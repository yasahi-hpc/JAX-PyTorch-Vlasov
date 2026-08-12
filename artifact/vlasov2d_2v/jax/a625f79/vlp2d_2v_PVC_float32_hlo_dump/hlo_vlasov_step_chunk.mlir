HloModule jit_run_chunk, entry_computation_layout={(f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[], /*index=5*/s32[])->(f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,1]{1,0}, /*index=5*/f32[1,17]{1,0}, f32[32,17]{1,0}, s32[6]{0}, f32[32,32]{1,0}, f32[32,32]{1,0}, /*index=10*/f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[], s32[])}

_where.17 {
  Arg_0.18 = pred[] parameter(0)
  Arg_1.19 = s32[] parameter(1)
  Arg_2.20 = s32[] parameter(2)
  ROOT select.21 = s32[] select(Arg_0.18, Arg_1.19, Arg_2.20)
}

remainder.22 {
  Arg_0.23 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.24 = s32[] parameter(1)
  constant.28 = s32[] constant(0)
  compare.29 = pred[] compare(Arg_1.24, constant.28), direction=EQ
  constant.27 = s32[] constant(1)
  call.30 = s32[] call(compare.29, constant.27, Arg_1.24), to_apply=_where.17
  broadcast.31 = s32[32768,32,6]{2,1,0} broadcast(call.30), dimensions={}
  remainder.32 = s32[32768,32,6]{2,1,0} remainder(Arg_0.23, broadcast.31)
  constant.25 = s32[] constant(0)
  broadcast.26 = s32[32768,32,6]{2,1,0} broadcast(constant.25), dimensions={}
  compare.34 = pred[32768,32,6]{2,1,0} compare(remainder.32, broadcast.26), direction=LT
  compare.35 = pred[] compare(call.30, constant.28), direction=LT
  broadcast.36 = pred[32768,32,6]{2,1,0} broadcast(compare.35), dimensions={}
  compare.37 = pred[32768,32,6]{2,1,0} compare(compare.34, broadcast.36), direction=NE
  compare.33 = pred[32768,32,6]{2,1,0} compare(remainder.32, broadcast.26), direction=NE
  and.38 = pred[32768,32,6]{2,1,0} and(compare.37, compare.33)
  broadcast.39 = s32[32768,32,6]{2,1,0} broadcast(call.30), dimensions={}
  add.40 = s32[32768,32,6]{2,1,0} add(remainder.32, broadcast.39)
  ROOT select.41 = s32[32768,32,6]{2,1,0} select(and.38, add.40, remainder.32)
}

advect_1d_vectorized.42 {
  iota.79 = f32[32]{0} iota(), iota_dimension=0
  reshape.85 = f32[1,32]{1,0} reshape(iota.79)
  broadcast.86 = f32[1,32]{1,0} broadcast(reshape.85), dimensions={0,1}
  reshape.87 = f32[32]{0} reshape(broadcast.86)
  broadcast.88 = f32[32768,32]{1,0} broadcast(reshape.87), dimensions={1}
  Arg_1.44 = f32[32768]{0} parameter(1)
  reshape.80 = f32[32768,1]{1,0} reshape(Arg_1.44)
  Arg_2.45 = f32[] parameter(2)
  broadcast.81 = f32[32768,1]{1,0} broadcast(Arg_2.45), dimensions={}
  multiply.82 = f32[32768,1]{1,0} multiply(reshape.80, broadcast.81)
  Arg_3.46 = f32[] parameter(3)
  broadcast.83 = f32[32768,1]{1,0} broadcast(Arg_3.46), dimensions={}
  divide.84 = f32[32768,1]{1,0} divide(multiply.82, broadcast.83)
  broadcast.89 = f32[32768,1]{1,0} broadcast(divide.84), dimensions={0,1}
  reshape.90 = f32[32768]{0} reshape(broadcast.89)
  broadcast.91 = f32[32768,32]{1,0} broadcast(reshape.90), dimensions={0}
  subtract.92 = f32[32768,32]{1,0} subtract(broadcast.88, broadcast.91)
  floor.93 = f32[32768,32]{1,0} floor(subtract.92)
  subtract.94 = f32[32768,32]{1,0} subtract(subtract.92, floor.93)
  constant.70 = f32[] constant(20)
  broadcast.71 = f32[32768,32]{1,0} broadcast(constant.70), dimensions={}
  divide.125 = f32[32768,32]{1,0} divide(subtract.94, broadcast.71)
  multiply.121 = f32[32768,32]{1,0} multiply(subtract.94, subtract.94)
  constant.68 = f32[] constant(24)
  broadcast.69 = f32[32768,32]{1,0} broadcast(constant.68), dimensions={}
  divide.126 = f32[32768,32]{1,0} divide(multiply.121, broadcast.69)
  subtract.127 = f32[32768,32]{1,0} subtract(divide.125, divide.126)
  multiply.122 = f32[32768,32]{1,0} multiply(multiply.121, subtract.94)
  divide.128 = f32[32768,32]{1,0} divide(multiply.122, broadcast.69)
  subtract.129 = f32[32768,32]{1,0} subtract(subtract.127, divide.128)
  multiply.123 = f32[32768,32]{1,0} multiply(multiply.122, subtract.94)
  divide.130 = f32[32768,32]{1,0} divide(multiply.123, broadcast.69)
  add.131 = f32[32768,32]{1,0} add(subtract.129, divide.130)
  multiply.124 = f32[32768,32]{1,0} multiply(multiply.123, subtract.94)
  constant.66 = f32[] constant(120)
  broadcast.67 = f32[32768,32]{1,0} broadcast(constant.66), dimensions={}
  divide.132 = f32[32768,32]{1,0} divide(multiply.124, broadcast.67)
  subtract.133 = f32[32768,32]{1,0} subtract(add.131, divide.132)
  Arg_0.43 = f32[32768,32]{1,0} parameter(0)
  reshape.113 = f32[1048576]{0} reshape(Arg_0.43)
  iota.106 = s32[32768]{0} iota(), iota_dimension=0
  reshape.107 = s32[32768,1,1]{2,1,0} reshape(iota.106)
  constant.76 = s32[] constant(32)
  broadcast.77 = s32[32768,1,1]{2,1,0} broadcast(constant.76), dimensions={}
  multiply.108 = s32[32768,1,1]{2,1,0} multiply(reshape.107, broadcast.77)
  broadcast.109 = s32[32768,1,1]{2,1,0} broadcast(multiply.108), dimensions={0,1,2}
  reshape.110 = s32[32768]{0} reshape(broadcast.109)
  broadcast.111 = s32[32768,32,6]{2,1,0} broadcast(reshape.110), dimensions={0}
  convert.95 = s32[32768,32]{1,0} convert(floor.93)
  reshape.96 = s32[32768,32,1]{2,1,0} reshape(convert.95)
  broadcast.98 = s32[32768,32,1]{2,1,0} broadcast(reshape.96), dimensions={0,1,2}
  reshape.99 = s32[32768,32]{1,0} reshape(broadcast.98)
  broadcast.100 = s32[32768,32,6]{2,1,0} broadcast(reshape.99), dimensions={0,1}
  Arg_4.47 = s32[6]{0} parameter(4)
  reshape.97 = s32[1,1,6]{2,1,0} reshape(Arg_4.47)
  broadcast.101 = s32[1,1,6]{2,1,0} broadcast(reshape.97), dimensions={0,1,2}
  reshape.102 = s32[6]{0} reshape(broadcast.101)
  broadcast.103 = s32[32768,32,6]{2,1,0} broadcast(reshape.102), dimensions={2}
  add.104 = s32[32768,32,6]{2,1,0} add(broadcast.100, broadcast.103)
  constant.78 = s32[] constant(32)
  call.105 = s32[32768,32,6]{2,1,0} call(add.104, constant.78), to_apply=remainder.22
  add.112 = s32[32768,32,6]{2,1,0} add(broadcast.111, call.105)
  reshape.114 = s32[6291456]{0} reshape(add.112)
  constant.74 = s32[] constant(0)
  broadcast.75 = s32[6291456]{0} broadcast(constant.74), dimensions={}
  compare.115 = pred[6291456]{0} compare(reshape.114, broadcast.75), direction=LT
  constant.72 = s32[] constant(1048576)
  broadcast.73 = s32[6291456]{0} broadcast(constant.72), dimensions={}
  add.116 = s32[6291456]{0} add(reshape.114, broadcast.73)
  select.117 = s32[6291456]{0} select(compare.115, add.116, reshape.114)
  reshape.118 = s32[6291456,1]{1,0} reshape(select.117)
  gather.119 = f32[6291456]{0} gather(reshape.113, reshape.118), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.120 = f32[32768,32,6]{2,1,0} reshape(gather.119)
  slice.183 = f32[32768,32,1]{2,1,0} slice(reshape.120), slice={[0:32768], [0:32], [0:1]}
  reshape.184 = f32[32768,32]{1,0} reshape(slice.183)
  multiply.185 = f32[32768,32]{1,0} multiply(subtract.133, reshape.184)
  constant.64 = f32[] constant(2)
  broadcast.65 = f32[32768,32]{1,0} broadcast(constant.64), dimensions={}
  divide.134 = f32[32768,32]{1,0} divide(subtract.94, broadcast.65)
  negate.135 = f32[32768,32]{1,0} negate(divide.134)
  multiply.136 = f32[32768,32]{1,0} multiply(multiply.121, broadcast.65)
  constant.62 = f32[] constant(3)
  broadcast.63 = f32[32768,32]{1,0} broadcast(constant.62), dimensions={}
  divide.137 = f32[32768,32]{1,0} divide(multiply.136, broadcast.63)
  add.138 = f32[32768,32]{1,0} add(negate.135, divide.137)
  divide.139 = f32[32768,32]{1,0} divide(multiply.122, broadcast.69)
  subtract.140 = f32[32768,32]{1,0} subtract(add.138, divide.139)
  constant.60 = f32[] constant(6)
  broadcast.61 = f32[32768,32]{1,0} broadcast(constant.60), dimensions={}
  divide.141 = f32[32768,32]{1,0} divide(multiply.123, broadcast.61)
  subtract.142 = f32[32768,32]{1,0} subtract(subtract.140, divide.141)
  divide.143 = f32[32768,32]{1,0} divide(multiply.124, broadcast.69)
  add.144 = f32[32768,32]{1,0} add(subtract.142, divide.143)
  slice.186 = f32[32768,32,1]{2,1,0} slice(reshape.120), slice={[0:32768], [0:32], [1:2]}
  reshape.187 = f32[32768,32]{1,0} reshape(slice.186)
  multiply.188 = f32[32768,32]{1,0} multiply(add.144, reshape.187)
  add.189 = f32[32768,32]{1,0} add(multiply.185, multiply.188)
  constant.58 = f32[] constant(1)
  broadcast.59 = f32[32768,32]{1,0} broadcast(constant.58), dimensions={}
  divide.145 = f32[32768,32]{1,0} divide(subtract.94, broadcast.63)
  subtract.146 = f32[32768,32]{1,0} subtract(broadcast.59, divide.145)
  constant.56 = f32[] constant(5)
  broadcast.57 = f32[32768,32]{1,0} broadcast(constant.56), dimensions={}
  multiply.147 = f32[32768,32]{1,0} multiply(multiply.121, broadcast.57)
  constant.54 = f32[] constant(4)
  broadcast.55 = f32[32768,32]{1,0} broadcast(constant.54), dimensions={}
  divide.148 = f32[32768,32]{1,0} divide(multiply.147, broadcast.55)
  subtract.149 = f32[32768,32]{1,0} subtract(subtract.146, divide.148)
  multiply.150 = f32[32768,32]{1,0} multiply(multiply.122, broadcast.57)
  constant.52 = f32[] constant(12)
  broadcast.53 = f32[32768,32]{1,0} broadcast(constant.52), dimensions={}
  divide.151 = f32[32768,32]{1,0} divide(multiply.150, broadcast.53)
  add.152 = f32[32768,32]{1,0} add(subtract.149, divide.151)
  divide.153 = f32[32768,32]{1,0} divide(multiply.123, broadcast.55)
  add.154 = f32[32768,32]{1,0} add(add.152, divide.153)
  divide.155 = f32[32768,32]{1,0} divide(multiply.124, broadcast.53)
  subtract.156 = f32[32768,32]{1,0} subtract(add.154, divide.155)
  slice.190 = f32[32768,32,1]{2,1,0} slice(reshape.120), slice={[0:32768], [0:32], [2:3]}
  reshape.191 = f32[32768,32]{1,0} reshape(slice.190)
  multiply.192 = f32[32768,32]{1,0} multiply(subtract.156, reshape.191)
  add.193 = f32[32768,32]{1,0} add(add.189, multiply.192)
  multiply.157 = f32[32768,32]{1,0} multiply(multiply.121, broadcast.65)
  divide.158 = f32[32768,32]{1,0} divide(multiply.157, broadcast.63)
  add.159 = f32[32768,32]{1,0} add(subtract.94, divide.158)
  constant.50 = f32[] constant(7)
  broadcast.51 = f32[32768,32]{1,0} broadcast(constant.50), dimensions={}
  multiply.160 = f32[32768,32]{1,0} multiply(multiply.122, broadcast.51)
  divide.161 = f32[32768,32]{1,0} divide(multiply.160, broadcast.53)
  subtract.162 = f32[32768,32]{1,0} subtract(add.159, divide.161)
  divide.163 = f32[32768,32]{1,0} divide(multiply.123, broadcast.61)
  subtract.164 = f32[32768,32]{1,0} subtract(subtract.162, divide.163)
  divide.165 = f32[32768,32]{1,0} divide(multiply.124, broadcast.53)
  add.166 = f32[32768,32]{1,0} add(subtract.164, divide.165)
  slice.194 = f32[32768,32,1]{2,1,0} slice(reshape.120), slice={[0:32768], [0:32], [3:4]}
  reshape.195 = f32[32768,32]{1,0} reshape(slice.194)
  multiply.196 = f32[32768,32]{1,0} multiply(add.166, reshape.195)
  add.197 = f32[32768,32]{1,0} add(add.193, multiply.196)
  divide.167 = f32[32768,32]{1,0} divide(subtract.94, broadcast.55)
  negate.168 = f32[32768,32]{1,0} negate(divide.167)
  divide.169 = f32[32768,32]{1,0} divide(multiply.121, broadcast.69)
  subtract.170 = f32[32768,32]{1,0} subtract(negate.168, divide.169)
  multiply.171 = f32[32768,32]{1,0} multiply(multiply.122, broadcast.51)
  divide.172 = f32[32768,32]{1,0} divide(multiply.171, broadcast.69)
  add.173 = f32[32768,32]{1,0} add(subtract.170, divide.172)
  divide.174 = f32[32768,32]{1,0} divide(multiply.123, broadcast.69)
  add.175 = f32[32768,32]{1,0} add(add.173, divide.174)
  divide.176 = f32[32768,32]{1,0} divide(multiply.124, broadcast.69)
  subtract.177 = f32[32768,32]{1,0} subtract(add.175, divide.176)
  slice.198 = f32[32768,32,1]{2,1,0} slice(reshape.120), slice={[0:32768], [0:32], [4:5]}
  reshape.199 = f32[32768,32]{1,0} reshape(slice.198)
  multiply.200 = f32[32768,32]{1,0} multiply(subtract.177, reshape.199)
  add.201 = f32[32768,32]{1,0} add(add.197, multiply.200)
  constant.48 = f32[] constant(30)
  broadcast.49 = f32[32768,32]{1,0} broadcast(constant.48), dimensions={}
  divide.178 = f32[32768,32]{1,0} divide(subtract.94, broadcast.49)
  divide.179 = f32[32768,32]{1,0} divide(multiply.122, broadcast.69)
  subtract.180 = f32[32768,32]{1,0} subtract(divide.178, divide.179)
  divide.181 = f32[32768,32]{1,0} divide(multiply.124, broadcast.67)
  add.182 = f32[32768,32]{1,0} add(subtract.180, divide.181)
  slice.202 = f32[32768,32,1]{2,1,0} slice(reshape.120), slice={[0:32768], [0:32], [5:6]}
  reshape.203 = f32[32768,32]{1,0} reshape(slice.202)
  multiply.204 = f32[32768,32]{1,0} multiply(add.182, reshape.203)
  ROOT add.205 = f32[32768,32]{1,0} add(add.201, multiply.204)
}

