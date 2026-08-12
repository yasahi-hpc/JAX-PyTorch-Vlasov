add_executable(
    unit-tests-stream
    Test_Main.cpp
    Test_Kernels.cpp
)

target_link_libraries(unit-tests-stream PUBLIC GTest::gtest stream_lib)

# Enable GoogleTest
include(GoogleTest)
gtest_discover_tests(unit-tests-stream PROPERTIES DISCOVERY_TIMEOUT 600 DISCOVERY_MODE PRE_TEST)
