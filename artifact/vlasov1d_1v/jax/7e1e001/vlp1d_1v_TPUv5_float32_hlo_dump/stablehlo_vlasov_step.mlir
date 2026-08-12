module @jit__lambda attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<128x128xf32>) -> (tensor<128x128xf32> {jax.result_info = "result[0]"}, tensor<128xf32> {jax.result_info = "result[1]"}, tensor<128xf32> {jax.result_info = "result[2]"}) {
    %cst = stablehlo.constant dense<"0x0000A0C0F67A9DC0ECF59AC0E27098C0D8EB95C0CE6693C0C4E190C0BA5C8EC0B0D78BC0A65289C09BCD86C0914884C086C381C0F97C7EC0E57279C0D16874C0BD5E6FC0A9546AC0944A65C0804060C06C365BC0582C56C0442251C030184CC01C0E47C0080442C0F4F93CC0E0EF37C0CCE532C0B8DB2DC0A4D128C090C723C07CBD1EC068B319C054A914C0409F0FC02B950AC0178B05C0038100C0DEEDF6BFB6D9ECBF8EC5E2BF65B1D8BF3D9DCEBF1189C4BFE974BABFC160B0BF994CA6BF70389CBF482492BF201088BFF0F77BBFA0CF67BF4CA753BFFC7E3FBFAC562BBF5C2E17BF0C0603BF70BBDDBED06AB5BE301A8DBE209349BEC0E3F1BD804221BD8042213DC0E3F13D2093493E301A8D3ED06AB53E70BBDD3E0806033F5C2E173FAC562B3F007F3F3F50A7533FA0CF673FF0F77B3F2010883F4824923F70389C3F984CA63FC060B03FE874BA3F1089C43F3A9DCE3F62B1D83F8AC5E23FB2D9EC3FDDEDF63F02810040168B05402A950A403E9F0F4052A9144066B319407ABD1E4090C72340A4D12840B8DB2D40CCE53240E0EF3740F4F93C40080442401C0E474030184C4045225140592C56406D365B4081406040954A6540A9546A40BD5E6F40D1687440E5727940F97C7E4086C38140914884409BCD8640A5528940AFD78B40BA5C8E40C4E19040CE669340D8EB9540E2709840ECF59A40F67A9D400000A040"> : tensor<128xf32>
    %c = stablehlo.constant dense<[-2, -1, 0, 1, 2, 3]> : tensor<6xi32>
    %cst_0 = stablehlo.constant dense<[0.000000e+00, 2.000000e+00, 1.000000e+00, 0.666666686, 5.000000e-01, 4.000000e-01, 0.333333343, 0.285714298, 2.500000e-01, 0.222222224, 2.000000e-01, 0.181818187, 0.166666672, 0.153846174, 0.142857149, 0.13333334, 1.250000e-01, 0.117647059, 0.111111112, 0.105263159, 1.000000e-01, 0.095238097, 0.0909090936, 0.0869565233, 0.0833333358, 8.000000e-02, 0.0769230872, 0.0740740672, 0.0714285746, 0.068965517, 0.0666666701, 0.0645161271, 6.250000e-02, 0.0606060587, 0.0588235296, 0.0571428575, 0.055555556, 0.0540540554, 0.0526315793, 0.051282052, 5.000000e-02, 0.048780486, 0.0476190485, 0.0465116277, 0.0454545468, 0.0444444455, 0.0434782617, 0.0425531901, 0.0416666679, 0.0408163294, 4.000000e-02, 0.0392156877, 0.0384615436, 0.0377358533, 0.0370370336, 0.0363636352, 0.0357142873, 0.0350877196, 0.0344827585, 0.0338983051, 0.0333333351, 0.0327868834, 0.0322580636, 0.0317460336, 3.125000e-02]> : tensor<65xf32>
    %0 = stablehlo.transpose %arg0, dims = [1, 0] : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %cst_1 = stablehlo.constant dense<2.500000e-02> : tensor<f32>
    %cst_2 = stablehlo.constant dense<0.0981747731> : tensor<f32>
    %1 = call @advect_1d_vectorized(%0, %cst, %cst_1, %cst_2, %c) : (tensor<128x128xf32>, tensor<128xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<128x128xf32>
    %2 = stablehlo.transpose %1, dims = [1, 0] : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %cst_3 = stablehlo.constant dense<0.0787401571> : tensor<f32>
    %3:3 = call @solve_poisson(%2, %cst_0, %cst_3) : (tensor<128x128xf32>, tensor<65xf32>, tensor<f32>) -> (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>)
    %cst_4 = stablehlo.constant dense<5.000000e-02> : tensor<f32>
    %4 = call @advect_1d_vectorized_38(%2, %3#0, %cst_4, %cst_3, %c) : (tensor<128x128xf32>, tensor<128xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<128x128xf32>
    %5 = stablehlo.transpose %4, dims = [1, 0] : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %6 = call @advect_1d_vectorized(%5, %cst, %cst_1, %cst_2, %c) : (tensor<128x128xf32>, tensor<128xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<128x128xf32>
    %7 = stablehlo.transpose %6, dims = [1, 0] : (tensor<128x128xf32>) -> tensor<128x128xf32>
    return %7, %3#1, %3#2 : tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>
  }
  func.func private @advect_1d_vectorized(%arg0: tensor<128x128xf32>, %arg1: tensor<128xf32>, %arg2: tensor<f32>, %arg3: tensor<f32>, %arg4: tensor<6xi32>) -> tensor<128x128xf32> {
    %0 = stablehlo.iota dim = 0 : tensor<128xf32>
    %1 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<128xf32>) -> tensor<128x1xf32>
    %2 = stablehlo.convert %arg2 : tensor<f32>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<f32>) -> tensor<128x1xf32>
    %4 = stablehlo.multiply %1, %3 : tensor<128x1xf32>
    %5 = stablehlo.convert %arg3 : tensor<f32>
    %6 = stablehlo.broadcast_in_dim %5, dims = [] : (tensor<f32>) -> tensor<128x1xf32>
    %7 = stablehlo.divide %4, %6 : tensor<128x1xf32>
    %8 = stablehlo.broadcast_in_dim %0, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %10 = stablehlo.broadcast_in_dim %7, dims = [0, 1] : (tensor<128x1xf32>) -> tensor<128x128xf32>
    %11 = stablehlo.subtract %9, %10 : tensor<128x128xf32>
    %12 = stablehlo.floor %11 : tensor<128x128xf32>
    %13 = stablehlo.subtract %11, %12 : tensor<128x128xf32>
    %14 = stablehlo.convert %12 : (tensor<128x128xf32>) -> tensor<128x128xi32>
    %15 = stablehlo.broadcast_in_dim %14, dims = [0, 1] : (tensor<128x128xi32>) -> tensor<128x128x1xi32>
    %16 = stablehlo.broadcast_in_dim %arg4, dims = [2] : (tensor<6xi32>) -> tensor<1x1x6xi32>
    %17 = stablehlo.broadcast_in_dim %15, dims = [0, 1, 2] : (tensor<128x128x1xi32>) -> tensor<128x128x6xi32>
    %18 = stablehlo.broadcast_in_dim %16, dims = [0, 1, 2] : (tensor<1x1x6xi32>) -> tensor<128x128x6xi32>
    %19 = stablehlo.add %17, %18 : tensor<128x128x6xi32>
    %c = stablehlo.constant dense<128> : tensor<i32>
    %20 = call @remainder(%19, %c) : (tensor<128x128x6xi32>, tensor<i32>) -> tensor<128x128x6xi32>
    %21 = stablehlo.iota dim = 0 : tensor<128xi32>
    %22 = stablehlo.broadcast_in_dim %21, dims = [0] : (tensor<128xi32>) -> tensor<128x1x1xi32>
    %c_0 = stablehlo.constant dense<128> : tensor<i32>
    %23 = stablehlo.broadcast_in_dim %c_0, dims = [] : (tensor<i32>) -> tensor<128x1x1xi32>
    %24 = stablehlo.multiply %22, %23 : tensor<128x1x1xi32>
    %25 = stablehlo.broadcast_in_dim %24, dims = [0, 1, 2] : (tensor<128x1x1xi32>) -> tensor<128x128x6xi32>
    %26 = stablehlo.add %25, %20 : tensor<128x128x6xi32>
    %27 = stablehlo.reshape %arg0 : (tensor<128x128xf32>) -> tensor<16384xf32>
    %28 = stablehlo.reshape %26 : (tensor<128x128x6xi32>) -> tensor<98304xi32>
    %c_1 = stablehlo.constant dense<0> : tensor<i32>
    %29 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<98304xi32>
    %30 = stablehlo.compare  LT, %28, %29,  SIGNED : (tensor<98304xi32>, tensor<98304xi32>) -> tensor<98304xi1>
    %c_2 = stablehlo.constant dense<16384> : tensor<i32>
    %31 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<98304xi32>
    %32 = stablehlo.add %28, %31 : tensor<98304xi32>
    %33 = stablehlo.select %30, %32, %28 : tensor<98304xi1>, tensor<98304xi32>
    %34 = stablehlo.broadcast_in_dim %33, dims = [0] : (tensor<98304xi32>) -> tensor<98304x1xi32>
    %35 = "stablehlo.gather"(%27, %34) <{dimension_numbers = #stablehlo.gather<collapsed_slice_dims = [0], start_index_map = [0], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 1>}> : (tensor<16384xf32>, tensor<98304x1xi32>) -> tensor<98304xf32>
    %36 = stablehlo.reshape %35 : (tensor<98304xf32>) -> tensor<128x128x6xf32>
    %37 = stablehlo.multiply %13, %13 : tensor<128x128xf32>
    %38 = stablehlo.multiply %37, %13 : tensor<128x128xf32>
    %39 = stablehlo.multiply %38, %13 : tensor<128x128xf32>
    %40 = stablehlo.multiply %39, %13 : tensor<128x128xf32>
    %cst = stablehlo.constant dense<2.000000e+01> : tensor<f32>
    %41 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %42 = stablehlo.divide %13, %41 : tensor<128x128xf32>
    %cst_3 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %43 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %44 = stablehlo.divide %37, %43 : tensor<128x128xf32>
    %45 = stablehlo.subtract %42, %44 : tensor<128x128xf32>
    %cst_4 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %46 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %47 = stablehlo.divide %38, %46 : tensor<128x128xf32>
    %48 = stablehlo.subtract %45, %47 : tensor<128x128xf32>
    %cst_5 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %49 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %50 = stablehlo.divide %39, %49 : tensor<128x128xf32>
    %51 = stablehlo.add %48, %50 : tensor<128x128xf32>
    %cst_6 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %52 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %53 = stablehlo.divide %40, %52 : tensor<128x128xf32>
    %54 = stablehlo.subtract %51, %53 : tensor<128x128xf32>
    %cst_7 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %55 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %56 = stablehlo.divide %13, %55 : tensor<128x128xf32>
    %57 = stablehlo.negate %56 : tensor<128x128xf32>
    %cst_8 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %58 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %59 = stablehlo.multiply %58, %37 : tensor<128x128xf32>
    %cst_9 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %60 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %61 = stablehlo.divide %59, %60 : tensor<128x128xf32>
    %62 = stablehlo.add %57, %61 : tensor<128x128xf32>
    %cst_10 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %63 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %64 = stablehlo.divide %38, %63 : tensor<128x128xf32>
    %65 = stablehlo.subtract %62, %64 : tensor<128x128xf32>
    %cst_11 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %66 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %67 = stablehlo.divide %39, %66 : tensor<128x128xf32>
    %68 = stablehlo.subtract %65, %67 : tensor<128x128xf32>
    %cst_12 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %69 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %70 = stablehlo.divide %40, %69 : tensor<128x128xf32>
    %71 = stablehlo.add %68, %70 : tensor<128x128xf32>
    %cst_13 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %72 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %73 = stablehlo.divide %13, %72 : tensor<128x128xf32>
    %cst_14 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %74 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %75 = stablehlo.subtract %74, %73 : tensor<128x128xf32>
    %cst_15 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %76 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %77 = stablehlo.multiply %76, %37 : tensor<128x128xf32>
    %cst_16 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %78 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %79 = stablehlo.divide %77, %78 : tensor<128x128xf32>
    %80 = stablehlo.subtract %75, %79 : tensor<128x128xf32>
    %cst_17 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %81 = stablehlo.broadcast_in_dim %cst_17, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %82 = stablehlo.multiply %81, %38 : tensor<128x128xf32>
    %cst_18 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %83 = stablehlo.broadcast_in_dim %cst_18, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %84 = stablehlo.divide %82, %83 : tensor<128x128xf32>
    %85 = stablehlo.add %80, %84 : tensor<128x128xf32>
    %cst_19 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %86 = stablehlo.broadcast_in_dim %cst_19, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %87 = stablehlo.divide %39, %86 : tensor<128x128xf32>
    %88 = stablehlo.add %85, %87 : tensor<128x128xf32>
    %cst_20 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %89 = stablehlo.broadcast_in_dim %cst_20, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %90 = stablehlo.divide %40, %89 : tensor<128x128xf32>
    %91 = stablehlo.subtract %88, %90 : tensor<128x128xf32>
    %cst_21 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %92 = stablehlo.broadcast_in_dim %cst_21, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %93 = stablehlo.multiply %92, %37 : tensor<128x128xf32>
    %cst_22 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %94 = stablehlo.broadcast_in_dim %cst_22, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %95 = stablehlo.divide %93, %94 : tensor<128x128xf32>
    %96 = stablehlo.add %13, %95 : tensor<128x128xf32>
    %cst_23 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %97 = stablehlo.broadcast_in_dim %cst_23, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %98 = stablehlo.multiply %97, %38 : tensor<128x128xf32>
    %cst_24 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %99 = stablehlo.broadcast_in_dim %cst_24, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %100 = stablehlo.divide %98, %99 : tensor<128x128xf32>
    %101 = stablehlo.subtract %96, %100 : tensor<128x128xf32>
    %cst_25 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %102 = stablehlo.broadcast_in_dim %cst_25, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %103 = stablehlo.divide %39, %102 : tensor<128x128xf32>
    %104 = stablehlo.subtract %101, %103 : tensor<128x128xf32>
    %cst_26 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %105 = stablehlo.broadcast_in_dim %cst_26, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %106 = stablehlo.divide %40, %105 : tensor<128x128xf32>
    %107 = stablehlo.add %104, %106 : tensor<128x128xf32>
    %cst_27 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %108 = stablehlo.broadcast_in_dim %cst_27, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %109 = stablehlo.divide %13, %108 : tensor<128x128xf32>
    %110 = stablehlo.negate %109 : tensor<128x128xf32>
    %cst_28 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %111 = stablehlo.broadcast_in_dim %cst_28, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %112 = stablehlo.divide %37, %111 : tensor<128x128xf32>
    %113 = stablehlo.subtract %110, %112 : tensor<128x128xf32>
    %cst_29 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %114 = stablehlo.broadcast_in_dim %cst_29, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %115 = stablehlo.multiply %114, %38 : tensor<128x128xf32>
    %cst_30 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %116 = stablehlo.broadcast_in_dim %cst_30, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %117 = stablehlo.divide %115, %116 : tensor<128x128xf32>
    %118 = stablehlo.add %113, %117 : tensor<128x128xf32>
    %cst_31 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %119 = stablehlo.broadcast_in_dim %cst_31, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %120 = stablehlo.divide %39, %119 : tensor<128x128xf32>
    %121 = stablehlo.add %118, %120 : tensor<128x128xf32>
    %cst_32 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %122 = stablehlo.broadcast_in_dim %cst_32, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %123 = stablehlo.divide %40, %122 : tensor<128x128xf32>
    %124 = stablehlo.subtract %121, %123 : tensor<128x128xf32>
    %cst_33 = stablehlo.constant dense<3.000000e+01> : tensor<f32>
    %125 = stablehlo.broadcast_in_dim %cst_33, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %126 = stablehlo.divide %13, %125 : tensor<128x128xf32>
    %cst_34 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %127 = stablehlo.broadcast_in_dim %cst_34, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %128 = stablehlo.divide %38, %127 : tensor<128x128xf32>
    %129 = stablehlo.subtract %126, %128 : tensor<128x128xf32>
    %cst_35 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %130 = stablehlo.broadcast_in_dim %cst_35, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %131 = stablehlo.divide %40, %130 : tensor<128x128xf32>
    %132 = stablehlo.add %129, %131 : tensor<128x128xf32>
    %133 = stablehlo.slice %36 [0:128, 0:128, 0:1] : (tensor<128x128x6xf32>) -> tensor<128x128x1xf32>
    %134 = stablehlo.reshape %133 : (tensor<128x128x1xf32>) -> tensor<128x128xf32>
    %135 = stablehlo.multiply %54, %134 : tensor<128x128xf32>
    %136 = stablehlo.slice %36 [0:128, 0:128, 1:2] : (tensor<128x128x6xf32>) -> tensor<128x128x1xf32>
    %137 = stablehlo.reshape %136 : (tensor<128x128x1xf32>) -> tensor<128x128xf32>
    %138 = stablehlo.multiply %71, %137 : tensor<128x128xf32>
    %139 = stablehlo.add %135, %138 : tensor<128x128xf32>
    %140 = stablehlo.slice %36 [0:128, 0:128, 2:3] : (tensor<128x128x6xf32>) -> tensor<128x128x1xf32>
    %141 = stablehlo.reshape %140 : (tensor<128x128x1xf32>) -> tensor<128x128xf32>
    %142 = stablehlo.multiply %91, %141 : tensor<128x128xf32>
    %143 = stablehlo.add %139, %142 : tensor<128x128xf32>
    %144 = stablehlo.slice %36 [0:128, 0:128, 3:4] : (tensor<128x128x6xf32>) -> tensor<128x128x1xf32>
    %145 = stablehlo.reshape %144 : (tensor<128x128x1xf32>) -> tensor<128x128xf32>
    %146 = stablehlo.multiply %107, %145 : tensor<128x128xf32>
    %147 = stablehlo.add %143, %146 : tensor<128x128xf32>
    %148 = stablehlo.slice %36 [0:128, 0:128, 4:5] : (tensor<128x128x6xf32>) -> tensor<128x128x1xf32>
    %149 = stablehlo.reshape %148 : (tensor<128x128x1xf32>) -> tensor<128x128xf32>
    %150 = stablehlo.multiply %124, %149 : tensor<128x128xf32>
    %151 = stablehlo.add %147, %150 : tensor<128x128xf32>
    %152 = stablehlo.slice %36 [0:128, 0:128, 5:6] : (tensor<128x128x6xf32>) -> tensor<128x128x1xf32>
    %153 = stablehlo.reshape %152 : (tensor<128x128x1xf32>) -> tensor<128x128xf32>
    %154 = stablehlo.multiply %132, %153 : tensor<128x128xf32>
    %155 = stablehlo.add %151, %154 : tensor<128x128xf32>
    return %155 : tensor<128x128xf32>
  }
  func.func private @remainder(%arg0: tensor<128x128x6xi32>, %arg1: tensor<i32>) -> tensor<128x128x6xi32> {
    %0 = stablehlo.convert %arg1 : tensor<i32>
    %c = stablehlo.constant dense<0> : tensor<i32>
    %1 = stablehlo.compare  EQ, %0, %c,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %2 = call @_where(%1, %c_0, %0) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %4 = stablehlo.remainder %arg0, %3 : tensor<128x128x6xi32>
    %c_1 = stablehlo.constant dense<0> : tensor<i32>
    %5 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %6 = stablehlo.compare  NE, %4, %5,  SIGNED : (tensor<128x128x6xi32>, tensor<128x128x6xi32>) -> tensor<128x128x6xi1>
    %c_2 = stablehlo.constant dense<0> : tensor<i32>
    %7 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %8 = stablehlo.compare  LT, %4, %7,  SIGNED : (tensor<128x128x6xi32>, tensor<128x128x6xi32>) -> tensor<128x128x6xi1>
    %c_3 = stablehlo.constant dense<0> : tensor<i32>
    %9 = stablehlo.compare  LT, %2, %c_3,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %10 = stablehlo.broadcast_in_dim %9, dims = [] : (tensor<i1>) -> tensor<128x128x6xi1>
    %11 = stablehlo.compare  NE, %8, %10,  UNSIGNED : (tensor<128x128x6xi1>, tensor<128x128x6xi1>) -> tensor<128x128x6xi1>
    %12 = stablehlo.and %11, %6 : tensor<128x128x6xi1>
    %13 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %14 = stablehlo.add %4, %13 : tensor<128x128x6xi32>
    %15 = stablehlo.select %12, %14, %4 : tensor<128x128x6xi1>, tensor<128x128x6xi32>
    return %15 : tensor<128x128x6xi32>
  }
  func.func private @_where(%arg0: tensor<i1>, %arg1: tensor<i32>, %arg2: tensor<i32>) -> tensor<i32> {
    %0 = stablehlo.select %arg0, %arg1, %arg2 : tensor<i1>, tensor<i32>
    return %0 : tensor<i32>
  }
  func.func private @solve_poisson(%arg0: tensor<128x128xf32>, %arg1: tensor<65xf32>, %arg2: tensor<f32>) -> (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>) {
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %0 = stablehlo.reduce(%arg0 init: %cst) applies stablehlo.add across dimensions = [1] : (tensor<128x128xf32>, tensor<f32>) -> tensor<128xf32>
    %1 = stablehlo.convert %arg2 : tensor<f32>
    %2 = stablehlo.broadcast_in_dim %1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %3 = stablehlo.multiply %0, %2 : tensor<128xf32>
    %cst_0 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %4 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %5 = stablehlo.subtract %3, %4 : tensor<128xf32>
    %6 = call @fft(%5) : (tensor<128xf32>) -> tensor<65xcomplex<f32>>
    %cst_1 = stablehlo.constant dense<(-0.000000e+00,-1.000000e+00)> : tensor<complex<f32>>
    %7 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<complex<f32>>) -> tensor<65xcomplex<f32>>
    %8 = stablehlo.multiply %7, %6 : tensor<65xcomplex<f32>>
    %9 = stablehlo.convert %arg1 : (tensor<65xf32>) -> tensor<65xcomplex<f32>>
    %10 = stablehlo.multiply %8, %9 : tensor<65xcomplex<f32>>
    %11 = call @fft_36(%10) : (tensor<65xcomplex<f32>>) -> tensor<128xf32>
    %12 = stablehlo.multiply %arg1, %arg1 : tensor<65xf32>
    %13 = stablehlo.convert %12 : (tensor<65xf32>) -> tensor<65xcomplex<f32>>
    %14 = stablehlo.multiply %6, %13 : tensor<65xcomplex<f32>>
    %15 = call @fft_36(%14) : (tensor<65xcomplex<f32>>) -> tensor<128xf32>
    return %11, %5, %15 : tensor<128xf32>, tensor<128xf32>, tensor<128xf32>
  }
  func.func private @fft(%arg0: tensor<128xf32>) -> tensor<65xcomplex<f32>> {
    %0 = stablehlo.fft %arg0, type =  RFFT, length = [128] : (tensor<128xf32>) -> tensor<65xcomplex<f32>>
    return %0 : tensor<65xcomplex<f32>>
  }
  func.func private @fft_36(%arg0: tensor<65xcomplex<f32>>) -> tensor<128xf32> {
    %0 = stablehlo.fft %arg0, type =  IRFFT, length = [128] : (tensor<65xcomplex<f32>>) -> tensor<128xf32>
    return %0 : tensor<128xf32>
  }
  func.func private @advect_1d_vectorized_38(%arg0: tensor<128x128xf32>, %arg1: tensor<128xf32>, %arg2: tensor<f32>, %arg3: tensor<f32>, %arg4: tensor<6xi32>) -> tensor<128x128xf32> {
    %0 = stablehlo.iota dim = 0 : tensor<128xf32>
    %1 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<128xf32>) -> tensor<128x1xf32>
    %2 = stablehlo.convert %arg2 : tensor<f32>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<f32>) -> tensor<128x1xf32>
    %4 = stablehlo.multiply %1, %3 : tensor<128x1xf32>
    %5 = stablehlo.convert %arg3 : tensor<f32>
    %6 = stablehlo.broadcast_in_dim %5, dims = [] : (tensor<f32>) -> tensor<128x1xf32>
    %7 = stablehlo.divide %4, %6 : tensor<128x1xf32>
    %8 = stablehlo.broadcast_in_dim %0, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %10 = stablehlo.broadcast_in_dim %7, dims = [0, 1] : (tensor<128x1xf32>) -> tensor<128x128xf32>
    %11 = stablehlo.subtract %9, %10 : tensor<128x128xf32>
    %12 = stablehlo.floor %11 : tensor<128x128xf32>
    %13 = stablehlo.subtract %11, %12 : tensor<128x128xf32>
    %14 = stablehlo.convert %12 : (tensor<128x128xf32>) -> tensor<128x128xi32>
    %15 = stablehlo.broadcast_in_dim %14, dims = [0, 1] : (tensor<128x128xi32>) -> tensor<128x128x1xi32>
    %16 = stablehlo.broadcast_in_dim %arg4, dims = [2] : (tensor<6xi32>) -> tensor<1x1x6xi32>
    %17 = stablehlo.broadcast_in_dim %15, dims = [0, 1, 2] : (tensor<128x128x1xi32>) -> tensor<128x128x6xi32>
    %18 = stablehlo.broadcast_in_dim %16, dims = [0, 1, 2] : (tensor<1x1x6xi32>) -> tensor<128x128x6xi32>
    %19 = stablehlo.add %17, %18 : tensor<128x128x6xi32>
    %c = stablehlo.constant dense<0> : tensor<i32>
    %20 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %21 = stablehlo.compare  GE, %19, %20,  SIGNED : (tensor<128x128x6xi32>, tensor<128x128x6xi32>) -> tensor<128x128x6xi1>
    %c_0 = stablehlo.constant dense<128> : tensor<i32>
    %22 = stablehlo.broadcast_in_dim %c_0, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %23 = stablehlo.compare  LT, %19, %22,  SIGNED : (tensor<128x128x6xi32>, tensor<128x128x6xi32>) -> tensor<128x128x6xi1>
    %24 = stablehlo.and %21, %23 : tensor<128x128x6xi1>
    %c_1 = stablehlo.constant dense<0> : tensor<i32>
    %c_2 = stablehlo.constant dense<127> : tensor<i32>
    %25 = call @clip(%19, %c_1, %c_2) : (tensor<128x128x6xi32>, tensor<i32>, tensor<i32>) -> tensor<128x128x6xi32>
    %26 = stablehlo.iota dim = 0 : tensor<128xi32>
    %27 = stablehlo.broadcast_in_dim %26, dims = [0] : (tensor<128xi32>) -> tensor<128x1x1xi32>
    %c_3 = stablehlo.constant dense<128> : tensor<i32>
    %28 = stablehlo.broadcast_in_dim %c_3, dims = [] : (tensor<i32>) -> tensor<128x1x1xi32>
    %29 = stablehlo.multiply %27, %28 : tensor<128x1x1xi32>
    %30 = stablehlo.broadcast_in_dim %29, dims = [0, 1, 2] : (tensor<128x1x1xi32>) -> tensor<128x128x6xi32>
    %31 = stablehlo.add %30, %25 : tensor<128x128x6xi32>
    %32 = stablehlo.reshape %arg0 : (tensor<128x128xf32>) -> tensor<16384xf32>
    %33 = stablehlo.reshape %31 : (tensor<128x128x6xi32>) -> tensor<98304xi32>
    %c_4 = stablehlo.constant dense<0> : tensor<i32>
    %34 = stablehlo.broadcast_in_dim %c_4, dims = [] : (tensor<i32>) -> tensor<98304xi32>
    %35 = stablehlo.compare  LT, %33, %34,  SIGNED : (tensor<98304xi32>, tensor<98304xi32>) -> tensor<98304xi1>
    %c_5 = stablehlo.constant dense<16384> : tensor<i32>
    %36 = stablehlo.broadcast_in_dim %c_5, dims = [] : (tensor<i32>) -> tensor<98304xi32>
    %37 = stablehlo.add %33, %36 : tensor<98304xi32>
    %38 = stablehlo.select %35, %37, %33 : tensor<98304xi1>, tensor<98304xi32>
    %39 = stablehlo.broadcast_in_dim %38, dims = [0] : (tensor<98304xi32>) -> tensor<98304x1xi32>
    %40 = "stablehlo.gather"(%32, %39) <{dimension_numbers = #stablehlo.gather<collapsed_slice_dims = [0], start_index_map = [0], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 1>}> : (tensor<16384xf32>, tensor<98304x1xi32>) -> tensor<98304xf32>
    %41 = stablehlo.reshape %40 : (tensor<98304xf32>) -> tensor<128x128x6xf32>
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %42 = call @_where_39(%24, %41, %cst) : (tensor<128x128x6xi1>, tensor<128x128x6xf32>, tensor<f32>) -> tensor<128x128x6xf32>
    %43 = stablehlo.multiply %13, %13 : tensor<128x128xf32>
    %44 = stablehlo.multiply %43, %13 : tensor<128x128xf32>
    %45 = stablehlo.multiply %44, %13 : tensor<128x128xf32>
    %46 = stablehlo.multiply %45, %13 : tensor<128x128xf32>
    %cst_6 = stablehlo.constant dense<2.000000e+01> : tensor<f32>
    %47 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %48 = stablehlo.divide %13, %47 : tensor<128x128xf32>
    %cst_7 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %49 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %50 = stablehlo.divide %43, %49 : tensor<128x128xf32>
    %51 = stablehlo.subtract %48, %50 : tensor<128x128xf32>
    %cst_8 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %52 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %53 = stablehlo.divide %44, %52 : tensor<128x128xf32>
    %54 = stablehlo.subtract %51, %53 : tensor<128x128xf32>
    %cst_9 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %55 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %56 = stablehlo.divide %45, %55 : tensor<128x128xf32>
    %57 = stablehlo.add %54, %56 : tensor<128x128xf32>
    %cst_10 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %58 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %59 = stablehlo.divide %46, %58 : tensor<128x128xf32>
    %60 = stablehlo.subtract %57, %59 : tensor<128x128xf32>
    %cst_11 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %61 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %62 = stablehlo.divide %13, %61 : tensor<128x128xf32>
    %63 = stablehlo.negate %62 : tensor<128x128xf32>
    %cst_12 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %64 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %65 = stablehlo.multiply %64, %43 : tensor<128x128xf32>
    %cst_13 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %66 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %67 = stablehlo.divide %65, %66 : tensor<128x128xf32>
    %68 = stablehlo.add %63, %67 : tensor<128x128xf32>
    %cst_14 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %69 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %70 = stablehlo.divide %44, %69 : tensor<128x128xf32>
    %71 = stablehlo.subtract %68, %70 : tensor<128x128xf32>
    %cst_15 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %72 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %73 = stablehlo.divide %45, %72 : tensor<128x128xf32>
    %74 = stablehlo.subtract %71, %73 : tensor<128x128xf32>
    %cst_16 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %75 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %76 = stablehlo.divide %46, %75 : tensor<128x128xf32>
    %77 = stablehlo.add %74, %76 : tensor<128x128xf32>
    %cst_17 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %78 = stablehlo.broadcast_in_dim %cst_17, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %79 = stablehlo.divide %13, %78 : tensor<128x128xf32>
    %cst_18 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %80 = stablehlo.broadcast_in_dim %cst_18, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %81 = stablehlo.subtract %80, %79 : tensor<128x128xf32>
    %cst_19 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %82 = stablehlo.broadcast_in_dim %cst_19, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %83 = stablehlo.multiply %82, %43 : tensor<128x128xf32>
    %cst_20 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %84 = stablehlo.broadcast_in_dim %cst_20, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %85 = stablehlo.divide %83, %84 : tensor<128x128xf32>
    %86 = stablehlo.subtract %81, %85 : tensor<128x128xf32>
    %cst_21 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %87 = stablehlo.broadcast_in_dim %cst_21, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %88 = stablehlo.multiply %87, %44 : tensor<128x128xf32>
    %cst_22 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %89 = stablehlo.broadcast_in_dim %cst_22, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %90 = stablehlo.divide %88, %89 : tensor<128x128xf32>
    %91 = stablehlo.add %86, %90 : tensor<128x128xf32>
    %cst_23 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %92 = stablehlo.broadcast_in_dim %cst_23, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %93 = stablehlo.divide %45, %92 : tensor<128x128xf32>
    %94 = stablehlo.add %91, %93 : tensor<128x128xf32>
    %cst_24 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %95 = stablehlo.broadcast_in_dim %cst_24, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %96 = stablehlo.divide %46, %95 : tensor<128x128xf32>
    %97 = stablehlo.subtract %94, %96 : tensor<128x128xf32>
    %cst_25 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %98 = stablehlo.broadcast_in_dim %cst_25, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %99 = stablehlo.multiply %98, %43 : tensor<128x128xf32>
    %cst_26 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %100 = stablehlo.broadcast_in_dim %cst_26, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %101 = stablehlo.divide %99, %100 : tensor<128x128xf32>
    %102 = stablehlo.add %13, %101 : tensor<128x128xf32>
    %cst_27 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %103 = stablehlo.broadcast_in_dim %cst_27, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %104 = stablehlo.multiply %103, %44 : tensor<128x128xf32>
    %cst_28 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %105 = stablehlo.broadcast_in_dim %cst_28, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %106 = stablehlo.divide %104, %105 : tensor<128x128xf32>
    %107 = stablehlo.subtract %102, %106 : tensor<128x128xf32>
    %cst_29 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %108 = stablehlo.broadcast_in_dim %cst_29, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %109 = stablehlo.divide %45, %108 : tensor<128x128xf32>
    %110 = stablehlo.subtract %107, %109 : tensor<128x128xf32>
    %cst_30 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %111 = stablehlo.broadcast_in_dim %cst_30, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %112 = stablehlo.divide %46, %111 : tensor<128x128xf32>
    %113 = stablehlo.add %110, %112 : tensor<128x128xf32>
    %cst_31 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %114 = stablehlo.broadcast_in_dim %cst_31, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %115 = stablehlo.divide %13, %114 : tensor<128x128xf32>
    %116 = stablehlo.negate %115 : tensor<128x128xf32>
    %cst_32 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %117 = stablehlo.broadcast_in_dim %cst_32, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %118 = stablehlo.divide %43, %117 : tensor<128x128xf32>
    %119 = stablehlo.subtract %116, %118 : tensor<128x128xf32>
    %cst_33 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %120 = stablehlo.broadcast_in_dim %cst_33, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %121 = stablehlo.multiply %120, %44 : tensor<128x128xf32>
    %cst_34 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %122 = stablehlo.broadcast_in_dim %cst_34, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %123 = stablehlo.divide %121, %122 : tensor<128x128xf32>
    %124 = stablehlo.add %119, %123 : tensor<128x128xf32>
    %cst_35 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %125 = stablehlo.broadcast_in_dim %cst_35, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %126 = stablehlo.divide %45, %125 : tensor<128x128xf32>
    %127 = stablehlo.add %124, %126 : tensor<128x128xf32>
    %cst_36 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %128 = stablehlo.broadcast_in_dim %cst_36, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %129 = stablehlo.divide %46, %128 : tensor<128x128xf32>
    %130 = stablehlo.subtract %127, %129 : tensor<128x128xf32>
    %cst_37 = stablehlo.constant dense<3.000000e+01> : tensor<f32>
    %131 = stablehlo.broadcast_in_dim %cst_37, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %132 = stablehlo.divide %13, %131 : tensor<128x128xf32>
    %cst_38 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %133 = stablehlo.broadcast_in_dim %cst_38, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %134 = stablehlo.divide %44, %133 : tensor<128x128xf32>
    %135 = stablehlo.subtract %132, %134 : tensor<128x128xf32>
    %cst_39 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %136 = stablehlo.broadcast_in_dim %cst_39, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %137 = stablehlo.divide %46, %136 : tensor<128x128xf32>
    %138 = stablehlo.add %135, %137 : tensor<128x128xf32>
    %139 = stablehlo.slice %42 [0:128, 0:128, 0:1] : (tensor<128x128x6xf32>) -> tensor<128x128x1xf32>
    %140 = stablehlo.reshape %139 : (tensor<128x128x1xf32>) -> tensor<128x128xf32>
    %141 = stablehlo.multiply %60, %140 : tensor<128x128xf32>
    %142 = stablehlo.slice %42 [0:128, 0:128, 1:2] : (tensor<128x128x6xf32>) -> tensor<128x128x1xf32>
    %143 = stablehlo.reshape %142 : (tensor<128x128x1xf32>) -> tensor<128x128xf32>
    %144 = stablehlo.multiply %77, %143 : tensor<128x128xf32>
    %145 = stablehlo.add %141, %144 : tensor<128x128xf32>
    %146 = stablehlo.slice %42 [0:128, 0:128, 2:3] : (tensor<128x128x6xf32>) -> tensor<128x128x1xf32>
    %147 = stablehlo.reshape %146 : (tensor<128x128x1xf32>) -> tensor<128x128xf32>
    %148 = stablehlo.multiply %97, %147 : tensor<128x128xf32>
    %149 = stablehlo.add %145, %148 : tensor<128x128xf32>
    %150 = stablehlo.slice %42 [0:128, 0:128, 3:4] : (tensor<128x128x6xf32>) -> tensor<128x128x1xf32>
    %151 = stablehlo.reshape %150 : (tensor<128x128x1xf32>) -> tensor<128x128xf32>
    %152 = stablehlo.multiply %113, %151 : tensor<128x128xf32>
    %153 = stablehlo.add %149, %152 : tensor<128x128xf32>
    %154 = stablehlo.slice %42 [0:128, 0:128, 4:5] : (tensor<128x128x6xf32>) -> tensor<128x128x1xf32>
    %155 = stablehlo.reshape %154 : (tensor<128x128x1xf32>) -> tensor<128x128xf32>
    %156 = stablehlo.multiply %130, %155 : tensor<128x128xf32>
    %157 = stablehlo.add %153, %156 : tensor<128x128xf32>
    %158 = stablehlo.slice %42 [0:128, 0:128, 5:6] : (tensor<128x128x6xf32>) -> tensor<128x128x1xf32>
    %159 = stablehlo.reshape %158 : (tensor<128x128x1xf32>) -> tensor<128x128xf32>
    %160 = stablehlo.multiply %138, %159 : tensor<128x128xf32>
    %161 = stablehlo.add %157, %160 : tensor<128x128xf32>
    return %161 : tensor<128x128xf32>
  }
  func.func private @clip(%arg0: tensor<128x128x6xi32>, %arg1: tensor<i32>, %arg2: tensor<i32>) -> tensor<128x128x6xi32> {
    %0 = stablehlo.convert %arg1 : tensor<i32>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %2 = stablehlo.maximum %1, %arg0 : tensor<128x128x6xi32>
    %3 = stablehlo.convert %arg2 : tensor<i32>
    %4 = stablehlo.broadcast_in_dim %3, dims = [] : (tensor<i32>) -> tensor<128x128x6xi32>
    %5 = stablehlo.minimum %4, %2 : tensor<128x128x6xi32>
    return %5 : tensor<128x128x6xi32>
  }
  func.func private @_where_39(%arg0: tensor<128x128x6xi1>, %arg1: tensor<128x128x6xf32>, %arg2: tensor<f32>) -> tensor<128x128x6xf32> {
    %0 = stablehlo.convert %arg2 : tensor<f32>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f32>) -> tensor<128x128x6xf32>
    %2 = stablehlo.select %arg0, %arg1, %1 : tensor<128x128x6xi1>, tensor<128x128x6xf32>
    return %2 : tensor<128x128x6xf32>
  }
}
