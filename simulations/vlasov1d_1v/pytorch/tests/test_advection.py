import pytest
import torch
import numpy as np
import src.vlasov1D1V

# Maps the `-solver` CLI/Vlasov constructor id to the underlying advect_1d_* kernel.
# The two kernels have different calling conventions (see advect_x/advect_v below):
# advect_1d_vectorized needs a transpose + point_indices/batch_offsets for its flat
# gather; advect_1d_matrix_diag derives everything from `velocities` and operates
# on [Nx, Nv] directly in both branches.


def advect_x(solver, f, grid_v, dt, dx, x_indices, x_batch_offsets, stencil_offsets):
    """Periodic X-drift, matching how vlasov_step / vlasov_step_matrix_diag /
    vlasov_step_gather_free call their kernel.

    For solver 2 (advect_x_static: always periodic, no `periodic` argument)
    this performs the block/weight precomputation that the production code
    hoists out of the step loop; `grid_v` must be the per-column [Nv]
    velocity tensor, matching the physical X drift.
    """
    if solver == 0:
        return src.vlasov1D1V.advect_1d_vectorized(
            f.T, grid_v, dt, x_indices, x_batch_offsets, stencil_offsets, dx, periodic=True
        ).T
    if solver == 2:
        blocks, W_x = src.vlasov1D1V.precompute_x_drift(grid_v, dt, dx, f.dtype)
        return src.vlasov1D1V.advect_x_static(f, W_x, blocks, stencil_offsets)
    return src.vlasov1D1V.advect_1d_matrix_diag(f, grid_v, dt, dx, stencil_offsets, periodic=True)


def advect_v(solver, f, accel, dt, dv, v_indices, v_batch_offsets, stencil_offsets):
    """Non-periodic V-drift, matching how vlasov_step / vlasov_step_matrix_diag /
    vlasov_step_gather_free call their kernel.

    For solver 2 (advect_v_static: always Dirichlet, no `periodic` argument)
    this sizes the static window bound S from the inputs so that
    |accel * dt / dv| < S holds; `accel` must be the per-row [Nx] field.
    """
    if solver == 0:
        return src.vlasov1D1V.advect_1d_vectorized(
            f, accel, dt, v_indices, v_batch_offsets, stencil_offsets, dv, periodic=False
        )
    if solver == 2:
        S = int(np.ceil(float(accel.abs().max()) * dt / dv)) + 1
        return src.vlasov1D1V.advect_v_static(f, accel, dt, dv, S, stencil_offsets)
    return src.vlasov1D1V.advect_1d_matrix_diag(f, accel, dt, dv, stencil_offsets, periodic=False)


@pytest.mark.parametrize("solver", [0, 1, 2])
def test_advect_1d_core_x(grid_instance, solver):
    """
    Test advection along X (periodic boundary conditions).
    f(x, v) = Gaussian(x) * 1(v)
    velocity = constant v_drift
    After time dt, f(x, v) should be Gaussian(x - v_drift*dt).
    """
    Nx = grid_instance.Nx
    Nv = grid_instance.Nv
    L = grid_instance.L
    dx = grid_instance.dx
    x = grid_instance.x
    v = grid_instance.v
    x_indices = grid_instance.x_indices
    x_batch_offsets = grid_instance.x_batch_offsets
    stencil_offsets = grid_instance.stencil_offsets

    # Initial condition: Gaussian in x, constant in v
    x0 = L / 2.0
    sigma = L / 10.0
    f_x = torch.exp(-0.5 * ((x - x0) / sigma)**2)
    f_init = f_x[:, None].expand(-1, Nv).clone()  # [Nx, Nv]

    # velocities shape [Nv] (one constant velocity for each v-slice)
    v_drift = 1.0
    velocities = torch.full((Nv,), v_drift)

    dt = 0.1

    f_next = advect_x(solver, f_init, velocities, dt, dx, x_indices, x_batch_offsets, stencil_offsets)

    # Check result
    shift = v_drift * dt
    x_shifted = x0 + shift

    # Analytical solution with periodic wrapping
    x_diff = x[:, None] - x_shifted
    x_diff = x_diff - L * torch.round(x_diff / L)
    f_expected = torch.exp(-0.5 * (x_diff / sigma)**2)
    f_expected = f_expected.expand(-1, Nv)

    # 5th order Lagrange should be quite good
    assert torch.allclose(f_next, f_expected, atol=1e-2)


