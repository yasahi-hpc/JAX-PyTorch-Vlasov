import jax
import jax.numpy as jnp
import pytest
import src.vlasov1D1V

def test_variables_initialization(variables_instance, grid_instance):
    """Test Variables initialization."""
    assert variables_instance.fn.shape == (grid_instance.Nx, grid_instance.Nv)
    assert variables_instance.f0.shape == (grid_instance.Nv,)

def test_variables_pytree_flatten_unflatten(variables_instance):
    """Test JAX Pytree registration for Variables."""
    Variables = src.vlasov1D1V.Variables
    
    leaves, aux_data = jax.tree_util.tree_flatten(variables_instance)
    
    # Check leaves (fn, f0)
    assert len(leaves) == 2
    assert jnp.array_equal(leaves[0], variables_instance.fn)
    assert jnp.array_equal(leaves[1], variables_instance.f0)
    
    # Check reconstruction
    variables_reconstructed = jax.tree_util.tree_unflatten(aux_data, leaves)
    
    assert isinstance(variables_reconstructed, Variables)
    assert jnp.array_equal(variables_reconstructed.fn, variables_instance.fn)
    assert jnp.array_equal(variables_reconstructed.f0, variables_instance.f0)

def test_variables_jit_compatibility(variables_instance):
    """Test that Variables can be passed to a JIT-compiled function."""
    
    @jax.jit
    def compute_mean_fn(variables):
        return jnp.mean(variables.fn)
    
    result = compute_mean_fn(variables_instance)
    assert jnp.isclose(result, jnp.mean(variables_instance.fn))

@pytest.mark.parametrize("physics_mode", [True, False])
def test_vlasov_initialize(physics_mode):
    """Test the initialize method of Vlasov class with different physics modes."""
    solver = src.vlasov1D1V.Vlasov(Nx=32, Nv=32, nbiter=10, physics_mode=physics_mode)
    state = solver.initialize()
    
    assert isinstance(state, src.vlasov1D1V.SimulationState)
    assert state.t == 0.0
    assert state.step == 0
    
    # Check grid consistency
    assert state.grid.Nx == solver.grid.Nx
    assert state.grid.Nv == solver.grid.Nv
    
    # Check fields
    assert state.field.rho.shape == (solver.grid.Nx,)
    assert state.field.phi.shape == (solver.grid.Nx,)
    
    # Check variables
    assert state.variables.fn.shape == (solver.grid.Nx, solver.grid.Nv)
    
    grid = state.grid
    x_2d = grid.x[:, None]
    v_2d = grid.v[None, :]
    
    if physics_mode:
        # 1. If physics_mode is true, f0 is a maxwellian
        expected_f0 = 1.0 / jnp.sqrt(2.0*jnp.pi) * jnp.exp(-0.5*grid.v**2)
        assert jnp.allclose(state.variables.f0, expected_f0, atol=1e-6)
        
        # 2. If physics_mode is true, f1 (fn) is a maxwellian added by a single mode perturbation
        eps = 0.001
        kx = 1 * 2.0 * jnp.pi / grid.L
        expected_fn = (1.0 + eps * jnp.cos(kx*x_2d)) / jnp.sqrt(2.0*jnp.pi) * jnp.exp(-0.5*v_2d**2)
        assert jnp.allclose(state.variables.fn, expected_fn, atol=1e-6)
        
    else:
        # 3. If physics_mode is false, f0 is zero
        assert jnp.all(state.variables.f0 == 0.0)
        
        # 4. If physics_mode is false, f1 (fn) is a gaussian pulse
        x0, v0 = grid.L / 2.0, 0.0
        sigma_x, sigma_v = grid.L / 10.0, grid.V_max / 4.0
        expected_fn = jnp.exp(-0.5 * ((x_2d - x0)**2 / sigma_x**2 + (v_2d - v0)**2 / sigma_v**2))
        assert jnp.allclose(state.variables.fn, expected_fn, atol=1e-6)
