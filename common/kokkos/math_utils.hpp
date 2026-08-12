#ifndef MATH_UTILS_HPP
#define MATH_UTILS_HPP

#include <stdexcept>
#include <Kokkos_Core.hpp>

namespace Math {

template <typename T>
struct base_floating_point {
  using value_type = T;
};

template <typename T>
struct base_floating_point<Kokkos::complex<T>> {
  using value_type = T;
};

/// \brief Helper to extract the base floating point type from a complex type
template <typename T>
using base_floating_point_type = typename base_floating_point<T>::value_type;

template <typename ExecutionSpace, typename RealType>
auto linspace(const ExecutionSpace&, const RealType start, const RealType stop,
              std::size_t num = 50, bool endpoint = true) {
  static_assert(std::is_floating_point_v<RealType>,
                "linspace: start and stop must be floating point types.");
  if (num == 0) {
    throw std::runtime_error("Number of elements must be larger than 0");
  }

  using ViewType = Kokkos::View<RealType*, ExecutionSpace>;

  std::size_t length = endpoint ? (num - 1) : num;
  RealType delta     = (stop - start) / static_cast<RealType>(length);
  ViewType result("linspace", num);

  auto h_result = Kokkos::create_mirror_view(result);
  for (std::size_t i = 0; i < length; i++) {
    h_result(i) = start + delta * static_cast<RealType>(i);
  }
  if (endpoint) h_result(length) = stop;
  Kokkos::deep_copy(result, h_result);

  return result;
}

// \brief A class to represent the 4th order Runge-Kutta method for solving ODE
// dy/dt = f(t, y) by
// y^{n+1} = y^{n} + (k1 + 2*k2 + 2*k3 + k4)/6
// t^{n+1} = t^{n} + h
// where h is a time step and
// k1 = f(t^{n}      , y^{n}     ) * h
// k2 = f(t^{n} + h/2, y^{n}+k1/2) * h
// k3 = f(t^{n} + h/2, y^{n}+k2/2) * h
// k4 = f(t^{n} + h  , y^{n}+k3  ) * h
//
// \tparam ExecutionSpace The type of the execution space
// \tparam BufferType The type of the view
template <typename ExecutionSpace, typename BufferType>
class RK4th {
  static_assert(BufferType::rank == 1, "RK4th: BufferType must have rank 1.");
  using value_type = typename BufferType::non_const_value_type;
  using float_type = base_floating_point_type<value_type>;

  //! Execution space
  ExecutionSpace m_exec_space;

  //! Order of the Runge-Kutta method
  const int m_order = 4;

  //! Time step size
  const float_type m_h;

  //! Size of the input View after flattening
  std::size_t m_array_size;

  //! Buffer views for intermediate results
  BufferType m_y, m_k1, m_k2, m_k3;

 public:
  // \brief Constructor of a RK4th class
  // \param[in] exec_space Kokkos execution space used in kernels
  // \param[in] y The variable to be solved
  // \param[in] h Time step
  RK4th(const ExecutionSpace& exec_space, const BufferType& y, float_type h)
      : m_exec_space(exec_space), m_h(h) {
    m_array_size = y.size();
    m_y          = BufferType("y", m_array_size);
    m_k1         = BufferType("k1", m_array_size);
    m_k2         = BufferType("k2", m_array_size);
    m_k3         = BufferType("k3", m_array_size);
  }

  auto order() { return m_order; }

  // \brief Advances the solution by one step using the Runge-Kutta method.
  // \tparam ViewType The type of the view
  // \param[in] dydt The right-hand side of the ODE
  // \param[in,out] y The current solution.
  // \param[in] step The current step (0, 1, 2, or 3)
  template <typename ViewType>
  void advance(const ViewType& dydt, const ViewType& y, int step) {
    static_assert(ViewType::rank == 1, "RK4th: ViewType must have rank 1.");
    auto h      = m_h;
    auto y_copy = m_y;
    if (step == 0) {
      auto k1 = m_k1;
      Kokkos::parallel_for(
          "rk_step0",
          Kokkos::RangePolicy<ExecutionSpace, Kokkos::IndexType<std::size_t>>(
              m_exec_space, 0, m_array_size),
          KOKKOS_LAMBDA(const std::size_t& i) {
            y_copy(i) = y(i);
            k1(i)     = dydt(i) * h;
            y(i)      = y_copy(i) + k1(i) / 2.0;
          });
    } else if (step == 1) {
      auto k2 = m_k2;
      Kokkos::parallel_for(
          "rk_step1",
          Kokkos::RangePolicy<ExecutionSpace, Kokkos::IndexType<std::size_t>>(
              m_exec_space, 0, m_array_size),
          KOKKOS_LAMBDA(const std::size_t& i) {
            k2(i) = dydt(i) * h;
            y(i)  = y_copy(i) + k2(i) / 2.0;
          });
    } else if (step == 2) {
      auto k3 = m_k3;
      Kokkos::parallel_for(
          "rk_step2",
          Kokkos::RangePolicy<ExecutionSpace, Kokkos::IndexType<std::size_t>>(
              m_exec_space, 0, m_array_size),
          KOKKOS_LAMBDA(const std::size_t& i) {
            k3(i) = dydt(i) * h;
            y(i)  = y_copy(i) + k3(i);
          });
    } else if (step == 3) {
      auto k1 = m_k1;
      auto k2 = m_k2;
      auto k3 = m_k3;
      Kokkos::parallel_for(
          "rk_step3",
          Kokkos::RangePolicy<ExecutionSpace, Kokkos::IndexType<std::size_t>>(
              m_exec_space, 0, m_array_size),
          KOKKOS_LAMBDA(const std::size_t& i) {
            auto tmp_dy =
                (k1(i) + 2.0 * k2(i) + 2.0 * k3(i) + dydt(i) * h) / 6.0;
            y(i) = y_copy(i) + tmp_dy;
          });
    } else {
      throw std::runtime_error("step should be 0, 1, 2, or 3");
    }
  }
};

}  // namespace Math

#endif