@pytest.mark.parametrize("solver", [0, 1, 2])
def test_advect_1d_core_v_dirichlet(grid_instance, solver):
    """
    Test advection along V (Dirichlet boundary conditions).
    f(x, v) = 1(x) * Gaussian(v)
    acceleration = constant a_drift
    After time dt, f should be Gaussian(v - a_drift*dt) with Dirichlet BCs.
    """
    Nx = grid_instance.Nx
    Nv = grid_instance.Nv
    V_max = grid_instance.V_max
    dv = grid_instance.dv
    v = grid_instance.v
    v_indices = grid_instance.v_indices
    v_batch_offsets = grid_instance.v_batch_offsets
    stencil_offsets = grid_instance.stencil_offsets

    # Initial condition: Gaussian in v, constant in x
    v0 = 0.0
    sigma = V_max / 4.0
    f_v = torch.exp(-0.5 * ((v - v0) / sigma)**2)
    f_init = f_v[None, :].expand(Nx, -1).clone()  # [Nx, Nv]

    # Constant acceleration
    a_drift = 1.0
    accelerations = torch.full((Nx,), a_drift)

    dt = 0.1

    f_next = advect_v(solver, f_init, accelerations, dt, dv, v_indices, v_batch_offsets, stencil_offsets)

    # Check result
    shift = a_drift * dt
    v_shifted = v0 + shift

    # Analytical solution with Dirichlet BCs
    v_grid_shifted = v - shift
    f_expected_v = torch.exp(-0.5 * ((v_grid_shifted - v0) / sigma)**2)

    # Apply Dirichlet condition: departure points outside domain -> 0
    departure_points = v - shift
    mask = (departure_points >= -V_max) & (departure_points <= V_max)
    f_expected_v = torch.where(mask, f_expected_v, torch.tensor(0.0))

    f_expected = f_expected_v[None, :].expand(Nx, -1)

    assert torch.allclose(f_next, f_expected, atol=1e-2)

    # Test Dirichlet specifically: shift everything out
    large_dt = 3.0 * V_max / a_drift
    f_out = advect_v(solver, f_init, accelerations, large_dt, dv, v_indices, v_batch_offsets, stencil_offsets)
    assert torch.allclose(f_out, torch.zeros_like(f_out), atol=1e-6)


@pytest.mark.parametrize("solver", [0, 1, 2])
@pytest.mark.parametrize("shift_factor", [1.0, 1.5, 2.7, 4.2])
def test_advect_1d_core_v_multi_cell_shift(grid_instance, solver, shift_factor):
    """
    Regression test for departure points that cross one or more full
    velocity grid cells, i.e. dt * |a_drift| >= dv.

    advect_1d_matrix_diag (solver 1) used to silently assume the
    departure point's per-row integer cell shift was always 0 (a bug
    inherited from the JAX reference, which only stays hidden there because
    none of the benchmark configs drive E past a single grid cell). This
    checks both kernels still track the analytical Dirichlet-truncated
    Gaussian shift once the shift spans multiple cells.
    """
    Nx = grid_instance.Nx
    Nv = grid_instance.Nv
    V_max = grid_instance.V_max
    dv = grid_instance.dv
    v = grid_instance.v
    v_indices = grid_instance.v_indices
    v_batch_offsets = grid_instance.v_batch_offsets
    stencil_offsets = grid_instance.stencil_offsets

    v0 = 0.0
    sigma = V_max / 4.0
    f_v = torch.exp(-0.5 * ((v - v0) / sigma)**2)
    f_init = f_v[None, :].expand(Nx, -1).clone()  # [Nx, Nv]

    dt = 0.1
    # dt * a_drift == shift_factor * dv, so shift_factor >= 1 exercises dt*|E| >= dv.
    a_drift = shift_factor * dv / dt
    accelerations = torch.full((Nx,), a_drift)

    shift = a_drift * dt
    assert shift >= dv - 1e-9  # sanity check: actually exercising dt * |E| >= dv

    f_next = advect_v(solver, f_init, accelerations, dt, dv, v_indices, v_batch_offsets, stencil_offsets)

    # Analytical solution with Dirichlet BCs (departure points outside domain -> 0)
    departure_points = v - shift
    f_expected_v = torch.exp(-0.5 * ((departure_points - v0) / sigma)**2)
    mask = (departure_points >= -V_max) & (departure_points <= V_max)
    f_expected_v = torch.where(mask, f_expected_v, torch.tensor(0.0))
    f_expected = f_expected_v[None, :].expand(Nx, -1)

    assert torch.allclose(f_next, f_expected, atol=1e-2)


