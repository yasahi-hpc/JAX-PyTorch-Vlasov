# Heat 3D Simulation

This project implements a 3D heat equation solver using JAX. It simulates the diffusion of a temperature field $u(x, y, z, t)$ on a uniform Cartesian grid.

## 1. Source Code

The main source code is located at: `src/heat3D.py`

## 2. Data Structures

The simulation uses JAX arrays (`jnp.ndarray`) for high-performance numerical operations. All dataclasses are registered as JAX Pytrees so they can be passed through `jax.jit`, `jax.lax.fori_loop`, and other JAX transformations.

*   **Temperature Field (`u`)**: A 3D array of shape `(Nx, Ny, Nz)` representing the temperature at each grid point.
*   **Grids**:
    *   `x`: A 1D array of size `Nx` representing the spatial grid points in $[0, L_x)$ (endpoint excluded for periodic BC).
    *   `y`: A 1D array of size `Ny` representing the spatial grid points in $[0, L_y)$ (endpoint excluded for periodic BC).
    *   `z`: A 1D array of size `Nz` representing the spatial grid points in $[0, L_z)$ (endpoint excluded for periodic BC).

The code defines the following dataclasses:

| Dataclass | Fields | Description |
|---|---|---|
| `Grid` | `Nx, Ny, Nz, Lx, Ly, Lz, dx, dy, dz, x, y, z` | Holds grid dimensions, domain lengths, spacings, and coordinate arrays. Registered as a frozen Pytree (static scalars as auxiliary data, arrays as children). |
| `Variables` | `u` | Holds the current temperature field. Registered as a Pytree. |
| `SimulationState` | `grid, variables, t, step` | Holds the full simulation state: grid, variables, current time, and step counter. Registered as a Pytree. |

## 3. Simulation

The simulation solves the 3D heat equation:

$$\frac{\partial u}{\partial t} = \kappa \nabla^2 u$$

using an explicit finite-difference scheme with a 7-point stencil:

$$u^{n+1}_{i,j,k} = u^{n}_{i,j,k} + \frac{\kappa \Delta t}{\Delta x^2} \left( u_{i-1,j,k} + u_{i+1,j,k} + u_{i,j-1,k} + u_{i,j+1,k} + u_{i,j,k-1} + u_{i,j,k+1} - 6\, u_{i,j,k} \right)$$

**Initial condition:**

$$u(x, y, z, 0) = \cos(k x)\, \cos(k y)\, \cos(k z), \quad k = 1$$

**Analytical solution:**

$$u(x, y, z, t) = \cos(k x)\, \cos(k y)\, \cos(k z)\, e^{-\kappa (k_x^2 + k_y^2 + k_z^2)\, t}$$

**Key Components:**
*   **`heat_step()`**: The core stencil computation using `jnp.take` with modular indices for periodic boundary conditions, decorated with `@jax.jit`.
*   **`Heat.__init__()`**: Pre-builds a JIT-compiled time-stepping function (`_run_chunk`) using `jax.lax.fori_loop` so the JIT cache is reused across calls.
*   **`Heat.initialize()`**: Creates the initial cosine temperature distribution.
*   **`Heat.analytical()`**: Computes the exact PDE solution for error analysis.
*   **`Heat.run()`**: Executes the time-stepping loop, either as a single chunk or in diagnostic intervals.

## 4. JIT Compilation (Just-In-Time)

JAX's `@jax.jit` and `jax.lax.fori_loop` are used to accelerate the simulation:

*   **`heat_step()`**: The 7-point stencil function is decorated with `@jax.jit`. The 6 neighbor gathers, Laplacian computation, and forward-Euler update are traced once and compiled into a single fused XLA kernel.
*   **`_run_chunk()`**: The entire time-stepping loop is compiled as a single `jax.lax.fori_loop` inside `@jax.jit`. This keeps all iterations on-device with zero Python dispatch overhead; the carry is simply the `u` array.

## 5. Unit Tests

Tests are located in `tests/` and run with `pytest`:

```bash
python -m pytest tests/ -v
```

### Test Files

| File | Tests | Description |
|---|---|---|
| `conftest.py` | — | Shared pytest fixtures (`grid_params`, `grid_instance`, `variables_instance`, `state_instance`, `solver_small`) |
| `test_grid.py` | 5 | Grid initialization, derived quantities (dx, dy, dz), coordinate shapes and ranges, Pytree flatten/unflatten, JIT compatibility, immutability, and non-cubic dimensions |
| `test_variables.py` | 3 | Variables initialization and shapes, Pytree flatten/unflatten, JIT compatibility |
| `test_state.py` | 2 | SimulationState Pytree flatten/unflatten and JIT compatibility |
| `test_heat_step.py` | 6 | Stencil correctness: uniform field (zero Laplacian), single-point diffusion, periodic boundary wrapping, energy conservation, discrete Laplacian eigenvalue verification against cosine mode, and JIT compatibility |
| `test_heat.py` | 20 | Heat solver: `initialize()` return type, time/step, grid consistency, field shapes, cosine IC; `analytical()` shape, identity at $t=0$, decay, formula verification; `run()` return type, time advancement, NaN-free output, mean conservation, $L_2$ accuracy vs analytical ($< 10^{-3}$), parametrised step counts ($n \in \{1, 10, 50\}$), idempotency, chunked execution, and single-step consistency with `heat_step` |

