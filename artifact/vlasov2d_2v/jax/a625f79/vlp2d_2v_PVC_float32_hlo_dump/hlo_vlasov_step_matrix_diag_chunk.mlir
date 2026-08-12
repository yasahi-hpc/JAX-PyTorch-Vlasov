HloModule jit_run_chunk, entry_computation_layout={(f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[], /*index=5*/s32[])->(f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,1]{1,0}, /*index=5*/f32[1,17]{1,0}, f32[32,17]{1,0}, s32[6]{0}, f32[32,32]{1,0}, f32[32,32]{1,0}, /*index=10*/f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[], s32[])}

_where.17 {
  Arg_0.18 = pred[] parameter(0)
  Arg_1.19 = s32[] parameter(1)
  Arg_2.20 = s32[] parameter(2)
  ROOT select.21 = s32[] select(Arg_0.18, Arg_1.19, Arg_2.20)
}

remainder.22 {
  Arg_0.23 = s32[32768]{0} parameter(0)
  Arg_1.24 = s32[] parameter(1)
  constant.28 = s32[] constant(0)
  compare.29 = pred[] compare(Arg_1.24, constant.28), direction=EQ
  constant.27 = s32[] constant(1)
  call.30 = s32[] call(compare.29, constant.27, Arg_1.24), to_apply=_where.17
  broadcast.31 = s32[32768]{0} broadcast(call.30), dimensions={}
  remainder.32 = s32[32768]{0} remainder(Arg_0.23, broadcast.31)
  constant.25 = s32[] constant(0)
  broadcast.26 = s32[32768]{0} broadcast(constant.25), dimensions={}
  compare.34 = pred[32768]{0} compare(remainder.32, broadcast.26), direction=LT
  compare.35 = pred[] compare(call.30, constant.28), direction=LT
  broadcast.36 = pred[32768]{0} broadcast(compare.35), dimensions={}
  compare.37 = pred[32768]{0} compare(compare.34, broadcast.36), direction=NE
  compare.33 = pred[32768]{0} compare(remainder.32, broadcast.26), direction=NE
  and.38 = pred[32768]{0} and(compare.37, compare.33)
  broadcast.39 = s32[32768]{0} broadcast(call.30), dimensions={}
  add.40 = s32[32768]{0} add(remainder.32, broadcast.39)
  ROOT select.41 = s32[32768]{0} select(and.38, add.40, remainder.32)
}

