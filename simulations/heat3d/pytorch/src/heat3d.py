import os
# Workaround for Triton compilation on aarch64 with CC=nvc
if os.environ.get("CC") and "nvc" in os.environ["CC"]:
    os.environ["CC"] = "gcc"

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
    Ny: int
    Nz: int
    Lx: float
    Ly: float
    Lz: float
    dx: float
    dy: float
    dz: float
    x: torch.Tensor
    y: torch.Tensor
    z: torch.Tensor

    @classmethod
    def create(cls, Nx, Ny, Nz, Lx, Ly, Lz, device='cpu', dtype=torch.float32):
        dx = Lx / Nx
        dy = Ly / Ny
        dz = Lz / Nz

        # Endpoint=False for periodic in X, Y, Z
        x = torch.linspace(0, Lx, Nx+1, device=device, dtype=dtype)[:-1]
        y = torch.linspace(0, Ly, Ny+1, device=device, dtype=dtype)[:-1]
        z = torch.linspace(0, Lz, Nz+1, device=device, dtype=dtype)[:-1]

        return Grid(Nx, Ny, Nz, Lx, Ly, Lz, dx, dy, dz, x, y, z)

    def to(self, device) -> "Grid":
        self.x = self.x.to(device)
        self.y = self.y.to(device)
        self.z = self.z.to(device)
        return self

@dataclass
class Variables:
    """
    Holds the physical field data
    """
    u: torch.Tensor

@dataclass
class SimulationState:
    variables: Variables
    t: float
    step: int

@torch.compile
def step(u: torch.Tensor, coeff: float):
    # Periodic boundary conditions via torch.roll.
    # Each roll is a cyclic shift along one axis.
    # With @torch.compile, the rolls and arithmetic are fused
    # into a single Triton kernel (index transformation, no copies).
    left   = torch.roll(u, -1, 0)
    right  = torch.roll(u,  1, 0)
    up     = torch.roll(u, -1, 1)
    down   = torch.roll(u,  1, 1)
    front  = torch.roll(u, -1, 2)
    back   = torch.roll(u,  1, 2)

    # Laplacian: Sum of neighbors - 6 * center
    laplacian = (left + right + up + down + front + back) - (6.0 * u)

    return u + coeff * laplacian


def export_heat_step_dynamo_report(
    state: SimulationState,
    coeff: float,
    output_path: pathlib.Path,
) -> None:
    dynamo.reset()
    explain_target = getattr(step, "_torchdynamo_orig_callable", step)
    explain_output = dynamo.explain(explain_target)(state.variables.u, coeff)
    dynamo_report = str(explain_output)
    output_path.write_text(dynamo_report)


def export_heat_step_fx_graph(
    state: SimulationState,
    coeff: float,
    output_path: pathlib.Path,
) -> None:
    """Capture the FX graph(s) TorchDynamo traces for `step`, before any lowering."""
    dynamo.reset()
    step_fn = getattr(step, "_torchdynamo_orig_callable", step)
    graphs = []

    def capture_backend(gm: torch.fx.GraphModule, example_inputs):
        graphs.append(gm)
        return gm.forward  # run eagerly, no lowering

    compiled = torch.compile(step_fn, backend=capture_backend)
    with torch.no_grad():
        compiled(state.variables.u, coeff)

    text = []
    for i, gm in enumerate(graphs):
        text.append(f"# ===== Dynamo FX graph {i} (readable) =====\n")
        text.append(gm.print_readable(print_output=False))
        text.append(f"\n# ===== Dynamo FX graph {i} (node table) =====\n")
        text.append(str(gm.graph))
        text.append("\n")
    output_path.write_text("".join(text))
    dynamo.reset()

class Heat:
    dt: float = 0.001
    nbiter: int = 10
    diag_steps: int = 10
    kappa: float = 1.0
    k: float = 1.0
    device: torch.device = torch.device(
        'cuda' if torch.cuda.is_available()
        else 'xpu' if hasattr(torch, 'xpu') and torch.xpu.is_available()
        else 'cpu'
    )

    def __init__(self, N: int = 256, L: float = 2.0*torch.pi,
                 nbiter:int = 10, diag_steps:int = 10, dt: float = 0.001,
                 kappa: float = 1.0, dtype: str = "float32") -> None:
        self.dtype = torch.float32 if dtype == "float32" else torch.float64
        self.grid       = Grid.create(N, N, N, L, L, L, device=self.device, dtype=self.dtype)
        self.nbiter     = nbiter
        self.diag_steps = diag_steps
        self.dt         = dt
        self.kappa      = kappa

    def initialize(self) -> SimulationState:
        """
        Creates the initial simulation state
        """

        g = self.grid

        # Initial condition
        x, y, z = torch.meshgrid(g.x, g.y, g.z, indexing='ij')
        kx, ky, kz = self.k, self.k, self.k
        u = torch.cos(kx * x) * torch.cos(ky * y) * torch.cos(kz * z)

        state = SimulationState(
            variables=Variables(u=u),
            t=0.0,
            step=0
        )
        return state

    def analytical(self) -> torch.Tensor:
        """
        Creates the analytical solution
        """
        kx, ky, kz = self.k, self.k, self.k
        ksq = kx**2 + ky**2 + kz**2

        # Initial condition
        g = self.grid
        x, y, z = torch.meshgrid(g.x, g.y, g.z, indexing='ij')
        u = torch.cos(kx * x) * torch.cos(ky * y) * torch.cos(kz * z)

        # Analytical solution at time t
        time = self.nbiter * self.dt
        u_analytical = u * math.exp(-self.kappa * ksq * time)

        return u_analytical

    def run(self, state: SimulationState) -> SimulationState:
        g = self.grid
        variables = state.variables
        u = variables.u

        # Main Loop
        coeff = self.kappa * self.dt / (g.dx**2)
        for i in range(1, self.nbiter + 1):
            u = step(u, coeff)

            state.t += self.dt
            state.step += 1

        synchronize(self.device)

        state = SimulationState(
            variables=Variables(u=u),
            t=state.t,
            step=state.step,
        )
        return state

