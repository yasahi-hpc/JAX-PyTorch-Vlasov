#ifndef VLASOV_POISSON_HPP_
#define VLASOV_POISSON_HPP_

#include <memory>
#include <random>
#include <filesystem>
#include <fstream>
#include <sstream>
#include <Kokkos_Core.hpp>
#include <Kokkos_Complex.hpp>
#include <Kokkos_Random.hpp>
#include <KokkosFFT.hpp>
#include "io_utils.hpp"
#include "math_utils.hpp"

/// Data structures

/// \brief Grid structure for Vlasov-Poisson solver
/// \tparam RealType Floating point type (float or double)
template <typename ExecutionSpace, typename RealType>
struct Grid {
  using View1D = Kokkos::View<RealType*, ExecutionSpace>;

  //! Number of grid points in x
  int m_nx;

  //! Number of grid points in v
  int m_nv;

  //! Domain length in x
  RealType m_lx;

  //! Maximum velocity in v
  RealType m_vmax;

  //! Grid spacing in x
  RealType m_dx;

  //! Grid spacing in v
  RealType m_dv;

  //! Grid in x direction
  View1D m_x;

  //! Grid in v direction
  View1D m_v;

  //! 1/kx for Poisson solver
  View1D m_inv_kx;

  /// \brief Constructor of a Grid class
  /// \param[in] nx Number of grid points in x
  /// \param[in] nv Number of grid points in v
  /// \param[in] lx Domain length in x
  /// \param[in] vmax Maximum velocity in v
  Grid(int nx, int nv, RealType lx, RealType vmax)
      : m_nx(nx), m_nv(nv), m_lx(lx), m_vmax(vmax) {
    m_dx = lx / nx;
    m_dv = 2.0 * vmax / (nv - 1);

    ExecutionSpace exec;
    m_x = Math::linspace(exec, RealType(0), lx, nx, /*endpoint=*/false);
    m_v = Math::linspace(exec, -vmax, vmax, nv, /*endpoint=*/true);

    using host_execution_space = Kokkos::DefaultHostExecutionSpace;
    host_execution_space host_exec;
    auto kx       = KokkosFFT::rfftfreq(host_exec, nx, m_dx);
    m_inv_kx      = View1D("inv_kx", nx / 2 + 1);
    auto h_inv_kx = Kokkos::create_mirror_view(m_inv_kx);
    for (std::size_t i = 0; i < m_inv_kx.extent(0); ++i) {
      h_inv_kx(i) = (i == 0) ? 0.0 : 1.0 / (2.0 * M_PI * kx(i));
    }
    Kokkos::deep_copy(m_inv_kx, h_inv_kx);
  }
};

template <typename ExecutionSpace, typename RealType, typename LayoutType>
struct Field {
  using View1D = Kokkos::View<RealType*, LayoutType, ExecutionSpace>;

  //! Density field in real space
  View1D m_rho;

  //! Electrostatic potential in real space
  View1D m_phi;

  //! Electric field in real space
  View1D m_E;

  /// \brief Constructor of Field class
  /// \param[in] nx Number of grid points in x
  Field(int nx) : m_rho("rho", nx), m_phi("phi", nx), m_E("E", nx) {}
};

template <typename ExecutionSpace, typename RealType, typename LayoutType>
struct Variables {
  using View1D = Kokkos::View<RealType*, LayoutType, ExecutionSpace>;
  using View2D = Kokkos::View<RealType**, LayoutType, ExecutionSpace>;

  //! Distribution function f(x,v)
  View2D m_fn, m_fnp1;

  //! Equilibrium distribution function f0(v)
  View1D m_f0;

  /// \brief Constructor of Variables class
  /// \param[in] nx Number of grid points in x
  /// \param[in] nv Number of grid points in v
  Variables(int nx, int nv)
      : m_fn("f", nx, nv), m_fnp1("fnp1", nx, nv), m_f0("f0", nv) {}
};

template <typename ExecutionSpace, typename RealType, typename LayoutType>
struct SimulationState {
  //! Execution space
  ExecutionSpace m_exec_space;

  //! Grid
  Grid<ExecutionSpace, RealType> m_grid;

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
  /// \param[in] nv Number of grid points in v
  /// \param[in] lx Domain length in x
  /// \param[in] vmax Maximum velocity in v
  SimulationState(int nx, int nv, RealType lx, RealType vmax)
      : m_grid(nx, nv, lx, vmax), m_field(nx), m_variables(nx, nv) {}
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
  if constexpr (axis == 0) {
    return advect_1d_periodic(fn, departure_point, nx, Lx, xmin, inv_dx);
  } else {
    return advect_1d_dirichlet(fn, departure_point, nx, Lx, xmin, inv_dx);
  }
}

