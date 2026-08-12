HloModule jit__lambda_, entry_computation_layout={(f64[128,128]{1,0})->(f64[128,128]{0,1}, f64[128]{0}, f64[128]{0})}

_where.10 {
  Arg_0.11 = pred[] parameter(0)
  Arg_1.12 = s32[] parameter(1)
  Arg_2.13 = s32[] parameter(2)
  ROOT select.14 = s32[] select(Arg_0.11, Arg_1.12, Arg_2.13)
}

remainder.15 {
  Arg_0.16 = s32[128,128,6]{2,1,0} parameter(0)
  Arg_1.17 = s64[] parameter(1)
  convert.22 = s32[] convert(Arg_1.17)
  constant.21 = s32[] constant(0)
  compare.23 = pred[] compare(convert.22, constant.21), direction=EQ
  constant.20 = s32[] constant(1)
  call.24 = s32[] call(compare.23, constant.20, convert.22), to_apply=_where.10
  broadcast.25 = s32[128,128,6]{2,1,0} broadcast(call.24), dimensions={}
  remainder.26 = s32[128,128,6]{2,1,0} remainder(Arg_0.16, broadcast.25)
  constant.18 = s32[] constant(0)
  broadcast.19 = s32[128,128,6]{2,1,0} broadcast(constant.18), dimensions={}
  compare.28 = pred[128,128,6]{2,1,0} compare(remainder.26, broadcast.19), direction=LT
  compare.29 = pred[] compare(call.24, constant.21), direction=LT
  broadcast.30 = pred[128,128,6]{2,1,0} broadcast(compare.29), dimensions={}
  compare.31 = pred[128,128,6]{2,1,0} compare(compare.28, broadcast.30), direction=NE
  compare.27 = pred[128,128,6]{2,1,0} compare(remainder.26, broadcast.19), direction=NE
  and.32 = pred[128,128,6]{2,1,0} and(compare.31, compare.27)
  broadcast.33 = s32[128,128,6]{2,1,0} broadcast(call.24), dimensions={}
  add.34 = s32[128,128,6]{2,1,0} add(remainder.26, broadcast.33)
  ROOT select.35 = s32[128,128,6]{2,1,0} select(and.32, add.34, remainder.26)
}

