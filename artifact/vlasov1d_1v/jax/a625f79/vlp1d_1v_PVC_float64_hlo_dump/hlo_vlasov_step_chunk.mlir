HloModule jit_run_chunk, entry_computation_layout={(f64[128]{0}, f64[128]{0}, f64[65]{0}, s32[6]{0}, f64[128]{0}, /*index=5*/f64[128]{0}, f64[128,128]{1,0}, f64[128]{0}, f64[], s64[])->(f64[128]{0}, f64[128]{0}, f64[65]{0}, s32[6]{0}, f64[128]{0}, /*index=5*/f64[128]{0}, f64[128,128]{1,0}, f64[128]{0}, f64[], s64[])}

_where.15 {
  Arg_0.16 = pred[] parameter(0)
  Arg_1.17 = s32[] parameter(1)
  Arg_2.18 = s32[] parameter(2)
  ROOT select.19 = s32[] select(Arg_0.16, Arg_1.17, Arg_2.18)
}

remainder.20 {
  Arg_0.21 = s32[128,128,6]{2,1,0} parameter(0)
  Arg_1.22 = s64[] parameter(1)
  convert.27 = s32[] convert(Arg_1.22)
  constant.26 = s32[] constant(0)
  compare.28 = pred[] compare(convert.27, constant.26), direction=EQ
  constant.25 = s32[] constant(1)
  call.29 = s32[] call(compare.28, constant.25, convert.27), to_apply=_where.15
  broadcast.30 = s32[128,128,6]{2,1,0} broadcast(call.29), dimensions={}
  remainder.31 = s32[128,128,6]{2,1,0} remainder(Arg_0.21, broadcast.30)
  constant.23 = s32[] constant(0)
  broadcast.24 = s32[128,128,6]{2,1,0} broadcast(constant.23), dimensions={}
  compare.33 = pred[128,128,6]{2,1,0} compare(remainder.31, broadcast.24), direction=LT
  compare.34 = pred[] compare(call.29, constant.26), direction=LT
  broadcast.35 = pred[128,128,6]{2,1,0} broadcast(compare.34), dimensions={}
  compare.36 = pred[128,128,6]{2,1,0} compare(compare.33, broadcast.35), direction=NE
  compare.32 = pred[128,128,6]{2,1,0} compare(remainder.31, broadcast.24), direction=NE
  and.37 = pred[128,128,6]{2,1,0} and(compare.36, compare.32)
  broadcast.38 = s32[128,128,6]{2,1,0} broadcast(call.29), dimensions={}
  add.39 = s32[128,128,6]{2,1,0} add(remainder.31, broadcast.38)
  ROOT select.40 = s32[128,128,6]{2,1,0} select(and.37, add.39, remainder.31)
}

