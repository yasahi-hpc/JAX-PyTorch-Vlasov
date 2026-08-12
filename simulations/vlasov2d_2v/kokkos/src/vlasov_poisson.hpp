#ifndef VLASOV_POISSON_HPP_
#define VLASOV_POISSON_HPP_

#include <memory>
#include <random>
#include <filesystem>
#include <Kokkos_Core.hpp>
#include <Kokkos_Complex.hpp>
#include <Kokkos_Random.hpp>
#include <KokkosFFT.hpp>
#include "io_utils.hpp"
#include "math_utils.hpp"

/// Data structures

/// \brief Grid structure for Vlasov-Poisson solver
/// \tparam RealType Floating point type (float or double)
template <typename ExecutionSpace, typename RealType, typename LayoutType>
struct Grid {
  using View1D = Kokkos::View<RealType*, ExecutionSpace>;
  using View2D = Kokkos::View<RealType**, LayoutType, ExecutionSpace>;

  ///@{
  //! Number of grid points in x and y
  int m_nx, m_ny;
  ///@}

  ///@{
  //! Number of grid points in vx and vy
  int m_nvx, m_nvy;
  ///@}

  ///@{
  //! Domain length in x and y
  RealType m_lx, m_ly;
  ///@}

  ///@{
  //! Domain length in vx and vy
  RealType m_Vx_max, m_Vy_max;
  ///@}

  ///@{
  //! Grid spacing in x and y
  RealType m_dx, m_dy;
  ///@}

  ///@{
  //! Grid spacing in vx and vy
  RealType m_dvx, m_dvy;
  ///@}

  //! Grid in x direction. Shape (Nx,)
  View1D m_x;

  //! Grid in y direction. Shape (Ny,)
  View1D m_y;

  //! Grid in vx direction. Shape (Nvx,)
  View1D m_vx;

  //! Grid in vy direction. Shape (Nvy,)
  View1D m_vy;

  //! Wavenumbers in x. Shape (Nx,)
  View1D m_kx;

  //! Wavenumbers in y. Shape (Ny,)
  View1D m_ky;

  //! 1/k^2 for Poisson solver
  View2D m_inv_ksq;

  /// \brief Constructor of a Grid class
  /// \param[in] nx Number of grid points in x
  /// \param[in] ny Number of grid points in y
  /// \param[in] nvx Number of grid points in vx
  /// \param[in] nvy Number of grid points in vy
  /// \param[in] lx Domain length in x
  /// \param[in] ly Domain length in y
  /// \param[in] Vx_max Maximum velocity in vx
  /// \param[in] Vy_max Maximum velocity in vy
  Grid(int nx, int ny, int nvx, int nvy, RealType lx, RealType ly,
       RealType Vx_max, RealType Vy_max)
      : m_nx(nx),
        m_ny(ny),
        m_nvx(nvx),
        m_nvy(nvy),
        m_lx(lx),
        m_ly(ly),
        m_Vx_max(Vx_max),
        m_Vy_max(Vy_max) {
    m_dx  = lx / nx;
    m_dy  = ly / ny;
    m_dvx = 2.0 * Vx_max / (nvx - 1);
    m_dvy = 2.0 * Vy_max / (nvy - 1);

    ExecutionSpace exec;
    m_x  = Math::linspace(exec, RealType(0), lx, nx, /*endpoint=*/false);
    m_y  = Math::linspace(exec, RealType(0), ly, ny, /*endpoint=*/false);
    m_vx = Math::linspace(exec, -Vx_max, Vx_max, nvx, /*endpoint=*/true);
    m_vy = Math::linspace(exec, -Vy_max, Vy_max, nvy, /*endpoint=*/true);

    m_inv_ksq = View2D("inv_ksq", nx, ny / 2 + 1);
    m_kx      = KokkosFFT::fftfreq(exec, nx, m_dx);
    m_ky      = KokkosFFT::rfftfreq(exec, ny, m_dy);
    auto h_kx = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, m_kx);
    auto h_ky = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, m_ky);
    auto h_inv_ksq = Kokkos::create_mirror_view(m_inv_ksq);
    for (std::size_t ikx = 0; ikx < m_inv_ksq.extent(0); ++ikx) {
      h_kx(ikx) *= 2.0 * M_PI;
    }

    for (std::size_t iky = 0; iky < m_inv_ksq.extent(1); ++iky) {
      h_ky(iky) *= 2.0 * M_PI;
    }

    for (std::size_t ikx = 0; ikx < m_inv_ksq.extent(0); ++ikx) {
      for (std::size_t iky = 0; iky < m_inv_ksq.extent(1); ++iky) {
        RealType ksq        = h_kx(ikx) * h_kx(ikx) + h_ky(iky) * h_ky(iky);
        h_inv_ksq(ikx, iky) = (ikx == 0 && iky == 0) ? 0.0 : 1.0 / ksq;
      }
    }
    Kokkos::deep_copy(m_kx, h_kx);
    Kokkos::deep_copy(m_ky, h_ky);
    Kokkos::deep_copy(m_inv_ksq, h_inv_ksq);
  }
};

template <typename ExecutionSpace, typename RealType, typename LayoutType>
struct Field {
  using View2D = Kokkos::View<RealType**, LayoutType, ExecutionSpace>;

  //! Density field
  View2D m_rho;

  //! Electrostatic potential
  View2D m_phi;

  //! Electric field in x direction
  View2D m_Ex;

  //! Electric field in y direction
  View2D m_Ey;

  /// \brief Constructor of Field class
  /// \param[in] nx Number of grid points in x
  /// \param[in] ny Number of grid points in y
  Field(int nx, int ny)
      : m_rho("rho", nx, ny),
        m_phi("phi", nx, ny),
        m_Ex("Ex", nx, ny),
        m_Ey("Ey", nx, ny) {}
};

