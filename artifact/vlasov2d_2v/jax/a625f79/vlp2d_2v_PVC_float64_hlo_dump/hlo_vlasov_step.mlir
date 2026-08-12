HloModule jit__lambda_, entry_computation_layout={(f64[32,32,32,32]{3,2,1,0})->(f64[32,32,32,32]{0,3,2,1}, f64[32,32]{1,0}, f64[32,32]{1,0})}

_where.18 {
  Arg_0.19 = pred[] parameter(0)
  Arg_1.20 = s32[] parameter(1)
  Arg_2.21 = s32[] parameter(2)
  ROOT select.22 = s32[] select(Arg_0.19, Arg_1.20, Arg_2.21)
}

remainder.23 {
  Arg_0.24 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.25 = s64[] parameter(1)
  convert.30 = s32[] convert(Arg_1.25)
  constant.29 = s32[] constant(0)
  compare.31 = pred[] compare(convert.30, constant.29), direction=EQ
  constant.28 = s32[] constant(1)
  call.32 = s32[] call(compare.31, constant.28, convert.30), to_apply=_where.18
  broadcast.33 = s32[32768,32,6]{2,1,0} broadcast(call.32), dimensions={}
  remainder.34 = s32[32768,32,6]{2,1,0} remainder(Arg_0.24, broadcast.33)
  constant.26 = s32[] constant(0)
  broadcast.27 = s32[32768,32,6]{2,1,0} broadcast(constant.26), dimensions={}
  compare.36 = pred[32768,32,6]{2,1,0} compare(remainder.34, broadcast.27), direction=LT
  compare.37 = pred[] compare(call.32, constant.29), direction=LT
  broadcast.38 = pred[32768,32,6]{2,1,0} broadcast(compare.37), dimensions={}
  compare.39 = pred[32768,32,6]{2,1,0} compare(compare.36, broadcast.38), direction=NE
  compare.35 = pred[32768,32,6]{2,1,0} compare(remainder.34, broadcast.27), direction=NE
  and.40 = pred[32768,32,6]{2,1,0} and(compare.39, compare.35)
  broadcast.41 = s32[32768,32,6]{2,1,0} broadcast(call.32), dimensions={}
  add.42 = s32[32768,32,6]{2,1,0} add(remainder.34, broadcast.41)
  ROOT select.43 = s32[32768,32,6]{2,1,0} select(and.40, add.42, remainder.34)
}

advect_1d_vectorized.44 {
  iota.81 = f64[32]{0} iota(), iota_dimension=0
  reshape.87 = f64[1,32]{1,0} reshape(iota.81)
  broadcast.88 = f64[1,32]{1,0} broadcast(reshape.87), dimensions={0,1}
  reshape.89 = f64[32]{0} reshape(broadcast.88)
  broadcast.90 = f64[32768,32]{1,0} broadcast(reshape.89), dimensions={1}
  Arg_1.46 = f64[32768]{0} parameter(1)
  reshape.82 = f64[32768,1]{1,0} reshape(Arg_1.46)
  Arg_2.47 = f64[] parameter(2)
  broadcast.83 = f64[32768,1]{1,0} broadcast(Arg_2.47), dimensions={}
  multiply.84 = f64[32768,1]{1,0} multiply(reshape.82, broadcast.83)
  Arg_3.48 = f64[] parameter(3)
  broadcast.85 = f64[32768,1]{1,0} broadcast(Arg_3.48), dimensions={}
  divide.86 = f64[32768,1]{1,0} divide(multiply.84, broadcast.85)
  broadcast.91 = f64[32768,1]{1,0} broadcast(divide.86), dimensions={0,1}
  reshape.92 = f64[32768]{0} reshape(broadcast.91)
  broadcast.93 = f64[32768,32]{1,0} broadcast(reshape.92), dimensions={0}
  subtract.94 = f64[32768,32]{1,0} subtract(broadcast.90, broadcast.93)
  floor.95 = f64[32768,32]{1,0} floor(subtract.94)
  subtract.96 = f64[32768,32]{1,0} subtract(subtract.94, floor.95)
  constant.72 = f64[] constant(20)
  broadcast.73 = f64[32768,32]{1,0} broadcast(constant.72), dimensions={}
  divide.129 = f64[32768,32]{1,0} divide(subtract.96, broadcast.73)
  multiply.125 = f64[32768,32]{1,0} multiply(subtract.96, subtract.96)
  constant.70 = f64[] constant(24)
  broadcast.71 = f64[32768,32]{1,0} broadcast(constant.70), dimensions={}
  divide.130 = f64[32768,32]{1,0} divide(multiply.125, broadcast.71)
  subtract.131 = f64[32768,32]{1,0} subtract(divide.129, divide.130)
  multiply.126 = f64[32768,32]{1,0} multiply(multiply.125, subtract.96)
  divide.132 = f64[32768,32]{1,0} divide(multiply.126, broadcast.71)
  subtract.133 = f64[32768,32]{1,0} subtract(subtract.131, divide.132)
  multiply.127 = f64[32768,32]{1,0} multiply(multiply.126, subtract.96)
  divide.134 = f64[32768,32]{1,0} divide(multiply.127, broadcast.71)
  add.135 = f64[32768,32]{1,0} add(subtract.133, divide.134)
  multiply.128 = f64[32768,32]{1,0} multiply(multiply.127, subtract.96)
  constant.68 = f64[] constant(120)
  broadcast.69 = f64[32768,32]{1,0} broadcast(constant.68), dimensions={}
  divide.136 = f64[32768,32]{1,0} divide(multiply.128, broadcast.69)
  subtract.137 = f64[32768,32]{1,0} subtract(add.135, divide.136)
  Arg_0.45 = f64[32768,32]{1,0} parameter(0)
  reshape.116 = f64[1048576]{0} reshape(Arg_0.45)
  iota.108 = s64[32768]{0} iota(), iota_dimension=0
  reshape.109 = s64[32768,1,1]{2,1,0} reshape(iota.108)
  constant.78 = s64[] constant(32)
  broadcast.79 = s64[32768,1,1]{2,1,0} broadcast(constant.78), dimensions={}
  multiply.110 = s64[32768,1,1]{2,1,0} multiply(reshape.109, broadcast.79)
  broadcast.112 = s64[32768,1,1]{2,1,0} broadcast(multiply.110), dimensions={0,1,2}
  reshape.113 = s64[32768]{0} reshape(broadcast.112)
  broadcast.114 = s64[32768,32,6]{2,1,0} broadcast(reshape.113), dimensions={0}
  convert.97 = s32[32768,32]{1,0} convert(floor.95)
  reshape.98 = s32[32768,32,1]{2,1,0} reshape(convert.97)
  broadcast.100 = s32[32768,32,1]{2,1,0} broadcast(reshape.98), dimensions={0,1,2}
  reshape.101 = s32[32768,32]{1,0} reshape(broadcast.100)
  broadcast.102 = s32[32768,32,6]{2,1,0} broadcast(reshape.101), dimensions={0,1}
  Arg_4.49 = s32[6]{0} parameter(4)
  reshape.99 = s32[1,1,6]{2,1,0} reshape(Arg_4.49)
  broadcast.103 = s32[1,1,6]{2,1,0} broadcast(reshape.99), dimensions={0,1,2}
  reshape.104 = s32[6]{0} reshape(broadcast.103)
  broadcast.105 = s32[32768,32,6]{2,1,0} broadcast(reshape.104), dimensions={2}
  add.106 = s32[32768,32,6]{2,1,0} add(broadcast.102, broadcast.105)
  constant.80 = s64[] constant(32)
  call.107 = s32[32768,32,6]{2,1,0} call(add.106, constant.80), to_apply=remainder.23
  convert.111 = s64[32768,32,6]{2,1,0} convert(call.107)
  add.115 = s64[32768,32,6]{2,1,0} add(broadcast.114, convert.111)
  reshape.117 = s64[6291456]{0} reshape(add.115)
  constant.76 = s64[] constant(0)
  broadcast.77 = s64[6291456]{0} broadcast(constant.76), dimensions={}
  compare.118 = pred[6291456]{0} compare(reshape.117, broadcast.77), direction=LT
  constant.74 = s64[] constant(1048576)
  broadcast.75 = s64[6291456]{0} broadcast(constant.74), dimensions={}
  add.119 = s64[6291456]{0} add(reshape.117, broadcast.75)
  select.120 = s64[6291456]{0} select(compare.118, add.119, reshape.117)
  convert.121 = s32[6291456]{0} convert(select.120)
  reshape.122 = s32[6291456,1]{1,0} reshape(convert.121)
  gather.123 = f64[6291456]{0} gather(reshape.116, reshape.122), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.124 = f64[32768,32,6]{2,1,0} reshape(gather.123)
  slice.187 = f64[32768,32,1]{2,1,0} slice(reshape.124), slice={[0:32768], [0:32], [0:1]}
  reshape.188 = f64[32768,32]{1,0} reshape(slice.187)
  multiply.189 = f64[32768,32]{1,0} multiply(subtract.137, reshape.188)
  constant.66 = f64[] constant(2)
  broadcast.67 = f64[32768,32]{1,0} broadcast(constant.66), dimensions={}
  divide.138 = f64[32768,32]{1,0} divide(subtract.96, broadcast.67)
  negate.139 = f64[32768,32]{1,0} negate(divide.138)
  multiply.140 = f64[32768,32]{1,0} multiply(multiply.125, broadcast.67)
  constant.64 = f64[] constant(3)
  broadcast.65 = f64[32768,32]{1,0} broadcast(constant.64), dimensions={}
  divide.141 = f64[32768,32]{1,0} divide(multiply.140, broadcast.65)
  add.142 = f64[32768,32]{1,0} add(negate.139, divide.141)
  divide.143 = f64[32768,32]{1,0} divide(multiply.126, broadcast.71)
  subtract.144 = f64[32768,32]{1,0} subtract(add.142, divide.143)
  constant.62 = f64[] constant(6)
  broadcast.63 = f64[32768,32]{1,0} broadcast(constant.62), dimensions={}
  divide.145 = f64[32768,32]{1,0} divide(multiply.127, broadcast.63)
  subtract.146 = f64[32768,32]{1,0} subtract(subtract.144, divide.145)
  divide.147 = f64[32768,32]{1,0} divide(multiply.128, broadcast.71)
  add.148 = f64[32768,32]{1,0} add(subtract.146, divide.147)
  slice.190 = f64[32768,32,1]{2,1,0} slice(reshape.124), slice={[0:32768], [0:32], [1:2]}
  reshape.191 = f64[32768,32]{1,0} reshape(slice.190)
  multiply.192 = f64[32768,32]{1,0} multiply(add.148, reshape.191)
  add.193 = f64[32768,32]{1,0} add(multiply.189, multiply.192)
  constant.60 = f64[] constant(1)
  broadcast.61 = f64[32768,32]{1,0} broadcast(constant.60), dimensions={}
  divide.149 = f64[32768,32]{1,0} divide(subtract.96, broadcast.65)
  subtract.150 = f64[32768,32]{1,0} subtract(broadcast.61, divide.149)
  constant.58 = f64[] constant(5)
  broadcast.59 = f64[32768,32]{1,0} broadcast(constant.58), dimensions={}
  multiply.151 = f64[32768,32]{1,0} multiply(multiply.125, broadcast.59)
  constant.56 = f64[] constant(4)
  broadcast.57 = f64[32768,32]{1,0} broadcast(constant.56), dimensions={}
  divide.152 = f64[32768,32]{1,0} divide(multiply.151, broadcast.57)
  subtract.153 = f64[32768,32]{1,0} subtract(subtract.150, divide.152)
  multiply.154 = f64[32768,32]{1,0} multiply(multiply.126, broadcast.59)
  constant.54 = f64[] constant(12)
  broadcast.55 = f64[32768,32]{1,0} broadcast(constant.54), dimensions={}
  divide.155 = f64[32768,32]{1,0} divide(multiply.154, broadcast.55)
  add.156 = f64[32768,32]{1,0} add(subtract.153, divide.155)
  divide.157 = f64[32768,32]{1,0} divide(multiply.127, broadcast.57)
  add.158 = f64[32768,32]{1,0} add(add.156, divide.157)
  divide.159 = f64[32768,32]{1,0} divide(multiply.128, broadcast.55)
  subtract.160 = f64[32768,32]{1,0} subtract(add.158, divide.159)
  slice.194 = f64[32768,32,1]{2,1,0} slice(reshape.124), slice={[0:32768], [0:32], [2:3]}
  reshape.195 = f64[32768,32]{1,0} reshape(slice.194)
  multiply.196 = f64[32768,32]{1,0} multiply(subtract.160, reshape.195)
  add.197 = f64[32768,32]{1,0} add(add.193, multiply.196)
  multiply.161 = f64[32768,32]{1,0} multiply(multiply.125, broadcast.67)
  divide.162 = f64[32768,32]{1,0} divide(multiply.161, broadcast.65)
  add.163 = f64[32768,32]{1,0} add(subtract.96, divide.162)
  constant.52 = f64[] constant(7)
  broadcast.53 = f64[32768,32]{1,0} broadcast(constant.52), dimensions={}
  multiply.164 = f64[32768,32]{1,0} multiply(multiply.126, broadcast.53)
  divide.165 = f64[32768,32]{1,0} divide(multiply.164, broadcast.55)
  subtract.166 = f64[32768,32]{1,0} subtract(add.163, divide.165)
  divide.167 = f64[32768,32]{1,0} divide(multiply.127, broadcast.63)
  subtract.168 = f64[32768,32]{1,0} subtract(subtract.166, divide.167)
  divide.169 = f64[32768,32]{1,0} divide(multiply.128, broadcast.55)
  add.170 = f64[32768,32]{1,0} add(subtract.168, divide.169)
  slice.198 = f64[32768,32,1]{2,1,0} slice(reshape.124), slice={[0:32768], [0:32], [3:4]}
  reshape.199 = f64[32768,32]{1,0} reshape(slice.198)
  multiply.200 = f64[32768,32]{1,0} multiply(add.170, reshape.199)
  add.201 = f64[32768,32]{1,0} add(add.197, multiply.200)
  divide.171 = f64[32768,32]{1,0} divide(subtract.96, broadcast.57)
  negate.172 = f64[32768,32]{1,0} negate(divide.171)
  divide.173 = f64[32768,32]{1,0} divide(multiply.125, broadcast.71)
  subtract.174 = f64[32768,32]{1,0} subtract(negate.172, divide.173)
  multiply.175 = f64[32768,32]{1,0} multiply(multiply.126, broadcast.53)
  divide.176 = f64[32768,32]{1,0} divide(multiply.175, broadcast.71)
  add.177 = f64[32768,32]{1,0} add(subtract.174, divide.176)
  divide.178 = f64[32768,32]{1,0} divide(multiply.127, broadcast.71)
  add.179 = f64[32768,32]{1,0} add(add.177, divide.178)
  divide.180 = f64[32768,32]{1,0} divide(multiply.128, broadcast.71)
  subtract.181 = f64[32768,32]{1,0} subtract(add.179, divide.180)
  slice.202 = f64[32768,32,1]{2,1,0} slice(reshape.124), slice={[0:32768], [0:32], [4:5]}
  reshape.203 = f64[32768,32]{1,0} reshape(slice.202)
  multiply.204 = f64[32768,32]{1,0} multiply(subtract.181, reshape.203)
  add.205 = f64[32768,32]{1,0} add(add.201, multiply.204)
  constant.50 = f64[] constant(30)
  broadcast.51 = f64[32768,32]{1,0} broadcast(constant.50), dimensions={}
  divide.182 = f64[32768,32]{1,0} divide(subtract.96, broadcast.51)
  divide.183 = f64[32768,32]{1,0} divide(multiply.126, broadcast.71)
  subtract.184 = f64[32768,32]{1,0} subtract(divide.182, divide.183)
  divide.185 = f64[32768,32]{1,0} divide(multiply.128, broadcast.69)
  add.186 = f64[32768,32]{1,0} add(subtract.184, divide.185)
  slice.206 = f64[32768,32,1]{2,1,0} slice(reshape.124), slice={[0:32768], [0:32], [5:6]}
  reshape.207 = f64[32768,32]{1,0} reshape(slice.206)
  multiply.208 = f64[32768,32]{1,0} multiply(add.186, reshape.207)
  ROOT add.209 = f64[32768,32]{1,0} add(add.205, multiply.208)
}

