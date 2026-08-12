HloModule jit__lambda_, entry_computation_layout={(f64[32,32,32,32]{3,2,1,0})->(f64[32,32,32,32]{0,3,2,1}, f64[32,32]{1,0}, f64[32,32]{1,0})}

_where.18 {
  Arg_0.19 = pred[] parameter(0)
  Arg_1.20 = s32[] parameter(1)
  Arg_2.21 = s32[] parameter(2)
  ROOT select.22 = s32[] select(Arg_0.19, Arg_1.20, Arg_2.21)
}

remainder.23 {
  Arg_0.24 = s32[32768]{0} parameter(0)
  Arg_1.25 = s32[] parameter(1)
  constant.29 = s32[] constant(0)
  compare.30 = pred[] compare(Arg_1.25, constant.29), direction=EQ
  constant.28 = s32[] constant(1)
  call.31 = s32[] call(compare.30, constant.28, Arg_1.25), to_apply=_where.18
  broadcast.32 = s32[32768]{0} broadcast(call.31), dimensions={}
  remainder.33 = s32[32768]{0} remainder(Arg_0.24, broadcast.32)
  constant.26 = s32[] constant(0)
  broadcast.27 = s32[32768]{0} broadcast(constant.26), dimensions={}
  compare.35 = pred[32768]{0} compare(remainder.33, broadcast.27), direction=LT
  compare.36 = pred[] compare(call.31, constant.29), direction=LT
  broadcast.37 = pred[32768]{0} broadcast(compare.36), dimensions={}
  compare.38 = pred[32768]{0} compare(compare.35, broadcast.37), direction=NE
  compare.34 = pred[32768]{0} compare(remainder.33, broadcast.27), direction=NE
  and.39 = pred[32768]{0} and(compare.38, compare.34)
  broadcast.40 = s32[32768]{0} broadcast(call.31), dimensions={}
  add.41 = s32[32768]{0} add(remainder.33, broadcast.40)
  ROOT select.42 = s32[32768]{0} select(and.39, add.41, remainder.33)
}

