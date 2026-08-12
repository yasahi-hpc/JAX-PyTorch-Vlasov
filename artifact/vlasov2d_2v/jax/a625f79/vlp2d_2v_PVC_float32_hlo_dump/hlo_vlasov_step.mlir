HloModule jit__lambda_, entry_computation_layout={(f32[32,32,32,32]{3,2,1,0})->(f32[32,32,32,32]{0,3,2,1}, f32[32,32]{1,0}, f32[32,32]{1,0})}

_where.18 {
  Arg_0.19 = pred[] parameter(0)
  Arg_1.20 = s32[] parameter(1)
  Arg_2.21 = s32[] parameter(2)
  ROOT select.22 = s32[] select(Arg_0.19, Arg_1.20, Arg_2.21)
}

remainder.23 {
  Arg_0.24 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.25 = s32[] parameter(1)
  constant.29 = s32[] constant(0)
  compare.30 = pred[] compare(Arg_1.25, constant.29), direction=EQ
  constant.28 = s32[] constant(1)
  call.31 = s32[] call(compare.30, constant.28, Arg_1.25), to_apply=_where.18
  broadcast.32 = s32[32768,32,6]{2,1,0} broadcast(call.31), dimensions={}
  remainder.33 = s32[32768,32,6]{2,1,0} remainder(Arg_0.24, broadcast.32)
  constant.26 = s32[] constant(0)
  broadcast.27 = s32[32768,32,6]{2,1,0} broadcast(constant.26), dimensions={}
  compare.35 = pred[32768,32,6]{2,1,0} compare(remainder.33, broadcast.27), direction=LT
  compare.36 = pred[] compare(call.31, constant.29), direction=LT
  broadcast.37 = pred[32768,32,6]{2,1,0} broadcast(compare.36), dimensions={}
  compare.38 = pred[32768,32,6]{2,1,0} compare(compare.35, broadcast.37), direction=NE
  compare.34 = pred[32768,32,6]{2,1,0} compare(remainder.33, broadcast.27), direction=NE
  and.39 = pred[32768,32,6]{2,1,0} and(compare.38, compare.34)
  broadcast.40 = s32[32768,32,6]{2,1,0} broadcast(call.31), dimensions={}
  add.41 = s32[32768,32,6]{2,1,0} add(remainder.33, broadcast.40)
  ROOT select.42 = s32[32768,32,6]{2,1,0} select(and.39, add.41, remainder.33)
}

advect_1d_vectorized.43 {
  iota.80 = f32[32]{0} iota(), iota_dimension=0
  reshape.86 = f32[1,32]{1,0} reshape(iota.80)
  broadcast.87 = f32[1,32]{1,0} broadcast(reshape.86), dimensions={0,1}
  reshape.88 = f32[32]{0} reshape(broadcast.87)
  broadcast.89 = f32[32768,32]{1,0} broadcast(reshape.88), dimensions={1}
  Arg_1.45 = f32[32768]{0} parameter(1)
  reshape.81 = f32[32768,1]{1,0} reshape(Arg_1.45)
  Arg_2.46 = f32[] parameter(2)
  broadcast.82 = f32[32768,1]{1,0} broadcast(Arg_2.46), dimensions={}
  multiply.83 = f32[32768,1]{1,0} multiply(reshape.81, broadcast.82)
  Arg_3.47 = f32[] parameter(3)
  broadcast.84 = f32[32768,1]{1,0} broadcast(Arg_3.47), dimensions={}
  divide.85 = f32[32768,1]{1,0} divide(multiply.83, broadcast.84)
  broadcast.90 = f32[32768,1]{1,0} broadcast(divide.85), dimensions={0,1}
  reshape.91 = f32[32768]{0} reshape(broadcast.90)
  broadcast.92 = f32[32768,32]{1,0} broadcast(reshape.91), dimensions={0}
  subtract.93 = f32[32768,32]{1,0} subtract(broadcast.89, broadcast.92)
  floor.94 = f32[32768,32]{1,0} floor(subtract.93)
  subtract.95 = f32[32768,32]{1,0} subtract(subtract.93, floor.94)
  constant.71 = f32[] constant(20)
  broadcast.72 = f32[32768,32]{1,0} broadcast(constant.71), dimensions={}
  divide.126 = f32[32768,32]{1,0} divide(subtract.95, broadcast.72)
  multiply.122 = f32[32768,32]{1,0} multiply(subtract.95, subtract.95)
  constant.69 = f32[] constant(24)
  broadcast.70 = f32[32768,32]{1,0} broadcast(constant.69), dimensions={}
  divide.127 = f32[32768,32]{1,0} divide(multiply.122, broadcast.70)
  subtract.128 = f32[32768,32]{1,0} subtract(divide.126, divide.127)
  multiply.123 = f32[32768,32]{1,0} multiply(multiply.122, subtract.95)
  divide.129 = f32[32768,32]{1,0} divide(multiply.123, broadcast.70)
  subtract.130 = f32[32768,32]{1,0} subtract(subtract.128, divide.129)
  multiply.124 = f32[32768,32]{1,0} multiply(multiply.123, subtract.95)
  divide.131 = f32[32768,32]{1,0} divide(multiply.124, broadcast.70)
  add.132 = f32[32768,32]{1,0} add(subtract.130, divide.131)
  multiply.125 = f32[32768,32]{1,0} multiply(multiply.124, subtract.95)
  constant.67 = f32[] constant(120)
  broadcast.68 = f32[32768,32]{1,0} broadcast(constant.67), dimensions={}
  divide.133 = f32[32768,32]{1,0} divide(multiply.125, broadcast.68)
  subtract.134 = f32[32768,32]{1,0} subtract(add.132, divide.133)
  Arg_0.44 = f32[32768,32]{1,0} parameter(0)
  reshape.114 = f32[1048576]{0} reshape(Arg_0.44)
  iota.107 = s32[32768]{0} iota(), iota_dimension=0
  reshape.108 = s32[32768,1,1]{2,1,0} reshape(iota.107)
  constant.77 = s32[] constant(32)
  broadcast.78 = s32[32768,1,1]{2,1,0} broadcast(constant.77), dimensions={}
  multiply.109 = s32[32768,1,1]{2,1,0} multiply(reshape.108, broadcast.78)
  broadcast.110 = s32[32768,1,1]{2,1,0} broadcast(multiply.109), dimensions={0,1,2}
  reshape.111 = s32[32768]{0} reshape(broadcast.110)
  broadcast.112 = s32[32768,32,6]{2,1,0} broadcast(reshape.111), dimensions={0}
  convert.96 = s32[32768,32]{1,0} convert(floor.94)
  reshape.97 = s32[32768,32,1]{2,1,0} reshape(convert.96)
  broadcast.99 = s32[32768,32,1]{2,1,0} broadcast(reshape.97), dimensions={0,1,2}
  reshape.100 = s32[32768,32]{1,0} reshape(broadcast.99)
  broadcast.101 = s32[32768,32,6]{2,1,0} broadcast(reshape.100), dimensions={0,1}
  Arg_4.48 = s32[6]{0} parameter(4)
  reshape.98 = s32[1,1,6]{2,1,0} reshape(Arg_4.48)
  broadcast.102 = s32[1,1,6]{2,1,0} broadcast(reshape.98), dimensions={0,1,2}
  reshape.103 = s32[6]{0} reshape(broadcast.102)
  broadcast.104 = s32[32768,32,6]{2,1,0} broadcast(reshape.103), dimensions={2}
  add.105 = s32[32768,32,6]{2,1,0} add(broadcast.101, broadcast.104)
  constant.79 = s32[] constant(32)
  call.106 = s32[32768,32,6]{2,1,0} call(add.105, constant.79), to_apply=remainder.23
  add.113 = s32[32768,32,6]{2,1,0} add(broadcast.112, call.106)
  reshape.115 = s32[6291456]{0} reshape(add.113)
  constant.75 = s32[] constant(0)
  broadcast.76 = s32[6291456]{0} broadcast(constant.75), dimensions={}
  compare.116 = pred[6291456]{0} compare(reshape.115, broadcast.76), direction=LT
  constant.73 = s32[] constant(1048576)
  broadcast.74 = s32[6291456]{0} broadcast(constant.73), dimensions={}
  add.117 = s32[6291456]{0} add(reshape.115, broadcast.74)
  select.118 = s32[6291456]{0} select(compare.116, add.117, reshape.115)
  reshape.119 = s32[6291456,1]{1,0} reshape(select.118)
  gather.120 = f32[6291456]{0} gather(reshape.114, reshape.119), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.121 = f32[32768,32,6]{2,1,0} reshape(gather.120)
  slice.184 = f32[32768,32,1]{2,1,0} slice(reshape.121), slice={[0:32768], [0:32], [0:1]}
  reshape.185 = f32[32768,32]{1,0} reshape(slice.184)
  multiply.186 = f32[32768,32]{1,0} multiply(subtract.134, reshape.185)
  constant.65 = f32[] constant(2)
  broadcast.66 = f32[32768,32]{1,0} broadcast(constant.65), dimensions={}
  divide.135 = f32[32768,32]{1,0} divide(subtract.95, broadcast.66)
  negate.136 = f32[32768,32]{1,0} negate(divide.135)
  multiply.137 = f32[32768,32]{1,0} multiply(multiply.122, broadcast.66)
  constant.63 = f32[] constant(3)
  broadcast.64 = f32[32768,32]{1,0} broadcast(constant.63), dimensions={}
  divide.138 = f32[32768,32]{1,0} divide(multiply.137, broadcast.64)
  add.139 = f32[32768,32]{1,0} add(negate.136, divide.138)
  divide.140 = f32[32768,32]{1,0} divide(multiply.123, broadcast.70)
  subtract.141 = f32[32768,32]{1,0} subtract(add.139, divide.140)
  constant.61 = f32[] constant(6)
  broadcast.62 = f32[32768,32]{1,0} broadcast(constant.61), dimensions={}
  divide.142 = f32[32768,32]{1,0} divide(multiply.124, broadcast.62)
  subtract.143 = f32[32768,32]{1,0} subtract(subtract.141, divide.142)
  divide.144 = f32[32768,32]{1,0} divide(multiply.125, broadcast.70)
  add.145 = f32[32768,32]{1,0} add(subtract.143, divide.144)
  slice.187 = f32[32768,32,1]{2,1,0} slice(reshape.121), slice={[0:32768], [0:32], [1:2]}
  reshape.188 = f32[32768,32]{1,0} reshape(slice.187)
  multiply.189 = f32[32768,32]{1,0} multiply(add.145, reshape.188)
  add.190 = f32[32768,32]{1,0} add(multiply.186, multiply.189)
  constant.59 = f32[] constant(1)
  broadcast.60 = f32[32768,32]{1,0} broadcast(constant.59), dimensions={}
  divide.146 = f32[32768,32]{1,0} divide(subtract.95, broadcast.64)
  subtract.147 = f32[32768,32]{1,0} subtract(broadcast.60, divide.146)
  constant.57 = f32[] constant(5)
  broadcast.58 = f32[32768,32]{1,0} broadcast(constant.57), dimensions={}
  multiply.148 = f32[32768,32]{1,0} multiply(multiply.122, broadcast.58)
  constant.55 = f32[] constant(4)
  broadcast.56 = f32[32768,32]{1,0} broadcast(constant.55), dimensions={}
  divide.149 = f32[32768,32]{1,0} divide(multiply.148, broadcast.56)
  subtract.150 = f32[32768,32]{1,0} subtract(subtract.147, divide.149)
  multiply.151 = f32[32768,32]{1,0} multiply(multiply.123, broadcast.58)
  constant.53 = f32[] constant(12)
  broadcast.54 = f32[32768,32]{1,0} broadcast(constant.53), dimensions={}
  divide.152 = f32[32768,32]{1,0} divide(multiply.151, broadcast.54)
  add.153 = f32[32768,32]{1,0} add(subtract.150, divide.152)
  divide.154 = f32[32768,32]{1,0} divide(multiply.124, broadcast.56)
  add.155 = f32[32768,32]{1,0} add(add.153, divide.154)
  divide.156 = f32[32768,32]{1,0} divide(multiply.125, broadcast.54)
  subtract.157 = f32[32768,32]{1,0} subtract(add.155, divide.156)
  slice.191 = f32[32768,32,1]{2,1,0} slice(reshape.121), slice={[0:32768], [0:32], [2:3]}
  reshape.192 = f32[32768,32]{1,0} reshape(slice.191)
  multiply.193 = f32[32768,32]{1,0} multiply(subtract.157, reshape.192)
  add.194 = f32[32768,32]{1,0} add(add.190, multiply.193)
  multiply.158 = f32[32768,32]{1,0} multiply(multiply.122, broadcast.66)
  divide.159 = f32[32768,32]{1,0} divide(multiply.158, broadcast.64)
  add.160 = f32[32768,32]{1,0} add(subtract.95, divide.159)
  constant.51 = f32[] constant(7)
  broadcast.52 = f32[32768,32]{1,0} broadcast(constant.51), dimensions={}
  multiply.161 = f32[32768,32]{1,0} multiply(multiply.123, broadcast.52)
  divide.162 = f32[32768,32]{1,0} divide(multiply.161, broadcast.54)
  subtract.163 = f32[32768,32]{1,0} subtract(add.160, divide.162)
  divide.164 = f32[32768,32]{1,0} divide(multiply.124, broadcast.62)
  subtract.165 = f32[32768,32]{1,0} subtract(subtract.163, divide.164)
  divide.166 = f32[32768,32]{1,0} divide(multiply.125, broadcast.54)
  add.167 = f32[32768,32]{1,0} add(subtract.165, divide.166)
  slice.195 = f32[32768,32,1]{2,1,0} slice(reshape.121), slice={[0:32768], [0:32], [3:4]}
  reshape.196 = f32[32768,32]{1,0} reshape(slice.195)
  multiply.197 = f32[32768,32]{1,0} multiply(add.167, reshape.196)
  add.198 = f32[32768,32]{1,0} add(add.194, multiply.197)
  divide.168 = f32[32768,32]{1,0} divide(subtract.95, broadcast.56)
  negate.169 = f32[32768,32]{1,0} negate(divide.168)
  divide.170 = f32[32768,32]{1,0} divide(multiply.122, broadcast.70)
  subtract.171 = f32[32768,32]{1,0} subtract(negate.169, divide.170)
  multiply.172 = f32[32768,32]{1,0} multiply(multiply.123, broadcast.52)
  divide.173 = f32[32768,32]{1,0} divide(multiply.172, broadcast.70)
  add.174 = f32[32768,32]{1,0} add(subtract.171, divide.173)
  divide.175 = f32[32768,32]{1,0} divide(multiply.124, broadcast.70)
  add.176 = f32[32768,32]{1,0} add(add.174, divide.175)
  divide.177 = f32[32768,32]{1,0} divide(multiply.125, broadcast.70)
  subtract.178 = f32[32768,32]{1,0} subtract(add.176, divide.177)
  slice.199 = f32[32768,32,1]{2,1,0} slice(reshape.121), slice={[0:32768], [0:32], [4:5]}
  reshape.200 = f32[32768,32]{1,0} reshape(slice.199)
  multiply.201 = f32[32768,32]{1,0} multiply(subtract.178, reshape.200)
  add.202 = f32[32768,32]{1,0} add(add.198, multiply.201)
  constant.49 = f32[] constant(30)
  broadcast.50 = f32[32768,32]{1,0} broadcast(constant.49), dimensions={}
  divide.179 = f32[32768,32]{1,0} divide(subtract.95, broadcast.50)
  divide.180 = f32[32768,32]{1,0} divide(multiply.123, broadcast.70)
  subtract.181 = f32[32768,32]{1,0} subtract(divide.179, divide.180)
  divide.182 = f32[32768,32]{1,0} divide(multiply.125, broadcast.68)
  add.183 = f32[32768,32]{1,0} add(subtract.181, divide.182)
  slice.203 = f32[32768,32,1]{2,1,0} slice(reshape.121), slice={[0:32768], [0:32], [5:6]}
  reshape.204 = f32[32768,32]{1,0} reshape(slice.203)
  multiply.205 = f32[32768,32]{1,0} multiply(add.183, reshape.204)
  ROOT add.206 = f32[32768,32]{1,0} add(add.202, multiply.205)
}

