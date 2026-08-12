import os
# Workaround for Triton compilation on aarch64 with CC=nvc
if os.environ.get("CC") and "nvc" in os.environ["CC"]:
    os.environ["CC"] = "gcc"
if os.environ.get("CXX") and "nvc" in os.environ["CXX"]:
    os.environ["CXX"] = "g++"

import platform
import torch
import torch._dynamo as dynamo

# Workaround for torch<=2.9 CPU inductor on aarch64: a vectorized indirect
# load under a mask (e.g. `advect_x_static`'s constant-index gather fused
# with the zero-padding mask of `advect_v_static`) generates
# `VecMask<int64_t, N>(int)`, which the NEON codegen cannot compile.
# Disabling CPU SIMD codegen avoids that path; Triton/GPU codegen is
# unaffected by `cpp.*` settings.
if platform.machine() == "aarch64":
    torch._inductor.config.cpp.simdlen = 1

import math
import argparse
import time
import pathlib
import xarray as xr
import numpy as np
from dataclasses import dataclass
from typing import Tuple

def get_device_label(device: torch.device) -> str:
    if device.type == 'cuda':
        idx = device.index if device.index is not None else torch.cuda.current_device()
        return f"{torch.cuda.get_device_name(idx)} (cuda:{idx})"
    elif device.type == 'xpu':
        idx = device.index if device.index is not None else torch.xpu.current_device()
        return f"{torch.xpu.get_device_name(idx)} (xpu:{idx})"
    elif device.type == 'mps':
        return "Apple Silicon (mps)"
    else:
        cpu_name = platform.processor() or platform.machine()
        return f"{cpu_name} (cpu)"

def synchronize(device: torch.device):
    if device.type == 'cuda':
        torch.cuda.synchronize()
    elif device.type == 'mps':
        torch.mps.synchronize()
    elif device.type == 'xpu':
        torch.xpu.synchronize()

def reset_peak_memory(device: torch.device):
    if device.type == 'cuda':
        torch.cuda.reset_peak_memory_stats(device)
    elif device.type == 'xpu':
        torch.xpu.reset_peak_memory_stats(device)

def get_memory_stats(device: torch.device):
    synchronize(device)

    if device.type == 'cuda':
        return {
            'allocated': torch.cuda.memory_allocated(device),
            'reserved': torch.cuda.memory_reserved(device),
            'peak_allocated': torch.cuda.max_memory_allocated(device),
            'peak_reserved': torch.cuda.max_memory_reserved(device),
        }

    elif device.type == 'xpu':
        return {
            'allocated': torch.xpu.memory_allocated(device),
            'reserved': torch.xpu.memory_reserved(device),
            'peak_allocated': torch.xpu.max_memory_allocated(device),
            'peak_reserved': torch.xpu.max_memory_reserved(device),
        }

    return None

def print_memory_summary(device: torch.device, filename: str) -> None:
    if device.type == 'cuda':
        summary = torch.cuda.memory_summary(abbreviated=False)
        with open(filename, 'w') as f:
            f.write(summary)

def format_memory(num_bytes: int) -> str:
    return f"{num_bytes / (1024 ** 2):.2f} MiB"

@dataclass
class Grid:
    """
    Grid definition for the 2D2V Vlasov solver.

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
    x : torch.Tensor
        Spatial grid points in x. Shape: (Nx,)
    y : torch.Tensor
        Spatial grid points in y. Shape: (Ny,)
    vx : torch.Tensor
        Velocity grid points in vx. Shape: (Nvx,)
    vy : torch.Tensor
        Velocity grid points in vy. Shape: (Nvy,)
    kx : torch.Tensor
        Wave numbers in x. Shape: (Nx, 1)
    ky : torch.Tensor
        Wave numbers in y (real FFT). Shape: (1, Ny//2 + 1)
    inv_ksq : torch.Tensor
        Inverse squared wave numbers (1/k^2). Shape: (Nx, Ny//2 + 1)
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
    x: torch.Tensor
    y: torch.Tensor
    vx: torch.Tensor
    vy: torch.Tensor
    kx: torch.Tensor
    ky: torch.Tensor
    inv_ksq: torch.Tensor
    x_indices: torch.Tensor
    y_indices: torch.Tensor
    vx_indices: torch.Tensor
    vy_indices: torch.Tensor
    stencil_offsets: torch.Tensor

    @classmethod
    def create(cls, Nx, Ny, Nvx, Nvy, Lx, Ly, Vx_max, Vy_max, device='cpu', dtype=torch.float32):
        dx, dy = Lx / Nx, Ly / Ny
        dvx, dvy = 2 * Vx_max / (Nvx - 1), 2 * Vy_max / (Nvy - 1)

        # Endpoint=False for periodic spatial dims
        x = torch.linspace(0, Lx, Nx + 1, device=device, dtype=dtype)[:-1]
        y = torch.linspace(0, Ly, Ny + 1, device=device, dtype=dtype)[:-1]
        # Endpoint=True for velocity dims
        vx = torch.linspace(-Vx_max, Vx_max, Nvx, device=device, dtype=dtype)
        vy = torch.linspace(-Vy_max, Vy_max, Nvy, device=device, dtype=dtype)

        kx = 2 * math.pi * torch.fft.fftfreq(Nx, d=dx, device=device, dtype=dtype).unsqueeze(1)    # [Nx, 1]
        ky = 2 * math.pi * torch.fft.rfftfreq(Ny, d=dy, device=device, dtype=dtype).unsqueeze(0)   # [1, Ny//2+1]

        k_sq = kx**2 + ky**2
        inv_ksq = torch.where(k_sq == 0, torch.tensor(0.0, device=device, dtype=dtype), 1.0 / k_sq)

        index_dtype = torch.int64
        x_indices = torch.arange(Nx, device=device, dtype=dtype)
        y_indices = torch.arange(Ny, device=device, dtype=dtype)
        vx_indices = torch.arange(Nvx, device=device, dtype=dtype)
        vy_indices = torch.arange(Nvy, device=device, dtype=dtype)
        stencil_offsets = torch.arange(-2, 4, device=device, dtype=index_dtype)

        return cls(Nx, Ny, Nvx, Nvy, Lx, Ly, Vx_max, Vy_max,
               dx, dy, dvx, dvy, x, y, vx, vy, kx, ky, inv_ksq,
               x_indices, y_indices, vx_indices, vy_indices, stencil_offsets)

    def to(self, device) -> "Grid":
        self.x = self.x.to(device)
        self.y = self.y.to(device)
        self.vx = self.vx.to(device)
        self.vy = self.vy.to(device)
        self.kx = self.kx.to(device)
        self.ky = self.ky.to(device)
        self.inv_ksq = self.inv_ksq.to(device)
        self.x_indices = self.x_indices.to(device)
        self.y_indices = self.y_indices.to(device)
        self.vx_indices = self.vx_indices.to(device)
        self.vy_indices = self.vy_indices.to(device)
        self.stencil_offsets = self.stencil_offsets.to(device)
        return self

@dataclass
class Field:
    """Holds the field data (rho, phi)."""
    rho: torch.Tensor
    phi: torch.Tensor

@dataclass
class Variables:
    """Holds the distribution function f."""
    fn: torch.Tensor
    f0: torch.Tensor

@dataclass
class SimulationState:
    """The state carried through the simulation loop."""
    field: Field
    variables: Variables
    t: float
    step: int

def get_lagrange5_weights(alpha):
    """Compute weights for 5th degree Lagrange interpolation.

    Parameters
    ----------
    alpha : torch.Tensor
        Fractional offset. Shape: [Batch, N]

    Returns
    -------
    torch.Tensor
        Interpolation weights. Shape: [Batch, N, 6]
    """
    weights = torch.empty((*alpha.shape, 6), device=alpha.device, dtype=alpha.dtype)
    nodes = torch.arange(-2, 4, device=alpha.device, dtype=alpha.dtype)

    for j in range(6):
        w = torch.ones_like(alpha)
        x_j = nodes[j]
        for m in range(6):
            if m != j:
                x_m = nodes[m]
                w = w * (alpha - x_m) / (x_j - x_m)
        weights[..., j] = w

    return weights


def lagrange5_interp_sum(alpha, gather_vals):
    """Evaluate the 6-point interpolation sum without materializing weights."""
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
        w0 * gather_vals[..., 0]
        + w1 * gather_vals[..., 1]
        + w2 * gather_vals[..., 2]
        + w3 * gather_vals[..., 3]
        + w4 * gather_vals[..., 4]
        + w5 * gather_vals[..., 5]
    )


def lagrange5_weights(alpha):
    """
    Evaluates the 6-point, 5th-order Lagrange interpolation weights in
    closed form (same coefficients as `lagrange5_interp_sum`, but returned
    as standalone weights rather than applied to gathered values).

    alpha: [...] fractional departure coordinates.
    Returns: [6, ...] stacked weights, one entry per stencil tap.
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

    return torch.stack([w0, w1, w2, w3, w4, w5], dim=0)

