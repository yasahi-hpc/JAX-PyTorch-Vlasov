import jax
import jax.numpy as jnp
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
    
    assert jnp.isclose(grid_instance.dx, expected_dx)
    assert jnp.isclose(grid_instance.dy, expected_dy)
    assert jnp.isclose(grid_instance.dvx, expected_dvx)
    assert jnp.isclose(grid_instance.dvy, expected_dvy)
    
    # Check array shapes
    assert grid_instance.x.shape == (grid_params["Nx"],)
    assert grid_instance.y.shape == (grid_params["Ny"],)
    assert grid_instance.vx.shape == (grid_params["Nvx"],)
    assert grid_instance.vy.shape == (grid_params["Nvy"],)
    assert grid_instance.kx.shape == (grid_params["Nx"], 1)

    # rfftfreq size is n//2 + 1
    assert grid_instance.ky.shape == (1, grid_params["Ny"] // 2 +1)
    assert grid_instance.inv_ksq.shape == (grid_params["Nx"], grid_params["Ny"] // 2 + 1)
    assert grid_instance.stencil_offsets.shape == (6,)

def test_grid_pytree_flatten_unflatten(grid_instance):
    """Test JAX Pytree registration: flatten and unflatten."""
    Grid = src.vlasov2D2V.Grid
    
    leaves, treedef = jax.tree_util.tree_flatten(grid_instance)
    
    # Check leaves (dynamic arrays)
    # x, y, vx, vy, kx, ky, inv_ksq, stencil_offsets
    assert len(leaves) == 8
    assert jnp.array_equal(leaves[0], grid_instance.x)
    assert jnp.array_equal(leaves[1], grid_instance.y)
    assert jnp.array_equal(leaves[2], grid_instance.vx)
    assert jnp.array_equal(leaves[3], grid_instance.vy)
    assert jnp.array_equal(leaves[4], grid_instance.kx)
    assert jnp.array_equal(leaves[5], grid_instance.ky)
    assert jnp.array_equal(leaves[6], grid_instance.inv_ksq)
    assert jnp.array_equal(leaves[7], grid_instance.stencil_offsets)
    
    # Check reconstruction
    grid_reconstructed = jax.tree_util.tree_unflatten(treedef, leaves)
    
    assert isinstance(grid_reconstructed, Grid)
    assert grid_reconstructed.Nx == grid_instance.Nx
    assert grid_reconstructed.Ny == grid_instance.Ny
    assert grid_reconstructed.Nvx == grid_instance.Nvx
    assert grid_reconstructed.Nvy == grid_instance.Nvy
    assert grid_reconstructed.Lx == grid_instance.Lx
    assert grid_reconstructed.Ly == grid_instance.Ly
    assert grid_reconstructed.Vx_max == grid_instance.Vx_max
    assert grid_reconstructed.Vy_max == grid_instance.Vy_max
    assert jnp.isclose(grid_reconstructed.dx, grid_instance.dx)
    assert jnp.isclose(grid_reconstructed.dy, grid_instance.dy)
    assert jnp.isclose(grid_reconstructed.dvx, grid_instance.dvx)
    assert jnp.isclose(grid_reconstructed.dvy, grid_instance.dvy)

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
