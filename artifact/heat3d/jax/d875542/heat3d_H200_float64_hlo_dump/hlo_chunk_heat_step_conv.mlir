HloModule jit_run_chunk, entry_computation_layout={(f64[32,32,32]{2,1,0}, f64[], s64[])->(f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32,32,32]{2,1,0}, f64[], /*index=5*/s64[])}

heat_step_conv.1 {
  Arg_0.2 = f64[32,32,32]{2,1,0} parameter(0)
  Arg_1.2 = f64[] parameter(1)
  mul.2 = f64[32,32,32]{2,1,0} broadcast(Arg_1.2), dimensions={}
  transpose.4 = f64[32,32,32]{1,0,2} transpose(Arg_0.2), dimensions={1,2,0}
  reshape.6 = f64[1024,1,32]{2,1,0} reshape(transpose.4)
  slice.6 = f64[1024,1,1]{2,1,0} slice(reshape.6), slice={[0:1024], [0:1], [31:32]}
  slice.7 = f64[1024,1,1]{2,1,0} slice(reshape.6), slice={[0:1024], [0:1], [0:1]}
  concatenate.3 = f64[1024,1,34]{2,1,0} concatenate(slice.6, reshape.6, slice.7), dimensions={2}
  Arg_2.1 = f64[1,1,3]{2,1,0} parameter(2)
  conv_general_dilated.3 = f64[1024,1,32]{2,1,0} convolution(concatenate.3, Arg_2.1), window={size=3}, dim_labels=bf0_oi0->bf0
  reshape.7 = f64[32,32,32]{2,1,0} reshape(conv_general_dilated.3)
  transpose.5 = f64[32,32,32]{0,2,1} transpose(reshape.7), dimensions={2,0,1}
  transpose.6 = f64[32,32,32]{1,2,0} transpose(Arg_0.2), dimensions={0,2,1}
  reshape.8 = f64[1024,1,32]{2,1,0} reshape(transpose.6)
  slice.8 = f64[1024,1,1]{2,1,0} slice(reshape.8), slice={[0:1024], [0:1], [31:32]}
  slice.9 = f64[1024,1,1]{2,1,0} slice(reshape.8), slice={[0:1024], [0:1], [0:1]}
  concatenate.4 = f64[1024,1,34]{2,1,0} concatenate(slice.8, reshape.8, slice.9), dimensions={2}
  conv_general_dilated.4 = f64[1024,1,32]{2,1,0} convolution(concatenate.4, Arg_2.1), window={size=3}, dim_labels=bf0_oi0->bf0
  reshape.9 = f64[32,32,32]{2,1,0} reshape(conv_general_dilated.4)
  transpose.7 = f64[32,32,32]{1,2,0} transpose(reshape.9), dimensions={0,2,1}
  add.3 = f64[32,32,32]{0,2,1} add(transpose.5, transpose.7)
  reshape.10 = f64[1024,1,32]{2,1,0} reshape(Arg_0.2)
  slice.10 = f64[1024,1,1]{2,1,0} slice(reshape.10), slice={[0:1024], [0:1], [31:32]}
  slice.11 = f64[1024,1,1]{2,1,0} slice(reshape.10), slice={[0:1024], [0:1], [0:1]}
  concatenate.5 = f64[1024,1,34]{2,1,0} concatenate(slice.10, reshape.10, slice.11), dimensions={2}
  conv_general_dilated.5 = f64[1024,1,32]{2,1,0} convolution(concatenate.5, Arg_2.1), window={size=3}, dim_labels=bf0_oi0->bf0
  reshape.11 = f64[32,32,32]{2,1,0} reshape(conv_general_dilated.5)
  add.4 = f64[32,32,32]{0,2,1} add(add.3, reshape.11)
  mul.3 = f64[32,32,32]{2,1,0} multiply(mul.2, add.4)
  ROOT add.5 = f64[32,32,32]{2,1,0} add(Arg_0.2, mul.3)
}

closed_call.2 {
  Arg_1.3 = f64[32,32,32]{2,1,0} parameter(1)
  constant.7 = f64[] constant(0.00051876446024876944)
  Arg_0.3 = f64[1,1,3]{2,1,0} parameter(0)
  ROOT jit_heat_step_conv_.1 = f64[32,32,32]{2,1,0} call(Arg_1.3, constant.7, Arg_0.3), to_apply=heat_step_conv.1
}

region_0.3 {
  arg_tuple.1 = (s64[], f64[32,32,32]{2,1,0}) parameter(0)
  get-tuple-element.2 = s64[] get-tuple-element(arg_tuple.1), index=0
  constant.8 = s64[] constant(1)
  add.7 = s64[] add(get-tuple-element.2, constant.8)
  constant.9 = f64[1,1,3]{2,1,0} constant({ { { 1, -2, 1 } } })
  get-tuple-element.3 = f64[32,32,32]{2,1,0} get-tuple-element(arg_tuple.1), index=1
  closed_call.1 = f64[32,32,32]{2,1,0} call(constant.9, get-tuple-element.3), to_apply=closed_call.2
  ROOT tuple.1 = (s64[], f64[32,32,32]{2,1,0}) tuple(add.7, closed_call.1)
}

region_1.4 {
  arg_tuple.3 = (s64[], f64[32,32,32]{2,1,0}) parameter(0)
  get-tuple-element.7 = f64[32,32,32]{2,1,0} get-tuple-element(arg_tuple.3), index=1
  get-tuple-element.6 = s64[] get-tuple-element(arg_tuple.3), index=0
  constant.11 = s64[] constant(100)
  ROOT lt.1 = pred[] compare(get-tuple-element.6, constant.11), direction=LT
}

ENTRY main.5 {
  constant.15 = s64[] constant(0)
  start_state_1__0_.1 = f64[32,32,32]{2,1,0} parameter(0)
  while.4 = (s64[], f64[32,32,32]{2,1,0}) tuple(constant.15, start_state_1__0_.1)
  while.5 = (s64[], f64[32,32,32]{2,1,0}) while(while.4), condition=region_1.4, body=region_0.3
  while.6 = s64[] get-tuple-element(while.5), index=0
  constant.14 = f64[32]{0} constant({...})
  while.7 = f64[32,32,32]{2,1,0} get-tuple-element(while.5), index=1
  start_state_2_.1 = f64[] parameter(1)
  constant.12 = f64[] constant(2)
  add.10 = f64[] add(start_state_2_.1, constant.12)
  start_state_3_.1 = s64[] parameter(2)
  constant.13 = s64[] constant(100)
  add.11 = s64[] add(start_state_3_.1, constant.13)
  ROOT tuple.3 = (f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32,32,32]{2,1,0}, f64[], /*index=5*/s64[]) tuple(constant.14, constant.14, constant.14, while.7, add.10, add.11)
}

