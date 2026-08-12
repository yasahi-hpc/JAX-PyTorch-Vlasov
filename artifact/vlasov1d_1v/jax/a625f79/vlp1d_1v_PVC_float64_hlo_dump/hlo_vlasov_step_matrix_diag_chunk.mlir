HloModule jit_run_chunk, entry_computation_layout={(f64[128]{0}, f64[128]{0}, f64[65]{0}, s32[6]{0}, f64[128]{0}, /*index=5*/f64[128]{0}, f64[128,128]{1,0}, f64[128]{0}, f64[], s64[])->(f64[128]{0}, f64[128]{0}, f64[65]{0}, s32[6]{0}, f64[128]{0}, /*index=5*/f64[128]{0}, f64[128,128]{1,0}, f64[128]{0}, f64[], s64[])}

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
  Arg_0.41 = f64[128,128]{1,0} parameter(0)
  transpose.51 = f64[128,128]{0,1} transpose(Arg_0.41), dimensions={1,0}
  transpose.52 = f64[128,128]{0,1} transpose(Arg_0.41), dimensions={1,0}
  concatenate.53 = f64[128,256]{1,0} concatenate(transpose.51, transpose.52), dimensions={1}
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
  ROOT gather.59 = f64[128,128]{1,0} gather(concatenate.53, reshape.58), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.86 = f64[128,128]{1,0} parameter(0)
  transpose.96 = f64[128,128]{0,1} transpose(Arg_0.86), dimensions={1,0}
  transpose.97 = f64[128,128]{0,1} transpose(Arg_0.86), dimensions={1,0}
  concatenate.98 = f64[128,256]{1,0} concatenate(transpose.96, transpose.97), dimensions={1}
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
  ROOT gather.104 = f64[128,128]{1,0} gather(concatenate.98, reshape.103), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.131 = f64[128,128]{1,0} parameter(0)
  transpose.141 = f64[128,128]{0,1} transpose(Arg_0.131), dimensions={1,0}
  transpose.142 = f64[128,128]{0,1} transpose(Arg_0.131), dimensions={1,0}
  concatenate.143 = f64[128,256]{1,0} concatenate(transpose.141, transpose.142), dimensions={1}
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
  ROOT gather.149 = f64[128,128]{1,0} gather(concatenate.143, reshape.148), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.176 = f64[128,128]{1,0} parameter(0)
  transpose.186 = f64[128,128]{0,1} transpose(Arg_0.176), dimensions={1,0}
  transpose.187 = f64[128,128]{0,1} transpose(Arg_0.176), dimensions={1,0}
  concatenate.188 = f64[128,256]{1,0} concatenate(transpose.186, transpose.187), dimensions={1}
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
  ROOT gather.194 = f64[128,128]{1,0} gather(concatenate.188, reshape.193), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.221 = f64[128,128]{1,0} parameter(0)
  transpose.231 = f64[128,128]{0,1} transpose(Arg_0.221), dimensions={1,0}
  transpose.232 = f64[128,128]{0,1} transpose(Arg_0.221), dimensions={1,0}
  concatenate.233 = f64[128,256]{1,0} concatenate(transpose.231, transpose.232), dimensions={1}
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
  ROOT gather.239 = f64[128,128]{1,0} gather(concatenate.233, reshape.238), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
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
  Arg_0.266 = f64[128,128]{1,0} parameter(0)
  transpose.276 = f64[128,128]{0,1} transpose(Arg_0.266), dimensions={1,0}
  transpose.277 = f64[128,128]{0,1} transpose(Arg_0.266), dimensions={1,0}
  concatenate.278 = f64[128,256]{1,0} concatenate(transpose.276, transpose.277), dimensions={1}
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
  ROOT gather.284 = f64[128,128]{1,0} gather(concatenate.278, reshape.283), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

