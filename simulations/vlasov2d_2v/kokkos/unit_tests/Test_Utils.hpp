#ifndef TEST_UTILS_HPP
#define TEST_UTILS_HPP

#include <cmath>
#include <limits>

template <typename T>
T fp_tolerance(T expected) {
  return std::max(
      std::numeric_limits<T>::epsilon() * T(10),
      std::abs(expected) * std::numeric_limits<T>::epsilon() * T(1e3));
}

#endif  // TEST_UTILS_HPP
