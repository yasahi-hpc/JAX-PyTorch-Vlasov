module @jit__lambda_ attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<32x32x32x32xf64>) -> (tensor<32x32x32x32xf64> {jax.result_info = "[0]"}, tensor<32x32xf64> {jax.result_info = "[1]"}, tensor<32x32xf64> {jax.result_info = "[2]"}) {
    %cst = stablehlo.constant dense<[-5.000000e+00, -4.67741935483871, -4.3548387096774199, -4.0322580645161281, -3.7096774193548385, -3.387096774193548, -3.064516129032258, -2.741935483870968, -2.4193548387096779, -2.0967741935483875, -1.7741935483870974, -1.4516129032258063, -1.129032258064516, -0.80645161290322598, -0.4838709677419355, -0.16129032258064502, 0.16129032258064502, 0.48387096774193505, 0.80645161290322553, 1.129032258064516, 1.4516129032258061, 1.7741935483870965, 2.096774193548387, 2.419354838709677, 2.741935483870968, 3.064516129032258, 3.387096774193548, 3.7096774193548385, 4.0322580645161281, 4.354838709677419, 4.67741935483871, 5.000000e+00]> : tensor<32xf64>
    %c = stablehlo.constant dense<[-2, -1, 0, 1, 2, 3]> : tensor<6xi32>
    %cst_0 = stablehlo.constant dense<[-5.000000e+00, -4.67741935483871, -4.3548387096774199, -4.0322580645161281, -3.7096774193548385, -3.387096774193548, -3.064516129032258, -2.741935483870968, -2.4193548387096779, -2.0967741935483875, -1.7741935483870974, -1.4516129032258063, -1.129032258064516, -0.80645161290322598, -0.4838709677419355, -0.16129032258064502, 0.16129032258064502, 0.48387096774193505, 0.80645161290322553, 1.129032258064516, 1.4516129032258061, 1.7741935483870965, 2.096774193548387, 2.419354838709677, 2.741935483870968, 3.064516129032258, 3.387096774193548, 3.7096774193548385, 4.0322580645161281, 4.354838709677419, 4.67741935483871, 5.000000e+00]> : tensor<32xf64>
    %cst_1 = stablehlo.constant dense<[[0.000000e+00], [5.000000e-01], [1.000000e+00], [1.500000e+00], [2.000000e+00], [2.500000e+00], [3.000000e+00], [3.5000000000000004], [4.000000e+00], [4.500000e+00], [5.000000e+00], [5.500000e+00], [6.000000e+00], [6.4999999999999991], [7.0000000000000009], [7.500000e+00], [-8.000000e+00], [-7.500000e+00], [-7.0000000000000009], [-6.4999999999999991], [-6.000000e+00], [-5.500000e+00], [-5.000000e+00], [-4.500000e+00], [-4.000000e+00], [-3.5000000000000004], [-3.000000e+00], [-2.500000e+00], [-2.000000e+00], [-1.500000e+00], [-1.000000e+00], [-5.000000e-01]]> : tensor<32x1xf64>
    %cst_2 = stablehlo.constant dense<[[0.000000e+00, 5.000000e-01, 1.000000e+00, 1.500000e+00, 2.000000e+00, 2.500000e+00, 3.000000e+00, 3.5000000000000004, 4.000000e+00, 4.500000e+00, 5.000000e+00, 5.500000e+00, 6.000000e+00, 6.4999999999999991, 7.0000000000000009, 7.500000e+00, 8.000000e+00]]> : tensor<1x17xf64>
    %cst_3 = stablehlo.constant dense<"0x00000000000000000000000000001040000000000000F03F1CC7711CC771DC3F000000000000D03F7B14AE47E17AC43F1CC7711CC771BC3F38052FA7E0E5B43F000000000000B03FE0E9D6FCB048A93F7B14AE47E17AA43F909CE66BF5ECA03F1CC7711CC7719C3FDFBEB27A973C983F38052FA7E0E5943FDFBC9A785634923F000000000000903F000000000000104000000000000000409A9999999999E93F9A9999999999D93F1E1E1E1E1E1ECE3F143BB1133BB1C33FD0BAC114F9ACBB3F7914AE47E17AB43F20F8811FF881AF3FFA189C8FC1F9A83FFBD96265F846A43F3BDABC4F71C9A03FF0F8C3018F3F9C3F1A1818181818983F6DAF2587B8CA943F78FB2181B71F923F20E01FE01FE08F3F000000000000F03F9A9999999999E93F000000000000E03F143BB1133BB1D33F9A9999999999C93F967B1A61B9A7C13F9A9999999999B93FC0782BFB1C52B33F1E1E1E1E1E1EAE3F181818181818A83F143BB1133BB1A33FFCA9F1D24D62A03FD0BAC114F9AC9B3FC6ECE00822AD973F7914AE47E17A943F74B83F3BEFE2913F20F8811FF8818F3F1CC7711CC771DC3F9A9999999999D93F143BB1133BB1D33F1CC7711CC771CC3F7B14AE47E17AC43F1E1E1E1E1E1EBE3F176CC1166CC1B63F957B1A61B9A7B13FE0C08103070EAC3F176CC1166CC1A63FA02C814DFBC9A23F20F8811FF8819F3F1B70C51A70C59A3F72810B5CE002973FF913B03F01FB933F121881111881913F028E45F8C7E98E3F000000000000D03F1E1E1E1E1E1ECE3F9A9999999999C93F7B14AE47E17AC43F000000000000C03FFA189C8FC1F9B83F143BB1133BB1B33F1EF8811FF881AF3F9A9999999999A93F15F8E2EA071DA53F967B1A61B9A7A13F8A86F8E3D6E59D3F9A9999999999993F42620177FA23963FC0782BFB1C52933F11F0FE10F0FE903F1E1E1E1E1E1E8E3F7B14AE47E17AC43F143BB1133BB1C33F967B1A61B9A7C13F1E1E1E1E1E1EBE3FFA189C8FC1F9B83F7B14AE47E17AB43F3BDABC4F71C9B03FCEBAC114F9ACAB3F70810B5CE002A73FC1782BFB1C52A33FFCA9F1D24D62A03FE0C08103070E9C3FDDBEB27A973C983F17F8E2EA071D953F11B08812B088923FFCA9F1D24D62903F1A5BFCA32C278D3F1CC7711CC771BC3FD0BAC114F9ACBB3F9A9999999999B93F176CC1166CC1B63F143BB1133BB1B33F3BDABC4F71C9B03F1CC7711CC771AC3F171818181818A83F7B14AE47E17AA43F121881111881A13F1E1E1E1E1E1E9E3F024B7AF9D3169A3F176CC1166CC1963FFD13B03F01FB933F957B1A61B9A7913FB5DBA0AC10638F3FE0C08103070E8C3F38052FA7E0E5B43F7914AE47E17AB43FC0782BFB1C52B33F957B1A61B9A7B13F1EF8811FF881AF3FCEBAC114F9ACAB3F171818181818A83F38052FA7E0E5A43F77FB2181B71FA23F20F8811FF8819F3F8B33DA3D6C7D9B3F181818181818983FEB0FF4480939953FA12C814DFBC9923FC69D25ECE6B7903F8A86F8E3D6E58D3F5E90947FE8DB8A3F000000000000B03F20F8811FF881AF3F1E1E1E1E1E1EAE3FE0C08103070EAC3F9A9999999999A93F70810B5CE002A73F7B14AE47E17AA43F77FB2181B71FA23F000000000000A03FF0F8C3018F3F9C3FFA189C8FC1F9983F40620177FA23963F143BB1133BB1933F9DA28C805394913F1EF8811FF8818F3F86490DD194588C3F9A9999999999893FE0E9D6FCB048A93FFA189C8FC1F9A83F181818181818A83F176CC1166CC1A63F15F8E2EA071DA53FC1782BFB1C52A33F121881111881A13F20F8811FF8819F3FF0F8C3018F3F9C3FE0E9D6FCB048993F907253D13CA1963FFBD96265F846943FDFBC9A785634923FFDA9F1D24D62903F887F1E23F2928D3F1B70C51A70C58A3F140678C2004F883F7B14AE47E17AA43FFBD96265F846A43F143BB1133BB1A33FA02C814DFBC9A23F967B1A61B9A7A13FFCA9F1D24D62A03F1E1E1E1E1E1E9E3F8B33DA3D6C7D9B3FFA189C8FC1F9983F907253D13CA1963F7B14AE47E17A943F13B08812B088923F3BDABC4F71C9903FE65097A51A748E3FCEBAC114F9AC8B3FE62C9B7FC634893F70810B5CE002873F909CE66BF5ECA03F3BDABC4F71C9A03FFCA9F1D24D62A03F20F8811FF8819F3F8A86F8E3D6E59D3FE0C08103070E9C3F024B7AF9D3169A3F181818181818983F40620177FA23963FFBD96265F846943F13B08812B088923F909CE66BF5EC903F028E45F8C7E98E3FF2F8C3018F3F8C3F2C686B179FD7893FC3ECE00822AD873F91FA47C6BCBA853F1CC7711CC7719C3FF0F8C3018F3F9C3FD0BAC114F9AC9B3F1B70C51A70C59A3F9A9999999999993FDDBEB27A973C983F176CC1166CC1963FEB0FF4480939953F143BB1133BB1933FDFBC9A785634923F3BDABC4F71C9903F028E45F8C7E98E3F1CC7711CC7718C3FA21CC5872A2C8A3F171818181818883FDEC08AB85633863F7B14AE47E17A843FDFBEB27A973C983F1A1818181818983FC6ECE00822AD973F72810B5CE002973F42620177FA23963F17F8E2EA071D953FFD13B03F01FB933FA12C814DFBC9923F9DA28C805394913FFDA9F1D24D62903FE65097A51A748E3FF2F8C3018F3F8C3FA21CC5872A2C8A3FDFBEB27A973C883F1A6701369F71863F6FAF2587B8CA843F4713E0AC7946833F38052FA7E0E5943F6DAF2587B8CA943F7914AE47E17A943FF913B03F01FB933FC0782BFB1C52933F11B08812B088923F957B1A61B9A7913FC69D25ECE6B7903F1EF8811FF8818F3F887F1E23F2928D3FCEBAC114F9AC8B3F2C686B179FD7893F171818181818883F1A6701369F71863F38052FA7E0E5843FED45C9D15B75833F77FB2181B71F823FDFBC9A785634923F78FB2181B71F923F74B83F3BEFE2913F121881111881913F11F0FE10F0FE903FFCA9F1D24D62903FB5DBA0AC10638F3F8A86F8E3D6E58D3F86490DD194588C3F1B70C51A70C58A3FE62C9B7FC634893FC3ECE00822AD873FDEC08AB85633863F6FAF2587B8CA843FED45C9D15B75833FDFBC9A785634823F801001BEFB07813F000000000000903F20E01FE01FE08F3F20F8811FF8818F3F028E45F8C7E98E3F1E1E1E1E1E1E8E3F1A5BFCA32C278D3FE0C08103070E8C3F5E90947FE8DB8A3F9A9999999999893F140678C2004F883F70810B5CE002873F91FA47C6BCBA853F7B14AE47E17A843F4713E0AC7946833F77FB2181B71F823F801001BEFB07813F000000000000803FDFBC9A785634923F78FB2181B71F923F74B83F3BEFE2913F121881111881913F11F0FE10F0FE903FFCA9F1D24D62903FB5DBA0AC10638F3F8A86F8E3D6E58D3F86490DD194588C3F1B70C51A70C58A3FE62C9B7FC634893FC3ECE00822AD873FDEC08AB85633863F6FAF2587B8CA843FED45C9D15B75833FDFBC9A785634823F801001BEFB07813F38052FA7E0E5943F6DAF2587B8CA943F7914AE47E17A943FF913B03F01FB933FC0782BFB1C52933F11B08812B088923F957B1A61B9A7913FC69D25ECE6B7903F1EF8811FF8818F3F887F1E23F2928D3FCEBAC114F9AC8B3F2C686B179FD7893F171818181818883F1A6701369F71863F38052FA7E0E5843FED45C9D15B75833F77FB2181B71F823FDFBEB27A973C983F1A1818181818983FC6ECE00822AD973F72810B5CE002973F42620177FA23963F17F8E2EA071D953FFD13B03F01FB933FA12C814DFBC9923F9DA28C805394913FFDA9F1D24D62903FE65097A51A748E3FF2F8C3018F3F8C3FA21CC5872A2C8A3FDFBEB27A973C883F1A6701369F71863F6FAF2587B8CA843F4713E0AC7946833F1CC7711CC7719C3FF0F8C3018F3F9C3FD0BAC114F9AC9B3F1B70C51A70C59A3F9A9999999999993FDDBEB27A973C983F176CC1166CC1963FEB0FF4480939953F143BB1133BB1933FDFBC9A785634923F3BDABC4F71C9903F028E45F8C7E98E3F1CC7711CC7718C3FA21CC5872A2C8A3F171818181818883FDEC08AB85633863F7B14AE47E17A843F909CE66BF5ECA03F3BDABC4F71C9A03FFCA9F1D24D62A03F20F8811FF8819F3F8A86F8E3D6E59D3FE0C08103070E9C3F024B7AF9D3169A3F181818181818983F40620177FA23963FFBD96265F846943F13B08812B088923F909CE66BF5EC903F028E45F8C7E98E3FF2F8C3018F3F8C3F2C686B179FD7893FC3ECE00822AD873F91FA47C6BCBA853F7B14AE47E17AA43FFBD96265F846A43F143BB1133BB1A33FA02C814DFBC9A23F967B1A61B9A7A13FFCA9F1D24D62A03F1E1E1E1E1E1E9E3F8B33DA3D6C7D9B3FFA189C8FC1F9983F907253D13CA1963F7B14AE47E17A943F13B08812B088923F3BDABC4F71C9903FE65097A51A748E3FCEBAC114F9AC8B3FE62C9B7FC634893F70810B5CE002873FE0E9D6FCB048A93FFA189C8FC1F9A83F181818181818A83F176CC1166CC1A63F15F8E2EA071DA53FC1782BFB1C52A33F121881111881A13F20F8811FF8819F3FF0F8C3018F3F9C3FE0E9D6FCB048993F907253D13CA1963FFBD96265F846943FDFBC9A785634923FFDA9F1D24D62903F887F1E23F2928D3F1B70C51A70C58A3F140678C2004F883F000000000000B03F20F8811FF881AF3F1E1E1E1E1E1EAE3FE0C08103070EAC3F9A9999999999A93F70810B5CE002A73F7B14AE47E17AA43F77FB2181B71FA23F000000000000A03FF0F8C3018F3F9C3FFA189C8FC1F9983F40620177FA23963F143BB1133BB1933F9DA28C805394913F1EF8811FF8818F3F86490DD194588C3F9A9999999999893F38052FA7E0E5B43F7914AE47E17AB43FC0782BFB1C52B33F957B1A61B9A7B13F1EF8811FF881AF3FCEBAC114F9ACAB3F171818181818A83F38052FA7E0E5A43F77FB2181B71FA23F20F8811FF8819F3F8B33DA3D6C7D9B3F181818181818983FEB0FF4480939953FA12C814DFBC9923FC69D25ECE6B7903F8A86F8E3D6E58D3F5E90947FE8DB8A3F1CC7711CC771BC3FD0BAC114F9ACBB3F9A9999999999B93F176CC1166CC1B63F143BB1133BB1B33F3BDABC4F71C9B03F1CC7711CC771AC3F171818181818A83F7B14AE47E17AA43F121881111881A13F1E1E1E1E1E1E9E3F024B7AF9D3169A3F176CC1166CC1963FFD13B03F01FB933F957B1A61B9A7913FB5DBA0AC10638F3FE0C08103070E8C3F7B14AE47E17AC43F143BB1133BB1C33F967B1A61B9A7C13F1E1E1E1E1E1EBE3FFA189C8FC1F9B83F7B14AE47E17AB43F3BDABC4F71C9B03FCEBAC114F9ACAB3F70810B5CE002A73FC1782BFB1C52A33FFCA9F1D24D62A03FE0C08103070E9C3FDDBEB27A973C983F17F8E2EA071D953F11B08812B088923FFCA9F1D24D62903F1A5BFCA32C278D3F000000000000D03F1E1E1E1E1E1ECE3F9A9999999999C93F7B14AE47E17AC43F000000000000C03FFA189C8FC1F9B83F143BB1133BB1B33F1EF8811FF881AF3F9A9999999999A93F15F8E2EA071DA53F967B1A61B9A7A13F8A86F8E3D6E59D3F9A9999999999993F42620177FA23963FC0782BFB1C52933F11F0FE10F0FE903F1E1E1E1E1E1E8E3F1CC7711CC771DC3F9A9999999999D93F143BB1133BB1D33F1CC7711CC771CC3F7B14AE47E17AC43F1E1E1E1E1E1EBE3F176CC1166CC1B63F957B1A61B9A7B13FE0C08103070EAC3F176CC1166CC1A63FA02C814DFBC9A23F20F8811FF8819F3F1B70C51A70C59A3F72810B5CE002973FF913B03F01FB933F121881111881913F028E45F8C7E98E3F000000000000F03F9A9999999999E93F000000000000E03F143BB1133BB1D33F9A9999999999C93F967B1A61B9A7C13F9A9999999999B93FC0782BFB1C52B33F1E1E1E1E1E1EAE3F181818181818A83F143BB1133BB1A33FFCA9F1D24D62A03FD0BAC114F9AC9B3FC6ECE00822AD973F7914AE47E17A943F74B83F3BEFE2913F20F8811FF8818F3F000000000000104000000000000000409A9999999999E93F9A9999999999D93F1E1E1E1E1E1ECE3F143BB1133BB1C33FD0BAC114F9ACBB3F7914AE47E17AB43F20F8811FF881AF3FFA189C8FC1F9A83FFBD96265F846A43F3BDABC4F71C9A03FF0F8C3018F3F9C3F1A1818181818983F6DAF2587B8CA943F78FB2181B71F923F20E01FE01FE08F3F"> : tensor<32x17xf64>
    %0 = stablehlo.broadcast_in_dim %cst, dims = [1] : (tensor<32xf64>) -> tensor<1x32x1xf64>
    %1 = stablehlo.transpose %arg0, dims = [1, 2, 3, 0] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %2 = stablehlo.reshape %1 : (tensor<32x32x32x32xf64>) -> tensor<32768x32xf64>
    %3 = stablehlo.broadcast_in_dim %0, dims = [0, 1, 2] : (tensor<1x32x1xf64>) -> tensor<32x32x32xf64>
    %4 = stablehlo.reshape %3 : (tensor<32x32x32xf64>) -> tensor<32768xf64>
    %cst_4 = stablehlo.constant dense<2.500000e-02> : tensor<f64>
    %cst_5 = stablehlo.constant dense<0.39269908169872414> : tensor<f64>
    %5 = call @advect_1d_roll_diag(%2, %4, %cst_4, %cst_5, %c) : (tensor<32768x32xf64>, tensor<32768xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<32768x32xf64>
    %6 = stablehlo.reshape %5 : (tensor<32768x32xf64>) -> tensor<32x32x32x32xf64>
    %7 = stablehlo.transpose %6, dims = [3, 0, 1, 2] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %8 = stablehlo.broadcast_in_dim %cst_0, dims = [2] : (tensor<32xf64>) -> tensor<1x1x32xf64>
    %9 = stablehlo.transpose %7, dims = [0, 2, 3, 1] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %10 = stablehlo.reshape %9 : (tensor<32x32x32x32xf64>) -> tensor<32768x32xf64>
    %11 = stablehlo.broadcast_in_dim %8, dims = [0, 1, 2] : (tensor<1x1x32xf64>) -> tensor<32x32x32xf64>
    %12 = stablehlo.reshape %11 : (tensor<32x32x32xf64>) -> tensor<32768xf64>
    %13 = call @advect_1d_roll_diag(%10, %12, %cst_4, %cst_5, %c) : (tensor<32768x32xf64>, tensor<32768xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<32768x32xf64>
    %14 = stablehlo.reshape %13 : (tensor<32768x32xf64>) -> tensor<32x32x32x32xf64>
    %15 = stablehlo.transpose %14, dims = [0, 3, 1, 2] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %cst_6 = stablehlo.constant dense<0.32258064516129031> : tensor<f64>
    %16:4 = call @solve_poisson(%15, %cst_1, %cst_2, %cst_3, %cst_6, %cst_6) : (tensor<32x32x32x32xf64>, tensor<32x1xf64>, tensor<1x17xf64>, tensor<32x17xf64>, tensor<f64>, tensor<f64>) -> (tensor<32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>)
    %17 = stablehlo.broadcast_in_dim %16#0, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1xf64>
    %18 = stablehlo.transpose %15, dims = [0, 1, 3, 2] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %19 = stablehlo.reshape %18 : (tensor<32x32x32x32xf64>) -> tensor<32768x32xf64>
    %20 = stablehlo.broadcast_in_dim %17, dims = [0, 1, 2] : (tensor<32x32x1xf64>) -> tensor<32x32x32xf64>
    %21 = stablehlo.reshape %20 : (tensor<32x32x32xf64>) -> tensor<32768xf64>
    %cst_7 = stablehlo.constant dense<5.000000e-02> : tensor<f64>
    %22 = call @advect_1d_roll_diag_1(%19, %21, %cst_7, %cst_6, %c) : (tensor<32768x32xf64>, tensor<32768xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<32768x32xf64>
    %23 = stablehlo.reshape %22 : (tensor<32768x32xf64>) -> tensor<32x32x32x32xf64>
    %24 = stablehlo.transpose %23, dims = [0, 1, 3, 2] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %25 = stablehlo.broadcast_in_dim %16#1, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1xf64>
    %26 = stablehlo.reshape %24 : (tensor<32x32x32x32xf64>) -> tensor<32768x32xf64>
    %27 = stablehlo.broadcast_in_dim %25, dims = [0, 1, 2] : (tensor<32x32x1xf64>) -> tensor<32x32x32xf64>
    %28 = stablehlo.reshape %27 : (tensor<32x32x32xf64>) -> tensor<32768xf64>
    %29 = call @advect_1d_roll_diag_1(%26, %28, %cst_7, %cst_6, %c) : (tensor<32768x32xf64>, tensor<32768xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<32768x32xf64>
    %30 = stablehlo.reshape %29 : (tensor<32768x32xf64>) -> tensor<32x32x32x32xf64>
    %31 = stablehlo.broadcast_in_dim %cst_0, dims = [2] : (tensor<32xf64>) -> tensor<1x1x32xf64>
    %32 = stablehlo.transpose %30, dims = [0, 2, 3, 1] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %33 = stablehlo.reshape %32 : (tensor<32x32x32x32xf64>) -> tensor<32768x32xf64>
    %34 = stablehlo.broadcast_in_dim %31, dims = [0, 1, 2] : (tensor<1x1x32xf64>) -> tensor<32x32x32xf64>
    %35 = stablehlo.reshape %34 : (tensor<32x32x32xf64>) -> tensor<32768xf64>
    %36 = call @advect_1d_roll_diag(%33, %35, %cst_4, %cst_5, %c) : (tensor<32768x32xf64>, tensor<32768xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<32768x32xf64>
    %37 = stablehlo.reshape %36 : (tensor<32768x32xf64>) -> tensor<32x32x32x32xf64>
    %38 = stablehlo.transpose %37, dims = [0, 3, 1, 2] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %39 = stablehlo.broadcast_in_dim %cst, dims = [1] : (tensor<32xf64>) -> tensor<1x32x1xf64>
    %40 = stablehlo.transpose %38, dims = [1, 2, 3, 0] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %41 = stablehlo.reshape %40 : (tensor<32x32x32x32xf64>) -> tensor<32768x32xf64>
    %42 = stablehlo.broadcast_in_dim %39, dims = [0, 1, 2] : (tensor<1x32x1xf64>) -> tensor<32x32x32xf64>
    %43 = stablehlo.reshape %42 : (tensor<32x32x32xf64>) -> tensor<32768xf64>
    %44 = call @advect_1d_roll_diag(%41, %43, %cst_4, %cst_5, %c) : (tensor<32768x32xf64>, tensor<32768xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<32768x32xf64>
    %45 = stablehlo.reshape %44 : (tensor<32768x32xf64>) -> tensor<32x32x32x32xf64>
    %46 = stablehlo.transpose %45, dims = [3, 0, 1, 2] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %46, %16#2, %16#3 : tensor<32x32x32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>
  }
  func.func private @advect_1d_roll_diag(%arg0: tensor<32768x32xf64>, %arg1: tensor<32768xf64>, %arg2: tensor<f64>, %arg3: tensor<f64>, %arg4: tensor<6xi32>) -> tensor<32768x32xf64> {
    %0 = stablehlo.convert %arg2 : tensor<f64>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %2 = stablehlo.multiply %arg1, %1 : tensor<32768xf64>
    %3 = stablehlo.convert %arg3 : tensor<f64>
    %4 = stablehlo.broadcast_in_dim %3, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %5 = stablehlo.divide %2, %4 : tensor<32768xf64>
    %6 = stablehlo.floor %5 : tensor<32768xf64>
    %7 = stablehlo.subtract %5, %6 : tensor<32768xf64>
    %8 = stablehlo.convert %6 : (tensor<32768xf64>) -> tensor<32768xi32>
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %9 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %10 = stablehlo.multiply %7, %7 : tensor<32768xf64>
    %11 = stablehlo.multiply %10, %7 : tensor<32768xf64>
    %12 = stablehlo.multiply %11, %7 : tensor<32768xf64>
    %13 = stablehlo.multiply %12, %7 : tensor<32768xf64>
    %cst_0 = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %14 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %15 = stablehlo.divide %7, %14 : tensor<32768xf64>
    %cst_1 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %16 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %17 = stablehlo.divide %10, %16 : tensor<32768xf64>
    %18 = stablehlo.subtract %15, %17 : tensor<32768xf64>
    %19 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %20 = stablehlo.divide %11, %19 : tensor<32768xf64>
    %21 = stablehlo.subtract %18, %20 : tensor<32768xf64>
    %22 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %23 = stablehlo.divide %12, %22 : tensor<32768xf64>
    %24 = stablehlo.add %21, %23 : tensor<32768xf64>
    %cst_2 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %25 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %26 = stablehlo.divide %13, %25 : tensor<32768xf64>
    %27 = stablehlo.subtract %24, %26 : tensor<32768xf64>
    %cst_3 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %28 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %29 = stablehlo.divide %7, %28 : tensor<32768xf64>
    %30 = stablehlo.negate %29 : tensor<32768xf64>
    %31 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %32 = stablehlo.multiply %31, %10 : tensor<32768xf64>
    %cst_4 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %33 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %34 = stablehlo.divide %32, %33 : tensor<32768xf64>
    %35 = stablehlo.add %30, %34 : tensor<32768xf64>
    %36 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %37 = stablehlo.divide %11, %36 : tensor<32768xf64>
    %38 = stablehlo.subtract %35, %37 : tensor<32768xf64>
    %cst_5 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %39 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %40 = stablehlo.divide %12, %39 : tensor<32768xf64>
    %41 = stablehlo.subtract %38, %40 : tensor<32768xf64>
    %42 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %43 = stablehlo.divide %13, %42 : tensor<32768xf64>
    %44 = stablehlo.add %41, %43 : tensor<32768xf64>
    %45 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %46 = stablehlo.divide %7, %45 : tensor<32768xf64>
    %cst_6 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %47 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %48 = stablehlo.subtract %47, %46 : tensor<32768xf64>
    %cst_7 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %49 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %50 = stablehlo.multiply %49, %10 : tensor<32768xf64>
    %cst_8 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %51 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %52 = stablehlo.divide %50, %51 : tensor<32768xf64>
    %53 = stablehlo.subtract %48, %52 : tensor<32768xf64>
    %54 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %55 = stablehlo.multiply %54, %11 : tensor<32768xf64>
    %cst_9 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %56 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %57 = stablehlo.divide %55, %56 : tensor<32768xf64>
    %58 = stablehlo.add %53, %57 : tensor<32768xf64>
    %59 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %60 = stablehlo.divide %12, %59 : tensor<32768xf64>
    %61 = stablehlo.add %58, %60 : tensor<32768xf64>
    %62 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %63 = stablehlo.divide %13, %62 : tensor<32768xf64>
    %64 = stablehlo.subtract %61, %63 : tensor<32768xf64>
    %65 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %66 = stablehlo.multiply %65, %10 : tensor<32768xf64>
    %67 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %68 = stablehlo.divide %66, %67 : tensor<32768xf64>
    %69 = stablehlo.add %7, %68 : tensor<32768xf64>
    %cst_10 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %70 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %71 = stablehlo.multiply %70, %11 : tensor<32768xf64>
    %72 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %73 = stablehlo.divide %71, %72 : tensor<32768xf64>
    %74 = stablehlo.subtract %69, %73 : tensor<32768xf64>
    %75 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %76 = stablehlo.divide %12, %75 : tensor<32768xf64>
    %77 = stablehlo.subtract %74, %76 : tensor<32768xf64>
    %78 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %79 = stablehlo.divide %13, %78 : tensor<32768xf64>
    %80 = stablehlo.add %77, %79 : tensor<32768xf64>
    %81 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %82 = stablehlo.divide %7, %81 : tensor<32768xf64>
    %83 = stablehlo.negate %82 : tensor<32768xf64>
    %84 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %85 = stablehlo.divide %10, %84 : tensor<32768xf64>
    %86 = stablehlo.subtract %83, %85 : tensor<32768xf64>
    %87 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %88 = stablehlo.multiply %87, %11 : tensor<32768xf64>
    %89 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %90 = stablehlo.divide %88, %89 : tensor<32768xf64>
    %91 = stablehlo.add %86, %90 : tensor<32768xf64>
    %92 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %93 = stablehlo.divide %12, %92 : tensor<32768xf64>
    %94 = stablehlo.add %91, %93 : tensor<32768xf64>
    %95 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %96 = stablehlo.divide %13, %95 : tensor<32768xf64>
    %97 = stablehlo.subtract %94, %96 : tensor<32768xf64>
    %cst_11 = stablehlo.constant dense<3.000000e+01> : tensor<f64>
    %98 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %99 = stablehlo.divide %7, %98 : tensor<32768xf64>
    %100 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %101 = stablehlo.divide %11, %100 : tensor<32768xf64>
    %102 = stablehlo.subtract %99, %101 : tensor<32768xf64>
    %103 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %104 = stablehlo.divide %13, %103 : tensor<32768xf64>
    %105 = stablehlo.add %102, %104 : tensor<32768xf64>
    %106 = stablehlo.broadcast_in_dim %27, dims = [1] : (tensor<32768xf64>) -> tensor<1x32768xf64>
    %107 = stablehlo.broadcast_in_dim %44, dims = [1] : (tensor<32768xf64>) -> tensor<1x32768xf64>
    %108 = stablehlo.broadcast_in_dim %64, dims = [1] : (tensor<32768xf64>) -> tensor<1x32768xf64>
    %109 = stablehlo.broadcast_in_dim %80, dims = [1] : (tensor<32768xf64>) -> tensor<1x32768xf64>
    %110 = stablehlo.broadcast_in_dim %97, dims = [1] : (tensor<32768xf64>) -> tensor<1x32768xf64>
    %111 = stablehlo.broadcast_in_dim %105, dims = [1] : (tensor<32768xf64>) -> tensor<1x32768xf64>
    %112 = stablehlo.concatenate %106, %107, %108, %109, %110, %111, dim = 0 : (tensor<1x32768xf64>, tensor<1x32768xf64>, tensor<1x32768xf64>, tensor<1x32768xf64>, tensor<1x32768xf64>, tensor<1x32768xf64>) -> tensor<6x32768xf64>
    %113 = stablehlo.slice %arg4 [0:1] : (tensor<6xi32>) -> tensor<1xi32>
    %114 = stablehlo.reshape %113 : (tensor<1xi32>) -> tensor<i32>
    %115 = stablehlo.broadcast_in_dim %114, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %116 = stablehlo.add %8, %115 : tensor<32768xi32>
    %117 = call @_roll_dynamic(%arg0, %116) : (tensor<32768x32xf64>, tensor<32768xi32>) -> tensor<32768x32xf64>
    %118 = stablehlo.slice %112 [0:1, 0:32768] : (tensor<6x32768xf64>) -> tensor<1x32768xf64>
    %119 = stablehlo.reshape %118 : (tensor<1x32768xf64>) -> tensor<32768xf64>
    %120 = stablehlo.broadcast_in_dim %119, dims = [0] : (tensor<32768xf64>) -> tensor<32768x1xf64>
    %121 = stablehlo.broadcast_in_dim %120, dims = [0, 1] : (tensor<32768x1xf64>) -> tensor<32768x32xf64>
    %122 = stablehlo.multiply %117, %121 : tensor<32768x32xf64>
    %123 = stablehlo.add %9, %122 : tensor<32768x32xf64>
    %124 = stablehlo.slice %arg4 [1:2] : (tensor<6xi32>) -> tensor<1xi32>
    %125 = stablehlo.reshape %124 : (tensor<1xi32>) -> tensor<i32>
    %126 = stablehlo.broadcast_in_dim %125, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %127 = stablehlo.add %8, %126 : tensor<32768xi32>
    %128 = call @_roll_dynamic(%arg0, %127) : (tensor<32768x32xf64>, tensor<32768xi32>) -> tensor<32768x32xf64>
    %129 = stablehlo.slice %112 [1:2, 0:32768] : (tensor<6x32768xf64>) -> tensor<1x32768xf64>
    %130 = stablehlo.reshape %129 : (tensor<1x32768xf64>) -> tensor<32768xf64>
    %131 = stablehlo.broadcast_in_dim %130, dims = [0] : (tensor<32768xf64>) -> tensor<32768x1xf64>
    %132 = stablehlo.broadcast_in_dim %131, dims = [0, 1] : (tensor<32768x1xf64>) -> tensor<32768x32xf64>
    %133 = stablehlo.multiply %128, %132 : tensor<32768x32xf64>
    %134 = stablehlo.add %123, %133 : tensor<32768x32xf64>
    %135 = stablehlo.slice %arg4 [2:3] : (tensor<6xi32>) -> tensor<1xi32>
    %136 = stablehlo.reshape %135 : (tensor<1xi32>) -> tensor<i32>
    %137 = stablehlo.broadcast_in_dim %136, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %138 = stablehlo.add %8, %137 : tensor<32768xi32>
    %139 = call @_roll_dynamic(%arg0, %138) : (tensor<32768x32xf64>, tensor<32768xi32>) -> tensor<32768x32xf64>
    %140 = stablehlo.slice %112 [2:3, 0:32768] : (tensor<6x32768xf64>) -> tensor<1x32768xf64>
    %141 = stablehlo.reshape %140 : (tensor<1x32768xf64>) -> tensor<32768xf64>
    %142 = stablehlo.broadcast_in_dim %141, dims = [0] : (tensor<32768xf64>) -> tensor<32768x1xf64>
    %143 = stablehlo.broadcast_in_dim %142, dims = [0, 1] : (tensor<32768x1xf64>) -> tensor<32768x32xf64>
    %144 = stablehlo.multiply %139, %143 : tensor<32768x32xf64>
    %145 = stablehlo.add %134, %144 : tensor<32768x32xf64>
    %146 = stablehlo.slice %arg4 [3:4] : (tensor<6xi32>) -> tensor<1xi32>
    %147 = stablehlo.reshape %146 : (tensor<1xi32>) -> tensor<i32>
    %148 = stablehlo.broadcast_in_dim %147, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %149 = stablehlo.add %8, %148 : tensor<32768xi32>
    %150 = call @_roll_dynamic(%arg0, %149) : (tensor<32768x32xf64>, tensor<32768xi32>) -> tensor<32768x32xf64>
    %151 = stablehlo.slice %112 [3:4, 0:32768] : (tensor<6x32768xf64>) -> tensor<1x32768xf64>
    %152 = stablehlo.reshape %151 : (tensor<1x32768xf64>) -> tensor<32768xf64>
    %153 = stablehlo.broadcast_in_dim %152, dims = [0] : (tensor<32768xf64>) -> tensor<32768x1xf64>
    %154 = stablehlo.broadcast_in_dim %153, dims = [0, 1] : (tensor<32768x1xf64>) -> tensor<32768x32xf64>
    %155 = stablehlo.multiply %150, %154 : tensor<32768x32xf64>
    %156 = stablehlo.add %145, %155 : tensor<32768x32xf64>
    %157 = stablehlo.slice %arg4 [4:5] : (tensor<6xi32>) -> tensor<1xi32>
    %158 = stablehlo.reshape %157 : (tensor<1xi32>) -> tensor<i32>
    %159 = stablehlo.broadcast_in_dim %158, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %160 = stablehlo.add %8, %159 : tensor<32768xi32>
    %161 = call @_roll_dynamic(%arg0, %160) : (tensor<32768x32xf64>, tensor<32768xi32>) -> tensor<32768x32xf64>
    %162 = stablehlo.slice %112 [4:5, 0:32768] : (tensor<6x32768xf64>) -> tensor<1x32768xf64>
    %163 = stablehlo.reshape %162 : (tensor<1x32768xf64>) -> tensor<32768xf64>
    %164 = stablehlo.broadcast_in_dim %163, dims = [0] : (tensor<32768xf64>) -> tensor<32768x1xf64>
    %165 = stablehlo.broadcast_in_dim %164, dims = [0, 1] : (tensor<32768x1xf64>) -> tensor<32768x32xf64>
    %166 = stablehlo.multiply %161, %165 : tensor<32768x32xf64>
    %167 = stablehlo.add %156, %166 : tensor<32768x32xf64>
    %168 = stablehlo.slice %arg4 [5:6] : (tensor<6xi32>) -> tensor<1xi32>
    %169 = stablehlo.reshape %168 : (tensor<1xi32>) -> tensor<i32>
    %170 = stablehlo.broadcast_in_dim %169, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %171 = stablehlo.add %8, %170 : tensor<32768xi32>
    %172 = call @_roll_dynamic(%arg0, %171) : (tensor<32768x32xf64>, tensor<32768xi32>) -> tensor<32768x32xf64>
    %173 = stablehlo.slice %112 [5:6, 0:32768] : (tensor<6x32768xf64>) -> tensor<1x32768xf64>
    %174 = stablehlo.reshape %173 : (tensor<1x32768xf64>) -> tensor<32768xf64>
    %175 = stablehlo.broadcast_in_dim %174, dims = [0] : (tensor<32768xf64>) -> tensor<32768x1xf64>
    %176 = stablehlo.broadcast_in_dim %175, dims = [0, 1] : (tensor<32768x1xf64>) -> tensor<32768x32xf64>
    %177 = stablehlo.multiply %172, %176 : tensor<32768x32xf64>
    %178 = stablehlo.add %167, %177 : tensor<32768x32xf64>
    return %178 : tensor<32768x32xf64>
  }
  func.func private @_roll_dynamic(%arg0: tensor<32768x32xf64>, %arg1: tensor<32768xi32>) -> tensor<32768x32xf64> {
    %0 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<32768xi32>) -> tensor<32768x1xi32>
    %1 = stablehlo.slice %0 [0:32768, 0:1] : (tensor<32768x1xi32>) -> tensor<32768x1xi32>
    %2 = stablehlo.reshape %1 : (tensor<32768x1xi32>) -> tensor<32768xi32>
    %c = stablehlo.constant dense<32> : tensor<i32>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %3 = stablehlo.maximum %c, %c_0 : tensor<i32>
    %4 = call @remainder(%2, %3) : (tensor<32768xi32>, tensor<i32>) -> tensor<32768xi32>
    %5 = stablehlo.concatenate %arg0, %arg0, dim = 1 : (tensor<32768x32xf64>, tensor<32768x32xf64>) -> tensor<32768x64xf64>
    %6 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %7 = stablehlo.subtract %6, %4 : tensor<32768xi32>
    %c_1 = stablehlo.constant dense<0> : tensor<i32>
    %8 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %9 = stablehlo.compare  LT, %7, %8,  SIGNED : (tensor<32768xi32>, tensor<32768xi32>) -> tensor<32768xi1>
    %c_2 = stablehlo.constant dense<64> : tensor<i32>
    %10 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %11 = stablehlo.add %7, %10 : tensor<32768xi32>
    %12 = stablehlo.select %9, %11, %7 : tensor<32768xi1>, tensor<32768xi32>
    %13 = stablehlo.broadcast_in_dim %12, dims = [0] : (tensor<32768xi32>) -> tensor<32768x1xi32>
    %14 = "stablehlo.gather"(%5, %13) <{dimension_numbers = #stablehlo.gather<offset_dims = [1], operand_batching_dims = [0], start_indices_batching_dims = [0], start_index_map = [1], index_vector_dim = 1>, indices_are_sorted = true, slice_sizes = array<i64: 1, 32>}> : (tensor<32768x64xf64>, tensor<32768x1xi32>) -> tensor<32768x32xf64>
    return %14 : tensor<32768x32xf64>
  }
  func.func private @remainder(%arg0: tensor<32768xi32>, %arg1: tensor<i32>) -> tensor<32768xi32> {
    %c = stablehlo.constant dense<0> : tensor<i32>
    %0 = stablehlo.compare  EQ, %arg1, %c,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %1 = call @_where(%0, %c_0, %arg1) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
    %2 = stablehlo.broadcast_in_dim %1, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %3 = stablehlo.remainder %arg0, %2 : tensor<32768xi32>
    %4 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %5 = stablehlo.compare  NE, %3, %4,  SIGNED : (tensor<32768xi32>, tensor<32768xi32>) -> tensor<32768xi1>
    %6 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %7 = stablehlo.compare  LT, %3, %6,  SIGNED : (tensor<32768xi32>, tensor<32768xi32>) -> tensor<32768xi1>
    %8 = stablehlo.compare  LT, %1, %c,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
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
  func.func private @solve_poisson(%arg0: tensor<32x32x32x32xf64>, %arg1: tensor<32x1xf64>, %arg2: tensor<1x17xf64>, %arg3: tensor<32x17xf64>, %arg4: tensor<f64>, %arg5: tensor<f64>) -> (tensor<32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>) {
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %0 = stablehlo.reduce(%arg0 init: %cst) applies stablehlo.add across dimensions = [2, 3] : (tensor<32x32x32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1 = stablehlo.convert %arg4 : tensor<f64>
    %2 = stablehlo.broadcast_in_dim %1, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %3 = stablehlo.multiply %0, %2 : tensor<32x32xf64>
    %4 = stablehlo.convert %arg5 : tensor<f64>
    %5 = stablehlo.broadcast_in_dim %4, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %6 = stablehlo.multiply %3, %5 : tensor<32x32xf64>
    %cst_0 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %7 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %8 = stablehlo.subtract %6, %7 : tensor<32x32xf64>
    %9 = call @fft(%8) : (tensor<32x32xf64>) -> tensor<32x17xcomplex<f64>>
    %10 = stablehlo.convert %arg3 : (tensor<32x17xf64>) -> tensor<32x17xcomplex<f64>>
    %11 = stablehlo.multiply %9, %10 : tensor<32x17xcomplex<f64>>
    %12 = call @fft_0(%11) : (tensor<32x17xcomplex<f64>>) -> tensor<32x32xf64>
    %13 = stablehlo.convert %arg1 : (tensor<32x1xf64>) -> tensor<32x1xcomplex<f64>>
    %cst_1 = stablehlo.constant dense<(-0.000000e+00,-1.000000e+00)> : tensor<complex<f64>>
    %14 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<complex<f64>>) -> tensor<32x1xcomplex<f64>>
    %15 = stablehlo.multiply %14, %13 : tensor<32x1xcomplex<f64>>
    %16 = stablehlo.broadcast_in_dim %15, dims = [0, 1] : (tensor<32x1xcomplex<f64>>) -> tensor<32x17xcomplex<f64>>
    %17 = stablehlo.multiply %16, %11 : tensor<32x17xcomplex<f64>>
    %18 = stablehlo.convert %arg2 : (tensor<1x17xf64>) -> tensor<1x17xcomplex<f64>>
    %19 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<complex<f64>>) -> tensor<1x17xcomplex<f64>>
    %20 = stablehlo.multiply %19, %18 : tensor<1x17xcomplex<f64>>
    %21 = stablehlo.broadcast_in_dim %20, dims = [0, 1] : (tensor<1x17xcomplex<f64>>) -> tensor<32x17xcomplex<f64>>
    %22 = stablehlo.multiply %21, %11 : tensor<32x17xcomplex<f64>>
    %23 = call @fft_0(%17) : (tensor<32x17xcomplex<f64>>) -> tensor<32x32xf64>
    %24 = call @fft_0(%22) : (tensor<32x17xcomplex<f64>>) -> tensor<32x32xf64>
    return %23, %24, %8, %12 : tensor<32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>
  }
  func.func private @fft(%arg0: tensor<32x32xf64>) -> tensor<32x17xcomplex<f64>> {
    %0 = stablehlo.fft %arg0, type =  RFFT, length = [32, 32] : (tensor<32x32xf64>) -> tensor<32x17xcomplex<f64>>
    return %0 : tensor<32x17xcomplex<f64>>
  }
  func.func private @fft_0(%arg0: tensor<32x17xcomplex<f64>>) -> tensor<32x32xf64> {
    %0 = stablehlo.fft %arg0, type =  IRFFT, length = [32, 32] : (tensor<32x17xcomplex<f64>>) -> tensor<32x32xf64>
    return %0 : tensor<32x32xf64>
  }
  func.func private @advect_1d_roll_diag_1(%arg0: tensor<32768x32xf64>, %arg1: tensor<32768xf64>, %arg2: tensor<f64>, %arg3: tensor<f64>, %arg4: tensor<6xi32>) -> tensor<32768x32xf64> {
    %0 = stablehlo.convert %arg2 : tensor<f64>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %2 = stablehlo.multiply %arg1, %1 : tensor<32768xf64>
    %3 = stablehlo.convert %arg3 : tensor<f64>
    %4 = stablehlo.broadcast_in_dim %3, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %5 = stablehlo.divide %2, %4 : tensor<32768xf64>
    %6 = stablehlo.floor %5 : tensor<32768xf64>
    %7 = stablehlo.subtract %5, %6 : tensor<32768xf64>
    %8 = stablehlo.convert %6 : (tensor<32768xf64>) -> tensor<32768xi32>
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %9 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %10 = call @build_v_diag_weights(%arg4, %8, %7) : (tensor<6xi32>, tensor<32768xi32>, tensor<32768xf64>) -> tensor<6x32768x32xf64>
    %11 = stablehlo.slice %arg4 [0:1] : (tensor<6xi32>) -> tensor<1xi32>
    %12 = stablehlo.reshape %11 : (tensor<1xi32>) -> tensor<i32>
    %13 = stablehlo.broadcast_in_dim %12, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %14 = stablehlo.add %8, %13 : tensor<32768xi32>
    %15 = call @_roll_dynamic(%arg0, %14) : (tensor<32768x32xf64>, tensor<32768xi32>) -> tensor<32768x32xf64>
    %16 = stablehlo.slice %10 [0:1, 0:32768, 0:32] : (tensor<6x32768x32xf64>) -> tensor<1x32768x32xf64>
    %17 = stablehlo.reshape %16 : (tensor<1x32768x32xf64>) -> tensor<32768x32xf64>
    %18 = stablehlo.multiply %17, %15 : tensor<32768x32xf64>
    %19 = stablehlo.add %9, %18 : tensor<32768x32xf64>
    %20 = stablehlo.slice %arg4 [1:2] : (tensor<6xi32>) -> tensor<1xi32>
    %21 = stablehlo.reshape %20 : (tensor<1xi32>) -> tensor<i32>
    %22 = stablehlo.broadcast_in_dim %21, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %23 = stablehlo.add %8, %22 : tensor<32768xi32>
    %24 = call @_roll_dynamic(%arg0, %23) : (tensor<32768x32xf64>, tensor<32768xi32>) -> tensor<32768x32xf64>
    %25 = stablehlo.slice %10 [1:2, 0:32768, 0:32] : (tensor<6x32768x32xf64>) -> tensor<1x32768x32xf64>
    %26 = stablehlo.reshape %25 : (tensor<1x32768x32xf64>) -> tensor<32768x32xf64>
    %27 = stablehlo.multiply %26, %24 : tensor<32768x32xf64>
    %28 = stablehlo.add %19, %27 : tensor<32768x32xf64>
    %29 = stablehlo.slice %arg4 [2:3] : (tensor<6xi32>) -> tensor<1xi32>
    %30 = stablehlo.reshape %29 : (tensor<1xi32>) -> tensor<i32>
    %31 = stablehlo.broadcast_in_dim %30, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %32 = stablehlo.add %8, %31 : tensor<32768xi32>
    %33 = call @_roll_dynamic(%arg0, %32) : (tensor<32768x32xf64>, tensor<32768xi32>) -> tensor<32768x32xf64>
    %34 = stablehlo.slice %10 [2:3, 0:32768, 0:32] : (tensor<6x32768x32xf64>) -> tensor<1x32768x32xf64>
    %35 = stablehlo.reshape %34 : (tensor<1x32768x32xf64>) -> tensor<32768x32xf64>
    %36 = stablehlo.multiply %35, %33 : tensor<32768x32xf64>
    %37 = stablehlo.add %28, %36 : tensor<32768x32xf64>
    %38 = stablehlo.slice %arg4 [3:4] : (tensor<6xi32>) -> tensor<1xi32>
    %39 = stablehlo.reshape %38 : (tensor<1xi32>) -> tensor<i32>
    %40 = stablehlo.broadcast_in_dim %39, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %41 = stablehlo.add %8, %40 : tensor<32768xi32>
    %42 = call @_roll_dynamic(%arg0, %41) : (tensor<32768x32xf64>, tensor<32768xi32>) -> tensor<32768x32xf64>
    %43 = stablehlo.slice %10 [3:4, 0:32768, 0:32] : (tensor<6x32768x32xf64>) -> tensor<1x32768x32xf64>
    %44 = stablehlo.reshape %43 : (tensor<1x32768x32xf64>) -> tensor<32768x32xf64>
    %45 = stablehlo.multiply %44, %42 : tensor<32768x32xf64>
    %46 = stablehlo.add %37, %45 : tensor<32768x32xf64>
    %47 = stablehlo.slice %arg4 [4:5] : (tensor<6xi32>) -> tensor<1xi32>
    %48 = stablehlo.reshape %47 : (tensor<1xi32>) -> tensor<i32>
    %49 = stablehlo.broadcast_in_dim %48, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %50 = stablehlo.add %8, %49 : tensor<32768xi32>
    %51 = call @_roll_dynamic(%arg0, %50) : (tensor<32768x32xf64>, tensor<32768xi32>) -> tensor<32768x32xf64>
    %52 = stablehlo.slice %10 [4:5, 0:32768, 0:32] : (tensor<6x32768x32xf64>) -> tensor<1x32768x32xf64>
    %53 = stablehlo.reshape %52 : (tensor<1x32768x32xf64>) -> tensor<32768x32xf64>
    %54 = stablehlo.multiply %53, %51 : tensor<32768x32xf64>
    %55 = stablehlo.add %46, %54 : tensor<32768x32xf64>
    %56 = stablehlo.slice %arg4 [5:6] : (tensor<6xi32>) -> tensor<1xi32>
    %57 = stablehlo.reshape %56 : (tensor<1xi32>) -> tensor<i32>
    %58 = stablehlo.broadcast_in_dim %57, dims = [] : (tensor<i32>) -> tensor<32768xi32>
    %59 = stablehlo.add %8, %58 : tensor<32768xi32>
    %60 = call @_roll_dynamic(%arg0, %59) : (tensor<32768x32xf64>, tensor<32768xi32>) -> tensor<32768x32xf64>
    %61 = stablehlo.slice %10 [5:6, 0:32768, 0:32] : (tensor<6x32768x32xf64>) -> tensor<1x32768x32xf64>
    %62 = stablehlo.reshape %61 : (tensor<1x32768x32xf64>) -> tensor<32768x32xf64>
    %63 = stablehlo.multiply %62, %60 : tensor<32768x32xf64>
    %64 = stablehlo.add %55, %63 : tensor<32768x32xf64>
    return %64 : tensor<32768x32xf64>
  }
  func.func private @build_v_diag_weights(%arg0: tensor<6xi32>, %arg1: tensor<32768xi32>, %arg2: tensor<32768xf64>) -> tensor<6x32768x32xf64> {
    %0 = stablehlo.multiply %arg2, %arg2 : tensor<32768xf64>
    %1 = stablehlo.multiply %0, %arg2 : tensor<32768xf64>
    %2 = stablehlo.multiply %1, %arg2 : tensor<32768xf64>
    %3 = stablehlo.multiply %2, %arg2 : tensor<32768xf64>
    %cst = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %4 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %5 = stablehlo.divide %arg2, %4 : tensor<32768xf64>
    %cst_0 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %6 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %7 = stablehlo.divide %0, %6 : tensor<32768xf64>
    %8 = stablehlo.subtract %5, %7 : tensor<32768xf64>
    %9 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %10 = stablehlo.divide %1, %9 : tensor<32768xf64>
    %11 = stablehlo.subtract %8, %10 : tensor<32768xf64>
    %12 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %13 = stablehlo.divide %2, %12 : tensor<32768xf64>
    %14 = stablehlo.add %11, %13 : tensor<32768xf64>
    %cst_1 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %15 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %16 = stablehlo.divide %3, %15 : tensor<32768xf64>
    %17 = stablehlo.subtract %14, %16 : tensor<32768xf64>
    %cst_2 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %18 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %19 = stablehlo.divide %arg2, %18 : tensor<32768xf64>
    %20 = stablehlo.negate %19 : tensor<32768xf64>
    %21 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %22 = stablehlo.multiply %21, %0 : tensor<32768xf64>
    %cst_3 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %23 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %24 = stablehlo.divide %22, %23 : tensor<32768xf64>
    %25 = stablehlo.add %20, %24 : tensor<32768xf64>
    %26 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %27 = stablehlo.divide %1, %26 : tensor<32768xf64>
    %28 = stablehlo.subtract %25, %27 : tensor<32768xf64>
    %cst_4 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %29 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %30 = stablehlo.divide %2, %29 : tensor<32768xf64>
    %31 = stablehlo.subtract %28, %30 : tensor<32768xf64>
    %32 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %33 = stablehlo.divide %3, %32 : tensor<32768xf64>
    %34 = stablehlo.add %31, %33 : tensor<32768xf64>
    %35 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %36 = stablehlo.divide %arg2, %35 : tensor<32768xf64>
    %cst_5 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %37 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %38 = stablehlo.subtract %37, %36 : tensor<32768xf64>
    %cst_6 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %39 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %40 = stablehlo.multiply %39, %0 : tensor<32768xf64>
    %cst_7 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %41 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %42 = stablehlo.divide %40, %41 : tensor<32768xf64>
    %43 = stablehlo.subtract %38, %42 : tensor<32768xf64>
    %44 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %45 = stablehlo.multiply %44, %1 : tensor<32768xf64>
    %cst_8 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %46 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %47 = stablehlo.divide %45, %46 : tensor<32768xf64>
    %48 = stablehlo.add %43, %47 : tensor<32768xf64>
    %49 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %50 = stablehlo.divide %2, %49 : tensor<32768xf64>
    %51 = stablehlo.add %48, %50 : tensor<32768xf64>
    %52 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %53 = stablehlo.divide %3, %52 : tensor<32768xf64>
    %54 = stablehlo.subtract %51, %53 : tensor<32768xf64>
    %55 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %56 = stablehlo.multiply %55, %0 : tensor<32768xf64>
    %57 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %58 = stablehlo.divide %56, %57 : tensor<32768xf64>
    %59 = stablehlo.add %arg2, %58 : tensor<32768xf64>
    %cst_9 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %60 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %61 = stablehlo.multiply %60, %1 : tensor<32768xf64>
    %62 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %63 = stablehlo.divide %61, %62 : tensor<32768xf64>
    %64 = stablehlo.subtract %59, %63 : tensor<32768xf64>
    %65 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %66 = stablehlo.divide %2, %65 : tensor<32768xf64>
    %67 = stablehlo.subtract %64, %66 : tensor<32768xf64>
    %68 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %69 = stablehlo.divide %3, %68 : tensor<32768xf64>
    %70 = stablehlo.add %67, %69 : tensor<32768xf64>
    %71 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %72 = stablehlo.divide %arg2, %71 : tensor<32768xf64>
    %73 = stablehlo.negate %72 : tensor<32768xf64>
    %74 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %75 = stablehlo.divide %0, %74 : tensor<32768xf64>
    %76 = stablehlo.subtract %73, %75 : tensor<32768xf64>
    %77 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %78 = stablehlo.multiply %77, %1 : tensor<32768xf64>
    %79 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %80 = stablehlo.divide %78, %79 : tensor<32768xf64>
    %81 = stablehlo.add %76, %80 : tensor<32768xf64>
    %82 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %83 = stablehlo.divide %2, %82 : tensor<32768xf64>
    %84 = stablehlo.add %81, %83 : tensor<32768xf64>
    %85 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %86 = stablehlo.divide %3, %85 : tensor<32768xf64>
    %87 = stablehlo.subtract %84, %86 : tensor<32768xf64>
    %cst_10 = stablehlo.constant dense<3.000000e+01> : tensor<f64>
    %88 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %89 = stablehlo.divide %arg2, %88 : tensor<32768xf64>
    %90 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %91 = stablehlo.divide %1, %90 : tensor<32768xf64>
    %92 = stablehlo.subtract %89, %91 : tensor<32768xf64>
    %93 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<32768xf64>
    %94 = stablehlo.divide %3, %93 : tensor<32768xf64>
    %95 = stablehlo.add %92, %94 : tensor<32768xf64>
    %96 = stablehlo.broadcast_in_dim %17, dims = [1] : (tensor<32768xf64>) -> tensor<1x32768xf64>
    %97 = stablehlo.broadcast_in_dim %34, dims = [1] : (tensor<32768xf64>) -> tensor<1x32768xf64>
    %98 = stablehlo.broadcast_in_dim %54, dims = [1] : (tensor<32768xf64>) -> tensor<1x32768xf64>
    %99 = stablehlo.broadcast_in_dim %70, dims = [1] : (tensor<32768xf64>) -> tensor<1x32768xf64>
    %100 = stablehlo.broadcast_in_dim %87, dims = [1] : (tensor<32768xf64>) -> tensor<1x32768xf64>
    %101 = stablehlo.broadcast_in_dim %95, dims = [1] : (tensor<32768xf64>) -> tensor<1x32768xf64>
    %102 = stablehlo.concatenate %96, %97, %98, %99, %100, %101, dim = 0 : (tensor<1x32768xf64>, tensor<1x32768xf64>, tensor<1x32768xf64>, tensor<1x32768xf64>, tensor<1x32768xf64>, tensor<1x32768xf64>) -> tensor<6x32768xf64>
    %103 = stablehlo.iota dim = 0 : tensor<32xi64>
    %104 = stablehlo.broadcast_in_dim %arg0, dims = [0] : (tensor<6xi32>) -> tensor<6x1xi32>
    %105 = stablehlo.broadcast_in_dim %arg1, dims = [1] : (tensor<32768xi32>) -> tensor<1x32768xi32>
    %106 = stablehlo.broadcast_in_dim %104, dims = [0, 1] : (tensor<6x1xi32>) -> tensor<6x32768xi32>
    %107 = stablehlo.broadcast_in_dim %105, dims = [0, 1] : (tensor<1x32768xi32>) -> tensor<6x32768xi32>
    %108 = stablehlo.add %106, %107 : tensor<6x32768xi32>
    %109 = stablehlo.broadcast_in_dim %103, dims = [2] : (tensor<32xi64>) -> tensor<1x1x32xi64>
    %110 = stablehlo.broadcast_in_dim %108, dims = [0, 1] : (tensor<6x32768xi32>) -> tensor<6x32768x1xi32>
    %111 = stablehlo.convert %110 : (tensor<6x32768x1xi32>) -> tensor<6x32768x1xi64>
    %112 = stablehlo.broadcast_in_dim %109, dims = [0, 1, 2] : (tensor<1x1x32xi64>) -> tensor<6x32768x32xi64>
    %113 = stablehlo.broadcast_in_dim %111, dims = [0, 1, 2] : (tensor<6x32768x1xi64>) -> tensor<6x32768x32xi64>
    %114 = stablehlo.subtract %112, %113 : tensor<6x32768x32xi64>
    %c = stablehlo.constant dense<0> : tensor<i64>
    %115 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i64>) -> tensor<6x32768x32xi64>
    %116 = stablehlo.compare  GE, %114, %115,  SIGNED : (tensor<6x32768x32xi64>, tensor<6x32768x32xi64>) -> tensor<6x32768x32xi1>
    %c_11 = stablehlo.constant dense<32> : tensor<i64>
    %117 = stablehlo.broadcast_in_dim %c_11, dims = [] : (tensor<i64>) -> tensor<6x32768x32xi64>
    %118 = stablehlo.compare  LT, %114, %117,  SIGNED : (tensor<6x32768x32xi64>, tensor<6x32768x32xi64>) -> tensor<6x32768x32xi1>
    %119 = stablehlo.and %116, %118 : tensor<6x32768x32xi1>
    %120 = stablehlo.broadcast_in_dim %102, dims = [0, 1] : (tensor<6x32768xf64>) -> tensor<6x32768x1xf64>
    %cst_12 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %121 = call @_where_2(%119, %120, %cst_12) : (tensor<6x32768x32xi1>, tensor<6x32768x1xf64>, tensor<f64>) -> tensor<6x32768x32xf64>
    return %121 : tensor<6x32768x32xf64>
  }
  func.func private @_where_2(%arg0: tensor<6x32768x32xi1>, %arg1: tensor<6x32768x1xf64>, %arg2: tensor<f64>) -> tensor<6x32768x32xf64> {
    %0 = stablehlo.convert %arg2 : tensor<f64>
    %1 = stablehlo.broadcast_in_dim %arg1, dims = [0, 1, 2] : (tensor<6x32768x1xf64>) -> tensor<6x32768x32xf64>
    %2 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f64>) -> tensor<6x32768x32xf64>
    %3 = stablehlo.select %arg0, %1, %2 : tensor<6x32768x32xi1>, tensor<6x32768x32xf64>
    return %3 : tensor<6x32768x32xf64>
  }
}