advect_1d_matrix_diag.285 {
  Arg_0.286 = f64[128,128]{1,0} parameter(0)
  Arg_1.287 = f64[128]{0} parameter(1)
  Arg_2.288 = f64[] parameter(2)
  broadcast.315 = f64[128]{0} broadcast(Arg_2.288), dimensions={}
  multiply.316 = f64[128]{0} multiply(Arg_1.287, broadcast.315)
  Arg_3.289 = f64[] parameter(3)
  broadcast.317 = f64[128]{0} broadcast(Arg_3.289), dimensions={}
  divide.318 = f64[128]{0} divide(multiply.316, broadcast.317)
  floor.319 = f64[128]{0} floor(divide.318)
  convert.321 = s32[128]{0} convert(floor.319)
  Arg_4.290 = s32[6]{0} parameter(4)
  slice.384 = s32[1]{0} slice(Arg_4.290), slice={[0:1]}
  reshape.385 = s32[] reshape(slice.384)
  broadcast.386 = s32[128]{0} broadcast(reshape.385), dimensions={}
  add.387 = s32[128]{0} add(convert.321, broadcast.386)
  call.388 = f64[128,128]{1,0} call(Arg_0.286, add.387), to_apply=_roll_dynamic.40
  transpose.389 = f64[128,128]{0,1} transpose(call.388), dimensions={1,0}
  subtract.320 = f64[128]{0} subtract(divide.318, floor.319)
  constant.313 = f64[] constant(20)
  broadcast.314 = f64[128]{0} broadcast(constant.313), dimensions={}
  divide.326 = f64[128]{0} divide(subtract.320, broadcast.314)
  multiply.322 = f64[128]{0} multiply(subtract.320, subtract.320)
  constant.311 = f64[] constant(24)
  broadcast.312 = f64[128]{0} broadcast(constant.311), dimensions={}
  divide.327 = f64[128]{0} divide(multiply.322, broadcast.312)
  subtract.328 = f64[128]{0} subtract(divide.326, divide.327)
  multiply.323 = f64[128]{0} multiply(multiply.322, subtract.320)
  divide.329 = f64[128]{0} divide(multiply.323, broadcast.312)
  subtract.330 = f64[128]{0} subtract(subtract.328, divide.329)
  multiply.324 = f64[128]{0} multiply(multiply.323, subtract.320)
  divide.331 = f64[128]{0} divide(multiply.324, broadcast.312)
  add.332 = f64[128]{0} add(subtract.330, divide.331)
  multiply.325 = f64[128]{0} multiply(multiply.324, subtract.320)
  constant.309 = f64[] constant(120)
  broadcast.310 = f64[128]{0} broadcast(constant.309), dimensions={}
  divide.333 = f64[128]{0} divide(multiply.325, broadcast.310)
  subtract.334 = f64[128]{0} subtract(add.332, divide.333)
  reshape.390 = f64[1,128]{1,0} reshape(subtract.334)
  broadcast.391 = f64[1,128]{1,0} broadcast(reshape.390), dimensions={0,1}
  reshape.392 = f64[128]{0} reshape(broadcast.391)
  broadcast.393 = f64[128,128]{1,0} broadcast(reshape.392), dimensions={1}
  multiply.394 = f64[128,128]{0,1} multiply(transpose.389, broadcast.393)
  slice.395 = s32[1]{0} slice(Arg_4.290), slice={[1:2]}
  reshape.396 = s32[] reshape(slice.395)
  broadcast.397 = s32[128]{0} broadcast(reshape.396), dimensions={}
  add.398 = s32[128]{0} add(convert.321, broadcast.397)
  call.399 = f64[128,128]{1,0} call(Arg_0.286, add.398), to_apply=_roll_dynamic.85
  transpose.400 = f64[128,128]{0,1} transpose(call.399), dimensions={1,0}
  constant.307 = f64[] constant(2)
  broadcast.308 = f64[128]{0} broadcast(constant.307), dimensions={}
  divide.335 = f64[128]{0} divide(subtract.320, broadcast.308)
  negate.336 = f64[128]{0} negate(divide.335)
  multiply.337 = f64[128]{0} multiply(multiply.322, broadcast.308)
  constant.305 = f64[] constant(3)
  broadcast.306 = f64[128]{0} broadcast(constant.305), dimensions={}
  divide.338 = f64[128]{0} divide(multiply.337, broadcast.306)
  add.339 = f64[128]{0} add(negate.336, divide.338)
  divide.340 = f64[128]{0} divide(multiply.323, broadcast.312)
  subtract.341 = f64[128]{0} subtract(add.339, divide.340)
  constant.303 = f64[] constant(6)
  broadcast.304 = f64[128]{0} broadcast(constant.303), dimensions={}
  divide.342 = f64[128]{0} divide(multiply.324, broadcast.304)
  subtract.343 = f64[128]{0} subtract(subtract.341, divide.342)
  divide.344 = f64[128]{0} divide(multiply.325, broadcast.312)
  add.345 = f64[128]{0} add(subtract.343, divide.344)
  reshape.401 = f64[1,128]{1,0} reshape(add.345)
  broadcast.402 = f64[1,128]{1,0} broadcast(reshape.401), dimensions={0,1}
  reshape.403 = f64[128]{0} reshape(broadcast.402)
  broadcast.404 = f64[128,128]{1,0} broadcast(reshape.403), dimensions={1}
  multiply.405 = f64[128,128]{0,1} multiply(transpose.400, broadcast.404)
  add.406 = f64[128,128]{0,1} add(multiply.394, multiply.405)
  slice.407 = s32[1]{0} slice(Arg_4.290), slice={[2:3]}
  reshape.408 = s32[] reshape(slice.407)
  broadcast.409 = s32[128]{0} broadcast(reshape.408), dimensions={}
  add.410 = s32[128]{0} add(convert.321, broadcast.409)
  call.411 = f64[128,128]{1,0} call(Arg_0.286, add.410), to_apply=_roll_dynamic.130
  transpose.412 = f64[128,128]{0,1} transpose(call.411), dimensions={1,0}
  constant.301 = f64[] constant(1)
  broadcast.302 = f64[128]{0} broadcast(constant.301), dimensions={}
  divide.346 = f64[128]{0} divide(subtract.320, broadcast.306)
  subtract.347 = f64[128]{0} subtract(broadcast.302, divide.346)
  constant.299 = f64[] constant(5)
  broadcast.300 = f64[128]{0} broadcast(constant.299), dimensions={}
  multiply.348 = f64[128]{0} multiply(multiply.322, broadcast.300)
  constant.297 = f64[] constant(4)
  broadcast.298 = f64[128]{0} broadcast(constant.297), dimensions={}
  divide.349 = f64[128]{0} divide(multiply.348, broadcast.298)
  subtract.350 = f64[128]{0} subtract(subtract.347, divide.349)
  multiply.351 = f64[128]{0} multiply(multiply.323, broadcast.300)
  constant.295 = f64[] constant(12)
  broadcast.296 = f64[128]{0} broadcast(constant.295), dimensions={}
  divide.352 = f64[128]{0} divide(multiply.351, broadcast.296)
  add.353 = f64[128]{0} add(subtract.350, divide.352)
  divide.354 = f64[128]{0} divide(multiply.324, broadcast.298)
  add.355 = f64[128]{0} add(add.353, divide.354)
  divide.356 = f64[128]{0} divide(multiply.325, broadcast.296)
  subtract.357 = f64[128]{0} subtract(add.355, divide.356)
  reshape.413 = f64[1,128]{1,0} reshape(subtract.357)
  broadcast.414 = f64[1,128]{1,0} broadcast(reshape.413), dimensions={0,1}
  reshape.415 = f64[128]{0} reshape(broadcast.414)
  broadcast.416 = f64[128,128]{1,0} broadcast(reshape.415), dimensions={1}
  multiply.417 = f64[128,128]{0,1} multiply(transpose.412, broadcast.416)
  add.418 = f64[128,128]{0,1} add(add.406, multiply.417)
  slice.419 = s32[1]{0} slice(Arg_4.290), slice={[3:4]}
  reshape.420 = s32[] reshape(slice.419)
  broadcast.421 = s32[128]{0} broadcast(reshape.420), dimensions={}
  add.422 = s32[128]{0} add(convert.321, broadcast.421)
  call.423 = f64[128,128]{1,0} call(Arg_0.286, add.422), to_apply=_roll_dynamic.175
  transpose.424 = f64[128,128]{0,1} transpose(call.423), dimensions={1,0}
  multiply.358 = f64[128]{0} multiply(multiply.322, broadcast.308)
  divide.359 = f64[128]{0} divide(multiply.358, broadcast.306)
  add.360 = f64[128]{0} add(subtract.320, divide.359)
  constant.293 = f64[] constant(7)
  broadcast.294 = f64[128]{0} broadcast(constant.293), dimensions={}
  multiply.361 = f64[128]{0} multiply(multiply.323, broadcast.294)
  divide.362 = f64[128]{0} divide(multiply.361, broadcast.296)
  subtract.363 = f64[128]{0} subtract(add.360, divide.362)
  divide.364 = f64[128]{0} divide(multiply.324, broadcast.304)
  subtract.365 = f64[128]{0} subtract(subtract.363, divide.364)
  divide.366 = f64[128]{0} divide(multiply.325, broadcast.296)
  add.367 = f64[128]{0} add(subtract.365, divide.366)
  reshape.425 = f64[1,128]{1,0} reshape(add.367)
  broadcast.426 = f64[1,128]{1,0} broadcast(reshape.425), dimensions={0,1}
  reshape.427 = f64[128]{0} reshape(broadcast.426)
  broadcast.428 = f64[128,128]{1,0} broadcast(reshape.427), dimensions={1}
  multiply.429 = f64[128,128]{0,1} multiply(transpose.424, broadcast.428)
  add.430 = f64[128,128]{0,1} add(add.418, multiply.429)
  slice.431 = s32[1]{0} slice(Arg_4.290), slice={[4:5]}
  reshape.432 = s32[] reshape(slice.431)
  broadcast.433 = s32[128]{0} broadcast(reshape.432), dimensions={}
  add.434 = s32[128]{0} add(convert.321, broadcast.433)
  call.435 = f64[128,128]{1,0} call(Arg_0.286, add.434), to_apply=_roll_dynamic.220
  transpose.436 = f64[128,128]{0,1} transpose(call.435), dimensions={1,0}
  divide.368 = f64[128]{0} divide(subtract.320, broadcast.298)
  negate.369 = f64[128]{0} negate(divide.368)
  divide.370 = f64[128]{0} divide(multiply.322, broadcast.312)
  subtract.371 = f64[128]{0} subtract(negate.369, divide.370)
  multiply.372 = f64[128]{0} multiply(multiply.323, broadcast.294)
  divide.373 = f64[128]{0} divide(multiply.372, broadcast.312)
  add.374 = f64[128]{0} add(subtract.371, divide.373)
  divide.375 = f64[128]{0} divide(multiply.324, broadcast.312)
  add.376 = f64[128]{0} add(add.374, divide.375)
  divide.377 = f64[128]{0} divide(multiply.325, broadcast.312)
  subtract.378 = f64[128]{0} subtract(add.376, divide.377)
  reshape.437 = f64[1,128]{1,0} reshape(subtract.378)
  broadcast.438 = f64[1,128]{1,0} broadcast(reshape.437), dimensions={0,1}
  reshape.439 = f64[128]{0} reshape(broadcast.438)
  broadcast.440 = f64[128,128]{1,0} broadcast(reshape.439), dimensions={1}
  multiply.441 = f64[128,128]{0,1} multiply(transpose.436, broadcast.440)
  add.442 = f64[128,128]{0,1} add(add.430, multiply.441)
  slice.443 = s32[1]{0} slice(Arg_4.290), slice={[5:6]}
  reshape.444 = s32[] reshape(slice.443)
  broadcast.445 = s32[128]{0} broadcast(reshape.444), dimensions={}
  add.446 = s32[128]{0} add(convert.321, broadcast.445)
  call.447 = f64[128,128]{1,0} call(Arg_0.286, add.446), to_apply=_roll_dynamic.265
  transpose.448 = f64[128,128]{0,1} transpose(call.447), dimensions={1,0}
  constant.291 = f64[] constant(30)
  broadcast.292 = f64[128]{0} broadcast(constant.291), dimensions={}
  divide.379 = f64[128]{0} divide(subtract.320, broadcast.292)
  divide.380 = f64[128]{0} divide(multiply.323, broadcast.312)
  subtract.381 = f64[128]{0} subtract(divide.379, divide.380)
  divide.382 = f64[128]{0} divide(multiply.325, broadcast.310)
  add.383 = f64[128]{0} add(subtract.381, divide.382)
  reshape.449 = f64[1,128]{1,0} reshape(add.383)
  broadcast.450 = f64[1,128]{1,0} broadcast(reshape.449), dimensions={0,1}
  reshape.451 = f64[128]{0} reshape(broadcast.450)
  broadcast.452 = f64[128,128]{1,0} broadcast(reshape.451), dimensions={1}
  multiply.453 = f64[128,128]{0,1} multiply(transpose.448, broadcast.452)
  ROOT add.454 = f64[128,128]{0,1} add(add.442, multiply.453)
}

