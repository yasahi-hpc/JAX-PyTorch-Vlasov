HloModule jit_run_chunk, entry_computation_layout={(f32[128]{0}, f32[128]{0}, f32[65]{0}, s32[6]{0}, f32[128]{0}, /*index=5*/f32[128]{0}, f32[128,128]{1,0}, f32[128]{0}, f32[], s32[])->(f32[128]{0}, f32[128]{0}, f32[65]{0}, s32[6]{0}, f32[128]{0}, /*index=5*/f32[128]{0}, f32[128,128]{1,0}, f32[128]{0}, f32[], s32[])}

_where.15 {
  Arg_0.16 = pred[] parameter(0)
  Arg_1.17 = s32[] parameter(1)
  Arg_2.18 = s32[] parameter(2)
  ROOT select.19 = s32[] select(Arg_0.16, Arg_1.17, Arg_2.18)
}

remainder.20 {
  Arg_0.21 = s32[128,128,6]{2,1,0} parameter(0)
  Arg_1.22 = s32[] parameter(1)
  constant.26 = s32[] constant(0)
  compare.27 = pred[] compare(Arg_1.22, constant.26), direction=EQ
  constant.25 = s32[] constant(1)
  call.28 = s32[] call(compare.27, constant.25, Arg_1.22), to_apply=_where.15
  broadcast.29 = s32[128,128,6]{2,1,0} broadcast(call.28), dimensions={}
  remainder.30 = s32[128,128,6]{2,1,0} remainder(Arg_0.21, broadcast.29)
  constant.23 = s32[] constant(0)
  broadcast.24 = s32[128,128,6]{2,1,0} broadcast(constant.23), dimensions={}
  compare.32 = pred[128,128,6]{2,1,0} compare(remainder.30, broadcast.24), direction=LT
  compare.33 = pred[] compare(call.28, constant.26), direction=LT
  broadcast.34 = pred[128,128,6]{2,1,0} broadcast(compare.33), dimensions={}
  compare.35 = pred[128,128,6]{2,1,0} compare(compare.32, broadcast.34), direction=NE
  compare.31 = pred[128,128,6]{2,1,0} compare(remainder.30, broadcast.24), direction=NE
  and.36 = pred[128,128,6]{2,1,0} and(compare.35, compare.31)
  broadcast.37 = s32[128,128,6]{2,1,0} broadcast(call.28), dimensions={}
  add.38 = s32[128,128,6]{2,1,0} add(remainder.30, broadcast.37)
  ROOT select.39 = s32[128,128,6]{2,1,0} select(and.36, add.38, remainder.30)
}