_where.215 {
  Arg_0.216 = pred[] parameter(0)
  Arg_1.217 = s32[] parameter(1)
  Arg_2.218 = s32[] parameter(2)
  ROOT select.219 = s32[] select(Arg_0.216, Arg_1.217, Arg_2.218)
}

remainder.220 {
  Arg_0.221 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.222 = s32[] parameter(1)
  constant.226 = s32[] constant(0)
  compare.227 = pred[] compare(Arg_1.222, constant.226), direction=EQ
  constant.225 = s32[] constant(1)
  call.228 = s32[] call(compare.227, constant.225, Arg_1.222), to_apply=_where.215
  broadcast.229 = s32[32768,32,6]{2,1,0} broadcast(call.228), dimensions={}
  remainder.230 = s32[32768,32,6]{2,1,0} remainder(Arg_0.221, broadcast.229)
  constant.223 = s32[] constant(0)
  broadcast.224 = s32[32768,32,6]{2,1,0} broadcast(constant.223), dimensions={}
  compare.232 = pred[32768,32,6]{2,1,0} compare(remainder.230, broadcast.224), direction=LT
  compare.233 = pred[] compare(call.228, constant.226), direction=LT
  broadcast.234 = pred[32768,32,6]{2,1,0} broadcast(compare.233), dimensions={}
  compare.235 = pred[32768,32,6]{2,1,0} compare(compare.232, broadcast.234), direction=NE
  compare.231 = pred[32768,32,6]{2,1,0} compare(remainder.230, broadcast.224), direction=NE
  and.236 = pred[32768,32,6]{2,1,0} and(compare.235, compare.231)
  broadcast.237 = s32[32768,32,6]{2,1,0} broadcast(call.228), dimensions={}
  add.238 = s32[32768,32,6]{2,1,0} add(remainder.230, broadcast.237)
  ROOT select.239 = s32[32768,32,6]{2,1,0} select(and.236, add.238, remainder.230)
}

advect_1d_vectorized.240 {
  iota.277 = f32[32]{0} iota(), iota_dimension=0
  reshape.283 = f32[1,32]{1,0} reshape(iota.277)
  broadcast.284 = f32[1,32]{1,0} broadcast(reshape.283), dimensions={0,1}
  reshape.285 = f32[32]{0} reshape(broadcast.284)
  broadcast.286 = f32[32768,32]{1,0} broadcast(reshape.285), dimensions={1}
  Arg_1.242 = f32[32768]{0} parameter(1)
  reshape.278 = f32[32768,1]{1,0} reshape(Arg_1.242)
  Arg_2.243 = f32[] parameter(2)
  broadcast.279 = f32[32768,1]{1,0} broadcast(Arg_2.243), dimensions={}
  multiply.280 = f32[32768,1]{1,0} multiply(reshape.278, broadcast.279)
  Arg_3.244 = f32[] parameter(3)
  broadcast.281 = f32[32768,1]{1,0} broadcast(Arg_3.244), dimensions={}
  divide.282 = f32[32768,1]{1,0} divide(multiply.280, broadcast.281)
  broadcast.287 = f32[32768,1]{1,0} broadcast(divide.282), dimensions={0,1}
  reshape.288 = f32[32768]{0} reshape(broadcast.287)
  broadcast.289 = f32[32768,32]{1,0} broadcast(reshape.288), dimensions={0}
  subtract.290 = f32[32768,32]{1,0} subtract(broadcast.286, broadcast.289)
  floor.291 = f32[32768,32]{1,0} floor(subtract.290)
  subtract.292 = f32[32768,32]{1,0} subtract(subtract.290, floor.291)
  constant.268 = f32[] constant(20)
  broadcast.269 = f32[32768,32]{1,0} broadcast(constant.268), dimensions={}
  divide.323 = f32[32768,32]{1,0} divide(subtract.292, broadcast.269)
  multiply.319 = f32[32768,32]{1,0} multiply(subtract.292, subtract.292)
  constant.266 = f32[] constant(24)
  broadcast.267 = f32[32768,32]{1,0} broadcast(constant.266), dimensions={}
  divide.324 = f32[32768,32]{1,0} divide(multiply.319, broadcast.267)
  subtract.325 = f32[32768,32]{1,0} subtract(divide.323, divide.324)
  multiply.320 = f32[32768,32]{1,0} multiply(multiply.319, subtract.292)
  divide.326 = f32[32768,32]{1,0} divide(multiply.320, broadcast.267)
  subtract.327 = f32[32768,32]{1,0} subtract(subtract.325, divide.326)
  multiply.321 = f32[32768,32]{1,0} multiply(multiply.320, subtract.292)
  divide.328 = f32[32768,32]{1,0} divide(multiply.321, broadcast.267)
  add.329 = f32[32768,32]{1,0} add(subtract.327, divide.328)
  multiply.322 = f32[32768,32]{1,0} multiply(multiply.321, subtract.292)
  constant.264 = f32[] constant(120)
  broadcast.265 = f32[32768,32]{1,0} broadcast(constant.264), dimensions={}
  divide.330 = f32[32768,32]{1,0} divide(multiply.322, broadcast.265)
  subtract.331 = f32[32768,32]{1,0} subtract(add.329, divide.330)
  Arg_0.241 = f32[32768,32]{1,0} parameter(0)
  reshape.311 = f32[1048576]{0} reshape(Arg_0.241)
  iota.304 = s32[32768]{0} iota(), iota_dimension=0
  reshape.305 = s32[32768,1,1]{2,1,0} reshape(iota.304)
  constant.274 = s32[] constant(32)
  broadcast.275 = s32[32768,1,1]{2,1,0} broadcast(constant.274), dimensions={}
  multiply.306 = s32[32768,1,1]{2,1,0} multiply(reshape.305, broadcast.275)
  broadcast.307 = s32[32768,1,1]{2,1,0} broadcast(multiply.306), dimensions={0,1,2}
  reshape.308 = s32[32768]{0} reshape(broadcast.307)
  broadcast.309 = s32[32768,32,6]{2,1,0} broadcast(reshape.308), dimensions={0}
  convert.293 = s32[32768,32]{1,0} convert(floor.291)
  reshape.294 = s32[32768,32,1]{2,1,0} reshape(convert.293)
  broadcast.296 = s32[32768,32,1]{2,1,0} broadcast(reshape.294), dimensions={0,1,2}
  reshape.297 = s32[32768,32]{1,0} reshape(broadcast.296)
  broadcast.298 = s32[32768,32,6]{2,1,0} broadcast(reshape.297), dimensions={0,1}
  Arg_4.245 = s32[6]{0} parameter(4)
  reshape.295 = s32[1,1,6]{2,1,0} reshape(Arg_4.245)
  broadcast.299 = s32[1,1,6]{2,1,0} broadcast(reshape.295), dimensions={0,1,2}
  reshape.300 = s32[6]{0} reshape(broadcast.299)
  broadcast.301 = s32[32768,32,6]{2,1,0} broadcast(reshape.300), dimensions={2}
  add.302 = s32[32768,32,6]{2,1,0} add(broadcast.298, broadcast.301)
  constant.276 = s32[] constant(32)
  call.303 = s32[32768,32,6]{2,1,0} call(add.302, constant.276), to_apply=remainder.220
  add.310 = s32[32768,32,6]{2,1,0} add(broadcast.309, call.303)
  reshape.312 = s32[6291456]{0} reshape(add.310)
  constant.272 = s32[] constant(0)
  broadcast.273 = s32[6291456]{0} broadcast(constant.272), dimensions={}
  compare.313 = pred[6291456]{0} compare(reshape.312, broadcast.273), direction=LT
  constant.270 = s32[] constant(1048576)
  broadcast.271 = s32[6291456]{0} broadcast(constant.270), dimensions={}
  add.314 = s32[6291456]{0} add(reshape.312, broadcast.271)
  select.315 = s32[6291456]{0} select(compare.313, add.314, reshape.312)
  reshape.316 = s32[6291456,1]{1,0} reshape(select.315)
  gather.317 = f32[6291456]{0} gather(reshape.311, reshape.316), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.318 = f32[32768,32,6]{2,1,0} reshape(gather.317)
  slice.381 = f32[32768,32,1]{2,1,0} slice(reshape.318), slice={[0:32768], [0:32], [0:1]}
  reshape.382 = f32[32768,32]{1,0} reshape(slice.381)
  multiply.383 = f32[32768,32]{1,0} multiply(subtract.331, reshape.382)
  constant.262 = f32[] constant(2)
  broadcast.263 = f32[32768,32]{1,0} broadcast(constant.262), dimensions={}
  divide.332 = f32[32768,32]{1,0} divide(subtract.292, broadcast.263)
  negate.333 = f32[32768,32]{1,0} negate(divide.332)
  multiply.334 = f32[32768,32]{1,0} multiply(multiply.319, broadcast.263)
  constant.260 = f32[] constant(3)
  broadcast.261 = f32[32768,32]{1,0} broadcast(constant.260), dimensions={}
  divide.335 = f32[32768,32]{1,0} divide(multiply.334, broadcast.261)
  add.336 = f32[32768,32]{1,0} add(negate.333, divide.335)
  divide.337 = f32[32768,32]{1,0} divide(multiply.320, broadcast.267)
  subtract.338 = f32[32768,32]{1,0} subtract(add.336, divide.337)
  constant.258 = f32[] constant(6)
  broadcast.259 = f32[32768,32]{1,0} broadcast(constant.258), dimensions={}
  divide.339 = f32[32768,32]{1,0} divide(multiply.321, broadcast.259)
  subtract.340 = f32[32768,32]{1,0} subtract(subtract.338, divide.339)
  divide.341 = f32[32768,32]{1,0} divide(multiply.322, broadcast.267)
  add.342 = f32[32768,32]{1,0} add(subtract.340, divide.341)
  slice.384 = f32[32768,32,1]{2,1,0} slice(reshape.318), slice={[0:32768], [0:32], [1:2]}
  reshape.385 = f32[32768,32]{1,0} reshape(slice.384)
  multiply.386 = f32[32768,32]{1,0} multiply(add.342, reshape.385)
  add.387 = f32[32768,32]{1,0} add(multiply.383, multiply.386)
  constant.256 = f32[] constant(1)
  broadcast.257 = f32[32768,32]{1,0} broadcast(constant.256), dimensions={}
  divide.343 = f32[32768,32]{1,0} divide(subtract.292, broadcast.261)
  subtract.344 = f32[32768,32]{1,0} subtract(broadcast.257, divide.343)
  constant.254 = f32[] constant(5)
  broadcast.255 = f32[32768,32]{1,0} broadcast(constant.254), dimensions={}
  multiply.345 = f32[32768,32]{1,0} multiply(multiply.319, broadcast.255)
  constant.252 = f32[] constant(4)
  broadcast.253 = f32[32768,32]{1,0} broadcast(constant.252), dimensions={}
  divide.346 = f32[32768,32]{1,0} divide(multiply.345, broadcast.253)
  subtract.347 = f32[32768,32]{1,0} subtract(subtract.344, divide.346)
  multiply.348 = f32[32768,32]{1,0} multiply(multiply.320, broadcast.255)
  constant.250 = f32[] constant(12)
  broadcast.251 = f32[32768,32]{1,0} broadcast(constant.250), dimensions={}
  divide.349 = f32[32768,32]{1,0} divide(multiply.348, broadcast.251)
  add.350 = f32[32768,32]{1,0} add(subtract.347, divide.349)
  divide.351 = f32[32768,32]{1,0} divide(multiply.321, broadcast.253)
  add.352 = f32[32768,32]{1,0} add(add.350, divide.351)
  divide.353 = f32[32768,32]{1,0} divide(multiply.322, broadcast.251)
  subtract.354 = f32[32768,32]{1,0} subtract(add.352, divide.353)
  slice.388 = f32[32768,32,1]{2,1,0} slice(reshape.318), slice={[0:32768], [0:32], [2:3]}
  reshape.389 = f32[32768,32]{1,0} reshape(slice.388)
  multiply.390 = f32[32768,32]{1,0} multiply(subtract.354, reshape.389)
  add.391 = f32[32768,32]{1,0} add(add.387, multiply.390)
  multiply.355 = f32[32768,32]{1,0} multiply(multiply.319, broadcast.263)
  divide.356 = f32[32768,32]{1,0} divide(multiply.355, broadcast.261)
  add.357 = f32[32768,32]{1,0} add(subtract.292, divide.356)
  constant.248 = f32[] constant(7)
  broadcast.249 = f32[32768,32]{1,0} broadcast(constant.248), dimensions={}
  multiply.358 = f32[32768,32]{1,0} multiply(multiply.320, broadcast.249)
  divide.359 = f32[32768,32]{1,0} divide(multiply.358, broadcast.251)
  subtract.360 = f32[32768,32]{1,0} subtract(add.357, divide.359)
  divide.361 = f32[32768,32]{1,0} divide(multiply.321, broadcast.259)
  subtract.362 = f32[32768,32]{1,0} subtract(subtract.360, divide.361)
  divide.363 = f32[32768,32]{1,0} divide(multiply.322, broadcast.251)
  add.364 = f32[32768,32]{1,0} add(subtract.362, divide.363)
  slice.392 = f32[32768,32,1]{2,1,0} slice(reshape.318), slice={[0:32768], [0:32], [3:4]}
  reshape.393 = f32[32768,32]{1,0} reshape(slice.392)
  multiply.394 = f32[32768,32]{1,0} multiply(add.364, reshape.393)
  add.395 = f32[32768,32]{1,0} add(add.391, multiply.394)
  divide.365 = f32[32768,32]{1,0} divide(subtract.292, broadcast.253)
  negate.366 = f32[32768,32]{1,0} negate(divide.365)
  divide.367 = f32[32768,32]{1,0} divide(multiply.319, broadcast.267)
  subtract.368 = f32[32768,32]{1,0} subtract(negate.366, divide.367)
  multiply.369 = f32[32768,32]{1,0} multiply(multiply.320, broadcast.249)
  divide.370 = f32[32768,32]{1,0} divide(multiply.369, broadcast.267)
  add.371 = f32[32768,32]{1,0} add(subtract.368, divide.370)
  divide.372 = f32[32768,32]{1,0} divide(multiply.321, broadcast.267)
  add.373 = f32[32768,32]{1,0} add(add.371, divide.372)
  divide.374 = f32[32768,32]{1,0} divide(multiply.322, broadcast.267)
  subtract.375 = f32[32768,32]{1,0} subtract(add.373, divide.374)
  slice.396 = f32[32768,32,1]{2,1,0} slice(reshape.318), slice={[0:32768], [0:32], [4:5]}
  reshape.397 = f32[32768,32]{1,0} reshape(slice.396)
  multiply.398 = f32[32768,32]{1,0} multiply(subtract.375, reshape.397)
  add.399 = f32[32768,32]{1,0} add(add.395, multiply.398)
  constant.246 = f32[] constant(30)
  broadcast.247 = f32[32768,32]{1,0} broadcast(constant.246), dimensions={}
  divide.376 = f32[32768,32]{1,0} divide(subtract.292, broadcast.247)
  divide.377 = f32[32768,32]{1,0} divide(multiply.320, broadcast.267)
  subtract.378 = f32[32768,32]{1,0} subtract(divide.376, divide.377)
  divide.379 = f32[32768,32]{1,0} divide(multiply.322, broadcast.265)
  add.380 = f32[32768,32]{1,0} add(subtract.378, divide.379)
  slice.400 = f32[32768,32,1]{2,1,0} slice(reshape.318), slice={[0:32768], [0:32], [5:6]}
  reshape.401 = f32[32768,32]{1,0} reshape(slice.400)
  multiply.402 = f32[32768,32]{1,0} multiply(add.380, reshape.401)
  ROOT add.403 = f32[32768,32]{1,0} add(add.399, multiply.402)
}

