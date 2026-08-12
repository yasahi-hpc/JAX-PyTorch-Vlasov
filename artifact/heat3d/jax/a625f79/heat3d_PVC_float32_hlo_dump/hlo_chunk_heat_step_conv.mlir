HloModule jit_run_chunk, entry_computation_layout={(f32[32,32,32]{2,1,0}, f32[], s32[])->(f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,32,32]{2,1,0}, f32[], /*index=5*/s32[])}

heat_step_conv.9 {
  Arg_0.10 = f32[32,32,32]{2,1,0} parameter(0)
  Arg_1.11 = f32[] parameter(1)
  broadcast.37 = f32[32,32,32]{2,1,0} broadcast(Arg_1.11), dimensions={}
  transpose.13 = f32[32,32,32]{1,0,2} transpose(Arg_0.10), dimensions={1,2,0}
  reshape.14 = f32[1024,1,32]{2,1,0} reshape(transpose.13)
  slice.15 = f32[1024,1,1]{2,1,0} slice(reshape.14), slice={[0:1024], [0:1], [31:32]}
  slice.16 = f32[1024,1,1]{2,1,0} slice(reshape.14), slice={[0:1024], [0:1], [0:1]}
  concatenate.17 = f32[1024,1,34]{2,1,0} concatenate(slice.15, reshape.14, slice.16), dimensions={2}
  Arg_2.12 = f32[1,1,3]{2,1,0} parameter(2)
  convolution.18 = f32[1024,1,32]{2,1,0} convolution(concatenate.17, Arg_2.12), window={size=3}, dim_labels=bf0_oi0->bf0
  reshape.19 = f32[32,32,32]{2,1,0} reshape(convolution.18)
  transpose.20 = f32[32,32,32]{0,2,1} transpose(reshape.19), dimensions={2,0,1}
  transpose.21 = f32[32,32,32]{1,2,0} transpose(Arg_0.10), dimensions={0,2,1}
  reshape.22 = f32[1024,1,32]{2,1,0} reshape(transpose.21)
  slice.23 = f32[1024,1,1]{2,1,0} slice(reshape.22), slice={[0:1024], [0:1], [31:32]}
  slice.24 = f32[1024,1,1]{2,1,0} slice(reshape.22), slice={[0:1024], [0:1], [0:1]}
  concatenate.25 = f32[1024,1,34]{2,1,0} concatenate(slice.23, reshape.22, slice.24), dimensions={2}
  convolution.26 = f32[1024,1,32]{2,1,0} convolution(concatenate.25, Arg_2.12), window={size=3}, dim_labels=bf0_oi0->bf0
  reshape.27 = f32[32,32,32]{2,1,0} reshape(convolution.26)
  transpose.28 = f32[32,32,32]{1,2,0} transpose(reshape.27), dimensions={0,2,1}
  add.29 = f32[32,32,32]{0,2,1} add(transpose.20, transpose.28)
  reshape.30 = f32[1024,1,32]{2,1,0} reshape(Arg_0.10)
  slice.31 = f32[1024,1,1]{2,1,0} slice(reshape.30), slice={[0:1024], [0:1], [31:32]}
  slice.32 = f32[1024,1,1]{2,1,0} slice(reshape.30), slice={[0:1024], [0:1], [0:1]}
  concatenate.33 = f32[1024,1,34]{2,1,0} concatenate(slice.31, reshape.30, slice.32), dimensions={2}
  convolution.34 = f32[1024,1,32]{2,1,0} convolution(concatenate.33, Arg_2.12), window={size=3}, dim_labels=bf0_oi0->bf0
  reshape.35 = f32[32,32,32]{2,1,0} reshape(convolution.34)
  add.36 = f32[32,32,32]{0,2,1} add(add.29, reshape.35)
  multiply.38 = f32[32,32,32]{2,1,0} multiply(broadcast.37, add.36)
  ROOT add.39 = f32[32,32,32]{2,1,0} add(Arg_0.10, multiply.38)
}

None.40 {
  Arg_1.42 = f32[32,32,32]{2,1,0} parameter(1)
  constant.43 = f32[] constant(0.000518764486)
  Arg_0.41 = f32[1,1,3]{2,1,0} parameter(0)
  ROOT call.44 = f32[32,32,32]{2,1,0} call(Arg_1.42, constant.43, Arg_0.41), to_apply=heat_step_conv.9
}

region_0.45 {
  arg_tuple.46 = (s32[], f32[32,32,32]{2,1,0}) parameter(0)
  get-tuple-element.47 = s32[] get-tuple-element(arg_tuple.46), index=0
  constant.49 = s32[] constant(1)
  add.52 = s32[] add(get-tuple-element.47, constant.49)
  constant.50 = f32[1,1,3]{2,1,0} constant({ { { 1, -2, 1 } } })
  get-tuple-element.48 = f32[32,32,32]{2,1,0} get-tuple-element(arg_tuple.46), index=1
  call.51 = f32[32,32,32]{2,1,0} call(constant.50, get-tuple-element.48), to_apply=None.40
  ROOT tuple.53 = (s32[], f32[32,32,32]{2,1,0}) tuple(add.52, call.51)
}

region_1.54 {
  arg_tuple.55 = (s32[], f32[32,32,32]{2,1,0}) parameter(0)
  get-tuple-element.57 = f32[32,32,32]{2,1,0} get-tuple-element(arg_tuple.55), index=1
  get-tuple-element.56 = s32[] get-tuple-element(arg_tuple.55), index=0
  constant.58 = s32[] constant(100)
  ROOT compare.59 = pred[] compare(get-tuple-element.56, constant.58), direction=LT
}

ENTRY main.66 {
  constant.7 = s32[] constant(0)
  Arg_0.1 = f32[32,32,32]{2,1,0} parameter(0)
  tuple.8 = (s32[], f32[32,32,32]{2,1,0}) tuple(constant.7, Arg_0.1)
  while.60 = (s32[], f32[32,32,32]{2,1,0}) while(tuple.8), condition=region_1.54, body=region_0.45
  get-tuple-element.61 = s32[] get-tuple-element(while.60), index=0
  constant.6 = f32[32]{0} constant({...})
  get-tuple-element.62 = f32[32,32,32]{2,1,0} get-tuple-element(while.60), index=1
  Arg_1.2 = f32[] parameter(1)
  constant.4 = f32[] constant(2)
  add.63 = f32[] add(Arg_1.2, constant.4)
  Arg_2.3 = s32[] parameter(2)
  constant.5 = s32[] constant(100)
  add.64 = s32[] add(Arg_2.3, constant.5)
  ROOT tuple.65 = (f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,32,32]{2,1,0}, f32[], /*index=5*/s32[]) tuple(constant.6, constant.6, constant.6, get-tuple-element.62, add.63, add.64)
}

