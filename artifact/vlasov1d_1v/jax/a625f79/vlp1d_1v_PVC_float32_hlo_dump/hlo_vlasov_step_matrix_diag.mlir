HloModule jit__lambda_, entry_computation_layout={(f32[128,128]{1,0})->(f32[128,128]{0,1}, f32[128]{0}, f32[128]{0})}

_where.9 {
  Arg_0.10 = pred[] parameter(0)
  Arg_1.11 = s32[] parameter(1)
  Arg_2.12 = s32[] parameter(2)
  ROOT select.13 = s32[] select(Arg_0.10, Arg_1.11, Arg_2.12)
}

remainder.14 {
  Arg_0.15 = s32[128]{0} parameter(0)
  Arg_1.16 = s32[] parameter(1)
  constant.20 = s32[] constant(0)
  compare.21 = pred[] compare(Arg_1.16, constant.20), direction=EQ
  constant.19 = s32[] constant(1)
  call.22 = s32[] call(compare.21, constant.19, Arg_1.16), to_apply=_where.9
  broadcast.23 = s32[128]{0} broadcast(call.22), dimensions={}
  remainder.24 = s32[128]{0} remainder(Arg_0.15, broadcast.23)
  constant.17 = s32[] constant(0)
  broadcast.18 = s32[128]{0} broadcast(constant.17), dimensions={}
  compare.26 = pred[128]{0} compare(remainder.24, broadcast.18), direction=LT
  compare.27 = pred[] compare(call.22, constant.20), direction=LT
  broadcast.28 = pred[128]{0} broadcast(compare.27), dimensions={}
  compare.29 = pred[128]{0} compare(compare.26, broadcast.28), direction=NE
  compare.25 = pred[128]{0} compare(remainder.24, broadcast.18), direction=NE
  and.30 = pred[128]{0} and(compare.29, compare.25)
  broadcast.31 = s32[128]{0} broadcast(call.22), dimensions={}
  add.32 = s32[128]{0} add(remainder.24, broadcast.31)
  ROOT select.33 = s32[128]{0} select(and.30, add.32, remainder.24)
}

