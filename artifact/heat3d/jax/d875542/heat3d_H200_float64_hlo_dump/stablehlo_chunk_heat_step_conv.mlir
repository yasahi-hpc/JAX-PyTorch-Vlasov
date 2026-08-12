module @jit_run_chunk attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<32x32x32xf64>, %arg1: tensor<f64>, %arg2: tensor<i64>) -> (tensor<32xf64> {jax.result_info = "result[0][0]"}, tensor<32xf64> {jax.result_info = "result[0][1]"}, tensor<32xf64> {jax.result_info = "result[0][2]"}, tensor<32x32x32xf64> {jax.result_info = "result[1][0]"}, tensor<f64> {jax.result_info = "result[2]"}, tensor<i64> {jax.result_info = "result[3]"}) {
    %cst = stablehlo.constant dense<[[[1.000000e+00, -2.000000e+00, 1.000000e+00]]]> : tensor<1x1x3xf64>
    %cst_0 = stablehlo.constant dense<[0.000000e+00, 0.19634954084936207, 0.39269908169872414, 0.58904862254808621, 0.78539816339744828, 0.98174770424681035, 1.1780972450961724, 1.3744467859455345, 1.5707963267948966, 1.7671458676442586, 1.9634954084936207, 2.1598449493429825, 2.3561944901923448, 2.5525440310417071, 2.748893571891069, 2.9452431127404308, 3.1415926535897931, 3.3379421944391554, 3.5342917352885173, 3.7306412761378791, 3.9269908169872414, 4.1233403578366037, 4.3196898986859651, 4.5160394395353274, 4.7123889803846897, 4.908738521234052, 5.1050880620834143, 5.3014376029327757, 5.497787143782138, 5.6941366846315002, 5.8904862254808616, 6.0868357663302239]> : tensor<32xf64>
    %cst_1 = stablehlo.constant dense<[0.000000e+00, 0.19634954084936207, 0.39269908169872414, 0.58904862254808621, 0.78539816339744828, 0.98174770424681035, 1.1780972450961724, 1.3744467859455345, 1.5707963267948966, 1.7671458676442586, 1.9634954084936207, 2.1598449493429825, 2.3561944901923448, 2.5525440310417071, 2.748893571891069, 2.9452431127404308, 3.1415926535897931, 3.3379421944391554, 3.5342917352885173, 3.7306412761378791, 3.9269908169872414, 4.1233403578366037, 4.3196898986859651, 4.5160394395353274, 4.7123889803846897, 4.908738521234052, 5.1050880620834143, 5.3014376029327757, 5.497787143782138, 5.6941366846315002, 5.8904862254808616, 6.0868357663302239]> : tensor<32xf64>
    %cst_2 = stablehlo.constant dense<[0.000000e+00, 0.19634954084936207, 0.39269908169872414, 0.58904862254808621, 0.78539816339744828, 0.98174770424681035, 1.1780972450961724, 1.3744467859455345, 1.5707963267948966, 1.7671458676442586, 1.9634954084936207, 2.1598449493429825, 2.3561944901923448, 2.5525440310417071, 2.748893571891069, 2.9452431127404308, 3.1415926535897931, 3.3379421944391554, 3.5342917352885173, 3.7306412761378791, 3.9269908169872414, 4.1233403578366037, 4.3196898986859651, 4.5160394395353274, 4.7123889803846897, 4.908738521234052, 5.1050880620834143, 5.3014376029327757, 5.497787143782138, 5.6941366846315002, 5.8904862254808616, 6.0868357663302239]> : tensor<32xf64>
    %c = stablehlo.constant dense<0> : tensor<i64>
    %0:3 = stablehlo.while(%iterArg = %cst, %iterArg_5 = %c, %iterArg_6 = %arg0) : tensor<1x1x3xf64>, tensor<i64>, tensor<32x32x32xf64>
    cond {
      %c_7 = stablehlo.constant dense<100> : tensor<i64>
      %3 = stablehlo.compare  LT, %iterArg_5, %c_7,  SIGNED : (tensor<i64>, tensor<i64>) -> tensor<i1>
      stablehlo.return %3 : tensor<i1>
    } do {
      %3 = func.call @closed_call(%iterArg, %iterArg_6) : (tensor<1x1x3xf64>, tensor<32x32x32xf64>) -> tensor<32x32x32xf64>
      %c_7 = stablehlo.constant dense<1> : tensor<i64>
      %4 = stablehlo.add %iterArg_5, %c_7 : tensor<i64>
      stablehlo.return %iterArg, %4, %3 : tensor<1x1x3xf64>, tensor<i64>, tensor<32x32x32xf64>
    }
    %cst_3 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %1 = stablehlo.add %arg1, %cst_3 : tensor<f64>
    %c_4 = stablehlo.constant dense<100> : tensor<i64>
    %2 = stablehlo.add %arg2, %c_4 : tensor<i64>
    return %cst_0, %cst_1, %cst_2, %0#2, %1, %2 : tensor<32xf64>, tensor<32xf64>, tensor<32xf64>, tensor<32x32x32xf64>, tensor<f64>, tensor<i64>
  }
  func.func private @closed_call(%arg0: tensor<1x1x3xf64>, %arg1: tensor<32x32x32xf64>) -> tensor<32x32x32xf64> {
    %cst = stablehlo.constant dense<5.1876446024876944E-4> : tensor<f64>
    %0 = call @heat_step_conv(%arg1, %cst, %arg0) : (tensor<32x32x32xf64>, tensor<f64>, tensor<1x1x3xf64>) -> tensor<32x32x32xf64>
    return %0 : tensor<32x32x32xf64>
  }
  func.func private @heat_step_conv(%arg0: tensor<32x32x32xf64>, %arg1: tensor<f64>, %arg2: tensor<1x1x3xf64>) -> tensor<32x32x32xf64> {
    %0 = stablehlo.transpose %arg0, dims = [1, 2, 0] : (tensor<32x32x32xf64>) -> tensor<32x32x32xf64>
    %1 = stablehlo.reshape %0 : (tensor<32x32x32xf64>) -> tensor<1024x1x32xf64>
    %2 = stablehlo.slice %1 [0:1024, 0:1, 31:32] : (tensor<1024x1x32xf64>) -> tensor<1024x1x1xf64>
    %3 = stablehlo.slice %1 [0:1024, 0:1, 0:1] : (tensor<1024x1x32xf64>) -> tensor<1024x1x1xf64>
    %4 = stablehlo.concatenate %2, %1, %3, dim = 2 : (tensor<1024x1x1xf64>, tensor<1024x1x32xf64>, tensor<1024x1x1xf64>) -> tensor<1024x1x34xf64>
    %5 = stablehlo.convolution(%4, %arg2) dim_numbers = [b, f, 0]x[o, i, 0]->[b, f, 0], window = {stride = [1], pad = [[0, 0]], lhs_dilate = [1], rhs_dilate = [1], reverse = [false]} {batch_group_count = 1 : i64, feature_group_count = 1 : i64, precision_config = [#stablehlo<precision DEFAULT>, #stablehlo<precision DEFAULT>]} : (tensor<1024x1x34xf64>, tensor<1x1x3xf64>) -> tensor<1024x1x32xf64>
    %6 = stablehlo.reshape %5 : (tensor<1024x1x32xf64>) -> tensor<32x32x32xf64>
    %7 = stablehlo.transpose %6, dims = [2, 0, 1] : (tensor<32x32x32xf64>) -> tensor<32x32x32xf64>
    %8 = stablehlo.transpose %arg0, dims = [0, 2, 1] : (tensor<32x32x32xf64>) -> tensor<32x32x32xf64>
    %9 = stablehlo.reshape %8 : (tensor<32x32x32xf64>) -> tensor<1024x1x32xf64>
    %10 = stablehlo.slice %9 [0:1024, 0:1, 31:32] : (tensor<1024x1x32xf64>) -> tensor<1024x1x1xf64>
    %11 = stablehlo.slice %9 [0:1024, 0:1, 0:1] : (tensor<1024x1x32xf64>) -> tensor<1024x1x1xf64>
    %12 = stablehlo.concatenate %10, %9, %11, dim = 2 : (tensor<1024x1x1xf64>, tensor<1024x1x32xf64>, tensor<1024x1x1xf64>) -> tensor<1024x1x34xf64>
    %13 = stablehlo.convolution(%12, %arg2) dim_numbers = [b, f, 0]x[o, i, 0]->[b, f, 0], window = {stride = [1], pad = [[0, 0]], lhs_dilate = [1], rhs_dilate = [1], reverse = [false]} {batch_group_count = 1 : i64, feature_group_count = 1 : i64, precision_config = [#stablehlo<precision DEFAULT>, #stablehlo<precision DEFAULT>]} : (tensor<1024x1x34xf64>, tensor<1x1x3xf64>) -> tensor<1024x1x32xf64>
    %14 = stablehlo.reshape %13 : (tensor<1024x1x32xf64>) -> tensor<32x32x32xf64>
    %15 = stablehlo.transpose %14, dims = [0, 2, 1] : (tensor<32x32x32xf64>) -> tensor<32x32x32xf64>
    %16 = stablehlo.add %7, %15 : tensor<32x32x32xf64>
    %17 = stablehlo.reshape %arg0 : (tensor<32x32x32xf64>) -> tensor<1024x1x32xf64>
    %18 = stablehlo.slice %17 [0:1024, 0:1, 31:32] : (tensor<1024x1x32xf64>) -> tensor<1024x1x1xf64>
    %19 = stablehlo.slice %17 [0:1024, 0:1, 0:1] : (tensor<1024x1x32xf64>) -> tensor<1024x1x1xf64>
    %20 = stablehlo.concatenate %18, %17, %19, dim = 2 : (tensor<1024x1x1xf64>, tensor<1024x1x32xf64>, tensor<1024x1x1xf64>) -> tensor<1024x1x34xf64>
    %21 = stablehlo.convolution(%20, %arg2) dim_numbers = [b, f, 0]x[o, i, 0]->[b, f, 0], window = {stride = [1], pad = [[0, 0]], lhs_dilate = [1], rhs_dilate = [1], reverse = [false]} {batch_group_count = 1 : i64, feature_group_count = 1 : i64, precision_config = [#stablehlo<precision DEFAULT>, #stablehlo<precision DEFAULT>]} : (tensor<1024x1x34xf64>, tensor<1x1x3xf64>) -> tensor<1024x1x32xf64>
    %22 = stablehlo.reshape %21 : (tensor<1024x1x32xf64>) -> tensor<32x32x32xf64>
    %23 = stablehlo.add %16, %22 : tensor<32x32x32xf64>
    %24 = stablehlo.convert %arg1 : tensor<f64>
    %25 = stablehlo.broadcast_in_dim %24, dims = [] : (tensor<f64>) -> tensor<32x32x32xf64>
    %26 = stablehlo.multiply %25, %23 : tensor<32x32x32xf64>
    %27 = stablehlo.add %arg0, %26 : tensor<32x32x32xf64>
    return %27 : tensor<32x32x32xf64>
  }
}
