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
struct TestLagrange : public ::testing::Test {
  using float_type  = typename T::first_type;
  using layout_type = typename T::second_type;
};

/// \brief Test Lagrange interpolation of order 5 with polynomial functions
/// \tparam T
/// \tparam LayoutType
template <typename T, typename LayoutType>
void test_lagrange_interp_5_uniform_exact_polynomials() {
  using RealViewType = Kokkos::View<T*, LayoutType, execution_space>;

  constexpr int num_points = 6, num_tests = 5;
  RealViewType x_stencils("x_stencils", num_points),
      w_stencils("w_stencils", num_points);
  RealViewType x_vals("x_vals", num_tests), vals("vals", num_tests),
      vals_inline("vals_inline", num_tests), ref_vals("ref_vals", num_tests);

  auto polynominal = KOKKOS_LAMBDA(T x) {
    return 2.0 * x * x * x - 3.0 * x * x + x + 5.0;
  };

  // Initialization of stencil points
  auto h_x_stencils = Kokkos::create_mirror_view(x_stencils);
  auto h_w_stencils = Kokkos::create_mirror_view(w_stencils);
  auto h_x_vals     = Kokkos::create_mirror_view(x_vals);
  auto h_ref_vals   = Kokkos::create_mirror_view(ref_vals);

  for (int i = 0; i < num_points; ++i) {
    h_x_stencils(i) = static_cast<T>(i - 2);  // -2 to 3
    h_w_stencils(i) = polynominal(h_x_stencils(i));
  }

  for (int i = 0; i < 5; ++i) {
    h_x_vals(i) = static_cast<T>(-1.5 + i * 0.5);  // -1.5, -1.0, -0.5, 0.0, 0.5
    h_ref_vals(i) = polynominal(h_x_vals(i));
  }

  Kokkos::deep_copy(x_stencils, h_x_stencils);
  Kokkos::deep_copy(w_stencils, h_w_stencils);
  Kokkos::deep_copy(x_vals, h_x_vals);

  execution_space exec;
  Kokkos::parallel_for(
      "lagrange_interp_5_uniform_exact_polynomials",
      Kokkos::RangePolicy<execution_space>(exec, 0, num_tests),
      KOKKOS_LAMBDA(const int i) {
        T indices[6], values[6];
        for (int j = 0; j < 6; ++j) {
          indices[j] = x_stencils(j);
          values[j]  = w_stencils(j);
        }
        T interp_val = lagrange_interp_5_uniform(indices, values, x_vals(i));
        vals(i)      = interp_val;

        interp_val     = lagrange_interp_5_uniform(values, x_vals(i));
        vals_inline(i) = interp_val;
      });
  exec.fence();

  auto h_vals = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, vals);
  auto h_vals_inline =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, vals_inline);
  for (int i = 0; i < num_tests; ++i) {
    EXPECT_NEAR(h_vals(i), h_ref_vals(i), fp_tolerance(h_ref_vals(i)));
    EXPECT_NEAR(h_vals_inline(i), h_ref_vals(i), fp_tolerance(h_ref_vals(i)));
  }
}

/// \brief Test Lagrange interpolation of order 5, evaluated at the nodes
/// \tparam T
/// \tparam LayoutType
template <typename T, typename LayoutType>
void test_lagrange_interp_5_uniform_nodes() {
  using RealViewType = Kokkos::View<T*, LayoutType, execution_space>;

  constexpr int num_points = 6;
  RealViewType x_stencils("x_stencils", num_points),
      w_stencils("w_stencils", num_points);
  RealViewType x_vals("x_vals", num_points), vals("vals", num_points),
      vals_inline("vals_inline", num_points), ref_vals("ref_vals", num_points);

  // Initialization of stencil points
  auto h_x_stencils = Kokkos::create_mirror_view(x_stencils);
  auto h_w_stencils = Kokkos::create_mirror_view(w_stencils);
  auto h_ref_vals   = Kokkos::create_mirror_view(ref_vals);

  for (int i = 0; i < num_points; ++i) {
    h_x_stencils(i) = static_cast<T>(i - 2);        // -2 to 3
    h_w_stencils(i) = static_cast<T>(i * i + 1.0);  // arbitrary values
    h_ref_vals(i)   = h_w_stencils(i);
  }

  Kokkos::deep_copy(x_stencils, h_x_stencils);
  Kokkos::deep_copy(w_stencils, h_w_stencils);
  Kokkos::deep_copy(x_vals, h_x_stencils);  // evaluate at the nodes

  execution_space exec;
  Kokkos::parallel_for(
      "lagrange_interp_5_uniform_nodes",
      Kokkos::RangePolicy<execution_space>(exec, 0, num_points),
      KOKKOS_LAMBDA(const int i) {
        T indices[6], values[6];
        for (int j = 0; j < 6; ++j) {
          indices[j] = x_stencils(j);
          values[j]  = w_stencils(j);
        }
        T interp_val = lagrange_interp_5_uniform(indices, values, x_vals(i));
        vals(i)      = interp_val;

        interp_val     = lagrange_interp_5_uniform(values, x_vals(i));
        vals_inline(i) = interp_val;
      });
  exec.fence();

  auto h_vals = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, vals);
  auto h_vals_inline =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, vals_inline);
  for (int i = 0; i < num_points; ++i) {
    EXPECT_NEAR(h_vals(i), h_ref_vals(i), fp_tolerance(h_ref_vals(i)));
    EXPECT_NEAR(h_vals_inline(i), h_ref_vals(i), fp_tolerance(h_ref_vals(i)));
  }
}
}  // namespace

TYPED_TEST_SUITE(TestLagrange, test_types);

// Test lagrange interpolation for different precision types
TYPED_TEST(TestLagrange, LagrangeInterpolationExactPolynomials) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_lagrange_interp_5_uniform_exact_polynomials<FloatType, LayoutType>();
}

// Test lagrange interpolation on nodes for different precision types
TYPED_TEST(TestLagrange, LagrangeInterpolationNodes) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_lagrange_interp_5_uniform_nodes<FloatType, LayoutType>();
}
