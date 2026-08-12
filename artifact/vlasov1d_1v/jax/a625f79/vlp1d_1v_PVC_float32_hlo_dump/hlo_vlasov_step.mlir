HloModule jit__lambda_, entry_computation_layout={(f32[128,128]{1,0})->(f32[128,128]{0,1}, f32[128]{0}, f32[128]{0})}

_where.10 {
  Arg_0.11 = pred[] parameter(0)
  Arg_1.12 = s32[] parameter(1)
  Arg_2.13 = s32[] parameter(2)
  ROOT select.14 = s32[] select(Arg_0.11, Arg_1.12, Arg_2.13)
}

remainder.15 {
  Arg_0.16 = s32[128,128,6]{2,1,0} parameter(0)
  Arg_1.17 = s32[] parameter(1)
  constant.21 = s32[] constant(0)
  compare.22 = pred[] compare(Arg_1.17, constant.21), direction=EQ
  constant.20 = s32[] constant(1)
  call.23 = s32[] call(compare.22, constant.20, Arg_1.17), to_apply=_where.10
  broadcast.24 = s32[128,128,6]{2,1,0} broadcast(call.23), dimensions={}
  remainder.25 = s32[128,128,6]{2,1,0} remainder(Arg_0.16, broadcast.24)
  constant.18 = s32[] constant(0)
  broadcast.19 = s32[128,128,6]{2,1,0} broadcast(constant.18), dimensions={}
  compare.27 = pred[128,128,6]{2,1,0} compare(remainder.25, broadcast.19), direction=LT
  compare.28 = pred[] compare(call.23, constant.21), direction=LT
  broadcast.29 = pred[128,128,6]{2,1,0} broadcast(compare.28), dimensions={}
  compare.30 = pred[128,128,6]{2,1,0} compare(compare.27, broadcast.29), direction=NE
  compare.26 = pred[128,128,6]{2,1,0} compare(remainder.25, broadcast.19), direction=NE
  and.31 = pred[128,128,6]{2,1,0} and(compare.30, compare.26)
  broadcast.32 = s32[128,128,6]{2,1,0} broadcast(call.23), dimensions={}
  add.33 = s32[128,128,6]{2,1,0} add(remainder.25, broadcast.32)
  ROOT select.34 = s32[128,128,6]{2,1,0} select(and.31, add.33, remainder.25)
}

