import torch
import pytest
import math
import src.heat3d


def test_step_uniform_field():
    """
    Test that step() on a uniform field produces no change.
    For a constant field, the Laplacian is zero, so u_new = u.
    """
    N = 8
    u = torch.ones((N, N, N), dtype=torch.float64)
    coeff = 0.1

    result = src.heat3d.step(u, coeff)

    assert torch.allclose(result, u, atol=1e-12)


def test_step_single_point_diffusion():
    """A single hot point should diffuse outward (value decreases at center)."""
    N = 8
    u = torch.zeros((N, N, N), dtype=torch.float64)
    u[4, 4, 4] = 1.0
    coeff = 0.1

    result = src.heat3d.step(u, coeff)

    # Center should decrease (diffuse outward)
    assert result[4, 4, 4] < 1.0
    # Neighbors should increase
    assert result[5, 4, 4] > 0.0
    assert result[3, 4, 4] > 0.0
    assert result[4, 5, 4] > 0.0
    assert result[4, 3, 4] > 0.0
    assert result[4, 4, 5] > 0.0
    assert result[4, 4, 3] > 0.0


def test_step_periodic_boundary():
    """Verify that the stencil wraps around (periodic BC via torch.roll)."""
    N = 8
    u = torch.zeros((N, N, N), dtype=torch.float64)
    # Place a hot point at the boundary corner
    u[0, 0, 0] = 1.0
    coeff = 0.1

    result = src.heat3d.step(u, coeff)

    # The periodic neighbor u[N-1, 0, 0] should receive heat
    assert result[N - 1, 0, 0] > 0.0
    assert result[1, 0, 0] > 0.0
    assert result[0, N - 1, 0] > 0.0
    assert result[0, 1, 0] > 0.0
    assert result[0, 0, N - 1] > 0.0
    assert result[0, 0, 1] > 0.0


def test_step_conservation_of_energy():
    """The total sum of u should be conserved by the Laplacian stencil with periodic BC."""
    N = 16
    torch.manual_seed(42)
    u = torch.randn((N, N, N), dtype=torch.float64)
    coeff = 0.01

    result = src.heat3d.step(u, coeff)

    assert torch.isclose(result.sum(), u.sum(), atol=1e-8)


def test_step_cosine_mode_laplacian():
    """
    For u = cos(kx*x)*cos(ky*y)*cos(kz*z), verify the discrete Laplacian eigenvalue.
    The raw stencil eigenvalue per axis is: 2*cos(k*dx) - 2
    step() computes: u + coeff * raw_eigenvalue * u
    """
    N = 32
    L = 2.0 * math.pi
    dx = L / N
    kx, ky, kz = 1.0, 1.0, 1.0

    xs = torch.linspace(0, L, N + 1, dtype=torch.float64)[:-1]
    x, y, z = torch.meshgrid(xs, xs, xs, indexing="ij")
    u = torch.cos(kx * x) * torch.cos(ky * y) * torch.cos(kz * z)

    kappa = 1.0
    dt = 1e-4
    coeff = kappa * dt / (dx ** 2)
    result = src.heat3d.step(u, coeff)

    lam_x = 2 * math.cos(kx * dx) - 2
    lam_y = 2 * math.cos(ky * dx) - 2
    lam_z = 2 * math.cos(kz * dx) - 2
    raw_eigenvalue = lam_x + lam_y + lam_z

    expected = u + coeff * raw_eigenvalue * u

    assert torch.allclose(result, expected, atol=1e-10)


def test_step_symmetry():
    """
    Test that step() preserves symmetry of a symmetric input.
    A symmetric field should remain symmetric after one step.
    """
    N = 9  # odd so we have a true center
    u = torch.zeros((N, N, N), dtype=torch.float64)
    mid = N // 2
    u[mid, mid, mid] = 1.0
    coeff = 0.1

    result = src.heat3d.step(u, coeff)

    # Check symmetry: result should be invariant under axis permutations
    assert torch.allclose(result, result.permute(1, 0, 2), atol=1e-12)
    assert torch.allclose(result, result.permute(0, 2, 1), atol=1e-12)
    assert torch.allclose(result, result.permute(2, 1, 0), atol=1e-12)