_where.218 {
  Arg_0.219 = pred[] parameter(0)
  Arg_1.220 = s32[] parameter(1)
  Arg_2.221 = s32[] parameter(2)
  ROOT select.222 = s32[] select(Arg_0.219, Arg_1.220, Arg_2.221)
}

remainder.223 {
  Arg_0.224 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.225 = s64[] parameter(1)
  convert.230 = s32[] convert(Arg_1.225)
  constant.229 = s32[] constant(0)
  compare.231 = pred[] compare(convert.230, constant.229), direction=EQ
  constant.228 = s32[] constant(1)
  call.232 = s32[] call(compare.231, constant.228, convert.230), to_apply=_where.218
  broadcast.233 = s32[32768,32,6]{2,1,0} broadcast(call.232), dimensions={}
  remainder.234 = s32[32768,32,6]{2,1,0} remainder(Arg_0.224, broadcast.233)
  constant.226 = s32[] constant(0)
  broadcast.227 = s32[32768,32,6]{2,1,0} broadcast(constant.226), dimensions={}
  compare.236 = pred[32768,32,6]{2,1,0} compare(remainder.234, broadcast.227), direction=LT
  compare.237 = pred[] compare(call.232, constant.229), direction=LT
  broadcast.238 = pred[32768,32,6]{2,1,0} broadcast(compare.237), dimensions={}
  compare.239 = pred[32768,32,6]{2,1,0} compare(compare.236, broadcast.238), direction=NE
  compare.235 = pred[32768,32,6]{2,1,0} compare(remainder.234, broadcast.227), direction=NE
  and.240 = pred[32768,32,6]{2,1,0} and(compare.239, compare.235)
  broadcast.241 = s32[32768,32,6]{2,1,0} broadcast(call.232), dimensions={}
  add.242 = s32[32768,32,6]{2,1,0} add(remainder.234, broadcast.241)
  ROOT select.243 = s32[32768,32,6]{2,1,0} select(and.240, add.242, remainder.234)
}

advect_1d_vectorized.244 {
  iota.281 = f64[32]{0} iota(), iota_dimension=0
  reshape.287 = f64[1,32]{1,0} reshape(iota.281)
  broadcast.288 = f64[1,32]{1,0} broadcast(reshape.287), dimensions={0,1}
  reshape.289 = f64[32]{0} reshape(broadcast.288)
  broadcast.290 = f64[32768,32]{1,0} broadcast(reshape.289), dimensions={1}
  Arg_1.246 = f64[32768]{0} parameter(1)
  reshape.282 = f64[32768,1]{1,0} reshape(Arg_1.246)
  Arg_2.247 = f64[] parameter(2)
  broadcast.283 = f64[32768,1]{1,0} broadcast(Arg_2.247), dimensions={}
  multiply.284 = f64[32768,1]{1,0} multiply(reshape.282, broadcast.283)
  Arg_3.248 = f64[] parameter(3)
  broadcast.285 = f64[32768,1]{1,0} broadcast(Arg_3.248), dimensions={}
  divide.286 = f64[32768,1]{1,0} divide(multiply.284, broadcast.285)
  broadcast.291 = f64[32768,1]{1,0} broadcast(divide.286), dimensions={0,1}
  reshape.292 = f64[32768]{0} reshape(broadcast.291)
  broadcast.293 = f64[32768,32]{1,0} broadcast(reshape.292), dimensions={0}
  subtract.294 = f64[32768,32]{1,0} subtract(broadcast.290, broadcast.293)
  floor.295 = f64[32768,32]{1,0} floor(subtract.294)
  subtract.296 = f64[32768,32]{1,0} subtract(subtract.294, floor.295)
  constant.272 = f64[] constant(20)
  broadcast.273 = f64[32768,32]{1,0} broadcast(constant.272), dimensions={}
  divide.329 = f64[32768,32]{1,0} divide(subtract.296, broadcast.273)
  multiply.325 = f64[32768,32]{1,0} multiply(subtract.296, subtract.296)
  constant.270 = f64[] constant(24)
  broadcast.271 = f64[32768,32]{1,0} broadcast(constant.270), dimensions={}
  divide.330 = f64[32768,32]{1,0} divide(multiply.325, broadcast.271)
  subtract.331 = f64[32768,32]{1,0} subtract(divide.329, divide.330)
  multiply.326 = f64[32768,32]{1,0} multiply(multiply.325, subtract.296)
  divide.332 = f64[32768,32]{1,0} divide(multiply.326, broadcast.271)
  subtract.333 = f64[32768,32]{1,0} subtract(subtract.331, divide.332)
  multiply.327 = f64[32768,32]{1,0} multiply(multiply.326, subtract.296)
  divide.334 = f64[32768,32]{1,0} divide(multiply.327, broadcast.271)
  add.335 = f64[32768,32]{1,0} add(subtract.333, divide.334)
  multiply.328 = f64[32768,32]{1,0} multiply(multiply.327, subtract.296)
  constant.268 = f64[] constant(120)
  broadcast.269 = f64[32768,32]{1,0} broadcast(constant.268), dimensions={}
  divide.336 = f64[32768,32]{1,0} divide(multiply.328, broadcast.269)
  subtract.337 = f64[32768,32]{1,0} subtract(add.335, divide.336)
  Arg_0.245 = f64[32768,32]{1,0} parameter(0)
  reshape.316 = f64[1048576]{0} reshape(Arg_0.245)
  iota.308 = s64[32768]{0} iota(), iota_dimension=0
  reshape.309 = s64[32768,1,1]{2,1,0} reshape(iota.308)
  constant.278 = s64[] constant(32)
  broadcast.279 = s64[32768,1,1]{2,1,0} broadcast(constant.278), dimensions={}
  multiply.310 = s64[32768,1,1]{2,1,0} multiply(reshape.309, broadcast.279)
  broadcast.312 = s64[32768,1,1]{2,1,0} broadcast(multiply.310), dimensions={0,1,2}
  reshape.313 = s64[32768]{0} reshape(broadcast.312)
  broadcast.314 = s64[32768,32,6]{2,1,0} broadcast(reshape.313), dimensions={0}
  convert.297 = s32[32768,32]{1,0} convert(floor.295)
  reshape.298 = s32[32768,32,1]{2,1,0} reshape(convert.297)
  broadcast.300 = s32[32768,32,1]{2,1,0} broadcast(reshape.298), dimensions={0,1,2}
  reshape.301 = s32[32768,32]{1,0} reshape(broadcast.300)
  broadcast.302 = s32[32768,32,6]{2,1,0} broadcast(reshape.301), dimensions={0,1}
  Arg_4.249 = s32[6]{0} parameter(4)
  reshape.299 = s32[1,1,6]{2,1,0} reshape(Arg_4.249)
  broadcast.303 = s32[1,1,6]{2,1,0} broadcast(reshape.299), dimensions={0,1,2}
  reshape.304 = s32[6]{0} reshape(broadcast.303)
  broadcast.305 = s32[32768,32,6]{2,1,0} broadcast(reshape.304), dimensions={2}
  add.306 = s32[32768,32,6]{2,1,0} add(broadcast.302, broadcast.305)
  constant.280 = s64[] constant(32)
  call.307 = s32[32768,32,6]{2,1,0} call(add.306, constant.280), to_apply=remainder.223
  convert.311 = s64[32768,32,6]{2,1,0} convert(call.307)
  add.315 = s64[32768,32,6]{2,1,0} add(broadcast.314, convert.311)
  reshape.317 = s64[6291456]{0} reshape(add.315)
  constant.276 = s64[] constant(0)
  broadcast.277 = s64[6291456]{0} broadcast(constant.276), dimensions={}
  compare.318 = pred[6291456]{0} compare(reshape.317, broadcast.277), direction=LT
  constant.274 = s64[] constant(1048576)
  broadcast.275 = s64[6291456]{0} broadcast(constant.274), dimensions={}
  add.319 = s64[6291456]{0} add(reshape.317, broadcast.275)
  select.320 = s64[6291456]{0} select(compare.318, add.319, reshape.317)
  convert.321 = s32[6291456]{0} convert(select.320)
  reshape.322 = s32[6291456,1]{1,0} reshape(convert.321)
  gather.323 = f64[6291456]{0} gather(reshape.316, reshape.322), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.324 = f64[32768,32,6]{2,1,0} reshape(gather.323)
  slice.387 = f64[32768,32,1]{2,1,0} slice(reshape.324), slice={[0:32768], [0:32], [0:1]}
  reshape.388 = f64[32768,32]{1,0} reshape(slice.387)
  multiply.389 = f64[32768,32]{1,0} multiply(subtract.337, reshape.388)
  constant.266 = f64[] constant(2)
  broadcast.267 = f64[32768,32]{1,0} broadcast(constant.266), dimensions={}
  divide.338 = f64[32768,32]{1,0} divide(subtract.296, broadcast.267)
  negate.339 = f64[32768,32]{1,0} negate(divide.338)
  multiply.340 = f64[32768,32]{1,0} multiply(multiply.325, broadcast.267)
  constant.264 = f64[] constant(3)
  broadcast.265 = f64[32768,32]{1,0} broadcast(constant.264), dimensions={}
  divide.341 = f64[32768,32]{1,0} divide(multiply.340, broadcast.265)
  add.342 = f64[32768,32]{1,0} add(negate.339, divide.341)
  divide.343 = f64[32768,32]{1,0} divide(multiply.326, broadcast.271)
  subtract.344 = f64[32768,32]{1,0} subtract(add.342, divide.343)
  constant.262 = f64[] constant(6)
  broadcast.263 = f64[32768,32]{1,0} broadcast(constant.262), dimensions={}
  divide.345 = f64[32768,32]{1,0} divide(multiply.327, broadcast.263)
  subtract.346 = f64[32768,32]{1,0} subtract(subtract.344, divide.345)
  divide.347 = f64[32768,32]{1,0} divide(multiply.328, broadcast.271)
  add.348 = f64[32768,32]{1,0} add(subtract.346, divide.347)
  slice.390 = f64[32768,32,1]{2,1,0} slice(reshape.324), slice={[0:32768], [0:32], [1:2]}
  reshape.391 = f64[32768,32]{1,0} reshape(slice.390)
  multiply.392 = f64[32768,32]{1,0} multiply(add.348, reshape.391)
  add.393 = f64[32768,32]{1,0} add(multiply.389, multiply.392)
  constant.260 = f64[] constant(1)
  broadcast.261 = f64[32768,32]{1,0} broadcast(constant.260), dimensions={}
  divide.349 = f64[32768,32]{1,0} divide(subtract.296, broadcast.265)
  subtract.350 = f64[32768,32]{1,0} subtract(broadcast.261, divide.349)
  constant.258 = f64[] constant(5)
  broadcast.259 = f64[32768,32]{1,0} broadcast(constant.258), dimensions={}
  multiply.351 = f64[32768,32]{1,0} multiply(multiply.325, broadcast.259)
  constant.256 = f64[] constant(4)
  broadcast.257 = f64[32768,32]{1,0} broadcast(constant.256), dimensions={}
  divide.352 = f64[32768,32]{1,0} divide(multiply.351, broadcast.257)
  subtract.353 = f64[32768,32]{1,0} subtract(subtract.350, divide.352)
  multiply.354 = f64[32768,32]{1,0} multiply(multiply.326, broadcast.259)
  constant.254 = f64[] constant(12)
  broadcast.255 = f64[32768,32]{1,0} broadcast(constant.254), dimensions={}
  divide.355 = f64[32768,32]{1,0} divide(multiply.354, broadcast.255)
  add.356 = f64[32768,32]{1,0} add(subtract.353, divide.355)
  divide.357 = f64[32768,32]{1,0} divide(multiply.327, broadcast.257)
  add.358 = f64[32768,32]{1,0} add(add.356, divide.357)
  divide.359 = f64[32768,32]{1,0} divide(multiply.328, broadcast.255)
  subtract.360 = f64[32768,32]{1,0} subtract(add.358, divide.359)
  slice.394 = f64[32768,32,1]{2,1,0} slice(reshape.324), slice={[0:32768], [0:32], [2:3]}
  reshape.395 = f64[32768,32]{1,0} reshape(slice.394)
  multiply.396 = f64[32768,32]{1,0} multiply(subtract.360, reshape.395)
  add.397 = f64[32768,32]{1,0} add(add.393, multiply.396)
  multiply.361 = f64[32768,32]{1,0} multiply(multiply.325, broadcast.267)
  divide.362 = f64[32768,32]{1,0} divide(multiply.361, broadcast.265)
  add.363 = f64[32768,32]{1,0} add(subtract.296, divide.362)
  constant.252 = f64[] constant(7)
  broadcast.253 = f64[32768,32]{1,0} broadcast(constant.252), dimensions={}
  multiply.364 = f64[32768,32]{1,0} multiply(multiply.326, broadcast.253)
  divide.365 = f64[32768,32]{1,0} divide(multiply.364, broadcast.255)
  subtract.366 = f64[32768,32]{1,0} subtract(add.363, divide.365)
  divide.367 = f64[32768,32]{1,0} divide(multiply.327, broadcast.263)
  subtract.368 = f64[32768,32]{1,0} subtract(subtract.366, divide.367)
  divide.369 = f64[32768,32]{1,0} divide(multiply.328, broadcast.255)
  add.370 = f64[32768,32]{1,0} add(subtract.368, divide.369)
  slice.398 = f64[32768,32,1]{2,1,0} slice(reshape.324), slice={[0:32768], [0:32], [3:4]}
  reshape.399 = f64[32768,32]{1,0} reshape(slice.398)
  multiply.400 = f64[32768,32]{1,0} multiply(add.370, reshape.399)
  add.401 = f64[32768,32]{1,0} add(add.397, multiply.400)
  divide.371 = f64[32768,32]{1,0} divide(subtract.296, broadcast.257)
  negate.372 = f64[32768,32]{1,0} negate(divide.371)
  divide.373 = f64[32768,32]{1,0} divide(multiply.325, broadcast.271)
  subtract.374 = f64[32768,32]{1,0} subtract(negate.372, divide.373)
  multiply.375 = f64[32768,32]{1,0} multiply(multiply.326, broadcast.253)
  divide.376 = f64[32768,32]{1,0} divide(multiply.375, broadcast.271)
  add.377 = f64[32768,32]{1,0} add(subtract.374, divide.376)
  divide.378 = f64[32768,32]{1,0} divide(multiply.327, broadcast.271)
  add.379 = f64[32768,32]{1,0} add(add.377, divide.378)
  divide.380 = f64[32768,32]{1,0} divide(multiply.328, broadcast.271)
  subtract.381 = f64[32768,32]{1,0} subtract(add.379, divide.380)
  slice.402 = f64[32768,32,1]{2,1,0} slice(reshape.324), slice={[0:32768], [0:32], [4:5]}
  reshape.403 = f64[32768,32]{1,0} reshape(slice.402)
  multiply.404 = f64[32768,32]{1,0} multiply(subtract.381, reshape.403)
  add.405 = f64[32768,32]{1,0} add(add.401, multiply.404)
  constant.250 = f64[] constant(30)
  broadcast.251 = f64[32768,32]{1,0} broadcast(constant.250), dimensions={}
  divide.382 = f64[32768,32]{1,0} divide(subtract.296, broadcast.251)
  divide.383 = f64[32768,32]{1,0} divide(multiply.326, broadcast.271)
  subtract.384 = f64[32768,32]{1,0} subtract(divide.382, divide.383)
  divide.385 = f64[32768,32]{1,0} divide(multiply.328, broadcast.269)
  add.386 = f64[32768,32]{1,0} add(subtract.384, divide.385)
  slice.406 = f64[32768,32,1]{2,1,0} slice(reshape.324), slice={[0:32768], [0:32], [5:6]}
  reshape.407 = f64[32768,32]{1,0} reshape(slice.406)
  multiply.408 = f64[32768,32]{1,0} multiply(add.386, reshape.407)
  ROOT add.409 = f64[32768,32]{1,0} add(add.405, multiply.408)
}

