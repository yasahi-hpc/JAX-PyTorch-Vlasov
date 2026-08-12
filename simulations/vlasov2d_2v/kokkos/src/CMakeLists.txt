add_library(vlp2d_2v_lib INTERFACE)
target_link_libraries(vlp2d_2v_lib INTERFACE common_lib Kokkos::kokkos KokkosFFT::fft)

# Expose headers to dependents
target_include_directories(vlp2d_2v_lib
    INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}
)

foreach(PRECISION fp32 fp64)
    string(TOUPPER ${PRECISION} PRECISION_UPPER)
    set(TARGET_NAME vlp2d_2v_${PRECISION})

    add_executable(${TARGET_NAME} vlasov_poisson.cpp)
    target_compile_features(${TARGET_NAME} PUBLIC cxx_std_20)
    target_compile_definitions(${TARGET_NAME} PUBLIC ENABLE_${PRECISION_UPPER})
    target_link_libraries(${TARGET_NAME} PUBLIC vlp2d_2v_lib)
endforeach()