advect_1d_vectorized.35 {
  iota.72 = f32[128]{0} iota(), iota_dimension=0
  reshape.78 = f32[1,128]{1,0} reshape(iota.72)
  broadcast.79 = f32[1,128]{1,0} broadcast(reshape.78), dimensions={0,1}
  reshape.80 = f32[128]{0} reshape(broadcast.79)
  broadcast.81 = f32[128,128]{1,0} broadcast(reshape.80), dimensions={1}
  Arg_1.37 = f32[128]{0} parameter(1)
  reshape.73 = f32[128,1]{1,0} reshape(Arg_1.37)
  Arg_2.38 = f32[] parameter(2)
  broadcast.74 = f32[128,1]{1,0} broadcast(Arg_2.38), dimensions={}
  multiply.75 = f32[128,1]{1,0} multiply(reshape.73, broadcast.74)
  Arg_3.39 = f32[] parameter(3)
  broadcast.76 = f32[128,1]{1,0} broadcast(Arg_3.39), dimensions={}
  divide.77 = f32[128,1]{1,0} divide(multiply.75, broadcast.76)
  broadcast.82 = f32[128,1]{1,0} broadcast(divide.77), dimensions={0,1}
  reshape.83 = f32[128]{0} reshape(broadcast.82)
  broadcast.84 = f32[128,128]{1,0} broadcast(reshape.83), dimensions={0}
  subtract.85 = f32[128,128]{1,0} subtract(broadcast.81, broadcast.84)
  floor.86 = f32[128,128]{1,0} floor(subtract.85)
  subtract.87 = f32[128,128]{1,0} subtract(subtract.85, floor.86)
  constant.63 = f32[] constant(20)
  broadcast.64 = f32[128,128]{1,0} broadcast(constant.63), dimensions={}
  divide.118 = f32[128,128]{1,0} divide(subtract.87, broadcast.64)
  multiply.114 = f32[128,128]{1,0} multiply(subtract.87, subtract.87)
  constant.61 = f32[] constant(24)
  broadcast.62 = f32[128,128]{1,0} broadcast(constant.61), dimensions={}
  divide.119 = f32[128,128]{1,0} divide(multiply.114, broadcast.62)
  subtract.120 = f32[128,128]{1,0} subtract(divide.118, divide.119)
  multiply.115 = f32[128,128]{1,0} multiply(multiply.114, subtract.87)
  divide.121 = f32[128,128]{1,0} divide(multiply.115, broadcast.62)
  subtract.122 = f32[128,128]{1,0} subtract(subtract.120, divide.121)
  multiply.116 = f32[128,128]{1,0} multiply(multiply.115, subtract.87)
  divide.123 = f32[128,128]{1,0} divide(multiply.116, broadcast.62)
  add.124 = f32[128,128]{1,0} add(subtract.122, divide.123)
  multiply.117 = f32[128,128]{1,0} multiply(multiply.116, subtract.87)
  constant.59 = f32[] constant(120)
  broadcast.60 = f32[128,128]{1,0} broadcast(constant.59), dimensions={}
  divide.125 = f32[128,128]{1,0} divide(multiply.117, broadcast.60)
  subtract.126 = f32[128,128]{1,0} subtract(add.124, divide.125)
  Arg_0.36 = f32[128,128]{1,0} parameter(0)
  reshape.106 = f32[16384]{0} reshape(Arg_0.36)
  iota.99 = s32[128]{0} iota(), iota_dimension=0
  reshape.100 = s32[128,1,1]{2,1,0} reshape(iota.99)
  constant.69 = s32[] constant(128)
  broadcast.70 = s32[128,1,1]{2,1,0} broadcast(constant.69), dimensions={}
  multiply.101 = s32[128,1,1]{2,1,0} multiply(reshape.100, broadcast.70)
  broadcast.102 = s32[128,1,1]{2,1,0} broadcast(multiply.101), dimensions={0,1,2}
  reshape.103 = s32[128]{0} reshape(broadcast.102)
  broadcast.104 = s32[128,128,6]{2,1,0} broadcast(reshape.103), dimensions={0}
  convert.88 = s32[128,128]{1,0} convert(floor.86)
  reshape.89 = s32[128,128,1]{2,1,0} reshape(convert.88)
  broadcast.91 = s32[128,128,1]{2,1,0} broadcast(reshape.89), dimensions={0,1,2}
  reshape.92 = s32[128,128]{1,0} reshape(broadcast.91)
  broadcast.93 = s32[128,128,6]{2,1,0} broadcast(reshape.92), dimensions={0,1}
  Arg_4.40 = s32[6]{0} parameter(4)
  reshape.90 = s32[1,1,6]{2,1,0} reshape(Arg_4.40)
  broadcast.94 = s32[1,1,6]{2,1,0} broadcast(reshape.90), dimensions={0,1,2}
  reshape.95 = s32[6]{0} reshape(broadcast.94)
  broadcast.96 = s32[128,128,6]{2,1,0} broadcast(reshape.95), dimensions={2}
  add.97 = s32[128,128,6]{2,1,0} add(broadcast.93, broadcast.96)
  constant.71 = s32[] constant(128)
  call.98 = s32[128,128,6]{2,1,0} call(add.97, constant.71), to_apply=remainder.15
  add.105 = s32[128,128,6]{2,1,0} add(broadcast.104, call.98)
  reshape.107 = s32[98304]{0} reshape(add.105)
  constant.67 = s32[] constant(0)
  broadcast.68 = s32[98304]{0} broadcast(constant.67), dimensions={}
  compare.108 = pred[98304]{0} compare(reshape.107, broadcast.68), direction=LT
  constant.65 = s32[] constant(16384)
  broadcast.66 = s32[98304]{0} broadcast(constant.65), dimensions={}
  add.109 = s32[98304]{0} add(reshape.107, broadcast.66)
  select.110 = s32[98304]{0} select(compare.108, add.109, reshape.107)
  reshape.111 = s32[98304,1]{1,0} reshape(select.110)
  gather.112 = f32[98304]{0} gather(reshape.106, reshape.111), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.113 = f32[128,128,6]{2,1,0} reshape(gather.112)
  slice.176 = f32[128,128,1]{2,1,0} slice(reshape.113), slice={[0:128], [0:128], [0:1]}
  reshape.177 = f32[128,128]{1,0} reshape(slice.176)
  multiply.178 = f32[128,128]{1,0} multiply(subtract.126, reshape.177)
  constant.57 = f32[] constant(2)
  broadcast.58 = f32[128,128]{1,0} broadcast(constant.57), dimensions={}
  divide.127 = f32[128,128]{1,0} divide(subtract.87, broadcast.58)
  negate.128 = f32[128,128]{1,0} negate(divide.127)
  multiply.129 = f32[128,128]{1,0} multiply(multiply.114, broadcast.58)
  constant.55 = f32[] constant(3)
  broadcast.56 = f32[128,128]{1,0} broadcast(constant.55), dimensions={}
  divide.130 = f32[128,128]{1,0} divide(multiply.129, broadcast.56)
  add.131 = f32[128,128]{1,0} add(negate.128, divide.130)
  divide.132 = f32[128,128]{1,0} divide(multiply.115, broadcast.62)
  subtract.133 = f32[128,128]{1,0} subtract(add.131, divide.132)
  constant.53 = f32[] constant(6)
  broadcast.54 = f32[128,128]{1,0} broadcast(constant.53), dimensions={}
  divide.134 = f32[128,128]{1,0} divide(multiply.116, broadcast.54)
  subtract.135 = f32[128,128]{1,0} subtract(subtract.133, divide.134)
  divide.136 = f32[128,128]{1,0} divide(multiply.117, broadcast.62)
  add.137 = f32[128,128]{1,0} add(subtract.135, divide.136)
  slice.179 = f32[128,128,1]{2,1,0} slice(reshape.113), slice={[0:128], [0:128], [1:2]}
  reshape.180 = f32[128,128]{1,0} reshape(slice.179)
  multiply.181 = f32[128,128]{1,0} multiply(add.137, reshape.180)
  add.182 = f32[128,128]{1,0} add(multiply.178, multiply.181)
  constant.51 = f32[] constant(1)
  broadcast.52 = f32[128,128]{1,0} broadcast(constant.51), dimensions={}
  divide.138 = f32[128,128]{1,0} divide(subtract.87, broadcast.56)
  subtract.139 = f32[128,128]{1,0} subtract(broadcast.52, divide.138)
  constant.49 = f32[] constant(5)
  broadcast.50 = f32[128,128]{1,0} broadcast(constant.49), dimensions={}
  multiply.140 = f32[128,128]{1,0} multiply(multiply.114, broadcast.50)
  constant.47 = f32[] constant(4)
  broadcast.48 = f32[128,128]{1,0} broadcast(constant.47), dimensions={}
  divide.141 = f32[128,128]{1,0} divide(multiply.140, broadcast.48)
  subtract.142 = f32[128,128]{1,0} subtract(subtract.139, divide.141)
  multiply.143 = f32[128,128]{1,0} multiply(multiply.115, broadcast.50)
  constant.45 = f32[] constant(12)
  broadcast.46 = f32[128,128]{1,0} broadcast(constant.45), dimensions={}
  divide.144 = f32[128,128]{1,0} divide(multiply.143, broadcast.46)
  add.145 = f32[128,128]{1,0} add(subtract.142, divide.144)
  divide.146 = f32[128,128]{1,0} divide(multiply.116, broadcast.48)
  add.147 = f32[128,128]{1,0} add(add.145, divide.146)
  divide.148 = f32[128,128]{1,0} divide(multiply.117, broadcast.46)
  subtract.149 = f32[128,128]{1,0} subtract(add.147, divide.148)
  slice.183 = f32[128,128,1]{2,1,0} slice(reshape.113), slice={[0:128], [0:128], [2:3]}
  reshape.184 = f32[128,128]{1,0} reshape(slice.183)
  multiply.185 = f32[128,128]{1,0} multiply(subtract.149, reshape.184)
  add.186 = f32[128,128]{1,0} add(add.182, multiply.185)
  multiply.150 = f32[128,128]{1,0} multiply(multiply.114, broadcast.58)
  divide.151 = f32[128,128]{1,0} divide(multiply.150, broadcast.56)
  add.152 = f32[128,128]{1,0} add(subtract.87, divide.151)
  constant.43 = f32[] constant(7)
  broadcast.44 = f32[128,128]{1,0} broadcast(constant.43), dimensions={}
  multiply.153 = f32[128,128]{1,0} multiply(multiply.115, broadcast.44)
  divide.154 = f32[128,128]{1,0} divide(multiply.153, broadcast.46)
  subtract.155 = f32[128,128]{1,0} subtract(add.152, divide.154)
  divide.156 = f32[128,128]{1,0} divide(multiply.116, broadcast.54)
  subtract.157 = f32[128,128]{1,0} subtract(subtract.155, divide.156)
  divide.158 = f32[128,128]{1,0} divide(multiply.117, broadcast.46)
  add.159 = f32[128,128]{1,0} add(subtract.157, divide.158)
  slice.187 = f32[128,128,1]{2,1,0} slice(reshape.113), slice={[0:128], [0:128], [3:4]}
  reshape.188 = f32[128,128]{1,0} reshape(slice.187)
  multiply.189 = f32[128,128]{1,0} multiply(add.159, reshape.188)
  add.190 = f32[128,128]{1,0} add(add.186, multiply.189)
  divide.160 = f32[128,128]{1,0} divide(subtract.87, broadcast.48)
  negate.161 = f32[128,128]{1,0} negate(divide.160)
  divide.162 = f32[128,128]{1,0} divide(multiply.114, broadcast.62)
  subtract.163 = f32[128,128]{1,0} subtract(negate.161, divide.162)
  multiply.164 = f32[128,128]{1,0} multiply(multiply.115, broadcast.44)
  divide.165 = f32[128,128]{1,0} divide(multiply.164, broadcast.62)
  add.166 = f32[128,128]{1,0} add(subtract.163, divide.165)
  divide.167 = f32[128,128]{1,0} divide(multiply.116, broadcast.62)
  add.168 = f32[128,128]{1,0} add(add.166, divide.167)
  divide.169 = f32[128,128]{1,0} divide(multiply.117, broadcast.62)
  subtract.170 = f32[128,128]{1,0} subtract(add.168, divide.169)
  slice.191 = f32[128,128,1]{2,1,0} slice(reshape.113), slice={[0:128], [0:128], [4:5]}
  reshape.192 = f32[128,128]{1,0} reshape(slice.191)
  multiply.193 = f32[128,128]{1,0} multiply(subtract.170, reshape.192)
  add.194 = f32[128,128]{1,0} add(add.190, multiply.193)
  constant.41 = f32[] constant(30)
  broadcast.42 = f32[128,128]{1,0} broadcast(constant.41), dimensions={}
  divide.171 = f32[128,128]{1,0} divide(subtract.87, broadcast.42)
  divide.172 = f32[128,128]{1,0} divide(multiply.115, broadcast.62)
  subtract.173 = f32[128,128]{1,0} subtract(divide.171, divide.172)
  divide.174 = f32[128,128]{1,0} divide(multiply.117, broadcast.60)
  add.175 = f32[128,128]{1,0} add(subtract.173, divide.174)
  slice.195 = f32[128,128,1]{2,1,0} slice(reshape.113), slice={[0:128], [0:128], [5:6]}
  reshape.196 = f32[128,128]{1,0} reshape(slice.195)
  multiply.197 = f32[128,128]{1,0} multiply(add.175, reshape.196)
  ROOT add.198 = f32[128,128]{1,0} add(add.194, multiply.197)
}

