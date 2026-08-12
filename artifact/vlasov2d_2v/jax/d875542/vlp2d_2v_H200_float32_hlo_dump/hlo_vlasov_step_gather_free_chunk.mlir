HloModule jit_run_chunk, entry_computation_layout={(f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[], /*index=5*/s32[])->(f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,1]{1,0}, /*index=5*/f32[1,17]{1,0}, f32[32,17]{1,0}, s32[6]{0}, f32[32,32]{1,0}, f32[32,32]{1,0}, /*index=10*/f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[], s32[])}

_roll_static.1 {
  Arg_0.2 = f32[32,32,16,32]{3,2,1,0} parameter(0)
  slice.3 = f32[31,32,16,32]{3,2,1,0} slice(Arg_0.2), slice={[1:32], [0:32], [0:16], [0:32]}
  slice.4 = f32[1,32,16,32]{3,2,1,0} slice(Arg_0.2), slice={[0:1], [0:32], [0:16], [0:32]}
  ROOT concatenate.1 = f32[32,32,16,32]{3,2,1,0} concatenate(slice.3, slice.4), dimensions={0}
}

_roll_static_6.2 {
  ROOT Arg_0.4 = f32[32,32,16,32]{3,2,1,0} parameter(0)
}

_roll_static_12.3 {
  Arg_0.6 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.8 = f32[30,32,32,32]{3,2,1,0} slice(Arg_0.6), slice={[2:32], [0:32], [0:32], [0:32]}
  slice.9 = f32[2,32,32,32]{3,2,1,0} slice(Arg_0.6), slice={[0:2], [0:32], [0:32], [0:32]}
  ROOT concatenate.4 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.8, slice.9), dimensions={0}
}

_roll_static_19.4 {
  Arg_0.8 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.12 = f32[31,32,32,32]{3,2,1,0} slice(Arg_0.8), slice={[1:32], [0:32], [0:32], [0:32]}
  slice.13 = f32[1,32,32,32]{3,2,1,0} slice(Arg_0.8), slice={[0:1], [0:32], [0:32], [0:32]}
  ROOT concatenate.6 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.12, slice.13), dimensions={0}
}

_roll_static_24.5 {
  ROOT Arg_0.10 = f32[32,32,32,32]{3,2,1,0} parameter(0)
}

_roll_static_29.6 {
  Arg_0.12 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.16 = f32[1,32,32,32]{3,2,1,0} slice(Arg_0.12), slice={[31:32], [0:32], [0:32], [0:32]}
  slice.17 = f32[31,32,32,32]{3,2,1,0} slice(Arg_0.12), slice={[0:31], [0:32], [0:32], [0:32]}
  ROOT concatenate.8 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.16, slice.17), dimensions={0}
}

_roll_static_34.7 {
  Arg_0.14 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.20 = f32[2,32,32,32]{3,2,1,0} slice(Arg_0.14), slice={[30:32], [0:32], [0:32], [0:32]}
  slice.21 = f32[30,32,32,32]{3,2,1,0} slice(Arg_0.14), slice={[0:30], [0:32], [0:32], [0:32]}
  ROOT concatenate.10 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.20, slice.21), dimensions={0}
}

_roll_static_39.8 {
  Arg_0.16 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.24 = f32[3,32,32,32]{3,2,1,0} slice(Arg_0.16), slice={[29:32], [0:32], [0:32], [0:32]}
  slice.25 = f32[29,32,32,32]{3,2,1,0} slice(Arg_0.16), slice={[0:29], [0:32], [0:32], [0:32]}
  ROOT concatenate.12 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.24, slice.25), dimensions={0}
}

_roll_static_45.9 {
  Arg_0.18 = f32[32,32,32,16]{3,2,1,0} parameter(0)
  slice.29 = f32[32,31,32,16]{3,2,1,0} slice(Arg_0.18), slice={[0:32], [1:32], [0:32], [0:16]}
  slice.30 = f32[32,1,32,16]{3,2,1,0} slice(Arg_0.18), slice={[0:32], [0:1], [0:32], [0:16]}
  ROOT concatenate.14 = f32[32,32,32,16]{3,2,1,0} concatenate(slice.29, slice.30), dimensions={1}
}

_roll_static_50.10 {
  ROOT Arg_0.20 = f32[32,32,32,16]{3,2,1,0} parameter(0)
}

_roll_static_55.11 {
  Arg_0.22 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.34 = f32[32,30,32,32]{3,2,1,0} slice(Arg_0.22), slice={[0:32], [2:32], [0:32], [0:32]}
  slice.35 = f32[32,2,32,32]{3,2,1,0} slice(Arg_0.22), slice={[0:32], [0:2], [0:32], [0:32]}
  ROOT concatenate.17 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.34, slice.35), dimensions={1}
}

_roll_static_61.12 {
  Arg_0.24 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.38 = f32[32,31,32,32]{3,2,1,0} slice(Arg_0.24), slice={[0:32], [1:32], [0:32], [0:32]}
  slice.39 = f32[32,1,32,32]{3,2,1,0} slice(Arg_0.24), slice={[0:32], [0:1], [0:32], [0:32]}
  ROOT concatenate.19 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.38, slice.39), dimensions={1}
}

_roll_static_65.13 {
  ROOT Arg_0.26 = f32[32,32,32,32]{3,2,1,0} parameter(0)
}

_roll_static_68.14 {
  Arg_0.28 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.42 = f32[32,1,32,32]{3,2,1,0} slice(Arg_0.28), slice={[0:32], [31:32], [0:32], [0:32]}
  slice.43 = f32[32,31,32,32]{3,2,1,0} slice(Arg_0.28), slice={[0:32], [0:31], [0:32], [0:32]}
  ROOT concatenate.21 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.42, slice.43), dimensions={1}
}

_roll_static_72.15 {
  Arg_0.30 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.46 = f32[32,2,32,32]{3,2,1,0} slice(Arg_0.30), slice={[0:32], [30:32], [0:32], [0:32]}
  slice.47 = f32[32,30,32,32]{3,2,1,0} slice(Arg_0.30), slice={[0:32], [0:30], [0:32], [0:32]}
  ROOT concatenate.23 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.46, slice.47), dimensions={1}
}

_roll_static_76.16 {
  Arg_0.32 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.50 = f32[32,3,32,32]{3,2,1,0} slice(Arg_0.32), slice={[0:32], [29:32], [0:32], [0:32]}
  slice.51 = f32[32,29,32,32]{3,2,1,0} slice(Arg_0.32), slice={[0:32], [0:29], [0:32], [0:32]}
  ROOT concatenate.25 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.50, slice.51), dimensions={1}
}

region_1.17 {
  reduce_sum.3 = f32[] parameter(0)
  reduce_sum.4 = f32[] parameter(1)
  ROOT reduce_sum.5 = f32[] add(reduce_sum.3, reduce_sum.4)
}

fft.18 {
  Arg_0.35 = f32[32,32]{1,0} parameter(0)
  ROOT fft.1 = c64[32,17]{1,0} fft(Arg_0.35), fft_type=RFFT, fft_length={32,32}
}

fft_85.19 {
  Arg_0.37 = c64[32,17]{1,0} parameter(0)
  ROOT fft.3 = f32[32,32]{1,0} fft(Arg_0.37), fft_type=IRFFT, fft_length={32,32}
}

solve_poisson.20 {
  Arg_1.2 = f32[32,1]{1,0} parameter(1)
  convert_element_type.4 = c64[32,1]{1,0} convert(Arg_1.2)
  constant.60 = c64[] constant((-0, -1))
  mul.84 = c64[32,1]{1,0} broadcast(constant.60), dimensions={}
  mul.90 = c64[32,1]{1,0} multiply(convert_element_type.4, mul.84)
  mul.91 = c64[32,1]{1,0} broadcast(mul.90), dimensions={0,1}
  mul.92 = c64[32]{0} reshape(mul.91)
  mul.93 = c64[32,17]{1,0} broadcast(mul.92), dimensions={0}
  Arg_0.38 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  constant.62 = f32[] constant(0)
  reduce_sum.7 = f32[32,32]{1,0} reduce(Arg_0.38, constant.62), dimensions={2,3}, to_apply=region_1.17
  Arg_4.2 = f32[] parameter(4)
  mul.85 = f32[32,32]{1,0} broadcast(Arg_4.2), dimensions={}
  mul.86 = f32[32,32]{1,0} multiply(reduce_sum.7, mul.85)
  Arg_5.2 = f32[] parameter(5)
  mul.87 = f32[32,32]{1,0} broadcast(Arg_5.2), dimensions={}
  mul.88 = f32[32,32]{1,0} multiply(mul.86, mul.87)
  constant.61 = f32[] constant(1)
  sub.28 = f32[32,32]{1,0} broadcast(constant.61), dimensions={}
  sub.29 = f32[32,32]{1,0} subtract(mul.88, sub.28)
  jit_fft_.4 = c64[32,17]{1,0} call(sub.29), to_apply=fft.18
  Arg_3.2 = f32[32,17]{1,0} parameter(3)
  convert_element_type.3 = c64[32,17]{1,0} convert(Arg_3.2)
  mul.89 = c64[32,17]{1,0} multiply(jit_fft_.4, convert_element_type.3)
  mul.94 = c64[32,17]{1,0} multiply(mul.93, mul.89)
  jit_fft_.6 = f32[32,32]{1,0} call(mul.94), to_apply=fft_85.19
  Arg_2.2 = f32[1,17]{1,0} parameter(2)
  convert_element_type.5 = c64[1,17]{1,0} convert(Arg_2.2)
  constant.59 = c64[] constant((-0, -1))
  broadcast.39 = c64[1,17]{1,0} broadcast(constant.59), dimensions={}
  mul.95 = c64[1,17]{1,0} multiply(convert_element_type.5, broadcast.39)
  mul.96 = c64[1,17]{1,0} broadcast(mul.95), dimensions={0,1}
  mul.97 = c64[17]{0} reshape(mul.96)
  mul.98 = c64[32,17]{1,0} broadcast(mul.97), dimensions={1}
  mul.99 = c64[32,17]{1,0} multiply(mul.98, mul.89)
  jit_fft_.7 = f32[32,32]{1,0} call(mul.99), to_apply=fft_85.19
  jit_fft_.5 = f32[32,32]{1,0} call(mul.89), to_apply=fft_85.19
  ROOT tuple.1 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(jit_fft_.6, jit_fft_.7, sub.29, jit_fft_.5)
}

_where.21 {
  Arg_0.40 = pred[32,32]{1,0} parameter(0)
  Arg_1.4 = f32[32,32]{1,0} parameter(1)
  Arg_2.4 = f32[] parameter(2)
  broadcast_in_dim.1 = f32[32,32]{1,0} broadcast(Arg_2.4), dimensions={}
  ROOT select_n.1 = f32[32,32]{1,0} select(Arg_0.40, Arg_1.4, broadcast_in_dim.1)
}