if __name__ == '__main__':
    parser = argparse.ArgumentParser(add_help=True)
    parser.add_argument('-nx', nargs='?', type=int, default=256,
                        help="Number of grid points in each spatial dimension")
    parser.add_argument('-lx', nargs='?', type=float, default=2.0*torch.pi,
                        help="Physical domain length in one spatial direction")
    parser.add_argument('-nbiter', nargs='?', type=int, default=1000,
                        help="Total number of simulation iterations")
    parser.add_argument('-nrepeats', nargs='?', type=int, default=10,
                        help="How many times to repeat")
    parser.add_argument('-diag_steps', nargs='?', type=int, default=10,
                        help="Number of steps between diagnostics output")
    parser.add_argument('-dt', nargs='?', type=float, default=0.05,
                        help="Time step size for the integration scheme")
    parser.add_argument('-out_dir', nargs='?', type=str, default='data_python',
                        help="Directory where diagnostic output files will be saved")
    parser.add_argument('-kappa', nargs='?', type=float, default=0.001,
                        help="Thermal diffusivity")
    parser.add_argument('-dtype', type=str, default='float64',
                        choices=['float32', 'float64'], help='Data type')
    args = parser.parse_args()

    # Initialize solver
    solver = Heat(
        N=args.nx, L=args.lx,
        nbiter=args.nbiter, diag_steps=args.diag_steps,
        dt=args.dt,
        kappa=args.kappa,
        dtype=args.dtype,
    )

    dynamo_dir = pathlib.Path("dynamo_graphs")
    dynamo_dir.mkdir(parents=True, exist_ok=True)
    dynamo_export_path = dynamo_dir / "heat_step.txt"
    fx_graph_export_path = dynamo_dir / "heat_step_fx_graph.txt"

    # Create initial state
    initial_state = solver.initialize()
    coeff = solver.kappa * solver.dt / (solver.grid.dx**2)
    export_heat_step_dynamo_report(initial_state, coeff, dynamo_export_path)
    export_heat_step_fx_graph(initial_state, coeff, fx_graph_export_path)

    # Warm-up JIT compilation
    output = ""
    output += "Warming up JIT compilation...\n"
    _ = solver.run(initial_state)
    synchronize(solver.device)
    output += "JIT compilation done. Starting timed run...\n"

    initial_state = solver.initialize()

    # Reset peak memory statistics so the compilation phase is excluded
    reset_peak_memory(solver.device)

    # Memory before benchmark
    mem_before = get_memory_stats(solver.device)

    # Run
    times = []
    synchronize(solver.device)
    for _ in range(args.nrepeats):
        start = time.time()
        _ = solver.run(initial_state)
        synchronize(solver.device)
        elapsed = time.time() - start
        times.append(elapsed)

    best = min(times)
    avg = sum(times) / len(times)

    # Memory after benchmark
    mem_after = get_memory_stats(solver.device)

    # Sanity check
    initial_state = solver.initialize()
    final_state = solver.run(initial_state)
    synchronize(solver.device)

    u_final = final_state.variables.u
    u_ref = solver.analytical()
    err_l2 = torch.linalg.norm((u_final - u_ref).reshape(-1)) / torch.linalg.norm((u_ref).reshape(-1))
    err_linf = torch.max(torch.abs(u_final - u_ref))

    # Estimate memory bandwidth
    # 7-point stencil: read 6 neighbors + center = 1 reads, 1 write => 8 * sizeof(dtype) bytes/point
    # We do this once per step; total bytes = n^3 * 2 * itemsize * nbiter
    n = args.nx
    dtype = u_ref.dtype
    elem_size = u_ref.itemsize
    points = n ** 3
    bytes_per_point = 2 * elem_size
    total_bytes = points * bytes_per_point * args.nbiter
    gbps_best = (total_bytes / best) / 1e9
    gbps_avg = (total_bytes / avg) / 1e9

    # Report
    t_final = final_state.t
    dtype_name = str(dtype).split('.')[-1]
    output += f"PyTorch version: {torch.__version__}\n"
    output += f"Device: {get_device_label(solver.device)}\n"
    output += f"Grid: {n} x {n} x {n} (N={points:,} points), dtype={dtype}\n"
    output += f"Times (s): best={best:.6f}, avg={avg:.6f} over {args.nrepeats} runs\n"
    output += f"Estimated bandwidth (GB/s): best={gbps_best:.2f}, avg={gbps_avg:.2f}\n"
    if mem_before is not None:
        output += "\nMemory statistics\n"
        output += (
            f"Allocated before benchmark : "
            f"{format_memory(mem_before['allocated'])}\n"
        )
        output += (
            f"Reserved before benchmark  : "
            f"{format_memory(mem_before['reserved'])}\n"
        )
        output += (
            f"Peak allocated             : "
            f"{format_memory(mem_after['peak_allocated'])}\n"
        )
        output += (
            f"Peak reserved              : "
            f"{format_memory(mem_after['peak_reserved'])}\n"
        )

    output += (
        f"\nErrors vs analytical PDE at t={t_final:.6e}: "
        f"L2rel={float(err_l2):.3e}, Linf={float(err_linf):.3e}\n"
    )
    pathlib.Path(f"heat3d_{dtype_name}.txt").write_text(output)

    print_memory_summary(solver.device, f"heat3d_{dtype_name}_memory.txt")