@pytest.mark.parametrize("shift_factor", [1.0, 1.5, 2.7, 4.2, 6.0])
def test_advect_1d_matrix_diag_matches_vectorized_multi_cell_shift(grid_params, shift_factor):
    """
    Direct cross-check between the two solver kernels (not against the
    truncated analytical formula, so it is not limited by Lagrange
    truncation error): for dt * |E| >= dv, advect_1d_matrix_diag (solver 1)
    must reproduce advect_1d_vectorized (solver 0) to floating-point
    precision, on both the periodic (X) and non-periodic (V) branches.

    Uses a dedicated float64 grid (rather than the float32 `grid_instance`
    fixture) so the tight tolerance below reflects kernel agreement, not
    float32 rounding.
    """
    grid = src.vlasov1D1V.Grid.create(**grid_params, device='cpu', dtype=torch.float64)
    Nx = grid.Nx
    Nv = grid.Nv
    dx = grid.dx
    dv = grid.dv
    x_indices = grid.x_indices
    x_batch_offsets = grid.x_batch_offsets
    v_indices = grid.v_indices
    v_batch_offsets = grid.v_batch_offsets
    stencil_offsets = grid.stencil_offsets

    torch.manual_seed(0)
    f = torch.rand(Nx, Nv, dtype=torch.float64)
    dt = 0.1

    # Periodic (X) branch: velocities vary per Nv-column.
    v_drift = torch.full((Nv,), shift_factor * dx / dt, dtype=torch.float64)
    f_vectorized_x = advect_x(0, f, v_drift, dt, dx, x_indices, x_batch_offsets, stencil_offsets)
    f_matrix_diag_x = advect_x(1, f, v_drift, dt, dx, x_indices, x_batch_offsets, stencil_offsets)
    assert torch.allclose(f_matrix_diag_x, f_vectorized_x, atol=1e-10, rtol=1e-10)

    # Non-periodic (V) branch: acceleration varies per Nx-row.
    a_drift = torch.full((Nx,), shift_factor * dv / dt, dtype=torch.float64)
    f_vectorized_v = advect_v(0, f, a_drift, dt, dv, v_indices, v_batch_offsets, stencil_offsets)
    f_matrix_diag_v = advect_v(1, f, a_drift, dt, dv, v_indices, v_batch_offsets, stencil_offsets)
    assert torch.allclose(f_matrix_diag_v, f_vectorized_v, atol=1e-10, rtol=1e-10)


