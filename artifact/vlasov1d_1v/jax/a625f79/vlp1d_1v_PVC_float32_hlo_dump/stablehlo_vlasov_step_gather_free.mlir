module @jit__lambda_ attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<128x128xf32>) -> (tensor<128x128xf32> {jax.result_info = "[0]"}, tensor<128xf32> {jax.result_info = "[1]"}, tensor<128xf32> {jax.result_info = "[2]"}) {
    %cst = stablehlo.constant dense<"0xFA0C3A3F0A2F3F3F1A51443F2A73493F3A954E3F4AB7533F5AD9583F6AFB5D3F7A1D633F8A3F683F9C616D3FAC83723FBEA5773FCEC77C3F80EEF43BA07DE13CD0DF423D68808A3DF890B33D78A1DC3DFCD8023E3C61173E7CE92B3EBC71403EFCF9543E3C82693E7C0A7E3E5E49893E7E8D933E9ED19D3EBE15A83EE059B23E009EBC3E20E2C63E4026D13E606ADB3E82AEE53EA2F2EF3EC236FA3E723D023F825F073F92810C3FA2A3113FB2C5163FC4E71B3FD409213FE42B263FF44D2B3F0570303F1592353F25B43A3F35D63F3F45F8443F561A4A3F663C4F3F765E543F8680593F96A25E3FA8C4633FB8E6683FC8086E3FD82A733FE84C783FF86E7D3F0242243C0363F63C83524D3DC2B98F3D42CAB83DC3DAE13DA275053EE6FD193E26862E3E6B0E433EAC96573EEC1E6C3E9653803EB6978A3ED6DB943EF61F9F3E1664A93E36A8B33E56ECBD3E7630C83E9974D23EB9B8DC3ED9FCE63EF940F13E1C85FB3E9EE4023FAE06083FBE280D3FCE4A123FDE6C173FEE8E1C3FFEB0213F10D3263F21F52B3F3117313F4139363F515B3B3F617D403F719F453F81C14A3F91E34F3FA205553FB2275A3FC2495F3FD26B643FE38D693FF3AF6E3F03D2733F13F4783F23167E3F800C4E3C20A4053D40C5573D20F3943DA003BE3D2014E73D5812083E989A1C3ED822313E18AB453E58335A3E98BB6E3EECA1813E0CE68B3E"> : tensor<128xf32>
    %cst_0 = stablehlo.constant dense<[0.000000e+00, 2.000000e+00, 1.000000e+00, 0.666666686, 5.000000e-01, 4.000000e-01, 0.333333343, 0.285714269, 2.500000e-01, 0.222222224, 2.000000e-01, 0.181818187, 0.166666672, 0.153846174, 0.142857134, 0.133333325, 1.250000e-01, 0.117647059, 0.111111112, 0.105263159, 1.000000e-01, 0.095238097, 0.0909090936, 0.0869565159, 0.0833333358, 8.000000e-02, 0.0769230872, 0.0740740672, 0.0714285671, 0.068965517, 0.0666666627, 0.0645161271, 6.250000e-02, 0.0606060587, 0.0588235296, 0.0571428537, 0.055555556, 0.0540540516, 0.0526315793, 0.051282052, 5.000000e-02, 0.048780486, 0.0476190485, 0.0465116277, 0.0454545468, 0.0444444455, 0.043478258, 0.0425531901, 0.0416666679, 0.0408163257, 4.000000e-02, 0.0392156877, 0.0384615436, 0.0377358496, 0.0370370336, 0.0363636352, 0.0357142836, 0.0350877196, 0.0344827585, 0.0338983051, 0.0333333313, 0.0327868834, 0.0322580636, 0.0317460299, 3.125000e-02]> : tensor<65xf32>
    %0 = stablehlo.multiply %cst, %cst : tensor<128xf32>
    %1 = stablehlo.multiply %0, %cst : tensor<128xf32>
    %2 = stablehlo.multiply %1, %cst : tensor<128xf32>
    %3 = stablehlo.multiply %2, %cst : tensor<128xf32>
    %cst_1 = stablehlo.constant dense<2.000000e+01> : tensor<f32>
    %4 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %5 = stablehlo.divide %cst, %4 : tensor<128xf32>
    %cst_2 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %6 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %7 = stablehlo.divide %0, %6 : tensor<128xf32>
    %8 = stablehlo.subtract %5, %7 : tensor<128xf32>
    %9 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %10 = stablehlo.divide %1, %9 : tensor<128xf32>
    %11 = stablehlo.subtract %8, %10 : tensor<128xf32>
    %12 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %13 = stablehlo.divide %2, %12 : tensor<128xf32>
    %14 = stablehlo.add %11, %13 : tensor<128xf32>
    %cst_3 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %15 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %16 = stablehlo.divide %3, %15 : tensor<128xf32>
    %17 = stablehlo.subtract %14, %16 : tensor<128xf32>
    %cst_4 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %18 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %19 = stablehlo.divide %cst, %18 : tensor<128xf32>
    %20 = stablehlo.negate %19 : tensor<128xf32>
    %21 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %22 = stablehlo.multiply %21, %0 : tensor<128xf32>
    %cst_5 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %23 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %24 = stablehlo.divide %22, %23 : tensor<128xf32>
    %25 = stablehlo.add %20, %24 : tensor<128xf32>
    %26 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %27 = stablehlo.divide %1, %26 : tensor<128xf32>
    %28 = stablehlo.subtract %25, %27 : tensor<128xf32>
    %cst_6 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %29 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %30 = stablehlo.divide %2, %29 : tensor<128xf32>
    %31 = stablehlo.subtract %28, %30 : tensor<128xf32>
    %32 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %33 = stablehlo.divide %3, %32 : tensor<128xf32>
    %34 = stablehlo.add %31, %33 : tensor<128xf32>
    %35 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %36 = stablehlo.divide %cst, %35 : tensor<128xf32>
    %cst_7 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %37 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %38 = stablehlo.subtract %37, %36 : tensor<128xf32>
    %cst_8 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %39 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %40 = stablehlo.multiply %39, %0 : tensor<128xf32>
    %cst_9 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %41 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %42 = stablehlo.divide %40, %41 : tensor<128xf32>
    %43 = stablehlo.subtract %38, %42 : tensor<128xf32>
    %44 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %45 = stablehlo.multiply %44, %1 : tensor<128xf32>
    %cst_10 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %46 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %47 = stablehlo.divide %45, %46 : tensor<128xf32>
    %48 = stablehlo.add %43, %47 : tensor<128xf32>
    %49 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %50 = stablehlo.divide %2, %49 : tensor<128xf32>
    %51 = stablehlo.add %48, %50 : tensor<128xf32>
    %52 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %53 = stablehlo.divide %3, %52 : tensor<128xf32>
    %54 = stablehlo.subtract %51, %53 : tensor<128xf32>
    %55 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %56 = stablehlo.multiply %55, %0 : tensor<128xf32>
    %57 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %58 = stablehlo.divide %56, %57 : tensor<128xf32>
    %59 = stablehlo.add %cst, %58 : tensor<128xf32>
    %cst_11 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %60 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %61 = stablehlo.multiply %60, %1 : tensor<128xf32>
    %62 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %63 = stablehlo.divide %61, %62 : tensor<128xf32>
    %64 = stablehlo.subtract %59, %63 : tensor<128xf32>
    %65 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %66 = stablehlo.divide %2, %65 : tensor<128xf32>
    %67 = stablehlo.subtract %64, %66 : tensor<128xf32>
    %68 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %69 = stablehlo.divide %3, %68 : tensor<128xf32>
    %70 = stablehlo.add %67, %69 : tensor<128xf32>
    %71 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %72 = stablehlo.divide %cst, %71 : tensor<128xf32>
    %73 = stablehlo.negate %72 : tensor<128xf32>
    %74 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %75 = stablehlo.divide %0, %74 : tensor<128xf32>
    %76 = stablehlo.subtract %73, %75 : tensor<128xf32>
    %77 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %78 = stablehlo.multiply %77, %1 : tensor<128xf32>
    %79 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %80 = stablehlo.divide %78, %79 : tensor<128xf32>
    %81 = stablehlo.add %76, %80 : tensor<128xf32>
    %82 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %83 = stablehlo.divide %2, %82 : tensor<128xf32>
    %84 = stablehlo.add %81, %83 : tensor<128xf32>
    %85 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %86 = stablehlo.divide %3, %85 : tensor<128xf32>
    %87 = stablehlo.subtract %84, %86 : tensor<128xf32>
    %cst_12 = stablehlo.constant dense<3.000000e+01> : tensor<f32>
    %88 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %89 = stablehlo.divide %cst, %88 : tensor<128xf32>
    %90 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %91 = stablehlo.divide %1, %90 : tensor<128xf32>
    %92 = stablehlo.subtract %89, %91 : tensor<128xf32>
    %93 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %94 = stablehlo.divide %3, %93 : tensor<128xf32>
    %95 = stablehlo.add %92, %94 : tensor<128xf32>
    %96 = stablehlo.broadcast_in_dim %17, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %97 = stablehlo.broadcast_in_dim %34, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %98 = stablehlo.broadcast_in_dim %54, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %99 = stablehlo.broadcast_in_dim %70, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %100 = stablehlo.broadcast_in_dim %87, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %101 = stablehlo.broadcast_in_dim %95, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %102 = stablehlo.concatenate %96, %97, %98, %99, %100, %101, dim = 0 : (tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>) -> tensor<6x128xf32>
    %103 = stablehlo.slice %arg0 [0:128, 0:14] : (tensor<128x128xf32>) -> tensor<128x14xf32>
    %104 = call @_roll_static(%103) : (tensor<128x14xf32>) -> tensor<128x14xf32>
    %105 = stablehlo.slice %arg0 [0:128, 14:64] : (tensor<128x128xf32>) -> tensor<128x50xf32>
    %106 = call @_roll_static_0(%105) : (tensor<128x50xf32>) -> tensor<128x50xf32>
    %107 = stablehlo.slice %arg0 [0:128, 64:114] : (tensor<128x128xf32>) -> tensor<128x50xf32>
    %108 = call @_roll_static_1(%107) : (tensor<128x50xf32>) -> tensor<128x50xf32>
    %109 = stablehlo.slice %arg0 [0:128, 114:128] : (tensor<128x128xf32>) -> tensor<128x14xf32>
    %110 = call @_roll_static_2(%109) : (tensor<128x14xf32>) -> tensor<128x14xf32>
    %111 = stablehlo.concatenate %104, %106, %108, %110, dim = 1 : (tensor<128x14xf32>, tensor<128x50xf32>, tensor<128x50xf32>, tensor<128x14xf32>) -> tensor<128x128xf32>
    %cst_13 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %112 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %113 = call @_roll_static_3(%111) : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %114 = stablehlo.slice %102 [0:1, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %115 = stablehlo.reshape %114 : (tensor<1x128xf32>) -> tensor<128xf32>
    %116 = stablehlo.broadcast_in_dim %115, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %117 = stablehlo.broadcast_in_dim %116, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %118 = stablehlo.multiply %113, %117 : tensor<128x128xf32>
    %119 = stablehlo.add %112, %118 : tensor<128x128xf32>
    %120 = call @_roll_static_4(%111) : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %121 = stablehlo.slice %102 [1:2, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %122 = stablehlo.reshape %121 : (tensor<1x128xf32>) -> tensor<128xf32>
    %123 = stablehlo.broadcast_in_dim %122, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %124 = stablehlo.broadcast_in_dim %123, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %125 = stablehlo.multiply %120, %124 : tensor<128x128xf32>
    %126 = stablehlo.add %119, %125 : tensor<128x128xf32>
    %127 = call @_roll_static_5(%111) : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %128 = stablehlo.slice %102 [2:3, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %129 = stablehlo.reshape %128 : (tensor<1x128xf32>) -> tensor<128xf32>
    %130 = stablehlo.broadcast_in_dim %129, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %131 = stablehlo.broadcast_in_dim %130, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %132 = stablehlo.multiply %127, %131 : tensor<128x128xf32>
    %133 = stablehlo.add %126, %132 : tensor<128x128xf32>
    %134 = call @_roll_static_6(%111) : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %135 = stablehlo.slice %102 [3:4, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %136 = stablehlo.reshape %135 : (tensor<1x128xf32>) -> tensor<128xf32>
    %137 = stablehlo.broadcast_in_dim %136, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %138 = stablehlo.broadcast_in_dim %137, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %139 = stablehlo.multiply %134, %138 : tensor<128x128xf32>
    %140 = stablehlo.add %133, %139 : tensor<128x128xf32>
    %141 = call @_roll_static_7(%111) : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %142 = stablehlo.slice %102 [4:5, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %143 = stablehlo.reshape %142 : (tensor<1x128xf32>) -> tensor<128xf32>
    %144 = stablehlo.broadcast_in_dim %143, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %145 = stablehlo.broadcast_in_dim %144, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %146 = stablehlo.multiply %141, %145 : tensor<128x128xf32>
    %147 = stablehlo.add %140, %146 : tensor<128x128xf32>
    %148 = call @_roll_static_8(%111) : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %149 = stablehlo.slice %102 [5:6, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %150 = stablehlo.reshape %149 : (tensor<1x128xf32>) -> tensor<128xf32>
    %151 = stablehlo.broadcast_in_dim %150, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %152 = stablehlo.broadcast_in_dim %151, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %153 = stablehlo.multiply %148, %152 : tensor<128x128xf32>
    %154 = stablehlo.add %147, %153 : tensor<128x128xf32>
    %cst_14 = stablehlo.constant dense<0.0787401571> : tensor<f32>
    %155:3 = call @solve_poisson(%154, %cst_0, %cst_14) : (tensor<128x128xf32>, tensor<65xf32>, tensor<f32>) -> (tensor<128xf32>, tensor<128xf32>, tensor<128xf32>)
    %cst_15 = stablehlo.constant dense<5.000000e-02> : tensor<f32>
    %156 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %157 = stablehlo.multiply %155#0, %156 : tensor<128xf32>
    %cst_16 = stablehlo.constant dense<0.0787401571> : tensor<f32>
    %158 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %159 = stablehlo.divide %157, %158 : tensor<128xf32>
    %160 = stablehlo.floor %159 : tensor<128xf32>
    %161 = stablehlo.subtract %159, %160 : tensor<128xf32>
    %162 = stablehlo.convert %160 : (tensor<128xf32>) -> tensor<128xi32>
    %163 = stablehlo.multiply %161, %161 : tensor<128xf32>
    %164 = stablehlo.multiply %163, %161 : tensor<128xf32>
    %165 = stablehlo.multiply %164, %161 : tensor<128xf32>
    %166 = stablehlo.multiply %165, %161 : tensor<128xf32>
    %167 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %168 = stablehlo.divide %161, %167 : tensor<128xf32>
    %169 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %170 = stablehlo.divide %163, %169 : tensor<128xf32>
    %171 = stablehlo.subtract %168, %170 : tensor<128xf32>
    %172 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %173 = stablehlo.divide %164, %172 : tensor<128xf32>
    %174 = stablehlo.subtract %171, %173 : tensor<128xf32>
    %175 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %176 = stablehlo.divide %165, %175 : tensor<128xf32>
    %177 = stablehlo.add %174, %176 : tensor<128xf32>
    %178 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %179 = stablehlo.divide %166, %178 : tensor<128xf32>
    %180 = stablehlo.subtract %177, %179 : tensor<128xf32>
    %181 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %182 = stablehlo.divide %161, %181 : tensor<128xf32>
    %183 = stablehlo.negate %182 : tensor<128xf32>
    %184 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %185 = stablehlo.multiply %184, %163 : tensor<128xf32>
    %186 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %187 = stablehlo.divide %185, %186 : tensor<128xf32>
    %188 = stablehlo.add %183, %187 : tensor<128xf32>
    %189 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %190 = stablehlo.divide %164, %189 : tensor<128xf32>
    %191 = stablehlo.subtract %188, %190 : tensor<128xf32>
    %192 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %193 = stablehlo.divide %165, %192 : tensor<128xf32>
    %194 = stablehlo.subtract %191, %193 : tensor<128xf32>
    %195 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %196 = stablehlo.divide %166, %195 : tensor<128xf32>
    %197 = stablehlo.add %194, %196 : tensor<128xf32>
    %198 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %199 = stablehlo.divide %161, %198 : tensor<128xf32>
    %200 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %201 = stablehlo.subtract %200, %199 : tensor<128xf32>
    %202 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %203 = stablehlo.multiply %202, %163 : tensor<128xf32>
    %204 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %205 = stablehlo.divide %203, %204 : tensor<128xf32>
    %206 = stablehlo.subtract %201, %205 : tensor<128xf32>
    %207 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %208 = stablehlo.multiply %207, %164 : tensor<128xf32>
    %209 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %210 = stablehlo.divide %208, %209 : tensor<128xf32>
    %211 = stablehlo.add %206, %210 : tensor<128xf32>
    %212 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %213 = stablehlo.divide %165, %212 : tensor<128xf32>
    %214 = stablehlo.add %211, %213 : tensor<128xf32>
    %215 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %216 = stablehlo.divide %166, %215 : tensor<128xf32>
    %217 = stablehlo.subtract %214, %216 : tensor<128xf32>
    %218 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %219 = stablehlo.multiply %218, %163 : tensor<128xf32>
    %220 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %221 = stablehlo.divide %219, %220 : tensor<128xf32>
    %222 = stablehlo.add %161, %221 : tensor<128xf32>
    %223 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %224 = stablehlo.multiply %223, %164 : tensor<128xf32>
    %225 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %226 = stablehlo.divide %224, %225 : tensor<128xf32>
    %227 = stablehlo.subtract %222, %226 : tensor<128xf32>
    %228 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %229 = stablehlo.divide %165, %228 : tensor<128xf32>
    %230 = stablehlo.subtract %227, %229 : tensor<128xf32>
    %231 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %232 = stablehlo.divide %166, %231 : tensor<128xf32>
    %233 = stablehlo.add %230, %232 : tensor<128xf32>
    %234 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %235 = stablehlo.divide %161, %234 : tensor<128xf32>
    %236 = stablehlo.negate %235 : tensor<128xf32>
    %237 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %238 = stablehlo.divide %163, %237 : tensor<128xf32>
    %239 = stablehlo.subtract %236, %238 : tensor<128xf32>
    %240 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %241 = stablehlo.multiply %240, %164 : tensor<128xf32>
    %242 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %243 = stablehlo.divide %241, %242 : tensor<128xf32>
    %244 = stablehlo.add %239, %243 : tensor<128xf32>
    %245 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %246 = stablehlo.divide %165, %245 : tensor<128xf32>
    %247 = stablehlo.add %244, %246 : tensor<128xf32>
    %248 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %249 = stablehlo.divide %166, %248 : tensor<128xf32>
    %250 = stablehlo.subtract %247, %249 : tensor<128xf32>
    %251 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %252 = stablehlo.divide %161, %251 : tensor<128xf32>
    %253 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %254 = stablehlo.divide %164, %253 : tensor<128xf32>
    %255 = stablehlo.subtract %252, %254 : tensor<128xf32>
    %256 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %257 = stablehlo.divide %166, %256 : tensor<128xf32>
    %258 = stablehlo.add %255, %257 : tensor<128xf32>
    %259 = stablehlo.broadcast_in_dim %180, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %260 = stablehlo.broadcast_in_dim %197, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %261 = stablehlo.broadcast_in_dim %217, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %262 = stablehlo.broadcast_in_dim %233, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %263 = stablehlo.broadcast_in_dim %250, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %264 = stablehlo.broadcast_in_dim %258, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %265 = stablehlo.concatenate %259, %260, %261, %262, %263, %264, dim = 0 : (tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>) -> tensor<6x128xf32>
    %266 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %c = stablehlo.constant dense<-1> : tensor<i32>
    %267 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %268 = stablehlo.compare  EQ, %162, %267,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %269 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %270 = stablehlo.reshape %269 : (tensor<1x128xf32>) -> tensor<128xf32>
    %cst_17 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %271 = call @_where(%268, %270, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %272 = stablehlo.add %266, %271 : tensor<128xf32>
    %c_18 = stablehlo.constant dense<-2> : tensor<i32>
    %273 = stablehlo.broadcast_in_dim %c_18, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %274 = stablehlo.compare  EQ, %162, %273,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %275 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %276 = stablehlo.reshape %275 : (tensor<1x128xf32>) -> tensor<128xf32>
    %277 = call @_where(%274, %276, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %278 = stablehlo.add %272, %277 : tensor<128xf32>
    %c_19 = stablehlo.constant dense<-3> : tensor<i32>
    %279 = stablehlo.broadcast_in_dim %c_19, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %280 = stablehlo.compare  EQ, %162, %279,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %281 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %282 = stablehlo.reshape %281 : (tensor<1x128xf32>) -> tensor<128xf32>
    %283 = call @_where(%280, %282, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %284 = stablehlo.add %278, %283 : tensor<128xf32>
    %c_20 = stablehlo.constant dense<-4> : tensor<i32>
    %285 = stablehlo.broadcast_in_dim %c_20, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %286 = stablehlo.compare  EQ, %162, %285,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %287 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %288 = stablehlo.reshape %287 : (tensor<1x128xf32>) -> tensor<128xf32>
    %289 = call @_where(%286, %288, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %290 = stablehlo.add %284, %289 : tensor<128xf32>
    %c_21 = stablehlo.constant dense<-5> : tensor<i32>
    %291 = stablehlo.broadcast_in_dim %c_21, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %292 = stablehlo.compare  EQ, %162, %291,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %293 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %294 = stablehlo.reshape %293 : (tensor<1x128xf32>) -> tensor<128xf32>
    %295 = call @_where(%292, %294, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %296 = stablehlo.add %290, %295 : tensor<128xf32>
    %c_22 = stablehlo.constant dense<-6> : tensor<i32>
    %297 = stablehlo.broadcast_in_dim %c_22, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %298 = stablehlo.compare  EQ, %162, %297,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %299 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %300 = stablehlo.reshape %299 : (tensor<1x128xf32>) -> tensor<128xf32>
    %301 = call @_where(%298, %300, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %302 = stablehlo.add %296, %301 : tensor<128xf32>
    %303 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %c_23 = stablehlo.constant dense<0> : tensor<i32>
    %304 = stablehlo.broadcast_in_dim %c_23, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %305 = stablehlo.compare  EQ, %162, %304,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %306 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %307 = stablehlo.reshape %306 : (tensor<1x128xf32>) -> tensor<128xf32>
    %308 = call @_where(%305, %307, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %309 = stablehlo.add %303, %308 : tensor<128xf32>
    %310 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %311 = stablehlo.compare  EQ, %162, %310,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %312 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %313 = stablehlo.reshape %312 : (tensor<1x128xf32>) -> tensor<128xf32>
    %314 = call @_where(%311, %313, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %315 = stablehlo.add %309, %314 : tensor<128xf32>
    %316 = stablehlo.broadcast_in_dim %c_18, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %317 = stablehlo.compare  EQ, %162, %316,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %318 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %319 = stablehlo.reshape %318 : (tensor<1x128xf32>) -> tensor<128xf32>
    %320 = call @_where(%317, %319, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %321 = stablehlo.add %315, %320 : tensor<128xf32>
    %322 = stablehlo.broadcast_in_dim %c_19, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %323 = stablehlo.compare  EQ, %162, %322,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %324 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %325 = stablehlo.reshape %324 : (tensor<1x128xf32>) -> tensor<128xf32>
    %326 = call @_where(%323, %325, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %327 = stablehlo.add %321, %326 : tensor<128xf32>
    %328 = stablehlo.broadcast_in_dim %c_20, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %329 = stablehlo.compare  EQ, %162, %328,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %330 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %331 = stablehlo.reshape %330 : (tensor<1x128xf32>) -> tensor<128xf32>
    %332 = call @_where(%329, %331, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %333 = stablehlo.add %327, %332 : tensor<128xf32>
    %334 = stablehlo.broadcast_in_dim %c_21, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %335 = stablehlo.compare  EQ, %162, %334,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %336 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %337 = stablehlo.reshape %336 : (tensor<1x128xf32>) -> tensor<128xf32>
    %338 = call @_where(%335, %337, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %339 = stablehlo.add %333, %338 : tensor<128xf32>
    %340 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %c_24 = stablehlo.constant dense<1> : tensor<i32>
    %341 = stablehlo.broadcast_in_dim %c_24, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %342 = stablehlo.compare  EQ, %162, %341,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %343 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %344 = stablehlo.reshape %343 : (tensor<1x128xf32>) -> tensor<128xf32>
    %345 = call @_where(%342, %344, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %346 = stablehlo.add %340, %345 : tensor<128xf32>
    %347 = stablehlo.broadcast_in_dim %c_23, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %348 = stablehlo.compare  EQ, %162, %347,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %349 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %350 = stablehlo.reshape %349 : (tensor<1x128xf32>) -> tensor<128xf32>
    %351 = call @_where(%348, %350, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %352 = stablehlo.add %346, %351 : tensor<128xf32>
    %353 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %354 = stablehlo.compare  EQ, %162, %353,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %355 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %356 = stablehlo.reshape %355 : (tensor<1x128xf32>) -> tensor<128xf32>
    %357 = call @_where(%354, %356, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %358 = stablehlo.add %352, %357 : tensor<128xf32>
    %359 = stablehlo.broadcast_in_dim %c_18, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %360 = stablehlo.compare  EQ, %162, %359,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %361 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %362 = stablehlo.reshape %361 : (tensor<1x128xf32>) -> tensor<128xf32>
    %363 = call @_where(%360, %362, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %364 = stablehlo.add %358, %363 : tensor<128xf32>
    %365 = stablehlo.broadcast_in_dim %c_19, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %366 = stablehlo.compare  EQ, %162, %365,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %367 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %368 = stablehlo.reshape %367 : (tensor<1x128xf32>) -> tensor<128xf32>
    %369 = call @_where(%366, %368, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %370 = stablehlo.add %364, %369 : tensor<128xf32>
    %371 = stablehlo.broadcast_in_dim %c_20, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %372 = stablehlo.compare  EQ, %162, %371,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %373 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %374 = stablehlo.reshape %373 : (tensor<1x128xf32>) -> tensor<128xf32>
    %375 = call @_where(%372, %374, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %376 = stablehlo.add %370, %375 : tensor<128xf32>
    %377 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %c_25 = stablehlo.constant dense<2> : tensor<i32>
    %378 = stablehlo.broadcast_in_dim %c_25, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %379 = stablehlo.compare  EQ, %162, %378,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %380 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %381 = stablehlo.reshape %380 : (tensor<1x128xf32>) -> tensor<128xf32>
    %382 = call @_where(%379, %381, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %383 = stablehlo.add %377, %382 : tensor<128xf32>
    %384 = stablehlo.broadcast_in_dim %c_24, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %385 = stablehlo.compare  EQ, %162, %384,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %386 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %387 = stablehlo.reshape %386 : (tensor<1x128xf32>) -> tensor<128xf32>
    %388 = call @_where(%385, %387, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %389 = stablehlo.add %383, %388 : tensor<128xf32>
    %390 = stablehlo.broadcast_in_dim %c_23, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %391 = stablehlo.compare  EQ, %162, %390,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %392 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %393 = stablehlo.reshape %392 : (tensor<1x128xf32>) -> tensor<128xf32>
    %394 = call @_where(%391, %393, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %395 = stablehlo.add %389, %394 : tensor<128xf32>
    %396 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %397 = stablehlo.compare  EQ, %162, %396,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %398 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %399 = stablehlo.reshape %398 : (tensor<1x128xf32>) -> tensor<128xf32>
    %400 = call @_where(%397, %399, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %401 = stablehlo.add %395, %400 : tensor<128xf32>
    %402 = stablehlo.broadcast_in_dim %c_18, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %403 = stablehlo.compare  EQ, %162, %402,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %404 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %405 = stablehlo.reshape %404 : (tensor<1x128xf32>) -> tensor<128xf32>
    %406 = call @_where(%403, %405, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %407 = stablehlo.add %401, %406 : tensor<128xf32>
    %408 = stablehlo.broadcast_in_dim %c_19, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %409 = stablehlo.compare  EQ, %162, %408,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %410 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %411 = stablehlo.reshape %410 : (tensor<1x128xf32>) -> tensor<128xf32>
    %412 = call @_where(%409, %411, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %413 = stablehlo.add %407, %412 : tensor<128xf32>
    %414 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %c_26 = stablehlo.constant dense<3> : tensor<i32>
    %415 = stablehlo.broadcast_in_dim %c_26, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %416 = stablehlo.compare  EQ, %162, %415,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %417 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %418 = stablehlo.reshape %417 : (tensor<1x128xf32>) -> tensor<128xf32>
    %419 = call @_where(%416, %418, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %420 = stablehlo.add %414, %419 : tensor<128xf32>
    %421 = stablehlo.broadcast_in_dim %c_25, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %422 = stablehlo.compare  EQ, %162, %421,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %423 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %424 = stablehlo.reshape %423 : (tensor<1x128xf32>) -> tensor<128xf32>
    %425 = call @_where(%422, %424, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %426 = stablehlo.add %420, %425 : tensor<128xf32>
    %427 = stablehlo.broadcast_in_dim %c_24, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %428 = stablehlo.compare  EQ, %162, %427,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %429 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %430 = stablehlo.reshape %429 : (tensor<1x128xf32>) -> tensor<128xf32>
    %431 = call @_where(%428, %430, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %432 = stablehlo.add %426, %431 : tensor<128xf32>
    %433 = stablehlo.broadcast_in_dim %c_23, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %434 = stablehlo.compare  EQ, %162, %433,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %435 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %436 = stablehlo.reshape %435 : (tensor<1x128xf32>) -> tensor<128xf32>
    %437 = call @_where(%434, %436, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %438 = stablehlo.add %432, %437 : tensor<128xf32>
    %439 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %440 = stablehlo.compare  EQ, %162, %439,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %441 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %442 = stablehlo.reshape %441 : (tensor<1x128xf32>) -> tensor<128xf32>
    %443 = call @_where(%440, %442, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %444 = stablehlo.add %438, %443 : tensor<128xf32>
    %445 = stablehlo.broadcast_in_dim %c_18, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %446 = stablehlo.compare  EQ, %162, %445,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %447 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %448 = stablehlo.reshape %447 : (tensor<1x128xf32>) -> tensor<128xf32>
    %449 = call @_where(%446, %448, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %450 = stablehlo.add %444, %449 : tensor<128xf32>
    %451 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %c_27 = stablehlo.constant dense<4> : tensor<i32>
    %452 = stablehlo.broadcast_in_dim %c_27, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %453 = stablehlo.compare  EQ, %162, %452,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %454 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %455 = stablehlo.reshape %454 : (tensor<1x128xf32>) -> tensor<128xf32>
    %456 = call @_where(%453, %455, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %457 = stablehlo.add %451, %456 : tensor<128xf32>
    %458 = stablehlo.broadcast_in_dim %c_26, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %459 = stablehlo.compare  EQ, %162, %458,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %460 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %461 = stablehlo.reshape %460 : (tensor<1x128xf32>) -> tensor<128xf32>
    %462 = call @_where(%459, %461, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %463 = stablehlo.add %457, %462 : tensor<128xf32>
    %464 = stablehlo.broadcast_in_dim %c_25, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %465 = stablehlo.compare  EQ, %162, %464,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %466 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %467 = stablehlo.reshape %466 : (tensor<1x128xf32>) -> tensor<128xf32>
    %468 = call @_where(%465, %467, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %469 = stablehlo.add %463, %468 : tensor<128xf32>
    %470 = stablehlo.broadcast_in_dim %c_24, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %471 = stablehlo.compare  EQ, %162, %470,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %472 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %473 = stablehlo.reshape %472 : (tensor<1x128xf32>) -> tensor<128xf32>
    %474 = call @_where(%471, %473, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %475 = stablehlo.add %469, %474 : tensor<128xf32>
    %476 = stablehlo.broadcast_in_dim %c_23, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %477 = stablehlo.compare  EQ, %162, %476,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %478 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %479 = stablehlo.reshape %478 : (tensor<1x128xf32>) -> tensor<128xf32>
    %480 = call @_where(%477, %479, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %481 = stablehlo.add %475, %480 : tensor<128xf32>
    %482 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %483 = stablehlo.compare  EQ, %162, %482,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %484 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %485 = stablehlo.reshape %484 : (tensor<1x128xf32>) -> tensor<128xf32>
    %486 = call @_where(%483, %485, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %487 = stablehlo.add %481, %486 : tensor<128xf32>
    %488 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %c_28 = stablehlo.constant dense<5> : tensor<i32>
    %489 = stablehlo.broadcast_in_dim %c_28, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %490 = stablehlo.compare  EQ, %162, %489,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %491 = stablehlo.slice %265 [0:1, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %492 = stablehlo.reshape %491 : (tensor<1x128xf32>) -> tensor<128xf32>
    %493 = call @_where(%490, %492, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %494 = stablehlo.add %488, %493 : tensor<128xf32>
    %495 = stablehlo.broadcast_in_dim %c_27, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %496 = stablehlo.compare  EQ, %162, %495,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %497 = stablehlo.slice %265 [1:2, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %498 = stablehlo.reshape %497 : (tensor<1x128xf32>) -> tensor<128xf32>
    %499 = call @_where(%496, %498, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %500 = stablehlo.add %494, %499 : tensor<128xf32>
    %501 = stablehlo.broadcast_in_dim %c_26, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %502 = stablehlo.compare  EQ, %162, %501,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %503 = stablehlo.slice %265 [2:3, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %504 = stablehlo.reshape %503 : (tensor<1x128xf32>) -> tensor<128xf32>
    %505 = call @_where(%502, %504, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %506 = stablehlo.add %500, %505 : tensor<128xf32>
    %507 = stablehlo.broadcast_in_dim %c_25, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %508 = stablehlo.compare  EQ, %162, %507,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %509 = stablehlo.slice %265 [3:4, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %510 = stablehlo.reshape %509 : (tensor<1x128xf32>) -> tensor<128xf32>
    %511 = call @_where(%508, %510, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %512 = stablehlo.add %506, %511 : tensor<128xf32>
    %513 = stablehlo.broadcast_in_dim %c_24, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %514 = stablehlo.compare  EQ, %162, %513,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %515 = stablehlo.slice %265 [4:5, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %516 = stablehlo.reshape %515 : (tensor<1x128xf32>) -> tensor<128xf32>
    %517 = call @_where(%514, %516, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %518 = stablehlo.add %512, %517 : tensor<128xf32>
    %519 = stablehlo.broadcast_in_dim %c_23, dims = [] : (tensor<i32>) -> tensor<128xi32>
    %520 = stablehlo.compare  EQ, %162, %519,  SIGNED : (tensor<128xi32>, tensor<128xi32>) -> tensor<128xi1>
    %521 = stablehlo.slice %265 [5:6, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %522 = stablehlo.reshape %521 : (tensor<1x128xf32>) -> tensor<128xf32>
    %523 = call @_where(%520, %522, %cst_17) : (tensor<128xi1>, tensor<128xf32>, tensor<f32>) -> tensor<128xf32>
    %524 = stablehlo.add %518, %523 : tensor<128xf32>
    %525 = stablehlo.broadcast_in_dim %302, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %526 = stablehlo.broadcast_in_dim %339, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %527 = stablehlo.broadcast_in_dim %376, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %528 = stablehlo.broadcast_in_dim %413, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %529 = stablehlo.broadcast_in_dim %450, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %530 = stablehlo.broadcast_in_dim %487, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %531 = stablehlo.broadcast_in_dim %524, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %532 = stablehlo.concatenate %525, %526, %527, %528, %529, %530, %531, dim = 0 : (tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>, tensor<1x128xf32>) -> tensor<7x128xf32>
    %c_29 = stablehlo.constant dense<0> : tensor<i32>
    %533 = call @_pad(%154, %c_29) : (tensor<128x128xf32>, tensor<i32>) -> tensor<128x134xf32>
    %534 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %535 = stablehlo.slice %532 [0:1, 0:128] : (tensor<7x128xf32>) -> tensor<1x128xf32>
    %536 = stablehlo.reshape %535 : (tensor<1x128xf32>) -> tensor<128xf32>
    %537 = stablehlo.broadcast_in_dim %536, dims = [0] : (tensor<128xf32>) -> tensor<128x1xf32>
    %538 = stablehlo.slice %533 [0:128, 6:134] : (tensor<128x134xf32>) -> tensor<128x128xf32>
    %539 = stablehlo.broadcast_in_dim %537, dims = [0, 1] : (tensor<128x1xf32>) -> tensor<128x128xf32>
    %540 = stablehlo.multiply %539, %538 : tensor<128x128xf32>
    %541 = stablehlo.add %534, %540 : tensor<128x128xf32>
    %542 = stablehlo.slice %532 [1:2, 0:128] : (tensor<7x128xf32>) -> tensor<1x128xf32>
    %543 = stablehlo.reshape %542 : (tensor<1x128xf32>) -> tensor<128xf32>
    %544 = stablehlo.broadcast_in_dim %543, dims = [0] : (tensor<128xf32>) -> tensor<128x1xf32>
    %545 = stablehlo.slice %533 [0:128, 5:133] : (tensor<128x134xf32>) -> tensor<128x128xf32>
    %546 = stablehlo.broadcast_in_dim %544, dims = [0, 1] : (tensor<128x1xf32>) -> tensor<128x128xf32>
    %547 = stablehlo.multiply %546, %545 : tensor<128x128xf32>
    %548 = stablehlo.add %541, %547 : tensor<128x128xf32>
    %549 = stablehlo.slice %532 [2:3, 0:128] : (tensor<7x128xf32>) -> tensor<1x128xf32>
    %550 = stablehlo.reshape %549 : (tensor<1x128xf32>) -> tensor<128xf32>
    %551 = stablehlo.broadcast_in_dim %550, dims = [0] : (tensor<128xf32>) -> tensor<128x1xf32>
    %552 = stablehlo.slice %533 [0:128, 4:132] : (tensor<128x134xf32>) -> tensor<128x128xf32>
    %553 = stablehlo.broadcast_in_dim %551, dims = [0, 1] : (tensor<128x1xf32>) -> tensor<128x128xf32>
    %554 = stablehlo.multiply %553, %552 : tensor<128x128xf32>
    %555 = stablehlo.add %548, %554 : tensor<128x128xf32>
    %556 = stablehlo.slice %532 [3:4, 0:128] : (tensor<7x128xf32>) -> tensor<1x128xf32>
    %557 = stablehlo.reshape %556 : (tensor<1x128xf32>) -> tensor<128xf32>
    %558 = stablehlo.broadcast_in_dim %557, dims = [0] : (tensor<128xf32>) -> tensor<128x1xf32>
    %559 = stablehlo.slice %533 [0:128, 3:131] : (tensor<128x134xf32>) -> tensor<128x128xf32>
    %560 = stablehlo.broadcast_in_dim %558, dims = [0, 1] : (tensor<128x1xf32>) -> tensor<128x128xf32>
    %561 = stablehlo.multiply %560, %559 : tensor<128x128xf32>
    %562 = stablehlo.add %555, %561 : tensor<128x128xf32>
    %563 = stablehlo.slice %532 [4:5, 0:128] : (tensor<7x128xf32>) -> tensor<1x128xf32>
    %564 = stablehlo.reshape %563 : (tensor<1x128xf32>) -> tensor<128xf32>
    %565 = stablehlo.broadcast_in_dim %564, dims = [0] : (tensor<128xf32>) -> tensor<128x1xf32>
    %566 = stablehlo.slice %533 [0:128, 2:130] : (tensor<128x134xf32>) -> tensor<128x128xf32>
    %567 = stablehlo.broadcast_in_dim %565, dims = [0, 1] : (tensor<128x1xf32>) -> tensor<128x128xf32>
    %568 = stablehlo.multiply %567, %566 : tensor<128x128xf32>
    %569 = stablehlo.add %562, %568 : tensor<128x128xf32>
    %570 = stablehlo.slice %532 [5:6, 0:128] : (tensor<7x128xf32>) -> tensor<1x128xf32>
    %571 = stablehlo.reshape %570 : (tensor<1x128xf32>) -> tensor<128xf32>
    %572 = stablehlo.broadcast_in_dim %571, dims = [0] : (tensor<128xf32>) -> tensor<128x1xf32>
    %573 = stablehlo.slice %533 [0:128, 1:129] : (tensor<128x134xf32>) -> tensor<128x128xf32>
    %574 = stablehlo.broadcast_in_dim %572, dims = [0, 1] : (tensor<128x1xf32>) -> tensor<128x128xf32>
    %575 = stablehlo.multiply %574, %573 : tensor<128x128xf32>
    %576 = stablehlo.add %569, %575 : tensor<128x128xf32>
    %577 = stablehlo.slice %532 [6:7, 0:128] : (tensor<7x128xf32>) -> tensor<1x128xf32>
    %578 = stablehlo.reshape %577 : (tensor<1x128xf32>) -> tensor<128xf32>
    %579 = stablehlo.broadcast_in_dim %578, dims = [0] : (tensor<128xf32>) -> tensor<128x1xf32>
    %580 = stablehlo.slice %533 [0:128, 0:128] : (tensor<128x134xf32>) -> tensor<128x128xf32>
    %581 = stablehlo.broadcast_in_dim %579, dims = [0, 1] : (tensor<128x1xf32>) -> tensor<128x128xf32>
    %582 = stablehlo.multiply %581, %580 : tensor<128x128xf32>
    %583 = stablehlo.add %576, %582 : tensor<128x128xf32>
    %584 = stablehlo.slice %583 [0:128, 0:14] : (tensor<128x128xf32>) -> tensor<128x14xf32>
    %585 = call @_roll_static(%584) : (tensor<128x14xf32>) -> tensor<128x14xf32>
    %586 = stablehlo.slice %583 [0:128, 14:64] : (tensor<128x128xf32>) -> tensor<128x50xf32>
    %587 = call @_roll_static_0(%586) : (tensor<128x50xf32>) -> tensor<128x50xf32>
    %588 = stablehlo.slice %583 [0:128, 64:114] : (tensor<128x128xf32>) -> tensor<128x50xf32>
    %589 = call @_roll_static_1(%588) : (tensor<128x50xf32>) -> tensor<128x50xf32>
    %590 = stablehlo.slice %583 [0:128, 114:128] : (tensor<128x128xf32>) -> tensor<128x14xf32>
    %591 = call @_roll_static_2(%590) : (tensor<128x14xf32>) -> tensor<128x14xf32>
    %592 = stablehlo.concatenate %585, %587, %589, %591, dim = 1 : (tensor<128x14xf32>, tensor<128x50xf32>, tensor<128x50xf32>, tensor<128x14xf32>) -> tensor<128x128xf32>
    %593 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<128x128xf32>
    %594 = call @_roll_static_3(%592) : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %595 = stablehlo.slice %102 [0:1, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %596 = stablehlo.reshape %595 : (tensor<1x128xf32>) -> tensor<128xf32>
    %597 = stablehlo.broadcast_in_dim %596, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %598 = stablehlo.broadcast_in_dim %597, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %599 = stablehlo.multiply %594, %598 : tensor<128x128xf32>
    %600 = stablehlo.add %593, %599 : tensor<128x128xf32>
    %601 = call @_roll_static_4(%592) : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %602 = stablehlo.slice %102 [1:2, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %603 = stablehlo.reshape %602 : (tensor<1x128xf32>) -> tensor<128xf32>
    %604 = stablehlo.broadcast_in_dim %603, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %605 = stablehlo.broadcast_in_dim %604, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %606 = stablehlo.multiply %601, %605 : tensor<128x128xf32>
    %607 = stablehlo.add %600, %606 : tensor<128x128xf32>
    %608 = call @_roll_static_5(%592) : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %609 = stablehlo.slice %102 [2:3, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %610 = stablehlo.reshape %609 : (tensor<1x128xf32>) -> tensor<128xf32>
    %611 = stablehlo.broadcast_in_dim %610, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %612 = stablehlo.broadcast_in_dim %611, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %613 = stablehlo.multiply %608, %612 : tensor<128x128xf32>
    %614 = stablehlo.add %607, %613 : tensor<128x128xf32>
    %615 = call @_roll_static_6(%592) : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %616 = stablehlo.slice %102 [3:4, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %617 = stablehlo.reshape %616 : (tensor<1x128xf32>) -> tensor<128xf32>
    %618 = stablehlo.broadcast_in_dim %617, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %619 = stablehlo.broadcast_in_dim %618, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %620 = stablehlo.multiply %615, %619 : tensor<128x128xf32>
    %621 = stablehlo.add %614, %620 : tensor<128x128xf32>
    %622 = call @_roll_static_7(%592) : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %623 = stablehlo.slice %102 [4:5, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %624 = stablehlo.reshape %623 : (tensor<1x128xf32>) -> tensor<128xf32>
    %625 = stablehlo.broadcast_in_dim %624, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %626 = stablehlo.broadcast_in_dim %625, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %627 = stablehlo.multiply %622, %626 : tensor<128x128xf32>
    %628 = stablehlo.add %621, %627 : tensor<128x128xf32>
    %629 = call @_roll_static_8(%592) : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %630 = stablehlo.slice %102 [5:6, 0:128] : (tensor<6x128xf32>) -> tensor<1x128xf32>
    %631 = stablehlo.reshape %630 : (tensor<1x128xf32>) -> tensor<128xf32>
    %632 = stablehlo.broadcast_in_dim %631, dims = [1] : (tensor<128xf32>) -> tensor<1x128xf32>
    %633 = stablehlo.broadcast_in_dim %632, dims = [0, 1] : (tensor<1x128xf32>) -> tensor<128x128xf32>
    %634 = stablehlo.multiply %629, %633 : tensor<128x128xf32>
    %635 = stablehlo.add %628, %634 : tensor<128x128xf32>
    return %635, %155#1, %155#2 : tensor<128x128xf32>, tensor<128xf32>, tensor<128xf32>
  }
  func.func private @_roll_static(%arg0: tensor<128x14xf32>) -> tensor<128x14xf32> {
    %0 = stablehlo.slice %arg0 [2:128, 0:14] : (tensor<128x14xf32>) -> tensor<126x14xf32>
    %1 = stablehlo.slice %arg0 [0:2, 0:14] : (tensor<128x14xf32>) -> tensor<2x14xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<126x14xf32>, tensor<2x14xf32>) -> tensor<128x14xf32>
    return %2 : tensor<128x14xf32>
  }
  func.func private @_roll_static_0(%arg0: tensor<128x50xf32>) -> tensor<128x50xf32> {
    %0 = stablehlo.slice %arg0 [1:128, 0:50] : (tensor<128x50xf32>) -> tensor<127x50xf32>
    %1 = stablehlo.slice %arg0 [0:1, 0:50] : (tensor<128x50xf32>) -> tensor<1x50xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<127x50xf32>, tensor<1x50xf32>) -> tensor<128x50xf32>
    return %2 : tensor<128x50xf32>
  }
  func.func private @_roll_static_1(%arg0: tensor<128x50xf32>) -> tensor<128x50xf32> {
    %0 = stablehlo.slice %arg0 [0:128, 0:50] : (tensor<128x50xf32>) -> tensor<128x50xf32>
    %1 = stablehlo.slice %arg0 [0:0, 0:50] : (tensor<128x50xf32>) -> tensor<0x50xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<128x50xf32>, tensor<0x50xf32>) -> tensor<128x50xf32>
    return %2 : tensor<128x50xf32>
  }
  func.func private @_roll_static_2(%arg0: tensor<128x14xf32>) -> tensor<128x14xf32> {
    %0 = stablehlo.slice %arg0 [127:128, 0:14] : (tensor<128x14xf32>) -> tensor<1x14xf32>
    %1 = stablehlo.slice %arg0 [0:127, 0:14] : (tensor<128x14xf32>) -> tensor<127x14xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<1x14xf32>, tensor<127x14xf32>) -> tensor<128x14xf32>
    return %2 : tensor<128x14xf32>
  }
  func.func private @_roll_static_3(%arg0: tensor<128x128xf32>) -> tensor<128x128xf32> {
    %0 = stablehlo.slice %arg0 [2:128, 0:128] : (tensor<128x128xf32>) -> tensor<126x128xf32>
    %1 = stablehlo.slice %arg0 [0:2, 0:128] : (tensor<128x128xf32>) -> tensor<2x128xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<126x128xf32>, tensor<2x128xf32>) -> tensor<128x128xf32>
    return %2 : tensor<128x128xf32>
  }
  func.func private @_roll_static_4(%arg0: tensor<128x128xf32>) -> tensor<128x128xf32> {
    %0 = stablehlo.slice %arg0 [1:128, 0:128] : (tensor<128x128xf32>) -> tensor<127x128xf32>
    %1 = stablehlo.slice %arg0 [0:1, 0:128] : (tensor<128x128xf32>) -> tensor<1x128xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<127x128xf32>, tensor<1x128xf32>) -> tensor<128x128xf32>
    return %2 : tensor<128x128xf32>
  }
  func.func private @_roll_static_5(%arg0: tensor<128x128xf32>) -> tensor<128x128xf32> {
    %0 = stablehlo.slice %arg0 [0:128, 0:128] : (tensor<128x128xf32>) -> tensor<128x128xf32>
    %1 = stablehlo.slice %arg0 [0:0, 0:128] : (tensor<128x128xf32>) -> tensor<0x128xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<128x128xf32>, tensor<0x128xf32>) -> tensor<128x128xf32>
    return %2 : tensor<128x128xf32>
  }
  func.func private @_roll_static_6(%arg0: tensor<128x128xf32>) -> tensor<128x128xf32> {
    %0 = stablehlo.slice %arg0 [127:128, 0:128] : (tensor<128x128xf32>) -> tensor<1x128xf32>
    %1 = stablehlo.slice %arg0 [0:127, 0:128] : (tensor<128x128xf32>) -> tensor<127x128xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<1x128xf32>, tensor<127x128xf32>) -> tensor<128x128xf32>
    return %2 : tensor<128x128xf32>
  }
  func.func private @_roll_static_7(%arg0: tensor<128x128xf32>) -> tensor<128x128xf32> {
    %0 = stablehlo.slice %arg0 [126:128, 0:128] : (tensor<128x128xf32>) -> tensor<2x128xf32>
    %1 = stablehlo.slice %arg0 [0:126, 0:128] : (tensor<128x128xf32>) -> tensor<126x128xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<2x128xf32>, tensor<126x128xf32>) -> tensor<128x128xf32>
    return %2 : tensor<128x128xf32>
  }
  func.func private @_roll_static_8(%arg0: tensor<128x128xf32>) -> tensor<128x128xf32> {
    %0 = stablehlo.slice %arg0 [125:128, 0:128] : (tensor<128x128xf32>) -> tensor<3x128xf32>
    %1 = stablehlo.slice %arg0 [0:125, 0:128] : (tensor<128x128xf32>) -> tensor<125x128xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<3x128xf32>, tensor<125x128xf32>) -> tensor<128x128xf32>
    return %2 : tensor<128x128xf32>
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
    %11 = call @fft_9(%10) : (tensor<65xcomplex<f32>>) -> tensor<128xf32>
    %12 = stablehlo.multiply %arg1, %arg1 : tensor<65xf32>
    %13 = stablehlo.convert %12 : (tensor<65xf32>) -> tensor<65xcomplex<f32>>
    %14 = stablehlo.multiply %6, %13 : tensor<65xcomplex<f32>>
    %15 = call @fft_9(%14) : (tensor<65xcomplex<f32>>) -> tensor<128xf32>
    return %11, %5, %15 : tensor<128xf32>, tensor<128xf32>, tensor<128xf32>
  }
  func.func private @fft(%arg0: tensor<128xf32>) -> tensor<65xcomplex<f32>> {
    %0 = stablehlo.fft %arg0, type =  RFFT, length = [128] : (tensor<128xf32>) -> tensor<65xcomplex<f32>>
    return %0 : tensor<65xcomplex<f32>>
  }
  func.func private @fft_9(%arg0: tensor<65xcomplex<f32>>) -> tensor<128xf32> {
    %0 = stablehlo.fft %arg0, type =  IRFFT, length = [128] : (tensor<65xcomplex<f32>>) -> tensor<128xf32>
    return %0 : tensor<128xf32>
  }
  func.func private @_where(%arg0: tensor<128xi1>, %arg1: tensor<128xf32>, %arg2: tensor<f32>) -> tensor<128xf32> {
    %0 = stablehlo.convert %arg2 : tensor<f32>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f32>) -> tensor<128xf32>
    %2 = stablehlo.select %arg0, %arg1, %1 : tensor<128xi1>, tensor<128xf32>
    return %2 : tensor<128xf32>
  }
  func.func private @_pad(%arg0: tensor<128x128xf32>, %arg1: tensor<i32>) -> tensor<128x134xf32> {
    %0 = stablehlo.convert %arg1 : (tensor<i32>) -> tensor<f32>
    %1 = stablehlo.pad %arg0, %0, low = [0, 3], high = [0, 3], interior = [0, 0] : (tensor<128x128xf32>, tensor<f32>) -> tensor<128x134xf32>
    return %1 : tensor<128x134xf32>
  }
}
