HloModule jit__lambda, entry_computation_layout={(f32[128,128]{1,0})->(f32[128,128]{1,0}, f32[128]{0}, f32[128]{0})}

_roll_static.1 {
  Arg_0.1 = f32[128,14]{1,0} parameter(0)
  slice.3 = f32[126,14]{1,0} slice(Arg_0.1), slice={[2:128], [0:14]}
  slice.4 = f32[2,14]{1,0} slice(Arg_0.1), slice={[0:2], [0:14]}
  ROOT concatenate.1 = f32[128,14]{1,0} concatenate(slice.3, slice.4), dimensions={0}
}

_roll_static_6.2 {
  Arg_0.3 = f32[128,50]{1,0} parameter(0)
  slice.8 = f32[127,50]{1,0} slice(Arg_0.3), slice={[1:128], [0:50]}
  slice.9 = f32[1,50]{1,0} slice(Arg_0.3), slice={[0:1], [0:50]}
  ROOT concatenate.3 = f32[128,50]{1,0} concatenate(slice.8, slice.9), dimensions={0}
}

_roll_static_11.3 {
  ROOT Arg_0.5 = f32[128,50]{1,0} parameter(0)
}

_roll_static_16.4 {
  Arg_0.7 = f32[128,14]{1,0} parameter(0)
  slice.14 = f32[1,14]{1,0} slice(Arg_0.7), slice={[127:128], [0:14]}
  slice.15 = f32[127,14]{1,0} slice(Arg_0.7), slice={[0:127], [0:14]}
  ROOT concatenate.5 = f32[128,14]{1,0} concatenate(slice.14, slice.15), dimensions={0}
}

_roll_static_22.5 {
  Arg_0.9 = f32[128,128]{1,0} parameter(0)
  slice.18 = f32[126,128]{1,0} slice(Arg_0.9), slice={[2:128], [0:128]}
  slice.19 = f32[2,128]{1,0} slice(Arg_0.9), slice={[0:2], [0:128]}
  ROOT concatenate.8 = f32[128,128]{1,0} concatenate(slice.18, slice.19), dimensions={0}
}

_roll_static_29.6 {
  Arg_0.11 = f32[128,128]{1,0} parameter(0)
  slice.22 = f32[127,128]{1,0} slice(Arg_0.11), slice={[1:128], [0:128]}
  slice.23 = f32[1,128]{1,0} slice(Arg_0.11), slice={[0:1], [0:128]}
  ROOT concatenate.10 = f32[128,128]{1,0} concatenate(slice.22, slice.23), dimensions={0}
}

_roll_static_34.7 {
  ROOT Arg_0.13 = f32[128,128]{1,0} parameter(0)
}

_roll_static_39.8 {
  Arg_0.15 = f32[128,128]{1,0} parameter(0)
  slice.26 = f32[1,128]{1,0} slice(Arg_0.15), slice={[127:128], [0:128]}
  slice.27 = f32[127,128]{1,0} slice(Arg_0.15), slice={[0:127], [0:128]}
  ROOT concatenate.12 = f32[128,128]{1,0} concatenate(slice.26, slice.27), dimensions={0}
}

_roll_static_44.9 {
  Arg_0.17 = f32[128,128]{1,0} parameter(0)
  slice.30 = f32[2,128]{1,0} slice(Arg_0.17), slice={[126:128], [0:128]}
  slice.31 = f32[126,128]{1,0} slice(Arg_0.17), slice={[0:126], [0:128]}
  ROOT concatenate.14 = f32[128,128]{1,0} concatenate(slice.30, slice.31), dimensions={0}
}

_roll_static_49.10 {
  Arg_0.19 = f32[128,128]{1,0} parameter(0)
  slice.34 = f32[3,128]{1,0} slice(Arg_0.19), slice={[125:128], [0:128]}
  slice.35 = f32[125,128]{1,0} slice(Arg_0.19), slice={[0:125], [0:128]}
  ROOT concatenate.16 = f32[128,128]{1,0} concatenate(slice.34, slice.35), dimensions={0}
}

region_0.11 {
  reduce_sum.3 = f32[] parameter(0)
  reduce_sum.4 = f32[] parameter(1)
  ROOT reduce_sum.5 = f32[] add(reduce_sum.3, reduce_sum.4)
}

fft.12 {
  Arg_0.22 = f32[128]{0} parameter(0)
  ROOT fft.1 = c64[65]{0} fft(Arg_0.22), fft_type=RFFT, fft_length={128}
}

fft_60.13 {
  Arg_0.24 = c64[65]{0} parameter(0)
  ROOT fft.3 = f32[128]{0} fft(Arg_0.24), fft_type=IRFFT, fft_length={128}
}

