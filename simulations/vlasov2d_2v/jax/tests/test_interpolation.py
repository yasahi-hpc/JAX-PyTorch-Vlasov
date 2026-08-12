import pytest
import jax.numpy as jnp
import numpy as np
from src.vlasov2D2V import lagrange5_interp_sum

def test_lagrange5_interp_sum_exact_polynomials():
    """
    Test that lagrange5_interp_sum exactly interpolates polynomials of degree <= 5.

    The stencil nodes are at [-2, -1, 0, 1, 2, 3].
    For a fractional offset alpha, the interpolated value is:
      lagrange5_interp_sum(alpha, f(node[j]))
    which should equal f(alpha) for any polynomial f of degree <= 5.
    """
    alphas = jnp.array([[0.0, 0.25, 0.5, 0.75, 0.99]])
    nodes = jnp.arange(-2, 4, dtype=jnp.float32)  # [-2, -1, 0, 1, 2, 3]

    for k in range(6):
        f_vals = jnp.broadcast_to((nodes ** k)[None, None, :], (1, alphas.shape[1], 6))
        expected = alphas ** k
        interpolated = lagrange5_interp_sum(alphas, f_vals)

        assert jnp.allclose(interpolated, expected, atol=1e-5), \
            f"Failed for polynomial degree {k}"

def test_lagrange5_interp_sum_at_nodes():
    """
    At alpha=0 the interpolation point coincides with stencil node 0
    (index 2 in [-2,-1,0,1,2,3]), so the interpolant returns the center stencil value.
    """
    alphas = jnp.array([[0.0]])
    f_vals = jnp.array([[[2.0, 3.0, 5.0, 7.0, 11.0, 13.0]]])

    expected = jnp.array([[5.0]])
    assert jnp.allclose(lagrange5_interp_sum(alphas, f_vals), expected, atol=1e-6)

def test_lagrange5_interp_sum_shape():
    """Test that the interpolant returns shape [Batch, N]."""
    batch, n = 4, 8
    alphas = jnp.ones((batch, n)) * 0.5
    f_vals = jnp.ones((batch, n, 6))
    interpolated = lagrange5_interp_sum(alphas, f_vals)
    assert interpolated.shape == (batch, n)

def test_lagrange5_interp_sum_partition_of_unity():
    """
    The interpolant should reproduce constants exactly for any alpha.
    """
    alphas = jnp.linspace(0, 1, 20).reshape(2, 10)
    f_vals = jnp.ones((2, 10, 6))
    interpolated = lagrange5_interp_sum(alphas, f_vals)
    assert jnp.allclose(interpolated, 1.0, atol=1e-6)
