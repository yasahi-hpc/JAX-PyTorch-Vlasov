HloModule jit__lambda_, entry_computation_layout={(f64[128,128]{1,0})->(f64[128,128]{0,1}, f64[128]{0}, f64[128]{0})}

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
  Arg_0.35 = f64[128,128]{1,0} parameter(0)
  transpose.45 = f64[128,128]{0,1} transpose(Arg_0.35), dimensions={1,0}
  transpose.46 = f64[128,128]{0,1} transpose(Arg_0.35), dimensions={1,0}
  concatenate.47 = f64[128,256]{1,0} concatenate(transpose.45, transpose.46), dimensions={1}
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
  ROOT gather.53 = f64[128,128]{1,0} gather(concatenate.47, reshape.52), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.80 = f64[128,128]{1,0} parameter(0)
  transpose.90 = f64[128,128]{0,1} transpose(Arg_0.80), dimensions={1,0}
  transpose.91 = f64[128,128]{0,1} transpose(Arg_0.80), dimensions={1,0}
  concatenate.92 = f64[128,256]{1,0} concatenate(transpose.90, transpose.91), dimensions={1}
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
  ROOT gather.98 = f64[128,128]{1,0} gather(concatenate.92, reshape.97), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.125 = f64[128,128]{1,0} parameter(0)
  transpose.135 = f64[128,128]{0,1} transpose(Arg_0.125), dimensions={1,0}
  transpose.136 = f64[128,128]{0,1} transpose(Arg_0.125), dimensions={1,0}
  concatenate.137 = f64[128,256]{1,0} concatenate(transpose.135, transpose.136), dimensions={1}
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
  ROOT gather.143 = f64[128,128]{1,0} gather(concatenate.137, reshape.142), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.170 = f64[128,128]{1,0} parameter(0)
  transpose.180 = f64[128,128]{0,1} transpose(Arg_0.170), dimensions={1,0}
  transpose.181 = f64[128,128]{0,1} transpose(Arg_0.170), dimensions={1,0}
  concatenate.182 = f64[128,256]{1,0} concatenate(transpose.180, transpose.181), dimensions={1}
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
  ROOT gather.188 = f64[128,128]{1,0} gather(concatenate.182, reshape.187), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.215 = f64[128,128]{1,0} parameter(0)
  transpose.225 = f64[128,128]{0,1} transpose(Arg_0.215), dimensions={1,0}
  transpose.226 = f64[128,128]{0,1} transpose(Arg_0.215), dimensions={1,0}
  concatenate.227 = f64[128,256]{1,0} concatenate(transpose.225, transpose.226), dimensions={1}
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
  ROOT gather.233 = f64[128,128]{1,0} gather(concatenate.227, reshape.232), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.260 = f64[128,128]{1,0} parameter(0)
  transpose.270 = f64[128,128]{0,1} transpose(Arg_0.260), dimensions={1,0}
  transpose.271 = f64[128,128]{0,1} transpose(Arg_0.260), dimensions={1,0}
  concatenate.272 = f64[128,256]{1,0} concatenate(transpose.270, transpose.271), dimensions={1}
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
  ROOT gather.278 = f64[128,128]{1,0} gather(concatenate.272, reshape.277), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

advect_1d_matrix_diag.279 {
  Arg_0.280 = f64[128,128]{1,0} parameter(0)
  Arg_1.281 = f64[128]{0} parameter(1)
  Arg_2.282 = f64[] parameter(2)
  broadcast.309 = f64[128]{0} broadcast(Arg_2.282), dimensions={}
  multiply.310 = f64[128]{0} multiply(Arg_1.281, broadcast.309)
  Arg_3.283 = f64[] parameter(3)
  broadcast.311 = f64[128]{0} broadcast(Arg_3.283), dimensions={}
  divide.312 = f64[128]{0} divide(multiply.310, broadcast.311)
  floor.313 = f64[128]{0} floor(divide.312)
  convert.315 = s32[128]{0} convert(floor.313)
  Arg_4.284 = s32[6]{0} parameter(4)
  slice.378 = s32[1]{0} slice(Arg_4.284), slice={[0:1]}
  reshape.379 = s32[] reshape(slice.378)
  broadcast.380 = s32[128]{0} broadcast(reshape.379), dimensions={}
  add.381 = s32[128]{0} add(convert.315, broadcast.380)
  call.382 = f64[128,128]{1,0} call(Arg_0.280, add.381), to_apply=_roll_dynamic.34
  transpose.383 = f64[128,128]{0,1} transpose(call.382), dimensions={1,0}
  subtract.314 = f64[128]{0} subtract(divide.312, floor.313)
  constant.307 = f64[] constant(20)
  broadcast.308 = f64[128]{0} broadcast(constant.307), dimensions={}
  divide.320 = f64[128]{0} divide(subtract.314, broadcast.308)
  multiply.316 = f64[128]{0} multiply(subtract.314, subtract.314)
  constant.305 = f64[] constant(24)
  broadcast.306 = f64[128]{0} broadcast(constant.305), dimensions={}
  divide.321 = f64[128]{0} divide(multiply.316, broadcast.306)
  subtract.322 = f64[128]{0} subtract(divide.320, divide.321)
  multiply.317 = f64[128]{0} multiply(multiply.316, subtract.314)
  divide.323 = f64[128]{0} divide(multiply.317, broadcast.306)
  subtract.324 = f64[128]{0} subtract(subtract.322, divide.323)
  multiply.318 = f64[128]{0} multiply(multiply.317, subtract.314)
  divide.325 = f64[128]{0} divide(multiply.318, broadcast.306)
  add.326 = f64[128]{0} add(subtract.324, divide.325)
  multiply.319 = f64[128]{0} multiply(multiply.318, subtract.314)
  constant.303 = f64[] constant(120)
  broadcast.304 = f64[128]{0} broadcast(constant.303), dimensions={}
  divide.327 = f64[128]{0} divide(multiply.319, broadcast.304)
  subtract.328 = f64[128]{0} subtract(add.326, divide.327)
  reshape.384 = f64[1,128]{1,0} reshape(subtract.328)
  broadcast.385 = f64[1,128]{1,0} broadcast(reshape.384), dimensions={0,1}
  reshape.386 = f64[128]{0} reshape(broadcast.385)
  broadcast.387 = f64[128,128]{1,0} broadcast(reshape.386), dimensions={1}
  multiply.388 = f64[128,128]{0,1} multiply(transpose.383, broadcast.387)
  slice.389 = s32[1]{0} slice(Arg_4.284), slice={[1:2]}
  reshape.390 = s32[] reshape(slice.389)
  broadcast.391 = s32[128]{0} broadcast(reshape.390), dimensions={}
  add.392 = s32[128]{0} add(convert.315, broadcast.391)
  call.393 = f64[128,128]{1,0} call(Arg_0.280, add.392), to_apply=_roll_dynamic.79
  transpose.394 = f64[128,128]{0,1} transpose(call.393), dimensions={1,0}
  constant.301 = f64[] constant(2)
  broadcast.302 = f64[128]{0} broadcast(constant.301), dimensions={}
  divide.329 = f64[128]{0} divide(subtract.314, broadcast.302)
  negate.330 = f64[128]{0} negate(divide.329)
  multiply.331 = f64[128]{0} multiply(multiply.316, broadcast.302)
  constant.299 = f64[] constant(3)
  broadcast.300 = f64[128]{0} broadcast(constant.299), dimensions={}
  divide.332 = f64[128]{0} divide(multiply.331, broadcast.300)
  add.333 = f64[128]{0} add(negate.330, divide.332)
  divide.334 = f64[128]{0} divide(multiply.317, broadcast.306)
  subtract.335 = f64[128]{0} subtract(add.333, divide.334)
  constant.297 = f64[] constant(6)
  broadcast.298 = f64[128]{0} broadcast(constant.297), dimensions={}
  divide.336 = f64[128]{0} divide(multiply.318, broadcast.298)
  subtract.337 = f64[128]{0} subtract(subtract.335, divide.336)
  divide.338 = f64[128]{0} divide(multiply.319, broadcast.306)
  add.339 = f64[128]{0} add(subtract.337, divide.338)
  reshape.395 = f64[1,128]{1,0} reshape(add.339)
  broadcast.396 = f64[1,128]{1,0} broadcast(reshape.395), dimensions={0,1}
  reshape.397 = f64[128]{0} reshape(broadcast.396)
  broadcast.398 = f64[128,128]{1,0} broadcast(reshape.397), dimensions={1}
  multiply.399 = f64[128,128]{0,1} multiply(transpose.394, broadcast.398)
  add.400 = f64[128,128]{0,1} add(multiply.388, multiply.399)
  slice.401 = s32[1]{0} slice(Arg_4.284), slice={[2:3]}
  reshape.402 = s32[] reshape(slice.401)
  broadcast.403 = s32[128]{0} broadcast(reshape.402), dimensions={}
  add.404 = s32[128]{0} add(convert.315, broadcast.403)
  call.405 = f64[128,128]{1,0} call(Arg_0.280, add.404), to_apply=_roll_dynamic.124
  transpose.406 = f64[128,128]{0,1} transpose(call.405), dimensions={1,0}
  constant.295 = f64[] constant(1)
  broadcast.296 = f64[128]{0} broadcast(constant.295), dimensions={}
  divide.340 = f64[128]{0} divide(subtract.314, broadcast.300)
  subtract.341 = f64[128]{0} subtract(broadcast.296, divide.340)
  constant.293 = f64[] constant(5)
  broadcast.294 = f64[128]{0} broadcast(constant.293), dimensions={}
  multiply.342 = f64[128]{0} multiply(multiply.316, broadcast.294)
  constant.291 = f64[] constant(4)
  broadcast.292 = f64[128]{0} broadcast(constant.291), dimensions={}
  divide.343 = f64[128]{0} divide(multiply.342, broadcast.292)
  subtract.344 = f64[128]{0} subtract(subtract.341, divide.343)
  multiply.345 = f64[128]{0} multiply(multiply.317, broadcast.294)
  constant.289 = f64[] constant(12)
  broadcast.290 = f64[128]{0} broadcast(constant.289), dimensions={}
  divide.346 = f64[128]{0} divide(multiply.345, broadcast.290)
  add.347 = f64[128]{0} add(subtract.344, divide.346)
  divide.348 = f64[128]{0} divide(multiply.318, broadcast.292)
  add.349 = f64[128]{0} add(add.347, divide.348)
  divide.350 = f64[128]{0} divide(multiply.319, broadcast.290)
  subtract.351 = f64[128]{0} subtract(add.349, divide.350)
  reshape.407 = f64[1,128]{1,0} reshape(subtract.351)
  broadcast.408 = f64[1,128]{1,0} broadcast(reshape.407), dimensions={0,1}
  reshape.409 = f64[128]{0} reshape(broadcast.408)
  broadcast.410 = f64[128,128]{1,0} broadcast(reshape.409), dimensions={1}
  multiply.411 = f64[128,128]{0,1} multiply(transpose.406, broadcast.410)
  add.412 = f64[128,128]{0,1} add(add.400, multiply.411)
  slice.413 = s32[1]{0} slice(Arg_4.284), slice={[3:4]}
  reshape.414 = s32[] reshape(slice.413)
  broadcast.415 = s32[128]{0} broadcast(reshape.414), dimensions={}
  add.416 = s32[128]{0} add(convert.315, broadcast.415)
  call.417 = f64[128,128]{1,0} call(Arg_0.280, add.416), to_apply=_roll_dynamic.169
  transpose.418 = f64[128,128]{0,1} transpose(call.417), dimensions={1,0}
  multiply.352 = f64[128]{0} multiply(multiply.316, broadcast.302)
  divide.353 = f64[128]{0} divide(multiply.352, broadcast.300)
  add.354 = f64[128]{0} add(subtract.314, divide.353)
  constant.287 = f64[] constant(7)
  broadcast.288 = f64[128]{0} broadcast(constant.287), dimensions={}
  multiply.355 = f64[128]{0} multiply(multiply.317, broadcast.288)
  divide.356 = f64[128]{0} divide(multiply.355, broadcast.290)
  subtract.357 = f64[128]{0} subtract(add.354, divide.356)
  divide.358 = f64[128]{0} divide(multiply.318, broadcast.298)
  subtract.359 = f64[128]{0} subtract(subtract.357, divide.358)
  divide.360 = f64[128]{0} divide(multiply.319, broadcast.290)
  add.361 = f64[128]{0} add(subtract.359, divide.360)
  reshape.419 = f64[1,128]{1,0} reshape(add.361)
  broadcast.420 = f64[1,128]{1,0} broadcast(reshape.419), dimensions={0,1}
  reshape.421 = f64[128]{0} reshape(broadcast.420)
  broadcast.422 = f64[128,128]{1,0} broadcast(reshape.421), dimensions={1}
  multiply.423 = f64[128,128]{0,1} multiply(transpose.418, broadcast.422)
  add.424 = f64[128,128]{0,1} add(add.412, multiply.423)
  slice.425 = s32[1]{0} slice(Arg_4.284), slice={[4:5]}
  reshape.426 = s32[] reshape(slice.425)
  broadcast.427 = s32[128]{0} broadcast(reshape.426), dimensions={}
  add.428 = s32[128]{0} add(convert.315, broadcast.427)
  call.429 = f64[128,128]{1,0} call(Arg_0.280, add.428), to_apply=_roll_dynamic.214
  transpose.430 = f64[128,128]{0,1} transpose(call.429), dimensions={1,0}
  divide.362 = f64[128]{0} divide(subtract.314, broadcast.292)
  negate.363 = f64[128]{0} negate(divide.362)
  divide.364 = f64[128]{0} divide(multiply.316, broadcast.306)
  subtract.365 = f64[128]{0} subtract(negate.363, divide.364)
  multiply.366 = f64[128]{0} multiply(multiply.317, broadcast.288)
  divide.367 = f64[128]{0} divide(multiply.366, broadcast.306)
  add.368 = f64[128]{0} add(subtract.365, divide.367)
  divide.369 = f64[128]{0} divide(multiply.318, broadcast.306)
  add.370 = f64[128]{0} add(add.368, divide.369)
  divide.371 = f64[128]{0} divide(multiply.319, broadcast.306)
  subtract.372 = f64[128]{0} subtract(add.370, divide.371)
  reshape.431 = f64[1,128]{1,0} reshape(subtract.372)
  broadcast.432 = f64[1,128]{1,0} broadcast(reshape.431), dimensions={0,1}
  reshape.433 = f64[128]{0} reshape(broadcast.432)
  broadcast.434 = f64[128,128]{1,0} broadcast(reshape.433), dimensions={1}
  multiply.435 = f64[128,128]{0,1} multiply(transpose.430, broadcast.434)
  add.436 = f64[128,128]{0,1} add(add.424, multiply.435)
  slice.437 = s32[1]{0} slice(Arg_4.284), slice={[5:6]}
  reshape.438 = s32[] reshape(slice.437)
  broadcast.439 = s32[128]{0} broadcast(reshape.438), dimensions={}
  add.440 = s32[128]{0} add(convert.315, broadcast.439)
  call.441 = f64[128,128]{1,0} call(Arg_0.280, add.440), to_apply=_roll_dynamic.259
  transpose.442 = f64[128,128]{0,1} transpose(call.441), dimensions={1,0}
  constant.285 = f64[] constant(30)
  broadcast.286 = f64[128]{0} broadcast(constant.285), dimensions={}
  divide.373 = f64[128]{0} divide(subtract.314, broadcast.286)
  divide.374 = f64[128]{0} divide(multiply.317, broadcast.306)
  subtract.375 = f64[128]{0} subtract(divide.373, divide.374)
  divide.376 = f64[128]{0} divide(multiply.319, broadcast.304)
  add.377 = f64[128]{0} add(subtract.375, divide.376)
  reshape.443 = f64[1,128]{1,0} reshape(add.377)
  broadcast.444 = f64[1,128]{1,0} broadcast(reshape.443), dimensions={0,1}
  reshape.445 = f64[128]{0} reshape(broadcast.444)
  broadcast.446 = f64[128,128]{1,0} broadcast(reshape.445), dimensions={1}
  multiply.447 = f64[128,128]{0,1} multiply(transpose.442, broadcast.446)
  ROOT add.448 = f64[128,128]{0,1} add(add.436, multiply.447)
}

