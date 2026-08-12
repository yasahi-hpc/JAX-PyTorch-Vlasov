import jax
import jax.numpy as jnp
import numpy as np
import math
import pytest
import src.heat3d


class TestHeatInitialize:
    """Tests for Heat.initialize()."""

    def test_initialize_returns_simulation_state(self, solver_small):
        """initialize() should return a SimulationState."""
        state = solver_small.initialize()
        assert isinstance(state, src.heat3d.SimulationState)

    def test_initialize_time_and_step(self, solver_small):
        """Initial state should have t=0 and step=0."""
        state = solver_small.initialize()
        assert state.t == 0.0
        assert state.step == 0

    def test_initialize_grid_consistency(self, solver_small):
        """Grid in the state should match the solver's grid."""
        state = solver_small.initialize()
        assert state.grid.Nx == solver_small.grid.Nx
        assert state.grid.Ny == solver_small.grid.Ny
        assert state.grid.Nz == solver_small.grid.Nz

    def test_initialize_field_shapes(self, solver_small):
        """u should have shape (N, N, N)."""
        state = solver_small.initialize()
        N = solver_small.grid.Nx
        assert state.variables.u.shape == (N, N, N)

    def test_initialize_u_is_cosine(self, solver_small):
        """u should be cos(kx*x)*cos(ky*y)*cos(kz*z)."""
        state = solver_small.initialize()
        g = solver_small.grid
        k = solver_small.k

        x, y, z = jnp.meshgrid(g.x, g.y, g.z, indexing="ij")
        expected = jnp.cos(k * x) * jnp.cos(k * y) * jnp.cos(k * z)

        assert jnp.allclose(state.variables.u, expected, atol=1e-6)


class TestHeatAnalytical:
    """Tests for Heat.analytical()."""

    def test_analytical_shape(self, solver_small):
        """Analytical solution should have shape (N, N, N)."""
        u_ref = solver_small.analytical()
        N = solver_small.grid.Nx
        assert u_ref.shape == (N, N, N)

    def test_analytical_at_t0(self):
        """At t=0 (nbiter=0), analytical = initial condition."""
        solver = src.heat3d.Heat(N=16, nbiter=0, diag_steps=1, dt=1e-4, kappa=1.0)
        u_ref = solver.analytical()

        state = solver.initialize()
        assert jnp.allclose(u_ref, state.variables.u, atol=1e-6)

    def test_analytical_decays(self, solver_small):
        """Analytical solution amplitude should decay with time."""
        state = solver_small.initialize()
        u_ref = solver_small.analytical()

        # Amplitude should be less than the initial condition
        assert jnp.max(jnp.abs(u_ref)) < jnp.max(jnp.abs(state.variables.u))

    def test_analytical_formula(self, solver_small):
        """Verify the analytical formula: u0 * exp(-kappa * k^2 * t)."""
        g = solver_small.grid
        k = solver_small.k
        kappa = solver_small.kappa
        dt = solver_small.dt
        nbiter = solver_small.nbiter

        ksq = k**2 + k**2 + k**2
        t_final = nbiter * dt
        decay = math.exp(-kappa * ksq * t_final)

        x, y, z = jnp.meshgrid(g.x, g.y, g.z, indexing="ij")
        u0 = jnp.cos(k * x) * jnp.cos(k * y) * jnp.cos(k * z)
        expected = u0 * decay

        u_ref = solver_small.analytical()
        assert jnp.allclose(u_ref, expected, atol=1e-6)


