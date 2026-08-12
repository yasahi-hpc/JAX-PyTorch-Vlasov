import argparse
import time
import resource
import jax
import jax.numpy as jnp
from functools import partial
import pathlib
import matplotlib.pyplot as plt
import xarray as xr
import numpy as np
from dataclasses import dataclass
from typing import Tuple, Any

def get_memory_stats(device=None):
    """
    Return allocator statistics for a JAX device via the public
    jax.Device.memory_stats() API (available on GPU/TPU PJRT backends).

    Returns None if the backend does not expose allocator statistics
    (e.g. the CPU backend).
    """
    if device is None:
        device = jax.local_devices()[0]
    return device.memory_stats()

def get_host_peak_rss():
    """Peak resident set size of this process in bytes (Linux: ru_maxrss is KiB)."""
    return resource.getrusage(resource.RUSAGE_SELF).ru_maxrss * 1024

def get_compiled_memory_analysis(jitted_fn, *args):
    """
    Static, compiler-reported memory requirements of a jitted function
    (AOT lowering; hits the JIT cache if already compiled for these shapes).

    Returns None if the backend does not implement memory_analysis().
    """
    try:
        return jitted_fn.lower(*args).compile().memory_analysis()
    except Exception:
        return None

def format_memory(num_bytes):
    return f"{num_bytes / 1024**2:.2f} MiB"

@jax.tree_util.register_pytree_node_class
@dataclass(frozen=True)
class Grid:
    """
    Immutable phase-space grid definition.
    Static parameters (Nx, Nv, etc.) are stored as 'auxiliary' data in the Pytree.
    Coordinate arrays (x, v) are stored as 'children' (JAX arrays).

    Attributes
    ----------
    Nx, Ny : int
        Number of grid points in spatial dimensions.
    Nvx, Nvy : int
        Number of grid points in velocity dimensions.
    Lx, Ly : float
        Domain length in spatial dimensions.
    Vx_max, Vy_max : float
        Maximum velocity in velocity dimensions.
    dx, dy : float
        Grid spacing in spatial dimensions.
    dvx, dvy : float
        Grid spacing in velocity dimensions.
    x : jnp.ndarray
        Spatial grid points in x. Shape: (Nx,)
    y : jnp.ndarray
        Spatial grid points in y. Shape: (Ny,)
    vx : jnp.ndarray
        Velocity grid points in vx. Shape: (Nvx,)
    vy : jnp.ndarray
        Velocity grid points in vy. Shape: (Nvy,)
    kx : jnp.ndarray
        Wave numbers in x. Shape: (Nx, 1)
    ky : jnp.ndarray
        Wave numbers in y (real FFT). Shape: (1, Ny//2 + 1)
    inv_ksq : jnp.ndarray
        Inverse squared wave numbers (1/k^2). Shape: (Nx, Ny//2 + 1)
    stencil_offsets : jnp.ndarray
        Interpolation stencil offsets with shape ``(6,)``.
    """
    Nx: int
    Ny: int
    Nvx: int
    Nvy: int
    Lx: float
    Ly: float
    Vx_max: float
    Vy_max: float
    dx: float
    dy: float
    dvx: float
    dvy: float
    x: jnp.ndarray
    y: jnp.ndarray
    vx: jnp.ndarray
    vy: jnp.ndarray
    kx: jnp.ndarray
    ky: jnp.ndarray
    inv_ksq: jnp.ndarray
    stencil_offsets: jnp.ndarray

    @classmethod
    def create(
        cls,
        Nx: int,
        Ny: int,
        Nvx: int,
        Nvy: int,
        Lx: float,
        Ly: float,
        Vx_max: float,
        Vy_max: float,
        dtype=jnp.float32,
    ) -> "Grid":
        dx, dy = Lx / Nx, Ly / Ny
        dvx, dvy = 2 * Vx_max / (Nvx - 1), 2 * Vy_max / (Nvy - 1)
        x = jnp.linspace(0, Lx, Nx, endpoint=False, dtype=dtype)
        y = jnp.linspace(0, Ly, Ny, endpoint=False, dtype=dtype)
        vx = jnp.linspace(-Vx_max, Vx_max, Nvx, endpoint=True, dtype=dtype)
        vy = jnp.linspace(-Vy_max, Vy_max, Nvy, endpoint=True, dtype=dtype)
        kx = (2 * jnp.pi * jnp.fft.fftfreq(Nx, d=dx)[:, None]).astype(dtype)
        ky = (2 * jnp.pi * jnp.fft.rfftfreq(Ny, d=dy)[None, :]).astype(dtype)

        k_sq = kx**2 + ky**2
        inv_ksq = jnp.where(k_sq == 0, 0.0, 1.0 / k_sq).astype(dtype)
        stencil_offsets = jnp.arange(-2, 4, dtype=jnp.int32)
        return cls(
            Nx,
            Ny,
            Nvx,
            Nvy,
            Lx,
            Ly,
            Vx_max,
            Vy_max,
            dx,
            dy,
            dvx,
            dvy,
            x,
            y,
            vx,
            vy,
            kx,
            ky,
            inv_ksq,
            stencil_offsets,
        )

    # -- Pytree Methods --
    def tree_flatten(self) -> Tuple[Tuple[Any, ...], Tuple[Any, ...]]:
        # Children (dynamic JAX arrays), Auxiliary (static python values)
        children = (
            self.x,
            self.y,
            self.vx,
            self.vy,
            self.kx,
            self.ky,
            self.inv_ksq,
            self.stencil_offsets,
        )
        aux_data = (self.Nx, self.Ny, self.Nvx, self.Nvy, self.Lx, self.Ly, self.Vx_max, self.Vy_max, self.dx, self.dy, self.dvx, self.dvy)
        return children, aux_data

    @classmethod
    def tree_unflatten(
        cls,
        aux_data: Tuple[int, int, int, int, float, float, float, float, float, float, float, float],
        children: Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray, jnp.ndarray, jnp.ndarray, jnp.ndarray, jnp.ndarray, jnp.ndarray],
    ) -> "Grid":
        return cls(*aux_data, *children)

@jax.tree_util.register_pytree_node_class
@dataclass
class Field:
    """
    Holds the field data (e.g., rho, phi)

    Parameters
    ----------
    rho : jnp.ndarray
        Charge density rho(x,y) with shape ``(Nx, Ny)``.
    phi : jnp.ndarray
        Electric potential phi(x,y) with shape ``(Nx, Ny)``.
    """
    rho: jnp.ndarray
    phi: jnp.ndarray

    # -- Pytree Methods --
    def tree_flatten(self) -> Tuple[Tuple[jnp.ndarray, jnp.ndarray], None]:
        # Children (dynamic JAX arrays)
        children = (self.rho, self.phi)
        return children, None

    @classmethod
    def tree_unflatten(
        cls,
        aux_data: None,
        children: Tuple[jnp.ndarray, jnp.ndarray],
    ) -> "Field":
        return cls(*children)

@jax.tree_util.register_pytree_node_class
@dataclass
class Variables:
    """
    Holds the physical field data (e.g., distribution function f).

    Parameters
    ----------
    fn : jnp.ndarray
        Distribution function f(x,y,vx,vy) with shape ``(Nx, Ny, Nvx, Nvy)``.
    f0 : jnp.ndarray
        Equilibrium distribution function f0(vx,vy) with shape ``(Nvx, Nvy)``.
    """
    fn: jnp.ndarray
    f0: jnp.ndarray

    # -- Pytree Methods --
    def tree_flatten(self) -> Tuple[Tuple[jnp.ndarray, jnp.ndarray], None]:
        return (self.fn, self.f0), None

    @classmethod
    def tree_unflatten(
        cls,
        aux_data: None,
        children: Tuple[jnp.ndarray, jnp.ndarray],
    ) -> "Variables":
        return cls(*children)