region_0.407 {
  Arg_0.408 = f32[] parameter(0)
  Arg_1.409 = f32[] parameter(1)
  ROOT add.410 = f32[] add(Arg_0.408, Arg_1.409)
}

fft.411 {
  Arg_0.412 = f32[32,32]{1,0} parameter(0)
  ROOT fft.413 = c64[32,17]{1,0} fft(Arg_0.412), fft_type=RFFT, fft_length={32,32}
}

fft_0.414 {
  Arg_0.415 = c64[32,17]{1,0} parameter(0)
  ROOT fft.416 = f32[32,32]{1,0} fft(Arg_0.415), fft_type=IRFFT, fft_length={32,32}
}

fft_0.417 {
  Arg_0.418 = c64[32,17]{1,0} parameter(0)
  ROOT fft.419 = f32[32,32]{1,0} fft(Arg_0.418), fft_type=IRFFT, fft_length={32,32}
}

fft_0.420 {
  Arg_0.421 = c64[32,17]{1,0} parameter(0)
  ROOT fft.422 = f32[32,32]{1,0} fft(Arg_0.421), fft_type=IRFFT, fft_length={32,32}
}

solve_poisson.423 {
  Arg_1.425 = f32[32,1]{1,0} parameter(1)
  convert.447 = c64[32,1]{1,0} convert(Arg_1.425)
  constant.432 = c64[] constant((-0, -1))
  broadcast.433 = c64[32,1]{1,0} broadcast(constant.432), dimensions={}
  multiply.448 = c64[32,1]{1,0} multiply(convert.447, broadcast.433)
  broadcast.449 = c64[32,1]{1,0} broadcast(multiply.448), dimensions={0,1}
  reshape.450 = c64[32]{0} reshape(broadcast.449)
  broadcast.451 = c64[32,17]{1,0} broadcast(reshape.450), dimensions={0}
  Arg_0.424 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  constant.436 = f32[] constant(0)
  reduce.437 = f32[32,32]{1,0} reduce(Arg_0.424, constant.436), dimensions={2,3}, to_apply=region_0.407
  Arg_4.428 = f32[] parameter(4)
  broadcast.438 = f32[32,32]{1,0} broadcast(Arg_4.428), dimensions={}
  multiply.439 = f32[32,32]{1,0} multiply(reduce.437, broadcast.438)
  Arg_5.429 = f32[] parameter(5)
  broadcast.440 = f32[32,32]{1,0} broadcast(Arg_5.429), dimensions={}
  multiply.441 = f32[32,32]{1,0} multiply(multiply.439, broadcast.440)
  constant.434 = f32[] constant(1)
  broadcast.435 = f32[32,32]{1,0} broadcast(constant.434), dimensions={}
  subtract.442 = f32[32,32]{1,0} subtract(multiply.441, broadcast.435)
  call.443 = c64[32,17]{1,0} call(subtract.442), to_apply=fft.411
  Arg_3.427 = f32[32,17]{1,0} parameter(3)
  convert.444 = c64[32,17]{1,0} convert(Arg_3.427)
  multiply.445 = c64[32,17]{1,0} multiply(call.443, convert.444)
  multiply.452 = c64[32,17]{1,0} multiply(broadcast.451, multiply.445)
  call.459 = f32[32,32]{1,0} call(multiply.452), to_apply=fft_0.417
  Arg_2.426 = f32[1,17]{1,0} parameter(2)
  convert.453 = c64[1,17]{1,0} convert(Arg_2.426)
  constant.430 = c64[] constant((-0, -1))
  broadcast.431 = c64[1,17]{1,0} broadcast(constant.430), dimensions={}
  multiply.454 = c64[1,17]{1,0} multiply(convert.453, broadcast.431)
  broadcast.455 = c64[1,17]{1,0} broadcast(multiply.454), dimensions={0,1}
  reshape.456 = c64[17]{0} reshape(broadcast.455)
  broadcast.457 = c64[32,17]{1,0} broadcast(reshape.456), dimensions={1}
  multiply.458 = c64[32,17]{1,0} multiply(broadcast.457, multiply.445)
  call.460 = f32[32,32]{1,0} call(multiply.458), to_apply=fft_0.420
  call.446 = f32[32,32]{1,0} call(multiply.445), to_apply=fft_0.414
  ROOT tuple.461 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(call.459, call.460, subtract.442, call.446)
}

clip.474 {
  Arg_2.477 = s32[] parameter(2)
  broadcast.480 = s32[32768,32,6]{2,1,0} broadcast(Arg_2.477), dimensions={}
  Arg_1.476 = s32[] parameter(1)
  broadcast.478 = s32[32768,32,6]{2,1,0} broadcast(Arg_1.476), dimensions={}
  Arg_0.475 = s32[32768,32,6]{2,1,0} parameter(0)
  maximum.479 = s32[32768,32,6]{2,1,0} maximum(broadcast.478, Arg_0.475)
  ROOT minimum.481 = s32[32768,32,6]{2,1,0} minimum(broadcast.480, maximum.479)
}

_where_2.482 {
  Arg_0.483 = pred[32768,32,6]{2,1,0} parameter(0)
  Arg_1.484 = f32[32768,32,6]{2,1,0} parameter(1)
  Arg_2.485 = f32[] parameter(2)
  broadcast.486 = f32[32768,32,6]{2,1,0} broadcast(Arg_2.485), dimensions={}
  ROOT select.487 = f32[32768,32,6]{2,1,0} select(Arg_0.483, Arg_1.484, broadcast.486)
}

