HloModule jit_run_chunk, entry_computation_layout={(f64[32,32,32]{2,1,0}, f64[], s64[])->(f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32,32,32]{2,1,0}, f64[], /*index=5*/s64[])}

_roll_static.1 {
  Arg_0.3 = f64[32,32,32]{2,1,0} parameter(0)
  slice.2 = f64[31,32,32]{2,1,0} slice(Arg_0.3), slice={[1:32], [0:32], [0:32]}
  slice.3 = f64[1,32,32]{2,1,0} slice(Arg_0.3), slice={[0:1], [0:32], [0:32]}
  ROOT concatenate.1 = f64[32,32,32]{2,1,0} concatenate(slice.2, slice.3), dimensions={0}
}

_roll_static_1.2 {
  Arg_0.5 = f64[32,32,32]{2,1,0} parameter(0)
  slice.6 = f64[1,32,32]{2,1,0} slice(Arg_0.5), slice={[31:32], [0:32], [0:32]}
  slice.7 = f64[31,32,32]{2,1,0} slice(Arg_0.5), slice={[0:31], [0:32], [0:32]}
  ROOT concatenate.3 = f64[32,32,32]{2,1,0} concatenate(slice.6, slice.7), dimensions={0}
}

_roll_static_5.3 {
  Arg_0.7 = f64[32,32,32]{2,1,0} parameter(0)
  slice.10 = f64[32,31,32]{2,1,0} slice(Arg_0.7), slice={[0:32], [1:32], [0:32]}
  slice.11 = f64[32,1,32]{2,1,0} slice(Arg_0.7), slice={[0:32], [0:1], [0:32]}
  ROOT concatenate.5 = f64[32,32,32]{2,1,0} concatenate(slice.10, slice.11), dimensions={1}
}

_roll_static_9.4 {
  Arg_0.9 = f64[32,32,32]{2,1,0} parameter(0)
  slice.14 = f64[32,1,32]{2,1,0} slice(Arg_0.9), slice={[0:32], [31:32], [0:32]}
  slice.15 = f64[32,31,32]{2,1,0} slice(Arg_0.9), slice={[0:32], [0:31], [0:32]}
  ROOT concatenate.7 = f64[32,32,32]{2,1,0} concatenate(slice.14, slice.15), dimensions={1}
}

_roll_static_13.5 {
  Arg_0.11 = f64[32,32,32]{2,1,0} parameter(0)
  slice.18 = f64[32,32,31]{2,1,0} slice(Arg_0.11), slice={[0:32], [0:32], [1:32]}
  slice.19 = f64[32,32,1]{2,1,0} slice(Arg_0.11), slice={[0:32], [0:32], [0:1]}
  ROOT concatenate.9 = f64[32,32,32]{2,1,0} concatenate(slice.18, slice.19), dimensions={2}
}

_roll_static_17.6 {
  Arg_0.13 = f64[32,32,32]{2,1,0} parameter(0)
  slice.22 = f64[32,32,1]{2,1,0} slice(Arg_0.13), slice={[0:32], [0:32], [31:32]}
  slice.23 = f64[32,32,31]{2,1,0} slice(Arg_0.13), slice={[0:32], [0:32], [0:31]}
  ROOT concatenate.11 = f64[32,32,32]{2,1,0} concatenate(slice.22, slice.23), dimensions={2}
}

