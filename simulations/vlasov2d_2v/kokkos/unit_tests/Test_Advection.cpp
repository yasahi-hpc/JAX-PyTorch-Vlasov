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
struct TestAdvection2D2V : public ::testing::Test {
  using float_type  = typename T::first_type;
  using layout_type = typename T::second_type;
};

/// \brief Test advection with periodic boundary conditions
/// \tparam axis
/// \tparam T
/// \tparam LayoutType
/// \param[in] solver_type 0 TeamPolicy, 1 MDRangePolicy
template <std::size_t axis, typename T, typename LayoutType>
void test_advection_1d_periodic(int solver_type) {
  using RealView4DType = Kokkos::View<T****, LayoutType, execution_space>;
  using GridType       = Grid<execution_space, T, LayoutType>;

  int nx = 128, ny = 128, nvx = 32, nvy = 32;
  T lx = 2.0 * M_PI, ly = 4.0 * M_PI;
  T Vx_max = 5.0, Vy_max = 7.0;

  GridType grid(nx, ny, nvx, nvy, lx, ly, Vx_max, Vy_max);
  RealView4DType fn("f", nx, ny, nvx, nvy), ref_fn("ref_fn", nx, ny, nvx, nvy);
  [[maybe_unused]] RealView4DType fnp1("fnp1", nx, ny, nvx, nvy);

  // Initialize f(x,y,vx,vy) = exp(-0.5 * ( (x - x0)^2/sigma_x^2 ))
  T x0 = lx / 2.0, sigma_x = lx / 10.0;
  auto h_fn = Kokkos::create_mirror_view(fn);

  if constexpr (axis == 0) {
    auto h_x =
        Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_x);
    for (int ix = 0; ix < nx; ++ix) {
      T x = h_x(ix);
      for (int iy = 0; iy < ny; ++iy) {
        for (int ivx = 0; ivx < nvx; ++ivx) {
          for (int ivy = 0; ivy < nvy; ++ivy) {
            h_fn(ix, iy, ivx, ivy) =
                std::exp(-0.5 * std::pow((x - x0) / sigma_x, 2));
          }
        }
      }
    }
  } else if constexpr (axis == 1) {
    auto h_y =
        Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_y);
    for (int ix = 0; ix < nx; ++ix) {
      for (int iy = 0; iy < ny; ++iy) {
        T y = h_y(iy);
        for (int ivx = 0; ivx < nvx; ++ivx) {
          for (int ivy = 0; ivy < nvy; ++ivy) {
            h_fn(ix, iy, ivx, ivy) =
                std::exp(-0.5 * std::pow((y - x0) / sigma_x, 2));
          }
        }
      }
    }
  }
  Kokkos::deep_copy(fn, h_fn);

  // set advection velocity constant
  T v_drift = 1.0;
  if constexpr (axis == 0) {
    Kokkos::deep_copy(grid.m_vx, v_drift);
  } else if constexpr (axis == 1) {
    Kokkos::deep_copy(grid.m_vy, v_drift);
  }

  // Advect for dt
  T dt = 0.1;

  // Advect in x
  execution_space exec;
  if (solver_type == 0) {
    // TeamPolicy implementation
    if constexpr (axis == 0) {
      advect_1d_core<0>(exec, fn, grid.m_x, grid.m_vx, dt, grid.m_nx, grid.m_lx,
                        T(0.0), T(1.0) / grid.m_dx);
    } else if constexpr (axis == 1) {
      advect_1d_core<1>(exec, fn, grid.m_y, grid.m_vy, dt, grid.m_ny, grid.m_ly,
                        T(0.0), T(1.0) / grid.m_dy);
    }
    exec.fence();
  } else {
    // MDRangePolicy implementation
    if constexpr (axis == 0) {
      advect_1d_core<0>(exec, fn, fnp1, grid.m_x, grid.m_vx, dt, grid.m_nx,
                        grid.m_lx, T(0.0), T(1.0) / grid.m_dx);
    } else if constexpr (axis == 1) {
      advect_1d_core<1>(exec, fn, fnp1, grid.m_y, grid.m_vy, dt, grid.m_ny,
                        grid.m_ly, T(0.0), T(1.0) / grid.m_dy);
    }
    exec.fence();
    Kokkos::kokkos_swap(fn, fnp1);
  }

  // Analytical solution after advection
  T x_shifted   = v_drift * dt + x0;
  auto h_ref_fn = Kokkos::create_mirror_view(ref_fn);

  if constexpr (axis == 0) {
    auto h_x =
        Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_x);
    for (int ix = 0; ix < nx; ++ix) {
      for (int iy = 0; iy < ny; ++iy) {
        T x = h_x(ix);
        for (int ivx = 0; ivx < nvx; ++ivx) {
          for (int ivy = 0; ivy < nvy; ++ivy) {
            // periodic wrap-around
            T x_new = x - x_shifted;
            x_new -= lx * std::round(x_new / lx);
            h_ref_fn(ix, iy, ivx, ivy) =
                std::exp(-0.5 * std::pow((x_new) / sigma_x, 2));
          }
        }
      }
    }
  } else if constexpr (axis == 1) {
    auto h_y =
        Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_y);
    for (int ix = 0; ix < nx; ++ix) {
      for (int iy = 0; iy < ny; ++iy) {
        T y = h_y(iy);
        for (int ivx = 0; ivx < nvx; ++ivx) {
          for (int ivy = 0; ivy < nvy; ++ivy) {
            // periodic wrap-around
            T y_new = y - x_shifted;
            y_new -= ly * std::round(y_new / ly);
            h_ref_fn(ix, iy, ivx, ivy) =
                std::exp(-0.5 * std::pow((y_new) / sigma_x, 2));
          }
        }
      }
    }
  }

  // Compare numerical and analytical solutions
  T epsilon = std::is_same_v<T, float> ? T(1e-2) : T(1e-4);
  Kokkos::deep_copy(h_fn, fn);
  for (int ix = 0; ix < nx; ++ix) {
    for (int iy = 0; iy < ny; ++iy) {
      for (int ivx = 0; ivx < nvx; ++ivx) {
        for (int ivy = 0; ivy < nvy; ++ivy) {
          EXPECT_NEAR(h_fn(ix, iy, ivx, ivy), h_ref_fn(ix, iy, ivx, ivy),
                      epsilon);
        }
      }
    }
  }
}

