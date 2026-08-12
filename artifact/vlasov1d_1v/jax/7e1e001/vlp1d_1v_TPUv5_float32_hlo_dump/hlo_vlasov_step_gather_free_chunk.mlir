HloModule jit_run_chunk, entry_computation_layout={(f32[128]{0}, f32[128]{0}, f32[65]{0}, s32[6]{0}, f32[128]{0}, /*index=5*/f32[128]{0}, f32[128,128]{1,0}, f32[128]{0}, f32[], s32[])->(f32[128]{0}, f32[128]{0}, f32[65]{0}, s32[6]{0}, f32[128]{0}, /*index=5*/f32[128]{0}, f32[128,128]{1,0}, f32[128]{0}, f32[], s32[])}

_roll_static.1 {
  Arg_0.2 = f32[128,14]{1,0} parameter(0)
  slice.3 = f32[126,14]{1,0} slice(Arg_0.2), slice={[2:128], [0:14]}
  slice.4 = f32[2,14]{1,0} slice(Arg_0.2), slice={[0:2], [0:14]}
  ROOT concatenate.1 = f32[128,14]{1,0} concatenate(slice.3, slice.4), dimensions={0}
}

_roll_static_6.2 {
  Arg_0.4 = f32[128,50]{1,0} parameter(0)
  slice.8 = f32[127,50]{1,0} slice(Arg_0.4), slice={[1:128], [0:50]}
  slice.9 = f32[1,50]{1,0} slice(Arg_0.4), slice={[0:1], [0:50]}
  ROOT concatenate.3 = f32[128,50]{1,0} concatenate(slice.8, slice.9), dimensions={0}
}

_roll_static_11.3 {
  ROOT Arg_0.6 = f32[128,50]{1,0} parameter(0)
}

_roll_static_16.4 {
  Arg_0.8 = f32[128,14]{1,0} parameter(0)
  slice.14 = f32[1,14]{1,0} slice(Arg_0.8), slice={[127:128], [0:14]}
  slice.15 = f32[127,14]{1,0} slice(Arg_0.8), slice={[0:127], [0:14]}
  ROOT concatenate.5 = f32[128,14]{1,0} concatenate(slice.14, slice.15), dimensions={0}
}

_roll_static_22.5 {
  Arg_0.10 = f32[128,128]{1,0} parameter(0)
  slice.18 = f32[126,128]{1,0} slice(Arg_0.10), slice={[2:128], [0:128]}
  slice.19 = f32[2,128]{1,0} slice(Arg_0.10), slice={[0:2], [0:128]}
  ROOT concatenate.8 = f32[128,128]{1,0} concatenate(slice.18, slice.19), dimensions={0}
}

_roll_static_29.6 {
  Arg_0.12 = f32[128,128]{1,0} parameter(0)
  slice.22 = f32[127,128]{1,0} slice(Arg_0.12), slice={[1:128], [0:128]}
  slice.23 = f32[1,128]{1,0} slice(Arg_0.12), slice={[0:1], [0:128]}
  ROOT concatenate.10 = f32[128,128]{1,0} concatenate(slice.22, slice.23), dimensions={0}
}

_roll_static_34.7 {
  ROOT Arg_0.14 = f32[128,128]{1,0} parameter(0)
}

_roll_static_39.8 {
  Arg_0.16 = f32[128,128]{1,0} parameter(0)
  slice.26 = f32[1,128]{1,0} slice(Arg_0.16), slice={[127:128], [0:128]}
  slice.27 = f32[127,128]{1,0} slice(Arg_0.16), slice={[0:127], [0:128]}
  ROOT concatenate.12 = f32[128,128]{1,0} concatenate(slice.26, slice.27), dimensions={0}
}

_roll_static_44.9 {
  Arg_0.18 = f32[128,128]{1,0} parameter(0)
  slice.30 = f32[2,128]{1,0} slice(Arg_0.18), slice={[126:128], [0:128]}
  slice.31 = f32[126,128]{1,0} slice(Arg_0.18), slice={[0:126], [0:128]}
  ROOT concatenate.14 = f32[128,128]{1,0} concatenate(slice.30, slice.31), dimensions={0}
}

_roll_static_49.10 {
  Arg_0.20 = f32[128,128]{1,0} parameter(0)
  slice.34 = f32[3,128]{1,0} slice(Arg_0.20), slice={[125:128], [0:128]}
  slice.35 = f32[125,128]{1,0} slice(Arg_0.20), slice={[0:125], [0:128]}
  ROOT concatenate.16 = f32[128,128]{1,0} concatenate(slice.34, slice.35), dimensions={0}
}

region_1.11 {
  reduce_sum.3 = f32[] parameter(0)
  reduce_sum.4 = f32[] parameter(1)
  ROOT reduce_sum.5 = f32[] add(reduce_sum.3, reduce_sum.4)
}

fft.12 {
  Arg_0.23 = f32[128]{0} parameter(0)
  ROOT fft.1 = c64[65]{0} fft(Arg_0.23), fft_type=RFFT, fft_length={128}
}

fft_60.13 {
  Arg_0.25 = c64[65]{0} parameter(0)
  ROOT fft.3 = f32[128]{0} fft(Arg_0.25), fft_type=IRFFT, fft_length={128}
}

solve_poisson.14 {
  Arg_0.26 = f32[128,128]{1,0} parameter(0)
  constant.40 = f32[] constant(0)
  reduce_sum.7 = f32[128]{0} reduce(Arg_0.26, constant.40), dimensions={1}, to_apply=region_1.11
  Arg_2.2 = f32[] parameter(2)
  mul.42 = f32[128]{0} broadcast(Arg_2.2), dimensions={}
  mul.43 = f32[128]{0} multiply(reduce_sum.7, mul.42)
  constant.39 = f32[] constant(1)
  sub.15 = f32[128]{0} broadcast(constant.39), dimensions={}
  sub.16 = f32[128]{0} subtract(mul.43, sub.15)
  jit_fft_.3 = c64[65]{0} call(sub.16), to_apply=fft.12
  constant.38 = c64[] constant((-0, -1))
  mul.41 = c64[65]{0} broadcast(constant.38), dimensions={}
  mul.44 = c64[65]{0} multiply(jit_fft_.3, mul.41)
  Arg_1.2 = f32[65]{0} parameter(1)
  convert_element_type.2 = c64[65]{0} convert(Arg_1.2)
  mul.45 = c64[65]{0} multiply(mul.44, convert_element_type.2)
  jit_fft_.4 = f32[128]{0} call(mul.45), to_apply=fft_60.13
  integer_pow.1 = f32[65]{0} multiply(Arg_1.2, Arg_1.2)
  convert_element_type.3 = c64[65]{0} convert(integer_pow.1)
  mul.46 = c64[65]{0} multiply(jit_fft_.3, convert_element_type.3)
  jit_fft_.5 = f32[128]{0} call(mul.46), to_apply=fft_60.13
  ROOT tuple.1 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) tuple(jit_fft_.4, sub.16, jit_fft_.5)
}