template <typename ExecutionSpace, typename RealType, typename LayoutType>
struct Variables {
  using View2D = Kokkos::View<RealType**, LayoutType, ExecutionSpace>;
  using View4D = Kokkos::View<RealType****, LayoutType, ExecutionSpace>;

  //! Distribution function f(x,y,vx,vy)
  View4D m_fn, m_fnp1;

  //! Equilibrium distribution function f0(vx,vy)
  View2D m_f0;

  /// \brief Constructor of Variables class
  /// \param[in] nx Number of grid points in x
  /// \param[in] ny Number of grid points in y
  /// \param[in] nvx Number of grid points in vx
  /// \param[in] nvy Number of grid points in vy
  Variables(int nx, int ny, int nvx, int nvy)
      : m_fn("f", nx, ny, nvx, nvy),
        m_fnp1("fnp1", nx, ny, nvx, nvy),
        m_f0("f0", nvx, nvy) {}
};

template <typename ExecutionSpace, typename RealType, typename LayoutType>
struct SimulationState {
  //! Execution space
  ExecutionSpace m_exec_space;

  //! Grid
  Grid<ExecutionSpace, RealType, LayoutType> m_grid;

  //! Field variables
  Field<ExecutionSpace, RealType, LayoutType> m_field;

  //! Distribution function fn and equilibrium f0
  Variables<ExecutionSpace, RealType, LayoutType> m_variables;

  //! Current simulation time
  RealType m_t = 0.0;

  //! Current simulation step
  int m_step = 0;

  /// \brief Constructor of SimulationState class
  /// \param[in] nx Number of grid points in x
  /// \param[in] ny Number of grid points in y
  /// \param[in] nvx Number of grid points in vx
  /// \param[in] nvy Number of grid points in vy
  /// \param[in] lx Domain length in x
  /// \param[in] ly Domain length in y
  /// \param[in] Vx_max Maximum velocity in vx
  /// \param[in] Vy_max Maximum velocity in vy
  SimulationState(int nx, int ny, int nvx, int nvy, RealType lx, RealType ly,
                  RealType Vx_max, RealType Vy_max)
      : m_grid(nx, ny, nvx, nvy, lx, ly, Vx_max, Vy_max),
        m_field(nx, ny),
        m_variables(nx, ny, nvx, nvy) {}
};

/// Numerical kernels (Pure functions)

/// \brief 5th-degree Lagrange interpolation on uniform grid
/// \tparam RealType Floating point type (float or double)
/// \param[in] x Array of 6 grid points
/// \param[in] w Array of 6 function values at the grid points
/// \param[in] x_val The point at which to interpolate
/// \return Interpolated value at x_val
template <typename RealType>
KOKKOS_INLINE_FUNCTION RealType lagrange_interp_5_uniform(const RealType* x,
                                                          const RealType* w,
                                                          RealType x_val) {
  RealType val = 0.0;
  for (int i = 0; i < 6; ++i) {
    RealType basis = 1.0;
    for (int j = 0; j < 6; ++j) {
      if (j != i) {
        basis *= (x_val - x[j]) / (x[i] - x[j]);
      }
    }
    val += w[i] * basis;
  }
  return val;
}

/// \brief 5th-degree Lagrange interpolation on uniform grid
/// \tparam RealType Floating point type (float or double)
/// \param[in] y Array of 6 function values at the grid points
/// \param[in] x The point at which to interpolate
/// \return Interpolated value at x
template <typename RealType>
KOKKOS_INLINE_FUNCTION RealType lagrange_interp_5_uniform(const RealType* y,
                                                          RealType x) {
  // x/20 - x^2/24 - x^3/24 + x^4/24 - x^5/120
  const RealType basis0 =
      x * (RealType(1.0 / 20.0) +
           x * (RealType(-1.0 / 24.0) +
                x * (RealType(-1.0 / 24.0) +
                     x * (RealType(1.0 / 24.0) + x * RealType(-1.0 / 120.0)))));

  // -x/2 + 2 x^2/3 - x^3/24 - x^4/6 + x^5/24
  const RealType basis1 =
      x * (RealType(-1.0 / 2.0) +
           x * (RealType(2.0 / 3.0) +
                x * (RealType(-1.0 / 24.0) +
                     x * (RealType(-1.0 / 6.0) + x * RealType(1.0 / 24.0)))));

  // 1 - x/3 - 5 x^2/4 + 5 x^3/12 + x^4/4 - x^5/12
  const RealType basis2 =
      RealType(1) +
      x * (RealType(-1.0 / 3.0) +
           x * (RealType(-5.0 / 4.0) +
                x * (RealType(5.0 / 12.0) +
                     x * (RealType(1.0 / 4.0) + x * RealType(-1.0 / 12.0)))));

  // x + 2 x^2/3 - 7 x^3/12 - x^4/6 + x^5/12
  const RealType basis3 =
      x * (RealType(1) +
           x * (RealType(2.0 / 3.0) +
                x * (RealType(-7.0 / 12.0) +
                     x * (RealType(-1.0 / 6.0) + x * RealType(1.0 / 12.0)))));

  // -x/4 - x^2/24 + 7 x^3/24 + x^4/24 - x^5/24
  const RealType basis4 =
      x * (RealType(-1.0 / 4.0) +
           x * (RealType(-1.0 / 24.0) +
                x * (RealType(7.0 / 24.0) +
                     x * (RealType(1.0 / 24.0) + x * RealType(-1.0 / 24.0)))));

  // x/30 - x^3/24 + x^5/120 (the even powers vanish)
  const RealType x2 = x * x;
  const RealType basis5 =
      x * (RealType(1.0 / 30.0) +
           x2 * (RealType(-1.0 / 24.0) + x2 * RealType(1.0 / 120.0)));

  return basis0 * y[0] + basis1 * y[1] + basis2 * y[2] + basis3 * y[3] +
         basis4 * y[4] + basis5 * y[5];
}