_where.206 {
  Arg_0.207 = pred[] parameter(0)
  Arg_1.208 = s32[] parameter(1)
  Arg_2.209 = s32[] parameter(2)
  ROOT select.210 = s32[] select(Arg_0.207, Arg_1.208, Arg_2.209)
}

remainder.211 {
  Arg_0.212 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.213 = s32[] parameter(1)
  constant.217 = s32[] constant(0)
  compare.218 = pred[] compare(Arg_1.213, constant.217), direction=EQ
  constant.216 = s32[] constant(1)
  call.219 = s32[] call(compare.218, constant.216, Arg_1.213), to_apply=_where.206
  broadcast.220 = s32[32768,32,6]{2,1,0} broadcast(call.219), dimensions={}
  remainder.221 = s32[32768,32,6]{2,1,0} remainder(Arg_0.212, broadcast.220)
  constant.214 = s32[] constant(0)
  broadcast.215 = s32[32768,32,6]{2,1,0} broadcast(constant.214), dimensions={}
  compare.223 = pred[32768,32,6]{2,1,0} compare(remainder.221, broadcast.215), direction=LT
  compare.224 = pred[] compare(call.219, constant.217), direction=LT
  broadcast.225 = pred[32768,32,6]{2,1,0} broadcast(compare.224), dimensions={}
  compare.226 = pred[32768,32,6]{2,1,0} compare(compare.223, broadcast.225), direction=NE
  compare.222 = pred[32768,32,6]{2,1,0} compare(remainder.221, broadcast.215), direction=NE
  and.227 = pred[32768,32,6]{2,1,0} and(compare.226, compare.222)
  broadcast.228 = s32[32768,32,6]{2,1,0} broadcast(call.219), dimensions={}
  add.229 = s32[32768,32,6]{2,1,0} add(remainder.221, broadcast.228)
  ROOT select.230 = s32[32768,32,6]{2,1,0} select(and.227, add.229, remainder.221)
}

advect_1d_vectorized.231 {
  iota.268 = f32[32]{0} iota(), iota_dimension=0
  reshape.274 = f32[1,32]{1,0} reshape(iota.268)
  broadcast.275 = f32[1,32]{1,0} broadcast(reshape.274), dimensions={0,1}
  reshape.276 = f32[32]{0} reshape(broadcast.275)
  broadcast.277 = f32[32768,32]{1,0} broadcast(reshape.276), dimensions={1}
  Arg_1.233 = f32[32768]{0} parameter(1)
  reshape.269 = f32[32768,1]{1,0} reshape(Arg_1.233)
  Arg_2.234 = f32[] parameter(2)
  broadcast.270 = f32[32768,1]{1,0} broadcast(Arg_2.234), dimensions={}
  multiply.271 = f32[32768,1]{1,0} multiply(reshape.269, broadcast.270)
  Arg_3.235 = f32[] parameter(3)
  broadcast.272 = f32[32768,1]{1,0} broadcast(Arg_3.235), dimensions={}
  divide.273 = f32[32768,1]{1,0} divide(multiply.271, broadcast.272)
  broadcast.278 = f32[32768,1]{1,0} broadcast(divide.273), dimensions={0,1}
  reshape.279 = f32[32768]{0} reshape(broadcast.278)
  broadcast.280 = f32[32768,32]{1,0} broadcast(reshape.279), dimensions={0}
  subtract.281 = f32[32768,32]{1,0} subtract(broadcast.277, broadcast.280)
  floor.282 = f32[32768,32]{1,0} floor(subtract.281)
  subtract.283 = f32[32768,32]{1,0} subtract(subtract.281, floor.282)
  constant.259 = f32[] constant(20)
  broadcast.260 = f32[32768,32]{1,0} broadcast(constant.259), dimensions={}
  divide.314 = f32[32768,32]{1,0} divide(subtract.283, broadcast.260)
  multiply.310 = f32[32768,32]{1,0} multiply(subtract.283, subtract.283)
  constant.257 = f32[] constant(24)
  broadcast.258 = f32[32768,32]{1,0} broadcast(constant.257), dimensions={}
  divide.315 = f32[32768,32]{1,0} divide(multiply.310, broadcast.258)
  subtract.316 = f32[32768,32]{1,0} subtract(divide.314, divide.315)
  multiply.311 = f32[32768,32]{1,0} multiply(multiply.310, subtract.283)
  divide.317 = f32[32768,32]{1,0} divide(multiply.311, broadcast.258)
  subtract.318 = f32[32768,32]{1,0} subtract(subtract.316, divide.317)
  multiply.312 = f32[32768,32]{1,0} multiply(multiply.311, subtract.283)
  divide.319 = f32[32768,32]{1,0} divide(multiply.312, broadcast.258)
  add.320 = f32[32768,32]{1,0} add(subtract.318, divide.319)
  multiply.313 = f32[32768,32]{1,0} multiply(multiply.312, subtract.283)
  constant.255 = f32[] constant(120)
  broadcast.256 = f32[32768,32]{1,0} broadcast(constant.255), dimensions={}
  divide.321 = f32[32768,32]{1,0} divide(multiply.313, broadcast.256)
  subtract.322 = f32[32768,32]{1,0} subtract(add.320, divide.321)
  Arg_0.232 = f32[32768,32]{1,0} parameter(0)
  reshape.302 = f32[1048576]{0} reshape(Arg_0.232)
  iota.295 = s32[32768]{0} iota(), iota_dimension=0
  reshape.296 = s32[32768,1,1]{2,1,0} reshape(iota.295)
  constant.265 = s32[] constant(32)
  broadcast.266 = s32[32768,1,1]{2,1,0} broadcast(constant.265), dimensions={}
  multiply.297 = s32[32768,1,1]{2,1,0} multiply(reshape.296, broadcast.266)
  broadcast.298 = s32[32768,1,1]{2,1,0} broadcast(multiply.297), dimensions={0,1,2}
  reshape.299 = s32[32768]{0} reshape(broadcast.298)
  broadcast.300 = s32[32768,32,6]{2,1,0} broadcast(reshape.299), dimensions={0}
  convert.284 = s32[32768,32]{1,0} convert(floor.282)
  reshape.285 = s32[32768,32,1]{2,1,0} reshape(convert.284)
  broadcast.287 = s32[32768,32,1]{2,1,0} broadcast(reshape.285), dimensions={0,1,2}
  reshape.288 = s32[32768,32]{1,0} reshape(broadcast.287)
  broadcast.289 = s32[32768,32,6]{2,1,0} broadcast(reshape.288), dimensions={0,1}
  Arg_4.236 = s32[6]{0} parameter(4)
  reshape.286 = s32[1,1,6]{2,1,0} reshape(Arg_4.236)
  broadcast.290 = s32[1,1,6]{2,1,0} broadcast(reshape.286), dimensions={0,1,2}
  reshape.291 = s32[6]{0} reshape(broadcast.290)
  broadcast.292 = s32[32768,32,6]{2,1,0} broadcast(reshape.291), dimensions={2}
  add.293 = s32[32768,32,6]{2,1,0} add(broadcast.289, broadcast.292)
  constant.267 = s32[] constant(32)
  call.294 = s32[32768,32,6]{2,1,0} call(add.293, constant.267), to_apply=remainder.211
  add.301 = s32[32768,32,6]{2,1,0} add(broadcast.300, call.294)
  reshape.303 = s32[6291456]{0} reshape(add.301)
  constant.263 = s32[] constant(0)
  broadcast.264 = s32[6291456]{0} broadcast(constant.263), dimensions={}
  compare.304 = pred[6291456]{0} compare(reshape.303, broadcast.264), direction=LT
  constant.261 = s32[] constant(1048576)
  broadcast.262 = s32[6291456]{0} broadcast(constant.261), dimensions={}
  add.305 = s32[6291456]{0} add(reshape.303, broadcast.262)
  select.306 = s32[6291456]{0} select(compare.304, add.305, reshape.303)
  reshape.307 = s32[6291456,1]{1,0} reshape(select.306)
  gather.308 = f32[6291456]{0} gather(reshape.302, reshape.307), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.309 = f32[32768,32,6]{2,1,0} reshape(gather.308)
  slice.372 = f32[32768,32,1]{2,1,0} slice(reshape.309), slice={[0:32768], [0:32], [0:1]}
  reshape.373 = f32[32768,32]{1,0} reshape(slice.372)
  multiply.374 = f32[32768,32]{1,0} multiply(subtract.322, reshape.373)
  constant.253 = f32[] constant(2)
  broadcast.254 = f32[32768,32]{1,0} broadcast(constant.253), dimensions={}
  divide.323 = f32[32768,32]{1,0} divide(subtract.283, broadcast.254)
  negate.324 = f32[32768,32]{1,0} negate(divide.323)
  multiply.325 = f32[32768,32]{1,0} multiply(multiply.310, broadcast.254)
  constant.251 = f32[] constant(3)
  broadcast.252 = f32[32768,32]{1,0} broadcast(constant.251), dimensions={}
  divide.326 = f32[32768,32]{1,0} divide(multiply.325, broadcast.252)
  add.327 = f32[32768,32]{1,0} add(negate.324, divide.326)
  divide.328 = f32[32768,32]{1,0} divide(multiply.311, broadcast.258)
  subtract.329 = f32[32768,32]{1,0} subtract(add.327, divide.328)
  constant.249 = f32[] constant(6)
  broadcast.250 = f32[32768,32]{1,0} broadcast(constant.249), dimensions={}
  divide.330 = f32[32768,32]{1,0} divide(multiply.312, broadcast.250)
  subtract.331 = f32[32768,32]{1,0} subtract(subtract.329, divide.330)
  divide.332 = f32[32768,32]{1,0} divide(multiply.313, broadcast.258)
  add.333 = f32[32768,32]{1,0} add(subtract.331, divide.332)
  slice.375 = f32[32768,32,1]{2,1,0} slice(reshape.309), slice={[0:32768], [0:32], [1:2]}
  reshape.376 = f32[32768,32]{1,0} reshape(slice.375)
  multiply.377 = f32[32768,32]{1,0} multiply(add.333, reshape.376)
  add.378 = f32[32768,32]{1,0} add(multiply.374, multiply.377)
  constant.247 = f32[] constant(1)
  broadcast.248 = f32[32768,32]{1,0} broadcast(constant.247), dimensions={}
  divide.334 = f32[32768,32]{1,0} divide(subtract.283, broadcast.252)
  subtract.335 = f32[32768,32]{1,0} subtract(broadcast.248, divide.334)
  constant.245 = f32[] constant(5)
  broadcast.246 = f32[32768,32]{1,0} broadcast(constant.245), dimensions={}
  multiply.336 = f32[32768,32]{1,0} multiply(multiply.310, broadcast.246)
  constant.243 = f32[] constant(4)
  broadcast.244 = f32[32768,32]{1,0} broadcast(constant.243), dimensions={}
  divide.337 = f32[32768,32]{1,0} divide(multiply.336, broadcast.244)
  subtract.338 = f32[32768,32]{1,0} subtract(subtract.335, divide.337)
  multiply.339 = f32[32768,32]{1,0} multiply(multiply.311, broadcast.246)
  constant.241 = f32[] constant(12)
  broadcast.242 = f32[32768,32]{1,0} broadcast(constant.241), dimensions={}
  divide.340 = f32[32768,32]{1,0} divide(multiply.339, broadcast.242)
  add.341 = f32[32768,32]{1,0} add(subtract.338, divide.340)
  divide.342 = f32[32768,32]{1,0} divide(multiply.312, broadcast.244)
  add.343 = f32[32768,32]{1,0} add(add.341, divide.342)
  divide.344 = f32[32768,32]{1,0} divide(multiply.313, broadcast.242)
  subtract.345 = f32[32768,32]{1,0} subtract(add.343, divide.344)
  slice.379 = f32[32768,32,1]{2,1,0} slice(reshape.309), slice={[0:32768], [0:32], [2:3]}
  reshape.380 = f32[32768,32]{1,0} reshape(slice.379)
  multiply.381 = f32[32768,32]{1,0} multiply(subtract.345, reshape.380)
  add.382 = f32[32768,32]{1,0} add(add.378, multiply.381)
  multiply.346 = f32[32768,32]{1,0} multiply(multiply.310, broadcast.254)
  divide.347 = f32[32768,32]{1,0} divide(multiply.346, broadcast.252)
  add.348 = f32[32768,32]{1,0} add(subtract.283, divide.347)
  constant.239 = f32[] constant(7)
  broadcast.240 = f32[32768,32]{1,0} broadcast(constant.239), dimensions={}
  multiply.349 = f32[32768,32]{1,0} multiply(multiply.311, broadcast.240)
  divide.350 = f32[32768,32]{1,0} divide(multiply.349, broadcast.242)
  subtract.351 = f32[32768,32]{1,0} subtract(add.348, divide.350)
  divide.352 = f32[32768,32]{1,0} divide(multiply.312, broadcast.250)
  subtract.353 = f32[32768,32]{1,0} subtract(subtract.351, divide.352)
  divide.354 = f32[32768,32]{1,0} divide(multiply.313, broadcast.242)
  add.355 = f32[32768,32]{1,0} add(subtract.353, divide.354)
  slice.383 = f32[32768,32,1]{2,1,0} slice(reshape.309), slice={[0:32768], [0:32], [3:4]}
  reshape.384 = f32[32768,32]{1,0} reshape(slice.383)
  multiply.385 = f32[32768,32]{1,0} multiply(add.355, reshape.384)
  add.386 = f32[32768,32]{1,0} add(add.382, multiply.385)
  divide.356 = f32[32768,32]{1,0} divide(subtract.283, broadcast.244)
  negate.357 = f32[32768,32]{1,0} negate(divide.356)
  divide.358 = f32[32768,32]{1,0} divide(multiply.310, broadcast.258)
  subtract.359 = f32[32768,32]{1,0} subtract(negate.357, divide.358)
  multiply.360 = f32[32768,32]{1,0} multiply(multiply.311, broadcast.240)
  divide.361 = f32[32768,32]{1,0} divide(multiply.360, broadcast.258)
  add.362 = f32[32768,32]{1,0} add(subtract.359, divide.361)
  divide.363 = f32[32768,32]{1,0} divide(multiply.312, broadcast.258)
  add.364 = f32[32768,32]{1,0} add(add.362, divide.363)
  divide.365 = f32[32768,32]{1,0} divide(multiply.313, broadcast.258)
  subtract.366 = f32[32768,32]{1,0} subtract(add.364, divide.365)
  slice.387 = f32[32768,32,1]{2,1,0} slice(reshape.309), slice={[0:32768], [0:32], [4:5]}
  reshape.388 = f32[32768,32]{1,0} reshape(slice.387)
  multiply.389 = f32[32768,32]{1,0} multiply(subtract.366, reshape.388)
  add.390 = f32[32768,32]{1,0} add(add.386, multiply.389)
  constant.237 = f32[] constant(30)
  broadcast.238 = f32[32768,32]{1,0} broadcast(constant.237), dimensions={}
  divide.367 = f32[32768,32]{1,0} divide(subtract.283, broadcast.238)
  divide.368 = f32[32768,32]{1,0} divide(multiply.311, broadcast.258)
  subtract.369 = f32[32768,32]{1,0} subtract(divide.367, divide.368)
  divide.370 = f32[32768,32]{1,0} divide(multiply.313, broadcast.256)
  add.371 = f32[32768,32]{1,0} add(subtract.369, divide.370)
  slice.391 = f32[32768,32,1]{2,1,0} slice(reshape.309), slice={[0:32768], [0:32], [5:6]}
  reshape.392 = f32[32768,32]{1,0} reshape(slice.391)
  multiply.393 = f32[32768,32]{1,0} multiply(add.371, reshape.392)
  ROOT add.394 = f32[32768,32]{1,0} add(add.390, multiply.393)
}