@torch.compile
def advect_1d_vectorized(
    f_batch,
    velocities,
    dt,
    dx,
    point_indices=None,
    stencil_offsets=None,
    periodic=True,
):
    """Batched 1D advection using flat indexing and vectorized Lagrange weights.

    Parameters
    ----------
    f_batch : torch.Tensor
        Distribution slices. Shape: [batch_size, n_points]
    velocities : torch.Tensor
        Velocity per batch element. Shape: [batch_size] or [batch_size, n_points]
    dt : float
        Time step.
    dx : float
        Grid spacing.
    periodic : bool
        If True, periodic BC; if False, Dirichlet (zero outside).

    Returns
    -------
    torch.Tensor
        Advected distribution. Shape: [batch_size, n_points]
    """
    batch_size, n_points = f_batch.shape
    if point_indices is None:
        point_indices = torch.arange(n_points, device=f_batch.device, dtype=f_batch.dtype)
    if stencil_offsets is None:
        stencil_offsets = torch.arange(-2, 4, device=f_batch.device, dtype=torch.int64)
    batch_offsets = (
        torch.arange(batch_size, device=f_batch.device, dtype=torch.int64).view(batch_size, 1, 1) * n_points
    )

    # displacement in index units
    if velocities.ndim == 1:
        v_expanded = velocities.unsqueeze(1)
    else:
        v_expanded = velocities

    displacement_idx = (v_expanded * dt) / dx
    depart_idx = point_indices.unsqueeze(0) - displacement_idx

    idx_left = torch.floor(depart_idx)
    alpha = depart_idx - idx_left
    idx_left = idx_left.to(torch.long)

    stencil_indices = idx_left.unsqueeze(-1) + stencil_offsets  # [B, N, 6]
    flat_f = f_batch.reshape(-1)

    if periodic:
        safe_indices = torch.remainder(stencil_indices, n_points)
        gather_idx = (batch_offsets + safe_indices).reshape(-1)
        f_vals = flat_f[gather_idx].reshape(batch_size, n_points, 6)
    else:
        valid_mask = (stencil_indices >= 0) & (stencil_indices < n_points)
        safe_indices = torch.clamp(stencil_indices, 0, n_points - 1)
        gather_idx = (batch_offsets + safe_indices).reshape(-1)
        f_vals = flat_f[gather_idx].reshape(batch_size, n_points, 6)
        f_vals = f_vals * valid_mask.to(dtype=f_batch.dtype)

    return lagrange5_interp_sum(alpha, f_vals)


def advect_1d(f_data, velocities, axis, dt, dx, periodic=True, point_indices=None, stencil_offsets=None):
    """High-level 1D advection for a 4D distribution function f(x, y, vx, vy).

    Moves the target *axis* to the last position, flattens all other
    dimensions into a batch, and delegates to advect_1d_vectorized.

    Parameters
    ----------
    f_data : torch.Tensor
        Distribution function.  Shape: (Nx, Ny, Nvx, Nvy)
    velocities : torch.Tensor
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
    torch.Tensor
        Advected distribution function, same shape as f_data.
    """
    # Move target axis to last position
    ndim = f_data.ndim
    perm = list(range(ndim))
    perm.append(perm.pop(axis))
    f_perm = f_data.permute(*perm)  # [..., N_target]

    # Flatten batch dims -> [N_batch, N_target]
    batch_shape = f_perm.shape[:-1]
    n_target = f_perm.shape[-1]
    f_flat = f_perm.reshape(-1, n_target)

    # Broadcast velocities to batch shape, then flatten
    vel_flat = velocities.expand(batch_shape).reshape(-1)

    # Vectorized advection
    f_flat = advect_1d_vectorized(
        f_flat,
        vel_flat,
        dt,
        dx,
        point_indices=point_indices,
        stencil_offsets=stencil_offsets,
        periodic=periodic,
    )

    # Reshape and inverse transpose
    f_flat = f_flat.reshape(f_perm.shape)
    inv_perm = [0] * ndim
    for i, p in enumerate(perm):
        inv_perm[p] = i
    return f_flat.permute(*inv_perm)


def compute_rho(f_data, dvx, dvy):
    """Compute charge density rho(x,y) by integrating f over velocity space.

    Parameters
    ----------
    f_data : torch.Tensor
        Distribution function f(x,y,vx,vy). Shape: (Nx, Ny, Nvx, Nvy)
    dvx, dvy : float
        Velocity grid spacings.

    Returns
    -------
    torch.Tensor
        Charge density rho(x,y). Shape: (Nx, Ny)
    """
    return torch.sum(f_data, dim=(2, 3)) * dvx * dvy


def compute_poisson(rho, kx, ky, inv_ksq):
    """Solve Poisson's equation in Fourier space.

    Parameters
    ----------
    rho : torch.Tensor
        Charge density rho(x,y). Shape: (Nx, Ny)
    kx : torch.Tensor
        Wave numbers in x. Shape: (Nx, 1)
    ky : torch.Tensor
        Wave numbers in y. Shape: (1, Ny//2+1)
    inv_ksq : torch.Tensor
        Precomputed 1/k^2. Shape: (Nx, Ny//2+1)

    Returns
    -------
    Ex, Ey, delta_rho, phi : torch.Tensor
    """
    Nx, Ny = rho.shape
    delta_rho = rho - 1
    rho_k = torch.fft.rfft2(delta_rho)

    phi_k = rho_k * inv_ksq
    phi = torch.fft.irfft2(phi_k, s=(Nx, Ny))

    Ex_k = -1j * kx * phi_k
    Ey_k = -1j * ky * phi_k

    Ex = torch.fft.irfft2(Ex_k, s=(Nx, Ny))
    Ey = torch.fft.irfft2(Ey_k, s=(Nx, Ny))

    return Ex, Ey, delta_rho, phi


