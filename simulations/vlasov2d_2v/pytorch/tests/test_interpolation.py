import pytest
import torch
import numpy as np
from src.vlasov2D2V import lagrange5_interp_sum

def test_lagrange5_interp_sum_exact_polynomials():
    """
    Test that the interpolation sum is exact for polynomials of degree <= 5.
    """
    nodes = torch.arange(-2, 4, dtype=torch.float64)
    alphas = torch.tensor([0.1, 0.25, 0.5, 0.75, 0.9], dtype=torch.float64)
    polynomials = [
        lambda x: torch.ones_like(x),
        lambda x: x,
        lambda x: x**2,
        lambda x: x**3,
        lambda x: x**4,
        lambda x: x**5,
    ]
    alpha_2d = alphas.unsqueeze(0)

    for poly in polynomials:
        f_vals = poly(nodes).view(1, 1, 6).expand(1, alphas.numel(), 6)
        interpolated = lagrange5_interp_sum(alpha_2d, f_vals)
        exact = poly(alphas)

        assert torch.allclose(interpolated.squeeze(0), exact, atol=1e-10), \
            f"Failed for polynomial {poly.__name__}"

def test_lagrange5_interp_sum_at_nodes():
    """
    At alpha=0, the interpolation should return the center stencil value exactly.
    """
    alpha = torch.tensor([[0.0]], dtype=torch.float64)
    f_vals = torch.tensor([[[2.0, 3.0, 5.0, 7.0, 11.0, 13.0]]], dtype=torch.float64)
    expected = torch.tensor([[5.0]], dtype=torch.float64)
    assert torch.allclose(lagrange5_interp_sum(alpha, f_vals), expected, atol=1e-12)

def test_lagrange5_interp_sum_shape():
    """Test that output shape matches [Batch, N]."""
    batch, n = 4, 8
    alpha = torch.rand(batch, n, dtype=torch.float64)
    f_vals = torch.rand(batch, n, 6, dtype=torch.float64)
    interpolated = lagrange5_interp_sum(alpha, f_vals)
    assert interpolated.shape == (batch, n)

def test_lagrange5_interp_sum_partition_of_unity():
    """
    The interpolation sum should reproduce constants exactly for any alpha.
    """
    alpha = torch.rand(3, 10, dtype=torch.float64)
    f_vals = torch.ones(3, 10, 6, dtype=torch.float64)
    interpolated = lagrange5_interp_sum(alpha, f_vals)
    assert torch.allclose(interpolated, torch.ones_like(interpolated), atol=1e-12)