advect_1d_vectorized.41 {
  iota.78 = f64[128]{0} iota(), iota_dimension=0
  reshape.84 = f64[1,128]{1,0} reshape(iota.78)
  broadcast.85 = f64[1,128]{1,0} broadcast(reshape.84), dimensions={0,1}
  reshape.86 = f64[128]{0} reshape(broadcast.85)
  broadcast.87 = f64[128,128]{1,0} broadcast(reshape.86), dimensions={1}
  Arg_1.43 = f64[128]{0} parameter(1)
  reshape.79 = f64[128,1]{1,0} reshape(Arg_1.43)
  Arg_2.44 = f64[] parameter(2)
  broadcast.80 = f64[128,1]{1,0} broadcast(Arg_2.44), dimensions={}
  multiply.81 = f64[128,1]{1,0} multiply(reshape.79, broadcast.80)
  Arg_3.45 = f64[] parameter(3)
  broadcast.82 = f64[128,1]{1,0} broadcast(Arg_3.45), dimensions={}
  divide.83 = f64[128,1]{1,0} divide(multiply.81, broadcast.82)
  broadcast.88 = f64[128,1]{1,0} broadcast(divide.83), dimensions={0,1}
  reshape.89 = f64[128]{0} reshape(broadcast.88)
  broadcast.90 = f64[128,128]{1,0} broadcast(reshape.89), dimensions={0}
  subtract.91 = f64[128,128]{1,0} subtract(broadcast.87, broadcast.90)
  floor.92 = f64[128,128]{1,0} floor(subtract.91)
  subtract.93 = f64[128,128]{1,0} subtract(subtract.91, floor.92)
  constant.69 = f64[] constant(20)
  broadcast.70 = f64[128,128]{1,0} broadcast(constant.69), dimensions={}
  divide.126 = f64[128,128]{1,0} divide(subtract.93, broadcast.70)
  multiply.122 = f64[128,128]{1,0} multiply(subtract.93, subtract.93)
  constant.67 = f64[] constant(24)
  broadcast.68 = f64[128,128]{1,0} broadcast(constant.67), dimensions={}
  divide.127 = f64[128,128]{1,0} divide(multiply.122, broadcast.68)
  subtract.128 = f64[128,128]{1,0} subtract(divide.126, divide.127)
  multiply.123 = f64[128,128]{1,0} multiply(multiply.122, subtract.93)
  divide.129 = f64[128,128]{1,0} divide(multiply.123, broadcast.68)
  subtract.130 = f64[128,128]{1,0} subtract(subtract.128, divide.129)
  multiply.124 = f64[128,128]{1,0} multiply(multiply.123, subtract.93)
  divide.131 = f64[128,128]{1,0} divide(multiply.124, broadcast.68)
  add.132 = f64[128,128]{1,0} add(subtract.130, divide.131)
  multiply.125 = f64[128,128]{1,0} multiply(multiply.124, subtract.93)
  constant.65 = f64[] constant(120)
  broadcast.66 = f64[128,128]{1,0} broadcast(constant.65), dimensions={}
  divide.133 = f64[128,128]{1,0} divide(multiply.125, broadcast.66)
  subtract.134 = f64[128,128]{1,0} subtract(add.132, divide.133)
  Arg_0.42 = f64[128,128]{1,0} parameter(0)
  reshape.113 = f64[16384]{0} reshape(Arg_0.42)
  iota.105 = s64[128]{0} iota(), iota_dimension=0
  reshape.106 = s64[128,1,1]{2,1,0} reshape(iota.105)
  constant.75 = s64[] constant(128)
  broadcast.76 = s64[128,1,1]{2,1,0} broadcast(constant.75), dimensions={}
  multiply.107 = s64[128,1,1]{2,1,0} multiply(reshape.106, broadcast.76)
  broadcast.109 = s64[128,1,1]{2,1,0} broadcast(multiply.107), dimensions={0,1,2}
  reshape.110 = s64[128]{0} reshape(broadcast.109)
  broadcast.111 = s64[128,128,6]{2,1,0} broadcast(reshape.110), dimensions={0}
  convert.94 = s32[128,128]{1,0} convert(floor.92)
  reshape.95 = s32[128,128,1]{2,1,0} reshape(convert.94)
  broadcast.97 = s32[128,128,1]{2,1,0} broadcast(reshape.95), dimensions={0,1,2}
  reshape.98 = s32[128,128]{1,0} reshape(broadcast.97)
  broadcast.99 = s32[128,128,6]{2,1,0} broadcast(reshape.98), dimensions={0,1}
  Arg_4.46 = s32[6]{0} parameter(4)
  reshape.96 = s32[1,1,6]{2,1,0} reshape(Arg_4.46)
  broadcast.100 = s32[1,1,6]{2,1,0} broadcast(reshape.96), dimensions={0,1,2}
  reshape.101 = s32[6]{0} reshape(broadcast.100)
  broadcast.102 = s32[128,128,6]{2,1,0} broadcast(reshape.101), dimensions={2}
  add.103 = s32[128,128,6]{2,1,0} add(broadcast.99, broadcast.102)
  constant.77 = s64[] constant(128)
  call.104 = s32[128,128,6]{2,1,0} call(add.103, constant.77), to_apply=remainder.20
  convert.108 = s64[128,128,6]{2,1,0} convert(call.104)
  add.112 = s64[128,128,6]{2,1,0} add(broadcast.111, convert.108)
  reshape.114 = s64[98304]{0} reshape(add.112)
  constant.73 = s64[] constant(0)
  broadcast.74 = s64[98304]{0} broadcast(constant.73), dimensions={}
  compare.115 = pred[98304]{0} compare(reshape.114, broadcast.74), direction=LT
  constant.71 = s64[] constant(16384)
  broadcast.72 = s64[98304]{0} broadcast(constant.71), dimensions={}
  add.116 = s64[98304]{0} add(reshape.114, broadcast.72)
  select.117 = s64[98304]{0} select(compare.115, add.116, reshape.114)
  convert.118 = s32[98304]{0} convert(select.117)
  reshape.119 = s32[98304,1]{1,0} reshape(convert.118)
  gather.120 = f64[98304]{0} gather(reshape.113, reshape.119), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.121 = f64[128,128,6]{2,1,0} reshape(gather.120)
  slice.184 = f64[128,128,1]{2,1,0} slice(reshape.121), slice={[0:128], [0:128], [0:1]}
  reshape.185 = f64[128,128]{1,0} reshape(slice.184)
  multiply.186 = f64[128,128]{1,0} multiply(subtract.134, reshape.185)
  constant.63 = f64[] constant(2)
  broadcast.64 = f64[128,128]{1,0} broadcast(constant.63), dimensions={}
  divide.135 = f64[128,128]{1,0} divide(subtract.93, broadcast.64)
  negate.136 = f64[128,128]{1,0} negate(divide.135)
  multiply.137 = f64[128,128]{1,0} multiply(multiply.122, broadcast.64)
  constant.61 = f64[] constant(3)
  broadcast.62 = f64[128,128]{1,0} broadcast(constant.61), dimensions={}
  divide.138 = f64[128,128]{1,0} divide(multiply.137, broadcast.62)
  add.139 = f64[128,128]{1,0} add(negate.136, divide.138)
  divide.140 = f64[128,128]{1,0} divide(multiply.123, broadcast.68)
  subtract.141 = f64[128,128]{1,0} subtract(add.139, divide.140)
  constant.59 = f64[] constant(6)
  broadcast.60 = f64[128,128]{1,0} broadcast(constant.59), dimensions={}
  divide.142 = f64[128,128]{1,0} divide(multiply.124, broadcast.60)
  subtract.143 = f64[128,128]{1,0} subtract(subtract.141, divide.142)
  divide.144 = f64[128,128]{1,0} divide(multiply.125, broadcast.68)
  add.145 = f64[128,128]{1,0} add(subtract.143, divide.144)
  slice.187 = f64[128,128,1]{2,1,0} slice(reshape.121), slice={[0:128], [0:128], [1:2]}
  reshape.188 = f64[128,128]{1,0} reshape(slice.187)
  multiply.189 = f64[128,128]{1,0} multiply(add.145, reshape.188)
  add.190 = f64[128,128]{1,0} add(multiply.186, multiply.189)
  constant.57 = f64[] constant(1)
  broadcast.58 = f64[128,128]{1,0} broadcast(constant.57), dimensions={}
  divide.146 = f64[128,128]{1,0} divide(subtract.93, broadcast.62)
  subtract.147 = f64[128,128]{1,0} subtract(broadcast.58, divide.146)
  constant.55 = f64[] constant(5)
  broadcast.56 = f64[128,128]{1,0} broadcast(constant.55), dimensions={}
  multiply.148 = f64[128,128]{1,0} multiply(multiply.122, broadcast.56)
  constant.53 = f64[] constant(4)
  broadcast.54 = f64[128,128]{1,0} broadcast(constant.53), dimensions={}
  divide.149 = f64[128,128]{1,0} divide(multiply.148, broadcast.54)
  subtract.150 = f64[128,128]{1,0} subtract(subtract.147, divide.149)
  multiply.151 = f64[128,128]{1,0} multiply(multiply.123, broadcast.56)
  constant.51 = f64[] constant(12)
  broadcast.52 = f64[128,128]{1,0} broadcast(constant.51), dimensions={}
  divide.152 = f64[128,128]{1,0} divide(multiply.151, broadcast.52)
  add.153 = f64[128,128]{1,0} add(subtract.150, divide.152)
  divide.154 = f64[128,128]{1,0} divide(multiply.124, broadcast.54)
  add.155 = f64[128,128]{1,0} add(add.153, divide.154)
  divide.156 = f64[128,128]{1,0} divide(multiply.125, broadcast.52)
  subtract.157 = f64[128,128]{1,0} subtract(add.155, divide.156)
  slice.191 = f64[128,128,1]{2,1,0} slice(reshape.121), slice={[0:128], [0:128], [2:3]}
  reshape.192 = f64[128,128]{1,0} reshape(slice.191)
  multiply.193 = f64[128,128]{1,0} multiply(subtract.157, reshape.192)
  add.194 = f64[128,128]{1,0} add(add.190, multiply.193)
  multiply.158 = f64[128,128]{1,0} multiply(multiply.122, broadcast.64)
  divide.159 = f64[128,128]{1,0} divide(multiply.158, broadcast.62)
  add.160 = f64[128,128]{1,0} add(subtract.93, divide.159)
  constant.49 = f64[] constant(7)
  broadcast.50 = f64[128,128]{1,0} broadcast(constant.49), dimensions={}
  multiply.161 = f64[128,128]{1,0} multiply(multiply.123, broadcast.50)
  divide.162 = f64[128,128]{1,0} divide(multiply.161, broadcast.52)
  subtract.163 = f64[128,128]{1,0} subtract(add.160, divide.162)
  divide.164 = f64[128,128]{1,0} divide(multiply.124, broadcast.60)
  subtract.165 = f64[128,128]{1,0} subtract(subtract.163, divide.164)
  divide.166 = f64[128,128]{1,0} divide(multiply.125, broadcast.52)
  add.167 = f64[128,128]{1,0} add(subtract.165, divide.166)
  slice.195 = f64[128,128,1]{2,1,0} slice(reshape.121), slice={[0:128], [0:128], [3:4]}
  reshape.196 = f64[128,128]{1,0} reshape(slice.195)
  multiply.197 = f64[128,128]{1,0} multiply(add.167, reshape.196)
  add.198 = f64[128,128]{1,0} add(add.194, multiply.197)
  divide.168 = f64[128,128]{1,0} divide(subtract.93, broadcast.54)
  negate.169 = f64[128,128]{1,0} negate(divide.168)
  divide.170 = f64[128,128]{1,0} divide(multiply.122, broadcast.68)
  subtract.171 = f64[128,128]{1,0} subtract(negate.169, divide.170)
  multiply.172 = f64[128,128]{1,0} multiply(multiply.123, broadcast.50)
  divide.173 = f64[128,128]{1,0} divide(multiply.172, broadcast.68)
  add.174 = f64[128,128]{1,0} add(subtract.171, divide.173)
  divide.175 = f64[128,128]{1,0} divide(multiply.124, broadcast.68)
  add.176 = f64[128,128]{1,0} add(add.174, divide.175)
  divide.177 = f64[128,128]{1,0} divide(multiply.125, broadcast.68)
  subtract.178 = f64[128,128]{1,0} subtract(add.176, divide.177)
  slice.199 = f64[128,128,1]{2,1,0} slice(reshape.121), slice={[0:128], [0:128], [4:5]}
  reshape.200 = f64[128,128]{1,0} reshape(slice.199)
  multiply.201 = f64[128,128]{1,0} multiply(subtract.178, reshape.200)
  add.202 = f64[128,128]{1,0} add(add.198, multiply.201)
  constant.47 = f64[] constant(30)
  broadcast.48 = f64[128,128]{1,0} broadcast(constant.47), dimensions={}
  divide.179 = f64[128,128]{1,0} divide(subtract.93, broadcast.48)
  divide.180 = f64[128,128]{1,0} divide(multiply.123, broadcast.68)
  subtract.181 = f64[128,128]{1,0} subtract(divide.179, divide.180)
  divide.182 = f64[128,128]{1,0} divide(multiply.125, broadcast.66)
  add.183 = f64[128,128]{1,0} add(subtract.181, divide.182)
  slice.203 = f64[128,128,1]{2,1,0} slice(reshape.121), slice={[0:128], [0:128], [5:6]}
  reshape.204 = f64[128,128]{1,0} reshape(slice.203)
  multiply.205 = f64[128,128]{1,0} multiply(add.183, reshape.204)
  ROOT add.206 = f64[128,128]{1,0} add(add.202, multiply.205)
}

