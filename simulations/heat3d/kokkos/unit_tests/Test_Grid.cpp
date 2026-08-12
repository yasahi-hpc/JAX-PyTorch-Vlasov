#include <limits>
#include <gtest/gtest.h>
#include "heat3d.hpp"
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

  int nx = 128, ny = 64, nz = 32;
  RealType lx = 2.0 * M_PI, ly = M_PI, lz = M_PI / 2.0;

  GridType grid(nx, ny, nz, lx, ly, lz);

  // Check grid properties
  ASSERT_EQ(grid.m_nx, nx);
  ASSERT_EQ(grid.m_ny, ny);
  ASSERT_EQ(grid.m_nz, nz);

  EXPECT_EQ(grid.m_lx, lx);
  EXPECT_EQ(grid.m_ly, ly);
  EXPECT_EQ(grid.m_lz, lz);

  RealType dx = lx / nx;
  RealType dy = ly / ny;
  RealType dz = lz / nz;
  EXPECT_NEAR(grid.m_dx, dx, fp_tolerance(dx));
  EXPECT_NEAR(grid.m_dy, dy, fp_tolerance(dy));
  EXPECT_NEAR(grid.m_dz, dz, fp_tolerance(dz));

  // Check grid values
  auto h_x = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_x);
  auto h_y = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_y);
  auto h_z = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_z);

  for (int i = 0; i < nx; ++i) {
    RealType ref_x = i * grid.m_dx;
    EXPECT_NEAR(h_x(i), ref_x, fp_tolerance(ref_x));
  }

  for (int j = 0; j < ny; ++j) {
    RealType ref_y = j * grid.m_dy;
    EXPECT_NEAR(h_y(j), ref_y, fp_tolerance(ref_y));
  }

  for (int k = 0; k < nz; ++k) {
    RealType ref_z = k * grid.m_dz;
    EXPECT_NEAR(h_z(k), ref_z, fp_tolerance(ref_z));
  }
}
}  // namespace

TYPED_TEST_SUITE(TestGridInitialization, float_types);

// Test grid initialization for different precision types
TYPED_TEST(TestGridInitialization, GridInitialization) {
  using FloatType = typename TestFixture::float_type;
  test_grid_initialization<FloatType>();
}