@pytest.mark.parametrize("shift_factor", [0.3, 1.0, 1.5, 2.7, 4.2, 6.0])
def test_advect_static_matches_vectorized(grid_params, shift_factor):
    """
    Direct cross-check between the static kernels (solver 2:
    advect_x_static / advect_v_static) and advect_1d_vectorized (solver 0,
    the reference gather-based kernel). Velocities vary per column/row so
    the X drift exercises multiple sign-changing static shift blocks
    (block_roll) and the V kick exercises the per-row tap-window collapse;
    shift_factor >= 1 covers departure points crossing one or more full
    grid cells. Not bounded by Lagrange truncation error, so agreement
    must be at roundoff level (float64 grid, as in the matrix_diag
    cross-check above). Mirrors `test_advect_static_matches_vectorized`
    in the JAX test_advection.py and the PyTorch 2D2V one.
    """
    grid = src.vlasov1D1V.Grid.create(**grid_params, device='cpu', dtype=torch.float64)
    Nx = grid.Nx
    Nv = grid.Nv
    dx = grid.dx
    dv = grid.dv

    torch.manual_seed(0)
    f = torch.rand(Nx, Nv, dtype=torch.float64)
    dt = 0.1

    # Periodic (X) branch: per-column velocities proportional to grid.v
    # (monotonic, sign-changing) with max displacement = shift_factor cells.
    v_drift = grid.v / grid.V_max * (shift_factor * dx / dt)
    f_vectorized_x = advect_x(0, f, v_drift, dt, dx,
                              grid.x_indices, grid.x_batch_offsets, grid.stencil_offsets)
    f_static_x = advect_x(2, f, v_drift, dt, dx,
                          grid.x_indices, grid.x_batch_offsets, grid.stencil_offsets)
    assert torch.allclose(f_static_x, f_vectorized_x, atol=1e-10, rtol=1e-10)

    # Non-periodic (V) branch: per-row acceleration varying in sign and
    # magnitude with max displacement = shift_factor cells.
    a_drift = (shift_factor * dv / dt) * torch.sin(
        2.0 * torch.pi * torch.arange(Nx, dtype=torch.float64) / Nx)
    f_vectorized_v = advect_v(0, f, a_drift, dt, dv,
                              grid.v_indices, grid.v_batch_offsets, grid.stencil_offsets)
    f_static_v = advect_v(2, f, a_drift, dt, dv,
                          grid.v_indices, grid.v_batch_offsets, grid.stencil_offsets)
    assert torch.allclose(f_static_v, f_vectorized_v, atol=1e-10, rtol=1e-10)


@pytest.mark.parametrize("physics_mode", [False, True])
def test_vlasov_step_gather_free_matches_vlasov_step(grid_params, physics_mode):
    """
    Direct cross-check between `vlasov_step_gather_free` and `vlasov_step`:
    both implement the same Strang-split Vlasov-Poisson step, just with the
    static (no data-dependent memory access) advection kernels instead of
    the gather-based ones, so a step from the same initial condition must
    agree to floating-point precision. Uses the Landau-damping initial
    condition so physics mode exercises a smooth, small E field inside the
    default S=1 window.
    """
    import math
    grid = src.vlasov1D1V.Grid.create(**grid_params, device='cpu', dtype=torch.float64)
    g = grid

    kx = 2.0 * math.pi / g.L
    maxwellian = (1.0 / math.sqrt(2.0 * math.pi)) * torch.exp(-0.5 * g.v[None, :]**2)
    f = ((1.0 + 0.05 * torch.cos(kx * g.x[:, None])) * maxwellian).to(torch.float64)
    dt = 0.05

    # Bypass the torch.compile wrappers so the comparison is between the two
    # kernels themselves, not affected by dynamo/inductor compilation.
    step_ref = src.vlasov1D1V.vlasov_step
    step_static_impl = getattr(
        src.vlasov1D1V.vlasov_step_gather_free_impl, "_torchdynamo_orig_callable",
        src.vlasov1D1V.vlasov_step_gather_free_impl
    )

    args = (
        dt, g.v, g.inv_kx, g.inv_kx_sq,
        g.x_indices, g.v_indices, g.x_batch_offsets, g.v_batch_offsets,
        g.stencil_offsets,
        g.dx, g.dv, g.V_max,
        physics_mode,
    )

    f_ref, rho_ref, phi_ref = step_ref(f, *args)

    blocks, W_x = src.vlasov1D1V.precompute_x_drift(g.v, dt / 2.0, g.dx, torch.float64)
    offsets = src.vlasov1D1V.static_stencil_offsets(g.stencil_offsets)
    f_static, rho_static, phi_static = step_static_impl(
        f, dt, W_x, blocks, offsets, g.inv_kx, g.inv_kx_sq, g.dv, physics_mode, 1)

    if physics_mode:
        # guard the S=1 static-window assumption of the kick
        E, _, _ = src.vlasov1D1V.solve_poisson_real(f, g.inv_kx, g.inv_kx_sq, g.dv)
        assert src.vlasov1D1V.check_v_window(E, dt, g.dv, 1) < 1

    assert torch.allclose(f_static, f_ref, atol=1e-9, rtol=1e-9)
    assert torch.allclose(rho_static, rho_ref, atol=1e-9, rtol=1e-9)
    assert torch.allclose(phi_static, phi_ref, atol=1e-9, rtol=1e-9)