advect_1d_vectorized.40 {
  iota.77 = f32[128]{0} iota(), iota_dimension=0
  reshape.83 = f32[1,128]{1,0} reshape(iota.77)
  broadcast.84 = f32[1,128]{1,0} broadcast(reshape.83), dimensions={0,1}
  reshape.85 = f32[128]{0} reshape(broadcast.84)
  broadcast.86 = f32[128,128]{1,0} broadcast(reshape.85), dimensions={1}
  Arg_1.42 = f32[128]{0} parameter(1)
  reshape.78 = f32[128,1]{1,0} reshape(Arg_1.42)
  Arg_2.43 = f32[] parameter(2)
  broadcast.79 = f32[128,1]{1,0} broadcast(Arg_2.43), dimensions={}
  multiply.80 = f32[128,1]{1,0} multiply(reshape.78, broadcast.79)
  Arg_3.44 = f32[] parameter(3)
  broadcast.81 = f32[128,1]{1,0} broadcast(Arg_3.44), dimensions={}
  divide.82 = f32[128,1]{1,0} divide(multiply.80, broadcast.81)
  broadcast.87 = f32[128,1]{1,0} broadcast(divide.82), dimensions={0,1}
  reshape.88 = f32[128]{0} reshape(broadcast.87)
  broadcast.89 = f32[128,128]{1,0} broadcast(reshape.88), dimensions={0}
  subtract.90 = f32[128,128]{1,0} subtract(broadcast.86, broadcast.89)
  floor.91 = f32[128,128]{1,0} floor(subtract.90)
  subtract.92 = f32[128,128]{1,0} subtract(subtract.90, floor.91)
  constant.68 = f32[] constant(20)
  broadcast.69 = f32[128,128]{1,0} broadcast(constant.68), dimensions={}
  divide.123 = f32[128,128]{1,0} divide(subtract.92, broadcast.69)
  multiply.119 = f32[128,128]{1,0} multiply(subtract.92, subtract.92)
  constant.66 = f32[] constant(24)
  broadcast.67 = f32[128,128]{1,0} broadcast(constant.66), dimensions={}
  divide.124 = f32[128,128]{1,0} divide(multiply.119, broadcast.67)
  subtract.125 = f32[128,128]{1,0} subtract(divide.123, divide.124)
  multiply.120 = f32[128,128]{1,0} multiply(multiply.119, subtract.92)
  divide.126 = f32[128,128]{1,0} divide(multiply.120, broadcast.67)
  subtract.127 = f32[128,128]{1,0} subtract(subtract.125, divide.126)
  multiply.121 = f32[128,128]{1,0} multiply(multiply.120, subtract.92)
  divide.128 = f32[128,128]{1,0} divide(multiply.121, broadcast.67)
  add.129 = f32[128,128]{1,0} add(subtract.127, divide.128)
  multiply.122 = f32[128,128]{1,0} multiply(multiply.121, subtract.92)
  constant.64 = f32[] constant(120)
  broadcast.65 = f32[128,128]{1,0} broadcast(constant.64), dimensions={}
  divide.130 = f32[128,128]{1,0} divide(multiply.122, broadcast.65)
  subtract.131 = f32[128,128]{1,0} subtract(add.129, divide.130)
  Arg_0.41 = f32[128,128]{1,0} parameter(0)
  reshape.111 = f32[16384]{0} reshape(Arg_0.41)
  iota.104 = s32[128]{0} iota(), iota_dimension=0
  reshape.105 = s32[128,1,1]{2,1,0} reshape(iota.104)
  constant.74 = s32[] constant(128)
  broadcast.75 = s32[128,1,1]{2,1,0} broadcast(constant.74), dimensions={}
  multiply.106 = s32[128,1,1]{2,1,0} multiply(reshape.105, broadcast.75)
  broadcast.107 = s32[128,1,1]{2,1,0} broadcast(multiply.106), dimensions={0,1,2}
  reshape.108 = s32[128]{0} reshape(broadcast.107)
  broadcast.109 = s32[128,128,6]{2,1,0} broadcast(reshape.108), dimensions={0}
  convert.93 = s32[128,128]{1,0} convert(floor.91)
  reshape.94 = s32[128,128,1]{2,1,0} reshape(convert.93)
  broadcast.96 = s32[128,128,1]{2,1,0} broadcast(reshape.94), dimensions={0,1,2}
  reshape.97 = s32[128,128]{1,0} reshape(broadcast.96)
  broadcast.98 = s32[128,128,6]{2,1,0} broadcast(reshape.97), dimensions={0,1}
  Arg_4.45 = s32[6]{0} parameter(4)
  reshape.95 = s32[1,1,6]{2,1,0} reshape(Arg_4.45)
  broadcast.99 = s32[1,1,6]{2,1,0} broadcast(reshape.95), dimensions={0,1,2}
  reshape.100 = s32[6]{0} reshape(broadcast.99)
  broadcast.101 = s32[128,128,6]{2,1,0} broadcast(reshape.100), dimensions={2}
  add.102 = s32[128,128,6]{2,1,0} add(broadcast.98, broadcast.101)
  constant.76 = s32[] constant(128)
  call.103 = s32[128,128,6]{2,1,0} call(add.102, constant.76), to_apply=remainder.20
  add.110 = s32[128,128,6]{2,1,0} add(broadcast.109, call.103)
  reshape.112 = s32[98304]{0} reshape(add.110)
  constant.72 = s32[] constant(0)
  broadcast.73 = s32[98304]{0} broadcast(constant.72), dimensions={}
  compare.113 = pred[98304]{0} compare(reshape.112, broadcast.73), direction=LT
  constant.70 = s32[] constant(16384)
  broadcast.71 = s32[98304]{0} broadcast(constant.70), dimensions={}
  add.114 = s32[98304]{0} add(reshape.112, broadcast.71)
  select.115 = s32[98304]{0} select(compare.113, add.114, reshape.112)
  reshape.116 = s32[98304,1]{1,0} reshape(select.115)
  gather.117 = f32[98304]{0} gather(reshape.111, reshape.116), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.118 = f32[128,128,6]{2,1,0} reshape(gather.117)
  slice.181 = f32[128,128,1]{2,1,0} slice(reshape.118), slice={[0:128], [0:128], [0:1]}
  reshape.182 = f32[128,128]{1,0} reshape(slice.181)
  multiply.183 = f32[128,128]{1,0} multiply(subtract.131, reshape.182)
  constant.62 = f32[] constant(2)
  broadcast.63 = f32[128,128]{1,0} broadcast(constant.62), dimensions={}
  divide.132 = f32[128,128]{1,0} divide(subtract.92, broadcast.63)
  negate.133 = f32[128,128]{1,0} negate(divide.132)
  multiply.134 = f32[128,128]{1,0} multiply(multiply.119, broadcast.63)
  constant.60 = f32[] constant(3)
  broadcast.61 = f32[128,128]{1,0} broadcast(constant.60), dimensions={}
  divide.135 = f32[128,128]{1,0} divide(multiply.134, broadcast.61)
  add.136 = f32[128,128]{1,0} add(negate.133, divide.135)
  divide.137 = f32[128,128]{1,0} divide(multiply.120, broadcast.67)
  subtract.138 = f32[128,128]{1,0} subtract(add.136, divide.137)
  constant.58 = f32[] constant(6)
  broadcast.59 = f32[128,128]{1,0} broadcast(constant.58), dimensions={}
  divide.139 = f32[128,128]{1,0} divide(multiply.121, broadcast.59)
  subtract.140 = f32[128,128]{1,0} subtract(subtract.138, divide.139)
  divide.141 = f32[128,128]{1,0} divide(multiply.122, broadcast.67)
  add.142 = f32[128,128]{1,0} add(subtract.140, divide.141)
  slice.184 = f32[128,128,1]{2,1,0} slice(reshape.118), slice={[0:128], [0:128], [1:2]}
  reshape.185 = f32[128,128]{1,0} reshape(slice.184)
  multiply.186 = f32[128,128]{1,0} multiply(add.142, reshape.185)
  add.187 = f32[128,128]{1,0} add(multiply.183, multiply.186)
  constant.56 = f32[] constant(1)
  broadcast.57 = f32[128,128]{1,0} broadcast(constant.56), dimensions={}
  divide.143 = f32[128,128]{1,0} divide(subtract.92, broadcast.61)
  subtract.144 = f32[128,128]{1,0} subtract(broadcast.57, divide.143)
  constant.54 = f32[] constant(5)
  broadcast.55 = f32[128,128]{1,0} broadcast(constant.54), dimensions={}
  multiply.145 = f32[128,128]{1,0} multiply(multiply.119, broadcast.55)
  constant.52 = f32[] constant(4)
  broadcast.53 = f32[128,128]{1,0} broadcast(constant.52), dimensions={}
  divide.146 = f32[128,128]{1,0} divide(multiply.145, broadcast.53)
  subtract.147 = f32[128,128]{1,0} subtract(subtract.144, divide.146)
  multiply.148 = f32[128,128]{1,0} multiply(multiply.120, broadcast.55)
  constant.50 = f32[] constant(12)
  broadcast.51 = f32[128,128]{1,0} broadcast(constant.50), dimensions={}
  divide.149 = f32[128,128]{1,0} divide(multiply.148, broadcast.51)
  add.150 = f32[128,128]{1,0} add(subtract.147, divide.149)
  divide.151 = f32[128,128]{1,0} divide(multiply.121, broadcast.53)
  add.152 = f32[128,128]{1,0} add(add.150, divide.151)
  divide.153 = f32[128,128]{1,0} divide(multiply.122, broadcast.51)
  subtract.154 = f32[128,128]{1,0} subtract(add.152, divide.153)
  slice.188 = f32[128,128,1]{2,1,0} slice(reshape.118), slice={[0:128], [0:128], [2:3]}
  reshape.189 = f32[128,128]{1,0} reshape(slice.188)
  multiply.190 = f32[128,128]{1,0} multiply(subtract.154, reshape.189)
  add.191 = f32[128,128]{1,0} add(add.187, multiply.190)
  multiply.155 = f32[128,128]{1,0} multiply(multiply.119, broadcast.63)
  divide.156 = f32[128,128]{1,0} divide(multiply.155, broadcast.61)
  add.157 = f32[128,128]{1,0} add(subtract.92, divide.156)
  constant.48 = f32[] constant(7)
  broadcast.49 = f32[128,128]{1,0} broadcast(constant.48), dimensions={}
  multiply.158 = f32[128,128]{1,0} multiply(multiply.120, broadcast.49)
  divide.159 = f32[128,128]{1,0} divide(multiply.158, broadcast.51)
  subtract.160 = f32[128,128]{1,0} subtract(add.157, divide.159)
  divide.161 = f32[128,128]{1,0} divide(multiply.121, broadcast.59)
  subtract.162 = f32[128,128]{1,0} subtract(subtract.160, divide.161)
  divide.163 = f32[128,128]{1,0} divide(multiply.122, broadcast.51)
  add.164 = f32[128,128]{1,0} add(subtract.162, divide.163)
  slice.192 = f32[128,128,1]{2,1,0} slice(reshape.118), slice={[0:128], [0:128], [3:4]}
  reshape.193 = f32[128,128]{1,0} reshape(slice.192)
  multiply.194 = f32[128,128]{1,0} multiply(add.164, reshape.193)
  add.195 = f32[128,128]{1,0} add(add.191, multiply.194)
  divide.165 = f32[128,128]{1,0} divide(subtract.92, broadcast.53)
  negate.166 = f32[128,128]{1,0} negate(divide.165)
  divide.167 = f32[128,128]{1,0} divide(multiply.119, broadcast.67)
  subtract.168 = f32[128,128]{1,0} subtract(negate.166, divide.167)
  multiply.169 = f32[128,128]{1,0} multiply(multiply.120, broadcast.49)
  divide.170 = f32[128,128]{1,0} divide(multiply.169, broadcast.67)
  add.171 = f32[128,128]{1,0} add(subtract.168, divide.170)
  divide.172 = f32[128,128]{1,0} divide(multiply.121, broadcast.67)
  add.173 = f32[128,128]{1,0} add(add.171, divide.172)
  divide.174 = f32[128,128]{1,0} divide(multiply.122, broadcast.67)
  subtract.175 = f32[128,128]{1,0} subtract(add.173, divide.174)
  slice.196 = f32[128,128,1]{2,1,0} slice(reshape.118), slice={[0:128], [0:128], [4:5]}
  reshape.197 = f32[128,128]{1,0} reshape(slice.196)
  multiply.198 = f32[128,128]{1,0} multiply(subtract.175, reshape.197)
  add.199 = f32[128,128]{1,0} add(add.195, multiply.198)
  constant.46 = f32[] constant(30)
  broadcast.47 = f32[128,128]{1,0} broadcast(constant.46), dimensions={}
  divide.176 = f32[128,128]{1,0} divide(subtract.92, broadcast.47)
  divide.177 = f32[128,128]{1,0} divide(multiply.120, broadcast.67)
  subtract.178 = f32[128,128]{1,0} subtract(divide.176, divide.177)
  divide.179 = f32[128,128]{1,0} divide(multiply.122, broadcast.65)
  add.180 = f32[128,128]{1,0} add(subtract.178, divide.179)
  slice.200 = f32[128,128,1]{2,1,0} slice(reshape.118), slice={[0:128], [0:128], [5:6]}
  reshape.201 = f32[128,128]{1,0} reshape(slice.200)
  multiply.202 = f32[128,128]{1,0} multiply(add.180, reshape.201)
  ROOT add.203 = f32[128,128]{1,0} add(add.199, multiply.202)
}