solve_poisson.14 {
  Arg_0.25 = f32[128,128]{1,0} parameter(0)
  constant.41 = f32[] constant(0)
  reduce_sum.7 = f32[128]{0} reduce(Arg_0.25, constant.41), dimensions={1}, to_apply=region_0.11
  Arg_2.1 = f32[] parameter(2)
  mul.32 = f32[128]{0} broadcast(Arg_2.1), dimensions={}
  mul.33 = f32[128]{0} multiply(reduce_sum.7, mul.32)
  constant.40 = f32[] constant(1)
  sub.3 = f32[128]{0} broadcast(constant.40), dimensions={}
  sub.4 = f32[128]{0} subtract(mul.33, sub.3)
  jit_fft_.3 = c64[65]{0} call(sub.4), to_apply=fft.12
  constant.39 = c64[] constant((-0, -1))
  mul.31 = c64[65]{0} broadcast(constant.39), dimensions={}
  mul.34 = c64[65]{0} multiply(jit_fft_.3, mul.31)
  Arg_1.1 = f32[65]{0} parameter(1)
  convert_element_type.2 = c64[65]{0} convert(Arg_1.1)
  mul.35 = c64[65]{0} multiply(mul.34, convert_element_type.2)
  jit_fft_.4 = f32[128]{0} call(mul.35), to_apply=fft_60.13
  integer_pow.1 = f32[65]{0} multiply(Arg_1.1, Arg_1.1)
  convert_element_type.3 = c64[65]{0} convert(integer_pow.1)
  mul.36 = c64[65]{0} multiply(jit_fft_.3, convert_element_type.3)
  jit_fft_.5 = f32[128]{0} call(mul.36), to_apply=fft_60.13
  ROOT tuple.1 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) tuple(jit_fft_.4, sub.4, jit_fft_.5)
}

_where.15 {
  Arg_0.27 = pred[128]{0} parameter(0)
  Arg_1.3 = f32[128]{0} parameter(1)
  Arg_2.3 = f32[] parameter(2)
  broadcast_in_dim.1 = f32[128]{0} broadcast(Arg_2.3), dimensions={}
  ROOT select_n.1 = f32[128]{0} select(Arg_0.27, Arg_1.3, broadcast_in_dim.1)
}

_pad.16 {
  Arg_0.29 = f32[128,128]{1,0} parameter(0)
  Arg_1.5 = s32[] parameter(1)
  convert_element_type.6 = f32[] convert(Arg_1.5)
  ROOT pad.1 = f32[128,134]{1,0} pad(Arg_0.29, convert_element_type.6), padding=0_0x3_3
}

