import pytest
import torch
import numpy as np
import src.vlasov2D2V

# Maps the `kernel` id used below to the underlying advect_1d_* implementation.
# advect_1d (kernel 0) is the gather-based `advect_1d_vectorized` wrapper;
# advect_1d_matrix_diag (kernel 1) is the gather-free, roll-based counterpart
# used by `vlasov_step_matrix_diag`. Both share the same call signature
# (f_data, velocities, axis, dt, dx, periodic=..., point_indices=..., stencil_offsets=...)
# so they can be swapped in directly.
_ADVECT_KERNELS = {
    0: src.vlasov2D2V.advect_1d,
    1: src.vlasov2D2V.advect_1d_matrix_diag,
}


def _point_indices_for_axis(grid_instance, axis):
    if axis == 0:
        return grid_instance.x_indices
    if axis == 1:
        return grid_instance.y_indices
    if axis == 2:
        return grid_instance.vx_indices
    return grid_instance.vy_indices


def advect_x_static_ref_api(f_data, velocities, axis, dt, dx, stencil_offsets):
    """Call advect_x_static (kernel 2) through the reference kernel API.

    The static spatial-drift kernel has no `periodic` argument (it is
    always periodic) and takes precomputed static blocks/weights instead of
    raw velocities; this wrapper performs the precomputation so tests can
    call it like advect_1d/advect_1d_matrix_diag. `velocities` must be the
    per-velocity-coordinate 1D tensor (shape (Nvx,) for axis 0, (Nvy,) for
    axis 1), matching the physical X/Y drift where the velocity depends
    only on vx/vy. Mirrors the same helper in the JAX test_advection.py.
    """
    blocks, W = src.vlasov2D2V.precompute_x_drift(velocities, dt, dx, f_data.dtype)
    return src.vlasov2D2V.advect_x_static(f_data, W, blocks, stencil_offsets, axis)


def advect_v_static_ref_api(f_data, E, axis, dt, dv, stencil_offsets):
    """Call advect_v_static (kernel 2) through the reference kernel API.

    The static kick kernel has no `periodic` argument (it is always
    Dirichlet via zero padding) and needs a static window bound S with
    |E * dt / dv| < S; this wrapper sizes S from the inputs. `E` must be
    the per-spatial-point field with shape (Nx, Ny). Mirrors the same
    helper in the JAX test_advection.py.
    """
    S = int(np.ceil(float(E.abs().max()) * dt / dv)) + 1
    return src.vlasov2D2V.advect_v_static(f_data, E, dt, dv, S, stencil_offsets, axis)