advect_1d_vectorized.36 {
  iota.73 = f64[128]{0} iota(), iota_dimension=0
  reshape.79 = f64[1,128]{1,0} reshape(iota.73)
  broadcast.80 = f64[1,128]{1,0} broadcast(reshape.79), dimensions={0,1}
  reshape.81 = f64[128]{0} reshape(broadcast.80)
  broadcast.82 = f64[128,128]{1,0} broadcast(reshape.81), dimensions={1}
  Arg_1.38 = f64[128]{0} parameter(1)
  reshape.74 = f64[128,1]{1,0} reshape(Arg_1.38)
  Arg_2.39 = f64[] parameter(2)
  broadcast.75 = f64[128,1]{1,0} broadcast(Arg_2.39), dimensions={}
  multiply.76 = f64[128,1]{1,0} multiply(reshape.74, broadcast.75)
  Arg_3.40 = f64[] parameter(3)
  broadcast.77 = f64[128,1]{1,0} broadcast(Arg_3.40), dimensions={}
  divide.78 = f64[128,1]{1,0} divide(multiply.76, broadcast.77)
  broadcast.83 = f64[128,1]{1,0} broadcast(divide.78), dimensions={0,1}
  reshape.84 = f64[128]{0} reshape(broadcast.83)
  broadcast.85 = f64[128,128]{1,0} broadcast(reshape.84), dimensions={0}
  subtract.86 = f64[128,128]{1,0} subtract(broadcast.82, broadcast.85)
  floor.87 = f64[128,128]{1,0} floor(subtract.86)
  subtract.88 = f64[128,128]{1,0} subtract(subtract.86, floor.87)
  constant.64 = f64[] constant(20)
  broadcast.65 = f64[128,128]{1,0} broadcast(constant.64), dimensions={}
  divide.121 = f64[128,128]{1,0} divide(subtract.88, broadcast.65)
  multiply.117 = f64[128,128]{1,0} multiply(subtract.88, subtract.88)
  constant.62 = f64[] constant(24)
  broadcast.63 = f64[128,128]{1,0} broadcast(constant.62), dimensions={}
  divide.122 = f64[128,128]{1,0} divide(multiply.117, broadcast.63)
  subtract.123 = f64[128,128]{1,0} subtract(divide.121, divide.122)
  multiply.118 = f64[128,128]{1,0} multiply(multiply.117, subtract.88)
  divide.124 = f64[128,128]{1,0} divide(multiply.118, broadcast.63)
  subtract.125 = f64[128,128]{1,0} subtract(subtract.123, divide.124)
  multiply.119 = f64[128,128]{1,0} multiply(multiply.118, subtract.88)
  divide.126 = f64[128,128]{1,0} divide(multiply.119, broadcast.63)
  add.127 = f64[128,128]{1,0} add(subtract.125, divide.126)
  multiply.120 = f64[128,128]{1,0} multiply(multiply.119, subtract.88)
  constant.60 = f64[] constant(120)
  broadcast.61 = f64[128,128]{1,0} broadcast(constant.60), dimensions={}
  divide.128 = f64[128,128]{1,0} divide(multiply.120, broadcast.61)
  subtract.129 = f64[128,128]{1,0} subtract(add.127, divide.128)
  Arg_0.37 = f64[128,128]{1,0} parameter(0)
  reshape.108 = f64[16384]{0} reshape(Arg_0.37)
  iota.100 = s64[128]{0} iota(), iota_dimension=0
  reshape.101 = s64[128,1,1]{2,1,0} reshape(iota.100)
  constant.70 = s64[] constant(128)
  broadcast.71 = s64[128,1,1]{2,1,0} broadcast(constant.70), dimensions={}
  multiply.102 = s64[128,1,1]{2,1,0} multiply(reshape.101, broadcast.71)
  broadcast.104 = s64[128,1,1]{2,1,0} broadcast(multiply.102), dimensions={0,1,2}
  reshape.105 = s64[128]{0} reshape(broadcast.104)
  broadcast.106 = s64[128,128,6]{2,1,0} broadcast(reshape.105), dimensions={0}
  convert.89 = s32[128,128]{1,0} convert(floor.87)
  reshape.90 = s32[128,128,1]{2,1,0} reshape(convert.89)
  broadcast.92 = s32[128,128,1]{2,1,0} broadcast(reshape.90), dimensions={0,1,2}
  reshape.93 = s32[128,128]{1,0} reshape(broadcast.92)
  broadcast.94 = s32[128,128,6]{2,1,0} broadcast(reshape.93), dimensions={0,1}
  Arg_4.41 = s32[6]{0} parameter(4)
  reshape.91 = s32[1,1,6]{2,1,0} reshape(Arg_4.41)
  broadcast.95 = s32[1,1,6]{2,1,0} broadcast(reshape.91), dimensions={0,1,2}
  reshape.96 = s32[6]{0} reshape(broadcast.95)
  broadcast.97 = s32[128,128,6]{2,1,0} broadcast(reshape.96), dimensions={2}
  add.98 = s32[128,128,6]{2,1,0} add(broadcast.94, broadcast.97)
  constant.72 = s64[] constant(128)
  call.99 = s32[128,128,6]{2,1,0} call(add.98, constant.72), to_apply=remainder.15
  convert.103 = s64[128,128,6]{2,1,0} convert(call.99)
  add.107 = s64[128,128,6]{2,1,0} add(broadcast.106, convert.103)
  reshape.109 = s64[98304]{0} reshape(add.107)
  constant.68 = s64[] constant(0)
  broadcast.69 = s64[98304]{0} broadcast(constant.68), dimensions={}
  compare.110 = pred[98304]{0} compare(reshape.109, broadcast.69), direction=LT
  constant.66 = s64[] constant(16384)
  broadcast.67 = s64[98304]{0} broadcast(constant.66), dimensions={}
  add.111 = s64[98304]{0} add(reshape.109, broadcast.67)
  select.112 = s64[98304]{0} select(compare.110, add.111, reshape.109)
  convert.113 = s32[98304]{0} convert(select.112)
  reshape.114 = s32[98304,1]{1,0} reshape(convert.113)
  gather.115 = f64[98304]{0} gather(reshape.108, reshape.114), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.116 = f64[128,128,6]{2,1,0} reshape(gather.115)
  slice.179 = f64[128,128,1]{2,1,0} slice(reshape.116), slice={[0:128], [0:128], [0:1]}
  reshape.180 = f64[128,128]{1,0} reshape(slice.179)
  multiply.181 = f64[128,128]{1,0} multiply(subtract.129, reshape.180)
  constant.58 = f64[] constant(2)
  broadcast.59 = f64[128,128]{1,0} broadcast(constant.58), dimensions={}
  divide.130 = f64[128,128]{1,0} divide(subtract.88, broadcast.59)
  negate.131 = f64[128,128]{1,0} negate(divide.130)
  multiply.132 = f64[128,128]{1,0} multiply(multiply.117, broadcast.59)
  constant.56 = f64[] constant(3)
  broadcast.57 = f64[128,128]{1,0} broadcast(constant.56), dimensions={}
  divide.133 = f64[128,128]{1,0} divide(multiply.132, broadcast.57)
  add.134 = f64[128,128]{1,0} add(negate.131, divide.133)
  divide.135 = f64[128,128]{1,0} divide(multiply.118, broadcast.63)
  subtract.136 = f64[128,128]{1,0} subtract(add.134, divide.135)
  constant.54 = f64[] constant(6)
  broadcast.55 = f64[128,128]{1,0} broadcast(constant.54), dimensions={}
  divide.137 = f64[128,128]{1,0} divide(multiply.119, broadcast.55)
  subtract.138 = f64[128,128]{1,0} subtract(subtract.136, divide.137)
  divide.139 = f64[128,128]{1,0} divide(multiply.120, broadcast.63)
  add.140 = f64[128,128]{1,0} add(subtract.138, divide.139)
  slice.182 = f64[128,128,1]{2,1,0} slice(reshape.116), slice={[0:128], [0:128], [1:2]}
  reshape.183 = f64[128,128]{1,0} reshape(slice.182)
  multiply.184 = f64[128,128]{1,0} multiply(add.140, reshape.183)
  add.185 = f64[128,128]{1,0} add(multiply.181, multiply.184)
  constant.52 = f64[] constant(1)
  broadcast.53 = f64[128,128]{1,0} broadcast(constant.52), dimensions={}
  divide.141 = f64[128,128]{1,0} divide(subtract.88, broadcast.57)
  subtract.142 = f64[128,128]{1,0} subtract(broadcast.53, divide.141)
  constant.50 = f64[] constant(5)
  broadcast.51 = f64[128,128]{1,0} broadcast(constant.50), dimensions={}
  multiply.143 = f64[128,128]{1,0} multiply(multiply.117, broadcast.51)
  constant.48 = f64[] constant(4)
  broadcast.49 = f64[128,128]{1,0} broadcast(constant.48), dimensions={}
  divide.144 = f64[128,128]{1,0} divide(multiply.143, broadcast.49)
  subtract.145 = f64[128,128]{1,0} subtract(subtract.142, divide.144)
  multiply.146 = f64[128,128]{1,0} multiply(multiply.118, broadcast.51)
  constant.46 = f64[] constant(12)
  broadcast.47 = f64[128,128]{1,0} broadcast(constant.46), dimensions={}
  divide.147 = f64[128,128]{1,0} divide(multiply.146, broadcast.47)
  add.148 = f64[128,128]{1,0} add(subtract.145, divide.147)
  divide.149 = f64[128,128]{1,0} divide(multiply.119, broadcast.49)
  add.150 = f64[128,128]{1,0} add(add.148, divide.149)
  divide.151 = f64[128,128]{1,0} divide(multiply.120, broadcast.47)
  subtract.152 = f64[128,128]{1,0} subtract(add.150, divide.151)
  slice.186 = f64[128,128,1]{2,1,0} slice(reshape.116), slice={[0:128], [0:128], [2:3]}
  reshape.187 = f64[128,128]{1,0} reshape(slice.186)
  multiply.188 = f64[128,128]{1,0} multiply(subtract.152, reshape.187)
  add.189 = f64[128,128]{1,0} add(add.185, multiply.188)
  multiply.153 = f64[128,128]{1,0} multiply(multiply.117, broadcast.59)
  divide.154 = f64[128,128]{1,0} divide(multiply.153, broadcast.57)
  add.155 = f64[128,128]{1,0} add(subtract.88, divide.154)
  constant.44 = f64[] constant(7)
  broadcast.45 = f64[128,128]{1,0} broadcast(constant.44), dimensions={}
  multiply.156 = f64[128,128]{1,0} multiply(multiply.118, broadcast.45)
  divide.157 = f64[128,128]{1,0} divide(multiply.156, broadcast.47)
  subtract.158 = f64[128,128]{1,0} subtract(add.155, divide.157)
  divide.159 = f64[128,128]{1,0} divide(multiply.119, broadcast.55)
  subtract.160 = f64[128,128]{1,0} subtract(subtract.158, divide.159)
  divide.161 = f64[128,128]{1,0} divide(multiply.120, broadcast.47)
  add.162 = f64[128,128]{1,0} add(subtract.160, divide.161)
  slice.190 = f64[128,128,1]{2,1,0} slice(reshape.116), slice={[0:128], [0:128], [3:4]}
  reshape.191 = f64[128,128]{1,0} reshape(slice.190)
  multiply.192 = f64[128,128]{1,0} multiply(add.162, reshape.191)
  add.193 = f64[128,128]{1,0} add(add.189, multiply.192)
  divide.163 = f64[128,128]{1,0} divide(subtract.88, broadcast.49)
  negate.164 = f64[128,128]{1,0} negate(divide.163)
  divide.165 = f64[128,128]{1,0} divide(multiply.117, broadcast.63)
  subtract.166 = f64[128,128]{1,0} subtract(negate.164, divide.165)
  multiply.167 = f64[128,128]{1,0} multiply(multiply.118, broadcast.45)
  divide.168 = f64[128,128]{1,0} divide(multiply.167, broadcast.63)
  add.169 = f64[128,128]{1,0} add(subtract.166, divide.168)
  divide.170 = f64[128,128]{1,0} divide(multiply.119, broadcast.63)
  add.171 = f64[128,128]{1,0} add(add.169, divide.170)
  divide.172 = f64[128,128]{1,0} divide(multiply.120, broadcast.63)
  subtract.173 = f64[128,128]{1,0} subtract(add.171, divide.172)
  slice.194 = f64[128,128,1]{2,1,0} slice(reshape.116), slice={[0:128], [0:128], [4:5]}
  reshape.195 = f64[128,128]{1,0} reshape(slice.194)
  multiply.196 = f64[128,128]{1,0} multiply(subtract.173, reshape.195)
  add.197 = f64[128,128]{1,0} add(add.193, multiply.196)
  constant.42 = f64[] constant(30)
  broadcast.43 = f64[128,128]{1,0} broadcast(constant.42), dimensions={}
  divide.174 = f64[128,128]{1,0} divide(subtract.88, broadcast.43)
  divide.175 = f64[128,128]{1,0} divide(multiply.118, broadcast.63)
  subtract.176 = f64[128,128]{1,0} subtract(divide.174, divide.175)
  divide.177 = f64[128,128]{1,0} divide(multiply.120, broadcast.61)
  add.178 = f64[128,128]{1,0} add(subtract.176, divide.177)
  slice.198 = f64[128,128,1]{2,1,0} slice(reshape.116), slice={[0:128], [0:128], [5:6]}
  reshape.199 = f64[128,128]{1,0} reshape(slice.198)
  multiply.200 = f64[128,128]{1,0} multiply(add.178, reshape.199)
  ROOT add.201 = f64[128,128]{1,0} add(add.197, multiply.200)
}

