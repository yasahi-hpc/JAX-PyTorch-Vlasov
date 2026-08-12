#include <limits>
#include <gtest/gtest.h>
#include "vlasov_poisson.hpp"
#include "Test_Utils.hpp"

namespace {
using execution_space = Kokkos::DefaultExecutionSpace;
using test_types      = ::testing::Types<std::pair<float, Kokkos::LayoutLeft>,
                                    std::pair<float, Kokkos::LayoutRight>,
                                    std::pair<double, Kokkos::LayoutLeft>,
                                    std::pair<double, Kokkos::LayoutRight> >;

template <typename T>
struct TestAdvection : public ::testing::Test {
  using float_type  = typename T::first_type;
  using layout_type = typename T::second_type;
};

/// \brief Test advection with periodic boundary conditions
/// \tparam T
/// \tparam LayoutType
/// \param[in] solver_type 0 TeamPolicy, 1 MDRangePolicy
template <typename T, typename LayoutType>
void test_advection_1d_periodic(int solver_type) {
  using RealView2DType = Kokkos::View<T**, LayoutType, execution_space>;
  using GridType       = Grid<execution_space, T>;

  int nx = 64, nv = 32;
  T lx = 2.0 * M_PI, vmax = 5.0;

  GridType grid(nx, nv, lx, vmax);
  RealView2DType fn("f", nx, nv), ref_fn("ref_fn", nx, nv);
  [[maybe_unused]] RealView2DType fnp1("fnp1", nx,
                                       nv);  // Only used for solver_type 1

  // Initialize f(x,v) = exp(-0.5 * ( (x - x0)^2/sigma_x^2 ))
  T x0 = lx / 2.0, sigma_x = lx / 10.0;
  auto h_fn = Kokkos::create_mirror_view(fn);
  auto h_x = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_x);
  for (int ix = 0; ix < nx; ++ix) {
    T x = h_x(ix);
    for (int iv = 0; iv < nv; ++iv) {
      h_fn(ix, iv) = std::exp(-0.5 * std::pow((x - x0) / sigma_x, 2));
    }
  }
  Kokkos::deep_copy(fn, h_fn);

  // set advection velocity constant
  T v_drift = 1.0;
  Kokkos::deep_copy(grid.m_v, v_drift);

  // Advect for dt
  T dt = 0.1;

  // Advect in x
  execution_space exec;
  if (solver_type == 0) {
    advect_1d_core<0>(exec, fn, grid.m_x, grid.m_v, dt, grid.m_nx, grid.m_lx,
                      T(0.0), T(1.0) / grid.m_dx);
    exec.fence();
  } else {
    advect_1d_core<0>(exec, fn, fnp1, grid.m_x, grid.m_v, dt, grid.m_nx,
                      grid.m_lx, T(0.0), T(1.0) / grid.m_dx);
    exec.fence();
    Kokkos::kokkos_swap(fn, fnp1);
  }

  // Analytical solution after advection
  T x_shifted   = v_drift * dt + x0;
  auto h_ref_fn = Kokkos::create_mirror_view(ref_fn);
  for (int ix = 0; ix < nx; ++ix) {
    T x = h_x(ix);
    for (int iv = 0; iv < nv; ++iv) {
      // periodic wrap-around
      T x_new = x - x_shifted;
      x_new -= lx * std::round(x_new / lx);
      h_ref_fn(ix, iv) = std::exp(-0.5 * std::pow((x_new) / sigma_x, 2));
    }
  }

  // Compare numerical and analytical solutions
  T epsilon = std::is_same_v<T, float> ? T(1e-2) : T(1e-7);
  Kokkos::deep_copy(h_fn, fn);
  for (int ix = 0; ix < nx; ++ix) {
    for (int iv = 0; iv < nv; ++iv) {
      EXPECT_NEAR(h_fn(ix, iv), h_ref_fn(ix, iv), epsilon);
    }
  }
}