@jax.tree_util.register_pytree_node_class
@dataclass
class SimulationState:
    """
    The state carried through the simulation loop.
    Contains the grid (constant) and the field (evolving).

    Parameters
    ----------
    grid : Grid
        The simulation grid (constant).
    field : Field
        The simulation field.
    variables : Variables
        The simulation variables.
    t : float
        The current simulation time.
    step : int
        The current simulation step.
    """
    grid: Grid
    field: Field
    variables: Variables
    t: float
    step: int

    # -- Pytree Methods --
    def tree_flatten(self) -> Tuple[Tuple[Grid, Field, Variables, float, int], None]:
        children = (self.grid, self.field, self.variables, self.t, self.step)
        return children, None

    @classmethod
    def tree_unflatten(
        cls,
        aux_data: None,
        children: Tuple[Grid, Field, Variables, float, int]
    ) -> "SimulationState":
        return cls(*children)

def lagrange5_interp_sum(
    alpha: jnp.ndarray,
    f_vals: jnp.ndarray
) -> jnp.ndarray:
    """
    Evaluate a fifth-order Lagrange interpolation stencil.

    Parameters
    ----------
    alpha : jnp.ndarray
        Fractional departure coordinates with shape ``(batch_size, n_points)``.
    f_vals : jnp.ndarray
        Stencil values with shape ``(batch_size, n_points, 6)``.

    Returns
    -------
    jnp.ndarray
        Interpolated values with shape ``(batch_size, n_points)``.
    """
    a = alpha
    a2 = a * a
    a3 = a2 * a
    a4 = a3 * a
    a5 = a4 * a

    w0 = (a / 20.0) - (a2 / 24.0) - (a3 / 24.0) + (a4 / 24.0) - (a5 / 120.0)
    w1 = -(a / 2.0) + (2.0 * a2 / 3.0) - (a3 / 24.0) - (a4 / 6.0) + (a5 / 24.0)
    w2 = 1.0 - (a / 3.0) - (5.0 * a2 / 4.0) + (5.0 * a3 / 12.0) + (a4 / 4.0) - (a5 / 12.0)
    w3 = a + (2.0 * a2 / 3.0) - (7.0 * a3 / 12.0) - (a4 / 6.0) + (a5 / 12.0)
    w4 = -(a / 4.0) - (a2 / 24.0) + (7.0 * a3 / 24.0) + (a4 / 24.0) - (a5 / 24.0)
    w5 = (a / 30.0) - (a3 / 24.0) + (a5 / 120.0)

    return (
        w0 * f_vals[:, :, 0]
        + w1 * f_vals[:, :, 1]
        + w2 * f_vals[:, :, 2]
        + w3 * f_vals[:, :, 3]
        + w4 * f_vals[:, :, 4]
        + w5 * f_vals[:, :, 5]
    )

def lagrange5_weights(
    alpha: jnp.ndarray
) -> jnp.ndarray:
    """
    Evaluate a fifth-order Lagrange weights

    Parameters
    ----------
    alpha : jnp.ndarray
        Fractional departure coordinates with shape ``(batch_size, n_points)``.

    Returns
    -------
    jnp.ndarray
        Lagrange weights with shape ``(6, batch_size, n_points)``.
    """
    a = alpha
    a2 = a * a
    a3 = a2 * a
    a4 = a3 * a
    a5 = a4 * a

    w0 = (a / 20.0) - (a2 / 24.0) - (a3 / 24.0) + (a4 / 24.0) - (a5 / 120.0)
    w1 = -(a / 2.0) + (2.0 * a2 / 3.0) - (a3 / 24.0) - (a4 / 6.0) + (a5 / 24.0)
    w2 = 1.0 - (a / 3.0) - (5.0 * a2 / 4.0) + (5.0 * a3 / 12.0) + (a4 / 4.0) - (a5 / 12.0)
    w3 = a + (2.0 * a2 / 3.0) - (7.0 * a3 / 12.0) - (a4 / 6.0) + (a5 / 12.0)
    w4 = -(a / 4.0) - (a2 / 24.0) + (7.0 * a3 / 24.0) + (a4 / 24.0) - (a5 / 24.0)
    w5 = (a / 30.0) - (a3 / 24.0) + (a5 / 120.0)

    return jnp.stack([w0, w1, w2, w3, w4, w5], axis=0)

@partial(jax.jit, static_argnums=(5,))
def advect_1d_vectorized(
    f_batch: jnp.ndarray,
    velocities: jnp.ndarray,
    dt: float,
    dx: float,
    stencil_offsets: jnp.ndarray,
    periodic: bool = True
) -> jnp.ndarray:
    """Batched 1D advection using flat indexing and vectorized Lagrange weights.

    Parameters
    ----------
    f_batch : jnp.ndarray
        Distribution slices. Shape: [batch_size, n_points]
    velocities : jnp.ndarray
        Velocity per batch element. Shape: [batch_size] or [batch_size, n_points]
    dt : float
        Time step.
    dx : float
        Grid spacing.
    periodic : bool
        If True, periodic BC; if False, Dirichlet (zero outside).

    Returns
    -------
    jnp.ndarray
        Advected distribution. Shape: [batch_size, n_points]
    """
    batch_size, n_points = f_batch.shape
    grid_indices = jnp.arange(n_points, dtype=f_batch.dtype)

    # displacement in index units
    v_eff = velocities[:, None] if velocities.ndim == 1 else velocities
    displacement_idx = (v_eff * dt) / dx
    depart_idx = grid_indices[None, :] - displacement_idx

    idx_left = jnp.floor(depart_idx)
    alpha = depart_idx - idx_left
    idx_left = idx_left.astype(jnp.int32)

    stencil_indices = idx_left[:, :, None] + stencil_offsets[None, None, :]

    if periodic:
        stencil_indices = jnp.mod(stencil_indices, n_points)
        # Flat gather
        batch_ids = jnp.arange(batch_size)[:, None, None]
        flat_indices = batch_ids * n_points + stencil_indices
        f_vals = f_batch.ravel()[flat_indices.ravel()].reshape(batch_size, n_points, 6)
    else:
        valid_mask = (stencil_indices >= 0) & (stencil_indices < n_points)
        safe_indices = jnp.clip(stencil_indices, 0, n_points - 1)
        batch_ids = jnp.arange(batch_size)[:, None, None]
        flat_indices = batch_ids * n_points + safe_indices
        f_vals = f_batch.ravel()[flat_indices.ravel()].reshape(batch_size, n_points, 6)
        f_vals = jnp.where(valid_mask, f_vals, 0.0)

    return lagrange5_interp_sum(alpha, f_vals)

@partial(jax.jit, static_argnums=(3,))
def build_v_diag_weights(
    stencil_offsets: jnp.ndarray,
    shifts: jnp.ndarray,
    alpha: jnp.ndarray,
    n_points: int,
) -> jnp.ndarray:
    """
    Build a diagonal weight matrix for Lagrange interpolation.

    Parameters
    ----------
    stencil_offsets : jnp.ndarray
        Interpolation stencil offsets with shape ``(6,)``.
    shifts : jnp.ndarray
        Stencil shifts with shape ``(Nx,)``.
    alpha : jnp.ndarray
        Fractional departure coordinates with shape ``(Nx,)``.
    Nv : int
        Number of grid points.

    Returns
    -------
    jnp.ndarray
        Diagonal weight matrix with shape ``(Nx, 6, Nv)``.
    """
    W = lagrange5_weights(alpha)
    v = jnp.arange(n_points)
    total_shifts = stencil_offsets[:, None] + shifts[None, :]

    source_idx = v[None, None, :] - total_shifts[:, :, None]

    valid = (source_idx >= 0) & (source_idx < n_points)
    diag_weights = jnp.where(valid, W[:, :, None], 0.0)
    return diag_weights

