"""
Tests for the vlasov_step function.
vlasov_step(carry, g, dt, physics_mode) -> (f_next, rho, phi)
  carry = (f, rho, phi)
  g     = Grid (passed as a separate argument, not part of the carry)
"""
import jax
import jax.numpy as jnp
import numpy as np
import pytest
import src.vlasov1D1V
from src.vlasov1D1V import (
    Grid, Field, Variables, SimulationState,
    vlasov_step, advect_1d_vectorized, solve_poisson,
    vlasov_step_matrix_diag, vlasov_step_gather_free,
)

solver_map = {
    0: vlasov_step,
    1: vlasov_step_matrix_diag,
    2: vlasov_step_gather_free,
}


# ------------------------------------------------------------------ fixtures --

@pytest.fixture
def small_grid():
    """A small grid for fast unit tests."""
    return Grid.create(Nx=32, Nv=32, L=2.0 * jnp.pi, V_max=4.0)


@pytest.fixture
def gaussian_state(small_grid):
    """Gaussian pulse state (physics_mode=False)."""
    g = small_grid
    x_2d = g.x[:, None]
    v_2d = g.v[None, :]
    x0, v0 = g.L / 2.0, 0.0
    sigma_x, sigma_v = g.L / 10.0, g.V_max / 4.0
    f = jnp.exp(-0.5 * ((x_2d - x0) ** 2 / sigma_x ** 2
                        + (v_2d - v0) ** 2 / sigma_v ** 2))
    rho = jnp.zeros(g.Nx)
    phi = jnp.zeros(g.Nx)
    return f, rho, phi


@pytest.fixture
def landau_state(small_grid):
    """Landau-damping state (physics_mode=True)."""
    g = small_grid
    eps = 0.001
    kx = 2.0 * jnp.pi / g.L
    x_2d = g.x[:, None]
    v_2d = g.v[None, :]
    f = (1.0 + eps * jnp.cos(kx * x_2d)) / jnp.sqrt(2.0 * jnp.pi) * jnp.exp(-0.5 * v_2d ** 2)
    _, rho, phi = solve_poisson(f, g.inv_kx, g.dv)
    return f, rho, phi


# -------------------------------------------------------- signature / shape ---
@pytest.mark.parametrize("solver", [0, 1, 2])
def test_vlasov_step_returns_tuple(small_grid, gaussian_state, solver):
    """vlasov_step must return a plain tuple (f, rho, phi)."""
    carry = gaussian_state

    vlasov_fn = solver_map[solver]

    result = vlasov_fn(carry, small_grid, 0.05, False)

    assert isinstance(result, tuple)
    assert len(result) == 3


@pytest.mark.parametrize("solver", [0, 1, 2])
def test_vlasov_step_output_shapes(small_grid, gaussian_state, solver):
    """Output shapes must match the grid dimensions."""
    g = small_grid
    vlasov_fn = solver_map[solver]

    f_out, rho_out, phi_out = vlasov_fn(gaussian_state, g, 0.05, False)

    assert f_out.shape == (g.Nx, g.Nv)
    assert rho_out.shape == (g.Nx,)
    assert phi_out.shape == (g.Nx,)


@pytest.mark.parametrize("solver", [0, 1, 2])
def test_vlasov_step_output_dtype(small_grid, gaussian_state, solver):
    """Outputs should be float32 (same as input)."""
    g = small_grid
    vlasov_fn = solver_map[solver]

    f_out, rho_out, phi_out = vlasov_fn(gaussian_state, g, 0.05, False)

    assert f_out.dtype == jnp.float32
    assert rho_out.dtype == jnp.float32
    assert phi_out.dtype == jnp.float32


# -------------------------------------------------- physics_mode = False ------

@pytest.mark.parametrize("solver", [0, 1, 2])
def test_step_no_physics_rho_phi_zero(small_grid, gaussian_state, solver):
    """When physics_mode=False, rho and phi should be zero."""
    vlasov_fn = solver_map[solver]
    _, rho, phi = vlasov_fn(gaussian_state, small_grid, 0.05, False)

    assert jnp.allclose(rho, 0.0, atol=1e-7)
    assert jnp.allclose(phi, 0.0, atol=1e-7)


@pytest.mark.parametrize("solver", [0, 1, 2])
def test_step_no_physics_f_changes(small_grid, gaussian_state, solver):
    """Even without E-field the distribution should advect (free-streaming)."""
    f_in = gaussian_state[0]
    vlasov_fn = solver_map[solver]
    f_out, _, _ = vlasov_fn(gaussian_state, small_grid, 0.05, False)

    # f should change (Gaussian shifts due to velocity advection)
    assert not jnp.allclose(f_out, f_in, atol=1e-6)


