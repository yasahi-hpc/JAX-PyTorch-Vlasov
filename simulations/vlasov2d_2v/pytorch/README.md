# Vlasov 2D2V — PyTorch Implementation

A 2D2V Vlasov–Poisson solver using semi-Lagrangian advection with Strang splitting, implemented in PyTorch.
The distribution function $f(x, y, v_x, v_y, t)$ is evolved on a 4D phase-space grid.

## Project Structure

```
pytorch/
├── README.md
├── src/
│   ├── __init__.py
│   └── vlasov2D2V.py      # Main solver
└── tests/
    ├── conftest.py          # Shared pytest fixtures
    ├── test_grid.py         # Grid construction tests (7 tests)
    ├── test_field.py        # Field dataclass tests (4 tests)
    ├── test_variables.py    # Variables & initialization tests (4 tests)
    ├── test_interpolation.py# Lagrange interpolation tests (4 tests)
    ├── test_advection.py    # Semi-Lagrangian advection tests (4 tests)
    └── test_poisson.py      # FFT Poisson solver tests (3 tests)
```

## Source Code (`src/vlasov2D2V.py`)

### Data Structures

| Class | Description |
|-------|-------------|
| `Grid` | Holds grid parameters (`Nx, Ny, Nvx, Nvy`), spacings (`dx, dy, dvx, dvy`), coordinate arrays (`x, y, vx, vy`), and Fourier-space arrays (`kx, ky, inv_ksq`). Created via `Grid.create(...)`. |
| `Field` | Contains the charge density `rho(x,y)` and electrostatic potential `phi(x,y)`. |
| `Variables` | Contains the distribution function `fn(x,y,vx,vy)` and equilibrium `f0(vx,vy)`. |
| `SimulationState` | Aggregates `Field`, `Variables`, time `t`, and step counter `step`. |

### Numerical Kernels

| Function | Description |
|----------|-------------|
| `get_lagrange5_weights(alpha)` | Computes 6-point Lagrange interpolation weights for fractional offset `alpha`. Exact for polynomials of degree ≤ 5. |
| `advect_1d_vectorized(f_batch, velocities, dt, dx, periodic)` | Batched 1D semi-Lagrangian advection using flat-index gather and vectorized Lagrange weights. Supports periodic and Dirichlet BCs. |
| `advect_1d(f_data, velocities, axis, dt, dx, periodic)` | High-level wrapper that permutes a 4D array to move the target axis last, flattens to batch form, calls `advect_1d_vectorized`, and restores the original shape. |
| `compute_rho(f_data, dvx, dvy)` | Integrates $f$ over velocity space: $\rho(x,y) = \int f \, dv_x \, dv_y$. |
| `compute_poisson(rho, kx, ky, inv_ksq)` | Solves $\nabla^2 \phi = -(\rho - 1)$ via `rfft2`/`irfft2` and returns $E_x, E_y, \delta\rho, \phi$. |
| `solve_poisson(f_data, kx, ky, inv_ksq, dvx, dvy)` | Combines `compute_rho` and `compute_poisson`. |

### Core Step

`vlasov_step_impl` performs one full Strang-split time step:

1. **Drift X** ($\Delta t/2$, periodic) — advect along $x$ with velocity $v_x$
2. **Drift Y** ($\Delta t/2$, periodic) — advect along $y$ with velocity $v_y$
3. **Kick $v_x$** ($\Delta t$, Dirichlet) — advect along $v_x$ with acceleration $E_x$
4. **Kick $v_y$** ($\Delta t$, Dirichlet) — advect along $v_y$ with acceleration $E_y$
5. **Drift Y** ($\Delta t/2$, periodic)
6. **Drift X** ($\Delta t/2$, periodic)

This function is compiled with `torch.compile(mode="reduce-overhead")` for CUDA Graph support.

### Orchestrator (`Vlasov` class)

- `initialize()` — Creates the initial `SimulationState` (Maxwellian + perturbation in physics mode, or Gaussian pulse otherwise).
- `run(state)` — Executes the time loop with double-buffering (`fn ↔ f_buffer`) and periodic diagnostic saves via `save_diag()`.
- `save_diag(state)` — Writes snapshots to netCDF via xarray.

### Command-Line Interface

```bash
python -m src.vlasov2D2V -nx 64 -ny 64 -nvx 64 -nvy 64 -nbiter 1000 -dt 0.05 -physics_mode
```

Key arguments: `-nx`, `-ny`, `-nvx`, `-nvy`, `-lx`, `-ly`, `-Vx_max`, `-Vy_max`, `-nbiter`, `-diag_steps`, `-dt`, `-out_dir`, `-physics_mode`, `-epsilon`.

## Tests (`tests/`)

27 tests total, covering every public function and data structure.

### `conftest.py` — Shared Fixtures