region_1.204 {
  Arg_0.205 = f32[] parameter(0)
  Arg_1.206 = f32[] parameter(1)
  ROOT add.207 = f32[] add(Arg_0.205, Arg_1.206)
}

fft.208 {
  Arg_0.209 = f32[128]{0} parameter(0)
  ROOT fft.210 = c64[65]{0} fft(Arg_0.209), fft_type=RFFT, fft_length={128}
}

fft_0.211 {
  Arg_0.212 = c64[65]{0} parameter(0)
  ROOT fft.213 = f32[128]{0} fft(Arg_0.212), fft_type=IRFFT, fft_length={128}
}

fft_0.214 {
  Arg_0.215 = c64[65]{0} parameter(0)
  ROOT fft.216 = f32[128]{0} fft(Arg_0.215), fft_type=IRFFT, fft_length={128}
}

solve_poisson.217 {
  Arg_0.218 = f32[128,128]{1,0} parameter(0)
  constant.225 = f32[] constant(0)
  reduce.226 = f32[128]{0} reduce(Arg_0.218, constant.225), dimensions={1}, to_apply=region_1.204
  Arg_2.220 = f32[] parameter(2)
  broadcast.227 = f32[128]{0} broadcast(Arg_2.220), dimensions={}
  multiply.228 = f32[128]{0} multiply(reduce.226, broadcast.227)
  constant.223 = f32[] constant(1)
  broadcast.224 = f32[128]{0} broadcast(constant.223), dimensions={}
  subtract.229 = f32[128]{0} subtract(multiply.228, broadcast.224)
  call.230 = c64[65]{0} call(subtract.229), to_apply=fft.208
  constant.221 = c64[] constant((-0, -1))
  broadcast.222 = c64[65]{0} broadcast(constant.221), dimensions={}
  multiply.231 = c64[65]{0} multiply(call.230, broadcast.222)
  Arg_1.219 = f32[65]{0} parameter(1)
  convert.232 = c64[65]{0} convert(Arg_1.219)
  multiply.233 = c64[65]{0} multiply(multiply.231, convert.232)
  call.234 = f32[128]{0} call(multiply.233), to_apply=fft_0.211
  multiply.235 = f32[65]{0} multiply(Arg_1.219, Arg_1.219)
  convert.236 = c64[65]{0} convert(multiply.235)
  multiply.237 = c64[65]{0} multiply(call.230, convert.236)
  call.238 = f32[128]{0} call(multiply.237), to_apply=fft_0.214
  ROOT tuple.239 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) tuple(call.234, subtract.229, call.238)
}

clip.240 {
  Arg_2.243 = s32[] parameter(2)
  broadcast.246 = s32[128,128,6]{2,1,0} broadcast(Arg_2.243), dimensions={}
  Arg_1.242 = s32[] parameter(1)
  broadcast.244 = s32[128,128,6]{2,1,0} broadcast(Arg_1.242), dimensions={}
  Arg_0.241 = s32[128,128,6]{2,1,0} parameter(0)
  maximum.245 = s32[128,128,6]{2,1,0} maximum(broadcast.244, Arg_0.241)
  ROOT minimum.247 = s32[128,128,6]{2,1,0} minimum(broadcast.246, maximum.245)
}

_where_2.248 {
  Arg_0.249 = pred[128,128,6]{2,1,0} parameter(0)
  Arg_1.250 = f32[128,128,6]{2,1,0} parameter(1)
  Arg_2.251 = f32[] parameter(2)
  broadcast.252 = f32[128,128,6]{2,1,0} broadcast(Arg_2.251), dimensions={}
  ROOT select.253 = f32[128,128,6]{2,1,0} select(Arg_0.249, Arg_1.250, broadcast.252)
}

