import os
# Workaround for Triton compilation on aarch64 with CC=nvc
if os.environ.get("CC") and "nvc" in os.environ["CC"]:
    os.environ["CC"] = "gcc"
if os.environ.get("CXX") and "nvc" in os.environ["CXX"]:
    os.environ["CXX"] = "g++"

import platform
import torch
import torch._dynamo as dynamo
import math
import argparse
import time
import pathlib
import xarray as xr
import numpy as np
from dataclasses import dataclass

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
    Nx: int
    Nv: int
    L: float
    V_max: float
    dx: float
    dv: float
    x: torch.Tensor
    v: torch.Tensor
    inv_kx: torch.Tensor
    inv_kx_sq: torch.Tensor
    x_indices: torch.Tensor
    v_indices: torch.Tensor
    x_batch_offsets: torch.Tensor
    v_batch_offsets: torch.Tensor
    stencil_offsets: torch.Tensor

    @classmethod
    def create(cls, Nx, Nv, L, V_max, device='cpu', dtype=torch.float32):
        dx = L / Nx
        dv = 2 * V_max / (Nv - 1)

        # Endpoint=False for periodic X
        x = torch.linspace(0, L, Nx + 1, device=device, dtype=dtype)[:-1]
        # Endpoint=True for V
        v = torch.linspace(-V_max, V_max, Nv, device=device, dtype=dtype)

        # Precompute FFT k vectors
        # PyTorch rfftfreq returns [0, 1, ..., N/2] / (d*N)
        kx = 2 * math.pi * torch.fft.rfftfreq(Nx, d=dx, device=device, dtype=dtype)
        # Avoid division by zero at k=0
        inv_kx = torch.where(kx == 0, torch.tensor(0.0, device=device, dtype=dtype), 1.0 / kx)
        inv_kx_sq = inv_kx * inv_kx

        index_dtype = torch.int64
        x_indices = torch.arange(Nx, device=device, dtype=dtype)
        v_indices = torch.arange(Nv, device=device, dtype=dtype)
        x_batch_offsets = (torch.arange(Nv, device=device, dtype=index_dtype) * Nx).view(Nv, 1, 1)
        v_batch_offsets = (torch.arange(Nx, device=device, dtype=index_dtype) * Nv).view(Nx, 1, 1)
        stencil_offsets = torch.arange(-2, 4, device=device, dtype=index_dtype)

        return Grid(
            Nx, Nv, L, V_max, dx, dv,
            x, v, inv_kx, inv_kx_sq,
            x_indices, v_indices, x_batch_offsets, v_batch_offsets, stencil_offsets,
        )

    def to(self, device) -> "Grid":
        self.x = self.x.to(device)
        self.v = self.v.to(device)
        self.inv_kx = self.inv_kx.to(device)
        self.inv_kx_sq = self.inv_kx_sq.to(device)
        self.x_indices = self.x_indices.to(device)
        self.v_indices = self.v_indices.to(device)
        self.x_batch_offsets = self.x_batch_offsets.to(device)
        self.v_batch_offsets = self.v_batch_offsets.to(device)
        self.stencil_offsets = self.stencil_offsets.to(device)
        return self

@dataclass
class Field:
    """
    Holds the field data (e.g., rho, phi)
    """
    rho: torch.Tensor
    phi: torch.Tensor

@dataclass
class Variables:
    """
    Holds the physical field data (e.g., distribution function f).
    """
    fn: torch.Tensor
    f0: torch.Tensor

@dataclass
class SimulationState:
    """
    The state carried through the simulation loop.
    Contains the field (evolving).
    """
    field: Field
    variables: Variables
    t: float
    step: int