region_0.450 {
  Arg_0.451 = f64[] parameter(0)
  Arg_1.452 = f64[] parameter(1)
  ROOT add.453 = f64[] add(Arg_0.451, Arg_1.452)
}

fft.454 {
  Arg_0.455 = f64[128]{0} parameter(0)
  ROOT fft.456 = c128[65]{0} fft(Arg_0.455), fft_type=RFFT, fft_length={128}
}

fft_0.457 {
  Arg_0.458 = c128[65]{0} parameter(0)
  ROOT fft.459 = f64[128]{0} fft(Arg_0.458), fft_type=IRFFT, fft_length={128}
}

fft_0.460 {
  Arg_0.461 = c128[65]{0} parameter(0)
  ROOT fft.462 = f64[128]{0} fft(Arg_0.461), fft_type=IRFFT, fft_length={128}
}

solve_poisson.463 {
  Arg_0.464 = f64[128,128]{1,0} parameter(0)
  constant.471 = f64[] constant(0)
  reduce.472 = f64[128]{0} reduce(Arg_0.464, constant.471), dimensions={1}, to_apply=region_0.450
  Arg_2.466 = f64[] parameter(2)
  broadcast.473 = f64[128]{0} broadcast(Arg_2.466), dimensions={}
  multiply.474 = f64[128]{0} multiply(reduce.472, broadcast.473)
  constant.469 = f64[] constant(1)
  broadcast.470 = f64[128]{0} broadcast(constant.469), dimensions={}
  subtract.475 = f64[128]{0} subtract(multiply.474, broadcast.470)
  call.476 = c128[65]{0} call(subtract.475), to_apply=fft.454
  constant.467 = c128[] constant((-0, -1))
  broadcast.468 = c128[65]{0} broadcast(constant.467), dimensions={}
  multiply.477 = c128[65]{0} multiply(call.476, broadcast.468)
  Arg_1.465 = f64[65]{0} parameter(1)
  convert.478 = c128[65]{0} convert(Arg_1.465)
  multiply.479 = c128[65]{0} multiply(multiply.477, convert.478)
  call.480 = f64[128]{0} call(multiply.479), to_apply=fft_0.457
  multiply.481 = f64[65]{0} multiply(Arg_1.465, Arg_1.465)
  convert.482 = c128[65]{0} convert(multiply.481)
  multiply.483 = c128[65]{0} multiply(call.476, convert.482)
  call.484 = f64[128]{0} call(multiply.483), to_apply=fft_0.460
  ROOT tuple.485 = (f64[128]{0}, f64[128]{0}, f64[128]{0}) tuple(call.480, subtract.475, call.484)
}

_where_2.490 {
  Arg_0.491 = pred[6,128,128]{2,1,0} parameter(0)
  Arg_1.492 = f64[6,128,1]{2,1,0} parameter(1)
  broadcast.494 = f64[6,128,1]{2,1,0} broadcast(Arg_1.492), dimensions={0,1,2}
  reshape.495 = f64[6,128]{1,0} reshape(broadcast.494)
  broadcast.496 = f64[6,128,128]{2,1,0} broadcast(reshape.495), dimensions={0,1}
  Arg_2.493 = f64[] parameter(2)
  broadcast.497 = f64[6,128,128]{2,1,0} broadcast(Arg_2.493), dimensions={}
  ROOT select.498 = f64[6,128,128]{2,1,0} select(Arg_0.491, broadcast.496, broadcast.497)
}

