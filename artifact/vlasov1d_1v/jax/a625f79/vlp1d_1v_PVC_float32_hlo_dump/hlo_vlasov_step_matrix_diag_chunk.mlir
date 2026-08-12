HloModule jit_run_chunk, entry_computation_layout={(f32[128]{0}, f32[128]{0}, f32[65]{0}, s32[6]{0}, f32[128]{0}, /*index=5*/f32[128]{0}, f32[128,128]{1,0}, f32[128]{0}, f32[], s32[])->(f32[128]{0}, f32[128]{0}, f32[65]{0}, s32[6]{0}, f32[128]{0}, /*index=5*/f32[128]{0}, f32[128,128]{1,0}, f32[128]{0}, f32[], s32[])}

_where.15 {
  Arg_0.16 = pred[] parameter(0)
  Arg_1.17 = s32[] parameter(1)
  Arg_2.18 = s32[] parameter(2)
  ROOT select.19 = s32[] select(Arg_0.16, Arg_1.17, Arg_2.18)
}

remainder.20 {
  Arg_0.21 = s32[128]{0} parameter(0)
  Arg_1.22 = s32[] parameter(1)
  constant.26 = s32[] constant(0)
  compare.27 = pred[] compare(Arg_1.22, constant.26), direction=EQ
  constant.25 = s32[] constant(1)
  call.28 = s32[] call(compare.27, constant.25, Arg_1.22), to_apply=_where.15
  broadcast.29 = s32[128]{0} broadcast(call.28), dimensions={}
  remainder.30 = s32[128]{0} remainder(Arg_0.21, broadcast.29)
  constant.23 = s32[] constant(0)
  broadcast.24 = s32[128]{0} broadcast(constant.23), dimensions={}
  compare.32 = pred[128]{0} compare(remainder.30, broadcast.24), direction=LT
  compare.33 = pred[] compare(call.28, constant.26), direction=LT
  broadcast.34 = pred[128]{0} broadcast(compare.33), dimensions={}
  compare.35 = pred[128]{0} compare(compare.32, broadcast.34), direction=NE
  compare.31 = pred[128]{0} compare(remainder.30, broadcast.24), direction=NE
  and.36 = pred[128]{0} and(compare.35, compare.31)
  broadcast.37 = s32[128]{0} broadcast(call.28), dimensions={}
  add.38 = s32[128]{0} add(remainder.30, broadcast.37)
  ROOT select.39 = s32[128]{0} select(and.36, add.38, remainder.30)
}