template <std::size_t axis, typename ExecutionSpace, typename RealType,
          typename LayoutType, typename GridView, typename VelocityView>
void advect_1d_core(
    const ExecutionSpace& exec,
    const Kokkos::View<RealType**, LayoutType, ExecutionSpace>& fn,
    const GridView& grid, const VelocityView& velocities, RealType dt, int nx,
    RealType Lx, RealType xmin, RealType inv_dx) {
  using ScratchView1DType =
      Kokkos::View<RealType*, typename ExecutionSpace::scratch_memory_space,
                   Kokkos::MemoryTraits<Kokkos::Unmanaged>>;
  using member_type = typename Kokkos::TeamPolicy<ExecutionSpace>::member_type;

  int size         = (axis == 0) ? fn.extent(0) : fn.extent(1);
  int batch        = (axis == 0) ? fn.extent(1) : fn.extent(0);
  int scratch_size = ScratchView1DType::shmem_size(size);
  int level        = 0;
  auto team_policy =
      Kokkos::TeamPolicy(
          exec, batch, Kokkos::AUTO,
          Kokkos::TeamPolicy<ExecutionSpace>::vector_length_max())
          .set_scratch_size(level, Kokkos::PerTeam(scratch_size));

  std::string label = (axis == 0) ? "advect_x" : "advect_v";
  Kokkos::parallel_for(
      label, team_policy, KOKKOS_LAMBDA(const member_type& team_member) {
        int j = team_member.league_rank();
        ScratchView1DType s_f(team_member.team_scratch(level), size);
        Kokkos::parallel_for(
            Kokkos::TeamVectorRange(team_member, size),
            [&](const int i) { s_f(i) = axis == 0 ? fn(i, j) : fn(j, i); });
        team_member.team_barrier();

        Kokkos::parallel_for(
            Kokkos::TeamVectorRange(team_member, size), [&](const int i) {
              RealType departure_point = grid(i) - velocities(j) * dt;
              RealType result = advect_1d_impl<axis>(s_f, departure_point, nx,
                                                     Lx, xmin, inv_dx);

              int ix     = axis == 0 ? i : j;
              int iv     = axis == 0 ? j : i;
              fn(ix, iv) = result;
            });
      });
}

template <std::size_t axis, typename ViewType>
KOKKOS_INLINE_FUNCTION auto slice_f(const ViewType& f, const int idx) {
  if constexpr (axis == 0) {
    return Kokkos::subview(f, Kokkos::ALL(), idx);
  } else {
    return Kokkos::subview(f, idx, Kokkos::ALL());
  }
}

template <std::size_t axis, typename ExecutionSpace, typename RealType,
          typename LayoutType, typename GridView, typename VelocityView>
void advect_1d_core(
    const ExecutionSpace& exec,
    const Kokkos::View<RealType**, LayoutType, ExecutionSpace>& fn,
    const Kokkos::View<RealType**, LayoutType, ExecutionSpace>& fnp1,
    const GridView& grid, const VelocityView& velocities, RealType dt, int nx,
    RealType Lx, RealType xmin, RealType inv_dx) {
  using MDRange2DType = Kokkos::MDRangePolicy<
      ExecutionSpace,
      Kokkos::Rank<2, Kokkos::Iterate::Right, Kokkos::Iterate::Right>,
      Kokkos::IndexType<int>>;
  MDRange2DType mdrange_policy(exec, {0, 0}, {fn.extent(0), fn.extent(1)});

  std::string label = (axis == 0) ? "advect_x" : "advect_v";
  Kokkos::parallel_for(
      label, mdrange_policy, KOKKOS_LAMBDA(const int ix, const int iv) {
        const int idx_batch  = axis == 0 ? iv : ix;
        const int idx_interp = axis == 0 ? ix : iv;

        auto sub_f = slice_f<axis>(fn, idx_batch);
        RealType departure_point =
            grid(idx_interp) - velocities(idx_batch) * dt;
        fnp1(ix, iv) =
            advect_1d_impl<axis>(sub_f, departure_point, nx, Lx, xmin, inv_dx);
      });
}

template <typename ExecutionSpace, typename RealType, typename LayoutType>
struct Efield {
 private:
  using View1D = Kokkos::View<RealType*, LayoutType, ExecutionSpace>;
  using ComplexView1D =
      Kokkos::View<Kokkos::complex<RealType>*, LayoutType, ExecutionSpace>;
  using ForwardPlanType =
      KokkosFFT::Plan<ExecutionSpace, View1D, ComplexView1D, 1>;
  using BackwardPlanType =
      KokkosFFT::Plan<ExecutionSpace, ComplexView1D, View1D, 1>;