_roll_dynamic.43 {
  Arg_0.44 = f64[32768,32]{1,0} parameter(0)
  concatenate.54 = f64[32768,64]{1,0} concatenate(Arg_0.44, Arg_0.44), dimensions={1}
  constant.50 = s32[] constant(32)
  broadcast.51 = s32[32768]{0} broadcast(constant.50), dimensions={}
  Arg_1.45 = s32[32768]{0} parameter(1)
  constant.52 = s32[] constant(32)
  call.53 = s32[32768]{0} call(Arg_1.45, constant.52), to_apply=remainder.23
  subtract.55 = s32[32768]{0} subtract(broadcast.51, call.53)
  constant.48 = s32[] constant(0)
  broadcast.49 = s32[32768]{0} broadcast(constant.48), dimensions={}
  compare.56 = pred[32768]{0} compare(subtract.55, broadcast.49), direction=LT
  constant.46 = s32[] constant(64)
  broadcast.47 = s32[32768]{0} broadcast(constant.46), dimensions={}
  add.57 = s32[32768]{0} add(subtract.55, broadcast.47)
  select.58 = s32[32768]{0} select(compare.56, add.57, subtract.55)
  reshape.59 = s32[32768,1]{1,0} reshape(select.58)
  ROOT gather.60 = f64[32768,32]{1,0} gather(concatenate.54, reshape.59), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.61 {
  Arg_0.62 = pred[] parameter(0)
  Arg_1.63 = s32[] parameter(1)
  Arg_2.64 = s32[] parameter(2)
  ROOT select.65 = s32[] select(Arg_0.62, Arg_1.63, Arg_2.64)
}

remainder.66 {
  Arg_0.67 = s32[32768]{0} parameter(0)
  Arg_1.68 = s32[] parameter(1)
  constant.72 = s32[] constant(0)
  compare.73 = pred[] compare(Arg_1.68, constant.72), direction=EQ
  constant.71 = s32[] constant(1)
  call.74 = s32[] call(compare.73, constant.71, Arg_1.68), to_apply=_where.61
  broadcast.75 = s32[32768]{0} broadcast(call.74), dimensions={}
  remainder.76 = s32[32768]{0} remainder(Arg_0.67, broadcast.75)
  constant.69 = s32[] constant(0)
  broadcast.70 = s32[32768]{0} broadcast(constant.69), dimensions={}
  compare.78 = pred[32768]{0} compare(remainder.76, broadcast.70), direction=LT
  compare.79 = pred[] compare(call.74, constant.72), direction=LT
  broadcast.80 = pred[32768]{0} broadcast(compare.79), dimensions={}
  compare.81 = pred[32768]{0} compare(compare.78, broadcast.80), direction=NE
  compare.77 = pred[32768]{0} compare(remainder.76, broadcast.70), direction=NE
  and.82 = pred[32768]{0} and(compare.81, compare.77)
  broadcast.83 = s32[32768]{0} broadcast(call.74), dimensions={}
  add.84 = s32[32768]{0} add(remainder.76, broadcast.83)
  ROOT select.85 = s32[32768]{0} select(and.82, add.84, remainder.76)
}

_roll_dynamic.86 {
  Arg_0.87 = f64[32768,32]{1,0} parameter(0)
  concatenate.97 = f64[32768,64]{1,0} concatenate(Arg_0.87, Arg_0.87), dimensions={1}
  constant.93 = s32[] constant(32)
  broadcast.94 = s32[32768]{0} broadcast(constant.93), dimensions={}
  Arg_1.88 = s32[32768]{0} parameter(1)
  constant.95 = s32[] constant(32)
  call.96 = s32[32768]{0} call(Arg_1.88, constant.95), to_apply=remainder.66
  subtract.98 = s32[32768]{0} subtract(broadcast.94, call.96)
  constant.91 = s32[] constant(0)
  broadcast.92 = s32[32768]{0} broadcast(constant.91), dimensions={}
  compare.99 = pred[32768]{0} compare(subtract.98, broadcast.92), direction=LT
  constant.89 = s32[] constant(64)
  broadcast.90 = s32[32768]{0} broadcast(constant.89), dimensions={}
  add.100 = s32[32768]{0} add(subtract.98, broadcast.90)
  select.101 = s32[32768]{0} select(compare.99, add.100, subtract.98)
  reshape.102 = s32[32768,1]{1,0} reshape(select.101)
  ROOT gather.103 = f64[32768,32]{1,0} gather(concatenate.97, reshape.102), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.104 {
  Arg_0.105 = pred[] parameter(0)
  Arg_1.106 = s32[] parameter(1)
  Arg_2.107 = s32[] parameter(2)
  ROOT select.108 = s32[] select(Arg_0.105, Arg_1.106, Arg_2.107)
}

remainder.109 {
  Arg_0.110 = s32[32768]{0} parameter(0)
  Arg_1.111 = s32[] parameter(1)
  constant.115 = s32[] constant(0)
  compare.116 = pred[] compare(Arg_1.111, constant.115), direction=EQ
  constant.114 = s32[] constant(1)
  call.117 = s32[] call(compare.116, constant.114, Arg_1.111), to_apply=_where.104
  broadcast.118 = s32[32768]{0} broadcast(call.117), dimensions={}
  remainder.119 = s32[32768]{0} remainder(Arg_0.110, broadcast.118)
  constant.112 = s32[] constant(0)
  broadcast.113 = s32[32768]{0} broadcast(constant.112), dimensions={}
  compare.121 = pred[32768]{0} compare(remainder.119, broadcast.113), direction=LT
  compare.122 = pred[] compare(call.117, constant.115), direction=LT
  broadcast.123 = pred[32768]{0} broadcast(compare.122), dimensions={}
  compare.124 = pred[32768]{0} compare(compare.121, broadcast.123), direction=NE
  compare.120 = pred[32768]{0} compare(remainder.119, broadcast.113), direction=NE
  and.125 = pred[32768]{0} and(compare.124, compare.120)
  broadcast.126 = s32[32768]{0} broadcast(call.117), dimensions={}
  add.127 = s32[32768]{0} add(remainder.119, broadcast.126)
  ROOT select.128 = s32[32768]{0} select(and.125, add.127, remainder.119)
}

_roll_dynamic.129 {
  Arg_0.130 = f64[32768,32]{1,0} parameter(0)
  concatenate.140 = f64[32768,64]{1,0} concatenate(Arg_0.130, Arg_0.130), dimensions={1}
  constant.136 = s32[] constant(32)
  broadcast.137 = s32[32768]{0} broadcast(constant.136), dimensions={}
  Arg_1.131 = s32[32768]{0} parameter(1)
  constant.138 = s32[] constant(32)
  call.139 = s32[32768]{0} call(Arg_1.131, constant.138), to_apply=remainder.109
  subtract.141 = s32[32768]{0} subtract(broadcast.137, call.139)
  constant.134 = s32[] constant(0)
  broadcast.135 = s32[32768]{0} broadcast(constant.134), dimensions={}
  compare.142 = pred[32768]{0} compare(subtract.141, broadcast.135), direction=LT
  constant.132 = s32[] constant(64)
  broadcast.133 = s32[32768]{0} broadcast(constant.132), dimensions={}
  add.143 = s32[32768]{0} add(subtract.141, broadcast.133)
  select.144 = s32[32768]{0} select(compare.142, add.143, subtract.141)
  reshape.145 = s32[32768,1]{1,0} reshape(select.144)
  ROOT gather.146 = f64[32768,32]{1,0} gather(concatenate.140, reshape.145), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.147 {
  Arg_0.148 = pred[] parameter(0)
  Arg_1.149 = s32[] parameter(1)
  Arg_2.150 = s32[] parameter(2)
  ROOT select.151 = s32[] select(Arg_0.148, Arg_1.149, Arg_2.150)
}

remainder.152 {
  Arg_0.153 = s32[32768]{0} parameter(0)
  Arg_1.154 = s32[] parameter(1)
  constant.158 = s32[] constant(0)
  compare.159 = pred[] compare(Arg_1.154, constant.158), direction=EQ
  constant.157 = s32[] constant(1)
  call.160 = s32[] call(compare.159, constant.157, Arg_1.154), to_apply=_where.147
  broadcast.161 = s32[32768]{0} broadcast(call.160), dimensions={}
  remainder.162 = s32[32768]{0} remainder(Arg_0.153, broadcast.161)
  constant.155 = s32[] constant(0)
  broadcast.156 = s32[32768]{0} broadcast(constant.155), dimensions={}
  compare.164 = pred[32768]{0} compare(remainder.162, broadcast.156), direction=LT
  compare.165 = pred[] compare(call.160, constant.158), direction=LT
  broadcast.166 = pred[32768]{0} broadcast(compare.165), dimensions={}
  compare.167 = pred[32768]{0} compare(compare.164, broadcast.166), direction=NE
  compare.163 = pred[32768]{0} compare(remainder.162, broadcast.156), direction=NE
  and.168 = pred[32768]{0} and(compare.167, compare.163)
  broadcast.169 = s32[32768]{0} broadcast(call.160), dimensions={}
  add.170 = s32[32768]{0} add(remainder.162, broadcast.169)
  ROOT select.171 = s32[32768]{0} select(and.168, add.170, remainder.162)
}

_roll_dynamic.172 {
  Arg_0.173 = f64[32768,32]{1,0} parameter(0)
  concatenate.183 = f64[32768,64]{1,0} concatenate(Arg_0.173, Arg_0.173), dimensions={1}
  constant.179 = s32[] constant(32)
  broadcast.180 = s32[32768]{0} broadcast(constant.179), dimensions={}
  Arg_1.174 = s32[32768]{0} parameter(1)
  constant.181 = s32[] constant(32)
  call.182 = s32[32768]{0} call(Arg_1.174, constant.181), to_apply=remainder.152
  subtract.184 = s32[32768]{0} subtract(broadcast.180, call.182)
  constant.177 = s32[] constant(0)
  broadcast.178 = s32[32768]{0} broadcast(constant.177), dimensions={}
  compare.185 = pred[32768]{0} compare(subtract.184, broadcast.178), direction=LT
  constant.175 = s32[] constant(64)
  broadcast.176 = s32[32768]{0} broadcast(constant.175), dimensions={}
  add.186 = s32[32768]{0} add(subtract.184, broadcast.176)
  select.187 = s32[32768]{0} select(compare.185, add.186, subtract.184)
  reshape.188 = s32[32768,1]{1,0} reshape(select.187)
  ROOT gather.189 = f64[32768,32]{1,0} gather(concatenate.183, reshape.188), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.190 {
  Arg_0.191 = pred[] parameter(0)
  Arg_1.192 = s32[] parameter(1)
  Arg_2.193 = s32[] parameter(2)
  ROOT select.194 = s32[] select(Arg_0.191, Arg_1.192, Arg_2.193)
}

remainder.195 {
  Arg_0.196 = s32[32768]{0} parameter(0)
  Arg_1.197 = s32[] parameter(1)
  constant.201 = s32[] constant(0)
  compare.202 = pred[] compare(Arg_1.197, constant.201), direction=EQ
  constant.200 = s32[] constant(1)
  call.203 = s32[] call(compare.202, constant.200, Arg_1.197), to_apply=_where.190
  broadcast.204 = s32[32768]{0} broadcast(call.203), dimensions={}
  remainder.205 = s32[32768]{0} remainder(Arg_0.196, broadcast.204)
  constant.198 = s32[] constant(0)
  broadcast.199 = s32[32768]{0} broadcast(constant.198), dimensions={}
  compare.207 = pred[32768]{0} compare(remainder.205, broadcast.199), direction=LT
  compare.208 = pred[] compare(call.203, constant.201), direction=LT
  broadcast.209 = pred[32768]{0} broadcast(compare.208), dimensions={}
  compare.210 = pred[32768]{0} compare(compare.207, broadcast.209), direction=NE
  compare.206 = pred[32768]{0} compare(remainder.205, broadcast.199), direction=NE
  and.211 = pred[32768]{0} and(compare.210, compare.206)
  broadcast.212 = s32[32768]{0} broadcast(call.203), dimensions={}
  add.213 = s32[32768]{0} add(remainder.205, broadcast.212)
  ROOT select.214 = s32[32768]{0} select(and.211, add.213, remainder.205)
}

_roll_dynamic.215 {
  Arg_0.216 = f64[32768,32]{1,0} parameter(0)
  concatenate.226 = f64[32768,64]{1,0} concatenate(Arg_0.216, Arg_0.216), dimensions={1}
  constant.222 = s32[] constant(32)
  broadcast.223 = s32[32768]{0} broadcast(constant.222), dimensions={}
  Arg_1.217 = s32[32768]{0} parameter(1)
  constant.224 = s32[] constant(32)
  call.225 = s32[32768]{0} call(Arg_1.217, constant.224), to_apply=remainder.195
  subtract.227 = s32[32768]{0} subtract(broadcast.223, call.225)
  constant.220 = s32[] constant(0)
  broadcast.221 = s32[32768]{0} broadcast(constant.220), dimensions={}
  compare.228 = pred[32768]{0} compare(subtract.227, broadcast.221), direction=LT
  constant.218 = s32[] constant(64)
  broadcast.219 = s32[32768]{0} broadcast(constant.218), dimensions={}
  add.229 = s32[32768]{0} add(subtract.227, broadcast.219)
  select.230 = s32[32768]{0} select(compare.228, add.229, subtract.227)
  reshape.231 = s32[32768,1]{1,0} reshape(select.230)
  ROOT gather.232 = f64[32768,32]{1,0} gather(concatenate.226, reshape.231), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.233 {
  Arg_0.234 = pred[] parameter(0)
  Arg_1.235 = s32[] parameter(1)
  Arg_2.236 = s32[] parameter(2)
  ROOT select.237 = s32[] select(Arg_0.234, Arg_1.235, Arg_2.236)
}

remainder.238 {
  Arg_0.239 = s32[32768]{0} parameter(0)
  Arg_1.240 = s32[] parameter(1)
  constant.244 = s32[] constant(0)
  compare.245 = pred[] compare(Arg_1.240, constant.244), direction=EQ
  constant.243 = s32[] constant(1)
  call.246 = s32[] call(compare.245, constant.243, Arg_1.240), to_apply=_where.233
  broadcast.247 = s32[32768]{0} broadcast(call.246), dimensions={}
  remainder.248 = s32[32768]{0} remainder(Arg_0.239, broadcast.247)
  constant.241 = s32[] constant(0)
  broadcast.242 = s32[32768]{0} broadcast(constant.241), dimensions={}
  compare.250 = pred[32768]{0} compare(remainder.248, broadcast.242), direction=LT
  compare.251 = pred[] compare(call.246, constant.244), direction=LT
  broadcast.252 = pred[32768]{0} broadcast(compare.251), dimensions={}
  compare.253 = pred[32768]{0} compare(compare.250, broadcast.252), direction=NE
  compare.249 = pred[32768]{0} compare(remainder.248, broadcast.242), direction=NE
  and.254 = pred[32768]{0} and(compare.253, compare.249)
  broadcast.255 = s32[32768]{0} broadcast(call.246), dimensions={}
  add.256 = s32[32768]{0} add(remainder.248, broadcast.255)
  ROOT select.257 = s32[32768]{0} select(and.254, add.256, remainder.248)
}

_roll_dynamic.258 {
  Arg_0.259 = f64[32768,32]{1,0} parameter(0)
  concatenate.269 = f64[32768,64]{1,0} concatenate(Arg_0.259, Arg_0.259), dimensions={1}
  constant.265 = s32[] constant(32)
  broadcast.266 = s32[32768]{0} broadcast(constant.265), dimensions={}
  Arg_1.260 = s32[32768]{0} parameter(1)
  constant.267 = s32[] constant(32)
  call.268 = s32[32768]{0} call(Arg_1.260, constant.267), to_apply=remainder.238
  subtract.270 = s32[32768]{0} subtract(broadcast.266, call.268)
  constant.263 = s32[] constant(0)
  broadcast.264 = s32[32768]{0} broadcast(constant.263), dimensions={}
  compare.271 = pred[32768]{0} compare(subtract.270, broadcast.264), direction=LT
  constant.261 = s32[] constant(64)
  broadcast.262 = s32[32768]{0} broadcast(constant.261), dimensions={}
  add.272 = s32[32768]{0} add(subtract.270, broadcast.262)
  select.273 = s32[32768]{0} select(compare.271, add.272, subtract.270)
  reshape.274 = s32[32768,1]{1,0} reshape(select.273)
  ROOT gather.275 = f64[32768,32]{1,0} gather(concatenate.269, reshape.274), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.276 {
  Arg_0.277 = f64[32768,32]{1,0} parameter(0)
  Arg_1.278 = f64[32768]{0} parameter(1)
  Arg_2.279 = f64[] parameter(2)
  broadcast.306 = f64[32768]{0} broadcast(Arg_2.279), dimensions={}
  multiply.307 = f64[32768]{0} multiply(Arg_1.278, broadcast.306)
  Arg_3.280 = f64[] parameter(3)
  broadcast.308 = f64[32768]{0} broadcast(Arg_3.280), dimensions={}
  divide.309 = f64[32768]{0} divide(multiply.307, broadcast.308)
  floor.310 = f64[32768]{0} floor(divide.309)
  convert.312 = s32[32768]{0} convert(floor.310)
  Arg_4.281 = s32[6]{0} parameter(4)
  slice.375 = s32[1]{0} slice(Arg_4.281), slice={[0:1]}
  reshape.376 = s32[] reshape(slice.375)
  broadcast.377 = s32[32768]{0} broadcast(reshape.376), dimensions={}
  add.378 = s32[32768]{0} add(convert.312, broadcast.377)
  call.379 = f64[32768,32]{1,0} call(Arg_0.277, add.378), to_apply=_roll_dynamic.43
  subtract.311 = f64[32768]{0} subtract(divide.309, floor.310)
  constant.304 = f64[] constant(20)
  broadcast.305 = f64[32768]{0} broadcast(constant.304), dimensions={}
  divide.317 = f64[32768]{0} divide(subtract.311, broadcast.305)
  multiply.313 = f64[32768]{0} multiply(subtract.311, subtract.311)
  constant.302 = f64[] constant(24)
  broadcast.303 = f64[32768]{0} broadcast(constant.302), dimensions={}
  divide.318 = f64[32768]{0} divide(multiply.313, broadcast.303)
  subtract.319 = f64[32768]{0} subtract(divide.317, divide.318)
  multiply.314 = f64[32768]{0} multiply(multiply.313, subtract.311)
  divide.320 = f64[32768]{0} divide(multiply.314, broadcast.303)
  subtract.321 = f64[32768]{0} subtract(subtract.319, divide.320)
  multiply.315 = f64[32768]{0} multiply(multiply.314, subtract.311)
  divide.322 = f64[32768]{0} divide(multiply.315, broadcast.303)
  add.323 = f64[32768]{0} add(subtract.321, divide.322)
  multiply.316 = f64[32768]{0} multiply(multiply.315, subtract.311)
  constant.300 = f64[] constant(120)
  broadcast.301 = f64[32768]{0} broadcast(constant.300), dimensions={}
  divide.324 = f64[32768]{0} divide(multiply.316, broadcast.301)
  subtract.325 = f64[32768]{0} subtract(add.323, divide.324)
  reshape.380 = f64[32768,1]{1,0} reshape(subtract.325)
  broadcast.381 = f64[32768,1]{1,0} broadcast(reshape.380), dimensions={0,1}
  reshape.382 = f64[32768]{0} reshape(broadcast.381)
  broadcast.383 = f64[32768,32]{1,0} broadcast(reshape.382), dimensions={0}
  multiply.384 = f64[32768,32]{1,0} multiply(call.379, broadcast.383)
  slice.385 = s32[1]{0} slice(Arg_4.281), slice={[1:2]}
  reshape.386 = s32[] reshape(slice.385)
  broadcast.387 = s32[32768]{0} broadcast(reshape.386), dimensions={}
  add.388 = s32[32768]{0} add(convert.312, broadcast.387)
  call.389 = f64[32768,32]{1,0} call(Arg_0.277, add.388), to_apply=_roll_dynamic.86
  constant.298 = f64[] constant(2)
  broadcast.299 = f64[32768]{0} broadcast(constant.298), dimensions={}
  divide.326 = f64[32768]{0} divide(subtract.311, broadcast.299)
  negate.327 = f64[32768]{0} negate(divide.326)
  multiply.328 = f64[32768]{0} multiply(multiply.313, broadcast.299)
  constant.296 = f64[] constant(3)
  broadcast.297 = f64[32768]{0} broadcast(constant.296), dimensions={}
  divide.329 = f64[32768]{0} divide(multiply.328, broadcast.297)
  add.330 = f64[32768]{0} add(negate.327, divide.329)
  divide.331 = f64[32768]{0} divide(multiply.314, broadcast.303)
  subtract.332 = f64[32768]{0} subtract(add.330, divide.331)
  constant.294 = f64[] constant(6)
  broadcast.295 = f64[32768]{0} broadcast(constant.294), dimensions={}
  divide.333 = f64[32768]{0} divide(multiply.315, broadcast.295)
  subtract.334 = f64[32768]{0} subtract(subtract.332, divide.333)
  divide.335 = f64[32768]{0} divide(multiply.316, broadcast.303)
  add.336 = f64[32768]{0} add(subtract.334, divide.335)
  reshape.390 = f64[32768,1]{1,0} reshape(add.336)
  broadcast.391 = f64[32768,1]{1,0} broadcast(reshape.390), dimensions={0,1}
  reshape.392 = f64[32768]{0} reshape(broadcast.391)
  broadcast.393 = f64[32768,32]{1,0} broadcast(reshape.392), dimensions={0}
  multiply.394 = f64[32768,32]{1,0} multiply(call.389, broadcast.393)
  add.395 = f64[32768,32]{1,0} add(multiply.384, multiply.394)
  slice.396 = s32[1]{0} slice(Arg_4.281), slice={[2:3]}
  reshape.397 = s32[] reshape(slice.396)
  broadcast.398 = s32[32768]{0} broadcast(reshape.397), dimensions={}
  add.399 = s32[32768]{0} add(convert.312, broadcast.398)
  call.400 = f64[32768,32]{1,0} call(Arg_0.277, add.399), to_apply=_roll_dynamic.129
  constant.292 = f64[] constant(1)
  broadcast.293 = f64[32768]{0} broadcast(constant.292), dimensions={}
  divide.337 = f64[32768]{0} divide(subtract.311, broadcast.297)
  subtract.338 = f64[32768]{0} subtract(broadcast.293, divide.337)
  constant.290 = f64[] constant(5)
  broadcast.291 = f64[32768]{0} broadcast(constant.290), dimensions={}
  multiply.339 = f64[32768]{0} multiply(multiply.313, broadcast.291)
  constant.288 = f64[] constant(4)
  broadcast.289 = f64[32768]{0} broadcast(constant.288), dimensions={}
  divide.340 = f64[32768]{0} divide(multiply.339, broadcast.289)
  subtract.341 = f64[32768]{0} subtract(subtract.338, divide.340)
  multiply.342 = f64[32768]{0} multiply(multiply.314, broadcast.291)
  constant.286 = f64[] constant(12)
  broadcast.287 = f64[32768]{0} broadcast(constant.286), dimensions={}
  divide.343 = f64[32768]{0} divide(multiply.342, broadcast.287)
  add.344 = f64[32768]{0} add(subtract.341, divide.343)
  divide.345 = f64[32768]{0} divide(multiply.315, broadcast.289)
  add.346 = f64[32768]{0} add(add.344, divide.345)
  divide.347 = f64[32768]{0} divide(multiply.316, broadcast.287)
  subtract.348 = f64[32768]{0} subtract(add.346, divide.347)
  reshape.401 = f64[32768,1]{1,0} reshape(subtract.348)
  broadcast.402 = f64[32768,1]{1,0} broadcast(reshape.401), dimensions={0,1}
  reshape.403 = f64[32768]{0} reshape(broadcast.402)
  broadcast.404 = f64[32768,32]{1,0} broadcast(reshape.403), dimensions={0}
  multiply.405 = f64[32768,32]{1,0} multiply(call.400, broadcast.404)
  add.406 = f64[32768,32]{1,0} add(add.395, multiply.405)
  slice.407 = s32[1]{0} slice(Arg_4.281), slice={[3:4]}
  reshape.408 = s32[] reshape(slice.407)
  broadcast.409 = s32[32768]{0} broadcast(reshape.408), dimensions={}
  add.410 = s32[32768]{0} add(convert.312, broadcast.409)
  call.411 = f64[32768,32]{1,0} call(Arg_0.277, add.410), to_apply=_roll_dynamic.172
  multiply.349 = f64[32768]{0} multiply(multiply.313, broadcast.299)
  divide.350 = f64[32768]{0} divide(multiply.349, broadcast.297)
  add.351 = f64[32768]{0} add(subtract.311, divide.350)
  constant.284 = f64[] constant(7)
  broadcast.285 = f64[32768]{0} broadcast(constant.284), dimensions={}
  multiply.352 = f64[32768]{0} multiply(multiply.314, broadcast.285)
  divide.353 = f64[32768]{0} divide(multiply.352, broadcast.287)
  subtract.354 = f64[32768]{0} subtract(add.351, divide.353)
  divide.355 = f64[32768]{0} divide(multiply.315, broadcast.295)
  subtract.356 = f64[32768]{0} subtract(subtract.354, divide.355)
  divide.357 = f64[32768]{0} divide(multiply.316, broadcast.287)
  add.358 = f64[32768]{0} add(subtract.356, divide.357)
  reshape.412 = f64[32768,1]{1,0} reshape(add.358)
  broadcast.413 = f64[32768,1]{1,0} broadcast(reshape.412), dimensions={0,1}
  reshape.414 = f64[32768]{0} reshape(broadcast.413)
  broadcast.415 = f64[32768,32]{1,0} broadcast(reshape.414), dimensions={0}
  multiply.416 = f64[32768,32]{1,0} multiply(call.411, broadcast.415)
  add.417 = f64[32768,32]{1,0} add(add.406, multiply.416)
  slice.418 = s32[1]{0} slice(Arg_4.281), slice={[4:5]}
  reshape.419 = s32[] reshape(slice.418)
  broadcast.420 = s32[32768]{0} broadcast(reshape.419), dimensions={}
  add.421 = s32[32768]{0} add(convert.312, broadcast.420)
  call.422 = f64[32768,32]{1,0} call(Arg_0.277, add.421), to_apply=_roll_dynamic.215
  divide.359 = f64[32768]{0} divide(subtract.311, broadcast.289)
  negate.360 = f64[32768]{0} negate(divide.359)
  divide.361 = f64[32768]{0} divide(multiply.313, broadcast.303)
  subtract.362 = f64[32768]{0} subtract(negate.360, divide.361)
  multiply.363 = f64[32768]{0} multiply(multiply.314, broadcast.285)
  divide.364 = f64[32768]{0} divide(multiply.363, broadcast.303)
  add.365 = f64[32768]{0} add(subtract.362, divide.364)
  divide.366 = f64[32768]{0} divide(multiply.315, broadcast.303)
  add.367 = f64[32768]{0} add(add.365, divide.366)
  divide.368 = f64[32768]{0} divide(multiply.316, broadcast.303)
  subtract.369 = f64[32768]{0} subtract(add.367, divide.368)
  reshape.423 = f64[32768,1]{1,0} reshape(subtract.369)
  broadcast.424 = f64[32768,1]{1,0} broadcast(reshape.423), dimensions={0,1}
  reshape.425 = f64[32768]{0} reshape(broadcast.424)
  broadcast.426 = f64[32768,32]{1,0} broadcast(reshape.425), dimensions={0}
  multiply.427 = f64[32768,32]{1,0} multiply(call.422, broadcast.426)
  add.428 = f64[32768,32]{1,0} add(add.417, multiply.427)
  slice.429 = s32[1]{0} slice(Arg_4.281), slice={[5:6]}
  reshape.430 = s32[] reshape(slice.429)
  broadcast.431 = s32[32768]{0} broadcast(reshape.430), dimensions={}
  add.432 = s32[32768]{0} add(convert.312, broadcast.431)
  call.433 = f64[32768,32]{1,0} call(Arg_0.277, add.432), to_apply=_roll_dynamic.258
  constant.282 = f64[] constant(30)
  broadcast.283 = f64[32768]{0} broadcast(constant.282), dimensions={}
  divide.370 = f64[32768]{0} divide(subtract.311, broadcast.283)
  divide.371 = f64[32768]{0} divide(multiply.314, broadcast.303)
  subtract.372 = f64[32768]{0} subtract(divide.370, divide.371)
  divide.373 = f64[32768]{0} divide(multiply.316, broadcast.301)
  add.374 = f64[32768]{0} add(subtract.372, divide.373)
  reshape.434 = f64[32768,1]{1,0} reshape(add.374)
  broadcast.435 = f64[32768,1]{1,0} broadcast(reshape.434), dimensions={0,1}
  reshape.436 = f64[32768]{0} reshape(broadcast.435)
  broadcast.437 = f64[32768,32]{1,0} broadcast(reshape.436), dimensions={0}
  multiply.438 = f64[32768,32]{1,0} multiply(call.433, broadcast.437)
  ROOT add.439 = f64[32768,32]{1,0} add(add.428, multiply.438)
}

_where.448 {
  Arg_0.449 = pred[] parameter(0)
  Arg_1.450 = s32[] parameter(1)
  Arg_2.451 = s32[] parameter(2)
  ROOT select.452 = s32[] select(Arg_0.449, Arg_1.450, Arg_2.451)
}

remainder.453 {
  Arg_0.454 = s32[32768]{0} parameter(0)
  Arg_1.455 = s32[] parameter(1)
  constant.459 = s32[] constant(0)
  compare.460 = pred[] compare(Arg_1.455, constant.459), direction=EQ
  constant.458 = s32[] constant(1)
  call.461 = s32[] call(compare.460, constant.458, Arg_1.455), to_apply=_where.448
  broadcast.462 = s32[32768]{0} broadcast(call.461), dimensions={}
  remainder.463 = s32[32768]{0} remainder(Arg_0.454, broadcast.462)
  constant.456 = s32[] constant(0)
  broadcast.457 = s32[32768]{0} broadcast(constant.456), dimensions={}
  compare.465 = pred[32768]{0} compare(remainder.463, broadcast.457), direction=LT
  compare.466 = pred[] compare(call.461, constant.459), direction=LT
  broadcast.467 = pred[32768]{0} broadcast(compare.466), dimensions={}
  compare.468 = pred[32768]{0} compare(compare.465, broadcast.467), direction=NE
  compare.464 = pred[32768]{0} compare(remainder.463, broadcast.457), direction=NE
  and.469 = pred[32768]{0} and(compare.468, compare.464)
  broadcast.470 = s32[32768]{0} broadcast(call.461), dimensions={}
  add.471 = s32[32768]{0} add(remainder.463, broadcast.470)
  ROOT select.472 = s32[32768]{0} select(and.469, add.471, remainder.463)
}

_roll_dynamic.473 {
  Arg_0.474 = f64[32768,32]{1,0} parameter(0)
  concatenate.484 = f64[32768,64]{1,0} concatenate(Arg_0.474, Arg_0.474), dimensions={1}
  constant.480 = s32[] constant(32)
  broadcast.481 = s32[32768]{0} broadcast(constant.480), dimensions={}
  Arg_1.475 = s32[32768]{0} parameter(1)
  constant.482 = s32[] constant(32)
  call.483 = s32[32768]{0} call(Arg_1.475, constant.482), to_apply=remainder.453
  subtract.485 = s32[32768]{0} subtract(broadcast.481, call.483)
  constant.478 = s32[] constant(0)
  broadcast.479 = s32[32768]{0} broadcast(constant.478), dimensions={}
  compare.486 = pred[32768]{0} compare(subtract.485, broadcast.479), direction=LT
  constant.476 = s32[] constant(64)
  broadcast.477 = s32[32768]{0} broadcast(constant.476), dimensions={}
  add.487 = s32[32768]{0} add(subtract.485, broadcast.477)
  select.488 = s32[32768]{0} select(compare.486, add.487, subtract.485)
  reshape.489 = s32[32768,1]{1,0} reshape(select.488)
  ROOT gather.490 = f64[32768,32]{1,0} gather(concatenate.484, reshape.489), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.491 {
  Arg_0.492 = pred[] parameter(0)
  Arg_1.493 = s32[] parameter(1)
  Arg_2.494 = s32[] parameter(2)
  ROOT select.495 = s32[] select(Arg_0.492, Arg_1.493, Arg_2.494)
}

remainder.496 {
  Arg_0.497 = s32[32768]{0} parameter(0)
  Arg_1.498 = s32[] parameter(1)
  constant.502 = s32[] constant(0)
  compare.503 = pred[] compare(Arg_1.498, constant.502), direction=EQ
  constant.501 = s32[] constant(1)
  call.504 = s32[] call(compare.503, constant.501, Arg_1.498), to_apply=_where.491
  broadcast.505 = s32[32768]{0} broadcast(call.504), dimensions={}
  remainder.506 = s32[32768]{0} remainder(Arg_0.497, broadcast.505)
  constant.499 = s32[] constant(0)
  broadcast.500 = s32[32768]{0} broadcast(constant.499), dimensions={}
  compare.508 = pred[32768]{0} compare(remainder.506, broadcast.500), direction=LT
  compare.509 = pred[] compare(call.504, constant.502), direction=LT
  broadcast.510 = pred[32768]{0} broadcast(compare.509), dimensions={}
  compare.511 = pred[32768]{0} compare(compare.508, broadcast.510), direction=NE
  compare.507 = pred[32768]{0} compare(remainder.506, broadcast.500), direction=NE
  and.512 = pred[32768]{0} and(compare.511, compare.507)
  broadcast.513 = s32[32768]{0} broadcast(call.504), dimensions={}
  add.514 = s32[32768]{0} add(remainder.506, broadcast.513)
  ROOT select.515 = s32[32768]{0} select(and.512, add.514, remainder.506)
}

_roll_dynamic.516 {
  Arg_0.517 = f64[32768,32]{1,0} parameter(0)
  concatenate.527 = f64[32768,64]{1,0} concatenate(Arg_0.517, Arg_0.517), dimensions={1}
  constant.523 = s32[] constant(32)
  broadcast.524 = s32[32768]{0} broadcast(constant.523), dimensions={}
  Arg_1.518 = s32[32768]{0} parameter(1)
  constant.525 = s32[] constant(32)
  call.526 = s32[32768]{0} call(Arg_1.518, constant.525), to_apply=remainder.496
  subtract.528 = s32[32768]{0} subtract(broadcast.524, call.526)
  constant.521 = s32[] constant(0)
  broadcast.522 = s32[32768]{0} broadcast(constant.521), dimensions={}
  compare.529 = pred[32768]{0} compare(subtract.528, broadcast.522), direction=LT
  constant.519 = s32[] constant(64)
  broadcast.520 = s32[32768]{0} broadcast(constant.519), dimensions={}
  add.530 = s32[32768]{0} add(subtract.528, broadcast.520)
  select.531 = s32[32768]{0} select(compare.529, add.530, subtract.528)
  reshape.532 = s32[32768,1]{1,0} reshape(select.531)
  ROOT gather.533 = f64[32768,32]{1,0} gather(concatenate.527, reshape.532), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.534 {
  Arg_0.535 = pred[] parameter(0)
  Arg_1.536 = s32[] parameter(1)
  Arg_2.537 = s32[] parameter(2)
  ROOT select.538 = s32[] select(Arg_0.535, Arg_1.536, Arg_2.537)
}

remainder.539 {
  Arg_0.540 = s32[32768]{0} parameter(0)
  Arg_1.541 = s32[] parameter(1)
  constant.545 = s32[] constant(0)
  compare.546 = pred[] compare(Arg_1.541, constant.545), direction=EQ
  constant.544 = s32[] constant(1)
  call.547 = s32[] call(compare.546, constant.544, Arg_1.541), to_apply=_where.534
  broadcast.548 = s32[32768]{0} broadcast(call.547), dimensions={}
  remainder.549 = s32[32768]{0} remainder(Arg_0.540, broadcast.548)
  constant.542 = s32[] constant(0)
  broadcast.543 = s32[32768]{0} broadcast(constant.542), dimensions={}
  compare.551 = pred[32768]{0} compare(remainder.549, broadcast.543), direction=LT
  compare.552 = pred[] compare(call.547, constant.545), direction=LT
  broadcast.553 = pred[32768]{0} broadcast(compare.552), dimensions={}
  compare.554 = pred[32768]{0} compare(compare.551, broadcast.553), direction=NE
  compare.550 = pred[32768]{0} compare(remainder.549, broadcast.543), direction=NE
  and.555 = pred[32768]{0} and(compare.554, compare.550)
  broadcast.556 = s32[32768]{0} broadcast(call.547), dimensions={}
  add.557 = s32[32768]{0} add(remainder.549, broadcast.556)
  ROOT select.558 = s32[32768]{0} select(and.555, add.557, remainder.549)
}

_roll_dynamic.559 {
  Arg_0.560 = f64[32768,32]{1,0} parameter(0)
  concatenate.570 = f64[32768,64]{1,0} concatenate(Arg_0.560, Arg_0.560), dimensions={1}
  constant.566 = s32[] constant(32)
  broadcast.567 = s32[32768]{0} broadcast(constant.566), dimensions={}
  Arg_1.561 = s32[32768]{0} parameter(1)
  constant.568 = s32[] constant(32)
  call.569 = s32[32768]{0} call(Arg_1.561, constant.568), to_apply=remainder.539
  subtract.571 = s32[32768]{0} subtract(broadcast.567, call.569)
  constant.564 = s32[] constant(0)
  broadcast.565 = s32[32768]{0} broadcast(constant.564), dimensions={}
  compare.572 = pred[32768]{0} compare(subtract.571, broadcast.565), direction=LT
  constant.562 = s32[] constant(64)
  broadcast.563 = s32[32768]{0} broadcast(constant.562), dimensions={}
  add.573 = s32[32768]{0} add(subtract.571, broadcast.563)
  select.574 = s32[32768]{0} select(compare.572, add.573, subtract.571)
  reshape.575 = s32[32768,1]{1,0} reshape(select.574)
  ROOT gather.576 = f64[32768,32]{1,0} gather(concatenate.570, reshape.575), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.577 {
  Arg_0.578 = pred[] parameter(0)
  Arg_1.579 = s32[] parameter(1)
  Arg_2.580 = s32[] parameter(2)
  ROOT select.581 = s32[] select(Arg_0.578, Arg_1.579, Arg_2.580)
}

remainder.582 {
  Arg_0.583 = s32[32768]{0} parameter(0)
  Arg_1.584 = s32[] parameter(1)
  constant.588 = s32[] constant(0)
  compare.589 = pred[] compare(Arg_1.584, constant.588), direction=EQ
  constant.587 = s32[] constant(1)
  call.590 = s32[] call(compare.589, constant.587, Arg_1.584), to_apply=_where.577
  broadcast.591 = s32[32768]{0} broadcast(call.590), dimensions={}
  remainder.592 = s32[32768]{0} remainder(Arg_0.583, broadcast.591)
  constant.585 = s32[] constant(0)
  broadcast.586 = s32[32768]{0} broadcast(constant.585), dimensions={}
  compare.594 = pred[32768]{0} compare(remainder.592, broadcast.586), direction=LT
  compare.595 = pred[] compare(call.590, constant.588), direction=LT
  broadcast.596 = pred[32768]{0} broadcast(compare.595), dimensions={}
  compare.597 = pred[32768]{0} compare(compare.594, broadcast.596), direction=NE
  compare.593 = pred[32768]{0} compare(remainder.592, broadcast.586), direction=NE
  and.598 = pred[32768]{0} and(compare.597, compare.593)
  broadcast.599 = s32[32768]{0} broadcast(call.590), dimensions={}
  add.600 = s32[32768]{0} add(remainder.592, broadcast.599)
  ROOT select.601 = s32[32768]{0} select(and.598, add.600, remainder.592)
}

_roll_dynamic.602 {
  Arg_0.603 = f64[32768,32]{1,0} parameter(0)
  concatenate.613 = f64[32768,64]{1,0} concatenate(Arg_0.603, Arg_0.603), dimensions={1}
  constant.609 = s32[] constant(32)
  broadcast.610 = s32[32768]{0} broadcast(constant.609), dimensions={}
  Arg_1.604 = s32[32768]{0} parameter(1)
  constant.611 = s32[] constant(32)
  call.612 = s32[32768]{0} call(Arg_1.604, constant.611), to_apply=remainder.582
  subtract.614 = s32[32768]{0} subtract(broadcast.610, call.612)
  constant.607 = s32[] constant(0)
  broadcast.608 = s32[32768]{0} broadcast(constant.607), dimensions={}
  compare.615 = pred[32768]{0} compare(subtract.614, broadcast.608), direction=LT
  constant.605 = s32[] constant(64)
  broadcast.606 = s32[32768]{0} broadcast(constant.605), dimensions={}
  add.616 = s32[32768]{0} add(subtract.614, broadcast.606)
  select.617 = s32[32768]{0} select(compare.615, add.616, subtract.614)
  reshape.618 = s32[32768,1]{1,0} reshape(select.617)
  ROOT gather.619 = f64[32768,32]{1,0} gather(concatenate.613, reshape.618), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.620 {
  Arg_0.621 = pred[] parameter(0)
  Arg_1.622 = s32[] parameter(1)
  Arg_2.623 = s32[] parameter(2)
  ROOT select.624 = s32[] select(Arg_0.621, Arg_1.622, Arg_2.623)
}

remainder.625 {
  Arg_0.626 = s32[32768]{0} parameter(0)
  Arg_1.627 = s32[] parameter(1)
  constant.631 = s32[] constant(0)
  compare.632 = pred[] compare(Arg_1.627, constant.631), direction=EQ
  constant.630 = s32[] constant(1)
  call.633 = s32[] call(compare.632, constant.630, Arg_1.627), to_apply=_where.620
  broadcast.634 = s32[32768]{0} broadcast(call.633), dimensions={}
  remainder.635 = s32[32768]{0} remainder(Arg_0.626, broadcast.634)
  constant.628 = s32[] constant(0)
  broadcast.629 = s32[32768]{0} broadcast(constant.628), dimensions={}
  compare.637 = pred[32768]{0} compare(remainder.635, broadcast.629), direction=LT
  compare.638 = pred[] compare(call.633, constant.631), direction=LT
  broadcast.639 = pred[32768]{0} broadcast(compare.638), dimensions={}
  compare.640 = pred[32768]{0} compare(compare.637, broadcast.639), direction=NE
  compare.636 = pred[32768]{0} compare(remainder.635, broadcast.629), direction=NE
  and.641 = pred[32768]{0} and(compare.640, compare.636)
  broadcast.642 = s32[32768]{0} broadcast(call.633), dimensions={}
  add.643 = s32[32768]{0} add(remainder.635, broadcast.642)
  ROOT select.644 = s32[32768]{0} select(and.641, add.643, remainder.635)
}

_roll_dynamic.645 {
  Arg_0.646 = f64[32768,32]{1,0} parameter(0)
  concatenate.656 = f64[32768,64]{1,0} concatenate(Arg_0.646, Arg_0.646), dimensions={1}
  constant.652 = s32[] constant(32)
  broadcast.653 = s32[32768]{0} broadcast(constant.652), dimensions={}
  Arg_1.647 = s32[32768]{0} parameter(1)
  constant.654 = s32[] constant(32)
  call.655 = s32[32768]{0} call(Arg_1.647, constant.654), to_apply=remainder.625
  subtract.657 = s32[32768]{0} subtract(broadcast.653, call.655)
  constant.650 = s32[] constant(0)
  broadcast.651 = s32[32768]{0} broadcast(constant.650), dimensions={}
  compare.658 = pred[32768]{0} compare(subtract.657, broadcast.651), direction=LT
  constant.648 = s32[] constant(64)
  broadcast.649 = s32[32768]{0} broadcast(constant.648), dimensions={}
  add.659 = s32[32768]{0} add(subtract.657, broadcast.649)
  select.660 = s32[32768]{0} select(compare.658, add.659, subtract.657)
  reshape.661 = s32[32768,1]{1,0} reshape(select.660)
  ROOT gather.662 = f64[32768,32]{1,0} gather(concatenate.656, reshape.661), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.663 {
  Arg_0.664 = pred[] parameter(0)
  Arg_1.665 = s32[] parameter(1)
  Arg_2.666 = s32[] parameter(2)
  ROOT select.667 = s32[] select(Arg_0.664, Arg_1.665, Arg_2.666)
}

remainder.668 {
  Arg_0.669 = s32[32768]{0} parameter(0)
  Arg_1.670 = s32[] parameter(1)
  constant.674 = s32[] constant(0)
  compare.675 = pred[] compare(Arg_1.670, constant.674), direction=EQ
  constant.673 = s32[] constant(1)
  call.676 = s32[] call(compare.675, constant.673, Arg_1.670), to_apply=_where.663
  broadcast.677 = s32[32768]{0} broadcast(call.676), dimensions={}
  remainder.678 = s32[32768]{0} remainder(Arg_0.669, broadcast.677)
  constant.671 = s32[] constant(0)
  broadcast.672 = s32[32768]{0} broadcast(constant.671), dimensions={}
  compare.680 = pred[32768]{0} compare(remainder.678, broadcast.672), direction=LT
  compare.681 = pred[] compare(call.676, constant.674), direction=LT
  broadcast.682 = pred[32768]{0} broadcast(compare.681), dimensions={}
  compare.683 = pred[32768]{0} compare(compare.680, broadcast.682), direction=NE
  compare.679 = pred[32768]{0} compare(remainder.678, broadcast.672), direction=NE
  and.684 = pred[32768]{0} and(compare.683, compare.679)
  broadcast.685 = s32[32768]{0} broadcast(call.676), dimensions={}
  add.686 = s32[32768]{0} add(remainder.678, broadcast.685)
  ROOT select.687 = s32[32768]{0} select(and.684, add.686, remainder.678)
}

_roll_dynamic.688 {
  Arg_0.689 = f64[32768,32]{1,0} parameter(0)
  concatenate.699 = f64[32768,64]{1,0} concatenate(Arg_0.689, Arg_0.689), dimensions={1}
  constant.695 = s32[] constant(32)
  broadcast.696 = s32[32768]{0} broadcast(constant.695), dimensions={}
  Arg_1.690 = s32[32768]{0} parameter(1)
  constant.697 = s32[] constant(32)
  call.698 = s32[32768]{0} call(Arg_1.690, constant.697), to_apply=remainder.668
  subtract.700 = s32[32768]{0} subtract(broadcast.696, call.698)
  constant.693 = s32[] constant(0)
  broadcast.694 = s32[32768]{0} broadcast(constant.693), dimensions={}
  compare.701 = pred[32768]{0} compare(subtract.700, broadcast.694), direction=LT
  constant.691 = s32[] constant(64)
  broadcast.692 = s32[32768]{0} broadcast(constant.691), dimensions={}
  add.702 = s32[32768]{0} add(subtract.700, broadcast.692)
  select.703 = s32[32768]{0} select(compare.701, add.702, subtract.700)
  reshape.704 = s32[32768,1]{1,0} reshape(select.703)
  ROOT gather.705 = f64[32768,32]{1,0} gather(concatenate.699, reshape.704), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.706 {
  Arg_0.707 = f64[32768,32]{1,0} parameter(0)
  Arg_1.708 = f64[32768]{0} parameter(1)
  Arg_2.709 = f64[] parameter(2)
  broadcast.736 = f64[32768]{0} broadcast(Arg_2.709), dimensions={}
  multiply.737 = f64[32768]{0} multiply(Arg_1.708, broadcast.736)
  Arg_3.710 = f64[] parameter(3)
  broadcast.738 = f64[32768]{0} broadcast(Arg_3.710), dimensions={}
  divide.739 = f64[32768]{0} divide(multiply.737, broadcast.738)
  floor.740 = f64[32768]{0} floor(divide.739)
  convert.742 = s32[32768]{0} convert(floor.740)
  Arg_4.711 = s32[6]{0} parameter(4)
  slice.805 = s32[1]{0} slice(Arg_4.711), slice={[0:1]}
  reshape.806 = s32[] reshape(slice.805)
  broadcast.807 = s32[32768]{0} broadcast(reshape.806), dimensions={}
  add.808 = s32[32768]{0} add(convert.742, broadcast.807)
  call.809 = f64[32768,32]{1,0} call(Arg_0.707, add.808), to_apply=_roll_dynamic.473
  subtract.741 = f64[32768]{0} subtract(divide.739, floor.740)
  constant.734 = f64[] constant(20)
  broadcast.735 = f64[32768]{0} broadcast(constant.734), dimensions={}
  divide.747 = f64[32768]{0} divide(subtract.741, broadcast.735)
  multiply.743 = f64[32768]{0} multiply(subtract.741, subtract.741)
  constant.732 = f64[] constant(24)
  broadcast.733 = f64[32768]{0} broadcast(constant.732), dimensions={}
  divide.748 = f64[32768]{0} divide(multiply.743, broadcast.733)
  subtract.749 = f64[32768]{0} subtract(divide.747, divide.748)
  multiply.744 = f64[32768]{0} multiply(multiply.743, subtract.741)
  divide.750 = f64[32768]{0} divide(multiply.744, broadcast.733)
  subtract.751 = f64[32768]{0} subtract(subtract.749, divide.750)
  multiply.745 = f64[32768]{0} multiply(multiply.744, subtract.741)
  divide.752 = f64[32768]{0} divide(multiply.745, broadcast.733)
  add.753 = f64[32768]{0} add(subtract.751, divide.752)
  multiply.746 = f64[32768]{0} multiply(multiply.745, subtract.741)
  constant.730 = f64[] constant(120)
  broadcast.731 = f64[32768]{0} broadcast(constant.730), dimensions={}
  divide.754 = f64[32768]{0} divide(multiply.746, broadcast.731)
  subtract.755 = f64[32768]{0} subtract(add.753, divide.754)
  reshape.810 = f64[32768,1]{1,0} reshape(subtract.755)
  broadcast.811 = f64[32768,1]{1,0} broadcast(reshape.810), dimensions={0,1}
  reshape.812 = f64[32768]{0} reshape(broadcast.811)
  broadcast.813 = f64[32768,32]{1,0} broadcast(reshape.812), dimensions={0}
  multiply.814 = f64[32768,32]{1,0} multiply(call.809, broadcast.813)
  slice.815 = s32[1]{0} slice(Arg_4.711), slice={[1:2]}
  reshape.816 = s32[] reshape(slice.815)
  broadcast.817 = s32[32768]{0} broadcast(reshape.816), dimensions={}
  add.818 = s32[32768]{0} add(convert.742, broadcast.817)
  call.819 = f64[32768,32]{1,0} call(Arg_0.707, add.818), to_apply=_roll_dynamic.516
  constant.728 = f64[] constant(2)
  broadcast.729 = f64[32768]{0} broadcast(constant.728), dimensions={}
  divide.756 = f64[32768]{0} divide(subtract.741, broadcast.729)
  negate.757 = f64[32768]{0} negate(divide.756)
  multiply.758 = f64[32768]{0} multiply(multiply.743, broadcast.729)
  constant.726 = f64[] constant(3)
  broadcast.727 = f64[32768]{0} broadcast(constant.726), dimensions={}
  divide.759 = f64[32768]{0} divide(multiply.758, broadcast.727)
  add.760 = f64[32768]{0} add(negate.757, divide.759)
  divide.761 = f64[32768]{0} divide(multiply.744, broadcast.733)
  subtract.762 = f64[32768]{0} subtract(add.760, divide.761)
  constant.724 = f64[] constant(6)
  broadcast.725 = f64[32768]{0} broadcast(constant.724), dimensions={}
  divide.763 = f64[32768]{0} divide(multiply.745, broadcast.725)
  subtract.764 = f64[32768]{0} subtract(subtract.762, divide.763)
  divide.765 = f64[32768]{0} divide(multiply.746, broadcast.733)
  add.766 = f64[32768]{0} add(subtract.764, divide.765)
  reshape.820 = f64[32768,1]{1,0} reshape(add.766)
  broadcast.821 = f64[32768,1]{1,0} broadcast(reshape.820), dimensions={0,1}
  reshape.822 = f64[32768]{0} reshape(broadcast.821)
  broadcast.823 = f64[32768,32]{1,0} broadcast(reshape.822), dimensions={0}
  multiply.824 = f64[32768,32]{1,0} multiply(call.819, broadcast.823)
  add.825 = f64[32768,32]{1,0} add(multiply.814, multiply.824)
  slice.826 = s32[1]{0} slice(Arg_4.711), slice={[2:3]}
  reshape.827 = s32[] reshape(slice.826)
  broadcast.828 = s32[32768]{0} broadcast(reshape.827), dimensions={}
  add.829 = s32[32768]{0} add(convert.742, broadcast.828)
  call.830 = f64[32768,32]{1,0} call(Arg_0.707, add.829), to_apply=_roll_dynamic.559
  constant.722 = f64[] constant(1)
  broadcast.723 = f64[32768]{0} broadcast(constant.722), dimensions={}
  divide.767 = f64[32768]{0} divide(subtract.741, broadcast.727)
  subtract.768 = f64[32768]{0} subtract(broadcast.723, divide.767)
  constant.720 = f64[] constant(5)
  broadcast.721 = f64[32768]{0} broadcast(constant.720), dimensions={}
  multiply.769 = f64[32768]{0} multiply(multiply.743, broadcast.721)
  constant.718 = f64[] constant(4)
  broadcast.719 = f64[32768]{0} broadcast(constant.718), dimensions={}
  divide.770 = f64[32768]{0} divide(multiply.769, broadcast.719)
  subtract.771 = f64[32768]{0} subtract(subtract.768, divide.770)
  multiply.772 = f64[32768]{0} multiply(multiply.744, broadcast.721)
  constant.716 = f64[] constant(12)
  broadcast.717 = f64[32768]{0} broadcast(constant.716), dimensions={}
  divide.773 = f64[32768]{0} divide(multiply.772, broadcast.717)
  add.774 = f64[32768]{0} add(subtract.771, divide.773)
  divide.775 = f64[32768]{0} divide(multiply.745, broadcast.719)
  add.776 = f64[32768]{0} add(add.774, divide.775)
  divide.777 = f64[32768]{0} divide(multiply.746, broadcast.717)
  subtract.778 = f64[32768]{0} subtract(add.776, divide.777)
  reshape.831 = f64[32768,1]{1,0} reshape(subtract.778)
  broadcast.832 = f64[32768,1]{1,0} broadcast(reshape.831), dimensions={0,1}
  reshape.833 = f64[32768]{0} reshape(broadcast.832)
  broadcast.834 = f64[32768,32]{1,0} broadcast(reshape.833), dimensions={0}
  multiply.835 = f64[32768,32]{1,0} multiply(call.830, broadcast.834)
  add.836 = f64[32768,32]{1,0} add(add.825, multiply.835)
  slice.837 = s32[1]{0} slice(Arg_4.711), slice={[3:4]}
  reshape.838 = s32[] reshape(slice.837)
  broadcast.839 = s32[32768]{0} broadcast(reshape.838), dimensions={}
  add.840 = s32[32768]{0} add(convert.742, broadcast.839)
  call.841 = f64[32768,32]{1,0} call(Arg_0.707, add.840), to_apply=_roll_dynamic.602
  multiply.779 = f64[32768]{0} multiply(multiply.743, broadcast.729)
  divide.780 = f64[32768]{0} divide(multiply.779, broadcast.727)
  add.781 = f64[32768]{0} add(subtract.741, divide.780)
  constant.714 = f64[] constant(7)
  broadcast.715 = f64[32768]{0} broadcast(constant.714), dimensions={}
  multiply.782 = f64[32768]{0} multiply(multiply.744, broadcast.715)
  divide.783 = f64[32768]{0} divide(multiply.782, broadcast.717)
  subtract.784 = f64[32768]{0} subtract(add.781, divide.783)
  divide.785 = f64[32768]{0} divide(multiply.745, broadcast.725)
  subtract.786 = f64[32768]{0} subtract(subtract.784, divide.785)
  divide.787 = f64[32768]{0} divide(multiply.746, broadcast.717)
  add.788 = f64[32768]{0} add(subtract.786, divide.787)
  reshape.842 = f64[32768,1]{1,0} reshape(add.788)
  broadcast.843 = f64[32768,1]{1,0} broadcast(reshape.842), dimensions={0,1}
  reshape.844 = f64[32768]{0} reshape(broadcast.843)
  broadcast.845 = f64[32768,32]{1,0} broadcast(reshape.844), dimensions={0}
  multiply.846 = f64[32768,32]{1,0} multiply(call.841, broadcast.845)
  add.847 = f64[32768,32]{1,0} add(add.836, multiply.846)
  slice.848 = s32[1]{0} slice(Arg_4.711), slice={[4:5]}
  reshape.849 = s32[] reshape(slice.848)
  broadcast.850 = s32[32768]{0} broadcast(reshape.849), dimensions={}
  add.851 = s32[32768]{0} add(convert.742, broadcast.850)
  call.852 = f64[32768,32]{1,0} call(Arg_0.707, add.851), to_apply=_roll_dynamic.645
  divide.789 = f64[32768]{0} divide(subtract.741, broadcast.719)
  negate.790 = f64[32768]{0} negate(divide.789)
  divide.791 = f64[32768]{0} divide(multiply.743, broadcast.733)
  subtract.792 = f64[32768]{0} subtract(negate.790, divide.791)
  multiply.793 = f64[32768]{0} multiply(multiply.744, broadcast.715)
  divide.794 = f64[32768]{0} divide(multiply.793, broadcast.733)
  add.795 = f64[32768]{0} add(subtract.792, divide.794)
  divide.796 = f64[32768]{0} divide(multiply.745, broadcast.733)
  add.797 = f64[32768]{0} add(add.795, divide.796)
  divide.798 = f64[32768]{0} divide(multiply.746, broadcast.733)
  subtract.799 = f64[32768]{0} subtract(add.797, divide.798)
  reshape.853 = f64[32768,1]{1,0} reshape(subtract.799)
  broadcast.854 = f64[32768,1]{1,0} broadcast(reshape.853), dimensions={0,1}
  reshape.855 = f64[32768]{0} reshape(broadcast.854)
  broadcast.856 = f64[32768,32]{1,0} broadcast(reshape.855), dimensions={0}
  multiply.857 = f64[32768,32]{1,0} multiply(call.852, broadcast.856)
  add.858 = f64[32768,32]{1,0} add(add.847, multiply.857)
  slice.859 = s32[1]{0} slice(Arg_4.711), slice={[5:6]}
  reshape.860 = s32[] reshape(slice.859)
  broadcast.861 = s32[32768]{0} broadcast(reshape.860), dimensions={}
  add.862 = s32[32768]{0} add(convert.742, broadcast.861)
  call.863 = f64[32768,32]{1,0} call(Arg_0.707, add.862), to_apply=_roll_dynamic.688
  constant.712 = f64[] constant(30)
  broadcast.713 = f64[32768]{0} broadcast(constant.712), dimensions={}
  divide.800 = f64[32768]{0} divide(subtract.741, broadcast.713)
  divide.801 = f64[32768]{0} divide(multiply.744, broadcast.733)
  subtract.802 = f64[32768]{0} subtract(divide.800, divide.801)
  divide.803 = f64[32768]{0} divide(multiply.746, broadcast.731)
  add.804 = f64[32768]{0} add(subtract.802, divide.803)
  reshape.864 = f64[32768,1]{1,0} reshape(add.804)
  broadcast.865 = f64[32768,1]{1,0} broadcast(reshape.864), dimensions={0,1}
  reshape.866 = f64[32768]{0} reshape(broadcast.865)
  broadcast.867 = f64[32768,32]{1,0} broadcast(reshape.866), dimensions={0}
  multiply.868 = f64[32768,32]{1,0} multiply(call.863, broadcast.867)
  ROOT add.869 = f64[32768,32]{1,0} add(add.858, multiply.868)
}

region_0.873 {
  Arg_0.874 = f64[] parameter(0)
  Arg_1.875 = f64[] parameter(1)
  ROOT add.876 = f64[] add(Arg_0.874, Arg_1.875)
}

fft.877 {
  Arg_0.878 = f64[32,32]{1,0} parameter(0)
  ROOT fft.879 = c128[32,17]{1,0} fft(Arg_0.878), fft_type=RFFT, fft_length={32,32}
}

fft_0.880 {
  Arg_0.881 = c128[32,17]{1,0} parameter(0)
  ROOT fft.882 = f64[32,32]{1,0} fft(Arg_0.881), fft_type=IRFFT, fft_length={32,32}
}

fft_0.883 {
  Arg_0.884 = c128[32,17]{1,0} parameter(0)
  ROOT fft.885 = f64[32,32]{1,0} fft(Arg_0.884), fft_type=IRFFT, fft_length={32,32}
}

fft_0.886 {
  Arg_0.887 = c128[32,17]{1,0} parameter(0)
  ROOT fft.888 = f64[32,32]{1,0} fft(Arg_0.887), fft_type=IRFFT, fft_length={32,32}
}

solve_poisson.889 {
  Arg_1.891 = f64[32,1]{1,0} parameter(1)
  convert.913 = c128[32,1]{1,0} convert(Arg_1.891)
  constant.898 = c128[] constant((-0, -1))
  broadcast.899 = c128[32,1]{1,0} broadcast(constant.898), dimensions={}
  multiply.914 = c128[32,1]{1,0} multiply(convert.913, broadcast.899)
  broadcast.915 = c128[32,1]{1,0} broadcast(multiply.914), dimensions={0,1}
  reshape.916 = c128[32]{0} reshape(broadcast.915)
  broadcast.917 = c128[32,17]{1,0} broadcast(reshape.916), dimensions={0}
  Arg_0.890 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  constant.902 = f64[] constant(0)
  reduce.903 = f64[32,32]{1,0} reduce(Arg_0.890, constant.902), dimensions={2,3}, to_apply=region_0.873
  Arg_4.894 = f64[] parameter(4)
  broadcast.904 = f64[32,32]{1,0} broadcast(Arg_4.894), dimensions={}
  multiply.905 = f64[32,32]{1,0} multiply(reduce.903, broadcast.904)
  Arg_5.895 = f64[] parameter(5)
  broadcast.906 = f64[32,32]{1,0} broadcast(Arg_5.895), dimensions={}
  multiply.907 = f64[32,32]{1,0} multiply(multiply.905, broadcast.906)
  constant.900 = f64[] constant(1)
  broadcast.901 = f64[32,32]{1,0} broadcast(constant.900), dimensions={}
  subtract.908 = f64[32,32]{1,0} subtract(multiply.907, broadcast.901)
  call.909 = c128[32,17]{1,0} call(subtract.908), to_apply=fft.877
  Arg_3.893 = f64[32,17]{1,0} parameter(3)
  convert.910 = c128[32,17]{1,0} convert(Arg_3.893)
  multiply.911 = c128[32,17]{1,0} multiply(call.909, convert.910)
  multiply.918 = c128[32,17]{1,0} multiply(broadcast.917, multiply.911)
  call.925 = f64[32,32]{1,0} call(multiply.918), to_apply=fft_0.883
  Arg_2.892 = f64[1,17]{1,0} parameter(2)
  convert.919 = c128[1,17]{1,0} convert(Arg_2.892)
  constant.896 = c128[] constant((-0, -1))
  broadcast.897 = c128[1,17]{1,0} broadcast(constant.896), dimensions={}
  multiply.920 = c128[1,17]{1,0} multiply(convert.919, broadcast.897)
  broadcast.921 = c128[1,17]{1,0} broadcast(multiply.920), dimensions={0,1}
  reshape.922 = c128[17]{0} reshape(broadcast.921)
  broadcast.923 = c128[32,17]{1,0} broadcast(reshape.922), dimensions={1}
  multiply.924 = c128[32,17]{1,0} multiply(broadcast.923, multiply.911)
  call.926 = f64[32,32]{1,0} call(multiply.924), to_apply=fft_0.886
  call.912 = f64[32,32]{1,0} call(multiply.911), to_apply=fft_0.880
  ROOT tuple.927 = (f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(call.925, call.926, subtract.908, call.912)
}

_where_2.940 {
  Arg_0.941 = pred[6,32768,32]{2,1,0} parameter(0)
  Arg_1.942 = f64[6,32768,1]{2,1,0} parameter(1)
  broadcast.944 = f64[6,32768,1]{2,1,0} broadcast(Arg_1.942), dimensions={0,1,2}
  reshape.945 = f64[6,32768]{1,0} reshape(broadcast.944)
  broadcast.946 = f64[6,32768,32]{2,1,0} broadcast(reshape.945), dimensions={0,1}
  Arg_2.943 = f64[] parameter(2)
  broadcast.947 = f64[6,32768,32]{2,1,0} broadcast(Arg_2.943), dimensions={}
  ROOT select.948 = f64[6,32768,32]{2,1,0} select(Arg_0.941, broadcast.946, broadcast.947)
}

build_v_diag_weights.949 {
  iota.1051 = s64[32]{0} iota(), iota_dimension=0
  reshape.1061 = s64[1,1,32]{2,1,0} reshape(iota.1051)
  broadcast.1064 = s64[1,1,32]{2,1,0} broadcast(reshape.1061), dimensions={0,1,2}
  reshape.1065 = s64[32]{0} reshape(broadcast.1064)
  broadcast.1066 = s64[6,32768,32]{2,1,0} broadcast(reshape.1065), dimensions={2}
  Arg_0.950 = s32[6]{0} parameter(0)
  reshape.1052 = s32[6,1]{1,0} reshape(Arg_0.950)
  broadcast.1054 = s32[6,1]{1,0} broadcast(reshape.1052), dimensions={0,1}
  reshape.1055 = s32[6]{0} reshape(broadcast.1054)
  broadcast.1056 = s32[6,32768]{1,0} broadcast(reshape.1055), dimensions={0}
  Arg_1.951 = s32[32768]{0} parameter(1)
  reshape.1053 = s32[1,32768]{1,0} reshape(Arg_1.951)
  broadcast.1057 = s32[1,32768]{1,0} broadcast(reshape.1053), dimensions={0,1}
  reshape.1058 = s32[32768]{0} reshape(broadcast.1057)
  broadcast.1059 = s32[6,32768]{1,0} broadcast(reshape.1058), dimensions={1}
  add.1060 = s32[6,32768]{1,0} add(broadcast.1056, broadcast.1059)
  reshape.1062 = s32[6,32768,1]{2,1,0} reshape(add.1060)
  convert.1063 = s64[6,32768,1]{2,1,0} convert(reshape.1062)
  broadcast.1067 = s64[6,32768,1]{2,1,0} broadcast(convert.1063), dimensions={0,1,2}
  reshape.1068 = s64[6,32768]{1,0} reshape(broadcast.1067)
  broadcast.1069 = s64[6,32768,32]{2,1,0} broadcast(reshape.1068), dimensions={0,1}
  subtract.1070 = s64[6,32768,32]{2,1,0} subtract(broadcast.1066, broadcast.1069)
  constant.955 = s64[] constant(0)
  broadcast.956 = s64[6,32768,32]{2,1,0} broadcast(constant.955), dimensions={}
  compare.1071 = pred[6,32768,32]{2,1,0} compare(subtract.1070, broadcast.956), direction=GE
  constant.953 = s64[] constant(32)
  broadcast.954 = s64[6,32768,32]{2,1,0} broadcast(constant.953), dimensions={}
  compare.1072 = pred[6,32768,32]{2,1,0} compare(subtract.1070, broadcast.954), direction=LT
  and.1073 = pred[6,32768,32]{2,1,0} and(compare.1071, compare.1072)
  Arg_2.952 = f64[32768]{0} parameter(2)
  constant.979 = f64[] constant(20)
  broadcast.980 = f64[32768]{0} broadcast(constant.979), dimensions={}
  divide.986 = f64[32768]{0} divide(Arg_2.952, broadcast.980)
  multiply.982 = f64[32768]{0} multiply(Arg_2.952, Arg_2.952)
  constant.977 = f64[] constant(24)
  broadcast.978 = f64[32768]{0} broadcast(constant.977), dimensions={}
  divide.987 = f64[32768]{0} divide(multiply.982, broadcast.978)
  subtract.988 = f64[32768]{0} subtract(divide.986, divide.987)
  multiply.983 = f64[32768]{0} multiply(multiply.982, Arg_2.952)
  divide.989 = f64[32768]{0} divide(multiply.983, broadcast.978)
  subtract.990 = f64[32768]{0} subtract(subtract.988, divide.989)
  multiply.984 = f64[32768]{0} multiply(multiply.983, Arg_2.952)
  divide.991 = f64[32768]{0} divide(multiply.984, broadcast.978)
  add.992 = f64[32768]{0} add(subtract.990, divide.991)
  multiply.985 = f64[32768]{0} multiply(multiply.984, Arg_2.952)
  constant.975 = f64[] constant(120)
  broadcast.976 = f64[32768]{0} broadcast(constant.975), dimensions={}
  divide.993 = f64[32768]{0} divide(multiply.985, broadcast.976)
  subtract.994 = f64[32768]{0} subtract(add.992, divide.993)
  reshape.1044 = f64[1,32768]{1,0} reshape(subtract.994)
  constant.973 = f64[] constant(2)
  broadcast.974 = f64[32768]{0} broadcast(constant.973), dimensions={}
  divide.995 = f64[32768]{0} divide(Arg_2.952, broadcast.974)
  negate.996 = f64[32768]{0} negate(divide.995)
  multiply.997 = f64[32768]{0} multiply(multiply.982, broadcast.974)
  constant.971 = f64[] constant(3)
  broadcast.972 = f64[32768]{0} broadcast(constant.971), dimensions={}
  divide.998 = f64[32768]{0} divide(multiply.997, broadcast.972)
  add.999 = f64[32768]{0} add(negate.996, divide.998)
  divide.1000 = f64[32768]{0} divide(multiply.983, broadcast.978)
  subtract.1001 = f64[32768]{0} subtract(add.999, divide.1000)
  constant.969 = f64[] constant(6)
  broadcast.970 = f64[32768]{0} broadcast(constant.969), dimensions={}
  divide.1002 = f64[32768]{0} divide(multiply.984, broadcast.970)
  subtract.1003 = f64[32768]{0} subtract(subtract.1001, divide.1002)
  divide.1004 = f64[32768]{0} divide(multiply.985, broadcast.978)
  add.1005 = f64[32768]{0} add(subtract.1003, divide.1004)
  reshape.1045 = f64[1,32768]{1,0} reshape(add.1005)
  constant.967 = f64[] constant(1)
  broadcast.968 = f64[32768]{0} broadcast(constant.967), dimensions={}
  divide.1006 = f64[32768]{0} divide(Arg_2.952, broadcast.972)
  subtract.1007 = f64[32768]{0} subtract(broadcast.968, divide.1006)
  constant.965 = f64[] constant(5)
  broadcast.966 = f64[32768]{0} broadcast(constant.965), dimensions={}
  multiply.1008 = f64[32768]{0} multiply(multiply.982, broadcast.966)
  constant.963 = f64[] constant(4)
  broadcast.964 = f64[32768]{0} broadcast(constant.963), dimensions={}
  divide.1009 = f64[32768]{0} divide(multiply.1008, broadcast.964)
  subtract.1010 = f64[32768]{0} subtract(subtract.1007, divide.1009)
  multiply.1011 = f64[32768]{0} multiply(multiply.983, broadcast.966)
  constant.961 = f64[] constant(12)
  broadcast.962 = f64[32768]{0} broadcast(constant.961), dimensions={}
  divide.1012 = f64[32768]{0} divide(multiply.1011, broadcast.962)
  add.1013 = f64[32768]{0} add(subtract.1010, divide.1012)
  divide.1014 = f64[32768]{0} divide(multiply.984, broadcast.964)
  add.1015 = f64[32768]{0} add(add.1013, divide.1014)
  divide.1016 = f64[32768]{0} divide(multiply.985, broadcast.962)
  subtract.1017 = f64[32768]{0} subtract(add.1015, divide.1016)
  reshape.1046 = f64[1,32768]{1,0} reshape(subtract.1017)
  multiply.1018 = f64[32768]{0} multiply(multiply.982, broadcast.974)
  divide.1019 = f64[32768]{0} divide(multiply.1018, broadcast.972)
  add.1020 = f64[32768]{0} add(Arg_2.952, divide.1019)
  constant.959 = f64[] constant(7)
  broadcast.960 = f64[32768]{0} broadcast(constant.959), dimensions={}
  multiply.1021 = f64[32768]{0} multiply(multiply.983, broadcast.960)
  divide.1022 = f64[32768]{0} divide(multiply.1021, broadcast.962)
  subtract.1023 = f64[32768]{0} subtract(add.1020, divide.1022)
  divide.1024 = f64[32768]{0} divide(multiply.984, broadcast.970)
  subtract.1025 = f64[32768]{0} subtract(subtract.1023, divide.1024)
  divide.1026 = f64[32768]{0} divide(multiply.985, broadcast.962)
  add.1027 = f64[32768]{0} add(subtract.1025, divide.1026)
  reshape.1047 = f64[1,32768]{1,0} reshape(add.1027)
  divide.1028 = f64[32768]{0} divide(Arg_2.952, broadcast.964)
  negate.1029 = f64[32768]{0} negate(divide.1028)
  divide.1030 = f64[32768]{0} divide(multiply.982, broadcast.978)
  subtract.1031 = f64[32768]{0} subtract(negate.1029, divide.1030)
  multiply.1032 = f64[32768]{0} multiply(multiply.983, broadcast.960)
  divide.1033 = f64[32768]{0} divide(multiply.1032, broadcast.978)
  add.1034 = f64[32768]{0} add(subtract.1031, divide.1033)
  divide.1035 = f64[32768]{0} divide(multiply.984, broadcast.978)
  add.1036 = f64[32768]{0} add(add.1034, divide.1035)
  divide.1037 = f64[32768]{0} divide(multiply.985, broadcast.978)
  subtract.1038 = f64[32768]{0} subtract(add.1036, divide.1037)
  reshape.1048 = f64[1,32768]{1,0} reshape(subtract.1038)
  constant.957 = f64[] constant(30)
  broadcast.958 = f64[32768]{0} broadcast(constant.957), dimensions={}
  divide.1039 = f64[32768]{0} divide(Arg_2.952, broadcast.958)
  divide.1040 = f64[32768]{0} divide(multiply.983, broadcast.978)
  subtract.1041 = f64[32768]{0} subtract(divide.1039, divide.1040)
  divide.1042 = f64[32768]{0} divide(multiply.985, broadcast.976)
  add.1043 = f64[32768]{0} add(subtract.1041, divide.1042)
  reshape.1049 = f64[1,32768]{1,0} reshape(add.1043)
  concatenate.1050 = f64[6,32768]{1,0} concatenate(reshape.1044, reshape.1045, reshape.1046, reshape.1047, reshape.1048, reshape.1049), dimensions={0}
  reshape.1074 = f64[6,32768,1]{2,1,0} reshape(concatenate.1050)
  constant.981 = f64[] constant(0)
  ROOT call.1075 = f64[6,32768,32]{2,1,0} call(and.1073, reshape.1074, constant.981), to_apply=_where_2.940
}

_where.1076 {
  Arg_0.1077 = pred[] parameter(0)
  Arg_1.1078 = s32[] parameter(1)
  Arg_2.1079 = s32[] parameter(2)
  ROOT select.1080 = s32[] select(Arg_0.1077, Arg_1.1078, Arg_2.1079)
}

remainder.1081 {
  Arg_0.1082 = s32[32768]{0} parameter(0)
  Arg_1.1083 = s32[] parameter(1)
  constant.1087 = s32[] constant(0)
  compare.1088 = pred[] compare(Arg_1.1083, constant.1087), direction=EQ
  constant.1086 = s32[] constant(1)
  call.1089 = s32[] call(compare.1088, constant.1086, Arg_1.1083), to_apply=_where.1076
  broadcast.1090 = s32[32768]{0} broadcast(call.1089), dimensions={}
  remainder.1091 = s32[32768]{0} remainder(Arg_0.1082, broadcast.1090)
  constant.1084 = s32[] constant(0)
  broadcast.1085 = s32[32768]{0} broadcast(constant.1084), dimensions={}
  compare.1093 = pred[32768]{0} compare(remainder.1091, broadcast.1085), direction=LT
  compare.1094 = pred[] compare(call.1089, constant.1087), direction=LT
  broadcast.1095 = pred[32768]{0} broadcast(compare.1094), dimensions={}
  compare.1096 = pred[32768]{0} compare(compare.1093, broadcast.1095), direction=NE
  compare.1092 = pred[32768]{0} compare(remainder.1091, broadcast.1085), direction=NE
  and.1097 = pred[32768]{0} and(compare.1096, compare.1092)
  broadcast.1098 = s32[32768]{0} broadcast(call.1089), dimensions={}
  add.1099 = s32[32768]{0} add(remainder.1091, broadcast.1098)
  ROOT select.1100 = s32[32768]{0} select(and.1097, add.1099, remainder.1091)
}

_roll_dynamic.1101 {
  Arg_0.1102 = f64[32768,32]{1,0} parameter(0)
  concatenate.1112 = f64[32768,64]{1,0} concatenate(Arg_0.1102, Arg_0.1102), dimensions={1}
  constant.1108 = s32[] constant(32)
  broadcast.1109 = s32[32768]{0} broadcast(constant.1108), dimensions={}
  Arg_1.1103 = s32[32768]{0} parameter(1)
  constant.1110 = s32[] constant(32)
  call.1111 = s32[32768]{0} call(Arg_1.1103, constant.1110), to_apply=remainder.1081
  subtract.1113 = s32[32768]{0} subtract(broadcast.1109, call.1111)
  constant.1106 = s32[] constant(0)
  broadcast.1107 = s32[32768]{0} broadcast(constant.1106), dimensions={}
  compare.1114 = pred[32768]{0} compare(subtract.1113, broadcast.1107), direction=LT
  constant.1104 = s32[] constant(64)
  broadcast.1105 = s32[32768]{0} broadcast(constant.1104), dimensions={}
  add.1115 = s32[32768]{0} add(subtract.1113, broadcast.1105)
  select.1116 = s32[32768]{0} select(compare.1114, add.1115, subtract.1113)
  reshape.1117 = s32[32768,1]{1,0} reshape(select.1116)
  ROOT gather.1118 = f64[32768,32]{1,0} gather(concatenate.1112, reshape.1117), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1119 {
  Arg_0.1120 = pred[] parameter(0)
  Arg_1.1121 = s32[] parameter(1)
  Arg_2.1122 = s32[] parameter(2)
  ROOT select.1123 = s32[] select(Arg_0.1120, Arg_1.1121, Arg_2.1122)
}

remainder.1124 {
  Arg_0.1125 = s32[32768]{0} parameter(0)
  Arg_1.1126 = s32[] parameter(1)
  constant.1130 = s32[] constant(0)
  compare.1131 = pred[] compare(Arg_1.1126, constant.1130), direction=EQ
  constant.1129 = s32[] constant(1)
  call.1132 = s32[] call(compare.1131, constant.1129, Arg_1.1126), to_apply=_where.1119
  broadcast.1133 = s32[32768]{0} broadcast(call.1132), dimensions={}
  remainder.1134 = s32[32768]{0} remainder(Arg_0.1125, broadcast.1133)
  constant.1127 = s32[] constant(0)
  broadcast.1128 = s32[32768]{0} broadcast(constant.1127), dimensions={}
  compare.1136 = pred[32768]{0} compare(remainder.1134, broadcast.1128), direction=LT
  compare.1137 = pred[] compare(call.1132, constant.1130), direction=LT
  broadcast.1138 = pred[32768]{0} broadcast(compare.1137), dimensions={}
  compare.1139 = pred[32768]{0} compare(compare.1136, broadcast.1138), direction=NE
  compare.1135 = pred[32768]{0} compare(remainder.1134, broadcast.1128), direction=NE
  and.1140 = pred[32768]{0} and(compare.1139, compare.1135)
  broadcast.1141 = s32[32768]{0} broadcast(call.1132), dimensions={}
  add.1142 = s32[32768]{0} add(remainder.1134, broadcast.1141)
  ROOT select.1143 = s32[32768]{0} select(and.1140, add.1142, remainder.1134)
}

_roll_dynamic.1144 {
  Arg_0.1145 = f64[32768,32]{1,0} parameter(0)
  concatenate.1155 = f64[32768,64]{1,0} concatenate(Arg_0.1145, Arg_0.1145), dimensions={1}
  constant.1151 = s32[] constant(32)
  broadcast.1152 = s32[32768]{0} broadcast(constant.1151), dimensions={}
  Arg_1.1146 = s32[32768]{0} parameter(1)
  constant.1153 = s32[] constant(32)
  call.1154 = s32[32768]{0} call(Arg_1.1146, constant.1153), to_apply=remainder.1124
  subtract.1156 = s32[32768]{0} subtract(broadcast.1152, call.1154)
  constant.1149 = s32[] constant(0)
  broadcast.1150 = s32[32768]{0} broadcast(constant.1149), dimensions={}
  compare.1157 = pred[32768]{0} compare(subtract.1156, broadcast.1150), direction=LT
  constant.1147 = s32[] constant(64)
  broadcast.1148 = s32[32768]{0} broadcast(constant.1147), dimensions={}
  add.1158 = s32[32768]{0} add(subtract.1156, broadcast.1148)
  select.1159 = s32[32768]{0} select(compare.1157, add.1158, subtract.1156)
  reshape.1160 = s32[32768,1]{1,0} reshape(select.1159)
  ROOT gather.1161 = f64[32768,32]{1,0} gather(concatenate.1155, reshape.1160), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1162 {
  Arg_0.1163 = pred[] parameter(0)
  Arg_1.1164 = s32[] parameter(1)
  Arg_2.1165 = s32[] parameter(2)
  ROOT select.1166 = s32[] select(Arg_0.1163, Arg_1.1164, Arg_2.1165)
}

remainder.1167 {
  Arg_0.1168 = s32[32768]{0} parameter(0)
  Arg_1.1169 = s32[] parameter(1)
  constant.1173 = s32[] constant(0)
  compare.1174 = pred[] compare(Arg_1.1169, constant.1173), direction=EQ
  constant.1172 = s32[] constant(1)
  call.1175 = s32[] call(compare.1174, constant.1172, Arg_1.1169), to_apply=_where.1162
  broadcast.1176 = s32[32768]{0} broadcast(call.1175), dimensions={}
  remainder.1177 = s32[32768]{0} remainder(Arg_0.1168, broadcast.1176)
  constant.1170 = s32[] constant(0)
  broadcast.1171 = s32[32768]{0} broadcast(constant.1170), dimensions={}
  compare.1179 = pred[32768]{0} compare(remainder.1177, broadcast.1171), direction=LT
  compare.1180 = pred[] compare(call.1175, constant.1173), direction=LT
  broadcast.1181 = pred[32768]{0} broadcast(compare.1180), dimensions={}
  compare.1182 = pred[32768]{0} compare(compare.1179, broadcast.1181), direction=NE
  compare.1178 = pred[32768]{0} compare(remainder.1177, broadcast.1171), direction=NE
  and.1183 = pred[32768]{0} and(compare.1182, compare.1178)
  broadcast.1184 = s32[32768]{0} broadcast(call.1175), dimensions={}
  add.1185 = s32[32768]{0} add(remainder.1177, broadcast.1184)
  ROOT select.1186 = s32[32768]{0} select(and.1183, add.1185, remainder.1177)
}

_roll_dynamic.1187 {
  Arg_0.1188 = f64[32768,32]{1,0} parameter(0)
  concatenate.1198 = f64[32768,64]{1,0} concatenate(Arg_0.1188, Arg_0.1188), dimensions={1}
  constant.1194 = s32[] constant(32)
  broadcast.1195 = s32[32768]{0} broadcast(constant.1194), dimensions={}
  Arg_1.1189 = s32[32768]{0} parameter(1)
  constant.1196 = s32[] constant(32)
  call.1197 = s32[32768]{0} call(Arg_1.1189, constant.1196), to_apply=remainder.1167
  subtract.1199 = s32[32768]{0} subtract(broadcast.1195, call.1197)
  constant.1192 = s32[] constant(0)
  broadcast.1193 = s32[32768]{0} broadcast(constant.1192), dimensions={}
  compare.1200 = pred[32768]{0} compare(subtract.1199, broadcast.1193), direction=LT
  constant.1190 = s32[] constant(64)
  broadcast.1191 = s32[32768]{0} broadcast(constant.1190), dimensions={}
  add.1201 = s32[32768]{0} add(subtract.1199, broadcast.1191)
  select.1202 = s32[32768]{0} select(compare.1200, add.1201, subtract.1199)
  reshape.1203 = s32[32768,1]{1,0} reshape(select.1202)
  ROOT gather.1204 = f64[32768,32]{1,0} gather(concatenate.1198, reshape.1203), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1205 {
  Arg_0.1206 = pred[] parameter(0)
  Arg_1.1207 = s32[] parameter(1)
  Arg_2.1208 = s32[] parameter(2)
  ROOT select.1209 = s32[] select(Arg_0.1206, Arg_1.1207, Arg_2.1208)
}

remainder.1210 {
  Arg_0.1211 = s32[32768]{0} parameter(0)
  Arg_1.1212 = s32[] parameter(1)
  constant.1216 = s32[] constant(0)
  compare.1217 = pred[] compare(Arg_1.1212, constant.1216), direction=EQ
  constant.1215 = s32[] constant(1)
  call.1218 = s32[] call(compare.1217, constant.1215, Arg_1.1212), to_apply=_where.1205
  broadcast.1219 = s32[32768]{0} broadcast(call.1218), dimensions={}
  remainder.1220 = s32[32768]{0} remainder(Arg_0.1211, broadcast.1219)
  constant.1213 = s32[] constant(0)
  broadcast.1214 = s32[32768]{0} broadcast(constant.1213), dimensions={}
  compare.1222 = pred[32768]{0} compare(remainder.1220, broadcast.1214), direction=LT
  compare.1223 = pred[] compare(call.1218, constant.1216), direction=LT
  broadcast.1224 = pred[32768]{0} broadcast(compare.1223), dimensions={}
  compare.1225 = pred[32768]{0} compare(compare.1222, broadcast.1224), direction=NE
  compare.1221 = pred[32768]{0} compare(remainder.1220, broadcast.1214), direction=NE
  and.1226 = pred[32768]{0} and(compare.1225, compare.1221)
  broadcast.1227 = s32[32768]{0} broadcast(call.1218), dimensions={}
  add.1228 = s32[32768]{0} add(remainder.1220, broadcast.1227)
  ROOT select.1229 = s32[32768]{0} select(and.1226, add.1228, remainder.1220)
}

_roll_dynamic.1230 {
  Arg_0.1231 = f64[32768,32]{1,0} parameter(0)
  concatenate.1241 = f64[32768,64]{1,0} concatenate(Arg_0.1231, Arg_0.1231), dimensions={1}
  constant.1237 = s32[] constant(32)
  broadcast.1238 = s32[32768]{0} broadcast(constant.1237), dimensions={}
  Arg_1.1232 = s32[32768]{0} parameter(1)
  constant.1239 = s32[] constant(32)
  call.1240 = s32[32768]{0} call(Arg_1.1232, constant.1239), to_apply=remainder.1210
  subtract.1242 = s32[32768]{0} subtract(broadcast.1238, call.1240)
  constant.1235 = s32[] constant(0)
  broadcast.1236 = s32[32768]{0} broadcast(constant.1235), dimensions={}
  compare.1243 = pred[32768]{0} compare(subtract.1242, broadcast.1236), direction=LT
  constant.1233 = s32[] constant(64)
  broadcast.1234 = s32[32768]{0} broadcast(constant.1233), dimensions={}
  add.1244 = s32[32768]{0} add(subtract.1242, broadcast.1234)
  select.1245 = s32[32768]{0} select(compare.1243, add.1244, subtract.1242)
  reshape.1246 = s32[32768,1]{1,0} reshape(select.1245)
  ROOT gather.1247 = f64[32768,32]{1,0} gather(concatenate.1241, reshape.1246), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1248 {
  Arg_0.1249 = pred[] parameter(0)
  Arg_1.1250 = s32[] parameter(1)
  Arg_2.1251 = s32[] parameter(2)
  ROOT select.1252 = s32[] select(Arg_0.1249, Arg_1.1250, Arg_2.1251)
}

remainder.1253 {
  Arg_0.1254 = s32[32768]{0} parameter(0)
  Arg_1.1255 = s32[] parameter(1)
  constant.1259 = s32[] constant(0)
  compare.1260 = pred[] compare(Arg_1.1255, constant.1259), direction=EQ
  constant.1258 = s32[] constant(1)
  call.1261 = s32[] call(compare.1260, constant.1258, Arg_1.1255), to_apply=_where.1248
  broadcast.1262 = s32[32768]{0} broadcast(call.1261), dimensions={}
  remainder.1263 = s32[32768]{0} remainder(Arg_0.1254, broadcast.1262)
  constant.1256 = s32[] constant(0)
  broadcast.1257 = s32[32768]{0} broadcast(constant.1256), dimensions={}
  compare.1265 = pred[32768]{0} compare(remainder.1263, broadcast.1257), direction=LT
  compare.1266 = pred[] compare(call.1261, constant.1259), direction=LT
  broadcast.1267 = pred[32768]{0} broadcast(compare.1266), dimensions={}
  compare.1268 = pred[32768]{0} compare(compare.1265, broadcast.1267), direction=NE
  compare.1264 = pred[32768]{0} compare(remainder.1263, broadcast.1257), direction=NE
  and.1269 = pred[32768]{0} and(compare.1268, compare.1264)
  broadcast.1270 = s32[32768]{0} broadcast(call.1261), dimensions={}
  add.1271 = s32[32768]{0} add(remainder.1263, broadcast.1270)
  ROOT select.1272 = s32[32768]{0} select(and.1269, add.1271, remainder.1263)
}

_roll_dynamic.1273 {
  Arg_0.1274 = f64[32768,32]{1,0} parameter(0)
  concatenate.1284 = f64[32768,64]{1,0} concatenate(Arg_0.1274, Arg_0.1274), dimensions={1}
  constant.1280 = s32[] constant(32)
  broadcast.1281 = s32[32768]{0} broadcast(constant.1280), dimensions={}
  Arg_1.1275 = s32[32768]{0} parameter(1)
  constant.1282 = s32[] constant(32)
  call.1283 = s32[32768]{0} call(Arg_1.1275, constant.1282), to_apply=remainder.1253
  subtract.1285 = s32[32768]{0} subtract(broadcast.1281, call.1283)
  constant.1278 = s32[] constant(0)
  broadcast.1279 = s32[32768]{0} broadcast(constant.1278), dimensions={}
  compare.1286 = pred[32768]{0} compare(subtract.1285, broadcast.1279), direction=LT
  constant.1276 = s32[] constant(64)
  broadcast.1277 = s32[32768]{0} broadcast(constant.1276), dimensions={}
  add.1287 = s32[32768]{0} add(subtract.1285, broadcast.1277)
  select.1288 = s32[32768]{0} select(compare.1286, add.1287, subtract.1285)
  reshape.1289 = s32[32768,1]{1,0} reshape(select.1288)
  ROOT gather.1290 = f64[32768,32]{1,0} gather(concatenate.1284, reshape.1289), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1291 {
  Arg_0.1292 = pred[] parameter(0)
  Arg_1.1293 = s32[] parameter(1)
  Arg_2.1294 = s32[] parameter(2)
  ROOT select.1295 = s32[] select(Arg_0.1292, Arg_1.1293, Arg_2.1294)
}

remainder.1296 {
  Arg_0.1297 = s32[32768]{0} parameter(0)
  Arg_1.1298 = s32[] parameter(1)
  constant.1302 = s32[] constant(0)
  compare.1303 = pred[] compare(Arg_1.1298, constant.1302), direction=EQ
  constant.1301 = s32[] constant(1)
  call.1304 = s32[] call(compare.1303, constant.1301, Arg_1.1298), to_apply=_where.1291
  broadcast.1305 = s32[32768]{0} broadcast(call.1304), dimensions={}
  remainder.1306 = s32[32768]{0} remainder(Arg_0.1297, broadcast.1305)
  constant.1299 = s32[] constant(0)
  broadcast.1300 = s32[32768]{0} broadcast(constant.1299), dimensions={}
  compare.1308 = pred[32768]{0} compare(remainder.1306, broadcast.1300), direction=LT
  compare.1309 = pred[] compare(call.1304, constant.1302), direction=LT
  broadcast.1310 = pred[32768]{0} broadcast(compare.1309), dimensions={}
  compare.1311 = pred[32768]{0} compare(compare.1308, broadcast.1310), direction=NE
  compare.1307 = pred[32768]{0} compare(remainder.1306, broadcast.1300), direction=NE
  and.1312 = pred[32768]{0} and(compare.1311, compare.1307)
  broadcast.1313 = s32[32768]{0} broadcast(call.1304), dimensions={}
  add.1314 = s32[32768]{0} add(remainder.1306, broadcast.1313)
  ROOT select.1315 = s32[32768]{0} select(and.1312, add.1314, remainder.1306)
}

_roll_dynamic.1316 {
  Arg_0.1317 = f64[32768,32]{1,0} parameter(0)
  concatenate.1327 = f64[32768,64]{1,0} concatenate(Arg_0.1317, Arg_0.1317), dimensions={1}
  constant.1323 = s32[] constant(32)
  broadcast.1324 = s32[32768]{0} broadcast(constant.1323), dimensions={}
  Arg_1.1318 = s32[32768]{0} parameter(1)
  constant.1325 = s32[] constant(32)
  call.1326 = s32[32768]{0} call(Arg_1.1318, constant.1325), to_apply=remainder.1296
  subtract.1328 = s32[32768]{0} subtract(broadcast.1324, call.1326)
  constant.1321 = s32[] constant(0)
  broadcast.1322 = s32[32768]{0} broadcast(constant.1321), dimensions={}
  compare.1329 = pred[32768]{0} compare(subtract.1328, broadcast.1322), direction=LT
  constant.1319 = s32[] constant(64)
  broadcast.1320 = s32[32768]{0} broadcast(constant.1319), dimensions={}
  add.1330 = s32[32768]{0} add(subtract.1328, broadcast.1320)
  select.1331 = s32[32768]{0} select(compare.1329, add.1330, subtract.1328)
  reshape.1332 = s32[32768,1]{1,0} reshape(select.1331)
  ROOT gather.1333 = f64[32768,32]{1,0} gather(concatenate.1327, reshape.1332), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag_1.1334 {
  Arg_4.1339 = s32[6]{0} parameter(4)
  Arg_1.1336 = f64[32768]{0} parameter(1)
  Arg_2.1337 = f64[] parameter(2)
  broadcast.1340 = f64[32768]{0} broadcast(Arg_2.1337), dimensions={}
  multiply.1341 = f64[32768]{0} multiply(Arg_1.1336, broadcast.1340)
  Arg_3.1338 = f64[] parameter(3)
  broadcast.1342 = f64[32768]{0} broadcast(Arg_3.1338), dimensions={}
  divide.1343 = f64[32768]{0} divide(multiply.1341, broadcast.1342)
  floor.1344 = f64[32768]{0} floor(divide.1343)
  convert.1346 = s32[32768]{0} convert(floor.1344)
  subtract.1345 = f64[32768]{0} subtract(divide.1343, floor.1344)
  call.1347 = f64[6,32768,32]{2,1,0} call(Arg_4.1339, convert.1346, subtract.1345), to_apply=build_v_diag_weights.949
  slice.1353 = f64[1,32768,32]{2,1,0} slice(call.1347), slice={[0:1], [0:32768], [0:32]}
  reshape.1354 = f64[32768,32]{1,0} reshape(slice.1353)
  Arg_0.1335 = f64[32768,32]{1,0} parameter(0)
  slice.1348 = s32[1]{0} slice(Arg_4.1339), slice={[0:1]}
  reshape.1349 = s32[] reshape(slice.1348)
  broadcast.1350 = s32[32768]{0} broadcast(reshape.1349), dimensions={}
  add.1351 = s32[32768]{0} add(convert.1346, broadcast.1350)
  call.1352 = f64[32768,32]{1,0} call(Arg_0.1335, add.1351), to_apply=_roll_dynamic.1101
  multiply.1355 = f64[32768,32]{1,0} multiply(reshape.1354, call.1352)
  slice.1361 = f64[1,32768,32]{2,1,0} slice(call.1347), slice={[1:2], [0:32768], [0:32]}
  reshape.1362 = f64[32768,32]{1,0} reshape(slice.1361)
  slice.1356 = s32[1]{0} slice(Arg_4.1339), slice={[1:2]}
  reshape.1357 = s32[] reshape(slice.1356)
  broadcast.1358 = s32[32768]{0} broadcast(reshape.1357), dimensions={}
  add.1359 = s32[32768]{0} add(convert.1346, broadcast.1358)
  call.1360 = f64[32768,32]{1,0} call(Arg_0.1335, add.1359), to_apply=_roll_dynamic.1144
  multiply.1363 = f64[32768,32]{1,0} multiply(reshape.1362, call.1360)
  add.1364 = f64[32768,32]{1,0} add(multiply.1355, multiply.1363)
  slice.1370 = f64[1,32768,32]{2,1,0} slice(call.1347), slice={[2:3], [0:32768], [0:32]}
  reshape.1371 = f64[32768,32]{1,0} reshape(slice.1370)
  slice.1365 = s32[1]{0} slice(Arg_4.1339), slice={[2:3]}
  reshape.1366 = s32[] reshape(slice.1365)
  broadcast.1367 = s32[32768]{0} broadcast(reshape.1366), dimensions={}
  add.1368 = s32[32768]{0} add(convert.1346, broadcast.1367)
  call.1369 = f64[32768,32]{1,0} call(Arg_0.1335, add.1368), to_apply=_roll_dynamic.1187
  multiply.1372 = f64[32768,32]{1,0} multiply(reshape.1371, call.1369)
  add.1373 = f64[32768,32]{1,0} add(add.1364, multiply.1372)
  slice.1379 = f64[1,32768,32]{2,1,0} slice(call.1347), slice={[3:4], [0:32768], [0:32]}
  reshape.1380 = f64[32768,32]{1,0} reshape(slice.1379)
  slice.1374 = s32[1]{0} slice(Arg_4.1339), slice={[3:4]}
  reshape.1375 = s32[] reshape(slice.1374)
  broadcast.1376 = s32[32768]{0} broadcast(reshape.1375), dimensions={}
  add.1377 = s32[32768]{0} add(convert.1346, broadcast.1376)
  call.1378 = f64[32768,32]{1,0} call(Arg_0.1335, add.1377), to_apply=_roll_dynamic.1230
  multiply.1381 = f64[32768,32]{1,0} multiply(reshape.1380, call.1378)
  add.1382 = f64[32768,32]{1,0} add(add.1373, multiply.1381)
  slice.1388 = f64[1,32768,32]{2,1,0} slice(call.1347), slice={[4:5], [0:32768], [0:32]}
  reshape.1389 = f64[32768,32]{1,0} reshape(slice.1388)
  slice.1383 = s32[1]{0} slice(Arg_4.1339), slice={[4:5]}
  reshape.1384 = s32[] reshape(slice.1383)
  broadcast.1385 = s32[32768]{0} broadcast(reshape.1384), dimensions={}
  add.1386 = s32[32768]{0} add(convert.1346, broadcast.1385)
  call.1387 = f64[32768,32]{1,0} call(Arg_0.1335, add.1386), to_apply=_roll_dynamic.1273
  multiply.1390 = f64[32768,32]{1,0} multiply(reshape.1389, call.1387)
  add.1391 = f64[32768,32]{1,0} add(add.1382, multiply.1390)
  slice.1397 = f64[1,32768,32]{2,1,0} slice(call.1347), slice={[5:6], [0:32768], [0:32]}
  reshape.1398 = f64[32768,32]{1,0} reshape(slice.1397)
  slice.1392 = s32[1]{0} slice(Arg_4.1339), slice={[5:6]}
  reshape.1393 = s32[] reshape(slice.1392)
  broadcast.1394 = s32[32768]{0} broadcast(reshape.1393), dimensions={}
  add.1395 = s32[32768]{0} add(convert.1346, broadcast.1394)
  call.1396 = f64[32768,32]{1,0} call(Arg_0.1335, add.1395), to_apply=_roll_dynamic.1316
  multiply.1399 = f64[32768,32]{1,0} multiply(reshape.1398, call.1396)
  ROOT add.1400 = f64[32768,32]{1,0} add(add.1391, multiply.1399)
}

_where_2.1410 {
  Arg_0.1411 = pred[6,32768,32]{2,1,0} parameter(0)
  Arg_1.1412 = f64[6,32768,1]{2,1,0} parameter(1)
  broadcast.1414 = f64[6,32768,1]{2,1,0} broadcast(Arg_1.1412), dimensions={0,1,2}
  reshape.1415 = f64[6,32768]{1,0} reshape(broadcast.1414)
  broadcast.1416 = f64[6,32768,32]{2,1,0} broadcast(reshape.1415), dimensions={0,1}
  Arg_2.1413 = f64[] parameter(2)
  broadcast.1417 = f64[6,32768,32]{2,1,0} broadcast(Arg_2.1413), dimensions={}
  ROOT select.1418 = f64[6,32768,32]{2,1,0} select(Arg_0.1411, broadcast.1416, broadcast.1417)
}

build_v_diag_weights.1419 {
  iota.1521 = s64[32]{0} iota(), iota_dimension=0
  reshape.1531 = s64[1,1,32]{2,1,0} reshape(iota.1521)
  broadcast.1534 = s64[1,1,32]{2,1,0} broadcast(reshape.1531), dimensions={0,1,2}
  reshape.1535 = s64[32]{0} reshape(broadcast.1534)
  broadcast.1536 = s64[6,32768,32]{2,1,0} broadcast(reshape.1535), dimensions={2}
  Arg_0.1420 = s32[6]{0} parameter(0)
  reshape.1522 = s32[6,1]{1,0} reshape(Arg_0.1420)
  broadcast.1524 = s32[6,1]{1,0} broadcast(reshape.1522), dimensions={0,1}
  reshape.1525 = s32[6]{0} reshape(broadcast.1524)
  broadcast.1526 = s32[6,32768]{1,0} broadcast(reshape.1525), dimensions={0}
  Arg_1.1421 = s32[32768]{0} parameter(1)
  reshape.1523 = s32[1,32768]{1,0} reshape(Arg_1.1421)
  broadcast.1527 = s32[1,32768]{1,0} broadcast(reshape.1523), dimensions={0,1}
  reshape.1528 = s32[32768]{0} reshape(broadcast.1527)
  broadcast.1529 = s32[6,32768]{1,0} broadcast(reshape.1528), dimensions={1}
  add.1530 = s32[6,32768]{1,0} add(broadcast.1526, broadcast.1529)
  reshape.1532 = s32[6,32768,1]{2,1,0} reshape(add.1530)
  convert.1533 = s64[6,32768,1]{2,1,0} convert(reshape.1532)
  broadcast.1537 = s64[6,32768,1]{2,1,0} broadcast(convert.1533), dimensions={0,1,2}
  reshape.1538 = s64[6,32768]{1,0} reshape(broadcast.1537)
  broadcast.1539 = s64[6,32768,32]{2,1,0} broadcast(reshape.1538), dimensions={0,1}
  subtract.1540 = s64[6,32768,32]{2,1,0} subtract(broadcast.1536, broadcast.1539)
  constant.1425 = s64[] constant(0)
  broadcast.1426 = s64[6,32768,32]{2,1,0} broadcast(constant.1425), dimensions={}
  compare.1541 = pred[6,32768,32]{2,1,0} compare(subtract.1540, broadcast.1426), direction=GE
  constant.1423 = s64[] constant(32)
  broadcast.1424 = s64[6,32768,32]{2,1,0} broadcast(constant.1423), dimensions={}
  compare.1542 = pred[6,32768,32]{2,1,0} compare(subtract.1540, broadcast.1424), direction=LT
  and.1543 = pred[6,32768,32]{2,1,0} and(compare.1541, compare.1542)
  Arg_2.1422 = f64[32768]{0} parameter(2)
  constant.1449 = f64[] constant(20)
  broadcast.1450 = f64[32768]{0} broadcast(constant.1449), dimensions={}
  divide.1456 = f64[32768]{0} divide(Arg_2.1422, broadcast.1450)
  multiply.1452 = f64[32768]{0} multiply(Arg_2.1422, Arg_2.1422)
  constant.1447 = f64[] constant(24)
  broadcast.1448 = f64[32768]{0} broadcast(constant.1447), dimensions={}
  divide.1457 = f64[32768]{0} divide(multiply.1452, broadcast.1448)
  subtract.1458 = f64[32768]{0} subtract(divide.1456, divide.1457)
  multiply.1453 = f64[32768]{0} multiply(multiply.1452, Arg_2.1422)
  divide.1459 = f64[32768]{0} divide(multiply.1453, broadcast.1448)
  subtract.1460 = f64[32768]{0} subtract(subtract.1458, divide.1459)
  multiply.1454 = f64[32768]{0} multiply(multiply.1453, Arg_2.1422)
  divide.1461 = f64[32768]{0} divide(multiply.1454, broadcast.1448)
  add.1462 = f64[32768]{0} add(subtract.1460, divide.1461)
  multiply.1455 = f64[32768]{0} multiply(multiply.1454, Arg_2.1422)
  constant.1445 = f64[] constant(120)
  broadcast.1446 = f64[32768]{0} broadcast(constant.1445), dimensions={}
  divide.1463 = f64[32768]{0} divide(multiply.1455, broadcast.1446)
  subtract.1464 = f64[32768]{0} subtract(add.1462, divide.1463)
  reshape.1514 = f64[1,32768]{1,0} reshape(subtract.1464)
  constant.1443 = f64[] constant(2)
  broadcast.1444 = f64[32768]{0} broadcast(constant.1443), dimensions={}
  divide.1465 = f64[32768]{0} divide(Arg_2.1422, broadcast.1444)
  negate.1466 = f64[32768]{0} negate(divide.1465)
  multiply.1467 = f64[32768]{0} multiply(multiply.1452, broadcast.1444)
  constant.1441 = f64[] constant(3)
  broadcast.1442 = f64[32768]{0} broadcast(constant.1441), dimensions={}
  divide.1468 = f64[32768]{0} divide(multiply.1467, broadcast.1442)
  add.1469 = f64[32768]{0} add(negate.1466, divide.1468)
  divide.1470 = f64[32768]{0} divide(multiply.1453, broadcast.1448)
  subtract.1471 = f64[32768]{0} subtract(add.1469, divide.1470)
  constant.1439 = f64[] constant(6)
  broadcast.1440 = f64[32768]{0} broadcast(constant.1439), dimensions={}
  divide.1472 = f64[32768]{0} divide(multiply.1454, broadcast.1440)
  subtract.1473 = f64[32768]{0} subtract(subtract.1471, divide.1472)
  divide.1474 = f64[32768]{0} divide(multiply.1455, broadcast.1448)
  add.1475 = f64[32768]{0} add(subtract.1473, divide.1474)
  reshape.1515 = f64[1,32768]{1,0} reshape(add.1475)
  constant.1437 = f64[] constant(1)
  broadcast.1438 = f64[32768]{0} broadcast(constant.1437), dimensions={}
  divide.1476 = f64[32768]{0} divide(Arg_2.1422, broadcast.1442)
  subtract.1477 = f64[32768]{0} subtract(broadcast.1438, divide.1476)
  constant.1435 = f64[] constant(5)
  broadcast.1436 = f64[32768]{0} broadcast(constant.1435), dimensions={}
  multiply.1478 = f64[32768]{0} multiply(multiply.1452, broadcast.1436)
  constant.1433 = f64[] constant(4)
  broadcast.1434 = f64[32768]{0} broadcast(constant.1433), dimensions={}
  divide.1479 = f64[32768]{0} divide(multiply.1478, broadcast.1434)
  subtract.1480 = f64[32768]{0} subtract(subtract.1477, divide.1479)
  multiply.1481 = f64[32768]{0} multiply(multiply.1453, broadcast.1436)
  constant.1431 = f64[] constant(12)
  broadcast.1432 = f64[32768]{0} broadcast(constant.1431), dimensions={}
  divide.1482 = f64[32768]{0} divide(multiply.1481, broadcast.1432)
  add.1483 = f64[32768]{0} add(subtract.1480, divide.1482)
  divide.1484 = f64[32768]{0} divide(multiply.1454, broadcast.1434)
  add.1485 = f64[32768]{0} add(add.1483, divide.1484)
  divide.1486 = f64[32768]{0} divide(multiply.1455, broadcast.1432)
  subtract.1487 = f64[32768]{0} subtract(add.1485, divide.1486)
  reshape.1516 = f64[1,32768]{1,0} reshape(subtract.1487)
  multiply.1488 = f64[32768]{0} multiply(multiply.1452, broadcast.1444)
  divide.1489 = f64[32768]{0} divide(multiply.1488, broadcast.1442)
  add.1490 = f64[32768]{0} add(Arg_2.1422, divide.1489)
  constant.1429 = f64[] constant(7)
  broadcast.1430 = f64[32768]{0} broadcast(constant.1429), dimensions={}
  multiply.1491 = f64[32768]{0} multiply(multiply.1453, broadcast.1430)
  divide.1492 = f64[32768]{0} divide(multiply.1491, broadcast.1432)
  subtract.1493 = f64[32768]{0} subtract(add.1490, divide.1492)
  divide.1494 = f64[32768]{0} divide(multiply.1454, broadcast.1440)
  subtract.1495 = f64[32768]{0} subtract(subtract.1493, divide.1494)
  divide.1496 = f64[32768]{0} divide(multiply.1455, broadcast.1432)
  add.1497 = f64[32768]{0} add(subtract.1495, divide.1496)
  reshape.1517 = f64[1,32768]{1,0} reshape(add.1497)
  divide.1498 = f64[32768]{0} divide(Arg_2.1422, broadcast.1434)
  negate.1499 = f64[32768]{0} negate(divide.1498)
  divide.1500 = f64[32768]{0} divide(multiply.1452, broadcast.1448)
  subtract.1501 = f64[32768]{0} subtract(negate.1499, divide.1500)
  multiply.1502 = f64[32768]{0} multiply(multiply.1453, broadcast.1430)
  divide.1503 = f64[32768]{0} divide(multiply.1502, broadcast.1448)
  add.1504 = f64[32768]{0} add(subtract.1501, divide.1503)
  divide.1505 = f64[32768]{0} divide(multiply.1454, broadcast.1448)
  add.1506 = f64[32768]{0} add(add.1504, divide.1505)
  divide.1507 = f64[32768]{0} divide(multiply.1455, broadcast.1448)
  subtract.1508 = f64[32768]{0} subtract(add.1506, divide.1507)
  reshape.1518 = f64[1,32768]{1,0} reshape(subtract.1508)
  constant.1427 = f64[] constant(30)
  broadcast.1428 = f64[32768]{0} broadcast(constant.1427), dimensions={}
  divide.1509 = f64[32768]{0} divide(Arg_2.1422, broadcast.1428)
  divide.1510 = f64[32768]{0} divide(multiply.1453, broadcast.1448)
  subtract.1511 = f64[32768]{0} subtract(divide.1509, divide.1510)
  divide.1512 = f64[32768]{0} divide(multiply.1455, broadcast.1446)
  add.1513 = f64[32768]{0} add(subtract.1511, divide.1512)
  reshape.1519 = f64[1,32768]{1,0} reshape(add.1513)
  concatenate.1520 = f64[6,32768]{1,0} concatenate(reshape.1514, reshape.1515, reshape.1516, reshape.1517, reshape.1518, reshape.1519), dimensions={0}
  reshape.1544 = f64[6,32768,1]{2,1,0} reshape(concatenate.1520)
  constant.1451 = f64[] constant(0)
  ROOT call.1545 = f64[6,32768,32]{2,1,0} call(and.1543, reshape.1544, constant.1451), to_apply=_where_2.1410
}

_where.1546 {
  Arg_0.1547 = pred[] parameter(0)
  Arg_1.1548 = s32[] parameter(1)
  Arg_2.1549 = s32[] parameter(2)
  ROOT select.1550 = s32[] select(Arg_0.1547, Arg_1.1548, Arg_2.1549)
}

remainder.1551 {
  Arg_0.1552 = s32[32768]{0} parameter(0)
  Arg_1.1553 = s32[] parameter(1)
  constant.1557 = s32[] constant(0)
  compare.1558 = pred[] compare(Arg_1.1553, constant.1557), direction=EQ
  constant.1556 = s32[] constant(1)
  call.1559 = s32[] call(compare.1558, constant.1556, Arg_1.1553), to_apply=_where.1546
  broadcast.1560 = s32[32768]{0} broadcast(call.1559), dimensions={}
  remainder.1561 = s32[32768]{0} remainder(Arg_0.1552, broadcast.1560)
  constant.1554 = s32[] constant(0)
  broadcast.1555 = s32[32768]{0} broadcast(constant.1554), dimensions={}
  compare.1563 = pred[32768]{0} compare(remainder.1561, broadcast.1555), direction=LT
  compare.1564 = pred[] compare(call.1559, constant.1557), direction=LT
  broadcast.1565 = pred[32768]{0} broadcast(compare.1564), dimensions={}
  compare.1566 = pred[32768]{0} compare(compare.1563, broadcast.1565), direction=NE
  compare.1562 = pred[32768]{0} compare(remainder.1561, broadcast.1555), direction=NE
  and.1567 = pred[32768]{0} and(compare.1566, compare.1562)
  broadcast.1568 = s32[32768]{0} broadcast(call.1559), dimensions={}
  add.1569 = s32[32768]{0} add(remainder.1561, broadcast.1568)
  ROOT select.1570 = s32[32768]{0} select(and.1567, add.1569, remainder.1561)
}

_roll_dynamic.1571 {
  Arg_0.1572 = f64[32768,32]{1,0} parameter(0)
  concatenate.1582 = f64[32768,64]{1,0} concatenate(Arg_0.1572, Arg_0.1572), dimensions={1}
  constant.1578 = s32[] constant(32)
  broadcast.1579 = s32[32768]{0} broadcast(constant.1578), dimensions={}
  Arg_1.1573 = s32[32768]{0} parameter(1)
  constant.1580 = s32[] constant(32)
  call.1581 = s32[32768]{0} call(Arg_1.1573, constant.1580), to_apply=remainder.1551
  subtract.1583 = s32[32768]{0} subtract(broadcast.1579, call.1581)
  constant.1576 = s32[] constant(0)
  broadcast.1577 = s32[32768]{0} broadcast(constant.1576), dimensions={}
  compare.1584 = pred[32768]{0} compare(subtract.1583, broadcast.1577), direction=LT
  constant.1574 = s32[] constant(64)
  broadcast.1575 = s32[32768]{0} broadcast(constant.1574), dimensions={}
  add.1585 = s32[32768]{0} add(subtract.1583, broadcast.1575)
  select.1586 = s32[32768]{0} select(compare.1584, add.1585, subtract.1583)
  reshape.1587 = s32[32768,1]{1,0} reshape(select.1586)
  ROOT gather.1588 = f64[32768,32]{1,0} gather(concatenate.1582, reshape.1587), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1589 {
  Arg_0.1590 = pred[] parameter(0)
  Arg_1.1591 = s32[] parameter(1)
  Arg_2.1592 = s32[] parameter(2)
  ROOT select.1593 = s32[] select(Arg_0.1590, Arg_1.1591, Arg_2.1592)
}

remainder.1594 {
  Arg_0.1595 = s32[32768]{0} parameter(0)
  Arg_1.1596 = s32[] parameter(1)
  constant.1600 = s32[] constant(0)
  compare.1601 = pred[] compare(Arg_1.1596, constant.1600), direction=EQ
  constant.1599 = s32[] constant(1)
  call.1602 = s32[] call(compare.1601, constant.1599, Arg_1.1596), to_apply=_where.1589
  broadcast.1603 = s32[32768]{0} broadcast(call.1602), dimensions={}
  remainder.1604 = s32[32768]{0} remainder(Arg_0.1595, broadcast.1603)
  constant.1597 = s32[] constant(0)
  broadcast.1598 = s32[32768]{0} broadcast(constant.1597), dimensions={}
  compare.1606 = pred[32768]{0} compare(remainder.1604, broadcast.1598), direction=LT
  compare.1607 = pred[] compare(call.1602, constant.1600), direction=LT
  broadcast.1608 = pred[32768]{0} broadcast(compare.1607), dimensions={}
  compare.1609 = pred[32768]{0} compare(compare.1606, broadcast.1608), direction=NE
  compare.1605 = pred[32768]{0} compare(remainder.1604, broadcast.1598), direction=NE
  and.1610 = pred[32768]{0} and(compare.1609, compare.1605)
  broadcast.1611 = s32[32768]{0} broadcast(call.1602), dimensions={}
  add.1612 = s32[32768]{0} add(remainder.1604, broadcast.1611)
  ROOT select.1613 = s32[32768]{0} select(and.1610, add.1612, remainder.1604)
}

_roll_dynamic.1614 {
  Arg_0.1615 = f64[32768,32]{1,0} parameter(0)
  concatenate.1625 = f64[32768,64]{1,0} concatenate(Arg_0.1615, Arg_0.1615), dimensions={1}
  constant.1621 = s32[] constant(32)
  broadcast.1622 = s32[32768]{0} broadcast(constant.1621), dimensions={}
  Arg_1.1616 = s32[32768]{0} parameter(1)
  constant.1623 = s32[] constant(32)
  call.1624 = s32[32768]{0} call(Arg_1.1616, constant.1623), to_apply=remainder.1594
  subtract.1626 = s32[32768]{0} subtract(broadcast.1622, call.1624)
  constant.1619 = s32[] constant(0)
  broadcast.1620 = s32[32768]{0} broadcast(constant.1619), dimensions={}
  compare.1627 = pred[32768]{0} compare(subtract.1626, broadcast.1620), direction=LT
  constant.1617 = s32[] constant(64)
  broadcast.1618 = s32[32768]{0} broadcast(constant.1617), dimensions={}
  add.1628 = s32[32768]{0} add(subtract.1626, broadcast.1618)
  select.1629 = s32[32768]{0} select(compare.1627, add.1628, subtract.1626)
  reshape.1630 = s32[32768,1]{1,0} reshape(select.1629)
  ROOT gather.1631 = f64[32768,32]{1,0} gather(concatenate.1625, reshape.1630), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1632 {
  Arg_0.1633 = pred[] parameter(0)
  Arg_1.1634 = s32[] parameter(1)
  Arg_2.1635 = s32[] parameter(2)
  ROOT select.1636 = s32[] select(Arg_0.1633, Arg_1.1634, Arg_2.1635)
}

remainder.1637 {
  Arg_0.1638 = s32[32768]{0} parameter(0)
  Arg_1.1639 = s32[] parameter(1)
  constant.1643 = s32[] constant(0)
  compare.1644 = pred[] compare(Arg_1.1639, constant.1643), direction=EQ
  constant.1642 = s32[] constant(1)
  call.1645 = s32[] call(compare.1644, constant.1642, Arg_1.1639), to_apply=_where.1632
  broadcast.1646 = s32[32768]{0} broadcast(call.1645), dimensions={}
  remainder.1647 = s32[32768]{0} remainder(Arg_0.1638, broadcast.1646)
  constant.1640 = s32[] constant(0)
  broadcast.1641 = s32[32768]{0} broadcast(constant.1640), dimensions={}
  compare.1649 = pred[32768]{0} compare(remainder.1647, broadcast.1641), direction=LT
  compare.1650 = pred[] compare(call.1645, constant.1643), direction=LT
  broadcast.1651 = pred[32768]{0} broadcast(compare.1650), dimensions={}
  compare.1652 = pred[32768]{0} compare(compare.1649, broadcast.1651), direction=NE
  compare.1648 = pred[32768]{0} compare(remainder.1647, broadcast.1641), direction=NE
  and.1653 = pred[32768]{0} and(compare.1652, compare.1648)
  broadcast.1654 = s32[32768]{0} broadcast(call.1645), dimensions={}
  add.1655 = s32[32768]{0} add(remainder.1647, broadcast.1654)
  ROOT select.1656 = s32[32768]{0} select(and.1653, add.1655, remainder.1647)
}

_roll_dynamic.1657 {
  Arg_0.1658 = f64[32768,32]{1,0} parameter(0)
  concatenate.1668 = f64[32768,64]{1,0} concatenate(Arg_0.1658, Arg_0.1658), dimensions={1}
  constant.1664 = s32[] constant(32)
  broadcast.1665 = s32[32768]{0} broadcast(constant.1664), dimensions={}
  Arg_1.1659 = s32[32768]{0} parameter(1)
  constant.1666 = s32[] constant(32)
  call.1667 = s32[32768]{0} call(Arg_1.1659, constant.1666), to_apply=remainder.1637
  subtract.1669 = s32[32768]{0} subtract(broadcast.1665, call.1667)
  constant.1662 = s32[] constant(0)
  broadcast.1663 = s32[32768]{0} broadcast(constant.1662), dimensions={}
  compare.1670 = pred[32768]{0} compare(subtract.1669, broadcast.1663), direction=LT
  constant.1660 = s32[] constant(64)
  broadcast.1661 = s32[32768]{0} broadcast(constant.1660), dimensions={}
  add.1671 = s32[32768]{0} add(subtract.1669, broadcast.1661)
  select.1672 = s32[32768]{0} select(compare.1670, add.1671, subtract.1669)
  reshape.1673 = s32[32768,1]{1,0} reshape(select.1672)
  ROOT gather.1674 = f64[32768,32]{1,0} gather(concatenate.1668, reshape.1673), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1675 {
  Arg_0.1676 = pred[] parameter(0)
  Arg_1.1677 = s32[] parameter(1)
  Arg_2.1678 = s32[] parameter(2)
  ROOT select.1679 = s32[] select(Arg_0.1676, Arg_1.1677, Arg_2.1678)
}

remainder.1680 {
  Arg_0.1681 = s32[32768]{0} parameter(0)
  Arg_1.1682 = s32[] parameter(1)
  constant.1686 = s32[] constant(0)
  compare.1687 = pred[] compare(Arg_1.1682, constant.1686), direction=EQ
  constant.1685 = s32[] constant(1)
  call.1688 = s32[] call(compare.1687, constant.1685, Arg_1.1682), to_apply=_where.1675
  broadcast.1689 = s32[32768]{0} broadcast(call.1688), dimensions={}
  remainder.1690 = s32[32768]{0} remainder(Arg_0.1681, broadcast.1689)
  constant.1683 = s32[] constant(0)
  broadcast.1684 = s32[32768]{0} broadcast(constant.1683), dimensions={}
  compare.1692 = pred[32768]{0} compare(remainder.1690, broadcast.1684), direction=LT
  compare.1693 = pred[] compare(call.1688, constant.1686), direction=LT
  broadcast.1694 = pred[32768]{0} broadcast(compare.1693), dimensions={}
  compare.1695 = pred[32768]{0} compare(compare.1692, broadcast.1694), direction=NE
  compare.1691 = pred[32768]{0} compare(remainder.1690, broadcast.1684), direction=NE
  and.1696 = pred[32768]{0} and(compare.1695, compare.1691)
  broadcast.1697 = s32[32768]{0} broadcast(call.1688), dimensions={}
  add.1698 = s32[32768]{0} add(remainder.1690, broadcast.1697)
  ROOT select.1699 = s32[32768]{0} select(and.1696, add.1698, remainder.1690)
}

_roll_dynamic.1700 {
  Arg_0.1701 = f64[32768,32]{1,0} parameter(0)
  concatenate.1711 = f64[32768,64]{1,0} concatenate(Arg_0.1701, Arg_0.1701), dimensions={1}
  constant.1707 = s32[] constant(32)
  broadcast.1708 = s32[32768]{0} broadcast(constant.1707), dimensions={}
  Arg_1.1702 = s32[32768]{0} parameter(1)
  constant.1709 = s32[] constant(32)
  call.1710 = s32[32768]{0} call(Arg_1.1702, constant.1709), to_apply=remainder.1680
  subtract.1712 = s32[32768]{0} subtract(broadcast.1708, call.1710)
  constant.1705 = s32[] constant(0)
  broadcast.1706 = s32[32768]{0} broadcast(constant.1705), dimensions={}
  compare.1713 = pred[32768]{0} compare(subtract.1712, broadcast.1706), direction=LT
  constant.1703 = s32[] constant(64)
  broadcast.1704 = s32[32768]{0} broadcast(constant.1703), dimensions={}
  add.1714 = s32[32768]{0} add(subtract.1712, broadcast.1704)
  select.1715 = s32[32768]{0} select(compare.1713, add.1714, subtract.1712)
  reshape.1716 = s32[32768,1]{1,0} reshape(select.1715)
  ROOT gather.1717 = f64[32768,32]{1,0} gather(concatenate.1711, reshape.1716), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1718 {
  Arg_0.1719 = pred[] parameter(0)
  Arg_1.1720 = s32[] parameter(1)
  Arg_2.1721 = s32[] parameter(2)
  ROOT select.1722 = s32[] select(Arg_0.1719, Arg_1.1720, Arg_2.1721)
}

remainder.1723 {
  Arg_0.1724 = s32[32768]{0} parameter(0)
  Arg_1.1725 = s32[] parameter(1)
  constant.1729 = s32[] constant(0)
  compare.1730 = pred[] compare(Arg_1.1725, constant.1729), direction=EQ
  constant.1728 = s32[] constant(1)
  call.1731 = s32[] call(compare.1730, constant.1728, Arg_1.1725), to_apply=_where.1718
  broadcast.1732 = s32[32768]{0} broadcast(call.1731), dimensions={}
  remainder.1733 = s32[32768]{0} remainder(Arg_0.1724, broadcast.1732)
  constant.1726 = s32[] constant(0)
  broadcast.1727 = s32[32768]{0} broadcast(constant.1726), dimensions={}
  compare.1735 = pred[32768]{0} compare(remainder.1733, broadcast.1727), direction=LT
  compare.1736 = pred[] compare(call.1731, constant.1729), direction=LT
  broadcast.1737 = pred[32768]{0} broadcast(compare.1736), dimensions={}
  compare.1738 = pred[32768]{0} compare(compare.1735, broadcast.1737), direction=NE
  compare.1734 = pred[32768]{0} compare(remainder.1733, broadcast.1727), direction=NE
  and.1739 = pred[32768]{0} and(compare.1738, compare.1734)
  broadcast.1740 = s32[32768]{0} broadcast(call.1731), dimensions={}
  add.1741 = s32[32768]{0} add(remainder.1733, broadcast.1740)
  ROOT select.1742 = s32[32768]{0} select(and.1739, add.1741, remainder.1733)
}

_roll_dynamic.1743 {
  Arg_0.1744 = f64[32768,32]{1,0} parameter(0)
  concatenate.1754 = f64[32768,64]{1,0} concatenate(Arg_0.1744, Arg_0.1744), dimensions={1}
  constant.1750 = s32[] constant(32)
  broadcast.1751 = s32[32768]{0} broadcast(constant.1750), dimensions={}
  Arg_1.1745 = s32[32768]{0} parameter(1)
  constant.1752 = s32[] constant(32)
  call.1753 = s32[32768]{0} call(Arg_1.1745, constant.1752), to_apply=remainder.1723
  subtract.1755 = s32[32768]{0} subtract(broadcast.1751, call.1753)
  constant.1748 = s32[] constant(0)
  broadcast.1749 = s32[32768]{0} broadcast(constant.1748), dimensions={}
  compare.1756 = pred[32768]{0} compare(subtract.1755, broadcast.1749), direction=LT
  constant.1746 = s32[] constant(64)
  broadcast.1747 = s32[32768]{0} broadcast(constant.1746), dimensions={}
  add.1757 = s32[32768]{0} add(subtract.1755, broadcast.1747)
  select.1758 = s32[32768]{0} select(compare.1756, add.1757, subtract.1755)
  reshape.1759 = s32[32768,1]{1,0} reshape(select.1758)
  ROOT gather.1760 = f64[32768,32]{1,0} gather(concatenate.1754, reshape.1759), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1761 {
  Arg_0.1762 = pred[] parameter(0)
  Arg_1.1763 = s32[] parameter(1)
  Arg_2.1764 = s32[] parameter(2)
  ROOT select.1765 = s32[] select(Arg_0.1762, Arg_1.1763, Arg_2.1764)
}

remainder.1766 {
  Arg_0.1767 = s32[32768]{0} parameter(0)
  Arg_1.1768 = s32[] parameter(1)
  constant.1772 = s32[] constant(0)
  compare.1773 = pred[] compare(Arg_1.1768, constant.1772), direction=EQ
  constant.1771 = s32[] constant(1)
  call.1774 = s32[] call(compare.1773, constant.1771, Arg_1.1768), to_apply=_where.1761
  broadcast.1775 = s32[32768]{0} broadcast(call.1774), dimensions={}
  remainder.1776 = s32[32768]{0} remainder(Arg_0.1767, broadcast.1775)
  constant.1769 = s32[] constant(0)
  broadcast.1770 = s32[32768]{0} broadcast(constant.1769), dimensions={}
  compare.1778 = pred[32768]{0} compare(remainder.1776, broadcast.1770), direction=LT
  compare.1779 = pred[] compare(call.1774, constant.1772), direction=LT
  broadcast.1780 = pred[32768]{0} broadcast(compare.1779), dimensions={}
  compare.1781 = pred[32768]{0} compare(compare.1778, broadcast.1780), direction=NE
  compare.1777 = pred[32768]{0} compare(remainder.1776, broadcast.1770), direction=NE
  and.1782 = pred[32768]{0} and(compare.1781, compare.1777)
  broadcast.1783 = s32[32768]{0} broadcast(call.1774), dimensions={}
  add.1784 = s32[32768]{0} add(remainder.1776, broadcast.1783)
  ROOT select.1785 = s32[32768]{0} select(and.1782, add.1784, remainder.1776)
}

_roll_dynamic.1786 {
  Arg_0.1787 = f64[32768,32]{1,0} parameter(0)
  concatenate.1797 = f64[32768,64]{1,0} concatenate(Arg_0.1787, Arg_0.1787), dimensions={1}
  constant.1793 = s32[] constant(32)
  broadcast.1794 = s32[32768]{0} broadcast(constant.1793), dimensions={}
  Arg_1.1788 = s32[32768]{0} parameter(1)
  constant.1795 = s32[] constant(32)
  call.1796 = s32[32768]{0} call(Arg_1.1788, constant.1795), to_apply=remainder.1766
  subtract.1798 = s32[32768]{0} subtract(broadcast.1794, call.1796)
  constant.1791 = s32[] constant(0)
  broadcast.1792 = s32[32768]{0} broadcast(constant.1791), dimensions={}
  compare.1799 = pred[32768]{0} compare(subtract.1798, broadcast.1792), direction=LT
  constant.1789 = s32[] constant(64)
  broadcast.1790 = s32[32768]{0} broadcast(constant.1789), dimensions={}
  add.1800 = s32[32768]{0} add(subtract.1798, broadcast.1790)
  select.1801 = s32[32768]{0} select(compare.1799, add.1800, subtract.1798)
  reshape.1802 = s32[32768,1]{1,0} reshape(select.1801)
  ROOT gather.1803 = f64[32768,32]{1,0} gather(concatenate.1797, reshape.1802), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag_1.1804 {
  Arg_4.1809 = s32[6]{0} parameter(4)
  Arg_1.1806 = f64[32768]{0} parameter(1)
  Arg_2.1807 = f64[] parameter(2)
  broadcast.1810 = f64[32768]{0} broadcast(Arg_2.1807), dimensions={}
  multiply.1811 = f64[32768]{0} multiply(Arg_1.1806, broadcast.1810)
  Arg_3.1808 = f64[] parameter(3)
  broadcast.1812 = f64[32768]{0} broadcast(Arg_3.1808), dimensions={}
  divide.1813 = f64[32768]{0} divide(multiply.1811, broadcast.1812)
  floor.1814 = f64[32768]{0} floor(divide.1813)
  convert.1816 = s32[32768]{0} convert(floor.1814)
  subtract.1815 = f64[32768]{0} subtract(divide.1813, floor.1814)
  call.1817 = f64[6,32768,32]{2,1,0} call(Arg_4.1809, convert.1816, subtract.1815), to_apply=build_v_diag_weights.1419
  slice.1823 = f64[1,32768,32]{2,1,0} slice(call.1817), slice={[0:1], [0:32768], [0:32]}
  reshape.1824 = f64[32768,32]{1,0} reshape(slice.1823)
  Arg_0.1805 = f64[32768,32]{1,0} parameter(0)
  slice.1818 = s32[1]{0} slice(Arg_4.1809), slice={[0:1]}
  reshape.1819 = s32[] reshape(slice.1818)
  broadcast.1820 = s32[32768]{0} broadcast(reshape.1819), dimensions={}
  add.1821 = s32[32768]{0} add(convert.1816, broadcast.1820)
  call.1822 = f64[32768,32]{1,0} call(Arg_0.1805, add.1821), to_apply=_roll_dynamic.1571
  multiply.1825 = f64[32768,32]{1,0} multiply(reshape.1824, call.1822)
  slice.1831 = f64[1,32768,32]{2,1,0} slice(call.1817), slice={[1:2], [0:32768], [0:32]}
  reshape.1832 = f64[32768,32]{1,0} reshape(slice.1831)
  slice.1826 = s32[1]{0} slice(Arg_4.1809), slice={[1:2]}
  reshape.1827 = s32[] reshape(slice.1826)
  broadcast.1828 = s32[32768]{0} broadcast(reshape.1827), dimensions={}
  add.1829 = s32[32768]{0} add(convert.1816, broadcast.1828)
  call.1830 = f64[32768,32]{1,0} call(Arg_0.1805, add.1829), to_apply=_roll_dynamic.1614
  multiply.1833 = f64[32768,32]{1,0} multiply(reshape.1832, call.1830)
  add.1834 = f64[32768,32]{1,0} add(multiply.1825, multiply.1833)
  slice.1840 = f64[1,32768,32]{2,1,0} slice(call.1817), slice={[2:3], [0:32768], [0:32]}
  reshape.1841 = f64[32768,32]{1,0} reshape(slice.1840)
  slice.1835 = s32[1]{0} slice(Arg_4.1809), slice={[2:3]}
  reshape.1836 = s32[] reshape(slice.1835)
  broadcast.1837 = s32[32768]{0} broadcast(reshape.1836), dimensions={}
  add.1838 = s32[32768]{0} add(convert.1816, broadcast.1837)
  call.1839 = f64[32768,32]{1,0} call(Arg_0.1805, add.1838), to_apply=_roll_dynamic.1657
  multiply.1842 = f64[32768,32]{1,0} multiply(reshape.1841, call.1839)
  add.1843 = f64[32768,32]{1,0} add(add.1834, multiply.1842)
  slice.1849 = f64[1,32768,32]{2,1,0} slice(call.1817), slice={[3:4], [0:32768], [0:32]}
  reshape.1850 = f64[32768,32]{1,0} reshape(slice.1849)
  slice.1844 = s32[1]{0} slice(Arg_4.1809), slice={[3:4]}
  reshape.1845 = s32[] reshape(slice.1844)
  broadcast.1846 = s32[32768]{0} broadcast(reshape.1845), dimensions={}
  add.1847 = s32[32768]{0} add(convert.1816, broadcast.1846)
  call.1848 = f64[32768,32]{1,0} call(Arg_0.1805, add.1847), to_apply=_roll_dynamic.1700
  multiply.1851 = f64[32768,32]{1,0} multiply(reshape.1850, call.1848)
  add.1852 = f64[32768,32]{1,0} add(add.1843, multiply.1851)
  slice.1858 = f64[1,32768,32]{2,1,0} slice(call.1817), slice={[4:5], [0:32768], [0:32]}
  reshape.1859 = f64[32768,32]{1,0} reshape(slice.1858)
  slice.1853 = s32[1]{0} slice(Arg_4.1809), slice={[4:5]}
  reshape.1854 = s32[] reshape(slice.1853)
  broadcast.1855 = s32[32768]{0} broadcast(reshape.1854), dimensions={}
  add.1856 = s32[32768]{0} add(convert.1816, broadcast.1855)
  call.1857 = f64[32768,32]{1,0} call(Arg_0.1805, add.1856), to_apply=_roll_dynamic.1743
  multiply.1860 = f64[32768,32]{1,0} multiply(reshape.1859, call.1857)
  add.1861 = f64[32768,32]{1,0} add(add.1852, multiply.1860)
  slice.1867 = f64[1,32768,32]{2,1,0} slice(call.1817), slice={[5:6], [0:32768], [0:32]}
  reshape.1868 = f64[32768,32]{1,0} reshape(slice.1867)
  slice.1862 = s32[1]{0} slice(Arg_4.1809), slice={[5:6]}
  reshape.1863 = s32[] reshape(slice.1862)
  broadcast.1864 = s32[32768]{0} broadcast(reshape.1863), dimensions={}
  add.1865 = s32[32768]{0} add(convert.1816, broadcast.1864)
  call.1866 = f64[32768,32]{1,0} call(Arg_0.1805, add.1865), to_apply=_roll_dynamic.1786
  multiply.1869 = f64[32768,32]{1,0} multiply(reshape.1868, call.1866)
  ROOT add.1870 = f64[32768,32]{1,0} add(add.1861, multiply.1869)
}

_where.1879 {
  Arg_0.1880 = pred[] parameter(0)
  Arg_1.1881 = s32[] parameter(1)
  Arg_2.1882 = s32[] parameter(2)
  ROOT select.1883 = s32[] select(Arg_0.1880, Arg_1.1881, Arg_2.1882)
}

remainder.1884 {
  Arg_0.1885 = s32[32768]{0} parameter(0)
  Arg_1.1886 = s32[] parameter(1)
  constant.1890 = s32[] constant(0)
  compare.1891 = pred[] compare(Arg_1.1886, constant.1890), direction=EQ
  constant.1889 = s32[] constant(1)
  call.1892 = s32[] call(compare.1891, constant.1889, Arg_1.1886), to_apply=_where.1879
  broadcast.1893 = s32[32768]{0} broadcast(call.1892), dimensions={}
  remainder.1894 = s32[32768]{0} remainder(Arg_0.1885, broadcast.1893)
  constant.1887 = s32[] constant(0)
  broadcast.1888 = s32[32768]{0} broadcast(constant.1887), dimensions={}
  compare.1896 = pred[32768]{0} compare(remainder.1894, broadcast.1888), direction=LT
  compare.1897 = pred[] compare(call.1892, constant.1890), direction=LT
  broadcast.1898 = pred[32768]{0} broadcast(compare.1897), dimensions={}
  compare.1899 = pred[32768]{0} compare(compare.1896, broadcast.1898), direction=NE
  compare.1895 = pred[32768]{0} compare(remainder.1894, broadcast.1888), direction=NE
  and.1900 = pred[32768]{0} and(compare.1899, compare.1895)
  broadcast.1901 = s32[32768]{0} broadcast(call.1892), dimensions={}
  add.1902 = s32[32768]{0} add(remainder.1894, broadcast.1901)
  ROOT select.1903 = s32[32768]{0} select(and.1900, add.1902, remainder.1894)
}

_roll_dynamic.1904 {
  Arg_0.1905 = f64[32768,32]{1,0} parameter(0)
  concatenate.1915 = f64[32768,64]{1,0} concatenate(Arg_0.1905, Arg_0.1905), dimensions={1}
  constant.1911 = s32[] constant(32)
  broadcast.1912 = s32[32768]{0} broadcast(constant.1911), dimensions={}
  Arg_1.1906 = s32[32768]{0} parameter(1)
  constant.1913 = s32[] constant(32)
  call.1914 = s32[32768]{0} call(Arg_1.1906, constant.1913), to_apply=remainder.1884
  subtract.1916 = s32[32768]{0} subtract(broadcast.1912, call.1914)
  constant.1909 = s32[] constant(0)
  broadcast.1910 = s32[32768]{0} broadcast(constant.1909), dimensions={}
  compare.1917 = pred[32768]{0} compare(subtract.1916, broadcast.1910), direction=LT
  constant.1907 = s32[] constant(64)
  broadcast.1908 = s32[32768]{0} broadcast(constant.1907), dimensions={}
  add.1918 = s32[32768]{0} add(subtract.1916, broadcast.1908)
  select.1919 = s32[32768]{0} select(compare.1917, add.1918, subtract.1916)
  reshape.1920 = s32[32768,1]{1,0} reshape(select.1919)
  ROOT gather.1921 = f64[32768,32]{1,0} gather(concatenate.1915, reshape.1920), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1922 {
  Arg_0.1923 = pred[] parameter(0)
  Arg_1.1924 = s32[] parameter(1)
  Arg_2.1925 = s32[] parameter(2)
  ROOT select.1926 = s32[] select(Arg_0.1923, Arg_1.1924, Arg_2.1925)
}

remainder.1927 {
  Arg_0.1928 = s32[32768]{0} parameter(0)
  Arg_1.1929 = s32[] parameter(1)
  constant.1933 = s32[] constant(0)
  compare.1934 = pred[] compare(Arg_1.1929, constant.1933), direction=EQ
  constant.1932 = s32[] constant(1)
  call.1935 = s32[] call(compare.1934, constant.1932, Arg_1.1929), to_apply=_where.1922
  broadcast.1936 = s32[32768]{0} broadcast(call.1935), dimensions={}
  remainder.1937 = s32[32768]{0} remainder(Arg_0.1928, broadcast.1936)
  constant.1930 = s32[] constant(0)
  broadcast.1931 = s32[32768]{0} broadcast(constant.1930), dimensions={}
  compare.1939 = pred[32768]{0} compare(remainder.1937, broadcast.1931), direction=LT
  compare.1940 = pred[] compare(call.1935, constant.1933), direction=LT
  broadcast.1941 = pred[32768]{0} broadcast(compare.1940), dimensions={}
  compare.1942 = pred[32768]{0} compare(compare.1939, broadcast.1941), direction=NE
  compare.1938 = pred[32768]{0} compare(remainder.1937, broadcast.1931), direction=NE
  and.1943 = pred[32768]{0} and(compare.1942, compare.1938)
  broadcast.1944 = s32[32768]{0} broadcast(call.1935), dimensions={}
  add.1945 = s32[32768]{0} add(remainder.1937, broadcast.1944)
  ROOT select.1946 = s32[32768]{0} select(and.1943, add.1945, remainder.1937)
}

_roll_dynamic.1947 {
  Arg_0.1948 = f64[32768,32]{1,0} parameter(0)
  concatenate.1958 = f64[32768,64]{1,0} concatenate(Arg_0.1948, Arg_0.1948), dimensions={1}
  constant.1954 = s32[] constant(32)
  broadcast.1955 = s32[32768]{0} broadcast(constant.1954), dimensions={}
  Arg_1.1949 = s32[32768]{0} parameter(1)
  constant.1956 = s32[] constant(32)
  call.1957 = s32[32768]{0} call(Arg_1.1949, constant.1956), to_apply=remainder.1927
  subtract.1959 = s32[32768]{0} subtract(broadcast.1955, call.1957)
  constant.1952 = s32[] constant(0)
  broadcast.1953 = s32[32768]{0} broadcast(constant.1952), dimensions={}
  compare.1960 = pred[32768]{0} compare(subtract.1959, broadcast.1953), direction=LT
  constant.1950 = s32[] constant(64)
  broadcast.1951 = s32[32768]{0} broadcast(constant.1950), dimensions={}
  add.1961 = s32[32768]{0} add(subtract.1959, broadcast.1951)
  select.1962 = s32[32768]{0} select(compare.1960, add.1961, subtract.1959)
  reshape.1963 = s32[32768,1]{1,0} reshape(select.1962)
  ROOT gather.1964 = f64[32768,32]{1,0} gather(concatenate.1958, reshape.1963), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1965 {
  Arg_0.1966 = pred[] parameter(0)
  Arg_1.1967 = s32[] parameter(1)
  Arg_2.1968 = s32[] parameter(2)
  ROOT select.1969 = s32[] select(Arg_0.1966, Arg_1.1967, Arg_2.1968)
}

remainder.1970 {
  Arg_0.1971 = s32[32768]{0} parameter(0)
  Arg_1.1972 = s32[] parameter(1)
  constant.1976 = s32[] constant(0)
  compare.1977 = pred[] compare(Arg_1.1972, constant.1976), direction=EQ
  constant.1975 = s32[] constant(1)
  call.1978 = s32[] call(compare.1977, constant.1975, Arg_1.1972), to_apply=_where.1965
  broadcast.1979 = s32[32768]{0} broadcast(call.1978), dimensions={}
  remainder.1980 = s32[32768]{0} remainder(Arg_0.1971, broadcast.1979)
  constant.1973 = s32[] constant(0)
  broadcast.1974 = s32[32768]{0} broadcast(constant.1973), dimensions={}
  compare.1982 = pred[32768]{0} compare(remainder.1980, broadcast.1974), direction=LT
  compare.1983 = pred[] compare(call.1978, constant.1976), direction=LT
  broadcast.1984 = pred[32768]{0} broadcast(compare.1983), dimensions={}
  compare.1985 = pred[32768]{0} compare(compare.1982, broadcast.1984), direction=NE
  compare.1981 = pred[32768]{0} compare(remainder.1980, broadcast.1974), direction=NE
  and.1986 = pred[32768]{0} and(compare.1985, compare.1981)
  broadcast.1987 = s32[32768]{0} broadcast(call.1978), dimensions={}
  add.1988 = s32[32768]{0} add(remainder.1980, broadcast.1987)
  ROOT select.1989 = s32[32768]{0} select(and.1986, add.1988, remainder.1980)
}

_roll_dynamic.1990 {
  Arg_0.1991 = f64[32768,32]{1,0} parameter(0)
  concatenate.2001 = f64[32768,64]{1,0} concatenate(Arg_0.1991, Arg_0.1991), dimensions={1}
  constant.1997 = s32[] constant(32)
  broadcast.1998 = s32[32768]{0} broadcast(constant.1997), dimensions={}
  Arg_1.1992 = s32[32768]{0} parameter(1)
  constant.1999 = s32[] constant(32)
  call.2000 = s32[32768]{0} call(Arg_1.1992, constant.1999), to_apply=remainder.1970
  subtract.2002 = s32[32768]{0} subtract(broadcast.1998, call.2000)
  constant.1995 = s32[] constant(0)
  broadcast.1996 = s32[32768]{0} broadcast(constant.1995), dimensions={}
  compare.2003 = pred[32768]{0} compare(subtract.2002, broadcast.1996), direction=LT
  constant.1993 = s32[] constant(64)
  broadcast.1994 = s32[32768]{0} broadcast(constant.1993), dimensions={}
  add.2004 = s32[32768]{0} add(subtract.2002, broadcast.1994)
  select.2005 = s32[32768]{0} select(compare.2003, add.2004, subtract.2002)
  reshape.2006 = s32[32768,1]{1,0} reshape(select.2005)
  ROOT gather.2007 = f64[32768,32]{1,0} gather(concatenate.2001, reshape.2006), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2008 {
  Arg_0.2009 = pred[] parameter(0)
  Arg_1.2010 = s32[] parameter(1)
  Arg_2.2011 = s32[] parameter(2)
  ROOT select.2012 = s32[] select(Arg_0.2009, Arg_1.2010, Arg_2.2011)
}

remainder.2013 {
  Arg_0.2014 = s32[32768]{0} parameter(0)
  Arg_1.2015 = s32[] parameter(1)
  constant.2019 = s32[] constant(0)
  compare.2020 = pred[] compare(Arg_1.2015, constant.2019), direction=EQ
  constant.2018 = s32[] constant(1)
  call.2021 = s32[] call(compare.2020, constant.2018, Arg_1.2015), to_apply=_where.2008
  broadcast.2022 = s32[32768]{0} broadcast(call.2021), dimensions={}
  remainder.2023 = s32[32768]{0} remainder(Arg_0.2014, broadcast.2022)
  constant.2016 = s32[] constant(0)
  broadcast.2017 = s32[32768]{0} broadcast(constant.2016), dimensions={}
  compare.2025 = pred[32768]{0} compare(remainder.2023, broadcast.2017), direction=LT
  compare.2026 = pred[] compare(call.2021, constant.2019), direction=LT
  broadcast.2027 = pred[32768]{0} broadcast(compare.2026), dimensions={}
  compare.2028 = pred[32768]{0} compare(compare.2025, broadcast.2027), direction=NE
  compare.2024 = pred[32768]{0} compare(remainder.2023, broadcast.2017), direction=NE
  and.2029 = pred[32768]{0} and(compare.2028, compare.2024)
  broadcast.2030 = s32[32768]{0} broadcast(call.2021), dimensions={}
  add.2031 = s32[32768]{0} add(remainder.2023, broadcast.2030)
  ROOT select.2032 = s32[32768]{0} select(and.2029, add.2031, remainder.2023)
}

_roll_dynamic.2033 {
  Arg_0.2034 = f64[32768,32]{1,0} parameter(0)
  concatenate.2044 = f64[32768,64]{1,0} concatenate(Arg_0.2034, Arg_0.2034), dimensions={1}
  constant.2040 = s32[] constant(32)
  broadcast.2041 = s32[32768]{0} broadcast(constant.2040), dimensions={}
  Arg_1.2035 = s32[32768]{0} parameter(1)
  constant.2042 = s32[] constant(32)
  call.2043 = s32[32768]{0} call(Arg_1.2035, constant.2042), to_apply=remainder.2013
  subtract.2045 = s32[32768]{0} subtract(broadcast.2041, call.2043)
  constant.2038 = s32[] constant(0)
  broadcast.2039 = s32[32768]{0} broadcast(constant.2038), dimensions={}
  compare.2046 = pred[32768]{0} compare(subtract.2045, broadcast.2039), direction=LT
  constant.2036 = s32[] constant(64)
  broadcast.2037 = s32[32768]{0} broadcast(constant.2036), dimensions={}
  add.2047 = s32[32768]{0} add(subtract.2045, broadcast.2037)
  select.2048 = s32[32768]{0} select(compare.2046, add.2047, subtract.2045)
  reshape.2049 = s32[32768,1]{1,0} reshape(select.2048)
  ROOT gather.2050 = f64[32768,32]{1,0} gather(concatenate.2044, reshape.2049), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2051 {
  Arg_0.2052 = pred[] parameter(0)
  Arg_1.2053 = s32[] parameter(1)
  Arg_2.2054 = s32[] parameter(2)
  ROOT select.2055 = s32[] select(Arg_0.2052, Arg_1.2053, Arg_2.2054)
}

remainder.2056 {
  Arg_0.2057 = s32[32768]{0} parameter(0)
  Arg_1.2058 = s32[] parameter(1)
  constant.2062 = s32[] constant(0)
  compare.2063 = pred[] compare(Arg_1.2058, constant.2062), direction=EQ
  constant.2061 = s32[] constant(1)
  call.2064 = s32[] call(compare.2063, constant.2061, Arg_1.2058), to_apply=_where.2051
  broadcast.2065 = s32[32768]{0} broadcast(call.2064), dimensions={}
  remainder.2066 = s32[32768]{0} remainder(Arg_0.2057, broadcast.2065)
  constant.2059 = s32[] constant(0)
  broadcast.2060 = s32[32768]{0} broadcast(constant.2059), dimensions={}
  compare.2068 = pred[32768]{0} compare(remainder.2066, broadcast.2060), direction=LT
  compare.2069 = pred[] compare(call.2064, constant.2062), direction=LT
  broadcast.2070 = pred[32768]{0} broadcast(compare.2069), dimensions={}
  compare.2071 = pred[32768]{0} compare(compare.2068, broadcast.2070), direction=NE
  compare.2067 = pred[32768]{0} compare(remainder.2066, broadcast.2060), direction=NE
  and.2072 = pred[32768]{0} and(compare.2071, compare.2067)
  broadcast.2073 = s32[32768]{0} broadcast(call.2064), dimensions={}
  add.2074 = s32[32768]{0} add(remainder.2066, broadcast.2073)
  ROOT select.2075 = s32[32768]{0} select(and.2072, add.2074, remainder.2066)
}

_roll_dynamic.2076 {
  Arg_0.2077 = f64[32768,32]{1,0} parameter(0)
  concatenate.2087 = f64[32768,64]{1,0} concatenate(Arg_0.2077, Arg_0.2077), dimensions={1}
  constant.2083 = s32[] constant(32)
  broadcast.2084 = s32[32768]{0} broadcast(constant.2083), dimensions={}
  Arg_1.2078 = s32[32768]{0} parameter(1)
  constant.2085 = s32[] constant(32)
  call.2086 = s32[32768]{0} call(Arg_1.2078, constant.2085), to_apply=remainder.2056
  subtract.2088 = s32[32768]{0} subtract(broadcast.2084, call.2086)
  constant.2081 = s32[] constant(0)
  broadcast.2082 = s32[32768]{0} broadcast(constant.2081), dimensions={}
  compare.2089 = pred[32768]{0} compare(subtract.2088, broadcast.2082), direction=LT
  constant.2079 = s32[] constant(64)
  broadcast.2080 = s32[32768]{0} broadcast(constant.2079), dimensions={}
  add.2090 = s32[32768]{0} add(subtract.2088, broadcast.2080)
  select.2091 = s32[32768]{0} select(compare.2089, add.2090, subtract.2088)
  reshape.2092 = s32[32768,1]{1,0} reshape(select.2091)
  ROOT gather.2093 = f64[32768,32]{1,0} gather(concatenate.2087, reshape.2092), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2094 {
  Arg_0.2095 = pred[] parameter(0)
  Arg_1.2096 = s32[] parameter(1)
  Arg_2.2097 = s32[] parameter(2)
  ROOT select.2098 = s32[] select(Arg_0.2095, Arg_1.2096, Arg_2.2097)
}

remainder.2099 {
  Arg_0.2100 = s32[32768]{0} parameter(0)
  Arg_1.2101 = s32[] parameter(1)
  constant.2105 = s32[] constant(0)
  compare.2106 = pred[] compare(Arg_1.2101, constant.2105), direction=EQ
  constant.2104 = s32[] constant(1)
  call.2107 = s32[] call(compare.2106, constant.2104, Arg_1.2101), to_apply=_where.2094
  broadcast.2108 = s32[32768]{0} broadcast(call.2107), dimensions={}
  remainder.2109 = s32[32768]{0} remainder(Arg_0.2100, broadcast.2108)
  constant.2102 = s32[] constant(0)
  broadcast.2103 = s32[32768]{0} broadcast(constant.2102), dimensions={}
  compare.2111 = pred[32768]{0} compare(remainder.2109, broadcast.2103), direction=LT
  compare.2112 = pred[] compare(call.2107, constant.2105), direction=LT
  broadcast.2113 = pred[32768]{0} broadcast(compare.2112), dimensions={}
  compare.2114 = pred[32768]{0} compare(compare.2111, broadcast.2113), direction=NE
  compare.2110 = pred[32768]{0} compare(remainder.2109, broadcast.2103), direction=NE
  and.2115 = pred[32768]{0} and(compare.2114, compare.2110)
  broadcast.2116 = s32[32768]{0} broadcast(call.2107), dimensions={}
  add.2117 = s32[32768]{0} add(remainder.2109, broadcast.2116)
  ROOT select.2118 = s32[32768]{0} select(and.2115, add.2117, remainder.2109)
}

_roll_dynamic.2119 {
  Arg_0.2120 = f64[32768,32]{1,0} parameter(0)
  concatenate.2130 = f64[32768,64]{1,0} concatenate(Arg_0.2120, Arg_0.2120), dimensions={1}
  constant.2126 = s32[] constant(32)
  broadcast.2127 = s32[32768]{0} broadcast(constant.2126), dimensions={}
  Arg_1.2121 = s32[32768]{0} parameter(1)
  constant.2128 = s32[] constant(32)
  call.2129 = s32[32768]{0} call(Arg_1.2121, constant.2128), to_apply=remainder.2099
  subtract.2131 = s32[32768]{0} subtract(broadcast.2127, call.2129)
  constant.2124 = s32[] constant(0)
  broadcast.2125 = s32[32768]{0} broadcast(constant.2124), dimensions={}
  compare.2132 = pred[32768]{0} compare(subtract.2131, broadcast.2125), direction=LT
  constant.2122 = s32[] constant(64)
  broadcast.2123 = s32[32768]{0} broadcast(constant.2122), dimensions={}
  add.2133 = s32[32768]{0} add(subtract.2131, broadcast.2123)
  select.2134 = s32[32768]{0} select(compare.2132, add.2133, subtract.2131)
  reshape.2135 = s32[32768,1]{1,0} reshape(select.2134)
  ROOT gather.2136 = f64[32768,32]{1,0} gather(concatenate.2130, reshape.2135), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.2137 {
  Arg_0.2138 = f64[32768,32]{1,0} parameter(0)
  Arg_1.2139 = f64[32768]{0} parameter(1)
  Arg_2.2140 = f64[] parameter(2)
  broadcast.2167 = f64[32768]{0} broadcast(Arg_2.2140), dimensions={}
  multiply.2168 = f64[32768]{0} multiply(Arg_1.2139, broadcast.2167)
  Arg_3.2141 = f64[] parameter(3)
  broadcast.2169 = f64[32768]{0} broadcast(Arg_3.2141), dimensions={}
  divide.2170 = f64[32768]{0} divide(multiply.2168, broadcast.2169)
  floor.2171 = f64[32768]{0} floor(divide.2170)
  convert.2173 = s32[32768]{0} convert(floor.2171)
  Arg_4.2142 = s32[6]{0} parameter(4)
  slice.2236 = s32[1]{0} slice(Arg_4.2142), slice={[0:1]}
  reshape.2237 = s32[] reshape(slice.2236)
  broadcast.2238 = s32[32768]{0} broadcast(reshape.2237), dimensions={}
  add.2239 = s32[32768]{0} add(convert.2173, broadcast.2238)
  call.2240 = f64[32768,32]{1,0} call(Arg_0.2138, add.2239), to_apply=_roll_dynamic.1904
  subtract.2172 = f64[32768]{0} subtract(divide.2170, floor.2171)
  constant.2165 = f64[] constant(20)
  broadcast.2166 = f64[32768]{0} broadcast(constant.2165), dimensions={}
  divide.2178 = f64[32768]{0} divide(subtract.2172, broadcast.2166)
  multiply.2174 = f64[32768]{0} multiply(subtract.2172, subtract.2172)
  constant.2163 = f64[] constant(24)
  broadcast.2164 = f64[32768]{0} broadcast(constant.2163), dimensions={}
  divide.2179 = f64[32768]{0} divide(multiply.2174, broadcast.2164)
  subtract.2180 = f64[32768]{0} subtract(divide.2178, divide.2179)
  multiply.2175 = f64[32768]{0} multiply(multiply.2174, subtract.2172)
  divide.2181 = f64[32768]{0} divide(multiply.2175, broadcast.2164)
  subtract.2182 = f64[32768]{0} subtract(subtract.2180, divide.2181)
  multiply.2176 = f64[32768]{0} multiply(multiply.2175, subtract.2172)
  divide.2183 = f64[32768]{0} divide(multiply.2176, broadcast.2164)
  add.2184 = f64[32768]{0} add(subtract.2182, divide.2183)
  multiply.2177 = f64[32768]{0} multiply(multiply.2176, subtract.2172)
  constant.2161 = f64[] constant(120)
  broadcast.2162 = f64[32768]{0} broadcast(constant.2161), dimensions={}
  divide.2185 = f64[32768]{0} divide(multiply.2177, broadcast.2162)
  subtract.2186 = f64[32768]{0} subtract(add.2184, divide.2185)
  reshape.2241 = f64[32768,1]{1,0} reshape(subtract.2186)
  broadcast.2242 = f64[32768,1]{1,0} broadcast(reshape.2241), dimensions={0,1}
  reshape.2243 = f64[32768]{0} reshape(broadcast.2242)
  broadcast.2244 = f64[32768,32]{1,0} broadcast(reshape.2243), dimensions={0}
  multiply.2245 = f64[32768,32]{1,0} multiply(call.2240, broadcast.2244)
  slice.2246 = s32[1]{0} slice(Arg_4.2142), slice={[1:2]}
  reshape.2247 = s32[] reshape(slice.2246)
  broadcast.2248 = s32[32768]{0} broadcast(reshape.2247), dimensions={}
  add.2249 = s32[32768]{0} add(convert.2173, broadcast.2248)
  call.2250 = f64[32768,32]{1,0} call(Arg_0.2138, add.2249), to_apply=_roll_dynamic.1947
  constant.2159 = f64[] constant(2)
  broadcast.2160 = f64[32768]{0} broadcast(constant.2159), dimensions={}
  divide.2187 = f64[32768]{0} divide(subtract.2172, broadcast.2160)
  negate.2188 = f64[32768]{0} negate(divide.2187)
  multiply.2189 = f64[32768]{0} multiply(multiply.2174, broadcast.2160)
  constant.2157 = f64[] constant(3)
  broadcast.2158 = f64[32768]{0} broadcast(constant.2157), dimensions={}
  divide.2190 = f64[32768]{0} divide(multiply.2189, broadcast.2158)
  add.2191 = f64[32768]{0} add(negate.2188, divide.2190)
  divide.2192 = f64[32768]{0} divide(multiply.2175, broadcast.2164)
  subtract.2193 = f64[32768]{0} subtract(add.2191, divide.2192)
  constant.2155 = f64[] constant(6)
  broadcast.2156 = f64[32768]{0} broadcast(constant.2155), dimensions={}
  divide.2194 = f64[32768]{0} divide(multiply.2176, broadcast.2156)
  subtract.2195 = f64[32768]{0} subtract(subtract.2193, divide.2194)
  divide.2196 = f64[32768]{0} divide(multiply.2177, broadcast.2164)
  add.2197 = f64[32768]{0} add(subtract.2195, divide.2196)
  reshape.2251 = f64[32768,1]{1,0} reshape(add.2197)
  broadcast.2252 = f64[32768,1]{1,0} broadcast(reshape.2251), dimensions={0,1}
  reshape.2253 = f64[32768]{0} reshape(broadcast.2252)
  broadcast.2254 = f64[32768,32]{1,0} broadcast(reshape.2253), dimensions={0}
  multiply.2255 = f64[32768,32]{1,0} multiply(call.2250, broadcast.2254)
  add.2256 = f64[32768,32]{1,0} add(multiply.2245, multiply.2255)
  slice.2257 = s32[1]{0} slice(Arg_4.2142), slice={[2:3]}
  reshape.2258 = s32[] reshape(slice.2257)
  broadcast.2259 = s32[32768]{0} broadcast(reshape.2258), dimensions={}
  add.2260 = s32[32768]{0} add(convert.2173, broadcast.2259)
  call.2261 = f64[32768,32]{1,0} call(Arg_0.2138, add.2260), to_apply=_roll_dynamic.1990
  constant.2153 = f64[] constant(1)
  broadcast.2154 = f64[32768]{0} broadcast(constant.2153), dimensions={}
  divide.2198 = f64[32768]{0} divide(subtract.2172, broadcast.2158)
  subtract.2199 = f64[32768]{0} subtract(broadcast.2154, divide.2198)
  constant.2151 = f64[] constant(5)
  broadcast.2152 = f64[32768]{0} broadcast(constant.2151), dimensions={}
  multiply.2200 = f64[32768]{0} multiply(multiply.2174, broadcast.2152)
  constant.2149 = f64[] constant(4)
  broadcast.2150 = f64[32768]{0} broadcast(constant.2149), dimensions={}
  divide.2201 = f64[32768]{0} divide(multiply.2200, broadcast.2150)
  subtract.2202 = f64[32768]{0} subtract(subtract.2199, divide.2201)
  multiply.2203 = f64[32768]{0} multiply(multiply.2175, broadcast.2152)
  constant.2147 = f64[] constant(12)
  broadcast.2148 = f64[32768]{0} broadcast(constant.2147), dimensions={}
  divide.2204 = f64[32768]{0} divide(multiply.2203, broadcast.2148)
  add.2205 = f64[32768]{0} add(subtract.2202, divide.2204)
  divide.2206 = f64[32768]{0} divide(multiply.2176, broadcast.2150)
  add.2207 = f64[32768]{0} add(add.2205, divide.2206)
  divide.2208 = f64[32768]{0} divide(multiply.2177, broadcast.2148)
  subtract.2209 = f64[32768]{0} subtract(add.2207, divide.2208)
  reshape.2262 = f64[32768,1]{1,0} reshape(subtract.2209)
  broadcast.2263 = f64[32768,1]{1,0} broadcast(reshape.2262), dimensions={0,1}
  reshape.2264 = f64[32768]{0} reshape(broadcast.2263)
  broadcast.2265 = f64[32768,32]{1,0} broadcast(reshape.2264), dimensions={0}
  multiply.2266 = f64[32768,32]{1,0} multiply(call.2261, broadcast.2265)
  add.2267 = f64[32768,32]{1,0} add(add.2256, multiply.2266)
  slice.2268 = s32[1]{0} slice(Arg_4.2142), slice={[3:4]}
  reshape.2269 = s32[] reshape(slice.2268)
  broadcast.2270 = s32[32768]{0} broadcast(reshape.2269), dimensions={}
  add.2271 = s32[32768]{0} add(convert.2173, broadcast.2270)
  call.2272 = f64[32768,32]{1,0} call(Arg_0.2138, add.2271), to_apply=_roll_dynamic.2033
  multiply.2210 = f64[32768]{0} multiply(multiply.2174, broadcast.2160)
  divide.2211 = f64[32768]{0} divide(multiply.2210, broadcast.2158)
  add.2212 = f64[32768]{0} add(subtract.2172, divide.2211)
  constant.2145 = f64[] constant(7)
  broadcast.2146 = f64[32768]{0} broadcast(constant.2145), dimensions={}
  multiply.2213 = f64[32768]{0} multiply(multiply.2175, broadcast.2146)
  divide.2214 = f64[32768]{0} divide(multiply.2213, broadcast.2148)
  subtract.2215 = f64[32768]{0} subtract(add.2212, divide.2214)
  divide.2216 = f64[32768]{0} divide(multiply.2176, broadcast.2156)
  subtract.2217 = f64[32768]{0} subtract(subtract.2215, divide.2216)
  divide.2218 = f64[32768]{0} divide(multiply.2177, broadcast.2148)
  add.2219 = f64[32768]{0} add(subtract.2217, divide.2218)
  reshape.2273 = f64[32768,1]{1,0} reshape(add.2219)
  broadcast.2274 = f64[32768,1]{1,0} broadcast(reshape.2273), dimensions={0,1}
  reshape.2275 = f64[32768]{0} reshape(broadcast.2274)
  broadcast.2276 = f64[32768,32]{1,0} broadcast(reshape.2275), dimensions={0}
  multiply.2277 = f64[32768,32]{1,0} multiply(call.2272, broadcast.2276)
  add.2278 = f64[32768,32]{1,0} add(add.2267, multiply.2277)
  slice.2279 = s32[1]{0} slice(Arg_4.2142), slice={[4:5]}
  reshape.2280 = s32[] reshape(slice.2279)
  broadcast.2281 = s32[32768]{0} broadcast(reshape.2280), dimensions={}
  add.2282 = s32[32768]{0} add(convert.2173, broadcast.2281)
  call.2283 = f64[32768,32]{1,0} call(Arg_0.2138, add.2282), to_apply=_roll_dynamic.2076
  divide.2220 = f64[32768]{0} divide(subtract.2172, broadcast.2150)
  negate.2221 = f64[32768]{0} negate(divide.2220)
  divide.2222 = f64[32768]{0} divide(multiply.2174, broadcast.2164)
  subtract.2223 = f64[32768]{0} subtract(negate.2221, divide.2222)
  multiply.2224 = f64[32768]{0} multiply(multiply.2175, broadcast.2146)
  divide.2225 = f64[32768]{0} divide(multiply.2224, broadcast.2164)
  add.2226 = f64[32768]{0} add(subtract.2223, divide.2225)
  divide.2227 = f64[32768]{0} divide(multiply.2176, broadcast.2164)
  add.2228 = f64[32768]{0} add(add.2226, divide.2227)
  divide.2229 = f64[32768]{0} divide(multiply.2177, broadcast.2164)
  subtract.2230 = f64[32768]{0} subtract(add.2228, divide.2229)
  reshape.2284 = f64[32768,1]{1,0} reshape(subtract.2230)
  broadcast.2285 = f64[32768,1]{1,0} broadcast(reshape.2284), dimensions={0,1}
  reshape.2286 = f64[32768]{0} reshape(broadcast.2285)
  broadcast.2287 = f64[32768,32]{1,0} broadcast(reshape.2286), dimensions={0}
  multiply.2288 = f64[32768,32]{1,0} multiply(call.2283, broadcast.2287)
  add.2289 = f64[32768,32]{1,0} add(add.2278, multiply.2288)
  slice.2290 = s32[1]{0} slice(Arg_4.2142), slice={[5:6]}
  reshape.2291 = s32[] reshape(slice.2290)
  broadcast.2292 = s32[32768]{0} broadcast(reshape.2291), dimensions={}
  add.2293 = s32[32768]{0} add(convert.2173, broadcast.2292)
  call.2294 = f64[32768,32]{1,0} call(Arg_0.2138, add.2293), to_apply=_roll_dynamic.2119
  constant.2143 = f64[] constant(30)
  broadcast.2144 = f64[32768]{0} broadcast(constant.2143), dimensions={}
  divide.2231 = f64[32768]{0} divide(subtract.2172, broadcast.2144)
  divide.2232 = f64[32768]{0} divide(multiply.2175, broadcast.2164)
  subtract.2233 = f64[32768]{0} subtract(divide.2231, divide.2232)
  divide.2234 = f64[32768]{0} divide(multiply.2177, broadcast.2162)
  add.2235 = f64[32768]{0} add(subtract.2233, divide.2234)
  reshape.2295 = f64[32768,1]{1,0} reshape(add.2235)
  broadcast.2296 = f64[32768,1]{1,0} broadcast(reshape.2295), dimensions={0,1}
  reshape.2297 = f64[32768]{0} reshape(broadcast.2296)
  broadcast.2298 = f64[32768,32]{1,0} broadcast(reshape.2297), dimensions={0}
  multiply.2299 = f64[32768,32]{1,0} multiply(call.2294, broadcast.2298)
  ROOT add.2300 = f64[32768,32]{1,0} add(add.2289, multiply.2299)
}

_where.2309 {
  Arg_0.2310 = pred[] parameter(0)
  Arg_1.2311 = s32[] parameter(1)
  Arg_2.2312 = s32[] parameter(2)
  ROOT select.2313 = s32[] select(Arg_0.2310, Arg_1.2311, Arg_2.2312)
}

remainder.2314 {
  Arg_0.2315 = s32[32768]{0} parameter(0)
  Arg_1.2316 = s32[] parameter(1)
  constant.2320 = s32[] constant(0)
  compare.2321 = pred[] compare(Arg_1.2316, constant.2320), direction=EQ
  constant.2319 = s32[] constant(1)
  call.2322 = s32[] call(compare.2321, constant.2319, Arg_1.2316), to_apply=_where.2309
  broadcast.2323 = s32[32768]{0} broadcast(call.2322), dimensions={}
  remainder.2324 = s32[32768]{0} remainder(Arg_0.2315, broadcast.2323)
  constant.2317 = s32[] constant(0)
  broadcast.2318 = s32[32768]{0} broadcast(constant.2317), dimensions={}
  compare.2326 = pred[32768]{0} compare(remainder.2324, broadcast.2318), direction=LT
  compare.2327 = pred[] compare(call.2322, constant.2320), direction=LT
  broadcast.2328 = pred[32768]{0} broadcast(compare.2327), dimensions={}
  compare.2329 = pred[32768]{0} compare(compare.2326, broadcast.2328), direction=NE
  compare.2325 = pred[32768]{0} compare(remainder.2324, broadcast.2318), direction=NE
  and.2330 = pred[32768]{0} and(compare.2329, compare.2325)
  broadcast.2331 = s32[32768]{0} broadcast(call.2322), dimensions={}
  add.2332 = s32[32768]{0} add(remainder.2324, broadcast.2331)
  ROOT select.2333 = s32[32768]{0} select(and.2330, add.2332, remainder.2324)
}

_roll_dynamic.2334 {
  Arg_0.2335 = f64[32768,32]{1,0} parameter(0)
  concatenate.2345 = f64[32768,64]{1,0} concatenate(Arg_0.2335, Arg_0.2335), dimensions={1}
  constant.2341 = s32[] constant(32)
  broadcast.2342 = s32[32768]{0} broadcast(constant.2341), dimensions={}
  Arg_1.2336 = s32[32768]{0} parameter(1)
  constant.2343 = s32[] constant(32)
  call.2344 = s32[32768]{0} call(Arg_1.2336, constant.2343), to_apply=remainder.2314
  subtract.2346 = s32[32768]{0} subtract(broadcast.2342, call.2344)
  constant.2339 = s32[] constant(0)
  broadcast.2340 = s32[32768]{0} broadcast(constant.2339), dimensions={}
  compare.2347 = pred[32768]{0} compare(subtract.2346, broadcast.2340), direction=LT
  constant.2337 = s32[] constant(64)
  broadcast.2338 = s32[32768]{0} broadcast(constant.2337), dimensions={}
  add.2348 = s32[32768]{0} add(subtract.2346, broadcast.2338)
  select.2349 = s32[32768]{0} select(compare.2347, add.2348, subtract.2346)
  reshape.2350 = s32[32768,1]{1,0} reshape(select.2349)
  ROOT gather.2351 = f64[32768,32]{1,0} gather(concatenate.2345, reshape.2350), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2352 {
  Arg_0.2353 = pred[] parameter(0)
  Arg_1.2354 = s32[] parameter(1)
  Arg_2.2355 = s32[] parameter(2)
  ROOT select.2356 = s32[] select(Arg_0.2353, Arg_1.2354, Arg_2.2355)
}

remainder.2357 {
  Arg_0.2358 = s32[32768]{0} parameter(0)
  Arg_1.2359 = s32[] parameter(1)
  constant.2363 = s32[] constant(0)
  compare.2364 = pred[] compare(Arg_1.2359, constant.2363), direction=EQ
  constant.2362 = s32[] constant(1)
  call.2365 = s32[] call(compare.2364, constant.2362, Arg_1.2359), to_apply=_where.2352
  broadcast.2366 = s32[32768]{0} broadcast(call.2365), dimensions={}
  remainder.2367 = s32[32768]{0} remainder(Arg_0.2358, broadcast.2366)
  constant.2360 = s32[] constant(0)
  broadcast.2361 = s32[32768]{0} broadcast(constant.2360), dimensions={}
  compare.2369 = pred[32768]{0} compare(remainder.2367, broadcast.2361), direction=LT
  compare.2370 = pred[] compare(call.2365, constant.2363), direction=LT
  broadcast.2371 = pred[32768]{0} broadcast(compare.2370), dimensions={}
  compare.2372 = pred[32768]{0} compare(compare.2369, broadcast.2371), direction=NE
  compare.2368 = pred[32768]{0} compare(remainder.2367, broadcast.2361), direction=NE
  and.2373 = pred[32768]{0} and(compare.2372, compare.2368)
  broadcast.2374 = s32[32768]{0} broadcast(call.2365), dimensions={}
  add.2375 = s32[32768]{0} add(remainder.2367, broadcast.2374)
  ROOT select.2376 = s32[32768]{0} select(and.2373, add.2375, remainder.2367)
}

_roll_dynamic.2377 {
  Arg_0.2378 = f64[32768,32]{1,0} parameter(0)
  concatenate.2388 = f64[32768,64]{1,0} concatenate(Arg_0.2378, Arg_0.2378), dimensions={1}
  constant.2384 = s32[] constant(32)
  broadcast.2385 = s32[32768]{0} broadcast(constant.2384), dimensions={}
  Arg_1.2379 = s32[32768]{0} parameter(1)
  constant.2386 = s32[] constant(32)
  call.2387 = s32[32768]{0} call(Arg_1.2379, constant.2386), to_apply=remainder.2357
  subtract.2389 = s32[32768]{0} subtract(broadcast.2385, call.2387)
  constant.2382 = s32[] constant(0)
  broadcast.2383 = s32[32768]{0} broadcast(constant.2382), dimensions={}
  compare.2390 = pred[32768]{0} compare(subtract.2389, broadcast.2383), direction=LT
  constant.2380 = s32[] constant(64)
  broadcast.2381 = s32[32768]{0} broadcast(constant.2380), dimensions={}
  add.2391 = s32[32768]{0} add(subtract.2389, broadcast.2381)
  select.2392 = s32[32768]{0} select(compare.2390, add.2391, subtract.2389)
  reshape.2393 = s32[32768,1]{1,0} reshape(select.2392)
  ROOT gather.2394 = f64[32768,32]{1,0} gather(concatenate.2388, reshape.2393), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2395 {
  Arg_0.2396 = pred[] parameter(0)
  Arg_1.2397 = s32[] parameter(1)
  Arg_2.2398 = s32[] parameter(2)
  ROOT select.2399 = s32[] select(Arg_0.2396, Arg_1.2397, Arg_2.2398)
}

remainder.2400 {
  Arg_0.2401 = s32[32768]{0} parameter(0)
  Arg_1.2402 = s32[] parameter(1)
  constant.2406 = s32[] constant(0)
  compare.2407 = pred[] compare(Arg_1.2402, constant.2406), direction=EQ
  constant.2405 = s32[] constant(1)
  call.2408 = s32[] call(compare.2407, constant.2405, Arg_1.2402), to_apply=_where.2395
  broadcast.2409 = s32[32768]{0} broadcast(call.2408), dimensions={}
  remainder.2410 = s32[32768]{0} remainder(Arg_0.2401, broadcast.2409)
  constant.2403 = s32[] constant(0)
  broadcast.2404 = s32[32768]{0} broadcast(constant.2403), dimensions={}
  compare.2412 = pred[32768]{0} compare(remainder.2410, broadcast.2404), direction=LT
  compare.2413 = pred[] compare(call.2408, constant.2406), direction=LT
  broadcast.2414 = pred[32768]{0} broadcast(compare.2413), dimensions={}
  compare.2415 = pred[32768]{0} compare(compare.2412, broadcast.2414), direction=NE
  compare.2411 = pred[32768]{0} compare(remainder.2410, broadcast.2404), direction=NE
  and.2416 = pred[32768]{0} and(compare.2415, compare.2411)
  broadcast.2417 = s32[32768]{0} broadcast(call.2408), dimensions={}
  add.2418 = s32[32768]{0} add(remainder.2410, broadcast.2417)
  ROOT select.2419 = s32[32768]{0} select(and.2416, add.2418, remainder.2410)
}

_roll_dynamic.2420 {
  Arg_0.2421 = f64[32768,32]{1,0} parameter(0)
  concatenate.2431 = f64[32768,64]{1,0} concatenate(Arg_0.2421, Arg_0.2421), dimensions={1}
  constant.2427 = s32[] constant(32)
  broadcast.2428 = s32[32768]{0} broadcast(constant.2427), dimensions={}
  Arg_1.2422 = s32[32768]{0} parameter(1)
  constant.2429 = s32[] constant(32)
  call.2430 = s32[32768]{0} call(Arg_1.2422, constant.2429), to_apply=remainder.2400
  subtract.2432 = s32[32768]{0} subtract(broadcast.2428, call.2430)
  constant.2425 = s32[] constant(0)
  broadcast.2426 = s32[32768]{0} broadcast(constant.2425), dimensions={}
  compare.2433 = pred[32768]{0} compare(subtract.2432, broadcast.2426), direction=LT
  constant.2423 = s32[] constant(64)
  broadcast.2424 = s32[32768]{0} broadcast(constant.2423), dimensions={}
  add.2434 = s32[32768]{0} add(subtract.2432, broadcast.2424)
  select.2435 = s32[32768]{0} select(compare.2433, add.2434, subtract.2432)
  reshape.2436 = s32[32768,1]{1,0} reshape(select.2435)
  ROOT gather.2437 = f64[32768,32]{1,0} gather(concatenate.2431, reshape.2436), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2438 {
  Arg_0.2439 = pred[] parameter(0)
  Arg_1.2440 = s32[] parameter(1)
  Arg_2.2441 = s32[] parameter(2)
  ROOT select.2442 = s32[] select(Arg_0.2439, Arg_1.2440, Arg_2.2441)
}

remainder.2443 {
  Arg_0.2444 = s32[32768]{0} parameter(0)
  Arg_1.2445 = s32[] parameter(1)
  constant.2449 = s32[] constant(0)
  compare.2450 = pred[] compare(Arg_1.2445, constant.2449), direction=EQ
  constant.2448 = s32[] constant(1)
  call.2451 = s32[] call(compare.2450, constant.2448, Arg_1.2445), to_apply=_where.2438
  broadcast.2452 = s32[32768]{0} broadcast(call.2451), dimensions={}
  remainder.2453 = s32[32768]{0} remainder(Arg_0.2444, broadcast.2452)
  constant.2446 = s32[] constant(0)
  broadcast.2447 = s32[32768]{0} broadcast(constant.2446), dimensions={}
  compare.2455 = pred[32768]{0} compare(remainder.2453, broadcast.2447), direction=LT
  compare.2456 = pred[] compare(call.2451, constant.2449), direction=LT
  broadcast.2457 = pred[32768]{0} broadcast(compare.2456), dimensions={}
  compare.2458 = pred[32768]{0} compare(compare.2455, broadcast.2457), direction=NE
  compare.2454 = pred[32768]{0} compare(remainder.2453, broadcast.2447), direction=NE
  and.2459 = pred[32768]{0} and(compare.2458, compare.2454)
  broadcast.2460 = s32[32768]{0} broadcast(call.2451), dimensions={}
  add.2461 = s32[32768]{0} add(remainder.2453, broadcast.2460)
  ROOT select.2462 = s32[32768]{0} select(and.2459, add.2461, remainder.2453)
}

_roll_dynamic.2463 {
  Arg_0.2464 = f64[32768,32]{1,0} parameter(0)
  concatenate.2474 = f64[32768,64]{1,0} concatenate(Arg_0.2464, Arg_0.2464), dimensions={1}
  constant.2470 = s32[] constant(32)
  broadcast.2471 = s32[32768]{0} broadcast(constant.2470), dimensions={}
  Arg_1.2465 = s32[32768]{0} parameter(1)
  constant.2472 = s32[] constant(32)
  call.2473 = s32[32768]{0} call(Arg_1.2465, constant.2472), to_apply=remainder.2443
  subtract.2475 = s32[32768]{0} subtract(broadcast.2471, call.2473)
  constant.2468 = s32[] constant(0)
  broadcast.2469 = s32[32768]{0} broadcast(constant.2468), dimensions={}
  compare.2476 = pred[32768]{0} compare(subtract.2475, broadcast.2469), direction=LT
  constant.2466 = s32[] constant(64)
  broadcast.2467 = s32[32768]{0} broadcast(constant.2466), dimensions={}
  add.2477 = s32[32768]{0} add(subtract.2475, broadcast.2467)
  select.2478 = s32[32768]{0} select(compare.2476, add.2477, subtract.2475)
  reshape.2479 = s32[32768,1]{1,0} reshape(select.2478)
  ROOT gather.2480 = f64[32768,32]{1,0} gather(concatenate.2474, reshape.2479), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2481 {
  Arg_0.2482 = pred[] parameter(0)
  Arg_1.2483 = s32[] parameter(1)
  Arg_2.2484 = s32[] parameter(2)
  ROOT select.2485 = s32[] select(Arg_0.2482, Arg_1.2483, Arg_2.2484)
}

remainder.2486 {
  Arg_0.2487 = s32[32768]{0} parameter(0)
  Arg_1.2488 = s32[] parameter(1)
  constant.2492 = s32[] constant(0)
  compare.2493 = pred[] compare(Arg_1.2488, constant.2492), direction=EQ
  constant.2491 = s32[] constant(1)
  call.2494 = s32[] call(compare.2493, constant.2491, Arg_1.2488), to_apply=_where.2481
  broadcast.2495 = s32[32768]{0} broadcast(call.2494), dimensions={}
  remainder.2496 = s32[32768]{0} remainder(Arg_0.2487, broadcast.2495)
  constant.2489 = s32[] constant(0)
  broadcast.2490 = s32[32768]{0} broadcast(constant.2489), dimensions={}
  compare.2498 = pred[32768]{0} compare(remainder.2496, broadcast.2490), direction=LT
  compare.2499 = pred[] compare(call.2494, constant.2492), direction=LT
  broadcast.2500 = pred[32768]{0} broadcast(compare.2499), dimensions={}
  compare.2501 = pred[32768]{0} compare(compare.2498, broadcast.2500), direction=NE
  compare.2497 = pred[32768]{0} compare(remainder.2496, broadcast.2490), direction=NE
  and.2502 = pred[32768]{0} and(compare.2501, compare.2497)
  broadcast.2503 = s32[32768]{0} broadcast(call.2494), dimensions={}
  add.2504 = s32[32768]{0} add(remainder.2496, broadcast.2503)
  ROOT select.2505 = s32[32768]{0} select(and.2502, add.2504, remainder.2496)
}

_roll_dynamic.2506 {
  Arg_0.2507 = f64[32768,32]{1,0} parameter(0)
  concatenate.2517 = f64[32768,64]{1,0} concatenate(Arg_0.2507, Arg_0.2507), dimensions={1}
  constant.2513 = s32[] constant(32)
  broadcast.2514 = s32[32768]{0} broadcast(constant.2513), dimensions={}
  Arg_1.2508 = s32[32768]{0} parameter(1)
  constant.2515 = s32[] constant(32)
  call.2516 = s32[32768]{0} call(Arg_1.2508, constant.2515), to_apply=remainder.2486
  subtract.2518 = s32[32768]{0} subtract(broadcast.2514, call.2516)
  constant.2511 = s32[] constant(0)
  broadcast.2512 = s32[32768]{0} broadcast(constant.2511), dimensions={}
  compare.2519 = pred[32768]{0} compare(subtract.2518, broadcast.2512), direction=LT
  constant.2509 = s32[] constant(64)
  broadcast.2510 = s32[32768]{0} broadcast(constant.2509), dimensions={}
  add.2520 = s32[32768]{0} add(subtract.2518, broadcast.2510)
  select.2521 = s32[32768]{0} select(compare.2519, add.2520, subtract.2518)
  reshape.2522 = s32[32768,1]{1,0} reshape(select.2521)
  ROOT gather.2523 = f64[32768,32]{1,0} gather(concatenate.2517, reshape.2522), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2524 {
  Arg_0.2525 = pred[] parameter(0)
  Arg_1.2526 = s32[] parameter(1)
  Arg_2.2527 = s32[] parameter(2)
  ROOT select.2528 = s32[] select(Arg_0.2525, Arg_1.2526, Arg_2.2527)
}

remainder.2529 {
  Arg_0.2530 = s32[32768]{0} parameter(0)
  Arg_1.2531 = s32[] parameter(1)
  constant.2535 = s32[] constant(0)
  compare.2536 = pred[] compare(Arg_1.2531, constant.2535), direction=EQ
  constant.2534 = s32[] constant(1)
  call.2537 = s32[] call(compare.2536, constant.2534, Arg_1.2531), to_apply=_where.2524
  broadcast.2538 = s32[32768]{0} broadcast(call.2537), dimensions={}
  remainder.2539 = s32[32768]{0} remainder(Arg_0.2530, broadcast.2538)
  constant.2532 = s32[] constant(0)
  broadcast.2533 = s32[32768]{0} broadcast(constant.2532), dimensions={}
  compare.2541 = pred[32768]{0} compare(remainder.2539, broadcast.2533), direction=LT
  compare.2542 = pred[] compare(call.2537, constant.2535), direction=LT
  broadcast.2543 = pred[32768]{0} broadcast(compare.2542), dimensions={}
  compare.2544 = pred[32768]{0} compare(compare.2541, broadcast.2543), direction=NE
  compare.2540 = pred[32768]{0} compare(remainder.2539, broadcast.2533), direction=NE
  and.2545 = pred[32768]{0} and(compare.2544, compare.2540)
  broadcast.2546 = s32[32768]{0} broadcast(call.2537), dimensions={}
  add.2547 = s32[32768]{0} add(remainder.2539, broadcast.2546)
  ROOT select.2548 = s32[32768]{0} select(and.2545, add.2547, remainder.2539)
}

_roll_dynamic.2549 {
  Arg_0.2550 = f64[32768,32]{1,0} parameter(0)
  concatenate.2560 = f64[32768,64]{1,0} concatenate(Arg_0.2550, Arg_0.2550), dimensions={1}
  constant.2556 = s32[] constant(32)
  broadcast.2557 = s32[32768]{0} broadcast(constant.2556), dimensions={}
  Arg_1.2551 = s32[32768]{0} parameter(1)
  constant.2558 = s32[] constant(32)
  call.2559 = s32[32768]{0} call(Arg_1.2551, constant.2558), to_apply=remainder.2529
  subtract.2561 = s32[32768]{0} subtract(broadcast.2557, call.2559)
  constant.2554 = s32[] constant(0)
  broadcast.2555 = s32[32768]{0} broadcast(constant.2554), dimensions={}
  compare.2562 = pred[32768]{0} compare(subtract.2561, broadcast.2555), direction=LT
  constant.2552 = s32[] constant(64)
  broadcast.2553 = s32[32768]{0} broadcast(constant.2552), dimensions={}
  add.2563 = s32[32768]{0} add(subtract.2561, broadcast.2553)
  select.2564 = s32[32768]{0} select(compare.2562, add.2563, subtract.2561)
  reshape.2565 = s32[32768,1]{1,0} reshape(select.2564)
  ROOT gather.2566 = f64[32768,32]{1,0} gather(concatenate.2560, reshape.2565), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.2567 {
  Arg_0.2568 = f64[32768,32]{1,0} parameter(0)
  Arg_1.2569 = f64[32768]{0} parameter(1)
  Arg_2.2570 = f64[] parameter(2)
  broadcast.2597 = f64[32768]{0} broadcast(Arg_2.2570), dimensions={}
  multiply.2598 = f64[32768]{0} multiply(Arg_1.2569, broadcast.2597)
  Arg_3.2571 = f64[] parameter(3)
  broadcast.2599 = f64[32768]{0} broadcast(Arg_3.2571), dimensions={}
  divide.2600 = f64[32768]{0} divide(multiply.2598, broadcast.2599)
  floor.2601 = f64[32768]{0} floor(divide.2600)
  convert.2603 = s32[32768]{0} convert(floor.2601)
  Arg_4.2572 = s32[6]{0} parameter(4)
  slice.2666 = s32[1]{0} slice(Arg_4.2572), slice={[0:1]}
  reshape.2667 = s32[] reshape(slice.2666)
  broadcast.2668 = s32[32768]{0} broadcast(reshape.2667), dimensions={}
  add.2669 = s32[32768]{0} add(convert.2603, broadcast.2668)
  call.2670 = f64[32768,32]{1,0} call(Arg_0.2568, add.2669), to_apply=_roll_dynamic.2334
  subtract.2602 = f64[32768]{0} subtract(divide.2600, floor.2601)
  constant.2595 = f64[] constant(20)
  broadcast.2596 = f64[32768]{0} broadcast(constant.2595), dimensions={}
  divide.2608 = f64[32768]{0} divide(subtract.2602, broadcast.2596)
  multiply.2604 = f64[32768]{0} multiply(subtract.2602, subtract.2602)
  constant.2593 = f64[] constant(24)
  broadcast.2594 = f64[32768]{0} broadcast(constant.2593), dimensions={}
  divide.2609 = f64[32768]{0} divide(multiply.2604, broadcast.2594)
  subtract.2610 = f64[32768]{0} subtract(divide.2608, divide.2609)
  multiply.2605 = f64[32768]{0} multiply(multiply.2604, subtract.2602)
  divide.2611 = f64[32768]{0} divide(multiply.2605, broadcast.2594)
  subtract.2612 = f64[32768]{0} subtract(subtract.2610, divide.2611)
  multiply.2606 = f64[32768]{0} multiply(multiply.2605, subtract.2602)
  divide.2613 = f64[32768]{0} divide(multiply.2606, broadcast.2594)
  add.2614 = f64[32768]{0} add(subtract.2612, divide.2613)
  multiply.2607 = f64[32768]{0} multiply(multiply.2606, subtract.2602)
  constant.2591 = f64[] constant(120)
  broadcast.2592 = f64[32768]{0} broadcast(constant.2591), dimensions={}
  divide.2615 = f64[32768]{0} divide(multiply.2607, broadcast.2592)
  subtract.2616 = f64[32768]{0} subtract(add.2614, divide.2615)
  reshape.2671 = f64[32768,1]{1,0} reshape(subtract.2616)
  broadcast.2672 = f64[32768,1]{1,0} broadcast(reshape.2671), dimensions={0,1}
  reshape.2673 = f64[32768]{0} reshape(broadcast.2672)
  broadcast.2674 = f64[32768,32]{1,0} broadcast(reshape.2673), dimensions={0}
  multiply.2675 = f64[32768,32]{1,0} multiply(call.2670, broadcast.2674)
  slice.2676 = s32[1]{0} slice(Arg_4.2572), slice={[1:2]}
  reshape.2677 = s32[] reshape(slice.2676)
  broadcast.2678 = s32[32768]{0} broadcast(reshape.2677), dimensions={}
  add.2679 = s32[32768]{0} add(convert.2603, broadcast.2678)
  call.2680 = f64[32768,32]{1,0} call(Arg_0.2568, add.2679), to_apply=_roll_dynamic.2377
  constant.2589 = f64[] constant(2)
  broadcast.2590 = f64[32768]{0} broadcast(constant.2589), dimensions={}
  divide.2617 = f64[32768]{0} divide(subtract.2602, broadcast.2590)
  negate.2618 = f64[32768]{0} negate(divide.2617)
  multiply.2619 = f64[32768]{0} multiply(multiply.2604, broadcast.2590)
  constant.2587 = f64[] constant(3)
  broadcast.2588 = f64[32768]{0} broadcast(constant.2587), dimensions={}
  divide.2620 = f64[32768]{0} divide(multiply.2619, broadcast.2588)
  add.2621 = f64[32768]{0} add(negate.2618, divide.2620)
  divide.2622 = f64[32768]{0} divide(multiply.2605, broadcast.2594)
  subtract.2623 = f64[32768]{0} subtract(add.2621, divide.2622)
  constant.2585 = f64[] constant(6)
  broadcast.2586 = f64[32768]{0} broadcast(constant.2585), dimensions={}
  divide.2624 = f64[32768]{0} divide(multiply.2606, broadcast.2586)
  subtract.2625 = f64[32768]{0} subtract(subtract.2623, divide.2624)
  divide.2626 = f64[32768]{0} divide(multiply.2607, broadcast.2594)
  add.2627 = f64[32768]{0} add(subtract.2625, divide.2626)
  reshape.2681 = f64[32768,1]{1,0} reshape(add.2627)
  broadcast.2682 = f64[32768,1]{1,0} broadcast(reshape.2681), dimensions={0,1}
  reshape.2683 = f64[32768]{0} reshape(broadcast.2682)
  broadcast.2684 = f64[32768,32]{1,0} broadcast(reshape.2683), dimensions={0}
  multiply.2685 = f64[32768,32]{1,0} multiply(call.2680, broadcast.2684)
  add.2686 = f64[32768,32]{1,0} add(multiply.2675, multiply.2685)
  slice.2687 = s32[1]{0} slice(Arg_4.2572), slice={[2:3]}
  reshape.2688 = s32[] reshape(slice.2687)
  broadcast.2689 = s32[32768]{0} broadcast(reshape.2688), dimensions={}
  add.2690 = s32[32768]{0} add(convert.2603, broadcast.2689)
  call.2691 = f64[32768,32]{1,0} call(Arg_0.2568, add.2690), to_apply=_roll_dynamic.2420
  constant.2583 = f64[] constant(1)
  broadcast.2584 = f64[32768]{0} broadcast(constant.2583), dimensions={}
  divide.2628 = f64[32768]{0} divide(subtract.2602, broadcast.2588)
  subtract.2629 = f64[32768]{0} subtract(broadcast.2584, divide.2628)
  constant.2581 = f64[] constant(5)
  broadcast.2582 = f64[32768]{0} broadcast(constant.2581), dimensions={}
  multiply.2630 = f64[32768]{0} multiply(multiply.2604, broadcast.2582)
  constant.2579 = f64[] constant(4)
  broadcast.2580 = f64[32768]{0} broadcast(constant.2579), dimensions={}
  divide.2631 = f64[32768]{0} divide(multiply.2630, broadcast.2580)
  subtract.2632 = f64[32768]{0} subtract(subtract.2629, divide.2631)
  multiply.2633 = f64[32768]{0} multiply(multiply.2605, broadcast.2582)
  constant.2577 = f64[] constant(12)
  broadcast.2578 = f64[32768]{0} broadcast(constant.2577), dimensions={}
  divide.2634 = f64[32768]{0} divide(multiply.2633, broadcast.2578)
  add.2635 = f64[32768]{0} add(subtract.2632, divide.2634)
  divide.2636 = f64[32768]{0} divide(multiply.2606, broadcast.2580)
  add.2637 = f64[32768]{0} add(add.2635, divide.2636)
  divide.2638 = f64[32768]{0} divide(multiply.2607, broadcast.2578)
  subtract.2639 = f64[32768]{0} subtract(add.2637, divide.2638)
  reshape.2692 = f64[32768,1]{1,0} reshape(subtract.2639)
  broadcast.2693 = f64[32768,1]{1,0} broadcast(reshape.2692), dimensions={0,1}
  reshape.2694 = f64[32768]{0} reshape(broadcast.2693)
  broadcast.2695 = f64[32768,32]{1,0} broadcast(reshape.2694), dimensions={0}
  multiply.2696 = f64[32768,32]{1,0} multiply(call.2691, broadcast.2695)
  add.2697 = f64[32768,32]{1,0} add(add.2686, multiply.2696)
  slice.2698 = s32[1]{0} slice(Arg_4.2572), slice={[3:4]}
  reshape.2699 = s32[] reshape(slice.2698)
  broadcast.2700 = s32[32768]{0} broadcast(reshape.2699), dimensions={}
  add.2701 = s32[32768]{0} add(convert.2603, broadcast.2700)
  call.2702 = f64[32768,32]{1,0} call(Arg_0.2568, add.2701), to_apply=_roll_dynamic.2463
  multiply.2640 = f64[32768]{0} multiply(multiply.2604, broadcast.2590)
  divide.2641 = f64[32768]{0} divide(multiply.2640, broadcast.2588)
  add.2642 = f64[32768]{0} add(subtract.2602, divide.2641)
  constant.2575 = f64[] constant(7)
  broadcast.2576 = f64[32768]{0} broadcast(constant.2575), dimensions={}
  multiply.2643 = f64[32768]{0} multiply(multiply.2605, broadcast.2576)
  divide.2644 = f64[32768]{0} divide(multiply.2643, broadcast.2578)
  subtract.2645 = f64[32768]{0} subtract(add.2642, divide.2644)
  divide.2646 = f64[32768]{0} divide(multiply.2606, broadcast.2586)
  subtract.2647 = f64[32768]{0} subtract(subtract.2645, divide.2646)
  divide.2648 = f64[32768]{0} divide(multiply.2607, broadcast.2578)
  add.2649 = f64[32768]{0} add(subtract.2647, divide.2648)
  reshape.2703 = f64[32768,1]{1,0} reshape(add.2649)
  broadcast.2704 = f64[32768,1]{1,0} broadcast(reshape.2703), dimensions={0,1}
  reshape.2705 = f64[32768]{0} reshape(broadcast.2704)
  broadcast.2706 = f64[32768,32]{1,0} broadcast(reshape.2705), dimensions={0}
  multiply.2707 = f64[32768,32]{1,0} multiply(call.2702, broadcast.2706)
  add.2708 = f64[32768,32]{1,0} add(add.2697, multiply.2707)
  slice.2709 = s32[1]{0} slice(Arg_4.2572), slice={[4:5]}
  reshape.2710 = s32[] reshape(slice.2709)
  broadcast.2711 = s32[32768]{0} broadcast(reshape.2710), dimensions={}
  add.2712 = s32[32768]{0} add(convert.2603, broadcast.2711)
  call.2713 = f64[32768,32]{1,0} call(Arg_0.2568, add.2712), to_apply=_roll_dynamic.2506
  divide.2650 = f64[32768]{0} divide(subtract.2602, broadcast.2580)
  negate.2651 = f64[32768]{0} negate(divide.2650)
  divide.2652 = f64[32768]{0} divide(multiply.2604, broadcast.2594)
  subtract.2653 = f64[32768]{0} subtract(negate.2651, divide.2652)
  multiply.2654 = f64[32768]{0} multiply(multiply.2605, broadcast.2576)
  divide.2655 = f64[32768]{0} divide(multiply.2654, broadcast.2594)
  add.2656 = f64[32768]{0} add(subtract.2653, divide.2655)
  divide.2657 = f64[32768]{0} divide(multiply.2606, broadcast.2594)
  add.2658 = f64[32768]{0} add(add.2656, divide.2657)
  divide.2659 = f64[32768]{0} divide(multiply.2607, broadcast.2594)
  subtract.2660 = f64[32768]{0} subtract(add.2658, divide.2659)
  reshape.2714 = f64[32768,1]{1,0} reshape(subtract.2660)
  broadcast.2715 = f64[32768,1]{1,0} broadcast(reshape.2714), dimensions={0,1}
  reshape.2716 = f64[32768]{0} reshape(broadcast.2715)
  broadcast.2717 = f64[32768,32]{1,0} broadcast(reshape.2716), dimensions={0}
  multiply.2718 = f64[32768,32]{1,0} multiply(call.2713, broadcast.2717)
  add.2719 = f64[32768,32]{1,0} add(add.2708, multiply.2718)
  slice.2720 = s32[1]{0} slice(Arg_4.2572), slice={[5:6]}
  reshape.2721 = s32[] reshape(slice.2720)
  broadcast.2722 = s32[32768]{0} broadcast(reshape.2721), dimensions={}
  add.2723 = s32[32768]{0} add(convert.2603, broadcast.2722)
  call.2724 = f64[32768,32]{1,0} call(Arg_0.2568, add.2723), to_apply=_roll_dynamic.2549
  constant.2573 = f64[] constant(30)
  broadcast.2574 = f64[32768]{0} broadcast(constant.2573), dimensions={}
  divide.2661 = f64[32768]{0} divide(subtract.2602, broadcast.2574)
  divide.2662 = f64[32768]{0} divide(multiply.2605, broadcast.2594)
  subtract.2663 = f64[32768]{0} subtract(divide.2661, divide.2662)
  divide.2664 = f64[32768]{0} divide(multiply.2607, broadcast.2592)
  add.2665 = f64[32768]{0} add(subtract.2663, divide.2664)
  reshape.2725 = f64[32768,1]{1,0} reshape(add.2665)
  broadcast.2726 = f64[32768,1]{1,0} broadcast(reshape.2725), dimensions={0,1}
  reshape.2727 = f64[32768]{0} reshape(broadcast.2726)
  broadcast.2728 = f64[32768,32]{1,0} broadcast(reshape.2727), dimensions={0}
  multiply.2729 = f64[32768,32]{1,0} multiply(call.2724, broadcast.2728)
  ROOT add.2730 = f64[32768,32]{1,0} add(add.2719, multiply.2729)
}

ENTRY main.2735 {
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
  call.440 = f64[32768,32]{1,0} call(reshape.13, reshape.17, constant.6, constant.5, constant.7), to_apply=advect_1d_roll_diag.276
  reshape.441 = f64[32,32,32,32]{3,2,1,0} reshape(call.440)
  transpose.442 = f64[32,32,32,32]{0,2,1,3} transpose(reshape.441), dimensions={3,1,2,0}
  reshape.443 = f64[32768,32]{1,0} reshape(transpose.442)
  constant.2 = f64[1,1,32]{2,1,0} constant({...})
  broadcast.444 = f64[1,1,32]{2,1,0} broadcast(constant.2), dimensions={0,1,2}
  reshape.445 = f64[32]{0} reshape(broadcast.444)
  broadcast.446 = f64[32,32,32]{2,1,0} broadcast(reshape.445), dimensions={2}
  reshape.447 = f64[32768]{0} reshape(broadcast.446)
  call.870 = f64[32768,32]{1,0} call(reshape.443, reshape.447, constant.6, constant.5, constant.7), to_apply=advect_1d_roll_diag.706
  reshape.871 = f64[32,32,32,32]{3,2,1,0} reshape(call.870)
  transpose.934 = f64[32,32,32,32]{1,2,3,0} transpose(reshape.871), dimensions={0,3,2,1}
  reshape.935 = f64[32768,32]{1,0} reshape(transpose.934)
  transpose.872 = f64[32,32,32,32]{1,3,2,0} transpose(reshape.871), dimensions={0,3,1,2}
  constant.8 = f64[32,1]{1,0} constant({...})
  constant.9 = f64[1,17]{1,0} constant({...})
  constant.10 = f64[32,17]{1,0} constant({...})
  constant.4 = f64[] constant(0.32258064516129031)
  call.928 = (f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) call(transpose.872, constant.8, constant.9, constant.10, constant.4, constant.4), to_apply=solve_poisson.889
  get-tuple-element.929 = f64[32,32]{1,0} get-tuple-element(call.928), index=0
  reshape.933 = f64[32,32,1]{2,1,0} reshape(get-tuple-element.929)
  broadcast.936 = f64[32,32,1]{2,1,0} broadcast(reshape.933), dimensions={0,1,2}
  reshape.937 = f64[32,32]{1,0} reshape(broadcast.936)
  broadcast.938 = f64[32,32,32]{2,1,0} broadcast(reshape.937), dimensions={0,1}
  reshape.939 = f64[32768]{0} reshape(broadcast.938)
  constant.3 = f64[] constant(0.05)
  call.1401 = f64[32768,32]{1,0} call(reshape.935, reshape.939, constant.3, constant.4, constant.7), to_apply=advect_1d_roll_diag_1.1334
  reshape.1402 = f64[32,32,32,32]{3,2,1,0} reshape(call.1401)
  transpose.1403 = f64[32,32,32,32]{2,3,1,0} transpose(reshape.1402), dimensions={0,1,3,2}
  reshape.1405 = f64[32768,32]{1,0} reshape(transpose.1403)
  get-tuple-element.930 = f64[32,32]{1,0} get-tuple-element(call.928), index=1
  reshape.1404 = f64[32,32,1]{2,1,0} reshape(get-tuple-element.930)
  broadcast.1406 = f64[32,32,1]{2,1,0} broadcast(reshape.1404), dimensions={0,1,2}
  reshape.1407 = f64[32,32]{1,0} reshape(broadcast.1406)
  broadcast.1408 = f64[32,32,32]{2,1,0} broadcast(reshape.1407), dimensions={0,1}
  reshape.1409 = f64[32768]{0} reshape(broadcast.1408)
  call.1871 = f64[32768,32]{1,0} call(reshape.1405, reshape.1409, constant.3, constant.4, constant.7), to_apply=advect_1d_roll_diag_1.1804
  reshape.1872 = f64[32,32,32,32]{3,2,1,0} reshape(call.1871)
  transpose.1873 = f64[32,32,32,32]{2,1,3,0} transpose(reshape.1872), dimensions={0,2,3,1}
  reshape.1874 = f64[32768,32]{1,0} reshape(transpose.1873)
  broadcast.1875 = f64[1,1,32]{2,1,0} broadcast(constant.2), dimensions={0,1,2}
  reshape.1876 = f64[32]{0} reshape(broadcast.1875)
  broadcast.1877 = f64[32,32,32]{2,1,0} broadcast(reshape.1876), dimensions={2}
  reshape.1878 = f64[32768]{0} reshape(broadcast.1877)
  call.2301 = f64[32768,32]{1,0} call(reshape.1874, reshape.1878, constant.6, constant.5, constant.7), to_apply=advect_1d_roll_diag.2137
  reshape.2302 = f64[32,32,32,32]{3,2,1,0} reshape(call.2301)
  transpose.2303 = f64[32,32,32,32]{0,2,1,3} transpose(reshape.2302), dimensions={3,1,2,0}
  reshape.2304 = f64[32768,32]{1,0} reshape(transpose.2303)
  broadcast.2305 = f64[1,32,1]{2,1,0} broadcast(constant.11), dimensions={0,1,2}
  reshape.2306 = f64[32]{0} reshape(broadcast.2305)
  broadcast.2307 = f64[32,32,32]{2,1,0} broadcast(reshape.2306), dimensions={1}
  reshape.2308 = f64[32768]{0} reshape(broadcast.2307)
  call.2731 = f64[32768,32]{1,0} call(reshape.2304, reshape.2308, constant.6, constant.5, constant.7), to_apply=advect_1d_roll_diag.2567
  reshape.2732 = f64[32,32,32,32]{3,2,1,0} reshape(call.2731)
  transpose.2733 = f64[32,32,32,32]{0,3,2,1} transpose(reshape.2732), dimensions={3,0,1,2}
  get-tuple-element.931 = f64[32,32]{1,0} get-tuple-element(call.928), index=2
  get-tuple-element.932 = f64[32,32]{1,0} get-tuple-element(call.928), index=3
  ROOT tuple.2734 = (f64[32,32,32,32]{0,3,2,1}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(transpose.2733, get-tuple-element.931, get-tuple-element.932)
}

