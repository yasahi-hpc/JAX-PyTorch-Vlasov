#ifndef HEAT3D_HPP_
#define HEAT3D_HPP_

#include <iostream>
#include <fstream>
#include <iomanip>
#include <numeric>
#include <sstream>
#include <vector>
#include <filesystem>
#include <Kokkos_Core.hpp>
#include "io_utils.hpp"
#include "math_utils.hpp"

/// Reuse MDRange type
template <typename ExecutionSpace>
using MDRange3DType = Kokkos::MDRangePolicy<
    ExecutionSpace,
    Kokkos::Rank<3, Kokkos::Iterate::Right, Kokkos::Iterate::Right>,
    Kokkos::IndexType<int>>;

/// Data structures

/// \brief Grid structure for Vlasov-Poisson solver
/// \tparam RealType Floating point type (float or double)
template <typename ExecutionSpace, typename RealType>
struct Grid {
  using View1D = Kokkos::View<RealType*, ExecutionSpace>;

  ///@{
  //! Number of grid points in x, y, and z
  int m_nx, m_ny, m_nz;
  ///@}

  ///@{
  //! Domain length in x, y and z
  RealType m_lx, m_ly, m_lz;
  ///@

  ///@{
  //! Grid spacing in x, y and z
  RealType m_dx, m_dy, m_dz;
  ///@}

  //! Grid in x direction. Shape (Nx,)
  View1D m_x;

  //! Grid in y direction. Shape (Ny,)
  View1D m_y;

  //! Grid in z direction. Shape (Nz,)
  View1D m_z;

  /// \brief Constructor of a Grid class
  /// \param[in] nx Number of grid points in x
  /// \param[in] ny Number of grid points in y
  /// \param[in] nz Number of grid points in z
  /// \param[in] lx Domain length in x
  /// \param[in] ly Domain length in y
  /// \param[in] lz Domain length in z
  Grid(int nx, int ny, int nz, RealType lx, RealType ly, RealType lz)
      : m_nx(nx), m_ny(ny), m_nz(nz), m_lx(lx), m_ly(ly), m_lz(lz) {
    m_dx = lx / nx;
    m_dy = ly / ny;
    m_dz = lz / nz;

    ExecutionSpace exec;
    m_x = Math::linspace(exec, RealType(0), lx, nx, /*endpoint=*/false);
    m_y = Math::linspace(exec, RealType(0), ly, ny, /*endpoint=*/false);
    m_z = Math::linspace(exec, RealType(0), lz, nz, /*endpoint=*/false);
  }
};

template <typename ExecutionSpace, typename RealType, typename LayoutType>
struct Variables {
  using View3D = Kokkos::View<RealType***, LayoutType, ExecutionSpace>;

  ///@{
  //! 3D Physical field with shape (Nx, Ny, Nz)
  View3D m_u, m_un;
  ///@}

  /// \brief Constructor of Variables class
  /// \param[in] nx Number of grid points in x
  /// \param[in] ny Number of grid points in y
  /// \param[in] nz Number of grid points in z
  Variables(int nx, int ny, int nz)
      : m_u("u", nx, ny, nz), m_un("un", nx, ny, nz) {}
};

template <typename ExecutionSpace, typename RealType, typename LayoutType>
struct SimulationState {
  using ExecutionSpaceType = ExecutionSpace;

  //! Execution space
  ExecutionSpace m_exec_space;

  //! Grid
  Grid<ExecutionSpace, RealType> m_grid;

  //! Physical field
  Variables<ExecutionSpace, RealType, LayoutType> m_variables;

  //! Current simulation time
  RealType m_t = 0.0;

  //! Current simulation step
  int m_step = 0;

  /// \brief Constructor of SimulationState class
  /// \param[in] nx Number of grid points in x
  /// \param[in] ny Number of grid points in y
  /// \param[in] nz Number of grid points in z
  /// \param[in] lx Domain length in x
  /// \param[in] ly Domain length in y
  /// \param[in] lz Domain length in z
  SimulationState(int nx, int ny, int nz, RealType lx, RealType ly, RealType lz)
      : m_grid(nx, ny, nz, lx, ly, lz), m_variables(nx, ny, nz) {}
};

template <typename SimulationStateType, typename RealType>
void initialize_state(SimulationStateType& state, RealType kx = 1.0,
                      RealType ky = 1.0, RealType kz = 1.0) {
  using ExecutionSpace = typename SimulationStateType::ExecutionSpaceType;
  auto& grid           = state.m_grid;
  auto& vars           = state.m_variables;
  auto& exec           = state.m_exec_space;

  MDRange3DType<ExecutionSpace> policy(exec, {0, 0, 0},
                                       {grid.m_nx, grid.m_ny, grid.m_nz});
  Kokkos::parallel_for(
      "init_u", policy,
      KOKKOS_LAMBDA(const int ix, const int iy, const int iz) {
        RealType x = grid.m_x(ix), y = grid.m_y(iy), z = grid.m_z(iz);
        vars.m_u(ix, iy, iz) =
            Kokkos::cos(kx * x) * Kokkos::cos(ky * y) * Kokkos::cos(kz * z);
      });

  exec.fence();

  // Reset state
  state.m_t    = 0.0;
  state.m_step = 0;
}

