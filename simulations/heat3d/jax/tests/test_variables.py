import jax
import jax.numpy as jnp
import pytest
import src.heat3d


def test_variables_initialization(variables_instance, grid_instance):
    """Test Variables initialization."""
    expected_shape = (grid_instance.Nx, grid_instance.Ny, grid_instance.Nz)
    assert variables_instance.u.shape == expected_shape


def test_variables_pytree_flatten_unflatten(variables_instance):
    """Test JAX Pytree registration for Variables."""
    Variables = src.heat3d.Variables

    leaves, aux_data = jax.tree_util.tree_flatten(variables_instance)

    # Check leaves (u)
    assert len(leaves) == 1
    assert jnp.array_equal(leaves[0], variables_instance.u)

    # Check reconstruction
    variables_reconstructed = jax.tree_util.tree_unflatten(aux_data, leaves)

    assert isinstance(variables_reconstructed, Variables)
    assert jnp.array_equal(variables_reconstructed.u, variables_instance.u)


def test_variables_jit_compatibility(variables_instance):
    """Test that Variables can be passed to a JIT-compiled function."""

    @jax.jit
    def compute_mean_u(variables):
        return jnp.mean(variables.u)

    result = compute_mean_u(variables_instance)
    assert jnp.isclose(result, jnp.mean(variables_instance.u))
