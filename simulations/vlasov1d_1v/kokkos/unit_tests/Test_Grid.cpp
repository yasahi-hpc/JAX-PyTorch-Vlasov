#include <limits>
#include <gtest/gtest.h>
#include "vlasov_poisson.hpp"
#include "Test_Utils.hpp"

namespace {
using execution_space = Kokkos::DefaultExecutionSpace;
using float_types     = ::testing::Types<float, double>;

template <typename T>
struct TestGridInitialization : public ::testing::Test {
  using float_type = T;
};

template <typename RealType>
void test_grid_initialization() {
  using GridType = Grid<execution_space, RealType>;

  int nx        = 128;
  int nv        = 64;
  RealType lx   = 2.0 * M_PI;
  RealType vmax = 5.0;

  GridType grid(nx, nv, lx, vmax);

  // Check grid properties
  ASSERT_EQ(grid.m_nx, nx);
  ASSERT_EQ(grid.m_nv, nv);

  EXPECT_NEAR(grid.m_lx, lx, fp_tolerance(lx));
  EXPECT_NEAR(grid.m_vmax, vmax, fp_tolerance(vmax));

  RealType dx = lx / nx;
  RealType dv = 2.0 * vmax / (nv - 1);
  EXPECT_NEAR(grid.m_dx, dx, fp_tolerance(dx));
  EXPECT_NEAR(grid.m_dv, dv, fp_tolerance(dv));

  // Check grid values
  auto h_x = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_x);
  auto h_v = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_v);
  auto h_inv_kx =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_inv_kx);

  for (int i = 0; i < nx; ++i) {
    RealType ref_x = i * grid.m_dx;
    EXPECT_NEAR(h_x(i), ref_x, fp_tolerance(ref_x));
  }

  for (int j = 0; j < nv; ++j) {
    RealType ref_v = -vmax + j * grid.m_dv;
    EXPECT_NEAR(h_v(j), ref_v, fp_tolerance(ref_v));
  }

  for (int i = 0; i < nx / 2 + 1; ++i) {
    RealType ref_inv_kx =
        (i == 0) ? 0.0 : 1.0 / (2.0 * M_PI * (static_cast<RealType>(i) / lx));
    EXPECT_NEAR(h_inv_kx(i), ref_inv_kx, fp_tolerance(ref_inv_kx));
  }
}
}  // namespace

TYPED_TEST_SUITE(TestGridInitialization, float_types);

// Test grid initialization for different precision types
TYPED_TEST(TestGridInitialization, GridInitialization) {
  using FloatType = typename TestFixture::float_type;
  test_grid_initialization<FloatType>();
}