  ExecutionSpace m_exec_space;
  View1D m_delta_rho;
  ComplexView1D m_rho_k, m_phi_k, m_E_k;

  //! The Forward FFT plan
  ForwardPlanType m_forward_plan;

  //! The Backward FFT plan
  BackwardPlanType m_backward_plan;

 public:
  explicit Efield(const ExecutionSpace& exec, int nx)
      : m_exec_space(exec),
        m_delta_rho("delta_rho", nx),
        m_rho_k("rho_k", nx / 2 + 1),
        m_phi_k("phi_k", nx / 2 + 1),
        m_E_k("E_k", nx / 2 + 1),
        m_forward_plan(m_exec_space, m_delta_rho, m_rho_k,
                       KokkosFFT::Direction::forward, -1),
        m_backward_plan(m_exec_space, m_rho_k, m_delta_rho,
                        KokkosFFT::Direction::backward, -1) {}

  ~Efield()                        = default;
  Efield()                         = delete;
  Efield(const Efield&)            = delete;
  Efield& operator=(const Efield&) = delete;
  Efield(Efield&&)                 = delete;
  Efield& operator=(Efield&&)      = delete;

  template <typename View2D>
  void compute_rho(const View2D& fn, const View1D& rho, RealType dv) const {
    auto team_policy = Kokkos::TeamPolicy<ExecutionSpace>(
        m_exec_space, fn.extent(0), Kokkos::AUTO,
        Kokkos::TeamPolicy<ExecutionSpace>::vector_length_max());
    using member_type =
        typename Kokkos::TeamPolicy<ExecutionSpace>::member_type;

    Kokkos::parallel_for(
        "compute_rho", team_policy,
        KOKKOS_LAMBDA(const member_type& team_member) {
          int ix       = team_member.league_rank();
          RealType sum = 0.0;
          Kokkos::parallel_reduce(
              Kokkos::TeamVectorRange(team_member, fn.extent(1)),
              [&](const int iv, RealType& lsum) { lsum += fn(ix, iv); }, sum);
          rho(ix) = sum * dv;
        });
  }