/// \brief Test advection with Dirichlet boundary conditions
/// \tparam T
/// \tparam LayoutType
/// \param[in] solver_type 0 TeamPolicy, 1 MDRangePolicy
template <typename T, typename LayoutType>
void test_advection_1d_dirichlet(int solver_type) {
  using RealView2DType = Kokkos::View<T**, LayoutType, execution_space>;
  using GridType       = Grid<execution_space, T>;

  int nx = 64, nv = 32;
  T lx = 2.0 * M_PI, vmax = 5.0;

  GridType grid(nx, nv, lx, vmax);
  RealView2DType fn("f", nx, nv), ref_fn("ref_fn", nx, nv);
  [[maybe_unused]] RealView2DType fnp1("fnp1", nx,
                                       nv);  // Only used for solver_type 1

  // Initialize f(x,v) = exp(-0.5 * ( (v - v0)^2/sigma_v^2 ))
  T v0 = 0.0, sigma_v = vmax / 4.0;
  auto h_fn = Kokkos::create_mirror_view(fn);
  auto h_v = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_v);
  for (int ix = 0; ix < nx; ++ix) {
    for (int iv = 0; iv < nv; ++iv) {
      T v          = h_v(iv);
      h_fn(ix, iv) = std::exp(-0.5 * std::pow((v - v0) / sigma_v, 2));
    }
  }
  Kokkos::deep_copy(fn, h_fn);

  // set advection velocity constant
  T a_drift = 1.0;
  Kokkos::deep_copy(grid.m_x, a_drift);

  // Advect for dt
  T dt = 0.1;

  // Advect in v
  execution_space exec;
  if (solver_type == 0) {
    advect_1d_core<1>(exec, fn, grid.m_v, grid.m_x, dt, grid.m_nv,
                      T(2.0) * grid.m_vmax, -grid.m_vmax, T(1.0) / grid.m_dv);
    exec.fence();
  } else {
    advect_1d_core<1>(exec, fn, fnp1, grid.m_v, grid.m_x, dt, grid.m_nv,
                      T(2.0) * grid.m_vmax, -grid.m_vmax, T(1.0) / grid.m_dv);
    exec.fence();
    Kokkos::kokkos_swap(fn, fnp1);
  }

  // Analytical solution after advection
  T v_shift     = a_drift * dt;
  auto h_ref_fn = Kokkos::create_mirror_view(ref_fn);
  for (int ix = 0; ix < nx; ++ix) {
    for (int iv = 0; iv < nv; ++iv) {
      // dirichlet boundary conditions
      T v               = h_v(iv);
      T v_new           = v - v_shift;
      bool is_in_bounds = (v_new >= -vmax) && (v_new <= vmax);
      h_ref_fn(ix, iv) =
          is_in_bounds ? std::exp(-0.5 * std::pow((v_new - v0) / sigma_v, 2))
                       : T(0);
    }
  }

  // Compare numerical and analytical solutions
  T epsilon = std::is_same_v<T, float> ? T(1e-2) : T(2e-5);
  Kokkos::deep_copy(h_fn, fn);
  for (int ix = 0; ix < nx; ++ix) {
    for (int iv = 0; iv < nv; ++iv) {
      EXPECT_NEAR(h_fn(ix, iv), h_ref_fn(ix, iv), epsilon);
    }
  }
}

}  // namespace

TYPED_TEST_SUITE(TestAdvection, test_types);

// Test advection with periodic boundary conditions for different precision
// types
TYPED_TEST(TestAdvection, x_periodic_team) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_advection_1d_periodic<FloatType, LayoutType>(0);
}

TYPED_TEST(TestAdvection, x_periodic_mdrange) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_advection_1d_periodic<FloatType, LayoutType>(1);
}

// Test advection with dirichlet boundary conditions for different precision
// types
TYPED_TEST(TestAdvection, v_dirichlet_team) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_advection_1d_dirichlet<FloatType, LayoutType>(0);
}

TYPED_TEST(TestAdvection, v_dirichlet_mdrange) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_advection_1d_dirichlet<FloatType, LayoutType>(1);
}