@partial(jax.jit, static_argnums=(5,))
def advect_1d_roll_diag(
    f_batch: jnp.ndarray,
    velocities: jnp.ndarray,
    dt: float,
    dx: float,
    stencil_offsets: jnp.ndarray,
    periodic: bool = True
) -> jnp.ndarray:
    """Batched 1D advection using flat indexing and vectorized Lagrange weights.

    Parameters
    ----------
    f_batch : jnp.ndarray
        Distribution slices. Shape: [batch_size, n_points]
    velocities : jnp.ndarray
        Velocity per batch element. Shape: [batch_size] or [batch_size, n_points]
    dt : float
        Time step.
    dx : float
        Grid spacing.
    periodic : bool
        If True, periodic BC; if False, Dirichlet (zero outside).

    Returns
    -------
    jnp.ndarray
        Advected distribution. Shape: [batch_size, n_points]
    """
    batch_size, n_points = f_batch.shape
    displacement_idx = velocities * dt / dx

    idx_left = jnp.floor(displacement_idx)
    alpha = displacement_idx - idx_left
    idx_left = idx_left.astype(jnp.int32)

    result = jnp.zeros_like(f_batch)
    if periodic:
        W = lagrange5_weights(alpha)
        for k in range(6):
            shifts = idx_left + stencil_offsets[k]
            shifted = jax.vmap(
                jnp.roll,
                in_axes=(0, 0),
                out_axes=0,
            )(f_batch, shifts)
            result = result + shifted * W[k][:, None]
    else:
        diag_weights = build_v_diag_weights(stencil_offsets, idx_left, alpha, n_points)
        for k in range(6):
            shifts = idx_left + stencil_offsets[k]
            shifted = jax.vmap(
                jnp.roll,
                in_axes=(0, 0),
                out_axes=0,
            )(f_batch, shifts)

            result = result + diag_weights[k] * shifted
    return result

def advect_1d(
    f_data: jnp.ndarray,
    velocities: jnp.ndarray,
    axis: int,
    dt: float,
    dx: float,
    stencil_offsets: jnp.ndarray,
    periodic: bool = True
) -> jnp.ndarray:
    """High-level 1D advection for a 4D distribution function f(x, y, vx, vy).

    Moves the target *axis* to the last position, flattens all other
    dimensions into a batch, and delegates to advect_1d_vectorized.

    Parameters
    ----------
    f_data : jnp.ndarray
        Distribution function.  Shape: (Nx, Ny, Nvx, Nvy)
    velocities : jnp.ndarray
        Velocity field, broadcastable to the batch shape
        (all dims except the target axis).
    axis : int
        Axis along which to advect (0=x, 1=y, 2=vx, 3=vy).
    dt : float
        Time step.
    dx : float
        Grid spacing along the advection axis.
    periodic : bool
        If True, periodic BC; if False, Dirichlet (zero outside).

    Returns
    -------
    jnp.ndarray
        Advected distribution function, same shape as f_data.
    """
    # Move target axis to last position
    ndim = f_data.ndim
    perm = list(range(ndim))
    perm.append(perm.pop(axis))
    f_data = jnp.transpose(f_data, perm)  # [..., N_target]

    # Flatten batch dims -> [N_batch, N_target]
    f_shape = f_data.shape
    batch_shape = f_data.shape[:-1]
    n_target = f_data.shape[-1]
    f_data = f_data.reshape(-1, n_target)

    # Broadcast velocities to batch shape, then flatten
    vel_flat = jnp.broadcast_to(velocities, batch_shape).ravel()

    # Vectorized advection
    f_data = advect_1d_vectorized(f_data, vel_flat, dt, dx, stencil_offsets, periodic)

    # Reshape and inverse transpose
    f_data = f_data.reshape(f_shape)
    inv_perm = [0] * ndim
    for i, p in enumerate(perm):
        inv_perm[p] = i
    return jnp.transpose(f_data, inv_perm)

def advect_1d_matrix_diag(
    f_data: jnp.ndarray,
    velocities: jnp.ndarray,
    axis: int,
    dt: float,
    dx: float,
    stencil_offsets: jnp.ndarray,
    periodic: bool = True
) -> jnp.ndarray:
    """High-level 1D advection for a 4D distribution function f(x, y, vx, vy).

    Moves the target *axis* to the last position, flattens all other
    dimensions into a batch, and delegates to advect_1d_vectorized.

    Parameters
    ----------
    f_data : jnp.ndarray
        Distribution function.  Shape: (Nx, Ny, Nvx, Nvy)
    velocities : jnp.ndarray
        Velocity field, broadcastable to the batch shape
        (all dims except the target axis).
    axis : int
        Axis along which to advect (0=x, 1=y, 2=vx, 3=vy).
    dt : float
        Time step.
    dx : float
        Grid spacing along the advection axis.
    periodic : bool
        If True, periodic BC; if False, Dirichlet (zero outside).

    Returns
    -------
    jnp.ndarray
        Advected distribution function, same shape as f_data.
    """
    # Move target axis to last position
    ndim = f_data.ndim
    perm = list(range(ndim))
    perm.append(perm.pop(axis))
    f_data = jnp.transpose(f_data, perm)  # [..., N_target]

    # Flatten batch dims -> [N_batch, N_target]
    f_shape = f_data.shape
    batch_shape = f_shape[:-1]
    n_target = f_shape[-1]
    f_data = f_data.reshape(-1, n_target)

    # Broadcast velocities to batch shape, then flatten
    vel_flat = jnp.broadcast_to(velocities, batch_shape).ravel()

    # Vectorized advection
    f_data = advect_1d_roll_diag(f_data, vel_flat, dt, dx, stencil_offsets, periodic)

    # Reshape and inverse transpose
    f_data = f_data.reshape(f_shape)
    inv_perm = [0] * ndim
    for i, p in enumerate(perm):
        inv_perm[p] = i
    return jnp.transpose(f_data, inv_perm)

def static_stencil_offsets(
    stencil_offsets: jnp.ndarray
) -> Tuple[int, ...]:
    """
    Convert stencil offsets to static Python ints for the gather-free kernels.

    Static rolls and slices require concrete shift values, so
    ``stencil_offsets`` must be a concrete array here (it is: the kernels
    only ever receive it as a closed-over constant, never as a traced
    argument).

    Parameters
    ----------
    stencil_offsets : jnp.ndarray
        Interpolation stencil offsets with shape ``(6,)``.

    Returns
    -------
    Tuple[int, ...]
        The offsets as Python ints.
    """
    return tuple(int(o) for o in np.asarray(stencil_offsets))

def precompute_x_drift(
    v: jnp.ndarray,
    dt: float,
    dx: float,
    dtype: Any,
) -> Tuple[list, jnp.ndarray]:
    """
    Split the per-velocity shift of a periodic spatial drift into static data.

    The drift displacement ``d_j = v_j * dt / dx`` is time-constant, so its
    integer part ``s_j = floor(d_j)`` and fractional part ``alpha_j`` are
    compile-time constants. Because ``v`` is monotonic, velocity indices with
    equal ``s_j`` form contiguous blocks. Displacement is computed with the
    same dtype and operation order as the reference kernels so integer shifts
    and weights match bit-for-bit.

    Parameters
    ----------
    v : jnp.ndarray
        Velocity coordinates (``vx`` or ``vy``) with shape ``(Nv,)``.
    dt : float
        Time step of this advection (the Strang half step ``dt/2``).
    dx : float
        Spatial grid spacing along the drift axis.
    dtype : str or dtype
        Array dtype used by the simulation (``float32`` or ``float64``).

    Returns
    -------
    blocks : list of tuple(int, int, int)
        Static velocity-index blocks ``(start, stop, shift)`` with
        Python-int shifts.
    W : jnp.ndarray
        Lagrange weights of the fractional displacements with shape
        ``(6, Nv)`` (tap ``k`` corresponds to ``Grid.stencil_offsets[k]``).
    """
    np_dtype = np.dtype(dtype)
    v_np = np.asarray(v, dtype=np_dtype)
    d = (v_np * np_dtype.type(dt)) / np_dtype.type(dx)
    s = np.floor(d)
    alpha = d - s
    s = s.astype(np.int64)

    edges = np.flatnonzero(np.diff(s)) + 1
    starts = np.concatenate(([0], edges))
    stops = np.concatenate((edges, [len(s)]))
    blocks = [(int(a), int(b), int(s[a])) for a, b in zip(starts, stops)]

    W = lagrange5_weights(jnp.asarray(alpha, dtype=dtype))  # (6, Nv)
    return blocks, W

