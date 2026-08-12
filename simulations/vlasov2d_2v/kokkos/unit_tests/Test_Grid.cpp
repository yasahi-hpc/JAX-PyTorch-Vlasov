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
struct TestGridInitialization2D2V : public ::testing::Test {
  using float_type  = typename T::first_type;
  using layout_type = typename T::second_type;
};

template <typename RealType, typename LayoutType>
void test_grid_initialization() {
  using GridType = Grid<execution_space, RealType, LayoutType>;

  int nx = 32, ny = 33, nvx = 35, nvy = 38;
  RealType lx = 2.0 * M_PI, ly = 4.0 * M_PI;
  RealType Vx_max = 5.0, Vy_max = 7.0;

  GridType grid(nx, ny, nvx, nvy, lx, ly, Vx_max, Vy_max);

  // Check grid properties
  ASSERT_EQ(grid.m_nx, nx);
  ASSERT_EQ(grid.m_ny, ny);
  ASSERT_EQ(grid.m_nvx, nvx);
  ASSERT_EQ(grid.m_nvy, nvy);

  EXPECT_NEAR(grid.m_lx, lx, fp_tolerance(lx));
  EXPECT_NEAR(grid.m_ly, ly, fp_tolerance(ly));
  EXPECT_NEAR(grid.m_Vx_max, Vx_max, fp_tolerance(Vx_max));
  EXPECT_NEAR(grid.m_Vy_max, Vy_max, fp_tolerance(Vy_max));

  RealType dx = lx / nx, dy = ly / ny;
  RealType dvx = 2.0 * Vx_max / (nvx - 1);
  RealType dvy = 2.0 * Vy_max / (nvy - 1);
  EXPECT_NEAR(grid.m_dx, dx, fp_tolerance(dx));
  EXPECT_NEAR(grid.m_dy, dy, fp_tolerance(dy));
  EXPECT_NEAR(grid.m_dvx, dvx, fp_tolerance(dvx));
  EXPECT_NEAR(grid.m_dvy, dvy, fp_tolerance(dvy));

  // Check grid values
  auto h_x = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_x);
  auto h_y = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_y);
  auto h_vx =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_vx);
  auto h_vy =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_vy);
  auto h_kx =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_kx);
  auto h_ky =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_ky);
  auto h_inv_ksq =
      Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_inv_ksq);

  for (int i = 0; i < nx; ++i) {
    RealType ref_x = i * grid.m_dx;
    EXPECT_NEAR(h_x(i), ref_x, fp_tolerance(ref_x));
  }

  for (int i = 0; i < ny; ++i) {
    RealType ref_y = i * grid.m_dy;
    EXPECT_NEAR(h_y(i), ref_y, fp_tolerance(ref_y));
  }

  for (int i = 0; i < nvx; ++i) {
    RealType ref_v = -Vx_max + i * grid.m_dvx;
    EXPECT_NEAR(h_vx(i), ref_v, fp_tolerance(ref_v));
  }

  for (int j = 0; j < nvy; ++j) {
    RealType ref_v = -Vy_max + j * grid.m_dvy;
    EXPECT_NEAR(h_vy(j), ref_v, fp_tolerance(ref_v));
  }

  for (int i = 0; i < nx; ++i) {
    RealType ref_kx = i < (nx / 2) ? i / lx : (i - nx) / lx;
    ref_kx *= 2.0 * M_PI;
    EXPECT_NEAR(h_kx(i), ref_kx, fp_tolerance(ref_kx));
  }

  for (int i = 0; i < ny / 2 + 1; ++i) {
    RealType ref_ky = 2.0 * M_PI * static_cast<RealType>(i) / ly;
    EXPECT_NEAR(h_ky(i), ref_ky, fp_tolerance(ref_ky));
  }

  for (int ikx = 0; ikx < nx; ++ikx) {
    for (int iky = 0; iky < ny / 2 + 1; ++iky) {
      RealType ksq         = h_kx(ikx) * h_kx(ikx) + h_ky(iky) * h_ky(iky);
      RealType ref_inv_ksq = (ikx == 0 && iky == 0) ? 0.0 : 1.0 / ksq;
      EXPECT_NEAR(h_inv_ksq(ikx, iky), ref_inv_ksq, fp_tolerance(ref_inv_ksq));
    }
  }
}
}  // namespace

TYPED_TEST_SUITE(TestGridInitialization2D2V, test_types);

// Test grid initialization for different precision types
TYPED_TEST(TestGridInitialization2D2V, GridInitialization) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_grid_initialization<FloatType, LayoutType>();
}
