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

    Parameters
    ----------
    Nx : int
        Number of spatial grid points.
    Nv : int
        Number of velocity grid points.
    L : float
        Spatial domain length.
    V_max : float
        Maximum velocity magnitude.
    dx : float
        Spatial grid spacing.
    dv : float
        Velocity grid spacing.
    x : jnp.ndarray
        Spatial coordinates with shape ``(Nx,)``.
    v : jnp.ndarray
        Velocity coordinates with shape ``(Nv,)``.
    inv_kx : jnp.ndarray
        Reciprocal Fourier wavenumbers with shape ``(Nx // 2 + 1,)``.
    stencil_offsets : jnp.ndarray
        Interpolation stencil offsets with shape ``(6,)``.
    """
    Nx: int
    Nv: int
    L: float
    V_max: float
    dx: float
    dv: float
    x: jnp.ndarray
    v: jnp.ndarray
    inv_kx: jnp.ndarray
    stencil_offsets: jnp.ndarray

    @classmethod
    def create(
        cls,
        Nx: int,
        Nv: int,
        L: float,
        V_max: float,
        dtype=jnp.float32
    ) -> "Grid":
        dx = L / Nx
        dv = 2 * V_max / (Nv - 1)
        x = jnp.linspace(0, L, Nx, endpoint=False, dtype=dtype)
        v = jnp.linspace(-V_max, V_max, Nv, endpoint=True, dtype=dtype)
        kx = 2 * jnp.pi * jnp.fft.rfftfreq(Nx, d=dx, dtype=dtype)
        inv_kx = jnp.where(kx == 0, 0.0, 1.0 / kx).astype(dtype)
        stencil_offsets = jnp.arange(-2, 4, dtype=jnp.int32)
        return cls(Nx, Nv, L, V_max, dx, dv, x, v, inv_kx, stencil_offsets)

    # -- Pytree Methods --
    def tree_flatten(self) -> Tuple[Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray, jnp.ndarray], Tuple[int, int, float, float, float, float]]:
        # Children(dynamic JAX arrays), Auxiliary(static python values)
        children = (self.x, self.v, self.inv_kx, self.stencil_offsets)
        aux_data = (self.Nx, self.Nv, self.L, self.V_max, self.dx, self.dv)
        return children, aux_data

    @classmethod
    def tree_unflatten(
        cls,
        aux_data: Tuple[int, int, float, float, float, float],
        children: Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray, jnp.ndarray],
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
        Charge density with shape ``(Nx,)``.
    phi : jnp.ndarray
        Electrostatic potential with shape ``(Nx,)``.
    """
    rho: jnp.ndarray
    phi: jnp.ndarray

    # -- Pytree Methods --
    def tree_flatten(self) -> Tuple[Tuple[jnp.ndarray, jnp.ndarray], None]:
        # Children(dynamic JAX arrays)
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
        Distribution function with shape ``(Nx, Nv)``.
    f0 : jnp.ndarray
        Equilibrium distribution function with shape ``(Nv)``.
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
        The simulation grid.
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
        aux_data = None
        return children, aux_data

    @classmethod
    def tree_unflatten(
        cls,
        aux_data: None,
        children: Tuple[Grid, Field, Variables, float, int],
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
    """Batched 1D advection using flat indexing

    Parameters
    ----------
    f_batch : jnp.ndarray
        Batch of distribution functions with shape ``(batch_size, n_points)``.
    velocities : jnp.ndarray
        Advection velocities with shape ``(batch_size,)`` or ``(batch_size, n_points)``.
    dt : float
        Time step size.
    dx : float
        Grid spacing in the advection direction.
    stencil_offsets : jnp.ndarray
        Interpolation stencil offsets with shape ``(6,)``.
    periodic : bool, optional
        Whether to apply periodic boundary conditions, by default True.

    Returns
    -------
    jnp.ndarray
        Advected distribution functions with shape ``(batch_size, n_points)``.

    Notes
    -----
    This routine never compute finite-difference derivatives.
    It evaluates

        f(x_i, t + dt) = f(x_i - v * dt, t)

    using higher-order Lagrange interpolation on the departure points.
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
        Diagonal weight matrix with shape ``(6, Nx, Nv)``.
    """
    W = lagrange5_weights(alpha)
    v = jnp.arange(n_points)
    total_shifts = stencil_offsets[:, None] + shifts[None, :]

    source_idx = v[None, None, :] - total_shifts[:, :, None]

    valid = (source_idx >= 0) & (source_idx < n_points)
    diag_weights = jnp.where(valid, W[:, :, None], 0.0)
    return diag_weights

@partial(jax.jit, static_argnums=(5,))
def advect_1d_matrix_diag(
    f_batch: jnp.ndarray,
    velocities: jnp.ndarray,
    dt: float,
    dx: float,
    stencil_offsets: jnp.ndarray,
    periodic: bool = True
) -> jnp.ndarray:
    """Batched 1D advection without gather
    Gather-free TPU implementation

    Parameters
    ----------
    f_batch : jnp.ndarray
        Batch of distribution functions with shape ``(batch_size, n_points)``.
    velocities : jnp.ndarray
        Advection velocities with shape ``(batch_size,)`` or ``(batch_size, n_points)``.
    dt : float
        Time step size.
    dx : float
        Grid spacing in the advection direction.
    stencil_offsets : jnp.ndarray
        Interpolation stencil offsets with shape ``(6,)``.
    periodic : bool, optional
        Whether to apply periodic boundary conditions, by default True.

    Returns
    -------
    jnp.ndarray
        Advected distribution functions with shape ``(batch_size, n_points)``.

    Notes
    -----
    This routine never compute finite-difference derivatives.
    It evaluates

        f(x_i, t + dt) = f(x_i - v * dt, t)

    using higher-order Lagrange interpolation on the departure points.
    """

    nx, nv= f_batch.shape
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
                in_axes=(1, 0),
                out_axes=1,
            )(f_batch, shifts)
            result = result + shifted * W[k][None, :]

        return result
    else:
        diag_weights = build_v_diag_weights(stencil_offsets, idx_left, alpha, nv)
        for k in range(6):
            shifts = idx_left + stencil_offsets[k]
            shifted = jax.vmap(
                jnp.roll,
                in_axes=(0, 0),
                out_axes=0,
            )(f_batch, shifts)

            result = result + diag_weights[k] * shifted
        return result

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
    Split the per-column shift of the periodic X drift into static data.

    The X-drift displacement ``d_j = v_j * dt / dx`` is time-constant, so its
    integer part ``s_j = floor(d_j)`` and fractional part ``alpha_j`` are
    compile-time constants. Because ``v`` is monotonic, columns with equal
    ``s_j`` form contiguous blocks. Displacement is computed with the same
    dtype and operation order as the reference kernels so integer shifts and
    weights match bit-for-bit.

    Parameters
    ----------
    v : jnp.ndarray
        Velocity coordinates with shape ``(Nv,)``.
    dt : float
        Time step of this advection (the Strang half step ``dt/2`` for X).
    dx : float
        Spatial grid spacing.
    dtype : str or dtype
        Array dtype used by the simulation (``float32`` or ``float64``).

    Returns
    -------
    blocks : list of tuple(int, int, int)
        Static column blocks ``(start, stop, shift)`` with Python-int
        shifts; ``f[:, start:stop]`` is rolled by ``shift`` along axis 0.
    W_x : jnp.ndarray
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

    W_x = lagrange5_weights(jnp.asarray(alpha, dtype=dtype))  # (6, Nv)
    return blocks, W_x

def block_roll(
    f: jnp.ndarray,
    blocks: list,
) -> jnp.ndarray:
    """
    Roll each contiguous column block by its static shift along axis 0.

    Realizes the per-column integer shift ``C^{s_j}`` of the X drift with
    static slices and concatenation only (each ``jnp.roll`` with a Python-int
    shift lowers to two static slices plus a concatenate — no gather).

    Parameters
    ----------
    f : jnp.ndarray
        Distribution function with shape ``(Nx, Nv)``.
    blocks : list of tuple(int, int, int)
        Static column blocks ``(start, stop, shift)`` from
        ``precompute_x_drift``.

    Returns
    -------
    jnp.ndarray
        Block-rolled distribution function with shape ``(Nx, Nv)``.
    """
    if all(shift % f.shape[0] == 0 for _, _, shift in blocks):
        return f
    pieces = [jnp.roll(f[:, a:b], shift, axis=0) for a, b, shift in blocks]
    return jnp.concatenate(pieces, axis=1) if len(pieces) > 1 else pieces[0]

def advect_x_static(
    f: jnp.ndarray,
    W_x: jnp.ndarray,
    blocks: list,
    stencil_offsets: jnp.ndarray,
) -> jnp.ndarray:
    """
    Periodic X drift as a block-static roll plus 6 static tap FMAs.

    Implements ``(A f)[i, j] = sum_k W_x[k, j] * f[(i - s_j - o_k) mod Nx, j]``
    with every shift static: the per-column integer shift is applied by
    ``block_roll`` and the remaining 6-band circulant ``K = sum_k w_k C^{o_k}``
    by 6 static rolls shared by all columns. No gather is emitted.

    Parameters
    ----------
    f : jnp.ndarray
        Distribution function with shape ``(Nx, Nv)``.
    W_x : jnp.ndarray
        Precomputed Lagrange weights with shape ``(6, Nv)``.
    blocks : list of tuple(int, int, int)
        Static column blocks from ``precompute_x_drift``.
    stencil_offsets : jnp.ndarray
        Interpolation stencil offsets with shape ``(6,)`` (must be
        concrete; see ``static_stencil_offsets``).

    Returns
    -------
    jnp.ndarray
        Advected distribution function with shape ``(Nx, Nv)``.
    """
    f2 = block_roll(f, blocks)
    out = jnp.zeros_like(f)
    for k, o in enumerate(static_stencil_offsets(stencil_offsets)):
        out = out + jnp.roll(f2, o, axis=0) * W_x[k][None, :]
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

    With ``d_i = E_i * dt / dv``, ``s_i = floor(d_i)`` and Lagrange weights
    ``w_k(alpha_i)``, the tap index ``m = s_i + o_k`` stays inside the static
    window ``[-S-2, S+2]`` whenever ``-S <= d_i < S``. The per-row weights are
    accumulated onto that window:
    ``Wt[m + S + 2, i] = sum_k w_k(alpha_i) * 1[s_i + o_k == m]``.

    Parameters
    ----------
    E : jnp.ndarray
        Electric field (advection velocity per row) with shape ``(Nx,)``.
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
        Tap weight matrix with shape ``(2S+5, Nx)``, taps ordered by
        ascending ``m`` in ``[-S-2, S+2]``.
    """
    d = (E * dt) / dv
    s = jnp.floor(d)
    alpha = d - s
    s = s.astype(jnp.int32)
    W6 = lagrange5_weights(alpha)  # (6, Nx)

    taps = range(-(S + 2), S + 3)  # m in [-S-2, S+2]
    rows = []
    for m in taps:
        acc = jnp.zeros_like(alpha)
        for k, o in enumerate(static_stencil_offsets(stencil_offsets)):
            acc = acc + jnp.where(s == m - o, W6[k], 0.0)
        rows.append(acc)
    return jnp.stack(rows, axis=0)  # (2S+5, Nx)

def advect_v_static(
    f: jnp.ndarray,
    E: jnp.ndarray,
    dt: float,
    dv: float,
    S: int,
    stencil_offsets: jnp.ndarray,
) -> jnp.ndarray:
    """
    Dirichlet V kick as 2S+5 static shifted FMAs on a zero-padded array.

    Applies the per-row banded operator
    ``(B f)[i, j] = sum_m Wt[m, i] * f_hat[i, j - m]`` where ``f_hat`` is the
    zero-extension of ``f`` (zero padding realizes the Dirichlet boundary
    condition exactly). Every tap ``m`` is a static slice of the padded array,
    so no gather is emitted.

    Parameters
    ----------
    f : jnp.ndarray
        Distribution function with shape ``(Nx, Nv)``.
    E : jnp.ndarray
        Electric field with shape ``(Nx,)``.
    dt : float
        Time step of the kick.
    dv : float
        Velocity grid spacing.
    S : int
        Static window bound (see ``build_v_tap_weights``).
    stencil_offsets : jnp.ndarray
        Interpolation stencil offsets with shape ``(6,)`` (must be
        concrete; see ``static_stencil_offsets``).

    Returns
    -------
    jnp.ndarray
        Advected distribution function with shape ``(Nx, Nv)``.
    """
    Wt = build_v_tap_weights(E, dt, dv, S, stencil_offsets)
    P = S + 2
    Nv = f.shape[1]
    g = jnp.pad(f, ((0, 0), (P, P)))  # zero padding == Dirichlet BC
    out = jnp.zeros_like(f)
    for q, m in enumerate(range(-P, P + 1)):
        out = out + Wt[q][:, None] * g[:, P - m:P - m + Nv]
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
        Electric field with shape ``(Nx,)``.
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

@jax.jit
def solve_poisson(
    f_data: jnp.ndarray,
    inv_kx: jnp.ndarray,
    dv: float
) -> Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]:
    """Solves Poisson's equation -> E(x)
    \nabla^2 phi = -rho
    -k^2 phi_k = -rho_k
    => phi_k = rho_k / k^2

    E = -dphi/dx
    E_k = -i*k*phi_k = -i*k*(rho_k/k^2) = -i*rho_k/k

    Parameters
    ----------
    f_data : jnp.ndarray
        Distribution function f(x,v)
    inv_kx : jnp.ndarray
        Precomputed 1/kx array for Fourier modes.
    dv : float
        Velocity grid spacing.

    Returns
    -------
    Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]
        Tuple containing (E, rho, phi) where:
        - E: Electric field E(x)
        - rho: Charge density rho(x)
        - phi: Electric potential phi(x)
    """
    n = jnp.sum(f_data, axis=1) * dv
    # rho = n - jnp.mean(n)
    rho = n - 1.0
    rho_k = jnp.fft.rfft(rho)

    # E_k = -i * rho_k / k
    E_k = -1j * rho_k * inv_kx
    E = jnp.fft.irfft(E_k)

    # Phi_k = rho_k / k ^ 2
    # Note : inv_kx is 1 / k. So we need 1 / k ^ 2
    # Handle k = 0 case implicitly(inv_kx is 0 at k = 0)
    Phi_k = rho_k * (inv_kx ** 2)
    phi = jnp.fft.irfft(Phi_k)
    return E, rho, phi

def vlasov_step(
    carry: Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray],
    g: Grid,
    dt: float,
    physics_mode: bool
) -> Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]:
    """
    Performs one time step of Vlasov-Poisson.
    Operates on high-level DataClasses.

    Parameters
    ----------
    carry : Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]
        Tuple containing (f, rho, phi) where:
        - f: distribution function f(x,v)
        - rho: charge density rho(x)
        - phi: electric potential phi(x)
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

    f = advect_1d_vectorized(f.T, g.v, dt/2.0, g.dx, g.stencil_offsets, periodic=True).T

    # Solve Poisson's equation to get E(x)
    if physics_mode:
        E, rho, phi = solve_poisson(f, g.inv_kx, g.dv)
    else:
        E = jnp.zeros_like(g.x)
        rho = jnp.zeros_like(g.x)
        phi = jnp.zeros_like(g.x)

    f = advect_1d_vectorized(f, E, dt, g.dv, g.stencil_offsets, periodic=False)

    f = advect_1d_vectorized(f.T, g.v, dt/2.0, g.dx, g.stencil_offsets, periodic=True).T

    return (f, rho, phi)