def block_roll(
    f_data: jnp.ndarray,
    blocks: list,
    axis: int,
    vel_axis: int,
) -> jnp.ndarray:
    """
    Roll each contiguous velocity block by its static shift along a spatial axis.

    Realizes the per-velocity integer shift ``C^{s_j}`` of a spatial drift
    with static slices and concatenation only (each ``jnp.roll`` with a
    Python-int shift lowers to two static slices plus a concatenate — no
    gather).

    Parameters
    ----------
    f_data : jnp.ndarray
        Distribution function with shape ``(Nx, Ny, Nvx, Nvy)``.
    blocks : list of tuple(int, int, int)
        Static velocity-index blocks ``(start, stop, shift)`` from
        ``precompute_x_drift``.
    axis : int
        Spatial axis to roll along (0=x, 1=y).
    vel_axis : int
        Velocity axis the blocks partition (2=vx for axis 0, 3=vy for axis 1).

    Returns
    -------
    jnp.ndarray
        Block-rolled distribution function, same shape as ``f_data``.
    """
    if all(shift % f_data.shape[axis] == 0 for _, _, shift in blocks):
        return f_data
    pieces = [
        jnp.roll(jax.lax.slice_in_dim(f_data, a, b, axis=vel_axis), shift, axis=axis)
        for a, b, shift in blocks
    ]
    return jnp.concatenate(pieces, axis=vel_axis) if len(pieces) > 1 else pieces[0]

def advect_x_static(
    f_data: jnp.ndarray,
    W: jnp.ndarray,
    blocks: list,
    stencil_offsets: jnp.ndarray,
    axis: int,
) -> jnp.ndarray:
    """
    Periodic X/Y drift as a block-static roll plus 6 static tap FMAs.

    Implements the per-velocity shifted 6-band circulant of the spatial
    drift with every shift static: the integer part is applied by
    ``block_roll`` and the remaining 6-tap Lagrange stencil by 6 static
    rolls shared by all velocities. No gather is emitted. Periodic BC only
    (there is no ``periodic`` argument).

    Parameters
    ----------
    f_data : jnp.ndarray
        Distribution function with shape ``(Nx, Ny, Nvx, Nvy)``.
    W : jnp.ndarray
        Precomputed Lagrange weights with shape ``(6, Nvx)`` for axis 0 or
        ``(6, Nvy)`` for axis 1 (from ``precompute_x_drift``).
    blocks : list of tuple(int, int, int)
        Static velocity-index blocks from ``precompute_x_drift``.
    stencil_offsets : jnp.ndarray
        Interpolation stencil offsets with shape ``(6,)`` (must be
        concrete; see ``static_stencil_offsets``).
    axis : int
        Spatial axis to advect along (0=x with velocity vx, 1=y with vy).

    Returns
    -------
    jnp.ndarray
        Advected distribution function, same shape as ``f_data``.
    """
    vel_axis = axis + 2
    w_shape = [1, 1, 1, 1]
    w_shape[vel_axis] = W.shape[1]

    f2 = block_roll(f_data, blocks, axis, vel_axis)
    out = jnp.zeros_like(f_data)
    for k, o in enumerate(static_stencil_offsets(stencil_offsets)):
        out = out + jnp.roll(f2, o, axis=axis) * W[k].reshape(w_shape)
    return out

def build_v_tap_weights(
    E: jnp.ndarray,
    dt: float,
    dv: float,
    S: int,
    stencil_offsets: jnp.ndarray,
) -> jnp.ndarray:
    """
    Collapse (integer shift, stencil tap) onto the static V-kick window.

    With ``d = E * dt / dv``, ``s = floor(d)`` and Lagrange weights
    ``w_k(alpha)``, the tap index ``m = s + o_k`` stays inside the static
    window ``[-S-2, S+2]`` whenever ``-S <= d < S``. The per-point weights
    are accumulated onto that window.

    Parameters
    ----------
    E : jnp.ndarray
        Electric field (advection velocity per spatial point) with shape
        ``(Nx, Ny)``.
    dt : float
        Time step of the kick.
    dv : float
        Velocity grid spacing.
    S : int
        Static window bound; the result is exact while ``|E*dt/dv| < S``.
    stencil_offsets : jnp.ndarray
        Interpolation stencil offsets with shape ``(6,)`` (must be
        concrete; see ``static_stencil_offsets``).

    Returns
    -------
    jnp.ndarray
        Tap weight matrix with shape ``(2S+5, Nx, Ny)``, taps ordered by
        ascending ``m`` in ``[-S-2, S+2]``.
    """
    d = (E * dt) / dv
    s = jnp.floor(d)
    alpha = d - s
    s = s.astype(jnp.int32)
    W6 = lagrange5_weights(alpha)  # (6, Nx, Ny)

    taps = range(-(S + 2), S + 3)  # m in [-S-2, S+2]
    rows = []
    for m in taps:
        acc = jnp.zeros_like(alpha)
        for k, o in enumerate(static_stencil_offsets(stencil_offsets)):
            acc = acc + jnp.where(s == m - o, W6[k], 0.0)
        rows.append(acc)
    return jnp.stack(rows, axis=0)  # (2S+5, Nx, Ny)

def advect_v_static(
    f_data: jnp.ndarray,
    E: jnp.ndarray,
    dt: float,
    dv: float,
    S: int,
    stencil_offsets: jnp.ndarray,
    axis: int,
) -> jnp.ndarray:
    """
    Dirichlet Vx/Vy kick as 2S+5 static shifted FMAs on a zero-padded array.

    Applies the per-spatial-point banded operator with every tap a static
    slice of the zero-padded array (zero padding realizes the Dirichlet
    boundary condition exactly), so no gather is emitted. Dirichlet BC only
    (there is no ``periodic`` argument).

    Parameters
    ----------
    f_data : jnp.ndarray
        Distribution function with shape ``(Nx, Ny, Nvx, Nvy)``.
    E : jnp.ndarray
        Electric field component (``Ex`` or ``Ey``) with shape ``(Nx, Ny)``.
    dt : float
        Time step of the kick.
    dv : float
        Velocity grid spacing along the kick axis.
    S : int
        Static window bound (see ``build_v_tap_weights``).
    stencil_offsets : jnp.ndarray
        Interpolation stencil offsets with shape ``(6,)`` (must be
        concrete; see ``static_stencil_offsets``).
    axis : int
        Velocity axis to advect along (2=vx with Ex, 3=vy with Ey).

    Returns
    -------
    jnp.ndarray
        Advected distribution function, same shape as ``f_data``.
    """
    Wt = build_v_tap_weights(E, dt, dv, S, stencil_offsets)
    P = S + 2
    n_points = f_data.shape[axis]
    pad_width = [(0, 0)] * f_data.ndim
    pad_width[axis] = (P, P)
    g = jnp.pad(f_data, pad_width)  # zero padding == Dirichlet BC
    out = jnp.zeros_like(f_data)
    for q, m in enumerate(range(-P, P + 1)):
        sliced = jax.lax.slice_in_dim(g, P - m, P - m + n_points, axis=axis)
        out = out + Wt[q][:, :, None, None] * sliced
    return out

