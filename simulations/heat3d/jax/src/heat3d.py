import math
import argparse
import resource
import time
import pathlib
import functools
from dataclasses import dataclass
from typing import Tuple
import xarray as xr
import numpy as np
import jax
import jax.numpy as jnp

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
    Immutable grid definition.
    Static parameters (Nx, Ny, etc.) are stored as 'auxiliary' data in the Pytree.
    Coordinate arrays (x, y, z) are stored as 'children' (JAX arrays).
    """
    Nx: int
    Ny: int
    Nz: int
    Lx: float
    Ly: float
    Lz: float
    dx: float
    dy: float
    dz: float
    x: jnp.ndarray
    y: jnp.ndarray
    z: jnp.ndarray

    @classmethod
    def create(cls, Nx, Ny, Nz, Lx, Ly, Lz, dtype=jnp.float32):
        dx = Lx / Nx
        dy = Ly / Ny
        dz = Lz / Nz

        # Endpoint=False for periodic in X, Y, Z
        x = jnp.linspace(0, Lx, Nx, endpoint=False, dtype=dtype)
        y = jnp.linspace(0, Ly, Ny, endpoint=False, dtype=dtype)
        z = jnp.linspace(0, Lz, Nz, endpoint=False, dtype=dtype)

        return cls(Nx, Ny, Nz, Lx, Ly, Lz, dx, dy, dz, x, y, z)

    # -- Pytree Methods --
    def tree_flatten(self):
        # Children (dynamic JAX arrays), Auxiliary (static python values)
        children = (self.x, self.y, self.z)
        aux_data = (self.Nx, self.Ny, self.Nz, self.Lx, self.Ly, self.Lz, self.dx, self.dy, self.dz)
        return children, aux_data

    @classmethod
    def tree_unflatten(cls, aux_data, children):
        return cls(*aux_data, *children)

@jax.tree_util.register_pytree_node_class
@dataclass
class Variables:
    """
    Holds the physical field data
    """
    u: jnp.ndarray

    # -- Pytree Methods --
    def tree_flatten(self):
        # Children (dynamic JAX arrays)
        children = (self.u,)
        return children, None

    @classmethod
    def tree_unflatten(cls, aux_data, children):
        return cls(*children)

@jax.tree_util.register_pytree_node_class
@dataclass
class SimulationState:
    grid: Grid
    variables: Variables
    t: float
    step: int

    # -- Pytree Methods --
    def tree_flatten(self) -> Tuple[Tuple[Grid, Variables, float, int], None]:
        children = (self.grid, self.variables, self.t, self.step)
        aux_data = None
        return children, aux_data

    @classmethod
    def tree_unflatten(
        cls,
        aux_data: None,
        children: Tuple[Grid, Variables, float, int],
    ) -> "SimulationState":
        return cls(*children)

@jax.jit
def heat_step(u: jnp.ndarray, coeff: float):
    # Create views (pointers, no memory allocation)
    n = u.shape[0]
    left   = jnp.take(u, (jnp.arange(n)+1)%n, axis=0)
    right  = jnp.take(u, (jnp.arange(n)-1)%n, axis=0)
    up     = jnp.take(u, (jnp.arange(n)+1)%n, axis=1)
    down   = jnp.take(u, (jnp.arange(n)-1)%n, axis=1)
    front  = jnp.take(u, (jnp.arange(n)+1)%n, axis=2)
    back   = jnp.take(u, (jnp.arange(n)-1)%n, axis=2)

    # Laplacian: Sum of neighbors - 6 * center
    laplacian = (left + right + up + down + front + back) - (6.0 * u)
    return u + coeff * laplacian

@jax.jit
def heat_step_roll(u: jnp.ndarray, coeff: float):
    # Create views (pointers, no memory allocation)
    left   = jnp.roll(u, -1, axis=0)
    right  = jnp.roll(u,  1, axis=0)
    up     = jnp.roll(u, -1, axis=1)
    down   = jnp.roll(u,  1, axis=1)
    front  = jnp.roll(u, -1, axis=2)
    back   = jnp.roll(u,  1, axis=2)

    # Laplacian: Sum of neighbors - 6 * center
    laplacian = (left + right + up + down + front + back) - (6.0 * u)
    return u + coeff * laplacian

def periodic_conv1d(x, kernel):
    # x : (batch, channel, width)

    x = jnp.concatenate(
        [x[:, :, -1:], x, x[:, :, :1]],
        axis=2,
    )

    return jax.lax.conv_general_dilated(
        lhs=x,
        rhs=kernel,
        window_strides=(1,),
        padding="VALID",
        dimension_numbers=("NCW", "OIW", "NCW"),
    )

def laplace_x(u, kernel):
    nx, ny, nz = u.shape

    # Batch = every yz-plane
    x = (
        u.transpose(1, 2, 0)
         .reshape(ny * nz, 1, nx)
    )

    x = periodic_conv1d(x, kernel)

    return (
        x.reshape(ny, nz, nx)
         .transpose(2, 0, 1)
    )

def laplace_y(u, kernel):
    nx, ny, nz = u.shape

    y = (
        u.transpose(0, 2, 1)
         .reshape(nx * nz, 1, ny)
    )

    y = periodic_conv1d(y, kernel)

    return (
        y.reshape(nx, nz, ny)
         .transpose(0, 2, 1)
    )

def laplace_z(u, kernel):
    nx, ny, nz = u.shape

    z = (
        u.reshape(nx * ny, 1, nz)
    )

    z = periodic_conv1d(z, kernel)

    return z.reshape(nx, ny, nz)

@jax.jit
def heat_step_conv(
    u: jnp.ndarray,
    coeff: float,
    kernel: jnp.ndarray
):
    laplacian = (
        laplace_x(u, kernel)
        + laplace_y(u, kernel)
        + laplace_z(u, kernel)
    )
    return u + coeff * laplacian

def build_conv_kernel(dtype: jnp.dtype) -> jnp.ndarray:
    # (out_channels, in_channels, kernel_width)
    return jnp.asarray([1.0, -2.0, 1.0], dtype=dtype).reshape(1, 1, 3)

class Heat:
    dt: 0.001
    nbiter: int = 10
    diag_steps: int = 10
    kappa: float = 1.0
    k: float = 1.0

    def __init__(self, N: int = 256, L: float = 2.0*jnp.pi,
                 nbiter:int = 10, diag_steps:int = 10, dt: float = 0.001,
                 kappa: float = 1.0, solver_type: int = 0, dtype: str = 'float32') -> None:
        self.dtype      = jnp.float64 if dtype == 'float64' else jnp.float32
        self.grid       = Grid.create(N, N, N, L, L, L, dtype=self.dtype)
        self.nbiter     = nbiter
        self.diag_steps = diag_steps
        self.dt         = dt
        self.kappa      = kappa
        self.solver_type = solver_type
        self.device      = self.grid.x.device  # Get device from grid arrays

        # Select the stencil function
        if solver_type == 2:
            conv_kernel = build_conv_kernel(self.dtype)
            step_fn = functools.partial(heat_step_conv, kernel=conv_kernel)
        else:
            solver_map = {0: heat_step, 1: heat_step_roll}
            step_fn = solver_map[solver_type]

        # Pre-build the JIT-compiled time-stepping function ONCE
        # so that subsequent calls to run() hit the JAX cache.
        coeff = self.kappa * self.dt / (self.grid.dx ** 2)

        # Handle case where diag_steps > nbiter
        length = min(self.diag_steps, self.nbiter)
        self.num_steps = self.nbiter // self.diag_steps
        self.no_diag_msg = None
        if self.num_steps == 0:
            self.no_diag_msg = f"Running simulation without diagnostics (num_steps=0). Steps: {length}"

        @jax.jit
        def run_chunk(start_state):
            def body_fn(_, u):
                return step_fn(u, coeff)

            u_final = jax.lax.fori_loop(0, length, body_fn, start_state.variables.u)
            t = start_state.t + self.dt * length
            step = start_state.step + length
            final_chunk_state = SimulationState(
                grid=self.grid,
                variables=Variables(u=u_final),
                t=t,
                step=step,
            )
            return final_chunk_state

        self._run_chunk = run_chunk

    def initialize(self) -> SimulationState:
        """
        Creates the initial simulation state
        """

        g = self.grid

        # Initial condition
        x, y, z = jnp.meshgrid(g.x, g.y, g.z, indexing='ij')
        kx, ky, kz = self.k, self.k, self.k
        u = jnp.cos(kx * x) * jnp.cos(ky * y) * jnp.cos(kz * z)

        state = SimulationState(
            grid=g,
            variables=Variables(u=u),
            t=0.0,
            step=0
        )
        return state

    def analytical(self) -> jnp.ndarray:
        """
        Creates the analytical solution
        """
        kx, ky, kz = self.k, self.k, self.k
        ksq = kx**2 + ky**2 + kz**2

        # Initial condition
        g = self.grid
        x, y, z = jnp.meshgrid(g.x, g.y, g.z, indexing='ij')
        u = jnp.cos(kx * x) * jnp.cos(ky * y) * jnp.cos(kz * z)

        # Analytical solution at time t
        time = self.nbiter * self.dt
        u_analytical = u * math.exp(-self.kappa * ksq * time)

        return u_analytical

    def run(self, state: SimulationState) -> SimulationState:
        current_state = state
        if self.num_steps == 0:
            # Suppress diagnostics and measure without profiler overhead
            current_state = self._run_chunk(current_state)
            current_state.variables.u.block_until_ready()
        else:
            with jax.profiler.trace("./", create_perfetto_link=False, create_perfetto_trace=True):
                for _ in range(self.num_steps):
                    # Run the simulation on device
                    current_state = self._run_chunk(current_state)

                    # Jax waits for the computation to finish
                    # only when we try to copy data to host
                    #self._diag(current_state)

                current_state.variables.u.block_until_ready()

        return current_state

def run_heat3d(
    nx: int,
    lx: float,
    nbiter: int,
    nrepeats: int,
    diag_steps: int,
    dt: float,
    out_dir: str,
    kappa: float,
    solver_type: int,
    dtype: str,
) -> None:
    if dtype == 'float64':
        # Enable 64-bit floating point support in JAX
        jax.config.update("jax_enable_x64", True)

    solver_names = {0: 'heat_step', 1: 'heat_step_roll', 2: 'heat_step_conv'}
    output = ""
    output += f"Solver: {solver_names[solver_type]} (type={solver_type})\n"

    # Initialize solver
    solver = Heat(
        N=nx, L=lx,
        nbiter=nbiter, diag_steps=diag_steps,
        dt=dt,
        kappa=kappa,
        solver_type=solver_type,
        dtype=dtype
    )
    if solver.no_diag_msg is not None:
        output += solver.no_diag_msg + "\n"

    # Create initial state
    initial_state = solver.initialize()

    # ── Jaxpr and stablehlo analysis ──────────────────────────────────────────────
    # 1) Single stencil step → stencil.txt
    jaxpr_dir = pathlib.Path("jaxpr_dump")
    stablehlo_dir = pathlib.Path("hlo_dump")
    jaxpr_dir.mkdir(parents=True, exist_ok=True)
    stablehlo_dir.mkdir(parents=True, exist_ok=True)

    coeff = solver.kappa * solver.dt / (solver.grid.dx ** 2)
    if solver.solver_type == 2:
        conv_kernel = build_conv_kernel(solver.dtype)
        step_fn = functools.partial(heat_step_conv, kernel=conv_kernel)
    else:
        step_fn = {0: heat_step, 1: heat_step_roll}[solver.solver_type]

    step_jaxpr_path = jaxpr_dir / f"stencil_{solver_names[solver.solver_type]}.txt"
    if not step_jaxpr_path.exists():
        jaxpr_step = jax.make_jaxpr(step_fn)(initial_state.variables.u, coeff)
        step_jaxpr_path.write_text(str(jaxpr_step))

    for dialect in ["hlo", "stablehlo"]:
        step_stablehlo_path = stablehlo_dir / f"{dialect}_stencil_{solver_names[solver.solver_type]}.mlir"
        if not step_stablehlo_path.exists():
            compiler_ir = jax.jit(step_fn).lower(initial_state.variables.u, coeff).compiler_ir(dialect=dialect)
            if dialect == "hlo":
                # Some backends may not support HLO; skip if not available
                try:
                    hlo_text = compiler_ir.as_hlo_text()
                    step_stablehlo_path.write_text(hlo_text)
                except Exception as e:
                    print(f"Skipping HLO dump for {solver_names[solver.solver_type]}: {e}")
            else:
                # StableHLO is generally supported; write it to file
                step_stablehlo_path.write_text(str(compiler_ir))

    # 2) Full fori_loop chunk → chunk.txt
    chunk_jaxpr_path = jaxpr_dir / f"chunk_{solver_names[solver.solver_type]}.txt"
    chunk_stablehlo_path = stablehlo_dir / f"chunk_{solver_names[solver.solver_type]}.mlir"
    if not chunk_jaxpr_path.exists():
        jaxpr_chunk = jax.make_jaxpr(solver._run_chunk)(initial_state)
        chunk_jaxpr_path.write_text(str(jaxpr_chunk))

    for dialect in ["hlo", "stablehlo"]:
        chunk_stablehlo_path = stablehlo_dir / f"{dialect}_chunk_{solver_names[solver.solver_type]}.mlir"
        if not chunk_stablehlo_path.exists():
            compiler_ir = solver._run_chunk.lower(initial_state).compiler_ir(dialect=dialect)
            if dialect == "hlo":
                # Some backends may not support HLO; skip if not available
                try:
                    hlo_text = compiler_ir.as_hlo_text()
                    chunk_stablehlo_path.write_text(hlo_text)
                except Exception as e:
                    print(f"Skipping HLO dump for chunk_{solver_names[solver.solver_type]}: {e}")
            else:
                # StableHLO is generally supported; write it to file
                chunk_stablehlo_path.write_text(str(compiler_ir))

    # Warm-up JIT compilation
    output += "Warming up JIT compilation...\n"
    _ = solver.run(initial_state)
    output += "JIT compilation done. Starting timed run...\n"

    initial_state = solver.initialize()

    # Wait for warm-up completion; async dispatch would otherwise let us
    # sample the allocator before the work (and its allocations) finished.
    initial_state.variables.u.block_until_ready()

    # Measure memory before the main loop
    mem_before = get_memory_stats()

    # Static (compiler-reported) memory requirements of one chunk
    mem_analysis = get_compiled_memory_analysis(solver._run_chunk, initial_state)

    # Run
    times = []
    for _ in range(nrepeats):
        start = time.time()
        final_state = solver.run(initial_state)
        final_state.variables.u.block_until_ready()
        elapsed = time.time() - start
        times.append(elapsed)

    best = min(times)
    avg = sum(times) / len(times)

    mem_after = get_memory_stats()

    # Sanity check
    initial_state = solver.initialize()
    final_state = solver.run(initial_state)
    final_state.variables.u.block_until_ready()

    u_final = final_state.variables.u
    u_ref = solver.analytical()
    err_l2 = jnp.linalg.norm((u_final - u_ref).reshape(-1)) / jnp.linalg.norm((u_ref).reshape(-1))
    err_linf = jnp.max(jnp.abs(u_final - u_ref))

    # Estimate memory bandwidth
    # 7-point stencil: read 6 neighbors + center = 1 reads, 1 write => 8 * sizeof(dtype) bytes/point
    # We do this once per step; total bytes = n^3 * 2 * itemsize * nbiter
    n = nx
    dtype = u_ref.dtype
    elem_size = np.dtype(dtype).itemsize
    points = n ** 3
    bytes_per_point = 2 * elem_size
    total_bytes = points * bytes_per_point * nbiter
    gbps_best = (total_bytes / best) / 1e9
    gbps_avg = (total_bytes / avg) / 1e9
    dtype_name = dtype

    # Report
    t_final = final_state.t
    output += f"\nJax version: {jax.__version__}\n"
    output += f"Device: {solver.device.device_kind}\n"
    output += f"Grid: {n} x {n} x {n} (N={points:,} points), dtype={dtype}\n"
    output += f"Times (s): best={best:.6f}, avg={avg:.6f} over {nrepeats} runs\n"
    output += f"Estimated bandwidth (GB/s): best={gbps_best:.2f}, avg={gbps_avg:.2f}\n"
    output += (
        f"Errors vs analytical PDE at t={t_final:.6e}: "
        f"L2rel={float(err_l2):.3e}, Linf={float(err_linf):.3e}\n"
    )
    output += "\nMemory statistics\n"
    if mem_before is not None and mem_after is not None:
        output += (
            f"Device memory before main loop : "
            f"{format_memory(mem_before['bytes_in_use'])}\n"
        )
        output += (
            f"Device memory after main loop  : "
            f"{format_memory(mem_after['bytes_in_use'])}\n"
        )
        output += (
            f"Device peak memory             : "
            f"{format_memory(mem_after['peak_bytes_in_use'])}\n"
        )
        if 'bytes_limit' in mem_after:
            output += (
                f"Device memory limit            : "
                f"{format_memory(mem_after['bytes_limit'])}\n"
            )
    else:
        output += "Device allocator stats unavailable on this backend (e.g. CPU).\n"
    output += (
        f"Host peak RSS                  : "
        f"{format_memory(get_host_peak_rss())}\n"
    )
    if mem_analysis is not None:
        output += "\nCompiled memory analysis (per chunk, compiler-reported)\n"
        output += f"Argument size                  : {format_memory(mem_analysis.argument_size_in_bytes)}\n"
        output += f"Output size                    : {format_memory(mem_analysis.output_size_in_bytes)}\n"
        output += f"Temp size                      : {format_memory(mem_analysis.temp_size_in_bytes)}\n"
        # peak_memory_in_bytes is missing from CompiledMemoryStats on older jaxlib
        peak = getattr(mem_analysis, 'peak_memory_in_bytes', None)
        if peak is not None:
            output += f"Peak memory                    : {format_memory(peak)}\n"

    pathlib.Path(f"heat3d_{dtype_name}.txt").write_text(output)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(add_help=True)
    parser.add_argument('-nx', nargs='?', type=int, default=256,
                        help="Number of grid points in each spatial dimension")
    parser.add_argument('-lx', nargs='?', type=float, default=2.0*jnp.pi,
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
    parser.add_argument('-solver', nargs='?', type=int, default=0, choices=[0, 1, 2],
                        help="Solver type: 0=heat_step, 1=heat_step_roll, 2=heat_step_conv")
    parser.add_argument('-dtype', type=str, default='float64',
                        choices=['float32', 'float64'], help='Data type')
    args = parser.parse_args()

    run_heat3d(
        nx=args.nx,
        lx=args.lx,
        nbiter=args.nbiter,
        nrepeats=args.nrepeats,
        diag_steps=args.diag_steps,
        dt=args.dt,
        out_dir=args.out_dir,
        kappa=args.kappa,
        solver_type=args.solver,
        dtype=args.dtype
    )
