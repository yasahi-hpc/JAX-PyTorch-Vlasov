import pytest
import jax
import jax.numpy as jnp
import numpy as np
import src.vlasov1D1V
from src.vlasov1D1V import advect_x_static, advect_v_static

advect_1d_map = {0: src.vlasov1D1V.advect_1d_vectorized,
                 1: src.vlasov1D1V.advect_1d_matrix_diag,}

def advect_x_static_ref_api(f, velocities, dt, dx, stencil_offsets):
    """Call advect_x_static (solver 2) through the reference kernel API.

    The gather-free X kernel has no `periodic` argument (it is always
    periodic) and takes precomputed static blocks/weights instead of raw
    velocities; this wrapper performs the precomputation so tests can call
    it like advect_1d_vectorized/advect_1d_matrix_diag.
    """
    blocks, W_x = src.vlasov1D1V.precompute_x_drift(velocities, dt, dx, f.dtype)
    return advect_x_static(f, W_x, blocks, stencil_offsets)

def advect_v_static_ref_api(f, velocities, dt, dv, stencil_offsets):
    """Call advect_v_static (solver 2) through the reference kernel API.

    The gather-free V kernel has no `periodic` argument (it is always
    Dirichlet via zero padding) and needs a static window bound S with
    |velocities * dt / dv| < S; this wrapper sizes S from the inputs.
    """
    S = int(np.ceil(np.max(np.abs(np.asarray(velocities))) * dt / dv)) + 1
    return advect_v_static(f, velocities, dt, dv, S, stencil_offsets)

@pytest.mark.parametrize("solver", [0, 1, 2])
def test_advect_1d_core_x(grid_instance, solver):
    """
    Test advection along X (axis 1 in the code's convention for advect_1d_core).
    Note: The code's docstring says:
    if axis == 1:
        # Advect along X (axis 0). velocities depends on V.

    Wait, let's check the code again.
    The input f_grid has shape (Nx, Nv).

    If axis == 1:
        f_T = f_grid.T  -> shape (Nv, Nx)
        f_next_T = jax.vmap(_solve_1d_slice, in_axes=(0, 0))(f_T, velocities)
        return f_next_T.T

    _solve_1d_slice takes (f_slice, c_speed).
    If we vmap over (0,0) of f_T (Nv, Nx), we are iterating over the first dimension (Nv).
    So for each velocity index j, we take a slice f_T[j, :] which is f_grid[:, j] (the spatial profile).
    And we take velocities[j].
    So this is indeed advection along X.

    Let's set up a simple translation test.
    f(x, v) = Gaussian(x) * 1(v)
    velocity = constant v0
    After time t, f(x, v) should be Gaussian(x - v0*t).
    """
    Nx = grid_instance.Nx
    Nv = grid_instance.Nv
    L = grid_instance.L
    dx = grid_instance.dx
    x = grid_instance.x
    v = grid_instance.v

    # Initial condition: Gaussian in x, constant in v
    x0 = L / 2.0
    sigma = L / 10.0
    f_x = jnp.exp(-0.5 * ((x - x0) / sigma)**2)
    f_init = jnp.tile(f_x[:, None], (1, Nv)) # (Nx, Nv)

    # Constant velocity for advection
    # The function signature is:
    # advect_1d_core(f_grid, grid_1d, velocities, dt_val, axis, N_slice, L_slice, grid_min, dx_slice)

    # For axis=1 (X advection), velocities should have shape (Nv,) because we vmap over the transpose.
    # Let's pick a constant velocity v_drift for all v indices to make checking easy.
    v_drift = 1.0
    velocities = jnp.full((Nv,), v_drift)

    dt = 0.1

    # Run advection
    if solver == 2:    # gather-free static kernel: always periodic, no periodic argument
        f_next = advect_x_static_ref_api(
            f_init,
            velocities,    # velocities
            dt,            # dt_val
            dx,            # dx_slice
            grid_instance.stencil_offsets,
        )
    elif solver == 1:  # matrix_diag
        f_next = advect_1d_map[solver](
            f_init,
            velocities,    # velocities
            dt,            # dt_val
            dx,            # dx_slice
            grid_instance.stencil_offsets,
            periodic=True, # periodic along x direction
        )
    else:
        f_next = advect_1d_map[solver](
            f_init.T,
            velocities,    # velocities
            dt,            # dt_val
            dx,            # dx_slice
            grid_instance.stencil_offsets,
            periodic=True, # periodic along x direction
        ).T

    # Check result
    # Expected: peak shifted by v_drift * dt
    shift = v_drift * dt
    x_shifted = x0 + shift

    # We can check the peak location or the whole profile.
    # Let's check the profile against an analytical shifted gaussian.
    # Since we have periodic boundaries, we need to handle wrapping if shift is large,
    # but here shift is small (0.1).

    # Analytical solution at t=dt
    # We need to be careful with periodicity for the analytical check
    x_diff = x[:, None] - x_shifted

    # Minimal distance on periodic domain
    # If x_diff > L/2, subtract L
    # If x_diff < -L/2, add L
    # For example, if x_diff = 0.1L, x_diff should be 0.1L
    # if x_diff = 0.6L, x_diff should be 0.6L - L = -0.4L
    x_diff = x_diff - L * jnp.round(x_diff / L)

    f_expected = jnp.exp(-0.5 * (x_diff / sigma)**2)
    # Broadcast to (Nx, Nv)
    f_expected = jnp.tile(f_expected, (1, Nv))

    # Check accuracy. 5th order Lagrange should be quite good.
    assert jnp.allclose(f_next, f_expected, atol=1e-2)