advect_1d_vectorized_1.254 {
  iota.297 = f32[128]{0} iota(), iota_dimension=0
  reshape.303 = f32[1,128]{1,0} reshape(iota.297)
  broadcast.304 = f32[1,128]{1,0} broadcast(reshape.303), dimensions={0,1}
  reshape.305 = f32[128]{0} reshape(broadcast.304)
  broadcast.306 = f32[128,128]{1,0} broadcast(reshape.305), dimensions={1}
  Arg_1.256 = f32[128]{0} parameter(1)
  reshape.298 = f32[128,1]{1,0} reshape(Arg_1.256)
  Arg_2.257 = f32[] parameter(2)
  broadcast.299 = f32[128,1]{1,0} broadcast(Arg_2.257), dimensions={}
  multiply.300 = f32[128,1]{1,0} multiply(reshape.298, broadcast.299)
  Arg_3.258 = f32[] parameter(3)
  broadcast.301 = f32[128,1]{1,0} broadcast(Arg_3.258), dimensions={}
  divide.302 = f32[128,1]{1,0} divide(multiply.300, broadcast.301)
  broadcast.307 = f32[128,1]{1,0} broadcast(divide.302), dimensions={0,1}
  reshape.308 = f32[128]{0} reshape(broadcast.307)
  broadcast.309 = f32[128,128]{1,0} broadcast(reshape.308), dimensions={0}
  subtract.310 = f32[128,128]{1,0} subtract(broadcast.306, broadcast.309)
  floor.311 = f32[128,128]{1,0} floor(subtract.310)
  subtract.312 = f32[128,128]{1,0} subtract(subtract.310, floor.311)
  constant.282 = f32[] constant(20)
  broadcast.283 = f32[128,128]{1,0} broadcast(constant.282), dimensions={}
  divide.347 = f32[128,128]{1,0} divide(subtract.312, broadcast.283)
  multiply.343 = f32[128,128]{1,0} multiply(subtract.312, subtract.312)
  constant.280 = f32[] constant(24)
  broadcast.281 = f32[128,128]{1,0} broadcast(constant.280), dimensions={}
  divide.348 = f32[128,128]{1,0} divide(multiply.343, broadcast.281)
  subtract.349 = f32[128,128]{1,0} subtract(divide.347, divide.348)
  multiply.344 = f32[128,128]{1,0} multiply(multiply.343, subtract.312)
  divide.350 = f32[128,128]{1,0} divide(multiply.344, broadcast.281)
  subtract.351 = f32[128,128]{1,0} subtract(subtract.349, divide.350)
  multiply.345 = f32[128,128]{1,0} multiply(multiply.344, subtract.312)
  divide.352 = f32[128,128]{1,0} divide(multiply.345, broadcast.281)
  add.353 = f32[128,128]{1,0} add(subtract.351, divide.352)
  multiply.346 = f32[128,128]{1,0} multiply(multiply.345, subtract.312)
  constant.278 = f32[] constant(120)
  broadcast.279 = f32[128,128]{1,0} broadcast(constant.278), dimensions={}
  divide.354 = f32[128,128]{1,0} divide(multiply.346, broadcast.279)
  subtract.355 = f32[128,128]{1,0} subtract(add.353, divide.354)
  convert.313 = s32[128,128]{1,0} convert(floor.311)
  reshape.314 = s32[128,128,1]{2,1,0} reshape(convert.313)
  broadcast.316 = s32[128,128,1]{2,1,0} broadcast(reshape.314), dimensions={0,1,2}
  reshape.317 = s32[128,128]{1,0} reshape(broadcast.316)
  broadcast.318 = s32[128,128,6]{2,1,0} broadcast(reshape.317), dimensions={0,1}
  Arg_4.259 = s32[6]{0} parameter(4)
  reshape.315 = s32[1,1,6]{2,1,0} reshape(Arg_4.259)
  broadcast.319 = s32[1,1,6]{2,1,0} broadcast(reshape.315), dimensions={0,1,2}
  reshape.320 = s32[6]{0} reshape(broadcast.319)
  broadcast.321 = s32[128,128,6]{2,1,0} broadcast(reshape.320), dimensions={2}
  add.322 = s32[128,128,6]{2,1,0} add(broadcast.318, broadcast.321)
  constant.292 = s32[] constant(0)
  broadcast.293 = s32[128,128,6]{2,1,0} broadcast(constant.292), dimensions={}
  compare.323 = pred[128,128,6]{2,1,0} compare(add.322, broadcast.293), direction=GE
  constant.290 = s32[] constant(128)
  broadcast.291 = s32[128,128,6]{2,1,0} broadcast(constant.290), dimensions={}
  compare.324 = pred[128,128,6]{2,1,0} compare(add.322, broadcast.291), direction=LT
  and.325 = pred[128,128,6]{2,1,0} and(compare.323, compare.324)
  Arg_0.255 = f32[128,128]{1,0} parameter(0)
  reshape.334 = f32[16384]{0} reshape(Arg_0.255)
  iota.327 = s32[128]{0} iota(), iota_dimension=0
  reshape.328 = s32[128,1,1]{2,1,0} reshape(iota.327)
  constant.288 = s32[] constant(128)
  broadcast.289 = s32[128,1,1]{2,1,0} broadcast(constant.288), dimensions={}
  multiply.329 = s32[128,1,1]{2,1,0} multiply(reshape.328, broadcast.289)
  broadcast.330 = s32[128,1,1]{2,1,0} broadcast(multiply.329), dimensions={0,1,2}
  reshape.331 = s32[128]{0} reshape(broadcast.330)
  broadcast.332 = s32[128,128,6]{2,1,0} broadcast(reshape.331), dimensions={0}
  constant.296 = s32[] constant(0)
  constant.295 = s32[] constant(127)
  call.326 = s32[128,128,6]{2,1,0} call(add.322, constant.296, constant.295), to_apply=clip.240
  add.333 = s32[128,128,6]{2,1,0} add(broadcast.332, call.326)
  reshape.335 = s32[98304]{0} reshape(add.333)
  constant.286 = s32[] constant(0)
  broadcast.287 = s32[98304]{0} broadcast(constant.286), dimensions={}
  compare.336 = pred[98304]{0} compare(reshape.335, broadcast.287), direction=LT
  constant.284 = s32[] constant(16384)
  broadcast.285 = s32[98304]{0} broadcast(constant.284), dimensions={}
  add.337 = s32[98304]{0} add(reshape.335, broadcast.285)
  select.338 = s32[98304]{0} select(compare.336, add.337, reshape.335)
  reshape.339 = s32[98304,1]{1,0} reshape(select.338)
  gather.340 = f32[98304]{0} gather(reshape.334, reshape.339), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.341 = f32[128,128,6]{2,1,0} reshape(gather.340)
  constant.294 = f32[] constant(0)
  call.342 = f32[128,128,6]{2,1,0} call(and.325, reshape.341, constant.294), to_apply=_where_2.248
  slice.405 = f32[128,128,1]{2,1,0} slice(call.342), slice={[0:128], [0:128], [0:1]}
  reshape.406 = f32[128,128]{1,0} reshape(slice.405)
  multiply.407 = f32[128,128]{1,0} multiply(subtract.355, reshape.406)
  constant.276 = f32[] constant(2)
  broadcast.277 = f32[128,128]{1,0} broadcast(constant.276), dimensions={}
  divide.356 = f32[128,128]{1,0} divide(subtract.312, broadcast.277)
  negate.357 = f32[128,128]{1,0} negate(divide.356)
  multiply.358 = f32[128,128]{1,0} multiply(multiply.343, broadcast.277)
  constant.274 = f32[] constant(3)
  broadcast.275 = f32[128,128]{1,0} broadcast(constant.274), dimensions={}
  divide.359 = f32[128,128]{1,0} divide(multiply.358, broadcast.275)
  add.360 = f32[128,128]{1,0} add(negate.357, divide.359)
  divide.361 = f32[128,128]{1,0} divide(multiply.344, broadcast.281)
  subtract.362 = f32[128,128]{1,0} subtract(add.360, divide.361)
  constant.272 = f32[] constant(6)
  broadcast.273 = f32[128,128]{1,0} broadcast(constant.272), dimensions={}
  divide.363 = f32[128,128]{1,0} divide(multiply.345, broadcast.273)
  subtract.364 = f32[128,128]{1,0} subtract(subtract.362, divide.363)
  divide.365 = f32[128,128]{1,0} divide(multiply.346, broadcast.281)
  add.366 = f32[128,128]{1,0} add(subtract.364, divide.365)
  slice.408 = f32[128,128,1]{2,1,0} slice(call.342), slice={[0:128], [0:128], [1:2]}
  reshape.409 = f32[128,128]{1,0} reshape(slice.408)
  multiply.410 = f32[128,128]{1,0} multiply(add.366, reshape.409)
  add.411 = f32[128,128]{1,0} add(multiply.407, multiply.410)
  constant.270 = f32[] constant(1)
  broadcast.271 = f32[128,128]{1,0} broadcast(constant.270), dimensions={}
  divide.367 = f32[128,128]{1,0} divide(subtract.312, broadcast.275)
  subtract.368 = f32[128,128]{1,0} subtract(broadcast.271, divide.367)
  constant.268 = f32[] constant(5)
  broadcast.269 = f32[128,128]{1,0} broadcast(constant.268), dimensions={}
  multiply.369 = f32[128,128]{1,0} multiply(multiply.343, broadcast.269)
  constant.266 = f32[] constant(4)
  broadcast.267 = f32[128,128]{1,0} broadcast(constant.266), dimensions={}
  divide.370 = f32[128,128]{1,0} divide(multiply.369, broadcast.267)
  subtract.371 = f32[128,128]{1,0} subtract(subtract.368, divide.370)
  multiply.372 = f32[128,128]{1,0} multiply(multiply.344, broadcast.269)
  constant.264 = f32[] constant(12)
  broadcast.265 = f32[128,128]{1,0} broadcast(constant.264), dimensions={}
  divide.373 = f32[128,128]{1,0} divide(multiply.372, broadcast.265)
  add.374 = f32[128,128]{1,0} add(subtract.371, divide.373)
  divide.375 = f32[128,128]{1,0} divide(multiply.345, broadcast.267)
  add.376 = f32[128,128]{1,0} add(add.374, divide.375)
  divide.377 = f32[128,128]{1,0} divide(multiply.346, broadcast.265)
  subtract.378 = f32[128,128]{1,0} subtract(add.376, divide.377)
  slice.412 = f32[128,128,1]{2,1,0} slice(call.342), slice={[0:128], [0:128], [2:3]}
  reshape.413 = f32[128,128]{1,0} reshape(slice.412)
  multiply.414 = f32[128,128]{1,0} multiply(subtract.378, reshape.413)
  add.415 = f32[128,128]{1,0} add(add.411, multiply.414)
  multiply.379 = f32[128,128]{1,0} multiply(multiply.343, broadcast.277)
  divide.380 = f32[128,128]{1,0} divide(multiply.379, broadcast.275)
  add.381 = f32[128,128]{1,0} add(subtract.312, divide.380)
  constant.262 = f32[] constant(7)
  broadcast.263 = f32[128,128]{1,0} broadcast(constant.262), dimensions={}
  multiply.382 = f32[128,128]{1,0} multiply(multiply.344, broadcast.263)
  divide.383 = f32[128,128]{1,0} divide(multiply.382, broadcast.265)
  subtract.384 = f32[128,128]{1,0} subtract(add.381, divide.383)
  divide.385 = f32[128,128]{1,0} divide(multiply.345, broadcast.273)
  subtract.386 = f32[128,128]{1,0} subtract(subtract.384, divide.385)
  divide.387 = f32[128,128]{1,0} divide(multiply.346, broadcast.265)
  add.388 = f32[128,128]{1,0} add(subtract.386, divide.387)
  slice.416 = f32[128,128,1]{2,1,0} slice(call.342), slice={[0:128], [0:128], [3:4]}
  reshape.417 = f32[128,128]{1,0} reshape(slice.416)
  multiply.418 = f32[128,128]{1,0} multiply(add.388, reshape.417)
  add.419 = f32[128,128]{1,0} add(add.415, multiply.418)
  divide.389 = f32[128,128]{1,0} divide(subtract.312, broadcast.267)
  negate.390 = f32[128,128]{1,0} negate(divide.389)
  divide.391 = f32[128,128]{1,0} divide(multiply.343, broadcast.281)
  subtract.392 = f32[128,128]{1,0} subtract(negate.390, divide.391)
  multiply.393 = f32[128,128]{1,0} multiply(multiply.344, broadcast.263)
  divide.394 = f32[128,128]{1,0} divide(multiply.393, broadcast.281)
  add.395 = f32[128,128]{1,0} add(subtract.392, divide.394)
  divide.396 = f32[128,128]{1,0} divide(multiply.345, broadcast.281)
  add.397 = f32[128,128]{1,0} add(add.395, divide.396)
  divide.398 = f32[128,128]{1,0} divide(multiply.346, broadcast.281)
  subtract.399 = f32[128,128]{1,0} subtract(add.397, divide.398)
  slice.420 = f32[128,128,1]{2,1,0} slice(call.342), slice={[0:128], [0:128], [4:5]}
  reshape.421 = f32[128,128]{1,0} reshape(slice.420)
  multiply.422 = f32[128,128]{1,0} multiply(subtract.399, reshape.421)
  add.423 = f32[128,128]{1,0} add(add.419, multiply.422)
  constant.260 = f32[] constant(30)
  broadcast.261 = f32[128,128]{1,0} broadcast(constant.260), dimensions={}
  divide.400 = f32[128,128]{1,0} divide(subtract.312, broadcast.261)
  divide.401 = f32[128,128]{1,0} divide(multiply.344, broadcast.281)
  subtract.402 = f32[128,128]{1,0} subtract(divide.400, divide.401)
  divide.403 = f32[128,128]{1,0} divide(multiply.346, broadcast.279)
  add.404 = f32[128,128]{1,0} add(subtract.402, divide.403)
  slice.424 = f32[128,128,1]{2,1,0} slice(call.342), slice={[0:128], [0:128], [5:6]}
  reshape.425 = f32[128,128]{1,0} reshape(slice.424)
  multiply.426 = f32[128,128]{1,0} multiply(add.404, reshape.425)
  ROOT add.427 = f32[128,128]{1,0} add(add.423, multiply.426)
}