@pytest.mark.parametrize("kernel", [0, 1, 2])
@pytest.mark.parametrize("axis", [0, 1])
def test_advect_1d_spatial(grid_instance, axis, kernel):
    """
    Test advection along X (axis=0) or Y (axis=1) using advect_1d /
    advect_1d_matrix_diag. Uses periodic boundary conditions.
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
    if axis == 0:  # X direction
        dx_slice = dx
        L_slice = Lx
        grid_1d = x

        # Initial condition: Gaussian in X, constant in others
        x0 = Lx / 2.0
        sigma = Lx / 10.0
        profile = torch.exp(-0.5 * ((x - x0) / sigma)**2)
        # Broadcast to (Nx, Ny, Nvx, Nvy)
        f_init = profile[:, None, None, None].expand(Nx, Ny, Nvx, Nvy).clone()

        # Velocities: broadcastable to (Ny, Nvx, Nvy) for axis 0
        v_drift = 1.0
        velocities = torch.full((Ny, Nvx, Nvy), v_drift)

    else:  # Y direction (axis=1)
        dx_slice = dy
        L_slice = Ly
        grid_1d = y

        # Initial condition: Gaussian in Y, constant in others
        x0 = Ly / 2.0
        sigma = Ly / 10.0
        profile = torch.exp(-0.5 * ((y - x0) / sigma)**2)
        # Broadcast to (Nx, Ny, Nvx, Nvy)
        f_init = profile[None, :, None, None].expand(Nx, Ny, Nvx, Nvy).clone()

        # Velocities: broadcastable to (Nx, Nvx, Nvy) for axis 1
        v_drift = 1.0
        velocities = torch.full((Nx, Nvx, Nvy), v_drift)

    dt = 0.1

    # Run advection (API: f_data, velocities, axis, dt, dx, periodic)
    if kernel == 2:  # static kernel: always periodic, no periodic argument
        # per-velocity-coordinate 1D velocities: (Nvx,) for axis 0, (Nvy,) for axis 1
        velocities_1d = torch.full((Nvx,) if axis == 0 else (Nvy,), v_drift)
        f_next = advect_x_static_ref_api(
            f_init,
            velocities_1d,
            axis,
            dt,
            dx_slice,
            grid_instance.stencil_offsets,
        )
    else:
        f_next = _ADVECT_KERNELS[kernel](
            f_init,
            velocities,
            axis,
            dt,
            dx_slice,
            point_indices=_point_indices_for_axis(grid_instance, axis),
            stencil_offsets=grid_instance.stencil_offsets,
            periodic=True
        )

    # Check result
    shift = v_drift * dt
    x_shifted = x0 + shift

    # Analytical solution (Periodic)
    x_diff = grid_1d - x_shifted
    x_diff = x_diff - L_slice * torch.round(x_diff / L_slice)

    profile_expected = torch.exp(-0.5 * (x_diff / sigma)**2)

    if axis == 0:
        f_expected = profile_expected[:, None, None, None].expand(Nx, Ny, Nvx, Nvy)
    else:
        f_expected = profile_expected[None, :, None, None].expand(Nx, Ny, Nvx, Nvy)

    # 5th order Lagrange should be quite good
    assert torch.allclose(f_next, f_expected, atol=1e-2)


@pytest.mark.parametrize("kernel", [0, 1, 2])
@pytest.mark.parametrize("axis", [2, 3])
def test_advect_1d_velocity(grid_instance, axis, kernel):
    """
    Test advection along Vx (axis=2) or Vy (axis=3) using advect_1d /
    advect_1d_matrix_diag. Uses Dirichlet boundary conditions.
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
        dx_slice = dvx
        grid_1d = vx
        grid_min = -Vx_max
        L_slice = 2 * Vx_max

        v0 = 0.0
        sigma = Vx_max / 4.0
        profile = torch.exp(-0.5 * ((vx - v0) / sigma)**2)
        f_init = profile[None, None, :, None].expand(Nx, Ny, Nvx, Nvy).clone()

        # Velocities (Accelerations): broadcastable to (Nx, Ny, Nvy) for axis 2
        a_drift = 1.0
        velocities = torch.full((Nx, Ny, Nvy), a_drift)

    else:  # Vy (axis=3)
        dx_slice = dvy
        grid_1d = vy
        grid_min = -Vy_max
        L_slice = 2 * Vy_max

        v0 = 0.0
        sigma = Vy_max / 4.0
        profile = torch.exp(-0.5 * ((vy - v0) / sigma)**2)
        f_init = profile[None, None, None, :].expand(Nx, Ny, Nvx, Nvy).clone()

        # Velocities (Accelerations): broadcastable to (Nx, Ny, Nvx) for axis 3
        a_drift = 1.0
        velocities = torch.full((Nx, Ny, Nvx), a_drift)

    dt = 0.1

    # Run advection (API: f_data, velocities, axis, dt, dx, periodic)
    if kernel == 2:  # static kernel: always Dirichlet, no periodic argument
        # per-spatial-point field with shape (Nx, Ny)
        E = torch.full((Nx, Ny), a_drift)
        f_next = advect_v_static_ref_api(
            f_init,
            E,
            axis,
            dt,
            dx_slice,
            grid_instance.stencil_offsets,
        )
    else:
        f_next = _ADVECT_KERNELS[kernel](
            f_init,
            velocities,
            axis,
            dt,
            dx_slice,
            point_indices=_point_indices_for_axis(grid_instance, axis),
            stencil_offsets=grid_instance.stencil_offsets,
            periodic=False
        )

    # Check result
    shift = a_drift * dt

    # Analytical solution (Dirichlet)
    departure_points = grid_1d - shift
    mask = (departure_points >= grid_min) & (departure_points <= grid_min + L_slice)

    profile_expected = torch.exp(-0.5 * ((departure_points - v0) / sigma)**2)
    profile_expected = torch.where(mask, profile_expected, torch.tensor(0.0))

    if axis == 2:
        f_expected = profile_expected[None, None, :, None].expand(Nx, Ny, Nvx, Nvy)
    else:
        f_expected = profile_expected[None, None, None, :].expand(Nx, Ny, Nvx, Nvy)

    assert torch.allclose(f_next, f_expected, atol=1e-2)