advect_1d_vectorized_1.488 {
  iota.531 = f32[32]{0} iota(), iota_dimension=0
  reshape.537 = f32[1,32]{1,0} reshape(iota.531)
  broadcast.538 = f32[1,32]{1,0} broadcast(reshape.537), dimensions={0,1}
  reshape.539 = f32[32]{0} reshape(broadcast.538)
  broadcast.540 = f32[32768,32]{1,0} broadcast(reshape.539), dimensions={1}
  Arg_1.490 = f32[32768]{0} parameter(1)
  reshape.532 = f32[32768,1]{1,0} reshape(Arg_1.490)
  Arg_2.491 = f32[] parameter(2)
  broadcast.533 = f32[32768,1]{1,0} broadcast(Arg_2.491), dimensions={}
  multiply.534 = f32[32768,1]{1,0} multiply(reshape.532, broadcast.533)
  Arg_3.492 = f32[] parameter(3)
  broadcast.535 = f32[32768,1]{1,0} broadcast(Arg_3.492), dimensions={}
  divide.536 = f32[32768,1]{1,0} divide(multiply.534, broadcast.535)
  broadcast.541 = f32[32768,1]{1,0} broadcast(divide.536), dimensions={0,1}
  reshape.542 = f32[32768]{0} reshape(broadcast.541)
  broadcast.543 = f32[32768,32]{1,0} broadcast(reshape.542), dimensions={0}
  subtract.544 = f32[32768,32]{1,0} subtract(broadcast.540, broadcast.543)
  floor.545 = f32[32768,32]{1,0} floor(subtract.544)
  subtract.546 = f32[32768,32]{1,0} subtract(subtract.544, floor.545)
  constant.516 = f32[] constant(20)
  broadcast.517 = f32[32768,32]{1,0} broadcast(constant.516), dimensions={}
  divide.581 = f32[32768,32]{1,0} divide(subtract.546, broadcast.517)
  multiply.577 = f32[32768,32]{1,0} multiply(subtract.546, subtract.546)
  constant.514 = f32[] constant(24)
  broadcast.515 = f32[32768,32]{1,0} broadcast(constant.514), dimensions={}
  divide.582 = f32[32768,32]{1,0} divide(multiply.577, broadcast.515)
  subtract.583 = f32[32768,32]{1,0} subtract(divide.581, divide.582)
  multiply.578 = f32[32768,32]{1,0} multiply(multiply.577, subtract.546)
  divide.584 = f32[32768,32]{1,0} divide(multiply.578, broadcast.515)
  subtract.585 = f32[32768,32]{1,0} subtract(subtract.583, divide.584)
  multiply.579 = f32[32768,32]{1,0} multiply(multiply.578, subtract.546)
  divide.586 = f32[32768,32]{1,0} divide(multiply.579, broadcast.515)
  add.587 = f32[32768,32]{1,0} add(subtract.585, divide.586)
  multiply.580 = f32[32768,32]{1,0} multiply(multiply.579, subtract.546)
  constant.512 = f32[] constant(120)
  broadcast.513 = f32[32768,32]{1,0} broadcast(constant.512), dimensions={}
  divide.588 = f32[32768,32]{1,0} divide(multiply.580, broadcast.513)
  subtract.589 = f32[32768,32]{1,0} subtract(add.587, divide.588)
  convert.547 = s32[32768,32]{1,0} convert(floor.545)
  reshape.548 = s32[32768,32,1]{2,1,0} reshape(convert.547)
  broadcast.550 = s32[32768,32,1]{2,1,0} broadcast(reshape.548), dimensions={0,1,2}
  reshape.551 = s32[32768,32]{1,0} reshape(broadcast.550)
  broadcast.552 = s32[32768,32,6]{2,1,0} broadcast(reshape.551), dimensions={0,1}
  Arg_4.493 = s32[6]{0} parameter(4)
  reshape.549 = s32[1,1,6]{2,1,0} reshape(Arg_4.493)
  broadcast.553 = s32[1,1,6]{2,1,0} broadcast(reshape.549), dimensions={0,1,2}
  reshape.554 = s32[6]{0} reshape(broadcast.553)
  broadcast.555 = s32[32768,32,6]{2,1,0} broadcast(reshape.554), dimensions={2}
  add.556 = s32[32768,32,6]{2,1,0} add(broadcast.552, broadcast.555)
  constant.526 = s32[] constant(0)
  broadcast.527 = s32[32768,32,6]{2,1,0} broadcast(constant.526), dimensions={}
  compare.557 = pred[32768,32,6]{2,1,0} compare(add.556, broadcast.527), direction=GE
  constant.524 = s32[] constant(32)
  broadcast.525 = s32[32768,32,6]{2,1,0} broadcast(constant.524), dimensions={}
  compare.558 = pred[32768,32,6]{2,1,0} compare(add.556, broadcast.525), direction=LT
  and.559 = pred[32768,32,6]{2,1,0} and(compare.557, compare.558)
  Arg_0.489 = f32[32768,32]{1,0} parameter(0)
  reshape.568 = f32[1048576]{0} reshape(Arg_0.489)
  iota.561 = s32[32768]{0} iota(), iota_dimension=0
  reshape.562 = s32[32768,1,1]{2,1,0} reshape(iota.561)
  constant.522 = s32[] constant(32)
  broadcast.523 = s32[32768,1,1]{2,1,0} broadcast(constant.522), dimensions={}
  multiply.563 = s32[32768,1,1]{2,1,0} multiply(reshape.562, broadcast.523)
  broadcast.564 = s32[32768,1,1]{2,1,0} broadcast(multiply.563), dimensions={0,1,2}
  reshape.565 = s32[32768]{0} reshape(broadcast.564)
  broadcast.566 = s32[32768,32,6]{2,1,0} broadcast(reshape.565), dimensions={0}
  constant.530 = s32[] constant(0)
  constant.529 = s32[] constant(31)
  call.560 = s32[32768,32,6]{2,1,0} call(add.556, constant.530, constant.529), to_apply=clip.474
  add.567 = s32[32768,32,6]{2,1,0} add(broadcast.566, call.560)
  reshape.569 = s32[6291456]{0} reshape(add.567)
  constant.520 = s32[] constant(0)
  broadcast.521 = s32[6291456]{0} broadcast(constant.520), dimensions={}
  compare.570 = pred[6291456]{0} compare(reshape.569, broadcast.521), direction=LT
  constant.518 = s32[] constant(1048576)
  broadcast.519 = s32[6291456]{0} broadcast(constant.518), dimensions={}
  add.571 = s32[6291456]{0} add(reshape.569, broadcast.519)
  select.572 = s32[6291456]{0} select(compare.570, add.571, reshape.569)
  reshape.573 = s32[6291456,1]{1,0} reshape(select.572)
  gather.574 = f32[6291456]{0} gather(reshape.568, reshape.573), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.575 = f32[32768,32,6]{2,1,0} reshape(gather.574)
  constant.528 = f32[] constant(0)
  call.576 = f32[32768,32,6]{2,1,0} call(and.559, reshape.575, constant.528), to_apply=_where_2.482
  slice.639 = f32[32768,32,1]{2,1,0} slice(call.576), slice={[0:32768], [0:32], [0:1]}
  reshape.640 = f32[32768,32]{1,0} reshape(slice.639)
  multiply.641 = f32[32768,32]{1,0} multiply(subtract.589, reshape.640)
  constant.510 = f32[] constant(2)
  broadcast.511 = f32[32768,32]{1,0} broadcast(constant.510), dimensions={}
  divide.590 = f32[32768,32]{1,0} divide(subtract.546, broadcast.511)
  negate.591 = f32[32768,32]{1,0} negate(divide.590)
  multiply.592 = f32[32768,32]{1,0} multiply(multiply.577, broadcast.511)
  constant.508 = f32[] constant(3)
  broadcast.509 = f32[32768,32]{1,0} broadcast(constant.508), dimensions={}
  divide.593 = f32[32768,32]{1,0} divide(multiply.592, broadcast.509)
  add.594 = f32[32768,32]{1,0} add(negate.591, divide.593)
  divide.595 = f32[32768,32]{1,0} divide(multiply.578, broadcast.515)
  subtract.596 = f32[32768,32]{1,0} subtract(add.594, divide.595)
  constant.506 = f32[] constant(6)
  broadcast.507 = f32[32768,32]{1,0} broadcast(constant.506), dimensions={}
  divide.597 = f32[32768,32]{1,0} divide(multiply.579, broadcast.507)
  subtract.598 = f32[32768,32]{1,0} subtract(subtract.596, divide.597)
  divide.599 = f32[32768,32]{1,0} divide(multiply.580, broadcast.515)
  add.600 = f32[32768,32]{1,0} add(subtract.598, divide.599)
  slice.642 = f32[32768,32,1]{2,1,0} slice(call.576), slice={[0:32768], [0:32], [1:2]}
  reshape.643 = f32[32768,32]{1,0} reshape(slice.642)
  multiply.644 = f32[32768,32]{1,0} multiply(add.600, reshape.643)
  add.645 = f32[32768,32]{1,0} add(multiply.641, multiply.644)
  constant.504 = f32[] constant(1)
  broadcast.505 = f32[32768,32]{1,0} broadcast(constant.504), dimensions={}
  divide.601 = f32[32768,32]{1,0} divide(subtract.546, broadcast.509)
  subtract.602 = f32[32768,32]{1,0} subtract(broadcast.505, divide.601)
  constant.502 = f32[] constant(5)
  broadcast.503 = f32[32768,32]{1,0} broadcast(constant.502), dimensions={}
  multiply.603 = f32[32768,32]{1,0} multiply(multiply.577, broadcast.503)
  constant.500 = f32[] constant(4)
  broadcast.501 = f32[32768,32]{1,0} broadcast(constant.500), dimensions={}
  divide.604 = f32[32768,32]{1,0} divide(multiply.603, broadcast.501)
  subtract.605 = f32[32768,32]{1,0} subtract(subtract.602, divide.604)
  multiply.606 = f32[32768,32]{1,0} multiply(multiply.578, broadcast.503)
  constant.498 = f32[] constant(12)
  broadcast.499 = f32[32768,32]{1,0} broadcast(constant.498), dimensions={}
  divide.607 = f32[32768,32]{1,0} divide(multiply.606, broadcast.499)
  add.608 = f32[32768,32]{1,0} add(subtract.605, divide.607)
  divide.609 = f32[32768,32]{1,0} divide(multiply.579, broadcast.501)
  add.610 = f32[32768,32]{1,0} add(add.608, divide.609)
  divide.611 = f32[32768,32]{1,0} divide(multiply.580, broadcast.499)
  subtract.612 = f32[32768,32]{1,0} subtract(add.610, divide.611)
  slice.646 = f32[32768,32,1]{2,1,0} slice(call.576), slice={[0:32768], [0:32], [2:3]}
  reshape.647 = f32[32768,32]{1,0} reshape(slice.646)
  multiply.648 = f32[32768,32]{1,0} multiply(subtract.612, reshape.647)
  add.649 = f32[32768,32]{1,0} add(add.645, multiply.648)
  multiply.613 = f32[32768,32]{1,0} multiply(multiply.577, broadcast.511)
  divide.614 = f32[32768,32]{1,0} divide(multiply.613, broadcast.509)
  add.615 = f32[32768,32]{1,0} add(subtract.546, divide.614)
  constant.496 = f32[] constant(7)
  broadcast.497 = f32[32768,32]{1,0} broadcast(constant.496), dimensions={}
  multiply.616 = f32[32768,32]{1,0} multiply(multiply.578, broadcast.497)
  divide.617 = f32[32768,32]{1,0} divide(multiply.616, broadcast.499)
  subtract.618 = f32[32768,32]{1,0} subtract(add.615, divide.617)
  divide.619 = f32[32768,32]{1,0} divide(multiply.579, broadcast.507)
  subtract.620 = f32[32768,32]{1,0} subtract(subtract.618, divide.619)
  divide.621 = f32[32768,32]{1,0} divide(multiply.580, broadcast.499)
  add.622 = f32[32768,32]{1,0} add(subtract.620, divide.621)
  slice.650 = f32[32768,32,1]{2,1,0} slice(call.576), slice={[0:32768], [0:32], [3:4]}
  reshape.651 = f32[32768,32]{1,0} reshape(slice.650)
  multiply.652 = f32[32768,32]{1,0} multiply(add.622, reshape.651)
  add.653 = f32[32768,32]{1,0} add(add.649, multiply.652)
  divide.623 = f32[32768,32]{1,0} divide(subtract.546, broadcast.501)
  negate.624 = f32[32768,32]{1,0} negate(divide.623)
  divide.625 = f32[32768,32]{1,0} divide(multiply.577, broadcast.515)
  subtract.626 = f32[32768,32]{1,0} subtract(negate.624, divide.625)
  multiply.627 = f32[32768,32]{1,0} multiply(multiply.578, broadcast.497)
  divide.628 = f32[32768,32]{1,0} divide(multiply.627, broadcast.515)
  add.629 = f32[32768,32]{1,0} add(subtract.626, divide.628)
  divide.630 = f32[32768,32]{1,0} divide(multiply.579, broadcast.515)
  add.631 = f32[32768,32]{1,0} add(add.629, divide.630)
  divide.632 = f32[32768,32]{1,0} divide(multiply.580, broadcast.515)
  subtract.633 = f32[32768,32]{1,0} subtract(add.631, divide.632)
  slice.654 = f32[32768,32,1]{2,1,0} slice(call.576), slice={[0:32768], [0:32], [4:5]}
  reshape.655 = f32[32768,32]{1,0} reshape(slice.654)
  multiply.656 = f32[32768,32]{1,0} multiply(subtract.633, reshape.655)
  add.657 = f32[32768,32]{1,0} add(add.653, multiply.656)
  constant.494 = f32[] constant(30)
  broadcast.495 = f32[32768,32]{1,0} broadcast(constant.494), dimensions={}
  divide.634 = f32[32768,32]{1,0} divide(subtract.546, broadcast.495)
  divide.635 = f32[32768,32]{1,0} divide(multiply.578, broadcast.515)
  subtract.636 = f32[32768,32]{1,0} subtract(divide.634, divide.635)
  divide.637 = f32[32768,32]{1,0} divide(multiply.580, broadcast.513)
  add.638 = f32[32768,32]{1,0} add(subtract.636, divide.637)
  slice.658 = f32[32768,32,1]{2,1,0} slice(call.576), slice={[0:32768], [0:32], [5:6]}
  reshape.659 = f32[32768,32]{1,0} reshape(slice.658)
  multiply.660 = f32[32768,32]{1,0} multiply(add.638, reshape.659)
  ROOT add.661 = f32[32768,32]{1,0} add(add.657, multiply.660)
}

clip.671 {
  Arg_2.674 = s32[] parameter(2)
  broadcast.677 = s32[32768,32,6]{2,1,0} broadcast(Arg_2.674), dimensions={}
  Arg_1.673 = s32[] parameter(1)
  broadcast.675 = s32[32768,32,6]{2,1,0} broadcast(Arg_1.673), dimensions={}
  Arg_0.672 = s32[32768,32,6]{2,1,0} parameter(0)
  maximum.676 = s32[32768,32,6]{2,1,0} maximum(broadcast.675, Arg_0.672)
  ROOT minimum.678 = s32[32768,32,6]{2,1,0} minimum(broadcast.677, maximum.676)
}

_where_2.679 {
  Arg_0.680 = pred[32768,32,6]{2,1,0} parameter(0)
  Arg_1.681 = f32[32768,32,6]{2,1,0} parameter(1)
  Arg_2.682 = f32[] parameter(2)
  broadcast.683 = f32[32768,32,6]{2,1,0} broadcast(Arg_2.682), dimensions={}
  ROOT select.684 = f32[32768,32,6]{2,1,0} select(Arg_0.680, Arg_1.681, broadcast.683)
}