region_1.395 {
  Arg_0.396 = f32[] parameter(0)
  Arg_1.397 = f32[] parameter(1)
  ROOT add.398 = f32[] add(Arg_0.396, Arg_1.397)
}

fft.399 {
  Arg_0.400 = f32[32,32]{1,0} parameter(0)
  ROOT fft.401 = c64[32,17]{1,0} fft(Arg_0.400), fft_type=RFFT, fft_length={32,32}
}

fft_0.402 {
  Arg_0.403 = c64[32,17]{1,0} parameter(0)
  ROOT fft.404 = f32[32,32]{1,0} fft(Arg_0.403), fft_type=IRFFT, fft_length={32,32}
}

fft_0.405 {
  Arg_0.406 = c64[32,17]{1,0} parameter(0)
  ROOT fft.407 = f32[32,32]{1,0} fft(Arg_0.406), fft_type=IRFFT, fft_length={32,32}
}

fft_0.408 {
  Arg_0.409 = c64[32,17]{1,0} parameter(0)
  ROOT fft.410 = f32[32,32]{1,0} fft(Arg_0.409), fft_type=IRFFT, fft_length={32,32}
}

solve_poisson.411 {
  Arg_1.413 = f32[32,1]{1,0} parameter(1)
  convert.435 = c64[32,1]{1,0} convert(Arg_1.413)
  constant.420 = c64[] constant((-0, -1))
  broadcast.421 = c64[32,1]{1,0} broadcast(constant.420), dimensions={}
  multiply.436 = c64[32,1]{1,0} multiply(convert.435, broadcast.421)
  broadcast.437 = c64[32,1]{1,0} broadcast(multiply.436), dimensions={0,1}
  reshape.438 = c64[32]{0} reshape(broadcast.437)
  broadcast.439 = c64[32,17]{1,0} broadcast(reshape.438), dimensions={0}
  Arg_0.412 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  constant.424 = f32[] constant(0)
  reduce.425 = f32[32,32]{1,0} reduce(Arg_0.412, constant.424), dimensions={2,3}, to_apply=region_1.395
  Arg_4.416 = f32[] parameter(4)
  broadcast.426 = f32[32,32]{1,0} broadcast(Arg_4.416), dimensions={}
  multiply.427 = f32[32,32]{1,0} multiply(reduce.425, broadcast.426)
  Arg_5.417 = f32[] parameter(5)
  broadcast.428 = f32[32,32]{1,0} broadcast(Arg_5.417), dimensions={}
  multiply.429 = f32[32,32]{1,0} multiply(multiply.427, broadcast.428)
  constant.422 = f32[] constant(1)
  broadcast.423 = f32[32,32]{1,0} broadcast(constant.422), dimensions={}
  subtract.430 = f32[32,32]{1,0} subtract(multiply.429, broadcast.423)
  call.431 = c64[32,17]{1,0} call(subtract.430), to_apply=fft.399
  Arg_3.415 = f32[32,17]{1,0} parameter(3)
  convert.432 = c64[32,17]{1,0} convert(Arg_3.415)
  multiply.433 = c64[32,17]{1,0} multiply(call.431, convert.432)
  multiply.440 = c64[32,17]{1,0} multiply(broadcast.439, multiply.433)
  call.447 = f32[32,32]{1,0} call(multiply.440), to_apply=fft_0.405
  Arg_2.414 = f32[1,17]{1,0} parameter(2)
  convert.441 = c64[1,17]{1,0} convert(Arg_2.414)
  constant.418 = c64[] constant((-0, -1))
  broadcast.419 = c64[1,17]{1,0} broadcast(constant.418), dimensions={}
  multiply.442 = c64[1,17]{1,0} multiply(convert.441, broadcast.419)
  broadcast.443 = c64[1,17]{1,0} broadcast(multiply.442), dimensions={0,1}
  reshape.444 = c64[17]{0} reshape(broadcast.443)
  broadcast.445 = c64[32,17]{1,0} broadcast(reshape.444), dimensions={1}
  multiply.446 = c64[32,17]{1,0} multiply(broadcast.445, multiply.433)
  call.448 = f32[32,32]{1,0} call(multiply.446), to_apply=fft_0.408
  call.434 = f32[32,32]{1,0} call(multiply.433), to_apply=fft_0.402
  ROOT tuple.449 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(call.447, call.448, subtract.430, call.434)
}

clip.450 {
  Arg_2.453 = s32[] parameter(2)
  broadcast.456 = s32[32768,32,6]{2,1,0} broadcast(Arg_2.453), dimensions={}
  Arg_1.452 = s32[] parameter(1)
  broadcast.454 = s32[32768,32,6]{2,1,0} broadcast(Arg_1.452), dimensions={}
  Arg_0.451 = s32[32768,32,6]{2,1,0} parameter(0)
  maximum.455 = s32[32768,32,6]{2,1,0} maximum(broadcast.454, Arg_0.451)
  ROOT minimum.457 = s32[32768,32,6]{2,1,0} minimum(broadcast.456, maximum.455)
}

_where_2.458 {
  Arg_0.459 = pred[32768,32,6]{2,1,0} parameter(0)
  Arg_1.460 = f32[32768,32,6]{2,1,0} parameter(1)
  Arg_2.461 = f32[] parameter(2)
  broadcast.462 = f32[32768,32,6]{2,1,0} broadcast(Arg_2.461), dimensions={}
  ROOT select.463 = f32[32768,32,6]{2,1,0} select(Arg_0.459, Arg_1.460, broadcast.462)
}