template <typename View1DType, typename RealType>
KOKKOS_INLINE_FUNCTION RealType advect_1d_periodic(const View1DType& fn,
                                                   RealType departure_point,
                                                   int nx, RealType Lx,
                                                   RealType xmin,
                                                   RealType inv_dx) {
  RealType dp_shifted = departure_point - xmin;
  // Apply periodic boundary conditions
  RealType dp_mod = Kokkos::fmod(dp_shifted, Lx);
  int idx_left    = Kokkos::floor(dp_mod * inv_dx);
  RealType x_val  = (dp_mod * inv_dx) - idx_left;

  int idx_first = idx_left - 2;  // [-2, nx)
  RealType values[6];
  for (int i = 0; i < 6; ++i) {
    idx_first += (idx_first < 0) ? nx : 0;  // wrap around for periodicity
    int idx = idx_first + i;
    idx -= (idx >= nx) ? nx : 0;
    values[i] = fn(idx);
  }

  return lagrange_interp_5_uniform(values, x_val);
}

template <typename View1DType, typename RealType>
KOKKOS_INLINE_FUNCTION RealType advect_1d_dirichlet(const View1DType& fn,
                                                    RealType departure_point,
                                                    int nx, RealType Lx,
                                                    RealType xmin,
                                                    RealType inv_dx) {
  RealType dp_shifted = departure_point - xmin;
  bool is_in_bounds   = (dp_shifted >= 0) && (dp_shifted <= Lx);
  if (!is_in_bounds) {
    return 0;
  } else {
    int idx_left   = Kokkos::floor(dp_shifted * inv_dx);
    RealType x_val = (dp_shifted * inv_dx) - idx_left;

    RealType values[6];
    for (int i = 0; i < 6; ++i) {
      int idx               = idx_left + i - 2;  // -2 offset for 5th-degree
      bool is_idx_in_bounds = (idx >= 0) && (idx < nx);
      values[i]             = is_idx_in_bounds ? fn(idx) : 0;
    }
    return lagrange_interp_5_uniform(values, x_val);
  }
}

template <std::size_t axis, typename View1DType, typename RealType>
KOKKOS_INLINE_FUNCTION RealType advect_1d_impl(const View1DType& fn,
                                               RealType departure_point, int nx,
                                               RealType Lx, RealType xmin,
                                               RealType inv_dx) {
  if constexpr (axis == 0 || axis == 1) {
    return advect_1d_periodic(fn, departure_point, nx, Lx, xmin, inv_dx);
  } else {
    return advect_1d_dirichlet(fn, departure_point, nx, Lx, xmin, inv_dx);
  }
}

template <std::size_t axis>
KOKKOS_INLINE_FUNCTION void map_batches(int n1, int n2, int n3, int j,
                                        int* indices) {
  if constexpr (axis == 0) {
    // i -> x axis, j -> (y,vx,vy)
    indices[1] = j / (n2 * n3);
    indices[2] = (j / n3) % n2;
    indices[3] = j % n3;
  } else if constexpr (axis == 1) {
    // i -> y axis, j -> (x,vx,vy)
    indices[0] = j / (n2 * n3);
    indices[2] = (j / n3) % n2;
    indices[3] = j % n3;
  } else if constexpr (axis == 2) {
    // i -> vx axis, j -> (x,y,vy)
    indices[0] = j / (n2 * n3);
    indices[1] = (j / n3) % n2;
    indices[3] = j % n3;
  } else if constexpr (axis == 3) {
    // i -> vy axis, j -> (x,y,vx)
    indices[0] = j / (n1 * n2);
    indices[1] = (j / n2) % n1;
    indices[2] = j % n2;
  }
}

template <std::size_t axis, typename VelocityView>
KOKKOS_INLINE_FUNCTION auto get_velocity(const VelocityView& velocities,
                                         const int* indices) {
  if constexpr (VelocityView::rank == 1) {
    // rank == 1
    // for axis 0 -> vx (axis 2), axis 1 -> vy (axis 3)
    return velocities(indices[axis + 2]);
  } else {
    // rank == 2
    return velocities(indices[0], indices[1]);
  }
}

/// \brief 1D semi-Lagrangian advection kernel
///
/// \tparam axis 0 for x advection, 1 for y advection, 2 for vx advection, 3 for
/// vy
/// \tparam ExecutionSpace Kokkos execution space
/// \tparam RealType Floating point type (float or double)
/// \tparam LayoutType Kokkos layout type for the distribution function
/// \tparam GridView Kokkos view type for the grid (1D)
/// \tparam VelocityView Kokkos view type for the velocity grid (1D or 2D)
/// \tparam Blocksize Block size for the team policy (only used for x, y, vx
/// directions)
///
/// \param[in] exec Kokkos execution space instance
/// \param[in,out] fn Distribution function to be updated.
/// Shape (Nx, Ny, Nvx, Nvy)
/// \param[in] grid Grid points in the advection direction (x, y, vx, or vy)
/// \param[in] velocities Velocity grid (1D for vx and vy, 2D for x and y)
/// \param[in] dt Time step size
/// \param[in] nx Number of grid points in the advection direction
/// \param[in] Lx Domain length in the advection direction
/// \param[in] xmin Minimum grid point in the advection direction
/// \param[in] inv_dx Inverse of the grid spacing in the advection direction
template <std::size_t axis, typename ExecutionSpace, typename RealType,
          typename LayoutType, typename GridView, typename VelocityView,
          std::size_t Blocksize = 16>