_pad.22 {
  Arg_0.42 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  Arg_1.6 = s32[] parameter(1)
  convert_element_type.8 = f32[] convert(Arg_1.6)
  ROOT pad.1 = f32[32,32,38,32]{3,2,1,0} pad(Arg_0.42, convert_element_type.8), padding=0_0x0_0x3_3x0_0
}

_pad_129.23 {
  Arg_0.44 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  Arg_1.8 = s32[] parameter(1)
  convert_element_type.11 = f32[] convert(Arg_1.8)
  ROOT pad.3 = f32[32,32,32,38]{3,2,1,0} pad(Arg_0.44, convert_element_type.11), padding=0_0x0_0x0_0x3_3
}

closed_call.24 {
  Arg_6.1 = f32[32,32]{1,0} parameter(6)
  Arg_7.1 = f32[32,32]{1,0} parameter(7)
  Arg_5.3 = f32[32,32,32,32]{3,2,1,0} parameter(5)
  slice.70 = f32[32,32,16,32]{3,2,1,0} slice(Arg_5.3), slice={[0:32], [0:32], [0:16], [0:32]}
  jit__roll_static_.32 = f32[32,32,16,32]{3,2,1,0} call(slice.70), to_apply=_roll_static.1
  slice.71 = f32[32,32,16,32]{3,2,1,0} slice(Arg_5.3), slice={[0:32], [0:32], [16:32], [0:32]}
  jit__roll_static_.33 = f32[32,32,16,32]{3,2,1,0} call(slice.71), to_apply=_roll_static_6.2
  concatenate.28 = f32[32,32,32,32]{3,2,1,0} concatenate(jit__roll_static_.32, jit__roll_static_.33), dimensions={2}
  jit__roll_static_.34 = f32[32,32,32,32]{3,2,1,0} call(concatenate.28), to_apply=_roll_static_12.3
  Arg_0.45 = f32[32]{0} parameter(0)
  constant.100 = f32[] constant(20)
  broadcast.77 = f32[32]{0} broadcast(constant.100), dimensions={}
  div.110 = f32[32]{0} divide(Arg_0.45, broadcast.77)
  mul.226 = f32[32]{0} multiply(Arg_0.45, Arg_0.45)
  constant.99 = f32[] constant(24)
  broadcast.76 = f32[32]{0} broadcast(constant.99), dimensions={}
  div.111 = f32[32]{0} divide(mul.226, broadcast.76)
  sub.58 = f32[32]{0} subtract(div.110, div.111)
  mul.227 = f32[32]{0} multiply(mul.226, Arg_0.45)
  div.112 = f32[32]{0} divide(mul.227, broadcast.76)
  sub.59 = f32[32]{0} subtract(sub.58, div.112)
  mul.228 = f32[32]{0} multiply(mul.227, Arg_0.45)
  div.113 = f32[32]{0} divide(mul.228, broadcast.76)
  add.142 = f32[32]{0} add(sub.59, div.113)
  mul.229 = f32[32]{0} multiply(mul.228, Arg_0.45)
  constant.98 = f32[] constant(120)
  broadcast.75 = f32[32]{0} broadcast(constant.98), dimensions={}
  div.114 = f32[32]{0} divide(mul.229, broadcast.75)
  sub.60 = f32[32]{0} subtract(add.142, div.114)
  reshape_squeeze_broadcast_in_dim.24 = f32[1,1,32,1]{3,2,1,0} reshape(sub.60)
  mul.246 = f32[1,1,32,1]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.24), dimensions={0,1,2,3}
  mul.247 = f32[32]{0} reshape(mul.246)
  mul.248 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.247), dimensions={2}
  mul.249 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.34, mul.248)
  jit__roll_static_.35 = f32[32,32,32,32]{3,2,1,0} call(concatenate.28), to_apply=_roll_static_19.4
  constant.97 = f32[] constant(2)
  broadcast.74 = f32[32]{0} broadcast(constant.97), dimensions={}
  div.115 = f32[32]{0} divide(Arg_0.45, broadcast.74)
  neg.8 = f32[32]{0} negate(div.115)
  mul.230 = f32[32]{0} multiply(mul.226, broadcast.74)
  constant.96 = f32[] constant(3)
  broadcast.73 = f32[32]{0} broadcast(constant.96), dimensions={}
  div.116 = f32[32]{0} divide(mul.230, broadcast.73)
  add.143 = f32[32]{0} add(neg.8, div.116)
  div.117 = f32[32]{0} divide(mul.227, broadcast.76)
  sub.61 = f32[32]{0} subtract(add.143, div.117)
  constant.95 = f32[] constant(6)
  broadcast.72 = f32[32]{0} broadcast(constant.95), dimensions={}
  div.118 = f32[32]{0} divide(mul.228, broadcast.72)
  sub.62 = f32[32]{0} subtract(sub.61, div.118)
  div.119 = f32[32]{0} divide(mul.229, broadcast.76)
  add.144 = f32[32]{0} add(sub.62, div.119)
  reshape_squeeze_broadcast_in_dim.25 = f32[1,1,32,1]{3,2,1,0} reshape(add.144)
  mul.250 = f32[1,1,32,1]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.25), dimensions={0,1,2,3}
  mul.251 = f32[32]{0} reshape(mul.250)
  mul.252 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.251), dimensions={2}
  mul.253 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.35, mul.252)
  add.162 = f32[32,32,32,32]{3,2,1,0} add(mul.249, mul.253)
  jit__roll_static_.36 = f32[32,32,32,32]{3,2,1,0} call(concatenate.28), to_apply=_roll_static_24.5
  constant.94 = f32[] constant(1)
  broadcast.71 = f32[32]{0} broadcast(constant.94), dimensions={}
  div.120 = f32[32]{0} divide(Arg_0.45, broadcast.73)
  sub.63 = f32[32]{0} subtract(broadcast.71, div.120)
  constant.93 = f32[] constant(5)
  broadcast.70 = f32[32]{0} broadcast(constant.93), dimensions={}
  mul.231 = f32[32]{0} multiply(mul.226, broadcast.70)
  constant.92 = f32[] constant(4)
  broadcast.69 = f32[32]{0} broadcast(constant.92), dimensions={}
  div.121 = f32[32]{0} divide(mul.231, broadcast.69)
  sub.64 = f32[32]{0} subtract(sub.63, div.121)
  mul.232 = f32[32]{0} multiply(mul.227, broadcast.70)
  constant.91 = f32[] constant(12)
  broadcast.68 = f32[32]{0} broadcast(constant.91), dimensions={}
  div.122 = f32[32]{0} divide(mul.232, broadcast.68)
  add.145 = f32[32]{0} add(sub.64, div.122)
  div.123 = f32[32]{0} divide(mul.228, broadcast.69)
  add.146 = f32[32]{0} add(add.145, div.123)
  div.124 = f32[32]{0} divide(mul.229, broadcast.68)
  sub.65 = f32[32]{0} subtract(add.146, div.124)
  reshape_squeeze_broadcast_in_dim.26 = f32[1,1,32,1]{3,2,1,0} reshape(sub.65)
  mul.254 = f32[1,1,32,1]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.26), dimensions={0,1,2,3}
  mul.255 = f32[32]{0} reshape(mul.254)
  mul.256 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.255), dimensions={2}
  mul.257 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.36, mul.256)
  add.163 = f32[32,32,32,32]{3,2,1,0} add(add.162, mul.257)
  jit__roll_static_.37 = f32[32,32,32,32]{3,2,1,0} call(concatenate.28), to_apply=_roll_static_29.6
  mul.233 = f32[32]{0} multiply(mul.226, broadcast.74)
  div.125 = f32[32]{0} divide(mul.233, broadcast.73)
  add.147 = f32[32]{0} add(Arg_0.45, div.125)
  constant.90 = f32[] constant(7)
  broadcast.67 = f32[32]{0} broadcast(constant.90), dimensions={}
  mul.234 = f32[32]{0} multiply(mul.227, broadcast.67)
  div.126 = f32[32]{0} divide(mul.234, broadcast.68)
  sub.66 = f32[32]{0} subtract(add.147, div.126)
  div.127 = f32[32]{0} divide(mul.228, broadcast.72)
  sub.67 = f32[32]{0} subtract(sub.66, div.127)
  div.128 = f32[32]{0} divide(mul.229, broadcast.68)
  add.148 = f32[32]{0} add(sub.67, div.128)
  reshape_squeeze_broadcast_in_dim.27 = f32[1,1,32,1]{3,2,1,0} reshape(add.148)
  mul.258 = f32[1,1,32,1]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.27), dimensions={0,1,2,3}
  mul.259 = f32[32]{0} reshape(mul.258)
  mul.260 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.259), dimensions={2}
  mul.261 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.37, mul.260)
  add.164 = f32[32,32,32,32]{3,2,1,0} add(add.163, mul.261)
  jit__roll_static_.38 = f32[32,32,32,32]{3,2,1,0} call(concatenate.28), to_apply=_roll_static_34.7
  div.129 = f32[32]{0} divide(Arg_0.45, broadcast.69)
  neg.9 = f32[32]{0} negate(div.129)
  div.130 = f32[32]{0} divide(mul.226, broadcast.76)
  sub.68 = f32[32]{0} subtract(neg.9, div.130)
  mul.235 = f32[32]{0} multiply(mul.227, broadcast.67)
  div.131 = f32[32]{0} divide(mul.235, broadcast.76)
  add.149 = f32[32]{0} add(sub.68, div.131)
  div.132 = f32[32]{0} divide(mul.228, broadcast.76)
  add.150 = f32[32]{0} add(add.149, div.132)
  div.133 = f32[32]{0} divide(mul.229, broadcast.76)
  sub.69 = f32[32]{0} subtract(add.150, div.133)
  reshape_squeeze_broadcast_in_dim.28 = f32[1,1,32,1]{3,2,1,0} reshape(sub.69)
  mul.262 = f32[1,1,32,1]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.28), dimensions={0,1,2,3}
  mul.263 = f32[32]{0} reshape(mul.262)
  mul.264 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.263), dimensions={2}
  mul.265 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.38, mul.264)
  add.165 = f32[32,32,32,32]{3,2,1,0} add(add.164, mul.265)
  jit__roll_static_.39 = f32[32,32,32,32]{3,2,1,0} call(concatenate.28), to_apply=_roll_static_39.8
  constant.89 = f32[] constant(30)
  broadcast.66 = f32[32]{0} broadcast(constant.89), dimensions={}
  div.134 = f32[32]{0} divide(Arg_0.45, broadcast.66)
  div.135 = f32[32]{0} divide(mul.227, broadcast.76)
  sub.70 = f32[32]{0} subtract(div.134, div.135)
  div.136 = f32[32]{0} divide(mul.229, broadcast.75)
  add.151 = f32[32]{0} add(sub.70, div.136)
  reshape_squeeze_broadcast_in_dim.29 = f32[1,1,32,1]{3,2,1,0} reshape(add.151)
  mul.266 = f32[1,1,32,1]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.29), dimensions={0,1,2,3}
  mul.267 = f32[32]{0} reshape(mul.266)
  mul.268 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.267), dimensions={2}
  mul.269 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.39, mul.268)
  add.166 = f32[32,32,32,32]{3,2,1,0} add(add.165, mul.269)
  slice.72 = f32[32,32,32,16]{3,2,1,0} slice(add.166), slice={[0:32], [0:32], [0:32], [0:16]}
  jit__roll_static_.40 = f32[32,32,32,16]{3,2,1,0} call(slice.72), to_apply=_roll_static_45.9
  slice.73 = f32[32,32,32,16]{3,2,1,0} slice(add.166), slice={[0:32], [0:32], [0:32], [16:32]}
  jit__roll_static_.41 = f32[32,32,32,16]{3,2,1,0} call(slice.73), to_apply=_roll_static_50.10
  concatenate.29 = f32[32,32,32,32]{3,2,1,0} concatenate(jit__roll_static_.40, jit__roll_static_.41), dimensions={3}
  jit__roll_static_.42 = f32[32,32,32,32]{3,2,1,0} call(concatenate.29), to_apply=_roll_static_55.11
  Arg_1.9 = f32[32]{0} parameter(1)
  div.137 = f32[32]{0} divide(Arg_1.9, broadcast.77)
  mul.236 = f32[32]{0} multiply(Arg_1.9, Arg_1.9)
  div.138 = f32[32]{0} divide(mul.236, broadcast.76)
  sub.71 = f32[32]{0} subtract(div.137, div.138)
  mul.237 = f32[32]{0} multiply(mul.236, Arg_1.9)
  div.139 = f32[32]{0} divide(mul.237, broadcast.76)
  sub.72 = f32[32]{0} subtract(sub.71, div.139)
  mul.238 = f32[32]{0} multiply(mul.237, Arg_1.9)
  div.140 = f32[32]{0} divide(mul.238, broadcast.76)
  add.152 = f32[32]{0} add(sub.72, div.140)
  mul.239 = f32[32]{0} multiply(mul.238, Arg_1.9)
  div.141 = f32[32]{0} divide(mul.239, broadcast.75)
  sub.73 = f32[32]{0} subtract(add.152, div.141)
  reshape_squeeze_broadcast_in_dim.30 = f32[1,1,1,32]{3,2,1,0} reshape(sub.73)
  mul.270 = f32[1,1,1,32]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.30), dimensions={0,1,2,3}
  mul.271 = f32[32]{0} reshape(mul.270)
  mul.272 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.271), dimensions={3}
  mul.273 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.42, mul.272)
  jit__roll_static_.43 = f32[32,32,32,32]{3,2,1,0} call(concatenate.29), to_apply=_roll_static_61.12
  div.142 = f32[32]{0} divide(Arg_1.9, broadcast.74)
  neg.10 = f32[32]{0} negate(div.142)
  mul.240 = f32[32]{0} multiply(mul.236, broadcast.74)
  div.143 = f32[32]{0} divide(mul.240, broadcast.73)
  add.153 = f32[32]{0} add(neg.10, div.143)
  div.144 = f32[32]{0} divide(mul.237, broadcast.76)
  sub.74 = f32[32]{0} subtract(add.153, div.144)
  div.145 = f32[32]{0} divide(mul.238, broadcast.72)
  sub.75 = f32[32]{0} subtract(sub.74, div.145)
  div.146 = f32[32]{0} divide(mul.239, broadcast.76)
  add.154 = f32[32]{0} add(sub.75, div.146)
  reshape_squeeze_broadcast_in_dim.31 = f32[1,1,1,32]{3,2,1,0} reshape(add.154)
  mul.274 = f32[1,1,1,32]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.31), dimensions={0,1,2,3}
  mul.275 = f32[32]{0} reshape(mul.274)
  mul.276 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.275), dimensions={3}
  mul.277 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.43, mul.276)
  add.167 = f32[32,32,32,32]{3,2,1,0} add(mul.273, mul.277)
  jit__roll_static_.44 = f32[32,32,32,32]{3,2,1,0} call(concatenate.29), to_apply=_roll_static_65.13
  div.147 = f32[32]{0} divide(Arg_1.9, broadcast.73)
  sub.76 = f32[32]{0} subtract(broadcast.71, div.147)
  mul.241 = f32[32]{0} multiply(mul.236, broadcast.70)
  div.148 = f32[32]{0} divide(mul.241, broadcast.69)
  sub.77 = f32[32]{0} subtract(sub.76, div.148)
  mul.242 = f32[32]{0} multiply(mul.237, broadcast.70)
  div.149 = f32[32]{0} divide(mul.242, broadcast.68)
  add.155 = f32[32]{0} add(sub.77, div.149)
  div.150 = f32[32]{0} divide(mul.238, broadcast.69)
  add.156 = f32[32]{0} add(add.155, div.150)
  div.151 = f32[32]{0} divide(mul.239, broadcast.68)
  sub.78 = f32[32]{0} subtract(add.156, div.151)
  reshape_squeeze_broadcast_in_dim.32 = f32[1,1,1,32]{3,2,1,0} reshape(sub.78)
  mul.278 = f32[1,1,1,32]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.32), dimensions={0,1,2,3}
  mul.279 = f32[32]{0} reshape(mul.278)
  mul.280 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.279), dimensions={3}
  mul.281 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.44, mul.280)
  add.168 = f32[32,32,32,32]{3,2,1,0} add(add.167, mul.281)
  jit__roll_static_.45 = f32[32,32,32,32]{3,2,1,0} call(concatenate.29), to_apply=_roll_static_68.14
  mul.243 = f32[32]{0} multiply(mul.236, broadcast.74)
  div.152 = f32[32]{0} divide(mul.243, broadcast.73)
  add.157 = f32[32]{0} add(Arg_1.9, div.152)
  mul.244 = f32[32]{0} multiply(mul.237, broadcast.67)
  div.153 = f32[32]{0} divide(mul.244, broadcast.68)
  sub.79 = f32[32]{0} subtract(add.157, div.153)
  div.154 = f32[32]{0} divide(mul.238, broadcast.72)
  sub.80 = f32[32]{0} subtract(sub.79, div.154)
  div.155 = f32[32]{0} divide(mul.239, broadcast.68)
  add.158 = f32[32]{0} add(sub.80, div.155)
  reshape_squeeze_broadcast_in_dim.33 = f32[1,1,1,32]{3,2,1,0} reshape(add.158)
  mul.282 = f32[1,1,1,32]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.33), dimensions={0,1,2,3}
  mul.283 = f32[32]{0} reshape(mul.282)
  mul.284 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.283), dimensions={3}
  mul.285 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.45, mul.284)
  add.169 = f32[32,32,32,32]{3,2,1,0} add(add.168, mul.285)
  jit__roll_static_.46 = f32[32,32,32,32]{3,2,1,0} call(concatenate.29), to_apply=_roll_static_72.15
  div.156 = f32[32]{0} divide(Arg_1.9, broadcast.69)
  neg.11 = f32[32]{0} negate(div.156)
  div.157 = f32[32]{0} divide(mul.236, broadcast.76)
  sub.81 = f32[32]{0} subtract(neg.11, div.157)
  mul.245 = f32[32]{0} multiply(mul.237, broadcast.67)
  div.158 = f32[32]{0} divide(mul.245, broadcast.76)
  add.159 = f32[32]{0} add(sub.81, div.158)
  div.159 = f32[32]{0} divide(mul.238, broadcast.76)
  add.160 = f32[32]{0} add(add.159, div.159)
  div.160 = f32[32]{0} divide(mul.239, broadcast.76)
  sub.82 = f32[32]{0} subtract(add.160, div.160)
  reshape_squeeze_broadcast_in_dim.34 = f32[1,1,1,32]{3,2,1,0} reshape(sub.82)
  mul.286 = f32[1,1,1,32]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.34), dimensions={0,1,2,3}
  mul.287 = f32[32]{0} reshape(mul.286)
  mul.288 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.287), dimensions={3}
  mul.289 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.46, mul.288)
  add.170 = f32[32,32,32,32]{3,2,1,0} add(add.169, mul.289)
  jit__roll_static_.47 = f32[32,32,32,32]{3,2,1,0} call(concatenate.29), to_apply=_roll_static_76.16
  div.161 = f32[32]{0} divide(Arg_1.9, broadcast.66)
  div.162 = f32[32]{0} divide(mul.237, broadcast.76)
  sub.83 = f32[32]{0} subtract(div.161, div.162)
  div.163 = f32[32]{0} divide(mul.239, broadcast.75)
  add.161 = f32[32]{0} add(sub.83, div.163)
  reshape_squeeze_broadcast_in_dim.35 = f32[1,1,1,32]{3,2,1,0} reshape(add.161)
  mul.290 = f32[1,1,1,32]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.35), dimensions={0,1,2,3}
  mul.291 = f32[32]{0} reshape(mul.290)
  mul.292 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.291), dimensions={3}
  mul.293 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.47, mul.292)
  add.171 = f32[32,32,32,32]{3,2,1,0} add(add.170, mul.293)
  Arg_2.5 = f32[32,1]{1,0} parameter(2)
  Arg_3.3 = f32[1,17]{1,0} parameter(3)
  Arg_4.3 = f32[32,17]{1,0} parameter(4)
  constant.102 = f32[] constant(0.322580636)
  jit_solve_poisson_.5 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) call(add.171, Arg_2.5, Arg_3.3, Arg_4.3, constant.102, constant.102), to_apply=solve_poisson.20
  jit_solve_poisson_.7 = f32[32,32]{1,0} get-tuple-element(jit_solve_poisson_.5), index=1
  constant.88 = f32[] constant(0.05)
  broadcast.65 = f32[32,32]{1,0} broadcast(constant.88), dimensions={}
  mul.333 = f32[32,32]{1,0} multiply(jit_solve_poisson_.7, broadcast.65)
  constant.87 = f32[] constant(0.322580636)
  broadcast.64 = f32[32,32]{1,0} broadcast(constant.87), dimensions={}
  div.192 = f32[32,32]{1,0} divide(mul.333, broadcast.64)
  floor.3 = f32[32,32]{1,0} floor(div.192)
  convert_element_type.13 = s32[32,32]{1,0} convert(floor.3)
  constant.74 = s32[] constant(-1)
  broadcast.51 = s32[32,32]{1,0} broadcast(constant.74), dimensions={}
  eq.126 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.51), direction=EQ
  sub.98 = f32[32,32]{1,0} subtract(div.192, floor.3)
  constant.86 = f32[] constant(20)
  broadcast.63 = f32[32,32]{1,0} broadcast(constant.86), dimensions={}
  div.193 = f32[32,32]{1,0} divide(sub.98, broadcast.63)
  mul.334 = f32[32,32]{1,0} multiply(sub.98, sub.98)
  constant.85 = f32[] constant(24)
  broadcast.62 = f32[32,32]{1,0} broadcast(constant.85), dimensions={}
  div.194 = f32[32,32]{1,0} divide(mul.334, broadcast.62)
  sub.99 = f32[32,32]{1,0} subtract(div.193, div.194)
  mul.335 = f32[32,32]{1,0} multiply(mul.334, sub.98)
  div.195 = f32[32,32]{1,0} divide(mul.335, broadcast.62)
  sub.100 = f32[32,32]{1,0} subtract(sub.99, div.195)
  mul.336 = f32[32,32]{1,0} multiply(mul.335, sub.98)
  div.196 = f32[32,32]{1,0} divide(mul.336, broadcast.62)
  add.223 = f32[32,32]{1,0} add(sub.100, div.196)
  mul.337 = f32[32,32]{1,0} multiply(mul.336, sub.98)
  constant.84 = f32[] constant(120)
  broadcast.61 = f32[32,32]{1,0} broadcast(constant.84), dimensions={}
  div.197 = f32[32,32]{1,0} divide(mul.337, broadcast.61)
  sub.101 = f32[32,32]{1,0} subtract(add.223, div.197)
  constant.103 = f32[] constant(0)
  jit__where_.126 = f32[32,32]{1,0} call(eq.126, sub.101, constant.103), to_apply=_where.21
  constant.73 = s32[] constant(-2)
  broadcast.50 = s32[32,32]{1,0} broadcast(constant.73), dimensions={}
  eq.127 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.50), direction=EQ
  constant.83 = f32[] constant(2)
  broadcast.60 = f32[32,32]{1,0} broadcast(constant.83), dimensions={}
  div.198 = f32[32,32]{1,0} divide(sub.98, broadcast.60)
  neg.14 = f32[32,32]{1,0} negate(div.198)
  mul.338 = f32[32,32]{1,0} multiply(mul.334, broadcast.60)
  constant.82 = f32[] constant(3)
  broadcast.59 = f32[32,32]{1,0} broadcast(constant.82), dimensions={}
  div.199 = f32[32,32]{1,0} divide(mul.338, broadcast.59)
  add.224 = f32[32,32]{1,0} add(neg.14, div.199)
  div.200 = f32[32,32]{1,0} divide(mul.335, broadcast.62)
  sub.102 = f32[32,32]{1,0} subtract(add.224, div.200)
  constant.81 = f32[] constant(6)
  broadcast.58 = f32[32,32]{1,0} broadcast(constant.81), dimensions={}
  div.201 = f32[32,32]{1,0} divide(mul.336, broadcast.58)
  sub.103 = f32[32,32]{1,0} subtract(sub.102, div.201)
  div.202 = f32[32,32]{1,0} divide(mul.337, broadcast.62)
  add.225 = f32[32,32]{1,0} add(sub.103, div.202)
  jit__where_.127 = f32[32,32]{1,0} call(eq.127, add.225, constant.103), to_apply=_where.21
  add.233 = f32[32,32]{1,0} add(jit__where_.126, jit__where_.127)
  constant.72 = s32[] constant(-3)
  broadcast.49 = s32[32,32]{1,0} broadcast(constant.72), dimensions={}
  eq.128 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.49), direction=EQ
  constant.80 = f32[] constant(1)
  broadcast.57 = f32[32,32]{1,0} broadcast(constant.80), dimensions={}
  div.203 = f32[32,32]{1,0} divide(sub.98, broadcast.59)
  sub.104 = f32[32,32]{1,0} subtract(broadcast.57, div.203)
  constant.79 = f32[] constant(5)
  broadcast.56 = f32[32,32]{1,0} broadcast(constant.79), dimensions={}
  mul.339 = f32[32,32]{1,0} multiply(mul.334, broadcast.56)
  constant.78 = f32[] constant(4)
  broadcast.55 = f32[32,32]{1,0} broadcast(constant.78), dimensions={}
  div.204 = f32[32,32]{1,0} divide(mul.339, broadcast.55)
  sub.105 = f32[32,32]{1,0} subtract(sub.104, div.204)
  mul.340 = f32[32,32]{1,0} multiply(mul.335, broadcast.56)
  constant.77 = f32[] constant(12)
  broadcast.54 = f32[32,32]{1,0} broadcast(constant.77), dimensions={}
  div.205 = f32[32,32]{1,0} divide(mul.340, broadcast.54)
  add.226 = f32[32,32]{1,0} add(sub.105, div.205)
  div.206 = f32[32,32]{1,0} divide(mul.336, broadcast.55)
  add.227 = f32[32,32]{1,0} add(add.226, div.206)
  div.207 = f32[32,32]{1,0} divide(mul.337, broadcast.54)
  sub.106 = f32[32,32]{1,0} subtract(add.227, div.207)
  jit__where_.128 = f32[32,32]{1,0} call(eq.128, sub.106, constant.103), to_apply=_where.21
  add.234 = f32[32,32]{1,0} add(add.233, jit__where_.128)
  constant.71 = s32[] constant(-4)
  broadcast.48 = s32[32,32]{1,0} broadcast(constant.71), dimensions={}
  eq.129 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.48), direction=EQ
  mul.341 = f32[32,32]{1,0} multiply(mul.334, broadcast.60)
  div.208 = f32[32,32]{1,0} divide(mul.341, broadcast.59)
  add.228 = f32[32,32]{1,0} add(sub.98, div.208)
  constant.76 = f32[] constant(7)
  broadcast.53 = f32[32,32]{1,0} broadcast(constant.76), dimensions={}
  mul.342 = f32[32,32]{1,0} multiply(mul.335, broadcast.53)
  div.209 = f32[32,32]{1,0} divide(mul.342, broadcast.54)
  sub.107 = f32[32,32]{1,0} subtract(add.228, div.209)
  div.210 = f32[32,32]{1,0} divide(mul.336, broadcast.58)
  sub.108 = f32[32,32]{1,0} subtract(sub.107, div.210)
  div.211 = f32[32,32]{1,0} divide(mul.337, broadcast.54)
  add.229 = f32[32,32]{1,0} add(sub.108, div.211)
  jit__where_.129 = f32[32,32]{1,0} call(eq.129, add.229, constant.103), to_apply=_where.21
  add.235 = f32[32,32]{1,0} add(add.234, jit__where_.129)
  constant.70 = s32[] constant(-5)
  broadcast.47 = s32[32,32]{1,0} broadcast(constant.70), dimensions={}
  eq.130 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.47), direction=EQ
  div.212 = f32[32,32]{1,0} divide(sub.98, broadcast.55)
  neg.15 = f32[32,32]{1,0} negate(div.212)
  div.213 = f32[32,32]{1,0} divide(mul.334, broadcast.62)
  sub.109 = f32[32,32]{1,0} subtract(neg.15, div.213)
  mul.343 = f32[32,32]{1,0} multiply(mul.335, broadcast.53)
  div.214 = f32[32,32]{1,0} divide(mul.343, broadcast.62)
  add.230 = f32[32,32]{1,0} add(sub.109, div.214)
  div.215 = f32[32,32]{1,0} divide(mul.336, broadcast.62)
  add.231 = f32[32,32]{1,0} add(add.230, div.215)
  div.216 = f32[32,32]{1,0} divide(mul.337, broadcast.62)
  sub.110 = f32[32,32]{1,0} subtract(add.231, div.216)
  jit__where_.130 = f32[32,32]{1,0} call(eq.130, sub.110, constant.103), to_apply=_where.21
  add.236 = f32[32,32]{1,0} add(add.235, jit__where_.130)
  constant.69 = s32[] constant(-6)
  broadcast.46 = s32[32,32]{1,0} broadcast(constant.69), dimensions={}
  eq.131 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.46), direction=EQ
  constant.75 = f32[] constant(30)
  broadcast.52 = f32[32,32]{1,0} broadcast(constant.75), dimensions={}
  div.217 = f32[32,32]{1,0} divide(sub.98, broadcast.52)
  div.218 = f32[32,32]{1,0} divide(mul.335, broadcast.62)
  sub.111 = f32[32,32]{1,0} subtract(div.217, div.218)
  div.219 = f32[32,32]{1,0} divide(mul.337, broadcast.61)
  add.232 = f32[32,32]{1,0} add(sub.111, div.219)
  jit__where_.131 = f32[32,32]{1,0} call(eq.131, add.232, constant.103), to_apply=_where.21
  add.237 = f32[32,32]{1,0} add(add.236, jit__where_.131)
  broadcast_in_dim_squeeze_broadcast_in_dim.21 = f32[32,32,1,1]{3,2,1,0} reshape(add.237)
  mul.344 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.21), dimensions={0,1,2,3}
  mul.345 = f32[32,32]{1,0} reshape(mul.344)
  mul.346 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.345), dimensions={0,1}
  jit_solve_poisson_.6 = f32[32,32]{1,0} get-tuple-element(jit_solve_poisson_.5), index=0
  mul.294 = f32[32,32]{1,0} multiply(jit_solve_poisson_.6, broadcast.65)
  div.164 = f32[32,32]{1,0} divide(mul.294, broadcast.64)
  floor.2 = f32[32,32]{1,0} floor(div.164)
  convert_element_type.12 = s32[32,32]{1,0} convert(floor.2)
  eq.84 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.51), direction=EQ
  sub.84 = f32[32,32]{1,0} subtract(div.164, floor.2)
  div.165 = f32[32,32]{1,0} divide(sub.84, broadcast.63)
  mul.295 = f32[32,32]{1,0} multiply(sub.84, sub.84)
  div.166 = f32[32,32]{1,0} divide(mul.295, broadcast.62)
  sub.85 = f32[32,32]{1,0} subtract(div.165, div.166)
  mul.296 = f32[32,32]{1,0} multiply(mul.295, sub.84)
  div.167 = f32[32,32]{1,0} divide(mul.296, broadcast.62)
  sub.86 = f32[32,32]{1,0} subtract(sub.85, div.167)
  mul.297 = f32[32,32]{1,0} multiply(mul.296, sub.84)
  div.168 = f32[32,32]{1,0} divide(mul.297, broadcast.62)
  add.172 = f32[32,32]{1,0} add(sub.86, div.168)
  mul.298 = f32[32,32]{1,0} multiply(mul.297, sub.84)
  div.169 = f32[32,32]{1,0} divide(mul.298, broadcast.61)
  sub.87 = f32[32,32]{1,0} subtract(add.172, div.169)
  jit__where_.84 = f32[32,32]{1,0} call(eq.84, sub.87, constant.103), to_apply=_where.21
  eq.85 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.50), direction=EQ
  div.170 = f32[32,32]{1,0} divide(sub.84, broadcast.60)
  neg.12 = f32[32,32]{1,0} negate(div.170)
  mul.299 = f32[32,32]{1,0} multiply(mul.295, broadcast.60)
  div.171 = f32[32,32]{1,0} divide(mul.299, broadcast.59)
  add.173 = f32[32,32]{1,0} add(neg.12, div.171)
  div.172 = f32[32,32]{1,0} divide(mul.296, broadcast.62)
  sub.88 = f32[32,32]{1,0} subtract(add.173, div.172)
  div.173 = f32[32,32]{1,0} divide(mul.297, broadcast.58)
  sub.89 = f32[32,32]{1,0} subtract(sub.88, div.173)
  div.174 = f32[32,32]{1,0} divide(mul.298, broadcast.62)
  add.174 = f32[32,32]{1,0} add(sub.89, div.174)
  jit__where_.85 = f32[32,32]{1,0} call(eq.85, add.174, constant.103), to_apply=_where.21
  add.182 = f32[32,32]{1,0} add(jit__where_.84, jit__where_.85)
  eq.86 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.49), direction=EQ
  div.175 = f32[32,32]{1,0} divide(sub.84, broadcast.59)
  sub.90 = f32[32,32]{1,0} subtract(broadcast.57, div.175)
  mul.300 = f32[32,32]{1,0} multiply(mul.295, broadcast.56)
  div.176 = f32[32,32]{1,0} divide(mul.300, broadcast.55)
  sub.91 = f32[32,32]{1,0} subtract(sub.90, div.176)
  mul.301 = f32[32,32]{1,0} multiply(mul.296, broadcast.56)
  div.177 = f32[32,32]{1,0} divide(mul.301, broadcast.54)
  add.175 = f32[32,32]{1,0} add(sub.91, div.177)
  div.178 = f32[32,32]{1,0} divide(mul.297, broadcast.55)
  add.176 = f32[32,32]{1,0} add(add.175, div.178)
  div.179 = f32[32,32]{1,0} divide(mul.298, broadcast.54)
  sub.92 = f32[32,32]{1,0} subtract(add.176, div.179)
  jit__where_.86 = f32[32,32]{1,0} call(eq.86, sub.92, constant.103), to_apply=_where.21
  add.183 = f32[32,32]{1,0} add(add.182, jit__where_.86)
  eq.87 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.48), direction=EQ
  mul.302 = f32[32,32]{1,0} multiply(mul.295, broadcast.60)
  div.180 = f32[32,32]{1,0} divide(mul.302, broadcast.59)
  add.177 = f32[32,32]{1,0} add(sub.84, div.180)
  mul.303 = f32[32,32]{1,0} multiply(mul.296, broadcast.53)
  div.181 = f32[32,32]{1,0} divide(mul.303, broadcast.54)
  sub.93 = f32[32,32]{1,0} subtract(add.177, div.181)
  div.182 = f32[32,32]{1,0} divide(mul.297, broadcast.58)
  sub.94 = f32[32,32]{1,0} subtract(sub.93, div.182)
  div.183 = f32[32,32]{1,0} divide(mul.298, broadcast.54)
  add.178 = f32[32,32]{1,0} add(sub.94, div.183)
  jit__where_.87 = f32[32,32]{1,0} call(eq.87, add.178, constant.103), to_apply=_where.21
  add.184 = f32[32,32]{1,0} add(add.183, jit__where_.87)
  eq.88 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.47), direction=EQ
  div.184 = f32[32,32]{1,0} divide(sub.84, broadcast.55)
  neg.13 = f32[32,32]{1,0} negate(div.184)
  div.185 = f32[32,32]{1,0} divide(mul.295, broadcast.62)
  sub.95 = f32[32,32]{1,0} subtract(neg.13, div.185)
  mul.304 = f32[32,32]{1,0} multiply(mul.296, broadcast.53)
  div.186 = f32[32,32]{1,0} divide(mul.304, broadcast.62)
  add.179 = f32[32,32]{1,0} add(sub.95, div.186)
  div.187 = f32[32,32]{1,0} divide(mul.297, broadcast.62)
  add.180 = f32[32,32]{1,0} add(add.179, div.187)
  div.188 = f32[32,32]{1,0} divide(mul.298, broadcast.62)
  sub.96 = f32[32,32]{1,0} subtract(add.180, div.188)
  jit__where_.88 = f32[32,32]{1,0} call(eq.88, sub.96, constant.103), to_apply=_where.21
  add.185 = f32[32,32]{1,0} add(add.184, jit__where_.88)
  eq.89 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.46), direction=EQ
  div.189 = f32[32,32]{1,0} divide(sub.84, broadcast.52)
  div.190 = f32[32,32]{1,0} divide(mul.296, broadcast.62)
  sub.97 = f32[32,32]{1,0} subtract(div.189, div.190)
  div.191 = f32[32,32]{1,0} divide(mul.298, broadcast.61)
  add.181 = f32[32,32]{1,0} add(sub.97, div.191)
  jit__where_.89 = f32[32,32]{1,0} call(eq.89, add.181, constant.103), to_apply=_where.21
  add.186 = f32[32,32]{1,0} add(add.185, jit__where_.89)
  broadcast_in_dim_squeeze_broadcast_in_dim.14 = f32[32,32,1,1]{3,2,1,0} reshape(add.186)
  mul.305 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.14), dimensions={0,1,2,3}
  mul.306 = f32[32,32]{1,0} reshape(mul.305)
  mul.307 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.306), dimensions={0,1}
  constant.101 = s32[] constant(0)
  jit__pad_.2 = f32[32,32,38,32]{3,2,1,0} call(add.171, constant.101), to_apply=_pad.22
  slice.74 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [6:38], [0:32]}
  mul.308 = f32[32,32,32,32]{3,2,1,0} multiply(mul.307, slice.74)
  constant.68 = s32[] constant(0)
  broadcast.45 = s32[32,32]{1,0} broadcast(constant.68), dimensions={}
  eq.90 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.45), direction=EQ
  jit__where_.90 = f32[32,32]{1,0} call(eq.90, sub.87, constant.103), to_apply=_where.21
  eq.91 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.51), direction=EQ
  jit__where_.91 = f32[32,32]{1,0} call(eq.91, add.174, constant.103), to_apply=_where.21
  add.187 = f32[32,32]{1,0} add(jit__where_.90, jit__where_.91)
  eq.92 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.50), direction=EQ
  jit__where_.92 = f32[32,32]{1,0} call(eq.92, sub.92, constant.103), to_apply=_where.21
  add.188 = f32[32,32]{1,0} add(add.187, jit__where_.92)
  eq.93 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.49), direction=EQ
  jit__where_.93 = f32[32,32]{1,0} call(eq.93, add.178, constant.103), to_apply=_where.21
  add.189 = f32[32,32]{1,0} add(add.188, jit__where_.93)
  eq.94 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.48), direction=EQ
  jit__where_.94 = f32[32,32]{1,0} call(eq.94, sub.96, constant.103), to_apply=_where.21
  add.190 = f32[32,32]{1,0} add(add.189, jit__where_.94)
  eq.95 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.47), direction=EQ
  jit__where_.95 = f32[32,32]{1,0} call(eq.95, add.181, constant.103), to_apply=_where.21
  add.191 = f32[32,32]{1,0} add(add.190, jit__where_.95)
  broadcast_in_dim_squeeze_broadcast_in_dim.15 = f32[32,32,1,1]{3,2,1,0} reshape(add.191)
  mul.309 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.15), dimensions={0,1,2,3}
  mul.310 = f32[32,32]{1,0} reshape(mul.309)
  mul.311 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.310), dimensions={0,1}
  slice.75 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [5:37], [0:32]}
  mul.312 = f32[32,32,32,32]{3,2,1,0} multiply(mul.311, slice.75)
  add.217 = f32[32,32,32,32]{3,2,1,0} add(mul.308, mul.312)
  constant.67 = s32[] constant(1)
  broadcast.44 = s32[32,32]{1,0} broadcast(constant.67), dimensions={}
  eq.96 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.44), direction=EQ
  jit__where_.96 = f32[32,32]{1,0} call(eq.96, sub.87, constant.103), to_apply=_where.21
  eq.97 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.45), direction=EQ
  jit__where_.97 = f32[32,32]{1,0} call(eq.97, add.174, constant.103), to_apply=_where.21
  add.192 = f32[32,32]{1,0} add(jit__where_.96, jit__where_.97)
  eq.98 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.51), direction=EQ
  jit__where_.98 = f32[32,32]{1,0} call(eq.98, sub.92, constant.103), to_apply=_where.21
  add.193 = f32[32,32]{1,0} add(add.192, jit__where_.98)
  eq.99 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.50), direction=EQ
  jit__where_.99 = f32[32,32]{1,0} call(eq.99, add.178, constant.103), to_apply=_where.21
  add.194 = f32[32,32]{1,0} add(add.193, jit__where_.99)
  eq.100 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.49), direction=EQ
  jit__where_.100 = f32[32,32]{1,0} call(eq.100, sub.96, constant.103), to_apply=_where.21
  add.195 = f32[32,32]{1,0} add(add.194, jit__where_.100)
  eq.101 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.48), direction=EQ
  jit__where_.101 = f32[32,32]{1,0} call(eq.101, add.181, constant.103), to_apply=_where.21
  add.196 = f32[32,32]{1,0} add(add.195, jit__where_.101)
  broadcast_in_dim_squeeze_broadcast_in_dim.16 = f32[32,32,1,1]{3,2,1,0} reshape(add.196)
  mul.313 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.16), dimensions={0,1,2,3}
  mul.314 = f32[32,32]{1,0} reshape(mul.313)
  mul.315 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.314), dimensions={0,1}
  slice.76 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [4:36], [0:32]}
  mul.316 = f32[32,32,32,32]{3,2,1,0} multiply(mul.315, slice.76)
  add.218 = f32[32,32,32,32]{3,2,1,0} add(add.217, mul.316)
  constant.66 = s32[] constant(2)
  broadcast.43 = s32[32,32]{1,0} broadcast(constant.66), dimensions={}
  eq.102 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.43), direction=EQ
  jit__where_.102 = f32[32,32]{1,0} call(eq.102, sub.87, constant.103), to_apply=_where.21
  eq.103 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.44), direction=EQ
  jit__where_.103 = f32[32,32]{1,0} call(eq.103, add.174, constant.103), to_apply=_where.21
  add.197 = f32[32,32]{1,0} add(jit__where_.102, jit__where_.103)
  eq.104 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.45), direction=EQ
  jit__where_.104 = f32[32,32]{1,0} call(eq.104, sub.92, constant.103), to_apply=_where.21
  add.198 = f32[32,32]{1,0} add(add.197, jit__where_.104)
  eq.105 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.51), direction=EQ
  jit__where_.105 = f32[32,32]{1,0} call(eq.105, add.178, constant.103), to_apply=_where.21
  add.199 = f32[32,32]{1,0} add(add.198, jit__where_.105)
  eq.106 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.50), direction=EQ
  jit__where_.106 = f32[32,32]{1,0} call(eq.106, sub.96, constant.103), to_apply=_where.21
  add.200 = f32[32,32]{1,0} add(add.199, jit__where_.106)
  eq.107 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.49), direction=EQ
  jit__where_.107 = f32[32,32]{1,0} call(eq.107, add.181, constant.103), to_apply=_where.21
  add.201 = f32[32,32]{1,0} add(add.200, jit__where_.107)
  broadcast_in_dim_squeeze_broadcast_in_dim.17 = f32[32,32,1,1]{3,2,1,0} reshape(add.201)
  mul.317 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.17), dimensions={0,1,2,3}
  mul.318 = f32[32,32]{1,0} reshape(mul.317)
  mul.319 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.318), dimensions={0,1}
  slice.77 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [3:35], [0:32]}
  mul.320 = f32[32,32,32,32]{3,2,1,0} multiply(mul.319, slice.77)
  add.219 = f32[32,32,32,32]{3,2,1,0} add(add.218, mul.320)
  constant.65 = s32[] constant(3)
  broadcast.42 = s32[32,32]{1,0} broadcast(constant.65), dimensions={}
  eq.108 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.42), direction=EQ
  jit__where_.108 = f32[32,32]{1,0} call(eq.108, sub.87, constant.103), to_apply=_where.21
  eq.109 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.43), direction=EQ
  jit__where_.109 = f32[32,32]{1,0} call(eq.109, add.174, constant.103), to_apply=_where.21
  add.202 = f32[32,32]{1,0} add(jit__where_.108, jit__where_.109)
  eq.110 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.44), direction=EQ
  jit__where_.110 = f32[32,32]{1,0} call(eq.110, sub.92, constant.103), to_apply=_where.21
  add.203 = f32[32,32]{1,0} add(add.202, jit__where_.110)
  eq.111 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.45), direction=EQ
  jit__where_.111 = f32[32,32]{1,0} call(eq.111, add.178, constant.103), to_apply=_where.21
  add.204 = f32[32,32]{1,0} add(add.203, jit__where_.111)
  eq.112 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.51), direction=EQ
  jit__where_.112 = f32[32,32]{1,0} call(eq.112, sub.96, constant.103), to_apply=_where.21
  add.205 = f32[32,32]{1,0} add(add.204, jit__where_.112)
  eq.113 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.50), direction=EQ
  jit__where_.113 = f32[32,32]{1,0} call(eq.113, add.181, constant.103), to_apply=_where.21
  add.206 = f32[32,32]{1,0} add(add.205, jit__where_.113)
  broadcast_in_dim_squeeze_broadcast_in_dim.18 = f32[32,32,1,1]{3,2,1,0} reshape(add.206)
  mul.321 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.18), dimensions={0,1,2,3}
  mul.322 = f32[32,32]{1,0} reshape(mul.321)
  mul.323 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.322), dimensions={0,1}
  slice.78 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [2:34], [0:32]}
  mul.324 = f32[32,32,32,32]{3,2,1,0} multiply(mul.323, slice.78)
  add.220 = f32[32,32,32,32]{3,2,1,0} add(add.219, mul.324)
  constant.64 = s32[] constant(4)
  broadcast.41 = s32[32,32]{1,0} broadcast(constant.64), dimensions={}
  eq.114 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.41), direction=EQ
  jit__where_.114 = f32[32,32]{1,0} call(eq.114, sub.87, constant.103), to_apply=_where.21
  eq.115 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.42), direction=EQ
  jit__where_.115 = f32[32,32]{1,0} call(eq.115, add.174, constant.103), to_apply=_where.21
  add.207 = f32[32,32]{1,0} add(jit__where_.114, jit__where_.115)
  eq.116 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.43), direction=EQ
  jit__where_.116 = f32[32,32]{1,0} call(eq.116, sub.92, constant.103), to_apply=_where.21
  add.208 = f32[32,32]{1,0} add(add.207, jit__where_.116)
  eq.117 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.44), direction=EQ
  jit__where_.117 = f32[32,32]{1,0} call(eq.117, add.178, constant.103), to_apply=_where.21
  add.209 = f32[32,32]{1,0} add(add.208, jit__where_.117)
  eq.118 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.45), direction=EQ
  jit__where_.118 = f32[32,32]{1,0} call(eq.118, sub.96, constant.103), to_apply=_where.21
  add.210 = f32[32,32]{1,0} add(add.209, jit__where_.118)
  eq.119 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.51), direction=EQ
  jit__where_.119 = f32[32,32]{1,0} call(eq.119, add.181, constant.103), to_apply=_where.21
  add.211 = f32[32,32]{1,0} add(add.210, jit__where_.119)
  broadcast_in_dim_squeeze_broadcast_in_dim.19 = f32[32,32,1,1]{3,2,1,0} reshape(add.211)
  mul.325 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.19), dimensions={0,1,2,3}
  mul.326 = f32[32,32]{1,0} reshape(mul.325)
  mul.327 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.326), dimensions={0,1}
  slice.79 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [1:33], [0:32]}
  mul.328 = f32[32,32,32,32]{3,2,1,0} multiply(mul.327, slice.79)
  add.221 = f32[32,32,32,32]{3,2,1,0} add(add.220, mul.328)
  constant.63 = s32[] constant(5)
  broadcast.40 = s32[32,32]{1,0} broadcast(constant.63), dimensions={}
  eq.120 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.40), direction=EQ
  jit__where_.120 = f32[32,32]{1,0} call(eq.120, sub.87, constant.103), to_apply=_where.21
  eq.121 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.41), direction=EQ
  jit__where_.121 = f32[32,32]{1,0} call(eq.121, add.174, constant.103), to_apply=_where.21
  add.212 = f32[32,32]{1,0} add(jit__where_.120, jit__where_.121)
  eq.122 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.42), direction=EQ
  jit__where_.122 = f32[32,32]{1,0} call(eq.122, sub.92, constant.103), to_apply=_where.21
  add.213 = f32[32,32]{1,0} add(add.212, jit__where_.122)
  eq.123 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.43), direction=EQ
  jit__where_.123 = f32[32,32]{1,0} call(eq.123, add.178, constant.103), to_apply=_where.21
  add.214 = f32[32,32]{1,0} add(add.213, jit__where_.123)
  eq.124 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.44), direction=EQ
  jit__where_.124 = f32[32,32]{1,0} call(eq.124, sub.96, constant.103), to_apply=_where.21
  add.215 = f32[32,32]{1,0} add(add.214, jit__where_.124)
  eq.125 = pred[32,32]{1,0} compare(convert_element_type.12, broadcast.45), direction=EQ
  jit__where_.125 = f32[32,32]{1,0} call(eq.125, add.181, constant.103), to_apply=_where.21
  add.216 = f32[32,32]{1,0} add(add.215, jit__where_.125)
  broadcast_in_dim_squeeze_broadcast_in_dim.20 = f32[32,32,1,1]{3,2,1,0} reshape(add.216)
  mul.329 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.20), dimensions={0,1,2,3}
  mul.330 = f32[32,32]{1,0} reshape(mul.329)
  mul.331 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.330), dimensions={0,1}
  slice.80 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.2), slice={[0:32], [0:32], [0:32], [0:32]}
  mul.332 = f32[32,32,32,32]{3,2,1,0} multiply(mul.331, slice.80)
  add.222 = f32[32,32,32,32]{3,2,1,0} add(add.221, mul.332)
  jit__pad_.3 = f32[32,32,32,38]{3,2,1,0} call(add.222, constant.101), to_apply=_pad_129.23
  slice.81 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [6:38]}
  mul.347 = f32[32,32,32,32]{3,2,1,0} multiply(mul.346, slice.81)
  eq.132 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.45), direction=EQ
  jit__where_.132 = f32[32,32]{1,0} call(eq.132, sub.101, constant.103), to_apply=_where.21
  eq.133 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.51), direction=EQ
  jit__where_.133 = f32[32,32]{1,0} call(eq.133, add.225, constant.103), to_apply=_where.21
  add.238 = f32[32,32]{1,0} add(jit__where_.132, jit__where_.133)
  eq.134 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.50), direction=EQ
  jit__where_.134 = f32[32,32]{1,0} call(eq.134, sub.106, constant.103), to_apply=_where.21
  add.239 = f32[32,32]{1,0} add(add.238, jit__where_.134)
  eq.135 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.49), direction=EQ
  jit__where_.135 = f32[32,32]{1,0} call(eq.135, add.229, constant.103), to_apply=_where.21
  add.240 = f32[32,32]{1,0} add(add.239, jit__where_.135)
  eq.136 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.48), direction=EQ
  jit__where_.136 = f32[32,32]{1,0} call(eq.136, sub.110, constant.103), to_apply=_where.21
  add.241 = f32[32,32]{1,0} add(add.240, jit__where_.136)
  eq.137 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.47), direction=EQ
  jit__where_.137 = f32[32,32]{1,0} call(eq.137, add.232, constant.103), to_apply=_where.21
  add.242 = f32[32,32]{1,0} add(add.241, jit__where_.137)
  broadcast_in_dim_squeeze_broadcast_in_dim.22 = f32[32,32,1,1]{3,2,1,0} reshape(add.242)
  mul.348 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.22), dimensions={0,1,2,3}
  mul.349 = f32[32,32]{1,0} reshape(mul.348)
  mul.350 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.349), dimensions={0,1}
  slice.82 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [5:37]}
  mul.351 = f32[32,32,32,32]{3,2,1,0} multiply(mul.350, slice.82)
  add.268 = f32[32,32,32,32]{3,2,1,0} add(mul.347, mul.351)
  eq.138 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.44), direction=EQ
  jit__where_.138 = f32[32,32]{1,0} call(eq.138, sub.101, constant.103), to_apply=_where.21
  eq.139 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.45), direction=EQ
  jit__where_.139 = f32[32,32]{1,0} call(eq.139, add.225, constant.103), to_apply=_where.21
  add.243 = f32[32,32]{1,0} add(jit__where_.138, jit__where_.139)
  eq.140 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.51), direction=EQ
  jit__where_.140 = f32[32,32]{1,0} call(eq.140, sub.106, constant.103), to_apply=_where.21
  add.244 = f32[32,32]{1,0} add(add.243, jit__where_.140)
  eq.141 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.50), direction=EQ
  jit__where_.141 = f32[32,32]{1,0} call(eq.141, add.229, constant.103), to_apply=_where.21
  add.245 = f32[32,32]{1,0} add(add.244, jit__where_.141)
  eq.142 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.49), direction=EQ
  jit__where_.142 = f32[32,32]{1,0} call(eq.142, sub.110, constant.103), to_apply=_where.21
  add.246 = f32[32,32]{1,0} add(add.245, jit__where_.142)
  eq.143 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.48), direction=EQ
  jit__where_.143 = f32[32,32]{1,0} call(eq.143, add.232, constant.103), to_apply=_where.21
  add.247 = f32[32,32]{1,0} add(add.246, jit__where_.143)
  broadcast_in_dim_squeeze_broadcast_in_dim.23 = f32[32,32,1,1]{3,2,1,0} reshape(add.247)
  mul.352 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.23), dimensions={0,1,2,3}
  mul.353 = f32[32,32]{1,0} reshape(mul.352)
  mul.354 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.353), dimensions={0,1}
  slice.83 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [4:36]}
  mul.355 = f32[32,32,32,32]{3,2,1,0} multiply(mul.354, slice.83)
  add.269 = f32[32,32,32,32]{3,2,1,0} add(add.268, mul.355)
  eq.144 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.43), direction=EQ
  jit__where_.144 = f32[32,32]{1,0} call(eq.144, sub.101, constant.103), to_apply=_where.21
  eq.145 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.44), direction=EQ
  jit__where_.145 = f32[32,32]{1,0} call(eq.145, add.225, constant.103), to_apply=_where.21
  add.248 = f32[32,32]{1,0} add(jit__where_.144, jit__where_.145)
  eq.146 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.45), direction=EQ
  jit__where_.146 = f32[32,32]{1,0} call(eq.146, sub.106, constant.103), to_apply=_where.21
  add.249 = f32[32,32]{1,0} add(add.248, jit__where_.146)
  eq.147 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.51), direction=EQ
  jit__where_.147 = f32[32,32]{1,0} call(eq.147, add.229, constant.103), to_apply=_where.21
  add.250 = f32[32,32]{1,0} add(add.249, jit__where_.147)
  eq.148 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.50), direction=EQ
  jit__where_.148 = f32[32,32]{1,0} call(eq.148, sub.110, constant.103), to_apply=_where.21
  add.251 = f32[32,32]{1,0} add(add.250, jit__where_.148)
  eq.149 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.49), direction=EQ
  jit__where_.149 = f32[32,32]{1,0} call(eq.149, add.232, constant.103), to_apply=_where.21
  add.252 = f32[32,32]{1,0} add(add.251, jit__where_.149)
  broadcast_in_dim_squeeze_broadcast_in_dim.24 = f32[32,32,1,1]{3,2,1,0} reshape(add.252)
  mul.356 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.24), dimensions={0,1,2,3}
  mul.357 = f32[32,32]{1,0} reshape(mul.356)
  mul.358 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.357), dimensions={0,1}
  slice.84 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [3:35]}
  mul.359 = f32[32,32,32,32]{3,2,1,0} multiply(mul.358, slice.84)
  add.270 = f32[32,32,32,32]{3,2,1,0} add(add.269, mul.359)
  eq.150 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.42), direction=EQ
  jit__where_.150 = f32[32,32]{1,0} call(eq.150, sub.101, constant.103), to_apply=_where.21
  eq.151 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.43), direction=EQ
  jit__where_.151 = f32[32,32]{1,0} call(eq.151, add.225, constant.103), to_apply=_where.21
  add.253 = f32[32,32]{1,0} add(jit__where_.150, jit__where_.151)
  eq.152 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.44), direction=EQ
  jit__where_.152 = f32[32,32]{1,0} call(eq.152, sub.106, constant.103), to_apply=_where.21
  add.254 = f32[32,32]{1,0} add(add.253, jit__where_.152)
  eq.153 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.45), direction=EQ
  jit__where_.153 = f32[32,32]{1,0} call(eq.153, add.229, constant.103), to_apply=_where.21
  add.255 = f32[32,32]{1,0} add(add.254, jit__where_.153)
  eq.154 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.51), direction=EQ
  jit__where_.154 = f32[32,32]{1,0} call(eq.154, sub.110, constant.103), to_apply=_where.21
  add.256 = f32[32,32]{1,0} add(add.255, jit__where_.154)
  eq.155 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.50), direction=EQ
  jit__where_.155 = f32[32,32]{1,0} call(eq.155, add.232, constant.103), to_apply=_where.21
  add.257 = f32[32,32]{1,0} add(add.256, jit__where_.155)
  broadcast_in_dim_squeeze_broadcast_in_dim.25 = f32[32,32,1,1]{3,2,1,0} reshape(add.257)
  mul.360 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.25), dimensions={0,1,2,3}
  mul.361 = f32[32,32]{1,0} reshape(mul.360)
  mul.362 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.361), dimensions={0,1}
  slice.85 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [2:34]}
  mul.363 = f32[32,32,32,32]{3,2,1,0} multiply(mul.362, slice.85)
  add.271 = f32[32,32,32,32]{3,2,1,0} add(add.270, mul.363)
  eq.156 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.41), direction=EQ
  jit__where_.156 = f32[32,32]{1,0} call(eq.156, sub.101, constant.103), to_apply=_where.21
  eq.157 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.42), direction=EQ
  jit__where_.157 = f32[32,32]{1,0} call(eq.157, add.225, constant.103), to_apply=_where.21
  add.258 = f32[32,32]{1,0} add(jit__where_.156, jit__where_.157)
  eq.158 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.43), direction=EQ
  jit__where_.158 = f32[32,32]{1,0} call(eq.158, sub.106, constant.103), to_apply=_where.21
  add.259 = f32[32,32]{1,0} add(add.258, jit__where_.158)
  eq.159 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.44), direction=EQ
  jit__where_.159 = f32[32,32]{1,0} call(eq.159, add.229, constant.103), to_apply=_where.21
  add.260 = f32[32,32]{1,0} add(add.259, jit__where_.159)
  eq.160 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.45), direction=EQ
  jit__where_.160 = f32[32,32]{1,0} call(eq.160, sub.110, constant.103), to_apply=_where.21
  add.261 = f32[32,32]{1,0} add(add.260, jit__where_.160)
  eq.161 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.51), direction=EQ
  jit__where_.161 = f32[32,32]{1,0} call(eq.161, add.232, constant.103), to_apply=_where.21
  add.262 = f32[32,32]{1,0} add(add.261, jit__where_.161)
  broadcast_in_dim_squeeze_broadcast_in_dim.26 = f32[32,32,1,1]{3,2,1,0} reshape(add.262)
  mul.364 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.26), dimensions={0,1,2,3}
  mul.365 = f32[32,32]{1,0} reshape(mul.364)
  mul.366 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.365), dimensions={0,1}
  slice.86 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [1:33]}
  mul.367 = f32[32,32,32,32]{3,2,1,0} multiply(mul.366, slice.86)
  add.272 = f32[32,32,32,32]{3,2,1,0} add(add.271, mul.367)
  eq.162 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.40), direction=EQ
  jit__where_.162 = f32[32,32]{1,0} call(eq.162, sub.101, constant.103), to_apply=_where.21
  eq.163 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.41), direction=EQ
  jit__where_.163 = f32[32,32]{1,0} call(eq.163, add.225, constant.103), to_apply=_where.21
  add.263 = f32[32,32]{1,0} add(jit__where_.162, jit__where_.163)
  eq.164 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.42), direction=EQ
  jit__where_.164 = f32[32,32]{1,0} call(eq.164, sub.106, constant.103), to_apply=_where.21
  add.264 = f32[32,32]{1,0} add(add.263, jit__where_.164)
  eq.165 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.43), direction=EQ
  jit__where_.165 = f32[32,32]{1,0} call(eq.165, add.229, constant.103), to_apply=_where.21
  add.265 = f32[32,32]{1,0} add(add.264, jit__where_.165)
  eq.166 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.44), direction=EQ
  jit__where_.166 = f32[32,32]{1,0} call(eq.166, sub.110, constant.103), to_apply=_where.21
  add.266 = f32[32,32]{1,0} add(add.265, jit__where_.166)
  eq.167 = pred[32,32]{1,0} compare(convert_element_type.13, broadcast.45), direction=EQ
  jit__where_.167 = f32[32,32]{1,0} call(eq.167, add.232, constant.103), to_apply=_where.21
  add.267 = f32[32,32]{1,0} add(add.266, jit__where_.167)
  broadcast_in_dim_squeeze_broadcast_in_dim.27 = f32[32,32,1,1]{3,2,1,0} reshape(add.267)
  mul.368 = f32[32,32,1,1]{3,2,1,0} broadcast(broadcast_in_dim_squeeze_broadcast_in_dim.27), dimensions={0,1,2,3}
  mul.369 = f32[32,32]{1,0} reshape(mul.368)
  mul.370 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.369), dimensions={0,1}
  slice.87 = f32[32,32,32,32]{3,2,1,0} slice(jit__pad_.3), slice={[0:32], [0:32], [0:32], [0:32]}
  mul.371 = f32[32,32,32,32]{3,2,1,0} multiply(mul.370, slice.87)
  add.273 = f32[32,32,32,32]{3,2,1,0} add(add.272, mul.371)
  slice.88 = f32[32,32,32,16]{3,2,1,0} slice(add.273), slice={[0:32], [0:32], [0:32], [0:16]}
  jit__roll_static_.48 = f32[32,32,32,16]{3,2,1,0} call(slice.88), to_apply=_roll_static_45.9
  slice.89 = f32[32,32,32,16]{3,2,1,0} slice(add.273), slice={[0:32], [0:32], [0:32], [16:32]}
  jit__roll_static_.49 = f32[32,32,32,16]{3,2,1,0} call(slice.89), to_apply=_roll_static_50.10
  concatenate.30 = f32[32,32,32,32]{3,2,1,0} concatenate(jit__roll_static_.48, jit__roll_static_.49), dimensions={3}
  jit__roll_static_.50 = f32[32,32,32,32]{3,2,1,0} call(concatenate.30), to_apply=_roll_static_55.11
  reshape_squeeze_broadcast_in_dim.36 = f32[1,1,1,32]{3,2,1,0} reshape(sub.73)
  mul.372 = f32[1,1,1,32]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.36), dimensions={0,1,2,3}
  mul.373 = f32[32]{0} reshape(mul.372)
  mul.374 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.373), dimensions={3}
  mul.375 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.50, mul.374)
  jit__roll_static_.51 = f32[32,32,32,32]{3,2,1,0} call(concatenate.30), to_apply=_roll_static_61.12
  reshape_squeeze_broadcast_in_dim.37 = f32[1,1,1,32]{3,2,1,0} reshape(add.154)
  mul.376 = f32[1,1,1,32]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.37), dimensions={0,1,2,3}
  mul.377 = f32[32]{0} reshape(mul.376)
  mul.378 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.377), dimensions={3}
  mul.379 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.51, mul.378)
  add.274 = f32[32,32,32,32]{3,2,1,0} add(mul.375, mul.379)
  jit__roll_static_.52 = f32[32,32,32,32]{3,2,1,0} call(concatenate.30), to_apply=_roll_static_65.13
  reshape_squeeze_broadcast_in_dim.38 = f32[1,1,1,32]{3,2,1,0} reshape(sub.78)
  mul.380 = f32[1,1,1,32]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.38), dimensions={0,1,2,3}
  mul.381 = f32[32]{0} reshape(mul.380)
  mul.382 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.381), dimensions={3}
  mul.383 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.52, mul.382)
  add.275 = f32[32,32,32,32]{3,2,1,0} add(add.274, mul.383)
  jit__roll_static_.53 = f32[32,32,32,32]{3,2,1,0} call(concatenate.30), to_apply=_roll_static_68.14
  reshape_squeeze_broadcast_in_dim.39 = f32[1,1,1,32]{3,2,1,0} reshape(add.158)
  mul.384 = f32[1,1,1,32]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.39), dimensions={0,1,2,3}
  mul.385 = f32[32]{0} reshape(mul.384)
  mul.386 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.385), dimensions={3}
  mul.387 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.53, mul.386)
  add.276 = f32[32,32,32,32]{3,2,1,0} add(add.275, mul.387)
  jit__roll_static_.54 = f32[32,32,32,32]{3,2,1,0} call(concatenate.30), to_apply=_roll_static_72.15
  reshape_squeeze_broadcast_in_dim.40 = f32[1,1,1,32]{3,2,1,0} reshape(sub.82)
  mul.388 = f32[1,1,1,32]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.40), dimensions={0,1,2,3}
  mul.389 = f32[32]{0} reshape(mul.388)
  mul.390 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.389), dimensions={3}
  mul.391 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.54, mul.390)
  add.277 = f32[32,32,32,32]{3,2,1,0} add(add.276, mul.391)
  jit__roll_static_.55 = f32[32,32,32,32]{3,2,1,0} call(concatenate.30), to_apply=_roll_static_76.16
  reshape_squeeze_broadcast_in_dim.41 = f32[1,1,1,32]{3,2,1,0} reshape(add.161)
  mul.392 = f32[1,1,1,32]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.41), dimensions={0,1,2,3}
  mul.393 = f32[32]{0} reshape(mul.392)
  mul.394 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.393), dimensions={3}
  mul.395 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.55, mul.394)
  add.278 = f32[32,32,32,32]{3,2,1,0} add(add.277, mul.395)
  slice.90 = f32[32,32,16,32]{3,2,1,0} slice(add.278), slice={[0:32], [0:32], [0:16], [0:32]}
  jit__roll_static_.56 = f32[32,32,16,32]{3,2,1,0} call(slice.90), to_apply=_roll_static.1
  slice.91 = f32[32,32,16,32]{3,2,1,0} slice(add.278), slice={[0:32], [0:32], [16:32], [0:32]}
  jit__roll_static_.57 = f32[32,32,16,32]{3,2,1,0} call(slice.91), to_apply=_roll_static_6.2
  concatenate.31 = f32[32,32,32,32]{3,2,1,0} concatenate(jit__roll_static_.56, jit__roll_static_.57), dimensions={2}
  jit__roll_static_.58 = f32[32,32,32,32]{3,2,1,0} call(concatenate.31), to_apply=_roll_static_12.3
  reshape_squeeze_broadcast_in_dim.42 = f32[1,1,32,1]{3,2,1,0} reshape(sub.60)
  mul.396 = f32[1,1,32,1]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.42), dimensions={0,1,2,3}
  mul.397 = f32[32]{0} reshape(mul.396)
  mul.398 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.397), dimensions={2}
  mul.399 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.58, mul.398)
  jit__roll_static_.59 = f32[32,32,32,32]{3,2,1,0} call(concatenate.31), to_apply=_roll_static_19.4
  reshape_squeeze_broadcast_in_dim.43 = f32[1,1,32,1]{3,2,1,0} reshape(add.144)
  mul.400 = f32[1,1,32,1]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.43), dimensions={0,1,2,3}
  mul.401 = f32[32]{0} reshape(mul.400)
  mul.402 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.401), dimensions={2}
  mul.403 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.59, mul.402)
  add.279 = f32[32,32,32,32]{3,2,1,0} add(mul.399, mul.403)
  jit__roll_static_.60 = f32[32,32,32,32]{3,2,1,0} call(concatenate.31), to_apply=_roll_static_24.5
  reshape_squeeze_broadcast_in_dim.44 = f32[1,1,32,1]{3,2,1,0} reshape(sub.65)
  mul.404 = f32[1,1,32,1]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.44), dimensions={0,1,2,3}
  mul.405 = f32[32]{0} reshape(mul.404)
  mul.406 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.405), dimensions={2}
  mul.407 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.60, mul.406)
  add.280 = f32[32,32,32,32]{3,2,1,0} add(add.279, mul.407)
  jit__roll_static_.61 = f32[32,32,32,32]{3,2,1,0} call(concatenate.31), to_apply=_roll_static_29.6
  reshape_squeeze_broadcast_in_dim.45 = f32[1,1,32,1]{3,2,1,0} reshape(add.148)
  mul.408 = f32[1,1,32,1]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.45), dimensions={0,1,2,3}
  mul.409 = f32[32]{0} reshape(mul.408)
  mul.410 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.409), dimensions={2}
  mul.411 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.61, mul.410)
  add.281 = f32[32,32,32,32]{3,2,1,0} add(add.280, mul.411)
  jit__roll_static_.62 = f32[32,32,32,32]{3,2,1,0} call(concatenate.31), to_apply=_roll_static_34.7
  reshape_squeeze_broadcast_in_dim.46 = f32[1,1,32,1]{3,2,1,0} reshape(sub.69)
  mul.412 = f32[1,1,32,1]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.46), dimensions={0,1,2,3}
  mul.413 = f32[32]{0} reshape(mul.412)
  mul.414 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.413), dimensions={2}
  mul.415 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.62, mul.414)
  add.282 = f32[32,32,32,32]{3,2,1,0} add(add.281, mul.415)
  jit__roll_static_.63 = f32[32,32,32,32]{3,2,1,0} call(concatenate.31), to_apply=_roll_static_39.8
  reshape_squeeze_broadcast_in_dim.47 = f32[1,1,32,1]{3,2,1,0} reshape(add.151)
  mul.416 = f32[1,1,32,1]{3,2,1,0} broadcast(reshape_squeeze_broadcast_in_dim.47), dimensions={0,1,2,3}
  mul.417 = f32[32]{0} reshape(mul.416)
  mul.418 = f32[32,32,32,32]{3,2,1,0} broadcast(mul.417), dimensions={2}
  mul.419 = f32[32,32,32,32]{3,2,1,0} multiply(jit__roll_static_.63, mul.418)
  add.283 = f32[32,32,32,32]{3,2,1,0} add(add.282, mul.419)
  jit_solve_poisson_.8 = f32[32,32]{1,0} get-tuple-element(jit_solve_poisson_.5), index=2
  jit_solve_poisson_.9 = f32[32,32]{1,0} get-tuple-element(jit_solve_poisson_.5), index=3
  ROOT tuple.3 = (f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(add.283, jit_solve_poisson_.8, jit_solve_poisson_.9)
}