@pytest.mark.parametrize("kernel", [0, 1, 2])
@pytest.mark.parametrize("axis", [2, 3])
@pytest.mark.parametrize("shift_factor", [1.0, 1.5, 2.7, 4.2])
def test_advect_1d_velocity_multi_cell_shift(grid_instance, axis, kernel, shift_factor):
    """
    Regression test for departure points that cross one or more full
    velocity grid cells, i.e. dt * |a_drift| >= dv.

    advect_1d_matrix_diag (kernel 1) mirrors the same bug class fixed in
    vlasov1D1V.py's `advect_1d_matrix_diag`: a roll-based kernel that only
    tracked the fixed stencil tap (-2..3) while assuming the per-row
    integer departure shift (`idx_left`) was always 0 would silently break
    once a departure point crosses a full grid cell. This checks both
    kernels still track the analytical Dirichlet-truncated Gaussian shift
    once the shift spans multiple cells.
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

    if axis == 2:
        dv = dvx
        grid_1d = vx
        V_max = Vx_max
        v0 = 0.0
        sigma = Vx_max / 4.0
        profile = torch.exp(-0.5 * ((vx - v0) / sigma)**2)
        f_init = profile[None, None, :, None].expand(Nx, Ny, Nvx, Nvy).clone()
        batch_shape = (Nx, Ny, Nvy)
    else:
        dv = dvy
        grid_1d = vy
        V_max = Vy_max
        v0 = 0.0
        sigma = Vy_max / 4.0
        profile = torch.exp(-0.5 * ((vy - v0) / sigma)**2)
        f_init = profile[None, None, None, :].expand(Nx, Ny, Nvx, Nvy).clone()
        batch_shape = (Nx, Ny, Nvx)

    dt = 0.1
    # dt * a_drift == shift_factor * dv, so shift_factor >= 1 exercises dt*|a| >= dv.
    a_drift = shift_factor * dv / dt
    velocities = torch.full(batch_shape, a_drift)

    shift = a_drift * dt
    assert shift >= dv - 1e-9  # sanity check: actually exercising dt * |a| >= dv

    if kernel == 2:  # static kernel: always Dirichlet, no periodic argument
        E = torch.full((Nx, Ny), a_drift)
        f_next = advect_v_static_ref_api(
            f_init,
            E,
            axis,
            dt,
            dv,
            grid_instance.stencil_offsets,
        )
    else:
        f_next = _ADVECT_KERNELS[kernel](
            f_init,
            velocities,
            axis,
            dt,
            dv,
            point_indices=_point_indices_for_axis(grid_instance, axis),
            stencil_offsets=grid_instance.stencil_offsets,
            periodic=False
        )

    # Analytical solution with Dirichlet BCs (departure points outside domain -> 0)
    departure_points = grid_1d - shift
    profile_expected = torch.exp(-0.5 * ((departure_points - v0) / sigma)**2)
    mask = (departure_points >= -V_max) & (departure_points <= V_max)
    profile_expected = torch.where(mask, profile_expected, torch.tensor(0.0))

    if axis == 2:
        f_expected = profile_expected[None, None, :, None].expand(Nx, Ny, Nvx, Nvy)
    else:
        f_expected = profile_expected[None, None, None, :].expand(Nx, Ny, Nvx, Nvy)

    assert torch.allclose(f_next, f_expected, atol=1e-2)


@pytest.mark.parametrize("axis", [0, 1, 2, 3])
@pytest.mark.parametrize("shift_factor", [1.0, 1.5, 2.7, 4.2, 6.0])
def test_advect_1d_matrix_diag_matches_vectorized_multi_cell_shift(grid_params, axis, shift_factor):
    """
    Direct cross-check between the two advection kernels (not against the
    truncated analytical formula, so it is not limited by Lagrange
    truncation error): for dt * |velocity| >= dx (or dv), advect_1d_matrix_diag
    must reproduce advect_1d to floating-point precision, on both the
    periodic (X, Y) and non-periodic (Vx, Vy) branches.

    Uses a dedicated float64 grid (rather than the float32 `grid_instance`
    fixture) so the tight tolerance below reflects kernel agreement, not
    float32 rounding.
    """
    grid = src.vlasov2D2V.Grid.create(**grid_params, device='cpu', dtype=torch.float64)
    Nx, Ny, Nvx, Nvy = grid.Nx, grid.Ny, grid.Nvx, grid.Nvy

    axis_to_dx = {0: grid.dx, 1: grid.dy, 2: grid.dvx, 3: grid.dvy}
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

    torch.manual_seed(0)
    f = torch.rand(Nx, Ny, Nvx, Nvy, dtype=torch.float64)
    dt = 0.1

    velocities = torch.full(batch_shape, shift_factor * dx / dt, dtype=torch.float64)

    f_vectorized = src.vlasov2D2V.advect_1d(
        f, velocities, axis, dt, dx,
        point_indices=_point_indices_for_axis(grid, axis),
        stencil_offsets=grid.stencil_offsets,
        periodic=periodic,
    )
    f_matrix_diag = src.vlasov2D2V.advect_1d_matrix_diag(
        f, velocities, axis, dt, dx,
        point_indices=_point_indices_for_axis(grid, axis),
        stencil_offsets=grid.stencil_offsets,
        periodic=periodic,
    )

    assert torch.allclose(f_matrix_diag, f_vectorized, atol=1e-10, rtol=1e-10)


@pytest.mark.parametrize("physics_mode", [False, True])
def test_vlasov_step_matrix_diag_matches_vlasov_step(grid_params, physics_mode):
    """
    Direct cross-check between `vlasov_step_matrix_diag` and
    `vlasov_step_impl`: both implement the same Strang-split
    Vlasov-Poisson step, just with different (gather-free vs gather-based)
    advection kernels, so a single step from the same initial condition
    must agree to floating-point precision.
    """
    grid = src.vlasov2D2V.Grid.create(**grid_params, device='cpu', dtype=torch.float64)
    g = grid

    torch.manual_seed(0)
    f = torch.rand(g.Nx, g.Ny, g.Nvx, g.Nvy, dtype=torch.float64)
    f0 = torch.zeros(g.Nvx, g.Nvy, dtype=torch.float64)
    dt = 0.05

    # Bypass the torch.compile wrapper so the comparison is between the two
    # kernels themselves, not affected by dynamo/inductor compilation.
    step_impl = getattr(
        src.vlasov2D2V.vlasov_step_impl, "_torchdynamo_orig_callable", src.vlasov2D2V.vlasov_step_impl
    )

    args = (
        f0, dt, g.x, g.y, g.vx, g.vy,
        g.kx, g.ky, g.inv_ksq,
        g.x_indices, g.y_indices, g.vx_indices, g.vy_indices, g.stencil_offsets,
        g.dx, g.dy, g.dvx, g.dvy,
        g.Nx, g.Ny,
        physics_mode,
    )

    f_ref, rho_ref, phi_ref = step_impl(f, *args)
    f_diag, rho_diag, phi_diag = src.vlasov2D2V.vlasov_step_matrix_diag(f, *args)

    assert torch.allclose(f_diag, f_ref, atol=1e-9, rtol=1e-9)
    assert torch.allclose(rho_diag, rho_ref, atol=1e-9, rtol=1e-9)
    assert torch.allclose(phi_diag, phi_ref, atol=1e-9, rtol=1e-9)


@pytest.mark.parametrize("axis", [0, 1, 2, 3])
@pytest.mark.parametrize("shift_factor", [0.3, 1.0, 1.5, 2.7, 4.2, 6.0])
def test_advect_static_matches_vectorized(grid_params, axis, shift_factor):
    """
    Direct cross-check between the static kernels (kernel 2:
    advect_x_static / advect_v_static) and advect_1d (kernel 0, the
    reference gather-based kernel). Velocities vary per vx/vy coordinate
    for the spatial drifts (exercising multiple static shift blocks in
    block_roll) and per (x, y) point for the kicks (exercising the tap
    window collapse); shift_factor >= 1 covers departure points crossing
    one or more full grid cells. Not bounded by Lagrange truncation
    error, so agreement must be at roundoff level (float64 grid, as in
    the matrix_diag cross-check above). Mirrors
    `test_advect_static_matches_vectorized` in the JAX
    test_advection.py.
    """
    grid = src.vlasov2D2V.Grid.create(**grid_params, device='cpu', dtype=torch.float64)
    Nx, Ny, Nvx, Nvy = grid.Nx, grid.Ny, grid.Nvx, grid.Nvy

    axis_to_dx = {0: grid.dx, 1: grid.dy, 2: grid.dvx, 3: grid.dvy}
    dx = axis_to_dx[axis]

    torch.manual_seed(0)
    f = torch.rand(Nx, Ny, Nvx, Nvy, dtype=torch.float64)
    dt = 0.1

    if axis in (0, 1):
        # Spatial drift: velocities proportional to vx/vy (monotonic,
        # sign-changing) with max displacement = shift_factor cells.
        if axis == 0:
            velocities_1d = grid.vx / grid.Vx_max * (shift_factor * dx / dt)
            velocities = velocities_1d[None, :, None]  # batch (Ny, Nvx, Nvy)
        else:
            velocities_1d = grid.vy / grid.Vy_max * (shift_factor * dx / dt)
            velocities = velocities_1d[None, None, :]  # batch (Nx, Nvx, Nvy)

        f_vectorized = src.vlasov2D2V.advect_1d(
            f, velocities, axis, dt, dx,
            point_indices=_point_indices_for_axis(grid, axis),
            stencil_offsets=grid.stencil_offsets,
            periodic=True,
        )
        f_static = advect_x_static_ref_api(
            f, velocities_1d, axis, dt, dx, grid.stencil_offsets
        )
    else:
        # Kick: E(x, y) varying in sign and magnitude with max displacement
        # = shift_factor cells.
        E = (shift_factor * dx / dt) * (
            torch.sin(2.0 * torch.pi * torch.arange(Nx, dtype=torch.float64) / Nx)[:, None]
            * torch.cos(2.0 * torch.pi * torch.arange(Ny, dtype=torch.float64) / Ny)[None, :]
        )
        f_vectorized = src.vlasov2D2V.advect_1d(
            f, E[:, :, None], axis, dt, dx,
            point_indices=_point_indices_for_axis(grid, axis),
            stencil_offsets=grid.stencil_offsets,
            periodic=False,
        )
        f_static = advect_v_static_ref_api(
            f, E, axis, dt, dx, grid.stencil_offsets
        )

    assert torch.allclose(f_static, f_vectorized, atol=1e-10, rtol=1e-10)


@pytest.mark.parametrize("physics_mode", [False, True])
def test_vlasov_step_gather_free_matches_vlasov_step(grid_params, physics_mode):
    """
    Direct cross-check between `vlasov_step_gather_free` and
    `vlasov_step_impl`: both implement the same Strang-split
    Vlasov-Poisson step, just with the static (no data-dependent memory
    access) advection kernels instead of the gather-based ones, so a step
    from the same initial condition must agree to floating-point
    precision. Uses the Landau-damping initial condition so physics mode
    exercises a smooth, small E field inside the default S=1 window.
    """
    grid = src.vlasov2D2V.Grid.create(**grid_params, device='cpu', dtype=torch.float64)
    g = grid

    import math
    kx_mode = 2.0 * math.pi / g.Lx
    ky_mode = 2.0 * math.pi / g.Ly
    energy = 0.5 * (g.vx[:, None]**2 + g.vy[None, :]**2)
    f0v = torch.exp(-energy) / (2.0 * math.pi)
    f = (1.0 + 0.05 * torch.cos(kx_mode * g.x)[:, None, None, None]
             * torch.cos(ky_mode * g.y)[None, :, None, None]) * f0v[None, None, :, :]
    f = f.to(torch.float64)
    f0 = torch.zeros(g.Nvx, g.Nvy, dtype=torch.float64)
    dt = 0.05

    # Bypass the torch.compile wrapper so the comparison is between the two
    # kernels themselves, not affected by dynamo/inductor compilation.
    step_impl = getattr(
        src.vlasov2D2V.vlasov_step_impl, "_torchdynamo_orig_callable", src.vlasov2D2V.vlasov_step_impl
    )

    args = (
        f0, dt, g.x, g.y, g.vx, g.vy,
        g.kx, g.ky, g.inv_ksq,
        g.x_indices, g.y_indices, g.vx_indices, g.vy_indices, g.stencil_offsets,
        g.dx, g.dy, g.dvx, g.dvy,
        g.Nx, g.Ny,
        physics_mode,
    )

    f_ref, rho_ref, phi_ref = step_impl(f, *args)
    f_static, rho_static, phi_static = src.vlasov2D2V.vlasov_step_gather_free(f, *args)

    if physics_mode:
        # guard the S=1 static-window assumption of the kick
        Ex, Ey, _, _ = src.vlasov2D2V.solve_poisson_real(f, g.kx, g.ky, g.inv_ksq, g.dvx, g.dvy)
        assert src.vlasov2D2V.check_v_window(Ex, dt, g.dvx, 1) < 1
        assert src.vlasov2D2V.check_v_window(Ey, dt, g.dvy, 1) < 1

    assert torch.allclose(f_static, f_ref, atol=1e-9, rtol=1e-9)
    assert torch.allclose(rho_static, rho_ref, atol=1e-9, rtol=1e-9)
    assert torch.allclose(phi_static, phi_ref, atol=1e-9, rtol=1e-9)