- `grid_params` — Default parameters: 16×16×16×16, $L=2\pi$, $V_{max}=4$.
- `grid_instance` — A `Grid` created on CPU from `grid_params`.
- `field_instance` — Zero-initialized `Field(rho, phi)`.
- `variables_instance` — Zero-initialized `Variables(fn, f0)`.

### `test_grid.py` — 7 tests

| Test | Description |
|------|-------------|
| `test_grid_initialization` | Verifies all scalar params and derived spacings `dx, dy, dvx, dvy`. |
| `test_grid_dataclass_fields` | Confirms all 19 attributes exist and tensors reside on CPU. |
| `test_grid_x_values` | Checks `x = linspace(0, Lx, Nx+1)[:-1]` (endpoint-excluded periodic). |
| `test_grid_y_values` | Same for `y`. |
| `test_grid_vx_values` | Checks `vx = linspace(-Vx_max, Vx_max, Nvx)` (endpoint-included). |
| `test_grid_vy_values` | Same for `vy`. |
| `test_grid_inv_ksq_zero_mode` | Verifies `inv_ksq[0,0] == 0` (avoids division by zero at $k=0$). |

### `test_field.py` — 4 tests

| Test | Description |
|------|-------------|
| `test_field_initialization` | Shape check for `rho` and `phi`: `(Nx, Ny)`. |
| `test_field_dataclass_fields` | Attribute existence and `isinstance` check. |
| `test_field_values` | Non-zero construction and value verification. |
| `test_field_sum` | Validates `torch.sum` operates correctly on members. |

### `test_variables.py` — 4 tests

| Test | Description |
|------|-------------|
| `test_variables_initialization` | Shape check for `fn`: `(Nx,Ny,Nvx,Nvy)` and `f0`: `(Nvx,Nvy)`. |
| `test_variables_dataclass_fields` | Attribute existence and `isinstance` check. |
| `test_variables_mean` | Validates `torch.mean` operates correctly. |
| `test_vlasov_initialize[True/False]` | Full `Vlasov.initialize()` test: verifies `f0` (Maxwellian vs zero), `fn` (perturbed Maxwellian vs Gaussian pulse), shapes, and initial `t=0, step=0`. |

### `test_interpolation.py` — 4 tests

| Test | Description |
|------|-------------|
| `test_lagrange5_weights_exact_polynomials` | Weights exactly reproduce $p(x) = x^k$ for $k = 0, \dots, 5$. |
| `test_lagrange5_weights_at_nodes` | At $\alpha=0$, weight vector is `[0,0,1,0,0,0]` (delta at node 0). |
| `test_lagrange5_weights_shape` | Output shape is `[Batch, N, 6]`. |
| `test_lagrange5_weights_partition_of_unity` | Weights sum to 1 for all $\alpha$ (reproduces constant $f=1$). |

### `test_advection.py` — 4 tests

| Test | Description |
|------|-------------|
| `test_advect_1d_spatial[0]` | X-advection (periodic): Gaussian shifted by $v \Delta t$, compared to analytical. |
| `test_advect_1d_spatial[1]` | Y-advection (periodic): same test along axis 1. |
| `test_advect_1d_velocity[2]` | $v_x$-advection (Dirichlet): Gaussian shifted by $a \Delta t$, zero outside domain. |
| `test_advect_1d_velocity[3]` | $v_y$-advection (Dirichlet): same test along axis 3. |

### `test_poisson.py` — 3 tests (parametrized over modes 1, 2, 3)

| Test | Description |
|------|-------------|
| `test_solve_poisson_properties[k]` | For a single-mode perturbation $\epsilon \cos(k_x x)\cos(k_y y)$: (1) `compute_rho` matches manual integration, (2) $\phi$ matches analytical $\epsilon/(k_x^2+k_y^2) \cos(k_x x)\cos(k_y y)$, (3) $E_x = -\partial\phi/\partial x$ and $E_y = -\partial\phi/\partial y$ match analytical derivatives. |

## Running

```bash
# Activate environment
module purge && module load gcc/11.4.1
conda activate torch_env

# Run tests (27 tests)
cd simulations/vlasov2d_2v/pytorch
python -m pytest tests/ -v

# Run simulation
python -m src.vlasov2D2V -nx 32 -ny 32 -nvx 32 -nvy 32 -nbiter 1000 -dt 0.05 -physics_mode
```

## Timing

```
PyTorch version: 2.9.1+cu128
Starting simulation on cuda with torch.float32 precision with Poisson solver and solver type vlasov_step_gather_free.
Grid: 128x128x128x128, Steps: 128, chunks: 0, diag_freq: 2000
Warming up torch.compile...
Compilation done. Starting timed run...
Elapsed time: 1.2143 [s]

Memory statistics
Allocated before benchmark : 2048.42 MiB
Reserved before benchmark  : 6196.00 MiB
Peak allocated             : 6193.55 MiB
Peak reserved              : 6196.00 MiB
```