def check_v_window(
    E: jnp.ndarray,
    dt: float,
    dv: float,
    S: int,
) -> float:
    """
    Return the maximum kick displacement ``max |E*dt/dv|`` in cells.

    The static tap window of the V kick is exact only while this value stays
    below ``S``; call this per chunk in production to guard the assumption.

    Parameters
    ----------
    E : jnp.ndarray
        Electric field component with shape ``(Nx, Ny)``.
    dt : float
        Time step of the kick.
    dv : float
        Velocity grid spacing.
    S : int
        Static window bound (unused in the computation; kept in the
        signature so call sites document what the value is compared to).

    Returns
    -------
    float
        Maximum absolute displacement in grid cells.
    """
    return float(jnp.max(jnp.abs(E * dt / dv)))

def compute_rho(
    f_data: jnp.ndarray,
    dvx: float,
    dvy: float
) -> jnp.ndarray:
    """
    Computes charge density rho(x,y) by integrating f over velocity space.
    Parameters
    ----------
    f_data : jnp.ndarray
        Distribution function f(x,y,vx,vy)
    dvx : float
        Velocity grid spacing in x.
    dvy : float
        Velocity grid spacing in y.

    Returns
    -------
    jnp.ndarray
        Charge density rho(x,y)
    """
    rho = jnp.sum(f_data, axis=(2, 3)) * dvx * dvy
    return rho

def compute_poisson(
    rho: jnp.ndarray,
    kx: jnp.ndarray,
    ky: jnp.ndarray,
    inv_ksq: jnp.ndarray
) -> Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray, jnp.ndarray]:
    """
    Solves Poisson's equation in Fourier space to get potential phi from charge density rho.
    Parameters
    ----------
    rho : jnp.ndarray
        Charge density rho(x,y)
    kx : jnp.ndarray
        Fourier modes in x.
    ky : jnp.ndarray
        Fourier modes in y.
    inv_ksq : jnp.ndarray
        Precomputed 1/k^2 array for Fourier modes.

    Returns
    -------
    jnp.ndarray
        Electric potential phi(x,y)
    """
    delta_rho = rho - 1
    rho_k = jnp.fft.rfft2(delta_rho)

    # Phi_k = rho_k / k^2
    phi_k = rho_k * inv_ksq
    phi = jnp.fft.irfft2(phi_k)

    # Ex_k = -i * kx * phi_k
    Ex_k = -1j * kx * phi_k
    Ey_k = -1j * ky * phi_k

    Ex = jnp.fft.irfft2(Ex_k)
    Ey = jnp.fft.irfft2(Ey_k)

    return Ex, Ey, delta_rho, phi

@jax.jit
def solve_poisson(
    f_data: jnp.ndarray,
    kx: jnp.ndarray,
    ky: jnp.ndarray,
    inv_ksq: jnp.ndarray,
    dvx: float,
    dvy: float
) -> Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray, jnp.ndarray]:
    """Solves Poisson's equation -> E(x, y)
    \nabla^2 phi = -rho
    -k^2 phi_k = -rho_k
    => phi_k = rho_k / k^2

    Ex = -dphi/dx, Ey = -dphi/dy
    Ex_k = -1j * kx * phi_k, Ey_k = -1j * ky * phi_k

    Parameters
    ----------
    f_data : jnp.ndarray
        Distribution function f(x,v)
    kx : jnp.ndarray
        Fourier modes in x.
    ky : jnp.ndarray
        Fourier modes in y.
    inv_ksq : jnp.ndarray
        Precomputed 1/k^2 array for Fourier modes.
    dvx : float
        Velocity grid spacing in x.
    dvy : float
        Velocity grid spacing in y.

    Returns
    -------
    Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray, jnp.ndarray]
        Tuple containing (Ex, Ey, delta_rho, phi) where:
        - Ex: x component of Electric field Ex(x, y)
        - Ey: y component of Electric field Ey(x, y)
        - delta_rho: Charge density deviation from mean delta_rho(x, y)
        - phi: Electric potential phi(x, y)
    """
    rho = compute_rho(f_data, dvx, dvy)
    Ex, Ey, delta_rho, phi = compute_poisson(rho, kx, ky, inv_ksq)

    return Ex, Ey, delta_rho, phi

def vlasov_step(
    carry: Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray],
    g: Grid,
    dt: float,
    physics_mode: bool
) -> Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]:
    """Performs one time step of Vlasov-Poisson using Strang splitting.

    Parameters
    ----------
    carry : Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]
        Tuple containing (f, rho, phi) where:
        - f: distribution function f(x,y,vx,vy)
        - rho: charge density rho(x,y)
        - phi: electric potential phi(x,y)
    g : Grid
        Grid object containing spatial and velocity grids.
    dt : float
        Time step size.
    physics_mode : bool
        Whether to solve Poisson's equation or not.

    Returns
    -------
    Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]
        Updated (f, rho, phi) after one time step.
    """
    f, _, _ = carry

    # Advect along X, Y (dt/2)
    # vx varies along axis 2 -> shape [1, Nvx, 1] broadcasts to batch (Ny, Nvx, Nvy)
    f = advect_1d(f, g.vx[None, :, None], 0, dt/2.0, g.dx, g.stencil_offsets, periodic=True)
    # vy varies along axis 3 -> shape [1, 1, Nvy] broadcasts to batch (Nx, Nvx, Nvy)
    f = advect_1d(f, g.vy[None, None, :], 1, dt/2.0, g.dy, g.stencil_offsets, periodic=True)

    # Solve Poisson's equation to get Ex, Ey, rho, phi
    if physics_mode:
        Ex, Ey, rho, phi = solve_poisson(f, g.kx, g.ky, g.inv_ksq, g.dvx, g.dvy)
    else:
        Ex = jnp.zeros((g.Nx, g.Ny), dtype=f.dtype)
        Ey = jnp.zeros((g.Nx, g.Ny), dtype=f.dtype)
        rho = jnp.zeros((g.Nx, g.Ny), dtype=f.dtype)
        phi = jnp.zeros((g.Nx, g.Ny), dtype=f.dtype)

    # Advect along Vx, Vy (dt)
    # Ex[Nx,Ny] -> shape [Nx, Ny, 1] broadcasts to batch (Nx, Ny, Nvy)
    f = advect_1d(f, Ex[:, :, None], 2, dt, g.dvx, g.stencil_offsets, periodic=False)
    # Ey[Nx,Ny] -> shape [Nx, Ny, 1] broadcasts to batch (Nx, Ny, Nvx)
    f = advect_1d(f, Ey[:, :, None], 3, dt, g.dvy, g.stencil_offsets, periodic=False)

    # Advect along X, Y (dt/2)
    f = advect_1d(f, g.vy[None, None, :], 1, dt/2.0, g.dy, g.stencil_offsets, periodic=True)
    f = advect_1d(f, g.vx[None, :, None], 0, dt/2.0, g.dx, g.stencil_offsets, periodic=True)

    return (f, rho, phi)