advect_1d_vectorized_1.685 {
  iota.728 = f32[32]{0} iota(), iota_dimension=0
  reshape.734 = f32[1,32]{1,0} reshape(iota.728)
  broadcast.735 = f32[1,32]{1,0} broadcast(reshape.734), dimensions={0,1}
  reshape.736 = f32[32]{0} reshape(broadcast.735)
  broadcast.737 = f32[32768,32]{1,0} broadcast(reshape.736), dimensions={1}
  Arg_1.687 = f32[32768]{0} parameter(1)
  reshape.729 = f32[32768,1]{1,0} reshape(Arg_1.687)
  Arg_2.688 = f32[] parameter(2)
  broadcast.730 = f32[32768,1]{1,0} broadcast(Arg_2.688), dimensions={}
  multiply.731 = f32[32768,1]{1,0} multiply(reshape.729, broadcast.730)
  Arg_3.689 = f32[] parameter(3)
  broadcast.732 = f32[32768,1]{1,0} broadcast(Arg_3.689), dimensions={}
  divide.733 = f32[32768,1]{1,0} divide(multiply.731, broadcast.732)
  broadcast.738 = f32[32768,1]{1,0} broadcast(divide.733), dimensions={0,1}
  reshape.739 = f32[32768]{0} reshape(broadcast.738)
  broadcast.740 = f32[32768,32]{1,0} broadcast(reshape.739), dimensions={0}
  subtract.741 = f32[32768,32]{1,0} subtract(broadcast.737, broadcast.740)
  floor.742 = f32[32768,32]{1,0} floor(subtract.741)
  subtract.743 = f32[32768,32]{1,0} subtract(subtract.741, floor.742)
  constant.713 = f32[] constant(20)
  broadcast.714 = f32[32768,32]{1,0} broadcast(constant.713), dimensions={}
  divide.778 = f32[32768,32]{1,0} divide(subtract.743, broadcast.714)
  multiply.774 = f32[32768,32]{1,0} multiply(subtract.743, subtract.743)
  constant.711 = f32[] constant(24)
  broadcast.712 = f32[32768,32]{1,0} broadcast(constant.711), dimensions={}
  divide.779 = f32[32768,32]{1,0} divide(multiply.774, broadcast.712)
  subtract.780 = f32[32768,32]{1,0} subtract(divide.778, divide.779)
  multiply.775 = f32[32768,32]{1,0} multiply(multiply.774, subtract.743)
  divide.781 = f32[32768,32]{1,0} divide(multiply.775, broadcast.712)
  subtract.782 = f32[32768,32]{1,0} subtract(subtract.780, divide.781)
  multiply.776 = f32[32768,32]{1,0} multiply(multiply.775, subtract.743)
  divide.783 = f32[32768,32]{1,0} divide(multiply.776, broadcast.712)
  add.784 = f32[32768,32]{1,0} add(subtract.782, divide.783)
  multiply.777 = f32[32768,32]{1,0} multiply(multiply.776, subtract.743)
  constant.709 = f32[] constant(120)
  broadcast.710 = f32[32768,32]{1,0} broadcast(constant.709), dimensions={}
  divide.785 = f32[32768,32]{1,0} divide(multiply.777, broadcast.710)
  subtract.786 = f32[32768,32]{1,0} subtract(add.784, divide.785)
  convert.744 = s32[32768,32]{1,0} convert(floor.742)
  reshape.745 = s32[32768,32,1]{2,1,0} reshape(convert.744)
  broadcast.747 = s32[32768,32,1]{2,1,0} broadcast(reshape.745), dimensions={0,1,2}
  reshape.748 = s32[32768,32]{1,0} reshape(broadcast.747)
  broadcast.749 = s32[32768,32,6]{2,1,0} broadcast(reshape.748), dimensions={0,1}
  Arg_4.690 = s32[6]{0} parameter(4)
  reshape.746 = s32[1,1,6]{2,1,0} reshape(Arg_4.690)
  broadcast.750 = s32[1,1,6]{2,1,0} broadcast(reshape.746), dimensions={0,1,2}
  reshape.751 = s32[6]{0} reshape(broadcast.750)
  broadcast.752 = s32[32768,32,6]{2,1,0} broadcast(reshape.751), dimensions={2}
  add.753 = s32[32768,32,6]{2,1,0} add(broadcast.749, broadcast.752)
  constant.723 = s32[] constant(0)
  broadcast.724 = s32[32768,32,6]{2,1,0} broadcast(constant.723), dimensions={}
  compare.754 = pred[32768,32,6]{2,1,0} compare(add.753, broadcast.724), direction=GE
  constant.721 = s32[] constant(32)
  broadcast.722 = s32[32768,32,6]{2,1,0} broadcast(constant.721), dimensions={}
  compare.755 = pred[32768,32,6]{2,1,0} compare(add.753, broadcast.722), direction=LT
  and.756 = pred[32768,32,6]{2,1,0} and(compare.754, compare.755)
  Arg_0.686 = f32[32768,32]{1,0} parameter(0)
  reshape.765 = f32[1048576]{0} reshape(Arg_0.686)
  iota.758 = s32[32768]{0} iota(), iota_dimension=0
  reshape.759 = s32[32768,1,1]{2,1,0} reshape(iota.758)
  constant.719 = s32[] constant(32)
  broadcast.720 = s32[32768,1,1]{2,1,0} broadcast(constant.719), dimensions={}
  multiply.760 = s32[32768,1,1]{2,1,0} multiply(reshape.759, broadcast.720)
  broadcast.761 = s32[32768,1,1]{2,1,0} broadcast(multiply.760), dimensions={0,1,2}
  reshape.762 = s32[32768]{0} reshape(broadcast.761)
  broadcast.763 = s32[32768,32,6]{2,1,0} broadcast(reshape.762), dimensions={0}
  constant.727 = s32[] constant(0)
  constant.726 = s32[] constant(31)
  call.757 = s32[32768,32,6]{2,1,0} call(add.753, constant.727, constant.726), to_apply=clip.671
  add.764 = s32[32768,32,6]{2,1,0} add(broadcast.763, call.757)
  reshape.766 = s32[6291456]{0} reshape(add.764)
  constant.717 = s32[] constant(0)
  broadcast.718 = s32[6291456]{0} broadcast(constant.717), dimensions={}
  compare.767 = pred[6291456]{0} compare(reshape.766, broadcast.718), direction=LT
  constant.715 = s32[] constant(1048576)
  broadcast.716 = s32[6291456]{0} broadcast(constant.715), dimensions={}
  add.768 = s32[6291456]{0} add(reshape.766, broadcast.716)
  select.769 = s32[6291456]{0} select(compare.767, add.768, reshape.766)
  reshape.770 = s32[6291456,1]{1,0} reshape(select.769)
  gather.771 = f32[6291456]{0} gather(reshape.765, reshape.770), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.772 = f32[32768,32,6]{2,1,0} reshape(gather.771)
  constant.725 = f32[] constant(0)
  call.773 = f32[32768,32,6]{2,1,0} call(and.756, reshape.772, constant.725), to_apply=_where_2.679
  slice.836 = f32[32768,32,1]{2,1,0} slice(call.773), slice={[0:32768], [0:32], [0:1]}
  reshape.837 = f32[32768,32]{1,0} reshape(slice.836)
  multiply.838 = f32[32768,32]{1,0} multiply(subtract.786, reshape.837)
  constant.707 = f32[] constant(2)
  broadcast.708 = f32[32768,32]{1,0} broadcast(constant.707), dimensions={}
  divide.787 = f32[32768,32]{1,0} divide(subtract.743, broadcast.708)
  negate.788 = f32[32768,32]{1,0} negate(divide.787)
  multiply.789 = f32[32768,32]{1,0} multiply(multiply.774, broadcast.708)
  constant.705 = f32[] constant(3)
  broadcast.706 = f32[32768,32]{1,0} broadcast(constant.705), dimensions={}
  divide.790 = f32[32768,32]{1,0} divide(multiply.789, broadcast.706)
  add.791 = f32[32768,32]{1,0} add(negate.788, divide.790)
  divide.792 = f32[32768,32]{1,0} divide(multiply.775, broadcast.712)
  subtract.793 = f32[32768,32]{1,0} subtract(add.791, divide.792)
  constant.703 = f32[] constant(6)
  broadcast.704 = f32[32768,32]{1,0} broadcast(constant.703), dimensions={}
  divide.794 = f32[32768,32]{1,0} divide(multiply.776, broadcast.704)
  subtract.795 = f32[32768,32]{1,0} subtract(subtract.793, divide.794)
  divide.796 = f32[32768,32]{1,0} divide(multiply.777, broadcast.712)
  add.797 = f32[32768,32]{1,0} add(subtract.795, divide.796)
  slice.839 = f32[32768,32,1]{2,1,0} slice(call.773), slice={[0:32768], [0:32], [1:2]}
  reshape.840 = f32[32768,32]{1,0} reshape(slice.839)
  multiply.841 = f32[32768,32]{1,0} multiply(add.797, reshape.840)
  add.842 = f32[32768,32]{1,0} add(multiply.838, multiply.841)
  constant.701 = f32[] constant(1)
  broadcast.702 = f32[32768,32]{1,0} broadcast(constant.701), dimensions={}
  divide.798 = f32[32768,32]{1,0} divide(subtract.743, broadcast.706)
  subtract.799 = f32[32768,32]{1,0} subtract(broadcast.702, divide.798)
  constant.699 = f32[] constant(5)
  broadcast.700 = f32[32768,32]{1,0} broadcast(constant.699), dimensions={}
  multiply.800 = f32[32768,32]{1,0} multiply(multiply.774, broadcast.700)
  constant.697 = f32[] constant(4)
  broadcast.698 = f32[32768,32]{1,0} broadcast(constant.697), dimensions={}
  divide.801 = f32[32768,32]{1,0} divide(multiply.800, broadcast.698)
  subtract.802 = f32[32768,32]{1,0} subtract(subtract.799, divide.801)
  multiply.803 = f32[32768,32]{1,0} multiply(multiply.775, broadcast.700)
  constant.695 = f32[] constant(12)
  broadcast.696 = f32[32768,32]{1,0} broadcast(constant.695), dimensions={}
  divide.804 = f32[32768,32]{1,0} divide(multiply.803, broadcast.696)
  add.805 = f32[32768,32]{1,0} add(subtract.802, divide.804)
  divide.806 = f32[32768,32]{1,0} divide(multiply.776, broadcast.698)
  add.807 = f32[32768,32]{1,0} add(add.805, divide.806)
  divide.808 = f32[32768,32]{1,0} divide(multiply.777, broadcast.696)
  subtract.809 = f32[32768,32]{1,0} subtract(add.807, divide.808)
  slice.843 = f32[32768,32,1]{2,1,0} slice(call.773), slice={[0:32768], [0:32], [2:3]}
  reshape.844 = f32[32768,32]{1,0} reshape(slice.843)
  multiply.845 = f32[32768,32]{1,0} multiply(subtract.809, reshape.844)
  add.846 = f32[32768,32]{1,0} add(add.842, multiply.845)
  multiply.810 = f32[32768,32]{1,0} multiply(multiply.774, broadcast.708)
  divide.811 = f32[32768,32]{1,0} divide(multiply.810, broadcast.706)
  add.812 = f32[32768,32]{1,0} add(subtract.743, divide.811)
  constant.693 = f32[] constant(7)
  broadcast.694 = f32[32768,32]{1,0} broadcast(constant.693), dimensions={}
  multiply.813 = f32[32768,32]{1,0} multiply(multiply.775, broadcast.694)
  divide.814 = f32[32768,32]{1,0} divide(multiply.813, broadcast.696)
  subtract.815 = f32[32768,32]{1,0} subtract(add.812, divide.814)
  divide.816 = f32[32768,32]{1,0} divide(multiply.776, broadcast.704)
  subtract.817 = f32[32768,32]{1,0} subtract(subtract.815, divide.816)
  divide.818 = f32[32768,32]{1,0} divide(multiply.777, broadcast.696)
  add.819 = f32[32768,32]{1,0} add(subtract.817, divide.818)
  slice.847 = f32[32768,32,1]{2,1,0} slice(call.773), slice={[0:32768], [0:32], [3:4]}
  reshape.848 = f32[32768,32]{1,0} reshape(slice.847)
  multiply.849 = f32[32768,32]{1,0} multiply(add.819, reshape.848)
  add.850 = f32[32768,32]{1,0} add(add.846, multiply.849)
  divide.820 = f32[32768,32]{1,0} divide(subtract.743, broadcast.698)
  negate.821 = f32[32768,32]{1,0} negate(divide.820)
  divide.822 = f32[32768,32]{1,0} divide(multiply.774, broadcast.712)
  subtract.823 = f32[32768,32]{1,0} subtract(negate.821, divide.822)
  multiply.824 = f32[32768,32]{1,0} multiply(multiply.775, broadcast.694)
  divide.825 = f32[32768,32]{1,0} divide(multiply.824, broadcast.712)
  add.826 = f32[32768,32]{1,0} add(subtract.823, divide.825)
  divide.827 = f32[32768,32]{1,0} divide(multiply.776, broadcast.712)
  add.828 = f32[32768,32]{1,0} add(add.826, divide.827)
  divide.829 = f32[32768,32]{1,0} divide(multiply.777, broadcast.712)
  subtract.830 = f32[32768,32]{1,0} subtract(add.828, divide.829)
  slice.851 = f32[32768,32,1]{2,1,0} slice(call.773), slice={[0:32768], [0:32], [4:5]}
  reshape.852 = f32[32768,32]{1,0} reshape(slice.851)
  multiply.853 = f32[32768,32]{1,0} multiply(subtract.830, reshape.852)
  add.854 = f32[32768,32]{1,0} add(add.850, multiply.853)
  constant.691 = f32[] constant(30)
  broadcast.692 = f32[32768,32]{1,0} broadcast(constant.691), dimensions={}
  divide.831 = f32[32768,32]{1,0} divide(subtract.743, broadcast.692)
  divide.832 = f32[32768,32]{1,0} divide(multiply.775, broadcast.712)
  subtract.833 = f32[32768,32]{1,0} subtract(divide.831, divide.832)
  divide.834 = f32[32768,32]{1,0} divide(multiply.777, broadcast.710)
  add.835 = f32[32768,32]{1,0} add(subtract.833, divide.834)
  slice.855 = f32[32768,32,1]{2,1,0} slice(call.773), slice={[0:32768], [0:32], [5:6]}
  reshape.856 = f32[32768,32]{1,0} reshape(slice.855)
  multiply.857 = f32[32768,32]{1,0} multiply(add.835, reshape.856)
  ROOT add.858 = f32[32768,32]{1,0} add(add.854, multiply.857)
}