_where.15 {
  Arg_0.28 = pred[128]{0} parameter(0)
  Arg_1.4 = f32[128]{0} parameter(1)
  Arg_2.4 = f32[] parameter(2)
  broadcast_in_dim.7 = f32[128]{0} broadcast(Arg_2.4), dimensions={}
  ROOT select_n.1 = f32[128]{0} select(Arg_0.28, Arg_1.4, broadcast_in_dim.7)
}

_pad.16 {
  Arg_0.30 = f32[128,128]{1,0} parameter(0)
  Arg_1.6 = s32[] parameter(1)
  convert_element_type.6 = f32[] convert(Arg_1.6)
  ROOT pad.1 = f32[128,134]{1,0} pad(Arg_0.30, convert_element_type.6), padding=0_0x3_3
}

closed_call.17 {
  Arg_3.1 = f32[128]{0} parameter(3)
  Arg_4.1 = f32[128]{0} parameter(4)
  Arg_2.5 = f32[128,128]{1,0} parameter(2)
  slice.47 = f32[128,14]{1,0} slice(Arg_2.5), slice={[0:128], [0:14]}
  jit__roll_static_.20 = f32[128,14]{1,0} call(slice.47), to_apply=_roll_static.1
  slice.48 = f32[128,50]{1,0} slice(Arg_2.5), slice={[0:128], [14:64]}
  jit__roll_static_.21 = f32[128,50]{1,0} call(slice.48), to_apply=_roll_static_6.2
  slice.49 = f32[128,50]{1,0} slice(Arg_2.5), slice={[0:128], [64:114]}
  jit__roll_static_.22 = f32[128,50]{1,0} call(slice.49), to_apply=_roll_static_11.3
  slice.50 = f32[128,14]{1,0} slice(Arg_2.5), slice={[0:128], [114:128]}
  jit__roll_static_.23 = f32[128,14]{1,0} call(slice.50), to_apply=_roll_static_16.4
  concatenate.18 = f32[128,128]{1,0} concatenate(jit__roll_static_.20, jit__roll_static_.21, jit__roll_static_.22, jit__roll_static_.23), dimensions={1}
  jit__roll_static_.24 = f32[128,128]{1,0} call(concatenate.18), to_apply=_roll_static_22.5
  Arg_0.31 = f32[128]{0} parameter(0)
  constant.66 = f32[] constant(20)
  broadcast.43 = f32[128]{0} broadcast(constant.66), dimensions={}
  div.57 = f32[128]{0} divide(Arg_0.31, broadcast.43)
  mul.111 = f32[128]{0} multiply(Arg_0.31, Arg_0.31)
  constant.65 = f32[] constant(24)
  broadcast.42 = f32[128]{0} broadcast(constant.65), dimensions={}
  div.58 = f32[128]{0} divide(mul.111, broadcast.42)
  sub.31 = f32[128]{0} subtract(div.57, div.58)
  mul.112 = f32[128]{0} multiply(mul.111, Arg_0.31)
  div.59 = f32[128]{0} divide(mul.112, broadcast.42)
  sub.32 = f32[128]{0} subtract(sub.31, div.59)
  mul.113 = f32[128]{0} multiply(mul.112, Arg_0.31)
  div.60 = f32[128]{0} divide(mul.113, broadcast.42)
  add.71 = f32[128]{0} add(sub.32, div.60)
  mul.114 = f32[128]{0} multiply(mul.113, Arg_0.31)
  constant.64 = f32[] constant(120)
  broadcast.41 = f32[128]{0} broadcast(constant.64), dimensions={}
  div.61 = f32[128]{0} divide(mul.114, broadcast.41)
  sub.33 = f32[128]{0} subtract(add.71, div.61)
  broadcast_in_dim.21 = f32[1,128]{1,0} reshape(sub.33)
  mul.121 = f32[1,128]{1,0} broadcast(broadcast_in_dim.21), dimensions={0,1}
  mul.122 = f32[128]{0} reshape(mul.121)
  mul.123 = f32[128,128]{1,0} broadcast(mul.122), dimensions={1}
  mul.124 = f32[128,128]{1,0} multiply(jit__roll_static_.24, mul.123)
  jit__roll_static_.25 = f32[128,128]{1,0} call(concatenate.18), to_apply=_roll_static_29.6
  constant.63 = f32[] constant(2)
  broadcast.40 = f32[128]{0} broadcast(constant.63), dimensions={}
  div.62 = f32[128]{0} divide(Arg_0.31, broadcast.40)
  neg.4 = f32[128]{0} negate(div.62)
  mul.115 = f32[128]{0} multiply(mul.111, broadcast.40)
  constant.62 = f32[] constant(3)
  broadcast.39 = f32[128]{0} broadcast(constant.62), dimensions={}
  div.63 = f32[128]{0} divide(mul.115, broadcast.39)
  add.72 = f32[128]{0} add(neg.4, div.63)
  div.64 = f32[128]{0} divide(mul.112, broadcast.42)
  sub.34 = f32[128]{0} subtract(add.72, div.64)
  constant.61 = f32[] constant(6)
  broadcast.38 = f32[128]{0} broadcast(constant.61), dimensions={}
  div.65 = f32[128]{0} divide(mul.113, broadcast.38)
  sub.35 = f32[128]{0} subtract(sub.34, div.65)
  div.66 = f32[128]{0} divide(mul.114, broadcast.42)
  add.73 = f32[128]{0} add(sub.35, div.66)
  broadcast_in_dim.22 = f32[1,128]{1,0} reshape(add.73)
  mul.125 = f32[1,128]{1,0} broadcast(broadcast_in_dim.22), dimensions={0,1}
  mul.126 = f32[128]{0} reshape(mul.125)
  mul.127 = f32[128,128]{1,0} broadcast(mul.126), dimensions={1}
  mul.128 = f32[128,128]{1,0} multiply(jit__roll_static_.25, mul.127)
  add.81 = f32[128,128]{1,0} add(mul.124, mul.128)
  jit__roll_static_.26 = f32[128,128]{1,0} call(concatenate.18), to_apply=_roll_static_34.7
  constant.60 = f32[] constant(1)
  broadcast.37 = f32[128]{0} broadcast(constant.60), dimensions={}
  div.67 = f32[128]{0} divide(Arg_0.31, broadcast.39)
  sub.36 = f32[128]{0} subtract(broadcast.37, div.67)
  constant.59 = f32[] constant(5)
  broadcast.36 = f32[128]{0} broadcast(constant.59), dimensions={}
  mul.116 = f32[128]{0} multiply(mul.111, broadcast.36)
  constant.58 = f32[] constant(4)
  broadcast.35 = f32[128]{0} broadcast(constant.58), dimensions={}
  div.68 = f32[128]{0} divide(mul.116, broadcast.35)
  sub.37 = f32[128]{0} subtract(sub.36, div.68)
  mul.117 = f32[128]{0} multiply(mul.112, broadcast.36)
  constant.57 = f32[] constant(12)
  broadcast.34 = f32[128]{0} broadcast(constant.57), dimensions={}
  div.69 = f32[128]{0} divide(mul.117, broadcast.34)
  add.74 = f32[128]{0} add(sub.37, div.69)
  div.70 = f32[128]{0} divide(mul.113, broadcast.35)
  add.75 = f32[128]{0} add(add.74, div.70)
  div.71 = f32[128]{0} divide(mul.114, broadcast.34)
  sub.38 = f32[128]{0} subtract(add.75, div.71)
  broadcast_in_dim.23 = f32[1,128]{1,0} reshape(sub.38)
  mul.129 = f32[1,128]{1,0} broadcast(broadcast_in_dim.23), dimensions={0,1}
  mul.130 = f32[128]{0} reshape(mul.129)
  mul.131 = f32[128,128]{1,0} broadcast(mul.130), dimensions={1}
  mul.132 = f32[128,128]{1,0} multiply(jit__roll_static_.26, mul.131)
  add.82 = f32[128,128]{1,0} add(add.81, mul.132)
  jit__roll_static_.27 = f32[128,128]{1,0} call(concatenate.18), to_apply=_roll_static_39.8
  mul.118 = f32[128]{0} multiply(mul.111, broadcast.40)
  div.72 = f32[128]{0} divide(mul.118, broadcast.39)
  add.76 = f32[128]{0} add(Arg_0.31, div.72)
  constant.56 = f32[] constant(7)
  broadcast.33 = f32[128]{0} broadcast(constant.56), dimensions={}
  mul.119 = f32[128]{0} multiply(mul.112, broadcast.33)
  div.73 = f32[128]{0} divide(mul.119, broadcast.34)
  sub.39 = f32[128]{0} subtract(add.76, div.73)
  div.74 = f32[128]{0} divide(mul.113, broadcast.38)
  sub.40 = f32[128]{0} subtract(sub.39, div.74)
  div.75 = f32[128]{0} divide(mul.114, broadcast.34)
  add.77 = f32[128]{0} add(sub.40, div.75)
  broadcast_in_dim.24 = f32[1,128]{1,0} reshape(add.77)
  mul.133 = f32[1,128]{1,0} broadcast(broadcast_in_dim.24), dimensions={0,1}
  mul.134 = f32[128]{0} reshape(mul.133)
  mul.135 = f32[128,128]{1,0} broadcast(mul.134), dimensions={1}
  mul.136 = f32[128,128]{1,0} multiply(jit__roll_static_.27, mul.135)
  add.83 = f32[128,128]{1,0} add(add.82, mul.136)
  jit__roll_static_.28 = f32[128,128]{1,0} call(concatenate.18), to_apply=_roll_static_44.9
  div.76 = f32[128]{0} divide(Arg_0.31, broadcast.35)
  neg.5 = f32[128]{0} negate(div.76)
  div.77 = f32[128]{0} divide(mul.111, broadcast.42)
  sub.41 = f32[128]{0} subtract(neg.5, div.77)
  mul.120 = f32[128]{0} multiply(mul.112, broadcast.33)
  div.78 = f32[128]{0} divide(mul.120, broadcast.42)
  add.78 = f32[128]{0} add(sub.41, div.78)
  div.79 = f32[128]{0} divide(mul.113, broadcast.42)
  add.79 = f32[128]{0} add(add.78, div.79)
  div.80 = f32[128]{0} divide(mul.114, broadcast.42)
  sub.42 = f32[128]{0} subtract(add.79, div.80)
  broadcast_in_dim.25 = f32[1,128]{1,0} reshape(sub.42)
  mul.137 = f32[1,128]{1,0} broadcast(broadcast_in_dim.25), dimensions={0,1}
  mul.138 = f32[128]{0} reshape(mul.137)
  mul.139 = f32[128,128]{1,0} broadcast(mul.138), dimensions={1}
  mul.140 = f32[128,128]{1,0} multiply(jit__roll_static_.28, mul.139)
  add.84 = f32[128,128]{1,0} add(add.83, mul.140)
  jit__roll_static_.29 = f32[128,128]{1,0} call(concatenate.18), to_apply=_roll_static_49.10
  constant.55 = f32[] constant(30)
  broadcast.32 = f32[128]{0} broadcast(constant.55), dimensions={}
  div.81 = f32[128]{0} divide(Arg_0.31, broadcast.32)
  div.82 = f32[128]{0} divide(mul.112, broadcast.42)
  sub.43 = f32[128]{0} subtract(div.81, div.82)
  div.83 = f32[128]{0} divide(mul.114, broadcast.41)
  add.80 = f32[128]{0} add(sub.43, div.83)
  broadcast_in_dim.26 = f32[1,128]{1,0} reshape(add.80)
  mul.141 = f32[1,128]{1,0} broadcast(broadcast_in_dim.26), dimensions={0,1}
  mul.142 = f32[128]{0} reshape(mul.141)
  mul.143 = f32[128,128]{1,0} broadcast(mul.142), dimensions={1}
  mul.144 = f32[128,128]{1,0} multiply(jit__roll_static_.29, mul.143)
  add.85 = f32[128,128]{1,0} add(add.84, mul.144)
  Arg_1.7 = f32[65]{0} parameter(1)
  constant.68 = f32[] constant(0.0787401572)
  jit_solve_poisson_.4 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) call(add.85, Arg_1.7, constant.68), to_apply=solve_poisson.14
  jit_solve_poisson_.5 = f32[128]{0} get-tuple-element(jit_solve_poisson_.4), index=0
  constant.54 = f32[] constant(0.05)
  mul.110 = f32[128]{0} broadcast(constant.54), dimensions={}
  mul.145 = f32[128]{0} multiply(jit_solve_poisson_.5, mul.110)
  constant.53 = f32[] constant(0.0787401572)
  div.56 = f32[128]{0} broadcast(constant.53), dimensions={}
  div.84 = f32[128]{0} divide(mul.145, div.56)
  floor.1 = f32[128]{0} floor(div.84)
  convert_element_type.7 = s32[128]{0} convert(floor.1)
  constant.52 = s32[] constant(-1)
  broadcast.31 = s32[128]{0} broadcast(constant.52), dimensions={}
  eq.46 = pred[128]{0} compare(convert_element_type.7, broadcast.31), direction=EQ
  sub.44 = f32[128]{0} subtract(div.84, floor.1)
  div.85 = f32[128]{0} divide(sub.44, broadcast.43)
  mul.146 = f32[128]{0} multiply(sub.44, sub.44)
  div.86 = f32[128]{0} divide(mul.146, broadcast.42)
  sub.45 = f32[128]{0} subtract(div.85, div.86)
  mul.147 = f32[128]{0} multiply(mul.146, sub.44)
  div.87 = f32[128]{0} divide(mul.147, broadcast.42)
  sub.46 = f32[128]{0} subtract(sub.45, div.87)
  mul.148 = f32[128]{0} multiply(mul.147, sub.44)
  div.88 = f32[128]{0} divide(mul.148, broadcast.42)
  add.86 = f32[128]{0} add(sub.46, div.88)
  mul.149 = f32[128]{0} multiply(mul.148, sub.44)
  div.89 = f32[128]{0} divide(mul.149, broadcast.41)
  sub.47 = f32[128]{0} subtract(add.86, div.89)
  constant.69 = f32[] constant(0)
  jit__where_.42 = f32[128]{0} call(eq.46, sub.47, constant.69), to_apply=_where.15
  constant.51 = s32[] constant(-2)
  broadcast.30 = s32[128]{0} broadcast(constant.51), dimensions={}
  eq.47 = pred[128]{0} compare(convert_element_type.7, broadcast.30), direction=EQ
  div.90 = f32[128]{0} divide(sub.44, broadcast.40)
  neg.6 = f32[128]{0} negate(div.90)
  mul.150 = f32[128]{0} multiply(mul.146, broadcast.40)
  div.91 = f32[128]{0} divide(mul.150, broadcast.39)
  add.87 = f32[128]{0} add(neg.6, div.91)
  div.92 = f32[128]{0} divide(mul.147, broadcast.42)
  sub.48 = f32[128]{0} subtract(add.87, div.92)
  div.93 = f32[128]{0} divide(mul.148, broadcast.38)
  sub.49 = f32[128]{0} subtract(sub.48, div.93)
  div.94 = f32[128]{0} divide(mul.149, broadcast.42)
  add.88 = f32[128]{0} add(sub.49, div.94)
  jit__where_.43 = f32[128]{0} call(eq.47, add.88, constant.69), to_apply=_where.15
  add.96 = f32[128]{0} add(jit__where_.42, jit__where_.43)
  constant.50 = s32[] constant(-3)
  broadcast.29 = s32[128]{0} broadcast(constant.50), dimensions={}
  eq.48 = pred[128]{0} compare(convert_element_type.7, broadcast.29), direction=EQ
  div.95 = f32[128]{0} divide(sub.44, broadcast.39)
  sub.50 = f32[128]{0} subtract(broadcast.37, div.95)
  mul.151 = f32[128]{0} multiply(mul.146, broadcast.36)
  div.96 = f32[128]{0} divide(mul.151, broadcast.35)
  sub.51 = f32[128]{0} subtract(sub.50, div.96)
  mul.152 = f32[128]{0} multiply(mul.147, broadcast.36)
  div.97 = f32[128]{0} divide(mul.152, broadcast.34)
  add.89 = f32[128]{0} add(sub.51, div.97)
  div.98 = f32[128]{0} divide(mul.148, broadcast.35)
  add.90 = f32[128]{0} add(add.89, div.98)
  div.99 = f32[128]{0} divide(mul.149, broadcast.34)
  sub.52 = f32[128]{0} subtract(add.90, div.99)
  jit__where_.44 = f32[128]{0} call(eq.48, sub.52, constant.69), to_apply=_where.15
  add.97 = f32[128]{0} add(add.96, jit__where_.44)
  constant.49 = s32[] constant(-4)
  broadcast.28 = s32[128]{0} broadcast(constant.49), dimensions={}
  eq.49 = pred[128]{0} compare(convert_element_type.7, broadcast.28), direction=EQ
  mul.153 = f32[128]{0} multiply(mul.146, broadcast.40)
  div.100 = f32[128]{0} divide(mul.153, broadcast.39)
  add.91 = f32[128]{0} add(sub.44, div.100)
  mul.154 = f32[128]{0} multiply(mul.147, broadcast.33)
  div.101 = f32[128]{0} divide(mul.154, broadcast.34)
  sub.53 = f32[128]{0} subtract(add.91, div.101)
  div.102 = f32[128]{0} divide(mul.148, broadcast.38)
  sub.54 = f32[128]{0} subtract(sub.53, div.102)
  div.103 = f32[128]{0} divide(mul.149, broadcast.34)
  add.92 = f32[128]{0} add(sub.54, div.103)
  jit__where_.45 = f32[128]{0} call(eq.49, add.92, constant.69), to_apply=_where.15
  add.98 = f32[128]{0} add(add.97, jit__where_.45)
  constant.48 = s32[] constant(-5)
  broadcast.27 = s32[128]{0} broadcast(constant.48), dimensions={}
  eq.50 = pred[128]{0} compare(convert_element_type.7, broadcast.27), direction=EQ
  div.104 = f32[128]{0} divide(sub.44, broadcast.35)
  neg.7 = f32[128]{0} negate(div.104)
  div.105 = f32[128]{0} divide(mul.146, broadcast.42)
  sub.55 = f32[128]{0} subtract(neg.7, div.105)
  mul.155 = f32[128]{0} multiply(mul.147, broadcast.33)
  div.106 = f32[128]{0} divide(mul.155, broadcast.42)
  add.93 = f32[128]{0} add(sub.55, div.106)
  div.107 = f32[128]{0} divide(mul.148, broadcast.42)
  add.94 = f32[128]{0} add(add.93, div.107)
  div.108 = f32[128]{0} divide(mul.149, broadcast.42)
  sub.56 = f32[128]{0} subtract(add.94, div.108)
  jit__where_.46 = f32[128]{0} call(eq.50, sub.56, constant.69), to_apply=_where.15
  add.99 = f32[128]{0} add(add.98, jit__where_.46)
  constant.47 = s32[] constant(-6)
  eq.45 = s32[128]{0} broadcast(constant.47), dimensions={}
  eq.51 = pred[128]{0} compare(convert_element_type.7, eq.45), direction=EQ
  div.109 = f32[128]{0} divide(sub.44, broadcast.32)
  div.110 = f32[128]{0} divide(mul.147, broadcast.42)
  sub.57 = f32[128]{0} subtract(div.109, div.110)
  div.111 = f32[128]{0} divide(mul.149, broadcast.41)
  add.95 = f32[128]{0} add(sub.57, div.111)
  jit__where_.47 = f32[128]{0} call(eq.51, add.95, constant.69), to_apply=_where.15
  add.100 = f32[128]{0} add(add.99, jit__where_.47)
  broadcast_in_dim.27 = f32[128,1]{1,0} reshape(add.100)
  mul.156 = f32[128,1]{1,0} broadcast(broadcast_in_dim.27), dimensions={0,1}
  mul.157 = f32[128]{0} reshape(mul.156)
  mul.158 = f32[128,128]{1,0} broadcast(mul.157), dimensions={0}
  constant.67 = s32[] constant(0)
  jit__pad_.1 = f32[128,134]{1,0} call(add.85, constant.67), to_apply=_pad.16
  slice.51 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [6:134]}
  mul.159 = f32[128,128]{1,0} multiply(mul.158, slice.51)
  constant.46 = s32[] constant(0)
  broadcast.26 = s32[128]{0} broadcast(constant.46), dimensions={}
  eq.52 = pred[128]{0} compare(convert_element_type.7, broadcast.26), direction=EQ
  jit__where_.48 = f32[128]{0} call(eq.52, sub.47, constant.69), to_apply=_where.15
  eq.53 = pred[128]{0} compare(convert_element_type.7, broadcast.31), direction=EQ
  jit__where_.49 = f32[128]{0} call(eq.53, add.88, constant.69), to_apply=_where.15
  add.101 = f32[128]{0} add(jit__where_.48, jit__where_.49)
  eq.54 = pred[128]{0} compare(convert_element_type.7, broadcast.30), direction=EQ
  jit__where_.50 = f32[128]{0} call(eq.54, sub.52, constant.69), to_apply=_where.15
  add.102 = f32[128]{0} add(add.101, jit__where_.50)
  eq.55 = pred[128]{0} compare(convert_element_type.7, broadcast.29), direction=EQ
  jit__where_.51 = f32[128]{0} call(eq.55, add.92, constant.69), to_apply=_where.15
  add.103 = f32[128]{0} add(add.102, jit__where_.51)
  eq.56 = pred[128]{0} compare(convert_element_type.7, broadcast.28), direction=EQ
  jit__where_.52 = f32[128]{0} call(eq.56, sub.56, constant.69), to_apply=_where.15
  add.104 = f32[128]{0} add(add.103, jit__where_.52)
  eq.57 = pred[128]{0} compare(convert_element_type.7, broadcast.27), direction=EQ
  jit__where_.53 = f32[128]{0} call(eq.57, add.95, constant.69), to_apply=_where.15
  add.105 = f32[128]{0} add(add.104, jit__where_.53)
  broadcast_in_dim.28 = f32[128,1]{1,0} reshape(add.105)
  mul.160 = f32[128,1]{1,0} broadcast(broadcast_in_dim.28), dimensions={0,1}
  mul.161 = f32[128]{0} reshape(mul.160)
  mul.162 = f32[128,128]{1,0} broadcast(mul.161), dimensions={0}
  slice.52 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [5:133]}
  mul.163 = f32[128,128]{1,0} multiply(mul.162, slice.52)
  add.131 = f32[128,128]{1,0} add(mul.159, mul.163)
  constant.45 = s32[] constant(1)
  broadcast.25 = s32[128]{0} broadcast(constant.45), dimensions={}
  eq.58 = pred[128]{0} compare(convert_element_type.7, broadcast.25), direction=EQ
  jit__where_.54 = f32[128]{0} call(eq.58, sub.47, constant.69), to_apply=_where.15
  eq.59 = pred[128]{0} compare(convert_element_type.7, broadcast.26), direction=EQ
  jit__where_.55 = f32[128]{0} call(eq.59, add.88, constant.69), to_apply=_where.15
  add.106 = f32[128]{0} add(jit__where_.54, jit__where_.55)
  eq.60 = pred[128]{0} compare(convert_element_type.7, broadcast.31), direction=EQ
  jit__where_.56 = f32[128]{0} call(eq.60, sub.52, constant.69), to_apply=_where.15
  add.107 = f32[128]{0} add(add.106, jit__where_.56)
  eq.61 = pred[128]{0} compare(convert_element_type.7, broadcast.30), direction=EQ
  jit__where_.57 = f32[128]{0} call(eq.61, add.92, constant.69), to_apply=_where.15
  add.108 = f32[128]{0} add(add.107, jit__where_.57)
  eq.62 = pred[128]{0} compare(convert_element_type.7, broadcast.29), direction=EQ
  jit__where_.58 = f32[128]{0} call(eq.62, sub.56, constant.69), to_apply=_where.15
  add.109 = f32[128]{0} add(add.108, jit__where_.58)
  eq.63 = pred[128]{0} compare(convert_element_type.7, broadcast.28), direction=EQ
  jit__where_.59 = f32[128]{0} call(eq.63, add.95, constant.69), to_apply=_where.15
  add.110 = f32[128]{0} add(add.109, jit__where_.59)
  broadcast_in_dim.29 = f32[128,1]{1,0} reshape(add.110)
  mul.164 = f32[128,1]{1,0} broadcast(broadcast_in_dim.29), dimensions={0,1}
  mul.165 = f32[128]{0} reshape(mul.164)
  mul.166 = f32[128,128]{1,0} broadcast(mul.165), dimensions={0}
  slice.53 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [4:132]}
  mul.167 = f32[128,128]{1,0} multiply(mul.166, slice.53)
  add.132 = f32[128,128]{1,0} add(add.131, mul.167)
  constant.44 = s32[] constant(2)
  broadcast.24 = s32[128]{0} broadcast(constant.44), dimensions={}
  eq.64 = pred[128]{0} compare(convert_element_type.7, broadcast.24), direction=EQ
  jit__where_.60 = f32[128]{0} call(eq.64, sub.47, constant.69), to_apply=_where.15
  eq.65 = pred[128]{0} compare(convert_element_type.7, broadcast.25), direction=EQ
  jit__where_.61 = f32[128]{0} call(eq.65, add.88, constant.69), to_apply=_where.15
  add.111 = f32[128]{0} add(jit__where_.60, jit__where_.61)
  eq.66 = pred[128]{0} compare(convert_element_type.7, broadcast.26), direction=EQ
  jit__where_.62 = f32[128]{0} call(eq.66, sub.52, constant.69), to_apply=_where.15
  add.112 = f32[128]{0} add(add.111, jit__where_.62)
  eq.67 = pred[128]{0} compare(convert_element_type.7, broadcast.31), direction=EQ
  jit__where_.63 = f32[128]{0} call(eq.67, add.92, constant.69), to_apply=_where.15
  add.113 = f32[128]{0} add(add.112, jit__where_.63)
  eq.68 = pred[128]{0} compare(convert_element_type.7, broadcast.30), direction=EQ
  jit__where_.64 = f32[128]{0} call(eq.68, sub.56, constant.69), to_apply=_where.15
  add.114 = f32[128]{0} add(add.113, jit__where_.64)
  eq.69 = pred[128]{0} compare(convert_element_type.7, broadcast.29), direction=EQ
  jit__where_.65 = f32[128]{0} call(eq.69, add.95, constant.69), to_apply=_where.15
  add.115 = f32[128]{0} add(add.114, jit__where_.65)
  broadcast_in_dim.30 = f32[128,1]{1,0} reshape(add.115)
  mul.168 = f32[128,1]{1,0} broadcast(broadcast_in_dim.30), dimensions={0,1}
  mul.169 = f32[128]{0} reshape(mul.168)
  mul.170 = f32[128,128]{1,0} broadcast(mul.169), dimensions={0}
  slice.54 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [3:131]}
  mul.171 = f32[128,128]{1,0} multiply(mul.170, slice.54)
  add.133 = f32[128,128]{1,0} add(add.132, mul.171)
  constant.43 = s32[] constant(3)
  broadcast.23 = s32[128]{0} broadcast(constant.43), dimensions={}
  eq.70 = pred[128]{0} compare(convert_element_type.7, broadcast.23), direction=EQ
  jit__where_.66 = f32[128]{0} call(eq.70, sub.47, constant.69), to_apply=_where.15
  eq.71 = pred[128]{0} compare(convert_element_type.7, broadcast.24), direction=EQ
  jit__where_.67 = f32[128]{0} call(eq.71, add.88, constant.69), to_apply=_where.15
  add.116 = f32[128]{0} add(jit__where_.66, jit__where_.67)
  eq.72 = pred[128]{0} compare(convert_element_type.7, broadcast.25), direction=EQ
  jit__where_.68 = f32[128]{0} call(eq.72, sub.52, constant.69), to_apply=_where.15
  add.117 = f32[128]{0} add(add.116, jit__where_.68)
  eq.73 = pred[128]{0} compare(convert_element_type.7, broadcast.26), direction=EQ
  jit__where_.69 = f32[128]{0} call(eq.73, add.92, constant.69), to_apply=_where.15
  add.118 = f32[128]{0} add(add.117, jit__where_.69)
  eq.74 = pred[128]{0} compare(convert_element_type.7, broadcast.31), direction=EQ
  jit__where_.70 = f32[128]{0} call(eq.74, sub.56, constant.69), to_apply=_where.15
  add.119 = f32[128]{0} add(add.118, jit__where_.70)
  eq.75 = pred[128]{0} compare(convert_element_type.7, broadcast.30), direction=EQ
  jit__where_.71 = f32[128]{0} call(eq.75, add.95, constant.69), to_apply=_where.15
  add.120 = f32[128]{0} add(add.119, jit__where_.71)
  broadcast_in_dim.31 = f32[128,1]{1,0} reshape(add.120)
  mul.172 = f32[128,1]{1,0} broadcast(broadcast_in_dim.31), dimensions={0,1}
  mul.173 = f32[128]{0} reshape(mul.172)
  mul.174 = f32[128,128]{1,0} broadcast(mul.173), dimensions={0}
  slice.55 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [2:130]}
  mul.175 = f32[128,128]{1,0} multiply(mul.174, slice.55)
  add.134 = f32[128,128]{1,0} add(add.133, mul.175)
  constant.42 = s32[] constant(4)
  broadcast.22 = s32[128]{0} broadcast(constant.42), dimensions={}
  eq.76 = pred[128]{0} compare(convert_element_type.7, broadcast.22), direction=EQ
  jit__where_.72 = f32[128]{0} call(eq.76, sub.47, constant.69), to_apply=_where.15
  eq.77 = pred[128]{0} compare(convert_element_type.7, broadcast.23), direction=EQ
  jit__where_.73 = f32[128]{0} call(eq.77, add.88, constant.69), to_apply=_where.15
  add.121 = f32[128]{0} add(jit__where_.72, jit__where_.73)
  eq.78 = pred[128]{0} compare(convert_element_type.7, broadcast.24), direction=EQ
  jit__where_.74 = f32[128]{0} call(eq.78, sub.52, constant.69), to_apply=_where.15
  add.122 = f32[128]{0} add(add.121, jit__where_.74)
  eq.79 = pred[128]{0} compare(convert_element_type.7, broadcast.25), direction=EQ
  jit__where_.75 = f32[128]{0} call(eq.79, add.92, constant.69), to_apply=_where.15
  add.123 = f32[128]{0} add(add.122, jit__where_.75)
  eq.80 = pred[128]{0} compare(convert_element_type.7, broadcast.26), direction=EQ
  jit__where_.76 = f32[128]{0} call(eq.80, sub.56, constant.69), to_apply=_where.15
  add.124 = f32[128]{0} add(add.123, jit__where_.76)
  eq.81 = pred[128]{0} compare(convert_element_type.7, broadcast.31), direction=EQ
  jit__where_.77 = f32[128]{0} call(eq.81, add.95, constant.69), to_apply=_where.15
  add.125 = f32[128]{0} add(add.124, jit__where_.77)
  broadcast_in_dim.32 = f32[128,1]{1,0} reshape(add.125)
  mul.176 = f32[128,1]{1,0} broadcast(broadcast_in_dim.32), dimensions={0,1}
  mul.177 = f32[128]{0} reshape(mul.176)
  mul.178 = f32[128,128]{1,0} broadcast(mul.177), dimensions={0}
  slice.56 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [1:129]}
  mul.179 = f32[128,128]{1,0} multiply(mul.178, slice.56)
  add.135 = f32[128,128]{1,0} add(add.134, mul.179)
  constant.41 = s32[] constant(5)
  eq.44 = s32[128]{0} broadcast(constant.41), dimensions={}
  eq.82 = pred[128]{0} compare(convert_element_type.7, eq.44), direction=EQ
  jit__where_.78 = f32[128]{0} call(eq.82, sub.47, constant.69), to_apply=_where.15
  eq.83 = pred[128]{0} compare(convert_element_type.7, broadcast.22), direction=EQ
  jit__where_.79 = f32[128]{0} call(eq.83, add.88, constant.69), to_apply=_where.15
  add.126 = f32[128]{0} add(jit__where_.78, jit__where_.79)
  eq.84 = pred[128]{0} compare(convert_element_type.7, broadcast.23), direction=EQ
  jit__where_.80 = f32[128]{0} call(eq.84, sub.52, constant.69), to_apply=_where.15
  add.127 = f32[128]{0} add(add.126, jit__where_.80)
  eq.85 = pred[128]{0} compare(convert_element_type.7, broadcast.24), direction=EQ
  jit__where_.81 = f32[128]{0} call(eq.85, add.92, constant.69), to_apply=_where.15
  add.128 = f32[128]{0} add(add.127, jit__where_.81)
  eq.86 = pred[128]{0} compare(convert_element_type.7, broadcast.25), direction=EQ
  jit__where_.82 = f32[128]{0} call(eq.86, sub.56, constant.69), to_apply=_where.15
  add.129 = f32[128]{0} add(add.128, jit__where_.82)
  eq.87 = pred[128]{0} compare(convert_element_type.7, broadcast.26), direction=EQ
  jit__where_.83 = f32[128]{0} call(eq.87, add.95, constant.69), to_apply=_where.15
  add.130 = f32[128]{0} add(add.129, jit__where_.83)
  broadcast_in_dim.33 = f32[128,1]{1,0} reshape(add.130)
  mul.180 = f32[128,1]{1,0} broadcast(broadcast_in_dim.33), dimensions={0,1}
  mul.181 = f32[128]{0} reshape(mul.180)
  mul.182 = f32[128,128]{1,0} broadcast(mul.181), dimensions={0}
  slice.57 = f32[128,128]{1,0} slice(jit__pad_.1), slice={[0:128], [0:128]}
  mul.183 = f32[128,128]{1,0} multiply(mul.182, slice.57)
  add.136 = f32[128,128]{1,0} add(add.135, mul.183)
  slice.58 = f32[128,14]{1,0} slice(add.136), slice={[0:128], [0:14]}
  jit__roll_static_.30 = f32[128,14]{1,0} call(slice.58), to_apply=_roll_static.1
  slice.59 = f32[128,50]{1,0} slice(add.136), slice={[0:128], [14:64]}
  jit__roll_static_.31 = f32[128,50]{1,0} call(slice.59), to_apply=_roll_static_6.2
  slice.60 = f32[128,50]{1,0} slice(add.136), slice={[0:128], [64:114]}
  jit__roll_static_.32 = f32[128,50]{1,0} call(slice.60), to_apply=_roll_static_11.3
  slice.61 = f32[128,14]{1,0} slice(add.136), slice={[0:128], [114:128]}
  jit__roll_static_.33 = f32[128,14]{1,0} call(slice.61), to_apply=_roll_static_16.4
  concatenate.19 = f32[128,128]{1,0} concatenate(jit__roll_static_.30, jit__roll_static_.31, jit__roll_static_.32, jit__roll_static_.33), dimensions={1}
  jit__roll_static_.34 = f32[128,128]{1,0} call(concatenate.19), to_apply=_roll_static_22.5
  broadcast_in_dim.34 = f32[1,128]{1,0} reshape(sub.33)
  mul.184 = f32[1,128]{1,0} broadcast(broadcast_in_dim.34), dimensions={0,1}
  mul.185 = f32[128]{0} reshape(mul.184)
  mul.186 = f32[128,128]{1,0} broadcast(mul.185), dimensions={1}
  mul.187 = f32[128,128]{1,0} multiply(jit__roll_static_.34, mul.186)
  jit__roll_static_.35 = f32[128,128]{1,0} call(concatenate.19), to_apply=_roll_static_29.6
  broadcast_in_dim.35 = f32[1,128]{1,0} reshape(add.73)
  mul.188 = f32[1,128]{1,0} broadcast(broadcast_in_dim.35), dimensions={0,1}
  mul.189 = f32[128]{0} reshape(mul.188)
  mul.190 = f32[128,128]{1,0} broadcast(mul.189), dimensions={1}
  mul.191 = f32[128,128]{1,0} multiply(jit__roll_static_.35, mul.190)
  add.137 = f32[128,128]{1,0} add(mul.187, mul.191)
  jit__roll_static_.36 = f32[128,128]{1,0} call(concatenate.19), to_apply=_roll_static_34.7
  broadcast_in_dim.36 = f32[1,128]{1,0} reshape(sub.38)
  mul.192 = f32[1,128]{1,0} broadcast(broadcast_in_dim.36), dimensions={0,1}
  mul.193 = f32[128]{0} reshape(mul.192)
  mul.194 = f32[128,128]{1,0} broadcast(mul.193), dimensions={1}
  mul.195 = f32[128,128]{1,0} multiply(jit__roll_static_.36, mul.194)
  add.138 = f32[128,128]{1,0} add(add.137, mul.195)
  jit__roll_static_.37 = f32[128,128]{1,0} call(concatenate.19), to_apply=_roll_static_39.8
  broadcast_in_dim.37 = f32[1,128]{1,0} reshape(add.77)
  mul.196 = f32[1,128]{1,0} broadcast(broadcast_in_dim.37), dimensions={0,1}
  mul.197 = f32[128]{0} reshape(mul.196)
  mul.198 = f32[128,128]{1,0} broadcast(mul.197), dimensions={1}
  mul.199 = f32[128,128]{1,0} multiply(jit__roll_static_.37, mul.198)
  add.139 = f32[128,128]{1,0} add(add.138, mul.199)
  jit__roll_static_.38 = f32[128,128]{1,0} call(concatenate.19), to_apply=_roll_static_44.9
  broadcast_in_dim.38 = f32[1,128]{1,0} reshape(sub.42)
  mul.200 = f32[1,128]{1,0} broadcast(broadcast_in_dim.38), dimensions={0,1}
  mul.201 = f32[128]{0} reshape(mul.200)
  mul.202 = f32[128,128]{1,0} broadcast(mul.201), dimensions={1}
  mul.203 = f32[128,128]{1,0} multiply(jit__roll_static_.38, mul.202)
  add.140 = f32[128,128]{1,0} add(add.139, mul.203)
  jit__roll_static_.39 = f32[128,128]{1,0} call(concatenate.19), to_apply=_roll_static_49.10
  broadcast_in_dim.39 = f32[1,128]{1,0} reshape(add.80)
  mul.204 = f32[1,128]{1,0} broadcast(broadcast_in_dim.39), dimensions={0,1}
  mul.205 = f32[128]{0} reshape(mul.204)
  mul.206 = f32[128,128]{1,0} broadcast(mul.205), dimensions={1}
  mul.207 = f32[128,128]{1,0} multiply(jit__roll_static_.39, mul.206)
  add.141 = f32[128,128]{1,0} add(add.140, mul.207)
  jit_solve_poisson_.6 = f32[128]{0} get-tuple-element(jit_solve_poisson_.4), index=1
  jit_solve_poisson_.7 = f32[128]{0} get-tuple-element(jit_solve_poisson_.4), index=2
  ROOT tuple.3 = (f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) tuple(add.141, jit_solve_poisson_.6, jit_solve_poisson_.7)
}

