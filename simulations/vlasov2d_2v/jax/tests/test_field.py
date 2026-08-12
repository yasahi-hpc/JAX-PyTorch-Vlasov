import jax
import jax.numpy as jnp
import pytest
import src.vlasov2D2V

def test_field_initialization(field_instance, grid_instance):
    """Test Field initialization."""
    assert field_instance.rho.shape == (grid_instance.Nx, grid_instance.Ny)
    assert field_instance.phi.shape == (grid_instance.Nx, grid_instance.Ny)

def test_field_pytree_flatten_unflatten(field_instance):
    """Test JAX Pytree registration for Field."""
    Field = src.vlasov2D2V.Field
    
    leaves, aux_data = jax.tree_util.tree_flatten(field_instance)
    
    # Check leaves (rho, phi)
    assert len(leaves) == 2
    assert jnp.array_equal(leaves[0], field_instance.rho)
    assert jnp.array_equal(leaves[1], field_instance.phi)
    
    # Check reconstruction
    field_reconstructed = jax.tree_util.tree_unflatten(aux_data, leaves)
    
    assert isinstance(field_reconstructed, Field)
    assert jnp.array_equal(field_reconstructed.rho, field_instance.rho)
    assert jnp.array_equal(field_reconstructed.phi, field_instance.phi)

def test_field_jit_compatibility(field_instance):
    """Test that Field can be passed to a JIT-compiled function."""
    
    @jax.jit
    def compute_sum_rho(field):
        return jnp.sum(field.rho)
    
    result = compute_sum_rho(field_instance)
    assert jnp.isclose(result, jnp.sum(field_instance.rho))
