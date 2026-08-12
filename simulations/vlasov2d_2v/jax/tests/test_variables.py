import jax
import jax.numpy as jnp
import pytest
import src.vlasov2D2V

def test_variables_initialization(variables_instance, grid_instance):
    """Test Variables initialization."""
    assert variables_instance.fn.shape == (grid_instance.Nx, grid_instance.Ny, grid_instance.Nvx, grid_instance.Nvy)
    assert variables_instance.f0.shape == (grid_instance.Nvx, grid_instance.Nvy)

def test_variables_pytree_flatten_unflatten(variables_instance):
    """Test JAX Pytree registration for Variables."""
    Variables = src.vlasov2D2V.Variables
    
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
    eps = 0.001
    solver = src.vlasov2D2V.Vlasov(Nx=32, Ny=32, Nvx=32, Nvy=32, nbiter=10, physics_mode=physics_mode,
                                   epsilon=eps)
    state = solver.initialize()
    
    assert isinstance(state, src.vlasov2D2V.SimulationState)
    assert state.t == 0.0
    assert state.step == 0
    
    # Check grid consistency
    assert state.grid.Nx == solver.grid.Nx
    assert state.grid.Ny == solver.grid.Ny
    assert state.grid.Nvx == solver.grid.Nvx
    assert state.grid.Nvy == solver.grid.Nvy
    assert state.grid.Lx == solver.grid.Lx
    assert state.grid.Ly == solver.grid.Ly
    assert state.grid.Vx_max == solver.grid.Vx_max
    assert state.grid.Vy_max == solver.grid.Vy_max
    
    # Check fields
    assert state.field.rho.shape == (solver.grid.Nx, solver.grid.Ny)
    assert state.field.phi.shape == (solver.grid.Nx, solver.grid.Ny)
    
    # Check variables
    assert state.variables.fn.shape == (solver.grid.Nx, solver.grid.Ny, solver.grid.Nvx, solver.grid.Nvy)
    assert state.variables.f0.shape == (solver.grid.Nvx, solver.grid.Nvy)
    
    grid = state.grid
    x_mesh = grid.x[:, None, None, None]
    y_mesh = grid.y[None, :, None, None]
    vx_mesh = grid.vx[:, None]
    vy_mesh = grid.vy[None, :]
    
    if physics_mode:
        # 1. If physics_mode is true, f0 is a maxwellian
        energy = 0.5 * (vx_mesh**2 + vy_mesh**2)
        expected_f0 = 1.0 / jnp.sqrt(2.0*jnp.pi) * jnp.exp(-energy)
        assert jnp.allclose(state.variables.f0, expected_f0, atol=1e-6)
        
        # 2. If physics_mode is true, f1 (fn) is a maxwellian added by a single mode perturbation
        kx = 1 * 2.0 * jnp.pi / grid.Lx
        ky = 1 * 2.0 * jnp.pi / grid.Ly
        expected_fn = (1.0 + eps * jnp.cos(kx*x_mesh) * jnp.cos(ky*y_mesh)) * expected_f0[None, None, :, :]
        assert jnp.allclose(state.variables.fn, expected_fn, atol=1e-6)
        
    else:
        # 3. If physics_mode is false, f0 is zero
        assert jnp.all(state.variables.f0 == 0.0)
        
        # 4. If physics_mode is false, f1 (fn) is a gaussian pulse
        x0, y0 = grid.Lx / 2.0, grid.Ly / 2.0
        vx0, vy0 = 0.0, 0.0
        sigma_x, sigma_v = grid.Lx / 10.0, grid.Vx_max / 4.0
        dx2 = (x_mesh - x0)**2 / sigma_x**2
        dy2 = (y_mesh - y0)**2 / sigma_x**2
        vx2 = (vx_mesh[None, None, :, :] - vx0)**2 / sigma_v**2
        vy2 = (vy_mesh[None, None, :, :] - vy0)**2 / sigma_v**2
        expected_fn = jnp.exp(-0.5 * (dx2 + dy2 + vx2 + vy2))
        assert jnp.allclose(state.variables.fn, expected_fn, atol=1e-6)