region_1.207 {
  Arg_0.208 = f64[] parameter(0)
  Arg_1.209 = f64[] parameter(1)
  ROOT add.210 = f64[] add(Arg_0.208, Arg_1.209)
}

fft.211 {
  Arg_0.212 = f64[128]{0} parameter(0)
  ROOT fft.213 = c128[65]{0} fft(Arg_0.212), fft_type=RFFT, fft_length={128}
}

fft_0.214 {
  Arg_0.215 = c128[65]{0} parameter(0)
  ROOT fft.216 = f64[128]{0} fft(Arg_0.215), fft_type=IRFFT, fft_length={128}
}

fft_0.217 {
  Arg_0.218 = c128[65]{0} parameter(0)
  ROOT fft.219 = f64[128]{0} fft(Arg_0.218), fft_type=IRFFT, fft_length={128}
}

solve_poisson.220 {
  Arg_0.221 = f64[128,128]{1,0} parameter(0)
  constant.228 = f64[] constant(0)
  reduce.229 = f64[128]{0} reduce(Arg_0.221, constant.228), dimensions={1}, to_apply=region_1.207
  Arg_2.223 = f64[] parameter(2)
  broadcast.230 = f64[128]{0} broadcast(Arg_2.223), dimensions={}
  multiply.231 = f64[128]{0} multiply(reduce.229, broadcast.230)
  constant.226 = f64[] constant(1)
  broadcast.227 = f64[128]{0} broadcast(constant.226), dimensions={}
  subtract.232 = f64[128]{0} subtract(multiply.231, broadcast.227)
  call.233 = c128[65]{0} call(subtract.232), to_apply=fft.211
  constant.224 = c128[] constant((-0, -1))
  broadcast.225 = c128[65]{0} broadcast(constant.224), dimensions={}
  multiply.234 = c128[65]{0} multiply(call.233, broadcast.225)
  Arg_1.222 = f64[65]{0} parameter(1)
  convert.235 = c128[65]{0} convert(Arg_1.222)
  multiply.236 = c128[65]{0} multiply(multiply.234, convert.235)
  call.237 = f64[128]{0} call(multiply.236), to_apply=fft_0.214
  multiply.238 = f64[65]{0} multiply(Arg_1.222, Arg_1.222)
  convert.239 = c128[65]{0} convert(multiply.238)
  multiply.240 = c128[65]{0} multiply(call.233, convert.239)
  call.241 = f64[128]{0} call(multiply.240), to_apply=fft_0.217
  ROOT tuple.242 = (f64[128]{0}, f64[128]{0}, f64[128]{0}) tuple(call.237, subtract.232, call.241)
}

clip.243 {
  Arg_2.246 = s64[] parameter(2)
  convert.250 = s32[] convert(Arg_2.246)
  broadcast.251 = s32[128,128,6]{2,1,0} broadcast(convert.250), dimensions={}
  Arg_1.245 = s64[] parameter(1)
  convert.247 = s32[] convert(Arg_1.245)
  broadcast.248 = s32[128,128,6]{2,1,0} broadcast(convert.247), dimensions={}
  Arg_0.244 = s32[128,128,6]{2,1,0} parameter(0)
  maximum.249 = s32[128,128,6]{2,1,0} maximum(broadcast.248, Arg_0.244)
  ROOT minimum.252 = s32[128,128,6]{2,1,0} minimum(broadcast.251, maximum.249)
}

_where_2.253 {
  Arg_0.254 = pred[128,128,6]{2,1,0} parameter(0)
  Arg_1.255 = f64[128,128,6]{2,1,0} parameter(1)
  Arg_2.256 = f64[] parameter(2)
  broadcast.257 = f64[128,128,6]{2,1,0} broadcast(Arg_2.256), dimensions={}
  ROOT select.258 = f64[128,128,6]{2,1,0} select(Arg_0.254, Arg_1.255, broadcast.257)
}

