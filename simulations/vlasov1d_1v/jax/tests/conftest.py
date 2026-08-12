import pytest
import sys
import os
import src.vlasov1D1V
import jax.numpy as jnp

@pytest.fixture
def grid_params():
    """Standard parameters for Grid creation."""
    return {
        "Nx": 16,
        "Nv": 16,
        "L": 2.0 * 3.14159,
        "V_max": 4.0
    }

@pytest.fixture
def grid_instance(grid_params):
    """Create a Grid instance using the imported module."""
    return src.vlasov1D1V.Grid.create(**grid_params)

@pytest.fixture
def field_instance(grid_instance):
    """Create a Field instance with dummy data."""
    rho = jnp.zeros(grid_instance.Nx)
    phi = jnp.zeros(grid_instance.Nx)
    return src.vlasov1D1V.Field(rho, phi)

@pytest.fixture
def variables_instance(grid_instance):
    """Create a Variables instance with dummy data."""
    fn = jnp.zeros((grid_instance.Nx, grid_instance.Nv))
    f0 = jnp.zeros(grid_instance.Nv)
    return src.vlasov1D1V.Variables(fn, f0)