region_0.25 {
  arg_tuple.1 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) parameter(0)
  get-tuple-element.4 = s32[] get-tuple-element(arg_tuple.1), index=0
  constant.104 = s32[] constant(1)
  add.285 = s32[] add(get-tuple-element.4, constant.104)
  constant.108 = f32[32]{0} constant({...})
  constant.107 = f32[32,1]{1,0} constant({...})
  constant.106 = f32[1,17]{1,0} constant({...})
  constant.105 = f32[32,17]{1,0} constant({...})
  get-tuple-element.5 = f32[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.1), index=1
  get-tuple-element.6 = f32[32,32]{1,0} get-tuple-element(arg_tuple.1), index=2
  get-tuple-element.7 = f32[32,32]{1,0} get-tuple-element(arg_tuple.1), index=3
  closed_call.4 = (f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) call(constant.108, constant.108, constant.107, constant.106, constant.105, get-tuple-element.5, get-tuple-element.6, get-tuple-element.7), to_apply=closed_call.24
  closed_call.5 = f32[32,32,32,32]{3,2,1,0} get-tuple-element(closed_call.4), index=0
  closed_call.6 = f32[32,32]{1,0} get-tuple-element(closed_call.4), index=1
  closed_call.7 = f32[32,32]{1,0} get-tuple-element(closed_call.4), index=2
  ROOT tuple.5 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(add.285, closed_call.5, closed_call.6, closed_call.7)
}

