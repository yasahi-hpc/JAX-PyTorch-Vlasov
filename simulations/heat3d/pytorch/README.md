# Heat 3D Simulation

This project implements a 3D heat equation solver using PyTorch. It simulates the diffusion of a temperature field $u(x, y, z, t)$ on a uniform Cartesian grid with periodic boundary conditions.

## 1. Source Code

The main source code is located at: `src/heat3D.py`

## 2. Data Structures

The simulation uses PyTorch tensors (`torch.Tensor`) for high-performance numerical operations.

*   **Temperature Field (`u`)**: A 3D array of shape `(Nx, Ny, Nz)` representing the temperature at each grid point.
*   **Grids**:
    *   `x`: A 1D array of size `Nx` representing the spatial grid points in $[0, L_x)$ (endpoint excluded for periodic BC).
    *   `y`: A 1D array of size `Ny` representing the spatial grid points in $[0, L_y)$ (endpoint excluded for periodic BC).
    *   `z`: A 1D array of size `Nz` representing the spatial grid points in $[0, L_z)$ (endpoint excluded for periodic BC).

The code defines the following dataclasses:

| Dataclass | Fields | Description |
|---|---|---|
| `Grid` | `Nx, Ny, Nz, Lx, Ly, Lz, dx, dy, dz, x, y, z` | Holds grid dimensions, domain lengths, spacings, and coordinate tensors |
| `Variables` | `u` | Holds the current temperature field |
| `SimulationState` | `variables, t, step` | Holds the simulation variables, current time, and step counter |

## 3. Simulation

The simulation solves the 3D heat equation:

$$\frac{\partial u}{\partial t} = \kappa \nabla^2 u$$

using an explicit finite-difference scheme with a 7-point stencil and **periodic boundary conditions**:

$$u^{n+1}_{i,j,k} = u^{n}_{i,j,k} + \frac{\kappa \Delta t}{\Delta x^2} \left( u_{i-1,j,k} + u_{i+1,j,k} + u_{i,j-1,k} + u_{i,j+1,k} + u_{i,j,k-1} + u_{i,j,k+1} - 6\, u_{i,j,k} \right)$$

where indices wrap around periodically (e.g., $u_{N,j,k} = u_{0,j,k}$).

**Initial condition:**

$$u(x, y, z, 0) = \cos(k x)\, \cos(k y)\, \cos(k z), \quad k = 1$$

**Analytical solution:**

$$u(x, y, z, t) = \cos(k x)\, \cos(k y)\, \cos(k z)\, e^{-\kappa (k_x^2 + k_y^2 + k_z^2)\, t}$$

**Key Components:**
*   **`step()`**: The core stencil computation using `torch.roll` for periodic boundary conditions, decorated with `@torch.compile` to fuse the Laplacian and update into a single efficient Triton kernel.
*   **`Heat.initialize()`**: Creates the initial cosine temperature distribution.
*   **`Heat.analytical()`**: Computes the exact PDE solution for error analysis.
*   **`Heat.run()`**: Executes the time-stepping loop.

## 4. JIT Compilation (Just-In-Time)

PyTorch's `torch.compile` is used to accelerate the stencil computation:

*   **`step()`**: The 7-point stencil function is decorated with `@torch.compile`. The 6 periodic neighbor reads via `torch.roll`, Laplacian computation, and forward-Euler update are fused into a single Triton GPU kernel. Each `torch.roll` becomes an index transformation (no data copy), and the entire expression operates directly on registers.

## 5. Unit Tests

Tests are located in `unit_tests/` and run with `pytest`:

```bash
python -m pytest unit_tests/ -v
```

### Test Files

| File | Tests | Description |
|---|---|---|
| `conftest.py` | — | Shared pytest fixtures (`grid_params`, `grid_instance`, `variables_instance`) |
| `test_grid.py` | 7 | Grid initialization, dataclass fields, coordinate values (x, y, z), device transfer, and symmetry |
| `test_variables.py` | 4 | Variables and SimulationState initialization, dataclass fields, values, and operations |
| `test_step.py` | 6 | Stencil correctness: uniform field (zero Laplacian), single-point diffusion, periodic boundary wrapping, energy conservation, discrete Laplacian eigenvalue verification against cosine mode, and symmetry |
| `test_heat.py` | 11 | Heat solver: initialization, initial condition values, analytical solution, time advancement, output shapes, convergence vs analytical ($L_2 < 10^{-3}$), mean conservation, energy decay, single-step consistency with `step()`, and parametrized decay rate for $\kappa \in \{10^{-4}, 10^{-3}, 10^{-2}\}$ |

**Total: 28 tests**

### Key Test Strategies

*   **Analytical verification**: The `step()` function is tested against the known discrete Laplacian eigenvalue for a cosine mode: $\lambda = \sum_d (2\cos(k_d \Delta x) - 2)$.
*   **Convergence test**: The full solver is run with a fine time step and verified against the exact PDE solution with $L_2$ relative error $< 10^{-3}$.
*   **Physical invariants**: Mean conservation ($\sum u$ preserved under periodic BC) and energy dissipation ($\sum u^2$ decreasing) are both confirmed.
*   **Periodic BC verification**: A single hot point at the boundary is tested to ensure heat wraps to the opposite face via `torch.roll`.
*   **Parametrized tests**: Analytical decay rate $e^{-3\kappa t}$ is checked across multiple $\kappa$ values.

## 6. Timings

```
Warming up JIT compilation...
JIT compilation done. Starting timed run...
PyTorch version: 2.9.1+cu128
Device: NVIDIA GH200 120GB (cuda:0)
Grid: 512 x 512 x 512 (N=134,217,728 points), dtype=torch.float32
Times (s): best=0.035015, avg=0.035995 over 10 runs
Estimated bandwidth (GB/s): best=3066.53, avg=2983.05

Memory statistics
Allocated before benchmark : 1024.01 MiB
Reserved before benchmark  : 4098.00 MiB
Peak allocated             : 1536.01 MiB
Peak reserved              : 4098.00 MiB

Errors vs analytical PDE at t=2.000000e+00: L2rel=1.911e-07, Linf=4.768e-07
```
