import torch
import pytest
import src.heat3d


def test_variables_initialization(variables_instance, grid_instance):
    """Test Variables initialization."""
    expected_shape = (grid_instance.Nx, grid_instance.Ny, grid_instance.Nz)
    assert variables_instance.u.shape == expected_shape


def test_variables_dataclass_fields(variables_instance):
    """Test that Variables dataclass has expected fields and they are accessible."""
    Variables = src.heat3d.Variables

    assert hasattr(variables_instance, 'u')
    assert isinstance(variables_instance, Variables)


def test_variables_values(grid_instance):
    """Test Variables with non-zero values."""
    shape = (grid_instance.Nx, grid_instance.Ny, grid_instance.Nz)
    u = torch.ones(shape) * 2.0
    variables = src.heat3d.Variables(u)

    assert torch.allclose(variables.u, torch.full(shape, 2.0))


def test_simulation_state_initialization():
    """Test SimulationState initialization."""
    u = torch.zeros((4, 4, 4))
    variables = src.heat3d.Variables(u)
    state = src.heat3d.SimulationState(variables=variables, t=0.0, step=0)

    assert isinstance(state, src.heat3d.SimulationState)
    assert state.t == 0.0
    assert state.step == 0
    assert isinstance(state.variables, src.heat3d.Variables)
    assert hasattr(state, 'variables')
    assert hasattr(state, 't')
    assert hasattr(state, 'step')
