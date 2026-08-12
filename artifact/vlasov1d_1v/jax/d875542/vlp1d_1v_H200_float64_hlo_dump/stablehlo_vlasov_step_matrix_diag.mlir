module @jit__lambda attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<128x128xf64>) -> (tensor<128x128xf64> {jax.result_info = "result[0]"}, tensor<128xf64> {jax.result_info = "result[1]"}, tensor<128xf64> {jax.result_info = "result[2]"}) {
    %cst = stablehlo.constant dense<"0x00000000000014C0ECF57ABD5EAF13C0D8EBF57ABD5E13C0C4E170381C0E13C0B0D7EBF57ABD12C09BCD66B3D96C12C087C3E170381C12C072B95C2E97CB11C05EAFD7EBF57A11C04AA552A9542A11C0369BCD66B3D910C022914824128910C00E87C3E1703810C0F4F97C3E9FCF0FC0CCE572B95C2E0FC0A4D168341A8D0EC07CBD5EAFD7EB0DC053A9542A954A0DC02B954AA552A90CC00381402010080CC0DB6C369BCD660BC0B3582C168BC50AC08844229148240AC06030180C068309C0381C0E87C3E108C010080402814008C0E8F3F97C3E9F07C0BFDFEFF7FBFD06C096CBE572B95C06C06EB7DBED76BB05C046A3D168341A05C01E8FC7E3F17804C0F67ABD5EAFD703C0CE66B3D96C3603C0A652A9542A9502C07E3E9FCFE7F301C0562A954AA55201C02D168BC562B100C004028140201000C0B8DBED76BBDDFEBF68B3D96C369BFDBF178BC562B158FCBFC762B1582C16FBBF733A9D4EA7D3F9BF221289442291F8BFD2E9743A9D4EF7BF82C16030180CF6BF31994C2693C9F4BFE170381C0E87F3BF914824128944F2BF402010080402F1BFE0EFF7FBFD7EEFBF409FCFE7F3F9ECBFA04EA7D3E974EABFFCFD7EBFDFEFE7BF58AD56ABD56AE5BFB85C2E97CBE5E2BF180C0683C160E0BFF076BBDD6EB7DBBFA8D56AB55AADD6BF68341A8D46A3D1BF402693C96432C9BF80C7E3F1783CBEBF008542A15028A4BF008542A15028A43F80C7E3F1783CBE3F402693C96432C93F60341A8D46A3D13FA8D56AB55AADD63FF076BBDD6EB7DB3F180C0683C160E03FB85C2E97CBE5E23F58AD56ABD56AE53FF8FD7EBFDFEFE73F9C4EA7D3E974EA3F3C9FCFE7F3F9EC3FE0EFF7FBFD7EEF3F412010080402F13F914824128944F23FE170381C0E87F33F31994C2693C9F43F83C16030180CF63FD3E9743A9D4EF73F231289442291F83F733A9D4EA7D3F93FC662B1582C16FB3F168BC562B158FC3F68B3D96C369BFD3FB8DBED76BBDDFE3F04028140201000402C168BC562B10040542A954AA55201407D3E9FCFE7F30140A652A9542A950240CE66B3D96C360340F67ABD5EAFD703401E8FC7E3F178044046A3D168341A05406EB7DBED76BB054096CBE572B95C0640BFDFEFF7FBFD0640E8F3F97C3E9F07401008040281400840381C0E87C3E108406030180C068309408844229148240A40B0582C168BC50A40D86C369BCD660B400281402010080C402C954AA552A90C4054A9542A954A0D407CBD5EAFD7EB0D40A4D168341A8D0E40CCE572B95C2E0F40F4F97C3E9FCF0F400E87C3E1703810402291482412891040369BCD66B3D910404AA552A9542A11405EAFD7EBF57A114072B95C2E97CB114086C3E170381C12409BCD66B3D96C1240AFD7EBF57ABD1240C4E170381C0E1340D8EBF57ABD5E1340ECF57ABD5EAF13400000000000001440"> : tensor<128xf64>
    %c = stablehlo.constant dense<[-2, -1, 0, 1, 2, 3]> : tensor<6xi32>
    %cst_0 = stablehlo.constant dense<[0.000000e+00, 2.000000e+00, 1.000000e+00, 0.66666666666666663, 5.000000e-01, 4.000000e-01, 0.33333333333333331, 0.2857142857142857, 2.500000e-01, 0.22222222222222221, 2.000000e-01, 0.18181818181818182, 0.16666666666666666, 0.15384615384615385, 0.14285714285714285, 0.13333333333333333, 1.250000e-01, 0.11764705882352941, 0.1111111111111111, 0.10526315789473684, 1.000000e-01, 0.095238095238095233, 0.090909090909090911, 0.086956521739130432, 0.083333333333333329, 8.000000e-02, 0.076923076923076927, 0.074074074074074084, 0.071428571428571425, 0.068965517241379296, 0.066666666666666666, 0.064516129032258063, 6.250000e-02, 0.060606060606060608, 0.058823529411764705, 0.057142857142857141, 0.055555555555555552, 0.054054054054054057, 0.052631578947368418, 0.05128205128205128, 5.000000e-02, 0.04878048780487805, 0.047619047619047616, 0.046511627906976744, 0.045454545454545456, 0.044444444444444446, 0.043478260869565216, 0.042553191489361701, 0.041666666666666664, 0.040816326530612242, 4.000000e-02, 0.039215686274509803, 0.038461538461538464, 0.037735849056603779, 0.037037037037037042, 0.036363636363636369, 0.035714285714285712, 0.035087719298245612, 0.034482758620689648, 0.033898305084745756, 0.033333333333333333, 0.032786885245901641, 0.032258064516129031, 0.031746031746031744, 3.125000e-02]> : tensor<65xf64>
    %cst_1 = stablehlo.constant dense<2.500000e-02> : tensor<f64>
    %cst_2 = stablehlo.constant dense<0.098174770424681035> : tensor<f64>
    %0 = call @advect_1d_matrix_diag(%arg0, %cst, %cst_1, %cst_2, %c) : (tensor<128x128xf64>, tensor<128xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<128x128xf64>
    %cst_3 = stablehlo.constant dense<0.078740157480314959> : tensor<f64>
    %1:3 = call @solve_poisson(%0, %cst_0, %cst_3) : (tensor<128x128xf64>, tensor<65xf64>, tensor<f64>) -> (tensor<128xf64>, tensor<128xf64>, tensor<128xf64>)
    %cst_4 = stablehlo.constant dense<5.000000e-02> : tensor<f64>
    %cst_5 = stablehlo.constant dense<0.078740157480314959> : tensor<f64>
    %2 = call @advect_1d_matrix_diag_35(%0, %1#0, %cst_4, %cst_5, %c) : (tensor<128x128xf64>, tensor<128xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<128x128xf64>
    %cst_6 = stablehlo.constant dense<2.500000e-02> : tensor<f64>
    %cst_7 = stablehlo.constant dense<0.098174770424681035> : tensor<f64>
    %3 = call @advect_1d_matrix_diag(%2, %cst, %cst_6, %cst_7, %c) : (tensor<128x128xf64>, tensor<128xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<128x128xf64>
    return %3, %1#1, %1#2 : tensor<128x128xf64>, tensor<128xf64>, tensor<128xf64>
  }
  func.func private @advect_1d_matrix_diag(%arg0: tensor<128x128xf64>, %arg1: tensor<128xf64>, %arg2: tensor<f64>, %arg3: tensor<f64>, %arg4: tensor<6xi32>) -> tensor<128x128xf64> {
    %0 = stablehlo.convert %arg2 : tensor<f64>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %2 = stablehlo.multiply %arg1, %1 : tensor<128xf64>
    %3 = stablehlo.convert %arg3 : tensor<f64>
    %4 = stablehlo.broadcast_in_dim %3, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %5 = stablehlo.divide %2, %4 : tensor<128xf64>
    %6 = stablehlo.floor %5 : tensor<128xf64>
    %7 = stablehlo.subtract %5, %6 : tensor<128xf64>
    %8 = stablehlo.convert %6 : (tensor<128xf64>) -> tensor<128xi32>
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %9 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %10 = stablehlo.multiply %7, %7 : tensor<128xf64>
    %11 = stablehlo.multiply %10, %7 : tensor<128xf64>
    %12 = stablehlo.multiply %11, %7 : tensor<128xf64>
    %13 = stablehlo.multiply %12, %7 : tensor<128xf64>
    %cst_0 = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %14 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %15 = stablehlo.divide %7, %14 : tensor<128xf64>
    %cst_1 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %16 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %17 = stablehlo.divide %10, %16 : tensor<128xf64>
    %18 = stablehlo.subtract %15, %17 : tensor<128xf64>
    %cst_2 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %19 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %20 = stablehlo.divide %11, %19 : tensor<128xf64>
    %21 = stablehlo.subtract %18, %20 : tensor<128xf64>
    %cst_3 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %22 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %23 = stablehlo.divide %12, %22 : tensor<128xf64>
    %24 = stablehlo.add %21, %23 : tensor<128xf64>
    %cst_4 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %25 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %26 = stablehlo.divide %13, %25 : tensor<128xf64>
    %27 = stablehlo.subtract %24, %26 : tensor<128xf64>
    %cst_5 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %28 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %29 = stablehlo.divide %7, %28 : tensor<128xf64>
    %30 = stablehlo.negate %29 : tensor<128xf64>
    %cst_6 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %31 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %32 = stablehlo.multiply %31, %10 : tensor<128xf64>
    %cst_7 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %33 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %34 = stablehlo.divide %32, %33 : tensor<128xf64>
    %35 = stablehlo.add %30, %34 : tensor<128xf64>
    %cst_8 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %36 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %37 = stablehlo.divide %11, %36 : tensor<128xf64>
    %38 = stablehlo.subtract %35, %37 : tensor<128xf64>
    %cst_9 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %39 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %40 = stablehlo.divide %12, %39 : tensor<128xf64>
    %41 = stablehlo.subtract %38, %40 : tensor<128xf64>
    %cst_10 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %42 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %43 = stablehlo.divide %13, %42 : tensor<128xf64>
    %44 = stablehlo.add %41, %43 : tensor<128xf64>
    %cst_11 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %45 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %46 = stablehlo.divide %7, %45 : tensor<128xf64>
    %cst_12 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %47 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %48 = stablehlo.subtract %47, %46 : tensor<128xf64>
    %cst_13 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %49 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %50 = stablehlo.multiply %49, %10 : tensor<128xf64>
    %cst_14 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %51 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %52 = stablehlo.divide %50, %51 : tensor<128xf64>
    %53 = stablehlo.subtract %48, %52 : tensor<128xf64>
    %cst_15 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %54 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %55 = stablehlo.multiply %54, %11 : tensor<128xf64>
    %cst_16 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %56 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %57 = stablehlo.divide %55, %56 : tensor<128xf64>
    %58 = stablehlo.add %53, %57 : tensor<128xf64>
    %cst_17 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %59 = stablehlo.broadcast_in_dim %cst_17, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %60 = stablehlo.divide %12, %59 : tensor<128xf64>
    %61 = stablehlo.add %58, %60 : tensor<128xf64>
    %cst_18 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %62 = stablehlo.broadcast_in_dim %cst_18, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %63 = stablehlo.divide %13, %62 : tensor<128xf64>
    %64 = stablehlo.subtract %61, %63 : tensor<128xf64>
    %cst_19 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %65 = stablehlo.broadcast_in_dim %cst_19, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %66 = stablehlo.multiply %65, %10 : tensor<128xf64>
    %cst_20 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %67 = stablehlo.broadcast_in_dim %cst_20, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %68 = stablehlo.divide %66, %67 : tensor<128xf64>
    %69 = stablehlo.add %7, %68 : tensor<128xf64>
    %cst_21 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %70 = stablehlo.broadcast_in_dim %cst_21, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %71 = stablehlo.multiply %70, %11 : tensor<128xf64>
    %cst_22 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %72 = stablehlo.broadcast_in_dim %cst_22, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %73 = stablehlo.divide %71, %72 : tensor<128xf64>
    %74 = stablehlo.subtract %69, %73 : tensor<128xf64>
    %cst_23 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %75 = stablehlo.broadcast_in_dim %cst_23, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %76 = stablehlo.divide %12, %75 : tensor<128xf64>
    %77 = stablehlo.subtract %74, %76 : tensor<128xf64>
    %cst_24 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %78 = stablehlo.broadcast_in_dim %cst_24, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %79 = stablehlo.divide %13, %78 : tensor<128xf64>
    %80 = stablehlo.add %77, %79 : tensor<128xf64>
    %cst_25 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %81 = stablehlo.broadcast_in_dim %cst_25, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %82 = stablehlo.divide %7, %81 : tensor<128xf64>
    %83 = stablehlo.negate %82 : tensor<128xf64>
    %cst_26 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %84 = stablehlo.broadcast_in_dim %cst_26, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %85 = stablehlo.divide %10, %84 : tensor<128xf64>
    %86 = stablehlo.subtract %83, %85 : tensor<128xf64>
    %cst_27 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %87 = stablehlo.broadcast_in_dim %cst_27, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %88 = stablehlo.multiply %87, %11 : tensor<128xf64>
    %cst_28 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %89 = stablehlo.broadcast_in_dim %cst_28, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %90 = stablehlo.divide %88, %89 : tensor<128xf64>
    %91 = stablehlo.add %86, %90 : tensor<128xf64>
    %cst_29 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %92 = stablehlo.broadcast_in_dim %cst_29, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %93 = stablehlo.divide %12, %92 : tensor<128xf64>
    %94 = stablehlo.add %91, %93 : tensor<128xf64>
    %cst_30 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %95 = stablehlo.broadcast_in_dim %cst_30, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %96 = stablehlo.divide %13, %95 : tensor<128xf64>
    %97 = stablehlo.subtract %94, %96 : tensor<128xf64>
    %cst_31 = stablehlo.constant dense<3.000000e+01> : tensor<f64>
    %98 = stablehlo.broadcast_in_dim %cst_31, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %99 = stablehlo.divide %7, %98 : tensor<128xf64>
    %cst_32 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %100 = stablehlo.broadcast_in_dim %cst_32, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %101 = stablehlo.divide %11, %100 : tensor<128xf64>
    %102 = stablehlo.subtract %99, %101 : tensor<128xf64>
    %cst_33 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %103 = stablehlo.broadcast_in_dim %cst_33, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %104 = stablehlo.divide %13, %103 : tensor<128xf64>
    %105 = stablehlo.add %102, %104 : tensor<128xf64>
    %106 = stablehlo.broadcast_in_dim %27, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %107 = stablehlo.broadcast_in_dim %44, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %108 = stablehlo.broadcast_in_dim %64, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %109 = stablehlo.broadcast_in_dim %80, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %110 = stablehlo.broadcast_in_dim %97, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %111 = stablehlo.broadcast_in_dim %105, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %112 = stablehlo.concatenate %106, %107, %108, %109, %110, %111, dim = 0 : (tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>) -> tensor<6x128xf64>
    %113 = stablehlo.slice %arg4 [0:1] : (tensor<6xi32>) -> tensor<1xi32>
    %114 = stablehlo.reshape %113 : (tensor<1xi32>) -> tensor<i32>
    %115 = stablehlo.broadcast_in_dim %114, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %116 = stablehlo.add %8, %115 : tensor<128xi32>
    %117 = call @_roll_dynamic(%arg0, %116) : (tensor<128x128xf64>, tensor<128xi32>) -> tensor<128x128xf64>
    %118 = stablehlo.transpose %117, dims = [1, 0] : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %119 = stablehlo.slice %112 [0:1, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %120 = stablehlo.reshape %119 : (tensor<1x128xf64>) -> tensor<128xf64>
    %121 = stablehlo.broadcast_in_dim %120, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %122 = stablehlo.broadcast_in_dim %121, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %123 = stablehlo.multiply %118, %122 : tensor<128x128xf64>
    %124 = stablehlo.add %9, %123 : tensor<128x128xf64>
    %125 = stablehlo.slice %arg4 [1:2] : (tensor<6xi32>) -> tensor<1xi32>
    %126 = stablehlo.reshape %125 : (tensor<1xi32>) -> tensor<i32>
    %127 = stablehlo.broadcast_in_dim %126, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %128 = stablehlo.add %8, %127 : tensor<128xi32>
    %129 = call @_roll_dynamic(%arg0, %128) : (tensor<128x128xf64>, tensor<128xi32>) -> tensor<128x128xf64>
    %130 = stablehlo.transpose %129, dims = [1, 0] : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %131 = stablehlo.slice %112 [1:2, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %132 = stablehlo.reshape %131 : (tensor<1x128xf64>) -> tensor<128xf64>
    %133 = stablehlo.broadcast_in_dim %132, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %134 = stablehlo.broadcast_in_dim %133, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %135 = stablehlo.multiply %130, %134 : tensor<128x128xf64>
    %136 = stablehlo.add %124, %135 : tensor<128x128xf64>
    %137 = stablehlo.slice %arg4 [2:3] : (tensor<6xi32>) -> tensor<1xi32>
    %138 = stablehlo.reshape %137 : (tensor<1xi32>) -> tensor<i32>
    %139 = stablehlo.broadcast_in_dim %138, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %140 = stablehlo.add %8, %139 : tensor<128xi32>
    %141 = call @_roll_dynamic(%arg0, %140) : (tensor<128x128xf64>, tensor<128xi32>) -> tensor<128x128xf64>
    %142 = stablehlo.transpose %141, dims = [1, 0] : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %143 = stablehlo.slice %112 [2:3, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %144 = stablehlo.reshape %143 : (tensor<1x128xf64>) -> tensor<128xf64>
    %145 = stablehlo.broadcast_in_dim %144, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %146 = stablehlo.broadcast_in_dim %145, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %147 = stablehlo.multiply %142, %146 : tensor<128x128xf64>
    %148 = stablehlo.add %136, %147 : tensor<128x128xf64>
    %149 = stablehlo.slice %arg4 [3:4] : (tensor<6xi32>) -> tensor<1xi32>
    %150 = stablehlo.reshape %149 : (tensor<1xi32>) -> tensor<i32>
    %151 = stablehlo.broadcast_in_dim %150, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %152 = stablehlo.add %8, %151 : tensor<128xi32>
    %153 = call @_roll_dynamic(%arg0, %152) : (tensor<128x128xf64>, tensor<128xi32>) -> tensor<128x128xf64>
    %154 = stablehlo.transpose %153, dims = [1, 0] : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %155 = stablehlo.slice %112 [3:4, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %156 = stablehlo.reshape %155 : (tensor<1x128xf64>) -> tensor<128xf64>
    %157 = stablehlo.broadcast_in_dim %156, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %158 = stablehlo.broadcast_in_dim %157, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %159 = stablehlo.multiply %154, %158 : tensor<128x128xf64>
    %160 = stablehlo.add %148, %159 : tensor<128x128xf64>
    %161 = stablehlo.slice %arg4 [4:5] : (tensor<6xi32>) -> tensor<1xi32>
    %162 = stablehlo.reshape %161 : (tensor<1xi32>) -> tensor<i32>
    %163 = stablehlo.broadcast_in_dim %162, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %164 = stablehlo.add %8, %163 : tensor<128xi32>
    %165 = call @_roll_dynamic(%arg0, %164) : (tensor<128x128xf64>, tensor<128xi32>) -> tensor<128x128xf64>
    %166 = stablehlo.transpose %165, dims = [1, 0] : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %167 = stablehlo.slice %112 [4:5, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %168 = stablehlo.reshape %167 : (tensor<1x128xf64>) -> tensor<128xf64>
    %169 = stablehlo.broadcast_in_dim %168, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %170 = stablehlo.broadcast_in_dim %169, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %171 = stablehlo.multiply %166, %170 : tensor<128x128xf64>
    %172 = stablehlo.add %160, %171 : tensor<128x128xf64>
    %173 = stablehlo.slice %arg4 [5:6] : (tensor<6xi32>) -> tensor<1xi32>
    %174 = stablehlo.reshape %173 : (tensor<1xi32>) -> tensor<i32>
    %175 = stablehlo.broadcast_in_dim %174, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %176 = stablehlo.add %8, %175 : tensor<128xi32>
    %177 = call @_roll_dynamic(%arg0, %176) : (tensor<128x128xf64>, tensor<128xi32>) -> tensor<128x128xf64>
    %178 = stablehlo.transpose %177, dims = [1, 0] : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %179 = stablehlo.slice %112 [5:6, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %180 = stablehlo.reshape %179 : (tensor<1x128xf64>) -> tensor<128xf64>
    %181 = stablehlo.broadcast_in_dim %180, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %182 = stablehlo.broadcast_in_dim %181, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %183 = stablehlo.multiply %178, %182 : tensor<128x128xf64>
    %184 = stablehlo.add %172, %183 : tensor<128x128xf64>
    return %184 : tensor<128x128xf64>
  }
  func.func private @_roll_dynamic(%arg0: tensor<128x128xf64>, %arg1: tensor<128xi32>) -> tensor<128x128xf64> {
    %0 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<128xi32>) -> tensor<128x1xi32>
    %1 = stablehlo.slice %0 [0:128, 0:1] : (tensor<128x1xi32>) -> tensor<128x1xi32>
    %2 = stablehlo.reshape %1 : (tensor<128x1xi32>) -> tensor<128xi32>
    %c = stablehlo.constant dense<128> : tensor<i32>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %3 = stablehlo.maximum %c, %c_0 : tensor<i32>
    %4 = call @remainder(%2, %3) : (tensor<128xi32>, tensor<i32>) -> tensor<128xi32>
    %5 = stablehlo.transpose %arg0, dims = [1, 0] : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %6 = stablehlo.transpose %arg0, dims = [1, 0] : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %7 = stablehlo.concatenate %5, %6, dim = 1 : (tensor<128x128xf64>, tensor<128x128xf64>) -> tensor<128x256xf64>
    %c_1 = stablehlo.constant dense<128> : tensor<i32>
    %8 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %9 = stablehlo.subtract %8, %4 : tensor<128xi32>
    %c_2 = stablehlo.constant dense<0> : tensor<i32>
    %10 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %11 = stablehlo.compare  LT, %9, %10,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %c_3 = stablehlo.constant dense<256> : tensor<i32>
    %12 = stablehlo.broadcast_in_dim %c_3, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %13 = stablehlo.add %9, %12 : tensor<128xi32>
    %14 = stablehlo.select %11, %13, %9 : tensor<128xi1>, tensor<128xi32>
    %15 = stablehlo.broadcast_in_dim %14, dims = [0] : (tensor<128xi32>) -> tensor<128x1xi32>
    %16 = "stablehlo.gather"(%7, %15) <{dimension_numbers = #stablehlo.gather<offset_dims = [1], operand_batching_dims = [0], start_indices_batching_dims = [0], start_index_map = [1], index_vector_dim = 1>, indices_are_sorted = true, slice_sizes = array<i64: 1, 128>}> : (tensor<128x256xf64>, tensor<128x1xi32>) -> tensor<128x128xf64>
    return %16 : tensor<128x128xf64>
  }
  func.func private @remainder(%arg0: tensor<128xi32>, %arg1: tensor<i32>) -> tensor<128xi32> {
    %c = stablehlo.constant dense<0> : tensor<i32>
    %0 = stablehlo.compare  EQ, %arg1, %c,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %1 = call @_where(%0, %c_0, %arg1) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
    %2 = stablehlo.broadcast_in_dim %1, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %3 = stablehlo.remainder %arg0, %2 : tensor<128xi32>
    %c_1 = stablehlo.constant dense<0> : tensor<i32>
    %4 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %5 = stablehlo.compare  NE, %3, %4,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %c_2 = stablehlo.constant dense<0> : tensor<i32>
    %6 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %7 = stablehlo.compare  LT, %3, %6,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %c_3 = stablehlo.constant dense<0> : tensor<i32>
    %8 = stablehlo.compare  LT, %1, %c_3,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %9 = stablehlo.broadcast_in_dim %8, dims = [] : (tensor<i1>) -> tensor<128xi1>
    %10 = stablehlo.compare  NE, %7, %9,  UNSIGNED : (tensor<128xi1>, tensor<128xi1>) -> tensor<128xi1>
    %11 = stablehlo.and %10, %5 : tensor<128xi1>
    %12 = stablehlo.broadcast_in_dim %1, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %13 = stablehlo.add %3, %12 : tensor<128xi32>
    %14 = stablehlo.select %11, %13, %3 : tensor<128xi1>, tensor<128xi32>
    return %14 : tensor<128xi32>
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
    %11 = call @fft_33(%10) : (tensor<65xcomplex<f64>>) -> tensor<128xf64>
    %12 = stablehlo.multiply %arg1, %arg1 : tensor<65xf64>
    %13 = stablehlo.convert %12 : (tensor<65xf64>) -> tensor<65xcomplex<f64>>
    %14 = stablehlo.multiply %6, %13 : tensor<65xcomplex<f64>>
    %15 = call @fft_33(%14) : (tensor<65xcomplex<f64>>) -> tensor<128xf64>
    return %11, %5, %15 : tensor<128xf64>, tensor<128xf64>, tensor<128xf64>
  }
  func.func private @fft(%arg0: tensor<128xf64>) -> tensor<65xcomplex<f64>> {
    %0 = stablehlo.fft %arg0, type =  RFFT, length = [128] : (tensor<128xf64>) -> tensor<65xcomplex<f64>>
    return %0 : tensor<65xcomplex<f64>>
  }
  func.func private @fft_33(%arg0: tensor<65xcomplex<f64>>) -> tensor<128xf64> {
    %0 = stablehlo.fft %arg0, type =  IRFFT, length = [128] : (tensor<65xcomplex<f64>>) -> tensor<128xf64>
    return %0 : tensor<128xf64>
  }
  func.func private @advect_1d_matrix_diag_35(%arg0: tensor<128x128xf64>, %arg1: tensor<128xf64>, %arg2: tensor<f64>, %arg3: tensor<f64>, %arg4: tensor<6xi32>) -> tensor<128x128xf64> {
    %0 = stablehlo.convert %arg2 : tensor<f64>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %2 = stablehlo.multiply %arg1, %1 : tensor<128xf64>
    %3 = stablehlo.convert %arg3 : tensor<f64>
    %4 = stablehlo.broadcast_in_dim %3, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %5 = stablehlo.divide %2, %4 : tensor<128xf64>
    %6 = stablehlo.floor %5 : tensor<128xf64>
    %7 = stablehlo.subtract %5, %6 : tensor<128xf64>
    %8 = stablehlo.convert %6 : (tensor<128xf64>) -> tensor<128xi32>
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %9 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %10 = call @build_v_diag_weights(%arg4, %8, %7) : (tensor<6xi32>, tensor<128xi32>, tensor<128xf64>) -> tensor<6x128x128xf64>
    %11 = stablehlo.slice %arg4 [0:1] : (tensor<6xi32>) -> tensor<1xi32>
    %12 = stablehlo.reshape %11 : (tensor<1xi32>) -> tensor<i32>
    %13 = stablehlo.broadcast_in_dim %12, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %14 = stablehlo.add %8, %13 : tensor<128xi32>
    %15 = call @_roll_dynamic_50(%arg0, %14) : (tensor<128x128xf64>, tensor<128xi32>) -> tensor<128x128xf64>
    %16 = stablehlo.slice %10 [0:1, 0:128, 0:128] : (tensor<6x128x128xf64>) -> tensor<1x128x128xf64>
    %17 = stablehlo.reshape %16 : (tensor<1x128x128xf64>) -> tensor<128x128xf64>
    %18 = stablehlo.multiply %17, %15 : tensor<128x128xf64>
    %19 = stablehlo.add %9, %18 : tensor<128x128xf64>
    %20 = stablehlo.slice %arg4 [1:2] : (tensor<6xi32>) -> tensor<1xi32>
    %21 = stablehlo.reshape %20 : (tensor<1xi32>) -> tensor<i32>
    %22 = stablehlo.broadcast_in_dim %21, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %23 = stablehlo.add %8, %22 : tensor<128xi32>
    %24 = call @_roll_dynamic_50(%arg0, %23) : (tensor<128x128xf64>, tensor<128xi32>) -> tensor<128x128xf64>
    %25 = stablehlo.slice %10 [1:2, 0:128, 0:128] : (tensor<6x128x128xf64>) -> tensor<1x128x128xf64>
    %26 = stablehlo.reshape %25 : (tensor<1x128x128xf64>) -> tensor<128x128xf64>
    %27 = stablehlo.multiply %26, %24 : tensor<128x128xf64>
    %28 = stablehlo.add %19, %27 : tensor<128x128xf64>
    %29 = stablehlo.slice %arg4 [2:3] : (tensor<6xi32>) -> tensor<1xi32>
    %30 = stablehlo.reshape %29 : (tensor<1xi32>) -> tensor<i32>
    %31 = stablehlo.broadcast_in_dim %30, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %32 = stablehlo.add %8, %31 : tensor<128xi32>
    %33 = call @_roll_dynamic_50(%arg0, %32) : (tensor<128x128xf64>, tensor<128xi32>) -> tensor<128x128xf64>
    %34 = stablehlo.slice %10 [2:3, 0:128, 0:128] : (tensor<6x128x128xf64>) -> tensor<1x128x128xf64>
    %35 = stablehlo.reshape %34 : (tensor<1x128x128xf64>) -> tensor<128x128xf64>
    %36 = stablehlo.multiply %35, %33 : tensor<128x128xf64>
    %37 = stablehlo.add %28, %36 : tensor<128x128xf64>
    %38 = stablehlo.slice %arg4 [3:4] : (tensor<6xi32>) -> tensor<1xi32>
    %39 = stablehlo.reshape %38 : (tensor<1xi32>) -> tensor<i32>
    %40 = stablehlo.broadcast_in_dim %39, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %41 = stablehlo.add %8, %40 : tensor<128xi32>
    %42 = call @_roll_dynamic_50(%arg0, %41) : (tensor<128x128xf64>, tensor<128xi32>) -> tensor<128x128xf64>
    %43 = stablehlo.slice %10 [3:4, 0:128, 0:128] : (tensor<6x128x128xf64>) -> tensor<1x128x128xf64>
    %44 = stablehlo.reshape %43 : (tensor<1x128x128xf64>) -> tensor<128x128xf64>
    %45 = stablehlo.multiply %44, %42 : tensor<128x128xf64>
    %46 = stablehlo.add %37, %45 : tensor<128x128xf64>
    %47 = stablehlo.slice %arg4 [4:5] : (tensor<6xi32>) -> tensor<1xi32>
    %48 = stablehlo.reshape %47 : (tensor<1xi32>) -> tensor<i32>
    %49 = stablehlo.broadcast_in_dim %48, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %50 = stablehlo.add %8, %49 : tensor<128xi32>
    %51 = call @_roll_dynamic_50(%arg0, %50) : (tensor<128x128xf64>, tensor<128xi32>) -> tensor<128x128xf64>
    %52 = stablehlo.slice %10 [4:5, 0:128, 0:128] : (tensor<6x128x128xf64>) -> tensor<1x128x128xf64>
    %53 = stablehlo.reshape %52 : (tensor<1x128x128xf64>) -> tensor<128x128xf64>
    %54 = stablehlo.multiply %53, %51 : tensor<128x128xf64>
    %55 = stablehlo.add %46, %54 : tensor<128x128xf64>
    %56 = stablehlo.slice %arg4 [5:6] : (tensor<6xi32>) -> tensor<1xi32>
    %57 = stablehlo.reshape %56 : (tensor<1xi32>) -> tensor<i32>
    %58 = stablehlo.broadcast_in_dim %57, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %59 = stablehlo.add %8, %58 : tensor<128xi32>
    %60 = call @_roll_dynamic_50(%arg0, %59) : (tensor<128x128xf64>, tensor<128xi32>) -> tensor<128x128xf64>
    %61 = stablehlo.slice %10 [5:6, 0:128, 0:128] : (tensor<6x128x128xf64>) -> tensor<1x128x128xf64>
    %62 = stablehlo.reshape %61 : (tensor<1x128x128xf64>) -> tensor<128x128xf64>
    %63 = stablehlo.multiply %62, %60 : tensor<128x128xf64>
    %64 = stablehlo.add %55, %63 : tensor<128x128xf64>
    return %64 : tensor<128x128xf64>
  }
  func.func private @build_v_diag_weights(%arg0: tensor<6xi32>, %arg1: tensor<128xi32>, %arg2: tensor<128xf64>) -> tensor<6x128x128xf64> {
    %0 = stablehlo.multiply %arg2, %arg2 : tensor<128xf64>
    %1 = stablehlo.multiply %0, %arg2 : tensor<128xf64>
    %2 = stablehlo.multiply %1, %arg2 : tensor<128xf64>
    %3 = stablehlo.multiply %2, %arg2 : tensor<128xf64>
    %cst = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %4 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %5 = stablehlo.divide %arg2, %4 : tensor<128xf64>
    %cst_0 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %6 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %7 = stablehlo.divide %0, %6 : tensor<128xf64>
    %8 = stablehlo.subtract %5, %7 : tensor<128xf64>
    %cst_1 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %9 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %10 = stablehlo.divide %1, %9 : tensor<128xf64>
    %11 = stablehlo.subtract %8, %10 : tensor<128xf64>
    %cst_2 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %12 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %13 = stablehlo.divide %2, %12 : tensor<128xf64>
    %14 = stablehlo.add %11, %13 : tensor<128xf64>
    %cst_3 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %15 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %16 = stablehlo.divide %3, %15 : tensor<128xf64>
    %17 = stablehlo.subtract %14, %16 : tensor<128xf64>
    %cst_4 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %18 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %19 = stablehlo.divide %arg2, %18 : tensor<128xf64>
    %20 = stablehlo.negate %19 : tensor<128xf64>
    %cst_5 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %21 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %22 = stablehlo.multiply %21, %0 : tensor<128xf64>
    %cst_6 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %23 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %24 = stablehlo.divide %22, %23 : tensor<128xf64>
    %25 = stablehlo.add %20, %24 : tensor<128xf64>
    %cst_7 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %26 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %27 = stablehlo.divide %1, %26 : tensor<128xf64>
    %28 = stablehlo.subtract %25, %27 : tensor<128xf64>
    %cst_8 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %29 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %30 = stablehlo.divide %2, %29 : tensor<128xf64>
    %31 = stablehlo.subtract %28, %30 : tensor<128xf64>
    %cst_9 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %32 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %33 = stablehlo.divide %3, %32 : tensor<128xf64>
    %34 = stablehlo.add %31, %33 : tensor<128xf64>
    %cst_10 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %35 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %36 = stablehlo.divide %arg2, %35 : tensor<128xf64>
    %cst_11 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %37 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %38 = stablehlo.subtract %37, %36 : tensor<128xf64>
    %cst_12 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %39 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %40 = stablehlo.multiply %39, %0 : tensor<128xf64>
    %cst_13 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %41 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %42 = stablehlo.divide %40, %41 : tensor<128xf64>
    %43 = stablehlo.subtract %38, %42 : tensor<128xf64>
    %cst_14 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %44 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %45 = stablehlo.multiply %44, %1 : tensor<128xf64>
    %cst_15 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %46 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %47 = stablehlo.divide %45, %46 : tensor<128xf64>
    %48 = stablehlo.add %43, %47 : tensor<128xf64>
    %cst_16 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %49 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %50 = stablehlo.divide %2, %49 : tensor<128xf64>
    %51 = stablehlo.add %48, %50 : tensor<128xf64>
    %cst_17 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %52 = stablehlo.broadcast_in_dim %cst_17, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %53 = stablehlo.divide %3, %52 : tensor<128xf64>
    %54 = stablehlo.subtract %51, %53 : tensor<128xf64>
    %cst_18 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %55 = stablehlo.broadcast_in_dim %cst_18, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %56 = stablehlo.multiply %55, %0 : tensor<128xf64>
    %cst_19 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %57 = stablehlo.broadcast_in_dim %cst_19, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %58 = stablehlo.divide %56, %57 : tensor<128xf64>
    %59 = stablehlo.add %arg2, %58 : tensor<128xf64>
    %cst_20 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %60 = stablehlo.broadcast_in_dim %cst_20, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %61 = stablehlo.multiply %60, %1 : tensor<128xf64>
    %cst_21 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %62 = stablehlo.broadcast_in_dim %cst_21, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %63 = stablehlo.divide %61, %62 : tensor<128xf64>
    %64 = stablehlo.subtract %59, %63 : tensor<128xf64>
    %cst_22 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %65 = stablehlo.broadcast_in_dim %cst_22, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %66 = stablehlo.divide %2, %65 : tensor<128xf64>
    %67 = stablehlo.subtract %64, %66 : tensor<128xf64>
    %cst_23 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %68 = stablehlo.broadcast_in_dim %cst_23, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %69 = stablehlo.divide %3, %68 : tensor<128xf64>
    %70 = stablehlo.add %67, %69 : tensor<128xf64>
    %cst_24 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %71 = stablehlo.broadcast_in_dim %cst_24, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %72 = stablehlo.divide %arg2, %71 : tensor<128xf64>
    %73 = stablehlo.negate %72 : tensor<128xf64>
    %cst_25 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %74 = stablehlo.broadcast_in_dim %cst_25, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %75 = stablehlo.divide %0, %74 : tensor<128xf64>
    %76 = stablehlo.subtract %73, %75 : tensor<128xf64>
    %cst_26 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %77 = stablehlo.broadcast_in_dim %cst_26, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %78 = stablehlo.multiply %77, %1 : tensor<128xf64>
    %cst_27 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %79 = stablehlo.broadcast_in_dim %cst_27, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %80 = stablehlo.divide %78, %79 : tensor<128xf64>
    %81 = stablehlo.add %76, %80 : tensor<128xf64>
    %cst_28 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %82 = stablehlo.broadcast_in_dim %cst_28, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %83 = stablehlo.divide %2, %82 : tensor<128xf64>
    %84 = stablehlo.add %81, %83 : tensor<128xf64>
    %cst_29 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %85 = stablehlo.broadcast_in_dim %cst_29, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %86 = stablehlo.divide %3, %85 : tensor<128xf64>
    %87 = stablehlo.subtract %84, %86 : tensor<128xf64>
    %cst_30 = stablehlo.constant dense<3.000000e+01> : tensor<f64>
    %88 = stablehlo.broadcast_in_dim %cst_30, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %89 = stablehlo.divide %arg2, %88 : tensor<128xf64>
    %cst_31 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %90 = stablehlo.broadcast_in_dim %cst_31, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %91 = stablehlo.divide %1, %90 : tensor<128xf64>
    %92 = stablehlo.subtract %89, %91 : tensor<128xf64>
    %cst_32 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %93 = stablehlo.broadcast_in_dim %cst_32, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %94 = stablehlo.divide %3, %93 : tensor<128xf64>
    %95 = stablehlo.add %92, %94 : tensor<128xf64>
    %96 = stablehlo.broadcast_in_dim %17, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %97 = stablehlo.broadcast_in_dim %34, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %98 = stablehlo.broadcast_in_dim %54, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %99 = stablehlo.broadcast_in_dim %70, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %100 = stablehlo.broadcast_in_dim %87, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %101 = stablehlo.broadcast_in_dim %95, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %102 = stablehlo.concatenate %96, %97, %98, %99, %100, %101, dim = 0 : (tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>) -> tensor<6x128xf64>
    %103 = stablehlo.iota dim = 0 : tensor<128xi64>
    %104 = stablehlo.broadcast_in_dim %arg0, dims = [0] : (tensor<6xi32>) -> tensor<6x1xi32>
    %105 = stablehlo.broadcast_in_dim %arg1, dims = [1] : (tensor<128xi32>) -> tensor<1x128xi32>
    %106 = stablehlo.broadcast_in_dim %104, dims = [0, 1] : (tensor<6x1xi32>) -> tensor<6x128xi32>
    %107 = stablehlo.broadcast_in_dim %105, dims = [0, 1] : (tensor<1x128xi32>) -> tensor<6x128xi32>
    %108 = stablehlo.add %106, %107 : tensor<6x128xi32>
    %109 = stablehlo.broadcast_in_dim %103, dims = [2] : (tensor<128xi64>) -> tensor<1x1x128xi64>
    %110 = stablehlo.broadcast_in_dim %108, dims = [0, 1] : (tensor<6x128xi32>) -> tensor<6x128x1xi32>
    %111 = stablehlo.convert %110 : (tensor<6x128x1xi32>) -> tensor<6x128x1xi64>
    %112 = stablehlo.broadcast_in_dim %109, dims = [0, 1, 2] : (tensor<1x1x128xi64>) -> tensor<6x128x128xi64>
    %113 = stablehlo.broadcast_in_dim %111, dims = [0, 1, 2] : (tensor<6x128x1xi64>) -> tensor<6x128x128xi64>
    %114 = stablehlo.subtract %112, %113 : tensor<6x128x128xi64>
    %c = stablehlo.constant dense<0> : tensor<i64>
    %115 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i64>) -> tensor<6x128x128xi64>
    %116 = stablehlo.compare  GE, %114, %115,  SIGNED : (tensor<6x128x128xi64>, tensor<6x128x128xi64>) -> tensor<6x128x128xi1>
    %c_33 = stablehlo.constant dense<128> : tensor<i64>
    %117 = stablehlo.broadcast_in_dim %c_33, dims = [] : (tensor<i64>) -> tensor<6x128x128xi64>
    %118 = stablehlo.compare  LT, %114, %117,  SIGNED : (tensor<6x128x128xi64>, tensor<6x128x128xi64>) -> tensor<6x128x128xi1>
    %119 = stablehlo.and %116, %118 : tensor<6x128x128xi1>
    %120 = stablehlo.broadcast_in_dim %102, dims = [0, 1] : (tensor<6x128xf64>) -> tensor<6x128x1xf64>
    %cst_34 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %121 = call @_where_46(%119, %120, %cst_34) : (tensor<6x128x128xi1>, tensor<6x128x1xf64>, tensor<f64>) -> tensor<6x128x128xf64>
    return %121 : tensor<6x128x128xf64>
  }
  func.func private @_where_46(%arg0: tensor<6x128x128xi1>, %arg1: tensor<6x128x1xf64>, %arg2: tensor<f64>) -> tensor<6x128x128xf64> {
    %0 = stablehlo.convert %arg2 : tensor<f64>
    %1 = stablehlo.broadcast_in_dim %arg1, dims = [0, 1, 2] : (tensor<6x128x1xf64>) -> tensor<6x128x128xf64>
    %2 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f64>) -> tensor<6x128x128xf64>
    %3 = stablehlo.select %arg0, %1, %2 : tensor<6x128x128xi1>, tensor<6x128x128xf64>
    return %3 : tensor<6x128x128xf64>
  }
  func.func private @_roll_dynamic_50(%arg0: tensor<128x128xf64>, %arg1: tensor<128xi32>) -> tensor<128x128xf64> {
    %0 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<128xi32>) -> tensor<128x1xi32>
    %1 = stablehlo.slice %0 [0:128, 0:1] : (tensor<128x1xi32>) -> tensor<128x1xi32>
    %2 = stablehlo.reshape %1 : (tensor<128x1xi32>) -> tensor<128xi32>
    %c = stablehlo.constant dense<128> : tensor<i32>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %3 = stablehlo.maximum %c, %c_0 : tensor<i32>
    %4 = call @remainder(%2, %3) : (tensor<128xi32>, tensor<i32>) -> tensor<128xi32>
    %5 = stablehlo.concatenate %arg0, %arg0, dim = 1 : (tensor<128x128xf64>, tensor<128x128xf64>) -> tensor<128x256xf64>
    %c_1 = stablehlo.constant dense<128> : tensor<i32>
    %6 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %7 = stablehlo.subtract %6, %4 : tensor<128xi32>
    %c_2 = stablehlo.constant dense<0> : tensor<i32>
    %8 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %9 = stablehlo.compare  LT, %7, %8,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %c_3 = stablehlo.constant dense<256> : tensor<i32>
    %10 = stablehlo.broadcast_in_dim %c_3, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %11 = stablehlo.add %7, %10 : tensor<128xi32>
    %12 = stablehlo.select %9, %11, %7 : tensor<128xi1>, tensor<128xi32>
    %13 = stablehlo.broadcast_in_dim %12, dims = [0] : (tensor<128xi32>) -> tensor<128x1xi32>
    %14 = "stablehlo.gather"(%5, %13) <{dimension_numbers = #stablehlo.gather<offset_dims = [1], operand_batching_dims = [0], start_indices_batching_dims = [0], start_index_map = [1], index_vector_dim = 1>, indices_are_sorted = true, slice_sizes = array<i64: 1, 128>}> : (tensor<128x256xf64>, tensor<128x1xi32>) -> tensor<128x128xf64>
    return %14 : tensor<128x128xf64>
  }
}