region_1.455 {
  Arg_0.456 = f64[] parameter(0)
  Arg_1.457 = f64[] parameter(1)
  ROOT add.458 = f64[] add(Arg_0.456, Arg_1.457)
}

fft.459 {
  Arg_0.460 = f64[128]{0} parameter(0)
  ROOT fft.461 = c128[65]{0} fft(Arg_0.460), fft_type=RFFT, fft_length={128}
}

fft_0.462 {
  Arg_0.463 = c128[65]{0} parameter(0)
  ROOT fft.464 = f64[128]{0} fft(Arg_0.463), fft_type=IRFFT, fft_length={128}
}

fft_0.465 {
  Arg_0.466 = c128[65]{0} parameter(0)
  ROOT fft.467 = f64[128]{0} fft(Arg_0.466), fft_type=IRFFT, fft_length={128}
}

solve_poisson.468 {
  Arg_0.469 = f64[128,128]{1,0} parameter(0)
  constant.476 = f64[] constant(0)
  reduce.477 = f64[128]{0} reduce(Arg_0.469, constant.476), dimensions={1}, to_apply=region_1.455
  Arg_2.471 = f64[] parameter(2)
  broadcast.478 = f64[128]{0} broadcast(Arg_2.471), dimensions={}
  multiply.479 = f64[128]{0} multiply(reduce.477, broadcast.478)
  constant.474 = f64[] constant(1)
  broadcast.475 = f64[128]{0} broadcast(constant.474), dimensions={}
  subtract.480 = f64[128]{0} subtract(multiply.479, broadcast.475)
  call.481 = c128[65]{0} call(subtract.480), to_apply=fft.459
  constant.472 = c128[] constant((-0, -1))
  broadcast.473 = c128[65]{0} broadcast(constant.472), dimensions={}
  multiply.482 = c128[65]{0} multiply(call.481, broadcast.473)
  Arg_1.470 = f64[65]{0} parameter(1)
  convert.483 = c128[65]{0} convert(Arg_1.470)
  multiply.484 = c128[65]{0} multiply(multiply.482, convert.483)
  call.485 = f64[128]{0} call(multiply.484), to_apply=fft_0.462
  multiply.486 = f64[65]{0} multiply(Arg_1.470, Arg_1.470)
  convert.487 = c128[65]{0} convert(multiply.486)
  multiply.488 = c128[65]{0} multiply(call.481, convert.487)
  call.489 = f64[128]{0} call(multiply.488), to_apply=fft_0.465
  ROOT tuple.490 = (f64[128]{0}, f64[128]{0}, f64[128]{0}) tuple(call.485, subtract.480, call.489)
}

_where_2.491 {
  Arg_0.492 = pred[6,128,128]{2,1,0} parameter(0)
  Arg_1.493 = f64[6,128,1]{2,1,0} parameter(1)
  broadcast.495 = f64[6,128,1]{2,1,0} broadcast(Arg_1.493), dimensions={0,1,2}
  reshape.496 = f64[6,128]{1,0} reshape(broadcast.495)
  broadcast.497 = f64[6,128,128]{2,1,0} broadcast(reshape.496), dimensions={0,1}
  Arg_2.494 = f64[] parameter(2)
  broadcast.498 = f64[6,128,128]{2,1,0} broadcast(Arg_2.494), dimensions={}
  ROOT select.499 = f64[6,128,128]{2,1,0} select(Arg_0.492, broadcast.497, broadcast.498)
}

