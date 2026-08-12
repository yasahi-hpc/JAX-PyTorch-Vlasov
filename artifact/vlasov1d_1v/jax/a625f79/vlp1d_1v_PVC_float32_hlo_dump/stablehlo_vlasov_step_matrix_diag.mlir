module @jit__lambda_ attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<128x128xf32>) -> (tensor<128x128xf32> {jax.result_info = "[0]"}, tensor<128xf32> {jax.result_info = "[1]"}, tensor<128xf32> {jax.result_info = "[2]"}) {
    %cst = stablehlo.constant dense<"0x0000A0C0F67A9DC0ECF59AC0E27098C0D8EB95C0CE6693C0C4E190C0BA5C8EC0B0D78BC0A65289C09BCD86C0914884C086C381C0F97C7EC0E57279C0D16874C0BD5E6FC0A9546AC0944A65C0804060C06C365BC0582C56C0442251C030184CC01C0E47C0080442C0F4F93CC0E0EF37C0CCE532C0B8DB2DC0A4D128C090C723C07CBD1EC068B319C054A914C0409F0FC02B950AC0178B05C0038100C0DEEDF6BFB6D9ECBF8EC5E2BF65B1D8BF3D9DCEBF1189C4BFE974BABFC160B0BF994CA6BF70389CBF482492BF201088BFF0F77BBFA0CF67BF4CA753BFFC7E3FBFAC562BBF5C2E17BF0C0603BF70BBDDBED06AB5BE301A8DBE209349BEC0E3F1BD804221BD8042213DC0E3F13D2093493E301A8D3ED06AB53E70BBDD3E0806033F5C2E173FAC562B3F007F3F3F50A7533FA0CF673FF0F77B3F2010883F4824923F70389C3F984CA63FC060B03FE874BA3F1089C43F3A9DCE3F62B1D83F8AC5E23FB2D9EC3FDDEDF63F02810040168B05402A950A403E9F0F4052A9144066B319407ABD1E4090C72340A4D12840B8DB2D40CCE53240E0EF3740F4F93C40080442401C0E474030184C4045225140592C56406D365B4081406040954A6540A9546A40BD5E6F40D1687440E5727940F97C7E4086C38140914884409BCD8640A5528940AFD78B40BA5C8E40C4E19040CE669340D8EB9540E2709840ECF59A40F67A9D400000A040"> : tensor<128xf32>
    %c = stablehlo.constant dense<[-2, -1, 0, 1, 2, 3]> : tensor<6xi32>
    %cst_0 = stablehlo.constant dense<[0.000000e+00, 2.000000e+00, 1.000000e+00, 0.666666686, 5.000000e-01, 4.000000e-01, 0.333333343, 0.285714269, 2.500000e-01, 0.222222224, 2.000000e-01, 0.181818187, 0.166666672, 0.153846174, 0.142857134, 0.133333325, 1.250000e-01, 0.117647059, 0.111111112, 0.105263159, 1.000000e-01, 0.095238097, 0.0909090936, 0.0869565159, 0.0833333358, 8.000000e-02, 0.0769230872, 0.0740740672, 0.0714285671, 0.068965517, 0.0666666627, 0.0645161271, 6.250000e-02, 0.0606060587, 0.0588235296, 0.0571428537, 0.055555556, 0.0540540516, 0.0526315793, 0.051282052, 5.000000e-02, 0.048780486, 0.0476190485, 0.0465116277, 0.0454545468, 0.0444444455, 0.043478258, 0.0425531901, 0.0416666679, 0.0408163257, 4.000000e-02, 0.0392156877, 0.0384615436, 0.0377358496, 0.0370370336, 0.0363636352, 0.0357142836, 0.0350877196, 0.0344827585, 0.0338983051, 0.0333333313, 0.0327868834, 0.0322580636, 0.0317460299, 3.125000e-02]> : tensor<65xf32>
    %cst_1 = stablehlo.constant dense<2.500000e-02> : tensor<f32>
    %cst_2 = stablehlo.constant dense<0.0981747731> : tensor<f32>
    %0 = call @advect_1d_matrix_diag(%arg0, %cst, %cst_1, %cst_2, %c) : (tensor<128x128xf32>, tensor<128xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<128x128xf32>
    %cst_3 = stablehlo.constant dense<0.0787401571> : tensor<f32>
    %1:3 = call @solve_poisson(%0, %cst_0, %cst_3) : (tensor<128x128xf32>, tensor<65xf32>, tensor<f32>) -> (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>)
    %cst_4 = stablehlo.constant dense<5.000000e-02> : tensor<f32>
    %2 = call @advect_1d_matrix_diag_1(%0, %1#0, %cst_4, %cst_3, %c) : (tensor<128x128xf32>, tensor<128xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<128x128xf32>
    %3 = call @advect_1d_matrix_diag(%2, %cst, %cst_1, %cst_2, %c) : (tensor<128x128xf32>, tensor<128xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<128x128xf32>
    return %3, %1#1, %1#2 : tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>
  }
  func.func private @advect_1d_matrix_diag(%arg0: tensor<128x128xf32>, %arg1: tensor<128xf32>, %arg2: tensor<f32>, %arg3: tensor<f32>, %arg4: tensor<6xi32>) -> tensor<128x128xf32> {
    %0 = stablehlo.convert %arg2 : tensor<f32>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %2 = stablehlo.multiply %arg1, %1 : tensor<128xf32>
    %3 = stablehlo.convert %arg3 : tensor<f32>
    %4 = stablehlo.broadcast_in_dim %3, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %5 = stablehlo.divide %2, %4 : tensor<128xf32>
    %6 = stablehlo.floor %5 : tensor<128xf32>
    %7 = stablehlo.subtract %5, %6 : tensor<128xf32>
    %8 = stablehlo.convert %6 : (tensor<128xf32>) -> tensor<128xi32>
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %9 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %10 = stablehlo.multiply %7, %7 : tensor<128xf32>
    %11 = stablehlo.multiply %10, %7 : tensor<128xf32>
    %12 = stablehlo.multiply %11, %7 : tensor<128xf32>
    %13 = stablehlo.multiply %12, %7 : tensor<128xf32>
    %cst_0 = stablehlo.constant dense<2.000000e+01> : tensor<f32>
    %14 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %15 = stablehlo.divide %7, %14 : tensor<128xf32>
    %cst_1 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %16 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %17 = stablehlo.divide %10, %16 : tensor<128xf32>
    %18 = stablehlo.subtract %15, %17 : tensor<128xf32>
    %19 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %20 = stablehlo.divide %11, %19 : tensor<128xf32>
    %21 = stablehlo.subtract %18, %20 : tensor<128xf32>
    %22 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %23 = stablehlo.divide %12, %22 : tensor<128xf32>
    %24 = stablehlo.add %21, %23 : tensor<128xf32>
    %cst_2 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %25 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %26 = stablehlo.divide %13, %25 : tensor<128xf32>
    %27 = stablehlo.subtract %24, %26 : tensor<128xf32>
    %cst_3 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %28 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %29 = stablehlo.divide %7, %28 : tensor<128xf32>
    %30 = stablehlo.negate %29 : tensor<128xf32>
    %31 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %32 = stablehlo.multiply %31, %10 : tensor<128xf32>
    %cst_4 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %33 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %34 = stablehlo.divide %32, %33 : tensor<128xf32>
    %35 = stablehlo.add %30, %34 : tensor<128xf32>
    %36 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %37 = stablehlo.divide %11, %36 : tensor<128xf32>
    %38 = stablehlo.subtract %35, %37 : tensor<128xf32>
    %cst_5 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %39 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %40 = stablehlo.divide %12, %39 : tensor<128xf32>
    %41 = stablehlo.subtract %38, %40 : tensor<128xf32>
    %42 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %43 = stablehlo.divide %13, %42 : tensor<128xf32>
    %44 = stablehlo.add %41, %43 : tensor<128xf32>
    %45 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %46 = stablehlo.divide %7, %45 : tensor<128xf32>
    %cst_6 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %47 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %48 = stablehlo.subtract %47, %46 : tensor<128xf32>
    %cst_7 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %49 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %50 = stablehlo.multiply %49, %10 : tensor<128xf32>
    %cst_8 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %51 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %52 = stablehlo.divide %50, %51 : tensor<128xf32>
    %53 = stablehlo.subtract %48, %52 : tensor<128xf32>
    %54 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %55 = stablehlo.multiply %54, %11 : tensor<128xf32>
    %cst_9 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %56 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %57 = stablehlo.divide %55, %56 : tensor<128xf32>
    %58 = stablehlo.add %53, %57 : tensor<128xf32>
    %59 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %60 = stablehlo.divide %12, %59 : tensor<128xf32>
    %61 = stablehlo.add %58, %60 : tensor<128xf32>
    %62 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %63 = stablehlo.divide %13, %62 : tensor<128xf32>
    %64 = stablehlo.subtract %61, %63 : tensor<128xf32>
    %65 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %66 = stablehlo.multiply %65, %10 : tensor<128xf32>
    %67 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %68 = stablehlo.divide %66, %67 : tensor<128xf32>
    %69 = stablehlo.add %7, %68 : tensor<128xf32>
    %cst_10 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %70 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %71 = stablehlo.multiply %70, %11 : tensor<128xf32>
    %72 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %73 = stablehlo.divide %71, %72 : tensor<128xf32>
    %74 = stablehlo.subtract %69, %73 : tensor<128xf32>
    %75 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %76 = stablehlo.divide %12, %75 : tensor<128xf32>
    %77 = stablehlo.subtract %74, %76 : tensor<128xf32>
    %78 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %79 = stablehlo.divide %13, %78 : tensor<128xf32>
    %80 = stablehlo.add %77, %79 : tensor<128xf32>
    %81 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %82 = stablehlo.divide %7, %81 : tensor<128xf32>
    %83 = stablehlo.negate %82 : tensor<128xf32>
    %84 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %85 = stablehlo.divide %10, %84 : tensor<128xf32>
    %86 = stablehlo.subtract %83, %85 : tensor<128xf32>
    %87 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %88 = stablehlo.multiply %87, %11 : tensor<128xf32>
    %89 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %90 = stablehlo.divide %88, %89 : tensor<128xf32>
    %91 = stablehlo.add %86, %90 : tensor<128xf32>
    %92 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %93 = stablehlo.divide %12, %92 : tensor<128xf32>
    %94 = stablehlo.add %91, %93 : tensor<128xf32>
    %95 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %96 = stablehlo.divide %13, %95 : tensor<128xf32>
    %97 = stablehlo.subtract %94, %96 : tensor<128xf32>
    %cst_11 = stablehlo.constant dense<3.000000e+01> : tensor<f32>
    %98 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %99 = stablehlo.divide %7, %98 : tensor<128xf32>
    %100 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %101 = stablehlo.divide %11, %100 : tensor<128xf32>
    %102 = stablehlo.subtract %99, %101 : tensor<128xf32>
    %103 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %104 = stablehlo.divide %13, %103 : tensor<128xf32>
    %105 = stablehlo.add %102, %104 : tensor<128xf32>
    %106 = stablehlo.broadcast_in_dim %27, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %107 = stablehlo.broadcast_in_dim %44, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %108 = stablehlo.broadcast_in_dim %64, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %109 = stablehlo.broadcast_in_dim %80, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %110 = stablehlo.broadcast_in_dim %97, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %111 = stablehlo.broadcast_in_dim %105, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %112 = stablehlo.concatenate %106, %107, %108, %109, %110, %111, dim = 0 : (tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>) -> tensor<6x128xf32>
    %113 = stablehlo.slice %arg4 [0:1] : (tensor<6xi32>) -> tensor<1xi32>
    %114 = stablehlo.reshape %113 : (tensor<1xi32>) -> tensor<i32>
    %115 = stablehlo.broadcast_in_dim %114, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %116 = stablehlo.add %8, %115 : tensor<128xi32>
    %117 = call @_roll_dynamic(%arg0, %116) : (tensor<128x128xf32>, tensor<128xi32>) -> tensor<128x128xf32>
    %118 = stablehlo.transpose %117, dims = [1, 0] : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %119 = stablehlo.slice %112 [0:1, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %120 = stablehlo.reshape %119 : (tensor<1x128xf32>) -> tensor<128xf32>
    %121 = stablehlo.broadcast_in_dim %120, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %122 = stablehlo.broadcast_in_dim %121, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %123 = stablehlo.multiply %118, %122 : tensor<128x128xf32>
    %124 = stablehlo.add %9, %123 : tensor<128x128xf32>
    %125 = stablehlo.slice %arg4 [1:2] : (tensor<6xi32>) -> tensor<1xi32>
    %126 = stablehlo.reshape %125 : (tensor<1xi32>) -> tensor<i32>
    %127 = stablehlo.broadcast_in_dim %126, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %128 = stablehlo.add %8, %127 : tensor<128xi32>
    %129 = call @_roll_dynamic(%arg0, %128) : (tensor<128x128xf32>, tensor<128xi32>) -> tensor<128x128xf32>
    %130 = stablehlo.transpose %129, dims = [1, 0] : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %131 = stablehlo.slice %112 [1:2, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %132 = stablehlo.reshape %131 : (tensor<1x128xf32>) -> tensor<128xf32>
    %133 = stablehlo.broadcast_in_dim %132, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %134 = stablehlo.broadcast_in_dim %133, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %135 = stablehlo.multiply %130, %134 : tensor<128x128xf32>
    %136 = stablehlo.add %124, %135 : tensor<128x128xf32>
    %137 = stablehlo.slice %arg4 [2:3] : (tensor<6xi32>) -> tensor<1xi32>
    %138 = stablehlo.reshape %137 : (tensor<1xi32>) -> tensor<i32>
    %139 = stablehlo.broadcast_in_dim %138, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %140 = stablehlo.add %8, %139 : tensor<128xi32>
    %141 = call @_roll_dynamic(%arg0, %140) : (tensor<128x128xf32>, tensor<128xi32>) -> tensor<128x128xf32>
    %142 = stablehlo.transpose %141, dims = [1, 0] : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %143 = stablehlo.slice %112 [2:3, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %144 = stablehlo.reshape %143 : (tensor<1x128xf32>) -> tensor<128xf32>
    %145 = stablehlo.broadcast_in_dim %144, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %146 = stablehlo.broadcast_in_dim %145, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %147 = stablehlo.multiply %142, %146 : tensor<128x128xf32>
    %148 = stablehlo.add %136, %147 : tensor<128x128xf32>
    %149 = stablehlo.slice %arg4 [3:4] : (tensor<6xi32>) -> tensor<1xi32>
    %150 = stablehlo.reshape %149 : (tensor<1xi32>) -> tensor<i32>
    %151 = stablehlo.broadcast_in_dim %150, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %152 = stablehlo.add %8, %151 : tensor<128xi32>
    %153 = call @_roll_dynamic(%arg0, %152) : (tensor<128x128xf32>, tensor<128xi32>) -> tensor<128x128xf32>
    %154 = stablehlo.transpose %153, dims = [1, 0] : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %155 = stablehlo.slice %112 [3:4, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %156 = stablehlo.reshape %155 : (tensor<1x128xf32>) -> tensor<128xf32>
    %157 = stablehlo.broadcast_in_dim %156, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %158 = stablehlo.broadcast_in_dim %157, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %159 = stablehlo.multiply %154, %158 : tensor<128x128xf32>
    %160 = stablehlo.add %148, %159 : tensor<128x128xf32>
    %161 = stablehlo.slice %arg4 [4:5] : (tensor<6xi32>) -> tensor<1xi32>
    %162 = stablehlo.reshape %161 : (tensor<1xi32>) -> tensor<i32>
    %163 = stablehlo.broadcast_in_dim %162, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %164 = stablehlo.add %8, %163 : tensor<128xi32>
    %165 = call @_roll_dynamic(%arg0, %164) : (tensor<128x128xf32>, tensor<128xi32>) -> tensor<128x128xf32>
    %166 = stablehlo.transpose %165, dims = [1, 0] : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %167 = stablehlo.slice %112 [4:5, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %168 = stablehlo.reshape %167 : (tensor<1x128xf32>) -> tensor<128xf32>
    %169 = stablehlo.broadcast_in_dim %168, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %170 = stablehlo.broadcast_in_dim %169, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %171 = stablehlo.multiply %166, %170 : tensor<128x128xf32>
    %172 = stablehlo.add %160, %171 : tensor<128x128xf32>
    %173 = stablehlo.slice %arg4 [5:6] : (tensor<6xi32>) -> tensor<1xi32>
    %174 = stablehlo.reshape %173 : (tensor<1xi32>) -> tensor<i32>
    %175 = stablehlo.broadcast_in_dim %174, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %176 = stablehlo.add %8, %175 : tensor<128xi32>
    %177 = call @_roll_dynamic(%arg0, %176) : (tensor<128x128xf32>, tensor<128xi32>) -> tensor<128x128xf32>
    %178 = stablehlo.transpose %177, dims = [1, 0] : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %179 = stablehlo.slice %112 [5:6, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %180 = stablehlo.reshape %179 : (tensor<1x128xf32>) -> tensor<128xf32>
    %181 = stablehlo.broadcast_in_dim %180, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %182 = stablehlo.broadcast_in_dim %181, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %183 = stablehlo.multiply %178, %182 : tensor<128x128xf32>
    %184 = stablehlo.add %172, %183 : tensor<128x128xf32>
    return %184 : tensor<128x128xf32>
  }
  func.func private @_roll_dynamic(%arg0: tensor<128x128xf32>, %arg1: tensor<128xi32>) -> tensor<128x128xf32> {
    %0 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<128xi32>) -> tensor<128x1xi32>
    %1 = stablehlo.slice %0 [0:128, 0:1] : (tensor<128x1xi32>) -> tensor<128x1xi32>
    %2 = stablehlo.reshape %1 : (tensor<128x1xi32>) -> tensor<128xi32>
    %c = stablehlo.constant dense<128> : tensor<i32>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %3 = stablehlo.maximum %c, %c_0 : tensor<i32>
    %4 = call @remainder(%2, %3) : (tensor<128xi32>, tensor<i32>) -> tensor<128xi32>
    %5 = stablehlo.transpose %arg0, dims = [1, 0] : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %6 = stablehlo.transpose %arg0, dims = [1, 0] : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %7 = stablehlo.concatenate %5, %6, dim = 1 : (tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x256xf32>
    %8 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %9 = stablehlo.subtract %8, %4 : tensor<128xi32>
    %c_1 = stablehlo.constant dense<0> : tensor<i32>
    %10 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %11 = stablehlo.compare  LT, %9, %10,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %c_2 = stablehlo.constant dense<256> : tensor<i32>
    %12 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %13 = stablehlo.add %9, %12 : tensor<128xi32>
    %14 = stablehlo.select %11, %13, %9 : tensor<128xi1>, tensor<128xi32>
    %15 = stablehlo.broadcast_in_dim %14, dims = [0] : (tensor<128xi32>) -> tensor<128x1xi32>
    %16 = "stablehlo.gather"(%7, %15) <{dimension_numbers = #stablehlo.gather<offset_dims = [1], operand_batching_dims = [0], start_indices_batching_dims = [0], start_index_map = [1], index_vector_dim = 1>, indices_are_sorted = true, slice_sizes = array<i64: 1, 128>}> : (tensor<128x256xf32>, tensor<128x1xi32>) -> tensor<128x128xf32>
    return %16 : tensor<128x128xf32>
  }
  func.func private @remainder(%arg0: tensor<128xi32>, %arg1: tensor<i32>) -> tensor<128xi32> {
    %c = stablehlo.constant dense<0> : tensor<i32>
    %0 = stablehlo.compare  EQ, %arg1, %c,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %1 = call @_where(%0, %c_0, %arg1) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
    %2 = stablehlo.broadcast_in_dim %1, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %3 = stablehlo.remainder %arg0, %2 : tensor<128xi32>
    %4 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %5 = stablehlo.compare  NE, %3, %4,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %6 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %7 = stablehlo.compare  LT, %3, %6,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %8 = stablehlo.compare  LT, %1, %c,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %9 = stablehlo.broadcast_in_dim %8, dims = [] : (tensor<i1>) -> tensor<128xi1>
    %10 = stablehlo.compare  NE, %7, %9,  UNSIGNED : (tensor<128xi1>, tensor<128xi1>) -> tensor<128xi1>
    %11 = stablehlo.and %10, %5 : tensor<128xi1>
    %12 = stablehlo.broadcast_in_dim %1, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %13 = stablehlo.add %3, %12 : tensor<128xi32>
    %14 = stablehlo.select %11, %13, %3 : tensor<128xi1>, tensor<128xi32>
    return %14 : tensor<128xi32>
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
    %11 = call @fft_0(%10) : (tensor<65xcomplex<f32>>) -> tensor<128xf32>
    %12 = stablehlo.multiply %arg1, %arg1 : tensor<65xf32>
    %13 = stablehlo.convert %12 : (tensor<65xf32>) -> tensor<65xcomplex<f32>>
    %14 = stablehlo.multiply %6, %13 : tensor<65xcomplex<f32>>
    %15 = call @fft_0(%14) : (tensor<65xcomplex<f32>>) -> tensor<128xf32>
    return %11, %5, %15 : tensor<128xf32>, tensor<128xf32>, tensor<128xf32>
  }
  func.func private @fft(%arg0: tensor<128xf32>) -> tensor<65xcomplex<f32>> {
    %0 = stablehlo.fft %arg0, type =  RFFT, length = [128] : (tensor<128xf32>) -> tensor<65xcomplex<f32>>
    return %0 : tensor<65xcomplex<f32>>
  }
  func.func private @fft_0(%arg0: tensor<65xcomplex<f32>>) -> tensor<128xf32> {
    %0 = stablehlo.fft %arg0, type =  IRFFT, length = [128] : (tensor<65xcomplex<f32>>) -> tensor<128xf32>
    return %0 : tensor<128xf32>
  }
  func.func private @advect_1d_matrix_diag_1(%arg0: tensor<128x128xf32>, %arg1: tensor<128xf32>, %arg2: tensor<f32>, %arg3: tensor<f32>, %arg4: tensor<6xi32>) -> tensor<128x128xf32> {
    %0 = stablehlo.convert %arg2 : tensor<f32>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %2 = stablehlo.multiply %arg1, %1 : tensor<128xf32>
    %3 = stablehlo.convert %arg3 : tensor<f32>
    %4 = stablehlo.broadcast_in_dim %3, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %5 = stablehlo.divide %2, %4 : tensor<128xf32>
    %6 = stablehlo.floor %5 : tensor<128xf32>
    %7 = stablehlo.subtract %5, %6 : tensor<128xf32>
    %8 = stablehlo.convert %6 : (tensor<128xf32>) -> tensor<128xi32>
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %9 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %10 = call @build_v_diag_weights(%arg4, %8, %7) : (tensor<6xi32>, tensor<128xi32>, tensor<128xf32>) -> tensor<6x128x128xf32>
    %11 = stablehlo.slice %arg4 [0:1] : (tensor<6xi32>) -> tensor<1xi32>
    %12 = stablehlo.reshape %11 : (tensor<1xi32>) -> tensor<i32>
    %13 = stablehlo.broadcast_in_dim %12, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %14 = stablehlo.add %8, %13 : tensor<128xi32>
    %15 = call @_roll_dynamic_3(%arg0, %14) : (tensor<128x128xf32>, tensor<128xi32>) -> tensor<128x128xf32>
    %16 = stablehlo.slice %10 [0:1, 0:128, 0:128] : (tensor<6x128x128xf32>) -> tensor<1x128x128xf32>
    %17 = stablehlo.reshape %16 : (tensor<1x128x128xf32>) -> tensor<128x128xf32>
    %18 = stablehlo.multiply %17, %15 : tensor<128x128xf32>
    %19 = stablehlo.add %9, %18 : tensor<128x128xf32>
    %20 = stablehlo.slice %arg4 [1:2] : (tensor<6xi32>) -> tensor<1xi32>
    %21 = stablehlo.reshape %20 : (tensor<1xi32>) -> tensor<i32>
    %22 = stablehlo.broadcast_in_dim %21, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %23 = stablehlo.add %8, %22 : tensor<128xi32>
    %24 = call @_roll_dynamic_3(%arg0, %23) : (tensor<128x128xf32>, tensor<128xi32>) -> tensor<128x128xf32>
    %25 = stablehlo.slice %10 [1:2, 0:128, 0:128] : (tensor<6x128x128xf32>) -> tensor<1x128x128xf32>
    %26 = stablehlo.reshape %25 : (tensor<1x128x128xf32>) -> tensor<128x128xf32>
    %27 = stablehlo.multiply %26, %24 : tensor<128x128xf32>
    %28 = stablehlo.add %19, %27 : tensor<128x128xf32>
    %29 = stablehlo.slice %arg4 [2:3] : (tensor<6xi32>) -> tensor<1xi32>
    %30 = stablehlo.reshape %29 : (tensor<1xi32>) -> tensor<i32>
    %31 = stablehlo.broadcast_in_dim %30, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %32 = stablehlo.add %8, %31 : tensor<128xi32>
    %33 = call @_roll_dynamic_3(%arg0, %32) : (tensor<128x128xf32>, tensor<128xi32>) -> tensor<128x128xf32>
    %34 = stablehlo.slice %10 [2:3, 0:128, 0:128] : (tensor<6x128x128xf32>) -> tensor<1x128x128xf32>
    %35 = stablehlo.reshape %34 : (tensor<1x128x128xf32>) -> tensor<128x128xf32>
    %36 = stablehlo.multiply %35, %33 : tensor<128x128xf32>
    %37 = stablehlo.add %28, %36 : tensor<128x128xf32>
    %38 = stablehlo.slice %arg4 [3:4] : (tensor<6xi32>) -> tensor<1xi32>
    %39 = stablehlo.reshape %38 : (tensor<1xi32>) -> tensor<i32>
    %40 = stablehlo.broadcast_in_dim %39, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %41 = stablehlo.add %8, %40 : tensor<128xi32>
    %42 = call @_roll_dynamic_3(%arg0, %41) : (tensor<128x128xf32>, tensor<128xi32>) -> tensor<128x128xf32>
    %43 = stablehlo.slice %10 [3:4, 0:128, 0:128] : (tensor<6x128x128xf32>) -> tensor<1x128x128xf32>
    %44 = stablehlo.reshape %43 : (tensor<1x128x128xf32>) -> tensor<128x128xf32>
    %45 = stablehlo.multiply %44, %42 : tensor<128x128xf32>
    %46 = stablehlo.add %37, %45 : tensor<128x128xf32>
    %47 = stablehlo.slice %arg4 [4:5] : (tensor<6xi32>) -> tensor<1xi32>
    %48 = stablehlo.reshape %47 : (tensor<1xi32>) -> tensor<i32>
    %49 = stablehlo.broadcast_in_dim %48, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %50 = stablehlo.add %8, %49 : tensor<128xi32>
    %51 = call @_roll_dynamic_3(%arg0, %50) : (tensor<128x128xf32>, tensor<128xi32>) -> tensor<128x128xf32>
    %52 = stablehlo.slice %10 [4:5, 0:128, 0:128] : (tensor<6x128x128xf32>) -> tensor<1x128x128xf32>
    %53 = stablehlo.reshape %52 : (tensor<1x128x128xf32>) -> tensor<128x128xf32>
    %54 = stablehlo.multiply %53, %51 : tensor<128x128xf32>
    %55 = stablehlo.add %46, %54 : tensor<128x128xf32>
    %56 = stablehlo.slice %arg4 [5:6] : (tensor<6xi32>) -> tensor<1xi32>
    %57 = stablehlo.reshape %56 : (tensor<1xi32>) -> tensor<i32>
    %58 = stablehlo.broadcast_in_dim %57, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %59 = stablehlo.add %8, %58 : tensor<128xi32>
    %60 = call @_roll_dynamic_3(%arg0, %59) : (tensor<128x128xf32>, tensor<128xi32>) -> tensor<128x128xf32>
    %61 = stablehlo.slice %10 [5:6, 0:128, 0:128] : (tensor<6x128x128xf32>) -> tensor<1x128x128xf32>
    %62 = stablehlo.reshape %61 : (tensor<1x128x128xf32>) -> tensor<128x128xf32>
    %63 = stablehlo.multiply %62, %60 : tensor<128x128xf32>
    %64 = stablehlo.add %55, %63 : tensor<128x128xf32>
    return %64 : tensor<128x128xf32>
  }
  func.func private @build_v_diag_weights(%arg0: tensor<6xi32>, %arg1: tensor<128xi32>, %arg2: tensor<128xf32>) -> tensor<6x128x128xf32> {
    %0 = stablehlo.multiply %arg2, %arg2 : tensor<128xf32>
    %1 = stablehlo.multiply %0, %arg2 : tensor<128xf32>
    %2 = stablehlo.multiply %1, %arg2 : tensor<128xf32>
    %3 = stablehlo.multiply %2, %arg2 : tensor<128xf32>
    %cst = stablehlo.constant dense<2.000000e+01> : tensor<f32>
    %4 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %5 = stablehlo.divide %arg2, %4 : tensor<128xf32>
    %cst_0 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %6 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %7 = stablehlo.divide %0, %6 : tensor<128xf32>
    %8 = stablehlo.subtract %5, %7 : tensor<128xf32>
    %9 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %10 = stablehlo.divide %1, %9 : tensor<128xf32>
    %11 = stablehlo.subtract %8, %10 : tensor<128xf32>
    %12 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %13 = stablehlo.divide %2, %12 : tensor<128xf32>
    %14 = stablehlo.add %11, %13 : tensor<128xf32>
    %cst_1 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %15 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %16 = stablehlo.divide %3, %15 : tensor<128xf32>
    %17 = stablehlo.subtract %14, %16 : tensor<128xf32>
    %cst_2 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %18 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %19 = stablehlo.divide %arg2, %18 : tensor<128xf32>
    %20 = stablehlo.negate %19 : tensor<128xf32>
    %21 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %22 = stablehlo.multiply %21, %0 : tensor<128xf32>
    %cst_3 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %23 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %24 = stablehlo.divide %22, %23 : tensor<128xf32>
    %25 = stablehlo.add %20, %24 : tensor<128xf32>
    %26 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %27 = stablehlo.divide %1, %26 : tensor<128xf32>
    %28 = stablehlo.subtract %25, %27 : tensor<128xf32>
    %cst_4 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %29 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %30 = stablehlo.divide %2, %29 : tensor<128xf32>
    %31 = stablehlo.subtract %28, %30 : tensor<128xf32>
    %32 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %33 = stablehlo.divide %3, %32 : tensor<128xf32>
    %34 = stablehlo.add %31, %33 : tensor<128xf32>
    %35 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %36 = stablehlo.divide %arg2, %35 : tensor<128xf32>
    %cst_5 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %37 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %38 = stablehlo.subtract %37, %36 : tensor<128xf32>
    %cst_6 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %39 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %40 = stablehlo.multiply %39, %0 : tensor<128xf32>
    %cst_7 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %41 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %42 = stablehlo.divide %40, %41 : tensor<128xf32>
    %43 = stablehlo.subtract %38, %42 : tensor<128xf32>
    %44 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %45 = stablehlo.multiply %44, %1 : tensor<128xf32>
    %cst_8 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %46 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %47 = stablehlo.divide %45, %46 : tensor<128xf32>
    %48 = stablehlo.add %43, %47 : tensor<128xf32>
    %49 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %50 = stablehlo.divide %2, %49 : tensor<128xf32>
    %51 = stablehlo.add %48, %50 : tensor<128xf32>
    %52 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %53 = stablehlo.divide %3, %52 : tensor<128xf32>
    %54 = stablehlo.subtract %51, %53 : tensor<128xf32>
    %55 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %56 = stablehlo.multiply %55, %0 : tensor<128xf32>
    %57 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %58 = stablehlo.divide %56, %57 : tensor<128xf32>
    %59 = stablehlo.add %arg2, %58 : tensor<128xf32>
    %cst_9 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %60 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %61 = stablehlo.multiply %60, %1 : tensor<128xf32>
    %62 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %63 = stablehlo.divide %61, %62 : tensor<128xf32>
    %64 = stablehlo.subtract %59, %63 : tensor<128xf32>
    %65 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %66 = stablehlo.divide %2, %65 : tensor<128xf32>
    %67 = stablehlo.subtract %64, %66 : tensor<128xf32>
    %68 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %69 = stablehlo.divide %3, %68 : tensor<128xf32>
    %70 = stablehlo.add %67, %69 : tensor<128xf32>
    %71 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %72 = stablehlo.divide %arg2, %71 : tensor<128xf32>
    %73 = stablehlo.negate %72 : tensor<128xf32>
    %74 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %75 = stablehlo.divide %0, %74 : tensor<128xf32>
    %76 = stablehlo.subtract %73, %75 : tensor<128xf32>
    %77 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %78 = stablehlo.multiply %77, %1 : tensor<128xf32>
    %79 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %80 = stablehlo.divide %78, %79 : tensor<128xf32>
    %81 = stablehlo.add %76, %80 : tensor<128xf32>
    %82 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %83 = stablehlo.divide %2, %82 : tensor<128xf32>
    %84 = stablehlo.add %81, %83 : tensor<128xf32>
    %85 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %86 = stablehlo.divide %3, %85 : tensor<128xf32>
    %87 = stablehlo.subtract %84, %86 : tensor<128xf32>
    %cst_10 = stablehlo.constant dense<3.000000e+01> : tensor<f32>
    %88 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %89 = stablehlo.divide %arg2, %88 : tensor<128xf32>
    %90 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %91 = stablehlo.divide %1, %90 : tensor<128xf32>
    %92 = stablehlo.subtract %89, %91 : tensor<128xf32>
    %93 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %94 = stablehlo.divide %3, %93 : tensor<128xf32>
    %95 = stablehlo.add %92, %94 : tensor<128xf32>
    %96 = stablehlo.broadcast_in_dim %17, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %97 = stablehlo.broadcast_in_dim %34, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %98 = stablehlo.broadcast_in_dim %54, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %99 = stablehlo.broadcast_in_dim %70, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %100 = stablehlo.broadcast_in_dim %87, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %101 = stablehlo.broadcast_in_dim %95, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %102 = stablehlo.concatenate %96, %97, %98, %99, %100, %101, dim = 0 : (tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>) -> tensor<6x128xf32>
    %103 = stablehlo.iota dim = 0 : tensor<128xi32>
    %104 = stablehlo.broadcast_in_dim %arg0, dims = [0] : (tensor<6xi32>) -> tensor<6x1xi32>
    %105 = stablehlo.broadcast_in_dim %arg1, dims = [1] : (tensor<128xi32>) -> tensor<1x128xi32>
    %106 = stablehlo.broadcast_in_dim %104, dims = [0, 1] : (tensor<6x1xi32>) -> tensor<6x128xi32>
    %107 = stablehlo.broadcast_in_dim %105, dims = [0, 1] : (tensor<1x128xi32>) -> tensor<6x128xi32>
    %108 = stablehlo.add %106, %107 : tensor<6x128xi32>
    %109 = stablehlo.broadcast_in_dim %103, dims = [2] : (tensor<128xi32>) -> tensor<1x1x128xi32>
    %110 = stablehlo.broadcast_in_dim %108, dims = [0, 1] : (tensor<6x128xi32>) -> tensor<6x128x1xi32>
    %111 = stablehlo.broadcast_in_dim %109, dims = [0, 1, 2] : (tensor<1x1x128xi32>) -> tensor<6x128x128xi32>
    %112 = stablehlo.broadcast_in_dim %110, dims = [0, 1, 2] : (tensor<6x128x1xi32>) -> tensor<6x128x128xi32>
    %113 = stablehlo.subtract %111, %112 : tensor<6x128x128xi32>
    %c = stablehlo.constant dense<0> : tensor<i32>
    %114 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<6x128x128xi32>
    %115 = stablehlo.compare  GE, %113, %114,  SIGNED : (tensor<6x128x128xi32>, tensor<6x128x128xi32>) -> tensor<6x128x128xi1>
    %c_11 = stablehlo.constant dense<128> : tensor<i32>
    %116 = stablehlo.broadcast_in_dim %c_11, dims = [] : (tensor<i32>) -> tensor<6x128x128xi32>
    %117 = stablehlo.compare  LT, %113, %116,  SIGNED : (tensor<6x128x128xi32>, tensor<6x128x128xi32>) -> tensor<6x128x128xi1>
    %118 = stablehlo.and %115, %117 : tensor<6x128x128xi1>
    %119 = stablehlo.broadcast_in_dim %102, dims = [0, 1] : (tensor<6x128xf32>) -> tensor<6x128x1xf32>
    %cst_12 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %120 = call @_where_2(%118, %119, %cst_12) : (tensor<6x128x128xi1>, tensor<6x128x1xf32>, tensor<f32>) -> tensor<6x128x128xf32>
    return %120 : tensor<6x128x128xf32>
  }
  func.func private @_where_2(%arg0: tensor<6x128x128xi1>, %arg1: tensor<6x128x1xf32>, %arg2: tensor<f32>) -> tensor<6x128x128xf32> {
    %0 = stablehlo.convert %arg2 : tensor<f32>
    %1 = stablehlo.broadcast_in_dim %arg1, dims = [0, 1, 2] : (tensor<6x128x1xf32>) -> tensor<6x128x128xf32>
    %2 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f32>) -> tensor<6x128x128xf32>
    %3 = stablehlo.select %arg0, %1, %2 : tensor<6x128x128xi1>, tensor<6x128x128xf32>
    return %3 : tensor<6x128x128xf32>
  }
  func.func private @_roll_dynamic_3(%arg0: tensor<128x128xf32>, %arg1: tensor<128xi32>) -> tensor<128x128xf32> {
    %0 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<128xi32>) -> tensor<128x1xi32>
    %1 = stablehlo.slice %0 [0:128, 0:1] : (tensor<128x1xi32>) -> tensor<128x1xi32>
    %2 = stablehlo.reshape %1 : (tensor<128x1xi32>) -> tensor<128xi32>
    %c = stablehlo.constant dense<128> : tensor<i32>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %3 = stablehlo.maximum %c, %c_0 : tensor<i32>
    %4 = call @remainder(%2, %3) : (tensor<128xi32>, tensor<i32>) -> tensor<128xi32>
    %5 = stablehlo.concatenate %arg0, %arg0, dim = 1 : (tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x256xf32>
    %6 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %7 = stablehlo.subtract %6, %4 : tensor<128xi32>
    %c_1 = stablehlo.constant dense<0> : tensor<i32>
    %8 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %9 = stablehlo.compare  LT, %7, %8,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %c_2 = stablehlo.constant dense<256> : tensor<i32>
    %10 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %11 = stablehlo.add %7, %10 : tensor<128xi32>
    %12 = stablehlo.select %9, %11, %7 : tensor<128xi1>, tensor<128xi32>
    %13 = stablehlo.broadcast_in_dim %12, dims = [0] : (tensor<128xi32>) -> tensor<128x1xi32>
    %14 = "stablehlo.gather"(%5, %13) <{dimension_numbers = #stablehlo.gather<offset_dims = [1], operand_batching_dims = [0], start_indices_batching_dims = [0], start_index_map = [1], index_vector_dim = 1>, indices_are_sorted = true, slice_sizes = array<i64: 1, 128>}> : (tensor<128x256xf32>, tensor<128x1xi32>) -> tensor<128x128xf32>
    return %14 : tensor<128x128xf32>
  }
}