advect_1d_vectorized_1.259 {
  iota.302 = f64[128]{0} iota(), iota_dimension=0
  reshape.308 = f64[1,128]{1,0} reshape(iota.302)
  broadcast.309 = f64[1,128]{1,0} broadcast(reshape.308), dimensions={0,1}
  reshape.310 = f64[128]{0} reshape(broadcast.309)
  broadcast.311 = f64[128,128]{1,0} broadcast(reshape.310), dimensions={1}
  Arg_1.261 = f64[128]{0} parameter(1)
  reshape.303 = f64[128,1]{1,0} reshape(Arg_1.261)
  Arg_2.262 = f64[] parameter(2)
  broadcast.304 = f64[128,1]{1,0} broadcast(Arg_2.262), dimensions={}
  multiply.305 = f64[128,1]{1,0} multiply(reshape.303, broadcast.304)
  Arg_3.263 = f64[] parameter(3)
  broadcast.306 = f64[128,1]{1,0} broadcast(Arg_3.263), dimensions={}
  divide.307 = f64[128,1]{1,0} divide(multiply.305, broadcast.306)
  broadcast.312 = f64[128,1]{1,0} broadcast(divide.307), dimensions={0,1}
  reshape.313 = f64[128]{0} reshape(broadcast.312)
  broadcast.314 = f64[128,128]{1,0} broadcast(reshape.313), dimensions={0}
  subtract.315 = f64[128,128]{1,0} subtract(broadcast.311, broadcast.314)
  floor.316 = f64[128,128]{1,0} floor(subtract.315)
  subtract.317 = f64[128,128]{1,0} subtract(subtract.315, floor.316)
  constant.287 = f64[] constant(20)
  broadcast.288 = f64[128,128]{1,0} broadcast(constant.287), dimensions={}
  divide.354 = f64[128,128]{1,0} divide(subtract.317, broadcast.288)
  multiply.350 = f64[128,128]{1,0} multiply(subtract.317, subtract.317)
  constant.285 = f64[] constant(24)
  broadcast.286 = f64[128,128]{1,0} broadcast(constant.285), dimensions={}
  divide.355 = f64[128,128]{1,0} divide(multiply.350, broadcast.286)
  subtract.356 = f64[128,128]{1,0} subtract(divide.354, divide.355)
  multiply.351 = f64[128,128]{1,0} multiply(multiply.350, subtract.317)
  divide.357 = f64[128,128]{1,0} divide(multiply.351, broadcast.286)
  subtract.358 = f64[128,128]{1,0} subtract(subtract.356, divide.357)
  multiply.352 = f64[128,128]{1,0} multiply(multiply.351, subtract.317)
  divide.359 = f64[128,128]{1,0} divide(multiply.352, broadcast.286)
  add.360 = f64[128,128]{1,0} add(subtract.358, divide.359)
  multiply.353 = f64[128,128]{1,0} multiply(multiply.352, subtract.317)
  constant.283 = f64[] constant(120)
  broadcast.284 = f64[128,128]{1,0} broadcast(constant.283), dimensions={}
  divide.361 = f64[128,128]{1,0} divide(multiply.353, broadcast.284)
  subtract.362 = f64[128,128]{1,0} subtract(add.360, divide.361)
  convert.318 = s32[128,128]{1,0} convert(floor.316)
  reshape.319 = s32[128,128,1]{2,1,0} reshape(convert.318)
  broadcast.321 = s32[128,128,1]{2,1,0} broadcast(reshape.319), dimensions={0,1,2}
  reshape.322 = s32[128,128]{1,0} reshape(broadcast.321)
  broadcast.323 = s32[128,128,6]{2,1,0} broadcast(reshape.322), dimensions={0,1}
  Arg_4.264 = s32[6]{0} parameter(4)
  reshape.320 = s32[1,1,6]{2,1,0} reshape(Arg_4.264)
  broadcast.324 = s32[1,1,6]{2,1,0} broadcast(reshape.320), dimensions={0,1,2}
  reshape.325 = s32[6]{0} reshape(broadcast.324)
  broadcast.326 = s32[128,128,6]{2,1,0} broadcast(reshape.325), dimensions={2}
  add.327 = s32[128,128,6]{2,1,0} add(broadcast.323, broadcast.326)
  constant.297 = s32[] constant(0)
  broadcast.298 = s32[128,128,6]{2,1,0} broadcast(constant.297), dimensions={}
  compare.328 = pred[128,128,6]{2,1,0} compare(add.327, broadcast.298), direction=GE
  constant.295 = s32[] constant(128)
  broadcast.296 = s32[128,128,6]{2,1,0} broadcast(constant.295), dimensions={}
  compare.329 = pred[128,128,6]{2,1,0} compare(add.327, broadcast.296), direction=LT
  and.330 = pred[128,128,6]{2,1,0} and(compare.328, compare.329)
  Arg_0.260 = f64[128,128]{1,0} parameter(0)
  reshape.340 = f64[16384]{0} reshape(Arg_0.260)
  iota.332 = s64[128]{0} iota(), iota_dimension=0
  reshape.333 = s64[128,1,1]{2,1,0} reshape(iota.332)
  constant.293 = s64[] constant(128)
  broadcast.294 = s64[128,1,1]{2,1,0} broadcast(constant.293), dimensions={}
  multiply.334 = s64[128,1,1]{2,1,0} multiply(reshape.333, broadcast.294)
  broadcast.336 = s64[128,1,1]{2,1,0} broadcast(multiply.334), dimensions={0,1,2}
  reshape.337 = s64[128]{0} reshape(broadcast.336)
  broadcast.338 = s64[128,128,6]{2,1,0} broadcast(reshape.337), dimensions={0}
  constant.301 = s64[] constant(0)
  constant.300 = s64[] constant(127)
  call.331 = s32[128,128,6]{2,1,0} call(add.327, constant.301, constant.300), to_apply=clip.243
  convert.335 = s64[128,128,6]{2,1,0} convert(call.331)
  add.339 = s64[128,128,6]{2,1,0} add(broadcast.338, convert.335)
  reshape.341 = s64[98304]{0} reshape(add.339)
  constant.291 = s64[] constant(0)
  broadcast.292 = s64[98304]{0} broadcast(constant.291), dimensions={}
  compare.342 = pred[98304]{0} compare(reshape.341, broadcast.292), direction=LT
  constant.289 = s64[] constant(16384)
  broadcast.290 = s64[98304]{0} broadcast(constant.289), dimensions={}
  add.343 = s64[98304]{0} add(reshape.341, broadcast.290)
  select.344 = s64[98304]{0} select(compare.342, add.343, reshape.341)
  convert.345 = s32[98304]{0} convert(select.344)
  reshape.346 = s32[98304,1]{1,0} reshape(convert.345)
  gather.347 = f64[98304]{0} gather(reshape.340, reshape.346), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.348 = f64[128,128,6]{2,1,0} reshape(gather.347)
  constant.299 = f64[] constant(0)
  call.349 = f64[128,128,6]{2,1,0} call(and.330, reshape.348, constant.299), to_apply=_where_2.253
  slice.412 = f64[128,128,1]{2,1,0} slice(call.349), slice={[0:128], [0:128], [0:1]}
  reshape.413 = f64[128,128]{1,0} reshape(slice.412)
  multiply.414 = f64[128,128]{1,0} multiply(subtract.362, reshape.413)
  constant.281 = f64[] constant(2)
  broadcast.282 = f64[128,128]{1,0} broadcast(constant.281), dimensions={}
  divide.363 = f64[128,128]{1,0} divide(subtract.317, broadcast.282)
  negate.364 = f64[128,128]{1,0} negate(divide.363)
  multiply.365 = f64[128,128]{1,0} multiply(multiply.350, broadcast.282)
  constant.279 = f64[] constant(3)
  broadcast.280 = f64[128,128]{1,0} broadcast(constant.279), dimensions={}
  divide.366 = f64[128,128]{1,0} divide(multiply.365, broadcast.280)
  add.367 = f64[128,128]{1,0} add(negate.364, divide.366)
  divide.368 = f64[128,128]{1,0} divide(multiply.351, broadcast.286)
  subtract.369 = f64[128,128]{1,0} subtract(add.367, divide.368)
  constant.277 = f64[] constant(6)
  broadcast.278 = f64[128,128]{1,0} broadcast(constant.277), dimensions={}
  divide.370 = f64[128,128]{1,0} divide(multiply.352, broadcast.278)
  subtract.371 = f64[128,128]{1,0} subtract(subtract.369, divide.370)
  divide.372 = f64[128,128]{1,0} divide(multiply.353, broadcast.286)
  add.373 = f64[128,128]{1,0} add(subtract.371, divide.372)
  slice.415 = f64[128,128,1]{2,1,0} slice(call.349), slice={[0:128], [0:128], [1:2]}
  reshape.416 = f64[128,128]{1,0} reshape(slice.415)
  multiply.417 = f64[128,128]{1,0} multiply(add.373, reshape.416)
  add.418 = f64[128,128]{1,0} add(multiply.414, multiply.417)
  constant.275 = f64[] constant(1)
  broadcast.276 = f64[128,128]{1,0} broadcast(constant.275), dimensions={}
  divide.374 = f64[128,128]{1,0} divide(subtract.317, broadcast.280)
  subtract.375 = f64[128,128]{1,0} subtract(broadcast.276, divide.374)
  constant.273 = f64[] constant(5)
  broadcast.274 = f64[128,128]{1,0} broadcast(constant.273), dimensions={}
  multiply.376 = f64[128,128]{1,0} multiply(multiply.350, broadcast.274)
  constant.271 = f64[] constant(4)
  broadcast.272 = f64[128,128]{1,0} broadcast(constant.271), dimensions={}
  divide.377 = f64[128,128]{1,0} divide(multiply.376, broadcast.272)
  subtract.378 = f64[128,128]{1,0} subtract(subtract.375, divide.377)
  multiply.379 = f64[128,128]{1,0} multiply(multiply.351, broadcast.274)
  constant.269 = f64[] constant(12)
  broadcast.270 = f64[128,128]{1,0} broadcast(constant.269), dimensions={}
  divide.380 = f64[128,128]{1,0} divide(multiply.379, broadcast.270)
  add.381 = f64[128,128]{1,0} add(subtract.378, divide.380)
  divide.382 = f64[128,128]{1,0} divide(multiply.352, broadcast.272)
  add.383 = f64[128,128]{1,0} add(add.381, divide.382)
  divide.384 = f64[128,128]{1,0} divide(multiply.353, broadcast.270)
  subtract.385 = f64[128,128]{1,0} subtract(add.383, divide.384)
  slice.419 = f64[128,128,1]{2,1,0} slice(call.349), slice={[0:128], [0:128], [2:3]}
  reshape.420 = f64[128,128]{1,0} reshape(slice.419)
  multiply.421 = f64[128,128]{1,0} multiply(subtract.385, reshape.420)
  add.422 = f64[128,128]{1,0} add(add.418, multiply.421)
  multiply.386 = f64[128,128]{1,0} multiply(multiply.350, broadcast.282)
  divide.387 = f64[128,128]{1,0} divide(multiply.386, broadcast.280)
  add.388 = f64[128,128]{1,0} add(subtract.317, divide.387)
  constant.267 = f64[] constant(7)
  broadcast.268 = f64[128,128]{1,0} broadcast(constant.267), dimensions={}
  multiply.389 = f64[128,128]{1,0} multiply(multiply.351, broadcast.268)
  divide.390 = f64[128,128]{1,0} divide(multiply.389, broadcast.270)
  subtract.391 = f64[128,128]{1,0} subtract(add.388, divide.390)
  divide.392 = f64[128,128]{1,0} divide(multiply.352, broadcast.278)
  subtract.393 = f64[128,128]{1,0} subtract(subtract.391, divide.392)
  divide.394 = f64[128,128]{1,0} divide(multiply.353, broadcast.270)
  add.395 = f64[128,128]{1,0} add(subtract.393, divide.394)
  slice.423 = f64[128,128,1]{2,1,0} slice(call.349), slice={[0:128], [0:128], [3:4]}
  reshape.424 = f64[128,128]{1,0} reshape(slice.423)
  multiply.425 = f64[128,128]{1,0} multiply(add.395, reshape.424)
  add.426 = f64[128,128]{1,0} add(add.422, multiply.425)
  divide.396 = f64[128,128]{1,0} divide(subtract.317, broadcast.272)
  negate.397 = f64[128,128]{1,0} negate(divide.396)
  divide.398 = f64[128,128]{1,0} divide(multiply.350, broadcast.286)
  subtract.399 = f64[128,128]{1,0} subtract(negate.397, divide.398)
  multiply.400 = f64[128,128]{1,0} multiply(multiply.351, broadcast.268)
  divide.401 = f64[128,128]{1,0} divide(multiply.400, broadcast.286)
  add.402 = f64[128,128]{1,0} add(subtract.399, divide.401)
  divide.403 = f64[128,128]{1,0} divide(multiply.352, broadcast.286)
  add.404 = f64[128,128]{1,0} add(add.402, divide.403)
  divide.405 = f64[128,128]{1,0} divide(multiply.353, broadcast.286)
  subtract.406 = f64[128,128]{1,0} subtract(add.404, divide.405)
  slice.427 = f64[128,128,1]{2,1,0} slice(call.349), slice={[0:128], [0:128], [4:5]}
  reshape.428 = f64[128,128]{1,0} reshape(slice.427)
  multiply.429 = f64[128,128]{1,0} multiply(subtract.406, reshape.428)
  add.430 = f64[128,128]{1,0} add(add.426, multiply.429)
  constant.265 = f64[] constant(30)
  broadcast.266 = f64[128,128]{1,0} broadcast(constant.265), dimensions={}
  divide.407 = f64[128,128]{1,0} divide(subtract.317, broadcast.266)
  divide.408 = f64[128,128]{1,0} divide(multiply.351, broadcast.286)
  subtract.409 = f64[128,128]{1,0} subtract(divide.407, divide.408)
  divide.410 = f64[128,128]{1,0} divide(multiply.353, broadcast.284)
  add.411 = f64[128,128]{1,0} add(subtract.409, divide.410)
  slice.431 = f64[128,128,1]{2,1,0} slice(call.349), slice={[0:128], [0:128], [5:6]}
  reshape.432 = f64[128,128]{1,0} reshape(slice.431)
  multiply.433 = f64[128,128]{1,0} multiply(add.411, reshape.432)
  ROOT add.434 = f64[128,128]{1,0} add(add.430, multiply.433)
}

