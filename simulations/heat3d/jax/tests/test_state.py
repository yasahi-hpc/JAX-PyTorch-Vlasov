import jax
import jax.numpy as jnp
import pytest
import src.heat3d


def test_state_pytree_flatten_unflatten(state_instance):
    """Test JAX Pytree registration for SimulationState."""
    SimulationState = src.heat3d.SimulationState

    leaves, treedef = jax.tree_util.tree_flatten(state_instance)

    # Reconstruct
    state_reconstructed = jax.tree_util.tree_unflatten(treedef, leaves)

    assert isinstance(state_reconstructed, SimulationState)
    assert state_reconstructed.t == state_instance.t
    assert state_reconstructed.step == state_instance.step
    assert jnp.array_equal(state_reconstructed.variables.u, state_instance.variables.u)
    assert state_reconstructed.grid.Nx == state_instance.grid.Nx


def test_state_jit_compatibility(state_instance):
    """Test that SimulationState can be passed to a JIT-compiled function."""

    @jax.jit
    def extract_time(state):
        return state.t + jnp.sum(state.variables.u)

    result = extract_time(state_instance)
    expected = state_instance.t + jnp.sum(state_instance.variables.u)
    assert jnp.isclose(result, expected)
