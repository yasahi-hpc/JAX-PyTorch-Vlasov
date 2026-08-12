import pytest
import sys
import os
import src.vlasov2D2V
import jax.numpy as jnp

@pytest.fixture
def grid_params():
    """Standard parameters for Grid creation."""
    return {
        "Nx": 16,
        "Ny": 16,
        "Nvx": 16,
        "Nvy": 16,
        "Lx": 2.0 * jnp.pi,
        "Ly": 2.0 * jnp.pi,
        "Vx_max": 4.0,
        "Vy_max": 4.0
    }

@pytest.fixture
def grid_instance(grid_params):
    """Create a Grid instance using the imported module."""
    return src.vlasov2D2V.Grid.create(**grid_params)

@pytest.fixture
def field_instance(grid_instance):
    """Create a Field instance with dummy data."""
    rho = jnp.zeros((grid_instance.Nx, grid_instance.Ny))
    phi = jnp.zeros((grid_instance.Nx, grid_instance.Ny))
    return src.vlasov2D2V.Field(rho, phi)

@pytest.fixture
def variables_instance(grid_instance):
    """Create a Variables instance with dummy data."""
    fn = jnp.zeros((grid_instance.Nx, grid_instance.Ny, grid_instance.Nvx, grid_instance.Nvy))
    f0 = jnp.zeros((grid_instance.Nvx, grid_instance.Nvy))
    return src.vlasov2D2V.Variables(fn, f0)
