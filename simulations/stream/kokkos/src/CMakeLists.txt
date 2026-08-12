add_library(stream_lib INTERFACE)
target_link_libraries(stream_lib INTERFACE common_lib Kokkos::kokkos)

# Expose headers to dependents
target_include_directories(stream_lib
    INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}
)

foreach(PRECISION fp32 fp64)
    string(TOUPPER ${PRECISION} PRECISION_UPPER)
    set(TARGET_NAME stream_${PRECISION})

    add_executable(${TARGET_NAME} stream.cpp)
    target_compile_features(${TARGET_NAME} PUBLIC cxx_std_20)
    target_compile_definitions(${TARGET_NAME} PUBLIC ENABLE_${PRECISION_UPPER})
    target_link_libraries(${TARGET_NAME} PUBLIC stream_lib)
endforeach()