def vlasov_step_matrix_diag(
    carry: Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray],
    g: Grid,
    dt: float,
    physics_mode: bool
) -> Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]:
    """Performs one time step of Vlasov-Poisson using Strang splitting.

    Parameters
    ----------
    carry : Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]
        Tuple containing (f, rho, phi) where:
        - f: distribution function f(x,y,vx,vy)
        - rho: charge density rho(x,y)
        - phi: electric potential phi(x,y)
    g : Grid
        Grid object containing spatial and velocity grids.
    dt : float
        Time step size.
    physics_mode : bool
        Whether to solve Poisson's equation or not.

    Returns
    -------
    Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]
        Updated (f, rho, phi) after one time step.
    """
    f, _, _ = carry

    # Advect along X, Y (dt/2)
    # vx varies along axis 2 -> shape [1, Nvx, 1] broadcasts to batch (Ny, Nvx, Nvy)
    f = advect_1d_matrix_diag(f, g.vx[None, :, None], 0, dt/2.0, g.dx, g.stencil_offsets, periodic=True)
    # vy varies along axis 3 -> shape [1, 1, Nvy] broadcasts to batch (Nx, Nvx, Nvy)
    f = advect_1d_matrix_diag(f, g.vy[None, None, :], 1, dt/2.0, g.dy, g.stencil_offsets, periodic=True)

    # Solve Poisson's equation to get Ex, Ey, rho, phi
    if physics_mode:
        Ex, Ey, rho, phi = solve_poisson(f, g.kx, g.ky, g.inv_ksq, g.dvx, g.dvy)
    else:
        Ex = jnp.zeros((g.Nx, g.Ny), dtype=f.dtype)
        Ey = jnp.zeros((g.Nx, g.Ny), dtype=f.dtype)
        rho = jnp.zeros((g.Nx, g.Ny), dtype=f.dtype)
        phi = jnp.zeros((g.Nx, g.Ny), dtype=f.dtype)

    # Advect along Vx, Vy (dt)
    # Ex[Nx,Ny] -> shape [Nx, Ny, 1] broadcasts to batch (Nx, Ny, Nvy)
    f = advect_1d_matrix_diag(f, Ex[:, :, None], 2, dt, g.dvx, g.stencil_offsets, periodic=False)
    # Ey[Nx,Ny] -> shape [Nx, Ny, 1] broadcasts to batch (Nx, Ny, Nvx)
    f = advect_1d_matrix_diag(f, Ey[:, :, None], 3, dt, g.dvy, g.stencil_offsets, periodic=False)

    # Advect along X, Y (dt/2)
    f = advect_1d_matrix_diag(f, g.vy[None, None, :], 1, dt/2.0, g.dy, g.stencil_offsets, periodic=True)
    f = advect_1d_matrix_diag(f, g.vx[None, :, None], 0, dt/2.0, g.dx, g.stencil_offsets, periodic=True)

    return (f, rho, phi)

def vlasov_step_gather_free(
    carry: Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray],
    g: Grid,
    dt: float,
    physics_mode: bool,
    S: int = 1
) -> Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]:
    """Performs one time step of Vlasov-Poisson without any gather
    (no data-dependent memory access in the lowering; TPU-friendly).

    The X/Y-drift shifts are time-constant, so their integer parts are
    applied as static block rolls and the 6-tap Lagrange stencils as 6
    static rolls each (``advect_x_static``). The Vx/Vy kicks collapse
    (integer shift, stencil tap) onto a static window of ``2S+5`` shifted
    FMAs (``advect_v_static``), exact while ``|E*dt/dv| < S`` (see
    ``check_v_window``).

    Parameters
    ----------
    carry : Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]
        Tuple containing (f, rho, phi) where:
        - f: distribution function f(x,y,vx,vy)
        - rho: charge density rho(x,y)
        - phi: electric potential phi(x,y)
    g : Grid
        Grid object containing spatial and velocity grids.
    dt : float
        Time step size.
    physics_mode : bool
        Whether to solve Poisson's equation or not.
    S : int
        Static window bound of the V kicks; requires ``|E*dt/dv| < S``.

    Returns
    -------
    Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]
        Updated (f, rho, phi) after one time step.
    """
    f, _, _ = carry

    # Precomputed at trace time from the concrete g.vx/g.vy: static
    # Python-int shifts and constant weights (the drift displacements are
    # time-constant).
    blocks_x, W_x = precompute_x_drift(g.vx, dt/2.0, g.dx, g.x.dtype)
    blocks_y, W_y = precompute_x_drift(g.vy, dt/2.0, g.dy, g.x.dtype)

    # Advect along X, Y (dt/2)
    f = advect_x_static(f, W_x, blocks_x, g.stencil_offsets, axis=0)
    f = advect_x_static(f, W_y, blocks_y, g.stencil_offsets, axis=1)

    # Solve Poisson's equation to get Ex, Ey, rho, phi
    if physics_mode:
        Ex, Ey, rho, phi = solve_poisson(f, g.kx, g.ky, g.inv_ksq, g.dvx, g.dvy)
    else:
        Ex = jnp.zeros((g.Nx, g.Ny), dtype=f.dtype)
        Ey = jnp.zeros((g.Nx, g.Ny), dtype=f.dtype)
        rho = jnp.zeros((g.Nx, g.Ny), dtype=f.dtype)
        phi = jnp.zeros((g.Nx, g.Ny), dtype=f.dtype)

    # Advect along Vx, Vy (dt)
    f = advect_v_static(f, Ex, dt, g.dvx, S, g.stencil_offsets, axis=2)
    f = advect_v_static(f, Ey, dt, g.dvy, S, g.stencil_offsets, axis=3)

    # Advect along X, Y (dt/2)
    f = advect_x_static(f, W_y, blocks_y, g.stencil_offsets, axis=1)
    f = advect_x_static(f, W_x, blocks_x, g.stencil_offsets, axis=0)

    return (f, rho, phi)

