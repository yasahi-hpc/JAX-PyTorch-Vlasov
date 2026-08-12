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
    %0 = call @heat_step(%arg0, %cst) : (tensor<32x32x32xf64>, tensor<f64>) -> tensor<32x32x32xf64>
    return %0 : tensor<32x32x32xf64>
  }
  func.func private @heat_step(%arg0: tensor<32x32x32xf64>, %arg1: tensor<f64>) -> tensor<32x32x32xf64> {
    %0 = stablehlo.iota dim = 0 : tensor<32xi64>
    %c = stablehlo.constant dense<1> : tensor<i64>
    %1 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %2 = stablehlo.add %0, %1 : tensor<32xi64>
    %c_0 = stablehlo.constant dense<32> : tensor<i64>
    %3 = call @remainder(%2, %c_0) : (tensor<32xi64>, tensor<i64>) -> tensor<32xi64>
    %4 = call @_take(%arg0, %3) : (tensor<32x32x32xf64>, tensor<32xi64>) -> tensor<32x32x32xf64>
    %5 = stablehlo.iota dim = 0 : tensor<32xi64>
    %6 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %7 = stablehlo.subtract %5, %6 : tensor<32xi64>
    %8 = call @remainder(%7, %c_0) : (tensor<32xi64>, tensor<i64>) -> tensor<32xi64>
    %9 = call @_take(%arg0, %8) : (tensor<32x32x32xf64>, tensor<32xi64>) -> tensor<32x32x32xf64>
    %10 = stablehlo.iota dim = 0 : tensor<32xi64>
    %11 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %12 = stablehlo.add %10, %11 : tensor<32xi64>
    %13 = call @remainder(%12, %c_0) : (tensor<32xi64>, tensor<i64>) -> tensor<32xi64>
    %14 = call @_take_1(%arg0, %13) : (tensor<32x32x32xf64>, tensor<32xi64>) -> tensor<32x32x32xf64>
    %15 = stablehlo.iota dim = 0 : tensor<32xi64>
    %16 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %17 = stablehlo.subtract %15, %16 : tensor<32xi64>
    %18 = call @remainder(%17, %c_0) : (tensor<32xi64>, tensor<i64>) -> tensor<32xi64>
    %19 = call @_take_1(%arg0, %18) : (tensor<32x32x32xf64>, tensor<32xi64>) -> tensor<32x32x32xf64>
    %20 = stablehlo.iota dim = 0 : tensor<32xi64>
    %21 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %22 = stablehlo.add %20, %21 : tensor<32xi64>
    %23 = call @remainder(%22, %c_0) : (tensor<32xi64>, tensor<i64>) -> tensor<32xi64>
    %24 = call @_take_2(%arg0, %23) : (tensor<32x32x32xf64>, tensor<32xi64>) -> tensor<32x32x32xf64>
    %25 = stablehlo.iota dim = 0 : tensor<32xi64>
    %26 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %27 = stablehlo.subtract %25, %26 : tensor<32xi64>
    %28 = call @remainder(%27, %c_0) : (tensor<32xi64>, tensor<i64>) -> tensor<32xi64>
    %29 = call @_take_2(%arg0, %28) : (tensor<32x32x32xf64>, tensor<32xi64>) -> tensor<32x32x32xf64>
    %30 = stablehlo.add %4, %9 : tensor<32x32x32xf64>
    %31 = stablehlo.add %30, %14 : tensor<32x32x32xf64>
    %32 = stablehlo.add %31, %19 : tensor<32x32x32xf64>
    %33 = stablehlo.add %32, %24 : tensor<32x32x32xf64>
    %34 = stablehlo.add %33, %29 : tensor<32x32x32xf64>
    %cst = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %35 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<32x32x32xf64>
    %36 = stablehlo.multiply %35, %arg0 : tensor<32x32x32xf64>
    %37 = stablehlo.subtract %34, %36 : tensor<32x32x32xf64>
    %38 = stablehlo.convert %arg1 : tensor<f64>
    %39 = stablehlo.broadcast_in_dim %38, dims = [] : (tensor<f64>) -> tensor<32x32x32xf64>
    %40 = stablehlo.multiply %39, %37 : tensor<32x32x32xf64>
    %41 = stablehlo.add %arg0, %40 : tensor<32x32x32xf64>
    return %41 : tensor<32x32x32xf64>
  }
  func.func private @remainder(%arg0: tensor<32xi64>, %arg1: tensor<i64>) -> tensor<32xi64> {
    %0 = stablehlo.convert %arg1 : tensor<i64>
    %c = stablehlo.constant dense<0> : tensor<i64>
    %1 = stablehlo.compare  EQ, %0, %c,  SIGNED : (tensor<i64>, tensor<i64>) -> tensor<i1>
    %c_0 = stablehlo.constant dense<1> : tensor<i64>
    %2 = call @_where(%1, %c_0, %0) : (tensor<i1>, tensor<i64>, tensor<i64>) -> tensor<i64>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %4 = stablehlo.remainder %arg0, %3 : tensor<32xi64>
    %5 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %6 = stablehlo.compare  NE, %4, %5,  SIGNED : (tensor<32xi64>, tensor<32xi64>) -> tensor<32xi1>
    %7 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %8 = stablehlo.compare  LT, %4, %7,  SIGNED : (tensor<32xi64>, tensor<32xi64>) -> tensor<32xi1>
    %9 = stablehlo.compare  LT, %2, %c,  SIGNED : (tensor<i64>, tensor<i64>) -> tensor<i1>
    %10 = stablehlo.broadcast_in_dim %9, dims = [] : (tensor<i1>) -> tensor<32xi1>
    %11 = stablehlo.compare  NE, %8, %10,  UNSIGNED : (tensor<32xi1>, tensor<32xi1>) -> tensor<32xi1>
    %12 = stablehlo.and %11, %6 : tensor<32xi1>
    %13 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %14 = stablehlo.add %4, %13 : tensor<32xi64>
    %15 = stablehlo.select %12, %14, %4 : tensor<32xi1>, tensor<32xi64>
    return %15 : tensor<32xi64>
  }
  func.func private @_where(%arg0: tensor<i1>, %arg1: tensor<i64>, %arg2: tensor<i64>) -> tensor<i64> {
    %0 = stablehlo.select %arg0, %arg1, %arg2 : tensor<i1>, tensor<i64>
    return %0 : tensor<i64>
  }
  func.func private @_take(%arg0: tensor<32x32x32xf64>, %arg1: tensor<32xi64>) -> tensor<32x32x32xf64> {
    %c = stablehlo.constant dense<0> : tensor<i64>
    %0 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %1 = stablehlo.compare  LT, %arg1, %0,  SIGNED : (tensor<32xi64>, tensor<32xi64>) -> tensor<32xi1>
    %c_0 = stablehlo.constant dense<32> : tensor<i64>
    %2 = stablehlo.broadcast_in_dim %c_0, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %3 = stablehlo.add %arg1, %2 : tensor<32xi64>
    %4 = call @_where_0(%1, %3, %arg1) : (tensor<32xi1>, tensor<32xi64>, tensor<32xi64>) -> tensor<32xi64>
    %5 = stablehlo.broadcast_in_dim %4, dims = [0] : (tensor<32xi64>) -> tensor<32x1xi64>
    %c_1 = stablehlo.constant dense<31> : tensor<1xi64>
    %c_2 = stablehlo.constant dense<0> : tensor<i64>
    %6 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i64>) -> tensor<32x1xi64>
    %7 = stablehlo.compare  GE, %5, %6,  SIGNED : (tensor<32x1xi64>, tensor<32x1xi64>) -> tensor<32x1xi1>
    %8 = stablehlo.broadcast_in_dim %c_1, dims = [1] : (tensor<1xi64>) -> tensor<1x1xi64>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x1xi64>) -> tensor<32x1xi64>
    %10 = stablehlo.compare  LE, %5, %9,  SIGNED : (tensor<32x1xi64>, tensor<32x1xi64>) -> tensor<32x1xi1>
    %11 = stablehlo.and %7, %10 : tensor<32x1xi1>
    %c_3 = stablehlo.constant dense<true> : tensor<i1>
    %12 = stablehlo.reduce(%11 init: %c_3) applies stablehlo.and across dimensions = [1] : (tensor<32x1xi1>, tensor<i1>) -> tensor<32xi1>
    %13 = "stablehlo.gather"(%arg0, %5) <{dimension_numbers = #stablehlo.gather<offset_dims = [1, 2], collapsed_slice_dims = [0], start_index_map = [0], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 1, 32, 32>}> : (tensor<32x32x32xf64>, tensor<32x1xi64>) -> tensor<32x32x32xf64>
    %14 = stablehlo.broadcast_in_dim %12, dims = [0] : (tensor<32xi1>) -> tensor<32x32x32xi1>
    %cst = stablehlo.constant dense<0x7FF8000000000000> : tensor<f64>
    %15 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<32x32x32xf64>
    %16 = stablehlo.select %14, %13, %15 : tensor<32x32x32xi1>, tensor<32x32x32xf64>
    return %16 : tensor<32x32x32xf64>
  }
  func.func private @_where_0(%arg0: tensor<32xi1>, %arg1: tensor<32xi64>, %arg2: tensor<32xi64>) -> tensor<32xi64> {
    %0 = stablehlo.select %arg0, %arg1, %arg2 : tensor<32xi1>, tensor<32xi64>
    return %0 : tensor<32xi64>
  }
  func.func private @_take_1(%arg0: tensor<32x32x32xf64>, %arg1: tensor<32xi64>) -> tensor<32x32x32xf64> {
    %c = stablehlo.constant dense<0> : tensor<i64>
    %0 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %1 = stablehlo.compare  LT, %arg1, %0,  SIGNED : (tensor<32xi64>, tensor<32xi64>) -> tensor<32xi1>
    %c_0 = stablehlo.constant dense<32> : tensor<i64>
    %2 = stablehlo.broadcast_in_dim %c_0, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %3 = stablehlo.add %arg1, %2 : tensor<32xi64>
    %4 = call @_where_0(%1, %3, %arg1) : (tensor<32xi1>, tensor<32xi64>, tensor<32xi64>) -> tensor<32xi64>
    %5 = stablehlo.broadcast_in_dim %4, dims = [0] : (tensor<32xi64>) -> tensor<32x1xi64>
    %c_1 = stablehlo.constant dense<31> : tensor<1xi64>
    %c_2 = stablehlo.constant dense<0> : tensor<i64>
    %6 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i64>) -> tensor<32x1xi64>
    %7 = stablehlo.compare  GE, %5, %6,  SIGNED : (tensor<32x1xi64>, tensor<32x1xi64>) -> tensor<32x1xi1>
    %8 = stablehlo.broadcast_in_dim %c_1, dims = [1] : (tensor<1xi64>) -> tensor<1x1xi64>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x1xi64>) -> tensor<32x1xi64>
    %10 = stablehlo.compare  LE, %5, %9,  SIGNED : (tensor<32x1xi64>, tensor<32x1xi64>) -> tensor<32x1xi1>
    %11 = stablehlo.and %7, %10 : tensor<32x1xi1>
    %c_3 = stablehlo.constant dense<true> : tensor<i1>
    %12 = stablehlo.reduce(%11 init: %c_3) applies stablehlo.and across dimensions = [1] : (tensor<32x1xi1>, tensor<i1>) -> tensor<32xi1>
    %13 = "stablehlo.gather"(%arg0, %5) <{dimension_numbers = #stablehlo.gather<offset_dims = [0, 2], collapsed_slice_dims = [1], start_index_map = [1], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 32, 1, 32>}> : (tensor<32x32x32xf64>, tensor<32x1xi64>) -> tensor<32x32x32xf64>
    %14 = stablehlo.broadcast_in_dim %12, dims = [1] : (tensor<32xi1>) -> tensor<32x32x32xi1>
    %cst = stablehlo.constant dense<0x7FF8000000000000> : tensor<f64>
    %15 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<32x32x32xf64>
    %16 = stablehlo.select %14, %13, %15 : tensor<32x32x32xi1>, tensor<32x32x32xf64>
    return %16 : tensor<32x32x32xf64>
  }
  func.func private @_take_2(%arg0: tensor<32x32x32xf64>, %arg1: tensor<32xi64>) -> tensor<32x32x32xf64> {
    %c = stablehlo.constant dense<0> : tensor<i64>
    %0 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %1 = stablehlo.compare  LT, %arg1, %0,  SIGNED : (tensor<32xi64>, tensor<32xi64>) -> tensor<32xi1>
    %c_0 = stablehlo.constant dense<32> : tensor<i64>
    %2 = stablehlo.broadcast_in_dim %c_0, dims = [] : (tensor<i64>) -> tensor<32xi64>
    %3 = stablehlo.add %arg1, %2 : tensor<32xi64>
    %4 = call @_where_0(%1, %3, %arg1) : (tensor<32xi1>, tensor<32xi64>, tensor<32xi64>) -> tensor<32xi64>
    %5 = stablehlo.broadcast_in_dim %4, dims = [0] : (tensor<32xi64>) -> tensor<32x1xi64>
    %c_1 = stablehlo.constant dense<31> : tensor<1xi64>
    %c_2 = stablehlo.constant dense<0> : tensor<i64>
    %6 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i64>) -> tensor<32x1xi64>
    %7 = stablehlo.compare  GE, %5, %6,  SIGNED : (tensor<32x1xi64>, tensor<32x1xi64>) -> tensor<32x1xi1>
    %8 = stablehlo.broadcast_in_dim %c_1, dims = [1] : (tensor<1xi64>) -> tensor<1x1xi64>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x1xi64>) -> tensor<32x1xi64>
    %10 = stablehlo.compare  LE, %5, %9,  SIGNED : (tensor<32x1xi64>, tensor<32x1xi64>) -> tensor<32x1xi1>
    %11 = stablehlo.and %7, %10 : tensor<32x1xi1>
    %c_3 = stablehlo.constant dense<true> : tensor<i1>
    %12 = stablehlo.reduce(%11 init: %c_3) applies stablehlo.and across dimensions = [1] : (tensor<32x1xi1>, tensor<i1>) -> tensor<32xi1>
    %13 = "stablehlo.gather"(%arg0, %5) <{dimension_numbers = #stablehlo.gather<offset_dims = [0, 1], collapsed_slice_dims = [2], start_index_map = [2], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 32, 32, 1>}> : (tensor<32x32x32xf64>, tensor<32x1xi64>) -> tensor<32x32x32xf64>
    %14 = stablehlo.broadcast_in_dim %12, dims = [2] : (tensor<32xi1>) -> tensor<32x32x32xi1>
    %cst = stablehlo.constant dense<0x7FF8000000000000> : tensor<f64>
    %15 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<32x32x32xf64>
    %16 = stablehlo.select %14, %13, %15 : tensor<32x32x32xi1>, tensor<32x32x32xf64>
    return %16 : tensor<32x32x32xf64>
  }
}
