module @jit_run_chunk attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<32x32x32xf32>, %arg1: tensor<f32>, %arg2: tensor<i32>) -> (tensor<32xf32> {jax.result_info = "result[0][0]"}, tensor<32xf32> {jax.result_info = "result[0][1]"}, tensor<32xf32> {jax.result_info = "result[0][2]"}, tensor<32x32x32xf32> {jax.result_info = "result[1][0]"}, tensor<f32> {jax.result_info = "result[2]"}, tensor<i32> {jax.result_info = "result[3]"}) {
    %cst = stablehlo.constant dense<[0.000000e+00, 0.196349546, 0.392699093, 0.589048624, 0.785398185, 0.981747746, 1.17809725, 1.37444687, 1.57079637, 1.76714587, 1.96349549, 2.15984511, 2.3561945, 2.55254412, 2.74889374, 2.94524312, 3.14159274, 3.33794236, 3.53429174, 3.73064137, 3.92699099, 4.12334061, 4.319690e+00, 4.51603937, 4.71238899, 4.90873861, 5.10508823, 5.30143785, 5.49778748, 5.69413662, 5.89048624, 6.08683586]> : tensor<32xf32>
    %cst_0 = stablehlo.constant dense<[0.000000e+00, 0.196349546, 0.392699093, 0.589048624, 0.785398185, 0.981747746, 1.17809725, 1.37444687, 1.57079637, 1.76714587, 1.96349549, 2.15984511, 2.3561945, 2.55254412, 2.74889374, 2.94524312, 3.14159274, 3.33794236, 3.53429174, 3.73064137, 3.92699099, 4.12334061, 4.319690e+00, 4.51603937, 4.71238899, 4.90873861, 5.10508823, 5.30143785, 5.49778748, 5.69413662, 5.89048624, 6.08683586]> : tensor<32xf32>
    %cst_1 = stablehlo.constant dense<[0.000000e+00, 0.196349546, 0.392699093, 0.589048624, 0.785398185, 0.981747746, 1.17809725, 1.37444687, 1.57079637, 1.76714587, 1.96349549, 2.15984511, 2.3561945, 2.55254412, 2.74889374, 2.94524312, 3.14159274, 3.33794236, 3.53429174, 3.73064137, 3.92699099, 4.12334061, 4.319690e+00, 4.51603937, 4.71238899, 4.90873861, 5.10508823, 5.30143785, 5.49778748, 5.69413662, 5.89048624, 6.08683586]> : tensor<32xf32>
    %c = stablehlo.constant dense<0> : tensor<i32>
    %0:2 = stablehlo.while(%iterArg = %c, %iterArg_4 = %arg0) : tensor<i32>, tensor<32x32x32xf32>
    cond {
      %c_5 = stablehlo.constant dense<20> : tensor<i32>
      %3 = stablehlo.compare  LT, %iterArg, %c_5,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
      stablehlo.return %3 : tensor<i1>
    } do {
      %3 = func.call @closed_call(%iterArg_4) : (tensor<32x32x32xf32>) -> tensor<32x32x32xf32>
      %c_5 = stablehlo.constant dense<1> : tensor<i32>
      %4 = stablehlo.add %iterArg, %c_5 : tensor<i32>
      stablehlo.return %4, %3 : tensor<i32>, tensor<32x32x32xf32>
    }
    %cst_2 = stablehlo.constant dense<2.000000e-02> : tensor<f32>
    %1 = stablehlo.add %arg1, %cst_2 : tensor<f32>
    %c_3 = stablehlo.constant dense<20> : tensor<i32>
    %2 = stablehlo.add %arg2, %c_3 : tensor<i32>
    return %cst, %cst_0, %cst_1, %0#1, %1, %2 : tensor<32xf32>, tensor<32xf32>, tensor<32xf32>, tensor<32x32x32xf32>, tensor<f32>, tensor<i32>
  }
  func.func private @closed_call(%arg0: tensor<32x32x32xf32>) -> tensor<32x32x32xf32> {
    %cst = stablehlo.constant dense<0.0259382222> : tensor<f32>
    %0 = call @heat_step_roll(%arg0, %cst) : (tensor<32x32x32xf32>, tensor<f32>) -> tensor<32x32x32xf32>
    return %0 : tensor<32x32x32xf32>
  }
  func.func private @heat_step_roll(%arg0: tensor<32x32x32xf32>, %arg1: tensor<f32>) -> tensor<32x32x32xf32> {
    %0 = call @_roll_static(%arg0) : (tensor<32x32x32xf32>) -> tensor<32x32x32xf32>
    %1 = call @_roll_static_1(%arg0) : (tensor<32x32x32xf32>) -> tensor<32x32x32xf32>
    %2 = call @_roll_static_5(%arg0) : (tensor<32x32x32xf32>) -> tensor<32x32x32xf32>
    %3 = call @_roll_static_9(%arg0) : (tensor<32x32x32xf32>) -> tensor<32x32x32xf32>
    %4 = call @_roll_static_13(%arg0) : (tensor<32x32x32xf32>) -> tensor<32x32x32xf32>
    %5 = call @_roll_static_17(%arg0) : (tensor<32x32x32xf32>) -> tensor<32x32x32xf32>
    %6 = stablehlo.add %0, %1 : tensor<32x32x32xf32>
    %7 = stablehlo.add %6, %2 : tensor<32x32x32xf32>
    %8 = stablehlo.add %7, %3 : tensor<32x32x32xf32>
    %9 = stablehlo.add %8, %4 : tensor<32x32x32xf32>
    %10 = stablehlo.add %9, %5 : tensor<32x32x32xf32>
    %cst = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %11 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f32>) -> tensor<32x32x32xf32>
    %12 = stablehlo.multiply %11, %arg0 : tensor<32x32x32xf32>
    %13 = stablehlo.subtract %10, %12 : tensor<32x32x32xf32>
    %14 = stablehlo.convert %arg1 : tensor<f32>
    %15 = stablehlo.broadcast_in_dim %14, dims = [] : (tensor<f32>) -> tensor<32x32x32xf32>
    %16 = stablehlo.multiply %15, %13 : tensor<32x32x32xf32>
    %17 = stablehlo.add %arg0, %16 : tensor<32x32x32xf32>
    return %17 : tensor<32x32x32xf32>
  }
  func.func private @_roll_static(%arg0: tensor<32x32x32xf32>) -> tensor<32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [1:32, 0:32, 0:32] : (tensor<32x32x32xf32>) -> tensor<31x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:1, 0:32, 0:32] : (tensor<32x32x32xf32>) -> tensor<1x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<31x32x32xf32>, tensor<1x32x32xf32>) -> tensor<32x32x32xf32>
    return %2 : tensor<32x32x32xf32>
  }
  func.func private @_roll_static_1(%arg0: tensor<32x32x32xf32>) -> tensor<32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [31:32, 0:32, 0:32] : (tensor<32x32x32xf32>) -> tensor<1x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:31, 0:32, 0:32] : (tensor<32x32x32xf32>) -> tensor<31x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<1x32x32xf32>, tensor<31x32x32xf32>) -> tensor<32x32x32xf32>
    return %2 : tensor<32x32x32xf32>
  }
  func.func private @_roll_static_5(%arg0: tensor<32x32x32xf32>) -> tensor<32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 1:32, 0:32] : (tensor<32x32x32xf32>) -> tensor<32x31x32xf32>
    %1 = stablehlo.slice %arg0 [0:32, 0:1, 0:32] : (tensor<32x32x32xf32>) -> tensor<32x1x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x31x32xf32>, tensor<32x1x32xf32>) -> tensor<32x32x32xf32>
    return %2 : tensor<32x32x32xf32>
  }
  func.func private @_roll_static_9(%arg0: tensor<32x32x32xf32>) -> tensor<32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 31:32, 0:32] : (tensor<32x32x32xf32>) -> tensor<32x1x32xf32>
    %1 = stablehlo.slice %arg0 [0:32, 0:31, 0:32] : (tensor<32x32x32xf32>) -> tensor<32x31x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x1x32xf32>, tensor<32x31x32xf32>) -> tensor<32x32x32xf32>
    return %2 : tensor<32x32x32xf32>
  }
  func.func private @_roll_static_13(%arg0: tensor<32x32x32xf32>) -> tensor<32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 0:32, 1:32] : (tensor<32x32x32xf32>) -> tensor<32x32x31xf32>
    %1 = stablehlo.slice %arg0 [0:32, 0:32, 0:1] : (tensor<32x32x32xf32>) -> tensor<32x32x1xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 2 : (tensor<32x32x31xf32>, tensor<32x32x1xf32>) -> tensor<32x32x32xf32>
    return %2 : tensor<32x32x32xf32>
  }
  func.func private @_roll_static_17(%arg0: tensor<32x32x32xf32>) -> tensor<32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 0:32, 31:32] : (tensor<32x32x32xf32>) -> tensor<32x32x1xf32>
    %1 = stablehlo.slice %arg0 [0:32, 0:32, 0:31] : (tensor<32x32x32xf32>) -> tensor<32x32x31xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 2 : (tensor<32x32x1xf32>, tensor<32x32x31xf32>) -> tensor<32x32x32xf32>
    return %2 : tensor<32x32x32xf32>
  }
}
