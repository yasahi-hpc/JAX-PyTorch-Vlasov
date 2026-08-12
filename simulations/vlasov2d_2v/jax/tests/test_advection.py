import pytest
import jax
import jax.numpy as jnp
import numpy as np
import src.vlasov2D2V

advect_1d_map = {
    0: src.vlasov2D2V.advect_1d,
    1: src.vlasov2D2V.advect_1d_matrix_diag,
}

def advect_x_static_ref_api(f_data, velocities, axis, dt, dx, stencil_offsets):
    """Call advect_x_static (solver 2) through the reference kernel API.

    The gather-free spatial-drift kernel has no `periodic` argument (it is
    always periodic) and takes precomputed static blocks/weights instead of
    raw velocities; this wrapper performs the precomputation so tests can
    call it like advect_1d/advect_1d_matrix_diag. `velocities` must be the
    per-velocity-coordinate 1D array (shape (Nvx,) for axis 0, (Nvy,) for
    axis 1), matching the physical X/Y drift where the velocity depends
    only on vx/vy.
    """
    blocks, W = src.vlasov2D2V.precompute_x_drift(velocities, dt, dx, f_data.dtype)
    return src.vlasov2D2V.advect_x_static(f_data, W, blocks, stencil_offsets, axis)

def advect_v_static_ref_api(f_data, E, axis, dt, dv, stencil_offsets):
    """Call advect_v_static (solver 2) through the reference kernel API.

    The gather-free kick kernel has no `periodic` argument (it is always
    Dirichlet via zero padding) and needs a static window bound S with
    |E * dt / dv| < S; this wrapper sizes S from the inputs. `E` must be
    the per-spatial-point field with shape (Nx, Ny).
    """
    S = int(np.ceil(np.max(np.abs(np.asarray(E))) * dt / dv)) + 1
    return src.vlasov2D2V.advect_v_static(f_data, E, dt, dv, S, stencil_offsets, axis)

@pytest.mark.parametrize("solver", [0, 1, 2])
@pytest.mark.parametrize("axis", [0, 1])
def test_advect_1d_spatial(grid_instance, axis, solver):
    """
    Test advection along X (axis=0) or Y (axis=1) using advect_1d.
    Uses periodic boundary conditions.
    """
    Nx = grid_instance.Nx
    Ny = grid_instance.Ny
    Nvx = grid_instance.Nvx
    Nvy = grid_instance.Nvy
    Lx = grid_instance.Lx
    Ly = grid_instance.Ly
    dx = grid_instance.dx
    dy = grid_instance.dy
    x = grid_instance.x
    y = grid_instance.y

    # Setup parameters based on axis
    if axis == 0: # X direction
        dx_slice = dx
        L_slice = Lx
        grid_1d = x

        # Initial condition: Gaussian in X, constant in others
        x0 = Lx / 2.0
        sigma = Lx / 10.0
        profile = jnp.exp(-0.5 * ((x - x0) / sigma)**2)
        # Broadcast to (Nx, Ny, Nvx, Nvy)
        f_init = jnp.broadcast_to(profile[:, None, None, None], (Nx, Ny, Nvx, Nvy))

        # Velocities: broadcastable to (Ny, Nvx, Nvy) for axis 0
        v_drift = 1.0
        velocities = jnp.full((Ny, Nvx, Nvy), v_drift)

    else: # Y direction (axis=1)
        dx_slice = dy
        L_slice = Ly
        grid_1d = y

        # Initial condition: Gaussian in Y, constant in others
        x0 = Ly / 2.0
        sigma = Ly / 10.0
        profile = jnp.exp(-0.5 * ((y - x0) / sigma)**2)
        # Broadcast to (Nx, Ny, Nvx, Nvy)
        f_init = jnp.broadcast_to(profile[None, :, None, None], (Nx, Ny, Nvx, Nvy))

        # Velocities: broadcastable to (Nx, Nvx, Nvy) for axis 1
        v_drift = 1.0
        velocities = jnp.full((Nx, Nvx, Nvy), v_drift)

    dt = 0.1

    # Run advection (new API: f_data, velocities, axis, dt, dx, periodic)
    if solver == 2:  # gather-free static kernel: always periodic, no periodic argument
        # per-velocity-coordinate 1D velocities: (Nvx,) for axis 0, (Nvy,) for axis 1
        velocities_1d = jnp.full((Nvx,) if axis == 0 else (Nvy,), v_drift)
        f_next = advect_x_static_ref_api(
            f_init,
            velocities_1d,
            axis,
            dt,
            dx_slice,
            grid_instance.stencil_offsets,
        )
    else:
        f_next = advect_1d_map[solver](
            f_init,
            velocities,
            axis,
            dt,
            dx_slice,
            grid_instance.stencil_offsets,
            periodic=True
        )

    # Check result
    shift = v_drift * dt
    x_shifted = x0 + shift

    # Analytical solution (Periodic)
    x_diff = grid_1d - x_shifted
    x_diff = x_diff - L_slice * jnp.round(x_diff / L_slice)

    profile_expected = jnp.exp(-0.5 * (x_diff / sigma)**2)

    if axis == 0:
        f_expected = jnp.broadcast_to(profile_expected[:, None, None, None], (Nx, Ny, Nvx, Nvy))
    else:
        f_expected = jnp.broadcast_to(profile_expected[None, :, None, None], (Nx, Ny, Nvx, Nvy))

    assert jnp.allclose(f_next, f_expected, atol=1e-2)

