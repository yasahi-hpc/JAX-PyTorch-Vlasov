HloModule jit__lambda, entry_computation_layout={(f32[32,32,32,32]{3,2,1,0})->(f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0})}

_roll_static.1 {
  Arg_0.1 = f32[32,32,16,32]{3,2,1,0} parameter(0)
  slice.3 = f32[31,32,16,32]{3,2,1,0} slice(Arg_0.1), slice={[1:32], [0:32], [0:16], [0:32]}
  slice.4 = f32[1,32,16,32]{3,2,1,0} slice(Arg_0.1), slice={[0:1], [0:32], [0:16], [0:32]}
  ROOT concatenate.1 = f32[32,32,16,32]{3,2,1,0} concatenate(slice.3, slice.4), dimensions={0}
}

_roll_static_6.2 {
  ROOT Arg_0.3 = f32[32,32,16,32]{3,2,1,0} parameter(0)
}

_roll_static_12.3 {
  Arg_0.5 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.8 = f32[30,32,32,32]{3,2,1,0} slice(Arg_0.5), slice={[2:32], [0:32], [0:32], [0:32]}
  slice.9 = f32[2,32,32,32]{3,2,1,0} slice(Arg_0.5), slice={[0:2], [0:32], [0:32], [0:32]}
  ROOT concatenate.4 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.8, slice.9), dimensions={0}
}

_roll_static_19.4 {
  Arg_0.7 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.12 = f32[31,32,32,32]{3,2,1,0} slice(Arg_0.7), slice={[1:32], [0:32], [0:32], [0:32]}
  slice.13 = f32[1,32,32,32]{3,2,1,0} slice(Arg_0.7), slice={[0:1], [0:32], [0:32], [0:32]}
  ROOT concatenate.6 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.12, slice.13), dimensions={0}
}

_roll_static_24.5 {
  ROOT Arg_0.9 = f32[32,32,32,32]{3,2,1,0} parameter(0)
}

_roll_static_29.6 {
  Arg_0.11 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.16 = f32[1,32,32,32]{3,2,1,0} slice(Arg_0.11), slice={[31:32], [0:32], [0:32], [0:32]}
  slice.17 = f32[31,32,32,32]{3,2,1,0} slice(Arg_0.11), slice={[0:31], [0:32], [0:32], [0:32]}
  ROOT concatenate.8 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.16, slice.17), dimensions={0}
}

_roll_static_34.7 {
  Arg_0.13 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.20 = f32[2,32,32,32]{3,2,1,0} slice(Arg_0.13), slice={[30:32], [0:32], [0:32], [0:32]}
  slice.21 = f32[30,32,32,32]{3,2,1,0} slice(Arg_0.13), slice={[0:30], [0:32], [0:32], [0:32]}
  ROOT concatenate.10 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.20, slice.21), dimensions={0}
}

_roll_static_39.8 {
  Arg_0.15 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.24 = f32[3,32,32,32]{3,2,1,0} slice(Arg_0.15), slice={[29:32], [0:32], [0:32], [0:32]}
  slice.25 = f32[29,32,32,32]{3,2,1,0} slice(Arg_0.15), slice={[0:29], [0:32], [0:32], [0:32]}
  ROOT concatenate.12 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.24, slice.25), dimensions={0}
}

_roll_static_45.9 {
  Arg_0.17 = f32[32,32,32,16]{3,2,1,0} parameter(0)
  slice.29 = f32[32,31,32,16]{3,2,1,0} slice(Arg_0.17), slice={[0:32], [1:32], [0:32], [0:16]}
  slice.30 = f32[32,1,32,16]{3,2,1,0} slice(Arg_0.17), slice={[0:32], [0:1], [0:32], [0:16]}
  ROOT concatenate.14 = f32[32,32,32,16]{3,2,1,0} concatenate(slice.29, slice.30), dimensions={1}
}

_roll_static_50.10 {
  ROOT Arg_0.19 = f32[32,32,32,16]{3,2,1,0} parameter(0)
}

_roll_static_55.11 {
  Arg_0.21 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.34 = f32[32,30,32,32]{3,2,1,0} slice(Arg_0.21), slice={[0:32], [2:32], [0:32], [0:32]}
  slice.35 = f32[32,2,32,32]{3,2,1,0} slice(Arg_0.21), slice={[0:32], [0:2], [0:32], [0:32]}
  ROOT concatenate.17 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.34, slice.35), dimensions={1}
}

_roll_static_61.12 {
  Arg_0.23 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.38 = f32[32,31,32,32]{3,2,1,0} slice(Arg_0.23), slice={[0:32], [1:32], [0:32], [0:32]}
  slice.39 = f32[32,1,32,32]{3,2,1,0} slice(Arg_0.23), slice={[0:32], [0:1], [0:32], [0:32]}
  ROOT concatenate.19 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.38, slice.39), dimensions={1}
}

_roll_static_65.13 {
  ROOT Arg_0.25 = f32[32,32,32,32]{3,2,1,0} parameter(0)
}

_roll_static_68.14 {
  Arg_0.27 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.42 = f32[32,1,32,32]{3,2,1,0} slice(Arg_0.27), slice={[0:32], [31:32], [0:32], [0:32]}
  slice.43 = f32[32,31,32,32]{3,2,1,0} slice(Arg_0.27), slice={[0:32], [0:31], [0:32], [0:32]}
  ROOT concatenate.21 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.42, slice.43), dimensions={1}
}

_roll_static_72.15 {
  Arg_0.29 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.46 = f32[32,2,32,32]{3,2,1,0} slice(Arg_0.29), slice={[0:32], [30:32], [0:32], [0:32]}
  slice.47 = f32[32,30,32,32]{3,2,1,0} slice(Arg_0.29), slice={[0:32], [0:30], [0:32], [0:32]}
  ROOT concatenate.23 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.46, slice.47), dimensions={1}
}

_roll_static_76.16 {
  Arg_0.31 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.50 = f32[32,3,32,32]{3,2,1,0} slice(Arg_0.31), slice={[0:32], [29:32], [0:32], [0:32]}
  slice.51 = f32[32,29,32,32]{3,2,1,0} slice(Arg_0.31), slice={[0:32], [0:29], [0:32], [0:32]}
  ROOT concatenate.25 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.50, slice.51), dimensions={1}
}

region_0.17 {
  reduce_sum.3 = f32[] parameter(0)
  reduce_sum.4 = f32[] parameter(1)
  ROOT reduce_sum.5 = f32[] add(reduce_sum.3, reduce_sum.4)
}

fft.18 {
  Arg_0.34 = f32[32,32]{1,0} parameter(0)
  ROOT fft.1 = c64[32,17]{1,0} fft(Arg_0.34), fft_type=RFFT, fft_length={32,32}
}

fft_85.19 {
  Arg_0.36 = c64[32,17]{1,0} parameter(0)
  ROOT fft.3 = f32[32,32]{1,0} fft(Arg_0.36), fft_type=IRFFT, fft_length={32,32}
}

