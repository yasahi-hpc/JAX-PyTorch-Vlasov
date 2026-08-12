cmake_minimum_required(VERSION 3.22)
project(vlp4d VERSION 0.0.1 LANGUAGES CXX)

list(PREPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# Version information
set(VLP4D_VERSION ${PROJECT_VERSION})
set(VLP4D_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(VLP4D_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(VLP4D_VERSION_PATCH ${PROJECT_VERSION_PATCH})

set(KOKKOS_REQUIRED_VERSION 4.5.0)
set(KOKKOSFFT_REQUIRED_VERSION 0.4.0)

option(VLP4D_ENABLE_TESTS "Build tests" OFF)
option(VLP4D_ENABLE_INTERNAL_KOKKOS "Build internal Kokkos instead of relying on external one" OFF)
option(VLP4D_ENABLE_INTERNAL_KOKKOSFFT "Build internal Kokkos-fft instead of relying on external one" OFF)

if (NOT VLP4D_ENABLE_INTERNAL_KOKKOS)
    # First check, Kokkos is added as subdirectory or not
    if(NOT TARGET Kokkos::kokkos)
        find_package(Kokkos ${KOKKOS_REQUIRED_VERSION} REQUIRED)
    endif()
else ()
    add_subdirectory(tpls/kokkos)
endif ()

if (NOT VLP4D_ENABLE_INTERNAL_KOKKOSFFT)
    # First check, Kokkos is added as subdirectory or not
    if(NOT TARGET KokkosFFT::fft)
        find_package(KokkosFFT ${KOKKOSFFT_REQUIRED_VERSION} REQUIRED)
    endif()
else ()
    add_subdirectory(tpls/kokkos-fft)
endif ()

# ==================================================================
# CMake Summary
# ==================================================================

message("")
message(STATUS "vlp4d version: ${VLP4D_VERSION_MAJOR}.${VLP4D_VERSION_MINOR}.${VLP4D_VERSION_PATCH}")

# googletest
if(VLP4D_ENABLE_TESTS)
  include(CTest)
  find_package(GTest CONFIG)
  if(NOT GTest_FOUND)
    add_subdirectory(tpls/googletest)
  endif()
endif()

add_subdirectory(common)
add_subdirectory(simulations)