@pytest.mark.parametrize("solver", [0, 1, 2])
def test_advect_1d_core_v_dirichlet(grid_instance, solver):
    """
    Test advection along V (axis 0 in the code's convention).
    Now with Dirichlet boundary conditions (0 at boundaries).
    """
    Nx = grid_instance.Nx
    Nv = grid_instance.Nv
    V_max = grid_instance.V_max
    dv = grid_instance.dv
    v = grid_instance.v

    # Initial condition: Gaussian in v, constant in x
    v0 = 0.0
    sigma = V_max / 4.0
    f_v = jnp.exp(-0.5 * ((v - v0) / sigma)**2)
    f_init = jnp.tile(f_v[None, :], (Nx, 1)) # (Nx, Nv)

    # Constant acceleration
    a_drift = 1.0
    accelerations = jnp.full((Nx,), a_drift)

    dt = 0.1

    # Run advection
    if solver == 2:  # gather-free static kernel: always Dirichlet, no periodic argument
        f_next = advect_v_static_ref_api(
            f_init,
            accelerations,  # velocities (accelerations)
            dt,             # dt_val
            dv,             # dv_slice
            grid_instance.stencil_offsets,
        )
    else:
        f_next = advect_1d_map[solver](
            f_init,
            accelerations,  # velocities (accelerations)
            dt,             # dt_val
            dv,             # dv_slice
            grid_instance.stencil_offsets,
            periodic=False, # fixed along vx direction
        )

    # Check result
    shift = a_drift * dt
    v_shifted = v0 + shift

    # Analytical solution
    # For Dirichlet, we don't wrap.
    # f(v) = f_init(v - shift)
    # We construct the expected profile by evaluating the gaussian at shifted coordinates.
    # Points that shift in from outside should be 0 (Dirichlet).
    # Since our gaussian is centered at 0 and decays, and shift is small,
    # the boundary effects might be small unless we shift a lot.

    v_grid_shifted = v - shift
    f_expected_v = jnp.exp(-0.5 * ((v_grid_shifted - v0) / sigma)**2)

    # Apply Dirichlet condition: if the source point (v - shift) was outside [-V_max, V_max], value is 0.
    # Actually, the code implementation checks if the departure point is within bounds.
    # departure_point = grid_point - velocity * dt
    # If departure_point is outside [-V_max, V_max], result is 0.

    departure_points = v - shift
    mask = (departure_points >= -V_max) & (departure_points <= V_max)
    f_expected_v = jnp.where(mask, f_expected_v, 0.0)

    f_expected = jnp.tile(f_expected_v[None, :], (Nx, 1))

    assert jnp.allclose(f_next, f_expected, atol=1e-2)

    # Test Dirichlet specifically: shift everything out
    large_dt = 3.0 * V_max / a_drift

    if solver == 2:
        f_out = advect_v_static_ref_api(
            f_init,
            accelerations,  # velocities (accelerations)
            large_dt,       # dt_val
            dv,             # dv_slice
            grid_instance.stencil_offsets,
        )
    else:
        f_out = advect_1d_map[solver](
            f_init,
            accelerations,  # velocities (accelerations)
            large_dt,       # dt_val
            dv,             # dv_slice
            grid_instance.stencil_offsets,
            periodic=False, # fixed along vx direction
        )

    assert jnp.allclose(f_out, 0.0, atol=1e-6)