heat_step_roll.7 {
  Arg_0.14 = f64[32,32,32]{2,1,0} parameter(0)
  Arg_1.1 = f64[] parameter(1)
  mul.6 = f64[32,32,32]{2,1,0} broadcast(Arg_1.1), dimensions={}
  jit__roll_static_.6 = f64[32,32,32]{2,1,0} call(Arg_0.14), to_apply=_roll_static.1
  jit__roll_static_.7 = f64[32,32,32]{2,1,0} call(Arg_0.14), to_apply=_roll_static_1.2
  add.6 = f64[32,32,32]{2,1,0} add(jit__roll_static_.6, jit__roll_static_.7)
  jit__roll_static_.8 = f64[32,32,32]{2,1,0} call(Arg_0.14), to_apply=_roll_static_5.3
  add.7 = f64[32,32,32]{2,1,0} add(add.6, jit__roll_static_.8)
  jit__roll_static_.9 = f64[32,32,32]{2,1,0} call(Arg_0.14), to_apply=_roll_static_9.4
  add.8 = f64[32,32,32]{2,1,0} add(add.7, jit__roll_static_.9)
  jit__roll_static_.10 = f64[32,32,32]{2,1,0} call(Arg_0.14), to_apply=_roll_static_13.5
  add.9 = f64[32,32,32]{2,1,0} add(add.8, jit__roll_static_.10)
  jit__roll_static_.11 = f64[32,32,32]{2,1,0} call(Arg_0.14), to_apply=_roll_static_17.6
  add.10 = f64[32,32,32]{2,1,0} add(add.9, jit__roll_static_.11)
  constant.7 = f64[] constant(6)
  mul.4 = f64[32,32,32]{2,1,0} broadcast(constant.7), dimensions={}
  mul.5 = f64[32,32,32]{2,1,0} multiply(Arg_0.14, mul.4)
  sub.1 = f64[32,32,32]{2,1,0} subtract(add.10, mul.5)
  mul.7 = f64[32,32,32]{2,1,0} multiply(mul.6, sub.1)
  ROOT add.11 = f64[32,32,32]{2,1,0} add(Arg_0.14, mul.7)
}

closed_call.8 {
  Arg_0.15 = f64[32,32,32]{2,1,0} parameter(0)
  constant.8 = f64[] constant(0.00051876446024876944)
  ROOT jit_heat_step_roll_.1 = f64[32,32,32]{2,1,0} call(Arg_0.15, constant.8), to_apply=heat_step_roll.7
}

region_0.9 {
  arg_tuple.1 = (s64[], f64[32,32,32]{2,1,0}) parameter(0)
  get-tuple-element.2 = s64[] get-tuple-element(arg_tuple.1), index=0
  constant.9 = s64[] constant(1)
  add.13 = s64[] add(get-tuple-element.2, constant.9)
  get-tuple-element.3 = f64[32,32,32]{2,1,0} get-tuple-element(arg_tuple.1), index=1
  closed_call.1 = f64[32,32,32]{2,1,0} call(get-tuple-element.3), to_apply=closed_call.8
  ROOT tuple.1 = (s64[], f64[32,32,32]{2,1,0}) tuple(add.13, closed_call.1)
}

region_1.10 {
  arg_tuple.3 = (s64[], f64[32,32,32]{2,1,0}) parameter(0)
  get-tuple-element.7 = f64[32,32,32]{2,1,0} get-tuple-element(arg_tuple.3), index=1
  get-tuple-element.6 = s64[] get-tuple-element(arg_tuple.3), index=0
  constant.11 = s64[] constant(100)
  ROOT lt.1 = pred[] compare(get-tuple-element.6, constant.11), direction=LT
}

ENTRY main.11 {
  constant.15 = s64[] constant(0)
  start_state_1__0_.1 = f64[32,32,32]{2,1,0} parameter(0)
  while.4 = (s64[], f64[32,32,32]{2,1,0}) tuple(constant.15, start_state_1__0_.1)
  while.5 = (s64[], f64[32,32,32]{2,1,0}) while(while.4), condition=region_1.10, body=region_0.9
  while.6 = s64[] get-tuple-element(while.5), index=0
  constant.14 = f64[32]{0} constant({...})
  while.7 = f64[32,32,32]{2,1,0} get-tuple-element(while.5), index=1
  start_state_2_.1 = f64[] parameter(1)
  constant.12 = f64[] constant(2)
  add.16 = f64[] add(start_state_2_.1, constant.12)
  start_state_3_.1 = s64[] parameter(2)
  constant.13 = s64[] constant(100)
  add.17 = s64[] add(start_state_3_.1, constant.13)
  ROOT tuple.3 = (f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32,32,32]{2,1,0}, f64[], /*index=5*/s64[]) tuple(constant.14, constant.14, constant.14, while.7, add.16, add.17)
}