region_0.201 {
  Arg_0.202 = f32[] parameter(0)
  Arg_1.203 = f32[] parameter(1)
  ROOT add.204 = f32[] add(Arg_0.202, Arg_1.203)
}

fft.205 {
  Arg_0.206 = f32[128]{0} parameter(0)
  ROOT fft.207 = c64[65]{0} fft(Arg_0.206), fft_type=RFFT, fft_length={128}
}

fft_0.208 {
  Arg_0.209 = c64[65]{0} parameter(0)
  ROOT fft.210 = f32[128]{0} fft(Arg_0.209), fft_type=IRFFT, fft_length={128}
}

fft_0.211 {
  Arg_0.212 = c64[65]{0} parameter(0)
  ROOT fft.213 = f32[128]{0} fft(Arg_0.212), fft_type=IRFFT, fft_length={128}
}

solve_poisson.214 {
  Arg_0.215 = f32[128,128]{1,0} parameter(0)
  constant.222 = f32[] constant(0)
  reduce.223 = f32[128]{0} reduce(Arg_0.215, constant.222), dimensions={1}, to_apply=region_0.201
  Arg_2.217 = f32[] parameter(2)
  broadcast.224 = f32[128]{0} broadcast(Arg_2.217), dimensions={}
  multiply.225 = f32[128]{0} multiply(reduce.223, broadcast.224)
  constant.220 = f32[] constant(1)
  broadcast.221 = f32[128]{0} broadcast(constant.220), dimensions={}
  subtract.226 = f32[128]{0} subtract(multiply.225, broadcast.221)
  call.227 = c64[65]{0} call(subtract.226), to_apply=fft.205
  constant.218 = c64[] constant((-0, -1))
  broadcast.219 = c64[65]{0} broadcast(constant.218), dimensions={}
  multiply.228 = c64[65]{0} multiply(call.227, broadcast.219)
  Arg_1.216 = f32[65]{0} parameter(1)
  convert.229 = c64[65]{0} convert(Arg_1.216)
  multiply.230 = c64[65]{0} multiply(multiply.228, convert.229)
  call.231 = f32[128]{0} call(multiply.230), to_apply=fft_0.208
  multiply.232 = f32[65]{0} multiply(Arg_1.216, Arg_1.216)
  convert.233 = c64[65]{0} convert(multiply.232)
  multiply.234 = c64[65]{0} multiply(call.227, convert.233)
  call.235 = f32[128]{0} call(multiply.234), to_apply=fft_0.211
  ROOT tuple.236 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) tuple(call.231, subtract.226, call.235)
}

clip.241 {
  Arg_2.244 = s32[] parameter(2)
  broadcast.247 = s32[128,128,6]{2,1,0} broadcast(Arg_2.244), dimensions={}
  Arg_1.243 = s32[] parameter(1)
  broadcast.245 = s32[128,128,6]{2,1,0} broadcast(Arg_1.243), dimensions={}
  Arg_0.242 = s32[128,128,6]{2,1,0} parameter(0)
  maximum.246 = s32[128,128,6]{2,1,0} maximum(broadcast.245, Arg_0.242)
  ROOT minimum.248 = s32[128,128,6]{2,1,0} minimum(broadcast.247, maximum.246)
}

