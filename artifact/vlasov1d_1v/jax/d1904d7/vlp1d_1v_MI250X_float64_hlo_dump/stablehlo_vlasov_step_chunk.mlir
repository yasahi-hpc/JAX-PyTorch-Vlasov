module @jit_run_chunk attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<128xf64>, %arg1: tensor<128xf64>, %arg2: tensor<65xf64>, %arg3: tensor<6xi32>, %arg4: tensor<128xf64>, %arg5: tensor<128xf64>, %arg6: tensor<128x128xf64>, %arg7: tensor<128xf64>, %arg8: tensor<f64>, %arg9: tensor<i64>) -> (tensor<128xf64> {jax.result_info = "result[0][0]"}, tensor<128xf64> {jax.result_info = "result[0][1]"}, tensor<65xf64> {jax.result_info = "result[0][2]"}, tensor<6xi32> {jax.result_info = "result[0][3]"}, tensor<128xf64> {jax.result_info = "result[1][0]"}, tensor<128xf64> {jax.result_info = "result[1][1]"}, tensor<128x128xf64> {jax.result_info = "result[2][0]"}, tensor<128xf64> {jax.result_info = "result[2][1]"}, tensor<f64> {jax.result_info = "result[3]"}, tensor<i64> {jax.result_info = "result[4]"}) {
    %cst = stablehlo.constant dense<"0x00000000000014C0ECF57ABD5EAF13C0D8EBF57ABD5E13C0C4E170381C0E13C0B0D7EBF57ABD12C09BCD66B3D96C12C087C3E170381C12C072B95C2E97CB11C05EAFD7EBF57A11C04AA552A9542A11C0369BCD66B3D910C022914824128910C00E87C3E1703810C0F4F97C3E9FCF0FC0CCE572B95C2E0FC0A4D168341A8D0EC07CBD5EAFD7EB0DC053A9542A954A0DC02B954AA552A90CC00381402010080CC0DB6C369BCD660BC0B3582C168BC50AC08844229148240AC06030180C068309C0381C0E87C3E108C010080402814008C0E8F3F97C3E9F07C0BFDFEFF7FBFD06C096CBE572B95C06C06EB7DBED76BB05C046A3D168341A05C01E8FC7E3F17804C0F67ABD5EAFD703C0CE66B3D96C3603C0A652A9542A9502C07E3E9FCFE7F301C0562A954AA55201C02D168BC562B100C004028140201000C0B8DBED76BBDDFEBF68B3D96C369BFDBF178BC562B158FCBFC762B1582C16FBBF733A9D4EA7D3F9BF221289442291F8BFD2E9743A9D4EF7BF82C16030180CF6BF31994C2693C9F4BFE170381C0E87F3BF914824128944F2BF402010080402F1BFE0EFF7FBFD7EEFBF409FCFE7F3F9ECBFA04EA7D3E974EABFFCFD7EBFDFEFE7BF58AD56ABD56AE5BFB85C2E97CBE5E2BF180C0683C160E0BFF076BBDD6EB7DBBFA8D56AB55AADD6BF68341A8D46A3D1BF402693C96432C9BF80C7E3F1783CBEBF008542A15028A4BF008542A15028A43F80C7E3F1783CBE3F402693C96432C93F60341A8D46A3D13FA8D56AB55AADD63FF076BBDD6EB7DB3F180C0683C160E03FB85C2E97CBE5E23F58AD56ABD56AE53FF8FD7EBFDFEFE73F9C4EA7D3E974EA3F3C9FCFE7F3F9EC3FE0EFF7FBFD7EEF3F412010080402F13F914824128944F23FE170381C0E87F33F31994C2693C9F43F83C16030180CF63FD3E9743A9D4EF73F231289442291F83F733A9D4EA7D3F93FC662B1582C16FB3F168BC562B158FC3F68B3D96C369BFD3FB8DBED76BBDDFE3F04028140201000402C168BC562B10040542A954AA55201407D3E9FCFE7F30140A652A9542A950240CE66B3D96C360340F67ABD5EAFD703401E8FC7E3F178044046A3D168341A05406EB7DBED76BB054096CBE572B95C0640BFDFEFF7FBFD0640E8F3F97C3E9F07401008040281400840381C0E87C3E108406030180C068309408844229148240A40B0582C168BC50A40D86C369BCD660B400281402010080C402C954AA552A90C4054A9542A954A0D407CBD5EAFD7EB0D40A4D168341A8D0E40CCE572B95C2E0F40F4F97C3E9FCF0F400E87C3E1703810402291482412891040369BCD66B3D910404AA552A9542A11405EAFD7EBF57A114072B95C2E97CB114086C3E170381C12409BCD66B3D96C1240AFD7EBF57ABD1240C4E170381C0E1340D8EBF57ABD5E1340ECF57ABD5EAF13400000000000001440"> : tensor<128xf64>
    %c = stablehlo.constant dense<[-2, -1, 0, 1, 2, 3]> : tensor<6xi32>
    %cst_0 = stablehlo.constant dense<[0.000000e+00, 2.000000e+00, 1.000000e+00, 0.66666666666666663, 5.000000e-01, 4.000000e-01, 0.33333333333333331, 0.2857142857142857, 2.500000e-01, 0.22222222222222221, 2.000000e-01, 0.18181818181818182, 0.16666666666666666, 0.15384615384615385, 0.14285714285714285, 0.13333333333333333, 1.250000e-01, 0.11764705882352941, 0.1111111111111111, 0.10526315789473684, 1.000000e-01, 0.095238095238095233, 0.090909090909090911, 0.086956521739130432, 0.083333333333333329, 8.000000e-02, 0.076923076923076927, 0.074074074074074084, 0.071428571428571425, 0.068965517241379296, 0.066666666666666666, 0.064516129032258063, 6.250000e-02, 0.060606060606060608, 0.058823529411764705, 0.057142857142857141, 0.055555555555555552, 0.054054054054054057, 0.052631578947368418, 0.05128205128205128, 5.000000e-02, 0.04878048780487805, 0.047619047619047616, 0.046511627906976744, 0.045454545454545456, 0.044444444444444446, 0.043478260869565216, 0.042553191489361701, 0.041666666666666664, 0.040816326530612242, 4.000000e-02, 0.039215686274509803, 0.038461538461538464, 0.037735849056603779, 0.037037037037037042, 0.036363636363636369, 0.035714285714285712, 0.035087719298245612, 0.034482758620689648, 0.033898305084745756, 0.033333333333333333, 0.032786885245901641, 0.032258064516129031, 0.031746031746031744, 3.125000e-02]> : tensor<65xf64>
    %c_1 = stablehlo.constant dense<0> : tensor<i64>
    %0:7 = stablehlo.while(%iterArg = %cst, %iterArg_4 = %c, %iterArg_5 = %cst_0, %iterArg_6 = %c_1, %iterArg_7 = %arg6, %iterArg_8 = %arg4, %iterArg_9 = %arg5) : tensor<128xf64>, tensor<6xi32>, tensor<65xf64>, tensor<i64>, tensor<128x128xf64>, tensor<128xf64>, tensor<128xf64>
    cond {
      %c_10 = stablehlo.constant dense<1000> : tensor<i64>
      %3 = stablehlo.compare  LT, %iterArg_6, %c_10,  SIGNED : (tensor<i64>, tensor<i64>) -> tensor<i1>
      stablehlo.return %3 : tensor<i1>
    } do {
      %3:3 = func.call @closed_call(%iterArg, %iterArg_4, %iterArg_5, %iterArg_7, %iterArg_8, %iterArg_9) : (tensor<128xf64>, tensor<6xi32>, tensor<65xf64>, tensor<128x128xf64>, tensor<128xf64>, tensor<128xf64>) -> (tensor<128x128xf64>, tensor<128xf64>, tensor<128xf64>)
      %c_10 = stablehlo.constant dense<1> : tensor<i64>
      %4 = stablehlo.add %iterArg_6, %c_10 : tensor<i64>
      stablehlo.return %iterArg, %iterArg_4, %iterArg_5, %4, %3#0, %3#1, %3#2 : tensor<128xf64>, tensor<6xi32>, tensor<65xf64>, tensor<i64>, tensor<128x128xf64>, tensor<128xf64>, tensor<128xf64>
    }
    %cst_2 = stablehlo.constant dense<5.000000e+01> : tensor<f64>
    %1 = stablehlo.add %arg8, %cst_2 : tensor<f64>
    %c_3 = stablehlo.constant dense<1000> : tensor<i64>
    %2 = stablehlo.add %arg9, %c_3 : tensor<i64>
    return %arg0, %arg1, %arg2, %arg3, %0#5, %0#6, %0#4, %arg7, %1, %2 : tensor<128xf64>, tensor<128xf64>, tensor<65xf64>, tensor<6xi32>, tensor<128xf64>, tensor<128xf64>, tensor<128x128xf64>, tensor<128xf64>, tensor<f64>, tensor<i64>
  }
  func.func private @closed_call(%arg0: tensor<128xf64>, %arg1: tensor<6xi32>, %arg2: tensor<65xf64>, %arg3: tensor<128x128xf64>, %arg4: tensor<128xf64>, %arg5: tensor<128xf64>) -> (tensor<128x128xf64>, tensor<128xf64>, tensor<128xf64>) {
    %0 = stablehlo.transpose %arg3, dims = [1, 0] : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %cst = stablehlo.constant dense<2.500000e-02> : tensor<f64>
    %cst_0 = stablehlo.constant dense<0.098174770424681035> : tensor<f64>
    %1 = call @advect_1d_vectorized(%0, %arg0, %cst, %cst_0, %arg1) : (tensor<128x128xf64>, tensor<128xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<128x128xf64>
    %2 = stablehlo.transpose %1, dims = [1, 0] : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %cst_1 = stablehlo.constant dense<0.078740157480314959> : tensor<f64>
    %3:3 = call @solve_poisson(%2, %arg2, %cst_1) : (tensor<128x128xf64>, tensor<65xf64>, tensor<f64>) -> (tensor<128xf64>, tensor<128xf64>, tensor<128xf64>)
    %cst_2 = stablehlo.constant dense<5.000000e-02> : tensor<f64>
    %cst_3 = stablehlo.constant dense<0.078740157480314959> : tensor<f64>
    %4 = call @advect_1d_vectorized_41(%2, %3#0, %cst_2, %cst_3, %arg1) : (tensor<128x128xf64>, tensor<128xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<128x128xf64>
    %5 = stablehlo.transpose %4, dims = [1, 0] : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %cst_4 = stablehlo.constant dense<2.500000e-02> : tensor<f64>
    %cst_5 = stablehlo.constant dense<0.098174770424681035> : tensor<f64>
    %6 = call @advect_1d_vectorized(%5, %arg0, %cst_4, %cst_5, %arg1) : (tensor<128x128xf64>, tensor<128xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<128x128xf64>
    %7 = stablehlo.transpose %6, dims = [1, 0] : (tensor<128x128xf64>) -> tensor<128x128xf64>
    return %7, %3#1, %3#2 : tensor<128x128xf64>, tensor<128xf64>, tensor<128xf64>
  }
  func.func private @advect_1d_vectorized(%arg0: tensor<128x128xf64>, %arg1: tensor<128xf64>, %arg2: tensor<f64>, %arg3: tensor<f64>, %arg4: tensor<6xi32>) -> tensor<128x128xf64> {
    %0 = stablehlo.iota dim = 0 : tensor<128xf64>
    %1 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<128xf64>) -> tensor<128x1xf64>
    %2 = stablehlo.convert %arg2 : tensor<f64>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<f64>) -> tensor<128x1xf64>
    %4 = stablehlo.multiply %1, %3 : tensor<128x1xf64>
    %5 = stablehlo.convert %arg3 : tensor<f64>
    %6 = stablehlo.broadcast_in_dim %5, dims = [] : (tensor<f64>) -> tensor<128x1xf64>
    %7 = stablehlo.divide %4, %6 : tensor<128x1xf64>
    %8 = stablehlo.broadcast_in_dim %0, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %10 = stablehlo.broadcast_in_dim %7, dims = [0, 1] : (tensor<128x1xf64>) -> tensor<128x128xf64>
    %11 = stablehlo.subtract %9, %10 : tensor<128x128xf64>
    %12 = stablehlo.floor %11 : tensor<128x128xf64>
    %13 = stablehlo.subtract %11, %12 : tensor<128x128xf64>
    %14 = stablehlo.convert %12 : (tensor<128x128xf64>) -> tensor<128x128xi32>
    %15 = stablehlo.broadcast_in_dim %14, dims = [0, 1] : (tensor<128x128xi32>) -> tensor<128x128x1xi32>
    %16 = stablehlo.broadcast_in_dim %arg4, dims = [2] : (tensor<6xi32>) -> tensor<1x1x6xi32>
    %17 = stablehlo.broadcast_in_dim %15, dims = [0, 1, 2] : (tensor<128x128x1xi32>) -> tensor<128x128x6xi32>
    %18 = stablehlo.broadcast_in_dim %16, dims = [0, 1, 2] : (tensor<1x1x6xi32>) -> tensor<128x128x6xi32>
    %19 = stablehlo.add %17, %18 : tensor<128x128x6xi32>
    %c = stablehlo.constant dense<128> : tensor<i64>
    %20 = call @remainder(%19, %c) : (tensor<128x128x6xi32>, tensor<i64>) -> tensor<128x128x6xi32>
    %21 = stablehlo.iota dim = 0 : tensor<128xi64>
    %22 = stablehlo.broadcast_in_dim %21, dims = [0] : (tensor<128xi64>) -> tensor<128x1x1xi64>
    %c_0 = stablehlo.constant dense<128> : tensor<i64>
    %23 = stablehlo.broadcast_in_dim %c_0, dims = [] : (tensor<i64>) -> tensor<128x1x1xi64>
    %24 = stablehlo.multiply %22, %23 : tensor<128x1x1xi64>
    %25 = stablehlo.convert %20 : (tensor<128x128x6xi32>) -> tensor<128x128x6xi64>
    %26 = stablehlo.broadcast_in_dim %24, dims = [0, 1, 2] : (tensor<128x1x1xi64>) -> tensor<128x128x6xi64>
    %27 = stablehlo.add %26, %25 : tensor<128x128x6xi64>
    %28 = stablehlo.reshape %arg0 : (tensor<128x128xf64>) -> tensor<16384xf64>
    %29 = stablehlo.reshape %27 : (tensor<128x128x6xi64>) -> tensor<98304xi64>
    %c_1 = stablehlo.constant dense<0> : tensor<i64>
    %30 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i64>) -> tensor<98304xi64>
    %31 = stablehlo.compare  LT, %29, %30,  SIGNED : (tensor<98304xi64>, tensor<98304xi64>) -> tensor<98304xi1>
    %c_2 = stablehlo.constant dense<16384> : tensor<i64>
    %32 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i64>) -> tensor<98304xi64>
    %33 = stablehlo.add %29, %32 : tensor<98304xi64>
    %34 = stablehlo.select %31, %33, %29 : tensor<98304xi1>, tensor<98304xi64>
    %35 = stablehlo.convert %34 : (tensor<98304xi64>) -> tensor<98304xi32>
    %36 = stablehlo.broadcast_in_dim %35, dims = [0] : (tensor<98304xi32>) -> tensor<98304x1xi32>
    %37 = "stablehlo.gather"(%28, %36) <{dimension_numbers = #stablehlo.gather<collapsed_slice_dims = [0], start_index_map = [0], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 1>}> : (tensor<16384xf64>, tensor<98304x1xi32>) -> tensor<98304xf64>
    %38 = stablehlo.reshape %37 : (tensor<98304xf64>) -> tensor<128x128x6xf64>
    %39 = stablehlo.multiply %13, %13 : tensor<128x128xf64>
    %40 = stablehlo.multiply %39, %13 : tensor<128x128xf64>
    %41 = stablehlo.multiply %40, %13 : tensor<128x128xf64>
    %42 = stablehlo.multiply %41, %13 : tensor<128x128xf64>
    %cst = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %43 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %44 = stablehlo.divide %13, %43 : tensor<128x128xf64>
    %cst_3 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %45 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %46 = stablehlo.divide %39, %45 : tensor<128x128xf64>
    %47 = stablehlo.subtract %44, %46 : tensor<128x128xf64>
    %cst_4 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %48 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %49 = stablehlo.divide %40, %48 : tensor<128x128xf64>
    %50 = stablehlo.subtract %47, %49 : tensor<128x128xf64>
    %cst_5 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %51 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %52 = stablehlo.divide %41, %51 : tensor<128x128xf64>
    %53 = stablehlo.add %50, %52 : tensor<128x128xf64>
    %cst_6 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %54 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %55 = stablehlo.divide %42, %54 : tensor<128x128xf64>
    %56 = stablehlo.subtract %53, %55 : tensor<128x128xf64>
    %cst_7 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %57 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %58 = stablehlo.divide %13, %57 : tensor<128x128xf64>
    %59 = stablehlo.negate %58 : tensor<128x128xf64>
    %cst_8 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %60 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %61 = stablehlo.multiply %60, %39 : tensor<128x128xf64>
    %cst_9 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %62 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %63 = stablehlo.divide %61, %62 : tensor<128x128xf64>
    %64 = stablehlo.add %59, %63 : tensor<128x128xf64>
    %cst_10 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %65 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %66 = stablehlo.divide %40, %65 : tensor<128x128xf64>
    %67 = stablehlo.subtract %64, %66 : tensor<128x128xf64>
    %cst_11 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %68 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %69 = stablehlo.divide %41, %68 : tensor<128x128xf64>
    %70 = stablehlo.subtract %67, %69 : tensor<128x128xf64>
    %cst_12 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %71 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %72 = stablehlo.divide %42, %71 : tensor<128x128xf64>
    %73 = stablehlo.add %70, %72 : tensor<128x128xf64>
    %cst_13 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %74 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %75 = stablehlo.divide %13, %74 : tensor<128x128xf64>
    %cst_14 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %76 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %77 = stablehlo.subtract %76, %75 : tensor<128x128xf64>
    %cst_15 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %78 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %79 = stablehlo.multiply %78, %39 : tensor<128x128xf64>
    %cst_16 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %80 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %81 = stablehlo.divide %79, %80 : tensor<128x128xf64>
    %82 = stablehlo.subtract %77, %81 : tensor<128x128xf64>
    %cst_17 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %83 = stablehlo.broadcast_in_dim %cst_17, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %84 = stablehlo.multiply %83, %40 : tensor<128x128xf64>
    %cst_18 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %85 = stablehlo.broadcast_in_dim %cst_18, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %86 = stablehlo.divide %84, %85 : tensor<128x128xf64>
    %87 = stablehlo.add %82, %86 : tensor<128x128xf64>
    %cst_19 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %88 = stablehlo.broadcast_in_dim %cst_19, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %89 = stablehlo.divide %41, %88 : tensor<128x128xf64>
    %90 = stablehlo.add %87, %89 : tensor<128x128xf64>
    %cst_20 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %91 = stablehlo.broadcast_in_dim %cst_20, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %92 = stablehlo.divide %42, %91 : tensor<128x128xf64>
    %93 = stablehlo.subtract %90, %92 : tensor<128x128xf64>
    %cst_21 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %94 = stablehlo.broadcast_in_dim %cst_21, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %95 = stablehlo.multiply %94, %39 : tensor<128x128xf64>
    %cst_22 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %96 = stablehlo.broadcast_in_dim %cst_22, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %97 = stablehlo.divide %95, %96 : tensor<128x128xf64>
    %98 = stablehlo.add %13, %97 : tensor<128x128xf64>
    %cst_23 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %99 = stablehlo.broadcast_in_dim %cst_23, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %100 = stablehlo.multiply %99, %40 : tensor<128x128xf64>
    %cst_24 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %101 = stablehlo.broadcast_in_dim %cst_24, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %102 = stablehlo.divide %100, %101 : tensor<128x128xf64>
    %103 = stablehlo.subtract %98, %102 : tensor<128x128xf64>
    %cst_25 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %104 = stablehlo.broadcast_in_dim %cst_25, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %105 = stablehlo.divide %41, %104 : tensor<128x128xf64>
    %106 = stablehlo.subtract %103, %105 : tensor<128x128xf64>
    %cst_26 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %107 = stablehlo.broadcast_in_dim %cst_26, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %108 = stablehlo.divide %42, %107 : tensor<128x128xf64>
    %109 = stablehlo.add %106, %108 : tensor<128x128xf64>
    %cst_27 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %110 = stablehlo.broadcast_in_dim %cst_27, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %111 = stablehlo.divide %13, %110 : tensor<128x128xf64>
    %112 = stablehlo.negate %111 : tensor<128x128xf64>
    %cst_28 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %113 = stablehlo.broadcast_in_dim %cst_28, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %114 = stablehlo.divide %39, %113 : tensor<128x128xf64>
    %115 = stablehlo.subtract %112, %114 : tensor<128x128xf64>
    %cst_29 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %116 = stablehlo.broadcast_in_dim %cst_29, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %117 = stablehlo.multiply %116, %40 : tensor<128x128xf64>
    %cst_30 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %118 = stablehlo.broadcast_in_dim %cst_30, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %119 = stablehlo.divide %117, %118 : tensor<128x128xf64>
    %120 = stablehlo.add %115, %119 : tensor<128x128xf64>
    %cst_31 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %121 = stablehlo.broadcast_in_dim %cst_31, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %122 = stablehlo.divide %41, %121 : tensor<128x128xf64>
    %123 = stablehlo.add %120, %122 : tensor<128x128xf64>
    %cst_32 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %124 = stablehlo.broadcast_in_dim %cst_32, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %125 = stablehlo.divide %42, %124 : tensor<128x128xf64>
    %126 = stablehlo.subtract %123, %125 : tensor<128x128xf64>
    %cst_33 = stablehlo.constant dense<3.000000e+01> : tensor<f64>
    %127 = stablehlo.broadcast_in_dim %cst_33, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %128 = stablehlo.divide %13, %127 : tensor<128x128xf64>
    %cst_34 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %129 = stablehlo.broadcast_in_dim %cst_34, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %130 = stablehlo.divide %40, %129 : tensor<128x128xf64>
    %131 = stablehlo.subtract %128, %130 : tensor<128x128xf64>
    %cst_35 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %132 = stablehlo.broadcast_in_dim %cst_35, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %133 = stablehlo.divide %42, %132 : tensor<128x128xf64>
    %134 = stablehlo.add %131, %133 : tensor<128x128xf64>
    %135 = stablehlo.slice %38 [0:128, 0:128, 0:1] : (tensor<128x128x6xf64>) -> tensor<128x128x1xf64>
    %136 = stablehlo.reshape %135 : (tensor<128x128x1xf64>) -> tensor<128x128xf64>
    %137 = stablehlo.multiply %56, %136 : tensor<128x128xf64>
    %138 = stablehlo.slice %38 [0:128, 0:128, 1:2] : (tensor<128x128x6xf64>) -> tensor<128x128x1xf64>
    %139 = stablehlo.reshape %138 : (tensor<128x128x1xf64>) -> tensor<128x128xf64>
    %140 = stablehlo.multiply %73, %139 : tensor<128x128xf64>
    %141 = stablehlo.add %137, %140 : tensor<128x128xf64>
    %142 = stablehlo.slice %38 [0:128, 0:128, 2:3] : (tensor<128x128x6xf64>) -> tensor<128x128x1xf64>
    %143 = stablehlo.reshape %142 : (tensor<128x128x1xf64>) -> tensor<128x128xf64>
    %144 = stablehlo.multiply %93, %143 : tensor<128x128xf64>
    %145 = stablehlo.add %141, %144 : tensor<128x128xf64>
    %146 = stablehlo.slice %38 [0:128, 0:128, 3:4] : (tensor<128x128x6xf64>) -> tensor<128x128x1xf64>
    %147 = stablehlo.reshape %146 : (tensor<128x128x1xf64>) -> tensor<128x128xf64>
    %148 = stablehlo.multiply %109, %147 : tensor<128x128xf64>
    %149 = stablehlo.add %145, %148 : tensor<128x128xf64>
    %150 = stablehlo.slice %38 [0:128, 0:128, 4:5] : (tensor<128x128x6xf64>) -> tensor<128x128x1xf64>
    %151 = stablehlo.reshape %150 : (tensor<128x128x1xf64>) -> tensor<128x128xf64>
    %152 = stablehlo.multiply %126, %151 : tensor<128x128xf64>
    %153 = stablehlo.add %149, %152 : tensor<128x128xf64>
    %154 = stablehlo.slice %38 [0:128, 0:128, 5:6] : (tensor<128x128x6xf64>) -> tensor<128x128x1xf64>
    %155 = stablehlo.reshape %154 : (tensor<128x128x1xf64>) -> tensor<128x128xf64>
    %156 = stablehlo.multiply %134, %155 : tensor<128x128xf64>
    %157 = stablehlo.add %153, %156 : tensor<128x128xf64>
    return %157 : tensor<128x128xf64>
  }
  func.func private @remainder(%arg0: tensor<128x128x6xi32>, %arg1: tensor<i64>) -> tensor<128x128x6xi32> {
    %0 = stablehlo.convert %arg1 : (tensor<i64>) -> tensor<i32>
    %c = stablehlo.constant dense<0> : tensor<i32>
    %1 = stablehlo.compare  EQ, %0, %c,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %2 = call @_where(%1, %c_0, %0) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %4 = stablehlo.remainder %arg0, %3 : tensor<128x128x6xi32>
    %c_1 = stablehlo.constant dense<0> : tensor<i32>
    %5 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %6 = stablehlo.compare  NE, %4, %5,  SIGNED : (tensor<128x128x6xi32>, tensor<128x128x6xi32>) -> tensor<128x128x6xi1>
    %c_2 = stablehlo.constant dense<0> : tensor<i32>
    %7 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %8 = stablehlo.compare  LT, %4, %7,  SIGNED : (tensor<128x128x6xi32>, tensor<128x128x6xi32>) -> tensor<128x128x6xi1>
    %c_3 = stablehlo.constant dense<0> : tensor<i32>
    %9 = stablehlo.compare  LT, %2, %c_3,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %10 = stablehlo.broadcast_in_dim %9, dims = [] : (tensor<i1>) -> tensor<128x128x6xi1>
    %11 = stablehlo.compare  NE, %8, %10,  UNSIGNED : (tensor<128x128x6xi1>, tensor<128x128x6xi1>) -> tensor<128x128x6xi1>
    %12 = stablehlo.and %11, %6 : tensor<128x128x6xi1>
    %13 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %14 = stablehlo.add %4, %13 : tensor<128x128x6xi32>
    %15 = stablehlo.select %12, %14, %4 : tensor<128x128x6xi1>, tensor<128x128x6xi32>
    return %15 : tensor<128x128x6xi32>
  }
  func.func private @_where(%arg0: tensor<i1>, %arg1: tensor<i32>, %arg2: tensor<i32>) -> tensor<i32> {
    %0 = stablehlo.select %arg0, %arg1, %arg2 : tensor<i1>, tensor<i32>
    return %0 : tensor<i32>
  }
  func.func private @solve_poisson(%arg0: tensor<128x128xf64>, %arg1: tensor<65xf64>, %arg2: tensor<f64>) -> (tensor<128xf64>, tensor<128xf64>, tensor<128xf64>) {
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %0 = stablehlo.reduce(%arg0 init: %cst) applies stablehlo.add across dimensions = [1] : (tensor<128x128xf64>, tensor<f64>) -> tensor<128xf64>
    %1 = stablehlo.convert %arg2 : tensor<f64>
    %2 = stablehlo.broadcast_in_dim %1, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %3 = stablehlo.multiply %0, %2 : tensor<128xf64>
    %cst_0 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %4 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %5 = stablehlo.subtract %3, %4 : tensor<128xf64>
    %6 = call @fft(%5) : (tensor<128xf64>) -> tensor<65xcomplex<f64>>
    %cst_1 = stablehlo.constant dense<(-0.000000e+00,-1.000000e+00)> : tensor<complex<f64>>
    %7 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<complex<f64>>) -> tensor<65xcomplex<f64>>
    %8 = stablehlo.multiply %7, %6 : tensor<65xcomplex<f64>>
    %9 = stablehlo.convert %arg1 : (tensor<65xf64>) -> tensor<65xcomplex<f64>>
    %10 = stablehlo.multiply %8, %9 : tensor<65xcomplex<f64>>
    %11 = call @fft_39(%10) : (tensor<65xcomplex<f64>>) -> tensor<128xf64>
    %12 = stablehlo.multiply %arg1, %arg1 : tensor<65xf64>
    %13 = stablehlo.convert %12 : (tensor<65xf64>) -> tensor<65xcomplex<f64>>
    %14 = stablehlo.multiply %6, %13 : tensor<65xcomplex<f64>>
    %15 = call @fft_39(%14) : (tensor<65xcomplex<f64>>) -> tensor<128xf64>
    return %11, %5, %15 : tensor<128xf64>, tensor<128xf64>, tensor<128xf64>
  }
  func.func private @fft(%arg0: tensor<128xf64>) -> tensor<65xcomplex<f64>> {
    %0 = stablehlo.fft %arg0, type =  RFFT, length = [128] : (tensor<128xf64>) -> tensor<65xcomplex<f64>>
    return %0 : tensor<65xcomplex<f64>>
  }
  func.func private @fft_39(%arg0: tensor<65xcomplex<f64>>) -> tensor<128xf64> {
    %0 = stablehlo.fft %arg0, type =  IRFFT, length = [128] : (tensor<65xcomplex<f64>>) -> tensor<128xf64>
    return %0 : tensor<128xf64>
  }
  func.func private @advect_1d_vectorized_41(%arg0: tensor<128x128xf64>, %arg1: tensor<128xf64>, %arg2: tensor<f64>, %arg3: tensor<f64>, %arg4: tensor<6xi32>) -> tensor<128x128xf64> {
    %0 = stablehlo.iota dim = 0 : tensor<128xf64>
    %1 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<128xf64>) -> tensor<128x1xf64>
    %2 = stablehlo.convert %arg2 : tensor<f64>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<f64>) -> tensor<128x1xf64>
    %4 = stablehlo.multiply %1, %3 : tensor<128x1xf64>
    %5 = stablehlo.convert %arg3 : tensor<f64>
    %6 = stablehlo.broadcast_in_dim %5, dims = [] : (tensor<f64>) -> tensor<128x1xf64>
    %7 = stablehlo.divide %4, %6 : tensor<128x1xf64>
    %8 = stablehlo.broadcast_in_dim %0, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %10 = stablehlo.broadcast_in_dim %7, dims = [0, 1] : (tensor<128x1xf64>) -> tensor<128x128xf64>
    %11 = stablehlo.subtract %9, %10 : tensor<128x128xf64>
    %12 = stablehlo.floor %11 : tensor<128x128xf64>
    %13 = stablehlo.subtract %11, %12 : tensor<128x128xf64>
    %14 = stablehlo.convert %12 : (tensor<128x128xf64>) -> tensor<128x128xi32>
    %15 = stablehlo.broadcast_in_dim %14, dims = [0, 1] : (tensor<128x128xi32>) -> tensor<128x128x1xi32>
    %16 = stablehlo.broadcast_in_dim %arg4, dims = [2] : (tensor<6xi32>) -> tensor<1x1x6xi32>
    %17 = stablehlo.broadcast_in_dim %15, dims = [0, 1, 2] : (tensor<128x128x1xi32>) -> tensor<128x128x6xi32>
    %18 = stablehlo.broadcast_in_dim %16, dims = [0, 1, 2] : (tensor<1x1x6xi32>) -> tensor<128x128x6xi32>
    %19 = stablehlo.add %17, %18 : tensor<128x128x6xi32>
    %c = stablehlo.constant dense<0> : tensor<i32>
    %20 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %21 = stablehlo.compare  GE, %19, %20,  SIGNED : (tensor<128x128x6xi32>, tensor<128x128x6xi32>) -> tensor<128x128x6xi1>
    %c_0 = stablehlo.constant dense<128> : tensor<i32>
    %22 = stablehlo.broadcast_in_dim %c_0, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %23 = stablehlo.compare  LT, %19, %22,  SIGNED : (tensor<128x128x6xi32>, tensor<128x128x6xi32>) -> tensor<128x128x6xi1>
    %24 = stablehlo.and %21, %23 : tensor<128x128x6xi1>
    %c_1 = stablehlo.constant dense<0> : tensor<i64>
    %c_2 = stablehlo.constant dense<127> : tensor<i64>
    %25 = call @clip(%19, %c_1, %c_2) : (tensor<128x128x6xi32>, tensor<i64>, tensor<i64>) -> tensor<128x128x6xi32>
    %26 = stablehlo.iota dim = 0 : tensor<128xi64>
    %27 = stablehlo.broadcast_in_dim %26, dims = [0] : (tensor<128xi64>) -> tensor<128x1x1xi64>
    %c_3 = stablehlo.constant dense<128> : tensor<i64>
    %28 = stablehlo.broadcast_in_dim %c_3, dims = [] : (tensor<i64>) -> tensor<128x1x1xi64>
    %29 = stablehlo.multiply %27, %28 : tensor<128x1x1xi64>
    %30 = stablehlo.convert %25 : (tensor<128x128x6xi32>) -> tensor<128x128x6xi64>
    %31 = stablehlo.broadcast_in_dim %29, dims = [0, 1, 2] : (tensor<128x1x1xi64>) -> tensor<128x128x6xi64>
    %32 = stablehlo.add %31, %30 : tensor<128x128x6xi64>
    %33 = stablehlo.reshape %arg0 : (tensor<128x128xf64>) -> tensor<16384xf64>
    %34 = stablehlo.reshape %32 : (tensor<128x128x6xi64>) -> tensor<98304xi64>
    %c_4 = stablehlo.constant dense<0> : tensor<i64>
    %35 = stablehlo.broadcast_in_dim %c_4, dims = [] : (tensor<i64>) -> tensor<98304xi64>
    %36 = stablehlo.compare  LT, %34, %35,  SIGNED : (tensor<98304xi64>, tensor<98304xi64>) -> tensor<98304xi1>
    %c_5 = stablehlo.constant dense<16384> : tensor<i64>
    %37 = stablehlo.broadcast_in_dim %c_5, dims = [] : (tensor<i64>) -> tensor<98304xi64>
    %38 = stablehlo.add %34, %37 : tensor<98304xi64>
    %39 = stablehlo.select %36, %38, %34 : tensor<98304xi1>, tensor<98304xi64>
    %40 = stablehlo.convert %39 : (tensor<98304xi64>) -> tensor<98304xi32>
    %41 = stablehlo.broadcast_in_dim %40, dims = [0] : (tensor<98304xi32>) -> tensor<98304x1xi32>
    %42 = "stablehlo.gather"(%33, %41) <{dimension_numbers = #stablehlo.gather<collapsed_slice_dims = [0], start_index_map = [0], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 1>}> : (tensor<16384xf64>, tensor<98304x1xi32>) -> tensor<98304xf64>
    %43 = stablehlo.reshape %42 : (tensor<98304xf64>) -> tensor<128x128x6xf64>
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %44 = call @_where_42(%24, %43, %cst) : (tensor<128x128x6xi1>, tensor<128x128x6xf64>, tensor<f64>) -> tensor<128x128x6xf64>
    %45 = stablehlo.multiply %13, %13 : tensor<128x128xf64>
    %46 = stablehlo.multiply %45, %13 : tensor<128x128xf64>
    %47 = stablehlo.multiply %46, %13 : tensor<128x128xf64>
    %48 = stablehlo.multiply %47, %13 : tensor<128x128xf64>
    %cst_6 = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %49 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %50 = stablehlo.divide %13, %49 : tensor<128x128xf64>
    %cst_7 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %51 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %52 = stablehlo.divide %45, %51 : tensor<128x128xf64>
    %53 = stablehlo.subtract %50, %52 : tensor<128x128xf64>
    %cst_8 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %54 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %55 = stablehlo.divide %46, %54 : tensor<128x128xf64>
    %56 = stablehlo.subtract %53, %55 : tensor<128x128xf64>
    %cst_9 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %57 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %58 = stablehlo.divide %47, %57 : tensor<128x128xf64>
    %59 = stablehlo.add %56, %58 : tensor<128x128xf64>
    %cst_10 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %60 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %61 = stablehlo.divide %48, %60 : tensor<128x128xf64>
    %62 = stablehlo.subtract %59, %61 : tensor<128x128xf64>
    %cst_11 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %63 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %64 = stablehlo.divide %13, %63 : tensor<128x128xf64>
    %65 = stablehlo.negate %64 : tensor<128x128xf64>
    %cst_12 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %66 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %67 = stablehlo.multiply %66, %45 : tensor<128x128xf64>
    %cst_13 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %68 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %69 = stablehlo.divide %67, %68 : tensor<128x128xf64>
    %70 = stablehlo.add %65, %69 : tensor<128x128xf64>
    %cst_14 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %71 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %72 = stablehlo.divide %46, %71 : tensor<128x128xf64>
    %73 = stablehlo.subtract %70, %72 : tensor<128x128xf64>
    %cst_15 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %74 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %75 = stablehlo.divide %47, %74 : tensor<128x128xf64>
    %76 = stablehlo.subtract %73, %75 : tensor<128x128xf64>
    %cst_16 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %77 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %78 = stablehlo.divide %48, %77 : tensor<128x128xf64>
    %79 = stablehlo.add %76, %78 : tensor<128x128xf64>
    %cst_17 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %80 = stablehlo.broadcast_in_dim %cst_17, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %81 = stablehlo.divide %13, %80 : tensor<128x128xf64>
    %cst_18 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %82 = stablehlo.broadcast_in_dim %cst_18, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %83 = stablehlo.subtract %82, %81 : tensor<128x128xf64>
    %cst_19 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %84 = stablehlo.broadcast_in_dim %cst_19, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %85 = stablehlo.multiply %84, %45 : tensor<128x128xf64>
    %cst_20 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %86 = stablehlo.broadcast_in_dim %cst_20, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %87 = stablehlo.divide %85, %86 : tensor<128x128xf64>
    %88 = stablehlo.subtract %83, %87 : tensor<128x128xf64>
    %cst_21 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %89 = stablehlo.broadcast_in_dim %cst_21, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %90 = stablehlo.multiply %89, %46 : tensor<128x128xf64>
    %cst_22 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %91 = stablehlo.broadcast_in_dim %cst_22, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %92 = stablehlo.divide %90, %91 : tensor<128x128xf64>
    %93 = stablehlo.add %88, %92 : tensor<128x128xf64>
    %cst_23 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %94 = stablehlo.broadcast_in_dim %cst_23, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %95 = stablehlo.divide %47, %94 : tensor<128x128xf64>
    %96 = stablehlo.add %93, %95 : tensor<128x128xf64>
    %cst_24 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %97 = stablehlo.broadcast_in_dim %cst_24, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %98 = stablehlo.divide %48, %97 : tensor<128x128xf64>
    %99 = stablehlo.subtract %96, %98 : tensor<128x128xf64>
    %cst_25 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %100 = stablehlo.broadcast_in_dim %cst_25, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %101 = stablehlo.multiply %100, %45 : tensor<128x128xf64>
    %cst_26 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %102 = stablehlo.broadcast_in_dim %cst_26, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %103 = stablehlo.divide %101, %102 : tensor<128x128xf64>
    %104 = stablehlo.add %13, %103 : tensor<128x128xf64>
    %cst_27 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %105 = stablehlo.broadcast_in_dim %cst_27, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %106 = stablehlo.multiply %105, %46 : tensor<128x128xf64>
    %cst_28 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %107 = stablehlo.broadcast_in_dim %cst_28, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %108 = stablehlo.divide %106, %107 : tensor<128x128xf64>
    %109 = stablehlo.subtract %104, %108 : tensor<128x128xf64>
    %cst_29 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %110 = stablehlo.broadcast_in_dim %cst_29, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %111 = stablehlo.divide %47, %110 : tensor<128x128xf64>
    %112 = stablehlo.subtract %109, %111 : tensor<128x128xf64>
    %cst_30 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %113 = stablehlo.broadcast_in_dim %cst_30, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %114 = stablehlo.divide %48, %113 : tensor<128x128xf64>
    %115 = stablehlo.add %112, %114 : tensor<128x128xf64>
    %cst_31 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %116 = stablehlo.broadcast_in_dim %cst_31, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %117 = stablehlo.divide %13, %116 : tensor<128x128xf64>
    %118 = stablehlo.negate %117 : tensor<128x128xf64>
    %cst_32 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %119 = stablehlo.broadcast_in_dim %cst_32, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %120 = stablehlo.divide %45, %119 : tensor<128x128xf64>
    %121 = stablehlo.subtract %118, %120 : tensor<128x128xf64>
    %cst_33 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %122 = stablehlo.broadcast_in_dim %cst_33, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %123 = stablehlo.multiply %122, %46 : tensor<128x128xf64>
    %cst_34 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %124 = stablehlo.broadcast_in_dim %cst_34, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %125 = stablehlo.divide %123, %124 : tensor<128x128xf64>
    %126 = stablehlo.add %121, %125 : tensor<128x128xf64>
    %cst_35 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %127 = stablehlo.broadcast_in_dim %cst_35, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %128 = stablehlo.divide %47, %127 : tensor<128x128xf64>
    %129 = stablehlo.add %126, %128 : tensor<128x128xf64>
    %cst_36 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %130 = stablehlo.broadcast_in_dim %cst_36, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %131 = stablehlo.divide %48, %130 : tensor<128x128xf64>
    %132 = stablehlo.subtract %129, %131 : tensor<128x128xf64>
    %cst_37 = stablehlo.constant dense<3.000000e+01> : tensor<f64>
    %133 = stablehlo.broadcast_in_dim %cst_37, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %134 = stablehlo.divide %13, %133 : tensor<128x128xf64>
    %cst_38 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %135 = stablehlo.broadcast_in_dim %cst_38, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %136 = stablehlo.divide %46, %135 : tensor<128x128xf64>
    %137 = stablehlo.subtract %134, %136 : tensor<128x128xf64>
    %cst_39 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %138 = stablehlo.broadcast_in_dim %cst_39, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %139 = stablehlo.divide %48, %138 : tensor<128x128xf64>
    %140 = stablehlo.add %137, %139 : tensor<128x128xf64>
    %141 = stablehlo.slice %44 [0:128, 0:128, 0:1] : (tensor<128x128x6xf64>) -> tensor<128x128x1xf64>
    %142 = stablehlo.reshape %141 : (tensor<128x128x1xf64>) -> tensor<128x128xf64>
    %143 = stablehlo.multiply %62, %142 : tensor<128x128xf64>
    %144 = stablehlo.slice %44 [0:128, 0:128, 1:2] : (tensor<128x128x6xf64>) -> tensor<128x128x1xf64>
    %145 = stablehlo.reshape %144 : (tensor<128x128x1xf64>) -> tensor<128x128xf64>
    %146 = stablehlo.multiply %79, %145 : tensor<128x128xf64>
    %147 = stablehlo.add %143, %146 : tensor<128x128xf64>
    %148 = stablehlo.slice %44 [0:128, 0:128, 2:3] : (tensor<128x128x6xf64>) -> tensor<128x128x1xf64>
    %149 = stablehlo.reshape %148 : (tensor<128x128x1xf64>) -> tensor<128x128xf64>
    %150 = stablehlo.multiply %99, %149 : tensor<128x128xf64>
    %151 = stablehlo.add %147, %150 : tensor<128x128xf64>
    %152 = stablehlo.slice %44 [0:128, 0:128, 3:4] : (tensor<128x128x6xf64>) -> tensor<128x128x1xf64>
    %153 = stablehlo.reshape %152 : (tensor<128x128x1xf64>) -> tensor<128x128xf64>
    %154 = stablehlo.multiply %115, %153 : tensor<128x128xf64>
    %155 = stablehlo.add %151, %154 : tensor<128x128xf64>
    %156 = stablehlo.slice %44 [0:128, 0:128, 4:5] : (tensor<128x128x6xf64>) -> tensor<128x128x1xf64>
    %157 = stablehlo.reshape %156 : (tensor<128x128x1xf64>) -> tensor<128x128xf64>
    %158 = stablehlo.multiply %132, %157 : tensor<128x128xf64>
    %159 = stablehlo.add %155, %158 : tensor<128x128xf64>
    %160 = stablehlo.slice %44 [0:128, 0:128, 5:6] : (tensor<128x128x6xf64>) -> tensor<128x128x1xf64>
    %161 = stablehlo.reshape %160 : (tensor<128x128x1xf64>) -> tensor<128x128xf64>
    %162 = stablehlo.multiply %140, %161 : tensor<128x128xf64>
    %163 = stablehlo.add %159, %162 : tensor<128x128xf64>
    return %163 : tensor<128x128xf64>
  }
  func.func private @clip(%arg0: tensor<128x128x6xi32>, %arg1: tensor<i64>, %arg2: tensor<i64>) -> tensor<128x128x6xi32> {
    %0 = stablehlo.convert %arg1 : (tensor<i64>) -> tensor<i32>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %2 = stablehlo.maximum %1, %arg0 : tensor<128x128x6xi32>
    %3 = stablehlo.convert %arg2 : (tensor<i64>) -> tensor<i32>
    %4 = stablehlo.broadcast_in_dim %3, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %5 = stablehlo.minimum %4, %2 : tensor<128x128x6xi32>
    return %5 : tensor<128x128x6xi32>
  }
  func.func private @_where_42(%arg0: tensor<128x128x6xi1>, %arg1: tensor<128x128x6xf64>, %arg2: tensor<f64>) -> tensor<128x128x6xf64> {
    %0 = stablehlo.convert %arg2 : tensor<f64>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f64>) -> tensor<128x128x6xf64>
    %2 = stablehlo.select %arg0, %arg1, %1 : tensor<128x128x6xi1>, tensor<128x128x6xf64>
    return %2 : tensor<128x128x6xf64>
  }
}