_where.867 {
  Arg_0.868 = pred[] parameter(0)
  Arg_1.869 = s32[] parameter(1)
  Arg_2.870 = s32[] parameter(2)
  ROOT select.871 = s32[] select(Arg_0.868, Arg_1.869, Arg_2.870)
}

remainder.872 {
  Arg_0.873 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.874 = s32[] parameter(1)
  constant.878 = s32[] constant(0)
  compare.879 = pred[] compare(Arg_1.874, constant.878), direction=EQ
  constant.877 = s32[] constant(1)
  call.880 = s32[] call(compare.879, constant.877, Arg_1.874), to_apply=_where.867
  broadcast.881 = s32[32768,32,6]{2,1,0} broadcast(call.880), dimensions={}
  remainder.882 = s32[32768,32,6]{2,1,0} remainder(Arg_0.873, broadcast.881)
  constant.875 = s32[] constant(0)
  broadcast.876 = s32[32768,32,6]{2,1,0} broadcast(constant.875), dimensions={}
  compare.884 = pred[32768,32,6]{2,1,0} compare(remainder.882, broadcast.876), direction=LT
  compare.885 = pred[] compare(call.880, constant.878), direction=LT
  broadcast.886 = pred[32768,32,6]{2,1,0} broadcast(compare.885), dimensions={}
  compare.887 = pred[32768,32,6]{2,1,0} compare(compare.884, broadcast.886), direction=NE
  compare.883 = pred[32768,32,6]{2,1,0} compare(remainder.882, broadcast.876), direction=NE
  and.888 = pred[32768,32,6]{2,1,0} and(compare.887, compare.883)
  broadcast.889 = s32[32768,32,6]{2,1,0} broadcast(call.880), dimensions={}
  add.890 = s32[32768,32,6]{2,1,0} add(remainder.882, broadcast.889)
  ROOT select.891 = s32[32768,32,6]{2,1,0} select(and.888, add.890, remainder.882)
}

advect_1d_vectorized.892 {
  iota.929 = f32[32]{0} iota(), iota_dimension=0
  reshape.935 = f32[1,32]{1,0} reshape(iota.929)
  broadcast.936 = f32[1,32]{1,0} broadcast(reshape.935), dimensions={0,1}
  reshape.937 = f32[32]{0} reshape(broadcast.936)
  broadcast.938 = f32[32768,32]{1,0} broadcast(reshape.937), dimensions={1}
  Arg_1.894 = f32[32768]{0} parameter(1)
  reshape.930 = f32[32768,1]{1,0} reshape(Arg_1.894)
  Arg_2.895 = f32[] parameter(2)
  broadcast.931 = f32[32768,1]{1,0} broadcast(Arg_2.895), dimensions={}
  multiply.932 = f32[32768,1]{1,0} multiply(reshape.930, broadcast.931)
  Arg_3.896 = f32[] parameter(3)
  broadcast.933 = f32[32768,1]{1,0} broadcast(Arg_3.896), dimensions={}
  divide.934 = f32[32768,1]{1,0} divide(multiply.932, broadcast.933)
  broadcast.939 = f32[32768,1]{1,0} broadcast(divide.934), dimensions={0,1}
  reshape.940 = f32[32768]{0} reshape(broadcast.939)
  broadcast.941 = f32[32768,32]{1,0} broadcast(reshape.940), dimensions={0}
  subtract.942 = f32[32768,32]{1,0} subtract(broadcast.938, broadcast.941)
  floor.943 = f32[32768,32]{1,0} floor(subtract.942)
  subtract.944 = f32[32768,32]{1,0} subtract(subtract.942, floor.943)
  constant.920 = f32[] constant(20)
  broadcast.921 = f32[32768,32]{1,0} broadcast(constant.920), dimensions={}
  divide.975 = f32[32768,32]{1,0} divide(subtract.944, broadcast.921)
  multiply.971 = f32[32768,32]{1,0} multiply(subtract.944, subtract.944)
  constant.918 = f32[] constant(24)
  broadcast.919 = f32[32768,32]{1,0} broadcast(constant.918), dimensions={}
  divide.976 = f32[32768,32]{1,0} divide(multiply.971, broadcast.919)
  subtract.977 = f32[32768,32]{1,0} subtract(divide.975, divide.976)
  multiply.972 = f32[32768,32]{1,0} multiply(multiply.971, subtract.944)
  divide.978 = f32[32768,32]{1,0} divide(multiply.972, broadcast.919)
  subtract.979 = f32[32768,32]{1,0} subtract(subtract.977, divide.978)
  multiply.973 = f32[32768,32]{1,0} multiply(multiply.972, subtract.944)
  divide.980 = f32[32768,32]{1,0} divide(multiply.973, broadcast.919)
  add.981 = f32[32768,32]{1,0} add(subtract.979, divide.980)
  multiply.974 = f32[32768,32]{1,0} multiply(multiply.973, subtract.944)
  constant.916 = f32[] constant(120)
  broadcast.917 = f32[32768,32]{1,0} broadcast(constant.916), dimensions={}
  divide.982 = f32[32768,32]{1,0} divide(multiply.974, broadcast.917)
  subtract.983 = f32[32768,32]{1,0} subtract(add.981, divide.982)
  Arg_0.893 = f32[32768,32]{1,0} parameter(0)
  reshape.963 = f32[1048576]{0} reshape(Arg_0.893)
  iota.956 = s32[32768]{0} iota(), iota_dimension=0
  reshape.957 = s32[32768,1,1]{2,1,0} reshape(iota.956)
  constant.926 = s32[] constant(32)
  broadcast.927 = s32[32768,1,1]{2,1,0} broadcast(constant.926), dimensions={}
  multiply.958 = s32[32768,1,1]{2,1,0} multiply(reshape.957, broadcast.927)
  broadcast.959 = s32[32768,1,1]{2,1,0} broadcast(multiply.958), dimensions={0,1,2}
  reshape.960 = s32[32768]{0} reshape(broadcast.959)
  broadcast.961 = s32[32768,32,6]{2,1,0} broadcast(reshape.960), dimensions={0}
  convert.945 = s32[32768,32]{1,0} convert(floor.943)
  reshape.946 = s32[32768,32,1]{2,1,0} reshape(convert.945)
  broadcast.948 = s32[32768,32,1]{2,1,0} broadcast(reshape.946), dimensions={0,1,2}
  reshape.949 = s32[32768,32]{1,0} reshape(broadcast.948)
  broadcast.950 = s32[32768,32,6]{2,1,0} broadcast(reshape.949), dimensions={0,1}
  Arg_4.897 = s32[6]{0} parameter(4)
  reshape.947 = s32[1,1,6]{2,1,0} reshape(Arg_4.897)
  broadcast.951 = s32[1,1,6]{2,1,0} broadcast(reshape.947), dimensions={0,1,2}
  reshape.952 = s32[6]{0} reshape(broadcast.951)
  broadcast.953 = s32[32768,32,6]{2,1,0} broadcast(reshape.952), dimensions={2}
  add.954 = s32[32768,32,6]{2,1,0} add(broadcast.950, broadcast.953)
  constant.928 = s32[] constant(32)
  call.955 = s32[32768,32,6]{2,1,0} call(add.954, constant.928), to_apply=remainder.872
  add.962 = s32[32768,32,6]{2,1,0} add(broadcast.961, call.955)
  reshape.964 = s32[6291456]{0} reshape(add.962)
  constant.924 = s32[] constant(0)
  broadcast.925 = s32[6291456]{0} broadcast(constant.924), dimensions={}
  compare.965 = pred[6291456]{0} compare(reshape.964, broadcast.925), direction=LT
  constant.922 = s32[] constant(1048576)
  broadcast.923 = s32[6291456]{0} broadcast(constant.922), dimensions={}
  add.966 = s32[6291456]{0} add(reshape.964, broadcast.923)
  select.967 = s32[6291456]{0} select(compare.965, add.966, reshape.964)
  reshape.968 = s32[6291456,1]{1,0} reshape(select.967)
  gather.969 = f32[6291456]{0} gather(reshape.963, reshape.968), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.970 = f32[32768,32,6]{2,1,0} reshape(gather.969)
  slice.1033 = f32[32768,32,1]{2,1,0} slice(reshape.970), slice={[0:32768], [0:32], [0:1]}
  reshape.1034 = f32[32768,32]{1,0} reshape(slice.1033)
  multiply.1035 = f32[32768,32]{1,0} multiply(subtract.983, reshape.1034)
  constant.914 = f32[] constant(2)
  broadcast.915 = f32[32768,32]{1,0} broadcast(constant.914), dimensions={}
  divide.984 = f32[32768,32]{1,0} divide(subtract.944, broadcast.915)
  negate.985 = f32[32768,32]{1,0} negate(divide.984)
  multiply.986 = f32[32768,32]{1,0} multiply(multiply.971, broadcast.915)
  constant.912 = f32[] constant(3)
  broadcast.913 = f32[32768,32]{1,0} broadcast(constant.912), dimensions={}
  divide.987 = f32[32768,32]{1,0} divide(multiply.986, broadcast.913)
  add.988 = f32[32768,32]{1,0} add(negate.985, divide.987)
  divide.989 = f32[32768,32]{1,0} divide(multiply.972, broadcast.919)
  subtract.990 = f32[32768,32]{1,0} subtract(add.988, divide.989)
  constant.910 = f32[] constant(6)
  broadcast.911 = f32[32768,32]{1,0} broadcast(constant.910), dimensions={}
  divide.991 = f32[32768,32]{1,0} divide(multiply.973, broadcast.911)
  subtract.992 = f32[32768,32]{1,0} subtract(subtract.990, divide.991)
  divide.993 = f32[32768,32]{1,0} divide(multiply.974, broadcast.919)
  add.994 = f32[32768,32]{1,0} add(subtract.992, divide.993)
  slice.1036 = f32[32768,32,1]{2,1,0} slice(reshape.970), slice={[0:32768], [0:32], [1:2]}
  reshape.1037 = f32[32768,32]{1,0} reshape(slice.1036)
  multiply.1038 = f32[32768,32]{1,0} multiply(add.994, reshape.1037)
  add.1039 = f32[32768,32]{1,0} add(multiply.1035, multiply.1038)
  constant.908 = f32[] constant(1)
  broadcast.909 = f32[32768,32]{1,0} broadcast(constant.908), dimensions={}
  divide.995 = f32[32768,32]{1,0} divide(subtract.944, broadcast.913)
  subtract.996 = f32[32768,32]{1,0} subtract(broadcast.909, divide.995)
  constant.906 = f32[] constant(5)
  broadcast.907 = f32[32768,32]{1,0} broadcast(constant.906), dimensions={}
  multiply.997 = f32[32768,32]{1,0} multiply(multiply.971, broadcast.907)
  constant.904 = f32[] constant(4)
  broadcast.905 = f32[32768,32]{1,0} broadcast(constant.904), dimensions={}
  divide.998 = f32[32768,32]{1,0} divide(multiply.997, broadcast.905)
  subtract.999 = f32[32768,32]{1,0} subtract(subtract.996, divide.998)
  multiply.1000 = f32[32768,32]{1,0} multiply(multiply.972, broadcast.907)
  constant.902 = f32[] constant(12)
  broadcast.903 = f32[32768,32]{1,0} broadcast(constant.902), dimensions={}
  divide.1001 = f32[32768,32]{1,0} divide(multiply.1000, broadcast.903)
  add.1002 = f32[32768,32]{1,0} add(subtract.999, divide.1001)
  divide.1003 = f32[32768,32]{1,0} divide(multiply.973, broadcast.905)
  add.1004 = f32[32768,32]{1,0} add(add.1002, divide.1003)
  divide.1005 = f32[32768,32]{1,0} divide(multiply.974, broadcast.903)
  subtract.1006 = f32[32768,32]{1,0} subtract(add.1004, divide.1005)
  slice.1040 = f32[32768,32,1]{2,1,0} slice(reshape.970), slice={[0:32768], [0:32], [2:3]}
  reshape.1041 = f32[32768,32]{1,0} reshape(slice.1040)
  multiply.1042 = f32[32768,32]{1,0} multiply(subtract.1006, reshape.1041)
  add.1043 = f32[32768,32]{1,0} add(add.1039, multiply.1042)
  multiply.1007 = f32[32768,32]{1,0} multiply(multiply.971, broadcast.915)
  divide.1008 = f32[32768,32]{1,0} divide(multiply.1007, broadcast.913)
  add.1009 = f32[32768,32]{1,0} add(subtract.944, divide.1008)
  constant.900 = f32[] constant(7)
  broadcast.901 = f32[32768,32]{1,0} broadcast(constant.900), dimensions={}
  multiply.1010 = f32[32768,32]{1,0} multiply(multiply.972, broadcast.901)
  divide.1011 = f32[32768,32]{1,0} divide(multiply.1010, broadcast.903)
  subtract.1012 = f32[32768,32]{1,0} subtract(add.1009, divide.1011)
  divide.1013 = f32[32768,32]{1,0} divide(multiply.973, broadcast.911)
  subtract.1014 = f32[32768,32]{1,0} subtract(subtract.1012, divide.1013)
  divide.1015 = f32[32768,32]{1,0} divide(multiply.974, broadcast.903)
  add.1016 = f32[32768,32]{1,0} add(subtract.1014, divide.1015)
  slice.1044 = f32[32768,32,1]{2,1,0} slice(reshape.970), slice={[0:32768], [0:32], [3:4]}
  reshape.1045 = f32[32768,32]{1,0} reshape(slice.1044)
  multiply.1046 = f32[32768,32]{1,0} multiply(add.1016, reshape.1045)
  add.1047 = f32[32768,32]{1,0} add(add.1043, multiply.1046)
  divide.1017 = f32[32768,32]{1,0} divide(subtract.944, broadcast.905)
  negate.1018 = f32[32768,32]{1,0} negate(divide.1017)
  divide.1019 = f32[32768,32]{1,0} divide(multiply.971, broadcast.919)
  subtract.1020 = f32[32768,32]{1,0} subtract(negate.1018, divide.1019)
  multiply.1021 = f32[32768,32]{1,0} multiply(multiply.972, broadcast.901)
  divide.1022 = f32[32768,32]{1,0} divide(multiply.1021, broadcast.919)
  add.1023 = f32[32768,32]{1,0} add(subtract.1020, divide.1022)
  divide.1024 = f32[32768,32]{1,0} divide(multiply.973, broadcast.919)
  add.1025 = f32[32768,32]{1,0} add(add.1023, divide.1024)
  divide.1026 = f32[32768,32]{1,0} divide(multiply.974, broadcast.919)
  subtract.1027 = f32[32768,32]{1,0} subtract(add.1025, divide.1026)
  slice.1048 = f32[32768,32,1]{2,1,0} slice(reshape.970), slice={[0:32768], [0:32], [4:5]}
  reshape.1049 = f32[32768,32]{1,0} reshape(slice.1048)
  multiply.1050 = f32[32768,32]{1,0} multiply(subtract.1027, reshape.1049)
  add.1051 = f32[32768,32]{1,0} add(add.1047, multiply.1050)
  constant.898 = f32[] constant(30)
  broadcast.899 = f32[32768,32]{1,0} broadcast(constant.898), dimensions={}
  divide.1028 = f32[32768,32]{1,0} divide(subtract.944, broadcast.899)
  divide.1029 = f32[32768,32]{1,0} divide(multiply.972, broadcast.919)
  subtract.1030 = f32[32768,32]{1,0} subtract(divide.1028, divide.1029)
  divide.1031 = f32[32768,32]{1,0} divide(multiply.974, broadcast.917)
  add.1032 = f32[32768,32]{1,0} add(subtract.1030, divide.1031)
  slice.1052 = f32[32768,32,1]{2,1,0} slice(reshape.970), slice={[0:32768], [0:32], [5:6]}
  reshape.1053 = f32[32768,32]{1,0} reshape(slice.1052)
  multiply.1054 = f32[32768,32]{1,0} multiply(add.1032, reshape.1053)
  ROOT add.1055 = f32[32768,32]{1,0} add(add.1051, multiply.1054)
}

