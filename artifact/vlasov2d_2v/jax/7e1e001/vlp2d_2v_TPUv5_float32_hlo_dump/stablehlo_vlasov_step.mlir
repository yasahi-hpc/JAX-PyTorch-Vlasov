module @jit__lambda attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<32x32x32x32xf32>) -> (tensor<32x32x32x32xf32> {jax.result_info = "result[0]"}, tensor<32x32xf32> {jax.result_info = "result[1]"}, tensor<32x32xf32> {jax.result_info = "result[2]"}) {
    %cst = stablehlo.constant dense<[-5.000000e+00, -4.67741966, -4.35483837, -4.03225803, -3.7096777, -3.38709712, -3.06451607, -2.74193525, -2.41935492, -2.09677458, -1.77419376, -1.45161271, -1.12903225, -0.806451797, -0.483870983, -0.161290407, 0.161290169, 0.483870745, 0.80645132, 1.12903225, 1.45161259, 1.77419317, 2.0967741, 2.41935468, 2.74193525, 3.06451583, 3.38709641, 3.70967722, 4.03225803, 4.35483837, 4.67741871, 5.000000e+00]> : tensor<32xf32>
    %c = stablehlo.constant dense<[-2, -1, 0, 1, 2, 3]> : tensor<6xi32>
    %cst_0 = stablehlo.constant dense<[-5.000000e+00, -4.67741966, -4.35483837, -4.03225803, -3.7096777, -3.38709712, -3.06451607, -2.74193525, -2.41935492, -2.09677458, -1.77419376, -1.45161271, -1.12903225, -0.806451797, -0.483870983, -0.161290407, 0.161290169, 0.483870745, 0.80645132, 1.12903225, 1.45161259, 1.77419317, 2.0967741, 2.41935468, 2.74193525, 3.06451583, 3.38709641, 3.70967722, 4.03225803, 4.35483837, 4.67741871, 5.000000e+00]> : tensor<32xf32>
    %cst_1 = stablehlo.constant dense<[[0.000000e+00], [5.000000e-01], [1.000000e+00], [1.49999988], [2.000000e+00], [2.500000e+00], [2.99999976], [3.500000e+00], [4.000000e+00], [4.500000e+00], [5.000000e+00], [5.500000e+00], [5.99999952], [6.49999952], [7.000000e+00], [7.500000e+00], [-8.000000e+00], [-7.500000e+00], [-7.000000e+00], [-6.49999952], [-5.99999952], [-5.500000e+00], [-5.000000e+00], [-4.500000e+00], [-4.000000e+00], [-3.500000e+00], [-2.99999976], [-2.500000e+00], [-2.000000e+00], [-1.49999988], [-1.000000e+00], [-5.000000e-01]]> : tensor<32x1xf32>
    %cst_2 = stablehlo.constant dense<[[0.000000e+00, 5.000000e-01, 1.000000e+00, 1.49999988, 2.000000e+00, 2.500000e+00, 2.99999976, 3.500000e+00, 4.000000e+00, 4.500000e+00, 5.000000e+00, 5.500000e+00, 5.99999952, 6.49999952, 7.000000e+00, 7.500000e+00, 8.000000e+00]]> : tensor<1x17xf32>
    %cst_3 = stablehlo.constant dense<"0x00000000000080400000803F3B8EE33E0000803E0AD7233E3B8EE33D062FA73D0000803D89454A3D0AD7233DAB67073D3B8EE33CBEE4C13C062FA73CB4A2913C0000803C0000804000000040CDCC4C3FCFCCCC3EF1F0703ED9891D3ECA67DD3D0AD7A33DC10F7C3D0CCE473DC337223D8A4B063D7AFCE13CC3C0C03CC455A63CBCFD903CFF007F3C0000803FCDCC4C3F0000003FDA899D3ECDCC4C3ECB3D0D3ECFCCCC3DE8909A3DF1F0703DC1C0403DD9891D3D6F12033DCA67DD3C1269BD3C0AD7A33C7A178F3CC10F7C3C3B8EE33ECFCCCC3EDA899D3E3B8E633E0AD7233EF1F0F03D620BB63DCB3D8D3D3970603D610B363DDB4F163DC10FFC3C822BD63C0517B83C0AD89F3CC1088C3C3F4E773C0000803EF1F0703ECDCC4C3E0AD7233E0000003E0CCEC73DDA899D3DC10F7C3DCDCC4C3D3FE8283DCB3D0D3DB72EEF3CCFCCCC3CD61FB13CE8909A3C80F7873CF1F0703C0AD7233ED9891D3ECB3D0D3EF1F0F03D0CCEC73D0AD7A33D8B4B863DC9675D3D0317383DE8901A3D6F12033D3970E03CBDE4C13C41E8A83C8045943C6F12833C6539693C3B8EE33DCA67DD3DCFCCCC3D620BB63DDA899D3D8B4B863D3B8E633DC1C0403D0AD7233DC1080C3DF1F0F03CA0B6D03C620BB63C0BD89F3CCB3D8D3C85187B3C3970603C062FA73D0AD7A33DE8909A3DCB3D8D3DC10F7C3DC9675D3DC1C0403D062F273DBCFD103DC10FFC3C62EBDB3CC1C0C03C4BC8A93CDC4F963C37BF853CB72E6F3C44DF563C0000803DC10F7C3DF1F0703D3970603DCDCC4C3D0317383D0AD7233DBCFD103D0000003D78FCE13C0CCEC73CD31FB13CDA899D3C9DA28C3CC10F7C3CA7C4623CCDCC4C3C89454A3D0CCE473DC1C0403D610B363D3FE8283DE8901A3DC1080C3DC10FFC3C78FCE13C8945CA3CE709B53CC337A23CB4A2913C7012833C92976C3C812B563C0678423C0AD7233DC337223DD9891D3DDB4F163DCB3D0D3D6F12033DF1F0F03C62EBDB3C0CCEC73CE709B53C0AD7A33C8045943C8B4B863CD7A0733CC9675D3C35A6493C0317383CAB67073D8A4B063D6F12033DC10FFC3CB72EEF3C3970E03CA0B6D03CC1C0C03CD31FB13CC337A23C8045943CAB67873C3F4E773C7AFC613CF9BC4E3C10693D3CE6D52D3C3B8EE33C7AFCE13CCA67DD3C822BD63CCFCCCC3CBDE4C13C620BB63C4BC8A93CDA899D3CB4A2913C8B4B863C3F4E773C3B8E633C5761513CC1C0403CB59A313C0AD7233CBEE4C13CC3C0C03C1269BD3C0517B83CD61FB13C41E8A83C0BD89F3CDC4F963C9DA28C3C7012833CD7A0733C7AFC613C5761513CBEE4413CFB8C333CC555263CCE331A3C062FA73CC455A63C0AD7A33C0AD89F3CE8909A3C8045943CCB3D8D3C37BF853CC10F7C3C92976C3CC9675D3CF9BC4E3CC1C0403CFB8C333C062F273CDFAA1B3CBCFD103CB4A2913CBCFD903C7A178F3CC1088C3C80F7873C6F12833C85187B3CB72E6F3CA7C4623C812B563C35A6493C10693D3CB59A313CC555263CDFAA1B3CB4A2113CDD3F083C0000803CFF007F3CC10F7C3C3F4E773CF1F0703C6539693C3970603C44DF563CCDCC4C3C0678423C0317383CE6D52D3C0AD7233CCE331A3CBCFD103CDD3F083C0000003CB4A2913CBCFD903C7A178F3CC1088C3C80F7873C6F12833C85187B3CB72E6F3CA7C4623C812B563C35A6493C10693D3CB59A313CC555263CDFAA1B3CB4A2113CDD3F083C062FA73CC455A63C0AD7A33C0AD89F3CE8909A3C8045943CCB3D8D3C37BF853CC10F7C3C92976C3CC9675D3CF9BC4E3CC1C0403CFB8C333C062F273CDFAA1B3CBCFD103CBEE4C13CC3C0C03C1269BD3C0517B83CD61FB13C41E8A83C0BD89F3CDC4F963C9DA28C3C7012833CD7A0733C7AFC613C5761513CBEE4413CFB8C333CC555263CCE331A3C3B8EE33C7AFCE13CCA67DD3C822BD63CCFCCCC3CBDE4C13C620BB63C4BC8A93CDA899D3CB4A2913C8B4B863C3F4E773C3B8E633C5761513CC1C0403CB59A313C0AD7233CAB67073D8A4B063D6F12033DC10FFC3CB72EEF3C3970E03CA0B6D03CC1C0C03CD31FB13CC337A23C8045943CAB67873C3F4E773C7AFC613CF9BC4E3C10693D3CE6D52D3C0AD7233DC337223DD9891D3DDB4F163DCB3D0D3D6F12033DF1F0F03C62EBDB3C0CCEC73CE709B53C0AD7A33C8045943C8B4B863CD7A0733CC9675D3C35A6493C0317383C89454A3D0CCE473DC1C0403D610B363D3FE8283DE8901A3DC1080C3DC10FFC3C78FCE13C8945CA3CE709B53CC337A23CB4A2913C7012833C92976C3C812B563C0678423C0000803DC10F7C3DF1F0703D3970603DCDCC4C3D0317383D0AD7233DBCFD103D0000003D78FCE13C0CCEC73CD31FB13CDA899D3C9DA28C3CC10F7C3CA7C4623CCDCC4C3C062FA73D0AD7A33DE8909A3DCB3D8D3DC10F7C3DC9675D3DC1C0403D062F273DBCFD103DC10FFC3C62EBDB3CC1C0C03C4BC8A93CDC4F963C37BF853CB72E6F3C44DF563C3B8EE33DCA67DD3DCFCCCC3D620BB63DDA899D3D8B4B863D3B8E633DC1C0403D0AD7233DC1080C3DF1F0F03CA0B6D03C620BB63C0BD89F3CCB3D8D3C85187B3C3970603C0AD7233ED9891D3ECB3D0D3EF1F0F03D0CCEC73D0AD7A33D8B4B863DC9675D3D0317383DE8901A3D6F12033D3970E03CBDE4C13C41E8A83C8045943C6F12833C6539693C0000803EF1F0703ECDCC4C3E0AD7233E0000003E0CCEC73DDA899D3DC10F7C3DCDCC4C3D3FE8283DCB3D0D3DB72EEF3CCFCCCC3CD61FB13CE8909A3C80F7873CF1F0703C3B8EE33ECFCCCC3EDA899D3E3B8E633E0AD7233EF1F0F03D620BB63DCB3D8D3D3970603D610B363DDB4F163DC10FFC3C822BD63C0517B83C0AD89F3CC1088C3C3F4E773C0000803FCDCC4C3F0000003FDA899D3ECDCC4C3ECB3D0D3ECFCCCC3DE8909A3DF1F0703DC1C0403DD9891D3D6F12033DCA67DD3C1269BD3C0AD7A33C7A178F3CC10F7C3C0000804000000040CDCC4C3FCFCCCC3EF1F0703ED9891D3ECA67DD3D0AD7A33DC10F7C3D0CCE473DC337223D8A4B063D7AFCE13CC3C0C03CC455A63CBCFD903CFF007F3C"> : tensor<32x17xf32>
    %0 = stablehlo.broadcast_in_dim %cst, dims = [1] : (tensor<32xf32>) -> tensor<1x32x1xf32>
    %1 = stablehlo.transpose %arg0, dims = [1, 2, 3, 0] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %2 = stablehlo.reshape %1 : (tensor<32x32x32x32xf32>) -> tensor<32768x32xf32>
    %3 = stablehlo.broadcast_in_dim %0, dims = [0, 1, 2] : (tensor<1x32x1xf32>) -> tensor<32x32x32xf32>
    %4 = stablehlo.reshape %3 : (tensor<32x32x32xf32>) -> tensor<32768xf32>
    %cst_4 = stablehlo.constant dense<2.500000e-02> : tensor<f32>
    %cst_5 = stablehlo.constant dense<0.392699093> : tensor<f32>
    %5 = call @advect_1d_vectorized(%2, %4, %cst_4, %cst_5, %c) : (tensor<32768x32xf32>, tensor<32768xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<32768x32xf32>
    %6 = stablehlo.reshape %5 : (tensor<32768x32xf32>) -> tensor<32x32x32x32xf32>
    %7 = stablehlo.transpose %6, dims = [3, 0, 1, 2] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %8 = stablehlo.broadcast_in_dim %cst_0, dims = [2] : (tensor<32xf32>) -> tensor<1x1x32xf32>
    %9 = stablehlo.transpose %7, dims = [0, 2, 3, 1] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %10 = stablehlo.reshape %9 : (tensor<32x32x32x32xf32>) -> tensor<32768x32xf32>
    %11 = stablehlo.broadcast_in_dim %8, dims = [0, 1, 2] : (tensor<1x1x32xf32>) -> tensor<32x32x32xf32>
    %12 = stablehlo.reshape %11 : (tensor<32x32x32xf32>) -> tensor<32768xf32>
    %13 = call @advect_1d_vectorized(%10, %12, %cst_4, %cst_5, %c) : (tensor<32768x32xf32>, tensor<32768xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<32768x32xf32>
    %14 = stablehlo.reshape %13 : (tensor<32768x32xf32>) -> tensor<32x32x32x32xf32>
    %15 = stablehlo.transpose %14, dims = [0, 3, 1, 2] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %cst_6 = stablehlo.constant dense<0.322580636> : tensor<f32>
    %16:4 = call @solve_poisson(%15, %cst_1, %cst_2, %cst_3, %cst_6, %cst_6) : (tensor<32x32x32x32xf32>, tensor<32x1xf32>, tensor<1x17xf32>, tensor<32x17xf32>, tensor<f32>, tensor<f32>) -> (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>)
    %17 = stablehlo.broadcast_in_dim %16#0, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1xf32>
    %18 = stablehlo.transpose %15, dims = [0, 1, 3, 2] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %19 = stablehlo.reshape %18 : (tensor<32x32x32x32xf32>) -> tensor<32768x32xf32>
    %20 = stablehlo.broadcast_in_dim %17, dims = [0, 1, 2] : (tensor<32x32x1xf32>) -> tensor<32x32x32xf32>
    %21 = stablehlo.reshape %20 : (tensor<32x32x32xf32>) -> tensor<32768xf32>
    %cst_7 = stablehlo.constant dense<5.000000e-02> : tensor<f32>
    %22 = call @advect_1d_vectorized_56(%19, %21, %cst_7, %cst_6, %c) : (tensor<32768x32xf32>, tensor<32768xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<32768x32xf32>
    %23 = stablehlo.reshape %22 : (tensor<32768x32xf32>) -> tensor<32x32x32x32xf32>
    %24 = stablehlo.transpose %23, dims = [0, 1, 3, 2] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %25 = stablehlo.broadcast_in_dim %16#1, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1xf32>
    %26 = stablehlo.reshape %24 : (tensor<32x32x32x32xf32>) -> tensor<32768x32xf32>
    %27 = stablehlo.broadcast_in_dim %25, dims = [0, 1, 2] : (tensor<32x32x1xf32>) -> tensor<32x32x32xf32>
    %28 = stablehlo.reshape %27 : (tensor<32x32x32xf32>) -> tensor<32768xf32>
    %29 = call @advect_1d_vectorized_56(%26, %28, %cst_7, %cst_6, %c) : (tensor<32768x32xf32>, tensor<32768xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<32768x32xf32>
    %30 = stablehlo.reshape %29 : (tensor<32768x32xf32>) -> tensor<32x32x32x32xf32>
    %31 = stablehlo.broadcast_in_dim %cst_0, dims = [2] : (tensor<32xf32>) -> tensor<1x1x32xf32>
    %32 = stablehlo.transpose %30, dims = [0, 2, 3, 1] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %33 = stablehlo.reshape %32 : (tensor<32x32x32x32xf32>) -> tensor<32768x32xf32>
    %34 = stablehlo.broadcast_in_dim %31, dims = [0, 1, 2] : (tensor<1x1x32xf32>) -> tensor<32x32x32xf32>
    %35 = stablehlo.reshape %34 : (tensor<32x32x32xf32>) -> tensor<32768xf32>
    %36 = call @advect_1d_vectorized(%33, %35, %cst_4, %cst_5, %c) : (tensor<32768x32xf32>, tensor<32768xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<32768x32xf32>
    %37 = stablehlo.reshape %36 : (tensor<32768x32xf32>) -> tensor<32x32x32x32xf32>
    %38 = stablehlo.transpose %37, dims = [0, 3, 1, 2] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %39 = stablehlo.broadcast_in_dim %cst, dims = [1] : (tensor<32xf32>) -> tensor<1x32x1xf32>
    %40 = stablehlo.transpose %38, dims = [1, 2, 3, 0] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %41 = stablehlo.reshape %40 : (tensor<32x32x32x32xf32>) -> tensor<32768x32xf32>
    %42 = stablehlo.broadcast_in_dim %39, dims = [0, 1, 2] : (tensor<1x32x1xf32>) -> tensor<32x32x32xf32>
    %43 = stablehlo.reshape %42 : (tensor<32x32x32xf32>) -> tensor<32768xf32>
    %44 = call @advect_1d_vectorized(%41, %43, %cst_4, %cst_5, %c) : (tensor<32768x32xf32>, tensor<32768xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<32768x32xf32>
    %45 = stablehlo.reshape %44 : (tensor<32768x32xf32>) -> tensor<32x32x32x32xf32>
    %46 = stablehlo.transpose %45, dims = [3, 0, 1, 2] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %46, %16#2, %16#3 : tensor<32x32x32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>
  }
  func.func private @advect_1d_vectorized(%arg0: tensor<32768x32xf32>, %arg1: tensor<32768xf32>, %arg2: tensor<f32>, %arg3: tensor<f32>, %arg4: tensor<6xi32>) -> tensor<32768x32xf32> {
    %0 = stablehlo.iota dim = 0 : tensor<32xf32>
    %1 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<32768xf32>) -> tensor<32768x1xf32>
    %2 = stablehlo.convert %arg2 : tensor<f32>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<f32>) -> tensor<32768x1xf32>
    %4 = stablehlo.multiply %1, %3 : tensor<32768x1xf32>
    %5 = stablehlo.convert %arg3 : tensor<f32>
    %6 = stablehlo.broadcast_in_dim %5, dims = [] : (tensor<f32>) -> tensor<32768x1xf32>
    %7 = stablehlo.divide %4, %6 : tensor<32768x1xf32>
    %8 = stablehlo.broadcast_in_dim %0, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x32xf32>) -> tensor<32768x32xf32>
    %10 = stablehlo.broadcast_in_dim %7, dims = [0, 1] : (tensor<32768x1xf32>) -> tensor<32768x32xf32>
    %11 = stablehlo.subtract %9, %10 : tensor<32768x32xf32>
    %12 = stablehlo.floor %11 : tensor<32768x32xf32>
    %13 = stablehlo.subtract %11, %12 : tensor<32768x32xf32>
    %14 = stablehlo.convert %12 : (tensor<32768x32xf32>) -> tensor<32768x32xi32>
    %15 = stablehlo.broadcast_in_dim %14, dims = [0, 1] : (tensor<32768x32xi32>) -> tensor<32768x32x1xi32>
    %16 = stablehlo.broadcast_in_dim %arg4, dims = [2] : (tensor<6xi32>) -> tensor<1x1x6xi32>
    %17 = stablehlo.broadcast_in_dim %15, dims = [0, 1, 2] : (tensor<32768x32x1xi32>) -> tensor<32768x32x6xi32>
    %18 = stablehlo.broadcast_in_dim %16, dims = [0, 1, 2] : (tensor<1x1x6xi32>) -> tensor<32768x32x6xi32>
    %19 = stablehlo.add %17, %18 : tensor<32768x32x6xi32>
    %c = stablehlo.constant dense<32> : tensor<i32>
    %20 = call @remainder(%19, %c) : (tensor<32768x32x6xi32>, tensor<i32>) -> tensor<32768x32x6xi32>
    %21 = stablehlo.iota dim = 0 : tensor<32768xi32>
    %22 = stablehlo.broadcast_in_dim %21, dims = [0] : (tensor<32768xi32>) -> tensor<32768x1x1xi32>
    %c_0 = stablehlo.constant dense<32> : tensor<i32>
    %23 = stablehlo.broadcast_in_dim %c_0, dims = [] : (tensor<i32>) -> tensor<32768x1x1xi32>
    %24 = stablehlo.multiply %22, %23 : tensor<32768x1x1xi32>
    %25 = stablehlo.broadcast_in_dim %24, dims = [0, 1, 2] : (tensor<32768x1x1xi32>) -> tensor<32768x32x6xi32>
    %26 = stablehlo.add %25, %20 : tensor<32768x32x6xi32>
    %27 = stablehlo.reshape %arg0 : (tensor<32768x32xf32>) -> tensor<1048576xf32>
    %28 = stablehlo.reshape %26 : (tensor<32768x32x6xi32>) -> tensor<6291456xi32>
    %c_1 = stablehlo.constant dense<0> : tensor<i32>
    %29 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<6291456xi32>
    %30 = stablehlo.compare  LT, %28, %29,  SIGNED : (tensor<6291456xi32>, tensor<6291456xi32>) -> tensor<6291456xi1>
    %c_2 = stablehlo.constant dense<1048576> : tensor<i32>
    %31 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<6291456xi32>
    %32 = stablehlo.add %28, %31 : tensor<6291456xi32>
    %33 = stablehlo.select %30, %32, %28 : tensor<6291456xi1>, tensor<6291456xi32>
    %34 = stablehlo.broadcast_in_dim %33, dims = [0] : (tensor<6291456xi32>) -> tensor<6291456x1xi32>
    %35 = "stablehlo.gather"(%27, %34) <{dimension_numbers = #stablehlo.gather<collapsed_slice_dims = [0], start_index_map = [0], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 1>}> : (tensor<1048576xf32>, tensor<6291456x1xi32>) -> tensor<6291456xf32>
    %36 = stablehlo.reshape %35 : (tensor<6291456xf32>) -> tensor<32768x32x6xf32>
    %37 = stablehlo.multiply %13, %13 : tensor<32768x32xf32>
    %38 = stablehlo.multiply %37, %13 : tensor<32768x32xf32>
    %39 = stablehlo.multiply %38, %13 : tensor<32768x32xf32>
    %40 = stablehlo.multiply %39, %13 : tensor<32768x32xf32>
    %cst = stablehlo.constant dense<2.000000e+01> : tensor<f32>
    %41 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %42 = stablehlo.divide %13, %41 : tensor<32768x32xf32>
    %cst_3 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %43 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %44 = stablehlo.divide %37, %43 : tensor<32768x32xf32>
    %45 = stablehlo.subtract %42, %44 : tensor<32768x32xf32>
    %cst_4 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %46 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %47 = stablehlo.divide %38, %46 : tensor<32768x32xf32>
    %48 = stablehlo.subtract %45, %47 : tensor<32768x32xf32>
    %cst_5 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %49 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %50 = stablehlo.divide %39, %49 : tensor<32768x32xf32>
    %51 = stablehlo.add %48, %50 : tensor<32768x32xf32>
    %cst_6 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %52 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %53 = stablehlo.divide %40, %52 : tensor<32768x32xf32>
    %54 = stablehlo.subtract %51, %53 : tensor<32768x32xf32>
    %cst_7 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %55 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %56 = stablehlo.divide %13, %55 : tensor<32768x32xf32>
    %57 = stablehlo.negate %56 : tensor<32768x32xf32>
    %cst_8 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %58 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %59 = stablehlo.multiply %58, %37 : tensor<32768x32xf32>
    %cst_9 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %60 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %61 = stablehlo.divide %59, %60 : tensor<32768x32xf32>
    %62 = stablehlo.add %57, %61 : tensor<32768x32xf32>
    %cst_10 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %63 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %64 = stablehlo.divide %38, %63 : tensor<32768x32xf32>
    %65 = stablehlo.subtract %62, %64 : tensor<32768x32xf32>
    %cst_11 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %66 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %67 = stablehlo.divide %39, %66 : tensor<32768x32xf32>
    %68 = stablehlo.subtract %65, %67 : tensor<32768x32xf32>
    %cst_12 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %69 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %70 = stablehlo.divide %40, %69 : tensor<32768x32xf32>
    %71 = stablehlo.add %68, %70 : tensor<32768x32xf32>
    %cst_13 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %72 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %73 = stablehlo.divide %13, %72 : tensor<32768x32xf32>
    %cst_14 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %74 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %75 = stablehlo.subtract %74, %73 : tensor<32768x32xf32>
    %cst_15 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %76 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %77 = stablehlo.multiply %76, %37 : tensor<32768x32xf32>
    %cst_16 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %78 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %79 = stablehlo.divide %77, %78 : tensor<32768x32xf32>
    %80 = stablehlo.subtract %75, %79 : tensor<32768x32xf32>
    %cst_17 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %81 = stablehlo.broadcast_in_dim %cst_17, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %82 = stablehlo.multiply %81, %38 : tensor<32768x32xf32>
    %cst_18 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %83 = stablehlo.broadcast_in_dim %cst_18, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %84 = stablehlo.divide %82, %83 : tensor<32768x32xf32>
    %85 = stablehlo.add %80, %84 : tensor<32768x32xf32>
    %cst_19 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %86 = stablehlo.broadcast_in_dim %cst_19, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %87 = stablehlo.divide %39, %86 : tensor<32768x32xf32>
    %88 = stablehlo.add %85, %87 : tensor<32768x32xf32>
    %cst_20 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %89 = stablehlo.broadcast_in_dim %cst_20, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %90 = stablehlo.divide %40, %89 : tensor<32768x32xf32>
    %91 = stablehlo.subtract %88, %90 : tensor<32768x32xf32>
    %cst_21 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %92 = stablehlo.broadcast_in_dim %cst_21, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %93 = stablehlo.multiply %92, %37 : tensor<32768x32xf32>
    %cst_22 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %94 = stablehlo.broadcast_in_dim %cst_22, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %95 = stablehlo.divide %93, %94 : tensor<32768x32xf32>
    %96 = stablehlo.add %13, %95 : tensor<32768x32xf32>
    %cst_23 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %97 = stablehlo.broadcast_in_dim %cst_23, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %98 = stablehlo.multiply %97, %38 : tensor<32768x32xf32>
    %cst_24 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %99 = stablehlo.broadcast_in_dim %cst_24, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %100 = stablehlo.divide %98, %99 : tensor<32768x32xf32>
    %101 = stablehlo.subtract %96, %100 : tensor<32768x32xf32>
    %cst_25 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %102 = stablehlo.broadcast_in_dim %cst_25, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %103 = stablehlo.divide %39, %102 : tensor<32768x32xf32>
    %104 = stablehlo.subtract %101, %103 : tensor<32768x32xf32>
    %cst_26 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %105 = stablehlo.broadcast_in_dim %cst_26, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %106 = stablehlo.divide %40, %105 : tensor<32768x32xf32>
    %107 = stablehlo.add %104, %106 : tensor<32768x32xf32>
    %cst_27 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %108 = stablehlo.broadcast_in_dim %cst_27, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %109 = stablehlo.divide %13, %108 : tensor<32768x32xf32>
    %110 = stablehlo.negate %109 : tensor<32768x32xf32>
    %cst_28 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %111 = stablehlo.broadcast_in_dim %cst_28, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %112 = stablehlo.divide %37, %111 : tensor<32768x32xf32>
    %113 = stablehlo.subtract %110, %112 : tensor<32768x32xf32>
    %cst_29 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %114 = stablehlo.broadcast_in_dim %cst_29, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %115 = stablehlo.multiply %114, %38 : tensor<32768x32xf32>
    %cst_30 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %116 = stablehlo.broadcast_in_dim %cst_30, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %117 = stablehlo.divide %115, %116 : tensor<32768x32xf32>
    %118 = stablehlo.add %113, %117 : tensor<32768x32xf32>
    %cst_31 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %119 = stablehlo.broadcast_in_dim %cst_31, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %120 = stablehlo.divide %39, %119 : tensor<32768x32xf32>
    %121 = stablehlo.add %118, %120 : tensor<32768x32xf32>
    %cst_32 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %122 = stablehlo.broadcast_in_dim %cst_32, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %123 = stablehlo.divide %40, %122 : tensor<32768x32xf32>
    %124 = stablehlo.subtract %121, %123 : tensor<32768x32xf32>
    %cst_33 = stablehlo.constant dense<3.000000e+01> : tensor<f32>
    %125 = stablehlo.broadcast_in_dim %cst_33, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %126 = stablehlo.divide %13, %125 : tensor<32768x32xf32>
    %cst_34 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %127 = stablehlo.broadcast_in_dim %cst_34, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %128 = stablehlo.divide %38, %127 : tensor<32768x32xf32>
    %129 = stablehlo.subtract %126, %128 : tensor<32768x32xf32>
    %cst_35 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %130 = stablehlo.broadcast_in_dim %cst_35, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %131 = stablehlo.divide %40, %130 : tensor<32768x32xf32>
    %132 = stablehlo.add %129, %131 : tensor<32768x32xf32>
    %133 = stablehlo.slice %36 [0:32768, 0:32, 0:1] : (tensor<32768x32x6xf32>) -> tensor<32768x32x1xf32>
    %134 = stablehlo.reshape %133 : (tensor<32768x32x1xf32>) -> tensor<32768x32xf32>
    %135 = stablehlo.multiply %54, %134 : tensor<32768x32xf32>
    %136 = stablehlo.slice %36 [0:32768, 0:32, 1:2] : (tensor<32768x32x6xf32>) -> tensor<32768x32x1xf32>
    %137 = stablehlo.reshape %136 : (tensor<32768x32x1xf32>) -> tensor<32768x32xf32>
    %138 = stablehlo.multiply %71, %137 : tensor<32768x32xf32>
    %139 = stablehlo.add %135, %138 : tensor<32768x32xf32>
    %140 = stablehlo.slice %36 [0:32768, 0:32, 2:3] : (tensor<32768x32x6xf32>) -> tensor<32768x32x1xf32>
    %141 = stablehlo.reshape %140 : (tensor<32768x32x1xf32>) -> tensor<32768x32xf32>
    %142 = stablehlo.multiply %91, %141 : tensor<32768x32xf32>
    %143 = stablehlo.add %139, %142 : tensor<32768x32xf32>
    %144 = stablehlo.slice %36 [0:32768, 0:32, 3:4] : (tensor<32768x32x6xf32>) -> tensor<32768x32x1xf32>
    %145 = stablehlo.reshape %144 : (tensor<32768x32x1xf32>) -> tensor<32768x32xf32>
    %146 = stablehlo.multiply %107, %145 : tensor<32768x32xf32>
    %147 = stablehlo.add %143, %146 : tensor<32768x32xf32>
    %148 = stablehlo.slice %36 [0:32768, 0:32, 4:5] : (tensor<32768x32x6xf32>) -> tensor<32768x32x1xf32>
    %149 = stablehlo.reshape %148 : (tensor<32768x32x1xf32>) -> tensor<32768x32xf32>
    %150 = stablehlo.multiply %124, %149 : tensor<32768x32xf32>
    %151 = stablehlo.add %147, %150 : tensor<32768x32xf32>
    %152 = stablehlo.slice %36 [0:32768, 0:32, 5:6] : (tensor<32768x32x6xf32>) -> tensor<32768x32x1xf32>
    %153 = stablehlo.reshape %152 : (tensor<32768x32x1xf32>) -> tensor<32768x32xf32>
    %154 = stablehlo.multiply %132, %153 : tensor<32768x32xf32>
    %155 = stablehlo.add %151, %154 : tensor<32768x32xf32>
    return %155 : tensor<32768x32xf32>
  }
  func.func private @remainder(%arg0: tensor<32768x32x6xi32>, %arg1: tensor<i32>) -> tensor<32768x32x6xi32> {
    %0 = stablehlo.convert %arg1 : tensor<i32>
    %c = stablehlo.constant dense<0> : tensor<i32>
    %1 = stablehlo.compare  EQ, %0, %c,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %2 = call @_where(%1, %c_0, %0) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<i32>) -> tensor<32768x32x6xi32>
    %4 = stablehlo.remainder %arg0, %3 : tensor<32768x32x6xi32>
    %c_1 = stablehlo.constant dense<0> : tensor<i32>
    %5 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<32768x32x6xi32>
    %6 = stablehlo.compare  NE, %4, %5,  SIGNED : (tensor<32768x32x6xi32>, tensor<32768x32x6xi32>) -> tensor<32768x32x6xi1>
    %c_2 = stablehlo.constant dense<0> : tensor<i32>
    %7 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<32768x32x6xi32>
    %8 = stablehlo.compare  LT, %4, %7,  SIGNED : (tensor<32768x32x6xi32>, tensor<32768x32x6xi32>) -> tensor<32768x32x6xi1>
    %c_3 = stablehlo.constant dense<0> : tensor<i32>
    %9 = stablehlo.compare  LT, %2, %c_3,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %10 = stablehlo.broadcast_in_dim %9, dims = [] : (tensor<i1>) -> tensor<32768x32x6xi1>
    %11 = stablehlo.compare  NE, %8, %10,  UNSIGNED : (tensor<32768x32x6xi1>, tensor<32768x32x6xi1>) -> tensor<32768x32x6xi1>
    %12 = stablehlo.and %11, %6 : tensor<32768x32x6xi1>
    %13 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<i32>) -> tensor<32768x32x6xi32>
    %14 = stablehlo.add %4, %13 : tensor<32768x32x6xi32>
    %15 = stablehlo.select %12, %14, %4 : tensor<32768x32x6xi1>, tensor<32768x32x6xi32>
    return %15 : tensor<32768x32x6xi32>
  }
  func.func private @_where(%arg0: tensor<i1>, %arg1: tensor<i32>, %arg2: tensor<i32>) -> tensor<i32> {
    %0 = stablehlo.select %arg0, %arg1, %arg2 : tensor<i1>, tensor<i32>
    return %0 : tensor<i32>
  }
  func.func private @solve_poisson(%arg0: tensor<32x32x32x32xf32>, %arg1: tensor<32x1xf32>, %arg2: tensor<1x17xf32>, %arg3: tensor<32x17xf32>, %arg4: tensor<f32>, %arg5: tensor<f32>) -> (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>) {
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %0 = stablehlo.reduce(%arg0 init: %cst) applies stablehlo.add across dimensions = [2, 3] : (tensor<32x32x32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1 = stablehlo.convert %arg4 : tensor<f32>
    %2 = stablehlo.broadcast_in_dim %1, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %3 = stablehlo.multiply %0, %2 : tensor<32x32xf32>
    %4 = stablehlo.convert %arg5 : tensor<f32>
    %5 = stablehlo.broadcast_in_dim %4, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %6 = stablehlo.multiply %3, %5 : tensor<32x32xf32>
    %cst_0 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %7 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %8 = stablehlo.subtract %6, %7 : tensor<32x32xf32>
    %9 = call @fft(%8) : (tensor<32x32xf32>) -> tensor<32x17xcomplex<f32>>
    %10 = stablehlo.convert %arg3 : (tensor<32x17xf32>) -> tensor<32x17xcomplex<f32>>
    %11 = stablehlo.multiply %9, %10 : tensor<32x17xcomplex<f32>>
    %12 = call @fft_45(%11) : (tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32>
    %13 = stablehlo.convert %arg1 : (tensor<32x1xf32>) -> tensor<32x1xcomplex<f32>>
    %cst_1 = stablehlo.constant dense<(-0.000000e+00,-1.000000e+00)> : tensor<complex<f32>>
    %14 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<complex<f32>>) -> tensor<32x1xcomplex<f32>>
    %15 = stablehlo.multiply %14, %13 : tensor<32x1xcomplex<f32>>
    %16 = stablehlo.broadcast_in_dim %15, dims = [0, 1] : (tensor<32x1xcomplex<f32>>) -> tensor<32x17xcomplex<f32>>
    %17 = stablehlo.multiply %16, %11 : tensor<32x17xcomplex<f32>>
    %18 = stablehlo.convert %arg2 : (tensor<1x17xf32>) -> tensor<1x17xcomplex<f32>>
    %cst_2 = stablehlo.constant dense<(-0.000000e+00,-1.000000e+00)> : tensor<complex<f32>>
    %19 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<complex<f32>>) -> tensor<1x17xcomplex<f32>>
    %20 = stablehlo.multiply %19, %18 : tensor<1x17xcomplex<f32>>
    %21 = stablehlo.broadcast_in_dim %20, dims = [0, 1] : (tensor<1x17xcomplex<f32>>) -> tensor<32x17xcomplex<f32>>
    %22 = stablehlo.multiply %21, %11 : tensor<32x17xcomplex<f32>>
    %23 = call @fft_45(%17) : (tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32>
    %24 = call @fft_45(%22) : (tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32>
    return %23, %24, %8, %12 : tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>
  }
  func.func private @fft(%arg0: tensor<32x32xf32>) -> tensor<32x17xcomplex<f32>> {
    %0 = stablehlo.fft %arg0, type =  RFFT, length = [32, 32] : (tensor<32x32xf32>) -> tensor<32x17xcomplex<f32>>
    return %0 : tensor<32x17xcomplex<f32>>
  }
  func.func private @fft_45(%arg0: tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32> {
    %0 = stablehlo.fft %arg0, type =  IRFFT, length = [32, 32] : (tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32>
    return %0 : tensor<32x32xf32>
  }
  func.func private @advect_1d_vectorized_56(%arg0: tensor<32768x32xf32>, %arg1: tensor<32768xf32>, %arg2: tensor<f32>, %arg3: tensor<f32>, %arg4: tensor<6xi32>) -> tensor<32768x32xf32> {
    %0 = stablehlo.iota dim = 0 : tensor<32xf32>
    %1 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<32768xf32>) -> tensor<32768x1xf32>
    %2 = stablehlo.convert %arg2 : tensor<f32>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<f32>) -> tensor<32768x1xf32>
    %4 = stablehlo.multiply %1, %3 : tensor<32768x1xf32>
    %5 = stablehlo.convert %arg3 : tensor<f32>
    %6 = stablehlo.broadcast_in_dim %5, dims = [] : (tensor<f32>) -> tensor<32768x1xf32>
    %7 = stablehlo.divide %4, %6 : tensor<32768x1xf32>
    %8 = stablehlo.broadcast_in_dim %0, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x32xf32>) -> tensor<32768x32xf32>
    %10 = stablehlo.broadcast_in_dim %7, dims = [0, 1] : (tensor<32768x1xf32>) -> tensor<32768x32xf32>
    %11 = stablehlo.subtract %9, %10 : tensor<32768x32xf32>
    %12 = stablehlo.floor %11 : tensor<32768x32xf32>
    %13 = stablehlo.subtract %11, %12 : tensor<32768x32xf32>
    %14 = stablehlo.convert %12 : (tensor<32768x32xf32>) -> tensor<32768x32xi32>
    %15 = stablehlo.broadcast_in_dim %14, dims = [0, 1] : (tensor<32768x32xi32>) -> tensor<32768x32x1xi32>
    %16 = stablehlo.broadcast_in_dim %arg4, dims = [2] : (tensor<6xi32>) -> tensor<1x1x6xi32>
    %17 = stablehlo.broadcast_in_dim %15, dims = [0, 1, 2] : (tensor<32768x32x1xi32>) -> tensor<32768x32x6xi32>
    %18 = stablehlo.broadcast_in_dim %16, dims = [0, 1, 2] : (tensor<1x1x6xi32>) -> tensor<32768x32x6xi32>
    %19 = stablehlo.add %17, %18 : tensor<32768x32x6xi32>
    %c = stablehlo.constant dense<0> : tensor<i32>
    %20 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<32768x32x6xi32>
    %21 = stablehlo.compare  GE, %19, %20,  SIGNED : (tensor<32768x32x6xi32>, tensor<32768x32x6xi32>) -> tensor<32768x32x6xi1>
    %c_0 = stablehlo.constant dense<32> : tensor<i32>
    %22 = stablehlo.broadcast_in_dim %c_0, dims = [] : (tensor<i32>) -> tensor<32768x32x6xi32>
    %23 = stablehlo.compare  LT, %19, %22,  SIGNED : (tensor<32768x32x6xi32>, tensor<32768x32x6xi32>) -> tensor<32768x32x6xi1>
    %24 = stablehlo.and %21, %23 : tensor<32768x32x6xi1>
    %c_1 = stablehlo.constant dense<0> : tensor<i32>
    %c_2 = stablehlo.constant dense<31> : tensor<i32>
    %25 = call @clip(%19, %c_1, %c_2) : (tensor<32768x32x6xi32>, tensor<i32>, tensor<i32>) -> tensor<32768x32x6xi32>
    %26 = stablehlo.iota dim = 0 : tensor<32768xi32>
    %27 = stablehlo.broadcast_in_dim %26, dims = [0] : (tensor<32768xi32>) -> tensor<32768x1x1xi32>
    %c_3 = stablehlo.constant dense<32> : tensor<i32>
    %28 = stablehlo.broadcast_in_dim %c_3, dims = [] : (tensor<i32>) -> tensor<32768x1x1xi32>
    %29 = stablehlo.multiply %27, %28 : tensor<32768x1x1xi32>
    %30 = stablehlo.broadcast_in_dim %29, dims = [0, 1, 2] : (tensor<32768x1x1xi32>) -> tensor<32768x32x6xi32>
    %31 = stablehlo.add %30, %25 : tensor<32768x32x6xi32>
    %32 = stablehlo.reshape %arg0 : (tensor<32768x32xf32>) -> tensor<1048576xf32>
    %33 = stablehlo.reshape %31 : (tensor<32768x32x6xi32>) -> tensor<6291456xi32>
    %c_4 = stablehlo.constant dense<0> : tensor<i32>
    %34 = stablehlo.broadcast_in_dim %c_4, dims = [] : (tensor<i32>) -> tensor<6291456xi32>
    %35 = stablehlo.compare  LT, %33, %34,  SIGNED : (tensor<6291456xi32>, tensor<6291456xi32>) -> tensor<6291456xi1>
    %c_5 = stablehlo.constant dense<1048576> : tensor<i32>
    %36 = stablehlo.broadcast_in_dim %c_5, dims = [] : (tensor<i32>) -> tensor<6291456xi32>
    %37 = stablehlo.add %33, %36 : tensor<6291456xi32>
    %38 = stablehlo.select %35, %37, %33 : tensor<6291456xi1>, tensor<6291456xi32>
    %39 = stablehlo.broadcast_in_dim %38, dims = [0] : (tensor<6291456xi32>) -> tensor<6291456x1xi32>
    %40 = "stablehlo.gather"(%32, %39) <{dimension_numbers = #stablehlo.gather<collapsed_slice_dims = [0], start_index_map = [0], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 1>}> : (tensor<1048576xf32>, tensor<6291456x1xi32>) -> tensor<6291456xf32>
    %41 = stablehlo.reshape %40 : (tensor<6291456xf32>) -> tensor<32768x32x6xf32>
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %42 = call @_where_57(%24, %41, %cst) : (tensor<32768x32x6xi1>, tensor<32768x32x6xf32>, tensor<f32>) -> tensor<32768x32x6xf32>
    %43 = stablehlo.multiply %13, %13 : tensor<32768x32xf32>
    %44 = stablehlo.multiply %43, %13 : tensor<32768x32xf32>
    %45 = stablehlo.multiply %44, %13 : tensor<32768x32xf32>
    %46 = stablehlo.multiply %45, %13 : tensor<32768x32xf32>
    %cst_6 = stablehlo.constant dense<2.000000e+01> : tensor<f32>
    %47 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %48 = stablehlo.divide %13, %47 : tensor<32768x32xf32>
    %cst_7 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %49 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %50 = stablehlo.divide %43, %49 : tensor<32768x32xf32>
    %51 = stablehlo.subtract %48, %50 : tensor<32768x32xf32>
    %cst_8 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %52 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %53 = stablehlo.divide %44, %52 : tensor<32768x32xf32>
    %54 = stablehlo.subtract %51, %53 : tensor<32768x32xf32>
    %cst_9 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %55 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %56 = stablehlo.divide %45, %55 : tensor<32768x32xf32>
    %57 = stablehlo.add %54, %56 : tensor<32768x32xf32>
    %cst_10 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %58 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %59 = stablehlo.divide %46, %58 : tensor<32768x32xf32>
    %60 = stablehlo.subtract %57, %59 : tensor<32768x32xf32>
    %cst_11 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %61 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %62 = stablehlo.divide %13, %61 : tensor<32768x32xf32>
    %63 = stablehlo.negate %62 : tensor<32768x32xf32>
    %cst_12 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %64 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %65 = stablehlo.multiply %64, %43 : tensor<32768x32xf32>
    %cst_13 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %66 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %67 = stablehlo.divide %65, %66 : tensor<32768x32xf32>
    %68 = stablehlo.add %63, %67 : tensor<32768x32xf32>
    %cst_14 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %69 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %70 = stablehlo.divide %44, %69 : tensor<32768x32xf32>
    %71 = stablehlo.subtract %68, %70 : tensor<32768x32xf32>
    %cst_15 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %72 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %73 = stablehlo.divide %45, %72 : tensor<32768x32xf32>
    %74 = stablehlo.subtract %71, %73 : tensor<32768x32xf32>
    %cst_16 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %75 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %76 = stablehlo.divide %46, %75 : tensor<32768x32xf32>
    %77 = stablehlo.add %74, %76 : tensor<32768x32xf32>
    %cst_17 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %78 = stablehlo.broadcast_in_dim %cst_17, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %79 = stablehlo.divide %13, %78 : tensor<32768x32xf32>
    %cst_18 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %80 = stablehlo.broadcast_in_dim %cst_18, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %81 = stablehlo.subtract %80, %79 : tensor<32768x32xf32>
    %cst_19 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %82 = stablehlo.broadcast_in_dim %cst_19, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %83 = stablehlo.multiply %82, %43 : tensor<32768x32xf32>
    %cst_20 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %84 = stablehlo.broadcast_in_dim %cst_20, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %85 = stablehlo.divide %83, %84 : tensor<32768x32xf32>
    %86 = stablehlo.subtract %81, %85 : tensor<32768x32xf32>
    %cst_21 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %87 = stablehlo.broadcast_in_dim %cst_21, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %88 = stablehlo.multiply %87, %44 : tensor<32768x32xf32>
    %cst_22 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %89 = stablehlo.broadcast_in_dim %cst_22, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %90 = stablehlo.divide %88, %89 : tensor<32768x32xf32>
    %91 = stablehlo.add %86, %90 : tensor<32768x32xf32>
    %cst_23 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %92 = stablehlo.broadcast_in_dim %cst_23, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %93 = stablehlo.divide %45, %92 : tensor<32768x32xf32>
    %94 = stablehlo.add %91, %93 : tensor<32768x32xf32>
    %cst_24 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %95 = stablehlo.broadcast_in_dim %cst_24, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %96 = stablehlo.divide %46, %95 : tensor<32768x32xf32>
    %97 = stablehlo.subtract %94, %96 : tensor<32768x32xf32>
    %cst_25 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %98 = stablehlo.broadcast_in_dim %cst_25, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %99 = stablehlo.multiply %98, %43 : tensor<32768x32xf32>
    %cst_26 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %100 = stablehlo.broadcast_in_dim %cst_26, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %101 = stablehlo.divide %99, %100 : tensor<32768x32xf32>
    %102 = stablehlo.add %13, %101 : tensor<32768x32xf32>
    %cst_27 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %103 = stablehlo.broadcast_in_dim %cst_27, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %104 = stablehlo.multiply %103, %44 : tensor<32768x32xf32>
    %cst_28 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %105 = stablehlo.broadcast_in_dim %cst_28, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %106 = stablehlo.divide %104, %105 : tensor<32768x32xf32>
    %107 = stablehlo.subtract %102, %106 : tensor<32768x32xf32>
    %cst_29 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %108 = stablehlo.broadcast_in_dim %cst_29, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %109 = stablehlo.divide %45, %108 : tensor<32768x32xf32>
    %110 = stablehlo.subtract %107, %109 : tensor<32768x32xf32>
    %cst_30 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %111 = stablehlo.broadcast_in_dim %cst_30, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %112 = stablehlo.divide %46, %111 : tensor<32768x32xf32>
    %113 = stablehlo.add %110, %112 : tensor<32768x32xf32>
    %cst_31 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %114 = stablehlo.broadcast_in_dim %cst_31, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %115 = stablehlo.divide %13, %114 : tensor<32768x32xf32>
    %116 = stablehlo.negate %115 : tensor<32768x32xf32>
    %cst_32 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %117 = stablehlo.broadcast_in_dim %cst_32, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %118 = stablehlo.divide %43, %117 : tensor<32768x32xf32>
    %119 = stablehlo.subtract %116, %118 : tensor<32768x32xf32>
    %cst_33 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %120 = stablehlo.broadcast_in_dim %cst_33, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %121 = stablehlo.multiply %120, %44 : tensor<32768x32xf32>
    %cst_34 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %122 = stablehlo.broadcast_in_dim %cst_34, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %123 = stablehlo.divide %121, %122 : tensor<32768x32xf32>
    %124 = stablehlo.add %119, %123 : tensor<32768x32xf32>
    %cst_35 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %125 = stablehlo.broadcast_in_dim %cst_35, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %126 = stablehlo.divide %45, %125 : tensor<32768x32xf32>
    %127 = stablehlo.add %124, %126 : tensor<32768x32xf32>
    %cst_36 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %128 = stablehlo.broadcast_in_dim %cst_36, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %129 = stablehlo.divide %46, %128 : tensor<32768x32xf32>
    %130 = stablehlo.subtract %127, %129 : tensor<32768x32xf32>
    %cst_37 = stablehlo.constant dense<3.000000e+01> : tensor<f32>
    %131 = stablehlo.broadcast_in_dim %cst_37, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %132 = stablehlo.divide %13, %131 : tensor<32768x32xf32>
    %cst_38 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %133 = stablehlo.broadcast_in_dim %cst_38, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %134 = stablehlo.divide %44, %133 : tensor<32768x32xf32>
    %135 = stablehlo.subtract %132, %134 : tensor<32768x32xf32>
    %cst_39 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %136 = stablehlo.broadcast_in_dim %cst_39, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %137 = stablehlo.divide %46, %136 : tensor<32768x32xf32>
    %138 = stablehlo.add %135, %137 : tensor<32768x32xf32>
    %139 = stablehlo.slice %42 [0:32768, 0:32, 0:1] : (tensor<32768x32x6xf32>) -> tensor<32768x32x1xf32>
    %140 = stablehlo.reshape %139 : (tensor<32768x32x1xf32>) -> tensor<32768x32xf32>
    %141 = stablehlo.multiply %60, %140 : tensor<32768x32xf32>
    %142 = stablehlo.slice %42 [0:32768, 0:32, 1:2] : (tensor<32768x32x6xf32>) -> tensor<32768x32x1xf32>
    %143 = stablehlo.reshape %142 : (tensor<32768x32x1xf32>) -> tensor<32768x32xf32>
    %144 = stablehlo.multiply %77, %143 : tensor<32768x32xf32>
    %145 = stablehlo.add %141, %144 : tensor<32768x32xf32>
    %146 = stablehlo.slice %42 [0:32768, 0:32, 2:3] : (tensor<32768x32x6xf32>) -> tensor<32768x32x1xf32>
    %147 = stablehlo.reshape %146 : (tensor<32768x32x1xf32>) -> tensor<32768x32xf32>
    %148 = stablehlo.multiply %97, %147 : tensor<32768x32xf32>
    %149 = stablehlo.add %145, %148 : tensor<32768x32xf32>
    %150 = stablehlo.slice %42 [0:32768, 0:32, 3:4] : (tensor<32768x32x6xf32>) -> tensor<32768x32x1xf32>
    %151 = stablehlo.reshape %150 : (tensor<32768x32x1xf32>) -> tensor<32768x32xf32>
    %152 = stablehlo.multiply %113, %151 : tensor<32768x32xf32>
    %153 = stablehlo.add %149, %152 : tensor<32768x32xf32>
    %154 = stablehlo.slice %42 [0:32768, 0:32, 4:5] : (tensor<32768x32x6xf32>) -> tensor<32768x32x1xf32>
    %155 = stablehlo.reshape %154 : (tensor<32768x32x1xf32>) -> tensor<32768x32xf32>
    %156 = stablehlo.multiply %130, %155 : tensor<32768x32xf32>
    %157 = stablehlo.add %153, %156 : tensor<32768x32xf32>
    %158 = stablehlo.slice %42 [0:32768, 0:32, 5:6] : (tensor<32768x32x6xf32>) -> tensor<32768x32x1xf32>
    %159 = stablehlo.reshape %158 : (tensor<32768x32x1xf32>) -> tensor<32768x32xf32>
    %160 = stablehlo.multiply %138, %159 : tensor<32768x32xf32>
    %161 = stablehlo.add %157, %160 : tensor<32768x32xf32>
    return %161 : tensor<32768x32xf32>
  }
  func.func private @clip(%arg0: tensor<32768x32x6xi32>, %arg1: tensor<i32>, %arg2: tensor<i32>) -> tensor<32768x32x6xi32> {
    %0 = stablehlo.convert %arg1 : tensor<i32>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<i32>) -> tensor<32768x32x6xi32>
    %2 = stablehlo.maximum %1, %arg0 : tensor<32768x32x6xi32>
    %3 = stablehlo.convert %arg2 : tensor<i32>
    %4 = stablehlo.broadcast_in_dim %3, dims = [] : (tensor<i32>) -> tensor<32768x32x6xi32>
    %5 = stablehlo.minimum %4, %2 : tensor<32768x32x6xi32>
    return %5 : tensor<32768x32x6xi32>
  }
  func.func private @_where_57(%arg0: tensor<32768x32x6xi1>, %arg1: tensor<32768x32x6xf32>, %arg2: tensor<f32>) -> tensor<32768x32x6xf32> {
    %0 = stablehlo.convert %arg2 : tensor<f32>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f32>) -> tensor<32768x32x6xf32>
    %2 = stablehlo.select %arg0, %arg1, %1 : tensor<32768x32x6xi1>, tensor<32768x32x6xf32>
    return %2 : tensor<32768x32x6xf32>
  }
}
