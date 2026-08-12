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
struct TestPoisson : public ::testing::Test {
  using float_type  = typename T::first_type;
  using layout_type = typename T::second_type;
};

template <typename T, typename LayoutType>
void test_efield_initialization() {
  using EfieldType = Efield<execution_space, T, LayoutType>;
  int nx           = 128;
  execution_space exec;

  ASSERT_NO_THROW(EfieldType efield(exec, nx););
}

/// \brief Test compute_rho function
/// rho = \int f dv
/// \tparam T
/// \tparam LayoutType
template <typename T, typename LayoutType>
void test_compute_rho() {
  using VariablesType = Variables<execution_space, T, LayoutType>;
  using FieldType     = Field<execution_space, T, LayoutType>;
  using EfieldType    = Efield<execution_space, T, LayoutType>;

  int nx = 128, nv = 64;
  T vmax = 5.0, dv = 2.0 * vmax / (nv - 1);
  execution_space exec;

  VariablesType vars(nx, nv);
  FieldType field(nx);
  EfieldType efield(exec, nx);

  // Initialize distribution function f(x,v) = exp(-0.5 * ( (x - x0)^2/sigma_x^2
  // + (v - v0)^2/sigma_v^2 ))
  auto h_fn = Kokkos::create_mirror_view(vars.m_fn);
  for (int ix = 0; ix < nx; ++ix) {
    T x = static_cast<T>(ix) * (2.0 * M_PI / nx);
    for (int iv = 0; iv < nv; ++iv) {
      T v          = -5.0 + static_cast<T>(iv) * (10.0 / (nv - 1));
      h_fn(ix, iv) = std::exp(-0.5 * (std::pow((x - M_PI) / 0.5, 2) +
                                      std::pow((v - 0.0) / 1.0, 2)));
    }
  }
  Kokkos::deep_copy(vars.m_fn, h_fn);

  // Compute density rho
  efield.compute_rho(vars.m_fn, field.m_rho, dv);

  auto h_rho =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, field.m_rho);
  for (int ix = 0; ix < nx; ++ix) {
    T expected_rho = 0.0;
    for (int iv = 0; iv < nv; ++iv) {
      expected_rho += h_fn(ix, iv) * dv;
    }
    EXPECT_NEAR(h_rho(ix), expected_rho, fp_tolerance(expected_rho));
  }
}

/// \brief Test compute_poisson function
/// \tparam T
/// \tparam LayoutType
template <typename T, typename LayoutType>
void test_compute_poisson() {
  using GridType   = Grid<execution_space, T>;
  using FieldType  = Field<execution_space, T, LayoutType>;
  using EfieldType = Efield<execution_space, T, LayoutType>;

  int nx = 128, nv = 64;
  T lx = 2.0 * M_PI, vmax = 5.0;
  execution_space exec;

  GridType grid(nx, nv, lx, vmax);
  FieldType field(nx);
  EfieldType efield(exec, nx);

  // Initialize a sinusoidal charge density rho(x) = A * sin(kx * x)
  T A        = 1.0;
  T kx       = 2.0 * M_PI / (2.0 * M_PI);  // one period over domain length 2pi
  auto h_rho = Kokkos::create_mirror_view(field.m_rho);
  auto h_x = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_x);

  using HostViewType = decltype(h_rho);
  HostViewType h_phi_ref("phi_ref", nx), h_E_ref("E_ref", nx);
  for (int ix = 0; ix < nx; ++ix) {
    T x       = h_x(ix);
    h_rho(ix) = A * std::sin(kx * x);

    // analytical solution for phi and E
    // phi(x) = (A / kx^2) * sin(kx * x)
    // E(x)   = -(A / kx) * cos(kx * x)
    h_phi_ref(ix) = (A / (kx * kx)) * std::sin(kx * x);
    h_E_ref(ix)   = -(A / kx) * std::cos(kx * x);
  }
  Kokkos::deep_copy(field.m_rho, h_rho);

  // Solve Poisson's equation in Fourier space
  efield.compute_poisson(field.m_rho, field.m_E, field.m_phi, grid.m_inv_kx);

  // Make reference for phi and E
  auto h_phi =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, field.m_phi);
  auto h_E =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, field.m_E);
  for (int ix = 0; ix < nx; ++ix) {
    EXPECT_NEAR(h_phi(ix), h_phi_ref(ix), fp_tolerance(h_phi_ref(ix)));
    EXPECT_NEAR(h_E(ix), h_E_ref(ix), fp_tolerance(h_E_ref(ix)));
  }
}
}  // namespace

TYPED_TEST_SUITE(TestPoisson, test_types);

// Test efields initialization for different precision types
TYPED_TEST(TestPoisson, EFieldInitialization) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_efield_initialization<FloatType, LayoutType>();
}

// Test velocity space integral for different precision types
TYPED_TEST(TestPoisson, ComputeRho) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_compute_rho<FloatType, LayoutType>();
}

// Test Poisson solver for different precision types
TYPED_TEST(TestPoisson, ComputePoisson) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_compute_poisson<FloatType, LayoutType>();
}