void advect_1d_core(
    const ExecutionSpace& exec,
    const Kokkos::View<RealType****, LayoutType, ExecutionSpace>& fn,
    const GridView& grid, const VelocityView& velocities, RealType dt, int nx,
    RealType Lx, RealType xmin, RealType inv_dx) {
  using member_type = typename Kokkos::TeamPolicy<ExecutionSpace>::member_type;

  int n1 = fn.extent_int(1), n2 = fn.extent_int(2), n3 = fn.extent_int(3);

  std::string label = (axis == 0)   ? "advect_x"
                      : (axis == 1) ? "advect_y"
                      : (axis == 2) ? "advect_vx"
                                    : "advect_vy";

  if constexpr (axis == 3) {
    using ScratchView1DType =
        Kokkos::View<RealType*, typename ExecutionSpace::scratch_memory_space,
                     Kokkos::MemoryTraits<Kokkos::Unmanaged>>;
    int size         = fn.extent(axis);
    int batch        = fn.size() / size;
    int scratch_size = ScratchView1DType::shmem_size(size);
    int level        = 0;

    auto team_policy =
        Kokkos::TeamPolicy(
            exec, batch, Kokkos::AUTO,
            Kokkos::TeamPolicy<ExecutionSpace>::vector_length_max())
            .set_scratch_size(level, Kokkos::PerTeam(scratch_size));

    Kokkos::parallel_for(
        label, team_policy, KOKKOS_LAMBDA(const member_type& team_member) {
          int j = team_member.league_rank();
          int indices[4];
          map_batches<axis>(n1, n2, n3, j, indices);

          ScratchView1DType s_f(team_member.team_scratch(level), size);
          Kokkos::parallel_for(
              Kokkos::TeamVectorRange(team_member, size), [&](const int i) {
                indices[axis] = i;
                s_f(i) = fn(indices[0], indices[1], indices[2], indices[3]);
              });
          team_member.team_barrier();

          Kokkos::parallel_for(
              Kokkos::TeamVectorRange(team_member, size), [&](const int i) {
                indices[axis] = i;
                RealType departure_point =
                    grid(i) - get_velocity<axis>(velocities, indices) * dt;
                RealType result = advect_1d_impl<axis>(s_f, departure_point, nx,
                                                       Lx, xmin, inv_dx);

                fn(indices[0], indices[1], indices[2], indices[3]) = result;
              });
        });
  } else {
    // For x, y, vx advection, we use 2D block (size, Blocksize) to allow
    // contiguous load
    using ScratchView2DType =
        Kokkos::View<RealType**, typename ExecutionSpace::scratch_memory_space,
                     Kokkos::MemoryTraits<Kokkos::Unmanaged>>;
    int n3_batch =
        n3 / Blocksize;  // Number of batches in the innermost dimension
    int size         = fn.extent(axis);
    int batch        = fn.size() / size / Blocksize;
    int scratch_size = ScratchView2DType::shmem_size(size, Blocksize);
    int level        = 0;

    auto team_policy =
        Kokkos::TeamPolicy(exec, batch, Kokkos::AUTO)
            .set_scratch_size(level, Kokkos::PerTeam(scratch_size));

    Kokkos::parallel_for(
        label, team_policy, KOKKOS_LAMBDA(const member_type& team_member) {
          int j = team_member.league_rank();
          int indices[4];
          map_batches<axis>(n1, n2, n3_batch, j, indices);

          ScratchView2DType s_f(team_member.team_scratch(level), size,
                                Blocksize);
          Kokkos::parallel_for(
              Kokkos::TeamVectorMDRange<Kokkos::Rank<2, Kokkos::Iterate::Right>,
                                        member_type>(team_member, size,
                                                     Blocksize),
              [&](const int i0, const int i1) {
                indices[axis] = i0;
                s_f(i0, i1)   = fn(indices[0], indices[1], indices[2],
                                   i1 + indices[3] * Blocksize);
              });
          team_member.team_barrier();

          Kokkos::parallel_for(
              Kokkos::TeamVectorMDRange<Kokkos::Rank<2, Kokkos::Iterate::Right>,
                                        member_type>(team_member, size,
                                                     Blocksize),
              [&](const int i0, const int i1) {
                indices[axis] = i0;
                RealType departure_point =
                    grid(i0) - get_velocity<axis>(velocities, indices) * dt;

                auto sub_f      = Kokkos::subview(s_f, Kokkos::ALL(), i1);
                RealType result = advect_1d_impl<axis>(sub_f, departure_point,
                                                       nx, Lx, xmin, inv_dx);

                fn(indices[0], indices[1], indices[2],
                   i1 + indices[3] * Blocksize) = result;
              });
        });
  }
}

template <std::size_t axis, typename ViewType>
KOKKOS_INLINE_FUNCTION auto slice_f(const ViewType& f, const int* indices) {
  if constexpr (axis == 0) {
    return Kokkos::subview(f, Kokkos::ALL(), indices[1], indices[2],
                           indices[3]);
  } else if constexpr (axis == 1) {
    return Kokkos::subview(f, indices[0], Kokkos::ALL(), indices[2],
                           indices[3]);
  } else if constexpr (axis == 2) {
    return Kokkos::subview(f, indices[0], indices[1], Kokkos::ALL(),
                           indices[3]);
  } else if constexpr (axis == 3) {
    return Kokkos::subview(f, indices[0], indices[1], indices[2],
                           Kokkos::ALL());
  }
}