/// \brief Test advection with Dirichlet boundary conditions
/// \tparam axis
/// \tparam T
/// \tparam LayoutType
/// \param[in] solver_type 0 TeamPolicy, 1 MDRangePolicy
template <std::size_t axis, typename T, typename LayoutType>
void test_advection_1d_dirichlet(int solver_type) {
  using RealView2DType = Kokkos::View<T**, LayoutType, execution_space>;
  using RealView4DType = Kokkos::View<T****, LayoutType, execution_space>;
  using GridType       = Grid<execution_space, T, LayoutType>;

  int nx = 32, ny = 32, nvx = 32, nvy = 32;
  T lx = 2.0 * M_PI, ly = 4.0 * M_PI;
  T Vx_max = 5.0, Vy_max = 7.0;

  GridType grid(nx, ny, nvx, nvy, lx, ly, Vx_max, Vy_max);
  RealView4DType fn("f", nx, ny, nvx, nvy), ref_fn("ref_fn", nx, ny, nvx, nvy);
  [[maybe_unused]] RealView4DType fnp1("fnp1", nx, ny, nvx, nvy);

  // Initialize f(x,y,vx,vy) = exp(-0.5 * ( (v - v0)^2/sigma_v^2 ))
  T v0 = 0.0, sigma_v = Vx_max / 4.0;
  auto h_fn = Kokkos::create_mirror_view(fn);

  if constexpr (axis == 2) {
    auto h_vx =
        Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_vx);
    for (int ix = 0; ix < nx; ++ix) {
      for (int iy = 0; iy < ny; ++iy) {
        for (int ivx = 0; ivx < nvx; ++ivx) {
          T v = h_vx(ivx);
          for (int ivy = 0; ivy < nvy; ++ivy) {
            h_fn(ix, iy, ivx, ivy) =
                std::exp(-0.5 * std::pow((v - v0) / sigma_v, 2));
          }
        }
      }
    }
  } else if constexpr (axis == 3) {
    auto h_vy =
        Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_vy);
    for (int ix = 0; ix < nx; ++ix) {
      for (int iy = 0; iy < ny; ++iy) {
        for (int ivx = 0; ivx < nvx; ++ivx) {
          for (int ivy = 0; ivy < nvy; ++ivy) {
            T v = h_vy(ivy);
            h_fn(ix, iy, ivx, ivy) =
                std::exp(-0.5 * std::pow((v - v0) / sigma_v, 2));
          }
        }
      }
    }
  }
  Kokkos::deep_copy(fn, h_fn);

  // set advection velocity constant
  T a_drift = 1.0;
  RealView2DType E("E", nx, ny);
  Kokkos::deep_copy(E, a_drift);

  // Advect for dt
  T dt = 0.1;

  // Advect in v
  execution_space exec;
  if (solver_type == 0) {
    if constexpr (axis == 2) {
      advect_1d_core<2>(exec, fn, grid.m_vx, E, dt, grid.m_nvx,
                        T(2.0) * grid.m_Vx_max, -grid.m_Vx_max,
                        T(1.0) / grid.m_dvx);
    } else if constexpr (axis == 3) {
      advect_1d_core<3>(exec, fn, grid.m_vy, E, dt, grid.m_nvy,
                        T(2.0) * grid.m_Vy_max, -grid.m_Vy_max,
                        T(1.0) / grid.m_dvy);
    }
    exec.fence();
  } else {
    if constexpr (axis == 2) {
      advect_1d_core<2>(exec, fn, fnp1, grid.m_vx, E, dt, grid.m_nvx,
                        T(2.0) * grid.m_Vx_max, -grid.m_Vx_max,
                        T(1.0) / grid.m_dvx);
    } else if constexpr (axis == 3) {
      advect_1d_core<3>(exec, fn, fnp1, grid.m_vy, E, dt, grid.m_nvy,
                        T(2.0) * grid.m_Vy_max, -grid.m_Vy_max,
                        T(1.0) / grid.m_dvy);
    }
    exec.fence();
    Kokkos::kokkos_swap(fn, fnp1);
  }

  // Analytical solution after advection
  T v_shift     = a_drift * dt;
  auto h_ref_fn = Kokkos::create_mirror_view(ref_fn);
  if constexpr (axis == 2) {
    auto h_v =
        Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_vx);
    for (int ix = 0; ix < nx; ++ix) {
      for (int iy = 0; iy < ny; ++iy) {
        for (int ivx = 0; ivx < nvx; ++ivx) {
          for (int ivy = 0; ivy < nvy; ++ivy) {
            // dirichlet boundary conditions
            T v               = h_v(ivx);
            T v_new           = v - v_shift;
            bool is_in_bounds = (v_new >= -Vx_max) && (v_new <= Vx_max);
            h_ref_fn(ix, iy, ivx, ivy) =
                is_in_bounds
                    ? std::exp(-0.5 * std::pow((v_new - v0) / sigma_v, 2))
                    : T(0);
          }
        }
      }
    }
  } else if constexpr (axis == 3) {
    auto h_v =
        Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, grid.m_vy);
    for (int ix = 0; ix < nx; ++ix) {
      for (int iy = 0; iy < ny; ++iy) {
        for (int ivx = 0; ivx < nvx; ++ivx) {
          for (int ivy = 0; ivy < nvy; ++ivy) {
            // dirichlet boundary conditions
            T v               = h_v(ivy);
            T v_new           = v - v_shift;
            bool is_in_bounds = (v_new >= -Vy_max) && (v_new <= Vy_max);
            h_ref_fn(ix, iy, ivx, ivy) =
                is_in_bounds
                    ? std::exp(-0.5 * std::pow((v_new - v0) / sigma_v, 2))
                    : T(0);
          }
        }
      }
    }
  }

  // Compare numerical and analytical solutions
  T epsilon = std::is_same_v<T, float> ? T(1e-2) : T(1e-4);
  Kokkos::deep_copy(h_fn, fn);
  for (int ix = 0; ix < nx; ++ix) {
    for (int iy = 0; iy < ny; ++iy) {
      for (int ivx = 0; ivx < nvx; ++ivx) {
        for (int ivy = 0; ivy < nvy; ++ivy) {
          EXPECT_NEAR(h_fn(ix, iy, ivx, ivy), h_ref_fn(ix, iy, ivx, ivy),
                      epsilon);
        }
      }
    }
  }
}

}  // namespace

