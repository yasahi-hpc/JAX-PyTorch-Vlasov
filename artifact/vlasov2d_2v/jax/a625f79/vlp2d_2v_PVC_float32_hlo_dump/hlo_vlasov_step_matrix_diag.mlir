HloModule jit__lambda_, entry_computation_layout={(f32[32,32,32,32]{3,2,1,0})->(f32[32,32,32,32]{0,3,2,1}, f32[32,32]{1,0}, f32[32,32]{1,0})}

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
  Arg_0.44 = f32[32768,32]{1,0} parameter(0)
  concatenate.54 = f32[32768,64]{1,0} concatenate(Arg_0.44, Arg_0.44), dimensions={1}
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
  ROOT gather.60 = f32[32768,32]{1,0} gather(concatenate.54, reshape.59), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.87 = f32[32768,32]{1,0} parameter(0)
  concatenate.97 = f32[32768,64]{1,0} concatenate(Arg_0.87, Arg_0.87), dimensions={1}
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
  ROOT gather.103 = f32[32768,32]{1,0} gather(concatenate.97, reshape.102), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.130 = f32[32768,32]{1,0} parameter(0)
  concatenate.140 = f32[32768,64]{1,0} concatenate(Arg_0.130, Arg_0.130), dimensions={1}
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
  ROOT gather.146 = f32[32768,32]{1,0} gather(concatenate.140, reshape.145), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.173 = f32[32768,32]{1,0} parameter(0)
  concatenate.183 = f32[32768,64]{1,0} concatenate(Arg_0.173, Arg_0.173), dimensions={1}
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
  ROOT gather.189 = f32[32768,32]{1,0} gather(concatenate.183, reshape.188), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.216 = f32[32768,32]{1,0} parameter(0)
  concatenate.226 = f32[32768,64]{1,0} concatenate(Arg_0.216, Arg_0.216), dimensions={1}
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
  ROOT gather.232 = f32[32768,32]{1,0} gather(concatenate.226, reshape.231), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.259 = f32[32768,32]{1,0} parameter(0)
  concatenate.269 = f32[32768,64]{1,0} concatenate(Arg_0.259, Arg_0.259), dimensions={1}
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
  ROOT gather.275 = f32[32768,32]{1,0} gather(concatenate.269, reshape.274), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.276 {
  Arg_0.277 = f32[32768,32]{1,0} parameter(0)
  Arg_1.278 = f32[32768]{0} parameter(1)
  Arg_2.279 = f32[] parameter(2)
  broadcast.306 = f32[32768]{0} broadcast(Arg_2.279), dimensions={}
  multiply.307 = f32[32768]{0} multiply(Arg_1.278, broadcast.306)
  Arg_3.280 = f32[] parameter(3)
  broadcast.308 = f32[32768]{0} broadcast(Arg_3.280), dimensions={}
  divide.309 = f32[32768]{0} divide(multiply.307, broadcast.308)
  floor.310 = f32[32768]{0} floor(divide.309)
  convert.312 = s32[32768]{0} convert(floor.310)
  Arg_4.281 = s32[6]{0} parameter(4)
  slice.375 = s32[1]{0} slice(Arg_4.281), slice={[0:1]}
  reshape.376 = s32[] reshape(slice.375)
  broadcast.377 = s32[32768]{0} broadcast(reshape.376), dimensions={}
  add.378 = s32[32768]{0} add(convert.312, broadcast.377)
  call.379 = f32[32768,32]{1,0} call(Arg_0.277, add.378), to_apply=_roll_dynamic.43
  subtract.311 = f32[32768]{0} subtract(divide.309, floor.310)
  constant.304 = f32[] constant(20)
  broadcast.305 = f32[32768]{0} broadcast(constant.304), dimensions={}
  divide.317 = f32[32768]{0} divide(subtract.311, broadcast.305)
  multiply.313 = f32[32768]{0} multiply(subtract.311, subtract.311)
  constant.302 = f32[] constant(24)
  broadcast.303 = f32[32768]{0} broadcast(constant.302), dimensions={}
  divide.318 = f32[32768]{0} divide(multiply.313, broadcast.303)
  subtract.319 = f32[32768]{0} subtract(divide.317, divide.318)
  multiply.314 = f32[32768]{0} multiply(multiply.313, subtract.311)
  divide.320 = f32[32768]{0} divide(multiply.314, broadcast.303)
  subtract.321 = f32[32768]{0} subtract(subtract.319, divide.320)
  multiply.315 = f32[32768]{0} multiply(multiply.314, subtract.311)
  divide.322 = f32[32768]{0} divide(multiply.315, broadcast.303)
  add.323 = f32[32768]{0} add(subtract.321, divide.322)
  multiply.316 = f32[32768]{0} multiply(multiply.315, subtract.311)
  constant.300 = f32[] constant(120)
  broadcast.301 = f32[32768]{0} broadcast(constant.300), dimensions={}
  divide.324 = f32[32768]{0} divide(multiply.316, broadcast.301)
  subtract.325 = f32[32768]{0} subtract(add.323, divide.324)
  reshape.380 = f32[32768,1]{1,0} reshape(subtract.325)
  broadcast.381 = f32[32768,1]{1,0} broadcast(reshape.380), dimensions={0,1}
  reshape.382 = f32[32768]{0} reshape(broadcast.381)
  broadcast.383 = f32[32768,32]{1,0} broadcast(reshape.382), dimensions={0}
  multiply.384 = f32[32768,32]{1,0} multiply(call.379, broadcast.383)
  slice.385 = s32[1]{0} slice(Arg_4.281), slice={[1:2]}
  reshape.386 = s32[] reshape(slice.385)
  broadcast.387 = s32[32768]{0} broadcast(reshape.386), dimensions={}
  add.388 = s32[32768]{0} add(convert.312, broadcast.387)
  call.389 = f32[32768,32]{1,0} call(Arg_0.277, add.388), to_apply=_roll_dynamic.86
  constant.298 = f32[] constant(2)
  broadcast.299 = f32[32768]{0} broadcast(constant.298), dimensions={}
  divide.326 = f32[32768]{0} divide(subtract.311, broadcast.299)
  negate.327 = f32[32768]{0} negate(divide.326)
  multiply.328 = f32[32768]{0} multiply(multiply.313, broadcast.299)
  constant.296 = f32[] constant(3)
  broadcast.297 = f32[32768]{0} broadcast(constant.296), dimensions={}
  divide.329 = f32[32768]{0} divide(multiply.328, broadcast.297)
  add.330 = f32[32768]{0} add(negate.327, divide.329)
  divide.331 = f32[32768]{0} divide(multiply.314, broadcast.303)
  subtract.332 = f32[32768]{0} subtract(add.330, divide.331)
  constant.294 = f32[] constant(6)
  broadcast.295 = f32[32768]{0} broadcast(constant.294), dimensions={}
  divide.333 = f32[32768]{0} divide(multiply.315, broadcast.295)
  subtract.334 = f32[32768]{0} subtract(subtract.332, divide.333)
  divide.335 = f32[32768]{0} divide(multiply.316, broadcast.303)
  add.336 = f32[32768]{0} add(subtract.334, divide.335)
  reshape.390 = f32[32768,1]{1,0} reshape(add.336)
  broadcast.391 = f32[32768,1]{1,0} broadcast(reshape.390), dimensions={0,1}
  reshape.392 = f32[32768]{0} reshape(broadcast.391)
  broadcast.393 = f32[32768,32]{1,0} broadcast(reshape.392), dimensions={0}
  multiply.394 = f32[32768,32]{1,0} multiply(call.389, broadcast.393)
  add.395 = f32[32768,32]{1,0} add(multiply.384, multiply.394)
  slice.396 = s32[1]{0} slice(Arg_4.281), slice={[2:3]}
  reshape.397 = s32[] reshape(slice.396)
  broadcast.398 = s32[32768]{0} broadcast(reshape.397), dimensions={}
  add.399 = s32[32768]{0} add(convert.312, broadcast.398)
  call.400 = f32[32768,32]{1,0} call(Arg_0.277, add.399), to_apply=_roll_dynamic.129
  constant.292 = f32[] constant(1)
  broadcast.293 = f32[32768]{0} broadcast(constant.292), dimensions={}
  divide.337 = f32[32768]{0} divide(subtract.311, broadcast.297)
  subtract.338 = f32[32768]{0} subtract(broadcast.293, divide.337)
  constant.290 = f32[] constant(5)
  broadcast.291 = f32[32768]{0} broadcast(constant.290), dimensions={}
  multiply.339 = f32[32768]{0} multiply(multiply.313, broadcast.291)
  constant.288 = f32[] constant(4)
  broadcast.289 = f32[32768]{0} broadcast(constant.288), dimensions={}
  divide.340 = f32[32768]{0} divide(multiply.339, broadcast.289)
  subtract.341 = f32[32768]{0} subtract(subtract.338, divide.340)
  multiply.342 = f32[32768]{0} multiply(multiply.314, broadcast.291)
  constant.286 = f32[] constant(12)
  broadcast.287 = f32[32768]{0} broadcast(constant.286), dimensions={}
  divide.343 = f32[32768]{0} divide(multiply.342, broadcast.287)
  add.344 = f32[32768]{0} add(subtract.341, divide.343)
  divide.345 = f32[32768]{0} divide(multiply.315, broadcast.289)
  add.346 = f32[32768]{0} add(add.344, divide.345)
  divide.347 = f32[32768]{0} divide(multiply.316, broadcast.287)
  subtract.348 = f32[32768]{0} subtract(add.346, divide.347)
  reshape.401 = f32[32768,1]{1,0} reshape(subtract.348)
  broadcast.402 = f32[32768,1]{1,0} broadcast(reshape.401), dimensions={0,1}
  reshape.403 = f32[32768]{0} reshape(broadcast.402)
  broadcast.404 = f32[32768,32]{1,0} broadcast(reshape.403), dimensions={0}
  multiply.405 = f32[32768,32]{1,0} multiply(call.400, broadcast.404)
  add.406 = f32[32768,32]{1,0} add(add.395, multiply.405)
  slice.407 = s32[1]{0} slice(Arg_4.281), slice={[3:4]}
  reshape.408 = s32[] reshape(slice.407)
  broadcast.409 = s32[32768]{0} broadcast(reshape.408), dimensions={}
  add.410 = s32[32768]{0} add(convert.312, broadcast.409)
  call.411 = f32[32768,32]{1,0} call(Arg_0.277, add.410), to_apply=_roll_dynamic.172
  multiply.349 = f32[32768]{0} multiply(multiply.313, broadcast.299)
  divide.350 = f32[32768]{0} divide(multiply.349, broadcast.297)
  add.351 = f32[32768]{0} add(subtract.311, divide.350)
  constant.284 = f32[] constant(7)
  broadcast.285 = f32[32768]{0} broadcast(constant.284), dimensions={}
  multiply.352 = f32[32768]{0} multiply(multiply.314, broadcast.285)
  divide.353 = f32[32768]{0} divide(multiply.352, broadcast.287)
  subtract.354 = f32[32768]{0} subtract(add.351, divide.353)
  divide.355 = f32[32768]{0} divide(multiply.315, broadcast.295)
  subtract.356 = f32[32768]{0} subtract(subtract.354, divide.355)
  divide.357 = f32[32768]{0} divide(multiply.316, broadcast.287)
  add.358 = f32[32768]{0} add(subtract.356, divide.357)
  reshape.412 = f32[32768,1]{1,0} reshape(add.358)
  broadcast.413 = f32[32768,1]{1,0} broadcast(reshape.412), dimensions={0,1}
  reshape.414 = f32[32768]{0} reshape(broadcast.413)
  broadcast.415 = f32[32768,32]{1,0} broadcast(reshape.414), dimensions={0}
  multiply.416 = f32[32768,32]{1,0} multiply(call.411, broadcast.415)
  add.417 = f32[32768,32]{1,0} add(add.406, multiply.416)
  slice.418 = s32[1]{0} slice(Arg_4.281), slice={[4:5]}
  reshape.419 = s32[] reshape(slice.418)
  broadcast.420 = s32[32768]{0} broadcast(reshape.419), dimensions={}
  add.421 = s32[32768]{0} add(convert.312, broadcast.420)
  call.422 = f32[32768,32]{1,0} call(Arg_0.277, add.421), to_apply=_roll_dynamic.215
  divide.359 = f32[32768]{0} divide(subtract.311, broadcast.289)
  negate.360 = f32[32768]{0} negate(divide.359)
  divide.361 = f32[32768]{0} divide(multiply.313, broadcast.303)
  subtract.362 = f32[32768]{0} subtract(negate.360, divide.361)
  multiply.363 = f32[32768]{0} multiply(multiply.314, broadcast.285)
  divide.364 = f32[32768]{0} divide(multiply.363, broadcast.303)
  add.365 = f32[32768]{0} add(subtract.362, divide.364)
  divide.366 = f32[32768]{0} divide(multiply.315, broadcast.303)
  add.367 = f32[32768]{0} add(add.365, divide.366)
  divide.368 = f32[32768]{0} divide(multiply.316, broadcast.303)
  subtract.369 = f32[32768]{0} subtract(add.367, divide.368)
  reshape.423 = f32[32768,1]{1,0} reshape(subtract.369)
  broadcast.424 = f32[32768,1]{1,0} broadcast(reshape.423), dimensions={0,1}
  reshape.425 = f32[32768]{0} reshape(broadcast.424)
  broadcast.426 = f32[32768,32]{1,0} broadcast(reshape.425), dimensions={0}
  multiply.427 = f32[32768,32]{1,0} multiply(call.422, broadcast.426)
  add.428 = f32[32768,32]{1,0} add(add.417, multiply.427)
  slice.429 = s32[1]{0} slice(Arg_4.281), slice={[5:6]}
  reshape.430 = s32[] reshape(slice.429)
  broadcast.431 = s32[32768]{0} broadcast(reshape.430), dimensions={}
  add.432 = s32[32768]{0} add(convert.312, broadcast.431)
  call.433 = f32[32768,32]{1,0} call(Arg_0.277, add.432), to_apply=_roll_dynamic.258
  constant.282 = f32[] constant(30)
  broadcast.283 = f32[32768]{0} broadcast(constant.282), dimensions={}
  divide.370 = f32[32768]{0} divide(subtract.311, broadcast.283)
  divide.371 = f32[32768]{0} divide(multiply.314, broadcast.303)
  subtract.372 = f32[32768]{0} subtract(divide.370, divide.371)
  divide.373 = f32[32768]{0} divide(multiply.316, broadcast.301)
  add.374 = f32[32768]{0} add(subtract.372, divide.373)
  reshape.434 = f32[32768,1]{1,0} reshape(add.374)
  broadcast.435 = f32[32768,1]{1,0} broadcast(reshape.434), dimensions={0,1}
  reshape.436 = f32[32768]{0} reshape(broadcast.435)
  broadcast.437 = f32[32768,32]{1,0} broadcast(reshape.436), dimensions={0}
  multiply.438 = f32[32768,32]{1,0} multiply(call.433, broadcast.437)
  ROOT add.439 = f32[32768,32]{1,0} add(add.428, multiply.438)
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
  Arg_0.474 = f32[32768,32]{1,0} parameter(0)
  concatenate.484 = f32[32768,64]{1,0} concatenate(Arg_0.474, Arg_0.474), dimensions={1}
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
  ROOT gather.490 = f32[32768,32]{1,0} gather(concatenate.484, reshape.489), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.517 = f32[32768,32]{1,0} parameter(0)
  concatenate.527 = f32[32768,64]{1,0} concatenate(Arg_0.517, Arg_0.517), dimensions={1}
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
  ROOT gather.533 = f32[32768,32]{1,0} gather(concatenate.527, reshape.532), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.560 = f32[32768,32]{1,0} parameter(0)
  concatenate.570 = f32[32768,64]{1,0} concatenate(Arg_0.560, Arg_0.560), dimensions={1}
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
  ROOT gather.576 = f32[32768,32]{1,0} gather(concatenate.570, reshape.575), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.603 = f32[32768,32]{1,0} parameter(0)
  concatenate.613 = f32[32768,64]{1,0} concatenate(Arg_0.603, Arg_0.603), dimensions={1}
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
  ROOT gather.619 = f32[32768,32]{1,0} gather(concatenate.613, reshape.618), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.646 = f32[32768,32]{1,0} parameter(0)
  concatenate.656 = f32[32768,64]{1,0} concatenate(Arg_0.646, Arg_0.646), dimensions={1}
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
  ROOT gather.662 = f32[32768,32]{1,0} gather(concatenate.656, reshape.661), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.689 = f32[32768,32]{1,0} parameter(0)
  concatenate.699 = f32[32768,64]{1,0} concatenate(Arg_0.689, Arg_0.689), dimensions={1}
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
  ROOT gather.705 = f32[32768,32]{1,0} gather(concatenate.699, reshape.704), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.706 {
  Arg_0.707 = f32[32768,32]{1,0} parameter(0)
  Arg_1.708 = f32[32768]{0} parameter(1)
  Arg_2.709 = f32[] parameter(2)
  broadcast.736 = f32[32768]{0} broadcast(Arg_2.709), dimensions={}
  multiply.737 = f32[32768]{0} multiply(Arg_1.708, broadcast.736)
  Arg_3.710 = f32[] parameter(3)
  broadcast.738 = f32[32768]{0} broadcast(Arg_3.710), dimensions={}
  divide.739 = f32[32768]{0} divide(multiply.737, broadcast.738)
  floor.740 = f32[32768]{0} floor(divide.739)
  convert.742 = s32[32768]{0} convert(floor.740)
  Arg_4.711 = s32[6]{0} parameter(4)
  slice.805 = s32[1]{0} slice(Arg_4.711), slice={[0:1]}
  reshape.806 = s32[] reshape(slice.805)
  broadcast.807 = s32[32768]{0} broadcast(reshape.806), dimensions={}
  add.808 = s32[32768]{0} add(convert.742, broadcast.807)
  call.809 = f32[32768,32]{1,0} call(Arg_0.707, add.808), to_apply=_roll_dynamic.473
  subtract.741 = f32[32768]{0} subtract(divide.739, floor.740)
  constant.734 = f32[] constant(20)
  broadcast.735 = f32[32768]{0} broadcast(constant.734), dimensions={}
  divide.747 = f32[32768]{0} divide(subtract.741, broadcast.735)
  multiply.743 = f32[32768]{0} multiply(subtract.741, subtract.741)
  constant.732 = f32[] constant(24)
  broadcast.733 = f32[32768]{0} broadcast(constant.732), dimensions={}
  divide.748 = f32[32768]{0} divide(multiply.743, broadcast.733)
  subtract.749 = f32[32768]{0} subtract(divide.747, divide.748)
  multiply.744 = f32[32768]{0} multiply(multiply.743, subtract.741)
  divide.750 = f32[32768]{0} divide(multiply.744, broadcast.733)
  subtract.751 = f32[32768]{0} subtract(subtract.749, divide.750)
  multiply.745 = f32[32768]{0} multiply(multiply.744, subtract.741)
  divide.752 = f32[32768]{0} divide(multiply.745, broadcast.733)
  add.753 = f32[32768]{0} add(subtract.751, divide.752)
  multiply.746 = f32[32768]{0} multiply(multiply.745, subtract.741)
  constant.730 = f32[] constant(120)
  broadcast.731 = f32[32768]{0} broadcast(constant.730), dimensions={}
  divide.754 = f32[32768]{0} divide(multiply.746, broadcast.731)
  subtract.755 = f32[32768]{0} subtract(add.753, divide.754)
  reshape.810 = f32[32768,1]{1,0} reshape(subtract.755)
  broadcast.811 = f32[32768,1]{1,0} broadcast(reshape.810), dimensions={0,1}
  reshape.812 = f32[32768]{0} reshape(broadcast.811)
  broadcast.813 = f32[32768,32]{1,0} broadcast(reshape.812), dimensions={0}
  multiply.814 = f32[32768,32]{1,0} multiply(call.809, broadcast.813)
  slice.815 = s32[1]{0} slice(Arg_4.711), slice={[1:2]}
  reshape.816 = s32[] reshape(slice.815)
  broadcast.817 = s32[32768]{0} broadcast(reshape.816), dimensions={}
  add.818 = s32[32768]{0} add(convert.742, broadcast.817)
  call.819 = f32[32768,32]{1,0} call(Arg_0.707, add.818), to_apply=_roll_dynamic.516
  constant.728 = f32[] constant(2)
  broadcast.729 = f32[32768]{0} broadcast(constant.728), dimensions={}
  divide.756 = f32[32768]{0} divide(subtract.741, broadcast.729)
  negate.757 = f32[32768]{0} negate(divide.756)
  multiply.758 = f32[32768]{0} multiply(multiply.743, broadcast.729)
  constant.726 = f32[] constant(3)
  broadcast.727 = f32[32768]{0} broadcast(constant.726), dimensions={}
  divide.759 = f32[32768]{0} divide(multiply.758, broadcast.727)
  add.760 = f32[32768]{0} add(negate.757, divide.759)
  divide.761 = f32[32768]{0} divide(multiply.744, broadcast.733)
  subtract.762 = f32[32768]{0} subtract(add.760, divide.761)
  constant.724 = f32[] constant(6)
  broadcast.725 = f32[32768]{0} broadcast(constant.724), dimensions={}
  divide.763 = f32[32768]{0} divide(multiply.745, broadcast.725)
  subtract.764 = f32[32768]{0} subtract(subtract.762, divide.763)
  divide.765 = f32[32768]{0} divide(multiply.746, broadcast.733)
  add.766 = f32[32768]{0} add(subtract.764, divide.765)
  reshape.820 = f32[32768,1]{1,0} reshape(add.766)
  broadcast.821 = f32[32768,1]{1,0} broadcast(reshape.820), dimensions={0,1}
  reshape.822 = f32[32768]{0} reshape(broadcast.821)
  broadcast.823 = f32[32768,32]{1,0} broadcast(reshape.822), dimensions={0}
  multiply.824 = f32[32768,32]{1,0} multiply(call.819, broadcast.823)
  add.825 = f32[32768,32]{1,0} add(multiply.814, multiply.824)
  slice.826 = s32[1]{0} slice(Arg_4.711), slice={[2:3]}
  reshape.827 = s32[] reshape(slice.826)
  broadcast.828 = s32[32768]{0} broadcast(reshape.827), dimensions={}
  add.829 = s32[32768]{0} add(convert.742, broadcast.828)
  call.830 = f32[32768,32]{1,0} call(Arg_0.707, add.829), to_apply=_roll_dynamic.559
  constant.722 = f32[] constant(1)
  broadcast.723 = f32[32768]{0} broadcast(constant.722), dimensions={}
  divide.767 = f32[32768]{0} divide(subtract.741, broadcast.727)
  subtract.768 = f32[32768]{0} subtract(broadcast.723, divide.767)
  constant.720 = f32[] constant(5)
  broadcast.721 = f32[32768]{0} broadcast(constant.720), dimensions={}
  multiply.769 = f32[32768]{0} multiply(multiply.743, broadcast.721)
  constant.718 = f32[] constant(4)
  broadcast.719 = f32[32768]{0} broadcast(constant.718), dimensions={}
  divide.770 = f32[32768]{0} divide(multiply.769, broadcast.719)
  subtract.771 = f32[32768]{0} subtract(subtract.768, divide.770)
  multiply.772 = f32[32768]{0} multiply(multiply.744, broadcast.721)
  constant.716 = f32[] constant(12)
  broadcast.717 = f32[32768]{0} broadcast(constant.716), dimensions={}
  divide.773 = f32[32768]{0} divide(multiply.772, broadcast.717)
  add.774 = f32[32768]{0} add(subtract.771, divide.773)
  divide.775 = f32[32768]{0} divide(multiply.745, broadcast.719)
  add.776 = f32[32768]{0} add(add.774, divide.775)
  divide.777 = f32[32768]{0} divide(multiply.746, broadcast.717)
  subtract.778 = f32[32768]{0} subtract(add.776, divide.777)
  reshape.831 = f32[32768,1]{1,0} reshape(subtract.778)
  broadcast.832 = f32[32768,1]{1,0} broadcast(reshape.831), dimensions={0,1}
  reshape.833 = f32[32768]{0} reshape(broadcast.832)
  broadcast.834 = f32[32768,32]{1,0} broadcast(reshape.833), dimensions={0}
  multiply.835 = f32[32768,32]{1,0} multiply(call.830, broadcast.834)
  add.836 = f32[32768,32]{1,0} add(add.825, multiply.835)
  slice.837 = s32[1]{0} slice(Arg_4.711), slice={[3:4]}
  reshape.838 = s32[] reshape(slice.837)
  broadcast.839 = s32[32768]{0} broadcast(reshape.838), dimensions={}
  add.840 = s32[32768]{0} add(convert.742, broadcast.839)
  call.841 = f32[32768,32]{1,0} call(Arg_0.707, add.840), to_apply=_roll_dynamic.602
  multiply.779 = f32[32768]{0} multiply(multiply.743, broadcast.729)
  divide.780 = f32[32768]{0} divide(multiply.779, broadcast.727)
  add.781 = f32[32768]{0} add(subtract.741, divide.780)
  constant.714 = f32[] constant(7)
  broadcast.715 = f32[32768]{0} broadcast(constant.714), dimensions={}
  multiply.782 = f32[32768]{0} multiply(multiply.744, broadcast.715)
  divide.783 = f32[32768]{0} divide(multiply.782, broadcast.717)
  subtract.784 = f32[32768]{0} subtract(add.781, divide.783)
  divide.785 = f32[32768]{0} divide(multiply.745, broadcast.725)
  subtract.786 = f32[32768]{0} subtract(subtract.784, divide.785)
  divide.787 = f32[32768]{0} divide(multiply.746, broadcast.717)
  add.788 = f32[32768]{0} add(subtract.786, divide.787)
  reshape.842 = f32[32768,1]{1,0} reshape(add.788)
  broadcast.843 = f32[32768,1]{1,0} broadcast(reshape.842), dimensions={0,1}
  reshape.844 = f32[32768]{0} reshape(broadcast.843)
  broadcast.845 = f32[32768,32]{1,0} broadcast(reshape.844), dimensions={0}
  multiply.846 = f32[32768,32]{1,0} multiply(call.841, broadcast.845)
  add.847 = f32[32768,32]{1,0} add(add.836, multiply.846)
  slice.848 = s32[1]{0} slice(Arg_4.711), slice={[4:5]}
  reshape.849 = s32[] reshape(slice.848)
  broadcast.850 = s32[32768]{0} broadcast(reshape.849), dimensions={}
  add.851 = s32[32768]{0} add(convert.742, broadcast.850)
  call.852 = f32[32768,32]{1,0} call(Arg_0.707, add.851), to_apply=_roll_dynamic.645
  divide.789 = f32[32768]{0} divide(subtract.741, broadcast.719)
  negate.790 = f32[32768]{0} negate(divide.789)
  divide.791 = f32[32768]{0} divide(multiply.743, broadcast.733)
  subtract.792 = f32[32768]{0} subtract(negate.790, divide.791)
  multiply.793 = f32[32768]{0} multiply(multiply.744, broadcast.715)
  divide.794 = f32[32768]{0} divide(multiply.793, broadcast.733)
  add.795 = f32[32768]{0} add(subtract.792, divide.794)
  divide.796 = f32[32768]{0} divide(multiply.745, broadcast.733)
  add.797 = f32[32768]{0} add(add.795, divide.796)
  divide.798 = f32[32768]{0} divide(multiply.746, broadcast.733)
  subtract.799 = f32[32768]{0} subtract(add.797, divide.798)
  reshape.853 = f32[32768,1]{1,0} reshape(subtract.799)
  broadcast.854 = f32[32768,1]{1,0} broadcast(reshape.853), dimensions={0,1}
  reshape.855 = f32[32768]{0} reshape(broadcast.854)
  broadcast.856 = f32[32768,32]{1,0} broadcast(reshape.855), dimensions={0}
  multiply.857 = f32[32768,32]{1,0} multiply(call.852, broadcast.856)
  add.858 = f32[32768,32]{1,0} add(add.847, multiply.857)
  slice.859 = s32[1]{0} slice(Arg_4.711), slice={[5:6]}
  reshape.860 = s32[] reshape(slice.859)
  broadcast.861 = s32[32768]{0} broadcast(reshape.860), dimensions={}
  add.862 = s32[32768]{0} add(convert.742, broadcast.861)
  call.863 = f32[32768,32]{1,0} call(Arg_0.707, add.862), to_apply=_roll_dynamic.688
  constant.712 = f32[] constant(30)
  broadcast.713 = f32[32768]{0} broadcast(constant.712), dimensions={}
  divide.800 = f32[32768]{0} divide(subtract.741, broadcast.713)
  divide.801 = f32[32768]{0} divide(multiply.744, broadcast.733)
  subtract.802 = f32[32768]{0} subtract(divide.800, divide.801)
  divide.803 = f32[32768]{0} divide(multiply.746, broadcast.731)
  add.804 = f32[32768]{0} add(subtract.802, divide.803)
  reshape.864 = f32[32768,1]{1,0} reshape(add.804)
  broadcast.865 = f32[32768,1]{1,0} broadcast(reshape.864), dimensions={0,1}
  reshape.866 = f32[32768]{0} reshape(broadcast.865)
  broadcast.867 = f32[32768,32]{1,0} broadcast(reshape.866), dimensions={0}
  multiply.868 = f32[32768,32]{1,0} multiply(call.863, broadcast.867)
  ROOT add.869 = f32[32768,32]{1,0} add(add.858, multiply.868)
}

region_0.873 {
  Arg_0.874 = f32[] parameter(0)
  Arg_1.875 = f32[] parameter(1)
  ROOT add.876 = f32[] add(Arg_0.874, Arg_1.875)
}

fft.877 {
  Arg_0.878 = f32[32,32]{1,0} parameter(0)
  ROOT fft.879 = c64[32,17]{1,0} fft(Arg_0.878), fft_type=RFFT, fft_length={32,32}
}

fft_0.880 {
  Arg_0.881 = c64[32,17]{1,0} parameter(0)
  ROOT fft.882 = f32[32,32]{1,0} fft(Arg_0.881), fft_type=IRFFT, fft_length={32,32}
}

fft_0.883 {
  Arg_0.884 = c64[32,17]{1,0} parameter(0)
  ROOT fft.885 = f32[32,32]{1,0} fft(Arg_0.884), fft_type=IRFFT, fft_length={32,32}
}

fft_0.886 {
  Arg_0.887 = c64[32,17]{1,0} parameter(0)
  ROOT fft.888 = f32[32,32]{1,0} fft(Arg_0.887), fft_type=IRFFT, fft_length={32,32}
}

solve_poisson.889 {
  Arg_1.891 = f32[32,1]{1,0} parameter(1)
  convert.913 = c64[32,1]{1,0} convert(Arg_1.891)
  constant.898 = c64[] constant((-0, -1))
  broadcast.899 = c64[32,1]{1,0} broadcast(constant.898), dimensions={}
  multiply.914 = c64[32,1]{1,0} multiply(convert.913, broadcast.899)
  broadcast.915 = c64[32,1]{1,0} broadcast(multiply.914), dimensions={0,1}
  reshape.916 = c64[32]{0} reshape(broadcast.915)
  broadcast.917 = c64[32,17]{1,0} broadcast(reshape.916), dimensions={0}
  Arg_0.890 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  constant.902 = f32[] constant(0)
  reduce.903 = f32[32,32]{1,0} reduce(Arg_0.890, constant.902), dimensions={2,3}, to_apply=region_0.873
  Arg_4.894 = f32[] parameter(4)
  broadcast.904 = f32[32,32]{1,0} broadcast(Arg_4.894), dimensions={}
  multiply.905 = f32[32,32]{1,0} multiply(reduce.903, broadcast.904)
  Arg_5.895 = f32[] parameter(5)
  broadcast.906 = f32[32,32]{1,0} broadcast(Arg_5.895), dimensions={}
  multiply.907 = f32[32,32]{1,0} multiply(multiply.905, broadcast.906)
  constant.900 = f32[] constant(1)
  broadcast.901 = f32[32,32]{1,0} broadcast(constant.900), dimensions={}
  subtract.908 = f32[32,32]{1,0} subtract(multiply.907, broadcast.901)
  call.909 = c64[32,17]{1,0} call(subtract.908), to_apply=fft.877
  Arg_3.893 = f32[32,17]{1,0} parameter(3)
  convert.910 = c64[32,17]{1,0} convert(Arg_3.893)
  multiply.911 = c64[32,17]{1,0} multiply(call.909, convert.910)
  multiply.918 = c64[32,17]{1,0} multiply(broadcast.917, multiply.911)
  call.925 = f32[32,32]{1,0} call(multiply.918), to_apply=fft_0.883
  Arg_2.892 = f32[1,17]{1,0} parameter(2)
  convert.919 = c64[1,17]{1,0} convert(Arg_2.892)
  constant.896 = c64[] constant((-0, -1))
  broadcast.897 = c64[1,17]{1,0} broadcast(constant.896), dimensions={}
  multiply.920 = c64[1,17]{1,0} multiply(convert.919, broadcast.897)
  broadcast.921 = c64[1,17]{1,0} broadcast(multiply.920), dimensions={0,1}
  reshape.922 = c64[17]{0} reshape(broadcast.921)
  broadcast.923 = c64[32,17]{1,0} broadcast(reshape.922), dimensions={1}
  multiply.924 = c64[32,17]{1,0} multiply(broadcast.923, multiply.911)
  call.926 = f32[32,32]{1,0} call(multiply.924), to_apply=fft_0.886
  call.912 = f32[32,32]{1,0} call(multiply.911), to_apply=fft_0.880
  ROOT tuple.927 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(call.925, call.926, subtract.908, call.912)
}

_where_2.940 {
  Arg_0.941 = pred[6,32768,32]{2,1,0} parameter(0)
  Arg_1.942 = f32[6,32768,1]{2,1,0} parameter(1)
  broadcast.944 = f32[6,32768,1]{2,1,0} broadcast(Arg_1.942), dimensions={0,1,2}
  reshape.945 = f32[6,32768]{1,0} reshape(broadcast.944)
  broadcast.946 = f32[6,32768,32]{2,1,0} broadcast(reshape.945), dimensions={0,1}
  Arg_2.943 = f32[] parameter(2)
  broadcast.947 = f32[6,32768,32]{2,1,0} broadcast(Arg_2.943), dimensions={}
  ROOT select.948 = f32[6,32768,32]{2,1,0} select(Arg_0.941, broadcast.946, broadcast.947)
}

build_v_diag_weights.949 {
  iota.1051 = s32[32]{0} iota(), iota_dimension=0
  reshape.1061 = s32[1,1,32]{2,1,0} reshape(iota.1051)
  broadcast.1063 = s32[1,1,32]{2,1,0} broadcast(reshape.1061), dimensions={0,1,2}
  reshape.1064 = s32[32]{0} reshape(broadcast.1063)
  broadcast.1065 = s32[6,32768,32]{2,1,0} broadcast(reshape.1064), dimensions={2}
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
  broadcast.1066 = s32[6,32768,1]{2,1,0} broadcast(reshape.1062), dimensions={0,1,2}
  reshape.1067 = s32[6,32768]{1,0} reshape(broadcast.1066)
  broadcast.1068 = s32[6,32768,32]{2,1,0} broadcast(reshape.1067), dimensions={0,1}
  subtract.1069 = s32[6,32768,32]{2,1,0} subtract(broadcast.1065, broadcast.1068)
  constant.955 = s32[] constant(0)
  broadcast.956 = s32[6,32768,32]{2,1,0} broadcast(constant.955), dimensions={}
  compare.1070 = pred[6,32768,32]{2,1,0} compare(subtract.1069, broadcast.956), direction=GE
  constant.953 = s32[] constant(32)
  broadcast.954 = s32[6,32768,32]{2,1,0} broadcast(constant.953), dimensions={}
  compare.1071 = pred[6,32768,32]{2,1,0} compare(subtract.1069, broadcast.954), direction=LT
  and.1072 = pred[6,32768,32]{2,1,0} and(compare.1070, compare.1071)
  Arg_2.952 = f32[32768]{0} parameter(2)
  constant.979 = f32[] constant(20)
  broadcast.980 = f32[32768]{0} broadcast(constant.979), dimensions={}
  divide.986 = f32[32768]{0} divide(Arg_2.952, broadcast.980)
  multiply.982 = f32[32768]{0} multiply(Arg_2.952, Arg_2.952)
  constant.977 = f32[] constant(24)
  broadcast.978 = f32[32768]{0} broadcast(constant.977), dimensions={}
  divide.987 = f32[32768]{0} divide(multiply.982, broadcast.978)
  subtract.988 = f32[32768]{0} subtract(divide.986, divide.987)
  multiply.983 = f32[32768]{0} multiply(multiply.982, Arg_2.952)
  divide.989 = f32[32768]{0} divide(multiply.983, broadcast.978)
  subtract.990 = f32[32768]{0} subtract(subtract.988, divide.989)
  multiply.984 = f32[32768]{0} multiply(multiply.983, Arg_2.952)
  divide.991 = f32[32768]{0} divide(multiply.984, broadcast.978)
  add.992 = f32[32768]{0} add(subtract.990, divide.991)
  multiply.985 = f32[32768]{0} multiply(multiply.984, Arg_2.952)
  constant.975 = f32[] constant(120)
  broadcast.976 = f32[32768]{0} broadcast(constant.975), dimensions={}
  divide.993 = f32[32768]{0} divide(multiply.985, broadcast.976)
  subtract.994 = f32[32768]{0} subtract(add.992, divide.993)
  reshape.1044 = f32[1,32768]{1,0} reshape(subtract.994)
  constant.973 = f32[] constant(2)
  broadcast.974 = f32[32768]{0} broadcast(constant.973), dimensions={}
  divide.995 = f32[32768]{0} divide(Arg_2.952, broadcast.974)
  negate.996 = f32[32768]{0} negate(divide.995)
  multiply.997 = f32[32768]{0} multiply(multiply.982, broadcast.974)
  constant.971 = f32[] constant(3)
  broadcast.972 = f32[32768]{0} broadcast(constant.971), dimensions={}
  divide.998 = f32[32768]{0} divide(multiply.997, broadcast.972)
  add.999 = f32[32768]{0} add(negate.996, divide.998)
  divide.1000 = f32[32768]{0} divide(multiply.983, broadcast.978)
  subtract.1001 = f32[32768]{0} subtract(add.999, divide.1000)
  constant.969 = f32[] constant(6)
  broadcast.970 = f32[32768]{0} broadcast(constant.969), dimensions={}
  divide.1002 = f32[32768]{0} divide(multiply.984, broadcast.970)
  subtract.1003 = f32[32768]{0} subtract(subtract.1001, divide.1002)
  divide.1004 = f32[32768]{0} divide(multiply.985, broadcast.978)
  add.1005 = f32[32768]{0} add(subtract.1003, divide.1004)
  reshape.1045 = f32[1,32768]{1,0} reshape(add.1005)
  constant.967 = f32[] constant(1)
  broadcast.968 = f32[32768]{0} broadcast(constant.967), dimensions={}
  divide.1006 = f32[32768]{0} divide(Arg_2.952, broadcast.972)
  subtract.1007 = f32[32768]{0} subtract(broadcast.968, divide.1006)
  constant.965 = f32[] constant(5)
  broadcast.966 = f32[32768]{0} broadcast(constant.965), dimensions={}
  multiply.1008 = f32[32768]{0} multiply(multiply.982, broadcast.966)
  constant.963 = f32[] constant(4)
  broadcast.964 = f32[32768]{0} broadcast(constant.963), dimensions={}
  divide.1009 = f32[32768]{0} divide(multiply.1008, broadcast.964)
  subtract.1010 = f32[32768]{0} subtract(subtract.1007, divide.1009)
  multiply.1011 = f32[32768]{0} multiply(multiply.983, broadcast.966)
  constant.961 = f32[] constant(12)
  broadcast.962 = f32[32768]{0} broadcast(constant.961), dimensions={}
  divide.1012 = f32[32768]{0} divide(multiply.1011, broadcast.962)
  add.1013 = f32[32768]{0} add(subtract.1010, divide.1012)
  divide.1014 = f32[32768]{0} divide(multiply.984, broadcast.964)
  add.1015 = f32[32768]{0} add(add.1013, divide.1014)
  divide.1016 = f32[32768]{0} divide(multiply.985, broadcast.962)
  subtract.1017 = f32[32768]{0} subtract(add.1015, divide.1016)
  reshape.1046 = f32[1,32768]{1,0} reshape(subtract.1017)
  multiply.1018 = f32[32768]{0} multiply(multiply.982, broadcast.974)
  divide.1019 = f32[32768]{0} divide(multiply.1018, broadcast.972)
  add.1020 = f32[32768]{0} add(Arg_2.952, divide.1019)
  constant.959 = f32[] constant(7)
  broadcast.960 = f32[32768]{0} broadcast(constant.959), dimensions={}
  multiply.1021 = f32[32768]{0} multiply(multiply.983, broadcast.960)
  divide.1022 = f32[32768]{0} divide(multiply.1021, broadcast.962)
  subtract.1023 = f32[32768]{0} subtract(add.1020, divide.1022)
  divide.1024 = f32[32768]{0} divide(multiply.984, broadcast.970)
  subtract.1025 = f32[32768]{0} subtract(subtract.1023, divide.1024)
  divide.1026 = f32[32768]{0} divide(multiply.985, broadcast.962)
  add.1027 = f32[32768]{0} add(subtract.1025, divide.1026)
  reshape.1047 = f32[1,32768]{1,0} reshape(add.1027)
  divide.1028 = f32[32768]{0} divide(Arg_2.952, broadcast.964)
  negate.1029 = f32[32768]{0} negate(divide.1028)
  divide.1030 = f32[32768]{0} divide(multiply.982, broadcast.978)
  subtract.1031 = f32[32768]{0} subtract(negate.1029, divide.1030)
  multiply.1032 = f32[32768]{0} multiply(multiply.983, broadcast.960)
  divide.1033 = f32[32768]{0} divide(multiply.1032, broadcast.978)
  add.1034 = f32[32768]{0} add(subtract.1031, divide.1033)
  divide.1035 = f32[32768]{0} divide(multiply.984, broadcast.978)
  add.1036 = f32[32768]{0} add(add.1034, divide.1035)
  divide.1037 = f32[32768]{0} divide(multiply.985, broadcast.978)
  subtract.1038 = f32[32768]{0} subtract(add.1036, divide.1037)
  reshape.1048 = f32[1,32768]{1,0} reshape(subtract.1038)
  constant.957 = f32[] constant(30)
  broadcast.958 = f32[32768]{0} broadcast(constant.957), dimensions={}
  divide.1039 = f32[32768]{0} divide(Arg_2.952, broadcast.958)
  divide.1040 = f32[32768]{0} divide(multiply.983, broadcast.978)
  subtract.1041 = f32[32768]{0} subtract(divide.1039, divide.1040)
  divide.1042 = f32[32768]{0} divide(multiply.985, broadcast.976)
  add.1043 = f32[32768]{0} add(subtract.1041, divide.1042)
  reshape.1049 = f32[1,32768]{1,0} reshape(add.1043)
  concatenate.1050 = f32[6,32768]{1,0} concatenate(reshape.1044, reshape.1045, reshape.1046, reshape.1047, reshape.1048, reshape.1049), dimensions={0}
  reshape.1073 = f32[6,32768,1]{2,1,0} reshape(concatenate.1050)
  constant.981 = f32[] constant(0)
  ROOT call.1074 = f32[6,32768,32]{2,1,0} call(and.1072, reshape.1073, constant.981), to_apply=_where_2.940
}

_where.1075 {
  Arg_0.1076 = pred[] parameter(0)
  Arg_1.1077 = s32[] parameter(1)
  Arg_2.1078 = s32[] parameter(2)
  ROOT select.1079 = s32[] select(Arg_0.1076, Arg_1.1077, Arg_2.1078)
}

remainder.1080 {
  Arg_0.1081 = s32[32768]{0} parameter(0)
  Arg_1.1082 = s32[] parameter(1)
  constant.1086 = s32[] constant(0)
  compare.1087 = pred[] compare(Arg_1.1082, constant.1086), direction=EQ
  constant.1085 = s32[] constant(1)
  call.1088 = s32[] call(compare.1087, constant.1085, Arg_1.1082), to_apply=_where.1075
  broadcast.1089 = s32[32768]{0} broadcast(call.1088), dimensions={}
  remainder.1090 = s32[32768]{0} remainder(Arg_0.1081, broadcast.1089)
  constant.1083 = s32[] constant(0)
  broadcast.1084 = s32[32768]{0} broadcast(constant.1083), dimensions={}
  compare.1092 = pred[32768]{0} compare(remainder.1090, broadcast.1084), direction=LT
  compare.1093 = pred[] compare(call.1088, constant.1086), direction=LT
  broadcast.1094 = pred[32768]{0} broadcast(compare.1093), dimensions={}
  compare.1095 = pred[32768]{0} compare(compare.1092, broadcast.1094), direction=NE
  compare.1091 = pred[32768]{0} compare(remainder.1090, broadcast.1084), direction=NE
  and.1096 = pred[32768]{0} and(compare.1095, compare.1091)
  broadcast.1097 = s32[32768]{0} broadcast(call.1088), dimensions={}
  add.1098 = s32[32768]{0} add(remainder.1090, broadcast.1097)
  ROOT select.1099 = s32[32768]{0} select(and.1096, add.1098, remainder.1090)
}

_roll_dynamic.1100 {
  Arg_0.1101 = f32[32768,32]{1,0} parameter(0)
  concatenate.1111 = f32[32768,64]{1,0} concatenate(Arg_0.1101, Arg_0.1101), dimensions={1}
  constant.1107 = s32[] constant(32)
  broadcast.1108 = s32[32768]{0} broadcast(constant.1107), dimensions={}
  Arg_1.1102 = s32[32768]{0} parameter(1)
  constant.1109 = s32[] constant(32)
  call.1110 = s32[32768]{0} call(Arg_1.1102, constant.1109), to_apply=remainder.1080
  subtract.1112 = s32[32768]{0} subtract(broadcast.1108, call.1110)
  constant.1105 = s32[] constant(0)
  broadcast.1106 = s32[32768]{0} broadcast(constant.1105), dimensions={}
  compare.1113 = pred[32768]{0} compare(subtract.1112, broadcast.1106), direction=LT
  constant.1103 = s32[] constant(64)
  broadcast.1104 = s32[32768]{0} broadcast(constant.1103), dimensions={}
  add.1114 = s32[32768]{0} add(subtract.1112, broadcast.1104)
  select.1115 = s32[32768]{0} select(compare.1113, add.1114, subtract.1112)
  reshape.1116 = s32[32768,1]{1,0} reshape(select.1115)
  ROOT gather.1117 = f32[32768,32]{1,0} gather(concatenate.1111, reshape.1116), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1118 {
  Arg_0.1119 = pred[] parameter(0)
  Arg_1.1120 = s32[] parameter(1)
  Arg_2.1121 = s32[] parameter(2)
  ROOT select.1122 = s32[] select(Arg_0.1119, Arg_1.1120, Arg_2.1121)
}

remainder.1123 {
  Arg_0.1124 = s32[32768]{0} parameter(0)
  Arg_1.1125 = s32[] parameter(1)
  constant.1129 = s32[] constant(0)
  compare.1130 = pred[] compare(Arg_1.1125, constant.1129), direction=EQ
  constant.1128 = s32[] constant(1)
  call.1131 = s32[] call(compare.1130, constant.1128, Arg_1.1125), to_apply=_where.1118
  broadcast.1132 = s32[32768]{0} broadcast(call.1131), dimensions={}
  remainder.1133 = s32[32768]{0} remainder(Arg_0.1124, broadcast.1132)
  constant.1126 = s32[] constant(0)
  broadcast.1127 = s32[32768]{0} broadcast(constant.1126), dimensions={}
  compare.1135 = pred[32768]{0} compare(remainder.1133, broadcast.1127), direction=LT
  compare.1136 = pred[] compare(call.1131, constant.1129), direction=LT
  broadcast.1137 = pred[32768]{0} broadcast(compare.1136), dimensions={}
  compare.1138 = pred[32768]{0} compare(compare.1135, broadcast.1137), direction=NE
  compare.1134 = pred[32768]{0} compare(remainder.1133, broadcast.1127), direction=NE
  and.1139 = pred[32768]{0} and(compare.1138, compare.1134)
  broadcast.1140 = s32[32768]{0} broadcast(call.1131), dimensions={}
  add.1141 = s32[32768]{0} add(remainder.1133, broadcast.1140)
  ROOT select.1142 = s32[32768]{0} select(and.1139, add.1141, remainder.1133)
}

_roll_dynamic.1143 {
  Arg_0.1144 = f32[32768,32]{1,0} parameter(0)
  concatenate.1154 = f32[32768,64]{1,0} concatenate(Arg_0.1144, Arg_0.1144), dimensions={1}
  constant.1150 = s32[] constant(32)
  broadcast.1151 = s32[32768]{0} broadcast(constant.1150), dimensions={}
  Arg_1.1145 = s32[32768]{0} parameter(1)
  constant.1152 = s32[] constant(32)
  call.1153 = s32[32768]{0} call(Arg_1.1145, constant.1152), to_apply=remainder.1123
  subtract.1155 = s32[32768]{0} subtract(broadcast.1151, call.1153)
  constant.1148 = s32[] constant(0)
  broadcast.1149 = s32[32768]{0} broadcast(constant.1148), dimensions={}
  compare.1156 = pred[32768]{0} compare(subtract.1155, broadcast.1149), direction=LT
  constant.1146 = s32[] constant(64)
  broadcast.1147 = s32[32768]{0} broadcast(constant.1146), dimensions={}
  add.1157 = s32[32768]{0} add(subtract.1155, broadcast.1147)
  select.1158 = s32[32768]{0} select(compare.1156, add.1157, subtract.1155)
  reshape.1159 = s32[32768,1]{1,0} reshape(select.1158)
  ROOT gather.1160 = f32[32768,32]{1,0} gather(concatenate.1154, reshape.1159), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1161 {
  Arg_0.1162 = pred[] parameter(0)
  Arg_1.1163 = s32[] parameter(1)
  Arg_2.1164 = s32[] parameter(2)
  ROOT select.1165 = s32[] select(Arg_0.1162, Arg_1.1163, Arg_2.1164)
}

remainder.1166 {
  Arg_0.1167 = s32[32768]{0} parameter(0)
  Arg_1.1168 = s32[] parameter(1)
  constant.1172 = s32[] constant(0)
  compare.1173 = pred[] compare(Arg_1.1168, constant.1172), direction=EQ
  constant.1171 = s32[] constant(1)
  call.1174 = s32[] call(compare.1173, constant.1171, Arg_1.1168), to_apply=_where.1161
  broadcast.1175 = s32[32768]{0} broadcast(call.1174), dimensions={}
  remainder.1176 = s32[32768]{0} remainder(Arg_0.1167, broadcast.1175)
  constant.1169 = s32[] constant(0)
  broadcast.1170 = s32[32768]{0} broadcast(constant.1169), dimensions={}
  compare.1178 = pred[32768]{0} compare(remainder.1176, broadcast.1170), direction=LT
  compare.1179 = pred[] compare(call.1174, constant.1172), direction=LT
  broadcast.1180 = pred[32768]{0} broadcast(compare.1179), dimensions={}
  compare.1181 = pred[32768]{0} compare(compare.1178, broadcast.1180), direction=NE
  compare.1177 = pred[32768]{0} compare(remainder.1176, broadcast.1170), direction=NE
  and.1182 = pred[32768]{0} and(compare.1181, compare.1177)
  broadcast.1183 = s32[32768]{0} broadcast(call.1174), dimensions={}
  add.1184 = s32[32768]{0} add(remainder.1176, broadcast.1183)
  ROOT select.1185 = s32[32768]{0} select(and.1182, add.1184, remainder.1176)
}

_roll_dynamic.1186 {
  Arg_0.1187 = f32[32768,32]{1,0} parameter(0)
  concatenate.1197 = f32[32768,64]{1,0} concatenate(Arg_0.1187, Arg_0.1187), dimensions={1}
  constant.1193 = s32[] constant(32)
  broadcast.1194 = s32[32768]{0} broadcast(constant.1193), dimensions={}
  Arg_1.1188 = s32[32768]{0} parameter(1)
  constant.1195 = s32[] constant(32)
  call.1196 = s32[32768]{0} call(Arg_1.1188, constant.1195), to_apply=remainder.1166
  subtract.1198 = s32[32768]{0} subtract(broadcast.1194, call.1196)
  constant.1191 = s32[] constant(0)
  broadcast.1192 = s32[32768]{0} broadcast(constant.1191), dimensions={}
  compare.1199 = pred[32768]{0} compare(subtract.1198, broadcast.1192), direction=LT
  constant.1189 = s32[] constant(64)
  broadcast.1190 = s32[32768]{0} broadcast(constant.1189), dimensions={}
  add.1200 = s32[32768]{0} add(subtract.1198, broadcast.1190)
  select.1201 = s32[32768]{0} select(compare.1199, add.1200, subtract.1198)
  reshape.1202 = s32[32768,1]{1,0} reshape(select.1201)
  ROOT gather.1203 = f32[32768,32]{1,0} gather(concatenate.1197, reshape.1202), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1204 {
  Arg_0.1205 = pred[] parameter(0)
  Arg_1.1206 = s32[] parameter(1)
  Arg_2.1207 = s32[] parameter(2)
  ROOT select.1208 = s32[] select(Arg_0.1205, Arg_1.1206, Arg_2.1207)
}

remainder.1209 {
  Arg_0.1210 = s32[32768]{0} parameter(0)
  Arg_1.1211 = s32[] parameter(1)
  constant.1215 = s32[] constant(0)
  compare.1216 = pred[] compare(Arg_1.1211, constant.1215), direction=EQ
  constant.1214 = s32[] constant(1)
  call.1217 = s32[] call(compare.1216, constant.1214, Arg_1.1211), to_apply=_where.1204
  broadcast.1218 = s32[32768]{0} broadcast(call.1217), dimensions={}
  remainder.1219 = s32[32768]{0} remainder(Arg_0.1210, broadcast.1218)
  constant.1212 = s32[] constant(0)
  broadcast.1213 = s32[32768]{0} broadcast(constant.1212), dimensions={}
  compare.1221 = pred[32768]{0} compare(remainder.1219, broadcast.1213), direction=LT
  compare.1222 = pred[] compare(call.1217, constant.1215), direction=LT
  broadcast.1223 = pred[32768]{0} broadcast(compare.1222), dimensions={}
  compare.1224 = pred[32768]{0} compare(compare.1221, broadcast.1223), direction=NE
  compare.1220 = pred[32768]{0} compare(remainder.1219, broadcast.1213), direction=NE
  and.1225 = pred[32768]{0} and(compare.1224, compare.1220)
  broadcast.1226 = s32[32768]{0} broadcast(call.1217), dimensions={}
  add.1227 = s32[32768]{0} add(remainder.1219, broadcast.1226)
  ROOT select.1228 = s32[32768]{0} select(and.1225, add.1227, remainder.1219)
}

_roll_dynamic.1229 {
  Arg_0.1230 = f32[32768,32]{1,0} parameter(0)
  concatenate.1240 = f32[32768,64]{1,0} concatenate(Arg_0.1230, Arg_0.1230), dimensions={1}
  constant.1236 = s32[] constant(32)
  broadcast.1237 = s32[32768]{0} broadcast(constant.1236), dimensions={}
  Arg_1.1231 = s32[32768]{0} parameter(1)
  constant.1238 = s32[] constant(32)
  call.1239 = s32[32768]{0} call(Arg_1.1231, constant.1238), to_apply=remainder.1209
  subtract.1241 = s32[32768]{0} subtract(broadcast.1237, call.1239)
  constant.1234 = s32[] constant(0)
  broadcast.1235 = s32[32768]{0} broadcast(constant.1234), dimensions={}
  compare.1242 = pred[32768]{0} compare(subtract.1241, broadcast.1235), direction=LT
  constant.1232 = s32[] constant(64)
  broadcast.1233 = s32[32768]{0} broadcast(constant.1232), dimensions={}
  add.1243 = s32[32768]{0} add(subtract.1241, broadcast.1233)
  select.1244 = s32[32768]{0} select(compare.1242, add.1243, subtract.1241)
  reshape.1245 = s32[32768,1]{1,0} reshape(select.1244)
  ROOT gather.1246 = f32[32768,32]{1,0} gather(concatenate.1240, reshape.1245), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1247 {
  Arg_0.1248 = pred[] parameter(0)
  Arg_1.1249 = s32[] parameter(1)
  Arg_2.1250 = s32[] parameter(2)
  ROOT select.1251 = s32[] select(Arg_0.1248, Arg_1.1249, Arg_2.1250)
}

remainder.1252 {
  Arg_0.1253 = s32[32768]{0} parameter(0)
  Arg_1.1254 = s32[] parameter(1)
  constant.1258 = s32[] constant(0)
  compare.1259 = pred[] compare(Arg_1.1254, constant.1258), direction=EQ
  constant.1257 = s32[] constant(1)
  call.1260 = s32[] call(compare.1259, constant.1257, Arg_1.1254), to_apply=_where.1247
  broadcast.1261 = s32[32768]{0} broadcast(call.1260), dimensions={}
  remainder.1262 = s32[32768]{0} remainder(Arg_0.1253, broadcast.1261)
  constant.1255 = s32[] constant(0)
  broadcast.1256 = s32[32768]{0} broadcast(constant.1255), dimensions={}
  compare.1264 = pred[32768]{0} compare(remainder.1262, broadcast.1256), direction=LT
  compare.1265 = pred[] compare(call.1260, constant.1258), direction=LT
  broadcast.1266 = pred[32768]{0} broadcast(compare.1265), dimensions={}
  compare.1267 = pred[32768]{0} compare(compare.1264, broadcast.1266), direction=NE
  compare.1263 = pred[32768]{0} compare(remainder.1262, broadcast.1256), direction=NE
  and.1268 = pred[32768]{0} and(compare.1267, compare.1263)
  broadcast.1269 = s32[32768]{0} broadcast(call.1260), dimensions={}
  add.1270 = s32[32768]{0} add(remainder.1262, broadcast.1269)
  ROOT select.1271 = s32[32768]{0} select(and.1268, add.1270, remainder.1262)
}

_roll_dynamic.1272 {
  Arg_0.1273 = f32[32768,32]{1,0} parameter(0)
  concatenate.1283 = f32[32768,64]{1,0} concatenate(Arg_0.1273, Arg_0.1273), dimensions={1}
  constant.1279 = s32[] constant(32)
  broadcast.1280 = s32[32768]{0} broadcast(constant.1279), dimensions={}
  Arg_1.1274 = s32[32768]{0} parameter(1)
  constant.1281 = s32[] constant(32)
  call.1282 = s32[32768]{0} call(Arg_1.1274, constant.1281), to_apply=remainder.1252
  subtract.1284 = s32[32768]{0} subtract(broadcast.1280, call.1282)
  constant.1277 = s32[] constant(0)
  broadcast.1278 = s32[32768]{0} broadcast(constant.1277), dimensions={}
  compare.1285 = pred[32768]{0} compare(subtract.1284, broadcast.1278), direction=LT
  constant.1275 = s32[] constant(64)
  broadcast.1276 = s32[32768]{0} broadcast(constant.1275), dimensions={}
  add.1286 = s32[32768]{0} add(subtract.1284, broadcast.1276)
  select.1287 = s32[32768]{0} select(compare.1285, add.1286, subtract.1284)
  reshape.1288 = s32[32768,1]{1,0} reshape(select.1287)
  ROOT gather.1289 = f32[32768,32]{1,0} gather(concatenate.1283, reshape.1288), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1290 {
  Arg_0.1291 = pred[] parameter(0)
  Arg_1.1292 = s32[] parameter(1)
  Arg_2.1293 = s32[] parameter(2)
  ROOT select.1294 = s32[] select(Arg_0.1291, Arg_1.1292, Arg_2.1293)
}

remainder.1295 {
  Arg_0.1296 = s32[32768]{0} parameter(0)
  Arg_1.1297 = s32[] parameter(1)
  constant.1301 = s32[] constant(0)
  compare.1302 = pred[] compare(Arg_1.1297, constant.1301), direction=EQ
  constant.1300 = s32[] constant(1)
  call.1303 = s32[] call(compare.1302, constant.1300, Arg_1.1297), to_apply=_where.1290
  broadcast.1304 = s32[32768]{0} broadcast(call.1303), dimensions={}
  remainder.1305 = s32[32768]{0} remainder(Arg_0.1296, broadcast.1304)
  constant.1298 = s32[] constant(0)
  broadcast.1299 = s32[32768]{0} broadcast(constant.1298), dimensions={}
  compare.1307 = pred[32768]{0} compare(remainder.1305, broadcast.1299), direction=LT
  compare.1308 = pred[] compare(call.1303, constant.1301), direction=LT
  broadcast.1309 = pred[32768]{0} broadcast(compare.1308), dimensions={}
  compare.1310 = pred[32768]{0} compare(compare.1307, broadcast.1309), direction=NE
  compare.1306 = pred[32768]{0} compare(remainder.1305, broadcast.1299), direction=NE
  and.1311 = pred[32768]{0} and(compare.1310, compare.1306)
  broadcast.1312 = s32[32768]{0} broadcast(call.1303), dimensions={}
  add.1313 = s32[32768]{0} add(remainder.1305, broadcast.1312)
  ROOT select.1314 = s32[32768]{0} select(and.1311, add.1313, remainder.1305)
}

_roll_dynamic.1315 {
  Arg_0.1316 = f32[32768,32]{1,0} parameter(0)
  concatenate.1326 = f32[32768,64]{1,0} concatenate(Arg_0.1316, Arg_0.1316), dimensions={1}
  constant.1322 = s32[] constant(32)
  broadcast.1323 = s32[32768]{0} broadcast(constant.1322), dimensions={}
  Arg_1.1317 = s32[32768]{0} parameter(1)
  constant.1324 = s32[] constant(32)
  call.1325 = s32[32768]{0} call(Arg_1.1317, constant.1324), to_apply=remainder.1295
  subtract.1327 = s32[32768]{0} subtract(broadcast.1323, call.1325)
  constant.1320 = s32[] constant(0)
  broadcast.1321 = s32[32768]{0} broadcast(constant.1320), dimensions={}
  compare.1328 = pred[32768]{0} compare(subtract.1327, broadcast.1321), direction=LT
  constant.1318 = s32[] constant(64)
  broadcast.1319 = s32[32768]{0} broadcast(constant.1318), dimensions={}
  add.1329 = s32[32768]{0} add(subtract.1327, broadcast.1319)
  select.1330 = s32[32768]{0} select(compare.1328, add.1329, subtract.1327)
  reshape.1331 = s32[32768,1]{1,0} reshape(select.1330)
  ROOT gather.1332 = f32[32768,32]{1,0} gather(concatenate.1326, reshape.1331), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag_1.1333 {
  Arg_4.1338 = s32[6]{0} parameter(4)
  Arg_1.1335 = f32[32768]{0} parameter(1)
  Arg_2.1336 = f32[] parameter(2)
  broadcast.1339 = f32[32768]{0} broadcast(Arg_2.1336), dimensions={}
  multiply.1340 = f32[32768]{0} multiply(Arg_1.1335, broadcast.1339)
  Arg_3.1337 = f32[] parameter(3)
  broadcast.1341 = f32[32768]{0} broadcast(Arg_3.1337), dimensions={}
  divide.1342 = f32[32768]{0} divide(multiply.1340, broadcast.1341)
  floor.1343 = f32[32768]{0} floor(divide.1342)
  convert.1345 = s32[32768]{0} convert(floor.1343)
  subtract.1344 = f32[32768]{0} subtract(divide.1342, floor.1343)
  call.1346 = f32[6,32768,32]{2,1,0} call(Arg_4.1338, convert.1345, subtract.1344), to_apply=build_v_diag_weights.949
  slice.1352 = f32[1,32768,32]{2,1,0} slice(call.1346), slice={[0:1], [0:32768], [0:32]}
  reshape.1353 = f32[32768,32]{1,0} reshape(slice.1352)
  Arg_0.1334 = f32[32768,32]{1,0} parameter(0)
  slice.1347 = s32[1]{0} slice(Arg_4.1338), slice={[0:1]}
  reshape.1348 = s32[] reshape(slice.1347)
  broadcast.1349 = s32[32768]{0} broadcast(reshape.1348), dimensions={}
  add.1350 = s32[32768]{0} add(convert.1345, broadcast.1349)
  call.1351 = f32[32768,32]{1,0} call(Arg_0.1334, add.1350), to_apply=_roll_dynamic.1100
  multiply.1354 = f32[32768,32]{1,0} multiply(reshape.1353, call.1351)
  slice.1360 = f32[1,32768,32]{2,1,0} slice(call.1346), slice={[1:2], [0:32768], [0:32]}
  reshape.1361 = f32[32768,32]{1,0} reshape(slice.1360)
  slice.1355 = s32[1]{0} slice(Arg_4.1338), slice={[1:2]}
  reshape.1356 = s32[] reshape(slice.1355)
  broadcast.1357 = s32[32768]{0} broadcast(reshape.1356), dimensions={}
  add.1358 = s32[32768]{0} add(convert.1345, broadcast.1357)
  call.1359 = f32[32768,32]{1,0} call(Arg_0.1334, add.1358), to_apply=_roll_dynamic.1143
  multiply.1362 = f32[32768,32]{1,0} multiply(reshape.1361, call.1359)
  add.1363 = f32[32768,32]{1,0} add(multiply.1354, multiply.1362)
  slice.1369 = f32[1,32768,32]{2,1,0} slice(call.1346), slice={[2:3], [0:32768], [0:32]}
  reshape.1370 = f32[32768,32]{1,0} reshape(slice.1369)
  slice.1364 = s32[1]{0} slice(Arg_4.1338), slice={[2:3]}
  reshape.1365 = s32[] reshape(slice.1364)
  broadcast.1366 = s32[32768]{0} broadcast(reshape.1365), dimensions={}
  add.1367 = s32[32768]{0} add(convert.1345, broadcast.1366)
  call.1368 = f32[32768,32]{1,0} call(Arg_0.1334, add.1367), to_apply=_roll_dynamic.1186
  multiply.1371 = f32[32768,32]{1,0} multiply(reshape.1370, call.1368)
  add.1372 = f32[32768,32]{1,0} add(add.1363, multiply.1371)
  slice.1378 = f32[1,32768,32]{2,1,0} slice(call.1346), slice={[3:4], [0:32768], [0:32]}
  reshape.1379 = f32[32768,32]{1,0} reshape(slice.1378)
  slice.1373 = s32[1]{0} slice(Arg_4.1338), slice={[3:4]}
  reshape.1374 = s32[] reshape(slice.1373)
  broadcast.1375 = s32[32768]{0} broadcast(reshape.1374), dimensions={}
  add.1376 = s32[32768]{0} add(convert.1345, broadcast.1375)
  call.1377 = f32[32768,32]{1,0} call(Arg_0.1334, add.1376), to_apply=_roll_dynamic.1229
  multiply.1380 = f32[32768,32]{1,0} multiply(reshape.1379, call.1377)
  add.1381 = f32[32768,32]{1,0} add(add.1372, multiply.1380)
  slice.1387 = f32[1,32768,32]{2,1,0} slice(call.1346), slice={[4:5], [0:32768], [0:32]}
  reshape.1388 = f32[32768,32]{1,0} reshape(slice.1387)
  slice.1382 = s32[1]{0} slice(Arg_4.1338), slice={[4:5]}
  reshape.1383 = s32[] reshape(slice.1382)
  broadcast.1384 = s32[32768]{0} broadcast(reshape.1383), dimensions={}
  add.1385 = s32[32768]{0} add(convert.1345, broadcast.1384)
  call.1386 = f32[32768,32]{1,0} call(Arg_0.1334, add.1385), to_apply=_roll_dynamic.1272
  multiply.1389 = f32[32768,32]{1,0} multiply(reshape.1388, call.1386)
  add.1390 = f32[32768,32]{1,0} add(add.1381, multiply.1389)
  slice.1396 = f32[1,32768,32]{2,1,0} slice(call.1346), slice={[5:6], [0:32768], [0:32]}
  reshape.1397 = f32[32768,32]{1,0} reshape(slice.1396)
  slice.1391 = s32[1]{0} slice(Arg_4.1338), slice={[5:6]}
  reshape.1392 = s32[] reshape(slice.1391)
  broadcast.1393 = s32[32768]{0} broadcast(reshape.1392), dimensions={}
  add.1394 = s32[32768]{0} add(convert.1345, broadcast.1393)
  call.1395 = f32[32768,32]{1,0} call(Arg_0.1334, add.1394), to_apply=_roll_dynamic.1315
  multiply.1398 = f32[32768,32]{1,0} multiply(reshape.1397, call.1395)
  ROOT add.1399 = f32[32768,32]{1,0} add(add.1390, multiply.1398)
}

_where_2.1409 {
  Arg_0.1410 = pred[6,32768,32]{2,1,0} parameter(0)
  Arg_1.1411 = f32[6,32768,1]{2,1,0} parameter(1)
  broadcast.1413 = f32[6,32768,1]{2,1,0} broadcast(Arg_1.1411), dimensions={0,1,2}
  reshape.1414 = f32[6,32768]{1,0} reshape(broadcast.1413)
  broadcast.1415 = f32[6,32768,32]{2,1,0} broadcast(reshape.1414), dimensions={0,1}
  Arg_2.1412 = f32[] parameter(2)
  broadcast.1416 = f32[6,32768,32]{2,1,0} broadcast(Arg_2.1412), dimensions={}
  ROOT select.1417 = f32[6,32768,32]{2,1,0} select(Arg_0.1410, broadcast.1415, broadcast.1416)
}

build_v_diag_weights.1418 {
  iota.1520 = s32[32]{0} iota(), iota_dimension=0
  reshape.1530 = s32[1,1,32]{2,1,0} reshape(iota.1520)
  broadcast.1532 = s32[1,1,32]{2,1,0} broadcast(reshape.1530), dimensions={0,1,2}
  reshape.1533 = s32[32]{0} reshape(broadcast.1532)
  broadcast.1534 = s32[6,32768,32]{2,1,0} broadcast(reshape.1533), dimensions={2}
  Arg_0.1419 = s32[6]{0} parameter(0)
  reshape.1521 = s32[6,1]{1,0} reshape(Arg_0.1419)
  broadcast.1523 = s32[6,1]{1,0} broadcast(reshape.1521), dimensions={0,1}
  reshape.1524 = s32[6]{0} reshape(broadcast.1523)
  broadcast.1525 = s32[6,32768]{1,0} broadcast(reshape.1524), dimensions={0}
  Arg_1.1420 = s32[32768]{0} parameter(1)
  reshape.1522 = s32[1,32768]{1,0} reshape(Arg_1.1420)
  broadcast.1526 = s32[1,32768]{1,0} broadcast(reshape.1522), dimensions={0,1}
  reshape.1527 = s32[32768]{0} reshape(broadcast.1526)
  broadcast.1528 = s32[6,32768]{1,0} broadcast(reshape.1527), dimensions={1}
  add.1529 = s32[6,32768]{1,0} add(broadcast.1525, broadcast.1528)
  reshape.1531 = s32[6,32768,1]{2,1,0} reshape(add.1529)
  broadcast.1535 = s32[6,32768,1]{2,1,0} broadcast(reshape.1531), dimensions={0,1,2}
  reshape.1536 = s32[6,32768]{1,0} reshape(broadcast.1535)
  broadcast.1537 = s32[6,32768,32]{2,1,0} broadcast(reshape.1536), dimensions={0,1}
  subtract.1538 = s32[6,32768,32]{2,1,0} subtract(broadcast.1534, broadcast.1537)
  constant.1424 = s32[] constant(0)
  broadcast.1425 = s32[6,32768,32]{2,1,0} broadcast(constant.1424), dimensions={}
  compare.1539 = pred[6,32768,32]{2,1,0} compare(subtract.1538, broadcast.1425), direction=GE
  constant.1422 = s32[] constant(32)
  broadcast.1423 = s32[6,32768,32]{2,1,0} broadcast(constant.1422), dimensions={}
  compare.1540 = pred[6,32768,32]{2,1,0} compare(subtract.1538, broadcast.1423), direction=LT
  and.1541 = pred[6,32768,32]{2,1,0} and(compare.1539, compare.1540)
  Arg_2.1421 = f32[32768]{0} parameter(2)
  constant.1448 = f32[] constant(20)
  broadcast.1449 = f32[32768]{0} broadcast(constant.1448), dimensions={}
  divide.1455 = f32[32768]{0} divide(Arg_2.1421, broadcast.1449)
  multiply.1451 = f32[32768]{0} multiply(Arg_2.1421, Arg_2.1421)
  constant.1446 = f32[] constant(24)
  broadcast.1447 = f32[32768]{0} broadcast(constant.1446), dimensions={}
  divide.1456 = f32[32768]{0} divide(multiply.1451, broadcast.1447)
  subtract.1457 = f32[32768]{0} subtract(divide.1455, divide.1456)
  multiply.1452 = f32[32768]{0} multiply(multiply.1451, Arg_2.1421)
  divide.1458 = f32[32768]{0} divide(multiply.1452, broadcast.1447)
  subtract.1459 = f32[32768]{0} subtract(subtract.1457, divide.1458)
  multiply.1453 = f32[32768]{0} multiply(multiply.1452, Arg_2.1421)
  divide.1460 = f32[32768]{0} divide(multiply.1453, broadcast.1447)
  add.1461 = f32[32768]{0} add(subtract.1459, divide.1460)
  multiply.1454 = f32[32768]{0} multiply(multiply.1453, Arg_2.1421)
  constant.1444 = f32[] constant(120)
  broadcast.1445 = f32[32768]{0} broadcast(constant.1444), dimensions={}
  divide.1462 = f32[32768]{0} divide(multiply.1454, broadcast.1445)
  subtract.1463 = f32[32768]{0} subtract(add.1461, divide.1462)
  reshape.1513 = f32[1,32768]{1,0} reshape(subtract.1463)
  constant.1442 = f32[] constant(2)
  broadcast.1443 = f32[32768]{0} broadcast(constant.1442), dimensions={}
  divide.1464 = f32[32768]{0} divide(Arg_2.1421, broadcast.1443)
  negate.1465 = f32[32768]{0} negate(divide.1464)
  multiply.1466 = f32[32768]{0} multiply(multiply.1451, broadcast.1443)
  constant.1440 = f32[] constant(3)
  broadcast.1441 = f32[32768]{0} broadcast(constant.1440), dimensions={}
  divide.1467 = f32[32768]{0} divide(multiply.1466, broadcast.1441)
  add.1468 = f32[32768]{0} add(negate.1465, divide.1467)
  divide.1469 = f32[32768]{0} divide(multiply.1452, broadcast.1447)
  subtract.1470 = f32[32768]{0} subtract(add.1468, divide.1469)
  constant.1438 = f32[] constant(6)
  broadcast.1439 = f32[32768]{0} broadcast(constant.1438), dimensions={}
  divide.1471 = f32[32768]{0} divide(multiply.1453, broadcast.1439)
  subtract.1472 = f32[32768]{0} subtract(subtract.1470, divide.1471)
  divide.1473 = f32[32768]{0} divide(multiply.1454, broadcast.1447)
  add.1474 = f32[32768]{0} add(subtract.1472, divide.1473)
  reshape.1514 = f32[1,32768]{1,0} reshape(add.1474)
  constant.1436 = f32[] constant(1)
  broadcast.1437 = f32[32768]{0} broadcast(constant.1436), dimensions={}
  divide.1475 = f32[32768]{0} divide(Arg_2.1421, broadcast.1441)
  subtract.1476 = f32[32768]{0} subtract(broadcast.1437, divide.1475)
  constant.1434 = f32[] constant(5)
  broadcast.1435 = f32[32768]{0} broadcast(constant.1434), dimensions={}
  multiply.1477 = f32[32768]{0} multiply(multiply.1451, broadcast.1435)
  constant.1432 = f32[] constant(4)
  broadcast.1433 = f32[32768]{0} broadcast(constant.1432), dimensions={}
  divide.1478 = f32[32768]{0} divide(multiply.1477, broadcast.1433)
  subtract.1479 = f32[32768]{0} subtract(subtract.1476, divide.1478)
  multiply.1480 = f32[32768]{0} multiply(multiply.1452, broadcast.1435)
  constant.1430 = f32[] constant(12)
  broadcast.1431 = f32[32768]{0} broadcast(constant.1430), dimensions={}
  divide.1481 = f32[32768]{0} divide(multiply.1480, broadcast.1431)
  add.1482 = f32[32768]{0} add(subtract.1479, divide.1481)
  divide.1483 = f32[32768]{0} divide(multiply.1453, broadcast.1433)
  add.1484 = f32[32768]{0} add(add.1482, divide.1483)
  divide.1485 = f32[32768]{0} divide(multiply.1454, broadcast.1431)
  subtract.1486 = f32[32768]{0} subtract(add.1484, divide.1485)
  reshape.1515 = f32[1,32768]{1,0} reshape(subtract.1486)
  multiply.1487 = f32[32768]{0} multiply(multiply.1451, broadcast.1443)
  divide.1488 = f32[32768]{0} divide(multiply.1487, broadcast.1441)
  add.1489 = f32[32768]{0} add(Arg_2.1421, divide.1488)
  constant.1428 = f32[] constant(7)
  broadcast.1429 = f32[32768]{0} broadcast(constant.1428), dimensions={}
  multiply.1490 = f32[32768]{0} multiply(multiply.1452, broadcast.1429)
  divide.1491 = f32[32768]{0} divide(multiply.1490, broadcast.1431)
  subtract.1492 = f32[32768]{0} subtract(add.1489, divide.1491)
  divide.1493 = f32[32768]{0} divide(multiply.1453, broadcast.1439)
  subtract.1494 = f32[32768]{0} subtract(subtract.1492, divide.1493)
  divide.1495 = f32[32768]{0} divide(multiply.1454, broadcast.1431)
  add.1496 = f32[32768]{0} add(subtract.1494, divide.1495)
  reshape.1516 = f32[1,32768]{1,0} reshape(add.1496)
  divide.1497 = f32[32768]{0} divide(Arg_2.1421, broadcast.1433)
  negate.1498 = f32[32768]{0} negate(divide.1497)
  divide.1499 = f32[32768]{0} divide(multiply.1451, broadcast.1447)
  subtract.1500 = f32[32768]{0} subtract(negate.1498, divide.1499)
  multiply.1501 = f32[32768]{0} multiply(multiply.1452, broadcast.1429)
  divide.1502 = f32[32768]{0} divide(multiply.1501, broadcast.1447)
  add.1503 = f32[32768]{0} add(subtract.1500, divide.1502)
  divide.1504 = f32[32768]{0} divide(multiply.1453, broadcast.1447)
  add.1505 = f32[32768]{0} add(add.1503, divide.1504)
  divide.1506 = f32[32768]{0} divide(multiply.1454, broadcast.1447)
  subtract.1507 = f32[32768]{0} subtract(add.1505, divide.1506)
  reshape.1517 = f32[1,32768]{1,0} reshape(subtract.1507)
  constant.1426 = f32[] constant(30)
  broadcast.1427 = f32[32768]{0} broadcast(constant.1426), dimensions={}
  divide.1508 = f32[32768]{0} divide(Arg_2.1421, broadcast.1427)
  divide.1509 = f32[32768]{0} divide(multiply.1452, broadcast.1447)
  subtract.1510 = f32[32768]{0} subtract(divide.1508, divide.1509)
  divide.1511 = f32[32768]{0} divide(multiply.1454, broadcast.1445)
  add.1512 = f32[32768]{0} add(subtract.1510, divide.1511)
  reshape.1518 = f32[1,32768]{1,0} reshape(add.1512)
  concatenate.1519 = f32[6,32768]{1,0} concatenate(reshape.1513, reshape.1514, reshape.1515, reshape.1516, reshape.1517, reshape.1518), dimensions={0}
  reshape.1542 = f32[6,32768,1]{2,1,0} reshape(concatenate.1519)
  constant.1450 = f32[] constant(0)
  ROOT call.1543 = f32[6,32768,32]{2,1,0} call(and.1541, reshape.1542, constant.1450), to_apply=_where_2.1409
}

_where.1544 {
  Arg_0.1545 = pred[] parameter(0)
  Arg_1.1546 = s32[] parameter(1)
  Arg_2.1547 = s32[] parameter(2)
  ROOT select.1548 = s32[] select(Arg_0.1545, Arg_1.1546, Arg_2.1547)
}

remainder.1549 {
  Arg_0.1550 = s32[32768]{0} parameter(0)
  Arg_1.1551 = s32[] parameter(1)
  constant.1555 = s32[] constant(0)
  compare.1556 = pred[] compare(Arg_1.1551, constant.1555), direction=EQ
  constant.1554 = s32[] constant(1)
  call.1557 = s32[] call(compare.1556, constant.1554, Arg_1.1551), to_apply=_where.1544
  broadcast.1558 = s32[32768]{0} broadcast(call.1557), dimensions={}
  remainder.1559 = s32[32768]{0} remainder(Arg_0.1550, broadcast.1558)
  constant.1552 = s32[] constant(0)
  broadcast.1553 = s32[32768]{0} broadcast(constant.1552), dimensions={}
  compare.1561 = pred[32768]{0} compare(remainder.1559, broadcast.1553), direction=LT
  compare.1562 = pred[] compare(call.1557, constant.1555), direction=LT
  broadcast.1563 = pred[32768]{0} broadcast(compare.1562), dimensions={}
  compare.1564 = pred[32768]{0} compare(compare.1561, broadcast.1563), direction=NE
  compare.1560 = pred[32768]{0} compare(remainder.1559, broadcast.1553), direction=NE
  and.1565 = pred[32768]{0} and(compare.1564, compare.1560)
  broadcast.1566 = s32[32768]{0} broadcast(call.1557), dimensions={}
  add.1567 = s32[32768]{0} add(remainder.1559, broadcast.1566)
  ROOT select.1568 = s32[32768]{0} select(and.1565, add.1567, remainder.1559)
}

_roll_dynamic.1569 {
  Arg_0.1570 = f32[32768,32]{1,0} parameter(0)
  concatenate.1580 = f32[32768,64]{1,0} concatenate(Arg_0.1570, Arg_0.1570), dimensions={1}
  constant.1576 = s32[] constant(32)
  broadcast.1577 = s32[32768]{0} broadcast(constant.1576), dimensions={}
  Arg_1.1571 = s32[32768]{0} parameter(1)
  constant.1578 = s32[] constant(32)
  call.1579 = s32[32768]{0} call(Arg_1.1571, constant.1578), to_apply=remainder.1549
  subtract.1581 = s32[32768]{0} subtract(broadcast.1577, call.1579)
  constant.1574 = s32[] constant(0)
  broadcast.1575 = s32[32768]{0} broadcast(constant.1574), dimensions={}
  compare.1582 = pred[32768]{0} compare(subtract.1581, broadcast.1575), direction=LT
  constant.1572 = s32[] constant(64)
  broadcast.1573 = s32[32768]{0} broadcast(constant.1572), dimensions={}
  add.1583 = s32[32768]{0} add(subtract.1581, broadcast.1573)
  select.1584 = s32[32768]{0} select(compare.1582, add.1583, subtract.1581)
  reshape.1585 = s32[32768,1]{1,0} reshape(select.1584)
  ROOT gather.1586 = f32[32768,32]{1,0} gather(concatenate.1580, reshape.1585), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1587 {
  Arg_0.1588 = pred[] parameter(0)
  Arg_1.1589 = s32[] parameter(1)
  Arg_2.1590 = s32[] parameter(2)
  ROOT select.1591 = s32[] select(Arg_0.1588, Arg_1.1589, Arg_2.1590)
}

remainder.1592 {
  Arg_0.1593 = s32[32768]{0} parameter(0)
  Arg_1.1594 = s32[] parameter(1)
  constant.1598 = s32[] constant(0)
  compare.1599 = pred[] compare(Arg_1.1594, constant.1598), direction=EQ
  constant.1597 = s32[] constant(1)
  call.1600 = s32[] call(compare.1599, constant.1597, Arg_1.1594), to_apply=_where.1587
  broadcast.1601 = s32[32768]{0} broadcast(call.1600), dimensions={}
  remainder.1602 = s32[32768]{0} remainder(Arg_0.1593, broadcast.1601)
  constant.1595 = s32[] constant(0)
  broadcast.1596 = s32[32768]{0} broadcast(constant.1595), dimensions={}
  compare.1604 = pred[32768]{0} compare(remainder.1602, broadcast.1596), direction=LT
  compare.1605 = pred[] compare(call.1600, constant.1598), direction=LT
  broadcast.1606 = pred[32768]{0} broadcast(compare.1605), dimensions={}
  compare.1607 = pred[32768]{0} compare(compare.1604, broadcast.1606), direction=NE
  compare.1603 = pred[32768]{0} compare(remainder.1602, broadcast.1596), direction=NE
  and.1608 = pred[32768]{0} and(compare.1607, compare.1603)
  broadcast.1609 = s32[32768]{0} broadcast(call.1600), dimensions={}
  add.1610 = s32[32768]{0} add(remainder.1602, broadcast.1609)
  ROOT select.1611 = s32[32768]{0} select(and.1608, add.1610, remainder.1602)
}

_roll_dynamic.1612 {
  Arg_0.1613 = f32[32768,32]{1,0} parameter(0)
  concatenate.1623 = f32[32768,64]{1,0} concatenate(Arg_0.1613, Arg_0.1613), dimensions={1}
  constant.1619 = s32[] constant(32)
  broadcast.1620 = s32[32768]{0} broadcast(constant.1619), dimensions={}
  Arg_1.1614 = s32[32768]{0} parameter(1)
  constant.1621 = s32[] constant(32)
  call.1622 = s32[32768]{0} call(Arg_1.1614, constant.1621), to_apply=remainder.1592
  subtract.1624 = s32[32768]{0} subtract(broadcast.1620, call.1622)
  constant.1617 = s32[] constant(0)
  broadcast.1618 = s32[32768]{0} broadcast(constant.1617), dimensions={}
  compare.1625 = pred[32768]{0} compare(subtract.1624, broadcast.1618), direction=LT
  constant.1615 = s32[] constant(64)
  broadcast.1616 = s32[32768]{0} broadcast(constant.1615), dimensions={}
  add.1626 = s32[32768]{0} add(subtract.1624, broadcast.1616)
  select.1627 = s32[32768]{0} select(compare.1625, add.1626, subtract.1624)
  reshape.1628 = s32[32768,1]{1,0} reshape(select.1627)
  ROOT gather.1629 = f32[32768,32]{1,0} gather(concatenate.1623, reshape.1628), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1630 {
  Arg_0.1631 = pred[] parameter(0)
  Arg_1.1632 = s32[] parameter(1)
  Arg_2.1633 = s32[] parameter(2)
  ROOT select.1634 = s32[] select(Arg_0.1631, Arg_1.1632, Arg_2.1633)
}

remainder.1635 {
  Arg_0.1636 = s32[32768]{0} parameter(0)
  Arg_1.1637 = s32[] parameter(1)
  constant.1641 = s32[] constant(0)
  compare.1642 = pred[] compare(Arg_1.1637, constant.1641), direction=EQ
  constant.1640 = s32[] constant(1)
  call.1643 = s32[] call(compare.1642, constant.1640, Arg_1.1637), to_apply=_where.1630
  broadcast.1644 = s32[32768]{0} broadcast(call.1643), dimensions={}
  remainder.1645 = s32[32768]{0} remainder(Arg_0.1636, broadcast.1644)
  constant.1638 = s32[] constant(0)
  broadcast.1639 = s32[32768]{0} broadcast(constant.1638), dimensions={}
  compare.1647 = pred[32768]{0} compare(remainder.1645, broadcast.1639), direction=LT
  compare.1648 = pred[] compare(call.1643, constant.1641), direction=LT
  broadcast.1649 = pred[32768]{0} broadcast(compare.1648), dimensions={}
  compare.1650 = pred[32768]{0} compare(compare.1647, broadcast.1649), direction=NE
  compare.1646 = pred[32768]{0} compare(remainder.1645, broadcast.1639), direction=NE
  and.1651 = pred[32768]{0} and(compare.1650, compare.1646)
  broadcast.1652 = s32[32768]{0} broadcast(call.1643), dimensions={}
  add.1653 = s32[32768]{0} add(remainder.1645, broadcast.1652)
  ROOT select.1654 = s32[32768]{0} select(and.1651, add.1653, remainder.1645)
}

_roll_dynamic.1655 {
  Arg_0.1656 = f32[32768,32]{1,0} parameter(0)
  concatenate.1666 = f32[32768,64]{1,0} concatenate(Arg_0.1656, Arg_0.1656), dimensions={1}
  constant.1662 = s32[] constant(32)
  broadcast.1663 = s32[32768]{0} broadcast(constant.1662), dimensions={}
  Arg_1.1657 = s32[32768]{0} parameter(1)
  constant.1664 = s32[] constant(32)
  call.1665 = s32[32768]{0} call(Arg_1.1657, constant.1664), to_apply=remainder.1635
  subtract.1667 = s32[32768]{0} subtract(broadcast.1663, call.1665)
  constant.1660 = s32[] constant(0)
  broadcast.1661 = s32[32768]{0} broadcast(constant.1660), dimensions={}
  compare.1668 = pred[32768]{0} compare(subtract.1667, broadcast.1661), direction=LT
  constant.1658 = s32[] constant(64)
  broadcast.1659 = s32[32768]{0} broadcast(constant.1658), dimensions={}
  add.1669 = s32[32768]{0} add(subtract.1667, broadcast.1659)
  select.1670 = s32[32768]{0} select(compare.1668, add.1669, subtract.1667)
  reshape.1671 = s32[32768,1]{1,0} reshape(select.1670)
  ROOT gather.1672 = f32[32768,32]{1,0} gather(concatenate.1666, reshape.1671), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1673 {
  Arg_0.1674 = pred[] parameter(0)
  Arg_1.1675 = s32[] parameter(1)
  Arg_2.1676 = s32[] parameter(2)
  ROOT select.1677 = s32[] select(Arg_0.1674, Arg_1.1675, Arg_2.1676)
}

remainder.1678 {
  Arg_0.1679 = s32[32768]{0} parameter(0)
  Arg_1.1680 = s32[] parameter(1)
  constant.1684 = s32[] constant(0)
  compare.1685 = pred[] compare(Arg_1.1680, constant.1684), direction=EQ
  constant.1683 = s32[] constant(1)
  call.1686 = s32[] call(compare.1685, constant.1683, Arg_1.1680), to_apply=_where.1673
  broadcast.1687 = s32[32768]{0} broadcast(call.1686), dimensions={}
  remainder.1688 = s32[32768]{0} remainder(Arg_0.1679, broadcast.1687)
  constant.1681 = s32[] constant(0)
  broadcast.1682 = s32[32768]{0} broadcast(constant.1681), dimensions={}
  compare.1690 = pred[32768]{0} compare(remainder.1688, broadcast.1682), direction=LT
  compare.1691 = pred[] compare(call.1686, constant.1684), direction=LT
  broadcast.1692 = pred[32768]{0} broadcast(compare.1691), dimensions={}
  compare.1693 = pred[32768]{0} compare(compare.1690, broadcast.1692), direction=NE
  compare.1689 = pred[32768]{0} compare(remainder.1688, broadcast.1682), direction=NE
  and.1694 = pred[32768]{0} and(compare.1693, compare.1689)
  broadcast.1695 = s32[32768]{0} broadcast(call.1686), dimensions={}
  add.1696 = s32[32768]{0} add(remainder.1688, broadcast.1695)
  ROOT select.1697 = s32[32768]{0} select(and.1694, add.1696, remainder.1688)
}

_roll_dynamic.1698 {
  Arg_0.1699 = f32[32768,32]{1,0} parameter(0)
  concatenate.1709 = f32[32768,64]{1,0} concatenate(Arg_0.1699, Arg_0.1699), dimensions={1}
  constant.1705 = s32[] constant(32)
  broadcast.1706 = s32[32768]{0} broadcast(constant.1705), dimensions={}
  Arg_1.1700 = s32[32768]{0} parameter(1)
  constant.1707 = s32[] constant(32)
  call.1708 = s32[32768]{0} call(Arg_1.1700, constant.1707), to_apply=remainder.1678
  subtract.1710 = s32[32768]{0} subtract(broadcast.1706, call.1708)
  constant.1703 = s32[] constant(0)
  broadcast.1704 = s32[32768]{0} broadcast(constant.1703), dimensions={}
  compare.1711 = pred[32768]{0} compare(subtract.1710, broadcast.1704), direction=LT
  constant.1701 = s32[] constant(64)
  broadcast.1702 = s32[32768]{0} broadcast(constant.1701), dimensions={}
  add.1712 = s32[32768]{0} add(subtract.1710, broadcast.1702)
  select.1713 = s32[32768]{0} select(compare.1711, add.1712, subtract.1710)
  reshape.1714 = s32[32768,1]{1,0} reshape(select.1713)
  ROOT gather.1715 = f32[32768,32]{1,0} gather(concatenate.1709, reshape.1714), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1716 {
  Arg_0.1717 = pred[] parameter(0)
  Arg_1.1718 = s32[] parameter(1)
  Arg_2.1719 = s32[] parameter(2)
  ROOT select.1720 = s32[] select(Arg_0.1717, Arg_1.1718, Arg_2.1719)
}

remainder.1721 {
  Arg_0.1722 = s32[32768]{0} parameter(0)
  Arg_1.1723 = s32[] parameter(1)
  constant.1727 = s32[] constant(0)
  compare.1728 = pred[] compare(Arg_1.1723, constant.1727), direction=EQ
  constant.1726 = s32[] constant(1)
  call.1729 = s32[] call(compare.1728, constant.1726, Arg_1.1723), to_apply=_where.1716
  broadcast.1730 = s32[32768]{0} broadcast(call.1729), dimensions={}
  remainder.1731 = s32[32768]{0} remainder(Arg_0.1722, broadcast.1730)
  constant.1724 = s32[] constant(0)
  broadcast.1725 = s32[32768]{0} broadcast(constant.1724), dimensions={}
  compare.1733 = pred[32768]{0} compare(remainder.1731, broadcast.1725), direction=LT
  compare.1734 = pred[] compare(call.1729, constant.1727), direction=LT
  broadcast.1735 = pred[32768]{0} broadcast(compare.1734), dimensions={}
  compare.1736 = pred[32768]{0} compare(compare.1733, broadcast.1735), direction=NE
  compare.1732 = pred[32768]{0} compare(remainder.1731, broadcast.1725), direction=NE
  and.1737 = pred[32768]{0} and(compare.1736, compare.1732)
  broadcast.1738 = s32[32768]{0} broadcast(call.1729), dimensions={}
  add.1739 = s32[32768]{0} add(remainder.1731, broadcast.1738)
  ROOT select.1740 = s32[32768]{0} select(and.1737, add.1739, remainder.1731)
}

_roll_dynamic.1741 {
  Arg_0.1742 = f32[32768,32]{1,0} parameter(0)
  concatenate.1752 = f32[32768,64]{1,0} concatenate(Arg_0.1742, Arg_0.1742), dimensions={1}
  constant.1748 = s32[] constant(32)
  broadcast.1749 = s32[32768]{0} broadcast(constant.1748), dimensions={}
  Arg_1.1743 = s32[32768]{0} parameter(1)
  constant.1750 = s32[] constant(32)
  call.1751 = s32[32768]{0} call(Arg_1.1743, constant.1750), to_apply=remainder.1721
  subtract.1753 = s32[32768]{0} subtract(broadcast.1749, call.1751)
  constant.1746 = s32[] constant(0)
  broadcast.1747 = s32[32768]{0} broadcast(constant.1746), dimensions={}
  compare.1754 = pred[32768]{0} compare(subtract.1753, broadcast.1747), direction=LT
  constant.1744 = s32[] constant(64)
  broadcast.1745 = s32[32768]{0} broadcast(constant.1744), dimensions={}
  add.1755 = s32[32768]{0} add(subtract.1753, broadcast.1745)
  select.1756 = s32[32768]{0} select(compare.1754, add.1755, subtract.1753)
  reshape.1757 = s32[32768,1]{1,0} reshape(select.1756)
  ROOT gather.1758 = f32[32768,32]{1,0} gather(concatenate.1752, reshape.1757), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1759 {
  Arg_0.1760 = pred[] parameter(0)
  Arg_1.1761 = s32[] parameter(1)
  Arg_2.1762 = s32[] parameter(2)
  ROOT select.1763 = s32[] select(Arg_0.1760, Arg_1.1761, Arg_2.1762)
}

remainder.1764 {
  Arg_0.1765 = s32[32768]{0} parameter(0)
  Arg_1.1766 = s32[] parameter(1)
  constant.1770 = s32[] constant(0)
  compare.1771 = pred[] compare(Arg_1.1766, constant.1770), direction=EQ
  constant.1769 = s32[] constant(1)
  call.1772 = s32[] call(compare.1771, constant.1769, Arg_1.1766), to_apply=_where.1759
  broadcast.1773 = s32[32768]{0} broadcast(call.1772), dimensions={}
  remainder.1774 = s32[32768]{0} remainder(Arg_0.1765, broadcast.1773)
  constant.1767 = s32[] constant(0)
  broadcast.1768 = s32[32768]{0} broadcast(constant.1767), dimensions={}
  compare.1776 = pred[32768]{0} compare(remainder.1774, broadcast.1768), direction=LT
  compare.1777 = pred[] compare(call.1772, constant.1770), direction=LT
  broadcast.1778 = pred[32768]{0} broadcast(compare.1777), dimensions={}
  compare.1779 = pred[32768]{0} compare(compare.1776, broadcast.1778), direction=NE
  compare.1775 = pred[32768]{0} compare(remainder.1774, broadcast.1768), direction=NE
  and.1780 = pred[32768]{0} and(compare.1779, compare.1775)
  broadcast.1781 = s32[32768]{0} broadcast(call.1772), dimensions={}
  add.1782 = s32[32768]{0} add(remainder.1774, broadcast.1781)
  ROOT select.1783 = s32[32768]{0} select(and.1780, add.1782, remainder.1774)
}

_roll_dynamic.1784 {
  Arg_0.1785 = f32[32768,32]{1,0} parameter(0)
  concatenate.1795 = f32[32768,64]{1,0} concatenate(Arg_0.1785, Arg_0.1785), dimensions={1}
  constant.1791 = s32[] constant(32)
  broadcast.1792 = s32[32768]{0} broadcast(constant.1791), dimensions={}
  Arg_1.1786 = s32[32768]{0} parameter(1)
  constant.1793 = s32[] constant(32)
  call.1794 = s32[32768]{0} call(Arg_1.1786, constant.1793), to_apply=remainder.1764
  subtract.1796 = s32[32768]{0} subtract(broadcast.1792, call.1794)
  constant.1789 = s32[] constant(0)
  broadcast.1790 = s32[32768]{0} broadcast(constant.1789), dimensions={}
  compare.1797 = pred[32768]{0} compare(subtract.1796, broadcast.1790), direction=LT
  constant.1787 = s32[] constant(64)
  broadcast.1788 = s32[32768]{0} broadcast(constant.1787), dimensions={}
  add.1798 = s32[32768]{0} add(subtract.1796, broadcast.1788)
  select.1799 = s32[32768]{0} select(compare.1797, add.1798, subtract.1796)
  reshape.1800 = s32[32768,1]{1,0} reshape(select.1799)
  ROOT gather.1801 = f32[32768,32]{1,0} gather(concatenate.1795, reshape.1800), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag_1.1802 {
  Arg_4.1807 = s32[6]{0} parameter(4)
  Arg_1.1804 = f32[32768]{0} parameter(1)
  Arg_2.1805 = f32[] parameter(2)
  broadcast.1808 = f32[32768]{0} broadcast(Arg_2.1805), dimensions={}
  multiply.1809 = f32[32768]{0} multiply(Arg_1.1804, broadcast.1808)
  Arg_3.1806 = f32[] parameter(3)
  broadcast.1810 = f32[32768]{0} broadcast(Arg_3.1806), dimensions={}
  divide.1811 = f32[32768]{0} divide(multiply.1809, broadcast.1810)
  floor.1812 = f32[32768]{0} floor(divide.1811)
  convert.1814 = s32[32768]{0} convert(floor.1812)
  subtract.1813 = f32[32768]{0} subtract(divide.1811, floor.1812)
  call.1815 = f32[6,32768,32]{2,1,0} call(Arg_4.1807, convert.1814, subtract.1813), to_apply=build_v_diag_weights.1418
  slice.1821 = f32[1,32768,32]{2,1,0} slice(call.1815), slice={[0:1], [0:32768], [0:32]}
  reshape.1822 = f32[32768,32]{1,0} reshape(slice.1821)
  Arg_0.1803 = f32[32768,32]{1,0} parameter(0)
  slice.1816 = s32[1]{0} slice(Arg_4.1807), slice={[0:1]}
  reshape.1817 = s32[] reshape(slice.1816)
  broadcast.1818 = s32[32768]{0} broadcast(reshape.1817), dimensions={}
  add.1819 = s32[32768]{0} add(convert.1814, broadcast.1818)
  call.1820 = f32[32768,32]{1,0} call(Arg_0.1803, add.1819), to_apply=_roll_dynamic.1569
  multiply.1823 = f32[32768,32]{1,0} multiply(reshape.1822, call.1820)
  slice.1829 = f32[1,32768,32]{2,1,0} slice(call.1815), slice={[1:2], [0:32768], [0:32]}
  reshape.1830 = f32[32768,32]{1,0} reshape(slice.1829)
  slice.1824 = s32[1]{0} slice(Arg_4.1807), slice={[1:2]}
  reshape.1825 = s32[] reshape(slice.1824)
  broadcast.1826 = s32[32768]{0} broadcast(reshape.1825), dimensions={}
  add.1827 = s32[32768]{0} add(convert.1814, broadcast.1826)
  call.1828 = f32[32768,32]{1,0} call(Arg_0.1803, add.1827), to_apply=_roll_dynamic.1612
  multiply.1831 = f32[32768,32]{1,0} multiply(reshape.1830, call.1828)
  add.1832 = f32[32768,32]{1,0} add(multiply.1823, multiply.1831)
  slice.1838 = f32[1,32768,32]{2,1,0} slice(call.1815), slice={[2:3], [0:32768], [0:32]}
  reshape.1839 = f32[32768,32]{1,0} reshape(slice.1838)
  slice.1833 = s32[1]{0} slice(Arg_4.1807), slice={[2:3]}
  reshape.1834 = s32[] reshape(slice.1833)
  broadcast.1835 = s32[32768]{0} broadcast(reshape.1834), dimensions={}
  add.1836 = s32[32768]{0} add(convert.1814, broadcast.1835)
  call.1837 = f32[32768,32]{1,0} call(Arg_0.1803, add.1836), to_apply=_roll_dynamic.1655
  multiply.1840 = f32[32768,32]{1,0} multiply(reshape.1839, call.1837)
  add.1841 = f32[32768,32]{1,0} add(add.1832, multiply.1840)
  slice.1847 = f32[1,32768,32]{2,1,0} slice(call.1815), slice={[3:4], [0:32768], [0:32]}
  reshape.1848 = f32[32768,32]{1,0} reshape(slice.1847)
  slice.1842 = s32[1]{0} slice(Arg_4.1807), slice={[3:4]}
  reshape.1843 = s32[] reshape(slice.1842)
  broadcast.1844 = s32[32768]{0} broadcast(reshape.1843), dimensions={}
  add.1845 = s32[32768]{0} add(convert.1814, broadcast.1844)
  call.1846 = f32[32768,32]{1,0} call(Arg_0.1803, add.1845), to_apply=_roll_dynamic.1698
  multiply.1849 = f32[32768,32]{1,0} multiply(reshape.1848, call.1846)
  add.1850 = f32[32768,32]{1,0} add(add.1841, multiply.1849)
  slice.1856 = f32[1,32768,32]{2,1,0} slice(call.1815), slice={[4:5], [0:32768], [0:32]}
  reshape.1857 = f32[32768,32]{1,0} reshape(slice.1856)
  slice.1851 = s32[1]{0} slice(Arg_4.1807), slice={[4:5]}
  reshape.1852 = s32[] reshape(slice.1851)
  broadcast.1853 = s32[32768]{0} broadcast(reshape.1852), dimensions={}
  add.1854 = s32[32768]{0} add(convert.1814, broadcast.1853)
  call.1855 = f32[32768,32]{1,0} call(Arg_0.1803, add.1854), to_apply=_roll_dynamic.1741
  multiply.1858 = f32[32768,32]{1,0} multiply(reshape.1857, call.1855)
  add.1859 = f32[32768,32]{1,0} add(add.1850, multiply.1858)
  slice.1865 = f32[1,32768,32]{2,1,0} slice(call.1815), slice={[5:6], [0:32768], [0:32]}
  reshape.1866 = f32[32768,32]{1,0} reshape(slice.1865)
  slice.1860 = s32[1]{0} slice(Arg_4.1807), slice={[5:6]}
  reshape.1861 = s32[] reshape(slice.1860)
  broadcast.1862 = s32[32768]{0} broadcast(reshape.1861), dimensions={}
  add.1863 = s32[32768]{0} add(convert.1814, broadcast.1862)
  call.1864 = f32[32768,32]{1,0} call(Arg_0.1803, add.1863), to_apply=_roll_dynamic.1784
  multiply.1867 = f32[32768,32]{1,0} multiply(reshape.1866, call.1864)
  ROOT add.1868 = f32[32768,32]{1,0} add(add.1859, multiply.1867)
}

_where.1877 {
  Arg_0.1878 = pred[] parameter(0)
  Arg_1.1879 = s32[] parameter(1)
  Arg_2.1880 = s32[] parameter(2)
  ROOT select.1881 = s32[] select(Arg_0.1878, Arg_1.1879, Arg_2.1880)
}

remainder.1882 {
  Arg_0.1883 = s32[32768]{0} parameter(0)
  Arg_1.1884 = s32[] parameter(1)
  constant.1888 = s32[] constant(0)
  compare.1889 = pred[] compare(Arg_1.1884, constant.1888), direction=EQ
  constant.1887 = s32[] constant(1)
  call.1890 = s32[] call(compare.1889, constant.1887, Arg_1.1884), to_apply=_where.1877
  broadcast.1891 = s32[32768]{0} broadcast(call.1890), dimensions={}
  remainder.1892 = s32[32768]{0} remainder(Arg_0.1883, broadcast.1891)
  constant.1885 = s32[] constant(0)
  broadcast.1886 = s32[32768]{0} broadcast(constant.1885), dimensions={}
  compare.1894 = pred[32768]{0} compare(remainder.1892, broadcast.1886), direction=LT
  compare.1895 = pred[] compare(call.1890, constant.1888), direction=LT
  broadcast.1896 = pred[32768]{0} broadcast(compare.1895), dimensions={}
  compare.1897 = pred[32768]{0} compare(compare.1894, broadcast.1896), direction=NE
  compare.1893 = pred[32768]{0} compare(remainder.1892, broadcast.1886), direction=NE
  and.1898 = pred[32768]{0} and(compare.1897, compare.1893)
  broadcast.1899 = s32[32768]{0} broadcast(call.1890), dimensions={}
  add.1900 = s32[32768]{0} add(remainder.1892, broadcast.1899)
  ROOT select.1901 = s32[32768]{0} select(and.1898, add.1900, remainder.1892)
}

_roll_dynamic.1902 {
  Arg_0.1903 = f32[32768,32]{1,0} parameter(0)
  concatenate.1913 = f32[32768,64]{1,0} concatenate(Arg_0.1903, Arg_0.1903), dimensions={1}
  constant.1909 = s32[] constant(32)
  broadcast.1910 = s32[32768]{0} broadcast(constant.1909), dimensions={}
  Arg_1.1904 = s32[32768]{0} parameter(1)
  constant.1911 = s32[] constant(32)
  call.1912 = s32[32768]{0} call(Arg_1.1904, constant.1911), to_apply=remainder.1882
  subtract.1914 = s32[32768]{0} subtract(broadcast.1910, call.1912)
  constant.1907 = s32[] constant(0)
  broadcast.1908 = s32[32768]{0} broadcast(constant.1907), dimensions={}
  compare.1915 = pred[32768]{0} compare(subtract.1914, broadcast.1908), direction=LT
  constant.1905 = s32[] constant(64)
  broadcast.1906 = s32[32768]{0} broadcast(constant.1905), dimensions={}
  add.1916 = s32[32768]{0} add(subtract.1914, broadcast.1906)
  select.1917 = s32[32768]{0} select(compare.1915, add.1916, subtract.1914)
  reshape.1918 = s32[32768,1]{1,0} reshape(select.1917)
  ROOT gather.1919 = f32[32768,32]{1,0} gather(concatenate.1913, reshape.1918), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1920 {
  Arg_0.1921 = pred[] parameter(0)
  Arg_1.1922 = s32[] parameter(1)
  Arg_2.1923 = s32[] parameter(2)
  ROOT select.1924 = s32[] select(Arg_0.1921, Arg_1.1922, Arg_2.1923)
}

remainder.1925 {
  Arg_0.1926 = s32[32768]{0} parameter(0)
  Arg_1.1927 = s32[] parameter(1)
  constant.1931 = s32[] constant(0)
  compare.1932 = pred[] compare(Arg_1.1927, constant.1931), direction=EQ
  constant.1930 = s32[] constant(1)
  call.1933 = s32[] call(compare.1932, constant.1930, Arg_1.1927), to_apply=_where.1920
  broadcast.1934 = s32[32768]{0} broadcast(call.1933), dimensions={}
  remainder.1935 = s32[32768]{0} remainder(Arg_0.1926, broadcast.1934)
  constant.1928 = s32[] constant(0)
  broadcast.1929 = s32[32768]{0} broadcast(constant.1928), dimensions={}
  compare.1937 = pred[32768]{0} compare(remainder.1935, broadcast.1929), direction=LT
  compare.1938 = pred[] compare(call.1933, constant.1931), direction=LT
  broadcast.1939 = pred[32768]{0} broadcast(compare.1938), dimensions={}
  compare.1940 = pred[32768]{0} compare(compare.1937, broadcast.1939), direction=NE
  compare.1936 = pred[32768]{0} compare(remainder.1935, broadcast.1929), direction=NE
  and.1941 = pred[32768]{0} and(compare.1940, compare.1936)
  broadcast.1942 = s32[32768]{0} broadcast(call.1933), dimensions={}
  add.1943 = s32[32768]{0} add(remainder.1935, broadcast.1942)
  ROOT select.1944 = s32[32768]{0} select(and.1941, add.1943, remainder.1935)
}

_roll_dynamic.1945 {
  Arg_0.1946 = f32[32768,32]{1,0} parameter(0)
  concatenate.1956 = f32[32768,64]{1,0} concatenate(Arg_0.1946, Arg_0.1946), dimensions={1}
  constant.1952 = s32[] constant(32)
  broadcast.1953 = s32[32768]{0} broadcast(constant.1952), dimensions={}
  Arg_1.1947 = s32[32768]{0} parameter(1)
  constant.1954 = s32[] constant(32)
  call.1955 = s32[32768]{0} call(Arg_1.1947, constant.1954), to_apply=remainder.1925
  subtract.1957 = s32[32768]{0} subtract(broadcast.1953, call.1955)
  constant.1950 = s32[] constant(0)
  broadcast.1951 = s32[32768]{0} broadcast(constant.1950), dimensions={}
  compare.1958 = pred[32768]{0} compare(subtract.1957, broadcast.1951), direction=LT
  constant.1948 = s32[] constant(64)
  broadcast.1949 = s32[32768]{0} broadcast(constant.1948), dimensions={}
  add.1959 = s32[32768]{0} add(subtract.1957, broadcast.1949)
  select.1960 = s32[32768]{0} select(compare.1958, add.1959, subtract.1957)
  reshape.1961 = s32[32768,1]{1,0} reshape(select.1960)
  ROOT gather.1962 = f32[32768,32]{1,0} gather(concatenate.1956, reshape.1961), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1963 {
  Arg_0.1964 = pred[] parameter(0)
  Arg_1.1965 = s32[] parameter(1)
  Arg_2.1966 = s32[] parameter(2)
  ROOT select.1967 = s32[] select(Arg_0.1964, Arg_1.1965, Arg_2.1966)
}

remainder.1968 {
  Arg_0.1969 = s32[32768]{0} parameter(0)
  Arg_1.1970 = s32[] parameter(1)
  constant.1974 = s32[] constant(0)
  compare.1975 = pred[] compare(Arg_1.1970, constant.1974), direction=EQ
  constant.1973 = s32[] constant(1)
  call.1976 = s32[] call(compare.1975, constant.1973, Arg_1.1970), to_apply=_where.1963
  broadcast.1977 = s32[32768]{0} broadcast(call.1976), dimensions={}
  remainder.1978 = s32[32768]{0} remainder(Arg_0.1969, broadcast.1977)
  constant.1971 = s32[] constant(0)
  broadcast.1972 = s32[32768]{0} broadcast(constant.1971), dimensions={}
  compare.1980 = pred[32768]{0} compare(remainder.1978, broadcast.1972), direction=LT
  compare.1981 = pred[] compare(call.1976, constant.1974), direction=LT
  broadcast.1982 = pred[32768]{0} broadcast(compare.1981), dimensions={}
  compare.1983 = pred[32768]{0} compare(compare.1980, broadcast.1982), direction=NE
  compare.1979 = pred[32768]{0} compare(remainder.1978, broadcast.1972), direction=NE
  and.1984 = pred[32768]{0} and(compare.1983, compare.1979)
  broadcast.1985 = s32[32768]{0} broadcast(call.1976), dimensions={}
  add.1986 = s32[32768]{0} add(remainder.1978, broadcast.1985)
  ROOT select.1987 = s32[32768]{0} select(and.1984, add.1986, remainder.1978)
}

_roll_dynamic.1988 {
  Arg_0.1989 = f32[32768,32]{1,0} parameter(0)
  concatenate.1999 = f32[32768,64]{1,0} concatenate(Arg_0.1989, Arg_0.1989), dimensions={1}
  constant.1995 = s32[] constant(32)
  broadcast.1996 = s32[32768]{0} broadcast(constant.1995), dimensions={}
  Arg_1.1990 = s32[32768]{0} parameter(1)
  constant.1997 = s32[] constant(32)
  call.1998 = s32[32768]{0} call(Arg_1.1990, constant.1997), to_apply=remainder.1968
  subtract.2000 = s32[32768]{0} subtract(broadcast.1996, call.1998)
  constant.1993 = s32[] constant(0)
  broadcast.1994 = s32[32768]{0} broadcast(constant.1993), dimensions={}
  compare.2001 = pred[32768]{0} compare(subtract.2000, broadcast.1994), direction=LT
  constant.1991 = s32[] constant(64)
  broadcast.1992 = s32[32768]{0} broadcast(constant.1991), dimensions={}
  add.2002 = s32[32768]{0} add(subtract.2000, broadcast.1992)
  select.2003 = s32[32768]{0} select(compare.2001, add.2002, subtract.2000)
  reshape.2004 = s32[32768,1]{1,0} reshape(select.2003)
  ROOT gather.2005 = f32[32768,32]{1,0} gather(concatenate.1999, reshape.2004), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2006 {
  Arg_0.2007 = pred[] parameter(0)
  Arg_1.2008 = s32[] parameter(1)
  Arg_2.2009 = s32[] parameter(2)
  ROOT select.2010 = s32[] select(Arg_0.2007, Arg_1.2008, Arg_2.2009)
}

remainder.2011 {
  Arg_0.2012 = s32[32768]{0} parameter(0)
  Arg_1.2013 = s32[] parameter(1)
  constant.2017 = s32[] constant(0)
  compare.2018 = pred[] compare(Arg_1.2013, constant.2017), direction=EQ
  constant.2016 = s32[] constant(1)
  call.2019 = s32[] call(compare.2018, constant.2016, Arg_1.2013), to_apply=_where.2006
  broadcast.2020 = s32[32768]{0} broadcast(call.2019), dimensions={}
  remainder.2021 = s32[32768]{0} remainder(Arg_0.2012, broadcast.2020)
  constant.2014 = s32[] constant(0)
  broadcast.2015 = s32[32768]{0} broadcast(constant.2014), dimensions={}
  compare.2023 = pred[32768]{0} compare(remainder.2021, broadcast.2015), direction=LT
  compare.2024 = pred[] compare(call.2019, constant.2017), direction=LT
  broadcast.2025 = pred[32768]{0} broadcast(compare.2024), dimensions={}
  compare.2026 = pred[32768]{0} compare(compare.2023, broadcast.2025), direction=NE
  compare.2022 = pred[32768]{0} compare(remainder.2021, broadcast.2015), direction=NE
  and.2027 = pred[32768]{0} and(compare.2026, compare.2022)
  broadcast.2028 = s32[32768]{0} broadcast(call.2019), dimensions={}
  add.2029 = s32[32768]{0} add(remainder.2021, broadcast.2028)
  ROOT select.2030 = s32[32768]{0} select(and.2027, add.2029, remainder.2021)
}

_roll_dynamic.2031 {
  Arg_0.2032 = f32[32768,32]{1,0} parameter(0)
  concatenate.2042 = f32[32768,64]{1,0} concatenate(Arg_0.2032, Arg_0.2032), dimensions={1}
  constant.2038 = s32[] constant(32)
  broadcast.2039 = s32[32768]{0} broadcast(constant.2038), dimensions={}
  Arg_1.2033 = s32[32768]{0} parameter(1)
  constant.2040 = s32[] constant(32)
  call.2041 = s32[32768]{0} call(Arg_1.2033, constant.2040), to_apply=remainder.2011
  subtract.2043 = s32[32768]{0} subtract(broadcast.2039, call.2041)
  constant.2036 = s32[] constant(0)
  broadcast.2037 = s32[32768]{0} broadcast(constant.2036), dimensions={}
  compare.2044 = pred[32768]{0} compare(subtract.2043, broadcast.2037), direction=LT
  constant.2034 = s32[] constant(64)
  broadcast.2035 = s32[32768]{0} broadcast(constant.2034), dimensions={}
  add.2045 = s32[32768]{0} add(subtract.2043, broadcast.2035)
  select.2046 = s32[32768]{0} select(compare.2044, add.2045, subtract.2043)
  reshape.2047 = s32[32768,1]{1,0} reshape(select.2046)
  ROOT gather.2048 = f32[32768,32]{1,0} gather(concatenate.2042, reshape.2047), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2049 {
  Arg_0.2050 = pred[] parameter(0)
  Arg_1.2051 = s32[] parameter(1)
  Arg_2.2052 = s32[] parameter(2)
  ROOT select.2053 = s32[] select(Arg_0.2050, Arg_1.2051, Arg_2.2052)
}

remainder.2054 {
  Arg_0.2055 = s32[32768]{0} parameter(0)
  Arg_1.2056 = s32[] parameter(1)
  constant.2060 = s32[] constant(0)
  compare.2061 = pred[] compare(Arg_1.2056, constant.2060), direction=EQ
  constant.2059 = s32[] constant(1)
  call.2062 = s32[] call(compare.2061, constant.2059, Arg_1.2056), to_apply=_where.2049
  broadcast.2063 = s32[32768]{0} broadcast(call.2062), dimensions={}
  remainder.2064 = s32[32768]{0} remainder(Arg_0.2055, broadcast.2063)
  constant.2057 = s32[] constant(0)
  broadcast.2058 = s32[32768]{0} broadcast(constant.2057), dimensions={}
  compare.2066 = pred[32768]{0} compare(remainder.2064, broadcast.2058), direction=LT
  compare.2067 = pred[] compare(call.2062, constant.2060), direction=LT
  broadcast.2068 = pred[32768]{0} broadcast(compare.2067), dimensions={}
  compare.2069 = pred[32768]{0} compare(compare.2066, broadcast.2068), direction=NE
  compare.2065 = pred[32768]{0} compare(remainder.2064, broadcast.2058), direction=NE
  and.2070 = pred[32768]{0} and(compare.2069, compare.2065)
  broadcast.2071 = s32[32768]{0} broadcast(call.2062), dimensions={}
  add.2072 = s32[32768]{0} add(remainder.2064, broadcast.2071)
  ROOT select.2073 = s32[32768]{0} select(and.2070, add.2072, remainder.2064)
}

_roll_dynamic.2074 {
  Arg_0.2075 = f32[32768,32]{1,0} parameter(0)
  concatenate.2085 = f32[32768,64]{1,0} concatenate(Arg_0.2075, Arg_0.2075), dimensions={1}
  constant.2081 = s32[] constant(32)
  broadcast.2082 = s32[32768]{0} broadcast(constant.2081), dimensions={}
  Arg_1.2076 = s32[32768]{0} parameter(1)
  constant.2083 = s32[] constant(32)
  call.2084 = s32[32768]{0} call(Arg_1.2076, constant.2083), to_apply=remainder.2054
  subtract.2086 = s32[32768]{0} subtract(broadcast.2082, call.2084)
  constant.2079 = s32[] constant(0)
  broadcast.2080 = s32[32768]{0} broadcast(constant.2079), dimensions={}
  compare.2087 = pred[32768]{0} compare(subtract.2086, broadcast.2080), direction=LT
  constant.2077 = s32[] constant(64)
  broadcast.2078 = s32[32768]{0} broadcast(constant.2077), dimensions={}
  add.2088 = s32[32768]{0} add(subtract.2086, broadcast.2078)
  select.2089 = s32[32768]{0} select(compare.2087, add.2088, subtract.2086)
  reshape.2090 = s32[32768,1]{1,0} reshape(select.2089)
  ROOT gather.2091 = f32[32768,32]{1,0} gather(concatenate.2085, reshape.2090), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2092 {
  Arg_0.2093 = pred[] parameter(0)
  Arg_1.2094 = s32[] parameter(1)
  Arg_2.2095 = s32[] parameter(2)
  ROOT select.2096 = s32[] select(Arg_0.2093, Arg_1.2094, Arg_2.2095)
}

remainder.2097 {
  Arg_0.2098 = s32[32768]{0} parameter(0)
  Arg_1.2099 = s32[] parameter(1)
  constant.2103 = s32[] constant(0)
  compare.2104 = pred[] compare(Arg_1.2099, constant.2103), direction=EQ
  constant.2102 = s32[] constant(1)
  call.2105 = s32[] call(compare.2104, constant.2102, Arg_1.2099), to_apply=_where.2092
  broadcast.2106 = s32[32768]{0} broadcast(call.2105), dimensions={}
  remainder.2107 = s32[32768]{0} remainder(Arg_0.2098, broadcast.2106)
  constant.2100 = s32[] constant(0)
  broadcast.2101 = s32[32768]{0} broadcast(constant.2100), dimensions={}
  compare.2109 = pred[32768]{0} compare(remainder.2107, broadcast.2101), direction=LT
  compare.2110 = pred[] compare(call.2105, constant.2103), direction=LT
  broadcast.2111 = pred[32768]{0} broadcast(compare.2110), dimensions={}
  compare.2112 = pred[32768]{0} compare(compare.2109, broadcast.2111), direction=NE
  compare.2108 = pred[32768]{0} compare(remainder.2107, broadcast.2101), direction=NE
  and.2113 = pred[32768]{0} and(compare.2112, compare.2108)
  broadcast.2114 = s32[32768]{0} broadcast(call.2105), dimensions={}
  add.2115 = s32[32768]{0} add(remainder.2107, broadcast.2114)
  ROOT select.2116 = s32[32768]{0} select(and.2113, add.2115, remainder.2107)
}

_roll_dynamic.2117 {
  Arg_0.2118 = f32[32768,32]{1,0} parameter(0)
  concatenate.2128 = f32[32768,64]{1,0} concatenate(Arg_0.2118, Arg_0.2118), dimensions={1}
  constant.2124 = s32[] constant(32)
  broadcast.2125 = s32[32768]{0} broadcast(constant.2124), dimensions={}
  Arg_1.2119 = s32[32768]{0} parameter(1)
  constant.2126 = s32[] constant(32)
  call.2127 = s32[32768]{0} call(Arg_1.2119, constant.2126), to_apply=remainder.2097
  subtract.2129 = s32[32768]{0} subtract(broadcast.2125, call.2127)
  constant.2122 = s32[] constant(0)
  broadcast.2123 = s32[32768]{0} broadcast(constant.2122), dimensions={}
  compare.2130 = pred[32768]{0} compare(subtract.2129, broadcast.2123), direction=LT
  constant.2120 = s32[] constant(64)
  broadcast.2121 = s32[32768]{0} broadcast(constant.2120), dimensions={}
  add.2131 = s32[32768]{0} add(subtract.2129, broadcast.2121)
  select.2132 = s32[32768]{0} select(compare.2130, add.2131, subtract.2129)
  reshape.2133 = s32[32768,1]{1,0} reshape(select.2132)
  ROOT gather.2134 = f32[32768,32]{1,0} gather(concatenate.2128, reshape.2133), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.2135 {
  Arg_0.2136 = f32[32768,32]{1,0} parameter(0)
  Arg_1.2137 = f32[32768]{0} parameter(1)
  Arg_2.2138 = f32[] parameter(2)
  broadcast.2165 = f32[32768]{0} broadcast(Arg_2.2138), dimensions={}
  multiply.2166 = f32[32768]{0} multiply(Arg_1.2137, broadcast.2165)
  Arg_3.2139 = f32[] parameter(3)
  broadcast.2167 = f32[32768]{0} broadcast(Arg_3.2139), dimensions={}
  divide.2168 = f32[32768]{0} divide(multiply.2166, broadcast.2167)
  floor.2169 = f32[32768]{0} floor(divide.2168)
  convert.2171 = s32[32768]{0} convert(floor.2169)
  Arg_4.2140 = s32[6]{0} parameter(4)
  slice.2234 = s32[1]{0} slice(Arg_4.2140), slice={[0:1]}
  reshape.2235 = s32[] reshape(slice.2234)
  broadcast.2236 = s32[32768]{0} broadcast(reshape.2235), dimensions={}
  add.2237 = s32[32768]{0} add(convert.2171, broadcast.2236)
  call.2238 = f32[32768,32]{1,0} call(Arg_0.2136, add.2237), to_apply=_roll_dynamic.1902
  subtract.2170 = f32[32768]{0} subtract(divide.2168, floor.2169)
  constant.2163 = f32[] constant(20)
  broadcast.2164 = f32[32768]{0} broadcast(constant.2163), dimensions={}
  divide.2176 = f32[32768]{0} divide(subtract.2170, broadcast.2164)
  multiply.2172 = f32[32768]{0} multiply(subtract.2170, subtract.2170)
  constant.2161 = f32[] constant(24)
  broadcast.2162 = f32[32768]{0} broadcast(constant.2161), dimensions={}
  divide.2177 = f32[32768]{0} divide(multiply.2172, broadcast.2162)
  subtract.2178 = f32[32768]{0} subtract(divide.2176, divide.2177)
  multiply.2173 = f32[32768]{0} multiply(multiply.2172, subtract.2170)
  divide.2179 = f32[32768]{0} divide(multiply.2173, broadcast.2162)
  subtract.2180 = f32[32768]{0} subtract(subtract.2178, divide.2179)
  multiply.2174 = f32[32768]{0} multiply(multiply.2173, subtract.2170)
  divide.2181 = f32[32768]{0} divide(multiply.2174, broadcast.2162)
  add.2182 = f32[32768]{0} add(subtract.2180, divide.2181)
  multiply.2175 = f32[32768]{0} multiply(multiply.2174, subtract.2170)
  constant.2159 = f32[] constant(120)
  broadcast.2160 = f32[32768]{0} broadcast(constant.2159), dimensions={}
  divide.2183 = f32[32768]{0} divide(multiply.2175, broadcast.2160)
  subtract.2184 = f32[32768]{0} subtract(add.2182, divide.2183)
  reshape.2239 = f32[32768,1]{1,0} reshape(subtract.2184)
  broadcast.2240 = f32[32768,1]{1,0} broadcast(reshape.2239), dimensions={0,1}
  reshape.2241 = f32[32768]{0} reshape(broadcast.2240)
  broadcast.2242 = f32[32768,32]{1,0} broadcast(reshape.2241), dimensions={0}
  multiply.2243 = f32[32768,32]{1,0} multiply(call.2238, broadcast.2242)
  slice.2244 = s32[1]{0} slice(Arg_4.2140), slice={[1:2]}
  reshape.2245 = s32[] reshape(slice.2244)
  broadcast.2246 = s32[32768]{0} broadcast(reshape.2245), dimensions={}
  add.2247 = s32[32768]{0} add(convert.2171, broadcast.2246)
  call.2248 = f32[32768,32]{1,0} call(Arg_0.2136, add.2247), to_apply=_roll_dynamic.1945
  constant.2157 = f32[] constant(2)
  broadcast.2158 = f32[32768]{0} broadcast(constant.2157), dimensions={}
  divide.2185 = f32[32768]{0} divide(subtract.2170, broadcast.2158)
  negate.2186 = f32[32768]{0} negate(divide.2185)
  multiply.2187 = f32[32768]{0} multiply(multiply.2172, broadcast.2158)
  constant.2155 = f32[] constant(3)
  broadcast.2156 = f32[32768]{0} broadcast(constant.2155), dimensions={}
  divide.2188 = f32[32768]{0} divide(multiply.2187, broadcast.2156)
  add.2189 = f32[32768]{0} add(negate.2186, divide.2188)
  divide.2190 = f32[32768]{0} divide(multiply.2173, broadcast.2162)
  subtract.2191 = f32[32768]{0} subtract(add.2189, divide.2190)
  constant.2153 = f32[] constant(6)
  broadcast.2154 = f32[32768]{0} broadcast(constant.2153), dimensions={}
  divide.2192 = f32[32768]{0} divide(multiply.2174, broadcast.2154)
  subtract.2193 = f32[32768]{0} subtract(subtract.2191, divide.2192)
  divide.2194 = f32[32768]{0} divide(multiply.2175, broadcast.2162)
  add.2195 = f32[32768]{0} add(subtract.2193, divide.2194)
  reshape.2249 = f32[32768,1]{1,0} reshape(add.2195)
  broadcast.2250 = f32[32768,1]{1,0} broadcast(reshape.2249), dimensions={0,1}
  reshape.2251 = f32[32768]{0} reshape(broadcast.2250)
  broadcast.2252 = f32[32768,32]{1,0} broadcast(reshape.2251), dimensions={0}
  multiply.2253 = f32[32768,32]{1,0} multiply(call.2248, broadcast.2252)
  add.2254 = f32[32768,32]{1,0} add(multiply.2243, multiply.2253)
  slice.2255 = s32[1]{0} slice(Arg_4.2140), slice={[2:3]}
  reshape.2256 = s32[] reshape(slice.2255)
  broadcast.2257 = s32[32768]{0} broadcast(reshape.2256), dimensions={}
  add.2258 = s32[32768]{0} add(convert.2171, broadcast.2257)
  call.2259 = f32[32768,32]{1,0} call(Arg_0.2136, add.2258), to_apply=_roll_dynamic.1988
  constant.2151 = f32[] constant(1)
  broadcast.2152 = f32[32768]{0} broadcast(constant.2151), dimensions={}
  divide.2196 = f32[32768]{0} divide(subtract.2170, broadcast.2156)
  subtract.2197 = f32[32768]{0} subtract(broadcast.2152, divide.2196)
  constant.2149 = f32[] constant(5)
  broadcast.2150 = f32[32768]{0} broadcast(constant.2149), dimensions={}
  multiply.2198 = f32[32768]{0} multiply(multiply.2172, broadcast.2150)
  constant.2147 = f32[] constant(4)
  broadcast.2148 = f32[32768]{0} broadcast(constant.2147), dimensions={}
  divide.2199 = f32[32768]{0} divide(multiply.2198, broadcast.2148)
  subtract.2200 = f32[32768]{0} subtract(subtract.2197, divide.2199)
  multiply.2201 = f32[32768]{0} multiply(multiply.2173, broadcast.2150)
  constant.2145 = f32[] constant(12)
  broadcast.2146 = f32[32768]{0} broadcast(constant.2145), dimensions={}
  divide.2202 = f32[32768]{0} divide(multiply.2201, broadcast.2146)
  add.2203 = f32[32768]{0} add(subtract.2200, divide.2202)
  divide.2204 = f32[32768]{0} divide(multiply.2174, broadcast.2148)
  add.2205 = f32[32768]{0} add(add.2203, divide.2204)
  divide.2206 = f32[32768]{0} divide(multiply.2175, broadcast.2146)
  subtract.2207 = f32[32768]{0} subtract(add.2205, divide.2206)
  reshape.2260 = f32[32768,1]{1,0} reshape(subtract.2207)
  broadcast.2261 = f32[32768,1]{1,0} broadcast(reshape.2260), dimensions={0,1}
  reshape.2262 = f32[32768]{0} reshape(broadcast.2261)
  broadcast.2263 = f32[32768,32]{1,0} broadcast(reshape.2262), dimensions={0}
  multiply.2264 = f32[32768,32]{1,0} multiply(call.2259, broadcast.2263)
  add.2265 = f32[32768,32]{1,0} add(add.2254, multiply.2264)
  slice.2266 = s32[1]{0} slice(Arg_4.2140), slice={[3:4]}
  reshape.2267 = s32[] reshape(slice.2266)
  broadcast.2268 = s32[32768]{0} broadcast(reshape.2267), dimensions={}
  add.2269 = s32[32768]{0} add(convert.2171, broadcast.2268)
  call.2270 = f32[32768,32]{1,0} call(Arg_0.2136, add.2269), to_apply=_roll_dynamic.2031
  multiply.2208 = f32[32768]{0} multiply(multiply.2172, broadcast.2158)
  divide.2209 = f32[32768]{0} divide(multiply.2208, broadcast.2156)
  add.2210 = f32[32768]{0} add(subtract.2170, divide.2209)
  constant.2143 = f32[] constant(7)
  broadcast.2144 = f32[32768]{0} broadcast(constant.2143), dimensions={}
  multiply.2211 = f32[32768]{0} multiply(multiply.2173, broadcast.2144)
  divide.2212 = f32[32768]{0} divide(multiply.2211, broadcast.2146)
  subtract.2213 = f32[32768]{0} subtract(add.2210, divide.2212)
  divide.2214 = f32[32768]{0} divide(multiply.2174, broadcast.2154)
  subtract.2215 = f32[32768]{0} subtract(subtract.2213, divide.2214)
  divide.2216 = f32[32768]{0} divide(multiply.2175, broadcast.2146)
  add.2217 = f32[32768]{0} add(subtract.2215, divide.2216)
  reshape.2271 = f32[32768,1]{1,0} reshape(add.2217)
  broadcast.2272 = f32[32768,1]{1,0} broadcast(reshape.2271), dimensions={0,1}
  reshape.2273 = f32[32768]{0} reshape(broadcast.2272)
  broadcast.2274 = f32[32768,32]{1,0} broadcast(reshape.2273), dimensions={0}
  multiply.2275 = f32[32768,32]{1,0} multiply(call.2270, broadcast.2274)
  add.2276 = f32[32768,32]{1,0} add(add.2265, multiply.2275)
  slice.2277 = s32[1]{0} slice(Arg_4.2140), slice={[4:5]}
  reshape.2278 = s32[] reshape(slice.2277)
  broadcast.2279 = s32[32768]{0} broadcast(reshape.2278), dimensions={}
  add.2280 = s32[32768]{0} add(convert.2171, broadcast.2279)
  call.2281 = f32[32768,32]{1,0} call(Arg_0.2136, add.2280), to_apply=_roll_dynamic.2074
  divide.2218 = f32[32768]{0} divide(subtract.2170, broadcast.2148)
  negate.2219 = f32[32768]{0} negate(divide.2218)
  divide.2220 = f32[32768]{0} divide(multiply.2172, broadcast.2162)
  subtract.2221 = f32[32768]{0} subtract(negate.2219, divide.2220)
  multiply.2222 = f32[32768]{0} multiply(multiply.2173, broadcast.2144)
  divide.2223 = f32[32768]{0} divide(multiply.2222, broadcast.2162)
  add.2224 = f32[32768]{0} add(subtract.2221, divide.2223)
  divide.2225 = f32[32768]{0} divide(multiply.2174, broadcast.2162)
  add.2226 = f32[32768]{0} add(add.2224, divide.2225)
  divide.2227 = f32[32768]{0} divide(multiply.2175, broadcast.2162)
  subtract.2228 = f32[32768]{0} subtract(add.2226, divide.2227)
  reshape.2282 = f32[32768,1]{1,0} reshape(subtract.2228)
  broadcast.2283 = f32[32768,1]{1,0} broadcast(reshape.2282), dimensions={0,1}
  reshape.2284 = f32[32768]{0} reshape(broadcast.2283)
  broadcast.2285 = f32[32768,32]{1,0} broadcast(reshape.2284), dimensions={0}
  multiply.2286 = f32[32768,32]{1,0} multiply(call.2281, broadcast.2285)
  add.2287 = f32[32768,32]{1,0} add(add.2276, multiply.2286)
  slice.2288 = s32[1]{0} slice(Arg_4.2140), slice={[5:6]}
  reshape.2289 = s32[] reshape(slice.2288)
  broadcast.2290 = s32[32768]{0} broadcast(reshape.2289), dimensions={}
  add.2291 = s32[32768]{0} add(convert.2171, broadcast.2290)
  call.2292 = f32[32768,32]{1,0} call(Arg_0.2136, add.2291), to_apply=_roll_dynamic.2117
  constant.2141 = f32[] constant(30)
  broadcast.2142 = f32[32768]{0} broadcast(constant.2141), dimensions={}
  divide.2229 = f32[32768]{0} divide(subtract.2170, broadcast.2142)
  divide.2230 = f32[32768]{0} divide(multiply.2173, broadcast.2162)
  subtract.2231 = f32[32768]{0} subtract(divide.2229, divide.2230)
  divide.2232 = f32[32768]{0} divide(multiply.2175, broadcast.2160)
  add.2233 = f32[32768]{0} add(subtract.2231, divide.2232)
  reshape.2293 = f32[32768,1]{1,0} reshape(add.2233)
  broadcast.2294 = f32[32768,1]{1,0} broadcast(reshape.2293), dimensions={0,1}
  reshape.2295 = f32[32768]{0} reshape(broadcast.2294)
  broadcast.2296 = f32[32768,32]{1,0} broadcast(reshape.2295), dimensions={0}
  multiply.2297 = f32[32768,32]{1,0} multiply(call.2292, broadcast.2296)
  ROOT add.2298 = f32[32768,32]{1,0} add(add.2287, multiply.2297)
}

_where.2307 {
  Arg_0.2308 = pred[] parameter(0)
  Arg_1.2309 = s32[] parameter(1)
  Arg_2.2310 = s32[] parameter(2)
  ROOT select.2311 = s32[] select(Arg_0.2308, Arg_1.2309, Arg_2.2310)
}

remainder.2312 {
  Arg_0.2313 = s32[32768]{0} parameter(0)
  Arg_1.2314 = s32[] parameter(1)
  constant.2318 = s32[] constant(0)
  compare.2319 = pred[] compare(Arg_1.2314, constant.2318), direction=EQ
  constant.2317 = s32[] constant(1)
  call.2320 = s32[] call(compare.2319, constant.2317, Arg_1.2314), to_apply=_where.2307
  broadcast.2321 = s32[32768]{0} broadcast(call.2320), dimensions={}
  remainder.2322 = s32[32768]{0} remainder(Arg_0.2313, broadcast.2321)
  constant.2315 = s32[] constant(0)
  broadcast.2316 = s32[32768]{0} broadcast(constant.2315), dimensions={}
  compare.2324 = pred[32768]{0} compare(remainder.2322, broadcast.2316), direction=LT
  compare.2325 = pred[] compare(call.2320, constant.2318), direction=LT
  broadcast.2326 = pred[32768]{0} broadcast(compare.2325), dimensions={}
  compare.2327 = pred[32768]{0} compare(compare.2324, broadcast.2326), direction=NE
  compare.2323 = pred[32768]{0} compare(remainder.2322, broadcast.2316), direction=NE
  and.2328 = pred[32768]{0} and(compare.2327, compare.2323)
  broadcast.2329 = s32[32768]{0} broadcast(call.2320), dimensions={}
  add.2330 = s32[32768]{0} add(remainder.2322, broadcast.2329)
  ROOT select.2331 = s32[32768]{0} select(and.2328, add.2330, remainder.2322)
}

_roll_dynamic.2332 {
  Arg_0.2333 = f32[32768,32]{1,0} parameter(0)
  concatenate.2343 = f32[32768,64]{1,0} concatenate(Arg_0.2333, Arg_0.2333), dimensions={1}
  constant.2339 = s32[] constant(32)
  broadcast.2340 = s32[32768]{0} broadcast(constant.2339), dimensions={}
  Arg_1.2334 = s32[32768]{0} parameter(1)
  constant.2341 = s32[] constant(32)
  call.2342 = s32[32768]{0} call(Arg_1.2334, constant.2341), to_apply=remainder.2312
  subtract.2344 = s32[32768]{0} subtract(broadcast.2340, call.2342)
  constant.2337 = s32[] constant(0)
  broadcast.2338 = s32[32768]{0} broadcast(constant.2337), dimensions={}
  compare.2345 = pred[32768]{0} compare(subtract.2344, broadcast.2338), direction=LT
  constant.2335 = s32[] constant(64)
  broadcast.2336 = s32[32768]{0} broadcast(constant.2335), dimensions={}
  add.2346 = s32[32768]{0} add(subtract.2344, broadcast.2336)
  select.2347 = s32[32768]{0} select(compare.2345, add.2346, subtract.2344)
  reshape.2348 = s32[32768,1]{1,0} reshape(select.2347)
  ROOT gather.2349 = f32[32768,32]{1,0} gather(concatenate.2343, reshape.2348), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2350 {
  Arg_0.2351 = pred[] parameter(0)
  Arg_1.2352 = s32[] parameter(1)
  Arg_2.2353 = s32[] parameter(2)
  ROOT select.2354 = s32[] select(Arg_0.2351, Arg_1.2352, Arg_2.2353)
}

remainder.2355 {
  Arg_0.2356 = s32[32768]{0} parameter(0)
  Arg_1.2357 = s32[] parameter(1)
  constant.2361 = s32[] constant(0)
  compare.2362 = pred[] compare(Arg_1.2357, constant.2361), direction=EQ
  constant.2360 = s32[] constant(1)
  call.2363 = s32[] call(compare.2362, constant.2360, Arg_1.2357), to_apply=_where.2350
  broadcast.2364 = s32[32768]{0} broadcast(call.2363), dimensions={}
  remainder.2365 = s32[32768]{0} remainder(Arg_0.2356, broadcast.2364)
  constant.2358 = s32[] constant(0)
  broadcast.2359 = s32[32768]{0} broadcast(constant.2358), dimensions={}
  compare.2367 = pred[32768]{0} compare(remainder.2365, broadcast.2359), direction=LT
  compare.2368 = pred[] compare(call.2363, constant.2361), direction=LT
  broadcast.2369 = pred[32768]{0} broadcast(compare.2368), dimensions={}
  compare.2370 = pred[32768]{0} compare(compare.2367, broadcast.2369), direction=NE
  compare.2366 = pred[32768]{0} compare(remainder.2365, broadcast.2359), direction=NE
  and.2371 = pred[32768]{0} and(compare.2370, compare.2366)
  broadcast.2372 = s32[32768]{0} broadcast(call.2363), dimensions={}
  add.2373 = s32[32768]{0} add(remainder.2365, broadcast.2372)
  ROOT select.2374 = s32[32768]{0} select(and.2371, add.2373, remainder.2365)
}

_roll_dynamic.2375 {
  Arg_0.2376 = f32[32768,32]{1,0} parameter(0)
  concatenate.2386 = f32[32768,64]{1,0} concatenate(Arg_0.2376, Arg_0.2376), dimensions={1}
  constant.2382 = s32[] constant(32)
  broadcast.2383 = s32[32768]{0} broadcast(constant.2382), dimensions={}
  Arg_1.2377 = s32[32768]{0} parameter(1)
  constant.2384 = s32[] constant(32)
  call.2385 = s32[32768]{0} call(Arg_1.2377, constant.2384), to_apply=remainder.2355
  subtract.2387 = s32[32768]{0} subtract(broadcast.2383, call.2385)
  constant.2380 = s32[] constant(0)
  broadcast.2381 = s32[32768]{0} broadcast(constant.2380), dimensions={}
  compare.2388 = pred[32768]{0} compare(subtract.2387, broadcast.2381), direction=LT
  constant.2378 = s32[] constant(64)
  broadcast.2379 = s32[32768]{0} broadcast(constant.2378), dimensions={}
  add.2389 = s32[32768]{0} add(subtract.2387, broadcast.2379)
  select.2390 = s32[32768]{0} select(compare.2388, add.2389, subtract.2387)
  reshape.2391 = s32[32768,1]{1,0} reshape(select.2390)
  ROOT gather.2392 = f32[32768,32]{1,0} gather(concatenate.2386, reshape.2391), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2393 {
  Arg_0.2394 = pred[] parameter(0)
  Arg_1.2395 = s32[] parameter(1)
  Arg_2.2396 = s32[] parameter(2)
  ROOT select.2397 = s32[] select(Arg_0.2394, Arg_1.2395, Arg_2.2396)
}

remainder.2398 {
  Arg_0.2399 = s32[32768]{0} parameter(0)
  Arg_1.2400 = s32[] parameter(1)
  constant.2404 = s32[] constant(0)
  compare.2405 = pred[] compare(Arg_1.2400, constant.2404), direction=EQ
  constant.2403 = s32[] constant(1)
  call.2406 = s32[] call(compare.2405, constant.2403, Arg_1.2400), to_apply=_where.2393
  broadcast.2407 = s32[32768]{0} broadcast(call.2406), dimensions={}
  remainder.2408 = s32[32768]{0} remainder(Arg_0.2399, broadcast.2407)
  constant.2401 = s32[] constant(0)
  broadcast.2402 = s32[32768]{0} broadcast(constant.2401), dimensions={}
  compare.2410 = pred[32768]{0} compare(remainder.2408, broadcast.2402), direction=LT
  compare.2411 = pred[] compare(call.2406, constant.2404), direction=LT
  broadcast.2412 = pred[32768]{0} broadcast(compare.2411), dimensions={}
  compare.2413 = pred[32768]{0} compare(compare.2410, broadcast.2412), direction=NE
  compare.2409 = pred[32768]{0} compare(remainder.2408, broadcast.2402), direction=NE
  and.2414 = pred[32768]{0} and(compare.2413, compare.2409)
  broadcast.2415 = s32[32768]{0} broadcast(call.2406), dimensions={}
  add.2416 = s32[32768]{0} add(remainder.2408, broadcast.2415)
  ROOT select.2417 = s32[32768]{0} select(and.2414, add.2416, remainder.2408)
}

_roll_dynamic.2418 {
  Arg_0.2419 = f32[32768,32]{1,0} parameter(0)
  concatenate.2429 = f32[32768,64]{1,0} concatenate(Arg_0.2419, Arg_0.2419), dimensions={1}
  constant.2425 = s32[] constant(32)
  broadcast.2426 = s32[32768]{0} broadcast(constant.2425), dimensions={}
  Arg_1.2420 = s32[32768]{0} parameter(1)
  constant.2427 = s32[] constant(32)
  call.2428 = s32[32768]{0} call(Arg_1.2420, constant.2427), to_apply=remainder.2398
  subtract.2430 = s32[32768]{0} subtract(broadcast.2426, call.2428)
  constant.2423 = s32[] constant(0)
  broadcast.2424 = s32[32768]{0} broadcast(constant.2423), dimensions={}
  compare.2431 = pred[32768]{0} compare(subtract.2430, broadcast.2424), direction=LT
  constant.2421 = s32[] constant(64)
  broadcast.2422 = s32[32768]{0} broadcast(constant.2421), dimensions={}
  add.2432 = s32[32768]{0} add(subtract.2430, broadcast.2422)
  select.2433 = s32[32768]{0} select(compare.2431, add.2432, subtract.2430)
  reshape.2434 = s32[32768,1]{1,0} reshape(select.2433)
  ROOT gather.2435 = f32[32768,32]{1,0} gather(concatenate.2429, reshape.2434), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2436 {
  Arg_0.2437 = pred[] parameter(0)
  Arg_1.2438 = s32[] parameter(1)
  Arg_2.2439 = s32[] parameter(2)
  ROOT select.2440 = s32[] select(Arg_0.2437, Arg_1.2438, Arg_2.2439)
}

remainder.2441 {
  Arg_0.2442 = s32[32768]{0} parameter(0)
  Arg_1.2443 = s32[] parameter(1)
  constant.2447 = s32[] constant(0)
  compare.2448 = pred[] compare(Arg_1.2443, constant.2447), direction=EQ
  constant.2446 = s32[] constant(1)
  call.2449 = s32[] call(compare.2448, constant.2446, Arg_1.2443), to_apply=_where.2436
  broadcast.2450 = s32[32768]{0} broadcast(call.2449), dimensions={}
  remainder.2451 = s32[32768]{0} remainder(Arg_0.2442, broadcast.2450)
  constant.2444 = s32[] constant(0)
  broadcast.2445 = s32[32768]{0} broadcast(constant.2444), dimensions={}
  compare.2453 = pred[32768]{0} compare(remainder.2451, broadcast.2445), direction=LT
  compare.2454 = pred[] compare(call.2449, constant.2447), direction=LT
  broadcast.2455 = pred[32768]{0} broadcast(compare.2454), dimensions={}
  compare.2456 = pred[32768]{0} compare(compare.2453, broadcast.2455), direction=NE
  compare.2452 = pred[32768]{0} compare(remainder.2451, broadcast.2445), direction=NE
  and.2457 = pred[32768]{0} and(compare.2456, compare.2452)
  broadcast.2458 = s32[32768]{0} broadcast(call.2449), dimensions={}
  add.2459 = s32[32768]{0} add(remainder.2451, broadcast.2458)
  ROOT select.2460 = s32[32768]{0} select(and.2457, add.2459, remainder.2451)
}

_roll_dynamic.2461 {
  Arg_0.2462 = f32[32768,32]{1,0} parameter(0)
  concatenate.2472 = f32[32768,64]{1,0} concatenate(Arg_0.2462, Arg_0.2462), dimensions={1}
  constant.2468 = s32[] constant(32)
  broadcast.2469 = s32[32768]{0} broadcast(constant.2468), dimensions={}
  Arg_1.2463 = s32[32768]{0} parameter(1)
  constant.2470 = s32[] constant(32)
  call.2471 = s32[32768]{0} call(Arg_1.2463, constant.2470), to_apply=remainder.2441
  subtract.2473 = s32[32768]{0} subtract(broadcast.2469, call.2471)
  constant.2466 = s32[] constant(0)
  broadcast.2467 = s32[32768]{0} broadcast(constant.2466), dimensions={}
  compare.2474 = pred[32768]{0} compare(subtract.2473, broadcast.2467), direction=LT
  constant.2464 = s32[] constant(64)
  broadcast.2465 = s32[32768]{0} broadcast(constant.2464), dimensions={}
  add.2475 = s32[32768]{0} add(subtract.2473, broadcast.2465)
  select.2476 = s32[32768]{0} select(compare.2474, add.2475, subtract.2473)
  reshape.2477 = s32[32768,1]{1,0} reshape(select.2476)
  ROOT gather.2478 = f32[32768,32]{1,0} gather(concatenate.2472, reshape.2477), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2479 {
  Arg_0.2480 = pred[] parameter(0)
  Arg_1.2481 = s32[] parameter(1)
  Arg_2.2482 = s32[] parameter(2)
  ROOT select.2483 = s32[] select(Arg_0.2480, Arg_1.2481, Arg_2.2482)
}

remainder.2484 {
  Arg_0.2485 = s32[32768]{0} parameter(0)
  Arg_1.2486 = s32[] parameter(1)
  constant.2490 = s32[] constant(0)
  compare.2491 = pred[] compare(Arg_1.2486, constant.2490), direction=EQ
  constant.2489 = s32[] constant(1)
  call.2492 = s32[] call(compare.2491, constant.2489, Arg_1.2486), to_apply=_where.2479
  broadcast.2493 = s32[32768]{0} broadcast(call.2492), dimensions={}
  remainder.2494 = s32[32768]{0} remainder(Arg_0.2485, broadcast.2493)
  constant.2487 = s32[] constant(0)
  broadcast.2488 = s32[32768]{0} broadcast(constant.2487), dimensions={}
  compare.2496 = pred[32768]{0} compare(remainder.2494, broadcast.2488), direction=LT
  compare.2497 = pred[] compare(call.2492, constant.2490), direction=LT
  broadcast.2498 = pred[32768]{0} broadcast(compare.2497), dimensions={}
  compare.2499 = pred[32768]{0} compare(compare.2496, broadcast.2498), direction=NE
  compare.2495 = pred[32768]{0} compare(remainder.2494, broadcast.2488), direction=NE
  and.2500 = pred[32768]{0} and(compare.2499, compare.2495)
  broadcast.2501 = s32[32768]{0} broadcast(call.2492), dimensions={}
  add.2502 = s32[32768]{0} add(remainder.2494, broadcast.2501)
  ROOT select.2503 = s32[32768]{0} select(and.2500, add.2502, remainder.2494)
}

_roll_dynamic.2504 {
  Arg_0.2505 = f32[32768,32]{1,0} parameter(0)
  concatenate.2515 = f32[32768,64]{1,0} concatenate(Arg_0.2505, Arg_0.2505), dimensions={1}
  constant.2511 = s32[] constant(32)
  broadcast.2512 = s32[32768]{0} broadcast(constant.2511), dimensions={}
  Arg_1.2506 = s32[32768]{0} parameter(1)
  constant.2513 = s32[] constant(32)
  call.2514 = s32[32768]{0} call(Arg_1.2506, constant.2513), to_apply=remainder.2484
  subtract.2516 = s32[32768]{0} subtract(broadcast.2512, call.2514)
  constant.2509 = s32[] constant(0)
  broadcast.2510 = s32[32768]{0} broadcast(constant.2509), dimensions={}
  compare.2517 = pred[32768]{0} compare(subtract.2516, broadcast.2510), direction=LT
  constant.2507 = s32[] constant(64)
  broadcast.2508 = s32[32768]{0} broadcast(constant.2507), dimensions={}
  add.2518 = s32[32768]{0} add(subtract.2516, broadcast.2508)
  select.2519 = s32[32768]{0} select(compare.2517, add.2518, subtract.2516)
  reshape.2520 = s32[32768,1]{1,0} reshape(select.2519)
  ROOT gather.2521 = f32[32768,32]{1,0} gather(concatenate.2515, reshape.2520), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2522 {
  Arg_0.2523 = pred[] parameter(0)
  Arg_1.2524 = s32[] parameter(1)
  Arg_2.2525 = s32[] parameter(2)
  ROOT select.2526 = s32[] select(Arg_0.2523, Arg_1.2524, Arg_2.2525)
}

remainder.2527 {
  Arg_0.2528 = s32[32768]{0} parameter(0)
  Arg_1.2529 = s32[] parameter(1)
  constant.2533 = s32[] constant(0)
  compare.2534 = pred[] compare(Arg_1.2529, constant.2533), direction=EQ
  constant.2532 = s32[] constant(1)
  call.2535 = s32[] call(compare.2534, constant.2532, Arg_1.2529), to_apply=_where.2522
  broadcast.2536 = s32[32768]{0} broadcast(call.2535), dimensions={}
  remainder.2537 = s32[32768]{0} remainder(Arg_0.2528, broadcast.2536)
  constant.2530 = s32[] constant(0)
  broadcast.2531 = s32[32768]{0} broadcast(constant.2530), dimensions={}
  compare.2539 = pred[32768]{0} compare(remainder.2537, broadcast.2531), direction=LT
  compare.2540 = pred[] compare(call.2535, constant.2533), direction=LT
  broadcast.2541 = pred[32768]{0} broadcast(compare.2540), dimensions={}
  compare.2542 = pred[32768]{0} compare(compare.2539, broadcast.2541), direction=NE
  compare.2538 = pred[32768]{0} compare(remainder.2537, broadcast.2531), direction=NE
  and.2543 = pred[32768]{0} and(compare.2542, compare.2538)
  broadcast.2544 = s32[32768]{0} broadcast(call.2535), dimensions={}
  add.2545 = s32[32768]{0} add(remainder.2537, broadcast.2544)
  ROOT select.2546 = s32[32768]{0} select(and.2543, add.2545, remainder.2537)
}

_roll_dynamic.2547 {
  Arg_0.2548 = f32[32768,32]{1,0} parameter(0)
  concatenate.2558 = f32[32768,64]{1,0} concatenate(Arg_0.2548, Arg_0.2548), dimensions={1}
  constant.2554 = s32[] constant(32)
  broadcast.2555 = s32[32768]{0} broadcast(constant.2554), dimensions={}
  Arg_1.2549 = s32[32768]{0} parameter(1)
  constant.2556 = s32[] constant(32)
  call.2557 = s32[32768]{0} call(Arg_1.2549, constant.2556), to_apply=remainder.2527
  subtract.2559 = s32[32768]{0} subtract(broadcast.2555, call.2557)
  constant.2552 = s32[] constant(0)
  broadcast.2553 = s32[32768]{0} broadcast(constant.2552), dimensions={}
  compare.2560 = pred[32768]{0} compare(subtract.2559, broadcast.2553), direction=LT
  constant.2550 = s32[] constant(64)
  broadcast.2551 = s32[32768]{0} broadcast(constant.2550), dimensions={}
  add.2561 = s32[32768]{0} add(subtract.2559, broadcast.2551)
  select.2562 = s32[32768]{0} select(compare.2560, add.2561, subtract.2559)
  reshape.2563 = s32[32768,1]{1,0} reshape(select.2562)
  ROOT gather.2564 = f32[32768,32]{1,0} gather(concatenate.2558, reshape.2563), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.2565 {
  Arg_0.2566 = f32[32768,32]{1,0} parameter(0)
  Arg_1.2567 = f32[32768]{0} parameter(1)
  Arg_2.2568 = f32[] parameter(2)
  broadcast.2595 = f32[32768]{0} broadcast(Arg_2.2568), dimensions={}
  multiply.2596 = f32[32768]{0} multiply(Arg_1.2567, broadcast.2595)
  Arg_3.2569 = f32[] parameter(3)
  broadcast.2597 = f32[32768]{0} broadcast(Arg_3.2569), dimensions={}
  divide.2598 = f32[32768]{0} divide(multiply.2596, broadcast.2597)
  floor.2599 = f32[32768]{0} floor(divide.2598)
  convert.2601 = s32[32768]{0} convert(floor.2599)
  Arg_4.2570 = s32[6]{0} parameter(4)
  slice.2664 = s32[1]{0} slice(Arg_4.2570), slice={[0:1]}
  reshape.2665 = s32[] reshape(slice.2664)
  broadcast.2666 = s32[32768]{0} broadcast(reshape.2665), dimensions={}
  add.2667 = s32[32768]{0} add(convert.2601, broadcast.2666)
  call.2668 = f32[32768,32]{1,0} call(Arg_0.2566, add.2667), to_apply=_roll_dynamic.2332
  subtract.2600 = f32[32768]{0} subtract(divide.2598, floor.2599)
  constant.2593 = f32[] constant(20)
  broadcast.2594 = f32[32768]{0} broadcast(constant.2593), dimensions={}
  divide.2606 = f32[32768]{0} divide(subtract.2600, broadcast.2594)
  multiply.2602 = f32[32768]{0} multiply(subtract.2600, subtract.2600)
  constant.2591 = f32[] constant(24)
  broadcast.2592 = f32[32768]{0} broadcast(constant.2591), dimensions={}
  divide.2607 = f32[32768]{0} divide(multiply.2602, broadcast.2592)
  subtract.2608 = f32[32768]{0} subtract(divide.2606, divide.2607)
  multiply.2603 = f32[32768]{0} multiply(multiply.2602, subtract.2600)
  divide.2609 = f32[32768]{0} divide(multiply.2603, broadcast.2592)
  subtract.2610 = f32[32768]{0} subtract(subtract.2608, divide.2609)
  multiply.2604 = f32[32768]{0} multiply(multiply.2603, subtract.2600)
  divide.2611 = f32[32768]{0} divide(multiply.2604, broadcast.2592)
  add.2612 = f32[32768]{0} add(subtract.2610, divide.2611)
  multiply.2605 = f32[32768]{0} multiply(multiply.2604, subtract.2600)
  constant.2589 = f32[] constant(120)
  broadcast.2590 = f32[32768]{0} broadcast(constant.2589), dimensions={}
  divide.2613 = f32[32768]{0} divide(multiply.2605, broadcast.2590)
  subtract.2614 = f32[32768]{0} subtract(add.2612, divide.2613)
  reshape.2669 = f32[32768,1]{1,0} reshape(subtract.2614)
  broadcast.2670 = f32[32768,1]{1,0} broadcast(reshape.2669), dimensions={0,1}
  reshape.2671 = f32[32768]{0} reshape(broadcast.2670)
  broadcast.2672 = f32[32768,32]{1,0} broadcast(reshape.2671), dimensions={0}
  multiply.2673 = f32[32768,32]{1,0} multiply(call.2668, broadcast.2672)
  slice.2674 = s32[1]{0} slice(Arg_4.2570), slice={[1:2]}
  reshape.2675 = s32[] reshape(slice.2674)
  broadcast.2676 = s32[32768]{0} broadcast(reshape.2675), dimensions={}
  add.2677 = s32[32768]{0} add(convert.2601, broadcast.2676)
  call.2678 = f32[32768,32]{1,0} call(Arg_0.2566, add.2677), to_apply=_roll_dynamic.2375
  constant.2587 = f32[] constant(2)
  broadcast.2588 = f32[32768]{0} broadcast(constant.2587), dimensions={}
  divide.2615 = f32[32768]{0} divide(subtract.2600, broadcast.2588)
  negate.2616 = f32[32768]{0} negate(divide.2615)
  multiply.2617 = f32[32768]{0} multiply(multiply.2602, broadcast.2588)
  constant.2585 = f32[] constant(3)
  broadcast.2586 = f32[32768]{0} broadcast(constant.2585), dimensions={}
  divide.2618 = f32[32768]{0} divide(multiply.2617, broadcast.2586)
  add.2619 = f32[32768]{0} add(negate.2616, divide.2618)
  divide.2620 = f32[32768]{0} divide(multiply.2603, broadcast.2592)
  subtract.2621 = f32[32768]{0} subtract(add.2619, divide.2620)
  constant.2583 = f32[] constant(6)
  broadcast.2584 = f32[32768]{0} broadcast(constant.2583), dimensions={}
  divide.2622 = f32[32768]{0} divide(multiply.2604, broadcast.2584)
  subtract.2623 = f32[32768]{0} subtract(subtract.2621, divide.2622)
  divide.2624 = f32[32768]{0} divide(multiply.2605, broadcast.2592)
  add.2625 = f32[32768]{0} add(subtract.2623, divide.2624)
  reshape.2679 = f32[32768,1]{1,0} reshape(add.2625)
  broadcast.2680 = f32[32768,1]{1,0} broadcast(reshape.2679), dimensions={0,1}
  reshape.2681 = f32[32768]{0} reshape(broadcast.2680)
  broadcast.2682 = f32[32768,32]{1,0} broadcast(reshape.2681), dimensions={0}
  multiply.2683 = f32[32768,32]{1,0} multiply(call.2678, broadcast.2682)
  add.2684 = f32[32768,32]{1,0} add(multiply.2673, multiply.2683)
  slice.2685 = s32[1]{0} slice(Arg_4.2570), slice={[2:3]}
  reshape.2686 = s32[] reshape(slice.2685)
  broadcast.2687 = s32[32768]{0} broadcast(reshape.2686), dimensions={}
  add.2688 = s32[32768]{0} add(convert.2601, broadcast.2687)
  call.2689 = f32[32768,32]{1,0} call(Arg_0.2566, add.2688), to_apply=_roll_dynamic.2418
  constant.2581 = f32[] constant(1)
  broadcast.2582 = f32[32768]{0} broadcast(constant.2581), dimensions={}
  divide.2626 = f32[32768]{0} divide(subtract.2600, broadcast.2586)
  subtract.2627 = f32[32768]{0} subtract(broadcast.2582, divide.2626)
  constant.2579 = f32[] constant(5)
  broadcast.2580 = f32[32768]{0} broadcast(constant.2579), dimensions={}
  multiply.2628 = f32[32768]{0} multiply(multiply.2602, broadcast.2580)
  constant.2577 = f32[] constant(4)
  broadcast.2578 = f32[32768]{0} broadcast(constant.2577), dimensions={}
  divide.2629 = f32[32768]{0} divide(multiply.2628, broadcast.2578)
  subtract.2630 = f32[32768]{0} subtract(subtract.2627, divide.2629)
  multiply.2631 = f32[32768]{0} multiply(multiply.2603, broadcast.2580)
  constant.2575 = f32[] constant(12)
  broadcast.2576 = f32[32768]{0} broadcast(constant.2575), dimensions={}
  divide.2632 = f32[32768]{0} divide(multiply.2631, broadcast.2576)
  add.2633 = f32[32768]{0} add(subtract.2630, divide.2632)
  divide.2634 = f32[32768]{0} divide(multiply.2604, broadcast.2578)
  add.2635 = f32[32768]{0} add(add.2633, divide.2634)
  divide.2636 = f32[32768]{0} divide(multiply.2605, broadcast.2576)
  subtract.2637 = f32[32768]{0} subtract(add.2635, divide.2636)
  reshape.2690 = f32[32768,1]{1,0} reshape(subtract.2637)
  broadcast.2691 = f32[32768,1]{1,0} broadcast(reshape.2690), dimensions={0,1}
  reshape.2692 = f32[32768]{0} reshape(broadcast.2691)
  broadcast.2693 = f32[32768,32]{1,0} broadcast(reshape.2692), dimensions={0}
  multiply.2694 = f32[32768,32]{1,0} multiply(call.2689, broadcast.2693)
  add.2695 = f32[32768,32]{1,0} add(add.2684, multiply.2694)
  slice.2696 = s32[1]{0} slice(Arg_4.2570), slice={[3:4]}
  reshape.2697 = s32[] reshape(slice.2696)
  broadcast.2698 = s32[32768]{0} broadcast(reshape.2697), dimensions={}
  add.2699 = s32[32768]{0} add(convert.2601, broadcast.2698)
  call.2700 = f32[32768,32]{1,0} call(Arg_0.2566, add.2699), to_apply=_roll_dynamic.2461
  multiply.2638 = f32[32768]{0} multiply(multiply.2602, broadcast.2588)
  divide.2639 = f32[32768]{0} divide(multiply.2638, broadcast.2586)
  add.2640 = f32[32768]{0} add(subtract.2600, divide.2639)
  constant.2573 = f32[] constant(7)
  broadcast.2574 = f32[32768]{0} broadcast(constant.2573), dimensions={}
  multiply.2641 = f32[32768]{0} multiply(multiply.2603, broadcast.2574)
  divide.2642 = f32[32768]{0} divide(multiply.2641, broadcast.2576)
  subtract.2643 = f32[32768]{0} subtract(add.2640, divide.2642)
  divide.2644 = f32[32768]{0} divide(multiply.2604, broadcast.2584)
  subtract.2645 = f32[32768]{0} subtract(subtract.2643, divide.2644)
  divide.2646 = f32[32768]{0} divide(multiply.2605, broadcast.2576)
  add.2647 = f32[32768]{0} add(subtract.2645, divide.2646)
  reshape.2701 = f32[32768,1]{1,0} reshape(add.2647)
  broadcast.2702 = f32[32768,1]{1,0} broadcast(reshape.2701), dimensions={0,1}
  reshape.2703 = f32[32768]{0} reshape(broadcast.2702)
  broadcast.2704 = f32[32768,32]{1,0} broadcast(reshape.2703), dimensions={0}
  multiply.2705 = f32[32768,32]{1,0} multiply(call.2700, broadcast.2704)
  add.2706 = f32[32768,32]{1,0} add(add.2695, multiply.2705)
  slice.2707 = s32[1]{0} slice(Arg_4.2570), slice={[4:5]}
  reshape.2708 = s32[] reshape(slice.2707)
  broadcast.2709 = s32[32768]{0} broadcast(reshape.2708), dimensions={}
  add.2710 = s32[32768]{0} add(convert.2601, broadcast.2709)
  call.2711 = f32[32768,32]{1,0} call(Arg_0.2566, add.2710), to_apply=_roll_dynamic.2504
  divide.2648 = f32[32768]{0} divide(subtract.2600, broadcast.2578)
  negate.2649 = f32[32768]{0} negate(divide.2648)
  divide.2650 = f32[32768]{0} divide(multiply.2602, broadcast.2592)
  subtract.2651 = f32[32768]{0} subtract(negate.2649, divide.2650)
  multiply.2652 = f32[32768]{0} multiply(multiply.2603, broadcast.2574)
  divide.2653 = f32[32768]{0} divide(multiply.2652, broadcast.2592)
  add.2654 = f32[32768]{0} add(subtract.2651, divide.2653)
  divide.2655 = f32[32768]{0} divide(multiply.2604, broadcast.2592)
  add.2656 = f32[32768]{0} add(add.2654, divide.2655)
  divide.2657 = f32[32768]{0} divide(multiply.2605, broadcast.2592)
  subtract.2658 = f32[32768]{0} subtract(add.2656, divide.2657)
  reshape.2712 = f32[32768,1]{1,0} reshape(subtract.2658)
  broadcast.2713 = f32[32768,1]{1,0} broadcast(reshape.2712), dimensions={0,1}
  reshape.2714 = f32[32768]{0} reshape(broadcast.2713)
  broadcast.2715 = f32[32768,32]{1,0} broadcast(reshape.2714), dimensions={0}
  multiply.2716 = f32[32768,32]{1,0} multiply(call.2711, broadcast.2715)
  add.2717 = f32[32768,32]{1,0} add(add.2706, multiply.2716)
  slice.2718 = s32[1]{0} slice(Arg_4.2570), slice={[5:6]}
  reshape.2719 = s32[] reshape(slice.2718)
  broadcast.2720 = s32[32768]{0} broadcast(reshape.2719), dimensions={}
  add.2721 = s32[32768]{0} add(convert.2601, broadcast.2720)
  call.2722 = f32[32768,32]{1,0} call(Arg_0.2566, add.2721), to_apply=_roll_dynamic.2547
  constant.2571 = f32[] constant(30)
  broadcast.2572 = f32[32768]{0} broadcast(constant.2571), dimensions={}
  divide.2659 = f32[32768]{0} divide(subtract.2600, broadcast.2572)
  divide.2660 = f32[32768]{0} divide(multiply.2603, broadcast.2592)
  subtract.2661 = f32[32768]{0} subtract(divide.2659, divide.2660)
  divide.2662 = f32[32768]{0} divide(multiply.2605, broadcast.2590)
  add.2663 = f32[32768]{0} add(subtract.2661, divide.2662)
  reshape.2723 = f32[32768,1]{1,0} reshape(add.2663)
  broadcast.2724 = f32[32768,1]{1,0} broadcast(reshape.2723), dimensions={0,1}
  reshape.2725 = f32[32768]{0} reshape(broadcast.2724)
  broadcast.2726 = f32[32768,32]{1,0} broadcast(reshape.2725), dimensions={0}
  multiply.2727 = f32[32768,32]{1,0} multiply(call.2722, broadcast.2726)
  ROOT add.2728 = f32[32768,32]{1,0} add(add.2717, multiply.2727)
}

ENTRY main.2733 {
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
  call.440 = f32[32768,32]{1,0} call(reshape.13, reshape.17, constant.6, constant.5, constant.7), to_apply=advect_1d_roll_diag.276
  reshape.441 = f32[32,32,32,32]{3,2,1,0} reshape(call.440)
  transpose.442 = f32[32,32,32,32]{0,2,1,3} transpose(reshape.441), dimensions={3,1,2,0}
  reshape.443 = f32[32768,32]{1,0} reshape(transpose.442)
  constant.2 = f32[1,1,32]{2,1,0} constant({...})
  broadcast.444 = f32[1,1,32]{2,1,0} broadcast(constant.2), dimensions={0,1,2}
  reshape.445 = f32[32]{0} reshape(broadcast.444)
  broadcast.446 = f32[32,32,32]{2,1,0} broadcast(reshape.445), dimensions={2}
  reshape.447 = f32[32768]{0} reshape(broadcast.446)
  call.870 = f32[32768,32]{1,0} call(reshape.443, reshape.447, constant.6, constant.5, constant.7), to_apply=advect_1d_roll_diag.706
  reshape.871 = f32[32,32,32,32]{3,2,1,0} reshape(call.870)
  transpose.934 = f32[32,32,32,32]{1,2,3,0} transpose(reshape.871), dimensions={0,3,2,1}
  reshape.935 = f32[32768,32]{1,0} reshape(transpose.934)
  transpose.872 = f32[32,32,32,32]{1,3,2,0} transpose(reshape.871), dimensions={0,3,1,2}
  constant.8 = f32[32,1]{1,0} constant({...})
  constant.9 = f32[1,17]{1,0} constant({...})
  constant.10 = f32[32,17]{1,0} constant({...})
  constant.4 = f32[] constant(0.322580636)
  call.928 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) call(transpose.872, constant.8, constant.9, constant.10, constant.4, constant.4), to_apply=solve_poisson.889
  get-tuple-element.929 = f32[32,32]{1,0} get-tuple-element(call.928), index=0
  reshape.933 = f32[32,32,1]{2,1,0} reshape(get-tuple-element.929)
  broadcast.936 = f32[32,32,1]{2,1,0} broadcast(reshape.933), dimensions={0,1,2}
  reshape.937 = f32[32,32]{1,0} reshape(broadcast.936)
  broadcast.938 = f32[32,32,32]{2,1,0} broadcast(reshape.937), dimensions={0,1}
  reshape.939 = f32[32768]{0} reshape(broadcast.938)
  constant.3 = f32[] constant(0.05)
  call.1400 = f32[32768,32]{1,0} call(reshape.935, reshape.939, constant.3, constant.4, constant.7), to_apply=advect_1d_roll_diag_1.1333
  reshape.1401 = f32[32,32,32,32]{3,2,1,0} reshape(call.1400)
  transpose.1402 = f32[32,32,32,32]{2,3,1,0} transpose(reshape.1401), dimensions={0,1,3,2}
  reshape.1404 = f32[32768,32]{1,0} reshape(transpose.1402)
  get-tuple-element.930 = f32[32,32]{1,0} get-tuple-element(call.928), index=1
  reshape.1403 = f32[32,32,1]{2,1,0} reshape(get-tuple-element.930)
  broadcast.1405 = f32[32,32,1]{2,1,0} broadcast(reshape.1403), dimensions={0,1,2}
  reshape.1406 = f32[32,32]{1,0} reshape(broadcast.1405)
  broadcast.1407 = f32[32,32,32]{2,1,0} broadcast(reshape.1406), dimensions={0,1}
  reshape.1408 = f32[32768]{0} reshape(broadcast.1407)
  call.1869 = f32[32768,32]{1,0} call(reshape.1404, reshape.1408, constant.3, constant.4, constant.7), to_apply=advect_1d_roll_diag_1.1802
  reshape.1870 = f32[32,32,32,32]{3,2,1,0} reshape(call.1869)
  transpose.1871 = f32[32,32,32,32]{2,1,3,0} transpose(reshape.1870), dimensions={0,2,3,1}
  reshape.1872 = f32[32768,32]{1,0} reshape(transpose.1871)
  broadcast.1873 = f32[1,1,32]{2,1,0} broadcast(constant.2), dimensions={0,1,2}
  reshape.1874 = f32[32]{0} reshape(broadcast.1873)
  broadcast.1875 = f32[32,32,32]{2,1,0} broadcast(reshape.1874), dimensions={2}
  reshape.1876 = f32[32768]{0} reshape(broadcast.1875)
  call.2299 = f32[32768,32]{1,0} call(reshape.1872, reshape.1876, constant.6, constant.5, constant.7), to_apply=advect_1d_roll_diag.2135
  reshape.2300 = f32[32,32,32,32]{3,2,1,0} reshape(call.2299)
  transpose.2301 = f32[32,32,32,32]{0,2,1,3} transpose(reshape.2300), dimensions={3,1,2,0}
  reshape.2302 = f32[32768,32]{1,0} reshape(transpose.2301)
  broadcast.2303 = f32[1,32,1]{2,1,0} broadcast(constant.11), dimensions={0,1,2}
  reshape.2304 = f32[32]{0} reshape(broadcast.2303)
  broadcast.2305 = f32[32,32,32]{2,1,0} broadcast(reshape.2304), dimensions={1}
  reshape.2306 = f32[32768]{0} reshape(broadcast.2305)
  call.2729 = f32[32768,32]{1,0} call(reshape.2302, reshape.2306, constant.6, constant.5, constant.7), to_apply=advect_1d_roll_diag.2565
  reshape.2730 = f32[32,32,32,32]{3,2,1,0} reshape(call.2729)
  transpose.2731 = f32[32,32,32,32]{0,3,2,1} transpose(reshape.2730), dimensions={3,0,1,2}
  get-tuple-element.931 = f32[32,32]{1,0} get-tuple-element(call.928), index=2
  get-tuple-element.932 = f32[32,32]{1,0} get-tuple-element(call.928), index=3
  ROOT tuple.2732 = (f32[32,32,32,32]{0,3,2,1}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(transpose.2731, get-tuple-element.931, get-tuple-element.932)
}