class Vlasov:
    dt: float = 0.05
    diag_steps: int = 10
    out_dir: str = "data"
    physics_mode: bool = False
    epsilon: float = 0.001
    def __init__(
        self,
        Nx: int = 32,
        Ny: int = 32,
        Nvx: int = 32,
        Nvy: int = 32,
        Lx: float = 2.0*jnp.pi,
        Ly: float = 2.0*jnp.pi,
        Vx_max: float = 6.0,
        Vy_max: float = 6.0,
        nbiter: int = 10,
        diag_steps: int = 10,
        dt: float = 0.05,
        out_dir: str = "data",
        physics_mode: bool = False,
        epsilon: float = 0.001,
        solver: int = 0,
        dtype: str = 'float32'
    ) -> None:
        """
        Initializes the Vlasov solver with the given parameters.

        Parameters
        ----------
        Nx, Ny : int
            Number of spatial grid points.
        Nvx, Nvy : int
            Number of velocity grid points.
        Lx, Ly : float
            Physical domain length.
        Vx_max, Vy_max : float
            Maximum velocity.
        nbiter : int
            Number of iterations.
        diag_steps : int
            Number of steps between diagnostics.
        dt : float
            Time step size.
        out_dir : str
            Directory for output files.
        physics_mode : bool
            Whether to solve Poisson's equation.
        epsilon : float
            Perturbation amplitude.
        solver : int
            Type of solver to use
            0: standard
            1: matrix_diag
            2: gather_free
        dtype : str
            Data type for computations.
        """
        self.output_log = ""
        self.dtype = jnp.float64 if dtype == 'float64' else jnp.float32
        self.grid = Grid.create(Nx, Ny, Nvx, Nvy, Lx, Ly, Vx_max, Vy_max, dtype=dtype)
        self.nbiter = nbiter
        self.diag_steps = diag_steps
        self.dt = dt
        self.out_dir = out_dir
        self.physics_mode = physics_mode
        self.epsilon = epsilon

        solver_names = {
            0: 'vlasov_step',
            1: 'vlasov_step_matrix_diag',
            2: 'vlasov_step_gather_free',
        }
        self.solver_type = solver_names[solver]

        if not pathlib.Path(self.out_dir).exists():
            pathlib.Path(self.out_dir).mkdir(parents=True)

        self.num_steps = self.nbiter // self.diag_steps
        device = self.grid.x.device
        message  = f"Jax version: {jax.__version__}\n"
        message += f"Starting simulation on {device.device_kind} using {self.grid.x.dtype} precision "
        message += "with Poisson solver" if self.physics_mode else "without Poisson solver"
        message += f" and solver type {self.solver_type}."
        self._append_log(message)
        self._append_log(
            f"Grid: {self.grid.Nx}x{self.grid.Ny}x{self.grid.Nvx}x{self.grid.Nvy}, "
            f"Steps: {self.nbiter}, chunks: {self.num_steps}, diag_freq: {self.diag_steps}"
        )

        # Handle case where diag_steps > nbiter
        length = min(self.diag_steps, self.nbiter)
        if self.num_steps == 0:
            self._append_log(f"Running simulation without diagnostics (num_steps=0). Steps: {length}")

        # Define JIT-compiled Chunk Runner
        # This compiles a loop that runs 'diag_steps' iterations entirely on GPU/TPU
        # and returns ONLY the final state, discarding intermediate history.
        g = self.grid
        @jax.jit
        def run_chunk(start_state):
            def body_fn(_, carry):
                if solver == 0:
                    return vlasov_step(carry, g, self.dt, self.physics_mode)
                elif solver == 1:
                    return vlasov_step_matrix_diag(carry, g, self.dt, self.physics_mode)
                elif solver == 2:
                    return vlasov_step_gather_free(carry, g, self.dt, self.physics_mode)
                else:
                    raise NotImplementedError(f"Unknown solver type: {solver}")

            carry = (start_state.variables.fn, start_state.field.rho, start_state.field.phi)
            f_final, rho_final, phi_final = jax.lax.fori_loop(0, length, body_fn, carry)
            t = start_state.t + self.dt * length
            step = start_state.step + length

            final_chunk_state = SimulationState(
                grid=g,
                field=Field(rho_final, phi_final),
                variables=Variables(f_final, start_state.variables.f0),
                t=t,
                step=step
            )

            return final_chunk_state

        self._run_chunk = run_chunk

    def _append_log(
        self,
        message: str,
    ) -> None:
        """
        Appends a message to the simulation log.

        Parameters
        ----------
        message : str
            The message to append to the log.
        """
        self.output_log += f"{message}\n"

    def initialize(self):
        """
        Creates the initial SimulationState with a Gaussian pulse.

        Returns
        -------
        SimulationState
            The initial state of the simulation.
        """

        # Broadcasting for memory efficiency
        x_mesh = self.grid.x[:, None, None, None]
        y_mesh = self.grid.y[None, :, None, None]
        vx_mesh = self.grid.vx[:, None]
        vy_mesh = self.grid.vy[None, :]

        if self.physics_mode:
            # Landau damping settings
            kx = 1 * 2.0 * jnp.pi / self.grid.Lx
            ky = 1 * 2.0 * jnp.pi / self.grid.Ly
            energy = 0.5 * (vx_mesh**2 + vy_mesh**2)
            f0 = 1.0 / np.sqrt(2.0*jnp.pi) * jnp.exp(-energy)
            f_data = (1.0 + self.epsilon * jnp.cos(kx*x_mesh) * jnp.cos(ky*y_mesh)) * f0[None, None, :, :]
        else:
            # Gaussian pulse
            x0, y0 = self.grid.Lx / 2.0, self.grid.Ly / 2.0
            vx0, vy0 = 0.0, 0.0
            sigma_x, sigma_v = self.grid.Lx / 10.0, self.grid.Vx_max / 4.0
            dx2 = (x_mesh - x0)**2 / sigma_x**2
            dy2 = (y_mesh - y0)**2 / sigma_x**2
            vx2 = (vx_mesh[None, None, :, :] - vx0)**2 / sigma_v**2
            vy2 = (vy_mesh[None, None, :, :] - vy0)**2 / sigma_v**2
            f_data = jnp.exp(-0.5 * (dx2 + dy2 + vx2 + vy2))
            f0 = jnp.zeros((self.grid.Nvx, self.grid.Nvy), dtype=self.dtype)
        *_, rho, phi = solve_poisson(f_data, self.grid.kx, self.grid.ky, self.grid.inv_ksq, self.grid.dvx, self.grid.dvy)

        initial_state = SimulationState(
            grid=self.grid,
            field=Field(rho, phi),
            variables=Variables(f_data, f0),
            t=0.0,
            step=0
        )

        self._diag(initial_state)
        return initial_state

    def run(
        self,
        initial_state: SimulationState,
    ) -> None:
        """
        Runs the simulation using jax.lax.scan.

        Parameters
        ----------
        initial_state : SimulationState
            The initial state of the simulation to start from.
        """

        current_state = initial_state

        if self.num_steps == 0:
            # Suppress diagnostics and measure without profiler overhead
            current_state = self._run_chunk(current_state)
            current_state.variables.fn.block_until_ready()

        else:
            with jax.profiler.trace("./", create_perfetto_link=False, create_perfetto_trace=True):
                for _ in range(self.num_steps):
                    # Run the simulation on device
                    current_state = self._run_chunk(current_state)

                    # Jax waits for the computation to finish
                    # only when we try to copy data to host
                    self._diag(current_state)

                current_state.variables.fn.block_until_ready()

        return current_state

    def _diag(
        self,
        state: SimulationState
    ) -> None:
        """
        Make a snapshot of the state to a single file

        Parameters
        ----------
        state : SimulationState
            The current state of the simulation to save diagnostics for.
        """

        # Create Dataset for just this snapshot
        f, f0 = state.variables.fn, state.variables.f0
        rho, phi = state.field.rho, state.field.phi

        # Cast to numpy to separate from graph
        ds = xr.Dataset(
            data_vars = {
                "f": (("time", "x", "y", "vx", "vy"), np.array(f)[None, ...]),
                "f0": (("time", "vx", "vy"), np.array(f0[None, ...])),
                "rho": (("time", "x", "y"), np.array(rho)[None, ...]),
                "phi": (("time", "x", "y"), np.array(phi)[None, ...]),
            },
            coords = {
                "time": np.array([float(state.t)]),
                "x": np.array(state.grid.x),
                "y": np.array(state.grid.y),
                "vx": np.array(state.grid.vx),
                "vy": np.array(state.grid.vy),
            },
            attrs = {
                "step": int(state.step),
                "dt": self.dt,
                "Lx": self.grid.Lx,
                "Ly": self.grid.Ly,
                "Vx_max": self.grid.Vx_max,
                "Vy_max": self.grid.Vy_max,
                "physics_mode": int(self.physics_mode),
            }
        )

        # Save file: field_000010.nc
        outdir = pathlib.Path(self.out_dir)
        filename = outdir / f"field_{state.step:06d}.nc"
        ds.to_netcdf(filename)

