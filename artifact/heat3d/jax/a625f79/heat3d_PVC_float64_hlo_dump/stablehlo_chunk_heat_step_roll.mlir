module @jit_run_chunk attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<32x32x32xf64>, %arg1: tensor<f64>, %arg2: tensor<i64>) -> (tensor<32xf64> {jax.result_info = "[<flat index 0>][<flat index 0>]"}, tensor<32xf64> {jax.result_info = "[<flat index 0>][<flat index 1>]"}, tensor<32xf64> {jax.result_info = "[<flat index 0>][<flat index 2>]"}, tensor<32x32x32xf64> {jax.result_info = "[<flat index 1>][<flat index 0>]"}, tensor<f64> {jax.result_info = "[<flat index 2>]"}, tensor<i64> {jax.result_info = "[<flat index 3>]"}) {
    %cst = stablehlo.constant dense<[0.000000e+00, 0.19634954084936207, 0.39269908169872414, 0.58904862254808621, 0.78539816339744828, 0.98174770424681035, 1.1780972450961724, 1.3744467859455345, 1.5707963267948966, 1.7671458676442586, 1.9634954084936207, 2.1598449493429825, 2.3561944901923448, 2.5525440310417071, 2.748893571891069, 2.9452431127404308, 3.1415926535897931, 3.3379421944391554, 3.5342917352885173, 3.7306412761378791, 3.9269908169872414, 4.1233403578366037, 4.3196898986859651, 4.5160394395353274, 4.7123889803846897, 4.908738521234052, 5.1050880620834143, 5.3014376029327757, 5.497787143782138, 5.6941366846315002, 5.8904862254808616, 6.0868357663302239]> : tensor<32xf64>
    %cst_0 = stablehlo.constant dense<[0.000000e+00, 0.19634954084936207, 0.39269908169872414, 0.58904862254808621, 0.78539816339744828, 0.98174770424681035, 1.1780972450961724, 1.3744467859455345, 1.5707963267948966, 1.7671458676442586, 1.9634954084936207, 2.1598449493429825, 2.3561944901923448, 2.5525440310417071, 2.748893571891069, 2.9452431127404308, 3.1415926535897931, 3.3379421944391554, 3.5342917352885173, 3.7306412761378791, 3.9269908169872414, 4.1233403578366037, 4.3196898986859651, 4.5160394395353274, 4.7123889803846897, 4.908738521234052, 5.1050880620834143, 5.3014376029327757, 5.497787143782138, 5.6941366846315002, 5.8904862254808616, 6.0868357663302239]> : tensor<32xf64>
    %cst_1 = stablehlo.constant dense<[0.000000e+00, 0.19634954084936207, 0.39269908169872414, 0.58904862254808621, 0.78539816339744828, 0.98174770424681035, 1.1780972450961724, 1.3744467859455345, 1.5707963267948966, 1.7671458676442586, 1.9634954084936207, 2.1598449493429825, 2.3561944901923448, 2.5525440310417071, 2.748893571891069, 2.9452431127404308, 3.1415926535897931, 3.3379421944391554, 3.5342917352885173, 3.7306412761378791, 3.9269908169872414, 4.1233403578366037, 4.3196898986859651, 4.5160394395353274, 4.7123889803846897, 4.908738521234052, 5.1050880620834143, 5.3014376029327757, 5.497787143782138, 5.6941366846315002, 5.8904862254808616, 6.0868357663302239]> : tensor<32xf64>
    %c = stablehlo.constant dense<0> : tensor<i64>
    %0:2 = stablehlo.while(%iterArg = %c, %iterArg_4 = %arg0) : tensor<i64>, tensor<32x32x32xf64>
     cond {
      %c_5 = stablehlo.constant dense<100> : tensor<i64>
      %3 = stablehlo.compare  LT, %iterArg, %c_5,  SIGNED : (tensor<i64>, tensor<i64>) -> tensor<i1>
      stablehlo.return %3 : tensor<i1>
    } do {
      %3 = func.call @None(%iterArg_4) : (tensor<32x32x32xf64>) -> tensor<32x32x32xf64>
      %c_5 = stablehlo.constant dense<1> : tensor<i64>
      %4 = stablehlo.add %iterArg, %c_5 : tensor<i64>
      stablehlo.return %4, %3 : tensor<i64>, tensor<32x32x32xf64>
    }
    %cst_2 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %1 = stablehlo.add %arg1, %cst_2 : tensor<f64>
    %c_3 = stablehlo.constant dense<100> : tensor<i64>
    %2 = stablehlo.add %arg2, %c_3 : tensor<i64>
    return %cst, %cst_0, %cst_1, %0#1, %1, %2 : tensor<32xf64>, tensor<32xf64>, tensor<32xf64>, tensor<32x32x32xf64>, tensor<f64>, tensor<i64>
  }
  func.func private @None(%arg0: tensor<32x32x32xf64>) -> tensor<32x32x32xf64> {
    %cst = stablehlo.constant dense<5.1876446024876944E-4> : tensor<f64>
    %0 = call @heat_step_roll(%arg0, %cst) : (tensor<32x32x32xf64>, tensor<f64>) -> tensor<32x32x32xf64>
    return %0 : tensor<32x32x32xf64>
  }
  func.func private @heat_step_roll(%arg0: tensor<32x32x32xf64>, %arg1: tensor<f64>) -> tensor<32x32x32xf64> {
    %0 = call @_roll_static(%arg0) : (tensor<32x32x32xf64>) -> tensor<32x32x32xf64>
    %1 = call @_roll_static_0(%arg0) : (tensor<32x32x32xf64>) -> tensor<32x32x32xf64>
    %2 = call @_roll_static_1(%arg0) : (tensor<32x32x32xf64>) -> tensor<32x32x32xf64>
    %3 = call @_roll_static_2(%arg0) : (tensor<32x32x32xf64>) -> tensor<32x32x32xf64>
    %4 = call @_roll_static_3(%arg0) : (tensor<32x32x32xf64>) -> tensor<32x32x32xf64>
    %5 = call @_roll_static_4(%arg0) : (tensor<32x32x32xf64>) -> tensor<32x32x32xf64>
    %6 = stablehlo.add %0, %1 : tensor<32x32x32xf64>
    %7 = stablehlo.add %6, %2 : tensor<32x32x32xf64>
    %8 = stablehlo.add %7, %3 : tensor<32x32x32xf64>
    %9 = stablehlo.add %8, %4 : tensor<32x32x32xf64>
    %10 = stablehlo.add %9, %5 : tensor<32x32x32xf64>
    %cst = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %11 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<32x32x32xf64>
    %12 = stablehlo.multiply %11, %arg0 : tensor<32x32x32xf64>
    %13 = stablehlo.subtract %10, %12 : tensor<32x32x32xf64>
    %14 = stablehlo.convert %arg1 : tensor<f64>
    %15 = stablehlo.broadcast_in_dim %14, dims = [] : (tensor<f64>) -> tensor<32x32x32xf64>
    %16 = stablehlo.multiply %15, %13 : tensor<32x32x32xf64>
    %17 = stablehlo.add %arg0, %16 : tensor<32x32x32xf64>
    return %17 : tensor<32x32x32xf64>
  }
  func.func private @_roll_static(%arg0: tensor<32x32x32xf64>) -> tensor<32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [1:32, 0:32, 0:32] : (tensor<32x32x32xf64>) -> tensor<31x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:1, 0:32, 0:32] : (tensor<32x32x32xf64>) -> tensor<1x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<31x32x32xf64>, tensor<1x32x32xf64>) -> tensor<32x32x32xf64>
    return %2 : tensor<32x32x32xf64>
  }
  func.func private @_roll_static_0(%arg0: tensor<32x32x32xf64>) -> tensor<32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [31:32, 0:32, 0:32] : (tensor<32x32x32xf64>) -> tensor<1x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:31, 0:32, 0:32] : (tensor<32x32x32xf64>) -> tensor<31x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<1x32x32xf64>, tensor<31x32x32xf64>) -> tensor<32x32x32xf64>
    return %2 : tensor<32x32x32xf64>
  }
  func.func private @_roll_static_1(%arg0: tensor<32x32x32xf64>) -> tensor<32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 1:32, 0:32] : (tensor<32x32x32xf64>) -> tensor<32x31x32xf64>
    %1 = stablehlo.slice %arg0 [0:32, 0:1, 0:32] : (tensor<32x32x32xf64>) -> tensor<32x1x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x31x32xf64>, tensor<32x1x32xf64>) -> tensor<32x32x32xf64>
    return %2 : tensor<32x32x32xf64>
  }
  func.func private @_roll_static_2(%arg0: tensor<32x32x32xf64>) -> tensor<32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 31:32, 0:32] : (tensor<32x32x32xf64>) -> tensor<32x1x32xf64>
    %1 = stablehlo.slice %arg0 [0:32, 0:31, 0:32] : (tensor<32x32x32xf64>) -> tensor<32x31x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x1x32xf64>, tensor<32x31x32xf64>) -> tensor<32x32x32xf64>
    return %2 : tensor<32x32x32xf64>
  }
  func.func private @_roll_static_3(%arg0: tensor<32x32x32xf64>) -> tensor<32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 0:32, 1:32] : (tensor<32x32x32xf64>) -> tensor<32x32x31xf64>
    %1 = stablehlo.slice %arg0 [0:32, 0:32, 0:1] : (tensor<32x32x32xf64>) -> tensor<32x32x1xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 2 : (tensor<32x32x31xf64>, tensor<32x32x1xf64>) -> tensor<32x32x32xf64>
    return %2 : tensor<32x32x32xf64>
  }
  func.func private @_roll_static_4(%arg0: tensor<32x32x32xf64>) -> tensor<32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 0:32, 31:32] : (tensor<32x32x32xf64>) -> tensor<32x32x1xf64>
    %1 = stablehlo.slice %arg0 [0:32, 0:32, 0:31] : (tensor<32x32x32xf64>) -> tensor<32x32x31xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 2 : (tensor<32x32x1xf64>, tensor<32x32x31xf64>) -> tensor<32x32x32xf64>
    return %2 : tensor<32x32x32xf64>
  }
}
