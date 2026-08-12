HloModule jit_heat_step_roll, entry_computation_layout={(f32[32,32,32]{2,1,0}, f32[])->f32[32,32,32]{2,1,0}}

_roll_static.1 {
  Arg_0.2 = f32[32,32,32]{2,1,0} parameter(0)
  slice.2 = f32[31,32,32]{2,1,0} slice(Arg_0.2), slice={[1:32], [0:32], [0:32]}
  slice.3 = f32[1,32,32]{2,1,0} slice(Arg_0.2), slice={[0:1], [0:32], [0:32]}
  ROOT concatenate.1 = f32[32,32,32]{2,1,0} concatenate(slice.2, slice.3), dimensions={0}
}

_roll_static_1.2 {
  Arg_0.4 = f32[32,32,32]{2,1,0} parameter(0)
  slice.6 = f32[1,32,32]{2,1,0} slice(Arg_0.4), slice={[31:32], [0:32], [0:32]}
  slice.7 = f32[31,32,32]{2,1,0} slice(Arg_0.4), slice={[0:31], [0:32], [0:32]}
  ROOT concatenate.3 = f32[32,32,32]{2,1,0} concatenate(slice.6, slice.7), dimensions={0}
}

_roll_static_5.3 {
  Arg_0.6 = f32[32,32,32]{2,1,0} parameter(0)
  slice.10 = f32[32,31,32]{2,1,0} slice(Arg_0.6), slice={[0:32], [1:32], [0:32]}
  slice.11 = f32[32,1,32]{2,1,0} slice(Arg_0.6), slice={[0:32], [0:1], [0:32]}
  ROOT concatenate.5 = f32[32,32,32]{2,1,0} concatenate(slice.10, slice.11), dimensions={1}
}

_roll_static_9.4 {
  Arg_0.8 = f32[32,32,32]{2,1,0} parameter(0)
  slice.14 = f32[32,1,32]{2,1,0} slice(Arg_0.8), slice={[0:32], [31:32], [0:32]}
  slice.15 = f32[32,31,32]{2,1,0} slice(Arg_0.8), slice={[0:32], [0:31], [0:32]}
  ROOT concatenate.7 = f32[32,32,32]{2,1,0} concatenate(slice.14, slice.15), dimensions={1}
}

_roll_static_13.5 {
  Arg_0.10 = f32[32,32,32]{2,1,0} parameter(0)
  slice.18 = f32[32,32,31]{2,1,0} slice(Arg_0.10), slice={[0:32], [0:32], [1:32]}
  slice.19 = f32[32,32,1]{2,1,0} slice(Arg_0.10), slice={[0:32], [0:32], [0:1]}
  ROOT concatenate.9 = f32[32,32,32]{2,1,0} concatenate(slice.18, slice.19), dimensions={2}
}

_roll_static_17.6 {
  Arg_0.12 = f32[32,32,32]{2,1,0} parameter(0)
  slice.22 = f32[32,32,1]{2,1,0} slice(Arg_0.12), slice={[0:32], [0:32], [31:32]}
  slice.23 = f32[32,32,31]{2,1,0} slice(Arg_0.12), slice={[0:32], [0:32], [0:31]}
  ROOT concatenate.11 = f32[32,32,32]{2,1,0} concatenate(slice.22, slice.23), dimensions={2}
}

heat_step_roll.7 {
  Arg_0.13 = f32[32,32,32]{2,1,0} parameter(0)
  Arg_1.1 = f32[] parameter(1)
  mul.6 = f32[32,32,32]{2,1,0} broadcast(Arg_1.1), dimensions={}
  jit__roll_static_.6 = f32[32,32,32]{2,1,0} call(Arg_0.13), to_apply=_roll_static.1
  jit__roll_static_.7 = f32[32,32,32]{2,1,0} call(Arg_0.13), to_apply=_roll_static_1.2
  add.6 = f32[32,32,32]{2,1,0} add(jit__roll_static_.6, jit__roll_static_.7)
  jit__roll_static_.8 = f32[32,32,32]{2,1,0} call(Arg_0.13), to_apply=_roll_static_5.3
  add.7 = f32[32,32,32]{2,1,0} add(add.6, jit__roll_static_.8)
  jit__roll_static_.9 = f32[32,32,32]{2,1,0} call(Arg_0.13), to_apply=_roll_static_9.4
  add.8 = f32[32,32,32]{2,1,0} add(add.7, jit__roll_static_.9)
  jit__roll_static_.10 = f32[32,32,32]{2,1,0} call(Arg_0.13), to_apply=_roll_static_13.5
  add.9 = f32[32,32,32]{2,1,0} add(add.8, jit__roll_static_.10)
  jit__roll_static_.11 = f32[32,32,32]{2,1,0} call(Arg_0.13), to_apply=_roll_static_17.6
  add.10 = f32[32,32,32]{2,1,0} add(add.9, jit__roll_static_.11)
  constant.1 = f32[] constant(6)
  mul.4 = f32[32,32,32]{2,1,0} broadcast(constant.1), dimensions={}
  mul.5 = f32[32,32,32]{2,1,0} multiply(Arg_0.13, mul.4)
  sub.1 = f32[32,32,32]{2,1,0} subtract(add.10, mul.5)
  mul.7 = f32[32,32,32]{2,1,0} multiply(mul.6, sub.1)
  ROOT add.11 = f32[32,32,32]{2,1,0} add(Arg_0.13, mul.7)
}

ENTRY main.8 {
  u.1 = f32[32,32,32]{2,1,0} parameter(0)
  coeff.1 = f32[] parameter(1)
  ROOT jit_heat_step_roll_.1 = f32[32,32,32]{2,1,0} call(u.1, coeff.1), to_apply=heat_step_roll.7
}

