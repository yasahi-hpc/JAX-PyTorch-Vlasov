add_executable(
    unit-tests-heat3d
    Test_Main.cpp
    Test_Grid.cpp
    Test_Variables.cpp
    Test_Heat.cpp
)

target_link_libraries(unit-tests-heat3d PUBLIC GTest::gtest heat3d_lib)

# Enable GoogleTest
include(GoogleTest)
gtest_discover_tests(unit-tests-heat3d PROPERTIES DISCOVERY_TIMEOUT 600 DISCOVERY_MODE PRE_TEST)
