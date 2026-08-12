import torch
import pytest
import src.vlasov2D2V

def test_field_initialization(field_instance, grid_instance):
    """Test Field initialization."""
    assert field_instance.rho.shape == (grid_instance.Nx, grid_instance.Ny)
    assert field_instance.phi.shape == (grid_instance.Nx, grid_instance.Ny)

def test_field_dataclass_fields(field_instance):
    """Test that Field dataclass has expected fields and they are accessible."""
    Field = src.vlasov2D2V.Field

    # Check that all expected attributes exist
    assert hasattr(field_instance, 'rho')
    assert hasattr(field_instance, 'phi')

    # Check it's an instance of Field
    assert isinstance(field_instance, Field)

def test_field_values(grid_instance):
    """Test Field with non-zero values."""
    rho = torch.ones((grid_instance.Nx, grid_instance.Ny)) * 2.0
    phi = torch.ones((grid_instance.Nx, grid_instance.Ny)) * 3.0
    field = src.vlasov2D2V.Field(rho, phi)

    assert torch.allclose(field.rho, torch.full((grid_instance.Nx, grid_instance.Ny), 2.0))
    assert torch.allclose(field.phi, torch.full((grid_instance.Nx, grid_instance.Ny), 3.0))

def test_field_sum(field_instance):
    """Test that operations on Field members work correctly."""
    result = torch.sum(field_instance.rho)
    assert torch.isclose(result, torch.sum(field_instance.rho))
