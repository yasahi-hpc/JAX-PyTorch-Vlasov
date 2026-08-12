/// H200
/// Device Execution Space:
///   KOKKOS_ENABLE_CUDA: yes
/// Cuda Options:
///   KOKKOS_ENABLE_CUDA_RELOCATABLE_DEVICE_CODE: no
///   KOKKOS_ENABLE_CUDA_UVM: no
///   KOKKOS_ENABLE_IMPL_CUDA_MALLOC_ASYNC: no
///
/// Cuda Runtime Configuration:
/// macro  KOKKOS_ENABLE_CUDA      : defined
/// macro  CUDA_VERSION          : 13000 = version 13.0
/// Kokkos::Cuda[ 0 ] NVIDIA GH200 120GB : Selected
///   Capability: 9.0
///   Total Global Memory: 95 GiB
///   Shared Memory per Block: 48 KiB
///   Can access system allocated memory: 1
///     via Address Translation Service: 1
/// Grid: 256 x 256 x 256 (N=16777216), dtype=float
/// Times (s): best=1.661115e-01, avg=1.672210e-01 over 10 runs
/// Estimated bandwidth (GB/s): best=807.9976, avg=802.6370
/// Errors vs analytical PDE at t=49.9995: L2rel=4.550807e-06, Linf=4.768372e-06
/// Device Execution Space:
///   KOKKOS_ENABLE_CUDA: yes
/// Cuda Options:
///   KOKKOS_ENABLE_CUDA_RELOCATABLE_DEVICE_CODE: no
///   KOKKOS_ENABLE_CUDA_UVM: no
///   KOKKOS_ENABLE_IMPL_CUDA_MALLOC_ASYNC: no
///
/// Cuda Runtime Configuration:
/// macro  KOKKOS_ENABLE_CUDA      : defined
/// macro  CUDA_VERSION          : 13000 = version 13.0
/// Kokkos::Cuda[ 0 ] NVIDIA GH200 120GB : Selected
///   Capability: 9.0
///   Total Global Memory: 95 GiB
///   Shared Memory per Block: 48 KiB
///   Can access system allocated memory: 1
///     via Address Translation Service: 1
/// Grid: 256 x 256 x 256 (N=16777216), dtype=double
/// Times (s): best=1.727451e-01, avg=1.728274e-01 over 10 runs
/// Estimated bandwidth (GB/s): best=1553.9397, avg=1553.2000
/// Errors vs analytical PDE at t=50.0000: L2rel=3.720229e-06, Linf=3.202031e-06

#include <vector>
#include <chrono>
#include <Kokkos_Core.hpp>
#include "io_utils.hpp"
#include "heat3d.hpp"

int main(int argc, char* argv[]) {
  Kokkos::ScopeGuard guard(argc, argv);
  auto kwargs = IO::parse_args(argc, argv);
  std::string out_dir =
      IO::get_arg<std::string>(kwargs, "out_dir", "data_kokkos");
  int nx         = IO::get_arg(kwargs, "nx", 256);
  double lx      = IO::get_arg(kwargs, "lx", 2.0 * M_PI);
  int nbiter     = IO::get_arg(kwargs, "nbiter", 1000);
  int nbrepeats  = IO::get_arg(kwargs, "nbrepeats", 10);
  int diag_steps = IO::get_arg(kwargs, "diag_steps", 10);
  double dt      = IO::get_arg(kwargs, "dt", 0.05);
  double kappa   = IO::get_arg(kwargs, "kappa", 0.001);

  using ExecutionSpace = Kokkos::DefaultExecutionSpace;

#if defined(ENABLE_FP32)
  using RealType = float;
#else
  using RealType = double;
#endif

  Heat3D<ExecutionSpace, RealType> solver(nx, nx, nx, lx, lx, lx, nbiter,
                                          diag_steps, dt, out_dir, kappa);
  solver.initialize();

  // Main loop
  std::vector<double> timings;
  for (int i = 0; i < nbrepeats; ++i) {
    auto start = std::chrono::high_resolution_clock::now();
    solver.run();
    auto end = std::chrono::high_resolution_clock::now();
    timings.push_back(
        std::chrono::duration_cast<std::chrono::duration<double>>(end - start)
            .count());
  }

  solver.report(timings);

  return 0;
}