region_0.413 {
  Arg_0.414 = f64[] parameter(0)
  Arg_1.415 = f64[] parameter(1)
  ROOT add.416 = f64[] add(Arg_0.414, Arg_1.415)
}

fft.417 {
  Arg_0.418 = f64[32,32]{1,0} parameter(0)
  ROOT fft.419 = c128[32,17]{1,0} fft(Arg_0.418), fft_type=RFFT, fft_length={32,32}
}

fft_0.420 {
  Arg_0.421 = c128[32,17]{1,0} parameter(0)
  ROOT fft.422 = f64[32,32]{1,0} fft(Arg_0.421), fft_type=IRFFT, fft_length={32,32}
}

fft_0.423 {
  Arg_0.424 = c128[32,17]{1,0} parameter(0)
  ROOT fft.425 = f64[32,32]{1,0} fft(Arg_0.424), fft_type=IRFFT, fft_length={32,32}
}

fft_0.426 {
  Arg_0.427 = c128[32,17]{1,0} parameter(0)
  ROOT fft.428 = f64[32,32]{1,0} fft(Arg_0.427), fft_type=IRFFT, fft_length={32,32}
}

solve_poisson.429 {
  Arg_1.431 = f64[32,1]{1,0} parameter(1)
  convert.453 = c128[32,1]{1,0} convert(Arg_1.431)
  constant.438 = c128[] constant((-0, -1))
  broadcast.439 = c128[32,1]{1,0} broadcast(constant.438), dimensions={}
  multiply.454 = c128[32,1]{1,0} multiply(convert.453, broadcast.439)
  broadcast.455 = c128[32,1]{1,0} broadcast(multiply.454), dimensions={0,1}
  reshape.456 = c128[32]{0} reshape(broadcast.455)
  broadcast.457 = c128[32,17]{1,0} broadcast(reshape.456), dimensions={0}
  Arg_0.430 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  constant.442 = f64[] constant(0)
  reduce.443 = f64[32,32]{1,0} reduce(Arg_0.430, constant.442), dimensions={2,3}, to_apply=region_0.413
  Arg_4.434 = f64[] parameter(4)
  broadcast.444 = f64[32,32]{1,0} broadcast(Arg_4.434), dimensions={}
  multiply.445 = f64[32,32]{1,0} multiply(reduce.443, broadcast.444)
  Arg_5.435 = f64[] parameter(5)
  broadcast.446 = f64[32,32]{1,0} broadcast(Arg_5.435), dimensions={}
  multiply.447 = f64[32,32]{1,0} multiply(multiply.445, broadcast.446)
  constant.440 = f64[] constant(1)
  broadcast.441 = f64[32,32]{1,0} broadcast(constant.440), dimensions={}
  subtract.448 = f64[32,32]{1,0} subtract(multiply.447, broadcast.441)
  call.449 = c128[32,17]{1,0} call(subtract.448), to_apply=fft.417
  Arg_3.433 = f64[32,17]{1,0} parameter(3)
  convert.450 = c128[32,17]{1,0} convert(Arg_3.433)
  multiply.451 = c128[32,17]{1,0} multiply(call.449, convert.450)
  multiply.458 = c128[32,17]{1,0} multiply(broadcast.457, multiply.451)
  call.465 = f64[32,32]{1,0} call(multiply.458), to_apply=fft_0.423
  Arg_2.432 = f64[1,17]{1,0} parameter(2)
  convert.459 = c128[1,17]{1,0} convert(Arg_2.432)
  constant.436 = c128[] constant((-0, -1))
  broadcast.437 = c128[1,17]{1,0} broadcast(constant.436), dimensions={}
  multiply.460 = c128[1,17]{1,0} multiply(convert.459, broadcast.437)
  broadcast.461 = c128[1,17]{1,0} broadcast(multiply.460), dimensions={0,1}
  reshape.462 = c128[17]{0} reshape(broadcast.461)
  broadcast.463 = c128[32,17]{1,0} broadcast(reshape.462), dimensions={1}
  multiply.464 = c128[32,17]{1,0} multiply(broadcast.463, multiply.451)
  call.466 = f64[32,32]{1,0} call(multiply.464), to_apply=fft_0.426
  call.452 = f64[32,32]{1,0} call(multiply.451), to_apply=fft_0.420
  ROOT tuple.467 = (f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(call.465, call.466, subtract.448, call.452)
}

clip.480 {
  Arg_2.483 = s64[] parameter(2)
  convert.487 = s32[] convert(Arg_2.483)
  broadcast.488 = s32[32768,32,6]{2,1,0} broadcast(convert.487), dimensions={}
  Arg_1.482 = s64[] parameter(1)
  convert.484 = s32[] convert(Arg_1.482)
  broadcast.485 = s32[32768,32,6]{2,1,0} broadcast(convert.484), dimensions={}
  Arg_0.481 = s32[32768,32,6]{2,1,0} parameter(0)
  maximum.486 = s32[32768,32,6]{2,1,0} maximum(broadcast.485, Arg_0.481)
  ROOT minimum.489 = s32[32768,32,6]{2,1,0} minimum(broadcast.488, maximum.486)
}

_where_2.490 {
  Arg_0.491 = pred[32768,32,6]{2,1,0} parameter(0)
  Arg_1.492 = f64[32768,32,6]{2,1,0} parameter(1)
  Arg_2.493 = f64[] parameter(2)
  broadcast.494 = f64[32768,32,6]{2,1,0} broadcast(Arg_2.493), dimensions={}
  ROOT select.495 = f64[32768,32,6]{2,1,0} select(Arg_0.491, Arg_1.492, broadcast.494)
}

advect_1d_vectorized_1.496 {
  iota.539 = f64[32]{0} iota(), iota_dimension=0
  reshape.545 = f64[1,32]{1,0} reshape(iota.539)
  broadcast.546 = f64[1,32]{1,0} broadcast(reshape.545), dimensions={0,1}
  reshape.547 = f64[32]{0} reshape(broadcast.546)
  broadcast.548 = f64[32768,32]{1,0} broadcast(reshape.547), dimensions={1}
  Arg_1.498 = f64[32768]{0} parameter(1)
  reshape.540 = f64[32768,1]{1,0} reshape(Arg_1.498)
  Arg_2.499 = f64[] parameter(2)
  broadcast.541 = f64[32768,1]{1,0} broadcast(Arg_2.499), dimensions={}
  multiply.542 = f64[32768,1]{1,0} multiply(reshape.540, broadcast.541)
  Arg_3.500 = f64[] parameter(3)
  broadcast.543 = f64[32768,1]{1,0} broadcast(Arg_3.500), dimensions={}
  divide.544 = f64[32768,1]{1,0} divide(multiply.542, broadcast.543)
  broadcast.549 = f64[32768,1]{1,0} broadcast(divide.544), dimensions={0,1}
  reshape.550 = f64[32768]{0} reshape(broadcast.549)
  broadcast.551 = f64[32768,32]{1,0} broadcast(reshape.550), dimensions={0}
  subtract.552 = f64[32768,32]{1,0} subtract(broadcast.548, broadcast.551)
  floor.553 = f64[32768,32]{1,0} floor(subtract.552)
  subtract.554 = f64[32768,32]{1,0} subtract(subtract.552, floor.553)
  constant.524 = f64[] constant(20)
  broadcast.525 = f64[32768,32]{1,0} broadcast(constant.524), dimensions={}
  divide.591 = f64[32768,32]{1,0} divide(subtract.554, broadcast.525)
  multiply.587 = f64[32768,32]{1,0} multiply(subtract.554, subtract.554)
  constant.522 = f64[] constant(24)
  broadcast.523 = f64[32768,32]{1,0} broadcast(constant.522), dimensions={}
  divide.592 = f64[32768,32]{1,0} divide(multiply.587, broadcast.523)
  subtract.593 = f64[32768,32]{1,0} subtract(divide.591, divide.592)
  multiply.588 = f64[32768,32]{1,0} multiply(multiply.587, subtract.554)
  divide.594 = f64[32768,32]{1,0} divide(multiply.588, broadcast.523)
  subtract.595 = f64[32768,32]{1,0} subtract(subtract.593, divide.594)
  multiply.589 = f64[32768,32]{1,0} multiply(multiply.588, subtract.554)
  divide.596 = f64[32768,32]{1,0} divide(multiply.589, broadcast.523)
  add.597 = f64[32768,32]{1,0} add(subtract.595, divide.596)
  multiply.590 = f64[32768,32]{1,0} multiply(multiply.589, subtract.554)
  constant.520 = f64[] constant(120)
  broadcast.521 = f64[32768,32]{1,0} broadcast(constant.520), dimensions={}
  divide.598 = f64[32768,32]{1,0} divide(multiply.590, broadcast.521)
  subtract.599 = f64[32768,32]{1,0} subtract(add.597, divide.598)
  convert.555 = s32[32768,32]{1,0} convert(floor.553)
  reshape.556 = s32[32768,32,1]{2,1,0} reshape(convert.555)
  broadcast.558 = s32[32768,32,1]{2,1,0} broadcast(reshape.556), dimensions={0,1,2}
  reshape.559 = s32[32768,32]{1,0} reshape(broadcast.558)
  broadcast.560 = s32[32768,32,6]{2,1,0} broadcast(reshape.559), dimensions={0,1}
  Arg_4.501 = s32[6]{0} parameter(4)
  reshape.557 = s32[1,1,6]{2,1,0} reshape(Arg_4.501)
  broadcast.561 = s32[1,1,6]{2,1,0} broadcast(reshape.557), dimensions={0,1,2}
  reshape.562 = s32[6]{0} reshape(broadcast.561)
  broadcast.563 = s32[32768,32,6]{2,1,0} broadcast(reshape.562), dimensions={2}
  add.564 = s32[32768,32,6]{2,1,0} add(broadcast.560, broadcast.563)
  constant.534 = s32[] constant(0)
  broadcast.535 = s32[32768,32,6]{2,1,0} broadcast(constant.534), dimensions={}
  compare.565 = pred[32768,32,6]{2,1,0} compare(add.564, broadcast.535), direction=GE
  constant.532 = s32[] constant(32)
  broadcast.533 = s32[32768,32,6]{2,1,0} broadcast(constant.532), dimensions={}
  compare.566 = pred[32768,32,6]{2,1,0} compare(add.564, broadcast.533), direction=LT
  and.567 = pred[32768,32,6]{2,1,0} and(compare.565, compare.566)
  Arg_0.497 = f64[32768,32]{1,0} parameter(0)
  reshape.577 = f64[1048576]{0} reshape(Arg_0.497)
  iota.569 = s64[32768]{0} iota(), iota_dimension=0
  reshape.570 = s64[32768,1,1]{2,1,0} reshape(iota.569)
  constant.530 = s64[] constant(32)
  broadcast.531 = s64[32768,1,1]{2,1,0} broadcast(constant.530), dimensions={}
  multiply.571 = s64[32768,1,1]{2,1,0} multiply(reshape.570, broadcast.531)
  broadcast.573 = s64[32768,1,1]{2,1,0} broadcast(multiply.571), dimensions={0,1,2}
  reshape.574 = s64[32768]{0} reshape(broadcast.573)
  broadcast.575 = s64[32768,32,6]{2,1,0} broadcast(reshape.574), dimensions={0}
  constant.538 = s64[] constant(0)
  constant.537 = s64[] constant(31)
  call.568 = s32[32768,32,6]{2,1,0} call(add.564, constant.538, constant.537), to_apply=clip.480
  convert.572 = s64[32768,32,6]{2,1,0} convert(call.568)
  add.576 = s64[32768,32,6]{2,1,0} add(broadcast.575, convert.572)
  reshape.578 = s64[6291456]{0} reshape(add.576)
  constant.528 = s64[] constant(0)
  broadcast.529 = s64[6291456]{0} broadcast(constant.528), dimensions={}
  compare.579 = pred[6291456]{0} compare(reshape.578, broadcast.529), direction=LT
  constant.526 = s64[] constant(1048576)
  broadcast.527 = s64[6291456]{0} broadcast(constant.526), dimensions={}
  add.580 = s64[6291456]{0} add(reshape.578, broadcast.527)
  select.581 = s64[6291456]{0} select(compare.579, add.580, reshape.578)
  convert.582 = s32[6291456]{0} convert(select.581)
  reshape.583 = s32[6291456,1]{1,0} reshape(convert.582)
  gather.584 = f64[6291456]{0} gather(reshape.577, reshape.583), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.585 = f64[32768,32,6]{2,1,0} reshape(gather.584)
  constant.536 = f64[] constant(0)
  call.586 = f64[32768,32,6]{2,1,0} call(and.567, reshape.585, constant.536), to_apply=_where_2.490
  slice.649 = f64[32768,32,1]{2,1,0} slice(call.586), slice={[0:32768], [0:32], [0:1]}
  reshape.650 = f64[32768,32]{1,0} reshape(slice.649)
  multiply.651 = f64[32768,32]{1,0} multiply(subtract.599, reshape.650)
  constant.518 = f64[] constant(2)
  broadcast.519 = f64[32768,32]{1,0} broadcast(constant.518), dimensions={}
  divide.600 = f64[32768,32]{1,0} divide(subtract.554, broadcast.519)
  negate.601 = f64[32768,32]{1,0} negate(divide.600)
  multiply.602 = f64[32768,32]{1,0} multiply(multiply.587, broadcast.519)
  constant.516 = f64[] constant(3)
  broadcast.517 = f64[32768,32]{1,0} broadcast(constant.516), dimensions={}
  divide.603 = f64[32768,32]{1,0} divide(multiply.602, broadcast.517)
  add.604 = f64[32768,32]{1,0} add(negate.601, divide.603)
  divide.605 = f64[32768,32]{1,0} divide(multiply.588, broadcast.523)
  subtract.606 = f64[32768,32]{1,0} subtract(add.604, divide.605)
  constant.514 = f64[] constant(6)
  broadcast.515 = f64[32768,32]{1,0} broadcast(constant.514), dimensions={}
  divide.607 = f64[32768,32]{1,0} divide(multiply.589, broadcast.515)
  subtract.608 = f64[32768,32]{1,0} subtract(subtract.606, divide.607)
  divide.609 = f64[32768,32]{1,0} divide(multiply.590, broadcast.523)
  add.610 = f64[32768,32]{1,0} add(subtract.608, divide.609)
  slice.652 = f64[32768,32,1]{2,1,0} slice(call.586), slice={[0:32768], [0:32], [1:2]}
  reshape.653 = f64[32768,32]{1,0} reshape(slice.652)
  multiply.654 = f64[32768,32]{1,0} multiply(add.610, reshape.653)
  add.655 = f64[32768,32]{1,0} add(multiply.651, multiply.654)
  constant.512 = f64[] constant(1)
  broadcast.513 = f64[32768,32]{1,0} broadcast(constant.512), dimensions={}
  divide.611 = f64[32768,32]{1,0} divide(subtract.554, broadcast.517)
  subtract.612 = f64[32768,32]{1,0} subtract(broadcast.513, divide.611)
  constant.510 = f64[] constant(5)
  broadcast.511 = f64[32768,32]{1,0} broadcast(constant.510), dimensions={}
  multiply.613 = f64[32768,32]{1,0} multiply(multiply.587, broadcast.511)
  constant.508 = f64[] constant(4)
  broadcast.509 = f64[32768,32]{1,0} broadcast(constant.508), dimensions={}
  divide.614 = f64[32768,32]{1,0} divide(multiply.613, broadcast.509)
  subtract.615 = f64[32768,32]{1,0} subtract(subtract.612, divide.614)
  multiply.616 = f64[32768,32]{1,0} multiply(multiply.588, broadcast.511)
  constant.506 = f64[] constant(12)
  broadcast.507 = f64[32768,32]{1,0} broadcast(constant.506), dimensions={}
  divide.617 = f64[32768,32]{1,0} divide(multiply.616, broadcast.507)
  add.618 = f64[32768,32]{1,0} add(subtract.615, divide.617)
  divide.619 = f64[32768,32]{1,0} divide(multiply.589, broadcast.509)
  add.620 = f64[32768,32]{1,0} add(add.618, divide.619)
  divide.621 = f64[32768,32]{1,0} divide(multiply.590, broadcast.507)
  subtract.622 = f64[32768,32]{1,0} subtract(add.620, divide.621)
  slice.656 = f64[32768,32,1]{2,1,0} slice(call.586), slice={[0:32768], [0:32], [2:3]}
  reshape.657 = f64[32768,32]{1,0} reshape(slice.656)
  multiply.658 = f64[32768,32]{1,0} multiply(subtract.622, reshape.657)
  add.659 = f64[32768,32]{1,0} add(add.655, multiply.658)
  multiply.623 = f64[32768,32]{1,0} multiply(multiply.587, broadcast.519)
  divide.624 = f64[32768,32]{1,0} divide(multiply.623, broadcast.517)
  add.625 = f64[32768,32]{1,0} add(subtract.554, divide.624)
  constant.504 = f64[] constant(7)
  broadcast.505 = f64[32768,32]{1,0} broadcast(constant.504), dimensions={}
  multiply.626 = f64[32768,32]{1,0} multiply(multiply.588, broadcast.505)
  divide.627 = f64[32768,32]{1,0} divide(multiply.626, broadcast.507)
  subtract.628 = f64[32768,32]{1,0} subtract(add.625, divide.627)
  divide.629 = f64[32768,32]{1,0} divide(multiply.589, broadcast.515)
  subtract.630 = f64[32768,32]{1,0} subtract(subtract.628, divide.629)
  divide.631 = f64[32768,32]{1,0} divide(multiply.590, broadcast.507)
  add.632 = f64[32768,32]{1,0} add(subtract.630, divide.631)
  slice.660 = f64[32768,32,1]{2,1,0} slice(call.586), slice={[0:32768], [0:32], [3:4]}
  reshape.661 = f64[32768,32]{1,0} reshape(slice.660)
  multiply.662 = f64[32768,32]{1,0} multiply(add.632, reshape.661)
  add.663 = f64[32768,32]{1,0} add(add.659, multiply.662)
  divide.633 = f64[32768,32]{1,0} divide(subtract.554, broadcast.509)
  negate.634 = f64[32768,32]{1,0} negate(divide.633)
  divide.635 = f64[32768,32]{1,0} divide(multiply.587, broadcast.523)
  subtract.636 = f64[32768,32]{1,0} subtract(negate.634, divide.635)
  multiply.637 = f64[32768,32]{1,0} multiply(multiply.588, broadcast.505)
  divide.638 = f64[32768,32]{1,0} divide(multiply.637, broadcast.523)
  add.639 = f64[32768,32]{1,0} add(subtract.636, divide.638)
  divide.640 = f64[32768,32]{1,0} divide(multiply.589, broadcast.523)
  add.641 = f64[32768,32]{1,0} add(add.639, divide.640)
  divide.642 = f64[32768,32]{1,0} divide(multiply.590, broadcast.523)
  subtract.643 = f64[32768,32]{1,0} subtract(add.641, divide.642)
  slice.664 = f64[32768,32,1]{2,1,0} slice(call.586), slice={[0:32768], [0:32], [4:5]}
  reshape.665 = f64[32768,32]{1,0} reshape(slice.664)
  multiply.666 = f64[32768,32]{1,0} multiply(subtract.643, reshape.665)
  add.667 = f64[32768,32]{1,0} add(add.663, multiply.666)
  constant.502 = f64[] constant(30)
  broadcast.503 = f64[32768,32]{1,0} broadcast(constant.502), dimensions={}
  divide.644 = f64[32768,32]{1,0} divide(subtract.554, broadcast.503)
  divide.645 = f64[32768,32]{1,0} divide(multiply.588, broadcast.523)
  subtract.646 = f64[32768,32]{1,0} subtract(divide.644, divide.645)
  divide.647 = f64[32768,32]{1,0} divide(multiply.590, broadcast.521)
  add.648 = f64[32768,32]{1,0} add(subtract.646, divide.647)
  slice.668 = f64[32768,32,1]{2,1,0} slice(call.586), slice={[0:32768], [0:32], [5:6]}
  reshape.669 = f64[32768,32]{1,0} reshape(slice.668)
  multiply.670 = f64[32768,32]{1,0} multiply(add.648, reshape.669)
  ROOT add.671 = f64[32768,32]{1,0} add(add.667, multiply.670)
}

clip.681 {
  Arg_2.684 = s64[] parameter(2)
  convert.688 = s32[] convert(Arg_2.684)
  broadcast.689 = s32[32768,32,6]{2,1,0} broadcast(convert.688), dimensions={}
  Arg_1.683 = s64[] parameter(1)
  convert.685 = s32[] convert(Arg_1.683)
  broadcast.686 = s32[32768,32,6]{2,1,0} broadcast(convert.685), dimensions={}
  Arg_0.682 = s32[32768,32,6]{2,1,0} parameter(0)
  maximum.687 = s32[32768,32,6]{2,1,0} maximum(broadcast.686, Arg_0.682)
  ROOT minimum.690 = s32[32768,32,6]{2,1,0} minimum(broadcast.689, maximum.687)
}

_where_2.691 {
  Arg_0.692 = pred[32768,32,6]{2,1,0} parameter(0)
  Arg_1.693 = f64[32768,32,6]{2,1,0} parameter(1)
  Arg_2.694 = f64[] parameter(2)
  broadcast.695 = f64[32768,32,6]{2,1,0} broadcast(Arg_2.694), dimensions={}
  ROOT select.696 = f64[32768,32,6]{2,1,0} select(Arg_0.692, Arg_1.693, broadcast.695)
}

advect_1d_vectorized_1.697 {
  iota.740 = f64[32]{0} iota(), iota_dimension=0
  reshape.746 = f64[1,32]{1,0} reshape(iota.740)
  broadcast.747 = f64[1,32]{1,0} broadcast(reshape.746), dimensions={0,1}
  reshape.748 = f64[32]{0} reshape(broadcast.747)
  broadcast.749 = f64[32768,32]{1,0} broadcast(reshape.748), dimensions={1}
  Arg_1.699 = f64[32768]{0} parameter(1)
  reshape.741 = f64[32768,1]{1,0} reshape(Arg_1.699)
  Arg_2.700 = f64[] parameter(2)
  broadcast.742 = f64[32768,1]{1,0} broadcast(Arg_2.700), dimensions={}
  multiply.743 = f64[32768,1]{1,0} multiply(reshape.741, broadcast.742)
  Arg_3.701 = f64[] parameter(3)
  broadcast.744 = f64[32768,1]{1,0} broadcast(Arg_3.701), dimensions={}
  divide.745 = f64[32768,1]{1,0} divide(multiply.743, broadcast.744)
  broadcast.750 = f64[32768,1]{1,0} broadcast(divide.745), dimensions={0,1}
  reshape.751 = f64[32768]{0} reshape(broadcast.750)
  broadcast.752 = f64[32768,32]{1,0} broadcast(reshape.751), dimensions={0}
  subtract.753 = f64[32768,32]{1,0} subtract(broadcast.749, broadcast.752)
  floor.754 = f64[32768,32]{1,0} floor(subtract.753)
  subtract.755 = f64[32768,32]{1,0} subtract(subtract.753, floor.754)
  constant.725 = f64[] constant(20)
  broadcast.726 = f64[32768,32]{1,0} broadcast(constant.725), dimensions={}
  divide.792 = f64[32768,32]{1,0} divide(subtract.755, broadcast.726)
  multiply.788 = f64[32768,32]{1,0} multiply(subtract.755, subtract.755)
  constant.723 = f64[] constant(24)
  broadcast.724 = f64[32768,32]{1,0} broadcast(constant.723), dimensions={}
  divide.793 = f64[32768,32]{1,0} divide(multiply.788, broadcast.724)
  subtract.794 = f64[32768,32]{1,0} subtract(divide.792, divide.793)
  multiply.789 = f64[32768,32]{1,0} multiply(multiply.788, subtract.755)
  divide.795 = f64[32768,32]{1,0} divide(multiply.789, broadcast.724)
  subtract.796 = f64[32768,32]{1,0} subtract(subtract.794, divide.795)
  multiply.790 = f64[32768,32]{1,0} multiply(multiply.789, subtract.755)
  divide.797 = f64[32768,32]{1,0} divide(multiply.790, broadcast.724)
  add.798 = f64[32768,32]{1,0} add(subtract.796, divide.797)
  multiply.791 = f64[32768,32]{1,0} multiply(multiply.790, subtract.755)
  constant.721 = f64[] constant(120)
  broadcast.722 = f64[32768,32]{1,0} broadcast(constant.721), dimensions={}
  divide.799 = f64[32768,32]{1,0} divide(multiply.791, broadcast.722)
  subtract.800 = f64[32768,32]{1,0} subtract(add.798, divide.799)
  convert.756 = s32[32768,32]{1,0} convert(floor.754)
  reshape.757 = s32[32768,32,1]{2,1,0} reshape(convert.756)
  broadcast.759 = s32[32768,32,1]{2,1,0} broadcast(reshape.757), dimensions={0,1,2}
  reshape.760 = s32[32768,32]{1,0} reshape(broadcast.759)
  broadcast.761 = s32[32768,32,6]{2,1,0} broadcast(reshape.760), dimensions={0,1}
  Arg_4.702 = s32[6]{0} parameter(4)
  reshape.758 = s32[1,1,6]{2,1,0} reshape(Arg_4.702)
  broadcast.762 = s32[1,1,6]{2,1,0} broadcast(reshape.758), dimensions={0,1,2}
  reshape.763 = s32[6]{0} reshape(broadcast.762)
  broadcast.764 = s32[32768,32,6]{2,1,0} broadcast(reshape.763), dimensions={2}
  add.765 = s32[32768,32,6]{2,1,0} add(broadcast.761, broadcast.764)
  constant.735 = s32[] constant(0)
  broadcast.736 = s32[32768,32,6]{2,1,0} broadcast(constant.735), dimensions={}
  compare.766 = pred[32768,32,6]{2,1,0} compare(add.765, broadcast.736), direction=GE
  constant.733 = s32[] constant(32)
  broadcast.734 = s32[32768,32,6]{2,1,0} broadcast(constant.733), dimensions={}
  compare.767 = pred[32768,32,6]{2,1,0} compare(add.765, broadcast.734), direction=LT
  and.768 = pred[32768,32,6]{2,1,0} and(compare.766, compare.767)
  Arg_0.698 = f64[32768,32]{1,0} parameter(0)
  reshape.778 = f64[1048576]{0} reshape(Arg_0.698)
  iota.770 = s64[32768]{0} iota(), iota_dimension=0
  reshape.771 = s64[32768,1,1]{2,1,0} reshape(iota.770)
  constant.731 = s64[] constant(32)
  broadcast.732 = s64[32768,1,1]{2,1,0} broadcast(constant.731), dimensions={}
  multiply.772 = s64[32768,1,1]{2,1,0} multiply(reshape.771, broadcast.732)
  broadcast.774 = s64[32768,1,1]{2,1,0} broadcast(multiply.772), dimensions={0,1,2}
  reshape.775 = s64[32768]{0} reshape(broadcast.774)
  broadcast.776 = s64[32768,32,6]{2,1,0} broadcast(reshape.775), dimensions={0}
  constant.739 = s64[] constant(0)
  constant.738 = s64[] constant(31)
  call.769 = s32[32768,32,6]{2,1,0} call(add.765, constant.739, constant.738), to_apply=clip.681
  convert.773 = s64[32768,32,6]{2,1,0} convert(call.769)
  add.777 = s64[32768,32,6]{2,1,0} add(broadcast.776, convert.773)
  reshape.779 = s64[6291456]{0} reshape(add.777)
  constant.729 = s64[] constant(0)
  broadcast.730 = s64[6291456]{0} broadcast(constant.729), dimensions={}
  compare.780 = pred[6291456]{0} compare(reshape.779, broadcast.730), direction=LT
  constant.727 = s64[] constant(1048576)
  broadcast.728 = s64[6291456]{0} broadcast(constant.727), dimensions={}
  add.781 = s64[6291456]{0} add(reshape.779, broadcast.728)
  select.782 = s64[6291456]{0} select(compare.780, add.781, reshape.779)
  convert.783 = s32[6291456]{0} convert(select.782)
  reshape.784 = s32[6291456,1]{1,0} reshape(convert.783)
  gather.785 = f64[6291456]{0} gather(reshape.778, reshape.784), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.786 = f64[32768,32,6]{2,1,0} reshape(gather.785)
  constant.737 = f64[] constant(0)
  call.787 = f64[32768,32,6]{2,1,0} call(and.768, reshape.786, constant.737), to_apply=_where_2.691
  slice.850 = f64[32768,32,1]{2,1,0} slice(call.787), slice={[0:32768], [0:32], [0:1]}
  reshape.851 = f64[32768,32]{1,0} reshape(slice.850)
  multiply.852 = f64[32768,32]{1,0} multiply(subtract.800, reshape.851)
  constant.719 = f64[] constant(2)
  broadcast.720 = f64[32768,32]{1,0} broadcast(constant.719), dimensions={}
  divide.801 = f64[32768,32]{1,0} divide(subtract.755, broadcast.720)
  negate.802 = f64[32768,32]{1,0} negate(divide.801)
  multiply.803 = f64[32768,32]{1,0} multiply(multiply.788, broadcast.720)
  constant.717 = f64[] constant(3)
  broadcast.718 = f64[32768,32]{1,0} broadcast(constant.717), dimensions={}
  divide.804 = f64[32768,32]{1,0} divide(multiply.803, broadcast.718)
  add.805 = f64[32768,32]{1,0} add(negate.802, divide.804)
  divide.806 = f64[32768,32]{1,0} divide(multiply.789, broadcast.724)
  subtract.807 = f64[32768,32]{1,0} subtract(add.805, divide.806)
  constant.715 = f64[] constant(6)
  broadcast.716 = f64[32768,32]{1,0} broadcast(constant.715), dimensions={}
  divide.808 = f64[32768,32]{1,0} divide(multiply.790, broadcast.716)
  subtract.809 = f64[32768,32]{1,0} subtract(subtract.807, divide.808)
  divide.810 = f64[32768,32]{1,0} divide(multiply.791, broadcast.724)
  add.811 = f64[32768,32]{1,0} add(subtract.809, divide.810)
  slice.853 = f64[32768,32,1]{2,1,0} slice(call.787), slice={[0:32768], [0:32], [1:2]}
  reshape.854 = f64[32768,32]{1,0} reshape(slice.853)
  multiply.855 = f64[32768,32]{1,0} multiply(add.811, reshape.854)
  add.856 = f64[32768,32]{1,0} add(multiply.852, multiply.855)
  constant.713 = f64[] constant(1)
  broadcast.714 = f64[32768,32]{1,0} broadcast(constant.713), dimensions={}
  divide.812 = f64[32768,32]{1,0} divide(subtract.755, broadcast.718)
  subtract.813 = f64[32768,32]{1,0} subtract(broadcast.714, divide.812)
  constant.711 = f64[] constant(5)
  broadcast.712 = f64[32768,32]{1,0} broadcast(constant.711), dimensions={}
  multiply.814 = f64[32768,32]{1,0} multiply(multiply.788, broadcast.712)
  constant.709 = f64[] constant(4)
  broadcast.710 = f64[32768,32]{1,0} broadcast(constant.709), dimensions={}
  divide.815 = f64[32768,32]{1,0} divide(multiply.814, broadcast.710)
  subtract.816 = f64[32768,32]{1,0} subtract(subtract.813, divide.815)
  multiply.817 = f64[32768,32]{1,0} multiply(multiply.789, broadcast.712)
  constant.707 = f64[] constant(12)
  broadcast.708 = f64[32768,32]{1,0} broadcast(constant.707), dimensions={}
  divide.818 = f64[32768,32]{1,0} divide(multiply.817, broadcast.708)
  add.819 = f64[32768,32]{1,0} add(subtract.816, divide.818)
  divide.820 = f64[32768,32]{1,0} divide(multiply.790, broadcast.710)
  add.821 = f64[32768,32]{1,0} add(add.819, divide.820)
  divide.822 = f64[32768,32]{1,0} divide(multiply.791, broadcast.708)
  subtract.823 = f64[32768,32]{1,0} subtract(add.821, divide.822)
  slice.857 = f64[32768,32,1]{2,1,0} slice(call.787), slice={[0:32768], [0:32], [2:3]}
  reshape.858 = f64[32768,32]{1,0} reshape(slice.857)
  multiply.859 = f64[32768,32]{1,0} multiply(subtract.823, reshape.858)
  add.860 = f64[32768,32]{1,0} add(add.856, multiply.859)
  multiply.824 = f64[32768,32]{1,0} multiply(multiply.788, broadcast.720)
  divide.825 = f64[32768,32]{1,0} divide(multiply.824, broadcast.718)
  add.826 = f64[32768,32]{1,0} add(subtract.755, divide.825)
  constant.705 = f64[] constant(7)
  broadcast.706 = f64[32768,32]{1,0} broadcast(constant.705), dimensions={}
  multiply.827 = f64[32768,32]{1,0} multiply(multiply.789, broadcast.706)
  divide.828 = f64[32768,32]{1,0} divide(multiply.827, broadcast.708)
  subtract.829 = f64[32768,32]{1,0} subtract(add.826, divide.828)
  divide.830 = f64[32768,32]{1,0} divide(multiply.790, broadcast.716)
  subtract.831 = f64[32768,32]{1,0} subtract(subtract.829, divide.830)
  divide.832 = f64[32768,32]{1,0} divide(multiply.791, broadcast.708)
  add.833 = f64[32768,32]{1,0} add(subtract.831, divide.832)
  slice.861 = f64[32768,32,1]{2,1,0} slice(call.787), slice={[0:32768], [0:32], [3:4]}
  reshape.862 = f64[32768,32]{1,0} reshape(slice.861)
  multiply.863 = f64[32768,32]{1,0} multiply(add.833, reshape.862)
  add.864 = f64[32768,32]{1,0} add(add.860, multiply.863)
  divide.834 = f64[32768,32]{1,0} divide(subtract.755, broadcast.710)
  negate.835 = f64[32768,32]{1,0} negate(divide.834)
  divide.836 = f64[32768,32]{1,0} divide(multiply.788, broadcast.724)
  subtract.837 = f64[32768,32]{1,0} subtract(negate.835, divide.836)
  multiply.838 = f64[32768,32]{1,0} multiply(multiply.789, broadcast.706)
  divide.839 = f64[32768,32]{1,0} divide(multiply.838, broadcast.724)
  add.840 = f64[32768,32]{1,0} add(subtract.837, divide.839)
  divide.841 = f64[32768,32]{1,0} divide(multiply.790, broadcast.724)
  add.842 = f64[32768,32]{1,0} add(add.840, divide.841)
  divide.843 = f64[32768,32]{1,0} divide(multiply.791, broadcast.724)
  subtract.844 = f64[32768,32]{1,0} subtract(add.842, divide.843)
  slice.865 = f64[32768,32,1]{2,1,0} slice(call.787), slice={[0:32768], [0:32], [4:5]}
  reshape.866 = f64[32768,32]{1,0} reshape(slice.865)
  multiply.867 = f64[32768,32]{1,0} multiply(subtract.844, reshape.866)
  add.868 = f64[32768,32]{1,0} add(add.864, multiply.867)
  constant.703 = f64[] constant(30)
  broadcast.704 = f64[32768,32]{1,0} broadcast(constant.703), dimensions={}
  divide.845 = f64[32768,32]{1,0} divide(subtract.755, broadcast.704)
  divide.846 = f64[32768,32]{1,0} divide(multiply.789, broadcast.724)
  subtract.847 = f64[32768,32]{1,0} subtract(divide.845, divide.846)
  divide.848 = f64[32768,32]{1,0} divide(multiply.791, broadcast.722)
  add.849 = f64[32768,32]{1,0} add(subtract.847, divide.848)
  slice.869 = f64[32768,32,1]{2,1,0} slice(call.787), slice={[0:32768], [0:32], [5:6]}
  reshape.870 = f64[32768,32]{1,0} reshape(slice.869)
  multiply.871 = f64[32768,32]{1,0} multiply(add.849, reshape.870)
  ROOT add.872 = f64[32768,32]{1,0} add(add.868, multiply.871)
}

_where.881 {
  Arg_0.882 = pred[] parameter(0)
  Arg_1.883 = s32[] parameter(1)
  Arg_2.884 = s32[] parameter(2)
  ROOT select.885 = s32[] select(Arg_0.882, Arg_1.883, Arg_2.884)
}

remainder.886 {
  Arg_0.887 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.888 = s64[] parameter(1)
  convert.893 = s32[] convert(Arg_1.888)
  constant.892 = s32[] constant(0)
  compare.894 = pred[] compare(convert.893, constant.892), direction=EQ
  constant.891 = s32[] constant(1)
  call.895 = s32[] call(compare.894, constant.891, convert.893), to_apply=_where.881
  broadcast.896 = s32[32768,32,6]{2,1,0} broadcast(call.895), dimensions={}
  remainder.897 = s32[32768,32,6]{2,1,0} remainder(Arg_0.887, broadcast.896)
  constant.889 = s32[] constant(0)
  broadcast.890 = s32[32768,32,6]{2,1,0} broadcast(constant.889), dimensions={}
  compare.899 = pred[32768,32,6]{2,1,0} compare(remainder.897, broadcast.890), direction=LT
  compare.900 = pred[] compare(call.895, constant.892), direction=LT
  broadcast.901 = pred[32768,32,6]{2,1,0} broadcast(compare.900), dimensions={}
  compare.902 = pred[32768,32,6]{2,1,0} compare(compare.899, broadcast.901), direction=NE
  compare.898 = pred[32768,32,6]{2,1,0} compare(remainder.897, broadcast.890), direction=NE
  and.903 = pred[32768,32,6]{2,1,0} and(compare.902, compare.898)
  broadcast.904 = s32[32768,32,6]{2,1,0} broadcast(call.895), dimensions={}
  add.905 = s32[32768,32,6]{2,1,0} add(remainder.897, broadcast.904)
  ROOT select.906 = s32[32768,32,6]{2,1,0} select(and.903, add.905, remainder.897)
}

advect_1d_vectorized.907 {
  iota.944 = f64[32]{0} iota(), iota_dimension=0
  reshape.950 = f64[1,32]{1,0} reshape(iota.944)
  broadcast.951 = f64[1,32]{1,0} broadcast(reshape.950), dimensions={0,1}
  reshape.952 = f64[32]{0} reshape(broadcast.951)
  broadcast.953 = f64[32768,32]{1,0} broadcast(reshape.952), dimensions={1}
  Arg_1.909 = f64[32768]{0} parameter(1)
  reshape.945 = f64[32768,1]{1,0} reshape(Arg_1.909)
  Arg_2.910 = f64[] parameter(2)
  broadcast.946 = f64[32768,1]{1,0} broadcast(Arg_2.910), dimensions={}
  multiply.947 = f64[32768,1]{1,0} multiply(reshape.945, broadcast.946)
  Arg_3.911 = f64[] parameter(3)
  broadcast.948 = f64[32768,1]{1,0} broadcast(Arg_3.911), dimensions={}
  divide.949 = f64[32768,1]{1,0} divide(multiply.947, broadcast.948)
  broadcast.954 = f64[32768,1]{1,0} broadcast(divide.949), dimensions={0,1}
  reshape.955 = f64[32768]{0} reshape(broadcast.954)
  broadcast.956 = f64[32768,32]{1,0} broadcast(reshape.955), dimensions={0}
  subtract.957 = f64[32768,32]{1,0} subtract(broadcast.953, broadcast.956)
  floor.958 = f64[32768,32]{1,0} floor(subtract.957)
  subtract.959 = f64[32768,32]{1,0} subtract(subtract.957, floor.958)
  constant.935 = f64[] constant(20)
  broadcast.936 = f64[32768,32]{1,0} broadcast(constant.935), dimensions={}
  divide.992 = f64[32768,32]{1,0} divide(subtract.959, broadcast.936)
  multiply.988 = f64[32768,32]{1,0} multiply(subtract.959, subtract.959)
  constant.933 = f64[] constant(24)
  broadcast.934 = f64[32768,32]{1,0} broadcast(constant.933), dimensions={}
  divide.993 = f64[32768,32]{1,0} divide(multiply.988, broadcast.934)
  subtract.994 = f64[32768,32]{1,0} subtract(divide.992, divide.993)
  multiply.989 = f64[32768,32]{1,0} multiply(multiply.988, subtract.959)
  divide.995 = f64[32768,32]{1,0} divide(multiply.989, broadcast.934)
  subtract.996 = f64[32768,32]{1,0} subtract(subtract.994, divide.995)
  multiply.990 = f64[32768,32]{1,0} multiply(multiply.989, subtract.959)
  divide.997 = f64[32768,32]{1,0} divide(multiply.990, broadcast.934)
  add.998 = f64[32768,32]{1,0} add(subtract.996, divide.997)
  multiply.991 = f64[32768,32]{1,0} multiply(multiply.990, subtract.959)
  constant.931 = f64[] constant(120)
  broadcast.932 = f64[32768,32]{1,0} broadcast(constant.931), dimensions={}
  divide.999 = f64[32768,32]{1,0} divide(multiply.991, broadcast.932)
  subtract.1000 = f64[32768,32]{1,0} subtract(add.998, divide.999)
  Arg_0.908 = f64[32768,32]{1,0} parameter(0)
  reshape.979 = f64[1048576]{0} reshape(Arg_0.908)
  iota.971 = s64[32768]{0} iota(), iota_dimension=0
  reshape.972 = s64[32768,1,1]{2,1,0} reshape(iota.971)
  constant.941 = s64[] constant(32)
  broadcast.942 = s64[32768,1,1]{2,1,0} broadcast(constant.941), dimensions={}
  multiply.973 = s64[32768,1,1]{2,1,0} multiply(reshape.972, broadcast.942)
  broadcast.975 = s64[32768,1,1]{2,1,0} broadcast(multiply.973), dimensions={0,1,2}
  reshape.976 = s64[32768]{0} reshape(broadcast.975)
  broadcast.977 = s64[32768,32,6]{2,1,0} broadcast(reshape.976), dimensions={0}
  convert.960 = s32[32768,32]{1,0} convert(floor.958)
  reshape.961 = s32[32768,32,1]{2,1,0} reshape(convert.960)
  broadcast.963 = s32[32768,32,1]{2,1,0} broadcast(reshape.961), dimensions={0,1,2}
  reshape.964 = s32[32768,32]{1,0} reshape(broadcast.963)
  broadcast.965 = s32[32768,32,6]{2,1,0} broadcast(reshape.964), dimensions={0,1}
  Arg_4.912 = s32[6]{0} parameter(4)
  reshape.962 = s32[1,1,6]{2,1,0} reshape(Arg_4.912)
  broadcast.966 = s32[1,1,6]{2,1,0} broadcast(reshape.962), dimensions={0,1,2}
  reshape.967 = s32[6]{0} reshape(broadcast.966)
  broadcast.968 = s32[32768,32,6]{2,1,0} broadcast(reshape.967), dimensions={2}
  add.969 = s32[32768,32,6]{2,1,0} add(broadcast.965, broadcast.968)
  constant.943 = s64[] constant(32)
  call.970 = s32[32768,32,6]{2,1,0} call(add.969, constant.943), to_apply=remainder.886
  convert.974 = s64[32768,32,6]{2,1,0} convert(call.970)
  add.978 = s64[32768,32,6]{2,1,0} add(broadcast.977, convert.974)
  reshape.980 = s64[6291456]{0} reshape(add.978)
  constant.939 = s64[] constant(0)
  broadcast.940 = s64[6291456]{0} broadcast(constant.939), dimensions={}
  compare.981 = pred[6291456]{0} compare(reshape.980, broadcast.940), direction=LT
  constant.937 = s64[] constant(1048576)
  broadcast.938 = s64[6291456]{0} broadcast(constant.937), dimensions={}
  add.982 = s64[6291456]{0} add(reshape.980, broadcast.938)
  select.983 = s64[6291456]{0} select(compare.981, add.982, reshape.980)
  convert.984 = s32[6291456]{0} convert(select.983)
  reshape.985 = s32[6291456,1]{1,0} reshape(convert.984)
  gather.986 = f64[6291456]{0} gather(reshape.979, reshape.985), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.987 = f64[32768,32,6]{2,1,0} reshape(gather.986)
  slice.1050 = f64[32768,32,1]{2,1,0} slice(reshape.987), slice={[0:32768], [0:32], [0:1]}
  reshape.1051 = f64[32768,32]{1,0} reshape(slice.1050)
  multiply.1052 = f64[32768,32]{1,0} multiply(subtract.1000, reshape.1051)
  constant.929 = f64[] constant(2)
  broadcast.930 = f64[32768,32]{1,0} broadcast(constant.929), dimensions={}
  divide.1001 = f64[32768,32]{1,0} divide(subtract.959, broadcast.930)
  negate.1002 = f64[32768,32]{1,0} negate(divide.1001)
  multiply.1003 = f64[32768,32]{1,0} multiply(multiply.988, broadcast.930)
  constant.927 = f64[] constant(3)
  broadcast.928 = f64[32768,32]{1,0} broadcast(constant.927), dimensions={}
  divide.1004 = f64[32768,32]{1,0} divide(multiply.1003, broadcast.928)
  add.1005 = f64[32768,32]{1,0} add(negate.1002, divide.1004)
  divide.1006 = f64[32768,32]{1,0} divide(multiply.989, broadcast.934)
  subtract.1007 = f64[32768,32]{1,0} subtract(add.1005, divide.1006)
  constant.925 = f64[] constant(6)
  broadcast.926 = f64[32768,32]{1,0} broadcast(constant.925), dimensions={}
  divide.1008 = f64[32768,32]{1,0} divide(multiply.990, broadcast.926)
  subtract.1009 = f64[32768,32]{1,0} subtract(subtract.1007, divide.1008)
  divide.1010 = f64[32768,32]{1,0} divide(multiply.991, broadcast.934)
  add.1011 = f64[32768,32]{1,0} add(subtract.1009, divide.1010)
  slice.1053 = f64[32768,32,1]{2,1,0} slice(reshape.987), slice={[0:32768], [0:32], [1:2]}
  reshape.1054 = f64[32768,32]{1,0} reshape(slice.1053)
  multiply.1055 = f64[32768,32]{1,0} multiply(add.1011, reshape.1054)
  add.1056 = f64[32768,32]{1,0} add(multiply.1052, multiply.1055)
  constant.923 = f64[] constant(1)
  broadcast.924 = f64[32768,32]{1,0} broadcast(constant.923), dimensions={}
  divide.1012 = f64[32768,32]{1,0} divide(subtract.959, broadcast.928)
  subtract.1013 = f64[32768,32]{1,0} subtract(broadcast.924, divide.1012)
  constant.921 = f64[] constant(5)
  broadcast.922 = f64[32768,32]{1,0} broadcast(constant.921), dimensions={}
  multiply.1014 = f64[32768,32]{1,0} multiply(multiply.988, broadcast.922)
  constant.919 = f64[] constant(4)
  broadcast.920 = f64[32768,32]{1,0} broadcast(constant.919), dimensions={}
  divide.1015 = f64[32768,32]{1,0} divide(multiply.1014, broadcast.920)
  subtract.1016 = f64[32768,32]{1,0} subtract(subtract.1013, divide.1015)
  multiply.1017 = f64[32768,32]{1,0} multiply(multiply.989, broadcast.922)
  constant.917 = f64[] constant(12)
  broadcast.918 = f64[32768,32]{1,0} broadcast(constant.917), dimensions={}
  divide.1018 = f64[32768,32]{1,0} divide(multiply.1017, broadcast.918)
  add.1019 = f64[32768,32]{1,0} add(subtract.1016, divide.1018)
  divide.1020 = f64[32768,32]{1,0} divide(multiply.990, broadcast.920)
  add.1021 = f64[32768,32]{1,0} add(add.1019, divide.1020)
  divide.1022 = f64[32768,32]{1,0} divide(multiply.991, broadcast.918)
  subtract.1023 = f64[32768,32]{1,0} subtract(add.1021, divide.1022)
  slice.1057 = f64[32768,32,1]{2,1,0} slice(reshape.987), slice={[0:32768], [0:32], [2:3]}
  reshape.1058 = f64[32768,32]{1,0} reshape(slice.1057)
  multiply.1059 = f64[32768,32]{1,0} multiply(subtract.1023, reshape.1058)
  add.1060 = f64[32768,32]{1,0} add(add.1056, multiply.1059)
  multiply.1024 = f64[32768,32]{1,0} multiply(multiply.988, broadcast.930)
  divide.1025 = f64[32768,32]{1,0} divide(multiply.1024, broadcast.928)
  add.1026 = f64[32768,32]{1,0} add(subtract.959, divide.1025)
  constant.915 = f64[] constant(7)
  broadcast.916 = f64[32768,32]{1,0} broadcast(constant.915), dimensions={}
  multiply.1027 = f64[32768,32]{1,0} multiply(multiply.989, broadcast.916)
  divide.1028 = f64[32768,32]{1,0} divide(multiply.1027, broadcast.918)
  subtract.1029 = f64[32768,32]{1,0} subtract(add.1026, divide.1028)
  divide.1030 = f64[32768,32]{1,0} divide(multiply.990, broadcast.926)
  subtract.1031 = f64[32768,32]{1,0} subtract(subtract.1029, divide.1030)
  divide.1032 = f64[32768,32]{1,0} divide(multiply.991, broadcast.918)
  add.1033 = f64[32768,32]{1,0} add(subtract.1031, divide.1032)
  slice.1061 = f64[32768,32,1]{2,1,0} slice(reshape.987), slice={[0:32768], [0:32], [3:4]}
  reshape.1062 = f64[32768,32]{1,0} reshape(slice.1061)
  multiply.1063 = f64[32768,32]{1,0} multiply(add.1033, reshape.1062)
  add.1064 = f64[32768,32]{1,0} add(add.1060, multiply.1063)
  divide.1034 = f64[32768,32]{1,0} divide(subtract.959, broadcast.920)
  negate.1035 = f64[32768,32]{1,0} negate(divide.1034)
  divide.1036 = f64[32768,32]{1,0} divide(multiply.988, broadcast.934)
  subtract.1037 = f64[32768,32]{1,0} subtract(negate.1035, divide.1036)
  multiply.1038 = f64[32768,32]{1,0} multiply(multiply.989, broadcast.916)
  divide.1039 = f64[32768,32]{1,0} divide(multiply.1038, broadcast.934)
  add.1040 = f64[32768,32]{1,0} add(subtract.1037, divide.1039)
  divide.1041 = f64[32768,32]{1,0} divide(multiply.990, broadcast.934)
  add.1042 = f64[32768,32]{1,0} add(add.1040, divide.1041)
  divide.1043 = f64[32768,32]{1,0} divide(multiply.991, broadcast.934)
  subtract.1044 = f64[32768,32]{1,0} subtract(add.1042, divide.1043)
  slice.1065 = f64[32768,32,1]{2,1,0} slice(reshape.987), slice={[0:32768], [0:32], [4:5]}
  reshape.1066 = f64[32768,32]{1,0} reshape(slice.1065)
  multiply.1067 = f64[32768,32]{1,0} multiply(subtract.1044, reshape.1066)
  add.1068 = f64[32768,32]{1,0} add(add.1064, multiply.1067)
  constant.913 = f64[] constant(30)
  broadcast.914 = f64[32768,32]{1,0} broadcast(constant.913), dimensions={}
  divide.1045 = f64[32768,32]{1,0} divide(subtract.959, broadcast.914)
  divide.1046 = f64[32768,32]{1,0} divide(multiply.989, broadcast.934)
  subtract.1047 = f64[32768,32]{1,0} subtract(divide.1045, divide.1046)
  divide.1048 = f64[32768,32]{1,0} divide(multiply.991, broadcast.932)
  add.1049 = f64[32768,32]{1,0} add(subtract.1047, divide.1048)
  slice.1069 = f64[32768,32,1]{2,1,0} slice(reshape.987), slice={[0:32768], [0:32], [5:6]}
  reshape.1070 = f64[32768,32]{1,0} reshape(slice.1069)
  multiply.1071 = f64[32768,32]{1,0} multiply(add.1049, reshape.1070)
  ROOT add.1072 = f64[32768,32]{1,0} add(add.1068, multiply.1071)
}

_where.1081 {
  Arg_0.1082 = pred[] parameter(0)
  Arg_1.1083 = s32[] parameter(1)
  Arg_2.1084 = s32[] parameter(2)
  ROOT select.1085 = s32[] select(Arg_0.1082, Arg_1.1083, Arg_2.1084)
}

remainder.1086 {
  Arg_0.1087 = s32[32768,32,6]{2,1,0} parameter(0)
  Arg_1.1088 = s64[] parameter(1)
  convert.1093 = s32[] convert(Arg_1.1088)
  constant.1092 = s32[] constant(0)
  compare.1094 = pred[] compare(convert.1093, constant.1092), direction=EQ
  constant.1091 = s32[] constant(1)
  call.1095 = s32[] call(compare.1094, constant.1091, convert.1093), to_apply=_where.1081
  broadcast.1096 = s32[32768,32,6]{2,1,0} broadcast(call.1095), dimensions={}
  remainder.1097 = s32[32768,32,6]{2,1,0} remainder(Arg_0.1087, broadcast.1096)
  constant.1089 = s32[] constant(0)
  broadcast.1090 = s32[32768,32,6]{2,1,0} broadcast(constant.1089), dimensions={}
  compare.1099 = pred[32768,32,6]{2,1,0} compare(remainder.1097, broadcast.1090), direction=LT
  compare.1100 = pred[] compare(call.1095, constant.1092), direction=LT
  broadcast.1101 = pred[32768,32,6]{2,1,0} broadcast(compare.1100), dimensions={}
  compare.1102 = pred[32768,32,6]{2,1,0} compare(compare.1099, broadcast.1101), direction=NE
  compare.1098 = pred[32768,32,6]{2,1,0} compare(remainder.1097, broadcast.1090), direction=NE
  and.1103 = pred[32768,32,6]{2,1,0} and(compare.1102, compare.1098)
  broadcast.1104 = s32[32768,32,6]{2,1,0} broadcast(call.1095), dimensions={}
  add.1105 = s32[32768,32,6]{2,1,0} add(remainder.1097, broadcast.1104)
  ROOT select.1106 = s32[32768,32,6]{2,1,0} select(and.1103, add.1105, remainder.1097)
}

advect_1d_vectorized.1107 {
  iota.1144 = f64[32]{0} iota(), iota_dimension=0
  reshape.1150 = f64[1,32]{1,0} reshape(iota.1144)
  broadcast.1151 = f64[1,32]{1,0} broadcast(reshape.1150), dimensions={0,1}
  reshape.1152 = f64[32]{0} reshape(broadcast.1151)
  broadcast.1153 = f64[32768,32]{1,0} broadcast(reshape.1152), dimensions={1}
  Arg_1.1109 = f64[32768]{0} parameter(1)
  reshape.1145 = f64[32768,1]{1,0} reshape(Arg_1.1109)
  Arg_2.1110 = f64[] parameter(2)
  broadcast.1146 = f64[32768,1]{1,0} broadcast(Arg_2.1110), dimensions={}
  multiply.1147 = f64[32768,1]{1,0} multiply(reshape.1145, broadcast.1146)
  Arg_3.1111 = f64[] parameter(3)
  broadcast.1148 = f64[32768,1]{1,0} broadcast(Arg_3.1111), dimensions={}
  divide.1149 = f64[32768,1]{1,0} divide(multiply.1147, broadcast.1148)
  broadcast.1154 = f64[32768,1]{1,0} broadcast(divide.1149), dimensions={0,1}
  reshape.1155 = f64[32768]{0} reshape(broadcast.1154)
  broadcast.1156 = f64[32768,32]{1,0} broadcast(reshape.1155), dimensions={0}
  subtract.1157 = f64[32768,32]{1,0} subtract(broadcast.1153, broadcast.1156)
  floor.1158 = f64[32768,32]{1,0} floor(subtract.1157)
  subtract.1159 = f64[32768,32]{1,0} subtract(subtract.1157, floor.1158)
  constant.1135 = f64[] constant(20)
  broadcast.1136 = f64[32768,32]{1,0} broadcast(constant.1135), dimensions={}
  divide.1192 = f64[32768,32]{1,0} divide(subtract.1159, broadcast.1136)
  multiply.1188 = f64[32768,32]{1,0} multiply(subtract.1159, subtract.1159)
  constant.1133 = f64[] constant(24)
  broadcast.1134 = f64[32768,32]{1,0} broadcast(constant.1133), dimensions={}
  divide.1193 = f64[32768,32]{1,0} divide(multiply.1188, broadcast.1134)
  subtract.1194 = f64[32768,32]{1,0} subtract(divide.1192, divide.1193)
  multiply.1189 = f64[32768,32]{1,0} multiply(multiply.1188, subtract.1159)
  divide.1195 = f64[32768,32]{1,0} divide(multiply.1189, broadcast.1134)
  subtract.1196 = f64[32768,32]{1,0} subtract(subtract.1194, divide.1195)
  multiply.1190 = f64[32768,32]{1,0} multiply(multiply.1189, subtract.1159)
  divide.1197 = f64[32768,32]{1,0} divide(multiply.1190, broadcast.1134)
  add.1198 = f64[32768,32]{1,0} add(subtract.1196, divide.1197)
  multiply.1191 = f64[32768,32]{1,0} multiply(multiply.1190, subtract.1159)
  constant.1131 = f64[] constant(120)
  broadcast.1132 = f64[32768,32]{1,0} broadcast(constant.1131), dimensions={}
  divide.1199 = f64[32768,32]{1,0} divide(multiply.1191, broadcast.1132)
  subtract.1200 = f64[32768,32]{1,0} subtract(add.1198, divide.1199)
  Arg_0.1108 = f64[32768,32]{1,0} parameter(0)
  reshape.1179 = f64[1048576]{0} reshape(Arg_0.1108)
  iota.1171 = s64[32768]{0} iota(), iota_dimension=0
  reshape.1172 = s64[32768,1,1]{2,1,0} reshape(iota.1171)
  constant.1141 = s64[] constant(32)
  broadcast.1142 = s64[32768,1,1]{2,1,0} broadcast(constant.1141), dimensions={}
  multiply.1173 = s64[32768,1,1]{2,1,0} multiply(reshape.1172, broadcast.1142)
  broadcast.1175 = s64[32768,1,1]{2,1,0} broadcast(multiply.1173), dimensions={0,1,2}
  reshape.1176 = s64[32768]{0} reshape(broadcast.1175)
  broadcast.1177 = s64[32768,32,6]{2,1,0} broadcast(reshape.1176), dimensions={0}
  convert.1160 = s32[32768,32]{1,0} convert(floor.1158)
  reshape.1161 = s32[32768,32,1]{2,1,0} reshape(convert.1160)
  broadcast.1163 = s32[32768,32,1]{2,1,0} broadcast(reshape.1161), dimensions={0,1,2}
  reshape.1164 = s32[32768,32]{1,0} reshape(broadcast.1163)
  broadcast.1165 = s32[32768,32,6]{2,1,0} broadcast(reshape.1164), dimensions={0,1}
  Arg_4.1112 = s32[6]{0} parameter(4)
  reshape.1162 = s32[1,1,6]{2,1,0} reshape(Arg_4.1112)
  broadcast.1166 = s32[1,1,6]{2,1,0} broadcast(reshape.1162), dimensions={0,1,2}
  reshape.1167 = s32[6]{0} reshape(broadcast.1166)
  broadcast.1168 = s32[32768,32,6]{2,1,0} broadcast(reshape.1167), dimensions={2}
  add.1169 = s32[32768,32,6]{2,1,0} add(broadcast.1165, broadcast.1168)
  constant.1143 = s64[] constant(32)
  call.1170 = s32[32768,32,6]{2,1,0} call(add.1169, constant.1143), to_apply=remainder.1086
  convert.1174 = s64[32768,32,6]{2,1,0} convert(call.1170)
  add.1178 = s64[32768,32,6]{2,1,0} add(broadcast.1177, convert.1174)
  reshape.1180 = s64[6291456]{0} reshape(add.1178)
  constant.1139 = s64[] constant(0)
  broadcast.1140 = s64[6291456]{0} broadcast(constant.1139), dimensions={}
  compare.1181 = pred[6291456]{0} compare(reshape.1180, broadcast.1140), direction=LT
  constant.1137 = s64[] constant(1048576)
  broadcast.1138 = s64[6291456]{0} broadcast(constant.1137), dimensions={}
  add.1182 = s64[6291456]{0} add(reshape.1180, broadcast.1138)
  select.1183 = s64[6291456]{0} select(compare.1181, add.1182, reshape.1180)
  convert.1184 = s32[6291456]{0} convert(select.1183)
  reshape.1185 = s32[6291456,1]{1,0} reshape(convert.1184)
  gather.1186 = f64[6291456]{0} gather(reshape.1179, reshape.1185), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.1187 = f64[32768,32,6]{2,1,0} reshape(gather.1186)
  slice.1250 = f64[32768,32,1]{2,1,0} slice(reshape.1187), slice={[0:32768], [0:32], [0:1]}
  reshape.1251 = f64[32768,32]{1,0} reshape(slice.1250)
  multiply.1252 = f64[32768,32]{1,0} multiply(subtract.1200, reshape.1251)
  constant.1129 = f64[] constant(2)
  broadcast.1130 = f64[32768,32]{1,0} broadcast(constant.1129), dimensions={}
  divide.1201 = f64[32768,32]{1,0} divide(subtract.1159, broadcast.1130)
  negate.1202 = f64[32768,32]{1,0} negate(divide.1201)
  multiply.1203 = f64[32768,32]{1,0} multiply(multiply.1188, broadcast.1130)
  constant.1127 = f64[] constant(3)
  broadcast.1128 = f64[32768,32]{1,0} broadcast(constant.1127), dimensions={}
  divide.1204 = f64[32768,32]{1,0} divide(multiply.1203, broadcast.1128)
  add.1205 = f64[32768,32]{1,0} add(negate.1202, divide.1204)
  divide.1206 = f64[32768,32]{1,0} divide(multiply.1189, broadcast.1134)
  subtract.1207 = f64[32768,32]{1,0} subtract(add.1205, divide.1206)
  constant.1125 = f64[] constant(6)
  broadcast.1126 = f64[32768,32]{1,0} broadcast(constant.1125), dimensions={}
  divide.1208 = f64[32768,32]{1,0} divide(multiply.1190, broadcast.1126)
  subtract.1209 = f64[32768,32]{1,0} subtract(subtract.1207, divide.1208)
  divide.1210 = f64[32768,32]{1,0} divide(multiply.1191, broadcast.1134)
  add.1211 = f64[32768,32]{1,0} add(subtract.1209, divide.1210)
  slice.1253 = f64[32768,32,1]{2,1,0} slice(reshape.1187), slice={[0:32768], [0:32], [1:2]}
  reshape.1254 = f64[32768,32]{1,0} reshape(slice.1253)
  multiply.1255 = f64[32768,32]{1,0} multiply(add.1211, reshape.1254)
  add.1256 = f64[32768,32]{1,0} add(multiply.1252, multiply.1255)
  constant.1123 = f64[] constant(1)
  broadcast.1124 = f64[32768,32]{1,0} broadcast(constant.1123), dimensions={}
  divide.1212 = f64[32768,32]{1,0} divide(subtract.1159, broadcast.1128)
  subtract.1213 = f64[32768,32]{1,0} subtract(broadcast.1124, divide.1212)
  constant.1121 = f64[] constant(5)
  broadcast.1122 = f64[32768,32]{1,0} broadcast(constant.1121), dimensions={}
  multiply.1214 = f64[32768,32]{1,0} multiply(multiply.1188, broadcast.1122)
  constant.1119 = f64[] constant(4)
  broadcast.1120 = f64[32768,32]{1,0} broadcast(constant.1119), dimensions={}
  divide.1215 = f64[32768,32]{1,0} divide(multiply.1214, broadcast.1120)
  subtract.1216 = f64[32768,32]{1,0} subtract(subtract.1213, divide.1215)
  multiply.1217 = f64[32768,32]{1,0} multiply(multiply.1189, broadcast.1122)
  constant.1117 = f64[] constant(12)
  broadcast.1118 = f64[32768,32]{1,0} broadcast(constant.1117), dimensions={}
  divide.1218 = f64[32768,32]{1,0} divide(multiply.1217, broadcast.1118)
  add.1219 = f64[32768,32]{1,0} add(subtract.1216, divide.1218)
  divide.1220 = f64[32768,32]{1,0} divide(multiply.1190, broadcast.1120)
  add.1221 = f64[32768,32]{1,0} add(add.1219, divide.1220)
  divide.1222 = f64[32768,32]{1,0} divide(multiply.1191, broadcast.1118)
  subtract.1223 = f64[32768,32]{1,0} subtract(add.1221, divide.1222)
  slice.1257 = f64[32768,32,1]{2,1,0} slice(reshape.1187), slice={[0:32768], [0:32], [2:3]}
  reshape.1258 = f64[32768,32]{1,0} reshape(slice.1257)
  multiply.1259 = f64[32768,32]{1,0} multiply(subtract.1223, reshape.1258)
  add.1260 = f64[32768,32]{1,0} add(add.1256, multiply.1259)
  multiply.1224 = f64[32768,32]{1,0} multiply(multiply.1188, broadcast.1130)
  divide.1225 = f64[32768,32]{1,0} divide(multiply.1224, broadcast.1128)
  add.1226 = f64[32768,32]{1,0} add(subtract.1159, divide.1225)
  constant.1115 = f64[] constant(7)
  broadcast.1116 = f64[32768,32]{1,0} broadcast(constant.1115), dimensions={}
  multiply.1227 = f64[32768,32]{1,0} multiply(multiply.1189, broadcast.1116)
  divide.1228 = f64[32768,32]{1,0} divide(multiply.1227, broadcast.1118)
  subtract.1229 = f64[32768,32]{1,0} subtract(add.1226, divide.1228)
  divide.1230 = f64[32768,32]{1,0} divide(multiply.1190, broadcast.1126)
  subtract.1231 = f64[32768,32]{1,0} subtract(subtract.1229, divide.1230)
  divide.1232 = f64[32768,32]{1,0} divide(multiply.1191, broadcast.1118)
  add.1233 = f64[32768,32]{1,0} add(subtract.1231, divide.1232)
  slice.1261 = f64[32768,32,1]{2,1,0} slice(reshape.1187), slice={[0:32768], [0:32], [3:4]}
  reshape.1262 = f64[32768,32]{1,0} reshape(slice.1261)
  multiply.1263 = f64[32768,32]{1,0} multiply(add.1233, reshape.1262)
  add.1264 = f64[32768,32]{1,0} add(add.1260, multiply.1263)
  divide.1234 = f64[32768,32]{1,0} divide(subtract.1159, broadcast.1120)
  negate.1235 = f64[32768,32]{1,0} negate(divide.1234)
  divide.1236 = f64[32768,32]{1,0} divide(multiply.1188, broadcast.1134)
  subtract.1237 = f64[32768,32]{1,0} subtract(negate.1235, divide.1236)
  multiply.1238 = f64[32768,32]{1,0} multiply(multiply.1189, broadcast.1116)
  divide.1239 = f64[32768,32]{1,0} divide(multiply.1238, broadcast.1134)
  add.1240 = f64[32768,32]{1,0} add(subtract.1237, divide.1239)
  divide.1241 = f64[32768,32]{1,0} divide(multiply.1190, broadcast.1134)
  add.1242 = f64[32768,32]{1,0} add(add.1240, divide.1241)
  divide.1243 = f64[32768,32]{1,0} divide(multiply.1191, broadcast.1134)
  subtract.1244 = f64[32768,32]{1,0} subtract(add.1242, divide.1243)
  slice.1265 = f64[32768,32,1]{2,1,0} slice(reshape.1187), slice={[0:32768], [0:32], [4:5]}
  reshape.1266 = f64[32768,32]{1,0} reshape(slice.1265)
  multiply.1267 = f64[32768,32]{1,0} multiply(subtract.1244, reshape.1266)
  add.1268 = f64[32768,32]{1,0} add(add.1264, multiply.1267)
  constant.1113 = f64[] constant(30)
  broadcast.1114 = f64[32768,32]{1,0} broadcast(constant.1113), dimensions={}
  divide.1245 = f64[32768,32]{1,0} divide(subtract.1159, broadcast.1114)
  divide.1246 = f64[32768,32]{1,0} divide(multiply.1189, broadcast.1134)
  subtract.1247 = f64[32768,32]{1,0} subtract(divide.1245, divide.1246)
  divide.1248 = f64[32768,32]{1,0} divide(multiply.1191, broadcast.1132)
  add.1249 = f64[32768,32]{1,0} add(subtract.1247, divide.1248)
  slice.1269 = f64[32768,32,1]{2,1,0} slice(reshape.1187), slice={[0:32768], [0:32], [5:6]}
  reshape.1270 = f64[32768,32]{1,0} reshape(slice.1269)
  multiply.1271 = f64[32768,32]{1,0} multiply(add.1249, reshape.1270)
  ROOT add.1272 = f64[32768,32]{1,0} add(add.1268, multiply.1271)
}

ENTRY main.1277 {
  Arg_0.1 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  transpose.12 = f64[32,32,32,32]{2,1,0,3} transpose(Arg_0.1), dimensions={1,2,3,0}
  reshape.13 = f64[32768,32]{1,0} reshape(transpose.12)
  constant.11 = f64[1,32,1]{2,1,0} constant({...})
  broadcast.14 = f64[1,32,1]{2,1,0} broadcast(constant.11), dimensions={0,1,2}
  reshape.15 = f64[32]{0} reshape(broadcast.14)
  broadcast.16 = f64[32,32,32]{2,1,0} broadcast(reshape.15), dimensions={1}
  reshape.17 = f64[32768]{0} reshape(broadcast.16)
  constant.6 = f64[] constant(0.025)
  constant.5 = f64[] constant(0.39269908169872414)
  constant.7 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  call.210 = f64[32768,32]{1,0} call(reshape.13, reshape.17, constant.6, constant.5, constant.7), to_apply=advect_1d_vectorized.44
  reshape.211 = f64[32,32,32,32]{3,2,1,0} reshape(call.210)
  transpose.212 = f64[32,32,32,32]{0,2,1,3} transpose(reshape.211), dimensions={3,1,2,0}
  reshape.213 = f64[32768,32]{1,0} reshape(transpose.212)
  constant.2 = f64[1,1,32]{2,1,0} constant({...})
  broadcast.214 = f64[1,1,32]{2,1,0} broadcast(constant.2), dimensions={0,1,2}
  reshape.215 = f64[32]{0} reshape(broadcast.214)
  broadcast.216 = f64[32,32,32]{2,1,0} broadcast(reshape.215), dimensions={2}
  reshape.217 = f64[32768]{0} reshape(broadcast.216)
  call.410 = f64[32768,32]{1,0} call(reshape.213, reshape.217, constant.6, constant.5, constant.7), to_apply=advect_1d_vectorized.244
  reshape.411 = f64[32,32,32,32]{3,2,1,0} reshape(call.410)
  transpose.474 = f64[32,32,32,32]{1,2,3,0} transpose(reshape.411), dimensions={0,3,2,1}
  reshape.475 = f64[32768,32]{1,0} reshape(transpose.474)
  transpose.412 = f64[32,32,32,32]{1,3,2,0} transpose(reshape.411), dimensions={0,3,1,2}
  constant.8 = f64[32,1]{1,0} constant({...})
  constant.9 = f64[1,17]{1,0} constant({...})
  constant.10 = f64[32,17]{1,0} constant({...})
  constant.4 = f64[] constant(0.32258064516129031)
  call.468 = (f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) call(transpose.412, constant.8, constant.9, constant.10, constant.4, constant.4), to_apply=solve_poisson.429
  get-tuple-element.469 = f64[32,32]{1,0} get-tuple-element(call.468), index=0
  reshape.473 = f64[32,32,1]{2,1,0} reshape(get-tuple-element.469)
  broadcast.476 = f64[32,32,1]{2,1,0} broadcast(reshape.473), dimensions={0,1,2}
  reshape.477 = f64[32,32]{1,0} reshape(broadcast.476)
  broadcast.478 = f64[32,32,32]{2,1,0} broadcast(reshape.477), dimensions={0,1}
  reshape.479 = f64[32768]{0} reshape(broadcast.478)
  constant.3 = f64[] constant(0.05)
  call.672 = f64[32768,32]{1,0} call(reshape.475, reshape.479, constant.3, constant.4, constant.7), to_apply=advect_1d_vectorized_1.496
  reshape.673 = f64[32,32,32,32]{3,2,1,0} reshape(call.672)
  transpose.674 = f64[32,32,32,32]{2,3,1,0} transpose(reshape.673), dimensions={0,1,3,2}
  reshape.676 = f64[32768,32]{1,0} reshape(transpose.674)
  get-tuple-element.470 = f64[32,32]{1,0} get-tuple-element(call.468), index=1
  reshape.675 = f64[32,32,1]{2,1,0} reshape(get-tuple-element.470)
  broadcast.677 = f64[32,32,1]{2,1,0} broadcast(reshape.675), dimensions={0,1,2}
  reshape.678 = f64[32,32]{1,0} reshape(broadcast.677)
  broadcast.679 = f64[32,32,32]{2,1,0} broadcast(reshape.678), dimensions={0,1}
  reshape.680 = f64[32768]{0} reshape(broadcast.679)
  call.873 = f64[32768,32]{1,0} call(reshape.676, reshape.680, constant.3, constant.4, constant.7), to_apply=advect_1d_vectorized_1.697
  reshape.874 = f64[32,32,32,32]{3,2,1,0} reshape(call.873)
  transpose.875 = f64[32,32,32,32]{2,1,3,0} transpose(reshape.874), dimensions={0,2,3,1}
  reshape.876 = f64[32768,32]{1,0} reshape(transpose.875)
  broadcast.877 = f64[1,1,32]{2,1,0} broadcast(constant.2), dimensions={0,1,2}
  reshape.878 = f64[32]{0} reshape(broadcast.877)
  broadcast.879 = f64[32,32,32]{2,1,0} broadcast(reshape.878), dimensions={2}
  reshape.880 = f64[32768]{0} reshape(broadcast.879)
  call.1073 = f64[32768,32]{1,0} call(reshape.876, reshape.880, constant.6, constant.5, constant.7), to_apply=advect_1d_vectorized.907
  reshape.1074 = f64[32,32,32,32]{3,2,1,0} reshape(call.1073)
  transpose.1075 = f64[32,32,32,32]{0,2,1,3} transpose(reshape.1074), dimensions={3,1,2,0}
  reshape.1076 = f64[32768,32]{1,0} reshape(transpose.1075)
  broadcast.1077 = f64[1,32,1]{2,1,0} broadcast(constant.11), dimensions={0,1,2}
  reshape.1078 = f64[32]{0} reshape(broadcast.1077)
  broadcast.1079 = f64[32,32,32]{2,1,0} broadcast(reshape.1078), dimensions={1}
  reshape.1080 = f64[32768]{0} reshape(broadcast.1079)
  call.1273 = f64[32768,32]{1,0} call(reshape.1076, reshape.1080, constant.6, constant.5, constant.7), to_apply=advect_1d_vectorized.1107
  reshape.1274 = f64[32,32,32,32]{3,2,1,0} reshape(call.1273)
  transpose.1275 = f64[32,32,32,32]{0,3,2,1} transpose(reshape.1274), dimensions={3,0,1,2}
  get-tuple-element.471 = f64[32,32]{1,0} get-tuple-element(call.468), index=2
  get-tuple-element.472 = f64[32,32]{1,0} get-tuple-element(call.468), index=3
  ROOT tuple.1276 = (f64[32,32,32,32]{0,3,2,1}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(transpose.1275, get-tuple-element.471, get-tuple-element.472)
}