_where.435 {
  Arg_0.436 = pred[] parameter(0)
  Arg_1.437 = s32[] parameter(1)
  Arg_2.438 = s32[] parameter(2)
  ROOT select.439 = s32[] select(Arg_0.436, Arg_1.437, Arg_2.438)
}

remainder.440 {
  Arg_0.441 = s32[128,128,6]{2,1,0} parameter(0)
  Arg_1.442 = s64[] parameter(1)
  convert.447 = s32[] convert(Arg_1.442)
  constant.446 = s32[] constant(0)
  compare.448 = pred[] compare(convert.447, constant.446), direction=EQ
  constant.445 = s32[] constant(1)
  call.449 = s32[] call(compare.448, constant.445, convert.447), to_apply=_where.435
  broadcast.450 = s32[128,128,6]{2,1,0} broadcast(call.449), dimensions={}
  remainder.451 = s32[128,128,6]{2,1,0} remainder(Arg_0.441, broadcast.450)
  constant.443 = s32[] constant(0)
  broadcast.444 = s32[128,128,6]{2,1,0} broadcast(constant.443), dimensions={}
  compare.453 = pred[128,128,6]{2,1,0} compare(remainder.451, broadcast.444), direction=LT
  compare.454 = pred[] compare(call.449, constant.446), direction=LT
  broadcast.455 = pred[128,128,6]{2,1,0} broadcast(compare.454), dimensions={}
  compare.456 = pred[128,128,6]{2,1,0} compare(compare.453, broadcast.455), direction=NE
  compare.452 = pred[128,128,6]{2,1,0} compare(remainder.451, broadcast.444), direction=NE
  and.457 = pred[128,128,6]{2,1,0} and(compare.456, compare.452)
  broadcast.458 = s32[128,128,6]{2,1,0} broadcast(call.449), dimensions={}
  add.459 = s32[128,128,6]{2,1,0} add(remainder.451, broadcast.458)
  ROOT select.460 = s32[128,128,6]{2,1,0} select(and.457, add.459, remainder.451)
}

