module @jit_heat_step_conv attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<32x32x32xf32>, %arg1: tensor<f32>) -> (tensor<32x32x32xf32> {jax.result_info = "result"}) {
    %cst = stablehlo.constant dense<[[[1.000000e+00, -2.000000e+00, 1.000000e+00]]]> : tensor<1x1x3xf32>
    %0 = call @heat_step_conv(%arg0, %arg1, %cst) : (tensor<32x32x32xf32>, tensor<f32>, tensor<1x1x3xf32>) -> tensor<32x32x32xf32>
    return %0 : tensor<32x32x32xf32>
  }
  func.func private @heat_step_conv(%arg0: tensor<32x32x32xf32>, %arg1: tensor<f32>, %arg2: tensor<1x1x3xf32>) -> tensor<32x32x32xf32> {
    %0 = stablehlo.transpose %arg0, dims = [1, 2, 0] : (tensor<32x32x32xf32>) -> tensor<32x32x32xf32>
    %1 = stablehlo.reshape %0 : (tensor<32x32x32xf32>) -> tensor<1024x1x32xf32>
    %2 = stablehlo.slice %1 [0:1024, 0:1, 31:32] : (tensor<1024x1x32xf32>) -> tensor<1024x1x1xf32>
    %3 = stablehlo.slice %1 [0:1024, 0:1, 0:1] : (tensor<1024x1x32xf32>) -> tensor<1024x1x1xf32>
    %4 = stablehlo.concatenate %2, %1, %3, dim = 2 : (tensor<1024x1x1xf32>, tensor<1024x1x32xf32>, tensor<1024x1x1xf32>) -> tensor<1024x1x34xf32>
    %5 = stablehlo.convolution(%4, %arg2) dim_numbers = [b, f, 0]x[o, i, 0]->[b, f, 0], window = {stride = [1], pad = [[0, 0]], lhs_dilate = [1], rhs_dilate = [1], reverse = [false]} {batch_group_count = 1 : i64, feature_group_count = 1 : i64, precision_config = [#stablehlo<precision DEFAULT>, #stablehlo<precision DEFAULT>]} : (tensor<1024x1x34xf32>, tensor<1x1x3xf32>) -> tensor<1024x1x32xf32>
    %6 = stablehlo.reshape %5 : (tensor<1024x1x32xf32>) -> tensor<32x32x32xf32>
    %7 = stablehlo.transpose %6, dims = [2, 0, 1] : (tensor<32x32x32xf32>) -> tensor<32x32x32xf32>
    %8 = stablehlo.transpose %arg0, dims = [0, 2, 1] : (tensor<32x32x32xf32>) -> tensor<32x32x32xf32>
    %9 = stablehlo.reshape %8 : (tensor<32x32x32xf32>) -> tensor<1024x1x32xf32>
    %10 = stablehlo.slice %9 [0:1024, 0:1, 31:32] : (tensor<1024x1x32xf32>) -> tensor<1024x1x1xf32>
    %11 = stablehlo.slice %9 [0:1024, 0:1, 0:1] : (tensor<1024x1x32xf32>) -> tensor<1024x1x1xf32>
    %12 = stablehlo.concatenate %10, %9, %11, dim = 2 : (tensor<1024x1x1xf32>, tensor<1024x1x32xf32>, tensor<1024x1x1xf32>) -> tensor<1024x1x34xf32>
    %13 = stablehlo.convolution(%12, %arg2) dim_numbers = [b, f, 0]x[o, i, 0]->[b, f, 0], window = {stride = [1], pad = [[0, 0]], lhs_dilate = [1], rhs_dilate = [1], reverse = [false]} {batch_group_count = 1 : i64, feature_group_count = 1 : i64, precision_config = [#stablehlo<precision DEFAULT>, #stablehlo<precision DEFAULT>]} : (tensor<1024x1x34xf32>, tensor<1x1x3xf32>) -> tensor<1024x1x32xf32>
    %14 = stablehlo.reshape %13 : (tensor<1024x1x32xf32>) -> tensor<32x32x32xf32>
    %15 = stablehlo.transpose %14, dims = [0, 2, 1] : (tensor<32x32x32xf32>) -> tensor<32x32x32xf32>
    %16 = stablehlo.add %7, %15 : tensor<32x32x32xf32>
    %17 = stablehlo.reshape %arg0 : (tensor<32x32x32xf32>) -> tensor<1024x1x32xf32>
    %18 = stablehlo.slice %17 [0:1024, 0:1, 31:32] : (tensor<1024x1x32xf32>) -> tensor<1024x1x1xf32>
    %19 = stablehlo.slice %17 [0:1024, 0:1, 0:1] : (tensor<1024x1x32xf32>) -> tensor<1024x1x1xf32>
    %20 = stablehlo.concatenate %18, %17, %19, dim = 2 : (tensor<1024x1x1xf32>, tensor<1024x1x32xf32>, tensor<1024x1x1xf32>) -> tensor<1024x1x34xf32>
    %21 = stablehlo.convolution(%20, %arg2) dim_numbers = [b, f, 0]x[o, i, 0]->[b, f, 0], window = {stride = [1], pad = [[0, 0]], lhs_dilate = [1], rhs_dilate = [1], reverse = [false]} {batch_group_count = 1 : i64, feature_group_count = 1 : i64, precision_config = [#stablehlo<precision DEFAULT>, #stablehlo<precision DEFAULT>]} : (tensor<1024x1x34xf32>, tensor<1x1x3xf32>) -> tensor<1024x1x32xf32>
    %22 = stablehlo.reshape %21 : (tensor<1024x1x32xf32>) -> tensor<32x32x32xf32>
    %23 = stablehlo.add %16, %22 : tensor<32x32x32xf32>
    %24 = stablehlo.convert %arg1 : tensor<f32>
    %25 = stablehlo.broadcast_in_dim %24, dims = [] : (tensor<f32>) -> tensor<32x32x32xf32>
    %26 = stablehlo.multiply %25, %23 : tensor<32x32x32xf32>
    %27 = stablehlo.add %arg0, %26 : tensor<32x32x32xf32>
    return %27 : tensor<32x32x32xf32>
  }
}