@pytest.mark.parametrize("solver", [0, 1, 2])
@pytest.mark.parametrize("axis", [2, 3])
def test_advect_1d_velocity(grid_instance, axis, solver):
    """
    Test advection along Vx (axis=2) or Vy (axis=3) using advect_1d.
    Uses Dirichlet boundary conditions.
    """
    Nx = grid_instance.Nx
    Ny = grid_instance.Ny
    Nvx = grid_instance.Nvx
    Nvy = grid_instance.Nvy
    Vx_max = grid_instance.Vx_max
    Vy_max = grid_instance.Vy_max
    dvx = grid_instance.dvx
    dvy = grid_instance.dvy
    vx = grid_instance.vx
    vy = grid_instance.vy

    if axis == 2: # Vx
        dx_slice = dvx
        grid_1d = vx
        grid_min = -Vx_max
        L_slice = 2 * Vx_max

        v0 = 0.0
        sigma = Vx_max / 4.0
        profile = jnp.exp(-0.5 * ((vx - v0) / sigma)**2)
        f_init = jnp.broadcast_to(profile[None, None, :, None], (Nx, Ny, Nvx, Nvy))

        # Velocities (Accelerations): broadcastable to (Nx, Ny, Nvy) for axis 2
        a_drift = 1.0
        velocities = jnp.full((Nx, Ny, Nvy), a_drift)

    else: # Vy
        dx_slice = dvy
        grid_1d = vy
        grid_min = -Vy_max
        L_slice = 2 * Vy_max

        v0 = 0.0
        sigma = Vy_max / 4.0
        profile = jnp.exp(-0.5 * ((vy - v0) / sigma)**2)
        f_init = jnp.broadcast_to(profile[None, None, None, :], (Nx, Ny, Nvx, Nvy))

        # Velocities (Accelerations): broadcastable to (Nx, Ny, Nvx) for axis 3
        a_drift = 1.0
        velocities = jnp.full((Nx, Ny, Nvx), a_drift)

    dt = 0.1

    # Run advection (new API: f_data, velocities, axis, dt, dx, periodic)
    if solver == 2:  # gather-free static kernel: always Dirichlet, no periodic argument
        # per-spatial-point field with shape (Nx, Ny)
        E = jnp.full((Nx, Ny), a_drift)
        f_next = advect_v_static_ref_api(
            f_init,
            E,
            axis,
            dt,
            dx_slice,
            grid_instance.stencil_offsets,
        )
    else:
        f_next = advect_1d_map[solver](
            f_init,
            velocities,
            axis,
            dt,
            dx_slice,
            grid_instance.stencil_offsets,
            periodic=False
        )

    # Check result
    shift = a_drift * dt

    # Analytical solution (Dirichlet)
    # Check departure point
    departure_points = grid_1d - shift
    mask = (departure_points >= grid_min) & (departure_points <= grid_min + L_slice)

    profile_expected = jnp.exp(-0.5 * ((departure_points - v0) / sigma)**2)
    profile_expected = jnp.where(mask, profile_expected, 0.0)

    if axis == 2:
        f_expected = jnp.broadcast_to(profile_expected[None, None, :, None], (Nx, Ny, Nvx, Nvy))
    else:
        f_expected = jnp.broadcast_to(profile_expected[None, None, None, :], (Nx, Ny, Nvx, Nvy))

    assert jnp.allclose(f_next, f_expected, atol=1e-2)

