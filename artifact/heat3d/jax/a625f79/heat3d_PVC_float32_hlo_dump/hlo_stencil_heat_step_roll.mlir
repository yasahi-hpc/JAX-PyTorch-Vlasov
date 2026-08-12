HloModule jit_heat_step_roll, entry_computation_layout={(f32[32,32,32]{2,1,0}, f32[])->f32[32,32,32]{2,1,0}}

_roll_static.3 {
  Arg_0.4 = f32[32,32,32]{2,1,0} parameter(0)
  slice.5 = f32[31,32,32]{2,1,0} slice(Arg_0.4), slice={[1:32], [0:32], [0:32]}
  slice.6 = f32[1,32,32]{2,1,0} slice(Arg_0.4), slice={[0:1], [0:32], [0:32]}
  ROOT concatenate.7 = f32[32,32,32]{2,1,0} concatenate(slice.5, slice.6), dimensions={0}
}

_roll_static_0.8 {
  Arg_0.9 = f32[32,32,32]{2,1,0} parameter(0)
  slice.10 = f32[1,32,32]{2,1,0} slice(Arg_0.9), slice={[31:32], [0:32], [0:32]}
  slice.11 = f32[31,32,32]{2,1,0} slice(Arg_0.9), slice={[0:31], [0:32], [0:32]}
  ROOT concatenate.12 = f32[32,32,32]{2,1,0} concatenate(slice.10, slice.11), dimensions={0}
}

_roll_static_1.13 {
  Arg_0.14 = f32[32,32,32]{2,1,0} parameter(0)
  slice.15 = f32[32,31,32]{2,1,0} slice(Arg_0.14), slice={[0:32], [1:32], [0:32]}
  slice.16 = f32[32,1,32]{2,1,0} slice(Arg_0.14), slice={[0:32], [0:1], [0:32]}
  ROOT concatenate.17 = f32[32,32,32]{2,1,0} concatenate(slice.15, slice.16), dimensions={1}
}

_roll_static_2.18 {
  Arg_0.19 = f32[32,32,32]{2,1,0} parameter(0)
  slice.20 = f32[32,1,32]{2,1,0} slice(Arg_0.19), slice={[0:32], [31:32], [0:32]}
  slice.21 = f32[32,31,32]{2,1,0} slice(Arg_0.19), slice={[0:32], [0:31], [0:32]}
  ROOT concatenate.22 = f32[32,32,32]{2,1,0} concatenate(slice.20, slice.21), dimensions={1}
}

_roll_static_3.23 {
  Arg_0.24 = f32[32,32,32]{2,1,0} parameter(0)
  slice.25 = f32[32,32,31]{2,1,0} slice(Arg_0.24), slice={[0:32], [0:32], [1:32]}
  slice.26 = f32[32,32,1]{2,1,0} slice(Arg_0.24), slice={[0:32], [0:32], [0:1]}
  ROOT concatenate.27 = f32[32,32,32]{2,1,0} concatenate(slice.25, slice.26), dimensions={2}
}

_roll_static_4.28 {
  Arg_0.29 = f32[32,32,32]{2,1,0} parameter(0)
  slice.30 = f32[32,32,1]{2,1,0} slice(Arg_0.29), slice={[0:32], [0:32], [31:32]}
  slice.31 = f32[32,32,31]{2,1,0} slice(Arg_0.29), slice={[0:32], [0:32], [0:31]}
  ROOT concatenate.32 = f32[32,32,32]{2,1,0} concatenate(slice.30, slice.31), dimensions={2}
}

heat_step_roll.33 {
  Arg_0.34 = f32[32,32,32]{2,1,0} parameter(0)
  Arg_1.35 = f32[] parameter(1)
  broadcast.51 = f32[32,32,32]{2,1,0} broadcast(Arg_1.35), dimensions={}
  call.38 = f32[32,32,32]{2,1,0} call(Arg_0.34), to_apply=_roll_static.3
  call.39 = f32[32,32,32]{2,1,0} call(Arg_0.34), to_apply=_roll_static_0.8
  add.44 = f32[32,32,32]{2,1,0} add(call.38, call.39)
  call.40 = f32[32,32,32]{2,1,0} call(Arg_0.34), to_apply=_roll_static_1.13
  add.45 = f32[32,32,32]{2,1,0} add(add.44, call.40)
  call.41 = f32[32,32,32]{2,1,0} call(Arg_0.34), to_apply=_roll_static_2.18
  add.46 = f32[32,32,32]{2,1,0} add(add.45, call.41)
  call.42 = f32[32,32,32]{2,1,0} call(Arg_0.34), to_apply=_roll_static_3.23
  add.47 = f32[32,32,32]{2,1,0} add(add.46, call.42)
  call.43 = f32[32,32,32]{2,1,0} call(Arg_0.34), to_apply=_roll_static_4.28
  add.48 = f32[32,32,32]{2,1,0} add(add.47, call.43)
  constant.36 = f32[] constant(6)
  broadcast.37 = f32[32,32,32]{2,1,0} broadcast(constant.36), dimensions={}
  multiply.49 = f32[32,32,32]{2,1,0} multiply(Arg_0.34, broadcast.37)
  subtract.50 = f32[32,32,32]{2,1,0} subtract(add.48, multiply.49)
  multiply.52 = f32[32,32,32]{2,1,0} multiply(broadcast.51, subtract.50)
  ROOT add.53 = f32[32,32,32]{2,1,0} add(Arg_0.34, multiply.52)
}

ENTRY main.55 {
  Arg_0.1 = f32[32,32,32]{2,1,0} parameter(0)
  Arg_1.2 = f32[] parameter(1)
  ROOT call.54 = f32[32,32,32]{2,1,0} call(Arg_0.1, Arg_1.2), to_apply=heat_step_roll.33
}