_where.428 {
  Arg_0.429 = pred[] parameter(0)
  Arg_1.430 = s32[] parameter(1)
  Arg_2.431 = s32[] parameter(2)
  ROOT select.432 = s32[] select(Arg_0.429, Arg_1.430, Arg_2.431)
}

remainder.433 {
  Arg_0.434 = s32[128,128,6]{2,1,0} parameter(0)
  Arg_1.435 = s32[] parameter(1)
  constant.439 = s32[] constant(0)
  compare.440 = pred[] compare(Arg_1.435, constant.439), direction=EQ
  constant.438 = s32[] constant(1)
  call.441 = s32[] call(compare.440, constant.438, Arg_1.435), to_apply=_where.428
  broadcast.442 = s32[128,128,6]{2,1,0} broadcast(call.441), dimensions={}
  remainder.443 = s32[128,128,6]{2,1,0} remainder(Arg_0.434, broadcast.442)
  constant.436 = s32[] constant(0)
  broadcast.437 = s32[128,128,6]{2,1,0} broadcast(constant.436), dimensions={}
  compare.445 = pred[128,128,6]{2,1,0} compare(remainder.443, broadcast.437), direction=LT
  compare.446 = pred[] compare(call.441, constant.439), direction=LT
  broadcast.447 = pred[128,128,6]{2,1,0} broadcast(compare.446), dimensions={}
  compare.448 = pred[128,128,6]{2,1,0} compare(compare.445, broadcast.447), direction=NE
  compare.444 = pred[128,128,6]{2,1,0} compare(remainder.443, broadcast.437), direction=NE
  and.449 = pred[128,128,6]{2,1,0} and(compare.448, compare.444)
  broadcast.450 = s32[128,128,6]{2,1,0} broadcast(call.441), dimensions={}
  add.451 = s32[128,128,6]{2,1,0} add(remainder.443, broadcast.450)
  ROOT select.452 = s32[128,128,6]{2,1,0} select(and.449, add.451, remainder.443)
}

