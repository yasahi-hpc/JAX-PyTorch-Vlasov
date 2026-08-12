import pytest
import torch
import numpy as np
import src.vlasov2D2V

@pytest.mark.parametrize("mode_number", [1, 2, 3])
def test_solve_poisson_properties(grid_instance, mode_number):
    """
    Test solve_poisson function.
    1. Input f is maxwellian + single mode perturbation.
    2. Confirm rho is integral of delta f.
    3. Confirm nabla^2 phi = -rho.
    4. Confirm Ex = -dphi/dx, Ey = -dphi/dy.
    """
    # Setup
    Nx = grid_instance.Nx
    Ny = grid_instance.Ny
    Nvx = grid_instance.Nvx
    Nvy = grid_instance.Nvy
    Lx = grid_instance.Lx
    Ly = grid_instance.Ly
    dx = grid_instance.dx
    dy = grid_instance.dy
    dvx = grid_instance.dvx
    dvy = grid_instance.dvy
    kx = grid_instance.kx
    ky = grid_instance.ky
    inv_ksq = grid_instance.inv_ksq

    # 1. Input variable f is given by a maxwellian added by a single mode perturbation
    # f(x,y,vx,vy) = (1 + epsilon * cos(kx0*x) * cos(ky0*y)) * f_M(vx,vy)
    epsilon = 0.01
    kx0 = mode_number * 2.0 * torch.pi / Lx
    ky0 = mode_number * 2.0 * torch.pi / Ly

    # Broadcasting
    x_mesh = grid_instance.x[:, None]
    y_mesh = grid_instance.y[None, :]
    vx_mesh = grid_instance.vx[:, None]
    vy_mesh = grid_instance.vy[None, :]

    f_M = 1.0 / torch.sqrt(torch.tensor(2.0 * torch.pi)) * torch.exp(-0.5 * (vx_mesh**2 + vy_mesh**2))
    perturbation = epsilon * torch.cos(kx0 * x_mesh) * torch.cos(ky0 * y_mesh)
    f_data = (1.0 + perturbation[:, :, None, None]) * f_M[None, None, :, :]

    # 2. Confirm that rho is the integral of f over velocity space
    rho = src.vlasov2D2V.compute_rho(f_data, dvx, dvy)
    rho_ref = torch.sum(f_data, dim=(2, 3)) * dvx * dvy

    # Check if returned rho matches the calculation from f
    assert torch.allclose(rho, rho_ref, atol=1e-6)

    # Solve Poisson with the analytical perturbation as rho input
    rho_analytical = perturbation
    Ex, Ey, delta_rho, phi = src.vlasov2D2V.compute_poisson(rho_analytical, kx, ky, inv_ksq)

    assert torch.allclose(delta_rho, rho_analytical - 1, atol=1e-6)

    # 3. Confirm nabla^2 phi = -rho
    # Analytical solution: phi = (epsilon / (kx0^2 + ky0^2)) * cos(kx0*x) * cos(ky0*y)
    phi_analytical = (epsilon / (kx0**2 + ky0**2)) * torch.cos(kx0 * x_mesh) * torch.cos(ky0 * y_mesh)

    assert torch.allclose(phi, phi_analytical, atol=1e-5)

    # 4. Confirm that Ex = -dphi/dx
    # Ex = (epsilon * kx0 / (kx0^2 + ky0^2)) * sin(kx0*x) * cos(ky0*y)
    Ex_analytical = (epsilon * kx0 / (kx0**2 + ky0**2)) * torch.sin(kx0 * x_mesh) * torch.cos(ky0 * y_mesh)

    assert torch.allclose(Ex, Ex_analytical, atol=1e-5)

    # 5. Confirm that Ey = -dphi/dy
    # Ey = (epsilon * ky0 / (kx0^2 + ky0^2)) * cos(kx0*x) * sin(ky0*y)
    Ey_analytical = (epsilon * ky0 / (kx0**2 + ky0**2)) * torch.cos(kx0 * x_mesh) * torch.sin(ky0 * y_mesh)

    assert torch.allclose(Ey, Ey_analytical, atol=1e-5)
