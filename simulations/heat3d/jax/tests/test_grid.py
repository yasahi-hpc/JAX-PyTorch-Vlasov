import jax
import jax.numpy as jnp
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

    assert jnp.isclose(grid_instance.dx, expected_dx)
    assert jnp.isclose(grid_instance.dy, expected_dy)
    assert jnp.isclose(grid_instance.dz, expected_dz)

    # Check array shapes
    assert grid_instance.x.shape == (grid_params["Nx"],)
    assert grid_instance.y.shape == (grid_params["Ny"],)
    assert grid_instance.z.shape == (grid_params["Nz"],)

    # Check coordinate ranges (endpoint=False for periodic domain)
    assert jnp.isclose(grid_instance.x[0], 0.0)
    assert grid_instance.x[-1] < grid_params["Lx"]
    assert jnp.isclose(grid_instance.y[0], 0.0)
    assert grid_instance.y[-1] < grid_params["Ly"]


def test_grid_pytree_flatten_unflatten(grid_instance):
    """Test JAX Pytree registration: flatten and unflatten."""
    Grid = src.heat3d.Grid

    leaves, treedef = jax.tree_util.tree_flatten(grid_instance)

    # Check leaves (dynamic arrays: x, y, z)
    assert len(leaves) == 3
    assert jnp.array_equal(leaves[0], grid_instance.x)
    assert jnp.array_equal(leaves[1], grid_instance.y)
    assert jnp.array_equal(leaves[2], grid_instance.z)

    # Check reconstruction
    grid_reconstructed = jax.tree_util.tree_unflatten(treedef, leaves)

    assert isinstance(grid_reconstructed, Grid)
    assert grid_reconstructed.Nx == grid_instance.Nx
    assert grid_reconstructed.Ny == grid_instance.Ny
    assert grid_reconstructed.Nz == grid_instance.Nz
    assert jnp.isclose(grid_reconstructed.dx, grid_instance.dx)
    assert jnp.array_equal(grid_reconstructed.x, grid_instance.x)
    assert jnp.array_equal(grid_reconstructed.y, grid_instance.y)
    assert jnp.array_equal(grid_reconstructed.z, grid_instance.z)


def test_grid_jit_compatibility(grid_instance):
    """Test that Grid can be passed to a JIT-compiled function."""

    @jax.jit
    def compute_sum_x(grid):
        return jnp.sum(grid.x)

    result = compute_sum_x(grid_instance)
    assert jnp.isclose(result, jnp.sum(grid_instance.x))


def test_grid_immutability(grid_instance):
    """Test that Grid is frozen (immutable)."""
    with pytest.raises(Exception):  # dataclass(frozen=True) raises FrozenInstanceError
        grid_instance.Nx = 100


def test_grid_different_sizes():
    """Test Grid creation with non-cubic dimensions."""
    g = src.heat3d.Grid.create(8, 16, 32, 1.0, 2.0, 3.0)
    assert g.Nx == 8
    assert g.Ny == 16
    assert g.Nz == 32
    assert g.x.shape == (8,)
    assert g.y.shape == (16,)
    assert g.z.shape == (32,)
    assert jnp.isclose(g.dx, 1.0 / 8)
    assert jnp.isclose(g.dy, 2.0 / 16)
    assert jnp.isclose(g.dz, 3.0 / 32)