def vlasov_step_matrix_diag(
    carry: Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray],
    g: Grid,
    dt: float,
    physics_mode: bool
) -> Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]:
    """
    Performs one time step of Vlasov-Poisson.
    Operates on high-level DataClasses.

    Parameters
    ----------
    carry : Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]
        Tuple containing (f, rho, phi) where:
        - f: distribution function f(x,v)
        - rho: charge density rho(x)
        - phi: electric potential phi(x)
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

    f = advect_1d_matrix_diag(f, g.v, dt/2.0, g.dx, g.stencil_offsets, periodic=True)

    # Solve Poisson's equation to get E(x)
    if physics_mode:
        E, rho, phi = solve_poisson(f, g.inv_kx, g.dv)
    else:
        E = jnp.zeros_like(g.x)
        rho = jnp.zeros_like(g.x)
        phi = jnp.zeros_like(g.x)

    f = advect_1d_matrix_diag(f, E, dt, g.dv, g.stencil_offsets, periodic=False)

    f = advect_1d_matrix_diag(f, g.v, dt/2.0, g.dx, g.stencil_offsets, periodic=True)

    return (f, rho, phi)

def vlasov_step_gather_free(
    carry: Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray],
    g: Grid,
    dt: float,
    physics_mode: bool,
    S: int = 1
) -> Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]:
    """
    Performs one time step of Vlasov-Poisson without any gather
    (no data-dependent memory access in the lowering; TPU-friendly).

    The X-drift shifts are time-constant, so their integer part is applied
    as static block rolls and the 6-tap Lagrange stencil as 6 static rolls
    (``advect_x_static``). The V kick collapses (integer shift, stencil tap)
    onto a static window of ``2S+5`` shifted FMAs (``advect_v_static``),
    exact while ``|E*dt/dv| < S`` (see ``check_v_window``).

    Parameters
    ----------
    carry : Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]
        Tuple containing (f, rho, phi) where:
        - f: distribution function f(x,v)
        - rho: charge density rho(x)
        - phi: electric potential phi(x)
    g : Grid
        Grid object containing spatial and velocity grids.
    dt : float
        Time step size.
    physics_mode : bool
        Whether to solve Poisson's equation or not.
    S : int
        Static window bound of the V kick; requires ``|E*dt/dv| < S``.

    Returns
    -------
    Tuple[jnp.ndarray, jnp.ndarray, jnp.ndarray]
        Updated (f, rho, phi) after one time step.
    """

    f, _, _ = carry

    # Precomputed at trace time from the concrete g.v: static Python-int
    # shifts and constant weights (the X-drift displacement is time-constant).
    blocks, W_x = precompute_x_drift(g.v, dt/2.0, g.dx, g.x.dtype)

    f = advect_x_static(f, W_x, blocks, g.stencil_offsets)

    # Solve Poisson's equation to get E(x)
    if physics_mode:
        E, rho, phi = solve_poisson(f, g.inv_kx, g.dv)
    else:
        E = jnp.zeros_like(g.x)
        rho = jnp.zeros_like(g.x)
        phi = jnp.zeros_like(g.x)

    f = advect_v_static(f, E, dt, g.dv, S, g.stencil_offsets)

    f = advect_x_static(f, W_x, blocks, g.stencil_offsets)

    return (f, rho, phi)

class Vlasov:
    dt: float = 0.05
    diag_steps: int = 10
    out_dir: str = "data"
    physics_mode: bool = False
    epsilon: float = 0.001
    def __init__(
        self,
        Nx: int = 128,
        Nv: int = 128,
        L: float = 2.0*jnp.pi,
        V_max: float = 6.0,
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
        Nx : int
            Number of spatial grid points.
        Nv : int
            Number of velocity grid points.
        L : float
            Physical domain length.
        V_max : float
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
        self.grid = Grid.create(Nx, Nv, L, V_max, dtype=dtype)
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
        device = self.grid.x.device  # Get device from grid arrays
        message  = f"Jax version: {jax.__version__}\n"
        message += f"Starting simulation on {device.device_kind} using {self.grid.x.dtype} precision "
        message += "with Poisson solver" if self.physics_mode else "without Poisson solver"
        message += f" and solver type {self.solver_type}."
        self._append_log(message)
        self._append_log(f"Grid: {self.grid.Nx}x{self.grid.Nv}, Steps: {self.nbiter}, chunks: {self.num_steps}, diag_freq: {self.diag_steps}")

        # Define JIT - compiled Chunk Runner
        # This compiles a loop that runs 'diag_steps' iterations entirely on GPU / TPU
        # and returns ONLY the final state, discarding intermediate history.
        # Handle case where diag_steps > nbiter
        length = min(self.diag_steps, self.nbiter)
        if self.num_steps == 0:
            self._append_log(f"Running simulation without diagnostics (num_steps=0). Steps: {length}")

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
                    raise ValueError(f"Unknown solver type: {solver}")

            carry = (start_state.variables.fn, start_state.field.rho, start_state.field.phi)
            f_final, rho_final, phi_final = jax.lax.fori_loop(0, length, body_fn, carry)
            t = start_state.t + self.dt * length
            step = start_state.step + length
            final_chunk_state = SimulationState(
                grid=start_state.grid,
                field=Field(rho_final, phi_final),
                variables=Variables(f_final, start_state.variables.f0),
                t=t,
                step=step
            )

            return final_chunk_state

        self._run_chunk = run_chunk

    def _append_log(
        self,
        message: str
    ) -> None:
        """
        Appends a message to the simulation log.

        Parameters
        ----------
        message : str
            The message to append to the log.
        """
        self.output_log += f"{message}\n"

    def initialize(self) -> SimulationState:
        """
        Creates the initial SimulationState with a Gaussian pulse.

        Returns
        -------
        SimulationState
            The initial state of the simulation.
        """

        # Broadcasting for memory efficiency
        x_2d = self.grid.x[:, None]
        v_2d = self.grid.v[None, :]

        if self.physics_mode:
            # Landau damping settings
            kx = 1 * 2.0 * jnp.pi / self.grid.L
            f0 = 1.0 / np.sqrt(2.0*jnp.pi) * jnp.exp(-0.5*self.grid.v**2)
            f_data = (1.0 + self.epsilon * jnp.cos(kx*x_2d)) / np.sqrt(2.0*jnp.pi) * jnp.exp(-0.5*v_2d**2)
        else:
            # Gaussian pulse
            x0, v0 = self.grid.L / 2.0, 0.0
            sigma_x, sigma_v = self.grid.L / 10.0, self.grid.V_max / 4.0
            f_data = jnp.exp(-0.5 * ((x_2d - x0)**2 / sigma_x**2 + (v_2d - v0)**2 / sigma_v**2))
            f0 = jnp.zeros_like(self.grid.v, dtype=self.dtype)
        _, rho, phi = solve_poisson(f_data, self.grid.inv_kx, self.grid.dv)

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
        initial_state: SimulationState
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

    def get_analytical_free_streaming(
        self,
        t_final: float
    ) -> jnp.ndarray:
        """
        Calculates analytical solution for E=0 case.

        Parameters
        ----------
        t_final : float
            The final time at which to evaluate the analytical solution.

        Returns
        -------
        jnp.ndarray
            The analytical distribution function at time t_final with shape (Nx, Nv).
        """
        x0, v0 = self.grid.L / 2.0, 0.0
        sigma_x, sigma_v = self.grid.L / 10.0, self.grid.V_max / 4.0

        # Back - propagate X coordinates : x_back = x - v * t
        X_back = jnp.mod(self.grid.x[:, None] - self.grid.v[None, :] * t_final, self.grid.L)
        V_grid = self.grid.v[None, :]

        f_analytical = jnp.exp(-0.5 * ((X_back - x0)**2 / sigma_x**2 + (V_grid - v0)**2 / sigma_v**2))
        return f_analytical

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
                "f": (("time", "x", "v"), np.array(f)[None, ...]),
                "f0": (("time", "v"), np.array(f0[None, ...])),
                "rho": (("time", "x"), np.array(rho)[None, ...]),
                "phi": (("time", "x"), np.array(phi)[None, ...]),
            },
            coords = {
                "time": np.array([float(state.t)]),
                "x": np.array(state.grid.x),
                "v": np.array(state.grid.v),
            },
            attrs = {
                "step": int(state.step),
                "dt": self.dt,
                "L": self.grid.L,
                "V_max": self.grid.V_max,
                "physics_mode": int(self.physics_mode),
            }
        )

        # Save file : field_000010.nc
        outdir = pathlib.Path(self.out_dir)
        filename = outdir / f"field_{state.step:06d}.nc"
        ds.to_netcdf(filename)

def run_vlp1d1v(
    nx: int,
    nv: int,
    lx: float,
    vmax: float,
    nbiter: int,
    diag_steps: int,
    dt: float,
    out_dir: str,
    physics_mode: bool,
    epsilon: float,
    solver_type: int,
    dtype: str,
):
    """
    Main function to run the Vlasov-Poisson simulation.
    Parses command-line arguments and initializes the solver.
    """

    if dtype == 'float64':
        # Enable 64-bit floating point support in JAX
        jax.config.update("jax_enable_x64", True)

    # Initialize Solver
    solver = Vlasov(
        Nx=nx, Nv=nv,
        L=lx, V_max=vmax,
        nbiter=nbiter,
        diag_steps=diag_steps,
        dt=dt,
        out_dir=out_dir,
        physics_mode=physics_mode, # Set False for validation, True for Physics
        epsilon=epsilon,
        solver=solver_type,
        dtype=dtype,
    )

    # Create Initial State
    initial_state = solver.initialize()

    # ── Jaxpr and stablehlo analysis ──────────────────────────────────────────────
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

    output_path = pathlib.Path.cwd() / f"vlp1d_1v_{dtype}.txt"
    output_path.write_text(solver.output_log)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(add_help=True)
    parser.add_argument('-nx', nargs='?', type=int, default=128,
                        help="Number of grid points in each spatial dimension")
    parser.add_argument('-nv', nargs='?', type=int, default=128,
                        help="Number of grid points in each velocity dimension")
    parser.add_argument('-lx', nargs='?', type=float, default=4.0*jnp.pi,
                        help="Physical domain length in one spatial direction")
    parser.add_argument('-vmax', nargs='?', type=float, default=5.0,
                        help="Maximum velocity in one spatial direction")
    parser.add_argument('-nbiter', nargs='?', type=int, default=1000,
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

    run_vlp1d1v(
        nx=args.nx,
        nv=args.nv,
        lx=args.lx,
        vmax=args.vmax,
        nbiter=args.nbiter,
        diag_steps=args.diag_steps,
        dt=args.dt,
        out_dir=args.out_dir,
        physics_mode=args.physics_mode,
        epsilon=args.epsilon,
        solver_type=args.solver,
        dtype=args.dtype
    )
