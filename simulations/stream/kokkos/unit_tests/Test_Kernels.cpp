#include <gtest/gtest.h>
#include "stream.hpp"
#include "Test_Utils.hpp"

namespace {
using execution_space = Kokkos::DefaultExecutionSpace;
using float_types     = ::testing::Types<float, double>;

template <typename T>
struct TestStreamKernels : public ::testing::Test {
  using float_type = T;
};

template <typename RealType>
void test_stream_set() {
  using View1D = Kokkos::View<RealType*, execution_space>;

  const std::size_t size = 100;
  View1D a("a", size);

  RealType scalar = static_cast<RealType>(3.14);

  execution_space exec;
  set(exec, a, scalar);

  // Verify that all elements in the view are set to the scalar value
  auto h_a = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, a);
  Kokkos::deep_copy(h_a, a);
  for (std::size_t i = 0; i < size; ++i) {
    EXPECT_NEAR(h_a(i), scalar, fp_tolerance(scalar));
  }
}

template <typename RealType>
void test_stream_copy() {
  using View1D = Kokkos::View<RealType*, execution_space>;

  const std::size_t size = 100;
  View1D a("a", size), c("c", size);

  RealType scalar = static_cast<RealType>(3.14);
  Kokkos::deep_copy(a, scalar);

  execution_space exec;
  copy(exec, a, c);

  // Verify that all elements in the view are set to the scalar value
  auto h_c = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, c);
  Kokkos::deep_copy(h_c, c);
  for (std::size_t i = 0; i < size; ++i) {
    EXPECT_NEAR(h_c(i), scalar, fp_tolerance(scalar));
  }
}

template <typename RealType>
void test_stream_scale() {
  using View1D = Kokkos::View<RealType*, execution_space>;

  const std::size_t size = 100;
  View1D b("b", size), c("c", size);

  RealType scalar = static_cast<RealType>(3.14);
  Kokkos::deep_copy(c, scalar);

  execution_space exec;
  scale(exec, b, c, scalar);

  // Verify that all elements in the view are set to scalar^2
  RealType ref = scalar * scalar;
  auto h_b     = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, b);
  Kokkos::deep_copy(h_b, b);
  for (std::size_t i = 0; i < size; ++i) {
    EXPECT_NEAR(h_b(i), ref, fp_tolerance(ref));
  }
}

template <typename RealType>
void test_stream_add() {
  using View1D = Kokkos::View<RealType*, execution_space>;

  const std::size_t size = 100;
  View1D a("a", size), b("b", size), c("c", size);

  RealType scalar = static_cast<RealType>(3.14);
  Kokkos::deep_copy(a, scalar);
  Kokkos::deep_copy(b, scalar);

  execution_space exec;
  add(exec, a, b, c);

  // Verify that all elements in the view are set to 2 * scalar
  RealType ref = 2 * scalar;
  auto h_c     = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, c);
  Kokkos::deep_copy(h_c, c);
  for (std::size_t i = 0; i < size; ++i) {
    EXPECT_NEAR(h_c(i), ref, fp_tolerance(ref));
  }
}

template <typename RealType>
void test_stream_triad() {
  using View1D = Kokkos::View<RealType*, execution_space>;

  const std::size_t size = 100;
  View1D a("a", size), b("b", size), c("c", size);

  RealType scalar = static_cast<RealType>(3.14);
  Kokkos::deep_copy(b, scalar);
  Kokkos::deep_copy(c, scalar);

  execution_space exec;
  triad(exec, a, b, c, scalar);

  // Verify that all elements in the view are set to scalar + scalar^2
  RealType ref = scalar + scalar * scalar;
  auto h_a     = Kokkos::create_mirror_view_and_copy(Kokkos::HostSpace{}, a);
  Kokkos::deep_copy(h_a, a);
  for (std::size_t i = 0; i < size; ++i) {
    EXPECT_NEAR(h_a(i), ref, fp_tolerance(ref));
  }
}
}  // namespace

TYPED_TEST_SUITE(TestStreamKernels, float_types);

// Test Stream set
TYPED_TEST(TestStreamKernels, StreamSet) {
  using FloatType = typename TestFixture::float_type;
  test_stream_set<FloatType>();
}

// Test Stream copy
TYPED_TEST(TestStreamKernels, StreamCopy) {
  using FloatType = typename TestFixture::float_type;
  test_stream_copy<FloatType>();
}

// Test Stream scale
TYPED_TEST(TestStreamKernels, StreamScale) {
  using FloatType = typename TestFixture::float_type;
  test_stream_scale<FloatType>();
}

// Test Stream add
TYPED_TEST(TestStreamKernels, StreamAdd) {
  using FloatType = typename TestFixture::float_type;
  test_stream_add<FloatType>();
}

// Test Stream triad
TYPED_TEST(TestStreamKernels, StreamTriad) {
  using FloatType = typename TestFixture::float_type;
  test_stream_triad<FloatType>();
}