TYPED_TEST_SUITE(TestAdvection2D2V, test_types);

// Test advection with periodic boundary conditions for different precision
// types
TYPED_TEST(TestAdvection2D2V, x_periodic_team) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_advection_1d_periodic<0, FloatType, LayoutType>(0);
}

TYPED_TEST(TestAdvection2D2V, x_periodic_mdrange) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_advection_1d_periodic<0, FloatType, LayoutType>(1);
}

// Test advection with periodic boundary conditions for different precision
// types
TYPED_TEST(TestAdvection2D2V, y_periodic_team) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_advection_1d_periodic<1, FloatType, LayoutType>(0);
}

TYPED_TEST(TestAdvection2D2V, y_periodic_mdrange) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_advection_1d_periodic<1, FloatType, LayoutType>(1);
}

// Test advection with dirichlet boundary conditions for different precision
// types
TYPED_TEST(TestAdvection2D2V, vx_dirichlet_team) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_advection_1d_dirichlet<2, FloatType, LayoutType>(0);
}

TYPED_TEST(TestAdvection2D2V, vx_dirichlet_mdrange) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_advection_1d_dirichlet<2, FloatType, LayoutType>(1);
}

// Test advection with dirichlet boundary conditions for different precision
// types
TYPED_TEST(TestAdvection2D2V, vy_dirichlet_team) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_advection_1d_dirichlet<3, FloatType, LayoutType>(0);
}

TYPED_TEST(TestAdvection2D2V, vy_dirichlet_mdrange) {
  using FloatType  = typename TestFixture::float_type;
  using LayoutType = typename TestFixture::layout_type;
  test_advection_1d_dirichlet<3, FloatType, LayoutType>(1);
}
