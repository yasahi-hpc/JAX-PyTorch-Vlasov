HloModule jit_run_chunk, entry_computation_layout={(f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[], /*index=5*/s64[])->(f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32,1]{1,0}, /*index=5*/f64[1,17]{1,0}, f64[32,17]{1,0}, s32[6]{0}, f64[32,32]{1,0}, f64[32,32]{1,0}, /*index=10*/f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[], s64[])}

_where.17 {
  Arg_0.18 = pred[] parameter(0)
  Arg_1.19 = s32[] parameter(1)
  Arg_2.20 = s32[] parameter(2)
  ROOT select.21 = s32[] select(Arg_0.18, Arg_1.19, Arg_2.20)
}

remainder.22 {
  Arg_0.23 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.24 = s64[] parameter(1)
  convert.29 = s32[] convert(Arg_1.24)
  constant.28 = s32[] constant(0)
  compare.30 = pred[] compare(convert.29, constant.28), direction=EQ
  constant.27 = s32[] constant(1)
  call.31 = s32[] call(compare.30, constant.27, convert.29), to_apply=_where.17
  broadcast.32 = s32[32768,32,6]{2,1,0} broadcast(call.31), dimensions={}
  remainder.33 = s32[32768,32,6]{2,1,0} remainder(Arg_0.23, broadcast.32)
  constant.25 = s32[] constant(0)
  broadcast.26 = s32[32768,32,6]{2,1,0} broadcast(constant.25), dimensions={}
  compare.35 = pred[32768,32,6]{2,1,0} compare(remainder.33, broadcast.26), direction=LT
  compare.36 = pred[] compare(call.31, constant.28), direction=LT
  broadcast.37 = pred[32768,32,6]{2,1,0} broadcast(compare.36), dimensions={}
  compare.38 = pred[32768,32,6]{2,1,0} compare(compare.35, broadcast.37), direction=NE
  compare.34 = pred[32768,32,6]{2,1,0} compare(remainder.33, broadcast.26), direction=NE
  and.39 = pred[32768,32,6]{2,1,0} and(compare.38, compare.34)
  broadcast.40 = s32[32768,32,6]{2,1,0} broadcast(call.31), dimensions={}
  add.41 = s32[32768,32,6]{2,1,0} add(remainder.33, broadcast.40)
  ROOT select.42 = s32[32768,32,6]{2,1,0} select(and.39, add.41, remainder.33)
}

advect_1d_vectorized.43 {
  iota.80 = f64[32]{0} iota(), iota_dimension=0
  reshape.86 = f64[1,32]{1,0} reshape(iota.80)
  broadcast.87 = f64[1,32]{1,0} broadcast(reshape.86), dimensions={0,1}
  reshape.88 = f64[32]{0} reshape(broadcast.87)
  broadcast.89 = f64[32768,32]{1,0} broadcast(reshape.88), dimensions={1}
  Arg_1.45 = f64[32768]{0} parameter(1)
  reshape.81 = f64[32768,1]{1,0} reshape(Arg_1.45)
  Arg_2.46 = f64[] parameter(2)
  broadcast.82 = f64[32768,1]{1,0} broadcast(Arg_2.46), dimensions={}
  multiply.83 = f64[32768,1]{1,0} multiply(reshape.81, broadcast.82)
  Arg_3.47 = f64[] parameter(3)
  broadcast.84 = f64[32768,1]{1,0} broadcast(Arg_3.47), dimensions={}
  divide.85 = f64[32768,1]{1,0} divide(multiply.83, broadcast.84)
  broadcast.90 = f64[32768,1]{1,0} broadcast(divide.85), dimensions={0,1}
  reshape.91 = f64[32768]{0} reshape(broadcast.90)
  broadcast.92 = f64[32768,32]{1,0} broadcast(reshape.91), dimensions={0}
  subtract.93 = f64[32768,32]{1,0} subtract(broadcast.89, broadcast.92)
  floor.94 = f64[32768,32]{1,0} floor(subtract.93)
  subtract.95 = f64[32768,32]{1,0} subtract(subtract.93, floor.94)
  constant.71 = f64[] constant(20)
  broadcast.72 = f64[32768,32]{1,0} broadcast(constant.71), dimensions={}
  divide.128 = f64[32768,32]{1,0} divide(subtract.95, broadcast.72)
  multiply.124 = f64[32768,32]{1,0} multiply(subtract.95, subtract.95)
  constant.69 = f64[] constant(24)
  broadcast.70 = f64[32768,32]{1,0} broadcast(constant.69), dimensions={}
  divide.129 = f64[32768,32]{1,0} divide(multiply.124, broadcast.70)
  subtract.130 = f64[32768,32]{1,0} subtract(divide.128, divide.129)
  multiply.125 = f64[32768,32]{1,0} multiply(multiply.124, subtract.95)
  divide.131 = f64[32768,32]{1,0} divide(multiply.125, broadcast.70)
  subtract.132 = f64[32768,32]{1,0} subtract(subtract.130, divide.131)
  multiply.126 = f64[32768,32]{1,0} multiply(multiply.125, subtract.95)
  divide.133 = f64[32768,32]{1,0} divide(multiply.126, broadcast.70)
  add.134 = f64[32768,32]{1,0} add(subtract.132, divide.133)
  multiply.127 = f64[32768,32]{1,0} multiply(multiply.126, subtract.95)
  constant.67 = f64[] constant(120)
  broadcast.68 = f64[32768,32]{1,0} broadcast(constant.67), dimensions={}
  divide.135 = f64[32768,32]{1,0} divide(multiply.127, broadcast.68)
  subtract.136 = f64[32768,32]{1,0} subtract(add.134, divide.135)
  Arg_0.44 = f64[32768,32]{1,0} parameter(0)
  reshape.115 = f64[1048576]{0} reshape(Arg_0.44)
  iota.107 = s64[32768]{0} iota(), iota_dimension=0
  reshape.108 = s64[32768,1,1]{2,1,0} reshape(iota.107)
  constant.77 = s64[] constant(32)
  broadcast.78 = s64[32768,1,1]{2,1,0} broadcast(constant.77), dimensions={}
  multiply.109 = s64[32768,1,1]{2,1,0} multiply(reshape.108, broadcast.78)
  broadcast.111 = s64[32768,1,1]{2,1,0} broadcast(multiply.109), dimensions={0,1,2}
  reshape.112 = s64[32768]{0} reshape(broadcast.111)
  broadcast.113 = s64[32768,32,6]{2,1,0} broadcast(reshape.112), dimensions={0}
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
  constant.79 = s64[] constant(32)
  call.106 = s32[32768,32,6]{2,1,0} call(add.105, constant.79), to_apply=remainder.22
  convert.110 = s64[32768,32,6]{2,1,0} convert(call.106)
  add.114 = s64[32768,32,6]{2,1,0} add(broadcast.113, convert.110)
  reshape.116 = s64[6291456]{0} reshape(add.114)
  constant.75 = s64[] constant(0)
  broadcast.76 = s64[6291456]{0} broadcast(constant.75), dimensions={}
  compare.117 = pred[6291456]{0} compare(reshape.116, broadcast.76), direction=LT
  constant.73 = s64[] constant(1048576)
  broadcast.74 = s64[6291456]{0} broadcast(constant.73), dimensions={}
  add.118 = s64[6291456]{0} add(reshape.116, broadcast.74)
  select.119 = s64[6291456]{0} select(compare.117, add.118, reshape.116)
  convert.120 = s32[6291456]{0} convert(select.119)
  reshape.121 = s32[6291456,1]{1,0} reshape(convert.120)
  gather.122 = f64[6291456]{0} gather(reshape.115, reshape.121), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.123 = f64[32768,32,6]{2,1,0} reshape(gather.122)
  slice.186 = f64[32768,32,1]{2,1,0} slice(reshape.123), slice={[0:32768], [0:32], [0:1]}
  reshape.187 = f64[32768,32]{1,0} reshape(slice.186)
  multiply.188 = f64[32768,32]{1,0} multiply(subtract.136, reshape.187)
  constant.65 = f64[] constant(2)
  broadcast.66 = f64[32768,32]{1,0} broadcast(constant.65), dimensions={}
  divide.137 = f64[32768,32]{1,0} divide(subtract.95, broadcast.66)
  negate.138 = f64[32768,32]{1,0} negate(divide.137)
  multiply.139 = f64[32768,32]{1,0} multiply(multiply.124, broadcast.66)
  constant.63 = f64[] constant(3)
  broadcast.64 = f64[32768,32]{1,0} broadcast(constant.63), dimensions={}
  divide.140 = f64[32768,32]{1,0} divide(multiply.139, broadcast.64)
  add.141 = f64[32768,32]{1,0} add(negate.138, divide.140)
  divide.142 = f64[32768,32]{1,0} divide(multiply.125, broadcast.70)
  subtract.143 = f64[32768,32]{1,0} subtract(add.141, divide.142)
  constant.61 = f64[] constant(6)
  broadcast.62 = f64[32768,32]{1,0} broadcast(constant.61), dimensions={}
  divide.144 = f64[32768,32]{1,0} divide(multiply.126, broadcast.62)
  subtract.145 = f64[32768,32]{1,0} subtract(subtract.143, divide.144)
  divide.146 = f64[32768,32]{1,0} divide(multiply.127, broadcast.70)
  add.147 = f64[32768,32]{1,0} add(subtract.145, divide.146)
  slice.189 = f64[32768,32,1]{2,1,0} slice(reshape.123), slice={[0:32768], [0:32], [1:2]}
  reshape.190 = f64[32768,32]{1,0} reshape(slice.189)
  multiply.191 = f64[32768,32]{1,0} multiply(add.147, reshape.190)
  add.192 = f64[32768,32]{1,0} add(multiply.188, multiply.191)
  constant.59 = f64[] constant(1)
  broadcast.60 = f64[32768,32]{1,0} broadcast(constant.59), dimensions={}
  divide.148 = f64[32768,32]{1,0} divide(subtract.95, broadcast.64)
  subtract.149 = f64[32768,32]{1,0} subtract(broadcast.60, divide.148)
  constant.57 = f64[] constant(5)
  broadcast.58 = f64[32768,32]{1,0} broadcast(constant.57), dimensions={}
  multiply.150 = f64[32768,32]{1,0} multiply(multiply.124, broadcast.58)
  constant.55 = f64[] constant(4)
  broadcast.56 = f64[32768,32]{1,0} broadcast(constant.55), dimensions={}
  divide.151 = f64[32768,32]{1,0} divide(multiply.150, broadcast.56)
  subtract.152 = f64[32768,32]{1,0} subtract(subtract.149, divide.151)
  multiply.153 = f64[32768,32]{1,0} multiply(multiply.125, broadcast.58)
  constant.53 = f64[] constant(12)
  broadcast.54 = f64[32768,32]{1,0} broadcast(constant.53), dimensions={}
  divide.154 = f64[32768,32]{1,0} divide(multiply.153, broadcast.54)
  add.155 = f64[32768,32]{1,0} add(subtract.152, divide.154)
  divide.156 = f64[32768,32]{1,0} divide(multiply.126, broadcast.56)
  add.157 = f64[32768,32]{1,0} add(add.155, divide.156)
  divide.158 = f64[32768,32]{1,0} divide(multiply.127, broadcast.54)
  subtract.159 = f64[32768,32]{1,0} subtract(add.157, divide.158)
  slice.193 = f64[32768,32,1]{2,1,0} slice(reshape.123), slice={[0:32768], [0:32], [2:3]}
  reshape.194 = f64[32768,32]{1,0} reshape(slice.193)
  multiply.195 = f64[32768,32]{1,0} multiply(subtract.159, reshape.194)
  add.196 = f64[32768,32]{1,0} add(add.192, multiply.195)
  multiply.160 = f64[32768,32]{1,0} multiply(multiply.124, broadcast.66)
  divide.161 = f64[32768,32]{1,0} divide(multiply.160, broadcast.64)
  add.162 = f64[32768,32]{1,0} add(subtract.95, divide.161)
  constant.51 = f64[] constant(7)
  broadcast.52 = f64[32768,32]{1,0} broadcast(constant.51), dimensions={}
  multiply.163 = f64[32768,32]{1,0} multiply(multiply.125, broadcast.52)
  divide.164 = f64[32768,32]{1,0} divide(multiply.163, broadcast.54)
  subtract.165 = f64[32768,32]{1,0} subtract(add.162, divide.164)
  divide.166 = f64[32768,32]{1,0} divide(multiply.126, broadcast.62)
  subtract.167 = f64[32768,32]{1,0} subtract(subtract.165, divide.166)
  divide.168 = f64[32768,32]{1,0} divide(multiply.127, broadcast.54)
  add.169 = f64[32768,32]{1,0} add(subtract.167, divide.168)
  slice.197 = f64[32768,32,1]{2,1,0} slice(reshape.123), slice={[0:32768], [0:32], [3:4]}
  reshape.198 = f64[32768,32]{1,0} reshape(slice.197)
  multiply.199 = f64[32768,32]{1,0} multiply(add.169, reshape.198)
  add.200 = f64[32768,32]{1,0} add(add.196, multiply.199)
  divide.170 = f64[32768,32]{1,0} divide(subtract.95, broadcast.56)
  negate.171 = f64[32768,32]{1,0} negate(divide.170)
  divide.172 = f64[32768,32]{1,0} divide(multiply.124, broadcast.70)
  subtract.173 = f64[32768,32]{1,0} subtract(negate.171, divide.172)
  multiply.174 = f64[32768,32]{1,0} multiply(multiply.125, broadcast.52)
  divide.175 = f64[32768,32]{1,0} divide(multiply.174, broadcast.70)
  add.176 = f64[32768,32]{1,0} add(subtract.173, divide.175)
  divide.177 = f64[32768,32]{1,0} divide(multiply.126, broadcast.70)
  add.178 = f64[32768,32]{1,0} add(add.176, divide.177)
  divide.179 = f64[32768,32]{1,0} divide(multiply.127, broadcast.70)
  subtract.180 = f64[32768,32]{1,0} subtract(add.178, divide.179)
  slice.201 = f64[32768,32,1]{2,1,0} slice(reshape.123), slice={[0:32768], [0:32], [4:5]}
  reshape.202 = f64[32768,32]{1,0} reshape(slice.201)
  multiply.203 = f64[32768,32]{1,0} multiply(subtract.180, reshape.202)
  add.204 = f64[32768,32]{1,0} add(add.200, multiply.203)
  constant.49 = f64[] constant(30)
  broadcast.50 = f64[32768,32]{1,0} broadcast(constant.49), dimensions={}
  divide.181 = f64[32768,32]{1,0} divide(subtract.95, broadcast.50)
  divide.182 = f64[32768,32]{1,0} divide(multiply.125, broadcast.70)
  subtract.183 = f64[32768,32]{1,0} subtract(divide.181, divide.182)
  divide.184 = f64[32768,32]{1,0} divide(multiply.127, broadcast.68)
  add.185 = f64[32768,32]{1,0} add(subtract.183, divide.184)
  slice.205 = f64[32768,32,1]{2,1,0} slice(reshape.123), slice={[0:32768], [0:32], [5:6]}
  reshape.206 = f64[32768,32]{1,0} reshape(slice.205)
  multiply.207 = f64[32768,32]{1,0} multiply(add.185, reshape.206)
  ROOT add.208 = f64[32768,32]{1,0} add(add.204, multiply.207)
}