  void compute_poisson(const View1D& rho, const View1D& E, const View1D& phi,
                       const View1D& inv_kx) const {
    auto delta_rho = m_delta_rho;
    Kokkos::parallel_for(
        "delta_rho",
        Kokkos::RangePolicy<ExecutionSpace>(m_exec_space, 0, rho.extent(0)),
        KOKKOS_LAMBDA(const int ix) { delta_rho(ix) = rho(ix) - 1.0; });

    // Forward FFT of rho
    KokkosFFT::execute(m_forward_plan, delta_rho, m_rho_k,
                       KokkosFFT::Normalization::none);

    // Solve Poisson equation in Fourier space
    RealType normcoeff = 1.0 / static_cast<RealType>(rho.extent(0));
    const Kokkos::complex<RealType> z(0.0, 1.0);
    auto rho_k = m_rho_k;
    auto phi_k = m_phi_k;
    auto E_k   = m_E_k;
    Kokkos::parallel_for(
        "solve_poisson",
        Kokkos::RangePolicy<ExecutionSpace>(m_exec_space, 0, rho_k.extent(0)),
        KOKKOS_LAMBDA(const int ik) {
          auto inv_kx_tmp = inv_kx(ik);
          phi_k(ik)       = rho_k(ik) * (inv_kx_tmp * inv_kx_tmp) * normcoeff;
          E_k(ik)         = -z * rho_k(ik) * inv_kx_tmp * normcoeff;
        });

    // Backward FFT of phi_k and E_k
    KokkosFFT::execute(m_backward_plan, phi_k, phi,
                       KokkosFFT::Normalization::none);
    KokkosFFT::execute(m_backward_plan, E_k, E, KokkosFFT::Normalization::none);
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
    // Advect in x (dt/2)
    advect_1d_core<0>(exec, vars.m_fn, grid.m_x, grid.m_v, dt / RealType(2),
                      grid.m_nx, grid.m_lx, RealType(0.0),
                      RealType(1.0) / grid.m_dx);

    if (physics_mode) {
      // Compute density
      efield.compute_rho(vars.m_fn, field.m_rho, grid.m_dv);

      // Compute electric field
      efield.compute_poisson(field.m_rho, field.m_E, field.m_phi,
                             grid.m_inv_kx);
    }

    // Advect in v
    advect_1d_core<1>(exec, vars.m_fn, grid.m_v, field.m_E, dt, grid.m_nv,
                      RealType(2.0) * grid.m_vmax, -grid.m_vmax,
                      RealType(1.0) / grid.m_dv);

    // Advect in x (dt/2)
    advect_1d_core<0>(exec, vars.m_fn, grid.m_x, grid.m_v, dt / RealType(2),
                      grid.m_nx, grid.m_lx, RealType(0.0),
                      RealType(1.0) / grid.m_dx);
    exec.fence();
  } else {
    // MDRange impl
    // Advect in x (dt/2)
    advect_1d_core<0>(exec, vars.m_fn, vars.m_fnp1, grid.m_x, grid.m_v,
                      dt / RealType(2), grid.m_nx, grid.m_lx, RealType(0.0),
                      RealType(1.0) / grid.m_dx);

    if (physics_mode) {
      // Compute density
      efield.compute_rho(vars.m_fnp1, field.m_rho, grid.m_dv);

      // Compute electric field
      efield.compute_poisson(field.m_rho, field.m_E, field.m_phi,
                             grid.m_inv_kx);
    }

    // Advect in v
    advect_1d_core<1>(exec, vars.m_fnp1, vars.m_fn, grid.m_v, field.m_E, dt,
                      grid.m_nv, RealType(2.0) * grid.m_vmax, -grid.m_vmax,
                      RealType(1.0) / grid.m_dv);

    // Advect in x (dt/2)
    advect_1d_core<0>(exec, vars.m_fn, vars.m_fnp1, grid.m_x, grid.m_v,
                      dt / RealType(2), grid.m_nx, grid.m_lx, RealType(0.0),
                      RealType(1.0) / grid.m_dx);
    exec.fence();
    Kokkos::kokkos_swap(vars.m_fn, vars.m_fnp1);
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
  VlasovPoisson(int nx, int nv, RealType lx, RealType vmax, int nbiter,
                int diag_steps, RealType dt, const std::string& out_dir,
                bool physics_mode, RealType epsilon, int solver_type)
      : m_state(nx, nv, lx, vmax),
        m_efield(m_state.m_exec_space, nx),
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
          Kokkos::MDRangePolicy<ExecutionSpace, Kokkos::Rank<2>>(
              execution_space, {0, 0}, {grid.m_nx, grid.m_nv}),
          KOKKOS_LAMBDA(const int ix, const int iv) {
            // Equilibrium Maxwellian
            vars.m_f0(iv) = (1.0 / std::sqrt(2.0 * M_PI)) *
                            Kokkos::exp(-0.5 * grid.m_v(iv) * grid.m_v(iv));

            // Perturbed distribution function
            RealType x            = grid.m_x(ix);
            auto kx               = 2.0 * M_PI / grid.m_lx;
            RealType perturbation = 1.0 + epsilon * Kokkos::cos(kx * x);
            vars.m_fn(ix, iv)     = vars.m_f0(iv) * perturbation;
          });
    } else {
      // Gaussian pulse settings
      auto x0 = 0.5 * grid.m_lx, v0 = 0.0;
      auto sigma_x = grid.m_lx / 10.0, sigma_v = grid.m_vmax / 4.0;
      Kokkos::parallel_for(
          "init_fn",
          Kokkos::MDRangePolicy<ExecutionSpace, Kokkos::Rank<2>>(
              execution_space, {0, 0}, {grid.m_nx, grid.m_nv}),
          KOKKOS_LAMBDA(const int ix, const int iv) {
            // Perturbed distribution function
            RealType x        = grid.m_x(ix);
            vars.m_fn(ix, iv) = Kokkos::exp(
                -0.5 * (Kokkos::pow((x - x0) / sigma_x, 2) +
                        Kokkos::pow((grid.m_v(iv) - v0) / sigma_v, 2)));
          });
    }

    // Compute initial density
    auto& field = m_state.m_field;
    m_efield.compute_rho(vars.m_fn, field.m_rho, grid.m_dv);

    // Compute electric field
    m_efield.compute_poisson(field.m_rho, field.m_E, field.m_phi,
                             grid.m_inv_kx);

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
                  << m_state.m_grid.m_nv << std::endl;
    report_stream << "  Domain: [0, " << m_state.m_grid.m_lx << "] x [-"
                  << m_state.m_grid.m_vmax << ", " << m_state.m_grid.m_vmax
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

    const std::string filename = std::string("vlp1d_1v_") + fp_tag + ".txt";
    std::ofstream out_file(filename, std::ios::out | std::ios::trunc);
    if (out_file.is_open()) {
      out_file << report_stream.str();
    }
  }
};

#endif  // VLASOV_POISSON_HPP_
