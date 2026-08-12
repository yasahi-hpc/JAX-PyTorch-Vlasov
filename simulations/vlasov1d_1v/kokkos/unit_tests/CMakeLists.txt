add_executable(
    unit-tests-vlasov1d-1v
    Test_Main.cpp
    Test_Grid.cpp
    Test_Variables.cpp
    Test_Poisson.cpp
    Test_Interpolation.cpp
    Test_Advection.cpp
)

target_link_libraries(unit-tests-vlasov1d-1v PUBLIC GTest::gtest vlp1d_1v_lib)

# Enable GoogleTest
include(GoogleTest)
gtest_discover_tests(unit-tests-vlasov1d-1v PROPERTIES DISCOVERY_TIMEOUT 600 DISCOVERY_MODE PRE_TEST)