advect_1d_vectorized_1.464 {
  iota.507 = f32[32]{0} iota(), iota_dimension=0
  reshape.513 = f32[1,32]{1,0} reshape(iota.507)
  broadcast.514 = f32[1,32]{1,0} broadcast(reshape.513), dimensions={0,1}
  reshape.515 = f32[32]{0} reshape(broadcast.514)
  broadcast.516 = f32[32768,32]{1,0} broadcast(reshape.515), dimensions={1}
  Arg_1.466 = f32[32768]{0} parameter(1)
  reshape.508 = f32[32768,1]{1,0} reshape(Arg_1.466)
  Arg_2.467 = f32[] parameter(2)
  broadcast.509 = f32[32768,1]{1,0} broadcast(Arg_2.467), dimensions={}
  multiply.510 = f32[32768,1]{1,0} multiply(reshape.508, broadcast.509)
  Arg_3.468 = f32[] parameter(3)
  broadcast.511 = f32[32768,1]{1,0} broadcast(Arg_3.468), dimensions={}
  divide.512 = f32[32768,1]{1,0} divide(multiply.510, broadcast.511)
  broadcast.517 = f32[32768,1]{1,0} broadcast(divide.512), dimensions={0,1}
  reshape.518 = f32[32768]{0} reshape(broadcast.517)
  broadcast.519 = f32[32768,32]{1,0} broadcast(reshape.518), dimensions={0}
  subtract.520 = f32[32768,32]{1,0} subtract(broadcast.516, broadcast.519)
  floor.521 = f32[32768,32]{1,0} floor(subtract.520)
  subtract.522 = f32[32768,32]{1,0} subtract(subtract.520, floor.521)
  constant.492 = f32[] constant(20)
  broadcast.493 = f32[32768,32]{1,0} broadcast(constant.492), dimensions={}
  divide.557 = f32[32768,32]{1,0} divide(subtract.522, broadcast.493)
  multiply.553 = f32[32768,32]{1,0} multiply(subtract.522, subtract.522)
  constant.490 = f32[] constant(24)
  broadcast.491 = f32[32768,32]{1,0} broadcast(constant.490), dimensions={}
  divide.558 = f32[32768,32]{1,0} divide(multiply.553, broadcast.491)
  subtract.559 = f32[32768,32]{1,0} subtract(divide.557, divide.558)
  multiply.554 = f32[32768,32]{1,0} multiply(multiply.553, subtract.522)
  divide.560 = f32[32768,32]{1,0} divide(multiply.554, broadcast.491)
  subtract.561 = f32[32768,32]{1,0} subtract(subtract.559, divide.560)
  multiply.555 = f32[32768,32]{1,0} multiply(multiply.554, subtract.522)
  divide.562 = f32[32768,32]{1,0} divide(multiply.555, broadcast.491)
  add.563 = f32[32768,32]{1,0} add(subtract.561, divide.562)
  multiply.556 = f32[32768,32]{1,0} multiply(multiply.555, subtract.522)
  constant.488 = f32[] constant(120)
  broadcast.489 = f32[32768,32]{1,0} broadcast(constant.488), dimensions={}
  divide.564 = f32[32768,32]{1,0} divide(multiply.556, broadcast.489)
  subtract.565 = f32[32768,32]{1,0} subtract(add.563, divide.564)
  convert.523 = s32[32768,32]{1,0} convert(floor.521)
  reshape.524 = s32[32768,32,1]{2,1,0} reshape(convert.523)
  broadcast.526 = s32[32768,32,1]{2,1,0} broadcast(reshape.524), dimensions={0,1,2}
  reshape.527 = s32[32768,32]{1,0} reshape(broadcast.526)
  broadcast.528 = s32[32768,32,6]{2,1,0} broadcast(reshape.527), dimensions={0,1}
  Arg_4.469 = s32[6]{0} parameter(4)
  reshape.525 = s32[1,1,6]{2,1,0} reshape(Arg_4.469)
  broadcast.529 = s32[1,1,6]{2,1,0} broadcast(reshape.525), dimensions={0,1,2}
  reshape.530 = s32[6]{0} reshape(broadcast.529)
  broadcast.531 = s32[32768,32,6]{2,1,0} broadcast(reshape.530), dimensions={2}
  add.532 = s32[32768,32,6]{2,1,0} add(broadcast.528, broadcast.531)
  constant.502 = s32[] constant(0)
  broadcast.503 = s32[32768,32,6]{2,1,0} broadcast(constant.502), dimensions={}
  compare.533 = pred[32768,32,6]{2,1,0} compare(add.532, broadcast.503), direction=GE
  constant.500 = s32[] constant(32)
  broadcast.501 = s32[32768,32,6]{2,1,0} broadcast(constant.500), dimensions={}
  compare.534 = pred[32768,32,6]{2,1,0} compare(add.532, broadcast.501), direction=LT
  and.535 = pred[32768,32,6]{2,1,0} and(compare.533, compare.534)
  Arg_0.465 = f32[32768,32]{1,0} parameter(0)
  reshape.544 = f32[1048576]{0} reshape(Arg_0.465)
  iota.537 = s32[32768]{0} iota(), iota_dimension=0
  reshape.538 = s32[32768,1,1]{2,1,0} reshape(iota.537)
  constant.498 = s32[] constant(32)
  broadcast.499 = s32[32768,1,1]{2,1,0} broadcast(constant.498), dimensions={}
  multiply.539 = s32[32768,1,1]{2,1,0} multiply(reshape.538, broadcast.499)
  broadcast.540 = s32[32768,1,1]{2,1,0} broadcast(multiply.539), dimensions={0,1,2}
  reshape.541 = s32[32768]{0} reshape(broadcast.540)
  broadcast.542 = s32[32768,32,6]{2,1,0} broadcast(reshape.541), dimensions={0}
  constant.506 = s32[] constant(0)
  constant.505 = s32[] constant(31)
  call.536 = s32[32768,32,6]{2,1,0} call(add.532, constant.506, constant.505), to_apply=clip.450
  add.543 = s32[32768,32,6]{2,1,0} add(broadcast.542, call.536)
  reshape.545 = s32[6291456]{0} reshape(add.543)
  constant.496 = s32[] constant(0)
  broadcast.497 = s32[6291456]{0} broadcast(constant.496), dimensions={}
  compare.546 = pred[6291456]{0} compare(reshape.545, broadcast.497), direction=LT
  constant.494 = s32[] constant(1048576)
  broadcast.495 = s32[6291456]{0} broadcast(constant.494), dimensions={}
  add.547 = s32[6291456]{0} add(reshape.545, broadcast.495)
  select.548 = s32[6291456]{0} select(compare.546, add.547, reshape.545)
  reshape.549 = s32[6291456,1]{1,0} reshape(select.548)
  gather.550 = f32[6291456]{0} gather(reshape.544, reshape.549), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.551 = f32[32768,32,6]{2,1,0} reshape(gather.550)
  constant.504 = f32[] constant(0)
  call.552 = f32[32768,32,6]{2,1,0} call(and.535, reshape.551, constant.504), to_apply=_where_2.458
  slice.615 = f32[32768,32,1]{2,1,0} slice(call.552), slice={[0:32768], [0:32], [0:1]}
  reshape.616 = f32[32768,32]{1,0} reshape(slice.615)
  multiply.617 = f32[32768,32]{1,0} multiply(subtract.565, reshape.616)
  constant.486 = f32[] constant(2)
  broadcast.487 = f32[32768,32]{1,0} broadcast(constant.486), dimensions={}
  divide.566 = f32[32768,32]{1,0} divide(subtract.522, broadcast.487)
  negate.567 = f32[32768,32]{1,0} negate(divide.566)
  multiply.568 = f32[32768,32]{1,0} multiply(multiply.553, broadcast.487)
  constant.484 = f32[] constant(3)
  broadcast.485 = f32[32768,32]{1,0} broadcast(constant.484), dimensions={}
  divide.569 = f32[32768,32]{1,0} divide(multiply.568, broadcast.485)
  add.570 = f32[32768,32]{1,0} add(negate.567, divide.569)
  divide.571 = f32[32768,32]{1,0} divide(multiply.554, broadcast.491)
  subtract.572 = f32[32768,32]{1,0} subtract(add.570, divide.571)
  constant.482 = f32[] constant(6)
  broadcast.483 = f32[32768,32]{1,0} broadcast(constant.482), dimensions={}
  divide.573 = f32[32768,32]{1,0} divide(multiply.555, broadcast.483)
  subtract.574 = f32[32768,32]{1,0} subtract(subtract.572, divide.573)
  divide.575 = f32[32768,32]{1,0} divide(multiply.556, broadcast.491)
  add.576 = f32[32768,32]{1,0} add(subtract.574, divide.575)
  slice.618 = f32[32768,32,1]{2,1,0} slice(call.552), slice={[0:32768], [0:32], [1:2]}
  reshape.619 = f32[32768,32]{1,0} reshape(slice.618)
  multiply.620 = f32[32768,32]{1,0} multiply(add.576, reshape.619)
  add.621 = f32[32768,32]{1,0} add(multiply.617, multiply.620)
  constant.480 = f32[] constant(1)
  broadcast.481 = f32[32768,32]{1,0} broadcast(constant.480), dimensions={}
  divide.577 = f32[32768,32]{1,0} divide(subtract.522, broadcast.485)
  subtract.578 = f32[32768,32]{1,0} subtract(broadcast.481, divide.577)
  constant.478 = f32[] constant(5)
  broadcast.479 = f32[32768,32]{1,0} broadcast(constant.478), dimensions={}
  multiply.579 = f32[32768,32]{1,0} multiply(multiply.553, broadcast.479)
  constant.476 = f32[] constant(4)
  broadcast.477 = f32[32768,32]{1,0} broadcast(constant.476), dimensions={}
  divide.580 = f32[32768,32]{1,0} divide(multiply.579, broadcast.477)
  subtract.581 = f32[32768,32]{1,0} subtract(subtract.578, divide.580)
  multiply.582 = f32[32768,32]{1,0} multiply(multiply.554, broadcast.479)
  constant.474 = f32[] constant(12)
  broadcast.475 = f32[32768,32]{1,0} broadcast(constant.474), dimensions={}
  divide.583 = f32[32768,32]{1,0} divide(multiply.582, broadcast.475)
  add.584 = f32[32768,32]{1,0} add(subtract.581, divide.583)
  divide.585 = f32[32768,32]{1,0} divide(multiply.555, broadcast.477)
  add.586 = f32[32768,32]{1,0} add(add.584, divide.585)
  divide.587 = f32[32768,32]{1,0} divide(multiply.556, broadcast.475)
  subtract.588 = f32[32768,32]{1,0} subtract(add.586, divide.587)
  slice.622 = f32[32768,32,1]{2,1,0} slice(call.552), slice={[0:32768], [0:32], [2:3]}
  reshape.623 = f32[32768,32]{1,0} reshape(slice.622)
  multiply.624 = f32[32768,32]{1,0} multiply(subtract.588, reshape.623)
  add.625 = f32[32768,32]{1,0} add(add.621, multiply.624)
  multiply.589 = f32[32768,32]{1,0} multiply(multiply.553, broadcast.487)
  divide.590 = f32[32768,32]{1,0} divide(multiply.589, broadcast.485)
  add.591 = f32[32768,32]{1,0} add(subtract.522, divide.590)
  constant.472 = f32[] constant(7)
  broadcast.473 = f32[32768,32]{1,0} broadcast(constant.472), dimensions={}
  multiply.592 = f32[32768,32]{1,0} multiply(multiply.554, broadcast.473)
  divide.593 = f32[32768,32]{1,0} divide(multiply.592, broadcast.475)
  subtract.594 = f32[32768,32]{1,0} subtract(add.591, divide.593)
  divide.595 = f32[32768,32]{1,0} divide(multiply.555, broadcast.483)
  subtract.596 = f32[32768,32]{1,0} subtract(subtract.594, divide.595)
  divide.597 = f32[32768,32]{1,0} divide(multiply.556, broadcast.475)
  add.598 = f32[32768,32]{1,0} add(subtract.596, divide.597)
  slice.626 = f32[32768,32,1]{2,1,0} slice(call.552), slice={[0:32768], [0:32], [3:4]}
  reshape.627 = f32[32768,32]{1,0} reshape(slice.626)
  multiply.628 = f32[32768,32]{1,0} multiply(add.598, reshape.627)
  add.629 = f32[32768,32]{1,0} add(add.625, multiply.628)
  divide.599 = f32[32768,32]{1,0} divide(subtract.522, broadcast.477)
  negate.600 = f32[32768,32]{1,0} negate(divide.599)
  divide.601 = f32[32768,32]{1,0} divide(multiply.553, broadcast.491)
  subtract.602 = f32[32768,32]{1,0} subtract(negate.600, divide.601)
  multiply.603 = f32[32768,32]{1,0} multiply(multiply.554, broadcast.473)
  divide.604 = f32[32768,32]{1,0} divide(multiply.603, broadcast.491)
  add.605 = f32[32768,32]{1,0} add(subtract.602, divide.604)
  divide.606 = f32[32768,32]{1,0} divide(multiply.555, broadcast.491)
  add.607 = f32[32768,32]{1,0} add(add.605, divide.606)
  divide.608 = f32[32768,32]{1,0} divide(multiply.556, broadcast.491)
  subtract.609 = f32[32768,32]{1,0} subtract(add.607, divide.608)
  slice.630 = f32[32768,32,1]{2,1,0} slice(call.552), slice={[0:32768], [0:32], [4:5]}
  reshape.631 = f32[32768,32]{1,0} reshape(slice.630)
  multiply.632 = f32[32768,32]{1,0} multiply(subtract.609, reshape.631)
  add.633 = f32[32768,32]{1,0} add(add.629, multiply.632)
  constant.470 = f32[] constant(30)
  broadcast.471 = f32[32768,32]{1,0} broadcast(constant.470), dimensions={}
  divide.610 = f32[32768,32]{1,0} divide(subtract.522, broadcast.471)
  divide.611 = f32[32768,32]{1,0} divide(multiply.554, broadcast.491)
  subtract.612 = f32[32768,32]{1,0} subtract(divide.610, divide.611)
  divide.613 = f32[32768,32]{1,0} divide(multiply.556, broadcast.489)
  add.614 = f32[32768,32]{1,0} add(subtract.612, divide.613)
  slice.634 = f32[32768,32,1]{2,1,0} slice(call.552), slice={[0:32768], [0:32], [5:6]}
  reshape.635 = f32[32768,32]{1,0} reshape(slice.634)
  multiply.636 = f32[32768,32]{1,0} multiply(add.614, reshape.635)
  ROOT add.637 = f32[32768,32]{1,0} add(add.633, multiply.636)
}

clip.638 {
  Arg_2.641 = s32[] parameter(2)
  broadcast.644 = s32[32768,32,6]{2,1,0} broadcast(Arg_2.641), dimensions={}
  Arg_1.640 = s32[] parameter(1)
  broadcast.642 = s32[32768,32,6]{2,1,0} broadcast(Arg_1.640), dimensions={}
  Arg_0.639 = s32[32768,32,6]{2,1,0} parameter(0)
  maximum.643 = s32[32768,32,6]{2,1,0} maximum(broadcast.642, Arg_0.639)
  ROOT minimum.645 = s32[32768,32,6]{2,1,0} minimum(broadcast.644, maximum.643)
}

_where_2.646 {
  Arg_0.647 = pred[32768,32,6]{2,1,0} parameter(0)
  Arg_1.648 = f32[32768,32,6]{2,1,0} parameter(1)
  Arg_2.649 = f32[] parameter(2)
  broadcast.650 = f32[32768,32,6]{2,1,0} broadcast(Arg_2.649), dimensions={}
  ROOT select.651 = f32[32768,32,6]{2,1,0} select(Arg_0.647, Arg_1.648, broadcast.650)
}

