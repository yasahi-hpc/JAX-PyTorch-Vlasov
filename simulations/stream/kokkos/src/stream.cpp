#include <Kokkos_Core.hpp>
#include "io_utils.hpp"
#include "stream.hpp"

int main(int argc, char* argv[]) {
  Kokkos::ScopeGuard guard(argc, argv);
  auto kwargs = IO::parse_args(argc, argv);
  int size    = IO::get_arg(kwargs, "size", 20000000);
  int nbiter  = IO::get_arg(kwargs, "nbiter", 10);

  using ExecutionSpace = Kokkos::DefaultExecutionSpace;
#if defined(ENABLE_FP32)
  using RealType = float;
#else
  using RealType = double;
#endif

  Stream<ExecutionSpace, RealType> stream(size, nbiter);
  stream.run();
  stream.report();

  return 0;
}