solve_poisson.20 {
  Arg_1.1 = f32[32,1]{1,0} parameter(1)
  convert_element_type.4 = c64[32,1]{1,0} convert(Arg_1.1)
  constant.49 = c64[] constant((-0, -1))
  mul.64 = c64[32,1]{1,0} broadcast(constant.49), dimensions={}
  mul.70 = c64[32,1]{1,0} multiply(convert_element_type.4, mul.64)
  mul.71 = c64[32,1]{1,0} broadcast(mul.70), dimensions={0,1}
  mul.72 = c64[32]{0} reshape(mul.71)
  mul.73 = c64[32,17]{1,0} broadcast(mul.72), dimensions={0}
  Arg_0.37 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  constant.51 = f32[] constant(0)
  reduce_sum.7 = f32[32,32]{1,0} reduce(Arg_0.37, constant.51), dimensions={2,3}, to_apply=region_0.17
  Arg_4.1 = f32[] parameter(4)
  mul.65 = f32[32,32]{1,0} broadcast(Arg_4.1), dimensions={}
  mul.66 = f32[32,32]{1,0} multiply(reduce_sum.7, mul.65)
  Arg_5.1 = f32[] parameter(5)
  mul.67 = f32[32,32]{1,0} broadcast(Arg_5.1), dimensions={}
  mul.68 = f32[32,32]{1,0} multiply(mul.66, mul.67)
  constant.50 = f32[] constant(1)
  sub.2 = f32[32,32]{1,0} broadcast(constant.50), dimensions={}
  sub.3 = f32[32,32]{1,0} subtract(mul.68, sub.2)
  jit_fft_.4 = c64[32,17]{1,0} call(sub.3), to_apply=fft.18
  Arg_3.1 = f32[32,17]{1,0} parameter(3)
  convert_element_type.3 = c64[32,17]{1,0} convert(Arg_3.1)
  mul.69 = c64[32,17]{1,0} multiply(jit_fft_.4, convert_element_type.3)
  mul.74 = c64[32,17]{1,0} multiply(mul.73, mul.69)
  jit_fft_.6 = f32[32,32]{1,0} call(mul.74), to_apply=fft_85.19
  Arg_2.1 = f32[1,17]{1,0} parameter(2)
  convert_element_type.5 = c64[1,17]{1,0} convert(Arg_2.1)
  constant.48 = c64[] constant((-0, -1))
  broadcast.27 = c64[1,17]{1,0} broadcast(constant.48), dimensions={}
  mul.75 = c64[1,17]{1,0} multiply(convert_element_type.5, broadcast.27)
  mul.76 = c64[1,17]{1,0} broadcast(mul.75), dimensions={0,1}
  mul.77 = c64[17]{0} reshape(mul.76)
  mul.78 = c64[32,17]{1,0} broadcast(mul.77), dimensions={1}
  mul.79 = c64[32,17]{1,0} multiply(mul.78, mul.69)
  jit_fft_.7 = f32[32,32]{1,0} call(mul.79), to_apply=fft_85.19
  jit_fft_.5 = f32[32,32]{1,0} call(mul.69), to_apply=fft_85.19
  ROOT tuple.1 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(jit_fft_.6, jit_fft_.7, sub.3, jit_fft_.5)
}

_where.21 {
  Arg_0.39 = pred[32,32]{1,0} parameter(0)
  Arg_1.3 = f32[32,32]{1,0} parameter(1)
  Arg_2.3 = f32[] parameter(2)
  broadcast_in_dim.1 = f32[32,32]{1,0} broadcast(Arg_2.3), dimensions={}
  ROOT select_n.1 = f32[32,32]{1,0} select(Arg_0.39, Arg_1.3, broadcast_in_dim.1)
}

_pad.22 {
  Arg_0.41 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  Arg_1.5 = s32[] parameter(1)
  convert_element_type.8 = f32[] convert(Arg_1.5)
  ROOT pad.1 = f32[32,32,38,32]{3,2,1,0} pad(Arg_0.41, convert_element_type.8), padding=0_0x0_0x3_3x0_0
}

_pad_129.23 {
  Arg_0.43 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  Arg_1.7 = s32[] parameter(1)
  convert_element_type.11 = f32[] convert(Arg_1.7)
  ROOT pad.3 = f32[32,32,32,38]{3,2,1,0} pad(Arg_0.43, convert_element_type.11), padding=0_0x0_0x0_0x3_3
}