region_0.204 {
  Arg_0.205 = f64[] parameter(0)
  Arg_1.206 = f64[] parameter(1)
  ROOT add.207 = f64[] add(Arg_0.205, Arg_1.206)
}

fft.208 {
  Arg_0.209 = f64[128]{0} parameter(0)
  ROOT fft.210 = c128[65]{0} fft(Arg_0.209), fft_type=RFFT, fft_length={128}
}

fft_0.211 {
  Arg_0.212 = c128[65]{0} parameter(0)
  ROOT fft.213 = f64[128]{0} fft(Arg_0.212), fft_type=IRFFT, fft_length={128}
}

fft_0.214 {
  Arg_0.215 = c128[65]{0} parameter(0)
  ROOT fft.216 = f64[128]{0} fft(Arg_0.215), fft_type=IRFFT, fft_length={128}
}

solve_poisson.217 {
  Arg_0.218 = f64[128,128]{1,0} parameter(0)
  constant.225 = f64[] constant(0)
  reduce.226 = f64[128]{0} reduce(Arg_0.218, constant.225), dimensions={1}, to_apply=region_0.204
  Arg_2.220 = f64[] parameter(2)
  broadcast.227 = f64[128]{0} broadcast(Arg_2.220), dimensions={}
  multiply.228 = f64[128]{0} multiply(reduce.226, broadcast.227)
  constant.223 = f64[] constant(1)
  broadcast.224 = f64[128]{0} broadcast(constant.223), dimensions={}
  subtract.229 = f64[128]{0} subtract(multiply.228, broadcast.224)
  call.230 = c128[65]{0} call(subtract.229), to_apply=fft.208
  constant.221 = c128[] constant((-0, -1))
  broadcast.222 = c128[65]{0} broadcast(constant.221), dimensions={}
  multiply.231 = c128[65]{0} multiply(call.230, broadcast.222)
  Arg_1.219 = f64[65]{0} parameter(1)
  convert.232 = c128[65]{0} convert(Arg_1.219)
  multiply.233 = c128[65]{0} multiply(multiply.231, convert.232)
  call.234 = f64[128]{0} call(multiply.233), to_apply=fft_0.211
  multiply.235 = f64[65]{0} multiply(Arg_1.219, Arg_1.219)
  convert.236 = c128[65]{0} convert(multiply.235)
  multiply.237 = c128[65]{0} multiply(call.230, convert.236)
  call.238 = f64[128]{0} call(multiply.237), to_apply=fft_0.214
  ROOT tuple.239 = (f64[128]{0}, f64[128]{0}, f64[128]{0}) tuple(call.234, subtract.229, call.238)
}

clip.244 {
  Arg_2.247 = s64[] parameter(2)
  convert.251 = s32[] convert(Arg_2.247)
  broadcast.252 = s32[128,128,6]{2,1,0} broadcast(convert.251), dimensions={}
  Arg_1.246 = s64[] parameter(1)
  convert.248 = s32[] convert(Arg_1.246)
  broadcast.249 = s32[128,128,6]{2,1,0} broadcast(convert.248), dimensions={}
  Arg_0.245 = s32[128,128,6]{2,1,0} parameter(0)
  maximum.250 = s32[128,128,6]{2,1,0} maximum(broadcast.249, Arg_0.245)
  ROOT minimum.253 = s32[128,128,6]{2,1,0} minimum(broadcast.252, maximum.250)
}

