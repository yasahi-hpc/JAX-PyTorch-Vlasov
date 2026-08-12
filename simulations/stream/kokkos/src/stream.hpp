#ifndef STREAM_HPP_
#define STREAM_HPP_

/*
Device Execution Space:
  KOKKOS_ENABLE_CUDA: yes
Cuda Options:
  KOKKOS_ENABLE_CUDA_RELOCATABLE_DEVICE_CODE: no
  KOKKOS_ENABLE_CUDA_UVM: no
  KOKKOS_ENABLE_IMPL_CUDA_MALLOC_ASYNC: no

Cuda Runtime Configuration:
macro  KOKKOS_ENABLE_CUDA      : defined
macro  CUDA_VERSION          : 12090 = version 12.9
Kokkos::Cuda[ 0 ] NVIDIA GH200 120GB : Selected
  Capability: 9.0
  Total Global Memory: 94.5 GiB
  Shared Memory per Block: 48 KiB
  Can access system allocated memory: 1
    via Address Translation Service: 1
Running STREAM Benchmark
Array Size: 20000000 elements (152 MB)
Total Memory: 456 MB
Data Type: double
Iterations: 10
-----------------------------------------------------------------
Function        Best Rate (GB/s)    Avg Time (s)    Min Time (s)
-----------------------------------------------------------------
Add             3509.5929           1.375399e-04    1.367680e-04
Copy            3081.6641           1.049424e-04    1.038400e-04
Scale           3055.2718           1.050882e-04    1.047370e-04
Set             1565.4352           1.026563e-04    1.022080e-04
Triad           3510.3886           1.377852e-04    1.367370e-04
*/

#include <map>
#include <vector>
#include <string>
#include <iostream>
#include <fstream>
#include <iomanip>
#include <sstream>
#include <chrono>
#include <numeric>
#include <type_traits>
#include <Kokkos_Core.hpp>

template <typename FunctorType, typename... Args>
auto time_kernel(FunctorType&& functor, const std::size_t nbiter,
                 Args&&... args) {
  std::vector<double> timings;
  for (std::size_t iter = 0; iter < nbiter; ++iter) {
    auto start = std::chrono::high_resolution_clock::now();
    std::forward<FunctorType>(functor)(std::forward<Args>(args)...);
    auto end = std::chrono::high_resolution_clock::now();
    timings.push_back(
        std::chrono::duration_cast<std::chrono::duration<double>>(end - start)
            .count());
  }

  // Find minimum time; ignore the first result
  auto min = std::min_element(timings.begin() + 1, timings.end());

  // Calculate average; ignore the first result
  double average = std::accumulate(timings.begin() + 1, timings.end(), 0.0) /
                   (double)(timings.size() - 1);

  return std::make_pair(*min, average);
}

template <typename ExecutionSpace, typename ViewType,
          typename RealType = typename ViewType::non_const_value_type>
void set(const ExecutionSpace& exec_space, const ViewType& a, RealType scalar) {
  Kokkos::parallel_for(
      "set",
      Kokkos::RangePolicy<ExecutionSpace, Kokkos::IndexType<std::size_t>>(
          exec_space, 0, a.extent(0)),
      KOKKOS_LAMBDA(const std::size_t i) { a(i) = scalar; });
  exec_space.fence();
}

template <typename ExecutionSpace, typename ViewType>
void copy(const ExecutionSpace& exec_space, const ViewType& a,
          const ViewType& c) {
  Kokkos::parallel_for(
      "copy",
      Kokkos::RangePolicy<ExecutionSpace, Kokkos::IndexType<std::size_t>>(
          exec_space, 0, a.extent(0)),
      KOKKOS_LAMBDA(const std::size_t i) { c(i) = a(i); });
  exec_space.fence();
}

template <typename ExecutionSpace, typename ViewType,
          typename RealType = typename ViewType::non_const_value_type>
void scale(const ExecutionSpace& exec_space, const ViewType& b,
           const ViewType& c, RealType scalar) {
  Kokkos::parallel_for(
      "scale",
      Kokkos::RangePolicy<ExecutionSpace, Kokkos::IndexType<std::size_t>>(
          exec_space, 0, b.extent(0)),
      KOKKOS_LAMBDA(const std::size_t i) { b(i) = scalar * c(i); });
  exec_space.fence();
}

template <typename ExecutionSpace, typename ViewType>
void add(const ExecutionSpace& exec_space, const ViewType& a, const ViewType& b,
         const ViewType& c) {
  Kokkos::parallel_for(
      "add",
      Kokkos::RangePolicy<ExecutionSpace, Kokkos::IndexType<std::size_t>>(
          exec_space, 0, a.extent(0)),
      KOKKOS_LAMBDA(const std::size_t i) { c(i) = a(i) + b(i); });
  exec_space.fence();
}

template <typename ExecutionSpace, typename ViewType,
          typename RealType = typename ViewType::non_const_value_type>
