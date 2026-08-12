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
struct TestPoisson2D2V : public ::testing::Test {
  using float_type  = typename T::first_type;
  using layout_type = typename T::second_type;
};

template <typename T, typename LayoutType>
void test_efield_initialization() {
  using EfieldType = Efield<execution_space, T, LayoutType>;
  int nx = 128, ny = 64;
  execution_space exec;

  ASSERT_NO_THROW(EfieldType efield(exec, nx, ny););
}

/// \brief Test compute_rho function
/// rho = \int f dvx dvy
/// \tparam T
/// \tparam LayoutType
template <typename T, typename LayoutType>
void test_compute_rho() {
  using VariablesType = Variables<execution_space, T, LayoutType>;
  using FieldType     = Field<execution_space, T, LayoutType>;
  using EfieldType    = Efield<execution_space, T, LayoutType>;

  int nx = 32, ny = 32, nvx = 32, nvy = 32;
  T lx = 2.0 * M_PI, ly = 4.0 * M_PI;
  T Vx_max = 5.0, Vy_max = 7.0;
  T dvx = 2.0 * Vx_max / (nvx - 1);
  T dvy = 2.0 * Vy_max / (nvy - 1);
  execution_space exec;

  VariablesType vars(nx, ny, nvx, nvy);
  FieldType field(nx, ny);
  EfieldType efield(exec, nx, ny);

  // Initialize distribution function f(x,y,vx,vy) = (1 + cos(kx*x) * cos(ky*y))
  // * exp(-0.5 * (vx^2 + vy^2))
  auto h_fn = Kokkos::create_mirror_view(vars.m_fn);
  for (int ix = 0; ix < nx; ++ix) {
    for (int iy = 0; iy < ny; ++iy) {
      T x = static_cast<T>(ix) * (lx / nx);
      T y = static_cast<T>(iy) * (ly / ny);
      for (int ivx = 0; ivx < nvx; ++ivx) {
        T vx = -Vx_max + static_cast<T>(ivx) * (2.0 * Vx_max / (nvx - 1));
        for (int ivy = 0; ivy < nvy; ++ivy) {
          T vy = -Vy_max + static_cast<T>(ivy) * (2.0 * Vy_max / (nvy - 1));
          h_fn(ix, iy, ivx, ivy) =
              (1.0 + std::cos(1.0 * x) * std::cos(2.0 * y)) *
              std::exp(-0.5 * (vx * vx + vy * vy));
        }
      }
    }
  }

  Kokkos::deep_copy(vars.m_fn, h_fn);

  // Compute density rho
  efield.compute_rho(vars.m_fn, field.m_rho, dvx, dvy);

  auto h_rho =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, field.m_rho);
  for (int ix = 0; ix < nx; ++ix) {
    for (int iy = 0; iy < ny; ++iy) {
      T expected_rho = 0.0;
      for (int ivx = 0; ivx < nvx; ++ivx) {
        for (int ivy = 0; ivy < nvy; ++ivy) {
          expected_rho += h_fn(ix, iy, ivx, ivy) * dvx * dvy;
        }
      }
      EXPECT_NEAR(h_rho(ix, iy), expected_rho, fp_tolerance(expected_rho));
    }
  }
}

/// \brief Test compute_poisson function
/// \tparam T
/// \tparam LayoutType
template <typename T, typename LayoutType>
void test_compute_poisson() {
  using GridType   = Grid<execution_space, T, LayoutType>;
  using FieldType  = Field<execution_space, T, LayoutType>;
  using EfieldType = Efield<execution_space, T, LayoutType>;

  int nx = 32, ny = 32, nvx = 32, nvy = 32;
  T lx = 2.0 * M_PI, ly = 4.0 * M_PI;
  T Vx_max = 5.0, Vy_max = 7.0;
  execution_space exec;

  GridType grid(nx, ny, nvx, nvy, lx, ly, Vx_max, Vy_max);
  FieldType field(nx, ny);
  EfieldType efield(exec, nx, ny);

  // Initialize a sinusoidal charge density rho(x) = A * sin(kx * x)
  T A  = 1.0;
  T kx = 2.0 * M_PI / lx, ky = 2.0 * M_PI / ly;
  auto h_rho = Kokkos::create_mirror_view(field.m_rho);
  auto h_x = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_x);
  auto h_y = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_y);

  using HostViewType = decltype(h_rho);
  HostViewType h_phi_ref("phi_ref", nx, ny), h_Ex_ref("Ex_ref", nx, ny),
      h_Ey_ref("Ey_ref", nx, ny);
  for (int ix = 0; ix < nx; ++ix) {
    for (int iy = 0; iy < ny; ++iy) {
      T x = h_x(ix);
      T y = h_y(iy);

      h_rho(ix, iy) = A * std::cos(kx * x) * std::cos(ky * y);

      // analytical solution for phi and E
      // phi(x) = (A / kx^2) * sin(kx * x)
      // E(x)   = -(A / kx) * cos(kx * x)
      T inv_ksq         = 1.0 / (kx * kx + ky * ky);
      h_phi_ref(ix, iy) = (A * inv_ksq) * std::cos(kx * x) * std::cos(ky * y);
      h_Ex_ref(ix, iy) =
          (A * inv_ksq * kx) * std::sin(kx * x) * std::cos(ky * y);
      h_Ey_ref(ix, iy) =
          (A * inv_ksq * ky) * std::cos(kx * x) * std::sin(ky * y);
    }
  }
  Kokkos::deep_copy(field.m_rho, h_rho);

  // Solve Poisson's equation in Fourier space
  efield.compute_poisson(field.m_rho, field.m_Ex, field.m_Ey, field.m_phi,
                         grid.m_kx, grid.m_ky, grid.m_inv_ksq);

  // Make reference for phi and E
  auto h_phi =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, field.m_phi);
  auto h_Ex =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, field.m_Ex);
  auto h_Ey =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, field.m_Ey);
  for (int ix = 0; ix < nx; ++ix) {
    for (int iy = 0; iy < ny; ++iy) {
      EXPECT_NEAR(h_phi(ix, iy), h_phi_ref(ix, iy),
                  fp_tolerance(h_phi_ref(ix, iy)));
      EXPECT_NEAR(h_Ex(ix, iy), h_Ex_ref(ix, iy),
                  fp_tolerance(h_Ex_ref(ix, iy)));
      EXPECT_NEAR(h_Ey(ix, iy), h_Ey_ref(ix, iy),
                  fp_tolerance(h_Ey_ref(ix, iy)));
    }
  }
}
}  // namespace

TYPED_TEST_SUITE(TestPoisson2D2V, test_types);

// Test efields initialization for different precision types
TYPED_TEST(TestPoisson2D2V, EFieldInitialization) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_efield_initialization<FloatType, LayoutType>();
}

// Test velocity space integral for different precision types
TYPED_TEST(TestPoisson2D2V, ComputeRho) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_compute_rho<FloatType, LayoutType>();
}

// Test Poisson solver for different precision types
TYPED_TEST(TestPoisson2D2V, ComputePoisson) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_compute_poisson<FloatType, LayoutType>();
}