_roll_dynamic.34 {
  Arg_0.35 = f32[128,128]{1,0} parameter(0)
  transpose.45 = f32[128,128]{0,1} transpose(Arg_0.35), dimensions={1,0}
  transpose.46 = f32[128,128]{0,1} transpose(Arg_0.35), dimensions={1,0}
  concatenate.47 = f32[128,256]{1,0} concatenate(transpose.45, transpose.46), dimensions={1}
  constant.41 = s32[] constant(128)
  broadcast.42 = s32[128]{0} broadcast(constant.41), dimensions={}
  Arg_1.36 = s32[128]{0} parameter(1)
  constant.43 = s32[] constant(128)
  call.44 = s32[128]{0} call(Arg_1.36, constant.43), to_apply=remainder.14
  subtract.48 = s32[128]{0} subtract(broadcast.42, call.44)
  constant.39 = s32[] constant(0)
  broadcast.40 = s32[128]{0} broadcast(constant.39), dimensions={}
  compare.49 = pred[128]{0} compare(subtract.48, broadcast.40), direction=LT
  constant.37 = s32[] constant(256)
  broadcast.38 = s32[128]{0} broadcast(constant.37), dimensions={}
  add.50 = s32[128]{0} add(subtract.48, broadcast.38)
  select.51 = s32[128]{0} select(compare.49, add.50, subtract.48)
  reshape.52 = s32[128,1]{1,0} reshape(select.51)
  ROOT gather.53 = f32[128,128]{1,0} gather(concatenate.47, reshape.52), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.54 {
  Arg_0.55 = pred[] parameter(0)
  Arg_1.56 = s32[] parameter(1)
  Arg_2.57 = s32[] parameter(2)
  ROOT select.58 = s32[] select(Arg_0.55, Arg_1.56, Arg_2.57)
}

remainder.59 {
  Arg_0.60 = s32[128]{0} parameter(0)
  Arg_1.61 = s32[] parameter(1)
  constant.65 = s32[] constant(0)
  compare.66 = pred[] compare(Arg_1.61, constant.65), direction=EQ
  constant.64 = s32[] constant(1)
  call.67 = s32[] call(compare.66, constant.64, Arg_1.61), to_apply=_where.54
  broadcast.68 = s32[128]{0} broadcast(call.67), dimensions={}
  remainder.69 = s32[128]{0} remainder(Arg_0.60, broadcast.68)
  constant.62 = s32[] constant(0)
  broadcast.63 = s32[128]{0} broadcast(constant.62), dimensions={}
  compare.71 = pred[128]{0} compare(remainder.69, broadcast.63), direction=LT
  compare.72 = pred[] compare(call.67, constant.65), direction=LT
  broadcast.73 = pred[128]{0} broadcast(compare.72), dimensions={}
  compare.74 = pred[128]{0} compare(compare.71, broadcast.73), direction=NE
  compare.70 = pred[128]{0} compare(remainder.69, broadcast.63), direction=NE
  and.75 = pred[128]{0} and(compare.74, compare.70)
  broadcast.76 = s32[128]{0} broadcast(call.67), dimensions={}
  add.77 = s32[128]{0} add(remainder.69, broadcast.76)
  ROOT select.78 = s32[128]{0} select(and.75, add.77, remainder.69)
}

_roll_dynamic.79 {
  Arg_0.80 = f32[128,128]{1,0} parameter(0)
  transpose.90 = f32[128,128]{0,1} transpose(Arg_0.80), dimensions={1,0}
  transpose.91 = f32[128,128]{0,1} transpose(Arg_0.80), dimensions={1,0}
  concatenate.92 = f32[128,256]{1,0} concatenate(transpose.90, transpose.91), dimensions={1}
  constant.86 = s32[] constant(128)
  broadcast.87 = s32[128]{0} broadcast(constant.86), dimensions={}
  Arg_1.81 = s32[128]{0} parameter(1)
  constant.88 = s32[] constant(128)
  call.89 = s32[128]{0} call(Arg_1.81, constant.88), to_apply=remainder.59
  subtract.93 = s32[128]{0} subtract(broadcast.87, call.89)
  constant.84 = s32[] constant(0)
  broadcast.85 = s32[128]{0} broadcast(constant.84), dimensions={}
  compare.94 = pred[128]{0} compare(subtract.93, broadcast.85), direction=LT
  constant.82 = s32[] constant(256)
  broadcast.83 = s32[128]{0} broadcast(constant.82), dimensions={}
  add.95 = s32[128]{0} add(subtract.93, broadcast.83)
  select.96 = s32[128]{0} select(compare.94, add.95, subtract.93)
  reshape.97 = s32[128,1]{1,0} reshape(select.96)
  ROOT gather.98 = f32[128,128]{1,0} gather(concatenate.92, reshape.97), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.99 {
  Arg_0.100 = pred[] parameter(0)
  Arg_1.101 = s32[] parameter(1)
  Arg_2.102 = s32[] parameter(2)
  ROOT select.103 = s32[] select(Arg_0.100, Arg_1.101, Arg_2.102)
}

remainder.104 {
  Arg_0.105 = s32[128]{0} parameter(0)
  Arg_1.106 = s32[] parameter(1)
  constant.110 = s32[] constant(0)
  compare.111 = pred[] compare(Arg_1.106, constant.110), direction=EQ
  constant.109 = s32[] constant(1)
  call.112 = s32[] call(compare.111, constant.109, Arg_1.106), to_apply=_where.99
  broadcast.113 = s32[128]{0} broadcast(call.112), dimensions={}
  remainder.114 = s32[128]{0} remainder(Arg_0.105, broadcast.113)
  constant.107 = s32[] constant(0)
  broadcast.108 = s32[128]{0} broadcast(constant.107), dimensions={}
  compare.116 = pred[128]{0} compare(remainder.114, broadcast.108), direction=LT
  compare.117 = pred[] compare(call.112, constant.110), direction=LT
  broadcast.118 = pred[128]{0} broadcast(compare.117), dimensions={}
  compare.119 = pred[128]{0} compare(compare.116, broadcast.118), direction=NE
  compare.115 = pred[128]{0} compare(remainder.114, broadcast.108), direction=NE
  and.120 = pred[128]{0} and(compare.119, compare.115)
  broadcast.121 = s32[128]{0} broadcast(call.112), dimensions={}
  add.122 = s32[128]{0} add(remainder.114, broadcast.121)
  ROOT select.123 = s32[128]{0} select(and.120, add.122, remainder.114)
}

_roll_dynamic.124 {
  Arg_0.125 = f32[128,128]{1,0} parameter(0)
  transpose.135 = f32[128,128]{0,1} transpose(Arg_0.125), dimensions={1,0}
  transpose.136 = f32[128,128]{0,1} transpose(Arg_0.125), dimensions={1,0}
  concatenate.137 = f32[128,256]{1,0} concatenate(transpose.135, transpose.136), dimensions={1}
  constant.131 = s32[] constant(128)
  broadcast.132 = s32[128]{0} broadcast(constant.131), dimensions={}
  Arg_1.126 = s32[128]{0} parameter(1)
  constant.133 = s32[] constant(128)
  call.134 = s32[128]{0} call(Arg_1.126, constant.133), to_apply=remainder.104
  subtract.138 = s32[128]{0} subtract(broadcast.132, call.134)
  constant.129 = s32[] constant(0)
  broadcast.130 = s32[128]{0} broadcast(constant.129), dimensions={}
  compare.139 = pred[128]{0} compare(subtract.138, broadcast.130), direction=LT
  constant.127 = s32[] constant(256)
  broadcast.128 = s32[128]{0} broadcast(constant.127), dimensions={}
  add.140 = s32[128]{0} add(subtract.138, broadcast.128)
  select.141 = s32[128]{0} select(compare.139, add.140, subtract.138)
  reshape.142 = s32[128,1]{1,0} reshape(select.141)
  ROOT gather.143 = f32[128,128]{1,0} gather(concatenate.137, reshape.142), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.144 {
  Arg_0.145 = pred[] parameter(0)
  Arg_1.146 = s32[] parameter(1)
  Arg_2.147 = s32[] parameter(2)
  ROOT select.148 = s32[] select(Arg_0.145, Arg_1.146, Arg_2.147)
}

remainder.149 {
  Arg_0.150 = s32[128]{0} parameter(0)
  Arg_1.151 = s32[] parameter(1)
  constant.155 = s32[] constant(0)
  compare.156 = pred[] compare(Arg_1.151, constant.155), direction=EQ
  constant.154 = s32[] constant(1)
  call.157 = s32[] call(compare.156, constant.154, Arg_1.151), to_apply=_where.144
  broadcast.158 = s32[128]{0} broadcast(call.157), dimensions={}
  remainder.159 = s32[128]{0} remainder(Arg_0.150, broadcast.158)
  constant.152 = s32[] constant(0)
  broadcast.153 = s32[128]{0} broadcast(constant.152), dimensions={}
  compare.161 = pred[128]{0} compare(remainder.159, broadcast.153), direction=LT
  compare.162 = pred[] compare(call.157, constant.155), direction=LT
  broadcast.163 = pred[128]{0} broadcast(compare.162), dimensions={}
  compare.164 = pred[128]{0} compare(compare.161, broadcast.163), direction=NE
  compare.160 = pred[128]{0} compare(remainder.159, broadcast.153), direction=NE
  and.165 = pred[128]{0} and(compare.164, compare.160)
  broadcast.166 = s32[128]{0} broadcast(call.157), dimensions={}
  add.167 = s32[128]{0} add(remainder.159, broadcast.166)
  ROOT select.168 = s32[128]{0} select(and.165, add.167, remainder.159)
}

_roll_dynamic.169 {
  Arg_0.170 = f32[128,128]{1,0} parameter(0)
  transpose.180 = f32[128,128]{0,1} transpose(Arg_0.170), dimensions={1,0}
  transpose.181 = f32[128,128]{0,1} transpose(Arg_0.170), dimensions={1,0}
  concatenate.182 = f32[128,256]{1,0} concatenate(transpose.180, transpose.181), dimensions={1}
  constant.176 = s32[] constant(128)
  broadcast.177 = s32[128]{0} broadcast(constant.176), dimensions={}
  Arg_1.171 = s32[128]{0} parameter(1)
  constant.178 = s32[] constant(128)
  call.179 = s32[128]{0} call(Arg_1.171, constant.178), to_apply=remainder.149
  subtract.183 = s32[128]{0} subtract(broadcast.177, call.179)
  constant.174 = s32[] constant(0)
  broadcast.175 = s32[128]{0} broadcast(constant.174), dimensions={}
  compare.184 = pred[128]{0} compare(subtract.183, broadcast.175), direction=LT
  constant.172 = s32[] constant(256)
  broadcast.173 = s32[128]{0} broadcast(constant.172), dimensions={}
  add.185 = s32[128]{0} add(subtract.183, broadcast.173)
  select.186 = s32[128]{0} select(compare.184, add.185, subtract.183)
  reshape.187 = s32[128,1]{1,0} reshape(select.186)
  ROOT gather.188 = f32[128,128]{1,0} gather(concatenate.182, reshape.187), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.189 {
  Arg_0.190 = pred[] parameter(0)
  Arg_1.191 = s32[] parameter(1)
  Arg_2.192 = s32[] parameter(2)
  ROOT select.193 = s32[] select(Arg_0.190, Arg_1.191, Arg_2.192)
}

remainder.194 {
  Arg_0.195 = s32[128]{0} parameter(0)
  Arg_1.196 = s32[] parameter(1)
  constant.200 = s32[] constant(0)
  compare.201 = pred[] compare(Arg_1.196, constant.200), direction=EQ
  constant.199 = s32[] constant(1)
  call.202 = s32[] call(compare.201, constant.199, Arg_1.196), to_apply=_where.189
  broadcast.203 = s32[128]{0} broadcast(call.202), dimensions={}
  remainder.204 = s32[128]{0} remainder(Arg_0.195, broadcast.203)
  constant.197 = s32[] constant(0)
  broadcast.198 = s32[128]{0} broadcast(constant.197), dimensions={}
  compare.206 = pred[128]{0} compare(remainder.204, broadcast.198), direction=LT
  compare.207 = pred[] compare(call.202, constant.200), direction=LT
  broadcast.208 = pred[128]{0} broadcast(compare.207), dimensions={}
  compare.209 = pred[128]{0} compare(compare.206, broadcast.208), direction=NE
  compare.205 = pred[128]{0} compare(remainder.204, broadcast.198), direction=NE
  and.210 = pred[128]{0} and(compare.209, compare.205)
  broadcast.211 = s32[128]{0} broadcast(call.202), dimensions={}
  add.212 = s32[128]{0} add(remainder.204, broadcast.211)
  ROOT select.213 = s32[128]{0} select(and.210, add.212, remainder.204)
}

_roll_dynamic.214 {
  Arg_0.215 = f32[128,128]{1,0} parameter(0)
  transpose.225 = f32[128,128]{0,1} transpose(Arg_0.215), dimensions={1,0}
  transpose.226 = f32[128,128]{0,1} transpose(Arg_0.215), dimensions={1,0}
  concatenate.227 = f32[128,256]{1,0} concatenate(transpose.225, transpose.226), dimensions={1}
  constant.221 = s32[] constant(128)
  broadcast.222 = s32[128]{0} broadcast(constant.221), dimensions={}
  Arg_1.216 = s32[128]{0} parameter(1)
  constant.223 = s32[] constant(128)
  call.224 = s32[128]{0} call(Arg_1.216, constant.223), to_apply=remainder.194
  subtract.228 = s32[128]{0} subtract(broadcast.222, call.224)
  constant.219 = s32[] constant(0)
  broadcast.220 = s32[128]{0} broadcast(constant.219), dimensions={}
  compare.229 = pred[128]{0} compare(subtract.228, broadcast.220), direction=LT
  constant.217 = s32[] constant(256)
  broadcast.218 = s32[128]{0} broadcast(constant.217), dimensions={}
  add.230 = s32[128]{0} add(subtract.228, broadcast.218)
  select.231 = s32[128]{0} select(compare.229, add.230, subtract.228)
  reshape.232 = s32[128,1]{1,0} reshape(select.231)
  ROOT gather.233 = f32[128,128]{1,0} gather(concatenate.227, reshape.232), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.234 {
  Arg_0.235 = pred[] parameter(0)
  Arg_1.236 = s32[] parameter(1)
  Arg_2.237 = s32[] parameter(2)
  ROOT select.238 = s32[] select(Arg_0.235, Arg_1.236, Arg_2.237)
}

remainder.239 {
  Arg_0.240 = s32[128]{0} parameter(0)
  Arg_1.241 = s32[] parameter(1)
  constant.245 = s32[] constant(0)
  compare.246 = pred[] compare(Arg_1.241, constant.245), direction=EQ
  constant.244 = s32[] constant(1)
  call.247 = s32[] call(compare.246, constant.244, Arg_1.241), to_apply=_where.234
  broadcast.248 = s32[128]{0} broadcast(call.247), dimensions={}
  remainder.249 = s32[128]{0} remainder(Arg_0.240, broadcast.248)
  constant.242 = s32[] constant(0)
  broadcast.243 = s32[128]{0} broadcast(constant.242), dimensions={}
  compare.251 = pred[128]{0} compare(remainder.249, broadcast.243), direction=LT
  compare.252 = pred[] compare(call.247, constant.245), direction=LT
  broadcast.253 = pred[128]{0} broadcast(compare.252), dimensions={}
  compare.254 = pred[128]{0} compare(compare.251, broadcast.253), direction=NE
  compare.250 = pred[128]{0} compare(remainder.249, broadcast.243), direction=NE
  and.255 = pred[128]{0} and(compare.254, compare.250)
  broadcast.256 = s32[128]{0} broadcast(call.247), dimensions={}
  add.257 = s32[128]{0} add(remainder.249, broadcast.256)
  ROOT select.258 = s32[128]{0} select(and.255, add.257, remainder.249)
}

_roll_dynamic.259 {
  Arg_0.260 = f32[128,128]{1,0} parameter(0)
  transpose.270 = f32[128,128]{0,1} transpose(Arg_0.260), dimensions={1,0}
  transpose.271 = f32[128,128]{0,1} transpose(Arg_0.260), dimensions={1,0}
  concatenate.272 = f32[128,256]{1,0} concatenate(transpose.270, transpose.271), dimensions={1}
  constant.266 = s32[] constant(128)
  broadcast.267 = s32[128]{0} broadcast(constant.266), dimensions={}
  Arg_1.261 = s32[128]{0} parameter(1)
  constant.268 = s32[] constant(128)
  call.269 = s32[128]{0} call(Arg_1.261, constant.268), to_apply=remainder.239
  subtract.273 = s32[128]{0} subtract(broadcast.267, call.269)
  constant.264 = s32[] constant(0)
  broadcast.265 = s32[128]{0} broadcast(constant.264), dimensions={}
  compare.274 = pred[128]{0} compare(subtract.273, broadcast.265), direction=LT
  constant.262 = s32[] constant(256)
  broadcast.263 = s32[128]{0} broadcast(constant.262), dimensions={}
  add.275 = s32[128]{0} add(subtract.273, broadcast.263)
  select.276 = s32[128]{0} select(compare.274, add.275, subtract.273)
  reshape.277 = s32[128,1]{1,0} reshape(select.276)
  ROOT gather.278 = f32[128,128]{1,0} gather(concatenate.272, reshape.277), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

advect_1d_matrix_diag.279 {
  Arg_0.280 = f32[128,128]{1,0} parameter(0)
  Arg_1.281 = f32[128]{0} parameter(1)
  Arg_2.282 = f32[] parameter(2)
  broadcast.309 = f32[128]{0} broadcast(Arg_2.282), dimensions={}
  multiply.310 = f32[128]{0} multiply(Arg_1.281, broadcast.309)
  Arg_3.283 = f32[] parameter(3)
  broadcast.311 = f32[128]{0} broadcast(Arg_3.283), dimensions={}
  divide.312 = f32[128]{0} divide(multiply.310, broadcast.311)
  floor.313 = f32[128]{0} floor(divide.312)
  convert.315 = s32[128]{0} convert(floor.313)
  Arg_4.284 = s32[6]{0} parameter(4)
  slice.378 = s32[1]{0} slice(Arg_4.284), slice={[0:1]}
  reshape.379 = s32[] reshape(slice.378)
  broadcast.380 = s32[128]{0} broadcast(reshape.379), dimensions={}
  add.381 = s32[128]{0} add(convert.315, broadcast.380)
  call.382 = f32[128,128]{1,0} call(Arg_0.280, add.381), to_apply=_roll_dynamic.34
  transpose.383 = f32[128,128]{0,1} transpose(call.382), dimensions={1,0}
  subtract.314 = f32[128]{0} subtract(divide.312, floor.313)
  constant.307 = f32[] constant(20)
  broadcast.308 = f32[128]{0} broadcast(constant.307), dimensions={}
  divide.320 = f32[128]{0} divide(subtract.314, broadcast.308)
  multiply.316 = f32[128]{0} multiply(subtract.314, subtract.314)
  constant.305 = f32[] constant(24)
  broadcast.306 = f32[128]{0} broadcast(constant.305), dimensions={}
  divide.321 = f32[128]{0} divide(multiply.316, broadcast.306)
  subtract.322 = f32[128]{0} subtract(divide.320, divide.321)
  multiply.317 = f32[128]{0} multiply(multiply.316, subtract.314)
  divide.323 = f32[128]{0} divide(multiply.317, broadcast.306)
  subtract.324 = f32[128]{0} subtract(subtract.322, divide.323)
  multiply.318 = f32[128]{0} multiply(multiply.317, subtract.314)
  divide.325 = f32[128]{0} divide(multiply.318, broadcast.306)
  add.326 = f32[128]{0} add(subtract.324, divide.325)
  multiply.319 = f32[128]{0} multiply(multiply.318, subtract.314)
  constant.303 = f32[] constant(120)
  broadcast.304 = f32[128]{0} broadcast(constant.303), dimensions={}
  divide.327 = f32[128]{0} divide(multiply.319, broadcast.304)
  subtract.328 = f32[128]{0} subtract(add.326, divide.327)
  reshape.384 = f32[1,128]{1,0} reshape(subtract.328)
  broadcast.385 = f32[1,128]{1,0} broadcast(reshape.384), dimensions={0,1}
  reshape.386 = f32[128]{0} reshape(broadcast.385)
  broadcast.387 = f32[128,128]{1,0} broadcast(reshape.386), dimensions={1}
  multiply.388 = f32[128,128]{0,1} multiply(transpose.383, broadcast.387)
  slice.389 = s32[1]{0} slice(Arg_4.284), slice={[1:2]}
  reshape.390 = s32[] reshape(slice.389)
  broadcast.391 = s32[128]{0} broadcast(reshape.390), dimensions={}
  add.392 = s32[128]{0} add(convert.315, broadcast.391)
  call.393 = f32[128,128]{1,0} call(Arg_0.280, add.392), to_apply=_roll_dynamic.79
  transpose.394 = f32[128,128]{0,1} transpose(call.393), dimensions={1,0}
  constant.301 = f32[] constant(2)
  broadcast.302 = f32[128]{0} broadcast(constant.301), dimensions={}
  divide.329 = f32[128]{0} divide(subtract.314, broadcast.302)
  negate.330 = f32[128]{0} negate(divide.329)
  multiply.331 = f32[128]{0} multiply(multiply.316, broadcast.302)
  constant.299 = f32[] constant(3)
  broadcast.300 = f32[128]{0} broadcast(constant.299), dimensions={}
  divide.332 = f32[128]{0} divide(multiply.331, broadcast.300)
  add.333 = f32[128]{0} add(negate.330, divide.332)
  divide.334 = f32[128]{0} divide(multiply.317, broadcast.306)
  subtract.335 = f32[128]{0} subtract(add.333, divide.334)
  constant.297 = f32[] constant(6)
  broadcast.298 = f32[128]{0} broadcast(constant.297), dimensions={}
  divide.336 = f32[128]{0} divide(multiply.318, broadcast.298)
  subtract.337 = f32[128]{0} subtract(subtract.335, divide.336)
  divide.338 = f32[128]{0} divide(multiply.319, broadcast.306)
  add.339 = f32[128]{0} add(subtract.337, divide.338)
  reshape.395 = f32[1,128]{1,0} reshape(add.339)
  broadcast.396 = f32[1,128]{1,0} broadcast(reshape.395), dimensions={0,1}
  reshape.397 = f32[128]{0} reshape(broadcast.396)
  broadcast.398 = f32[128,128]{1,0} broadcast(reshape.397), dimensions={1}
  multiply.399 = f32[128,128]{0,1} multiply(transpose.394, broadcast.398)
  add.400 = f32[128,128]{0,1} add(multiply.388, multiply.399)
  slice.401 = s32[1]{0} slice(Arg_4.284), slice={[2:3]}
  reshape.402 = s32[] reshape(slice.401)
  broadcast.403 = s32[128]{0} broadcast(reshape.402), dimensions={}
  add.404 = s32[128]{0} add(convert.315, broadcast.403)
  call.405 = f32[128,128]{1,0} call(Arg_0.280, add.404), to_apply=_roll_dynamic.124
  transpose.406 = f32[128,128]{0,1} transpose(call.405), dimensions={1,0}
  constant.295 = f32[] constant(1)
  broadcast.296 = f32[128]{0} broadcast(constant.295), dimensions={}
  divide.340 = f32[128]{0} divide(subtract.314, broadcast.300)
  subtract.341 = f32[128]{0} subtract(broadcast.296, divide.340)
  constant.293 = f32[] constant(5)
  broadcast.294 = f32[128]{0} broadcast(constant.293), dimensions={}
  multiply.342 = f32[128]{0} multiply(multiply.316, broadcast.294)
  constant.291 = f32[] constant(4)
  broadcast.292 = f32[128]{0} broadcast(constant.291), dimensions={}
  divide.343 = f32[128]{0} divide(multiply.342, broadcast.292)
  subtract.344 = f32[128]{0} subtract(subtract.341, divide.343)
  multiply.345 = f32[128]{0} multiply(multiply.317, broadcast.294)
  constant.289 = f32[] constant(12)
  broadcast.290 = f32[128]{0} broadcast(constant.289), dimensions={}
  divide.346 = f32[128]{0} divide(multiply.345, broadcast.290)
  add.347 = f32[128]{0} add(subtract.344, divide.346)
  divide.348 = f32[128]{0} divide(multiply.318, broadcast.292)
  add.349 = f32[128]{0} add(add.347, divide.348)
  divide.350 = f32[128]{0} divide(multiply.319, broadcast.290)
  subtract.351 = f32[128]{0} subtract(add.349, divide.350)
  reshape.407 = f32[1,128]{1,0} reshape(subtract.351)
  broadcast.408 = f32[1,128]{1,0} broadcast(reshape.407), dimensions={0,1}
  reshape.409 = f32[128]{0} reshape(broadcast.408)
  broadcast.410 = f32[128,128]{1,0} broadcast(reshape.409), dimensions={1}
  multiply.411 = f32[128,128]{0,1} multiply(transpose.406, broadcast.410)
  add.412 = f32[128,128]{0,1} add(add.400, multiply.411)
  slice.413 = s32[1]{0} slice(Arg_4.284), slice={[3:4]}
  reshape.414 = s32[] reshape(slice.413)
  broadcast.415 = s32[128]{0} broadcast(reshape.414), dimensions={}
  add.416 = s32[128]{0} add(convert.315, broadcast.415)
  call.417 = f32[128,128]{1,0} call(Arg_0.280, add.416), to_apply=_roll_dynamic.169
  transpose.418 = f32[128,128]{0,1} transpose(call.417), dimensions={1,0}
  multiply.352 = f32[128]{0} multiply(multiply.316, broadcast.302)
  divide.353 = f32[128]{0} divide(multiply.352, broadcast.300)
  add.354 = f32[128]{0} add(subtract.314, divide.353)
  constant.287 = f32[] constant(7)
  broadcast.288 = f32[128]{0} broadcast(constant.287), dimensions={}
  multiply.355 = f32[128]{0} multiply(multiply.317, broadcast.288)
  divide.356 = f32[128]{0} divide(multiply.355, broadcast.290)
  subtract.357 = f32[128]{0} subtract(add.354, divide.356)
  divide.358 = f32[128]{0} divide(multiply.318, broadcast.298)
  subtract.359 = f32[128]{0} subtract(subtract.357, divide.358)
  divide.360 = f32[128]{0} divide(multiply.319, broadcast.290)
  add.361 = f32[128]{0} add(subtract.359, divide.360)
  reshape.419 = f32[1,128]{1,0} reshape(add.361)
  broadcast.420 = f32[1,128]{1,0} broadcast(reshape.419), dimensions={0,1}
  reshape.421 = f32[128]{0} reshape(broadcast.420)
  broadcast.422 = f32[128,128]{1,0} broadcast(reshape.421), dimensions={1}
  multiply.423 = f32[128,128]{0,1} multiply(transpose.418, broadcast.422)
  add.424 = f32[128,128]{0,1} add(add.412, multiply.423)
  slice.425 = s32[1]{0} slice(Arg_4.284), slice={[4:5]}
  reshape.426 = s32[] reshape(slice.425)
  broadcast.427 = s32[128]{0} broadcast(reshape.426), dimensions={}
  add.428 = s32[128]{0} add(convert.315, broadcast.427)
  call.429 = f32[128,128]{1,0} call(Arg_0.280, add.428), to_apply=_roll_dynamic.214
  transpose.430 = f32[128,128]{0,1} transpose(call.429), dimensions={1,0}
  divide.362 = f32[128]{0} divide(subtract.314, broadcast.292)
  negate.363 = f32[128]{0} negate(divide.362)
  divide.364 = f32[128]{0} divide(multiply.316, broadcast.306)
  subtract.365 = f32[128]{0} subtract(negate.363, divide.364)
  multiply.366 = f32[128]{0} multiply(multiply.317, broadcast.288)
  divide.367 = f32[128]{0} divide(multiply.366, broadcast.306)
  add.368 = f32[128]{0} add(subtract.365, divide.367)
  divide.369 = f32[128]{0} divide(multiply.318, broadcast.306)
  add.370 = f32[128]{0} add(add.368, divide.369)
  divide.371 = f32[128]{0} divide(multiply.319, broadcast.306)
  subtract.372 = f32[128]{0} subtract(add.370, divide.371)
  reshape.431 = f32[1,128]{1,0} reshape(subtract.372)
  broadcast.432 = f32[1,128]{1,0} broadcast(reshape.431), dimensions={0,1}
  reshape.433 = f32[128]{0} reshape(broadcast.432)
  broadcast.434 = f32[128,128]{1,0} broadcast(reshape.433), dimensions={1}
  multiply.435 = f32[128,128]{0,1} multiply(transpose.430, broadcast.434)
  add.436 = f32[128,128]{0,1} add(add.424, multiply.435)
  slice.437 = s32[1]{0} slice(Arg_4.284), slice={[5:6]}
  reshape.438 = s32[] reshape(slice.437)
  broadcast.439 = s32[128]{0} broadcast(reshape.438), dimensions={}
  add.440 = s32[128]{0} add(convert.315, broadcast.439)
  call.441 = f32[128,128]{1,0} call(Arg_0.280, add.440), to_apply=_roll_dynamic.259
  transpose.442 = f32[128,128]{0,1} transpose(call.441), dimensions={1,0}
  constant.285 = f32[] constant(30)
  broadcast.286 = f32[128]{0} broadcast(constant.285), dimensions={}
  divide.373 = f32[128]{0} divide(subtract.314, broadcast.286)
  divide.374 = f32[128]{0} divide(multiply.317, broadcast.306)
  subtract.375 = f32[128]{0} subtract(divide.373, divide.374)
  divide.376 = f32[128]{0} divide(multiply.319, broadcast.304)
  add.377 = f32[128]{0} add(subtract.375, divide.376)
  reshape.443 = f32[1,128]{1,0} reshape(add.377)
  broadcast.444 = f32[1,128]{1,0} broadcast(reshape.443), dimensions={0,1}
  reshape.445 = f32[128]{0} reshape(broadcast.444)
  broadcast.446 = f32[128,128]{1,0} broadcast(reshape.445), dimensions={1}
  multiply.447 = f32[128,128]{0,1} multiply(transpose.442, broadcast.446)
  ROOT add.448 = f32[128,128]{0,1} add(add.436, multiply.447)
}

region_0.450 {
  Arg_0.451 = f32[] parameter(0)
  Arg_1.452 = f32[] parameter(1)
  ROOT add.453 = f32[] add(Arg_0.451, Arg_1.452)
}

fft.454 {
  Arg_0.455 = f32[128]{0} parameter(0)
  ROOT fft.456 = c64[65]{0} fft(Arg_0.455), fft_type=RFFT, fft_length={128}
}

fft_0.457 {
  Arg_0.458 = c64[65]{0} parameter(0)
  ROOT fft.459 = f32[128]{0} fft(Arg_0.458), fft_type=IRFFT, fft_length={128}
}

fft_0.460 {
  Arg_0.461 = c64[65]{0} parameter(0)
  ROOT fft.462 = f32[128]{0} fft(Arg_0.461), fft_type=IRFFT, fft_length={128}
}

solve_poisson.463 {
  Arg_0.464 = f32[128,128]{1,0} parameter(0)
  constant.471 = f32[] constant(0)
  reduce.472 = f32[128]{0} reduce(Arg_0.464, constant.471), dimensions={1}, to_apply=region_0.450
  Arg_2.466 = f32[] parameter(2)
  broadcast.473 = f32[128]{0} broadcast(Arg_2.466), dimensions={}
  multiply.474 = f32[128]{0} multiply(reduce.472, broadcast.473)
  constant.469 = f32[] constant(1)
  broadcast.470 = f32[128]{0} broadcast(constant.469), dimensions={}
  subtract.475 = f32[128]{0} subtract(multiply.474, broadcast.470)
  call.476 = c64[65]{0} call(subtract.475), to_apply=fft.454
  constant.467 = c64[] constant((-0, -1))
  broadcast.468 = c64[65]{0} broadcast(constant.467), dimensions={}
  multiply.477 = c64[65]{0} multiply(call.476, broadcast.468)
  Arg_1.465 = f32[65]{0} parameter(1)
  convert.478 = c64[65]{0} convert(Arg_1.465)
  multiply.479 = c64[65]{0} multiply(multiply.477, convert.478)
  call.480 = f32[128]{0} call(multiply.479), to_apply=fft_0.457
  multiply.481 = f32[65]{0} multiply(Arg_1.465, Arg_1.465)
  convert.482 = c64[65]{0} convert(multiply.481)
  multiply.483 = c64[65]{0} multiply(call.476, convert.482)
  call.484 = f32[128]{0} call(multiply.483), to_apply=fft_0.460
  ROOT tuple.485 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) tuple(call.480, subtract.475, call.484)
}

_where_2.490 {
  Arg_0.491 = pred[6,128,128]{2,1,0} parameter(0)
  Arg_1.492 = f32[6,128,1]{2,1,0} parameter(1)
  broadcast.494 = f32[6,128,1]{2,1,0} broadcast(Arg_1.492), dimensions={0,1,2}
  reshape.495 = f32[6,128]{1,0} reshape(broadcast.494)
  broadcast.496 = f32[6,128,128]{2,1,0} broadcast(reshape.495), dimensions={0,1}
  Arg_2.493 = f32[] parameter(2)
  broadcast.497 = f32[6,128,128]{2,1,0} broadcast(Arg_2.493), dimensions={}
  ROOT select.498 = f32[6,128,128]{2,1,0} select(Arg_0.491, broadcast.496, broadcast.497)
}

build_v_diag_weights.499 {
  iota.601 = s32[128]{0} iota(), iota_dimension=0
  reshape.611 = s32[1,1,128]{2,1,0} reshape(iota.601)
  broadcast.613 = s32[1,1,128]{2,1,0} broadcast(reshape.611), dimensions={0,1,2}
  reshape.614 = s32[128]{0} reshape(broadcast.613)
  broadcast.615 = s32[6,128,128]{2,1,0} broadcast(reshape.614), dimensions={2}
  Arg_0.500 = s32[6]{0} parameter(0)
  reshape.602 = s32[6,1]{1,0} reshape(Arg_0.500)
  broadcast.604 = s32[6,1]{1,0} broadcast(reshape.602), dimensions={0,1}
  reshape.605 = s32[6]{0} reshape(broadcast.604)
  broadcast.606 = s32[6,128]{1,0} broadcast(reshape.605), dimensions={0}
  Arg_1.501 = s32[128]{0} parameter(1)
  reshape.603 = s32[1,128]{1,0} reshape(Arg_1.501)
  broadcast.607 = s32[1,128]{1,0} broadcast(reshape.603), dimensions={0,1}
  reshape.608 = s32[128]{0} reshape(broadcast.607)
  broadcast.609 = s32[6,128]{1,0} broadcast(reshape.608), dimensions={1}
  add.610 = s32[6,128]{1,0} add(broadcast.606, broadcast.609)
  reshape.612 = s32[6,128,1]{2,1,0} reshape(add.610)
  broadcast.616 = s32[6,128,1]{2,1,0} broadcast(reshape.612), dimensions={0,1,2}
  reshape.617 = s32[6,128]{1,0} reshape(broadcast.616)
  broadcast.618 = s32[6,128,128]{2,1,0} broadcast(reshape.617), dimensions={0,1}
  subtract.619 = s32[6,128,128]{2,1,0} subtract(broadcast.615, broadcast.618)
  constant.505 = s32[] constant(0)
  broadcast.506 = s32[6,128,128]{2,1,0} broadcast(constant.505), dimensions={}
  compare.620 = pred[6,128,128]{2,1,0} compare(subtract.619, broadcast.506), direction=GE
  constant.503 = s32[] constant(128)
  broadcast.504 = s32[6,128,128]{2,1,0} broadcast(constant.503), dimensions={}
  compare.621 = pred[6,128,128]{2,1,0} compare(subtract.619, broadcast.504), direction=LT
  and.622 = pred[6,128,128]{2,1,0} and(compare.620, compare.621)
  Arg_2.502 = f32[128]{0} parameter(2)
  constant.529 = f32[] constant(20)
  broadcast.530 = f32[128]{0} broadcast(constant.529), dimensions={}
  divide.536 = f32[128]{0} divide(Arg_2.502, broadcast.530)
  multiply.532 = f32[128]{0} multiply(Arg_2.502, Arg_2.502)
  constant.527 = f32[] constant(24)
  broadcast.528 = f32[128]{0} broadcast(constant.527), dimensions={}
  divide.537 = f32[128]{0} divide(multiply.532, broadcast.528)
  subtract.538 = f32[128]{0} subtract(divide.536, divide.537)
  multiply.533 = f32[128]{0} multiply(multiply.532, Arg_2.502)
  divide.539 = f32[128]{0} divide(multiply.533, broadcast.528)
  subtract.540 = f32[128]{0} subtract(subtract.538, divide.539)
  multiply.534 = f32[128]{0} multiply(multiply.533, Arg_2.502)
  divide.541 = f32[128]{0} divide(multiply.534, broadcast.528)
  add.542 = f32[128]{0} add(subtract.540, divide.541)
  multiply.535 = f32[128]{0} multiply(multiply.534, Arg_2.502)
  constant.525 = f32[] constant(120)
  broadcast.526 = f32[128]{0} broadcast(constant.525), dimensions={}
  divide.543 = f32[128]{0} divide(multiply.535, broadcast.526)
  subtract.544 = f32[128]{0} subtract(add.542, divide.543)
  reshape.594 = f32[1,128]{1,0} reshape(subtract.544)
  constant.523 = f32[] constant(2)
  broadcast.524 = f32[128]{0} broadcast(constant.523), dimensions={}
  divide.545 = f32[128]{0} divide(Arg_2.502, broadcast.524)
  negate.546 = f32[128]{0} negate(divide.545)
  multiply.547 = f32[128]{0} multiply(multiply.532, broadcast.524)
  constant.521 = f32[] constant(3)
  broadcast.522 = f32[128]{0} broadcast(constant.521), dimensions={}
  divide.548 = f32[128]{0} divide(multiply.547, broadcast.522)
  add.549 = f32[128]{0} add(negate.546, divide.548)
  divide.550 = f32[128]{0} divide(multiply.533, broadcast.528)
  subtract.551 = f32[128]{0} subtract(add.549, divide.550)
  constant.519 = f32[] constant(6)
  broadcast.520 = f32[128]{0} broadcast(constant.519), dimensions={}
  divide.552 = f32[128]{0} divide(multiply.534, broadcast.520)
  subtract.553 = f32[128]{0} subtract(subtract.551, divide.552)
  divide.554 = f32[128]{0} divide(multiply.535, broadcast.528)
  add.555 = f32[128]{0} add(subtract.553, divide.554)
  reshape.595 = f32[1,128]{1,0} reshape(add.555)
  constant.517 = f32[] constant(1)
  broadcast.518 = f32[128]{0} broadcast(constant.517), dimensions={}
  divide.556 = f32[128]{0} divide(Arg_2.502, broadcast.522)
  subtract.557 = f32[128]{0} subtract(broadcast.518, divide.556)
  constant.515 = f32[] constant(5)
  broadcast.516 = f32[128]{0} broadcast(constant.515), dimensions={}
  multiply.558 = f32[128]{0} multiply(multiply.532, broadcast.516)
  constant.513 = f32[] constant(4)
  broadcast.514 = f32[128]{0} broadcast(constant.513), dimensions={}
  divide.559 = f32[128]{0} divide(multiply.558, broadcast.514)
  subtract.560 = f32[128]{0} subtract(subtract.557, divide.559)
  multiply.561 = f32[128]{0} multiply(multiply.533, broadcast.516)
  constant.511 = f32[] constant(12)
  broadcast.512 = f32[128]{0} broadcast(constant.511), dimensions={}
  divide.562 = f32[128]{0} divide(multiply.561, broadcast.512)
  add.563 = f32[128]{0} add(subtract.560, divide.562)
  divide.564 = f32[128]{0} divide(multiply.534, broadcast.514)
  add.565 = f32[128]{0} add(add.563, divide.564)
  divide.566 = f32[128]{0} divide(multiply.535, broadcast.512)
  subtract.567 = f32[128]{0} subtract(add.565, divide.566)
  reshape.596 = f32[1,128]{1,0} reshape(subtract.567)
  multiply.568 = f32[128]{0} multiply(multiply.532, broadcast.524)
  divide.569 = f32[128]{0} divide(multiply.568, broadcast.522)
  add.570 = f32[128]{0} add(Arg_2.502, divide.569)
  constant.509 = f32[] constant(7)
  broadcast.510 = f32[128]{0} broadcast(constant.509), dimensions={}
  multiply.571 = f32[128]{0} multiply(multiply.533, broadcast.510)
  divide.572 = f32[128]{0} divide(multiply.571, broadcast.512)
  subtract.573 = f32[128]{0} subtract(add.570, divide.572)
  divide.574 = f32[128]{0} divide(multiply.534, broadcast.520)
  subtract.575 = f32[128]{0} subtract(subtract.573, divide.574)
  divide.576 = f32[128]{0} divide(multiply.535, broadcast.512)
  add.577 = f32[128]{0} add(subtract.575, divide.576)
  reshape.597 = f32[1,128]{1,0} reshape(add.577)
  divide.578 = f32[128]{0} divide(Arg_2.502, broadcast.514)
  negate.579 = f32[128]{0} negate(divide.578)
  divide.580 = f32[128]{0} divide(multiply.532, broadcast.528)
  subtract.581 = f32[128]{0} subtract(negate.579, divide.580)
  multiply.582 = f32[128]{0} multiply(multiply.533, broadcast.510)
  divide.583 = f32[128]{0} divide(multiply.582, broadcast.528)
  add.584 = f32[128]{0} add(subtract.581, divide.583)
  divide.585 = f32[128]{0} divide(multiply.534, broadcast.528)
  add.586 = f32[128]{0} add(add.584, divide.585)
  divide.587 = f32[128]{0} divide(multiply.535, broadcast.528)
  subtract.588 = f32[128]{0} subtract(add.586, divide.587)
  reshape.598 = f32[1,128]{1,0} reshape(subtract.588)
  constant.507 = f32[] constant(30)
  broadcast.508 = f32[128]{0} broadcast(constant.507), dimensions={}
  divide.589 = f32[128]{0} divide(Arg_2.502, broadcast.508)
  divide.590 = f32[128]{0} divide(multiply.533, broadcast.528)
  subtract.591 = f32[128]{0} subtract(divide.589, divide.590)
  divide.592 = f32[128]{0} divide(multiply.535, broadcast.526)
  add.593 = f32[128]{0} add(subtract.591, divide.592)
  reshape.599 = f32[1,128]{1,0} reshape(add.593)
  concatenate.600 = f32[6,128]{1,0} concatenate(reshape.594, reshape.595, reshape.596, reshape.597, reshape.598, reshape.599), dimensions={0}
  reshape.623 = f32[6,128,1]{2,1,0} reshape(concatenate.600)
  constant.531 = f32[] constant(0)
  ROOT call.624 = f32[6,128,128]{2,1,0} call(and.622, reshape.623, constant.531), to_apply=_where_2.490
}

_where.625 {
  Arg_0.626 = pred[] parameter(0)
  Arg_1.627 = s32[] parameter(1)
  Arg_2.628 = s32[] parameter(2)
  ROOT select.629 = s32[] select(Arg_0.626, Arg_1.627, Arg_2.628)
}

remainder.630 {
  Arg_0.631 = s32[128]{0} parameter(0)
  Arg_1.632 = s32[] parameter(1)
  constant.636 = s32[] constant(0)
  compare.637 = pred[] compare(Arg_1.632, constant.636), direction=EQ
  constant.635 = s32[] constant(1)
  call.638 = s32[] call(compare.637, constant.635, Arg_1.632), to_apply=_where.625
  broadcast.639 = s32[128]{0} broadcast(call.638), dimensions={}
  remainder.640 = s32[128]{0} remainder(Arg_0.631, broadcast.639)
  constant.633 = s32[] constant(0)
  broadcast.634 = s32[128]{0} broadcast(constant.633), dimensions={}
  compare.642 = pred[128]{0} compare(remainder.640, broadcast.634), direction=LT
  compare.643 = pred[] compare(call.638, constant.636), direction=LT
  broadcast.644 = pred[128]{0} broadcast(compare.643), dimensions={}
  compare.645 = pred[128]{0} compare(compare.642, broadcast.644), direction=NE
  compare.641 = pred[128]{0} compare(remainder.640, broadcast.634), direction=NE
  and.646 = pred[128]{0} and(compare.645, compare.641)
  broadcast.647 = s32[128]{0} broadcast(call.638), dimensions={}
  add.648 = s32[128]{0} add(remainder.640, broadcast.647)
  ROOT select.649 = s32[128]{0} select(and.646, add.648, remainder.640)
}

_roll_dynamic_3.650 {
  Arg_0.651 = f32[128,128]{1,0} parameter(0)
  concatenate.661 = f32[128,256]{1,0} concatenate(Arg_0.651, Arg_0.651), dimensions={1}
  constant.657 = s32[] constant(128)
  broadcast.658 = s32[128]{0} broadcast(constant.657), dimensions={}
  Arg_1.652 = s32[128]{0} parameter(1)
  constant.659 = s32[] constant(128)
  call.660 = s32[128]{0} call(Arg_1.652, constant.659), to_apply=remainder.630
  subtract.662 = s32[128]{0} subtract(broadcast.658, call.660)
  constant.655 = s32[] constant(0)
  broadcast.656 = s32[128]{0} broadcast(constant.655), dimensions={}
  compare.663 = pred[128]{0} compare(subtract.662, broadcast.656), direction=LT
  constant.653 = s32[] constant(256)
  broadcast.654 = s32[128]{0} broadcast(constant.653), dimensions={}
  add.664 = s32[128]{0} add(subtract.662, broadcast.654)
  select.665 = s32[128]{0} select(compare.663, add.664, subtract.662)
  reshape.666 = s32[128,1]{1,0} reshape(select.665)
  ROOT gather.667 = f32[128,128]{1,0} gather(concatenate.661, reshape.666), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.668 {
  Arg_0.669 = pred[] parameter(0)
  Arg_1.670 = s32[] parameter(1)
  Arg_2.671 = s32[] parameter(2)
  ROOT select.672 = s32[] select(Arg_0.669, Arg_1.670, Arg_2.671)
}

remainder.673 {
  Arg_0.674 = s32[128]{0} parameter(0)
  Arg_1.675 = s32[] parameter(1)
  constant.679 = s32[] constant(0)
  compare.680 = pred[] compare(Arg_1.675, constant.679), direction=EQ
  constant.678 = s32[] constant(1)
  call.681 = s32[] call(compare.680, constant.678, Arg_1.675), to_apply=_where.668
  broadcast.682 = s32[128]{0} broadcast(call.681), dimensions={}
  remainder.683 = s32[128]{0} remainder(Arg_0.674, broadcast.682)
  constant.676 = s32[] constant(0)
  broadcast.677 = s32[128]{0} broadcast(constant.676), dimensions={}
  compare.685 = pred[128]{0} compare(remainder.683, broadcast.677), direction=LT
  compare.686 = pred[] compare(call.681, constant.679), direction=LT
  broadcast.687 = pred[128]{0} broadcast(compare.686), dimensions={}
  compare.688 = pred[128]{0} compare(compare.685, broadcast.687), direction=NE
  compare.684 = pred[128]{0} compare(remainder.683, broadcast.677), direction=NE
  and.689 = pred[128]{0} and(compare.688, compare.684)
  broadcast.690 = s32[128]{0} broadcast(call.681), dimensions={}
  add.691 = s32[128]{0} add(remainder.683, broadcast.690)
  ROOT select.692 = s32[128]{0} select(and.689, add.691, remainder.683)
}

_roll_dynamic_3.693 {
  Arg_0.694 = f32[128,128]{1,0} parameter(0)
  concatenate.704 = f32[128,256]{1,0} concatenate(Arg_0.694, Arg_0.694), dimensions={1}
  constant.700 = s32[] constant(128)
  broadcast.701 = s32[128]{0} broadcast(constant.700), dimensions={}
  Arg_1.695 = s32[128]{0} parameter(1)
  constant.702 = s32[] constant(128)
  call.703 = s32[128]{0} call(Arg_1.695, constant.702), to_apply=remainder.673
  subtract.705 = s32[128]{0} subtract(broadcast.701, call.703)
  constant.698 = s32[] constant(0)
  broadcast.699 = s32[128]{0} broadcast(constant.698), dimensions={}
  compare.706 = pred[128]{0} compare(subtract.705, broadcast.699), direction=LT
  constant.696 = s32[] constant(256)
  broadcast.697 = s32[128]{0} broadcast(constant.696), dimensions={}
  add.707 = s32[128]{0} add(subtract.705, broadcast.697)
  select.708 = s32[128]{0} select(compare.706, add.707, subtract.705)
  reshape.709 = s32[128,1]{1,0} reshape(select.708)
  ROOT gather.710 = f32[128,128]{1,0} gather(concatenate.704, reshape.709), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.711 {
  Arg_0.712 = pred[] parameter(0)
  Arg_1.713 = s32[] parameter(1)
  Arg_2.714 = s32[] parameter(2)
  ROOT select.715 = s32[] select(Arg_0.712, Arg_1.713, Arg_2.714)
}

remainder.716 {
  Arg_0.717 = s32[128]{0} parameter(0)
  Arg_1.718 = s32[] parameter(1)
  constant.722 = s32[] constant(0)
  compare.723 = pred[] compare(Arg_1.718, constant.722), direction=EQ
  constant.721 = s32[] constant(1)
  call.724 = s32[] call(compare.723, constant.721, Arg_1.718), to_apply=_where.711
  broadcast.725 = s32[128]{0} broadcast(call.724), dimensions={}
  remainder.726 = s32[128]{0} remainder(Arg_0.717, broadcast.725)
  constant.719 = s32[] constant(0)
  broadcast.720 = s32[128]{0} broadcast(constant.719), dimensions={}
  compare.728 = pred[128]{0} compare(remainder.726, broadcast.720), direction=LT
  compare.729 = pred[] compare(call.724, constant.722), direction=LT
  broadcast.730 = pred[128]{0} broadcast(compare.729), dimensions={}
  compare.731 = pred[128]{0} compare(compare.728, broadcast.730), direction=NE
  compare.727 = pred[128]{0} compare(remainder.726, broadcast.720), direction=NE
  and.732 = pred[128]{0} and(compare.731, compare.727)
  broadcast.733 = s32[128]{0} broadcast(call.724), dimensions={}
  add.734 = s32[128]{0} add(remainder.726, broadcast.733)
  ROOT select.735 = s32[128]{0} select(and.732, add.734, remainder.726)
}

_roll_dynamic_3.736 {
  Arg_0.737 = f32[128,128]{1,0} parameter(0)
  concatenate.747 = f32[128,256]{1,0} concatenate(Arg_0.737, Arg_0.737), dimensions={1}
  constant.743 = s32[] constant(128)
  broadcast.744 = s32[128]{0} broadcast(constant.743), dimensions={}
  Arg_1.738 = s32[128]{0} parameter(1)
  constant.745 = s32[] constant(128)
  call.746 = s32[128]{0} call(Arg_1.738, constant.745), to_apply=remainder.716
  subtract.748 = s32[128]{0} subtract(broadcast.744, call.746)
  constant.741 = s32[] constant(0)
  broadcast.742 = s32[128]{0} broadcast(constant.741), dimensions={}
  compare.749 = pred[128]{0} compare(subtract.748, broadcast.742), direction=LT
  constant.739 = s32[] constant(256)
  broadcast.740 = s32[128]{0} broadcast(constant.739), dimensions={}
  add.750 = s32[128]{0} add(subtract.748, broadcast.740)
  select.751 = s32[128]{0} select(compare.749, add.750, subtract.748)
  reshape.752 = s32[128,1]{1,0} reshape(select.751)
  ROOT gather.753 = f32[128,128]{1,0} gather(concatenate.747, reshape.752), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.754 {
  Arg_0.755 = pred[] parameter(0)
  Arg_1.756 = s32[] parameter(1)
  Arg_2.757 = s32[] parameter(2)
  ROOT select.758 = s32[] select(Arg_0.755, Arg_1.756, Arg_2.757)
}

remainder.759 {
  Arg_0.760 = s32[128]{0} parameter(0)
  Arg_1.761 = s32[] parameter(1)
  constant.765 = s32[] constant(0)
  compare.766 = pred[] compare(Arg_1.761, constant.765), direction=EQ
  constant.764 = s32[] constant(1)
  call.767 = s32[] call(compare.766, constant.764, Arg_1.761), to_apply=_where.754
  broadcast.768 = s32[128]{0} broadcast(call.767), dimensions={}
  remainder.769 = s32[128]{0} remainder(Arg_0.760, broadcast.768)
  constant.762 = s32[] constant(0)
  broadcast.763 = s32[128]{0} broadcast(constant.762), dimensions={}
  compare.771 = pred[128]{0} compare(remainder.769, broadcast.763), direction=LT
  compare.772 = pred[] compare(call.767, constant.765), direction=LT
  broadcast.773 = pred[128]{0} broadcast(compare.772), dimensions={}
  compare.774 = pred[128]{0} compare(compare.771, broadcast.773), direction=NE
  compare.770 = pred[128]{0} compare(remainder.769, broadcast.763), direction=NE
  and.775 = pred[128]{0} and(compare.774, compare.770)
  broadcast.776 = s32[128]{0} broadcast(call.767), dimensions={}
  add.777 = s32[128]{0} add(remainder.769, broadcast.776)
  ROOT select.778 = s32[128]{0} select(and.775, add.777, remainder.769)
}

_roll_dynamic_3.779 {
  Arg_0.780 = f32[128,128]{1,0} parameter(0)
  concatenate.790 = f32[128,256]{1,0} concatenate(Arg_0.780, Arg_0.780), dimensions={1}
  constant.786 = s32[] constant(128)
  broadcast.787 = s32[128]{0} broadcast(constant.786), dimensions={}
  Arg_1.781 = s32[128]{0} parameter(1)
  constant.788 = s32[] constant(128)
  call.789 = s32[128]{0} call(Arg_1.781, constant.788), to_apply=remainder.759
  subtract.791 = s32[128]{0} subtract(broadcast.787, call.789)
  constant.784 = s32[] constant(0)
  broadcast.785 = s32[128]{0} broadcast(constant.784), dimensions={}
  compare.792 = pred[128]{0} compare(subtract.791, broadcast.785), direction=LT
  constant.782 = s32[] constant(256)
  broadcast.783 = s32[128]{0} broadcast(constant.782), dimensions={}
  add.793 = s32[128]{0} add(subtract.791, broadcast.783)
  select.794 = s32[128]{0} select(compare.792, add.793, subtract.791)
  reshape.795 = s32[128,1]{1,0} reshape(select.794)
  ROOT gather.796 = f32[128,128]{1,0} gather(concatenate.790, reshape.795), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.797 {
  Arg_0.798 = pred[] parameter(0)
  Arg_1.799 = s32[] parameter(1)
  Arg_2.800 = s32[] parameter(2)
  ROOT select.801 = s32[] select(Arg_0.798, Arg_1.799, Arg_2.800)
}

remainder.802 {
  Arg_0.803 = s32[128]{0} parameter(0)
  Arg_1.804 = s32[] parameter(1)
  constant.808 = s32[] constant(0)
  compare.809 = pred[] compare(Arg_1.804, constant.808), direction=EQ
  constant.807 = s32[] constant(1)
  call.810 = s32[] call(compare.809, constant.807, Arg_1.804), to_apply=_where.797
  broadcast.811 = s32[128]{0} broadcast(call.810), dimensions={}
  remainder.812 = s32[128]{0} remainder(Arg_0.803, broadcast.811)
  constant.805 = s32[] constant(0)
  broadcast.806 = s32[128]{0} broadcast(constant.805), dimensions={}
  compare.814 = pred[128]{0} compare(remainder.812, broadcast.806), direction=LT
  compare.815 = pred[] compare(call.810, constant.808), direction=LT
  broadcast.816 = pred[128]{0} broadcast(compare.815), dimensions={}
  compare.817 = pred[128]{0} compare(compare.814, broadcast.816), direction=NE
  compare.813 = pred[128]{0} compare(remainder.812, broadcast.806), direction=NE
  and.818 = pred[128]{0} and(compare.817, compare.813)
  broadcast.819 = s32[128]{0} broadcast(call.810), dimensions={}
  add.820 = s32[128]{0} add(remainder.812, broadcast.819)
  ROOT select.821 = s32[128]{0} select(and.818, add.820, remainder.812)
}

_roll_dynamic_3.822 {
  Arg_0.823 = f32[128,128]{1,0} parameter(0)
  concatenate.833 = f32[128,256]{1,0} concatenate(Arg_0.823, Arg_0.823), dimensions={1}
  constant.829 = s32[] constant(128)
  broadcast.830 = s32[128]{0} broadcast(constant.829), dimensions={}
  Arg_1.824 = s32[128]{0} parameter(1)
  constant.831 = s32[] constant(128)
  call.832 = s32[128]{0} call(Arg_1.824, constant.831), to_apply=remainder.802
  subtract.834 = s32[128]{0} subtract(broadcast.830, call.832)
  constant.827 = s32[] constant(0)
  broadcast.828 = s32[128]{0} broadcast(constant.827), dimensions={}
  compare.835 = pred[128]{0} compare(subtract.834, broadcast.828), direction=LT
  constant.825 = s32[] constant(256)
  broadcast.826 = s32[128]{0} broadcast(constant.825), dimensions={}
  add.836 = s32[128]{0} add(subtract.834, broadcast.826)
  select.837 = s32[128]{0} select(compare.835, add.836, subtract.834)
  reshape.838 = s32[128,1]{1,0} reshape(select.837)
  ROOT gather.839 = f32[128,128]{1,0} gather(concatenate.833, reshape.838), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.840 {
  Arg_0.841 = pred[] parameter(0)
  Arg_1.842 = s32[] parameter(1)
  Arg_2.843 = s32[] parameter(2)
  ROOT select.844 = s32[] select(Arg_0.841, Arg_1.842, Arg_2.843)
}

remainder.845 {
  Arg_0.846 = s32[128]{0} parameter(0)
  Arg_1.847 = s32[] parameter(1)
  constant.851 = s32[] constant(0)
  compare.852 = pred[] compare(Arg_1.847, constant.851), direction=EQ
  constant.850 = s32[] constant(1)
  call.853 = s32[] call(compare.852, constant.850, Arg_1.847), to_apply=_where.840
  broadcast.854 = s32[128]{0} broadcast(call.853), dimensions={}
  remainder.855 = s32[128]{0} remainder(Arg_0.846, broadcast.854)
  constant.848 = s32[] constant(0)
  broadcast.849 = s32[128]{0} broadcast(constant.848), dimensions={}
  compare.857 = pred[128]{0} compare(remainder.855, broadcast.849), direction=LT
  compare.858 = pred[] compare(call.853, constant.851), direction=LT
  broadcast.859 = pred[128]{0} broadcast(compare.858), dimensions={}
  compare.860 = pred[128]{0} compare(compare.857, broadcast.859), direction=NE
  compare.856 = pred[128]{0} compare(remainder.855, broadcast.849), direction=NE
  and.861 = pred[128]{0} and(compare.860, compare.856)
  broadcast.862 = s32[128]{0} broadcast(call.853), dimensions={}
  add.863 = s32[128]{0} add(remainder.855, broadcast.862)
  ROOT select.864 = s32[128]{0} select(and.861, add.863, remainder.855)
}

_roll_dynamic_3.865 {
  Arg_0.866 = f32[128,128]{1,0} parameter(0)
  concatenate.876 = f32[128,256]{1,0} concatenate(Arg_0.866, Arg_0.866), dimensions={1}
  constant.872 = s32[] constant(128)
  broadcast.873 = s32[128]{0} broadcast(constant.872), dimensions={}
  Arg_1.867 = s32[128]{0} parameter(1)
  constant.874 = s32[] constant(128)
  call.875 = s32[128]{0} call(Arg_1.867, constant.874), to_apply=remainder.845
  subtract.877 = s32[128]{0} subtract(broadcast.873, call.875)
  constant.870 = s32[] constant(0)
  broadcast.871 = s32[128]{0} broadcast(constant.870), dimensions={}
  compare.878 = pred[128]{0} compare(subtract.877, broadcast.871), direction=LT
  constant.868 = s32[] constant(256)
  broadcast.869 = s32[128]{0} broadcast(constant.868), dimensions={}
  add.879 = s32[128]{0} add(subtract.877, broadcast.869)
  select.880 = s32[128]{0} select(compare.878, add.879, subtract.877)
  reshape.881 = s32[128,1]{1,0} reshape(select.880)
  ROOT gather.882 = f32[128,128]{1,0} gather(concatenate.876, reshape.881), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

advect_1d_matrix_diag_1.883 {
  Arg_4.888 = s32[6]{0} parameter(4)
  Arg_1.885 = f32[128]{0} parameter(1)
  Arg_2.886 = f32[] parameter(2)
  broadcast.889 = f32[128]{0} broadcast(Arg_2.886), dimensions={}
  multiply.890 = f32[128]{0} multiply(Arg_1.885, broadcast.889)
  Arg_3.887 = f32[] parameter(3)
  broadcast.891 = f32[128]{0} broadcast(Arg_3.887), dimensions={}
  divide.892 = f32[128]{0} divide(multiply.890, broadcast.891)
  floor.893 = f32[128]{0} floor(divide.892)
  convert.895 = s32[128]{0} convert(floor.893)
  subtract.894 = f32[128]{0} subtract(divide.892, floor.893)
  call.896 = f32[6,128,128]{2,1,0} call(Arg_4.888, convert.895, subtract.894), to_apply=build_v_diag_weights.499
  slice.902 = f32[1,128,128]{2,1,0} slice(call.896), slice={[0:1], [0:128], [0:128]}
  reshape.903 = f32[128,128]{1,0} reshape(slice.902)
  Arg_0.884 = f32[128,128]{1,0} parameter(0)
  slice.897 = s32[1]{0} slice(Arg_4.888), slice={[0:1]}
  reshape.898 = s32[] reshape(slice.897)
  broadcast.899 = s32[128]{0} broadcast(reshape.898), dimensions={}
  add.900 = s32[128]{0} add(convert.895, broadcast.899)
  call.901 = f32[128,128]{1,0} call(Arg_0.884, add.900), to_apply=_roll_dynamic_3.650
  multiply.904 = f32[128,128]{1,0} multiply(reshape.903, call.901)
  slice.910 = f32[1,128,128]{2,1,0} slice(call.896), slice={[1:2], [0:128], [0:128]}
  reshape.911 = f32[128,128]{1,0} reshape(slice.910)
  slice.905 = s32[1]{0} slice(Arg_4.888), slice={[1:2]}
  reshape.906 = s32[] reshape(slice.905)
  broadcast.907 = s32[128]{0} broadcast(reshape.906), dimensions={}
  add.908 = s32[128]{0} add(convert.895, broadcast.907)
  call.909 = f32[128,128]{1,0} call(Arg_0.884, add.908), to_apply=_roll_dynamic_3.693
  multiply.912 = f32[128,128]{1,0} multiply(reshape.911, call.909)
  add.913 = f32[128,128]{1,0} add(multiply.904, multiply.912)
  slice.919 = f32[1,128,128]{2,1,0} slice(call.896), slice={[2:3], [0:128], [0:128]}
  reshape.920 = f32[128,128]{1,0} reshape(slice.919)
  slice.914 = s32[1]{0} slice(Arg_4.888), slice={[2:3]}
  reshape.915 = s32[] reshape(slice.914)
  broadcast.916 = s32[128]{0} broadcast(reshape.915), dimensions={}
  add.917 = s32[128]{0} add(convert.895, broadcast.916)
  call.918 = f32[128,128]{1,0} call(Arg_0.884, add.917), to_apply=_roll_dynamic_3.736
  multiply.921 = f32[128,128]{1,0} multiply(reshape.920, call.918)
  add.922 = f32[128,128]{1,0} add(add.913, multiply.921)
  slice.928 = f32[1,128,128]{2,1,0} slice(call.896), slice={[3:4], [0:128], [0:128]}
  reshape.929 = f32[128,128]{1,0} reshape(slice.928)
  slice.923 = s32[1]{0} slice(Arg_4.888), slice={[3:4]}
  reshape.924 = s32[] reshape(slice.923)
  broadcast.925 = s32[128]{0} broadcast(reshape.924), dimensions={}
  add.926 = s32[128]{0} add(convert.895, broadcast.925)
  call.927 = f32[128,128]{1,0} call(Arg_0.884, add.926), to_apply=_roll_dynamic_3.779
  multiply.930 = f32[128,128]{1,0} multiply(reshape.929, call.927)
  add.931 = f32[128,128]{1,0} add(add.922, multiply.930)
  slice.937 = f32[1,128,128]{2,1,0} slice(call.896), slice={[4:5], [0:128], [0:128]}
  reshape.938 = f32[128,128]{1,0} reshape(slice.937)
  slice.932 = s32[1]{0} slice(Arg_4.888), slice={[4:5]}
  reshape.933 = s32[] reshape(slice.932)
  broadcast.934 = s32[128]{0} broadcast(reshape.933), dimensions={}
  add.935 = s32[128]{0} add(convert.895, broadcast.934)
  call.936 = f32[128,128]{1,0} call(Arg_0.884, add.935), to_apply=_roll_dynamic_3.822
  multiply.939 = f32[128,128]{1,0} multiply(reshape.938, call.936)
  add.940 = f32[128,128]{1,0} add(add.931, multiply.939)
  slice.946 = f32[1,128,128]{2,1,0} slice(call.896), slice={[5:6], [0:128], [0:128]}
  reshape.947 = f32[128,128]{1,0} reshape(slice.946)
  slice.941 = s32[1]{0} slice(Arg_4.888), slice={[5:6]}
  reshape.942 = s32[] reshape(slice.941)
  broadcast.943 = s32[128]{0} broadcast(reshape.942), dimensions={}
  add.944 = s32[128]{0} add(convert.895, broadcast.943)
  call.945 = f32[128,128]{1,0} call(Arg_0.884, add.944), to_apply=_roll_dynamic_3.865
  multiply.948 = f32[128,128]{1,0} multiply(reshape.947, call.945)
  ROOT add.949 = f32[128,128]{1,0} add(add.940, multiply.948)
}

_where.951 {
  Arg_0.952 = pred[] parameter(0)
  Arg_1.953 = s32[] parameter(1)
  Arg_2.954 = s32[] parameter(2)
  ROOT select.955 = s32[] select(Arg_0.952, Arg_1.953, Arg_2.954)
}

remainder.956 {
  Arg_0.957 = s32[128]{0} parameter(0)
  Arg_1.958 = s32[] parameter(1)
  constant.962 = s32[] constant(0)
  compare.963 = pred[] compare(Arg_1.958, constant.962), direction=EQ
  constant.961 = s32[] constant(1)
  call.964 = s32[] call(compare.963, constant.961, Arg_1.958), to_apply=_where.951
  broadcast.965 = s32[128]{0} broadcast(call.964), dimensions={}
  remainder.966 = s32[128]{0} remainder(Arg_0.957, broadcast.965)
  constant.959 = s32[] constant(0)
  broadcast.960 = s32[128]{0} broadcast(constant.959), dimensions={}
  compare.968 = pred[128]{0} compare(remainder.966, broadcast.960), direction=LT
  compare.969 = pred[] compare(call.964, constant.962), direction=LT
  broadcast.970 = pred[128]{0} broadcast(compare.969), dimensions={}
  compare.971 = pred[128]{0} compare(compare.968, broadcast.970), direction=NE
  compare.967 = pred[128]{0} compare(remainder.966, broadcast.960), direction=NE
  and.972 = pred[128]{0} and(compare.971, compare.967)
  broadcast.973 = s32[128]{0} broadcast(call.964), dimensions={}
  add.974 = s32[128]{0} add(remainder.966, broadcast.973)
  ROOT select.975 = s32[128]{0} select(and.972, add.974, remainder.966)
}

_roll_dynamic.976 {
  Arg_0.977 = f32[128,128]{1,0} parameter(0)
  transpose.987 = f32[128,128]{0,1} transpose(Arg_0.977), dimensions={1,0}
  transpose.988 = f32[128,128]{0,1} transpose(Arg_0.977), dimensions={1,0}
  concatenate.989 = f32[128,256]{1,0} concatenate(transpose.987, transpose.988), dimensions={1}
  constant.983 = s32[] constant(128)
  broadcast.984 = s32[128]{0} broadcast(constant.983), dimensions={}
  Arg_1.978 = s32[128]{0} parameter(1)
  constant.985 = s32[] constant(128)
  call.986 = s32[128]{0} call(Arg_1.978, constant.985), to_apply=remainder.956
  subtract.990 = s32[128]{0} subtract(broadcast.984, call.986)
  constant.981 = s32[] constant(0)
  broadcast.982 = s32[128]{0} broadcast(constant.981), dimensions={}
  compare.991 = pred[128]{0} compare(subtract.990, broadcast.982), direction=LT
  constant.979 = s32[] constant(256)
  broadcast.980 = s32[128]{0} broadcast(constant.979), dimensions={}
  add.992 = s32[128]{0} add(subtract.990, broadcast.980)
  select.993 = s32[128]{0} select(compare.991, add.992, subtract.990)
  reshape.994 = s32[128,1]{1,0} reshape(select.993)
  ROOT gather.995 = f32[128,128]{1,0} gather(concatenate.989, reshape.994), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.996 {
  Arg_0.997 = pred[] parameter(0)
  Arg_1.998 = s32[] parameter(1)
  Arg_2.999 = s32[] parameter(2)
  ROOT select.1000 = s32[] select(Arg_0.997, Arg_1.998, Arg_2.999)
}

remainder.1001 {
  Arg_0.1002 = s32[128]{0} parameter(0)
  Arg_1.1003 = s32[] parameter(1)
  constant.1007 = s32[] constant(0)
  compare.1008 = pred[] compare(Arg_1.1003, constant.1007), direction=EQ
  constant.1006 = s32[] constant(1)
  call.1009 = s32[] call(compare.1008, constant.1006, Arg_1.1003), to_apply=_where.996
  broadcast.1010 = s32[128]{0} broadcast(call.1009), dimensions={}
  remainder.1011 = s32[128]{0} remainder(Arg_0.1002, broadcast.1010)
  constant.1004 = s32[] constant(0)
  broadcast.1005 = s32[128]{0} broadcast(constant.1004), dimensions={}
  compare.1013 = pred[128]{0} compare(remainder.1011, broadcast.1005), direction=LT
  compare.1014 = pred[] compare(call.1009, constant.1007), direction=LT
  broadcast.1015 = pred[128]{0} broadcast(compare.1014), dimensions={}
  compare.1016 = pred[128]{0} compare(compare.1013, broadcast.1015), direction=NE
  compare.1012 = pred[128]{0} compare(remainder.1011, broadcast.1005), direction=NE
  and.1017 = pred[128]{0} and(compare.1016, compare.1012)
  broadcast.1018 = s32[128]{0} broadcast(call.1009), dimensions={}
  add.1019 = s32[128]{0} add(remainder.1011, broadcast.1018)
  ROOT select.1020 = s32[128]{0} select(and.1017, add.1019, remainder.1011)
}

_roll_dynamic.1021 {
  Arg_0.1022 = f32[128,128]{1,0} parameter(0)
  transpose.1032 = f32[128,128]{0,1} transpose(Arg_0.1022), dimensions={1,0}
  transpose.1033 = f32[128,128]{0,1} transpose(Arg_0.1022), dimensions={1,0}
  concatenate.1034 = f32[128,256]{1,0} concatenate(transpose.1032, transpose.1033), dimensions={1}
  constant.1028 = s32[] constant(128)
  broadcast.1029 = s32[128]{0} broadcast(constant.1028), dimensions={}
  Arg_1.1023 = s32[128]{0} parameter(1)
  constant.1030 = s32[] constant(128)
  call.1031 = s32[128]{0} call(Arg_1.1023, constant.1030), to_apply=remainder.1001
  subtract.1035 = s32[128]{0} subtract(broadcast.1029, call.1031)
  constant.1026 = s32[] constant(0)
  broadcast.1027 = s32[128]{0} broadcast(constant.1026), dimensions={}
  compare.1036 = pred[128]{0} compare(subtract.1035, broadcast.1027), direction=LT
  constant.1024 = s32[] constant(256)
  broadcast.1025 = s32[128]{0} broadcast(constant.1024), dimensions={}
  add.1037 = s32[128]{0} add(subtract.1035, broadcast.1025)
  select.1038 = s32[128]{0} select(compare.1036, add.1037, subtract.1035)
  reshape.1039 = s32[128,1]{1,0} reshape(select.1038)
  ROOT gather.1040 = f32[128,128]{1,0} gather(concatenate.1034, reshape.1039), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.1041 {
  Arg_0.1042 = pred[] parameter(0)
  Arg_1.1043 = s32[] parameter(1)
  Arg_2.1044 = s32[] parameter(2)
  ROOT select.1045 = s32[] select(Arg_0.1042, Arg_1.1043, Arg_2.1044)
}

remainder.1046 {
  Arg_0.1047 = s32[128]{0} parameter(0)
  Arg_1.1048 = s32[] parameter(1)
  constant.1052 = s32[] constant(0)
  compare.1053 = pred[] compare(Arg_1.1048, constant.1052), direction=EQ
  constant.1051 = s32[] constant(1)
  call.1054 = s32[] call(compare.1053, constant.1051, Arg_1.1048), to_apply=_where.1041
  broadcast.1055 = s32[128]{0} broadcast(call.1054), dimensions={}
  remainder.1056 = s32[128]{0} remainder(Arg_0.1047, broadcast.1055)
  constant.1049 = s32[] constant(0)
  broadcast.1050 = s32[128]{0} broadcast(constant.1049), dimensions={}
  compare.1058 = pred[128]{0} compare(remainder.1056, broadcast.1050), direction=LT
  compare.1059 = pred[] compare(call.1054, constant.1052), direction=LT
  broadcast.1060 = pred[128]{0} broadcast(compare.1059), dimensions={}
  compare.1061 = pred[128]{0} compare(compare.1058, broadcast.1060), direction=NE
  compare.1057 = pred[128]{0} compare(remainder.1056, broadcast.1050), direction=NE
  and.1062 = pred[128]{0} and(compare.1061, compare.1057)
  broadcast.1063 = s32[128]{0} broadcast(call.1054), dimensions={}
  add.1064 = s32[128]{0} add(remainder.1056, broadcast.1063)
  ROOT select.1065 = s32[128]{0} select(and.1062, add.1064, remainder.1056)
}

_roll_dynamic.1066 {
  Arg_0.1067 = f32[128,128]{1,0} parameter(0)
  transpose.1077 = f32[128,128]{0,1} transpose(Arg_0.1067), dimensions={1,0}
  transpose.1078 = f32[128,128]{0,1} transpose(Arg_0.1067), dimensions={1,0}
  concatenate.1079 = f32[128,256]{1,0} concatenate(transpose.1077, transpose.1078), dimensions={1}
  constant.1073 = s32[] constant(128)
  broadcast.1074 = s32[128]{0} broadcast(constant.1073), dimensions={}
  Arg_1.1068 = s32[128]{0} parameter(1)
  constant.1075 = s32[] constant(128)
  call.1076 = s32[128]{0} call(Arg_1.1068, constant.1075), to_apply=remainder.1046
  subtract.1080 = s32[128]{0} subtract(broadcast.1074, call.1076)
  constant.1071 = s32[] constant(0)
  broadcast.1072 = s32[128]{0} broadcast(constant.1071), dimensions={}
  compare.1081 = pred[128]{0} compare(subtract.1080, broadcast.1072), direction=LT
  constant.1069 = s32[] constant(256)
  broadcast.1070 = s32[128]{0} broadcast(constant.1069), dimensions={}
  add.1082 = s32[128]{0} add(subtract.1080, broadcast.1070)
  select.1083 = s32[128]{0} select(compare.1081, add.1082, subtract.1080)
  reshape.1084 = s32[128,1]{1,0} reshape(select.1083)
  ROOT gather.1085 = f32[128,128]{1,0} gather(concatenate.1079, reshape.1084), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.1086 {
  Arg_0.1087 = pred[] parameter(0)
  Arg_1.1088 = s32[] parameter(1)
  Arg_2.1089 = s32[] parameter(2)
  ROOT select.1090 = s32[] select(Arg_0.1087, Arg_1.1088, Arg_2.1089)
}

remainder.1091 {
  Arg_0.1092 = s32[128]{0} parameter(0)
  Arg_1.1093 = s32[] parameter(1)
  constant.1097 = s32[] constant(0)
  compare.1098 = pred[] compare(Arg_1.1093, constant.1097), direction=EQ
  constant.1096 = s32[] constant(1)
  call.1099 = s32[] call(compare.1098, constant.1096, Arg_1.1093), to_apply=_where.1086
  broadcast.1100 = s32[128]{0} broadcast(call.1099), dimensions={}
  remainder.1101 = s32[128]{0} remainder(Arg_0.1092, broadcast.1100)
  constant.1094 = s32[] constant(0)
  broadcast.1095 = s32[128]{0} broadcast(constant.1094), dimensions={}
  compare.1103 = pred[128]{0} compare(remainder.1101, broadcast.1095), direction=LT
  compare.1104 = pred[] compare(call.1099, constant.1097), direction=LT
  broadcast.1105 = pred[128]{0} broadcast(compare.1104), dimensions={}
  compare.1106 = pred[128]{0} compare(compare.1103, broadcast.1105), direction=NE
  compare.1102 = pred[128]{0} compare(remainder.1101, broadcast.1095), direction=NE
  and.1107 = pred[128]{0} and(compare.1106, compare.1102)
  broadcast.1108 = s32[128]{0} broadcast(call.1099), dimensions={}
  add.1109 = s32[128]{0} add(remainder.1101, broadcast.1108)
  ROOT select.1110 = s32[128]{0} select(and.1107, add.1109, remainder.1101)
}

_roll_dynamic.1111 {
  Arg_0.1112 = f32[128,128]{1,0} parameter(0)
  transpose.1122 = f32[128,128]{0,1} transpose(Arg_0.1112), dimensions={1,0}
  transpose.1123 = f32[128,128]{0,1} transpose(Arg_0.1112), dimensions={1,0}
  concatenate.1124 = f32[128,256]{1,0} concatenate(transpose.1122, transpose.1123), dimensions={1}
  constant.1118 = s32[] constant(128)
  broadcast.1119 = s32[128]{0} broadcast(constant.1118), dimensions={}
  Arg_1.1113 = s32[128]{0} parameter(1)
  constant.1120 = s32[] constant(128)
  call.1121 = s32[128]{0} call(Arg_1.1113, constant.1120), to_apply=remainder.1091
  subtract.1125 = s32[128]{0} subtract(broadcast.1119, call.1121)
  constant.1116 = s32[] constant(0)
  broadcast.1117 = s32[128]{0} broadcast(constant.1116), dimensions={}
  compare.1126 = pred[128]{0} compare(subtract.1125, broadcast.1117), direction=LT
  constant.1114 = s32[] constant(256)
  broadcast.1115 = s32[128]{0} broadcast(constant.1114), dimensions={}
  add.1127 = s32[128]{0} add(subtract.1125, broadcast.1115)
  select.1128 = s32[128]{0} select(compare.1126, add.1127, subtract.1125)
  reshape.1129 = s32[128,1]{1,0} reshape(select.1128)
  ROOT gather.1130 = f32[128,128]{1,0} gather(concatenate.1124, reshape.1129), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.1131 {
  Arg_0.1132 = pred[] parameter(0)
  Arg_1.1133 = s32[] parameter(1)
  Arg_2.1134 = s32[] parameter(2)
  ROOT select.1135 = s32[] select(Arg_0.1132, Arg_1.1133, Arg_2.1134)
}

remainder.1136 {
  Arg_0.1137 = s32[128]{0} parameter(0)
  Arg_1.1138 = s32[] parameter(1)
  constant.1142 = s32[] constant(0)
  compare.1143 = pred[] compare(Arg_1.1138, constant.1142), direction=EQ
  constant.1141 = s32[] constant(1)
  call.1144 = s32[] call(compare.1143, constant.1141, Arg_1.1138), to_apply=_where.1131
  broadcast.1145 = s32[128]{0} broadcast(call.1144), dimensions={}
  remainder.1146 = s32[128]{0} remainder(Arg_0.1137, broadcast.1145)
  constant.1139 = s32[] constant(0)
  broadcast.1140 = s32[128]{0} broadcast(constant.1139), dimensions={}
  compare.1148 = pred[128]{0} compare(remainder.1146, broadcast.1140), direction=LT
  compare.1149 = pred[] compare(call.1144, constant.1142), direction=LT
  broadcast.1150 = pred[128]{0} broadcast(compare.1149), dimensions={}
  compare.1151 = pred[128]{0} compare(compare.1148, broadcast.1150), direction=NE
  compare.1147 = pred[128]{0} compare(remainder.1146, broadcast.1140), direction=NE
  and.1152 = pred[128]{0} and(compare.1151, compare.1147)
  broadcast.1153 = s32[128]{0} broadcast(call.1144), dimensions={}
  add.1154 = s32[128]{0} add(remainder.1146, broadcast.1153)
  ROOT select.1155 = s32[128]{0} select(and.1152, add.1154, remainder.1146)
}

_roll_dynamic.1156 {
  Arg_0.1157 = f32[128,128]{1,0} parameter(0)
  transpose.1167 = f32[128,128]{0,1} transpose(Arg_0.1157), dimensions={1,0}
  transpose.1168 = f32[128,128]{0,1} transpose(Arg_0.1157), dimensions={1,0}
  concatenate.1169 = f32[128,256]{1,0} concatenate(transpose.1167, transpose.1168), dimensions={1}
  constant.1163 = s32[] constant(128)
  broadcast.1164 = s32[128]{0} broadcast(constant.1163), dimensions={}
  Arg_1.1158 = s32[128]{0} parameter(1)
  constant.1165 = s32[] constant(128)
  call.1166 = s32[128]{0} call(Arg_1.1158, constant.1165), to_apply=remainder.1136
  subtract.1170 = s32[128]{0} subtract(broadcast.1164, call.1166)
  constant.1161 = s32[] constant(0)
  broadcast.1162 = s32[128]{0} broadcast(constant.1161), dimensions={}
  compare.1171 = pred[128]{0} compare(subtract.1170, broadcast.1162), direction=LT
  constant.1159 = s32[] constant(256)
  broadcast.1160 = s32[128]{0} broadcast(constant.1159), dimensions={}
  add.1172 = s32[128]{0} add(subtract.1170, broadcast.1160)
  select.1173 = s32[128]{0} select(compare.1171, add.1172, subtract.1170)
  reshape.1174 = s32[128,1]{1,0} reshape(select.1173)
  ROOT gather.1175 = f32[128,128]{1,0} gather(concatenate.1169, reshape.1174), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.1176 {
  Arg_0.1177 = pred[] parameter(0)
  Arg_1.1178 = s32[] parameter(1)
  Arg_2.1179 = s32[] parameter(2)
  ROOT select.1180 = s32[] select(Arg_0.1177, Arg_1.1178, Arg_2.1179)
}

remainder.1181 {
  Arg_0.1182 = s32[128]{0} parameter(0)
  Arg_1.1183 = s32[] parameter(1)
  constant.1187 = s32[] constant(0)
  compare.1188 = pred[] compare(Arg_1.1183, constant.1187), direction=EQ
  constant.1186 = s32[] constant(1)
  call.1189 = s32[] call(compare.1188, constant.1186, Arg_1.1183), to_apply=_where.1176
  broadcast.1190 = s32[128]{0} broadcast(call.1189), dimensions={}
  remainder.1191 = s32[128]{0} remainder(Arg_0.1182, broadcast.1190)
  constant.1184 = s32[] constant(0)
  broadcast.1185 = s32[128]{0} broadcast(constant.1184), dimensions={}
  compare.1193 = pred[128]{0} compare(remainder.1191, broadcast.1185), direction=LT
  compare.1194 = pred[] compare(call.1189, constant.1187), direction=LT
  broadcast.1195 = pred[128]{0} broadcast(compare.1194), dimensions={}
  compare.1196 = pred[128]{0} compare(compare.1193, broadcast.1195), direction=NE
  compare.1192 = pred[128]{0} compare(remainder.1191, broadcast.1185), direction=NE
  and.1197 = pred[128]{0} and(compare.1196, compare.1192)
  broadcast.1198 = s32[128]{0} broadcast(call.1189), dimensions={}
  add.1199 = s32[128]{0} add(remainder.1191, broadcast.1198)
  ROOT select.1200 = s32[128]{0} select(and.1197, add.1199, remainder.1191)
}

_roll_dynamic.1201 {
  Arg_0.1202 = f32[128,128]{1,0} parameter(0)
  transpose.1212 = f32[128,128]{0,1} transpose(Arg_0.1202), dimensions={1,0}
  transpose.1213 = f32[128,128]{0,1} transpose(Arg_0.1202), dimensions={1,0}
  concatenate.1214 = f32[128,256]{1,0} concatenate(transpose.1212, transpose.1213), dimensions={1}
  constant.1208 = s32[] constant(128)
  broadcast.1209 = s32[128]{0} broadcast(constant.1208), dimensions={}
  Arg_1.1203 = s32[128]{0} parameter(1)
  constant.1210 = s32[] constant(128)
  call.1211 = s32[128]{0} call(Arg_1.1203, constant.1210), to_apply=remainder.1181
  subtract.1215 = s32[128]{0} subtract(broadcast.1209, call.1211)
  constant.1206 = s32[] constant(0)
  broadcast.1207 = s32[128]{0} broadcast(constant.1206), dimensions={}
  compare.1216 = pred[128]{0} compare(subtract.1215, broadcast.1207), direction=LT
  constant.1204 = s32[] constant(256)
  broadcast.1205 = s32[128]{0} broadcast(constant.1204), dimensions={}
  add.1217 = s32[128]{0} add(subtract.1215, broadcast.1205)
  select.1218 = s32[128]{0} select(compare.1216, add.1217, subtract.1215)
  reshape.1219 = s32[128,1]{1,0} reshape(select.1218)
  ROOT gather.1220 = f32[128,128]{1,0} gather(concatenate.1214, reshape.1219), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

advect_1d_matrix_diag.1221 {
  Arg_0.1222 = f32[128,128]{1,0} parameter(0)
  Arg_1.1223 = f32[128]{0} parameter(1)
  Arg_2.1224 = f32[] parameter(2)
  broadcast.1251 = f32[128]{0} broadcast(Arg_2.1224), dimensions={}
  multiply.1252 = f32[128]{0} multiply(Arg_1.1223, broadcast.1251)
  Arg_3.1225 = f32[] parameter(3)
  broadcast.1253 = f32[128]{0} broadcast(Arg_3.1225), dimensions={}
  divide.1254 = f32[128]{0} divide(multiply.1252, broadcast.1253)
  floor.1255 = f32[128]{0} floor(divide.1254)
  convert.1257 = s32[128]{0} convert(floor.1255)
  Arg_4.1226 = s32[6]{0} parameter(4)
  slice.1320 = s32[1]{0} slice(Arg_4.1226), slice={[0:1]}
  reshape.1321 = s32[] reshape(slice.1320)
  broadcast.1322 = s32[128]{0} broadcast(reshape.1321), dimensions={}
  add.1323 = s32[128]{0} add(convert.1257, broadcast.1322)
  call.1324 = f32[128,128]{1,0} call(Arg_0.1222, add.1323), to_apply=_roll_dynamic.976
  transpose.1325 = f32[128,128]{0,1} transpose(call.1324), dimensions={1,0}
  subtract.1256 = f32[128]{0} subtract(divide.1254, floor.1255)
  constant.1249 = f32[] constant(20)
  broadcast.1250 = f32[128]{0} broadcast(constant.1249), dimensions={}
  divide.1262 = f32[128]{0} divide(subtract.1256, broadcast.1250)
  multiply.1258 = f32[128]{0} multiply(subtract.1256, subtract.1256)
  constant.1247 = f32[] constant(24)
  broadcast.1248 = f32[128]{0} broadcast(constant.1247), dimensions={}
  divide.1263 = f32[128]{0} divide(multiply.1258, broadcast.1248)
  subtract.1264 = f32[128]{0} subtract(divide.1262, divide.1263)
  multiply.1259 = f32[128]{0} multiply(multiply.1258, subtract.1256)
  divide.1265 = f32[128]{0} divide(multiply.1259, broadcast.1248)
  subtract.1266 = f32[128]{0} subtract(subtract.1264, divide.1265)
  multiply.1260 = f32[128]{0} multiply(multiply.1259, subtract.1256)
  divide.1267 = f32[128]{0} divide(multiply.1260, broadcast.1248)
  add.1268 = f32[128]{0} add(subtract.1266, divide.1267)
  multiply.1261 = f32[128]{0} multiply(multiply.1260, subtract.1256)
  constant.1245 = f32[] constant(120)
  broadcast.1246 = f32[128]{0} broadcast(constant.1245), dimensions={}
  divide.1269 = f32[128]{0} divide(multiply.1261, broadcast.1246)
  subtract.1270 = f32[128]{0} subtract(add.1268, divide.1269)
  reshape.1326 = f32[1,128]{1,0} reshape(subtract.1270)
  broadcast.1327 = f32[1,128]{1,0} broadcast(reshape.1326), dimensions={0,1}
  reshape.1328 = f32[128]{0} reshape(broadcast.1327)
  broadcast.1329 = f32[128,128]{1,0} broadcast(reshape.1328), dimensions={1}
  multiply.1330 = f32[128,128]{0,1} multiply(transpose.1325, broadcast.1329)
  slice.1331 = s32[1]{0} slice(Arg_4.1226), slice={[1:2]}
  reshape.1332 = s32[] reshape(slice.1331)
  broadcast.1333 = s32[128]{0} broadcast(reshape.1332), dimensions={}
  add.1334 = s32[128]{0} add(convert.1257, broadcast.1333)
  call.1335 = f32[128,128]{1,0} call(Arg_0.1222, add.1334), to_apply=_roll_dynamic.1021
  transpose.1336 = f32[128,128]{0,1} transpose(call.1335), dimensions={1,0}
  constant.1243 = f32[] constant(2)
  broadcast.1244 = f32[128]{0} broadcast(constant.1243), dimensions={}
  divide.1271 = f32[128]{0} divide(subtract.1256, broadcast.1244)
  negate.1272 = f32[128]{0} negate(divide.1271)
  multiply.1273 = f32[128]{0} multiply(multiply.1258, broadcast.1244)
  constant.1241 = f32[] constant(3)
  broadcast.1242 = f32[128]{0} broadcast(constant.1241), dimensions={}
  divide.1274 = f32[128]{0} divide(multiply.1273, broadcast.1242)
  add.1275 = f32[128]{0} add(negate.1272, divide.1274)
  divide.1276 = f32[128]{0} divide(multiply.1259, broadcast.1248)
  subtract.1277 = f32[128]{0} subtract(add.1275, divide.1276)
  constant.1239 = f32[] constant(6)
  broadcast.1240 = f32[128]{0} broadcast(constant.1239), dimensions={}
  divide.1278 = f32[128]{0} divide(multiply.1260, broadcast.1240)
  subtract.1279 = f32[128]{0} subtract(subtract.1277, divide.1278)
  divide.1280 = f32[128]{0} divide(multiply.1261, broadcast.1248)
  add.1281 = f32[128]{0} add(subtract.1279, divide.1280)
  reshape.1337 = f32[1,128]{1,0} reshape(add.1281)
  broadcast.1338 = f32[1,128]{1,0} broadcast(reshape.1337), dimensions={0,1}
  reshape.1339 = f32[128]{0} reshape(broadcast.1338)
  broadcast.1340 = f32[128,128]{1,0} broadcast(reshape.1339), dimensions={1}
  multiply.1341 = f32[128,128]{0,1} multiply(transpose.1336, broadcast.1340)
  add.1342 = f32[128,128]{0,1} add(multiply.1330, multiply.1341)
  slice.1343 = s32[1]{0} slice(Arg_4.1226), slice={[2:3]}
  reshape.1344 = s32[] reshape(slice.1343)
  broadcast.1345 = s32[128]{0} broadcast(reshape.1344), dimensions={}
  add.1346 = s32[128]{0} add(convert.1257, broadcast.1345)
  call.1347 = f32[128,128]{1,0} call(Arg_0.1222, add.1346), to_apply=_roll_dynamic.1066
  transpose.1348 = f32[128,128]{0,1} transpose(call.1347), dimensions={1,0}
  constant.1237 = f32[] constant(1)
  broadcast.1238 = f32[128]{0} broadcast(constant.1237), dimensions={}
  divide.1282 = f32[128]{0} divide(subtract.1256, broadcast.1242)
  subtract.1283 = f32[128]{0} subtract(broadcast.1238, divide.1282)
  constant.1235 = f32[] constant(5)
  broadcast.1236 = f32[128]{0} broadcast(constant.1235), dimensions={}
  multiply.1284 = f32[128]{0} multiply(multiply.1258, broadcast.1236)
  constant.1233 = f32[] constant(4)
  broadcast.1234 = f32[128]{0} broadcast(constant.1233), dimensions={}
  divide.1285 = f32[128]{0} divide(multiply.1284, broadcast.1234)
  subtract.1286 = f32[128]{0} subtract(subtract.1283, divide.1285)
  multiply.1287 = f32[128]{0} multiply(multiply.1259, broadcast.1236)
  constant.1231 = f32[] constant(12)
  broadcast.1232 = f32[128]{0} broadcast(constant.1231), dimensions={}
  divide.1288 = f32[128]{0} divide(multiply.1287, broadcast.1232)
  add.1289 = f32[128]{0} add(subtract.1286, divide.1288)
  divide.1290 = f32[128]{0} divide(multiply.1260, broadcast.1234)
  add.1291 = f32[128]{0} add(add.1289, divide.1290)
  divide.1292 = f32[128]{0} divide(multiply.1261, broadcast.1232)
  subtract.1293 = f32[128]{0} subtract(add.1291, divide.1292)
  reshape.1349 = f32[1,128]{1,0} reshape(subtract.1293)
  broadcast.1350 = f32[1,128]{1,0} broadcast(reshape.1349), dimensions={0,1}
  reshape.1351 = f32[128]{0} reshape(broadcast.1350)
  broadcast.1352 = f32[128,128]{1,0} broadcast(reshape.1351), dimensions={1}
  multiply.1353 = f32[128,128]{0,1} multiply(transpose.1348, broadcast.1352)
  add.1354 = f32[128,128]{0,1} add(add.1342, multiply.1353)
  slice.1355 = s32[1]{0} slice(Arg_4.1226), slice={[3:4]}
  reshape.1356 = s32[] reshape(slice.1355)
  broadcast.1357 = s32[128]{0} broadcast(reshape.1356), dimensions={}
  add.1358 = s32[128]{0} add(convert.1257, broadcast.1357)
  call.1359 = f32[128,128]{1,0} call(Arg_0.1222, add.1358), to_apply=_roll_dynamic.1111
  transpose.1360 = f32[128,128]{0,1} transpose(call.1359), dimensions={1,0}
  multiply.1294 = f32[128]{0} multiply(multiply.1258, broadcast.1244)
  divide.1295 = f32[128]{0} divide(multiply.1294, broadcast.1242)
  add.1296 = f32[128]{0} add(subtract.1256, divide.1295)
  constant.1229 = f32[] constant(7)
  broadcast.1230 = f32[128]{0} broadcast(constant.1229), dimensions={}
  multiply.1297 = f32[128]{0} multiply(multiply.1259, broadcast.1230)
  divide.1298 = f32[128]{0} divide(multiply.1297, broadcast.1232)
  subtract.1299 = f32[128]{0} subtract(add.1296, divide.1298)
  divide.1300 = f32[128]{0} divide(multiply.1260, broadcast.1240)
  subtract.1301 = f32[128]{0} subtract(subtract.1299, divide.1300)
  divide.1302 = f32[128]{0} divide(multiply.1261, broadcast.1232)
  add.1303 = f32[128]{0} add(subtract.1301, divide.1302)
  reshape.1361 = f32[1,128]{1,0} reshape(add.1303)
  broadcast.1362 = f32[1,128]{1,0} broadcast(reshape.1361), dimensions={0,1}
  reshape.1363 = f32[128]{0} reshape(broadcast.1362)
  broadcast.1364 = f32[128,128]{1,0} broadcast(reshape.1363), dimensions={1}
  multiply.1365 = f32[128,128]{0,1} multiply(transpose.1360, broadcast.1364)
  add.1366 = f32[128,128]{0,1} add(add.1354, multiply.1365)
  slice.1367 = s32[1]{0} slice(Arg_4.1226), slice={[4:5]}
  reshape.1368 = s32[] reshape(slice.1367)
  broadcast.1369 = s32[128]{0} broadcast(reshape.1368), dimensions={}
  add.1370 = s32[128]{0} add(convert.1257, broadcast.1369)
  call.1371 = f32[128,128]{1,0} call(Arg_0.1222, add.1370), to_apply=_roll_dynamic.1156
  transpose.1372 = f32[128,128]{0,1} transpose(call.1371), dimensions={1,0}
  divide.1304 = f32[128]{0} divide(subtract.1256, broadcast.1234)
  negate.1305 = f32[128]{0} negate(divide.1304)
  divide.1306 = f32[128]{0} divide(multiply.1258, broadcast.1248)
  subtract.1307 = f32[128]{0} subtract(negate.1305, divide.1306)
  multiply.1308 = f32[128]{0} multiply(multiply.1259, broadcast.1230)
  divide.1309 = f32[128]{0} divide(multiply.1308, broadcast.1248)
  add.1310 = f32[128]{0} add(subtract.1307, divide.1309)
  divide.1311 = f32[128]{0} divide(multiply.1260, broadcast.1248)
  add.1312 = f32[128]{0} add(add.1310, divide.1311)
  divide.1313 = f32[128]{0} divide(multiply.1261, broadcast.1248)
  subtract.1314 = f32[128]{0} subtract(add.1312, divide.1313)
  reshape.1373 = f32[1,128]{1,0} reshape(subtract.1314)
  broadcast.1374 = f32[1,128]{1,0} broadcast(reshape.1373), dimensions={0,1}
  reshape.1375 = f32[128]{0} reshape(broadcast.1374)
  broadcast.1376 = f32[128,128]{1,0} broadcast(reshape.1375), dimensions={1}
  multiply.1377 = f32[128,128]{0,1} multiply(transpose.1372, broadcast.1376)
  add.1378 = f32[128,128]{0,1} add(add.1366, multiply.1377)
  slice.1379 = s32[1]{0} slice(Arg_4.1226), slice={[5:6]}
  reshape.1380 = s32[] reshape(slice.1379)
  broadcast.1381 = s32[128]{0} broadcast(reshape.1380), dimensions={}
  add.1382 = s32[128]{0} add(convert.1257, broadcast.1381)
  call.1383 = f32[128,128]{1,0} call(Arg_0.1222, add.1382), to_apply=_roll_dynamic.1201
  transpose.1384 = f32[128,128]{0,1} transpose(call.1383), dimensions={1,0}
  constant.1227 = f32[] constant(30)
  broadcast.1228 = f32[128]{0} broadcast(constant.1227), dimensions={}
  divide.1315 = f32[128]{0} divide(subtract.1256, broadcast.1228)
  divide.1316 = f32[128]{0} divide(multiply.1259, broadcast.1248)
  subtract.1317 = f32[128]{0} subtract(divide.1315, divide.1316)
  divide.1318 = f32[128]{0} divide(multiply.1261, broadcast.1246)
  add.1319 = f32[128]{0} add(subtract.1317, divide.1318)
  reshape.1385 = f32[1,128]{1,0} reshape(add.1319)
  broadcast.1386 = f32[1,128]{1,0} broadcast(reshape.1385), dimensions={0,1}
  reshape.1387 = f32[128]{0} reshape(broadcast.1386)
  broadcast.1388 = f32[128,128]{1,0} broadcast(reshape.1387), dimensions={1}
  multiply.1389 = f32[128,128]{0,1} multiply(transpose.1384, broadcast.1388)
  ROOT add.1390 = f32[128,128]{0,1} add(add.1378, multiply.1389)
}

ENTRY main.1393 {
  Arg_0.1 = f32[128,128]{1,0} parameter(0)
  constant.4 = f32[128]{0} constant({...})
  constant.7 = f32[] constant(0.025)
  constant.8 = f32[] constant(0.0981747732)
  constant.5 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  call.449 = f32[128,128]{0,1} call(Arg_0.1, constant.4, constant.7, constant.8, constant.5), to_apply=advect_1d_matrix_diag.279
  constant.6 = f32[65]{0} constant({...})
  constant.3 = f32[] constant(0.0787401572)
  call.486 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) call(call.449, constant.6, constant.3), to_apply=solve_poisson.463
  get-tuple-element.487 = f32[128]{0} get-tuple-element(call.486), index=0
  constant.2 = f32[] constant(0.05)
  call.950 = f32[128,128]{1,0} call(call.449, get-tuple-element.487, constant.2, constant.3, constant.5), to_apply=advect_1d_matrix_diag_1.883
  call.1391 = f32[128,128]{0,1} call(call.950, constant.4, constant.7, constant.8, constant.5), to_apply=advect_1d_matrix_diag.1221
  get-tuple-element.488 = f32[128]{0} get-tuple-element(call.486), index=1
  get-tuple-element.489 = f32[128]{0} get-tuple-element(call.486), index=2
  ROOT tuple.1392 = (f32[128,128]{0,1}, f32[128]{0}, f32[128]{0}) tuple(call.1391, get-tuple-element.488, get-tuple-element.489)
}

