import torch
import numpy as np
import pytest
import src.heat3d

def test_grid_initialization(grid_instance, grid_params):
    """Test that Grid is initialized with correct parameters and shapes."""
    assert grid_instance.Nx == grid_params["Nx"]
    assert grid_instance.Ny == grid_params["Ny"]
    assert grid_instance.Nz == grid_params["Nz"]
    assert grid_instance.Lx == grid_params["Lx"]
    assert grid_instance.Ly == grid_params["Ly"]
    assert grid_instance.Lz == grid_params["Lz"]

    # Check derived quantities
    expected_dx = grid_params["Lx"] / grid_params["Nx"]
    expected_dy = grid_params["Ly"] / grid_params["Ny"]
    expected_dz = grid_params["Lz"] / grid_params["Nz"]

    assert torch.isclose(torch.tensor(grid_instance.dx), torch.tensor(expected_dx))
    assert torch.isclose(torch.tensor(grid_instance.dy), torch.tensor(expected_dy))
    assert torch.isclose(torch.tensor(grid_instance.dz), torch.tensor(expected_dz))

    # Check array shapes (Nx points for periodic, endpoint=False)
    assert grid_instance.x.shape == (grid_params["Nx"],)
    assert grid_instance.y.shape == (grid_params["Ny"],)
    assert grid_instance.z.shape == (grid_params["Nz"],)

def test_grid_dataclass_fields(grid_instance):
    """Test that Grid dataclass has expected fields and they are accessible."""
    # Check that all expected attributes exist
    assert hasattr(grid_instance, 'Nx')
    assert hasattr(grid_instance, 'Ny')
    assert hasattr(grid_instance, 'Nz')
    assert hasattr(grid_instance, 'Lx')
    assert hasattr(grid_instance, 'Ly')
    assert hasattr(grid_instance, 'Lz')
    assert hasattr(grid_instance, 'dx')
    assert hasattr(grid_instance, 'dy')
    assert hasattr(grid_instance, 'dz')
    assert hasattr(grid_instance, 'x')
    assert hasattr(grid_instance, 'y')
    assert hasattr(grid_instance, 'z')

    # Check that tensors are on CPU
    assert grid_instance.x.device == torch.device('cpu')
    assert grid_instance.y.device == torch.device('cpu')
    assert grid_instance.z.device == torch.device('cpu')

def test_grid_x_values(grid_instance, grid_params):
    """Test that x grid values are correct (endpoint=False for periodic)."""
    Nx = grid_params["Nx"]
    Lx = grid_params["Lx"]

    expected_x = torch.linspace(0, Lx, Nx + 1)[:-1]
    assert torch.allclose(grid_instance.x, expected_x)

def test_grid_y_values(grid_instance, grid_params):
    """Test that y grid values are correct (endpoint=False for periodic)."""
    Ny = grid_params["Ny"]
    Ly = grid_params["Ly"]

    expected_y = torch.linspace(0, Ly, Ny + 1)[:-1]
    assert torch.allclose(grid_instance.y, expected_y)

def test_grid_z_values(grid_instance, grid_params):
    """Test that z grid values are correct (endpoint=False for periodic)."""
    Nz = grid_params["Nz"]
    Lz = grid_params["Lz"]

    expected_z = torch.linspace(0, Lz, Nz + 1)[:-1]
    assert torch.allclose(grid_instance.z, expected_z)

def test_grid_to_device(grid_instance):
    """Test that Grid.to() moves tensors to the specified device."""
    grid_instance.to('cpu')
    assert grid_instance.x.device == torch.device('cpu')
    assert grid_instance.y.device == torch.device('cpu')
    assert grid_instance.z.device == torch.device('cpu')

def test_grid_symmetry(grid_params):
    """Test that a symmetric grid (same N and L in all dims) produces equal spacings."""
    N = grid_params["Nx"]
    L = grid_params["Lx"]
    grid = src.heat3d.Grid.create(N, N, N, L, L, L, device='cpu')
    assert grid.dx == grid.dy == grid.dz
    assert torch.allclose(grid.x, grid.y)
    assert torch.allclose(grid.y, grid.z)