advect_1d_vectorized_1.652 {
  iota.695 = f32[32]{0} iota(), iota_dimension=0
  reshape.701 = f32[1,32]{1,0} reshape(iota.695)
  broadcast.702 = f32[1,32]{1,0} broadcast(reshape.701), dimensions={0,1}
  reshape.703 = f32[32]{0} reshape(broadcast.702)
  broadcast.704 = f32[32768,32]{1,0} broadcast(reshape.703), dimensions={1}
  Arg_1.654 = f32[32768]{0} parameter(1)
  reshape.696 = f32[32768,1]{1,0} reshape(Arg_1.654)
  Arg_2.655 = f32[] parameter(2)
  broadcast.697 = f32[32768,1]{1,0} broadcast(Arg_2.655), dimensions={}
  multiply.698 = f32[32768,1]{1,0} multiply(reshape.696, broadcast.697)
  Arg_3.656 = f32[] parameter(3)
  broadcast.699 = f32[32768,1]{1,0} broadcast(Arg_3.656), dimensions={}
  divide.700 = f32[32768,1]{1,0} divide(multiply.698, broadcast.699)
  broadcast.705 = f32[32768,1]{1,0} broadcast(divide.700), dimensions={0,1}
  reshape.706 = f32[32768]{0} reshape(broadcast.705)
  broadcast.707 = f32[32768,32]{1,0} broadcast(reshape.706), dimensions={0}
  subtract.708 = f32[32768,32]{1,0} subtract(broadcast.704, broadcast.707)
  floor.709 = f32[32768,32]{1,0} floor(subtract.708)
  subtract.710 = f32[32768,32]{1,0} subtract(subtract.708, floor.709)
  constant.680 = f32[] constant(20)
  broadcast.681 = f32[32768,32]{1,0} broadcast(constant.680), dimensions={}
  divide.745 = f32[32768,32]{1,0} divide(subtract.710, broadcast.681)
  multiply.741 = f32[32768,32]{1,0} multiply(subtract.710, subtract.710)
  constant.678 = f32[] constant(24)
  broadcast.679 = f32[32768,32]{1,0} broadcast(constant.678), dimensions={}
  divide.746 = f32[32768,32]{1,0} divide(multiply.741, broadcast.679)
  subtract.747 = f32[32768,32]{1,0} subtract(divide.745, divide.746)
  multiply.742 = f32[32768,32]{1,0} multiply(multiply.741, subtract.710)
  divide.748 = f32[32768,32]{1,0} divide(multiply.742, broadcast.679)
  subtract.749 = f32[32768,32]{1,0} subtract(subtract.747, divide.748)
  multiply.743 = f32[32768,32]{1,0} multiply(multiply.742, subtract.710)
  divide.750 = f32[32768,32]{1,0} divide(multiply.743, broadcast.679)
  add.751 = f32[32768,32]{1,0} add(subtract.749, divide.750)
  multiply.744 = f32[32768,32]{1,0} multiply(multiply.743, subtract.710)
  constant.676 = f32[] constant(120)
  broadcast.677 = f32[32768,32]{1,0} broadcast(constant.676), dimensions={}
  divide.752 = f32[32768,32]{1,0} divide(multiply.744, broadcast.677)
  subtract.753 = f32[32768,32]{1,0} subtract(add.751, divide.752)
  convert.711 = s32[32768,32]{1,0} convert(floor.709)
  reshape.712 = s32[32768,32,1]{2,1,0} reshape(convert.711)
  broadcast.714 = s32[32768,32,1]{2,1,0} broadcast(reshape.712), dimensions={0,1,2}
  reshape.715 = s32[32768,32]{1,0} reshape(broadcast.714)
  broadcast.716 = s32[32768,32,6]{2,1,0} broadcast(reshape.715), dimensions={0,1}
  Arg_4.657 = s32[6]{0} parameter(4)
  reshape.713 = s32[1,1,6]{2,1,0} reshape(Arg_4.657)
  broadcast.717 = s32[1,1,6]{2,1,0} broadcast(reshape.713), dimensions={0,1,2}
  reshape.718 = s32[6]{0} reshape(broadcast.717)
  broadcast.719 = s32[32768,32,6]{2,1,0} broadcast(reshape.718), dimensions={2}
  add.720 = s32[32768,32,6]{2,1,0} add(broadcast.716, broadcast.719)
  constant.690 = s32[] constant(0)
  broadcast.691 = s32[32768,32,6]{2,1,0} broadcast(constant.690), dimensions={}
  compare.721 = pred[32768,32,6]{2,1,0} compare(add.720, broadcast.691), direction=GE
  constant.688 = s32[] constant(32)
  broadcast.689 = s32[32768,32,6]{2,1,0} broadcast(constant.688), dimensions={}
  compare.722 = pred[32768,32,6]{2,1,0} compare(add.720, broadcast.689), direction=LT
  and.723 = pred[32768,32,6]{2,1,0} and(compare.721, compare.722)
  Arg_0.653 = f32[32768,32]{1,0} parameter(0)
  reshape.732 = f32[1048576]{0} reshape(Arg_0.653)
  iota.725 = s32[32768]{0} iota(), iota_dimension=0
  reshape.726 = s32[32768,1,1]{2,1,0} reshape(iota.725)
  constant.686 = s32[] constant(32)
  broadcast.687 = s32[32768,1,1]{2,1,0} broadcast(constant.686), dimensions={}
  multiply.727 = s32[32768,1,1]{2,1,0} multiply(reshape.726, broadcast.687)
  broadcast.728 = s32[32768,1,1]{2,1,0} broadcast(multiply.727), dimensions={0,1,2}
  reshape.729 = s32[32768]{0} reshape(broadcast.728)
  broadcast.730 = s32[32768,32,6]{2,1,0} broadcast(reshape.729), dimensions={0}
  constant.694 = s32[] constant(0)
  constant.693 = s32[] constant(31)
  call.724 = s32[32768,32,6]{2,1,0} call(add.720, constant.694, constant.693), to_apply=clip.638
  add.731 = s32[32768,32,6]{2,1,0} add(broadcast.730, call.724)
  reshape.733 = s32[6291456]{0} reshape(add.731)
  constant.684 = s32[] constant(0)
  broadcast.685 = s32[6291456]{0} broadcast(constant.684), dimensions={}
  compare.734 = pred[6291456]{0} compare(reshape.733, broadcast.685), direction=LT
  constant.682 = s32[] constant(1048576)
  broadcast.683 = s32[6291456]{0} broadcast(constant.682), dimensions={}
  add.735 = s32[6291456]{0} add(reshape.733, broadcast.683)
  select.736 = s32[6291456]{0} select(compare.734, add.735, reshape.733)
  reshape.737 = s32[6291456,1]{1,0} reshape(select.736)
  gather.738 = f32[6291456]{0} gather(reshape.732, reshape.737), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.739 = f32[32768,32,6]{2,1,0} reshape(gather.738)
  constant.692 = f32[] constant(0)
  call.740 = f32[32768,32,6]{2,1,0} call(and.723, reshape.739, constant.692), to_apply=_where_2.646
  slice.803 = f32[32768,32,1]{2,1,0} slice(call.740), slice={[0:32768], [0:32], [0:1]}
  reshape.804 = f32[32768,32]{1,0} reshape(slice.803)
  multiply.805 = f32[32768,32]{1,0} multiply(subtract.753, reshape.804)
  constant.674 = f32[] constant(2)
  broadcast.675 = f32[32768,32]{1,0} broadcast(constant.674), dimensions={}
  divide.754 = f32[32768,32]{1,0} divide(subtract.710, broadcast.675)
  negate.755 = f32[32768,32]{1,0} negate(divide.754)
  multiply.756 = f32[32768,32]{1,0} multiply(multiply.741, broadcast.675)
  constant.672 = f32[] constant(3)
  broadcast.673 = f32[32768,32]{1,0} broadcast(constant.672), dimensions={}
  divide.757 = f32[32768,32]{1,0} divide(multiply.756, broadcast.673)
  add.758 = f32[32768,32]{1,0} add(negate.755, divide.757)
  divide.759 = f32[32768,32]{1,0} divide(multiply.742, broadcast.679)
  subtract.760 = f32[32768,32]{1,0} subtract(add.758, divide.759)
  constant.670 = f32[] constant(6)
  broadcast.671 = f32[32768,32]{1,0} broadcast(constant.670), dimensions={}
  divide.761 = f32[32768,32]{1,0} divide(multiply.743, broadcast.671)
  subtract.762 = f32[32768,32]{1,0} subtract(subtract.760, divide.761)
  divide.763 = f32[32768,32]{1,0} divide(multiply.744, broadcast.679)
  add.764 = f32[32768,32]{1,0} add(subtract.762, divide.763)
  slice.806 = f32[32768,32,1]{2,1,0} slice(call.740), slice={[0:32768], [0:32], [1:2]}
  reshape.807 = f32[32768,32]{1,0} reshape(slice.806)
  multiply.808 = f32[32768,32]{1,0} multiply(add.764, reshape.807)
  add.809 = f32[32768,32]{1,0} add(multiply.805, multiply.808)
  constant.668 = f32[] constant(1)
  broadcast.669 = f32[32768,32]{1,0} broadcast(constant.668), dimensions={}
  divide.765 = f32[32768,32]{1,0} divide(subtract.710, broadcast.673)
  subtract.766 = f32[32768,32]{1,0} subtract(broadcast.669, divide.765)
  constant.666 = f32[] constant(5)
  broadcast.667 = f32[32768,32]{1,0} broadcast(constant.666), dimensions={}
  multiply.767 = f32[32768,32]{1,0} multiply(multiply.741, broadcast.667)
  constant.664 = f32[] constant(4)
  broadcast.665 = f32[32768,32]{1,0} broadcast(constant.664), dimensions={}
  divide.768 = f32[32768,32]{1,0} divide(multiply.767, broadcast.665)
  subtract.769 = f32[32768,32]{1,0} subtract(subtract.766, divide.768)
  multiply.770 = f32[32768,32]{1,0} multiply(multiply.742, broadcast.667)
  constant.662 = f32[] constant(12)
  broadcast.663 = f32[32768,32]{1,0} broadcast(constant.662), dimensions={}
  divide.771 = f32[32768,32]{1,0} divide(multiply.770, broadcast.663)
  add.772 = f32[32768,32]{1,0} add(subtract.769, divide.771)
  divide.773 = f32[32768,32]{1,0} divide(multiply.743, broadcast.665)
  add.774 = f32[32768,32]{1,0} add(add.772, divide.773)
  divide.775 = f32[32768,32]{1,0} divide(multiply.744, broadcast.663)
  subtract.776 = f32[32768,32]{1,0} subtract(add.774, divide.775)
  slice.810 = f32[32768,32,1]{2,1,0} slice(call.740), slice={[0:32768], [0:32], [2:3]}
  reshape.811 = f32[32768,32]{1,0} reshape(slice.810)
  multiply.812 = f32[32768,32]{1,0} multiply(subtract.776, reshape.811)
  add.813 = f32[32768,32]{1,0} add(add.809, multiply.812)
  multiply.777 = f32[32768,32]{1,0} multiply(multiply.741, broadcast.675)
  divide.778 = f32[32768,32]{1,0} divide(multiply.777, broadcast.673)
  add.779 = f32[32768,32]{1,0} add(subtract.710, divide.778)
  constant.660 = f32[] constant(7)
  broadcast.661 = f32[32768,32]{1,0} broadcast(constant.660), dimensions={}
  multiply.780 = f32[32768,32]{1,0} multiply(multiply.742, broadcast.661)
  divide.781 = f32[32768,32]{1,0} divide(multiply.780, broadcast.663)
  subtract.782 = f32[32768,32]{1,0} subtract(add.779, divide.781)
  divide.783 = f32[32768,32]{1,0} divide(multiply.743, broadcast.671)
  subtract.784 = f32[32768,32]{1,0} subtract(subtract.782, divide.783)
  divide.785 = f32[32768,32]{1,0} divide(multiply.744, broadcast.663)
  add.786 = f32[32768,32]{1,0} add(subtract.784, divide.785)
  slice.814 = f32[32768,32,1]{2,1,0} slice(call.740), slice={[0:32768], [0:32], [3:4]}
  reshape.815 = f32[32768,32]{1,0} reshape(slice.814)
  multiply.816 = f32[32768,32]{1,0} multiply(add.786, reshape.815)
  add.817 = f32[32768,32]{1,0} add(add.813, multiply.816)
  divide.787 = f32[32768,32]{1,0} divide(subtract.710, broadcast.665)
  negate.788 = f32[32768,32]{1,0} negate(divide.787)
  divide.789 = f32[32768,32]{1,0} divide(multiply.741, broadcast.679)
  subtract.790 = f32[32768,32]{1,0} subtract(negate.788, divide.789)
  multiply.791 = f32[32768,32]{1,0} multiply(multiply.742, broadcast.661)
  divide.792 = f32[32768,32]{1,0} divide(multiply.791, broadcast.679)
  add.793 = f32[32768,32]{1,0} add(subtract.790, divide.792)
  divide.794 = f32[32768,32]{1,0} divide(multiply.743, broadcast.679)
  add.795 = f32[32768,32]{1,0} add(add.793, divide.794)
  divide.796 = f32[32768,32]{1,0} divide(multiply.744, broadcast.679)
  subtract.797 = f32[32768,32]{1,0} subtract(add.795, divide.796)
  slice.818 = f32[32768,32,1]{2,1,0} slice(call.740), slice={[0:32768], [0:32], [4:5]}
  reshape.819 = f32[32768,32]{1,0} reshape(slice.818)
  multiply.820 = f32[32768,32]{1,0} multiply(subtract.797, reshape.819)
  add.821 = f32[32768,32]{1,0} add(add.817, multiply.820)
  constant.658 = f32[] constant(30)
  broadcast.659 = f32[32768,32]{1,0} broadcast(constant.658), dimensions={}
  divide.798 = f32[32768,32]{1,0} divide(subtract.710, broadcast.659)
  divide.799 = f32[32768,32]{1,0} divide(multiply.742, broadcast.679)
  subtract.800 = f32[32768,32]{1,0} subtract(divide.798, divide.799)
  divide.801 = f32[32768,32]{1,0} divide(multiply.744, broadcast.677)
  add.802 = f32[32768,32]{1,0} add(subtract.800, divide.801)
  slice.822 = f32[32768,32,1]{2,1,0} slice(call.740), slice={[0:32768], [0:32], [5:6]}
  reshape.823 = f32[32768,32]{1,0} reshape(slice.822)
  multiply.824 = f32[32768,32]{1,0} multiply(add.802, reshape.823)
  ROOT add.825 = f32[32768,32]{1,0} add(add.821, multiply.824)
}

_where.826 {
  Arg_0.827 = pred[] parameter(0)
  Arg_1.828 = s32[] parameter(1)
  Arg_2.829 = s32[] parameter(2)
  ROOT select.830 = s32[] select(Arg_0.827, Arg_1.828, Arg_2.829)
}

remainder.831 {
  Arg_0.832 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.833 = s32[] parameter(1)
  constant.837 = s32[] constant(0)
  compare.838 = pred[] compare(Arg_1.833, constant.837), direction=EQ
  constant.836 = s32[] constant(1)
  call.839 = s32[] call(compare.838, constant.836, Arg_1.833), to_apply=_where.826
  broadcast.840 = s32[32768,32,6]{2,1,0} broadcast(call.839), dimensions={}
  remainder.841 = s32[32768,32,6]{2,1,0} remainder(Arg_0.832, broadcast.840)
  constant.834 = s32[] constant(0)
  broadcast.835 = s32[32768,32,6]{2,1,0} broadcast(constant.834), dimensions={}
  compare.843 = pred[32768,32,6]{2,1,0} compare(remainder.841, broadcast.835), direction=LT
  compare.844 = pred[] compare(call.839, constant.837), direction=LT
  broadcast.845 = pred[32768,32,6]{2,1,0} broadcast(compare.844), dimensions={}
  compare.846 = pred[32768,32,6]{2,1,0} compare(compare.843, broadcast.845), direction=NE
  compare.842 = pred[32768,32,6]{2,1,0} compare(remainder.841, broadcast.835), direction=NE
  and.847 = pred[32768,32,6]{2,1,0} and(compare.846, compare.842)
  broadcast.848 = s32[32768,32,6]{2,1,0} broadcast(call.839), dimensions={}
  add.849 = s32[32768,32,6]{2,1,0} add(remainder.841, broadcast.848)
  ROOT select.850 = s32[32768,32,6]{2,1,0} select(and.847, add.849, remainder.841)
}

