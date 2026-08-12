#include <limits>
#include <gtest/gtest.h>
#include "heat3d.hpp"
#include "Test_Utils.hpp"

namespace {
using execution_space = Kokkos::DefaultExecutionSpace;
using test_types      = ::testing::Types<std::pair<float, Kokkos::LayoutLeft>,
                                    std::pair<float, Kokkos::LayoutRight>,
                                    std::pair<double, Kokkos::LayoutLeft>,
                                    std::pair<double, Kokkos::LayoutRight> >;

template <typename T>
struct TestVariablesInitialization : public ::testing::Test {
  using float_type  = typename T::first_type;
  using layout_type = typename T::second_type;
};

template <typename T>
struct TestSimulationStateInitialization : public ::testing::Test {
  using float_type  = typename T::first_type;
  using layout_type = typename T::second_type;
};

template <typename T, typename LayoutType>
void test_variables_initialization() {
  using VariablesType = Variables<execution_space, T, LayoutType>;
  int nx = 16, ny = 17, nz = 18;
  VariablesType vars(nx, ny, nz);

  // Check variables properties
  ASSERT_EQ(vars.m_u.extent_int(0), nx);
  ASSERT_EQ(vars.m_u.extent_int(1), ny);
  ASSERT_EQ(vars.m_u.extent_int(2), nz);

  ASSERT_EQ(vars.m_un.extent_int(0), nx);
  ASSERT_EQ(vars.m_un.extent_int(1), ny);
  ASSERT_EQ(vars.m_un.extent_int(2), nz);
}

template <typename T, typename LayoutType>
void test_simulation_state_initialization() {
  using SimulationStateType = SimulationState<execution_space, T, LayoutType>;
  int nx = 20, ny = 22, nz = 24;
  T lx = 2.0 * M_PI;
  SimulationStateType state(nx, ny, nz, lx, lx, lx);

  // Check grid properties
  ASSERT_EQ(state.m_grid.m_nx, nx);
  ASSERT_EQ(state.m_grid.m_ny, ny);
  ASSERT_EQ(state.m_grid.m_nz, nz);

  EXPECT_EQ(state.m_grid.m_lx, lx);
  EXPECT_EQ(state.m_grid.m_ly, lx);
  EXPECT_EQ(state.m_grid.m_lz, lx);

  T dx = lx / nx, dy = lx / ny, dz = lx / nz;
  EXPECT_EQ(state.m_grid.m_dx, dx);
  EXPECT_EQ(state.m_grid.m_dy, dy);
  EXPECT_EQ(state.m_grid.m_dz, dz);

  // Check variables properties
  ASSERT_EQ(state.m_variables.m_u.extent_int(0), nx);
  ASSERT_EQ(state.m_variables.m_u.extent_int(1), ny);
  ASSERT_EQ(state.m_variables.m_u.extent_int(2), nz);
  ASSERT_EQ(state.m_variables.m_un.extent_int(0), nx);
  ASSERT_EQ(state.m_variables.m_un.extent_int(1), ny);
  ASSERT_EQ(state.m_variables.m_un.extent_int(2), nz);

  // Check initial time and step
  EXPECT_EQ(state.m_t, T(0.0));
  ASSERT_EQ(state.m_step, 0);
}
}  // namespace

TYPED_TEST_SUITE(TestVariablesInitialization, test_types);
TYPED_TEST_SUITE(TestSimulationStateInitialization, test_types);

// Test variables initialization for different precision types
TYPED_TEST(TestVariablesInitialization, VariablesInitialization) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_variables_initialization<FloatType, LayoutType>();
}

// Test simulation state initialization for different precision types
TYPED_TEST(TestSimulationStateInitialization, SimulationStateInitialization) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_simulation_state_initialization<FloatType, LayoutType>();
}
