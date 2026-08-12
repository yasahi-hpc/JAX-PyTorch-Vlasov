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
struct TestHeat : public ::testing::Test {
  using float_type  = typename T::first_type;
  using layout_type = typename T::second_type;
};

template <typename RealType, typename LayoutType>
void test_heat_construct() {
  const int nx      = 100;
  const RealType lx = 2.0 * M_PI;

  const int nbiter = 10, diag_steps = 5;
  const RealType dt = 0.01, kappa = 1.0;
  const std::string out_dir = "heat3d_output";
  Heat3D<execution_space, RealType> solver(nx, nx, nx, lx, lx, lx, nbiter,
                                           diag_steps, dt, out_dir, kappa);

  // Verify that out_dir exists
  namespace fs            = std::filesystem;
  bool is_out_dir_created = fs::exists(out_dir) && fs::is_directory(out_dir);
  EXPECT_TRUE(is_out_dir_created);
}

template <typename RealType, typename LayoutType>
void test_heat_initialize() {
  using SimulationStateType =
      SimulationState<execution_space, RealType, LayoutType>;
  int nx = 20, ny = 22, nz = 24;
  RealType lx = 2.0 * M_PI;
  SimulationStateType state(nx, ny, nz, lx, lx, lx);

  const RealType kx = 1.0, ky = 1.3, kz = 1.7;

  // Initialize state and values
  // Initialize values with u = cos(kx * x) * cos(ky * y) * cos(kz * z)
  initialize_state(state, kx, ky, kz);

  // Verify that all elements in the view are set to the scalar value
  auto h_u = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{},
                                                 state.m_variables.m_u);
  for (int i = 0; i < nx; ++i) {
    for (int j = 0; j < ny; ++j) {
      for (int k = 0; k < nz; ++k) {
        RealType x = i * state.m_grid.m_dx;
        RealType y = j * state.m_grid.m_dy;
        RealType z = k * state.m_grid.m_dz;
        RealType u_ref =
            Kokkos::cos(kx * x) * Kokkos::cos(ky * y) * Kokkos::cos(kz * z);
        EXPECT_NEAR(h_u(i, j, k), u_ref, fp_tolerance(u_ref));
      }
    }
  }
}

template <typename RealType, typename LayoutType>
void test_heat_step() {
  using SimulationStateType =
      SimulationState<execution_space, RealType, LayoutType>;
  int nx      = 32;
  RealType lx = 2.0 * M_PI;
  SimulationStateType state(nx, nx, nx, lx, lx, lx);

  const RealType dt = 0.001, kappa = 1.0;
  const RealType coeff = kappa * dt / (state.m_grid.m_dx * state.m_grid.m_dx);
  const RealType kx = 1.0, ky = 1.0, kz = 1.0;

  // Initialize state and values
  // Initialize values with u = cos(kx * x) * cos(ky * y) * cos(kz * z)
  initialize_state(state, kx, ky, kz);

  // After the call
  // t and step are incremented
  // u is updated according to the heat equation
  // un is updated with the previous u values
  heat_step(state, dt, coeff);

  // Starting from 0 and 1
  ASSERT_EQ(state.m_t, dt);
  ASSERT_EQ(state.m_step, 1);

  auto h_u  = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{},
                                                  state.m_variables.m_u);
  auto h_un = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{},
                                                  state.m_variables.m_un);
  for (int i = 0; i < nx; ++i) {
    for (int j = 0; j < nx; ++j) {
      for (int k = 0; k < nx; ++k) {
        RealType x = i * state.m_grid.m_dx;
        RealType y = j * state.m_grid.m_dy;
        RealType z = k * state.m_grid.m_dz;
        RealType u_init =
            Kokkos::cos(kx * x) * Kokkos::cos(ky * y) * Kokkos::cos(kz * z);

        // The raw stencil (without dx^2) has eigenvalue per axis: 2*cos(k*dx) -
        // 2
        RealType lam_x      = 2.0 * Kokkos::cos(kx * state.m_grid.m_dx) - 2.0;
        RealType lam_y      = 2.0 * Kokkos::cos(ky * state.m_grid.m_dy) - 2.0;
        RealType lam_z      = 2.0 * Kokkos::cos(kz * state.m_grid.m_dz) - 2.0;
        RealType eigenvalue = lam_x + lam_y + lam_z;

        RealType u_ref = u_init + coeff * eigenvalue * u_init;
        EXPECT_NEAR(h_u(i, j, k), u_ref, fp_tolerance(u_ref));

        // un should be updated with the previous u values
        EXPECT_NEAR(h_un(i, j, k), u_init, fp_tolerance(u_init));
      }
    }
  }
}

template <typename RealType, typename LayoutType>
void test_heat_anayltical() {
  using SimulationStateType =
      SimulationState<execution_space, RealType, LayoutType>;
  int nx = 20, ny = 22, nz = 24;
  RealType lx = 2.0 * M_PI;
  SimulationStateType state(nx, ny, nz, lx, lx, lx);

  const RealType kx = 1.0, ky = 1.3, kz = 1.7;
  const RealType time = 50.0, kappa = 0.3;

  auto &grid = state.m_grid;
  auto &vars = state.m_variables;
  auto &exec = state.m_exec_space;

  analytical_solution(exec, vars.m_u, grid, time, kappa, kx, ky, kz);

  // Verify that all elements in the view are set to the scalar value
  auto h_u = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{},
                                                 state.m_variables.m_u);
  for (int i = 0; i < nx; ++i) {
    for (int j = 0; j < ny; ++j) {
      for (int k = 0; k < nz; ++k) {
        RealType x = i * state.m_grid.m_dx;
        RealType y = j * state.m_grid.m_dy;
        RealType z = k * state.m_grid.m_dz;
        RealType u_init =
            Kokkos::cos(kx * x) * Kokkos::cos(ky * y) * Kokkos::cos(kz * z);
        RealType ksq   = kx * kx + ky * ky + kz * kz;
        RealType u_ref = u_init * Kokkos::exp(-kappa * ksq * time);
        EXPECT_NEAR(h_u(i, j, k), u_ref, fp_tolerance(u_ref));
      }
    }
  }
}

}  // namespace

TYPED_TEST_SUITE(TestHeat, test_types);

// Test Heat solver is properly constructed
TYPED_TEST(TestHeat, Construct) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_heat_construct<FloatType, LayoutType>();
}

// Test initial state is properly initialized
TYPED_TEST(TestHeat, Initialized) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_heat_initialize<FloatType, LayoutType>();
}

// Test state is properly updated
TYPED_TEST(TestHeat, OneTimeStep) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_heat_step<FloatType, LayoutType>();
}

// Test analytical value is properly computed
TYPED_TEST(TestHeat, Anayltical) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_heat_anayltical<FloatType, LayoutType>();
}