advect_1d_vectorized.851 {
  iota.888 = f32[32]{0} iota(), iota_dimension=0
  reshape.894 = f32[1,32]{1,0} reshape(iota.888)
  broadcast.895 = f32[1,32]{1,0} broadcast(reshape.894), dimensions={0,1}
  reshape.896 = f32[32]{0} reshape(broadcast.895)
  broadcast.897 = f32[32768,32]{1,0} broadcast(reshape.896), dimensions={1}
  Arg_1.853 = f32[32768]{0} parameter(1)
  reshape.889 = f32[32768,1]{1,0} reshape(Arg_1.853)
  Arg_2.854 = f32[] parameter(2)
  broadcast.890 = f32[32768,1]{1,0} broadcast(Arg_2.854), dimensions={}
  multiply.891 = f32[32768,1]{1,0} multiply(reshape.889, broadcast.890)
  Arg_3.855 = f32[] parameter(3)
  broadcast.892 = f32[32768,1]{1,0} broadcast(Arg_3.855), dimensions={}
  divide.893 = f32[32768,1]{1,0} divide(multiply.891, broadcast.892)
  broadcast.898 = f32[32768,1]{1,0} broadcast(divide.893), dimensions={0,1}
  reshape.899 = f32[32768]{0} reshape(broadcast.898)
  broadcast.900 = f32[32768,32]{1,0} broadcast(reshape.899), dimensions={0}
  subtract.901 = f32[32768,32]{1,0} subtract(broadcast.897, broadcast.900)
  floor.902 = f32[32768,32]{1,0} floor(subtract.901)
  subtract.903 = f32[32768,32]{1,0} subtract(subtract.901, floor.902)
  constant.879 = f32[] constant(20)
  broadcast.880 = f32[32768,32]{1,0} broadcast(constant.879), dimensions={}
  divide.934 = f32[32768,32]{1,0} divide(subtract.903, broadcast.880)
  multiply.930 = f32[32768,32]{1,0} multiply(subtract.903, subtract.903)
  constant.877 = f32[] constant(24)
  broadcast.878 = f32[32768,32]{1,0} broadcast(constant.877), dimensions={}
  divide.935 = f32[32768,32]{1,0} divide(multiply.930, broadcast.878)
  subtract.936 = f32[32768,32]{1,0} subtract(divide.934, divide.935)
  multiply.931 = f32[32768,32]{1,0} multiply(multiply.930, subtract.903)
  divide.937 = f32[32768,32]{1,0} divide(multiply.931, broadcast.878)
  subtract.938 = f32[32768,32]{1,0} subtract(subtract.936, divide.937)
  multiply.932 = f32[32768,32]{1,0} multiply(multiply.931, subtract.903)
  divide.939 = f32[32768,32]{1,0} divide(multiply.932, broadcast.878)
  add.940 = f32[32768,32]{1,0} add(subtract.938, divide.939)
  multiply.933 = f32[32768,32]{1,0} multiply(multiply.932, subtract.903)
  constant.875 = f32[] constant(120)
  broadcast.876 = f32[32768,32]{1,0} broadcast(constant.875), dimensions={}
  divide.941 = f32[32768,32]{1,0} divide(multiply.933, broadcast.876)
  subtract.942 = f32[32768,32]{1,0} subtract(add.940, divide.941)
  Arg_0.852 = f32[32768,32]{1,0} parameter(0)
  reshape.922 = f32[1048576]{0} reshape(Arg_0.852)
  iota.915 = s32[32768]{0} iota(), iota_dimension=0
  reshape.916 = s32[32768,1,1]{2,1,0} reshape(iota.915)
  constant.885 = s32[] constant(32)
  broadcast.886 = s32[32768,1,1]{2,1,0} broadcast(constant.885), dimensions={}
  multiply.917 = s32[32768,1,1]{2,1,0} multiply(reshape.916, broadcast.886)
  broadcast.918 = s32[32768,1,1]{2,1,0} broadcast(multiply.917), dimensions={0,1,2}
  reshape.919 = s32[32768]{0} reshape(broadcast.918)
  broadcast.920 = s32[32768,32,6]{2,1,0} broadcast(reshape.919), dimensions={0}
  convert.904 = s32[32768,32]{1,0} convert(floor.902)
  reshape.905 = s32[32768,32,1]{2,1,0} reshape(convert.904)
  broadcast.907 = s32[32768,32,1]{2,1,0} broadcast(reshape.905), dimensions={0,1,2}
  reshape.908 = s32[32768,32]{1,0} reshape(broadcast.907)
  broadcast.909 = s32[32768,32,6]{2,1,0} broadcast(reshape.908), dimensions={0,1}
  Arg_4.856 = s32[6]{0} parameter(4)
  reshape.906 = s32[1,1,6]{2,1,0} reshape(Arg_4.856)
  broadcast.910 = s32[1,1,6]{2,1,0} broadcast(reshape.906), dimensions={0,1,2}
  reshape.911 = s32[6]{0} reshape(broadcast.910)
  broadcast.912 = s32[32768,32,6]{2,1,0} broadcast(reshape.911), dimensions={2}
  add.913 = s32[32768,32,6]{2,1,0} add(broadcast.909, broadcast.912)
  constant.887 = s32[] constant(32)
  call.914 = s32[32768,32,6]{2,1,0} call(add.913, constant.887), to_apply=remainder.831
  add.921 = s32[32768,32,6]{2,1,0} add(broadcast.920, call.914)
  reshape.923 = s32[6291456]{0} reshape(add.921)
  constant.883 = s32[] constant(0)
  broadcast.884 = s32[6291456]{0} broadcast(constant.883), dimensions={}
  compare.924 = pred[6291456]{0} compare(reshape.923, broadcast.884), direction=LT
  constant.881 = s32[] constant(1048576)
  broadcast.882 = s32[6291456]{0} broadcast(constant.881), dimensions={}
  add.925 = s32[6291456]{0} add(reshape.923, broadcast.882)
  select.926 = s32[6291456]{0} select(compare.924, add.925, reshape.923)
  reshape.927 = s32[6291456,1]{1,0} reshape(select.926)
  gather.928 = f32[6291456]{0} gather(reshape.922, reshape.927), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.929 = f32[32768,32,6]{2,1,0} reshape(gather.928)
  slice.992 = f32[32768,32,1]{2,1,0} slice(reshape.929), slice={[0:32768], [0:32], [0:1]}
  reshape.993 = f32[32768,32]{1,0} reshape(slice.992)
  multiply.994 = f32[32768,32]{1,0} multiply(subtract.942, reshape.993)
  constant.873 = f32[] constant(2)
  broadcast.874 = f32[32768,32]{1,0} broadcast(constant.873), dimensions={}
  divide.943 = f32[32768,32]{1,0} divide(subtract.903, broadcast.874)
  negate.944 = f32[32768,32]{1,0} negate(divide.943)
  multiply.945 = f32[32768,32]{1,0} multiply(multiply.930, broadcast.874)
  constant.871 = f32[] constant(3)
  broadcast.872 = f32[32768,32]{1,0} broadcast(constant.871), dimensions={}
  divide.946 = f32[32768,32]{1,0} divide(multiply.945, broadcast.872)
  add.947 = f32[32768,32]{1,0} add(negate.944, divide.946)
  divide.948 = f32[32768,32]{1,0} divide(multiply.931, broadcast.878)
  subtract.949 = f32[32768,32]{1,0} subtract(add.947, divide.948)
  constant.869 = f32[] constant(6)
  broadcast.870 = f32[32768,32]{1,0} broadcast(constant.869), dimensions={}
  divide.950 = f32[32768,32]{1,0} divide(multiply.932, broadcast.870)
  subtract.951 = f32[32768,32]{1,0} subtract(subtract.949, divide.950)
  divide.952 = f32[32768,32]{1,0} divide(multiply.933, broadcast.878)
  add.953 = f32[32768,32]{1,0} add(subtract.951, divide.952)
  slice.995 = f32[32768,32,1]{2,1,0} slice(reshape.929), slice={[0:32768], [0:32], [1:2]}
  reshape.996 = f32[32768,32]{1,0} reshape(slice.995)
  multiply.997 = f32[32768,32]{1,0} multiply(add.953, reshape.996)
  add.998 = f32[32768,32]{1,0} add(multiply.994, multiply.997)
  constant.867 = f32[] constant(1)
  broadcast.868 = f32[32768,32]{1,0} broadcast(constant.867), dimensions={}
  divide.954 = f32[32768,32]{1,0} divide(subtract.903, broadcast.872)
  subtract.955 = f32[32768,32]{1,0} subtract(broadcast.868, divide.954)
  constant.865 = f32[] constant(5)
  broadcast.866 = f32[32768,32]{1,0} broadcast(constant.865), dimensions={}
  multiply.956 = f32[32768,32]{1,0} multiply(multiply.930, broadcast.866)
  constant.863 = f32[] constant(4)
  broadcast.864 = f32[32768,32]{1,0} broadcast(constant.863), dimensions={}
  divide.957 = f32[32768,32]{1,0} divide(multiply.956, broadcast.864)
  subtract.958 = f32[32768,32]{1,0} subtract(subtract.955, divide.957)
  multiply.959 = f32[32768,32]{1,0} multiply(multiply.931, broadcast.866)
  constant.861 = f32[] constant(12)
  broadcast.862 = f32[32768,32]{1,0} broadcast(constant.861), dimensions={}
  divide.960 = f32[32768,32]{1,0} divide(multiply.959, broadcast.862)
  add.961 = f32[32768,32]{1,0} add(subtract.958, divide.960)
  divide.962 = f32[32768,32]{1,0} divide(multiply.932, broadcast.864)
  add.963 = f32[32768,32]{1,0} add(add.961, divide.962)
  divide.964 = f32[32768,32]{1,0} divide(multiply.933, broadcast.862)
  subtract.965 = f32[32768,32]{1,0} subtract(add.963, divide.964)
  slice.999 = f32[32768,32,1]{2,1,0} slice(reshape.929), slice={[0:32768], [0:32], [2:3]}
  reshape.1000 = f32[32768,32]{1,0} reshape(slice.999)
  multiply.1001 = f32[32768,32]{1,0} multiply(subtract.965, reshape.1000)
  add.1002 = f32[32768,32]{1,0} add(add.998, multiply.1001)
  multiply.966 = f32[32768,32]{1,0} multiply(multiply.930, broadcast.874)
  divide.967 = f32[32768,32]{1,0} divide(multiply.966, broadcast.872)
  add.968 = f32[32768,32]{1,0} add(subtract.903, divide.967)
  constant.859 = f32[] constant(7)
  broadcast.860 = f32[32768,32]{1,0} broadcast(constant.859), dimensions={}
  multiply.969 = f32[32768,32]{1,0} multiply(multiply.931, broadcast.860)
  divide.970 = f32[32768,32]{1,0} divide(multiply.969, broadcast.862)
  subtract.971 = f32[32768,32]{1,0} subtract(add.968, divide.970)
  divide.972 = f32[32768,32]{1,0} divide(multiply.932, broadcast.870)
  subtract.973 = f32[32768,32]{1,0} subtract(subtract.971, divide.972)
  divide.974 = f32[32768,32]{1,0} divide(multiply.933, broadcast.862)
  add.975 = f32[32768,32]{1,0} add(subtract.973, divide.974)
  slice.1003 = f32[32768,32,1]{2,1,0} slice(reshape.929), slice={[0:32768], [0:32], [3:4]}
  reshape.1004 = f32[32768,32]{1,0} reshape(slice.1003)
  multiply.1005 = f32[32768,32]{1,0} multiply(add.975, reshape.1004)
  add.1006 = f32[32768,32]{1,0} add(add.1002, multiply.1005)
  divide.976 = f32[32768,32]{1,0} divide(subtract.903, broadcast.864)
  negate.977 = f32[32768,32]{1,0} negate(divide.976)
  divide.978 = f32[32768,32]{1,0} divide(multiply.930, broadcast.878)
  subtract.979 = f32[32768,32]{1,0} subtract(negate.977, divide.978)
  multiply.980 = f32[32768,32]{1,0} multiply(multiply.931, broadcast.860)
  divide.981 = f32[32768,32]{1,0} divide(multiply.980, broadcast.878)
  add.982 = f32[32768,32]{1,0} add(subtract.979, divide.981)
  divide.983 = f32[32768,32]{1,0} divide(multiply.932, broadcast.878)
  add.984 = f32[32768,32]{1,0} add(add.982, divide.983)
  divide.985 = f32[32768,32]{1,0} divide(multiply.933, broadcast.878)
  subtract.986 = f32[32768,32]{1,0} subtract(add.984, divide.985)
  slice.1007 = f32[32768,32,1]{2,1,0} slice(reshape.929), slice={[0:32768], [0:32], [4:5]}
  reshape.1008 = f32[32768,32]{1,0} reshape(slice.1007)
  multiply.1009 = f32[32768,32]{1,0} multiply(subtract.986, reshape.1008)
  add.1010 = f32[32768,32]{1,0} add(add.1006, multiply.1009)
  constant.857 = f32[] constant(30)
  broadcast.858 = f32[32768,32]{1,0} broadcast(constant.857), dimensions={}
  divide.987 = f32[32768,32]{1,0} divide(subtract.903, broadcast.858)
  divide.988 = f32[32768,32]{1,0} divide(multiply.931, broadcast.878)
  subtract.989 = f32[32768,32]{1,0} subtract(divide.987, divide.988)
  divide.990 = f32[32768,32]{1,0} divide(multiply.933, broadcast.876)
  add.991 = f32[32768,32]{1,0} add(subtract.989, divide.990)
  slice.1011 = f32[32768,32,1]{2,1,0} slice(reshape.929), slice={[0:32768], [0:32], [5:6]}
  reshape.1012 = f32[32768,32]{1,0} reshape(slice.1011)
  multiply.1013 = f32[32768,32]{1,0} multiply(add.991, reshape.1012)
  ROOT add.1014 = f32[32768,32]{1,0} add(add.1010, multiply.1013)
}

_where.1015 {
  Arg_0.1016 = pred[] parameter(0)
  Arg_1.1017 = s32[] parameter(1)
  Arg_2.1018 = s32[] parameter(2)
  ROOT select.1019 = s32[] select(Arg_0.1016, Arg_1.1017, Arg_2.1018)
}

