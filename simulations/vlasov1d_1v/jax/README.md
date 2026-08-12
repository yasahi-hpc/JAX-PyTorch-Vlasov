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

Here is the main kernel `advect_1d_vectorized`.

```python
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
    # (batch_size, 1) when a single velocity is provided per batch element.
    # Otherwise preserve shape
    # (batch_size, n_points)
    v_eff = velocities[:, None] if velocities.ndim == 1 else velocities
    displacement_idx = (v_eff * dt) / dx
    depart_idx = grid_indices[None, :] - displacement_idx

    # idx_left: Integer index immediately to the left of departure point.
    # (batch_size, n_points)
    # alpha: convert to integer indices for gathering
    # (batch_size, n_points)
    idx_left = jnp.floor(depart_idx)
    alpha = depart_idx - idx_left
    idx_left = idx_left.astype(jnp.int32)

    # Build six-point stencil around each departure point.
    # idx_left[:, :, None]
    #     shape = (batch_size, n_points, 1)
    #
    # stencil_offsets[None, None, :]
    # stencil_indices: (batch_size, n_points, 6)
    stencil_indices = idx_left[:, :, None] + stencil_offsets[None, None, :]

    if periodic:
        stencil_indices = jnp.mod(stencil_indices, n_points)
        # Flat gather
        # batch_idx = (batch_size, 1, 1)
        batch_ids = jnp.arange(batch_size)[:, None, None]
        # flat_indices = (batch_size, n_points, 6)
        flat_indices = batch_ids * n_points + stencil_indices
        f_vals = f_batch.ravel()[flat_indices.ravel()].reshape(batch_size, n_points, 6)
    else:
        # Mask identifying stencil entries inside domain
        # shape (batch_size, n_points, 6)
        valid_mask = (stencil_indices >= 0) & (stencil_indices < n_points)

        # Clamp indices to valid range
        # shape (batch_size, n_points, 6)
        safe_indices = jnp.clip(stencil_indices, 0, n_points - 1)

        # Batch ids:
        # shape = (batch_size, 1, 1)
        batch_ids = jnp.arange(batch_size)[:, None, None]

        # Flat gather indices.
        # shape = (batch_size, n_points, 6)
        flat_indices = batch_ids * n_points + safe_indices

        # Get stencil values.
        # shape = (batch_size, n_points, 6)
        f_vals = f_batch.ravel()[flat_indices.ravel()].reshape(batch_size, n_points, 6)
        f_vals = jnp.where(valid_mask, f_vals, 0.0)

    return lagrange5_interp_sum(alpha, f_vals)
```

## 4. JIT Compilation (Just-In-Time)

JAX's JIT compilation is extensively used to accelerate the simulation:

*   **`advect_1d_vectorized`**: The core advection routine is JIT-compiled. It handles the parallelized interpolation across the grid.
*   **`simulate`**: The entire simulation loop is JIT-compiled. It uses `jax.lax.scan` to unroll the time-stepping loop, allowing the XLA compiler to optimize the entire simulation sequence into a single efficient kernel.
*   **`solve_poisson`**: While not explicitly decorated with `@jax.jit`, it is called within the JIT-compiled `vlasov_step` (inside `simulate`), so it is also compiled.

## 5. Simulation Results

The following figure shows the comparison between the initial condition, the numerical solution after time $t$, and the analytical solution (for the free-streaming case).

![Simulation Result](vlasov1d-1v.png)

## 6. Timings

```
Jax version: 0.8.2
Starting simulation on NVIDIA GH200 120GB using float32 precision with Poisson solver and solver type vlasov_step_gather_free.
Grid: 4096x4096, Steps: 1000, chunks: 0, diag_freq: 2000
Running simulation without diagnostics (num_steps=0). Steps: 1000
Warming up JIT compilation...
JIT compilation done. Starting timed run...
Elapsed time: 0.6189801692962646 [s]

Memory statistics
Device memory before main loop : 192.20 MiB
Device memory after main loop  : 256.29 MiB
Device peak memory             : 320.37 MiB
Device memory limit            : 72960.00 MiB
Host peak RSS                  : 3509.69 MiB

Compiled memory analysis (per chunk, compiler-reported)
Argument size                  : 64.09 MiB
Output size                    : 64.09 MiB
Temp size                      : 64.06 MiB
Peak memory                    : 192.36 MiB
```