@pytest.mark.parametrize("solver", [0, 1, 2])
def test_step_no_physics_mass_conservation(small_grid, gaussian_state, solver):
    """Total mass = integral(f) dx dv must be conserved (periodic + Dirichlet
    with negligible boundary flux)."""
    g = small_grid
    f_in = gaussian_state[0]
    vlasov_fn = solver_map[solver]
    f_out, _, _ = vlasov_fn(gaussian_state, g, 0.01, False)

    mass_in = jnp.sum(f_in) * g.dx * g.dv
    mass_out = jnp.sum(f_out) * g.dx * g.dv

    # Loose tolerance because Dirichlet BC in v can leak a tiny amount
    assert jnp.isclose(mass_in, mass_out, rtol=1e-3)

@pytest.mark.parametrize("solver", [0, 1, 2])
def test_step_zero_dt_is_identity(small_grid, gaussian_state, solver):
    """With dt=0 the step should be a no-op."""
    f_in = gaussian_state[0]
    vlasov_fn = solver_map[solver]
    f_out, _, _ = vlasov_fn(gaussian_state, small_grid, 0.0, False)

    assert jnp.allclose(f_out, f_in, atol=1e-6)


# -------------------------------------------------- physics_mode = True -------

@pytest.mark.parametrize("solver", [0, 1, 2])
def test_step_physics_rho_phi_nonzero(small_grid, landau_state, solver):
    """When physics_mode=True, Poisson solve should produce non-zero rho, phi."""
    vlasov_fn = solver_map[solver]
    _, rho, phi = vlasov_fn(landau_state, small_grid, 0.05, True)

    assert not jnp.allclose(rho, 0.0, atol=1e-10)
    assert not jnp.allclose(phi, 0.0, atol=1e-10)


@pytest.mark.parametrize("solver", [0, 1, 2])
def test_step_physics_f_changes(small_grid, landau_state, solver):
    """With E-field the distribution should evolve."""
    f_in = landau_state[0]
    vlasov_fn = solver_map[solver]
    f_out, _, _ = vlasov_fn(landau_state, small_grid, 0.05, True)

    assert not jnp.allclose(f_out, f_in, atol=1e-6)


# ------------------------------------------------- JIT compatibility ---------


@pytest.mark.parametrize("solver", [0, 1, 2])
def test_vlasov_step_jit(small_grid, gaussian_state, solver):
    """vlasov_step must be JIT-compilable (the carry + grid pattern)."""
    g = small_grid
    vlasov_fn = solver_map[solver]
    jit_step = jax.jit(lambda carry: vlasov_fn(carry, g, 0.05, False))

    f_out, rho_out, phi_out = jit_step(gaussian_state)

    assert f_out.shape == (g.Nx, g.Nv)
    assert rho_out.shape == (g.Nx,)
    assert phi_out.shape == (g.Nx,)


@pytest.mark.parametrize("solver", [0, 1, 2])
def test_vlasov_step_jit_physics(small_grid, landau_state, solver):
    """JIT compilation with physics_mode=True."""
    g = small_grid
    vlasov_fn = solver_map[solver]
    jit_step = jax.jit(lambda carry: vlasov_fn(carry, g, 0.05, True))

    f_out, rho_out, phi_out = jit_step(landau_state)

    assert f_out.shape == (g.Nx, g.Nv)
    assert not jnp.allclose(rho_out, 0.0, atol=1e-10)


# ----------------------------------------------- fori_loop compatibility ------


@pytest.mark.parametrize("solver", [0, 1, 2])
def test_vlasov_step_in_fori_loop(small_grid, gaussian_state, solver):
    """vlasov_step must work as the body of lax.fori_loop (the optimized pattern)."""
    g = small_grid
    vlasov_fn = solver_map[solver]

    @jax.jit
    def run_chunk(carry):
        def body_fn(_, c):
            return vlasov_fn(c, g, 0.05, False)
        return jax.lax.fori_loop(0, 5, body_fn, carry)

    f_out, rho_out, phi_out = run_chunk(gaussian_state)

    assert f_out.shape == (g.Nx, g.Nv)
    assert rho_out.shape == (g.Nx,)

@pytest.mark.parametrize("solver", [0, 1, 2])
def test_vlasov_step_in_fori_loop_physics(small_grid, landau_state, solver):
    """fori_loop with physics_mode=True."""
    g = small_grid
    vlasov_fn = solver_map[solver]
    @jax.jit
    def run_chunk(carry):
        def body_fn(_, c):
            return vlasov_fn(c, g, 0.05, True)
        return jax.lax.fori_loop(0, 5, body_fn, carry)

    f_out, rho_out, phi_out = run_chunk(landau_state)

    assert f_out.shape == (g.Nx, g.Nv)
    assert not jnp.allclose(rho_out, 0.0, atol=1e-10)


