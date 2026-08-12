import pytest
import jax.numpy as jnp
import numpy as np
from src.vlasov1D1V import lagrange5_interp_sum, lagrange5_weights

def test_lagrange_interp_5_uniform_exact_polynomials():
    """
    Test that 5th-degree Lagrange interpolation is exact for polynomials of degree <= 5.
    """
    # Stencil points (uniform grid)
    nodes = jnp.array([-2.0, -1.0, 0.0, 1.0, 2.0, 3.0])
    
    # Test points to interpolate at
    alphas = jnp.array([-1.5, -0.5, 0.5, 1.5, 2.5])
    
    # Define polynomials to test: 1, x, x^2, ..., x^5
    polynomials = [
        lambda x: jnp.ones_like(x),
        lambda x: x,
        lambda x: x**2,
        lambda x: x**3,
        lambda x: x**4,
        lambda x: x**5
    ]
    
    alpha_2d = alphas[None, :]  # [1, 5]
    
    for poly in polynomials:
        f_nodes = poly(nodes)  # [6]

        f_vals = jnp.broadcast_to(f_nodes, (1, alphas.shape[0], nodes.shape[0]))
        interpolated = lagrange5_interp_sum(alpha_2d, f_vals)  # [1, 5]

        exact = poly(alphas)  # [5]
  
        assert jnp.allclose(interpolated.squeeze(0), exact, atol=1e-5), \
            f"Failed for polynomial {poly.__name__}"

def test_lagrange_interp_5_uniform_nodes():
    """
    Test that interpolation at alpha=0 returns the center stencil value exactly.
    """
    alpha = jnp.array([[0.0]])  # [1, 1]
    stencil_values = jnp.array([[[2.0, 3.0, 5.0, 7.0, 11.0, 13.0]]])
    interpolated = lagrange5_interp_sum(alpha, stencil_values)

    assert jnp.allclose(interpolated.squeeze(), stencil_values[0, 0, 2], atol=1e-5)

def test_lagrange_weights_5_uniform_nodes():
    """
    Test that the Lagrange weights are correct for alpha=0.
    """
    alpha = jnp.array([[0.0]])  # [1, 1]
    stencil_values = jnp.array([[[2.0, 3.0, 5.0, 7.0, 11.0, 13.0]]])
    weights = lagrange5_weights(alpha)
    interpolated = jnp.sum(weights * stencil_values.reshape(6, 1, 1), axis=0)

    assert jnp.allclose(interpolated.squeeze(), stencil_values[0, 0, 2], atol=1e-5)