def lagrange5_interp_sum(alpha, gather_vals):
    """
    Evaluates the 6-point, 5th-order Lagrange interpolation sum without materializing
    a [B, N, 6] weights tensor. gather_vals is expected to contain stencil values in
    offsets [-2, -1, 0, 1, 2, 3] along the last dimension.
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
        w0 * gather_vals[..., 0]
        + w1 * gather_vals[..., 1]
        + w2 * gather_vals[..., 2]
        + w3 * gather_vals[..., 3]
        + w4 * gather_vals[..., 4]
        + w5 * gather_vals[..., 5]
    )

def lagrange5_weights(alpha):
    """
    Evaluates the 6-point, 5th-order Lagrange interpolation weights.
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
def advect_1d_vectorized(f_batch, velocities, dt, point_indices, batch_offsets, stencil_offsets, dx, periodic=True):
    """
    Vectorized 1D advection.
    f_batch: [Batch, Grid_Size] (The dimension to advect is the last one)
    velocities: [Batch] or [Batch, Grid_Size] (Speed at each point)
    """
    # Compute Departure Points: x_dep = x - v * dt
    # grid coords are 0, dx, 2dx... -> equivalent to indices 0, 1, 2...
    # We work in "index space" to save ops: idx_dep = idx - (v*dt)/dx
    batch_size, n_points = f_batch.shape

    # Calculate displacement in index units
    # Note: velocities can be scalar per batch (advect X) or vector (advect V with E(x))
    if velocities.ndim == 1:
        # velocities: [Batch] -> Broadcast to [Batch, N]
        velocities = velocities.unsqueeze(1)

    displacement_idx = (velocities * dt) / dx
    depart_idx = point_indices.unsqueeze(0) - displacement_idx

    # Floor and Fraction
    idx_left = torch.floor(depart_idx)
    alpha = depart_idx - idx_left # Fractional part [0, 1)
    idx_left = idx_left.to(torch.long)

    # Get stencil values and interpolate.
    # Flat indexing avoids creating [B, N, N] temporary tensors.
    stencil_indices = idx_left.unsqueeze(-1) + stencil_offsets

    f_batch = f_batch.reshape(-1)

    if periodic:
        safe_indices = torch.remainder(stencil_indices, n_points)
        gather_idx = (batch_offsets + safe_indices).reshape(-1)
        f_vals = f_batch[gather_idx].reshape(batch_size, n_points, 6)
    else:
        valid_mask = (stencil_indices >= 0) & (stencil_indices < n_points)
        safe_indices = torch.clamp(stencil_indices, 0, n_points - 1)
        gather_idx = (batch_offsets + safe_indices).reshape(-1)
        f_vals = f_batch[gather_idx].reshape(batch_size, n_points, 6)
        f_vals = f_vals * valid_mask.to(dtype=f_batch.dtype)

    f_new = lagrange5_interp_sum(alpha, f_vals)
    return f_new

def _roll_columns(x, shifts):
    """
    Rolls each column of x ([N, M]) along dim 0 by its own per-column integer
    shift ([M]), i.e. out[i, j] = x[(i - shifts[j]) % N, j]. Equivalent to
    jax.vmap(jnp.roll, in_axes=(1, 0), out_axes=1)(x, shifts).
    """
    n = x.shape[0]
    row_idx = torch.arange(n, device=x.device).unsqueeze(1) # [N, 1]
    idx = torch.remainder(row_idx - shifts.unsqueeze(0), n) # [N, M]
    return torch.gather(x, 0, idx)

def _roll_rows(x, shifts):
    """
    Rolls each row of x ([N, M]) along dim 1 by its own per-row integer
    shift ([N]), i.e. out[i, j] = x[i, (j - shifts[i]) % M].
    """
    m = x.shape[1]
    col_idx = torch.arange(m, device=x.device).unsqueeze(0) # [1, M]
    idx = torch.remainder(col_idx - shifts.unsqueeze(1), m) # [N, M]
    return torch.gather(x, 1, idx)

def build_v_diag_weights(stencil_offsets, shifts, alpha, n_points):
    """
    Builds a banded weight matrix so that interpolation along V can be
    applied as a per-row circular roll plus a per-row masked weighted sum.

    shifts: [Nx] integer index shift of the departure point.
    alpha: [Nx] fractional part of the departure point.
    n_points: Nv (grid size along the advected axis).
    Returns: [6, Nx, Nv] diagonal (banded) weight matrix.
    """

    W = lagrange5_weights(alpha)
    v = torch.arange(n_points, device=alpha.device)
    total_shifts = stencil_offsets.unsqueeze(1) + shifts.unsqueeze(0)

    source_idx = v.view(1, 1, -1) - total_shifts.unsqueeze(-1)
    valid = (source_idx >= 0) & (source_idx < n_points)
    return valid.to(W.dtype) * W.unsqueeze(-1)

@torch.compile
def advect_1d_matrix_diag(f_batch, velocities, dt, dx, stencil_offsets, periodic=True):
    """
    Batched 1D advection using per-row/column circular rolls plus banded
    Lagrange weights, mirroring the JAX `advect_1d_matrix_diag` solver
    variant (roll-based instead of a single flat gather).

    f_batch: [Nx, Nv]
    velocities: [Nv] (periodic drift along X) or [Nx] (drift along V, with E(x))

    Note: the JAX reference's non-periodic branch rolls by only the fixed
    stencil tap (-2..3) and relies on the per-row integer departure shift
    (`idx_left`) always being 0, which silently breaks once a departure
    point crosses a full grid cell (dt * |E| >= dv). Here the roll shift
    includes `idx_left` (via `_roll_rows`) so the result stays correct for
    any displacement, matching `advect_1d_vectorized` in all cases while
    keeping the same banded-weight structure as the JAX version.
    """
    nx, nv = f_batch.shape
    displacement_idx = velocities * dt / dx

    idx_left = torch.floor(displacement_idx)
    alpha = displacement_idx - idx_left
    idx_left = idx_left.to(torch.long)

    result = torch.zeros_like(f_batch)
    if periodic:
        W = lagrange5_weights(alpha)
        for k in range(6):
            shifts = idx_left + stencil_offsets[k]
            shifted = _roll_columns(f_batch, shifts) # [Nx, Nv]
            result = result + shifted * W[k].unsqueeze(0)
        return result
    else:
        diag_weights = build_v_diag_weights(stencil_offsets, idx_left, alpha, nv) # [Nx, 6, Nv]
        for k in range(6):
            shifts = idx_left + stencil_offsets[k]
            shifted = _roll_rows(f_batch, shifts) # [Nx, Nv]
            result = result + diag_weights[k] * shifted
        return result

