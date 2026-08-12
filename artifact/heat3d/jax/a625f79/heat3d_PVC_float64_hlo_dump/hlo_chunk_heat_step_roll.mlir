HloModule jit_run_chunk, entry_computation_layout={(f64[32,32,32]{2,1,0}, f64[], s64[])->(f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32,32,32]{2,1,0}, f64[], /*index=5*/s64[])}

_roll_static.9 {
  Arg_0.10 = f64[32,32,32]{2,1,0} parameter(0)
  slice.11 = f64[31,32,32]{2,1,0} slice(Arg_0.10), slice={[1:32], [0:32], [0:32]}
  slice.12 = f64[1,32,32]{2,1,0} slice(Arg_0.10), slice={[0:1], [0:32], [0:32]}
  ROOT concatenate.13 = f64[32,32,32]{2,1,0} concatenate(slice.11, slice.12), dimensions={0}
}

_roll_static_0.14 {
  Arg_0.15 = f64[32,32,32]{2,1,0} parameter(0)
  slice.16 = f64[1,32,32]{2,1,0} slice(Arg_0.15), slice={[31:32], [0:32], [0:32]}
  slice.17 = f64[31,32,32]{2,1,0} slice(Arg_0.15), slice={[0:31], [0:32], [0:32]}
  ROOT concatenate.18 = f64[32,32,32]{2,1,0} concatenate(slice.16, slice.17), dimensions={0}
}

_roll_static_1.19 {
  Arg_0.20 = f64[32,32,32]{2,1,0} parameter(0)
  slice.21 = f64[32,31,32]{2,1,0} slice(Arg_0.20), slice={[0:32], [1:32], [0:32]}
  slice.22 = f64[32,1,32]{2,1,0} slice(Arg_0.20), slice={[0:32], [0:1], [0:32]}
  ROOT concatenate.23 = f64[32,32,32]{2,1,0} concatenate(slice.21, slice.22), dimensions={1}
}

_roll_static_2.24 {
  Arg_0.25 = f64[32,32,32]{2,1,0} parameter(0)
  slice.26 = f64[32,1,32]{2,1,0} slice(Arg_0.25), slice={[0:32], [31:32], [0:32]}
  slice.27 = f64[32,31,32]{2,1,0} slice(Arg_0.25), slice={[0:32], [0:31], [0:32]}
  ROOT concatenate.28 = f64[32,32,32]{2,1,0} concatenate(slice.26, slice.27), dimensions={1}
}

_roll_static_3.29 {
  Arg_0.30 = f64[32,32,32]{2,1,0} parameter(0)
  slice.31 = f64[32,32,31]{2,1,0} slice(Arg_0.30), slice={[0:32], [0:32], [1:32]}
  slice.32 = f64[32,32,1]{2,1,0} slice(Arg_0.30), slice={[0:32], [0:32], [0:1]}
  ROOT concatenate.33 = f64[32,32,32]{2,1,0} concatenate(slice.31, slice.32), dimensions={2}
}

_roll_static_4.34 {
  Arg_0.35 = f64[32,32,32]{2,1,0} parameter(0)
  slice.36 = f64[32,32,1]{2,1,0} slice(Arg_0.35), slice={[0:32], [0:32], [31:32]}
  slice.37 = f64[32,32,31]{2,1,0} slice(Arg_0.35), slice={[0:32], [0:32], [0:31]}
  ROOT concatenate.38 = f64[32,32,32]{2,1,0} concatenate(slice.36, slice.37), dimensions={2}
}