_where_2.249 {
  Arg_0.250 = pred[128,128,6]{2,1,0} parameter(0)
  Arg_1.251 = f32[128,128,6]{2,1,0} parameter(1)
  Arg_2.252 = f32[] parameter(2)
  broadcast.253 = f32[128,128,6]{2,1,0} broadcast(Arg_2.252), dimensions={}
  ROOT select.254 = f32[128,128,6]{2,1,0} select(Arg_0.250, Arg_1.251, broadcast.253)
}

advect_1d_vectorized_1.255 {
  iota.298 = f32[128]{0} iota(), iota_dimension=0
  reshape.304 = f32[1,128]{1,0} reshape(iota.298)
  broadcast.305 = f32[1,128]{1,0} broadcast(reshape.304), dimensions={0,1}
  reshape.306 = f32[128]{0} reshape(broadcast.305)
  broadcast.307 = f32[128,128]{1,0} broadcast(reshape.306), dimensions={1}
  Arg_1.257 = f32[128]{0} parameter(1)
  reshape.299 = f32[128,1]{1,0} reshape(Arg_1.257)
  Arg_2.258 = f32[] parameter(2)
  broadcast.300 = f32[128,1]{1,0} broadcast(Arg_2.258), dimensions={}
  multiply.301 = f32[128,1]{1,0} multiply(reshape.299, broadcast.300)
  Arg_3.259 = f32[] parameter(3)
  broadcast.302 = f32[128,1]{1,0} broadcast(Arg_3.259), dimensions={}
  divide.303 = f32[128,1]{1,0} divide(multiply.301, broadcast.302)
  broadcast.308 = f32[128,1]{1,0} broadcast(divide.303), dimensions={0,1}
  reshape.309 = f32[128]{0} reshape(broadcast.308)
  broadcast.310 = f32[128,128]{1,0} broadcast(reshape.309), dimensions={0}
  subtract.311 = f32[128,128]{1,0} subtract(broadcast.307, broadcast.310)
  floor.312 = f32[128,128]{1,0} floor(subtract.311)
  subtract.313 = f32[128,128]{1,0} subtract(subtract.311, floor.312)
  constant.283 = f32[] constant(20)
  broadcast.284 = f32[128,128]{1,0} broadcast(constant.283), dimensions={}
  divide.348 = f32[128,128]{1,0} divide(subtract.313, broadcast.284)
  multiply.344 = f32[128,128]{1,0} multiply(subtract.313, subtract.313)
  constant.281 = f32[] constant(24)
  broadcast.282 = f32[128,128]{1,0} broadcast(constant.281), dimensions={}
  divide.349 = f32[128,128]{1,0} divide(multiply.344, broadcast.282)
  subtract.350 = f32[128,128]{1,0} subtract(divide.348, divide.349)
  multiply.345 = f32[128,128]{1,0} multiply(multiply.344, subtract.313)
  divide.351 = f32[128,128]{1,0} divide(multiply.345, broadcast.282)
  subtract.352 = f32[128,128]{1,0} subtract(subtract.350, divide.351)
  multiply.346 = f32[128,128]{1,0} multiply(multiply.345, subtract.313)
  divide.353 = f32[128,128]{1,0} divide(multiply.346, broadcast.282)
  add.354 = f32[128,128]{1,0} add(subtract.352, divide.353)
  multiply.347 = f32[128,128]{1,0} multiply(multiply.346, subtract.313)
  constant.279 = f32[] constant(120)
  broadcast.280 = f32[128,128]{1,0} broadcast(constant.279), dimensions={}
  divide.355 = f32[128,128]{1,0} divide(multiply.347, broadcast.280)
  subtract.356 = f32[128,128]{1,0} subtract(add.354, divide.355)
  convert.314 = s32[128,128]{1,0} convert(floor.312)
  reshape.315 = s32[128,128,1]{2,1,0} reshape(convert.314)
  broadcast.317 = s32[128,128,1]{2,1,0} broadcast(reshape.315), dimensions={0,1,2}
  reshape.318 = s32[128,128]{1,0} reshape(broadcast.317)
  broadcast.319 = s32[128,128,6]{2,1,0} broadcast(reshape.318), dimensions={0,1}
  Arg_4.260 = s32[6]{0} parameter(4)
  reshape.316 = s32[1,1,6]{2,1,0} reshape(Arg_4.260)
  broadcast.320 = s32[1,1,6]{2,1,0} broadcast(reshape.316), dimensions={0,1,2}
  reshape.321 = s32[6]{0} reshape(broadcast.320)
  broadcast.322 = s32[128,128,6]{2,1,0} broadcast(reshape.321), dimensions={2}
  add.323 = s32[128,128,6]{2,1,0} add(broadcast.319, broadcast.322)
  constant.293 = s32[] constant(0)
  broadcast.294 = s32[128,128,6]{2,1,0} broadcast(constant.293), dimensions={}
  compare.324 = pred[128,128,6]{2,1,0} compare(add.323, broadcast.294), direction=GE
  constant.291 = s32[] constant(128)
  broadcast.292 = s32[128,128,6]{2,1,0} broadcast(constant.291), dimensions={}
  compare.325 = pred[128,128,6]{2,1,0} compare(add.323, broadcast.292), direction=LT
  and.326 = pred[128,128,6]{2,1,0} and(compare.324, compare.325)
  Arg_0.256 = f32[128,128]{1,0} parameter(0)
  reshape.335 = f32[16384]{0} reshape(Arg_0.256)
  iota.328 = s32[128]{0} iota(), iota_dimension=0
  reshape.329 = s32[128,1,1]{2,1,0} reshape(iota.328)
  constant.289 = s32[] constant(128)
  broadcast.290 = s32[128,1,1]{2,1,0} broadcast(constant.289), dimensions={}
  multiply.330 = s32[128,1,1]{2,1,0} multiply(reshape.329, broadcast.290)
  broadcast.331 = s32[128,1,1]{2,1,0} broadcast(multiply.330), dimensions={0,1,2}
  reshape.332 = s32[128]{0} reshape(broadcast.331)
  broadcast.333 = s32[128,128,6]{2,1,0} broadcast(reshape.332), dimensions={0}
  constant.297 = s32[] constant(0)
  constant.296 = s32[] constant(127)
  call.327 = s32[128,128,6]{2,1,0} call(add.323, constant.297, constant.296), to_apply=clip.241
  add.334 = s32[128,128,6]{2,1,0} add(broadcast.333, call.327)
  reshape.336 = s32[98304]{0} reshape(add.334)
  constant.287 = s32[] constant(0)
  broadcast.288 = s32[98304]{0} broadcast(constant.287), dimensions={}
  compare.337 = pred[98304]{0} compare(reshape.336, broadcast.288), direction=LT
  constant.285 = s32[] constant(16384)
  broadcast.286 = s32[98304]{0} broadcast(constant.285), dimensions={}
  add.338 = s32[98304]{0} add(reshape.336, broadcast.286)
  select.339 = s32[98304]{0} select(compare.337, add.338, reshape.336)
  reshape.340 = s32[98304,1]{1,0} reshape(select.339)
  gather.341 = f32[98304]{0} gather(reshape.335, reshape.340), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.342 = f32[128,128,6]{2,1,0} reshape(gather.341)
  constant.295 = f32[] constant(0)
  call.343 = f32[128,128,6]{2,1,0} call(and.326, reshape.342, constant.295), to_apply=_where_2.249
  slice.406 = f32[128,128,1]{2,1,0} slice(call.343), slice={[0:128], [0:128], [0:1]}
  reshape.407 = f32[128,128]{1,0} reshape(slice.406)
  multiply.408 = f32[128,128]{1,0} multiply(subtract.356, reshape.407)
  constant.277 = f32[] constant(2)
  broadcast.278 = f32[128,128]{1,0} broadcast(constant.277), dimensions={}
  divide.357 = f32[128,128]{1,0} divide(subtract.313, broadcast.278)
  negate.358 = f32[128,128]{1,0} negate(divide.357)
  multiply.359 = f32[128,128]{1,0} multiply(multiply.344, broadcast.278)
  constant.275 = f32[] constant(3)
  broadcast.276 = f32[128,128]{1,0} broadcast(constant.275), dimensions={}
  divide.360 = f32[128,128]{1,0} divide(multiply.359, broadcast.276)
  add.361 = f32[128,128]{1,0} add(negate.358, divide.360)
  divide.362 = f32[128,128]{1,0} divide(multiply.345, broadcast.282)
  subtract.363 = f32[128,128]{1,0} subtract(add.361, divide.362)
  constant.273 = f32[] constant(6)
  broadcast.274 = f32[128,128]{1,0} broadcast(constant.273), dimensions={}
  divide.364 = f32[128,128]{1,0} divide(multiply.346, broadcast.274)
  subtract.365 = f32[128,128]{1,0} subtract(subtract.363, divide.364)
  divide.366 = f32[128,128]{1,0} divide(multiply.347, broadcast.282)
  add.367 = f32[128,128]{1,0} add(subtract.365, divide.366)
  slice.409 = f32[128,128,1]{2,1,0} slice(call.343), slice={[0:128], [0:128], [1:2]}
  reshape.410 = f32[128,128]{1,0} reshape(slice.409)
  multiply.411 = f32[128,128]{1,0} multiply(add.367, reshape.410)
  add.412 = f32[128,128]{1,0} add(multiply.408, multiply.411)
  constant.271 = f32[] constant(1)
  broadcast.272 = f32[128,128]{1,0} broadcast(constant.271), dimensions={}
  divide.368 = f32[128,128]{1,0} divide(subtract.313, broadcast.276)
  subtract.369 = f32[128,128]{1,0} subtract(broadcast.272, divide.368)
  constant.269 = f32[] constant(5)
  broadcast.270 = f32[128,128]{1,0} broadcast(constant.269), dimensions={}
  multiply.370 = f32[128,128]{1,0} multiply(multiply.344, broadcast.270)
  constant.267 = f32[] constant(4)
  broadcast.268 = f32[128,128]{1,0} broadcast(constant.267), dimensions={}
  divide.371 = f32[128,128]{1,0} divide(multiply.370, broadcast.268)
  subtract.372 = f32[128,128]{1,0} subtract(subtract.369, divide.371)
  multiply.373 = f32[128,128]{1,0} multiply(multiply.345, broadcast.270)
  constant.265 = f32[] constant(12)
  broadcast.266 = f32[128,128]{1,0} broadcast(constant.265), dimensions={}
  divide.374 = f32[128,128]{1,0} divide(multiply.373, broadcast.266)
  add.375 = f32[128,128]{1,0} add(subtract.372, divide.374)
  divide.376 = f32[128,128]{1,0} divide(multiply.346, broadcast.268)
  add.377 = f32[128,128]{1,0} add(add.375, divide.376)
  divide.378 = f32[128,128]{1,0} divide(multiply.347, broadcast.266)
  subtract.379 = f32[128,128]{1,0} subtract(add.377, divide.378)
  slice.413 = f32[128,128,1]{2,1,0} slice(call.343), slice={[0:128], [0:128], [2:3]}
  reshape.414 = f32[128,128]{1,0} reshape(slice.413)
  multiply.415 = f32[128,128]{1,0} multiply(subtract.379, reshape.414)
  add.416 = f32[128,128]{1,0} add(add.412, multiply.415)
  multiply.380 = f32[128,128]{1,0} multiply(multiply.344, broadcast.278)
  divide.381 = f32[128,128]{1,0} divide(multiply.380, broadcast.276)
  add.382 = f32[128,128]{1,0} add(subtract.313, divide.381)
  constant.263 = f32[] constant(7)
  broadcast.264 = f32[128,128]{1,0} broadcast(constant.263), dimensions={}
  multiply.383 = f32[128,128]{1,0} multiply(multiply.345, broadcast.264)
  divide.384 = f32[128,128]{1,0} divide(multiply.383, broadcast.266)
  subtract.385 = f32[128,128]{1,0} subtract(add.382, divide.384)
  divide.386 = f32[128,128]{1,0} divide(multiply.346, broadcast.274)
  subtract.387 = f32[128,128]{1,0} subtract(subtract.385, divide.386)
  divide.388 = f32[128,128]{1,0} divide(multiply.347, broadcast.266)
  add.389 = f32[128,128]{1,0} add(subtract.387, divide.388)
  slice.417 = f32[128,128,1]{2,1,0} slice(call.343), slice={[0:128], [0:128], [3:4]}
  reshape.418 = f32[128,128]{1,0} reshape(slice.417)
  multiply.419 = f32[128,128]{1,0} multiply(add.389, reshape.418)
  add.420 = f32[128,128]{1,0} add(add.416, multiply.419)
  divide.390 = f32[128,128]{1,0} divide(subtract.313, broadcast.268)
  negate.391 = f32[128,128]{1,0} negate(divide.390)
  divide.392 = f32[128,128]{1,0} divide(multiply.344, broadcast.282)
  subtract.393 = f32[128,128]{1,0} subtract(negate.391, divide.392)
  multiply.394 = f32[128,128]{1,0} multiply(multiply.345, broadcast.264)
  divide.395 = f32[128,128]{1,0} divide(multiply.394, broadcast.282)
  add.396 = f32[128,128]{1,0} add(subtract.393, divide.395)
  divide.397 = f32[128,128]{1,0} divide(multiply.346, broadcast.282)
  add.398 = f32[128,128]{1,0} add(add.396, divide.397)
  divide.399 = f32[128,128]{1,0} divide(multiply.347, broadcast.282)
  subtract.400 = f32[128,128]{1,0} subtract(add.398, divide.399)
  slice.421 = f32[128,128,1]{2,1,0} slice(call.343), slice={[0:128], [0:128], [4:5]}
  reshape.422 = f32[128,128]{1,0} reshape(slice.421)
  multiply.423 = f32[128,128]{1,0} multiply(subtract.400, reshape.422)
  add.424 = f32[128,128]{1,0} add(add.420, multiply.423)
  constant.261 = f32[] constant(30)
  broadcast.262 = f32[128,128]{1,0} broadcast(constant.261), dimensions={}
  divide.401 = f32[128,128]{1,0} divide(subtract.313, broadcast.262)
  divide.402 = f32[128,128]{1,0} divide(multiply.345, broadcast.282)
  subtract.403 = f32[128,128]{1,0} subtract(divide.401, divide.402)
  divide.404 = f32[128,128]{1,0} divide(multiply.347, broadcast.280)
  add.405 = f32[128,128]{1,0} add(subtract.403, divide.404)
  slice.425 = f32[128,128,1]{2,1,0} slice(call.343), slice={[0:128], [0:128], [5:6]}
  reshape.426 = f32[128,128]{1,0} reshape(slice.425)
  multiply.427 = f32[128,128]{1,0} multiply(add.405, reshape.426)
  ROOT add.428 = f32[128,128]{1,0} add(add.424, multiply.427)
}

