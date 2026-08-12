module @jit_run_chunk attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<32x32x32xf32>, %arg1: tensor<f32>, %arg2: tensor<i32>) -> (tensor<32xf32> {jax.result_info = "[<flat index 0>][<flat index 0>]"}, tensor<32xf32> {jax.result_info = "[<flat index 0>][<flat index 1>]"}, tensor<32xf32> {jax.result_info = "[<flat index 0>][<flat index 2>]"}, tensor<32x32x32xf32> {jax.result_info = "[<flat index 1>][<flat index 0>]"}, tensor<f32> {jax.result_info = "[<flat index 2>]"}, tensor<i32> {jax.result_info = "[<flat index 3>]"}) {
    %cst = stablehlo.constant dense<[[[1.000000e+00, -2.000000e+00, 1.000000e+00]]]> : tensor<1x1x3xf32>
    %cst_0 = stablehlo.constant dense<[0.000000e+00, 0.196349546, 0.392699093, 0.589048624, 0.785398185, 0.981747746, 1.17809725, 1.37444687, 1.57079637, 1.76714587, 1.96349549, 2.15984511, 2.3561945, 2.55254412, 2.74889374, 2.94524312, 3.14159274, 3.33794236, 3.53429174, 3.73064137, 3.92699099, 4.12334061, 4.319690e+00, 4.51603937, 4.71238899, 4.90873861, 5.10508823, 5.30143785, 5.49778748, 5.69413662, 5.89048624, 6.08683586]> : tensor<32xf32>
    %cst_1 = stablehlo.constant dense<[0.000000e+00, 0.196349546, 0.392699093, 0.589048624, 0.785398185, 0.981747746, 1.17809725, 1.37444687, 1.57079637, 1.76714587, 1.96349549, 2.15984511, 2.3561945, 2.55254412, 2.74889374, 2.94524312, 3.14159274, 3.33794236, 3.53429174, 3.73064137, 3.92699099, 4.12334061, 4.319690e+00, 4.51603937, 4.71238899, 4.90873861, 5.10508823, 5.30143785, 5.49778748, 5.69413662, 5.89048624, 6.08683586]> : tensor<32xf32>
    %cst_2 = stablehlo.constant dense<[0.000000e+00, 0.196349546, 0.392699093, 0.589048624, 0.785398185, 0.981747746, 1.17809725, 1.37444687, 1.57079637, 1.76714587, 1.96349549, 2.15984511, 2.3561945, 2.55254412, 2.74889374, 2.94524312, 3.14159274, 3.33794236, 3.53429174, 3.73064137, 3.92699099, 4.12334061, 4.319690e+00, 4.51603937, 4.71238899, 4.90873861, 5.10508823, 5.30143785, 5.49778748, 5.69413662, 5.89048624, 6.08683586]> : tensor<32xf32>
    %c = stablehlo.constant dense<0> : tensor<i32>
    %0:3 = stablehlo.while(%iterArg = %cst, %iterArg_5 = %c, %iterArg_6 = %arg0) : tensor<1x1x3xf32>, tensor<i32>, tensor<32x32x32xf32>
     cond {
      %c_7 = stablehlo.constant dense<100> : tensor<i32>
      %3 = stablehlo.compare  LT, %iterArg_5, %c_7,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
      stablehlo.return %3 : tensor<i1>
    } do {
      %3 = func.call @None(%iterArg, %iterArg_6) : (tensor<1x1x3xf32>, tensor<32x32x32xf32>) -> tensor<32x32x32xf32>
      %c_7 = stablehlo.constant dense<1> : tensor<i32>
      %4 = stablehlo.add %iterArg_5, %c_7 : tensor<i32>
      stablehlo.return %iterArg, %4, %3 : tensor<1x1x3xf32>, tensor<i32>, tensor<32x32x32xf32>
    }
    %cst_3 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %1 = stablehlo.add %arg1, %cst_3 : tensor<f32>
    %c_4 = stablehlo.constant dense<100> : tensor<i32>
    %2 = stablehlo.add %arg2, %c_4 : tensor<i32>
    return %cst_0, %cst_1, %cst_2, %0#2, %1, %2 : tensor<32xf32>, tensor<32xf32>, tensor<32xf32>, tensor<32x32x32xf32>, tensor<f32>, tensor<i32>
  }
  func.func private @None(%arg0: tensor<1x1x3xf32>, %arg1: tensor<32x32x32xf32>) -> tensor<32x32x32xf32> {
    %cst = stablehlo.constant dense<5.18764486E-4> : tensor<f32>
    %0 = call @heat_step_conv(%arg1, %cst, %arg0) : (tensor<32x32x32xf32>, tensor<f32>, tensor<1x1x3xf32>) -> tensor<32x32x32xf32>
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
