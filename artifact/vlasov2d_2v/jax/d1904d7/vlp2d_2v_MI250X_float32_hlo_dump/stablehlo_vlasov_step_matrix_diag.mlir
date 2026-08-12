module @jit__lambda attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<32x32x32x32xf32>) -> (tensor<32x32x32x32xf32> {jax.result_info = "result[0]"}, tensor<32x32xf32> {jax.result_info = "result[1]"}, tensor<32x32xf32> {jax.result_info = "result[2]"}) {
    %cst = stablehlo.constant dense<[-5.000000e+00, -4.67741966, -4.35483837, -4.03225803, -3.7096777, -3.38709712, -3.06451607, -2.74193525, -2.41935492, -2.09677458, -1.77419376, -1.45161271, -1.12903225, -0.806451797, -0.483870983, -0.161290407, 0.161290169, 0.483870745, 0.80645132, 1.12903225, 1.45161259, 1.77419317, 2.0967741, 2.41935468, 2.74193525, 3.06451583, 3.38709641, 3.70967722, 4.03225803, 4.35483837, 4.67741871, 5.000000e+00]> : tensor<32xf32>
    %c = stablehlo.constant dense<[-2, -1, 0, 1, 2, 3]> : tensor<6xi32>
    %cst_0 = stablehlo.constant dense<[-5.000000e+00, -4.67741966, -4.35483837, -4.03225803, -3.7096777, -3.38709712, -3.06451607, -2.74193525, -2.41935492, -2.09677458, -1.77419376, -1.45161271, -1.12903225, -0.806451797, -0.483870983, -0.161290407, 0.161290169, 0.483870745, 0.80645132, 1.12903225, 1.45161259, 1.77419317, 2.0967741, 2.41935468, 2.74193525, 3.06451583, 3.38709641, 3.70967722, 4.03225803, 4.35483837, 4.67741871, 5.000000e+00]> : tensor<32xf32>
    %cst_1 = stablehlo.constant dense<[[0.000000e+00], [5.000000e-01], [1.000000e+00], [1.500000e+00], [2.000000e+00], [2.500000e+00], [3.000000e+00], [3.500000e+00], [4.000000e+00], [4.500000e+00], [5.000000e+00], [5.500000e+00], [6.000000e+00], [6.50000048], [7.000000e+00], [7.500000e+00], [-8.000000e+00], [-7.500000e+00], [-7.000000e+00], [-6.50000048], [-6.000000e+00], [-5.500000e+00], [-5.000000e+00], [-4.500000e+00], [-4.000000e+00], [-3.500000e+00], [-3.000000e+00], [-2.500000e+00], [-2.000000e+00], [-1.500000e+00], [-1.000000e+00], [-5.000000e-01]]> : tensor<32x1xf32>
    %cst_2 = stablehlo.constant dense<[[0.000000e+00, 5.000000e-01, 1.000000e+00, 1.500000e+00, 2.000000e+00, 2.500000e+00, 3.000000e+00, 3.500000e+00, 4.000000e+00, 4.500000e+00, 5.000000e+00, 5.500000e+00, 6.000000e+00, 6.50000048, 7.000000e+00, 7.500000e+00, 8.000000e+00]]> : tensor<1x17xf32>
    %cst_3 = stablehlo.constant dense<"0x00000000000080400000803F398EE33E0000803E0AD7233E398EE33D052FA73D0000803D88454A3D0AD7233DAB67073D398EE33CBAE4C13C052FA73CB4A2913C0000803C0000804000000040CDCC4C3FCDCCCC3EF1F0703ED9891D3EC967DD3D0AD7A33DC10F7C3D0CCE473DC337223D8A4B063D78FCE13CBEC0C03CC455A63CBCFD903CFF007F3C0000803FCDCC4C3F0000003FD9899D3ECDCC4C3ECB3D0D3ECDCCCC3DE8909A3DF1F0703DC1C0403DD9891D3D6F12033DC967DD3C0E69BD3C0AD7A33C7A178F3CC10F7C3C398EE33ECDCCCC3ED9899D3E398E633E0AD7233EF1F0F03D610BB63DCB3D8D3D3870603D610B363DDA4F163DC10FFC3C812BD63C0117B83C0AD89F3CC1088C3C404E773C0000803EF1F0703ECDCC4C3E0AD7233E0000003E0CCEC73DD9899D3DC10F7C3DCDCC4C3D3FE8283DCB3D0D3DB72EEF3CCDCCCC3CD21FB13CE8909A3C81F7873CF1F0703C0AD7233ED9891D3ECB3D0D3EF1F0F03D0CCEC73D0AD7A33D8A4B863DC9675D3D0317383DE8901A3D6F12033D3870E03CBCE4C13C3EE8A83C8145943C6F12833C6539693C398EE33DC967DD3DCDCCCC3D610BB63DD9899D3D8A4B863D398E633DC1C0403D0AD7233DC1080C3DF1F0F03CA0B6D03C610BB63C08D89F3CCB3D8D3C85187B3C3870603C052FA73D0AD7A33DE8909A3DCB3D8D3DC10F7C3DC9675D3DC1C0403D052F273DBCFD103DC10FFC3C62EBDB3CC1C0C03C4AC8A93CD94F963C37BF853CB72E6F3C44DF563C0000803DC10F7C3DF1F0703D3870603DCDCC4C3D0317383D0AD7233DBCFD103D0000003D78FCE13C0CCEC73CD41FB13CD9899D3C9BA28C3CC10F7C3CA7C4623CCDCC4C3C88454A3D0CCE473DC1C0403D610B363D3FE8283DE8901A3DC1080C3DC10FFC3C78FCE13C8845CA3CE709B53CC337A23CB4A2913C6E12833C91976C3C812B563C0678423C0AD7233DC337223DD9891D3DDA4F163DCB3D0D3D6F12033DF1F0F03C62EBDB3C0CCEC73CE709B53C0AD7A33C8145943C8A4B863CD3A0733CC9675D3C34A6493C0317383CAB67073D8A4B063D6F12033DC10FFC3CB72EEF3C3870E03CA0B6D03CC1C0C03CD41FB13CC337A23C8145943CAB67873C404E773C76FC613CF9BC4E3C10693D3CE6D52D3C398EE33C78FCE13CC967DD3C812BD63CCDCCCC3CBCE4C13C610BB63C4AC8A93CD9899D3CB4A2913C8A4B863C404E773C398E633C5361513CC1C0403CB69A313C0AD7233CBAE4C13CBEC0C03C0E69BD3C0117B83CD21FB13C3EE8A83C08D89F3CD94F963C9BA28C3C6E12833CD3A0733C76FC613C5361513CBAE4413CF98C333CC355263CCD331A3C052FA73CC455A63C0AD7A33C0AD89F3CE8909A3C8145943CCB3D8D3C37BF853CC10F7C3C91976C3CC9675D3CF9BC4E3CC1C0403CF98C333C052F273CDFAA1B3CBCFD103CB4A2913CBCFD903C7A178F3CC1088C3C81F7873C6F12833C85187B3CB72E6F3CA7C4623C812B563C34A6493C10693D3CB69A313CC355263CDFAA1B3CB4A2113CDE3F083C0000803CFF007F3CC10F7C3C404E773CF1F0703C6539693C3870603C44DF563CCDCC4C3C0678423C0317383CE6D52D3C0AD7233CCD331A3CBCFD103CDE3F083C0000003CB4A2913CBCFD903C7A178F3CC1088C3C81F7873C6F12833C85187B3CB72E6F3CA7C4623C812B563C34A6493C10693D3CB69A313CC355263CDFAA1B3CB4A2113CDE3F083C052FA73CC455A63C0AD7A33C0AD89F3CE8909A3C8145943CCB3D8D3C37BF853CC10F7C3C91976C3CC9675D3CF9BC4E3CC1C0403CF98C333C052F273CDFAA1B3CBCFD103CBAE4C13CBEC0C03C0E69BD3C0117B83CD21FB13C3EE8A83C08D89F3CD94F963C9BA28C3C6E12833CD3A0733C76FC613C5361513CBAE4413CF98C333CC355263CCD331A3C398EE33C78FCE13CC967DD3C812BD63CCDCCCC3CBCE4C13C610BB63C4AC8A93CD9899D3CB4A2913C8A4B863C404E773C398E633C5361513CC1C0403CB69A313C0AD7233CAB67073D8A4B063D6F12033DC10FFC3CB72EEF3C3870E03CA0B6D03CC1C0C03CD41FB13CC337A23C8145943CAB67873C404E773C76FC613CF9BC4E3C10693D3CE6D52D3C0AD7233DC337223DD9891D3DDA4F163DCB3D0D3D6F12033DF1F0F03C62EBDB3C0CCEC73CE709B53C0AD7A33C8145943C8A4B863CD3A0733CC9675D3C34A6493C0317383C88454A3D0CCE473DC1C0403D610B363D3FE8283DE8901A3DC1080C3DC10FFC3C78FCE13C8845CA3CE709B53CC337A23CB4A2913C6E12833C91976C3C812B563C0678423C0000803DC10F7C3DF1F0703D3870603DCDCC4C3D0317383D0AD7233DBCFD103D0000003D78FCE13C0CCEC73CD41FB13CD9899D3C9BA28C3CC10F7C3CA7C4623CCDCC4C3C052FA73D0AD7A33DE8909A3DCB3D8D3DC10F7C3DC9675D3DC1C0403D052F273DBCFD103DC10FFC3C62EBDB3CC1C0C03C4AC8A93CD94F963C37BF853CB72E6F3C44DF563C398EE33DC967DD3DCDCCCC3D610BB63DD9899D3D8A4B863D398E633DC1C0403D0AD7233DC1080C3DF1F0F03CA0B6D03C610BB63C08D89F3CCB3D8D3C85187B3C3870603C0AD7233ED9891D3ECB3D0D3EF1F0F03D0CCEC73D0AD7A33D8A4B863DC9675D3D0317383DE8901A3D6F12033D3870E03CBCE4C13C3EE8A83C8145943C6F12833C6539693C0000803EF1F0703ECDCC4C3E0AD7233E0000003E0CCEC73DD9899D3DC10F7C3DCDCC4C3D3FE8283DCB3D0D3DB72EEF3CCDCCCC3CD21FB13CE8909A3C81F7873CF1F0703C398EE33ECDCCCC3ED9899D3E398E633E0AD7233EF1F0F03D610BB63DCB3D8D3D3870603D610B363DDA4F163DC10FFC3C812BD63C0117B83C0AD89F3CC1088C3C404E773C0000803FCDCC4C3F0000003FD9899D3ECDCC4C3ECB3D0D3ECDCCCC3DE8909A3DF1F0703DC1C0403DD9891D3D6F12033DC967DD3C0E69BD3C0AD7A33C7A178F3CC10F7C3C0000804000000040CDCC4C3FCDCCCC3EF1F0703ED9891D3EC967DD3D0AD7A33DC10F7C3D0CCE473DC337223D8A4B063D78FCE13CBEC0C03CC455A63CBCFD903CFF007F3C"> : tensor<32x17xf32>
    %0 = stablehlo.broadcast_in_dim %cst, dims = [1] : (tensor<32xf32>) -> tensor<1x32x1xf32>
    %1 = stablehlo.transpose %arg0, dims = [1, 2, 3, 0] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %2 = stablehlo.reshape %1 : (tensor<32x32x32x32xf32>) -> tensor<32768x32xf32>
    %3 = stablehlo.broadcast_in_dim %0, dims = [0, 1, 2] : (tensor<1x32x1xf32>) -> tensor<32x32x32xf32>
    %4 = stablehlo.reshape %3 : (tensor<32x32x32xf32>) -> tensor<32768xf32>
    %cst_4 = stablehlo.constant dense<2.500000e-02> : tensor<f32>
    %cst_5 = stablehlo.constant dense<0.392699093> : tensor<f32>
    %5 = call @advect_1d_roll_diag(%2, %4, %cst_4, %cst_5, %c) : (tensor<32768x32xf32>, tensor<32768xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<32768x32xf32>
    %6 = stablehlo.reshape %5 : (tensor<32768x32xf32>) -> tensor<32x32x32x32xf32>
    %7 = stablehlo.transpose %6, dims = [3, 0, 1, 2] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %8 = stablehlo.broadcast_in_dim %cst_0, dims = [2] : (tensor<32xf32>) -> tensor<1x1x32xf32>
    %9 = stablehlo.transpose %7, dims = [0, 2, 3, 1] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %10 = stablehlo.reshape %9 : (tensor<32x32x32x32xf32>) -> tensor<32768x32xf32>
    %11 = stablehlo.broadcast_in_dim %8, dims = [0, 1, 2] : (tensor<1x1x32xf32>) -> tensor<32x32x32xf32>
    %12 = stablehlo.reshape %11 : (tensor<32x32x32xf32>) -> tensor<32768xf32>
    %cst_6 = stablehlo.constant dense<2.500000e-02> : tensor<f32>
    %cst_7 = stablehlo.constant dense<0.392699093> : tensor<f32>
    %13 = call @advect_1d_roll_diag(%10, %12, %cst_6, %cst_7, %c) : (tensor<32768x32xf32>, tensor<32768xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<32768x32xf32>
    %14 = stablehlo.reshape %13 : (tensor<32768x32xf32>) -> tensor<32x32x32x32xf32>
    %15 = stablehlo.transpose %14, dims = [0, 3, 1, 2] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %cst_8 = stablehlo.constant dense<0.322580636> : tensor<f32>
    %cst_9 = stablehlo.constant dense<0.322580636> : tensor<f32>
    %16:4 = call @solve_poisson(%15, %cst_1, %cst_2, %cst_3, %cst_8, %cst_9) : (tensor<32x32x32x32xf32>, tensor<32x1xf32>, tensor<1x17xf32>, tensor<32x17xf32>, tensor<f32>, tensor<f32>) -> (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>)
    %17 = stablehlo.broadcast_in_dim %16#0, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1xf32>
    %18 = stablehlo.transpose %15, dims = [0, 1, 3, 2] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %19 = stablehlo.reshape %18 : (tensor<32x32x32x32xf32>) -> tensor<32768x32xf32>
    %20 = stablehlo.broadcast_in_dim %17, dims = [0, 1, 2] : (tensor<32x32x1xf32>) -> tensor<32x32x32xf32>
    %21 = stablehlo.reshape %20 : (tensor<32x32x32xf32>) -> tensor<32768xf32>
    %cst_10 = stablehlo.constant dense<5.000000e-02> : tensor<f32>
    %cst_11 = stablehlo.constant dense<0.322580636> : tensor<f32>
    %22 = call @advect_1d_roll_diag_54(%19, %21, %cst_10, %cst_11, %c) : (tensor<32768x32xf32>, tensor<32768xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<32768x32xf32>
    %23 = stablehlo.reshape %22 : (tensor<32768x32xf32>) -> tensor<32x32x32x32xf32>
    %24 = stablehlo.transpose %23, dims = [0, 1, 3, 2] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %25 = stablehlo.broadcast_in_dim %16#1, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1xf32>
    %26 = stablehlo.reshape %24 : (tensor<32x32x32x32xf32>) -> tensor<32768x32xf32>
    %27 = stablehlo.broadcast_in_dim %25, dims = [0, 1, 2] : (tensor<32x32x1xf32>) -> tensor<32x32x32xf32>
    %28 = stablehlo.reshape %27 : (tensor<32x32x32xf32>) -> tensor<32768xf32>
    %cst_12 = stablehlo.constant dense<5.000000e-02> : tensor<f32>
    %cst_13 = stablehlo.constant dense<0.322580636> : tensor<f32>
    %29 = call @advect_1d_roll_diag_54(%26, %28, %cst_12, %cst_13, %c) : (tensor<32768x32xf32>, tensor<32768xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<32768x32xf32>
    %30 = stablehlo.reshape %29 : (tensor<32768x32xf32>) -> tensor<32x32x32x32xf32>
    %31 = stablehlo.broadcast_in_dim %cst_0, dims = [2] : (tensor<32xf32>) -> tensor<1x1x32xf32>
    %32 = stablehlo.transpose %30, dims = [0, 2, 3, 1] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %33 = stablehlo.reshape %32 : (tensor<32x32x32x32xf32>) -> tensor<32768x32xf32>
    %34 = stablehlo.broadcast_in_dim %31, dims = [0, 1, 2] : (tensor<1x1x32xf32>) -> tensor<32x32x32xf32>
    %35 = stablehlo.reshape %34 : (tensor<32x32x32xf32>) -> tensor<32768xf32>
    %cst_14 = stablehlo.constant dense<2.500000e-02> : tensor<f32>
    %cst_15 = stablehlo.constant dense<0.392699093> : tensor<f32>
    %36 = call @advect_1d_roll_diag(%33, %35, %cst_14, %cst_15, %c) : (tensor<32768x32xf32>, tensor<32768xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<32768x32xf32>
    %37 = stablehlo.reshape %36 : (tensor<32768x32xf32>) -> tensor<32x32x32x32xf32>
    %38 = stablehlo.transpose %37, dims = [0, 3, 1, 2] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %39 = stablehlo.broadcast_in_dim %cst, dims = [1] : (tensor<32xf32>) -> tensor<1x32x1xf32>
    %40 = stablehlo.transpose %38, dims = [1, 2, 3, 0] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %41 = stablehlo.reshape %40 : (tensor<32x32x32x32xf32>) -> tensor<32768x32xf32>
    %42 = stablehlo.broadcast_in_dim %39, dims = [0, 1, 2] : (tensor<1x32x1xf32>) -> tensor<32x32x32xf32>
    %43 = stablehlo.reshape %42 : (tensor<32x32x32xf32>) -> tensor<32768xf32>
    %cst_16 = stablehlo.constant dense<2.500000e-02> : tensor<f32>
    %cst_17 = stablehlo.constant dense<0.392699093> : tensor<f32>
    %44 = call @advect_1d_roll_diag(%41, %43, %cst_16, %cst_17, %c) : (tensor<32768x32xf32>, tensor<32768xf32>, tensor<f32>, tensor<f32>, tensor<6xi32>) -> tensor<32768x32xf32>
    %45 = stablehlo.reshape %44 : (tensor<32768x32xf32>) -> tensor<32x32x32x32xf32>
    %46 = stablehlo.transpose %45, dims = [3, 0, 1, 2] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %46, %16#2, %16#3 : tensor<32x32x32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>
  }
  func.func private @advect_1d_roll_diag(%arg0: tensor<32768x32xf32>, %arg1: tensor<32768xf32>, %arg2: tensor<f32>, %arg3: tensor<f32>, %arg4: tensor<6xi32>) -> tensor<32768x32xf32> {
    %0 = stablehlo.convert %arg2 : tensor<f32>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %2 = stablehlo.multiply %arg1, %1 : tensor<32768xf32>
    %3 = stablehlo.convert %arg3 : tensor<f32>
    %4 = stablehlo.broadcast_in_dim %3, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %5 = stablehlo.divide %2, %4 : tensor<32768xf32>
    %6 = stablehlo.floor %5 : tensor<32768xf32>
    %7 = stablehlo.subtract %5, %6 : tensor<32768xf32>
    %8 = stablehlo.convert %6 : (tensor<32768xf32>) -> tensor<32768xi32>
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %9 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %10 = stablehlo.multiply %7, %7 : tensor<32768xf32>
    %11 = stablehlo.multiply %10, %7 : tensor<32768xf32>
    %12 = stablehlo.multiply %11, %7 : tensor<32768xf32>
    %13 = stablehlo.multiply %12, %7 : tensor<32768xf32>
    %cst_0 = stablehlo.constant dense<2.000000e+01> : tensor<f32>
    %14 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %15 = stablehlo.divide %7, %14 : tensor<32768xf32>
    %cst_1 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %16 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %17 = stablehlo.divide %10, %16 : tensor<32768xf32>
    %18 = stablehlo.subtract %15, %17 : tensor<32768xf32>
    %cst_2 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %19 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %20 = stablehlo.divide %11, %19 : tensor<32768xf32>
    %21 = stablehlo.subtract %18, %20 : tensor<32768xf32>
    %cst_3 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %22 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %23 = stablehlo.divide %12, %22 : tensor<32768xf32>
    %24 = stablehlo.add %21, %23 : tensor<32768xf32>
    %cst_4 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %25 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %26 = stablehlo.divide %13, %25 : tensor<32768xf32>
    %27 = stablehlo.subtract %24, %26 : tensor<32768xf32>
    %cst_5 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %28 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %29 = stablehlo.divide %7, %28 : tensor<32768xf32>
    %30 = stablehlo.negate %29 : tensor<32768xf32>
    %cst_6 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %31 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %32 = stablehlo.multiply %31, %10 : tensor<32768xf32>
    %cst_7 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %33 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %34 = stablehlo.divide %32, %33 : tensor<32768xf32>
    %35 = stablehlo.add %30, %34 : tensor<32768xf32>
    %cst_8 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %36 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %37 = stablehlo.divide %11, %36 : tensor<32768xf32>
    %38 = stablehlo.subtract %35, %37 : tensor<32768xf32>
    %cst_9 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %39 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %40 = stablehlo.divide %12, %39 : tensor<32768xf32>
    %41 = stablehlo.subtract %38, %40 : tensor<32768xf32>
    %cst_10 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %42 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %43 = stablehlo.divide %13, %42 : tensor<32768xf32>
    %44 = stablehlo.add %41, %43 : tensor<32768xf32>
    %cst_11 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %45 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %46 = stablehlo.divide %7, %45 : tensor<32768xf32>
    %cst_12 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %47 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %48 = stablehlo.subtract %47, %46 : tensor<32768xf32>
    %cst_13 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %49 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %50 = stablehlo.multiply %49, %10 : tensor<32768xf32>
    %cst_14 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %51 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %52 = stablehlo.divide %50, %51 : tensor<32768xf32>
    %53 = stablehlo.subtract %48, %52 : tensor<32768xf32>
    %cst_15 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %54 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %55 = stablehlo.multiply %54, %11 : tensor<32768xf32>
    %cst_16 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %56 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %57 = stablehlo.divide %55, %56 : tensor<32768xf32>
    %58 = stablehlo.add %53, %57 : tensor<32768xf32>
    %cst_17 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %59 = stablehlo.broadcast_in_dim %cst_17, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %60 = stablehlo.divide %12, %59 : tensor<32768xf32>
    %61 = stablehlo.add %58, %60 : tensor<32768xf32>
    %cst_18 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %62 = stablehlo.broadcast_in_dim %cst_18, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %63 = stablehlo.divide %13, %62 : tensor<32768xf32>
    %64 = stablehlo.subtract %61, %63 : tensor<32768xf32>
    %cst_19 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %65 = stablehlo.broadcast_in_dim %cst_19, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %66 = stablehlo.multiply %65, %10 : tensor<32768xf32>
    %cst_20 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %67 = stablehlo.broadcast_in_dim %cst_20, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %68 = stablehlo.divide %66, %67 : tensor<32768xf32>
    %69 = stablehlo.add %7, %68 : tensor<32768xf32>
    %cst_21 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %70 = stablehlo.broadcast_in_dim %cst_21, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %71 = stablehlo.multiply %70, %11 : tensor<32768xf32>
    %cst_22 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %72 = stablehlo.broadcast_in_dim %cst_22, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %73 = stablehlo.divide %71, %72 : tensor<32768xf32>
    %74 = stablehlo.subtract %69, %73 : tensor<32768xf32>
    %cst_23 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %75 = stablehlo.broadcast_in_dim %cst_23, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %76 = stablehlo.divide %12, %75 : tensor<32768xf32>
    %77 = stablehlo.subtract %74, %76 : tensor<32768xf32>
    %cst_24 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %78 = stablehlo.broadcast_in_dim %cst_24, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %79 = stablehlo.divide %13, %78 : tensor<32768xf32>
    %80 = stablehlo.add %77, %79 : tensor<32768xf32>
    %cst_25 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %81 = stablehlo.broadcast_in_dim %cst_25, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %82 = stablehlo.divide %7, %81 : tensor<32768xf32>
    %83 = stablehlo.negate %82 : tensor<32768xf32>
    %cst_26 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %84 = stablehlo.broadcast_in_dim %cst_26, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %85 = stablehlo.divide %10, %84 : tensor<32768xf32>
    %86 = stablehlo.subtract %83, %85 : tensor<32768xf32>
    %cst_27 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %87 = stablehlo.broadcast_in_dim %cst_27, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %88 = stablehlo.multiply %87, %11 : tensor<32768xf32>
    %cst_28 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %89 = stablehlo.broadcast_in_dim %cst_28, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %90 = stablehlo.divide %88, %89 : tensor<32768xf32>
    %91 = stablehlo.add %86, %90 : tensor<32768xf32>
    %cst_29 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %92 = stablehlo.broadcast_in_dim %cst_29, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %93 = stablehlo.divide %12, %92 : tensor<32768xf32>
    %94 = stablehlo.add %91, %93 : tensor<32768xf32>
    %cst_30 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %95 = stablehlo.broadcast_in_dim %cst_30, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %96 = stablehlo.divide %13, %95 : tensor<32768xf32>
    %97 = stablehlo.subtract %94, %96 : tensor<32768xf32>
    %cst_31 = stablehlo.constant dense<3.000000e+01> : tensor<f32>
    %98 = stablehlo.broadcast_in_dim %cst_31, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %99 = stablehlo.divide %7, %98 : tensor<32768xf32>
    %cst_32 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %100 = stablehlo.broadcast_in_dim %cst_32, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %101 = stablehlo.divide %11, %100 : tensor<32768xf32>
    %102 = stablehlo.subtract %99, %101 : tensor<32768xf32>
    %cst_33 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %103 = stablehlo.broadcast_in_dim %cst_33, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %104 = stablehlo.divide %13, %103 : tensor<32768xf32>
    %105 = stablehlo.add %102, %104 : tensor<32768xf32>
    %106 = stablehlo.broadcast_in_dim %27, dims = [1] : (tensor<32768xf32>) -> tensor<1x32768xf32>
    %107 = stablehlo.broadcast_in_dim %44, dims = [1] : (tensor<32768xf32>) -> tensor<1x32768xf32>
    %108 = stablehlo.broadcast_in_dim %64, dims = [1] : (tensor<32768xf32>) -> tensor<1x32768xf32>
    %109 = stablehlo.broadcast_in_dim %80, dims = [1] : (tensor<32768xf32>) -> tensor<1x32768xf32>
    %110 = stablehlo.broadcast_in_dim %97, dims = [1] : (tensor<32768xf32>) -> tensor<1x32768xf32>
    %111 = stablehlo.broadcast_in_dim %105, dims = [1] : (tensor<32768xf32>) -> tensor<1x32768xf32>
    %112 = stablehlo.concatenate %106, %107, %108, %109, %110, %111, dim = 0 : (tensor<1x32768xf32>, tensor<1x32768xf32>, tensor<1x32768xf32>, tensor<1x32768xf32>, tensor<1x32768xf32>, tensor<1x32768xf32>) -> tensor<6x32768xf32>
    %113 = stablehlo.slice %arg4 [0:1] : (tensor<6xi32>) -> tensor<1xi32>
    %114 = stablehlo.reshape %113 : (tensor<1xi32>) -> tensor<i32>
    %115 = stablehlo.broadcast_in_dim %114, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %116 = stablehlo.add %8, %115 : tensor<32768xi32>
    %117 = call @_roll_dynamic(%arg0, %116) : (tensor<32768x32xf32>, tensor<32768xi32>) -> tensor<32768x32xf32>
    %118 = stablehlo.slice %112 [0:1, 0:32768] : (tensor<6x32768xf32>) -> tensor<1x32768xf32>
    %119 = stablehlo.reshape %118 : (tensor<1x32768xf32>) -> tensor<32768xf32>
    %120 = stablehlo.broadcast_in_dim %119, dims = [0] : (tensor<32768xf32>) -> tensor<32768x1xf32>
    %121 = stablehlo.broadcast_in_dim %120, dims = [0, 1] : (tensor<32768x1xf32>) -> tensor<32768x32xf32>
    %122 = stablehlo.multiply %117, %121 : tensor<32768x32xf32>
    %123 = stablehlo.add %9, %122 : tensor<32768x32xf32>
    %124 = stablehlo.slice %arg4 [1:2] : (tensor<6xi32>) -> tensor<1xi32>
    %125 = stablehlo.reshape %124 : (tensor<1xi32>) -> tensor<i32>
    %126 = stablehlo.broadcast_in_dim %125, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %127 = stablehlo.add %8, %126 : tensor<32768xi32>
    %128 = call @_roll_dynamic(%arg0, %127) : (tensor<32768x32xf32>, tensor<32768xi32>) -> tensor<32768x32xf32>
    %129 = stablehlo.slice %112 [1:2, 0:32768] : (tensor<6x32768xf32>) -> tensor<1x32768xf32>
    %130 = stablehlo.reshape %129 : (tensor<1x32768xf32>) -> tensor<32768xf32>
    %131 = stablehlo.broadcast_in_dim %130, dims = [0] : (tensor<32768xf32>) -> tensor<32768x1xf32>
    %132 = stablehlo.broadcast_in_dim %131, dims = [0, 1] : (tensor<32768x1xf32>) -> tensor<32768x32xf32>
    %133 = stablehlo.multiply %128, %132 : tensor<32768x32xf32>
    %134 = stablehlo.add %123, %133 : tensor<32768x32xf32>
    %135 = stablehlo.slice %arg4 [2:3] : (tensor<6xi32>) -> tensor<1xi32>
    %136 = stablehlo.reshape %135 : (tensor<1xi32>) -> tensor<i32>
    %137 = stablehlo.broadcast_in_dim %136, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %138 = stablehlo.add %8, %137 : tensor<32768xi32>
    %139 = call @_roll_dynamic(%arg0, %138) : (tensor<32768x32xf32>, tensor<32768xi32>) -> tensor<32768x32xf32>
    %140 = stablehlo.slice %112 [2:3, 0:32768] : (tensor<6x32768xf32>) -> tensor<1x32768xf32>
    %141 = stablehlo.reshape %140 : (tensor<1x32768xf32>) -> tensor<32768xf32>
    %142 = stablehlo.broadcast_in_dim %141, dims = [0] : (tensor<32768xf32>) -> tensor<32768x1xf32>
    %143 = stablehlo.broadcast_in_dim %142, dims = [0, 1] : (tensor<32768x1xf32>) -> tensor<32768x32xf32>
    %144 = stablehlo.multiply %139, %143 : tensor<32768x32xf32>
    %145 = stablehlo.add %134, %144 : tensor<32768x32xf32>
    %146 = stablehlo.slice %arg4 [3:4] : (tensor<6xi32>) -> tensor<1xi32>
    %147 = stablehlo.reshape %146 : (tensor<1xi32>) -> tensor<i32>
    %148 = stablehlo.broadcast_in_dim %147, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %149 = stablehlo.add %8, %148 : tensor<32768xi32>
    %150 = call @_roll_dynamic(%arg0, %149) : (tensor<32768x32xf32>, tensor<32768xi32>) -> tensor<32768x32xf32>
    %151 = stablehlo.slice %112 [3:4, 0:32768] : (tensor<6x32768xf32>) -> tensor<1x32768xf32>
    %152 = stablehlo.reshape %151 : (tensor<1x32768xf32>) -> tensor<32768xf32>
    %153 = stablehlo.broadcast_in_dim %152, dims = [0] : (tensor<32768xf32>) -> tensor<32768x1xf32>
    %154 = stablehlo.broadcast_in_dim %153, dims = [0, 1] : (tensor<32768x1xf32>) -> tensor<32768x32xf32>
    %155 = stablehlo.multiply %150, %154 : tensor<32768x32xf32>
    %156 = stablehlo.add %145, %155 : tensor<32768x32xf32>
    %157 = stablehlo.slice %arg4 [4:5] : (tensor<6xi32>) -> tensor<1xi32>
    %158 = stablehlo.reshape %157 : (tensor<1xi32>) -> tensor<i32>
    %159 = stablehlo.broadcast_in_dim %158, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %160 = stablehlo.add %8, %159 : tensor<32768xi32>
    %161 = call @_roll_dynamic(%arg0, %160) : (tensor<32768x32xf32>, tensor<32768xi32>) -> tensor<32768x32xf32>
    %162 = stablehlo.slice %112 [4:5, 0:32768] : (tensor<6x32768xf32>) -> tensor<1x32768xf32>
    %163 = stablehlo.reshape %162 : (tensor<1x32768xf32>) -> tensor<32768xf32>
    %164 = stablehlo.broadcast_in_dim %163, dims = [0] : (tensor<32768xf32>) -> tensor<32768x1xf32>
    %165 = stablehlo.broadcast_in_dim %164, dims = [0, 1] : (tensor<32768x1xf32>) -> tensor<32768x32xf32>
    %166 = stablehlo.multiply %161, %165 : tensor<32768x32xf32>
    %167 = stablehlo.add %156, %166 : tensor<32768x32xf32>
    %168 = stablehlo.slice %arg4 [5:6] : (tensor<6xi32>) -> tensor<1xi32>
    %169 = stablehlo.reshape %168 : (tensor<1xi32>) -> tensor<i32>
    %170 = stablehlo.broadcast_in_dim %169, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %171 = stablehlo.add %8, %170 : tensor<32768xi32>
    %172 = call @_roll_dynamic(%arg0, %171) : (tensor<32768x32xf32>, tensor<32768xi32>) -> tensor<32768x32xf32>
    %173 = stablehlo.slice %112 [5:6, 0:32768] : (tensor<6x32768xf32>) -> tensor<1x32768xf32>
    %174 = stablehlo.reshape %173 : (tensor<1x32768xf32>) -> tensor<32768xf32>
    %175 = stablehlo.broadcast_in_dim %174, dims = [0] : (tensor<32768xf32>) -> tensor<32768x1xf32>
    %176 = stablehlo.broadcast_in_dim %175, dims = [0, 1] : (tensor<32768x1xf32>) -> tensor<32768x32xf32>
    %177 = stablehlo.multiply %172, %176 : tensor<32768x32xf32>
    %178 = stablehlo.add %167, %177 : tensor<32768x32xf32>
    return %178 : tensor<32768x32xf32>
  }
  func.func private @_roll_dynamic(%arg0: tensor<32768x32xf32>, %arg1: tensor<32768xi32>) -> tensor<32768x32xf32> {
    %0 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<32768xi32>) -> tensor<32768x1xi32>
    %1 = stablehlo.slice %0 [0:32768, 0:1] : (tensor<32768x1xi32>) -> tensor<32768x1xi32>
    %2 = stablehlo.reshape %1 : (tensor<32768x1xi32>) -> tensor<32768xi32>
    %c = stablehlo.constant dense<32> : tensor<i32>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %3 = stablehlo.maximum %c, %c_0 : tensor<i32>
    %4 = call @remainder(%2, %3) : (tensor<32768xi32>, tensor<i32>) -> tensor<32768xi32>
    %5 = stablehlo.concatenate %arg0, %arg0, dim = 1 : (tensor<32768x32xf32>, tensor<32768x32xf32>) -> tensor<32768x64xf32>
    %c_1 = stablehlo.constant dense<32> : tensor<i32>
    %6 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %7 = stablehlo.subtract %6, %4 : tensor<32768xi32>
    %c_2 = stablehlo.constant dense<0> : tensor<i32>
    %8 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %9 = stablehlo.compare  LT, %7, %8,  SIGNED : (tensor<32768xi32>, tensor<32768xi32>) -> tensor<32768xi1>
    %c_3 = stablehlo.constant dense<64> : tensor<i32>
    %10 = stablehlo.broadcast_in_dim %c_3, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %11 = stablehlo.add %7, %10 : tensor<32768xi32>
    %12 = stablehlo.select %9, %11, %7 : tensor<32768xi1>, tensor<32768xi32>
    %13 = stablehlo.broadcast_in_dim %12, dims = [0] : (tensor<32768xi32>) -> tensor<32768x1xi32>
    %14 = "stablehlo.gather"(%5, %13) <{dimension_numbers = #stablehlo.gather<offset_dims = [1], operand_batching_dims = [0], start_indices_batching_dims = [0], start_index_map = [1], index_vector_dim = 1>, indices_are_sorted = true, slice_sizes = array<i64: 1, 32>}> : (tensor<32768x64xf32>, tensor<32768x1xi32>) -> tensor<32768x32xf32>
    return %14 : tensor<32768x32xf32>
  }
  func.func private @remainder(%arg0: tensor<32768xi32>, %arg1: tensor<i32>) -> tensor<32768xi32> {
    %c = stablehlo.constant dense<0> : tensor<i32>
    %0 = stablehlo.compare  EQ, %arg1, %c,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %1 = call @_where(%0, %c_0, %arg1) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
    %2 = stablehlo.broadcast_in_dim %1, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %3 = stablehlo.remainder %arg0, %2 : tensor<32768xi32>
    %c_1 = stablehlo.constant dense<0> : tensor<i32>
    %4 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %5 = stablehlo.compare  NE, %3, %4,  SIGNED : (tensor<32768xi32>, tensor<32768xi32>) -> tensor<32768xi1>
    %c_2 = stablehlo.constant dense<0> : tensor<i32>
    %6 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %7 = stablehlo.compare  LT, %3, %6,  SIGNED : (tensor<32768xi32>, tensor<32768xi32>) -> tensor<32768xi1>
    %c_3 = stablehlo.constant dense<0> : tensor<i32>
    %8 = stablehlo.compare  LT, %1, %c_3,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %9 = stablehlo.broadcast_in_dim %8, dims = [] : (tensor<i1>) -> tensor<32768xi1>
    %10 = stablehlo.compare  NE, %7, %9,  UNSIGNED : (tensor<32768xi1>, tensor<32768xi1>) -> tensor<32768xi1>
    %11 = stablehlo.and %10, %5 : tensor<32768xi1>
    %12 = stablehlo.broadcast_in_dim %1, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %13 = stablehlo.add %3, %12 : tensor<32768xi32>
    %14 = stablehlo.select %11, %13, %3 : tensor<32768xi1>, tensor<32768xi32>
    return %14 : tensor<32768xi32>
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
    %12 = call @fft_43(%11) : (tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32>
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
    %23 = call @fft_43(%17) : (tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32>
    %24 = call @fft_43(%22) : (tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32>
    return %23, %24, %8, %12 : tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>
  }
  func.func private @fft(%arg0: tensor<32x32xf32>) -> tensor<32x17xcomplex<f32>> {
    %0 = stablehlo.fft %arg0, type =  RFFT, length = [32, 32] : (tensor<32x32xf32>) -> tensor<32x17xcomplex<f32>>
    return %0 : tensor<32x17xcomplex<f32>>
  }
  func.func private @fft_43(%arg0: tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32> {
    %0 = stablehlo.fft %arg0, type =  IRFFT, length = [32, 32] : (tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32>
    return %0 : tensor<32x32xf32>
  }
  func.func private @advect_1d_roll_diag_54(%arg0: tensor<32768x32xf32>, %arg1: tensor<32768xf32>, %arg2: tensor<f32>, %arg3: tensor<f32>, %arg4: tensor<6xi32>) -> tensor<32768x32xf32> {
    %0 = stablehlo.convert %arg2 : tensor<f32>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %2 = stablehlo.multiply %arg1, %1 : tensor<32768xf32>
    %3 = stablehlo.convert %arg3 : tensor<f32>
    %4 = stablehlo.broadcast_in_dim %3, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %5 = stablehlo.divide %2, %4 : tensor<32768xf32>
    %6 = stablehlo.floor %5 : tensor<32768xf32>
    %7 = stablehlo.subtract %5, %6 : tensor<32768xf32>
    %8 = stablehlo.convert %6 : (tensor<32768xf32>) -> tensor<32768xi32>
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %9 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f32>) -> tensor<32768x32xf32>
    %10 = call @build_v_diag_weights(%arg4, %8, %7) : (tensor<6xi32>, tensor<32768xi32>, tensor<32768xf32>) -> tensor<6x32768x32xf32>
    %11 = stablehlo.slice %arg4 [0:1] : (tensor<6xi32>) -> tensor<1xi32>
    %12 = stablehlo.reshape %11 : (tensor<1xi32>) -> tensor<i32>
    %13 = stablehlo.broadcast_in_dim %12, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %14 = stablehlo.add %8, %13 : tensor<32768xi32>
    %15 = call @_roll_dynamic(%arg0, %14) : (tensor<32768x32xf32>, tensor<32768xi32>) -> tensor<32768x32xf32>
    %16 = stablehlo.slice %10 [0:1, 0:32768, 0:32] : (tensor<6x32768x32xf32>) -> tensor<1x32768x32xf32>
    %17 = stablehlo.reshape %16 : (tensor<1x32768x32xf32>) -> tensor<32768x32xf32>
    %18 = stablehlo.multiply %17, %15 : tensor<32768x32xf32>
    %19 = stablehlo.add %9, %18 : tensor<32768x32xf32>
    %20 = stablehlo.slice %arg4 [1:2] : (tensor<6xi32>) -> tensor<1xi32>
    %21 = stablehlo.reshape %20 : (tensor<1xi32>) -> tensor<i32>
    %22 = stablehlo.broadcast_in_dim %21, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %23 = stablehlo.add %8, %22 : tensor<32768xi32>
    %24 = call @_roll_dynamic(%arg0, %23) : (tensor<32768x32xf32>, tensor<32768xi32>) -> tensor<32768x32xf32>
    %25 = stablehlo.slice %10 [1:2, 0:32768, 0:32] : (tensor<6x32768x32xf32>) -> tensor<1x32768x32xf32>
    %26 = stablehlo.reshape %25 : (tensor<1x32768x32xf32>) -> tensor<32768x32xf32>
    %27 = stablehlo.multiply %26, %24 : tensor<32768x32xf32>
    %28 = stablehlo.add %19, %27 : tensor<32768x32xf32>
    %29 = stablehlo.slice %arg4 [2:3] : (tensor<6xi32>) -> tensor<1xi32>
    %30 = stablehlo.reshape %29 : (tensor<1xi32>) -> tensor<i32>
    %31 = stablehlo.broadcast_in_dim %30, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %32 = stablehlo.add %8, %31 : tensor<32768xi32>
    %33 = call @_roll_dynamic(%arg0, %32) : (tensor<32768x32xf32>, tensor<32768xi32>) -> tensor<32768x32xf32>
    %34 = stablehlo.slice %10 [2:3, 0:32768, 0:32] : (tensor<6x32768x32xf32>) -> tensor<1x32768x32xf32>
    %35 = stablehlo.reshape %34 : (tensor<1x32768x32xf32>) -> tensor<32768x32xf32>
    %36 = stablehlo.multiply %35, %33 : tensor<32768x32xf32>
    %37 = stablehlo.add %28, %36 : tensor<32768x32xf32>
    %38 = stablehlo.slice %arg4 [3:4] : (tensor<6xi32>) -> tensor<1xi32>
    %39 = stablehlo.reshape %38 : (tensor<1xi32>) -> tensor<i32>
    %40 = stablehlo.broadcast_in_dim %39, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %41 = stablehlo.add %8, %40 : tensor<32768xi32>
    %42 = call @_roll_dynamic(%arg0, %41) : (tensor<32768x32xf32>, tensor<32768xi32>) -> tensor<32768x32xf32>
    %43 = stablehlo.slice %10 [3:4, 0:32768, 0:32] : (tensor<6x32768x32xf32>) -> tensor<1x32768x32xf32>
    %44 = stablehlo.reshape %43 : (tensor<1x32768x32xf32>) -> tensor<32768x32xf32>
    %45 = stablehlo.multiply %44, %42 : tensor<32768x32xf32>
    %46 = stablehlo.add %37, %45 : tensor<32768x32xf32>
    %47 = stablehlo.slice %arg4 [4:5] : (tensor<6xi32>) -> tensor<1xi32>
    %48 = stablehlo.reshape %47 : (tensor<1xi32>) -> tensor<i32>
    %49 = stablehlo.broadcast_in_dim %48, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %50 = stablehlo.add %8, %49 : tensor<32768xi32>
    %51 = call @_roll_dynamic(%arg0, %50) : (tensor<32768x32xf32>, tensor<32768xi32>) -> tensor<32768x32xf32>
    %52 = stablehlo.slice %10 [4:5, 0:32768, 0:32] : (tensor<6x32768x32xf32>) -> tensor<1x32768x32xf32>
    %53 = stablehlo.reshape %52 : (tensor<1x32768x32xf32>) -> tensor<32768x32xf32>
    %54 = stablehlo.multiply %53, %51 : tensor<32768x32xf32>
    %55 = stablehlo.add %46, %54 : tensor<32768x32xf32>
    %56 = stablehlo.slice %arg4 [5:6] : (tensor<6xi32>) -> tensor<1xi32>
    %57 = stablehlo.reshape %56 : (tensor<1xi32>) -> tensor<i32>
    %58 = stablehlo.broadcast_in_dim %57, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %59 = stablehlo.add %8, %58 : tensor<32768xi32>
    %60 = call @_roll_dynamic(%arg0, %59) : (tensor<32768x32xf32>, tensor<32768xi32>) -> tensor<32768x32xf32>
    %61 = stablehlo.slice %10 [5:6, 0:32768, 0:32] : (tensor<6x32768x32xf32>) -> tensor<1x32768x32xf32>
    %62 = stablehlo.reshape %61 : (tensor<1x32768x32xf32>) -> tensor<32768x32xf32>
    %63 = stablehlo.multiply %62, %60 : tensor<32768x32xf32>
    %64 = stablehlo.add %55, %63 : tensor<32768x32xf32>
    return %64 : tensor<32768x32xf32>
  }
  func.func private @build_v_diag_weights(%arg0: tensor<6xi32>, %arg1: tensor<32768xi32>, %arg2: tensor<32768xf32>) -> tensor<6x32768x32xf32> {
    %0 = stablehlo.multiply %arg2, %arg2 : tensor<32768xf32>
    %1 = stablehlo.multiply %0, %arg2 : tensor<32768xf32>
    %2 = stablehlo.multiply %1, %arg2 : tensor<32768xf32>
    %3 = stablehlo.multiply %2, %arg2 : tensor<32768xf32>
    %cst = stablehlo.constant dense<2.000000e+01> : tensor<f32>
    %4 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %5 = stablehlo.divide %arg2, %4 : tensor<32768xf32>
    %cst_0 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %6 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %7 = stablehlo.divide %0, %6 : tensor<32768xf32>
    %8 = stablehlo.subtract %5, %7 : tensor<32768xf32>
    %cst_1 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %9 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %10 = stablehlo.divide %1, %9 : tensor<32768xf32>
    %11 = stablehlo.subtract %8, %10 : tensor<32768xf32>
    %cst_2 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %12 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %13 = stablehlo.divide %2, %12 : tensor<32768xf32>
    %14 = stablehlo.add %11, %13 : tensor<32768xf32>
    %cst_3 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %15 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %16 = stablehlo.divide %3, %15 : tensor<32768xf32>
    %17 = stablehlo.subtract %14, %16 : tensor<32768xf32>
    %cst_4 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %18 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %19 = stablehlo.divide %arg2, %18 : tensor<32768xf32>
    %20 = stablehlo.negate %19 : tensor<32768xf32>
    %cst_5 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %21 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %22 = stablehlo.multiply %21, %0 : tensor<32768xf32>
    %cst_6 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %23 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %24 = stablehlo.divide %22, %23 : tensor<32768xf32>
    %25 = stablehlo.add %20, %24 : tensor<32768xf32>
    %cst_7 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %26 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %27 = stablehlo.divide %1, %26 : tensor<32768xf32>
    %28 = stablehlo.subtract %25, %27 : tensor<32768xf32>
    %cst_8 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %29 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %30 = stablehlo.divide %2, %29 : tensor<32768xf32>
    %31 = stablehlo.subtract %28, %30 : tensor<32768xf32>
    %cst_9 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %32 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %33 = stablehlo.divide %3, %32 : tensor<32768xf32>
    %34 = stablehlo.add %31, %33 : tensor<32768xf32>
    %cst_10 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %35 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %36 = stablehlo.divide %arg2, %35 : tensor<32768xf32>
    %cst_11 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %37 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %38 = stablehlo.subtract %37, %36 : tensor<32768xf32>
    %cst_12 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %39 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %40 = stablehlo.multiply %39, %0 : tensor<32768xf32>
    %cst_13 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %41 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %42 = stablehlo.divide %40, %41 : tensor<32768xf32>
    %43 = stablehlo.subtract %38, %42 : tensor<32768xf32>
    %cst_14 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %44 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %45 = stablehlo.multiply %44, %1 : tensor<32768xf32>
    %cst_15 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %46 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %47 = stablehlo.divide %45, %46 : tensor<32768xf32>
    %48 = stablehlo.add %43, %47 : tensor<32768xf32>
    %cst_16 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %49 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %50 = stablehlo.divide %2, %49 : tensor<32768xf32>
    %51 = stablehlo.add %48, %50 : tensor<32768xf32>
    %cst_17 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %52 = stablehlo.broadcast_in_dim %cst_17, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %53 = stablehlo.divide %3, %52 : tensor<32768xf32>
    %54 = stablehlo.subtract %51, %53 : tensor<32768xf32>
    %cst_18 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %55 = stablehlo.broadcast_in_dim %cst_18, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %56 = stablehlo.multiply %55, %0 : tensor<32768xf32>
    %cst_19 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %57 = stablehlo.broadcast_in_dim %cst_19, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %58 = stablehlo.divide %56, %57 : tensor<32768xf32>
    %59 = stablehlo.add %arg2, %58 : tensor<32768xf32>
    %cst_20 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %60 = stablehlo.broadcast_in_dim %cst_20, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %61 = stablehlo.multiply %60, %1 : tensor<32768xf32>
    %cst_21 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %62 = stablehlo.broadcast_in_dim %cst_21, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %63 = stablehlo.divide %61, %62 : tensor<32768xf32>
    %64 = stablehlo.subtract %59, %63 : tensor<32768xf32>
    %cst_22 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %65 = stablehlo.broadcast_in_dim %cst_22, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %66 = stablehlo.divide %2, %65 : tensor<32768xf32>
    %67 = stablehlo.subtract %64, %66 : tensor<32768xf32>
    %cst_23 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %68 = stablehlo.broadcast_in_dim %cst_23, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %69 = stablehlo.divide %3, %68 : tensor<32768xf32>
    %70 = stablehlo.add %67, %69 : tensor<32768xf32>
    %cst_24 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %71 = stablehlo.broadcast_in_dim %cst_24, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %72 = stablehlo.divide %arg2, %71 : tensor<32768xf32>
    %73 = stablehlo.negate %72 : tensor<32768xf32>
    %cst_25 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %74 = stablehlo.broadcast_in_dim %cst_25, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %75 = stablehlo.divide %0, %74 : tensor<32768xf32>
    %76 = stablehlo.subtract %73, %75 : tensor<32768xf32>
    %cst_26 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %77 = stablehlo.broadcast_in_dim %cst_26, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %78 = stablehlo.multiply %77, %1 : tensor<32768xf32>
    %cst_27 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %79 = stablehlo.broadcast_in_dim %cst_27, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %80 = stablehlo.divide %78, %79 : tensor<32768xf32>
    %81 = stablehlo.add %76, %80 : tensor<32768xf32>
    %cst_28 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %82 = stablehlo.broadcast_in_dim %cst_28, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %83 = stablehlo.divide %2, %82 : tensor<32768xf32>
    %84 = stablehlo.add %81, %83 : tensor<32768xf32>
    %cst_29 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %85 = stablehlo.broadcast_in_dim %cst_29, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %86 = stablehlo.divide %3, %85 : tensor<32768xf32>
    %87 = stablehlo.subtract %84, %86 : tensor<32768xf32>
    %cst_30 = stablehlo.constant dense<3.000000e+01> : tensor<f32>
    %88 = stablehlo.broadcast_in_dim %cst_30, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %89 = stablehlo.divide %arg2, %88 : tensor<32768xf32>
    %cst_31 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %90 = stablehlo.broadcast_in_dim %cst_31, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %91 = stablehlo.divide %1, %90 : tensor<32768xf32>
    %92 = stablehlo.subtract %89, %91 : tensor<32768xf32>
    %cst_32 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %93 = stablehlo.broadcast_in_dim %cst_32, dims = [] : (tensor<f32>) -> tensor<32768xf32>
    %94 = stablehlo.divide %3, %93 : tensor<32768xf32>
    %95 = stablehlo.add %92, %94 : tensor<32768xf32>
    %96 = stablehlo.broadcast_in_dim %17, dims = [1] : (tensor<32768xf32>) -> tensor<1x32768xf32>
    %97 = stablehlo.broadcast_in_dim %34, dims = [1] : (tensor<32768xf32>) -> tensor<1x32768xf32>
    %98 = stablehlo.broadcast_in_dim %54, dims = [1] : (tensor<32768xf32>) -> tensor<1x32768xf32>
    %99 = stablehlo.broadcast_in_dim %70, dims = [1] : (tensor<32768xf32>) -> tensor<1x32768xf32>
    %100 = stablehlo.broadcast_in_dim %87, dims = [1] : (tensor<32768xf32>) -> tensor<1x32768xf32>
    %101 = stablehlo.broadcast_in_dim %95, dims = [1] : (tensor<32768xf32>) -> tensor<1x32768xf32>
    %102 = stablehlo.concatenate %96, %97, %98, %99, %100, %101, dim = 0 : (tensor<1x32768xf32>, tensor<1x32768xf32>, tensor<1x32768xf32>, tensor<1x32768xf32>, tensor<1x32768xf32>, tensor<1x32768xf32>) -> tensor<6x32768xf32>
    %103 = stablehlo.iota dim = 0 : tensor<32xi32>
    %104 = stablehlo.broadcast_in_dim %arg0, dims = [0] : (tensor<6xi32>) -> tensor<6x1xi32>
    %105 = stablehlo.broadcast_in_dim %arg1, dims = [1] : (tensor<32768xi32>) -> tensor<1x32768xi32>
    %106 = stablehlo.broadcast_in_dim %104, dims = [0, 1] : (tensor<6x1xi32>) -> tensor<6x32768xi32>
    %107 = stablehlo.broadcast_in_dim %105, dims = [0, 1] : (tensor<1x32768xi32>) -> tensor<6x32768xi32>
    %108 = stablehlo.add %106, %107 : tensor<6x32768xi32>
    %109 = stablehlo.broadcast_in_dim %103, dims = [2] : (tensor<32xi32>) -> tensor<1x1x32xi32>
    %110 = stablehlo.broadcast_in_dim %108, dims = [0, 1] : (tensor<6x32768xi32>) -> tensor<6x32768x1xi32>
    %111 = stablehlo.broadcast_in_dim %109, dims = [0, 1, 2] : (tensor<1x1x32xi32>) -> tensor<6x32768x32xi32>
    %112 = stablehlo.broadcast_in_dim %110, dims = [0, 1, 2] : (tensor<6x32768x1xi32>) -> tensor<6x32768x32xi32>
    %113 = stablehlo.subtract %111, %112 : tensor<6x32768x32xi32>
    %c = stablehlo.constant dense<0> : tensor<i32>
    %114 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<6x32768x32xi32>
    %115 = stablehlo.compare  GE, %113, %114,  SIGNED : (tensor<6x32768x32xi32>, tensor<6x32768x32xi32>) -> tensor<6x32768x32xi1>
    %c_33 = stablehlo.constant dense<32> : tensor<i32>
    %116 = stablehlo.broadcast_in_dim %c_33, dims = [] : (tensor<i32>) -> tensor<6x32768x32xi32>
    %117 = stablehlo.compare  LT, %113, %116,  SIGNED : (tensor<6x32768x32xi32>, tensor<6x32768x32xi32>) -> tensor<6x32768x32xi1>
    %118 = stablehlo.and %115, %117 : tensor<6x32768x32xi1>
    %119 = stablehlo.broadcast_in_dim %102, dims = [0, 1] : (tensor<6x32768xf32>) -> tensor<6x32768x1xf32>
    %cst_34 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %120 = call @_where_64(%118, %119, %cst_34) : (tensor<6x32768x32xi1>, tensor<6x32768x1xf32>, tensor<f32>) -> tensor<6x32768x32xf32>
    return %120 : tensor<6x32768x32xf32>
  }
  func.func private @_where_64(%arg0: tensor<6x32768x32xi1>, %arg1: tensor<6x32768x1xf32>, %arg2: tensor<f32>) -> tensor<6x32768x32xf32> {
    %0 = stablehlo.convert %arg2 : tensor<f32>
    %1 = stablehlo.broadcast_in_dim %arg1, dims = [0, 1, 2] : (tensor<6x32768x1xf32>) -> tensor<6x32768x32xf32>
    %2 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f32>) -> tensor<6x32768x32xf32>
    %3 = stablehlo.select %arg0, %1, %2 : tensor<6x32768x32xi1>, tensor<6x32768x32xf32>
    return %3 : tensor<6x32768x32xf32>
  }
}