remainder.1020 {
  Arg_0.1021 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.1022 = s32[] parameter(1)
  constant.1026 = s32[] constant(0)
  compare.1027 = pred[] compare(Arg_1.1022, constant.1026), direction=EQ
  constant.1025 = s32[] constant(1)
  call.1028 = s32[] call(compare.1027, constant.1025, Arg_1.1022), to_apply=_where.1015
  broadcast.1029 = s32[32768,32,6]{2,1,0} broadcast(call.1028), dimensions={}
  remainder.1030 = s32[32768,32,6]{2,1,0} remainder(Arg_0.1021, broadcast.1029)
  constant.1023 = s32[] constant(0)
  broadcast.1024 = s32[32768,32,6]{2,1,0} broadcast(constant.1023), dimensions={}
  compare.1032 = pred[32768,32,6]{2,1,0} compare(remainder.1030, broadcast.1024), direction=LT
  compare.1033 = pred[] compare(call.1028, constant.1026), direction=LT
  broadcast.1034 = pred[32768,32,6]{2,1,0} broadcast(compare.1033), dimensions={}
  compare.1035 = pred[32768,32,6]{2,1,0} compare(compare.1032, broadcast.1034), direction=NE
  compare.1031 = pred[32768,32,6]{2,1,0} compare(remainder.1030, broadcast.1024), direction=NE
  and.1036 = pred[32768,32,6]{2,1,0} and(compare.1035, compare.1031)
  broadcast.1037 = s32[32768,32,6]{2,1,0} broadcast(call.1028), dimensions={}
  add.1038 = s32[32768,32,6]{2,1,0} add(remainder.1030, broadcast.1037)
  ROOT select.1039 = s32[32768,32,6]{2,1,0} select(and.1036, add.1038, remainder.1030)
}

advect_1d_vectorized.1040 {
  iota.1077 = f32[32]{0} iota(), iota_dimension=0
  reshape.1083 = f32[1,32]{1,0} reshape(iota.1077)
  broadcast.1084 = f32[1,32]{1,0} broadcast(reshape.1083), dimensions={0,1}
  reshape.1085 = f32[32]{0} reshape(broadcast.1084)
  broadcast.1086 = f32[32768,32]{1,0} broadcast(reshape.1085), dimensions={1}
  Arg_1.1042 = f32[32768]{0} parameter(1)
  reshape.1078 = f32[32768,1]{1,0} reshape(Arg_1.1042)
  Arg_2.1043 = f32[] parameter(2)
  broadcast.1079 = f32[32768,1]{1,0} broadcast(Arg_2.1043), dimensions={}
  multiply.1080 = f32[32768,1]{1,0} multiply(reshape.1078, broadcast.1079)
  Arg_3.1044 = f32[] parameter(3)
  broadcast.1081 = f32[32768,1]{1,0} broadcast(Arg_3.1044), dimensions={}
  divide.1082 = f32[32768,1]{1,0} divide(multiply.1080, broadcast.1081)
  broadcast.1087 = f32[32768,1]{1,0} broadcast(divide.1082), dimensions={0,1}
  reshape.1088 = f32[32768]{0} reshape(broadcast.1087)
  broadcast.1089 = f32[32768,32]{1,0} broadcast(reshape.1088), dimensions={0}
  subtract.1090 = f32[32768,32]{1,0} subtract(broadcast.1086, broadcast.1089)
  floor.1091 = f32[32768,32]{1,0} floor(subtract.1090)
  subtract.1092 = f32[32768,32]{1,0} subtract(subtract.1090, floor.1091)
  constant.1068 = f32[] constant(20)
  broadcast.1069 = f32[32768,32]{1,0} broadcast(constant.1068), dimensions={}
  divide.1123 = f32[32768,32]{1,0} divide(subtract.1092, broadcast.1069)
  multiply.1119 = f32[32768,32]{1,0} multiply(subtract.1092, subtract.1092)
  constant.1066 = f32[] constant(24)
  broadcast.1067 = f32[32768,32]{1,0} broadcast(constant.1066), dimensions={}
  divide.1124 = f32[32768,32]{1,0} divide(multiply.1119, broadcast.1067)
  subtract.1125 = f32[32768,32]{1,0} subtract(divide.1123, divide.1124)
  multiply.1120 = f32[32768,32]{1,0} multiply(multiply.1119, subtract.1092)
  divide.1126 = f32[32768,32]{1,0} divide(multiply.1120, broadcast.1067)
  subtract.1127 = f32[32768,32]{1,0} subtract(subtract.1125, divide.1126)
  multiply.1121 = f32[32768,32]{1,0} multiply(multiply.1120, subtract.1092)
  divide.1128 = f32[32768,32]{1,0} divide(multiply.1121, broadcast.1067)
  add.1129 = f32[32768,32]{1,0} add(subtract.1127, divide.1128)
  multiply.1122 = f32[32768,32]{1,0} multiply(multiply.1121, subtract.1092)
  constant.1064 = f32[] constant(120)
  broadcast.1065 = f32[32768,32]{1,0} broadcast(constant.1064), dimensions={}
  divide.1130 = f32[32768,32]{1,0} divide(multiply.1122, broadcast.1065)
  subtract.1131 = f32[32768,32]{1,0} subtract(add.1129, divide.1130)
  Arg_0.1041 = f32[32768,32]{1,0} parameter(0)
  reshape.1111 = f32[1048576]{0} reshape(Arg_0.1041)
  iota.1104 = s32[32768]{0} iota(), iota_dimension=0
  reshape.1105 = s32[32768,1,1]{2,1,0} reshape(iota.1104)
  constant.1074 = s32[] constant(32)
  broadcast.1075 = s32[32768,1,1]{2,1,0} broadcast(constant.1074), dimensions={}
  multiply.1106 = s32[32768,1,1]{2,1,0} multiply(reshape.1105, broadcast.1075)
  broadcast.1107 = s32[32768,1,1]{2,1,0} broadcast(multiply.1106), dimensions={0,1,2}
  reshape.1108 = s32[32768]{0} reshape(broadcast.1107)
  broadcast.1109 = s32[32768,32,6]{2,1,0} broadcast(reshape.1108), dimensions={0}
  convert.1093 = s32[32768,32]{1,0} convert(floor.1091)
  reshape.1094 = s32[32768,32,1]{2,1,0} reshape(convert.1093)
  broadcast.1096 = s32[32768,32,1]{2,1,0} broadcast(reshape.1094), dimensions={0,1,2}
  reshape.1097 = s32[32768,32]{1,0} reshape(broadcast.1096)
  broadcast.1098 = s32[32768,32,6]{2,1,0} broadcast(reshape.1097), dimensions={0,1}
  Arg_4.1045 = s32[6]{0} parameter(4)
  reshape.1095 = s32[1,1,6]{2,1,0} reshape(Arg_4.1045)
  broadcast.1099 = s32[1,1,6]{2,1,0} broadcast(reshape.1095), dimensions={0,1,2}
  reshape.1100 = s32[6]{0} reshape(broadcast.1099)
  broadcast.1101 = s32[32768,32,6]{2,1,0} broadcast(reshape.1100), dimensions={2}
  add.1102 = s32[32768,32,6]{2,1,0} add(broadcast.1098, broadcast.1101)
  constant.1076 = s32[] constant(32)
  call.1103 = s32[32768,32,6]{2,1,0} call(add.1102, constant.1076), to_apply=remainder.1020
  add.1110 = s32[32768,32,6]{2,1,0} add(broadcast.1109, call.1103)
  reshape.1112 = s32[6291456]{0} reshape(add.1110)
  constant.1072 = s32[] constant(0)
  broadcast.1073 = s32[6291456]{0} broadcast(constant.1072), dimensions={}
  compare.1113 = pred[6291456]{0} compare(reshape.1112, broadcast.1073), direction=LT
  constant.1070 = s32[] constant(1048576)
  broadcast.1071 = s32[6291456]{0} broadcast(constant.1070), dimensions={}
  add.1114 = s32[6291456]{0} add(reshape.1112, broadcast.1071)
  select.1115 = s32[6291456]{0} select(compare.1113, add.1114, reshape.1112)
  reshape.1116 = s32[6291456,1]{1,0} reshape(select.1115)
  gather.1117 = f32[6291456]{0} gather(reshape.1111, reshape.1116), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.1118 = f32[32768,32,6]{2,1,0} reshape(gather.1117)
  slice.1181 = f32[32768,32,1]{2,1,0} slice(reshape.1118), slice={[0:32768], [0:32], [0:1]}
  reshape.1182 = f32[32768,32]{1,0} reshape(slice.1181)
  multiply.1183 = f32[32768,32]{1,0} multiply(subtract.1131, reshape.1182)
  constant.1062 = f32[] constant(2)
  broadcast.1063 = f32[32768,32]{1,0} broadcast(constant.1062), dimensions={}
  divide.1132 = f32[32768,32]{1,0} divide(subtract.1092, broadcast.1063)
  negate.1133 = f32[32768,32]{1,0} negate(divide.1132)
  multiply.1134 = f32[32768,32]{1,0} multiply(multiply.1119, broadcast.1063)
  constant.1060 = f32[] constant(3)
  broadcast.1061 = f32[32768,32]{1,0} broadcast(constant.1060), dimensions={}
  divide.1135 = f32[32768,32]{1,0} divide(multiply.1134, broadcast.1061)
  add.1136 = f32[32768,32]{1,0} add(negate.1133, divide.1135)
  divide.1137 = f32[32768,32]{1,0} divide(multiply.1120, broadcast.1067)
  subtract.1138 = f32[32768,32]{1,0} subtract(add.1136, divide.1137)
  constant.1058 = f32[] constant(6)
  broadcast.1059 = f32[32768,32]{1,0} broadcast(constant.1058), dimensions={}
  divide.1139 = f32[32768,32]{1,0} divide(multiply.1121, broadcast.1059)
  subtract.1140 = f32[32768,32]{1,0} subtract(subtract.1138, divide.1139)
  divide.1141 = f32[32768,32]{1,0} divide(multiply.1122, broadcast.1067)
  add.1142 = f32[32768,32]{1,0} add(subtract.1140, divide.1141)
  slice.1184 = f32[32768,32,1]{2,1,0} slice(reshape.1118), slice={[0:32768], [0:32], [1:2]}
  reshape.1185 = f32[32768,32]{1,0} reshape(slice.1184)
  multiply.1186 = f32[32768,32]{1,0} multiply(add.1142, reshape.1185)
  add.1187 = f32[32768,32]{1,0} add(multiply.1183, multiply.1186)
  constant.1056 = f32[] constant(1)
  broadcast.1057 = f32[32768,32]{1,0} broadcast(constant.1056), dimensions={}
  divide.1143 = f32[32768,32]{1,0} divide(subtract.1092, broadcast.1061)
  subtract.1144 = f32[32768,32]{1,0} subtract(broadcast.1057, divide.1143)
  constant.1054 = f32[] constant(5)
  broadcast.1055 = f32[32768,32]{1,0} broadcast(constant.1054), dimensions={}
  multiply.1145 = f32[32768,32]{1,0} multiply(multiply.1119, broadcast.1055)
  constant.1052 = f32[] constant(4)
  broadcast.1053 = f32[32768,32]{1,0} broadcast(constant.1052), dimensions={}
  divide.1146 = f32[32768,32]{1,0} divide(multiply.1145, broadcast.1053)
  subtract.1147 = f32[32768,32]{1,0} subtract(subtract.1144, divide.1146)
  multiply.1148 = f32[32768,32]{1,0} multiply(multiply.1120, broadcast.1055)
  constant.1050 = f32[] constant(12)
  broadcast.1051 = f32[32768,32]{1,0} broadcast(constant.1050), dimensions={}
  divide.1149 = f32[32768,32]{1,0} divide(multiply.1148, broadcast.1051)
  add.1150 = f32[32768,32]{1,0} add(subtract.1147, divide.1149)
  divide.1151 = f32[32768,32]{1,0} divide(multiply.1121, broadcast.1053)
  add.1152 = f32[32768,32]{1,0} add(add.1150, divide.1151)
  divide.1153 = f32[32768,32]{1,0} divide(multiply.1122, broadcast.1051)
  subtract.1154 = f32[32768,32]{1,0} subtract(add.1152, divide.1153)
  slice.1188 = f32[32768,32,1]{2,1,0} slice(reshape.1118), slice={[0:32768], [0:32], [2:3]}
  reshape.1189 = f32[32768,32]{1,0} reshape(slice.1188)
  multiply.1190 = f32[32768,32]{1,0} multiply(subtract.1154, reshape.1189)
  add.1191 = f32[32768,32]{1,0} add(add.1187, multiply.1190)
  multiply.1155 = f32[32768,32]{1,0} multiply(multiply.1119, broadcast.1063)
  divide.1156 = f32[32768,32]{1,0} divide(multiply.1155, broadcast.1061)
  add.1157 = f32[32768,32]{1,0} add(subtract.1092, divide.1156)
  constant.1048 = f32[] constant(7)
  broadcast.1049 = f32[32768,32]{1,0} broadcast(constant.1048), dimensions={}
  multiply.1158 = f32[32768,32]{1,0} multiply(multiply.1120, broadcast.1049)
  divide.1159 = f32[32768,32]{1,0} divide(multiply.1158, broadcast.1051)
  subtract.1160 = f32[32768,32]{1,0} subtract(add.1157, divide.1159)
  divide.1161 = f32[32768,32]{1,0} divide(multiply.1121, broadcast.1059)
  subtract.1162 = f32[32768,32]{1,0} subtract(subtract.1160, divide.1161)
  divide.1163 = f32[32768,32]{1,0} divide(multiply.1122, broadcast.1051)
  add.1164 = f32[32768,32]{1,0} add(subtract.1162, divide.1163)
  slice.1192 = f32[32768,32,1]{2,1,0} slice(reshape.1118), slice={[0:32768], [0:32], [3:4]}
  reshape.1193 = f32[32768,32]{1,0} reshape(slice.1192)
  multiply.1194 = f32[32768,32]{1,0} multiply(add.1164, reshape.1193)
  add.1195 = f32[32768,32]{1,0} add(add.1191, multiply.1194)
  divide.1165 = f32[32768,32]{1,0} divide(subtract.1092, broadcast.1053)
  negate.1166 = f32[32768,32]{1,0} negate(divide.1165)
  divide.1167 = f32[32768,32]{1,0} divide(multiply.1119, broadcast.1067)
  subtract.1168 = f32[32768,32]{1,0} subtract(negate.1166, divide.1167)
  multiply.1169 = f32[32768,32]{1,0} multiply(multiply.1120, broadcast.1049)
  divide.1170 = f32[32768,32]{1,0} divide(multiply.1169, broadcast.1067)
  add.1171 = f32[32768,32]{1,0} add(subtract.1168, divide.1170)
  divide.1172 = f32[32768,32]{1,0} divide(multiply.1121, broadcast.1067)
  add.1173 = f32[32768,32]{1,0} add(add.1171, divide.1172)
  divide.1174 = f32[32768,32]{1,0} divide(multiply.1122, broadcast.1067)
  subtract.1175 = f32[32768,32]{1,0} subtract(add.1173, divide.1174)
  slice.1196 = f32[32768,32,1]{2,1,0} slice(reshape.1118), slice={[0:32768], [0:32], [4:5]}
  reshape.1197 = f32[32768,32]{1,0} reshape(slice.1196)
  multiply.1198 = f32[32768,32]{1,0} multiply(subtract.1175, reshape.1197)
  add.1199 = f32[32768,32]{1,0} add(add.1195, multiply.1198)
  constant.1046 = f32[] constant(30)
  broadcast.1047 = f32[32768,32]{1,0} broadcast(constant.1046), dimensions={}
  divide.1176 = f32[32768,32]{1,0} divide(subtract.1092, broadcast.1047)
  divide.1177 = f32[32768,32]{1,0} divide(multiply.1120, broadcast.1067)
  subtract.1178 = f32[32768,32]{1,0} subtract(divide.1176, divide.1177)
  divide.1179 = f32[32768,32]{1,0} divide(multiply.1122, broadcast.1065)
  add.1180 = f32[32768,32]{1,0} add(subtract.1178, divide.1179)
  slice.1200 = f32[32768,32,1]{2,1,0} slice(reshape.1118), slice={[0:32768], [0:32], [5:6]}
  reshape.1201 = f32[32768,32]{1,0} reshape(slice.1200)
  multiply.1202 = f32[32768,32]{1,0} multiply(add.1180, reshape.1201)
  ROOT add.1203 = f32[32768,32]{1,0} add(add.1199, multiply.1202)
}

