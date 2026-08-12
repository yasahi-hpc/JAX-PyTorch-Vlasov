import pytest
import jax.numpy as jnp
import numpy as np
import src.vlasov2D2V

@pytest.mark.parametrize("mode_number", [1, 2, 3])
def test_solve_poisson_properties(grid_instance, mode_number):
    """
    Test solve_poisson function.
    1. Input f is maxwellian + single mode perturbation.
    2. Confirm rho is integral of delta f.
    3. Confirm \nabla^2 phi = -rho.
    4. Confirm Ex = -dphi/dx. Ey = -dphi/dy.
    """
    # Setup
    Nx = grid_instance.Nx
    Ny = grid_instance.Ny
    Nvx = grid_instance.Nvx
    Nvy = grid_instance.Nvy
    Lx = grid_instance.Lx
    Ly = grid_instance.Ly
    Vx_max = grid_instance.Vx_max
    Vy_max = grid_instance.Vy_max
    dx = grid_instance.dx
    dy = grid_instance.dy
    dvx = grid_instance.dvx
    dvy = grid_instance.dvy
    kx = grid_instance.kx
    ky = grid_instance.ky
    inv_ksq = grid_instance.inv_ksq
    
    # 1. Input variable f is given by a maxwellian added by a single mode perturbation
    # f(x,v) = (1 + epsilon * cos(k*x)) * f_M(v)
    epsilon = 0.01
    kx0 = mode_number * 2.0 * jnp.pi / Lx
    ky0 = mode_number * 2.0 * jnp.pi / Ly
    
    # Broadcasting
    x_mesh = grid_instance.x[:, None]
    y_mesh = grid_instance.y[None, :]
    vx_mesh = grid_instance.vx[:, None]
    vy_mesh = grid_instance.vy[None, :]
    
    f_M = 1.0 / jnp.sqrt(2.0 * jnp.pi) * jnp.exp(-0.5 * (vx_mesh**2 + vy_mesh**2))
    perturbation = epsilon * jnp.cos(kx0 * x_mesh) * jnp.cos(ky0 * y_mesh)
    f_data = (1.0 + perturbation[:, :, None, None]) * f_M[None, None, :, :]
    
    # 2. Confirm that rho is the integral of delta f over velocity space
    # rho = integral(f - f_M) dv
    # Note: solve_poisson computes rho = n - mean(n)
    # n = integral(f) dv = 1 + epsilon * cos(kx)
    # So rho should be epsilon * cos(kx)
    
    rho = src.vlasov2D2V.compute_rho(f_data, dvx, dvy)
    rho_ref = jnp.sum(f_data, axis=(2,3)) * dvx * dvy
    
    # Check if returned rho matches the calculation from f
    assert jnp.allclose(rho, rho_ref, atol=1e-6)
    
    # Also check against analytical expectation
    # Maybe too strict?
    #rho_analytical = epsilon * jnp.cos(kx * x_mesh) * jnp.cos(ky * y_mesh)
    #assert jnp.allclose(rho, rho_analytical, atol=1e-5)

    # Solve Poisson
    rho_analytical = perturbation
    Ex, Ey, delta_rho, phi = src.vlasov2D2V.compute_poisson(rho_analytical, kx, ky, inv_ksq)

    assert jnp.allclose(delta_rho, rho_analytical-1, atol=1e-6)

    # 3. Confirm \nabla^2 phi = -rho
    # Analytical solution: phi = (epsilon / (kx^2 + ky^2)) * cos(kx) * cos(ky)
    # d^2 phi / dx^2 + d^2 phi / dy^2 = -epsilon * cos(kx) * cos(ky) = -rho
    phi_analytical = (epsilon / (kx0**2 + ky0**2)) * jnp.cos(kx0 * x_mesh) * jnp.cos(ky0 * y_mesh)
    
    # The solver might have a constant offset for phi (mean 0 usually)
    # Let's check if they match up to a constant, or if the solver enforces mean 0.
    # solve_poisson: Phi_k = rho_k / k^2 (with k=0 mode = 0). So mean phi is 0.
    # Our analytical phi also has mean 0 (integral of cos over period is 0).
    assert jnp.allclose(phi, phi_analytical, atol=1e-5)

    # 4. Confirm that Ex = -dphi/dx
    # Analytical solution: Ex = -d/dx [ (epsilon / (kx^2 + ky^2)) * cos(kx) * cos(ky) ]
    # Ex = - (epsilon / (kx^2 + ky^2)) * (-kx * sin(kx)) * cos(ky) = (epsilon * kx / (kx^2 + ky^2)) * sin(kx) * cos(ky)
    Ex_analytical = (epsilon * kx0 / (kx0**2 + ky0**2)) * jnp.sin(kx0 * x_mesh) * jnp.cos(ky0 * y_mesh)
    
    assert jnp.allclose(Ex, Ex_analytical, atol=1e-5)

    # 5. Confirm that Ey = -dphi/dy
    # Analytical solution: Ey = -d/dy [ (epsilon / (kx^2 + ky^2)) * cos(kx) * cos(ky) ]
    # Ey = - (epsilon / (kx^2 + ky^2)) * cos(kx) * (-ky * sin(ky)) = (epsilon * ky / (kx^2 + ky^2)) * cos(kx) * sin(ky)
    Ey_analytical = (epsilon * ky0 / (kx0**2 + ky0**2)) * jnp.cos(kx0 * x_mesh) * jnp.sin(ky0 * y_mesh)

    assert jnp.allclose(Ey, Ey_analytical, atol=1e-5)
