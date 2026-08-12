import torch
import pytest
import math
import src.vlasov2D2V

def test_variables_initialization(variables_instance, grid_instance):
    """Test Variables initialization."""
    assert variables_instance.fn.shape == (grid_instance.Nx, grid_instance.Ny,
                                           grid_instance.Nvx, grid_instance.Nvy)
    assert variables_instance.f0.shape == (grid_instance.Nvx, grid_instance.Nvy)

def test_variables_dataclass_fields(variables_instance):
    """Test that Variables dataclass has expected fields and they are accessible."""
    Variables = src.vlasov2D2V.Variables

    # Check that all expected attributes exist
    assert hasattr(variables_instance, 'fn')
    assert hasattr(variables_instance, 'f0')

    # Check it's an instance of Variables
    assert isinstance(variables_instance, Variables)

def test_variables_mean(variables_instance):
    """Test that operations on Variables members work correctly."""
    result = torch.mean(variables_instance.fn)
    assert torch.isclose(result, torch.mean(variables_instance.fn))

@pytest.mark.parametrize("physics_mode", [True, False])
def test_vlasov_initialize(physics_mode, tmp_path):
    """Test the initialize method of Vlasov class with different physics modes."""
    eps = 0.001
    solver = src.vlasov2D2V.Vlasov(
        Nx=32, Ny=32, Nvx=32, Nvy=32, nbiter=10,
        physics_mode=physics_mode, epsilon=eps, out_dir=str(tmp_path)
    )
    state = solver.initialize()

    assert isinstance(state, src.vlasov2D2V.SimulationState)
    assert state.t == 0.0
    assert state.step == 0

    # Check fields
    assert state.field.rho.shape == (solver.grid.Nx, solver.grid.Ny)
    assert state.field.phi.shape == (solver.grid.Nx, solver.grid.Ny)

    # Check variables
    assert state.variables.fn.shape == (solver.grid.Nx, solver.grid.Ny,
                                        solver.grid.Nvx, solver.grid.Nvy)
    assert state.variables.f0.shape == (solver.grid.Nvx, solver.grid.Nvy)

    grid = solver.grid
    x_mesh = grid.x[:, None, None, None]
    y_mesh = grid.y[None, :, None, None]
    vx_mesh = grid.vx[:, None]
    vy_mesh = grid.vy[None, :]

    if physics_mode:
        # 1. If physics_mode is true, f0 is a 2D maxwellian
        energy = 0.5 * (vx_mesh**2 + vy_mesh**2)
        expected_f0 = 1.0 / math.sqrt(2.0 * math.pi) * torch.exp(-energy)
        assert torch.allclose(state.variables.f0, expected_f0, atol=1e-6)

        # 2. If physics_mode is true, fn is a maxwellian with single mode perturbation
        kx = 1 * 2.0 * math.pi / grid.Lx
        ky = 1 * 2.0 * math.pi / grid.Ly
        expected_fn = (1.0 + eps * torch.cos(kx * x_mesh) * torch.cos(ky * y_mesh)) \
                      * expected_f0[None, None, :, :]
        assert torch.allclose(state.variables.fn, expected_fn, atol=1e-6)

    else:
        # 3. If physics_mode is false, f0 is zero
        assert torch.all(state.variables.f0 == 0.0)

        # 4. If physics_mode is false, fn is a 4D gaussian pulse
        x0, y0 = grid.Lx / 2.0, grid.Ly / 2.0
        vx0, vy0 = 0.0, 0.0
        sigma_x = grid.Lx / 10.0
        sigma_v = grid.Vx_max / 4.0
        dx2 = (x_mesh - x0)**2 / sigma_x**2
        dy2 = (y_mesh - y0)**2 / sigma_x**2
        vx2 = (vx_mesh[None, None, :, :] - vx0)**2 / sigma_v**2
        vy2 = (vy_mesh[None, None, :, :] - vy0)**2 / sigma_v**2
        expected_fn = torch.exp(-0.5 * (dx2 + dy2 + vx2 + vy2))
        assert torch.allclose(state.variables.fn, expected_fn, atol=1e-6)