ENTRY main.17 {
  carry_0_.1 = f32[128,128]{1,0} parameter(0)
  slice.47 = f32[128,14]{1,0} slice(carry_0_.1), slice={[0:128], [0:14]}
  jit__roll_static_.20 = f32[128,14]{1,0} call(slice.47), to_apply=_roll_static.1
  slice.48 = f32[128,50]{1,0} slice(carry_0_.1), slice={[0:128], [14:64]}
  jit__roll_static_.21 = f32[128,50]{1,0} call(slice.48), to_apply=_roll_static_6.2
  slice.49 = f32[128,50]{1,0} slice(carry_0_.1), slice={[0:128], [64:114]}
  jit__roll_static_.22 = f32[128,50]{1,0} call(slice.49), to_apply=_roll_static_11.3
  slice.50 = f32[128,14]{1,0} slice(carry_0_.1), slice={[0:128], [114:128]}
  jit__roll_static_.23 = f32[128,14]{1,0} call(slice.50), to_apply=_roll_static_16.4
  concatenate.18 = f32[128,128]{1,0} concatenate(jit__roll_static_.20, jit__roll_static_.21, jit__roll_static_.22, jit__roll_static_.23), dimensions={1}
  jit__roll_static_.24 = f32[128,128]{1,0} call(concatenate.18), to_apply=_roll_static_22.5
  constant.72 = f32[1,128]{1,0} constant({...})
  mul.101 = f32[1,128]{1,0} broadcast(constant.72), dimensions={0,1}
  mul.102 = f32[128]{0} reshape(mul.101)
  mul.103 = f32[128,128]{1,0} broadcast(mul.102), dimensions={1}
  mul.104 = f32[128,128]{1,0} multiply(jit__roll_static_.24, mul.103)
  jit__roll_static_.25 = f32[128,128]{1,0} call(concatenate.18), to_apply=_roll_static_29.6
  constant.73 = f32[1,128]{1,0} constant({...})
  mul.105 = f32[1,128]{1,0} broadcast(constant.73), dimensions={0,1}
  mul.106 = f32[128]{0} reshape(mul.105)
  mul.107 = f32[128,128]{1,0} broadcast(mul.106), dimensions={1}
  mul.108 = f32[128,128]{1,0} multiply(jit__roll_static_.25, mul.107)
  add.61 = f32[128,128]{1,0} add(mul.104, mul.108)
  jit__roll_static_.26 = f32[128,128]{1,0} call(concatenate.18), to_apply=_roll_static_34.7
  constant.74 = f32[1,128]{1,0} constant({...})
  mul.109 = f32[1,128]{1,0} broadcast(constant.74), dimensions={0,1}
  mul.110 = f32[128]{0} reshape(mul.109)
  mul.111 = f32[128,128]{1,0} broadcast(mul.110), dimensions={1}
  mul.112 = f32[128,128]{1,0} multiply(jit__roll_static_.26, mul.111)
  add.62 = f32[128,128]{1,0} add(add.61, mul.112)
  jit__roll_static_.27 = f32[128,128]{1,0} call(concatenate.18), to_apply=_roll_static_39.8
  constant.75 = f32[1,128]{1,0} constant({...})
  mul.113 = f32[1,128]{1,0} broadcast(constant.75), dimensions={0,1}
  mul.114 = f32[128]{0} reshape(mul.113)
  mul.115 = f32[128,128]{1,0} broadcast(mul.114), dimensions={1}
  mul.116 = f32[128,128]{1,0} multiply(jit__roll_static_.27, mul.115)
  add.63 = f32[128,128]{1,0} add(add.62, mul.116)
  jit__roll_static_.28 = f32[128,128]{1,0} call(concatenate.18), to_apply=_roll_static_44.9
  constant.76 = f32[1,128]{1,0} constant({...})
  mul.117 = f32[1,128]{1,0} broadcast(constant.76), dimensions={0,1}
  mul.118 = f32[128]{0} reshape(mul.117)
  mul.119 = f32[128,128]{1,0} broadcast(mul.118), dimensions={1}
  mul.120 = f32[128,128]{1,0} multiply(jit__roll_static_.28, mul.119)
  add.64 = f32[128,128]{1,0} add(add.63, mul.120)
  jit__roll_static_.29 = f32[128,128]{1,0} call(concatenate.18), to_apply=_roll_static_49.10
  constant.77 = f32[1,128]{1,0} constant({...})
  mul.121 = f32[1,128]{1,0} broadcast(constant.77), dimensions={0,1}
  mul.122 = f32[128]{0} reshape(mul.121)
  mul.123 = f32[128,128]{1,0} broadcast(mul.122), dimensions={1}
  mul.124 = f32[128,128]{1,0} multiply(jit__roll_static_.29, mul.123)
  add.65 = f32[128,128]{1,0} add(add.64, mul.124)
  constant.71 = f32[65]{0} constant({...})
  constant.69 = f32[] constant(0.0787401572)
  jit_solve_poisson_.4 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) call(add.65, constant.71, constant.69), to_apply=solve_poisson.14
  jit_solve_poisson_.5 = f32[128]{0} get-tuple-element(jit_solve_poisson_.4), index=0
  constant.67 = f32[] constant(0.05)
  mul.100 = f32[128]{0} broadcast(constant.67), dimensions={}
  mul.125 = f32[128]{0} multiply(jit_solve_poisson_.5, mul.100)
  constant.66 = f32[] constant(0.0787401572)
  div.33 = f32[128]{0} broadcast(constant.66), dimensions={}
  div.34 = f32[128]{0} divide(mul.125, div.33)
  floor.1 = f32[128]{0} floor(div.34)
  convert_element_type.7 = s32[128]{0} convert(floor.1)
  constant.53 = s32[] constant(-1)
  broadcast.28 = s32[128]{0} broadcast(constant.53), dimensions={}
  eq.46 = pred[128]{0} compare(convert_element_type.7, broadcast.28), direction=EQ
  sub.20 = f32[128]{0} subtract(div.34, floor.1)
  constant.65 = f32[] constant(20)
  div.32 = f32[128]{0} broadcast(constant.65), dimensions={}
  div.35 = f32[128]{0} divide(sub.20, div.32)
  mul.126 = f32[128]{0} multiply(sub.20, sub.20)
  constant.64 = f32[] constant(24)
  broadcast.37 = f32[128]{0} broadcast(constant.64), dimensions={}
  div.36 = f32[128]{0} divide(mul.126, broadcast.37)
  sub.21 = f32[128]{0} subtract(div.35, div.36)
  mul.127 = f32[128]{0} multiply(mul.126, sub.20)
  div.37 = f32[128]{0} divide(mul.127, broadcast.37)
  sub.22 = f32[128]{0} subtract(sub.21, div.37)
  mul.128 = f32[128]{0} multiply(mul.127, sub.20)
  div.38 = f32[128]{0} divide(mul.128, broadcast.37)
  add.66 = f32[128]{0} add(sub.22, div.38)
  mul.129 = f32[128]{0} multiply(mul.128, sub.20)
  constant.63 = f32[] constant(120)
  broadcast.36 = f32[128]{0} broadcast(constant.63), dimensions={}
  div.39 = f32[128]{0} divide(mul.129, broadcast.36)
  sub.23 = f32[128]{0} subtract(add.66, div.39)
  constant.70 = f32[] constant(0)
  jit__where_.42 = f32[128]{0} call(eq.46, sub.23, constant.70), to_apply=_where.15
  constant.52 = s32[] constant(-2)
  broadcast.27 = s32[128]{0} broadcast(constant.52), dimensions={}
  eq.47 = pred[128]{0} compare(convert_element_type.7, broadcast.27), direction=EQ
  constant.62 = f32[] constant(2)
  broadcast.35 = f32[128]{0} broadcast(constant.62), dimensions={}
  div.40 = f32[128]{0} divide(sub.20, broadcast.35)
  neg.2 = f32[128]{0} negate(div.40)
  mul.130 = f32[128]{0} multiply(mul.126, broadcast.35)
  constant.61 = f32[] constant(3)
  broadcast.34 = f32[128]{0} broadcast(constant.61), dimensions={}
  div.41 = f32[128]{0} divide(mul.130, broadcast.34)
  add.67 = f32[128]{0} add(neg.2, div.41)
  div.42 = f32[128]{0} divide(mul.127, broadcast.37)
  sub.24 = f32[128]{0} subtract(add.67, div.42)
  constant.60 = f32[] constant(6)
  broadcast.33 = f32[128]{0} broadcast(constant.60), dimensions={}
  div.43 = f32[128]{0} divide(mul.128, broadcast.33)
  sub.25 = f32[128]{0} subtract(sub.24, div.43)
  div.44 = f32[128]{0} divide(mul.129, broadcast.37)
  add.68 = f32[128]{0} add(sub.25, div.44)
  jit__where_.43 = f32[128]{0} call(eq.47, add.68, constant.70), to_apply=_where.15
  add.76 = f32[128]{0} add(jit__where_.42, jit__where_.43)
  constant.51 = s32[] constant(-3)
  broadcast.26 = s32[128]{0} broadcast(constant.51), dimensions={}
  eq.48 = pred[128]{0} compare(convert_element_type.7, broadcast.26), direction=EQ
  constant.59 = f32[] constant(1)
  sub.19 = f32[128]{0} broadcast(constant.59), dimensions={}
  div.45 = f32[128]{0} divide(sub.20, broadcast.34)
  sub.26 = f32[128]{0} subtract(sub.19, div.45)
  constant.58 = f32[] constant(5)
  broadcast.32 = f32[128]{0} broadcast(constant.58), dimensions={}
  mul.131 = f32[128]{0} multiply(mul.126, broadcast.32)
  constant.57 = f32[] constant(4)
  broadcast.31 = f32[128]{0} broadcast(constant.57), dimensions={}
  div.46 = f32[128]{0} divide(mul.131, broadcast.31)
  sub.27 = f32[128]{0} subtract(sub.26, div.46)
  mul.132 = f32[128]{0} multiply(mul.127, broadcast.32)
  constant.56 = f32[] constant(12)
  broadcast.30 = f32[128]{0} broadcast(constant.56), dimensions={}
  div.47 = f32[128]{0} divide(mul.132, broadcast.30)
  add.69 = f32[128]{0} add(sub.27, div.47)
  div.48 = f32[128]{0} divide(mul.128, broadcast.31)
  add.70 = f32[128]{0} add(add.69, div.48)
  div.49 = f32[128]{0} divide(mul.129, broadcast.30)
  sub.28 = f32[128]{0} subtract(add.70, div.49)
  jit__where_.44 = f32[128]{0} call(eq.48, sub.28, constant.70), to_apply=_where.15
  add.77 = f32[128]{0} add(add.76, jit__where_.44)
  constant.50 = s32[] constant(-4)
  broadcast.25 = s32[128]{0} broadcast(constant.50), dimensions={}
  eq.49 = pred[128]{0} compare(convert_element_type.7, broadcast.25), direction=EQ
  mul.133 = f32[128]{0} multiply(mul.126, broadcast.35)
  div.50 = f32[128]{0} divide(mul.133, broadcast.34)
  add.71 = f32[128]{0} add(sub.20, div.50)
  constant.55 = f32[] constant(7)
  broadcast.29 = f32[128]{0} broadcast(constant.55), dimensions={}
  mul.134 = f32[128]{0} multiply(mul.127, broadcast.29)
  div.51 = f32[128]{0} divide(mul.134, broadcast.30)
  sub.29 = f32[128]{0} subtract(add.71, div.51)
  div.52 = f32[128]{0} divide(mul.128, broadcast.33)
  sub.30 = f32[128]{0} subtract(sub.29, div.52)
  div.53 = f32[128]{0} divide(mul.129, broadcast.30)
  add.72 = f32[128]{0} add(sub.30, div.53)
  jit__where_.45 = f32[128]{0} call(eq.49, add.72, constant.70), to_apply=_where.15
  add.78 = f32[128]{0} add(add.77, jit__where_.45)
  constant.49 = s32[] constant(-5)
  broadcast.24 = s32[128]{0} broadcast(constant.49), dimensions={}
  eq.50 = pred[128]{0} compare(convert_element_type.7, broadcast.24), direction=EQ
  div.54 = f32[128]{0} divide(sub.20, broadcast.31)
  neg.3 = f32[128]{0} negate(div.54)
  div.55 = f32[128]{0} divide(mul.126, broadcast.37)
  sub.31 = f32[128]{0} subtract(neg.3, div.55)
  mul.135 = f32[128]{0} multiply(mul.127, broadcast.29)
  div.56 = f32[128]{0} divide(mul.135, broadcast.37)
  add.73 = f32[128]{0} add(sub.31, div.56)
  div.57 = f32[128]{0} divide(mul.128, broadcast.37)
  add.74 = f32[128]{0} add(add.73, div.57)
  div.58 = f32[128]{0} divide(mul.129, broadcast.37)
  sub.32 = f32[128]{0} subtract(add.74, div.58)
  jit__where_.46 = f32[128]{0} call(eq.50, sub.32, constant.70), to_apply=_where.15
  add.79 = f32[128]{0} add(add.78, jit__where_.46)
  constant.48 = s32[] constant(-6)
  eq.45 = s32[128]{0} broadcast(constant.48), dimensions={}
  eq.51 = pred[128]{0} compare(convert_element_type.7, eq.45), direction=EQ
  constant.54 = f32[] constant(30)
  div.31 = f32[128]{0} broadcast(constant.54), dimensions={}
  div.59 = f32[128]{0} divide(sub.20, div.31)
  div.60 = f32[128]{0} divide(mul.127, broadcast.37)
  sub.33 = f32[128]{0} subtract(div.59, div.60)
  div.61 = f32[128]{0} divide(mul.129, broadcast.36)
  add.75 = f32[128]{0} add(sub.33, div.61)
  jit__where_.47 = f32[128]{0} call(eq.51, add.75, constant.70), to_apply=_where.15
  add.80 = f32[128]{0} add(add.79, jit__where_.47)
  broadcast_in_dim.9 = f32[128,1]{1,0} reshape(add.80)
  mul.136 = f32[128,1]{1,0} broadcast(broadcast_in_dim.9), dimensions={0,1}
  mul.137 = f32[128]{0} reshape(mul.136)
  mul.138 = f32[128,128]{1,0} broadcast(mul.137), dimensions={0}
  constant.68 = s32[] constant(0)
  jit__pad_.1 = f32[128,134]{1,0} call(add.65, constant.68), to_apply=_pad.16
  slice.51 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [6:134]}
  mul.139 = f32[128,128]{1,0} multiply(mul.138, slice.51)
  constant.47 = s32[] constant(0)
  broadcast.23 = s32[128]{0} broadcast(constant.47), dimensions={}
  eq.52 = pred[128]{0} compare(convert_element_type.7, broadcast.23), direction=EQ
  jit__where_.48 = f32[128]{0} call(eq.52, sub.23, constant.70), to_apply=_where.15
  eq.53 = pred[128]{0} compare(convert_element_type.7, broadcast.28), direction=EQ
  jit__where_.49 = f32[128]{0} call(eq.53, add.68, constant.70), to_apply=_where.15
  add.81 = f32[128]{0} add(jit__where_.48, jit__where_.49)
  eq.54 = pred[128]{0} compare(convert_element_type.7, broadcast.27), direction=EQ
  jit__where_.50 = f32[128]{0} call(eq.54, sub.28, constant.70), to_apply=_where.15
  add.82 = f32[128]{0} add(add.81, jit__where_.50)
  eq.55 = pred[128]{0} compare(convert_element_type.7, broadcast.26), direction=EQ
  jit__where_.51 = f32[128]{0} call(eq.55, add.72, constant.70), to_apply=_where.15
  add.83 = f32[128]{0} add(add.82, jit__where_.51)
  eq.56 = pred[128]{0} compare(convert_element_type.7, broadcast.25), direction=EQ
  jit__where_.52 = f32[128]{0} call(eq.56, sub.32, constant.70), to_apply=_where.15
  add.84 = f32[128]{0} add(add.83, jit__where_.52)
  eq.57 = pred[128]{0} compare(convert_element_type.7, broadcast.24), direction=EQ
  jit__where_.53 = f32[128]{0} call(eq.57, add.75, constant.70), to_apply=_where.15
  add.85 = f32[128]{0} add(add.84, jit__where_.53)
  broadcast_in_dim.10 = f32[128,1]{1,0} reshape(add.85)
  mul.140 = f32[128,1]{1,0} broadcast(broadcast_in_dim.10), dimensions={0,1}
  mul.141 = f32[128]{0} reshape(mul.140)
  mul.142 = f32[128,128]{1,0} broadcast(mul.141), dimensions={0}
  slice.52 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [5:133]}
  mul.143 = f32[128,128]{1,0} multiply(mul.142, slice.52)
  add.111 = f32[128,128]{1,0} add(mul.139, mul.143)
  constant.46 = s32[] constant(1)
  broadcast.22 = s32[128]{0} broadcast(constant.46), dimensions={}
  eq.58 = pred[128]{0} compare(convert_element_type.7, broadcast.22), direction=EQ
  jit__where_.54 = f32[128]{0} call(eq.58, sub.23, constant.70), to_apply=_where.15
  eq.59 = pred[128]{0} compare(convert_element_type.7, broadcast.23), direction=EQ
  jit__where_.55 = f32[128]{0} call(eq.59, add.68, constant.70), to_apply=_where.15
  add.86 = f32[128]{0} add(jit__where_.54, jit__where_.55)
  eq.60 = pred[128]{0} compare(convert_element_type.7, broadcast.28), direction=EQ
  jit__where_.56 = f32[128]{0} call(eq.60, sub.28, constant.70), to_apply=_where.15
  add.87 = f32[128]{0} add(add.86, jit__where_.56)
  eq.61 = pred[128]{0} compare(convert_element_type.7, broadcast.27), direction=EQ
  jit__where_.57 = f32[128]{0} call(eq.61, add.72, constant.70), to_apply=_where.15
  add.88 = f32[128]{0} add(add.87, jit__where_.57)
  eq.62 = pred[128]{0} compare(convert_element_type.7, broadcast.26), direction=EQ
  jit__where_.58 = f32[128]{0} call(eq.62, sub.32, constant.70), to_apply=_where.15
  add.89 = f32[128]{0} add(add.88, jit__where_.58)
  eq.63 = pred[128]{0} compare(convert_element_type.7, broadcast.25), direction=EQ
  jit__where_.59 = f32[128]{0} call(eq.63, add.75, constant.70), to_apply=_where.15
  add.90 = f32[128]{0} add(add.89, jit__where_.59)
  broadcast_in_dim.11 = f32[128,1]{1,0} reshape(add.90)
  mul.144 = f32[128,1]{1,0} broadcast(broadcast_in_dim.11), dimensions={0,1}
  mul.145 = f32[128]{0} reshape(mul.144)
  mul.146 = f32[128,128]{1,0} broadcast(mul.145), dimensions={0}
  slice.53 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [4:132]}
  mul.147 = f32[128,128]{1,0} multiply(mul.146, slice.53)
  add.112 = f32[128,128]{1,0} add(add.111, mul.147)
  constant.45 = s32[] constant(2)
  broadcast.21 = s32[128]{0} broadcast(constant.45), dimensions={}
  eq.64 = pred[128]{0} compare(convert_element_type.7, broadcast.21), direction=EQ
  jit__where_.60 = f32[128]{0} call(eq.64, sub.23, constant.70), to_apply=_where.15
  eq.65 = pred[128]{0} compare(convert_element_type.7, broadcast.22), direction=EQ
  jit__where_.61 = f32[128]{0} call(eq.65, add.68, constant.70), to_apply=_where.15
  add.91 = f32[128]{0} add(jit__where_.60, jit__where_.61)
  eq.66 = pred[128]{0} compare(convert_element_type.7, broadcast.23), direction=EQ
  jit__where_.62 = f32[128]{0} call(eq.66, sub.28, constant.70), to_apply=_where.15
  add.92 = f32[128]{0} add(add.91, jit__where_.62)
  eq.67 = pred[128]{0} compare(convert_element_type.7, broadcast.28), direction=EQ
  jit__where_.63 = f32[128]{0} call(eq.67, add.72, constant.70), to_apply=_where.15
  add.93 = f32[128]{0} add(add.92, jit__where_.63)
  eq.68 = pred[128]{0} compare(convert_element_type.7, broadcast.27), direction=EQ
  jit__where_.64 = f32[128]{0} call(eq.68, sub.32, constant.70), to_apply=_where.15
  add.94 = f32[128]{0} add(add.93, jit__where_.64)
  eq.69 = pred[128]{0} compare(convert_element_type.7, broadcast.26), direction=EQ
  jit__where_.65 = f32[128]{0} call(eq.69, add.75, constant.70), to_apply=_where.15
  add.95 = f32[128]{0} add(add.94, jit__where_.65)
  broadcast_in_dim.12 = f32[128,1]{1,0} reshape(add.95)
  mul.148 = f32[128,1]{1,0} broadcast(broadcast_in_dim.12), dimensions={0,1}
  mul.149 = f32[128]{0} reshape(mul.148)
  mul.150 = f32[128,128]{1,0} broadcast(mul.149), dimensions={0}
  slice.54 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [3:131]}
  mul.151 = f32[128,128]{1,0} multiply(mul.150, slice.54)
  add.113 = f32[128,128]{1,0} add(add.112, mul.151)
  constant.44 = s32[] constant(3)
  broadcast.20 = s32[128]{0} broadcast(constant.44), dimensions={}
  eq.70 = pred[128]{0} compare(convert_element_type.7, broadcast.20), direction=EQ
  jit__where_.66 = f32[128]{0} call(eq.70, sub.23, constant.70), to_apply=_where.15
  eq.71 = pred[128]{0} compare(convert_element_type.7, broadcast.21), direction=EQ
  jit__where_.67 = f32[128]{0} call(eq.71, add.68, constant.70), to_apply=_where.15
  add.96 = f32[128]{0} add(jit__where_.66, jit__where_.67)
  eq.72 = pred[128]{0} compare(convert_element_type.7, broadcast.22), direction=EQ
  jit__where_.68 = f32[128]{0} call(eq.72, sub.28, constant.70), to_apply=_where.15
  add.97 = f32[128]{0} add(add.96, jit__where_.68)
  eq.73 = pred[128]{0} compare(convert_element_type.7, broadcast.23), direction=EQ
  jit__where_.69 = f32[128]{0} call(eq.73, add.72, constant.70), to_apply=_where.15
  add.98 = f32[128]{0} add(add.97, jit__where_.69)
  eq.74 = pred[128]{0} compare(convert_element_type.7, broadcast.28), direction=EQ
  jit__where_.70 = f32[128]{0} call(eq.74, sub.32, constant.70), to_apply=_where.15
  add.99 = f32[128]{0} add(add.98, jit__where_.70)
  eq.75 = pred[128]{0} compare(convert_element_type.7, broadcast.27), direction=EQ
  jit__where_.71 = f32[128]{0} call(eq.75, add.75, constant.70), to_apply=_where.15
  add.100 = f32[128]{0} add(add.99, jit__where_.71)
  broadcast_in_dim.13 = f32[128,1]{1,0} reshape(add.100)
  mul.152 = f32[128,1]{1,0} broadcast(broadcast_in_dim.13), dimensions={0,1}
  mul.153 = f32[128]{0} reshape(mul.152)
  mul.154 = f32[128,128]{1,0} broadcast(mul.153), dimensions={0}
  slice.55 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [2:130]}
  mul.155 = f32[128,128]{1,0} multiply(mul.154, slice.55)
  add.114 = f32[128,128]{1,0} add(add.113, mul.155)
  constant.43 = s32[] constant(4)
  broadcast.19 = s32[128]{0} broadcast(constant.43), dimensions={}
  eq.76 = pred[128]{0} compare(convert_element_type.7, broadcast.19), direction=EQ
  jit__where_.72 = f32[128]{0} call(eq.76, sub.23, constant.70), to_apply=_where.15
  eq.77 = pred[128]{0} compare(convert_element_type.7, broadcast.20), direction=EQ
  jit__where_.73 = f32[128]{0} call(eq.77, add.68, constant.70), to_apply=_where.15
  add.101 = f32[128]{0} add(jit__where_.72, jit__where_.73)
  eq.78 = pred[128]{0} compare(convert_element_type.7, broadcast.21), direction=EQ
  jit__where_.74 = f32[128]{0} call(eq.78, sub.28, constant.70), to_apply=_where.15
  add.102 = f32[128]{0} add(add.101, jit__where_.74)
  eq.79 = pred[128]{0} compare(convert_element_type.7, broadcast.22), direction=EQ
  jit__where_.75 = f32[128]{0} call(eq.79, add.72, constant.70), to_apply=_where.15
  add.103 = f32[128]{0} add(add.102, jit__where_.75)
  eq.80 = pred[128]{0} compare(convert_element_type.7, broadcast.23), direction=EQ
  jit__where_.76 = f32[128]{0} call(eq.80, sub.32, constant.70), to_apply=_where.15
  add.104 = f32[128]{0} add(add.103, jit__where_.76)
  eq.81 = pred[128]{0} compare(convert_element_type.7, broadcast.28), direction=EQ
  jit__where_.77 = f32[128]{0} call(eq.81, add.75, constant.70), to_apply=_where.15
  add.105 = f32[128]{0} add(add.104, jit__where_.77)
  broadcast_in_dim.14 = f32[128,1]{1,0} reshape(add.105)
  mul.156 = f32[128,1]{1,0} broadcast(broadcast_in_dim.14), dimensions={0,1}
  mul.157 = f32[128]{0} reshape(mul.156)
  mul.158 = f32[128,128]{1,0} broadcast(mul.157), dimensions={0}
  slice.56 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [1:129]}
  mul.159 = f32[128,128]{1,0} multiply(mul.158, slice.56)
  add.115 = f32[128,128]{1,0} add(add.114, mul.159)
  constant.42 = s32[] constant(5)
  eq.44 = s32[128]{0} broadcast(constant.42), dimensions={}
  eq.82 = pred[128]{0} compare(convert_element_type.7, eq.44), direction=EQ
  jit__where_.78 = f32[128]{0} call(eq.82, sub.23, constant.70), to_apply=_where.15
  eq.83 = pred[128]{0} compare(convert_element_type.7, broadcast.19), direction=EQ
  jit__where_.79 = f32[128]{0} call(eq.83, add.68, constant.70), to_apply=_where.15
  add.106 = f32[128]{0} add(jit__where_.78, jit__where_.79)
  eq.84 = pred[128]{0} compare(convert_element_type.7, broadcast.20), direction=EQ
  jit__where_.80 = f32[128]{0} call(eq.84, sub.28, constant.70), to_apply=_where.15
  add.107 = f32[128]{0} add(add.106, jit__where_.80)
  eq.85 = pred[128]{0} compare(convert_element_type.7, broadcast.21), direction=EQ
  jit__where_.81 = f32[128]{0} call(eq.85, add.72, constant.70), to_apply=_where.15
  add.108 = f32[128]{0} add(add.107, jit__where_.81)
  eq.86 = pred[128]{0} compare(convert_element_type.7, broadcast.22), direction=EQ
  jit__where_.82 = f32[128]{0} call(eq.86, sub.32, constant.70), to_apply=_where.15
  add.109 = f32[128]{0} add(add.108, jit__where_.82)
  eq.87 = pred[128]{0} compare(convert_element_type.7, broadcast.23), direction=EQ
  jit__where_.83 = f32[128]{0} call(eq.87, add.75, constant.70), to_apply=_where.15
  add.110 = f32[128]{0} add(add.109, jit__where_.83)
  broadcast_in_dim.15 = f32[128,1]{1,0} reshape(add.110)
  mul.160 = f32[128,1]{1,0} broadcast(broadcast_in_dim.15), dimensions={0,1}
  mul.161 = f32[128]{0} reshape(mul.160)
  mul.162 = f32[128,128]{1,0} broadcast(mul.161), dimensions={0}
  slice.57 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [0:128]}
  mul.163 = f32[128,128]{1,0} multiply(mul.162, slice.57)
  add.116 = f32[128,128]{1,0} add(add.115, mul.163)
  slice.58 = f32[128,14]{1,0} slice(add.116), slice={[0:128], [0:14]}
  jit__roll_static_.30 = f32[128,14]{1,0} call(slice.58), to_apply=_roll_static.1
  slice.59 = f32[128,50]{1,0} slice(add.116), slice={[0:128], [14:64]}
  jit__roll_static_.31 = f32[128,50]{1,0} call(slice.59), to_apply=_roll_static_6.2
  slice.60 = f32[128,50]{1,0} slice(add.116), slice={[0:128], [64:114]}
  jit__roll_static_.32 = f32[128,50]{1,0} call(slice.60), to_apply=_roll_static_11.3
  slice.61 = f32[128,14]{1,0} slice(add.116), slice={[0:128], [114:128]}
  jit__roll_static_.33 = f32[128,14]{1,0} call(slice.61), to_apply=_roll_static_16.4
  concatenate.19 = f32[128,128]{1,0} concatenate(jit__roll_static_.30, jit__roll_static_.31, jit__roll_static_.32, jit__roll_static_.33), dimensions={1}
  jit__roll_static_.34 = f32[128,128]{1,0} call(concatenate.19), to_apply=_roll_static_22.5
  mul.164 = f32[1,128]{1,0} broadcast(constant.72), dimensions={0,1}
  mul.165 = f32[128]{0} reshape(mul.164)
  mul.166 = f32[128,128]{1,0} broadcast(mul.165), dimensions={1}
  mul.167 = f32[128,128]{1,0} multiply(jit__roll_static_.34, mul.166)
  jit__roll_static_.35 = f32[128,128]{1,0} call(concatenate.19), to_apply=_roll_static_29.6
  mul.168 = f32[1,128]{1,0} broadcast(constant.73), dimensions={0,1}
  mul.169 = f32[128]{0} reshape(mul.168)
  mul.170 = f32[128,128]{1,0} broadcast(mul.169), dimensions={1}
  mul.171 = f32[128,128]{1,0} multiply(jit__roll_static_.35, mul.170)
  add.117 = f32[128,128]{1,0} add(mul.167, mul.171)
  jit__roll_static_.36 = f32[128,128]{1,0} call(concatenate.19), to_apply=_roll_static_34.7
  mul.172 = f32[1,128]{1,0} broadcast(constant.74), dimensions={0,1}
  mul.173 = f32[128]{0} reshape(mul.172)
  mul.174 = f32[128,128]{1,0} broadcast(mul.173), dimensions={1}
  mul.175 = f32[128,128]{1,0} multiply(jit__roll_static_.36, mul.174)
  add.118 = f32[128,128]{1,0} add(add.117, mul.175)
  jit__roll_static_.37 = f32[128,128]{1,0} call(concatenate.19), to_apply=_roll_static_39.8
  mul.176 = f32[1,128]{1,0} broadcast(constant.75), dimensions={0,1}
  mul.177 = f32[128]{0} reshape(mul.176)
  mul.178 = f32[128,128]{1,0} broadcast(mul.177), dimensions={1}
  mul.179 = f32[128,128]{1,0} multiply(jit__roll_static_.37, mul.178)
  add.119 = f32[128,128]{1,0} add(add.118, mul.179)
  jit__roll_static_.38 = f32[128,128]{1,0} call(concatenate.19), to_apply=_roll_static_44.9
  mul.180 = f32[1,128]{1,0} broadcast(constant.76), dimensions={0,1}
  mul.181 = f32[128]{0} reshape(mul.180)
  mul.182 = f32[128,128]{1,0} broadcast(mul.181), dimensions={1}
  mul.183 = f32[128,128]{1,0} multiply(jit__roll_static_.38, mul.182)
  add.120 = f32[128,128]{1,0} add(add.119, mul.183)
  jit__roll_static_.39 = f32[128,128]{1,0} call(concatenate.19), to_apply=_roll_static_49.10
  mul.184 = f32[1,128]{1,0} broadcast(constant.77), dimensions={0,1}
  mul.185 = f32[128]{0} reshape(mul.184)
  mul.186 = f32[128,128]{1,0} broadcast(mul.185), dimensions={1}
  mul.187 = f32[128,128]{1,0} multiply(jit__roll_static_.39, mul.186)
  add.121 = f32[128,128]{1,0} add(add.120, mul.187)
  jit_solve_poisson_.6 = f32[128]{0} get-tuple-element(jit_solve_poisson_.4), index=1
  jit_solve_poisson_.7 = f32[128]{0} get-tuple-element(jit_solve_poisson_.4), index=2
  ROOT tuple.3 = (f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) tuple(add.121, jit_solve_poisson_.6, jit_solve_poisson_.7)
}