def solve_poisson(f_data, kx, ky, inv_ksq, dvx, dvy):
    """Solve Poisson's equation from distribution function f.

    Parameters
    ----------
    f_data : torch.Tensor
        Distribution function f(x,y,vx,vy). Shape: (Nx, Ny, Nvx, Nvy)
    kx, ky, inv_ksq : torch.Tensor
        Fourier space arrays.
    dvx, dvy : float
        Velocity grid spacings.

    Returns
    -------
    Ex, Ey, delta_rho, phi : torch.Tensor
    """
    rho = compute_rho(f_data, dvx, dvy)
    return compute_poisson(rho, kx, ky, inv_ksq)


def compute_poisson_real(rho, kx, ky, inv_ksq):
    """Solve Poisson's equation while minimizing complex operator usage."""
    Nx, Ny = rho.shape
    delta_rho = rho - 1
    rho_k = torch.fft.rfft2(delta_rho)

    rho_k_real = torch.view_as_real(rho_k)
    inv_ksq_3d = inv_ksq.unsqueeze(-1)
    phi_k_real = rho_k_real * inv_ksq_3d

    kx_3d = kx.unsqueeze(-1)
    ky_3d = ky.unsqueeze(-1)
    Ex_k_real = torch.stack([
        phi_k_real[..., 1] * kx_3d.squeeze(-1),
        -phi_k_real[..., 0] * kx_3d.squeeze(-1),
    ], dim=-1)
    Ey_k_real = torch.stack([
        phi_k_real[..., 1] * ky_3d.squeeze(-1),
        -phi_k_real[..., 0] * ky_3d.squeeze(-1),
    ], dim=-1)

    phi_k = torch.view_as_complex(phi_k_real)
    Ex_k = torch.view_as_complex(Ex_k_real)
    Ey_k = torch.view_as_complex(Ey_k_real)

    phi = torch.fft.irfft2(phi_k, s=(Nx, Ny))
    Ex = torch.fft.irfft2(Ex_k, s=(Nx, Ny))
    Ey = torch.fft.irfft2(Ey_k, s=(Nx, Ny))

    return Ex, Ey, delta_rho, phi


def solve_poisson_real(f_data, kx, ky, inv_ksq, dvx, dvy):
    """Solve Poisson's equation from f while minimizing complex operator usage."""
    rho = compute_rho(f_data, dvx, dvy)
    return compute_poisson_real(rho, kx, ky, inv_ksq)


def _roll_batch(x, shifts):
    """
    Rolls each row of x ([Batch, N]) along dim 1 by its own per-row integer
    shift ([Batch]), i.e. out[i, j] = x[i, (j - shifts[i]) % N]. Mirrors
    `_roll_rows` in vlasov1D1V.py.
    """
    n = x.shape[1]
    col_idx = torch.arange(n, device=x.device).unsqueeze(0)  # [1, N]
    idx = torch.remainder(col_idx - shifts.unsqueeze(1), n)   # [Batch, N]
    return torch.gather(x, 1, idx)


def build_diag_weights(stencil_offsets, shifts, alpha, n_points):
    """
    Builds a banded weight matrix so interpolation along the advected axis
    can be applied as a per-row circular roll plus a per-row masked
    weighted sum, mirroring `build_v_diag_weights` in vlasov1D1V.py.

    shifts: [Batch] integer index shift of the departure point.
    alpha: [Batch] fractional part of the departure point.
    n_points: grid size along the advected axis.
    Returns: [6, Batch, n_points] banded weight matrix.
    """
    W = lagrange5_weights(alpha)
    idx = torch.arange(n_points, device=alpha.device)
    total_shifts = stencil_offsets.unsqueeze(1) + shifts.unsqueeze(0)

    source_idx = idx.view(1, 1, -1) - total_shifts.unsqueeze(-1)  # [6, Batch, n_points]
    valid = (source_idx >= 0) & (source_idx < n_points)
    return valid.to(W.dtype) * W.unsqueeze(-1)

@torch.compile
def advect_1d_matrix_diag_core(f_batch, velocities, dt, dx, stencil_offsets, periodic=True):
    """
    Gather-free batched 1D advection using per-row circular rolls plus
    banded Lagrange weights, mirroring the JAX/PyTorch `advect_1d_matrix_diag`
    solver variant in vlasov1D1V.py (roll-based instead of a flat gather).

    f_batch: [Batch, N_points]. velocities: [Batch] (one value per row,
    constant along the advected axis -- guaranteed by how the `advect_1d_matrix_diag`
    wrapper below broadcasts them).
    """
    batch_size, n_points = f_batch.shape
    displacement_idx = velocities * dt / dx

    idx_left = torch.floor(displacement_idx)
    alpha = displacement_idx - idx_left
    idx_left = idx_left.to(torch.long)

    result = torch.zeros_like(f_batch)
    if periodic:
        W = lagrange5_weights(alpha)  # [6, Batch]
        for k in range(6):
            shifts = idx_left + stencil_offsets[k]
            shifted = _roll_batch(f_batch, shifts)  # [Batch, N_points]
            result = result + shifted * W[k].unsqueeze(1)
        return result
    else:
        diag_weights = build_diag_weights(stencil_offsets, idx_left, alpha, n_points)  # [6, Batch, N_points]
        for k in range(6):
            shifts = idx_left + stencil_offsets[k]
            shifted = _roll_batch(f_batch, shifts)
            result = result + diag_weights[k] * shifted
        return result


def advect_1d_matrix_diag(f_data, velocities, axis, dt, dx, periodic=True, point_indices=None, stencil_offsets=None):
    """
    Gather-free counterpart to `advect_1d`: moves the target axis to the
    last position, flattens the remaining dims into a batch, and delegates
    to `advect_1d_matrix_diag_core` (per-row circular roll + banded Lagrange
    weights) instead of `advect_1d_vectorized` (flat gather).

    `point_indices` and `stencil_offsets` are accepted but unused; they
    exist only so this function has the same call signature as `advect_1d`
    and can be used as a drop-in replacement.

    Parameters
    ----------
    f_data : torch.Tensor
        Distribution function. Shape: (Nx, Ny, Nvx, Nvy)
    velocities : torch.Tensor
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
    torch.Tensor
        Advected distribution function, same shape as f_data.
    """
    ndim = f_data.ndim
    perm = list(range(ndim))
    perm.append(perm.pop(axis))
    f_perm = f_data.permute(*perm)  # [..., N_target]

    batch_shape = f_perm.shape[:-1]
    n_target = f_perm.shape[-1]
    f_flat = f_perm.reshape(-1, n_target)

    vel_flat = velocities.expand(batch_shape).reshape(-1)

    f_flat = advect_1d_matrix_diag_core(f_flat, vel_flat, dt, dx, stencil_offsets, periodic=periodic)

    f_flat = f_flat.reshape(f_perm.shape)
    inv_perm = [0] * ndim
    for i, p in enumerate(perm):
        inv_perm[p] = i
    return f_flat.permute(*inv_perm)


def static_stencil_offsets(stencil_offsets) -> Tuple[int, ...]:
    """
    Convert stencil offsets to static Python ints for the gather-free kernels.

    Static rolls and slices require concrete shift values (a tensor shift
    would force a data-dependent indexing path). Accepts either a concrete
    tensor or an already-converted int sequence; the tensor form must only
    be used *outside* torch.compile'd code (``.tolist()`` on a tensor would
    graph-break), which is why the compiled solver-2 step receives the
    offsets pre-converted to a tuple.

    Parameters
    ----------
    stencil_offsets : torch.Tensor or sequence of int
        Interpolation stencil offsets. Shape/length: (6,)

    Returns
    -------
    Tuple[int, ...]
        The offsets as Python ints.
    """
    if isinstance(stencil_offsets, torch.Tensor):
        return tuple(int(o) for o in stencil_offsets.tolist())
    return tuple(int(o) for o in stencil_offsets)