_where.1064 {
  Arg_0.1065 = pred[] parameter(0)
  Arg_1.1066 = s32[] parameter(1)
  Arg_2.1067 = s32[] parameter(2)
  ROOT select.1068 = s32[] select(Arg_0.1065, Arg_1.1066, Arg_2.1067)
}

remainder.1069 {
  Arg_0.1070 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.1071 = s32[] parameter(1)
  constant.1075 = s32[] constant(0)
  compare.1076 = pred[] compare(Arg_1.1071, constant.1075), direction=EQ
  constant.1074 = s32[] constant(1)
  call.1077 = s32[] call(compare.1076, constant.1074, Arg_1.1071), to_apply=_where.1064
  broadcast.1078 = s32[32768,32,6]{2,1,0} broadcast(call.1077), dimensions={}
  remainder.1079 = s32[32768,32,6]{2,1,0} remainder(Arg_0.1070, broadcast.1078)
  constant.1072 = s32[] constant(0)
  broadcast.1073 = s32[32768,32,6]{2,1,0} broadcast(constant.1072), dimensions={}
  compare.1081 = pred[32768,32,6]{2,1,0} compare(remainder.1079, broadcast.1073), direction=LT
  compare.1082 = pred[] compare(call.1077, constant.1075), direction=LT
  broadcast.1083 = pred[32768,32,6]{2,1,0} broadcast(compare.1082), dimensions={}
  compare.1084 = pred[32768,32,6]{2,1,0} compare(compare.1081, broadcast.1083), direction=NE
  compare.1080 = pred[32768,32,6]{2,1,0} compare(remainder.1079, broadcast.1073), direction=NE
  and.1085 = pred[32768,32,6]{2,1,0} and(compare.1084, compare.1080)
  broadcast.1086 = s32[32768,32,6]{2,1,0} broadcast(call.1077), dimensions={}
  add.1087 = s32[32768,32,6]{2,1,0} add(remainder.1079, broadcast.1086)
  ROOT select.1088 = s32[32768,32,6]{2,1,0} select(and.1085, add.1087, remainder.1079)
}

advect_1d_vectorized.1089 {
  iota.1126 = f32[32]{0} iota(), iota_dimension=0
  reshape.1132 = f32[1,32]{1,0} reshape(iota.1126)
  broadcast.1133 = f32[1,32]{1,0} broadcast(reshape.1132), dimensions={0,1}
  reshape.1134 = f32[32]{0} reshape(broadcast.1133)
  broadcast.1135 = f32[32768,32]{1,0} broadcast(reshape.1134), dimensions={1}
  Arg_1.1091 = f32[32768]{0} parameter(1)
  reshape.1127 = f32[32768,1]{1,0} reshape(Arg_1.1091)
  Arg_2.1092 = f32[] parameter(2)
  broadcast.1128 = f32[32768,1]{1,0} broadcast(Arg_2.1092), dimensions={}
  multiply.1129 = f32[32768,1]{1,0} multiply(reshape.1127, broadcast.1128)
  Arg_3.1093 = f32[] parameter(3)
  broadcast.1130 = f32[32768,1]{1,0} broadcast(Arg_3.1093), dimensions={}
  divide.1131 = f32[32768,1]{1,0} divide(multiply.1129, broadcast.1130)
  broadcast.1136 = f32[32768,1]{1,0} broadcast(divide.1131), dimensions={0,1}
  reshape.1137 = f32[32768]{0} reshape(broadcast.1136)
  broadcast.1138 = f32[32768,32]{1,0} broadcast(reshape.1137), dimensions={0}
  subtract.1139 = f32[32768,32]{1,0} subtract(broadcast.1135, broadcast.1138)
  floor.1140 = f32[32768,32]{1,0} floor(subtract.1139)
  subtract.1141 = f32[32768,32]{1,0} subtract(subtract.1139, floor.1140)
  constant.1117 = f32[] constant(20)
  broadcast.1118 = f32[32768,32]{1,0} broadcast(constant.1117), dimensions={}
  divide.1172 = f32[32768,32]{1,0} divide(subtract.1141, broadcast.1118)
  multiply.1168 = f32[32768,32]{1,0} multiply(subtract.1141, subtract.1141)
  constant.1115 = f32[] constant(24)
  broadcast.1116 = f32[32768,32]{1,0} broadcast(constant.1115), dimensions={}
  divide.1173 = f32[32768,32]{1,0} divide(multiply.1168, broadcast.1116)
  subtract.1174 = f32[32768,32]{1,0} subtract(divide.1172, divide.1173)
  multiply.1169 = f32[32768,32]{1,0} multiply(multiply.1168, subtract.1141)
  divide.1175 = f32[32768,32]{1,0} divide(multiply.1169, broadcast.1116)
  subtract.1176 = f32[32768,32]{1,0} subtract(subtract.1174, divide.1175)
  multiply.1170 = f32[32768,32]{1,0} multiply(multiply.1169, subtract.1141)
  divide.1177 = f32[32768,32]{1,0} divide(multiply.1170, broadcast.1116)
  add.1178 = f32[32768,32]{1,0} add(subtract.1176, divide.1177)
  multiply.1171 = f32[32768,32]{1,0} multiply(multiply.1170, subtract.1141)
  constant.1113 = f32[] constant(120)
  broadcast.1114 = f32[32768,32]{1,0} broadcast(constant.1113), dimensions={}
  divide.1179 = f32[32768,32]{1,0} divide(multiply.1171, broadcast.1114)
  subtract.1180 = f32[32768,32]{1,0} subtract(add.1178, divide.1179)
  Arg_0.1090 = f32[32768,32]{1,0} parameter(0)
  reshape.1160 = f32[1048576]{0} reshape(Arg_0.1090)
  iota.1153 = s32[32768]{0} iota(), iota_dimension=0
  reshape.1154 = s32[32768,1,1]{2,1,0} reshape(iota.1153)
  constant.1123 = s32[] constant(32)
  broadcast.1124 = s32[32768,1,1]{2,1,0} broadcast(constant.1123), dimensions={}
  multiply.1155 = s32[32768,1,1]{2,1,0} multiply(reshape.1154, broadcast.1124)
  broadcast.1156 = s32[32768,1,1]{2,1,0} broadcast(multiply.1155), dimensions={0,1,2}
  reshape.1157 = s32[32768]{0} reshape(broadcast.1156)
  broadcast.1158 = s32[32768,32,6]{2,1,0} broadcast(reshape.1157), dimensions={0}
  convert.1142 = s32[32768,32]{1,0} convert(floor.1140)
  reshape.1143 = s32[32768,32,1]{2,1,0} reshape(convert.1142)
  broadcast.1145 = s32[32768,32,1]{2,1,0} broadcast(reshape.1143), dimensions={0,1,2}
  reshape.1146 = s32[32768,32]{1,0} reshape(broadcast.1145)
  broadcast.1147 = s32[32768,32,6]{2,1,0} broadcast(reshape.1146), dimensions={0,1}
  Arg_4.1094 = s32[6]{0} parameter(4)
  reshape.1144 = s32[1,1,6]{2,1,0} reshape(Arg_4.1094)
  broadcast.1148 = s32[1,1,6]{2,1,0} broadcast(reshape.1144), dimensions={0,1,2}
  reshape.1149 = s32[6]{0} reshape(broadcast.1148)
  broadcast.1150 = s32[32768,32,6]{2,1,0} broadcast(reshape.1149), dimensions={2}
  add.1151 = s32[32768,32,6]{2,1,0} add(broadcast.1147, broadcast.1150)
  constant.1125 = s32[] constant(32)
  call.1152 = s32[32768,32,6]{2,1,0} call(add.1151, constant.1125), to_apply=remainder.1069
  add.1159 = s32[32768,32,6]{2,1,0} add(broadcast.1158, call.1152)
  reshape.1161 = s32[6291456]{0} reshape(add.1159)
  constant.1121 = s32[] constant(0)
  broadcast.1122 = s32[6291456]{0} broadcast(constant.1121), dimensions={}
  compare.1162 = pred[6291456]{0} compare(reshape.1161, broadcast.1122), direction=LT
  constant.1119 = s32[] constant(1048576)
  broadcast.1120 = s32[6291456]{0} broadcast(constant.1119), dimensions={}
  add.1163 = s32[6291456]{0} add(reshape.1161, broadcast.1120)
  select.1164 = s32[6291456]{0} select(compare.1162, add.1163, reshape.1161)
  reshape.1165 = s32[6291456,1]{1,0} reshape(select.1164)
  gather.1166 = f32[6291456]{0} gather(reshape.1160, reshape.1165), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.1167 = f32[32768,32,6]{2,1,0} reshape(gather.1166)
  slice.1230 = f32[32768,32,1]{2,1,0} slice(reshape.1167), slice={[0:32768], [0:32], [0:1]}
  reshape.1231 = f32[32768,32]{1,0} reshape(slice.1230)
  multiply.1232 = f32[32768,32]{1,0} multiply(subtract.1180, reshape.1231)
  constant.1111 = f32[] constant(2)
  broadcast.1112 = f32[32768,32]{1,0} broadcast(constant.1111), dimensions={}
  divide.1181 = f32[32768,32]{1,0} divide(subtract.1141, broadcast.1112)
  negate.1182 = f32[32768,32]{1,0} negate(divide.1181)
  multiply.1183 = f32[32768,32]{1,0} multiply(multiply.1168, broadcast.1112)
  constant.1109 = f32[] constant(3)
  broadcast.1110 = f32[32768,32]{1,0} broadcast(constant.1109), dimensions={}
  divide.1184 = f32[32768,32]{1,0} divide(multiply.1183, broadcast.1110)
  add.1185 = f32[32768,32]{1,0} add(negate.1182, divide.1184)
  divide.1186 = f32[32768,32]{1,0} divide(multiply.1169, broadcast.1116)
  subtract.1187 = f32[32768,32]{1,0} subtract(add.1185, divide.1186)
  constant.1107 = f32[] constant(6)
  broadcast.1108 = f32[32768,32]{1,0} broadcast(constant.1107), dimensions={}
  divide.1188 = f32[32768,32]{1,0} divide(multiply.1170, broadcast.1108)
  subtract.1189 = f32[32768,32]{1,0} subtract(subtract.1187, divide.1188)
  divide.1190 = f32[32768,32]{1,0} divide(multiply.1171, broadcast.1116)
  add.1191 = f32[32768,32]{1,0} add(subtract.1189, divide.1190)
  slice.1233 = f32[32768,32,1]{2,1,0} slice(reshape.1167), slice={[0:32768], [0:32], [1:2]}
  reshape.1234 = f32[32768,32]{1,0} reshape(slice.1233)
  multiply.1235 = f32[32768,32]{1,0} multiply(add.1191, reshape.1234)
  add.1236 = f32[32768,32]{1,0} add(multiply.1232, multiply.1235)
  constant.1105 = f32[] constant(1)
  broadcast.1106 = f32[32768,32]{1,0} broadcast(constant.1105), dimensions={}
  divide.1192 = f32[32768,32]{1,0} divide(subtract.1141, broadcast.1110)
  subtract.1193 = f32[32768,32]{1,0} subtract(broadcast.1106, divide.1192)
  constant.1103 = f32[] constant(5)
  broadcast.1104 = f32[32768,32]{1,0} broadcast(constant.1103), dimensions={}
  multiply.1194 = f32[32768,32]{1,0} multiply(multiply.1168, broadcast.1104)
  constant.1101 = f32[] constant(4)
  broadcast.1102 = f32[32768,32]{1,0} broadcast(constant.1101), dimensions={}
  divide.1195 = f32[32768,32]{1,0} divide(multiply.1194, broadcast.1102)
  subtract.1196 = f32[32768,32]{1,0} subtract(subtract.1193, divide.1195)
  multiply.1197 = f32[32768,32]{1,0} multiply(multiply.1169, broadcast.1104)
  constant.1099 = f32[] constant(12)
  broadcast.1100 = f32[32768,32]{1,0} broadcast(constant.1099), dimensions={}
  divide.1198 = f32[32768,32]{1,0} divide(multiply.1197, broadcast.1100)
  add.1199 = f32[32768,32]{1,0} add(subtract.1196, divide.1198)
  divide.1200 = f32[32768,32]{1,0} divide(multiply.1170, broadcast.1102)
  add.1201 = f32[32768,32]{1,0} add(add.1199, divide.1200)
  divide.1202 = f32[32768,32]{1,0} divide(multiply.1171, broadcast.1100)
  subtract.1203 = f32[32768,32]{1,0} subtract(add.1201, divide.1202)
  slice.1237 = f32[32768,32,1]{2,1,0} slice(reshape.1167), slice={[0:32768], [0:32], [2:3]}
  reshape.1238 = f32[32768,32]{1,0} reshape(slice.1237)
  multiply.1239 = f32[32768,32]{1,0} multiply(subtract.1203, reshape.1238)
  add.1240 = f32[32768,32]{1,0} add(add.1236, multiply.1239)
  multiply.1204 = f32[32768,32]{1,0} multiply(multiply.1168, broadcast.1112)
  divide.1205 = f32[32768,32]{1,0} divide(multiply.1204, broadcast.1110)
  add.1206 = f32[32768,32]{1,0} add(subtract.1141, divide.1205)
  constant.1097 = f32[] constant(7)
  broadcast.1098 = f32[32768,32]{1,0} broadcast(constant.1097), dimensions={}
  multiply.1207 = f32[32768,32]{1,0} multiply(multiply.1169, broadcast.1098)
  divide.1208 = f32[32768,32]{1,0} divide(multiply.1207, broadcast.1100)
  subtract.1209 = f32[32768,32]{1,0} subtract(add.1206, divide.1208)
  divide.1210 = f32[32768,32]{1,0} divide(multiply.1170, broadcast.1108)
  subtract.1211 = f32[32768,32]{1,0} subtract(subtract.1209, divide.1210)
  divide.1212 = f32[32768,32]{1,0} divide(multiply.1171, broadcast.1100)
  add.1213 = f32[32768,32]{1,0} add(subtract.1211, divide.1212)
  slice.1241 = f32[32768,32,1]{2,1,0} slice(reshape.1167), slice={[0:32768], [0:32], [3:4]}
  reshape.1242 = f32[32768,32]{1,0} reshape(slice.1241)
  multiply.1243 = f32[32768,32]{1,0} multiply(add.1213, reshape.1242)
  add.1244 = f32[32768,32]{1,0} add(add.1240, multiply.1243)
  divide.1214 = f32[32768,32]{1,0} divide(subtract.1141, broadcast.1102)
  negate.1215 = f32[32768,32]{1,0} negate(divide.1214)
  divide.1216 = f32[32768,32]{1,0} divide(multiply.1168, broadcast.1116)
  subtract.1217 = f32[32768,32]{1,0} subtract(negate.1215, divide.1216)
  multiply.1218 = f32[32768,32]{1,0} multiply(multiply.1169, broadcast.1098)
  divide.1219 = f32[32768,32]{1,0} divide(multiply.1218, broadcast.1116)
  add.1220 = f32[32768,32]{1,0} add(subtract.1217, divide.1219)
  divide.1221 = f32[32768,32]{1,0} divide(multiply.1170, broadcast.1116)
  add.1222 = f32[32768,32]{1,0} add(add.1220, divide.1221)
  divide.1223 = f32[32768,32]{1,0} divide(multiply.1171, broadcast.1116)
  subtract.1224 = f32[32768,32]{1,0} subtract(add.1222, divide.1223)
  slice.1245 = f32[32768,32,1]{2,1,0} slice(reshape.1167), slice={[0:32768], [0:32], [4:5]}
  reshape.1246 = f32[32768,32]{1,0} reshape(slice.1245)
  multiply.1247 = f32[32768,32]{1,0} multiply(subtract.1224, reshape.1246)
  add.1248 = f32[32768,32]{1,0} add(add.1244, multiply.1247)
  constant.1095 = f32[] constant(30)
  broadcast.1096 = f32[32768,32]{1,0} broadcast(constant.1095), dimensions={}
  divide.1225 = f32[32768,32]{1,0} divide(subtract.1141, broadcast.1096)
  divide.1226 = f32[32768,32]{1,0} divide(multiply.1169, broadcast.1116)
  subtract.1227 = f32[32768,32]{1,0} subtract(divide.1225, divide.1226)
  divide.1228 = f32[32768,32]{1,0} divide(multiply.1171, broadcast.1114)
  add.1229 = f32[32768,32]{1,0} add(subtract.1227, divide.1228)
  slice.1249 = f32[32768,32,1]{2,1,0} slice(reshape.1167), slice={[0:32768], [0:32], [5:6]}
  reshape.1250 = f32[32768,32]{1,0} reshape(slice.1249)
  multiply.1251 = f32[32768,32]{1,0} multiply(add.1229, reshape.1250)
  ROOT add.1252 = f32[32768,32]{1,0} add(add.1248, multiply.1251)
}