_roll_dynamic.40 {
  Arg_0.41 = f32[128,128]{1,0} parameter(0)
  transpose.51 = f32[128,128]{0,1} transpose(Arg_0.41), dimensions={1,0}
  transpose.52 = f32[128,128]{0,1} transpose(Arg_0.41), dimensions={1,0}
  concatenate.53 = f32[128,256]{1,0} concatenate(transpose.51, transpose.52), dimensions={1}
  constant.47 = s32[] constant(128)
  broadcast.48 = s32[128]{0} broadcast(constant.47), dimensions={}
  Arg_1.42 = s32[128]{0} parameter(1)
  constant.49 = s32[] constant(128)
  call.50 = s32[128]{0} call(Arg_1.42, constant.49), to_apply=remainder.20
  subtract.54 = s32[128]{0} subtract(broadcast.48, call.50)
  constant.45 = s32[] constant(0)
  broadcast.46 = s32[128]{0} broadcast(constant.45), dimensions={}
  compare.55 = pred[128]{0} compare(subtract.54, broadcast.46), direction=LT
  constant.43 = s32[] constant(256)
  broadcast.44 = s32[128]{0} broadcast(constant.43), dimensions={}
  add.56 = s32[128]{0} add(subtract.54, broadcast.44)
  select.57 = s32[128]{0} select(compare.55, add.56, subtract.54)
  reshape.58 = s32[128,1]{1,0} reshape(select.57)
  ROOT gather.59 = f32[128,128]{1,0} gather(concatenate.53, reshape.58), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.60 {
  Arg_0.61 = pred[] parameter(0)
  Arg_1.62 = s32[] parameter(1)
  Arg_2.63 = s32[] parameter(2)
  ROOT select.64 = s32[] select(Arg_0.61, Arg_1.62, Arg_2.63)
}

remainder.65 {
  Arg_0.66 = s32[128]{0} parameter(0)
  Arg_1.67 = s32[] parameter(1)
  constant.71 = s32[] constant(0)
  compare.72 = pred[] compare(Arg_1.67, constant.71), direction=EQ
  constant.70 = s32[] constant(1)
  call.73 = s32[] call(compare.72, constant.70, Arg_1.67), to_apply=_where.60
  broadcast.74 = s32[128]{0} broadcast(call.73), dimensions={}
  remainder.75 = s32[128]{0} remainder(Arg_0.66, broadcast.74)
  constant.68 = s32[] constant(0)
  broadcast.69 = s32[128]{0} broadcast(constant.68), dimensions={}
  compare.77 = pred[128]{0} compare(remainder.75, broadcast.69), direction=LT
  compare.78 = pred[] compare(call.73, constant.71), direction=LT
  broadcast.79 = pred[128]{0} broadcast(compare.78), dimensions={}
  compare.80 = pred[128]{0} compare(compare.77, broadcast.79), direction=NE
  compare.76 = pred[128]{0} compare(remainder.75, broadcast.69), direction=NE
  and.81 = pred[128]{0} and(compare.80, compare.76)
  broadcast.82 = s32[128]{0} broadcast(call.73), dimensions={}
  add.83 = s32[128]{0} add(remainder.75, broadcast.82)
  ROOT select.84 = s32[128]{0} select(and.81, add.83, remainder.75)
}

_roll_dynamic.85 {
  Arg_0.86 = f32[128,128]{1,0} parameter(0)
  transpose.96 = f32[128,128]{0,1} transpose(Arg_0.86), dimensions={1,0}
  transpose.97 = f32[128,128]{0,1} transpose(Arg_0.86), dimensions={1,0}
  concatenate.98 = f32[128,256]{1,0} concatenate(transpose.96, transpose.97), dimensions={1}
  constant.92 = s32[] constant(128)
  broadcast.93 = s32[128]{0} broadcast(constant.92), dimensions={}
  Arg_1.87 = s32[128]{0} parameter(1)
  constant.94 = s32[] constant(128)
  call.95 = s32[128]{0} call(Arg_1.87, constant.94), to_apply=remainder.65
  subtract.99 = s32[128]{0} subtract(broadcast.93, call.95)
  constant.90 = s32[] constant(0)
  broadcast.91 = s32[128]{0} broadcast(constant.90), dimensions={}
  compare.100 = pred[128]{0} compare(subtract.99, broadcast.91), direction=LT
  constant.88 = s32[] constant(256)
  broadcast.89 = s32[128]{0} broadcast(constant.88), dimensions={}
  add.101 = s32[128]{0} add(subtract.99, broadcast.89)
  select.102 = s32[128]{0} select(compare.100, add.101, subtract.99)
  reshape.103 = s32[128,1]{1,0} reshape(select.102)
  ROOT gather.104 = f32[128,128]{1,0} gather(concatenate.98, reshape.103), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.105 {
  Arg_0.106 = pred[] parameter(0)
  Arg_1.107 = s32[] parameter(1)
  Arg_2.108 = s32[] parameter(2)
  ROOT select.109 = s32[] select(Arg_0.106, Arg_1.107, Arg_2.108)
}

remainder.110 {
  Arg_0.111 = s32[128]{0} parameter(0)
  Arg_1.112 = s32[] parameter(1)
  constant.116 = s32[] constant(0)
  compare.117 = pred[] compare(Arg_1.112, constant.116), direction=EQ
  constant.115 = s32[] constant(1)
  call.118 = s32[] call(compare.117, constant.115, Arg_1.112), to_apply=_where.105
  broadcast.119 = s32[128]{0} broadcast(call.118), dimensions={}
  remainder.120 = s32[128]{0} remainder(Arg_0.111, broadcast.119)
  constant.113 = s32[] constant(0)
  broadcast.114 = s32[128]{0} broadcast(constant.113), dimensions={}
  compare.122 = pred[128]{0} compare(remainder.120, broadcast.114), direction=LT
  compare.123 = pred[] compare(call.118, constant.116), direction=LT
  broadcast.124 = pred[128]{0} broadcast(compare.123), dimensions={}
  compare.125 = pred[128]{0} compare(compare.122, broadcast.124), direction=NE
  compare.121 = pred[128]{0} compare(remainder.120, broadcast.114), direction=NE
  and.126 = pred[128]{0} and(compare.125, compare.121)
  broadcast.127 = s32[128]{0} broadcast(call.118), dimensions={}
  add.128 = s32[128]{0} add(remainder.120, broadcast.127)
  ROOT select.129 = s32[128]{0} select(and.126, add.128, remainder.120)
}

_roll_dynamic.130 {
  Arg_0.131 = f32[128,128]{1,0} parameter(0)
  transpose.141 = f32[128,128]{0,1} transpose(Arg_0.131), dimensions={1,0}
  transpose.142 = f32[128,128]{0,1} transpose(Arg_0.131), dimensions={1,0}
  concatenate.143 = f32[128,256]{1,0} concatenate(transpose.141, transpose.142), dimensions={1}
  constant.137 = s32[] constant(128)
  broadcast.138 = s32[128]{0} broadcast(constant.137), dimensions={}
  Arg_1.132 = s32[128]{0} parameter(1)
  constant.139 = s32[] constant(128)
  call.140 = s32[128]{0} call(Arg_1.132, constant.139), to_apply=remainder.110
  subtract.144 = s32[128]{0} subtract(broadcast.138, call.140)
  constant.135 = s32[] constant(0)
  broadcast.136 = s32[128]{0} broadcast(constant.135), dimensions={}
  compare.145 = pred[128]{0} compare(subtract.144, broadcast.136), direction=LT
  constant.133 = s32[] constant(256)
  broadcast.134 = s32[128]{0} broadcast(constant.133), dimensions={}
  add.146 = s32[128]{0} add(subtract.144, broadcast.134)
  select.147 = s32[128]{0} select(compare.145, add.146, subtract.144)
  reshape.148 = s32[128,1]{1,0} reshape(select.147)
  ROOT gather.149 = f32[128,128]{1,0} gather(concatenate.143, reshape.148), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.150 {
  Arg_0.151 = pred[] parameter(0)
  Arg_1.152 = s32[] parameter(1)
  Arg_2.153 = s32[] parameter(2)
  ROOT select.154 = s32[] select(Arg_0.151, Arg_1.152, Arg_2.153)
}

remainder.155 {
  Arg_0.156 = s32[128]{0} parameter(0)
  Arg_1.157 = s32[] parameter(1)
  constant.161 = s32[] constant(0)
  compare.162 = pred[] compare(Arg_1.157, constant.161), direction=EQ
  constant.160 = s32[] constant(1)
  call.163 = s32[] call(compare.162, constant.160, Arg_1.157), to_apply=_where.150
  broadcast.164 = s32[128]{0} broadcast(call.163), dimensions={}
  remainder.165 = s32[128]{0} remainder(Arg_0.156, broadcast.164)
  constant.158 = s32[] constant(0)
  broadcast.159 = s32[128]{0} broadcast(constant.158), dimensions={}
  compare.167 = pred[128]{0} compare(remainder.165, broadcast.159), direction=LT
  compare.168 = pred[] compare(call.163, constant.161), direction=LT
  broadcast.169 = pred[128]{0} broadcast(compare.168), dimensions={}
  compare.170 = pred[128]{0} compare(compare.167, broadcast.169), direction=NE
  compare.166 = pred[128]{0} compare(remainder.165, broadcast.159), direction=NE
  and.171 = pred[128]{0} and(compare.170, compare.166)
  broadcast.172 = s32[128]{0} broadcast(call.163), dimensions={}
  add.173 = s32[128]{0} add(remainder.165, broadcast.172)
  ROOT select.174 = s32[128]{0} select(and.171, add.173, remainder.165)
}

_roll_dynamic.175 {
  Arg_0.176 = f32[128,128]{1,0} parameter(0)
  transpose.186 = f32[128,128]{0,1} transpose(Arg_0.176), dimensions={1,0}
  transpose.187 = f32[128,128]{0,1} transpose(Arg_0.176), dimensions={1,0}
  concatenate.188 = f32[128,256]{1,0} concatenate(transpose.186, transpose.187), dimensions={1}
  constant.182 = s32[] constant(128)
  broadcast.183 = s32[128]{0} broadcast(constant.182), dimensions={}
  Arg_1.177 = s32[128]{0} parameter(1)
  constant.184 = s32[] constant(128)
  call.185 = s32[128]{0} call(Arg_1.177, constant.184), to_apply=remainder.155
  subtract.189 = s32[128]{0} subtract(broadcast.183, call.185)
  constant.180 = s32[] constant(0)
  broadcast.181 = s32[128]{0} broadcast(constant.180), dimensions={}
  compare.190 = pred[128]{0} compare(subtract.189, broadcast.181), direction=LT
  constant.178 = s32[] constant(256)
  broadcast.179 = s32[128]{0} broadcast(constant.178), dimensions={}
  add.191 = s32[128]{0} add(subtract.189, broadcast.179)
  select.192 = s32[128]{0} select(compare.190, add.191, subtract.189)
  reshape.193 = s32[128,1]{1,0} reshape(select.192)
  ROOT gather.194 = f32[128,128]{1,0} gather(concatenate.188, reshape.193), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.195 {
  Arg_0.196 = pred[] parameter(0)
  Arg_1.197 = s32[] parameter(1)
  Arg_2.198 = s32[] parameter(2)
  ROOT select.199 = s32[] select(Arg_0.196, Arg_1.197, Arg_2.198)
}

remainder.200 {
  Arg_0.201 = s32[128]{0} parameter(0)
  Arg_1.202 = s32[] parameter(1)
  constant.206 = s32[] constant(0)
  compare.207 = pred[] compare(Arg_1.202, constant.206), direction=EQ
  constant.205 = s32[] constant(1)
  call.208 = s32[] call(compare.207, constant.205, Arg_1.202), to_apply=_where.195
  broadcast.209 = s32[128]{0} broadcast(call.208), dimensions={}
  remainder.210 = s32[128]{0} remainder(Arg_0.201, broadcast.209)
  constant.203 = s32[] constant(0)
  broadcast.204 = s32[128]{0} broadcast(constant.203), dimensions={}
  compare.212 = pred[128]{0} compare(remainder.210, broadcast.204), direction=LT
  compare.213 = pred[] compare(call.208, constant.206), direction=LT
  broadcast.214 = pred[128]{0} broadcast(compare.213), dimensions={}
  compare.215 = pred[128]{0} compare(compare.212, broadcast.214), direction=NE
  compare.211 = pred[128]{0} compare(remainder.210, broadcast.204), direction=NE
  and.216 = pred[128]{0} and(compare.215, compare.211)
  broadcast.217 = s32[128]{0} broadcast(call.208), dimensions={}
  add.218 = s32[128]{0} add(remainder.210, broadcast.217)
  ROOT select.219 = s32[128]{0} select(and.216, add.218, remainder.210)
}

_roll_dynamic.220 {
  Arg_0.221 = f32[128,128]{1,0} parameter(0)
  transpose.231 = f32[128,128]{0,1} transpose(Arg_0.221), dimensions={1,0}
  transpose.232 = f32[128,128]{0,1} transpose(Arg_0.221), dimensions={1,0}
  concatenate.233 = f32[128,256]{1,0} concatenate(transpose.231, transpose.232), dimensions={1}
  constant.227 = s32[] constant(128)
  broadcast.228 = s32[128]{0} broadcast(constant.227), dimensions={}
  Arg_1.222 = s32[128]{0} parameter(1)
  constant.229 = s32[] constant(128)
  call.230 = s32[128]{0} call(Arg_1.222, constant.229), to_apply=remainder.200
  subtract.234 = s32[128]{0} subtract(broadcast.228, call.230)
  constant.225 = s32[] constant(0)
  broadcast.226 = s32[128]{0} broadcast(constant.225), dimensions={}
  compare.235 = pred[128]{0} compare(subtract.234, broadcast.226), direction=LT
  constant.223 = s32[] constant(256)
  broadcast.224 = s32[128]{0} broadcast(constant.223), dimensions={}
  add.236 = s32[128]{0} add(subtract.234, broadcast.224)
  select.237 = s32[128]{0} select(compare.235, add.236, subtract.234)
  reshape.238 = s32[128,1]{1,0} reshape(select.237)
  ROOT gather.239 = f32[128,128]{1,0} gather(concatenate.233, reshape.238), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.240 {
  Arg_0.241 = pred[] parameter(0)
  Arg_1.242 = s32[] parameter(1)
  Arg_2.243 = s32[] parameter(2)
  ROOT select.244 = s32[] select(Arg_0.241, Arg_1.242, Arg_2.243)
}

remainder.245 {
  Arg_0.246 = s32[128]{0} parameter(0)
  Arg_1.247 = s32[] parameter(1)
  constant.251 = s32[] constant(0)
  compare.252 = pred[] compare(Arg_1.247, constant.251), direction=EQ
  constant.250 = s32[] constant(1)
  call.253 = s32[] call(compare.252, constant.250, Arg_1.247), to_apply=_where.240
  broadcast.254 = s32[128]{0} broadcast(call.253), dimensions={}
  remainder.255 = s32[128]{0} remainder(Arg_0.246, broadcast.254)
  constant.248 = s32[] constant(0)
  broadcast.249 = s32[128]{0} broadcast(constant.248), dimensions={}
  compare.257 = pred[128]{0} compare(remainder.255, broadcast.249), direction=LT
  compare.258 = pred[] compare(call.253, constant.251), direction=LT
  broadcast.259 = pred[128]{0} broadcast(compare.258), dimensions={}
  compare.260 = pred[128]{0} compare(compare.257, broadcast.259), direction=NE
  compare.256 = pred[128]{0} compare(remainder.255, broadcast.249), direction=NE
  and.261 = pred[128]{0} and(compare.260, compare.256)
  broadcast.262 = s32[128]{0} broadcast(call.253), dimensions={}
  add.263 = s32[128]{0} add(remainder.255, broadcast.262)
  ROOT select.264 = s32[128]{0} select(and.261, add.263, remainder.255)
}

_roll_dynamic.265 {
  Arg_0.266 = f32[128,128]{1,0} parameter(0)
  transpose.276 = f32[128,128]{0,1} transpose(Arg_0.266), dimensions={1,0}
  transpose.277 = f32[128,128]{0,1} transpose(Arg_0.266), dimensions={1,0}
  concatenate.278 = f32[128,256]{1,0} concatenate(transpose.276, transpose.277), dimensions={1}
  constant.272 = s32[] constant(128)
  broadcast.273 = s32[128]{0} broadcast(constant.272), dimensions={}
  Arg_1.267 = s32[128]{0} parameter(1)
  constant.274 = s32[] constant(128)
  call.275 = s32[128]{0} call(Arg_1.267, constant.274), to_apply=remainder.245
  subtract.279 = s32[128]{0} subtract(broadcast.273, call.275)
  constant.270 = s32[] constant(0)
  broadcast.271 = s32[128]{0} broadcast(constant.270), dimensions={}
  compare.280 = pred[128]{0} compare(subtract.279, broadcast.271), direction=LT
  constant.268 = s32[] constant(256)
  broadcast.269 = s32[128]{0} broadcast(constant.268), dimensions={}
  add.281 = s32[128]{0} add(subtract.279, broadcast.269)
  select.282 = s32[128]{0} select(compare.280, add.281, subtract.279)
  reshape.283 = s32[128,1]{1,0} reshape(select.282)
  ROOT gather.284 = f32[128,128]{1,0} gather(concatenate.278, reshape.283), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

advect_1d_matrix_diag.285 {
  Arg_0.286 = f32[128,128]{1,0} parameter(0)
  Arg_1.287 = f32[128]{0} parameter(1)
  Arg_2.288 = f32[] parameter(2)
  broadcast.315 = f32[128]{0} broadcast(Arg_2.288), dimensions={}
  multiply.316 = f32[128]{0} multiply(Arg_1.287, broadcast.315)
  Arg_3.289 = f32[] parameter(3)
  broadcast.317 = f32[128]{0} broadcast(Arg_3.289), dimensions={}
  divide.318 = f32[128]{0} divide(multiply.316, broadcast.317)
  floor.319 = f32[128]{0} floor(divide.318)
  convert.321 = s32[128]{0} convert(floor.319)
  Arg_4.290 = s32[6]{0} parameter(4)
  slice.384 = s32[1]{0} slice(Arg_4.290), slice={[0:1]}
  reshape.385 = s32[] reshape(slice.384)
  broadcast.386 = s32[128]{0} broadcast(reshape.385), dimensions={}
  add.387 = s32[128]{0} add(convert.321, broadcast.386)
  call.388 = f32[128,128]{1,0} call(Arg_0.286, add.387), to_apply=_roll_dynamic.40
  transpose.389 = f32[128,128]{0,1} transpose(call.388), dimensions={1,0}
  subtract.320 = f32[128]{0} subtract(divide.318, floor.319)
  constant.313 = f32[] constant(20)
  broadcast.314 = f32[128]{0} broadcast(constant.313), dimensions={}
  divide.326 = f32[128]{0} divide(subtract.320, broadcast.314)
  multiply.322 = f32[128]{0} multiply(subtract.320, subtract.320)
  constant.311 = f32[] constant(24)
  broadcast.312 = f32[128]{0} broadcast(constant.311), dimensions={}
  divide.327 = f32[128]{0} divide(multiply.322, broadcast.312)
  subtract.328 = f32[128]{0} subtract(divide.326, divide.327)
  multiply.323 = f32[128]{0} multiply(multiply.322, subtract.320)
  divide.329 = f32[128]{0} divide(multiply.323, broadcast.312)
  subtract.330 = f32[128]{0} subtract(subtract.328, divide.329)
  multiply.324 = f32[128]{0} multiply(multiply.323, subtract.320)
  divide.331 = f32[128]{0} divide(multiply.324, broadcast.312)
  add.332 = f32[128]{0} add(subtract.330, divide.331)
  multiply.325 = f32[128]{0} multiply(multiply.324, subtract.320)
  constant.309 = f32[] constant(120)
  broadcast.310 = f32[128]{0} broadcast(constant.309), dimensions={}
  divide.333 = f32[128]{0} divide(multiply.325, broadcast.310)
  subtract.334 = f32[128]{0} subtract(add.332, divide.333)
  reshape.390 = f32[1,128]{1,0} reshape(subtract.334)
  broadcast.391 = f32[1,128]{1,0} broadcast(reshape.390), dimensions={0,1}
  reshape.392 = f32[128]{0} reshape(broadcast.391)
  broadcast.393 = f32[128,128]{1,0} broadcast(reshape.392), dimensions={1}
  multiply.394 = f32[128,128]{0,1} multiply(transpose.389, broadcast.393)
  slice.395 = s32[1]{0} slice(Arg_4.290), slice={[1:2]}
  reshape.396 = s32[] reshape(slice.395)
  broadcast.397 = s32[128]{0} broadcast(reshape.396), dimensions={}
  add.398 = s32[128]{0} add(convert.321, broadcast.397)
  call.399 = f32[128,128]{1,0} call(Arg_0.286, add.398), to_apply=_roll_dynamic.85
  transpose.400 = f32[128,128]{0,1} transpose(call.399), dimensions={1,0}
  constant.307 = f32[] constant(2)
  broadcast.308 = f32[128]{0} broadcast(constant.307), dimensions={}
  divide.335 = f32[128]{0} divide(subtract.320, broadcast.308)
  negate.336 = f32[128]{0} negate(divide.335)
  multiply.337 = f32[128]{0} multiply(multiply.322, broadcast.308)
  constant.305 = f32[] constant(3)
  broadcast.306 = f32[128]{0} broadcast(constant.305), dimensions={}
  divide.338 = f32[128]{0} divide(multiply.337, broadcast.306)
  add.339 = f32[128]{0} add(negate.336, divide.338)
  divide.340 = f32[128]{0} divide(multiply.323, broadcast.312)
  subtract.341 = f32[128]{0} subtract(add.339, divide.340)
  constant.303 = f32[] constant(6)
  broadcast.304 = f32[128]{0} broadcast(constant.303), dimensions={}
  divide.342 = f32[128]{0} divide(multiply.324, broadcast.304)
  subtract.343 = f32[128]{0} subtract(subtract.341, divide.342)
  divide.344 = f32[128]{0} divide(multiply.325, broadcast.312)
  add.345 = f32[128]{0} add(subtract.343, divide.344)
  reshape.401 = f32[1,128]{1,0} reshape(add.345)
  broadcast.402 = f32[1,128]{1,0} broadcast(reshape.401), dimensions={0,1}
  reshape.403 = f32[128]{0} reshape(broadcast.402)
  broadcast.404 = f32[128,128]{1,0} broadcast(reshape.403), dimensions={1}
  multiply.405 = f32[128,128]{0,1} multiply(transpose.400, broadcast.404)
  add.406 = f32[128,128]{0,1} add(multiply.394, multiply.405)
  slice.407 = s32[1]{0} slice(Arg_4.290), slice={[2:3]}
  reshape.408 = s32[] reshape(slice.407)
  broadcast.409 = s32[128]{0} broadcast(reshape.408), dimensions={}
  add.410 = s32[128]{0} add(convert.321, broadcast.409)
  call.411 = f32[128,128]{1,0} call(Arg_0.286, add.410), to_apply=_roll_dynamic.130
  transpose.412 = f32[128,128]{0,1} transpose(call.411), dimensions={1,0}
  constant.301 = f32[] constant(1)
  broadcast.302 = f32[128]{0} broadcast(constant.301), dimensions={}
  divide.346 = f32[128]{0} divide(subtract.320, broadcast.306)
  subtract.347 = f32[128]{0} subtract(broadcast.302, divide.346)
  constant.299 = f32[] constant(5)
  broadcast.300 = f32[128]{0} broadcast(constant.299), dimensions={}
  multiply.348 = f32[128]{0} multiply(multiply.322, broadcast.300)
  constant.297 = f32[] constant(4)
  broadcast.298 = f32[128]{0} broadcast(constant.297), dimensions={}
  divide.349 = f32[128]{0} divide(multiply.348, broadcast.298)
  subtract.350 = f32[128]{0} subtract(subtract.347, divide.349)
  multiply.351 = f32[128]{0} multiply(multiply.323, broadcast.300)
  constant.295 = f32[] constant(12)
  broadcast.296 = f32[128]{0} broadcast(constant.295), dimensions={}
  divide.352 = f32[128]{0} divide(multiply.351, broadcast.296)
  add.353 = f32[128]{0} add(subtract.350, divide.352)
  divide.354 = f32[128]{0} divide(multiply.324, broadcast.298)
  add.355 = f32[128]{0} add(add.353, divide.354)
  divide.356 = f32[128]{0} divide(multiply.325, broadcast.296)
  subtract.357 = f32[128]{0} subtract(add.355, divide.356)
  reshape.413 = f32[1,128]{1,0} reshape(subtract.357)
  broadcast.414 = f32[1,128]{1,0} broadcast(reshape.413), dimensions={0,1}
  reshape.415 = f32[128]{0} reshape(broadcast.414)
  broadcast.416 = f32[128,128]{1,0} broadcast(reshape.415), dimensions={1}
  multiply.417 = f32[128,128]{0,1} multiply(transpose.412, broadcast.416)
  add.418 = f32[128,128]{0,1} add(add.406, multiply.417)
  slice.419 = s32[1]{0} slice(Arg_4.290), slice={[3:4]}
  reshape.420 = s32[] reshape(slice.419)
  broadcast.421 = s32[128]{0} broadcast(reshape.420), dimensions={}
  add.422 = s32[128]{0} add(convert.321, broadcast.421)
  call.423 = f32[128,128]{1,0} call(Arg_0.286, add.422), to_apply=_roll_dynamic.175
  transpose.424 = f32[128,128]{0,1} transpose(call.423), dimensions={1,0}
  multiply.358 = f32[128]{0} multiply(multiply.322, broadcast.308)
  divide.359 = f32[128]{0} divide(multiply.358, broadcast.306)
  add.360 = f32[128]{0} add(subtract.320, divide.359)
  constant.293 = f32[] constant(7)
  broadcast.294 = f32[128]{0} broadcast(constant.293), dimensions={}
  multiply.361 = f32[128]{0} multiply(multiply.323, broadcast.294)
  divide.362 = f32[128]{0} divide(multiply.361, broadcast.296)
  subtract.363 = f32[128]{0} subtract(add.360, divide.362)
  divide.364 = f32[128]{0} divide(multiply.324, broadcast.304)
  subtract.365 = f32[128]{0} subtract(subtract.363, divide.364)
  divide.366 = f32[128]{0} divide(multiply.325, broadcast.296)
  add.367 = f32[128]{0} add(subtract.365, divide.366)
  reshape.425 = f32[1,128]{1,0} reshape(add.367)
  broadcast.426 = f32[1,128]{1,0} broadcast(reshape.425), dimensions={0,1}
  reshape.427 = f32[128]{0} reshape(broadcast.426)
  broadcast.428 = f32[128,128]{1,0} broadcast(reshape.427), dimensions={1}
  multiply.429 = f32[128,128]{0,1} multiply(transpose.424, broadcast.428)
  add.430 = f32[128,128]{0,1} add(add.418, multiply.429)
  slice.431 = s32[1]{0} slice(Arg_4.290), slice={[4:5]}
  reshape.432 = s32[] reshape(slice.431)
  broadcast.433 = s32[128]{0} broadcast(reshape.432), dimensions={}
  add.434 = s32[128]{0} add(convert.321, broadcast.433)
  call.435 = f32[128,128]{1,0} call(Arg_0.286, add.434), to_apply=_roll_dynamic.220
  transpose.436 = f32[128,128]{0,1} transpose(call.435), dimensions={1,0}
  divide.368 = f32[128]{0} divide(subtract.320, broadcast.298)
  negate.369 = f32[128]{0} negate(divide.368)
  divide.370 = f32[128]{0} divide(multiply.322, broadcast.312)
  subtract.371 = f32[128]{0} subtract(negate.369, divide.370)
  multiply.372 = f32[128]{0} multiply(multiply.323, broadcast.294)
  divide.373 = f32[128]{0} divide(multiply.372, broadcast.312)
  add.374 = f32[128]{0} add(subtract.371, divide.373)
  divide.375 = f32[128]{0} divide(multiply.324, broadcast.312)
  add.376 = f32[128]{0} add(add.374, divide.375)
  divide.377 = f32[128]{0} divide(multiply.325, broadcast.312)
  subtract.378 = f32[128]{0} subtract(add.376, divide.377)
  reshape.437 = f32[1,128]{1,0} reshape(subtract.378)
  broadcast.438 = f32[1,128]{1,0} broadcast(reshape.437), dimensions={0,1}
  reshape.439 = f32[128]{0} reshape(broadcast.438)
  broadcast.440 = f32[128,128]{1,0} broadcast(reshape.439), dimensions={1}
  multiply.441 = f32[128,128]{0,1} multiply(transpose.436, broadcast.440)
  add.442 = f32[128,128]{0,1} add(add.430, multiply.441)
  slice.443 = s32[1]{0} slice(Arg_4.290), slice={[5:6]}
  reshape.444 = s32[] reshape(slice.443)
  broadcast.445 = s32[128]{0} broadcast(reshape.444), dimensions={}
  add.446 = s32[128]{0} add(convert.321, broadcast.445)
  call.447 = f32[128,128]{1,0} call(Arg_0.286, add.446), to_apply=_roll_dynamic.265
  transpose.448 = f32[128,128]{0,1} transpose(call.447), dimensions={1,0}
  constant.291 = f32[] constant(30)
  broadcast.292 = f32[128]{0} broadcast(constant.291), dimensions={}
  divide.379 = f32[128]{0} divide(subtract.320, broadcast.292)
  divide.380 = f32[128]{0} divide(multiply.323, broadcast.312)
  subtract.381 = f32[128]{0} subtract(divide.379, divide.380)
  divide.382 = f32[128]{0} divide(multiply.325, broadcast.310)
  add.383 = f32[128]{0} add(subtract.381, divide.382)
  reshape.449 = f32[1,128]{1,0} reshape(add.383)
  broadcast.450 = f32[1,128]{1,0} broadcast(reshape.449), dimensions={0,1}
  reshape.451 = f32[128]{0} reshape(broadcast.450)
  broadcast.452 = f32[128,128]{1,0} broadcast(reshape.451), dimensions={1}
  multiply.453 = f32[128,128]{0,1} multiply(transpose.448, broadcast.452)
  ROOT add.454 = f32[128,128]{0,1} add(add.442, multiply.453)
}

region_1.455 {
  Arg_0.456 = f32[] parameter(0)
  Arg_1.457 = f32[] parameter(1)
  ROOT add.458 = f32[] add(Arg_0.456, Arg_1.457)
}

fft.459 {
  Arg_0.460 = f32[128]{0} parameter(0)
  ROOT fft.461 = c64[65]{0} fft(Arg_0.460), fft_type=RFFT, fft_length={128}
}

fft_0.462 {
  Arg_0.463 = c64[65]{0} parameter(0)
  ROOT fft.464 = f32[128]{0} fft(Arg_0.463), fft_type=IRFFT, fft_length={128}
}

fft_0.465 {
  Arg_0.466 = c64[65]{0} parameter(0)
  ROOT fft.467 = f32[128]{0} fft(Arg_0.466), fft_type=IRFFT, fft_length={128}
}

solve_poisson.468 {
  Arg_0.469 = f32[128,128]{1,0} parameter(0)
  constant.476 = f32[] constant(0)
  reduce.477 = f32[128]{0} reduce(Arg_0.469, constant.476), dimensions={1}, to_apply=region_1.455
  Arg_2.471 = f32[] parameter(2)
  broadcast.478 = f32[128]{0} broadcast(Arg_2.471), dimensions={}
  multiply.479 = f32[128]{0} multiply(reduce.477, broadcast.478)
  constant.474 = f32[] constant(1)
  broadcast.475 = f32[128]{0} broadcast(constant.474), dimensions={}
  subtract.480 = f32[128]{0} subtract(multiply.479, broadcast.475)
  call.481 = c64[65]{0} call(subtract.480), to_apply=fft.459
  constant.472 = c64[] constant((-0, -1))
  broadcast.473 = c64[65]{0} broadcast(constant.472), dimensions={}
  multiply.482 = c64[65]{0} multiply(call.481, broadcast.473)
  Arg_1.470 = f32[65]{0} parameter(1)
  convert.483 = c64[65]{0} convert(Arg_1.470)
  multiply.484 = c64[65]{0} multiply(multiply.482, convert.483)
  call.485 = f32[128]{0} call(multiply.484), to_apply=fft_0.462
  multiply.486 = f32[65]{0} multiply(Arg_1.470, Arg_1.470)
  convert.487 = c64[65]{0} convert(multiply.486)
  multiply.488 = c64[65]{0} multiply(call.481, convert.487)
  call.489 = f32[128]{0} call(multiply.488), to_apply=fft_0.465
  ROOT tuple.490 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) tuple(call.485, subtract.480, call.489)
}

_where_2.491 {
  Arg_0.492 = pred[6,128,128]{2,1,0} parameter(0)
  Arg_1.493 = f32[6,128,1]{2,1,0} parameter(1)
  broadcast.495 = f32[6,128,1]{2,1,0} broadcast(Arg_1.493), dimensions={0,1,2}
  reshape.496 = f32[6,128]{1,0} reshape(broadcast.495)
  broadcast.497 = f32[6,128,128]{2,1,0} broadcast(reshape.496), dimensions={0,1}
  Arg_2.494 = f32[] parameter(2)
  broadcast.498 = f32[6,128,128]{2,1,0} broadcast(Arg_2.494), dimensions={}
  ROOT select.499 = f32[6,128,128]{2,1,0} select(Arg_0.492, broadcast.497, broadcast.498)
}

build_v_diag_weights.500 {
  iota.602 = s32[128]{0} iota(), iota_dimension=0
  reshape.612 = s32[1,1,128]{2,1,0} reshape(iota.602)
  broadcast.614 = s32[1,1,128]{2,1,0} broadcast(reshape.612), dimensions={0,1,2}
  reshape.615 = s32[128]{0} reshape(broadcast.614)
  broadcast.616 = s32[6,128,128]{2,1,0} broadcast(reshape.615), dimensions={2}
  Arg_0.501 = s32[6]{0} parameter(0)
  reshape.603 = s32[6,1]{1,0} reshape(Arg_0.501)
  broadcast.605 = s32[6,1]{1,0} broadcast(reshape.603), dimensions={0,1}
  reshape.606 = s32[6]{0} reshape(broadcast.605)
  broadcast.607 = s32[6,128]{1,0} broadcast(reshape.606), dimensions={0}
  Arg_1.502 = s32[128]{0} parameter(1)
  reshape.604 = s32[1,128]{1,0} reshape(Arg_1.502)
  broadcast.608 = s32[1,128]{1,0} broadcast(reshape.604), dimensions={0,1}
  reshape.609 = s32[128]{0} reshape(broadcast.608)
  broadcast.610 = s32[6,128]{1,0} broadcast(reshape.609), dimensions={1}
  add.611 = s32[6,128]{1,0} add(broadcast.607, broadcast.610)
  reshape.613 = s32[6,128,1]{2,1,0} reshape(add.611)
  broadcast.617 = s32[6,128,1]{2,1,0} broadcast(reshape.613), dimensions={0,1,2}
  reshape.618 = s32[6,128]{1,0} reshape(broadcast.617)
  broadcast.619 = s32[6,128,128]{2,1,0} broadcast(reshape.618), dimensions={0,1}
  subtract.620 = s32[6,128,128]{2,1,0} subtract(broadcast.616, broadcast.619)
  constant.506 = s32[] constant(0)
  broadcast.507 = s32[6,128,128]{2,1,0} broadcast(constant.506), dimensions={}
  compare.621 = pred[6,128,128]{2,1,0} compare(subtract.620, broadcast.507), direction=GE
  constant.504 = s32[] constant(128)
  broadcast.505 = s32[6,128,128]{2,1,0} broadcast(constant.504), dimensions={}
  compare.622 = pred[6,128,128]{2,1,0} compare(subtract.620, broadcast.505), direction=LT
  and.623 = pred[6,128,128]{2,1,0} and(compare.621, compare.622)
  Arg_2.503 = f32[128]{0} parameter(2)
  constant.530 = f32[] constant(20)
  broadcast.531 = f32[128]{0} broadcast(constant.530), dimensions={}
  divide.537 = f32[128]{0} divide(Arg_2.503, broadcast.531)
  multiply.533 = f32[128]{0} multiply(Arg_2.503, Arg_2.503)
  constant.528 = f32[] constant(24)
  broadcast.529 = f32[128]{0} broadcast(constant.528), dimensions={}
  divide.538 = f32[128]{0} divide(multiply.533, broadcast.529)
  subtract.539 = f32[128]{0} subtract(divide.537, divide.538)
  multiply.534 = f32[128]{0} multiply(multiply.533, Arg_2.503)
  divide.540 = f32[128]{0} divide(multiply.534, broadcast.529)
  subtract.541 = f32[128]{0} subtract(subtract.539, divide.540)
  multiply.535 = f32[128]{0} multiply(multiply.534, Arg_2.503)
  divide.542 = f32[128]{0} divide(multiply.535, broadcast.529)
  add.543 = f32[128]{0} add(subtract.541, divide.542)
  multiply.536 = f32[128]{0} multiply(multiply.535, Arg_2.503)
  constant.526 = f32[] constant(120)
  broadcast.527 = f32[128]{0} broadcast(constant.526), dimensions={}
  divide.544 = f32[128]{0} divide(multiply.536, broadcast.527)
  subtract.545 = f32[128]{0} subtract(add.543, divide.544)
  reshape.595 = f32[1,128]{1,0} reshape(subtract.545)
  constant.524 = f32[] constant(2)
  broadcast.525 = f32[128]{0} broadcast(constant.524), dimensions={}
  divide.546 = f32[128]{0} divide(Arg_2.503, broadcast.525)
  negate.547 = f32[128]{0} negate(divide.546)
  multiply.548 = f32[128]{0} multiply(multiply.533, broadcast.525)
  constant.522 = f32[] constant(3)
  broadcast.523 = f32[128]{0} broadcast(constant.522), dimensions={}
  divide.549 = f32[128]{0} divide(multiply.548, broadcast.523)
  add.550 = f32[128]{0} add(negate.547, divide.549)
  divide.551 = f32[128]{0} divide(multiply.534, broadcast.529)
  subtract.552 = f32[128]{0} subtract(add.550, divide.551)
  constant.520 = f32[] constant(6)
  broadcast.521 = f32[128]{0} broadcast(constant.520), dimensions={}
  divide.553 = f32[128]{0} divide(multiply.535, broadcast.521)
  subtract.554 = f32[128]{0} subtract(subtract.552, divide.553)
  divide.555 = f32[128]{0} divide(multiply.536, broadcast.529)
  add.556 = f32[128]{0} add(subtract.554, divide.555)
  reshape.596 = f32[1,128]{1,0} reshape(add.556)
  constant.518 = f32[] constant(1)
  broadcast.519 = f32[128]{0} broadcast(constant.518), dimensions={}
  divide.557 = f32[128]{0} divide(Arg_2.503, broadcast.523)
  subtract.558 = f32[128]{0} subtract(broadcast.519, divide.557)
  constant.516 = f32[] constant(5)
  broadcast.517 = f32[128]{0} broadcast(constant.516), dimensions={}
  multiply.559 = f32[128]{0} multiply(multiply.533, broadcast.517)
  constant.514 = f32[] constant(4)
  broadcast.515 = f32[128]{0} broadcast(constant.514), dimensions={}
  divide.560 = f32[128]{0} divide(multiply.559, broadcast.515)
  subtract.561 = f32[128]{0} subtract(subtract.558, divide.560)
  multiply.562 = f32[128]{0} multiply(multiply.534, broadcast.517)
  constant.512 = f32[] constant(12)
  broadcast.513 = f32[128]{0} broadcast(constant.512), dimensions={}
  divide.563 = f32[128]{0} divide(multiply.562, broadcast.513)
  add.564 = f32[128]{0} add(subtract.561, divide.563)
  divide.565 = f32[128]{0} divide(multiply.535, broadcast.515)
  add.566 = f32[128]{0} add(add.564, divide.565)
  divide.567 = f32[128]{0} divide(multiply.536, broadcast.513)
  subtract.568 = f32[128]{0} subtract(add.566, divide.567)
  reshape.597 = f32[1,128]{1,0} reshape(subtract.568)
  multiply.569 = f32[128]{0} multiply(multiply.533, broadcast.525)
  divide.570 = f32[128]{0} divide(multiply.569, broadcast.523)
  add.571 = f32[128]{0} add(Arg_2.503, divide.570)
  constant.510 = f32[] constant(7)
  broadcast.511 = f32[128]{0} broadcast(constant.510), dimensions={}
  multiply.572 = f32[128]{0} multiply(multiply.534, broadcast.511)
  divide.573 = f32[128]{0} divide(multiply.572, broadcast.513)
  subtract.574 = f32[128]{0} subtract(add.571, divide.573)
  divide.575 = f32[128]{0} divide(multiply.535, broadcast.521)
  subtract.576 = f32[128]{0} subtract(subtract.574, divide.575)
  divide.577 = f32[128]{0} divide(multiply.536, broadcast.513)
  add.578 = f32[128]{0} add(subtract.576, divide.577)
  reshape.598 = f32[1,128]{1,0} reshape(add.578)
  divide.579 = f32[128]{0} divide(Arg_2.503, broadcast.515)
  negate.580 = f32[128]{0} negate(divide.579)
  divide.581 = f32[128]{0} divide(multiply.533, broadcast.529)
  subtract.582 = f32[128]{0} subtract(negate.580, divide.581)
  multiply.583 = f32[128]{0} multiply(multiply.534, broadcast.511)
  divide.584 = f32[128]{0} divide(multiply.583, broadcast.529)
  add.585 = f32[128]{0} add(subtract.582, divide.584)
  divide.586 = f32[128]{0} divide(multiply.535, broadcast.529)
  add.587 = f32[128]{0} add(add.585, divide.586)
  divide.588 = f32[128]{0} divide(multiply.536, broadcast.529)
  subtract.589 = f32[128]{0} subtract(add.587, divide.588)
  reshape.599 = f32[1,128]{1,0} reshape(subtract.589)
  constant.508 = f32[] constant(30)
  broadcast.509 = f32[128]{0} broadcast(constant.508), dimensions={}
  divide.590 = f32[128]{0} divide(Arg_2.503, broadcast.509)
  divide.591 = f32[128]{0} divide(multiply.534, broadcast.529)
  subtract.592 = f32[128]{0} subtract(divide.590, divide.591)
  divide.593 = f32[128]{0} divide(multiply.536, broadcast.527)
  add.594 = f32[128]{0} add(subtract.592, divide.593)
  reshape.600 = f32[1,128]{1,0} reshape(add.594)
  concatenate.601 = f32[6,128]{1,0} concatenate(reshape.595, reshape.596, reshape.597, reshape.598, reshape.599, reshape.600), dimensions={0}
  reshape.624 = f32[6,128,1]{2,1,0} reshape(concatenate.601)
  constant.532 = f32[] constant(0)
  ROOT call.625 = f32[6,128,128]{2,1,0} call(and.623, reshape.624, constant.532), to_apply=_where_2.491
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
  Arg_0.652 = f32[128,128]{1,0} parameter(0)
  concatenate.662 = f32[128,256]{1,0} concatenate(Arg_0.652, Arg_0.652), dimensions={1}
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
  ROOT gather.668 = f32[128,128]{1,0} gather(concatenate.662, reshape.667), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.695 = f32[128,128]{1,0} parameter(0)
  concatenate.705 = f32[128,256]{1,0} concatenate(Arg_0.695, Arg_0.695), dimensions={1}
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
  ROOT gather.711 = f32[128,128]{1,0} gather(concatenate.705, reshape.710), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.738 = f32[128,128]{1,0} parameter(0)
  concatenate.748 = f32[128,256]{1,0} concatenate(Arg_0.738, Arg_0.738), dimensions={1}
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
  ROOT gather.754 = f32[128,128]{1,0} gather(concatenate.748, reshape.753), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.781 = f32[128,128]{1,0} parameter(0)
  concatenate.791 = f32[128,256]{1,0} concatenate(Arg_0.781, Arg_0.781), dimensions={1}
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
  ROOT gather.797 = f32[128,128]{1,0} gather(concatenate.791, reshape.796), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.824 = f32[128,128]{1,0} parameter(0)
  concatenate.834 = f32[128,256]{1,0} concatenate(Arg_0.824, Arg_0.824), dimensions={1}
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
  ROOT gather.840 = f32[128,128]{1,0} gather(concatenate.834, reshape.839), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.867 = f32[128,128]{1,0} parameter(0)
  concatenate.877 = f32[128,256]{1,0} concatenate(Arg_0.867, Arg_0.867), dimensions={1}
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
  ROOT gather.883 = f32[128,128]{1,0} gather(concatenate.877, reshape.882), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

advect_1d_matrix_diag_1.884 {
  Arg_4.889 = s32[6]{0} parameter(4)
  Arg_1.886 = f32[128]{0} parameter(1)
  Arg_2.887 = f32[] parameter(2)
  broadcast.890 = f32[128]{0} broadcast(Arg_2.887), dimensions={}
  multiply.891 = f32[128]{0} multiply(Arg_1.886, broadcast.890)
  Arg_3.888 = f32[] parameter(3)
  broadcast.892 = f32[128]{0} broadcast(Arg_3.888), dimensions={}
  divide.893 = f32[128]{0} divide(multiply.891, broadcast.892)
  floor.894 = f32[128]{0} floor(divide.893)
  convert.896 = s32[128]{0} convert(floor.894)
  subtract.895 = f32[128]{0} subtract(divide.893, floor.894)
  call.897 = f32[6,128,128]{2,1,0} call(Arg_4.889, convert.896, subtract.895), to_apply=build_v_diag_weights.500
  slice.903 = f32[1,128,128]{2,1,0} slice(call.897), slice={[0:1], [0:128], [0:128]}
  reshape.904 = f32[128,128]{1,0} reshape(slice.903)
  Arg_0.885 = f32[128,128]{1,0} parameter(0)
  slice.898 = s32[1]{0} slice(Arg_4.889), slice={[0:1]}
  reshape.899 = s32[] reshape(slice.898)
  broadcast.900 = s32[128]{0} broadcast(reshape.899), dimensions={}
  add.901 = s32[128]{0} add(convert.896, broadcast.900)
  call.902 = f32[128,128]{1,0} call(Arg_0.885, add.901), to_apply=_roll_dynamic_3.651
  multiply.905 = f32[128,128]{1,0} multiply(reshape.904, call.902)
  slice.911 = f32[1,128,128]{2,1,0} slice(call.897), slice={[1:2], [0:128], [0:128]}
  reshape.912 = f32[128,128]{1,0} reshape(slice.911)
  slice.906 = s32[1]{0} slice(Arg_4.889), slice={[1:2]}
  reshape.907 = s32[] reshape(slice.906)
  broadcast.908 = s32[128]{0} broadcast(reshape.907), dimensions={}
  add.909 = s32[128]{0} add(convert.896, broadcast.908)
  call.910 = f32[128,128]{1,0} call(Arg_0.885, add.909), to_apply=_roll_dynamic_3.694
  multiply.913 = f32[128,128]{1,0} multiply(reshape.912, call.910)
  add.914 = f32[128,128]{1,0} add(multiply.905, multiply.913)
  slice.920 = f32[1,128,128]{2,1,0} slice(call.897), slice={[2:3], [0:128], [0:128]}
  reshape.921 = f32[128,128]{1,0} reshape(slice.920)
  slice.915 = s32[1]{0} slice(Arg_4.889), slice={[2:3]}
  reshape.916 = s32[] reshape(slice.915)
  broadcast.917 = s32[128]{0} broadcast(reshape.916), dimensions={}
  add.918 = s32[128]{0} add(convert.896, broadcast.917)
  call.919 = f32[128,128]{1,0} call(Arg_0.885, add.918), to_apply=_roll_dynamic_3.737
  multiply.922 = f32[128,128]{1,0} multiply(reshape.921, call.919)
  add.923 = f32[128,128]{1,0} add(add.914, multiply.922)
  slice.929 = f32[1,128,128]{2,1,0} slice(call.897), slice={[3:4], [0:128], [0:128]}
  reshape.930 = f32[128,128]{1,0} reshape(slice.929)
  slice.924 = s32[1]{0} slice(Arg_4.889), slice={[3:4]}
  reshape.925 = s32[] reshape(slice.924)
  broadcast.926 = s32[128]{0} broadcast(reshape.925), dimensions={}
  add.927 = s32[128]{0} add(convert.896, broadcast.926)
  call.928 = f32[128,128]{1,0} call(Arg_0.885, add.927), to_apply=_roll_dynamic_3.780
  multiply.931 = f32[128,128]{1,0} multiply(reshape.930, call.928)
  add.932 = f32[128,128]{1,0} add(add.923, multiply.931)
  slice.938 = f32[1,128,128]{2,1,0} slice(call.897), slice={[4:5], [0:128], [0:128]}
  reshape.939 = f32[128,128]{1,0} reshape(slice.938)
  slice.933 = s32[1]{0} slice(Arg_4.889), slice={[4:5]}
  reshape.934 = s32[] reshape(slice.933)
  broadcast.935 = s32[128]{0} broadcast(reshape.934), dimensions={}
  add.936 = s32[128]{0} add(convert.896, broadcast.935)
  call.937 = f32[128,128]{1,0} call(Arg_0.885, add.936), to_apply=_roll_dynamic_3.823
  multiply.940 = f32[128,128]{1,0} multiply(reshape.939, call.937)
  add.941 = f32[128,128]{1,0} add(add.932, multiply.940)
  slice.947 = f32[1,128,128]{2,1,0} slice(call.897), slice={[5:6], [0:128], [0:128]}
  reshape.948 = f32[128,128]{1,0} reshape(slice.947)
  slice.942 = s32[1]{0} slice(Arg_4.889), slice={[5:6]}
  reshape.943 = s32[] reshape(slice.942)
  broadcast.944 = s32[128]{0} broadcast(reshape.943), dimensions={}
  add.945 = s32[128]{0} add(convert.896, broadcast.944)
  call.946 = f32[128,128]{1,0} call(Arg_0.885, add.945), to_apply=_roll_dynamic_3.866
  multiply.949 = f32[128,128]{1,0} multiply(reshape.948, call.946)
  ROOT add.950 = f32[128,128]{1,0} add(add.941, multiply.949)
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

None.1391 {
  Arg_4.1396 = f32[128]{0} parameter(4)
  Arg_5.1397 = f32[128]{0} parameter(5)
  Arg_3.1395 = f32[128,128]{1,0} parameter(3)
  Arg_0.1392 = f32[128]{0} parameter(0)
  constant.1400 = f32[] constant(0.025)
  constant.1401 = f32[] constant(0.0981747732)
  Arg_1.1393 = s32[6]{0} parameter(1)
  call.1402 = f32[128,128]{0,1} call(Arg_3.1395, Arg_0.1392, constant.1400, constant.1401, Arg_1.1393), to_apply=advect_1d_matrix_diag.285
  Arg_2.1394 = f32[65]{0} parameter(2)
  constant.1399 = f32[] constant(0.0787401572)
  call.1403 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) call(call.1402, Arg_2.1394, constant.1399), to_apply=solve_poisson.468
  get-tuple-element.1404 = f32[128]{0} get-tuple-element(call.1403), index=0
  constant.1398 = f32[] constant(0.05)
  call.1407 = f32[128,128]{1,0} call(call.1402, get-tuple-element.1404, constant.1398, constant.1399, Arg_1.1393), to_apply=advect_1d_matrix_diag_1.884
  call.1408 = f32[128,128]{0,1} call(call.1407, Arg_0.1392, constant.1400, constant.1401, Arg_1.1393), to_apply=advect_1d_matrix_diag.1221
  get-tuple-element.1405 = f32[128]{0} get-tuple-element(call.1403), index=1
  get-tuple-element.1406 = f32[128]{0} get-tuple-element(call.1403), index=2
  ROOT tuple.1409 = (f32[128,128]{0,1}, f32[128]{0}, f32[128]{0}) tuple(call.1408, get-tuple-element.1405, get-tuple-element.1406)
}

region_0.1410 {
  arg_tuple.1411 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) parameter(0)
  get-tuple-element.1412 = s32[] get-tuple-element(arg_tuple.1411), index=0
  constant.1416 = s32[] constant(1)
  add.1424 = s32[] add(get-tuple-element.1412, constant.1416)
  constant.1419 = f32[128]{0} constant({...})
  constant.1418 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  constant.1417 = f32[65]{0} constant({...})
  get-tuple-element.1413 = f32[128,128]{1,0} get-tuple-element(arg_tuple.1411), index=1
  get-tuple-element.1414 = f32[128]{0} get-tuple-element(arg_tuple.1411), index=2
  get-tuple-element.1415 = f32[128]{0} get-tuple-element(arg_tuple.1411), index=3
  call.1420 = (f32[128,128]{0,1}, f32[128]{0}, f32[128]{0}) call(constant.1419, constant.1418, constant.1417, get-tuple-element.1413, get-tuple-element.1414, get-tuple-element.1415), to_apply=None.1391
  get-tuple-element.1421 = f32[128,128]{0,1} get-tuple-element(call.1420), index=0
  get-tuple-element.1422 = f32[128]{0} get-tuple-element(call.1420), index=1
  get-tuple-element.1423 = f32[128]{0} get-tuple-element(call.1420), index=2
  ROOT tuple.1425 = (s32[], f32[128,128]{0,1}, f32[128]{0}, f32[128]{0}) tuple(add.1424, get-tuple-element.1421, get-tuple-element.1422, get-tuple-element.1423)
}

region_2.1426 {
  arg_tuple.1427 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) parameter(0)
  get-tuple-element.1429 = f32[128,128]{1,0} get-tuple-element(arg_tuple.1427), index=1
  get-tuple-element.1430 = f32[128]{0} get-tuple-element(arg_tuple.1427), index=2
  get-tuple-element.1431 = f32[128]{0} get-tuple-element(arg_tuple.1427), index=3
  get-tuple-element.1428 = s32[] get-tuple-element(arg_tuple.1427), index=0
  constant.1432 = s32[] constant(1000)
  ROOT compare.1433 = pred[] compare(get-tuple-element.1428, constant.1432), direction=LT
}

ENTRY main.1442 {
  constant.13 = s32[] constant(0)
  Arg_6.7 = f32[128,128]{1,0} parameter(6)
  Arg_4.5 = f32[128]{0} parameter(4)
  Arg_5.6 = f32[128]{0} parameter(5)
  tuple.14 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) tuple(constant.13, Arg_6.7, Arg_4.5, Arg_5.6)
  while.1434 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) while(tuple.14), condition=region_2.1426, body=region_0.1410
  get-tuple-element.1435 = s32[] get-tuple-element(while.1434), index=0
  Arg_0.1 = f32[128]{0} parameter(0)
  Arg_1.2 = f32[128]{0} parameter(1)
  Arg_2.3 = f32[65]{0} parameter(2)
  Arg_3.4 = s32[6]{0} parameter(3)
  get-tuple-element.1437 = f32[128]{0} get-tuple-element(while.1434), index=2
  get-tuple-element.1438 = f32[128]{0} get-tuple-element(while.1434), index=3
  get-tuple-element.1436 = f32[128,128]{1,0} get-tuple-element(while.1434), index=1
  Arg_7.8 = f32[128]{0} parameter(7)
  Arg_8.9 = f32[] parameter(8)
  constant.11 = f32[] constant(50)
  add.1439 = f32[] add(Arg_8.9, constant.11)
  Arg_9.10 = s32[] parameter(9)
  constant.12 = s32[] constant(1000)
  add.1440 = s32[] add(Arg_9.10, constant.12)
  ROOT tuple.1441 = (f32[128]{0}, f32[128]{0}, f32[65]{0}, s32[6]{0}, f32[128]{0}, /*index=5*/f32[128]{0}, f32[128,128]{1,0}, f32[128]{0}, f32[], s32[]) tuple(Arg_0.1, Arg_1.2, Arg_2.3, Arg_3.4, get-tuple-element.1437, get-tuple-element.1438, get-tuple-element.1436, Arg_7.8, add.1439, add.1440)
}