@pytest.mark.parametrize("solver", [0, 1, 2])
@pytest.mark.parametrize("shift_factor", [1.0, 1.5, 2.7, 4.2])
def test_advect_1d_core_v_multi_cell_shift(grid_instance, solver, shift_factor):
    """
    Regression test for departure points that cross one or more full
    velocity grid cells, i.e. dt * |a_drift| >= dv.

    advect_1d_matrix_diag (solver 1) used to roll its non-periodic branch by
    only the fixed stencil tap, implicitly assuming the departure point's
    per-row integer cell shift (idx_left) was always 0. That silently broke
    once a departure point crossed a full grid cell (dt * |E| >= dv); none
    of this repo's benchmark configs previously exercised that regime,
    which is why it went unnoticed. All solvers must still track the
    analytical Dirichlet-truncated Gaussian shift once the shift spans
    multiple cells.
    """
    Nx = grid_instance.Nx
    Nv = grid_instance.Nv
    V_max = grid_instance.V_max
    dv = grid_instance.dv
    v = grid_instance.v

    v0 = 0.0
    sigma = V_max / 4.0
    f_v = jnp.exp(-0.5 * ((v - v0) / sigma)**2)
    f_init = jnp.tile(f_v[None, :], (Nx, 1)) # (Nx, Nv)

    dt = 0.1
    # dt * a_drift == shift_factor * dv, so shift_factor >= 1 exercises dt*|E| >= dv.
    a_drift = shift_factor * dv / dt
    accelerations = jnp.full((Nx,), a_drift)

    shift = a_drift * dt
    assert shift >= dv - 1e-6 # sanity check: actually exercising dt * |E| >= dv

    if solver == 2:  # gather-free static kernel: always Dirichlet, no periodic argument
        f_next = advect_v_static_ref_api(
            f_init,
            accelerations,
            dt,
            dv,
            grid_instance.stencil_offsets,
        )
    else:
        f_next = advect_1d_map[solver](
            f_init,
            accelerations,
            dt,
            dv,
            grid_instance.stencil_offsets,
            periodic=False,
        )

    departure_points = v - shift
    f_expected_v = jnp.exp(-0.5 * ((departure_points - v0) / sigma)**2)
    mask = (departure_points >= -V_max) & (departure_points <= V_max)
    f_expected_v = jnp.where(mask, f_expected_v, 0.0)
    f_expected = jnp.tile(f_expected_v[None, :], (Nx, 1))

    assert jnp.allclose(f_next, f_expected, atol=1e-2)