template <typename SimulationStateType, typename RealType>
void heat_step(SimulationStateType& state, RealType dt, RealType coeff) {
  using ExecutionSpace = typename SimulationStateType::ExecutionSpaceType;
  auto& grid           = state.m_grid;
  auto& vars           = state.m_variables;
  auto& exec           = state.m_exec_space;

  MDRange3DType<ExecutionSpace> policy(exec, {0, 0, 0},
                                       {grid.m_nx, grid.m_ny, grid.m_nz});
  Kokkos::parallel_for(
      "heat3d", policy,
      KOKKOS_LAMBDA(const int ix, const int iy, const int iz) {
        // Compute indices with periodic boundary conditions
        const int ixm1 = (ix - 1 + grid.m_nx) % grid.m_nx;
        const int ixp1 = (ix + 1) % grid.m_nx;
        const int iym1 = (iy - 1 + grid.m_ny) % grid.m_ny;
        const int iyp1 = (iy + 1) % grid.m_ny;
        const int izm1 = (iz - 1 + grid.m_nz) % grid.m_nz;
        const int izp1 = (iz + 1) % grid.m_nz;

        // Update the solution using the heat equation
        vars.m_un(ix, iy, iz) =
            vars.m_u(ix, iy, iz) +
            coeff * (vars.m_u(ixp1, iy, iz) + vars.m_u(ixm1, iy, iz) +
                     vars.m_u(ix, iyp1, iz) + vars.m_u(ix, iym1, iz) +
                     vars.m_u(ix, iy, izp1) + vars.m_u(ix, iy, izm1) -
                     RealType(6) * vars.m_u(ix, iy, iz));
      });
  exec.fence();

  // Increment time and step
  state.m_t += dt;
  state.m_step += 1;

  // Swap views
  Kokkos::kokkos_swap(vars.m_u, vars.m_un);
}

template <typename ExecutionSpace, typename ViewType, typename GridType,
          typename RealType>
void analytical_solution(const ExecutionSpace& exec, const ViewType& u,
                         const GridType& grid, RealType time, RealType kappa,
                         RealType kx = 1.0, RealType ky = 1.0,
                         RealType kz = 1.0) {
  MDRange3DType<ExecutionSpace> policy(exec, {0, 0, 0},
                                       {grid.m_nx, grid.m_ny, grid.m_nz});
  Kokkos::parallel_for(
      "analytical_u", policy,
      KOKKOS_LAMBDA(const int ix, const int iy, const int iz) {
        RealType x = grid.m_x(ix), y = grid.m_y(iy), z = grid.m_z(iz);
        auto u_init =
            Kokkos::cos(kx * x) * Kokkos::cos(ky * y) * Kokkos::cos(kz * z);
        auto ksq      = kx * kx + ky * ky + kz * kz;
        u(ix, iy, iz) = u_init * Kokkos::exp(-kappa * ksq * time);
      });

  exec.fence();
}

template <typename ExecutionSpace, typename RealType>
class Heat3D {
 private:
  using LayoutType = Kokkos::LayoutRight;
  using SimulationStateType =
      SimulationState<ExecutionSpace, RealType, LayoutType>;

  SimulationStateType m_state;
  int m_nbiter;
  int m_diag_steps = 10;
  RealType m_dt;
  std::string m_out_dir;
  RealType m_k = 1.0;
  RealType m_kappa;

 public:
  Heat3D(int nx, int ny, int nz, RealType lx, RealType ly, RealType lz,
         int nbiter, int diag_steps, RealType dt, const std::string& out_dir,
         RealType kappa)
      : m_state(nx, ny, nz, lx, ly, lz),
        m_nbiter(nbiter),
        m_diag_steps(diag_steps),
        m_dt(dt),
        m_out_dir(out_dir),
        m_kappa(kappa) {
    namespace fs = std::filesystem;

    if (!(fs::exists(m_out_dir) && fs::is_directory(m_out_dir))) {
      IO::mkdir(m_out_dir, fs::perms::owner_all | fs::perms::group_read |
                               fs::perms::group_exec | fs::perms::others_read |
                               fs::perms::others_exec);
    }
  }

  void initialize() { initialize_state(m_state, m_k, m_k, m_k); }

  /// \brief Runs the Heat3D simulation for m_nbiter iterations
  void run() {
    auto coeff = m_kappa * m_dt / (m_state.m_grid.m_dx * m_state.m_grid.m_dx);
    for (int iter = 0; iter < m_nbiter; ++iter) {
      // Run the simulation on device
      heat_step(m_state, m_dt, coeff);
      if (iter % m_diag_steps == 0) {
        // diag(m_state);
      }
    }
  }