void triad(const ExecutionSpace& exec_space, const ViewType& a,
           const ViewType& b, const ViewType& c, RealType scalar) {
  Kokkos::parallel_for(
      "triad",
      Kokkos::RangePolicy<ExecutionSpace, Kokkos::IndexType<std::size_t>>(
          exec_space, 0, a.extent(0)),
      KOKKOS_LAMBDA(const std::size_t i) { a(i) = b(i) + scalar * c(i); });
  exec_space.fence();
}

template <typename ExecutionSpace, typename RealType>
class Stream {
 private:
  using View1D = Kokkos::View<RealType*, ExecutionSpace>;

  // Size of arrays
  std::size_t m_size;

  // Number of iterations for timing
  std::size_t m_nbiter;

  // Scalar
  const RealType m_scalar = 4.0;

  // Buffers
  View1D m_a;
  View1D m_b;
  View1D m_c;

  // Results (key, value) = (operation, (min_time, average_time))
  std::map<std::string, std::pair<double, double>> m_results;

 public:
  Stream(std::size_t size, std::size_t nbiter)
      : m_size(size), m_nbiter(nbiter) {
    // Allocate Kokkos Views
    m_a = View1D("a", m_size);
    m_b = View1D("b", m_size);
    m_c = View1D("c", m_size);

    // Initialize Kokkos Views with deep_copy
    const RealType a_init = 1.0, b_init = 2.0, c_init = 0.0;
    Kokkos::deep_copy(m_a, a_init);
    Kokkos::deep_copy(m_b, b_init);
    Kokkos::deep_copy(m_c, c_init);
  }
  ~Stream() = default;

  void run() {
    ExecutionSpace exec_space;
    m_results["Set"]   = time_kernel(set<ExecutionSpace, View1D, RealType>,
                                     m_nbiter, exec_space, m_a, m_scalar);
    m_results["Copy"]  = time_kernel(copy<ExecutionSpace, View1D>, m_nbiter,
                                     exec_space, m_a, m_c);
    m_results["Scale"] = time_kernel(scale<ExecutionSpace, View1D, RealType>,
                                     m_nbiter, exec_space, m_b, m_c, m_scalar);
    m_results["Add"]   = time_kernel(add<ExecutionSpace, View1D>, m_nbiter,
                                     exec_space, m_a, m_b, m_c);
    m_results["Triad"] =
        time_kernel(triad<ExecutionSpace, View1D, RealType>, m_nbiter,
                    exec_space, m_a, m_b, m_c, m_scalar);
  }

  void report() const {
    std::size_t array_size_mb = (m_size * sizeof(RealType)) / (1024 * 1024);
    std::size_t total_mem_mb  = 3 * array_size_mb;  // a, b, c

    std::ostringstream report_stream;
    ExecutionSpace().print_configuration(report_stream);

    std::string dtype_name = "unknown";
    std::string fp_tag     = "unknown";
    if constexpr (std::is_same_v<RealType, double>) {
      dtype_name = "double";
      fp_tag     = "fp64";
    } else if constexpr (std::is_same_v<RealType, float>) {
      dtype_name = "float";
      fp_tag     = "fp32";
    }

    report_stream << "Running STREAM Benchmark" << std::endl;
    report_stream << "Array Size: " << m_size << " elements (" << array_size_mb
                  << " MB)" << std::endl;
    report_stream << "Total Memory: " << total_mem_mb << " MB" << std::endl;
    report_stream << "Data Type: " << dtype_name << std::endl;
    report_stream << "Iterations: " << m_nbiter << std::endl;
    report_stream << std::string(65, '-') << std::endl;
    report_stream << std::left << std::setw(16) << "Function" << std::setw(20)
                  << "Best Rate (GB/s)" << std::setw(16) << "Avg Time (s)"
                  << std::setw(16) << "Min Time (s)" << std::endl;
    report_stream << std::string(65, '-') << std::endl;

    std::map<std::string, double> bytes_map = {
        {"Set", 1 * sizeof(RealType)},    // Write a(i)
        {"Copy", 2 * sizeof(RealType)},   // Read a(i), Write c(i)
        {"Scale", 2 * sizeof(RealType)},  // Read c(i), Write b(i)
        {"Add", 3 * sizeof(RealType)},    // Read a(i), Read b(i), Write c(i)
        {"Triad", 3 * sizeof(RealType)}   // Read b(i), Read c(i), Write a(i)
    };

    for (const auto& [operation, timings] : m_results) {
      auto [min_time, avg_time] = timings;
      double best_rate = (bytes_map[operation] * m_size) / (min_time * 1.0e9);
      report_stream << std::left << std::setw(16) << operation << std::setw(20)
                    << std::fixed << std::setprecision(4) << best_rate
                    << std::setw(16) << std::scientific << std::setprecision(6)
                    << avg_time << std::setw(16) << min_time << std::endl;
    }

    const std::string filename = std::string("stream_") + fp_tag + ".txt";
    std::ofstream out_file(filename, std::ios::out | std::ios::trunc);
    if (out_file.is_open()) {
      out_file << report_stream.str();
    }
  }
};

#endif  // STREAM_HPP_
