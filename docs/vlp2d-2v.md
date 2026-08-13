# Vlasov 1D-1V Simulation

This project implements a Vlasov 2D-2V solver using JAX/Kokkos/PyTorch. It simulates the evolution of a distribution function $f(t, x, y, v_x, v_y)$ in a 4D phase space.

## 1. Data Structures (JAX)

The simulation primarily uses JAX arrays (`jnp.ndarray`) for high-performance numerical operations. Similar data structures are used in Kokkos and PyTorch versions.

*   **`Grid`**: A frozen dataclass representing the 4D phase space grid.
    *   Contains dimensions (`Nx`, `Ny`, `Nvx`, `Nvy`), physical lengths (`Lx`, `Ly`), and velocity bounds (`Vmax_x`, `Vmax_y`).
    *   Stores coordinate arrays for `x`, `y`, `vx`, and `vy`.
*   **`Field`**: A dataclass holding the 2D field data (rho, phi).
    *   `rho`: Charge density of shape `(Nx, Ny)`.
    *   `phi`: Electric potential of shape `(Nx, Ny)`.
*   **`Variables`**: A dataclass holding the distribution function. 
    *   `fn`: 4D array of shape `(Nx, Ny, Nvx, Nvy)` representing the distribution function.
    *   `f0`: 2D array of shape `(Nvx, Nvy)` representing the equilibirum distribution function.
*   **`SimulationState`**: A dataclass encapsulating the full state of the simulation at a given time.
    *   Includes `grid`, `field`, `variables`, current time `t`, and step count `step`.

These classes are registered as JAX PyTree nodes, allowing them to be passed directly into JIT-compiled functions and `jax.lax.fori_loop`.

## 2. Simulation

The simulation solves the Vlasov-Poisson system using a time-splitting method (Strang Splitting):

1.  **Advection (X, Y)**: Advect $f$ along spatial axes for $\Delta t / 2$.
    *   X-advection uses $v_x$.
    *   Y-advection uses $v_y$.
2.  **Advection (Vx, Vy)**:
    *   Calculate Electric Field $\mathbf{E} = (E_x, E_y)$ by solving the 2D Poisson equation.
    *   Advect $f$ along velocity axes for $\Delta t$ using acceleration $\mathbf{a} = \mathbf{E}$ (assuming $q/m=1$).
3.  **Advection (X, Y)**: Advect $f$ along spatial axes for another $\Delta t / 2$.

**Key Numerical Methods:**
*   **Dimensional Splitting**: The 4D advection is broken down into a sequence of 1D advections along each axis.
*   **Semi-Lagrangian Advection**: Uses 5th-degree Lagrange interpolation (`lagrange_interp_5_uniform`) to estimate values at departure points.
*   **Poisson Solver**: A spectral solver (`solve_poisson_2d`) uses 2D FFT to compute the electric field from the spatial charge density $\rho(x, y)$.

## 3. Kernels

* [JAX version](https://github.com/yasahi-hpc/JAX-PyTorch-Vlasov/blob/main/simulations/vlasov2d_2v/jax/src/vlasov2D2V.py). solver 0, 1 and 2 corresponds to baseline, roll, and gather-free versions.

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
    """Batched 1D advection using flat indexing and vectorized Lagrange weights.

    Parameters
    ----------
    f_batch : jnp.ndarray
        Distribution slices. Shape: [batch_size, n_points]
    velocities : jnp.ndarray
        Velocity per batch element. Shape: [batch_size] or [batch_size, n_points]
    dt : float
        Time step.
    dx : float
        Grid spacing.
    periodic : bool
        If True, periodic BC; if False, Dirichlet (zero outside).

    Returns
    -------
    jnp.ndarray
        Advected distribution. Shape: [batch_size, n_points]
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
```

* [Kokkos version](https://github.com/yasahi-hpc/JAX-PyTorch-Vlasov/blob/main/simulations/vlasov2d_2v/kokkos/src/vlasov_poisson.hpp). solver 0 and 1 corresponds to TeamPolicy and MDRange versions.

```C++
MDRange4DType mdrange_policy(
    exec, {0, 0, 0, 0},
    {fn.extent(0), fn.extent(1), fn.extent(2), fn.extent(3)});
Kokkos::parallel_for(
    label, mdrange_policy,
    KOKKOS_LAMBDA(const int ix, const int iy, const int ivx, const int ivy) {
      const int indices[4] = {ix, iy, ivx, ivy};
      auto sub_f           = slice_f<axis>(fn, indices);
      RealType departure_point =
          grid(indices[axis]) - get_velocity<axis>(velocities, indices) * dt;
      fnp1(ix, iy, ivx, ivy) =
          advect_1d_impl<axis>(sub_f, departure_point, nx, Lx, xmin, inv_dx);
    });
```

* [PyTorch version](https://github.com/yasahi-hpc/JAX-PyTorch-Vlasov/blob/main/simulations/vlasov2d_2v/pytorch/src/vlasov2D2V.py). solver 0, 1 and 2 corresponds to baseline, roll, and gather-free versions.

```python
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
```

## 4. Run and Simulation Results

Please run the following command.

```bash
# Kokkos (fp32, MDRange)
build/simulations/vlasov2d_2v/kokkos/src/vlp2d_2v_fp32 -nx 128 -ny 128 -nvx 128 -nvy 128 -nbiter 128 -diag_steps 2000 -solver_type 1
        

# JAX (fp32, gather free)
cd simulations/vlasov2d_2v/jax/src
python vlasov2D2V.py -dtype float32 -nx 128 -ny 128 -nvx 128 -nvy 128 -nbiter 128 -diag_steps 2000 -physics_mode -solver 2
        

# PyTorch (fp32, gather free)
cd simulations/vlasov2d_2v/pytorch/src
python vlasov2D2V.py -dtype float32 -nx 128 -ny 128 -nvx 128 -nvy 128 -nbiter 128 -diag_steps 2000 -physics_mode -solver 2
```

## 5. Timings

* After running the code, we have the output file `vlp2d_2v_H200_float32_Nx128_Nvx128_solver2.txt` like this.

```
Jax version: 0.8.2
Starting simulation on NVIDIA GH200 120GB using float32 precision with Poisson solver and solver type vlasov_step_gather_free.
Grid: 128x128x128x128, Steps: 128, chunks: 0, diag_freq: 2000
Running simulation without diagnostics (num_steps=0). Steps: 128
Warming up JIT compilation...
JIT compilation done. Starting timed run...
Elapsed time: 1.2192354202270508 [s]

Memory statistics
Device memory before main loop : 3072.57 MiB
Device memory after main loop  : 4096.80 MiB
Device peak memory             : 6144.93 MiB
Device memory limit            : 72960.00 MiB
Host peak RSS                  : 6402.25 MiB

Compiled memory analysis (per chunk, compiler-reported)
Argument size                  : 1024.19 MiB
Output size                    : 1024.22 MiB
Temp size                      : 2048.06 MiB
Peak memory                    : 4096.57 MiB
```