@pytest.mark.parametrize("solver", [0, 1, 2])
@pytest.mark.parametrize("axis", [2, 3])
@pytest.mark.parametrize("shift_factor", [1.0, 1.5, 2.7, 4.2])
def test_advect_1d_velocity_multi_cell_shift(grid_instance, axis, solver, shift_factor):
    """
    Regression test for departure points that cross one or more full
    velocity grid cells, i.e. dt * |E| >= dv.

    Mirrors `test_advect_1d_core_v_multi_cell_shift` in
    vlasov1d_1v/jax/tests/test_advection.py: advect_1d_matrix_diag
    (solver 2) rolls its non-periodic branch by idx_left + the stencil
    tap, so it must keep tracking the analytical Dirichlet-truncated
    Gaussian shift once the shift spans multiple cells (a roll that only
    used the fixed stencil tap would silently assume idx_left is always
    0, breaking once dt * |E| >= dv). All solvers are checked here since
    none of this repo's benchmark configs previously exercised this
    regime.
    """
    Nx = grid_instance.Nx
    Ny = grid_instance.Ny
    Nvx = grid_instance.Nvx
    Nvy = grid_instance.Nvy
    Vx_max = grid_instance.Vx_max
    Vy_max = grid_instance.Vy_max
    dvx = grid_instance.dvx
    dvy = grid_instance.dvy
    vx = grid_instance.vx
    vy = grid_instance.vy

    if axis == 2:  # Vx
        dv = dvx
        grid_1d = vx
        V_max = Vx_max

        v0 = 0.0
        sigma = Vx_max / 4.0
        profile = jnp.exp(-0.5 * ((vx - v0) / sigma)**2)
        f_init = jnp.broadcast_to(profile[None, None, :, None], (Nx, Ny, Nvx, Nvy))
        batch_shape = (Nx, Ny, Nvy)

    else:  # Vy
        dv = dvy
        grid_1d = vy
        V_max = Vy_max

        v0 = 0.0
        sigma = Vy_max / 4.0
        profile = jnp.exp(-0.5 * ((vy - v0) / sigma)**2)
        f_init = jnp.broadcast_to(profile[None, None, None, :], (Nx, Ny, Nvx, Nvy))
        batch_shape = (Nx, Ny, Nvx)

    dt = 0.1
    # dt * a_drift == shift_factor * dv, so shift_factor >= 1 exercises dt*|E| >= dv.
    a_drift = shift_factor * dv / dt
    velocities = jnp.full(batch_shape, a_drift)

    shift = a_drift * dt
    assert shift >= dv - 1e-6  # sanity check: actually exercising dt * |E| >= dv

    if solver == 2:  # gather-free static kernel: always Dirichlet, no periodic argument
        E = jnp.full((Nx, Ny), a_drift)
        f_next = advect_v_static_ref_api(
            f_init,
            E,
            axis,
            dt,
            dv,
            grid_instance.stencil_offsets,
        )
    else:
        f_next = advect_1d_map[solver](
            f_init,
            velocities,
            axis,
            dt,
            dv,
            grid_instance.stencil_offsets,
            periodic=False,
        )

    # Analytical solution with Dirichlet BCs (departure points outside domain -> 0)
    departure_points = grid_1d - shift
    profile_expected = jnp.exp(-0.5 * ((departure_points - v0) / sigma)**2)
    mask = (departure_points >= -V_max) & (departure_points <= V_max)
    profile_expected = jnp.where(mask, profile_expected, 0.0)

    if axis == 2:
        f_expected = jnp.broadcast_to(profile_expected[None, None, :, None], (Nx, Ny, Nvx, Nvy))
    else:
        f_expected = jnp.broadcast_to(profile_expected[None, None, None, :], (Nx, Ny, Nvx, Nvy))

    assert jnp.allclose(f_next, f_expected, atol=1e-2)

