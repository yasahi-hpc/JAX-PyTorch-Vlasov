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
struct TestFieldInitialization2D2V : public ::testing::Test {
  using float_type  = typename T::first_type;
  using layout_type = typename T::second_type;
};

template <typename T>
struct TestVariablesInitialization2D2V : public ::testing::Test {
  using float_type  = typename T::first_type;
  using layout_type = typename T::second_type;
};

template <typename T>
struct TestSimulationStateInitialization2D2V : public ::testing::Test {
  using float_type  = typename T::first_type;
  using layout_type = typename T::second_type;
};

template <typename T, typename LayoutType>
void test_field_initialization() {
  using FieldType = Field<execution_space, T, LayoutType>;
  int nx = 128, ny = 64;

  FieldType field(nx, ny);

  // Check field properties
  ASSERT_EQ(field.m_rho.extent_int(0), nx);
  ASSERT_EQ(field.m_rho.extent_int(1), ny);
  ASSERT_EQ(field.m_phi.extent_int(0), nx);
  ASSERT_EQ(field.m_phi.extent_int(1), ny);
  ASSERT_EQ(field.m_Ex.extent_int(0), nx);
  ASSERT_EQ(field.m_Ex.extent_int(1), ny);
  ASSERT_EQ(field.m_Ey.extent_int(0), nx);
  ASSERT_EQ(field.m_Ey.extent_int(1), ny);
}

template <typename T, typename LayoutType>
void test_variables_initialization() {
  using VariablesType = Variables<execution_space, T, LayoutType>;
  int nx = 32, ny = 33, nvx = 35, nvy = 38;

  VariablesType vars(nx, ny, nvx, nvy);

  // Check variables properties
  ASSERT_EQ(vars.m_fn.extent_int(0), nx);
  ASSERT_EQ(vars.m_fn.extent_int(1), ny);
  ASSERT_EQ(vars.m_fn.extent_int(2), nvx);
  ASSERT_EQ(vars.m_fn.extent_int(3), nvy);
  ASSERT_EQ(vars.m_fnp1.extent_int(0), nx);
  ASSERT_EQ(vars.m_fnp1.extent_int(1), ny);
  ASSERT_EQ(vars.m_fnp1.extent_int(2), nvx);
  ASSERT_EQ(vars.m_fnp1.extent_int(3), nvy);
  ASSERT_EQ(vars.m_f0.extent_int(0), nvx);
  ASSERT_EQ(vars.m_f0.extent_int(1), nvy);
}

template <typename T, typename LayoutType>
void test_simulation_state_initialization() {
  using SimulationStateType = SimulationState<execution_space, T, LayoutType>;
  int nx = 32, ny = 33, nvx = 35, nvy = 38;
  T lx = 2.0 * M_PI, ly = 4.0 * M_PI;
  T Vx_max = 5.0, Vy_max = 7.0;
  SimulationStateType state(nx, ny, nvx, nvy, lx, ly, Vx_max, Vy_max);

  // Check grid properties
  ASSERT_EQ(state.m_grid.m_nx, nx);
  ASSERT_EQ(state.m_grid.m_ny, ny);
  ASSERT_EQ(state.m_grid.m_nvx, nvx);
  ASSERT_EQ(state.m_grid.m_nvy, nvy);
  EXPECT_NEAR(state.m_grid.m_lx, lx, fp_tolerance(lx));
  EXPECT_NEAR(state.m_grid.m_ly, ly, fp_tolerance(ly));
  EXPECT_NEAR(state.m_grid.m_Vx_max, Vx_max, fp_tolerance(Vx_max));
  EXPECT_NEAR(state.m_grid.m_Vy_max, Vy_max, fp_tolerance(Vy_max));

  T dx = lx / nx, dy = ly / ny;
  T dvx = 2.0 * Vx_max / (nvx - 1);
  T dvy = 2.0 * Vy_max / (nvy - 1);
  EXPECT_NEAR(state.m_grid.m_dx, dx, fp_tolerance(dx));
  EXPECT_NEAR(state.m_grid.m_dy, dy, fp_tolerance(dy));
  EXPECT_NEAR(state.m_grid.m_dvx, dvx, fp_tolerance(dvx));
  EXPECT_NEAR(state.m_grid.m_dvy, dvy, fp_tolerance(dvy));

  // Check field properties
  ASSERT_EQ(state.m_field.m_rho.extent_int(0), nx);
  ASSERT_EQ(state.m_field.m_rho.extent_int(1), ny);
  ASSERT_EQ(state.m_field.m_phi.extent_int(0), nx);
  ASSERT_EQ(state.m_field.m_phi.extent_int(1), ny);
  ASSERT_EQ(state.m_field.m_Ex.extent_int(0), nx);
  ASSERT_EQ(state.m_field.m_Ex.extent_int(1), ny);
  ASSERT_EQ(state.m_field.m_Ey.extent_int(0), nx);
  ASSERT_EQ(state.m_field.m_Ey.extent_int(1), ny);

  // Check variables properties
  ASSERT_EQ(state.m_variables.m_fn.extent_int(0), nx);
  ASSERT_EQ(state.m_variables.m_fn.extent_int(1), ny);
  ASSERT_EQ(state.m_variables.m_fn.extent_int(2), nvx);
  ASSERT_EQ(state.m_variables.m_fn.extent_int(3), nvy);
  ASSERT_EQ(state.m_variables.m_fnp1.extent_int(0), nx);
  ASSERT_EQ(state.m_variables.m_fnp1.extent_int(1), ny);
  ASSERT_EQ(state.m_variables.m_fnp1.extent_int(2), nvx);
  ASSERT_EQ(state.m_variables.m_fnp1.extent_int(3), nvy);
  ASSERT_EQ(state.m_variables.m_f0.extent_int(0), nvx);
  ASSERT_EQ(state.m_variables.m_f0.extent_int(1), nvy);

  // Check initial time and step
  EXPECT_NEAR(state.m_t, T(0.0), fp_tolerance(T(0.0)));
  ASSERT_EQ(state.m_step, 0);
}
}  // namespace

TYPED_TEST_SUITE(TestFieldInitialization2D2V, test_types);
TYPED_TEST_SUITE(TestVariablesInitialization2D2V, test_types);
TYPED_TEST_SUITE(TestSimulationStateInitialization2D2V, test_types);

// Test fields initialization for different precision types
TYPED_TEST(TestFieldInitialization2D2V, FieldInitialization) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_field_initialization<FloatType, LayoutType>();
}

// Test variables initialization for different precision types
TYPED_TEST(TestVariablesInitialization2D2V, VariablesInitialization) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_variables_initialization<FloatType, LayoutType>();
}

// Test simulation state initialization for different precision types
TYPED_TEST(TestSimulationStateInitialization2D2V,
           SimulationStateInitialization) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_simulation_state_initialization<FloatType, LayoutType>();
}
