module @jit_heat_step_roll attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<32x32x32xf32>, %arg1: tensor<f32>) -> (tensor<32x32x32xf32> {jax.result_info = "result"}) {
    %0 = call @heat_step_roll(%arg0, %arg1) : (tensor<32x32x32xf32>, tensor<f32>) -> tensor<32x32x32xf32>
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
