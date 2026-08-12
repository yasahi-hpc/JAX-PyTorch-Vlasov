add_executable(
    unit-tests-vlasov2d-2v
    Test_Main.cpp
    Test_Grid.cpp
    Test_Variables.cpp
    Test_Poisson.cpp
    Test_Interpolation.cpp
    Test_Advection.cpp
)

target_link_libraries(unit-tests-vlasov2d-2v PUBLIC GTest::gtest vlp2d_2v_lib)

# Enable GoogleTest
include(GoogleTest)
gtest_discover_tests(unit-tests-vlasov2d-2v PROPERTIES DISCOVERY_TIMEOUT 600 DISCOVERY_MODE PRE_TEST)