**Total: 36 tests**

### Key Test Strategies

*   **Analytical verification**: The `heat_step()` function is tested against the known discrete Laplacian eigenvalue for a cosine mode: $\lambda = \sum_d (2\cos(k_d \Delta x) - 2)$.
*   **Convergence test**: The full solver is run with a fine time step and verified against the exact PDE solution with $L_2$ relative error $< 10^{-3}$.
*   **Physical invariant**: Mean conservation is confirmed — the spatial mean of $u$ is preserved under periodic boundary conditions.
*   **Pytree round-trip**: All dataclasses (`Grid`, `Variables`, `SimulationState`) are tested for correct JAX Pytree flatten/unflatten and compatibility with `jax.jit`.
*   **Parametrized tests**: Step counts are tested across $n \in \{1, 10, 50\}$ to verify correct time and step advancement.

## 6. Timings

```
Solver: heat_step_roll (type=1)
Running simulation without diagnostics (num_steps=0). Steps: 100
Warming up JIT compilation...
JIT compilation done. Starting timed run...

Jax version: 0.8.2
Device: NVIDIA GH200 120GB
Grid: 512 x 512 x 512 (N=134,217,728 points), dtype=float32
Times (s): best=0.068344, avg=0.068683 over 10 runs
Estimated bandwidth (GB/s): best=1571.09, avg=1563.32
Errors vs analytical PDE at t=2.000000e+00: L2rel=2.555e-07, Linf=9.537e-07

Memory statistics
Device memory before main loop : 1024.01 MiB
Device memory after main loop  : 1024.02 MiB
Device peak memory             : 4096.01 MiB
Device memory limit            : 72960.00 MiB
Host peak RSS                  : 3185.75 MiB

Compiled memory analysis (per chunk, compiler-reported)
Argument size                  : 512.00 MiB
Output size                    : 512.01 MiB
Temp size                      : 512.00 MiB
Peak memory                    : 1536.01 MiB
```

## 7. Memory Measurement

`src/heat3d.py` reports device and host memory consumption alongside the timings.

**Example output** (GH200, 512³, float32, conv solver):

```bash
Memory statistics
Device memory before main loop : 1024.01 MiB
Device memory after main loop  : 1024.02 MiB
Device peak memory             : 71766.13 MiB
Device memory limit            : 72960.00 MiB
Host peak RSS                  : 3489.50 MiB

Compiled memory analysis (per chunk, compiler-reported)
Argument size                  : 512.00 MiB
Output size                    : 512.01 MiB
Temp size                      : 1030.02 MiB
Peak memory                    : 2054.03 MiB
```

**How to interpret each value:**

| Value | Source | Meaning |
|---|---|---|
| Device memory before main loop | `memory_stats()["bytes_in_use"]` | Bytes held by live buffers in XLA's allocator after warm-up, just before the timed loop. This is the steady-state footprint of the simulation state (e.g. two 512³ float32 fields = 1024 MiB: `initial_state.u` plus the warm-up result kept alive by `_`). |
| Device memory after main loop | `memory_stats()["bytes_in_use"]` | Same quantity after the timed runs. It should be nearly identical to the *before* value; sustained growth across runs indicates arrays being kept alive unintentionally (a leak). |
| Device peak memory | `memory_stats()["peak_bytes_in_use"]` | High-water mark **since process start** — it cannot be reset. It includes JIT compilation and, for the conv solver, cuDNN autotuning workspaces, which is why it can be far larger than the loop's actual requirement (71.7 GiB above vs ~2 GiB per chunk). Use the compiled memory analysis for the per-chunk truth. |
| Device memory limit | `memory_stats()["bytes_limit"]` | The pool XLA's allocator may use, set by `XLA_PYTHON_CLIENT_MEM_FRACTION` (default 75% of device memory, preallocated at startup). Because of this preallocation, `nvidia-smi` shows a large constant allocation and is **not** a valid measure of JAX memory usage — always use `memory_stats()`. |
| Host peak RSS | `getrusage().ru_maxrss` | Peak CPU-side resident memory of the whole Python process (interpreter, JAX runtime, compilation, host copies). The only number reported on the CPU backend, where `memory_stats()` is unavailable. |
| Argument size | `memory_analysis()` | Bytes of the executable's input buffers (here: the 512 MiB `u` field plus scalars). Static, compiler-reported — independent of allocator state. |
| Output size | `memory_analysis()` | Bytes of the executable's output buffers (the updated state). |
| Temp size | `memory_analysis()` | Scratch buffers XLA allocates internally while the executable runs (e.g. the wrap-padded array and convolution workspace inside the `fori_loop` body). |
| Peak memory | `memory_analysis()` | The executable's own high-water mark. This is the best estimate of the true per-chunk device memory requirement, free of warm-up and autotuning noise: the grid must fit `peak memory + live state` within the device limit. |

References: [`jax.Device.memory_stats`](https://docs.jax.dev/en/latest/_autosummary/jax.Device.html), [GPU memory allocation](https://docs.jax.dev/en/latest/gpu_memory_allocation.html), [AOT compilation](https://docs.jax.dev/en/latest/aot.html), [device memory profiling](https://docs.jax.dev/en/latest/device_memory_profiling.html), [asynchronous dispatch](https://docs.jax.dev/en/latest/async_dispatch.html).