ENTRY main.24 {
  carry_0_.1 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.70 = f32[32,32,16,32]{3,2,1,0} slice(carry_0_.1), slice={[0:32], [0:32], [0:16], [0:32]}
  jit__roll_static_.32 = f32[32,32,16,32]{3,2,1,0} call(slice.70), to_apply=_roll_static.1
  slice.71 = f32[32,32,16,32]{3,2,1,0} slice(carry_0_.1), slice={[0:32], [0:32], [16:32], [0:32]}
  jit__roll_static_.33 = f32[32,32,16,32]{3,2,1,0} call(slice.71), to_apply=_roll_static_6.2
  concatenate.28 = f32[32,32,32,32]{3,2,1,0} concatenate(jit__roll_static_.32, jit__roll_static_.33), dimensions={2}
  jit__roll_static_.34 = f32[32,32,32,32]{3,2,1,0} call(concatenate.28), to_apply=_roll_static_12.3
  constant.89 = f32[1,1,32,1]{3,2,1,0} constant({...})
  mul.206 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.89), dimensions={0,1,2,3}
  mul.207 = f32[32]{0} reshape(mul.206)
  mul.208 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.207), dimensions={2}
  mul.209 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.34, mul.208)
  jit__roll_static_.35 = f32[32,32,32,32]{3,2,1,0} call(concatenate.28), to_apply=_roll_static_19.4
  constant.88 = f32[1,1,32,1]{3,2,1,0} constant({...})
  mul.210 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.88), dimensions={0,1,2,3}
  mul.211 = f32[32]{0} reshape(mul.210)
  mul.212 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.211), dimensions={2}
  mul.213 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.35, mul.212)
  add.122 = f32[32,32,32,32]{3,2,1,0} add(mul.209, mul.213)
  jit__roll_static_.36 = f32[32,32,32,32]{3,2,1,0} call(concatenate.28), to_apply=_roll_static_24.5
  constant.87 = f32[1,1,32,1]{3,2,1,0} constant({...})
  mul.214 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.87), dimensions={0,1,2,3}
  mul.215 = f32[32]{0} reshape(mul.214)
  mul.216 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.215), dimensions={2}
  mul.217 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.36, mul.216)
  add.123 = f32[32,32,32,32]{3,2,1,0} add(add.122, mul.217)
  jit__roll_static_.37 = f32[32,32,32,32]{3,2,1,0} call(concatenate.28), to_apply=_roll_static_29.6
  constant.86 = f32[1,1,32,1]{3,2,1,0} constant({...})
  mul.218 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.86), dimensions={0,1,2,3}
  mul.219 = f32[32]{0} reshape(mul.218)
  mul.220 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.219), dimensions={2}
  mul.221 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.37, mul.220)
  add.124 = f32[32,32,32,32]{3,2,1,0} add(add.123, mul.221)
  jit__roll_static_.38 = f32[32,32,32,32]{3,2,1,0} call(concatenate.28), to_apply=_roll_static_34.7
  constant.85 = f32[1,1,32,1]{3,2,1,0} constant({...})
  mul.222 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.85), dimensions={0,1,2,3}
  mul.223 = f32[32]{0} reshape(mul.222)
  mul.224 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.223), dimensions={2}
  mul.225 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.38, mul.224)
  add.125 = f32[32,32,32,32]{3,2,1,0} add(add.124, mul.225)
  jit__roll_static_.39 = f32[32,32,32,32]{3,2,1,0} call(concatenate.28), to_apply=_roll_static_39.8
  constant.84 = f32[1,1,32,1]{3,2,1,0} constant({...})
  mul.226 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.84), dimensions={0,1,2,3}
  mul.227 = f32[32]{0} reshape(mul.226)
  mul.228 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.227), dimensions={2}
  mul.229 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.39, mul.228)
  add.126 = f32[32,32,32,32]{3,2,1,0} add(add.125, mul.229)
  slice.72 = f32[32,32,32,16]{3,2,1,0} slice(add.126), slice={[0:32], [0:32], [0:32], [0:16]}
  jit__roll_static_.40 = f32[32,32,32,16]{3,2,1,0} call(slice.72), to_apply=_roll_static_45.9
  slice.73 = f32[32,32,32,16]{3,2,1,0} slice(add.126), slice={[0:32], [0:32], [0:32], [16:32]}
  jit__roll_static_.41 = f32[32,32,32,16]{3,2,1,0} call(slice.73), to_apply=_roll_static_50.10
  concatenate.29 = f32[32,32,32,32]{3,2,1,0} concatenate(jit__roll_static_.40, jit__roll_static_.41), dimensions={3}
  jit__roll_static_.42 = f32[32,32,32,32]{3,2,1,0} call(concatenate.29), to_apply=_roll_static_55.11
  constant.83 = f32[1,1,1,32]{3,2,1,0} constant({...})
  mul.230 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.83), dimensions={0,1,2,3}
  mul.231 = f32[32]{0} reshape(mul.230)
  mul.232 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.231), dimensions={3}
  mul.233 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.42, mul.232)
  jit__roll_static_.43 = f32[32,32,32,32]{3,2,1,0} call(concatenate.29), to_apply=_roll_static_61.12
  constant.82 = f32[1,1,1,32]{3,2,1,0} constant({...})
  mul.234 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.82), dimensions={0,1,2,3}
  mul.235 = f32[32]{0} reshape(mul.234)
  mul.236 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.235), dimensions={3}
  mul.237 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.43, mul.236)
  add.127 = f32[32,32,32,32]{3,2,1,0} add(mul.233, mul.237)
  jit__roll_static_.44 = f32[32,32,32,32]{3,2,1,0} call(concatenate.29), to_apply=_roll_static_65.13
  constant.81 = f32[1,1,1,32]{3,2,1,0} constant({...})
  mul.238 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.81), dimensions={0,1,2,3}
  mul.239 = f32[32]{0} reshape(mul.238)
  mul.240 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.239), dimensions={3}
  mul.241 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.44, mul.240)
  add.128 = f32[32,32,32,32]{3,2,1,0} add(add.127, mul.241)
  jit__roll_static_.45 = f32[32,32,32,32]{3,2,1,0} call(concatenate.29), to_apply=_roll_static_68.14
  constant.80 = f32[1,1,1,32]{3,2,1,0} constant({...})
  mul.242 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.80), dimensions={0,1,2,3}
  mul.243 = f32[32]{0} reshape(mul.242)
  mul.244 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.243), dimensions={3}
  mul.245 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.45, mul.244)
  add.129 = f32[32,32,32,32]{3,2,1,0} add(add.128, mul.245)
  jit__roll_static_.46 = f32[32,32,32,32]{3,2,1,0} call(concatenate.29), to_apply=_roll_static_72.15
  constant.79 = f32[1,1,1,32]{3,2,1,0} constant({...})
  mul.246 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.79), dimensions={0,1,2,3}
  mul.247 = f32[32]{0} reshape(mul.246)
  mul.248 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.247), dimensions={3}
  mul.249 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.46, mul.248)
  add.130 = f32[32,32,32,32]{3,2,1,0} add(add.129, mul.249)
  jit__roll_static_.47 = f32[32,32,32,32]{3,2,1,0} call(concatenate.29), to_apply=_roll_static_76.16
  constant.78 = f32[1,1,1,32]{3,2,1,0} constant({...})
  mul.250 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.78), dimensions={0,1,2,3}
  mul.251 = f32[32]{0} reshape(mul.250)
  mul.252 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.251), dimensions={3}
  mul.253 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.47, mul.252)
  add.131 = f32[32,32,32,32]{3,2,1,0} add(add.130, mul.253)
  constant.93 = f32[32,1]{1,0} constant({...})
  constant.94 = f32[1,17]{1,0} constant({...})
  constant.95 = f32[32,17]{1,0} constant({...})
  constant.91 = f32[] constant(0.322580636)
  jit_solve_poisson_.5 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) call(add.131, constant.93, constant.94, constant.95, constant.91, constant.91), to_apply=solve_poisson.20
  jit_solve_poisson_.7 = f32[32,32]{1,0} get-tuple-element(jit_solve_poisson_.5), index=1
  constant.77 = f32[] constant(0.05)
  broadcast.53 = f32[32,32]{1,0} broadcast(constant.77), dimensions={}
  mul.293 = f32[32,32]{1,0} multiply(jit_solve_poisson_.7, broadcast.53)
  constant.76 = f32[] constant(0.322580636)
  broadcast.52 = f32[32,32]{1,0} broadcast(constant.76), dimensions={}
  div.84 = f32[32,32]{1,0} divide(mul.293, broadcast.52)
  floor.3 = f32[32,32]{1,0} floor(div.84)
  convert_element_type.13 = s32[32,32]{1,0} convert(floor.3)
  constant.63 = s32[] constant(-1)
  broadcast.39 = s32[32,32]{1,0} broadcast(constant.63), dimensions={}
  eq.126 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.39), direction=EQ
  sub.46 = f32[32,32]{1,0} subtract(div.84, floor.3)
  constant.75 = f32[] constant(20)
  broadcast.51 = f32[32,32]{1,0} broadcast(constant.75), dimensions={}
  div.85 = f32[32,32]{1,0} divide(sub.46, broadcast.51)
  mul.294 = f32[32,32]{1,0} multiply(sub.46, sub.46)
  constant.74 = f32[] constant(24)
  broadcast.50 = f32[32,32]{1,0} broadcast(constant.74), dimensions={}
  div.86 = f32[32,32]{1,0} divide(mul.294, broadcast.50)
  sub.47 = f32[32,32]{1,0} subtract(div.85, div.86)
  mul.295 = f32[32,32]{1,0} multiply(mul.294, sub.46)
  div.87 = f32[32,32]{1,0} divide(mul.295, broadcast.50)
  sub.48 = f32[32,32]{1,0} subtract(sub.47, div.87)
  mul.296 = f32[32,32]{1,0} multiply(mul.295, sub.46)
  div.88 = f32[32,32]{1,0} divide(mul.296, broadcast.50)
  add.183 = f32[32,32]{1,0} add(sub.48, div.88)
  mul.297 = f32[32,32]{1,0} multiply(mul.296, sub.46)
  constant.73 = f32[] constant(120)
  broadcast.49 = f32[32,32]{1,0} broadcast(constant.73), dimensions={}
  div.89 = f32[32,32]{1,0} divide(mul.297, broadcast.49)
  sub.49 = f32[32,32]{1,0} subtract(add.183, div.89)
  constant.92 = f32[] constant(0)
  jit__where_.126 = f32[32,32]{1,0} call(eq.126, sub.49, constant.92), to_apply=_where.21
  constant.62 = s32[] constant(-2)
  broadcast.38 = s32[32,32]{1,0} broadcast(constant.62), dimensions={}
  eq.127 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.38), direction=EQ
  constant.72 = f32[] constant(2)
  broadcast.48 = f32[32,32]{1,0} broadcast(constant.72), dimensions={}
  div.90 = f32[32,32]{1,0} divide(sub.46, broadcast.48)
  neg.6 = f32[32,32]{1,0} negate(div.90)
  mul.298 = f32[32,32]{1,0} multiply(mul.294, broadcast.48)
  constant.71 = f32[] constant(3)
  broadcast.47 = f32[32,32]{1,0} broadcast(constant.71), dimensions={}
  div.91 = f32[32,32]{1,0} divide(mul.298, broadcast.47)
  add.184 = f32[32,32]{1,0} add(neg.6, div.91)
  div.92 = f32[32,32]{1,0} divide(mul.295, broadcast.50)
  sub.50 = f32[32,32]{1,0} subtract(add.184, div.92)
  constant.70 = f32[] constant(6)
  broadcast.46 = f32[32,32]{1,0} broadcast(constant.70), dimensions={}
  div.93 = f32[32,32]{1,0} divide(mul.296, broadcast.46)
  sub.51 = f32[32,32]{1,0} subtract(sub.50, div.93)
  div.94 = f32[32,32]{1,0} divide(mul.297, broadcast.50)
  add.185 = f32[32,32]{1,0} add(sub.51, div.94)
  jit__where_.127 = f32[32,32]{1,0} call(eq.127, add.185, constant.92), to_apply=_where.21
  add.193 = f32[32,32]{1,0} add(jit__where_.126, jit__where_.127)
  constant.61 = s32[] constant(-3)
  broadcast.37 = s32[32,32]{1,0} broadcast(constant.61), dimensions={}
  eq.128 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.37), direction=EQ
  constant.69 = f32[] constant(1)
  broadcast.45 = f32[32,32]{1,0} broadcast(constant.69), dimensions={}
  div.95 = f32[32,32]{1,0} divide(sub.46, broadcast.47)
  sub.52 = f32[32,32]{1,0} subtract(broadcast.45, div.95)
  constant.68 = f32[] constant(5)
  broadcast.44 = f32[32,32]{1,0} broadcast(constant.68), dimensions={}
  mul.299 = f32[32,32]{1,0} multiply(mul.294, broadcast.44)
  constant.67 = f32[] constant(4)
  broadcast.43 = f32[32,32]{1,0} broadcast(constant.67), dimensions={}
  div.96 = f32[32,32]{1,0} divide(mul.299, broadcast.43)
  sub.53 = f32[32,32]{1,0} subtract(sub.52, div.96)
  mul.300 = f32[32,32]{1,0} multiply(mul.295, broadcast.44)
  constant.66 = f32[] constant(12)
  broadcast.42 = f32[32,32]{1,0} broadcast(constant.66), dimensions={}
  div.97 = f32[32,32]{1,0} divide(mul.300, broadcast.42)
  add.186 = f32[32,32]{1,0} add(sub.53, div.97)
  div.98 = f32[32,32]{1,0} divide(mul.296, broadcast.43)
  add.187 = f32[32,32]{1,0} add(add.186, div.98)
  div.99 = f32[32,32]{1,0} divide(mul.297, broadcast.42)
  sub.54 = f32[32,32]{1,0} subtract(add.187, div.99)
  jit__where_.128 = f32[32,32]{1,0} call(eq.128, sub.54, constant.92), to_apply=_where.21
  add.194 = f32[32,32]{1,0} add(add.193, jit__where_.128)
  constant.60 = s32[] constant(-4)
  broadcast.36 = s32[32,32]{1,0} broadcast(constant.60), dimensions={}
  eq.129 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.36), direction=EQ
  mul.301 = f32[32,32]{1,0} multiply(mul.294, broadcast.48)
  div.100 = f32[32,32]{1,0} divide(mul.301, broadcast.47)
  add.188 = f32[32,32]{1,0} add(sub.46, div.100)
  constant.65 = f32[] constant(7)
  broadcast.41 = f32[32,32]{1,0} broadcast(constant.65), dimensions={}
  mul.302 = f32[32,32]{1,0} multiply(mul.295, broadcast.41)
  div.101 = f32[32,32]{1,0} divide(mul.302, broadcast.42)
  sub.55 = f32[32,32]{1,0} subtract(add.188, div.101)
  div.102 = f32[32,32]{1,0} divide(mul.296, broadcast.46)
  sub.56 = f32[32,32]{1,0} subtract(sub.55, div.102)
  div.103 = f32[32,32]{1,0} divide(mul.297, broadcast.42)
  add.189 = f32[32,32]{1,0} add(sub.56, div.103)
  jit__where_.129 = f32[32,32]{1,0} call(eq.129, add.189, constant.92), to_apply=_where.21
  add.195 = f32[32,32]{1,0} add(add.194, jit__where_.129)
  constant.59 = s32[] constant(-5)
  broadcast.35 = s32[32,32]{1,0} broadcast(constant.59), dimensions={}
  eq.130 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.35), direction=EQ
  div.104 = f32[32,32]{1,0} divide(sub.46, broadcast.43)
  neg.7 = f32[32,32]{1,0} negate(div.104)
  div.105 = f32[32,32]{1,0} divide(mul.294, broadcast.50)
  sub.57 = f32[32,32]{1,0} subtract(neg.7, div.105)
  mul.303 = f32[32,32]{1,0} multiply(mul.295, broadcast.41)
  div.106 = f32[32,32]{1,0} divide(mul.303, broadcast.50)
  add.190 = f32[32,32]{1,0} add(sub.57, div.106)
  div.107 = f32[32,32]{1,0} divide(mul.296, broadcast.50)
  add.191 = f32[32,32]{1,0} add(add.190, div.107)
  div.108 = f32[32,32]{1,0} divide(mul.297, broadcast.50)
  sub.58 = f32[32,32]{1,0} subtract(add.191, div.108)
  jit__where_.130 = f32[32,32]{1,0} call(eq.130, sub.58, constant.92), to_apply=_where.21
  add.196 = f32[32,32]{1,0} add(add.195, jit__where_.130)
  constant.58 = s32[] constant(-6)
  broadcast.34 = s32[32,32]{1,0} broadcast(constant.58), dimensions={}
  eq.131 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.34), direction=EQ
  constant.64 = f32[] constant(30)
  broadcast.40 = f32[32,32]{1,0} broadcast(constant.64), dimensions={}
  div.109 = f32[32,32]{1,0} divide(sub.46, broadcast.40)
  div.110 = f32[32,32]{1,0} divide(mul.295, broadcast.50)
  sub.59 = f32[32,32]{1,0} subtract(div.109, div.110)
  div.111 = f32[32,32]{1,0} divide(mul.297, broadcast.49)
  add.192 = f32[32,32]{1,0} add(sub.59, div.111)
  jit__where_.131 = f32[32,32]{1,0} call(eq.131, add.192, constant.92), to_apply=_where.21
  add.197 = f32[32,32]{1,0} add(add.196, jit__where_.131)
  broadcast_in_dim.23 = f32[32,32,1,1]{3,2,1,0} reshape(add.197)
  mul.304 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.23), dimensions={0,1,2,3}
  mul.305 = f32[32,32]{1,0} reshape(mul.304)
  mul.306 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.305), dimensions={0,1}
  jit_solve_poisson_.6 = f32[32,32]{1,0} get-tuple-element(jit_solve_poisson_.5), index=0
  mul.254 = f32[32,32]{1,0} multiply(jit_solve_poisson_.6, broadcast.53)
  div.56 = f32[32,32]{1,0} divide(mul.254, broadcast.52)
  floor.2 = f32[32,32]{1,0} floor(div.56)
  convert_element_type.12 = s32[32,32]{1,0} convert(floor.2)
  eq.84 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.39), direction=EQ
  sub.32 = f32[32,32]{1,0} subtract(div.56, floor.2)
  div.57 = f32[32,32]{1,0} divide(sub.32, broadcast.51)
  mul.255 = f32[32,32]{1,0} multiply(sub.32, sub.32)
  div.58 = f32[32,32]{1,0} divide(mul.255, broadcast.50)
  sub.33 = f32[32,32]{1,0} subtract(div.57, div.58)
  mul.256 = f32[32,32]{1,0} multiply(mul.255, sub.32)
  div.59 = f32[32,32]{1,0} divide(mul.256, broadcast.50)
  sub.34 = f32[32,32]{1,0} subtract(sub.33, div.59)
  mul.257 = f32[32,32]{1,0} multiply(mul.256, sub.32)
  div.60 = f32[32,32]{1,0} divide(mul.257, broadcast.50)
  add.132 = f32[32,32]{1,0} add(sub.34, div.60)
  mul.258 = f32[32,32]{1,0} multiply(mul.257, sub.32)
  div.61 = f32[32,32]{1,0} divide(mul.258, broadcast.49)
  sub.35 = f32[32,32]{1,0} subtract(add.132, div.61)
  jit__where_.84 = f32[32,32]{1,0} call(eq.84, sub.35, constant.92), to_apply=_where.21
  eq.85 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.38), direction=EQ
  div.62 = f32[32,32]{1,0} divide(sub.32, broadcast.48)
  neg.4 = f32[32,32]{1,0} negate(div.62)
  mul.259 = f32[32,32]{1,0} multiply(mul.255, broadcast.48)
  div.63 = f32[32,32]{1,0} divide(mul.259, broadcast.47)
  add.133 = f32[32,32]{1,0} add(neg.4, div.63)
  div.64 = f32[32,32]{1,0} divide(mul.256, broadcast.50)
  sub.36 = f32[32,32]{1,0} subtract(add.133, div.64)
  div.65 = f32[32,32]{1,0} divide(mul.257, broadcast.46)
  sub.37 = f32[32,32]{1,0} subtract(sub.36, div.65)
  div.66 = f32[32,32]{1,0} divide(mul.258, broadcast.50)
  add.134 = f32[32,32]{1,0} add(sub.37, div.66)
  jit__where_.85 = f32[32,32]{1,0} call(eq.85, add.134, constant.92), to_apply=_where.21
  add.142 = f32[32,32]{1,0} add(jit__where_.84, jit__where_.85)
  eq.86 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.37), direction=EQ
  div.67 = f32[32,32]{1,0} divide(sub.32, broadcast.47)
  sub.38 = f32[32,32]{1,0} subtract(broadcast.45, div.67)
  mul.260 = f32[32,32]{1,0} multiply(mul.255, broadcast.44)
  div.68 = f32[32,32]{1,0} divide(mul.260, broadcast.43)
  sub.39 = f32[32,32]{1,0} subtract(sub.38, div.68)
  mul.261 = f32[32,32]{1,0} multiply(mul.256, broadcast.44)
  div.69 = f32[32,32]{1,0} divide(mul.261, broadcast.42)
  add.135 = f32[32,32]{1,0} add(sub.39, div.69)
  div.70 = f32[32,32]{1,0} divide(mul.257, broadcast.43)
  add.136 = f32[32,32]{1,0} add(add.135, div.70)
  div.71 = f32[32,32]{1,0} divide(mul.258, broadcast.42)
  sub.40 = f32[32,32]{1,0} subtract(add.136, div.71)
  jit__where_.86 = f32[32,32]{1,0} call(eq.86, sub.40, constant.92), to_apply=_where.21
  add.143 = f32[32,32]{1,0} add(add.142, jit__where_.86)
  eq.87 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.36), direction=EQ
  mul.262 = f32[32,32]{1,0} multiply(mul.255, broadcast.48)
  div.72 = f32[32,32]{1,0} divide(mul.262, broadcast.47)
  add.137 = f32[32,32]{1,0} add(sub.32, div.72)
  mul.263 = f32[32,32]{1,0} multiply(mul.256, broadcast.41)
  div.73 = f32[32,32]{1,0} divide(mul.263, broadcast.42)
  sub.41 = f32[32,32]{1,0} subtract(add.137, div.73)
  div.74 = f32[32,32]{1,0} divide(mul.257, broadcast.46)
  sub.42 = f32[32,32]{1,0} subtract(sub.41, div.74)
  div.75 = f32[32,32]{1,0} divide(mul.258, broadcast.42)
  add.138 = f32[32,32]{1,0} add(sub.42, div.75)
  jit__where_.87 = f32[32,32]{1,0} call(eq.87, add.138, constant.92), to_apply=_where.21
  add.144 = f32[32,32]{1,0} add(add.143, jit__where_.87)
  eq.88 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.35), direction=EQ
  div.76 = f32[32,32]{1,0} divide(sub.32, broadcast.43)
  neg.5 = f32[32,32]{1,0} negate(div.76)
  div.77 = f32[32,32]{1,0} divide(mul.255, broadcast.50)
  sub.43 = f32[32,32]{1,0} subtract(neg.5, div.77)
  mul.264 = f32[32,32]{1,0} multiply(mul.256, broadcast.41)
  div.78 = f32[32,32]{1,0} divide(mul.264, broadcast.50)
  add.139 = f32[32,32]{1,0} add(sub.43, div.78)
  div.79 = f32[32,32]{1,0} divide(mul.257, broadcast.50)
  add.140 = f32[32,32]{1,0} add(add.139, div.79)
  div.80 = f32[32,32]{1,0} divide(mul.258, broadcast.50)
  sub.44 = f32[32,32]{1,0} subtract(add.140, div.80)
  jit__where_.88 = f32[32,32]{1,0} call(eq.88, sub.44, constant.92), to_apply=_where.21
  add.145 = f32[32,32]{1,0} add(add.144, jit__where_.88)
  eq.89 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.34), direction=EQ
  div.81 = f32[32,32]{1,0} divide(sub.32, broadcast.40)
  div.82 = f32[32,32]{1,0} divide(mul.256, broadcast.50)
  sub.45 = f32[32,32]{1,0} subtract(div.81, div.82)
  div.83 = f32[32,32]{1,0} divide(mul.258, broadcast.49)
  add.141 = f32[32,32]{1,0} add(sub.45, div.83)
  jit__where_.89 = f32[32,32]{1,0} call(eq.89, add.141, constant.92), to_apply=_where.21
  add.146 = f32[32,32]{1,0} add(add.145, jit__where_.89)
  broadcast_in_dim.16 = f32[32,32,1,1]{3,2,1,0} reshape(add.146)
  mul.265 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.16), dimensions={0,1,2,3}
  mul.266 = f32[32,32]{1,0} reshape(mul.265)
  mul.267 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.266), dimensions={0,1}
  constant.90 = s32[] constant(0)
  jit__pad_.2 = f32[32,32,38,32]{3,2,1,0} call(add.131, constant.90), to_apply=_pad.22
  slice.74 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [6:38], [0:32]}
  mul.268 = f32[32,32,32,32]{3,2,1,0} multiply(mul.267, slice.74)
  constant.57 = s32[] constant(0)
  broadcast.33 = s32[32,32]{1,0} broadcast(constant.57), dimensions={}
  eq.90 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.33), direction=EQ
  jit__where_.90 = f32[32,32]{1,0} call(eq.90, sub.35, constant.92), to_apply=_where.21
  eq.91 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.39), direction=EQ
  jit__where_.91 = f32[32,32]{1,0} call(eq.91, add.134, constant.92), to_apply=_where.21
  add.147 = f32[32,32]{1,0} add(jit__where_.90, jit__where_.91)
  eq.92 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.38), direction=EQ
  jit__where_.92 = f32[32,32]{1,0} call(eq.92, sub.40, constant.92), to_apply=_where.21
  add.148 = f32[32,32]{1,0} add(add.147, jit__where_.92)
  eq.93 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.37), direction=EQ
  jit__where_.93 = f32[32,32]{1,0} call(eq.93, add.138, constant.92), to_apply=_where.21
  add.149 = f32[32,32]{1,0} add(add.148, jit__where_.93)
  eq.94 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.36), direction=EQ
  jit__where_.94 = f32[32,32]{1,0} call(eq.94, sub.44, constant.92), to_apply=_where.21
  add.150 = f32[32,32]{1,0} add(add.149, jit__where_.94)
  eq.95 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.35), direction=EQ
  jit__where_.95 = f32[32,32]{1,0} call(eq.95, add.141, constant.92), to_apply=_where.21
  add.151 = f32[32,32]{1,0} add(add.150, jit__where_.95)
  broadcast_in_dim.17 = f32[32,32,1,1]{3,2,1,0} reshape(add.151)
  mul.269 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.17), dimensions={0,1,2,3}
  mul.270 = f32[32,32]{1,0} reshape(mul.269)
  mul.271 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.270), dimensions={0,1}
  slice.75 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [5:37], [0:32]}
  mul.272 = f32[32,32,32,32]{3,2,1,0} multiply(mul.271, slice.75)
  add.177 = f32[32,32,32,32]{3,2,1,0} add(mul.268, mul.272)
  constant.56 = s32[] constant(1)
  broadcast.32 = s32[32,32]{1,0} broadcast(constant.56), dimensions={}
  eq.96 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.32), direction=EQ
  jit__where_.96 = f32[32,32]{1,0} call(eq.96, sub.35, constant.92), to_apply=_where.21
  eq.97 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.33), direction=EQ
  jit__where_.97 = f32[32,32]{1,0} call(eq.97, add.134, constant.92), to_apply=_where.21
  add.152 = f32[32,32]{1,0} add(jit__where_.96, jit__where_.97)
  eq.98 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.39), direction=EQ
  jit__where_.98 = f32[32,32]{1,0} call(eq.98, sub.40, constant.92), to_apply=_where.21
  add.153 = f32[32,32]{1,0} add(add.152, jit__where_.98)
  eq.99 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.38), direction=EQ
  jit__where_.99 = f32[32,32]{1,0} call(eq.99, add.138, constant.92), to_apply=_where.21
  add.154 = f32[32,32]{1,0} add(add.153, jit__where_.99)
  eq.100 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.37), direction=EQ
  jit__where_.100 = f32[32,32]{1,0} call(eq.100, sub.44, constant.92), to_apply=_where.21
  add.155 = f32[32,32]{1,0} add(add.154, jit__where_.100)
  eq.101 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.36), direction=EQ
  jit__where_.101 = f32[32,32]{1,0} call(eq.101, add.141, constant.92), to_apply=_where.21
  add.156 = f32[32,32]{1,0} add(add.155, jit__where_.101)
  broadcast_in_dim.18 = f32[32,32,1,1]{3,2,1,0} reshape(add.156)
  mul.273 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.18), dimensions={0,1,2,3}
  mul.274 = f32[32,32]{1,0} reshape(mul.273)
  mul.275 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.274), dimensions={0,1}
  slice.76 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [4:36], [0:32]}
  mul.276 = f32[32,32,32,32]{3,2,1,0} multiply(mul.275, slice.76)
  add.178 = f32[32,32,32,32]{3,2,1,0} add(add.177, mul.276)
  constant.55 = s32[] constant(2)
  broadcast.31 = s32[32,32]{1,0} broadcast(constant.55), dimensions={}
  eq.102 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.31), direction=EQ
  jit__where_.102 = f32[32,32]{1,0} call(eq.102, sub.35, constant.92), to_apply=_where.21
  eq.103 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.32), direction=EQ
  jit__where_.103 = f32[32,32]{1,0} call(eq.103, add.134, constant.92), to_apply=_where.21
  add.157 = f32[32,32]{1,0} add(jit__where_.102, jit__where_.103)
  eq.104 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.33), direction=EQ
  jit__where_.104 = f32[32,32]{1,0} call(eq.104, sub.40, constant.92), to_apply=_where.21
  add.158 = f32[32,32]{1,0} add(add.157, jit__where_.104)
  eq.105 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.39), direction=EQ
  jit__where_.105 = f32[32,32]{1,0} call(eq.105, add.138, constant.92), to_apply=_where.21
  add.159 = f32[32,32]{1,0} add(add.158, jit__where_.105)
  eq.106 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.38), direction=EQ
  jit__where_.106 = f32[32,32]{1,0} call(eq.106, sub.44, constant.92), to_apply=_where.21
  add.160 = f32[32,32]{1,0} add(add.159, jit__where_.106)
  eq.107 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.37), direction=EQ
  jit__where_.107 = f32[32,32]{1,0} call(eq.107, add.141, constant.92), to_apply=_where.21
  add.161 = f32[32,32]{1,0} add(add.160, jit__where_.107)
  broadcast_in_dim.19 = f32[32,32,1,1]{3,2,1,0} reshape(add.161)
  mul.277 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.19), dimensions={0,1,2,3}
  mul.278 = f32[32,32]{1,0} reshape(mul.277)
  mul.279 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.278), dimensions={0,1}
  slice.77 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [3:35], [0:32]}
  mul.280 = f32[32,32,32,32]{3,2,1,0} multiply(mul.279, slice.77)
  add.179 = f32[32,32,32,32]{3,2,1,0} add(add.178, mul.280)
  constant.54 = s32[] constant(3)
  broadcast.30 = s32[32,32]{1,0} broadcast(constant.54), dimensions={}
  eq.108 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.30), direction=EQ
  jit__where_.108 = f32[32,32]{1,0} call(eq.108, sub.35, constant.92), to_apply=_where.21
  eq.109 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.31), direction=EQ
  jit__where_.109 = f32[32,32]{1,0} call(eq.109, add.134, constant.92), to_apply=_where.21
  add.162 = f32[32,32]{1,0} add(jit__where_.108, jit__where_.109)
  eq.110 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.32), direction=EQ
  jit__where_.110 = f32[32,32]{1,0} call(eq.110, sub.40, constant.92), to_apply=_where.21
  add.163 = f32[32,32]{1,0} add(add.162, jit__where_.110)
  eq.111 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.33), direction=EQ
  jit__where_.111 = f32[32,32]{1,0} call(eq.111, add.138, constant.92), to_apply=_where.21
  add.164 = f32[32,32]{1,0} add(add.163, jit__where_.111)
  eq.112 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.39), direction=EQ
  jit__where_.112 = f32[32,32]{1,0} call(eq.112, sub.44, constant.92), to_apply=_where.21
  add.165 = f32[32,32]{1,0} add(add.164, jit__where_.112)
  eq.113 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.38), direction=EQ
  jit__where_.113 = f32[32,32]{1,0} call(eq.113, add.141, constant.92), to_apply=_where.21
  add.166 = f32[32,32]{1,0} add(add.165, jit__where_.113)
  broadcast_in_dim.20 = f32[32,32,1,1]{3,2,1,0} reshape(add.166)
  mul.281 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.20), dimensions={0,1,2,3}
  mul.282 = f32[32,32]{1,0} reshape(mul.281)
  mul.283 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.282), dimensions={0,1}
  slice.78 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [2:34], [0:32]}
  mul.284 = f32[32,32,32,32]{3,2,1,0} multiply(mul.283, slice.78)
  add.180 = f32[32,32,32,32]{3,2,1,0} add(add.179, mul.284)
  constant.53 = s32[] constant(4)
  broadcast.29 = s32[32,32]{1,0} broadcast(constant.53), dimensions={}
  eq.114 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.29), direction=EQ
  jit__where_.114 = f32[32,32]{1,0} call(eq.114, sub.35, constant.92), to_apply=_where.21
  eq.115 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.30), direction=EQ
  jit__where_.115 = f32[32,32]{1,0} call(eq.115, add.134, constant.92), to_apply=_where.21
  add.167 = f32[32,32]{1,0} add(jit__where_.114, jit__where_.115)
  eq.116 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.31), direction=EQ
  jit__where_.116 = f32[32,32]{1,0} call(eq.116, sub.40, constant.92), to_apply=_where.21
  add.168 = f32[32,32]{1,0} add(add.167, jit__where_.116)
  eq.117 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.32), direction=EQ
  jit__where_.117 = f32[32,32]{1,0} call(eq.117, add.138, constant.92), to_apply=_where.21
  add.169 = f32[32,32]{1,0} add(add.168, jit__where_.117)
  eq.118 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.33), direction=EQ
  jit__where_.118 = f32[32,32]{1,0} call(eq.118, sub.44, constant.92), to_apply=_where.21
  add.170 = f32[32,32]{1,0} add(add.169, jit__where_.118)
  eq.119 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.39), direction=EQ
  jit__where_.119 = f32[32,32]{1,0} call(eq.119, add.141, constant.92), to_apply=_where.21
  add.171 = f32[32,32]{1,0} add(add.170, jit__where_.119)
  broadcast_in_dim.21 = f32[32,32,1,1]{3,2,1,0} reshape(add.171)
  mul.285 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.21), dimensions={0,1,2,3}
  mul.286 = f32[32,32]{1,0} reshape(mul.285)
  mul.287 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.286), dimensions={0,1}
  slice.79 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [1:33], [0:32]}
  mul.288 = f32[32,32,32,32]{3,2,1,0} multiply(mul.287, slice.79)
  add.181 = f32[32,32,32,32]{3,2,1,0} add(add.180, mul.288)
  constant.52 = s32[] constant(5)
  broadcast.28 = s32[32,32]{1,0} broadcast(constant.52), dimensions={}
  eq.120 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.28), direction=EQ
  jit__where_.120 = f32[32,32]{1,0} call(eq.120, sub.35, constant.92), to_apply=_where.21
  eq.121 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.29), direction=EQ
  jit__where_.121 = f32[32,32]{1,0} call(eq.121, add.134, constant.92), to_apply=_where.21
  add.172 = f32[32,32]{1,0} add(jit__where_.120, jit__where_.121)
  eq.122 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.30), direction=EQ
  jit__where_.122 = f32[32,32]{1,0} call(eq.122, sub.40, constant.92), to_apply=_where.21
  add.173 = f32[32,32]{1,0} add(add.172, jit__where_.122)
  eq.123 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.31), direction=EQ
  jit__where_.123 = f32[32,32]{1,0} call(eq.123, add.138, constant.92), to_apply=_where.21
  add.174 = f32[32,32]{1,0} add(add.173, jit__where_.123)
  eq.124 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.32), direction=EQ
  jit__where_.124 = f32[32,32]{1,0} call(eq.124, sub.44, constant.92), to_apply=_where.21
  add.175 = f32[32,32]{1,0} add(add.174, jit__where_.124)
  eq.125 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.33), direction=EQ
  jit__where_.125 = f32[32,32]{1,0} call(eq.125, add.141, constant.92), to_apply=_where.21
  add.176 = f32[32,32]{1,0} add(add.175, jit__where_.125)
  broadcast_in_dim.22 = f32[32,32,1,1]{3,2,1,0} reshape(add.176)
  mul.289 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.22), dimensions={0,1,2,3}
  mul.290 = f32[32,32]{1,0} reshape(mul.289)
  mul.291 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.290), dimensions={0,1}
  slice.80 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [0:32], [0:32]}
  mul.292 = f32[32,32,32,32]{3,2,1,0} multiply(mul.291, slice.80)
  add.182 = f32[32,32,32,32]{3,2,1,0} add(add.181, mul.292)
  jit__pad_.3 = f32[32,32,32,38]{3,2,1,0} call(add.182, constant.90), to_apply=_pad_129.23
  slice.81 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [6:38]}
  mul.307 = f32[32,32,32,32]{3,2,1,0} multiply(mul.306, slice.81)
  eq.132 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.33), direction=EQ
  jit__where_.132 = f32[32,32]{1,0} call(eq.132, sub.49, constant.92), to_apply=_where.21
  eq.133 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.39), direction=EQ
  jit__where_.133 = f32[32,32]{1,0} call(eq.133, add.185, constant.92), to_apply=_where.21
  add.198 = f32[32,32]{1,0} add(jit__where_.132, jit__where_.133)
  eq.134 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.38), direction=EQ
  jit__where_.134 = f32[32,32]{1,0} call(eq.134, sub.54, constant.92), to_apply=_where.21
  add.199 = f32[32,32]{1,0} add(add.198, jit__where_.134)
  eq.135 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.37), direction=EQ
  jit__where_.135 = f32[32,32]{1,0} call(eq.135, add.189, constant.92), to_apply=_where.21
  add.200 = f32[32,32]{1,0} add(add.199, jit__where_.135)
  eq.136 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.36), direction=EQ
  jit__where_.136 = f32[32,32]{1,0} call(eq.136, sub.58, constant.92), to_apply=_where.21
  add.201 = f32[32,32]{1,0} add(add.200, jit__where_.136)
  eq.137 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.35), direction=EQ
  jit__where_.137 = f32[32,32]{1,0} call(eq.137, add.192, constant.92), to_apply=_where.21
  add.202 = f32[32,32]{1,0} add(add.201, jit__where_.137)
  broadcast_in_dim.24 = f32[32,32,1,1]{3,2,1,0} reshape(add.202)
  mul.308 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.24), dimensions={0,1,2,3}
  mul.309 = f32[32,32]{1,0} reshape(mul.308)
  mul.310 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.309), dimensions={0,1}
  slice.82 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [5:37]}
  mul.311 = f32[32,32,32,32]{3,2,1,0} multiply(mul.310, slice.82)
  add.228 = f32[32,32,32,32]{3,2,1,0} add(mul.307, mul.311)
  eq.138 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.32), direction=EQ
  jit__where_.138 = f32[32,32]{1,0} call(eq.138, sub.49, constant.92), to_apply=_where.21
  eq.139 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.33), direction=EQ
  jit__where_.139 = f32[32,32]{1,0} call(eq.139, add.185, constant.92), to_apply=_where.21
  add.203 = f32[32,32]{1,0} add(jit__where_.138, jit__where_.139)
  eq.140 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.39), direction=EQ
  jit__where_.140 = f32[32,32]{1,0} call(eq.140, sub.54, constant.92), to_apply=_where.21
  add.204 = f32[32,32]{1,0} add(add.203, jit__where_.140)
  eq.141 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.38), direction=EQ
  jit__where_.141 = f32[32,32]{1,0} call(eq.141, add.189, constant.92), to_apply=_where.21
  add.205 = f32[32,32]{1,0} add(add.204, jit__where_.141)
  eq.142 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.37), direction=EQ
  jit__where_.142 = f32[32,32]{1,0} call(eq.142, sub.58, constant.92), to_apply=_where.21
  add.206 = f32[32,32]{1,0} add(add.205, jit__where_.142)
  eq.143 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.36), direction=EQ
  jit__where_.143 = f32[32,32]{1,0} call(eq.143, add.192, constant.92), to_apply=_where.21
  add.207 = f32[32,32]{1,0} add(add.206, jit__where_.143)
  broadcast_in_dim.25 = f32[32,32,1,1]{3,2,1,0} reshape(add.207)
  mul.312 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.25), dimensions={0,1,2,3}
  mul.313 = f32[32,32]{1,0} reshape(mul.312)
  mul.314 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.313), dimensions={0,1}
  slice.83 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [4:36]}
  mul.315 = f32[32,32,32,32]{3,2,1,0} multiply(mul.314, slice.83)
  add.229 = f32[32,32,32,32]{3,2,1,0} add(add.228, mul.315)
  eq.144 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.31), direction=EQ
  jit__where_.144 = f32[32,32]{1,0} call(eq.144, sub.49, constant.92), to_apply=_where.21
  eq.145 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.32), direction=EQ
  jit__where_.145 = f32[32,32]{1,0} call(eq.145, add.185, constant.92), to_apply=_where.21
  add.208 = f32[32,32]{1,0} add(jit__where_.144, jit__where_.145)
  eq.146 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.33), direction=EQ
  jit__where_.146 = f32[32,32]{1,0} call(eq.146, sub.54, constant.92), to_apply=_where.21
  add.209 = f32[32,32]{1,0} add(add.208, jit__where_.146)
  eq.147 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.39), direction=EQ
  jit__where_.147 = f32[32,32]{1,0} call(eq.147, add.189, constant.92), to_apply=_where.21
  add.210 = f32[32,32]{1,0} add(add.209, jit__where_.147)
  eq.148 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.38), direction=EQ
  jit__where_.148 = f32[32,32]{1,0} call(eq.148, sub.58, constant.92), to_apply=_where.21
  add.211 = f32[32,32]{1,0} add(add.210, jit__where_.148)
  eq.149 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.37), direction=EQ
  jit__where_.149 = f32[32,32]{1,0} call(eq.149, add.192, constant.92), to_apply=_where.21
  add.212 = f32[32,32]{1,0} add(add.211, jit__where_.149)
  broadcast_in_dim.26 = f32[32,32,1,1]{3,2,1,0} reshape(add.212)
  mul.316 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.26), dimensions={0,1,2,3}
  mul.317 = f32[32,32]{1,0} reshape(mul.316)
  mul.318 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.317), dimensions={0,1}
  slice.84 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [3:35]}
  mul.319 = f32[32,32,32,32]{3,2,1,0} multiply(mul.318, slice.84)
  add.230 = f32[32,32,32,32]{3,2,1,0} add(add.229, mul.319)
  eq.150 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.30), direction=EQ
  jit__where_.150 = f32[32,32]{1,0} call(eq.150, sub.49, constant.92), to_apply=_where.21
  eq.151 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.31), direction=EQ
  jit__where_.151 = f32[32,32]{1,0} call(eq.151, add.185, constant.92), to_apply=_where.21
  add.213 = f32[32,32]{1,0} add(jit__where_.150, jit__where_.151)
  eq.152 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.32), direction=EQ
  jit__where_.152 = f32[32,32]{1,0} call(eq.152, sub.54, constant.92), to_apply=_where.21
  add.214 = f32[32,32]{1,0} add(add.213, jit__where_.152)
  eq.153 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.33), direction=EQ
  jit__where_.153 = f32[32,32]{1,0} call(eq.153, add.189, constant.92), to_apply=_where.21
  add.215 = f32[32,32]{1,0} add(add.214, jit__where_.153)
  eq.154 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.39), direction=EQ
  jit__where_.154 = f32[32,32]{1,0} call(eq.154, sub.58, constant.92), to_apply=_where.21
  add.216 = f32[32,32]{1,0} add(add.215, jit__where_.154)
  eq.155 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.38), direction=EQ
  jit__where_.155 = f32[32,32]{1,0} call(eq.155, add.192, constant.92), to_apply=_where.21
  add.217 = f32[32,32]{1,0} add(add.216, jit__where_.155)
  broadcast_in_dim.27 = f32[32,32,1,1]{3,2,1,0} reshape(add.217)
  mul.320 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.27), dimensions={0,1,2,3}
  mul.321 = f32[32,32]{1,0} reshape(mul.320)
  mul.322 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.321), dimensions={0,1}
  slice.85 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [2:34]}
  mul.323 = f32[32,32,32,32]{3,2,1,0} multiply(mul.322, slice.85)
  add.231 = f32[32,32,32,32]{3,2,1,0} add(add.230, mul.323)
  eq.156 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.29), direction=EQ
  jit__where_.156 = f32[32,32]{1,0} call(eq.156, sub.49, constant.92), to_apply=_where.21
  eq.157 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.30), direction=EQ
  jit__where_.157 = f32[32,32]{1,0} call(eq.157, add.185, constant.92), to_apply=_where.21
  add.218 = f32[32,32]{1,0} add(jit__where_.156, jit__where_.157)
  eq.158 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.31), direction=EQ
  jit__where_.158 = f32[32,32]{1,0} call(eq.158, sub.54, constant.92), to_apply=_where.21
  add.219 = f32[32,32]{1,0} add(add.218, jit__where_.158)
  eq.159 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.32), direction=EQ
  jit__where_.159 = f32[32,32]{1,0} call(eq.159, add.189, constant.92), to_apply=_where.21
  add.220 = f32[32,32]{1,0} add(add.219, jit__where_.159)
  eq.160 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.33), direction=EQ
  jit__where_.160 = f32[32,32]{1,0} call(eq.160, sub.58, constant.92), to_apply=_where.21
  add.221 = f32[32,32]{1,0} add(add.220, jit__where_.160)
  eq.161 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.39), direction=EQ
  jit__where_.161 = f32[32,32]{1,0} call(eq.161, add.192, constant.92), to_apply=_where.21
  add.222 = f32[32,32]{1,0} add(add.221, jit__where_.161)
  broadcast_in_dim.28 = f32[32,32,1,1]{3,2,1,0} reshape(add.222)
  mul.324 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.28), dimensions={0,1,2,3}
  mul.325 = f32[32,32]{1,0} reshape(mul.324)
  mul.326 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.325), dimensions={0,1}
  slice.86 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [1:33]}
  mul.327 = f32[32,32,32,32]{3,2,1,0} multiply(mul.326, slice.86)
  add.232 = f32[32,32,32,32]{3,2,1,0} add(add.231, mul.327)
  eq.162 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.28), direction=EQ
  jit__where_.162 = f32[32,32]{1,0} call(eq.162, sub.49, constant.92), to_apply=_where.21
  eq.163 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.29), direction=EQ
  jit__where_.163 = f32[32,32]{1,0} call(eq.163, add.185, constant.92), to_apply=_where.21
  add.223 = f32[32,32]{1,0} add(jit__where_.162, jit__where_.163)
  eq.164 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.30), direction=EQ
  jit__where_.164 = f32[32,32]{1,0} call(eq.164, sub.54, constant.92), to_apply=_where.21
  add.224 = f32[32,32]{1,0} add(add.223, jit__where_.164)
  eq.165 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.31), direction=EQ
  jit__where_.165 = f32[32,32]{1,0} call(eq.165, add.189, constant.92), to_apply=_where.21
  add.225 = f32[32,32]{1,0} add(add.224, jit__where_.165)
  eq.166 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.32), direction=EQ
  jit__where_.166 = f32[32,32]{1,0} call(eq.166, sub.58, constant.92), to_apply=_where.21
  add.226 = f32[32,32]{1,0} add(add.225, jit__where_.166)
  eq.167 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.33), direction=EQ
  jit__where_.167 = f32[32,32]{1,0} call(eq.167, add.192, constant.92), to_apply=_where.21
  add.227 = f32[32,32]{1,0} add(add.226, jit__where_.167)
  broadcast_in_dim.29 = f32[32,32,1,1]{3,2,1,0} reshape(add.227)
  mul.328 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim.29), dimensions={0,1,2,3}
  mul.329 = f32[32,32]{1,0} reshape(mul.328)
  mul.330 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.329), dimensions={0,1}
  slice.87 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [0:32]}
  mul.331 = f32[32,32,32,32]{3,2,1,0} multiply(mul.330, slice.87)
  add.233 = f32[32,32,32,32]{3,2,1,0} add(add.232, mul.331)
  slice.88 = f32[32,32,32,16]{3,2,1,0} slice(add.233), slice={[0:32], [0:32], [0:32], [0:16]}
  jit__roll_static_.48 = f32[32,32,32,16]{3,2,1,0} call(slice.88), to_apply=_roll_static_45.9
  slice.89 = f32[32,32,32,16]{3,2,1,0} slice(add.233), slice={[0:32], [0:32], [0:32], [16:32]}
  jit__roll_static_.49 = f32[32,32,32,16]{3,2,1,0} call(slice.89), to_apply=_roll_static_50.10
  concatenate.30 = f32[32,32,32,32]{3,2,1,0} concatenate(jit__roll_static_.48, jit__roll_static_.49), dimensions={3}
  jit__roll_static_.50 = f32[32,32,32,32]{3,2,1,0} call(concatenate.30), to_apply=_roll_static_55.11
  mul.332 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.83), dimensions={0,1,2,3}
  mul.333 = f32[32]{0} reshape(mul.332)
  mul.334 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.333), dimensions={3}
  mul.335 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.50, mul.334)
  jit__roll_static_.51 = f32[32,32,32,32]{3,2,1,0} call(concatenate.30), to_apply=_roll_static_61.12
  mul.336 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.82), dimensions={0,1,2,3}
  mul.337 = f32[32]{0} reshape(mul.336)
  mul.338 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.337), dimensions={3}
  mul.339 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.51, mul.338)
  add.234 = f32[32,32,32,32]{3,2,1,0} add(mul.335, mul.339)
  jit__roll_static_.52 = f32[32,32,32,32]{3,2,1,0} call(concatenate.30), to_apply=_roll_static_65.13
  mul.340 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.81), dimensions={0,1,2,3}
  mul.341 = f32[32]{0} reshape(mul.340)
  mul.342 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.341), dimensions={3}
  mul.343 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.52, mul.342)
  add.235 = f32[32,32,32,32]{3,2,1,0} add(add.234, mul.343)
  jit__roll_static_.53 = f32[32,32,32,32]{3,2,1,0} call(concatenate.30), to_apply=_roll_static_68.14
  mul.344 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.80), dimensions={0,1,2,3}
  mul.345 = f32[32]{0} reshape(mul.344)
  mul.346 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.345), dimensions={3}
  mul.347 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.53, mul.346)
  add.236 = f32[32,32,32,32]{3,2,1,0} add(add.235, mul.347)
  jit__roll_static_.54 = f32[32,32,32,32]{3,2,1,0} call(concatenate.30), to_apply=_roll_static_72.15
  mul.348 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.79), dimensions={0,1,2,3}
  mul.349 = f32[32]{0} reshape(mul.348)
  mul.350 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.349), dimensions={3}
  mul.351 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.54, mul.350)
  add.237 = f32[32,32,32,32]{3,2,1,0} add(add.236, mul.351)
  jit__roll_static_.55 = f32[32,32,32,32]{3,2,1,0} call(concatenate.30), to_apply=_roll_static_76.16
  mul.352 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.78), dimensions={0,1,2,3}
  mul.353 = f32[32]{0} reshape(mul.352)
  mul.354 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.353), dimensions={3}
  mul.355 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.55, mul.354)
  add.238 = f32[32,32,32,32]{3,2,1,0} add(add.237, mul.355)
  slice.90 = f32[32,32,16,32]{3,2,1,0} slice(add.238), slice={[0:32], [0:32], [0:16], [0:32]}
  jit__roll_static_.56 = f32[32,32,16,32]{3,2,1,0} call(slice.90), to_apply=_roll_static.1
  slice.91 = f32[32,32,16,32]{3,2,1,0} slice(add.238), slice={[0:32], [0:32], [16:32], [0:32]}
  jit__roll_static_.57 = f32[32,32,16,32]{3,2,1,0} call(slice.91), to_apply=_roll_static_6.2
  concatenate.31 = f32[32,32,32,32]{3,2,1,0} concatenate(jit__roll_static_.56, jit__roll_static_.57), dimensions={2}
  jit__roll_static_.58 = f32[32,32,32,32]{3,2,1,0} call(concatenate.31), to_apply=_roll_static_12.3
  mul.356 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.89), dimensions={0,1,2,3}
  mul.357 = f32[32]{0} reshape(mul.356)
  mul.358 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.357), dimensions={2}
  mul.359 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.58, mul.358)
  jit__roll_static_.59 = f32[32,32,32,32]{3,2,1,0} call(concatenate.31), to_apply=_roll_static_19.4
  mul.360 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.88), dimensions={0,1,2,3}
  mul.361 = f32[32]{0} reshape(mul.360)
  mul.362 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.361), dimensions={2}
  mul.363 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.59, mul.362)
  add.239 = f32[32,32,32,32]{3,2,1,0} add(mul.359, mul.363)
  jit__roll_static_.60 = f32[32,32,32,32]{3,2,1,0} call(concatenate.31), to_apply=_roll_static_24.5
  mul.364 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.87), dimensions={0,1,2,3}
  mul.365 = f32[32]{0} reshape(mul.364)
  mul.366 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.365), dimensions={2}
  mul.367 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.60, mul.366)
  add.240 = f32[32,32,32,32]{3,2,1,0} add(add.239, mul.367)
  jit__roll_static_.61 = f32[32,32,32,32]{3,2,1,0} call(concatenate.31), to_apply=_roll_static_29.6
  mul.368 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.86), dimensions={0,1,2,3}
  mul.369 = f32[32]{0} reshape(mul.368)
  mul.370 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.369), dimensions={2}
  mul.371 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.61, mul.370)
  add.241 = f32[32,32,32,32]{3,2,1,0} add(add.240, mul.371)
  jit__roll_static_.62 = f32[32,32,32,32]{3,2,1,0} call(concatenate.31), to_apply=_roll_static_34.7
  mul.372 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.85), dimensions={0,1,2,3}
  mul.373 = f32[32]{0} reshape(mul.372)
  mul.374 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.373), dimensions={2}
  mul.375 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.62, mul.374)
  add.242 = f32[32,32,32,32]{3,2,1,0} add(add.241, mul.375)
  jit__roll_static_.63 = f32[32,32,32,32]{3,2,1,0} call(concatenate.31), to_apply=_roll_static_39.8
  mul.376 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.84), dimensions={0,1,2,3}
  mul.377 = f32[32]{0} reshape(mul.376)
  mul.378 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.377), dimensions={2}
  mul.379 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.63, mul.378)
  add.243 = f32[32,32,32,32]{3,2,1,0} add(add.242, mul.379)
  jit_solve_poisson_.8 = f32[32,32]{1,0} get-tuple-element(jit_solve_poisson_.5), index=2
  jit_solve_poisson_.9 = f32[32,32]{1,0} get-tuple-element(jit_solve_poisson_.5), index=3
  ROOT tuple.3 = (f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(add.243, jit_solve_poisson_.8, jit_solve_poisson_.9)
}

