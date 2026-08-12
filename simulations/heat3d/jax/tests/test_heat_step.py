import jax
import jax.numpy as jnp
import numpy as np
import math
import pytest
import src.heat3d


class TestHeatStep:
    """Tests for the heat_step kernel (7-point stencil Laplacian)."""

    def test_uniform_field_unchanged(self):
        """A spatially uniform field has zero Laplacian, so heat_step is identity."""
        N = 8
        u = jnp.ones((N, N, N))
        coeff = 0.1

        result = src.heat3d.heat_step(u, coeff)

        assert jnp.allclose(result, u, atol=1e-6)

    def test_single_point_source(self):
        """A single hot point should diffuse outward (value decreases)."""
        N = 8
        u = jnp.zeros((N, N, N))
        u = u.at[4, 4, 4].set(1.0)
        coeff = 0.1

        result = src.heat3d.heat_step(u, coeff)

        # Center should decrease (diffuse outward)
        assert result[4, 4, 4] < 1.0
        # Neighbors should increase
        assert result[5, 4, 4] > 0.0
        assert result[3, 4, 4] > 0.0
        assert result[4, 5, 4] > 0.0
        assert result[4, 3, 4] > 0.0
        assert result[4, 4, 5] > 0.0
        assert result[4, 4, 3] > 0.0

    def test_periodic_boundary(self):
        """Verify that the stencil wraps around (periodic BC)."""
        N = 8
        u = jnp.zeros((N, N, N))
        # Place a hot point at the boundary
        u = u.at[0, 0, 0].set(1.0)
        coeff = 0.1

        result = src.heat3d.heat_step(u, coeff)

        # The periodic neighbor u[N-1, 0, 0] should receive heat
        assert result[N - 1, 0, 0] > 0.0
        # And u[1, 0, 0]
        assert result[1, 0, 0] > 0.0
        # And u[0, N-1, 0], u[0, 1, 0], u[0, 0, N-1], u[0, 0, 1]
        assert result[0, N - 1, 0] > 0.0
        assert result[0, 1, 0] > 0.0
        assert result[0, 0, N - 1] > 0.0
        assert result[0, 0, 1] > 0.0

    def test_conservation_of_energy(self):
        """The total sum of u should be conserved by the Laplacian stencil."""
        N = 16
        key = jax.random.PRNGKey(42)
        u = jax.random.normal(key, (N, N, N))
        coeff = 0.01

        result = src.heat3d.heat_step(u, coeff)

        assert jnp.isclose(jnp.sum(result), jnp.sum(u), atol=1e-4)

    def test_cosine_mode_laplacian(self):
        """
        For u = cos(kx*x)*cos(ky*y)*cos(kz*z), the Laplacian is:
        L[u] = -(kx^2 + ky^2 + kz^2) * u  (continuous).
        Verify heat_step applies the discrete Laplacian correctly.

        --- DERIVATION OF THE DISCRETE EIGENVALUE ---
        1. The 1D Discrete Stencil:
           In one dimension, the Laplacian operation on grid index 'i' is:
           Δu_i = u_{i+1} - 2u_i + u_{i-1}

        2. Substitution:
           Let u_i = cos(k * i * dx). Then:
           Δu_i = cos(k(i+1)dx) - 2cos(k * i * dx) + cos(k(i-1)dx)

        3. Trigonometric Identity:
           Using cos(A+B) + cos(A-B) = 2cos(A)cos(B), where A = k*i*dx and B = k*dx:
           Δu_i = 2cos(k * i * dx)cos(k * dx) - 2cos(k * i * dx)

        4. Factoring:
           Δu_i = [2cos(k * dx) - 2] * cos(k * i * dx)
           The term in brackets is the 'raw_eigenvalue' for one dimension.

        5. 3D Extension:
           The 7-point stencil is the sum of the 1D stencils in x, y, and z.
           Since our field is a product of cosines, the total eigenvalue is:
           λ_total = (2cos(kx*dx)-2) + (2cos(ky*dy)-2) + (2cos(kz*dz)-2)
        """
        N = 32
        L = 2.0 * jnp.pi
        dx = L / N
        kx, ky, kz = 1.0, 1.0, 1.0

        xs = jnp.linspace(0, L, N, endpoint=False)
        x, y, z = jnp.meshgrid(xs, xs, xs, indexing="ij")
        u = jnp.cos(kx * x) * jnp.cos(ky * y) * jnp.cos(kz * z)

        # Use physical coeff = kappa * dt / dx^2 to match how it's used in practice
        kappa = 1.0
        dt = 1e-4
        coeff = kappa * dt / (dx**2)
        result = src.heat3d.heat_step(u, coeff)

        # heat_step computes: u + coeff * (sum_neighbors - 6*u)
        # The raw stencil (without dx^2) has eigenvalue per axis: 2*cos(k*dx) - 2
        # coeff already includes 1/dx^2, so expected = u + coeff * raw_eigenvalue * u
        lam_x = 2 * jnp.cos(kx * dx) - 2
        lam_y = 2 * jnp.cos(ky * dx) - 2
        lam_z = 2 * jnp.cos(kz * dx) - 2
        raw_eigenvalue = lam_x + lam_y + lam_z

        expected = u + coeff * raw_eigenvalue * u

        assert jnp.allclose(result, expected, atol=1e-5)

    def test_jit_compatible(self):
        """heat_step should work inside jax.jit."""
        N = 8
        u = jnp.ones((N, N, N))
        coeff = 0.1

        jitted_step = jax.jit(lambda u: src.heat3d.heat_step(u, coeff))
        result = jitted_step(u)

        assert jnp.allclose(result, u, atol=1e-6)


class TestHeatStepConv:
    """Tests for the conv-based heat step with prebuilt kernel."""

    def test_build_conv_kernel_values(self):
        kernel = src.heat3d.build_conv_kernel(jnp.float32)

        assert kernel.shape == (1, 1, 3)
        assert kernel.dtype == jnp.float32
        assert jnp.isclose(kernel[0, 0, 0], 1.0)
        assert jnp.isclose(kernel[0, 0, 1], -2.0)
        assert jnp.isclose(kernel[0, 0, 2], 1.0)

        # Derivative kernel should sum to zero.
        assert jnp.isclose(jnp.sum(kernel), 0.0)

    def test_uniform_field_unchanged(self):
        N = 8
        u = jnp.ones((N, N, N), dtype=jnp.float32)
        coeff = 0.1
        kernel = src.heat3d.build_conv_kernel(u.dtype)

        result = src.heat3d.heat_step_conv(u, coeff, kernel)

        assert jnp.allclose(result, u, atol=1e-6)

    def test_matches_roll_implementation(self):
        N = 8
        key = jax.random.PRNGKey(7)
        u = jax.random.normal(key, (N, N, N), dtype=jnp.float32)
        coeff = 0.01
        kernel = src.heat3d.build_conv_kernel(u.dtype)

        conv_result = src.heat3d.heat_step_conv(u, coeff, kernel)
        roll_result = src.heat3d.heat_step_roll(u, coeff)

        assert jnp.allclose(conv_result, roll_result, atol=1e-5)