advect_1d_vectorized.453 {
  iota.490 = f32[128]{0} iota(), iota_dimension=0
  reshape.496 = f32[1,128]{1,0} reshape(iota.490)
  broadcast.497 = f32[1,128]{1,0} broadcast(reshape.496), dimensions={0,1}
  reshape.498 = f32[128]{0} reshape(broadcast.497)
  broadcast.499 = f32[128,128]{1,0} broadcast(reshape.498), dimensions={1}
  Arg_1.455 = f32[128]{0} parameter(1)
  reshape.491 = f32[128,1]{1,0} reshape(Arg_1.455)
  Arg_2.456 = f32[] parameter(2)
  broadcast.492 = f32[128,1]{1,0} broadcast(Arg_2.456), dimensions={}
  multiply.493 = f32[128,1]{1,0} multiply(reshape.491, broadcast.492)
  Arg_3.457 = f32[] parameter(3)
  broadcast.494 = f32[128,1]{1,0} broadcast(Arg_3.457), dimensions={}
  divide.495 = f32[128,1]{1,0} divide(multiply.493, broadcast.494)
  broadcast.500 = f32[128,1]{1,0} broadcast(divide.495), dimensions={0,1}
  reshape.501 = f32[128]{0} reshape(broadcast.500)
  broadcast.502 = f32[128,128]{1,0} broadcast(reshape.501), dimensions={0}
  subtract.503 = f32[128,128]{1,0} subtract(broadcast.499, broadcast.502)
  floor.504 = f32[128,128]{1,0} floor(subtract.503)
  subtract.505 = f32[128,128]{1,0} subtract(subtract.503, floor.504)
  constant.481 = f32[] constant(20)
  broadcast.482 = f32[128,128]{1,0} broadcast(constant.481), dimensions={}
  divide.536 = f32[128,128]{1,0} divide(subtract.505, broadcast.482)
  multiply.532 = f32[128,128]{1,0} multiply(subtract.505, subtract.505)
  constant.479 = f32[] constant(24)
  broadcast.480 = f32[128,128]{1,0} broadcast(constant.479), dimensions={}
  divide.537 = f32[128,128]{1,0} divide(multiply.532, broadcast.480)
  subtract.538 = f32[128,128]{1,0} subtract(divide.536, divide.537)
  multiply.533 = f32[128,128]{1,0} multiply(multiply.532, subtract.505)
  divide.539 = f32[128,128]{1,0} divide(multiply.533, broadcast.480)
  subtract.540 = f32[128,128]{1,0} subtract(subtract.538, divide.539)
  multiply.534 = f32[128,128]{1,0} multiply(multiply.533, subtract.505)
  divide.541 = f32[128,128]{1,0} divide(multiply.534, broadcast.480)
  add.542 = f32[128,128]{1,0} add(subtract.540, divide.541)
  multiply.535 = f32[128,128]{1,0} multiply(multiply.534, subtract.505)
  constant.477 = f32[] constant(120)
  broadcast.478 = f32[128,128]{1,0} broadcast(constant.477), dimensions={}
  divide.543 = f32[128,128]{1,0} divide(multiply.535, broadcast.478)
  subtract.544 = f32[128,128]{1,0} subtract(add.542, divide.543)
  Arg_0.454 = f32[128,128]{1,0} parameter(0)
  reshape.524 = f32[16384]{0} reshape(Arg_0.454)
  iota.517 = s32[128]{0} iota(), iota_dimension=0
  reshape.518 = s32[128,1,1]{2,1,0} reshape(iota.517)
  constant.487 = s32[] constant(128)
  broadcast.488 = s32[128,1,1]{2,1,0} broadcast(constant.487), dimensions={}
  multiply.519 = s32[128,1,1]{2,1,0} multiply(reshape.518, broadcast.488)
  broadcast.520 = s32[128,1,1]{2,1,0} broadcast(multiply.519), dimensions={0,1,2}
  reshape.521 = s32[128]{0} reshape(broadcast.520)
  broadcast.522 = s32[128,128,6]{2,1,0} broadcast(reshape.521), dimensions={0}
  convert.506 = s32[128,128]{1,0} convert(floor.504)
  reshape.507 = s32[128,128,1]{2,1,0} reshape(convert.506)
  broadcast.509 = s32[128,128,1]{2,1,0} broadcast(reshape.507), dimensions={0,1,2}
  reshape.510 = s32[128,128]{1,0} reshape(broadcast.509)
  broadcast.511 = s32[128,128,6]{2,1,0} broadcast(reshape.510), dimensions={0,1}
  Arg_4.458 = s32[6]{0} parameter(4)
  reshape.508 = s32[1,1,6]{2,1,0} reshape(Arg_4.458)
  broadcast.512 = s32[1,1,6]{2,1,0} broadcast(reshape.508), dimensions={0,1,2}
  reshape.513 = s32[6]{0} reshape(broadcast.512)
  broadcast.514 = s32[128,128,6]{2,1,0} broadcast(reshape.513), dimensions={2}
  add.515 = s32[128,128,6]{2,1,0} add(broadcast.511, broadcast.514)
  constant.489 = s32[] constant(128)
  call.516 = s32[128,128,6]{2,1,0} call(add.515, constant.489), to_apply=remainder.433
  add.523 = s32[128,128,6]{2,1,0} add(broadcast.522, call.516)
  reshape.525 = s32[98304]{0} reshape(add.523)
  constant.485 = s32[] constant(0)
  broadcast.486 = s32[98304]{0} broadcast(constant.485), dimensions={}
  compare.526 = pred[98304]{0} compare(reshape.525, broadcast.486), direction=LT
  constant.483 = s32[] constant(16384)
  broadcast.484 = s32[98304]{0} broadcast(constant.483), dimensions={}
  add.527 = s32[98304]{0} add(reshape.525, broadcast.484)
  select.528 = s32[98304]{0} select(compare.526, add.527, reshape.525)
  reshape.529 = s32[98304,1]{1,0} reshape(select.528)
  gather.530 = f32[98304]{0} gather(reshape.524, reshape.529), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.531 = f32[128,128,6]{2,1,0} reshape(gather.530)
  slice.594 = f32[128,128,1]{2,1,0} slice(reshape.531), slice={[0:128], [0:128], [0:1]}
  reshape.595 = f32[128,128]{1,0} reshape(slice.594)
  multiply.596 = f32[128,128]{1,0} multiply(subtract.544, reshape.595)
  constant.475 = f32[] constant(2)
  broadcast.476 = f32[128,128]{1,0} broadcast(constant.475), dimensions={}
  divide.545 = f32[128,128]{1,0} divide(subtract.505, broadcast.476)
  negate.546 = f32[128,128]{1,0} negate(divide.545)
  multiply.547 = f32[128,128]{1,0} multiply(multiply.532, broadcast.476)
  constant.473 = f32[] constant(3)
  broadcast.474 = f32[128,128]{1,0} broadcast(constant.473), dimensions={}
  divide.548 = f32[128,128]{1,0} divide(multiply.547, broadcast.474)
  add.549 = f32[128,128]{1,0} add(negate.546, divide.548)
  divide.550 = f32[128,128]{1,0} divide(multiply.533, broadcast.480)
  subtract.551 = f32[128,128]{1,0} subtract(add.549, divide.550)
  constant.471 = f32[] constant(6)
  broadcast.472 = f32[128,128]{1,0} broadcast(constant.471), dimensions={}
  divide.552 = f32[128,128]{1,0} divide(multiply.534, broadcast.472)
  subtract.553 = f32[128,128]{1,0} subtract(subtract.551, divide.552)
  divide.554 = f32[128,128]{1,0} divide(multiply.535, broadcast.480)
  add.555 = f32[128,128]{1,0} add(subtract.553, divide.554)
  slice.597 = f32[128,128,1]{2,1,0} slice(reshape.531), slice={[0:128], [0:128], [1:2]}
  reshape.598 = f32[128,128]{1,0} reshape(slice.597)
  multiply.599 = f32[128,128]{1,0} multiply(add.555, reshape.598)
  add.600 = f32[128,128]{1,0} add(multiply.596, multiply.599)
  constant.469 = f32[] constant(1)
  broadcast.470 = f32[128,128]{1,0} broadcast(constant.469), dimensions={}
  divide.556 = f32[128,128]{1,0} divide(subtract.505, broadcast.474)
  subtract.557 = f32[128,128]{1,0} subtract(broadcast.470, divide.556)
  constant.467 = f32[] constant(5)
  broadcast.468 = f32[128,128]{1,0} broadcast(constant.467), dimensions={}
  multiply.558 = f32[128,128]{1,0} multiply(multiply.532, broadcast.468)
  constant.465 = f32[] constant(4)
  broadcast.466 = f32[128,128]{1,0} broadcast(constant.465), dimensions={}
  divide.559 = f32[128,128]{1,0} divide(multiply.558, broadcast.466)
  subtract.560 = f32[128,128]{1,0} subtract(subtract.557, divide.559)
  multiply.561 = f32[128,128]{1,0} multiply(multiply.533, broadcast.468)
  constant.463 = f32[] constant(12)
  broadcast.464 = f32[128,128]{1,0} broadcast(constant.463), dimensions={}
  divide.562 = f32[128,128]{1,0} divide(multiply.561, broadcast.464)
  add.563 = f32[128,128]{1,0} add(subtract.560, divide.562)
  divide.564 = f32[128,128]{1,0} divide(multiply.534, broadcast.466)
  add.565 = f32[128,128]{1,0} add(add.563, divide.564)
  divide.566 = f32[128,128]{1,0} divide(multiply.535, broadcast.464)
  subtract.567 = f32[128,128]{1,0} subtract(add.565, divide.566)
  slice.601 = f32[128,128,1]{2,1,0} slice(reshape.531), slice={[0:128], [0:128], [2:3]}
  reshape.602 = f32[128,128]{1,0} reshape(slice.601)
  multiply.603 = f32[128,128]{1,0} multiply(subtract.567, reshape.602)
  add.604 = f32[128,128]{1,0} add(add.600, multiply.603)
  multiply.568 = f32[128,128]{1,0} multiply(multiply.532, broadcast.476)
  divide.569 = f32[128,128]{1,0} divide(multiply.568, broadcast.474)
  add.570 = f32[128,128]{1,0} add(subtract.505, divide.569)
  constant.461 = f32[] constant(7)
  broadcast.462 = f32[128,128]{1,0} broadcast(constant.461), dimensions={}
  multiply.571 = f32[128,128]{1,0} multiply(multiply.533, broadcast.462)
  divide.572 = f32[128,128]{1,0} divide(multiply.571, broadcast.464)
  subtract.573 = f32[128,128]{1,0} subtract(add.570, divide.572)
  divide.574 = f32[128,128]{1,0} divide(multiply.534, broadcast.472)
  subtract.575 = f32[128,128]{1,0} subtract(subtract.573, divide.574)
  divide.576 = f32[128,128]{1,0} divide(multiply.535, broadcast.464)
  add.577 = f32[128,128]{1,0} add(subtract.575, divide.576)
  slice.605 = f32[128,128,1]{2,1,0} slice(reshape.531), slice={[0:128], [0:128], [3:4]}
  reshape.606 = f32[128,128]{1,0} reshape(slice.605)
  multiply.607 = f32[128,128]{1,0} multiply(add.577, reshape.606)
  add.608 = f32[128,128]{1,0} add(add.604, multiply.607)
  divide.578 = f32[128,128]{1,0} divide(subtract.505, broadcast.466)
  negate.579 = f32[128,128]{1,0} negate(divide.578)
  divide.580 = f32[128,128]{1,0} divide(multiply.532, broadcast.480)
  subtract.581 = f32[128,128]{1,0} subtract(negate.579, divide.580)
  multiply.582 = f32[128,128]{1,0} multiply(multiply.533, broadcast.462)
  divide.583 = f32[128,128]{1,0} divide(multiply.582, broadcast.480)
  add.584 = f32[128,128]{1,0} add(subtract.581, divide.583)
  divide.585 = f32[128,128]{1,0} divide(multiply.534, broadcast.480)
  add.586 = f32[128,128]{1,0} add(add.584, divide.585)
  divide.587 = f32[128,128]{1,0} divide(multiply.535, broadcast.480)
  subtract.588 = f32[128,128]{1,0} subtract(add.586, divide.587)
  slice.609 = f32[128,128,1]{2,1,0} slice(reshape.531), slice={[0:128], [0:128], [4:5]}
  reshape.610 = f32[128,128]{1,0} reshape(slice.609)
  multiply.611 = f32[128,128]{1,0} multiply(subtract.588, reshape.610)
  add.612 = f32[128,128]{1,0} add(add.608, multiply.611)
  constant.459 = f32[] constant(30)
  broadcast.460 = f32[128,128]{1,0} broadcast(constant.459), dimensions={}
  divide.589 = f32[128,128]{1,0} divide(subtract.505, broadcast.460)
  divide.590 = f32[128,128]{1,0} divide(multiply.533, broadcast.480)
  subtract.591 = f32[128,128]{1,0} subtract(divide.589, divide.590)
  divide.592 = f32[128,128]{1,0} divide(multiply.535, broadcast.478)
  add.593 = f32[128,128]{1,0} add(subtract.591, divide.592)
  slice.613 = f32[128,128,1]{2,1,0} slice(reshape.531), slice={[0:128], [0:128], [5:6]}
  reshape.614 = f32[128,128]{1,0} reshape(slice.613)
  multiply.615 = f32[128,128]{1,0} multiply(add.593, reshape.614)
  ROOT add.616 = f32[128,128]{1,0} add(add.612, multiply.615)
}