/// \brief 1D semi-Lagrangian advection kernel with MDRange
///
/// \tparam axis 0 for x advection, 1 for y advection, 2 for vx advection, 3 for
/// vy
/// \tparam ExecutionSpace Kokkos execution space
/// \tparam RealType Floating point type (float or double)
/// \tparam LayoutType Kokkos layout type for the distribution function
/// \tparam GridView Kokkos view type for the grid (1D)
/// \tparam VelocityView Kokkos view type for the velocity grid (1D or 2D)
///
/// \param[in] exec Kokkos execution space instance
/// \param[in,out] fn Distribution function to be updated.
/// Shape (Nx, Ny, Nvx, Nvy)
/// \param[in,out] fnp1 Distribution function to be updated.
/// Shape (Nx, Ny, Nvx, Nvy)
/// \param[in] grid Grid points in the advection direction (x, y, vx, or vy)
/// \param[in] velocities Velocity grid (1D for vx and vy, 2D for x and y)
/// \param[in] dt Time step size
/// \param[in] nx Number of grid points in the advection direction
/// \param[in] Lx Domain length in the advection direction
/// \param[in] xmin Minimum grid point in the advection direction
/// \param[in] inv_dx Inverse of the grid spacing in the advection direction
template <std::size_t axis, typename ExecutionSpace, typename RealType,
          typename LayoutType, typename GridView, typename VelocityView>
void advect_1d_core(
    const ExecutionSpace& exec,
    const Kokkos::View<RealType****, LayoutType, ExecutionSpace>& fn,
    const Kokkos::View<RealType****, LayoutType, ExecutionSpace>& fnp1,
    const GridView& grid, const VelocityView& velocities, RealType dt, int nx,
    RealType Lx, RealType xmin, RealType inv_dx) {
  std::string label = (axis == 0)   ? "advect_x"
                      : (axis == 1) ? "advect_y"
                      : (axis == 2) ? "advect_vx"
                                    : "advect_vy";

  using MDRange4DType = Kokkos::MDRangePolicy<
      ExecutionSpace,
      Kokkos::Rank<4, Kokkos::Iterate::Right, Kokkos::Iterate::Right>,
      Kokkos::IndexType<int>>;

  MDRange4DType mdrange_policy(
      exec, {0, 0, 0, 0},
      {fn.extent(0), fn.extent(1), fn.extent(2), fn.extent(3)});
  Kokkos::parallel_for(
      label, mdrange_policy,
      KOKKOS_LAMBDA(const int ix, const int iy, const int ivx, const int ivy) {
        const int indices[4] = {ix, iy, ivx, ivy};
        auto sub_f           = slice_f<axis>(fn, indices);
        RealType departure_point =
            grid(indices[axis]) - get_velocity<axis>(velocities, indices) * dt;
        fnp1(ix, iy, ivx, ivy) =
            advect_1d_impl<axis>(sub_f, departure_point, nx, Lx, xmin, inv_dx);
      });
}

template <typename ExecutionSpace, typename RealType, typename LayoutType>
struct Efield {
 private:
  using View2D = Kokkos::View<RealType**, LayoutType, ExecutionSpace>;
  using ComplexView2D =
      Kokkos::View<Kokkos::complex<RealType>**, LayoutType, ExecutionSpace>;
  using ForwardPlanType =
      KokkosFFT::Plan<ExecutionSpace, View2D, ComplexView2D, 2>;
  using BackwardPlanType =
      KokkosFFT::Plan<ExecutionSpace, ComplexView2D, View2D, 2>;

  ExecutionSpace m_exec_space;
  View2D m_delta_rho;
  ComplexView2D m_rho_k, m_phi_k, m_Ex_k, m_Ey_k;

  //! The Forward FFT plan
  ForwardPlanType m_forward_plan;

  //! The Backward FFT plan
  BackwardPlanType m_backward_plan;

 public:
  explicit Efield(const ExecutionSpace& exec, int nx, int ny)
      : m_exec_space(exec),
        m_delta_rho("delta_rho", nx, ny),
        m_rho_k("rho_k", nx, ny / 2 + 1),
        m_phi_k("phi_k", nx, ny / 2 + 1),
        m_Ex_k("Ex_k", nx, ny / 2 + 1),
        m_Ey_k("Ey_k", nx, ny / 2 + 1),
        m_forward_plan(m_exec_space, m_delta_rho, m_rho_k,
                       KokkosFFT::Direction::forward,
                       KokkosFFT::axis_type<2>({-2, -1})),
        m_backward_plan(m_exec_space, m_rho_k, m_delta_rho,
                        KokkosFFT::Direction::backward,
                        KokkosFFT::axis_type<2>({-2, -1})) {}

  ~Efield()                        = default;
  Efield()                         = delete;
  Efield(const Efield&)            = delete;
  Efield& operator=(const Efield&) = delete;
  Efield(Efield&&)                 = delete;
  Efield& operator=(Efield&&)      = delete;

  template <typename View4D>
  void compute_rho(const View4D& fn, const View2D& rho, RealType dvx,
                   RealType dvy) const {
    int nx = fn.extent_int(0), ny = fn.extent_int(1), nvx = fn.extent_int(2),
        nvy          = fn.extent_int(3);
    auto team_policy = Kokkos::TeamPolicy<ExecutionSpace>(
        m_exec_space, nx * ny, Kokkos::AUTO,
        Kokkos::TeamPolicy<ExecutionSpace>::vector_length_max());
    using member_type =
        typename Kokkos::TeamPolicy<ExecutionSpace>::member_type;

    Kokkos::parallel_for(
        "compute_rho", team_policy,
        KOKKOS_LAMBDA(const member_type& team_member) {
          int ixy = team_member.league_rank();
          int ix = ixy / ny, iy = ixy % ny;
          RealType sum = 0.0;
          Kokkos::parallel_reduce(
              Kokkos::TeamVectorMDRange<Kokkos::Rank<2, Kokkos::Iterate::Right>,
                                        member_type>(team_member, nvx, nvy),
              [&](const int ivx, const int ivy, RealType& lsum) {
                lsum += fn(ix, iy, ivx, ivy);
              },
              sum);
          rho(ix, iy) = sum * dvx * dvy;
        });
  }

