import torch
import numpy as np
import pytest
import src.vlasov2D2V

def test_grid_initialization(grid_instance, grid_params):
    """Test that Grid is initialized with correct parameters and shapes."""
    assert grid_instance.Nx == grid_params["Nx"]
    assert grid_instance.Ny == grid_params["Ny"]
    assert grid_instance.Nvx == grid_params["Nvx"]
    assert grid_instance.Nvy == grid_params["Nvy"]
    assert grid_instance.Lx == grid_params["Lx"]
    assert grid_instance.Ly == grid_params["Ly"]
    assert grid_instance.Vx_max == grid_params["Vx_max"]
    assert grid_instance.Vy_max == grid_params["Vy_max"]

    # Check derived quantities
    expected_dx = grid_params["Lx"] / grid_params["Nx"]
    expected_dy = grid_params["Ly"] / grid_params["Ny"]
    expected_dvx = 2 * grid_params["Vx_max"] / (grid_params["Nvx"] - 1)
    expected_dvy = 2 * grid_params["Vy_max"] / (grid_params["Nvy"] - 1)

    assert torch.isclose(torch.tensor(grid_instance.dx), torch.tensor(expected_dx))
    assert torch.isclose(torch.tensor(grid_instance.dy), torch.tensor(expected_dy))
    assert torch.isclose(torch.tensor(grid_instance.dvx), torch.tensor(expected_dvx))
    assert torch.isclose(torch.tensor(grid_instance.dvy), torch.tensor(expected_dvy))

    # Check array shapes
    assert grid_instance.x.shape == (grid_params["Nx"],)
    assert grid_instance.y.shape == (grid_params["Ny"],)
    assert grid_instance.vx.shape == (grid_params["Nvx"],)
    assert grid_instance.vy.shape == (grid_params["Nvy"],)
    assert grid_instance.kx.shape == (grid_params["Nx"], 1)
    # rfftfreq size is n//2 + 1
    assert grid_instance.ky.shape == (1, grid_params["Ny"] // 2 + 1)
    assert grid_instance.inv_ksq.shape == (grid_params["Nx"], grid_params["Ny"] // 2 + 1)
    assert grid_instance.x_indices.shape == (grid_params["Nx"],)
    assert grid_instance.y_indices.shape == (grid_params["Ny"],)
    assert grid_instance.vx_indices.shape == (grid_params["Nvx"],)
    assert grid_instance.vy_indices.shape == (grid_params["Nvy"],)
    assert grid_instance.stencil_offsets.shape == (6,)

def test_grid_dataclass_fields(grid_instance):
    """Test that Grid dataclass has expected fields and they are accessible."""
    Grid = src.vlasov2D2V.Grid

    # Check that all expected attributes exist
    assert hasattr(grid_instance, 'Nx')
    assert hasattr(grid_instance, 'Ny')
    assert hasattr(grid_instance, 'Nvx')
    assert hasattr(grid_instance, 'Nvy')
    assert hasattr(grid_instance, 'Lx')
    assert hasattr(grid_instance, 'Ly')
    assert hasattr(grid_instance, 'Vx_max')
    assert hasattr(grid_instance, 'Vy_max')
    assert hasattr(grid_instance, 'dx')
    assert hasattr(grid_instance, 'dy')
    assert hasattr(grid_instance, 'dvx')
    assert hasattr(grid_instance, 'dvy')
    assert hasattr(grid_instance, 'x')
    assert hasattr(grid_instance, 'y')
    assert hasattr(grid_instance, 'vx')
    assert hasattr(grid_instance, 'vy')
    assert hasattr(grid_instance, 'kx')
    assert hasattr(grid_instance, 'ky')
    assert hasattr(grid_instance, 'inv_ksq')
    assert hasattr(grid_instance, 'x_indices')
    assert hasattr(grid_instance, 'y_indices')
    assert hasattr(grid_instance, 'vx_indices')
    assert hasattr(grid_instance, 'vy_indices')
    assert hasattr(grid_instance, 'stencil_offsets')

    # Check that tensors are on CPU
    assert grid_instance.x.device == torch.device('cpu')
    assert grid_instance.y.device == torch.device('cpu')
    assert grid_instance.vx.device == torch.device('cpu')
    assert grid_instance.vy.device == torch.device('cpu')
    assert grid_instance.kx.device == torch.device('cpu')
    assert grid_instance.ky.device == torch.device('cpu')
    assert grid_instance.inv_ksq.device == torch.device('cpu')
    assert grid_instance.x_indices.device == torch.device('cpu')
    assert grid_instance.y_indices.device == torch.device('cpu')
    assert grid_instance.vx_indices.device == torch.device('cpu')
    assert grid_instance.vy_indices.device == torch.device('cpu')
    assert grid_instance.stencil_offsets.device == torch.device('cpu')

def test_grid_x_values(grid_instance, grid_params):
    """Test that x grid values are correct (endpoint=False for periodic)."""
    Nx = grid_params["Nx"]
    Lx = grid_params["Lx"]

    # x should be linspace(0, Lx, Nx+1)[:-1], i.e. endpoint=False
    expected_x = torch.linspace(0, Lx, Nx + 1)[:-1]
    assert torch.allclose(grid_instance.x, expected_x)

def test_grid_y_values(grid_instance, grid_params):
    """Test that y grid values are correct (endpoint=False for periodic)."""
    Ny = grid_params["Ny"]
    Ly = grid_params["Ly"]

    expected_y = torch.linspace(0, Ly, Ny + 1)[:-1]
    assert torch.allclose(grid_instance.y, expected_y)

def test_grid_vx_values(grid_instance, grid_params):
    """Test that vx grid values are correct (endpoint=True)."""
    Nvx = grid_params["Nvx"]
    Vx_max = grid_params["Vx_max"]

    expected_vx = torch.linspace(-Vx_max, Vx_max, Nvx)
    assert torch.allclose(grid_instance.vx, expected_vx)

def test_grid_vy_values(grid_instance, grid_params):
    """Test that vy grid values are correct (endpoint=True)."""
    Nvy = grid_params["Nvy"]
    Vy_max = grid_params["Vy_max"]

    expected_vy = torch.linspace(-Vy_max, Vy_max, Nvy)
    assert torch.allclose(grid_instance.vy, expected_vy)

def test_grid_inv_ksq_zero_mode(grid_instance):
    """Test that inv_ksq has 0 at k=0 mode to avoid division by zero."""
    assert grid_instance.inv_ksq[0, 0] == 0.0
