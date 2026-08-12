import torch
from src.vlasov1D1V import lagrange5_interp_sum

def test_lagrange5_interp_exact_polynomials():
    """
    Test that 5th-degree Lagrange interpolation is exact for polynomials of degree <= 5.
    We construct a scenario where we interpolate a polynomial using the weights.
    """
    # Stencil nodes relative to floor index: -2, -1, 0, 1, 2, 3
    nodes = torch.arange(-2, 4, dtype=torch.float64)

    # Test points (fractional offsets alpha in [0, 1))
    alphas = torch.tensor([0.1, 0.25, 0.5, 0.75, 0.9], dtype=torch.float64)

    # Define polynomials to test: 1, x, x^2, ..., x^5
    polynomials = [
        lambda x: torch.ones_like(x),
        lambda x: x,
        lambda x: x**2,
        lambda x: x**3,
        lambda x: x**4,
        lambda x: x**5,
    ]

    # Use Batch=1, N=len(alphas)
    alpha_2d = alphas.unsqueeze(0)  # [1, 5]

    for poly in polynomials:
        f_nodes = poly(nodes)  # [6]
        gather_vals = f_nodes.view(1, 1, 6).expand(1, alpha_2d.shape[1], 6)

        # Interpolated value using the direct interpolation sum kernel.
        interpolated = lagrange5_interp_sum(alpha_2d, gather_vals)  # [1, 5]

        # Exact values at fractional positions
        exact = poly(alphas)  # [5]

        assert torch.allclose(interpolated.squeeze(0), exact, atol=1e-10)

def test_lagrange5_interp_at_node_zero_returns_center_value():
    """
    At alpha=0, interpolation should return the center stencil value (offset 0).
    """
    alpha = torch.tensor([[0.0]], dtype=torch.float64)  # [1, 1]
    gather_vals = torch.tensor([[[7.0, 11.0, 42.0, -1.0, 3.0, 9.0]]], dtype=torch.float64)
    out = lagrange5_interp_sum(alpha, gather_vals)
    assert torch.allclose(out, torch.tensor([[42.0]], dtype=torch.float64), atol=1e-12)

def test_lagrange5_interp_shape():
    """Test that output shape matches [Batch, N]."""
    batch, n = 4, 8
    alpha = torch.rand(batch, n, dtype=torch.float64)
    gather_vals = torch.rand(batch, n, 6, dtype=torch.float64)
    out = lagrange5_interp_sum(alpha, gather_vals)
    assert out.shape == (batch, n)

def test_lagrange5_interp_partition_of_unity():
    """
    Partition of unity for Lagrange basis implies that if all stencil values are
    one, interpolated output should be exactly one.
    """
    alpha = torch.rand(3, 10, dtype=torch.float64)
    gather_vals = torch.ones(3, 10, 6, dtype=torch.float64)
    out = lagrange5_interp_sum(alpha, gather_vals)
    assert torch.allclose(out, torch.ones_like(out), atol=1e-12)