region_0.18 {
  arg_tuple.1 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) parameter(0)
  get-tuple-element.4 = s32[] get-tuple-element(arg_tuple.1), index=0
  constant.70 = s32[] constant(1)
  add.143 = s32[] add(get-tuple-element.4, constant.70)
  constant.72 = f32[128]{0} constant({...})
  constant.71 = f32[65]{0} constant({...})
  get-tuple-element.5 = f32[128,128]{1,0} get-tuple-element(arg_tuple.1), index=1
  get-tuple-element.6 = f32[128]{0} get-tuple-element(arg_tuple.1), index=2
  get-tuple-element.7 = f32[128]{0} get-tuple-element(arg_tuple.1), index=3
  closed_call.4 = (f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) call(constant.72, constant.71, get-tuple-element.5, get-tuple-element.6, get-tuple-element.7), to_apply=closed_call.17
  closed_call.5 = f32[128,128]{1,0} get-tuple-element(closed_call.4), index=0
  closed_call.6 = f32[128]{0} get-tuple-element(closed_call.4), index=1
  closed_call.7 = f32[128]{0} get-tuple-element(closed_call.4), index=2
  ROOT tuple.5 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) tuple(add.143, closed_call.5, closed_call.6, closed_call.7)
}

region_2.19 {
  arg_tuple.3 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) parameter(0)
  get-tuple-element.13 = f32[128,128]{1,0} get-tuple-element(arg_tuple.3), index=1
  get-tuple-element.14 = f32[128]{0} get-tuple-element(arg_tuple.3), index=2
  get-tuple-element.15 = f32[128]{0} get-tuple-element(arg_tuple.3), index=3
  get-tuple-element.12 = s32[] get-tuple-element(arg_tuple.3), index=0
  constant.74 = s32[] constant(10)
  ROOT lt.1 = pred[] compare(get-tuple-element.12, constant.74), direction=LT
}

