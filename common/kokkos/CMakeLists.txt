add_library(common_lib INTERFACE)

target_link_libraries(common_lib INTERFACE Kokkos::kokkos)
target_include_directories(
  common_lib INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}> $<INSTALL_INTERFACE:${INSTALL_INCLUDEDIR}>
)