  auto sanity_check() -> std::pair<RealType, RealType> {
    initialize();
    run();

    // Analytical solution at final time
    auto& grid = m_state.m_grid;
    auto& vars = m_state.m_variables;
    auto& exec = m_state.m_exec_space;

    auto time  = m_state.m_t;
    auto kappa = m_kappa;

    auto kx = m_k, ky = m_k, kz = m_k;
    MDRange3DType<ExecutionSpace> policy(exec, {0, 0, 0},
                                         {grid.m_nx, grid.m_ny, grid.m_nz});
    Kokkos::parallel_for(
        "analytical_u", policy,
        KOKKOS_LAMBDA(const int ix, const int iy, const int iz) {
          RealType x = grid.m_x(ix), y = grid.m_y(iy), z = grid.m_z(iz);
          auto u_init =
              Kokkos::cos(kx * x) * Kokkos::cos(ky * y) * Kokkos::cos(kz * z);
          auto ksq              = kx * kx + ky * ky + kz * kz;
          vars.m_un(ix, iy, iz) = u_init * Kokkos::exp(-kappa * ksq * time);
        });

    exec.fence();

    // L2 norm and Linf norm
    RealType err_sq = 0, ref_sq = 0, err_linf = 0;
    Kokkos::parallel_reduce(
        "l2_linf_norm", policy,
        KOKKOS_LAMBDA(const int ix, const int iy, const int iz,
                      RealType& lerr_sq, RealType& lref_sq,
                      RealType& lerr_linf) {
          auto diff = vars.m_un(ix, iy, iz) - vars.m_u(ix, iy, iz);
          lerr_sq += diff * diff;
          lref_sq += vars.m_un(ix, iy, iz) * vars.m_un(ix, iy, iz);
          lerr_linf = Kokkos::max(lerr_linf, Kokkos::abs(diff));
        },
        err_sq, ref_sq, Kokkos::Max<RealType>(err_linf));
    RealType err_l2 = Kokkos::sqrt(err_sq) / Kokkos::sqrt(ref_sq);

    return std::make_pair(err_l2, err_linf);
  }

  void report(const std::vector<double>& timings) {
    // Find minimum time; ignore the first result
    auto min = std::min_element(timings.begin() + 1, timings.end());

    // Calculate average; ignore the first result
    double avg = std::accumulate(timings.begin() + 1, timings.end(), 0.0) /
                 (double)(timings.size() - 1);

    auto [err_l2, err_linf] = sanity_check();
    std::string dtype_name  = "unknown";
    std::string fp_tag      = "unknown";
    if constexpr (std::is_same_v<RealType, double>) {
      dtype_name = "double";
      fp_tag     = "fp64";
    } else if constexpr (std::is_same_v<RealType, float>) {
      dtype_name = "float";
      fp_tag     = "fp32";
    }

    // Estimate memory bandwidth
    // 7-point stencil: read 6 neighbors + center = 1 reads, 1 write => 8 *
    // sizeof(dtype) bytes/point We do this once per step; total bytes = n^3 * 2
    // * itemsize * nbiter
    std::size_t points =
        m_state.m_grid.m_nx * m_state.m_grid.m_ny * m_state.m_grid.m_nz;
    std::size_t bytes_per_point =
        2 * sizeof(RealType);  // 1 read + 1 write per point
    double total_bytes = points * bytes_per_point * m_nbiter;
    auto gbps_best     = (total_bytes / (*min)) / 1.0e9;
    auto gbps_avg      = (total_bytes / avg) / 1.0e9;

    std::ostringstream report_stream;
    ExecutionSpace().print_configuration(report_stream);
    report_stream << "Grid: " << m_state.m_grid.m_nx << " x "
                  << m_state.m_grid.m_ny << " x " << m_state.m_grid.m_nz
                  << " (N=" << points << "), dtype=" << dtype_name << std::endl;
    report_stream << "Times (s): best=" << std::scientific
                  << std::setprecision(6) << *min << ", avg=" << std::scientific
                  << std::setprecision(6) << avg << " over " << timings.size()
                  << " runs" << std::endl;
    report_stream << "Estimated bandwidth (GB/s): best=" << std::fixed
                  << std::setprecision(4) << gbps_best << ", avg=" << std::fixed
                  << std::setprecision(4) << gbps_avg << std::endl;
    report_stream << "Errors vs analytical PDE at t=" << m_state.m_t
                  << ": L2rel=" << std::scientific << std::setprecision(6)
                  << err_l2 << ", Linf=" << std::scientific
                  << std::setprecision(6) << err_linf << std::endl;

    const std::string filename = std::string("heat3d_") + fp_tag + ".txt";
    std::ofstream out_file(filename, std::ios::out | std::ios::trunc);
    if (out_file.is_open()) {
      out_file << report_stream.str();
    }
  }
};

#endif  // HEAT3D_HPP_