_where_2.254 {
  Arg_0.255 = pred[128,128,6]{2,1,0} parameter(0)
  Arg_1.256 = f64[128,128,6]{2,1,0} parameter(1)
  Arg_2.257 = f64[] parameter(2)
  broadcast.258 = f64[128,128,6]{2,1,0} broadcast(Arg_2.257), dimensions={}
  ROOT select.259 = f64[128,128,6]{2,1,0} select(Arg_0.255, Arg_1.256, broadcast.258)
}

advect_1d_vectorized_1.260 {
  iota.303 = f64[128]{0} iota(), iota_dimension=0
  reshape.309 = f64[1,128]{1,0} reshape(iota.303)
  broadcast.310 = f64[1,128]{1,0} broadcast(reshape.309), dimensions={0,1}
  reshape.311 = f64[128]{0} reshape(broadcast.310)
  broadcast.312 = f64[128,128]{1,0} broadcast(reshape.311), dimensions={1}
  Arg_1.262 = f64[128]{0} parameter(1)
  reshape.304 = f64[128,1]{1,0} reshape(Arg_1.262)
  Arg_2.263 = f64[] parameter(2)
  broadcast.305 = f64[128,1]{1,0} broadcast(Arg_2.263), dimensions={}
  multiply.306 = f64[128,1]{1,0} multiply(reshape.304, broadcast.305)
  Arg_3.264 = f64[] parameter(3)
  broadcast.307 = f64[128,1]{1,0} broadcast(Arg_3.264), dimensions={}
  divide.308 = f64[128,1]{1,0} divide(multiply.306, broadcast.307)
  broadcast.313 = f64[128,1]{1,0} broadcast(divide.308), dimensions={0,1}
  reshape.314 = f64[128]{0} reshape(broadcast.313)
  broadcast.315 = f64[128,128]{1,0} broadcast(reshape.314), dimensions={0}
  subtract.316 = f64[128,128]{1,0} subtract(broadcast.312, broadcast.315)
  floor.317 = f64[128,128]{1,0} floor(subtract.316)
  subtract.318 = f64[128,128]{1,0} subtract(subtract.316, floor.317)
  constant.288 = f64[] constant(20)
  broadcast.289 = f64[128,128]{1,0} broadcast(constant.288), dimensions={}
  divide.355 = f64[128,128]{1,0} divide(subtract.318, broadcast.289)
  multiply.351 = f64[128,128]{1,0} multiply(subtract.318, subtract.318)
  constant.286 = f64[] constant(24)
  broadcast.287 = f64[128,128]{1,0} broadcast(constant.286), dimensions={}
  divide.356 = f64[128,128]{1,0} divide(multiply.351, broadcast.287)
  subtract.357 = f64[128,128]{1,0} subtract(divide.355, divide.356)
  multiply.352 = f64[128,128]{1,0} multiply(multiply.351, subtract.318)
  divide.358 = f64[128,128]{1,0} divide(multiply.352, broadcast.287)
  subtract.359 = f64[128,128]{1,0} subtract(subtract.357, divide.358)
  multiply.353 = f64[128,128]{1,0} multiply(multiply.352, subtract.318)
  divide.360 = f64[128,128]{1,0} divide(multiply.353, broadcast.287)
  add.361 = f64[128,128]{1,0} add(subtract.359, divide.360)
  multiply.354 = f64[128,128]{1,0} multiply(multiply.353, subtract.318)
  constant.284 = f64[] constant(120)
  broadcast.285 = f64[128,128]{1,0} broadcast(constant.284), dimensions={}
  divide.362 = f64[128,128]{1,0} divide(multiply.354, broadcast.285)
  subtract.363 = f64[128,128]{1,0} subtract(add.361, divide.362)
  convert.319 = s32[128,128]{1,0} convert(floor.317)
  reshape.320 = s32[128,128,1]{2,1,0} reshape(convert.319)
  broadcast.322 = s32[128,128,1]{2,1,0} broadcast(reshape.320), dimensions={0,1,2}
  reshape.323 = s32[128,128]{1,0} reshape(broadcast.322)
  broadcast.324 = s32[128,128,6]{2,1,0} broadcast(reshape.323), dimensions={0,1}
  Arg_4.265 = s32[6]{0} parameter(4)
  reshape.321 = s32[1,1,6]{2,1,0} reshape(Arg_4.265)
  broadcast.325 = s32[1,1,6]{2,1,0} broadcast(reshape.321), dimensions={0,1,2}
  reshape.326 = s32[6]{0} reshape(broadcast.325)
  broadcast.327 = s32[128,128,6]{2,1,0} broadcast(reshape.326), dimensions={2}
  add.328 = s32[128,128,6]{2,1,0} add(broadcast.324, broadcast.327)
  constant.298 = s32[] constant(0)
  broadcast.299 = s32[128,128,6]{2,1,0} broadcast(constant.298), dimensions={}
  compare.329 = pred[128,128,6]{2,1,0} compare(add.328, broadcast.299), direction=GE
  constant.296 = s32[] constant(128)
  broadcast.297 = s32[128,128,6]{2,1,0} broadcast(constant.296), dimensions={}
  compare.330 = pred[128,128,6]{2,1,0} compare(add.328, broadcast.297), direction=LT
  and.331 = pred[128,128,6]{2,1,0} and(compare.329, compare.330)
  Arg_0.261 = f64[128,128]{1,0} parameter(0)
  reshape.341 = f64[16384]{0} reshape(Arg_0.261)
  iota.333 = s64[128]{0} iota(), iota_dimension=0
  reshape.334 = s64[128,1,1]{2,1,0} reshape(iota.333)
  constant.294 = s64[] constant(128)
  broadcast.295 = s64[128,1,1]{2,1,0} broadcast(constant.294), dimensions={}
  multiply.335 = s64[128,1,1]{2,1,0} multiply(reshape.334, broadcast.295)
  broadcast.337 = s64[128,1,1]{2,1,0} broadcast(multiply.335), dimensions={0,1,2}
  reshape.338 = s64[128]{0} reshape(broadcast.337)
  broadcast.339 = s64[128,128,6]{2,1,0} broadcast(reshape.338), dimensions={0}
  constant.302 = s64[] constant(0)
  constant.301 = s64[] constant(127)
  call.332 = s32[128,128,6]{2,1,0} call(add.328, constant.302, constant.301), to_apply=clip.244
  convert.336 = s64[128,128,6]{2,1,0} convert(call.332)
  add.340 = s64[128,128,6]{2,1,0} add(broadcast.339, convert.336)
  reshape.342 = s64[98304]{0} reshape(add.340)
  constant.292 = s64[] constant(0)
  broadcast.293 = s64[98304]{0} broadcast(constant.292), dimensions={}
  compare.343 = pred[98304]{0} compare(reshape.342, broadcast.293), direction=LT
  constant.290 = s64[] constant(16384)
  broadcast.291 = s64[98304]{0} broadcast(constant.290), dimensions={}
  add.344 = s64[98304]{0} add(reshape.342, broadcast.291)
  select.345 = s64[98304]{0} select(compare.343, add.344, reshape.342)
  convert.346 = s32[98304]{0} convert(select.345)
  reshape.347 = s32[98304,1]{1,0} reshape(convert.346)
  gather.348 = f64[98304]{0} gather(reshape.341, reshape.347), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.349 = f64[128,128,6]{2,1,0} reshape(gather.348)
  constant.300 = f64[] constant(0)
  call.350 = f64[128,128,6]{2,1,0} call(and.331, reshape.349, constant.300), to_apply=_where_2.254
  slice.413 = f64[128,128,1]{2,1,0} slice(call.350), slice={[0:128], [0:128], [0:1]}
  reshape.414 = f64[128,128]{1,0} reshape(slice.413)
  multiply.415 = f64[128,128]{1,0} multiply(subtract.363, reshape.414)
  constant.282 = f64[] constant(2)
  broadcast.283 = f64[128,128]{1,0} broadcast(constant.282), dimensions={}
  divide.364 = f64[128,128]{1,0} divide(subtract.318, broadcast.283)
  negate.365 = f64[128,128]{1,0} negate(divide.364)
  multiply.366 = f64[128,128]{1,0} multiply(multiply.351, broadcast.283)
  constant.280 = f64[] constant(3)
  broadcast.281 = f64[128,128]{1,0} broadcast(constant.280), dimensions={}
  divide.367 = f64[128,128]{1,0} divide(multiply.366, broadcast.281)
  add.368 = f64[128,128]{1,0} add(negate.365, divide.367)
  divide.369 = f64[128,128]{1,0} divide(multiply.352, broadcast.287)
  subtract.370 = f64[128,128]{1,0} subtract(add.368, divide.369)
  constant.278 = f64[] constant(6)
  broadcast.279 = f64[128,128]{1,0} broadcast(constant.278), dimensions={}
  divide.371 = f64[128,128]{1,0} divide(multiply.353, broadcast.279)
  subtract.372 = f64[128,128]{1,0} subtract(subtract.370, divide.371)
  divide.373 = f64[128,128]{1,0} divide(multiply.354, broadcast.287)
  add.374 = f64[128,128]{1,0} add(subtract.372, divide.373)
  slice.416 = f64[128,128,1]{2,1,0} slice(call.350), slice={[0:128], [0:128], [1:2]}
  reshape.417 = f64[128,128]{1,0} reshape(slice.416)
  multiply.418 = f64[128,128]{1,0} multiply(add.374, reshape.417)
  add.419 = f64[128,128]{1,0} add(multiply.415, multiply.418)
  constant.276 = f64[] constant(1)
  broadcast.277 = f64[128,128]{1,0} broadcast(constant.276), dimensions={}
  divide.375 = f64[128,128]{1,0} divide(subtract.318, broadcast.281)
  subtract.376 = f64[128,128]{1,0} subtract(broadcast.277, divide.375)
  constant.274 = f64[] constant(5)
  broadcast.275 = f64[128,128]{1,0} broadcast(constant.274), dimensions={}
  multiply.377 = f64[128,128]{1,0} multiply(multiply.351, broadcast.275)
  constant.272 = f64[] constant(4)
  broadcast.273 = f64[128,128]{1,0} broadcast(constant.272), dimensions={}
  divide.378 = f64[128,128]{1,0} divide(multiply.377, broadcast.273)
  subtract.379 = f64[128,128]{1,0} subtract(subtract.376, divide.378)
  multiply.380 = f64[128,128]{1,0} multiply(multiply.352, broadcast.275)
  constant.270 = f64[] constant(12)
  broadcast.271 = f64[128,128]{1,0} broadcast(constant.270), dimensions={}
  divide.381 = f64[128,128]{1,0} divide(multiply.380, broadcast.271)
  add.382 = f64[128,128]{1,0} add(subtract.379, divide.381)
  divide.383 = f64[128,128]{1,0} divide(multiply.353, broadcast.273)
  add.384 = f64[128,128]{1,0} add(add.382, divide.383)
  divide.385 = f64[128,128]{1,0} divide(multiply.354, broadcast.271)
  subtract.386 = f64[128,128]{1,0} subtract(add.384, divide.385)
  slice.420 = f64[128,128,1]{2,1,0} slice(call.350), slice={[0:128], [0:128], [2:3]}
  reshape.421 = f64[128,128]{1,0} reshape(slice.420)
  multiply.422 = f64[128,128]{1,0} multiply(subtract.386, reshape.421)
  add.423 = f64[128,128]{1,0} add(add.419, multiply.422)
  multiply.387 = f64[128,128]{1,0} multiply(multiply.351, broadcast.283)
  divide.388 = f64[128,128]{1,0} divide(multiply.387, broadcast.281)
  add.389 = f64[128,128]{1,0} add(subtract.318, divide.388)
  constant.268 = f64[] constant(7)
  broadcast.269 = f64[128,128]{1,0} broadcast(constant.268), dimensions={}
  multiply.390 = f64[128,128]{1,0} multiply(multiply.352, broadcast.269)
  divide.391 = f64[128,128]{1,0} divide(multiply.390, broadcast.271)
  subtract.392 = f64[128,128]{1,0} subtract(add.389, divide.391)
  divide.393 = f64[128,128]{1,0} divide(multiply.353, broadcast.279)
  subtract.394 = f64[128,128]{1,0} subtract(subtract.392, divide.393)
  divide.395 = f64[128,128]{1,0} divide(multiply.354, broadcast.271)
  add.396 = f64[128,128]{1,0} add(subtract.394, divide.395)
  slice.424 = f64[128,128,1]{2,1,0} slice(call.350), slice={[0:128], [0:128], [3:4]}
  reshape.425 = f64[128,128]{1,0} reshape(slice.424)
  multiply.426 = f64[128,128]{1,0} multiply(add.396, reshape.425)
  add.427 = f64[128,128]{1,0} add(add.423, multiply.426)
  divide.397 = f64[128,128]{1,0} divide(subtract.318, broadcast.273)
  negate.398 = f64[128,128]{1,0} negate(divide.397)
  divide.399 = f64[128,128]{1,0} divide(multiply.351, broadcast.287)
  subtract.400 = f64[128,128]{1,0} subtract(negate.398, divide.399)
  multiply.401 = f64[128,128]{1,0} multiply(multiply.352, broadcast.269)
  divide.402 = f64[128,128]{1,0} divide(multiply.401, broadcast.287)
  add.403 = f64[128,128]{1,0} add(subtract.400, divide.402)
  divide.404 = f64[128,128]{1,0} divide(multiply.353, broadcast.287)
  add.405 = f64[128,128]{1,0} add(add.403, divide.404)
  divide.406 = f64[128,128]{1,0} divide(multiply.354, broadcast.287)
  subtract.407 = f64[128,128]{1,0} subtract(add.405, divide.406)
  slice.428 = f64[128,128,1]{2,1,0} slice(call.350), slice={[0:128], [0:128], [4:5]}
  reshape.429 = f64[128,128]{1,0} reshape(slice.428)
  multiply.430 = f64[128,128]{1,0} multiply(subtract.407, reshape.429)
  add.431 = f64[128,128]{1,0} add(add.427, multiply.430)
  constant.266 = f64[] constant(30)
  broadcast.267 = f64[128,128]{1,0} broadcast(constant.266), dimensions={}
  divide.408 = f64[128,128]{1,0} divide(subtract.318, broadcast.267)
  divide.409 = f64[128,128]{1,0} divide(multiply.352, broadcast.287)
  subtract.410 = f64[128,128]{1,0} subtract(divide.408, divide.409)
  divide.411 = f64[128,128]{1,0} divide(multiply.354, broadcast.285)
  add.412 = f64[128,128]{1,0} add(subtract.410, divide.411)
  slice.432 = f64[128,128,1]{2,1,0} slice(call.350), slice={[0:128], [0:128], [5:6]}
  reshape.433 = f64[128,128]{1,0} reshape(slice.432)
  multiply.434 = f64[128,128]{1,0} multiply(add.412, reshape.433)
  ROOT add.435 = f64[128,128]{1,0} add(add.431, multiply.434)
}