# ---------------------------------------- Strang splitting consistency --------
@pytest.mark.parametrize("solver", [0, 1, 2])
def test_strang_splitting_free_stream(small_grid, solver):
    """
    For E=0, Strang splitting reduces to pure X-advection.
    Compare vlasov_step against two half-drift X steps.
    """
    g = small_grid
    dt = 0.05

    # Gaussian
    x_2d = g.x[:, None]
    v_2d = g.v[None, :]
    x0, v0 = g.L / 2.0, 0.0
    sigma_x, sigma_v = g.L / 10.0, g.V_max / 4.0
    f = jnp.exp(-0.5 * ((x_2d - x0) ** 2 / sigma_x ** 2
                        + (v_2d - v0) ** 2 / sigma_v ** 2))
    rho = jnp.zeros(g.Nx)
    phi = jnp.zeros(g.Nx)

    # vlasov_step
    vlasov_fn = solver_map[solver]
    f_step, _, _ = vlasov_fn((f, rho, phi), g, dt, False)

    # Manual Strang: drift X(dt/2) → kick V(dt, E=0) → drift X(dt/2)
    f1 = advect_1d_vectorized(
        f.T, g.v, dt / 2.0, g.dx, g.stencil_offsets, periodic=True
    ).T
    # E=0 → f_star2 = advect_1d_vectorized(f1, 0, dt, dv, periodic=False) = f1
    E_zero = jnp.zeros(g.Nx)
    f2 = advect_1d_vectorized(
        f1, E_zero, dt, g.dv, g.stencil_offsets, periodic=False
    )
    f3 = advect_1d_vectorized(
        f2.T, g.v, dt / 2.0, g.dx, g.stencil_offsets, periodic=True
    ).T

    assert jnp.allclose(f_step, f3, atol=1e-6)

@pytest.mark.parametrize("solver", [0, 1, 2])
def test_two_steps_differ_from_one(small_grid, gaussian_state, solver):
    """Two consecutive steps should differ from a single step with 2*dt
    (Strang splitting is not time-linear)."""
    g = small_grid
    dt = 0.05

    # Single step with 2*dt
    vlasov_fn = solver_map[solver]
    f_one, _, _ = vlasov_fn(gaussian_state, g, 2 * dt, False)

    # Two consecutive steps with dt
    carry1 = vlasov_fn(gaussian_state, g, dt, False)
    f_two, _, _ = vlasov_fn(carry1, g, dt, False)

    # They should differ (Strang splitting is operator-split, not linear in dt)
    assert not jnp.allclose(f_one, f_two, atol=1e-6)


# ------------------------------------------- gather-free solver (solver 2) ----

@pytest.mark.parametrize("physics_mode", [False, True])
def test_gather_free_matches_reference_trajectory(small_grid, landau_state,
                                                  physics_mode):
    """
    vlasov_step_gather_free must reproduce the vlasov_step (solver 0) and
    vlasov_step_matrix_diag (solver 1) trajectories at roundoff level: it is
    the same Lagrange-5 Strang step, only reformulated with static shifts.
    Not bounded by truncation error, so the tolerance is tight.
    """
    g = small_grid
    dt = 0.05
    c2 = c0 = c1 = landau_state
    for _ in range(10):
        c2 = vlasov_step_gather_free(c2, g, dt, physics_mode)
        c0 = vlasov_step(c0, g, dt, physics_mode)
        c1 = vlasov_step_matrix_diag(c1, g, dt, physics_mode)

    assert jnp.allclose(c2[0], c0[0], atol=1e-5, rtol=1e-5)
    assert jnp.allclose(c2[0], c1[0], atol=1e-5, rtol=1e-5)
    assert jnp.allclose(c2[1], c0[1], atol=1e-5, rtol=1e-5)  # rho
    assert jnp.allclose(c2[2], c0[2], atol=1e-5, rtol=1e-5)  # phi


def test_gather_free_lowering_has_no_gather(small_grid, landau_state):
    """
    The whole point of solver 2: the StableHLO lowering of one jitted step
    must contain zero gather ops (no data-dependent memory access), unlike
    the reference solvers.
    """
    g = small_grid
    dt = 0.05

    def lowered_text(vlasov_fn):
        step = jax.jit(lambda carry: vlasov_fn(carry, g, dt, True))
        return str(step.lower(landau_state).compiler_ir(dialect="stablehlo"))

    assert "stablehlo.gather" not in lowered_text(vlasov_step_gather_free)
    # Sanity check that the probe actually detects gathers on the reference.
    assert "stablehlo.gather" in lowered_text(vlasov_step)
