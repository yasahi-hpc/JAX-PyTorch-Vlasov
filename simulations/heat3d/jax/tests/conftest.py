import pytest
import jax
import jax.numpy as jnp
import src.heat3d

@pytest.fixture
def grid_params():
    """Standard parameters for Grid creation."""
    return {
        "Nx": 16,
        "Ny": 16,
        "Nz": 16,
        "Lx": 2.0 * jnp.pi,
        "Ly": 2.0 * jnp.pi,
        "Lz": 2.0 * jnp.pi,
    }


@pytest.fixture
def grid_instance(grid_params):
    """Create a Grid instance using the imported module."""
    return src.heat3d.Grid.create(**grid_params)


@pytest.fixture
def variables_instance(grid_instance):
    """Create a Variables instance with dummy data."""
    shape = (grid_instance.Nx, grid_instance.Ny, grid_instance.Nz)
    u = jnp.zeros(shape)
    return src.heat3d.Variables(u=u)


@pytest.fixture
def state_instance(grid_instance, variables_instance):
    """Create a SimulationState instance."""
    return src.heat3d.SimulationState(
        grid=grid_instance,
        variables=variables_instance,
        t=0.0,
        step=0,
    )


@pytest.fixture
def solver_small():
    """Create a small Heat solver for fast testing."""
    return src.heat3d.Heat(
        N=16,
        L=2.0 * jnp.pi,
        nbiter=100,
        diag_steps=200,  # > nbiter so num_steps=0
        dt=1e-4,
        kappa=1.0,
        dtype='float32',
    )