advect_1d_vectorized.461 {
  iota.498 = f64[128]{0} iota(), iota_dimension=0
  reshape.504 = f64[1,128]{1,0} reshape(iota.498)
  broadcast.505 = f64[1,128]{1,0} broadcast(reshape.504), dimensions={0,1}
  reshape.506 = f64[128]{0} reshape(broadcast.505)
  broadcast.507 = f64[128,128]{1,0} broadcast(reshape.506), dimensions={1}
  Arg_1.463 = f64[128]{0} parameter(1)
  reshape.499 = f64[128,1]{1,0} reshape(Arg_1.463)
  Arg_2.464 = f64[] parameter(2)
  broadcast.500 = f64[128,1]{1,0} broadcast(Arg_2.464), dimensions={}
  multiply.501 = f64[128,1]{1,0} multiply(reshape.499, broadcast.500)
  Arg_3.465 = f64[] parameter(3)
  broadcast.502 = f64[128,1]{1,0} broadcast(Arg_3.465), dimensions={}
  divide.503 = f64[128,1]{1,0} divide(multiply.501, broadcast.502)
  broadcast.508 = f64[128,1]{1,0} broadcast(divide.503), dimensions={0,1}
  reshape.509 = f64[128]{0} reshape(broadcast.508)
  broadcast.510 = f64[128,128]{1,0} broadcast(reshape.509), dimensions={0}
  subtract.511 = f64[128,128]{1,0} subtract(broadcast.507, broadcast.510)
  floor.512 = f64[128,128]{1,0} floor(subtract.511)
  subtract.513 = f64[128,128]{1,0} subtract(subtract.511, floor.512)
  constant.489 = f64[] constant(20)
  broadcast.490 = f64[128,128]{1,0} broadcast(constant.489), dimensions={}
  divide.546 = f64[128,128]{1,0} divide(subtract.513, broadcast.490)
  multiply.542 = f64[128,128]{1,0} multiply(subtract.513, subtract.513)
  constant.487 = f64[] constant(24)
  broadcast.488 = f64[128,128]{1,0} broadcast(constant.487), dimensions={}
  divide.547 = f64[128,128]{1,0} divide(multiply.542, broadcast.488)
  subtract.548 = f64[128,128]{1,0} subtract(divide.546, divide.547)
  multiply.543 = f64[128,128]{1,0} multiply(multiply.542, subtract.513)
  divide.549 = f64[128,128]{1,0} divide(multiply.543, broadcast.488)
  subtract.550 = f64[128,128]{1,0} subtract(subtract.548, divide.549)
  multiply.544 = f64[128,128]{1,0} multiply(multiply.543, subtract.513)
  divide.551 = f64[128,128]{1,0} divide(multiply.544, broadcast.488)
  add.552 = f64[128,128]{1,0} add(subtract.550, divide.551)
  multiply.545 = f64[128,128]{1,0} multiply(multiply.544, subtract.513)
  constant.485 = f64[] constant(120)
  broadcast.486 = f64[128,128]{1,0} broadcast(constant.485), dimensions={}
  divide.553 = f64[128,128]{1,0} divide(multiply.545, broadcast.486)
  subtract.554 = f64[128,128]{1,0} subtract(add.552, divide.553)
  Arg_0.462 = f64[128,128]{1,0} parameter(0)
  reshape.533 = f64[16384]{0} reshape(Arg_0.462)
  iota.525 = s64[128]{0} iota(), iota_dimension=0
  reshape.526 = s64[128,1,1]{2,1,0} reshape(iota.525)
  constant.495 = s64[] constant(128)
  broadcast.496 = s64[128,1,1]{2,1,0} broadcast(constant.495), dimensions={}
  multiply.527 = s64[128,1,1]{2,1,0} multiply(reshape.526, broadcast.496)
  broadcast.529 = s64[128,1,1]{2,1,0} broadcast(multiply.527), dimensions={0,1,2}
  reshape.530 = s64[128]{0} reshape(broadcast.529)
  broadcast.531 = s64[128,128,6]{2,1,0} broadcast(reshape.530), dimensions={0}
  convert.514 = s32[128,128]{1,0} convert(floor.512)
  reshape.515 = s32[128,128,1]{2,1,0} reshape(convert.514)
  broadcast.517 = s32[128,128,1]{2,1,0} broadcast(reshape.515), dimensions={0,1,2}
  reshape.518 = s32[128,128]{1,0} reshape(broadcast.517)
  broadcast.519 = s32[128,128,6]{2,1,0} broadcast(reshape.518), dimensions={0,1}
  Arg_4.466 = s32[6]{0} parameter(4)
  reshape.516 = s32[1,1,6]{2,1,0} reshape(Arg_4.466)
  broadcast.520 = s32[1,1,6]{2,1,0} broadcast(reshape.516), dimensions={0,1,2}
  reshape.521 = s32[6]{0} reshape(broadcast.520)
  broadcast.522 = s32[128,128,6]{2,1,0} broadcast(reshape.521), dimensions={2}
  add.523 = s32[128,128,6]{2,1,0} add(broadcast.519, broadcast.522)
  constant.497 = s64[] constant(128)
  call.524 = s32[128,128,6]{2,1,0} call(add.523, constant.497), to_apply=remainder.440
  convert.528 = s64[128,128,6]{2,1,0} convert(call.524)
  add.532 = s64[128,128,6]{2,1,0} add(broadcast.531, convert.528)
  reshape.534 = s64[98304]{0} reshape(add.532)
  constant.493 = s64[] constant(0)
  broadcast.494 = s64[98304]{0} broadcast(constant.493), dimensions={}
  compare.535 = pred[98304]{0} compare(reshape.534, broadcast.494), direction=LT
  constant.491 = s64[] constant(16384)
  broadcast.492 = s64[98304]{0} broadcast(constant.491), dimensions={}
  add.536 = s64[98304]{0} add(reshape.534, broadcast.492)
  select.537 = s64[98304]{0} select(compare.535, add.536, reshape.534)
  convert.538 = s32[98304]{0} convert(select.537)
  reshape.539 = s32[98304,1]{1,0} reshape(convert.538)
  gather.540 = f64[98304]{0} gather(reshape.533, reshape.539), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.541 = f64[128,128,6]{2,1,0} reshape(gather.540)
  slice.604 = f64[128,128,1]{2,1,0} slice(reshape.541), slice={[0:128], [0:128], [0:1]}
  reshape.605 = f64[128,128]{1,0} reshape(slice.604)
  multiply.606 = f64[128,128]{1,0} multiply(subtract.554, reshape.605)
  constant.483 = f64[] constant(2)
  broadcast.484 = f64[128,128]{1,0} broadcast(constant.483), dimensions={}
  divide.555 = f64[128,128]{1,0} divide(subtract.513, broadcast.484)
  negate.556 = f64[128,128]{1,0} negate(divide.555)
  multiply.557 = f64[128,128]{1,0} multiply(multiply.542, broadcast.484)
  constant.481 = f64[] constant(3)
  broadcast.482 = f64[128,128]{1,0} broadcast(constant.481), dimensions={}
  divide.558 = f64[128,128]{1,0} divide(multiply.557, broadcast.482)
  add.559 = f64[128,128]{1,0} add(negate.556, divide.558)
  divide.560 = f64[128,128]{1,0} divide(multiply.543, broadcast.488)
  subtract.561 = f64[128,128]{1,0} subtract(add.559, divide.560)
  constant.479 = f64[] constant(6)
  broadcast.480 = f64[128,128]{1,0} broadcast(constant.479), dimensions={}
  divide.562 = f64[128,128]{1,0} divide(multiply.544, broadcast.480)
  subtract.563 = f64[128,128]{1,0} subtract(subtract.561, divide.562)
  divide.564 = f64[128,128]{1,0} divide(multiply.545, broadcast.488)
  add.565 = f64[128,128]{1,0} add(subtract.563, divide.564)
  slice.607 = f64[128,128,1]{2,1,0} slice(reshape.541), slice={[0:128], [0:128], [1:2]}
  reshape.608 = f64[128,128]{1,0} reshape(slice.607)
  multiply.609 = f64[128,128]{1,0} multiply(add.565, reshape.608)
  add.610 = f64[128,128]{1,0} add(multiply.606, multiply.609)
  constant.477 = f64[] constant(1)
  broadcast.478 = f64[128,128]{1,0} broadcast(constant.477), dimensions={}
  divide.566 = f64[128,128]{1,0} divide(subtract.513, broadcast.482)
  subtract.567 = f64[128,128]{1,0} subtract(broadcast.478, divide.566)
  constant.475 = f64[] constant(5)
  broadcast.476 = f64[128,128]{1,0} broadcast(constant.475), dimensions={}
  multiply.568 = f64[128,128]{1,0} multiply(multiply.542, broadcast.476)
  constant.473 = f64[] constant(4)
  broadcast.474 = f64[128,128]{1,0} broadcast(constant.473), dimensions={}
  divide.569 = f64[128,128]{1,0} divide(multiply.568, broadcast.474)
  subtract.570 = f64[128,128]{1,0} subtract(subtract.567, divide.569)
  multiply.571 = f64[128,128]{1,0} multiply(multiply.543, broadcast.476)
  constant.471 = f64[] constant(12)
  broadcast.472 = f64[128,128]{1,0} broadcast(constant.471), dimensions={}
  divide.572 = f64[128,128]{1,0} divide(multiply.571, broadcast.472)
  add.573 = f64[128,128]{1,0} add(subtract.570, divide.572)
  divide.574 = f64[128,128]{1,0} divide(multiply.544, broadcast.474)
  add.575 = f64[128,128]{1,0} add(add.573, divide.574)
  divide.576 = f64[128,128]{1,0} divide(multiply.545, broadcast.472)
  subtract.577 = f64[128,128]{1,0} subtract(add.575, divide.576)
  slice.611 = f64[128,128,1]{2,1,0} slice(reshape.541), slice={[0:128], [0:128], [2:3]}
  reshape.612 = f64[128,128]{1,0} reshape(slice.611)
  multiply.613 = f64[128,128]{1,0} multiply(subtract.577, reshape.612)
  add.614 = f64[128,128]{1,0} add(add.610, multiply.613)
  multiply.578 = f64[128,128]{1,0} multiply(multiply.542, broadcast.484)
  divide.579 = f64[128,128]{1,0} divide(multiply.578, broadcast.482)
  add.580 = f64[128,128]{1,0} add(subtract.513, divide.579)
  constant.469 = f64[] constant(7)
  broadcast.470 = f64[128,128]{1,0} broadcast(constant.469), dimensions={}
  multiply.581 = f64[128,128]{1,0} multiply(multiply.543, broadcast.470)
  divide.582 = f64[128,128]{1,0} divide(multiply.581, broadcast.472)
  subtract.583 = f64[128,128]{1,0} subtract(add.580, divide.582)
  divide.584 = f64[128,128]{1,0} divide(multiply.544, broadcast.480)
  subtract.585 = f64[128,128]{1,0} subtract(subtract.583, divide.584)
  divide.586 = f64[128,128]{1,0} divide(multiply.545, broadcast.472)
  add.587 = f64[128,128]{1,0} add(subtract.585, divide.586)
  slice.615 = f64[128,128,1]{2,1,0} slice(reshape.541), slice={[0:128], [0:128], [3:4]}
  reshape.616 = f64[128,128]{1,0} reshape(slice.615)
  multiply.617 = f64[128,128]{1,0} multiply(add.587, reshape.616)
  add.618 = f64[128,128]{1,0} add(add.614, multiply.617)
  divide.588 = f64[128,128]{1,0} divide(subtract.513, broadcast.474)
  negate.589 = f64[128,128]{1,0} negate(divide.588)
  divide.590 = f64[128,128]{1,0} divide(multiply.542, broadcast.488)
  subtract.591 = f64[128,128]{1,0} subtract(negate.589, divide.590)
  multiply.592 = f64[128,128]{1,0} multiply(multiply.543, broadcast.470)
  divide.593 = f64[128,128]{1,0} divide(multiply.592, broadcast.488)
  add.594 = f64[128,128]{1,0} add(subtract.591, divide.593)
  divide.595 = f64[128,128]{1,0} divide(multiply.544, broadcast.488)
  add.596 = f64[128,128]{1,0} add(add.594, divide.595)
  divide.597 = f64[128,128]{1,0} divide(multiply.545, broadcast.488)
  subtract.598 = f64[128,128]{1,0} subtract(add.596, divide.597)
  slice.619 = f64[128,128,1]{2,1,0} slice(reshape.541), slice={[0:128], [0:128], [4:5]}
  reshape.620 = f64[128,128]{1,0} reshape(slice.619)
  multiply.621 = f64[128,128]{1,0} multiply(subtract.598, reshape.620)
  add.622 = f64[128,128]{1,0} add(add.618, multiply.621)
  constant.467 = f64[] constant(30)
  broadcast.468 = f64[128,128]{1,0} broadcast(constant.467), dimensions={}
  divide.599 = f64[128,128]{1,0} divide(subtract.513, broadcast.468)
  divide.600 = f64[128,128]{1,0} divide(multiply.543, broadcast.488)
  subtract.601 = f64[128,128]{1,0} subtract(divide.599, divide.600)
  divide.602 = f64[128,128]{1,0} divide(multiply.545, broadcast.486)
  add.603 = f64[128,128]{1,0} add(subtract.601, divide.602)
  slice.623 = f64[128,128,1]{2,1,0} slice(reshape.541), slice={[0:128], [0:128], [5:6]}
  reshape.624 = f64[128,128]{1,0} reshape(slice.623)
  multiply.625 = f64[128,128]{1,0} multiply(add.603, reshape.624)
  ROOT add.626 = f64[128,128]{1,0} add(add.622, multiply.625)
}