heat_step_roll.39 {
  Arg_0.40 = f64[32,32,32]{2,1,0} parameter(0)
  Arg_1.41 = f64[] parameter(1)
  broadcast.57 = f64[32,32,32]{2,1,0} broadcast(Arg_1.41), dimensions={}
  call.44 = f64[32,32,32]{2,1,0} call(Arg_0.40), to_apply=_roll_static.9
  call.45 = f64[32,32,32]{2,1,0} call(Arg_0.40), to_apply=_roll_static_0.14
  add.50 = f64[32,32,32]{2,1,0} add(call.44, call.45)
  call.46 = f64[32,32,32]{2,1,0} call(Arg_0.40), to_apply=_roll_static_1.19
  add.51 = f64[32,32,32]{2,1,0} add(add.50, call.46)
  call.47 = f64[32,32,32]{2,1,0} call(Arg_0.40), to_apply=_roll_static_2.24
  add.52 = f64[32,32,32]{2,1,0} add(add.51, call.47)
  call.48 = f64[32,32,32]{2,1,0} call(Arg_0.40), to_apply=_roll_static_3.29
  add.53 = f64[32,32,32]{2,1,0} add(add.52, call.48)
  call.49 = f64[32,32,32]{2,1,0} call(Arg_0.40), to_apply=_roll_static_4.34
  add.54 = f64[32,32,32]{2,1,0} add(add.53, call.49)
  constant.42 = f64[] constant(6)
  broadcast.43 = f64[32,32,32]{2,1,0} broadcast(constant.42), dimensions={}
  multiply.55 = f64[32,32,32]{2,1,0} multiply(Arg_0.40, broadcast.43)
  subtract.56 = f64[32,32,32]{2,1,0} subtract(add.54, multiply.55)
  multiply.58 = f64[32,32,32]{2,1,0} multiply(broadcast.57, subtract.56)
  ROOT add.59 = f64[32,32,32]{2,1,0} add(Arg_0.40, multiply.58)
}

None.60 {
  Arg_0.61 = f64[32,32,32]{2,1,0} parameter(0)
  constant.62 = f64[] constant(0.00051876446024876944)
  ROOT call.63 = f64[32,32,32]{2,1,0} call(Arg_0.61, constant.62), to_apply=heat_step_roll.39
}

region_0.64 {
  arg_tuple.65 = (s64[], f64[32,32,32]{2,1,0}) parameter(0)
  get-tuple-element.66 = s64[] get-tuple-element(arg_tuple.65), index=0
  constant.68 = s64[] constant(1)
  add.70 = s64[] add(get-tuple-element.66, constant.68)
  get-tuple-element.67 = f64[32,32,32]{2,1,0} get-tuple-element(arg_tuple.65), index=1
  call.69 = f64[32,32,32]{2,1,0} call(get-tuple-element.67), to_apply=None.60
  ROOT tuple.71 = (s64[], f64[32,32,32]{2,1,0}) tuple(add.70, call.69)
}

region_1.72 {
  arg_tuple.73 = (s64[], f64[32,32,32]{2,1,0}) parameter(0)
  get-tuple-element.75 = f64[32,32,32]{2,1,0} get-tuple-element(arg_tuple.73), index=1
  get-tuple-element.74 = s64[] get-tuple-element(arg_tuple.73), index=0
  constant.76 = s64[] constant(100)
  ROOT compare.77 = pred[] compare(get-tuple-element.74, constant.76), direction=LT
}

ENTRY main.84 {
  constant.7 = s64[] constant(0)
  Arg_0.1 = f64[32,32,32]{2,1,0} parameter(0)
  tuple.8 = (s64[], f64[32,32,32]{2,1,0}) tuple(constant.7, Arg_0.1)
  while.78 = (s64[], f64[32,32,32]{2,1,0}) while(tuple.8), condition=region_1.72, body=region_0.64
  get-tuple-element.79 = s64[] get-tuple-element(while.78), index=0
  constant.6 = f64[32]{0} constant({...})
  get-tuple-element.80 = f64[32,32,32]{2,1,0} get-tuple-element(while.78), index=1
  Arg_1.2 = f64[] parameter(1)
  constant.4 = f64[] constant(2)
  add.81 = f64[] add(Arg_1.2, constant.4)
  Arg_2.3 = s64[] parameter(2)
  constant.5 = s64[] constant(100)
  add.82 = s64[] add(Arg_2.3, constant.5)
  ROOT tuple.83 = (f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32,32,32]{2,1,0}, f64[], /*index=5*/s64[]) tuple(constant.6, constant.6, constant.6, get-tuple-element.80, add.81, add.82)
}

