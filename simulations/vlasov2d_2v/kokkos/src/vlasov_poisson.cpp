#include <Kokkos_Core.hpp>
#include "io_utils.hpp"
#include "vlasov_poisson.hpp"

int main(int argc, char* argv[]) {
  Kokkos::ScopeGuard guard(argc, argv);
  auto kwargs = IO::parse_args(argc, argv);
  std::string out_dir =
      IO::get_arg<std::string>(kwargs, "out_dir", "data_kokkos");
  int nx            = IO::get_arg(kwargs, "nx", 32);
  int ny            = IO::get_arg(kwargs, "ny", 32);
  int nvx           = IO::get_arg(kwargs, "nvx", 32);
  int nvy           = IO::get_arg(kwargs, "nvy", 32);
  double lx         = IO::get_arg(kwargs, "lx", 4.0 * M_PI);
  double ly         = IO::get_arg(kwargs, "ly", 4.0 * M_PI);
  double Vx_max     = IO::get_arg(kwargs, "Vx_max", 5.0);
  double Vy_max     = IO::get_arg(kwargs, "Vy_max", 5.0);
  int nbiter        = IO::get_arg(kwargs, "nbiter", 1000);
  int diag_steps    = IO::get_arg(kwargs, "diag_steps", 10);
  double dt         = IO::get_arg(kwargs, "dt", 0.05);
  bool physics_mode = IO::get_arg(kwargs, "physics_mode", true);
  double epsilon    = IO::get_arg(kwargs, "epsilon", 0.001);
  int solver_type   = IO::get_arg(kwargs, "solver_type", 0);

  using ExecutionSpace = Kokkos::DefaultExecutionSpace;
#if defined(ENABLE_FP32)
  using RealType = float;
#else
  using RealType = double;
#endif

  VlasovPoisson<ExecutionSpace, RealType> solver(
      nx, ny, nvx, nvy, lx, ly, Vx_max, Vy_max, nbiter, diag_steps, dt, out_dir,
      physics_mode, epsilon, solver_type);
  solver.initialize();
  Kokkos::Timer timer;
  solver.run();
  Kokkos::fence();
  double seconds = timer.seconds();
  solver.report(seconds);

  return 0;
}