_where.438 {
  Arg_0.439 = pred[] parameter(0)
  Arg_1.440 = s32[] parameter(1)
  Arg_2.441 = s32[] parameter(2)
  ROOT select.442 = s32[] select(Arg_0.439, Arg_1.440, Arg_2.441)
}

remainder.443 {
  Arg_0.444 = s32[128,128,6]{2,1,0} parameter(0)
  Arg_1.445 = s64[] parameter(1)
  convert.450 = s32[] convert(Arg_1.445)
  constant.449 = s32[] constant(0)
  compare.451 = pred[] compare(convert.450, constant.449), direction=EQ
  constant.448 = s32[] constant(1)
  call.452 = s32[] call(compare.451, constant.448, convert.450), to_apply=_where.438
  broadcast.453 = s32[128,128,6]{2,1,0} broadcast(call.452), dimensions={}
  remainder.454 = s32[128,128,6]{2,1,0} remainder(Arg_0.444, broadcast.453)
  constant.446 = s32[] constant(0)
  broadcast.447 = s32[128,128,6]{2,1,0} broadcast(constant.446), dimensions={}
  compare.456 = pred[128,128,6]{2,1,0} compare(remainder.454, broadcast.447), direction=LT
  compare.457 = pred[] compare(call.452, constant.449), direction=LT
  broadcast.458 = pred[128,128,6]{2,1,0} broadcast(compare.457), dimensions={}
  compare.459 = pred[128,128,6]{2,1,0} compare(compare.456, broadcast.458), direction=NE
  compare.455 = pred[128,128,6]{2,1,0} compare(remainder.454, broadcast.447), direction=NE
  and.460 = pred[128,128,6]{2,1,0} and(compare.459, compare.455)
  broadcast.461 = s32[128,128,6]{2,1,0} broadcast(call.452), dimensions={}
  add.462 = s32[128,128,6]{2,1,0} add(remainder.454, broadcast.461)
  ROOT select.463 = s32[128,128,6]{2,1,0} select(and.460, add.462, remainder.454)
}