_roll_dynamic.42 {
  Arg_0.43 = f32[32768,32]{1,0} parameter(0)
  concatenate.53 = f32[32768,64]{1,0} concatenate(Arg_0.43, Arg_0.43), dimensions={1}
  constant.49 = s32[] constant(32)
  broadcast.50 = s32[32768]{0} broadcast(constant.49), dimensions={}
  Arg_1.44 = s32[32768]{0} parameter(1)
  constant.51 = s32[] constant(32)
  call.52 = s32[32768]{0} call(Arg_1.44, constant.51), to_apply=remainder.22
  subtract.54 = s32[32768]{0} subtract(broadcast.50, call.52)
  constant.47 = s32[] constant(0)
  broadcast.48 = s32[32768]{0} broadcast(constant.47), dimensions={}
  compare.55 = pred[32768]{0} compare(subtract.54, broadcast.48), direction=LT
  constant.45 = s32[] constant(64)
  broadcast.46 = s32[32768]{0} broadcast(constant.45), dimensions={}
  add.56 = s32[32768]{0} add(subtract.54, broadcast.46)
  select.57 = s32[32768]{0} select(compare.55, add.56, subtract.54)
  reshape.58 = s32[32768,1]{1,0} reshape(select.57)
  ROOT gather.59 = f32[32768,32]{1,0} gather(concatenate.53, reshape.58), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.60 {
  Arg_0.61 = pred[] parameter(0)
  Arg_1.62 = s32[] parameter(1)
  Arg_2.63 = s32[] parameter(2)
  ROOT select.64 = s32[] select(Arg_0.61, Arg_1.62, Arg_2.63)
}

remainder.65 {
  Arg_0.66 = s32[32768]{0} parameter(0)
  Arg_1.67 = s32[] parameter(1)
  constant.71 = s32[] constant(0)
  compare.72 = pred[] compare(Arg_1.67, constant.71), direction=EQ
  constant.70 = s32[] constant(1)
  call.73 = s32[] call(compare.72, constant.70, Arg_1.67), to_apply=_where.60
  broadcast.74 = s32[32768]{0} broadcast(call.73), dimensions={}
  remainder.75 = s32[32768]{0} remainder(Arg_0.66, broadcast.74)
  constant.68 = s32[] constant(0)
  broadcast.69 = s32[32768]{0} broadcast(constant.68), dimensions={}
  compare.77 = pred[32768]{0} compare(remainder.75, broadcast.69), direction=LT
  compare.78 = pred[] compare(call.73, constant.71), direction=LT
  broadcast.79 = pred[32768]{0} broadcast(compare.78), dimensions={}
  compare.80 = pred[32768]{0} compare(compare.77, broadcast.79), direction=NE
  compare.76 = pred[32768]{0} compare(remainder.75, broadcast.69), direction=NE
  and.81 = pred[32768]{0} and(compare.80, compare.76)
  broadcast.82 = s32[32768]{0} broadcast(call.73), dimensions={}
  add.83 = s32[32768]{0} add(remainder.75, broadcast.82)
  ROOT select.84 = s32[32768]{0} select(and.81, add.83, remainder.75)
}

_roll_dynamic.85 {
  Arg_0.86 = f32[32768,32]{1,0} parameter(0)
  concatenate.96 = f32[32768,64]{1,0} concatenate(Arg_0.86, Arg_0.86), dimensions={1}
  constant.92 = s32[] constant(32)
  broadcast.93 = s32[32768]{0} broadcast(constant.92), dimensions={}
  Arg_1.87 = s32[32768]{0} parameter(1)
  constant.94 = s32[] constant(32)
  call.95 = s32[32768]{0} call(Arg_1.87, constant.94), to_apply=remainder.65
  subtract.97 = s32[32768]{0} subtract(broadcast.93, call.95)
  constant.90 = s32[] constant(0)
  broadcast.91 = s32[32768]{0} broadcast(constant.90), dimensions={}
  compare.98 = pred[32768]{0} compare(subtract.97, broadcast.91), direction=LT
  constant.88 = s32[] constant(64)
  broadcast.89 = s32[32768]{0} broadcast(constant.88), dimensions={}
  add.99 = s32[32768]{0} add(subtract.97, broadcast.89)
  select.100 = s32[32768]{0} select(compare.98, add.99, subtract.97)
  reshape.101 = s32[32768,1]{1,0} reshape(select.100)
  ROOT gather.102 = f32[32768,32]{1,0} gather(concatenate.96, reshape.101), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.103 {
  Arg_0.104 = pred[] parameter(0)
  Arg_1.105 = s32[] parameter(1)
  Arg_2.106 = s32[] parameter(2)
  ROOT select.107 = s32[] select(Arg_0.104, Arg_1.105, Arg_2.106)
}

remainder.108 {
  Arg_0.109 = s32[32768]{0} parameter(0)
  Arg_1.110 = s32[] parameter(1)
  constant.114 = s32[] constant(0)
  compare.115 = pred[] compare(Arg_1.110, constant.114), direction=EQ
  constant.113 = s32[] constant(1)
  call.116 = s32[] call(compare.115, constant.113, Arg_1.110), to_apply=_where.103
  broadcast.117 = s32[32768]{0} broadcast(call.116), dimensions={}
  remainder.118 = s32[32768]{0} remainder(Arg_0.109, broadcast.117)
  constant.111 = s32[] constant(0)
  broadcast.112 = s32[32768]{0} broadcast(constant.111), dimensions={}
  compare.120 = pred[32768]{0} compare(remainder.118, broadcast.112), direction=LT
  compare.121 = pred[] compare(call.116, constant.114), direction=LT
  broadcast.122 = pred[32768]{0} broadcast(compare.121), dimensions={}
  compare.123 = pred[32768]{0} compare(compare.120, broadcast.122), direction=NE
  compare.119 = pred[32768]{0} compare(remainder.118, broadcast.112), direction=NE
  and.124 = pred[32768]{0} and(compare.123, compare.119)
  broadcast.125 = s32[32768]{0} broadcast(call.116), dimensions={}
  add.126 = s32[32768]{0} add(remainder.118, broadcast.125)
  ROOT select.127 = s32[32768]{0} select(and.124, add.126, remainder.118)
}

_roll_dynamic.128 {
  Arg_0.129 = f32[32768,32]{1,0} parameter(0)
  concatenate.139 = f32[32768,64]{1,0} concatenate(Arg_0.129, Arg_0.129), dimensions={1}
  constant.135 = s32[] constant(32)
  broadcast.136 = s32[32768]{0} broadcast(constant.135), dimensions={}
  Arg_1.130 = s32[32768]{0} parameter(1)
  constant.137 = s32[] constant(32)
  call.138 = s32[32768]{0} call(Arg_1.130, constant.137), to_apply=remainder.108
  subtract.140 = s32[32768]{0} subtract(broadcast.136, call.138)
  constant.133 = s32[] constant(0)
  broadcast.134 = s32[32768]{0} broadcast(constant.133), dimensions={}
  compare.141 = pred[32768]{0} compare(subtract.140, broadcast.134), direction=LT
  constant.131 = s32[] constant(64)
  broadcast.132 = s32[32768]{0} broadcast(constant.131), dimensions={}
  add.142 = s32[32768]{0} add(subtract.140, broadcast.132)
  select.143 = s32[32768]{0} select(compare.141, add.142, subtract.140)
  reshape.144 = s32[32768,1]{1,0} reshape(select.143)
  ROOT gather.145 = f32[32768,32]{1,0} gather(concatenate.139, reshape.144), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.146 {
  Arg_0.147 = pred[] parameter(0)
  Arg_1.148 = s32[] parameter(1)
  Arg_2.149 = s32[] parameter(2)
  ROOT select.150 = s32[] select(Arg_0.147, Arg_1.148, Arg_2.149)
}

remainder.151 {
  Arg_0.152 = s32[32768]{0} parameter(0)
  Arg_1.153 = s32[] parameter(1)
  constant.157 = s32[] constant(0)
  compare.158 = pred[] compare(Arg_1.153, constant.157), direction=EQ
  constant.156 = s32[] constant(1)
  call.159 = s32[] call(compare.158, constant.156, Arg_1.153), to_apply=_where.146
  broadcast.160 = s32[32768]{0} broadcast(call.159), dimensions={}
  remainder.161 = s32[32768]{0} remainder(Arg_0.152, broadcast.160)
  constant.154 = s32[] constant(0)
  broadcast.155 = s32[32768]{0} broadcast(constant.154), dimensions={}
  compare.163 = pred[32768]{0} compare(remainder.161, broadcast.155), direction=LT
  compare.164 = pred[] compare(call.159, constant.157), direction=LT
  broadcast.165 = pred[32768]{0} broadcast(compare.164), dimensions={}
  compare.166 = pred[32768]{0} compare(compare.163, broadcast.165), direction=NE
  compare.162 = pred[32768]{0} compare(remainder.161, broadcast.155), direction=NE
  and.167 = pred[32768]{0} and(compare.166, compare.162)
  broadcast.168 = s32[32768]{0} broadcast(call.159), dimensions={}
  add.169 = s32[32768]{0} add(remainder.161, broadcast.168)
  ROOT select.170 = s32[32768]{0} select(and.167, add.169, remainder.161)
}

_roll_dynamic.171 {
  Arg_0.172 = f32[32768,32]{1,0} parameter(0)
  concatenate.182 = f32[32768,64]{1,0} concatenate(Arg_0.172, Arg_0.172), dimensions={1}
  constant.178 = s32[] constant(32)
  broadcast.179 = s32[32768]{0} broadcast(constant.178), dimensions={}
  Arg_1.173 = s32[32768]{0} parameter(1)
  constant.180 = s32[] constant(32)
  call.181 = s32[32768]{0} call(Arg_1.173, constant.180), to_apply=remainder.151
  subtract.183 = s32[32768]{0} subtract(broadcast.179, call.181)
  constant.176 = s32[] constant(0)
  broadcast.177 = s32[32768]{0} broadcast(constant.176), dimensions={}
  compare.184 = pred[32768]{0} compare(subtract.183, broadcast.177), direction=LT
  constant.174 = s32[] constant(64)
  broadcast.175 = s32[32768]{0} broadcast(constant.174), dimensions={}
  add.185 = s32[32768]{0} add(subtract.183, broadcast.175)
  select.186 = s32[32768]{0} select(compare.184, add.185, subtract.183)
  reshape.187 = s32[32768,1]{1,0} reshape(select.186)
  ROOT gather.188 = f32[32768,32]{1,0} gather(concatenate.182, reshape.187), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.189 {
  Arg_0.190 = pred[] parameter(0)
  Arg_1.191 = s32[] parameter(1)
  Arg_2.192 = s32[] parameter(2)
  ROOT select.193 = s32[] select(Arg_0.190, Arg_1.191, Arg_2.192)
}

remainder.194 {
  Arg_0.195 = s32[32768]{0} parameter(0)
  Arg_1.196 = s32[] parameter(1)
  constant.200 = s32[] constant(0)
  compare.201 = pred[] compare(Arg_1.196, constant.200), direction=EQ
  constant.199 = s32[] constant(1)
  call.202 = s32[] call(compare.201, constant.199, Arg_1.196), to_apply=_where.189
  broadcast.203 = s32[32768]{0} broadcast(call.202), dimensions={}
  remainder.204 = s32[32768]{0} remainder(Arg_0.195, broadcast.203)
  constant.197 = s32[] constant(0)
  broadcast.198 = s32[32768]{0} broadcast(constant.197), dimensions={}
  compare.206 = pred[32768]{0} compare(remainder.204, broadcast.198), direction=LT
  compare.207 = pred[] compare(call.202, constant.200), direction=LT
  broadcast.208 = pred[32768]{0} broadcast(compare.207), dimensions={}
  compare.209 = pred[32768]{0} compare(compare.206, broadcast.208), direction=NE
  compare.205 = pred[32768]{0} compare(remainder.204, broadcast.198), direction=NE
  and.210 = pred[32768]{0} and(compare.209, compare.205)
  broadcast.211 = s32[32768]{0} broadcast(call.202), dimensions={}
  add.212 = s32[32768]{0} add(remainder.204, broadcast.211)
  ROOT select.213 = s32[32768]{0} select(and.210, add.212, remainder.204)
}

_roll_dynamic.214 {
  Arg_0.215 = f32[32768,32]{1,0} parameter(0)
  concatenate.225 = f32[32768,64]{1,0} concatenate(Arg_0.215, Arg_0.215), dimensions={1}
  constant.221 = s32[] constant(32)
  broadcast.222 = s32[32768]{0} broadcast(constant.221), dimensions={}
  Arg_1.216 = s32[32768]{0} parameter(1)
  constant.223 = s32[] constant(32)
  call.224 = s32[32768]{0} call(Arg_1.216, constant.223), to_apply=remainder.194
  subtract.226 = s32[32768]{0} subtract(broadcast.222, call.224)
  constant.219 = s32[] constant(0)
  broadcast.220 = s32[32768]{0} broadcast(constant.219), dimensions={}
  compare.227 = pred[32768]{0} compare(subtract.226, broadcast.220), direction=LT
  constant.217 = s32[] constant(64)
  broadcast.218 = s32[32768]{0} broadcast(constant.217), dimensions={}
  add.228 = s32[32768]{0} add(subtract.226, broadcast.218)
  select.229 = s32[32768]{0} select(compare.227, add.228, subtract.226)
  reshape.230 = s32[32768,1]{1,0} reshape(select.229)
  ROOT gather.231 = f32[32768,32]{1,0} gather(concatenate.225, reshape.230), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.232 {
  Arg_0.233 = pred[] parameter(0)
  Arg_1.234 = s32[] parameter(1)
  Arg_2.235 = s32[] parameter(2)
  ROOT select.236 = s32[] select(Arg_0.233, Arg_1.234, Arg_2.235)
}

remainder.237 {
  Arg_0.238 = s32[32768]{0} parameter(0)
  Arg_1.239 = s32[] parameter(1)
  constant.243 = s32[] constant(0)
  compare.244 = pred[] compare(Arg_1.239, constant.243), direction=EQ
  constant.242 = s32[] constant(1)
  call.245 = s32[] call(compare.244, constant.242, Arg_1.239), to_apply=_where.232
  broadcast.246 = s32[32768]{0} broadcast(call.245), dimensions={}
  remainder.247 = s32[32768]{0} remainder(Arg_0.238, broadcast.246)
  constant.240 = s32[] constant(0)
  broadcast.241 = s32[32768]{0} broadcast(constant.240), dimensions={}
  compare.249 = pred[32768]{0} compare(remainder.247, broadcast.241), direction=LT
  compare.250 = pred[] compare(call.245, constant.243), direction=LT
  broadcast.251 = pred[32768]{0} broadcast(compare.250), dimensions={}
  compare.252 = pred[32768]{0} compare(compare.249, broadcast.251), direction=NE
  compare.248 = pred[32768]{0} compare(remainder.247, broadcast.241), direction=NE
  and.253 = pred[32768]{0} and(compare.252, compare.248)
  broadcast.254 = s32[32768]{0} broadcast(call.245), dimensions={}
  add.255 = s32[32768]{0} add(remainder.247, broadcast.254)
  ROOT select.256 = s32[32768]{0} select(and.253, add.255, remainder.247)
}

_roll_dynamic.257 {
  Arg_0.258 = f32[32768,32]{1,0} parameter(0)
  concatenate.268 = f32[32768,64]{1,0} concatenate(Arg_0.258, Arg_0.258), dimensions={1}
  constant.264 = s32[] constant(32)
  broadcast.265 = s32[32768]{0} broadcast(constant.264), dimensions={}
  Arg_1.259 = s32[32768]{0} parameter(1)
  constant.266 = s32[] constant(32)
  call.267 = s32[32768]{0} call(Arg_1.259, constant.266), to_apply=remainder.237
  subtract.269 = s32[32768]{0} subtract(broadcast.265, call.267)
  constant.262 = s32[] constant(0)
  broadcast.263 = s32[32768]{0} broadcast(constant.262), dimensions={}
  compare.270 = pred[32768]{0} compare(subtract.269, broadcast.263), direction=LT
  constant.260 = s32[] constant(64)
  broadcast.261 = s32[32768]{0} broadcast(constant.260), dimensions={}
  add.271 = s32[32768]{0} add(subtract.269, broadcast.261)
  select.272 = s32[32768]{0} select(compare.270, add.271, subtract.269)
  reshape.273 = s32[32768,1]{1,0} reshape(select.272)
  ROOT gather.274 = f32[32768,32]{1,0} gather(concatenate.268, reshape.273), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.275 {
  Arg_0.276 = f32[32768,32]{1,0} parameter(0)
  Arg_1.277 = f32[32768]{0} parameter(1)
  Arg_2.278 = f32[] parameter(2)
  broadcast.305 = f32[32768]{0} broadcast(Arg_2.278), dimensions={}
  multiply.306 = f32[32768]{0} multiply(Arg_1.277, broadcast.305)
  Arg_3.279 = f32[] parameter(3)
  broadcast.307 = f32[32768]{0} broadcast(Arg_3.279), dimensions={}
  divide.308 = f32[32768]{0} divide(multiply.306, broadcast.307)
  floor.309 = f32[32768]{0} floor(divide.308)
  convert.311 = s32[32768]{0} convert(floor.309)
  Arg_4.280 = s32[6]{0} parameter(4)
  slice.374 = s32[1]{0} slice(Arg_4.280), slice={[0:1]}
  reshape.375 = s32[] reshape(slice.374)
  broadcast.376 = s32[32768]{0} broadcast(reshape.375), dimensions={}
  add.377 = s32[32768]{0} add(convert.311, broadcast.376)
  call.378 = f32[32768,32]{1,0} call(Arg_0.276, add.377), to_apply=_roll_dynamic.42
  subtract.310 = f32[32768]{0} subtract(divide.308, floor.309)
  constant.303 = f32[] constant(20)
  broadcast.304 = f32[32768]{0} broadcast(constant.303), dimensions={}
  divide.316 = f32[32768]{0} divide(subtract.310, broadcast.304)
  multiply.312 = f32[32768]{0} multiply(subtract.310, subtract.310)
  constant.301 = f32[] constant(24)
  broadcast.302 = f32[32768]{0} broadcast(constant.301), dimensions={}
  divide.317 = f32[32768]{0} divide(multiply.312, broadcast.302)
  subtract.318 = f32[32768]{0} subtract(divide.316, divide.317)
  multiply.313 = f32[32768]{0} multiply(multiply.312, subtract.310)
  divide.319 = f32[32768]{0} divide(multiply.313, broadcast.302)
  subtract.320 = f32[32768]{0} subtract(subtract.318, divide.319)
  multiply.314 = f32[32768]{0} multiply(multiply.313, subtract.310)
  divide.321 = f32[32768]{0} divide(multiply.314, broadcast.302)
  add.322 = f32[32768]{0} add(subtract.320, divide.321)
  multiply.315 = f32[32768]{0} multiply(multiply.314, subtract.310)
  constant.299 = f32[] constant(120)
  broadcast.300 = f32[32768]{0} broadcast(constant.299), dimensions={}
  divide.323 = f32[32768]{0} divide(multiply.315, broadcast.300)
  subtract.324 = f32[32768]{0} subtract(add.322, divide.323)
  reshape.379 = f32[32768,1]{1,0} reshape(subtract.324)
  broadcast.380 = f32[32768,1]{1,0} broadcast(reshape.379), dimensions={0,1}
  reshape.381 = f32[32768]{0} reshape(broadcast.380)
  broadcast.382 = f32[32768,32]{1,0} broadcast(reshape.381), dimensions={0}
  multiply.383 = f32[32768,32]{1,0} multiply(call.378, broadcast.382)
  slice.384 = s32[1]{0} slice(Arg_4.280), slice={[1:2]}
  reshape.385 = s32[] reshape(slice.384)
  broadcast.386 = s32[32768]{0} broadcast(reshape.385), dimensions={}
  add.387 = s32[32768]{0} add(convert.311, broadcast.386)
  call.388 = f32[32768,32]{1,0} call(Arg_0.276, add.387), to_apply=_roll_dynamic.85
  constant.297 = f32[] constant(2)
  broadcast.298 = f32[32768]{0} broadcast(constant.297), dimensions={}
  divide.325 = f32[32768]{0} divide(subtract.310, broadcast.298)
  negate.326 = f32[32768]{0} negate(divide.325)
  multiply.327 = f32[32768]{0} multiply(multiply.312, broadcast.298)
  constant.295 = f32[] constant(3)
  broadcast.296 = f32[32768]{0} broadcast(constant.295), dimensions={}
  divide.328 = f32[32768]{0} divide(multiply.327, broadcast.296)
  add.329 = f32[32768]{0} add(negate.326, divide.328)
  divide.330 = f32[32768]{0} divide(multiply.313, broadcast.302)
  subtract.331 = f32[32768]{0} subtract(add.329, divide.330)
  constant.293 = f32[] constant(6)
  broadcast.294 = f32[32768]{0} broadcast(constant.293), dimensions={}
  divide.332 = f32[32768]{0} divide(multiply.314, broadcast.294)
  subtract.333 = f32[32768]{0} subtract(subtract.331, divide.332)
  divide.334 = f32[32768]{0} divide(multiply.315, broadcast.302)
  add.335 = f32[32768]{0} add(subtract.333, divide.334)
  reshape.389 = f32[32768,1]{1,0} reshape(add.335)
  broadcast.390 = f32[32768,1]{1,0} broadcast(reshape.389), dimensions={0,1}
  reshape.391 = f32[32768]{0} reshape(broadcast.390)
  broadcast.392 = f32[32768,32]{1,0} broadcast(reshape.391), dimensions={0}
  multiply.393 = f32[32768,32]{1,0} multiply(call.388, broadcast.392)
  add.394 = f32[32768,32]{1,0} add(multiply.383, multiply.393)
  slice.395 = s32[1]{0} slice(Arg_4.280), slice={[2:3]}
  reshape.396 = s32[] reshape(slice.395)
  broadcast.397 = s32[32768]{0} broadcast(reshape.396), dimensions={}
  add.398 = s32[32768]{0} add(convert.311, broadcast.397)
  call.399 = f32[32768,32]{1,0} call(Arg_0.276, add.398), to_apply=_roll_dynamic.128
  constant.291 = f32[] constant(1)
  broadcast.292 = f32[32768]{0} broadcast(constant.291), dimensions={}
  divide.336 = f32[32768]{0} divide(subtract.310, broadcast.296)
  subtract.337 = f32[32768]{0} subtract(broadcast.292, divide.336)
  constant.289 = f32[] constant(5)
  broadcast.290 = f32[32768]{0} broadcast(constant.289), dimensions={}
  multiply.338 = f32[32768]{0} multiply(multiply.312, broadcast.290)
  constant.287 = f32[] constant(4)
  broadcast.288 = f32[32768]{0} broadcast(constant.287), dimensions={}
  divide.339 = f32[32768]{0} divide(multiply.338, broadcast.288)
  subtract.340 = f32[32768]{0} subtract(subtract.337, divide.339)
  multiply.341 = f32[32768]{0} multiply(multiply.313, broadcast.290)
  constant.285 = f32[] constant(12)
  broadcast.286 = f32[32768]{0} broadcast(constant.285), dimensions={}
  divide.342 = f32[32768]{0} divide(multiply.341, broadcast.286)
  add.343 = f32[32768]{0} add(subtract.340, divide.342)
  divide.344 = f32[32768]{0} divide(multiply.314, broadcast.288)
  add.345 = f32[32768]{0} add(add.343, divide.344)
  divide.346 = f32[32768]{0} divide(multiply.315, broadcast.286)
  subtract.347 = f32[32768]{0} subtract(add.345, divide.346)
  reshape.400 = f32[32768,1]{1,0} reshape(subtract.347)
  broadcast.401 = f32[32768,1]{1,0} broadcast(reshape.400), dimensions={0,1}
  reshape.402 = f32[32768]{0} reshape(broadcast.401)
  broadcast.403 = f32[32768,32]{1,0} broadcast(reshape.402), dimensions={0}
  multiply.404 = f32[32768,32]{1,0} multiply(call.399, broadcast.403)
  add.405 = f32[32768,32]{1,0} add(add.394, multiply.404)
  slice.406 = s32[1]{0} slice(Arg_4.280), slice={[3:4]}
  reshape.407 = s32[] reshape(slice.406)
  broadcast.408 = s32[32768]{0} broadcast(reshape.407), dimensions={}
  add.409 = s32[32768]{0} add(convert.311, broadcast.408)
  call.410 = f32[32768,32]{1,0} call(Arg_0.276, add.409), to_apply=_roll_dynamic.171
  multiply.348 = f32[32768]{0} multiply(multiply.312, broadcast.298)
  divide.349 = f32[32768]{0} divide(multiply.348, broadcast.296)
  add.350 = f32[32768]{0} add(subtract.310, divide.349)
  constant.283 = f32[] constant(7)
  broadcast.284 = f32[32768]{0} broadcast(constant.283), dimensions={}
  multiply.351 = f32[32768]{0} multiply(multiply.313, broadcast.284)
  divide.352 = f32[32768]{0} divide(multiply.351, broadcast.286)
  subtract.353 = f32[32768]{0} subtract(add.350, divide.352)
  divide.354 = f32[32768]{0} divide(multiply.314, broadcast.294)
  subtract.355 = f32[32768]{0} subtract(subtract.353, divide.354)
  divide.356 = f32[32768]{0} divide(multiply.315, broadcast.286)
  add.357 = f32[32768]{0} add(subtract.355, divide.356)
  reshape.411 = f32[32768,1]{1,0} reshape(add.357)
  broadcast.412 = f32[32768,1]{1,0} broadcast(reshape.411), dimensions={0,1}
  reshape.413 = f32[32768]{0} reshape(broadcast.412)
  broadcast.414 = f32[32768,32]{1,0} broadcast(reshape.413), dimensions={0}
  multiply.415 = f32[32768,32]{1,0} multiply(call.410, broadcast.414)
  add.416 = f32[32768,32]{1,0} add(add.405, multiply.415)
  slice.417 = s32[1]{0} slice(Arg_4.280), slice={[4:5]}
  reshape.418 = s32[] reshape(slice.417)
  broadcast.419 = s32[32768]{0} broadcast(reshape.418), dimensions={}
  add.420 = s32[32768]{0} add(convert.311, broadcast.419)
  call.421 = f32[32768,32]{1,0} call(Arg_0.276, add.420), to_apply=_roll_dynamic.214
  divide.358 = f32[32768]{0} divide(subtract.310, broadcast.288)
  negate.359 = f32[32768]{0} negate(divide.358)
  divide.360 = f32[32768]{0} divide(multiply.312, broadcast.302)
  subtract.361 = f32[32768]{0} subtract(negate.359, divide.360)
  multiply.362 = f32[32768]{0} multiply(multiply.313, broadcast.284)
  divide.363 = f32[32768]{0} divide(multiply.362, broadcast.302)
  add.364 = f32[32768]{0} add(subtract.361, divide.363)
  divide.365 = f32[32768]{0} divide(multiply.314, broadcast.302)
  add.366 = f32[32768]{0} add(add.364, divide.365)
  divide.367 = f32[32768]{0} divide(multiply.315, broadcast.302)
  subtract.368 = f32[32768]{0} subtract(add.366, divide.367)
  reshape.422 = f32[32768,1]{1,0} reshape(subtract.368)
  broadcast.423 = f32[32768,1]{1,0} broadcast(reshape.422), dimensions={0,1}
  reshape.424 = f32[32768]{0} reshape(broadcast.423)
  broadcast.425 = f32[32768,32]{1,0} broadcast(reshape.424), dimensions={0}
  multiply.426 = f32[32768,32]{1,0} multiply(call.421, broadcast.425)
  add.427 = f32[32768,32]{1,0} add(add.416, multiply.426)
  slice.428 = s32[1]{0} slice(Arg_4.280), slice={[5:6]}
  reshape.429 = s32[] reshape(slice.428)
  broadcast.430 = s32[32768]{0} broadcast(reshape.429), dimensions={}
  add.431 = s32[32768]{0} add(convert.311, broadcast.430)
  call.432 = f32[32768,32]{1,0} call(Arg_0.276, add.431), to_apply=_roll_dynamic.257
  constant.281 = f32[] constant(30)
  broadcast.282 = f32[32768]{0} broadcast(constant.281), dimensions={}
  divide.369 = f32[32768]{0} divide(subtract.310, broadcast.282)
  divide.370 = f32[32768]{0} divide(multiply.313, broadcast.302)
  subtract.371 = f32[32768]{0} subtract(divide.369, divide.370)
  divide.372 = f32[32768]{0} divide(multiply.315, broadcast.300)
  add.373 = f32[32768]{0} add(subtract.371, divide.372)
  reshape.433 = f32[32768,1]{1,0} reshape(add.373)
  broadcast.434 = f32[32768,1]{1,0} broadcast(reshape.433), dimensions={0,1}
  reshape.435 = f32[32768]{0} reshape(broadcast.434)
  broadcast.436 = f32[32768,32]{1,0} broadcast(reshape.435), dimensions={0}
  multiply.437 = f32[32768,32]{1,0} multiply(call.432, broadcast.436)
  ROOT add.438 = f32[32768,32]{1,0} add(add.427, multiply.437)
}

_where.439 {
  Arg_0.440 = pred[] parameter(0)
  Arg_1.441 = s32[] parameter(1)
  Arg_2.442 = s32[] parameter(2)
  ROOT select.443 = s32[] select(Arg_0.440, Arg_1.441, Arg_2.442)
}

remainder.444 {
  Arg_0.445 = s32[32768]{0} parameter(0)
  Arg_1.446 = s32[] parameter(1)
  constant.450 = s32[] constant(0)
  compare.451 = pred[] compare(Arg_1.446, constant.450), direction=EQ
  constant.449 = s32[] constant(1)
  call.452 = s32[] call(compare.451, constant.449, Arg_1.446), to_apply=_where.439
  broadcast.453 = s32[32768]{0} broadcast(call.452), dimensions={}
  remainder.454 = s32[32768]{0} remainder(Arg_0.445, broadcast.453)
  constant.447 = s32[] constant(0)
  broadcast.448 = s32[32768]{0} broadcast(constant.447), dimensions={}
  compare.456 = pred[32768]{0} compare(remainder.454, broadcast.448), direction=LT
  compare.457 = pred[] compare(call.452, constant.450), direction=LT
  broadcast.458 = pred[32768]{0} broadcast(compare.457), dimensions={}
  compare.459 = pred[32768]{0} compare(compare.456, broadcast.458), direction=NE
  compare.455 = pred[32768]{0} compare(remainder.454, broadcast.448), direction=NE
  and.460 = pred[32768]{0} and(compare.459, compare.455)
  broadcast.461 = s32[32768]{0} broadcast(call.452), dimensions={}
  add.462 = s32[32768]{0} add(remainder.454, broadcast.461)
  ROOT select.463 = s32[32768]{0} select(and.460, add.462, remainder.454)
}

_roll_dynamic.464 {
  Arg_0.465 = f32[32768,32]{1,0} parameter(0)
  concatenate.475 = f32[32768,64]{1,0} concatenate(Arg_0.465, Arg_0.465), dimensions={1}
  constant.471 = s32[] constant(32)
  broadcast.472 = s32[32768]{0} broadcast(constant.471), dimensions={}
  Arg_1.466 = s32[32768]{0} parameter(1)
  constant.473 = s32[] constant(32)
  call.474 = s32[32768]{0} call(Arg_1.466, constant.473), to_apply=remainder.444
  subtract.476 = s32[32768]{0} subtract(broadcast.472, call.474)
  constant.469 = s32[] constant(0)
  broadcast.470 = s32[32768]{0} broadcast(constant.469), dimensions={}
  compare.477 = pred[32768]{0} compare(subtract.476, broadcast.470), direction=LT
  constant.467 = s32[] constant(64)
  broadcast.468 = s32[32768]{0} broadcast(constant.467), dimensions={}
  add.478 = s32[32768]{0} add(subtract.476, broadcast.468)
  select.479 = s32[32768]{0} select(compare.477, add.478, subtract.476)
  reshape.480 = s32[32768,1]{1,0} reshape(select.479)
  ROOT gather.481 = f32[32768,32]{1,0} gather(concatenate.475, reshape.480), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.482 {
  Arg_0.483 = pred[] parameter(0)
  Arg_1.484 = s32[] parameter(1)
  Arg_2.485 = s32[] parameter(2)
  ROOT select.486 = s32[] select(Arg_0.483, Arg_1.484, Arg_2.485)
}

remainder.487 {
  Arg_0.488 = s32[32768]{0} parameter(0)
  Arg_1.489 = s32[] parameter(1)
  constant.493 = s32[] constant(0)
  compare.494 = pred[] compare(Arg_1.489, constant.493), direction=EQ
  constant.492 = s32[] constant(1)
  call.495 = s32[] call(compare.494, constant.492, Arg_1.489), to_apply=_where.482
  broadcast.496 = s32[32768]{0} broadcast(call.495), dimensions={}
  remainder.497 = s32[32768]{0} remainder(Arg_0.488, broadcast.496)
  constant.490 = s32[] constant(0)
  broadcast.491 = s32[32768]{0} broadcast(constant.490), dimensions={}
  compare.499 = pred[32768]{0} compare(remainder.497, broadcast.491), direction=LT
  compare.500 = pred[] compare(call.495, constant.493), direction=LT
  broadcast.501 = pred[32768]{0} broadcast(compare.500), dimensions={}
  compare.502 = pred[32768]{0} compare(compare.499, broadcast.501), direction=NE
  compare.498 = pred[32768]{0} compare(remainder.497, broadcast.491), direction=NE
  and.503 = pred[32768]{0} and(compare.502, compare.498)
  broadcast.504 = s32[32768]{0} broadcast(call.495), dimensions={}
  add.505 = s32[32768]{0} add(remainder.497, broadcast.504)
  ROOT select.506 = s32[32768]{0} select(and.503, add.505, remainder.497)
}

_roll_dynamic.507 {
  Arg_0.508 = f32[32768,32]{1,0} parameter(0)
  concatenate.518 = f32[32768,64]{1,0} concatenate(Arg_0.508, Arg_0.508), dimensions={1}
  constant.514 = s32[] constant(32)
  broadcast.515 = s32[32768]{0} broadcast(constant.514), dimensions={}
  Arg_1.509 = s32[32768]{0} parameter(1)
  constant.516 = s32[] constant(32)
  call.517 = s32[32768]{0} call(Arg_1.509, constant.516), to_apply=remainder.487
  subtract.519 = s32[32768]{0} subtract(broadcast.515, call.517)
  constant.512 = s32[] constant(0)
  broadcast.513 = s32[32768]{0} broadcast(constant.512), dimensions={}
  compare.520 = pred[32768]{0} compare(subtract.519, broadcast.513), direction=LT
  constant.510 = s32[] constant(64)
  broadcast.511 = s32[32768]{0} broadcast(constant.510), dimensions={}
  add.521 = s32[32768]{0} add(subtract.519, broadcast.511)
  select.522 = s32[32768]{0} select(compare.520, add.521, subtract.519)
  reshape.523 = s32[32768,1]{1,0} reshape(select.522)
  ROOT gather.524 = f32[32768,32]{1,0} gather(concatenate.518, reshape.523), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.525 {
  Arg_0.526 = pred[] parameter(0)
  Arg_1.527 = s32[] parameter(1)
  Arg_2.528 = s32[] parameter(2)
  ROOT select.529 = s32[] select(Arg_0.526, Arg_1.527, Arg_2.528)
}

remainder.530 {
  Arg_0.531 = s32[32768]{0} parameter(0)
  Arg_1.532 = s32[] parameter(1)
  constant.536 = s32[] constant(0)
  compare.537 = pred[] compare(Arg_1.532, constant.536), direction=EQ
  constant.535 = s32[] constant(1)
  call.538 = s32[] call(compare.537, constant.535, Arg_1.532), to_apply=_where.525
  broadcast.539 = s32[32768]{0} broadcast(call.538), dimensions={}
  remainder.540 = s32[32768]{0} remainder(Arg_0.531, broadcast.539)
  constant.533 = s32[] constant(0)
  broadcast.534 = s32[32768]{0} broadcast(constant.533), dimensions={}
  compare.542 = pred[32768]{0} compare(remainder.540, broadcast.534), direction=LT
  compare.543 = pred[] compare(call.538, constant.536), direction=LT
  broadcast.544 = pred[32768]{0} broadcast(compare.543), dimensions={}
  compare.545 = pred[32768]{0} compare(compare.542, broadcast.544), direction=NE
  compare.541 = pred[32768]{0} compare(remainder.540, broadcast.534), direction=NE
  and.546 = pred[32768]{0} and(compare.545, compare.541)
  broadcast.547 = s32[32768]{0} broadcast(call.538), dimensions={}
  add.548 = s32[32768]{0} add(remainder.540, broadcast.547)
  ROOT select.549 = s32[32768]{0} select(and.546, add.548, remainder.540)
}

_roll_dynamic.550 {
  Arg_0.551 = f32[32768,32]{1,0} parameter(0)
  concatenate.561 = f32[32768,64]{1,0} concatenate(Arg_0.551, Arg_0.551), dimensions={1}
  constant.557 = s32[] constant(32)
  broadcast.558 = s32[32768]{0} broadcast(constant.557), dimensions={}
  Arg_1.552 = s32[32768]{0} parameter(1)
  constant.559 = s32[] constant(32)
  call.560 = s32[32768]{0} call(Arg_1.552, constant.559), to_apply=remainder.530
  subtract.562 = s32[32768]{0} subtract(broadcast.558, call.560)
  constant.555 = s32[] constant(0)
  broadcast.556 = s32[32768]{0} broadcast(constant.555), dimensions={}
  compare.563 = pred[32768]{0} compare(subtract.562, broadcast.556), direction=LT
  constant.553 = s32[] constant(64)
  broadcast.554 = s32[32768]{0} broadcast(constant.553), dimensions={}
  add.564 = s32[32768]{0} add(subtract.562, broadcast.554)
  select.565 = s32[32768]{0} select(compare.563, add.564, subtract.562)
  reshape.566 = s32[32768,1]{1,0} reshape(select.565)
  ROOT gather.567 = f32[32768,32]{1,0} gather(concatenate.561, reshape.566), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.568 {
  Arg_0.569 = pred[] parameter(0)
  Arg_1.570 = s32[] parameter(1)
  Arg_2.571 = s32[] parameter(2)
  ROOT select.572 = s32[] select(Arg_0.569, Arg_1.570, Arg_2.571)
}

remainder.573 {
  Arg_0.574 = s32[32768]{0} parameter(0)
  Arg_1.575 = s32[] parameter(1)
  constant.579 = s32[] constant(0)
  compare.580 = pred[] compare(Arg_1.575, constant.579), direction=EQ
  constant.578 = s32[] constant(1)
  call.581 = s32[] call(compare.580, constant.578, Arg_1.575), to_apply=_where.568
  broadcast.582 = s32[32768]{0} broadcast(call.581), dimensions={}
  remainder.583 = s32[32768]{0} remainder(Arg_0.574, broadcast.582)
  constant.576 = s32[] constant(0)
  broadcast.577 = s32[32768]{0} broadcast(constant.576), dimensions={}
  compare.585 = pred[32768]{0} compare(remainder.583, broadcast.577), direction=LT
  compare.586 = pred[] compare(call.581, constant.579), direction=LT
  broadcast.587 = pred[32768]{0} broadcast(compare.586), dimensions={}
  compare.588 = pred[32768]{0} compare(compare.585, broadcast.587), direction=NE
  compare.584 = pred[32768]{0} compare(remainder.583, broadcast.577), direction=NE
  and.589 = pred[32768]{0} and(compare.588, compare.584)
  broadcast.590 = s32[32768]{0} broadcast(call.581), dimensions={}
  add.591 = s32[32768]{0} add(remainder.583, broadcast.590)
  ROOT select.592 = s32[32768]{0} select(and.589, add.591, remainder.583)
}

_roll_dynamic.593 {
  Arg_0.594 = f32[32768,32]{1,0} parameter(0)
  concatenate.604 = f32[32768,64]{1,0} concatenate(Arg_0.594, Arg_0.594), dimensions={1}
  constant.600 = s32[] constant(32)
  broadcast.601 = s32[32768]{0} broadcast(constant.600), dimensions={}
  Arg_1.595 = s32[32768]{0} parameter(1)
  constant.602 = s32[] constant(32)
  call.603 = s32[32768]{0} call(Arg_1.595, constant.602), to_apply=remainder.573
  subtract.605 = s32[32768]{0} subtract(broadcast.601, call.603)
  constant.598 = s32[] constant(0)
  broadcast.599 = s32[32768]{0} broadcast(constant.598), dimensions={}
  compare.606 = pred[32768]{0} compare(subtract.605, broadcast.599), direction=LT
  constant.596 = s32[] constant(64)
  broadcast.597 = s32[32768]{0} broadcast(constant.596), dimensions={}
  add.607 = s32[32768]{0} add(subtract.605, broadcast.597)
  select.608 = s32[32768]{0} select(compare.606, add.607, subtract.605)
  reshape.609 = s32[32768,1]{1,0} reshape(select.608)
  ROOT gather.610 = f32[32768,32]{1,0} gather(concatenate.604, reshape.609), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.611 {
  Arg_0.612 = pred[] parameter(0)
  Arg_1.613 = s32[] parameter(1)
  Arg_2.614 = s32[] parameter(2)
  ROOT select.615 = s32[] select(Arg_0.612, Arg_1.613, Arg_2.614)
}

remainder.616 {
  Arg_0.617 = s32[32768]{0} parameter(0)
  Arg_1.618 = s32[] parameter(1)
  constant.622 = s32[] constant(0)
  compare.623 = pred[] compare(Arg_1.618, constant.622), direction=EQ
  constant.621 = s32[] constant(1)
  call.624 = s32[] call(compare.623, constant.621, Arg_1.618), to_apply=_where.611
  broadcast.625 = s32[32768]{0} broadcast(call.624), dimensions={}
  remainder.626 = s32[32768]{0} remainder(Arg_0.617, broadcast.625)
  constant.619 = s32[] constant(0)
  broadcast.620 = s32[32768]{0} broadcast(constant.619), dimensions={}
  compare.628 = pred[32768]{0} compare(remainder.626, broadcast.620), direction=LT
  compare.629 = pred[] compare(call.624, constant.622), direction=LT
  broadcast.630 = pred[32768]{0} broadcast(compare.629), dimensions={}
  compare.631 = pred[32768]{0} compare(compare.628, broadcast.630), direction=NE
  compare.627 = pred[32768]{0} compare(remainder.626, broadcast.620), direction=NE
  and.632 = pred[32768]{0} and(compare.631, compare.627)
  broadcast.633 = s32[32768]{0} broadcast(call.624), dimensions={}
  add.634 = s32[32768]{0} add(remainder.626, broadcast.633)
  ROOT select.635 = s32[32768]{0} select(and.632, add.634, remainder.626)
}

_roll_dynamic.636 {
  Arg_0.637 = f32[32768,32]{1,0} parameter(0)
  concatenate.647 = f32[32768,64]{1,0} concatenate(Arg_0.637, Arg_0.637), dimensions={1}
  constant.643 = s32[] constant(32)
  broadcast.644 = s32[32768]{0} broadcast(constant.643), dimensions={}
  Arg_1.638 = s32[32768]{0} parameter(1)
  constant.645 = s32[] constant(32)
  call.646 = s32[32768]{0} call(Arg_1.638, constant.645), to_apply=remainder.616
  subtract.648 = s32[32768]{0} subtract(broadcast.644, call.646)
  constant.641 = s32[] constant(0)
  broadcast.642 = s32[32768]{0} broadcast(constant.641), dimensions={}
  compare.649 = pred[32768]{0} compare(subtract.648, broadcast.642), direction=LT
  constant.639 = s32[] constant(64)
  broadcast.640 = s32[32768]{0} broadcast(constant.639), dimensions={}
  add.650 = s32[32768]{0} add(subtract.648, broadcast.640)
  select.651 = s32[32768]{0} select(compare.649, add.650, subtract.648)
  reshape.652 = s32[32768,1]{1,0} reshape(select.651)
  ROOT gather.653 = f32[32768,32]{1,0} gather(concatenate.647, reshape.652), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.654 {
  Arg_0.655 = pred[] parameter(0)
  Arg_1.656 = s32[] parameter(1)
  Arg_2.657 = s32[] parameter(2)
  ROOT select.658 = s32[] select(Arg_0.655, Arg_1.656, Arg_2.657)
}

remainder.659 {
  Arg_0.660 = s32[32768]{0} parameter(0)
  Arg_1.661 = s32[] parameter(1)
  constant.665 = s32[] constant(0)
  compare.666 = pred[] compare(Arg_1.661, constant.665), direction=EQ
  constant.664 = s32[] constant(1)
  call.667 = s32[] call(compare.666, constant.664, Arg_1.661), to_apply=_where.654
  broadcast.668 = s32[32768]{0} broadcast(call.667), dimensions={}
  remainder.669 = s32[32768]{0} remainder(Arg_0.660, broadcast.668)
  constant.662 = s32[] constant(0)
  broadcast.663 = s32[32768]{0} broadcast(constant.662), dimensions={}
  compare.671 = pred[32768]{0} compare(remainder.669, broadcast.663), direction=LT
  compare.672 = pred[] compare(call.667, constant.665), direction=LT
  broadcast.673 = pred[32768]{0} broadcast(compare.672), dimensions={}
  compare.674 = pred[32768]{0} compare(compare.671, broadcast.673), direction=NE
  compare.670 = pred[32768]{0} compare(remainder.669, broadcast.663), direction=NE
  and.675 = pred[32768]{0} and(compare.674, compare.670)
  broadcast.676 = s32[32768]{0} broadcast(call.667), dimensions={}
  add.677 = s32[32768]{0} add(remainder.669, broadcast.676)
  ROOT select.678 = s32[32768]{0} select(and.675, add.677, remainder.669)
}

_roll_dynamic.679 {
  Arg_0.680 = f32[32768,32]{1,0} parameter(0)
  concatenate.690 = f32[32768,64]{1,0} concatenate(Arg_0.680, Arg_0.680), dimensions={1}
  constant.686 = s32[] constant(32)
  broadcast.687 = s32[32768]{0} broadcast(constant.686), dimensions={}
  Arg_1.681 = s32[32768]{0} parameter(1)
  constant.688 = s32[] constant(32)
  call.689 = s32[32768]{0} call(Arg_1.681, constant.688), to_apply=remainder.659
  subtract.691 = s32[32768]{0} subtract(broadcast.687, call.689)
  constant.684 = s32[] constant(0)
  broadcast.685 = s32[32768]{0} broadcast(constant.684), dimensions={}
  compare.692 = pred[32768]{0} compare(subtract.691, broadcast.685), direction=LT
  constant.682 = s32[] constant(64)
  broadcast.683 = s32[32768]{0} broadcast(constant.682), dimensions={}
  add.693 = s32[32768]{0} add(subtract.691, broadcast.683)
  select.694 = s32[32768]{0} select(compare.692, add.693, subtract.691)
  reshape.695 = s32[32768,1]{1,0} reshape(select.694)
  ROOT gather.696 = f32[32768,32]{1,0} gather(concatenate.690, reshape.695), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.697 {
  Arg_0.698 = f32[32768,32]{1,0} parameter(0)
  Arg_1.699 = f32[32768]{0} parameter(1)
  Arg_2.700 = f32[] parameter(2)
  broadcast.727 = f32[32768]{0} broadcast(Arg_2.700), dimensions={}
  multiply.728 = f32[32768]{0} multiply(Arg_1.699, broadcast.727)
  Arg_3.701 = f32[] parameter(3)
  broadcast.729 = f32[32768]{0} broadcast(Arg_3.701), dimensions={}
  divide.730 = f32[32768]{0} divide(multiply.728, broadcast.729)
  floor.731 = f32[32768]{0} floor(divide.730)
  convert.733 = s32[32768]{0} convert(floor.731)
  Arg_4.702 = s32[6]{0} parameter(4)
  slice.796 = s32[1]{0} slice(Arg_4.702), slice={[0:1]}
  reshape.797 = s32[] reshape(slice.796)
  broadcast.798 = s32[32768]{0} broadcast(reshape.797), dimensions={}
  add.799 = s32[32768]{0} add(convert.733, broadcast.798)
  call.800 = f32[32768,32]{1,0} call(Arg_0.698, add.799), to_apply=_roll_dynamic.464
  subtract.732 = f32[32768]{0} subtract(divide.730, floor.731)
  constant.725 = f32[] constant(20)
  broadcast.726 = f32[32768]{0} broadcast(constant.725), dimensions={}
  divide.738 = f32[32768]{0} divide(subtract.732, broadcast.726)
  multiply.734 = f32[32768]{0} multiply(subtract.732, subtract.732)
  constant.723 = f32[] constant(24)
  broadcast.724 = f32[32768]{0} broadcast(constant.723), dimensions={}
  divide.739 = f32[32768]{0} divide(multiply.734, broadcast.724)
  subtract.740 = f32[32768]{0} subtract(divide.738, divide.739)
  multiply.735 = f32[32768]{0} multiply(multiply.734, subtract.732)
  divide.741 = f32[32768]{0} divide(multiply.735, broadcast.724)
  subtract.742 = f32[32768]{0} subtract(subtract.740, divide.741)
  multiply.736 = f32[32768]{0} multiply(multiply.735, subtract.732)
  divide.743 = f32[32768]{0} divide(multiply.736, broadcast.724)
  add.744 = f32[32768]{0} add(subtract.742, divide.743)
  multiply.737 = f32[32768]{0} multiply(multiply.736, subtract.732)
  constant.721 = f32[] constant(120)
  broadcast.722 = f32[32768]{0} broadcast(constant.721), dimensions={}
  divide.745 = f32[32768]{0} divide(multiply.737, broadcast.722)
  subtract.746 = f32[32768]{0} subtract(add.744, divide.745)
  reshape.801 = f32[32768,1]{1,0} reshape(subtract.746)
  broadcast.802 = f32[32768,1]{1,0} broadcast(reshape.801), dimensions={0,1}
  reshape.803 = f32[32768]{0} reshape(broadcast.802)
  broadcast.804 = f32[32768,32]{1,0} broadcast(reshape.803), dimensions={0}
  multiply.805 = f32[32768,32]{1,0} multiply(call.800, broadcast.804)
  slice.806 = s32[1]{0} slice(Arg_4.702), slice={[1:2]}
  reshape.807 = s32[] reshape(slice.806)
  broadcast.808 = s32[32768]{0} broadcast(reshape.807), dimensions={}
  add.809 = s32[32768]{0} add(convert.733, broadcast.808)
  call.810 = f32[32768,32]{1,0} call(Arg_0.698, add.809), to_apply=_roll_dynamic.507
  constant.719 = f32[] constant(2)
  broadcast.720 = f32[32768]{0} broadcast(constant.719), dimensions={}
  divide.747 = f32[32768]{0} divide(subtract.732, broadcast.720)
  negate.748 = f32[32768]{0} negate(divide.747)
  multiply.749 = f32[32768]{0} multiply(multiply.734, broadcast.720)
  constant.717 = f32[] constant(3)
  broadcast.718 = f32[32768]{0} broadcast(constant.717), dimensions={}
  divide.750 = f32[32768]{0} divide(multiply.749, broadcast.718)
  add.751 = f32[32768]{0} add(negate.748, divide.750)
  divide.752 = f32[32768]{0} divide(multiply.735, broadcast.724)
  subtract.753 = f32[32768]{0} subtract(add.751, divide.752)
  constant.715 = f32[] constant(6)
  broadcast.716 = f32[32768]{0} broadcast(constant.715), dimensions={}
  divide.754 = f32[32768]{0} divide(multiply.736, broadcast.716)
  subtract.755 = f32[32768]{0} subtract(subtract.753, divide.754)
  divide.756 = f32[32768]{0} divide(multiply.737, broadcast.724)
  add.757 = f32[32768]{0} add(subtract.755, divide.756)
  reshape.811 = f32[32768,1]{1,0} reshape(add.757)
  broadcast.812 = f32[32768,1]{1,0} broadcast(reshape.811), dimensions={0,1}
  reshape.813 = f32[32768]{0} reshape(broadcast.812)
  broadcast.814 = f32[32768,32]{1,0} broadcast(reshape.813), dimensions={0}
  multiply.815 = f32[32768,32]{1,0} multiply(call.810, broadcast.814)
  add.816 = f32[32768,32]{1,0} add(multiply.805, multiply.815)
  slice.817 = s32[1]{0} slice(Arg_4.702), slice={[2:3]}
  reshape.818 = s32[] reshape(slice.817)
  broadcast.819 = s32[32768]{0} broadcast(reshape.818), dimensions={}
  add.820 = s32[32768]{0} add(convert.733, broadcast.819)
  call.821 = f32[32768,32]{1,0} call(Arg_0.698, add.820), to_apply=_roll_dynamic.550
  constant.713 = f32[] constant(1)
  broadcast.714 = f32[32768]{0} broadcast(constant.713), dimensions={}
  divide.758 = f32[32768]{0} divide(subtract.732, broadcast.718)
  subtract.759 = f32[32768]{0} subtract(broadcast.714, divide.758)
  constant.711 = f32[] constant(5)
  broadcast.712 = f32[32768]{0} broadcast(constant.711), dimensions={}
  multiply.760 = f32[32768]{0} multiply(multiply.734, broadcast.712)
  constant.709 = f32[] constant(4)
  broadcast.710 = f32[32768]{0} broadcast(constant.709), dimensions={}
  divide.761 = f32[32768]{0} divide(multiply.760, broadcast.710)
  subtract.762 = f32[32768]{0} subtract(subtract.759, divide.761)
  multiply.763 = f32[32768]{0} multiply(multiply.735, broadcast.712)
  constant.707 = f32[] constant(12)
  broadcast.708 = f32[32768]{0} broadcast(constant.707), dimensions={}
  divide.764 = f32[32768]{0} divide(multiply.763, broadcast.708)
  add.765 = f32[32768]{0} add(subtract.762, divide.764)
  divide.766 = f32[32768]{0} divide(multiply.736, broadcast.710)
  add.767 = f32[32768]{0} add(add.765, divide.766)
  divide.768 = f32[32768]{0} divide(multiply.737, broadcast.708)
  subtract.769 = f32[32768]{0} subtract(add.767, divide.768)
  reshape.822 = f32[32768,1]{1,0} reshape(subtract.769)
  broadcast.823 = f32[32768,1]{1,0} broadcast(reshape.822), dimensions={0,1}
  reshape.824 = f32[32768]{0} reshape(broadcast.823)
  broadcast.825 = f32[32768,32]{1,0} broadcast(reshape.824), dimensions={0}
  multiply.826 = f32[32768,32]{1,0} multiply(call.821, broadcast.825)
  add.827 = f32[32768,32]{1,0} add(add.816, multiply.826)
  slice.828 = s32[1]{0} slice(Arg_4.702), slice={[3:4]}
  reshape.829 = s32[] reshape(slice.828)
  broadcast.830 = s32[32768]{0} broadcast(reshape.829), dimensions={}
  add.831 = s32[32768]{0} add(convert.733, broadcast.830)
  call.832 = f32[32768,32]{1,0} call(Arg_0.698, add.831), to_apply=_roll_dynamic.593
  multiply.770 = f32[32768]{0} multiply(multiply.734, broadcast.720)
  divide.771 = f32[32768]{0} divide(multiply.770, broadcast.718)
  add.772 = f32[32768]{0} add(subtract.732, divide.771)
  constant.705 = f32[] constant(7)
  broadcast.706 = f32[32768]{0} broadcast(constant.705), dimensions={}
  multiply.773 = f32[32768]{0} multiply(multiply.735, broadcast.706)
  divide.774 = f32[32768]{0} divide(multiply.773, broadcast.708)
  subtract.775 = f32[32768]{0} subtract(add.772, divide.774)
  divide.776 = f32[32768]{0} divide(multiply.736, broadcast.716)
  subtract.777 = f32[32768]{0} subtract(subtract.775, divide.776)
  divide.778 = f32[32768]{0} divide(multiply.737, broadcast.708)
  add.779 = f32[32768]{0} add(subtract.777, divide.778)
  reshape.833 = f32[32768,1]{1,0} reshape(add.779)
  broadcast.834 = f32[32768,1]{1,0} broadcast(reshape.833), dimensions={0,1}
  reshape.835 = f32[32768]{0} reshape(broadcast.834)
  broadcast.836 = f32[32768,32]{1,0} broadcast(reshape.835), dimensions={0}
  multiply.837 = f32[32768,32]{1,0} multiply(call.832, broadcast.836)
  add.838 = f32[32768,32]{1,0} add(add.827, multiply.837)
  slice.839 = s32[1]{0} slice(Arg_4.702), slice={[4:5]}
  reshape.840 = s32[] reshape(slice.839)
  broadcast.841 = s32[32768]{0} broadcast(reshape.840), dimensions={}
  add.842 = s32[32768]{0} add(convert.733, broadcast.841)
  call.843 = f32[32768,32]{1,0} call(Arg_0.698, add.842), to_apply=_roll_dynamic.636
  divide.780 = f32[32768]{0} divide(subtract.732, broadcast.710)
  negate.781 = f32[32768]{0} negate(divide.780)
  divide.782 = f32[32768]{0} divide(multiply.734, broadcast.724)
  subtract.783 = f32[32768]{0} subtract(negate.781, divide.782)
  multiply.784 = f32[32768]{0} multiply(multiply.735, broadcast.706)
  divide.785 = f32[32768]{0} divide(multiply.784, broadcast.724)
  add.786 = f32[32768]{0} add(subtract.783, divide.785)
  divide.787 = f32[32768]{0} divide(multiply.736, broadcast.724)
  add.788 = f32[32768]{0} add(add.786, divide.787)
  divide.789 = f32[32768]{0} divide(multiply.737, broadcast.724)
  subtract.790 = f32[32768]{0} subtract(add.788, divide.789)
  reshape.844 = f32[32768,1]{1,0} reshape(subtract.790)
  broadcast.845 = f32[32768,1]{1,0} broadcast(reshape.844), dimensions={0,1}
  reshape.846 = f32[32768]{0} reshape(broadcast.845)
  broadcast.847 = f32[32768,32]{1,0} broadcast(reshape.846), dimensions={0}
  multiply.848 = f32[32768,32]{1,0} multiply(call.843, broadcast.847)
  add.849 = f32[32768,32]{1,0} add(add.838, multiply.848)
  slice.850 = s32[1]{0} slice(Arg_4.702), slice={[5:6]}
  reshape.851 = s32[] reshape(slice.850)
  broadcast.852 = s32[32768]{0} broadcast(reshape.851), dimensions={}
  add.853 = s32[32768]{0} add(convert.733, broadcast.852)
  call.854 = f32[32768,32]{1,0} call(Arg_0.698, add.853), to_apply=_roll_dynamic.679
  constant.703 = f32[] constant(30)
  broadcast.704 = f32[32768]{0} broadcast(constant.703), dimensions={}
  divide.791 = f32[32768]{0} divide(subtract.732, broadcast.704)
  divide.792 = f32[32768]{0} divide(multiply.735, broadcast.724)
  subtract.793 = f32[32768]{0} subtract(divide.791, divide.792)
  divide.794 = f32[32768]{0} divide(multiply.737, broadcast.722)
  add.795 = f32[32768]{0} add(subtract.793, divide.794)
  reshape.855 = f32[32768,1]{1,0} reshape(add.795)
  broadcast.856 = f32[32768,1]{1,0} broadcast(reshape.855), dimensions={0,1}
  reshape.857 = f32[32768]{0} reshape(broadcast.856)
  broadcast.858 = f32[32768,32]{1,0} broadcast(reshape.857), dimensions={0}
  multiply.859 = f32[32768,32]{1,0} multiply(call.854, broadcast.858)
  ROOT add.860 = f32[32768,32]{1,0} add(add.849, multiply.859)
}

region_1.861 {
  Arg_0.862 = f32[] parameter(0)
  Arg_1.863 = f32[] parameter(1)
  ROOT add.864 = f32[] add(Arg_0.862, Arg_1.863)
}

fft.865 {
  Arg_0.866 = f32[32,32]{1,0} parameter(0)
  ROOT fft.867 = c64[32,17]{1,0} fft(Arg_0.866), fft_type=RFFT, fft_length={32,32}
}

fft_0.868 {
  Arg_0.869 = c64[32,17]{1,0} parameter(0)
  ROOT fft.870 = f32[32,32]{1,0} fft(Arg_0.869), fft_type=IRFFT, fft_length={32,32}
}

fft_0.871 {
  Arg_0.872 = c64[32,17]{1,0} parameter(0)
  ROOT fft.873 = f32[32,32]{1,0} fft(Arg_0.872), fft_type=IRFFT, fft_length={32,32}
}

fft_0.874 {
  Arg_0.875 = c64[32,17]{1,0} parameter(0)
  ROOT fft.876 = f32[32,32]{1,0} fft(Arg_0.875), fft_type=IRFFT, fft_length={32,32}
}

solve_poisson.877 {
  Arg_1.879 = f32[32,1]{1,0} parameter(1)
  convert.901 = c64[32,1]{1,0} convert(Arg_1.879)
  constant.886 = c64[] constant((-0, -1))
  broadcast.887 = c64[32,1]{1,0} broadcast(constant.886), dimensions={}
  multiply.902 = c64[32,1]{1,0} multiply(convert.901, broadcast.887)
  broadcast.903 = c64[32,1]{1,0} broadcast(multiply.902), dimensions={0,1}
  reshape.904 = c64[32]{0} reshape(broadcast.903)
  broadcast.905 = c64[32,17]{1,0} broadcast(reshape.904), dimensions={0}
  Arg_0.878 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  constant.890 = f32[] constant(0)
  reduce.891 = f32[32,32]{1,0} reduce(Arg_0.878, constant.890), dimensions={2,3}, to_apply=region_1.861
  Arg_4.882 = f32[] parameter(4)
  broadcast.892 = f32[32,32]{1,0} broadcast(Arg_4.882), dimensions={}
  multiply.893 = f32[32,32]{1,0} multiply(reduce.891, broadcast.892)
  Arg_5.883 = f32[] parameter(5)
  broadcast.894 = f32[32,32]{1,0} broadcast(Arg_5.883), dimensions={}
  multiply.895 = f32[32,32]{1,0} multiply(multiply.893, broadcast.894)
  constant.888 = f32[] constant(1)
  broadcast.889 = f32[32,32]{1,0} broadcast(constant.888), dimensions={}
  subtract.896 = f32[32,32]{1,0} subtract(multiply.895, broadcast.889)
  call.897 = c64[32,17]{1,0} call(subtract.896), to_apply=fft.865
  Arg_3.881 = f32[32,17]{1,0} parameter(3)
  convert.898 = c64[32,17]{1,0} convert(Arg_3.881)
  multiply.899 = c64[32,17]{1,0} multiply(call.897, convert.898)
  multiply.906 = c64[32,17]{1,0} multiply(broadcast.905, multiply.899)
  call.913 = f32[32,32]{1,0} call(multiply.906), to_apply=fft_0.871
  Arg_2.880 = f32[1,17]{1,0} parameter(2)
  convert.907 = c64[1,17]{1,0} convert(Arg_2.880)
  constant.884 = c64[] constant((-0, -1))
  broadcast.885 = c64[1,17]{1,0} broadcast(constant.884), dimensions={}
  multiply.908 = c64[1,17]{1,0} multiply(convert.907, broadcast.885)
  broadcast.909 = c64[1,17]{1,0} broadcast(multiply.908), dimensions={0,1}
  reshape.910 = c64[17]{0} reshape(broadcast.909)
  broadcast.911 = c64[32,17]{1,0} broadcast(reshape.910), dimensions={1}
  multiply.912 = c64[32,17]{1,0} multiply(broadcast.911, multiply.899)
  call.914 = f32[32,32]{1,0} call(multiply.912), to_apply=fft_0.874
  call.900 = f32[32,32]{1,0} call(multiply.899), to_apply=fft_0.868
  ROOT tuple.915 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(call.913, call.914, subtract.896, call.900)
}

_where_2.916 {
  Arg_0.917 = pred[6,32768,32]{2,1,0} parameter(0)
  Arg_1.918 = f32[6,32768,1]{2,1,0} parameter(1)
  broadcast.920 = f32[6,32768,1]{2,1,0} broadcast(Arg_1.918), dimensions={0,1,2}
  reshape.921 = f32[6,32768]{1,0} reshape(broadcast.920)
  broadcast.922 = f32[6,32768,32]{2,1,0} broadcast(reshape.921), dimensions={0,1}
  Arg_2.919 = f32[] parameter(2)
  broadcast.923 = f32[6,32768,32]{2,1,0} broadcast(Arg_2.919), dimensions={}
  ROOT select.924 = f32[6,32768,32]{2,1,0} select(Arg_0.917, broadcast.922, broadcast.923)
}

build_v_diag_weights.925 {
  iota.1027 = s32[32]{0} iota(), iota_dimension=0
  reshape.1037 = s32[1,1,32]{2,1,0} reshape(iota.1027)
  broadcast.1039 = s32[1,1,32]{2,1,0} broadcast(reshape.1037), dimensions={0,1,2}
  reshape.1040 = s32[32]{0} reshape(broadcast.1039)
  broadcast.1041 = s32[6,32768,32]{2,1,0} broadcast(reshape.1040), dimensions={2}
  Arg_0.926 = s32[6]{0} parameter(0)
  reshape.1028 = s32[6,1]{1,0} reshape(Arg_0.926)
  broadcast.1030 = s32[6,1]{1,0} broadcast(reshape.1028), dimensions={0,1}
  reshape.1031 = s32[6]{0} reshape(broadcast.1030)
  broadcast.1032 = s32[6,32768]{1,0} broadcast(reshape.1031), dimensions={0}
  Arg_1.927 = s32[32768]{0} parameter(1)
  reshape.1029 = s32[1,32768]{1,0} reshape(Arg_1.927)
  broadcast.1033 = s32[1,32768]{1,0} broadcast(reshape.1029), dimensions={0,1}
  reshape.1034 = s32[32768]{0} reshape(broadcast.1033)
  broadcast.1035 = s32[6,32768]{1,0} broadcast(reshape.1034), dimensions={1}
  add.1036 = s32[6,32768]{1,0} add(broadcast.1032, broadcast.1035)
  reshape.1038 = s32[6,32768,1]{2,1,0} reshape(add.1036)
  broadcast.1042 = s32[6,32768,1]{2,1,0} broadcast(reshape.1038), dimensions={0,1,2}
  reshape.1043 = s32[6,32768]{1,0} reshape(broadcast.1042)
  broadcast.1044 = s32[6,32768,32]{2,1,0} broadcast(reshape.1043), dimensions={0,1}
  subtract.1045 = s32[6,32768,32]{2,1,0} subtract(broadcast.1041, broadcast.1044)
  constant.931 = s32[] constant(0)
  broadcast.932 = s32[6,32768,32]{2,1,0} broadcast(constant.931), dimensions={}
  compare.1046 = pred[6,32768,32]{2,1,0} compare(subtract.1045, broadcast.932), direction=GE
  constant.929 = s32[] constant(32)
  broadcast.930 = s32[6,32768,32]{2,1,0} broadcast(constant.929), dimensions={}
  compare.1047 = pred[6,32768,32]{2,1,0} compare(subtract.1045, broadcast.930), direction=LT
  and.1048 = pred[6,32768,32]{2,1,0} and(compare.1046, compare.1047)
  Arg_2.928 = f32[32768]{0} parameter(2)
  constant.955 = f32[] constant(20)
  broadcast.956 = f32[32768]{0} broadcast(constant.955), dimensions={}
  divide.962 = f32[32768]{0} divide(Arg_2.928, broadcast.956)
  multiply.958 = f32[32768]{0} multiply(Arg_2.928, Arg_2.928)
  constant.953 = f32[] constant(24)
  broadcast.954 = f32[32768]{0} broadcast(constant.953), dimensions={}
  divide.963 = f32[32768]{0} divide(multiply.958, broadcast.954)
  subtract.964 = f32[32768]{0} subtract(divide.962, divide.963)
  multiply.959 = f32[32768]{0} multiply(multiply.958, Arg_2.928)
  divide.965 = f32[32768]{0} divide(multiply.959, broadcast.954)
  subtract.966 = f32[32768]{0} subtract(subtract.964, divide.965)
  multiply.960 = f32[32768]{0} multiply(multiply.959, Arg_2.928)
  divide.967 = f32[32768]{0} divide(multiply.960, broadcast.954)
  add.968 = f32[32768]{0} add(subtract.966, divide.967)
  multiply.961 = f32[32768]{0} multiply(multiply.960, Arg_2.928)
  constant.951 = f32[] constant(120)
  broadcast.952 = f32[32768]{0} broadcast(constant.951), dimensions={}
  divide.969 = f32[32768]{0} divide(multiply.961, broadcast.952)
  subtract.970 = f32[32768]{0} subtract(add.968, divide.969)
  reshape.1020 = f32[1,32768]{1,0} reshape(subtract.970)
  constant.949 = f32[] constant(2)
  broadcast.950 = f32[32768]{0} broadcast(constant.949), dimensions={}
  divide.971 = f32[32768]{0} divide(Arg_2.928, broadcast.950)
  negate.972 = f32[32768]{0} negate(divide.971)
  multiply.973 = f32[32768]{0} multiply(multiply.958, broadcast.950)
  constant.947 = f32[] constant(3)
  broadcast.948 = f32[32768]{0} broadcast(constant.947), dimensions={}
  divide.974 = f32[32768]{0} divide(multiply.973, broadcast.948)
  add.975 = f32[32768]{0} add(negate.972, divide.974)
  divide.976 = f32[32768]{0} divide(multiply.959, broadcast.954)
  subtract.977 = f32[32768]{0} subtract(add.975, divide.976)
  constant.945 = f32[] constant(6)
  broadcast.946 = f32[32768]{0} broadcast(constant.945), dimensions={}
  divide.978 = f32[32768]{0} divide(multiply.960, broadcast.946)
  subtract.979 = f32[32768]{0} subtract(subtract.977, divide.978)
  divide.980 = f32[32768]{0} divide(multiply.961, broadcast.954)
  add.981 = f32[32768]{0} add(subtract.979, divide.980)
  reshape.1021 = f32[1,32768]{1,0} reshape(add.981)
  constant.943 = f32[] constant(1)
  broadcast.944 = f32[32768]{0} broadcast(constant.943), dimensions={}
  divide.982 = f32[32768]{0} divide(Arg_2.928, broadcast.948)
  subtract.983 = f32[32768]{0} subtract(broadcast.944, divide.982)
  constant.941 = f32[] constant(5)
  broadcast.942 = f32[32768]{0} broadcast(constant.941), dimensions={}
  multiply.984 = f32[32768]{0} multiply(multiply.958, broadcast.942)
  constant.939 = f32[] constant(4)
  broadcast.940 = f32[32768]{0} broadcast(constant.939), dimensions={}
  divide.985 = f32[32768]{0} divide(multiply.984, broadcast.940)
  subtract.986 = f32[32768]{0} subtract(subtract.983, divide.985)
  multiply.987 = f32[32768]{0} multiply(multiply.959, broadcast.942)
  constant.937 = f32[] constant(12)
  broadcast.938 = f32[32768]{0} broadcast(constant.937), dimensions={}
  divide.988 = f32[32768]{0} divide(multiply.987, broadcast.938)
  add.989 = f32[32768]{0} add(subtract.986, divide.988)
  divide.990 = f32[32768]{0} divide(multiply.960, broadcast.940)
  add.991 = f32[32768]{0} add(add.989, divide.990)
  divide.992 = f32[32768]{0} divide(multiply.961, broadcast.938)
  subtract.993 = f32[32768]{0} subtract(add.991, divide.992)
  reshape.1022 = f32[1,32768]{1,0} reshape(subtract.993)
  multiply.994 = f32[32768]{0} multiply(multiply.958, broadcast.950)
  divide.995 = f32[32768]{0} divide(multiply.994, broadcast.948)
  add.996 = f32[32768]{0} add(Arg_2.928, divide.995)
  constant.935 = f32[] constant(7)
  broadcast.936 = f32[32768]{0} broadcast(constant.935), dimensions={}
  multiply.997 = f32[32768]{0} multiply(multiply.959, broadcast.936)
  divide.998 = f32[32768]{0} divide(multiply.997, broadcast.938)
  subtract.999 = f32[32768]{0} subtract(add.996, divide.998)
  divide.1000 = f32[32768]{0} divide(multiply.960, broadcast.946)
  subtract.1001 = f32[32768]{0} subtract(subtract.999, divide.1000)
  divide.1002 = f32[32768]{0} divide(multiply.961, broadcast.938)
  add.1003 = f32[32768]{0} add(subtract.1001, divide.1002)
  reshape.1023 = f32[1,32768]{1,0} reshape(add.1003)
  divide.1004 = f32[32768]{0} divide(Arg_2.928, broadcast.940)
  negate.1005 = f32[32768]{0} negate(divide.1004)
  divide.1006 = f32[32768]{0} divide(multiply.958, broadcast.954)
  subtract.1007 = f32[32768]{0} subtract(negate.1005, divide.1006)
  multiply.1008 = f32[32768]{0} multiply(multiply.959, broadcast.936)
  divide.1009 = f32[32768]{0} divide(multiply.1008, broadcast.954)
  add.1010 = f32[32768]{0} add(subtract.1007, divide.1009)
  divide.1011 = f32[32768]{0} divide(multiply.960, broadcast.954)
  add.1012 = f32[32768]{0} add(add.1010, divide.1011)
  divide.1013 = f32[32768]{0} divide(multiply.961, broadcast.954)
  subtract.1014 = f32[32768]{0} subtract(add.1012, divide.1013)
  reshape.1024 = f32[1,32768]{1,0} reshape(subtract.1014)
  constant.933 = f32[] constant(30)
  broadcast.934 = f32[32768]{0} broadcast(constant.933), dimensions={}
  divide.1015 = f32[32768]{0} divide(Arg_2.928, broadcast.934)
  divide.1016 = f32[32768]{0} divide(multiply.959, broadcast.954)
  subtract.1017 = f32[32768]{0} subtract(divide.1015, divide.1016)
  divide.1018 = f32[32768]{0} divide(multiply.961, broadcast.952)
  add.1019 = f32[32768]{0} add(subtract.1017, divide.1018)
  reshape.1025 = f32[1,32768]{1,0} reshape(add.1019)
  concatenate.1026 = f32[6,32768]{1,0} concatenate(reshape.1020, reshape.1021, reshape.1022, reshape.1023, reshape.1024, reshape.1025), dimensions={0}
  reshape.1049 = f32[6,32768,1]{2,1,0} reshape(concatenate.1026)
  constant.957 = f32[] constant(0)
  ROOT call.1050 = f32[6,32768,32]{2,1,0} call(and.1048, reshape.1049, constant.957), to_apply=_where_2.916
}

_where.1051 {
  Arg_0.1052 = pred[] parameter(0)
  Arg_1.1053 = s32[] parameter(1)
  Arg_2.1054 = s32[] parameter(2)
  ROOT select.1055 = s32[] select(Arg_0.1052, Arg_1.1053, Arg_2.1054)
}

remainder.1056 {
  Arg_0.1057 = s32[32768]{0} parameter(0)
  Arg_1.1058 = s32[] parameter(1)
  constant.1062 = s32[] constant(0)
  compare.1063 = pred[] compare(Arg_1.1058, constant.1062), direction=EQ
  constant.1061 = s32[] constant(1)
  call.1064 = s32[] call(compare.1063, constant.1061, Arg_1.1058), to_apply=_where.1051
  broadcast.1065 = s32[32768]{0} broadcast(call.1064), dimensions={}
  remainder.1066 = s32[32768]{0} remainder(Arg_0.1057, broadcast.1065)
  constant.1059 = s32[] constant(0)
  broadcast.1060 = s32[32768]{0} broadcast(constant.1059), dimensions={}
  compare.1068 = pred[32768]{0} compare(remainder.1066, broadcast.1060), direction=LT
  compare.1069 = pred[] compare(call.1064, constant.1062), direction=LT
  broadcast.1070 = pred[32768]{0} broadcast(compare.1069), dimensions={}
  compare.1071 = pred[32768]{0} compare(compare.1068, broadcast.1070), direction=NE
  compare.1067 = pred[32768]{0} compare(remainder.1066, broadcast.1060), direction=NE
  and.1072 = pred[32768]{0} and(compare.1071, compare.1067)
  broadcast.1073 = s32[32768]{0} broadcast(call.1064), dimensions={}
  add.1074 = s32[32768]{0} add(remainder.1066, broadcast.1073)
  ROOT select.1075 = s32[32768]{0} select(and.1072, add.1074, remainder.1066)
}

_roll_dynamic.1076 {
  Arg_0.1077 = f32[32768,32]{1,0} parameter(0)
  concatenate.1087 = f32[32768,64]{1,0} concatenate(Arg_0.1077, Arg_0.1077), dimensions={1}
  constant.1083 = s32[] constant(32)
  broadcast.1084 = s32[32768]{0} broadcast(constant.1083), dimensions={}
  Arg_1.1078 = s32[32768]{0} parameter(1)
  constant.1085 = s32[] constant(32)
  call.1086 = s32[32768]{0} call(Arg_1.1078, constant.1085), to_apply=remainder.1056
  subtract.1088 = s32[32768]{0} subtract(broadcast.1084, call.1086)
  constant.1081 = s32[] constant(0)
  broadcast.1082 = s32[32768]{0} broadcast(constant.1081), dimensions={}
  compare.1089 = pred[32768]{0} compare(subtract.1088, broadcast.1082), direction=LT
  constant.1079 = s32[] constant(64)
  broadcast.1080 = s32[32768]{0} broadcast(constant.1079), dimensions={}
  add.1090 = s32[32768]{0} add(subtract.1088, broadcast.1080)
  select.1091 = s32[32768]{0} select(compare.1089, add.1090, subtract.1088)
  reshape.1092 = s32[32768,1]{1,0} reshape(select.1091)
  ROOT gather.1093 = f32[32768,32]{1,0} gather(concatenate.1087, reshape.1092), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1094 {
  Arg_0.1095 = pred[] parameter(0)
  Arg_1.1096 = s32[] parameter(1)
  Arg_2.1097 = s32[] parameter(2)
  ROOT select.1098 = s32[] select(Arg_0.1095, Arg_1.1096, Arg_2.1097)
}

remainder.1099 {
  Arg_0.1100 = s32[32768]{0} parameter(0)
  Arg_1.1101 = s32[] parameter(1)
  constant.1105 = s32[] constant(0)
  compare.1106 = pred[] compare(Arg_1.1101, constant.1105), direction=EQ
  constant.1104 = s32[] constant(1)
  call.1107 = s32[] call(compare.1106, constant.1104, Arg_1.1101), to_apply=_where.1094
  broadcast.1108 = s32[32768]{0} broadcast(call.1107), dimensions={}
  remainder.1109 = s32[32768]{0} remainder(Arg_0.1100, broadcast.1108)
  constant.1102 = s32[] constant(0)
  broadcast.1103 = s32[32768]{0} broadcast(constant.1102), dimensions={}
  compare.1111 = pred[32768]{0} compare(remainder.1109, broadcast.1103), direction=LT
  compare.1112 = pred[] compare(call.1107, constant.1105), direction=LT
  broadcast.1113 = pred[32768]{0} broadcast(compare.1112), dimensions={}
  compare.1114 = pred[32768]{0} compare(compare.1111, broadcast.1113), direction=NE
  compare.1110 = pred[32768]{0} compare(remainder.1109, broadcast.1103), direction=NE
  and.1115 = pred[32768]{0} and(compare.1114, compare.1110)
  broadcast.1116 = s32[32768]{0} broadcast(call.1107), dimensions={}
  add.1117 = s32[32768]{0} add(remainder.1109, broadcast.1116)
  ROOT select.1118 = s32[32768]{0} select(and.1115, add.1117, remainder.1109)
}

_roll_dynamic.1119 {
  Arg_0.1120 = f32[32768,32]{1,0} parameter(0)
  concatenate.1130 = f32[32768,64]{1,0} concatenate(Arg_0.1120, Arg_0.1120), dimensions={1}
  constant.1126 = s32[] constant(32)
  broadcast.1127 = s32[32768]{0} broadcast(constant.1126), dimensions={}
  Arg_1.1121 = s32[32768]{0} parameter(1)
  constant.1128 = s32[] constant(32)
  call.1129 = s32[32768]{0} call(Arg_1.1121, constant.1128), to_apply=remainder.1099
  subtract.1131 = s32[32768]{0} subtract(broadcast.1127, call.1129)
  constant.1124 = s32[] constant(0)
  broadcast.1125 = s32[32768]{0} broadcast(constant.1124), dimensions={}
  compare.1132 = pred[32768]{0} compare(subtract.1131, broadcast.1125), direction=LT
  constant.1122 = s32[] constant(64)
  broadcast.1123 = s32[32768]{0} broadcast(constant.1122), dimensions={}
  add.1133 = s32[32768]{0} add(subtract.1131, broadcast.1123)
  select.1134 = s32[32768]{0} select(compare.1132, add.1133, subtract.1131)
  reshape.1135 = s32[32768,1]{1,0} reshape(select.1134)
  ROOT gather.1136 = f32[32768,32]{1,0} gather(concatenate.1130, reshape.1135), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1137 {
  Arg_0.1138 = pred[] parameter(0)
  Arg_1.1139 = s32[] parameter(1)
  Arg_2.1140 = s32[] parameter(2)
  ROOT select.1141 = s32[] select(Arg_0.1138, Arg_1.1139, Arg_2.1140)
}

remainder.1142 {
  Arg_0.1143 = s32[32768]{0} parameter(0)
  Arg_1.1144 = s32[] parameter(1)
  constant.1148 = s32[] constant(0)
  compare.1149 = pred[] compare(Arg_1.1144, constant.1148), direction=EQ
  constant.1147 = s32[] constant(1)
  call.1150 = s32[] call(compare.1149, constant.1147, Arg_1.1144), to_apply=_where.1137
  broadcast.1151 = s32[32768]{0} broadcast(call.1150), dimensions={}
  remainder.1152 = s32[32768]{0} remainder(Arg_0.1143, broadcast.1151)
  constant.1145 = s32[] constant(0)
  broadcast.1146 = s32[32768]{0} broadcast(constant.1145), dimensions={}
  compare.1154 = pred[32768]{0} compare(remainder.1152, broadcast.1146), direction=LT
  compare.1155 = pred[] compare(call.1150, constant.1148), direction=LT
  broadcast.1156 = pred[32768]{0} broadcast(compare.1155), dimensions={}
  compare.1157 = pred[32768]{0} compare(compare.1154, broadcast.1156), direction=NE
  compare.1153 = pred[32768]{0} compare(remainder.1152, broadcast.1146), direction=NE
  and.1158 = pred[32768]{0} and(compare.1157, compare.1153)
  broadcast.1159 = s32[32768]{0} broadcast(call.1150), dimensions={}
  add.1160 = s32[32768]{0} add(remainder.1152, broadcast.1159)
  ROOT select.1161 = s32[32768]{0} select(and.1158, add.1160, remainder.1152)
}

_roll_dynamic.1162 {
  Arg_0.1163 = f32[32768,32]{1,0} parameter(0)
  concatenate.1173 = f32[32768,64]{1,0} concatenate(Arg_0.1163, Arg_0.1163), dimensions={1}
  constant.1169 = s32[] constant(32)
  broadcast.1170 = s32[32768]{0} broadcast(constant.1169), dimensions={}
  Arg_1.1164 = s32[32768]{0} parameter(1)
  constant.1171 = s32[] constant(32)
  call.1172 = s32[32768]{0} call(Arg_1.1164, constant.1171), to_apply=remainder.1142
  subtract.1174 = s32[32768]{0} subtract(broadcast.1170, call.1172)
  constant.1167 = s32[] constant(0)
  broadcast.1168 = s32[32768]{0} broadcast(constant.1167), dimensions={}
  compare.1175 = pred[32768]{0} compare(subtract.1174, broadcast.1168), direction=LT
  constant.1165 = s32[] constant(64)
  broadcast.1166 = s32[32768]{0} broadcast(constant.1165), dimensions={}
  add.1176 = s32[32768]{0} add(subtract.1174, broadcast.1166)
  select.1177 = s32[32768]{0} select(compare.1175, add.1176, subtract.1174)
  reshape.1178 = s32[32768,1]{1,0} reshape(select.1177)
  ROOT gather.1179 = f32[32768,32]{1,0} gather(concatenate.1173, reshape.1178), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1180 {
  Arg_0.1181 = pred[] parameter(0)
  Arg_1.1182 = s32[] parameter(1)
  Arg_2.1183 = s32[] parameter(2)
  ROOT select.1184 = s32[] select(Arg_0.1181, Arg_1.1182, Arg_2.1183)
}

remainder.1185 {
  Arg_0.1186 = s32[32768]{0} parameter(0)
  Arg_1.1187 = s32[] parameter(1)
  constant.1191 = s32[] constant(0)
  compare.1192 = pred[] compare(Arg_1.1187, constant.1191), direction=EQ
  constant.1190 = s32[] constant(1)
  call.1193 = s32[] call(compare.1192, constant.1190, Arg_1.1187), to_apply=_where.1180
  broadcast.1194 = s32[32768]{0} broadcast(call.1193), dimensions={}
  remainder.1195 = s32[32768]{0} remainder(Arg_0.1186, broadcast.1194)
  constant.1188 = s32[] constant(0)
  broadcast.1189 = s32[32768]{0} broadcast(constant.1188), dimensions={}
  compare.1197 = pred[32768]{0} compare(remainder.1195, broadcast.1189), direction=LT
  compare.1198 = pred[] compare(call.1193, constant.1191), direction=LT
  broadcast.1199 = pred[32768]{0} broadcast(compare.1198), dimensions={}
  compare.1200 = pred[32768]{0} compare(compare.1197, broadcast.1199), direction=NE
  compare.1196 = pred[32768]{0} compare(remainder.1195, broadcast.1189), direction=NE
  and.1201 = pred[32768]{0} and(compare.1200, compare.1196)
  broadcast.1202 = s32[32768]{0} broadcast(call.1193), dimensions={}
  add.1203 = s32[32768]{0} add(remainder.1195, broadcast.1202)
  ROOT select.1204 = s32[32768]{0} select(and.1201, add.1203, remainder.1195)
}

_roll_dynamic.1205 {
  Arg_0.1206 = f32[32768,32]{1,0} parameter(0)
  concatenate.1216 = f32[32768,64]{1,0} concatenate(Arg_0.1206, Arg_0.1206), dimensions={1}
  constant.1212 = s32[] constant(32)
  broadcast.1213 = s32[32768]{0} broadcast(constant.1212), dimensions={}
  Arg_1.1207 = s32[32768]{0} parameter(1)
  constant.1214 = s32[] constant(32)
  call.1215 = s32[32768]{0} call(Arg_1.1207, constant.1214), to_apply=remainder.1185
  subtract.1217 = s32[32768]{0} subtract(broadcast.1213, call.1215)
  constant.1210 = s32[] constant(0)
  broadcast.1211 = s32[32768]{0} broadcast(constant.1210), dimensions={}
  compare.1218 = pred[32768]{0} compare(subtract.1217, broadcast.1211), direction=LT
  constant.1208 = s32[] constant(64)
  broadcast.1209 = s32[32768]{0} broadcast(constant.1208), dimensions={}
  add.1219 = s32[32768]{0} add(subtract.1217, broadcast.1209)
  select.1220 = s32[32768]{0} select(compare.1218, add.1219, subtract.1217)
  reshape.1221 = s32[32768,1]{1,0} reshape(select.1220)
  ROOT gather.1222 = f32[32768,32]{1,0} gather(concatenate.1216, reshape.1221), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1223 {
  Arg_0.1224 = pred[] parameter(0)
  Arg_1.1225 = s32[] parameter(1)
  Arg_2.1226 = s32[] parameter(2)
  ROOT select.1227 = s32[] select(Arg_0.1224, Arg_1.1225, Arg_2.1226)
}

remainder.1228 {
  Arg_0.1229 = s32[32768]{0} parameter(0)
  Arg_1.1230 = s32[] parameter(1)
  constant.1234 = s32[] constant(0)
  compare.1235 = pred[] compare(Arg_1.1230, constant.1234), direction=EQ
  constant.1233 = s32[] constant(1)
  call.1236 = s32[] call(compare.1235, constant.1233, Arg_1.1230), to_apply=_where.1223
  broadcast.1237 = s32[32768]{0} broadcast(call.1236), dimensions={}
  remainder.1238 = s32[32768]{0} remainder(Arg_0.1229, broadcast.1237)
  constant.1231 = s32[] constant(0)
  broadcast.1232 = s32[32768]{0} broadcast(constant.1231), dimensions={}
  compare.1240 = pred[32768]{0} compare(remainder.1238, broadcast.1232), direction=LT
  compare.1241 = pred[] compare(call.1236, constant.1234), direction=LT
  broadcast.1242 = pred[32768]{0} broadcast(compare.1241), dimensions={}
  compare.1243 = pred[32768]{0} compare(compare.1240, broadcast.1242), direction=NE
  compare.1239 = pred[32768]{0} compare(remainder.1238, broadcast.1232), direction=NE
  and.1244 = pred[32768]{0} and(compare.1243, compare.1239)
  broadcast.1245 = s32[32768]{0} broadcast(call.1236), dimensions={}
  add.1246 = s32[32768]{0} add(remainder.1238, broadcast.1245)
  ROOT select.1247 = s32[32768]{0} select(and.1244, add.1246, remainder.1238)
}

_roll_dynamic.1248 {
  Arg_0.1249 = f32[32768,32]{1,0} parameter(0)
  concatenate.1259 = f32[32768,64]{1,0} concatenate(Arg_0.1249, Arg_0.1249), dimensions={1}
  constant.1255 = s32[] constant(32)
  broadcast.1256 = s32[32768]{0} broadcast(constant.1255), dimensions={}
  Arg_1.1250 = s32[32768]{0} parameter(1)
  constant.1257 = s32[] constant(32)
  call.1258 = s32[32768]{0} call(Arg_1.1250, constant.1257), to_apply=remainder.1228
  subtract.1260 = s32[32768]{0} subtract(broadcast.1256, call.1258)
  constant.1253 = s32[] constant(0)
  broadcast.1254 = s32[32768]{0} broadcast(constant.1253), dimensions={}
  compare.1261 = pred[32768]{0} compare(subtract.1260, broadcast.1254), direction=LT
  constant.1251 = s32[] constant(64)
  broadcast.1252 = s32[32768]{0} broadcast(constant.1251), dimensions={}
  add.1262 = s32[32768]{0} add(subtract.1260, broadcast.1252)
  select.1263 = s32[32768]{0} select(compare.1261, add.1262, subtract.1260)
  reshape.1264 = s32[32768,1]{1,0} reshape(select.1263)
  ROOT gather.1265 = f32[32768,32]{1,0} gather(concatenate.1259, reshape.1264), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1266 {
  Arg_0.1267 = pred[] parameter(0)
  Arg_1.1268 = s32[] parameter(1)
  Arg_2.1269 = s32[] parameter(2)
  ROOT select.1270 = s32[] select(Arg_0.1267, Arg_1.1268, Arg_2.1269)
}

remainder.1271 {
  Arg_0.1272 = s32[32768]{0} parameter(0)
  Arg_1.1273 = s32[] parameter(1)
  constant.1277 = s32[] constant(0)
  compare.1278 = pred[] compare(Arg_1.1273, constant.1277), direction=EQ
  constant.1276 = s32[] constant(1)
  call.1279 = s32[] call(compare.1278, constant.1276, Arg_1.1273), to_apply=_where.1266
  broadcast.1280 = s32[32768]{0} broadcast(call.1279), dimensions={}
  remainder.1281 = s32[32768]{0} remainder(Arg_0.1272, broadcast.1280)
  constant.1274 = s32[] constant(0)
  broadcast.1275 = s32[32768]{0} broadcast(constant.1274), dimensions={}
  compare.1283 = pred[32768]{0} compare(remainder.1281, broadcast.1275), direction=LT
  compare.1284 = pred[] compare(call.1279, constant.1277), direction=LT
  broadcast.1285 = pred[32768]{0} broadcast(compare.1284), dimensions={}
  compare.1286 = pred[32768]{0} compare(compare.1283, broadcast.1285), direction=NE
  compare.1282 = pred[32768]{0} compare(remainder.1281, broadcast.1275), direction=NE
  and.1287 = pred[32768]{0} and(compare.1286, compare.1282)
  broadcast.1288 = s32[32768]{0} broadcast(call.1279), dimensions={}
  add.1289 = s32[32768]{0} add(remainder.1281, broadcast.1288)
  ROOT select.1290 = s32[32768]{0} select(and.1287, add.1289, remainder.1281)
}

_roll_dynamic.1291 {
  Arg_0.1292 = f32[32768,32]{1,0} parameter(0)
  concatenate.1302 = f32[32768,64]{1,0} concatenate(Arg_0.1292, Arg_0.1292), dimensions={1}
  constant.1298 = s32[] constant(32)
  broadcast.1299 = s32[32768]{0} broadcast(constant.1298), dimensions={}
  Arg_1.1293 = s32[32768]{0} parameter(1)
  constant.1300 = s32[] constant(32)
  call.1301 = s32[32768]{0} call(Arg_1.1293, constant.1300), to_apply=remainder.1271
  subtract.1303 = s32[32768]{0} subtract(broadcast.1299, call.1301)
  constant.1296 = s32[] constant(0)
  broadcast.1297 = s32[32768]{0} broadcast(constant.1296), dimensions={}
  compare.1304 = pred[32768]{0} compare(subtract.1303, broadcast.1297), direction=LT
  constant.1294 = s32[] constant(64)
  broadcast.1295 = s32[32768]{0} broadcast(constant.1294), dimensions={}
  add.1305 = s32[32768]{0} add(subtract.1303, broadcast.1295)
  select.1306 = s32[32768]{0} select(compare.1304, add.1305, subtract.1303)
  reshape.1307 = s32[32768,1]{1,0} reshape(select.1306)
  ROOT gather.1308 = f32[32768,32]{1,0} gather(concatenate.1302, reshape.1307), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag_1.1309 {
  Arg_4.1314 = s32[6]{0} parameter(4)
  Arg_1.1311 = f32[32768]{0} parameter(1)
  Arg_2.1312 = f32[] parameter(2)
  broadcast.1315 = f32[32768]{0} broadcast(Arg_2.1312), dimensions={}
  multiply.1316 = f32[32768]{0} multiply(Arg_1.1311, broadcast.1315)
  Arg_3.1313 = f32[] parameter(3)
  broadcast.1317 = f32[32768]{0} broadcast(Arg_3.1313), dimensions={}
  divide.1318 = f32[32768]{0} divide(multiply.1316, broadcast.1317)
  floor.1319 = f32[32768]{0} floor(divide.1318)
  convert.1321 = s32[32768]{0} convert(floor.1319)
  subtract.1320 = f32[32768]{0} subtract(divide.1318, floor.1319)
  call.1322 = f32[6,32768,32]{2,1,0} call(Arg_4.1314, convert.1321, subtract.1320), to_apply=build_v_diag_weights.925
  slice.1328 = f32[1,32768,32]{2,1,0} slice(call.1322), slice={[0:1], [0:32768], [0:32]}
  reshape.1329 = f32[32768,32]{1,0} reshape(slice.1328)
  Arg_0.1310 = f32[32768,32]{1,0} parameter(0)
  slice.1323 = s32[1]{0} slice(Arg_4.1314), slice={[0:1]}
  reshape.1324 = s32[] reshape(slice.1323)
  broadcast.1325 = s32[32768]{0} broadcast(reshape.1324), dimensions={}
  add.1326 = s32[32768]{0} add(convert.1321, broadcast.1325)
  call.1327 = f32[32768,32]{1,0} call(Arg_0.1310, add.1326), to_apply=_roll_dynamic.1076
  multiply.1330 = f32[32768,32]{1,0} multiply(reshape.1329, call.1327)
  slice.1336 = f32[1,32768,32]{2,1,0} slice(call.1322), slice={[1:2], [0:32768], [0:32]}
  reshape.1337 = f32[32768,32]{1,0} reshape(slice.1336)
  slice.1331 = s32[1]{0} slice(Arg_4.1314), slice={[1:2]}
  reshape.1332 = s32[] reshape(slice.1331)
  broadcast.1333 = s32[32768]{0} broadcast(reshape.1332), dimensions={}
  add.1334 = s32[32768]{0} add(convert.1321, broadcast.1333)
  call.1335 = f32[32768,32]{1,0} call(Arg_0.1310, add.1334), to_apply=_roll_dynamic.1119
  multiply.1338 = f32[32768,32]{1,0} multiply(reshape.1337, call.1335)
  add.1339 = f32[32768,32]{1,0} add(multiply.1330, multiply.1338)
  slice.1345 = f32[1,32768,32]{2,1,0} slice(call.1322), slice={[2:3], [0:32768], [0:32]}
  reshape.1346 = f32[32768,32]{1,0} reshape(slice.1345)
  slice.1340 = s32[1]{0} slice(Arg_4.1314), slice={[2:3]}
  reshape.1341 = s32[] reshape(slice.1340)
  broadcast.1342 = s32[32768]{0} broadcast(reshape.1341), dimensions={}
  add.1343 = s32[32768]{0} add(convert.1321, broadcast.1342)
  call.1344 = f32[32768,32]{1,0} call(Arg_0.1310, add.1343), to_apply=_roll_dynamic.1162
  multiply.1347 = f32[32768,32]{1,0} multiply(reshape.1346, call.1344)
  add.1348 = f32[32768,32]{1,0} add(add.1339, multiply.1347)
  slice.1354 = f32[1,32768,32]{2,1,0} slice(call.1322), slice={[3:4], [0:32768], [0:32]}
  reshape.1355 = f32[32768,32]{1,0} reshape(slice.1354)
  slice.1349 = s32[1]{0} slice(Arg_4.1314), slice={[3:4]}
  reshape.1350 = s32[] reshape(slice.1349)
  broadcast.1351 = s32[32768]{0} broadcast(reshape.1350), dimensions={}
  add.1352 = s32[32768]{0} add(convert.1321, broadcast.1351)
  call.1353 = f32[32768,32]{1,0} call(Arg_0.1310, add.1352), to_apply=_roll_dynamic.1205
  multiply.1356 = f32[32768,32]{1,0} multiply(reshape.1355, call.1353)
  add.1357 = f32[32768,32]{1,0} add(add.1348, multiply.1356)
  slice.1363 = f32[1,32768,32]{2,1,0} slice(call.1322), slice={[4:5], [0:32768], [0:32]}
  reshape.1364 = f32[32768,32]{1,0} reshape(slice.1363)
  slice.1358 = s32[1]{0} slice(Arg_4.1314), slice={[4:5]}
  reshape.1359 = s32[] reshape(slice.1358)
  broadcast.1360 = s32[32768]{0} broadcast(reshape.1359), dimensions={}
  add.1361 = s32[32768]{0} add(convert.1321, broadcast.1360)
  call.1362 = f32[32768,32]{1,0} call(Arg_0.1310, add.1361), to_apply=_roll_dynamic.1248
  multiply.1365 = f32[32768,32]{1,0} multiply(reshape.1364, call.1362)
  add.1366 = f32[32768,32]{1,0} add(add.1357, multiply.1365)
  slice.1372 = f32[1,32768,32]{2,1,0} slice(call.1322), slice={[5:6], [0:32768], [0:32]}
  reshape.1373 = f32[32768,32]{1,0} reshape(slice.1372)
  slice.1367 = s32[1]{0} slice(Arg_4.1314), slice={[5:6]}
  reshape.1368 = s32[] reshape(slice.1367)
  broadcast.1369 = s32[32768]{0} broadcast(reshape.1368), dimensions={}
  add.1370 = s32[32768]{0} add(convert.1321, broadcast.1369)
  call.1371 = f32[32768,32]{1,0} call(Arg_0.1310, add.1370), to_apply=_roll_dynamic.1291
  multiply.1374 = f32[32768,32]{1,0} multiply(reshape.1373, call.1371)
  ROOT add.1375 = f32[32768,32]{1,0} add(add.1366, multiply.1374)
}

_where_2.1376 {
  Arg_0.1377 = pred[6,32768,32]{2,1,0} parameter(0)
  Arg_1.1378 = f32[6,32768,1]{2,1,0} parameter(1)
  broadcast.1380 = f32[6,32768,1]{2,1,0} broadcast(Arg_1.1378), dimensions={0,1,2}
  reshape.1381 = f32[6,32768]{1,0} reshape(broadcast.1380)
  broadcast.1382 = f32[6,32768,32]{2,1,0} broadcast(reshape.1381), dimensions={0,1}
  Arg_2.1379 = f32[] parameter(2)
  broadcast.1383 = f32[6,32768,32]{2,1,0} broadcast(Arg_2.1379), dimensions={}
  ROOT select.1384 = f32[6,32768,32]{2,1,0} select(Arg_0.1377, broadcast.1382, broadcast.1383)
}

build_v_diag_weights.1385 {
  iota.1487 = s32[32]{0} iota(), iota_dimension=0
  reshape.1497 = s32[1,1,32]{2,1,0} reshape(iota.1487)
  broadcast.1499 = s32[1,1,32]{2,1,0} broadcast(reshape.1497), dimensions={0,1,2}
  reshape.1500 = s32[32]{0} reshape(broadcast.1499)
  broadcast.1501 = s32[6,32768,32]{2,1,0} broadcast(reshape.1500), dimensions={2}
  Arg_0.1386 = s32[6]{0} parameter(0)
  reshape.1488 = s32[6,1]{1,0} reshape(Arg_0.1386)
  broadcast.1490 = s32[6,1]{1,0} broadcast(reshape.1488), dimensions={0,1}
  reshape.1491 = s32[6]{0} reshape(broadcast.1490)
  broadcast.1492 = s32[6,32768]{1,0} broadcast(reshape.1491), dimensions={0}
  Arg_1.1387 = s32[32768]{0} parameter(1)
  reshape.1489 = s32[1,32768]{1,0} reshape(Arg_1.1387)
  broadcast.1493 = s32[1,32768]{1,0} broadcast(reshape.1489), dimensions={0,1}
  reshape.1494 = s32[32768]{0} reshape(broadcast.1493)
  broadcast.1495 = s32[6,32768]{1,0} broadcast(reshape.1494), dimensions={1}
  add.1496 = s32[6,32768]{1,0} add(broadcast.1492, broadcast.1495)
  reshape.1498 = s32[6,32768,1]{2,1,0} reshape(add.1496)
  broadcast.1502 = s32[6,32768,1]{2,1,0} broadcast(reshape.1498), dimensions={0,1,2}
  reshape.1503 = s32[6,32768]{1,0} reshape(broadcast.1502)
  broadcast.1504 = s32[6,32768,32]{2,1,0} broadcast(reshape.1503), dimensions={0,1}
  subtract.1505 = s32[6,32768,32]{2,1,0} subtract(broadcast.1501, broadcast.1504)
  constant.1391 = s32[] constant(0)
  broadcast.1392 = s32[6,32768,32]{2,1,0} broadcast(constant.1391), dimensions={}
  compare.1506 = pred[6,32768,32]{2,1,0} compare(subtract.1505, broadcast.1392), direction=GE
  constant.1389 = s32[] constant(32)
  broadcast.1390 = s32[6,32768,32]{2,1,0} broadcast(constant.1389), dimensions={}
  compare.1507 = pred[6,32768,32]{2,1,0} compare(subtract.1505, broadcast.1390), direction=LT
  and.1508 = pred[6,32768,32]{2,1,0} and(compare.1506, compare.1507)
  Arg_2.1388 = f32[32768]{0} parameter(2)
  constant.1415 = f32[] constant(20)
  broadcast.1416 = f32[32768]{0} broadcast(constant.1415), dimensions={}
  divide.1422 = f32[32768]{0} divide(Arg_2.1388, broadcast.1416)
  multiply.1418 = f32[32768]{0} multiply(Arg_2.1388, Arg_2.1388)
  constant.1413 = f32[] constant(24)
  broadcast.1414 = f32[32768]{0} broadcast(constant.1413), dimensions={}
  divide.1423 = f32[32768]{0} divide(multiply.1418, broadcast.1414)
  subtract.1424 = f32[32768]{0} subtract(divide.1422, divide.1423)
  multiply.1419 = f32[32768]{0} multiply(multiply.1418, Arg_2.1388)
  divide.1425 = f32[32768]{0} divide(multiply.1419, broadcast.1414)
  subtract.1426 = f32[32768]{0} subtract(subtract.1424, divide.1425)
  multiply.1420 = f32[32768]{0} multiply(multiply.1419, Arg_2.1388)
  divide.1427 = f32[32768]{0} divide(multiply.1420, broadcast.1414)
  add.1428 = f32[32768]{0} add(subtract.1426, divide.1427)
  multiply.1421 = f32[32768]{0} multiply(multiply.1420, Arg_2.1388)
  constant.1411 = f32[] constant(120)
  broadcast.1412 = f32[32768]{0} broadcast(constant.1411), dimensions={}
  divide.1429 = f32[32768]{0} divide(multiply.1421, broadcast.1412)
  subtract.1430 = f32[32768]{0} subtract(add.1428, divide.1429)
  reshape.1480 = f32[1,32768]{1,0} reshape(subtract.1430)
  constant.1409 = f32[] constant(2)
  broadcast.1410 = f32[32768]{0} broadcast(constant.1409), dimensions={}
  divide.1431 = f32[32768]{0} divide(Arg_2.1388, broadcast.1410)
  negate.1432 = f32[32768]{0} negate(divide.1431)
  multiply.1433 = f32[32768]{0} multiply(multiply.1418, broadcast.1410)
  constant.1407 = f32[] constant(3)
  broadcast.1408 = f32[32768]{0} broadcast(constant.1407), dimensions={}
  divide.1434 = f32[32768]{0} divide(multiply.1433, broadcast.1408)
  add.1435 = f32[32768]{0} add(negate.1432, divide.1434)
  divide.1436 = f32[32768]{0} divide(multiply.1419, broadcast.1414)
  subtract.1437 = f32[32768]{0} subtract(add.1435, divide.1436)
  constant.1405 = f32[] constant(6)
  broadcast.1406 = f32[32768]{0} broadcast(constant.1405), dimensions={}
  divide.1438 = f32[32768]{0} divide(multiply.1420, broadcast.1406)
  subtract.1439 = f32[32768]{0} subtract(subtract.1437, divide.1438)
  divide.1440 = f32[32768]{0} divide(multiply.1421, broadcast.1414)
  add.1441 = f32[32768]{0} add(subtract.1439, divide.1440)
  reshape.1481 = f32[1,32768]{1,0} reshape(add.1441)
  constant.1403 = f32[] constant(1)
  broadcast.1404 = f32[32768]{0} broadcast(constant.1403), dimensions={}
  divide.1442 = f32[32768]{0} divide(Arg_2.1388, broadcast.1408)
  subtract.1443 = f32[32768]{0} subtract(broadcast.1404, divide.1442)
  constant.1401 = f32[] constant(5)
  broadcast.1402 = f32[32768]{0} broadcast(constant.1401), dimensions={}
  multiply.1444 = f32[32768]{0} multiply(multiply.1418, broadcast.1402)
  constant.1399 = f32[] constant(4)
  broadcast.1400 = f32[32768]{0} broadcast(constant.1399), dimensions={}
  divide.1445 = f32[32768]{0} divide(multiply.1444, broadcast.1400)
  subtract.1446 = f32[32768]{0} subtract(subtract.1443, divide.1445)
  multiply.1447 = f32[32768]{0} multiply(multiply.1419, broadcast.1402)
  constant.1397 = f32[] constant(12)
  broadcast.1398 = f32[32768]{0} broadcast(constant.1397), dimensions={}
  divide.1448 = f32[32768]{0} divide(multiply.1447, broadcast.1398)
  add.1449 = f32[32768]{0} add(subtract.1446, divide.1448)
  divide.1450 = f32[32768]{0} divide(multiply.1420, broadcast.1400)
  add.1451 = f32[32768]{0} add(add.1449, divide.1450)
  divide.1452 = f32[32768]{0} divide(multiply.1421, broadcast.1398)
  subtract.1453 = f32[32768]{0} subtract(add.1451, divide.1452)
  reshape.1482 = f32[1,32768]{1,0} reshape(subtract.1453)
  multiply.1454 = f32[32768]{0} multiply(multiply.1418, broadcast.1410)
  divide.1455 = f32[32768]{0} divide(multiply.1454, broadcast.1408)
  add.1456 = f32[32768]{0} add(Arg_2.1388, divide.1455)
  constant.1395 = f32[] constant(7)
  broadcast.1396 = f32[32768]{0} broadcast(constant.1395), dimensions={}
  multiply.1457 = f32[32768]{0} multiply(multiply.1419, broadcast.1396)
  divide.1458 = f32[32768]{0} divide(multiply.1457, broadcast.1398)
  subtract.1459 = f32[32768]{0} subtract(add.1456, divide.1458)
  divide.1460 = f32[32768]{0} divide(multiply.1420, broadcast.1406)
  subtract.1461 = f32[32768]{0} subtract(subtract.1459, divide.1460)
  divide.1462 = f32[32768]{0} divide(multiply.1421, broadcast.1398)
  add.1463 = f32[32768]{0} add(subtract.1461, divide.1462)
  reshape.1483 = f32[1,32768]{1,0} reshape(add.1463)
  divide.1464 = f32[32768]{0} divide(Arg_2.1388, broadcast.1400)
  negate.1465 = f32[32768]{0} negate(divide.1464)
  divide.1466 = f32[32768]{0} divide(multiply.1418, broadcast.1414)
  subtract.1467 = f32[32768]{0} subtract(negate.1465, divide.1466)
  multiply.1468 = f32[32768]{0} multiply(multiply.1419, broadcast.1396)
  divide.1469 = f32[32768]{0} divide(multiply.1468, broadcast.1414)
  add.1470 = f32[32768]{0} add(subtract.1467, divide.1469)
  divide.1471 = f32[32768]{0} divide(multiply.1420, broadcast.1414)
  add.1472 = f32[32768]{0} add(add.1470, divide.1471)
  divide.1473 = f32[32768]{0} divide(multiply.1421, broadcast.1414)
  subtract.1474 = f32[32768]{0} subtract(add.1472, divide.1473)
  reshape.1484 = f32[1,32768]{1,0} reshape(subtract.1474)
  constant.1393 = f32[] constant(30)
  broadcast.1394 = f32[32768]{0} broadcast(constant.1393), dimensions={}
  divide.1475 = f32[32768]{0} divide(Arg_2.1388, broadcast.1394)
  divide.1476 = f32[32768]{0} divide(multiply.1419, broadcast.1414)
  subtract.1477 = f32[32768]{0} subtract(divide.1475, divide.1476)
  divide.1478 = f32[32768]{0} divide(multiply.1421, broadcast.1412)
  add.1479 = f32[32768]{0} add(subtract.1477, divide.1478)
  reshape.1485 = f32[1,32768]{1,0} reshape(add.1479)
  concatenate.1486 = f32[6,32768]{1,0} concatenate(reshape.1480, reshape.1481, reshape.1482, reshape.1483, reshape.1484, reshape.1485), dimensions={0}
  reshape.1509 = f32[6,32768,1]{2,1,0} reshape(concatenate.1486)
  constant.1417 = f32[] constant(0)
  ROOT call.1510 = f32[6,32768,32]{2,1,0} call(and.1508, reshape.1509, constant.1417), to_apply=_where_2.1376
}

_where.1511 {
  Arg_0.1512 = pred[] parameter(0)
  Arg_1.1513 = s32[] parameter(1)
  Arg_2.1514 = s32[] parameter(2)
  ROOT select.1515 = s32[] select(Arg_0.1512, Arg_1.1513, Arg_2.1514)
}

remainder.1516 {
  Arg_0.1517 = s32[32768]{0} parameter(0)
  Arg_1.1518 = s32[] parameter(1)
  constant.1522 = s32[] constant(0)
  compare.1523 = pred[] compare(Arg_1.1518, constant.1522), direction=EQ
  constant.1521 = s32[] constant(1)
  call.1524 = s32[] call(compare.1523, constant.1521, Arg_1.1518), to_apply=_where.1511
  broadcast.1525 = s32[32768]{0} broadcast(call.1524), dimensions={}
  remainder.1526 = s32[32768]{0} remainder(Arg_0.1517, broadcast.1525)
  constant.1519 = s32[] constant(0)
  broadcast.1520 = s32[32768]{0} broadcast(constant.1519), dimensions={}
  compare.1528 = pred[32768]{0} compare(remainder.1526, broadcast.1520), direction=LT
  compare.1529 = pred[] compare(call.1524, constant.1522), direction=LT
  broadcast.1530 = pred[32768]{0} broadcast(compare.1529), dimensions={}
  compare.1531 = pred[32768]{0} compare(compare.1528, broadcast.1530), direction=NE
  compare.1527 = pred[32768]{0} compare(remainder.1526, broadcast.1520), direction=NE
  and.1532 = pred[32768]{0} and(compare.1531, compare.1527)
  broadcast.1533 = s32[32768]{0} broadcast(call.1524), dimensions={}
  add.1534 = s32[32768]{0} add(remainder.1526, broadcast.1533)
  ROOT select.1535 = s32[32768]{0} select(and.1532, add.1534, remainder.1526)
}

_roll_dynamic.1536 {
  Arg_0.1537 = f32[32768,32]{1,0} parameter(0)
  concatenate.1547 = f32[32768,64]{1,0} concatenate(Arg_0.1537, Arg_0.1537), dimensions={1}
  constant.1543 = s32[] constant(32)
  broadcast.1544 = s32[32768]{0} broadcast(constant.1543), dimensions={}
  Arg_1.1538 = s32[32768]{0} parameter(1)
  constant.1545 = s32[] constant(32)
  call.1546 = s32[32768]{0} call(Arg_1.1538, constant.1545), to_apply=remainder.1516
  subtract.1548 = s32[32768]{0} subtract(broadcast.1544, call.1546)
  constant.1541 = s32[] constant(0)
  broadcast.1542 = s32[32768]{0} broadcast(constant.1541), dimensions={}
  compare.1549 = pred[32768]{0} compare(subtract.1548, broadcast.1542), direction=LT
  constant.1539 = s32[] constant(64)
  broadcast.1540 = s32[32768]{0} broadcast(constant.1539), dimensions={}
  add.1550 = s32[32768]{0} add(subtract.1548, broadcast.1540)
  select.1551 = s32[32768]{0} select(compare.1549, add.1550, subtract.1548)
  reshape.1552 = s32[32768,1]{1,0} reshape(select.1551)
  ROOT gather.1553 = f32[32768,32]{1,0} gather(concatenate.1547, reshape.1552), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1554 {
  Arg_0.1555 = pred[] parameter(0)
  Arg_1.1556 = s32[] parameter(1)
  Arg_2.1557 = s32[] parameter(2)
  ROOT select.1558 = s32[] select(Arg_0.1555, Arg_1.1556, Arg_2.1557)
}

remainder.1559 {
  Arg_0.1560 = s32[32768]{0} parameter(0)
  Arg_1.1561 = s32[] parameter(1)
  constant.1565 = s32[] constant(0)
  compare.1566 = pred[] compare(Arg_1.1561, constant.1565), direction=EQ
  constant.1564 = s32[] constant(1)
  call.1567 = s32[] call(compare.1566, constant.1564, Arg_1.1561), to_apply=_where.1554
  broadcast.1568 = s32[32768]{0} broadcast(call.1567), dimensions={}
  remainder.1569 = s32[32768]{0} remainder(Arg_0.1560, broadcast.1568)
  constant.1562 = s32[] constant(0)
  broadcast.1563 = s32[32768]{0} broadcast(constant.1562), dimensions={}
  compare.1571 = pred[32768]{0} compare(remainder.1569, broadcast.1563), direction=LT
  compare.1572 = pred[] compare(call.1567, constant.1565), direction=LT
  broadcast.1573 = pred[32768]{0} broadcast(compare.1572), dimensions={}
  compare.1574 = pred[32768]{0} compare(compare.1571, broadcast.1573), direction=NE
  compare.1570 = pred[32768]{0} compare(remainder.1569, broadcast.1563), direction=NE
  and.1575 = pred[32768]{0} and(compare.1574, compare.1570)
  broadcast.1576 = s32[32768]{0} broadcast(call.1567), dimensions={}
  add.1577 = s32[32768]{0} add(remainder.1569, broadcast.1576)
  ROOT select.1578 = s32[32768]{0} select(and.1575, add.1577, remainder.1569)
}

_roll_dynamic.1579 {
  Arg_0.1580 = f32[32768,32]{1,0} parameter(0)
  concatenate.1590 = f32[32768,64]{1,0} concatenate(Arg_0.1580, Arg_0.1580), dimensions={1}
  constant.1586 = s32[] constant(32)
  broadcast.1587 = s32[32768]{0} broadcast(constant.1586), dimensions={}
  Arg_1.1581 = s32[32768]{0} parameter(1)
  constant.1588 = s32[] constant(32)
  call.1589 = s32[32768]{0} call(Arg_1.1581, constant.1588), to_apply=remainder.1559
  subtract.1591 = s32[32768]{0} subtract(broadcast.1587, call.1589)
  constant.1584 = s32[] constant(0)
  broadcast.1585 = s32[32768]{0} broadcast(constant.1584), dimensions={}
  compare.1592 = pred[32768]{0} compare(subtract.1591, broadcast.1585), direction=LT
  constant.1582 = s32[] constant(64)
  broadcast.1583 = s32[32768]{0} broadcast(constant.1582), dimensions={}
  add.1593 = s32[32768]{0} add(subtract.1591, broadcast.1583)
  select.1594 = s32[32768]{0} select(compare.1592, add.1593, subtract.1591)
  reshape.1595 = s32[32768,1]{1,0} reshape(select.1594)
  ROOT gather.1596 = f32[32768,32]{1,0} gather(concatenate.1590, reshape.1595), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1597 {
  Arg_0.1598 = pred[] parameter(0)
  Arg_1.1599 = s32[] parameter(1)
  Arg_2.1600 = s32[] parameter(2)
  ROOT select.1601 = s32[] select(Arg_0.1598, Arg_1.1599, Arg_2.1600)
}

remainder.1602 {
  Arg_0.1603 = s32[32768]{0} parameter(0)
  Arg_1.1604 = s32[] parameter(1)
  constant.1608 = s32[] constant(0)
  compare.1609 = pred[] compare(Arg_1.1604, constant.1608), direction=EQ
  constant.1607 = s32[] constant(1)
  call.1610 = s32[] call(compare.1609, constant.1607, Arg_1.1604), to_apply=_where.1597
  broadcast.1611 = s32[32768]{0} broadcast(call.1610), dimensions={}
  remainder.1612 = s32[32768]{0} remainder(Arg_0.1603, broadcast.1611)
  constant.1605 = s32[] constant(0)
  broadcast.1606 = s32[32768]{0} broadcast(constant.1605), dimensions={}
  compare.1614 = pred[32768]{0} compare(remainder.1612, broadcast.1606), direction=LT
  compare.1615 = pred[] compare(call.1610, constant.1608), direction=LT
  broadcast.1616 = pred[32768]{0} broadcast(compare.1615), dimensions={}
  compare.1617 = pred[32768]{0} compare(compare.1614, broadcast.1616), direction=NE
  compare.1613 = pred[32768]{0} compare(remainder.1612, broadcast.1606), direction=NE
  and.1618 = pred[32768]{0} and(compare.1617, compare.1613)
  broadcast.1619 = s32[32768]{0} broadcast(call.1610), dimensions={}
  add.1620 = s32[32768]{0} add(remainder.1612, broadcast.1619)
  ROOT select.1621 = s32[32768]{0} select(and.1618, add.1620, remainder.1612)
}

_roll_dynamic.1622 {
  Arg_0.1623 = f32[32768,32]{1,0} parameter(0)
  concatenate.1633 = f32[32768,64]{1,0} concatenate(Arg_0.1623, Arg_0.1623), dimensions={1}
  constant.1629 = s32[] constant(32)
  broadcast.1630 = s32[32768]{0} broadcast(constant.1629), dimensions={}
  Arg_1.1624 = s32[32768]{0} parameter(1)
  constant.1631 = s32[] constant(32)
  call.1632 = s32[32768]{0} call(Arg_1.1624, constant.1631), to_apply=remainder.1602
  subtract.1634 = s32[32768]{0} subtract(broadcast.1630, call.1632)
  constant.1627 = s32[] constant(0)
  broadcast.1628 = s32[32768]{0} broadcast(constant.1627), dimensions={}
  compare.1635 = pred[32768]{0} compare(subtract.1634, broadcast.1628), direction=LT
  constant.1625 = s32[] constant(64)
  broadcast.1626 = s32[32768]{0} broadcast(constant.1625), dimensions={}
  add.1636 = s32[32768]{0} add(subtract.1634, broadcast.1626)
  select.1637 = s32[32768]{0} select(compare.1635, add.1636, subtract.1634)
  reshape.1638 = s32[32768,1]{1,0} reshape(select.1637)
  ROOT gather.1639 = f32[32768,32]{1,0} gather(concatenate.1633, reshape.1638), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1640 {
  Arg_0.1641 = pred[] parameter(0)
  Arg_1.1642 = s32[] parameter(1)
  Arg_2.1643 = s32[] parameter(2)
  ROOT select.1644 = s32[] select(Arg_0.1641, Arg_1.1642, Arg_2.1643)
}

remainder.1645 {
  Arg_0.1646 = s32[32768]{0} parameter(0)
  Arg_1.1647 = s32[] parameter(1)
  constant.1651 = s32[] constant(0)
  compare.1652 = pred[] compare(Arg_1.1647, constant.1651), direction=EQ
  constant.1650 = s32[] constant(1)
  call.1653 = s32[] call(compare.1652, constant.1650, Arg_1.1647), to_apply=_where.1640
  broadcast.1654 = s32[32768]{0} broadcast(call.1653), dimensions={}
  remainder.1655 = s32[32768]{0} remainder(Arg_0.1646, broadcast.1654)
  constant.1648 = s32[] constant(0)
  broadcast.1649 = s32[32768]{0} broadcast(constant.1648), dimensions={}
  compare.1657 = pred[32768]{0} compare(remainder.1655, broadcast.1649), direction=LT
  compare.1658 = pred[] compare(call.1653, constant.1651), direction=LT
  broadcast.1659 = pred[32768]{0} broadcast(compare.1658), dimensions={}
  compare.1660 = pred[32768]{0} compare(compare.1657, broadcast.1659), direction=NE
  compare.1656 = pred[32768]{0} compare(remainder.1655, broadcast.1649), direction=NE
  and.1661 = pred[32768]{0} and(compare.1660, compare.1656)
  broadcast.1662 = s32[32768]{0} broadcast(call.1653), dimensions={}
  add.1663 = s32[32768]{0} add(remainder.1655, broadcast.1662)
  ROOT select.1664 = s32[32768]{0} select(and.1661, add.1663, remainder.1655)
}

_roll_dynamic.1665 {
  Arg_0.1666 = f32[32768,32]{1,0} parameter(0)
  concatenate.1676 = f32[32768,64]{1,0} concatenate(Arg_0.1666, Arg_0.1666), dimensions={1}
  constant.1672 = s32[] constant(32)
  broadcast.1673 = s32[32768]{0} broadcast(constant.1672), dimensions={}
  Arg_1.1667 = s32[32768]{0} parameter(1)
  constant.1674 = s32[] constant(32)
  call.1675 = s32[32768]{0} call(Arg_1.1667, constant.1674), to_apply=remainder.1645
  subtract.1677 = s32[32768]{0} subtract(broadcast.1673, call.1675)
  constant.1670 = s32[] constant(0)
  broadcast.1671 = s32[32768]{0} broadcast(constant.1670), dimensions={}
  compare.1678 = pred[32768]{0} compare(subtract.1677, broadcast.1671), direction=LT
  constant.1668 = s32[] constant(64)
  broadcast.1669 = s32[32768]{0} broadcast(constant.1668), dimensions={}
  add.1679 = s32[32768]{0} add(subtract.1677, broadcast.1669)
  select.1680 = s32[32768]{0} select(compare.1678, add.1679, subtract.1677)
  reshape.1681 = s32[32768,1]{1,0} reshape(select.1680)
  ROOT gather.1682 = f32[32768,32]{1,0} gather(concatenate.1676, reshape.1681), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1683 {
  Arg_0.1684 = pred[] parameter(0)
  Arg_1.1685 = s32[] parameter(1)
  Arg_2.1686 = s32[] parameter(2)
  ROOT select.1687 = s32[] select(Arg_0.1684, Arg_1.1685, Arg_2.1686)
}

remainder.1688 {
  Arg_0.1689 = s32[32768]{0} parameter(0)
  Arg_1.1690 = s32[] parameter(1)
  constant.1694 = s32[] constant(0)
  compare.1695 = pred[] compare(Arg_1.1690, constant.1694), direction=EQ
  constant.1693 = s32[] constant(1)
  call.1696 = s32[] call(compare.1695, constant.1693, Arg_1.1690), to_apply=_where.1683
  broadcast.1697 = s32[32768]{0} broadcast(call.1696), dimensions={}
  remainder.1698 = s32[32768]{0} remainder(Arg_0.1689, broadcast.1697)
  constant.1691 = s32[] constant(0)
  broadcast.1692 = s32[32768]{0} broadcast(constant.1691), dimensions={}
  compare.1700 = pred[32768]{0} compare(remainder.1698, broadcast.1692), direction=LT
  compare.1701 = pred[] compare(call.1696, constant.1694), direction=LT
  broadcast.1702 = pred[32768]{0} broadcast(compare.1701), dimensions={}
  compare.1703 = pred[32768]{0} compare(compare.1700, broadcast.1702), direction=NE
  compare.1699 = pred[32768]{0} compare(remainder.1698, broadcast.1692), direction=NE
  and.1704 = pred[32768]{0} and(compare.1703, compare.1699)
  broadcast.1705 = s32[32768]{0} broadcast(call.1696), dimensions={}
  add.1706 = s32[32768]{0} add(remainder.1698, broadcast.1705)
  ROOT select.1707 = s32[32768]{0} select(and.1704, add.1706, remainder.1698)
}

_roll_dynamic.1708 {
  Arg_0.1709 = f32[32768,32]{1,0} parameter(0)
  concatenate.1719 = f32[32768,64]{1,0} concatenate(Arg_0.1709, Arg_0.1709), dimensions={1}
  constant.1715 = s32[] constant(32)
  broadcast.1716 = s32[32768]{0} broadcast(constant.1715), dimensions={}
  Arg_1.1710 = s32[32768]{0} parameter(1)
  constant.1717 = s32[] constant(32)
  call.1718 = s32[32768]{0} call(Arg_1.1710, constant.1717), to_apply=remainder.1688
  subtract.1720 = s32[32768]{0} subtract(broadcast.1716, call.1718)
  constant.1713 = s32[] constant(0)
  broadcast.1714 = s32[32768]{0} broadcast(constant.1713), dimensions={}
  compare.1721 = pred[32768]{0} compare(subtract.1720, broadcast.1714), direction=LT
  constant.1711 = s32[] constant(64)
  broadcast.1712 = s32[32768]{0} broadcast(constant.1711), dimensions={}
  add.1722 = s32[32768]{0} add(subtract.1720, broadcast.1712)
  select.1723 = s32[32768]{0} select(compare.1721, add.1722, subtract.1720)
  reshape.1724 = s32[32768,1]{1,0} reshape(select.1723)
  ROOT gather.1725 = f32[32768,32]{1,0} gather(concatenate.1719, reshape.1724), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1726 {
  Arg_0.1727 = pred[] parameter(0)
  Arg_1.1728 = s32[] parameter(1)
  Arg_2.1729 = s32[] parameter(2)
  ROOT select.1730 = s32[] select(Arg_0.1727, Arg_1.1728, Arg_2.1729)
}

remainder.1731 {
  Arg_0.1732 = s32[32768]{0} parameter(0)
  Arg_1.1733 = s32[] parameter(1)
  constant.1737 = s32[] constant(0)
  compare.1738 = pred[] compare(Arg_1.1733, constant.1737), direction=EQ
  constant.1736 = s32[] constant(1)
  call.1739 = s32[] call(compare.1738, constant.1736, Arg_1.1733), to_apply=_where.1726
  broadcast.1740 = s32[32768]{0} broadcast(call.1739), dimensions={}
  remainder.1741 = s32[32768]{0} remainder(Arg_0.1732, broadcast.1740)
  constant.1734 = s32[] constant(0)
  broadcast.1735 = s32[32768]{0} broadcast(constant.1734), dimensions={}
  compare.1743 = pred[32768]{0} compare(remainder.1741, broadcast.1735), direction=LT
  compare.1744 = pred[] compare(call.1739, constant.1737), direction=LT
  broadcast.1745 = pred[32768]{0} broadcast(compare.1744), dimensions={}
  compare.1746 = pred[32768]{0} compare(compare.1743, broadcast.1745), direction=NE
  compare.1742 = pred[32768]{0} compare(remainder.1741, broadcast.1735), direction=NE
  and.1747 = pred[32768]{0} and(compare.1746, compare.1742)
  broadcast.1748 = s32[32768]{0} broadcast(call.1739), dimensions={}
  add.1749 = s32[32768]{0} add(remainder.1741, broadcast.1748)
  ROOT select.1750 = s32[32768]{0} select(and.1747, add.1749, remainder.1741)
}

_roll_dynamic.1751 {
  Arg_0.1752 = f32[32768,32]{1,0} parameter(0)
  concatenate.1762 = f32[32768,64]{1,0} concatenate(Arg_0.1752, Arg_0.1752), dimensions={1}
  constant.1758 = s32[] constant(32)
  broadcast.1759 = s32[32768]{0} broadcast(constant.1758), dimensions={}
  Arg_1.1753 = s32[32768]{0} parameter(1)
  constant.1760 = s32[] constant(32)
  call.1761 = s32[32768]{0} call(Arg_1.1753, constant.1760), to_apply=remainder.1731
  subtract.1763 = s32[32768]{0} subtract(broadcast.1759, call.1761)
  constant.1756 = s32[] constant(0)
  broadcast.1757 = s32[32768]{0} broadcast(constant.1756), dimensions={}
  compare.1764 = pred[32768]{0} compare(subtract.1763, broadcast.1757), direction=LT
  constant.1754 = s32[] constant(64)
  broadcast.1755 = s32[32768]{0} broadcast(constant.1754), dimensions={}
  add.1765 = s32[32768]{0} add(subtract.1763, broadcast.1755)
  select.1766 = s32[32768]{0} select(compare.1764, add.1765, subtract.1763)
  reshape.1767 = s32[32768,1]{1,0} reshape(select.1766)
  ROOT gather.1768 = f32[32768,32]{1,0} gather(concatenate.1762, reshape.1767), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag_1.1769 {
  Arg_4.1774 = s32[6]{0} parameter(4)
  Arg_1.1771 = f32[32768]{0} parameter(1)
  Arg_2.1772 = f32[] parameter(2)
  broadcast.1775 = f32[32768]{0} broadcast(Arg_2.1772), dimensions={}
  multiply.1776 = f32[32768]{0} multiply(Arg_1.1771, broadcast.1775)
  Arg_3.1773 = f32[] parameter(3)
  broadcast.1777 = f32[32768]{0} broadcast(Arg_3.1773), dimensions={}
  divide.1778 = f32[32768]{0} divide(multiply.1776, broadcast.1777)
  floor.1779 = f32[32768]{0} floor(divide.1778)
  convert.1781 = s32[32768]{0} convert(floor.1779)
  subtract.1780 = f32[32768]{0} subtract(divide.1778, floor.1779)
  call.1782 = f32[6,32768,32]{2,1,0} call(Arg_4.1774, convert.1781, subtract.1780), to_apply=build_v_diag_weights.1385
  slice.1788 = f32[1,32768,32]{2,1,0} slice(call.1782), slice={[0:1], [0:32768], [0:32]}
  reshape.1789 = f32[32768,32]{1,0} reshape(slice.1788)
  Arg_0.1770 = f32[32768,32]{1,0} parameter(0)
  slice.1783 = s32[1]{0} slice(Arg_4.1774), slice={[0:1]}
  reshape.1784 = s32[] reshape(slice.1783)
  broadcast.1785 = s32[32768]{0} broadcast(reshape.1784), dimensions={}
  add.1786 = s32[32768]{0} add(convert.1781, broadcast.1785)
  call.1787 = f32[32768,32]{1,0} call(Arg_0.1770, add.1786), to_apply=_roll_dynamic.1536
  multiply.1790 = f32[32768,32]{1,0} multiply(reshape.1789, call.1787)
  slice.1796 = f32[1,32768,32]{2,1,0} slice(call.1782), slice={[1:2], [0:32768], [0:32]}
  reshape.1797 = f32[32768,32]{1,0} reshape(slice.1796)
  slice.1791 = s32[1]{0} slice(Arg_4.1774), slice={[1:2]}
  reshape.1792 = s32[] reshape(slice.1791)
  broadcast.1793 = s32[32768]{0} broadcast(reshape.1792), dimensions={}
  add.1794 = s32[32768]{0} add(convert.1781, broadcast.1793)
  call.1795 = f32[32768,32]{1,0} call(Arg_0.1770, add.1794), to_apply=_roll_dynamic.1579
  multiply.1798 = f32[32768,32]{1,0} multiply(reshape.1797, call.1795)
  add.1799 = f32[32768,32]{1,0} add(multiply.1790, multiply.1798)
  slice.1805 = f32[1,32768,32]{2,1,0} slice(call.1782), slice={[2:3], [0:32768], [0:32]}
  reshape.1806 = f32[32768,32]{1,0} reshape(slice.1805)
  slice.1800 = s32[1]{0} slice(Arg_4.1774), slice={[2:3]}
  reshape.1801 = s32[] reshape(slice.1800)
  broadcast.1802 = s32[32768]{0} broadcast(reshape.1801), dimensions={}
  add.1803 = s32[32768]{0} add(convert.1781, broadcast.1802)
  call.1804 = f32[32768,32]{1,0} call(Arg_0.1770, add.1803), to_apply=_roll_dynamic.1622
  multiply.1807 = f32[32768,32]{1,0} multiply(reshape.1806, call.1804)
  add.1808 = f32[32768,32]{1,0} add(add.1799, multiply.1807)
  slice.1814 = f32[1,32768,32]{2,1,0} slice(call.1782), slice={[3:4], [0:32768], [0:32]}
  reshape.1815 = f32[32768,32]{1,0} reshape(slice.1814)
  slice.1809 = s32[1]{0} slice(Arg_4.1774), slice={[3:4]}
  reshape.1810 = s32[] reshape(slice.1809)
  broadcast.1811 = s32[32768]{0} broadcast(reshape.1810), dimensions={}
  add.1812 = s32[32768]{0} add(convert.1781, broadcast.1811)
  call.1813 = f32[32768,32]{1,0} call(Arg_0.1770, add.1812), to_apply=_roll_dynamic.1665
  multiply.1816 = f32[32768,32]{1,0} multiply(reshape.1815, call.1813)
  add.1817 = f32[32768,32]{1,0} add(add.1808, multiply.1816)
  slice.1823 = f32[1,32768,32]{2,1,0} slice(call.1782), slice={[4:5], [0:32768], [0:32]}
  reshape.1824 = f32[32768,32]{1,0} reshape(slice.1823)
  slice.1818 = s32[1]{0} slice(Arg_4.1774), slice={[4:5]}
  reshape.1819 = s32[] reshape(slice.1818)
  broadcast.1820 = s32[32768]{0} broadcast(reshape.1819), dimensions={}
  add.1821 = s32[32768]{0} add(convert.1781, broadcast.1820)
  call.1822 = f32[32768,32]{1,0} call(Arg_0.1770, add.1821), to_apply=_roll_dynamic.1708
  multiply.1825 = f32[32768,32]{1,0} multiply(reshape.1824, call.1822)
  add.1826 = f32[32768,32]{1,0} add(add.1817, multiply.1825)
  slice.1832 = f32[1,32768,32]{2,1,0} slice(call.1782), slice={[5:6], [0:32768], [0:32]}
  reshape.1833 = f32[32768,32]{1,0} reshape(slice.1832)
  slice.1827 = s32[1]{0} slice(Arg_4.1774), slice={[5:6]}
  reshape.1828 = s32[] reshape(slice.1827)
  broadcast.1829 = s32[32768]{0} broadcast(reshape.1828), dimensions={}
  add.1830 = s32[32768]{0} add(convert.1781, broadcast.1829)
  call.1831 = f32[32768,32]{1,0} call(Arg_0.1770, add.1830), to_apply=_roll_dynamic.1751
  multiply.1834 = f32[32768,32]{1,0} multiply(reshape.1833, call.1831)
  ROOT add.1835 = f32[32768,32]{1,0} add(add.1826, multiply.1834)
}

_where.1836 {
  Arg_0.1837 = pred[] parameter(0)
  Arg_1.1838 = s32[] parameter(1)
  Arg_2.1839 = s32[] parameter(2)
  ROOT select.1840 = s32[] select(Arg_0.1837, Arg_1.1838, Arg_2.1839)
}

remainder.1841 {
  Arg_0.1842 = s32[32768]{0} parameter(0)
  Arg_1.1843 = s32[] parameter(1)
  constant.1847 = s32[] constant(0)
  compare.1848 = pred[] compare(Arg_1.1843, constant.1847), direction=EQ
  constant.1846 = s32[] constant(1)
  call.1849 = s32[] call(compare.1848, constant.1846, Arg_1.1843), to_apply=_where.1836
  broadcast.1850 = s32[32768]{0} broadcast(call.1849), dimensions={}
  remainder.1851 = s32[32768]{0} remainder(Arg_0.1842, broadcast.1850)
  constant.1844 = s32[] constant(0)
  broadcast.1845 = s32[32768]{0} broadcast(constant.1844), dimensions={}
  compare.1853 = pred[32768]{0} compare(remainder.1851, broadcast.1845), direction=LT
  compare.1854 = pred[] compare(call.1849, constant.1847), direction=LT
  broadcast.1855 = pred[32768]{0} broadcast(compare.1854), dimensions={}
  compare.1856 = pred[32768]{0} compare(compare.1853, broadcast.1855), direction=NE
  compare.1852 = pred[32768]{0} compare(remainder.1851, broadcast.1845), direction=NE
  and.1857 = pred[32768]{0} and(compare.1856, compare.1852)
  broadcast.1858 = s32[32768]{0} broadcast(call.1849), dimensions={}
  add.1859 = s32[32768]{0} add(remainder.1851, broadcast.1858)
  ROOT select.1860 = s32[32768]{0} select(and.1857, add.1859, remainder.1851)
}

_roll_dynamic.1861 {
  Arg_0.1862 = f32[32768,32]{1,0} parameter(0)
  concatenate.1872 = f32[32768,64]{1,0} concatenate(Arg_0.1862, Arg_0.1862), dimensions={1}
  constant.1868 = s32[] constant(32)
  broadcast.1869 = s32[32768]{0} broadcast(constant.1868), dimensions={}
  Arg_1.1863 = s32[32768]{0} parameter(1)
  constant.1870 = s32[] constant(32)
  call.1871 = s32[32768]{0} call(Arg_1.1863, constant.1870), to_apply=remainder.1841
  subtract.1873 = s32[32768]{0} subtract(broadcast.1869, call.1871)
  constant.1866 = s32[] constant(0)
  broadcast.1867 = s32[32768]{0} broadcast(constant.1866), dimensions={}
  compare.1874 = pred[32768]{0} compare(subtract.1873, broadcast.1867), direction=LT
  constant.1864 = s32[] constant(64)
  broadcast.1865 = s32[32768]{0} broadcast(constant.1864), dimensions={}
  add.1875 = s32[32768]{0} add(subtract.1873, broadcast.1865)
  select.1876 = s32[32768]{0} select(compare.1874, add.1875, subtract.1873)
  reshape.1877 = s32[32768,1]{1,0} reshape(select.1876)
  ROOT gather.1878 = f32[32768,32]{1,0} gather(concatenate.1872, reshape.1877), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.1905 = f32[32768,32]{1,0} parameter(0)
  concatenate.1915 = f32[32768,64]{1,0} concatenate(Arg_0.1905, Arg_0.1905), dimensions={1}
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
  ROOT gather.1921 = f32[32768,32]{1,0} gather(concatenate.1915, reshape.1920), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.1948 = f32[32768,32]{1,0} parameter(0)
  concatenate.1958 = f32[32768,64]{1,0} concatenate(Arg_0.1948, Arg_0.1948), dimensions={1}
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
  ROOT gather.1964 = f32[32768,32]{1,0} gather(concatenate.1958, reshape.1963), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.1991 = f32[32768,32]{1,0} parameter(0)
  concatenate.2001 = f32[32768,64]{1,0} concatenate(Arg_0.1991, Arg_0.1991), dimensions={1}
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
  ROOT gather.2007 = f32[32768,32]{1,0} gather(concatenate.2001, reshape.2006), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.2034 = f32[32768,32]{1,0} parameter(0)
  concatenate.2044 = f32[32768,64]{1,0} concatenate(Arg_0.2034, Arg_0.2034), dimensions={1}
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
  ROOT gather.2050 = f32[32768,32]{1,0} gather(concatenate.2044, reshape.2049), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.2077 = f32[32768,32]{1,0} parameter(0)
  concatenate.2087 = f32[32768,64]{1,0} concatenate(Arg_0.2077, Arg_0.2077), dimensions={1}
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
  ROOT gather.2093 = f32[32768,32]{1,0} gather(concatenate.2087, reshape.2092), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.2094 {
  Arg_0.2095 = f32[32768,32]{1,0} parameter(0)
  Arg_1.2096 = f32[32768]{0} parameter(1)
  Arg_2.2097 = f32[] parameter(2)
  broadcast.2124 = f32[32768]{0} broadcast(Arg_2.2097), dimensions={}
  multiply.2125 = f32[32768]{0} multiply(Arg_1.2096, broadcast.2124)
  Arg_3.2098 = f32[] parameter(3)
  broadcast.2126 = f32[32768]{0} broadcast(Arg_3.2098), dimensions={}
  divide.2127 = f32[32768]{0} divide(multiply.2125, broadcast.2126)
  floor.2128 = f32[32768]{0} floor(divide.2127)
  convert.2130 = s32[32768]{0} convert(floor.2128)
  Arg_4.2099 = s32[6]{0} parameter(4)
  slice.2193 = s32[1]{0} slice(Arg_4.2099), slice={[0:1]}
  reshape.2194 = s32[] reshape(slice.2193)
  broadcast.2195 = s32[32768]{0} broadcast(reshape.2194), dimensions={}
  add.2196 = s32[32768]{0} add(convert.2130, broadcast.2195)
  call.2197 = f32[32768,32]{1,0} call(Arg_0.2095, add.2196), to_apply=_roll_dynamic.1861
  subtract.2129 = f32[32768]{0} subtract(divide.2127, floor.2128)
  constant.2122 = f32[] constant(20)
  broadcast.2123 = f32[32768]{0} broadcast(constant.2122), dimensions={}
  divide.2135 = f32[32768]{0} divide(subtract.2129, broadcast.2123)
  multiply.2131 = f32[32768]{0} multiply(subtract.2129, subtract.2129)
  constant.2120 = f32[] constant(24)
  broadcast.2121 = f32[32768]{0} broadcast(constant.2120), dimensions={}
  divide.2136 = f32[32768]{0} divide(multiply.2131, broadcast.2121)
  subtract.2137 = f32[32768]{0} subtract(divide.2135, divide.2136)
  multiply.2132 = f32[32768]{0} multiply(multiply.2131, subtract.2129)
  divide.2138 = f32[32768]{0} divide(multiply.2132, broadcast.2121)
  subtract.2139 = f32[32768]{0} subtract(subtract.2137, divide.2138)
  multiply.2133 = f32[32768]{0} multiply(multiply.2132, subtract.2129)
  divide.2140 = f32[32768]{0} divide(multiply.2133, broadcast.2121)
  add.2141 = f32[32768]{0} add(subtract.2139, divide.2140)
  multiply.2134 = f32[32768]{0} multiply(multiply.2133, subtract.2129)
  constant.2118 = f32[] constant(120)
  broadcast.2119 = f32[32768]{0} broadcast(constant.2118), dimensions={}
  divide.2142 = f32[32768]{0} divide(multiply.2134, broadcast.2119)
  subtract.2143 = f32[32768]{0} subtract(add.2141, divide.2142)
  reshape.2198 = f32[32768,1]{1,0} reshape(subtract.2143)
  broadcast.2199 = f32[32768,1]{1,0} broadcast(reshape.2198), dimensions={0,1}
  reshape.2200 = f32[32768]{0} reshape(broadcast.2199)
  broadcast.2201 = f32[32768,32]{1,0} broadcast(reshape.2200), dimensions={0}
  multiply.2202 = f32[32768,32]{1,0} multiply(call.2197, broadcast.2201)
  slice.2203 = s32[1]{0} slice(Arg_4.2099), slice={[1:2]}
  reshape.2204 = s32[] reshape(slice.2203)
  broadcast.2205 = s32[32768]{0} broadcast(reshape.2204), dimensions={}
  add.2206 = s32[32768]{0} add(convert.2130, broadcast.2205)
  call.2207 = f32[32768,32]{1,0} call(Arg_0.2095, add.2206), to_apply=_roll_dynamic.1904
  constant.2116 = f32[] constant(2)
  broadcast.2117 = f32[32768]{0} broadcast(constant.2116), dimensions={}
  divide.2144 = f32[32768]{0} divide(subtract.2129, broadcast.2117)
  negate.2145 = f32[32768]{0} negate(divide.2144)
  multiply.2146 = f32[32768]{0} multiply(multiply.2131, broadcast.2117)
  constant.2114 = f32[] constant(3)
  broadcast.2115 = f32[32768]{0} broadcast(constant.2114), dimensions={}
  divide.2147 = f32[32768]{0} divide(multiply.2146, broadcast.2115)
  add.2148 = f32[32768]{0} add(negate.2145, divide.2147)
  divide.2149 = f32[32768]{0} divide(multiply.2132, broadcast.2121)
  subtract.2150 = f32[32768]{0} subtract(add.2148, divide.2149)
  constant.2112 = f32[] constant(6)
  broadcast.2113 = f32[32768]{0} broadcast(constant.2112), dimensions={}
  divide.2151 = f32[32768]{0} divide(multiply.2133, broadcast.2113)
  subtract.2152 = f32[32768]{0} subtract(subtract.2150, divide.2151)
  divide.2153 = f32[32768]{0} divide(multiply.2134, broadcast.2121)
  add.2154 = f32[32768]{0} add(subtract.2152, divide.2153)
  reshape.2208 = f32[32768,1]{1,0} reshape(add.2154)
  broadcast.2209 = f32[32768,1]{1,0} broadcast(reshape.2208), dimensions={0,1}
  reshape.2210 = f32[32768]{0} reshape(broadcast.2209)
  broadcast.2211 = f32[32768,32]{1,0} broadcast(reshape.2210), dimensions={0}
  multiply.2212 = f32[32768,32]{1,0} multiply(call.2207, broadcast.2211)
  add.2213 = f32[32768,32]{1,0} add(multiply.2202, multiply.2212)
  slice.2214 = s32[1]{0} slice(Arg_4.2099), slice={[2:3]}
  reshape.2215 = s32[] reshape(slice.2214)
  broadcast.2216 = s32[32768]{0} broadcast(reshape.2215), dimensions={}
  add.2217 = s32[32768]{0} add(convert.2130, broadcast.2216)
  call.2218 = f32[32768,32]{1,0} call(Arg_0.2095, add.2217), to_apply=_roll_dynamic.1947
  constant.2110 = f32[] constant(1)
  broadcast.2111 = f32[32768]{0} broadcast(constant.2110), dimensions={}
  divide.2155 = f32[32768]{0} divide(subtract.2129, broadcast.2115)
  subtract.2156 = f32[32768]{0} subtract(broadcast.2111, divide.2155)
  constant.2108 = f32[] constant(5)
  broadcast.2109 = f32[32768]{0} broadcast(constant.2108), dimensions={}
  multiply.2157 = f32[32768]{0} multiply(multiply.2131, broadcast.2109)
  constant.2106 = f32[] constant(4)
  broadcast.2107 = f32[32768]{0} broadcast(constant.2106), dimensions={}
  divide.2158 = f32[32768]{0} divide(multiply.2157, broadcast.2107)
  subtract.2159 = f32[32768]{0} subtract(subtract.2156, divide.2158)
  multiply.2160 = f32[32768]{0} multiply(multiply.2132, broadcast.2109)
  constant.2104 = f32[] constant(12)
  broadcast.2105 = f32[32768]{0} broadcast(constant.2104), dimensions={}
  divide.2161 = f32[32768]{0} divide(multiply.2160, broadcast.2105)
  add.2162 = f32[32768]{0} add(subtract.2159, divide.2161)
  divide.2163 = f32[32768]{0} divide(multiply.2133, broadcast.2107)
  add.2164 = f32[32768]{0} add(add.2162, divide.2163)
  divide.2165 = f32[32768]{0} divide(multiply.2134, broadcast.2105)
  subtract.2166 = f32[32768]{0} subtract(add.2164, divide.2165)
  reshape.2219 = f32[32768,1]{1,0} reshape(subtract.2166)
  broadcast.2220 = f32[32768,1]{1,0} broadcast(reshape.2219), dimensions={0,1}
  reshape.2221 = f32[32768]{0} reshape(broadcast.2220)
  broadcast.2222 = f32[32768,32]{1,0} broadcast(reshape.2221), dimensions={0}
  multiply.2223 = f32[32768,32]{1,0} multiply(call.2218, broadcast.2222)
  add.2224 = f32[32768,32]{1,0} add(add.2213, multiply.2223)
  slice.2225 = s32[1]{0} slice(Arg_4.2099), slice={[3:4]}
  reshape.2226 = s32[] reshape(slice.2225)
  broadcast.2227 = s32[32768]{0} broadcast(reshape.2226), dimensions={}
  add.2228 = s32[32768]{0} add(convert.2130, broadcast.2227)
  call.2229 = f32[32768,32]{1,0} call(Arg_0.2095, add.2228), to_apply=_roll_dynamic.1990
  multiply.2167 = f32[32768]{0} multiply(multiply.2131, broadcast.2117)
  divide.2168 = f32[32768]{0} divide(multiply.2167, broadcast.2115)
  add.2169 = f32[32768]{0} add(subtract.2129, divide.2168)
  constant.2102 = f32[] constant(7)
  broadcast.2103 = f32[32768]{0} broadcast(constant.2102), dimensions={}
  multiply.2170 = f32[32768]{0} multiply(multiply.2132, broadcast.2103)
  divide.2171 = f32[32768]{0} divide(multiply.2170, broadcast.2105)
  subtract.2172 = f32[32768]{0} subtract(add.2169, divide.2171)
  divide.2173 = f32[32768]{0} divide(multiply.2133, broadcast.2113)
  subtract.2174 = f32[32768]{0} subtract(subtract.2172, divide.2173)
  divide.2175 = f32[32768]{0} divide(multiply.2134, broadcast.2105)
  add.2176 = f32[32768]{0} add(subtract.2174, divide.2175)
  reshape.2230 = f32[32768,1]{1,0} reshape(add.2176)
  broadcast.2231 = f32[32768,1]{1,0} broadcast(reshape.2230), dimensions={0,1}
  reshape.2232 = f32[32768]{0} reshape(broadcast.2231)
  broadcast.2233 = f32[32768,32]{1,0} broadcast(reshape.2232), dimensions={0}
  multiply.2234 = f32[32768,32]{1,0} multiply(call.2229, broadcast.2233)
  add.2235 = f32[32768,32]{1,0} add(add.2224, multiply.2234)
  slice.2236 = s32[1]{0} slice(Arg_4.2099), slice={[4:5]}
  reshape.2237 = s32[] reshape(slice.2236)
  broadcast.2238 = s32[32768]{0} broadcast(reshape.2237), dimensions={}
  add.2239 = s32[32768]{0} add(convert.2130, broadcast.2238)
  call.2240 = f32[32768,32]{1,0} call(Arg_0.2095, add.2239), to_apply=_roll_dynamic.2033
  divide.2177 = f32[32768]{0} divide(subtract.2129, broadcast.2107)
  negate.2178 = f32[32768]{0} negate(divide.2177)
  divide.2179 = f32[32768]{0} divide(multiply.2131, broadcast.2121)
  subtract.2180 = f32[32768]{0} subtract(negate.2178, divide.2179)
  multiply.2181 = f32[32768]{0} multiply(multiply.2132, broadcast.2103)
  divide.2182 = f32[32768]{0} divide(multiply.2181, broadcast.2121)
  add.2183 = f32[32768]{0} add(subtract.2180, divide.2182)
  divide.2184 = f32[32768]{0} divide(multiply.2133, broadcast.2121)
  add.2185 = f32[32768]{0} add(add.2183, divide.2184)
  divide.2186 = f32[32768]{0} divide(multiply.2134, broadcast.2121)
  subtract.2187 = f32[32768]{0} subtract(add.2185, divide.2186)
  reshape.2241 = f32[32768,1]{1,0} reshape(subtract.2187)
  broadcast.2242 = f32[32768,1]{1,0} broadcast(reshape.2241), dimensions={0,1}
  reshape.2243 = f32[32768]{0} reshape(broadcast.2242)
  broadcast.2244 = f32[32768,32]{1,0} broadcast(reshape.2243), dimensions={0}
  multiply.2245 = f32[32768,32]{1,0} multiply(call.2240, broadcast.2244)
  add.2246 = f32[32768,32]{1,0} add(add.2235, multiply.2245)
  slice.2247 = s32[1]{0} slice(Arg_4.2099), slice={[5:6]}
  reshape.2248 = s32[] reshape(slice.2247)
  broadcast.2249 = s32[32768]{0} broadcast(reshape.2248), dimensions={}
  add.2250 = s32[32768]{0} add(convert.2130, broadcast.2249)
  call.2251 = f32[32768,32]{1,0} call(Arg_0.2095, add.2250), to_apply=_roll_dynamic.2076
  constant.2100 = f32[] constant(30)
  broadcast.2101 = f32[32768]{0} broadcast(constant.2100), dimensions={}
  divide.2188 = f32[32768]{0} divide(subtract.2129, broadcast.2101)
  divide.2189 = f32[32768]{0} divide(multiply.2132, broadcast.2121)
  subtract.2190 = f32[32768]{0} subtract(divide.2188, divide.2189)
  divide.2191 = f32[32768]{0} divide(multiply.2134, broadcast.2119)
  add.2192 = f32[32768]{0} add(subtract.2190, divide.2191)
  reshape.2252 = f32[32768,1]{1,0} reshape(add.2192)
  broadcast.2253 = f32[32768,1]{1,0} broadcast(reshape.2252), dimensions={0,1}
  reshape.2254 = f32[32768]{0} reshape(broadcast.2253)
  broadcast.2255 = f32[32768,32]{1,0} broadcast(reshape.2254), dimensions={0}
  multiply.2256 = f32[32768,32]{1,0} multiply(call.2251, broadcast.2255)
  ROOT add.2257 = f32[32768,32]{1,0} add(add.2246, multiply.2256)
}

_where.2258 {
  Arg_0.2259 = pred[] parameter(0)
  Arg_1.2260 = s32[] parameter(1)
  Arg_2.2261 = s32[] parameter(2)
  ROOT select.2262 = s32[] select(Arg_0.2259, Arg_1.2260, Arg_2.2261)
}

remainder.2263 {
  Arg_0.2264 = s32[32768]{0} parameter(0)
  Arg_1.2265 = s32[] parameter(1)
  constant.2269 = s32[] constant(0)
  compare.2270 = pred[] compare(Arg_1.2265, constant.2269), direction=EQ
  constant.2268 = s32[] constant(1)
  call.2271 = s32[] call(compare.2270, constant.2268, Arg_1.2265), to_apply=_where.2258
  broadcast.2272 = s32[32768]{0} broadcast(call.2271), dimensions={}
  remainder.2273 = s32[32768]{0} remainder(Arg_0.2264, broadcast.2272)
  constant.2266 = s32[] constant(0)
  broadcast.2267 = s32[32768]{0} broadcast(constant.2266), dimensions={}
  compare.2275 = pred[32768]{0} compare(remainder.2273, broadcast.2267), direction=LT
  compare.2276 = pred[] compare(call.2271, constant.2269), direction=LT
  broadcast.2277 = pred[32768]{0} broadcast(compare.2276), dimensions={}
  compare.2278 = pred[32768]{0} compare(compare.2275, broadcast.2277), direction=NE
  compare.2274 = pred[32768]{0} compare(remainder.2273, broadcast.2267), direction=NE
  and.2279 = pred[32768]{0} and(compare.2278, compare.2274)
  broadcast.2280 = s32[32768]{0} broadcast(call.2271), dimensions={}
  add.2281 = s32[32768]{0} add(remainder.2273, broadcast.2280)
  ROOT select.2282 = s32[32768]{0} select(and.2279, add.2281, remainder.2273)
}

_roll_dynamic.2283 {
  Arg_0.2284 = f32[32768,32]{1,0} parameter(0)
  concatenate.2294 = f32[32768,64]{1,0} concatenate(Arg_0.2284, Arg_0.2284), dimensions={1}
  constant.2290 = s32[] constant(32)
  broadcast.2291 = s32[32768]{0} broadcast(constant.2290), dimensions={}
  Arg_1.2285 = s32[32768]{0} parameter(1)
  constant.2292 = s32[] constant(32)
  call.2293 = s32[32768]{0} call(Arg_1.2285, constant.2292), to_apply=remainder.2263
  subtract.2295 = s32[32768]{0} subtract(broadcast.2291, call.2293)
  constant.2288 = s32[] constant(0)
  broadcast.2289 = s32[32768]{0} broadcast(constant.2288), dimensions={}
  compare.2296 = pred[32768]{0} compare(subtract.2295, broadcast.2289), direction=LT
  constant.2286 = s32[] constant(64)
  broadcast.2287 = s32[32768]{0} broadcast(constant.2286), dimensions={}
  add.2297 = s32[32768]{0} add(subtract.2295, broadcast.2287)
  select.2298 = s32[32768]{0} select(compare.2296, add.2297, subtract.2295)
  reshape.2299 = s32[32768,1]{1,0} reshape(select.2298)
  ROOT gather.2300 = f32[32768,32]{1,0} gather(concatenate.2294, reshape.2299), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2301 {
  Arg_0.2302 = pred[] parameter(0)
  Arg_1.2303 = s32[] parameter(1)
  Arg_2.2304 = s32[] parameter(2)
  ROOT select.2305 = s32[] select(Arg_0.2302, Arg_1.2303, Arg_2.2304)
}

remainder.2306 {
  Arg_0.2307 = s32[32768]{0} parameter(0)
  Arg_1.2308 = s32[] parameter(1)
  constant.2312 = s32[] constant(0)
  compare.2313 = pred[] compare(Arg_1.2308, constant.2312), direction=EQ
  constant.2311 = s32[] constant(1)
  call.2314 = s32[] call(compare.2313, constant.2311, Arg_1.2308), to_apply=_where.2301
  broadcast.2315 = s32[32768]{0} broadcast(call.2314), dimensions={}
  remainder.2316 = s32[32768]{0} remainder(Arg_0.2307, broadcast.2315)
  constant.2309 = s32[] constant(0)
  broadcast.2310 = s32[32768]{0} broadcast(constant.2309), dimensions={}
  compare.2318 = pred[32768]{0} compare(remainder.2316, broadcast.2310), direction=LT
  compare.2319 = pred[] compare(call.2314, constant.2312), direction=LT
  broadcast.2320 = pred[32768]{0} broadcast(compare.2319), dimensions={}
  compare.2321 = pred[32768]{0} compare(compare.2318, broadcast.2320), direction=NE
  compare.2317 = pred[32768]{0} compare(remainder.2316, broadcast.2310), direction=NE
  and.2322 = pred[32768]{0} and(compare.2321, compare.2317)
  broadcast.2323 = s32[32768]{0} broadcast(call.2314), dimensions={}
  add.2324 = s32[32768]{0} add(remainder.2316, broadcast.2323)
  ROOT select.2325 = s32[32768]{0} select(and.2322, add.2324, remainder.2316)
}

_roll_dynamic.2326 {
  Arg_0.2327 = f32[32768,32]{1,0} parameter(0)
  concatenate.2337 = f32[32768,64]{1,0} concatenate(Arg_0.2327, Arg_0.2327), dimensions={1}
  constant.2333 = s32[] constant(32)
  broadcast.2334 = s32[32768]{0} broadcast(constant.2333), dimensions={}
  Arg_1.2328 = s32[32768]{0} parameter(1)
  constant.2335 = s32[] constant(32)
  call.2336 = s32[32768]{0} call(Arg_1.2328, constant.2335), to_apply=remainder.2306
  subtract.2338 = s32[32768]{0} subtract(broadcast.2334, call.2336)
  constant.2331 = s32[] constant(0)
  broadcast.2332 = s32[32768]{0} broadcast(constant.2331), dimensions={}
  compare.2339 = pred[32768]{0} compare(subtract.2338, broadcast.2332), direction=LT
  constant.2329 = s32[] constant(64)
  broadcast.2330 = s32[32768]{0} broadcast(constant.2329), dimensions={}
  add.2340 = s32[32768]{0} add(subtract.2338, broadcast.2330)
  select.2341 = s32[32768]{0} select(compare.2339, add.2340, subtract.2338)
  reshape.2342 = s32[32768,1]{1,0} reshape(select.2341)
  ROOT gather.2343 = f32[32768,32]{1,0} gather(concatenate.2337, reshape.2342), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2344 {
  Arg_0.2345 = pred[] parameter(0)
  Arg_1.2346 = s32[] parameter(1)
  Arg_2.2347 = s32[] parameter(2)
  ROOT select.2348 = s32[] select(Arg_0.2345, Arg_1.2346, Arg_2.2347)
}

remainder.2349 {
  Arg_0.2350 = s32[32768]{0} parameter(0)
  Arg_1.2351 = s32[] parameter(1)
  constant.2355 = s32[] constant(0)
  compare.2356 = pred[] compare(Arg_1.2351, constant.2355), direction=EQ
  constant.2354 = s32[] constant(1)
  call.2357 = s32[] call(compare.2356, constant.2354, Arg_1.2351), to_apply=_where.2344
  broadcast.2358 = s32[32768]{0} broadcast(call.2357), dimensions={}
  remainder.2359 = s32[32768]{0} remainder(Arg_0.2350, broadcast.2358)
  constant.2352 = s32[] constant(0)
  broadcast.2353 = s32[32768]{0} broadcast(constant.2352), dimensions={}
  compare.2361 = pred[32768]{0} compare(remainder.2359, broadcast.2353), direction=LT
  compare.2362 = pred[] compare(call.2357, constant.2355), direction=LT
  broadcast.2363 = pred[32768]{0} broadcast(compare.2362), dimensions={}
  compare.2364 = pred[32768]{0} compare(compare.2361, broadcast.2363), direction=NE
  compare.2360 = pred[32768]{0} compare(remainder.2359, broadcast.2353), direction=NE
  and.2365 = pred[32768]{0} and(compare.2364, compare.2360)
  broadcast.2366 = s32[32768]{0} broadcast(call.2357), dimensions={}
  add.2367 = s32[32768]{0} add(remainder.2359, broadcast.2366)
  ROOT select.2368 = s32[32768]{0} select(and.2365, add.2367, remainder.2359)
}

_roll_dynamic.2369 {
  Arg_0.2370 = f32[32768,32]{1,0} parameter(0)
  concatenate.2380 = f32[32768,64]{1,0} concatenate(Arg_0.2370, Arg_0.2370), dimensions={1}
  constant.2376 = s32[] constant(32)
  broadcast.2377 = s32[32768]{0} broadcast(constant.2376), dimensions={}
  Arg_1.2371 = s32[32768]{0} parameter(1)
  constant.2378 = s32[] constant(32)
  call.2379 = s32[32768]{0} call(Arg_1.2371, constant.2378), to_apply=remainder.2349
  subtract.2381 = s32[32768]{0} subtract(broadcast.2377, call.2379)
  constant.2374 = s32[] constant(0)
  broadcast.2375 = s32[32768]{0} broadcast(constant.2374), dimensions={}
  compare.2382 = pred[32768]{0} compare(subtract.2381, broadcast.2375), direction=LT
  constant.2372 = s32[] constant(64)
  broadcast.2373 = s32[32768]{0} broadcast(constant.2372), dimensions={}
  add.2383 = s32[32768]{0} add(subtract.2381, broadcast.2373)
  select.2384 = s32[32768]{0} select(compare.2382, add.2383, subtract.2381)
  reshape.2385 = s32[32768,1]{1,0} reshape(select.2384)
  ROOT gather.2386 = f32[32768,32]{1,0} gather(concatenate.2380, reshape.2385), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2387 {
  Arg_0.2388 = pred[] parameter(0)
  Arg_1.2389 = s32[] parameter(1)
  Arg_2.2390 = s32[] parameter(2)
  ROOT select.2391 = s32[] select(Arg_0.2388, Arg_1.2389, Arg_2.2390)
}

remainder.2392 {
  Arg_0.2393 = s32[32768]{0} parameter(0)
  Arg_1.2394 = s32[] parameter(1)
  constant.2398 = s32[] constant(0)
  compare.2399 = pred[] compare(Arg_1.2394, constant.2398), direction=EQ
  constant.2397 = s32[] constant(1)
  call.2400 = s32[] call(compare.2399, constant.2397, Arg_1.2394), to_apply=_where.2387
  broadcast.2401 = s32[32768]{0} broadcast(call.2400), dimensions={}
  remainder.2402 = s32[32768]{0} remainder(Arg_0.2393, broadcast.2401)
  constant.2395 = s32[] constant(0)
  broadcast.2396 = s32[32768]{0} broadcast(constant.2395), dimensions={}
  compare.2404 = pred[32768]{0} compare(remainder.2402, broadcast.2396), direction=LT
  compare.2405 = pred[] compare(call.2400, constant.2398), direction=LT
  broadcast.2406 = pred[32768]{0} broadcast(compare.2405), dimensions={}
  compare.2407 = pred[32768]{0} compare(compare.2404, broadcast.2406), direction=NE
  compare.2403 = pred[32768]{0} compare(remainder.2402, broadcast.2396), direction=NE
  and.2408 = pred[32768]{0} and(compare.2407, compare.2403)
  broadcast.2409 = s32[32768]{0} broadcast(call.2400), dimensions={}
  add.2410 = s32[32768]{0} add(remainder.2402, broadcast.2409)
  ROOT select.2411 = s32[32768]{0} select(and.2408, add.2410, remainder.2402)
}

_roll_dynamic.2412 {
  Arg_0.2413 = f32[32768,32]{1,0} parameter(0)
  concatenate.2423 = f32[32768,64]{1,0} concatenate(Arg_0.2413, Arg_0.2413), dimensions={1}
  constant.2419 = s32[] constant(32)
  broadcast.2420 = s32[32768]{0} broadcast(constant.2419), dimensions={}
  Arg_1.2414 = s32[32768]{0} parameter(1)
  constant.2421 = s32[] constant(32)
  call.2422 = s32[32768]{0} call(Arg_1.2414, constant.2421), to_apply=remainder.2392
  subtract.2424 = s32[32768]{0} subtract(broadcast.2420, call.2422)
  constant.2417 = s32[] constant(0)
  broadcast.2418 = s32[32768]{0} broadcast(constant.2417), dimensions={}
  compare.2425 = pred[32768]{0} compare(subtract.2424, broadcast.2418), direction=LT
  constant.2415 = s32[] constant(64)
  broadcast.2416 = s32[32768]{0} broadcast(constant.2415), dimensions={}
  add.2426 = s32[32768]{0} add(subtract.2424, broadcast.2416)
  select.2427 = s32[32768]{0} select(compare.2425, add.2426, subtract.2424)
  reshape.2428 = s32[32768,1]{1,0} reshape(select.2427)
  ROOT gather.2429 = f32[32768,32]{1,0} gather(concatenate.2423, reshape.2428), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2430 {
  Arg_0.2431 = pred[] parameter(0)
  Arg_1.2432 = s32[] parameter(1)
  Arg_2.2433 = s32[] parameter(2)
  ROOT select.2434 = s32[] select(Arg_0.2431, Arg_1.2432, Arg_2.2433)
}

remainder.2435 {
  Arg_0.2436 = s32[32768]{0} parameter(0)
  Arg_1.2437 = s32[] parameter(1)
  constant.2441 = s32[] constant(0)
  compare.2442 = pred[] compare(Arg_1.2437, constant.2441), direction=EQ
  constant.2440 = s32[] constant(1)
  call.2443 = s32[] call(compare.2442, constant.2440, Arg_1.2437), to_apply=_where.2430
  broadcast.2444 = s32[32768]{0} broadcast(call.2443), dimensions={}
  remainder.2445 = s32[32768]{0} remainder(Arg_0.2436, broadcast.2444)
  constant.2438 = s32[] constant(0)
  broadcast.2439 = s32[32768]{0} broadcast(constant.2438), dimensions={}
  compare.2447 = pred[32768]{0} compare(remainder.2445, broadcast.2439), direction=LT
  compare.2448 = pred[] compare(call.2443, constant.2441), direction=LT
  broadcast.2449 = pred[32768]{0} broadcast(compare.2448), dimensions={}
  compare.2450 = pred[32768]{0} compare(compare.2447, broadcast.2449), direction=NE
  compare.2446 = pred[32768]{0} compare(remainder.2445, broadcast.2439), direction=NE
  and.2451 = pred[32768]{0} and(compare.2450, compare.2446)
  broadcast.2452 = s32[32768]{0} broadcast(call.2443), dimensions={}
  add.2453 = s32[32768]{0} add(remainder.2445, broadcast.2452)
  ROOT select.2454 = s32[32768]{0} select(and.2451, add.2453, remainder.2445)
}

_roll_dynamic.2455 {
  Arg_0.2456 = f32[32768,32]{1,0} parameter(0)
  concatenate.2466 = f32[32768,64]{1,0} concatenate(Arg_0.2456, Arg_0.2456), dimensions={1}
  constant.2462 = s32[] constant(32)
  broadcast.2463 = s32[32768]{0} broadcast(constant.2462), dimensions={}
  Arg_1.2457 = s32[32768]{0} parameter(1)
  constant.2464 = s32[] constant(32)
  call.2465 = s32[32768]{0} call(Arg_1.2457, constant.2464), to_apply=remainder.2435
  subtract.2467 = s32[32768]{0} subtract(broadcast.2463, call.2465)
  constant.2460 = s32[] constant(0)
  broadcast.2461 = s32[32768]{0} broadcast(constant.2460), dimensions={}
  compare.2468 = pred[32768]{0} compare(subtract.2467, broadcast.2461), direction=LT
  constant.2458 = s32[] constant(64)
  broadcast.2459 = s32[32768]{0} broadcast(constant.2458), dimensions={}
  add.2469 = s32[32768]{0} add(subtract.2467, broadcast.2459)
  select.2470 = s32[32768]{0} select(compare.2468, add.2469, subtract.2467)
  reshape.2471 = s32[32768,1]{1,0} reshape(select.2470)
  ROOT gather.2472 = f32[32768,32]{1,0} gather(concatenate.2466, reshape.2471), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2473 {
  Arg_0.2474 = pred[] parameter(0)
  Arg_1.2475 = s32[] parameter(1)
  Arg_2.2476 = s32[] parameter(2)
  ROOT select.2477 = s32[] select(Arg_0.2474, Arg_1.2475, Arg_2.2476)
}

remainder.2478 {
  Arg_0.2479 = s32[32768]{0} parameter(0)
  Arg_1.2480 = s32[] parameter(1)
  constant.2484 = s32[] constant(0)
  compare.2485 = pred[] compare(Arg_1.2480, constant.2484), direction=EQ
  constant.2483 = s32[] constant(1)
  call.2486 = s32[] call(compare.2485, constant.2483, Arg_1.2480), to_apply=_where.2473
  broadcast.2487 = s32[32768]{0} broadcast(call.2486), dimensions={}
  remainder.2488 = s32[32768]{0} remainder(Arg_0.2479, broadcast.2487)
  constant.2481 = s32[] constant(0)
  broadcast.2482 = s32[32768]{0} broadcast(constant.2481), dimensions={}
  compare.2490 = pred[32768]{0} compare(remainder.2488, broadcast.2482), direction=LT
  compare.2491 = pred[] compare(call.2486, constant.2484), direction=LT
  broadcast.2492 = pred[32768]{0} broadcast(compare.2491), dimensions={}
  compare.2493 = pred[32768]{0} compare(compare.2490, broadcast.2492), direction=NE
  compare.2489 = pred[32768]{0} compare(remainder.2488, broadcast.2482), direction=NE
  and.2494 = pred[32768]{0} and(compare.2493, compare.2489)
  broadcast.2495 = s32[32768]{0} broadcast(call.2486), dimensions={}
  add.2496 = s32[32768]{0} add(remainder.2488, broadcast.2495)
  ROOT select.2497 = s32[32768]{0} select(and.2494, add.2496, remainder.2488)
}

_roll_dynamic.2498 {
  Arg_0.2499 = f32[32768,32]{1,0} parameter(0)
  concatenate.2509 = f32[32768,64]{1,0} concatenate(Arg_0.2499, Arg_0.2499), dimensions={1}
  constant.2505 = s32[] constant(32)
  broadcast.2506 = s32[32768]{0} broadcast(constant.2505), dimensions={}
  Arg_1.2500 = s32[32768]{0} parameter(1)
  constant.2507 = s32[] constant(32)
  call.2508 = s32[32768]{0} call(Arg_1.2500, constant.2507), to_apply=remainder.2478
  subtract.2510 = s32[32768]{0} subtract(broadcast.2506, call.2508)
  constant.2503 = s32[] constant(0)
  broadcast.2504 = s32[32768]{0} broadcast(constant.2503), dimensions={}
  compare.2511 = pred[32768]{0} compare(subtract.2510, broadcast.2504), direction=LT
  constant.2501 = s32[] constant(64)
  broadcast.2502 = s32[32768]{0} broadcast(constant.2501), dimensions={}
  add.2512 = s32[32768]{0} add(subtract.2510, broadcast.2502)
  select.2513 = s32[32768]{0} select(compare.2511, add.2512, subtract.2510)
  reshape.2514 = s32[32768,1]{1,0} reshape(select.2513)
  ROOT gather.2515 = f32[32768,32]{1,0} gather(concatenate.2509, reshape.2514), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.2516 {
  Arg_0.2517 = f32[32768,32]{1,0} parameter(0)
  Arg_1.2518 = f32[32768]{0} parameter(1)
  Arg_2.2519 = f32[] parameter(2)
  broadcast.2546 = f32[32768]{0} broadcast(Arg_2.2519), dimensions={}
  multiply.2547 = f32[32768]{0} multiply(Arg_1.2518, broadcast.2546)
  Arg_3.2520 = f32[] parameter(3)
  broadcast.2548 = f32[32768]{0} broadcast(Arg_3.2520), dimensions={}
  divide.2549 = f32[32768]{0} divide(multiply.2547, broadcast.2548)
  floor.2550 = f32[32768]{0} floor(divide.2549)
  convert.2552 = s32[32768]{0} convert(floor.2550)
  Arg_4.2521 = s32[6]{0} parameter(4)
  slice.2615 = s32[1]{0} slice(Arg_4.2521), slice={[0:1]}
  reshape.2616 = s32[] reshape(slice.2615)
  broadcast.2617 = s32[32768]{0} broadcast(reshape.2616), dimensions={}
  add.2618 = s32[32768]{0} add(convert.2552, broadcast.2617)
  call.2619 = f32[32768,32]{1,0} call(Arg_0.2517, add.2618), to_apply=_roll_dynamic.2283
  subtract.2551 = f32[32768]{0} subtract(divide.2549, floor.2550)
  constant.2544 = f32[] constant(20)
  broadcast.2545 = f32[32768]{0} broadcast(constant.2544), dimensions={}
  divide.2557 = f32[32768]{0} divide(subtract.2551, broadcast.2545)
  multiply.2553 = f32[32768]{0} multiply(subtract.2551, subtract.2551)
  constant.2542 = f32[] constant(24)
  broadcast.2543 = f32[32768]{0} broadcast(constant.2542), dimensions={}
  divide.2558 = f32[32768]{0} divide(multiply.2553, broadcast.2543)
  subtract.2559 = f32[32768]{0} subtract(divide.2557, divide.2558)
  multiply.2554 = f32[32768]{0} multiply(multiply.2553, subtract.2551)
  divide.2560 = f32[32768]{0} divide(multiply.2554, broadcast.2543)
  subtract.2561 = f32[32768]{0} subtract(subtract.2559, divide.2560)
  multiply.2555 = f32[32768]{0} multiply(multiply.2554, subtract.2551)
  divide.2562 = f32[32768]{0} divide(multiply.2555, broadcast.2543)
  add.2563 = f32[32768]{0} add(subtract.2561, divide.2562)
  multiply.2556 = f32[32768]{0} multiply(multiply.2555, subtract.2551)
  constant.2540 = f32[] constant(120)
  broadcast.2541 = f32[32768]{0} broadcast(constant.2540), dimensions={}
  divide.2564 = f32[32768]{0} divide(multiply.2556, broadcast.2541)
  subtract.2565 = f32[32768]{0} subtract(add.2563, divide.2564)
  reshape.2620 = f32[32768,1]{1,0} reshape(subtract.2565)
  broadcast.2621 = f32[32768,1]{1,0} broadcast(reshape.2620), dimensions={0,1}
  reshape.2622 = f32[32768]{0} reshape(broadcast.2621)
  broadcast.2623 = f32[32768,32]{1,0} broadcast(reshape.2622), dimensions={0}
  multiply.2624 = f32[32768,32]{1,0} multiply(call.2619, broadcast.2623)
  slice.2625 = s32[1]{0} slice(Arg_4.2521), slice={[1:2]}
  reshape.2626 = s32[] reshape(slice.2625)
  broadcast.2627 = s32[32768]{0} broadcast(reshape.2626), dimensions={}
  add.2628 = s32[32768]{0} add(convert.2552, broadcast.2627)
  call.2629 = f32[32768,32]{1,0} call(Arg_0.2517, add.2628), to_apply=_roll_dynamic.2326
  constant.2538 = f32[] constant(2)
  broadcast.2539 = f32[32768]{0} broadcast(constant.2538), dimensions={}
  divide.2566 = f32[32768]{0} divide(subtract.2551, broadcast.2539)
  negate.2567 = f32[32768]{0} negate(divide.2566)
  multiply.2568 = f32[32768]{0} multiply(multiply.2553, broadcast.2539)
  constant.2536 = f32[] constant(3)
  broadcast.2537 = f32[32768]{0} broadcast(constant.2536), dimensions={}
  divide.2569 = f32[32768]{0} divide(multiply.2568, broadcast.2537)
  add.2570 = f32[32768]{0} add(negate.2567, divide.2569)
  divide.2571 = f32[32768]{0} divide(multiply.2554, broadcast.2543)
  subtract.2572 = f32[32768]{0} subtract(add.2570, divide.2571)
  constant.2534 = f32[] constant(6)
  broadcast.2535 = f32[32768]{0} broadcast(constant.2534), dimensions={}
  divide.2573 = f32[32768]{0} divide(multiply.2555, broadcast.2535)
  subtract.2574 = f32[32768]{0} subtract(subtract.2572, divide.2573)
  divide.2575 = f32[32768]{0} divide(multiply.2556, broadcast.2543)
  add.2576 = f32[32768]{0} add(subtract.2574, divide.2575)
  reshape.2630 = f32[32768,1]{1,0} reshape(add.2576)
  broadcast.2631 = f32[32768,1]{1,0} broadcast(reshape.2630), dimensions={0,1}
  reshape.2632 = f32[32768]{0} reshape(broadcast.2631)
  broadcast.2633 = f32[32768,32]{1,0} broadcast(reshape.2632), dimensions={0}
  multiply.2634 = f32[32768,32]{1,0} multiply(call.2629, broadcast.2633)
  add.2635 = f32[32768,32]{1,0} add(multiply.2624, multiply.2634)
  slice.2636 = s32[1]{0} slice(Arg_4.2521), slice={[2:3]}
  reshape.2637 = s32[] reshape(slice.2636)
  broadcast.2638 = s32[32768]{0} broadcast(reshape.2637), dimensions={}
  add.2639 = s32[32768]{0} add(convert.2552, broadcast.2638)
  call.2640 = f32[32768,32]{1,0} call(Arg_0.2517, add.2639), to_apply=_roll_dynamic.2369
  constant.2532 = f32[] constant(1)
  broadcast.2533 = f32[32768]{0} broadcast(constant.2532), dimensions={}
  divide.2577 = f32[32768]{0} divide(subtract.2551, broadcast.2537)
  subtract.2578 = f32[32768]{0} subtract(broadcast.2533, divide.2577)
  constant.2530 = f32[] constant(5)
  broadcast.2531 = f32[32768]{0} broadcast(constant.2530), dimensions={}
  multiply.2579 = f32[32768]{0} multiply(multiply.2553, broadcast.2531)
  constant.2528 = f32[] constant(4)
  broadcast.2529 = f32[32768]{0} broadcast(constant.2528), dimensions={}
  divide.2580 = f32[32768]{0} divide(multiply.2579, broadcast.2529)
  subtract.2581 = f32[32768]{0} subtract(subtract.2578, divide.2580)
  multiply.2582 = f32[32768]{0} multiply(multiply.2554, broadcast.2531)
  constant.2526 = f32[] constant(12)
  broadcast.2527 = f32[32768]{0} broadcast(constant.2526), dimensions={}
  divide.2583 = f32[32768]{0} divide(multiply.2582, broadcast.2527)
  add.2584 = f32[32768]{0} add(subtract.2581, divide.2583)
  divide.2585 = f32[32768]{0} divide(multiply.2555, broadcast.2529)
  add.2586 = f32[32768]{0} add(add.2584, divide.2585)
  divide.2587 = f32[32768]{0} divide(multiply.2556, broadcast.2527)
  subtract.2588 = f32[32768]{0} subtract(add.2586, divide.2587)
  reshape.2641 = f32[32768,1]{1,0} reshape(subtract.2588)
  broadcast.2642 = f32[32768,1]{1,0} broadcast(reshape.2641), dimensions={0,1}
  reshape.2643 = f32[32768]{0} reshape(broadcast.2642)
  broadcast.2644 = f32[32768,32]{1,0} broadcast(reshape.2643), dimensions={0}
  multiply.2645 = f32[32768,32]{1,0} multiply(call.2640, broadcast.2644)
  add.2646 = f32[32768,32]{1,0} add(add.2635, multiply.2645)
  slice.2647 = s32[1]{0} slice(Arg_4.2521), slice={[3:4]}
  reshape.2648 = s32[] reshape(slice.2647)
  broadcast.2649 = s32[32768]{0} broadcast(reshape.2648), dimensions={}
  add.2650 = s32[32768]{0} add(convert.2552, broadcast.2649)
  call.2651 = f32[32768,32]{1,0} call(Arg_0.2517, add.2650), to_apply=_roll_dynamic.2412
  multiply.2589 = f32[32768]{0} multiply(multiply.2553, broadcast.2539)
  divide.2590 = f32[32768]{0} divide(multiply.2589, broadcast.2537)
  add.2591 = f32[32768]{0} add(subtract.2551, divide.2590)
  constant.2524 = f32[] constant(7)
  broadcast.2525 = f32[32768]{0} broadcast(constant.2524), dimensions={}
  multiply.2592 = f32[32768]{0} multiply(multiply.2554, broadcast.2525)
  divide.2593 = f32[32768]{0} divide(multiply.2592, broadcast.2527)
  subtract.2594 = f32[32768]{0} subtract(add.2591, divide.2593)
  divide.2595 = f32[32768]{0} divide(multiply.2555, broadcast.2535)
  subtract.2596 = f32[32768]{0} subtract(subtract.2594, divide.2595)
  divide.2597 = f32[32768]{0} divide(multiply.2556, broadcast.2527)
  add.2598 = f32[32768]{0} add(subtract.2596, divide.2597)
  reshape.2652 = f32[32768,1]{1,0} reshape(add.2598)
  broadcast.2653 = f32[32768,1]{1,0} broadcast(reshape.2652), dimensions={0,1}
  reshape.2654 = f32[32768]{0} reshape(broadcast.2653)
  broadcast.2655 = f32[32768,32]{1,0} broadcast(reshape.2654), dimensions={0}
  multiply.2656 = f32[32768,32]{1,0} multiply(call.2651, broadcast.2655)
  add.2657 = f32[32768,32]{1,0} add(add.2646, multiply.2656)
  slice.2658 = s32[1]{0} slice(Arg_4.2521), slice={[4:5]}
  reshape.2659 = s32[] reshape(slice.2658)
  broadcast.2660 = s32[32768]{0} broadcast(reshape.2659), dimensions={}
  add.2661 = s32[32768]{0} add(convert.2552, broadcast.2660)
  call.2662 = f32[32768,32]{1,0} call(Arg_0.2517, add.2661), to_apply=_roll_dynamic.2455
  divide.2599 = f32[32768]{0} divide(subtract.2551, broadcast.2529)
  negate.2600 = f32[32768]{0} negate(divide.2599)
  divide.2601 = f32[32768]{0} divide(multiply.2553, broadcast.2543)
  subtract.2602 = f32[32768]{0} subtract(negate.2600, divide.2601)
  multiply.2603 = f32[32768]{0} multiply(multiply.2554, broadcast.2525)
  divide.2604 = f32[32768]{0} divide(multiply.2603, broadcast.2543)
  add.2605 = f32[32768]{0} add(subtract.2602, divide.2604)
  divide.2606 = f32[32768]{0} divide(multiply.2555, broadcast.2543)
  add.2607 = f32[32768]{0} add(add.2605, divide.2606)
  divide.2608 = f32[32768]{0} divide(multiply.2556, broadcast.2543)
  subtract.2609 = f32[32768]{0} subtract(add.2607, divide.2608)
  reshape.2663 = f32[32768,1]{1,0} reshape(subtract.2609)
  broadcast.2664 = f32[32768,1]{1,0} broadcast(reshape.2663), dimensions={0,1}
  reshape.2665 = f32[32768]{0} reshape(broadcast.2664)
  broadcast.2666 = f32[32768,32]{1,0} broadcast(reshape.2665), dimensions={0}
  multiply.2667 = f32[32768,32]{1,0} multiply(call.2662, broadcast.2666)
  add.2668 = f32[32768,32]{1,0} add(add.2657, multiply.2667)
  slice.2669 = s32[1]{0} slice(Arg_4.2521), slice={[5:6]}
  reshape.2670 = s32[] reshape(slice.2669)
  broadcast.2671 = s32[32768]{0} broadcast(reshape.2670), dimensions={}
  add.2672 = s32[32768]{0} add(convert.2552, broadcast.2671)
  call.2673 = f32[32768,32]{1,0} call(Arg_0.2517, add.2672), to_apply=_roll_dynamic.2498
  constant.2522 = f32[] constant(30)
  broadcast.2523 = f32[32768]{0} broadcast(constant.2522), dimensions={}
  divide.2610 = f32[32768]{0} divide(subtract.2551, broadcast.2523)
  divide.2611 = f32[32768]{0} divide(multiply.2554, broadcast.2543)
  subtract.2612 = f32[32768]{0} subtract(divide.2610, divide.2611)
  divide.2613 = f32[32768]{0} divide(multiply.2556, broadcast.2541)
  add.2614 = f32[32768]{0} add(subtract.2612, divide.2613)
  reshape.2674 = f32[32768,1]{1,0} reshape(add.2614)
  broadcast.2675 = f32[32768,1]{1,0} broadcast(reshape.2674), dimensions={0,1}
  reshape.2676 = f32[32768]{0} reshape(broadcast.2675)
  broadcast.2677 = f32[32768,32]{1,0} broadcast(reshape.2676), dimensions={0}
  multiply.2678 = f32[32768,32]{1,0} multiply(call.2673, broadcast.2677)
  ROOT add.2679 = f32[32768,32]{1,0} add(add.2668, multiply.2678)
}

None.2680 {
  Arg_7.2688 = f32[32,32]{1,0} parameter(7)
  Arg_8.2689 = f32[32,32]{1,0} parameter(8)
  Arg_6.2687 = f32[32,32,32,32]{3,2,1,0} parameter(6)
  transpose.2695 = f32[32,32,32,32]{2,1,0,3} transpose(Arg_6.2687), dimensions={1,2,3,0}
  reshape.2696 = f32[32768,32]{1,0} reshape(transpose.2695)
  Arg_0.2681 = f32[32]{0} parameter(0)
  reshape.2694 = f32[1,32,1]{2,1,0} reshape(Arg_0.2681)
  broadcast.2697 = f32[1,32,1]{2,1,0} broadcast(reshape.2694), dimensions={0,1,2}
  reshape.2698 = f32[32]{0} reshape(broadcast.2697)
  broadcast.2699 = f32[32,32,32]{2,1,0} broadcast(reshape.2698), dimensions={1}
  reshape.2700 = f32[32768]{0} reshape(broadcast.2699)
  constant.2693 = f32[] constant(0.025)
  constant.2692 = f32[] constant(0.392699093)
  Arg_1.2682 = s32[6]{0} parameter(1)
  call.2701 = f32[32768,32]{1,0} call(reshape.2696, reshape.2700, constant.2693, constant.2692, Arg_1.2682), to_apply=advect_1d_roll_diag.275
  reshape.2702 = f32[32,32,32,32]{3,2,1,0} reshape(call.2701)
  transpose.2704 = f32[32,32,32,32]{0,2,1,3} transpose(reshape.2702), dimensions={3,1,2,0}
  reshape.2705 = f32[32768,32]{1,0} reshape(transpose.2704)
  Arg_2.2683 = f32[32]{0} parameter(2)
  reshape.2703 = f32[1,1,32]{2,1,0} reshape(Arg_2.2683)
  broadcast.2706 = f32[1,1,32]{2,1,0} broadcast(reshape.2703), dimensions={0,1,2}
  reshape.2707 = f32[32]{0} reshape(broadcast.2706)
  broadcast.2708 = f32[32,32,32]{2,1,0} broadcast(reshape.2707), dimensions={2}
  reshape.2709 = f32[32768]{0} reshape(broadcast.2708)
  call.2710 = f32[32768,32]{1,0} call(reshape.2705, reshape.2709, constant.2693, constant.2692, Arg_1.2682), to_apply=advect_1d_roll_diag.697
  reshape.2711 = f32[32,32,32,32]{3,2,1,0} reshape(call.2710)
  transpose.2719 = f32[32,32,32,32]{1,2,3,0} transpose(reshape.2711), dimensions={0,3,2,1}
  reshape.2720 = f32[32768,32]{1,0} reshape(transpose.2719)
  transpose.2712 = f32[32,32,32,32]{1,3,2,0} transpose(reshape.2711), dimensions={0,3,1,2}
  Arg_3.2684 = f32[32,1]{1,0} parameter(3)
  Arg_4.2685 = f32[1,17]{1,0} parameter(4)
  Arg_5.2686 = f32[32,17]{1,0} parameter(5)
  constant.2691 = f32[] constant(0.322580636)
  call.2713 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) call(transpose.2712, Arg_3.2684, Arg_4.2685, Arg_5.2686, constant.2691, constant.2691), to_apply=solve_poisson.877
  get-tuple-element.2714 = f32[32,32]{1,0} get-tuple-element(call.2713), index=0
  reshape.2718 = f32[32,32,1]{2,1,0} reshape(get-tuple-element.2714)
  broadcast.2721 = f32[32,32,1]{2,1,0} broadcast(reshape.2718), dimensions={0,1,2}
  reshape.2722 = f32[32,32]{1,0} reshape(broadcast.2721)
  broadcast.2723 = f32[32,32,32]{2,1,0} broadcast(reshape.2722), dimensions={0,1}
  reshape.2724 = f32[32768]{0} reshape(broadcast.2723)
  constant.2690 = f32[] constant(0.05)
  call.2725 = f32[32768,32]{1,0} call(reshape.2720, reshape.2724, constant.2690, constant.2691, Arg_1.2682), to_apply=advect_1d_roll_diag_1.1309
  reshape.2726 = f32[32,32,32,32]{3,2,1,0} reshape(call.2725)
  transpose.2727 = f32[32,32,32,32]{2,3,1,0} transpose(reshape.2726), dimensions={0,1,3,2}
  reshape.2729 = f32[32768,32]{1,0} reshape(transpose.2727)
  get-tuple-element.2715 = f32[32,32]{1,0} get-tuple-element(call.2713), index=1
  reshape.2728 = f32[32,32,1]{2,1,0} reshape(get-tuple-element.2715)
  broadcast.2730 = f32[32,32,1]{2,1,0} broadcast(reshape.2728), dimensions={0,1,2}
  reshape.2731 = f32[32,32]{1,0} reshape(broadcast.2730)
  broadcast.2732 = f32[32,32,32]{2,1,0} broadcast(reshape.2731), dimensions={0,1}
  reshape.2733 = f32[32768]{0} reshape(broadcast.2732)
  call.2734 = f32[32768,32]{1,0} call(reshape.2729, reshape.2733, constant.2690, constant.2691, Arg_1.2682), to_apply=advect_1d_roll_diag_1.1769
  reshape.2735 = f32[32,32,32,32]{3,2,1,0} reshape(call.2734)
  transpose.2737 = f32[32,32,32,32]{2,1,3,0} transpose(reshape.2735), dimensions={0,2,3,1}
  reshape.2738 = f32[32768,32]{1,0} reshape(transpose.2737)
  reshape.2736 = f32[1,1,32]{2,1,0} reshape(Arg_2.2683)
  broadcast.2739 = f32[1,1,32]{2,1,0} broadcast(reshape.2736), dimensions={0,1,2}
  reshape.2740 = f32[32]{0} reshape(broadcast.2739)
  broadcast.2741 = f32[32,32,32]{2,1,0} broadcast(reshape.2740), dimensions={2}
  reshape.2742 = f32[32768]{0} reshape(broadcast.2741)
  call.2743 = f32[32768,32]{1,0} call(reshape.2738, reshape.2742, constant.2693, constant.2692, Arg_1.2682), to_apply=advect_1d_roll_diag.2094
  reshape.2744 = f32[32,32,32,32]{3,2,1,0} reshape(call.2743)
  transpose.2746 = f32[32,32,32,32]{0,2,1,3} transpose(reshape.2744), dimensions={3,1,2,0}
  reshape.2747 = f32[32768,32]{1,0} reshape(transpose.2746)
  reshape.2745 = f32[1,32,1]{2,1,0} reshape(Arg_0.2681)
  broadcast.2748 = f32[1,32,1]{2,1,0} broadcast(reshape.2745), dimensions={0,1,2}
  reshape.2749 = f32[32]{0} reshape(broadcast.2748)
  broadcast.2750 = f32[32,32,32]{2,1,0} broadcast(reshape.2749), dimensions={1}
  reshape.2751 = f32[32768]{0} reshape(broadcast.2750)
  call.2752 = f32[32768,32]{1,0} call(reshape.2747, reshape.2751, constant.2693, constant.2692, Arg_1.2682), to_apply=advect_1d_roll_diag.2516
  reshape.2753 = f32[32,32,32,32]{3,2,1,0} reshape(call.2752)
  transpose.2754 = f32[32,32,32,32]{0,3,2,1} transpose(reshape.2753), dimensions={3,0,1,2}
  get-tuple-element.2716 = f32[32,32]{1,0} get-tuple-element(call.2713), index=2
  get-tuple-element.2717 = f32[32,32]{1,0} get-tuple-element(call.2713), index=3
  ROOT tuple.2755 = (f32[32,32,32,32]{0,3,2,1}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(transpose.2754, get-tuple-element.2716, get-tuple-element.2717)
}

region_0.2756 {
  arg_tuple.2757 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) parameter(0)
  get-tuple-element.2758 = s32[] get-tuple-element(arg_tuple.2757), index=0
  constant.2762 = s32[] constant(1)
  add.2772 = s32[] add(get-tuple-element.2758, constant.2762)
  constant.2767 = f32[32]{0} constant({...})
  constant.2766 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  constant.2765 = f32[32,1]{1,0} constant({...})
  constant.2764 = f32[1,17]{1,0} constant({...})
  constant.2763 = f32[32,17]{1,0} constant({...})
  get-tuple-element.2759 = f32[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.2757), index=1
  get-tuple-element.2760 = f32[32,32]{1,0} get-tuple-element(arg_tuple.2757), index=2
  get-tuple-element.2761 = f32[32,32]{1,0} get-tuple-element(arg_tuple.2757), index=3
  call.2768 = (f32[32,32,32,32]{0,3,2,1}, f32[32,32]{1,0}, f32[32,32]{1,0}) call(constant.2767, constant.2766, constant.2767, constant.2765, constant.2764, constant.2763, get-tuple-element.2759, get-tuple-element.2760, get-tuple-element.2761), to_apply=None.2680
  get-tuple-element.2769 = f32[32,32,32,32]{0,3,2,1} get-tuple-element(call.2768), index=0
  get-tuple-element.2770 = f32[32,32]{1,0} get-tuple-element(call.2768), index=1
  get-tuple-element.2771 = f32[32,32]{1,0} get-tuple-element(call.2768), index=2
  ROOT tuple.2773 = (s32[], f32[32,32,32,32]{0,3,2,1}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(add.2772, get-tuple-element.2769, get-tuple-element.2770, get-tuple-element.2771)
}

region_2.2774 {
  arg_tuple.2775 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) parameter(0)
  get-tuple-element.2777 = f32[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.2775), index=1
  get-tuple-element.2778 = f32[32,32]{1,0} get-tuple-element(arg_tuple.2775), index=2
  get-tuple-element.2779 = f32[32,32]{1,0} get-tuple-element(arg_tuple.2775), index=3
  get-tuple-element.2776 = s32[] get-tuple-element(arg_tuple.2775), index=0
  constant.2780 = s32[] constant(128)
  ROOT compare.2781 = pred[] compare(get-tuple-element.2776, constant.2780), direction=LT
}

ENTRY main.2790 {
  constant.15 = s32[] constant(0)
  Arg_2.3 = f32[32,32,32,32]{3,2,1,0} parameter(2)
  Arg_0.1 = f32[32,32]{1,0} parameter(0)
  Arg_1.2 = f32[32,32]{1,0} parameter(1)
  tuple.16 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(constant.15, Arg_2.3, Arg_0.1, Arg_1.2)
  while.2782 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) while(tuple.16), condition=region_2.2774, body=region_0.2756
  get-tuple-element.2783 = s32[] get-tuple-element(while.2782), index=0
  constant.14 = f32[32]{0} constant({...})
  constant.9 = f32[32]{0} constant({...})
  constant.11 = f32[32,1]{1,0} constant({...})
  constant.12 = f32[1,17]{1,0} constant({...})
  constant.13 = f32[32,17]{1,0} constant({...})
  constant.10 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  get-tuple-element.2785 = f32[32,32]{1,0} get-tuple-element(while.2782), index=2
  get-tuple-element.2786 = f32[32,32]{1,0} get-tuple-element(while.2782), index=3
  get-tuple-element.2784 = f32[32,32,32,32]{3,2,1,0} get-tuple-element(while.2782), index=1
  Arg_3.4 = f32[32,32]{1,0} parameter(3)
  Arg_4.5 = f32[] parameter(4)
  constant.7 = f32[] constant(6.4)
  add.2787 = f32[] add(Arg_4.5, constant.7)
  Arg_5.6 = s32[] parameter(5)
  constant.8 = s32[] constant(128)
  add.2788 = s32[] add(Arg_5.6, constant.8)
  ROOT tuple.2789 = (f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,1]{1,0}, /*index=5*/f32[1,17]{1,0}, f32[32,17]{1,0}, s32[6]{0}, f32[32,32]{1,0}, f32[32,32]{1,0}, /*index=10*/f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[], s32[]) tuple(constant.14, constant.14, constant.9, constant.9, constant.11, constant.12, constant.13, constant.10, get-tuple-element.2785, get-tuple-element.2786, get-tuple-element.2784, Arg_3.4, add.2787, add.2788)
}