  template <typename View1D>
  void compute_poisson(const View2D& rho, const View2D& Ex, const View2D& Ey,
                       const View2D& phi, const View1D& kx, const View1D& ky,
                       const View2D& inv_ksq) const {
    auto delta_rho = m_delta_rho;
    int nx = rho.extent_int(0), ny = rho.extent_int(1);
    using iterate_type =
        Kokkos::Rank<2, Kokkos::Iterate::Right, Kokkos::Iterate::Right>;
    using mdrange_policy_type =
        Kokkos::MDRangePolicy<ExecutionSpace, iterate_type,
                              Kokkos::IndexType<int>>;
    Kokkos::Array<int, 2> begins{0, 0}, ends{nx, ny};
    mdrange_policy_type mdrange_policy(m_exec_space, begins, ends);
    Kokkos::parallel_for(
        "delta_rho", mdrange_policy, KOKKOS_LAMBDA(const int ix, const int iy) {
          delta_rho(ix, iy) = rho(ix, iy) - 1.0;
        });

    // Forward FFT of rho
    KokkosFFT::execute(m_forward_plan, delta_rho, m_rho_k,
                       KokkosFFT::Normalization::none);

    // Solve Poisson equation in Fourier space
    RealType normcoeff = 1.0 / static_cast<RealType>(nx * ny);
    const Kokkos::complex<RealType> z(0.0, 1.0);
    auto rho_k = m_rho_k;
    auto phi_k = m_phi_k;
    auto Ex_k  = m_Ex_k;
    auto Ey_k  = m_Ey_k;

    int nyh = ny / 2 + 1;
    Kokkos::Array<int, 2> begins_k{0, 0}, ends_k{nx, nyh};
    mdrange_policy_type mdrange_policy_k(m_exec_space, begins_k, ends_k);

    Kokkos::parallel_for(
        "solve_poisson", mdrange_policy_k,
        KOKKOS_LAMBDA(const int ikx, const int iky) {
          phi_k(ikx, iky) = rho_k(ikx, iky) * inv_ksq(ikx, iky) * normcoeff;
          Ex_k(ikx, iky)  = -z * kx(ikx) * phi_k(ikx, iky);
          Ey_k(ikx, iky)  = -z * ky(iky) * phi_k(ikx, iky);
        });
    // Backward FFT of phi_k and E_k
    KokkosFFT::execute(m_backward_plan, phi_k, phi,
                       KokkosFFT::Normalization::none);
    KokkosFFT::execute(m_backward_plan, Ex_k, Ex,
                       KokkosFFT::Normalization::none);
    KokkosFFT::execute(m_backward_plan, Ey_k, Ey,
                       KokkosFFT::Normalization::none);
  }
};

template <typename SimulationStateType, typename EfieldType, typename RealType>
void vlasov_step(SimulationStateType& state, const EfieldType& efield,
                 const RealType dt, bool physics_mode, int solver_type) {
  auto& grid  = state.m_grid;
  auto& field = state.m_field;
  auto& vars  = state.m_variables;
  auto& exec  = state.m_exec_space;

  if (solver_type == 0) {
    // Team impl
    // Advect in x, y (dt/2)
    advect_1d_core<0>(exec, vars.m_fn, grid.m_x, grid.m_vx, dt / RealType(2),
                      grid.m_nx, grid.m_lx, RealType(0.0),
                      RealType(1.0) / grid.m_dx);

    advect_1d_core<1>(exec, vars.m_fn, grid.m_y, grid.m_vy, dt / RealType(2),
                      grid.m_ny, grid.m_ly, RealType(0.0),
                      RealType(1.0) / grid.m_dy);

    if (physics_mode) {
      // Compute density
      efield.compute_rho(vars.m_fn, field.m_rho, grid.m_dvx, grid.m_dvy);

      // Compute electric field
      efield.compute_poisson(field.m_rho, field.m_Ex, field.m_Ey, field.m_phi,
                             grid.m_kx, grid.m_ky, grid.m_inv_ksq);
    }

    // Advect in vx using Ex (dt)
    advect_1d_core<2>(exec, vars.m_fn, grid.m_vx, field.m_Ex, dt, grid.m_nvx,
                      RealType(2.0) * grid.m_Vx_max, -grid.m_Vx_max,
                      RealType(1.0) / grid.m_dvx);

    // Advect in vy using Ey (dt)
    advect_1d_core<3>(exec, vars.m_fn, grid.m_vy, field.m_Ey, dt, grid.m_nvy,
                      RealType(2.0) * grid.m_Vy_max, -grid.m_Vy_max,
                      RealType(1.0) / grid.m_dvy);

    // Advect in x, y (dt/2)
    advect_1d_core<1>(exec, vars.m_fn, grid.m_y, grid.m_vy, dt / RealType(2),
                      grid.m_ny, grid.m_ly, RealType(0.0),
                      RealType(1.0) / grid.m_dy);

    advect_1d_core<0>(exec, vars.m_fn, grid.m_x, grid.m_vx, dt / RealType(2),
                      grid.m_nx, grid.m_lx, RealType(0.0),
                      RealType(1.0) / grid.m_dx);
  } else {
    // MDRange impl
    // Advect in x, y (dt/2)
    advect_1d_core<0>(exec, vars.m_fn, vars.m_fnp1, grid.m_x, grid.m_vx,
                      dt / RealType(2), grid.m_nx, grid.m_lx, RealType(0.0),
                      RealType(1.0) / grid.m_dx);

    advect_1d_core<1>(exec, vars.m_fnp1, vars.m_fn, grid.m_y, grid.m_vy,
                      dt / RealType(2), grid.m_ny, grid.m_ly, RealType(0.0),
                      RealType(1.0) / grid.m_dy);

    if (physics_mode) {
      // Compute density
      efield.compute_rho(vars.m_fn, field.m_rho, grid.m_dvx, grid.m_dvy);

      // Compute electric field
      efield.compute_poisson(field.m_rho, field.m_Ex, field.m_Ey, field.m_phi,
                             grid.m_kx, grid.m_ky, grid.m_inv_ksq);
    }

    // Advect in vx using Ex (dt)
    advect_1d_core<2>(exec, vars.m_fn, vars.m_fnp1, grid.m_vx, field.m_Ex, dt,
                      grid.m_nvx, RealType(2.0) * grid.m_Vx_max, -grid.m_Vx_max,
                      RealType(1.0) / grid.m_dvx);

    // Advect in vy using Ey (dt)
    advect_1d_core<3>(exec, vars.m_fnp1, vars.m_fn, grid.m_vy, field.m_Ey, dt,
                      grid.m_nvy, RealType(2.0) * grid.m_Vy_max, -grid.m_Vy_max,
                      RealType(1.0) / grid.m_dvy);

    // Advect in x, y (dt/2)
    advect_1d_core<1>(exec, vars.m_fn, vars.m_fnp1, grid.m_y, grid.m_vy,
                      dt / RealType(2), grid.m_ny, grid.m_ly, RealType(0.0),
                      RealType(1.0) / grid.m_dy);

    advect_1d_core<0>(exec, vars.m_fnp1, vars.m_fn, grid.m_x, grid.m_vx,
                      dt / RealType(2), grid.m_nx, grid.m_lx, RealType(0.0),
                      RealType(1.0) / grid.m_dx);
  }

  // Update time
  state.m_t += dt;
  state.m_step += 1;
}