def precompute_x_drift(v, dt, dx, dtype):
    """
    Split the per-velocity shift of a periodic spatial drift into static data.

    The drift displacement ``d_j = v_j * dt / dx`` is time-constant, so its
    integer part ``s_j = floor(d_j)`` and fractional part ``alpha_j`` are
    constants. Because ``v`` is monotonic, velocity indices with equal
    ``s_j`` form contiguous blocks. Displacement is computed with the same
    dtype and operation order as the reference kernels so integer shifts
    and weights match bit-for-bit.

    Parameters
    ----------
    v : torch.Tensor
        Velocity coordinates (``vx`` or ``vy``). Shape: (Nv,)
    dt : float
        Time step of this advection (the Strang half step ``dt/2``).
    dx : float
        Spatial grid spacing along the drift axis.
    dtype : torch.dtype
        Tensor dtype used by the simulation.

    Returns
    -------
    blocks : list of tuple(int, int, int)
        Static velocity-index blocks ``(start, stop, shift)`` with
        Python-int shifts.
    W : torch.Tensor
        Lagrange weights of the fractional displacements. Shape: (6, Nv)
        (tap ``k`` corresponds to ``Grid.stencil_offsets[k]``).
    """
    np_dtype = np.dtype('float64' if dtype == torch.float64 else 'float32')
    v_np = v.detach().cpu().numpy().astype(np_dtype)
    d = (v_np * np_dtype.type(dt)) / np_dtype.type(dx)
    s = np.floor(d)
    alpha = d - s
    s = s.astype(np.int64)

    edges = np.flatnonzero(np.diff(s)) + 1
    starts = np.concatenate(([0], edges))
    stops = np.concatenate((edges, [len(s)]))
    blocks = [(int(a), int(b), int(s[a])) for a, b in zip(starts, stops)]

    W = lagrange5_weights(torch.as_tensor(alpha, dtype=dtype, device=v.device))  # (6, Nv)
    return blocks, W


def block_roll(f_data, blocks, axis, vel_axis):
    """
    Roll each contiguous velocity block by its static shift along a spatial axis.

    Realizes the per-velocity integer shift of a spatial drift with static
    narrows, rolls and one concatenate only (``torch.roll`` with a
    Python-int shift is a static shuffle — no data-dependent indexing).

    Off the hot path: `advect_x_static` now folds the integer shift into
    constant gather indices instead (see its docstring); this function is
    kept as the JAX-parity reference, mirroring ``block_roll`` in the JAX
    vlasov2D2V.py.

    Parameters
    ----------
    f_data : torch.Tensor
        Distribution function. Shape: (Nx, Ny, Nvx, Nvy)
    blocks : list of tuple(int, int, int)
        Static velocity-index blocks ``(start, stop, shift)`` from
        ``precompute_x_drift``.
    axis : int
        Spatial axis to roll along (0=x, 1=y).
    vel_axis : int
        Velocity axis the blocks partition (2=vx for axis 0, 3=vy for axis 1).

    Returns
    -------
    torch.Tensor
        Block-rolled distribution function, same shape as ``f_data``.
    """
    if all(shift % f_data.shape[axis] == 0 for _, _, shift in blocks):
        return f_data
    pieces = [
        torch.roll(f_data.narrow(vel_axis, a, b - a), shifts=shift, dims=axis)
        for a, b, shift in blocks
    ]
    return torch.cat(pieces, dim=vel_axis) if len(pieces) > 1 else pieces[0]


def advect_x_static(f_data, W, blocks, stencil_offsets, axis):
    """
    Periodic X/Y drift as 6 constant-index gathers fused with the tap FMAs.

    The per-velocity integer shift and the 6-tap Lagrange stencil are
    folded into one gather index per tap, ``(i - s_j - o_k) % N``, where
    the shifts ``s_j`` come from the static ``blocks`` and the tap offsets
    ``o_k`` are Python ints — the indices depend only on the constant grid
    and dt, never on the evolving data, so there is still no
    data-dependent memory access. Under torch.compile the index arithmetic
    and all 6 gathers fuse into a single pointwise kernel.

    This replaces the earlier `block_roll` + 6-static-roll form, which
    reads the same values in the same accumulation order (the output is
    bitwise identical) but emits one roll kernel per shift block — the
    block count grows linearly with the spatial resolution, which made the
    1D1V solver 2 launch-bound on GPU at large Nx (see the 2026-07-16
    entry in simulations/vlasov1d_1v/pytorch/README.md and
    investigation/vlasov1d_1v/ab90443/investigation.md). `block_roll` is
    kept as the JAX-parity reference. Periodic BC only (there is no
    ``periodic`` argument). Mirrors ``advect_x_static`` in the PyTorch
    vlasov1D1V.py.

    Parameters
    ----------
    f_data : torch.Tensor
        Distribution function. Shape: (Nx, Ny, Nvx, Nvy)
    W : torch.Tensor
        Precomputed Lagrange weights. Shape: (6, Nvx) for axis 0 or
        (6, Nvy) for axis 1 (from ``precompute_x_drift``).
    blocks : list of tuple(int, int, int)
        Static velocity-index blocks from ``precompute_x_drift``.
    stencil_offsets : torch.Tensor
        Interpolation stencil offsets. Shape: (6,) (must be concrete; see
        ``static_stencil_offsets``).
    axis : int
        Spatial axis to advect along (0=x with velocity vx, 1=y with vy).

    Returns
    -------
    torch.Tensor
        Advected distribution function, same shape as ``f_data``.
    """
    vel_axis = axis + 2
    n = f_data.shape[axis]
    w_shape = [1, 1, 1, 1]
    w_shape[vel_axis] = W.shape[1]

    # Expand the static blocks to a per-velocity shift vector. ``blocks``
    # is compile-time constant, so under torch.compile this tensor is a
    # constant baked into the graph, not a per-step computation.
    shifts = torch.tensor(
        [s for a, b, s in blocks for _ in range(b - a)],
        dtype=torch.int64, device=f_data.device,
    ).view(w_shape)                                             # [.., Nv(axis), ..]
    idx_shape = [1, 1, 1, 1]
    idx_shape[axis] = n
    rows = torch.arange(n, device=f_data.device).view(idx_shape) - shifts

    out = torch.zeros_like(f_data)
    for k, o in enumerate(static_stencil_offsets(stencil_offsets)):
        idx = torch.remainder(rows - o, n).expand(f_data.shape)
        out = out + torch.gather(f_data, axis, idx) * W[k].reshape(w_shape)
    return out


def build_v_tap_weights(E, dt, dv, S, stencil_offsets):
    """
    Collapse (integer shift, stencil tap) onto the static V-kick window.

    With ``d = E * dt / dv``, ``s = floor(d)`` and Lagrange weights
    ``w_k(alpha)``, the tap index ``m = s + o_k`` stays inside the static
    window ``[-S-2, S+2]`` whenever ``-S <= d < S``. The per-point weights
    are accumulated onto that window.

    Parameters
    ----------
    E : torch.Tensor
        Electric field (advection velocity per spatial point).
        Shape: (Nx, Ny)
    dt : float
        Time step of the kick.
    dv : float
        Velocity grid spacing.
    S : int
        Static window bound; the result is exact while ``|E*dt/dv| < S``.
    stencil_offsets : torch.Tensor
        Interpolation stencil offsets. Shape: (6,) (must be concrete; see
        ``static_stencil_offsets``).

    Returns
    -------
    torch.Tensor
        Tap weight matrix. Shape: (2S+5, Nx, Ny), taps ordered by
        ascending ``m`` in ``[-S-2, S+2]``.
    """
    d = (E * dt) / dv
    s = torch.floor(d)
    alpha = d - s
    s = s.to(torch.long)
    W6 = lagrange5_weights(alpha)  # (6, Nx, Ny)

    taps = range(-(S + 2), S + 3)  # m in [-S-2, S+2]
    rows = []
    for m in taps:
        acc = torch.zeros_like(alpha)
        for k, o in enumerate(static_stencil_offsets(stencil_offsets)):
            acc = acc + (s == m - o).to(W6.dtype) * W6[k]
        rows.append(acc)
    return torch.stack(rows, dim=0)  # (2S+5, Nx, Ny)