@pytest.mark.parametrize("shift_factor", [1.0, 1.5, 2.7, 4.2, 6.0])
def test_advect_1d_matrix_diag_matches_vectorized_multi_cell_shift(grid_instance, shift_factor):
    """
    Direct cross-check between advect_1d_matrix_diag (solver 4) and
    advect_1d_vectorized (solver 0, the reference gather-based kernel) for
    dt * |E| >= dv. Unlike the analytical check above, this is not bounded
    by Lagrange truncation error, so it directly guards the bug where the
    non-periodic branch's roll ignored the departure point's per-row
    integer shift.
    """
    Nx = grid_instance.Nx
    Nv = grid_instance.Nv
    dx = grid_instance.dx
    dv = grid_instance.dv
    stencil_offsets = grid_instance.stencil_offsets

    f = jax.random.uniform(jax.random.PRNGKey(0), (Nx, Nv))
    dt = 0.1

    # Periodic (X) branch: velocities vary per Nv-column.
    v_drift = jnp.full((Nv,), shift_factor * dx / dt)
    f_vectorized_x = src.vlasov1D1V.advect_1d_vectorized(
        f.T, v_drift, dt, dx, stencil_offsets, periodic=True
    ).T
    f_matrix_diag_x = src.vlasov1D1V.advect_1d_matrix_diag(
        f, v_drift, dt, dx, stencil_offsets, periodic=True
    )
    assert jnp.allclose(f_matrix_diag_x, f_vectorized_x, atol=1e-5, rtol=1e-5)

    # Non-periodic (V) branch: acceleration varies per Nx-row.
    a_drift = jnp.full((Nx,), shift_factor * dv / dt)
    f_vectorized_v = src.vlasov1D1V.advect_1d_vectorized(
        f, a_drift, dt, dv, stencil_offsets, periodic=False
    )
    f_matrix_diag_v = src.vlasov1D1V.advect_1d_matrix_diag(
        f, a_drift, dt, dv, stencil_offsets, periodic=False
    )
    assert jnp.allclose(f_matrix_diag_v, f_vectorized_v, atol=1e-5, rtol=1e-5)

@pytest.mark.parametrize("shift_factor", [0.3, 1.0, 1.5, 2.7, 4.2, 6.0])
def test_advect_static_matches_vectorized(grid_instance, shift_factor):
    """
    Direct cross-check between the gather-free static kernels (solver 2:
    advect_x_static / advect_v_static) and advect_1d_vectorized (solver 0,
    the reference gather-based kernel). Velocities vary per column/row so
    the X drift exercises multiple static shift blocks (block_roll) and the
    V kick exercises the per-row tap-window collapse; shift_factor >= 1
    covers departure points crossing one or more full grid cells. Not
    bounded by Lagrange truncation error, so agreement must be at roundoff
    level.
    """
    Nx = grid_instance.Nx
    Nv = grid_instance.Nv
    V_max = grid_instance.V_max
    dx = grid_instance.dx
    dv = grid_instance.dv
    stencil_offsets = grid_instance.stencil_offsets

    f = jax.random.uniform(jax.random.PRNGKey(0), (Nx, Nv))
    dt = 0.1

    # Periodic (X) drift: per-column velocities proportional to grid.v
    # (monotonic, sign-changing) with max displacement = shift_factor cells.
    v_drift = grid_instance.v / V_max * (shift_factor * dx / dt)
    f_vectorized_x = src.vlasov1D1V.advect_1d_vectorized(
        f.T, v_drift, dt, dx, stencil_offsets, periodic=True
    ).T
    f_static_x = advect_x_static_ref_api(f, v_drift, dt, dx, stencil_offsets)
    assert jnp.allclose(f_static_x, f_vectorized_x, atol=1e-5, rtol=1e-5)

    # Dirichlet (V) kick: per-row acceleration varying in sign and magnitude
    # with max displacement = shift_factor cells.
    a_drift = (shift_factor * dv / dt) * jnp.sin(
        2.0 * jnp.pi * jnp.arange(Nx) / Nx)
    f_vectorized_v = src.vlasov1D1V.advect_1d_vectorized(
        f, a_drift, dt, dv, stencil_offsets, periodic=False
    )
    f_static_v = advect_v_static_ref_api(f, a_drift, dt, dv, stencil_offsets)
    assert jnp.allclose(f_static_v, f_vectorized_v, atol=1e-5, rtol=1e-5)