advect_1d_vectorized.464 {
  iota.501 = f64[128]{0} iota(), iota_dimension=0
  reshape.507 = f64[1,128]{1,0} reshape(iota.501)
  broadcast.508 = f64[1,128]{1,0} broadcast(reshape.507), dimensions={0,1}
  reshape.509 = f64[128]{0} reshape(broadcast.508)
  broadcast.510 = f64[128,128]{1,0} broadcast(reshape.509), dimensions={1}
  Arg_1.466 = f64[128]{0} parameter(1)
  reshape.502 = f64[128,1]{1,0} reshape(Arg_1.466)
  Arg_2.467 = f64[] parameter(2)
  broadcast.503 = f64[128,1]{1,0} broadcast(Arg_2.467), dimensions={}
  multiply.504 = f64[128,1]{1,0} multiply(reshape.502, broadcast.503)
  Arg_3.468 = f64[] parameter(3)
  broadcast.505 = f64[128,1]{1,0} broadcast(Arg_3.468), dimensions={}
  divide.506 = f64[128,1]{1,0} divide(multiply.504, broadcast.505)
  broadcast.511 = f64[128,1]{1,0} broadcast(divide.506), dimensions={0,1}
  reshape.512 = f64[128]{0} reshape(broadcast.511)
  broadcast.513 = f64[128,128]{1,0} broadcast(reshape.512), dimensions={0}
  subtract.514 = f64[128,128]{1,0} subtract(broadcast.510, broadcast.513)
  floor.515 = f64[128,128]{1,0} floor(subtract.514)
  subtract.516 = f64[128,128]{1,0} subtract(subtract.514, floor.515)
  constant.492 = f64[] constant(20)
  broadcast.493 = f64[128,128]{1,0} broadcast(constant.492), dimensions={}
  divide.549 = f64[128,128]{1,0} divide(subtract.516, broadcast.493)
  multiply.545 = f64[128,128]{1,0} multiply(subtract.516, subtract.516)
  constant.490 = f64[] constant(24)
  broadcast.491 = f64[128,128]{1,0} broadcast(constant.490), dimensions={}
  divide.550 = f64[128,128]{1,0} divide(multiply.545, broadcast.491)
  subtract.551 = f64[128,128]{1,0} subtract(divide.549, divide.550)
  multiply.546 = f64[128,128]{1,0} multiply(multiply.545, subtract.516)
  divide.552 = f64[128,128]{1,0} divide(multiply.546, broadcast.491)
  subtract.553 = f64[128,128]{1,0} subtract(subtract.551, divide.552)
  multiply.547 = f64[128,128]{1,0} multiply(multiply.546, subtract.516)
  divide.554 = f64[128,128]{1,0} divide(multiply.547, broadcast.491)
  add.555 = f64[128,128]{1,0} add(subtract.553, divide.554)
  multiply.548 = f64[128,128]{1,0} multiply(multiply.547, subtract.516)
  constant.488 = f64[] constant(120)
  broadcast.489 = f64[128,128]{1,0} broadcast(constant.488), dimensions={}
  divide.556 = f64[128,128]{1,0} divide(multiply.548, broadcast.489)
  subtract.557 = f64[128,128]{1,0} subtract(add.555, divide.556)
  Arg_0.465 = f64[128,128]{1,0} parameter(0)
  reshape.536 = f64[16384]{0} reshape(Arg_0.465)
  iota.528 = s64[128]{0} iota(), iota_dimension=0
  reshape.529 = s64[128,1,1]{2,1,0} reshape(iota.528)
  constant.498 = s64[] constant(128)
  broadcast.499 = s64[128,1,1]{2,1,0} broadcast(constant.498), dimensions={}
  multiply.530 = s64[128,1,1]{2,1,0} multiply(reshape.529, broadcast.499)
  broadcast.532 = s64[128,1,1]{2,1,0} broadcast(multiply.530), dimensions={0,1,2}
  reshape.533 = s64[128]{0} reshape(broadcast.532)
  broadcast.534 = s64[128,128,6]{2,1,0} broadcast(reshape.533), dimensions={0}
  convert.517 = s32[128,128]{1,0} convert(floor.515)
  reshape.518 = s32[128,128,1]{2,1,0} reshape(convert.517)
  broadcast.520 = s32[128,128,1]{2,1,0} broadcast(reshape.518), dimensions={0,1,2}
  reshape.521 = s32[128,128]{1,0} reshape(broadcast.520)
  broadcast.522 = s32[128,128,6]{2,1,0} broadcast(reshape.521), dimensions={0,1}
  Arg_4.469 = s32[6]{0} parameter(4)
  reshape.519 = s32[1,1,6]{2,1,0} reshape(Arg_4.469)
  broadcast.523 = s32[1,1,6]{2,1,0} broadcast(reshape.519), dimensions={0,1,2}
  reshape.524 = s32[6]{0} reshape(broadcast.523)
  broadcast.525 = s32[128,128,6]{2,1,0} broadcast(reshape.524), dimensions={2}
  add.526 = s32[128,128,6]{2,1,0} add(broadcast.522, broadcast.525)
  constant.500 = s64[] constant(128)
  call.527 = s32[128,128,6]{2,1,0} call(add.526, constant.500), to_apply=remainder.443
  convert.531 = s64[128,128,6]{2,1,0} convert(call.527)
  add.535 = s64[128,128,6]{2,1,0} add(broadcast.534, convert.531)
  reshape.537 = s64[98304]{0} reshape(add.535)
  constant.496 = s64[] constant(0)
  broadcast.497 = s64[98304]{0} broadcast(constant.496), dimensions={}
  compare.538 = pred[98304]{0} compare(reshape.537, broadcast.497), direction=LT
  constant.494 = s64[] constant(16384)
  broadcast.495 = s64[98304]{0} broadcast(constant.494), dimensions={}
  add.539 = s64[98304]{0} add(reshape.537, broadcast.495)
  select.540 = s64[98304]{0} select(compare.538, add.539, reshape.537)
  convert.541 = s32[98304]{0} convert(select.540)
  reshape.542 = s32[98304,1]{1,0} reshape(convert.541)
  gather.543 = f64[98304]{0} gather(reshape.536, reshape.542), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.544 = f64[128,128,6]{2,1,0} reshape(gather.543)
  slice.607 = f64[128,128,1]{2,1,0} slice(reshape.544), slice={[0:128], [0:128], [0:1]}
  reshape.608 = f64[128,128]{1,0} reshape(slice.607)
  multiply.609 = f64[128,128]{1,0} multiply(subtract.557, reshape.608)
  constant.486 = f64[] constant(2)
  broadcast.487 = f64[128,128]{1,0} broadcast(constant.486), dimensions={}
  divide.558 = f64[128,128]{1,0} divide(subtract.516, broadcast.487)
  negate.559 = f64[128,128]{1,0} negate(divide.558)
  multiply.560 = f64[128,128]{1,0} multiply(multiply.545, broadcast.487)
  constant.484 = f64[] constant(3)
  broadcast.485 = f64[128,128]{1,0} broadcast(constant.484), dimensions={}
  divide.561 = f64[128,128]{1,0} divide(multiply.560, broadcast.485)
  add.562 = f64[128,128]{1,0} add(negate.559, divide.561)
  divide.563 = f64[128,128]{1,0} divide(multiply.546, broadcast.491)
  subtract.564 = f64[128,128]{1,0} subtract(add.562, divide.563)
  constant.482 = f64[] constant(6)
  broadcast.483 = f64[128,128]{1,0} broadcast(constant.482), dimensions={}
  divide.565 = f64[128,128]{1,0} divide(multiply.547, broadcast.483)
  subtract.566 = f64[128,128]{1,0} subtract(subtract.564, divide.565)
  divide.567 = f64[128,128]{1,0} divide(multiply.548, broadcast.491)
  add.568 = f64[128,128]{1,0} add(subtract.566, divide.567)
  slice.610 = f64[128,128,1]{2,1,0} slice(reshape.544), slice={[0:128], [0:128], [1:2]}
  reshape.611 = f64[128,128]{1,0} reshape(slice.610)
  multiply.612 = f64[128,128]{1,0} multiply(add.568, reshape.611)
  add.613 = f64[128,128]{1,0} add(multiply.609, multiply.612)
  constant.480 = f64[] constant(1)
  broadcast.481 = f64[128,128]{1,0} broadcast(constant.480), dimensions={}
  divide.569 = f64[128,128]{1,0} divide(subtract.516, broadcast.485)
  subtract.570 = f64[128,128]{1,0} subtract(broadcast.481, divide.569)
  constant.478 = f64[] constant(5)
  broadcast.479 = f64[128,128]{1,0} broadcast(constant.478), dimensions={}
  multiply.571 = f64[128,128]{1,0} multiply(multiply.545, broadcast.479)
  constant.476 = f64[] constant(4)
  broadcast.477 = f64[128,128]{1,0} broadcast(constant.476), dimensions={}
  divide.572 = f64[128,128]{1,0} divide(multiply.571, broadcast.477)
  subtract.573 = f64[128,128]{1,0} subtract(subtract.570, divide.572)
  multiply.574 = f64[128,128]{1,0} multiply(multiply.546, broadcast.479)
  constant.474 = f64[] constant(12)
  broadcast.475 = f64[128,128]{1,0} broadcast(constant.474), dimensions={}
  divide.575 = f64[128,128]{1,0} divide(multiply.574, broadcast.475)
  add.576 = f64[128,128]{1,0} add(subtract.573, divide.575)
  divide.577 = f64[128,128]{1,0} divide(multiply.547, broadcast.477)
  add.578 = f64[128,128]{1,0} add(add.576, divide.577)
  divide.579 = f64[128,128]{1,0} divide(multiply.548, broadcast.475)
  subtract.580 = f64[128,128]{1,0} subtract(add.578, divide.579)
  slice.614 = f64[128,128,1]{2,1,0} slice(reshape.544), slice={[0:128], [0:128], [2:3]}
  reshape.615 = f64[128,128]{1,0} reshape(slice.614)
  multiply.616 = f64[128,128]{1,0} multiply(subtract.580, reshape.615)
  add.617 = f64[128,128]{1,0} add(add.613, multiply.616)
  multiply.581 = f64[128,128]{1,0} multiply(multiply.545, broadcast.487)
  divide.582 = f64[128,128]{1,0} divide(multiply.581, broadcast.485)
  add.583 = f64[128,128]{1,0} add(subtract.516, divide.582)
  constant.472 = f64[] constant(7)
  broadcast.473 = f64[128,128]{1,0} broadcast(constant.472), dimensions={}
  multiply.584 = f64[128,128]{1,0} multiply(multiply.546, broadcast.473)
  divide.585 = f64[128,128]{1,0} divide(multiply.584, broadcast.475)
  subtract.586 = f64[128,128]{1,0} subtract(add.583, divide.585)
  divide.587 = f64[128,128]{1,0} divide(multiply.547, broadcast.483)
  subtract.588 = f64[128,128]{1,0} subtract(subtract.586, divide.587)
  divide.589 = f64[128,128]{1,0} divide(multiply.548, broadcast.475)
  add.590 = f64[128,128]{1,0} add(subtract.588, divide.589)
  slice.618 = f64[128,128,1]{2,1,0} slice(reshape.544), slice={[0:128], [0:128], [3:4]}
  reshape.619 = f64[128,128]{1,0} reshape(slice.618)
  multiply.620 = f64[128,128]{1,0} multiply(add.590, reshape.619)
  add.621 = f64[128,128]{1,0} add(add.617, multiply.620)
  divide.591 = f64[128,128]{1,0} divide(subtract.516, broadcast.477)
  negate.592 = f64[128,128]{1,0} negate(divide.591)
  divide.593 = f64[128,128]{1,0} divide(multiply.545, broadcast.491)
  subtract.594 = f64[128,128]{1,0} subtract(negate.592, divide.593)
  multiply.595 = f64[128,128]{1,0} multiply(multiply.546, broadcast.473)
  divide.596 = f64[128,128]{1,0} divide(multiply.595, broadcast.491)
  add.597 = f64[128,128]{1,0} add(subtract.594, divide.596)
  divide.598 = f64[128,128]{1,0} divide(multiply.547, broadcast.491)
  add.599 = f64[128,128]{1,0} add(add.597, divide.598)
  divide.600 = f64[128,128]{1,0} divide(multiply.548, broadcast.491)
  subtract.601 = f64[128,128]{1,0} subtract(add.599, divide.600)
  slice.622 = f64[128,128,1]{2,1,0} slice(reshape.544), slice={[0:128], [0:128], [4:5]}
  reshape.623 = f64[128,128]{1,0} reshape(slice.622)
  multiply.624 = f64[128,128]{1,0} multiply(subtract.601, reshape.623)
  add.625 = f64[128,128]{1,0} add(add.621, multiply.624)
  constant.470 = f64[] constant(30)
  broadcast.471 = f64[128,128]{1,0} broadcast(constant.470), dimensions={}
  divide.602 = f64[128,128]{1,0} divide(subtract.516, broadcast.471)
  divide.603 = f64[128,128]{1,0} divide(multiply.546, broadcast.491)
  subtract.604 = f64[128,128]{1,0} subtract(divide.602, divide.603)
  divide.605 = f64[128,128]{1,0} divide(multiply.548, broadcast.489)
  add.606 = f64[128,128]{1,0} add(subtract.604, divide.605)
  slice.626 = f64[128,128,1]{2,1,0} slice(reshape.544), slice={[0:128], [0:128], [5:6]}
  reshape.627 = f64[128,128]{1,0} reshape(slice.626)
  multiply.628 = f64[128,128]{1,0} multiply(add.606, reshape.627)
  ROOT add.629 = f64[128,128]{1,0} add(add.625, multiply.628)
}