def advect_v_static(f_data, E, dt, dv, S, stencil_offsets, axis):
    """
    Dirichlet Vx/Vy kick as 2S+5 static shifted FMAs on a zero-padded tensor.

    Applies the per-spatial-point banded operator with every tap a static
    narrow of the zero-padded tensor (zero padding realizes the Dirichlet
    boundary condition exactly), so no data-dependent memory access.
    Dirichlet BC only (there is no ``periodic`` argument). Mirrors
    ``advect_v_static`` in the JAX vlasov2D2V.py.

    Parameters
    ----------
    f_data : torch.Tensor
        Distribution function. Shape: (Nx, Ny, Nvx, Nvy)
    E : torch.Tensor
        Electric field component (``Ex`` or ``Ey``). Shape: (Nx, Ny)
    dt : float
        Time step of the kick.
    dv : float
        Velocity grid spacing along the kick axis.
    S : int
        Static window bound (see ``build_v_tap_weights``).
    stencil_offsets : torch.Tensor
        Interpolation stencil offsets. Shape: (6,) (must be concrete; see
        ``static_stencil_offsets``).
    axis : int
        Velocity axis to advect along (2=vx with Ex, 3=vy with Ey).

    Returns
    -------
    torch.Tensor
        Advected distribution function, same shape as ``f_data``.
    """
    Wt = build_v_tap_weights(E, dt, dv, S, stencil_offsets)
    P = S + 2
    n_points = f_data.shape[axis]
    # F.pad takes (left, right) pairs ordered from the last dim backwards
    pad = [0] * (2 * f_data.ndim)
    pad[2 * (f_data.ndim - 1 - axis)] = P
    pad[2 * (f_data.ndim - 1 - axis) + 1] = P
    g = torch.nn.functional.pad(f_data, pad)  # zero padding == Dirichlet BC
    out = torch.zeros_like(f_data)
    for q, m in enumerate(range(-P, P + 1)):
        sliced = g.narrow(axis, P - m, n_points)
        out = out + Wt[q][:, :, None, None] * sliced
    return out


