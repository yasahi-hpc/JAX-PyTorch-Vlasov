import torch
import numpy as np
import pytest
import src.vlasov1D1V

def test_grid_initialization(grid_instance, grid_params):
    """Test that Grid is initialized with correct parameters and shapes."""
    assert grid_instance.Nx == grid_params["Nx"]
    assert grid_instance.Nv == grid_params["Nv"]
    assert grid_instance.L == grid_params["L"]
    assert grid_instance.V_max == grid_params["V_max"]

    # Check derived quantities
    expected_dx = grid_params["L"] / grid_params["Nx"]
    expected_dv = 2 * grid_params["V_max"] / (grid_params["Nv"] - 1)

    assert torch.isclose(torch.tensor(grid_instance.dx), torch.tensor(expected_dx))
    assert torch.isclose(torch.tensor(grid_instance.dv), torch.tensor(expected_dv))

    # Check array shapes
    assert grid_instance.x.shape == (grid_params["Nx"],)
    assert grid_instance.v.shape == (grid_params["Nv"],)
    # rfftfreq size is n//2 + 1
    assert grid_instance.inv_kx.shape == (grid_params["Nx"] // 2 + 1,)
    assert grid_instance.inv_kx_sq.shape == (grid_params["Nx"] // 2 + 1,)
    assert grid_instance.x_indices.shape == (grid_params["Nx"],)
    assert grid_instance.v_indices.shape == (grid_params["Nv"],)
    assert grid_instance.x_batch_offsets.shape == (grid_params["Nv"], 1, 1)
    assert grid_instance.v_batch_offsets.shape == (grid_params["Nx"], 1, 1)
    assert grid_instance.stencil_offsets.shape == (6,)

def test_grid_dataclass_fields(grid_instance):
    """Test that Grid dataclass has expected fields and they are accessible."""
    Grid = src.vlasov1D1V.Grid

    # Check that all expected attributes exist
    assert hasattr(grid_instance, 'Nx')
    assert hasattr(grid_instance, 'Nv')
    assert hasattr(grid_instance, 'L')
    assert hasattr(grid_instance, 'V_max')
    assert hasattr(grid_instance, 'dx')
    assert hasattr(grid_instance, 'dv')
    assert hasattr(grid_instance, 'x')
    assert hasattr(grid_instance, 'v')
    assert hasattr(grid_instance, 'inv_kx')
    assert hasattr(grid_instance, 'inv_kx_sq')
    assert hasattr(grid_instance, 'x_indices')
    assert hasattr(grid_instance, 'v_indices')
    assert hasattr(grid_instance, 'x_batch_offsets')
    assert hasattr(grid_instance, 'v_batch_offsets')
    assert hasattr(grid_instance, 'stencil_offsets')

    # Check that tensors are on CPU
    assert grid_instance.x.device == torch.device('cpu')
    assert grid_instance.v.device == torch.device('cpu')
    assert grid_instance.inv_kx.device == torch.device('cpu')
    assert grid_instance.inv_kx_sq.device == torch.device('cpu')

def test_grid_x_values(grid_instance, grid_params):
    """Test that x grid values are correct (endpoint=False for periodic)."""
    Nx = grid_params["Nx"]
    L = grid_params["L"]

    # x should be linspace(0, L, Nx+1)[:-1], i.e. endpoint=False
    expected_x = torch.linspace(0, L, Nx + 1)[:-1]
    assert torch.allclose(grid_instance.x, expected_x)

def test_grid_v_values(grid_instance, grid_params):
    """Test that v grid values are correct (endpoint=True)."""
    Nv = grid_params["Nv"]
    V_max = grid_params["V_max"]

    # v should be linspace(-V_max, V_max, Nv)
    expected_v = torch.linspace(-V_max, V_max, Nv)
    assert torch.allclose(grid_instance.v, expected_v)

def test_grid_inv_kx_zero_mode(grid_instance):
    """Test that inv_kx has 0 at k=0 mode to avoid division by zero."""
    assert grid_instance.inv_kx[0] == 0.0
    assert grid_instance.inv_kx_sq[0] == 0.0


def test_grid_precomputed_index_tensors(grid_instance):
    """Test the precomputed index helpers used by compiled advection."""
    assert torch.allclose(
        grid_instance.inv_kx_sq,
        grid_instance.inv_kx * grid_instance.inv_kx,
    )
    assert torch.equal(
        grid_instance.stencil_offsets,
        torch.arange(-2, 4, dtype=grid_instance.stencil_offsets.dtype),
    )
    assert torch.equal(
        grid_instance.x_indices,
        torch.arange(grid_instance.Nx, dtype=grid_instance.x.dtype),
    )
    assert torch.equal(
        grid_instance.v_indices,
        torch.arange(grid_instance.Nv, dtype=grid_instance.v.dtype),
    )