_where.209 {
  Arg_0.210 = pred[] parameter(0)
  Arg_1.211 = s32[] parameter(1)
  Arg_2.212 = s32[] parameter(2)
  ROOT select.213 = s32[] select(Arg_0.210, Arg_1.211, Arg_2.212)
}

remainder.214 {
  Arg_0.215 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.216 = s64[] parameter(1)
  convert.221 = s32[] convert(Arg_1.216)
  constant.220 = s32[] constant(0)
  compare.222 = pred[] compare(convert.221, constant.220), direction=EQ
  constant.219 = s32[] constant(1)
  call.223 = s32[] call(compare.222, constant.219, convert.221), to_apply=_where.209
  broadcast.224 = s32[32768,32,6]{2,1,0} broadcast(call.223), dimensions={}
  remainder.225 = s32[32768,32,6]{2,1,0} remainder(Arg_0.215, broadcast.224)
  constant.217 = s32[] constant(0)
  broadcast.218 = s32[32768,32,6]{2,1,0} broadcast(constant.217), dimensions={}
  compare.227 = pred[32768,32,6]{2,1,0} compare(remainder.225, broadcast.218), direction=LT
  compare.228 = pred[] compare(call.223, constant.220), direction=LT
  broadcast.229 = pred[32768,32,6]{2,1,0} broadcast(compare.228), dimensions={}
  compare.230 = pred[32768,32,6]{2,1,0} compare(compare.227, broadcast.229), direction=NE
  compare.226 = pred[32768,32,6]{2,1,0} compare(remainder.225, broadcast.218), direction=NE
  and.231 = pred[32768,32,6]{2,1,0} and(compare.230, compare.226)
  broadcast.232 = s32[32768,32,6]{2,1,0} broadcast(call.223), dimensions={}
  add.233 = s32[32768,32,6]{2,1,0} add(remainder.225, broadcast.232)
  ROOT select.234 = s32[32768,32,6]{2,1,0} select(and.231, add.233, remainder.225)
}

advect_1d_vectorized.235 {
  iota.272 = f64[32]{0} iota(), iota_dimension=0
  reshape.278 = f64[1,32]{1,0} reshape(iota.272)
  broadcast.279 = f64[1,32]{1,0} broadcast(reshape.278), dimensions={0,1}
  reshape.280 = f64[32]{0} reshape(broadcast.279)
  broadcast.281 = f64[32768,32]{1,0} broadcast(reshape.280), dimensions={1}
  Arg_1.237 = f64[32768]{0} parameter(1)
  reshape.273 = f64[32768,1]{1,0} reshape(Arg_1.237)
  Arg_2.238 = f64[] parameter(2)
  broadcast.274 = f64[32768,1]{1,0} broadcast(Arg_2.238), dimensions={}
  multiply.275 = f64[32768,1]{1,0} multiply(reshape.273, broadcast.274)
  Arg_3.239 = f64[] parameter(3)
  broadcast.276 = f64[32768,1]{1,0} broadcast(Arg_3.239), dimensions={}
  divide.277 = f64[32768,1]{1,0} divide(multiply.275, broadcast.276)
  broadcast.282 = f64[32768,1]{1,0} broadcast(divide.277), dimensions={0,1}
  reshape.283 = f64[32768]{0} reshape(broadcast.282)
  broadcast.284 = f64[32768,32]{1,0} broadcast(reshape.283), dimensions={0}
  subtract.285 = f64[32768,32]{1,0} subtract(broadcast.281, broadcast.284)
  floor.286 = f64[32768,32]{1,0} floor(subtract.285)
  subtract.287 = f64[32768,32]{1,0} subtract(subtract.285, floor.286)
  constant.263 = f64[] constant(20)
  broadcast.264 = f64[32768,32]{1,0} broadcast(constant.263), dimensions={}
  divide.320 = f64[32768,32]{1,0} divide(subtract.287, broadcast.264)
  multiply.316 = f64[32768,32]{1,0} multiply(subtract.287, subtract.287)
  constant.261 = f64[] constant(24)
  broadcast.262 = f64[32768,32]{1,0} broadcast(constant.261), dimensions={}
  divide.321 = f64[32768,32]{1,0} divide(multiply.316, broadcast.262)
  subtract.322 = f64[32768,32]{1,0} subtract(divide.320, divide.321)
  multiply.317 = f64[32768,32]{1,0} multiply(multiply.316, subtract.287)
  divide.323 = f64[32768,32]{1,0} divide(multiply.317, broadcast.262)
  subtract.324 = f64[32768,32]{1,0} subtract(subtract.322, divide.323)
  multiply.318 = f64[32768,32]{1,0} multiply(multiply.317, subtract.287)
  divide.325 = f64[32768,32]{1,0} divide(multiply.318, broadcast.262)
  add.326 = f64[32768,32]{1,0} add(subtract.324, divide.325)
  multiply.319 = f64[32768,32]{1,0} multiply(multiply.318, subtract.287)
  constant.259 = f64[] constant(120)
  broadcast.260 = f64[32768,32]{1,0} broadcast(constant.259), dimensions={}
  divide.327 = f64[32768,32]{1,0} divide(multiply.319, broadcast.260)
  subtract.328 = f64[32768,32]{1,0} subtract(add.326, divide.327)
  Arg_0.236 = f64[32768,32]{1,0} parameter(0)
  reshape.307 = f64[1048576]{0} reshape(Arg_0.236)
  iota.299 = s64[32768]{0} iota(), iota_dimension=0
  reshape.300 = s64[32768,1,1]{2,1,0} reshape(iota.299)
  constant.269 = s64[] constant(32)
  broadcast.270 = s64[32768,1,1]{2,1,0} broadcast(constant.269), dimensions={}
  multiply.301 = s64[32768,1,1]{2,1,0} multiply(reshape.300, broadcast.270)
  broadcast.303 = s64[32768,1,1]{2,1,0} broadcast(multiply.301), dimensions={0,1,2}
  reshape.304 = s64[32768]{0} reshape(broadcast.303)
  broadcast.305 = s64[32768,32,6]{2,1,0} broadcast(reshape.304), dimensions={0}
  convert.288 = s32[32768,32]{1,0} convert(floor.286)
  reshape.289 = s32[32768,32,1]{2,1,0} reshape(convert.288)
  broadcast.291 = s32[32768,32,1]{2,1,0} broadcast(reshape.289), dimensions={0,1,2}
  reshape.292 = s32[32768,32]{1,0} reshape(broadcast.291)
  broadcast.293 = s32[32768,32,6]{2,1,0} broadcast(reshape.292), dimensions={0,1}
  Arg_4.240 = s32[6]{0} parameter(4)
  reshape.290 = s32[1,1,6]{2,1,0} reshape(Arg_4.240)
  broadcast.294 = s32[1,1,6]{2,1,0} broadcast(reshape.290), dimensions={0,1,2}
  reshape.295 = s32[6]{0} reshape(broadcast.294)
  broadcast.296 = s32[32768,32,6]{2,1,0} broadcast(reshape.295), dimensions={2}
  add.297 = s32[32768,32,6]{2,1,0} add(broadcast.293, broadcast.296)
  constant.271 = s64[] constant(32)
  call.298 = s32[32768,32,6]{2,1,0} call(add.297, constant.271), to_apply=remainder.214
  convert.302 = s64[32768,32,6]{2,1,0} convert(call.298)
  add.306 = s64[32768,32,6]{2,1,0} add(broadcast.305, convert.302)
  reshape.308 = s64[6291456]{0} reshape(add.306)
  constant.267 = s64[] constant(0)
  broadcast.268 = s64[6291456]{0} broadcast(constant.267), dimensions={}
  compare.309 = pred[6291456]{0} compare(reshape.308, broadcast.268), direction=LT
  constant.265 = s64[] constant(1048576)
  broadcast.266 = s64[6291456]{0} broadcast(constant.265), dimensions={}
  add.310 = s64[6291456]{0} add(reshape.308, broadcast.266)
  select.311 = s64[6291456]{0} select(compare.309, add.310, reshape.308)
  convert.312 = s32[6291456]{0} convert(select.311)
  reshape.313 = s32[6291456,1]{1,0} reshape(convert.312)
  gather.314 = f64[6291456]{0} gather(reshape.307, reshape.313), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.315 = f64[32768,32,6]{2,1,0} reshape(gather.314)
  slice.378 = f64[32768,32,1]{2,1,0} slice(reshape.315), slice={[0:32768], [0:32], [0:1]}
  reshape.379 = f64[32768,32]{1,0} reshape(slice.378)
  multiply.380 = f64[32768,32]{1,0} multiply(subtract.328, reshape.379)
  constant.257 = f64[] constant(2)
  broadcast.258 = f64[32768,32]{1,0} broadcast(constant.257), dimensions={}
  divide.329 = f64[32768,32]{1,0} divide(subtract.287, broadcast.258)
  negate.330 = f64[32768,32]{1,0} negate(divide.329)
  multiply.331 = f64[32768,32]{1,0} multiply(multiply.316, broadcast.258)
  constant.255 = f64[] constant(3)
  broadcast.256 = f64[32768,32]{1,0} broadcast(constant.255), dimensions={}
  divide.332 = f64[32768,32]{1,0} divide(multiply.331, broadcast.256)
  add.333 = f64[32768,32]{1,0} add(negate.330, divide.332)
  divide.334 = f64[32768,32]{1,0} divide(multiply.317, broadcast.262)
  subtract.335 = f64[32768,32]{1,0} subtract(add.333, divide.334)
  constant.253 = f64[] constant(6)
  broadcast.254 = f64[32768,32]{1,0} broadcast(constant.253), dimensions={}
  divide.336 = f64[32768,32]{1,0} divide(multiply.318, broadcast.254)
  subtract.337 = f64[32768,32]{1,0} subtract(subtract.335, divide.336)
  divide.338 = f64[32768,32]{1,0} divide(multiply.319, broadcast.262)
  add.339 = f64[32768,32]{1,0} add(subtract.337, divide.338)
  slice.381 = f64[32768,32,1]{2,1,0} slice(reshape.315), slice={[0:32768], [0:32], [1:2]}
  reshape.382 = f64[32768,32]{1,0} reshape(slice.381)
  multiply.383 = f64[32768,32]{1,0} multiply(add.339, reshape.382)
  add.384 = f64[32768,32]{1,0} add(multiply.380, multiply.383)
  constant.251 = f64[] constant(1)
  broadcast.252 = f64[32768,32]{1,0} broadcast(constant.251), dimensions={}
  divide.340 = f64[32768,32]{1,0} divide(subtract.287, broadcast.256)
  subtract.341 = f64[32768,32]{1,0} subtract(broadcast.252, divide.340)
  constant.249 = f64[] constant(5)
  broadcast.250 = f64[32768,32]{1,0} broadcast(constant.249), dimensions={}
  multiply.342 = f64[32768,32]{1,0} multiply(multiply.316, broadcast.250)
  constant.247 = f64[] constant(4)
  broadcast.248 = f64[32768,32]{1,0} broadcast(constant.247), dimensions={}
  divide.343 = f64[32768,32]{1,0} divide(multiply.342, broadcast.248)
  subtract.344 = f64[32768,32]{1,0} subtract(subtract.341, divide.343)
  multiply.345 = f64[32768,32]{1,0} multiply(multiply.317, broadcast.250)
  constant.245 = f64[] constant(12)
  broadcast.246 = f64[32768,32]{1,0} broadcast(constant.245), dimensions={}
  divide.346 = f64[32768,32]{1,0} divide(multiply.345, broadcast.246)
  add.347 = f64[32768,32]{1,0} add(subtract.344, divide.346)
  divide.348 = f64[32768,32]{1,0} divide(multiply.318, broadcast.248)
  add.349 = f64[32768,32]{1,0} add(add.347, divide.348)
  divide.350 = f64[32768,32]{1,0} divide(multiply.319, broadcast.246)
  subtract.351 = f64[32768,32]{1,0} subtract(add.349, divide.350)
  slice.385 = f64[32768,32,1]{2,1,0} slice(reshape.315), slice={[0:32768], [0:32], [2:3]}
  reshape.386 = f64[32768,32]{1,0} reshape(slice.385)
  multiply.387 = f64[32768,32]{1,0} multiply(subtract.351, reshape.386)
  add.388 = f64[32768,32]{1,0} add(add.384, multiply.387)
  multiply.352 = f64[32768,32]{1,0} multiply(multiply.316, broadcast.258)
  divide.353 = f64[32768,32]{1,0} divide(multiply.352, broadcast.256)
  add.354 = f64[32768,32]{1,0} add(subtract.287, divide.353)
  constant.243 = f64[] constant(7)
  broadcast.244 = f64[32768,32]{1,0} broadcast(constant.243), dimensions={}
  multiply.355 = f64[32768,32]{1,0} multiply(multiply.317, broadcast.244)
  divide.356 = f64[32768,32]{1,0} divide(multiply.355, broadcast.246)
  subtract.357 = f64[32768,32]{1,0} subtract(add.354, divide.356)
  divide.358 = f64[32768,32]{1,0} divide(multiply.318, broadcast.254)
  subtract.359 = f64[32768,32]{1,0} subtract(subtract.357, divide.358)
  divide.360 = f64[32768,32]{1,0} divide(multiply.319, broadcast.246)
  add.361 = f64[32768,32]{1,0} add(subtract.359, divide.360)
  slice.389 = f64[32768,32,1]{2,1,0} slice(reshape.315), slice={[0:32768], [0:32], [3:4]}
  reshape.390 = f64[32768,32]{1,0} reshape(slice.389)
  multiply.391 = f64[32768,32]{1,0} multiply(add.361, reshape.390)
  add.392 = f64[32768,32]{1,0} add(add.388, multiply.391)
  divide.362 = f64[32768,32]{1,0} divide(subtract.287, broadcast.248)
  negate.363 = f64[32768,32]{1,0} negate(divide.362)
  divide.364 = f64[32768,32]{1,0} divide(multiply.316, broadcast.262)
  subtract.365 = f64[32768,32]{1,0} subtract(negate.363, divide.364)
  multiply.366 = f64[32768,32]{1,0} multiply(multiply.317, broadcast.244)
  divide.367 = f64[32768,32]{1,0} divide(multiply.366, broadcast.262)
  add.368 = f64[32768,32]{1,0} add(subtract.365, divide.367)
  divide.369 = f64[32768,32]{1,0} divide(multiply.318, broadcast.262)
  add.370 = f64[32768,32]{1,0} add(add.368, divide.369)
  divide.371 = f64[32768,32]{1,0} divide(multiply.319, broadcast.262)
  subtract.372 = f64[32768,32]{1,0} subtract(add.370, divide.371)
  slice.393 = f64[32768,32,1]{2,1,0} slice(reshape.315), slice={[0:32768], [0:32], [4:5]}
  reshape.394 = f64[32768,32]{1,0} reshape(slice.393)
  multiply.395 = f64[32768,32]{1,0} multiply(subtract.372, reshape.394)
  add.396 = f64[32768,32]{1,0} add(add.392, multiply.395)
  constant.241 = f64[] constant(30)
  broadcast.242 = f64[32768,32]{1,0} broadcast(constant.241), dimensions={}
  divide.373 = f64[32768,32]{1,0} divide(subtract.287, broadcast.242)
  divide.374 = f64[32768,32]{1,0} divide(multiply.317, broadcast.262)
  subtract.375 = f64[32768,32]{1,0} subtract(divide.373, divide.374)
  divide.376 = f64[32768,32]{1,0} divide(multiply.319, broadcast.260)
  add.377 = f64[32768,32]{1,0} add(subtract.375, divide.376)
  slice.397 = f64[32768,32,1]{2,1,0} slice(reshape.315), slice={[0:32768], [0:32], [5:6]}
  reshape.398 = f64[32768,32]{1,0} reshape(slice.397)
  multiply.399 = f64[32768,32]{1,0} multiply(add.377, reshape.398)
  ROOT add.400 = f64[32768,32]{1,0} add(add.396, multiply.399)
}