build_v_diag_weights.499 {
  iota.601 = s64[128]{0} iota(), iota_dimension=0
  reshape.611 = s64[1,1,128]{2,1,0} reshape(iota.601)
  broadcast.614 = s64[1,1,128]{2,1,0} broadcast(reshape.611), dimensions={0,1,2}
  reshape.615 = s64[128]{0} reshape(broadcast.614)
  broadcast.616 = s64[6,128,128]{2,1,0} broadcast(reshape.615), dimensions={2}
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
  convert.613 = s64[6,128,1]{2,1,0} convert(reshape.612)
  broadcast.617 = s64[6,128,1]{2,1,0} broadcast(convert.613), dimensions={0,1,2}
  reshape.618 = s64[6,128]{1,0} reshape(broadcast.617)
  broadcast.619 = s64[6,128,128]{2,1,0} broadcast(reshape.618), dimensions={0,1}
  subtract.620 = s64[6,128,128]{2,1,0} subtract(broadcast.616, broadcast.619)
  constant.505 = s64[] constant(0)
  broadcast.506 = s64[6,128,128]{2,1,0} broadcast(constant.505), dimensions={}
  compare.621 = pred[6,128,128]{2,1,0} compare(subtract.620, broadcast.506), direction=GE
  constant.503 = s64[] constant(128)
  broadcast.504 = s64[6,128,128]{2,1,0} broadcast(constant.503), dimensions={}
  compare.622 = pred[6,128,128]{2,1,0} compare(subtract.620, broadcast.504), direction=LT
  and.623 = pred[6,128,128]{2,1,0} and(compare.621, compare.622)
  Arg_2.502 = f64[128]{0} parameter(2)
  constant.529 = f64[] constant(20)
  broadcast.530 = f64[128]{0} broadcast(constant.529), dimensions={}
  divide.536 = f64[128]{0} divide(Arg_2.502, broadcast.530)
  multiply.532 = f64[128]{0} multiply(Arg_2.502, Arg_2.502)
  constant.527 = f64[] constant(24)
  broadcast.528 = f64[128]{0} broadcast(constant.527), dimensions={}
  divide.537 = f64[128]{0} divide(multiply.532, broadcast.528)
  subtract.538 = f64[128]{0} subtract(divide.536, divide.537)
  multiply.533 = f64[128]{0} multiply(multiply.532, Arg_2.502)
  divide.539 = f64[128]{0} divide(multiply.533, broadcast.528)
  subtract.540 = f64[128]{0} subtract(subtract.538, divide.539)
  multiply.534 = f64[128]{0} multiply(multiply.533, Arg_2.502)
  divide.541 = f64[128]{0} divide(multiply.534, broadcast.528)
  add.542 = f64[128]{0} add(subtract.540, divide.541)
  multiply.535 = f64[128]{0} multiply(multiply.534, Arg_2.502)
  constant.525 = f64[] constant(120)
  broadcast.526 = f64[128]{0} broadcast(constant.525), dimensions={}
  divide.543 = f64[128]{0} divide(multiply.535, broadcast.526)
  subtract.544 = f64[128]{0} subtract(add.542, divide.543)
  reshape.594 = f64[1,128]{1,0} reshape(subtract.544)
  constant.523 = f64[] constant(2)
  broadcast.524 = f64[128]{0} broadcast(constant.523), dimensions={}
  divide.545 = f64[128]{0} divide(Arg_2.502, broadcast.524)
  negate.546 = f64[128]{0} negate(divide.545)
  multiply.547 = f64[128]{0} multiply(multiply.532, broadcast.524)
  constant.521 = f64[] constant(3)
  broadcast.522 = f64[128]{0} broadcast(constant.521), dimensions={}
  divide.548 = f64[128]{0} divide(multiply.547, broadcast.522)
  add.549 = f64[128]{0} add(negate.546, divide.548)
  divide.550 = f64[128]{0} divide(multiply.533, broadcast.528)
  subtract.551 = f64[128]{0} subtract(add.549, divide.550)
  constant.519 = f64[] constant(6)
  broadcast.520 = f64[128]{0} broadcast(constant.519), dimensions={}
  divide.552 = f64[128]{0} divide(multiply.534, broadcast.520)
  subtract.553 = f64[128]{0} subtract(subtract.551, divide.552)
  divide.554 = f64[128]{0} divide(multiply.535, broadcast.528)
  add.555 = f64[128]{0} add(subtract.553, divide.554)
  reshape.595 = f64[1,128]{1,0} reshape(add.555)
  constant.517 = f64[] constant(1)
  broadcast.518 = f64[128]{0} broadcast(constant.517), dimensions={}
  divide.556 = f64[128]{0} divide(Arg_2.502, broadcast.522)
  subtract.557 = f64[128]{0} subtract(broadcast.518, divide.556)
  constant.515 = f64[] constant(5)
  broadcast.516 = f64[128]{0} broadcast(constant.515), dimensions={}
  multiply.558 = f64[128]{0} multiply(multiply.532, broadcast.516)
  constant.513 = f64[] constant(4)
  broadcast.514 = f64[128]{0} broadcast(constant.513), dimensions={}
  divide.559 = f64[128]{0} divide(multiply.558, broadcast.514)
  subtract.560 = f64[128]{0} subtract(subtract.557, divide.559)
  multiply.561 = f64[128]{0} multiply(multiply.533, broadcast.516)
  constant.511 = f64[] constant(12)
  broadcast.512 = f64[128]{0} broadcast(constant.511), dimensions={}
  divide.562 = f64[128]{0} divide(multiply.561, broadcast.512)
  add.563 = f64[128]{0} add(subtract.560, divide.562)
  divide.564 = f64[128]{0} divide(multiply.534, broadcast.514)
  add.565 = f64[128]{0} add(add.563, divide.564)
  divide.566 = f64[128]{0} divide(multiply.535, broadcast.512)
  subtract.567 = f64[128]{0} subtract(add.565, divide.566)
  reshape.596 = f64[1,128]{1,0} reshape(subtract.567)
  multiply.568 = f64[128]{0} multiply(multiply.532, broadcast.524)
  divide.569 = f64[128]{0} divide(multiply.568, broadcast.522)
  add.570 = f64[128]{0} add(Arg_2.502, divide.569)
  constant.509 = f64[] constant(7)
  broadcast.510 = f64[128]{0} broadcast(constant.509), dimensions={}
  multiply.571 = f64[128]{0} multiply(multiply.533, broadcast.510)
  divide.572 = f64[128]{0} divide(multiply.571, broadcast.512)
  subtract.573 = f64[128]{0} subtract(add.570, divide.572)
  divide.574 = f64[128]{0} divide(multiply.534, broadcast.520)
  subtract.575 = f64[128]{0} subtract(subtract.573, divide.574)
  divide.576 = f64[128]{0} divide(multiply.535, broadcast.512)
  add.577 = f64[128]{0} add(subtract.575, divide.576)
  reshape.597 = f64[1,128]{1,0} reshape(add.577)
  divide.578 = f64[128]{0} divide(Arg_2.502, broadcast.514)
  negate.579 = f64[128]{0} negate(divide.578)
  divide.580 = f64[128]{0} divide(multiply.532, broadcast.528)
  subtract.581 = f64[128]{0} subtract(negate.579, divide.580)
  multiply.582 = f64[128]{0} multiply(multiply.533, broadcast.510)
  divide.583 = f64[128]{0} divide(multiply.582, broadcast.528)
  add.584 = f64[128]{0} add(subtract.581, divide.583)
  divide.585 = f64[128]{0} divide(multiply.534, broadcast.528)
  add.586 = f64[128]{0} add(add.584, divide.585)
  divide.587 = f64[128]{0} divide(multiply.535, broadcast.528)
  subtract.588 = f64[128]{0} subtract(add.586, divide.587)
  reshape.598 = f64[1,128]{1,0} reshape(subtract.588)
  constant.507 = f64[] constant(30)
  broadcast.508 = f64[128]{0} broadcast(constant.507), dimensions={}
  divide.589 = f64[128]{0} divide(Arg_2.502, broadcast.508)
  divide.590 = f64[128]{0} divide(multiply.533, broadcast.528)
  subtract.591 = f64[128]{0} subtract(divide.589, divide.590)
  divide.592 = f64[128]{0} divide(multiply.535, broadcast.526)
  add.593 = f64[128]{0} add(subtract.591, divide.592)
  reshape.599 = f64[1,128]{1,0} reshape(add.593)
  concatenate.600 = f64[6,128]{1,0} concatenate(reshape.594, reshape.595, reshape.596, reshape.597, reshape.598, reshape.599), dimensions={0}
  reshape.624 = f64[6,128,1]{2,1,0} reshape(concatenate.600)
  constant.531 = f64[] constant(0)
  ROOT call.625 = f64[6,128,128]{2,1,0} call(and.623, reshape.624, constant.531), to_apply=_where_2.490
}

_where.626 {
  Arg_0.627 = pred[] parameter(0)
  Arg_1.628 = s32[] parameter(1)
  Arg_2.629 = s32[] parameter(2)
  ROOT select.630 = s32[] select(Arg_0.627, Arg_1.628, Arg_2.629)
}

remainder.631 {
  Arg_0.632 = s32[128]{0} parameter(0)
  Arg_1.633 = s32[] parameter(1)
  constant.637 = s32[] constant(0)
  compare.638 = pred[] compare(Arg_1.633, constant.637), direction=EQ
  constant.636 = s32[] constant(1)
  call.639 = s32[] call(compare.638, constant.636, Arg_1.633), to_apply=_where.626
  broadcast.640 = s32[128]{0} broadcast(call.639), dimensions={}
  remainder.641 = s32[128]{0} remainder(Arg_0.632, broadcast.640)
  constant.634 = s32[] constant(0)
  broadcast.635 = s32[128]{0} broadcast(constant.634), dimensions={}
  compare.643 = pred[128]{0} compare(remainder.641, broadcast.635), direction=LT
  compare.644 = pred[] compare(call.639, constant.637), direction=LT
  broadcast.645 = pred[128]{0} broadcast(compare.644), dimensions={}
  compare.646 = pred[128]{0} compare(compare.643, broadcast.645), direction=NE
  compare.642 = pred[128]{0} compare(remainder.641, broadcast.635), direction=NE
  and.647 = pred[128]{0} and(compare.646, compare.642)
  broadcast.648 = s32[128]{0} broadcast(call.639), dimensions={}
  add.649 = s32[128]{0} add(remainder.641, broadcast.648)
  ROOT select.650 = s32[128]{0} select(and.647, add.649, remainder.641)
}

