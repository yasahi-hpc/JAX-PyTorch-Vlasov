# Vlasov 1D-1V Simulation

This project implements a Vlasov 1D-1V solver using JAX. It simulates the evolution of a distribution function $f(x, v, t)$ in phase space.

## 1. Source Code

The main source code is located at: `src/advection.py`

## 2. Data Structures

The simulation primarily uses JAX arrays (`jax.numpy.ndarray`) for high-performance numerical operations.

*   **Distribution Function (`f`)**: A 2D array of shape `(Nx, Nv)` representing the phase space density.
    *   Axis 0 corresponds to spatial position $x$.
    *   Axis 1 corresponds to velocity $v$.
*   **Grids**:
    *   `x`: A 1D array of size `Nx` representing the spatial grid points in $[0, L]$.
    *   `v`: A 1D array of size `Nv` representing the velocity grid points in $[-V_{max}, V_{max}]$.
*   **Electric Field (`E`)**: A 1D array of size `Nx` representing the electric field at each spatial point.

## 3. Simulation

The simulation solves the Vlasov equation using a time-splitting method (Drift-Kick-Drift):

1.  **Drift in X**: Advect $f$ along the spatial axis $x$ with velocity $v$ for a half time step ($\Delta t / 2$).
2.  **Kick in V**:
    *   Calculate the Electric Field $E(x)$ by solving Poisson's equation (if `PHYSICS_MODE` is enabled).
    *   Advect $f$ along the velocity axis $v$ with acceleration $E$ for a full time step ($\Delta t$).
3.  **Drift in X**: Advect $f$ along the spatial axis $x$ with velocity $v$ for another half time step ($\Delta t / 2$).

**Key Numerical Methods:**
*   **Advection**: A semi-Lagrangian scheme is used.
*   **Interpolation**: 5th-degree Lagrange interpolation (`lagrange_interp_5_uniform`) is used to estimate values at departure points.
*   **Poisson Solver**: A spectral solver using FFT (`solve_poisson`) computes the electric field from the charge density.

## 4. JIT Compilation (Just-In-Time)

JAX's JIT compilation is extensively used to accelerate the simulation:

*   **`advect_variable_velocity`**: The core advection routine is JIT-compiled. It handles the parallelized interpolation across the grid.
*   **`simulate`**: The entire simulation loop is JIT-compiled. It uses `jax.lax.scan` to unroll the time-stepping loop, allowing the XLA compiler to optimize the entire simulation sequence into a single efficient kernel.
*   **`solve_poisson`**: While not explicitly decorated with `@jax.jit`, it is called within the JIT-compiled `vlasov_step` (inside `simulate`), so it is also compiled.

## 5. Simulation Results

The following figure shows the comparison between the initial condition, the numerical solution after time $t$, and the analytical solution (for the free-streaming case).

![Simulation Result](vlasov1d-1v.png)

## 6. Timings

```
PyTorch version: 2.9.1+cu128
Starting simulation on cuda with torch.float32 precision with Poisson solver and solver type vlasov_step_gather_free.
Grid: 4096x4096, Steps: 1000, chunks: 0, diag_freq: 2000
Warming up JIT compilation...
JIT compilation done. Starting timed run...
Elapsed time: 0.4061 [s]

Memory statistics
Allocated before benchmark : 128.39 MiB
Reserved before benchmark  : 642.00 MiB
Peak allocated             : 320.56 MiB
Peak reserved              : 642.00 MiB
```