@pytest.mark.parametrize("axis", [0, 1, 2, 3])
@pytest.mark.parametrize("shift_factor", [1.0, 1.5, 2.7, 4.2, 6.0])
def test_advect_1d_matrix_diag_matches_vectorized_multi_cell_shift(grid_instance, axis, shift_factor):
    """
    Direct cross-check between advect_1d_matrix_diag (solver 2) and
    advect_1d (solver 0, the reference gather-based kernel) for
    dt * |velocity| >= dx (or dv). Unlike the analytical check above,
    this is not bounded by Lagrange truncation error, so it directly
    guards the roll-based kernel's handling of the departure point's
    per-row integer shift on both the periodic (X, Y) and non-periodic
    (Vx, Vy) branches. Mirrors
    `test_advect_1d_matrix_diag_matches_vectorized_multi_cell_shift` in
    vlasov1d_1v/jax/tests/test_advection.py.
    """
    Nx = grid_instance.Nx
    Ny = grid_instance.Ny
    Nvx = grid_instance.Nvx
    Nvy = grid_instance.Nvy

    axis_to_dx = {
        0: grid_instance.dx,
        1: grid_instance.dy,
        2: grid_instance.dvx,
        3: grid_instance.dvy,
    }
    axis_to_periodic = {0: True, 1: True, 2: False, 3: False}
    axis_to_batch_shape = {
        0: (Ny, Nvx, Nvy),
        1: (Nx, Nvx, Nvy),
        2: (Nx, Ny, Nvy),
        3: (Nx, Ny, Nvx),
    }

    dx = axis_to_dx[axis]
    periodic = axis_to_periodic[axis]
    batch_shape = axis_to_batch_shape[axis]

    f = jax.random.uniform(jax.random.PRNGKey(0), (Nx, Ny, Nvx, Nvy))
    dt = 0.1

    velocities = jnp.full(batch_shape, shift_factor * dx / dt)

    f_vectorized = src.vlasov2D2V.advect_1d(
        f, velocities, axis, dt, dx, grid_instance.stencil_offsets, periodic=periodic
    )
    f_matrix_diag = src.vlasov2D2V.advect_1d_matrix_diag(
        f, velocities, axis, dt, dx, grid_instance.stencil_offsets, periodic=periodic
    )

    assert jnp.allclose(f_matrix_diag, f_vectorized, atol=1e-5, rtol=1e-5)

@pytest.mark.parametrize("axis", [0, 1, 2, 3])
@pytest.mark.parametrize("shift_factor", [0.3, 1.0, 1.5, 2.7, 4.2, 6.0])
def test_advect_static_matches_vectorized(grid_instance, axis, shift_factor):
    """
    Direct cross-check between the gather-free static kernels (solver 2:
    advect_x_static / advect_v_static) and advect_1d (solver 0, the
    reference gather-based kernel). Velocities vary per vx/vy coordinate
    for the spatial drifts (exercising multiple static shift blocks in
    block_roll) and per (x, y) point for the kicks (exercising the tap
    window collapse); shift_factor >= 1 covers departure points crossing
    one or more full grid cells. Not bounded by Lagrange truncation error,
    so agreement must be at roundoff level. Mirrors
    `test_advect_static_matches_vectorized` in
    vlasov1d_1v/jax/tests/test_advection.py.
    """
    Nx = grid_instance.Nx
    Ny = grid_instance.Ny
    Nvx = grid_instance.Nvx
    Nvy = grid_instance.Nvy

    axis_to_dx = {
        0: grid_instance.dx,
        1: grid_instance.dy,
        2: grid_instance.dvx,
        3: grid_instance.dvy,
    }
    dx = axis_to_dx[axis]

    f = jax.random.uniform(jax.random.PRNGKey(0), (Nx, Ny, Nvx, Nvy))
    dt = 0.1

    if axis in (0, 1):
        # Spatial drift: velocities proportional to vx/vy (monotonic,
        # sign-changing) with max displacement = shift_factor cells.
        if axis == 0:
            velocities_1d = grid_instance.vx / grid_instance.Vx_max * (shift_factor * dx / dt)
            velocities = velocities_1d[None, :, None]  # batch (Ny, Nvx, Nvy)
        else:
            velocities_1d = grid_instance.vy / grid_instance.Vy_max * (shift_factor * dx / dt)
            velocities = velocities_1d[None, None, :]  # batch (Nx, Nvx, Nvy)

        f_vectorized = src.vlasov2D2V.advect_1d(
            f, velocities, axis, dt, dx, grid_instance.stencil_offsets, periodic=True
        )
        f_static = advect_x_static_ref_api(
            f, velocities_1d, axis, dt, dx, grid_instance.stencil_offsets
        )
    else:
        # Kick: E(x, y) varying in sign and magnitude with max displacement
        # = shift_factor cells.
        E = (shift_factor * dx / dt) * (
            jnp.sin(2.0 * jnp.pi * jnp.arange(Nx) / Nx)[:, None]
            * jnp.cos(2.0 * jnp.pi * jnp.arange(Ny) / Ny)[None, :]
        )
        f_vectorized = src.vlasov2D2V.advect_1d(
            f, E[:, :, None], axis, dt, dx, grid_instance.stencil_offsets, periodic=False
        )
        f_static = advect_v_static_ref_api(
            f, E, axis, dt, dx, grid_instance.stencil_offsets
        )

    assert jnp.allclose(f_static, f_vectorized, atol=1e-5, rtol=1e-5)