_where.431 {
  Arg_0.432 = pred[] parameter(0)
  Arg_1.433 = s32[] parameter(1)
  Arg_2.434 = s32[] parameter(2)
  ROOT select.435 = s32[] select(Arg_0.432, Arg_1.433, Arg_2.434)
}

remainder.436 {
  Arg_0.437 = s32[128,128,6]{2,1,0} parameter(0)
  Arg_1.438 = s32[] parameter(1)
  constant.442 = s32[] constant(0)
  compare.443 = pred[] compare(Arg_1.438, constant.442), direction=EQ
  constant.441 = s32[] constant(1)
  call.444 = s32[] call(compare.443, constant.441, Arg_1.438), to_apply=_where.431
  broadcast.445 = s32[128,128,6]{2,1,0} broadcast(call.444), dimensions={}
  remainder.446 = s32[128,128,6]{2,1,0} remainder(Arg_0.437, broadcast.445)
  constant.439 = s32[] constant(0)
  broadcast.440 = s32[128,128,6]{2,1,0} broadcast(constant.439), dimensions={}
  compare.448 = pred[128,128,6]{2,1,0} compare(remainder.446, broadcast.440), direction=LT
  compare.449 = pred[] compare(call.444, constant.442), direction=LT
  broadcast.450 = pred[128,128,6]{2,1,0} broadcast(compare.449), dimensions={}
  compare.451 = pred[128,128,6]{2,1,0} compare(compare.448, broadcast.450), direction=NE
  compare.447 = pred[128,128,6]{2,1,0} compare(remainder.446, broadcast.440), direction=NE
  and.452 = pred[128,128,6]{2,1,0} and(compare.451, compare.447)
  broadcast.453 = s32[128,128,6]{2,1,0} broadcast(call.444), dimensions={}
  add.454 = s32[128,128,6]{2,1,0} add(remainder.446, broadcast.453)
  ROOT select.455 = s32[128,128,6]{2,1,0} select(and.452, add.454, remainder.446)
}