build_v_diag_weights.500 {
  iota.602 = s64[128]{0} iota(), iota_dimension=0
  reshape.612 = s64[1,1,128]{2,1,0} reshape(iota.602)
  broadcast.615 = s64[1,1,128]{2,1,0} broadcast(reshape.612), dimensions={0,1,2}
  reshape.616 = s64[128]{0} reshape(broadcast.615)
  broadcast.617 = s64[6,128,128]{2,1,0} broadcast(reshape.616), dimensions={2}
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
  convert.614 = s64[6,128,1]{2,1,0} convert(reshape.613)
  broadcast.618 = s64[6,128,1]{2,1,0} broadcast(convert.614), dimensions={0,1,2}
  reshape.619 = s64[6,128]{1,0} reshape(broadcast.618)
  broadcast.620 = s64[6,128,128]{2,1,0} broadcast(reshape.619), dimensions={0,1}
  subtract.621 = s64[6,128,128]{2,1,0} subtract(broadcast.617, broadcast.620)
  constant.506 = s64[] constant(0)
  broadcast.507 = s64[6,128,128]{2,1,0} broadcast(constant.506), dimensions={}
  compare.622 = pred[6,128,128]{2,1,0} compare(subtract.621, broadcast.507), direction=GE
  constant.504 = s64[] constant(128)
  broadcast.505 = s64[6,128,128]{2,1,0} broadcast(constant.504), dimensions={}
  compare.623 = pred[6,128,128]{2,1,0} compare(subtract.621, broadcast.505), direction=LT
  and.624 = pred[6,128,128]{2,1,0} and(compare.622, compare.623)
  Arg_2.503 = f64[128]{0} parameter(2)
  constant.530 = f64[] constant(20)
  broadcast.531 = f64[128]{0} broadcast(constant.530), dimensions={}
  divide.537 = f64[128]{0} divide(Arg_2.503, broadcast.531)
  multiply.533 = f64[128]{0} multiply(Arg_2.503, Arg_2.503)
  constant.528 = f64[] constant(24)
  broadcast.529 = f64[128]{0} broadcast(constant.528), dimensions={}
  divide.538 = f64[128]{0} divide(multiply.533, broadcast.529)
  subtract.539 = f64[128]{0} subtract(divide.537, divide.538)
  multiply.534 = f64[128]{0} multiply(multiply.533, Arg_2.503)
  divide.540 = f64[128]{0} divide(multiply.534, broadcast.529)
  subtract.541 = f64[128]{0} subtract(subtract.539, divide.540)
  multiply.535 = f64[128]{0} multiply(multiply.534, Arg_2.503)
  divide.542 = f64[128]{0} divide(multiply.535, broadcast.529)
  add.543 = f64[128]{0} add(subtract.541, divide.542)
  multiply.536 = f64[128]{0} multiply(multiply.535, Arg_2.503)
  constant.526 = f64[] constant(120)
  broadcast.527 = f64[128]{0} broadcast(constant.526), dimensions={}
  divide.544 = f64[128]{0} divide(multiply.536, broadcast.527)
  subtract.545 = f64[128]{0} subtract(add.543, divide.544)
  reshape.595 = f64[1,128]{1,0} reshape(subtract.545)
  constant.524 = f64[] constant(2)
  broadcast.525 = f64[128]{0} broadcast(constant.524), dimensions={}
  divide.546 = f64[128]{0} divide(Arg_2.503, broadcast.525)
  negate.547 = f64[128]{0} negate(divide.546)
  multiply.548 = f64[128]{0} multiply(multiply.533, broadcast.525)
  constant.522 = f64[] constant(3)
  broadcast.523 = f64[128]{0} broadcast(constant.522), dimensions={}
  divide.549 = f64[128]{0} divide(multiply.548, broadcast.523)
  add.550 = f64[128]{0} add(negate.547, divide.549)
  divide.551 = f64[128]{0} divide(multiply.534, broadcast.529)
  subtract.552 = f64[128]{0} subtract(add.550, divide.551)
  constant.520 = f64[] constant(6)
  broadcast.521 = f64[128]{0} broadcast(constant.520), dimensions={}
  divide.553 = f64[128]{0} divide(multiply.535, broadcast.521)
  subtract.554 = f64[128]{0} subtract(subtract.552, divide.553)
  divide.555 = f64[128]{0} divide(multiply.536, broadcast.529)
  add.556 = f64[128]{0} add(subtract.554, divide.555)
  reshape.596 = f64[1,128]{1,0} reshape(add.556)
  constant.518 = f64[] constant(1)
  broadcast.519 = f64[128]{0} broadcast(constant.518), dimensions={}
  divide.557 = f64[128]{0} divide(Arg_2.503, broadcast.523)
  subtract.558 = f64[128]{0} subtract(broadcast.519, divide.557)
  constant.516 = f64[] constant(5)
  broadcast.517 = f64[128]{0} broadcast(constant.516), dimensions={}
  multiply.559 = f64[128]{0} multiply(multiply.533, broadcast.517)
  constant.514 = f64[] constant(4)
  broadcast.515 = f64[128]{0} broadcast(constant.514), dimensions={}
  divide.560 = f64[128]{0} divide(multiply.559, broadcast.515)
  subtract.561 = f64[128]{0} subtract(subtract.558, divide.560)
  multiply.562 = f64[128]{0} multiply(multiply.534, broadcast.517)
  constant.512 = f64[] constant(12)
  broadcast.513 = f64[128]{0} broadcast(constant.512), dimensions={}
  divide.563 = f64[128]{0} divide(multiply.562, broadcast.513)
  add.564 = f64[128]{0} add(subtract.561, divide.563)
  divide.565 = f64[128]{0} divide(multiply.535, broadcast.515)
  add.566 = f64[128]{0} add(add.564, divide.565)
  divide.567 = f64[128]{0} divide(multiply.536, broadcast.513)
  subtract.568 = f64[128]{0} subtract(add.566, divide.567)
  reshape.597 = f64[1,128]{1,0} reshape(subtract.568)
  multiply.569 = f64[128]{0} multiply(multiply.533, broadcast.525)
  divide.570 = f64[128]{0} divide(multiply.569, broadcast.523)
  add.571 = f64[128]{0} add(Arg_2.503, divide.570)
  constant.510 = f64[] constant(7)
  broadcast.511 = f64[128]{0} broadcast(constant.510), dimensions={}
  multiply.572 = f64[128]{0} multiply(multiply.534, broadcast.511)
  divide.573 = f64[128]{0} divide(multiply.572, broadcast.513)
  subtract.574 = f64[128]{0} subtract(add.571, divide.573)
  divide.575 = f64[128]{0} divide(multiply.535, broadcast.521)
  subtract.576 = f64[128]{0} subtract(subtract.574, divide.575)
  divide.577 = f64[128]{0} divide(multiply.536, broadcast.513)
  add.578 = f64[128]{0} add(subtract.576, divide.577)
  reshape.598 = f64[1,128]{1,0} reshape(add.578)
  divide.579 = f64[128]{0} divide(Arg_2.503, broadcast.515)
  negate.580 = f64[128]{0} negate(divide.579)
  divide.581 = f64[128]{0} divide(multiply.533, broadcast.529)
  subtract.582 = f64[128]{0} subtract(negate.580, divide.581)
  multiply.583 = f64[128]{0} multiply(multiply.534, broadcast.511)
  divide.584 = f64[128]{0} divide(multiply.583, broadcast.529)
  add.585 = f64[128]{0} add(subtract.582, divide.584)
  divide.586 = f64[128]{0} divide(multiply.535, broadcast.529)
  add.587 = f64[128]{0} add(add.585, divide.586)
  divide.588 = f64[128]{0} divide(multiply.536, broadcast.529)
  subtract.589 = f64[128]{0} subtract(add.587, divide.588)
  reshape.599 = f64[1,128]{1,0} reshape(subtract.589)
  constant.508 = f64[] constant(30)
  broadcast.509 = f64[128]{0} broadcast(constant.508), dimensions={}
  divide.590 = f64[128]{0} divide(Arg_2.503, broadcast.509)
  divide.591 = f64[128]{0} divide(multiply.534, broadcast.529)
  subtract.592 = f64[128]{0} subtract(divide.590, divide.591)
  divide.593 = f64[128]{0} divide(multiply.536, broadcast.527)
  add.594 = f64[128]{0} add(subtract.592, divide.593)
  reshape.600 = f64[1,128]{1,0} reshape(add.594)
  concatenate.601 = f64[6,128]{1,0} concatenate(reshape.595, reshape.596, reshape.597, reshape.598, reshape.599, reshape.600), dimensions={0}
  reshape.625 = f64[6,128,1]{2,1,0} reshape(concatenate.601)
  constant.532 = f64[] constant(0)
  ROOT call.626 = f64[6,128,128]{2,1,0} call(and.624, reshape.625, constant.532), to_apply=_where_2.491
}

_where.627 {
  Arg_0.628 = pred[] parameter(0)
  Arg_1.629 = s32[] parameter(1)
  Arg_2.630 = s32[] parameter(2)
  ROOT select.631 = s32[] select(Arg_0.628, Arg_1.629, Arg_2.630)
}