def static_stencil_offsets(stencil_offsets):
    """
    Convert stencil offsets to static Python ints for the gather-free kernels.

    Static rolls and slices require concrete shift values (a tensor shift
    would force a data-dependent indexing path). Accepts either a concrete
    tensor or an already-converted int sequence; the tensor form must only
    be used *outside* torch.compile'd code (``.tolist()`` on a tensor would
    graph-break), which is why the compiled solver-2 step receives the
    offsets pre-converted to a tuple.

    stencil_offsets: [6] tensor or length-6 int sequence.
    Returns: tuple of 6 Python ints.
    """
    if isinstance(stencil_offsets, torch.Tensor):
        return tuple(int(o) for o in stencil_offsets.tolist())
    return tuple(int(o) for o in stencil_offsets)

def precompute_x_drift(v, dt, dx, dtype):
    """
    Splits the per-column shift of the periodic X drift into static data.

    The X-drift displacement ``d_j = v_j * dt / dx`` is time-constant, so
    its integer part ``s_j = floor(d_j)`` and fractional part ``alpha_j``
    are constants. Because ``v`` is monotonic, columns with equal ``s_j``
    form contiguous blocks. Displacement is computed with the same dtype
    and operation order as the reference kernels so integer shifts and
    weights match bit-for-bit.

    v: [Nv] velocity coordinates. dt: the Strang half step (dt/2 for X).
    dx: spatial grid spacing. dtype: torch dtype of the simulation.
    Returns: (blocks, W_x) where blocks is a list of static column blocks
    (start, stop, shift) with Python-int shifts, and W_x is the [6, Nv]
    Lagrange weight tensor (tap k corresponds to Grid.stencil_offsets[k]).
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

    W_x = lagrange5_weights(torch.as_tensor(alpha, dtype=dtype, device=v.device))  # [6, Nv]
    return blocks, W_x

def block_roll(f, blocks):
    """
    Rolls each contiguous column block by its static shift along dim 0.

    Realizes the per-column integer shift of the X drift with static
    narrows, rolls and one concatenate only (``torch.roll`` with a
    Python-int shift is a static shuffle — no data-dependent indexing).

    f: [Nx, Nv]. blocks: static column blocks from `precompute_x_drift`.
    Returns: [Nx, Nv] block-rolled tensor.
    """
    if all(shift % f.shape[0] == 0 for _, _, shift in blocks):
        return f
    pieces = [
        torch.roll(f.narrow(1, a, b - a), shifts=shift, dims=0)
        for a, b, shift in blocks
    ]
    return torch.cat(pieces, dim=1) if len(pieces) > 1 else pieces[0]

def advect_x_static(f, W_x, blocks, stencil_offsets):
    """
    Periodic X drift as 6 constant-index gathers fused with the tap FMAs.

    The per-column integer shift and the 6-tap Lagrange stencil are folded
    into one gather index per tap, ``(i - s_j - o_k) % Nx``, where the
    shifts ``s_j`` come from the static ``blocks`` and the tap offsets
    ``o_k`` are Python ints — the indices depend only on the constant grid
    and dt, never on the evolving data, so there is still no data-dependent
    memory access. Under torch.compile the index arithmetic and all 6
    gathers fuse into a single pointwise kernel.

    This replaces the earlier `block_roll` + circular-halo form, which
    reads the same values in the same accumulation order (the output is
    bitwise identical) but emits one roll kernel per shift block — the
    block count grows as ``V_max*dt/(2*dx)`` and reaches ~82 at Nx=4096,
    which made solver 2 launch-bound on GPU (see the nsys profiles in
    measurements/). `block_roll` is kept as the JAX-parity reference.

    f: [Nx, Nv]. W_x: [6, Nv] weights and blocks from `precompute_x_drift`.
    stencil_offsets: [6] tensor or int tuple (must be concrete; see
    `static_stencil_offsets`).
    Returns: [Nx, Nv] advected tensor.
    """
    offsets = static_stencil_offsets(stencil_offsets)
    nx = f.shape[0]

    # Expand the static blocks to a per-column shift vector. ``blocks`` is
    # compile-time constant, so under torch.compile this tensor is a
    # constant baked into the graph, not a per-step computation.
    shifts = torch.tensor(
        [s for a, b, s in blocks for _ in range(b - a)],
        dtype=torch.int64, device=f.device,
    ).unsqueeze(0)                                              # [1, Nv]
    rows = torch.arange(nx, device=f.device).unsqueeze(1) - shifts  # [Nx, Nv]

    out = torch.zeros_like(f)
    for k, o in enumerate(offsets):
        idx = torch.remainder(rows - o, nx)
        out = out + torch.gather(f, 0, idx) * W_x[k].unsqueeze(0)
    return out

def build_v_tap_weights(E, dt, dv, S, stencil_offsets):
    """
    Collapses (integer shift, stencil tap) onto the static V-kick window.

    With ``d_i = E_i * dt / dv``, ``s_i = floor(d_i)`` and Lagrange weights
    ``w_k(alpha_i)``, the tap index ``m = s_i + o_k`` stays inside the
    static window ``[-S-2, S+2]`` whenever ``-S <= d_i < S``. The per-row
    weights are accumulated onto that window.

    E: [Nx] advection velocity per row. S: static window bound; the result
    is exact while ``|E*dt/dv| < S``. stencil_offsets: [6] tensor or int
    tuple (must be concrete; see `static_stencil_offsets`).
    Returns: [2S+5, Nx] tap weight matrix, taps ordered by ascending m.
    """
    d = (E * dt) / dv
    s = torch.floor(d)
    alpha = d - s
    s = s.to(torch.long)
    W6 = lagrange5_weights(alpha)  # [6, Nx]

    taps = range(-(S + 2), S + 3)  # m in [-S-2, S+2]
    rows = []
    for m in taps:
        acc = torch.zeros_like(alpha)
        for k, o in enumerate(static_stencil_offsets(stencil_offsets)):
            acc = acc + (s == m - o).to(W6.dtype) * W6[k]
        rows.append(acc)
    return torch.stack(rows, dim=0)  # [2S+5, Nx]

def advect_v_static(f, E, dt, dv, S, stencil_offsets):
    """
    Dirichlet V kick as 2S+5 static shifted FMAs on a zero-padded tensor.

    Applies the per-row banded operator with every tap a static narrow of
    the zero-padded tensor (zero padding realizes the Dirichlet boundary
    condition exactly), so no data-dependent memory access. Dirichlet BC
    only (there is no `periodic` argument). Mirrors `advect_v_static` in
    the JAX vlasov1D1V.py and the PyTorch vlasov2D2V.py.

    f: [Nx, Nv]. E: [Nx]. S: static window bound (see
    `build_v_tap_weights`). stencil_offsets: [6] tensor or int tuple.
    Returns: [Nx, Nv] advected tensor.
    """
    Wt = build_v_tap_weights(E, dt, dv, S, stencil_offsets)
    P = S + 2
    nv = f.shape[1]
    g = torch.nn.functional.pad(f, (P, P))  # zero padding == Dirichlet BC
    out = torch.zeros_like(f)
    for q, m in enumerate(range(-P, P + 1)):
        sliced = g.narrow(1, P - m, nv)
        out = out + Wt[q].unsqueeze(1) * sliced
    return out

def check_v_window(E, dt, dv, S):
    """
    Returns the maximum kick displacement ``max |E*dt/dv|`` in cells.

    The static tap window of the V kick is exact only while this value
    stays below ``S``; call this periodically in production to guard the
    assumption. ``S`` is unused in the computation; it is kept in the
    signature so call sites document what the value is compared to.
    """
    return float((E * dt / dv).abs().max())

def solve_poisson(f, inv_kx, dv):
    """
    Solves Poisson equation using FFT.
    f: [Nx, Nv]
    Returns: E [Nx], rho [Nx], phi [Nx]
    """
    # Density rho(x) = integral f(x,v) dv
    n = torch.sum(f, dim=1) * dv
    rho = n - 1.0 # Background ion density

    # FFT
    rho_k = torch.fft.rfft(rho)

    # E_k = -i * rho_k / k
    # Phi_k = rho_k / k^2
    E_k = -1j * rho_k * inv_kx
    Phi_k = rho_k * (inv_kx ** 2)

    # IFFT (ensure real output)
    E = torch.fft.irfft(E_k, n=rho.shape[0])
    phi = torch.fft.irfft(Phi_k, n=rho.shape[0])

    return E, rho, phi

def solve_poisson_real(f, inv_kx, inv_kx_sq, dv):
    """
    Solves Poisson equation using FFT.
    f: [Nx, Nv]
    Returns: E [Nx], rho [Nx], phi [Nx]
    """
    # Density rho(x) = integral f(x,v) dv
    n = torch.sum(f, dim=1) * dv
    rho = n - 1.0 # Background ion density

    # FFT
    rho_k = torch.fft.rfft(rho)

    # E_k = -i * rho_k / k  (rewritten without complex ops for torchinductor)
    # Phi_k = rho_k / k^2
    # Decompose into real-valued operations to avoid complex operator warning
    rho_k_real = torch.view_as_real(rho_k)              # [N/2+1, 2]
    inv_kx_sq_2d = inv_kx_sq.unsqueeze(-1)              # [N/2+1, 1]

    # -i * (a + bi) * c = (b*c) + (-a*c)i  → swap & negate imag
    E_k_real = torch.stack([
         rho_k_real[..., 1] * inv_kx,   #  imag(rho_k) * inv_kx
        -rho_k_real[..., 0] * inv_kx,   # -real(rho_k) * inv_kx
    ], dim=-1)
    # (a + bi) * c^2 = a*c^2 + b*c^2 i
    Phi_k_real = rho_k_real * inv_kx_sq_2d

    E_k = torch.view_as_complex(E_k_real)
    Phi_k = torch.view_as_complex(Phi_k_real)

    # IFFT (ensure real output)
    E = torch.fft.irfft(E_k, n=rho.shape[0])
    phi = torch.fft.irfft(Phi_k, n=rho.shape[0])

    return E, rho, phi

def vlasov_step(
    f,
    dt,
    grid_v,
    grid_inv_kx,
    grid_inv_kx_sq,
    x_indices,
    v_indices,
    x_batch_offsets,
    v_batch_offsets,
    stencil_offsets,
    grid_dx,
    grid_dv,
    grid_V_max,
    physics_mode,
):
    """
    Functional stateless step for torch.compile
    """
    # Advect along X (dim 0) (dt/2).
    # We treat V (dim 1) as the batch dimension.
    # Transpose f to [Nv, Nx] so advection happens on the last dim.
    # Velocity for each batch row is grid.v
    f = advect_1d_vectorized(
        f.T, grid_v, dt / 2.0, x_indices, x_batch_offsets, stencil_offsets, grid_dx, periodic=True
    ).T

    # Solve Poisson's equation to get E(x)
    if physics_mode:
        E, rho, phi = solve_poisson_real(f, grid_inv_kx, grid_inv_kx_sq, grid_dv)
    else:
        E = f.new_zeros((f.shape[0],))
        rho = f.new_zeros((f.shape[0],))
        phi = f.new_zeros((f.shape[0],))

    # Advect along V (dim 1) (dt).
    # We treat X (dim 0) as batch dimension.
    # f is already [Nx, Nv].
    # Velocity for each batch row is E (acceleration).
    f = advect_1d_vectorized(
        f, E, dt, v_indices, v_batch_offsets, stencil_offsets, grid_dv, periodic=False
    )

    # Advect along X (dim 0) (dt/2).
    f = advect_1d_vectorized(
        f.T, grid_v, dt / 2.0, x_indices, x_batch_offsets, stencil_offsets, grid_dx, periodic=True
    ).T

    return f, rho, phi

def vlasov_step_matrix_diag(
    f,
    dt,
    grid_v,
    grid_inv_kx,
    grid_inv_kx_sq,
    x_indices,
    v_indices,
    x_batch_offsets,
    v_batch_offsets,
    stencil_offsets,
    grid_dx,
    grid_dv,
    grid_V_max,
    physics_mode,
):
    """
    Same splitting scheme as `vlasov_step`, but using the gather-free
    `advect_1d_matrix_diag` kernel instead of `advect_1d_vectorized`.
    Unlike `advect_1d_vectorized`, this kernel needs no transpose: the
    periodic (X) branch shifts along dim 0 directly, and the non-periodic
    (V) branch shifts along dim 1 directly.
    x_indices, v_indices, x_batch_offsets, v_batch_offsets are unused here
    (kept only so this function is a drop-in replacement for `vlasov_step`).
    """
    # Advect along X (dim 0) (dt/2).
    f = advect_1d_matrix_diag(f, grid_v, dt / 2.0, grid_dx, stencil_offsets, periodic=True)

    # Solve Poisson's equation to get E(x)
    if physics_mode:
        E, rho, phi = solve_poisson_real(f, grid_inv_kx, grid_inv_kx_sq, grid_dv)
    else:
        E = f.new_zeros((f.shape[0],))
        rho = f.new_zeros((f.shape[0],))
        phi = f.new_zeros((f.shape[0],))

    # Advect along V (dim 1) (dt). Velocity for each row is E (acceleration).
    f = advect_1d_matrix_diag(f, E, dt, grid_dv, stencil_offsets, periodic=False)

    # Advect along X (dim 0) (dt/2).
    f = advect_1d_matrix_diag(f, grid_v, dt / 2.0, grid_dx, stencil_offsets, periodic=True)

    return f, rho, phi

@torch.compile
def vlasov_step_gather_free_impl(f, dt, W_x, blocks, stencil_offsets,
                                 grid_inv_kx, grid_inv_kx_sq, grid_dv,
                                 physics_mode, S):
    """
    Compiled core of the solver-2 step. Compiles as a single graph with no
    graph breaks: everything data-dependent was hoisted to the caller —
    ``blocks`` is a Python list of int tuples, ``W_x`` is the precomputed
    weight tensor, and ``stencil_offsets`` is a tuple of Python ints (never
    a tensor, whose conversion would graph-break). All shifts inside are
    compile-time constants, so the advections lower to constant-index
    gathers and static narrows with no data-dependent memory access.

    Parameters mirror `vlasov_step_gather_free`, which precomputes the
    static data and delegates here.
    """
    # Advect along X (dim 0) (dt/2).
    f = advect_x_static(f, W_x, blocks, stencil_offsets)

    # Solve Poisson's equation to get E(x)
    if physics_mode:
        E, rho, phi = solve_poisson_real(f, grid_inv_kx, grid_inv_kx_sq, grid_dv)
    else:
        E = f.new_zeros((f.shape[0],))
        rho = f.new_zeros((f.shape[0],))
        phi = f.new_zeros((f.shape[0],))

    # Advect along V (dim 1) (dt). Velocity for each row is E (acceleration).
    f = advect_v_static(f, E, dt, grid_dv, S, stencil_offsets)

    # Advect along X (dim 0) (dt/2).
    f = advect_x_static(f, W_x, blocks, stencil_offsets)

    return f, rho, phi

def vlasov_step_gather_free(
    f,
    dt,
    grid_v,
    grid_inv_kx,
    grid_inv_kx_sq,
    x_indices,
    v_indices,
    x_batch_offsets,
    v_batch_offsets,
    stencil_offsets,
    grid_dx,
    grid_dv,
    grid_V_max,
    physics_mode,
    S=1,
):
    """
    Same splitting scheme as `vlasov_step`, but with every shift a
    compile-time constant so the advections contain no data-dependent
    memory access at all (gather indices, where used, depend only on the
    constant grid and dt, never on the evolving data). Mirrors
    `vlasov_step_gather_free` in the JAX vlasov1D1V.py and the PyTorch
    vlasov2D2V.py.

    The X-drift shifts are time-constant, so the integer shift and the
    6-tap Lagrange stencil are folded into 6 constant-index gathers that
    fuse into one kernel (`advect_x_static`). The V kick collapses
    (integer shift, stencil tap) onto a static window of ``2S+5`` shifted
    FMAs (`advect_v_static`), exact while ``|E*dt/dv| < S`` (see
    `check_v_window`).

    This drop-in wrapper performs the numpy/host precomputation (which must
    stay outside torch.compile) and delegates to the compiled
    `vlasov_step_gather_free_impl`. The Vlasov class hoists the
    precomputation out of the step loop entirely (see `Vlasov.__init__`);
    this per-call form exists so the function stays a drop-in replacement
    for `vlasov_step` — the precompute only touches (Nv,)-sized host
    arrays and is negligible next to the [Nx, Nv] advections.

    x_indices, v_indices, x_batch_offsets, v_batch_offsets are unused here
    (kept only so this function is a drop-in replacement for `vlasov_step`).
    `S` is the static window bound of the V kick.
    """
    # Precomputed from the concrete grid_v: static Python-int shifts and
    # constant weights (the X-drift displacement is time-constant).
    blocks, W_x = precompute_x_drift(grid_v, dt / 2.0, grid_dx, f.dtype)
    offsets = static_stencil_offsets(stencil_offsets)

    return vlasov_step_gather_free_impl(
        f, dt, W_x, blocks, offsets,
        grid_inv_kx, grid_inv_kx_sq, grid_dv,
        physics_mode, S)

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

    def __init__(
        self,
        Nx: int = 128,
        Nv: int = 128,
        L: float = 2.0 * torch.pi,
        V_max: float = 6.0,
        nbiter: int = 10,
        diag_steps: int = 10,
        dt: float = 0.05,
        out_dir: str = "data",
        physics_mode: bool = False,
        epsilon: float = 0.001,
        dtype: str = "float32",
        solver: int = 0,
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
        dtype : str
            Data type for computations.
        solver : int
            Type of stepping kernel to use.
            0: vlasov_step (gather-based advect_1d_vectorized)
            1: vlasov_step_matrix_diag (gather-free advect_1d_matrix_diag)
            2: vlasov_step_gather_free (static shifts, no data-dependent
               memory access: advect_x_static / advect_v_static)
        """
        self.output_log = ""
        self.dtype = torch.float32 if dtype == "float32" else torch.float64
        self.grid = Grid.create(Nx, Nv, L, V_max, device=self.device, dtype=self.dtype)
        self.nbiter = nbiter
        self.diag_steps = diag_steps
        self.dt = dt
        self.out_dir = out_dir
        self.physics_mode = physics_mode
        self.epsilon = epsilon

        solver_fns = {
            0: vlasov_step,
            1: vlasov_step_matrix_diag,
            2: vlasov_step_gather_free,
        }
        solver_names = {
            0: "vlasov_step",
            1: "vlasov_step_matrix_diag",
            2: "vlasov_step_gather_free",
        }
        self.solver = solver
        self.solver_type = solver_names[solver]
        self._step_fn = solver_fns[solver]

        if solver == 2:
            # Hoist the numpy/host precomputation of the static drift data
            # out of the step loop: the drift displacement depends only on
            # the (constant) grid and dt, so blocks/weights are computed
            # once here and the per-step function reduces to the compiled
            # `vlasov_step_gather_free_impl`, which traces as a single
            # graph with no graph breaks.
            g = self.grid
            blocks, W_x = precompute_x_drift(g.v, self.dt / 2.0, g.dx, self.dtype)
            offsets = static_stencil_offsets(g.stencil_offsets)

            def _step_gather_free(f, dt, grid_v, grid_inv_kx, grid_inv_kx_sq,
                                  x_indices, v_indices,
                                  x_batch_offsets, v_batch_offsets,
                                  stencil_offsets,
                                  grid_dx, grid_dv, grid_V_max,
                                  physics_mode):
                return vlasov_step_gather_free_impl(
                    f, dt, W_x, blocks, offsets,
                    grid_inv_kx, grid_inv_kx_sq, grid_dv,
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
        self._append_log(f"Grid: {self.grid.Nx}x{self.grid.Nv}, Steps: {self.nbiter}, chunks: {num_steps}, diag_freq: {self.diag_steps}")

    def _append_log(self, message: str) -> None:
        self.output_log += f"{message}\n"

    def initialize(self) -> SimulationState:
        """Creates the initial SimulationState with a Gaussian pulse."""
        # Broadcasting for memory efficiency
        x_2d = self.grid.x.unsqueeze(1) # [Nx, 1]
        v_2d = self.grid.v.unsqueeze(0) # [1, Nv]

        if self.physics_mode:
            # Landau Damping
            kx = 2.0 * math.pi / self.grid.L
            # f = (1 + eps*cos(kx*x)) * (1/sqrt(2pi)) * exp(-v^2/2)
            maxwellian = (1.0 / math.sqrt(2.0 * math.pi)) * torch.exp(-0.5 * v_2d**2)
            perturbation = 1.0 + self.epsilon * torch.cos(kx * x_2d)
            f = perturbation * maxwellian
            f0 = maxwellian.squeeze(0) # Store 1D f0
        else:
            # Gaussian Pulse (Validation)
            x0, v0 = self.grid.L / 2.0, 0.0
            sigma_x, sigma_v = self.grid.L / 10.0, self.grid.V_max / 4.0
            f = torch.exp(-0.5 * ((x_2d - x0)**2 / sigma_x**2 + (v_2d - v0)**2 / sigma_v**2))
            f0 = torch.zeros_like(self.grid.v, dtype=self.dtype) # Unused for validation, but we keep the structure

        # Initial Poisson solve
        E, rho, phi = solve_poisson_real(f, self.grid.inv_kx, self.grid.inv_kx_sq, self.grid.dv)
        state = SimulationState(
            field=Field(rho, phi),
            variables=Variables(fn=f, f0=f0),
            t=0.0,
            step=0
        )
        self.save_diag(state)
        return state

    def save_diag(self, state: SimulationState) -> None:
        # Move to CPU/Numpy for IO
        # We use asynchronous transfer if possible, but here we just block for simplicity
        f_np = state.variables.fn.detach().cpu().numpy()
        f0_np = state.variables.f0.detach().cpu().numpy()
        rho_np = state.field.rho.detach().cpu().numpy()
        phi_np = state.field.phi.detach().cpu().numpy()

        ds = xr.Dataset(
            data_vars = {
                "f": (("time", "x", "v"), f_np[None, ...]),
                "f0": (("time", "v"), f0_np[None, ...]),
                "rho": (("time", "x"), rho_np[None, ...]),
                "phi": (("time", "x"), phi_np[None, ...]),
            },
            coords = {
                "time": np.array([float(state.t)]),
                "x": self.grid.x.cpu().numpy(),
                "v": self.grid.v.cpu().numpy(),
            },
            attrs = {
                "step": int(state.step),
                "dt": self.dt,
                "physics_mode": int(self.physics_mode)
            }
        )

        filename = pathlib.Path(self.out_dir) / f"field_{int(state.step):06d}.nc"
        ds.to_netcdf(filename)

    def run(self, state: SimulationState) -> SimulationState:
        g = self.grid

        # Main Loop
        diag_counter = 0
        rho, phi = state.field.rho, state.field.phi

        f = state.variables.fn
        synchronize(self.device)
        for i in range(1, self.nbiter + 1):
            f, rho, phi = self._step_fn(
                f,
                self.dt,
                g.v,
                g.inv_kx,
                g.inv_kx_sq,
                g.x_indices,
                g.v_indices,
                g.x_batch_offsets,
                g.v_batch_offsets,
                g.stencil_offsets,
                g.dx,
                g.dv,
                g.V_max,
                self.physics_mode,
            )
            state.t += self.dt
            state.step += 1

            diag_counter += 1
            if diag_counter >= self.diag_steps:
                # Synchronize before IO to ensure buffers are filled
                synchronize(self.device)

                # Reconstruct state object for saving
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


def export_vlasov_step_dynamo_report(
    solver: Vlasov,
    state: SimulationState,
    output_path: pathlib.Path,
) -> None:
    g = solver.grid
    dynamo.reset()
    explain_output = dynamo.explain(solver._step_fn)(
        state.variables.fn,
        solver.dt,
        g.v,
        g.inv_kx,
        g.inv_kx_sq,
        g.x_indices,
        g.v_indices,
        g.x_batch_offsets,
        g.v_batch_offsets,
        g.stencil_offsets,
        g.dx,
        g.dv,
        g.V_max,
        solver.physics_mode,
    )
    dynamo_report = str(explain_output)
    output_path.write_text(dynamo_report)


def export_vlasov_step_fx_graph(
    solver: Vlasov,
    state: SimulationState,
    output_path: pathlib.Path,
) -> None:
    """Capture the FX graph(s) TorchDynamo traces for the step function, before any lowering."""
    g = solver.grid
    dynamo.reset()
    graphs = []

    def capture_backend(gm: torch.fx.GraphModule, example_inputs):
        graphs.append(gm)
        return gm.forward  # run eagerly, no lowering

    compiled = torch.compile(solver._step_fn, backend=capture_backend)
    with torch.no_grad():
        compiled(
            state.variables.fn,
            solver.dt,
            g.v,
            g.inv_kx,
            g.inv_kx_sq,
            g.x_indices,
            g.v_indices,
            g.x_batch_offsets,
            g.v_batch_offsets,
            g.stencil_offsets,
            g.dx,
            g.dv,
            g.V_max,
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

if __name__ == "__main__":
    parser = argparse.ArgumentParser(add_help=True)
    parser.add_argument('-nx', nargs='?', type=int, default=128,
                        help="Number of grid points in each spatial dimension")
    parser.add_argument('-nv', nargs='?', type=int, default=128,
                        help="Number of grid points in each velocity dimension")
    parser.add_argument('-lx', nargs='?', type=float, default=4.0*torch.pi,
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
    parser.add_argument('-dtype', type=str, default='float64',
                        choices=['float32', 'float64'], help='Data type')
    parser.add_argument('-solver', nargs='?', type=int, default=0, choices=[0, 1, 2],
                        help="Solver type: 0=vlasov_step (gather), 1=vlasov_step_matrix_diag (gather-free), "
                             "2=vlasov_step_gather_free (static shifts)")
    args = parser.parse_args()

    # Initialize solver
    solver = Vlasov(
        Nx=args.nx, Nv=args.nv,
        L=args.lx, V_max=args.vmax,
        nbiter=args.nbiter,
        diag_steps=args.diag_steps,
        dt=args.dt,
        out_dir=args.out_dir,
        physics_mode=args.physics_mode, # Set False for validation, True for Physics
        epsilon=args.epsilon,
        dtype=args.dtype,
        solver=args.solver,
    )

    # Torch dynamo analyses
    dynamo_dir = pathlib.Path("dynamo_graphs")
    dynamo_dir.mkdir(parents=True, exist_ok=True)
    dynamo_export_path = dynamo_dir / f"{solver.solver_type}.txt"
    fx_graph_export_path = dynamo_dir / f"{solver.solver_type}_fx_graph.txt"

    # Create Initial State
    initial_state = solver.initialize()
    export_vlasov_step_dynamo_report(solver, initial_state, dynamo_export_path)
    export_vlasov_step_fx_graph(solver, initial_state, fx_graph_export_path)

    # Warm-up JIT compilation
    solver._append_log("Warming up JIT compilation...")
    _ = solver.run(initial_state)
    solver._append_log("JIT compilation done. Starting timed run...")

    initial_state = solver.initialize()

    # Reset peak memory statistics so the compilation phase is excluded
    reset_peak_memory(solver.device)

    # Memory before benchmark
    mem_before = get_memory_stats(solver.device)

    # Run
    start = time.time()
    state_final = solver.run(initial_state)
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

    print_memory_summary(solver.device, pathlib.Path.cwd() / f"vlp1d_1v_{args.dtype}_memory.txt")

    output_path = pathlib.Path.cwd() / f"vlp1d_1v_{args.dtype}.txt"
    output_path.write_text(solver.output_log)
