import jax
import jax.numpy as jnp
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
    
    assert jnp.isclose(grid_instance.dx, expected_dx)
    assert jnp.isclose(grid_instance.dv, expected_dv)
    
    # Check array shapes
    assert grid_instance.x.shape == (grid_params["Nx"],)
    assert grid_instance.v.shape == (grid_params["Nv"],)
    # rfftfreq size is n//2 + 1
    assert grid_instance.inv_kx.shape == (grid_params["Nx"] // 2 + 1,)
    assert grid_instance.stencil_offsets.shape == (6,)
    assert jnp.array_equal(grid_instance.stencil_offsets, jnp.arange(-2, 4, dtype=jnp.int32))

def test_grid_pytree_flatten_unflatten(grid_instance):
    """Test JAX Pytree registration: flatten and unflatten."""
    Grid = src.vlasov1D1V.Grid
    
    leaves, treedef = jax.tree_util.tree_flatten(grid_instance)
    
    # Check leaves (dynamic arrays)
    # x, v, inv_kx, stencil_offsets
    assert len(leaves) == 4
    assert jnp.array_equal(leaves[0], grid_instance.x)
    assert jnp.array_equal(leaves[1], grid_instance.v)
    assert jnp.array_equal(leaves[2], grid_instance.inv_kx)
    assert jnp.array_equal(leaves[3], grid_instance.stencil_offsets)
    
    # Check reconstruction
    grid_reconstructed = jax.tree_util.tree_unflatten(treedef, leaves)
    
    assert isinstance(grid_reconstructed, Grid)
    assert grid_reconstructed.Nx == grid_instance.Nx
    assert grid_reconstructed.Nv == grid_instance.Nv
    assert jnp.array_equal(grid_reconstructed.x, grid_instance.x)
    assert jnp.array_equal(grid_reconstructed.v, grid_instance.v)
    assert jnp.array_equal(grid_reconstructed.stencil_offsets, grid_instance.stencil_offsets)

def test_grid_jit_compatibility(grid_instance):
    """Test that Grid can be passed to a JIT-compiled function."""
    
    @jax.jit
    def compute_sum_x(grid):
        return jnp.sum(grid.x)
    
    result = compute_sum_x(grid_instance)
    assert jnp.isclose(result, jnp.sum(grid_instance.x))

def test_grid_immutability(grid_instance):
    """Test that Grid is frozen (immutable)."""
    with pytest.raises(Exception): # dataclass(frozen=True) raises FrozenInstanceError
        grid_instance.Nx = 100
