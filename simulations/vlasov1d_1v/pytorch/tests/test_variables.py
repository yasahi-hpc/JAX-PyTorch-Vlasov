import torch
import pytest
import math
import tempfile
import src.vlasov1D1V

def test_variables_initialization(variables_instance, grid_instance):
    """Test Variables initialization."""
    assert variables_instance.fn.shape == (grid_instance.Nx, grid_instance.Nv)
    assert variables_instance.f0.shape == (grid_instance.Nv,)

def test_variables_dataclass_fields(variables_instance):
    """Test that Variables dataclass has expected fields and they are accessible."""
    Variables = src.vlasov1D1V.Variables

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
    solver = src.vlasov1D1V.Vlasov(
        Nx=32, Nv=32, nbiter=10, physics_mode=physics_mode, out_dir=str(tmp_path)
    )
    state = solver.initialize()

    assert isinstance(state, src.vlasov1D1V.SimulationState)
    assert state.t == 0.0
    assert state.step == 0

    # Check fields
    assert state.field.rho.shape == (solver.grid.Nx,)
    assert state.field.phi.shape == (solver.grid.Nx,)

    # Check variables
    assert state.variables.fn.shape == (solver.grid.Nx, solver.grid.Nv)

    grid = solver.grid
    x_2d = grid.x[:, None]
    v_2d = grid.v[None, :]

    if physics_mode:
        # 1. If physics_mode is true, f0 is a maxwellian
        expected_f0 = 1.0 / math.sqrt(2.0 * math.pi) * torch.exp(-0.5 * grid.v**2)
        assert torch.allclose(state.variables.f0, expected_f0, atol=1e-6)

        # 2. If physics_mode is true, fn is a maxwellian with single mode perturbation
        eps = 0.001
        kx = 1 * 2.0 * math.pi / grid.L
        expected_fn = (1.0 + eps * torch.cos(kx * x_2d)) / math.sqrt(2.0 * math.pi) * torch.exp(-0.5 * v_2d**2)
        assert torch.allclose(state.variables.fn, expected_fn, atol=1e-6)

    else:
        # 3. If physics_mode is false, f0 is zero
        assert torch.all(state.variables.f0 == 0.0)

        # 4. If physics_mode is false, fn is a gaussian pulse
        x0, v0 = grid.L / 2.0, 0.0
        sigma_x, sigma_v = grid.L / 10.0, grid.V_max / 4.0
        expected_fn = torch.exp(-0.5 * ((x_2d - x0)**2 / sigma_x**2 + (v_2d - v0)**2 / sigma_v**2))
        assert torch.allclose(state.variables.fn, expected_fn, atol=1e-6)
