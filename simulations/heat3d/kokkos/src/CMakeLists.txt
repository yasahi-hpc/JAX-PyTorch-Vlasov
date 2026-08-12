add_library(heat3d_lib INTERFACE)
target_link_libraries(heat3d_lib INTERFACE common_lib Kokkos::kokkos)

# Expose headers to dependents
target_include_directories(heat3d_lib
    INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}
)

foreach(PRECISION fp32 fp64)
    string(TOUPPER ${PRECISION} PRECISION_UPPER)
    set(TARGET_NAME heat3d_${PRECISION})

    add_executable(${TARGET_NAME} heat3d.cpp)
    target_compile_features(${TARGET_NAME} PUBLIC cxx_std_20)
    target_compile_definitions(${TARGET_NAME} PUBLIC ENABLE_${PRECISION_UPPER})
    target_link_libraries(${TARGET_NAME} PUBLIC heat3d_lib)
endforeach()