None.617 {
  Arg_4.622 = f32[128]{0} parameter(4)
  Arg_5.623 = f32[128]{0} parameter(5)
  Arg_3.621 = f32[128,128]{1,0} parameter(3)
  transpose.628 = f32[128,128]{0,1} transpose(Arg_3.621), dimensions={1,0}
  Arg_0.618 = f32[128]{0} parameter(0)
  constant.627 = f32[] constant(0.025)
  constant.626 = f32[] constant(0.0981747732)
  Arg_1.619 = s32[6]{0} parameter(1)
  call.629 = f32[128,128]{1,0} call(transpose.628, Arg_0.618, constant.627, constant.626, Arg_1.619), to_apply=advect_1d_vectorized.40
  transpose.630 = f32[128,128]{0,1} transpose(call.629), dimensions={1,0}
  Arg_2.620 = f32[65]{0} parameter(2)
  constant.625 = f32[] constant(0.0787401572)
  call.631 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) call(transpose.630, Arg_2.620, constant.625), to_apply=solve_poisson.217
  get-tuple-element.632 = f32[128]{0} get-tuple-element(call.631), index=0
  constant.624 = f32[] constant(0.05)
  call.635 = f32[128,128]{1,0} call(transpose.630, get-tuple-element.632, constant.624, constant.625, Arg_1.619), to_apply=advect_1d_vectorized_1.254
  transpose.636 = f32[128,128]{0,1} transpose(call.635), dimensions={1,0}
  call.637 = f32[128,128]{1,0} call(transpose.636, Arg_0.618, constant.627, constant.626, Arg_1.619), to_apply=advect_1d_vectorized.453
  transpose.638 = f32[128,128]{0,1} transpose(call.637), dimensions={1,0}
  get-tuple-element.633 = f32[128]{0} get-tuple-element(call.631), index=1
  get-tuple-element.634 = f32[128]{0} get-tuple-element(call.631), index=2
  ROOT tuple.639 = (f32[128,128]{0,1}, f32[128]{0}, f32[128]{0}) tuple(transpose.638, get-tuple-element.633, get-tuple-element.634)
}

