module @jit_run_chunk attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<128xf64>, %arg1: tensor<128xf64>, %arg2: tensor<65xf64>, %arg3: tensor<6xi32>, %arg4: tensor<128xf64>, %arg5: tensor<128xf64>, %arg6: tensor<128x128xf64>, %arg7: tensor<128xf64>, %arg8: tensor<f64>, %arg9: tensor<i64>) -> (tensor<128xf64> {jax.result_info = "result[0][0]"}, tensor<128xf64> {jax.result_info = "result[0][1]"}, tensor<65xf64> {jax.result_info = "result[0][2]"}, tensor<6xi32> {jax.result_info = "result[0][3]"}, tensor<128xf64> {jax.result_info = "result[1][0]"}, tensor<128xf64> {jax.result_info = "result[1][1]"}, tensor<128x128xf64> {jax.result_info = "result[2][0]"}, tensor<128xf64> {jax.result_info = "result[2][1]"}, tensor<f64> {jax.result_info = "result[3]"}, tensor<i64> {jax.result_info = "result[4]"}) {
    %cst = stablehlo.constant dense<"0xFA6E6C249F41E73FD0B7E92BE1E5E73FA6006733238AE83F7A49E43A652EE93F50926142A7D2E93F26DBDE49E976EA3FFC235C512B1BEB3FD46CD9586DBFEB3FAAB55660AF63EC3F80FED367F107ED3F5447516F33ACED3F2A90CE767550EE3F00D94B7EB7F4EE3FD421C985F998EF3F005535A3C69D7E3F00707698B22F9C3F50C50FC4F95BA83F6029F21D0D50B13F0870DC591D72B63FB8B6C6952D94BB3FB07ED8E81E5BC03F08A2CD0627ECC23F68C5C2242F7DC53FBCE8B742370EC83F100CAD603F9FCA3F682FA27E4730CD3FBC52979C4FC1CF3F0C3B46DD2B29D13FBACC40ECAF71D23F645E3BFB33BAD33F10F0350AB802D53FBA8130193C4BD63F64132B28C093D73F10A5253744DCD83FBA362046C824DA3F66C81A554C6DDB3F105A1564D0B5DC3FBCEB0F7354FEDD3F6A7D0A82D846DF3F8A878248AE47E03F60D0FF4FF0EBE03F36197D573290E13F0C62FA5E7434E23FE3AA7766B6D8E23FB9F3F46DF87CE33F8E3C72753A21E43F6485EF7C7CC5E43F3ACE6C84BE69E53F0F17EA8B000EE63FE45F679342B2E63FBAA8E49A8456E73F90F161A2C6FAE73F653ADFA9089FE83F3B835CB14A43E93F11CCD9B88CE7E93FE81457C0CE8BEA3FBD5DD4C71030EB3F92A651CF52D4EB3F68EFCED69478EC3F3E384CDED61CED3F1481C9E518C1ED3FEAC946ED5A65EE3FC012C4F49C09EF3F955B41FCDEADEF3FAE1AA9EF4088843F05A87D6761CC9E3F5A61932B51AAA93F58F7B3D138F7B13F0D3E9E0D4919B73FC0848849593BBC3FB665B9C2B4AEC03F0B89AEE0BC3FC33F62ACA3FEC4D0C53FB8CF981CCD61C83F11F38D3AD5F2CA3F67168358DD83CD3FE01C3CBB720AD03F8CAE36CAF652D13F374031D97A9BD23FE2D12BE8FEE3D33F8C6326F7822CD53F3AF520060775D63FE5861B158BBDD73F901816240F06D93F3AAA1033934EDA3FE93B0B421797DB3F94CD05519BDFDC3F405F00601F28DE3FEBF0FA6EA370DF3F4BC1FABE935CE03F200A78C6D500E13FF652F5CD17A5E13FCD9B72D55949E23FA3E4EFDC9BEDE23F782D6DE4DD91E33F4E76EAEB1F36E43F23BF67F361DAE43FF807E5FAA37EE53FCE506202E622E63FA399DF0928C7E63F7AE25C116A6BE73F512BDA18AC0FE83F26745720EEB3E83FFCBCD4273058E93FD105522F72FCE93FA64ECF36B4A0EA3F7C974C3EF644EB3F51E0C94538E9EB3F2929474D7A8DEC3F0072C454BC31ED3FD5BA415CFED5ED3FAB03BF63407AEE3F804C3C6B821EEF3F5695B972C4C2EF3F008BB78D9EC1893F0070421B88B4A03F60FD1693A8F8AA3F60C57585649EB23F000C60C174C0B73FB0524AFD84E2BC3FB04C9A9C4A02C13F08708FBA5293C33F689384D85A24C63FB8B679F662B5C83F18DA6E146B46CB3F68FD633273D7CD3F60902CA83D34D03F0C2227B7C17CD13F"> : tensor<128xf64>
    %cst_0 = stablehlo.constant dense<[0.000000e+00, 2.000000e+00, 1.000000e+00, 0.66666666666666663, 5.000000e-01, 4.000000e-01, 0.33333333333333331, 0.2857142857142857, 2.500000e-01, 0.22222222222222221, 2.000000e-01, 0.18181818181818182, 0.16666666666666666, 0.15384615384615385, 0.14285714285714285, 0.13333333333333333, 1.250000e-01, 0.11764705882352941, 0.1111111111111111, 0.10526315789473684, 1.000000e-01, 0.095238095238095233, 0.090909090909090911, 0.086956521739130432, 0.083333333333333329, 8.000000e-02, 0.076923076923076927, 0.074074074074074084, 0.071428571428571425, 0.068965517241379296, 0.066666666666666666, 0.064516129032258063, 6.250000e-02, 0.060606060606060608, 0.058823529411764705, 0.057142857142857141, 0.055555555555555552, 0.054054054054054057, 0.052631578947368418, 0.05128205128205128, 5.000000e-02, 0.04878048780487805, 0.047619047619047616, 0.046511627906976744, 0.045454545454545456, 0.044444444444444446, 0.043478260869565216, 0.042553191489361701, 0.041666666666666664, 0.040816326530612242, 4.000000e-02, 0.039215686274509803, 0.038461538461538464, 0.037735849056603779, 0.037037037037037042, 0.036363636363636369, 0.035714285714285712, 0.035087719298245612, 0.034482758620689648, 0.033898305084745756, 0.033333333333333333, 0.032786885245901641, 0.032258064516129031, 0.031746031746031744, 3.125000e-02]> : tensor<65xf64>
    %c = stablehlo.constant dense<0> : tensor<i64>
    %0:6 = stablehlo.while(%iterArg = %cst, %iterArg_3 = %cst_0, %iterArg_4 = %c, %iterArg_5 = %arg6, %iterArg_6 = %arg4, %iterArg_7 = %arg5) : tensor<128xf64>, tensor<65xf64>, tensor<i64>, tensor<128x128xf64>, tensor<128xf64>, tensor<128xf64>
    cond {
      %c_8 = stablehlo.constant dense<1000> : tensor<i64>
      %3 = stablehlo.compare  LT, %iterArg_4, %c_8,  SIGNED : (tensor<i64>, tensor<i64>) -> tensor<i1>
      stablehlo.return %3 : tensor<i1>
    } do {
      %3:3 = func.call @closed_call(%iterArg, %iterArg_3, %iterArg_5, %iterArg_6, %iterArg_7) : (tensor<128xf64>, tensor<65xf64>, tensor<128x128xf64>, tensor<128xf64>, tensor<128xf64>) -> (tensor<128x128xf64>, tensor<128xf64>, tensor<128xf64>)
      %c_8 = stablehlo.constant dense<1> : tensor<i64>
      %4 = stablehlo.add %iterArg_4, %c_8 : tensor<i64>
      stablehlo.return %iterArg, %iterArg_3, %4, %3#0, %3#1, %3#2 : tensor<128xf64>, tensor<65xf64>, tensor<i64>, tensor<128x128xf64>, tensor<128xf64>, tensor<128xf64>
    }
    %cst_1 = stablehlo.constant dense<5.000000e+01> : tensor<f64>
    %1 = stablehlo.add %arg8, %cst_1 : tensor<f64>
    %c_2 = stablehlo.constant dense<1000> : tensor<i64>
    %2 = stablehlo.add %arg9, %c_2 : tensor<i64>
    return %arg0, %arg1, %arg2, %arg3, %0#4, %0#5, %0#3, %arg7, %1, %2 : tensor<128xf64>, tensor<128xf64>, tensor<65xf64>, tensor<6xi32>, tensor<128xf64>, tensor<128xf64>, tensor<128x128xf64>, tensor<128xf64>, tensor<f64>, tensor<i64>
  }
  func.func private @closed_call(%arg0: tensor<128xf64>, %arg1: tensor<65xf64>, %arg2: tensor<128x128xf64>, %arg3: tensor<128xf64>, %arg4: tensor<128xf64>) -> (tensor<128x128xf64>, tensor<128xf64>, tensor<128xf64>) {
    %0 = stablehlo.multiply %arg0, %arg0 : tensor<128xf64>
    %1 = stablehlo.multiply %0, %arg0 : tensor<128xf64>
    %2 = stablehlo.multiply %1, %arg0 : tensor<128xf64>
    %3 = stablehlo.multiply %2, %arg0 : tensor<128xf64>
    %cst = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %4 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %5 = stablehlo.divide %arg0, %4 : tensor<128xf64>
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
    %19 = stablehlo.divide %arg0, %18 : tensor<128xf64>
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
    %36 = stablehlo.divide %arg0, %35 : tensor<128xf64>
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
    %59 = stablehlo.add %arg0, %58 : tensor<128xf64>
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
    %72 = stablehlo.divide %arg0, %71 : tensor<128xf64>
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
    %89 = stablehlo.divide %arg0, %88 : tensor<128xf64>
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
    %103 = stablehlo.slice %arg2 [0:128, 0:14] : (tensor<128x128xf64>) -> tensor<128x14xf64>
    %104 = call @_roll_static(%103) : (tensor<128x14xf64>) -> tensor<128x14xf64>
    %105 = stablehlo.slice %arg2 [0:128, 14:64] : (tensor<128x128xf64>) -> tensor<128x50xf64>
    %106 = call @_roll_static_6(%105) : (tensor<128x50xf64>) -> tensor<128x50xf64>
    %107 = stablehlo.slice %arg2 [0:128, 64:114] : (tensor<128x128xf64>) -> tensor<128x50xf64>
    %108 = call @_roll_static_11(%107) : (tensor<128x50xf64>) -> tensor<128x50xf64>
    %109 = stablehlo.slice %arg2 [0:128, 114:128] : (tensor<128x128xf64>) -> tensor<128x14xf64>
    %110 = call @_roll_static_16(%109) : (tensor<128x14xf64>) -> tensor<128x14xf64>
    %111 = stablehlo.concatenate %104, %106, %108, %110, dim = 1 : (tensor<128x14xf64>, tensor<128x50xf64>, tensor<128x50xf64>, tensor<128x14xf64>) -> tensor<128x128xf64>
    %cst_33 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %112 = stablehlo.broadcast_in_dim %cst_33, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %113 = call @_roll_static_22(%111) : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %114 = stablehlo.slice %102 [0:1, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %115 = stablehlo.reshape %114 : (tensor<1x128xf64>) -> tensor<128xf64>
    %116 = stablehlo.broadcast_in_dim %115, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %117 = stablehlo.broadcast_in_dim %116, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %118 = stablehlo.multiply %113, %117 : tensor<128x128xf64>
    %119 = stablehlo.add %112, %118 : tensor<128x128xf64>
    %120 = call @_roll_static_29(%111) : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %121 = stablehlo.slice %102 [1:2, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %122 = stablehlo.reshape %121 : (tensor<1x128xf64>) -> tensor<128xf64>
    %123 = stablehlo.broadcast_in_dim %122, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %124 = stablehlo.broadcast_in_dim %123, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %125 = stablehlo.multiply %120, %124 : tensor<128x128xf64>
    %126 = stablehlo.add %119, %125 : tensor<128x128xf64>
    %127 = call @_roll_static_34(%111) : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %128 = stablehlo.slice %102 [2:3, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %129 = stablehlo.reshape %128 : (tensor<1x128xf64>) -> tensor<128xf64>
    %130 = stablehlo.broadcast_in_dim %129, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %131 = stablehlo.broadcast_in_dim %130, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %132 = stablehlo.multiply %127, %131 : tensor<128x128xf64>
    %133 = stablehlo.add %126, %132 : tensor<128x128xf64>
    %134 = call @_roll_static_39(%111) : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %135 = stablehlo.slice %102 [3:4, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %136 = stablehlo.reshape %135 : (tensor<1x128xf64>) -> tensor<128xf64>
    %137 = stablehlo.broadcast_in_dim %136, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %138 = stablehlo.broadcast_in_dim %137, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %139 = stablehlo.multiply %134, %138 : tensor<128x128xf64>
    %140 = stablehlo.add %133, %139 : tensor<128x128xf64>
    %141 = call @_roll_static_44(%111) : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %142 = stablehlo.slice %102 [4:5, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %143 = stablehlo.reshape %142 : (tensor<1x128xf64>) -> tensor<128xf64>
    %144 = stablehlo.broadcast_in_dim %143, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %145 = stablehlo.broadcast_in_dim %144, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %146 = stablehlo.multiply %141, %145 : tensor<128x128xf64>
    %147 = stablehlo.add %140, %146 : tensor<128x128xf64>
    %148 = call @_roll_static_49(%111) : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %149 = stablehlo.slice %102 [5:6, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %150 = stablehlo.reshape %149 : (tensor<1x128xf64>) -> tensor<128xf64>
    %151 = stablehlo.broadcast_in_dim %150, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %152 = stablehlo.broadcast_in_dim %151, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %153 = stablehlo.multiply %148, %152 : tensor<128x128xf64>
    %154 = stablehlo.add %147, %153 : tensor<128x128xf64>
    %cst_34 = stablehlo.constant dense<0.078740157480314959> : tensor<f64>
    %155:3 = call @solve_poisson(%154, %arg1, %cst_34) : (tensor<128x128xf64>, tensor<65xf64>, tensor<f64>) -> (tensor<128xf64>, tensor<128xf64>, tensor<128xf64>)
    %cst_35 = stablehlo.constant dense<5.000000e-02> : tensor<f64>
    %156 = stablehlo.broadcast_in_dim %cst_35, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %157 = stablehlo.multiply %155#0, %156 : tensor<128xf64>
    %cst_36 = stablehlo.constant dense<0.078740157480314959> : tensor<f64>
    %158 = stablehlo.broadcast_in_dim %cst_36, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %159 = stablehlo.divide %157, %158 : tensor<128xf64>
    %160 = stablehlo.floor %159 : tensor<128xf64>
    %161 = stablehlo.subtract %159, %160 : tensor<128xf64>
    %162 = stablehlo.convert %160 : (tensor<128xf64>) -> tensor<128xi32>
    %163 = stablehlo.multiply %161, %161 : tensor<128xf64>
    %164 = stablehlo.multiply %163, %161 : tensor<128xf64>
    %165 = stablehlo.multiply %164, %161 : tensor<128xf64>
    %166 = stablehlo.multiply %165, %161 : tensor<128xf64>
    %cst_37 = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %167 = stablehlo.broadcast_in_dim %cst_37, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %168 = stablehlo.divide %161, %167 : tensor<128xf64>
    %cst_38 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %169 = stablehlo.broadcast_in_dim %cst_38, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %170 = stablehlo.divide %163, %169 : tensor<128xf64>
    %171 = stablehlo.subtract %168, %170 : tensor<128xf64>
    %cst_39 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %172 = stablehlo.broadcast_in_dim %cst_39, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %173 = stablehlo.divide %164, %172 : tensor<128xf64>
    %174 = stablehlo.subtract %171, %173 : tensor<128xf64>
    %cst_40 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %175 = stablehlo.broadcast_in_dim %cst_40, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %176 = stablehlo.divide %165, %175 : tensor<128xf64>
    %177 = stablehlo.add %174, %176 : tensor<128xf64>
    %cst_41 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %178 = stablehlo.broadcast_in_dim %cst_41, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %179 = stablehlo.divide %166, %178 : tensor<128xf64>
    %180 = stablehlo.subtract %177, %179 : tensor<128xf64>
    %cst_42 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %181 = stablehlo.broadcast_in_dim %cst_42, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %182 = stablehlo.divide %161, %181 : tensor<128xf64>
    %183 = stablehlo.negate %182 : tensor<128xf64>
    %cst_43 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %184 = stablehlo.broadcast_in_dim %cst_43, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %185 = stablehlo.multiply %184, %163 : tensor<128xf64>
    %cst_44 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %186 = stablehlo.broadcast_in_dim %cst_44, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %187 = stablehlo.divide %185, %186 : tensor<128xf64>
    %188 = stablehlo.add %183, %187 : tensor<128xf64>
    %cst_45 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %189 = stablehlo.broadcast_in_dim %cst_45, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %190 = stablehlo.divide %164, %189 : tensor<128xf64>
    %191 = stablehlo.subtract %188, %190 : tensor<128xf64>
    %cst_46 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %192 = stablehlo.broadcast_in_dim %cst_46, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %193 = stablehlo.divide %165, %192 : tensor<128xf64>
    %194 = stablehlo.subtract %191, %193 : tensor<128xf64>
    %cst_47 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %195 = stablehlo.broadcast_in_dim %cst_47, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %196 = stablehlo.divide %166, %195 : tensor<128xf64>
    %197 = stablehlo.add %194, %196 : tensor<128xf64>
    %cst_48 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %198 = stablehlo.broadcast_in_dim %cst_48, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %199 = stablehlo.divide %161, %198 : tensor<128xf64>
    %cst_49 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %200 = stablehlo.broadcast_in_dim %cst_49, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %201 = stablehlo.subtract %200, %199 : tensor<128xf64>
    %cst_50 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %202 = stablehlo.broadcast_in_dim %cst_50, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %203 = stablehlo.multiply %202, %163 : tensor<128xf64>
    %cst_51 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %204 = stablehlo.broadcast_in_dim %cst_51, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %205 = stablehlo.divide %203, %204 : tensor<128xf64>
    %206 = stablehlo.subtract %201, %205 : tensor<128xf64>
    %cst_52 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %207 = stablehlo.broadcast_in_dim %cst_52, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %208 = stablehlo.multiply %207, %164 : tensor<128xf64>
    %cst_53 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %209 = stablehlo.broadcast_in_dim %cst_53, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %210 = stablehlo.divide %208, %209 : tensor<128xf64>
    %211 = stablehlo.add %206, %210 : tensor<128xf64>
    %cst_54 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %212 = stablehlo.broadcast_in_dim %cst_54, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %213 = stablehlo.divide %165, %212 : tensor<128xf64>
    %214 = stablehlo.add %211, %213 : tensor<128xf64>
    %cst_55 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %215 = stablehlo.broadcast_in_dim %cst_55, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %216 = stablehlo.divide %166, %215 : tensor<128xf64>
    %217 = stablehlo.subtract %214, %216 : tensor<128xf64>
    %cst_56 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %218 = stablehlo.broadcast_in_dim %cst_56, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %219 = stablehlo.multiply %218, %163 : tensor<128xf64>
    %cst_57 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %220 = stablehlo.broadcast_in_dim %cst_57, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %221 = stablehlo.divide %219, %220 : tensor<128xf64>
    %222 = stablehlo.add %161, %221 : tensor<128xf64>
    %cst_58 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %223 = stablehlo.broadcast_in_dim %cst_58, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %224 = stablehlo.multiply %223, %164 : tensor<128xf64>
    %cst_59 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %225 = stablehlo.broadcast_in_dim %cst_59, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %226 = stablehlo.divide %224, %225 : tensor<128xf64>
    %227 = stablehlo.subtract %222, %226 : tensor<128xf64>
    %cst_60 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %228 = stablehlo.broadcast_in_dim %cst_60, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %229 = stablehlo.divide %165, %228 : tensor<128xf64>
    %230 = stablehlo.subtract %227, %229 : tensor<128xf64>
    %cst_61 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %231 = stablehlo.broadcast_in_dim %cst_61, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %232 = stablehlo.divide %166, %231 : tensor<128xf64>
    %233 = stablehlo.add %230, %232 : tensor<128xf64>
    %cst_62 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %234 = stablehlo.broadcast_in_dim %cst_62, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %235 = stablehlo.divide %161, %234 : tensor<128xf64>
    %236 = stablehlo.negate %235 : tensor<128xf64>
    %cst_63 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %237 = stablehlo.broadcast_in_dim %cst_63, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %238 = stablehlo.divide %163, %237 : tensor<128xf64>
    %239 = stablehlo.subtract %236, %238 : tensor<128xf64>
    %cst_64 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %240 = stablehlo.broadcast_in_dim %cst_64, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %241 = stablehlo.multiply %240, %164 : tensor<128xf64>
    %cst_65 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %242 = stablehlo.broadcast_in_dim %cst_65, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %243 = stablehlo.divide %241, %242 : tensor<128xf64>
    %244 = stablehlo.add %239, %243 : tensor<128xf64>
    %cst_66 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %245 = stablehlo.broadcast_in_dim %cst_66, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %246 = stablehlo.divide %165, %245 : tensor<128xf64>
    %247 = stablehlo.add %244, %246 : tensor<128xf64>
    %cst_67 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %248 = stablehlo.broadcast_in_dim %cst_67, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %249 = stablehlo.divide %166, %248 : tensor<128xf64>
    %250 = stablehlo.subtract %247, %249 : tensor<128xf64>
    %cst_68 = stablehlo.constant dense<3.000000e+01> : tensor<f64>
    %251 = stablehlo.broadcast_in_dim %cst_68, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %252 = stablehlo.divide %161, %251 : tensor<128xf64>
    %cst_69 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %253 = stablehlo.broadcast_in_dim %cst_69, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %254 = stablehlo.divide %164, %253 : tensor<128xf64>
    %255 = stablehlo.subtract %252, %254 : tensor<128xf64>
    %cst_70 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %256 = stablehlo.broadcast_in_dim %cst_70, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %257 = stablehlo.divide %166, %256 : tensor<128xf64>
    %258 = stablehlo.add %255, %257 : tensor<128xf64>
    %259 = stablehlo.broadcast_in_dim %180, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %260 = stablehlo.broadcast_in_dim %197, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %261 = stablehlo.broadcast_in_dim %217, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %262 = stablehlo.broadcast_in_dim %233, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %263 = stablehlo.broadcast_in_dim %250, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %264 = stablehlo.broadcast_in_dim %258, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %265 = stablehlo.concatenate %259, %260, %261, %262, %263, %264, dim = 0 : (tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>) -> tensor<6x128xf64>
    %cst_71 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %266 = stablehlo.broadcast_in_dim %cst_71, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %c = stablehlo.constant dense<-1> : tensor<i32>
    %267 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %268 = stablehlo.compare  EQ, %162, %267,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %269 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %270 = stablehlo.reshape %269 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_72 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %271 = call @_where(%268, %270, %cst_72) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %272 = stablehlo.add %266, %271 : tensor<128xf64>
    %c_73 = stablehlo.constant dense<-2> : tensor<i32>
    %273 = stablehlo.broadcast_in_dim %c_73, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %274 = stablehlo.compare  EQ, %162, %273,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %275 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %276 = stablehlo.reshape %275 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_74 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %277 = call @_where(%274, %276, %cst_74) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %278 = stablehlo.add %272, %277 : tensor<128xf64>
    %c_75 = stablehlo.constant dense<-3> : tensor<i32>
    %279 = stablehlo.broadcast_in_dim %c_75, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %280 = stablehlo.compare  EQ, %162, %279,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %281 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %282 = stablehlo.reshape %281 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_76 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %283 = call @_where(%280, %282, %cst_76) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %284 = stablehlo.add %278, %283 : tensor<128xf64>
    %c_77 = stablehlo.constant dense<-4> : tensor<i32>
    %285 = stablehlo.broadcast_in_dim %c_77, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %286 = stablehlo.compare  EQ, %162, %285,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %287 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %288 = stablehlo.reshape %287 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_78 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %289 = call @_where(%286, %288, %cst_78) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %290 = stablehlo.add %284, %289 : tensor<128xf64>
    %c_79 = stablehlo.constant dense<-5> : tensor<i32>
    %291 = stablehlo.broadcast_in_dim %c_79, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %292 = stablehlo.compare  EQ, %162, %291,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %293 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %294 = stablehlo.reshape %293 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_80 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %295 = call @_where(%292, %294, %cst_80) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %296 = stablehlo.add %290, %295 : tensor<128xf64>
    %c_81 = stablehlo.constant dense<-6> : tensor<i32>
    %297 = stablehlo.broadcast_in_dim %c_81, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %298 = stablehlo.compare  EQ, %162, %297,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %299 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %300 = stablehlo.reshape %299 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_82 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %301 = call @_where(%298, %300, %cst_82) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %302 = stablehlo.add %296, %301 : tensor<128xf64>
    %cst_83 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %303 = stablehlo.broadcast_in_dim %cst_83, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %c_84 = stablehlo.constant dense<0> : tensor<i32>
    %304 = stablehlo.broadcast_in_dim %c_84, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %305 = stablehlo.compare  EQ, %162, %304,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %306 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %307 = stablehlo.reshape %306 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_85 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %308 = call @_where(%305, %307, %cst_85) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %309 = stablehlo.add %303, %308 : tensor<128xf64>
    %c_86 = stablehlo.constant dense<-1> : tensor<i32>
    %310 = stablehlo.broadcast_in_dim %c_86, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %311 = stablehlo.compare  EQ, %162, %310,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %312 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %313 = stablehlo.reshape %312 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_87 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %314 = call @_where(%311, %313, %cst_87) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %315 = stablehlo.add %309, %314 : tensor<128xf64>
    %c_88 = stablehlo.constant dense<-2> : tensor<i32>
    %316 = stablehlo.broadcast_in_dim %c_88, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %317 = stablehlo.compare  EQ, %162, %316,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %318 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %319 = stablehlo.reshape %318 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_89 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %320 = call @_where(%317, %319, %cst_89) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %321 = stablehlo.add %315, %320 : tensor<128xf64>
    %c_90 = stablehlo.constant dense<-3> : tensor<i32>
    %322 = stablehlo.broadcast_in_dim %c_90, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %323 = stablehlo.compare  EQ, %162, %322,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %324 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %325 = stablehlo.reshape %324 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_91 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %326 = call @_where(%323, %325, %cst_91) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %327 = stablehlo.add %321, %326 : tensor<128xf64>
    %c_92 = stablehlo.constant dense<-4> : tensor<i32>
    %328 = stablehlo.broadcast_in_dim %c_92, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %329 = stablehlo.compare  EQ, %162, %328,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %330 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %331 = stablehlo.reshape %330 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_93 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %332 = call @_where(%329, %331, %cst_93) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %333 = stablehlo.add %327, %332 : tensor<128xf64>
    %c_94 = stablehlo.constant dense<-5> : tensor<i32>
    %334 = stablehlo.broadcast_in_dim %c_94, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %335 = stablehlo.compare  EQ, %162, %334,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %336 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %337 = stablehlo.reshape %336 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_95 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %338 = call @_where(%335, %337, %cst_95) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %339 = stablehlo.add %333, %338 : tensor<128xf64>
    %cst_96 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %340 = stablehlo.broadcast_in_dim %cst_96, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %c_97 = stablehlo.constant dense<1> : tensor<i32>
    %341 = stablehlo.broadcast_in_dim %c_97, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %342 = stablehlo.compare  EQ, %162, %341,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %343 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %344 = stablehlo.reshape %343 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_98 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %345 = call @_where(%342, %344, %cst_98) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %346 = stablehlo.add %340, %345 : tensor<128xf64>
    %c_99 = stablehlo.constant dense<0> : tensor<i32>
    %347 = stablehlo.broadcast_in_dim %c_99, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %348 = stablehlo.compare  EQ, %162, %347,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %349 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %350 = stablehlo.reshape %349 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_100 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %351 = call @_where(%348, %350, %cst_100) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %352 = stablehlo.add %346, %351 : tensor<128xf64>
    %c_101 = stablehlo.constant dense<-1> : tensor<i32>
    %353 = stablehlo.broadcast_in_dim %c_101, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %354 = stablehlo.compare  EQ, %162, %353,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %355 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %356 = stablehlo.reshape %355 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_102 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %357 = call @_where(%354, %356, %cst_102) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %358 = stablehlo.add %352, %357 : tensor<128xf64>
    %c_103 = stablehlo.constant dense<-2> : tensor<i32>
    %359 = stablehlo.broadcast_in_dim %c_103, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %360 = stablehlo.compare  EQ, %162, %359,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %361 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %362 = stablehlo.reshape %361 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_104 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %363 = call @_where(%360, %362, %cst_104) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %364 = stablehlo.add %358, %363 : tensor<128xf64>
    %c_105 = stablehlo.constant dense<-3> : tensor<i32>
    %365 = stablehlo.broadcast_in_dim %c_105, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %366 = stablehlo.compare  EQ, %162, %365,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %367 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %368 = stablehlo.reshape %367 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_106 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %369 = call @_where(%366, %368, %cst_106) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %370 = stablehlo.add %364, %369 : tensor<128xf64>
    %c_107 = stablehlo.constant dense<-4> : tensor<i32>
    %371 = stablehlo.broadcast_in_dim %c_107, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %372 = stablehlo.compare  EQ, %162, %371,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %373 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %374 = stablehlo.reshape %373 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_108 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %375 = call @_where(%372, %374, %cst_108) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %376 = stablehlo.add %370, %375 : tensor<128xf64>
    %cst_109 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %377 = stablehlo.broadcast_in_dim %cst_109, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %c_110 = stablehlo.constant dense<2> : tensor<i32>
    %378 = stablehlo.broadcast_in_dim %c_110, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %379 = stablehlo.compare  EQ, %162, %378,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %380 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %381 = stablehlo.reshape %380 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_111 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %382 = call @_where(%379, %381, %cst_111) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %383 = stablehlo.add %377, %382 : tensor<128xf64>
    %c_112 = stablehlo.constant dense<1> : tensor<i32>
    %384 = stablehlo.broadcast_in_dim %c_112, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %385 = stablehlo.compare  EQ, %162, %384,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %386 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %387 = stablehlo.reshape %386 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_113 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %388 = call @_where(%385, %387, %cst_113) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %389 = stablehlo.add %383, %388 : tensor<128xf64>
    %c_114 = stablehlo.constant dense<0> : tensor<i32>
    %390 = stablehlo.broadcast_in_dim %c_114, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %391 = stablehlo.compare  EQ, %162, %390,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %392 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %393 = stablehlo.reshape %392 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_115 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %394 = call @_where(%391, %393, %cst_115) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %395 = stablehlo.add %389, %394 : tensor<128xf64>
    %c_116 = stablehlo.constant dense<-1> : tensor<i32>
    %396 = stablehlo.broadcast_in_dim %c_116, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %397 = stablehlo.compare  EQ, %162, %396,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %398 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %399 = stablehlo.reshape %398 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_117 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %400 = call @_where(%397, %399, %cst_117) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %401 = stablehlo.add %395, %400 : tensor<128xf64>
    %c_118 = stablehlo.constant dense<-2> : tensor<i32>
    %402 = stablehlo.broadcast_in_dim %c_118, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %403 = stablehlo.compare  EQ, %162, %402,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %404 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %405 = stablehlo.reshape %404 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_119 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %406 = call @_where(%403, %405, %cst_119) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %407 = stablehlo.add %401, %406 : tensor<128xf64>
    %c_120 = stablehlo.constant dense<-3> : tensor<i32>
    %408 = stablehlo.broadcast_in_dim %c_120, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %409 = stablehlo.compare  EQ, %162, %408,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %410 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %411 = stablehlo.reshape %410 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_121 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %412 = call @_where(%409, %411, %cst_121) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %413 = stablehlo.add %407, %412 : tensor<128xf64>
    %cst_122 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %414 = stablehlo.broadcast_in_dim %cst_122, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %c_123 = stablehlo.constant dense<3> : tensor<i32>
    %415 = stablehlo.broadcast_in_dim %c_123, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %416 = stablehlo.compare  EQ, %162, %415,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %417 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %418 = stablehlo.reshape %417 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_124 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %419 = call @_where(%416, %418, %cst_124) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %420 = stablehlo.add %414, %419 : tensor<128xf64>
    %c_125 = stablehlo.constant dense<2> : tensor<i32>
    %421 = stablehlo.broadcast_in_dim %c_125, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %422 = stablehlo.compare  EQ, %162, %421,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %423 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %424 = stablehlo.reshape %423 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_126 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %425 = call @_where(%422, %424, %cst_126) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %426 = stablehlo.add %420, %425 : tensor<128xf64>
    %c_127 = stablehlo.constant dense<1> : tensor<i32>
    %427 = stablehlo.broadcast_in_dim %c_127, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %428 = stablehlo.compare  EQ, %162, %427,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %429 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %430 = stablehlo.reshape %429 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_128 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %431 = call @_where(%428, %430, %cst_128) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %432 = stablehlo.add %426, %431 : tensor<128xf64>
    %c_129 = stablehlo.constant dense<0> : tensor<i32>
    %433 = stablehlo.broadcast_in_dim %c_129, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %434 = stablehlo.compare  EQ, %162, %433,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %435 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %436 = stablehlo.reshape %435 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_130 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %437 = call @_where(%434, %436, %cst_130) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %438 = stablehlo.add %432, %437 : tensor<128xf64>
    %c_131 = stablehlo.constant dense<-1> : tensor<i32>
    %439 = stablehlo.broadcast_in_dim %c_131, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %440 = stablehlo.compare  EQ, %162, %439,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %441 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %442 = stablehlo.reshape %441 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_132 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %443 = call @_where(%440, %442, %cst_132) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %444 = stablehlo.add %438, %443 : tensor<128xf64>
    %c_133 = stablehlo.constant dense<-2> : tensor<i32>
    %445 = stablehlo.broadcast_in_dim %c_133, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %446 = stablehlo.compare  EQ, %162, %445,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %447 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %448 = stablehlo.reshape %447 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_134 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %449 = call @_where(%446, %448, %cst_134) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %450 = stablehlo.add %444, %449 : tensor<128xf64>
    %cst_135 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %451 = stablehlo.broadcast_in_dim %cst_135, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %c_136 = stablehlo.constant dense<4> : tensor<i32>
    %452 = stablehlo.broadcast_in_dim %c_136, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %453 = stablehlo.compare  EQ, %162, %452,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %454 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %455 = stablehlo.reshape %454 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_137 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %456 = call @_where(%453, %455, %cst_137) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %457 = stablehlo.add %451, %456 : tensor<128xf64>
    %c_138 = stablehlo.constant dense<3> : tensor<i32>
    %458 = stablehlo.broadcast_in_dim %c_138, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %459 = stablehlo.compare  EQ, %162, %458,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %460 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %461 = stablehlo.reshape %460 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_139 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %462 = call @_where(%459, %461, %cst_139) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %463 = stablehlo.add %457, %462 : tensor<128xf64>
    %c_140 = stablehlo.constant dense<2> : tensor<i32>
    %464 = stablehlo.broadcast_in_dim %c_140, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %465 = stablehlo.compare  EQ, %162, %464,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %466 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %467 = stablehlo.reshape %466 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_141 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %468 = call @_where(%465, %467, %cst_141) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %469 = stablehlo.add %463, %468 : tensor<128xf64>
    %c_142 = stablehlo.constant dense<1> : tensor<i32>
    %470 = stablehlo.broadcast_in_dim %c_142, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %471 = stablehlo.compare  EQ, %162, %470,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %472 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %473 = stablehlo.reshape %472 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_143 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %474 = call @_where(%471, %473, %cst_143) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %475 = stablehlo.add %469, %474 : tensor<128xf64>
    %c_144 = stablehlo.constant dense<0> : tensor<i32>
    %476 = stablehlo.broadcast_in_dim %c_144, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %477 = stablehlo.compare  EQ, %162, %476,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %478 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %479 = stablehlo.reshape %478 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_145 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %480 = call @_where(%477, %479, %cst_145) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %481 = stablehlo.add %475, %480 : tensor<128xf64>
    %c_146 = stablehlo.constant dense<-1> : tensor<i32>
    %482 = stablehlo.broadcast_in_dim %c_146, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %483 = stablehlo.compare  EQ, %162, %482,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %484 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %485 = stablehlo.reshape %484 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_147 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %486 = call @_where(%483, %485, %cst_147) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %487 = stablehlo.add %481, %486 : tensor<128xf64>
    %cst_148 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %488 = stablehlo.broadcast_in_dim %cst_148, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %c_149 = stablehlo.constant dense<5> : tensor<i32>
    %489 = stablehlo.broadcast_in_dim %c_149, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %490 = stablehlo.compare  EQ, %162, %489,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %491 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %492 = stablehlo.reshape %491 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_150 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %493 = call @_where(%490, %492, %cst_150) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %494 = stablehlo.add %488, %493 : tensor<128xf64>
    %c_151 = stablehlo.constant dense<4> : tensor<i32>
    %495 = stablehlo.broadcast_in_dim %c_151, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %496 = stablehlo.compare  EQ, %162, %495,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %497 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %498 = stablehlo.reshape %497 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_152 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %499 = call @_where(%496, %498, %cst_152) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %500 = stablehlo.add %494, %499 : tensor<128xf64>
    %c_153 = stablehlo.constant dense<3> : tensor<i32>
    %501 = stablehlo.broadcast_in_dim %c_153, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %502 = stablehlo.compare  EQ, %162, %501,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %503 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %504 = stablehlo.reshape %503 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_154 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %505 = call @_where(%502, %504, %cst_154) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %506 = stablehlo.add %500, %505 : tensor<128xf64>
    %c_155 = stablehlo.constant dense<2> : tensor<i32>
    %507 = stablehlo.broadcast_in_dim %c_155, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %508 = stablehlo.compare  EQ, %162, %507,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %509 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %510 = stablehlo.reshape %509 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_156 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %511 = call @_where(%508, %510, %cst_156) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %512 = stablehlo.add %506, %511 : tensor<128xf64>
    %c_157 = stablehlo.constant dense<1> : tensor<i32>
    %513 = stablehlo.broadcast_in_dim %c_157, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %514 = stablehlo.compare  EQ, %162, %513,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %515 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %516 = stablehlo.reshape %515 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_158 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %517 = call @_where(%514, %516, %cst_158) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %518 = stablehlo.add %512, %517 : tensor<128xf64>
    %c_159 = stablehlo.constant dense<0> : tensor<i32>
    %519 = stablehlo.broadcast_in_dim %c_159, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %520 = stablehlo.compare  EQ, %162, %519,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %521 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %522 = stablehlo.reshape %521 : (tensor<1x128xf64>) -> tensor<128xf64>
    %cst_160 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %523 = call @_where(%520, %522, %cst_160) : (tensor<128xi1>, tensor<128xf64>, tensor<f64>) -> tensor<128xf64>
    %524 = stablehlo.add %518, %523 : tensor<128xf64>
    %525 = stablehlo.broadcast_in_dim %302, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %526 = stablehlo.broadcast_in_dim %339, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %527 = stablehlo.broadcast_in_dim %376, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %528 = stablehlo.broadcast_in_dim %413, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %529 = stablehlo.broadcast_in_dim %450, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %530 = stablehlo.broadcast_in_dim %487, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %531 = stablehlo.broadcast_in_dim %524, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %532 = stablehlo.concatenate %525, %526, %527, %528, %529, %530, %531, dim = 0 : (tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>, tensor<1x128xf64>) -> tensor<7x128xf64>
    %c_161 = stablehlo.constant dense<0> : tensor<i64>
    %533 = call @_pad(%154, %c_161) : (tensor<128x128xf64>, tensor<i64>) -> tensor<128x134xf64>
    %cst_162 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %534 = stablehlo.broadcast_in_dim %cst_162, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %535 = stablehlo.slice %532 [0:1, 0:128] : (tensor<7x128xf64>) -> tensor<1x128xf64>
    %536 = stablehlo.reshape %535 : (tensor<1x128xf64>) -> tensor<128xf64>
    %537 = stablehlo.broadcast_in_dim %536, dims = [0] : (tensor<128xf64>) -> tensor<128x1xf64>
    %538 = stablehlo.slice %533 [0:128, 6:134] : (tensor<128x134xf64>) -> tensor<128x128xf64>
    %539 = stablehlo.broadcast_in_dim %537, dims = [0, 1] : (tensor<128x1xf64>) -> tensor<128x128xf64>
    %540 = stablehlo.multiply %539, %538 : tensor<128x128xf64>
    %541 = stablehlo.add %534, %540 : tensor<128x128xf64>
    %542 = stablehlo.slice %532 [1:2, 0:128] : (tensor<7x128xf64>) -> tensor<1x128xf64>
    %543 = stablehlo.reshape %542 : (tensor<1x128xf64>) -> tensor<128xf64>
    %544 = stablehlo.broadcast_in_dim %543, dims = [0] : (tensor<128xf64>) -> tensor<128x1xf64>
    %545 = stablehlo.slice %533 [0:128, 5:133] : (tensor<128x134xf64>) -> tensor<128x128xf64>
    %546 = stablehlo.broadcast_in_dim %544, dims = [0, 1] : (tensor<128x1xf64>) -> tensor<128x128xf64>
    %547 = stablehlo.multiply %546, %545 : tensor<128x128xf64>
    %548 = stablehlo.add %541, %547 : tensor<128x128xf64>
    %549 = stablehlo.slice %532 [2:3, 0:128] : (tensor<7x128xf64>) -> tensor<1x128xf64>
    %550 = stablehlo.reshape %549 : (tensor<1x128xf64>) -> tensor<128xf64>
    %551 = stablehlo.broadcast_in_dim %550, dims = [0] : (tensor<128xf64>) -> tensor<128x1xf64>
    %552 = stablehlo.slice %533 [0:128, 4:132] : (tensor<128x134xf64>) -> tensor<128x128xf64>
    %553 = stablehlo.broadcast_in_dim %551, dims = [0, 1] : (tensor<128x1xf64>) -> tensor<128x128xf64>
    %554 = stablehlo.multiply %553, %552 : tensor<128x128xf64>
    %555 = stablehlo.add %548, %554 : tensor<128x128xf64>
    %556 = stablehlo.slice %532 [3:4, 0:128] : (tensor<7x128xf64>) -> tensor<1x128xf64>
    %557 = stablehlo.reshape %556 : (tensor<1x128xf64>) -> tensor<128xf64>
    %558 = stablehlo.broadcast_in_dim %557, dims = [0] : (tensor<128xf64>) -> tensor<128x1xf64>
    %559 = stablehlo.slice %533 [0:128, 3:131] : (tensor<128x134xf64>) -> tensor<128x128xf64>
    %560 = stablehlo.broadcast_in_dim %558, dims = [0, 1] : (tensor<128x1xf64>) -> tensor<128x128xf64>
    %561 = stablehlo.multiply %560, %559 : tensor<128x128xf64>
    %562 = stablehlo.add %555, %561 : tensor<128x128xf64>
    %563 = stablehlo.slice %532 [4:5, 0:128] : (tensor<7x128xf64>) -> tensor<1x128xf64>
    %564 = stablehlo.reshape %563 : (tensor<1x128xf64>) -> tensor<128xf64>
    %565 = stablehlo.broadcast_in_dim %564, dims = [0] : (tensor<128xf64>) -> tensor<128x1xf64>
    %566 = stablehlo.slice %533 [0:128, 2:130] : (tensor<128x134xf64>) -> tensor<128x128xf64>
    %567 = stablehlo.broadcast_in_dim %565, dims = [0, 1] : (tensor<128x1xf64>) -> tensor<128x128xf64>
    %568 = stablehlo.multiply %567, %566 : tensor<128x128xf64>
    %569 = stablehlo.add %562, %568 : tensor<128x128xf64>
    %570 = stablehlo.slice %532 [5:6, 0:128] : (tensor<7x128xf64>) -> tensor<1x128xf64>
    %571 = stablehlo.reshape %570 : (tensor<1x128xf64>) -> tensor<128xf64>
    %572 = stablehlo.broadcast_in_dim %571, dims = [0] : (tensor<128xf64>) -> tensor<128x1xf64>
    %573 = stablehlo.slice %533 [0:128, 1:129] : (tensor<128x134xf64>) -> tensor<128x128xf64>
    %574 = stablehlo.broadcast_in_dim %572, dims = [0, 1] : (tensor<128x1xf64>) -> tensor<128x128xf64>
    %575 = stablehlo.multiply %574, %573 : tensor<128x128xf64>
    %576 = stablehlo.add %569, %575 : tensor<128x128xf64>
    %577 = stablehlo.slice %532 [6:7, 0:128] : (tensor<7x128xf64>) -> tensor<1x128xf64>
    %578 = stablehlo.reshape %577 : (tensor<1x128xf64>) -> tensor<128xf64>
    %579 = stablehlo.broadcast_in_dim %578, dims = [0] : (tensor<128xf64>) -> tensor<128x1xf64>
    %580 = stablehlo.slice %533 [0:128, 0:128] : (tensor<128x134xf64>) -> tensor<128x128xf64>
    %581 = stablehlo.broadcast_in_dim %579, dims = [0, 1] : (tensor<128x1xf64>) -> tensor<128x128xf64>
    %582 = stablehlo.multiply %581, %580 : tensor<128x128xf64>
    %583 = stablehlo.add %576, %582 : tensor<128x128xf64>
    %584 = stablehlo.slice %583 [0:128, 0:14] : (tensor<128x128xf64>) -> tensor<128x14xf64>
    %585 = call @_roll_static(%584) : (tensor<128x14xf64>) -> tensor<128x14xf64>
    %586 = stablehlo.slice %583 [0:128, 14:64] : (tensor<128x128xf64>) -> tensor<128x50xf64>
    %587 = call @_roll_static_6(%586) : (tensor<128x50xf64>) -> tensor<128x50xf64>
    %588 = stablehlo.slice %583 [0:128, 64:114] : (tensor<128x128xf64>) -> tensor<128x50xf64>
    %589 = call @_roll_static_11(%588) : (tensor<128x50xf64>) -> tensor<128x50xf64>
    %590 = stablehlo.slice %583 [0:128, 114:128] : (tensor<128x128xf64>) -> tensor<128x14xf64>
    %591 = call @_roll_static_16(%590) : (tensor<128x14xf64>) -> tensor<128x14xf64>
    %592 = stablehlo.concatenate %585, %587, %589, %591, dim = 1 : (tensor<128x14xf64>, tensor<128x50xf64>, tensor<128x50xf64>, tensor<128x14xf64>) -> tensor<128x128xf64>
    %cst_163 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %593 = stablehlo.broadcast_in_dim %cst_163, dims = [] : (tensor<f64>) -> tensor<128x128xf64>
    %594 = call @_roll_static_22(%592) : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %595 = stablehlo.slice %102 [0:1, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %596 = stablehlo.reshape %595 : (tensor<1x128xf64>) -> tensor<128xf64>
    %597 = stablehlo.broadcast_in_dim %596, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %598 = stablehlo.broadcast_in_dim %597, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %599 = stablehlo.multiply %594, %598 : tensor<128x128xf64>
    %600 = stablehlo.add %593, %599 : tensor<128x128xf64>
    %601 = call @_roll_static_29(%592) : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %602 = stablehlo.slice %102 [1:2, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %603 = stablehlo.reshape %602 : (tensor<1x128xf64>) -> tensor<128xf64>
    %604 = stablehlo.broadcast_in_dim %603, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %605 = stablehlo.broadcast_in_dim %604, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %606 = stablehlo.multiply %601, %605 : tensor<128x128xf64>
    %607 = stablehlo.add %600, %606 : tensor<128x128xf64>
    %608 = call @_roll_static_34(%592) : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %609 = stablehlo.slice %102 [2:3, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %610 = stablehlo.reshape %609 : (tensor<1x128xf64>) -> tensor<128xf64>
    %611 = stablehlo.broadcast_in_dim %610, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %612 = stablehlo.broadcast_in_dim %611, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %613 = stablehlo.multiply %608, %612 : tensor<128x128xf64>
    %614 = stablehlo.add %607, %613 : tensor<128x128xf64>
    %615 = call @_roll_static_39(%592) : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %616 = stablehlo.slice %102 [3:4, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %617 = stablehlo.reshape %616 : (tensor<1x128xf64>) -> tensor<128xf64>
    %618 = stablehlo.broadcast_in_dim %617, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %619 = stablehlo.broadcast_in_dim %618, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %620 = stablehlo.multiply %615, %619 : tensor<128x128xf64>
    %621 = stablehlo.add %614, %620 : tensor<128x128xf64>
    %622 = call @_roll_static_44(%592) : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %623 = stablehlo.slice %102 [4:5, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %624 = stablehlo.reshape %623 : (tensor<1x128xf64>) -> tensor<128xf64>
    %625 = stablehlo.broadcast_in_dim %624, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %626 = stablehlo.broadcast_in_dim %625, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %627 = stablehlo.multiply %622, %626 : tensor<128x128xf64>
    %628 = stablehlo.add %621, %627 : tensor<128x128xf64>
    %629 = call @_roll_static_49(%592) : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %630 = stablehlo.slice %102 [5:6, 0:128] : (tensor<6x128xf64>) -> tensor<1x128xf64>
    %631 = stablehlo.reshape %630 : (tensor<1x128xf64>) -> tensor<128xf64>
    %632 = stablehlo.broadcast_in_dim %631, dims = [1] : (tensor<128xf64>) -> tensor<1x128xf64>
    %633 = stablehlo.broadcast_in_dim %632, dims = [0, 1] : (tensor<1x128xf64>) -> tensor<128x128xf64>
    %634 = stablehlo.multiply %629, %633 : tensor<128x128xf64>
    %635 = stablehlo.add %628, %634 : tensor<128x128xf64>
    return %635, %155#1, %155#2 : tensor<128x128xf64>, tensor<128xf64>, tensor<128xf64>
  }
  func.func private @_roll_static(%arg0: tensor<128x14xf64>) -> tensor<128x14xf64> {
    %0 = stablehlo.slice %arg0 [2:128, 0:14] : (tensor<128x14xf64>) -> tensor<126x14xf64>
    %1 = stablehlo.slice %arg0 [0:2, 0:14] : (tensor<128x14xf64>) -> tensor<2x14xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<126x14xf64>, tensor<2x14xf64>) -> tensor<128x14xf64>
    return %2 : tensor<128x14xf64>
  }
  func.func private @_roll_static_6(%arg0: tensor<128x50xf64>) -> tensor<128x50xf64> {
    %0 = stablehlo.slice %arg0 [1:128, 0:50] : (tensor<128x50xf64>) -> tensor<127x50xf64>
    %1 = stablehlo.slice %arg0 [0:1, 0:50] : (tensor<128x50xf64>) -> tensor<1x50xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<127x50xf64>, tensor<1x50xf64>) -> tensor<128x50xf64>
    return %2 : tensor<128x50xf64>
  }
  func.func private @_roll_static_11(%arg0: tensor<128x50xf64>) -> tensor<128x50xf64> {
    %0 = stablehlo.slice %arg0 [0:128, 0:50] : (tensor<128x50xf64>) -> tensor<128x50xf64>
    %1 = stablehlo.slice %arg0 [0:0, 0:50] : (tensor<128x50xf64>) -> tensor<0x50xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<128x50xf64>, tensor<0x50xf64>) -> tensor<128x50xf64>
    return %2 : tensor<128x50xf64>
  }
  func.func private @_roll_static_16(%arg0: tensor<128x14xf64>) -> tensor<128x14xf64> {
    %0 = stablehlo.slice %arg0 [127:128, 0:14] : (tensor<128x14xf64>) -> tensor<1x14xf64>
    %1 = stablehlo.slice %arg0 [0:127, 0:14] : (tensor<128x14xf64>) -> tensor<127x14xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<1x14xf64>, tensor<127x14xf64>) -> tensor<128x14xf64>
    return %2 : tensor<128x14xf64>
  }
  func.func private @_roll_static_22(%arg0: tensor<128x128xf64>) -> tensor<128x128xf64> {
    %0 = stablehlo.slice %arg0 [2:128, 0:128] : (tensor<128x128xf64>) -> tensor<126x128xf64>
    %1 = stablehlo.slice %arg0 [0:2, 0:128] : (tensor<128x128xf64>) -> tensor<2x128xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<126x128xf64>, tensor<2x128xf64>) -> tensor<128x128xf64>
    return %2 : tensor<128x128xf64>
  }
  func.func private @_roll_static_29(%arg0: tensor<128x128xf64>) -> tensor<128x128xf64> {
    %0 = stablehlo.slice %arg0 [1:128, 0:128] : (tensor<128x128xf64>) -> tensor<127x128xf64>
    %1 = stablehlo.slice %arg0 [0:1, 0:128] : (tensor<128x128xf64>) -> tensor<1x128xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<127x128xf64>, tensor<1x128xf64>) -> tensor<128x128xf64>
    return %2 : tensor<128x128xf64>
  }
  func.func private @_roll_static_34(%arg0: tensor<128x128xf64>) -> tensor<128x128xf64> {
    %0 = stablehlo.slice %arg0 [0:128, 0:128] : (tensor<128x128xf64>) -> tensor<128x128xf64>
    %1 = stablehlo.slice %arg0 [0:0, 0:128] : (tensor<128x128xf64>) -> tensor<0x128xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<128x128xf64>, tensor<0x128xf64>) -> tensor<128x128xf64>
    return %2 : tensor<128x128xf64>
  }
  func.func private @_roll_static_39(%arg0: tensor<128x128xf64>) -> tensor<128x128xf64> {
    %0 = stablehlo.slice %arg0 [127:128, 0:128] : (tensor<128x128xf64>) -> tensor<1x128xf64>
    %1 = stablehlo.slice %arg0 [0:127, 0:128] : (tensor<128x128xf64>) -> tensor<127x128xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<1x128xf64>, tensor<127x128xf64>) -> tensor<128x128xf64>
    return %2 : tensor<128x128xf64>
  }
  func.func private @_roll_static_44(%arg0: tensor<128x128xf64>) -> tensor<128x128xf64> {
    %0 = stablehlo.slice %arg0 [126:128, 0:128] : (tensor<128x128xf64>) -> tensor<2x128xf64>
    %1 = stablehlo.slice %arg0 [0:126, 0:128] : (tensor<128x128xf64>) -> tensor<126x128xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<2x128xf64>, tensor<126x128xf64>) -> tensor<128x128xf64>
    return %2 : tensor<128x128xf64>
  }
  func.func private @_roll_static_49(%arg0: tensor<128x128xf64>) -> tensor<128x128xf64> {
    %0 = stablehlo.slice %arg0 [125:128, 0:128] : (tensor<128x128xf64>) -> tensor<3x128xf64>
    %1 = stablehlo.slice %arg0 [0:125, 0:128] : (tensor<128x128xf64>) -> tensor<125x128xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<3x128xf64>, tensor<125x128xf64>) -> tensor<128x128xf64>
    return %2 : tensor<128x128xf64>
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
    %11 = call @fft_60(%10) : (tensor<65xcomplex<f64>>) -> tensor<128xf64>
    %12 = stablehlo.multiply %arg1, %arg1 : tensor<65xf64>
    %13 = stablehlo.convert %12 : (tensor<65xf64>) -> tensor<65xcomplex<f64>>
    %14 = stablehlo.multiply %6, %13 : tensor<65xcomplex<f64>>
    %15 = call @fft_60(%14) : (tensor<65xcomplex<f64>>) -> tensor<128xf64>
    return %11, %5, %15 : tensor<128xf64>, tensor<128xf64>, tensor<128xf64>
  }
  func.func private @fft(%arg0: tensor<128xf64>) -> tensor<65xcomplex<f64>> {
    %0 = stablehlo.fft %arg0, type =  RFFT, length = [128] : (tensor<128xf64>) -> tensor<65xcomplex<f64>>
    return %0 : tensor<65xcomplex<f64>>
  }
  func.func private @fft_60(%arg0: tensor<65xcomplex<f64>>) -> tensor<128xf64> {
    %0 = stablehlo.fft %arg0, type =  IRFFT, length = [128] : (tensor<65xcomplex<f64>>) -> tensor<128xf64>
    return %0 : tensor<128xf64>
  }
  func.func private @_where(%arg0: tensor<128xi1>, %arg1: tensor<128xf64>, %arg2: tensor<f64>) -> tensor<128xf64> {
    %0 = stablehlo.convert %arg2 : tensor<f64>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f64>) -> tensor<128xf64>
    %2 = stablehlo.select %arg0, %arg1, %1 : tensor<128xi1>, tensor<128xf64>
    return %2 : tensor<128xf64>
  }
  func.func private @_pad(%arg0: tensor<128x128xf64>, %arg1: tensor<i64>) -> tensor<128x134xf64> {
    %0 = stablehlo.convert %arg1 : (tensor<i64>) -> tensor<f64>
    %1 = stablehlo.pad %arg0, %0, low = [0, 3], high = [0, 3], interior = [0, 0] : (tensor<128x128xf64>, tensor<f64>) -> tensor<128x134xf64>
    return %1 : tensor<128x134xf64>
  }
}