ENTRY main.20 {
  constant.77 = s32[] constant(0)
  start_state_2__0_.1 = f32[128,128]{1,0} parameter(6)
  start_state_1__0_.1 = f32[128]{0} parameter(4)
  start_state_1__1_.1 = f32[128]{0} parameter(5)
  while.6 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) tuple(constant.77, start_state_2__0_.1, start_state_1__0_.1, start_state_1__1_.1)
  while.7 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) while(while.6), condition=region_2.19, body=region_0.18
  while.8 = s32[] get-tuple-element(while.7), index=0
  start_state_0__0_.1 = f32[128]{0} parameter(0)
  start_state_0__1_.1 = f32[128]{0} parameter(1)
  start_state_0__2_.1 = f32[65]{0} parameter(2)
  start_state_0__3_.1 = s32[6]{0} parameter(3)
  while.10 = f32[128]{0} get-tuple-element(while.7), index=2
  while.11 = f32[128]{0} get-tuple-element(while.7), index=3
  while.9 = f32[128,128]{1,0} get-tuple-element(while.7), index=1
  start_state_2__1_.1 = f32[128]{0} parameter(7)
  start_state_3_.1 = f32[] parameter(8)
  constant.75 = f32[] constant(0.5)
  add.146 = f32[] add(start_state_3_.1, constant.75)
  start_state_4_.1 = s32[] parameter(9)
  constant.76 = s32[] constant(10)
  add.147 = s32[] add(start_state_4_.1, constant.76)
  ROOT tuple.7 = (f32[128]{0}, f32[128]{0}, f32[65]{0}, s32[6]{0}, f32[128]{0}, /*index=5*/f32[128]{0}, f32[128,128]{1,0}, f32[128]{0}, f32[], s32[]) tuple(start_state_0__0_.1, start_state_0__1_.1, start_state_0__2_.1, start_state_0__3_.1, while.10, while.11, while.9, start_state_2__1_.1, add.146, add.147)
}