region_1.401 {
  Arg_0.402 = f64[] parameter(0)
  Arg_1.403 = f64[] parameter(1)
  ROOT add.404 = f64[] add(Arg_0.402, Arg_1.403)
}

fft.405 {
  Arg_0.406 = f64[32,32]{1,0} parameter(0)
  ROOT fft.407 = c128[32,17]{1,0} fft(Arg_0.406), fft_type=RFFT, fft_length={32,32}
}

fft_0.408 {
  Arg_0.409 = c128[32,17]{1,0} parameter(0)
  ROOT fft.410 = f64[32,32]{1,0} fft(Arg_0.409), fft_type=IRFFT, fft_length={32,32}
}

fft_0.411 {
  Arg_0.412 = c128[32,17]{1,0} parameter(0)
  ROOT fft.413 = f64[32,32]{1,0} fft(Arg_0.412), fft_type=IRFFT, fft_length={32,32}
}

fft_0.414 {
  Arg_0.415 = c128[32,17]{1,0} parameter(0)
  ROOT fft.416 = f64[32,32]{1,0} fft(Arg_0.415), fft_type=IRFFT, fft_length={32,32}
}

solve_poisson.417 {
  Arg_1.419 = f64[32,1]{1,0} parameter(1)
  convert.441 = c128[32,1]{1,0} convert(Arg_1.419)
  constant.426 = c128[] constant((-0, -1))
  broadcast.427 = c128[32,1]{1,0} broadcast(constant.426), dimensions={}
  multiply.442 = c128[32,1]{1,0} multiply(convert.441, broadcast.427)
  broadcast.443 = c128[32,1]{1,0} broadcast(multiply.442), dimensions={0,1}
  reshape.444 = c128[32]{0} reshape(broadcast.443)
  broadcast.445 = c128[32,17]{1,0} broadcast(reshape.444), dimensions={0}
  Arg_0.418 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  constant.430 = f64[] constant(0)
  reduce.431 = f64[32,32]{1,0} reduce(Arg_0.418, constant.430), dimensions={2,3}, to_apply=region_1.401
  Arg_4.422 = f64[] parameter(4)
  broadcast.432 = f64[32,32]{1,0} broadcast(Arg_4.422), dimensions={}
  multiply.433 = f64[32,32]{1,0} multiply(reduce.431, broadcast.432)
  Arg_5.423 = f64[] parameter(5)
  broadcast.434 = f64[32,32]{1,0} broadcast(Arg_5.423), dimensions={}
  multiply.435 = f64[32,32]{1,0} multiply(multiply.433, broadcast.434)
  constant.428 = f64[] constant(1)
  broadcast.429 = f64[32,32]{1,0} broadcast(constant.428), dimensions={}
  subtract.436 = f64[32,32]{1,0} subtract(multiply.435, broadcast.429)
  call.437 = c128[32,17]{1,0} call(subtract.436), to_apply=fft.405
  Arg_3.421 = f64[32,17]{1,0} parameter(3)
  convert.438 = c128[32,17]{1,0} convert(Arg_3.421)
  multiply.439 = c128[32,17]{1,0} multiply(call.437, convert.438)
  multiply.446 = c128[32,17]{1,0} multiply(broadcast.445, multiply.439)
  call.453 = f64[32,32]{1,0} call(multiply.446), to_apply=fft_0.411
  Arg_2.420 = f64[1,17]{1,0} parameter(2)
  convert.447 = c128[1,17]{1,0} convert(Arg_2.420)
  constant.424 = c128[] constant((-0, -1))
  broadcast.425 = c128[1,17]{1,0} broadcast(constant.424), dimensions={}
  multiply.448 = c128[1,17]{1,0} multiply(convert.447, broadcast.425)
  broadcast.449 = c128[1,17]{1,0} broadcast(multiply.448), dimensions={0,1}
  reshape.450 = c128[17]{0} reshape(broadcast.449)
  broadcast.451 = c128[32,17]{1,0} broadcast(reshape.450), dimensions={1}
  multiply.452 = c128[32,17]{1,0} multiply(broadcast.451, multiply.439)
  call.454 = f64[32,32]{1,0} call(multiply.452), to_apply=fft_0.414
  call.440 = f64[32,32]{1,0} call(multiply.439), to_apply=fft_0.408
  ROOT tuple.455 = (f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(call.453, call.454, subtract.436, call.440)
}

clip.456 {
  Arg_2.459 = s64[] parameter(2)
  convert.463 = s32[] convert(Arg_2.459)
  broadcast.464 = s32[32768,32,6]{2,1,0} broadcast(convert.463), dimensions={}
  Arg_1.458 = s64[] parameter(1)
  convert.460 = s32[] convert(Arg_1.458)
  broadcast.461 = s32[32768,32,6]{2,1,0} broadcast(convert.460), dimensions={}
  Arg_0.457 = s32[32768,32,6]{2,1,0} parameter(0)
  maximum.462 = s32[32768,32,6]{2,1,0} maximum(broadcast.461, Arg_0.457)
  ROOT minimum.465 = s32[32768,32,6]{2,1,0} minimum(broadcast.464, maximum.462)
}

_where_2.466 {
  Arg_0.467 = pred[32768,32,6]{2,1,0} parameter(0)
  Arg_1.468 = f64[32768,32,6]{2,1,0} parameter(1)
  Arg_2.469 = f64[] parameter(2)
  broadcast.470 = f64[32768,32,6]{2,1,0} broadcast(Arg_2.469), dimensions={}
  ROOT select.471 = f64[32768,32,6]{2,1,0} select(Arg_0.467, Arg_1.468, broadcast.470)
}

advect_1d_vectorized_1.472 {
  iota.515 = f64[32]{0} iota(), iota_dimension=0
  reshape.521 = f64[1,32]{1,0} reshape(iota.515)
  broadcast.522 = f64[1,32]{1,0} broadcast(reshape.521), dimensions={0,1}
  reshape.523 = f64[32]{0} reshape(broadcast.522)
  broadcast.524 = f64[32768,32]{1,0} broadcast(reshape.523), dimensions={1}
  Arg_1.474 = f64[32768]{0} parameter(1)
  reshape.516 = f64[32768,1]{1,0} reshape(Arg_1.474)
  Arg_2.475 = f64[] parameter(2)
  broadcast.517 = f64[32768,1]{1,0} broadcast(Arg_2.475), dimensions={}
  multiply.518 = f64[32768,1]{1,0} multiply(reshape.516, broadcast.517)
  Arg_3.476 = f64[] parameter(3)
  broadcast.519 = f64[32768,1]{1,0} broadcast(Arg_3.476), dimensions={}
  divide.520 = f64[32768,1]{1,0} divide(multiply.518, broadcast.519)
  broadcast.525 = f64[32768,1]{1,0} broadcast(divide.520), dimensions={0,1}
  reshape.526 = f64[32768]{0} reshape(broadcast.525)
  broadcast.527 = f64[32768,32]{1,0} broadcast(reshape.526), dimensions={0}
  subtract.528 = f64[32768,32]{1,0} subtract(broadcast.524, broadcast.527)
  floor.529 = f64[32768,32]{1,0} floor(subtract.528)
  subtract.530 = f64[32768,32]{1,0} subtract(subtract.528, floor.529)
  constant.500 = f64[] constant(20)
  broadcast.501 = f64[32768,32]{1,0} broadcast(constant.500), dimensions={}
  divide.567 = f64[32768,32]{1,0} divide(subtract.530, broadcast.501)
  multiply.563 = f64[32768,32]{1,0} multiply(subtract.530, subtract.530)
  constant.498 = f64[] constant(24)
  broadcast.499 = f64[32768,32]{1,0} broadcast(constant.498), dimensions={}
  divide.568 = f64[32768,32]{1,0} divide(multiply.563, broadcast.499)
  subtract.569 = f64[32768,32]{1,0} subtract(divide.567, divide.568)
  multiply.564 = f64[32768,32]{1,0} multiply(multiply.563, subtract.530)
  divide.570 = f64[32768,32]{1,0} divide(multiply.564, broadcast.499)
  subtract.571 = f64[32768,32]{1,0} subtract(subtract.569, divide.570)
  multiply.565 = f64[32768,32]{1,0} multiply(multiply.564, subtract.530)
  divide.572 = f64[32768,32]{1,0} divide(multiply.565, broadcast.499)
  add.573 = f64[32768,32]{1,0} add(subtract.571, divide.572)
  multiply.566 = f64[32768,32]{1,0} multiply(multiply.565, subtract.530)
  constant.496 = f64[] constant(120)
  broadcast.497 = f64[32768,32]{1,0} broadcast(constant.496), dimensions={}
  divide.574 = f64[32768,32]{1,0} divide(multiply.566, broadcast.497)
  subtract.575 = f64[32768,32]{1,0} subtract(add.573, divide.574)
  convert.531 = s32[32768,32]{1,0} convert(floor.529)
  reshape.532 = s32[32768,32,1]{2,1,0} reshape(convert.531)
  broadcast.534 = s32[32768,32,1]{2,1,0} broadcast(reshape.532), dimensions={0,1,2}
  reshape.535 = s32[32768,32]{1,0} reshape(broadcast.534)
  broadcast.536 = s32[32768,32,6]{2,1,0} broadcast(reshape.535), dimensions={0,1}
  Arg_4.477 = s32[6]{0} parameter(4)
  reshape.533 = s32[1,1,6]{2,1,0} reshape(Arg_4.477)
  broadcast.537 = s32[1,1,6]{2,1,0} broadcast(reshape.533), dimensions={0,1,2}
  reshape.538 = s32[6]{0} reshape(broadcast.537)
  broadcast.539 = s32[32768,32,6]{2,1,0} broadcast(reshape.538), dimensions={2}
  add.540 = s32[32768,32,6]{2,1,0} add(broadcast.536, broadcast.539)
  constant.510 = s32[] constant(0)
  broadcast.511 = s32[32768,32,6]{2,1,0} broadcast(constant.510), dimensions={}
  compare.541 = pred[32768,32,6]{2,1,0} compare(add.540, broadcast.511), direction=GE
  constant.508 = s32[] constant(32)
  broadcast.509 = s32[32768,32,6]{2,1,0} broadcast(constant.508), dimensions={}
  compare.542 = pred[32768,32,6]{2,1,0} compare(add.540, broadcast.509), direction=LT
  and.543 = pred[32768,32,6]{2,1,0} and(compare.541, compare.542)
  Arg_0.473 = f64[32768,32]{1,0} parameter(0)
  reshape.553 = f64[1048576]{0} reshape(Arg_0.473)
  iota.545 = s64[32768]{0} iota(), iota_dimension=0
  reshape.546 = s64[32768,1,1]{2,1,0} reshape(iota.545)
  constant.506 = s64[] constant(32)
  broadcast.507 = s64[32768,1,1]{2,1,0} broadcast(constant.506), dimensions={}
  multiply.547 = s64[32768,1,1]{2,1,0} multiply(reshape.546, broadcast.507)
  broadcast.549 = s64[32768,1,1]{2,1,0} broadcast(multiply.547), dimensions={0,1,2}
  reshape.550 = s64[32768]{0} reshape(broadcast.549)
  broadcast.551 = s64[32768,32,6]{2,1,0} broadcast(reshape.550), dimensions={0}
  constant.514 = s64[] constant(0)
  constant.513 = s64[] constant(31)
  call.544 = s32[32768,32,6]{2,1,0} call(add.540, constant.514, constant.513), to_apply=clip.456
  convert.548 = s64[32768,32,6]{2,1,0} convert(call.544)
  add.552 = s64[32768,32,6]{2,1,0} add(broadcast.551, convert.548)
  reshape.554 = s64[6291456]{0} reshape(add.552)
  constant.504 = s64[] constant(0)
  broadcast.505 = s64[6291456]{0} broadcast(constant.504), dimensions={}
  compare.555 = pred[6291456]{0} compare(reshape.554, broadcast.505), direction=LT
  constant.502 = s64[] constant(1048576)
  broadcast.503 = s64[6291456]{0} broadcast(constant.502), dimensions={}
  add.556 = s64[6291456]{0} add(reshape.554, broadcast.503)
  select.557 = s64[6291456]{0} select(compare.555, add.556, reshape.554)
  convert.558 = s32[6291456]{0} convert(select.557)
  reshape.559 = s32[6291456,1]{1,0} reshape(convert.558)
  gather.560 = f64[6291456]{0} gather(reshape.553, reshape.559), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.561 = f64[32768,32,6]{2,1,0} reshape(gather.560)
  constant.512 = f64[] constant(0)
  call.562 = f64[32768,32,6]{2,1,0} call(and.543, reshape.561, constant.512), to_apply=_where_2.466
  slice.625 = f64[32768,32,1]{2,1,0} slice(call.562), slice={[0:32768], [0:32], [0:1]}
  reshape.626 = f64[32768,32]{1,0} reshape(slice.625)
  multiply.627 = f64[32768,32]{1,0} multiply(subtract.575, reshape.626)
  constant.494 = f64[] constant(2)
  broadcast.495 = f64[32768,32]{1,0} broadcast(constant.494), dimensions={}
  divide.576 = f64[32768,32]{1,0} divide(subtract.530, broadcast.495)
  negate.577 = f64[32768,32]{1,0} negate(divide.576)
  multiply.578 = f64[32768,32]{1,0} multiply(multiply.563, broadcast.495)
  constant.492 = f64[] constant(3)
  broadcast.493 = f64[32768,32]{1,0} broadcast(constant.492), dimensions={}
  divide.579 = f64[32768,32]{1,0} divide(multiply.578, broadcast.493)
  add.580 = f64[32768,32]{1,0} add(negate.577, divide.579)
  divide.581 = f64[32768,32]{1,0} divide(multiply.564, broadcast.499)
  subtract.582 = f64[32768,32]{1,0} subtract(add.580, divide.581)
  constant.490 = f64[] constant(6)
  broadcast.491 = f64[32768,32]{1,0} broadcast(constant.490), dimensions={}
  divide.583 = f64[32768,32]{1,0} divide(multiply.565, broadcast.491)
  subtract.584 = f64[32768,32]{1,0} subtract(subtract.582, divide.583)
  divide.585 = f64[32768,32]{1,0} divide(multiply.566, broadcast.499)
  add.586 = f64[32768,32]{1,0} add(subtract.584, divide.585)
  slice.628 = f64[32768,32,1]{2,1,0} slice(call.562), slice={[0:32768], [0:32], [1:2]}
  reshape.629 = f64[32768,32]{1,0} reshape(slice.628)
  multiply.630 = f64[32768,32]{1,0} multiply(add.586, reshape.629)
  add.631 = f64[32768,32]{1,0} add(multiply.627, multiply.630)
  constant.488 = f64[] constant(1)
  broadcast.489 = f64[32768,32]{1,0} broadcast(constant.488), dimensions={}
  divide.587 = f64[32768,32]{1,0} divide(subtract.530, broadcast.493)
  subtract.588 = f64[32768,32]{1,0} subtract(broadcast.489, divide.587)
  constant.486 = f64[] constant(5)
  broadcast.487 = f64[32768,32]{1,0} broadcast(constant.486), dimensions={}
  multiply.589 = f64[32768,32]{1,0} multiply(multiply.563, broadcast.487)
  constant.484 = f64[] constant(4)
  broadcast.485 = f64[32768,32]{1,0} broadcast(constant.484), dimensions={}
  divide.590 = f64[32768,32]{1,0} divide(multiply.589, broadcast.485)
  subtract.591 = f64[32768,32]{1,0} subtract(subtract.588, divide.590)
  multiply.592 = f64[32768,32]{1,0} multiply(multiply.564, broadcast.487)
  constant.482 = f64[] constant(12)
  broadcast.483 = f64[32768,32]{1,0} broadcast(constant.482), dimensions={}
  divide.593 = f64[32768,32]{1,0} divide(multiply.592, broadcast.483)
  add.594 = f64[32768,32]{1,0} add(subtract.591, divide.593)
  divide.595 = f64[32768,32]{1,0} divide(multiply.565, broadcast.485)
  add.596 = f64[32768,32]{1,0} add(add.594, divide.595)
  divide.597 = f64[32768,32]{1,0} divide(multiply.566, broadcast.483)
  subtract.598 = f64[32768,32]{1,0} subtract(add.596, divide.597)
  slice.632 = f64[32768,32,1]{2,1,0} slice(call.562), slice={[0:32768], [0:32], [2:3]}
  reshape.633 = f64[32768,32]{1,0} reshape(slice.632)
  multiply.634 = f64[32768,32]{1,0} multiply(subtract.598, reshape.633)
  add.635 = f64[32768,32]{1,0} add(add.631, multiply.634)
  multiply.599 = f64[32768,32]{1,0} multiply(multiply.563, broadcast.495)
  divide.600 = f64[32768,32]{1,0} divide(multiply.599, broadcast.493)
  add.601 = f64[32768,32]{1,0} add(subtract.530, divide.600)
  constant.480 = f64[] constant(7)
  broadcast.481 = f64[32768,32]{1,0} broadcast(constant.480), dimensions={}
  multiply.602 = f64[32768,32]{1,0} multiply(multiply.564, broadcast.481)
  divide.603 = f64[32768,32]{1,0} divide(multiply.602, broadcast.483)
  subtract.604 = f64[32768,32]{1,0} subtract(add.601, divide.603)
  divide.605 = f64[32768,32]{1,0} divide(multiply.565, broadcast.491)
  subtract.606 = f64[32768,32]{1,0} subtract(subtract.604, divide.605)
  divide.607 = f64[32768,32]{1,0} divide(multiply.566, broadcast.483)
  add.608 = f64[32768,32]{1,0} add(subtract.606, divide.607)
  slice.636 = f64[32768,32,1]{2,1,0} slice(call.562), slice={[0:32768], [0:32], [3:4]}
  reshape.637 = f64[32768,32]{1,0} reshape(slice.636)
  multiply.638 = f64[32768,32]{1,0} multiply(add.608, reshape.637)
  add.639 = f64[32768,32]{1,0} add(add.635, multiply.638)
  divide.609 = f64[32768,32]{1,0} divide(subtract.530, broadcast.485)
  negate.610 = f64[32768,32]{1,0} negate(divide.609)
  divide.611 = f64[32768,32]{1,0} divide(multiply.563, broadcast.499)
  subtract.612 = f64[32768,32]{1,0} subtract(negate.610, divide.611)
  multiply.613 = f64[32768,32]{1,0} multiply(multiply.564, broadcast.481)
  divide.614 = f64[32768,32]{1,0} divide(multiply.613, broadcast.499)
  add.615 = f64[32768,32]{1,0} add(subtract.612, divide.614)
  divide.616 = f64[32768,32]{1,0} divide(multiply.565, broadcast.499)
  add.617 = f64[32768,32]{1,0} add(add.615, divide.616)
  divide.618 = f64[32768,32]{1,0} divide(multiply.566, broadcast.499)
  subtract.619 = f64[32768,32]{1,0} subtract(add.617, divide.618)
  slice.640 = f64[32768,32,1]{2,1,0} slice(call.562), slice={[0:32768], [0:32], [4:5]}
  reshape.641 = f64[32768,32]{1,0} reshape(slice.640)
  multiply.642 = f64[32768,32]{1,0} multiply(subtract.619, reshape.641)
  add.643 = f64[32768,32]{1,0} add(add.639, multiply.642)
  constant.478 = f64[] constant(30)
  broadcast.479 = f64[32768,32]{1,0} broadcast(constant.478), dimensions={}
  divide.620 = f64[32768,32]{1,0} divide(subtract.530, broadcast.479)
  divide.621 = f64[32768,32]{1,0} divide(multiply.564, broadcast.499)
  subtract.622 = f64[32768,32]{1,0} subtract(divide.620, divide.621)
  divide.623 = f64[32768,32]{1,0} divide(multiply.566, broadcast.497)
  add.624 = f64[32768,32]{1,0} add(subtract.622, divide.623)
  slice.644 = f64[32768,32,1]{2,1,0} slice(call.562), slice={[0:32768], [0:32], [5:6]}
  reshape.645 = f64[32768,32]{1,0} reshape(slice.644)
  multiply.646 = f64[32768,32]{1,0} multiply(add.624, reshape.645)
  ROOT add.647 = f64[32768,32]{1,0} add(add.643, multiply.646)
}

clip.648 {
  Arg_2.651 = s64[] parameter(2)
  convert.655 = s32[] convert(Arg_2.651)
  broadcast.656 = s32[32768,32,6]{2,1,0} broadcast(convert.655), dimensions={}
  Arg_1.650 = s64[] parameter(1)
  convert.652 = s32[] convert(Arg_1.650)
  broadcast.653 = s32[32768,32,6]{2,1,0} broadcast(convert.652), dimensions={}
  Arg_0.649 = s32[32768,32,6]{2,1,0} parameter(0)
  maximum.654 = s32[32768,32,6]{2,1,0} maximum(broadcast.653, Arg_0.649)
  ROOT minimum.657 = s32[32768,32,6]{2,1,0} minimum(broadcast.656, maximum.654)
}

_where_2.658 {
  Arg_0.659 = pred[32768,32,6]{2,1,0} parameter(0)
  Arg_1.660 = f64[32768,32,6]{2,1,0} parameter(1)
  Arg_2.661 = f64[] parameter(2)
  broadcast.662 = f64[32768,32,6]{2,1,0} broadcast(Arg_2.661), dimensions={}
  ROOT select.663 = f64[32768,32,6]{2,1,0} select(Arg_0.659, Arg_1.660, broadcast.662)
}

advect_1d_vectorized_1.664 {
  iota.707 = f64[32]{0} iota(), iota_dimension=0
  reshape.713 = f64[1,32]{1,0} reshape(iota.707)
  broadcast.714 = f64[1,32]{1,0} broadcast(reshape.713), dimensions={0,1}
  reshape.715 = f64[32]{0} reshape(broadcast.714)
  broadcast.716 = f64[32768,32]{1,0} broadcast(reshape.715), dimensions={1}
  Arg_1.666 = f64[32768]{0} parameter(1)
  reshape.708 = f64[32768,1]{1,0} reshape(Arg_1.666)
  Arg_2.667 = f64[] parameter(2)
  broadcast.709 = f64[32768,1]{1,0} broadcast(Arg_2.667), dimensions={}
  multiply.710 = f64[32768,1]{1,0} multiply(reshape.708, broadcast.709)
  Arg_3.668 = f64[] parameter(3)
  broadcast.711 = f64[32768,1]{1,0} broadcast(Arg_3.668), dimensions={}
  divide.712 = f64[32768,1]{1,0} divide(multiply.710, broadcast.711)
  broadcast.717 = f64[32768,1]{1,0} broadcast(divide.712), dimensions={0,1}
  reshape.718 = f64[32768]{0} reshape(broadcast.717)
  broadcast.719 = f64[32768,32]{1,0} broadcast(reshape.718), dimensions={0}
  subtract.720 = f64[32768,32]{1,0} subtract(broadcast.716, broadcast.719)
  floor.721 = f64[32768,32]{1,0} floor(subtract.720)
  subtract.722 = f64[32768,32]{1,0} subtract(subtract.720, floor.721)
  constant.692 = f64[] constant(20)
  broadcast.693 = f64[32768,32]{1,0} broadcast(constant.692), dimensions={}
  divide.759 = f64[32768,32]{1,0} divide(subtract.722, broadcast.693)
  multiply.755 = f64[32768,32]{1,0} multiply(subtract.722, subtract.722)
  constant.690 = f64[] constant(24)
  broadcast.691 = f64[32768,32]{1,0} broadcast(constant.690), dimensions={}
  divide.760 = f64[32768,32]{1,0} divide(multiply.755, broadcast.691)
  subtract.761 = f64[32768,32]{1,0} subtract(divide.759, divide.760)
  multiply.756 = f64[32768,32]{1,0} multiply(multiply.755, subtract.722)
  divide.762 = f64[32768,32]{1,0} divide(multiply.756, broadcast.691)
  subtract.763 = f64[32768,32]{1,0} subtract(subtract.761, divide.762)
  multiply.757 = f64[32768,32]{1,0} multiply(multiply.756, subtract.722)
  divide.764 = f64[32768,32]{1,0} divide(multiply.757, broadcast.691)
  add.765 = f64[32768,32]{1,0} add(subtract.763, divide.764)
  multiply.758 = f64[32768,32]{1,0} multiply(multiply.757, subtract.722)
  constant.688 = f64[] constant(120)
  broadcast.689 = f64[32768,32]{1,0} broadcast(constant.688), dimensions={}
  divide.766 = f64[32768,32]{1,0} divide(multiply.758, broadcast.689)
  subtract.767 = f64[32768,32]{1,0} subtract(add.765, divide.766)
  convert.723 = s32[32768,32]{1,0} convert(floor.721)
  reshape.724 = s32[32768,32,1]{2,1,0} reshape(convert.723)
  broadcast.726 = s32[32768,32,1]{2,1,0} broadcast(reshape.724), dimensions={0,1,2}
  reshape.727 = s32[32768,32]{1,0} reshape(broadcast.726)
  broadcast.728 = s32[32768,32,6]{2,1,0} broadcast(reshape.727), dimensions={0,1}
  Arg_4.669 = s32[6]{0} parameter(4)
  reshape.725 = s32[1,1,6]{2,1,0} reshape(Arg_4.669)
  broadcast.729 = s32[1,1,6]{2,1,0} broadcast(reshape.725), dimensions={0,1,2}
  reshape.730 = s32[6]{0} reshape(broadcast.729)
  broadcast.731 = s32[32768,32,6]{2,1,0} broadcast(reshape.730), dimensions={2}
  add.732 = s32[32768,32,6]{2,1,0} add(broadcast.728, broadcast.731)
  constant.702 = s32[] constant(0)
  broadcast.703 = s32[32768,32,6]{2,1,0} broadcast(constant.702), dimensions={}
  compare.733 = pred[32768,32,6]{2,1,0} compare(add.732, broadcast.703), direction=GE
  constant.700 = s32[] constant(32)
  broadcast.701 = s32[32768,32,6]{2,1,0} broadcast(constant.700), dimensions={}
  compare.734 = pred[32768,32,6]{2,1,0} compare(add.732, broadcast.701), direction=LT
  and.735 = pred[32768,32,6]{2,1,0} and(compare.733, compare.734)
  Arg_0.665 = f64[32768,32]{1,0} parameter(0)
  reshape.745 = f64[1048576]{0} reshape(Arg_0.665)
  iota.737 = s64[32768]{0} iota(), iota_dimension=0
  reshape.738 = s64[32768,1,1]{2,1,0} reshape(iota.737)
  constant.698 = s64[] constant(32)
  broadcast.699 = s64[32768,1,1]{2,1,0} broadcast(constant.698), dimensions={}
  multiply.739 = s64[32768,1,1]{2,1,0} multiply(reshape.738, broadcast.699)
  broadcast.741 = s64[32768,1,1]{2,1,0} broadcast(multiply.739), dimensions={0,1,2}
  reshape.742 = s64[32768]{0} reshape(broadcast.741)
  broadcast.743 = s64[32768,32,6]{2,1,0} broadcast(reshape.742), dimensions={0}
  constant.706 = s64[] constant(0)
  constant.705 = s64[] constant(31)
  call.736 = s32[32768,32,6]{2,1,0} call(add.732, constant.706, constant.705), to_apply=clip.648
  convert.740 = s64[32768,32,6]{2,1,0} convert(call.736)
  add.744 = s64[32768,32,6]{2,1,0} add(broadcast.743, convert.740)
  reshape.746 = s64[6291456]{0} reshape(add.744)
  constant.696 = s64[] constant(0)
  broadcast.697 = s64[6291456]{0} broadcast(constant.696), dimensions={}
  compare.747 = pred[6291456]{0} compare(reshape.746, broadcast.697), direction=LT
  constant.694 = s64[] constant(1048576)
  broadcast.695 = s64[6291456]{0} broadcast(constant.694), dimensions={}
  add.748 = s64[6291456]{0} add(reshape.746, broadcast.695)
  select.749 = s64[6291456]{0} select(compare.747, add.748, reshape.746)
  convert.750 = s32[6291456]{0} convert(select.749)
  reshape.751 = s32[6291456,1]{1,0} reshape(convert.750)
  gather.752 = f64[6291456]{0} gather(reshape.745, reshape.751), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.753 = f64[32768,32,6]{2,1,0} reshape(gather.752)
  constant.704 = f64[] constant(0)
  call.754 = f64[32768,32,6]{2,1,0} call(and.735, reshape.753, constant.704), to_apply=_where_2.658
  slice.817 = f64[32768,32,1]{2,1,0} slice(call.754), slice={[0:32768], [0:32], [0:1]}
  reshape.818 = f64[32768,32]{1,0} reshape(slice.817)
  multiply.819 = f64[32768,32]{1,0} multiply(subtract.767, reshape.818)
  constant.686 = f64[] constant(2)
  broadcast.687 = f64[32768,32]{1,0} broadcast(constant.686), dimensions={}
  divide.768 = f64[32768,32]{1,0} divide(subtract.722, broadcast.687)
  negate.769 = f64[32768,32]{1,0} negate(divide.768)
  multiply.770 = f64[32768,32]{1,0} multiply(multiply.755, broadcast.687)
  constant.684 = f64[] constant(3)
  broadcast.685 = f64[32768,32]{1,0} broadcast(constant.684), dimensions={}
  divide.771 = f64[32768,32]{1,0} divide(multiply.770, broadcast.685)
  add.772 = f64[32768,32]{1,0} add(negate.769, divide.771)
  divide.773 = f64[32768,32]{1,0} divide(multiply.756, broadcast.691)
  subtract.774 = f64[32768,32]{1,0} subtract(add.772, divide.773)
  constant.682 = f64[] constant(6)
  broadcast.683 = f64[32768,32]{1,0} broadcast(constant.682), dimensions={}
  divide.775 = f64[32768,32]{1,0} divide(multiply.757, broadcast.683)
  subtract.776 = f64[32768,32]{1,0} subtract(subtract.774, divide.775)
  divide.777 = f64[32768,32]{1,0} divide(multiply.758, broadcast.691)
  add.778 = f64[32768,32]{1,0} add(subtract.776, divide.777)
  slice.820 = f64[32768,32,1]{2,1,0} slice(call.754), slice={[0:32768], [0:32], [1:2]}
  reshape.821 = f64[32768,32]{1,0} reshape(slice.820)
  multiply.822 = f64[32768,32]{1,0} multiply(add.778, reshape.821)
  add.823 = f64[32768,32]{1,0} add(multiply.819, multiply.822)
  constant.680 = f64[] constant(1)
  broadcast.681 = f64[32768,32]{1,0} broadcast(constant.680), dimensions={}
  divide.779 = f64[32768,32]{1,0} divide(subtract.722, broadcast.685)
  subtract.780 = f64[32768,32]{1,0} subtract(broadcast.681, divide.779)
  constant.678 = f64[] constant(5)
  broadcast.679 = f64[32768,32]{1,0} broadcast(constant.678), dimensions={}
  multiply.781 = f64[32768,32]{1,0} multiply(multiply.755, broadcast.679)
  constant.676 = f64[] constant(4)
  broadcast.677 = f64[32768,32]{1,0} broadcast(constant.676), dimensions={}
  divide.782 = f64[32768,32]{1,0} divide(multiply.781, broadcast.677)
  subtract.783 = f64[32768,32]{1,0} subtract(subtract.780, divide.782)
  multiply.784 = f64[32768,32]{1,0} multiply(multiply.756, broadcast.679)
  constant.674 = f64[] constant(12)
  broadcast.675 = f64[32768,32]{1,0} broadcast(constant.674), dimensions={}
  divide.785 = f64[32768,32]{1,0} divide(multiply.784, broadcast.675)
  add.786 = f64[32768,32]{1,0} add(subtract.783, divide.785)
  divide.787 = f64[32768,32]{1,0} divide(multiply.757, broadcast.677)
  add.788 = f64[32768,32]{1,0} add(add.786, divide.787)
  divide.789 = f64[32768,32]{1,0} divide(multiply.758, broadcast.675)
  subtract.790 = f64[32768,32]{1,0} subtract(add.788, divide.789)
  slice.824 = f64[32768,32,1]{2,1,0} slice(call.754), slice={[0:32768], [0:32], [2:3]}
  reshape.825 = f64[32768,32]{1,0} reshape(slice.824)
  multiply.826 = f64[32768,32]{1,0} multiply(subtract.790, reshape.825)
  add.827 = f64[32768,32]{1,0} add(add.823, multiply.826)
  multiply.791 = f64[32768,32]{1,0} multiply(multiply.755, broadcast.687)
  divide.792 = f64[32768,32]{1,0} divide(multiply.791, broadcast.685)
  add.793 = f64[32768,32]{1,0} add(subtract.722, divide.792)
  constant.672 = f64[] constant(7)
  broadcast.673 = f64[32768,32]{1,0} broadcast(constant.672), dimensions={}
  multiply.794 = f64[32768,32]{1,0} multiply(multiply.756, broadcast.673)
  divide.795 = f64[32768,32]{1,0} divide(multiply.794, broadcast.675)
  subtract.796 = f64[32768,32]{1,0} subtract(add.793, divide.795)
  divide.797 = f64[32768,32]{1,0} divide(multiply.757, broadcast.683)
  subtract.798 = f64[32768,32]{1,0} subtract(subtract.796, divide.797)
  divide.799 = f64[32768,32]{1,0} divide(multiply.758, broadcast.675)
  add.800 = f64[32768,32]{1,0} add(subtract.798, divide.799)
  slice.828 = f64[32768,32,1]{2,1,0} slice(call.754), slice={[0:32768], [0:32], [3:4]}
  reshape.829 = f64[32768,32]{1,0} reshape(slice.828)
  multiply.830 = f64[32768,32]{1,0} multiply(add.800, reshape.829)
  add.831 = f64[32768,32]{1,0} add(add.827, multiply.830)
  divide.801 = f64[32768,32]{1,0} divide(subtract.722, broadcast.677)
  negate.802 = f64[32768,32]{1,0} negate(divide.801)
  divide.803 = f64[32768,32]{1,0} divide(multiply.755, broadcast.691)
  subtract.804 = f64[32768,32]{1,0} subtract(negate.802, divide.803)
  multiply.805 = f64[32768,32]{1,0} multiply(multiply.756, broadcast.673)
  divide.806 = f64[32768,32]{1,0} divide(multiply.805, broadcast.691)
  add.807 = f64[32768,32]{1,0} add(subtract.804, divide.806)
  divide.808 = f64[32768,32]{1,0} divide(multiply.757, broadcast.691)
  add.809 = f64[32768,32]{1,0} add(add.807, divide.808)
  divide.810 = f64[32768,32]{1,0} divide(multiply.758, broadcast.691)
  subtract.811 = f64[32768,32]{1,0} subtract(add.809, divide.810)
  slice.832 = f64[32768,32,1]{2,1,0} slice(call.754), slice={[0:32768], [0:32], [4:5]}
  reshape.833 = f64[32768,32]{1,0} reshape(slice.832)
  multiply.834 = f64[32768,32]{1,0} multiply(subtract.811, reshape.833)
  add.835 = f64[32768,32]{1,0} add(add.831, multiply.834)
  constant.670 = f64[] constant(30)
  broadcast.671 = f64[32768,32]{1,0} broadcast(constant.670), dimensions={}
  divide.812 = f64[32768,32]{1,0} divide(subtract.722, broadcast.671)
  divide.813 = f64[32768,32]{1,0} divide(multiply.756, broadcast.691)
  subtract.814 = f64[32768,32]{1,0} subtract(divide.812, divide.813)
  divide.815 = f64[32768,32]{1,0} divide(multiply.758, broadcast.689)
  add.816 = f64[32768,32]{1,0} add(subtract.814, divide.815)
  slice.836 = f64[32768,32,1]{2,1,0} slice(call.754), slice={[0:32768], [0:32], [5:6]}
  reshape.837 = f64[32768,32]{1,0} reshape(slice.836)
  multiply.838 = f64[32768,32]{1,0} multiply(add.816, reshape.837)
  ROOT add.839 = f64[32768,32]{1,0} add(add.835, multiply.838)
}

_where.840 {
  Arg_0.841 = pred[] parameter(0)
  Arg_1.842 = s32[] parameter(1)
  Arg_2.843 = s32[] parameter(2)
  ROOT select.844 = s32[] select(Arg_0.841, Arg_1.842, Arg_2.843)
}

remainder.845 {
  Arg_0.846 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.847 = s64[] parameter(1)
  convert.852 = s32[] convert(Arg_1.847)
  constant.851 = s32[] constant(0)
  compare.853 = pred[] compare(convert.852, constant.851), direction=EQ
  constant.850 = s32[] constant(1)
  call.854 = s32[] call(compare.853, constant.850, convert.852), to_apply=_where.840
  broadcast.855 = s32[32768,32,6]{2,1,0} broadcast(call.854), dimensions={}
  remainder.856 = s32[32768,32,6]{2,1,0} remainder(Arg_0.846, broadcast.855)
  constant.848 = s32[] constant(0)
  broadcast.849 = s32[32768,32,6]{2,1,0} broadcast(constant.848), dimensions={}
  compare.858 = pred[32768,32,6]{2,1,0} compare(remainder.856, broadcast.849), direction=LT
  compare.859 = pred[] compare(call.854, constant.851), direction=LT
  broadcast.860 = pred[32768,32,6]{2,1,0} broadcast(compare.859), dimensions={}
  compare.861 = pred[32768,32,6]{2,1,0} compare(compare.858, broadcast.860), direction=NE
  compare.857 = pred[32768,32,6]{2,1,0} compare(remainder.856, broadcast.849), direction=NE
  and.862 = pred[32768,32,6]{2,1,0} and(compare.861, compare.857)
  broadcast.863 = s32[32768,32,6]{2,1,0} broadcast(call.854), dimensions={}
  add.864 = s32[32768,32,6]{2,1,0} add(remainder.856, broadcast.863)
  ROOT select.865 = s32[32768,32,6]{2,1,0} select(and.862, add.864, remainder.856)
}

advect_1d_vectorized.866 {
  iota.903 = f64[32]{0} iota(), iota_dimension=0
  reshape.909 = f64[1,32]{1,0} reshape(iota.903)
  broadcast.910 = f64[1,32]{1,0} broadcast(reshape.909), dimensions={0,1}
  reshape.911 = f64[32]{0} reshape(broadcast.910)
  broadcast.912 = f64[32768,32]{1,0} broadcast(reshape.911), dimensions={1}
  Arg_1.868 = f64[32768]{0} parameter(1)
  reshape.904 = f64[32768,1]{1,0} reshape(Arg_1.868)
  Arg_2.869 = f64[] parameter(2)
  broadcast.905 = f64[32768,1]{1,0} broadcast(Arg_2.869), dimensions={}
  multiply.906 = f64[32768,1]{1,0} multiply(reshape.904, broadcast.905)
  Arg_3.870 = f64[] parameter(3)
  broadcast.907 = f64[32768,1]{1,0} broadcast(Arg_3.870), dimensions={}
  divide.908 = f64[32768,1]{1,0} divide(multiply.906, broadcast.907)
  broadcast.913 = f64[32768,1]{1,0} broadcast(divide.908), dimensions={0,1}
  reshape.914 = f64[32768]{0} reshape(broadcast.913)
  broadcast.915 = f64[32768,32]{1,0} broadcast(reshape.914), dimensions={0}
  subtract.916 = f64[32768,32]{1,0} subtract(broadcast.912, broadcast.915)
  floor.917 = f64[32768,32]{1,0} floor(subtract.916)
  subtract.918 = f64[32768,32]{1,0} subtract(subtract.916, floor.917)
  constant.894 = f64[] constant(20)
  broadcast.895 = f64[32768,32]{1,0} broadcast(constant.894), dimensions={}
  divide.951 = f64[32768,32]{1,0} divide(subtract.918, broadcast.895)
  multiply.947 = f64[32768,32]{1,0} multiply(subtract.918, subtract.918)
  constant.892 = f64[] constant(24)
  broadcast.893 = f64[32768,32]{1,0} broadcast(constant.892), dimensions={}
  divide.952 = f64[32768,32]{1,0} divide(multiply.947, broadcast.893)
  subtract.953 = f64[32768,32]{1,0} subtract(divide.951, divide.952)
  multiply.948 = f64[32768,32]{1,0} multiply(multiply.947, subtract.918)
  divide.954 = f64[32768,32]{1,0} divide(multiply.948, broadcast.893)
  subtract.955 = f64[32768,32]{1,0} subtract(subtract.953, divide.954)
  multiply.949 = f64[32768,32]{1,0} multiply(multiply.948, subtract.918)
  divide.956 = f64[32768,32]{1,0} divide(multiply.949, broadcast.893)
  add.957 = f64[32768,32]{1,0} add(subtract.955, divide.956)
  multiply.950 = f64[32768,32]{1,0} multiply(multiply.949, subtract.918)
  constant.890 = f64[] constant(120)
  broadcast.891 = f64[32768,32]{1,0} broadcast(constant.890), dimensions={}
  divide.958 = f64[32768,32]{1,0} divide(multiply.950, broadcast.891)
  subtract.959 = f64[32768,32]{1,0} subtract(add.957, divide.958)
  Arg_0.867 = f64[32768,32]{1,0} parameter(0)
  reshape.938 = f64[1048576]{0} reshape(Arg_0.867)
  iota.930 = s64[32768]{0} iota(), iota_dimension=0
  reshape.931 = s64[32768,1,1]{2,1,0} reshape(iota.930)
  constant.900 = s64[] constant(32)
  broadcast.901 = s64[32768,1,1]{2,1,0} broadcast(constant.900), dimensions={}
  multiply.932 = s64[32768,1,1]{2,1,0} multiply(reshape.931, broadcast.901)
  broadcast.934 = s64[32768,1,1]{2,1,0} broadcast(multiply.932), dimensions={0,1,2}
  reshape.935 = s64[32768]{0} reshape(broadcast.934)
  broadcast.936 = s64[32768,32,6]{2,1,0} broadcast(reshape.935), dimensions={0}
  convert.919 = s32[32768,32]{1,0} convert(floor.917)
  reshape.920 = s32[32768,32,1]{2,1,0} reshape(convert.919)
  broadcast.922 = s32[32768,32,1]{2,1,0} broadcast(reshape.920), dimensions={0,1,2}
  reshape.923 = s32[32768,32]{1,0} reshape(broadcast.922)
  broadcast.924 = s32[32768,32,6]{2,1,0} broadcast(reshape.923), dimensions={0,1}
  Arg_4.871 = s32[6]{0} parameter(4)
  reshape.921 = s32[1,1,6]{2,1,0} reshape(Arg_4.871)
  broadcast.925 = s32[1,1,6]{2,1,0} broadcast(reshape.921), dimensions={0,1,2}
  reshape.926 = s32[6]{0} reshape(broadcast.925)
  broadcast.927 = s32[32768,32,6]{2,1,0} broadcast(reshape.926), dimensions={2}
  add.928 = s32[32768,32,6]{2,1,0} add(broadcast.924, broadcast.927)
  constant.902 = s64[] constant(32)
  call.929 = s32[32768,32,6]{2,1,0} call(add.928, constant.902), to_apply=remainder.845
  convert.933 = s64[32768,32,6]{2,1,0} convert(call.929)
  add.937 = s64[32768,32,6]{2,1,0} add(broadcast.936, convert.933)
  reshape.939 = s64[6291456]{0} reshape(add.937)
  constant.898 = s64[] constant(0)
  broadcast.899 = s64[6291456]{0} broadcast(constant.898), dimensions={}
  compare.940 = pred[6291456]{0} compare(reshape.939, broadcast.899), direction=LT
  constant.896 = s64[] constant(1048576)
  broadcast.897 = s64[6291456]{0} broadcast(constant.896), dimensions={}
  add.941 = s64[6291456]{0} add(reshape.939, broadcast.897)
  select.942 = s64[6291456]{0} select(compare.940, add.941, reshape.939)
  convert.943 = s32[6291456]{0} convert(select.942)
  reshape.944 = s32[6291456,1]{1,0} reshape(convert.943)
  gather.945 = f64[6291456]{0} gather(reshape.938, reshape.944), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.946 = f64[32768,32,6]{2,1,0} reshape(gather.945)
  slice.1009 = f64[32768,32,1]{2,1,0} slice(reshape.946), slice={[0:32768], [0:32], [0:1]}
  reshape.1010 = f64[32768,32]{1,0} reshape(slice.1009)
  multiply.1011 = f64[32768,32]{1,0} multiply(subtract.959, reshape.1010)
  constant.888 = f64[] constant(2)
  broadcast.889 = f64[32768,32]{1,0} broadcast(constant.888), dimensions={}
  divide.960 = f64[32768,32]{1,0} divide(subtract.918, broadcast.889)
  negate.961 = f64[32768,32]{1,0} negate(divide.960)
  multiply.962 = f64[32768,32]{1,0} multiply(multiply.947, broadcast.889)
  constant.886 = f64[] constant(3)
  broadcast.887 = f64[32768,32]{1,0} broadcast(constant.886), dimensions={}
  divide.963 = f64[32768,32]{1,0} divide(multiply.962, broadcast.887)
  add.964 = f64[32768,32]{1,0} add(negate.961, divide.963)
  divide.965 = f64[32768,32]{1,0} divide(multiply.948, broadcast.893)
  subtract.966 = f64[32768,32]{1,0} subtract(add.964, divide.965)
  constant.884 = f64[] constant(6)
  broadcast.885 = f64[32768,32]{1,0} broadcast(constant.884), dimensions={}
  divide.967 = f64[32768,32]{1,0} divide(multiply.949, broadcast.885)
  subtract.968 = f64[32768,32]{1,0} subtract(subtract.966, divide.967)
  divide.969 = f64[32768,32]{1,0} divide(multiply.950, broadcast.893)
  add.970 = f64[32768,32]{1,0} add(subtract.968, divide.969)
  slice.1012 = f64[32768,32,1]{2,1,0} slice(reshape.946), slice={[0:32768], [0:32], [1:2]}
  reshape.1013 = f64[32768,32]{1,0} reshape(slice.1012)
  multiply.1014 = f64[32768,32]{1,0} multiply(add.970, reshape.1013)
  add.1015 = f64[32768,32]{1,0} add(multiply.1011, multiply.1014)
  constant.882 = f64[] constant(1)
  broadcast.883 = f64[32768,32]{1,0} broadcast(constant.882), dimensions={}
  divide.971 = f64[32768,32]{1,0} divide(subtract.918, broadcast.887)
  subtract.972 = f64[32768,32]{1,0} subtract(broadcast.883, divide.971)
  constant.880 = f64[] constant(5)
  broadcast.881 = f64[32768,32]{1,0} broadcast(constant.880), dimensions={}
  multiply.973 = f64[32768,32]{1,0} multiply(multiply.947, broadcast.881)
  constant.878 = f64[] constant(4)
  broadcast.879 = f64[32768,32]{1,0} broadcast(constant.878), dimensions={}
  divide.974 = f64[32768,32]{1,0} divide(multiply.973, broadcast.879)
  subtract.975 = f64[32768,32]{1,0} subtract(subtract.972, divide.974)
  multiply.976 = f64[32768,32]{1,0} multiply(multiply.948, broadcast.881)
  constant.876 = f64[] constant(12)
  broadcast.877 = f64[32768,32]{1,0} broadcast(constant.876), dimensions={}
  divide.977 = f64[32768,32]{1,0} divide(multiply.976, broadcast.877)
  add.978 = f64[32768,32]{1,0} add(subtract.975, divide.977)
  divide.979 = f64[32768,32]{1,0} divide(multiply.949, broadcast.879)
  add.980 = f64[32768,32]{1,0} add(add.978, divide.979)
  divide.981 = f64[32768,32]{1,0} divide(multiply.950, broadcast.877)
  subtract.982 = f64[32768,32]{1,0} subtract(add.980, divide.981)
  slice.1016 = f64[32768,32,1]{2,1,0} slice(reshape.946), slice={[0:32768], [0:32], [2:3]}
  reshape.1017 = f64[32768,32]{1,0} reshape(slice.1016)
  multiply.1018 = f64[32768,32]{1,0} multiply(subtract.982, reshape.1017)
  add.1019 = f64[32768,32]{1,0} add(add.1015, multiply.1018)
  multiply.983 = f64[32768,32]{1,0} multiply(multiply.947, broadcast.889)
  divide.984 = f64[32768,32]{1,0} divide(multiply.983, broadcast.887)
  add.985 = f64[32768,32]{1,0} add(subtract.918, divide.984)
  constant.874 = f64[] constant(7)
  broadcast.875 = f64[32768,32]{1,0} broadcast(constant.874), dimensions={}
  multiply.986 = f64[32768,32]{1,0} multiply(multiply.948, broadcast.875)
  divide.987 = f64[32768,32]{1,0} divide(multiply.986, broadcast.877)
  subtract.988 = f64[32768,32]{1,0} subtract(add.985, divide.987)
  divide.989 = f64[32768,32]{1,0} divide(multiply.949, broadcast.885)
  subtract.990 = f64[32768,32]{1,0} subtract(subtract.988, divide.989)
  divide.991 = f64[32768,32]{1,0} divide(multiply.950, broadcast.877)
  add.992 = f64[32768,32]{1,0} add(subtract.990, divide.991)
  slice.1020 = f64[32768,32,1]{2,1,0} slice(reshape.946), slice={[0:32768], [0:32], [3:4]}
  reshape.1021 = f64[32768,32]{1,0} reshape(slice.1020)
  multiply.1022 = f64[32768,32]{1,0} multiply(add.992, reshape.1021)
  add.1023 = f64[32768,32]{1,0} add(add.1019, multiply.1022)
  divide.993 = f64[32768,32]{1,0} divide(subtract.918, broadcast.879)
  negate.994 = f64[32768,32]{1,0} negate(divide.993)
  divide.995 = f64[32768,32]{1,0} divide(multiply.947, broadcast.893)
  subtract.996 = f64[32768,32]{1,0} subtract(negate.994, divide.995)
  multiply.997 = f64[32768,32]{1,0} multiply(multiply.948, broadcast.875)
  divide.998 = f64[32768,32]{1,0} divide(multiply.997, broadcast.893)
  add.999 = f64[32768,32]{1,0} add(subtract.996, divide.998)
  divide.1000 = f64[32768,32]{1,0} divide(multiply.949, broadcast.893)
  add.1001 = f64[32768,32]{1,0} add(add.999, divide.1000)
  divide.1002 = f64[32768,32]{1,0} divide(multiply.950, broadcast.893)
  subtract.1003 = f64[32768,32]{1,0} subtract(add.1001, divide.1002)
  slice.1024 = f64[32768,32,1]{2,1,0} slice(reshape.946), slice={[0:32768], [0:32], [4:5]}
  reshape.1025 = f64[32768,32]{1,0} reshape(slice.1024)
  multiply.1026 = f64[32768,32]{1,0} multiply(subtract.1003, reshape.1025)
  add.1027 = f64[32768,32]{1,0} add(add.1023, multiply.1026)
  constant.872 = f64[] constant(30)
  broadcast.873 = f64[32768,32]{1,0} broadcast(constant.872), dimensions={}
  divide.1004 = f64[32768,32]{1,0} divide(subtract.918, broadcast.873)
  divide.1005 = f64[32768,32]{1,0} divide(multiply.948, broadcast.893)
  subtract.1006 = f64[32768,32]{1,0} subtract(divide.1004, divide.1005)
  divide.1007 = f64[32768,32]{1,0} divide(multiply.950, broadcast.891)
  add.1008 = f64[32768,32]{1,0} add(subtract.1006, divide.1007)
  slice.1028 = f64[32768,32,1]{2,1,0} slice(reshape.946), slice={[0:32768], [0:32], [5:6]}
  reshape.1029 = f64[32768,32]{1,0} reshape(slice.1028)
  multiply.1030 = f64[32768,32]{1,0} multiply(add.1008, reshape.1029)
  ROOT add.1031 = f64[32768,32]{1,0} add(add.1027, multiply.1030)
}

_where.1032 {
  Arg_0.1033 = pred[] parameter(0)
  Arg_1.1034 = s32[] parameter(1)
  Arg_2.1035 = s32[] parameter(2)
  ROOT select.1036 = s32[] select(Arg_0.1033, Arg_1.1034, Arg_2.1035)
}

remainder.1037 {
  Arg_0.1038 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.1039 = s64[] parameter(1)
  convert.1044 = s32[] convert(Arg_1.1039)
  constant.1043 = s32[] constant(0)
  compare.1045 = pred[] compare(convert.1044, constant.1043), direction=EQ
  constant.1042 = s32[] constant(1)
  call.1046 = s32[] call(compare.1045, constant.1042, convert.1044), to_apply=_where.1032
  broadcast.1047 = s32[32768,32,6]{2,1,0} broadcast(call.1046), dimensions={}
  remainder.1048 = s32[32768,32,6]{2,1,0} remainder(Arg_0.1038, broadcast.1047)
  constant.1040 = s32[] constant(0)
  broadcast.1041 = s32[32768,32,6]{2,1,0} broadcast(constant.1040), dimensions={}
  compare.1050 = pred[32768,32,6]{2,1,0} compare(remainder.1048, broadcast.1041), direction=LT
  compare.1051 = pred[] compare(call.1046, constant.1043), direction=LT
  broadcast.1052 = pred[32768,32,6]{2,1,0} broadcast(compare.1051), dimensions={}
  compare.1053 = pred[32768,32,6]{2,1,0} compare(compare.1050, broadcast.1052), direction=NE
  compare.1049 = pred[32768,32,6]{2,1,0} compare(remainder.1048, broadcast.1041), direction=NE
  and.1054 = pred[32768,32,6]{2,1,0} and(compare.1053, compare.1049)
  broadcast.1055 = s32[32768,32,6]{2,1,0} broadcast(call.1046), dimensions={}
  add.1056 = s32[32768,32,6]{2,1,0} add(remainder.1048, broadcast.1055)
  ROOT select.1057 = s32[32768,32,6]{2,1,0} select(and.1054, add.1056, remainder.1048)
}

advect_1d_vectorized.1058 {
  iota.1095 = f64[32]{0} iota(), iota_dimension=0
  reshape.1101 = f64[1,32]{1,0} reshape(iota.1095)
  broadcast.1102 = f64[1,32]{1,0} broadcast(reshape.1101), dimensions={0,1}
  reshape.1103 = f64[32]{0} reshape(broadcast.1102)
  broadcast.1104 = f64[32768,32]{1,0} broadcast(reshape.1103), dimensions={1}
  Arg_1.1060 = f64[32768]{0} parameter(1)
  reshape.1096 = f64[32768,1]{1,0} reshape(Arg_1.1060)
  Arg_2.1061 = f64[] parameter(2)
  broadcast.1097 = f64[32768,1]{1,0} broadcast(Arg_2.1061), dimensions={}
  multiply.1098 = f64[32768,1]{1,0} multiply(reshape.1096, broadcast.1097)
  Arg_3.1062 = f64[] parameter(3)
  broadcast.1099 = f64[32768,1]{1,0} broadcast(Arg_3.1062), dimensions={}
  divide.1100 = f64[32768,1]{1,0} divide(multiply.1098, broadcast.1099)
  broadcast.1105 = f64[32768,1]{1,0} broadcast(divide.1100), dimensions={0,1}
  reshape.1106 = f64[32768]{0} reshape(broadcast.1105)
  broadcast.1107 = f64[32768,32]{1,0} broadcast(reshape.1106), dimensions={0}
  subtract.1108 = f64[32768,32]{1,0} subtract(broadcast.1104, broadcast.1107)
  floor.1109 = f64[32768,32]{1,0} floor(subtract.1108)
  subtract.1110 = f64[32768,32]{1,0} subtract(subtract.1108, floor.1109)
  constant.1086 = f64[] constant(20)
  broadcast.1087 = f64[32768,32]{1,0} broadcast(constant.1086), dimensions={}
  divide.1143 = f64[32768,32]{1,0} divide(subtract.1110, broadcast.1087)
  multiply.1139 = f64[32768,32]{1,0} multiply(subtract.1110, subtract.1110)
  constant.1084 = f64[] constant(24)
  broadcast.1085 = f64[32768,32]{1,0} broadcast(constant.1084), dimensions={}
  divide.1144 = f64[32768,32]{1,0} divide(multiply.1139, broadcast.1085)
  subtract.1145 = f64[32768,32]{1,0} subtract(divide.1143, divide.1144)
  multiply.1140 = f64[32768,32]{1,0} multiply(multiply.1139, subtract.1110)
  divide.1146 = f64[32768,32]{1,0} divide(multiply.1140, broadcast.1085)
  subtract.1147 = f64[32768,32]{1,0} subtract(subtract.1145, divide.1146)
  multiply.1141 = f64[32768,32]{1,0} multiply(multiply.1140, subtract.1110)
  divide.1148 = f64[32768,32]{1,0} divide(multiply.1141, broadcast.1085)
  add.1149 = f64[32768,32]{1,0} add(subtract.1147, divide.1148)
  multiply.1142 = f64[32768,32]{1,0} multiply(multiply.1141, subtract.1110)
  constant.1082 = f64[] constant(120)
  broadcast.1083 = f64[32768,32]{1,0} broadcast(constant.1082), dimensions={}
  divide.1150 = f64[32768,32]{1,0} divide(multiply.1142, broadcast.1083)
  subtract.1151 = f64[32768,32]{1,0} subtract(add.1149, divide.1150)
  Arg_0.1059 = f64[32768,32]{1,0} parameter(0)
  reshape.1130 = f64[1048576]{0} reshape(Arg_0.1059)
  iota.1122 = s64[32768]{0} iota(), iota_dimension=0
  reshape.1123 = s64[32768,1,1]{2,1,0} reshape(iota.1122)
  constant.1092 = s64[] constant(32)
  broadcast.1093 = s64[32768,1,1]{2,1,0} broadcast(constant.1092), dimensions={}
  multiply.1124 = s64[32768,1,1]{2,1,0} multiply(reshape.1123, broadcast.1093)
  broadcast.1126 = s64[32768,1,1]{2,1,0} broadcast(multiply.1124), dimensions={0,1,2}
  reshape.1127 = s64[32768]{0} reshape(broadcast.1126)
  broadcast.1128 = s64[32768,32,6]{2,1,0} broadcast(reshape.1127), dimensions={0}
  convert.1111 = s32[32768,32]{1,0} convert(floor.1109)
  reshape.1112 = s32[32768,32,1]{2,1,0} reshape(convert.1111)
  broadcast.1114 = s32[32768,32,1]{2,1,0} broadcast(reshape.1112), dimensions={0,1,2}
  reshape.1115 = s32[32768,32]{1,0} reshape(broadcast.1114)
  broadcast.1116 = s32[32768,32,6]{2,1,0} broadcast(reshape.1115), dimensions={0,1}
  Arg_4.1063 = s32[6]{0} parameter(4)
  reshape.1113 = s32[1,1,6]{2,1,0} reshape(Arg_4.1063)
  broadcast.1117 = s32[1,1,6]{2,1,0} broadcast(reshape.1113), dimensions={0,1,2}
  reshape.1118 = s32[6]{0} reshape(broadcast.1117)
  broadcast.1119 = s32[32768,32,6]{2,1,0} broadcast(reshape.1118), dimensions={2}
  add.1120 = s32[32768,32,6]{2,1,0} add(broadcast.1116, broadcast.1119)
  constant.1094 = s64[] constant(32)
  call.1121 = s32[32768,32,6]{2,1,0} call(add.1120, constant.1094), to_apply=remainder.1037
  convert.1125 = s64[32768,32,6]{2,1,0} convert(call.1121)
  add.1129 = s64[32768,32,6]{2,1,0} add(broadcast.1128, convert.1125)
  reshape.1131 = s64[6291456]{0} reshape(add.1129)
  constant.1090 = s64[] constant(0)
  broadcast.1091 = s64[6291456]{0} broadcast(constant.1090), dimensions={}
  compare.1132 = pred[6291456]{0} compare(reshape.1131, broadcast.1091), direction=LT
  constant.1088 = s64[] constant(1048576)
  broadcast.1089 = s64[6291456]{0} broadcast(constant.1088), dimensions={}
  add.1133 = s64[6291456]{0} add(reshape.1131, broadcast.1089)
  select.1134 = s64[6291456]{0} select(compare.1132, add.1133, reshape.1131)
  convert.1135 = s32[6291456]{0} convert(select.1134)
  reshape.1136 = s32[6291456,1]{1,0} reshape(convert.1135)
  gather.1137 = f64[6291456]{0} gather(reshape.1130, reshape.1136), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.1138 = f64[32768,32,6]{2,1,0} reshape(gather.1137)
  slice.1201 = f64[32768,32,1]{2,1,0} slice(reshape.1138), slice={[0:32768], [0:32], [0:1]}
  reshape.1202 = f64[32768,32]{1,0} reshape(slice.1201)
  multiply.1203 = f64[32768,32]{1,0} multiply(subtract.1151, reshape.1202)
  constant.1080 = f64[] constant(2)
  broadcast.1081 = f64[32768,32]{1,0} broadcast(constant.1080), dimensions={}
  divide.1152 = f64[32768,32]{1,0} divide(subtract.1110, broadcast.1081)
  negate.1153 = f64[32768,32]{1,0} negate(divide.1152)
  multiply.1154 = f64[32768,32]{1,0} multiply(multiply.1139, broadcast.1081)
  constant.1078 = f64[] constant(3)
  broadcast.1079 = f64[32768,32]{1,0} broadcast(constant.1078), dimensions={}
  divide.1155 = f64[32768,32]{1,0} divide(multiply.1154, broadcast.1079)
  add.1156 = f64[32768,32]{1,0} add(negate.1153, divide.1155)
  divide.1157 = f64[32768,32]{1,0} divide(multiply.1140, broadcast.1085)
  subtract.1158 = f64[32768,32]{1,0} subtract(add.1156, divide.1157)
  constant.1076 = f64[] constant(6)
  broadcast.1077 = f64[32768,32]{1,0} broadcast(constant.1076), dimensions={}
  divide.1159 = f64[32768,32]{1,0} divide(multiply.1141, broadcast.1077)
  subtract.1160 = f64[32768,32]{1,0} subtract(subtract.1158, divide.1159)
  divide.1161 = f64[32768,32]{1,0} divide(multiply.1142, broadcast.1085)
  add.1162 = f64[32768,32]{1,0} add(subtract.1160, divide.1161)
  slice.1204 = f64[32768,32,1]{2,1,0} slice(reshape.1138), slice={[0:32768], [0:32], [1:2]}
  reshape.1205 = f64[32768,32]{1,0} reshape(slice.1204)
  multiply.1206 = f64[32768,32]{1,0} multiply(add.1162, reshape.1205)
  add.1207 = f64[32768,32]{1,0} add(multiply.1203, multiply.1206)
  constant.1074 = f64[] constant(1)
  broadcast.1075 = f64[32768,32]{1,0} broadcast(constant.1074), dimensions={}
  divide.1163 = f64[32768,32]{1,0} divide(subtract.1110, broadcast.1079)
  subtract.1164 = f64[32768,32]{1,0} subtract(broadcast.1075, divide.1163)
  constant.1072 = f64[] constant(5)
  broadcast.1073 = f64[32768,32]{1,0} broadcast(constant.1072), dimensions={}
  multiply.1165 = f64[32768,32]{1,0} multiply(multiply.1139, broadcast.1073)
  constant.1070 = f64[] constant(4)
  broadcast.1071 = f64[32768,32]{1,0} broadcast(constant.1070), dimensions={}
  divide.1166 = f64[32768,32]{1,0} divide(multiply.1165, broadcast.1071)
  subtract.1167 = f64[32768,32]{1,0} subtract(subtract.1164, divide.1166)
  multiply.1168 = f64[32768,32]{1,0} multiply(multiply.1140, broadcast.1073)
  constant.1068 = f64[] constant(12)
  broadcast.1069 = f64[32768,32]{1,0} broadcast(constant.1068), dimensions={}
  divide.1169 = f64[32768,32]{1,0} divide(multiply.1168, broadcast.1069)
  add.1170 = f64[32768,32]{1,0} add(subtract.1167, divide.1169)
  divide.1171 = f64[32768,32]{1,0} divide(multiply.1141, broadcast.1071)
  add.1172 = f64[32768,32]{1,0} add(add.1170, divide.1171)
  divide.1173 = f64[32768,32]{1,0} divide(multiply.1142, broadcast.1069)
  subtract.1174 = f64[32768,32]{1,0} subtract(add.1172, divide.1173)
  slice.1208 = f64[32768,32,1]{2,1,0} slice(reshape.1138), slice={[0:32768], [0:32], [2:3]}
  reshape.1209 = f64[32768,32]{1,0} reshape(slice.1208)
  multiply.1210 = f64[32768,32]{1,0} multiply(subtract.1174, reshape.1209)
  add.1211 = f64[32768,32]{1,0} add(add.1207, multiply.1210)
  multiply.1175 = f64[32768,32]{1,0} multiply(multiply.1139, broadcast.1081)
  divide.1176 = f64[32768,32]{1,0} divide(multiply.1175, broadcast.1079)
  add.1177 = f64[32768,32]{1,0} add(subtract.1110, divide.1176)
  constant.1066 = f64[] constant(7)
  broadcast.1067 = f64[32768,32]{1,0} broadcast(constant.1066), dimensions={}
  multiply.1178 = f64[32768,32]{1,0} multiply(multiply.1140, broadcast.1067)
  divide.1179 = f64[32768,32]{1,0} divide(multiply.1178, broadcast.1069)
  subtract.1180 = f64[32768,32]{1,0} subtract(add.1177, divide.1179)
  divide.1181 = f64[32768,32]{1,0} divide(multiply.1141, broadcast.1077)
  subtract.1182 = f64[32768,32]{1,0} subtract(subtract.1180, divide.1181)
  divide.1183 = f64[32768,32]{1,0} divide(multiply.1142, broadcast.1069)
  add.1184 = f64[32768,32]{1,0} add(subtract.1182, divide.1183)
  slice.1212 = f64[32768,32,1]{2,1,0} slice(reshape.1138), slice={[0:32768], [0:32], [3:4]}
  reshape.1213 = f64[32768,32]{1,0} reshape(slice.1212)
  multiply.1214 = f64[32768,32]{1,0} multiply(add.1184, reshape.1213)
  add.1215 = f64[32768,32]{1,0} add(add.1211, multiply.1214)
  divide.1185 = f64[32768,32]{1,0} divide(subtract.1110, broadcast.1071)
  negate.1186 = f64[32768,32]{1,0} negate(divide.1185)
  divide.1187 = f64[32768,32]{1,0} divide(multiply.1139, broadcast.1085)
  subtract.1188 = f64[32768,32]{1,0} subtract(negate.1186, divide.1187)
  multiply.1189 = f64[32768,32]{1,0} multiply(multiply.1140, broadcast.1067)
  divide.1190 = f64[32768,32]{1,0} divide(multiply.1189, broadcast.1085)
  add.1191 = f64[32768,32]{1,0} add(subtract.1188, divide.1190)
  divide.1192 = f64[32768,32]{1,0} divide(multiply.1141, broadcast.1085)
  add.1193 = f64[32768,32]{1,0} add(add.1191, divide.1192)
  divide.1194 = f64[32768,32]{1,0} divide(multiply.1142, broadcast.1085)
  subtract.1195 = f64[32768,32]{1,0} subtract(add.1193, divide.1194)
  slice.1216 = f64[32768,32,1]{2,1,0} slice(reshape.1138), slice={[0:32768], [0:32], [4:5]}
  reshape.1217 = f64[32768,32]{1,0} reshape(slice.1216)
  multiply.1218 = f64[32768,32]{1,0} multiply(subtract.1195, reshape.1217)
  add.1219 = f64[32768,32]{1,0} add(add.1215, multiply.1218)
  constant.1064 = f64[] constant(30)
  broadcast.1065 = f64[32768,32]{1,0} broadcast(constant.1064), dimensions={}
  divide.1196 = f64[32768,32]{1,0} divide(subtract.1110, broadcast.1065)
  divide.1197 = f64[32768,32]{1,0} divide(multiply.1140, broadcast.1085)
  subtract.1198 = f64[32768,32]{1,0} subtract(divide.1196, divide.1197)
  divide.1199 = f64[32768,32]{1,0} divide(multiply.1142, broadcast.1083)
  add.1200 = f64[32768,32]{1,0} add(subtract.1198, divide.1199)
  slice.1220 = f64[32768,32,1]{2,1,0} slice(reshape.1138), slice={[0:32768], [0:32], [5:6]}
  reshape.1221 = f64[32768,32]{1,0} reshape(slice.1220)
  multiply.1222 = f64[32768,32]{1,0} multiply(add.1200, reshape.1221)
  ROOT add.1223 = f64[32768,32]{1,0} add(add.1219, multiply.1222)
}

None.1224 {
  Arg_7.1232 = f64[32,32]{1,0} parameter(7)
  Arg_8.1233 = f64[32,32]{1,0} parameter(8)
  Arg_6.1231 = f64[32,32,32,32]{3,2,1,0} parameter(6)
  transpose.1239 = f64[32,32,32,32]{2,1,0,3} transpose(Arg_6.1231), dimensions={1,2,3,0}
  reshape.1240 = f64[32768,32]{1,0} reshape(transpose.1239)
  Arg_0.1225 = f64[32]{0} parameter(0)
  reshape.1238 = f64[1,32,1]{2,1,0} reshape(Arg_0.1225)
  broadcast.1241 = f64[1,32,1]{2,1,0} broadcast(reshape.1238), dimensions={0,1,2}
  reshape.1242 = f64[32]{0} reshape(broadcast.1241)
  broadcast.1243 = f64[32,32,32]{2,1,0} broadcast(reshape.1242), dimensions={1}
  reshape.1244 = f64[32768]{0} reshape(broadcast.1243)
  constant.1237 = f64[] constant(0.025)
  constant.1236 = f64[] constant(0.39269908169872414)
  Arg_1.1226 = s32[6]{0} parameter(1)
  call.1245 = f64[32768,32]{1,0} call(reshape.1240, reshape.1244, constant.1237, constant.1236, Arg_1.1226), to_apply=advect_1d_vectorized.43
  reshape.1246 = f64[32,32,32,32]{3,2,1,0} reshape(call.1245)
  transpose.1248 = f64[32,32,32,32]{0,2,1,3} transpose(reshape.1246), dimensions={3,1,2,0}
  reshape.1249 = f64[32768,32]{1,0} reshape(transpose.1248)
  Arg_2.1227 = f64[32]{0} parameter(2)
  reshape.1247 = f64[1,1,32]{2,1,0} reshape(Arg_2.1227)
  broadcast.1250 = f64[1,1,32]{2,1,0} broadcast(reshape.1247), dimensions={0,1,2}
  reshape.1251 = f64[32]{0} reshape(broadcast.1250)
  broadcast.1252 = f64[32,32,32]{2,1,0} broadcast(reshape.1251), dimensions={2}
  reshape.1253 = f64[32768]{0} reshape(broadcast.1252)
  call.1254 = f64[32768,32]{1,0} call(reshape.1249, reshape.1253, constant.1237, constant.1236, Arg_1.1226), to_apply=advect_1d_vectorized.235
  reshape.1255 = f64[32,32,32,32]{3,2,1,0} reshape(call.1254)
  transpose.1263 = f64[32,32,32,32]{1,2,3,0} transpose(reshape.1255), dimensions={0,3,2,1}
  reshape.1264 = f64[32768,32]{1,0} reshape(transpose.1263)
  transpose.1256 = f64[32,32,32,32]{1,3,2,0} transpose(reshape.1255), dimensions={0,3,1,2}
  Arg_3.1228 = f64[32,1]{1,0} parameter(3)
  Arg_4.1229 = f64[1,17]{1,0} parameter(4)
  Arg_5.1230 = f64[32,17]{1,0} parameter(5)
  constant.1235 = f64[] constant(0.32258064516129031)
  call.1257 = (f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) call(transpose.1256, Arg_3.1228, Arg_4.1229, Arg_5.1230, constant.1235, constant.1235), to_apply=solve_poisson.417
  get-tuple-element.1258 = f64[32,32]{1,0} get-tuple-element(call.1257), index=0
  reshape.1262 = f64[32,32,1]{2,1,0} reshape(get-tuple-element.1258)
  broadcast.1265 = f64[32,32,1]{2,1,0} broadcast(reshape.1262), dimensions={0,1,2}
  reshape.1266 = f64[32,32]{1,0} reshape(broadcast.1265)
  broadcast.1267 = f64[32,32,32]{2,1,0} broadcast(reshape.1266), dimensions={0,1}
  reshape.1268 = f64[32768]{0} reshape(broadcast.1267)
  constant.1234 = f64[] constant(0.05)
  call.1269 = f64[32768,32]{1,0} call(reshape.1264, reshape.1268, constant.1234, constant.1235, Arg_1.1226), to_apply=advect_1d_vectorized_1.472
  reshape.1270 = f64[32,32,32,32]{3,2,1,0} reshape(call.1269)
  transpose.1271 = f64[32,32,32,32]{2,3,1,0} transpose(reshape.1270), dimensions={0,1,3,2}
  reshape.1273 = f64[32768,32]{1,0} reshape(transpose.1271)
  get-tuple-element.1259 = f64[32,32]{1,0} get-tuple-element(call.1257), index=1
  reshape.1272 = f64[32,32,1]{2,1,0} reshape(get-tuple-element.1259)
  broadcast.1274 = f64[32,32,1]{2,1,0} broadcast(reshape.1272), dimensions={0,1,2}
  reshape.1275 = f64[32,32]{1,0} reshape(broadcast.1274)
  broadcast.1276 = f64[32,32,32]{2,1,0} broadcast(reshape.1275), dimensions={0,1}
  reshape.1277 = f64[32768]{0} reshape(broadcast.1276)
  call.1278 = f64[32768,32]{1,0} call(reshape.1273, reshape.1277, constant.1234, constant.1235, Arg_1.1226), to_apply=advect_1d_vectorized_1.664
  reshape.1279 = f64[32,32,32,32]{3,2,1,0} reshape(call.1278)
  transpose.1281 = f64[32,32,32,32]{2,1,3,0} transpose(reshape.1279), dimensions={0,2,3,1}
  reshape.1282 = f64[32768,32]{1,0} reshape(transpose.1281)
  reshape.1280 = f64[1,1,32]{2,1,0} reshape(Arg_2.1227)
  broadcast.1283 = f64[1,1,32]{2,1,0} broadcast(reshape.1280), dimensions={0,1,2}
  reshape.1284 = f64[32]{0} reshape(broadcast.1283)
  broadcast.1285 = f64[32,32,32]{2,1,0} broadcast(reshape.1284), dimensions={2}
  reshape.1286 = f64[32768]{0} reshape(broadcast.1285)
  call.1287 = f64[32768,32]{1,0} call(reshape.1282, reshape.1286, constant.1237, constant.1236, Arg_1.1226), to_apply=advect_1d_vectorized.866
  reshape.1288 = f64[32,32,32,32]{3,2,1,0} reshape(call.1287)
  transpose.1290 = f64[32,32,32,32]{0,2,1,3} transpose(reshape.1288), dimensions={3,1,2,0}
  reshape.1291 = f64[32768,32]{1,0} reshape(transpose.1290)
  reshape.1289 = f64[1,32,1]{2,1,0} reshape(Arg_0.1225)
  broadcast.1292 = f64[1,32,1]{2,1,0} broadcast(reshape.1289), dimensions={0,1,2}
  reshape.1293 = f64[32]{0} reshape(broadcast.1292)
  broadcast.1294 = f64[32,32,32]{2,1,0} broadcast(reshape.1293), dimensions={1}
  reshape.1295 = f64[32768]{0} reshape(broadcast.1294)
  call.1296 = f64[32768,32]{1,0} call(reshape.1291, reshape.1295, constant.1237, constant.1236, Arg_1.1226), to_apply=advect_1d_vectorized.1058
  reshape.1297 = f64[32,32,32,32]{3,2,1,0} reshape(call.1296)
  transpose.1298 = f64[32,32,32,32]{0,3,2,1} transpose(reshape.1297), dimensions={3,0,1,2}
  get-tuple-element.1260 = f64[32,32]{1,0} get-tuple-element(call.1257), index=2
  get-tuple-element.1261 = f64[32,32]{1,0} get-tuple-element(call.1257), index=3
  ROOT tuple.1299 = (f64[32,32,32,32]{0,3,2,1}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(transpose.1298, get-tuple-element.1260, get-tuple-element.1261)
}

region_0.1300 {
  arg_tuple.1301 = (s64[], f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) parameter(0)
  get-tuple-element.1302 = s64[] get-tuple-element(arg_tuple.1301), index=0
  constant.1306 = s64[] constant(1)
  add.1316 = s64[] add(get-tuple-element.1302, constant.1306)
  constant.1311 = f64[32]{0} constant({...})
  constant.1310 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  constant.1309 = f64[32,1]{1,0} constant({...})
  constant.1308 = f64[1,17]{1,0} constant({...})
  constant.1307 = f64[32,17]{1,0} constant({...})
  get-tuple-element.1303 = f64[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.1301), index=1
  get-tuple-element.1304 = f64[32,32]{1,0} get-tuple-element(arg_tuple.1301), index=2
  get-tuple-element.1305 = f64[32,32]{1,0} get-tuple-element(arg_tuple.1301), index=3
  call.1312 = (f64[32,32,32,32]{0,3,2,1}, f64[32,32]{1,0}, f64[32,32]{1,0}) call(constant.1311, constant.1310, constant.1311, constant.1309, constant.1308, constant.1307, get-tuple-element.1303, get-tuple-element.1304, get-tuple-element.1305), to_apply=None.1224
  get-tuple-element.1313 = f64[32,32,32,32]{0,3,2,1} get-tuple-element(call.1312), index=0
  get-tuple-element.1314 = f64[32,32]{1,0} get-tuple-element(call.1312), index=1
  get-tuple-element.1315 = f64[32,32]{1,0} get-tuple-element(call.1312), index=2
  ROOT tuple.1317 = (s64[], f64[32,32,32,32]{0,3,2,1}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(add.1316, get-tuple-element.1313, get-tuple-element.1314, get-tuple-element.1315)
}

region_2.1318 {
  arg_tuple.1319 = (s64[], f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) parameter(0)
  get-tuple-element.1321 = f64[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.1319), index=1
  get-tuple-element.1322 = f64[32,32]{1,0} get-tuple-element(arg_tuple.1319), index=2
  get-tuple-element.1323 = f64[32,32]{1,0} get-tuple-element(arg_tuple.1319), index=3
  get-tuple-element.1320 = s64[] get-tuple-element(arg_tuple.1319), index=0
  constant.1324 = s64[] constant(128)
  ROOT compare.1325 = pred[] compare(get-tuple-element.1320, constant.1324), direction=LT
}

ENTRY main.1334 {
  constant.15 = s64[] constant(0)
  Arg_2.3 = f64[32,32,32,32]{3,2,1,0} parameter(2)
  Arg_0.1 = f64[32,32]{1,0} parameter(0)
  Arg_1.2 = f64[32,32]{1,0} parameter(1)
  tuple.16 = (s64[], f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(constant.15, Arg_2.3, Arg_0.1, Arg_1.2)
  while.1326 = (s64[], f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) while(tuple.16), condition=region_2.1318, body=region_0.1300
  get-tuple-element.1327 = s64[] get-tuple-element(while.1326), index=0
  constant.14 = f64[32]{0} constant({...})
  constant.9 = f64[32]{0} constant({...})
  constant.11 = f64[32,1]{1,0} constant({...})
  constant.12 = f64[1,17]{1,0} constant({...})
  constant.13 = f64[32,17]{1,0} constant({...})
  constant.10 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  get-tuple-element.1329 = f64[32,32]{1,0} get-tuple-element(while.1326), index=2
  get-tuple-element.1330 = f64[32,32]{1,0} get-tuple-element(while.1326), index=3
  get-tuple-element.1328 = f64[32,32,32,32]{3,2,1,0} get-tuple-element(while.1326), index=1
  Arg_3.4 = f64[32,32]{1,0} parameter(3)
  Arg_4.5 = f64[] parameter(4)
  constant.7 = f64[] constant(6.4)
  add.1331 = f64[] add(Arg_4.5, constant.7)
  Arg_5.6 = s64[] parameter(5)
  constant.8 = s64[] constant(128)
  add.1332 = s64[] add(Arg_5.6, constant.8)
  ROOT tuple.1333 = (f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32,1]{1,0}, /*index=5*/f64[1,17]{1,0}, f64[32,17]{1,0}, s32[6]{0}, f64[32,32]{1,0}, f64[32,32]{1,0}, /*index=10*/f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[], s64[]) tuple(constant.14, constant.14, constant.9, constant.9, constant.11, constant.12, constant.13, constant.10, get-tuple-element.1329, get-tuple-element.1330, get-tuple-element.1328, Arg_3.4, add.1331, add.1332)
}