template <typename ExecutionSpace, typename RealType>
class VlasovPoisson {
 private:
  using LayoutType = Kokkos::LayoutRight;
  using SimulationStateType =
      SimulationState<ExecutionSpace, RealType, LayoutType>;

  SimulationStateType m_state;
  Efield<ExecutionSpace, RealType, LayoutType> m_efield;
  int m_nbiter;
  int m_diag_steps = 10;
  RealType m_dt;
  std::string m_out_dir;
  bool m_physics_mode;
  RealType m_epsilon;
  int m_solver_type;
  bool m_skip_diag = false;

 public:
  VlasovPoisson(int nx, int ny, int nvx, int nvy, RealType lx, RealType ly,
                RealType Vx_max, RealType Vy_max, int nbiter, int diag_steps,
                RealType dt, const std::string& out_dir, bool physics_mode,
                RealType epsilon, int solver_type)
      : m_state(nx, ny, nvx, nvy, lx, ly, Vx_max, Vy_max),
        m_efield(m_state.m_exec_space, nx, ny),
        m_nbiter(nbiter),
        m_diag_steps(diag_steps),
        m_dt(dt),
        m_out_dir(out_dir),
        m_physics_mode(physics_mode),
        m_epsilon(epsilon),
        m_solver_type(solver_type),
        m_skip_diag(m_diag_steps > m_nbiter) {
    namespace fs = std::filesystem;
    if (!(fs::exists(m_out_dir) && fs::is_directory(m_out_dir))) {
      IO::mkdir(m_out_dir, fs::perms::owner_all | fs::perms::group_read |
                               fs::perms::group_exec | fs::perms::others_read |
                               fs::perms::others_exec);
    }
  }

  void initialize() {
    auto& grid            = m_state.m_grid;
    auto& vars            = m_state.m_variables;
    auto& execution_space = m_state.m_exec_space;

    if (m_physics_mode) {
      // Landau damping settings
      auto epsilon = m_epsilon;
      Kokkos::parallel_for(
          "init_fn",
          Kokkos::MDRangePolicy<ExecutionSpace, Kokkos::Rank<4>>(
              execution_space, {0, 0, 0, 0},
              {grid.m_nx, grid.m_ny, grid.m_nvx, grid.m_nvy}),
          KOKKOS_LAMBDA(const int ix, const int iy, const int ivx,
                        const int ivy) {
            // Equilibrium Maxwellian
            vars.m_f0(ivx, ivy) =
                (1.0 / std::sqrt(2.0 * M_PI)) *
                Kokkos::exp(-0.5 * grid.m_vx(ivx) * grid.m_vx(ivx));
            // Perturbed distribution function
            RealType x = grid.m_x(ix), y = grid.m_y(iy);
            auto kx = 2.0 * M_PI / grid.m_lx;
            auto ky = 2.0 * M_PI / grid.m_ly;
            RealType perturbation =
                1.0 + epsilon * Kokkos::cos(kx * x) * Kokkos::cos(ky * y);
            vars.m_fn(ix, iy, ivx, ivy) = vars.m_f0(ivx, ivy) * perturbation;
          });
    } else {
      // Gaussian pulse settings
      auto x0 = 0.5 * grid.m_lx, y0 = 0.5 * grid.m_ly;
      auto vx0 = 0.0, vy0 = 0.0;
      auto sigma_x = grid.m_lx / 10.0, sigma_v = grid.m_Vx_max / 4.0;
      Kokkos::parallel_for(
          "init_fn",
          Kokkos::MDRangePolicy<ExecutionSpace, Kokkos::Rank<4>>(
              execution_space, {0, 0, 0, 0},
              {grid.m_nx, grid.m_ny, grid.m_nvx, grid.m_nvy}),
          KOKKOS_LAMBDA(const int ix, const int iy, const int ivx,
                        const int ivy) {
            // Perturbed distribution function
            RealType x = grid.m_x(ix), y = grid.m_y(iy), vx = grid.m_vx(ivx),
                     vy = grid.m_vy(ivy);
            vars.m_fn(ix, iy, ivx, ivy) =
                Kokkos::exp(-0.5 * (Kokkos::pow((x - x0) / sigma_x, 2) +
                                    Kokkos::pow((y - y0) / sigma_x, 2) +
                                    Kokkos::pow((vx - vx0) / sigma_v, 2)) +
                            Kokkos::pow((vy - vy0) / sigma_v, 2));
          });
    }

    // Compute initial density
    auto& field = m_state.m_field;
    m_efield.compute_rho(vars.m_fn, field.m_rho, grid.m_dvx, grid.m_dvy);

    // Compute electric field
    m_efield.compute_poisson(field.m_rho, field.m_Ex, field.m_Ey, field.m_phi,
                             grid.m_kx, grid.m_ky, grid.m_inv_ksq);

    execution_space.fence();
    diag(m_state);
  }