_roll_dynamic_3.651 {
  Arg_0.652 = f64[128,128]{1,0} parameter(0)
  concatenate.662 = f64[128,256]{1,0} concatenate(Arg_0.652, Arg_0.652), dimensions={1}
  constant.658 = s32[] constant(128)
  broadcast.659 = s32[128]{0} broadcast(constant.658), dimensions={}
  Arg_1.653 = s32[128]{0} parameter(1)
  constant.660 = s32[] constant(128)
  call.661 = s32[128]{0} call(Arg_1.653, constant.660), to_apply=remainder.631
  subtract.663 = s32[128]{0} subtract(broadcast.659, call.661)
  constant.656 = s32[] constant(0)
  broadcast.657 = s32[128]{0} broadcast(constant.656), dimensions={}
  compare.664 = pred[128]{0} compare(subtract.663, broadcast.657), direction=LT
  constant.654 = s32[] constant(256)
  broadcast.655 = s32[128]{0} broadcast(constant.654), dimensions={}
  add.665 = s32[128]{0} add(subtract.663, broadcast.655)
  select.666 = s32[128]{0} select(compare.664, add.665, subtract.663)
  reshape.667 = s32[128,1]{1,0} reshape(select.666)
  ROOT gather.668 = f64[128,128]{1,0} gather(concatenate.662, reshape.667), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.669 {
  Arg_0.670 = pred[] parameter(0)
  Arg_1.671 = s32[] parameter(1)
  Arg_2.672 = s32[] parameter(2)
  ROOT select.673 = s32[] select(Arg_0.670, Arg_1.671, Arg_2.672)
}

remainder.674 {
  Arg_0.675 = s32[128]{0} parameter(0)
  Arg_1.676 = s32[] parameter(1)
  constant.680 = s32[] constant(0)
  compare.681 = pred[] compare(Arg_1.676, constant.680), direction=EQ
  constant.679 = s32[] constant(1)
  call.682 = s32[] call(compare.681, constant.679, Arg_1.676), to_apply=_where.669
  broadcast.683 = s32[128]{0} broadcast(call.682), dimensions={}
  remainder.684 = s32[128]{0} remainder(Arg_0.675, broadcast.683)
  constant.677 = s32[] constant(0)
  broadcast.678 = s32[128]{0} broadcast(constant.677), dimensions={}
  compare.686 = pred[128]{0} compare(remainder.684, broadcast.678), direction=LT
  compare.687 = pred[] compare(call.682, constant.680), direction=LT
  broadcast.688 = pred[128]{0} broadcast(compare.687), dimensions={}
  compare.689 = pred[128]{0} compare(compare.686, broadcast.688), direction=NE
  compare.685 = pred[128]{0} compare(remainder.684, broadcast.678), direction=NE
  and.690 = pred[128]{0} and(compare.689, compare.685)
  broadcast.691 = s32[128]{0} broadcast(call.682), dimensions={}
  add.692 = s32[128]{0} add(remainder.684, broadcast.691)
  ROOT select.693 = s32[128]{0} select(and.690, add.692, remainder.684)
}

_roll_dynamic_3.694 {
  Arg_0.695 = f64[128,128]{1,0} parameter(0)
  concatenate.705 = f64[128,256]{1,0} concatenate(Arg_0.695, Arg_0.695), dimensions={1}
  constant.701 = s32[] constant(128)
  broadcast.702 = s32[128]{0} broadcast(constant.701), dimensions={}
  Arg_1.696 = s32[128]{0} parameter(1)
  constant.703 = s32[] constant(128)
  call.704 = s32[128]{0} call(Arg_1.696, constant.703), to_apply=remainder.674
  subtract.706 = s32[128]{0} subtract(broadcast.702, call.704)
  constant.699 = s32[] constant(0)
  broadcast.700 = s32[128]{0} broadcast(constant.699), dimensions={}
  compare.707 = pred[128]{0} compare(subtract.706, broadcast.700), direction=LT
  constant.697 = s32[] constant(256)
  broadcast.698 = s32[128]{0} broadcast(constant.697), dimensions={}
  add.708 = s32[128]{0} add(subtract.706, broadcast.698)
  select.709 = s32[128]{0} select(compare.707, add.708, subtract.706)
  reshape.710 = s32[128,1]{1,0} reshape(select.709)
  ROOT gather.711 = f64[128,128]{1,0} gather(concatenate.705, reshape.710), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.712 {
  Arg_0.713 = pred[] parameter(0)
  Arg_1.714 = s32[] parameter(1)
  Arg_2.715 = s32[] parameter(2)
  ROOT select.716 = s32[] select(Arg_0.713, Arg_1.714, Arg_2.715)
}

remainder.717 {
  Arg_0.718 = s32[128]{0} parameter(0)
  Arg_1.719 = s32[] parameter(1)
  constant.723 = s32[] constant(0)
  compare.724 = pred[] compare(Arg_1.719, constant.723), direction=EQ
  constant.722 = s32[] constant(1)
  call.725 = s32[] call(compare.724, constant.722, Arg_1.719), to_apply=_where.712
  broadcast.726 = s32[128]{0} broadcast(call.725), dimensions={}
  remainder.727 = s32[128]{0} remainder(Arg_0.718, broadcast.726)
  constant.720 = s32[] constant(0)
  broadcast.721 = s32[128]{0} broadcast(constant.720), dimensions={}
  compare.729 = pred[128]{0} compare(remainder.727, broadcast.721), direction=LT
  compare.730 = pred[] compare(call.725, constant.723), direction=LT
  broadcast.731 = pred[128]{0} broadcast(compare.730), dimensions={}
  compare.732 = pred[128]{0} compare(compare.729, broadcast.731), direction=NE
  compare.728 = pred[128]{0} compare(remainder.727, broadcast.721), direction=NE
  and.733 = pred[128]{0} and(compare.732, compare.728)
  broadcast.734 = s32[128]{0} broadcast(call.725), dimensions={}
  add.735 = s32[128]{0} add(remainder.727, broadcast.734)
  ROOT select.736 = s32[128]{0} select(and.733, add.735, remainder.727)
}

_roll_dynamic_3.737 {
  Arg_0.738 = f64[128,128]{1,0} parameter(0)
  concatenate.748 = f64[128,256]{1,0} concatenate(Arg_0.738, Arg_0.738), dimensions={1}
  constant.744 = s32[] constant(128)
  broadcast.745 = s32[128]{0} broadcast(constant.744), dimensions={}
  Arg_1.739 = s32[128]{0} parameter(1)
  constant.746 = s32[] constant(128)
  call.747 = s32[128]{0} call(Arg_1.739, constant.746), to_apply=remainder.717
  subtract.749 = s32[128]{0} subtract(broadcast.745, call.747)
  constant.742 = s32[] constant(0)
  broadcast.743 = s32[128]{0} broadcast(constant.742), dimensions={}
  compare.750 = pred[128]{0} compare(subtract.749, broadcast.743), direction=LT
  constant.740 = s32[] constant(256)
  broadcast.741 = s32[128]{0} broadcast(constant.740), dimensions={}
  add.751 = s32[128]{0} add(subtract.749, broadcast.741)
  select.752 = s32[128]{0} select(compare.750, add.751, subtract.749)
  reshape.753 = s32[128,1]{1,0} reshape(select.752)
  ROOT gather.754 = f64[128,128]{1,0} gather(concatenate.748, reshape.753), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.755 {
  Arg_0.756 = pred[] parameter(0)
  Arg_1.757 = s32[] parameter(1)
  Arg_2.758 = s32[] parameter(2)
  ROOT select.759 = s32[] select(Arg_0.756, Arg_1.757, Arg_2.758)
}

remainder.760 {
  Arg_0.761 = s32[128]{0} parameter(0)
  Arg_1.762 = s32[] parameter(1)
  constant.766 = s32[] constant(0)
  compare.767 = pred[] compare(Arg_1.762, constant.766), direction=EQ
  constant.765 = s32[] constant(1)
  call.768 = s32[] call(compare.767, constant.765, Arg_1.762), to_apply=_where.755
  broadcast.769 = s32[128]{0} broadcast(call.768), dimensions={}
  remainder.770 = s32[128]{0} remainder(Arg_0.761, broadcast.769)
  constant.763 = s32[] constant(0)
  broadcast.764 = s32[128]{0} broadcast(constant.763), dimensions={}
  compare.772 = pred[128]{0} compare(remainder.770, broadcast.764), direction=LT
  compare.773 = pred[] compare(call.768, constant.766), direction=LT
  broadcast.774 = pred[128]{0} broadcast(compare.773), dimensions={}
  compare.775 = pred[128]{0} compare(compare.772, broadcast.774), direction=NE
  compare.771 = pred[128]{0} compare(remainder.770, broadcast.764), direction=NE
  and.776 = pred[128]{0} and(compare.775, compare.771)
  broadcast.777 = s32[128]{0} broadcast(call.768), dimensions={}
  add.778 = s32[128]{0} add(remainder.770, broadcast.777)
  ROOT select.779 = s32[128]{0} select(and.776, add.778, remainder.770)
}

_roll_dynamic_3.780 {
  Arg_0.781 = f64[128,128]{1,0} parameter(0)
  concatenate.791 = f64[128,256]{1,0} concatenate(Arg_0.781, Arg_0.781), dimensions={1}
  constant.787 = s32[] constant(128)
  broadcast.788 = s32[128]{0} broadcast(constant.787), dimensions={}
  Arg_1.782 = s32[128]{0} parameter(1)
  constant.789 = s32[] constant(128)
  call.790 = s32[128]{0} call(Arg_1.782, constant.789), to_apply=remainder.760
  subtract.792 = s32[128]{0} subtract(broadcast.788, call.790)
  constant.785 = s32[] constant(0)
  broadcast.786 = s32[128]{0} broadcast(constant.785), dimensions={}
  compare.793 = pred[128]{0} compare(subtract.792, broadcast.786), direction=LT
  constant.783 = s32[] constant(256)
  broadcast.784 = s32[128]{0} broadcast(constant.783), dimensions={}
  add.794 = s32[128]{0} add(subtract.792, broadcast.784)
  select.795 = s32[128]{0} select(compare.793, add.794, subtract.792)
  reshape.796 = s32[128,1]{1,0} reshape(select.795)
  ROOT gather.797 = f64[128,128]{1,0} gather(concatenate.791, reshape.796), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.798 {
  Arg_0.799 = pred[] parameter(0)
  Arg_1.800 = s32[] parameter(1)
  Arg_2.801 = s32[] parameter(2)
  ROOT select.802 = s32[] select(Arg_0.799, Arg_1.800, Arg_2.801)
}

remainder.803 {
  Arg_0.804 = s32[128]{0} parameter(0)
  Arg_1.805 = s32[] parameter(1)
  constant.809 = s32[] constant(0)
  compare.810 = pred[] compare(Arg_1.805, constant.809), direction=EQ
  constant.808 = s32[] constant(1)
  call.811 = s32[] call(compare.810, constant.808, Arg_1.805), to_apply=_where.798
  broadcast.812 = s32[128]{0} broadcast(call.811), dimensions={}
  remainder.813 = s32[128]{0} remainder(Arg_0.804, broadcast.812)
  constant.806 = s32[] constant(0)
  broadcast.807 = s32[128]{0} broadcast(constant.806), dimensions={}
  compare.815 = pred[128]{0} compare(remainder.813, broadcast.807), direction=LT
  compare.816 = pred[] compare(call.811, constant.809), direction=LT
  broadcast.817 = pred[128]{0} broadcast(compare.816), dimensions={}
  compare.818 = pred[128]{0} compare(compare.815, broadcast.817), direction=NE
  compare.814 = pred[128]{0} compare(remainder.813, broadcast.807), direction=NE
  and.819 = pred[128]{0} and(compare.818, compare.814)
  broadcast.820 = s32[128]{0} broadcast(call.811), dimensions={}
  add.821 = s32[128]{0} add(remainder.813, broadcast.820)
  ROOT select.822 = s32[128]{0} select(and.819, add.821, remainder.813)
}

_roll_dynamic_3.823 {
  Arg_0.824 = f64[128,128]{1,0} parameter(0)
  concatenate.834 = f64[128,256]{1,0} concatenate(Arg_0.824, Arg_0.824), dimensions={1}
  constant.830 = s32[] constant(128)
  broadcast.831 = s32[128]{0} broadcast(constant.830), dimensions={}
  Arg_1.825 = s32[128]{0} parameter(1)
  constant.832 = s32[] constant(128)
  call.833 = s32[128]{0} call(Arg_1.825, constant.832), to_apply=remainder.803
  subtract.835 = s32[128]{0} subtract(broadcast.831, call.833)
  constant.828 = s32[] constant(0)
  broadcast.829 = s32[128]{0} broadcast(constant.828), dimensions={}
  compare.836 = pred[128]{0} compare(subtract.835, broadcast.829), direction=LT
  constant.826 = s32[] constant(256)
  broadcast.827 = s32[128]{0} broadcast(constant.826), dimensions={}
  add.837 = s32[128]{0} add(subtract.835, broadcast.827)
  select.838 = s32[128]{0} select(compare.836, add.837, subtract.835)
  reshape.839 = s32[128,1]{1,0} reshape(select.838)
  ROOT gather.840 = f64[128,128]{1,0} gather(concatenate.834, reshape.839), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.841 {
  Arg_0.842 = pred[] parameter(0)
  Arg_1.843 = s32[] parameter(1)
  Arg_2.844 = s32[] parameter(2)
  ROOT select.845 = s32[] select(Arg_0.842, Arg_1.843, Arg_2.844)
}

remainder.846 {
  Arg_0.847 = s32[128]{0} parameter(0)
  Arg_1.848 = s32[] parameter(1)
  constant.852 = s32[] constant(0)
  compare.853 = pred[] compare(Arg_1.848, constant.852), direction=EQ
  constant.851 = s32[] constant(1)
  call.854 = s32[] call(compare.853, constant.851, Arg_1.848), to_apply=_where.841
  broadcast.855 = s32[128]{0} broadcast(call.854), dimensions={}
  remainder.856 = s32[128]{0} remainder(Arg_0.847, broadcast.855)
  constant.849 = s32[] constant(0)
  broadcast.850 = s32[128]{0} broadcast(constant.849), dimensions={}
  compare.858 = pred[128]{0} compare(remainder.856, broadcast.850), direction=LT
  compare.859 = pred[] compare(call.854, constant.852), direction=LT
  broadcast.860 = pred[128]{0} broadcast(compare.859), dimensions={}
  compare.861 = pred[128]{0} compare(compare.858, broadcast.860), direction=NE
  compare.857 = pred[128]{0} compare(remainder.856, broadcast.850), direction=NE
  and.862 = pred[128]{0} and(compare.861, compare.857)
  broadcast.863 = s32[128]{0} broadcast(call.854), dimensions={}
  add.864 = s32[128]{0} add(remainder.856, broadcast.863)
  ROOT select.865 = s32[128]{0} select(and.862, add.864, remainder.856)
}

_roll_dynamic_3.866 {
  Arg_0.867 = f64[128,128]{1,0} parameter(0)
  concatenate.877 = f64[128,256]{1,0} concatenate(Arg_0.867, Arg_0.867), dimensions={1}
  constant.873 = s32[] constant(128)
  broadcast.874 = s32[128]{0} broadcast(constant.873), dimensions={}
  Arg_1.868 = s32[128]{0} parameter(1)
  constant.875 = s32[] constant(128)
  call.876 = s32[128]{0} call(Arg_1.868, constant.875), to_apply=remainder.846
  subtract.878 = s32[128]{0} subtract(broadcast.874, call.876)
  constant.871 = s32[] constant(0)
  broadcast.872 = s32[128]{0} broadcast(constant.871), dimensions={}
  compare.879 = pred[128]{0} compare(subtract.878, broadcast.872), direction=LT
  constant.869 = s32[] constant(256)
  broadcast.870 = s32[128]{0} broadcast(constant.869), dimensions={}
  add.880 = s32[128]{0} add(subtract.878, broadcast.870)
  select.881 = s32[128]{0} select(compare.879, add.880, subtract.878)
  reshape.882 = s32[128,1]{1,0} reshape(select.881)
  ROOT gather.883 = f64[128,128]{1,0} gather(concatenate.877, reshape.882), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

advect_1d_matrix_diag_1.884 {
  Arg_4.889 = s32[6]{0} parameter(4)
  Arg_1.886 = f64[128]{0} parameter(1)
  Arg_2.887 = f64[] parameter(2)
  broadcast.890 = f64[128]{0} broadcast(Arg_2.887), dimensions={}
  multiply.891 = f64[128]{0} multiply(Arg_1.886, broadcast.890)
  Arg_3.888 = f64[] parameter(3)
  broadcast.892 = f64[128]{0} broadcast(Arg_3.888), dimensions={}
  divide.893 = f64[128]{0} divide(multiply.891, broadcast.892)
  floor.894 = f64[128]{0} floor(divide.893)
  convert.896 = s32[128]{0} convert(floor.894)
  subtract.895 = f64[128]{0} subtract(divide.893, floor.894)
  call.897 = f64[6,128,128]{2,1,0} call(Arg_4.889, convert.896, subtract.895), to_apply=build_v_diag_weights.499
  slice.903 = f64[1,128,128]{2,1,0} slice(call.897), slice={[0:1], [0:128], [0:128]}
  reshape.904 = f64[128,128]{1,0} reshape(slice.903)
  Arg_0.885 = f64[128,128]{1,0} parameter(0)
  slice.898 = s32[1]{0} slice(Arg_4.889), slice={[0:1]}
  reshape.899 = s32[] reshape(slice.898)
  broadcast.900 = s32[128]{0} broadcast(reshape.899), dimensions={}
  add.901 = s32[128]{0} add(convert.896, broadcast.900)
  call.902 = f64[128,128]{1,0} call(Arg_0.885, add.901), to_apply=_roll_dynamic_3.651
  multiply.905 = f64[128,128]{1,0} multiply(reshape.904, call.902)
  slice.911 = f64[1,128,128]{2,1,0} slice(call.897), slice={[1:2], [0:128], [0:128]}
  reshape.912 = f64[128,128]{1,0} reshape(slice.911)
  slice.906 = s32[1]{0} slice(Arg_4.889), slice={[1:2]}
  reshape.907 = s32[] reshape(slice.906)
  broadcast.908 = s32[128]{0} broadcast(reshape.907), dimensions={}
  add.909 = s32[128]{0} add(convert.896, broadcast.908)
  call.910 = f64[128,128]{1,0} call(Arg_0.885, add.909), to_apply=_roll_dynamic_3.694
  multiply.913 = f64[128,128]{1,0} multiply(reshape.912, call.910)
  add.914 = f64[128,128]{1,0} add(multiply.905, multiply.913)
  slice.920 = f64[1,128,128]{2,1,0} slice(call.897), slice={[2:3], [0:128], [0:128]}
  reshape.921 = f64[128,128]{1,0} reshape(slice.920)
  slice.915 = s32[1]{0} slice(Arg_4.889), slice={[2:3]}
  reshape.916 = s32[] reshape(slice.915)
  broadcast.917 = s32[128]{0} broadcast(reshape.916), dimensions={}
  add.918 = s32[128]{0} add(convert.896, broadcast.917)
  call.919 = f64[128,128]{1,0} call(Arg_0.885, add.918), to_apply=_roll_dynamic_3.737
  multiply.922 = f64[128,128]{1,0} multiply(reshape.921, call.919)
  add.923 = f64[128,128]{1,0} add(add.914, multiply.922)
  slice.929 = f64[1,128,128]{2,1,0} slice(call.897), slice={[3:4], [0:128], [0:128]}
  reshape.930 = f64[128,128]{1,0} reshape(slice.929)
  slice.924 = s32[1]{0} slice(Arg_4.889), slice={[3:4]}
  reshape.925 = s32[] reshape(slice.924)
  broadcast.926 = s32[128]{0} broadcast(reshape.925), dimensions={}
  add.927 = s32[128]{0} add(convert.896, broadcast.926)
  call.928 = f64[128,128]{1,0} call(Arg_0.885, add.927), to_apply=_roll_dynamic_3.780
  multiply.931 = f64[128,128]{1,0} multiply(reshape.930, call.928)
  add.932 = f64[128,128]{1,0} add(add.923, multiply.931)
  slice.938 = f64[1,128,128]{2,1,0} slice(call.897), slice={[4:5], [0:128], [0:128]}
  reshape.939 = f64[128,128]{1,0} reshape(slice.938)
  slice.933 = s32[1]{0} slice(Arg_4.889), slice={[4:5]}
  reshape.934 = s32[] reshape(slice.933)
  broadcast.935 = s32[128]{0} broadcast(reshape.934), dimensions={}
  add.936 = s32[128]{0} add(convert.896, broadcast.935)
  call.937 = f64[128,128]{1,0} call(Arg_0.885, add.936), to_apply=_roll_dynamic_3.823
  multiply.940 = f64[128,128]{1,0} multiply(reshape.939, call.937)
  add.941 = f64[128,128]{1,0} add(add.932, multiply.940)
  slice.947 = f64[1,128,128]{2,1,0} slice(call.897), slice={[5:6], [0:128], [0:128]}
  reshape.948 = f64[128,128]{1,0} reshape(slice.947)
  slice.942 = s32[1]{0} slice(Arg_4.889), slice={[5:6]}
  reshape.943 = s32[] reshape(slice.942)
  broadcast.944 = s32[128]{0} broadcast(reshape.943), dimensions={}
  add.945 = s32[128]{0} add(convert.896, broadcast.944)
  call.946 = f64[128,128]{1,0} call(Arg_0.885, add.945), to_apply=_roll_dynamic_3.866
  multiply.949 = f64[128,128]{1,0} multiply(reshape.948, call.946)
  ROOT add.950 = f64[128,128]{1,0} add(add.941, multiply.949)
}

_where.952 {
  Arg_0.953 = pred[] parameter(0)
  Arg_1.954 = s32[] parameter(1)
  Arg_2.955 = s32[] parameter(2)
  ROOT select.956 = s32[] select(Arg_0.953, Arg_1.954, Arg_2.955)
}

remainder.957 {
  Arg_0.958 = s32[128]{0} parameter(0)
  Arg_1.959 = s32[] parameter(1)
  constant.963 = s32[] constant(0)
  compare.964 = pred[] compare(Arg_1.959, constant.963), direction=EQ
  constant.962 = s32[] constant(1)
  call.965 = s32[] call(compare.964, constant.962, Arg_1.959), to_apply=_where.952
  broadcast.966 = s32[128]{0} broadcast(call.965), dimensions={}
  remainder.967 = s32[128]{0} remainder(Arg_0.958, broadcast.966)
  constant.960 = s32[] constant(0)
  broadcast.961 = s32[128]{0} broadcast(constant.960), dimensions={}
  compare.969 = pred[128]{0} compare(remainder.967, broadcast.961), direction=LT
  compare.970 = pred[] compare(call.965, constant.963), direction=LT
  broadcast.971 = pred[128]{0} broadcast(compare.970), dimensions={}
  compare.972 = pred[128]{0} compare(compare.969, broadcast.971), direction=NE
  compare.968 = pred[128]{0} compare(remainder.967, broadcast.961), direction=NE
  and.973 = pred[128]{0} and(compare.972, compare.968)
  broadcast.974 = s32[128]{0} broadcast(call.965), dimensions={}
  add.975 = s32[128]{0} add(remainder.967, broadcast.974)
  ROOT select.976 = s32[128]{0} select(and.973, add.975, remainder.967)
}

_roll_dynamic.977 {
  Arg_0.978 = f64[128,128]{1,0} parameter(0)
  transpose.988 = f64[128,128]{0,1} transpose(Arg_0.978), dimensions={1,0}
  transpose.989 = f64[128,128]{0,1} transpose(Arg_0.978), dimensions={1,0}
  concatenate.990 = f64[128,256]{1,0} concatenate(transpose.988, transpose.989), dimensions={1}
  constant.984 = s32[] constant(128)
  broadcast.985 = s32[128]{0} broadcast(constant.984), dimensions={}
  Arg_1.979 = s32[128]{0} parameter(1)
  constant.986 = s32[] constant(128)
  call.987 = s32[128]{0} call(Arg_1.979, constant.986), to_apply=remainder.957
  subtract.991 = s32[128]{0} subtract(broadcast.985, call.987)
  constant.982 = s32[] constant(0)
  broadcast.983 = s32[128]{0} broadcast(constant.982), dimensions={}
  compare.992 = pred[128]{0} compare(subtract.991, broadcast.983), direction=LT
  constant.980 = s32[] constant(256)
  broadcast.981 = s32[128]{0} broadcast(constant.980), dimensions={}
  add.993 = s32[128]{0} add(subtract.991, broadcast.981)
  select.994 = s32[128]{0} select(compare.992, add.993, subtract.991)
  reshape.995 = s32[128,1]{1,0} reshape(select.994)
  ROOT gather.996 = f64[128,128]{1,0} gather(concatenate.990, reshape.995), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.997 {
  Arg_0.998 = pred[] parameter(0)
  Arg_1.999 = s32[] parameter(1)
  Arg_2.1000 = s32[] parameter(2)
  ROOT select.1001 = s32[] select(Arg_0.998, Arg_1.999, Arg_2.1000)
}

remainder.1002 {
  Arg_0.1003 = s32[128]{0} parameter(0)
  Arg_1.1004 = s32[] parameter(1)
  constant.1008 = s32[] constant(0)
  compare.1009 = pred[] compare(Arg_1.1004, constant.1008), direction=EQ
  constant.1007 = s32[] constant(1)
  call.1010 = s32[] call(compare.1009, constant.1007, Arg_1.1004), to_apply=_where.997
  broadcast.1011 = s32[128]{0} broadcast(call.1010), dimensions={}
  remainder.1012 = s32[128]{0} remainder(Arg_0.1003, broadcast.1011)
  constant.1005 = s32[] constant(0)
  broadcast.1006 = s32[128]{0} broadcast(constant.1005), dimensions={}
  compare.1014 = pred[128]{0} compare(remainder.1012, broadcast.1006), direction=LT
  compare.1015 = pred[] compare(call.1010, constant.1008), direction=LT
  broadcast.1016 = pred[128]{0} broadcast(compare.1015), dimensions={}
  compare.1017 = pred[128]{0} compare(compare.1014, broadcast.1016), direction=NE
  compare.1013 = pred[128]{0} compare(remainder.1012, broadcast.1006), direction=NE
  and.1018 = pred[128]{0} and(compare.1017, compare.1013)
  broadcast.1019 = s32[128]{0} broadcast(call.1010), dimensions={}
  add.1020 = s32[128]{0} add(remainder.1012, broadcast.1019)
  ROOT select.1021 = s32[128]{0} select(and.1018, add.1020, remainder.1012)
}

_roll_dynamic.1022 {
  Arg_0.1023 = f64[128,128]{1,0} parameter(0)
  transpose.1033 = f64[128,128]{0,1} transpose(Arg_0.1023), dimensions={1,0}
  transpose.1034 = f64[128,128]{0,1} transpose(Arg_0.1023), dimensions={1,0}
  concatenate.1035 = f64[128,256]{1,0} concatenate(transpose.1033, transpose.1034), dimensions={1}
  constant.1029 = s32[] constant(128)
  broadcast.1030 = s32[128]{0} broadcast(constant.1029), dimensions={}
  Arg_1.1024 = s32[128]{0} parameter(1)
  constant.1031 = s32[] constant(128)
  call.1032 = s32[128]{0} call(Arg_1.1024, constant.1031), to_apply=remainder.1002
  subtract.1036 = s32[128]{0} subtract(broadcast.1030, call.1032)
  constant.1027 = s32[] constant(0)
  broadcast.1028 = s32[128]{0} broadcast(constant.1027), dimensions={}
  compare.1037 = pred[128]{0} compare(subtract.1036, broadcast.1028), direction=LT
  constant.1025 = s32[] constant(256)
  broadcast.1026 = s32[128]{0} broadcast(constant.1025), dimensions={}
  add.1038 = s32[128]{0} add(subtract.1036, broadcast.1026)
  select.1039 = s32[128]{0} select(compare.1037, add.1038, subtract.1036)
  reshape.1040 = s32[128,1]{1,0} reshape(select.1039)
  ROOT gather.1041 = f64[128,128]{1,0} gather(concatenate.1035, reshape.1040), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.1042 {
  Arg_0.1043 = pred[] parameter(0)
  Arg_1.1044 = s32[] parameter(1)
  Arg_2.1045 = s32[] parameter(2)
  ROOT select.1046 = s32[] select(Arg_0.1043, Arg_1.1044, Arg_2.1045)
}

remainder.1047 {
  Arg_0.1048 = s32[128]{0} parameter(0)
  Arg_1.1049 = s32[] parameter(1)
  constant.1053 = s32[] constant(0)
  compare.1054 = pred[] compare(Arg_1.1049, constant.1053), direction=EQ
  constant.1052 = s32[] constant(1)
  call.1055 = s32[] call(compare.1054, constant.1052, Arg_1.1049), to_apply=_where.1042
  broadcast.1056 = s32[128]{0} broadcast(call.1055), dimensions={}
  remainder.1057 = s32[128]{0} remainder(Arg_0.1048, broadcast.1056)
  constant.1050 = s32[] constant(0)
  broadcast.1051 = s32[128]{0} broadcast(constant.1050), dimensions={}
  compare.1059 = pred[128]{0} compare(remainder.1057, broadcast.1051), direction=LT
  compare.1060 = pred[] compare(call.1055, constant.1053), direction=LT
  broadcast.1061 = pred[128]{0} broadcast(compare.1060), dimensions={}
  compare.1062 = pred[128]{0} compare(compare.1059, broadcast.1061), direction=NE
  compare.1058 = pred[128]{0} compare(remainder.1057, broadcast.1051), direction=NE
  and.1063 = pred[128]{0} and(compare.1062, compare.1058)
  broadcast.1064 = s32[128]{0} broadcast(call.1055), dimensions={}
  add.1065 = s32[128]{0} add(remainder.1057, broadcast.1064)
  ROOT select.1066 = s32[128]{0} select(and.1063, add.1065, remainder.1057)
}

_roll_dynamic.1067 {
  Arg_0.1068 = f64[128,128]{1,0} parameter(0)
  transpose.1078 = f64[128,128]{0,1} transpose(Arg_0.1068), dimensions={1,0}
  transpose.1079 = f64[128,128]{0,1} transpose(Arg_0.1068), dimensions={1,0}
  concatenate.1080 = f64[128,256]{1,0} concatenate(transpose.1078, transpose.1079), dimensions={1}
  constant.1074 = s32[] constant(128)
  broadcast.1075 = s32[128]{0} broadcast(constant.1074), dimensions={}
  Arg_1.1069 = s32[128]{0} parameter(1)
  constant.1076 = s32[] constant(128)
  call.1077 = s32[128]{0} call(Arg_1.1069, constant.1076), to_apply=remainder.1047
  subtract.1081 = s32[128]{0} subtract(broadcast.1075, call.1077)
  constant.1072 = s32[] constant(0)
  broadcast.1073 = s32[128]{0} broadcast(constant.1072), dimensions={}
  compare.1082 = pred[128]{0} compare(subtract.1081, broadcast.1073), direction=LT
  constant.1070 = s32[] constant(256)
  broadcast.1071 = s32[128]{0} broadcast(constant.1070), dimensions={}
  add.1083 = s32[128]{0} add(subtract.1081, broadcast.1071)
  select.1084 = s32[128]{0} select(compare.1082, add.1083, subtract.1081)
  reshape.1085 = s32[128,1]{1,0} reshape(select.1084)
  ROOT gather.1086 = f64[128,128]{1,0} gather(concatenate.1080, reshape.1085), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.1087 {
  Arg_0.1088 = pred[] parameter(0)
  Arg_1.1089 = s32[] parameter(1)
  Arg_2.1090 = s32[] parameter(2)
  ROOT select.1091 = s32[] select(Arg_0.1088, Arg_1.1089, Arg_2.1090)
}

remainder.1092 {
  Arg_0.1093 = s32[128]{0} parameter(0)
  Arg_1.1094 = s32[] parameter(1)
  constant.1098 = s32[] constant(0)
  compare.1099 = pred[] compare(Arg_1.1094, constant.1098), direction=EQ
  constant.1097 = s32[] constant(1)
  call.1100 = s32[] call(compare.1099, constant.1097, Arg_1.1094), to_apply=_where.1087
  broadcast.1101 = s32[128]{0} broadcast(call.1100), dimensions={}
  remainder.1102 = s32[128]{0} remainder(Arg_0.1093, broadcast.1101)
  constant.1095 = s32[] constant(0)
  broadcast.1096 = s32[128]{0} broadcast(constant.1095), dimensions={}
  compare.1104 = pred[128]{0} compare(remainder.1102, broadcast.1096), direction=LT
  compare.1105 = pred[] compare(call.1100, constant.1098), direction=LT
  broadcast.1106 = pred[128]{0} broadcast(compare.1105), dimensions={}
  compare.1107 = pred[128]{0} compare(compare.1104, broadcast.1106), direction=NE
  compare.1103 = pred[128]{0} compare(remainder.1102, broadcast.1096), direction=NE
  and.1108 = pred[128]{0} and(compare.1107, compare.1103)
  broadcast.1109 = s32[128]{0} broadcast(call.1100), dimensions={}
  add.1110 = s32[128]{0} add(remainder.1102, broadcast.1109)
  ROOT select.1111 = s32[128]{0} select(and.1108, add.1110, remainder.1102)
}

_roll_dynamic.1112 {
  Arg_0.1113 = f64[128,128]{1,0} parameter(0)
  transpose.1123 = f64[128,128]{0,1} transpose(Arg_0.1113), dimensions={1,0}
  transpose.1124 = f64[128,128]{0,1} transpose(Arg_0.1113), dimensions={1,0}
  concatenate.1125 = f64[128,256]{1,0} concatenate(transpose.1123, transpose.1124), dimensions={1}
  constant.1119 = s32[] constant(128)
  broadcast.1120 = s32[128]{0} broadcast(constant.1119), dimensions={}
  Arg_1.1114 = s32[128]{0} parameter(1)
  constant.1121 = s32[] constant(128)
  call.1122 = s32[128]{0} call(Arg_1.1114, constant.1121), to_apply=remainder.1092
  subtract.1126 = s32[128]{0} subtract(broadcast.1120, call.1122)
  constant.1117 = s32[] constant(0)
  broadcast.1118 = s32[128]{0} broadcast(constant.1117), dimensions={}
  compare.1127 = pred[128]{0} compare(subtract.1126, broadcast.1118), direction=LT
  constant.1115 = s32[] constant(256)
  broadcast.1116 = s32[128]{0} broadcast(constant.1115), dimensions={}
  add.1128 = s32[128]{0} add(subtract.1126, broadcast.1116)
  select.1129 = s32[128]{0} select(compare.1127, add.1128, subtract.1126)
  reshape.1130 = s32[128,1]{1,0} reshape(select.1129)
  ROOT gather.1131 = f64[128,128]{1,0} gather(concatenate.1125, reshape.1130), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.1132 {
  Arg_0.1133 = pred[] parameter(0)
  Arg_1.1134 = s32[] parameter(1)
  Arg_2.1135 = s32[] parameter(2)
  ROOT select.1136 = s32[] select(Arg_0.1133, Arg_1.1134, Arg_2.1135)
}

remainder.1137 {
  Arg_0.1138 = s32[128]{0} parameter(0)
  Arg_1.1139 = s32[] parameter(1)
  constant.1143 = s32[] constant(0)
  compare.1144 = pred[] compare(Arg_1.1139, constant.1143), direction=EQ
  constant.1142 = s32[] constant(1)
  call.1145 = s32[] call(compare.1144, constant.1142, Arg_1.1139), to_apply=_where.1132
  broadcast.1146 = s32[128]{0} broadcast(call.1145), dimensions={}
  remainder.1147 = s32[128]{0} remainder(Arg_0.1138, broadcast.1146)
  constant.1140 = s32[] constant(0)
  broadcast.1141 = s32[128]{0} broadcast(constant.1140), dimensions={}
  compare.1149 = pred[128]{0} compare(remainder.1147, broadcast.1141), direction=LT
  compare.1150 = pred[] compare(call.1145, constant.1143), direction=LT
  broadcast.1151 = pred[128]{0} broadcast(compare.1150), dimensions={}
  compare.1152 = pred[128]{0} compare(compare.1149, broadcast.1151), direction=NE
  compare.1148 = pred[128]{0} compare(remainder.1147, broadcast.1141), direction=NE
  and.1153 = pred[128]{0} and(compare.1152, compare.1148)
  broadcast.1154 = s32[128]{0} broadcast(call.1145), dimensions={}
  add.1155 = s32[128]{0} add(remainder.1147, broadcast.1154)
  ROOT select.1156 = s32[128]{0} select(and.1153, add.1155, remainder.1147)
}

_roll_dynamic.1157 {
  Arg_0.1158 = f64[128,128]{1,0} parameter(0)
  transpose.1168 = f64[128,128]{0,1} transpose(Arg_0.1158), dimensions={1,0}
  transpose.1169 = f64[128,128]{0,1} transpose(Arg_0.1158), dimensions={1,0}
  concatenate.1170 = f64[128,256]{1,0} concatenate(transpose.1168, transpose.1169), dimensions={1}
  constant.1164 = s32[] constant(128)
  broadcast.1165 = s32[128]{0} broadcast(constant.1164), dimensions={}
  Arg_1.1159 = s32[128]{0} parameter(1)
  constant.1166 = s32[] constant(128)
  call.1167 = s32[128]{0} call(Arg_1.1159, constant.1166), to_apply=remainder.1137
  subtract.1171 = s32[128]{0} subtract(broadcast.1165, call.1167)
  constant.1162 = s32[] constant(0)
  broadcast.1163 = s32[128]{0} broadcast(constant.1162), dimensions={}
  compare.1172 = pred[128]{0} compare(subtract.1171, broadcast.1163), direction=LT
  constant.1160 = s32[] constant(256)
  broadcast.1161 = s32[128]{0} broadcast(constant.1160), dimensions={}
  add.1173 = s32[128]{0} add(subtract.1171, broadcast.1161)
  select.1174 = s32[128]{0} select(compare.1172, add.1173, subtract.1171)
  reshape.1175 = s32[128,1]{1,0} reshape(select.1174)
  ROOT gather.1176 = f64[128,128]{1,0} gather(concatenate.1170, reshape.1175), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.1177 {
  Arg_0.1178 = pred[] parameter(0)
  Arg_1.1179 = s32[] parameter(1)
  Arg_2.1180 = s32[] parameter(2)
  ROOT select.1181 = s32[] select(Arg_0.1178, Arg_1.1179, Arg_2.1180)
}

remainder.1182 {
  Arg_0.1183 = s32[128]{0} parameter(0)
  Arg_1.1184 = s32[] parameter(1)
  constant.1188 = s32[] constant(0)
  compare.1189 = pred[] compare(Arg_1.1184, constant.1188), direction=EQ
  constant.1187 = s32[] constant(1)
  call.1190 = s32[] call(compare.1189, constant.1187, Arg_1.1184), to_apply=_where.1177
  broadcast.1191 = s32[128]{0} broadcast(call.1190), dimensions={}
  remainder.1192 = s32[128]{0} remainder(Arg_0.1183, broadcast.1191)
  constant.1185 = s32[] constant(0)
  broadcast.1186 = s32[128]{0} broadcast(constant.1185), dimensions={}
  compare.1194 = pred[128]{0} compare(remainder.1192, broadcast.1186), direction=LT
  compare.1195 = pred[] compare(call.1190, constant.1188), direction=LT
  broadcast.1196 = pred[128]{0} broadcast(compare.1195), dimensions={}
  compare.1197 = pred[128]{0} compare(compare.1194, broadcast.1196), direction=NE
  compare.1193 = pred[128]{0} compare(remainder.1192, broadcast.1186), direction=NE
  and.1198 = pred[128]{0} and(compare.1197, compare.1193)
  broadcast.1199 = s32[128]{0} broadcast(call.1190), dimensions={}
  add.1200 = s32[128]{0} add(remainder.1192, broadcast.1199)
  ROOT select.1201 = s32[128]{0} select(and.1198, add.1200, remainder.1192)
}

_roll_dynamic.1202 {
  Arg_0.1203 = f64[128,128]{1,0} parameter(0)
  transpose.1213 = f64[128,128]{0,1} transpose(Arg_0.1203), dimensions={1,0}
  transpose.1214 = f64[128,128]{0,1} transpose(Arg_0.1203), dimensions={1,0}
  concatenate.1215 = f64[128,256]{1,0} concatenate(transpose.1213, transpose.1214), dimensions={1}
  constant.1209 = s32[] constant(128)
  broadcast.1210 = s32[128]{0} broadcast(constant.1209), dimensions={}
  Arg_1.1204 = s32[128]{0} parameter(1)
  constant.1211 = s32[] constant(128)
  call.1212 = s32[128]{0} call(Arg_1.1204, constant.1211), to_apply=remainder.1182
  subtract.1216 = s32[128]{0} subtract(broadcast.1210, call.1212)
  constant.1207 = s32[] constant(0)
  broadcast.1208 = s32[128]{0} broadcast(constant.1207), dimensions={}
  compare.1217 = pred[128]{0} compare(subtract.1216, broadcast.1208), direction=LT
  constant.1205 = s32[] constant(256)
  broadcast.1206 = s32[128]{0} broadcast(constant.1205), dimensions={}
  add.1218 = s32[128]{0} add(subtract.1216, broadcast.1206)
  select.1219 = s32[128]{0} select(compare.1217, add.1218, subtract.1216)
  reshape.1220 = s32[128,1]{1,0} reshape(select.1219)
  ROOT gather.1221 = f64[128,128]{1,0} gather(concatenate.1215, reshape.1220), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

advect_1d_matrix_diag.1222 {
  Arg_0.1223 = f64[128,128]{1,0} parameter(0)
  Arg_1.1224 = f64[128]{0} parameter(1)
  Arg_2.1225 = f64[] parameter(2)
  broadcast.1252 = f64[128]{0} broadcast(Arg_2.1225), dimensions={}
  multiply.1253 = f64[128]{0} multiply(Arg_1.1224, broadcast.1252)
  Arg_3.1226 = f64[] parameter(3)
  broadcast.1254 = f64[128]{0} broadcast(Arg_3.1226), dimensions={}
  divide.1255 = f64[128]{0} divide(multiply.1253, broadcast.1254)
  floor.1256 = f64[128]{0} floor(divide.1255)
  convert.1258 = s32[128]{0} convert(floor.1256)
  Arg_4.1227 = s32[6]{0} parameter(4)
  slice.1321 = s32[1]{0} slice(Arg_4.1227), slice={[0:1]}
  reshape.1322 = s32[] reshape(slice.1321)
  broadcast.1323 = s32[128]{0} broadcast(reshape.1322), dimensions={}
  add.1324 = s32[128]{0} add(convert.1258, broadcast.1323)
  call.1325 = f64[128,128]{1,0} call(Arg_0.1223, add.1324), to_apply=_roll_dynamic.977
  transpose.1326 = f64[128,128]{0,1} transpose(call.1325), dimensions={1,0}
  subtract.1257 = f64[128]{0} subtract(divide.1255, floor.1256)
  constant.1250 = f64[] constant(20)
  broadcast.1251 = f64[128]{0} broadcast(constant.1250), dimensions={}
  divide.1263 = f64[128]{0} divide(subtract.1257, broadcast.1251)
  multiply.1259 = f64[128]{0} multiply(subtract.1257, subtract.1257)
  constant.1248 = f64[] constant(24)
  broadcast.1249 = f64[128]{0} broadcast(constant.1248), dimensions={}
  divide.1264 = f64[128]{0} divide(multiply.1259, broadcast.1249)
  subtract.1265 = f64[128]{0} subtract(divide.1263, divide.1264)
  multiply.1260 = f64[128]{0} multiply(multiply.1259, subtract.1257)
  divide.1266 = f64[128]{0} divide(multiply.1260, broadcast.1249)
  subtract.1267 = f64[128]{0} subtract(subtract.1265, divide.1266)
  multiply.1261 = f64[128]{0} multiply(multiply.1260, subtract.1257)
  divide.1268 = f64[128]{0} divide(multiply.1261, broadcast.1249)
  add.1269 = f64[128]{0} add(subtract.1267, divide.1268)
  multiply.1262 = f64[128]{0} multiply(multiply.1261, subtract.1257)
  constant.1246 = f64[] constant(120)
  broadcast.1247 = f64[128]{0} broadcast(constant.1246), dimensions={}
  divide.1270 = f64[128]{0} divide(multiply.1262, broadcast.1247)
  subtract.1271 = f64[128]{0} subtract(add.1269, divide.1270)
  reshape.1327 = f64[1,128]{1,0} reshape(subtract.1271)
  broadcast.1328 = f64[1,128]{1,0} broadcast(reshape.1327), dimensions={0,1}
  reshape.1329 = f64[128]{0} reshape(broadcast.1328)
  broadcast.1330 = f64[128,128]{1,0} broadcast(reshape.1329), dimensions={1}
  multiply.1331 = f64[128,128]{0,1} multiply(transpose.1326, broadcast.1330)
  slice.1332 = s32[1]{0} slice(Arg_4.1227), slice={[1:2]}
  reshape.1333 = s32[] reshape(slice.1332)
  broadcast.1334 = s32[128]{0} broadcast(reshape.1333), dimensions={}
  add.1335 = s32[128]{0} add(convert.1258, broadcast.1334)
  call.1336 = f64[128,128]{1,0} call(Arg_0.1223, add.1335), to_apply=_roll_dynamic.1022
  transpose.1337 = f64[128,128]{0,1} transpose(call.1336), dimensions={1,0}
  constant.1244 = f64[] constant(2)
  broadcast.1245 = f64[128]{0} broadcast(constant.1244), dimensions={}
  divide.1272 = f64[128]{0} divide(subtract.1257, broadcast.1245)
  negate.1273 = f64[128]{0} negate(divide.1272)
  multiply.1274 = f64[128]{0} multiply(multiply.1259, broadcast.1245)
  constant.1242 = f64[] constant(3)
  broadcast.1243 = f64[128]{0} broadcast(constant.1242), dimensions={}
  divide.1275 = f64[128]{0} divide(multiply.1274, broadcast.1243)
  add.1276 = f64[128]{0} add(negate.1273, divide.1275)
  divide.1277 = f64[128]{0} divide(multiply.1260, broadcast.1249)
  subtract.1278 = f64[128]{0} subtract(add.1276, divide.1277)
  constant.1240 = f64[] constant(6)
  broadcast.1241 = f64[128]{0} broadcast(constant.1240), dimensions={}
  divide.1279 = f64[128]{0} divide(multiply.1261, broadcast.1241)
  subtract.1280 = f64[128]{0} subtract(subtract.1278, divide.1279)
  divide.1281 = f64[128]{0} divide(multiply.1262, broadcast.1249)
  add.1282 = f64[128]{0} add(subtract.1280, divide.1281)
  reshape.1338 = f64[1,128]{1,0} reshape(add.1282)
  broadcast.1339 = f64[1,128]{1,0} broadcast(reshape.1338), dimensions={0,1}
  reshape.1340 = f64[128]{0} reshape(broadcast.1339)
  broadcast.1341 = f64[128,128]{1,0} broadcast(reshape.1340), dimensions={1}
  multiply.1342 = f64[128,128]{0,1} multiply(transpose.1337, broadcast.1341)
  add.1343 = f64[128,128]{0,1} add(multiply.1331, multiply.1342)
  slice.1344 = s32[1]{0} slice(Arg_4.1227), slice={[2:3]}
  reshape.1345 = s32[] reshape(slice.1344)
  broadcast.1346 = s32[128]{0} broadcast(reshape.1345), dimensions={}
  add.1347 = s32[128]{0} add(convert.1258, broadcast.1346)
  call.1348 = f64[128,128]{1,0} call(Arg_0.1223, add.1347), to_apply=_roll_dynamic.1067
  transpose.1349 = f64[128,128]{0,1} transpose(call.1348), dimensions={1,0}
  constant.1238 = f64[] constant(1)
  broadcast.1239 = f64[128]{0} broadcast(constant.1238), dimensions={}
  divide.1283 = f64[128]{0} divide(subtract.1257, broadcast.1243)
  subtract.1284 = f64[128]{0} subtract(broadcast.1239, divide.1283)
  constant.1236 = f64[] constant(5)
  broadcast.1237 = f64[128]{0} broadcast(constant.1236), dimensions={}
  multiply.1285 = f64[128]{0} multiply(multiply.1259, broadcast.1237)
  constant.1234 = f64[] constant(4)
  broadcast.1235 = f64[128]{0} broadcast(constant.1234), dimensions={}
  divide.1286 = f64[128]{0} divide(multiply.1285, broadcast.1235)
  subtract.1287 = f64[128]{0} subtract(subtract.1284, divide.1286)
  multiply.1288 = f64[128]{0} multiply(multiply.1260, broadcast.1237)
  constant.1232 = f64[] constant(12)
  broadcast.1233 = f64[128]{0} broadcast(constant.1232), dimensions={}
  divide.1289 = f64[128]{0} divide(multiply.1288, broadcast.1233)
  add.1290 = f64[128]{0} add(subtract.1287, divide.1289)
  divide.1291 = f64[128]{0} divide(multiply.1261, broadcast.1235)
  add.1292 = f64[128]{0} add(add.1290, divide.1291)
  divide.1293 = f64[128]{0} divide(multiply.1262, broadcast.1233)
  subtract.1294 = f64[128]{0} subtract(add.1292, divide.1293)
  reshape.1350 = f64[1,128]{1,0} reshape(subtract.1294)
  broadcast.1351 = f64[1,128]{1,0} broadcast(reshape.1350), dimensions={0,1}
  reshape.1352 = f64[128]{0} reshape(broadcast.1351)
  broadcast.1353 = f64[128,128]{1,0} broadcast(reshape.1352), dimensions={1}
  multiply.1354 = f64[128,128]{0,1} multiply(transpose.1349, broadcast.1353)
  add.1355 = f64[128,128]{0,1} add(add.1343, multiply.1354)
  slice.1356 = s32[1]{0} slice(Arg_4.1227), slice={[3:4]}
  reshape.1357 = s32[] reshape(slice.1356)
  broadcast.1358 = s32[128]{0} broadcast(reshape.1357), dimensions={}
  add.1359 = s32[128]{0} add(convert.1258, broadcast.1358)
  call.1360 = f64[128,128]{1,0} call(Arg_0.1223, add.1359), to_apply=_roll_dynamic.1112
  transpose.1361 = f64[128,128]{0,1} transpose(call.1360), dimensions={1,0}
  multiply.1295 = f64[128]{0} multiply(multiply.1259, broadcast.1245)
  divide.1296 = f64[128]{0} divide(multiply.1295, broadcast.1243)
  add.1297 = f64[128]{0} add(subtract.1257, divide.1296)
  constant.1230 = f64[] constant(7)
  broadcast.1231 = f64[128]{0} broadcast(constant.1230), dimensions={}
  multiply.1298 = f64[128]{0} multiply(multiply.1260, broadcast.1231)
  divide.1299 = f64[128]{0} divide(multiply.1298, broadcast.1233)
  subtract.1300 = f64[128]{0} subtract(add.1297, divide.1299)
  divide.1301 = f64[128]{0} divide(multiply.1261, broadcast.1241)
  subtract.1302 = f64[128]{0} subtract(subtract.1300, divide.1301)
  divide.1303 = f64[128]{0} divide(multiply.1262, broadcast.1233)
  add.1304 = f64[128]{0} add(subtract.1302, divide.1303)
  reshape.1362 = f64[1,128]{1,0} reshape(add.1304)
  broadcast.1363 = f64[1,128]{1,0} broadcast(reshape.1362), dimensions={0,1}
  reshape.1364 = f64[128]{0} reshape(broadcast.1363)
  broadcast.1365 = f64[128,128]{1,0} broadcast(reshape.1364), dimensions={1}
  multiply.1366 = f64[128,128]{0,1} multiply(transpose.1361, broadcast.1365)
  add.1367 = f64[128,128]{0,1} add(add.1355, multiply.1366)
  slice.1368 = s32[1]{0} slice(Arg_4.1227), slice={[4:5]}
  reshape.1369 = s32[] reshape(slice.1368)
  broadcast.1370 = s32[128]{0} broadcast(reshape.1369), dimensions={}
  add.1371 = s32[128]{0} add(convert.1258, broadcast.1370)
  call.1372 = f64[128,128]{1,0} call(Arg_0.1223, add.1371), to_apply=_roll_dynamic.1157
  transpose.1373 = f64[128,128]{0,1} transpose(call.1372), dimensions={1,0}
  divide.1305 = f64[128]{0} divide(subtract.1257, broadcast.1235)
  negate.1306 = f64[128]{0} negate(divide.1305)
  divide.1307 = f64[128]{0} divide(multiply.1259, broadcast.1249)
  subtract.1308 = f64[128]{0} subtract(negate.1306, divide.1307)
  multiply.1309 = f64[128]{0} multiply(multiply.1260, broadcast.1231)
  divide.1310 = f64[128]{0} divide(multiply.1309, broadcast.1249)
  add.1311 = f64[128]{0} add(subtract.1308, divide.1310)
  divide.1312 = f64[128]{0} divide(multiply.1261, broadcast.1249)
  add.1313 = f64[128]{0} add(add.1311, divide.1312)
  divide.1314 = f64[128]{0} divide(multiply.1262, broadcast.1249)
  subtract.1315 = f64[128]{0} subtract(add.1313, divide.1314)
  reshape.1374 = f64[1,128]{1,0} reshape(subtract.1315)
  broadcast.1375 = f64[1,128]{1,0} broadcast(reshape.1374), dimensions={0,1}
  reshape.1376 = f64[128]{0} reshape(broadcast.1375)
  broadcast.1377 = f64[128,128]{1,0} broadcast(reshape.1376), dimensions={1}
  multiply.1378 = f64[128,128]{0,1} multiply(transpose.1373, broadcast.1377)
  add.1379 = f64[128,128]{0,1} add(add.1367, multiply.1378)
  slice.1380 = s32[1]{0} slice(Arg_4.1227), slice={[5:6]}
  reshape.1381 = s32[] reshape(slice.1380)
  broadcast.1382 = s32[128]{0} broadcast(reshape.1381), dimensions={}
  add.1383 = s32[128]{0} add(convert.1258, broadcast.1382)
  call.1384 = f64[128,128]{1,0} call(Arg_0.1223, add.1383), to_apply=_roll_dynamic.1202
  transpose.1385 = f64[128,128]{0,1} transpose(call.1384), dimensions={1,0}
  constant.1228 = f64[] constant(30)
  broadcast.1229 = f64[128]{0} broadcast(constant.1228), dimensions={}
  divide.1316 = f64[128]{0} divide(subtract.1257, broadcast.1229)
  divide.1317 = f64[128]{0} divide(multiply.1260, broadcast.1249)
  subtract.1318 = f64[128]{0} subtract(divide.1316, divide.1317)
  divide.1319 = f64[128]{0} divide(multiply.1262, broadcast.1247)
  add.1320 = f64[128]{0} add(subtract.1318, divide.1319)
  reshape.1386 = f64[1,128]{1,0} reshape(add.1320)
  broadcast.1387 = f64[1,128]{1,0} broadcast(reshape.1386), dimensions={0,1}
  reshape.1388 = f64[128]{0} reshape(broadcast.1387)
  broadcast.1389 = f64[128,128]{1,0} broadcast(reshape.1388), dimensions={1}
  multiply.1390 = f64[128,128]{0,1} multiply(transpose.1385, broadcast.1389)
  ROOT add.1391 = f64[128,128]{0,1} add(add.1379, multiply.1390)
}

ENTRY main.1394 {
  Arg_0.1 = f64[128,128]{1,0} parameter(0)
  constant.4 = f64[128]{0} constant({...})
  constant.7 = f64[] constant(0.025)
  constant.8 = f64[] constant(0.098174770424681035)
  constant.5 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  call.449 = f64[128,128]{0,1} call(Arg_0.1, constant.4, constant.7, constant.8, constant.5), to_apply=advect_1d_matrix_diag.279
  constant.6 = f64[65]{0} constant({...})
  constant.3 = f64[] constant(0.07874015748031496)
  call.486 = (f64[128]{0}, f64[128]{0}, f64[128]{0}) call(call.449, constant.6, constant.3), to_apply=solve_poisson.463
  get-tuple-element.487 = f64[128]{0} get-tuple-element(call.486), index=0
  constant.2 = f64[] constant(0.05)
  call.951 = f64[128,128]{1,0} call(call.449, get-tuple-element.487, constant.2, constant.3, constant.5), to_apply=advect_1d_matrix_diag_1.884
  call.1392 = f64[128,128]{0,1} call(call.951, constant.4, constant.7, constant.8, constant.5), to_apply=advect_1d_matrix_diag.1222
  get-tuple-element.488 = f64[128]{0} get-tuple-element(call.486), index=1
  get-tuple-element.489 = f64[128]{0} get-tuple-element(call.486), index=2
  ROOT tuple.1393 = (f64[128,128]{0,1}, f64[128]{0}, f64[128]{0}) tuple(call.1392, get-tuple-element.488, get-tuple-element.489)
}