None.1204 {
  Arg_7.1212 = f32[32,32]{1,0} parameter(7)
  Arg_8.1213 = f32[32,32]{1,0} parameter(8)
  Arg_6.1211 = f32[32,32,32,32]{3,2,1,0} parameter(6)
  transpose.1219 = f32[32,32,32,32]{2,1,0,3} transpose(Arg_6.1211), dimensions={1,2,3,0}
  reshape.1220 = f32[32768,32]{1,0} reshape(transpose.1219)
  Arg_0.1205 = f32[32]{0} parameter(0)
  reshape.1218 = f32[1,32,1]{2,1,0} reshape(Arg_0.1205)
  broadcast.1221 = f32[1,32,1]{2,1,0} broadcast(reshape.1218), dimensions={0,1,2}
  reshape.1222 = f32[32]{0} reshape(broadcast.1221)
  broadcast.1223 = f32[32,32,32]{2,1,0} broadcast(reshape.1222), dimensions={1}
  reshape.1224 = f32[32768]{0} reshape(broadcast.1223)
  constant.1217 = f32[] constant(0.025)
  constant.1216 = f32[] constant(0.392699093)
  Arg_1.1206 = s32[6]{0} parameter(1)
  call.1225 = f32[32768,32]{1,0} call(reshape.1220, reshape.1224, constant.1217, constant.1216, Arg_1.1206), to_apply=advect_1d_vectorized.42
  reshape.1226 = f32[32,32,32,32]{3,2,1,0} reshape(call.1225)
  transpose.1228 = f32[32,32,32,32]{0,2,1,3} transpose(reshape.1226), dimensions={3,1,2,0}
  reshape.1229 = f32[32768,32]{1,0} reshape(transpose.1228)
  Arg_2.1207 = f32[32]{0} parameter(2)
  reshape.1227 = f32[1,1,32]{2,1,0} reshape(Arg_2.1207)
  broadcast.1230 = f32[1,1,32]{2,1,0} broadcast(reshape.1227), dimensions={0,1,2}
  reshape.1231 = f32[32]{0} reshape(broadcast.1230)
  broadcast.1232 = f32[32,32,32]{2,1,0} broadcast(reshape.1231), dimensions={2}
  reshape.1233 = f32[32768]{0} reshape(broadcast.1232)
  call.1234 = f32[32768,32]{1,0} call(reshape.1229, reshape.1233, constant.1217, constant.1216, Arg_1.1206), to_apply=advect_1d_vectorized.231
  reshape.1235 = f32[32,32,32,32]{3,2,1,0} reshape(call.1234)
  transpose.1243 = f32[32,32,32,32]{1,2,3,0} transpose(reshape.1235), dimensions={0,3,2,1}
  reshape.1244 = f32[32768,32]{1,0} reshape(transpose.1243)
  transpose.1236 = f32[32,32,32,32]{1,3,2,0} transpose(reshape.1235), dimensions={0,3,1,2}
  Arg_3.1208 = f32[32,1]{1,0} parameter(3)
  Arg_4.1209 = f32[1,17]{1,0} parameter(4)
  Arg_5.1210 = f32[32,17]{1,0} parameter(5)
  constant.1215 = f32[] constant(0.322580636)
  call.1237 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) call(transpose.1236, Arg_3.1208, Arg_4.1209, Arg_5.1210, constant.1215, constant.1215), to_apply=solve_poisson.411
  get-tuple-element.1238 = f32[32,32]{1,0} get-tuple-element(call.1237), index=0
  reshape.1242 = f32[32,32,1]{2,1,0} reshape(get-tuple-element.1238)
  broadcast.1245 = f32[32,32,1]{2,1,0} broadcast(reshape.1242), dimensions={0,1,2}
  reshape.1246 = f32[32,32]{1,0} reshape(broadcast.1245)
  broadcast.1247 = f32[32,32,32]{2,1,0} broadcast(reshape.1246), dimensions={0,1}
  reshape.1248 = f32[32768]{0} reshape(broadcast.1247)
  constant.1214 = f32[] constant(0.05)
  call.1249 = f32[32768,32]{1,0} call(reshape.1244, reshape.1248, constant.1214, constant.1215, Arg_1.1206), to_apply=advect_1d_vectorized_1.464
  reshape.1250 = f32[32,32,32,32]{3,2,1,0} reshape(call.1249)
  transpose.1251 = f32[32,32,32,32]{2,3,1,0} transpose(reshape.1250), dimensions={0,1,3,2}
  reshape.1253 = f32[32768,32]{1,0} reshape(transpose.1251)
  get-tuple-element.1239 = f32[32,32]{1,0} get-tuple-element(call.1237), index=1
  reshape.1252 = f32[32,32,1]{2,1,0} reshape(get-tuple-element.1239)
  broadcast.1254 = f32[32,32,1]{2,1,0} broadcast(reshape.1252), dimensions={0,1,2}
  reshape.1255 = f32[32,32]{1,0} reshape(broadcast.1254)
  broadcast.1256 = f32[32,32,32]{2,1,0} broadcast(reshape.1255), dimensions={0,1}
  reshape.1257 = f32[32768]{0} reshape(broadcast.1256)
  call.1258 = f32[32768,32]{1,0} call(reshape.1253, reshape.1257, constant.1214, constant.1215, Arg_1.1206), to_apply=advect_1d_vectorized_1.652
  reshape.1259 = f32[32,32,32,32]{3,2,1,0} reshape(call.1258)
  transpose.1261 = f32[32,32,32,32]{2,1,3,0} transpose(reshape.1259), dimensions={0,2,3,1}
  reshape.1262 = f32[32768,32]{1,0} reshape(transpose.1261)
  reshape.1260 = f32[1,1,32]{2,1,0} reshape(Arg_2.1207)
  broadcast.1263 = f32[1,1,32]{2,1,0} broadcast(reshape.1260), dimensions={0,1,2}
  reshape.1264 = f32[32]{0} reshape(broadcast.1263)
  broadcast.1265 = f32[32,32,32]{2,1,0} broadcast(reshape.1264), dimensions={2}
  reshape.1266 = f32[32768]{0} reshape(broadcast.1265)
  call.1267 = f32[32768,32]{1,0} call(reshape.1262, reshape.1266, constant.1217, constant.1216, Arg_1.1206), to_apply=advect_1d_vectorized.851
  reshape.1268 = f32[32,32,32,32]{3,2,1,0} reshape(call.1267)
  transpose.1270 = f32[32,32,32,32]{0,2,1,3} transpose(reshape.1268), dimensions={3,1,2,0}
  reshape.1271 = f32[32768,32]{1,0} reshape(transpose.1270)
  reshape.1269 = f32[1,32,1]{2,1,0} reshape(Arg_0.1205)
  broadcast.1272 = f32[1,32,1]{2,1,0} broadcast(reshape.1269), dimensions={0,1,2}
  reshape.1273 = f32[32]{0} reshape(broadcast.1272)
  broadcast.1274 = f32[32,32,32]{2,1,0} broadcast(reshape.1273), dimensions={1}
  reshape.1275 = f32[32768]{0} reshape(broadcast.1274)
  call.1276 = f32[32768,32]{1,0} call(reshape.1271, reshape.1275, constant.1217, constant.1216, Arg_1.1206), to_apply=advect_1d_vectorized.1040
  reshape.1277 = f32[32,32,32,32]{3,2,1,0} reshape(call.1276)
  transpose.1278 = f32[32,32,32,32]{0,3,2,1} transpose(reshape.1277), dimensions={3,0,1,2}
  get-tuple-element.1240 = f32[32,32]{1,0} get-tuple-element(call.1237), index=2
  get-tuple-element.1241 = f32[32,32]{1,0} get-tuple-element(call.1237), index=3
  ROOT tuple.1279 = (f32[32,32,32,32]{0,3,2,1}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(transpose.1278, get-tuple-element.1240, get-tuple-element.1241)
}

region_0.1280 {
  arg_tuple.1281 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) parameter(0)
  get-tuple-element.1282 = s32[] get-tuple-element(arg_tuple.1281), index=0
  constant.1286 = s32[] constant(1)
  add.1296 = s32[] add(get-tuple-element.1282, constant.1286)
  constant.1291 = f32[32]{0} constant({...})
  constant.1290 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  constant.1289 = f32[32,1]{1,0} constant({...})
  constant.1288 = f32[1,17]{1,0} constant({...})
  constant.1287 = f32[32,17]{1,0} constant({...})
  get-tuple-element.1283 = f32[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.1281), index=1
  get-tuple-element.1284 = f32[32,32]{1,0} get-tuple-element(arg_tuple.1281), index=2
  get-tuple-element.1285 = f32[32,32]{1,0} get-tuple-element(arg_tuple.1281), index=3
  call.1292 = (f32[32,32,32,32]{0,3,2,1}, f32[32,32]{1,0}, f32[32,32]{1,0}) call(constant.1291, constant.1290, constant.1291, constant.1289, constant.1288, constant.1287, get-tuple-element.1283, get-tuple-element.1284, get-tuple-element.1285), to_apply=None.1204
  get-tuple-element.1293 = f32[32,32,32,32]{0,3,2,1} get-tuple-element(call.1292), index=0
  get-tuple-element.1294 = f32[32,32]{1,0} get-tuple-element(call.1292), index=1
  get-tuple-element.1295 = f32[32,32]{1,0} get-tuple-element(call.1292), index=2
  ROOT tuple.1297 = (s32[], f32[32,32,32,32]{0,3,2,1}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(add.1296, get-tuple-element.1293, get-tuple-element.1294, get-tuple-element.1295)
}

region_2.1298 {
  arg_tuple.1299 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) parameter(0)
  get-tuple-element.1301 = f32[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.1299), index=1
  get-tuple-element.1302 = f32[32,32]{1,0} get-tuple-element(arg_tuple.1299), index=2
  get-tuple-element.1303 = f32[32,32]{1,0} get-tuple-element(arg_tuple.1299), index=3
  get-tuple-element.1300 = s32[] get-tuple-element(arg_tuple.1299), index=0
  constant.1304 = s32[] constant(128)
  ROOT compare.1305 = pred[] compare(get-tuple-element.1300, constant.1304), direction=LT
}

ENTRY main.1314 {
  constant.15 = s32[] constant(0)
  Arg_2.3 = f32[32,32,32,32]{3,2,1,0} parameter(2)
  Arg_0.1 = f32[32,32]{1,0} parameter(0)
  Arg_1.2 = f32[32,32]{1,0} parameter(1)
  tuple.16 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(constant.15, Arg_2.3, Arg_0.1, Arg_1.2)
  while.1306 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) while(tuple.16), condition=region_2.1298, body=region_0.1280
  get-tuple-element.1307 = s32[] get-tuple-element(while.1306), index=0
  constant.14 = f32[32]{0} constant({...})
  constant.9 = f32[32]{0} constant({...})
  constant.11 = f32[32,1]{1,0} constant({...})
  constant.12 = f32[1,17]{1,0} constant({...})
  constant.13 = f32[32,17]{1,0} constant({...})
  constant.10 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  get-tuple-element.1309 = f32[32,32]{1,0} get-tuple-element(while.1306), index=2
  get-tuple-element.1310 = f32[32,32]{1,0} get-tuple-element(while.1306), index=3
  get-tuple-element.1308 = f32[32,32,32,32]{3,2,1,0} get-tuple-element(while.1306), index=1
  Arg_3.4 = f32[32,32]{1,0} parameter(3)
  Arg_4.5 = f32[] parameter(4)
  constant.7 = f32[] constant(6.4)
  add.1311 = f32[] add(Arg_4.5, constant.7)
  Arg_5.6 = s32[] parameter(5)
  constant.8 = s32[] constant(128)
  add.1312 = s32[] add(Arg_5.6, constant.8)
  ROOT tuple.1313 = (f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,1]{1,0}, /*index=5*/f32[1,17]{1,0}, f32[32,17]{1,0}, s32[6]{0}, f32[32,32]{1,0}, f32[32,32]{1,0}, /*index=10*/f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[], s32[]) tuple(constant.14, constant.14, constant.9, constant.9, constant.11, constant.12, constant.13, constant.10, get-tuple-element.1309, get-tuple-element.1310, get-tuple-element.1308, Arg_3.4, add.1311, add.1312)
}

