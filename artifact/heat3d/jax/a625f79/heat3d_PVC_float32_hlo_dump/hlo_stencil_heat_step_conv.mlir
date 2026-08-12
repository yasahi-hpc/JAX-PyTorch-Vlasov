HloModule jit__unnamed_wrapped_function_, entry_computation_layout={(f32[32,32,32]{2,1,0}, f32[])->f32[32,32,32]{2,1,0}}

heat_step_conv.4 {
  Arg_0.5 = f32[32,32,32]{2,1,0} parameter(0)
  Arg_1.6 = f32[] parameter(1)
  broadcast.32 = f32[32,32,32]{2,1,0} broadcast(Arg_1.6), dimensions={}
  transpose.8 = f32[32,32,32]{1,0,2} transpose(Arg_0.5), dimensions={1,2,0}
  reshape.9 = f32[1024,1,32]{2,1,0} reshape(transpose.8)
  slice.10 = f32[1024,1,1]{2,1,0} slice(reshape.9), slice={[0:1024], [0:1], [31:32]}
  slice.11 = f32[1024,1,1]{2,1,0} slice(reshape.9), slice={[0:1024], [0:1], [0:1]}
  concatenate.12 = f32[1024,1,34]{2,1,0} concatenate(slice.10, reshape.9, slice.11), dimensions={2}
  Arg_2.7 = f32[1,1,3]{2,1,0} parameter(2)
  convolution.13 = f32[1024,1,32]{2,1,0} convolution(concatenate.12, Arg_2.7), window={size=3}, dim_labels=bf0_oi0->bf0
  reshape.14 = f32[32,32,32]{2,1,0} reshape(convolution.13)
  transpose.15 = f32[32,32,32]{0,2,1} transpose(reshape.14), dimensions={2,0,1}
  transpose.16 = f32[32,32,32]{1,2,0} transpose(Arg_0.5), dimensions={0,2,1}
  reshape.17 = f32[1024,1,32]{2,1,0} reshape(transpose.16)
  slice.18 = f32[1024,1,1]{2,1,0} slice(reshape.17), slice={[0:1024], [0:1], [31:32]}
  slice.19 = f32[1024,1,1]{2,1,0} slice(reshape.17), slice={[0:1024], [0:1], [0:1]}
  concatenate.20 = f32[1024,1,34]{2,1,0} concatenate(slice.18, reshape.17, slice.19), dimensions={2}
  convolution.21 = f32[1024,1,32]{2,1,0} convolution(concatenate.20, Arg_2.7), window={size=3}, dim_labels=bf0_oi0->bf0
  reshape.22 = f32[32,32,32]{2,1,0} reshape(convolution.21)
  transpose.23 = f32[32,32,32]{1,2,0} transpose(reshape.22), dimensions={0,2,1}
  add.24 = f32[32,32,32]{0,2,1} add(transpose.15, transpose.23)
  reshape.25 = f32[1024,1,32]{2,1,0} reshape(Arg_0.5)
  slice.26 = f32[1024,1,1]{2,1,0} slice(reshape.25), slice={[0:1024], [0:1], [31:32]}
  slice.27 = f32[1024,1,1]{2,1,0} slice(reshape.25), slice={[0:1024], [0:1], [0:1]}
  concatenate.28 = f32[1024,1,34]{2,1,0} concatenate(slice.26, reshape.25, slice.27), dimensions={2}
  convolution.29 = f32[1024,1,32]{2,1,0} convolution(concatenate.28, Arg_2.7), window={size=3}, dim_labels=bf0_oi0->bf0
  reshape.30 = f32[32,32,32]{2,1,0} reshape(convolution.29)
  add.31 = f32[32,32,32]{0,2,1} add(add.24, reshape.30)
  multiply.33 = f32[32,32,32]{2,1,0} multiply(broadcast.32, add.31)
  ROOT add.34 = f32[32,32,32]{2,1,0} add(Arg_0.5, multiply.33)
}

ENTRY main.36 {
  Arg_0.1 = f32[32,32,32]{2,1,0} parameter(0)
  Arg_1.2 = f32[] parameter(1)
  constant.3 = f32[1,1,3]{2,1,0} constant({ { { 1, -2, 1 } } })
  ROOT call.35 = f32[32,32,32]{2,1,0} call(Arg_0.1, Arg_1.2, constant.3), to_apply=heat_step_conv.4
}

