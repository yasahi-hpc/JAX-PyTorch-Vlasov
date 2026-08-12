module @jit__lambda attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<32x32x32x32xf32>) -> (tensor<32x32x32x32xf32> {jax.result_info = "result[0]"}, tensor<32x32xf32> {jax.result_info = "result[1]"}, tensor<32x32xf32> {jax.result_info = "result[2]"}) {
    %cst = stablehlo.constant dense<[0.681690097, 0.702226221, 0.722762346, 0.74329847, 0.763834595, 0.78437072, 0.804906845, 0.825442969, 0.845979094, 0.866515159, 0.887051344, 0.907587468, 0.928123593, 0.948659658, 0.969195842, 0.989731907, 0.0102680512, 0.0308041684, 0.0513402857, 0.071876429, 0.0924125239, 0.112948641, 0.133484781, 0.154020905, 0.174557015, 0.19509314, 0.21562925, 0.236165375, 0.256701529, 0.277237624, 0.297773719, 0.318309873]> : tensor<32xf32>
    %cst_0 = stablehlo.constant dense<[0.681690097, 0.702226221, 0.722762346, 0.74329847, 0.763834595, 0.78437072, 0.804906845, 0.825442969, 0.845979094, 0.866515159, 0.887051344, 0.907587468, 0.928123593, 0.948659658, 0.969195842, 0.989731907, 0.0102680512, 0.0308041684, 0.0513402857, 0.071876429, 0.0924125239, 0.112948641, 0.133484781, 0.154020905, 0.174557015, 0.19509314, 0.21562925, 0.236165375, 0.256701529, 0.277237624, 0.297773719, 0.318309873]> : tensor<32xf32>
    %cst_1 = stablehlo.constant dense<[[0.000000e+00], [5.000000e-01], [1.000000e+00], [1.49999988], [2.000000e+00], [2.500000e+00], [2.99999976], [3.500000e+00], [4.000000e+00], [4.500000e+00], [5.000000e+00], [5.500000e+00], [5.99999952], [6.49999952], [7.000000e+00], [7.500000e+00], [-8.000000e+00], [-7.500000e+00], [-7.000000e+00], [-6.49999952], [-5.99999952], [-5.500000e+00], [-5.000000e+00], [-4.500000e+00], [-4.000000e+00], [-3.500000e+00], [-2.99999976], [-2.500000e+00], [-2.000000e+00], [-1.49999988], [-1.000000e+00], [-5.000000e-01]]> : tensor<32x1xf32>
    %cst_2 = stablehlo.constant dense<[[0.000000e+00, 5.000000e-01, 1.000000e+00, 1.49999988, 2.000000e+00, 2.500000e+00, 2.99999976, 3.500000e+00, 4.000000e+00, 4.500000e+00, 5.000000e+00, 5.500000e+00, 5.99999952, 6.49999952, 7.000000e+00, 7.500000e+00, 8.000000e+00]]> : tensor<1x17xf32>
    %cst_3 = stablehlo.constant dense<"0x00000000000080400000803F3B8EE33E0000803E0AD7233E3B8EE33D062FA73D0000803D89454A3D0AD7233DAB67073D3B8EE33CBEE4C13C062FA73CB4A2913C0000803C0000804000000040CDCC4C3FCFCCCC3EF1F0703ED9891D3ECA67DD3D0AD7A33DC10F7C3D0CCE473DC337223D8A4B063D7AFCE13CC3C0C03CC455A63CBCFD903CFF007F3C0000803FCDCC4C3F0000003FDA899D3ECDCC4C3ECB3D0D3ECFCCCC3DE8909A3DF1F0703DC1C0403DD9891D3D6F12033DCA67DD3C1269BD3C0AD7A33C7A178F3CC10F7C3C3B8EE33ECFCCCC3EDA899D3E3B8E633E0AD7233EF1F0F03D620BB63DCB3D8D3D3970603D610B363DDB4F163DC10FFC3C822BD63C0517B83C0AD89F3CC1088C3C3F4E773C0000803EF1F0703ECDCC4C3E0AD7233E0000003E0CCEC73DDA899D3DC10F7C3DCDCC4C3D3FE8283DCB3D0D3DB72EEF3CCFCCCC3CD61FB13CE8909A3C80F7873CF1F0703C0AD7233ED9891D3ECB3D0D3EF1F0F03D0CCEC73D0AD7A33D8B4B863DC9675D3D0317383DE8901A3D6F12033D3970E03CBDE4C13C41E8A83C8045943C6F12833C6539693C3B8EE33DCA67DD3DCFCCCC3D620BB63DDA899D3D8B4B863D3B8E633DC1C0403D0AD7233DC1080C3DF1F0F03CA0B6D03C620BB63C0BD89F3CCB3D8D3C85187B3C3970603C062FA73D0AD7A33DE8909A3DCB3D8D3DC10F7C3DC9675D3DC1C0403D062F273DBCFD103DC10FFC3C62EBDB3CC1C0C03C4BC8A93CDC4F963C37BF853CB72E6F3C44DF563C0000803DC10F7C3DF1F0703D3970603DCDCC4C3D0317383D0AD7233DBCFD103D0000003D78FCE13C0CCEC73CD31FB13CDA899D3C9DA28C3CC10F7C3CA7C4623CCDCC4C3C89454A3D0CCE473DC1C0403D610B363D3FE8283DE8901A3DC1080C3DC10FFC3C78FCE13C8945CA3CE709B53CC337A23CB4A2913C7012833C92976C3C812B563C0678423C0AD7233DC337223DD9891D3DDB4F163DCB3D0D3D6F12033DF1F0F03C62EBDB3C0CCEC73CE709B53C0AD7A33C8045943C8B4B863CD7A0733CC9675D3C35A6493C0317383CAB67073D8A4B063D6F12033DC10FFC3CB72EEF3C3970E03CA0B6D03CC1C0C03CD31FB13CC337A23C8045943CAB67873C3F4E773C7AFC613CF9BC4E3C10693D3CE6D52D3C3B8EE33C7AFCE13CCA67DD3C822BD63CCFCCCC3CBDE4C13C620BB63C4BC8A93CDA899D3CB4A2913C8B4B863C3F4E773C3B8E633C5761513CC1C0403CB59A313C0AD7233CBEE4C13CC3C0C03C1269BD3C0517B83CD61FB13C41E8A83C0BD89F3CDC4F963C9DA28C3C7012833CD7A0733C7AFC613C5761513CBEE4413CFB8C333CC555263CCE331A3C062FA73CC455A63C0AD7A33C0AD89F3CE8909A3C8045943CCB3D8D3C37BF853CC10F7C3C92976C3CC9675D3CF9BC4E3CC1C0403CFB8C333C062F273CDFAA1B3CBCFD103CB4A2913CBCFD903C7A178F3CC1088C3C80F7873C6F12833C85187B3CB72E6F3CA7C4623C812B563C35A6493C10693D3CB59A313CC555263CDFAA1B3CB4A2113CDD3F083C0000803CFF007F3CC10F7C3C3F4E773CF1F0703C6539693C3970603C44DF563CCDCC4C3C0678423C0317383CE6D52D3C0AD7233CCE331A3CBCFD103CDD3F083C0000003CB4A2913CBCFD903C7A178F3CC1088C3C80F7873C6F12833C85187B3CB72E6F3CA7C4623C812B563C35A6493C10693D3CB59A313CC555263CDFAA1B3CB4A2113CDD3F083C062FA73CC455A63C0AD7A33C0AD89F3CE8909A3C8045943CCB3D8D3C37BF853CC10F7C3C92976C3CC9675D3CF9BC4E3CC1C0403CFB8C333C062F273CDFAA1B3CBCFD103CBEE4C13CC3C0C03C1269BD3C0517B83CD61FB13C41E8A83C0BD89F3CDC4F963C9DA28C3C7012833CD7A0733C7AFC613C5761513CBEE4413CFB8C333CC555263CCE331A3C3B8EE33C7AFCE13CCA67DD3C822BD63CCFCCCC3CBDE4C13C620BB63C4BC8A93CDA899D3CB4A2913C8B4B863C3F4E773C3B8E633C5761513CC1C0403CB59A313C0AD7233CAB67073D8A4B063D6F12033DC10FFC3CB72EEF3C3970E03CA0B6D03CC1C0C03CD31FB13CC337A23C8045943CAB67873C3F4E773C7AFC613CF9BC4E3C10693D3CE6D52D3C0AD7233DC337223DD9891D3DDB4F163DCB3D0D3D6F12033DF1F0F03C62EBDB3C0CCEC73CE709B53C0AD7A33C8045943C8B4B863CD7A0733CC9675D3C35A6493C0317383C89454A3D0CCE473DC1C0403D610B363D3FE8283DE8901A3DC1080C3DC10FFC3C78FCE13C8945CA3CE709B53CC337A23CB4A2913C7012833C92976C3C812B563C0678423C0000803DC10F7C3DF1F0703D3970603DCDCC4C3D0317383D0AD7233DBCFD103D0000003D78FCE13C0CCEC73CD31FB13CDA899D3C9DA28C3CC10F7C3CA7C4623CCDCC4C3C062FA73D0AD7A33DE8909A3DCB3D8D3DC10F7C3DC9675D3DC1C0403D062F273DBCFD103DC10FFC3C62EBDB3CC1C0C03C4BC8A93CDC4F963C37BF853CB72E6F3C44DF563C3B8EE33DCA67DD3DCFCCCC3D620BB63DDA899D3D8B4B863D3B8E633DC1C0403D0AD7233DC1080C3DF1F0F03CA0B6D03C620BB63C0BD89F3CCB3D8D3C85187B3C3970603C0AD7233ED9891D3ECB3D0D3EF1F0F03D0CCEC73D0AD7A33D8B4B863DC9675D3D0317383DE8901A3D6F12033D3970E03CBDE4C13C41E8A83C8045943C6F12833C6539693C0000803EF1F0703ECDCC4C3E0AD7233E0000003E0CCEC73DDA899D3DC10F7C3DCDCC4C3D3FE8283DCB3D0D3DB72EEF3CCFCCCC3CD61FB13CE8909A3C80F7873CF1F0703C3B8EE33ECFCCCC3EDA899D3E3B8E633E0AD7233EF1F0F03D620BB63DCB3D8D3D3970603D610B363DDB4F163DC10FFC3C822BD63C0517B83C0AD89F3CC1088C3C3F4E773C0000803FCDCC4C3F0000003FDA899D3ECDCC4C3ECB3D0D3ECFCCCC3DE8909A3DF1F0703DC1C0403DD9891D3D6F12033DCA67DD3C1269BD3C0AD7A33C7A178F3CC10F7C3C0000804000000040CDCC4C3FCFCCCC3EF1F0703ED9891D3ECA67DD3D0AD7A33DC10F7C3D0CCE473DC337223D8A4B063D7AFCE13CC3C0C03CC455A63CBCFD903CFF007F3C"> : tensor<32x17xf32>
    %0 = stablehlo.multiply %cst, %cst : tensor<32xf32>
    %1 = stablehlo.multiply %0, %cst : tensor<32xf32>
    %2 = stablehlo.multiply %1, %cst : tensor<32xf32>
    %3 = stablehlo.multiply %2, %cst : tensor<32xf32>
    %cst_4 = stablehlo.constant dense<2.000000e+01> : tensor<f32>
    %4 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %5 = stablehlo.divide %cst, %4 : tensor<32xf32>
    %cst_5 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %6 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %7 = stablehlo.divide %0, %6 : tensor<32xf32>
    %8 = stablehlo.subtract %5, %7 : tensor<32xf32>
    %cst_6 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %9 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %10 = stablehlo.divide %1, %9 : tensor<32xf32>
    %11 = stablehlo.subtract %8, %10 : tensor<32xf32>
    %cst_7 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %12 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %13 = stablehlo.divide %2, %12 : tensor<32xf32>
    %14 = stablehlo.add %11, %13 : tensor<32xf32>
    %cst_8 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %15 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %16 = stablehlo.divide %3, %15 : tensor<32xf32>
    %17 = stablehlo.subtract %14, %16 : tensor<32xf32>
    %cst_9 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %18 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %19 = stablehlo.divide %cst, %18 : tensor<32xf32>
    %20 = stablehlo.negate %19 : tensor<32xf32>
    %cst_10 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %21 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %22 = stablehlo.multiply %21, %0 : tensor<32xf32>
    %cst_11 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %23 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %24 = stablehlo.divide %22, %23 : tensor<32xf32>
    %25 = stablehlo.add %20, %24 : tensor<32xf32>
    %cst_12 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %26 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %27 = stablehlo.divide %1, %26 : tensor<32xf32>
    %28 = stablehlo.subtract %25, %27 : tensor<32xf32>
    %cst_13 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %29 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %30 = stablehlo.divide %2, %29 : tensor<32xf32>
    %31 = stablehlo.subtract %28, %30 : tensor<32xf32>
    %cst_14 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %32 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %33 = stablehlo.divide %3, %32 : tensor<32xf32>
    %34 = stablehlo.add %31, %33 : tensor<32xf32>
    %cst_15 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %35 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %36 = stablehlo.divide %cst, %35 : tensor<32xf32>
    %cst_16 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %37 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %38 = stablehlo.subtract %37, %36 : tensor<32xf32>
    %cst_17 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %39 = stablehlo.broadcast_in_dim %cst_17, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %40 = stablehlo.multiply %39, %0 : tensor<32xf32>
    %cst_18 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %41 = stablehlo.broadcast_in_dim %cst_18, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %42 = stablehlo.divide %40, %41 : tensor<32xf32>
    %43 = stablehlo.subtract %38, %42 : tensor<32xf32>
    %cst_19 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %44 = stablehlo.broadcast_in_dim %cst_19, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %45 = stablehlo.multiply %44, %1 : tensor<32xf32>
    %cst_20 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %46 = stablehlo.broadcast_in_dim %cst_20, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %47 = stablehlo.divide %45, %46 : tensor<32xf32>
    %48 = stablehlo.add %43, %47 : tensor<32xf32>
    %cst_21 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %49 = stablehlo.broadcast_in_dim %cst_21, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %50 = stablehlo.divide %2, %49 : tensor<32xf32>
    %51 = stablehlo.add %48, %50 : tensor<32xf32>
    %cst_22 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %52 = stablehlo.broadcast_in_dim %cst_22, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %53 = stablehlo.divide %3, %52 : tensor<32xf32>
    %54 = stablehlo.subtract %51, %53 : tensor<32xf32>
    %cst_23 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %55 = stablehlo.broadcast_in_dim %cst_23, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %56 = stablehlo.multiply %55, %0 : tensor<32xf32>
    %cst_24 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %57 = stablehlo.broadcast_in_dim %cst_24, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %58 = stablehlo.divide %56, %57 : tensor<32xf32>
    %59 = stablehlo.add %cst, %58 : tensor<32xf32>
    %cst_25 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %60 = stablehlo.broadcast_in_dim %cst_25, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %61 = stablehlo.multiply %60, %1 : tensor<32xf32>
    %cst_26 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %62 = stablehlo.broadcast_in_dim %cst_26, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %63 = stablehlo.divide %61, %62 : tensor<32xf32>
    %64 = stablehlo.subtract %59, %63 : tensor<32xf32>
    %cst_27 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %65 = stablehlo.broadcast_in_dim %cst_27, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %66 = stablehlo.divide %2, %65 : tensor<32xf32>
    %67 = stablehlo.subtract %64, %66 : tensor<32xf32>
    %cst_28 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %68 = stablehlo.broadcast_in_dim %cst_28, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %69 = stablehlo.divide %3, %68 : tensor<32xf32>
    %70 = stablehlo.add %67, %69 : tensor<32xf32>
    %cst_29 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %71 = stablehlo.broadcast_in_dim %cst_29, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %72 = stablehlo.divide %cst, %71 : tensor<32xf32>
    %73 = stablehlo.negate %72 : tensor<32xf32>
    %cst_30 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %74 = stablehlo.broadcast_in_dim %cst_30, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %75 = stablehlo.divide %0, %74 : tensor<32xf32>
    %76 = stablehlo.subtract %73, %75 : tensor<32xf32>
    %cst_31 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %77 = stablehlo.broadcast_in_dim %cst_31, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %78 = stablehlo.multiply %77, %1 : tensor<32xf32>
    %cst_32 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %79 = stablehlo.broadcast_in_dim %cst_32, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %80 = stablehlo.divide %78, %79 : tensor<32xf32>
    %81 = stablehlo.add %76, %80 : tensor<32xf32>
    %cst_33 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %82 = stablehlo.broadcast_in_dim %cst_33, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %83 = stablehlo.divide %2, %82 : tensor<32xf32>
    %84 = stablehlo.add %81, %83 : tensor<32xf32>
    %cst_34 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %85 = stablehlo.broadcast_in_dim %cst_34, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %86 = stablehlo.divide %3, %85 : tensor<32xf32>
    %87 = stablehlo.subtract %84, %86 : tensor<32xf32>
    %cst_35 = stablehlo.constant dense<3.000000e+01> : tensor<f32>
    %88 = stablehlo.broadcast_in_dim %cst_35, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %89 = stablehlo.divide %cst, %88 : tensor<32xf32>
    %cst_36 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %90 = stablehlo.broadcast_in_dim %cst_36, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %91 = stablehlo.divide %1, %90 : tensor<32xf32>
    %92 = stablehlo.subtract %89, %91 : tensor<32xf32>
    %cst_37 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %93 = stablehlo.broadcast_in_dim %cst_37, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %94 = stablehlo.divide %3, %93 : tensor<32xf32>
    %95 = stablehlo.add %92, %94 : tensor<32xf32>
    %96 = stablehlo.broadcast_in_dim %17, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %97 = stablehlo.broadcast_in_dim %34, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %98 = stablehlo.broadcast_in_dim %54, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %99 = stablehlo.broadcast_in_dim %70, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %100 = stablehlo.broadcast_in_dim %87, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %101 = stablehlo.broadcast_in_dim %95, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %102 = stablehlo.concatenate %96, %97, %98, %99, %100, %101, dim = 0 : (tensor<1x32xf32>, tensor<1x32xf32>, tensor<1x32xf32>, tensor<1x32xf32>, tensor<1x32xf32>, tensor<1x32xf32>) -> tensor<6x32xf32>
    %103 = stablehlo.multiply %cst_0, %cst_0 : tensor<32xf32>
    %104 = stablehlo.multiply %103, %cst_0 : tensor<32xf32>
    %105 = stablehlo.multiply %104, %cst_0 : tensor<32xf32>
    %106 = stablehlo.multiply %105, %cst_0 : tensor<32xf32>
    %cst_38 = stablehlo.constant dense<2.000000e+01> : tensor<f32>
    %107 = stablehlo.broadcast_in_dim %cst_38, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %108 = stablehlo.divide %cst_0, %107 : tensor<32xf32>
    %cst_39 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %109 = stablehlo.broadcast_in_dim %cst_39, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %110 = stablehlo.divide %103, %109 : tensor<32xf32>
    %111 = stablehlo.subtract %108, %110 : tensor<32xf32>
    %cst_40 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %112 = stablehlo.broadcast_in_dim %cst_40, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %113 = stablehlo.divide %104, %112 : tensor<32xf32>
    %114 = stablehlo.subtract %111, %113 : tensor<32xf32>
    %cst_41 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %115 = stablehlo.broadcast_in_dim %cst_41, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %116 = stablehlo.divide %105, %115 : tensor<32xf32>
    %117 = stablehlo.add %114, %116 : tensor<32xf32>
    %cst_42 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %118 = stablehlo.broadcast_in_dim %cst_42, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %119 = stablehlo.divide %106, %118 : tensor<32xf32>
    %120 = stablehlo.subtract %117, %119 : tensor<32xf32>
    %cst_43 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %121 = stablehlo.broadcast_in_dim %cst_43, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %122 = stablehlo.divide %cst_0, %121 : tensor<32xf32>
    %123 = stablehlo.negate %122 : tensor<32xf32>
    %cst_44 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %124 = stablehlo.broadcast_in_dim %cst_44, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %125 = stablehlo.multiply %124, %103 : tensor<32xf32>
    %cst_45 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %126 = stablehlo.broadcast_in_dim %cst_45, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %127 = stablehlo.divide %125, %126 : tensor<32xf32>
    %128 = stablehlo.add %123, %127 : tensor<32xf32>
    %cst_46 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %129 = stablehlo.broadcast_in_dim %cst_46, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %130 = stablehlo.divide %104, %129 : tensor<32xf32>
    %131 = stablehlo.subtract %128, %130 : tensor<32xf32>
    %cst_47 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %132 = stablehlo.broadcast_in_dim %cst_47, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %133 = stablehlo.divide %105, %132 : tensor<32xf32>
    %134 = stablehlo.subtract %131, %133 : tensor<32xf32>
    %cst_48 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %135 = stablehlo.broadcast_in_dim %cst_48, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %136 = stablehlo.divide %106, %135 : tensor<32xf32>
    %137 = stablehlo.add %134, %136 : tensor<32xf32>
    %cst_49 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %138 = stablehlo.broadcast_in_dim %cst_49, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %139 = stablehlo.divide %cst_0, %138 : tensor<32xf32>
    %cst_50 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %140 = stablehlo.broadcast_in_dim %cst_50, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %141 = stablehlo.subtract %140, %139 : tensor<32xf32>
    %cst_51 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %142 = stablehlo.broadcast_in_dim %cst_51, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %143 = stablehlo.multiply %142, %103 : tensor<32xf32>
    %cst_52 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %144 = stablehlo.broadcast_in_dim %cst_52, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %145 = stablehlo.divide %143, %144 : tensor<32xf32>
    %146 = stablehlo.subtract %141, %145 : tensor<32xf32>
    %cst_53 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %147 = stablehlo.broadcast_in_dim %cst_53, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %148 = stablehlo.multiply %147, %104 : tensor<32xf32>
    %cst_54 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %149 = stablehlo.broadcast_in_dim %cst_54, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %150 = stablehlo.divide %148, %149 : tensor<32xf32>
    %151 = stablehlo.add %146, %150 : tensor<32xf32>
    %cst_55 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %152 = stablehlo.broadcast_in_dim %cst_55, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %153 = stablehlo.divide %105, %152 : tensor<32xf32>
    %154 = stablehlo.add %151, %153 : tensor<32xf32>
    %cst_56 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %155 = stablehlo.broadcast_in_dim %cst_56, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %156 = stablehlo.divide %106, %155 : tensor<32xf32>
    %157 = stablehlo.subtract %154, %156 : tensor<32xf32>
    %cst_57 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %158 = stablehlo.broadcast_in_dim %cst_57, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %159 = stablehlo.multiply %158, %103 : tensor<32xf32>
    %cst_58 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %160 = stablehlo.broadcast_in_dim %cst_58, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %161 = stablehlo.divide %159, %160 : tensor<32xf32>
    %162 = stablehlo.add %cst_0, %161 : tensor<32xf32>
    %cst_59 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %163 = stablehlo.broadcast_in_dim %cst_59, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %164 = stablehlo.multiply %163, %104 : tensor<32xf32>
    %cst_60 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %165 = stablehlo.broadcast_in_dim %cst_60, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %166 = stablehlo.divide %164, %165 : tensor<32xf32>
    %167 = stablehlo.subtract %162, %166 : tensor<32xf32>
    %cst_61 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %168 = stablehlo.broadcast_in_dim %cst_61, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %169 = stablehlo.divide %105, %168 : tensor<32xf32>
    %170 = stablehlo.subtract %167, %169 : tensor<32xf32>
    %cst_62 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %171 = stablehlo.broadcast_in_dim %cst_62, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %172 = stablehlo.divide %106, %171 : tensor<32xf32>
    %173 = stablehlo.add %170, %172 : tensor<32xf32>
    %cst_63 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %174 = stablehlo.broadcast_in_dim %cst_63, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %175 = stablehlo.divide %cst_0, %174 : tensor<32xf32>
    %176 = stablehlo.negate %175 : tensor<32xf32>
    %cst_64 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %177 = stablehlo.broadcast_in_dim %cst_64, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %178 = stablehlo.divide %103, %177 : tensor<32xf32>
    %179 = stablehlo.subtract %176, %178 : tensor<32xf32>
    %cst_65 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %180 = stablehlo.broadcast_in_dim %cst_65, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %181 = stablehlo.multiply %180, %104 : tensor<32xf32>
    %cst_66 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %182 = stablehlo.broadcast_in_dim %cst_66, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %183 = stablehlo.divide %181, %182 : tensor<32xf32>
    %184 = stablehlo.add %179, %183 : tensor<32xf32>
    %cst_67 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %185 = stablehlo.broadcast_in_dim %cst_67, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %186 = stablehlo.divide %105, %185 : tensor<32xf32>
    %187 = stablehlo.add %184, %186 : tensor<32xf32>
    %cst_68 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %188 = stablehlo.broadcast_in_dim %cst_68, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %189 = stablehlo.divide %106, %188 : tensor<32xf32>
    %190 = stablehlo.subtract %187, %189 : tensor<32xf32>
    %cst_69 = stablehlo.constant dense<3.000000e+01> : tensor<f32>
    %191 = stablehlo.broadcast_in_dim %cst_69, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %192 = stablehlo.divide %cst_0, %191 : tensor<32xf32>
    %cst_70 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %193 = stablehlo.broadcast_in_dim %cst_70, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %194 = stablehlo.divide %104, %193 : tensor<32xf32>
    %195 = stablehlo.subtract %192, %194 : tensor<32xf32>
    %cst_71 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %196 = stablehlo.broadcast_in_dim %cst_71, dims = [] : (tensor<f32>) -> tensor<32xf32>
    %197 = stablehlo.divide %106, %196 : tensor<32xf32>
    %198 = stablehlo.add %195, %197 : tensor<32xf32>
    %199 = stablehlo.broadcast_in_dim %120, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %200 = stablehlo.broadcast_in_dim %137, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %201 = stablehlo.broadcast_in_dim %157, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %202 = stablehlo.broadcast_in_dim %173, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %203 = stablehlo.broadcast_in_dim %190, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %204 = stablehlo.broadcast_in_dim %198, dims = [1] : (tensor<32xf32>) -> tensor<1x32xf32>
    %205 = stablehlo.concatenate %199, %200, %201, %202, %203, %204, dim = 0 : (tensor<1x32xf32>, tensor<1x32xf32>, tensor<1x32xf32>, tensor<1x32xf32>, tensor<1x32xf32>, tensor<1x32xf32>) -> tensor<6x32xf32>
    %206 = stablehlo.slice %arg0 [0:32, 0:32, 0:16, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x32x16x32xf32>
    %207 = call @_roll_static(%206) : (tensor<32x32x16x32xf32>) -> tensor<32x32x16x32xf32>
    %208 = stablehlo.slice %arg0 [0:32, 0:32, 16:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x32x16x32xf32>
    %209 = call @_roll_static_6(%208) : (tensor<32x32x16x32xf32>) -> tensor<32x32x16x32xf32>
    %210 = stablehlo.concatenate %207, %209, dim = 2 : (tensor<32x32x16x32xf32>, tensor<32x32x16x32xf32>) -> tensor<32x32x32x32xf32>
    %cst_72 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %211 = stablehlo.broadcast_in_dim %cst_72, dims = [] : (tensor<f32>) -> tensor<32x32x32x32xf32>
    %212 = call @_roll_static_12(%210) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %213 = stablehlo.slice %102 [0:1, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %214 = stablehlo.reshape %213 : (tensor<1x32xf32>) -> tensor<32xf32>
    %215 = stablehlo.reshape %214 : (tensor<32xf32>) -> tensor<1x1x32x1xf32>
    %216 = stablehlo.broadcast_in_dim %215, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf32>) -> tensor<32x32x32x32xf32>
    %217 = stablehlo.multiply %212, %216 : tensor<32x32x32x32xf32>
    %218 = stablehlo.add %211, %217 : tensor<32x32x32x32xf32>
    %219 = call @_roll_static_19(%210) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %220 = stablehlo.slice %102 [1:2, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %221 = stablehlo.reshape %220 : (tensor<1x32xf32>) -> tensor<32xf32>
    %222 = stablehlo.reshape %221 : (tensor<32xf32>) -> tensor<1x1x32x1xf32>
    %223 = stablehlo.broadcast_in_dim %222, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf32>) -> tensor<32x32x32x32xf32>
    %224 = stablehlo.multiply %219, %223 : tensor<32x32x32x32xf32>
    %225 = stablehlo.add %218, %224 : tensor<32x32x32x32xf32>
    %226 = call @_roll_static_24(%210) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %227 = stablehlo.slice %102 [2:3, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %228 = stablehlo.reshape %227 : (tensor<1x32xf32>) -> tensor<32xf32>
    %229 = stablehlo.reshape %228 : (tensor<32xf32>) -> tensor<1x1x32x1xf32>
    %230 = stablehlo.broadcast_in_dim %229, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf32>) -> tensor<32x32x32x32xf32>
    %231 = stablehlo.multiply %226, %230 : tensor<32x32x32x32xf32>
    %232 = stablehlo.add %225, %231 : tensor<32x32x32x32xf32>
    %233 = call @_roll_static_29(%210) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %234 = stablehlo.slice %102 [3:4, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %235 = stablehlo.reshape %234 : (tensor<1x32xf32>) -> tensor<32xf32>
    %236 = stablehlo.reshape %235 : (tensor<32xf32>) -> tensor<1x1x32x1xf32>
    %237 = stablehlo.broadcast_in_dim %236, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf32>) -> tensor<32x32x32x32xf32>
    %238 = stablehlo.multiply %233, %237 : tensor<32x32x32x32xf32>
    %239 = stablehlo.add %232, %238 : tensor<32x32x32x32xf32>
    %240 = call @_roll_static_34(%210) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %241 = stablehlo.slice %102 [4:5, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %242 = stablehlo.reshape %241 : (tensor<1x32xf32>) -> tensor<32xf32>
    %243 = stablehlo.reshape %242 : (tensor<32xf32>) -> tensor<1x1x32x1xf32>
    %244 = stablehlo.broadcast_in_dim %243, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf32>) -> tensor<32x32x32x32xf32>
    %245 = stablehlo.multiply %240, %244 : tensor<32x32x32x32xf32>
    %246 = stablehlo.add %239, %245 : tensor<32x32x32x32xf32>
    %247 = call @_roll_static_39(%210) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %248 = stablehlo.slice %102 [5:6, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %249 = stablehlo.reshape %248 : (tensor<1x32xf32>) -> tensor<32xf32>
    %250 = stablehlo.reshape %249 : (tensor<32xf32>) -> tensor<1x1x32x1xf32>
    %251 = stablehlo.broadcast_in_dim %250, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf32>) -> tensor<32x32x32x32xf32>
    %252 = stablehlo.multiply %247, %251 : tensor<32x32x32x32xf32>
    %253 = stablehlo.add %246, %252 : tensor<32x32x32x32xf32>
    %254 = stablehlo.slice %253 [0:32, 0:32, 0:32, 0:16] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x16xf32>
    %255 = call @_roll_static_45(%254) : (tensor<32x32x32x16xf32>) -> tensor<32x32x32x16xf32>
    %256 = stablehlo.slice %253 [0:32, 0:32, 0:32, 16:32] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x16xf32>
    %257 = call @_roll_static_50(%256) : (tensor<32x32x32x16xf32>) -> tensor<32x32x32x16xf32>
    %258 = stablehlo.concatenate %255, %257, dim = 3 : (tensor<32x32x32x16xf32>, tensor<32x32x32x16xf32>) -> tensor<32x32x32x32xf32>
    %cst_73 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %259 = stablehlo.broadcast_in_dim %cst_73, dims = [] : (tensor<f32>) -> tensor<32x32x32x32xf32>
    %260 = call @_roll_static_55(%258) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %261 = stablehlo.slice %205 [0:1, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %262 = stablehlo.reshape %261 : (tensor<1x32xf32>) -> tensor<32xf32>
    %263 = stablehlo.reshape %262 : (tensor<32xf32>) -> tensor<1x1x1x32xf32>
    %264 = stablehlo.broadcast_in_dim %263, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf32>) -> tensor<32x32x32x32xf32>
    %265 = stablehlo.multiply %260, %264 : tensor<32x32x32x32xf32>
    %266 = stablehlo.add %259, %265 : tensor<32x32x32x32xf32>
    %267 = call @_roll_static_61(%258) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %268 = stablehlo.slice %205 [1:2, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %269 = stablehlo.reshape %268 : (tensor<1x32xf32>) -> tensor<32xf32>
    %270 = stablehlo.reshape %269 : (tensor<32xf32>) -> tensor<1x1x1x32xf32>
    %271 = stablehlo.broadcast_in_dim %270, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf32>) -> tensor<32x32x32x32xf32>
    %272 = stablehlo.multiply %267, %271 : tensor<32x32x32x32xf32>
    %273 = stablehlo.add %266, %272 : tensor<32x32x32x32xf32>
    %274 = call @_roll_static_65(%258) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %275 = stablehlo.slice %205 [2:3, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %276 = stablehlo.reshape %275 : (tensor<1x32xf32>) -> tensor<32xf32>
    %277 = stablehlo.reshape %276 : (tensor<32xf32>) -> tensor<1x1x1x32xf32>
    %278 = stablehlo.broadcast_in_dim %277, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf32>) -> tensor<32x32x32x32xf32>
    %279 = stablehlo.multiply %274, %278 : tensor<32x32x32x32xf32>
    %280 = stablehlo.add %273, %279 : tensor<32x32x32x32xf32>
    %281 = call @_roll_static_68(%258) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %282 = stablehlo.slice %205 [3:4, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %283 = stablehlo.reshape %282 : (tensor<1x32xf32>) -> tensor<32xf32>
    %284 = stablehlo.reshape %283 : (tensor<32xf32>) -> tensor<1x1x1x32xf32>
    %285 = stablehlo.broadcast_in_dim %284, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf32>) -> tensor<32x32x32x32xf32>
    %286 = stablehlo.multiply %281, %285 : tensor<32x32x32x32xf32>
    %287 = stablehlo.add %280, %286 : tensor<32x32x32x32xf32>
    %288 = call @_roll_static_72(%258) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %289 = stablehlo.slice %205 [4:5, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %290 = stablehlo.reshape %289 : (tensor<1x32xf32>) -> tensor<32xf32>
    %291 = stablehlo.reshape %290 : (tensor<32xf32>) -> tensor<1x1x1x32xf32>
    %292 = stablehlo.broadcast_in_dim %291, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf32>) -> tensor<32x32x32x32xf32>
    %293 = stablehlo.multiply %288, %292 : tensor<32x32x32x32xf32>
    %294 = stablehlo.add %287, %293 : tensor<32x32x32x32xf32>
    %295 = call @_roll_static_76(%258) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %296 = stablehlo.slice %205 [5:6, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %297 = stablehlo.reshape %296 : (tensor<1x32xf32>) -> tensor<32xf32>
    %298 = stablehlo.reshape %297 : (tensor<32xf32>) -> tensor<1x1x1x32xf32>
    %299 = stablehlo.broadcast_in_dim %298, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf32>) -> tensor<32x32x32x32xf32>
    %300 = stablehlo.multiply %295, %299 : tensor<32x32x32x32xf32>
    %301 = stablehlo.add %294, %300 : tensor<32x32x32x32xf32>
    %cst_74 = stablehlo.constant dense<0.322580636> : tensor<f32>
    %302:4 = call @solve_poisson(%301, %cst_1, %cst_2, %cst_3, %cst_74, %cst_74) : (tensor<32x32x32x32xf32>, tensor<32x1xf32>, tensor<1x17xf32>, tensor<32x17xf32>, tensor<f32>, tensor<f32>) -> (tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>)
    %cst_75 = stablehlo.constant dense<5.000000e-02> : tensor<f32>
    %303 = stablehlo.broadcast_in_dim %cst_75, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %304 = stablehlo.multiply %302#0, %303 : tensor<32x32xf32>
    %cst_76 = stablehlo.constant dense<0.322580636> : tensor<f32>
    %305 = stablehlo.broadcast_in_dim %cst_76, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %306 = stablehlo.divide %304, %305 : tensor<32x32xf32>
    %307 = stablehlo.floor %306 : tensor<32x32xf32>
    %308 = stablehlo.subtract %306, %307 : tensor<32x32xf32>
    %309 = stablehlo.convert %307 : (tensor<32x32xf32>) -> tensor<32x32xi32>
    %310 = stablehlo.multiply %308, %308 : tensor<32x32xf32>
    %311 = stablehlo.multiply %310, %308 : tensor<32x32xf32>
    %312 = stablehlo.multiply %311, %308 : tensor<32x32xf32>
    %313 = stablehlo.multiply %312, %308 : tensor<32x32xf32>
    %cst_77 = stablehlo.constant dense<2.000000e+01> : tensor<f32>
    %314 = stablehlo.broadcast_in_dim %cst_77, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %315 = stablehlo.divide %308, %314 : tensor<32x32xf32>
    %cst_78 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %316 = stablehlo.broadcast_in_dim %cst_78, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %317 = stablehlo.divide %310, %316 : tensor<32x32xf32>
    %318 = stablehlo.subtract %315, %317 : tensor<32x32xf32>
    %cst_79 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %319 = stablehlo.broadcast_in_dim %cst_79, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %320 = stablehlo.divide %311, %319 : tensor<32x32xf32>
    %321 = stablehlo.subtract %318, %320 : tensor<32x32xf32>
    %cst_80 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %322 = stablehlo.broadcast_in_dim %cst_80, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %323 = stablehlo.divide %312, %322 : tensor<32x32xf32>
    %324 = stablehlo.add %321, %323 : tensor<32x32xf32>
    %cst_81 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %325 = stablehlo.broadcast_in_dim %cst_81, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %326 = stablehlo.divide %313, %325 : tensor<32x32xf32>
    %327 = stablehlo.subtract %324, %326 : tensor<32x32xf32>
    %cst_82 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %328 = stablehlo.broadcast_in_dim %cst_82, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %329 = stablehlo.divide %308, %328 : tensor<32x32xf32>
    %330 = stablehlo.negate %329 : tensor<32x32xf32>
    %cst_83 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %331 = stablehlo.broadcast_in_dim %cst_83, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %332 = stablehlo.multiply %331, %310 : tensor<32x32xf32>
    %cst_84 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %333 = stablehlo.broadcast_in_dim %cst_84, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %334 = stablehlo.divide %332, %333 : tensor<32x32xf32>
    %335 = stablehlo.add %330, %334 : tensor<32x32xf32>
    %cst_85 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %336 = stablehlo.broadcast_in_dim %cst_85, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %337 = stablehlo.divide %311, %336 : tensor<32x32xf32>
    %338 = stablehlo.subtract %335, %337 : tensor<32x32xf32>
    %cst_86 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %339 = stablehlo.broadcast_in_dim %cst_86, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %340 = stablehlo.divide %312, %339 : tensor<32x32xf32>
    %341 = stablehlo.subtract %338, %340 : tensor<32x32xf32>
    %cst_87 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %342 = stablehlo.broadcast_in_dim %cst_87, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %343 = stablehlo.divide %313, %342 : tensor<32x32xf32>
    %344 = stablehlo.add %341, %343 : tensor<32x32xf32>
    %cst_88 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %345 = stablehlo.broadcast_in_dim %cst_88, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %346 = stablehlo.divide %308, %345 : tensor<32x32xf32>
    %cst_89 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %347 = stablehlo.broadcast_in_dim %cst_89, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %348 = stablehlo.subtract %347, %346 : tensor<32x32xf32>
    %cst_90 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %349 = stablehlo.broadcast_in_dim %cst_90, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %350 = stablehlo.multiply %349, %310 : tensor<32x32xf32>
    %cst_91 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %351 = stablehlo.broadcast_in_dim %cst_91, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %352 = stablehlo.divide %350, %351 : tensor<32x32xf32>
    %353 = stablehlo.subtract %348, %352 : tensor<32x32xf32>
    %cst_92 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %354 = stablehlo.broadcast_in_dim %cst_92, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %355 = stablehlo.multiply %354, %311 : tensor<32x32xf32>
    %cst_93 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %356 = stablehlo.broadcast_in_dim %cst_93, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %357 = stablehlo.divide %355, %356 : tensor<32x32xf32>
    %358 = stablehlo.add %353, %357 : tensor<32x32xf32>
    %cst_94 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %359 = stablehlo.broadcast_in_dim %cst_94, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %360 = stablehlo.divide %312, %359 : tensor<32x32xf32>
    %361 = stablehlo.add %358, %360 : tensor<32x32xf32>
    %cst_95 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %362 = stablehlo.broadcast_in_dim %cst_95, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %363 = stablehlo.divide %313, %362 : tensor<32x32xf32>
    %364 = stablehlo.subtract %361, %363 : tensor<32x32xf32>
    %cst_96 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %365 = stablehlo.broadcast_in_dim %cst_96, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %366 = stablehlo.multiply %365, %310 : tensor<32x32xf32>
    %cst_97 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %367 = stablehlo.broadcast_in_dim %cst_97, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %368 = stablehlo.divide %366, %367 : tensor<32x32xf32>
    %369 = stablehlo.add %308, %368 : tensor<32x32xf32>
    %cst_98 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %370 = stablehlo.broadcast_in_dim %cst_98, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %371 = stablehlo.multiply %370, %311 : tensor<32x32xf32>
    %cst_99 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %372 = stablehlo.broadcast_in_dim %cst_99, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %373 = stablehlo.divide %371, %372 : tensor<32x32xf32>
    %374 = stablehlo.subtract %369, %373 : tensor<32x32xf32>
    %cst_100 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %375 = stablehlo.broadcast_in_dim %cst_100, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %376 = stablehlo.divide %312, %375 : tensor<32x32xf32>
    %377 = stablehlo.subtract %374, %376 : tensor<32x32xf32>
    %cst_101 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %378 = stablehlo.broadcast_in_dim %cst_101, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %379 = stablehlo.divide %313, %378 : tensor<32x32xf32>
    %380 = stablehlo.add %377, %379 : tensor<32x32xf32>
    %cst_102 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %381 = stablehlo.broadcast_in_dim %cst_102, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %382 = stablehlo.divide %308, %381 : tensor<32x32xf32>
    %383 = stablehlo.negate %382 : tensor<32x32xf32>
    %cst_103 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %384 = stablehlo.broadcast_in_dim %cst_103, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %385 = stablehlo.divide %310, %384 : tensor<32x32xf32>
    %386 = stablehlo.subtract %383, %385 : tensor<32x32xf32>
    %cst_104 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %387 = stablehlo.broadcast_in_dim %cst_104, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %388 = stablehlo.multiply %387, %311 : tensor<32x32xf32>
    %cst_105 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %389 = stablehlo.broadcast_in_dim %cst_105, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %390 = stablehlo.divide %388, %389 : tensor<32x32xf32>
    %391 = stablehlo.add %386, %390 : tensor<32x32xf32>
    %cst_106 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %392 = stablehlo.broadcast_in_dim %cst_106, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %393 = stablehlo.divide %312, %392 : tensor<32x32xf32>
    %394 = stablehlo.add %391, %393 : tensor<32x32xf32>
    %cst_107 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %395 = stablehlo.broadcast_in_dim %cst_107, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %396 = stablehlo.divide %313, %395 : tensor<32x32xf32>
    %397 = stablehlo.subtract %394, %396 : tensor<32x32xf32>
    %cst_108 = stablehlo.constant dense<3.000000e+01> : tensor<f32>
    %398 = stablehlo.broadcast_in_dim %cst_108, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %399 = stablehlo.divide %308, %398 : tensor<32x32xf32>
    %cst_109 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %400 = stablehlo.broadcast_in_dim %cst_109, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %401 = stablehlo.divide %311, %400 : tensor<32x32xf32>
    %402 = stablehlo.subtract %399, %401 : tensor<32x32xf32>
    %cst_110 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %403 = stablehlo.broadcast_in_dim %cst_110, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %404 = stablehlo.divide %313, %403 : tensor<32x32xf32>
    %405 = stablehlo.add %402, %404 : tensor<32x32xf32>
    %406 = stablehlo.broadcast_in_dim %327, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %407 = stablehlo.broadcast_in_dim %344, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %408 = stablehlo.broadcast_in_dim %364, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %409 = stablehlo.broadcast_in_dim %380, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %410 = stablehlo.broadcast_in_dim %397, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %411 = stablehlo.broadcast_in_dim %405, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %412 = stablehlo.concatenate %406, %407, %408, %409, %410, %411, dim = 0 : (tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>) -> tensor<6x32x32xf32>
    %cst_111 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %413 = stablehlo.broadcast_in_dim %cst_111, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c = stablehlo.constant dense<-1> : tensor<i32>
    %414 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %415 = stablehlo.compare  EQ, %309, %414,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %416 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %417 = stablehlo.reshape %416 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %cst_112 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %418 = call @_where(%415, %417, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %419 = stablehlo.add %413, %418 : tensor<32x32xf32>
    %c_113 = stablehlo.constant dense<-2> : tensor<i32>
    %420 = stablehlo.broadcast_in_dim %c_113, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %421 = stablehlo.compare  EQ, %309, %420,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %422 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %423 = stablehlo.reshape %422 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %424 = call @_where(%421, %423, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %425 = stablehlo.add %419, %424 : tensor<32x32xf32>
    %c_114 = stablehlo.constant dense<-3> : tensor<i32>
    %426 = stablehlo.broadcast_in_dim %c_114, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %427 = stablehlo.compare  EQ, %309, %426,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %428 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %429 = stablehlo.reshape %428 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %430 = call @_where(%427, %429, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %431 = stablehlo.add %425, %430 : tensor<32x32xf32>
    %c_115 = stablehlo.constant dense<-4> : tensor<i32>
    %432 = stablehlo.broadcast_in_dim %c_115, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %433 = stablehlo.compare  EQ, %309, %432,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %434 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %435 = stablehlo.reshape %434 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %436 = call @_where(%433, %435, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %437 = stablehlo.add %431, %436 : tensor<32x32xf32>
    %c_116 = stablehlo.constant dense<-5> : tensor<i32>
    %438 = stablehlo.broadcast_in_dim %c_116, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %439 = stablehlo.compare  EQ, %309, %438,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %440 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %441 = stablehlo.reshape %440 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %442 = call @_where(%439, %441, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %443 = stablehlo.add %437, %442 : tensor<32x32xf32>
    %c_117 = stablehlo.constant dense<-6> : tensor<i32>
    %444 = stablehlo.broadcast_in_dim %c_117, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %445 = stablehlo.compare  EQ, %309, %444,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %446 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %447 = stablehlo.reshape %446 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %448 = call @_where(%445, %447, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %449 = stablehlo.add %443, %448 : tensor<32x32xf32>
    %cst_118 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %450 = stablehlo.broadcast_in_dim %cst_118, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c_119 = stablehlo.constant dense<0> : tensor<i32>
    %451 = stablehlo.broadcast_in_dim %c_119, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %452 = stablehlo.compare  EQ, %309, %451,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %453 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %454 = stablehlo.reshape %453 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %455 = call @_where(%452, %454, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %456 = stablehlo.add %450, %455 : tensor<32x32xf32>
    %c_120 = stablehlo.constant dense<-1> : tensor<i32>
    %457 = stablehlo.broadcast_in_dim %c_120, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %458 = stablehlo.compare  EQ, %309, %457,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %459 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %460 = stablehlo.reshape %459 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %461 = call @_where(%458, %460, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %462 = stablehlo.add %456, %461 : tensor<32x32xf32>
    %c_121 = stablehlo.constant dense<-2> : tensor<i32>
    %463 = stablehlo.broadcast_in_dim %c_121, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %464 = stablehlo.compare  EQ, %309, %463,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %465 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %466 = stablehlo.reshape %465 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %467 = call @_where(%464, %466, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %468 = stablehlo.add %462, %467 : tensor<32x32xf32>
    %c_122 = stablehlo.constant dense<-3> : tensor<i32>
    %469 = stablehlo.broadcast_in_dim %c_122, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %470 = stablehlo.compare  EQ, %309, %469,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %471 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %472 = stablehlo.reshape %471 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %473 = call @_where(%470, %472, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %474 = stablehlo.add %468, %473 : tensor<32x32xf32>
    %c_123 = stablehlo.constant dense<-4> : tensor<i32>
    %475 = stablehlo.broadcast_in_dim %c_123, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %476 = stablehlo.compare  EQ, %309, %475,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %477 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %478 = stablehlo.reshape %477 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %479 = call @_where(%476, %478, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %480 = stablehlo.add %474, %479 : tensor<32x32xf32>
    %c_124 = stablehlo.constant dense<-5> : tensor<i32>
    %481 = stablehlo.broadcast_in_dim %c_124, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %482 = stablehlo.compare  EQ, %309, %481,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %483 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %484 = stablehlo.reshape %483 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %485 = call @_where(%482, %484, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %486 = stablehlo.add %480, %485 : tensor<32x32xf32>
    %cst_125 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %487 = stablehlo.broadcast_in_dim %cst_125, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c_126 = stablehlo.constant dense<1> : tensor<i32>
    %488 = stablehlo.broadcast_in_dim %c_126, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %489 = stablehlo.compare  EQ, %309, %488,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %490 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %491 = stablehlo.reshape %490 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %492 = call @_where(%489, %491, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %493 = stablehlo.add %487, %492 : tensor<32x32xf32>
    %c_127 = stablehlo.constant dense<0> : tensor<i32>
    %494 = stablehlo.broadcast_in_dim %c_127, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %495 = stablehlo.compare  EQ, %309, %494,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %496 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %497 = stablehlo.reshape %496 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %498 = call @_where(%495, %497, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %499 = stablehlo.add %493, %498 : tensor<32x32xf32>
    %c_128 = stablehlo.constant dense<-1> : tensor<i32>
    %500 = stablehlo.broadcast_in_dim %c_128, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %501 = stablehlo.compare  EQ, %309, %500,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %502 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %503 = stablehlo.reshape %502 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %504 = call @_where(%501, %503, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %505 = stablehlo.add %499, %504 : tensor<32x32xf32>
    %c_129 = stablehlo.constant dense<-2> : tensor<i32>
    %506 = stablehlo.broadcast_in_dim %c_129, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %507 = stablehlo.compare  EQ, %309, %506,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %508 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %509 = stablehlo.reshape %508 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %510 = call @_where(%507, %509, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %511 = stablehlo.add %505, %510 : tensor<32x32xf32>
    %c_130 = stablehlo.constant dense<-3> : tensor<i32>
    %512 = stablehlo.broadcast_in_dim %c_130, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %513 = stablehlo.compare  EQ, %309, %512,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %514 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %515 = stablehlo.reshape %514 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %516 = call @_where(%513, %515, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %517 = stablehlo.add %511, %516 : tensor<32x32xf32>
    %c_131 = stablehlo.constant dense<-4> : tensor<i32>
    %518 = stablehlo.broadcast_in_dim %c_131, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %519 = stablehlo.compare  EQ, %309, %518,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %520 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %521 = stablehlo.reshape %520 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %522 = call @_where(%519, %521, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %523 = stablehlo.add %517, %522 : tensor<32x32xf32>
    %cst_132 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %524 = stablehlo.broadcast_in_dim %cst_132, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c_133 = stablehlo.constant dense<2> : tensor<i32>
    %525 = stablehlo.broadcast_in_dim %c_133, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %526 = stablehlo.compare  EQ, %309, %525,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %527 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %528 = stablehlo.reshape %527 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %529 = call @_where(%526, %528, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %530 = stablehlo.add %524, %529 : tensor<32x32xf32>
    %c_134 = stablehlo.constant dense<1> : tensor<i32>
    %531 = stablehlo.broadcast_in_dim %c_134, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %532 = stablehlo.compare  EQ, %309, %531,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %533 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %534 = stablehlo.reshape %533 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %535 = call @_where(%532, %534, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %536 = stablehlo.add %530, %535 : tensor<32x32xf32>
    %c_135 = stablehlo.constant dense<0> : tensor<i32>
    %537 = stablehlo.broadcast_in_dim %c_135, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %538 = stablehlo.compare  EQ, %309, %537,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %539 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %540 = stablehlo.reshape %539 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %541 = call @_where(%538, %540, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %542 = stablehlo.add %536, %541 : tensor<32x32xf32>
    %c_136 = stablehlo.constant dense<-1> : tensor<i32>
    %543 = stablehlo.broadcast_in_dim %c_136, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %544 = stablehlo.compare  EQ, %309, %543,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %545 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %546 = stablehlo.reshape %545 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %547 = call @_where(%544, %546, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %548 = stablehlo.add %542, %547 : tensor<32x32xf32>
    %c_137 = stablehlo.constant dense<-2> : tensor<i32>
    %549 = stablehlo.broadcast_in_dim %c_137, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %550 = stablehlo.compare  EQ, %309, %549,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %551 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %552 = stablehlo.reshape %551 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %553 = call @_where(%550, %552, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %554 = stablehlo.add %548, %553 : tensor<32x32xf32>
    %c_138 = stablehlo.constant dense<-3> : tensor<i32>
    %555 = stablehlo.broadcast_in_dim %c_138, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %556 = stablehlo.compare  EQ, %309, %555,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %557 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %558 = stablehlo.reshape %557 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %559 = call @_where(%556, %558, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %560 = stablehlo.add %554, %559 : tensor<32x32xf32>
    %cst_139 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %561 = stablehlo.broadcast_in_dim %cst_139, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c_140 = stablehlo.constant dense<3> : tensor<i32>
    %562 = stablehlo.broadcast_in_dim %c_140, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %563 = stablehlo.compare  EQ, %309, %562,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %564 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %565 = stablehlo.reshape %564 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %566 = call @_where(%563, %565, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %567 = stablehlo.add %561, %566 : tensor<32x32xf32>
    %c_141 = stablehlo.constant dense<2> : tensor<i32>
    %568 = stablehlo.broadcast_in_dim %c_141, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %569 = stablehlo.compare  EQ, %309, %568,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %570 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %571 = stablehlo.reshape %570 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %572 = call @_where(%569, %571, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %573 = stablehlo.add %567, %572 : tensor<32x32xf32>
    %c_142 = stablehlo.constant dense<1> : tensor<i32>
    %574 = stablehlo.broadcast_in_dim %c_142, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %575 = stablehlo.compare  EQ, %309, %574,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %576 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %577 = stablehlo.reshape %576 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %578 = call @_where(%575, %577, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %579 = stablehlo.add %573, %578 : tensor<32x32xf32>
    %c_143 = stablehlo.constant dense<0> : tensor<i32>
    %580 = stablehlo.broadcast_in_dim %c_143, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %581 = stablehlo.compare  EQ, %309, %580,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %582 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %583 = stablehlo.reshape %582 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %584 = call @_where(%581, %583, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %585 = stablehlo.add %579, %584 : tensor<32x32xf32>
    %c_144 = stablehlo.constant dense<-1> : tensor<i32>
    %586 = stablehlo.broadcast_in_dim %c_144, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %587 = stablehlo.compare  EQ, %309, %586,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %588 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %589 = stablehlo.reshape %588 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %590 = call @_where(%587, %589, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %591 = stablehlo.add %585, %590 : tensor<32x32xf32>
    %c_145 = stablehlo.constant dense<-2> : tensor<i32>
    %592 = stablehlo.broadcast_in_dim %c_145, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %593 = stablehlo.compare  EQ, %309, %592,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %594 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %595 = stablehlo.reshape %594 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %596 = call @_where(%593, %595, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %597 = stablehlo.add %591, %596 : tensor<32x32xf32>
    %cst_146 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %598 = stablehlo.broadcast_in_dim %cst_146, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c_147 = stablehlo.constant dense<4> : tensor<i32>
    %599 = stablehlo.broadcast_in_dim %c_147, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %600 = stablehlo.compare  EQ, %309, %599,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %601 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %602 = stablehlo.reshape %601 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %603 = call @_where(%600, %602, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %604 = stablehlo.add %598, %603 : tensor<32x32xf32>
    %c_148 = stablehlo.constant dense<3> : tensor<i32>
    %605 = stablehlo.broadcast_in_dim %c_148, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %606 = stablehlo.compare  EQ, %309, %605,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %607 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %608 = stablehlo.reshape %607 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %609 = call @_where(%606, %608, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %610 = stablehlo.add %604, %609 : tensor<32x32xf32>
    %c_149 = stablehlo.constant dense<2> : tensor<i32>
    %611 = stablehlo.broadcast_in_dim %c_149, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %612 = stablehlo.compare  EQ, %309, %611,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %613 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %614 = stablehlo.reshape %613 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %615 = call @_where(%612, %614, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %616 = stablehlo.add %610, %615 : tensor<32x32xf32>
    %c_150 = stablehlo.constant dense<1> : tensor<i32>
    %617 = stablehlo.broadcast_in_dim %c_150, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %618 = stablehlo.compare  EQ, %309, %617,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %619 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %620 = stablehlo.reshape %619 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %621 = call @_where(%618, %620, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %622 = stablehlo.add %616, %621 : tensor<32x32xf32>
    %c_151 = stablehlo.constant dense<0> : tensor<i32>
    %623 = stablehlo.broadcast_in_dim %c_151, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %624 = stablehlo.compare  EQ, %309, %623,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %625 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %626 = stablehlo.reshape %625 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %627 = call @_where(%624, %626, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %628 = stablehlo.add %622, %627 : tensor<32x32xf32>
    %c_152 = stablehlo.constant dense<-1> : tensor<i32>
    %629 = stablehlo.broadcast_in_dim %c_152, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %630 = stablehlo.compare  EQ, %309, %629,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %631 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %632 = stablehlo.reshape %631 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %633 = call @_where(%630, %632, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %634 = stablehlo.add %628, %633 : tensor<32x32xf32>
    %cst_153 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %635 = stablehlo.broadcast_in_dim %cst_153, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c_154 = stablehlo.constant dense<5> : tensor<i32>
    %636 = stablehlo.broadcast_in_dim %c_154, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %637 = stablehlo.compare  EQ, %309, %636,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %638 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %639 = stablehlo.reshape %638 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %640 = call @_where(%637, %639, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %641 = stablehlo.add %635, %640 : tensor<32x32xf32>
    %c_155 = stablehlo.constant dense<4> : tensor<i32>
    %642 = stablehlo.broadcast_in_dim %c_155, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %643 = stablehlo.compare  EQ, %309, %642,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %644 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %645 = stablehlo.reshape %644 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %646 = call @_where(%643, %645, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %647 = stablehlo.add %641, %646 : tensor<32x32xf32>
    %c_156 = stablehlo.constant dense<3> : tensor<i32>
    %648 = stablehlo.broadcast_in_dim %c_156, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %649 = stablehlo.compare  EQ, %309, %648,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %650 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %651 = stablehlo.reshape %650 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %652 = call @_where(%649, %651, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %653 = stablehlo.add %647, %652 : tensor<32x32xf32>
    %c_157 = stablehlo.constant dense<2> : tensor<i32>
    %654 = stablehlo.broadcast_in_dim %c_157, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %655 = stablehlo.compare  EQ, %309, %654,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %656 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %657 = stablehlo.reshape %656 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %658 = call @_where(%655, %657, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %659 = stablehlo.add %653, %658 : tensor<32x32xf32>
    %c_158 = stablehlo.constant dense<1> : tensor<i32>
    %660 = stablehlo.broadcast_in_dim %c_158, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %661 = stablehlo.compare  EQ, %309, %660,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %662 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %663 = stablehlo.reshape %662 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %664 = call @_where(%661, %663, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %665 = stablehlo.add %659, %664 : tensor<32x32xf32>
    %c_159 = stablehlo.constant dense<0> : tensor<i32>
    %666 = stablehlo.broadcast_in_dim %c_159, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %667 = stablehlo.compare  EQ, %309, %666,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %668 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %669 = stablehlo.reshape %668 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %670 = call @_where(%667, %669, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %671 = stablehlo.add %665, %670 : tensor<32x32xf32>
    %672 = stablehlo.broadcast_in_dim %449, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %673 = stablehlo.broadcast_in_dim %486, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %674 = stablehlo.broadcast_in_dim %523, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %675 = stablehlo.broadcast_in_dim %560, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %676 = stablehlo.broadcast_in_dim %597, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %677 = stablehlo.broadcast_in_dim %634, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %678 = stablehlo.broadcast_in_dim %671, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %679 = stablehlo.concatenate %672, %673, %674, %675, %676, %677, %678, dim = 0 : (tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>) -> tensor<7x32x32xf32>
    %c_160 = stablehlo.constant dense<0> : tensor<i32>
    %680 = call @_pad(%301, %c_160) : (tensor<32x32x32x32xf32>, tensor<i32>) -> tensor<32x32x38x32xf32>
    %cst_161 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %681 = stablehlo.broadcast_in_dim %cst_161, dims = [] : (tensor<f32>) -> tensor<32x32x32x32xf32>
    %682 = stablehlo.slice %680 [0:32, 0:32, 6:38, 0:32] : (tensor<32x32x38x32xf32>) -> tensor<32x32x32x32xf32>
    %683 = stablehlo.slice %679 [0:1, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %684 = stablehlo.reshape %683 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %685 = stablehlo.broadcast_in_dim %684, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %686 = stablehlo.broadcast_in_dim %685, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %687 = stablehlo.multiply %686, %682 : tensor<32x32x32x32xf32>
    %688 = stablehlo.add %681, %687 : tensor<32x32x32x32xf32>
    %689 = stablehlo.slice %680 [0:32, 0:32, 5:37, 0:32] : (tensor<32x32x38x32xf32>) -> tensor<32x32x32x32xf32>
    %690 = stablehlo.slice %679 [1:2, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %691 = stablehlo.reshape %690 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %692 = stablehlo.broadcast_in_dim %691, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %693 = stablehlo.broadcast_in_dim %692, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %694 = stablehlo.multiply %693, %689 : tensor<32x32x32x32xf32>
    %695 = stablehlo.add %688, %694 : tensor<32x32x32x32xf32>
    %696 = stablehlo.slice %680 [0:32, 0:32, 4:36, 0:32] : (tensor<32x32x38x32xf32>) -> tensor<32x32x32x32xf32>
    %697 = stablehlo.slice %679 [2:3, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %698 = stablehlo.reshape %697 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %699 = stablehlo.broadcast_in_dim %698, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %700 = stablehlo.broadcast_in_dim %699, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %701 = stablehlo.multiply %700, %696 : tensor<32x32x32x32xf32>
    %702 = stablehlo.add %695, %701 : tensor<32x32x32x32xf32>
    %703 = stablehlo.slice %680 [0:32, 0:32, 3:35, 0:32] : (tensor<32x32x38x32xf32>) -> tensor<32x32x32x32xf32>
    %704 = stablehlo.slice %679 [3:4, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %705 = stablehlo.reshape %704 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %706 = stablehlo.broadcast_in_dim %705, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %707 = stablehlo.broadcast_in_dim %706, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %708 = stablehlo.multiply %707, %703 : tensor<32x32x32x32xf32>
    %709 = stablehlo.add %702, %708 : tensor<32x32x32x32xf32>
    %710 = stablehlo.slice %680 [0:32, 0:32, 2:34, 0:32] : (tensor<32x32x38x32xf32>) -> tensor<32x32x32x32xf32>
    %711 = stablehlo.slice %679 [4:5, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %712 = stablehlo.reshape %711 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %713 = stablehlo.broadcast_in_dim %712, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %714 = stablehlo.broadcast_in_dim %713, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %715 = stablehlo.multiply %714, %710 : tensor<32x32x32x32xf32>
    %716 = stablehlo.add %709, %715 : tensor<32x32x32x32xf32>
    %717 = stablehlo.slice %680 [0:32, 0:32, 1:33, 0:32] : (tensor<32x32x38x32xf32>) -> tensor<32x32x32x32xf32>
    %718 = stablehlo.slice %679 [5:6, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %719 = stablehlo.reshape %718 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %720 = stablehlo.broadcast_in_dim %719, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %721 = stablehlo.broadcast_in_dim %720, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %722 = stablehlo.multiply %721, %717 : tensor<32x32x32x32xf32>
    %723 = stablehlo.add %716, %722 : tensor<32x32x32x32xf32>
    %724 = stablehlo.slice %680 [0:32, 0:32, 0:32, 0:32] : (tensor<32x32x38x32xf32>) -> tensor<32x32x32x32xf32>
    %725 = stablehlo.slice %679 [6:7, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %726 = stablehlo.reshape %725 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %727 = stablehlo.broadcast_in_dim %726, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %728 = stablehlo.broadcast_in_dim %727, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %729 = stablehlo.multiply %728, %724 : tensor<32x32x32x32xf32>
    %730 = stablehlo.add %723, %729 : tensor<32x32x32x32xf32>
    %cst_162 = stablehlo.constant dense<5.000000e-02> : tensor<f32>
    %731 = stablehlo.broadcast_in_dim %cst_162, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %732 = stablehlo.multiply %302#1, %731 : tensor<32x32xf32>
    %cst_163 = stablehlo.constant dense<0.322580636> : tensor<f32>
    %733 = stablehlo.broadcast_in_dim %cst_163, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %734 = stablehlo.divide %732, %733 : tensor<32x32xf32>
    %735 = stablehlo.floor %734 : tensor<32x32xf32>
    %736 = stablehlo.subtract %734, %735 : tensor<32x32xf32>
    %737 = stablehlo.convert %735 : (tensor<32x32xf32>) -> tensor<32x32xi32>
    %738 = stablehlo.multiply %736, %736 : tensor<32x32xf32>
    %739 = stablehlo.multiply %738, %736 : tensor<32x32xf32>
    %740 = stablehlo.multiply %739, %736 : tensor<32x32xf32>
    %741 = stablehlo.multiply %740, %736 : tensor<32x32xf32>
    %cst_164 = stablehlo.constant dense<2.000000e+01> : tensor<f32>
    %742 = stablehlo.broadcast_in_dim %cst_164, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %743 = stablehlo.divide %736, %742 : tensor<32x32xf32>
    %cst_165 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %744 = stablehlo.broadcast_in_dim %cst_165, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %745 = stablehlo.divide %738, %744 : tensor<32x32xf32>
    %746 = stablehlo.subtract %743, %745 : tensor<32x32xf32>
    %cst_166 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %747 = stablehlo.broadcast_in_dim %cst_166, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %748 = stablehlo.divide %739, %747 : tensor<32x32xf32>
    %749 = stablehlo.subtract %746, %748 : tensor<32x32xf32>
    %cst_167 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %750 = stablehlo.broadcast_in_dim %cst_167, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %751 = stablehlo.divide %740, %750 : tensor<32x32xf32>
    %752 = stablehlo.add %749, %751 : tensor<32x32xf32>
    %cst_168 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %753 = stablehlo.broadcast_in_dim %cst_168, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %754 = stablehlo.divide %741, %753 : tensor<32x32xf32>
    %755 = stablehlo.subtract %752, %754 : tensor<32x32xf32>
    %cst_169 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %756 = stablehlo.broadcast_in_dim %cst_169, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %757 = stablehlo.divide %736, %756 : tensor<32x32xf32>
    %758 = stablehlo.negate %757 : tensor<32x32xf32>
    %cst_170 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %759 = stablehlo.broadcast_in_dim %cst_170, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %760 = stablehlo.multiply %759, %738 : tensor<32x32xf32>
    %cst_171 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %761 = stablehlo.broadcast_in_dim %cst_171, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %762 = stablehlo.divide %760, %761 : tensor<32x32xf32>
    %763 = stablehlo.add %758, %762 : tensor<32x32xf32>
    %cst_172 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %764 = stablehlo.broadcast_in_dim %cst_172, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %765 = stablehlo.divide %739, %764 : tensor<32x32xf32>
    %766 = stablehlo.subtract %763, %765 : tensor<32x32xf32>
    %cst_173 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %767 = stablehlo.broadcast_in_dim %cst_173, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %768 = stablehlo.divide %740, %767 : tensor<32x32xf32>
    %769 = stablehlo.subtract %766, %768 : tensor<32x32xf32>
    %cst_174 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %770 = stablehlo.broadcast_in_dim %cst_174, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %771 = stablehlo.divide %741, %770 : tensor<32x32xf32>
    %772 = stablehlo.add %769, %771 : tensor<32x32xf32>
    %cst_175 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %773 = stablehlo.broadcast_in_dim %cst_175, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %774 = stablehlo.divide %736, %773 : tensor<32x32xf32>
    %cst_176 = stablehlo.constant dense<1.000000e+00> : tensor<f32>
    %775 = stablehlo.broadcast_in_dim %cst_176, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %776 = stablehlo.subtract %775, %774 : tensor<32x32xf32>
    %cst_177 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %777 = stablehlo.broadcast_in_dim %cst_177, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %778 = stablehlo.multiply %777, %738 : tensor<32x32xf32>
    %cst_178 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %779 = stablehlo.broadcast_in_dim %cst_178, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %780 = stablehlo.divide %778, %779 : tensor<32x32xf32>
    %781 = stablehlo.subtract %776, %780 : tensor<32x32xf32>
    %cst_179 = stablehlo.constant dense<5.000000e+00> : tensor<f32>
    %782 = stablehlo.broadcast_in_dim %cst_179, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %783 = stablehlo.multiply %782, %739 : tensor<32x32xf32>
    %cst_180 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %784 = stablehlo.broadcast_in_dim %cst_180, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %785 = stablehlo.divide %783, %784 : tensor<32x32xf32>
    %786 = stablehlo.add %781, %785 : tensor<32x32xf32>
    %cst_181 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %787 = stablehlo.broadcast_in_dim %cst_181, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %788 = stablehlo.divide %740, %787 : tensor<32x32xf32>
    %789 = stablehlo.add %786, %788 : tensor<32x32xf32>
    %cst_182 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %790 = stablehlo.broadcast_in_dim %cst_182, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %791 = stablehlo.divide %741, %790 : tensor<32x32xf32>
    %792 = stablehlo.subtract %789, %791 : tensor<32x32xf32>
    %cst_183 = stablehlo.constant dense<2.000000e+00> : tensor<f32>
    %793 = stablehlo.broadcast_in_dim %cst_183, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %794 = stablehlo.multiply %793, %738 : tensor<32x32xf32>
    %cst_184 = stablehlo.constant dense<3.000000e+00> : tensor<f32>
    %795 = stablehlo.broadcast_in_dim %cst_184, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %796 = stablehlo.divide %794, %795 : tensor<32x32xf32>
    %797 = stablehlo.add %736, %796 : tensor<32x32xf32>
    %cst_185 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %798 = stablehlo.broadcast_in_dim %cst_185, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %799 = stablehlo.multiply %798, %739 : tensor<32x32xf32>
    %cst_186 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %800 = stablehlo.broadcast_in_dim %cst_186, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %801 = stablehlo.divide %799, %800 : tensor<32x32xf32>
    %802 = stablehlo.subtract %797, %801 : tensor<32x32xf32>
    %cst_187 = stablehlo.constant dense<6.000000e+00> : tensor<f32>
    %803 = stablehlo.broadcast_in_dim %cst_187, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %804 = stablehlo.divide %740, %803 : tensor<32x32xf32>
    %805 = stablehlo.subtract %802, %804 : tensor<32x32xf32>
    %cst_188 = stablehlo.constant dense<1.200000e+01> : tensor<f32>
    %806 = stablehlo.broadcast_in_dim %cst_188, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %807 = stablehlo.divide %741, %806 : tensor<32x32xf32>
    %808 = stablehlo.add %805, %807 : tensor<32x32xf32>
    %cst_189 = stablehlo.constant dense<4.000000e+00> : tensor<f32>
    %809 = stablehlo.broadcast_in_dim %cst_189, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %810 = stablehlo.divide %736, %809 : tensor<32x32xf32>
    %811 = stablehlo.negate %810 : tensor<32x32xf32>
    %cst_190 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %812 = stablehlo.broadcast_in_dim %cst_190, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %813 = stablehlo.divide %738, %812 : tensor<32x32xf32>
    %814 = stablehlo.subtract %811, %813 : tensor<32x32xf32>
    %cst_191 = stablehlo.constant dense<7.000000e+00> : tensor<f32>
    %815 = stablehlo.broadcast_in_dim %cst_191, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %816 = stablehlo.multiply %815, %739 : tensor<32x32xf32>
    %cst_192 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %817 = stablehlo.broadcast_in_dim %cst_192, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %818 = stablehlo.divide %816, %817 : tensor<32x32xf32>
    %819 = stablehlo.add %814, %818 : tensor<32x32xf32>
    %cst_193 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %820 = stablehlo.broadcast_in_dim %cst_193, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %821 = stablehlo.divide %740, %820 : tensor<32x32xf32>
    %822 = stablehlo.add %819, %821 : tensor<32x32xf32>
    %cst_194 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %823 = stablehlo.broadcast_in_dim %cst_194, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %824 = stablehlo.divide %741, %823 : tensor<32x32xf32>
    %825 = stablehlo.subtract %822, %824 : tensor<32x32xf32>
    %cst_195 = stablehlo.constant dense<3.000000e+01> : tensor<f32>
    %826 = stablehlo.broadcast_in_dim %cst_195, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %827 = stablehlo.divide %736, %826 : tensor<32x32xf32>
    %cst_196 = stablehlo.constant dense<2.400000e+01> : tensor<f32>
    %828 = stablehlo.broadcast_in_dim %cst_196, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %829 = stablehlo.divide %739, %828 : tensor<32x32xf32>
    %830 = stablehlo.subtract %827, %829 : tensor<32x32xf32>
    %cst_197 = stablehlo.constant dense<1.200000e+02> : tensor<f32>
    %831 = stablehlo.broadcast_in_dim %cst_197, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %832 = stablehlo.divide %741, %831 : tensor<32x32xf32>
    %833 = stablehlo.add %830, %832 : tensor<32x32xf32>
    %834 = stablehlo.broadcast_in_dim %755, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %835 = stablehlo.broadcast_in_dim %772, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %836 = stablehlo.broadcast_in_dim %792, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %837 = stablehlo.broadcast_in_dim %808, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %838 = stablehlo.broadcast_in_dim %825, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %839 = stablehlo.broadcast_in_dim %833, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %840 = stablehlo.concatenate %834, %835, %836, %837, %838, %839, dim = 0 : (tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>) -> tensor<6x32x32xf32>
    %cst_198 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %841 = stablehlo.broadcast_in_dim %cst_198, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c_199 = stablehlo.constant dense<-1> : tensor<i32>
    %842 = stablehlo.broadcast_in_dim %c_199, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %843 = stablehlo.compare  EQ, %737, %842,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %844 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %845 = stablehlo.reshape %844 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %846 = call @_where(%843, %845, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %847 = stablehlo.add %841, %846 : tensor<32x32xf32>
    %c_200 = stablehlo.constant dense<-2> : tensor<i32>
    %848 = stablehlo.broadcast_in_dim %c_200, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %849 = stablehlo.compare  EQ, %737, %848,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %850 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %851 = stablehlo.reshape %850 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %852 = call @_where(%849, %851, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %853 = stablehlo.add %847, %852 : tensor<32x32xf32>
    %c_201 = stablehlo.constant dense<-3> : tensor<i32>
    %854 = stablehlo.broadcast_in_dim %c_201, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %855 = stablehlo.compare  EQ, %737, %854,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %856 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %857 = stablehlo.reshape %856 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %858 = call @_where(%855, %857, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %859 = stablehlo.add %853, %858 : tensor<32x32xf32>
    %c_202 = stablehlo.constant dense<-4> : tensor<i32>
    %860 = stablehlo.broadcast_in_dim %c_202, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %861 = stablehlo.compare  EQ, %737, %860,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %862 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %863 = stablehlo.reshape %862 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %864 = call @_where(%861, %863, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %865 = stablehlo.add %859, %864 : tensor<32x32xf32>
    %c_203 = stablehlo.constant dense<-5> : tensor<i32>
    %866 = stablehlo.broadcast_in_dim %c_203, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %867 = stablehlo.compare  EQ, %737, %866,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %868 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %869 = stablehlo.reshape %868 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %870 = call @_where(%867, %869, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %871 = stablehlo.add %865, %870 : tensor<32x32xf32>
    %c_204 = stablehlo.constant dense<-6> : tensor<i32>
    %872 = stablehlo.broadcast_in_dim %c_204, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %873 = stablehlo.compare  EQ, %737, %872,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %874 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %875 = stablehlo.reshape %874 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %876 = call @_where(%873, %875, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %877 = stablehlo.add %871, %876 : tensor<32x32xf32>
    %cst_205 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %878 = stablehlo.broadcast_in_dim %cst_205, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c_206 = stablehlo.constant dense<0> : tensor<i32>
    %879 = stablehlo.broadcast_in_dim %c_206, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %880 = stablehlo.compare  EQ, %737, %879,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %881 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %882 = stablehlo.reshape %881 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %883 = call @_where(%880, %882, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %884 = stablehlo.add %878, %883 : tensor<32x32xf32>
    %c_207 = stablehlo.constant dense<-1> : tensor<i32>
    %885 = stablehlo.broadcast_in_dim %c_207, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %886 = stablehlo.compare  EQ, %737, %885,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %887 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %888 = stablehlo.reshape %887 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %889 = call @_where(%886, %888, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %890 = stablehlo.add %884, %889 : tensor<32x32xf32>
    %c_208 = stablehlo.constant dense<-2> : tensor<i32>
    %891 = stablehlo.broadcast_in_dim %c_208, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %892 = stablehlo.compare  EQ, %737, %891,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %893 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %894 = stablehlo.reshape %893 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %895 = call @_where(%892, %894, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %896 = stablehlo.add %890, %895 : tensor<32x32xf32>
    %c_209 = stablehlo.constant dense<-3> : tensor<i32>
    %897 = stablehlo.broadcast_in_dim %c_209, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %898 = stablehlo.compare  EQ, %737, %897,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %899 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %900 = stablehlo.reshape %899 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %901 = call @_where(%898, %900, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %902 = stablehlo.add %896, %901 : tensor<32x32xf32>
    %c_210 = stablehlo.constant dense<-4> : tensor<i32>
    %903 = stablehlo.broadcast_in_dim %c_210, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %904 = stablehlo.compare  EQ, %737, %903,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %905 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %906 = stablehlo.reshape %905 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %907 = call @_where(%904, %906, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %908 = stablehlo.add %902, %907 : tensor<32x32xf32>
    %c_211 = stablehlo.constant dense<-5> : tensor<i32>
    %909 = stablehlo.broadcast_in_dim %c_211, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %910 = stablehlo.compare  EQ, %737, %909,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %911 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %912 = stablehlo.reshape %911 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %913 = call @_where(%910, %912, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %914 = stablehlo.add %908, %913 : tensor<32x32xf32>
    %cst_212 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %915 = stablehlo.broadcast_in_dim %cst_212, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c_213 = stablehlo.constant dense<1> : tensor<i32>
    %916 = stablehlo.broadcast_in_dim %c_213, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %917 = stablehlo.compare  EQ, %737, %916,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %918 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %919 = stablehlo.reshape %918 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %920 = call @_where(%917, %919, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %921 = stablehlo.add %915, %920 : tensor<32x32xf32>
    %c_214 = stablehlo.constant dense<0> : tensor<i32>
    %922 = stablehlo.broadcast_in_dim %c_214, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %923 = stablehlo.compare  EQ, %737, %922,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %924 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %925 = stablehlo.reshape %924 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %926 = call @_where(%923, %925, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %927 = stablehlo.add %921, %926 : tensor<32x32xf32>
    %c_215 = stablehlo.constant dense<-1> : tensor<i32>
    %928 = stablehlo.broadcast_in_dim %c_215, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %929 = stablehlo.compare  EQ, %737, %928,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %930 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %931 = stablehlo.reshape %930 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %932 = call @_where(%929, %931, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %933 = stablehlo.add %927, %932 : tensor<32x32xf32>
    %c_216 = stablehlo.constant dense<-2> : tensor<i32>
    %934 = stablehlo.broadcast_in_dim %c_216, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %935 = stablehlo.compare  EQ, %737, %934,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %936 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %937 = stablehlo.reshape %936 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %938 = call @_where(%935, %937, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %939 = stablehlo.add %933, %938 : tensor<32x32xf32>
    %c_217 = stablehlo.constant dense<-3> : tensor<i32>
    %940 = stablehlo.broadcast_in_dim %c_217, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %941 = stablehlo.compare  EQ, %737, %940,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %942 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %943 = stablehlo.reshape %942 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %944 = call @_where(%941, %943, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %945 = stablehlo.add %939, %944 : tensor<32x32xf32>
    %c_218 = stablehlo.constant dense<-4> : tensor<i32>
    %946 = stablehlo.broadcast_in_dim %c_218, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %947 = stablehlo.compare  EQ, %737, %946,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %948 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %949 = stablehlo.reshape %948 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %950 = call @_where(%947, %949, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %951 = stablehlo.add %945, %950 : tensor<32x32xf32>
    %cst_219 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %952 = stablehlo.broadcast_in_dim %cst_219, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c_220 = stablehlo.constant dense<2> : tensor<i32>
    %953 = stablehlo.broadcast_in_dim %c_220, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %954 = stablehlo.compare  EQ, %737, %953,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %955 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %956 = stablehlo.reshape %955 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %957 = call @_where(%954, %956, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %958 = stablehlo.add %952, %957 : tensor<32x32xf32>
    %c_221 = stablehlo.constant dense<1> : tensor<i32>
    %959 = stablehlo.broadcast_in_dim %c_221, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %960 = stablehlo.compare  EQ, %737, %959,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %961 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %962 = stablehlo.reshape %961 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %963 = call @_where(%960, %962, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %964 = stablehlo.add %958, %963 : tensor<32x32xf32>
    %c_222 = stablehlo.constant dense<0> : tensor<i32>
    %965 = stablehlo.broadcast_in_dim %c_222, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %966 = stablehlo.compare  EQ, %737, %965,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %967 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %968 = stablehlo.reshape %967 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %969 = call @_where(%966, %968, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %970 = stablehlo.add %964, %969 : tensor<32x32xf32>
    %c_223 = stablehlo.constant dense<-1> : tensor<i32>
    %971 = stablehlo.broadcast_in_dim %c_223, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %972 = stablehlo.compare  EQ, %737, %971,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %973 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %974 = stablehlo.reshape %973 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %975 = call @_where(%972, %974, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %976 = stablehlo.add %970, %975 : tensor<32x32xf32>
    %c_224 = stablehlo.constant dense<-2> : tensor<i32>
    %977 = stablehlo.broadcast_in_dim %c_224, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %978 = stablehlo.compare  EQ, %737, %977,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %979 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %980 = stablehlo.reshape %979 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %981 = call @_where(%978, %980, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %982 = stablehlo.add %976, %981 : tensor<32x32xf32>
    %c_225 = stablehlo.constant dense<-3> : tensor<i32>
    %983 = stablehlo.broadcast_in_dim %c_225, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %984 = stablehlo.compare  EQ, %737, %983,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %985 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %986 = stablehlo.reshape %985 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %987 = call @_where(%984, %986, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %988 = stablehlo.add %982, %987 : tensor<32x32xf32>
    %cst_226 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %989 = stablehlo.broadcast_in_dim %cst_226, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c_227 = stablehlo.constant dense<3> : tensor<i32>
    %990 = stablehlo.broadcast_in_dim %c_227, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %991 = stablehlo.compare  EQ, %737, %990,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %992 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %993 = stablehlo.reshape %992 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %994 = call @_where(%991, %993, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %995 = stablehlo.add %989, %994 : tensor<32x32xf32>
    %c_228 = stablehlo.constant dense<2> : tensor<i32>
    %996 = stablehlo.broadcast_in_dim %c_228, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %997 = stablehlo.compare  EQ, %737, %996,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %998 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %999 = stablehlo.reshape %998 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1000 = call @_where(%997, %999, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1001 = stablehlo.add %995, %1000 : tensor<32x32xf32>
    %c_229 = stablehlo.constant dense<1> : tensor<i32>
    %1002 = stablehlo.broadcast_in_dim %c_229, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1003 = stablehlo.compare  EQ, %737, %1002,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1004 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1005 = stablehlo.reshape %1004 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1006 = call @_where(%1003, %1005, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1007 = stablehlo.add %1001, %1006 : tensor<32x32xf32>
    %c_230 = stablehlo.constant dense<0> : tensor<i32>
    %1008 = stablehlo.broadcast_in_dim %c_230, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1009 = stablehlo.compare  EQ, %737, %1008,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1010 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1011 = stablehlo.reshape %1010 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1012 = call @_where(%1009, %1011, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1013 = stablehlo.add %1007, %1012 : tensor<32x32xf32>
    %c_231 = stablehlo.constant dense<-1> : tensor<i32>
    %1014 = stablehlo.broadcast_in_dim %c_231, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1015 = stablehlo.compare  EQ, %737, %1014,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1016 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1017 = stablehlo.reshape %1016 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1018 = call @_where(%1015, %1017, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1019 = stablehlo.add %1013, %1018 : tensor<32x32xf32>
    %c_232 = stablehlo.constant dense<-2> : tensor<i32>
    %1020 = stablehlo.broadcast_in_dim %c_232, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1021 = stablehlo.compare  EQ, %737, %1020,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1022 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1023 = stablehlo.reshape %1022 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1024 = call @_where(%1021, %1023, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1025 = stablehlo.add %1019, %1024 : tensor<32x32xf32>
    %cst_233 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %1026 = stablehlo.broadcast_in_dim %cst_233, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c_234 = stablehlo.constant dense<4> : tensor<i32>
    %1027 = stablehlo.broadcast_in_dim %c_234, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1028 = stablehlo.compare  EQ, %737, %1027,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1029 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1030 = stablehlo.reshape %1029 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1031 = call @_where(%1028, %1030, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1032 = stablehlo.add %1026, %1031 : tensor<32x32xf32>
    %c_235 = stablehlo.constant dense<3> : tensor<i32>
    %1033 = stablehlo.broadcast_in_dim %c_235, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1034 = stablehlo.compare  EQ, %737, %1033,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1035 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1036 = stablehlo.reshape %1035 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1037 = call @_where(%1034, %1036, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1038 = stablehlo.add %1032, %1037 : tensor<32x32xf32>
    %c_236 = stablehlo.constant dense<2> : tensor<i32>
    %1039 = stablehlo.broadcast_in_dim %c_236, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1040 = stablehlo.compare  EQ, %737, %1039,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1041 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1042 = stablehlo.reshape %1041 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1043 = call @_where(%1040, %1042, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1044 = stablehlo.add %1038, %1043 : tensor<32x32xf32>
    %c_237 = stablehlo.constant dense<1> : tensor<i32>
    %1045 = stablehlo.broadcast_in_dim %c_237, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1046 = stablehlo.compare  EQ, %737, %1045,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1047 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1048 = stablehlo.reshape %1047 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1049 = call @_where(%1046, %1048, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1050 = stablehlo.add %1044, %1049 : tensor<32x32xf32>
    %c_238 = stablehlo.constant dense<0> : tensor<i32>
    %1051 = stablehlo.broadcast_in_dim %c_238, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1052 = stablehlo.compare  EQ, %737, %1051,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1053 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1054 = stablehlo.reshape %1053 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1055 = call @_where(%1052, %1054, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1056 = stablehlo.add %1050, %1055 : tensor<32x32xf32>
    %c_239 = stablehlo.constant dense<-1> : tensor<i32>
    %1057 = stablehlo.broadcast_in_dim %c_239, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1058 = stablehlo.compare  EQ, %737, %1057,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1059 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1060 = stablehlo.reshape %1059 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1061 = call @_where(%1058, %1060, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1062 = stablehlo.add %1056, %1061 : tensor<32x32xf32>
    %cst_240 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %1063 = stablehlo.broadcast_in_dim %cst_240, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %c_241 = stablehlo.constant dense<5> : tensor<i32>
    %1064 = stablehlo.broadcast_in_dim %c_241, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1065 = stablehlo.compare  EQ, %737, %1064,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1066 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1067 = stablehlo.reshape %1066 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1068 = call @_where(%1065, %1067, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1069 = stablehlo.add %1063, %1068 : tensor<32x32xf32>
    %c_242 = stablehlo.constant dense<4> : tensor<i32>
    %1070 = stablehlo.broadcast_in_dim %c_242, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1071 = stablehlo.compare  EQ, %737, %1070,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1072 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1073 = stablehlo.reshape %1072 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1074 = call @_where(%1071, %1073, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1075 = stablehlo.add %1069, %1074 : tensor<32x32xf32>
    %c_243 = stablehlo.constant dense<3> : tensor<i32>
    %1076 = stablehlo.broadcast_in_dim %c_243, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1077 = stablehlo.compare  EQ, %737, %1076,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1078 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1079 = stablehlo.reshape %1078 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1080 = call @_where(%1077, %1079, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1081 = stablehlo.add %1075, %1080 : tensor<32x32xf32>
    %c_244 = stablehlo.constant dense<2> : tensor<i32>
    %1082 = stablehlo.broadcast_in_dim %c_244, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1083 = stablehlo.compare  EQ, %737, %1082,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1084 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1085 = stablehlo.reshape %1084 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1086 = call @_where(%1083, %1085, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1087 = stablehlo.add %1081, %1086 : tensor<32x32xf32>
    %c_245 = stablehlo.constant dense<1> : tensor<i32>
    %1088 = stablehlo.broadcast_in_dim %c_245, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1089 = stablehlo.compare  EQ, %737, %1088,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1090 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1091 = stablehlo.reshape %1090 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1092 = call @_where(%1089, %1091, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1093 = stablehlo.add %1087, %1092 : tensor<32x32xf32>
    %c_246 = stablehlo.constant dense<0> : tensor<i32>
    %1094 = stablehlo.broadcast_in_dim %c_246, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1095 = stablehlo.compare  EQ, %737, %1094,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1096 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf32>) -> tensor<1x32x32xf32>
    %1097 = stablehlo.reshape %1096 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1098 = call @_where(%1095, %1097, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf32>, tensor<f32>) -> tensor<32x32xf32>
    %1099 = stablehlo.add %1093, %1098 : tensor<32x32xf32>
    %1100 = stablehlo.broadcast_in_dim %877, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %1101 = stablehlo.broadcast_in_dim %914, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %1102 = stablehlo.broadcast_in_dim %951, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %1103 = stablehlo.broadcast_in_dim %988, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %1104 = stablehlo.broadcast_in_dim %1025, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %1105 = stablehlo.broadcast_in_dim %1062, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %1106 = stablehlo.broadcast_in_dim %1099, dims = [1, 2] : (tensor<32x32xf32>) -> tensor<1x32x32xf32>
    %1107 = stablehlo.concatenate %1100, %1101, %1102, %1103, %1104, %1105, %1106, dim = 0 : (tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>, tensor<1x32x32xf32>) -> tensor<7x32x32xf32>
    %1108 = call @_pad_129(%730, %c_160) : (tensor<32x32x32x32xf32>, tensor<i32>) -> tensor<32x32x32x38xf32>
    %cst_247 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %1109 = stablehlo.broadcast_in_dim %cst_247, dims = [] : (tensor<f32>) -> tensor<32x32x32x32xf32>
    %1110 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 6:38] : (tensor<32x32x32x38xf32>) -> tensor<32x32x32x32xf32>
    %1111 = stablehlo.slice %1107 [0:1, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %1112 = stablehlo.reshape %1111 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1113 = stablehlo.broadcast_in_dim %1112, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %1114 = stablehlo.broadcast_in_dim %1113, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %1115 = stablehlo.multiply %1114, %1110 : tensor<32x32x32x32xf32>
    %1116 = stablehlo.add %1109, %1115 : tensor<32x32x32x32xf32>
    %1117 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 5:37] : (tensor<32x32x32x38xf32>) -> tensor<32x32x32x32xf32>
    %1118 = stablehlo.slice %1107 [1:2, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %1119 = stablehlo.reshape %1118 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1120 = stablehlo.broadcast_in_dim %1119, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %1121 = stablehlo.broadcast_in_dim %1120, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %1122 = stablehlo.multiply %1121, %1117 : tensor<32x32x32x32xf32>
    %1123 = stablehlo.add %1116, %1122 : tensor<32x32x32x32xf32>
    %1124 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 4:36] : (tensor<32x32x32x38xf32>) -> tensor<32x32x32x32xf32>
    %1125 = stablehlo.slice %1107 [2:3, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %1126 = stablehlo.reshape %1125 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1127 = stablehlo.broadcast_in_dim %1126, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %1128 = stablehlo.broadcast_in_dim %1127, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %1129 = stablehlo.multiply %1128, %1124 : tensor<32x32x32x32xf32>
    %1130 = stablehlo.add %1123, %1129 : tensor<32x32x32x32xf32>
    %1131 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 3:35] : (tensor<32x32x32x38xf32>) -> tensor<32x32x32x32xf32>
    %1132 = stablehlo.slice %1107 [3:4, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %1133 = stablehlo.reshape %1132 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1134 = stablehlo.broadcast_in_dim %1133, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %1135 = stablehlo.broadcast_in_dim %1134, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %1136 = stablehlo.multiply %1135, %1131 : tensor<32x32x32x32xf32>
    %1137 = stablehlo.add %1130, %1136 : tensor<32x32x32x32xf32>
    %1138 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 2:34] : (tensor<32x32x32x38xf32>) -> tensor<32x32x32x32xf32>
    %1139 = stablehlo.slice %1107 [4:5, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %1140 = stablehlo.reshape %1139 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1141 = stablehlo.broadcast_in_dim %1140, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %1142 = stablehlo.broadcast_in_dim %1141, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %1143 = stablehlo.multiply %1142, %1138 : tensor<32x32x32x32xf32>
    %1144 = stablehlo.add %1137, %1143 : tensor<32x32x32x32xf32>
    %1145 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 1:33] : (tensor<32x32x32x38xf32>) -> tensor<32x32x32x32xf32>
    %1146 = stablehlo.slice %1107 [5:6, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %1147 = stablehlo.reshape %1146 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1148 = stablehlo.broadcast_in_dim %1147, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %1149 = stablehlo.broadcast_in_dim %1148, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %1150 = stablehlo.multiply %1149, %1145 : tensor<32x32x32x32xf32>
    %1151 = stablehlo.add %1144, %1150 : tensor<32x32x32x32xf32>
    %1152 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x38xf32>) -> tensor<32x32x32x32xf32>
    %1153 = stablehlo.slice %1107 [6:7, 0:32, 0:32] : (tensor<7x32x32xf32>) -> tensor<1x32x32xf32>
    %1154 = stablehlo.reshape %1153 : (tensor<1x32x32xf32>) -> tensor<32x32xf32>
    %1155 = stablehlo.broadcast_in_dim %1154, dims = [0, 1] : (tensor<32x32xf32>) -> tensor<32x32x1x1xf32>
    %1156 = stablehlo.broadcast_in_dim %1155, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf32>) -> tensor<32x32x32x32xf32>
    %1157 = stablehlo.multiply %1156, %1152 : tensor<32x32x32x32xf32>
    %1158 = stablehlo.add %1151, %1157 : tensor<32x32x32x32xf32>
    %1159 = stablehlo.slice %1158 [0:32, 0:32, 0:32, 0:16] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x16xf32>
    %1160 = call @_roll_static_45(%1159) : (tensor<32x32x32x16xf32>) -> tensor<32x32x32x16xf32>
    %1161 = stablehlo.slice %1158 [0:32, 0:32, 0:32, 16:32] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x16xf32>
    %1162 = call @_roll_static_50(%1161) : (tensor<32x32x32x16xf32>) -> tensor<32x32x32x16xf32>
    %1163 = stablehlo.concatenate %1160, %1162, dim = 3 : (tensor<32x32x32x16xf32>, tensor<32x32x32x16xf32>) -> tensor<32x32x32x32xf32>
    %cst_248 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %1164 = stablehlo.broadcast_in_dim %cst_248, dims = [] : (tensor<f32>) -> tensor<32x32x32x32xf32>
    %1165 = call @_roll_static_55(%1163) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1166 = stablehlo.slice %205 [0:1, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %1167 = stablehlo.reshape %1166 : (tensor<1x32xf32>) -> tensor<32xf32>
    %1168 = stablehlo.reshape %1167 : (tensor<32xf32>) -> tensor<1x1x1x32xf32>
    %1169 = stablehlo.broadcast_in_dim %1168, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf32>) -> tensor<32x32x32x32xf32>
    %1170 = stablehlo.multiply %1165, %1169 : tensor<32x32x32x32xf32>
    %1171 = stablehlo.add %1164, %1170 : tensor<32x32x32x32xf32>
    %1172 = call @_roll_static_61(%1163) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1173 = stablehlo.slice %205 [1:2, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %1174 = stablehlo.reshape %1173 : (tensor<1x32xf32>) -> tensor<32xf32>
    %1175 = stablehlo.reshape %1174 : (tensor<32xf32>) -> tensor<1x1x1x32xf32>
    %1176 = stablehlo.broadcast_in_dim %1175, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf32>) -> tensor<32x32x32x32xf32>
    %1177 = stablehlo.multiply %1172, %1176 : tensor<32x32x32x32xf32>
    %1178 = stablehlo.add %1171, %1177 : tensor<32x32x32x32xf32>
    %1179 = call @_roll_static_65(%1163) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1180 = stablehlo.slice %205 [2:3, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %1181 = stablehlo.reshape %1180 : (tensor<1x32xf32>) -> tensor<32xf32>
    %1182 = stablehlo.reshape %1181 : (tensor<32xf32>) -> tensor<1x1x1x32xf32>
    %1183 = stablehlo.broadcast_in_dim %1182, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf32>) -> tensor<32x32x32x32xf32>
    %1184 = stablehlo.multiply %1179, %1183 : tensor<32x32x32x32xf32>
    %1185 = stablehlo.add %1178, %1184 : tensor<32x32x32x32xf32>
    %1186 = call @_roll_static_68(%1163) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1187 = stablehlo.slice %205 [3:4, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %1188 = stablehlo.reshape %1187 : (tensor<1x32xf32>) -> tensor<32xf32>
    %1189 = stablehlo.reshape %1188 : (tensor<32xf32>) -> tensor<1x1x1x32xf32>
    %1190 = stablehlo.broadcast_in_dim %1189, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf32>) -> tensor<32x32x32x32xf32>
    %1191 = stablehlo.multiply %1186, %1190 : tensor<32x32x32x32xf32>
    %1192 = stablehlo.add %1185, %1191 : tensor<32x32x32x32xf32>
    %1193 = call @_roll_static_72(%1163) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1194 = stablehlo.slice %205 [4:5, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %1195 = stablehlo.reshape %1194 : (tensor<1x32xf32>) -> tensor<32xf32>
    %1196 = stablehlo.reshape %1195 : (tensor<32xf32>) -> tensor<1x1x1x32xf32>
    %1197 = stablehlo.broadcast_in_dim %1196, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf32>) -> tensor<32x32x32x32xf32>
    %1198 = stablehlo.multiply %1193, %1197 : tensor<32x32x32x32xf32>
    %1199 = stablehlo.add %1192, %1198 : tensor<32x32x32x32xf32>
    %1200 = call @_roll_static_76(%1163) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1201 = stablehlo.slice %205 [5:6, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %1202 = stablehlo.reshape %1201 : (tensor<1x32xf32>) -> tensor<32xf32>
    %1203 = stablehlo.reshape %1202 : (tensor<32xf32>) -> tensor<1x1x1x32xf32>
    %1204 = stablehlo.broadcast_in_dim %1203, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf32>) -> tensor<32x32x32x32xf32>
    %1205 = stablehlo.multiply %1200, %1204 : tensor<32x32x32x32xf32>
    %1206 = stablehlo.add %1199, %1205 : tensor<32x32x32x32xf32>
    %1207 = stablehlo.slice %1206 [0:32, 0:32, 0:16, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x32x16x32xf32>
    %1208 = call @_roll_static(%1207) : (tensor<32x32x16x32xf32>) -> tensor<32x32x16x32xf32>
    %1209 = stablehlo.slice %1206 [0:32, 0:32, 16:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x32x16x32xf32>
    %1210 = call @_roll_static_6(%1209) : (tensor<32x32x16x32xf32>) -> tensor<32x32x16x32xf32>
    %1211 = stablehlo.concatenate %1208, %1210, dim = 2 : (tensor<32x32x16x32xf32>, tensor<32x32x16x32xf32>) -> tensor<32x32x32x32xf32>
    %cst_249 = stablehlo.constant dense<0.000000e+00> : tensor<f32>
    %1212 = stablehlo.broadcast_in_dim %cst_249, dims = [] : (tensor<f32>) -> tensor<32x32x32x32xf32>
    %1213 = call @_roll_static_12(%1211) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1214 = stablehlo.slice %102 [0:1, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %1215 = stablehlo.reshape %1214 : (tensor<1x32xf32>) -> tensor<32xf32>
    %1216 = stablehlo.reshape %1215 : (tensor<32xf32>) -> tensor<1x1x32x1xf32>
    %1217 = stablehlo.broadcast_in_dim %1216, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf32>) -> tensor<32x32x32x32xf32>
    %1218 = stablehlo.multiply %1213, %1217 : tensor<32x32x32x32xf32>
    %1219 = stablehlo.add %1212, %1218 : tensor<32x32x32x32xf32>
    %1220 = call @_roll_static_19(%1211) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1221 = stablehlo.slice %102 [1:2, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %1222 = stablehlo.reshape %1221 : (tensor<1x32xf32>) -> tensor<32xf32>
    %1223 = stablehlo.reshape %1222 : (tensor<32xf32>) -> tensor<1x1x32x1xf32>
    %1224 = stablehlo.broadcast_in_dim %1223, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf32>) -> tensor<32x32x32x32xf32>
    %1225 = stablehlo.multiply %1220, %1224 : tensor<32x32x32x32xf32>
    %1226 = stablehlo.add %1219, %1225 : tensor<32x32x32x32xf32>
    %1227 = call @_roll_static_24(%1211) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1228 = stablehlo.slice %102 [2:3, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %1229 = stablehlo.reshape %1228 : (tensor<1x32xf32>) -> tensor<32xf32>
    %1230 = stablehlo.reshape %1229 : (tensor<32xf32>) -> tensor<1x1x32x1xf32>
    %1231 = stablehlo.broadcast_in_dim %1230, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf32>) -> tensor<32x32x32x32xf32>
    %1232 = stablehlo.multiply %1227, %1231 : tensor<32x32x32x32xf32>
    %1233 = stablehlo.add %1226, %1232 : tensor<32x32x32x32xf32>
    %1234 = call @_roll_static_29(%1211) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1235 = stablehlo.slice %102 [3:4, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %1236 = stablehlo.reshape %1235 : (tensor<1x32xf32>) -> tensor<32xf32>
    %1237 = stablehlo.reshape %1236 : (tensor<32xf32>) -> tensor<1x1x32x1xf32>
    %1238 = stablehlo.broadcast_in_dim %1237, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf32>) -> tensor<32x32x32x32xf32>
    %1239 = stablehlo.multiply %1234, %1238 : tensor<32x32x32x32xf32>
    %1240 = stablehlo.add %1233, %1239 : tensor<32x32x32x32xf32>
    %1241 = call @_roll_static_34(%1211) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1242 = stablehlo.slice %102 [4:5, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %1243 = stablehlo.reshape %1242 : (tensor<1x32xf32>) -> tensor<32xf32>
    %1244 = stablehlo.reshape %1243 : (tensor<32xf32>) -> tensor<1x1x32x1xf32>
    %1245 = stablehlo.broadcast_in_dim %1244, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf32>) -> tensor<32x32x32x32xf32>
    %1246 = stablehlo.multiply %1241, %1245 : tensor<32x32x32x32xf32>
    %1247 = stablehlo.add %1240, %1246 : tensor<32x32x32x32xf32>
    %1248 = call @_roll_static_39(%1211) : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1249 = stablehlo.slice %102 [5:6, 0:32] : (tensor<6x32xf32>) -> tensor<1x32xf32>
    %1250 = stablehlo.reshape %1249 : (tensor<1x32xf32>) -> tensor<32xf32>
    %1251 = stablehlo.reshape %1250 : (tensor<32xf32>) -> tensor<1x1x32x1xf32>
    %1252 = stablehlo.broadcast_in_dim %1251, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf32>) -> tensor<32x32x32x32xf32>
    %1253 = stablehlo.multiply %1248, %1252 : tensor<32x32x32x32xf32>
    %1254 = stablehlo.add %1247, %1253 : tensor<32x32x32x32xf32>
    return %1254, %302#2, %302#3 : tensor<32x32x32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>
  }
  func.func private @_roll_static(%arg0: tensor<32x32x16x32xf32>) -> tensor<32x32x16x32xf32> {
    %0 = stablehlo.slice %arg0 [1:32, 0:32, 0:16, 0:32] : (tensor<32x32x16x32xf32>) -> tensor<31x32x16x32xf32>
    %1 = stablehlo.slice %arg0 [0:1, 0:32, 0:16, 0:32] : (tensor<32x32x16x32xf32>) -> tensor<1x32x16x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<31x32x16x32xf32>, tensor<1x32x16x32xf32>) -> tensor<32x32x16x32xf32>
    return %2 : tensor<32x32x16x32xf32>
  }
  func.func private @_roll_static_6(%arg0: tensor<32x32x16x32xf32>) -> tensor<32x32x16x32xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 0:32, 0:16, 0:32] : (tensor<32x32x16x32xf32>) -> tensor<32x32x16x32xf32>
    %1 = stablehlo.slice %arg0 [0:0, 0:32, 0:16, 0:32] : (tensor<32x32x16x32xf32>) -> tensor<0x32x16x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<32x32x16x32xf32>, tensor<0x32x16x32xf32>) -> tensor<32x32x16x32xf32>
    return %2 : tensor<32x32x16x32xf32>
  }
  func.func private @_roll_static_12(%arg0: tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [2:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<30x32x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:2, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<2x32x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<30x32x32x32xf32>, tensor<2x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %2 : tensor<32x32x32x32xf32>
  }
  func.func private @_roll_static_19(%arg0: tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [1:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<31x32x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:1, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<1x32x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<31x32x32x32xf32>, tensor<1x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %2 : tensor<32x32x32x32xf32>
  }
  func.func private @_roll_static_24(%arg0: tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:0, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<0x32x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<32x32x32x32xf32>, tensor<0x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %2 : tensor<32x32x32x32xf32>
  }
  func.func private @_roll_static_29(%arg0: tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [31:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<1x32x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:31, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<31x32x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<1x32x32x32xf32>, tensor<31x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %2 : tensor<32x32x32x32xf32>
  }
  func.func private @_roll_static_34(%arg0: tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [30:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<2x32x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:30, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<30x32x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<2x32x32x32xf32>, tensor<30x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %2 : tensor<32x32x32x32xf32>
  }
  func.func private @_roll_static_39(%arg0: tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [29:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<3x32x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:29, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<29x32x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<3x32x32x32xf32>, tensor<29x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %2 : tensor<32x32x32x32xf32>
  }
  func.func private @_roll_static_45(%arg0: tensor<32x32x32x16xf32>) -> tensor<32x32x32x16xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 1:32, 0:32, 0:16] : (tensor<32x32x32x16xf32>) -> tensor<32x31x32x16xf32>
    %1 = stablehlo.slice %arg0 [0:32, 0:1, 0:32, 0:16] : (tensor<32x32x32x16xf32>) -> tensor<32x1x32x16xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x31x32x16xf32>, tensor<32x1x32x16xf32>) -> tensor<32x32x32x16xf32>
    return %2 : tensor<32x32x32x16xf32>
  }
  func.func private @_roll_static_50(%arg0: tensor<32x32x32x16xf32>) -> tensor<32x32x32x16xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 0:32, 0:32, 0:16] : (tensor<32x32x32x16xf32>) -> tensor<32x32x32x16xf32>
    %1 = stablehlo.slice %arg0 [0:32, 0:0, 0:32, 0:16] : (tensor<32x32x32x16xf32>) -> tensor<32x0x32x16xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x32x32x16xf32>, tensor<32x0x32x16xf32>) -> tensor<32x32x32x16xf32>
    return %2 : tensor<32x32x32x16xf32>
  }
  func.func private @_roll_static_55(%arg0: tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 2:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x30x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:32, 0:2, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x2x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x30x32x32xf32>, tensor<32x2x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %2 : tensor<32x32x32x32xf32>
  }
  func.func private @_roll_static_61(%arg0: tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 1:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x31x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:32, 0:1, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x1x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x31x32x32xf32>, tensor<32x1x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %2 : tensor<32x32x32x32xf32>
  }
  func.func private @_roll_static_65(%arg0: tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:32, 0:0, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x0x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x32x32x32xf32>, tensor<32x0x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %2 : tensor<32x32x32x32xf32>
  }
  func.func private @_roll_static_68(%arg0: tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 31:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x1x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:32, 0:31, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x31x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x1x32x32xf32>, tensor<32x31x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %2 : tensor<32x32x32x32xf32>
  }
  func.func private @_roll_static_72(%arg0: tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 30:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x2x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:32, 0:30, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x30x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x2x32x32xf32>, tensor<32x30x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %2 : tensor<32x32x32x32xf32>
  }
  func.func private @_roll_static_76(%arg0: tensor<32x32x32x32xf32>) -> tensor<32x32x32x32xf32> {
    %0 = stablehlo.slice %arg0 [0:32, 29:32, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x3x32x32xf32>
    %1 = stablehlo.slice %arg0 [0:32, 0:29, 0:32, 0:32] : (tensor<32x32x32x32xf32>) -> tensor<32x29x32x32xf32>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x3x32x32xf32>, tensor<32x29x32x32xf32>) -> tensor<32x32x32x32xf32>
    return %2 : tensor<32x32x32x32xf32>
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
    %12 = call @fft_85(%11) : (tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32>
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
    %23 = call @fft_85(%17) : (tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32>
    %24 = call @fft_85(%22) : (tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32>
    return %23, %24, %8, %12 : tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>, tensor<32x32xf32>
  }
  func.func private @fft(%arg0: tensor<32x32xf32>) -> tensor<32x17xcomplex<f32>> {
    %0 = stablehlo.fft %arg0, type =  RFFT, length = [32, 32] : (tensor<32x32xf32>) -> tensor<32x17xcomplex<f32>>
    return %0 : tensor<32x17xcomplex<f32>>
  }
  func.func private @fft_85(%arg0: tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32> {
    %0 = stablehlo.fft %arg0, type =  IRFFT, length = [32, 32] : (tensor<32x17xcomplex<f32>>) -> tensor<32x32xf32>
    return %0 : tensor<32x32xf32>
  }
  func.func private @_where(%arg0: tensor<32x32xi1>, %arg1: tensor<32x32xf32>, %arg2: tensor<f32>) -> tensor<32x32xf32> {
    %0 = stablehlo.convert %arg2 : tensor<f32>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f32>) -> tensor<32x32xf32>
    %2 = stablehlo.select %arg0, %arg1, %1 : tensor<32x32xi1>, tensor<32x32xf32>
    return %2 : tensor<32x32xf32>
  }
  func.func private @_pad(%arg0: tensor<32x32x32x32xf32>, %arg1: tensor<i32>) -> tensor<32x32x38x32xf32> {
    %0 = stablehlo.convert %arg1 : (tensor<i32>) -> tensor<f32>
    %1 = stablehlo.pad %arg0, %0, low = [0, 0, 3, 0], high = [0, 0, 3, 0], interior = [0, 0, 0, 0] : (tensor<32x32x32x32xf32>, tensor<f32>) -> tensor<32x32x38x32xf32>
    return %1 : tensor<32x32x38x32xf32>
  }
  func.func private @_pad_129(%arg0: tensor<32x32x32x32xf32>, %arg1: tensor<i32>) -> tensor<32x32x32x38xf32> {
    %0 = stablehlo.convert %arg1 : (tensor<i32>) -> tensor<f32>
    %1 = stablehlo.pad %arg0, %0, low = [0, 0, 0, 3], high = [0, 0, 0, 3], interior = [0, 0, 0, 0] : (tensor<32x32x32x32xf32>, tensor<f32>) -> tensor<32x32x32x38xf32>
    return %1 : tensor<32x32x32x38xf32>
  }
}