advect_1d_vectorized.456 {
  iota.493 = f32[128]{0} iota(), iota_dimension=0
  reshape.499 = f32[1,128]{1,0} reshape(iota.493)
  broadcast.500 = f32[1,128]{1,0} broadcast(reshape.499), dimensions={0,1}
  reshape.501 = f32[128]{0} reshape(broadcast.500)
  broadcast.502 = f32[128,128]{1,0} broadcast(reshape.501), dimensions={1}
  Arg_1.458 = f32[128]{0} parameter(1)
  reshape.494 = f32[128,1]{1,0} reshape(Arg_1.458)
  Arg_2.459 = f32[] parameter(2)
  broadcast.495 = f32[128,1]{1,0} broadcast(Arg_2.459), dimensions={}
  multiply.496 = f32[128,1]{1,0} multiply(reshape.494, broadcast.495)
  Arg_3.460 = f32[] parameter(3)
  broadcast.497 = f32[128,1]{1,0} broadcast(Arg_3.460), dimensions={}
  divide.498 = f32[128,1]{1,0} divide(multiply.496, broadcast.497)
  broadcast.503 = f32[128,1]{1,0} broadcast(divide.498), dimensions={0,1}
  reshape.504 = f32[128]{0} reshape(broadcast.503)
  broadcast.505 = f32[128,128]{1,0} broadcast(reshape.504), dimensions={0}
  subtract.506 = f32[128,128]{1,0} subtract(broadcast.502, broadcast.505)
  floor.507 = f32[128,128]{1,0} floor(subtract.506)
  subtract.508 = f32[128,128]{1,0} subtract(subtract.506, floor.507)
  constant.484 = f32[] constant(20)
  broadcast.485 = f32[128,128]{1,0} broadcast(constant.484), dimensions={}
  divide.539 = f32[128,128]{1,0} divide(subtract.508, broadcast.485)
  multiply.535 = f32[128,128]{1,0} multiply(subtract.508, subtract.508)
  constant.482 = f32[] constant(24)
  broadcast.483 = f32[128,128]{1,0} broadcast(constant.482), dimensions={}
  divide.540 = f32[128,128]{1,0} divide(multiply.535, broadcast.483)
  subtract.541 = f32[128,128]{1,0} subtract(divide.539, divide.540)
  multiply.536 = f32[128,128]{1,0} multiply(multiply.535, subtract.508)
  divide.542 = f32[128,128]{1,0} divide(multiply.536, broadcast.483)
  subtract.543 = f32[128,128]{1,0} subtract(subtract.541, divide.542)
  multiply.537 = f32[128,128]{1,0} multiply(multiply.536, subtract.508)
  divide.544 = f32[128,128]{1,0} divide(multiply.537, broadcast.483)
  add.545 = f32[128,128]{1,0} add(subtract.543, divide.544)
  multiply.538 = f32[128,128]{1,0} multiply(multiply.537, subtract.508)
  constant.480 = f32[] constant(120)
  broadcast.481 = f32[128,128]{1,0} broadcast(constant.480), dimensions={}
  divide.546 = f32[128,128]{1,0} divide(multiply.538, broadcast.481)
  subtract.547 = f32[128,128]{1,0} subtract(add.545, divide.546)
  Arg_0.457 = f32[128,128]{1,0} parameter(0)
  reshape.527 = f32[16384]{0} reshape(Arg_0.457)
  iota.520 = s32[128]{0} iota(), iota_dimension=0
  reshape.521 = s32[128,1,1]{2,1,0} reshape(iota.520)
  constant.490 = s32[] constant(128)
  broadcast.491 = s32[128,1,1]{2,1,0} broadcast(constant.490), dimensions={}
  multiply.522 = s32[128,1,1]{2,1,0} multiply(reshape.521, broadcast.491)
  broadcast.523 = s32[128,1,1]{2,1,0} broadcast(multiply.522), dimensions={0,1,2}
  reshape.524 = s32[128]{0} reshape(broadcast.523)
  broadcast.525 = s32[128,128,6]{2,1,0} broadcast(reshape.524), dimensions={0}
  convert.509 = s32[128,128]{1,0} convert(floor.507)
  reshape.510 = s32[128,128,1]{2,1,0} reshape(convert.509)
  broadcast.512 = s32[128,128,1]{2,1,0} broadcast(reshape.510), dimensions={0,1,2}
  reshape.513 = s32[128,128]{1,0} reshape(broadcast.512)
  broadcast.514 = s32[128,128,6]{2,1,0} broadcast(reshape.513), dimensions={0,1}
  Arg_4.461 = s32[6]{0} parameter(4)
  reshape.511 = s32[1,1,6]{2,1,0} reshape(Arg_4.461)
  broadcast.515 = s32[1,1,6]{2,1,0} broadcast(reshape.511), dimensions={0,1,2}
  reshape.516 = s32[6]{0} reshape(broadcast.515)
  broadcast.517 = s32[128,128,6]{2,1,0} broadcast(reshape.516), dimensions={2}
  add.518 = s32[128,128,6]{2,1,0} add(broadcast.514, broadcast.517)
  constant.492 = s32[] constant(128)
  call.519 = s32[128,128,6]{2,1,0} call(add.518, constant.492), to_apply=remainder.436
  add.526 = s32[128,128,6]{2,1,0} add(broadcast.525, call.519)
  reshape.528 = s32[98304]{0} reshape(add.526)
  constant.488 = s32[] constant(0)
  broadcast.489 = s32[98304]{0} broadcast(constant.488), dimensions={}
  compare.529 = pred[98304]{0} compare(reshape.528, broadcast.489), direction=LT
  constant.486 = s32[] constant(16384)
  broadcast.487 = s32[98304]{0} broadcast(constant.486), dimensions={}
  add.530 = s32[98304]{0} add(reshape.528, broadcast.487)
  select.531 = s32[98304]{0} select(compare.529, add.530, reshape.528)
  reshape.532 = s32[98304,1]{1,0} reshape(select.531)
  gather.533 = f32[98304]{0} gather(reshape.527, reshape.532), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.534 = f32[128,128,6]{2,1,0} reshape(gather.533)
  slice.597 = f32[128,128,1]{2,1,0} slice(reshape.534), slice={[0:128], [0:128], [0:1]}
  reshape.598 = f32[128,128]{1,0} reshape(slice.597)
  multiply.599 = f32[128,128]{1,0} multiply(subtract.547, reshape.598)
  constant.478 = f32[] constant(2)
  broadcast.479 = f32[128,128]{1,0} broadcast(constant.478), dimensions={}
  divide.548 = f32[128,128]{1,0} divide(subtract.508, broadcast.479)
  negate.549 = f32[128,128]{1,0} negate(divide.548)
  multiply.550 = f32[128,128]{1,0} multiply(multiply.535, broadcast.479)
  constant.476 = f32[] constant(3)
  broadcast.477 = f32[128,128]{1,0} broadcast(constant.476), dimensions={}
  divide.551 = f32[128,128]{1,0} divide(multiply.550, broadcast.477)
  add.552 = f32[128,128]{1,0} add(negate.549, divide.551)
  divide.553 = f32[128,128]{1,0} divide(multiply.536, broadcast.483)
  subtract.554 = f32[128,128]{1,0} subtract(add.552, divide.553)
  constant.474 = f32[] constant(6)
  broadcast.475 = f32[128,128]{1,0} broadcast(constant.474), dimensions={}
  divide.555 = f32[128,128]{1,0} divide(multiply.537, broadcast.475)
  subtract.556 = f32[128,128]{1,0} subtract(subtract.554, divide.555)
  divide.557 = f32[128,128]{1,0} divide(multiply.538, broadcast.483)
  add.558 = f32[128,128]{1,0} add(subtract.556, divide.557)
  slice.600 = f32[128,128,1]{2,1,0} slice(reshape.534), slice={[0:128], [0:128], [1:2]}
  reshape.601 = f32[128,128]{1,0} reshape(slice.600)
  multiply.602 = f32[128,128]{1,0} multiply(add.558, reshape.601)
  add.603 = f32[128,128]{1,0} add(multiply.599, multiply.602)
  constant.472 = f32[] constant(1)
  broadcast.473 = f32[128,128]{1,0} broadcast(constant.472), dimensions={}
  divide.559 = f32[128,128]{1,0} divide(subtract.508, broadcast.477)
  subtract.560 = f32[128,128]{1,0} subtract(broadcast.473, divide.559)
  constant.470 = f32[] constant(5)
  broadcast.471 = f32[128,128]{1,0} broadcast(constant.470), dimensions={}
  multiply.561 = f32[128,128]{1,0} multiply(multiply.535, broadcast.471)
  constant.468 = f32[] constant(4)
  broadcast.469 = f32[128,128]{1,0} broadcast(constant.468), dimensions={}
  divide.562 = f32[128,128]{1,0} divide(multiply.561, broadcast.469)
  subtract.563 = f32[128,128]{1,0} subtract(subtract.560, divide.562)
  multiply.564 = f32[128,128]{1,0} multiply(multiply.536, broadcast.471)
  constant.466 = f32[] constant(12)
  broadcast.467 = f32[128,128]{1,0} broadcast(constant.466), dimensions={}
  divide.565 = f32[128,128]{1,0} divide(multiply.564, broadcast.467)
  add.566 = f32[128,128]{1,0} add(subtract.563, divide.565)
  divide.567 = f32[128,128]{1,0} divide(multiply.537, broadcast.469)
  add.568 = f32[128,128]{1,0} add(add.566, divide.567)
  divide.569 = f32[128,128]{1,0} divide(multiply.538, broadcast.467)
  subtract.570 = f32[128,128]{1,0} subtract(add.568, divide.569)
  slice.604 = f32[128,128,1]{2,1,0} slice(reshape.534), slice={[0:128], [0:128], [2:3]}
  reshape.605 = f32[128,128]{1,0} reshape(slice.604)
  multiply.606 = f32[128,128]{1,0} multiply(subtract.570, reshape.605)
  add.607 = f32[128,128]{1,0} add(add.603, multiply.606)
  multiply.571 = f32[128,128]{1,0} multiply(multiply.535, broadcast.479)
  divide.572 = f32[128,128]{1,0} divide(multiply.571, broadcast.477)
  add.573 = f32[128,128]{1,0} add(subtract.508, divide.572)
  constant.464 = f32[] constant(7)
  broadcast.465 = f32[128,128]{1,0} broadcast(constant.464), dimensions={}
  multiply.574 = f32[128,128]{1,0} multiply(multiply.536, broadcast.465)
  divide.575 = f32[128,128]{1,0} divide(multiply.574, broadcast.467)
  subtract.576 = f32[128,128]{1,0} subtract(add.573, divide.575)
  divide.577 = f32[128,128]{1,0} divide(multiply.537, broadcast.475)
  subtract.578 = f32[128,128]{1,0} subtract(subtract.576, divide.577)
  divide.579 = f32[128,128]{1,0} divide(multiply.538, broadcast.467)
  add.580 = f32[128,128]{1,0} add(subtract.578, divide.579)
  slice.608 = f32[128,128,1]{2,1,0} slice(reshape.534), slice={[0:128], [0:128], [3:4]}
  reshape.609 = f32[128,128]{1,0} reshape(slice.608)
  multiply.610 = f32[128,128]{1,0} multiply(add.580, reshape.609)
  add.611 = f32[128,128]{1,0} add(add.607, multiply.610)
  divide.581 = f32[128,128]{1,0} divide(subtract.508, broadcast.469)
  negate.582 = f32[128,128]{1,0} negate(divide.581)
  divide.583 = f32[128,128]{1,0} divide(multiply.535, broadcast.483)
  subtract.584 = f32[128,128]{1,0} subtract(negate.582, divide.583)
  multiply.585 = f32[128,128]{1,0} multiply(multiply.536, broadcast.465)
  divide.586 = f32[128,128]{1,0} divide(multiply.585, broadcast.483)
  add.587 = f32[128,128]{1,0} add(subtract.584, divide.586)
  divide.588 = f32[128,128]{1,0} divide(multiply.537, broadcast.483)
  add.589 = f32[128,128]{1,0} add(add.587, divide.588)
  divide.590 = f32[128,128]{1,0} divide(multiply.538, broadcast.483)
  subtract.591 = f32[128,128]{1,0} subtract(add.589, divide.590)
  slice.612 = f32[128,128,1]{2,1,0} slice(reshape.534), slice={[0:128], [0:128], [4:5]}
  reshape.613 = f32[128,128]{1,0} reshape(slice.612)
  multiply.614 = f32[128,128]{1,0} multiply(subtract.591, reshape.613)
  add.615 = f32[128,128]{1,0} add(add.611, multiply.614)
  constant.462 = f32[] constant(30)
  broadcast.463 = f32[128,128]{1,0} broadcast(constant.462), dimensions={}
  divide.592 = f32[128,128]{1,0} divide(subtract.508, broadcast.463)
  divide.593 = f32[128,128]{1,0} divide(multiply.536, broadcast.483)
  subtract.594 = f32[128,128]{1,0} subtract(divide.592, divide.593)
  divide.595 = f32[128,128]{1,0} divide(multiply.538, broadcast.481)
  add.596 = f32[128,128]{1,0} add(subtract.594, divide.595)
  slice.616 = f32[128,128,1]{2,1,0} slice(reshape.534), slice={[0:128], [0:128], [5:6]}
  reshape.617 = f32[128,128]{1,0} reshape(slice.616)
  multiply.618 = f32[128,128]{1,0} multiply(add.596, reshape.617)
  ROOT add.619 = f32[128,128]{1,0} add(add.615, multiply.618)
}