None.627 {
  Arg_4.632 = f64[128]{0} parameter(4)
  Arg_5.633 = f64[128]{0} parameter(5)
  Arg_3.631 = f64[128,128]{1,0} parameter(3)
  transpose.638 = f64[128,128]{0,1} transpose(Arg_3.631), dimensions={1,0}
  Arg_0.628 = f64[128]{0} parameter(0)
  constant.637 = f64[] constant(0.025)
  constant.636 = f64[] constant(0.098174770424681035)
  Arg_1.629 = s32[6]{0} parameter(1)
  call.639 = f64[128,128]{1,0} call(transpose.638, Arg_0.628, constant.637, constant.636, Arg_1.629), to_apply=advect_1d_vectorized.41
  transpose.640 = f64[128,128]{0,1} transpose(call.639), dimensions={1,0}
  Arg_2.630 = f64[65]{0} parameter(2)
  constant.635 = f64[] constant(0.07874015748031496)
  call.641 = (f64[128]{0}, f64[128]{0}, f64[128]{0}) call(transpose.640, Arg_2.630, constant.635), to_apply=solve_poisson.220
  get-tuple-element.642 = f64[128]{0} get-tuple-element(call.641), index=0
  constant.634 = f64[] constant(0.05)
  call.645 = f64[128,128]{1,0} call(transpose.640, get-tuple-element.642, constant.634, constant.635, Arg_1.629), to_apply=advect_1d_vectorized_1.259
  transpose.646 = f64[128,128]{0,1} transpose(call.645), dimensions={1,0}
  call.647 = f64[128,128]{1,0} call(transpose.646, Arg_0.628, constant.637, constant.636, Arg_1.629), to_apply=advect_1d_vectorized.461
  transpose.648 = f64[128,128]{0,1} transpose(call.647), dimensions={1,0}
  get-tuple-element.643 = f64[128]{0} get-tuple-element(call.641), index=1
  get-tuple-element.644 = f64[128]{0} get-tuple-element(call.641), index=2
  ROOT tuple.649 = (f64[128,128]{0,1}, f64[128]{0}, f64[128]{0}) tuple(transpose.648, get-tuple-element.643, get-tuple-element.644)
}