def check_v_window(E, dt, dv, S):
    """
    Return the maximum kick displacement ``max |E*dt/dv|`` in cells.

    The static tap window of the V kick is exact only while this value
    stays below ``S``; call this periodically in production to guard the
    assumption.

    Parameters
    ----------
    E : torch.Tensor
        Electric field component. Shape: (Nx, Ny)
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
    return float((E * dt / dv).abs().max())

@torch.compile
def vlasov_step_impl(f, f0, dt, grid_x, grid_y, grid_vx, grid_vy,
                     grid_kx, grid_ky, grid_inv_ksq,
                     grid_x_indices, grid_y_indices, grid_vx_indices, grid_vy_indices,
                     grid_stencil_offsets,
                     grid_dx, grid_dy, grid_dvx, grid_dvy,
                     grid_Nx, grid_Ny,
                     physics_mode):
    """
    Functional stateless step for torch.compile.
    Performs one Strang-split Vlasov-Poisson step.
    """
    # Advect along X, Y (dt/2)
    # vx varies along axis 2 -> shape [1, Nvx, 1] broadcasts to batch (Ny, Nvx, Nvy)
    f = advect_1d(
        f, grid_vx[None, :, None], 0, dt/2.0, grid_dx,
        periodic=True, point_indices=grid_x_indices, stencil_offsets=grid_stencil_offsets
    )
    # vy varies along axis 3 -> shape [1, 1, Nvy] broadcasts to batch (Nx, Nvx, Nvy)
    f = advect_1d(
        f, grid_vy[None, None, :], 1, dt/2.0, grid_dy,
        periodic=True, point_indices=grid_y_indices, stencil_offsets=grid_stencil_offsets
    )

    # Solve Poisson's equation to get Ex, Ey, rho, phi
    if physics_mode:
        Ex, Ey, rho, phi = solve_poisson_real(f, grid_kx, grid_ky, grid_inv_ksq, grid_dvx, grid_dvy)
    else:
        Ex = torch.zeros((grid_Nx, grid_Ny), device=f.device)
        Ey = torch.zeros((grid_Nx, grid_Ny), device=f.device)
        rho = torch.zeros((grid_Nx, grid_Ny), device=f.device)
        phi = torch.zeros((grid_Nx, grid_Ny), device=f.device)

    # Advect along Vx, Vy (dt)
    # Ex[Nx,Ny] -> shape [Nx, Ny, 1] broadcasts to batch (Nx, Ny, Nvy)
    f = advect_1d(
        f, Ex[:, :, None], 2, dt, grid_dvx,
        periodic=False, point_indices=grid_vx_indices, stencil_offsets=grid_stencil_offsets
    )
    # Ey[Nx,Ny] -> shape [Nx, Ny, 1] broadcasts to batch (Nx, Ny, Nvx)
    f = advect_1d(
        f, Ey[:, :, None], 3, dt, grid_dvy,
        periodic=False, point_indices=grid_vy_indices, stencil_offsets=grid_stencil_offsets
    )

    # Advect along X, Y (dt/2)
    f = advect_1d(
        f, grid_vy[None, None, :], 1, dt/2.0, grid_dy,
        periodic=True, point_indices=grid_y_indices, stencil_offsets=grid_stencil_offsets
    )
    f = advect_1d(
        f, grid_vx[None, :, None], 0, dt/2.0, grid_dx,
        periodic=True, point_indices=grid_x_indices, stencil_offsets=grid_stencil_offsets
    )

    return f, rho, phi


def vlasov_step_matrix_diag(f, f0, dt, grid_x, grid_y, grid_vx, grid_vy,
                            grid_kx, grid_ky, grid_inv_ksq,
                            grid_x_indices, grid_y_indices, grid_vx_indices, grid_vy_indices,
                            grid_stencil_offsets,
                            grid_dx, grid_dy, grid_dvx, grid_dvy,
                            grid_Nx, grid_Ny,
                            physics_mode):
    """
    Same splitting scheme as `vlasov_step_impl`, but using the gather-free
    `advect_1d_matrix_diag` kernel instead of `advect_1d`
    (`advect_1d_vectorized`). Mirrors `vlasov_step_matrix_diag` in
    vlasov1D1V.py, generalized to the 4D (x, y, vx, vy) distribution
    function via the same axis-permuting wrapper used by `advect_1d`.

    grid_x_indices, grid_y_indices, grid_vx_indices, grid_vy_indices,
    grid_stencil_offsets are unused here (kept only so this function is a
    drop-in replacement for `vlasov_step_impl`).
    """
    # Advect along X, Y (dt/2)
    f = advect_1d_matrix_diag(f, grid_vx[None, :, None], 0, dt / 2.0, grid_dx, stencil_offsets=grid_stencil_offsets, periodic=True)
    f = advect_1d_matrix_diag(f, grid_vy[None, None, :], 1, dt / 2.0, grid_dy, stencil_offsets=grid_stencil_offsets, periodic=True)

    # Solve Poisson's equation to get Ex, Ey, rho, phi
    if physics_mode:
        Ex, Ey, rho, phi = solve_poisson_real(f, grid_kx, grid_ky, grid_inv_ksq, grid_dvx, grid_dvy)
    else:
        Ex = torch.zeros((grid_Nx, grid_Ny), device=f.device)
        Ey = torch.zeros((grid_Nx, grid_Ny), device=f.device)
        rho = torch.zeros((grid_Nx, grid_Ny), device=f.device)
        phi = torch.zeros((grid_Nx, grid_Ny), device=f.device)

    # Advect along Vx, Vy (dt)
    f = advect_1d_matrix_diag(f, Ex[:, :, None], 2, dt, grid_dvx, stencil_offsets=grid_stencil_offsets, periodic=False)
    f = advect_1d_matrix_diag(f, Ey[:, :, None], 3, dt, grid_dvy, stencil_offsets=grid_stencil_offsets, periodic=False)

    # Advect along X, Y (dt/2)
    f = advect_1d_matrix_diag(f, grid_vy[None, None, :], 1, dt / 2.0, grid_dy, stencil_offsets=grid_stencil_offsets, periodic=True)
    f = advect_1d_matrix_diag(f, grid_vx[None, :, None], 0, dt / 2.0, grid_dx, stencil_offsets=grid_stencil_offsets, periodic=True)

    return f, rho, phi


@torch.compile
def vlasov_step_gather_free_impl(f, dt, W_x, W_y, blocks_x, blocks_y, stencil_offsets,
                                 grid_kx, grid_ky, grid_inv_ksq,
                                 grid_dvx, grid_dvy,
                                 grid_Nx, grid_Ny,
                                 physics_mode, S):
    """
    Compiled core of the solver-2 step. Compiles as a single graph with no
    graph breaks: everything data-dependent was hoisted to the caller —
    ``blocks_x``/``blocks_y`` are Python lists of int tuples, ``W_x``/``W_y``
    are precomputed weight tensors, and ``stencil_offsets`` is a tuple of
    Python ints (never a tensor, whose conversion would graph-break). All
    shifts inside are compile-time constants, so the advections lower to
    constant-index gathers and static narrows with no data-dependent
    memory access.

    Parameters mirror `vlasov_step_gather_free`, which precomputes the
    static data and delegates here.
    """
    # Advect along X, Y (dt/2)
    f = advect_x_static(f, W_x, blocks_x, stencil_offsets, axis=0)
    f = advect_x_static(f, W_y, blocks_y, stencil_offsets, axis=1)

    # Solve Poisson's equation to get Ex, Ey, rho, phi
    if physics_mode:
        Ex, Ey, rho, phi = solve_poisson_real(f, grid_kx, grid_ky, grid_inv_ksq, grid_dvx, grid_dvy)
    else:
        Ex = torch.zeros((grid_Nx, grid_Ny), device=f.device)
        Ey = torch.zeros((grid_Nx, grid_Ny), device=f.device)
        rho = torch.zeros((grid_Nx, grid_Ny), device=f.device)
        phi = torch.zeros((grid_Nx, grid_Ny), device=f.device)

    # Advect along Vx, Vy (dt)
    f = advect_v_static(f, Ex, dt, grid_dvx, S, stencil_offsets, axis=2)
    f = advect_v_static(f, Ey, dt, grid_dvy, S, stencil_offsets, axis=3)

    # Advect along X, Y (dt/2)
    f = advect_x_static(f, W_y, blocks_y, stencil_offsets, axis=1)
    f = advect_x_static(f, W_x, blocks_x, stencil_offsets, axis=0)

    return f, rho, phi


def vlasov_step_gather_free(f, f0, dt, grid_x, grid_y, grid_vx, grid_vy,
                            grid_kx, grid_ky, grid_inv_ksq,
                            grid_x_indices, grid_y_indices, grid_vx_indices, grid_vy_indices,
                            grid_stencil_offsets,
                            grid_dx, grid_dy, grid_dvx, grid_dvy,
                            grid_Nx, grid_Ny,
                            physics_mode, S=1):
    """
    Same splitting scheme as `vlasov_step_impl`, but with every shift a
    compile-time constant so the advections contain no data-dependent
    memory access at all (gather indices, where used, depend only on the
    constant grid and dt, never on the evolving data). Mirrors
    `vlasov_step_gather_free` in the JAX vlasov2D2V.py and the PyTorch
    vlasov1D1V.py.

    The X/Y-drift shifts are time-constant, so the integer shift and the
    6-tap Lagrange stencil are folded into 6 constant-index gathers per
    drift that fuse into one kernel (`advect_x_static`). The Vx/Vy kicks
    collapse (integer shift, stencil tap) onto a static window of ``2S+5`` shifted
    FMAs (`advect_v_static`), exact while ``|E*dt/dv| < S`` (see
    `check_v_window`).

    This drop-in wrapper performs the numpy/host precomputation (which must
    stay outside torch.compile) and delegates to the compiled
    `vlasov_step_gather_free_impl`. The Vlasov class hoists the
    precomputation out of the step loop entirely (see `Vlasov.__init__`);
    this per-call form exists so the function stays a drop-in replacement
    for `vlasov_step_impl` — the precompute only touches (Nv,)-sized
    host arrays and is negligible next to the 4D advections.

    grid_x_indices, grid_y_indices, grid_vx_indices, grid_vy_indices are
    unused here (kept only so this function is a drop-in replacement for
    `vlasov_step_impl`). `S` is the static window bound of the V kicks.
    """
    # Precomputed from the concrete grid_vx/grid_vy: static Python-int
    # shifts and constant weights (the drift displacements are
    # time-constant).
    blocks_x, W_x = precompute_x_drift(grid_vx, dt/2.0, grid_dx, f.dtype)
    blocks_y, W_y = precompute_x_drift(grid_vy, dt/2.0, grid_dy, f.dtype)
    offsets = static_stencil_offsets(grid_stencil_offsets)

    return vlasov_step_gather_free_impl(
        f, dt, W_x, W_y, blocks_x, blocks_y, offsets,
        grid_kx, grid_ky, grid_inv_ksq,
        grid_dvx, grid_dvy,
        grid_Nx, grid_Ny,
        physics_mode, S)


def export_vlasov_step_dynamo_report(
    solver: "Vlasov",
    state: SimulationState,
    output_path: pathlib.Path,
) -> None:
    g = solver.grid
    dynamo.reset()
    explain_target = getattr(solver._step_fn, "_torchdynamo_orig_callable", solver._step_fn)
    explain_output = dynamo.explain(explain_target)(
        state.variables.fn,
        state.variables.f0,
        solver.dt,
        g.x,
        g.y,
        g.vx,
        g.vy,
        g.kx,
        g.ky,
        g.inv_ksq,
        g.x_indices,
        g.y_indices,
        g.vx_indices,
        g.vy_indices,
        g.stencil_offsets,
        g.dx,
        g.dy,
        g.dvx,
        g.dvy,
        g.Nx,
        g.Ny,
        solver.physics_mode,
    )
    dynamo_report = str(explain_output)
    output_path.write_text(dynamo_report)


def export_vlasov_step_fx_graph(
    solver: "Vlasov",
    state: SimulationState,
    output_path: pathlib.Path,
) -> None:
    """Capture the FX graph(s) TorchDynamo traces for the step function, before any lowering."""
    g = solver.grid
    dynamo.reset()
    step_fn = getattr(solver._step_fn, "_torchdynamo_orig_callable", solver._step_fn)
    graphs = []

    def capture_backend(gm: torch.fx.GraphModule, example_inputs):
        graphs.append(gm)
        return gm.forward  # run eagerly, no lowering

    compiled = torch.compile(step_fn, backend=capture_backend)
    with torch.no_grad():
        compiled(
            state.variables.fn,
            state.variables.f0,
            solver.dt,
            g.x,
            g.y,
            g.vx,
            g.vy,
            g.kx,
            g.ky,
            g.inv_ksq,
            g.x_indices,
            g.y_indices,
            g.vx_indices,
            g.vy_indices,
            g.stencil_offsets,
            g.dx,
            g.dy,
            g.dvx,
            g.dvy,
            g.Nx,
            g.Ny,
            solver.physics_mode,
        )

    text = []
    for i, gm in enumerate(graphs):
        text.append(f"# ===== Dynamo FX graph {i} (readable) =====\n")
        text.append(gm.print_readable(print_output=False))
        text.append(f"\n# ===== Dynamo FX graph {i} (node table) =====\n")
        text.append(str(gm.graph))
        text.append("\n")
    output_path.write_text("".join(text))
    dynamo.reset()

class Vlasov:
    dt: float = 0.05
    diag_steps: int = 10
    out_dir: str = "data"
    physics_mode: bool = False
    epsilon: float = 0.001
    device: torch.device = torch.device(
        'cuda' if torch.cuda.is_available()
        else 'xpu' if hasattr(torch, 'xpu') and torch.xpu.is_available()
        else 'cpu'
    )
    dtype: torch.dtype = torch.float32

    def __init__(self, Nx=32, Ny=32, Nvx=32, Nvy=32,
                 Lx=2.0*math.pi, Ly=2.0*math.pi, Vx_max=6.0, Vy_max=6.0,
                 nbiter=10, diag_steps=10, dt=0.05,
                 out_dir="data", physics_mode=False, epsilon=0.001, dtype: str = "float32",
                 solver: int = 0):
        """
        Initializes the Vlasov solver with the given parameters.

        Parameters
        ----------
        solver : int
            Type of stepping kernel to use.
            0: vlasov_step_impl (gather-based advect_1d_vectorized)
            1: vlasov_step_matrix_diag (gather-free advect_1d_matrix_diag)
            2: vlasov_step_gather_free (static shifts, no data-dependent
               memory access: advect_x_static / advect_v_static)
        """
        self.output_log = ""
        self.dtype = torch.float32 if dtype == "float32" else torch.float64
        self.grid = Grid.create(Nx, Ny, Nvx, Nvy, Lx, Ly, Vx_max, Vy_max, device=self.device, dtype=self.dtype)
        self.nbiter = nbiter
        self.diag_steps = diag_steps
        self.dt = dt
        self.out_dir = out_dir
        self.physics_mode = physics_mode
        self.epsilon = epsilon

        solver_fns = {
            0: vlasov_step_impl,
            1: vlasov_step_matrix_diag,
            2: vlasov_step_gather_free,
        }
        solver_names = {
            0: "vlasov_step_impl",
            1: "vlasov_step_matrix_diag",
            2: "vlasov_step_gather_free",
        }
        self.solver = solver
        self.solver_type = solver_names[solver]
        self._step_fn = solver_fns[solver]

        if solver == 2:
            # Hoist the numpy/host precomputation of the static drift data
            # out of the step loop: the drift displacements depend only on
            # the (constant) grid and dt, so blocks/weights are computed
            # once here and the per-step function reduces to the compiled
            # `vlasov_step_gather_free_impl`, which traces as a single
            # graph with no graph breaks.
            g = self.grid
            blocks_x, W_x = precompute_x_drift(g.vx, self.dt / 2.0, g.dx, self.dtype)
            blocks_y, W_y = precompute_x_drift(g.vy, self.dt / 2.0, g.dy, self.dtype)
            offsets = static_stencil_offsets(g.stencil_offsets)

            def _step_gather_free(f, f0, dt, grid_x, grid_y, grid_vx, grid_vy,
                                  grid_kx, grid_ky, grid_inv_ksq,
                                  grid_x_indices, grid_y_indices, grid_vx_indices, grid_vy_indices,
                                  grid_stencil_offsets,
                                  grid_dx, grid_dy, grid_dvx, grid_dvy,
                                  grid_Nx, grid_Ny,
                                  physics_mode):
                return vlasov_step_gather_free_impl(
                    f, dt, W_x, W_y, blocks_x, blocks_y, offsets,
                    grid_kx, grid_ky, grid_inv_ksq,
                    grid_dvx, grid_dvy,
                    grid_Nx, grid_Ny,
                    physics_mode, 1)

            self._step_fn = _step_gather_free

        if not pathlib.Path(self.out_dir).exists():
            pathlib.Path(self.out_dir).mkdir(parents=True)

        num_steps = self.nbiter // self.diag_steps
        message  = f"PyTorch version: {torch.__version__}\n"
        message += f"Starting simulation on {self.device} with {self.grid.x.dtype} precision "
        message += "with Poisson solver" if self.physics_mode else "without Poisson solver"
        message += f" and solver type {self.solver_type}."
        self._append_log(message)
        self._append_log(f"Grid: {Nx}x{Ny}x{Nvx}x{Nvy}, Steps: {self.nbiter}, chunks: {num_steps}, diag_freq: {self.diag_steps}")

    def _append_log(self, message: str) -> None:
        self.output_log += f"{message}\n"

    def initialize(self) -> SimulationState:
        """Creates the initial SimulationState."""
        g = self.grid

        x_mesh = g.x[:, None, None, None]   # [Nx, 1, 1, 1]
        y_mesh = g.y[None, :, None, None]    # [1, Ny, 1, 1]
        vx_mesh = g.vx[:, None]              # [Nvx, 1]
        vy_mesh = g.vy[None, :]              # [1, Nvy]

        if self.physics_mode:
            kx_mode = 1 * 2.0 * math.pi / g.Lx
            ky_mode = 1 * 2.0 * math.pi / g.Ly
            energy = 0.5 * (vx_mesh**2 + vy_mesh**2)
            f0 = (1.0 / math.sqrt(2.0 * math.pi)) * torch.exp(-energy)
            f_data = (1.0 + self.epsilon * torch.cos(kx_mode * x_mesh) * torch.cos(ky_mode * y_mesh)) * f0[None, None, :, :]
        else:
            x0, y0 = g.Lx / 2.0, g.Ly / 2.0
            vx0, vy0 = 0.0, 0.0
            sigma_x = g.Lx / 10.0
            sigma_v = g.Vx_max / 4.0
            dx2 = (x_mesh - x0)**2 / sigma_x**2
            dy2 = (y_mesh - y0)**2 / sigma_x**2
            vx2 = (vx_mesh[None, None, :, :] - vx0)**2 / sigma_v**2
            vy2 = (vy_mesh[None, None, :, :] - vy0)**2 / sigma_v**2
            f_data = torch.exp(-0.5 * (dx2 + dy2 + vx2 + vy2))
            f0 = torch.zeros((g.Nvx, g.Nvy), device=self.device, dtype=self.dtype)

        *_, rho, phi = solve_poisson_real(f_data, g.kx, g.ky, g.inv_ksq, g.dvx, g.dvy)

        state = SimulationState(
            field=Field(rho, phi),
            variables=Variables(fn=f_data, f0=f0),
            t=0.0,
            step=0
        )
        self.save_diag(state)
        return state

    def save_diag(self, state: SimulationState) -> None:
        """Save a snapshot of the state to a netCDF file."""
        f_np = state.variables.fn.detach().cpu().numpy()
        f0_np = state.variables.f0.detach().cpu().numpy()
        rho_np = state.field.rho.detach().cpu().numpy()
        phi_np = state.field.phi.detach().cpu().numpy()

        ds = xr.Dataset(
            data_vars={
                "f": (("time", "x", "y", "vx", "vy"), f_np[None, ...]),
                "f0": (("time", "vx", "vy"), f0_np[None, ...]),
                "rho": (("time", "x", "y"), rho_np[None, ...]),
                "phi": (("time", "x", "y"), phi_np[None, ...]),
            },
            coords={
                "time": np.array([float(state.t)]),
                "x": self.grid.x.cpu().numpy(),
                "y": self.grid.y.cpu().numpy(),
                "vx": self.grid.vx.cpu().numpy(),
                "vy": self.grid.vy.cpu().numpy(),
            },
            attrs={
                "step": int(state.step),
                "dt": self.dt,
                "Lx": self.grid.Lx,
                "Ly": self.grid.Ly,
                "Vx_max": self.grid.Vx_max,
                "Vy_max": self.grid.Vy_max,
                "physics_mode": int(self.physics_mode),
            }
        )

        filename = pathlib.Path(self.out_dir) / f"field_{int(state.step):06d}.nc"
        ds.to_netcdf(filename)

    def run(self, state: SimulationState) -> SimulationState:
        """Run the simulation loop."""
        g = self.grid

        # Main Loop
        diag_counter = 0
        rho, phi = state.field.rho, state.field.phi

        f = state.variables.fn
        synchronize(self.device)
        for i in range(1, self.nbiter + 1):
            f, rho, phi = self._step_fn(
                f, state.variables.f0, self.dt,
                g.x, g.y, g.vx, g.vy,
                g.kx, g.ky, g.inv_ksq,
                g.x_indices, g.y_indices, g.vx_indices, g.vy_indices, g.stencil_offsets,
                g.dx, g.dy, g.dvx, g.dvy,
                g.Nx, g.Ny,
                self.physics_mode
            )
            state.t += self.dt
            state.step += 1

            diag_counter += 1
            if diag_counter >= self.diag_steps:
                synchronize(self.device)

                current_state = SimulationState(
                    field=Field(rho, phi),
                    variables=Variables(fn=f, f0=state.variables.f0),
                    t=state.t,
                    step=state.step
                )
                self.save_diag(current_state)
                diag_counter = 0

        synchronize(self.device)

        return SimulationState(
            field=Field(rho, phi),
            variables=Variables(fn=f, f0=state.variables.f0),
            t=state.t,
            step=state.step
        )

if __name__ == "__main__":
    parser = argparse.ArgumentParser(add_help=True)
    parser.add_argument('-nx', nargs='?', type=int, default=32,
                        help="Number of grid points in x")
    parser.add_argument('-ny', nargs='?', type=int, default=32,
                        help="Number of grid points in y")
    parser.add_argument('-nvx', nargs='?', type=int, default=32,
                        help="Number of grid points in vx")
    parser.add_argument('-nvy', nargs='?', type=int, default=32,
                        help="Number of grid points in vy")
    parser.add_argument('-lx', nargs='?', type=float, default=4.0*math.pi,
                        help="Physical domain length in x")
    parser.add_argument('-ly', nargs='?', type=float, default=4.0*math.pi,
                        help="Physical domain length in y")
    parser.add_argument('-Vx_max', nargs='?', type=float, default=5.0,
                        help="Maximum velocity in vx")
    parser.add_argument('-Vy_max', nargs='?', type=float, default=5.0,
                        help="Maximum velocity in vy")
    parser.add_argument('-nbiter', nargs='?', type=int, default=10,
                        help="Total number of simulation iterations")
    parser.add_argument('-diag_steps', nargs='?', type=int, default=10,
                        help="Number of steps between diagnostics output")
    parser.add_argument('-dt', nargs='?', type=float, default=0.05,
                        help="Time step size")
    parser.add_argument('-out_dir', nargs='?', type=str, default='data_python',
                        help="Directory for diagnostic output files")
    parser.add_argument('-physics_mode', action='store_true', default=False,
                        help='Enable physics mode (Landau damping)')
    parser.add_argument('-epsilon', nargs='?', type=float, default=0.001,
                        help="Amplitude of initial perturbation")
    parser.add_argument('-dtype', type=str, default='float64',
                        choices=['float32', 'float64'], help='Data type')
    parser.add_argument('-solver', nargs='?', type=int, default=0, choices=[0, 1, 2],
                        help="Solver type: 0=vlasov_step_impl (gather), 1=vlasov_step_matrix_diag (gather-free), "
                             "2=vlasov_step_gather_free (static shifts)")
    args = parser.parse_args()

    solver = Vlasov(
        Nx=args.nx, Ny=args.ny, Nvx=args.nvx, Nvy=args.nvy,
        Lx=args.lx, Ly=args.ly, Vx_max=args.Vx_max, Vy_max=args.Vy_max,
        nbiter=args.nbiter, diag_steps=args.diag_steps,
        dt=args.dt,
        out_dir=args.out_dir,
        physics_mode=args.physics_mode,
        epsilon=args.epsilon,
        dtype=args.dtype,
        solver=args.solver,
    )

    dynamo_dir = pathlib.Path("dynamo_graphs")
    dynamo_dir.mkdir(parents=True, exist_ok=True)
    dynamo_export_path = dynamo_dir / f"{solver.solver_type}.txt"
    fx_graph_export_path = dynamo_dir / f"{solver.solver_type}_fx_graph.txt"

    # Create Initial State
    initial_state = solver.initialize()
    export_vlasov_step_dynamo_report(solver, initial_state, dynamo_export_path)
    export_vlasov_step_fx_graph(solver, initial_state, fx_graph_export_path)

    # Warm-up torch.compile
    solver._append_log("Warming up torch.compile...")
    _ = solver.run(initial_state)
    solver._append_log("Compilation done. Starting timed run...")

    initial_state = solver.initialize()

    # Reset peak memory statistics so the compilation phase is excluded
    reset_peak_memory(solver.device)

    # Memory before benchmark
    mem_before = get_memory_stats(solver.device)

    # Timed run
    start = time.time()
    final_state = solver.run(initial_state)
    elapsed = time.time() - start

    # Memory after benchmark
    mem_after = get_memory_stats(solver.device)

    solver._append_log(f'Elapsed time: {elapsed:.4f} [s]')

    if mem_before is not None:
        message = "\nMemory statistics\n"
        message += (
            f"Allocated before benchmark : "
            f"{format_memory(mem_before['allocated'])}\n"
        )
        message += (
            f"Reserved before benchmark  : "
            f"{format_memory(mem_before['reserved'])}\n"
        )
        message += (
            f"Peak allocated             : "
            f"{format_memory(mem_after['peak_allocated'])}\n"
        )
        message += (
            f"Peak reserved              : "
            f"{format_memory(mem_after['peak_reserved'])}\n"
        )
        solver._append_log(message)

    print_memory_summary(solver.device, pathlib.Path.cwd() / f"vlp2d_2v_{args.dtype}_memory.txt")

    output_path = pathlib.Path.cwd() / f"vlp2d_2v_{args.dtype}.txt"
    output_path.write_text(solver.output_log)