def run_vlp2d2v(
    nx: int,
    ny: int,
    nvx: int,
    nvy: int,
    lx: float,
    ly: float,
    Vx_max: float,
    Vy_max: float,
    nbiter: int,
    diag_steps: int,
    dt: float,
    out_dir: str,
    physics_mode: bool,
    epsilon: float,
    solver_type: int,
    dtype: str,
):
    if dtype == 'float64':
        # Enable 64-bit floating point support in JAX
        jax.config.update("jax_enable_x64", True)

    # Initialize Solver
    solver = Vlasov(
        Nx=nx, Ny=ny, Nvx=nvx, Nvy=nvy,
        Lx=lx, Ly=ly, Vx_max=Vx_max, Vy_max=Vy_max,
        nbiter=nbiter, diag_steps=diag_steps,
        dt=dt,
        out_dir=out_dir,
        physics_mode=physics_mode, # Set False for validation, True for Physics
        epsilon=epsilon,
        solver=solver_type,
        dtype=dtype,
    )

    # Create Initial State
    initial_state = solver.initialize()

    # -- Jaxpr and stablehlo analysis ----------------------------------------------------
    g = solver.grid
    f0 = initial_state.variables.fn
    rho0 = initial_state.field.rho
    phi0 = initial_state.field.phi
    carry0 = (f0, rho0, phi0)

    # 1) Single Vlasov step → vlasov_step.txt
    jaxpr_dir = pathlib.Path("jaxpr_dump")
    jaxpr_dir.mkdir(parents=True, exist_ok=True)
    stablehlo_dir = pathlib.Path("hlo_dump")
    stablehlo_dir.mkdir(parents=True, exist_ok=True)

    step_jaxpr_path = jaxpr_dir / f"{solver.solver_type}.txt"

    solver_map = {
        0: vlasov_step,
        1: vlasov_step_matrix_diag,
        2: vlasov_step_gather_free,
    }
    step_fn = lambda carry: solver_map[solver_type](carry, g, solver.dt, solver.physics_mode)
    if not step_jaxpr_path.exists():
        jaxpr_step = jax.make_jaxpr(step_fn)(carry0)
        step_jaxpr_path.write_text(str(jaxpr_step))

    for dialect in ["hlo", "stablehlo"]:
        step_stablehlo_path = stablehlo_dir / f"{dialect}_{solver.solver_type}.mlir"
        if not step_stablehlo_path.exists():
            compiler_ir = jax.jit(step_fn).lower(carry0).compiler_ir(dialect=dialect)
            if dialect == "hlo":
                # Some backends may not support HLO; skip if not available
                try:
                    hlo_text = compiler_ir.as_hlo_text()
                    step_stablehlo_path.write_text(hlo_text)
                except Exception as e:
                    print(f"Skipping HLO dump for {solver.solver_type} due to error: {e}")
            else:
                # StableHLO is generally supported; write it to file
                step_stablehlo_path.write_text(str(compiler_ir))

    # 2) Full fori_loop chunk → vlasov_chunk.txt
    chunk_jaxpr_path = jaxpr_dir / f"{solver.solver_type}_chunk.txt"
    if not chunk_jaxpr_path.exists():
        jaxpr_chunk = jax.make_jaxpr(solver._run_chunk)(initial_state)
        chunk_jaxpr_path.write_text(str(jaxpr_chunk))

    for dialect in ["hlo", "stablehlo"]:
        chunk_stablehlo_path = stablehlo_dir / f"{dialect}_{solver.solver_type}_chunk.mlir"
        if not chunk_stablehlo_path.exists():
            compiler_ir = solver._run_chunk.lower(initial_state).compiler_ir(dialect=dialect)
            if dialect == "hlo":
                # Some backends may not support HLO; skip if not available
                try:
                    hlo_text = compiler_ir.as_hlo_text()
                    chunk_stablehlo_path.write_text(hlo_text)
                except Exception as e:
                    print(f"Skipping HLO dump for chunk {solver.solver_type} due to error: {e}")
            else:
                # StableHLO is generally supported; write it to file
                chunk_stablehlo_path.write_text(str(compiler_ir))

    # Warm-up JIT compilation
    solver._append_log("Warming up JIT compilation...")
    _ = solver.run(initial_state)
    solver._append_log("JIT compilation done. Starting timed run...")

    # Create Initial State
    initial_state = solver.initialize()

    # Wait for warm-up completion; async dispatch would otherwise let us
    # sample the allocator before the work (and its allocations) finished.
    initial_state.variables.fn.block_until_ready()

    # Measure memory before the main loop
    mem_before = get_memory_stats()

    # Static (compiler-reported) memory requirements of one chunk
    mem_analysis = get_compiled_memory_analysis(solver._run_chunk, initial_state)

    # Run
    start = time.time()
    state_final = solver.run(initial_state)
    seconds = time.time() - start

    solver._append_log(f"Elapsed time: {seconds} [s]")

    mem_after = get_memory_stats()

    solver._append_log("\nMemory statistics")
    if mem_before is not None and mem_after is not None:
        solver._append_log(f"Device memory before main loop : {format_memory(mem_before['bytes_in_use'])}")
        solver._append_log(f"Device memory after main loop  : {format_memory(mem_after['bytes_in_use'])}")
        solver._append_log(f"Device peak memory             : {format_memory(mem_after['peak_bytes_in_use'])}")
        if 'bytes_limit' in mem_after:
            solver._append_log(f"Device memory limit            : {format_memory(mem_after['bytes_limit'])}")
    else:
        solver._append_log("Device allocator stats unavailable on this backend (e.g. CPU).")
    solver._append_log(f"Host peak RSS                  : {format_memory(get_host_peak_rss())}")

    if mem_analysis is not None:
        solver._append_log("\nCompiled memory analysis (per chunk, compiler-reported)")
        solver._append_log(f"Argument size                  : {format_memory(mem_analysis.argument_size_in_bytes)}")
        solver._append_log(f"Output size                    : {format_memory(mem_analysis.output_size_in_bytes)}")
        solver._append_log(f"Temp size                      : {format_memory(mem_analysis.temp_size_in_bytes)}")
        # peak_memory_in_bytes is missing from CompiledMemoryStats on older jaxlib
        peak = getattr(mem_analysis, 'peak_memory_in_bytes', None)
        if peak is not None:
            solver._append_log(f"Peak memory                    : {format_memory(peak)}")

    output_path = pathlib.Path.cwd() / f"vlp2d_2v_{dtype}.txt"
    output_path.write_text(solver.output_log)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(add_help=True)
    parser.add_argument('-nx', nargs='?', type=int, default=32,
                        help="Number of grid points in each spatial dimension")
    parser.add_argument('-ny', nargs='?', type=int, default=32,
                        help="Number of grid points in each spatial dimension")
    parser.add_argument('-nvx', nargs='?', type=int, default=32,
                        help="Number of grid points in each velocity dimension")
    parser.add_argument('-nvy', nargs='?', type=int, default=32,
                        help="Number of grid points in each velocity dimension")
    parser.add_argument('-lx', nargs='?', type=float, default=4.0*jnp.pi,
                        help="Physical domain length in the x spatial direction")
    parser.add_argument('-ly', nargs='?', type=float, default=4.0*jnp.pi,
                        help="Physical domain length in the y spatial direction")
    parser.add_argument('-Vx_max', nargs='?', type=float, default=5.0,
                        help="Maximum velocity in x velocity dimension")
    parser.add_argument('-Vy_max', nargs='?', type=float, default=5.0,
                        help="Maximum velocity in y velocity dimension")
    parser.add_argument('-nbiter', nargs='?', type=int, default=10,
                        help="Total number of simulation iterations")
    parser.add_argument('-diag_steps', nargs='?', type=int, default=10,
                        help="Number of steps between diagnostics output")
    parser.add_argument('-dt', nargs='?', type=float, default=0.05,
                        help="Time step size for the integration scheme")
    parser.add_argument('-out_dir', nargs='?', type=str, default='data_python',
                        help="Directory where diagnostic output files will be saved")
    parser.add_argument('-physics_mode', action='store_true', default=False,
                        help='physics mode or not')
    parser.add_argument('-epsilon', nargs='?', type=float, default=0.001,
                        help="Amplitude of initial perturbation")
    parser.add_argument('-solver', nargs='?', type=int, default=0, choices=[0, 1, 2],
                        help="Solver type: 0=vlasov_step, 1=vlasov_matrix_diag, 2=vlasov_gather_free")
    parser.add_argument('-dtype', nargs='?', type=str, default='float32',
                        help="Data type for the simulation (float32 or float64)")
    args = parser.parse_args()

    run_vlp2d2v(
        nx=args.nx,
        ny=args.ny,
        nvx=args.nvx,
        nvy=args.nvy,
        lx=args.lx,
        ly=args.ly,
        Vx_max=args.Vx_max,
        Vy_max=args.Vy_max,
        nbiter=args.nbiter,
        diag_steps=args.diag_steps,
        dt=args.dt,
        out_dir=args.out_dir,
        physics_mode=args.physics_mode,
        epsilon=args.epsilon,
        solver_type=args.solver,
        dtype=args.dtype
    )