  /// \brief Runs the Vlasov-Poisson simulation
  void run() {
    for (int iter = 0; iter < m_nbiter; ++iter) {
      // Run the simulation on device
      vlasov_step(m_state, m_efield, m_dt, m_physics_mode, m_solver_type);
      if (!m_skip_diag && iter % m_diag_steps == 0) {
        diag(m_state);
      }
    }
  }

  /// \brief Diagnostic function to save simulation state
  /// \param[in] state The current simulation state.
  void diag(const SimulationStateType& state) {
    to_binary_file("fn", state.m_variables.m_fn, state.m_step);
    to_binary_file("f0", state.m_variables.m_f0, state.m_step);
    to_binary_file("rho", state.m_field.m_rho, state.m_step);
    to_binary_file("phi", state.m_field.m_phi, state.m_step);
  }

  /// \brief Saves a View to a binary file
  /// \tparam ViewType The type of the field to be saved.
  /// \param[in] label The label of the field.
  /// \param[in] value The field to be saved.
  /// \param[in] step The current iteration number.
  template <typename ViewType>
  void to_binary_file(const std::string& label, const ViewType& value,
                      int step) {
    using value_type = typename ViewType::non_const_value_type;
    using elem_type =
        KokkosFFT::Impl::add_pointer_n_t<value_type, ViewType::rank()>;
    Kokkos::View<elem_type, Kokkos::LayoutRight, ExecutionSpace> out(
        label, value.layout());
    Kokkos::deep_copy(out, value);

    // Save file: fn_000010.dat
    std::string filename =
        m_out_dir + "/" + label + "_" + IO::zfill(step, 6) + ".bin";
    auto h_out = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, out);
    IO::to_binary(filename, h_out);
  }

  void report(double seconds) const {
    std::string dtype_name = "unknown";
    std::string fp_tag     = "unknown";
    if constexpr (std::is_same_v<RealType, double>) {
      dtype_name = "double";
      fp_tag     = "fp64";
    } else if constexpr (std::is_same_v<RealType, float>) {
      dtype_name = "float";
      fp_tag     = "fp32";
    }

    std::ostringstream report_stream;
    ExecutionSpace().print_configuration(report_stream);

    std::string solver_name =
        (m_solver_type == 0) ? "TeamPolicy" : "MDRangePolicy";

    report_stream << "Vlasov-Poisson Simulation Report:" << std::endl;
    report_stream << "  Solver Type: " << solver_name << std::endl;
    report_stream << "  Data Type: " << dtype_name << std::endl;
    report_stream << "  Grid: " << m_state.m_grid.m_nx << " x "
                  << m_state.m_grid.m_ny << " x " << m_state.m_grid.m_nvx
                  << " x " << m_state.m_grid.m_nvy << std::endl;
    report_stream << "  Domain: [0, " << m_state.m_grid.m_lx << "] x [0, "
                  << m_state.m_grid.m_ly << "] x [-" << m_state.m_grid.m_Vx_max
                  << ", " << m_state.m_grid.m_Vx_max << "] x [-"
                  << m_state.m_grid.m_Vy_max << ", " << m_state.m_grid.m_Vy_max
                  << "]" << std::endl;
    report_stream << "  Time step: " << m_dt << std::endl;
    report_stream << "  Total iterations: " << m_nbiter << std::endl;
    report_stream << "  Diagnostics every: " << m_diag_steps << " iterations"
                  << std::endl;
    report_stream << "  Output directory: " << m_out_dir << std::endl;
    report_stream << "  Physics mode: "
                  << (m_physics_mode ? "Landau damping" : "Gaussian pulse")
                  << std::endl;
    if (m_physics_mode) {
      report_stream << "  Perturbation amplitude (epsilon): " << m_epsilon
                    << std::endl;
    }

    report_stream << "  Elapsed time: " << seconds << " [s]" << std::endl;

    const std::string filename = std::string("vlp2d_2v_") + fp_tag + ".txt";
    std::ofstream out_file(filename, std::ios::out | std::ios::trunc);
    if (out_file.is_open()) {
      out_file << report_stream.str();
    }
  }
};

#endif  // VLASOV_POISSON_HPP_