remainder.632 {
  Arg_0.633 = s32[128]{0} parameter(0)
  Arg_1.634 = s32[] parameter(1)
  constant.638 = s32[] constant(0)
  compare.639 = pred[] compare(Arg_1.634, constant.638), direction=EQ
  constant.637 = s32[] constant(1)
  call.640 = s32[] call(compare.639, constant.637, Arg_1.634), to_apply=_where.627
  broadcast.641 = s32[128]{0} broadcast(call.640), dimensions={}
  remainder.642 = s32[128]{0} remainder(Arg_0.633, broadcast.641)
  constant.635 = s32[] constant(0)
  broadcast.636 = s32[128]{0} broadcast(constant.635), dimensions={}
  compare.644 = pred[128]{0} compare(remainder.642, broadcast.636), direction=LT
  compare.645 = pred[] compare(call.640, constant.638), direction=LT
  broadcast.646 = pred[128]{0} broadcast(compare.645), dimensions={}
  compare.647 = pred[128]{0} compare(compare.644, broadcast.646), direction=NE
  compare.643 = pred[128]{0} compare(remainder.642, broadcast.636), direction=NE
  and.648 = pred[128]{0} and(compare.647, compare.643)
  broadcast.649 = s32[128]{0} broadcast(call.640), dimensions={}
  add.650 = s32[128]{0} add(remainder.642, broadcast.649)
  ROOT select.651 = s32[128]{0} select(and.648, add.650, remainder.642)
}

