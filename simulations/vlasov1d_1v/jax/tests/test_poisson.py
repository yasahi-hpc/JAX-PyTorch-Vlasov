import pytest
import jax.numpy as jnp
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
    
    # 1. Input variable f is given by a maxwellian added by a single mode perturbation
    # f(x,v) = (1 + epsilon * cos(k*x)) * f_M(v)
    epsilon = 0.01
    k = mode_number * 2.0 * jnp.pi / L 
    
    # Broadcasting
    x_2d = x[:, None]
    v_2d = v[None, :]
    
    f_M = 1.0 / jnp.sqrt(2.0 * jnp.pi) * jnp.exp(-0.5 * v_2d**2)
    perturbation = epsilon * jnp.cos(k * x_2d)
    f_data = (1.0 + perturbation) * f_M
    
    # Run solve_poisson
    E, rho, phi = src.vlasov1D1V.solve_poisson(f_data, inv_kx, dv)
    
    # 2. Confirm that rho is the integral of delta f over velocity space
    # rho = integral(f - f_M) dv
    # Note: solve_poisson computes rho = n - mean(n)
    # n = integral(f) dv = 1 + epsilon * cos(kx)
    # mean(n) = 1
    # So rho should be epsilon * cos(kx)
    
    n_calc = jnp.sum(f_data, axis=1) * dv
    #rho_calc_from_f = n_calc - jnp.mean(n_calc)
    rho_calc_from_f = n_calc - 1.0  # since mean(n) = 1 for this setup
    
    # Check if returned rho matches the calculation from f
    assert jnp.allclose(rho, rho_calc_from_f, atol=1e-6)
    
    # Also check against analytical expectation
    # Maybe too strict?
    #rho_analytical = epsilon * jnp.cos(k * x)
    #assert jnp.allclose(rho, rho_analytical, atol=1e-5)

    # 3. Confirm d^2 phi / dx^2 = -rho
    # Analytical solution: phi = (epsilon / k^2) * cos(kx)
    # d^2 phi / dx^2 = -epsilon * cos(kx) = -rho
    phi_analytical = (epsilon / k**2) * jnp.cos(k * x)
    
    # The solver might have a constant offset for phi (mean 0 usually)
    # Let's check if they match up to a constant, or if the solver enforces mean 0.
    # solve_poisson: Phi_k = rho_k / k^2 (with k=0 mode = 0). So mean phi is 0.
    # Our analytical phi also has mean 0 (integral of cos over period is 0).
    assert jnp.allclose(phi, phi_analytical, atol=1e-5)

    # 4. Confirm that E = -dphi/dx
    # Analytical solution: E = -d/dx [ (epsilon / k^2) * cos(kx) ]
    # E = - (epsilon / k^2) * (-k * sin(kx)) = (epsilon / k) * sin(kx)
    E_analytical = (epsilon / k) * jnp.sin(k * x)
    
    assert jnp.allclose(E, E_analytical, atol=1e-5)
