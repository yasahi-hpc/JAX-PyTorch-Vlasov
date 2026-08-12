import torch
import pytest
import math
import src.heat3d


def test_heat_initialize():
    """Test the initialize method of the Heat class."""
    N = 8
    L = 2.0 * math.pi
    solver = src.heat3d.Heat(N=N, L=L, nbiter=10, dt=0.001, kappa=0.001)
    state = solver.initialize()

    assert isinstance(state, src.heat3d.SimulationState)
    assert state.t == 0.0
    assert state.step == 0

    expected_shape = (N, N, N)
    assert state.variables.u.shape == expected_shape


def test_heat_initialize_values():
    """
    Test that initialize() produces the correct initial condition.
    u(x,y,z) = cos(k*x) * cos(k*y) * cos(k*z) with k=1.
    """
    N = 8
    L = 2.0 * math.pi
    solver = src.heat3d.Heat(N=N, L=L, nbiter=10, dt=0.001, kappa=0.001)
    state = solver.initialize()

    g = solver.grid
    x, y, z = torch.meshgrid(g.x, g.y, g.z, indexing='ij')
    k = 1.0
    expected_u = torch.cos(k * x) * torch.cos(k * y) * torch.cos(k * z)

    assert torch.allclose(state.variables.u, expected_u, atol=1e-6)


def test_heat_analytical():
    """
    Test the analytical solution at t = nbiter * dt.
    u_analytical = cos(kx*x)*cos(ky*y)*cos(kz*z) * exp(-kappa * k^2 * t)
    where k^2 = kx^2 + ky^2 + kz^2 = 3 for k=1.
    """
    N = 8
    L = 2.0 * math.pi
    nbiter = 100
    dt = 0.001
    kappa = 0.001
    solver = src.heat3d.Heat(N=N, L=L, nbiter=nbiter, dt=dt, kappa=kappa)

    u_analytical = solver.analytical()

    g = solver.grid
    x, y, z = torch.meshgrid(g.x, g.y, g.z, indexing='ij')
    k = 1.0
    ksq = 3.0 * k**2
    t = nbiter * dt
    expected = torch.cos(k * x) * torch.cos(k * y) * torch.cos(k * z) * math.exp(-kappa * ksq * t)

    assert torch.allclose(u_analytical, expected, atol=1e-6)


def test_heat_analytical_at_t0():
    """Test that the analytical solution at t=0 equals the initial condition."""
    N = 8
    L = 2.0 * math.pi
    solver = src.heat3d.Heat(N=N, L=L, nbiter=0, dt=0.001, kappa=0.001)

    state = solver.initialize()
    u_analytical = solver.analytical()

    assert torch.allclose(state.variables.u, u_analytical, atol=1e-6)


def test_heat_run_advances_time():
    """Test that run() advances the simulation time and step counter."""
    N = 8
    L = 2.0 * math.pi
    nbiter = 10
    dt = 0.001
    solver = src.heat3d.Heat(N=N, L=L, nbiter=nbiter, dt=dt, kappa=0.001)
    state = solver.initialize()
    final_state = solver.run(state)

    assert final_state.step == nbiter
    assert abs(final_state.t - nbiter * dt) < 1e-10


def test_heat_run_output_shape():
    """Test that run() returns variables with correct shapes."""
    N = 8
    L = 2.0 * math.pi
    solver = src.heat3d.Heat(N=N, L=L, nbiter=5, dt=0.001, kappa=0.001)
    state = solver.initialize()
    final_state = solver.run(state)

    expected_shape = (N, N, N)
    assert final_state.variables.u.shape == expected_shape


def test_heat_run_convergence():
    """
    Test that the numerical solution converges to the analytical solution.
    With a small enough dt and kappa, the L2 relative error should be small.
    """
    N = 16
    L = 2.0 * math.pi
    nbiter = 100
    dt = 0.0001
    kappa = 1.0
    solver = src.heat3d.Heat(N=N, L=L, nbiter=nbiter, dt=dt, kappa=kappa)

    state = solver.initialize()
    final_state = solver.run(state)

    u_numerical = final_state.variables.u
    u_analytical = solver.analytical()

    err_l2 = torch.linalg.norm((u_numerical - u_analytical).reshape(-1)) / torch.linalg.norm(u_analytical.reshape(-1))

    assert err_l2 < 1e-3, f"L2 relative error {err_l2:.3e} is too large"


def test_heat_run_conserves_mean():
    """The heat equation with periodic BC conserves the spatial mean of u."""
    N = 8
    L = 2.0 * math.pi
    solver = src.heat3d.Heat(N=N, L=L, nbiter=50, dt=0.001, kappa=0.01)

    state = solver.initialize()
    mean_before = torch.mean(state.variables.u)

    final_state = solver.run(state)
    mean_after = torch.mean(final_state.variables.u)

    assert torch.isclose(mean_before, mean_after, atol=1e-4)


def test_heat_run_decay():
    """
    Test that the solution decays over time (heat equation dissipates energy).
    """
    N = 8
    L = 2.0 * math.pi
    solver = src.heat3d.Heat(N=N, L=L, nbiter=50, dt=0.001, kappa=0.01)

    state = solver.initialize()
    initial_energy = torch.sum(state.variables.u**2)

    final_state = solver.run(state)
    final_energy = torch.sum(final_state.variables.u**2)

    assert final_energy < initial_energy, \
        f"Energy should decrease: initial={initial_energy:.4f}, final={final_energy:.4f}"


def test_heat_run_single_step():
    """Running a single step should match step() directly."""
    N = 8
    L = 2.0 * math.pi
    kappa = 1.0
    dt = 1e-4
    dx = L / N

    solver = src.heat3d.Heat(N=N, L=L, nbiter=1, dt=dt, kappa=kappa)
    state = solver.initialize()
    final_state = solver.run(state)

    coeff = kappa * dt / (dx ** 2)
    expected = src.heat3d.step(state.variables.u, coeff)

    assert torch.allclose(final_state.variables.u, expected, atol=1e-6)


@pytest.mark.parametrize("kappa", [0.0001, 0.001, 0.01])
def test_heat_analytical_decay_rate(kappa):
    """
    Test that the analytical solution decays at the expected rate for different kappa values.
    """
    N = 8
    L = 2.0 * math.pi
    nbiter = 100
    dt = 0.001
    solver = src.heat3d.Heat(N=N, L=L, nbiter=nbiter, dt=dt, kappa=kappa)

    u_analytical = solver.analytical()

    # The max value of the analytical solution should be exp(-kappa * 3 * t)
    # since cos has max value 1 and k^2 = 3
    t = nbiter * dt
    expected_max = math.exp(-kappa * 3.0 * t)
    actual_max = torch.max(u_analytical).item()

    assert abs(actual_max - expected_max) < 1e-5, \
        f"Max analytical value {actual_max:.6f} != expected {expected_max:.6f}"
