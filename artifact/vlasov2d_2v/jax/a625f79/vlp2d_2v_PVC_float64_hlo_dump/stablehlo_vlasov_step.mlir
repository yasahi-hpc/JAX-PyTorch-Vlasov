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
    %5 = call @advect_1d_vectorized(%2, %4, %cst_4, %cst_5, %c) : (tensor<32768x32xf64>, tensor<32768xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<32768x32xf64>
    %6 = stablehlo.reshape %5 : (tensor<32768x32xf64>) -> tensor<32x32x32x32xf64>
    %7 = stablehlo.transpose %6, dims = [3, 0, 1, 2] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %8 = stablehlo.broadcast_in_dim %cst_0, dims = [2] : (tensor<32xf64>) -> tensor<1x1x32xf64>
    %9 = stablehlo.transpose %7, dims = [0, 2, 3, 1] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %10 = stablehlo.reshape %9 : (tensor<32x32x32x32xf64>) -> tensor<32768x32xf64>
    %11 = stablehlo.broadcast_in_dim %8, dims = [0, 1, 2] : (tensor<1x1x32xf64>) -> tensor<32x32x32xf64>
    %12 = stablehlo.reshape %11 : (tensor<32x32x32xf64>) -> tensor<32768xf64>
    %13 = call @advect_1d_vectorized(%10, %12, %cst_4, %cst_5, %c) : (tensor<32768x32xf64>, tensor<32768xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<32768x32xf64>
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
    %22 = call @advect_1d_vectorized_1(%19, %21, %cst_7, %cst_6, %c) : (tensor<32768x32xf64>, tensor<32768xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<32768x32xf64>
    %23 = stablehlo.reshape %22 : (tensor<32768x32xf64>) -> tensor<32x32x32x32xf64>
    %24 = stablehlo.transpose %23, dims = [0, 1, 3, 2] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %25 = stablehlo.broadcast_in_dim %16#1, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1xf64>
    %26 = stablehlo.reshape %24 : (tensor<32x32x32x32xf64>) -> tensor<32768x32xf64>
    %27 = stablehlo.broadcast_in_dim %25, dims = [0, 1, 2] : (tensor<32x32x1xf64>) -> tensor<32x32x32xf64>
    %28 = stablehlo.reshape %27 : (tensor<32x32x32xf64>) -> tensor<32768xf64>
    %29 = call @advect_1d_vectorized_1(%26, %28, %cst_7, %cst_6, %c) : (tensor<32768x32xf64>, tensor<32768xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<32768x32xf64>
    %30 = stablehlo.reshape %29 : (tensor<32768x32xf64>) -> tensor<32x32x32x32xf64>
    %31 = stablehlo.broadcast_in_dim %cst_0, dims = [2] : (tensor<32xf64>) -> tensor<1x1x32xf64>
    %32 = stablehlo.transpose %30, dims = [0, 2, 3, 1] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %33 = stablehlo.reshape %32 : (tensor<32x32x32x32xf64>) -> tensor<32768x32xf64>
    %34 = stablehlo.broadcast_in_dim %31, dims = [0, 1, 2] : (tensor<1x1x32xf64>) -> tensor<32x32x32xf64>
    %35 = stablehlo.reshape %34 : (tensor<32x32x32xf64>) -> tensor<32768xf64>
    %36 = call @advect_1d_vectorized(%33, %35, %cst_4, %cst_5, %c) : (tensor<32768x32xf64>, tensor<32768xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<32768x32xf64>
    %37 = stablehlo.reshape %36 : (tensor<32768x32xf64>) -> tensor<32x32x32x32xf64>
    %38 = stablehlo.transpose %37, dims = [0, 3, 1, 2] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %39 = stablehlo.broadcast_in_dim %cst, dims = [1] : (tensor<32xf64>) -> tensor<1x32x1xf64>
    %40 = stablehlo.transpose %38, dims = [1, 2, 3, 0] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %41 = stablehlo.reshape %40 : (tensor<32x32x32x32xf64>) -> tensor<32768x32xf64>
    %42 = stablehlo.broadcast_in_dim %39, dims = [0, 1, 2] : (tensor<1x32x1xf64>) -> tensor<32x32x32xf64>
    %43 = stablehlo.reshape %42 : (tensor<32x32x32xf64>) -> tensor<32768xf64>
    %44 = call @advect_1d_vectorized(%41, %43, %cst_4, %cst_5, %c) : (tensor<32768x32xf64>, tensor<32768xf64>, tensor<f64>, tensor<f64>, tensor<6xi32>) -> tensor<32768x32xf64>
    %45 = stablehlo.reshape %44 : (tensor<32768x32xf64>) -> tensor<32x32x32x32xf64>
    %46 = stablehlo.transpose %45, dims = [3, 0, 1, 2] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %46, %16#2, %16#3 : tensor<32x32x32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>
  }
  func.func private @advect_1d_vectorized(%arg0: tensor<32768x32xf64>, %arg1: tensor<32768xf64>, %arg2: tensor<f64>, %arg3: tensor<f64>, %arg4: tensor<6xi32>) -> tensor<32768x32xf64> {
    %0 = stablehlo.iota dim = 0 : tensor<32xf64>
    %1 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<32768xf64>) -> tensor<32768x1xf64>
    %2 = stablehlo.convert %arg2 : tensor<f64>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<f64>) -> tensor<32768x1xf64>
    %4 = stablehlo.multiply %1, %3 : tensor<32768x1xf64>
    %5 = stablehlo.convert %arg3 : tensor<f64>
    %6 = stablehlo.broadcast_in_dim %5, dims = [] : (tensor<f64>) -> tensor<32768x1xf64>
    %7 = stablehlo.divide %4, %6 : tensor<32768x1xf64>
    %8 = stablehlo.broadcast_in_dim %0, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x32xf64>) -> tensor<32768x32xf64>
    %10 = stablehlo.broadcast_in_dim %7, dims = [0, 1] : (tensor<32768x1xf64>) -> tensor<32768x32xf64>
    %11 = stablehlo.subtract %9, %10 : tensor<32768x32xf64>
    %12 = stablehlo.floor %11 : tensor<32768x32xf64>
    %13 = stablehlo.subtract %11, %12 : tensor<32768x32xf64>
    %14 = stablehlo.convert %12 : (tensor<32768x32xf64>) -> tensor<32768x32xi32>
    %15 = stablehlo.broadcast_in_dim %14, dims = [0, 1] : (tensor<32768x32xi32>) -> tensor<32768x32x1xi32>
    %16 = stablehlo.broadcast_in_dim %arg4, dims = [2] : (tensor<6xi32>) -> tensor<1x1x6xi32>
    %17 = stablehlo.broadcast_in_dim %15, dims = [0, 1, 2] : (tensor<32768x32x1xi32>) -> tensor<32768x32x6xi32>
    %18 = stablehlo.broadcast_in_dim %16, dims = [0, 1, 2] : (tensor<1x1x6xi32>) -> tensor<32768x32x6xi32>
    %19 = stablehlo.add %17, %18 : tensor<32768x32x6xi32>
    %c = stablehlo.constant dense<32> : tensor<i64>
    %20 = call @remainder(%19, %c) : (tensor<32768x32x6xi32>, tensor<i64>) -> tensor<32768x32x6xi32>
    %21 = stablehlo.iota dim = 0 : tensor<32768xi64>
    %22 = stablehlo.broadcast_in_dim %21, dims = [0] : (tensor<32768xi64>) -> tensor<32768x1x1xi64>
    %c_0 = stablehlo.constant dense<32> : tensor<i64>
    %23 = stablehlo.broadcast_in_dim %c_0, dims = [] : (tensor<i64>) -> tensor<32768x1x1xi64>
    %24 = stablehlo.multiply %22, %23 : tensor<32768x1x1xi64>
    %25 = stablehlo.convert %20 : (tensor<32768x32x6xi32>) -> tensor<32768x32x6xi64>
    %26 = stablehlo.broadcast_in_dim %24, dims = [0, 1, 2] : (tensor<32768x1x1xi64>) -> tensor<32768x32x6xi64>
    %27 = stablehlo.add %26, %25 : tensor<32768x32x6xi64>
    %28 = stablehlo.reshape %arg0 : (tensor<32768x32xf64>) -> tensor<1048576xf64>
    %29 = stablehlo.reshape %27 : (tensor<32768x32x6xi64>) -> tensor<6291456xi64>
    %c_1 = stablehlo.constant dense<0> : tensor<i64>
    %30 = stablehlo.broadcast_in_dim %c_1, dims = [] : (tensor<i64>) -> tensor<6291456xi64>
    %31 = stablehlo.compare  LT, %29, %30,  SIGNED : (tensor<6291456xi64>, tensor<6291456xi64>) -> tensor<6291456xi1>
    %c_2 = stablehlo.constant dense<1048576> : tensor<i64>
    %32 = stablehlo.broadcast_in_dim %c_2, dims = [] : (tensor<i64>) -> tensor<6291456xi64>
    %33 = stablehlo.add %29, %32 : tensor<6291456xi64>
    %34 = stablehlo.select %31, %33, %29 : tensor<6291456xi1>, tensor<6291456xi64>
    %35 = stablehlo.convert %34 : (tensor<6291456xi64>) -> tensor<6291456xi32>
    %36 = stablehlo.broadcast_in_dim %35, dims = [0] : (tensor<6291456xi32>) -> tensor<6291456x1xi32>
    %37 = "stablehlo.gather"(%28, %36) <{dimension_numbers = #stablehlo.gather<collapsed_slice_dims = [0], start_index_map = [0], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 1>}> : (tensor<1048576xf64>, tensor<6291456x1xi32>) -> tensor<6291456xf64>
    %38 = stablehlo.reshape %37 : (tensor<6291456xf64>) -> tensor<32768x32x6xf64>
    %39 = stablehlo.multiply %13, %13 : tensor<32768x32xf64>
    %40 = stablehlo.multiply %39, %13 : tensor<32768x32xf64>
    %41 = stablehlo.multiply %40, %13 : tensor<32768x32xf64>
    %42 = stablehlo.multiply %41, %13 : tensor<32768x32xf64>
    %cst = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %43 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %44 = stablehlo.divide %13, %43 : tensor<32768x32xf64>
    %cst_3 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %45 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %46 = stablehlo.divide %39, %45 : tensor<32768x32xf64>
    %47 = stablehlo.subtract %44, %46 : tensor<32768x32xf64>
    %48 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %49 = stablehlo.divide %40, %48 : tensor<32768x32xf64>
    %50 = stablehlo.subtract %47, %49 : tensor<32768x32xf64>
    %51 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %52 = stablehlo.divide %41, %51 : tensor<32768x32xf64>
    %53 = stablehlo.add %50, %52 : tensor<32768x32xf64>
    %cst_4 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %54 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %55 = stablehlo.divide %42, %54 : tensor<32768x32xf64>
    %56 = stablehlo.subtract %53, %55 : tensor<32768x32xf64>
    %cst_5 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %57 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %58 = stablehlo.divide %13, %57 : tensor<32768x32xf64>
    %59 = stablehlo.negate %58 : tensor<32768x32xf64>
    %60 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %61 = stablehlo.multiply %60, %39 : tensor<32768x32xf64>
    %cst_6 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %62 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %63 = stablehlo.divide %61, %62 : tensor<32768x32xf64>
    %64 = stablehlo.add %59, %63 : tensor<32768x32xf64>
    %65 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %66 = stablehlo.divide %40, %65 : tensor<32768x32xf64>
    %67 = stablehlo.subtract %64, %66 : tensor<32768x32xf64>
    %cst_7 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %68 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %69 = stablehlo.divide %41, %68 : tensor<32768x32xf64>
    %70 = stablehlo.subtract %67, %69 : tensor<32768x32xf64>
    %71 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %72 = stablehlo.divide %42, %71 : tensor<32768x32xf64>
    %73 = stablehlo.add %70, %72 : tensor<32768x32xf64>
    %74 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %75 = stablehlo.divide %13, %74 : tensor<32768x32xf64>
    %cst_8 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %76 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %77 = stablehlo.subtract %76, %75 : tensor<32768x32xf64>
    %cst_9 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %78 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %79 = stablehlo.multiply %78, %39 : tensor<32768x32xf64>
    %cst_10 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %80 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %81 = stablehlo.divide %79, %80 : tensor<32768x32xf64>
    %82 = stablehlo.subtract %77, %81 : tensor<32768x32xf64>
    %83 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %84 = stablehlo.multiply %83, %40 : tensor<32768x32xf64>
    %cst_11 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %85 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %86 = stablehlo.divide %84, %85 : tensor<32768x32xf64>
    %87 = stablehlo.add %82, %86 : tensor<32768x32xf64>
    %88 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %89 = stablehlo.divide %41, %88 : tensor<32768x32xf64>
    %90 = stablehlo.add %87, %89 : tensor<32768x32xf64>
    %91 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %92 = stablehlo.divide %42, %91 : tensor<32768x32xf64>
    %93 = stablehlo.subtract %90, %92 : tensor<32768x32xf64>
    %94 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %95 = stablehlo.multiply %94, %39 : tensor<32768x32xf64>
    %96 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %97 = stablehlo.divide %95, %96 : tensor<32768x32xf64>
    %98 = stablehlo.add %13, %97 : tensor<32768x32xf64>
    %cst_12 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %99 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %100 = stablehlo.multiply %99, %40 : tensor<32768x32xf64>
    %101 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %102 = stablehlo.divide %100, %101 : tensor<32768x32xf64>
    %103 = stablehlo.subtract %98, %102 : tensor<32768x32xf64>
    %104 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %105 = stablehlo.divide %41, %104 : tensor<32768x32xf64>
    %106 = stablehlo.subtract %103, %105 : tensor<32768x32xf64>
    %107 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %108 = stablehlo.divide %42, %107 : tensor<32768x32xf64>
    %109 = stablehlo.add %106, %108 : tensor<32768x32xf64>
    %110 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %111 = stablehlo.divide %13, %110 : tensor<32768x32xf64>
    %112 = stablehlo.negate %111 : tensor<32768x32xf64>
    %113 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %114 = stablehlo.divide %39, %113 : tensor<32768x32xf64>
    %115 = stablehlo.subtract %112, %114 : tensor<32768x32xf64>
    %116 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %117 = stablehlo.multiply %116, %40 : tensor<32768x32xf64>
    %118 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %119 = stablehlo.divide %117, %118 : tensor<32768x32xf64>
    %120 = stablehlo.add %115, %119 : tensor<32768x32xf64>
    %121 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %122 = stablehlo.divide %41, %121 : tensor<32768x32xf64>
    %123 = stablehlo.add %120, %122 : tensor<32768x32xf64>
    %124 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %125 = stablehlo.divide %42, %124 : tensor<32768x32xf64>
    %126 = stablehlo.subtract %123, %125 : tensor<32768x32xf64>
    %cst_13 = stablehlo.constant dense<3.000000e+01> : tensor<f64>
    %127 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %128 = stablehlo.divide %13, %127 : tensor<32768x32xf64>
    %129 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %130 = stablehlo.divide %40, %129 : tensor<32768x32xf64>
    %131 = stablehlo.subtract %128, %130 : tensor<32768x32xf64>
    %132 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %133 = stablehlo.divide %42, %132 : tensor<32768x32xf64>
    %134 = stablehlo.add %131, %133 : tensor<32768x32xf64>
    %135 = stablehlo.slice %38 [0:32768, 0:32, 0:1] : (tensor<32768x32x6xf64>) -> tensor<32768x32x1xf64>
    %136 = stablehlo.reshape %135 : (tensor<32768x32x1xf64>) -> tensor<32768x32xf64>
    %137 = stablehlo.multiply %56, %136 : tensor<32768x32xf64>
    %138 = stablehlo.slice %38 [0:32768, 0:32, 1:2] : (tensor<32768x32x6xf64>) -> tensor<32768x32x1xf64>
    %139 = stablehlo.reshape %138 : (tensor<32768x32x1xf64>) -> tensor<32768x32xf64>
    %140 = stablehlo.multiply %73, %139 : tensor<32768x32xf64>
    %141 = stablehlo.add %137, %140 : tensor<32768x32xf64>
    %142 = stablehlo.slice %38 [0:32768, 0:32, 2:3] : (tensor<32768x32x6xf64>) -> tensor<32768x32x1xf64>
    %143 = stablehlo.reshape %142 : (tensor<32768x32x1xf64>) -> tensor<32768x32xf64>
    %144 = stablehlo.multiply %93, %143 : tensor<32768x32xf64>
    %145 = stablehlo.add %141, %144 : tensor<32768x32xf64>
    %146 = stablehlo.slice %38 [0:32768, 0:32, 3:4] : (tensor<32768x32x6xf64>) -> tensor<32768x32x1xf64>
    %147 = stablehlo.reshape %146 : (tensor<32768x32x1xf64>) -> tensor<32768x32xf64>
    %148 = stablehlo.multiply %109, %147 : tensor<32768x32xf64>
    %149 = stablehlo.add %145, %148 : tensor<32768x32xf64>
    %150 = stablehlo.slice %38 [0:32768, 0:32, 4:5] : (tensor<32768x32x6xf64>) -> tensor<32768x32x1xf64>
    %151 = stablehlo.reshape %150 : (tensor<32768x32x1xf64>) -> tensor<32768x32xf64>
    %152 = stablehlo.multiply %126, %151 : tensor<32768x32xf64>
    %153 = stablehlo.add %149, %152 : tensor<32768x32xf64>
    %154 = stablehlo.slice %38 [0:32768, 0:32, 5:6] : (tensor<32768x32x6xf64>) -> tensor<32768x32x1xf64>
    %155 = stablehlo.reshape %154 : (tensor<32768x32x1xf64>) -> tensor<32768x32xf64>
    %156 = stablehlo.multiply %134, %155 : tensor<32768x32xf64>
    %157 = stablehlo.add %153, %156 : tensor<32768x32xf64>
    return %157 : tensor<32768x32xf64>
  }
  func.func private @remainder(%arg0: tensor<32768x32x6xi32>, %arg1: tensor<i64>) -> tensor<32768x32x6xi32> {
    %0 = stablehlo.convert %arg1 : (tensor<i64>) -> tensor<i32>
    %c = stablehlo.constant dense<0> : tensor<i32>
    %1 = stablehlo.compare  EQ, %0, %c,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
    %c_0 = stablehlo.constant dense<1> : tensor<i32>
    %2 = call @_where(%1, %c_0, %0) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<i32>) -> tensor<32768x32x6xi32>
    %4 = stablehlo.remainder %arg0, %3 : tensor<32768x32x6xi32>
    %5 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<32768x32x6xi32>
    %6 = stablehlo.compare  NE, %4, %5,  SIGNED : (tensor<32768x32x6xi32>, tensor<32768x32x6xi32>) -> tensor<32768x32x6xi1>
    %7 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<32768x32x6xi32>
    %8 = stablehlo.compare  LT, %4, %7,  SIGNED : (tensor<32768x32x6xi32>, tensor<32768x32x6xi32>) -> tensor<32768x32x6xi1>
    %9 = stablehlo.compare  LT, %2, %c,  SIGNED : (tensor<i32>, tensor<i32>) -> tensor<i1>
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
  func.func private @advect_1d_vectorized_1(%arg0: tensor<32768x32xf64>, %arg1: tensor<32768xf64>, %arg2: tensor<f64>, %arg3: tensor<f64>, %arg4: tensor<6xi32>) -> tensor<32768x32xf64> {
    %0 = stablehlo.iota dim = 0 : tensor<32xf64>
    %1 = stablehlo.broadcast_in_dim %arg1, dims = [0] : (tensor<32768xf64>) -> tensor<32768x1xf64>
    %2 = stablehlo.convert %arg2 : tensor<f64>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<f64>) -> tensor<32768x1xf64>
    %4 = stablehlo.multiply %1, %3 : tensor<32768x1xf64>
    %5 = stablehlo.convert %arg3 : tensor<f64>
    %6 = stablehlo.broadcast_in_dim %5, dims = [] : (tensor<f64>) -> tensor<32768x1xf64>
    %7 = stablehlo.divide %4, %6 : tensor<32768x1xf64>
    %8 = stablehlo.broadcast_in_dim %0, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %9 = stablehlo.broadcast_in_dim %8, dims = [0, 1] : (tensor<1x32xf64>) -> tensor<32768x32xf64>
    %10 = stablehlo.broadcast_in_dim %7, dims = [0, 1] : (tensor<32768x1xf64>) -> tensor<32768x32xf64>
    %11 = stablehlo.subtract %9, %10 : tensor<32768x32xf64>
    %12 = stablehlo.floor %11 : tensor<32768x32xf64>
    %13 = stablehlo.subtract %11, %12 : tensor<32768x32xf64>
    %14 = stablehlo.convert %12 : (tensor<32768x32xf64>) -> tensor<32768x32xi32>
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
    %c_1 = stablehlo.constant dense<0> : tensor<i64>
    %c_2 = stablehlo.constant dense<31> : tensor<i64>
    %25 = call @clip(%19, %c_1, %c_2) : (tensor<32768x32x6xi32>, tensor<i64>, tensor<i64>) -> tensor<32768x32x6xi32>
    %26 = stablehlo.iota dim = 0 : tensor<32768xi64>
    %27 = stablehlo.broadcast_in_dim %26, dims = [0] : (tensor<32768xi64>) -> tensor<32768x1x1xi64>
    %c_3 = stablehlo.constant dense<32> : tensor<i64>
    %28 = stablehlo.broadcast_in_dim %c_3, dims = [] : (tensor<i64>) -> tensor<32768x1x1xi64>
    %29 = stablehlo.multiply %27, %28 : tensor<32768x1x1xi64>
    %30 = stablehlo.convert %25 : (tensor<32768x32x6xi32>) -> tensor<32768x32x6xi64>
    %31 = stablehlo.broadcast_in_dim %29, dims = [0, 1, 2] : (tensor<32768x1x1xi64>) -> tensor<32768x32x6xi64>
    %32 = stablehlo.add %31, %30 : tensor<32768x32x6xi64>
    %33 = stablehlo.reshape %arg0 : (tensor<32768x32xf64>) -> tensor<1048576xf64>
    %34 = stablehlo.reshape %32 : (tensor<32768x32x6xi64>) -> tensor<6291456xi64>
    %c_4 = stablehlo.constant dense<0> : tensor<i64>
    %35 = stablehlo.broadcast_in_dim %c_4, dims = [] : (tensor<i64>) -> tensor<6291456xi64>
    %36 = stablehlo.compare  LT, %34, %35,  SIGNED : (tensor<6291456xi64>, tensor<6291456xi64>) -> tensor<6291456xi1>
    %c_5 = stablehlo.constant dense<1048576> : tensor<i64>
    %37 = stablehlo.broadcast_in_dim %c_5, dims = [] : (tensor<i64>) -> tensor<6291456xi64>
    %38 = stablehlo.add %34, %37 : tensor<6291456xi64>
    %39 = stablehlo.select %36, %38, %34 : tensor<6291456xi1>, tensor<6291456xi64>
    %40 = stablehlo.convert %39 : (tensor<6291456xi64>) -> tensor<6291456xi32>
    %41 = stablehlo.broadcast_in_dim %40, dims = [0] : (tensor<6291456xi32>) -> tensor<6291456x1xi32>
    %42 = "stablehlo.gather"(%33, %41) <{dimension_numbers = #stablehlo.gather<collapsed_slice_dims = [0], start_index_map = [0], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = array<i64: 1>}> : (tensor<1048576xf64>, tensor<6291456x1xi32>) -> tensor<6291456xf64>
    %43 = stablehlo.reshape %42 : (tensor<6291456xf64>) -> tensor<32768x32x6xf64>
    %cst = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %44 = call @_where_2(%24, %43, %cst) : (tensor<32768x32x6xi1>, tensor<32768x32x6xf64>, tensor<f64>) -> tensor<32768x32x6xf64>
    %45 = stablehlo.multiply %13, %13 : tensor<32768x32xf64>
    %46 = stablehlo.multiply %45, %13 : tensor<32768x32xf64>
    %47 = stablehlo.multiply %46, %13 : tensor<32768x32xf64>
    %48 = stablehlo.multiply %47, %13 : tensor<32768x32xf64>
    %cst_6 = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %49 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %50 = stablehlo.divide %13, %49 : tensor<32768x32xf64>
    %cst_7 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %51 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %52 = stablehlo.divide %45, %51 : tensor<32768x32xf64>
    %53 = stablehlo.subtract %50, %52 : tensor<32768x32xf64>
    %54 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %55 = stablehlo.divide %46, %54 : tensor<32768x32xf64>
    %56 = stablehlo.subtract %53, %55 : tensor<32768x32xf64>
    %57 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %58 = stablehlo.divide %47, %57 : tensor<32768x32xf64>
    %59 = stablehlo.add %56, %58 : tensor<32768x32xf64>
    %cst_8 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %60 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %61 = stablehlo.divide %48, %60 : tensor<32768x32xf64>
    %62 = stablehlo.subtract %59, %61 : tensor<32768x32xf64>
    %cst_9 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %63 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %64 = stablehlo.divide %13, %63 : tensor<32768x32xf64>
    %65 = stablehlo.negate %64 : tensor<32768x32xf64>
    %66 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %67 = stablehlo.multiply %66, %45 : tensor<32768x32xf64>
    %cst_10 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %68 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %69 = stablehlo.divide %67, %68 : tensor<32768x32xf64>
    %70 = stablehlo.add %65, %69 : tensor<32768x32xf64>
    %71 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %72 = stablehlo.divide %46, %71 : tensor<32768x32xf64>
    %73 = stablehlo.subtract %70, %72 : tensor<32768x32xf64>
    %cst_11 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %74 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %75 = stablehlo.divide %47, %74 : tensor<32768x32xf64>
    %76 = stablehlo.subtract %73, %75 : tensor<32768x32xf64>
    %77 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %78 = stablehlo.divide %48, %77 : tensor<32768x32xf64>
    %79 = stablehlo.add %76, %78 : tensor<32768x32xf64>
    %80 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %81 = stablehlo.divide %13, %80 : tensor<32768x32xf64>
    %cst_12 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %82 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %83 = stablehlo.subtract %82, %81 : tensor<32768x32xf64>
    %cst_13 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %84 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %85 = stablehlo.multiply %84, %45 : tensor<32768x32xf64>
    %cst_14 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %86 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %87 = stablehlo.divide %85, %86 : tensor<32768x32xf64>
    %88 = stablehlo.subtract %83, %87 : tensor<32768x32xf64>
    %89 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %90 = stablehlo.multiply %89, %46 : tensor<32768x32xf64>
    %cst_15 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %91 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %92 = stablehlo.divide %90, %91 : tensor<32768x32xf64>
    %93 = stablehlo.add %88, %92 : tensor<32768x32xf64>
    %94 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %95 = stablehlo.divide %47, %94 : tensor<32768x32xf64>
    %96 = stablehlo.add %93, %95 : tensor<32768x32xf64>
    %97 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %98 = stablehlo.divide %48, %97 : tensor<32768x32xf64>
    %99 = stablehlo.subtract %96, %98 : tensor<32768x32xf64>
    %100 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %101 = stablehlo.multiply %100, %45 : tensor<32768x32xf64>
    %102 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %103 = stablehlo.divide %101, %102 : tensor<32768x32xf64>
    %104 = stablehlo.add %13, %103 : tensor<32768x32xf64>
    %cst_16 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %105 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %106 = stablehlo.multiply %105, %46 : tensor<32768x32xf64>
    %107 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %108 = stablehlo.divide %106, %107 : tensor<32768x32xf64>
    %109 = stablehlo.subtract %104, %108 : tensor<32768x32xf64>
    %110 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %111 = stablehlo.divide %47, %110 : tensor<32768x32xf64>
    %112 = stablehlo.subtract %109, %111 : tensor<32768x32xf64>
    %113 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %114 = stablehlo.divide %48, %113 : tensor<32768x32xf64>
    %115 = stablehlo.add %112, %114 : tensor<32768x32xf64>
    %116 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %117 = stablehlo.divide %13, %116 : tensor<32768x32xf64>
    %118 = stablehlo.negate %117 : tensor<32768x32xf64>
    %119 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %120 = stablehlo.divide %45, %119 : tensor<32768x32xf64>
    %121 = stablehlo.subtract %118, %120 : tensor<32768x32xf64>
    %122 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %123 = stablehlo.multiply %122, %46 : tensor<32768x32xf64>
    %124 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %125 = stablehlo.divide %123, %124 : tensor<32768x32xf64>
    %126 = stablehlo.add %121, %125 : tensor<32768x32xf64>
    %127 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %128 = stablehlo.divide %47, %127 : tensor<32768x32xf64>
    %129 = stablehlo.add %126, %128 : tensor<32768x32xf64>
    %130 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %131 = stablehlo.divide %48, %130 : tensor<32768x32xf64>
    %132 = stablehlo.subtract %129, %131 : tensor<32768x32xf64>
    %cst_17 = stablehlo.constant dense<3.000000e+01> : tensor<f64>
    %133 = stablehlo.broadcast_in_dim %cst_17, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %134 = stablehlo.divide %13, %133 : tensor<32768x32xf64>
    %135 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %136 = stablehlo.divide %46, %135 : tensor<32768x32xf64>
    %137 = stablehlo.subtract %134, %136 : tensor<32768x32xf64>
    %138 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<32768x32xf64>
    %139 = stablehlo.divide %48, %138 : tensor<32768x32xf64>
    %140 = stablehlo.add %137, %139 : tensor<32768x32xf64>
    %141 = stablehlo.slice %44 [0:32768, 0:32, 0:1] : (tensor<32768x32x6xf64>) -> tensor<32768x32x1xf64>
    %142 = stablehlo.reshape %141 : (tensor<32768x32x1xf64>) -> tensor<32768x32xf64>
    %143 = stablehlo.multiply %62, %142 : tensor<32768x32xf64>
    %144 = stablehlo.slice %44 [0:32768, 0:32, 1:2] : (tensor<32768x32x6xf64>) -> tensor<32768x32x1xf64>
    %145 = stablehlo.reshape %144 : (tensor<32768x32x1xf64>) -> tensor<32768x32xf64>
    %146 = stablehlo.multiply %79, %145 : tensor<32768x32xf64>
    %147 = stablehlo.add %143, %146 : tensor<32768x32xf64>
    %148 = stablehlo.slice %44 [0:32768, 0:32, 2:3] : (tensor<32768x32x6xf64>) -> tensor<32768x32x1xf64>
    %149 = stablehlo.reshape %148 : (tensor<32768x32x1xf64>) -> tensor<32768x32xf64>
    %150 = stablehlo.multiply %99, %149 : tensor<32768x32xf64>
    %151 = stablehlo.add %147, %150 : tensor<32768x32xf64>
    %152 = stablehlo.slice %44 [0:32768, 0:32, 3:4] : (tensor<32768x32x6xf64>) -> tensor<32768x32x1xf64>
    %153 = stablehlo.reshape %152 : (tensor<32768x32x1xf64>) -> tensor<32768x32xf64>
    %154 = stablehlo.multiply %115, %153 : tensor<32768x32xf64>
    %155 = stablehlo.add %151, %154 : tensor<32768x32xf64>
    %156 = stablehlo.slice %44 [0:32768, 0:32, 4:5] : (tensor<32768x32x6xf64>) -> tensor<32768x32x1xf64>
    %157 = stablehlo.reshape %156 : (tensor<32768x32x1xf64>) -> tensor<32768x32xf64>
    %158 = stablehlo.multiply %132, %157 : tensor<32768x32xf64>
    %159 = stablehlo.add %155, %158 : tensor<32768x32xf64>
    %160 = stablehlo.slice %44 [0:32768, 0:32, 5:6] : (tensor<32768x32x6xf64>) -> tensor<32768x32x1xf64>
    %161 = stablehlo.reshape %160 : (tensor<32768x32x1xf64>) -> tensor<32768x32xf64>
    %162 = stablehlo.multiply %140, %161 : tensor<32768x32xf64>
    %163 = stablehlo.add %159, %162 : tensor<32768x32xf64>
    return %163 : tensor<32768x32xf64>
  }
  func.func private @clip(%arg0: tensor<32768x32x6xi32>, %arg1: tensor<i64>, %arg2: tensor<i64>) -> tensor<32768x32x6xi32> {
    %0 = stablehlo.convert %arg1 : (tensor<i64>) -> tensor<i32>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<i32>) -> tensor<32768x32x6xi32>
    %2 = stablehlo.maximum %1, %arg0 : tensor<32768x32x6xi32>
    %3 = stablehlo.convert %arg2 : (tensor<i64>) -> tensor<i32>
    %4 = stablehlo.broadcast_in_dim %3, dims = [] : (tensor<i32>) -> tensor<32768x32x6xi32>
    %5 = stablehlo.minimum %4, %2 : tensor<32768x32x6xi32>
    return %5 : tensor<32768x32x6xi32>
  }
  func.func private @_where_2(%arg0: tensor<32768x32x6xi1>, %arg1: tensor<32768x32x6xf64>, %arg2: tensor<f64>) -> tensor<32768x32x6xf64> {
    %0 = stablehlo.convert %arg2 : tensor<f64>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f64>) -> tensor<32768x32x6xf64>
    %2 = stablehlo.select %arg0, %arg1, %1 : tensor<32768x32x6xi1>, tensor<32768x32x6xf64>
    return %2 : tensor<32768x32x6xf64>
  }
}
