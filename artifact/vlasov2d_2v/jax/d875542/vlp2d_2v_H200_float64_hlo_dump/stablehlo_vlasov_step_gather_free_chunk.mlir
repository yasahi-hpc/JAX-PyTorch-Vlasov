module @jit_run_chunk attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main(%arg0: tensor<32x32xf64>, %arg1: tensor<32x32xf64>, %arg2: tensor<32x32x32x32xf64>, %arg3: tensor<32x32xf64>, %arg4: tensor<f64>, %arg5: tensor<i64>) -> (tensor<32xf64> {jax.result_info = "result[0][0]"}, tensor<32xf64> {jax.result_info = "result[0][1]"}, tensor<32xf64> {jax.result_info = "result[0][2]"}, tensor<32xf64> {jax.result_info = "result[0][3]"}, tensor<32x1xf64> {jax.result_info = "result[0][4]"}, tensor<1x17xf64> {jax.result_info = "result[0][5]"}, tensor<32x17xf64> {jax.result_info = "result[0][6]"}, tensor<6xi32> {jax.result_info = "result[0][7]"}, tensor<32x32xf64> {jax.result_info = "result[1][0]"}, tensor<32x32xf64> {jax.result_info = "result[1][1]"}, tensor<32x32x32x32xf64> {jax.result_info = "result[2][0]"}, tensor<32x32xf64> {jax.result_info = "result[2][1]"}, tensor<f64> {jax.result_info = "result[3]"}, tensor<i64> {jax.result_info = "result[4]"}) {
    %cst = stablehlo.constant dense<[0.68169011381620925, 0.70222623550548613, 0.72276235719476289, 0.74329847888403977, 0.76383460057331654, 0.78437072226259341, 0.80490684395187029, 0.82544296564114705, 0.84597908733042382, 0.86651520901970069, 0.88705133070897746, 0.90758745239825434, 0.9281235740875311, 0.94865969577680798, 0.96919581746608474, 0.98973193915536162, 0.0102680608446384, 0.0308041825339152, 0.051340304223192038, 0.071876425912468858, 0.092412547601745651, 0.11294866929102249, 0.13348479098029933, 0.15402091266957613, 0.17455703435885297, 0.19509315604812977, 0.21562927773740659, 0.23616539942668341, 0.25670152111596017, 0.27723764280523705, 0.29777376449451387, 0.31830988618379069]> : tensor<32xf64>
    %cst_0 = stablehlo.constant dense<[0.68169011381620925, 0.70222623550548613, 0.72276235719476289, 0.74329847888403977, 0.76383460057331654, 0.78437072226259341, 0.80490684395187029, 0.82544296564114705, 0.84597908733042382, 0.86651520901970069, 0.88705133070897746, 0.90758745239825434, 0.9281235740875311, 0.94865969577680798, 0.96919581746608474, 0.98973193915536162, 0.0102680608446384, 0.0308041825339152, 0.051340304223192038, 0.071876425912468858, 0.092412547601745651, 0.11294866929102249, 0.13348479098029933, 0.15402091266957613, 0.17455703435885297, 0.19509315604812977, 0.21562927773740659, 0.23616539942668341, 0.25670152111596017, 0.27723764280523705, 0.29777376449451387, 0.31830988618379069]> : tensor<32xf64>
    %cst_1 = stablehlo.constant dense<[[0.000000e+00], [5.000000e-01], [1.000000e+00], [1.500000e+00], [2.000000e+00], [2.500000e+00], [3.000000e+00], [3.5000000000000004], [4.000000e+00], [4.500000e+00], [5.000000e+00], [5.500000e+00], [6.000000e+00], [6.4999999999999991], [7.0000000000000009], [7.500000e+00], [-8.000000e+00], [-7.500000e+00], [-7.0000000000000009], [-6.4999999999999991], [-6.000000e+00], [-5.500000e+00], [-5.000000e+00], [-4.500000e+00], [-4.000000e+00], [-3.5000000000000004], [-3.000000e+00], [-2.500000e+00], [-2.000000e+00], [-1.500000e+00], [-1.000000e+00], [-5.000000e-01]]> : tensor<32x1xf64>
    %cst_2 = stablehlo.constant dense<[[0.000000e+00, 5.000000e-01, 1.000000e+00, 1.500000e+00, 2.000000e+00, 2.500000e+00, 3.000000e+00, 3.5000000000000004, 4.000000e+00, 4.500000e+00, 5.000000e+00, 5.500000e+00, 6.000000e+00, 6.4999999999999991, 7.0000000000000009, 7.500000e+00, 8.000000e+00]]> : tensor<1x17xf64>
    %cst_3 = stablehlo.constant dense<"0x00000000000000000000000000001040000000000000F03F1CC7711CC771DC3F000000000000D03F7B14AE47E17AC43F1CC7711CC771BC3F38052FA7E0E5B43F000000000000B03FE0E9D6FCB048A93F7B14AE47E17AA43F909CE66BF5ECA03F1CC7711CC7719C3FDFBEB27A973C983F38052FA7E0E5943FDFBC9A785634923F000000000000903F000000000000104000000000000000409A9999999999E93F9A9999999999D93F1E1E1E1E1E1ECE3F143BB1133BB1C33FD0BAC114F9ACBB3F7914AE47E17AB43F20F8811FF881AF3FFA189C8FC1F9A83FFBD96265F846A43F3BDABC4F71C9A03FF0F8C3018F3F9C3F1A1818181818983F6DAF2587B8CA943F78FB2181B71F923F20E01FE01FE08F3F000000000000F03F9A9999999999E93F000000000000E03F143BB1133BB1D33F9A9999999999C93F967B1A61B9A7C13F9A9999999999B93FC0782BFB1C52B33F1E1E1E1E1E1EAE3F181818181818A83F143BB1133BB1A33FFCA9F1D24D62A03FD0BAC114F9AC9B3FC6ECE00822AD973F7914AE47E17A943F74B83F3BEFE2913F20F8811FF8818F3F1CC7711CC771DC3F9A9999999999D93F143BB1133BB1D33F1CC7711CC771CC3F7B14AE47E17AC43F1E1E1E1E1E1EBE3F176CC1166CC1B63F957B1A61B9A7B13FE0C08103070EAC3F176CC1166CC1A63FA02C814DFBC9A23F20F8811FF8819F3F1B70C51A70C59A3F72810B5CE002973FF913B03F01FB933F121881111881913F028E45F8C7E98E3F000000000000D03F1E1E1E1E1E1ECE3F9A9999999999C93F7B14AE47E17AC43F000000000000C03FFA189C8FC1F9B83F143BB1133BB1B33F1EF8811FF881AF3F9A9999999999A93F15F8E2EA071DA53F967B1A61B9A7A13F8A86F8E3D6E59D3F9A9999999999993F42620177FA23963FC0782BFB1C52933F11F0FE10F0FE903F1E1E1E1E1E1E8E3F7B14AE47E17AC43F143BB1133BB1C33F967B1A61B9A7C13F1E1E1E1E1E1EBE3FFA189C8FC1F9B83F7B14AE47E17AB43F3BDABC4F71C9B03FCEBAC114F9ACAB3F70810B5CE002A73FC1782BFB1C52A33FFCA9F1D24D62A03FE0C08103070E9C3FDDBEB27A973C983F17F8E2EA071D953F11B08812B088923FFCA9F1D24D62903F1A5BFCA32C278D3F1CC7711CC771BC3FD0BAC114F9ACBB3F9A9999999999B93F176CC1166CC1B63F143BB1133BB1B33F3BDABC4F71C9B03F1CC7711CC771AC3F171818181818A83F7B14AE47E17AA43F121881111881A13F1E1E1E1E1E1E9E3F024B7AF9D3169A3F176CC1166CC1963FFD13B03F01FB933F957B1A61B9A7913FB5DBA0AC10638F3FE0C08103070E8C3F38052FA7E0E5B43F7914AE47E17AB43FC0782BFB1C52B33F957B1A61B9A7B13F1EF8811FF881AF3FCEBAC114F9ACAB3F171818181818A83F38052FA7E0E5A43F77FB2181B71FA23F20F8811FF8819F3F8B33DA3D6C7D9B3F181818181818983FEB0FF4480939953FA12C814DFBC9923FC69D25ECE6B7903F8A86F8E3D6E58D3F5E90947FE8DB8A3F000000000000B03F20F8811FF881AF3F1E1E1E1E1E1EAE3FE0C08103070EAC3F9A9999999999A93F70810B5CE002A73F7B14AE47E17AA43F77FB2181B71FA23F000000000000A03FF0F8C3018F3F9C3FFA189C8FC1F9983F40620177FA23963F143BB1133BB1933F9DA28C805394913F1EF8811FF8818F3F86490DD194588C3F9A9999999999893FE0E9D6FCB048A93FFA189C8FC1F9A83F181818181818A83F176CC1166CC1A63F15F8E2EA071DA53FC1782BFB1C52A33F121881111881A13F20F8811FF8819F3FF0F8C3018F3F9C3FE0E9D6FCB048993F907253D13CA1963FFBD96265F846943FDFBC9A785634923FFDA9F1D24D62903F887F1E23F2928D3F1B70C51A70C58A3F140678C2004F883F7B14AE47E17AA43FFBD96265F846A43F143BB1133BB1A33FA02C814DFBC9A23F967B1A61B9A7A13FFCA9F1D24D62A03F1E1E1E1E1E1E9E3F8B33DA3D6C7D9B3FFA189C8FC1F9983F907253D13CA1963F7B14AE47E17A943F13B08812B088923F3BDABC4F71C9903FE65097A51A748E3FCEBAC114F9AC8B3FE62C9B7FC634893F70810B5CE002873F909CE66BF5ECA03F3BDABC4F71C9A03FFCA9F1D24D62A03F20F8811FF8819F3F8A86F8E3D6E59D3FE0C08103070E9C3F024B7AF9D3169A3F181818181818983F40620177FA23963FFBD96265F846943F13B08812B088923F909CE66BF5EC903F028E45F8C7E98E3FF2F8C3018F3F8C3F2C686B179FD7893FC3ECE00822AD873F91FA47C6BCBA853F1CC7711CC7719C3FF0F8C3018F3F9C3FD0BAC114F9AC9B3F1B70C51A70C59A3F9A9999999999993FDDBEB27A973C983F176CC1166CC1963FEB0FF4480939953F143BB1133BB1933FDFBC9A785634923F3BDABC4F71C9903F028E45F8C7E98E3F1CC7711CC7718C3FA21CC5872A2C8A3F171818181818883FDEC08AB85633863F7B14AE47E17A843FDFBEB27A973C983F1A1818181818983FC6ECE00822AD973F72810B5CE002973F42620177FA23963F17F8E2EA071D953FFD13B03F01FB933FA12C814DFBC9923F9DA28C805394913FFDA9F1D24D62903FE65097A51A748E3FF2F8C3018F3F8C3FA21CC5872A2C8A3FDFBEB27A973C883F1A6701369F71863F6FAF2587B8CA843F4713E0AC7946833F38052FA7E0E5943F6DAF2587B8CA943F7914AE47E17A943FF913B03F01FB933FC0782BFB1C52933F11B08812B088923F957B1A61B9A7913FC69D25ECE6B7903F1EF8811FF8818F3F887F1E23F2928D3FCEBAC114F9AC8B3F2C686B179FD7893F171818181818883F1A6701369F71863F38052FA7E0E5843FED45C9D15B75833F77FB2181B71F823FDFBC9A785634923F78FB2181B71F923F74B83F3BEFE2913F121881111881913F11F0FE10F0FE903FFCA9F1D24D62903FB5DBA0AC10638F3F8A86F8E3D6E58D3F86490DD194588C3F1B70C51A70C58A3FE62C9B7FC634893FC3ECE00822AD873FDEC08AB85633863F6FAF2587B8CA843FED45C9D15B75833FDFBC9A785634823F801001BEFB07813F000000000000903F20E01FE01FE08F3F20F8811FF8818F3F028E45F8C7E98E3F1E1E1E1E1E1E8E3F1A5BFCA32C278D3FE0C08103070E8C3F5E90947FE8DB8A3F9A9999999999893F140678C2004F883F70810B5CE002873F91FA47C6BCBA853F7B14AE47E17A843F4713E0AC7946833F77FB2181B71F823F801001BEFB07813F000000000000803FDFBC9A785634923F78FB2181B71F923F74B83F3BEFE2913F121881111881913F11F0FE10F0FE903FFCA9F1D24D62903FB5DBA0AC10638F3F8A86F8E3D6E58D3F86490DD194588C3F1B70C51A70C58A3FE62C9B7FC634893FC3ECE00822AD873FDEC08AB85633863F6FAF2587B8CA843FED45C9D15B75833FDFBC9A785634823F801001BEFB07813F38052FA7E0E5943F6DAF2587B8CA943F7914AE47E17A943FF913B03F01FB933FC0782BFB1C52933F11B08812B088923F957B1A61B9A7913FC69D25ECE6B7903F1EF8811FF8818F3F887F1E23F2928D3FCEBAC114F9AC8B3F2C686B179FD7893F171818181818883F1A6701369F71863F38052FA7E0E5843FED45C9D15B75833F77FB2181B71F823FDFBEB27A973C983F1A1818181818983FC6ECE00822AD973F72810B5CE002973F42620177FA23963F17F8E2EA071D953FFD13B03F01FB933FA12C814DFBC9923F9DA28C805394913FFDA9F1D24D62903FE65097A51A748E3FF2F8C3018F3F8C3FA21CC5872A2C8A3FDFBEB27A973C883F1A6701369F71863F6FAF2587B8CA843F4713E0AC7946833F1CC7711CC7719C3FF0F8C3018F3F9C3FD0BAC114F9AC9B3F1B70C51A70C59A3F9A9999999999993FDDBEB27A973C983F176CC1166CC1963FEB0FF4480939953F143BB1133BB1933FDFBC9A785634923F3BDABC4F71C9903F028E45F8C7E98E3F1CC7711CC7718C3FA21CC5872A2C8A3F171818181818883FDEC08AB85633863F7B14AE47E17A843F909CE66BF5ECA03F3BDABC4F71C9A03FFCA9F1D24D62A03F20F8811FF8819F3F8A86F8E3D6E59D3FE0C08103070E9C3F024B7AF9D3169A3F181818181818983F40620177FA23963FFBD96265F846943F13B08812B088923F909CE66BF5EC903F028E45F8C7E98E3FF2F8C3018F3F8C3F2C686B179FD7893FC3ECE00822AD873F91FA47C6BCBA853F7B14AE47E17AA43FFBD96265F846A43F143BB1133BB1A33FA02C814DFBC9A23F967B1A61B9A7A13FFCA9F1D24D62A03F1E1E1E1E1E1E9E3F8B33DA3D6C7D9B3FFA189C8FC1F9983F907253D13CA1963F7B14AE47E17A943F13B08812B088923F3BDABC4F71C9903FE65097A51A748E3FCEBAC114F9AC8B3FE62C9B7FC634893F70810B5CE002873FE0E9D6FCB048A93FFA189C8FC1F9A83F181818181818A83F176CC1166CC1A63F15F8E2EA071DA53FC1782BFB1C52A33F121881111881A13F20F8811FF8819F3FF0F8C3018F3F9C3FE0E9D6FCB048993F907253D13CA1963FFBD96265F846943FDFBC9A785634923FFDA9F1D24D62903F887F1E23F2928D3F1B70C51A70C58A3F140678C2004F883F000000000000B03F20F8811FF881AF3F1E1E1E1E1E1EAE3FE0C08103070EAC3F9A9999999999A93F70810B5CE002A73F7B14AE47E17AA43F77FB2181B71FA23F000000000000A03FF0F8C3018F3F9C3FFA189C8FC1F9983F40620177FA23963F143BB1133BB1933F9DA28C805394913F1EF8811FF8818F3F86490DD194588C3F9A9999999999893F38052FA7E0E5B43F7914AE47E17AB43FC0782BFB1C52B33F957B1A61B9A7B13F1EF8811FF881AF3FCEBAC114F9ACAB3F171818181818A83F38052FA7E0E5A43F77FB2181B71FA23F20F8811FF8819F3F8B33DA3D6C7D9B3F181818181818983FEB0FF4480939953FA12C814DFBC9923FC69D25ECE6B7903F8A86F8E3D6E58D3F5E90947FE8DB8A3F1CC7711CC771BC3FD0BAC114F9ACBB3F9A9999999999B93F176CC1166CC1B63F143BB1133BB1B33F3BDABC4F71C9B03F1CC7711CC771AC3F171818181818A83F7B14AE47E17AA43F121881111881A13F1E1E1E1E1E1E9E3F024B7AF9D3169A3F176CC1166CC1963FFD13B03F01FB933F957B1A61B9A7913FB5DBA0AC10638F3FE0C08103070E8C3F7B14AE47E17AC43F143BB1133BB1C33F967B1A61B9A7C13F1E1E1E1E1E1EBE3FFA189C8FC1F9B83F7B14AE47E17AB43F3BDABC4F71C9B03FCEBAC114F9ACAB3F70810B5CE002A73FC1782BFB1C52A33FFCA9F1D24D62A03FE0C08103070E9C3FDDBEB27A973C983F17F8E2EA071D953F11B08812B088923FFCA9F1D24D62903F1A5BFCA32C278D3F000000000000D03F1E1E1E1E1E1ECE3F9A9999999999C93F7B14AE47E17AC43F000000000000C03FFA189C8FC1F9B83F143BB1133BB1B33F1EF8811FF881AF3F9A9999999999A93F15F8E2EA071DA53F967B1A61B9A7A13F8A86F8E3D6E59D3F9A9999999999993F42620177FA23963FC0782BFB1C52933F11F0FE10F0FE903F1E1E1E1E1E1E8E3F1CC7711CC771DC3F9A9999999999D93F143BB1133BB1D33F1CC7711CC771CC3F7B14AE47E17AC43F1E1E1E1E1E1EBE3F176CC1166CC1B63F957B1A61B9A7B13FE0C08103070EAC3F176CC1166CC1A63FA02C814DFBC9A23F20F8811FF8819F3F1B70C51A70C59A3F72810B5CE002973FF913B03F01FB933F121881111881913F028E45F8C7E98E3F000000000000F03F9A9999999999E93F000000000000E03F143BB1133BB1D33F9A9999999999C93F967B1A61B9A7C13F9A9999999999B93FC0782BFB1C52B33F1E1E1E1E1E1EAE3F181818181818A83F143BB1133BB1A33FFCA9F1D24D62A03FD0BAC114F9AC9B3FC6ECE00822AD973F7914AE47E17A943F74B83F3BEFE2913F20F8811FF8818F3F000000000000104000000000000000409A9999999999E93F9A9999999999D93F1E1E1E1E1E1ECE3F143BB1133BB1C33FD0BAC114F9ACBB3F7914AE47E17AB43F20F8811FF881AF3FFA189C8FC1F9A83FFBD96265F846A43F3BDABC4F71C9A03FF0F8C3018F3F9C3F1A1818181818983F6DAF2587B8CA943F78FB2181B71F923F20E01FE01FE08F3F"> : tensor<32x17xf64>
    %cst_4 = stablehlo.constant dense<[0.000000e+00, 0.39269908169872414, 0.78539816339744828, 1.1780972450961724, 1.5707963267948966, 1.9634954084936207, 2.3561944901923448, 2.748893571891069, 3.1415926535897931, 3.5342917352885173, 3.9269908169872414, 4.3196898986859651, 4.7123889803846897, 5.1050880620834143, 5.497787143782138, 5.8904862254808616, 6.2831853071795862, 6.6758843888783108, 7.0685834705770345, 7.4612825522757582, 7.8539816339744828, 8.2466807156732074, 8.6393797973719302, 9.0320788790706548, 9.4247779607693793, 9.8174770424681039, 10.210176124166829, 10.602875205865551, 10.995574287564276, 11.388273369263, 11.780972450961723, 12.173671532660448]> : tensor<32xf64>
    %cst_5 = stablehlo.constant dense<[0.000000e+00, 0.39269908169872414, 0.78539816339744828, 1.1780972450961724, 1.5707963267948966, 1.9634954084936207, 2.3561944901923448, 2.748893571891069, 3.1415926535897931, 3.5342917352885173, 3.9269908169872414, 4.3196898986859651, 4.7123889803846897, 5.1050880620834143, 5.497787143782138, 5.8904862254808616, 6.2831853071795862, 6.6758843888783108, 7.0685834705770345, 7.4612825522757582, 7.8539816339744828, 8.2466807156732074, 8.6393797973719302, 9.0320788790706548, 9.4247779607693793, 9.8174770424681039, 10.210176124166829, 10.602875205865551, 10.995574287564276, 11.388273369263, 11.780972450961723, 12.173671532660448]> : tensor<32xf64>
    %cst_6 = stablehlo.constant dense<[-5.000000e+00, -4.67741935483871, -4.3548387096774199, -4.0322580645161281, -3.7096774193548385, -3.387096774193548, -3.064516129032258, -2.741935483870968, -2.4193548387096779, -2.0967741935483875, -1.7741935483870974, -1.4516129032258063, -1.129032258064516, -0.80645161290322598, -0.4838709677419355, -0.16129032258064502, 0.16129032258064502, 0.48387096774193505, 0.80645161290322553, 1.129032258064516, 1.4516129032258061, 1.7741935483870965, 2.096774193548387, 2.419354838709677, 2.741935483870968, 3.064516129032258, 3.387096774193548, 3.7096774193548385, 4.0322580645161281, 4.354838709677419, 4.67741935483871, 5.000000e+00]> : tensor<32xf64>
    %cst_7 = stablehlo.constant dense<[-5.000000e+00, -4.67741935483871, -4.3548387096774199, -4.0322580645161281, -3.7096774193548385, -3.387096774193548, -3.064516129032258, -2.741935483870968, -2.4193548387096779, -2.0967741935483875, -1.7741935483870974, -1.4516129032258063, -1.129032258064516, -0.80645161290322598, -0.4838709677419355, -0.16129032258064502, 0.16129032258064502, 0.48387096774193505, 0.80645161290322553, 1.129032258064516, 1.4516129032258061, 1.7741935483870965, 2.096774193548387, 2.419354838709677, 2.741935483870968, 3.064516129032258, 3.387096774193548, 3.7096774193548385, 4.0322580645161281, 4.354838709677419, 4.67741935483871, 5.000000e+00]> : tensor<32xf64>
    %c = stablehlo.constant dense<[-2, -1, 0, 1, 2, 3]> : tensor<6xi32>
    %c_8 = stablehlo.constant dense<0> : tensor<i64>
    %0:9 = stablehlo.while(%iterArg = %cst, %iterArg_11 = %cst_0, %iterArg_12 = %cst_1, %iterArg_13 = %cst_2, %iterArg_14 = %cst_3, %iterArg_15 = %c_8, %iterArg_16 = %arg2, %iterArg_17 = %arg0, %iterArg_18 = %arg1) : tensor<32xf64>, tensor<32xf64>, tensor<32x1xf64>, tensor<1x17xf64>, tensor<32x17xf64>, tensor<i64>, tensor<32x32x32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>
    cond {
      %c_19 = stablehlo.constant dense<128> : tensor<i64>
      %3 = stablehlo.compare  LT, %iterArg_15, %c_19,  SIGNED : (tensor<i64>, tensor<i64>) -> tensor<i1>
      stablehlo.return %3 : tensor<i1>
    } do {
      %3:3 = func.call @closed_call(%iterArg, %iterArg_11, %iterArg_12, %iterArg_13, %iterArg_14, %iterArg_16, %iterArg_17, %iterArg_18) : (tensor<32xf64>, tensor<32xf64>, tensor<32x1xf64>, tensor<1x17xf64>, tensor<32x17xf64>, tensor<32x32x32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>) -> (tensor<32x32x32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>)
      %c_19 = stablehlo.constant dense<1> : tensor<i64>
      %4 = stablehlo.add %iterArg_15, %c_19 : tensor<i64>
      stablehlo.return %iterArg, %iterArg_11, %iterArg_12, %iterArg_13, %iterArg_14, %4, %3#0, %3#1, %3#2 : tensor<32xf64>, tensor<32xf64>, tensor<32x1xf64>, tensor<1x17xf64>, tensor<32x17xf64>, tensor<i64>, tensor<32x32x32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>
    }
    %cst_9 = stablehlo.constant dense<6.400000e+00> : tensor<f64>
    %1 = stablehlo.add %arg4, %cst_9 : tensor<f64>
    %c_10 = stablehlo.constant dense<128> : tensor<i64>
    %2 = stablehlo.add %arg5, %c_10 : tensor<i64>
    return %cst_4, %cst_5, %cst_6, %cst_7, %cst_1, %cst_2, %cst_3, %c, %0#7, %0#8, %0#6, %arg3, %1, %2 : tensor<32xf64>, tensor<32xf64>, tensor<32xf64>, tensor<32xf64>, tensor<32x1xf64>, tensor<1x17xf64>, tensor<32x17xf64>, tensor<6xi32>, tensor<32x32xf64>, tensor<32x32xf64>, tensor<32x32x32x32xf64>, tensor<32x32xf64>, tensor<f64>, tensor<i64>
  }
  func.func private @closed_call(%arg0: tensor<32xf64>, %arg1: tensor<32xf64>, %arg2: tensor<32x1xf64>, %arg3: tensor<1x17xf64>, %arg4: tensor<32x17xf64>, %arg5: tensor<32x32x32x32xf64>, %arg6: tensor<32x32xf64>, %arg7: tensor<32x32xf64>) -> (tensor<32x32x32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>) {
    %0 = stablehlo.multiply %arg0, %arg0 : tensor<32xf64>
    %1 = stablehlo.multiply %0, %arg0 : tensor<32xf64>
    %2 = stablehlo.multiply %1, %arg0 : tensor<32xf64>
    %3 = stablehlo.multiply %2, %arg0 : tensor<32xf64>
    %cst = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %4 = stablehlo.broadcast_in_dim %cst, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %5 = stablehlo.divide %arg0, %4 : tensor<32xf64>
    %cst_0 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %6 = stablehlo.broadcast_in_dim %cst_0, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %7 = stablehlo.divide %0, %6 : tensor<32xf64>
    %8 = stablehlo.subtract %5, %7 : tensor<32xf64>
    %cst_1 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %9 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %10 = stablehlo.divide %1, %9 : tensor<32xf64>
    %11 = stablehlo.subtract %8, %10 : tensor<32xf64>
    %cst_2 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %12 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %13 = stablehlo.divide %2, %12 : tensor<32xf64>
    %14 = stablehlo.add %11, %13 : tensor<32xf64>
    %cst_3 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %15 = stablehlo.broadcast_in_dim %cst_3, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %16 = stablehlo.divide %3, %15 : tensor<32xf64>
    %17 = stablehlo.subtract %14, %16 : tensor<32xf64>
    %cst_4 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %18 = stablehlo.broadcast_in_dim %cst_4, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %19 = stablehlo.divide %arg0, %18 : tensor<32xf64>
    %20 = stablehlo.negate %19 : tensor<32xf64>
    %cst_5 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %21 = stablehlo.broadcast_in_dim %cst_5, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %22 = stablehlo.multiply %21, %0 : tensor<32xf64>
    %cst_6 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %23 = stablehlo.broadcast_in_dim %cst_6, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %24 = stablehlo.divide %22, %23 : tensor<32xf64>
    %25 = stablehlo.add %20, %24 : tensor<32xf64>
    %cst_7 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %26 = stablehlo.broadcast_in_dim %cst_7, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %27 = stablehlo.divide %1, %26 : tensor<32xf64>
    %28 = stablehlo.subtract %25, %27 : tensor<32xf64>
    %cst_8 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %29 = stablehlo.broadcast_in_dim %cst_8, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %30 = stablehlo.divide %2, %29 : tensor<32xf64>
    %31 = stablehlo.subtract %28, %30 : tensor<32xf64>
    %cst_9 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %32 = stablehlo.broadcast_in_dim %cst_9, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %33 = stablehlo.divide %3, %32 : tensor<32xf64>
    %34 = stablehlo.add %31, %33 : tensor<32xf64>
    %cst_10 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %35 = stablehlo.broadcast_in_dim %cst_10, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %36 = stablehlo.divide %arg0, %35 : tensor<32xf64>
    %cst_11 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %37 = stablehlo.broadcast_in_dim %cst_11, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %38 = stablehlo.subtract %37, %36 : tensor<32xf64>
    %cst_12 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %39 = stablehlo.broadcast_in_dim %cst_12, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %40 = stablehlo.multiply %39, %0 : tensor<32xf64>
    %cst_13 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %41 = stablehlo.broadcast_in_dim %cst_13, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %42 = stablehlo.divide %40, %41 : tensor<32xf64>
    %43 = stablehlo.subtract %38, %42 : tensor<32xf64>
    %cst_14 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %44 = stablehlo.broadcast_in_dim %cst_14, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %45 = stablehlo.multiply %44, %1 : tensor<32xf64>
    %cst_15 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %46 = stablehlo.broadcast_in_dim %cst_15, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %47 = stablehlo.divide %45, %46 : tensor<32xf64>
    %48 = stablehlo.add %43, %47 : tensor<32xf64>
    %cst_16 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %49 = stablehlo.broadcast_in_dim %cst_16, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %50 = stablehlo.divide %2, %49 : tensor<32xf64>
    %51 = stablehlo.add %48, %50 : tensor<32xf64>
    %cst_17 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %52 = stablehlo.broadcast_in_dim %cst_17, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %53 = stablehlo.divide %3, %52 : tensor<32xf64>
    %54 = stablehlo.subtract %51, %53 : tensor<32xf64>
    %cst_18 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %55 = stablehlo.broadcast_in_dim %cst_18, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %56 = stablehlo.multiply %55, %0 : tensor<32xf64>
    %cst_19 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %57 = stablehlo.broadcast_in_dim %cst_19, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %58 = stablehlo.divide %56, %57 : tensor<32xf64>
    %59 = stablehlo.add %arg0, %58 : tensor<32xf64>
    %cst_20 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %60 = stablehlo.broadcast_in_dim %cst_20, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %61 = stablehlo.multiply %60, %1 : tensor<32xf64>
    %cst_21 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %62 = stablehlo.broadcast_in_dim %cst_21, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %63 = stablehlo.divide %61, %62 : tensor<32xf64>
    %64 = stablehlo.subtract %59, %63 : tensor<32xf64>
    %cst_22 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %65 = stablehlo.broadcast_in_dim %cst_22, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %66 = stablehlo.divide %2, %65 : tensor<32xf64>
    %67 = stablehlo.subtract %64, %66 : tensor<32xf64>
    %cst_23 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %68 = stablehlo.broadcast_in_dim %cst_23, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %69 = stablehlo.divide %3, %68 : tensor<32xf64>
    %70 = stablehlo.add %67, %69 : tensor<32xf64>
    %cst_24 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %71 = stablehlo.broadcast_in_dim %cst_24, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %72 = stablehlo.divide %arg0, %71 : tensor<32xf64>
    %73 = stablehlo.negate %72 : tensor<32xf64>
    %cst_25 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %74 = stablehlo.broadcast_in_dim %cst_25, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %75 = stablehlo.divide %0, %74 : tensor<32xf64>
    %76 = stablehlo.subtract %73, %75 : tensor<32xf64>
    %cst_26 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %77 = stablehlo.broadcast_in_dim %cst_26, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %78 = stablehlo.multiply %77, %1 : tensor<32xf64>
    %cst_27 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %79 = stablehlo.broadcast_in_dim %cst_27, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %80 = stablehlo.divide %78, %79 : tensor<32xf64>
    %81 = stablehlo.add %76, %80 : tensor<32xf64>
    %cst_28 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %82 = stablehlo.broadcast_in_dim %cst_28, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %83 = stablehlo.divide %2, %82 : tensor<32xf64>
    %84 = stablehlo.add %81, %83 : tensor<32xf64>
    %cst_29 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %85 = stablehlo.broadcast_in_dim %cst_29, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %86 = stablehlo.divide %3, %85 : tensor<32xf64>
    %87 = stablehlo.subtract %84, %86 : tensor<32xf64>
    %cst_30 = stablehlo.constant dense<3.000000e+01> : tensor<f64>
    %88 = stablehlo.broadcast_in_dim %cst_30, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %89 = stablehlo.divide %arg0, %88 : tensor<32xf64>
    %cst_31 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %90 = stablehlo.broadcast_in_dim %cst_31, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %91 = stablehlo.divide %1, %90 : tensor<32xf64>
    %92 = stablehlo.subtract %89, %91 : tensor<32xf64>
    %cst_32 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %93 = stablehlo.broadcast_in_dim %cst_32, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %94 = stablehlo.divide %3, %93 : tensor<32xf64>
    %95 = stablehlo.add %92, %94 : tensor<32xf64>
    %96 = stablehlo.broadcast_in_dim %17, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %97 = stablehlo.broadcast_in_dim %34, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %98 = stablehlo.broadcast_in_dim %54, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %99 = stablehlo.broadcast_in_dim %70, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %100 = stablehlo.broadcast_in_dim %87, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %101 = stablehlo.broadcast_in_dim %95, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %102 = stablehlo.concatenate %96, %97, %98, %99, %100, %101, dim = 0 : (tensor<1x32xf64>, tensor<1x32xf64>, tensor<1x32xf64>, tensor<1x32xf64>, tensor<1x32xf64>, tensor<1x32xf64>) -> tensor<6x32xf64>
    %103 = stablehlo.multiply %arg1, %arg1 : tensor<32xf64>
    %104 = stablehlo.multiply %103, %arg1 : tensor<32xf64>
    %105 = stablehlo.multiply %104, %arg1 : tensor<32xf64>
    %106 = stablehlo.multiply %105, %arg1 : tensor<32xf64>
    %cst_33 = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %107 = stablehlo.broadcast_in_dim %cst_33, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %108 = stablehlo.divide %arg1, %107 : tensor<32xf64>
    %cst_34 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %109 = stablehlo.broadcast_in_dim %cst_34, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %110 = stablehlo.divide %103, %109 : tensor<32xf64>
    %111 = stablehlo.subtract %108, %110 : tensor<32xf64>
    %cst_35 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %112 = stablehlo.broadcast_in_dim %cst_35, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %113 = stablehlo.divide %104, %112 : tensor<32xf64>
    %114 = stablehlo.subtract %111, %113 : tensor<32xf64>
    %cst_36 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %115 = stablehlo.broadcast_in_dim %cst_36, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %116 = stablehlo.divide %105, %115 : tensor<32xf64>
    %117 = stablehlo.add %114, %116 : tensor<32xf64>
    %cst_37 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %118 = stablehlo.broadcast_in_dim %cst_37, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %119 = stablehlo.divide %106, %118 : tensor<32xf64>
    %120 = stablehlo.subtract %117, %119 : tensor<32xf64>
    %cst_38 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %121 = stablehlo.broadcast_in_dim %cst_38, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %122 = stablehlo.divide %arg1, %121 : tensor<32xf64>
    %123 = stablehlo.negate %122 : tensor<32xf64>
    %cst_39 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %124 = stablehlo.broadcast_in_dim %cst_39, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %125 = stablehlo.multiply %124, %103 : tensor<32xf64>
    %cst_40 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %126 = stablehlo.broadcast_in_dim %cst_40, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %127 = stablehlo.divide %125, %126 : tensor<32xf64>
    %128 = stablehlo.add %123, %127 : tensor<32xf64>
    %cst_41 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %129 = stablehlo.broadcast_in_dim %cst_41, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %130 = stablehlo.divide %104, %129 : tensor<32xf64>
    %131 = stablehlo.subtract %128, %130 : tensor<32xf64>
    %cst_42 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %132 = stablehlo.broadcast_in_dim %cst_42, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %133 = stablehlo.divide %105, %132 : tensor<32xf64>
    %134 = stablehlo.subtract %131, %133 : tensor<32xf64>
    %cst_43 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %135 = stablehlo.broadcast_in_dim %cst_43, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %136 = stablehlo.divide %106, %135 : tensor<32xf64>
    %137 = stablehlo.add %134, %136 : tensor<32xf64>
    %cst_44 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %138 = stablehlo.broadcast_in_dim %cst_44, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %139 = stablehlo.divide %arg1, %138 : tensor<32xf64>
    %cst_45 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %140 = stablehlo.broadcast_in_dim %cst_45, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %141 = stablehlo.subtract %140, %139 : tensor<32xf64>
    %cst_46 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %142 = stablehlo.broadcast_in_dim %cst_46, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %143 = stablehlo.multiply %142, %103 : tensor<32xf64>
    %cst_47 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %144 = stablehlo.broadcast_in_dim %cst_47, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %145 = stablehlo.divide %143, %144 : tensor<32xf64>
    %146 = stablehlo.subtract %141, %145 : tensor<32xf64>
    %cst_48 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %147 = stablehlo.broadcast_in_dim %cst_48, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %148 = stablehlo.multiply %147, %104 : tensor<32xf64>
    %cst_49 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %149 = stablehlo.broadcast_in_dim %cst_49, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %150 = stablehlo.divide %148, %149 : tensor<32xf64>
    %151 = stablehlo.add %146, %150 : tensor<32xf64>
    %cst_50 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %152 = stablehlo.broadcast_in_dim %cst_50, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %153 = stablehlo.divide %105, %152 : tensor<32xf64>
    %154 = stablehlo.add %151, %153 : tensor<32xf64>
    %cst_51 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %155 = stablehlo.broadcast_in_dim %cst_51, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %156 = stablehlo.divide %106, %155 : tensor<32xf64>
    %157 = stablehlo.subtract %154, %156 : tensor<32xf64>
    %cst_52 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %158 = stablehlo.broadcast_in_dim %cst_52, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %159 = stablehlo.multiply %158, %103 : tensor<32xf64>
    %cst_53 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %160 = stablehlo.broadcast_in_dim %cst_53, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %161 = stablehlo.divide %159, %160 : tensor<32xf64>
    %162 = stablehlo.add %arg1, %161 : tensor<32xf64>
    %cst_54 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %163 = stablehlo.broadcast_in_dim %cst_54, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %164 = stablehlo.multiply %163, %104 : tensor<32xf64>
    %cst_55 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %165 = stablehlo.broadcast_in_dim %cst_55, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %166 = stablehlo.divide %164, %165 : tensor<32xf64>
    %167 = stablehlo.subtract %162, %166 : tensor<32xf64>
    %cst_56 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %168 = stablehlo.broadcast_in_dim %cst_56, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %169 = stablehlo.divide %105, %168 : tensor<32xf64>
    %170 = stablehlo.subtract %167, %169 : tensor<32xf64>
    %cst_57 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %171 = stablehlo.broadcast_in_dim %cst_57, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %172 = stablehlo.divide %106, %171 : tensor<32xf64>
    %173 = stablehlo.add %170, %172 : tensor<32xf64>
    %cst_58 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %174 = stablehlo.broadcast_in_dim %cst_58, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %175 = stablehlo.divide %arg1, %174 : tensor<32xf64>
    %176 = stablehlo.negate %175 : tensor<32xf64>
    %cst_59 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %177 = stablehlo.broadcast_in_dim %cst_59, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %178 = stablehlo.divide %103, %177 : tensor<32xf64>
    %179 = stablehlo.subtract %176, %178 : tensor<32xf64>
    %cst_60 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %180 = stablehlo.broadcast_in_dim %cst_60, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %181 = stablehlo.multiply %180, %104 : tensor<32xf64>
    %cst_61 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %182 = stablehlo.broadcast_in_dim %cst_61, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %183 = stablehlo.divide %181, %182 : tensor<32xf64>
    %184 = stablehlo.add %179, %183 : tensor<32xf64>
    %cst_62 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %185 = stablehlo.broadcast_in_dim %cst_62, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %186 = stablehlo.divide %105, %185 : tensor<32xf64>
    %187 = stablehlo.add %184, %186 : tensor<32xf64>
    %cst_63 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %188 = stablehlo.broadcast_in_dim %cst_63, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %189 = stablehlo.divide %106, %188 : tensor<32xf64>
    %190 = stablehlo.subtract %187, %189 : tensor<32xf64>
    %cst_64 = stablehlo.constant dense<3.000000e+01> : tensor<f64>
    %191 = stablehlo.broadcast_in_dim %cst_64, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %192 = stablehlo.divide %arg1, %191 : tensor<32xf64>
    %cst_65 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %193 = stablehlo.broadcast_in_dim %cst_65, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %194 = stablehlo.divide %104, %193 : tensor<32xf64>
    %195 = stablehlo.subtract %192, %194 : tensor<32xf64>
    %cst_66 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %196 = stablehlo.broadcast_in_dim %cst_66, dims = [] : (tensor<f64>) -> tensor<32xf64>
    %197 = stablehlo.divide %106, %196 : tensor<32xf64>
    %198 = stablehlo.add %195, %197 : tensor<32xf64>
    %199 = stablehlo.broadcast_in_dim %120, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %200 = stablehlo.broadcast_in_dim %137, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %201 = stablehlo.broadcast_in_dim %157, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %202 = stablehlo.broadcast_in_dim %173, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %203 = stablehlo.broadcast_in_dim %190, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %204 = stablehlo.broadcast_in_dim %198, dims = [1] : (tensor<32xf64>) -> tensor<1x32xf64>
    %205 = stablehlo.concatenate %199, %200, %201, %202, %203, %204, dim = 0 : (tensor<1x32xf64>, tensor<1x32xf64>, tensor<1x32xf64>, tensor<1x32xf64>, tensor<1x32xf64>, tensor<1x32xf64>) -> tensor<6x32xf64>
    %206 = stablehlo.slice %arg5 [0:32, 0:32, 0:16, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x32x16x32xf64>
    %207 = call @_roll_static(%206) : (tensor<32x32x16x32xf64>) -> tensor<32x32x16x32xf64>
    %208 = stablehlo.slice %arg5 [0:32, 0:32, 16:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x32x16x32xf64>
    %209 = call @_roll_static_6(%208) : (tensor<32x32x16x32xf64>) -> tensor<32x32x16x32xf64>
    %210 = stablehlo.concatenate %207, %209, dim = 2 : (tensor<32x32x16x32xf64>, tensor<32x32x16x32xf64>) -> tensor<32x32x32x32xf64>
    %cst_67 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %211 = stablehlo.broadcast_in_dim %cst_67, dims = [] : (tensor<f64>) -> tensor<32x32x32x32xf64>
    %212 = call @_roll_static_12(%210) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %213 = stablehlo.slice %102 [0:1, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %214 = stablehlo.reshape %213 : (tensor<1x32xf64>) -> tensor<32xf64>
    %215 = stablehlo.reshape %214 : (tensor<32xf64>) -> tensor<1x1x32x1xf64>
    %216 = stablehlo.broadcast_in_dim %215, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf64>) -> tensor<32x32x32x32xf64>
    %217 = stablehlo.multiply %212, %216 : tensor<32x32x32x32xf64>
    %218 = stablehlo.add %211, %217 : tensor<32x32x32x32xf64>
    %219 = call @_roll_static_19(%210) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %220 = stablehlo.slice %102 [1:2, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %221 = stablehlo.reshape %220 : (tensor<1x32xf64>) -> tensor<32xf64>
    %222 = stablehlo.reshape %221 : (tensor<32xf64>) -> tensor<1x1x32x1xf64>
    %223 = stablehlo.broadcast_in_dim %222, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf64>) -> tensor<32x32x32x32xf64>
    %224 = stablehlo.multiply %219, %223 : tensor<32x32x32x32xf64>
    %225 = stablehlo.add %218, %224 : tensor<32x32x32x32xf64>
    %226 = call @_roll_static_24(%210) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %227 = stablehlo.slice %102 [2:3, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %228 = stablehlo.reshape %227 : (tensor<1x32xf64>) -> tensor<32xf64>
    %229 = stablehlo.reshape %228 : (tensor<32xf64>) -> tensor<1x1x32x1xf64>
    %230 = stablehlo.broadcast_in_dim %229, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf64>) -> tensor<32x32x32x32xf64>
    %231 = stablehlo.multiply %226, %230 : tensor<32x32x32x32xf64>
    %232 = stablehlo.add %225, %231 : tensor<32x32x32x32xf64>
    %233 = call @_roll_static_29(%210) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %234 = stablehlo.slice %102 [3:4, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %235 = stablehlo.reshape %234 : (tensor<1x32xf64>) -> tensor<32xf64>
    %236 = stablehlo.reshape %235 : (tensor<32xf64>) -> tensor<1x1x32x1xf64>
    %237 = stablehlo.broadcast_in_dim %236, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf64>) -> tensor<32x32x32x32xf64>
    %238 = stablehlo.multiply %233, %237 : tensor<32x32x32x32xf64>
    %239 = stablehlo.add %232, %238 : tensor<32x32x32x32xf64>
    %240 = call @_roll_static_34(%210) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %241 = stablehlo.slice %102 [4:5, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %242 = stablehlo.reshape %241 : (tensor<1x32xf64>) -> tensor<32xf64>
    %243 = stablehlo.reshape %242 : (tensor<32xf64>) -> tensor<1x1x32x1xf64>
    %244 = stablehlo.broadcast_in_dim %243, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf64>) -> tensor<32x32x32x32xf64>
    %245 = stablehlo.multiply %240, %244 : tensor<32x32x32x32xf64>
    %246 = stablehlo.add %239, %245 : tensor<32x32x32x32xf64>
    %247 = call @_roll_static_39(%210) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %248 = stablehlo.slice %102 [5:6, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %249 = stablehlo.reshape %248 : (tensor<1x32xf64>) -> tensor<32xf64>
    %250 = stablehlo.reshape %249 : (tensor<32xf64>) -> tensor<1x1x32x1xf64>
    %251 = stablehlo.broadcast_in_dim %250, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf64>) -> tensor<32x32x32x32xf64>
    %252 = stablehlo.multiply %247, %251 : tensor<32x32x32x32xf64>
    %253 = stablehlo.add %246, %252 : tensor<32x32x32x32xf64>
    %254 = stablehlo.slice %253 [0:32, 0:32, 0:32, 0:16] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x16xf64>
    %255 = call @_roll_static_45(%254) : (tensor<32x32x32x16xf64>) -> tensor<32x32x32x16xf64>
    %256 = stablehlo.slice %253 [0:32, 0:32, 0:32, 16:32] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x16xf64>
    %257 = call @_roll_static_50(%256) : (tensor<32x32x32x16xf64>) -> tensor<32x32x32x16xf64>
    %258 = stablehlo.concatenate %255, %257, dim = 3 : (tensor<32x32x32x16xf64>, tensor<32x32x32x16xf64>) -> tensor<32x32x32x32xf64>
    %cst_68 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %259 = stablehlo.broadcast_in_dim %cst_68, dims = [] : (tensor<f64>) -> tensor<32x32x32x32xf64>
    %260 = call @_roll_static_55(%258) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %261 = stablehlo.slice %205 [0:1, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %262 = stablehlo.reshape %261 : (tensor<1x32xf64>) -> tensor<32xf64>
    %263 = stablehlo.reshape %262 : (tensor<32xf64>) -> tensor<1x1x1x32xf64>
    %264 = stablehlo.broadcast_in_dim %263, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf64>) -> tensor<32x32x32x32xf64>
    %265 = stablehlo.multiply %260, %264 : tensor<32x32x32x32xf64>
    %266 = stablehlo.add %259, %265 : tensor<32x32x32x32xf64>
    %267 = call @_roll_static_61(%258) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %268 = stablehlo.slice %205 [1:2, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %269 = stablehlo.reshape %268 : (tensor<1x32xf64>) -> tensor<32xf64>
    %270 = stablehlo.reshape %269 : (tensor<32xf64>) -> tensor<1x1x1x32xf64>
    %271 = stablehlo.broadcast_in_dim %270, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf64>) -> tensor<32x32x32x32xf64>
    %272 = stablehlo.multiply %267, %271 : tensor<32x32x32x32xf64>
    %273 = stablehlo.add %266, %272 : tensor<32x32x32x32xf64>
    %274 = call @_roll_static_65(%258) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %275 = stablehlo.slice %205 [2:3, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %276 = stablehlo.reshape %275 : (tensor<1x32xf64>) -> tensor<32xf64>
    %277 = stablehlo.reshape %276 : (tensor<32xf64>) -> tensor<1x1x1x32xf64>
    %278 = stablehlo.broadcast_in_dim %277, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf64>) -> tensor<32x32x32x32xf64>
    %279 = stablehlo.multiply %274, %278 : tensor<32x32x32x32xf64>
    %280 = stablehlo.add %273, %279 : tensor<32x32x32x32xf64>
    %281 = call @_roll_static_68(%258) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %282 = stablehlo.slice %205 [3:4, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %283 = stablehlo.reshape %282 : (tensor<1x32xf64>) -> tensor<32xf64>
    %284 = stablehlo.reshape %283 : (tensor<32xf64>) -> tensor<1x1x1x32xf64>
    %285 = stablehlo.broadcast_in_dim %284, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf64>) -> tensor<32x32x32x32xf64>
    %286 = stablehlo.multiply %281, %285 : tensor<32x32x32x32xf64>
    %287 = stablehlo.add %280, %286 : tensor<32x32x32x32xf64>
    %288 = call @_roll_static_72(%258) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %289 = stablehlo.slice %205 [4:5, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %290 = stablehlo.reshape %289 : (tensor<1x32xf64>) -> tensor<32xf64>
    %291 = stablehlo.reshape %290 : (tensor<32xf64>) -> tensor<1x1x1x32xf64>
    %292 = stablehlo.broadcast_in_dim %291, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf64>) -> tensor<32x32x32x32xf64>
    %293 = stablehlo.multiply %288, %292 : tensor<32x32x32x32xf64>
    %294 = stablehlo.add %287, %293 : tensor<32x32x32x32xf64>
    %295 = call @_roll_static_76(%258) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %296 = stablehlo.slice %205 [5:6, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %297 = stablehlo.reshape %296 : (tensor<1x32xf64>) -> tensor<32xf64>
    %298 = stablehlo.reshape %297 : (tensor<32xf64>) -> tensor<1x1x1x32xf64>
    %299 = stablehlo.broadcast_in_dim %298, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf64>) -> tensor<32x32x32x32xf64>
    %300 = stablehlo.multiply %295, %299 : tensor<32x32x32x32xf64>
    %301 = stablehlo.add %294, %300 : tensor<32x32x32x32xf64>
    %cst_69 = stablehlo.constant dense<0.32258064516129031> : tensor<f64>
    %cst_70 = stablehlo.constant dense<0.32258064516129031> : tensor<f64>
    %302:4 = call @solve_poisson(%301, %arg2, %arg3, %arg4, %cst_69, %cst_70) : (tensor<32x32x32x32xf64>, tensor<32x1xf64>, tensor<1x17xf64>, tensor<32x17xf64>, tensor<f64>, tensor<f64>) -> (tensor<32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>)
    %cst_71 = stablehlo.constant dense<5.000000e-02> : tensor<f64>
    %303 = stablehlo.broadcast_in_dim %cst_71, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %304 = stablehlo.multiply %302#0, %303 : tensor<32x32xf64>
    %cst_72 = stablehlo.constant dense<0.32258064516129031> : tensor<f64>
    %305 = stablehlo.broadcast_in_dim %cst_72, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %306 = stablehlo.divide %304, %305 : tensor<32x32xf64>
    %307 = stablehlo.floor %306 : tensor<32x32xf64>
    %308 = stablehlo.subtract %306, %307 : tensor<32x32xf64>
    %309 = stablehlo.convert %307 : (tensor<32x32xf64>) -> tensor<32x32xi32>
    %310 = stablehlo.multiply %308, %308 : tensor<32x32xf64>
    %311 = stablehlo.multiply %310, %308 : tensor<32x32xf64>
    %312 = stablehlo.multiply %311, %308 : tensor<32x32xf64>
    %313 = stablehlo.multiply %312, %308 : tensor<32x32xf64>
    %cst_73 = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %314 = stablehlo.broadcast_in_dim %cst_73, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %315 = stablehlo.divide %308, %314 : tensor<32x32xf64>
    %cst_74 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %316 = stablehlo.broadcast_in_dim %cst_74, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %317 = stablehlo.divide %310, %316 : tensor<32x32xf64>
    %318 = stablehlo.subtract %315, %317 : tensor<32x32xf64>
    %cst_75 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %319 = stablehlo.broadcast_in_dim %cst_75, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %320 = stablehlo.divide %311, %319 : tensor<32x32xf64>
    %321 = stablehlo.subtract %318, %320 : tensor<32x32xf64>
    %cst_76 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %322 = stablehlo.broadcast_in_dim %cst_76, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %323 = stablehlo.divide %312, %322 : tensor<32x32xf64>
    %324 = stablehlo.add %321, %323 : tensor<32x32xf64>
    %cst_77 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %325 = stablehlo.broadcast_in_dim %cst_77, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %326 = stablehlo.divide %313, %325 : tensor<32x32xf64>
    %327 = stablehlo.subtract %324, %326 : tensor<32x32xf64>
    %cst_78 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %328 = stablehlo.broadcast_in_dim %cst_78, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %329 = stablehlo.divide %308, %328 : tensor<32x32xf64>
    %330 = stablehlo.negate %329 : tensor<32x32xf64>
    %cst_79 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %331 = stablehlo.broadcast_in_dim %cst_79, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %332 = stablehlo.multiply %331, %310 : tensor<32x32xf64>
    %cst_80 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %333 = stablehlo.broadcast_in_dim %cst_80, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %334 = stablehlo.divide %332, %333 : tensor<32x32xf64>
    %335 = stablehlo.add %330, %334 : tensor<32x32xf64>
    %cst_81 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %336 = stablehlo.broadcast_in_dim %cst_81, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %337 = stablehlo.divide %311, %336 : tensor<32x32xf64>
    %338 = stablehlo.subtract %335, %337 : tensor<32x32xf64>
    %cst_82 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %339 = stablehlo.broadcast_in_dim %cst_82, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %340 = stablehlo.divide %312, %339 : tensor<32x32xf64>
    %341 = stablehlo.subtract %338, %340 : tensor<32x32xf64>
    %cst_83 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %342 = stablehlo.broadcast_in_dim %cst_83, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %343 = stablehlo.divide %313, %342 : tensor<32x32xf64>
    %344 = stablehlo.add %341, %343 : tensor<32x32xf64>
    %cst_84 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %345 = stablehlo.broadcast_in_dim %cst_84, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %346 = stablehlo.divide %308, %345 : tensor<32x32xf64>
    %cst_85 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %347 = stablehlo.broadcast_in_dim %cst_85, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %348 = stablehlo.subtract %347, %346 : tensor<32x32xf64>
    %cst_86 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %349 = stablehlo.broadcast_in_dim %cst_86, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %350 = stablehlo.multiply %349, %310 : tensor<32x32xf64>
    %cst_87 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %351 = stablehlo.broadcast_in_dim %cst_87, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %352 = stablehlo.divide %350, %351 : tensor<32x32xf64>
    %353 = stablehlo.subtract %348, %352 : tensor<32x32xf64>
    %cst_88 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %354 = stablehlo.broadcast_in_dim %cst_88, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %355 = stablehlo.multiply %354, %311 : tensor<32x32xf64>
    %cst_89 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %356 = stablehlo.broadcast_in_dim %cst_89, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %357 = stablehlo.divide %355, %356 : tensor<32x32xf64>
    %358 = stablehlo.add %353, %357 : tensor<32x32xf64>
    %cst_90 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %359 = stablehlo.broadcast_in_dim %cst_90, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %360 = stablehlo.divide %312, %359 : tensor<32x32xf64>
    %361 = stablehlo.add %358, %360 : tensor<32x32xf64>
    %cst_91 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %362 = stablehlo.broadcast_in_dim %cst_91, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %363 = stablehlo.divide %313, %362 : tensor<32x32xf64>
    %364 = stablehlo.subtract %361, %363 : tensor<32x32xf64>
    %cst_92 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %365 = stablehlo.broadcast_in_dim %cst_92, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %366 = stablehlo.multiply %365, %310 : tensor<32x32xf64>
    %cst_93 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %367 = stablehlo.broadcast_in_dim %cst_93, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %368 = stablehlo.divide %366, %367 : tensor<32x32xf64>
    %369 = stablehlo.add %308, %368 : tensor<32x32xf64>
    %cst_94 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %370 = stablehlo.broadcast_in_dim %cst_94, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %371 = stablehlo.multiply %370, %311 : tensor<32x32xf64>
    %cst_95 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %372 = stablehlo.broadcast_in_dim %cst_95, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %373 = stablehlo.divide %371, %372 : tensor<32x32xf64>
    %374 = stablehlo.subtract %369, %373 : tensor<32x32xf64>
    %cst_96 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %375 = stablehlo.broadcast_in_dim %cst_96, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %376 = stablehlo.divide %312, %375 : tensor<32x32xf64>
    %377 = stablehlo.subtract %374, %376 : tensor<32x32xf64>
    %cst_97 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %378 = stablehlo.broadcast_in_dim %cst_97, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %379 = stablehlo.divide %313, %378 : tensor<32x32xf64>
    %380 = stablehlo.add %377, %379 : tensor<32x32xf64>
    %cst_98 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %381 = stablehlo.broadcast_in_dim %cst_98, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %382 = stablehlo.divide %308, %381 : tensor<32x32xf64>
    %383 = stablehlo.negate %382 : tensor<32x32xf64>
    %cst_99 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %384 = stablehlo.broadcast_in_dim %cst_99, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %385 = stablehlo.divide %310, %384 : tensor<32x32xf64>
    %386 = stablehlo.subtract %383, %385 : tensor<32x32xf64>
    %cst_100 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %387 = stablehlo.broadcast_in_dim %cst_100, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %388 = stablehlo.multiply %387, %311 : tensor<32x32xf64>
    %cst_101 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %389 = stablehlo.broadcast_in_dim %cst_101, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %390 = stablehlo.divide %388, %389 : tensor<32x32xf64>
    %391 = stablehlo.add %386, %390 : tensor<32x32xf64>
    %cst_102 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %392 = stablehlo.broadcast_in_dim %cst_102, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %393 = stablehlo.divide %312, %392 : tensor<32x32xf64>
    %394 = stablehlo.add %391, %393 : tensor<32x32xf64>
    %cst_103 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %395 = stablehlo.broadcast_in_dim %cst_103, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %396 = stablehlo.divide %313, %395 : tensor<32x32xf64>
    %397 = stablehlo.subtract %394, %396 : tensor<32x32xf64>
    %cst_104 = stablehlo.constant dense<3.000000e+01> : tensor<f64>
    %398 = stablehlo.broadcast_in_dim %cst_104, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %399 = stablehlo.divide %308, %398 : tensor<32x32xf64>
    %cst_105 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %400 = stablehlo.broadcast_in_dim %cst_105, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %401 = stablehlo.divide %311, %400 : tensor<32x32xf64>
    %402 = stablehlo.subtract %399, %401 : tensor<32x32xf64>
    %cst_106 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %403 = stablehlo.broadcast_in_dim %cst_106, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %404 = stablehlo.divide %313, %403 : tensor<32x32xf64>
    %405 = stablehlo.add %402, %404 : tensor<32x32xf64>
    %406 = stablehlo.broadcast_in_dim %327, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %407 = stablehlo.broadcast_in_dim %344, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %408 = stablehlo.broadcast_in_dim %364, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %409 = stablehlo.broadcast_in_dim %380, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %410 = stablehlo.broadcast_in_dim %397, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %411 = stablehlo.broadcast_in_dim %405, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %412 = stablehlo.concatenate %406, %407, %408, %409, %410, %411, dim = 0 : (tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>) -> tensor<6x32x32xf64>
    %cst_107 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %413 = stablehlo.broadcast_in_dim %cst_107, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c = stablehlo.constant dense<-1> : tensor<i32>
    %414 = stablehlo.broadcast_in_dim %c, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %415 = stablehlo.compare  EQ, %309, %414,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %416 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %417 = stablehlo.reshape %416 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_108 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %418 = call @_where(%415, %417, %cst_108) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %419 = stablehlo.add %413, %418 : tensor<32x32xf64>
    %c_109 = stablehlo.constant dense<-2> : tensor<i32>
    %420 = stablehlo.broadcast_in_dim %c_109, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %421 = stablehlo.compare  EQ, %309, %420,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %422 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %423 = stablehlo.reshape %422 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_110 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %424 = call @_where(%421, %423, %cst_110) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %425 = stablehlo.add %419, %424 : tensor<32x32xf64>
    %c_111 = stablehlo.constant dense<-3> : tensor<i32>
    %426 = stablehlo.broadcast_in_dim %c_111, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %427 = stablehlo.compare  EQ, %309, %426,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %428 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %429 = stablehlo.reshape %428 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_112 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %430 = call @_where(%427, %429, %cst_112) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %431 = stablehlo.add %425, %430 : tensor<32x32xf64>
    %c_113 = stablehlo.constant dense<-4> : tensor<i32>
    %432 = stablehlo.broadcast_in_dim %c_113, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %433 = stablehlo.compare  EQ, %309, %432,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %434 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %435 = stablehlo.reshape %434 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_114 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %436 = call @_where(%433, %435, %cst_114) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %437 = stablehlo.add %431, %436 : tensor<32x32xf64>
    %c_115 = stablehlo.constant dense<-5> : tensor<i32>
    %438 = stablehlo.broadcast_in_dim %c_115, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %439 = stablehlo.compare  EQ, %309, %438,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %440 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %441 = stablehlo.reshape %440 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_116 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %442 = call @_where(%439, %441, %cst_116) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %443 = stablehlo.add %437, %442 : tensor<32x32xf64>
    %c_117 = stablehlo.constant dense<-6> : tensor<i32>
    %444 = stablehlo.broadcast_in_dim %c_117, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %445 = stablehlo.compare  EQ, %309, %444,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %446 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %447 = stablehlo.reshape %446 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_118 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %448 = call @_where(%445, %447, %cst_118) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %449 = stablehlo.add %443, %448 : tensor<32x32xf64>
    %cst_119 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %450 = stablehlo.broadcast_in_dim %cst_119, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c_120 = stablehlo.constant dense<0> : tensor<i32>
    %451 = stablehlo.broadcast_in_dim %c_120, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %452 = stablehlo.compare  EQ, %309, %451,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %453 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %454 = stablehlo.reshape %453 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_121 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %455 = call @_where(%452, %454, %cst_121) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %456 = stablehlo.add %450, %455 : tensor<32x32xf64>
    %c_122 = stablehlo.constant dense<-1> : tensor<i32>
    %457 = stablehlo.broadcast_in_dim %c_122, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %458 = stablehlo.compare  EQ, %309, %457,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %459 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %460 = stablehlo.reshape %459 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_123 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %461 = call @_where(%458, %460, %cst_123) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %462 = stablehlo.add %456, %461 : tensor<32x32xf64>
    %c_124 = stablehlo.constant dense<-2> : tensor<i32>
    %463 = stablehlo.broadcast_in_dim %c_124, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %464 = stablehlo.compare  EQ, %309, %463,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %465 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %466 = stablehlo.reshape %465 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_125 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %467 = call @_where(%464, %466, %cst_125) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %468 = stablehlo.add %462, %467 : tensor<32x32xf64>
    %c_126 = stablehlo.constant dense<-3> : tensor<i32>
    %469 = stablehlo.broadcast_in_dim %c_126, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %470 = stablehlo.compare  EQ, %309, %469,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %471 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %472 = stablehlo.reshape %471 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_127 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %473 = call @_where(%470, %472, %cst_127) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %474 = stablehlo.add %468, %473 : tensor<32x32xf64>
    %c_128 = stablehlo.constant dense<-4> : tensor<i32>
    %475 = stablehlo.broadcast_in_dim %c_128, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %476 = stablehlo.compare  EQ, %309, %475,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %477 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %478 = stablehlo.reshape %477 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_129 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %479 = call @_where(%476, %478, %cst_129) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %480 = stablehlo.add %474, %479 : tensor<32x32xf64>
    %c_130 = stablehlo.constant dense<-5> : tensor<i32>
    %481 = stablehlo.broadcast_in_dim %c_130, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %482 = stablehlo.compare  EQ, %309, %481,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %483 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %484 = stablehlo.reshape %483 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_131 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %485 = call @_where(%482, %484, %cst_131) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %486 = stablehlo.add %480, %485 : tensor<32x32xf64>
    %cst_132 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %487 = stablehlo.broadcast_in_dim %cst_132, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c_133 = stablehlo.constant dense<1> : tensor<i32>
    %488 = stablehlo.broadcast_in_dim %c_133, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %489 = stablehlo.compare  EQ, %309, %488,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %490 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %491 = stablehlo.reshape %490 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_134 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %492 = call @_where(%489, %491, %cst_134) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %493 = stablehlo.add %487, %492 : tensor<32x32xf64>
    %c_135 = stablehlo.constant dense<0> : tensor<i32>
    %494 = stablehlo.broadcast_in_dim %c_135, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %495 = stablehlo.compare  EQ, %309, %494,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %496 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %497 = stablehlo.reshape %496 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_136 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %498 = call @_where(%495, %497, %cst_136) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %499 = stablehlo.add %493, %498 : tensor<32x32xf64>
    %c_137 = stablehlo.constant dense<-1> : tensor<i32>
    %500 = stablehlo.broadcast_in_dim %c_137, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %501 = stablehlo.compare  EQ, %309, %500,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %502 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %503 = stablehlo.reshape %502 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_138 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %504 = call @_where(%501, %503, %cst_138) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %505 = stablehlo.add %499, %504 : tensor<32x32xf64>
    %c_139 = stablehlo.constant dense<-2> : tensor<i32>
    %506 = stablehlo.broadcast_in_dim %c_139, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %507 = stablehlo.compare  EQ, %309, %506,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %508 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %509 = stablehlo.reshape %508 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_140 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %510 = call @_where(%507, %509, %cst_140) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %511 = stablehlo.add %505, %510 : tensor<32x32xf64>
    %c_141 = stablehlo.constant dense<-3> : tensor<i32>
    %512 = stablehlo.broadcast_in_dim %c_141, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %513 = stablehlo.compare  EQ, %309, %512,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %514 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %515 = stablehlo.reshape %514 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_142 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %516 = call @_where(%513, %515, %cst_142) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %517 = stablehlo.add %511, %516 : tensor<32x32xf64>
    %c_143 = stablehlo.constant dense<-4> : tensor<i32>
    %518 = stablehlo.broadcast_in_dim %c_143, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %519 = stablehlo.compare  EQ, %309, %518,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %520 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %521 = stablehlo.reshape %520 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_144 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %522 = call @_where(%519, %521, %cst_144) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %523 = stablehlo.add %517, %522 : tensor<32x32xf64>
    %cst_145 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %524 = stablehlo.broadcast_in_dim %cst_145, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c_146 = stablehlo.constant dense<2> : tensor<i32>
    %525 = stablehlo.broadcast_in_dim %c_146, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %526 = stablehlo.compare  EQ, %309, %525,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %527 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %528 = stablehlo.reshape %527 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_147 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %529 = call @_where(%526, %528, %cst_147) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %530 = stablehlo.add %524, %529 : tensor<32x32xf64>
    %c_148 = stablehlo.constant dense<1> : tensor<i32>
    %531 = stablehlo.broadcast_in_dim %c_148, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %532 = stablehlo.compare  EQ, %309, %531,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %533 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %534 = stablehlo.reshape %533 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_149 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %535 = call @_where(%532, %534, %cst_149) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %536 = stablehlo.add %530, %535 : tensor<32x32xf64>
    %c_150 = stablehlo.constant dense<0> : tensor<i32>
    %537 = stablehlo.broadcast_in_dim %c_150, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %538 = stablehlo.compare  EQ, %309, %537,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %539 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %540 = stablehlo.reshape %539 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_151 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %541 = call @_where(%538, %540, %cst_151) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %542 = stablehlo.add %536, %541 : tensor<32x32xf64>
    %c_152 = stablehlo.constant dense<-1> : tensor<i32>
    %543 = stablehlo.broadcast_in_dim %c_152, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %544 = stablehlo.compare  EQ, %309, %543,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %545 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %546 = stablehlo.reshape %545 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_153 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %547 = call @_where(%544, %546, %cst_153) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %548 = stablehlo.add %542, %547 : tensor<32x32xf64>
    %c_154 = stablehlo.constant dense<-2> : tensor<i32>
    %549 = stablehlo.broadcast_in_dim %c_154, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %550 = stablehlo.compare  EQ, %309, %549,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %551 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %552 = stablehlo.reshape %551 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_155 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %553 = call @_where(%550, %552, %cst_155) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %554 = stablehlo.add %548, %553 : tensor<32x32xf64>
    %c_156 = stablehlo.constant dense<-3> : tensor<i32>
    %555 = stablehlo.broadcast_in_dim %c_156, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %556 = stablehlo.compare  EQ, %309, %555,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %557 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %558 = stablehlo.reshape %557 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_157 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %559 = call @_where(%556, %558, %cst_157) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %560 = stablehlo.add %554, %559 : tensor<32x32xf64>
    %cst_158 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %561 = stablehlo.broadcast_in_dim %cst_158, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c_159 = stablehlo.constant dense<3> : tensor<i32>
    %562 = stablehlo.broadcast_in_dim %c_159, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %563 = stablehlo.compare  EQ, %309, %562,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %564 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %565 = stablehlo.reshape %564 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_160 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %566 = call @_where(%563, %565, %cst_160) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %567 = stablehlo.add %561, %566 : tensor<32x32xf64>
    %c_161 = stablehlo.constant dense<2> : tensor<i32>
    %568 = stablehlo.broadcast_in_dim %c_161, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %569 = stablehlo.compare  EQ, %309, %568,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %570 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %571 = stablehlo.reshape %570 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_162 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %572 = call @_where(%569, %571, %cst_162) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %573 = stablehlo.add %567, %572 : tensor<32x32xf64>
    %c_163 = stablehlo.constant dense<1> : tensor<i32>
    %574 = stablehlo.broadcast_in_dim %c_163, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %575 = stablehlo.compare  EQ, %309, %574,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %576 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %577 = stablehlo.reshape %576 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_164 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %578 = call @_where(%575, %577, %cst_164) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %579 = stablehlo.add %573, %578 : tensor<32x32xf64>
    %c_165 = stablehlo.constant dense<0> : tensor<i32>
    %580 = stablehlo.broadcast_in_dim %c_165, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %581 = stablehlo.compare  EQ, %309, %580,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %582 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %583 = stablehlo.reshape %582 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_166 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %584 = call @_where(%581, %583, %cst_166) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %585 = stablehlo.add %579, %584 : tensor<32x32xf64>
    %c_167 = stablehlo.constant dense<-1> : tensor<i32>
    %586 = stablehlo.broadcast_in_dim %c_167, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %587 = stablehlo.compare  EQ, %309, %586,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %588 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %589 = stablehlo.reshape %588 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_168 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %590 = call @_where(%587, %589, %cst_168) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %591 = stablehlo.add %585, %590 : tensor<32x32xf64>
    %c_169 = stablehlo.constant dense<-2> : tensor<i32>
    %592 = stablehlo.broadcast_in_dim %c_169, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %593 = stablehlo.compare  EQ, %309, %592,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %594 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %595 = stablehlo.reshape %594 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_170 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %596 = call @_where(%593, %595, %cst_170) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %597 = stablehlo.add %591, %596 : tensor<32x32xf64>
    %cst_171 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %598 = stablehlo.broadcast_in_dim %cst_171, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c_172 = stablehlo.constant dense<4> : tensor<i32>
    %599 = stablehlo.broadcast_in_dim %c_172, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %600 = stablehlo.compare  EQ, %309, %599,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %601 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %602 = stablehlo.reshape %601 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_173 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %603 = call @_where(%600, %602, %cst_173) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %604 = stablehlo.add %598, %603 : tensor<32x32xf64>
    %c_174 = stablehlo.constant dense<3> : tensor<i32>
    %605 = stablehlo.broadcast_in_dim %c_174, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %606 = stablehlo.compare  EQ, %309, %605,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %607 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %608 = stablehlo.reshape %607 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_175 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %609 = call @_where(%606, %608, %cst_175) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %610 = stablehlo.add %604, %609 : tensor<32x32xf64>
    %c_176 = stablehlo.constant dense<2> : tensor<i32>
    %611 = stablehlo.broadcast_in_dim %c_176, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %612 = stablehlo.compare  EQ, %309, %611,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %613 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %614 = stablehlo.reshape %613 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_177 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %615 = call @_where(%612, %614, %cst_177) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %616 = stablehlo.add %610, %615 : tensor<32x32xf64>
    %c_178 = stablehlo.constant dense<1> : tensor<i32>
    %617 = stablehlo.broadcast_in_dim %c_178, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %618 = stablehlo.compare  EQ, %309, %617,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %619 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %620 = stablehlo.reshape %619 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_179 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %621 = call @_where(%618, %620, %cst_179) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %622 = stablehlo.add %616, %621 : tensor<32x32xf64>
    %c_180 = stablehlo.constant dense<0> : tensor<i32>
    %623 = stablehlo.broadcast_in_dim %c_180, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %624 = stablehlo.compare  EQ, %309, %623,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %625 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %626 = stablehlo.reshape %625 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_181 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %627 = call @_where(%624, %626, %cst_181) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %628 = stablehlo.add %622, %627 : tensor<32x32xf64>
    %c_182 = stablehlo.constant dense<-1> : tensor<i32>
    %629 = stablehlo.broadcast_in_dim %c_182, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %630 = stablehlo.compare  EQ, %309, %629,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %631 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %632 = stablehlo.reshape %631 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_183 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %633 = call @_where(%630, %632, %cst_183) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %634 = stablehlo.add %628, %633 : tensor<32x32xf64>
    %cst_184 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %635 = stablehlo.broadcast_in_dim %cst_184, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c_185 = stablehlo.constant dense<5> : tensor<i32>
    %636 = stablehlo.broadcast_in_dim %c_185, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %637 = stablehlo.compare  EQ, %309, %636,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %638 = stablehlo.slice %412 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %639 = stablehlo.reshape %638 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_186 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %640 = call @_where(%637, %639, %cst_186) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %641 = stablehlo.add %635, %640 : tensor<32x32xf64>
    %c_187 = stablehlo.constant dense<4> : tensor<i32>
    %642 = stablehlo.broadcast_in_dim %c_187, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %643 = stablehlo.compare  EQ, %309, %642,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %644 = stablehlo.slice %412 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %645 = stablehlo.reshape %644 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_188 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %646 = call @_where(%643, %645, %cst_188) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %647 = stablehlo.add %641, %646 : tensor<32x32xf64>
    %c_189 = stablehlo.constant dense<3> : tensor<i32>
    %648 = stablehlo.broadcast_in_dim %c_189, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %649 = stablehlo.compare  EQ, %309, %648,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %650 = stablehlo.slice %412 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %651 = stablehlo.reshape %650 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_190 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %652 = call @_where(%649, %651, %cst_190) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %653 = stablehlo.add %647, %652 : tensor<32x32xf64>
    %c_191 = stablehlo.constant dense<2> : tensor<i32>
    %654 = stablehlo.broadcast_in_dim %c_191, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %655 = stablehlo.compare  EQ, %309, %654,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %656 = stablehlo.slice %412 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %657 = stablehlo.reshape %656 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_192 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %658 = call @_where(%655, %657, %cst_192) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %659 = stablehlo.add %653, %658 : tensor<32x32xf64>
    %c_193 = stablehlo.constant dense<1> : tensor<i32>
    %660 = stablehlo.broadcast_in_dim %c_193, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %661 = stablehlo.compare  EQ, %309, %660,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %662 = stablehlo.slice %412 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %663 = stablehlo.reshape %662 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_194 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %664 = call @_where(%661, %663, %cst_194) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %665 = stablehlo.add %659, %664 : tensor<32x32xf64>
    %c_195 = stablehlo.constant dense<0> : tensor<i32>
    %666 = stablehlo.broadcast_in_dim %c_195, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %667 = stablehlo.compare  EQ, %309, %666,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %668 = stablehlo.slice %412 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %669 = stablehlo.reshape %668 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_196 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %670 = call @_where(%667, %669, %cst_196) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %671 = stablehlo.add %665, %670 : tensor<32x32xf64>
    %672 = stablehlo.broadcast_in_dim %449, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %673 = stablehlo.broadcast_in_dim %486, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %674 = stablehlo.broadcast_in_dim %523, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %675 = stablehlo.broadcast_in_dim %560, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %676 = stablehlo.broadcast_in_dim %597, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %677 = stablehlo.broadcast_in_dim %634, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %678 = stablehlo.broadcast_in_dim %671, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %679 = stablehlo.concatenate %672, %673, %674, %675, %676, %677, %678, dim = 0 : (tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>) -> tensor<7x32x32xf64>
    %c_197 = stablehlo.constant dense<0> : tensor<i64>
    %680 = call @_pad(%301, %c_197) : (tensor<32x32x32x32xf64>, tensor<i64>) -> tensor<32x32x38x32xf64>
    %cst_198 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %681 = stablehlo.broadcast_in_dim %cst_198, dims = [] : (tensor<f64>) -> tensor<32x32x32x32xf64>
    %682 = stablehlo.slice %680 [0:32, 0:32, 6:38, 0:32] : (tensor<32x32x38x32xf64>) -> tensor<32x32x32x32xf64>
    %683 = stablehlo.slice %679 [0:1, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %684 = stablehlo.reshape %683 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %685 = stablehlo.broadcast_in_dim %684, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %686 = stablehlo.broadcast_in_dim %685, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %687 = stablehlo.multiply %686, %682 : tensor<32x32x32x32xf64>
    %688 = stablehlo.add %681, %687 : tensor<32x32x32x32xf64>
    %689 = stablehlo.slice %680 [0:32, 0:32, 5:37, 0:32] : (tensor<32x32x38x32xf64>) -> tensor<32x32x32x32xf64>
    %690 = stablehlo.slice %679 [1:2, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %691 = stablehlo.reshape %690 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %692 = stablehlo.broadcast_in_dim %691, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %693 = stablehlo.broadcast_in_dim %692, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %694 = stablehlo.multiply %693, %689 : tensor<32x32x32x32xf64>
    %695 = stablehlo.add %688, %694 : tensor<32x32x32x32xf64>
    %696 = stablehlo.slice %680 [0:32, 0:32, 4:36, 0:32] : (tensor<32x32x38x32xf64>) -> tensor<32x32x32x32xf64>
    %697 = stablehlo.slice %679 [2:3, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %698 = stablehlo.reshape %697 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %699 = stablehlo.broadcast_in_dim %698, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %700 = stablehlo.broadcast_in_dim %699, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %701 = stablehlo.multiply %700, %696 : tensor<32x32x32x32xf64>
    %702 = stablehlo.add %695, %701 : tensor<32x32x32x32xf64>
    %703 = stablehlo.slice %680 [0:32, 0:32, 3:35, 0:32] : (tensor<32x32x38x32xf64>) -> tensor<32x32x32x32xf64>
    %704 = stablehlo.slice %679 [3:4, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %705 = stablehlo.reshape %704 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %706 = stablehlo.broadcast_in_dim %705, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %707 = stablehlo.broadcast_in_dim %706, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %708 = stablehlo.multiply %707, %703 : tensor<32x32x32x32xf64>
    %709 = stablehlo.add %702, %708 : tensor<32x32x32x32xf64>
    %710 = stablehlo.slice %680 [0:32, 0:32, 2:34, 0:32] : (tensor<32x32x38x32xf64>) -> tensor<32x32x32x32xf64>
    %711 = stablehlo.slice %679 [4:5, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %712 = stablehlo.reshape %711 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %713 = stablehlo.broadcast_in_dim %712, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %714 = stablehlo.broadcast_in_dim %713, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %715 = stablehlo.multiply %714, %710 : tensor<32x32x32x32xf64>
    %716 = stablehlo.add %709, %715 : tensor<32x32x32x32xf64>
    %717 = stablehlo.slice %680 [0:32, 0:32, 1:33, 0:32] : (tensor<32x32x38x32xf64>) -> tensor<32x32x32x32xf64>
    %718 = stablehlo.slice %679 [5:6, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %719 = stablehlo.reshape %718 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %720 = stablehlo.broadcast_in_dim %719, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %721 = stablehlo.broadcast_in_dim %720, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %722 = stablehlo.multiply %721, %717 : tensor<32x32x32x32xf64>
    %723 = stablehlo.add %716, %722 : tensor<32x32x32x32xf64>
    %724 = stablehlo.slice %680 [0:32, 0:32, 0:32, 0:32] : (tensor<32x32x38x32xf64>) -> tensor<32x32x32x32xf64>
    %725 = stablehlo.slice %679 [6:7, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %726 = stablehlo.reshape %725 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %727 = stablehlo.broadcast_in_dim %726, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %728 = stablehlo.broadcast_in_dim %727, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %729 = stablehlo.multiply %728, %724 : tensor<32x32x32x32xf64>
    %730 = stablehlo.add %723, %729 : tensor<32x32x32x32xf64>
    %cst_199 = stablehlo.constant dense<5.000000e-02> : tensor<f64>
    %731 = stablehlo.broadcast_in_dim %cst_199, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %732 = stablehlo.multiply %302#1, %731 : tensor<32x32xf64>
    %cst_200 = stablehlo.constant dense<0.32258064516129031> : tensor<f64>
    %733 = stablehlo.broadcast_in_dim %cst_200, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %734 = stablehlo.divide %732, %733 : tensor<32x32xf64>
    %735 = stablehlo.floor %734 : tensor<32x32xf64>
    %736 = stablehlo.subtract %734, %735 : tensor<32x32xf64>
    %737 = stablehlo.convert %735 : (tensor<32x32xf64>) -> tensor<32x32xi32>
    %738 = stablehlo.multiply %736, %736 : tensor<32x32xf64>
    %739 = stablehlo.multiply %738, %736 : tensor<32x32xf64>
    %740 = stablehlo.multiply %739, %736 : tensor<32x32xf64>
    %741 = stablehlo.multiply %740, %736 : tensor<32x32xf64>
    %cst_201 = stablehlo.constant dense<2.000000e+01> : tensor<f64>
    %742 = stablehlo.broadcast_in_dim %cst_201, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %743 = stablehlo.divide %736, %742 : tensor<32x32xf64>
    %cst_202 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %744 = stablehlo.broadcast_in_dim %cst_202, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %745 = stablehlo.divide %738, %744 : tensor<32x32xf64>
    %746 = stablehlo.subtract %743, %745 : tensor<32x32xf64>
    %cst_203 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %747 = stablehlo.broadcast_in_dim %cst_203, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %748 = stablehlo.divide %739, %747 : tensor<32x32xf64>
    %749 = stablehlo.subtract %746, %748 : tensor<32x32xf64>
    %cst_204 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %750 = stablehlo.broadcast_in_dim %cst_204, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %751 = stablehlo.divide %740, %750 : tensor<32x32xf64>
    %752 = stablehlo.add %749, %751 : tensor<32x32xf64>
    %cst_205 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %753 = stablehlo.broadcast_in_dim %cst_205, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %754 = stablehlo.divide %741, %753 : tensor<32x32xf64>
    %755 = stablehlo.subtract %752, %754 : tensor<32x32xf64>
    %cst_206 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %756 = stablehlo.broadcast_in_dim %cst_206, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %757 = stablehlo.divide %736, %756 : tensor<32x32xf64>
    %758 = stablehlo.negate %757 : tensor<32x32xf64>
    %cst_207 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %759 = stablehlo.broadcast_in_dim %cst_207, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %760 = stablehlo.multiply %759, %738 : tensor<32x32xf64>
    %cst_208 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %761 = stablehlo.broadcast_in_dim %cst_208, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %762 = stablehlo.divide %760, %761 : tensor<32x32xf64>
    %763 = stablehlo.add %758, %762 : tensor<32x32xf64>
    %cst_209 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %764 = stablehlo.broadcast_in_dim %cst_209, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %765 = stablehlo.divide %739, %764 : tensor<32x32xf64>
    %766 = stablehlo.subtract %763, %765 : tensor<32x32xf64>
    %cst_210 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %767 = stablehlo.broadcast_in_dim %cst_210, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %768 = stablehlo.divide %740, %767 : tensor<32x32xf64>
    %769 = stablehlo.subtract %766, %768 : tensor<32x32xf64>
    %cst_211 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %770 = stablehlo.broadcast_in_dim %cst_211, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %771 = stablehlo.divide %741, %770 : tensor<32x32xf64>
    %772 = stablehlo.add %769, %771 : tensor<32x32xf64>
    %cst_212 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %773 = stablehlo.broadcast_in_dim %cst_212, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %774 = stablehlo.divide %736, %773 : tensor<32x32xf64>
    %cst_213 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %775 = stablehlo.broadcast_in_dim %cst_213, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %776 = stablehlo.subtract %775, %774 : tensor<32x32xf64>
    %cst_214 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %777 = stablehlo.broadcast_in_dim %cst_214, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %778 = stablehlo.multiply %777, %738 : tensor<32x32xf64>
    %cst_215 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %779 = stablehlo.broadcast_in_dim %cst_215, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %780 = stablehlo.divide %778, %779 : tensor<32x32xf64>
    %781 = stablehlo.subtract %776, %780 : tensor<32x32xf64>
    %cst_216 = stablehlo.constant dense<5.000000e+00> : tensor<f64>
    %782 = stablehlo.broadcast_in_dim %cst_216, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %783 = stablehlo.multiply %782, %739 : tensor<32x32xf64>
    %cst_217 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %784 = stablehlo.broadcast_in_dim %cst_217, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %785 = stablehlo.divide %783, %784 : tensor<32x32xf64>
    %786 = stablehlo.add %781, %785 : tensor<32x32xf64>
    %cst_218 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %787 = stablehlo.broadcast_in_dim %cst_218, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %788 = stablehlo.divide %740, %787 : tensor<32x32xf64>
    %789 = stablehlo.add %786, %788 : tensor<32x32xf64>
    %cst_219 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %790 = stablehlo.broadcast_in_dim %cst_219, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %791 = stablehlo.divide %741, %790 : tensor<32x32xf64>
    %792 = stablehlo.subtract %789, %791 : tensor<32x32xf64>
    %cst_220 = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %793 = stablehlo.broadcast_in_dim %cst_220, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %794 = stablehlo.multiply %793, %738 : tensor<32x32xf64>
    %cst_221 = stablehlo.constant dense<3.000000e+00> : tensor<f64>
    %795 = stablehlo.broadcast_in_dim %cst_221, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %796 = stablehlo.divide %794, %795 : tensor<32x32xf64>
    %797 = stablehlo.add %736, %796 : tensor<32x32xf64>
    %cst_222 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %798 = stablehlo.broadcast_in_dim %cst_222, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %799 = stablehlo.multiply %798, %739 : tensor<32x32xf64>
    %cst_223 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %800 = stablehlo.broadcast_in_dim %cst_223, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %801 = stablehlo.divide %799, %800 : tensor<32x32xf64>
    %802 = stablehlo.subtract %797, %801 : tensor<32x32xf64>
    %cst_224 = stablehlo.constant dense<6.000000e+00> : tensor<f64>
    %803 = stablehlo.broadcast_in_dim %cst_224, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %804 = stablehlo.divide %740, %803 : tensor<32x32xf64>
    %805 = stablehlo.subtract %802, %804 : tensor<32x32xf64>
    %cst_225 = stablehlo.constant dense<1.200000e+01> : tensor<f64>
    %806 = stablehlo.broadcast_in_dim %cst_225, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %807 = stablehlo.divide %741, %806 : tensor<32x32xf64>
    %808 = stablehlo.add %805, %807 : tensor<32x32xf64>
    %cst_226 = stablehlo.constant dense<4.000000e+00> : tensor<f64>
    %809 = stablehlo.broadcast_in_dim %cst_226, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %810 = stablehlo.divide %736, %809 : tensor<32x32xf64>
    %811 = stablehlo.negate %810 : tensor<32x32xf64>
    %cst_227 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %812 = stablehlo.broadcast_in_dim %cst_227, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %813 = stablehlo.divide %738, %812 : tensor<32x32xf64>
    %814 = stablehlo.subtract %811, %813 : tensor<32x32xf64>
    %cst_228 = stablehlo.constant dense<7.000000e+00> : tensor<f64>
    %815 = stablehlo.broadcast_in_dim %cst_228, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %816 = stablehlo.multiply %815, %739 : tensor<32x32xf64>
    %cst_229 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %817 = stablehlo.broadcast_in_dim %cst_229, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %818 = stablehlo.divide %816, %817 : tensor<32x32xf64>
    %819 = stablehlo.add %814, %818 : tensor<32x32xf64>
    %cst_230 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %820 = stablehlo.broadcast_in_dim %cst_230, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %821 = stablehlo.divide %740, %820 : tensor<32x32xf64>
    %822 = stablehlo.add %819, %821 : tensor<32x32xf64>
    %cst_231 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %823 = stablehlo.broadcast_in_dim %cst_231, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %824 = stablehlo.divide %741, %823 : tensor<32x32xf64>
    %825 = stablehlo.subtract %822, %824 : tensor<32x32xf64>
    %cst_232 = stablehlo.constant dense<3.000000e+01> : tensor<f64>
    %826 = stablehlo.broadcast_in_dim %cst_232, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %827 = stablehlo.divide %736, %826 : tensor<32x32xf64>
    %cst_233 = stablehlo.constant dense<2.400000e+01> : tensor<f64>
    %828 = stablehlo.broadcast_in_dim %cst_233, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %829 = stablehlo.divide %739, %828 : tensor<32x32xf64>
    %830 = stablehlo.subtract %827, %829 : tensor<32x32xf64>
    %cst_234 = stablehlo.constant dense<1.200000e+02> : tensor<f64>
    %831 = stablehlo.broadcast_in_dim %cst_234, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %832 = stablehlo.divide %741, %831 : tensor<32x32xf64>
    %833 = stablehlo.add %830, %832 : tensor<32x32xf64>
    %834 = stablehlo.broadcast_in_dim %755, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %835 = stablehlo.broadcast_in_dim %772, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %836 = stablehlo.broadcast_in_dim %792, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %837 = stablehlo.broadcast_in_dim %808, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %838 = stablehlo.broadcast_in_dim %825, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %839 = stablehlo.broadcast_in_dim %833, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %840 = stablehlo.concatenate %834, %835, %836, %837, %838, %839, dim = 0 : (tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>) -> tensor<6x32x32xf64>
    %cst_235 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %841 = stablehlo.broadcast_in_dim %cst_235, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c_236 = stablehlo.constant dense<-1> : tensor<i32>
    %842 = stablehlo.broadcast_in_dim %c_236, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %843 = stablehlo.compare  EQ, %737, %842,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %844 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %845 = stablehlo.reshape %844 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_237 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %846 = call @_where(%843, %845, %cst_237) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %847 = stablehlo.add %841, %846 : tensor<32x32xf64>
    %c_238 = stablehlo.constant dense<-2> : tensor<i32>
    %848 = stablehlo.broadcast_in_dim %c_238, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %849 = stablehlo.compare  EQ, %737, %848,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %850 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %851 = stablehlo.reshape %850 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_239 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %852 = call @_where(%849, %851, %cst_239) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %853 = stablehlo.add %847, %852 : tensor<32x32xf64>
    %c_240 = stablehlo.constant dense<-3> : tensor<i32>
    %854 = stablehlo.broadcast_in_dim %c_240, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %855 = stablehlo.compare  EQ, %737, %854,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %856 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %857 = stablehlo.reshape %856 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_241 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %858 = call @_where(%855, %857, %cst_241) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %859 = stablehlo.add %853, %858 : tensor<32x32xf64>
    %c_242 = stablehlo.constant dense<-4> : tensor<i32>
    %860 = stablehlo.broadcast_in_dim %c_242, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %861 = stablehlo.compare  EQ, %737, %860,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %862 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %863 = stablehlo.reshape %862 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_243 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %864 = call @_where(%861, %863, %cst_243) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %865 = stablehlo.add %859, %864 : tensor<32x32xf64>
    %c_244 = stablehlo.constant dense<-5> : tensor<i32>
    %866 = stablehlo.broadcast_in_dim %c_244, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %867 = stablehlo.compare  EQ, %737, %866,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %868 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %869 = stablehlo.reshape %868 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_245 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %870 = call @_where(%867, %869, %cst_245) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %871 = stablehlo.add %865, %870 : tensor<32x32xf64>
    %c_246 = stablehlo.constant dense<-6> : tensor<i32>
    %872 = stablehlo.broadcast_in_dim %c_246, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %873 = stablehlo.compare  EQ, %737, %872,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %874 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %875 = stablehlo.reshape %874 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_247 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %876 = call @_where(%873, %875, %cst_247) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %877 = stablehlo.add %871, %876 : tensor<32x32xf64>
    %cst_248 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %878 = stablehlo.broadcast_in_dim %cst_248, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c_249 = stablehlo.constant dense<0> : tensor<i32>
    %879 = stablehlo.broadcast_in_dim %c_249, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %880 = stablehlo.compare  EQ, %737, %879,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %881 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %882 = stablehlo.reshape %881 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_250 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %883 = call @_where(%880, %882, %cst_250) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %884 = stablehlo.add %878, %883 : tensor<32x32xf64>
    %c_251 = stablehlo.constant dense<-1> : tensor<i32>
    %885 = stablehlo.broadcast_in_dim %c_251, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %886 = stablehlo.compare  EQ, %737, %885,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %887 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %888 = stablehlo.reshape %887 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_252 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %889 = call @_where(%886, %888, %cst_252) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %890 = stablehlo.add %884, %889 : tensor<32x32xf64>
    %c_253 = stablehlo.constant dense<-2> : tensor<i32>
    %891 = stablehlo.broadcast_in_dim %c_253, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %892 = stablehlo.compare  EQ, %737, %891,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %893 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %894 = stablehlo.reshape %893 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_254 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %895 = call @_where(%892, %894, %cst_254) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %896 = stablehlo.add %890, %895 : tensor<32x32xf64>
    %c_255 = stablehlo.constant dense<-3> : tensor<i32>
    %897 = stablehlo.broadcast_in_dim %c_255, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %898 = stablehlo.compare  EQ, %737, %897,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %899 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %900 = stablehlo.reshape %899 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_256 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %901 = call @_where(%898, %900, %cst_256) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %902 = stablehlo.add %896, %901 : tensor<32x32xf64>
    %c_257 = stablehlo.constant dense<-4> : tensor<i32>
    %903 = stablehlo.broadcast_in_dim %c_257, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %904 = stablehlo.compare  EQ, %737, %903,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %905 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %906 = stablehlo.reshape %905 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_258 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %907 = call @_where(%904, %906, %cst_258) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %908 = stablehlo.add %902, %907 : tensor<32x32xf64>
    %c_259 = stablehlo.constant dense<-5> : tensor<i32>
    %909 = stablehlo.broadcast_in_dim %c_259, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %910 = stablehlo.compare  EQ, %737, %909,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %911 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %912 = stablehlo.reshape %911 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_260 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %913 = call @_where(%910, %912, %cst_260) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %914 = stablehlo.add %908, %913 : tensor<32x32xf64>
    %cst_261 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %915 = stablehlo.broadcast_in_dim %cst_261, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c_262 = stablehlo.constant dense<1> : tensor<i32>
    %916 = stablehlo.broadcast_in_dim %c_262, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %917 = stablehlo.compare  EQ, %737, %916,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %918 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %919 = stablehlo.reshape %918 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_263 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %920 = call @_where(%917, %919, %cst_263) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %921 = stablehlo.add %915, %920 : tensor<32x32xf64>
    %c_264 = stablehlo.constant dense<0> : tensor<i32>
    %922 = stablehlo.broadcast_in_dim %c_264, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %923 = stablehlo.compare  EQ, %737, %922,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %924 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %925 = stablehlo.reshape %924 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_265 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %926 = call @_where(%923, %925, %cst_265) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %927 = stablehlo.add %921, %926 : tensor<32x32xf64>
    %c_266 = stablehlo.constant dense<-1> : tensor<i32>
    %928 = stablehlo.broadcast_in_dim %c_266, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %929 = stablehlo.compare  EQ, %737, %928,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %930 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %931 = stablehlo.reshape %930 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_267 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %932 = call @_where(%929, %931, %cst_267) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %933 = stablehlo.add %927, %932 : tensor<32x32xf64>
    %c_268 = stablehlo.constant dense<-2> : tensor<i32>
    %934 = stablehlo.broadcast_in_dim %c_268, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %935 = stablehlo.compare  EQ, %737, %934,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %936 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %937 = stablehlo.reshape %936 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_269 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %938 = call @_where(%935, %937, %cst_269) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %939 = stablehlo.add %933, %938 : tensor<32x32xf64>
    %c_270 = stablehlo.constant dense<-3> : tensor<i32>
    %940 = stablehlo.broadcast_in_dim %c_270, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %941 = stablehlo.compare  EQ, %737, %940,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %942 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %943 = stablehlo.reshape %942 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_271 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %944 = call @_where(%941, %943, %cst_271) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %945 = stablehlo.add %939, %944 : tensor<32x32xf64>
    %c_272 = stablehlo.constant dense<-4> : tensor<i32>
    %946 = stablehlo.broadcast_in_dim %c_272, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %947 = stablehlo.compare  EQ, %737, %946,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %948 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %949 = stablehlo.reshape %948 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_273 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %950 = call @_where(%947, %949, %cst_273) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %951 = stablehlo.add %945, %950 : tensor<32x32xf64>
    %cst_274 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %952 = stablehlo.broadcast_in_dim %cst_274, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c_275 = stablehlo.constant dense<2> : tensor<i32>
    %953 = stablehlo.broadcast_in_dim %c_275, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %954 = stablehlo.compare  EQ, %737, %953,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %955 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %956 = stablehlo.reshape %955 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_276 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %957 = call @_where(%954, %956, %cst_276) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %958 = stablehlo.add %952, %957 : tensor<32x32xf64>
    %c_277 = stablehlo.constant dense<1> : tensor<i32>
    %959 = stablehlo.broadcast_in_dim %c_277, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %960 = stablehlo.compare  EQ, %737, %959,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %961 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %962 = stablehlo.reshape %961 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_278 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %963 = call @_where(%960, %962, %cst_278) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %964 = stablehlo.add %958, %963 : tensor<32x32xf64>
    %c_279 = stablehlo.constant dense<0> : tensor<i32>
    %965 = stablehlo.broadcast_in_dim %c_279, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %966 = stablehlo.compare  EQ, %737, %965,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %967 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %968 = stablehlo.reshape %967 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_280 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %969 = call @_where(%966, %968, %cst_280) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %970 = stablehlo.add %964, %969 : tensor<32x32xf64>
    %c_281 = stablehlo.constant dense<-1> : tensor<i32>
    %971 = stablehlo.broadcast_in_dim %c_281, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %972 = stablehlo.compare  EQ, %737, %971,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %973 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %974 = stablehlo.reshape %973 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_282 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %975 = call @_where(%972, %974, %cst_282) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %976 = stablehlo.add %970, %975 : tensor<32x32xf64>
    %c_283 = stablehlo.constant dense<-2> : tensor<i32>
    %977 = stablehlo.broadcast_in_dim %c_283, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %978 = stablehlo.compare  EQ, %737, %977,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %979 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %980 = stablehlo.reshape %979 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_284 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %981 = call @_where(%978, %980, %cst_284) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %982 = stablehlo.add %976, %981 : tensor<32x32xf64>
    %c_285 = stablehlo.constant dense<-3> : tensor<i32>
    %983 = stablehlo.broadcast_in_dim %c_285, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %984 = stablehlo.compare  EQ, %737, %983,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %985 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %986 = stablehlo.reshape %985 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_286 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %987 = call @_where(%984, %986, %cst_286) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %988 = stablehlo.add %982, %987 : tensor<32x32xf64>
    %cst_287 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %989 = stablehlo.broadcast_in_dim %cst_287, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c_288 = stablehlo.constant dense<3> : tensor<i32>
    %990 = stablehlo.broadcast_in_dim %c_288, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %991 = stablehlo.compare  EQ, %737, %990,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %992 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %993 = stablehlo.reshape %992 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_289 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %994 = call @_where(%991, %993, %cst_289) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %995 = stablehlo.add %989, %994 : tensor<32x32xf64>
    %c_290 = stablehlo.constant dense<2> : tensor<i32>
    %996 = stablehlo.broadcast_in_dim %c_290, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %997 = stablehlo.compare  EQ, %737, %996,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %998 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %999 = stablehlo.reshape %998 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_291 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1000 = call @_where(%997, %999, %cst_291) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1001 = stablehlo.add %995, %1000 : tensor<32x32xf64>
    %c_292 = stablehlo.constant dense<1> : tensor<i32>
    %1002 = stablehlo.broadcast_in_dim %c_292, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1003 = stablehlo.compare  EQ, %737, %1002,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1004 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1005 = stablehlo.reshape %1004 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_293 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1006 = call @_where(%1003, %1005, %cst_293) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1007 = stablehlo.add %1001, %1006 : tensor<32x32xf64>
    %c_294 = stablehlo.constant dense<0> : tensor<i32>
    %1008 = stablehlo.broadcast_in_dim %c_294, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1009 = stablehlo.compare  EQ, %737, %1008,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1010 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1011 = stablehlo.reshape %1010 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_295 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1012 = call @_where(%1009, %1011, %cst_295) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1013 = stablehlo.add %1007, %1012 : tensor<32x32xf64>
    %c_296 = stablehlo.constant dense<-1> : tensor<i32>
    %1014 = stablehlo.broadcast_in_dim %c_296, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1015 = stablehlo.compare  EQ, %737, %1014,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1016 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1017 = stablehlo.reshape %1016 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_297 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1018 = call @_where(%1015, %1017, %cst_297) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1019 = stablehlo.add %1013, %1018 : tensor<32x32xf64>
    %c_298 = stablehlo.constant dense<-2> : tensor<i32>
    %1020 = stablehlo.broadcast_in_dim %c_298, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1021 = stablehlo.compare  EQ, %737, %1020,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1022 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1023 = stablehlo.reshape %1022 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_299 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1024 = call @_where(%1021, %1023, %cst_299) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1025 = stablehlo.add %1019, %1024 : tensor<32x32xf64>
    %cst_300 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1026 = stablehlo.broadcast_in_dim %cst_300, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c_301 = stablehlo.constant dense<4> : tensor<i32>
    %1027 = stablehlo.broadcast_in_dim %c_301, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1028 = stablehlo.compare  EQ, %737, %1027,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1029 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1030 = stablehlo.reshape %1029 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_302 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1031 = call @_where(%1028, %1030, %cst_302) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1032 = stablehlo.add %1026, %1031 : tensor<32x32xf64>
    %c_303 = stablehlo.constant dense<3> : tensor<i32>
    %1033 = stablehlo.broadcast_in_dim %c_303, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1034 = stablehlo.compare  EQ, %737, %1033,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1035 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1036 = stablehlo.reshape %1035 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_304 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1037 = call @_where(%1034, %1036, %cst_304) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1038 = stablehlo.add %1032, %1037 : tensor<32x32xf64>
    %c_305 = stablehlo.constant dense<2> : tensor<i32>
    %1039 = stablehlo.broadcast_in_dim %c_305, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1040 = stablehlo.compare  EQ, %737, %1039,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1041 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1042 = stablehlo.reshape %1041 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_306 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1043 = call @_where(%1040, %1042, %cst_306) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1044 = stablehlo.add %1038, %1043 : tensor<32x32xf64>
    %c_307 = stablehlo.constant dense<1> : tensor<i32>
    %1045 = stablehlo.broadcast_in_dim %c_307, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1046 = stablehlo.compare  EQ, %737, %1045,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1047 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1048 = stablehlo.reshape %1047 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_308 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1049 = call @_where(%1046, %1048, %cst_308) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1050 = stablehlo.add %1044, %1049 : tensor<32x32xf64>
    %c_309 = stablehlo.constant dense<0> : tensor<i32>
    %1051 = stablehlo.broadcast_in_dim %c_309, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1052 = stablehlo.compare  EQ, %737, %1051,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1053 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1054 = stablehlo.reshape %1053 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_310 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1055 = call @_where(%1052, %1054, %cst_310) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1056 = stablehlo.add %1050, %1055 : tensor<32x32xf64>
    %c_311 = stablehlo.constant dense<-1> : tensor<i32>
    %1057 = stablehlo.broadcast_in_dim %c_311, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1058 = stablehlo.compare  EQ, %737, %1057,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1059 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1060 = stablehlo.reshape %1059 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_312 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1061 = call @_where(%1058, %1060, %cst_312) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1062 = stablehlo.add %1056, %1061 : tensor<32x32xf64>
    %cst_313 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1063 = stablehlo.broadcast_in_dim %cst_313, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %c_314 = stablehlo.constant dense<5> : tensor<i32>
    %1064 = stablehlo.broadcast_in_dim %c_314, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1065 = stablehlo.compare  EQ, %737, %1064,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1066 = stablehlo.slice %840 [0:1, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1067 = stablehlo.reshape %1066 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_315 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1068 = call @_where(%1065, %1067, %cst_315) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1069 = stablehlo.add %1063, %1068 : tensor<32x32xf64>
    %c_316 = stablehlo.constant dense<4> : tensor<i32>
    %1070 = stablehlo.broadcast_in_dim %c_316, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1071 = stablehlo.compare  EQ, %737, %1070,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1072 = stablehlo.slice %840 [1:2, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1073 = stablehlo.reshape %1072 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_317 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1074 = call @_where(%1071, %1073, %cst_317) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1075 = stablehlo.add %1069, %1074 : tensor<32x32xf64>
    %c_318 = stablehlo.constant dense<3> : tensor<i32>
    %1076 = stablehlo.broadcast_in_dim %c_318, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1077 = stablehlo.compare  EQ, %737, %1076,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1078 = stablehlo.slice %840 [2:3, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1079 = stablehlo.reshape %1078 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_319 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1080 = call @_where(%1077, %1079, %cst_319) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1081 = stablehlo.add %1075, %1080 : tensor<32x32xf64>
    %c_320 = stablehlo.constant dense<2> : tensor<i32>
    %1082 = stablehlo.broadcast_in_dim %c_320, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1083 = stablehlo.compare  EQ, %737, %1082,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1084 = stablehlo.slice %840 [3:4, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1085 = stablehlo.reshape %1084 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_321 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1086 = call @_where(%1083, %1085, %cst_321) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1087 = stablehlo.add %1081, %1086 : tensor<32x32xf64>
    %c_322 = stablehlo.constant dense<1> : tensor<i32>
    %1088 = stablehlo.broadcast_in_dim %c_322, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1089 = stablehlo.compare  EQ, %737, %1088,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1090 = stablehlo.slice %840 [4:5, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1091 = stablehlo.reshape %1090 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_323 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1092 = call @_where(%1089, %1091, %cst_323) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1093 = stablehlo.add %1087, %1092 : tensor<32x32xf64>
    %c_324 = stablehlo.constant dense<0> : tensor<i32>
    %1094 = stablehlo.broadcast_in_dim %c_324, dims = [] : (tensor<i32>) -> tensor<32x32xi32>
    %1095 = stablehlo.compare  EQ, %737, %1094,  SIGNED : (tensor<32x32xi32>, tensor<32x32xi32>) -> tensor<32x32xi1>
    %1096 = stablehlo.slice %840 [5:6, 0:32, 0:32] : (tensor<6x32x32xf64>) -> tensor<1x32x32xf64>
    %1097 = stablehlo.reshape %1096 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %cst_325 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1098 = call @_where(%1095, %1097, %cst_325) : (tensor<32x32xi1>, tensor<32x32xf64>, tensor<f64>) -> tensor<32x32xf64>
    %1099 = stablehlo.add %1093, %1098 : tensor<32x32xf64>
    %1100 = stablehlo.broadcast_in_dim %877, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %1101 = stablehlo.broadcast_in_dim %914, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %1102 = stablehlo.broadcast_in_dim %951, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %1103 = stablehlo.broadcast_in_dim %988, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %1104 = stablehlo.broadcast_in_dim %1025, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %1105 = stablehlo.broadcast_in_dim %1062, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %1106 = stablehlo.broadcast_in_dim %1099, dims = [1, 2] : (tensor<32x32xf64>) -> tensor<1x32x32xf64>
    %1107 = stablehlo.concatenate %1100, %1101, %1102, %1103, %1104, %1105, %1106, dim = 0 : (tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>, tensor<1x32x32xf64>) -> tensor<7x32x32xf64>
    %c_326 = stablehlo.constant dense<0> : tensor<i64>
    %1108 = call @_pad_129(%730, %c_326) : (tensor<32x32x32x32xf64>, tensor<i64>) -> tensor<32x32x32x38xf64>
    %cst_327 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1109 = stablehlo.broadcast_in_dim %cst_327, dims = [] : (tensor<f64>) -> tensor<32x32x32x32xf64>
    %1110 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 6:38] : (tensor<32x32x32x38xf64>) -> tensor<32x32x32x32xf64>
    %1111 = stablehlo.slice %1107 [0:1, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %1112 = stablehlo.reshape %1111 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %1113 = stablehlo.broadcast_in_dim %1112, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %1114 = stablehlo.broadcast_in_dim %1113, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %1115 = stablehlo.multiply %1114, %1110 : tensor<32x32x32x32xf64>
    %1116 = stablehlo.add %1109, %1115 : tensor<32x32x32x32xf64>
    %1117 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 5:37] : (tensor<32x32x32x38xf64>) -> tensor<32x32x32x32xf64>
    %1118 = stablehlo.slice %1107 [1:2, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %1119 = stablehlo.reshape %1118 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %1120 = stablehlo.broadcast_in_dim %1119, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %1121 = stablehlo.broadcast_in_dim %1120, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %1122 = stablehlo.multiply %1121, %1117 : tensor<32x32x32x32xf64>
    %1123 = stablehlo.add %1116, %1122 : tensor<32x32x32x32xf64>
    %1124 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 4:36] : (tensor<32x32x32x38xf64>) -> tensor<32x32x32x32xf64>
    %1125 = stablehlo.slice %1107 [2:3, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %1126 = stablehlo.reshape %1125 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %1127 = stablehlo.broadcast_in_dim %1126, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %1128 = stablehlo.broadcast_in_dim %1127, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %1129 = stablehlo.multiply %1128, %1124 : tensor<32x32x32x32xf64>
    %1130 = stablehlo.add %1123, %1129 : tensor<32x32x32x32xf64>
    %1131 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 3:35] : (tensor<32x32x32x38xf64>) -> tensor<32x32x32x32xf64>
    %1132 = stablehlo.slice %1107 [3:4, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %1133 = stablehlo.reshape %1132 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %1134 = stablehlo.broadcast_in_dim %1133, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %1135 = stablehlo.broadcast_in_dim %1134, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %1136 = stablehlo.multiply %1135, %1131 : tensor<32x32x32x32xf64>
    %1137 = stablehlo.add %1130, %1136 : tensor<32x32x32x32xf64>
    %1138 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 2:34] : (tensor<32x32x32x38xf64>) -> tensor<32x32x32x32xf64>
    %1139 = stablehlo.slice %1107 [4:5, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %1140 = stablehlo.reshape %1139 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %1141 = stablehlo.broadcast_in_dim %1140, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %1142 = stablehlo.broadcast_in_dim %1141, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %1143 = stablehlo.multiply %1142, %1138 : tensor<32x32x32x32xf64>
    %1144 = stablehlo.add %1137, %1143 : tensor<32x32x32x32xf64>
    %1145 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 1:33] : (tensor<32x32x32x38xf64>) -> tensor<32x32x32x32xf64>
    %1146 = stablehlo.slice %1107 [5:6, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %1147 = stablehlo.reshape %1146 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %1148 = stablehlo.broadcast_in_dim %1147, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %1149 = stablehlo.broadcast_in_dim %1148, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %1150 = stablehlo.multiply %1149, %1145 : tensor<32x32x32x32xf64>
    %1151 = stablehlo.add %1144, %1150 : tensor<32x32x32x32xf64>
    %1152 = stablehlo.slice %1108 [0:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x38xf64>) -> tensor<32x32x32x32xf64>
    %1153 = stablehlo.slice %1107 [6:7, 0:32, 0:32] : (tensor<7x32x32xf64>) -> tensor<1x32x32xf64>
    %1154 = stablehlo.reshape %1153 : (tensor<1x32x32xf64>) -> tensor<32x32xf64>
    %1155 = stablehlo.broadcast_in_dim %1154, dims = [0, 1] : (tensor<32x32xf64>) -> tensor<32x32x1x1xf64>
    %1156 = stablehlo.broadcast_in_dim %1155, dims = [0, 1, 2, 3] : (tensor<32x32x1x1xf64>) -> tensor<32x32x32x32xf64>
    %1157 = stablehlo.multiply %1156, %1152 : tensor<32x32x32x32xf64>
    %1158 = stablehlo.add %1151, %1157 : tensor<32x32x32x32xf64>
    %1159 = stablehlo.slice %1158 [0:32, 0:32, 0:32, 0:16] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x16xf64>
    %1160 = call @_roll_static_45(%1159) : (tensor<32x32x32x16xf64>) -> tensor<32x32x32x16xf64>
    %1161 = stablehlo.slice %1158 [0:32, 0:32, 0:32, 16:32] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x16xf64>
    %1162 = call @_roll_static_50(%1161) : (tensor<32x32x32x16xf64>) -> tensor<32x32x32x16xf64>
    %1163 = stablehlo.concatenate %1160, %1162, dim = 3 : (tensor<32x32x32x16xf64>, tensor<32x32x32x16xf64>) -> tensor<32x32x32x32xf64>
    %cst_328 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1164 = stablehlo.broadcast_in_dim %cst_328, dims = [] : (tensor<f64>) -> tensor<32x32x32x32xf64>
    %1165 = call @_roll_static_55(%1163) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1166 = stablehlo.slice %205 [0:1, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %1167 = stablehlo.reshape %1166 : (tensor<1x32xf64>) -> tensor<32xf64>
    %1168 = stablehlo.reshape %1167 : (tensor<32xf64>) -> tensor<1x1x1x32xf64>
    %1169 = stablehlo.broadcast_in_dim %1168, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf64>) -> tensor<32x32x32x32xf64>
    %1170 = stablehlo.multiply %1165, %1169 : tensor<32x32x32x32xf64>
    %1171 = stablehlo.add %1164, %1170 : tensor<32x32x32x32xf64>
    %1172 = call @_roll_static_61(%1163) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1173 = stablehlo.slice %205 [1:2, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %1174 = stablehlo.reshape %1173 : (tensor<1x32xf64>) -> tensor<32xf64>
    %1175 = stablehlo.reshape %1174 : (tensor<32xf64>) -> tensor<1x1x1x32xf64>
    %1176 = stablehlo.broadcast_in_dim %1175, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf64>) -> tensor<32x32x32x32xf64>
    %1177 = stablehlo.multiply %1172, %1176 : tensor<32x32x32x32xf64>
    %1178 = stablehlo.add %1171, %1177 : tensor<32x32x32x32xf64>
    %1179 = call @_roll_static_65(%1163) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1180 = stablehlo.slice %205 [2:3, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %1181 = stablehlo.reshape %1180 : (tensor<1x32xf64>) -> tensor<32xf64>
    %1182 = stablehlo.reshape %1181 : (tensor<32xf64>) -> tensor<1x1x1x32xf64>
    %1183 = stablehlo.broadcast_in_dim %1182, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf64>) -> tensor<32x32x32x32xf64>
    %1184 = stablehlo.multiply %1179, %1183 : tensor<32x32x32x32xf64>
    %1185 = stablehlo.add %1178, %1184 : tensor<32x32x32x32xf64>
    %1186 = call @_roll_static_68(%1163) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1187 = stablehlo.slice %205 [3:4, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %1188 = stablehlo.reshape %1187 : (tensor<1x32xf64>) -> tensor<32xf64>
    %1189 = stablehlo.reshape %1188 : (tensor<32xf64>) -> tensor<1x1x1x32xf64>
    %1190 = stablehlo.broadcast_in_dim %1189, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf64>) -> tensor<32x32x32x32xf64>
    %1191 = stablehlo.multiply %1186, %1190 : tensor<32x32x32x32xf64>
    %1192 = stablehlo.add %1185, %1191 : tensor<32x32x32x32xf64>
    %1193 = call @_roll_static_72(%1163) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1194 = stablehlo.slice %205 [4:5, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %1195 = stablehlo.reshape %1194 : (tensor<1x32xf64>) -> tensor<32xf64>
    %1196 = stablehlo.reshape %1195 : (tensor<32xf64>) -> tensor<1x1x1x32xf64>
    %1197 = stablehlo.broadcast_in_dim %1196, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf64>) -> tensor<32x32x32x32xf64>
    %1198 = stablehlo.multiply %1193, %1197 : tensor<32x32x32x32xf64>
    %1199 = stablehlo.add %1192, %1198 : tensor<32x32x32x32xf64>
    %1200 = call @_roll_static_76(%1163) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1201 = stablehlo.slice %205 [5:6, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %1202 = stablehlo.reshape %1201 : (tensor<1x32xf64>) -> tensor<32xf64>
    %1203 = stablehlo.reshape %1202 : (tensor<32xf64>) -> tensor<1x1x1x32xf64>
    %1204 = stablehlo.broadcast_in_dim %1203, dims = [0, 1, 2, 3] : (tensor<1x1x1x32xf64>) -> tensor<32x32x32x32xf64>
    %1205 = stablehlo.multiply %1200, %1204 : tensor<32x32x32x32xf64>
    %1206 = stablehlo.add %1199, %1205 : tensor<32x32x32x32xf64>
    %1207 = stablehlo.slice %1206 [0:32, 0:32, 0:16, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x32x16x32xf64>
    %1208 = call @_roll_static(%1207) : (tensor<32x32x16x32xf64>) -> tensor<32x32x16x32xf64>
    %1209 = stablehlo.slice %1206 [0:32, 0:32, 16:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x32x16x32xf64>
    %1210 = call @_roll_static_6(%1209) : (tensor<32x32x16x32xf64>) -> tensor<32x32x16x32xf64>
    %1211 = stablehlo.concatenate %1208, %1210, dim = 2 : (tensor<32x32x16x32xf64>, tensor<32x32x16x32xf64>) -> tensor<32x32x32x32xf64>
    %cst_329 = stablehlo.constant dense<0.000000e+00> : tensor<f64>
    %1212 = stablehlo.broadcast_in_dim %cst_329, dims = [] : (tensor<f64>) -> tensor<32x32x32x32xf64>
    %1213 = call @_roll_static_12(%1211) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1214 = stablehlo.slice %102 [0:1, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %1215 = stablehlo.reshape %1214 : (tensor<1x32xf64>) -> tensor<32xf64>
    %1216 = stablehlo.reshape %1215 : (tensor<32xf64>) -> tensor<1x1x32x1xf64>
    %1217 = stablehlo.broadcast_in_dim %1216, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf64>) -> tensor<32x32x32x32xf64>
    %1218 = stablehlo.multiply %1213, %1217 : tensor<32x32x32x32xf64>
    %1219 = stablehlo.add %1212, %1218 : tensor<32x32x32x32xf64>
    %1220 = call @_roll_static_19(%1211) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1221 = stablehlo.slice %102 [1:2, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %1222 = stablehlo.reshape %1221 : (tensor<1x32xf64>) -> tensor<32xf64>
    %1223 = stablehlo.reshape %1222 : (tensor<32xf64>) -> tensor<1x1x32x1xf64>
    %1224 = stablehlo.broadcast_in_dim %1223, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf64>) -> tensor<32x32x32x32xf64>
    %1225 = stablehlo.multiply %1220, %1224 : tensor<32x32x32x32xf64>
    %1226 = stablehlo.add %1219, %1225 : tensor<32x32x32x32xf64>
    %1227 = call @_roll_static_24(%1211) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1228 = stablehlo.slice %102 [2:3, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %1229 = stablehlo.reshape %1228 : (tensor<1x32xf64>) -> tensor<32xf64>
    %1230 = stablehlo.reshape %1229 : (tensor<32xf64>) -> tensor<1x1x32x1xf64>
    %1231 = stablehlo.broadcast_in_dim %1230, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf64>) -> tensor<32x32x32x32xf64>
    %1232 = stablehlo.multiply %1227, %1231 : tensor<32x32x32x32xf64>
    %1233 = stablehlo.add %1226, %1232 : tensor<32x32x32x32xf64>
    %1234 = call @_roll_static_29(%1211) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1235 = stablehlo.slice %102 [3:4, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %1236 = stablehlo.reshape %1235 : (tensor<1x32xf64>) -> tensor<32xf64>
    %1237 = stablehlo.reshape %1236 : (tensor<32xf64>) -> tensor<1x1x32x1xf64>
    %1238 = stablehlo.broadcast_in_dim %1237, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf64>) -> tensor<32x32x32x32xf64>
    %1239 = stablehlo.multiply %1234, %1238 : tensor<32x32x32x32xf64>
    %1240 = stablehlo.add %1233, %1239 : tensor<32x32x32x32xf64>
    %1241 = call @_roll_static_34(%1211) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1242 = stablehlo.slice %102 [4:5, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %1243 = stablehlo.reshape %1242 : (tensor<1x32xf64>) -> tensor<32xf64>
    %1244 = stablehlo.reshape %1243 : (tensor<32xf64>) -> tensor<1x1x32x1xf64>
    %1245 = stablehlo.broadcast_in_dim %1244, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf64>) -> tensor<32x32x32x32xf64>
    %1246 = stablehlo.multiply %1241, %1245 : tensor<32x32x32x32xf64>
    %1247 = stablehlo.add %1240, %1246 : tensor<32x32x32x32xf64>
    %1248 = call @_roll_static_39(%1211) : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1249 = stablehlo.slice %102 [5:6, 0:32] : (tensor<6x32xf64>) -> tensor<1x32xf64>
    %1250 = stablehlo.reshape %1249 : (tensor<1x32xf64>) -> tensor<32xf64>
    %1251 = stablehlo.reshape %1250 : (tensor<32xf64>) -> tensor<1x1x32x1xf64>
    %1252 = stablehlo.broadcast_in_dim %1251, dims = [0, 1, 2, 3] : (tensor<1x1x32x1xf64>) -> tensor<32x32x32x32xf64>
    %1253 = stablehlo.multiply %1248, %1252 : tensor<32x32x32x32xf64>
    %1254 = stablehlo.add %1247, %1253 : tensor<32x32x32x32xf64>
    return %1254, %302#2, %302#3 : tensor<32x32x32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>
  }
  func.func private @_roll_static(%arg0: tensor<32x32x16x32xf64>) -> tensor<32x32x16x32xf64> {
    %0 = stablehlo.slice %arg0 [1:32, 0:32, 0:16, 0:32] : (tensor<32x32x16x32xf64>) -> tensor<31x32x16x32xf64>
    %1 = stablehlo.slice %arg0 [0:1, 0:32, 0:16, 0:32] : (tensor<32x32x16x32xf64>) -> tensor<1x32x16x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<31x32x16x32xf64>, tensor<1x32x16x32xf64>) -> tensor<32x32x16x32xf64>
    return %2 : tensor<32x32x16x32xf64>
  }
  func.func private @_roll_static_6(%arg0: tensor<32x32x16x32xf64>) -> tensor<32x32x16x32xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 0:32, 0:16, 0:32] : (tensor<32x32x16x32xf64>) -> tensor<32x32x16x32xf64>
    %1 = stablehlo.slice %arg0 [0:0, 0:32, 0:16, 0:32] : (tensor<32x32x16x32xf64>) -> tensor<0x32x16x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<32x32x16x32xf64>, tensor<0x32x16x32xf64>) -> tensor<32x32x16x32xf64>
    return %2 : tensor<32x32x16x32xf64>
  }
  func.func private @_roll_static_12(%arg0: tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [2:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<30x32x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:2, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<2x32x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<30x32x32x32xf64>, tensor<2x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %2 : tensor<32x32x32x32xf64>
  }
  func.func private @_roll_static_19(%arg0: tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [1:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<31x32x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:1, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<1x32x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<31x32x32x32xf64>, tensor<1x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %2 : tensor<32x32x32x32xf64>
  }
  func.func private @_roll_static_24(%arg0: tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:0, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<0x32x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<32x32x32x32xf64>, tensor<0x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %2 : tensor<32x32x32x32xf64>
  }
  func.func private @_roll_static_29(%arg0: tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [31:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<1x32x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:31, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<31x32x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<1x32x32x32xf64>, tensor<31x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %2 : tensor<32x32x32x32xf64>
  }
  func.func private @_roll_static_34(%arg0: tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [30:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<2x32x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:30, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<30x32x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<2x32x32x32xf64>, tensor<30x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %2 : tensor<32x32x32x32xf64>
  }
  func.func private @_roll_static_39(%arg0: tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [29:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<3x32x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:29, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<29x32x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 0 : (tensor<3x32x32x32xf64>, tensor<29x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %2 : tensor<32x32x32x32xf64>
  }
  func.func private @_roll_static_45(%arg0: tensor<32x32x32x16xf64>) -> tensor<32x32x32x16xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 1:32, 0:32, 0:16] : (tensor<32x32x32x16xf64>) -> tensor<32x31x32x16xf64>
    %1 = stablehlo.slice %arg0 [0:32, 0:1, 0:32, 0:16] : (tensor<32x32x32x16xf64>) -> tensor<32x1x32x16xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x31x32x16xf64>, tensor<32x1x32x16xf64>) -> tensor<32x32x32x16xf64>
    return %2 : tensor<32x32x32x16xf64>
  }
  func.func private @_roll_static_50(%arg0: tensor<32x32x32x16xf64>) -> tensor<32x32x32x16xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 0:32, 0:32, 0:16] : (tensor<32x32x32x16xf64>) -> tensor<32x32x32x16xf64>
    %1 = stablehlo.slice %arg0 [0:32, 0:0, 0:32, 0:16] : (tensor<32x32x32x16xf64>) -> tensor<32x0x32x16xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x32x32x16xf64>, tensor<32x0x32x16xf64>) -> tensor<32x32x32x16xf64>
    return %2 : tensor<32x32x32x16xf64>
  }
  func.func private @_roll_static_55(%arg0: tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 2:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x30x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:32, 0:2, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x2x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x30x32x32xf64>, tensor<32x2x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %2 : tensor<32x32x32x32xf64>
  }
  func.func private @_roll_static_61(%arg0: tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 1:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x31x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:32, 0:1, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x1x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x31x32x32xf64>, tensor<32x1x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %2 : tensor<32x32x32x32xf64>
  }
  func.func private @_roll_static_65(%arg0: tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 0:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:32, 0:0, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x0x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x32x32x32xf64>, tensor<32x0x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %2 : tensor<32x32x32x32xf64>
  }
  func.func private @_roll_static_68(%arg0: tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 31:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x1x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:32, 0:31, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x31x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x1x32x32xf64>, tensor<32x31x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %2 : tensor<32x32x32x32xf64>
  }
  func.func private @_roll_static_72(%arg0: tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 30:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x2x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:32, 0:30, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x30x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x2x32x32xf64>, tensor<32x30x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %2 : tensor<32x32x32x32xf64>
  }
  func.func private @_roll_static_76(%arg0: tensor<32x32x32x32xf64>) -> tensor<32x32x32x32xf64> {
    %0 = stablehlo.slice %arg0 [0:32, 29:32, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x3x32x32xf64>
    %1 = stablehlo.slice %arg0 [0:32, 0:29, 0:32, 0:32] : (tensor<32x32x32x32xf64>) -> tensor<32x29x32x32xf64>
    %2 = stablehlo.concatenate %0, %1, dim = 1 : (tensor<32x3x32x32xf64>, tensor<32x29x32x32xf64>) -> tensor<32x32x32x32xf64>
    return %2 : tensor<32x32x32x32xf64>
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
    %12 = call @fft_85(%11) : (tensor<32x17xcomplex<f64>>) -> tensor<32x32xf64>
    %13 = stablehlo.convert %arg1 : (tensor<32x1xf64>) -> tensor<32x1xcomplex<f64>>
    %cst_1 = stablehlo.constant dense<(-0.000000e+00,-1.000000e+00)> : tensor<complex<f64>>
    %14 = stablehlo.broadcast_in_dim %cst_1, dims = [] : (tensor<complex<f64>>) -> tensor<32x1xcomplex<f64>>
    %15 = stablehlo.multiply %14, %13 : tensor<32x1xcomplex<f64>>
    %16 = stablehlo.broadcast_in_dim %15, dims = [0, 1] : (tensor<32x1xcomplex<f64>>) -> tensor<32x17xcomplex<f64>>
    %17 = stablehlo.multiply %16, %11 : tensor<32x17xcomplex<f64>>
    %18 = stablehlo.convert %arg2 : (tensor<1x17xf64>) -> tensor<1x17xcomplex<f64>>
    %cst_2 = stablehlo.constant dense<(-0.000000e+00,-1.000000e+00)> : tensor<complex<f64>>
    %19 = stablehlo.broadcast_in_dim %cst_2, dims = [] : (tensor<complex<f64>>) -> tensor<1x17xcomplex<f64>>
    %20 = stablehlo.multiply %19, %18 : tensor<1x17xcomplex<f64>>
    %21 = stablehlo.broadcast_in_dim %20, dims = [0, 1] : (tensor<1x17xcomplex<f64>>) -> tensor<32x17xcomplex<f64>>
    %22 = stablehlo.multiply %21, %11 : tensor<32x17xcomplex<f64>>
    %23 = call @fft_85(%17) : (tensor<32x17xcomplex<f64>>) -> tensor<32x32xf64>
    %24 = call @fft_85(%22) : (tensor<32x17xcomplex<f64>>) -> tensor<32x32xf64>
    return %23, %24, %8, %12 : tensor<32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>, tensor<32x32xf64>
  }
  func.func private @fft(%arg0: tensor<32x32xf64>) -> tensor<32x17xcomplex<f64>> {
    %0 = stablehlo.fft %arg0, type =  RFFT, length = [32, 32] : (tensor<32x32xf64>) -> tensor<32x17xcomplex<f64>>
    return %0 : tensor<32x17xcomplex<f64>>
  }
  func.func private @fft_85(%arg0: tensor<32x17xcomplex<f64>>) -> tensor<32x32xf64> {
    %0 = stablehlo.fft %arg0, type =  IRFFT, length = [32, 32] : (tensor<32x17xcomplex<f64>>) -> tensor<32x32xf64>
    return %0 : tensor<32x32xf64>
  }
  func.func private @_where(%arg0: tensor<32x32xi1>, %arg1: tensor<32x32xf64>, %arg2: tensor<f64>) -> tensor<32x32xf64> {
    %0 = stablehlo.convert %arg2 : tensor<f64>
    %1 = stablehlo.broadcast_in_dim %0, dims = [] : (tensor<f64>) -> tensor<32x32xf64>
    %2 = stablehlo.select %arg0, %arg1, %1 : tensor<32x32xi1>, tensor<32x32xf64>
    return %2 : tensor<32x32xf64>
  }
  func.func private @_pad(%arg0: tensor<32x32x32x32xf64>, %arg1: tensor<i64>) -> tensor<32x32x38x32xf64> {
    %0 = stablehlo.convert %arg1 : (tensor<i64>) -> tensor<f64>
    %1 = stablehlo.pad %arg0, %0, low = [0, 0, 3, 0], high = [0, 0, 3, 0], interior = [0, 0, 0, 0] : (tensor<32x32x32x32xf64>, tensor<f64>) -> tensor<32x32x38x32xf64>
    return %1 : tensor<32x32x38x32xf64>
  }
  func.func private @_pad_129(%arg0: tensor<32x32x32x32xf64>, %arg1: tensor<i64>) -> tensor<32x32x32x38xf64> {
    %0 = stablehlo.convert %arg1 : (tensor<i64>) -> tensor<f64>
    %1 = stablehlo.pad %arg0, %0, low = [0, 0, 0, 3], high = [0, 0, 0, 3], interior = [0, 0, 0, 0] : (tensor<32x32x32x32xf64>, tensor<f64>) -> tensor<32x32x32x38xf64>
    return %1 : tensor<32x32x32x38xf64>
  }
}