_roll_dynamic_3.652 {
  Arg_0.653 = f64[128,128]{1,0} parameter(0)
  concatenate.663 = f64[128,256]{1,0} concatenate(Arg_0.653, Arg_0.653), dimensions={1}
  constant.659 = s32[] constant(128)
  broadcast.660 = s32[128]{0} broadcast(constant.659), dimensions={}
  Arg_1.654 = s32[128]{0} parameter(1)
  constant.661 = s32[] constant(128)
  call.662 = s32[128]{0} call(Arg_1.654, constant.661), to_apply=remainder.632
  subtract.664 = s32[128]{0} subtract(broadcast.660, call.662)
  constant.657 = s32[] constant(0)
  broadcast.658 = s32[128]{0} broadcast(constant.657), dimensions={}
  compare.665 = pred[128]{0} compare(subtract.664, broadcast.658), direction=LT
  constant.655 = s32[] constant(256)
  broadcast.656 = s32[128]{0} broadcast(constant.655), dimensions={}
  add.666 = s32[128]{0} add(subtract.664, broadcast.656)
  select.667 = s32[128]{0} select(compare.665, add.666, subtract.664)
  reshape.668 = s32[128,1]{1,0} reshape(select.667)
  ROOT gather.669 = f64[128,128]{1,0} gather(concatenate.663, reshape.668), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.670 {
  Arg_0.671 = pred[] parameter(0)
  Arg_1.672 = s32[] parameter(1)
  Arg_2.673 = s32[] parameter(2)
  ROOT select.674 = s32[] select(Arg_0.671, Arg_1.672, Arg_2.673)
}

remainder.675 {
  Arg_0.676 = s32[128]{0} parameter(0)
  Arg_1.677 = s32[] parameter(1)
  constant.681 = s32[] constant(0)
  compare.682 = pred[] compare(Arg_1.677, constant.681), direction=EQ
  constant.680 = s32[] constant(1)
  call.683 = s32[] call(compare.682, constant.680, Arg_1.677), to_apply=_where.670
  broadcast.684 = s32[128]{0} broadcast(call.683), dimensions={}
  remainder.685 = s32[128]{0} remainder(Arg_0.676, broadcast.684)
  constant.678 = s32[] constant(0)
  broadcast.679 = s32[128]{0} broadcast(constant.678), dimensions={}
  compare.687 = pred[128]{0} compare(remainder.685, broadcast.679), direction=LT
  compare.688 = pred[] compare(call.683, constant.681), direction=LT
  broadcast.689 = pred[128]{0} broadcast(compare.688), dimensions={}
  compare.690 = pred[128]{0} compare(compare.687, broadcast.689), direction=NE
  compare.686 = pred[128]{0} compare(remainder.685, broadcast.679), direction=NE
  and.691 = pred[128]{0} and(compare.690, compare.686)
  broadcast.692 = s32[128]{0} broadcast(call.683), dimensions={}
  add.693 = s32[128]{0} add(remainder.685, broadcast.692)
  ROOT select.694 = s32[128]{0} select(and.691, add.693, remainder.685)
}

_roll_dynamic_3.695 {
  Arg_0.696 = f64[128,128]{1,0} parameter(0)
  concatenate.706 = f64[128,256]{1,0} concatenate(Arg_0.696, Arg_0.696), dimensions={1}
  constant.702 = s32[] constant(128)
  broadcast.703 = s32[128]{0} broadcast(constant.702), dimensions={}
  Arg_1.697 = s32[128]{0} parameter(1)
  constant.704 = s32[] constant(128)
  call.705 = s32[128]{0} call(Arg_1.697, constant.704), to_apply=remainder.675
  subtract.707 = s32[128]{0} subtract(broadcast.703, call.705)
  constant.700 = s32[] constant(0)
  broadcast.701 = s32[128]{0} broadcast(constant.700), dimensions={}
  compare.708 = pred[128]{0} compare(subtract.707, broadcast.701), direction=LT
  constant.698 = s32[] constant(256)
  broadcast.699 = s32[128]{0} broadcast(constant.698), dimensions={}
  add.709 = s32[128]{0} add(subtract.707, broadcast.699)
  select.710 = s32[128]{0} select(compare.708, add.709, subtract.707)
  reshape.711 = s32[128,1]{1,0} reshape(select.710)
  ROOT gather.712 = f64[128,128]{1,0} gather(concatenate.706, reshape.711), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.713 {
  Arg_0.714 = pred[] parameter(0)
  Arg_1.715 = s32[] parameter(1)
  Arg_2.716 = s32[] parameter(2)
  ROOT select.717 = s32[] select(Arg_0.714, Arg_1.715, Arg_2.716)
}

remainder.718 {
  Arg_0.719 = s32[128]{0} parameter(0)
  Arg_1.720 = s32[] parameter(1)
  constant.724 = s32[] constant(0)
  compare.725 = pred[] compare(Arg_1.720, constant.724), direction=EQ
  constant.723 = s32[] constant(1)
  call.726 = s32[] call(compare.725, constant.723, Arg_1.720), to_apply=_where.713
  broadcast.727 = s32[128]{0} broadcast(call.726), dimensions={}
  remainder.728 = s32[128]{0} remainder(Arg_0.719, broadcast.727)
  constant.721 = s32[] constant(0)
  broadcast.722 = s32[128]{0} broadcast(constant.721), dimensions={}
  compare.730 = pred[128]{0} compare(remainder.728, broadcast.722), direction=LT
  compare.731 = pred[] compare(call.726, constant.724), direction=LT
  broadcast.732 = pred[128]{0} broadcast(compare.731), dimensions={}
  compare.733 = pred[128]{0} compare(compare.730, broadcast.732), direction=NE
  compare.729 = pred[128]{0} compare(remainder.728, broadcast.722), direction=NE
  and.734 = pred[128]{0} and(compare.733, compare.729)
  broadcast.735 = s32[128]{0} broadcast(call.726), dimensions={}
  add.736 = s32[128]{0} add(remainder.728, broadcast.735)
  ROOT select.737 = s32[128]{0} select(and.734, add.736, remainder.728)
}

_roll_dynamic_3.738 {
  Arg_0.739 = f64[128,128]{1,0} parameter(0)
  concatenate.749 = f64[128,256]{1,0} concatenate(Arg_0.739, Arg_0.739), dimensions={1}
  constant.745 = s32[] constant(128)
  broadcast.746 = s32[128]{0} broadcast(constant.745), dimensions={}
  Arg_1.740 = s32[128]{0} parameter(1)
  constant.747 = s32[] constant(128)
  call.748 = s32[128]{0} call(Arg_1.740, constant.747), to_apply=remainder.718
  subtract.750 = s32[128]{0} subtract(broadcast.746, call.748)
  constant.743 = s32[] constant(0)
  broadcast.744 = s32[128]{0} broadcast(constant.743), dimensions={}
  compare.751 = pred[128]{0} compare(subtract.750, broadcast.744), direction=LT
  constant.741 = s32[] constant(256)
  broadcast.742 = s32[128]{0} broadcast(constant.741), dimensions={}
  add.752 = s32[128]{0} add(subtract.750, broadcast.742)
  select.753 = s32[128]{0} select(compare.751, add.752, subtract.750)
  reshape.754 = s32[128,1]{1,0} reshape(select.753)
  ROOT gather.755 = f64[128,128]{1,0} gather(concatenate.749, reshape.754), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.756 {
  Arg_0.757 = pred[] parameter(0)
  Arg_1.758 = s32[] parameter(1)
  Arg_2.759 = s32[] parameter(2)
  ROOT select.760 = s32[] select(Arg_0.757, Arg_1.758, Arg_2.759)
}

remainder.761 {
  Arg_0.762 = s32[128]{0} parameter(0)
  Arg_1.763 = s32[] parameter(1)
  constant.767 = s32[] constant(0)
  compare.768 = pred[] compare(Arg_1.763, constant.767), direction=EQ
  constant.766 = s32[] constant(1)
  call.769 = s32[] call(compare.768, constant.766, Arg_1.763), to_apply=_where.756
  broadcast.770 = s32[128]{0} broadcast(call.769), dimensions={}
  remainder.771 = s32[128]{0} remainder(Arg_0.762, broadcast.770)
  constant.764 = s32[] constant(0)
  broadcast.765 = s32[128]{0} broadcast(constant.764), dimensions={}
  compare.773 = pred[128]{0} compare(remainder.771, broadcast.765), direction=LT
  compare.774 = pred[] compare(call.769, constant.767), direction=LT
  broadcast.775 = pred[128]{0} broadcast(compare.774), dimensions={}
  compare.776 = pred[128]{0} compare(compare.773, broadcast.775), direction=NE
  compare.772 = pred[128]{0} compare(remainder.771, broadcast.765), direction=NE
  and.777 = pred[128]{0} and(compare.776, compare.772)
  broadcast.778 = s32[128]{0} broadcast(call.769), dimensions={}
  add.779 = s32[128]{0} add(remainder.771, broadcast.778)
  ROOT select.780 = s32[128]{0} select(and.777, add.779, remainder.771)
}

_roll_dynamic_3.781 {
  Arg_0.782 = f64[128,128]{1,0} parameter(0)
  concatenate.792 = f64[128,256]{1,0} concatenate(Arg_0.782, Arg_0.782), dimensions={1}
  constant.788 = s32[] constant(128)
  broadcast.789 = s32[128]{0} broadcast(constant.788), dimensions={}
  Arg_1.783 = s32[128]{0} parameter(1)
  constant.790 = s32[] constant(128)
  call.791 = s32[128]{0} call(Arg_1.783, constant.790), to_apply=remainder.761
  subtract.793 = s32[128]{0} subtract(broadcast.789, call.791)
  constant.786 = s32[] constant(0)
  broadcast.787 = s32[128]{0} broadcast(constant.786), dimensions={}
  compare.794 = pred[128]{0} compare(subtract.793, broadcast.787), direction=LT
  constant.784 = s32[] constant(256)
  broadcast.785 = s32[128]{0} broadcast(constant.784), dimensions={}
  add.795 = s32[128]{0} add(subtract.793, broadcast.785)
  select.796 = s32[128]{0} select(compare.794, add.795, subtract.793)
  reshape.797 = s32[128,1]{1,0} reshape(select.796)
  ROOT gather.798 = f64[128,128]{1,0} gather(concatenate.792, reshape.797), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.799 {
  Arg_0.800 = pred[] parameter(0)
  Arg_1.801 = s32[] parameter(1)
  Arg_2.802 = s32[] parameter(2)
  ROOT select.803 = s32[] select(Arg_0.800, Arg_1.801, Arg_2.802)
}

remainder.804 {
  Arg_0.805 = s32[128]{0} parameter(0)
  Arg_1.806 = s32[] parameter(1)
  constant.810 = s32[] constant(0)
  compare.811 = pred[] compare(Arg_1.806, constant.810), direction=EQ
  constant.809 = s32[] constant(1)
  call.812 = s32[] call(compare.811, constant.809, Arg_1.806), to_apply=_where.799
  broadcast.813 = s32[128]{0} broadcast(call.812), dimensions={}
  remainder.814 = s32[128]{0} remainder(Arg_0.805, broadcast.813)
  constant.807 = s32[] constant(0)
  broadcast.808 = s32[128]{0} broadcast(constant.807), dimensions={}
  compare.816 = pred[128]{0} compare(remainder.814, broadcast.808), direction=LT
  compare.817 = pred[] compare(call.812, constant.810), direction=LT
  broadcast.818 = pred[128]{0} broadcast(compare.817), dimensions={}
  compare.819 = pred[128]{0} compare(compare.816, broadcast.818), direction=NE
  compare.815 = pred[128]{0} compare(remainder.814, broadcast.808), direction=NE
  and.820 = pred[128]{0} and(compare.819, compare.815)
  broadcast.821 = s32[128]{0} broadcast(call.812), dimensions={}
  add.822 = s32[128]{0} add(remainder.814, broadcast.821)
  ROOT select.823 = s32[128]{0} select(and.820, add.822, remainder.814)
}

_roll_dynamic_3.824 {
  Arg_0.825 = f64[128,128]{1,0} parameter(0)
  concatenate.835 = f64[128,256]{1,0} concatenate(Arg_0.825, Arg_0.825), dimensions={1}
  constant.831 = s32[] constant(128)
  broadcast.832 = s32[128]{0} broadcast(constant.831), dimensions={}
  Arg_1.826 = s32[128]{0} parameter(1)
  constant.833 = s32[] constant(128)
  call.834 = s32[128]{0} call(Arg_1.826, constant.833), to_apply=remainder.804
  subtract.836 = s32[128]{0} subtract(broadcast.832, call.834)
  constant.829 = s32[] constant(0)
  broadcast.830 = s32[128]{0} broadcast(constant.829), dimensions={}
  compare.837 = pred[128]{0} compare(subtract.836, broadcast.830), direction=LT
  constant.827 = s32[] constant(256)
  broadcast.828 = s32[128]{0} broadcast(constant.827), dimensions={}
  add.838 = s32[128]{0} add(subtract.836, broadcast.828)
  select.839 = s32[128]{0} select(compare.837, add.838, subtract.836)
  reshape.840 = s32[128,1]{1,0} reshape(select.839)
  ROOT gather.841 = f64[128,128]{1,0} gather(concatenate.835, reshape.840), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

_where.842 {
  Arg_0.843 = pred[] parameter(0)
  Arg_1.844 = s32[] parameter(1)
  Arg_2.845 = s32[] parameter(2)
  ROOT select.846 = s32[] select(Arg_0.843, Arg_1.844, Arg_2.845)
}

remainder.847 {
  Arg_0.848 = s32[128]{0} parameter(0)
  Arg_1.849 = s32[] parameter(1)
  constant.853 = s32[] constant(0)
  compare.854 = pred[] compare(Arg_1.849, constant.853), direction=EQ
  constant.852 = s32[] constant(1)
  call.855 = s32[] call(compare.854, constant.852, Arg_1.849), to_apply=_where.842
  broadcast.856 = s32[128]{0} broadcast(call.855), dimensions={}
  remainder.857 = s32[128]{0} remainder(Arg_0.848, broadcast.856)
  constant.850 = s32[] constant(0)
  broadcast.851 = s32[128]{0} broadcast(constant.850), dimensions={}
  compare.859 = pred[128]{0} compare(remainder.857, broadcast.851), direction=LT
  compare.860 = pred[] compare(call.855, constant.853), direction=LT
  broadcast.861 = pred[128]{0} broadcast(compare.860), dimensions={}
  compare.862 = pred[128]{0} compare(compare.859, broadcast.861), direction=NE
  compare.858 = pred[128]{0} compare(remainder.857, broadcast.851), direction=NE
  and.863 = pred[128]{0} and(compare.862, compare.858)
  broadcast.864 = s32[128]{0} broadcast(call.855), dimensions={}
  add.865 = s32[128]{0} add(remainder.857, broadcast.864)
  ROOT select.866 = s32[128]{0} select(and.863, add.865, remainder.857)
}

_roll_dynamic_3.867 {
  Arg_0.868 = f64[128,128]{1,0} parameter(0)
  concatenate.878 = f64[128,256]{1,0} concatenate(Arg_0.868, Arg_0.868), dimensions={1}
  constant.874 = s32[] constant(128)
  broadcast.875 = s32[128]{0} broadcast(constant.874), dimensions={}
  Arg_1.869 = s32[128]{0} parameter(1)
  constant.876 = s32[] constant(128)
  call.877 = s32[128]{0} call(Arg_1.869, constant.876), to_apply=remainder.847
  subtract.879 = s32[128]{0} subtract(broadcast.875, call.877)
  constant.872 = s32[] constant(0)
  broadcast.873 = s32[128]{0} broadcast(constant.872), dimensions={}
  compare.880 = pred[128]{0} compare(subtract.879, broadcast.873), direction=LT
  constant.870 = s32[] constant(256)
  broadcast.871 = s32[128]{0} broadcast(constant.870), dimensions={}
  add.881 = s32[128]{0} add(subtract.879, broadcast.871)
  select.882 = s32[128]{0} select(compare.880, add.881, subtract.879)
  reshape.883 = s32[128,1]{1,0} reshape(select.882)
  ROOT gather.884 = f64[128,128]{1,0} gather(concatenate.878, reshape.883), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

advect_1d_matrix_diag_1.885 {
  Arg_4.890 = s32[6]{0} parameter(4)
  Arg_1.887 = f64[128]{0} parameter(1)
  Arg_2.888 = f64[] parameter(2)
  broadcast.891 = f64[128]{0} broadcast(Arg_2.888), dimensions={}
  multiply.892 = f64[128]{0} multiply(Arg_1.887, broadcast.891)
  Arg_3.889 = f64[] parameter(3)
  broadcast.893 = f64[128]{0} broadcast(Arg_3.889), dimensions={}
  divide.894 = f64[128]{0} divide(multiply.892, broadcast.893)
  floor.895 = f64[128]{0} floor(divide.894)
  convert.897 = s32[128]{0} convert(floor.895)
  subtract.896 = f64[128]{0} subtract(divide.894, floor.895)
  call.898 = f64[6,128,128]{2,1,0} call(Arg_4.890, convert.897, subtract.896), to_apply=build_v_diag_weights.500
  slice.904 = f64[1,128,128]{2,1,0} slice(call.898), slice={[0:1], [0:128], [0:128]}
  reshape.905 = f64[128,128]{1,0} reshape(slice.904)
  Arg_0.886 = f64[128,128]{1,0} parameter(0)
  slice.899 = s32[1]{0} slice(Arg_4.890), slice={[0:1]}
  reshape.900 = s32[] reshape(slice.899)
  broadcast.901 = s32[128]{0} broadcast(reshape.900), dimensions={}
  add.902 = s32[128]{0} add(convert.897, broadcast.901)
  call.903 = f64[128,128]{1,0} call(Arg_0.886, add.902), to_apply=_roll_dynamic_3.652
  multiply.906 = f64[128,128]{1,0} multiply(reshape.905, call.903)
  slice.912 = f64[1,128,128]{2,1,0} slice(call.898), slice={[1:2], [0:128], [0:128]}
  reshape.913 = f64[128,128]{1,0} reshape(slice.912)
  slice.907 = s32[1]{0} slice(Arg_4.890), slice={[1:2]}
  reshape.908 = s32[] reshape(slice.907)
  broadcast.909 = s32[128]{0} broadcast(reshape.908), dimensions={}
  add.910 = s32[128]{0} add(convert.897, broadcast.909)
  call.911 = f64[128,128]{1,0} call(Arg_0.886, add.910), to_apply=_roll_dynamic_3.695
  multiply.914 = f64[128,128]{1,0} multiply(reshape.913, call.911)
  add.915 = f64[128,128]{1,0} add(multiply.906, multiply.914)
  slice.921 = f64[1,128,128]{2,1,0} slice(call.898), slice={[2:3], [0:128], [0:128]}
  reshape.922 = f64[128,128]{1,0} reshape(slice.921)
  slice.916 = s32[1]{0} slice(Arg_4.890), slice={[2:3]}
  reshape.917 = s32[] reshape(slice.916)
  broadcast.918 = s32[128]{0} broadcast(reshape.917), dimensions={}
  add.919 = s32[128]{0} add(convert.897, broadcast.918)
  call.920 = f64[128,128]{1,0} call(Arg_0.886, add.919), to_apply=_roll_dynamic_3.738
  multiply.923 = f64[128,128]{1,0} multiply(reshape.922, call.920)
  add.924 = f64[128,128]{1,0} add(add.915, multiply.923)
  slice.930 = f64[1,128,128]{2,1,0} slice(call.898), slice={[3:4], [0:128], [0:128]}
  reshape.931 = f64[128,128]{1,0} reshape(slice.930)
  slice.925 = s32[1]{0} slice(Arg_4.890), slice={[3:4]}
  reshape.926 = s32[] reshape(slice.925)
  broadcast.927 = s32[128]{0} broadcast(reshape.926), dimensions={}
  add.928 = s32[128]{0} add(convert.897, broadcast.927)
  call.929 = f64[128,128]{1,0} call(Arg_0.886, add.928), to_apply=_roll_dynamic_3.781
  multiply.932 = f64[128,128]{1,0} multiply(reshape.931, call.929)
  add.933 = f64[128,128]{1,0} add(add.924, multiply.932)
  slice.939 = f64[1,128,128]{2,1,0} slice(call.898), slice={[4:5], [0:128], [0:128]}
  reshape.940 = f64[128,128]{1,0} reshape(slice.939)
  slice.934 = s32[1]{0} slice(Arg_4.890), slice={[4:5]}
  reshape.935 = s32[] reshape(slice.934)
  broadcast.936 = s32[128]{0} broadcast(reshape.935), dimensions={}
  add.937 = s32[128]{0} add(convert.897, broadcast.936)
  call.938 = f64[128,128]{1,0} call(Arg_0.886, add.937), to_apply=_roll_dynamic_3.824
  multiply.941 = f64[128,128]{1,0} multiply(reshape.940, call.938)
  add.942 = f64[128,128]{1,0} add(add.933, multiply.941)
  slice.948 = f64[1,128,128]{2,1,0} slice(call.898), slice={[5:6], [0:128], [0:128]}
  reshape.949 = f64[128,128]{1,0} reshape(slice.948)
  slice.943 = s32[1]{0} slice(Arg_4.890), slice={[5:6]}
  reshape.944 = s32[] reshape(slice.943)
  broadcast.945 = s32[128]{0} broadcast(reshape.944), dimensions={}
  add.946 = s32[128]{0} add(convert.897, broadcast.945)
  call.947 = f64[128,128]{1,0} call(Arg_0.886, add.946), to_apply=_roll_dynamic_3.867
  multiply.950 = f64[128,128]{1,0} multiply(reshape.949, call.947)
  ROOT add.951 = f64[128,128]{1,0} add(add.942, multiply.950)
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

None.1392 {
  Arg_4.1397 = f64[128]{0} parameter(4)
  Arg_5.1398 = f64[128]{0} parameter(5)
  Arg_3.1396 = f64[128,128]{1,0} parameter(3)
  Arg_0.1393 = f64[128]{0} parameter(0)
  constant.1401 = f64[] constant(0.025)
  constant.1402 = f64[] constant(0.098174770424681035)
  Arg_1.1394 = s32[6]{0} parameter(1)
  call.1403 = f64[128,128]{0,1} call(Arg_3.1396, Arg_0.1393, constant.1401, constant.1402, Arg_1.1394), to_apply=advect_1d_matrix_diag.285
  Arg_2.1395 = f64[65]{0} parameter(2)
  constant.1400 = f64[] constant(0.07874015748031496)
  call.1404 = (f64[128]{0}, f64[128]{0}, f64[128]{0}) call(call.1403, Arg_2.1395, constant.1400), to_apply=solve_poisson.468
  get-tuple-element.1405 = f64[128]{0} get-tuple-element(call.1404), index=0
  constant.1399 = f64[] constant(0.05)
  call.1408 = f64[128,128]{1,0} call(call.1403, get-tuple-element.1405, constant.1399, constant.1400, Arg_1.1394), to_apply=advect_1d_matrix_diag_1.885
  call.1409 = f64[128,128]{0,1} call(call.1408, Arg_0.1393, constant.1401, constant.1402, Arg_1.1394), to_apply=advect_1d_matrix_diag.1222
  get-tuple-element.1406 = f64[128]{0} get-tuple-element(call.1404), index=1
  get-tuple-element.1407 = f64[128]{0} get-tuple-element(call.1404), index=2
  ROOT tuple.1410 = (f64[128,128]{0,1}, f64[128]{0}, f64[128]{0}) tuple(call.1409, get-tuple-element.1406, get-tuple-element.1407)
}

region_0.1411 {
  arg_tuple.1412 = (s64[], f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) parameter(0)
  get-tuple-element.1413 = s64[] get-tuple-element(arg_tuple.1412), index=0
  constant.1417 = s64[] constant(1)
  add.1425 = s64[] add(get-tuple-element.1413, constant.1417)
  constant.1420 = f64[128]{0} constant({...})
  constant.1419 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  constant.1418 = f64[65]{0} constant({...})
  get-tuple-element.1414 = f64[128,128]{1,0} get-tuple-element(arg_tuple.1412), index=1
  get-tuple-element.1415 = f64[128]{0} get-tuple-element(arg_tuple.1412), index=2
  get-tuple-element.1416 = f64[128]{0} get-tuple-element(arg_tuple.1412), index=3
  call.1421 = (f64[128,128]{0,1}, f64[128]{0}, f64[128]{0}) call(constant.1420, constant.1419, constant.1418, get-tuple-element.1414, get-tuple-element.1415, get-tuple-element.1416), to_apply=None.1392
  get-tuple-element.1422 = f64[128,128]{0,1} get-tuple-element(call.1421), index=0
  get-tuple-element.1423 = f64[128]{0} get-tuple-element(call.1421), index=1
  get-tuple-element.1424 = f64[128]{0} get-tuple-element(call.1421), index=2
  ROOT tuple.1426 = (s64[], f64[128,128]{0,1}, f64[128]{0}, f64[128]{0}) tuple(add.1425, get-tuple-element.1422, get-tuple-element.1423, get-tuple-element.1424)
}

region_2.1427 {
  arg_tuple.1428 = (s64[], f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) parameter(0)
  get-tuple-element.1430 = f64[128,128]{1,0} get-tuple-element(arg_tuple.1428), index=1
  get-tuple-element.1431 = f64[128]{0} get-tuple-element(arg_tuple.1428), index=2
  get-tuple-element.1432 = f64[128]{0} get-tuple-element(arg_tuple.1428), index=3
  get-tuple-element.1429 = s64[] get-tuple-element(arg_tuple.1428), index=0
  constant.1433 = s64[] constant(1000)
  ROOT compare.1434 = pred[] compare(get-tuple-element.1429, constant.1433), direction=LT
}

ENTRY main.1443 {
  constant.13 = s64[] constant(0)
  Arg_6.7 = f64[128,128]{1,0} parameter(6)
  Arg_4.5 = f64[128]{0} parameter(4)
  Arg_5.6 = f64[128]{0} parameter(5)
  tuple.14 = (s64[], f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) tuple(constant.13, Arg_6.7, Arg_4.5, Arg_5.6)
  while.1435 = (s64[], f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) while(tuple.14), condition=region_2.1427, body=region_0.1411
  get-tuple-element.1436 = s64[] get-tuple-element(while.1435), index=0
  Arg_0.1 = f64[128]{0} parameter(0)
  Arg_1.2 = f64[128]{0} parameter(1)
  Arg_2.3 = f64[65]{0} parameter(2)
  Arg_3.4 = s32[6]{0} parameter(3)
  get-tuple-element.1438 = f64[128]{0} get-tuple-element(while.1435), index=2
  get-tuple-element.1439 = f64[128]{0} get-tuple-element(while.1435), index=3
  get-tuple-element.1437 = f64[128,128]{1,0} get-tuple-element(while.1435), index=1
  Arg_7.8 = f64[128]{0} parameter(7)
  Arg_8.9 = f64[] parameter(8)
  constant.11 = f64[] constant(50)
  add.1440 = f64[] add(Arg_8.9, constant.11)
  Arg_9.10 = s64[] parameter(9)
  constant.12 = s64[] constant(1000)
  add.1441 = s64[] add(Arg_9.10, constant.12)
  ROOT tuple.1442 = (f64[128]{0}, f64[128]{0}, f64[65]{0}, s32[6]{0}, f64[128]{0}, /*index=5*/f64[128]{0}, f64[128,128]{1,0}, f64[128]{0}, f64[], s64[]) tuple(Arg_0.1, Arg_1.2, Arg_2.3, Arg_3.4, get-tuple-element.1438, get-tuple-element.1439, get-tuple-element.1437, Arg_7.8, add.1440, add.1441)
}