ENTRY main.633 {
  Arg_0.1 = f64[128,128]{1,0} parameter(0)
  transpose.9 = f64[128,128]{0,1} transpose(Arg_0.1), dimensions={1,0}
  constant.6 = f64[128]{0} constant({...})
  constant.5 = f64[] constant(0.025)
  constant.4 = f64[] constant(0.098174770424681035)
  constant.7 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  call.202 = f64[128,128]{1,0} call(transpose.9, constant.6, constant.5, constant.4, constant.7), to_apply=advect_1d_vectorized.36
  transpose.203 = f64[128,128]{0,1} transpose(call.202), dimensions={1,0}
  constant.8 = f64[65]{0} constant({...})
  constant.3 = f64[] constant(0.07874015748031496)
  call.240 = (f64[128]{0}, f64[128]{0}, f64[128]{0}) call(transpose.203, constant.8, constant.3), to_apply=solve_poisson.217
  get-tuple-element.241 = f64[128]{0} get-tuple-element(call.240), index=0
  constant.2 = f64[] constant(0.05)
  call.436 = f64[128,128]{1,0} call(transpose.203, get-tuple-element.241, constant.2, constant.3, constant.7), to_apply=advect_1d_vectorized_1.260
  transpose.437 = f64[128,128]{0,1} transpose(call.436), dimensions={1,0}
  call.630 = f64[128,128]{1,0} call(transpose.437, constant.6, constant.5, constant.4, constant.7), to_apply=advect_1d_vectorized.464
  transpose.631 = f64[128,128]{0,1} transpose(call.630), dimensions={1,0}
  get-tuple-element.242 = f64[128]{0} get-tuple-element(call.240), index=1
  get-tuple-element.243 = f64[128]{0} get-tuple-element(call.240), index=2
  ROOT tuple.632 = (f64[128,128]{0,1}, f64[128]{0}, f64[128]{0}) tuple(transpose.631, get-tuple-element.242, get-tuple-element.243)
}

