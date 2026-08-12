module @jit_heat_step attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<32x32x32xf32>, %arg1: tensor<f32>) -> (tensor<32x32x32xf32> {jax.result_info = "result"}) {
    %0 = call @heat_step(%arg0, %arg1) : (tensor<32x32x32xf32>, tensor<f32>) -> tensor<32x32x32xf32>
    return %0 : tensor<32x32x32xf32>
  }
  func.func private @heat_step(%arg0: tensor<32x32x32xf32>, %arg1: tensor<f32>) -> tensor<32x32x32xf32> {
    %0 = stablehlo.iota dim = 0 : tensor<32xi32>
    %c = stablehlo.constant dense<1> : tensor<i32>
    %1 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %2 = stablehlo.add %0, %1 : tensor<32xi32>
    %c_0 = stablehlo.constant dense<32> : tensor<i32>
    %3 = call @remainder(%2, %c_0) : (tensor<32xi32>, tensor<i32>) -> tensor<32xi32>
    %4 = call @_take(%arg0, %3) : (tensor<32x32x32xf32>, tensor<32xi32>) -> tensor<32x32x32xf32>
    %5 = stablehlo.iota dim = 0 : tensor<32xi32>
    %c_1 = stablehlo.constant dense<1> : tensor<i32>
    %6 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %7 = stablehlo.subtract %5, %6 : tensor<32xi32>
    %8 = call @remainder(%7, %c_0) : (tensor<32xi32>, tensor<i32>) -> tensor<32xi32>
    %9 = call @_take(%arg0, %8) : (tensor<32x32x32xf32>, tensor<32xi32>) -> tensor<32x32x32xf32>
    %10 = stablehlo.iota dim = 0 : tensor<32xi32>
    %c_2 = stablehlo.constant dense<1> : tensor<i32>
    %11 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %12 = stablehlo.add %10, %11 : tensor<32xi32>
    %13 = call @remainder(%12, %c_0) : (tensor<32xi32>, tensor<i32>) -> tensor<32xi32>
    %14 = call @_take_10(%arg0, %13) : (tensor<32x32x32xf32>, tensor<32xi32>) -> tensor<32x32x32xf32>
    %15 = stablehlo.iota dim = 0 : tensor<32xi32>
    %c_3 = stablehlo.constant dense<1> : tensor<i32>
    %16 = stablehlo.broadcast_in_dim %c_3, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %17 = stablehlo.subtract %15, %16 : tensor<32xi32>
    %18 = call @remainder(%17, %c_0) : (tensor<32xi32>, tensor<i32>) -> tensor<32xi32>
    %19 = call @_take_10(%arg0, %18) : (tensor<32x32x32xf32>, tensor<32xi32>) -> tensor<32x32x32xf32>
    %20 = stablehlo.iota dim = 0 : tensor<32xi32>
    %c_4 = stablehlo.constant dense<1> : tensor<i32>
    %21 = stablehlo.broadcast_in_dim %c_4, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %22 = stablehlo.add %20, %21 : tensor<32xi32>
    %23 = call @remainder(%22, %c_0) : (tensor<32xi32>, tensor<i32>) -> tensor<32xi32>
    %24 = call @_take_14(%arg0, %23) : (tensor<32x32x32xf32>, tensor<32xi32>) -> tensor<32x32x32xf32>
    %25 = stablehlo.iota dim = 0 : tensor<32xi32>
    %c_5 = stablehlo.constant dense<1> : tensor<i32>
    %26 = stablehlo.broadcast_in_dim %c_5, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %27 = stablehlo.subtract %25, %26 : tensor<32xi32>
    %28 = call @remainder(%27, %c_0) : (tensor<32xi32>, tensor<i32>) -> tensor<32xi32>
    %29 = call @_take_14(%arg0, %28) : (tensor<32x32x32xf32>, tensor<32xi32>) -> tensor<32x32x32xf32>
    %30 = stablehlo.add %4, %9 : tensor<32x32x32xf32>
    %31 = stablehlo.add %30, %14 : tensor<32x32x32xf32>
    %32 = stablehlo.add %31, %19 : tensor<32x32x32xf32>
    %33 = stablehlo.add %32, %24 : tensor<32x32x32xf32>
    %34 = stablehlo.add %33, %29 : tensor<32x32x32xf32>
    %cst = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %35 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f32>) -> tensor<32x32x32xf32>
    %36 = stablehlo.multiply %35, %arg0 : tensor<32x32x32xf32>
    %37 = stablehlo.subtract %34, %36 : tensor<32x32x32xf32>
    %38 = stablehlo.convert %arg1 : tensor<f32>
    %39 = stablehlo.broadcast_in_dim %38, dims = [] : (tensor<f32>) -> tensor<32x32x32xf32>
    %40 = stablehlo.multiply %39, %37 : tensor<32x32x32xf32>
    %41 = stablehlo.add %arg0, %40 : tensor<32x32x32xf32>
    return %41 : tensor<32x32x32xf32>
  }
  func.func private @remainder(%arg0: tensor<32xi32>, %arg1: tensor<i32>) -> tensor<32xi32> {
    %0 = stablehlo.convert %arg1 : tensor<i32>
    %c = stablehlo.constant dense<0> : tensor<i32>
    %1 = stablehlo.compare  EQ, %0, %c,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %2 = call @_where(%1, %c_0, %0) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %4 = stablehlo.remainder %arg0, %3 : tensor<32xi32>
    %c_1 = stablehlo.constant dense<0> : tensor<i32>
    %5 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %6 = stablehlo.compare  NE, %4, %5,  SIGNED : (tensor<32xi32>, tensor<32xi32>) -> tensor<32xi1>
    %c_2 = stablehlo.constant dense<0> : tensor<i32>
    %7 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %8 = stablehlo.compare  LT, %4, %7,  SIGNED : (tensor<32xi32>, tensor<32xi32>) -> tensor<32xi1>
    %c_3 = stablehlo.constant dense<0> : tensor<i32>
    %9 = stablehlo.compare  LT, %2, %c_3,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %10 = stablehlo.broadcast_in_dim %9, dims = [] : (tensor<i1>) -> tensor<32xi1>
    %11 = stablehlo.compare  NE, %8, %10,  UNSIGNED : (tensor<32xi1>, tensor<32xi1>) -> tensor<32xi1>
    %12 = stablehlo.and %11, %6 : tensor<32xi1>
    %13 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %14 = stablehlo.add %4, %13 : tensor<32xi32>
    %15 = stablehlo.select %12, %14, %4 : tensor<32xi1>, tensor<32xi32>
    return %15 : tensor<32xi32>
  }
  func.func private @_where(%arg0: tensor<i1>, %arg1: tensor<i32>, %arg2: tensor<i32>) -> tensor<i32> {
    %0 = stablehlo.select %arg0, %arg1, %arg2 : tensor<i1>, tensor<i32>
    return %0 : tensor<i32>
  }
  func.func private @_take(%arg0: tensor<32x32x32xf32>, %arg1: tensor<32xi32>) -> tensor<32x32x32xf32> {
    %c = stablehlo.constant dense<0> : tensor<i32>
    %0 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %1 = stablehlo.compare  LT, %arg1, %0,  SIGNED : (tensor<32xi32>, tensor<32xi32>) -> tensor<32xi1>
    %c_0 = stablehlo.constant dense<32> : tensor<i32>
    %2 = stablehlo.broadcast_in_dim %c_0, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %3 = stablehlo.add %arg1, %2 : tensor<32xi32>
    %4 = call @_where_3(%1, %3, %arg1) : (tensor<32xi1>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %5 = stablehlo.broadcast_in_dim %4, dims = [0] : (tensor<32xi32>) -> tensor<32x1xi32>
    %c_1 = stablehlo.constant dense<31> : tensor<1xi32>
    %c_2 = stablehlo.constant dense<0> : tensor<i32>
    %6 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<32x1xi32>
    %7 = stablehlo.compare  GE, %5, %6,  SIGNED : (tensor<32x1xi32>, tensor<32x1xi32>) -> tensor<32x1xi1>
    %8 = stablehlo.broadcast_in_dim %c_1, dims = [1] : (tensor<1xi32>) -> tensor<1x1xi32>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x1xi32>) -> tensor<32x1xi32>
    %10 = stablehlo.compare  LE, %5, %9,  SIGNED : (tensor<32x1xi32>, tensor<32x1xi32>) -> tensor<32x1xi1>
    %11 = stablehlo.and %7, %10 : tensor<32x1xi1>
    %c_3 = stablehlo.constant dense<true> : tensor<i1>
    %12 = stablehlo.reduce(%11 init: %c_3) applies stablehlo.and across dimensions = [1] : (tensor<32x1xi1>, tensor<i1>) -> tensor<32xi1>
    %13 = "stablehlo.gather"(%arg0, %5) <{dimension_numbers = #stablehlo.gather<offset_dims = [1, 2], collapsed_slice_dims = [0], start_index_map = [0], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 1, 32, 32>}> : (tensor<32x32x32xf32>, tensor<32x1xi32>) -> tensor<32x32x32xf32>
    %14 = stablehlo.broadcast_in_dim %12, dims = [0] : (tensor<32xi1>) -> tensor<32x32x32xi1>
    %cst = stablehlo.constant dense<0x7FC00000> : tensor<f32>
    %15 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f32>) -> tensor<32x32x32xf32>
    %16 = stablehlo.select %14, %13, %15 : tensor<32x32x32xi1>, tensor<32x32x32xf32>
    return %16 : tensor<32x32x32xf32>
  }
  func.func private @_where_3(%arg0: tensor<32xi1>, %arg1: tensor<32xi32>, %arg2: tensor<32xi32>) -> tensor<32xi32> {
    %0 = stablehlo.select %arg0, %arg1, %arg2 : tensor<32xi1>, tensor<32xi32>
    return %0 : tensor<32xi32>
  }
  func.func private @_take_10(%arg0: tensor<32x32x32xf32>, %arg1: tensor<32xi32>) -> tensor<32x32x32xf32> {
    %c = stablehlo.constant dense<0> : tensor<i32>
    %0 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %1 = stablehlo.compare  LT, %arg1, %0,  SIGNED : (tensor<32xi32>, tensor<32xi32>) -> tensor<32xi1>
    %c_0 = stablehlo.constant dense<32> : tensor<i32>
    %2 = stablehlo.broadcast_in_dim %c_0, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %3 = stablehlo.add %arg1, %2 : tensor<32xi32>
    %4 = call @_where_3(%1, %3, %arg1) : (tensor<32xi1>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %5 = stablehlo.broadcast_in_dim %4, dims = [0] : (tensor<32xi32>) -> tensor<32x1xi32>
    %c_1 = stablehlo.constant dense<31> : tensor<1xi32>
    %c_2 = stablehlo.constant dense<0> : tensor<i32>
    %6 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<32x1xi32>
    %7 = stablehlo.compare  GE, %5, %6,  SIGNED : (tensor<32x1xi32>, tensor<32x1xi32>) -> tensor<32x1xi1>
    %8 = stablehlo.broadcast_in_dim %c_1, dims = [1] : (tensor<1xi32>) -> tensor<1x1xi32>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x1xi32>) -> tensor<32x1xi32>
    %10 = stablehlo.compare  LE, %5, %9,  SIGNED : (tensor<32x1xi32>, tensor<32x1xi32>) -> tensor<32x1xi1>
    %11 = stablehlo.and %7, %10 : tensor<32x1xi1>
    %c_3 = stablehlo.constant dense<true> : tensor<i1>
    %12 = stablehlo.reduce(%11 init: %c_3) applies stablehlo.and across dimensions = [1] : (tensor<32x1xi1>, tensor<i1>) -> tensor<32xi1>
    %13 = "stablehlo.gather"(%arg0, %5) <{dimension_numbers = #stablehlo.gather<offset_dims = [0, 2], collapsed_slice_dims = [1], start_index_map = [1], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 32, 1, 32>}> : (tensor<32x32x32xf32>, tensor<32x1xi32>) -> tensor<32x32x32xf32>
    %14 = stablehlo.broadcast_in_dim %12, dims = [1] : (tensor<32xi1>) -> tensor<32x32x32xi1>
    %cst = stablehlo.constant dense<0x7FC00000> : tensor<f32>
    %15 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f32>) -> tensor<32x32x32xf32>
    %16 = stablehlo.select %14, %13, %15 : tensor<32x32x32xi1>, tensor<32x32x32xf32>
    return %16 : tensor<32x32x32xf32>
  }
  func.func private @_take_14(%arg0: tensor<32x32x32xf32>, %arg1: tensor<32xi32>) -> tensor<32x32x32xf32> {
    %c = stablehlo.constant dense<0> : tensor<i32>
    %0 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %1 = stablehlo.compare  LT, %arg1, %0,  SIGNED : (tensor<32xi32>, tensor<32xi32>) -> tensor<32xi1>
    %c_0 = stablehlo.constant dense<32> : tensor<i32>
    %2 = stablehlo.broadcast_in_dim %c_0, dims = [] : (tensor<i32>) -> tensor<32xi32>
    %3 = stablehlo.add %arg1, %2 : tensor<32xi32>
    %4 = call @_where_3(%1, %3, %arg1) : (tensor<32xi1>, tensor<32xi32>, tensor<32xi32>) -> tensor<32xi32>
    %5 = stablehlo.broadcast_in_dim %4, dims = [0] : (tensor<32xi32>) -> tensor<32x1xi32>
    %c_1 = stablehlo.constant dense<31> : tensor<1xi32>
    %c_2 = stablehlo.constant dense<0> : tensor<i32>
    %6 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<32x1xi32>
    %7 = stablehlo.compare  GE, %5, %6,  SIGNED : (tensor<32x1xi32>, tensor<32x1xi32>) -> tensor<32x1xi1>
    %8 = stablehlo.broadcast_in_dim %c_1, dims = [1] : (tensor<1xi32>) -> tensor<1x1xi32>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x1xi32>) -> tensor<32x1xi32>
    %10 = stablehlo.compare  LE, %5, %9,  SIGNED : (tensor<32x1xi32>, tensor<32x1xi32>) -> tensor<32x1xi1>
    %11 = stablehlo.and %7, %10 : tensor<32x1xi1>
    %c_3 = stablehlo.constant dense<true> : tensor<i1>
    %12 = stablehlo.reduce(%11 init: %c_3) applies stablehlo.and across dimensions = [1] : (tensor<32x1xi1>, tensor<i1>) -> tensor<32xi1>
    %13 = "stablehlo.gather"(%arg0, %5) <{dimension_numbers = #stablehlo.gather<offset_dims = [0, 1], collapsed_slice_dims = [2], start_index_map = [2], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 32, 32, 1>}> : (tensor<32x32x32xf32>, tensor<32x1xi32>) -> tensor<32x32x32xf32>
    %14 = stablehlo.broadcast_in_dim %12, dims = [2] : (tensor<32xi1>) -> tensor<32x32x32xi1>
    %cst = stablehlo.constant dense<0x7FC00000> : tensor<f32>
    %15 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f32>) -> tensor<32x32x32xf32>
    %16 = stablehlo.select %14, %13, %15 : tensor<32x32x32xi1>, tensor<32x32x32xf32>
    return %16 : tensor<32x32x32xf32>
  }
}