ENTRY main.1257 {
  Arg_0.1 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  transpose.12 = f32[32,32,32,32]{2,1,0,3} transpose(Arg_0.1), dimensions={1,2,3,0}
  reshape.13 = f32[32768,32]{1,0} reshape(transpose.12)
  constant.11 = f32[1,32,1]{2,1,0} constant({...})
  broadcast.14 = f32[1,32,1]{2,1,0} broadcast(constant.11), dimensions={0,1,2}
  reshape.15 = f32[32]{0} reshape(broadcast.14)
  broadcast.16 = f32[32,32,32]{2,1,0} broadcast(reshape.15), dimensions={1}
  reshape.17 = f32[32768]{0} reshape(broadcast.16)
  constant.6 = f32[] constant(0.025)
  constant.5 = f32[] constant(0.392699093)
  constant.7 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  call.207 = f32[32768,32]{1,0} call(reshape.13, reshape.17, constant.6, constant.5, constant.7), to_apply=advect_1d_vectorized.43
  reshape.208 = f32[32,32,32,32]{3,2,1,0} reshape(call.207)
  transpose.209 = f32[32,32,32,32]{0,2,1,3} transpose(reshape.208), dimensions={3,1,2,0}
  reshape.210 = f32[32768,32]{1,0} reshape(transpose.209)
  constant.2 = f32[1,1,32]{2,1,0} constant({...})
  broadcast.211 = f32[1,1,32]{2,1,0} broadcast(constant.2), dimensions={0,1,2}
  reshape.212 = f32[32]{0} reshape(broadcast.211)
  broadcast.213 = f32[32,32,32]{2,1,0} broadcast(reshape.212), dimensions={2}
  reshape.214 = f32[32768]{0} reshape(broadcast.213)
  call.404 = f32[32768,32]{1,0} call(reshape.210, reshape.214, constant.6, constant.5, constant.7), to_apply=advect_1d_vectorized.240
  reshape.405 = f32[32,32,32,32]{3,2,1,0} reshape(call.404)
  transpose.468 = f32[32,32,32,32]{1,2,3,0} transpose(reshape.405), dimensions={0,3,2,1}
  reshape.469 = f32[32768,32]{1,0} reshape(transpose.468)
  transpose.406 = f32[32,32,32,32]{1,3,2,0} transpose(reshape.405), dimensions={0,3,1,2}
  constant.8 = f32[32,1]{1,0} constant({...})
  constant.9 = f32[1,17]{1,0} constant({...})
  constant.10 = f32[32,17]{1,0} constant({...})
  constant.4 = f32[] constant(0.322580636)
  call.462 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) call(transpose.406, constant.8, constant.9, constant.10, constant.4, constant.4), to_apply=solve_poisson.423
  get-tuple-element.463 = f32[32,32]{1,0} get-tuple-element(call.462), index=0
  reshape.467 = f32[32,32,1]{2,1,0} reshape(get-tuple-element.463)
  broadcast.470 = f32[32,32,1]{2,1,0} broadcast(reshape.467), dimensions={0,1,2}
  reshape.471 = f32[32,32]{1,0} reshape(broadcast.470)
  broadcast.472 = f32[32,32,32]{2,1,0} broadcast(reshape.471), dimensions={0,1}
  reshape.473 = f32[32768]{0} reshape(broadcast.472)
  constant.3 = f32[] constant(0.05)
  call.662 = f32[32768,32]{1,0} call(reshape.469, reshape.473, constant.3, constant.4, constant.7), to_apply=advect_1d_vectorized_1.488
  reshape.663 = f32[32,32,32,32]{3,2,1,0} reshape(call.662)
  transpose.664 = f32[32,32,32,32]{2,3,1,0} transpose(reshape.663), dimensions={0,1,3,2}
  reshape.666 = f32[32768,32]{1,0} reshape(transpose.664)
  get-tuple-element.464 = f32[32,32]{1,0} get-tuple-element(call.462), index=1
  reshape.665 = f32[32,32,1]{2,1,0} reshape(get-tuple-element.464)
  broadcast.667 = f32[32,32,1]{2,1,0} broadcast(reshape.665), dimensions={0,1,2}
  reshape.668 = f32[32,32]{1,0} reshape(broadcast.667)
  broadcast.669 = f32[32,32,32]{2,1,0} broadcast(reshape.668), dimensions={0,1}
  reshape.670 = f32[32768]{0} reshape(broadcast.669)
  call.859 = f32[32768,32]{1,0} call(reshape.666, reshape.670, constant.3, constant.4, constant.7), to_apply=advect_1d_vectorized_1.685
  reshape.860 = f32[32,32,32,32]{3,2,1,0} reshape(call.859)
  transpose.861 = f32[32,32,32,32]{2,1,3,0} transpose(reshape.860), dimensions={0,2,3,1}
  reshape.862 = f32[32768,32]{1,0} reshape(transpose.861)
  broadcast.863 = f32[1,1,32]{2,1,0} broadcast(constant.2), dimensions={0,1,2}
  reshape.864 = f32[32]{0} reshape(broadcast.863)
  broadcast.865 = f32[32,32,32]{2,1,0} broadcast(reshape.864), dimensions={2}
  reshape.866 = f32[32768]{0} reshape(broadcast.865)
  call.1056 = f32[32768,32]{1,0} call(reshape.862, reshape.866, constant.6, constant.5, constant.7), to_apply=advect_1d_vectorized.892
  reshape.1057 = f32[32,32,32,32]{3,2,1,0} reshape(call.1056)
  transpose.1058 = f32[32,32,32,32]{0,2,1,3} transpose(reshape.1057), dimensions={3,1,2,0}
  reshape.1059 = f32[32768,32]{1,0} reshape(transpose.1058)
  broadcast.1060 = f32[1,32,1]{2,1,0} broadcast(constant.11), dimensions={0,1,2}
  reshape.1061 = f32[32]{0} reshape(broadcast.1060)
  broadcast.1062 = f32[32,32,32]{2,1,0} broadcast(reshape.1061), dimensions={1}
  reshape.1063 = f32[32768]{0} reshape(broadcast.1062)
  call.1253 = f32[32768,32]{1,0} call(reshape.1059, reshape.1063, constant.6, constant.5, constant.7), to_apply=advect_1d_vectorized.1089
  reshape.1254 = f32[32,32,32,32]{3,2,1,0} reshape(call.1253)
  transpose.1255 = f32[32,32,32,32]{0,3,2,1} transpose(reshape.1254), dimensions={3,0,1,2}
  get-tuple-element.465 = f32[32,32]{1,0} get-tuple-element(call.462), index=2
  get-tuple-element.466 = f32[32,32]{1,0} get-tuple-element(call.462), index=3
  ROOT tuple.1256 = (f32[32,32,32,32]{0,3,2,1}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(transpose.1255, get-tuple-element.465, get-tuple-element.466)
}