region_2.26 {
  arg_tuple.3 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) parameter(0)
  get-tuple-element.13 = f32[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.3), index=1
  get-tuple-element.14 = f32[32,32]{1,0} get-tuple-element(arg_tuple.3), index=2
  get-tuple-element.15 = f32[32,32]{1,0} get-tuple-element(arg_tuple.3), index=3
  get-tuple-element.12 = s32[] get-tuple-element(arg_tuple.3), index=0
  constant.110 = s32[] constant(128)
  ROOT lt.1 = pred[] compare(get-tuple-element.12, constant.110), direction=LT
}

ENTRY main.27 {
  constant.119 = s32[] constant(0)
  start_state_2__0_.1 = f32[32,32,32,32]{3,2,1,0} parameter(2)
  start_state_1__0_.1 = f32[32,32]{1,0} parameter(0)
  start_state_1__1_.1 = f32[32,32]{1,0} parameter(1)
  while.6 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(constant.119, start_state_2__0_.1, start_state_1__0_.1, start_state_1__1_.1)
  while.7 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) while(while.6), condition=region_2.26, body=region_0.25
  while.8 = s32[] get-tuple-element(while.7), index=0
  constant.116 = f32[32]{0} constant({...})
  constant.117 = f32[32]{0} constant({...})
  constant.113 = f32[32,1]{1,0} constant({...})
  constant.114 = f32[1,17]{1,0} constant({...})
  constant.115 = f32[32,17]{1,0} constant({...})
  constant.118 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  while.10 = f32[32,32]{1,0} get-tuple-element(while.7), index=2
  while.11 = f32[32,32]{1,0} get-tuple-element(while.7), index=3
  while.9 = f32[32,32,32,32]{3,2,1,0} get-tuple-element(while.7), index=1
  start_state_2__1_.1 = f32[32,32]{1,0} parameter(3)
  start_state_3_.1 = f32[] parameter(4)
  constant.111 = f32[] constant(6.4)
  add.288 = f32[] add(start_state_3_.1, constant.111)
  start_state_4_.1 = s32[] parameter(5)
  constant.112 = s32[] constant(128)
  add.289 = s32[] add(start_state_4_.1, constant.112)
  ROOT tuple.7 = (f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,1]{1,0}, /*index=5*/f32[1,17]{1,0}, f32[32,17]{1,0}, s32[6]{0}, f32[32,32]{1,0}, f32[32,32]{1,0}, /*index=10*/f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[], s32[]) tuple(constant.116, constant.116, constant.117, constant.117, constant.113, constant.114, constant.115, constant.118, while.10, while.11, while.9, start_state_2__1_.1, add.288, add.289)
}