region_0.640 {
  arg_tuple.641 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) parameter(0)
  get-tuple-element.642 = s32[] get-tuple-element(arg_tuple.641), index=0
  constant.646 = s32[] constant(1)
  add.654 = s32[] add(get-tuple-element.642, constant.646)
  constant.649 = f32[128]{0} constant({...})
  constant.648 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  constant.647 = f32[65]{0} constant({...})
  get-tuple-element.643 = f32[128,128]{1,0} get-tuple-element(arg_tuple.641), index=1
  get-tuple-element.644 = f32[128]{0} get-tuple-element(arg_tuple.641), index=2
  get-tuple-element.645 = f32[128]{0} get-tuple-element(arg_tuple.641), index=3
  call.650 = (f32[128,128]{0,1}, f32[128]{0}, f32[128]{0}) call(constant.649, constant.648, constant.647, get-tuple-element.643, get-tuple-element.644, get-tuple-element.645), to_apply=None.617
  get-tuple-element.651 = f32[128,128]{0,1} get-tuple-element(call.650), index=0
  get-tuple-element.652 = f32[128]{0} get-tuple-element(call.650), index=1
  get-tuple-element.653 = f32[128]{0} get-tuple-element(call.650), index=2
  ROOT tuple.655 = (s32[], f32[128,128]{0,1}, f32[128]{0}, f32[128]{0}) tuple(add.654, get-tuple-element.651, get-tuple-element.652, get-tuple-element.653)
}

region_2.656 {
  arg_tuple.657 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) parameter(0)
  get-tuple-element.659 = f32[128,128]{1,0} get-tuple-element(arg_tuple.657), index=1
  get-tuple-element.660 = f32[128]{0} get-tuple-element(arg_tuple.657), index=2
  get-tuple-element.661 = f32[128]{0} get-tuple-element(arg_tuple.657), index=3
  get-tuple-element.658 = s32[] get-tuple-element(arg_tuple.657), index=0
  constant.662 = s32[] constant(1000)
  ROOT compare.663 = pred[] compare(get-tuple-element.658, constant.662), direction=LT
}

ENTRY main.672 {
  constant.13 = s32[] constant(0)
  Arg_6.7 = f32[128,128]{1,0} parameter(6)
  Arg_4.5 = f32[128]{0} parameter(4)
  Arg_5.6 = f32[128]{0} parameter(5)
  tuple.14 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) tuple(constant.13, Arg_6.7, Arg_4.5, Arg_5.6)
  while.664 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) while(tuple.14), condition=region_2.656, body=region_0.640
  get-tuple-element.665 = s32[] get-tuple-element(while.664), index=0
  Arg_0.1 = f32[128]{0} parameter(0)
  Arg_1.2 = f32[128]{0} parameter(1)
  Arg_2.3 = f32[65]{0} parameter(2)
  Arg_3.4 = s32[6]{0} parameter(3)
  get-tuple-element.667 = f32[128]{0} get-tuple-element(while.664), index=2
  get-tuple-element.668 = f32[128]{0} get-tuple-element(while.664), index=3
  get-tuple-element.666 = f32[128,128]{1,0} get-tuple-element(while.664), index=1
  Arg_7.8 = f32[128]{0} parameter(7)
  Arg_8.9 = f32[] parameter(8)
  constant.11 = f32[] constant(50)
  add.669 = f32[] add(Arg_8.9, constant.11)
  Arg_9.10 = s32[] parameter(9)
  constant.12 = s32[] constant(1000)
  add.670 = s32[] add(Arg_9.10, constant.12)
  ROOT tuple.671 = (f32[128]{0}, f32[128]{0}, f32[65]{0}, s32[6]{0}, f32[128]{0}, /*index=5*/f32[128]{0}, f32[128,128]{1,0}, f32[128]{0}, f32[], s32[]) tuple(Arg_0.1, Arg_1.2, Arg_2.3, Arg_3.4, get-tuple-element.667, get-tuple-element.668, get-tuple-element.666, Arg_7.8, add.669, add.670)
}

