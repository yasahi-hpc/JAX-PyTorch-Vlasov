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
struct TestFieldInitialization : public ::testing::Test {
  using float_type  = typename T::first_type;
  using layout_type = typename T::second_type;
};

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
void test_field_initialization() {
  using FieldType = Field<execution_space, T, LayoutType>;
  int nx          = 128;

  FieldType field(nx);

  // Check field properties
  ASSERT_EQ(field.m_rho.extent_int(0), nx);
  ASSERT_EQ(field.m_phi.extent_int(0), nx);
  ASSERT_EQ(field.m_E.extent_int(0), nx);
}

template <typename T, typename LayoutType>
void test_variables_initialization() {
  using VariablesType = Variables<execution_space, T, LayoutType>;
  int nx              = 128;
  int nv              = 64;

  VariablesType vars(nx, nv);

  // Check variables properties
  ASSERT_EQ(vars.m_fn.extent_int(0), nx);
  ASSERT_EQ(vars.m_fn.extent_int(1), nv);
  ASSERT_EQ(vars.m_fnp1.extent_int(0), nx);
  ASSERT_EQ(vars.m_fnp1.extent_int(1), nv);
  ASSERT_EQ(vars.m_f0.extent_int(0), nv);
}

template <typename T, typename LayoutType>
void test_simulation_state_initialization() {
  using SimulationStateType = SimulationState<execution_space, T, LayoutType>;
  int nx                    = 128;
  int nv                    = 64;
  T lx                      = 2.0 * M_PI;
  T vmax                    = 5.0;
  SimulationStateType state(nx, nv, lx, vmax);

  // Check grid properties
  ASSERT_EQ(state.m_grid.m_nx, nx);
  ASSERT_EQ(state.m_grid.m_nv, nv);

  EXPECT_NEAR(state.m_grid.m_lx, lx, fp_tolerance(lx));
  EXPECT_NEAR(state.m_grid.m_vmax, vmax, fp_tolerance(vmax));

  T dx = lx / nx;
  T dv = 2.0 * vmax / (nv - 1);
  EXPECT_NEAR(state.m_grid.m_dx, dx, fp_tolerance(dx));
  EXPECT_NEAR(state.m_grid.m_dv, dv, fp_tolerance(dv));

  // Check field properties
  ASSERT_EQ(state.m_field.m_rho.extent_int(0), nx);
  ASSERT_EQ(state.m_field.m_phi.extent_int(0), nx);
  ASSERT_EQ(state.m_field.m_E.extent_int(0), nx);

  // Check variables properties
  ASSERT_EQ(state.m_variables.m_fn.extent_int(0), nx);
  ASSERT_EQ(state.m_variables.m_fn.extent_int(1), nv);
  ASSERT_EQ(state.m_variables.m_fnp1.extent_int(0), nx);
  ASSERT_EQ(state.m_variables.m_fnp1.extent_int(1), nv);
  ASSERT_EQ(state.m_variables.m_f0.extent_int(0), nv);

  // Check initial time and step
  EXPECT_NEAR(state.m_t, T(0.0), fp_tolerance(T(0.0)));
  ASSERT_EQ(state.m_step, 0);
}
}  // namespace

TYPED_TEST_SUITE(TestFieldInitialization, test_types);
TYPED_TEST_SUITE(TestVariablesInitialization, test_types);
TYPED_TEST_SUITE(TestSimulationStateInitialization, test_types);

// Test fields initialization for different precision types
TYPED_TEST(TestFieldInitialization, FieldInitialization) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_field_initialization<FloatType, LayoutType>();
}

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
