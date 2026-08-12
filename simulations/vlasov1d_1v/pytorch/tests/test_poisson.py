import pytest
import torch
import numpy as np
import src.vlasov1D1V

@pytest.mark.parametrize("mode_number", [1, 2, 3])
def test_solve_poisson_properties(grid_instance, mode_number):
    """
    Test solve_poisson function.
    1. Input f is maxwellian + single mode perturbation.
    2. Confirm rho is integral of delta f.
    3. Confirm d^2 phi / dx^2 = -rho.
    4. Confirm E = -dphi/dx.
    """
    # Setup
    Nx = grid_instance.Nx
    Nv = grid_instance.Nv
    L = grid_instance.L
    dx = grid_instance.dx
    dv = grid_instance.dv
    x = grid_instance.x
    v = grid_instance.v
    inv_kx = grid_instance.inv_kx
    inv_kx_sq = grid_instance.inv_kx_sq

    # 1. Input variable f is given by a maxwellian added by a single mode perturbation
    # f(x,v) = (1 + epsilon * cos(k*x)) * f_M(v)
    epsilon = 0.01
    k = mode_number * 2.0 * torch.pi / L

    # Broadcasting
    x_2d = x[:, None]
    v_2d = v[None, :]

    f_M = 1.0 / torch.sqrt(torch.tensor(2.0 * torch.pi)) * torch.exp(-0.5 * v_2d**2)
    perturbation = epsilon * torch.cos(k * x_2d)
    f_data = (1.0 + perturbation) * f_M

    # Run both Poisson implementations and confirm the optimized real-valued path
    # preserves the original solver's results.
    E_ref, rho_ref, phi_ref = src.vlasov1D1V.solve_poisson(f_data, inv_kx, dv)
    E, rho, phi = src.vlasov1D1V.solve_poisson_real(f_data, inv_kx, inv_kx_sq, dv)

    assert torch.allclose(E, E_ref, atol=1e-6)
    assert torch.allclose(rho, rho_ref, atol=1e-6)
    assert torch.allclose(phi, phi_ref, atol=1e-6)

    # 2. Confirm that rho is the integral of delta f over velocity space
    n_calc = torch.sum(f_data, dim=1) * dv
    rho_calc_from_f = n_calc - 1.0

    assert torch.allclose(rho, rho_calc_from_f, atol=1e-6)

    # 3. Confirm d^2 phi / dx^2 = -rho
    # Analytical solution: phi = (epsilon / k^2) * cos(kx)
    phi_analytical = (epsilon / k**2) * torch.cos(k * x)

    assert torch.allclose(phi, phi_analytical, atol=1e-5)

    # 4. Confirm that E = -dphi/dx
    # Analytical solution: E = (epsilon / k) * sin(kx)
    E_analytical = (epsilon / k) * torch.sin(k * x)

    assert torch.allclose(E, E_analytical, atol=1e-5)