ENTRY main.623 {
  Arg_0.1 = f32[128,128]{1,0} parameter(0)
  transpose.9 = f32[128,128]{0,1} transpose(Arg_0.1), dimensions={1,0}
  constant.6 = f32[128]{0} constant({...})
  constant.5 = f32[] constant(0.025)
  constant.4 = f32[] constant(0.0981747732)
  constant.7 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  call.199 = f32[128,128]{1,0} call(transpose.9, constant.6, constant.5, constant.4, constant.7), to_apply=advect_1d_vectorized.35
  transpose.200 = f32[128,128]{0,1} transpose(call.199), dimensions={1,0}
  constant.8 = f32[65]{0} constant({...})
  constant.3 = f32[] constant(0.0787401572)
  call.237 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) call(transpose.200, constant.8, constant.3), to_apply=solve_poisson.214
  get-tuple-element.238 = f32[128]{0} get-tuple-element(call.237), index=0
  constant.2 = f32[] constant(0.05)
  call.429 = f32[128,128]{1,0} call(transpose.200, get-tuple-element.238, constant.2, constant.3, constant.7), to_apply=advect_1d_vectorized_1.255
  transpose.430 = f32[128,128]{0,1} transpose(call.429), dimensions={1,0}
  call.620 = f32[128,128]{1,0} call(transpose.430, constant.6, constant.5, constant.4, constant.7), to_apply=advect_1d_vectorized.456
  transpose.621 = f32[128,128]{0,1} transpose(call.620), dimensions={1,0}
  get-tuple-element.239 = f32[128]{0} get-tuple-element(call.237), index=1
  get-tuple-element.240 = f32[128]{0} get-tuple-element(call.237), index=2
  ROOT tuple.622 = (f32[128,128]{0,1}, f32[128]{0}, f32[128]{0}) tuple(transpose.621, get-tuple-element.239, get-tuple-element.240)
}