class TestHeatRun:
    """Tests for Heat.run() — the full time integration."""

    def test_run_returns_simulation_state(self, solver_small):
        """run() should return a SimulationState."""
        state = solver_small.initialize()
        final = solver_small.run(state)
        assert isinstance(final, src.heat3d.SimulationState)

    def test_run_advances_time(self, solver_small):
        """After run, t and step should be updated."""
        state = solver_small.initialize()
        final = solver_small.run(state)

        expected_t = solver_small.nbiter * solver_small.dt
        assert jnp.isclose(final.t, expected_t, atol=1e-10)
        assert final.step == solver_small.nbiter

    def test_run_field_not_nan(self, solver_small):
        """Output fields should not contain NaN."""
        state = solver_small.initialize()
        final = solver_small.run(state)
        assert not jnp.any(jnp.isnan(final.variables.u))

    def test_run_conserves_mean(self, solver_small):
        """
        The heat equation with periodic BC conserves the spatial mean of u.
        """
        state = solver_small.initialize()
        mean_before = jnp.mean(state.variables.u)

        final = solver_small.run(state)
        mean_after = jnp.mean(final.variables.u)

        assert jnp.isclose(mean_before, mean_after, atol=1e-4)

    def test_run_accuracy_vs_analytical(self):
        """
        Run the solver and compare against the analytical solution.
        Use small dt and small kappa for accuracy.
        """
        N = 16
        kappa = 1.0
        dt = 1e-4
        nbiter = 100

        solver = src.heat3d.Heat(
            N=N, nbiter=nbiter, diag_steps=nbiter + 1, dt=dt, kappa=kappa
        )
        state = solver.initialize()
        final = solver.run(state)

        u_numerical = final.variables.u
        u_ref = solver.analytical()

        err_l2 = float(
            jnp.linalg.norm((u_numerical - u_ref).reshape(-1))
            / jnp.linalg.norm(u_ref.reshape(-1))
        )
        # Forward Euler with this dt/dx should give good accuracy
        assert err_l2 < 1e-3, f"L2 relative error too large: {err_l2:.3e}"

    @pytest.mark.parametrize("nbiter", [1, 10, 50])
    def test_run_different_step_counts(self, nbiter):
        """Run should handle different iteration counts correctly."""
        solver = src.heat3d.Heat(
            N=8, nbiter=nbiter, diag_steps=nbiter + 1, dt=1e-4, kappa=1.0
        )
        state = solver.initialize()
        final = solver.run(state)

        assert final.step == nbiter
        assert jnp.isclose(final.t, nbiter * solver.dt, atol=1e-12)

    def test_run_idempotent_from_same_initial(self, solver_small):
        """Running from the same initial state twice should give identical results."""
        state = solver_small.initialize()

        final1 = solver_small.run(state)
        final2 = solver_small.run(state)

        assert jnp.array_equal(final1.variables.u, final2.variables.u)

    def test_run_with_diag_chunks(self):
        """
        Test the chunked execution path (num_steps > 0, i.e. nbiter > diag_steps).
        """
        solver = src.heat3d.Heat(
            N=8, nbiter=20, diag_steps=10, dt=1e-4, kappa=1.0
        )
        state = solver.initialize()
        final = solver.run(state)

        assert final.step == 20
        assert not jnp.any(jnp.isnan(final.variables.u))

    def test_run_single_step(self):
        """Running a single step should match heat_step directly."""
        N = 8
        kappa = 1.0
        dt = 1e-4
        L = 2.0 * jnp.pi
        dx = L / N

        solver = src.heat3d.Heat(N=N, nbiter=1, diag_steps=2, dt=dt, kappa=kappa)
        state = solver.initialize()
        final = solver.run(state)

        # Manually compute one step
        coeff = kappa * dt / (dx**2)
        expected = src.heat3d.heat_step(state.variables.u, coeff)

        assert jnp.allclose(final.variables.u, expected, atol=1e-6)

class TestHeatNewParameters:
    """Tests for the new solver_type, device, and dtype parameters."""

    def test_solver_type_default_is_heat_step(self):
        """Default solver_type=0 should use heat_step."""
        solver = src.heat3d.Heat(N=8, nbiter=5, diag_steps=10, dt=1e-4, kappa=1.0)
        assert solver.solver_type == 0

    @pytest.mark.parametrize("solver_type", [0, 1, 2])
    def test_solver_types_produce_state(self, solver_type):
        """All solver_type values (0, 1, 2) should run without error."""
        solver = src.heat3d.Heat(
            N=8, nbiter=5, diag_steps=10, dt=1e-4, kappa=1.0,
            solver_type=solver_type
        )
        state = solver.initialize()
        final = solver.run(state)
        assert isinstance(final, src.heat3d.SimulationState)
        assert not jnp.any(jnp.isnan(final.variables.u))

    def test_device_attribute_is_jax_device(self):
        """solver.device should be a JAX device object."""
        import jax
        solver = src.heat3d.Heat(N=8, nbiter=5, diag_steps=10, dt=1e-4, kappa=1.0)
        assert isinstance(solver.device, jax.Device)

    def test_dtype_float32(self):
        """dtype='float32' should produce float32 arrays."""
        solver = src.heat3d.Heat(
            N=8, nbiter=5, diag_steps=10, dt=1e-4, kappa=1.0, dtype='float32'
        )
        state = solver.initialize()
        assert state.variables.u.dtype == jnp.float32

    def test_dtype_float64(self):
        """dtype='float64' should produce float64 arrays (requires x64 enabled)."""
        jax.config.update("jax_enable_x64", True)
        try:
            solver = src.heat3d.Heat(
                N=8, nbiter=5, diag_steps=10, dt=1e-4, kappa=1.0, dtype='float64'
            )
            state = solver.initialize()
            assert state.variables.u.dtype == jnp.float64
        finally:
            jax.config.update("jax_enable_x64", False)

    def test_no_diag_msg_when_num_steps_zero(self):
        """no_diag_msg should be set when diag_steps > nbiter (num_steps == 0)."""
        solver = src.heat3d.Heat(
            N=8, nbiter=10, diag_steps=20, dt=1e-4, kappa=1.0
        )
        assert solver.num_steps == 0
        assert solver.no_diag_msg is not None
        assert isinstance(solver.no_diag_msg, str)

    def test_no_diag_msg_none_when_num_steps_positive(self):
        """no_diag_msg should be None when diag_steps <= nbiter (num_steps > 0)."""
        solver = src.heat3d.Heat(
            N=8, nbiter=20, diag_steps=10, dt=1e-4, kappa=1.0
        )
        assert solver.num_steps > 0
        assert solver.no_diag_msg is None