region_0.650 {
  arg_tuple.651 = (s64[], f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) parameter(0)
  get-tuple-element.652 = s64[] get-tuple-element(arg_tuple.651), index=0
  constant.656 = s64[] constant(1)
  add.664 = s64[] add(get-tuple-element.652, constant.656)
  constant.659 = f64[128]{0} constant({...})
  constant.658 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  constant.657 = f64[65]{0} constant({...})
  get-tuple-element.653 = f64[128,128]{1,0} get-tuple-element(arg_tuple.651), index=1
  get-tuple-element.654 = f64[128]{0} get-tuple-element(arg_tuple.651), index=2
  get-tuple-element.655 = f64[128]{0} get-tuple-element(arg_tuple.651), index=3
  call.660 = (f64[128,128]{0,1}, f64[128]{0}, f64[128]{0}) call(constant.659, constant.658, constant.657, get-tuple-element.653, get-tuple-element.654, get-tuple-element.655), to_apply=None.627
  get-tuple-element.661 = f64[128,128]{0,1} get-tuple-element(call.660), index=0
  get-tuple-element.662 = f64[128]{0} get-tuple-element(call.660), index=1
  get-tuple-element.663 = f64[128]{0} get-tuple-element(call.660), index=2
  ROOT tuple.665 = (s64[], f64[128,128]{0,1}, f64[128]{0}, f64[128]{0}) tuple(add.664, get-tuple-element.661, get-tuple-element.662, get-tuple-element.663)
}

region_2.666 {
  arg_tuple.667 = (s64[], f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) parameter(0)
  get-tuple-element.669 = f64[128,128]{1,0} get-tuple-element(arg_tuple.667), index=1
  get-tuple-element.670 = f64[128]{0} get-tuple-element(arg_tuple.667), index=2
  get-tuple-element.671 = f64[128]{0} get-tuple-element(arg_tuple.667), index=3
  get-tuple-element.668 = s64[] get-tuple-element(arg_tuple.667), index=0
  constant.672 = s64[] constant(1000)
  ROOT compare.673 = pred[] compare(get-tuple-element.668, constant.672), direction=LT
}

ENTRY main.682 {
  constant.13 = s64[] constant(0)
  Arg_6.7 = f64[128,128]{1,0} parameter(6)
  Arg_4.5 = f64[128]{0} parameter(4)
  Arg_5.6 = f64[128]{0} parameter(5)
  tuple.14 = (s64[], f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) tuple(constant.13, Arg_6.7, Arg_4.5, Arg_5.6)
  while.674 = (s64[], f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) while(tuple.14), condition=region_2.666, body=region_0.650
  get-tuple-element.675 = s64[] get-tuple-element(while.674), index=0
  Arg_0.1 = f64[128]{0} parameter(0)
  Arg_1.2 = f64[128]{0} parameter(1)
  Arg_2.3 = f64[65]{0} parameter(2)
  Arg_3.4 = s32[6]{0} parameter(3)
  get-tuple-element.677 = f64[128]{0} get-tuple-element(while.674), index=2
  get-tuple-element.678 = f64[128]{0} get-tuple-element(while.674), index=3
  get-tuple-element.676 = f64[128,128]{1,0} get-tuple-element(while.674), index=1
  Arg_7.8 = f64[128]{0} parameter(7)
  Arg_8.9 = f64[] parameter(8)
  constant.11 = f64[] constant(50)
  add.679 = f64[] add(Arg_8.9, constant.11)
  Arg_9.10 = s64[] parameter(9)
  constant.12 = s64[] constant(1000)
  add.680 = s64[] add(Arg_9.10, constant.12)
  ROOT tuple.681 = (f64[128]{0}, f64[128]{0}, f64[65]{0}, s32[6]{0}, f64[128]{0}, /*index=5*/f64[128]{0}, f64[128,128]{1,0}, f64[128]{0}, f64[], s64[]) tuple(Arg_0.1, Arg_1.2, Arg_2.3, Arg_3.4, get-tuple-element.677, get-tuple-element.678, get-tuple-element.676, Arg_7.8, add.679, add.680)
}

