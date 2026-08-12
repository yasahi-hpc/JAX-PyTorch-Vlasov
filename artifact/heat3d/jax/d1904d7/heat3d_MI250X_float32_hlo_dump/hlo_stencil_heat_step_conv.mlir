HloModule jit_heat_step_conv, entry_computation_layout={(f32[32,32,32]{2,1,0}, f32[])->f32[32,32,32]{2,1,0}}

heat_step_conv.1 {
  Arg_0.1 = f32[32,32,32]{2,1,0} parameter(0)
  Arg_1.1 = f32[] parameter(1)
  mul.2 = f32[32,32,32]{2,1,0} broadcast(Arg_1.1), dimensions={}
  transpose.4 = f32[32,32,32]{1,0,2} transpose(Arg_0.1), dimensions={1,2,0}
  reshape.6 = f32[1024,1,32]{2,1,0} reshape(transpose.4)
  slice.6 = f32[1024,1,1]{2,1,0} slice(reshape.6), slice={[0:1024], [0:1], [31:32]}
  slice.7 = f32[1024,1,1]{2,1,0} slice(reshape.6), slice={[0:1024], [0:1], [0:1]}
  concatenate.3 = f32[1024,1,34]{2,1,0} concatenate(slice.6, reshape.6, slice.7), dimensions={2}
  Arg_2.1 = f32[1,1,3]{2,1,0} parameter(2)
  conv_general_dilated.3 = f32[1024,1,32]{2,1,0} convolution(concatenate.3, Arg_2.1), window={size=3}, dim_labels=bf0_oi0->bf0
  reshape.7 = f32[32,32,32]{2,1,0} reshape(conv_general_dilated.3)
  transpose.5 = f32[32,32,32]{0,2,1} transpose(reshape.7), dimensions={2,0,1}
  transpose.6 = f32[32,32,32]{1,2,0} transpose(Arg_0.1), dimensions={0,2,1}
  reshape.8 = f32[1024,1,32]{2,1,0} reshape(transpose.6)
  slice.8 = f32[1024,1,1]{2,1,0} slice(reshape.8), slice={[0:1024], [0:1], [31:32]}
  slice.9 = f32[1024,1,1]{2,1,0} slice(reshape.8), slice={[0:1024], [0:1], [0:1]}
  concatenate.4 = f32[1024,1,34]{2,1,0} concatenate(slice.8, reshape.8, slice.9), dimensions={2}
  conv_general_dilated.4 = f32[1024,1,32]{2,1,0} convolution(concatenate.4, Arg_2.1), window={size=3}, dim_labels=bf0_oi0->bf0
  reshape.9 = f32[32,32,32]{2,1,0} reshape(conv_general_dilated.4)
  transpose.7 = f32[32,32,32]{1,2,0} transpose(reshape.9), dimensions={0,2,1}
  add.3 = f32[32,32,32]{0,2,1} add(transpose.5, transpose.7)
  reshape.10 = f32[1024,1,32]{2,1,0} reshape(Arg_0.1)
  slice.10 = f32[1024,1,1]{2,1,0} slice(reshape.10), slice={[0:1024], [0:1], [31:32]}
  slice.11 = f32[1024,1,1]{2,1,0} slice(reshape.10), slice={[0:1024], [0:1], [0:1]}
  concatenate.5 = f32[1024,1,34]{2,1,0} concatenate(slice.10, reshape.10, slice.11), dimensions={2}
  conv_general_dilated.5 = f32[1024,1,32]{2,1,0} convolution(concatenate.5, Arg_2.1), window={size=3}, dim_labels=bf0_oi0->bf0
  reshape.11 = f32[32,32,32]{2,1,0} reshape(conv_general_dilated.5)
  add.4 = f32[32,32,32]{0,2,1} add(add.3, reshape.11)
  mul.3 = f32[32,32,32]{2,1,0} multiply(mul.2, add.4)
  ROOT add.5 = f32[32,32,32]{2,1,0} add(Arg_0.1, mul.3)
}

ENTRY main.2 {
  u.1 = f32[32,32,32]{2,1,0} parameter(0)
  coeff.1 = f32[] parameter(1)
  constant.1 = f32[1,1,3]{2,1,0} constant({ { { 1, -2, 1 } } })
  ROOT jit_heat_step_conv_.1 = f32[32,32,32]{2,1,0} call(u.1, coeff.1, constant.1), to_apply=heat_step_conv.1
}

