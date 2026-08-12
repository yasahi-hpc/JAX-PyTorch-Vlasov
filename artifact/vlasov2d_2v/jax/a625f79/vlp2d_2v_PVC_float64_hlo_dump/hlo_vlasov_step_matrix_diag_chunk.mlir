HloModule jit_run_chunk, entry_computation_layout={(f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[], /*index=5*/s64[])->(f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32,1]{1,0}, /*index=5*/f64[1,17]{1,0}, f64[32,17]{1,0}, s32[6]{0}, f64[32,32]{1,0}, f64[32,32]{1,0}, /*index=10*/f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[], s64[])}

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
  Arg_0.43 = f64[32768,32]{1,0} parameter(0)
  concatenate.53 = f64[32768,64]{1,0} concatenate(Arg_0.43, Arg_0.43), dimensions={1}
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
  ROOT gather.59 = f64[32768,32]{1,0} gather(concatenate.53, reshape.58), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.86 = f64[32768,32]{1,0} parameter(0)
  concatenate.96 = f64[32768,64]{1,0} concatenate(Arg_0.86, Arg_0.86), dimensions={1}
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
  ROOT gather.102 = f64[32768,32]{1,0} gather(concatenate.96, reshape.101), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.129 = f64[32768,32]{1,0} parameter(0)
  concatenate.139 = f64[32768,64]{1,0} concatenate(Arg_0.129, Arg_0.129), dimensions={1}
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
  ROOT gather.145 = f64[32768,32]{1,0} gather(concatenate.139, reshape.144), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.172 = f64[32768,32]{1,0} parameter(0)
  concatenate.182 = f64[32768,64]{1,0} concatenate(Arg_0.172, Arg_0.172), dimensions={1}
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
  ROOT gather.188 = f64[32768,32]{1,0} gather(concatenate.182, reshape.187), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.215 = f64[32768,32]{1,0} parameter(0)
  concatenate.225 = f64[32768,64]{1,0} concatenate(Arg_0.215, Arg_0.215), dimensions={1}
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
  ROOT gather.231 = f64[32768,32]{1,0} gather(concatenate.225, reshape.230), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.258 = f64[32768,32]{1,0} parameter(0)
  concatenate.268 = f64[32768,64]{1,0} concatenate(Arg_0.258, Arg_0.258), dimensions={1}
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
  ROOT gather.274 = f64[32768,32]{1,0} gather(concatenate.268, reshape.273), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.275 {
  Arg_0.276 = f64[32768,32]{1,0} parameter(0)
  Arg_1.277 = f64[32768]{0} parameter(1)
  Arg_2.278 = f64[] parameter(2)
  broadcast.305 = f64[32768]{0} broadcast(Arg_2.278), dimensions={}
  multiply.306 = f64[32768]{0} multiply(Arg_1.277, broadcast.305)
  Arg_3.279 = f64[] parameter(3)
  broadcast.307 = f64[32768]{0} broadcast(Arg_3.279), dimensions={}
  divide.308 = f64[32768]{0} divide(multiply.306, broadcast.307)
  floor.309 = f64[32768]{0} floor(divide.308)
  convert.311 = s32[32768]{0} convert(floor.309)
  Arg_4.280 = s32[6]{0} parameter(4)
  slice.374 = s32[1]{0} slice(Arg_4.280), slice={[0:1]}
  reshape.375 = s32[] reshape(slice.374)
  broadcast.376 = s32[32768]{0} broadcast(reshape.375), dimensions={}
  add.377 = s32[32768]{0} add(convert.311, broadcast.376)
  call.378 = f64[32768,32]{1,0} call(Arg_0.276, add.377), to_apply=_roll_dynamic.42
  subtract.310 = f64[32768]{0} subtract(divide.308, floor.309)
  constant.303 = f64[] constant(20)
  broadcast.304 = f64[32768]{0} broadcast(constant.303), dimensions={}
  divide.316 = f64[32768]{0} divide(subtract.310, broadcast.304)
  multiply.312 = f64[32768]{0} multiply(subtract.310, subtract.310)
  constant.301 = f64[] constant(24)
  broadcast.302 = f64[32768]{0} broadcast(constant.301), dimensions={}
  divide.317 = f64[32768]{0} divide(multiply.312, broadcast.302)
  subtract.318 = f64[32768]{0} subtract(divide.316, divide.317)
  multiply.313 = f64[32768]{0} multiply(multiply.312, subtract.310)
  divide.319 = f64[32768]{0} divide(multiply.313, broadcast.302)
  subtract.320 = f64[32768]{0} subtract(subtract.318, divide.319)
  multiply.314 = f64[32768]{0} multiply(multiply.313, subtract.310)
  divide.321 = f64[32768]{0} divide(multiply.314, broadcast.302)
  add.322 = f64[32768]{0} add(subtract.320, divide.321)
  multiply.315 = f64[32768]{0} multiply(multiply.314, subtract.310)
  constant.299 = f64[] constant(120)
  broadcast.300 = f64[32768]{0} broadcast(constant.299), dimensions={}
  divide.323 = f64[32768]{0} divide(multiply.315, broadcast.300)
  subtract.324 = f64[32768]{0} subtract(add.322, divide.323)
  reshape.379 = f64[32768,1]{1,0} reshape(subtract.324)
  broadcast.380 = f64[32768,1]{1,0} broadcast(reshape.379), dimensions={0,1}
  reshape.381 = f64[32768]{0} reshape(broadcast.380)
  broadcast.382 = f64[32768,32]{1,0} broadcast(reshape.381), dimensions={0}
  multiply.383 = f64[32768,32]{1,0} multiply(call.378, broadcast.382)
  slice.384 = s32[1]{0} slice(Arg_4.280), slice={[1:2]}
  reshape.385 = s32[] reshape(slice.384)
  broadcast.386 = s32[32768]{0} broadcast(reshape.385), dimensions={}
  add.387 = s32[32768]{0} add(convert.311, broadcast.386)
  call.388 = f64[32768,32]{1,0} call(Arg_0.276, add.387), to_apply=_roll_dynamic.85
  constant.297 = f64[] constant(2)
  broadcast.298 = f64[32768]{0} broadcast(constant.297), dimensions={}
  divide.325 = f64[32768]{0} divide(subtract.310, broadcast.298)
  negate.326 = f64[32768]{0} negate(divide.325)
  multiply.327 = f64[32768]{0} multiply(multiply.312, broadcast.298)
  constant.295 = f64[] constant(3)
  broadcast.296 = f64[32768]{0} broadcast(constant.295), dimensions={}
  divide.328 = f64[32768]{0} divide(multiply.327, broadcast.296)
  add.329 = f64[32768]{0} add(negate.326, divide.328)
  divide.330 = f64[32768]{0} divide(multiply.313, broadcast.302)
  subtract.331 = f64[32768]{0} subtract(add.329, divide.330)
  constant.293 = f64[] constant(6)
  broadcast.294 = f64[32768]{0} broadcast(constant.293), dimensions={}
  divide.332 = f64[32768]{0} divide(multiply.314, broadcast.294)
  subtract.333 = f64[32768]{0} subtract(subtract.331, divide.332)
  divide.334 = f64[32768]{0} divide(multiply.315, broadcast.302)
  add.335 = f64[32768]{0} add(subtract.333, divide.334)
  reshape.389 = f64[32768,1]{1,0} reshape(add.335)
  broadcast.390 = f64[32768,1]{1,0} broadcast(reshape.389), dimensions={0,1}
  reshape.391 = f64[32768]{0} reshape(broadcast.390)
  broadcast.392 = f64[32768,32]{1,0} broadcast(reshape.391), dimensions={0}
  multiply.393 = f64[32768,32]{1,0} multiply(call.388, broadcast.392)
  add.394 = f64[32768,32]{1,0} add(multiply.383, multiply.393)
  slice.395 = s32[1]{0} slice(Arg_4.280), slice={[2:3]}
  reshape.396 = s32[] reshape(slice.395)
  broadcast.397 = s32[32768]{0} broadcast(reshape.396), dimensions={}
  add.398 = s32[32768]{0} add(convert.311, broadcast.397)
  call.399 = f64[32768,32]{1,0} call(Arg_0.276, add.398), to_apply=_roll_dynamic.128
  constant.291 = f64[] constant(1)
  broadcast.292 = f64[32768]{0} broadcast(constant.291), dimensions={}
  divide.336 = f64[32768]{0} divide(subtract.310, broadcast.296)
  subtract.337 = f64[32768]{0} subtract(broadcast.292, divide.336)
  constant.289 = f64[] constant(5)
  broadcast.290 = f64[32768]{0} broadcast(constant.289), dimensions={}
  multiply.338 = f64[32768]{0} multiply(multiply.312, broadcast.290)
  constant.287 = f64[] constant(4)
  broadcast.288 = f64[32768]{0} broadcast(constant.287), dimensions={}
  divide.339 = f64[32768]{0} divide(multiply.338, broadcast.288)
  subtract.340 = f64[32768]{0} subtract(subtract.337, divide.339)
  multiply.341 = f64[32768]{0} multiply(multiply.313, broadcast.290)
  constant.285 = f64[] constant(12)
  broadcast.286 = f64[32768]{0} broadcast(constant.285), dimensions={}
  divide.342 = f64[32768]{0} divide(multiply.341, broadcast.286)
  add.343 = f64[32768]{0} add(subtract.340, divide.342)
  divide.344 = f64[32768]{0} divide(multiply.314, broadcast.288)
  add.345 = f64[32768]{0} add(add.343, divide.344)
  divide.346 = f64[32768]{0} divide(multiply.315, broadcast.286)
  subtract.347 = f64[32768]{0} subtract(add.345, divide.346)
  reshape.400 = f64[32768,1]{1,0} reshape(subtract.347)
  broadcast.401 = f64[32768,1]{1,0} broadcast(reshape.400), dimensions={0,1}
  reshape.402 = f64[32768]{0} reshape(broadcast.401)
  broadcast.403 = f64[32768,32]{1,0} broadcast(reshape.402), dimensions={0}
  multiply.404 = f64[32768,32]{1,0} multiply(call.399, broadcast.403)
  add.405 = f64[32768,32]{1,0} add(add.394, multiply.404)
  slice.406 = s32[1]{0} slice(Arg_4.280), slice={[3:4]}
  reshape.407 = s32[] reshape(slice.406)
  broadcast.408 = s32[32768]{0} broadcast(reshape.407), dimensions={}
  add.409 = s32[32768]{0} add(convert.311, broadcast.408)
  call.410 = f64[32768,32]{1,0} call(Arg_0.276, add.409), to_apply=_roll_dynamic.171
  multiply.348 = f64[32768]{0} multiply(multiply.312, broadcast.298)
  divide.349 = f64[32768]{0} divide(multiply.348, broadcast.296)
  add.350 = f64[32768]{0} add(subtract.310, divide.349)
  constant.283 = f64[] constant(7)
  broadcast.284 = f64[32768]{0} broadcast(constant.283), dimensions={}
  multiply.351 = f64[32768]{0} multiply(multiply.313, broadcast.284)
  divide.352 = f64[32768]{0} divide(multiply.351, broadcast.286)
  subtract.353 = f64[32768]{0} subtract(add.350, divide.352)
  divide.354 = f64[32768]{0} divide(multiply.314, broadcast.294)
  subtract.355 = f64[32768]{0} subtract(subtract.353, divide.354)
  divide.356 = f64[32768]{0} divide(multiply.315, broadcast.286)
  add.357 = f64[32768]{0} add(subtract.355, divide.356)
  reshape.411 = f64[32768,1]{1,0} reshape(add.357)
  broadcast.412 = f64[32768,1]{1,0} broadcast(reshape.411), dimensions={0,1}
  reshape.413 = f64[32768]{0} reshape(broadcast.412)
  broadcast.414 = f64[32768,32]{1,0} broadcast(reshape.413), dimensions={0}
  multiply.415 = f64[32768,32]{1,0} multiply(call.410, broadcast.414)
  add.416 = f64[32768,32]{1,0} add(add.405, multiply.415)
  slice.417 = s32[1]{0} slice(Arg_4.280), slice={[4:5]}
  reshape.418 = s32[] reshape(slice.417)
  broadcast.419 = s32[32768]{0} broadcast(reshape.418), dimensions={}
  add.420 = s32[32768]{0} add(convert.311, broadcast.419)
  call.421 = f64[32768,32]{1,0} call(Arg_0.276, add.420), to_apply=_roll_dynamic.214
  divide.358 = f64[32768]{0} divide(subtract.310, broadcast.288)
  negate.359 = f64[32768]{0} negate(divide.358)
  divide.360 = f64[32768]{0} divide(multiply.312, broadcast.302)
  subtract.361 = f64[32768]{0} subtract(negate.359, divide.360)
  multiply.362 = f64[32768]{0} multiply(multiply.313, broadcast.284)
  divide.363 = f64[32768]{0} divide(multiply.362, broadcast.302)
  add.364 = f64[32768]{0} add(subtract.361, divide.363)
  divide.365 = f64[32768]{0} divide(multiply.314, broadcast.302)
  add.366 = f64[32768]{0} add(add.364, divide.365)
  divide.367 = f64[32768]{0} divide(multiply.315, broadcast.302)
  subtract.368 = f64[32768]{0} subtract(add.366, divide.367)
  reshape.422 = f64[32768,1]{1,0} reshape(subtract.368)
  broadcast.423 = f64[32768,1]{1,0} broadcast(reshape.422), dimensions={0,1}
  reshape.424 = f64[32768]{0} reshape(broadcast.423)
  broadcast.425 = f64[32768,32]{1,0} broadcast(reshape.424), dimensions={0}
  multiply.426 = f64[32768,32]{1,0} multiply(call.421, broadcast.425)
  add.427 = f64[32768,32]{1,0} add(add.416, multiply.426)
  slice.428 = s32[1]{0} slice(Arg_4.280), slice={[5:6]}
  reshape.429 = s32[] reshape(slice.428)
  broadcast.430 = s32[32768]{0} broadcast(reshape.429), dimensions={}
  add.431 = s32[32768]{0} add(convert.311, broadcast.430)
  call.432 = f64[32768,32]{1,0} call(Arg_0.276, add.431), to_apply=_roll_dynamic.257
  constant.281 = f64[] constant(30)
  broadcast.282 = f64[32768]{0} broadcast(constant.281), dimensions={}
  divide.369 = f64[32768]{0} divide(subtract.310, broadcast.282)
  divide.370 = f64[32768]{0} divide(multiply.313, broadcast.302)
  subtract.371 = f64[32768]{0} subtract(divide.369, divide.370)
  divide.372 = f64[32768]{0} divide(multiply.315, broadcast.300)
  add.373 = f64[32768]{0} add(subtract.371, divide.372)
  reshape.433 = f64[32768,1]{1,0} reshape(add.373)
  broadcast.434 = f64[32768,1]{1,0} broadcast(reshape.433), dimensions={0,1}
  reshape.435 = f64[32768]{0} reshape(broadcast.434)
  broadcast.436 = f64[32768,32]{1,0} broadcast(reshape.435), dimensions={0}
  multiply.437 = f64[32768,32]{1,0} multiply(call.432, broadcast.436)
  ROOT add.438 = f64[32768,32]{1,0} add(add.427, multiply.437)
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
  Arg_0.465 = f64[32768,32]{1,0} parameter(0)
  concatenate.475 = f64[32768,64]{1,0} concatenate(Arg_0.465, Arg_0.465), dimensions={1}
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
  ROOT gather.481 = f64[32768,32]{1,0} gather(concatenate.475, reshape.480), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.508 = f64[32768,32]{1,0} parameter(0)
  concatenate.518 = f64[32768,64]{1,0} concatenate(Arg_0.508, Arg_0.508), dimensions={1}
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
  ROOT gather.524 = f64[32768,32]{1,0} gather(concatenate.518, reshape.523), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.551 = f64[32768,32]{1,0} parameter(0)
  concatenate.561 = f64[32768,64]{1,0} concatenate(Arg_0.551, Arg_0.551), dimensions={1}
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
  ROOT gather.567 = f64[32768,32]{1,0} gather(concatenate.561, reshape.566), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.594 = f64[32768,32]{1,0} parameter(0)
  concatenate.604 = f64[32768,64]{1,0} concatenate(Arg_0.594, Arg_0.594), dimensions={1}
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
  ROOT gather.610 = f64[32768,32]{1,0} gather(concatenate.604, reshape.609), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.637 = f64[32768,32]{1,0} parameter(0)
  concatenate.647 = f64[32768,64]{1,0} concatenate(Arg_0.637, Arg_0.637), dimensions={1}
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
  ROOT gather.653 = f64[32768,32]{1,0} gather(concatenate.647, reshape.652), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
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
  Arg_0.680 = f64[32768,32]{1,0} parameter(0)
  concatenate.690 = f64[32768,64]{1,0} concatenate(Arg_0.680, Arg_0.680), dimensions={1}
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
  ROOT gather.696 = f64[32768,32]{1,0} gather(concatenate.690, reshape.695), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.697 {
  Arg_0.698 = f64[32768,32]{1,0} parameter(0)
  Arg_1.699 = f64[32768]{0} parameter(1)
  Arg_2.700 = f64[] parameter(2)
  broadcast.727 = f64[32768]{0} broadcast(Arg_2.700), dimensions={}
  multiply.728 = f64[32768]{0} multiply(Arg_1.699, broadcast.727)
  Arg_3.701 = f64[] parameter(3)
  broadcast.729 = f64[32768]{0} broadcast(Arg_3.701), dimensions={}
  divide.730 = f64[32768]{0} divide(multiply.728, broadcast.729)
  floor.731 = f64[32768]{0} floor(divide.730)
  convert.733 = s32[32768]{0} convert(floor.731)
  Arg_4.702 = s32[6]{0} parameter(4)
  slice.796 = s32[1]{0} slice(Arg_4.702), slice={[0:1]}
  reshape.797 = s32[] reshape(slice.796)
  broadcast.798 = s32[32768]{0} broadcast(reshape.797), dimensions={}
  add.799 = s32[32768]{0} add(convert.733, broadcast.798)
  call.800 = f64[32768,32]{1,0} call(Arg_0.698, add.799), to_apply=_roll_dynamic.464
  subtract.732 = f64[32768]{0} subtract(divide.730, floor.731)
  constant.725 = f64[] constant(20)
  broadcast.726 = f64[32768]{0} broadcast(constant.725), dimensions={}
  divide.738 = f64[32768]{0} divide(subtract.732, broadcast.726)
  multiply.734 = f64[32768]{0} multiply(subtract.732, subtract.732)
  constant.723 = f64[] constant(24)
  broadcast.724 = f64[32768]{0} broadcast(constant.723), dimensions={}
  divide.739 = f64[32768]{0} divide(multiply.734, broadcast.724)
  subtract.740 = f64[32768]{0} subtract(divide.738, divide.739)
  multiply.735 = f64[32768]{0} multiply(multiply.734, subtract.732)
  divide.741 = f64[32768]{0} divide(multiply.735, broadcast.724)
  subtract.742 = f64[32768]{0} subtract(subtract.740, divide.741)
  multiply.736 = f64[32768]{0} multiply(multiply.735, subtract.732)
  divide.743 = f64[32768]{0} divide(multiply.736, broadcast.724)
  add.744 = f64[32768]{0} add(subtract.742, divide.743)
  multiply.737 = f64[32768]{0} multiply(multiply.736, subtract.732)
  constant.721 = f64[] constant(120)
  broadcast.722 = f64[32768]{0} broadcast(constant.721), dimensions={}
  divide.745 = f64[32768]{0} divide(multiply.737, broadcast.722)
  subtract.746 = f64[32768]{0} subtract(add.744, divide.745)
  reshape.801 = f64[32768,1]{1,0} reshape(subtract.746)
  broadcast.802 = f64[32768,1]{1,0} broadcast(reshape.801), dimensions={0,1}
  reshape.803 = f64[32768]{0} reshape(broadcast.802)
  broadcast.804 = f64[32768,32]{1,0} broadcast(reshape.803), dimensions={0}
  multiply.805 = f64[32768,32]{1,0} multiply(call.800, broadcast.804)
  slice.806 = s32[1]{0} slice(Arg_4.702), slice={[1:2]}
  reshape.807 = s32[] reshape(slice.806)
  broadcast.808 = s32[32768]{0} broadcast(reshape.807), dimensions={}
  add.809 = s32[32768]{0} add(convert.733, broadcast.808)
  call.810 = f64[32768,32]{1,0} call(Arg_0.698, add.809), to_apply=_roll_dynamic.507
  constant.719 = f64[] constant(2)
  broadcast.720 = f64[32768]{0} broadcast(constant.719), dimensions={}
  divide.747 = f64[32768]{0} divide(subtract.732, broadcast.720)
  negate.748 = f64[32768]{0} negate(divide.747)
  multiply.749 = f64[32768]{0} multiply(multiply.734, broadcast.720)
  constant.717 = f64[] constant(3)
  broadcast.718 = f64[32768]{0} broadcast(constant.717), dimensions={}
  divide.750 = f64[32768]{0} divide(multiply.749, broadcast.718)
  add.751 = f64[32768]{0} add(negate.748, divide.750)
  divide.752 = f64[32768]{0} divide(multiply.735, broadcast.724)
  subtract.753 = f64[32768]{0} subtract(add.751, divide.752)
  constant.715 = f64[] constant(6)
  broadcast.716 = f64[32768]{0} broadcast(constant.715), dimensions={}
  divide.754 = f64[32768]{0} divide(multiply.736, broadcast.716)
  subtract.755 = f64[32768]{0} subtract(subtract.753, divide.754)
  divide.756 = f64[32768]{0} divide(multiply.737, broadcast.724)
  add.757 = f64[32768]{0} add(subtract.755, divide.756)
  reshape.811 = f64[32768,1]{1,0} reshape(add.757)
  broadcast.812 = f64[32768,1]{1,0} broadcast(reshape.811), dimensions={0,1}
  reshape.813 = f64[32768]{0} reshape(broadcast.812)
  broadcast.814 = f64[32768,32]{1,0} broadcast(reshape.813), dimensions={0}
  multiply.815 = f64[32768,32]{1,0} multiply(call.810, broadcast.814)
  add.816 = f64[32768,32]{1,0} add(multiply.805, multiply.815)
  slice.817 = s32[1]{0} slice(Arg_4.702), slice={[2:3]}
  reshape.818 = s32[] reshape(slice.817)
  broadcast.819 = s32[32768]{0} broadcast(reshape.818), dimensions={}
  add.820 = s32[32768]{0} add(convert.733, broadcast.819)
  call.821 = f64[32768,32]{1,0} call(Arg_0.698, add.820), to_apply=_roll_dynamic.550
  constant.713 = f64[] constant(1)
  broadcast.714 = f64[32768]{0} broadcast(constant.713), dimensions={}
  divide.758 = f64[32768]{0} divide(subtract.732, broadcast.718)
  subtract.759 = f64[32768]{0} subtract(broadcast.714, divide.758)
  constant.711 = f64[] constant(5)
  broadcast.712 = f64[32768]{0} broadcast(constant.711), dimensions={}
  multiply.760 = f64[32768]{0} multiply(multiply.734, broadcast.712)
  constant.709 = f64[] constant(4)
  broadcast.710 = f64[32768]{0} broadcast(constant.709), dimensions={}
  divide.761 = f64[32768]{0} divide(multiply.760, broadcast.710)
  subtract.762 = f64[32768]{0} subtract(subtract.759, divide.761)
  multiply.763 = f64[32768]{0} multiply(multiply.735, broadcast.712)
  constant.707 = f64[] constant(12)
  broadcast.708 = f64[32768]{0} broadcast(constant.707), dimensions={}
  divide.764 = f64[32768]{0} divide(multiply.763, broadcast.708)
  add.765 = f64[32768]{0} add(subtract.762, divide.764)
  divide.766 = f64[32768]{0} divide(multiply.736, broadcast.710)
  add.767 = f64[32768]{0} add(add.765, divide.766)
  divide.768 = f64[32768]{0} divide(multiply.737, broadcast.708)
  subtract.769 = f64[32768]{0} subtract(add.767, divide.768)
  reshape.822 = f64[32768,1]{1,0} reshape(subtract.769)
  broadcast.823 = f64[32768,1]{1,0} broadcast(reshape.822), dimensions={0,1}
  reshape.824 = f64[32768]{0} reshape(broadcast.823)
  broadcast.825 = f64[32768,32]{1,0} broadcast(reshape.824), dimensions={0}
  multiply.826 = f64[32768,32]{1,0} multiply(call.821, broadcast.825)
  add.827 = f64[32768,32]{1,0} add(add.816, multiply.826)
  slice.828 = s32[1]{0} slice(Arg_4.702), slice={[3:4]}
  reshape.829 = s32[] reshape(slice.828)
  broadcast.830 = s32[32768]{0} broadcast(reshape.829), dimensions={}
  add.831 = s32[32768]{0} add(convert.733, broadcast.830)
  call.832 = f64[32768,32]{1,0} call(Arg_0.698, add.831), to_apply=_roll_dynamic.593
  multiply.770 = f64[32768]{0} multiply(multiply.734, broadcast.720)
  divide.771 = f64[32768]{0} divide(multiply.770, broadcast.718)
  add.772 = f64[32768]{0} add(subtract.732, divide.771)
  constant.705 = f64[] constant(7)
  broadcast.706 = f64[32768]{0} broadcast(constant.705), dimensions={}
  multiply.773 = f64[32768]{0} multiply(multiply.735, broadcast.706)
  divide.774 = f64[32768]{0} divide(multiply.773, broadcast.708)
  subtract.775 = f64[32768]{0} subtract(add.772, divide.774)
  divide.776 = f64[32768]{0} divide(multiply.736, broadcast.716)
  subtract.777 = f64[32768]{0} subtract(subtract.775, divide.776)
  divide.778 = f64[32768]{0} divide(multiply.737, broadcast.708)
  add.779 = f64[32768]{0} add(subtract.777, divide.778)
  reshape.833 = f64[32768,1]{1,0} reshape(add.779)
  broadcast.834 = f64[32768,1]{1,0} broadcast(reshape.833), dimensions={0,1}
  reshape.835 = f64[32768]{0} reshape(broadcast.834)
  broadcast.836 = f64[32768,32]{1,0} broadcast(reshape.835), dimensions={0}
  multiply.837 = f64[32768,32]{1,0} multiply(call.832, broadcast.836)
  add.838 = f64[32768,32]{1,0} add(add.827, multiply.837)
  slice.839 = s32[1]{0} slice(Arg_4.702), slice={[4:5]}
  reshape.840 = s32[] reshape(slice.839)
  broadcast.841 = s32[32768]{0} broadcast(reshape.840), dimensions={}
  add.842 = s32[32768]{0} add(convert.733, broadcast.841)
  call.843 = f64[32768,32]{1,0} call(Arg_0.698, add.842), to_apply=_roll_dynamic.636
  divide.780 = f64[32768]{0} divide(subtract.732, broadcast.710)
  negate.781 = f64[32768]{0} negate(divide.780)
  divide.782 = f64[32768]{0} divide(multiply.734, broadcast.724)
  subtract.783 = f64[32768]{0} subtract(negate.781, divide.782)
  multiply.784 = f64[32768]{0} multiply(multiply.735, broadcast.706)
  divide.785 = f64[32768]{0} divide(multiply.784, broadcast.724)
  add.786 = f64[32768]{0} add(subtract.783, divide.785)
  divide.787 = f64[32768]{0} divide(multiply.736, broadcast.724)
  add.788 = f64[32768]{0} add(add.786, divide.787)
  divide.789 = f64[32768]{0} divide(multiply.737, broadcast.724)
  subtract.790 = f64[32768]{0} subtract(add.788, divide.789)
  reshape.844 = f64[32768,1]{1,0} reshape(subtract.790)
  broadcast.845 = f64[32768,1]{1,0} broadcast(reshape.844), dimensions={0,1}
  reshape.846 = f64[32768]{0} reshape(broadcast.845)
  broadcast.847 = f64[32768,32]{1,0} broadcast(reshape.846), dimensions={0}
  multiply.848 = f64[32768,32]{1,0} multiply(call.843, broadcast.847)
  add.849 = f64[32768,32]{1,0} add(add.838, multiply.848)
  slice.850 = s32[1]{0} slice(Arg_4.702), slice={[5:6]}
  reshape.851 = s32[] reshape(slice.850)
  broadcast.852 = s32[32768]{0} broadcast(reshape.851), dimensions={}
  add.853 = s32[32768]{0} add(convert.733, broadcast.852)
  call.854 = f64[32768,32]{1,0} call(Arg_0.698, add.853), to_apply=_roll_dynamic.679
  constant.703 = f64[] constant(30)
  broadcast.704 = f64[32768]{0} broadcast(constant.703), dimensions={}
  divide.791 = f64[32768]{0} divide(subtract.732, broadcast.704)
  divide.792 = f64[32768]{0} divide(multiply.735, broadcast.724)
  subtract.793 = f64[32768]{0} subtract(divide.791, divide.792)
  divide.794 = f64[32768]{0} divide(multiply.737, broadcast.722)
  add.795 = f64[32768]{0} add(subtract.793, divide.794)
  reshape.855 = f64[32768,1]{1,0} reshape(add.795)
  broadcast.856 = f64[32768,1]{1,0} broadcast(reshape.855), dimensions={0,1}
  reshape.857 = f64[32768]{0} reshape(broadcast.856)
  broadcast.858 = f64[32768,32]{1,0} broadcast(reshape.857), dimensions={0}
  multiply.859 = f64[32768,32]{1,0} multiply(call.854, broadcast.858)
  ROOT add.860 = f64[32768,32]{1,0} add(add.849, multiply.859)
}

region_1.861 {
  Arg_0.862 = f64[] parameter(0)
  Arg_1.863 = f64[] parameter(1)
  ROOT add.864 = f64[] add(Arg_0.862, Arg_1.863)
}

fft.865 {
  Arg_0.866 = f64[32,32]{1,0} parameter(0)
  ROOT fft.867 = c128[32,17]{1,0} fft(Arg_0.866), fft_type=RFFT, fft_length={32,32}
}

fft_0.868 {
  Arg_0.869 = c128[32,17]{1,0} parameter(0)
  ROOT fft.870 = f64[32,32]{1,0} fft(Arg_0.869), fft_type=IRFFT, fft_length={32,32}
}

fft_0.871 {
  Arg_0.872 = c128[32,17]{1,0} parameter(0)
  ROOT fft.873 = f64[32,32]{1,0} fft(Arg_0.872), fft_type=IRFFT, fft_length={32,32}
}

fft_0.874 {
  Arg_0.875 = c128[32,17]{1,0} parameter(0)
  ROOT fft.876 = f64[32,32]{1,0} fft(Arg_0.875), fft_type=IRFFT, fft_length={32,32}
}

solve_poisson.877 {
  Arg_1.879 = f64[32,1]{1,0} parameter(1)
  convert.901 = c128[32,1]{1,0} convert(Arg_1.879)
  constant.886 = c128[] constant((-0, -1))
  broadcast.887 = c128[32,1]{1,0} broadcast(constant.886), dimensions={}
  multiply.902 = c128[32,1]{1,0} multiply(convert.901, broadcast.887)
  broadcast.903 = c128[32,1]{1,0} broadcast(multiply.902), dimensions={0,1}
  reshape.904 = c128[32]{0} reshape(broadcast.903)
  broadcast.905 = c128[32,17]{1,0} broadcast(reshape.904), dimensions={0}
  Arg_0.878 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  constant.890 = f64[] constant(0)
  reduce.891 = f64[32,32]{1,0} reduce(Arg_0.878, constant.890), dimensions={2,3}, to_apply=region_1.861
  Arg_4.882 = f64[] parameter(4)
  broadcast.892 = f64[32,32]{1,0} broadcast(Arg_4.882), dimensions={}
  multiply.893 = f64[32,32]{1,0} multiply(reduce.891, broadcast.892)
  Arg_5.883 = f64[] parameter(5)
  broadcast.894 = f64[32,32]{1,0} broadcast(Arg_5.883), dimensions={}
  multiply.895 = f64[32,32]{1,0} multiply(multiply.893, broadcast.894)
  constant.888 = f64[] constant(1)
  broadcast.889 = f64[32,32]{1,0} broadcast(constant.888), dimensions={}
  subtract.896 = f64[32,32]{1,0} subtract(multiply.895, broadcast.889)
  call.897 = c128[32,17]{1,0} call(subtract.896), to_apply=fft.865
  Arg_3.881 = f64[32,17]{1,0} parameter(3)
  convert.898 = c128[32,17]{1,0} convert(Arg_3.881)
  multiply.899 = c128[32,17]{1,0} multiply(call.897, convert.898)
  multiply.906 = c128[32,17]{1,0} multiply(broadcast.905, multiply.899)
  call.913 = f64[32,32]{1,0} call(multiply.906), to_apply=fft_0.871
  Arg_2.880 = f64[1,17]{1,0} parameter(2)
  convert.907 = c128[1,17]{1,0} convert(Arg_2.880)
  constant.884 = c128[] constant((-0, -1))
  broadcast.885 = c128[1,17]{1,0} broadcast(constant.884), dimensions={}
  multiply.908 = c128[1,17]{1,0} multiply(convert.907, broadcast.885)
  broadcast.909 = c128[1,17]{1,0} broadcast(multiply.908), dimensions={0,1}
  reshape.910 = c128[17]{0} reshape(broadcast.909)
  broadcast.911 = c128[32,17]{1,0} broadcast(reshape.910), dimensions={1}
  multiply.912 = c128[32,17]{1,0} multiply(broadcast.911, multiply.899)
  call.914 = f64[32,32]{1,0} call(multiply.912), to_apply=fft_0.874
  call.900 = f64[32,32]{1,0} call(multiply.899), to_apply=fft_0.868
  ROOT tuple.915 = (f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(call.913, call.914, subtract.896, call.900)
}

_where_2.916 {
  Arg_0.917 = pred[6,32768,32]{2,1,0} parameter(0)
  Arg_1.918 = f64[6,32768,1]{2,1,0} parameter(1)
  broadcast.920 = f64[6,32768,1]{2,1,0} broadcast(Arg_1.918), dimensions={0,1,2}
  reshape.921 = f64[6,32768]{1,0} reshape(broadcast.920)
  broadcast.922 = f64[6,32768,32]{2,1,0} broadcast(reshape.921), dimensions={0,1}
  Arg_2.919 = f64[] parameter(2)
  broadcast.923 = f64[6,32768,32]{2,1,0} broadcast(Arg_2.919), dimensions={}
  ROOT select.924 = f64[6,32768,32]{2,1,0} select(Arg_0.917, broadcast.922, broadcast.923)
}

build_v_diag_weights.925 {
  iota.1027 = s64[32]{0} iota(), iota_dimension=0
  reshape.1037 = s64[1,1,32]{2,1,0} reshape(iota.1027)
  broadcast.1040 = s64[1,1,32]{2,1,0} broadcast(reshape.1037), dimensions={0,1,2}
  reshape.1041 = s64[32]{0} reshape(broadcast.1040)
  broadcast.1042 = s64[6,32768,32]{2,1,0} broadcast(reshape.1041), dimensions={2}
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
  convert.1039 = s64[6,32768,1]{2,1,0} convert(reshape.1038)
  broadcast.1043 = s64[6,32768,1]{2,1,0} broadcast(convert.1039), dimensions={0,1,2}
  reshape.1044 = s64[6,32768]{1,0} reshape(broadcast.1043)
  broadcast.1045 = s64[6,32768,32]{2,1,0} broadcast(reshape.1044), dimensions={0,1}
  subtract.1046 = s64[6,32768,32]{2,1,0} subtract(broadcast.1042, broadcast.1045)
  constant.931 = s64[] constant(0)
  broadcast.932 = s64[6,32768,32]{2,1,0} broadcast(constant.931), dimensions={}
  compare.1047 = pred[6,32768,32]{2,1,0} compare(subtract.1046, broadcast.932), direction=GE
  constant.929 = s64[] constant(32)
  broadcast.930 = s64[6,32768,32]{2,1,0} broadcast(constant.929), dimensions={}
  compare.1048 = pred[6,32768,32]{2,1,0} compare(subtract.1046, broadcast.930), direction=LT
  and.1049 = pred[6,32768,32]{2,1,0} and(compare.1047, compare.1048)
  Arg_2.928 = f64[32768]{0} parameter(2)
  constant.955 = f64[] constant(20)
  broadcast.956 = f64[32768]{0} broadcast(constant.955), dimensions={}
  divide.962 = f64[32768]{0} divide(Arg_2.928, broadcast.956)
  multiply.958 = f64[32768]{0} multiply(Arg_2.928, Arg_2.928)
  constant.953 = f64[] constant(24)
  broadcast.954 = f64[32768]{0} broadcast(constant.953), dimensions={}
  divide.963 = f64[32768]{0} divide(multiply.958, broadcast.954)
  subtract.964 = f64[32768]{0} subtract(divide.962, divide.963)
  multiply.959 = f64[32768]{0} multiply(multiply.958, Arg_2.928)
  divide.965 = f64[32768]{0} divide(multiply.959, broadcast.954)
  subtract.966 = f64[32768]{0} subtract(subtract.964, divide.965)
  multiply.960 = f64[32768]{0} multiply(multiply.959, Arg_2.928)
  divide.967 = f64[32768]{0} divide(multiply.960, broadcast.954)
  add.968 = f64[32768]{0} add(subtract.966, divide.967)
  multiply.961 = f64[32768]{0} multiply(multiply.960, Arg_2.928)
  constant.951 = f64[] constant(120)
  broadcast.952 = f64[32768]{0} broadcast(constant.951), dimensions={}
  divide.969 = f64[32768]{0} divide(multiply.961, broadcast.952)
  subtract.970 = f64[32768]{0} subtract(add.968, divide.969)
  reshape.1020 = f64[1,32768]{1,0} reshape(subtract.970)
  constant.949 = f64[] constant(2)
  broadcast.950 = f64[32768]{0} broadcast(constant.949), dimensions={}
  divide.971 = f64[32768]{0} divide(Arg_2.928, broadcast.950)
  negate.972 = f64[32768]{0} negate(divide.971)
  multiply.973 = f64[32768]{0} multiply(multiply.958, broadcast.950)
  constant.947 = f64[] constant(3)
  broadcast.948 = f64[32768]{0} broadcast(constant.947), dimensions={}
  divide.974 = f64[32768]{0} divide(multiply.973, broadcast.948)
  add.975 = f64[32768]{0} add(negate.972, divide.974)
  divide.976 = f64[32768]{0} divide(multiply.959, broadcast.954)
  subtract.977 = f64[32768]{0} subtract(add.975, divide.976)
  constant.945 = f64[] constant(6)
  broadcast.946 = f64[32768]{0} broadcast(constant.945), dimensions={}
  divide.978 = f64[32768]{0} divide(multiply.960, broadcast.946)
  subtract.979 = f64[32768]{0} subtract(subtract.977, divide.978)
  divide.980 = f64[32768]{0} divide(multiply.961, broadcast.954)
  add.981 = f64[32768]{0} add(subtract.979, divide.980)
  reshape.1021 = f64[1,32768]{1,0} reshape(add.981)
  constant.943 = f64[] constant(1)
  broadcast.944 = f64[32768]{0} broadcast(constant.943), dimensions={}
  divide.982 = f64[32768]{0} divide(Arg_2.928, broadcast.948)
  subtract.983 = f64[32768]{0} subtract(broadcast.944, divide.982)
  constant.941 = f64[] constant(5)
  broadcast.942 = f64[32768]{0} broadcast(constant.941), dimensions={}
  multiply.984 = f64[32768]{0} multiply(multiply.958, broadcast.942)
  constant.939 = f64[] constant(4)
  broadcast.940 = f64[32768]{0} broadcast(constant.939), dimensions={}
  divide.985 = f64[32768]{0} divide(multiply.984, broadcast.940)
  subtract.986 = f64[32768]{0} subtract(subtract.983, divide.985)
  multiply.987 = f64[32768]{0} multiply(multiply.959, broadcast.942)
  constant.937 = f64[] constant(12)
  broadcast.938 = f64[32768]{0} broadcast(constant.937), dimensions={}
  divide.988 = f64[32768]{0} divide(multiply.987, broadcast.938)
  add.989 = f64[32768]{0} add(subtract.986, divide.988)
  divide.990 = f64[32768]{0} divide(multiply.960, broadcast.940)
  add.991 = f64[32768]{0} add(add.989, divide.990)
  divide.992 = f64[32768]{0} divide(multiply.961, broadcast.938)
  subtract.993 = f64[32768]{0} subtract(add.991, divide.992)
  reshape.1022 = f64[1,32768]{1,0} reshape(subtract.993)
  multiply.994 = f64[32768]{0} multiply(multiply.958, broadcast.950)
  divide.995 = f64[32768]{0} divide(multiply.994, broadcast.948)
  add.996 = f64[32768]{0} add(Arg_2.928, divide.995)
  constant.935 = f64[] constant(7)
  broadcast.936 = f64[32768]{0} broadcast(constant.935), dimensions={}
  multiply.997 = f64[32768]{0} multiply(multiply.959, broadcast.936)
  divide.998 = f64[32768]{0} divide(multiply.997, broadcast.938)
  subtract.999 = f64[32768]{0} subtract(add.996, divide.998)
  divide.1000 = f64[32768]{0} divide(multiply.960, broadcast.946)
  subtract.1001 = f64[32768]{0} subtract(subtract.999, divide.1000)
  divide.1002 = f64[32768]{0} divide(multiply.961, broadcast.938)
  add.1003 = f64[32768]{0} add(subtract.1001, divide.1002)
  reshape.1023 = f64[1,32768]{1,0} reshape(add.1003)
  divide.1004 = f64[32768]{0} divide(Arg_2.928, broadcast.940)
  negate.1005 = f64[32768]{0} negate(divide.1004)
  divide.1006 = f64[32768]{0} divide(multiply.958, broadcast.954)
  subtract.1007 = f64[32768]{0} subtract(negate.1005, divide.1006)
  multiply.1008 = f64[32768]{0} multiply(multiply.959, broadcast.936)
  divide.1009 = f64[32768]{0} divide(multiply.1008, broadcast.954)
  add.1010 = f64[32768]{0} add(subtract.1007, divide.1009)
  divide.1011 = f64[32768]{0} divide(multiply.960, broadcast.954)
  add.1012 = f64[32768]{0} add(add.1010, divide.1011)
  divide.1013 = f64[32768]{0} divide(multiply.961, broadcast.954)
  subtract.1014 = f64[32768]{0} subtract(add.1012, divide.1013)
  reshape.1024 = f64[1,32768]{1,0} reshape(subtract.1014)
  constant.933 = f64[] constant(30)
  broadcast.934 = f64[32768]{0} broadcast(constant.933), dimensions={}
  divide.1015 = f64[32768]{0} divide(Arg_2.928, broadcast.934)
  divide.1016 = f64[32768]{0} divide(multiply.959, broadcast.954)
  subtract.1017 = f64[32768]{0} subtract(divide.1015, divide.1016)
  divide.1018 = f64[32768]{0} divide(multiply.961, broadcast.952)
  add.1019 = f64[32768]{0} add(subtract.1017, divide.1018)
  reshape.1025 = f64[1,32768]{1,0} reshape(add.1019)
  concatenate.1026 = f64[6,32768]{1,0} concatenate(reshape.1020, reshape.1021, reshape.1022, reshape.1023, reshape.1024, reshape.1025), dimensions={0}
  reshape.1050 = f64[6,32768,1]{2,1,0} reshape(concatenate.1026)
  constant.957 = f64[] constant(0)
  ROOT call.1051 = f64[6,32768,32]{2,1,0} call(and.1049, reshape.1050, constant.957), to_apply=_where_2.916
}

_where.1052 {
  Arg_0.1053 = pred[] parameter(0)
  Arg_1.1054 = s32[] parameter(1)
  Arg_2.1055 = s32[] parameter(2)
  ROOT select.1056 = s32[] select(Arg_0.1053, Arg_1.1054, Arg_2.1055)
}

remainder.1057 {
  Arg_0.1058 = s32[32768]{0} parameter(0)
  Arg_1.1059 = s32[] parameter(1)
  constant.1063 = s32[] constant(0)
  compare.1064 = pred[] compare(Arg_1.1059, constant.1063), direction=EQ
  constant.1062 = s32[] constant(1)
  call.1065 = s32[] call(compare.1064, constant.1062, Arg_1.1059), to_apply=_where.1052
  broadcast.1066 = s32[32768]{0} broadcast(call.1065), dimensions={}
  remainder.1067 = s32[32768]{0} remainder(Arg_0.1058, broadcast.1066)
  constant.1060 = s32[] constant(0)
  broadcast.1061 = s32[32768]{0} broadcast(constant.1060), dimensions={}
  compare.1069 = pred[32768]{0} compare(remainder.1067, broadcast.1061), direction=LT
  compare.1070 = pred[] compare(call.1065, constant.1063), direction=LT
  broadcast.1071 = pred[32768]{0} broadcast(compare.1070), dimensions={}
  compare.1072 = pred[32768]{0} compare(compare.1069, broadcast.1071), direction=NE
  compare.1068 = pred[32768]{0} compare(remainder.1067, broadcast.1061), direction=NE
  and.1073 = pred[32768]{0} and(compare.1072, compare.1068)
  broadcast.1074 = s32[32768]{0} broadcast(call.1065), dimensions={}
  add.1075 = s32[32768]{0} add(remainder.1067, broadcast.1074)
  ROOT select.1076 = s32[32768]{0} select(and.1073, add.1075, remainder.1067)
}

_roll_dynamic.1077 {
  Arg_0.1078 = f64[32768,32]{1,0} parameter(0)
  concatenate.1088 = f64[32768,64]{1,0} concatenate(Arg_0.1078, Arg_0.1078), dimensions={1}
  constant.1084 = s32[] constant(32)
  broadcast.1085 = s32[32768]{0} broadcast(constant.1084), dimensions={}
  Arg_1.1079 = s32[32768]{0} parameter(1)
  constant.1086 = s32[] constant(32)
  call.1087 = s32[32768]{0} call(Arg_1.1079, constant.1086), to_apply=remainder.1057
  subtract.1089 = s32[32768]{0} subtract(broadcast.1085, call.1087)
  constant.1082 = s32[] constant(0)
  broadcast.1083 = s32[32768]{0} broadcast(constant.1082), dimensions={}
  compare.1090 = pred[32768]{0} compare(subtract.1089, broadcast.1083), direction=LT
  constant.1080 = s32[] constant(64)
  broadcast.1081 = s32[32768]{0} broadcast(constant.1080), dimensions={}
  add.1091 = s32[32768]{0} add(subtract.1089, broadcast.1081)
  select.1092 = s32[32768]{0} select(compare.1090, add.1091, subtract.1089)
  reshape.1093 = s32[32768,1]{1,0} reshape(select.1092)
  ROOT gather.1094 = f64[32768,32]{1,0} gather(concatenate.1088, reshape.1093), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1095 {
  Arg_0.1096 = pred[] parameter(0)
  Arg_1.1097 = s32[] parameter(1)
  Arg_2.1098 = s32[] parameter(2)
  ROOT select.1099 = s32[] select(Arg_0.1096, Arg_1.1097, Arg_2.1098)
}

remainder.1100 {
  Arg_0.1101 = s32[32768]{0} parameter(0)
  Arg_1.1102 = s32[] parameter(1)
  constant.1106 = s32[] constant(0)
  compare.1107 = pred[] compare(Arg_1.1102, constant.1106), direction=EQ
  constant.1105 = s32[] constant(1)
  call.1108 = s32[] call(compare.1107, constant.1105, Arg_1.1102), to_apply=_where.1095
  broadcast.1109 = s32[32768]{0} broadcast(call.1108), dimensions={}
  remainder.1110 = s32[32768]{0} remainder(Arg_0.1101, broadcast.1109)
  constant.1103 = s32[] constant(0)
  broadcast.1104 = s32[32768]{0} broadcast(constant.1103), dimensions={}
  compare.1112 = pred[32768]{0} compare(remainder.1110, broadcast.1104), direction=LT
  compare.1113 = pred[] compare(call.1108, constant.1106), direction=LT
  broadcast.1114 = pred[32768]{0} broadcast(compare.1113), dimensions={}
  compare.1115 = pred[32768]{0} compare(compare.1112, broadcast.1114), direction=NE
  compare.1111 = pred[32768]{0} compare(remainder.1110, broadcast.1104), direction=NE
  and.1116 = pred[32768]{0} and(compare.1115, compare.1111)
  broadcast.1117 = s32[32768]{0} broadcast(call.1108), dimensions={}
  add.1118 = s32[32768]{0} add(remainder.1110, broadcast.1117)
  ROOT select.1119 = s32[32768]{0} select(and.1116, add.1118, remainder.1110)
}

_roll_dynamic.1120 {
  Arg_0.1121 = f64[32768,32]{1,0} parameter(0)
  concatenate.1131 = f64[32768,64]{1,0} concatenate(Arg_0.1121, Arg_0.1121), dimensions={1}
  constant.1127 = s32[] constant(32)
  broadcast.1128 = s32[32768]{0} broadcast(constant.1127), dimensions={}
  Arg_1.1122 = s32[32768]{0} parameter(1)
  constant.1129 = s32[] constant(32)
  call.1130 = s32[32768]{0} call(Arg_1.1122, constant.1129), to_apply=remainder.1100
  subtract.1132 = s32[32768]{0} subtract(broadcast.1128, call.1130)
  constant.1125 = s32[] constant(0)
  broadcast.1126 = s32[32768]{0} broadcast(constant.1125), dimensions={}
  compare.1133 = pred[32768]{0} compare(subtract.1132, broadcast.1126), direction=LT
  constant.1123 = s32[] constant(64)
  broadcast.1124 = s32[32768]{0} broadcast(constant.1123), dimensions={}
  add.1134 = s32[32768]{0} add(subtract.1132, broadcast.1124)
  select.1135 = s32[32768]{0} select(compare.1133, add.1134, subtract.1132)
  reshape.1136 = s32[32768,1]{1,0} reshape(select.1135)
  ROOT gather.1137 = f64[32768,32]{1,0} gather(concatenate.1131, reshape.1136), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1138 {
  Arg_0.1139 = pred[] parameter(0)
  Arg_1.1140 = s32[] parameter(1)
  Arg_2.1141 = s32[] parameter(2)
  ROOT select.1142 = s32[] select(Arg_0.1139, Arg_1.1140, Arg_2.1141)
}

remainder.1143 {
  Arg_0.1144 = s32[32768]{0} parameter(0)
  Arg_1.1145 = s32[] parameter(1)
  constant.1149 = s32[] constant(0)
  compare.1150 = pred[] compare(Arg_1.1145, constant.1149), direction=EQ
  constant.1148 = s32[] constant(1)
  call.1151 = s32[] call(compare.1150, constant.1148, Arg_1.1145), to_apply=_where.1138
  broadcast.1152 = s32[32768]{0} broadcast(call.1151), dimensions={}
  remainder.1153 = s32[32768]{0} remainder(Arg_0.1144, broadcast.1152)
  constant.1146 = s32[] constant(0)
  broadcast.1147 = s32[32768]{0} broadcast(constant.1146), dimensions={}
  compare.1155 = pred[32768]{0} compare(remainder.1153, broadcast.1147), direction=LT
  compare.1156 = pred[] compare(call.1151, constant.1149), direction=LT
  broadcast.1157 = pred[32768]{0} broadcast(compare.1156), dimensions={}
  compare.1158 = pred[32768]{0} compare(compare.1155, broadcast.1157), direction=NE
  compare.1154 = pred[32768]{0} compare(remainder.1153, broadcast.1147), direction=NE
  and.1159 = pred[32768]{0} and(compare.1158, compare.1154)
  broadcast.1160 = s32[32768]{0} broadcast(call.1151), dimensions={}
  add.1161 = s32[32768]{0} add(remainder.1153, broadcast.1160)
  ROOT select.1162 = s32[32768]{0} select(and.1159, add.1161, remainder.1153)
}

_roll_dynamic.1163 {
  Arg_0.1164 = f64[32768,32]{1,0} parameter(0)
  concatenate.1174 = f64[32768,64]{1,0} concatenate(Arg_0.1164, Arg_0.1164), dimensions={1}
  constant.1170 = s32[] constant(32)
  broadcast.1171 = s32[32768]{0} broadcast(constant.1170), dimensions={}
  Arg_1.1165 = s32[32768]{0} parameter(1)
  constant.1172 = s32[] constant(32)
  call.1173 = s32[32768]{0} call(Arg_1.1165, constant.1172), to_apply=remainder.1143
  subtract.1175 = s32[32768]{0} subtract(broadcast.1171, call.1173)
  constant.1168 = s32[] constant(0)
  broadcast.1169 = s32[32768]{0} broadcast(constant.1168), dimensions={}
  compare.1176 = pred[32768]{0} compare(subtract.1175, broadcast.1169), direction=LT
  constant.1166 = s32[] constant(64)
  broadcast.1167 = s32[32768]{0} broadcast(constant.1166), dimensions={}
  add.1177 = s32[32768]{0} add(subtract.1175, broadcast.1167)
  select.1178 = s32[32768]{0} select(compare.1176, add.1177, subtract.1175)
  reshape.1179 = s32[32768,1]{1,0} reshape(select.1178)
  ROOT gather.1180 = f64[32768,32]{1,0} gather(concatenate.1174, reshape.1179), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1181 {
  Arg_0.1182 = pred[] parameter(0)
  Arg_1.1183 = s32[] parameter(1)
  Arg_2.1184 = s32[] parameter(2)
  ROOT select.1185 = s32[] select(Arg_0.1182, Arg_1.1183, Arg_2.1184)
}

remainder.1186 {
  Arg_0.1187 = s32[32768]{0} parameter(0)
  Arg_1.1188 = s32[] parameter(1)
  constant.1192 = s32[] constant(0)
  compare.1193 = pred[] compare(Arg_1.1188, constant.1192), direction=EQ
  constant.1191 = s32[] constant(1)
  call.1194 = s32[] call(compare.1193, constant.1191, Arg_1.1188), to_apply=_where.1181
  broadcast.1195 = s32[32768]{0} broadcast(call.1194), dimensions={}
  remainder.1196 = s32[32768]{0} remainder(Arg_0.1187, broadcast.1195)
  constant.1189 = s32[] constant(0)
  broadcast.1190 = s32[32768]{0} broadcast(constant.1189), dimensions={}
  compare.1198 = pred[32768]{0} compare(remainder.1196, broadcast.1190), direction=LT
  compare.1199 = pred[] compare(call.1194, constant.1192), direction=LT
  broadcast.1200 = pred[32768]{0} broadcast(compare.1199), dimensions={}
  compare.1201 = pred[32768]{0} compare(compare.1198, broadcast.1200), direction=NE
  compare.1197 = pred[32768]{0} compare(remainder.1196, broadcast.1190), direction=NE
  and.1202 = pred[32768]{0} and(compare.1201, compare.1197)
  broadcast.1203 = s32[32768]{0} broadcast(call.1194), dimensions={}
  add.1204 = s32[32768]{0} add(remainder.1196, broadcast.1203)
  ROOT select.1205 = s32[32768]{0} select(and.1202, add.1204, remainder.1196)
}

_roll_dynamic.1206 {
  Arg_0.1207 = f64[32768,32]{1,0} parameter(0)
  concatenate.1217 = f64[32768,64]{1,0} concatenate(Arg_0.1207, Arg_0.1207), dimensions={1}
  constant.1213 = s32[] constant(32)
  broadcast.1214 = s32[32768]{0} broadcast(constant.1213), dimensions={}
  Arg_1.1208 = s32[32768]{0} parameter(1)
  constant.1215 = s32[] constant(32)
  call.1216 = s32[32768]{0} call(Arg_1.1208, constant.1215), to_apply=remainder.1186
  subtract.1218 = s32[32768]{0} subtract(broadcast.1214, call.1216)
  constant.1211 = s32[] constant(0)
  broadcast.1212 = s32[32768]{0} broadcast(constant.1211), dimensions={}
  compare.1219 = pred[32768]{0} compare(subtract.1218, broadcast.1212), direction=LT
  constant.1209 = s32[] constant(64)
  broadcast.1210 = s32[32768]{0} broadcast(constant.1209), dimensions={}
  add.1220 = s32[32768]{0} add(subtract.1218, broadcast.1210)
  select.1221 = s32[32768]{0} select(compare.1219, add.1220, subtract.1218)
  reshape.1222 = s32[32768,1]{1,0} reshape(select.1221)
  ROOT gather.1223 = f64[32768,32]{1,0} gather(concatenate.1217, reshape.1222), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1224 {
  Arg_0.1225 = pred[] parameter(0)
  Arg_1.1226 = s32[] parameter(1)
  Arg_2.1227 = s32[] parameter(2)
  ROOT select.1228 = s32[] select(Arg_0.1225, Arg_1.1226, Arg_2.1227)
}

remainder.1229 {
  Arg_0.1230 = s32[32768]{0} parameter(0)
  Arg_1.1231 = s32[] parameter(1)
  constant.1235 = s32[] constant(0)
  compare.1236 = pred[] compare(Arg_1.1231, constant.1235), direction=EQ
  constant.1234 = s32[] constant(1)
  call.1237 = s32[] call(compare.1236, constant.1234, Arg_1.1231), to_apply=_where.1224
  broadcast.1238 = s32[32768]{0} broadcast(call.1237), dimensions={}
  remainder.1239 = s32[32768]{0} remainder(Arg_0.1230, broadcast.1238)
  constant.1232 = s32[] constant(0)
  broadcast.1233 = s32[32768]{0} broadcast(constant.1232), dimensions={}
  compare.1241 = pred[32768]{0} compare(remainder.1239, broadcast.1233), direction=LT
  compare.1242 = pred[] compare(call.1237, constant.1235), direction=LT
  broadcast.1243 = pred[32768]{0} broadcast(compare.1242), dimensions={}
  compare.1244 = pred[32768]{0} compare(compare.1241, broadcast.1243), direction=NE
  compare.1240 = pred[32768]{0} compare(remainder.1239, broadcast.1233), direction=NE
  and.1245 = pred[32768]{0} and(compare.1244, compare.1240)
  broadcast.1246 = s32[32768]{0} broadcast(call.1237), dimensions={}
  add.1247 = s32[32768]{0} add(remainder.1239, broadcast.1246)
  ROOT select.1248 = s32[32768]{0} select(and.1245, add.1247, remainder.1239)
}

_roll_dynamic.1249 {
  Arg_0.1250 = f64[32768,32]{1,0} parameter(0)
  concatenate.1260 = f64[32768,64]{1,0} concatenate(Arg_0.1250, Arg_0.1250), dimensions={1}
  constant.1256 = s32[] constant(32)
  broadcast.1257 = s32[32768]{0} broadcast(constant.1256), dimensions={}
  Arg_1.1251 = s32[32768]{0} parameter(1)
  constant.1258 = s32[] constant(32)
  call.1259 = s32[32768]{0} call(Arg_1.1251, constant.1258), to_apply=remainder.1229
  subtract.1261 = s32[32768]{0} subtract(broadcast.1257, call.1259)
  constant.1254 = s32[] constant(0)
  broadcast.1255 = s32[32768]{0} broadcast(constant.1254), dimensions={}
  compare.1262 = pred[32768]{0} compare(subtract.1261, broadcast.1255), direction=LT
  constant.1252 = s32[] constant(64)
  broadcast.1253 = s32[32768]{0} broadcast(constant.1252), dimensions={}
  add.1263 = s32[32768]{0} add(subtract.1261, broadcast.1253)
  select.1264 = s32[32768]{0} select(compare.1262, add.1263, subtract.1261)
  reshape.1265 = s32[32768,1]{1,0} reshape(select.1264)
  ROOT gather.1266 = f64[32768,32]{1,0} gather(concatenate.1260, reshape.1265), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1267 {
  Arg_0.1268 = pred[] parameter(0)
  Arg_1.1269 = s32[] parameter(1)
  Arg_2.1270 = s32[] parameter(2)
  ROOT select.1271 = s32[] select(Arg_0.1268, Arg_1.1269, Arg_2.1270)
}

remainder.1272 {
  Arg_0.1273 = s32[32768]{0} parameter(0)
  Arg_1.1274 = s32[] parameter(1)
  constant.1278 = s32[] constant(0)
  compare.1279 = pred[] compare(Arg_1.1274, constant.1278), direction=EQ
  constant.1277 = s32[] constant(1)
  call.1280 = s32[] call(compare.1279, constant.1277, Arg_1.1274), to_apply=_where.1267
  broadcast.1281 = s32[32768]{0} broadcast(call.1280), dimensions={}
  remainder.1282 = s32[32768]{0} remainder(Arg_0.1273, broadcast.1281)
  constant.1275 = s32[] constant(0)
  broadcast.1276 = s32[32768]{0} broadcast(constant.1275), dimensions={}
  compare.1284 = pred[32768]{0} compare(remainder.1282, broadcast.1276), direction=LT
  compare.1285 = pred[] compare(call.1280, constant.1278), direction=LT
  broadcast.1286 = pred[32768]{0} broadcast(compare.1285), dimensions={}
  compare.1287 = pred[32768]{0} compare(compare.1284, broadcast.1286), direction=NE
  compare.1283 = pred[32768]{0} compare(remainder.1282, broadcast.1276), direction=NE
  and.1288 = pred[32768]{0} and(compare.1287, compare.1283)
  broadcast.1289 = s32[32768]{0} broadcast(call.1280), dimensions={}
  add.1290 = s32[32768]{0} add(remainder.1282, broadcast.1289)
  ROOT select.1291 = s32[32768]{0} select(and.1288, add.1290, remainder.1282)
}

_roll_dynamic.1292 {
  Arg_0.1293 = f64[32768,32]{1,0} parameter(0)
  concatenate.1303 = f64[32768,64]{1,0} concatenate(Arg_0.1293, Arg_0.1293), dimensions={1}
  constant.1299 = s32[] constant(32)
  broadcast.1300 = s32[32768]{0} broadcast(constant.1299), dimensions={}
  Arg_1.1294 = s32[32768]{0} parameter(1)
  constant.1301 = s32[] constant(32)
  call.1302 = s32[32768]{0} call(Arg_1.1294, constant.1301), to_apply=remainder.1272
  subtract.1304 = s32[32768]{0} subtract(broadcast.1300, call.1302)
  constant.1297 = s32[] constant(0)
  broadcast.1298 = s32[32768]{0} broadcast(constant.1297), dimensions={}
  compare.1305 = pred[32768]{0} compare(subtract.1304, broadcast.1298), direction=LT
  constant.1295 = s32[] constant(64)
  broadcast.1296 = s32[32768]{0} broadcast(constant.1295), dimensions={}
  add.1306 = s32[32768]{0} add(subtract.1304, broadcast.1296)
  select.1307 = s32[32768]{0} select(compare.1305, add.1306, subtract.1304)
  reshape.1308 = s32[32768,1]{1,0} reshape(select.1307)
  ROOT gather.1309 = f64[32768,32]{1,0} gather(concatenate.1303, reshape.1308), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag_1.1310 {
  Arg_4.1315 = s32[6]{0} parameter(4)
  Arg_1.1312 = f64[32768]{0} parameter(1)
  Arg_2.1313 = f64[] parameter(2)
  broadcast.1316 = f64[32768]{0} broadcast(Arg_2.1313), dimensions={}
  multiply.1317 = f64[32768]{0} multiply(Arg_1.1312, broadcast.1316)
  Arg_3.1314 = f64[] parameter(3)
  broadcast.1318 = f64[32768]{0} broadcast(Arg_3.1314), dimensions={}
  divide.1319 = f64[32768]{0} divide(multiply.1317, broadcast.1318)
  floor.1320 = f64[32768]{0} floor(divide.1319)
  convert.1322 = s32[32768]{0} convert(floor.1320)
  subtract.1321 = f64[32768]{0} subtract(divide.1319, floor.1320)
  call.1323 = f64[6,32768,32]{2,1,0} call(Arg_4.1315, convert.1322, subtract.1321), to_apply=build_v_diag_weights.925
  slice.1329 = f64[1,32768,32]{2,1,0} slice(call.1323), slice={[0:1], [0:32768], [0:32]}
  reshape.1330 = f64[32768,32]{1,0} reshape(slice.1329)
  Arg_0.1311 = f64[32768,32]{1,0} parameter(0)
  slice.1324 = s32[1]{0} slice(Arg_4.1315), slice={[0:1]}
  reshape.1325 = s32[] reshape(slice.1324)
  broadcast.1326 = s32[32768]{0} broadcast(reshape.1325), dimensions={}
  add.1327 = s32[32768]{0} add(convert.1322, broadcast.1326)
  call.1328 = f64[32768,32]{1,0} call(Arg_0.1311, add.1327), to_apply=_roll_dynamic.1077
  multiply.1331 = f64[32768,32]{1,0} multiply(reshape.1330, call.1328)
  slice.1337 = f64[1,32768,32]{2,1,0} slice(call.1323), slice={[1:2], [0:32768], [0:32]}
  reshape.1338 = f64[32768,32]{1,0} reshape(slice.1337)
  slice.1332 = s32[1]{0} slice(Arg_4.1315), slice={[1:2]}
  reshape.1333 = s32[] reshape(slice.1332)
  broadcast.1334 = s32[32768]{0} broadcast(reshape.1333), dimensions={}
  add.1335 = s32[32768]{0} add(convert.1322, broadcast.1334)
  call.1336 = f64[32768,32]{1,0} call(Arg_0.1311, add.1335), to_apply=_roll_dynamic.1120
  multiply.1339 = f64[32768,32]{1,0} multiply(reshape.1338, call.1336)
  add.1340 = f64[32768,32]{1,0} add(multiply.1331, multiply.1339)
  slice.1346 = f64[1,32768,32]{2,1,0} slice(call.1323), slice={[2:3], [0:32768], [0:32]}
  reshape.1347 = f64[32768,32]{1,0} reshape(slice.1346)
  slice.1341 = s32[1]{0} slice(Arg_4.1315), slice={[2:3]}
  reshape.1342 = s32[] reshape(slice.1341)
  broadcast.1343 = s32[32768]{0} broadcast(reshape.1342), dimensions={}
  add.1344 = s32[32768]{0} add(convert.1322, broadcast.1343)
  call.1345 = f64[32768,32]{1,0} call(Arg_0.1311, add.1344), to_apply=_roll_dynamic.1163
  multiply.1348 = f64[32768,32]{1,0} multiply(reshape.1347, call.1345)
  add.1349 = f64[32768,32]{1,0} add(add.1340, multiply.1348)
  slice.1355 = f64[1,32768,32]{2,1,0} slice(call.1323), slice={[3:4], [0:32768], [0:32]}
  reshape.1356 = f64[32768,32]{1,0} reshape(slice.1355)
  slice.1350 = s32[1]{0} slice(Arg_4.1315), slice={[3:4]}
  reshape.1351 = s32[] reshape(slice.1350)
  broadcast.1352 = s32[32768]{0} broadcast(reshape.1351), dimensions={}
  add.1353 = s32[32768]{0} add(convert.1322, broadcast.1352)
  call.1354 = f64[32768,32]{1,0} call(Arg_0.1311, add.1353), to_apply=_roll_dynamic.1206
  multiply.1357 = f64[32768,32]{1,0} multiply(reshape.1356, call.1354)
  add.1358 = f64[32768,32]{1,0} add(add.1349, multiply.1357)
  slice.1364 = f64[1,32768,32]{2,1,0} slice(call.1323), slice={[4:5], [0:32768], [0:32]}
  reshape.1365 = f64[32768,32]{1,0} reshape(slice.1364)
  slice.1359 = s32[1]{0} slice(Arg_4.1315), slice={[4:5]}
  reshape.1360 = s32[] reshape(slice.1359)
  broadcast.1361 = s32[32768]{0} broadcast(reshape.1360), dimensions={}
  add.1362 = s32[32768]{0} add(convert.1322, broadcast.1361)
  call.1363 = f64[32768,32]{1,0} call(Arg_0.1311, add.1362), to_apply=_roll_dynamic.1249
  multiply.1366 = f64[32768,32]{1,0} multiply(reshape.1365, call.1363)
  add.1367 = f64[32768,32]{1,0} add(add.1358, multiply.1366)
  slice.1373 = f64[1,32768,32]{2,1,0} slice(call.1323), slice={[5:6], [0:32768], [0:32]}
  reshape.1374 = f64[32768,32]{1,0} reshape(slice.1373)
  slice.1368 = s32[1]{0} slice(Arg_4.1315), slice={[5:6]}
  reshape.1369 = s32[] reshape(slice.1368)
  broadcast.1370 = s32[32768]{0} broadcast(reshape.1369), dimensions={}
  add.1371 = s32[32768]{0} add(convert.1322, broadcast.1370)
  call.1372 = f64[32768,32]{1,0} call(Arg_0.1311, add.1371), to_apply=_roll_dynamic.1292
  multiply.1375 = f64[32768,32]{1,0} multiply(reshape.1374, call.1372)
  ROOT add.1376 = f64[32768,32]{1,0} add(add.1367, multiply.1375)
}

_where_2.1377 {
  Arg_0.1378 = pred[6,32768,32]{2,1,0} parameter(0)
  Arg_1.1379 = f64[6,32768,1]{2,1,0} parameter(1)
  broadcast.1381 = f64[6,32768,1]{2,1,0} broadcast(Arg_1.1379), dimensions={0,1,2}
  reshape.1382 = f64[6,32768]{1,0} reshape(broadcast.1381)
  broadcast.1383 = f64[6,32768,32]{2,1,0} broadcast(reshape.1382), dimensions={0,1}
  Arg_2.1380 = f64[] parameter(2)
  broadcast.1384 = f64[6,32768,32]{2,1,0} broadcast(Arg_2.1380), dimensions={}
  ROOT select.1385 = f64[6,32768,32]{2,1,0} select(Arg_0.1378, broadcast.1383, broadcast.1384)
}

build_v_diag_weights.1386 {
  iota.1488 = s64[32]{0} iota(), iota_dimension=0
  reshape.1498 = s64[1,1,32]{2,1,0} reshape(iota.1488)
  broadcast.1501 = s64[1,1,32]{2,1,0} broadcast(reshape.1498), dimensions={0,1,2}
  reshape.1502 = s64[32]{0} reshape(broadcast.1501)
  broadcast.1503 = s64[6,32768,32]{2,1,0} broadcast(reshape.1502), dimensions={2}
  Arg_0.1387 = s32[6]{0} parameter(0)
  reshape.1489 = s32[6,1]{1,0} reshape(Arg_0.1387)
  broadcast.1491 = s32[6,1]{1,0} broadcast(reshape.1489), dimensions={0,1}
  reshape.1492 = s32[6]{0} reshape(broadcast.1491)
  broadcast.1493 = s32[6,32768]{1,0} broadcast(reshape.1492), dimensions={0}
  Arg_1.1388 = s32[32768]{0} parameter(1)
  reshape.1490 = s32[1,32768]{1,0} reshape(Arg_1.1388)
  broadcast.1494 = s32[1,32768]{1,0} broadcast(reshape.1490), dimensions={0,1}
  reshape.1495 = s32[32768]{0} reshape(broadcast.1494)
  broadcast.1496 = s32[6,32768]{1,0} broadcast(reshape.1495), dimensions={1}
  add.1497 = s32[6,32768]{1,0} add(broadcast.1493, broadcast.1496)
  reshape.1499 = s32[6,32768,1]{2,1,0} reshape(add.1497)
  convert.1500 = s64[6,32768,1]{2,1,0} convert(reshape.1499)
  broadcast.1504 = s64[6,32768,1]{2,1,0} broadcast(convert.1500), dimensions={0,1,2}
  reshape.1505 = s64[6,32768]{1,0} reshape(broadcast.1504)
  broadcast.1506 = s64[6,32768,32]{2,1,0} broadcast(reshape.1505), dimensions={0,1}
  subtract.1507 = s64[6,32768,32]{2,1,0} subtract(broadcast.1503, broadcast.1506)
  constant.1392 = s64[] constant(0)
  broadcast.1393 = s64[6,32768,32]{2,1,0} broadcast(constant.1392), dimensions={}
  compare.1508 = pred[6,32768,32]{2,1,0} compare(subtract.1507, broadcast.1393), direction=GE
  constant.1390 = s64[] constant(32)
  broadcast.1391 = s64[6,32768,32]{2,1,0} broadcast(constant.1390), dimensions={}
  compare.1509 = pred[6,32768,32]{2,1,0} compare(subtract.1507, broadcast.1391), direction=LT
  and.1510 = pred[6,32768,32]{2,1,0} and(compare.1508, compare.1509)
  Arg_2.1389 = f64[32768]{0} parameter(2)
  constant.1416 = f64[] constant(20)
  broadcast.1417 = f64[32768]{0} broadcast(constant.1416), dimensions={}
  divide.1423 = f64[32768]{0} divide(Arg_2.1389, broadcast.1417)
  multiply.1419 = f64[32768]{0} multiply(Arg_2.1389, Arg_2.1389)
  constant.1414 = f64[] constant(24)
  broadcast.1415 = f64[32768]{0} broadcast(constant.1414), dimensions={}
  divide.1424 = f64[32768]{0} divide(multiply.1419, broadcast.1415)
  subtract.1425 = f64[32768]{0} subtract(divide.1423, divide.1424)
  multiply.1420 = f64[32768]{0} multiply(multiply.1419, Arg_2.1389)
  divide.1426 = f64[32768]{0} divide(multiply.1420, broadcast.1415)
  subtract.1427 = f64[32768]{0} subtract(subtract.1425, divide.1426)
  multiply.1421 = f64[32768]{0} multiply(multiply.1420, Arg_2.1389)
  divide.1428 = f64[32768]{0} divide(multiply.1421, broadcast.1415)
  add.1429 = f64[32768]{0} add(subtract.1427, divide.1428)
  multiply.1422 = f64[32768]{0} multiply(multiply.1421, Arg_2.1389)
  constant.1412 = f64[] constant(120)
  broadcast.1413 = f64[32768]{0} broadcast(constant.1412), dimensions={}
  divide.1430 = f64[32768]{0} divide(multiply.1422, broadcast.1413)
  subtract.1431 = f64[32768]{0} subtract(add.1429, divide.1430)
  reshape.1481 = f64[1,32768]{1,0} reshape(subtract.1431)
  constant.1410 = f64[] constant(2)
  broadcast.1411 = f64[32768]{0} broadcast(constant.1410), dimensions={}
  divide.1432 = f64[32768]{0} divide(Arg_2.1389, broadcast.1411)
  negate.1433 = f64[32768]{0} negate(divide.1432)
  multiply.1434 = f64[32768]{0} multiply(multiply.1419, broadcast.1411)
  constant.1408 = f64[] constant(3)
  broadcast.1409 = f64[32768]{0} broadcast(constant.1408), dimensions={}
  divide.1435 = f64[32768]{0} divide(multiply.1434, broadcast.1409)
  add.1436 = f64[32768]{0} add(negate.1433, divide.1435)
  divide.1437 = f64[32768]{0} divide(multiply.1420, broadcast.1415)
  subtract.1438 = f64[32768]{0} subtract(add.1436, divide.1437)
  constant.1406 = f64[] constant(6)
  broadcast.1407 = f64[32768]{0} broadcast(constant.1406), dimensions={}
  divide.1439 = f64[32768]{0} divide(multiply.1421, broadcast.1407)
  subtract.1440 = f64[32768]{0} subtract(subtract.1438, divide.1439)
  divide.1441 = f64[32768]{0} divide(multiply.1422, broadcast.1415)
  add.1442 = f64[32768]{0} add(subtract.1440, divide.1441)
  reshape.1482 = f64[1,32768]{1,0} reshape(add.1442)
  constant.1404 = f64[] constant(1)
  broadcast.1405 = f64[32768]{0} broadcast(constant.1404), dimensions={}
  divide.1443 = f64[32768]{0} divide(Arg_2.1389, broadcast.1409)
  subtract.1444 = f64[32768]{0} subtract(broadcast.1405, divide.1443)
  constant.1402 = f64[] constant(5)
  broadcast.1403 = f64[32768]{0} broadcast(constant.1402), dimensions={}
  multiply.1445 = f64[32768]{0} multiply(multiply.1419, broadcast.1403)
  constant.1400 = f64[] constant(4)
  broadcast.1401 = f64[32768]{0} broadcast(constant.1400), dimensions={}
  divide.1446 = f64[32768]{0} divide(multiply.1445, broadcast.1401)
  subtract.1447 = f64[32768]{0} subtract(subtract.1444, divide.1446)
  multiply.1448 = f64[32768]{0} multiply(multiply.1420, broadcast.1403)
  constant.1398 = f64[] constant(12)
  broadcast.1399 = f64[32768]{0} broadcast(constant.1398), dimensions={}
  divide.1449 = f64[32768]{0} divide(multiply.1448, broadcast.1399)
  add.1450 = f64[32768]{0} add(subtract.1447, divide.1449)
  divide.1451 = f64[32768]{0} divide(multiply.1421, broadcast.1401)
  add.1452 = f64[32768]{0} add(add.1450, divide.1451)
  divide.1453 = f64[32768]{0} divide(multiply.1422, broadcast.1399)
  subtract.1454 = f64[32768]{0} subtract(add.1452, divide.1453)
  reshape.1483 = f64[1,32768]{1,0} reshape(subtract.1454)
  multiply.1455 = f64[32768]{0} multiply(multiply.1419, broadcast.1411)
  divide.1456 = f64[32768]{0} divide(multiply.1455, broadcast.1409)
  add.1457 = f64[32768]{0} add(Arg_2.1389, divide.1456)
  constant.1396 = f64[] constant(7)
  broadcast.1397 = f64[32768]{0} broadcast(constant.1396), dimensions={}
  multiply.1458 = f64[32768]{0} multiply(multiply.1420, broadcast.1397)
  divide.1459 = f64[32768]{0} divide(multiply.1458, broadcast.1399)
  subtract.1460 = f64[32768]{0} subtract(add.1457, divide.1459)
  divide.1461 = f64[32768]{0} divide(multiply.1421, broadcast.1407)
  subtract.1462 = f64[32768]{0} subtract(subtract.1460, divide.1461)
  divide.1463 = f64[32768]{0} divide(multiply.1422, broadcast.1399)
  add.1464 = f64[32768]{0} add(subtract.1462, divide.1463)
  reshape.1484 = f64[1,32768]{1,0} reshape(add.1464)
  divide.1465 = f64[32768]{0} divide(Arg_2.1389, broadcast.1401)
  negate.1466 = f64[32768]{0} negate(divide.1465)
  divide.1467 = f64[32768]{0} divide(multiply.1419, broadcast.1415)
  subtract.1468 = f64[32768]{0} subtract(negate.1466, divide.1467)
  multiply.1469 = f64[32768]{0} multiply(multiply.1420, broadcast.1397)
  divide.1470 = f64[32768]{0} divide(multiply.1469, broadcast.1415)
  add.1471 = f64[32768]{0} add(subtract.1468, divide.1470)
  divide.1472 = f64[32768]{0} divide(multiply.1421, broadcast.1415)
  add.1473 = f64[32768]{0} add(add.1471, divide.1472)
  divide.1474 = f64[32768]{0} divide(multiply.1422, broadcast.1415)
  subtract.1475 = f64[32768]{0} subtract(add.1473, divide.1474)
  reshape.1485 = f64[1,32768]{1,0} reshape(subtract.1475)
  constant.1394 = f64[] constant(30)
  broadcast.1395 = f64[32768]{0} broadcast(constant.1394), dimensions={}
  divide.1476 = f64[32768]{0} divide(Arg_2.1389, broadcast.1395)
  divide.1477 = f64[32768]{0} divide(multiply.1420, broadcast.1415)
  subtract.1478 = f64[32768]{0} subtract(divide.1476, divide.1477)
  divide.1479 = f64[32768]{0} divide(multiply.1422, broadcast.1413)
  add.1480 = f64[32768]{0} add(subtract.1478, divide.1479)
  reshape.1486 = f64[1,32768]{1,0} reshape(add.1480)
  concatenate.1487 = f64[6,32768]{1,0} concatenate(reshape.1481, reshape.1482, reshape.1483, reshape.1484, reshape.1485, reshape.1486), dimensions={0}
  reshape.1511 = f64[6,32768,1]{2,1,0} reshape(concatenate.1487)
  constant.1418 = f64[] constant(0)
  ROOT call.1512 = f64[6,32768,32]{2,1,0} call(and.1510, reshape.1511, constant.1418), to_apply=_where_2.1377
}

_where.1513 {
  Arg_0.1514 = pred[] parameter(0)
  Arg_1.1515 = s32[] parameter(1)
  Arg_2.1516 = s32[] parameter(2)
  ROOT select.1517 = s32[] select(Arg_0.1514, Arg_1.1515, Arg_2.1516)
}

remainder.1518 {
  Arg_0.1519 = s32[32768]{0} parameter(0)
  Arg_1.1520 = s32[] parameter(1)
  constant.1524 = s32[] constant(0)
  compare.1525 = pred[] compare(Arg_1.1520, constant.1524), direction=EQ
  constant.1523 = s32[] constant(1)
  call.1526 = s32[] call(compare.1525, constant.1523, Arg_1.1520), to_apply=_where.1513
  broadcast.1527 = s32[32768]{0} broadcast(call.1526), dimensions={}
  remainder.1528 = s32[32768]{0} remainder(Arg_0.1519, broadcast.1527)
  constant.1521 = s32[] constant(0)
  broadcast.1522 = s32[32768]{0} broadcast(constant.1521), dimensions={}
  compare.1530 = pred[32768]{0} compare(remainder.1528, broadcast.1522), direction=LT
  compare.1531 = pred[] compare(call.1526, constant.1524), direction=LT
  broadcast.1532 = pred[32768]{0} broadcast(compare.1531), dimensions={}
  compare.1533 = pred[32768]{0} compare(compare.1530, broadcast.1532), direction=NE
  compare.1529 = pred[32768]{0} compare(remainder.1528, broadcast.1522), direction=NE
  and.1534 = pred[32768]{0} and(compare.1533, compare.1529)
  broadcast.1535 = s32[32768]{0} broadcast(call.1526), dimensions={}
  add.1536 = s32[32768]{0} add(remainder.1528, broadcast.1535)
  ROOT select.1537 = s32[32768]{0} select(and.1534, add.1536, remainder.1528)
}

_roll_dynamic.1538 {
  Arg_0.1539 = f64[32768,32]{1,0} parameter(0)
  concatenate.1549 = f64[32768,64]{1,0} concatenate(Arg_0.1539, Arg_0.1539), dimensions={1}
  constant.1545 = s32[] constant(32)
  broadcast.1546 = s32[32768]{0} broadcast(constant.1545), dimensions={}
  Arg_1.1540 = s32[32768]{0} parameter(1)
  constant.1547 = s32[] constant(32)
  call.1548 = s32[32768]{0} call(Arg_1.1540, constant.1547), to_apply=remainder.1518
  subtract.1550 = s32[32768]{0} subtract(broadcast.1546, call.1548)
  constant.1543 = s32[] constant(0)
  broadcast.1544 = s32[32768]{0} broadcast(constant.1543), dimensions={}
  compare.1551 = pred[32768]{0} compare(subtract.1550, broadcast.1544), direction=LT
  constant.1541 = s32[] constant(64)
  broadcast.1542 = s32[32768]{0} broadcast(constant.1541), dimensions={}
  add.1552 = s32[32768]{0} add(subtract.1550, broadcast.1542)
  select.1553 = s32[32768]{0} select(compare.1551, add.1552, subtract.1550)
  reshape.1554 = s32[32768,1]{1,0} reshape(select.1553)
  ROOT gather.1555 = f64[32768,32]{1,0} gather(concatenate.1549, reshape.1554), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1556 {
  Arg_0.1557 = pred[] parameter(0)
  Arg_1.1558 = s32[] parameter(1)
  Arg_2.1559 = s32[] parameter(2)
  ROOT select.1560 = s32[] select(Arg_0.1557, Arg_1.1558, Arg_2.1559)
}

remainder.1561 {
  Arg_0.1562 = s32[32768]{0} parameter(0)
  Arg_1.1563 = s32[] parameter(1)
  constant.1567 = s32[] constant(0)
  compare.1568 = pred[] compare(Arg_1.1563, constant.1567), direction=EQ
  constant.1566 = s32[] constant(1)
  call.1569 = s32[] call(compare.1568, constant.1566, Arg_1.1563), to_apply=_where.1556
  broadcast.1570 = s32[32768]{0} broadcast(call.1569), dimensions={}
  remainder.1571 = s32[32768]{0} remainder(Arg_0.1562, broadcast.1570)
  constant.1564 = s32[] constant(0)
  broadcast.1565 = s32[32768]{0} broadcast(constant.1564), dimensions={}
  compare.1573 = pred[32768]{0} compare(remainder.1571, broadcast.1565), direction=LT
  compare.1574 = pred[] compare(call.1569, constant.1567), direction=LT
  broadcast.1575 = pred[32768]{0} broadcast(compare.1574), dimensions={}
  compare.1576 = pred[32768]{0} compare(compare.1573, broadcast.1575), direction=NE
  compare.1572 = pred[32768]{0} compare(remainder.1571, broadcast.1565), direction=NE
  and.1577 = pred[32768]{0} and(compare.1576, compare.1572)
  broadcast.1578 = s32[32768]{0} broadcast(call.1569), dimensions={}
  add.1579 = s32[32768]{0} add(remainder.1571, broadcast.1578)
  ROOT select.1580 = s32[32768]{0} select(and.1577, add.1579, remainder.1571)
}

_roll_dynamic.1581 {
  Arg_0.1582 = f64[32768,32]{1,0} parameter(0)
  concatenate.1592 = f64[32768,64]{1,0} concatenate(Arg_0.1582, Arg_0.1582), dimensions={1}
  constant.1588 = s32[] constant(32)
  broadcast.1589 = s32[32768]{0} broadcast(constant.1588), dimensions={}
  Arg_1.1583 = s32[32768]{0} parameter(1)
  constant.1590 = s32[] constant(32)
  call.1591 = s32[32768]{0} call(Arg_1.1583, constant.1590), to_apply=remainder.1561
  subtract.1593 = s32[32768]{0} subtract(broadcast.1589, call.1591)
  constant.1586 = s32[] constant(0)
  broadcast.1587 = s32[32768]{0} broadcast(constant.1586), dimensions={}
  compare.1594 = pred[32768]{0} compare(subtract.1593, broadcast.1587), direction=LT
  constant.1584 = s32[] constant(64)
  broadcast.1585 = s32[32768]{0} broadcast(constant.1584), dimensions={}
  add.1595 = s32[32768]{0} add(subtract.1593, broadcast.1585)
  select.1596 = s32[32768]{0} select(compare.1594, add.1595, subtract.1593)
  reshape.1597 = s32[32768,1]{1,0} reshape(select.1596)
  ROOT gather.1598 = f64[32768,32]{1,0} gather(concatenate.1592, reshape.1597), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1599 {
  Arg_0.1600 = pred[] parameter(0)
  Arg_1.1601 = s32[] parameter(1)
  Arg_2.1602 = s32[] parameter(2)
  ROOT select.1603 = s32[] select(Arg_0.1600, Arg_1.1601, Arg_2.1602)
}

remainder.1604 {
  Arg_0.1605 = s32[32768]{0} parameter(0)
  Arg_1.1606 = s32[] parameter(1)
  constant.1610 = s32[] constant(0)
  compare.1611 = pred[] compare(Arg_1.1606, constant.1610), direction=EQ
  constant.1609 = s32[] constant(1)
  call.1612 = s32[] call(compare.1611, constant.1609, Arg_1.1606), to_apply=_where.1599
  broadcast.1613 = s32[32768]{0} broadcast(call.1612), dimensions={}
  remainder.1614 = s32[32768]{0} remainder(Arg_0.1605, broadcast.1613)
  constant.1607 = s32[] constant(0)
  broadcast.1608 = s32[32768]{0} broadcast(constant.1607), dimensions={}
  compare.1616 = pred[32768]{0} compare(remainder.1614, broadcast.1608), direction=LT
  compare.1617 = pred[] compare(call.1612, constant.1610), direction=LT
  broadcast.1618 = pred[32768]{0} broadcast(compare.1617), dimensions={}
  compare.1619 = pred[32768]{0} compare(compare.1616, broadcast.1618), direction=NE
  compare.1615 = pred[32768]{0} compare(remainder.1614, broadcast.1608), direction=NE
  and.1620 = pred[32768]{0} and(compare.1619, compare.1615)
  broadcast.1621 = s32[32768]{0} broadcast(call.1612), dimensions={}
  add.1622 = s32[32768]{0} add(remainder.1614, broadcast.1621)
  ROOT select.1623 = s32[32768]{0} select(and.1620, add.1622, remainder.1614)
}

_roll_dynamic.1624 {
  Arg_0.1625 = f64[32768,32]{1,0} parameter(0)
  concatenate.1635 = f64[32768,64]{1,0} concatenate(Arg_0.1625, Arg_0.1625), dimensions={1}
  constant.1631 = s32[] constant(32)
  broadcast.1632 = s32[32768]{0} broadcast(constant.1631), dimensions={}
  Arg_1.1626 = s32[32768]{0} parameter(1)
  constant.1633 = s32[] constant(32)
  call.1634 = s32[32768]{0} call(Arg_1.1626, constant.1633), to_apply=remainder.1604
  subtract.1636 = s32[32768]{0} subtract(broadcast.1632, call.1634)
  constant.1629 = s32[] constant(0)
  broadcast.1630 = s32[32768]{0} broadcast(constant.1629), dimensions={}
  compare.1637 = pred[32768]{0} compare(subtract.1636, broadcast.1630), direction=LT
  constant.1627 = s32[] constant(64)
  broadcast.1628 = s32[32768]{0} broadcast(constant.1627), dimensions={}
  add.1638 = s32[32768]{0} add(subtract.1636, broadcast.1628)
  select.1639 = s32[32768]{0} select(compare.1637, add.1638, subtract.1636)
  reshape.1640 = s32[32768,1]{1,0} reshape(select.1639)
  ROOT gather.1641 = f64[32768,32]{1,0} gather(concatenate.1635, reshape.1640), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1642 {
  Arg_0.1643 = pred[] parameter(0)
  Arg_1.1644 = s32[] parameter(1)
  Arg_2.1645 = s32[] parameter(2)
  ROOT select.1646 = s32[] select(Arg_0.1643, Arg_1.1644, Arg_2.1645)
}

remainder.1647 {
  Arg_0.1648 = s32[32768]{0} parameter(0)
  Arg_1.1649 = s32[] parameter(1)
  constant.1653 = s32[] constant(0)
  compare.1654 = pred[] compare(Arg_1.1649, constant.1653), direction=EQ
  constant.1652 = s32[] constant(1)
  call.1655 = s32[] call(compare.1654, constant.1652, Arg_1.1649), to_apply=_where.1642
  broadcast.1656 = s32[32768]{0} broadcast(call.1655), dimensions={}
  remainder.1657 = s32[32768]{0} remainder(Arg_0.1648, broadcast.1656)
  constant.1650 = s32[] constant(0)
  broadcast.1651 = s32[32768]{0} broadcast(constant.1650), dimensions={}
  compare.1659 = pred[32768]{0} compare(remainder.1657, broadcast.1651), direction=LT
  compare.1660 = pred[] compare(call.1655, constant.1653), direction=LT
  broadcast.1661 = pred[32768]{0} broadcast(compare.1660), dimensions={}
  compare.1662 = pred[32768]{0} compare(compare.1659, broadcast.1661), direction=NE
  compare.1658 = pred[32768]{0} compare(remainder.1657, broadcast.1651), direction=NE
  and.1663 = pred[32768]{0} and(compare.1662, compare.1658)
  broadcast.1664 = s32[32768]{0} broadcast(call.1655), dimensions={}
  add.1665 = s32[32768]{0} add(remainder.1657, broadcast.1664)
  ROOT select.1666 = s32[32768]{0} select(and.1663, add.1665, remainder.1657)
}

_roll_dynamic.1667 {
  Arg_0.1668 = f64[32768,32]{1,0} parameter(0)
  concatenate.1678 = f64[32768,64]{1,0} concatenate(Arg_0.1668, Arg_0.1668), dimensions={1}
  constant.1674 = s32[] constant(32)
  broadcast.1675 = s32[32768]{0} broadcast(constant.1674), dimensions={}
  Arg_1.1669 = s32[32768]{0} parameter(1)
  constant.1676 = s32[] constant(32)
  call.1677 = s32[32768]{0} call(Arg_1.1669, constant.1676), to_apply=remainder.1647
  subtract.1679 = s32[32768]{0} subtract(broadcast.1675, call.1677)
  constant.1672 = s32[] constant(0)
  broadcast.1673 = s32[32768]{0} broadcast(constant.1672), dimensions={}
  compare.1680 = pred[32768]{0} compare(subtract.1679, broadcast.1673), direction=LT
  constant.1670 = s32[] constant(64)
  broadcast.1671 = s32[32768]{0} broadcast(constant.1670), dimensions={}
  add.1681 = s32[32768]{0} add(subtract.1679, broadcast.1671)
  select.1682 = s32[32768]{0} select(compare.1680, add.1681, subtract.1679)
  reshape.1683 = s32[32768,1]{1,0} reshape(select.1682)
  ROOT gather.1684 = f64[32768,32]{1,0} gather(concatenate.1678, reshape.1683), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1685 {
  Arg_0.1686 = pred[] parameter(0)
  Arg_1.1687 = s32[] parameter(1)
  Arg_2.1688 = s32[] parameter(2)
  ROOT select.1689 = s32[] select(Arg_0.1686, Arg_1.1687, Arg_2.1688)
}

remainder.1690 {
  Arg_0.1691 = s32[32768]{0} parameter(0)
  Arg_1.1692 = s32[] parameter(1)
  constant.1696 = s32[] constant(0)
  compare.1697 = pred[] compare(Arg_1.1692, constant.1696), direction=EQ
  constant.1695 = s32[] constant(1)
  call.1698 = s32[] call(compare.1697, constant.1695, Arg_1.1692), to_apply=_where.1685
  broadcast.1699 = s32[32768]{0} broadcast(call.1698), dimensions={}
  remainder.1700 = s32[32768]{0} remainder(Arg_0.1691, broadcast.1699)
  constant.1693 = s32[] constant(0)
  broadcast.1694 = s32[32768]{0} broadcast(constant.1693), dimensions={}
  compare.1702 = pred[32768]{0} compare(remainder.1700, broadcast.1694), direction=LT
  compare.1703 = pred[] compare(call.1698, constant.1696), direction=LT
  broadcast.1704 = pred[32768]{0} broadcast(compare.1703), dimensions={}
  compare.1705 = pred[32768]{0} compare(compare.1702, broadcast.1704), direction=NE
  compare.1701 = pred[32768]{0} compare(remainder.1700, broadcast.1694), direction=NE
  and.1706 = pred[32768]{0} and(compare.1705, compare.1701)
  broadcast.1707 = s32[32768]{0} broadcast(call.1698), dimensions={}
  add.1708 = s32[32768]{0} add(remainder.1700, broadcast.1707)
  ROOT select.1709 = s32[32768]{0} select(and.1706, add.1708, remainder.1700)
}

_roll_dynamic.1710 {
  Arg_0.1711 = f64[32768,32]{1,0} parameter(0)
  concatenate.1721 = f64[32768,64]{1,0} concatenate(Arg_0.1711, Arg_0.1711), dimensions={1}
  constant.1717 = s32[] constant(32)
  broadcast.1718 = s32[32768]{0} broadcast(constant.1717), dimensions={}
  Arg_1.1712 = s32[32768]{0} parameter(1)
  constant.1719 = s32[] constant(32)
  call.1720 = s32[32768]{0} call(Arg_1.1712, constant.1719), to_apply=remainder.1690
  subtract.1722 = s32[32768]{0} subtract(broadcast.1718, call.1720)
  constant.1715 = s32[] constant(0)
  broadcast.1716 = s32[32768]{0} broadcast(constant.1715), dimensions={}
  compare.1723 = pred[32768]{0} compare(subtract.1722, broadcast.1716), direction=LT
  constant.1713 = s32[] constant(64)
  broadcast.1714 = s32[32768]{0} broadcast(constant.1713), dimensions={}
  add.1724 = s32[32768]{0} add(subtract.1722, broadcast.1714)
  select.1725 = s32[32768]{0} select(compare.1723, add.1724, subtract.1722)
  reshape.1726 = s32[32768,1]{1,0} reshape(select.1725)
  ROOT gather.1727 = f64[32768,32]{1,0} gather(concatenate.1721, reshape.1726), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1728 {
  Arg_0.1729 = pred[] parameter(0)
  Arg_1.1730 = s32[] parameter(1)
  Arg_2.1731 = s32[] parameter(2)
  ROOT select.1732 = s32[] select(Arg_0.1729, Arg_1.1730, Arg_2.1731)
}

remainder.1733 {
  Arg_0.1734 = s32[32768]{0} parameter(0)
  Arg_1.1735 = s32[] parameter(1)
  constant.1739 = s32[] constant(0)
  compare.1740 = pred[] compare(Arg_1.1735, constant.1739), direction=EQ
  constant.1738 = s32[] constant(1)
  call.1741 = s32[] call(compare.1740, constant.1738, Arg_1.1735), to_apply=_where.1728
  broadcast.1742 = s32[32768]{0} broadcast(call.1741), dimensions={}
  remainder.1743 = s32[32768]{0} remainder(Arg_0.1734, broadcast.1742)
  constant.1736 = s32[] constant(0)
  broadcast.1737 = s32[32768]{0} broadcast(constant.1736), dimensions={}
  compare.1745 = pred[32768]{0} compare(remainder.1743, broadcast.1737), direction=LT
  compare.1746 = pred[] compare(call.1741, constant.1739), direction=LT
  broadcast.1747 = pred[32768]{0} broadcast(compare.1746), dimensions={}
  compare.1748 = pred[32768]{0} compare(compare.1745, broadcast.1747), direction=NE
  compare.1744 = pred[32768]{0} compare(remainder.1743, broadcast.1737), direction=NE
  and.1749 = pred[32768]{0} and(compare.1748, compare.1744)
  broadcast.1750 = s32[32768]{0} broadcast(call.1741), dimensions={}
  add.1751 = s32[32768]{0} add(remainder.1743, broadcast.1750)
  ROOT select.1752 = s32[32768]{0} select(and.1749, add.1751, remainder.1743)
}

_roll_dynamic.1753 {
  Arg_0.1754 = f64[32768,32]{1,0} parameter(0)
  concatenate.1764 = f64[32768,64]{1,0} concatenate(Arg_0.1754, Arg_0.1754), dimensions={1}
  constant.1760 = s32[] constant(32)
  broadcast.1761 = s32[32768]{0} broadcast(constant.1760), dimensions={}
  Arg_1.1755 = s32[32768]{0} parameter(1)
  constant.1762 = s32[] constant(32)
  call.1763 = s32[32768]{0} call(Arg_1.1755, constant.1762), to_apply=remainder.1733
  subtract.1765 = s32[32768]{0} subtract(broadcast.1761, call.1763)
  constant.1758 = s32[] constant(0)
  broadcast.1759 = s32[32768]{0} broadcast(constant.1758), dimensions={}
  compare.1766 = pred[32768]{0} compare(subtract.1765, broadcast.1759), direction=LT
  constant.1756 = s32[] constant(64)
  broadcast.1757 = s32[32768]{0} broadcast(constant.1756), dimensions={}
  add.1767 = s32[32768]{0} add(subtract.1765, broadcast.1757)
  select.1768 = s32[32768]{0} select(compare.1766, add.1767, subtract.1765)
  reshape.1769 = s32[32768,1]{1,0} reshape(select.1768)
  ROOT gather.1770 = f64[32768,32]{1,0} gather(concatenate.1764, reshape.1769), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag_1.1771 {
  Arg_4.1776 = s32[6]{0} parameter(4)
  Arg_1.1773 = f64[32768]{0} parameter(1)
  Arg_2.1774 = f64[] parameter(2)
  broadcast.1777 = f64[32768]{0} broadcast(Arg_2.1774), dimensions={}
  multiply.1778 = f64[32768]{0} multiply(Arg_1.1773, broadcast.1777)
  Arg_3.1775 = f64[] parameter(3)
  broadcast.1779 = f64[32768]{0} broadcast(Arg_3.1775), dimensions={}
  divide.1780 = f64[32768]{0} divide(multiply.1778, broadcast.1779)
  floor.1781 = f64[32768]{0} floor(divide.1780)
  convert.1783 = s32[32768]{0} convert(floor.1781)
  subtract.1782 = f64[32768]{0} subtract(divide.1780, floor.1781)
  call.1784 = f64[6,32768,32]{2,1,0} call(Arg_4.1776, convert.1783, subtract.1782), to_apply=build_v_diag_weights.1386
  slice.1790 = f64[1,32768,32]{2,1,0} slice(call.1784), slice={[0:1], [0:32768], [0:32]}
  reshape.1791 = f64[32768,32]{1,0} reshape(slice.1790)
  Arg_0.1772 = f64[32768,32]{1,0} parameter(0)
  slice.1785 = s32[1]{0} slice(Arg_4.1776), slice={[0:1]}
  reshape.1786 = s32[] reshape(slice.1785)
  broadcast.1787 = s32[32768]{0} broadcast(reshape.1786), dimensions={}
  add.1788 = s32[32768]{0} add(convert.1783, broadcast.1787)
  call.1789 = f64[32768,32]{1,0} call(Arg_0.1772, add.1788), to_apply=_roll_dynamic.1538
  multiply.1792 = f64[32768,32]{1,0} multiply(reshape.1791, call.1789)
  slice.1798 = f64[1,32768,32]{2,1,0} slice(call.1784), slice={[1:2], [0:32768], [0:32]}
  reshape.1799 = f64[32768,32]{1,0} reshape(slice.1798)
  slice.1793 = s32[1]{0} slice(Arg_4.1776), slice={[1:2]}
  reshape.1794 = s32[] reshape(slice.1793)
  broadcast.1795 = s32[32768]{0} broadcast(reshape.1794), dimensions={}
  add.1796 = s32[32768]{0} add(convert.1783, broadcast.1795)
  call.1797 = f64[32768,32]{1,0} call(Arg_0.1772, add.1796), to_apply=_roll_dynamic.1581
  multiply.1800 = f64[32768,32]{1,0} multiply(reshape.1799, call.1797)
  add.1801 = f64[32768,32]{1,0} add(multiply.1792, multiply.1800)
  slice.1807 = f64[1,32768,32]{2,1,0} slice(call.1784), slice={[2:3], [0:32768], [0:32]}
  reshape.1808 = f64[32768,32]{1,0} reshape(slice.1807)
  slice.1802 = s32[1]{0} slice(Arg_4.1776), slice={[2:3]}
  reshape.1803 = s32[] reshape(slice.1802)
  broadcast.1804 = s32[32768]{0} broadcast(reshape.1803), dimensions={}
  add.1805 = s32[32768]{0} add(convert.1783, broadcast.1804)
  call.1806 = f64[32768,32]{1,0} call(Arg_0.1772, add.1805), to_apply=_roll_dynamic.1624
  multiply.1809 = f64[32768,32]{1,0} multiply(reshape.1808, call.1806)
  add.1810 = f64[32768,32]{1,0} add(add.1801, multiply.1809)
  slice.1816 = f64[1,32768,32]{2,1,0} slice(call.1784), slice={[3:4], [0:32768], [0:32]}
  reshape.1817 = f64[32768,32]{1,0} reshape(slice.1816)
  slice.1811 = s32[1]{0} slice(Arg_4.1776), slice={[3:4]}
  reshape.1812 = s32[] reshape(slice.1811)
  broadcast.1813 = s32[32768]{0} broadcast(reshape.1812), dimensions={}
  add.1814 = s32[32768]{0} add(convert.1783, broadcast.1813)
  call.1815 = f64[32768,32]{1,0} call(Arg_0.1772, add.1814), to_apply=_roll_dynamic.1667
  multiply.1818 = f64[32768,32]{1,0} multiply(reshape.1817, call.1815)
  add.1819 = f64[32768,32]{1,0} add(add.1810, multiply.1818)
  slice.1825 = f64[1,32768,32]{2,1,0} slice(call.1784), slice={[4:5], [0:32768], [0:32]}
  reshape.1826 = f64[32768,32]{1,0} reshape(slice.1825)
  slice.1820 = s32[1]{0} slice(Arg_4.1776), slice={[4:5]}
  reshape.1821 = s32[] reshape(slice.1820)
  broadcast.1822 = s32[32768]{0} broadcast(reshape.1821), dimensions={}
  add.1823 = s32[32768]{0} add(convert.1783, broadcast.1822)
  call.1824 = f64[32768,32]{1,0} call(Arg_0.1772, add.1823), to_apply=_roll_dynamic.1710
  multiply.1827 = f64[32768,32]{1,0} multiply(reshape.1826, call.1824)
  add.1828 = f64[32768,32]{1,0} add(add.1819, multiply.1827)
  slice.1834 = f64[1,32768,32]{2,1,0} slice(call.1784), slice={[5:6], [0:32768], [0:32]}
  reshape.1835 = f64[32768,32]{1,0} reshape(slice.1834)
  slice.1829 = s32[1]{0} slice(Arg_4.1776), slice={[5:6]}
  reshape.1830 = s32[] reshape(slice.1829)
  broadcast.1831 = s32[32768]{0} broadcast(reshape.1830), dimensions={}
  add.1832 = s32[32768]{0} add(convert.1783, broadcast.1831)
  call.1833 = f64[32768,32]{1,0} call(Arg_0.1772, add.1832), to_apply=_roll_dynamic.1753
  multiply.1836 = f64[32768,32]{1,0} multiply(reshape.1835, call.1833)
  ROOT add.1837 = f64[32768,32]{1,0} add(add.1828, multiply.1836)
}

_where.1838 {
  Arg_0.1839 = pred[] parameter(0)
  Arg_1.1840 = s32[] parameter(1)
  Arg_2.1841 = s32[] parameter(2)
  ROOT select.1842 = s32[] select(Arg_0.1839, Arg_1.1840, Arg_2.1841)
}

remainder.1843 {
  Arg_0.1844 = s32[32768]{0} parameter(0)
  Arg_1.1845 = s32[] parameter(1)
  constant.1849 = s32[] constant(0)
  compare.1850 = pred[] compare(Arg_1.1845, constant.1849), direction=EQ
  constant.1848 = s32[] constant(1)
  call.1851 = s32[] call(compare.1850, constant.1848, Arg_1.1845), to_apply=_where.1838
  broadcast.1852 = s32[32768]{0} broadcast(call.1851), dimensions={}
  remainder.1853 = s32[32768]{0} remainder(Arg_0.1844, broadcast.1852)
  constant.1846 = s32[] constant(0)
  broadcast.1847 = s32[32768]{0} broadcast(constant.1846), dimensions={}
  compare.1855 = pred[32768]{0} compare(remainder.1853, broadcast.1847), direction=LT
  compare.1856 = pred[] compare(call.1851, constant.1849), direction=LT
  broadcast.1857 = pred[32768]{0} broadcast(compare.1856), dimensions={}
  compare.1858 = pred[32768]{0} compare(compare.1855, broadcast.1857), direction=NE
  compare.1854 = pred[32768]{0} compare(remainder.1853, broadcast.1847), direction=NE
  and.1859 = pred[32768]{0} and(compare.1858, compare.1854)
  broadcast.1860 = s32[32768]{0} broadcast(call.1851), dimensions={}
  add.1861 = s32[32768]{0} add(remainder.1853, broadcast.1860)
  ROOT select.1862 = s32[32768]{0} select(and.1859, add.1861, remainder.1853)
}

_roll_dynamic.1863 {
  Arg_0.1864 = f64[32768,32]{1,0} parameter(0)
  concatenate.1874 = f64[32768,64]{1,0} concatenate(Arg_0.1864, Arg_0.1864), dimensions={1}
  constant.1870 = s32[] constant(32)
  broadcast.1871 = s32[32768]{0} broadcast(constant.1870), dimensions={}
  Arg_1.1865 = s32[32768]{0} parameter(1)
  constant.1872 = s32[] constant(32)
  call.1873 = s32[32768]{0} call(Arg_1.1865, constant.1872), to_apply=remainder.1843
  subtract.1875 = s32[32768]{0} subtract(broadcast.1871, call.1873)
  constant.1868 = s32[] constant(0)
  broadcast.1869 = s32[32768]{0} broadcast(constant.1868), dimensions={}
  compare.1876 = pred[32768]{0} compare(subtract.1875, broadcast.1869), direction=LT
  constant.1866 = s32[] constant(64)
  broadcast.1867 = s32[32768]{0} broadcast(constant.1866), dimensions={}
  add.1877 = s32[32768]{0} add(subtract.1875, broadcast.1867)
  select.1878 = s32[32768]{0} select(compare.1876, add.1877, subtract.1875)
  reshape.1879 = s32[32768,1]{1,0} reshape(select.1878)
  ROOT gather.1880 = f64[32768,32]{1,0} gather(concatenate.1874, reshape.1879), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1881 {
  Arg_0.1882 = pred[] parameter(0)
  Arg_1.1883 = s32[] parameter(1)
  Arg_2.1884 = s32[] parameter(2)
  ROOT select.1885 = s32[] select(Arg_0.1882, Arg_1.1883, Arg_2.1884)
}

remainder.1886 {
  Arg_0.1887 = s32[32768]{0} parameter(0)
  Arg_1.1888 = s32[] parameter(1)
  constant.1892 = s32[] constant(0)
  compare.1893 = pred[] compare(Arg_1.1888, constant.1892), direction=EQ
  constant.1891 = s32[] constant(1)
  call.1894 = s32[] call(compare.1893, constant.1891, Arg_1.1888), to_apply=_where.1881
  broadcast.1895 = s32[32768]{0} broadcast(call.1894), dimensions={}
  remainder.1896 = s32[32768]{0} remainder(Arg_0.1887, broadcast.1895)
  constant.1889 = s32[] constant(0)
  broadcast.1890 = s32[32768]{0} broadcast(constant.1889), dimensions={}
  compare.1898 = pred[32768]{0} compare(remainder.1896, broadcast.1890), direction=LT
  compare.1899 = pred[] compare(call.1894, constant.1892), direction=LT
  broadcast.1900 = pred[32768]{0} broadcast(compare.1899), dimensions={}
  compare.1901 = pred[32768]{0} compare(compare.1898, broadcast.1900), direction=NE
  compare.1897 = pred[32768]{0} compare(remainder.1896, broadcast.1890), direction=NE
  and.1902 = pred[32768]{0} and(compare.1901, compare.1897)
  broadcast.1903 = s32[32768]{0} broadcast(call.1894), dimensions={}
  add.1904 = s32[32768]{0} add(remainder.1896, broadcast.1903)
  ROOT select.1905 = s32[32768]{0} select(and.1902, add.1904, remainder.1896)
}

_roll_dynamic.1906 {
  Arg_0.1907 = f64[32768,32]{1,0} parameter(0)
  concatenate.1917 = f64[32768,64]{1,0} concatenate(Arg_0.1907, Arg_0.1907), dimensions={1}
  constant.1913 = s32[] constant(32)
  broadcast.1914 = s32[32768]{0} broadcast(constant.1913), dimensions={}
  Arg_1.1908 = s32[32768]{0} parameter(1)
  constant.1915 = s32[] constant(32)
  call.1916 = s32[32768]{0} call(Arg_1.1908, constant.1915), to_apply=remainder.1886
  subtract.1918 = s32[32768]{0} subtract(broadcast.1914, call.1916)
  constant.1911 = s32[] constant(0)
  broadcast.1912 = s32[32768]{0} broadcast(constant.1911), dimensions={}
  compare.1919 = pred[32768]{0} compare(subtract.1918, broadcast.1912), direction=LT
  constant.1909 = s32[] constant(64)
  broadcast.1910 = s32[32768]{0} broadcast(constant.1909), dimensions={}
  add.1920 = s32[32768]{0} add(subtract.1918, broadcast.1910)
  select.1921 = s32[32768]{0} select(compare.1919, add.1920, subtract.1918)
  reshape.1922 = s32[32768,1]{1,0} reshape(select.1921)
  ROOT gather.1923 = f64[32768,32]{1,0} gather(concatenate.1917, reshape.1922), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1924 {
  Arg_0.1925 = pred[] parameter(0)
  Arg_1.1926 = s32[] parameter(1)
  Arg_2.1927 = s32[] parameter(2)
  ROOT select.1928 = s32[] select(Arg_0.1925, Arg_1.1926, Arg_2.1927)
}

remainder.1929 {
  Arg_0.1930 = s32[32768]{0} parameter(0)
  Arg_1.1931 = s32[] parameter(1)
  constant.1935 = s32[] constant(0)
  compare.1936 = pred[] compare(Arg_1.1931, constant.1935), direction=EQ
  constant.1934 = s32[] constant(1)
  call.1937 = s32[] call(compare.1936, constant.1934, Arg_1.1931), to_apply=_where.1924
  broadcast.1938 = s32[32768]{0} broadcast(call.1937), dimensions={}
  remainder.1939 = s32[32768]{0} remainder(Arg_0.1930, broadcast.1938)
  constant.1932 = s32[] constant(0)
  broadcast.1933 = s32[32768]{0} broadcast(constant.1932), dimensions={}
  compare.1941 = pred[32768]{0} compare(remainder.1939, broadcast.1933), direction=LT
  compare.1942 = pred[] compare(call.1937, constant.1935), direction=LT
  broadcast.1943 = pred[32768]{0} broadcast(compare.1942), dimensions={}
  compare.1944 = pred[32768]{0} compare(compare.1941, broadcast.1943), direction=NE
  compare.1940 = pred[32768]{0} compare(remainder.1939, broadcast.1933), direction=NE
  and.1945 = pred[32768]{0} and(compare.1944, compare.1940)
  broadcast.1946 = s32[32768]{0} broadcast(call.1937), dimensions={}
  add.1947 = s32[32768]{0} add(remainder.1939, broadcast.1946)
  ROOT select.1948 = s32[32768]{0} select(and.1945, add.1947, remainder.1939)
}

_roll_dynamic.1949 {
  Arg_0.1950 = f64[32768,32]{1,0} parameter(0)
  concatenate.1960 = f64[32768,64]{1,0} concatenate(Arg_0.1950, Arg_0.1950), dimensions={1}
  constant.1956 = s32[] constant(32)
  broadcast.1957 = s32[32768]{0} broadcast(constant.1956), dimensions={}
  Arg_1.1951 = s32[32768]{0} parameter(1)
  constant.1958 = s32[] constant(32)
  call.1959 = s32[32768]{0} call(Arg_1.1951, constant.1958), to_apply=remainder.1929
  subtract.1961 = s32[32768]{0} subtract(broadcast.1957, call.1959)
  constant.1954 = s32[] constant(0)
  broadcast.1955 = s32[32768]{0} broadcast(constant.1954), dimensions={}
  compare.1962 = pred[32768]{0} compare(subtract.1961, broadcast.1955), direction=LT
  constant.1952 = s32[] constant(64)
  broadcast.1953 = s32[32768]{0} broadcast(constant.1952), dimensions={}
  add.1963 = s32[32768]{0} add(subtract.1961, broadcast.1953)
  select.1964 = s32[32768]{0} select(compare.1962, add.1963, subtract.1961)
  reshape.1965 = s32[32768,1]{1,0} reshape(select.1964)
  ROOT gather.1966 = f64[32768,32]{1,0} gather(concatenate.1960, reshape.1965), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.1967 {
  Arg_0.1968 = pred[] parameter(0)
  Arg_1.1969 = s32[] parameter(1)
  Arg_2.1970 = s32[] parameter(2)
  ROOT select.1971 = s32[] select(Arg_0.1968, Arg_1.1969, Arg_2.1970)
}

remainder.1972 {
  Arg_0.1973 = s32[32768]{0} parameter(0)
  Arg_1.1974 = s32[] parameter(1)
  constant.1978 = s32[] constant(0)
  compare.1979 = pred[] compare(Arg_1.1974, constant.1978), direction=EQ
  constant.1977 = s32[] constant(1)
  call.1980 = s32[] call(compare.1979, constant.1977, Arg_1.1974), to_apply=_where.1967
  broadcast.1981 = s32[32768]{0} broadcast(call.1980), dimensions={}
  remainder.1982 = s32[32768]{0} remainder(Arg_0.1973, broadcast.1981)
  constant.1975 = s32[] constant(0)
  broadcast.1976 = s32[32768]{0} broadcast(constant.1975), dimensions={}
  compare.1984 = pred[32768]{0} compare(remainder.1982, broadcast.1976), direction=LT
  compare.1985 = pred[] compare(call.1980, constant.1978), direction=LT
  broadcast.1986 = pred[32768]{0} broadcast(compare.1985), dimensions={}
  compare.1987 = pred[32768]{0} compare(compare.1984, broadcast.1986), direction=NE
  compare.1983 = pred[32768]{0} compare(remainder.1982, broadcast.1976), direction=NE
  and.1988 = pred[32768]{0} and(compare.1987, compare.1983)
  broadcast.1989 = s32[32768]{0} broadcast(call.1980), dimensions={}
  add.1990 = s32[32768]{0} add(remainder.1982, broadcast.1989)
  ROOT select.1991 = s32[32768]{0} select(and.1988, add.1990, remainder.1982)
}

_roll_dynamic.1992 {
  Arg_0.1993 = f64[32768,32]{1,0} parameter(0)
  concatenate.2003 = f64[32768,64]{1,0} concatenate(Arg_0.1993, Arg_0.1993), dimensions={1}
  constant.1999 = s32[] constant(32)
  broadcast.2000 = s32[32768]{0} broadcast(constant.1999), dimensions={}
  Arg_1.1994 = s32[32768]{0} parameter(1)
  constant.2001 = s32[] constant(32)
  call.2002 = s32[32768]{0} call(Arg_1.1994, constant.2001), to_apply=remainder.1972
  subtract.2004 = s32[32768]{0} subtract(broadcast.2000, call.2002)
  constant.1997 = s32[] constant(0)
  broadcast.1998 = s32[32768]{0} broadcast(constant.1997), dimensions={}
  compare.2005 = pred[32768]{0} compare(subtract.2004, broadcast.1998), direction=LT
  constant.1995 = s32[] constant(64)
  broadcast.1996 = s32[32768]{0} broadcast(constant.1995), dimensions={}
  add.2006 = s32[32768]{0} add(subtract.2004, broadcast.1996)
  select.2007 = s32[32768]{0} select(compare.2005, add.2006, subtract.2004)
  reshape.2008 = s32[32768,1]{1,0} reshape(select.2007)
  ROOT gather.2009 = f64[32768,32]{1,0} gather(concatenate.2003, reshape.2008), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2010 {
  Arg_0.2011 = pred[] parameter(0)
  Arg_1.2012 = s32[] parameter(1)
  Arg_2.2013 = s32[] parameter(2)
  ROOT select.2014 = s32[] select(Arg_0.2011, Arg_1.2012, Arg_2.2013)
}

remainder.2015 {
  Arg_0.2016 = s32[32768]{0} parameter(0)
  Arg_1.2017 = s32[] parameter(1)
  constant.2021 = s32[] constant(0)
  compare.2022 = pred[] compare(Arg_1.2017, constant.2021), direction=EQ
  constant.2020 = s32[] constant(1)
  call.2023 = s32[] call(compare.2022, constant.2020, Arg_1.2017), to_apply=_where.2010
  broadcast.2024 = s32[32768]{0} broadcast(call.2023), dimensions={}
  remainder.2025 = s32[32768]{0} remainder(Arg_0.2016, broadcast.2024)
  constant.2018 = s32[] constant(0)
  broadcast.2019 = s32[32768]{0} broadcast(constant.2018), dimensions={}
  compare.2027 = pred[32768]{0} compare(remainder.2025, broadcast.2019), direction=LT
  compare.2028 = pred[] compare(call.2023, constant.2021), direction=LT
  broadcast.2029 = pred[32768]{0} broadcast(compare.2028), dimensions={}
  compare.2030 = pred[32768]{0} compare(compare.2027, broadcast.2029), direction=NE
  compare.2026 = pred[32768]{0} compare(remainder.2025, broadcast.2019), direction=NE
  and.2031 = pred[32768]{0} and(compare.2030, compare.2026)
  broadcast.2032 = s32[32768]{0} broadcast(call.2023), dimensions={}
  add.2033 = s32[32768]{0} add(remainder.2025, broadcast.2032)
  ROOT select.2034 = s32[32768]{0} select(and.2031, add.2033, remainder.2025)
}

_roll_dynamic.2035 {
  Arg_0.2036 = f64[32768,32]{1,0} parameter(0)
  concatenate.2046 = f64[32768,64]{1,0} concatenate(Arg_0.2036, Arg_0.2036), dimensions={1}
  constant.2042 = s32[] constant(32)
  broadcast.2043 = s32[32768]{0} broadcast(constant.2042), dimensions={}
  Arg_1.2037 = s32[32768]{0} parameter(1)
  constant.2044 = s32[] constant(32)
  call.2045 = s32[32768]{0} call(Arg_1.2037, constant.2044), to_apply=remainder.2015
  subtract.2047 = s32[32768]{0} subtract(broadcast.2043, call.2045)
  constant.2040 = s32[] constant(0)
  broadcast.2041 = s32[32768]{0} broadcast(constant.2040), dimensions={}
  compare.2048 = pred[32768]{0} compare(subtract.2047, broadcast.2041), direction=LT
  constant.2038 = s32[] constant(64)
  broadcast.2039 = s32[32768]{0} broadcast(constant.2038), dimensions={}
  add.2049 = s32[32768]{0} add(subtract.2047, broadcast.2039)
  select.2050 = s32[32768]{0} select(compare.2048, add.2049, subtract.2047)
  reshape.2051 = s32[32768,1]{1,0} reshape(select.2050)
  ROOT gather.2052 = f64[32768,32]{1,0} gather(concatenate.2046, reshape.2051), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2053 {
  Arg_0.2054 = pred[] parameter(0)
  Arg_1.2055 = s32[] parameter(1)
  Arg_2.2056 = s32[] parameter(2)
  ROOT select.2057 = s32[] select(Arg_0.2054, Arg_1.2055, Arg_2.2056)
}

remainder.2058 {
  Arg_0.2059 = s32[32768]{0} parameter(0)
  Arg_1.2060 = s32[] parameter(1)
  constant.2064 = s32[] constant(0)
  compare.2065 = pred[] compare(Arg_1.2060, constant.2064), direction=EQ
  constant.2063 = s32[] constant(1)
  call.2066 = s32[] call(compare.2065, constant.2063, Arg_1.2060), to_apply=_where.2053
  broadcast.2067 = s32[32768]{0} broadcast(call.2066), dimensions={}
  remainder.2068 = s32[32768]{0} remainder(Arg_0.2059, broadcast.2067)
  constant.2061 = s32[] constant(0)
  broadcast.2062 = s32[32768]{0} broadcast(constant.2061), dimensions={}
  compare.2070 = pred[32768]{0} compare(remainder.2068, broadcast.2062), direction=LT
  compare.2071 = pred[] compare(call.2066, constant.2064), direction=LT
  broadcast.2072 = pred[32768]{0} broadcast(compare.2071), dimensions={}
  compare.2073 = pred[32768]{0} compare(compare.2070, broadcast.2072), direction=NE
  compare.2069 = pred[32768]{0} compare(remainder.2068, broadcast.2062), direction=NE
  and.2074 = pred[32768]{0} and(compare.2073, compare.2069)
  broadcast.2075 = s32[32768]{0} broadcast(call.2066), dimensions={}
  add.2076 = s32[32768]{0} add(remainder.2068, broadcast.2075)
  ROOT select.2077 = s32[32768]{0} select(and.2074, add.2076, remainder.2068)
}

_roll_dynamic.2078 {
  Arg_0.2079 = f64[32768,32]{1,0} parameter(0)
  concatenate.2089 = f64[32768,64]{1,0} concatenate(Arg_0.2079, Arg_0.2079), dimensions={1}
  constant.2085 = s32[] constant(32)
  broadcast.2086 = s32[32768]{0} broadcast(constant.2085), dimensions={}
  Arg_1.2080 = s32[32768]{0} parameter(1)
  constant.2087 = s32[] constant(32)
  call.2088 = s32[32768]{0} call(Arg_1.2080, constant.2087), to_apply=remainder.2058
  subtract.2090 = s32[32768]{0} subtract(broadcast.2086, call.2088)
  constant.2083 = s32[] constant(0)
  broadcast.2084 = s32[32768]{0} broadcast(constant.2083), dimensions={}
  compare.2091 = pred[32768]{0} compare(subtract.2090, broadcast.2084), direction=LT
  constant.2081 = s32[] constant(64)
  broadcast.2082 = s32[32768]{0} broadcast(constant.2081), dimensions={}
  add.2092 = s32[32768]{0} add(subtract.2090, broadcast.2082)
  select.2093 = s32[32768]{0} select(compare.2091, add.2092, subtract.2090)
  reshape.2094 = s32[32768,1]{1,0} reshape(select.2093)
  ROOT gather.2095 = f64[32768,32]{1,0} gather(concatenate.2089, reshape.2094), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.2096 {
  Arg_0.2097 = f64[32768,32]{1,0} parameter(0)
  Arg_1.2098 = f64[32768]{0} parameter(1)
  Arg_2.2099 = f64[] parameter(2)
  broadcast.2126 = f64[32768]{0} broadcast(Arg_2.2099), dimensions={}
  multiply.2127 = f64[32768]{0} multiply(Arg_1.2098, broadcast.2126)
  Arg_3.2100 = f64[] parameter(3)
  broadcast.2128 = f64[32768]{0} broadcast(Arg_3.2100), dimensions={}
  divide.2129 = f64[32768]{0} divide(multiply.2127, broadcast.2128)
  floor.2130 = f64[32768]{0} floor(divide.2129)
  convert.2132 = s32[32768]{0} convert(floor.2130)
  Arg_4.2101 = s32[6]{0} parameter(4)
  slice.2195 = s32[1]{0} slice(Arg_4.2101), slice={[0:1]}
  reshape.2196 = s32[] reshape(slice.2195)
  broadcast.2197 = s32[32768]{0} broadcast(reshape.2196), dimensions={}
  add.2198 = s32[32768]{0} add(convert.2132, broadcast.2197)
  call.2199 = f64[32768,32]{1,0} call(Arg_0.2097, add.2198), to_apply=_roll_dynamic.1863
  subtract.2131 = f64[32768]{0} subtract(divide.2129, floor.2130)
  constant.2124 = f64[] constant(20)
  broadcast.2125 = f64[32768]{0} broadcast(constant.2124), dimensions={}
  divide.2137 = f64[32768]{0} divide(subtract.2131, broadcast.2125)
  multiply.2133 = f64[32768]{0} multiply(subtract.2131, subtract.2131)
  constant.2122 = f64[] constant(24)
  broadcast.2123 = f64[32768]{0} broadcast(constant.2122), dimensions={}
  divide.2138 = f64[32768]{0} divide(multiply.2133, broadcast.2123)
  subtract.2139 = f64[32768]{0} subtract(divide.2137, divide.2138)
  multiply.2134 = f64[32768]{0} multiply(multiply.2133, subtract.2131)
  divide.2140 = f64[32768]{0} divide(multiply.2134, broadcast.2123)
  subtract.2141 = f64[32768]{0} subtract(subtract.2139, divide.2140)
  multiply.2135 = f64[32768]{0} multiply(multiply.2134, subtract.2131)
  divide.2142 = f64[32768]{0} divide(multiply.2135, broadcast.2123)
  add.2143 = f64[32768]{0} add(subtract.2141, divide.2142)
  multiply.2136 = f64[32768]{0} multiply(multiply.2135, subtract.2131)
  constant.2120 = f64[] constant(120)
  broadcast.2121 = f64[32768]{0} broadcast(constant.2120), dimensions={}
  divide.2144 = f64[32768]{0} divide(multiply.2136, broadcast.2121)
  subtract.2145 = f64[32768]{0} subtract(add.2143, divide.2144)
  reshape.2200 = f64[32768,1]{1,0} reshape(subtract.2145)
  broadcast.2201 = f64[32768,1]{1,0} broadcast(reshape.2200), dimensions={0,1}
  reshape.2202 = f64[32768]{0} reshape(broadcast.2201)
  broadcast.2203 = f64[32768,32]{1,0} broadcast(reshape.2202), dimensions={0}
  multiply.2204 = f64[32768,32]{1,0} multiply(call.2199, broadcast.2203)
  slice.2205 = s32[1]{0} slice(Arg_4.2101), slice={[1:2]}
  reshape.2206 = s32[] reshape(slice.2205)
  broadcast.2207 = s32[32768]{0} broadcast(reshape.2206), dimensions={}
  add.2208 = s32[32768]{0} add(convert.2132, broadcast.2207)
  call.2209 = f64[32768,32]{1,0} call(Arg_0.2097, add.2208), to_apply=_roll_dynamic.1906
  constant.2118 = f64[] constant(2)
  broadcast.2119 = f64[32768]{0} broadcast(constant.2118), dimensions={}
  divide.2146 = f64[32768]{0} divide(subtract.2131, broadcast.2119)
  negate.2147 = f64[32768]{0} negate(divide.2146)
  multiply.2148 = f64[32768]{0} multiply(multiply.2133, broadcast.2119)
  constant.2116 = f64[] constant(3)
  broadcast.2117 = f64[32768]{0} broadcast(constant.2116), dimensions={}
  divide.2149 = f64[32768]{0} divide(multiply.2148, broadcast.2117)
  add.2150 = f64[32768]{0} add(negate.2147, divide.2149)
  divide.2151 = f64[32768]{0} divide(multiply.2134, broadcast.2123)
  subtract.2152 = f64[32768]{0} subtract(add.2150, divide.2151)
  constant.2114 = f64[] constant(6)
  broadcast.2115 = f64[32768]{0} broadcast(constant.2114), dimensions={}
  divide.2153 = f64[32768]{0} divide(multiply.2135, broadcast.2115)
  subtract.2154 = f64[32768]{0} subtract(subtract.2152, divide.2153)
  divide.2155 = f64[32768]{0} divide(multiply.2136, broadcast.2123)
  add.2156 = f64[32768]{0} add(subtract.2154, divide.2155)
  reshape.2210 = f64[32768,1]{1,0} reshape(add.2156)
  broadcast.2211 = f64[32768,1]{1,0} broadcast(reshape.2210), dimensions={0,1}
  reshape.2212 = f64[32768]{0} reshape(broadcast.2211)
  broadcast.2213 = f64[32768,32]{1,0} broadcast(reshape.2212), dimensions={0}
  multiply.2214 = f64[32768,32]{1,0} multiply(call.2209, broadcast.2213)
  add.2215 = f64[32768,32]{1,0} add(multiply.2204, multiply.2214)
  slice.2216 = s32[1]{0} slice(Arg_4.2101), slice={[2:3]}
  reshape.2217 = s32[] reshape(slice.2216)
  broadcast.2218 = s32[32768]{0} broadcast(reshape.2217), dimensions={}
  add.2219 = s32[32768]{0} add(convert.2132, broadcast.2218)
  call.2220 = f64[32768,32]{1,0} call(Arg_0.2097, add.2219), to_apply=_roll_dynamic.1949
  constant.2112 = f64[] constant(1)
  broadcast.2113 = f64[32768]{0} broadcast(constant.2112), dimensions={}
  divide.2157 = f64[32768]{0} divide(subtract.2131, broadcast.2117)
  subtract.2158 = f64[32768]{0} subtract(broadcast.2113, divide.2157)
  constant.2110 = f64[] constant(5)
  broadcast.2111 = f64[32768]{0} broadcast(constant.2110), dimensions={}
  multiply.2159 = f64[32768]{0} multiply(multiply.2133, broadcast.2111)
  constant.2108 = f64[] constant(4)
  broadcast.2109 = f64[32768]{0} broadcast(constant.2108), dimensions={}
  divide.2160 = f64[32768]{0} divide(multiply.2159, broadcast.2109)
  subtract.2161 = f64[32768]{0} subtract(subtract.2158, divide.2160)
  multiply.2162 = f64[32768]{0} multiply(multiply.2134, broadcast.2111)
  constant.2106 = f64[] constant(12)
  broadcast.2107 = f64[32768]{0} broadcast(constant.2106), dimensions={}
  divide.2163 = f64[32768]{0} divide(multiply.2162, broadcast.2107)
  add.2164 = f64[32768]{0} add(subtract.2161, divide.2163)
  divide.2165 = f64[32768]{0} divide(multiply.2135, broadcast.2109)
  add.2166 = f64[32768]{0} add(add.2164, divide.2165)
  divide.2167 = f64[32768]{0} divide(multiply.2136, broadcast.2107)
  subtract.2168 = f64[32768]{0} subtract(add.2166, divide.2167)
  reshape.2221 = f64[32768,1]{1,0} reshape(subtract.2168)
  broadcast.2222 = f64[32768,1]{1,0} broadcast(reshape.2221), dimensions={0,1}
  reshape.2223 = f64[32768]{0} reshape(broadcast.2222)
  broadcast.2224 = f64[32768,32]{1,0} broadcast(reshape.2223), dimensions={0}
  multiply.2225 = f64[32768,32]{1,0} multiply(call.2220, broadcast.2224)
  add.2226 = f64[32768,32]{1,0} add(add.2215, multiply.2225)
  slice.2227 = s32[1]{0} slice(Arg_4.2101), slice={[3:4]}
  reshape.2228 = s32[] reshape(slice.2227)
  broadcast.2229 = s32[32768]{0} broadcast(reshape.2228), dimensions={}
  add.2230 = s32[32768]{0} add(convert.2132, broadcast.2229)
  call.2231 = f64[32768,32]{1,0} call(Arg_0.2097, add.2230), to_apply=_roll_dynamic.1992
  multiply.2169 = f64[32768]{0} multiply(multiply.2133, broadcast.2119)
  divide.2170 = f64[32768]{0} divide(multiply.2169, broadcast.2117)
  add.2171 = f64[32768]{0} add(subtract.2131, divide.2170)
  constant.2104 = f64[] constant(7)
  broadcast.2105 = f64[32768]{0} broadcast(constant.2104), dimensions={}
  multiply.2172 = f64[32768]{0} multiply(multiply.2134, broadcast.2105)
  divide.2173 = f64[32768]{0} divide(multiply.2172, broadcast.2107)
  subtract.2174 = f64[32768]{0} subtract(add.2171, divide.2173)
  divide.2175 = f64[32768]{0} divide(multiply.2135, broadcast.2115)
  subtract.2176 = f64[32768]{0} subtract(subtract.2174, divide.2175)
  divide.2177 = f64[32768]{0} divide(multiply.2136, broadcast.2107)
  add.2178 = f64[32768]{0} add(subtract.2176, divide.2177)
  reshape.2232 = f64[32768,1]{1,0} reshape(add.2178)
  broadcast.2233 = f64[32768,1]{1,0} broadcast(reshape.2232), dimensions={0,1}
  reshape.2234 = f64[32768]{0} reshape(broadcast.2233)
  broadcast.2235 = f64[32768,32]{1,0} broadcast(reshape.2234), dimensions={0}
  multiply.2236 = f64[32768,32]{1,0} multiply(call.2231, broadcast.2235)
  add.2237 = f64[32768,32]{1,0} add(add.2226, multiply.2236)
  slice.2238 = s32[1]{0} slice(Arg_4.2101), slice={[4:5]}
  reshape.2239 = s32[] reshape(slice.2238)
  broadcast.2240 = s32[32768]{0} broadcast(reshape.2239), dimensions={}
  add.2241 = s32[32768]{0} add(convert.2132, broadcast.2240)
  call.2242 = f64[32768,32]{1,0} call(Arg_0.2097, add.2241), to_apply=_roll_dynamic.2035
  divide.2179 = f64[32768]{0} divide(subtract.2131, broadcast.2109)
  negate.2180 = f64[32768]{0} negate(divide.2179)
  divide.2181 = f64[32768]{0} divide(multiply.2133, broadcast.2123)
  subtract.2182 = f64[32768]{0} subtract(negate.2180, divide.2181)
  multiply.2183 = f64[32768]{0} multiply(multiply.2134, broadcast.2105)
  divide.2184 = f64[32768]{0} divide(multiply.2183, broadcast.2123)
  add.2185 = f64[32768]{0} add(subtract.2182, divide.2184)
  divide.2186 = f64[32768]{0} divide(multiply.2135, broadcast.2123)
  add.2187 = f64[32768]{0} add(add.2185, divide.2186)
  divide.2188 = f64[32768]{0} divide(multiply.2136, broadcast.2123)
  subtract.2189 = f64[32768]{0} subtract(add.2187, divide.2188)
  reshape.2243 = f64[32768,1]{1,0} reshape(subtract.2189)
  broadcast.2244 = f64[32768,1]{1,0} broadcast(reshape.2243), dimensions={0,1}
  reshape.2245 = f64[32768]{0} reshape(broadcast.2244)
  broadcast.2246 = f64[32768,32]{1,0} broadcast(reshape.2245), dimensions={0}
  multiply.2247 = f64[32768,32]{1,0} multiply(call.2242, broadcast.2246)
  add.2248 = f64[32768,32]{1,0} add(add.2237, multiply.2247)
  slice.2249 = s32[1]{0} slice(Arg_4.2101), slice={[5:6]}
  reshape.2250 = s32[] reshape(slice.2249)
  broadcast.2251 = s32[32768]{0} broadcast(reshape.2250), dimensions={}
  add.2252 = s32[32768]{0} add(convert.2132, broadcast.2251)
  call.2253 = f64[32768,32]{1,0} call(Arg_0.2097, add.2252), to_apply=_roll_dynamic.2078
  constant.2102 = f64[] constant(30)
  broadcast.2103 = f64[32768]{0} broadcast(constant.2102), dimensions={}
  divide.2190 = f64[32768]{0} divide(subtract.2131, broadcast.2103)
  divide.2191 = f64[32768]{0} divide(multiply.2134, broadcast.2123)
  subtract.2192 = f64[32768]{0} subtract(divide.2190, divide.2191)
  divide.2193 = f64[32768]{0} divide(multiply.2136, broadcast.2121)
  add.2194 = f64[32768]{0} add(subtract.2192, divide.2193)
  reshape.2254 = f64[32768,1]{1,0} reshape(add.2194)
  broadcast.2255 = f64[32768,1]{1,0} broadcast(reshape.2254), dimensions={0,1}
  reshape.2256 = f64[32768]{0} reshape(broadcast.2255)
  broadcast.2257 = f64[32768,32]{1,0} broadcast(reshape.2256), dimensions={0}
  multiply.2258 = f64[32768,32]{1,0} multiply(call.2253, broadcast.2257)
  ROOT add.2259 = f64[32768,32]{1,0} add(add.2248, multiply.2258)
}

_where.2260 {
  Arg_0.2261 = pred[] parameter(0)
  Arg_1.2262 = s32[] parameter(1)
  Arg_2.2263 = s32[] parameter(2)
  ROOT select.2264 = s32[] select(Arg_0.2261, Arg_1.2262, Arg_2.2263)
}

remainder.2265 {
  Arg_0.2266 = s32[32768]{0} parameter(0)
  Arg_1.2267 = s32[] parameter(1)
  constant.2271 = s32[] constant(0)
  compare.2272 = pred[] compare(Arg_1.2267, constant.2271), direction=EQ
  constant.2270 = s32[] constant(1)
  call.2273 = s32[] call(compare.2272, constant.2270, Arg_1.2267), to_apply=_where.2260
  broadcast.2274 = s32[32768]{0} broadcast(call.2273), dimensions={}
  remainder.2275 = s32[32768]{0} remainder(Arg_0.2266, broadcast.2274)
  constant.2268 = s32[] constant(0)
  broadcast.2269 = s32[32768]{0} broadcast(constant.2268), dimensions={}
  compare.2277 = pred[32768]{0} compare(remainder.2275, broadcast.2269), direction=LT
  compare.2278 = pred[] compare(call.2273, constant.2271), direction=LT
  broadcast.2279 = pred[32768]{0} broadcast(compare.2278), dimensions={}
  compare.2280 = pred[32768]{0} compare(compare.2277, broadcast.2279), direction=NE
  compare.2276 = pred[32768]{0} compare(remainder.2275, broadcast.2269), direction=NE
  and.2281 = pred[32768]{0} and(compare.2280, compare.2276)
  broadcast.2282 = s32[32768]{0} broadcast(call.2273), dimensions={}
  add.2283 = s32[32768]{0} add(remainder.2275, broadcast.2282)
  ROOT select.2284 = s32[32768]{0} select(and.2281, add.2283, remainder.2275)
}

_roll_dynamic.2285 {
  Arg_0.2286 = f64[32768,32]{1,0} parameter(0)
  concatenate.2296 = f64[32768,64]{1,0} concatenate(Arg_0.2286, Arg_0.2286), dimensions={1}
  constant.2292 = s32[] constant(32)
  broadcast.2293 = s32[32768]{0} broadcast(constant.2292), dimensions={}
  Arg_1.2287 = s32[32768]{0} parameter(1)
  constant.2294 = s32[] constant(32)
  call.2295 = s32[32768]{0} call(Arg_1.2287, constant.2294), to_apply=remainder.2265
  subtract.2297 = s32[32768]{0} subtract(broadcast.2293, call.2295)
  constant.2290 = s32[] constant(0)
  broadcast.2291 = s32[32768]{0} broadcast(constant.2290), dimensions={}
  compare.2298 = pred[32768]{0} compare(subtract.2297, broadcast.2291), direction=LT
  constant.2288 = s32[] constant(64)
  broadcast.2289 = s32[32768]{0} broadcast(constant.2288), dimensions={}
  add.2299 = s32[32768]{0} add(subtract.2297, broadcast.2289)
  select.2300 = s32[32768]{0} select(compare.2298, add.2299, subtract.2297)
  reshape.2301 = s32[32768,1]{1,0} reshape(select.2300)
  ROOT gather.2302 = f64[32768,32]{1,0} gather(concatenate.2296, reshape.2301), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2303 {
  Arg_0.2304 = pred[] parameter(0)
  Arg_1.2305 = s32[] parameter(1)
  Arg_2.2306 = s32[] parameter(2)
  ROOT select.2307 = s32[] select(Arg_0.2304, Arg_1.2305, Arg_2.2306)
}

remainder.2308 {
  Arg_0.2309 = s32[32768]{0} parameter(0)
  Arg_1.2310 = s32[] parameter(1)
  constant.2314 = s32[] constant(0)
  compare.2315 = pred[] compare(Arg_1.2310, constant.2314), direction=EQ
  constant.2313 = s32[] constant(1)
  call.2316 = s32[] call(compare.2315, constant.2313, Arg_1.2310), to_apply=_where.2303
  broadcast.2317 = s32[32768]{0} broadcast(call.2316), dimensions={}
  remainder.2318 = s32[32768]{0} remainder(Arg_0.2309, broadcast.2317)
  constant.2311 = s32[] constant(0)
  broadcast.2312 = s32[32768]{0} broadcast(constant.2311), dimensions={}
  compare.2320 = pred[32768]{0} compare(remainder.2318, broadcast.2312), direction=LT
  compare.2321 = pred[] compare(call.2316, constant.2314), direction=LT
  broadcast.2322 = pred[32768]{0} broadcast(compare.2321), dimensions={}
  compare.2323 = pred[32768]{0} compare(compare.2320, broadcast.2322), direction=NE
  compare.2319 = pred[32768]{0} compare(remainder.2318, broadcast.2312), direction=NE
  and.2324 = pred[32768]{0} and(compare.2323, compare.2319)
  broadcast.2325 = s32[32768]{0} broadcast(call.2316), dimensions={}
  add.2326 = s32[32768]{0} add(remainder.2318, broadcast.2325)
  ROOT select.2327 = s32[32768]{0} select(and.2324, add.2326, remainder.2318)
}

_roll_dynamic.2328 {
  Arg_0.2329 = f64[32768,32]{1,0} parameter(0)
  concatenate.2339 = f64[32768,64]{1,0} concatenate(Arg_0.2329, Arg_0.2329), dimensions={1}
  constant.2335 = s32[] constant(32)
  broadcast.2336 = s32[32768]{0} broadcast(constant.2335), dimensions={}
  Arg_1.2330 = s32[32768]{0} parameter(1)
  constant.2337 = s32[] constant(32)
  call.2338 = s32[32768]{0} call(Arg_1.2330, constant.2337), to_apply=remainder.2308
  subtract.2340 = s32[32768]{0} subtract(broadcast.2336, call.2338)
  constant.2333 = s32[] constant(0)
  broadcast.2334 = s32[32768]{0} broadcast(constant.2333), dimensions={}
  compare.2341 = pred[32768]{0} compare(subtract.2340, broadcast.2334), direction=LT
  constant.2331 = s32[] constant(64)
  broadcast.2332 = s32[32768]{0} broadcast(constant.2331), dimensions={}
  add.2342 = s32[32768]{0} add(subtract.2340, broadcast.2332)
  select.2343 = s32[32768]{0} select(compare.2341, add.2342, subtract.2340)
  reshape.2344 = s32[32768,1]{1,0} reshape(select.2343)
  ROOT gather.2345 = f64[32768,32]{1,0} gather(concatenate.2339, reshape.2344), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2346 {
  Arg_0.2347 = pred[] parameter(0)
  Arg_1.2348 = s32[] parameter(1)
  Arg_2.2349 = s32[] parameter(2)
  ROOT select.2350 = s32[] select(Arg_0.2347, Arg_1.2348, Arg_2.2349)
}

remainder.2351 {
  Arg_0.2352 = s32[32768]{0} parameter(0)
  Arg_1.2353 = s32[] parameter(1)
  constant.2357 = s32[] constant(0)
  compare.2358 = pred[] compare(Arg_1.2353, constant.2357), direction=EQ
  constant.2356 = s32[] constant(1)
  call.2359 = s32[] call(compare.2358, constant.2356, Arg_1.2353), to_apply=_where.2346
  broadcast.2360 = s32[32768]{0} broadcast(call.2359), dimensions={}
  remainder.2361 = s32[32768]{0} remainder(Arg_0.2352, broadcast.2360)
  constant.2354 = s32[] constant(0)
  broadcast.2355 = s32[32768]{0} broadcast(constant.2354), dimensions={}
  compare.2363 = pred[32768]{0} compare(remainder.2361, broadcast.2355), direction=LT
  compare.2364 = pred[] compare(call.2359, constant.2357), direction=LT
  broadcast.2365 = pred[32768]{0} broadcast(compare.2364), dimensions={}
  compare.2366 = pred[32768]{0} compare(compare.2363, broadcast.2365), direction=NE
  compare.2362 = pred[32768]{0} compare(remainder.2361, broadcast.2355), direction=NE
  and.2367 = pred[32768]{0} and(compare.2366, compare.2362)
  broadcast.2368 = s32[32768]{0} broadcast(call.2359), dimensions={}
  add.2369 = s32[32768]{0} add(remainder.2361, broadcast.2368)
  ROOT select.2370 = s32[32768]{0} select(and.2367, add.2369, remainder.2361)
}

_roll_dynamic.2371 {
  Arg_0.2372 = f64[32768,32]{1,0} parameter(0)
  concatenate.2382 = f64[32768,64]{1,0} concatenate(Arg_0.2372, Arg_0.2372), dimensions={1}
  constant.2378 = s32[] constant(32)
  broadcast.2379 = s32[32768]{0} broadcast(constant.2378), dimensions={}
  Arg_1.2373 = s32[32768]{0} parameter(1)
  constant.2380 = s32[] constant(32)
  call.2381 = s32[32768]{0} call(Arg_1.2373, constant.2380), to_apply=remainder.2351
  subtract.2383 = s32[32768]{0} subtract(broadcast.2379, call.2381)
  constant.2376 = s32[] constant(0)
  broadcast.2377 = s32[32768]{0} broadcast(constant.2376), dimensions={}
  compare.2384 = pred[32768]{0} compare(subtract.2383, broadcast.2377), direction=LT
  constant.2374 = s32[] constant(64)
  broadcast.2375 = s32[32768]{0} broadcast(constant.2374), dimensions={}
  add.2385 = s32[32768]{0} add(subtract.2383, broadcast.2375)
  select.2386 = s32[32768]{0} select(compare.2384, add.2385, subtract.2383)
  reshape.2387 = s32[32768,1]{1,0} reshape(select.2386)
  ROOT gather.2388 = f64[32768,32]{1,0} gather(concatenate.2382, reshape.2387), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2389 {
  Arg_0.2390 = pred[] parameter(0)
  Arg_1.2391 = s32[] parameter(1)
  Arg_2.2392 = s32[] parameter(2)
  ROOT select.2393 = s32[] select(Arg_0.2390, Arg_1.2391, Arg_2.2392)
}

remainder.2394 {
  Arg_0.2395 = s32[32768]{0} parameter(0)
  Arg_1.2396 = s32[] parameter(1)
  constant.2400 = s32[] constant(0)
  compare.2401 = pred[] compare(Arg_1.2396, constant.2400), direction=EQ
  constant.2399 = s32[] constant(1)
  call.2402 = s32[] call(compare.2401, constant.2399, Arg_1.2396), to_apply=_where.2389
  broadcast.2403 = s32[32768]{0} broadcast(call.2402), dimensions={}
  remainder.2404 = s32[32768]{0} remainder(Arg_0.2395, broadcast.2403)
  constant.2397 = s32[] constant(0)
  broadcast.2398 = s32[32768]{0} broadcast(constant.2397), dimensions={}
  compare.2406 = pred[32768]{0} compare(remainder.2404, broadcast.2398), direction=LT
  compare.2407 = pred[] compare(call.2402, constant.2400), direction=LT
  broadcast.2408 = pred[32768]{0} broadcast(compare.2407), dimensions={}
  compare.2409 = pred[32768]{0} compare(compare.2406, broadcast.2408), direction=NE
  compare.2405 = pred[32768]{0} compare(remainder.2404, broadcast.2398), direction=NE
  and.2410 = pred[32768]{0} and(compare.2409, compare.2405)
  broadcast.2411 = s32[32768]{0} broadcast(call.2402), dimensions={}
  add.2412 = s32[32768]{0} add(remainder.2404, broadcast.2411)
  ROOT select.2413 = s32[32768]{0} select(and.2410, add.2412, remainder.2404)
}

_roll_dynamic.2414 {
  Arg_0.2415 = f64[32768,32]{1,0} parameter(0)
  concatenate.2425 = f64[32768,64]{1,0} concatenate(Arg_0.2415, Arg_0.2415), dimensions={1}
  constant.2421 = s32[] constant(32)
  broadcast.2422 = s32[32768]{0} broadcast(constant.2421), dimensions={}
  Arg_1.2416 = s32[32768]{0} parameter(1)
  constant.2423 = s32[] constant(32)
  call.2424 = s32[32768]{0} call(Arg_1.2416, constant.2423), to_apply=remainder.2394
  subtract.2426 = s32[32768]{0} subtract(broadcast.2422, call.2424)
  constant.2419 = s32[] constant(0)
  broadcast.2420 = s32[32768]{0} broadcast(constant.2419), dimensions={}
  compare.2427 = pred[32768]{0} compare(subtract.2426, broadcast.2420), direction=LT
  constant.2417 = s32[] constant(64)
  broadcast.2418 = s32[32768]{0} broadcast(constant.2417), dimensions={}
  add.2428 = s32[32768]{0} add(subtract.2426, broadcast.2418)
  select.2429 = s32[32768]{0} select(compare.2427, add.2428, subtract.2426)
  reshape.2430 = s32[32768,1]{1,0} reshape(select.2429)
  ROOT gather.2431 = f64[32768,32]{1,0} gather(concatenate.2425, reshape.2430), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2432 {
  Arg_0.2433 = pred[] parameter(0)
  Arg_1.2434 = s32[] parameter(1)
  Arg_2.2435 = s32[] parameter(2)
  ROOT select.2436 = s32[] select(Arg_0.2433, Arg_1.2434, Arg_2.2435)
}

remainder.2437 {
  Arg_0.2438 = s32[32768]{0} parameter(0)
  Arg_1.2439 = s32[] parameter(1)
  constant.2443 = s32[] constant(0)
  compare.2444 = pred[] compare(Arg_1.2439, constant.2443), direction=EQ
  constant.2442 = s32[] constant(1)
  call.2445 = s32[] call(compare.2444, constant.2442, Arg_1.2439), to_apply=_where.2432
  broadcast.2446 = s32[32768]{0} broadcast(call.2445), dimensions={}
  remainder.2447 = s32[32768]{0} remainder(Arg_0.2438, broadcast.2446)
  constant.2440 = s32[] constant(0)
  broadcast.2441 = s32[32768]{0} broadcast(constant.2440), dimensions={}
  compare.2449 = pred[32768]{0} compare(remainder.2447, broadcast.2441), direction=LT
  compare.2450 = pred[] compare(call.2445, constant.2443), direction=LT
  broadcast.2451 = pred[32768]{0} broadcast(compare.2450), dimensions={}
  compare.2452 = pred[32768]{0} compare(compare.2449, broadcast.2451), direction=NE
  compare.2448 = pred[32768]{0} compare(remainder.2447, broadcast.2441), direction=NE
  and.2453 = pred[32768]{0} and(compare.2452, compare.2448)
  broadcast.2454 = s32[32768]{0} broadcast(call.2445), dimensions={}
  add.2455 = s32[32768]{0} add(remainder.2447, broadcast.2454)
  ROOT select.2456 = s32[32768]{0} select(and.2453, add.2455, remainder.2447)
}

_roll_dynamic.2457 {
  Arg_0.2458 = f64[32768,32]{1,0} parameter(0)
  concatenate.2468 = f64[32768,64]{1,0} concatenate(Arg_0.2458, Arg_0.2458), dimensions={1}
  constant.2464 = s32[] constant(32)
  broadcast.2465 = s32[32768]{0} broadcast(constant.2464), dimensions={}
  Arg_1.2459 = s32[32768]{0} parameter(1)
  constant.2466 = s32[] constant(32)
  call.2467 = s32[32768]{0} call(Arg_1.2459, constant.2466), to_apply=remainder.2437
  subtract.2469 = s32[32768]{0} subtract(broadcast.2465, call.2467)
  constant.2462 = s32[] constant(0)
  broadcast.2463 = s32[32768]{0} broadcast(constant.2462), dimensions={}
  compare.2470 = pred[32768]{0} compare(subtract.2469, broadcast.2463), direction=LT
  constant.2460 = s32[] constant(64)
  broadcast.2461 = s32[32768]{0} broadcast(constant.2460), dimensions={}
  add.2471 = s32[32768]{0} add(subtract.2469, broadcast.2461)
  select.2472 = s32[32768]{0} select(compare.2470, add.2471, subtract.2469)
  reshape.2473 = s32[32768,1]{1,0} reshape(select.2472)
  ROOT gather.2474 = f64[32768,32]{1,0} gather(concatenate.2468, reshape.2473), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

_where.2475 {
  Arg_0.2476 = pred[] parameter(0)
  Arg_1.2477 = s32[] parameter(1)
  Arg_2.2478 = s32[] parameter(2)
  ROOT select.2479 = s32[] select(Arg_0.2476, Arg_1.2477, Arg_2.2478)
}

remainder.2480 {
  Arg_0.2481 = s32[32768]{0} parameter(0)
  Arg_1.2482 = s32[] parameter(1)
  constant.2486 = s32[] constant(0)
  compare.2487 = pred[] compare(Arg_1.2482, constant.2486), direction=EQ
  constant.2485 = s32[] constant(1)
  call.2488 = s32[] call(compare.2487, constant.2485, Arg_1.2482), to_apply=_where.2475
  broadcast.2489 = s32[32768]{0} broadcast(call.2488), dimensions={}
  remainder.2490 = s32[32768]{0} remainder(Arg_0.2481, broadcast.2489)
  constant.2483 = s32[] constant(0)
  broadcast.2484 = s32[32768]{0} broadcast(constant.2483), dimensions={}
  compare.2492 = pred[32768]{0} compare(remainder.2490, broadcast.2484), direction=LT
  compare.2493 = pred[] compare(call.2488, constant.2486), direction=LT
  broadcast.2494 = pred[32768]{0} broadcast(compare.2493), dimensions={}
  compare.2495 = pred[32768]{0} compare(compare.2492, broadcast.2494), direction=NE
  compare.2491 = pred[32768]{0} compare(remainder.2490, broadcast.2484), direction=NE
  and.2496 = pred[32768]{0} and(compare.2495, compare.2491)
  broadcast.2497 = s32[32768]{0} broadcast(call.2488), dimensions={}
  add.2498 = s32[32768]{0} add(remainder.2490, broadcast.2497)
  ROOT select.2499 = s32[32768]{0} select(and.2496, add.2498, remainder.2490)
}

_roll_dynamic.2500 {
  Arg_0.2501 = f64[32768,32]{1,0} parameter(0)
  concatenate.2511 = f64[32768,64]{1,0} concatenate(Arg_0.2501, Arg_0.2501), dimensions={1}
  constant.2507 = s32[] constant(32)
  broadcast.2508 = s32[32768]{0} broadcast(constant.2507), dimensions={}
  Arg_1.2502 = s32[32768]{0} parameter(1)
  constant.2509 = s32[] constant(32)
  call.2510 = s32[32768]{0} call(Arg_1.2502, constant.2509), to_apply=remainder.2480
  subtract.2512 = s32[32768]{0} subtract(broadcast.2508, call.2510)
  constant.2505 = s32[] constant(0)
  broadcast.2506 = s32[32768]{0} broadcast(constant.2505), dimensions={}
  compare.2513 = pred[32768]{0} compare(subtract.2512, broadcast.2506), direction=LT
  constant.2503 = s32[] constant(64)
  broadcast.2504 = s32[32768]{0} broadcast(constant.2503), dimensions={}
  add.2514 = s32[32768]{0} add(subtract.2512, broadcast.2504)
  select.2515 = s32[32768]{0} select(compare.2513, add.2514, subtract.2512)
  reshape.2516 = s32[32768,1]{1,0} reshape(select.2515)
  ROOT gather.2517 = f64[32768,32]{1,0} gather(concatenate.2511, reshape.2516), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.2518 {
  Arg_0.2519 = f64[32768,32]{1,0} parameter(0)
  Arg_1.2520 = f64[32768]{0} parameter(1)
  Arg_2.2521 = f64[] parameter(2)
  broadcast.2548 = f64[32768]{0} broadcast(Arg_2.2521), dimensions={}
  multiply.2549 = f64[32768]{0} multiply(Arg_1.2520, broadcast.2548)
  Arg_3.2522 = f64[] parameter(3)
  broadcast.2550 = f64[32768]{0} broadcast(Arg_3.2522), dimensions={}
  divide.2551 = f64[32768]{0} divide(multiply.2549, broadcast.2550)
  floor.2552 = f64[32768]{0} floor(divide.2551)
  convert.2554 = s32[32768]{0} convert(floor.2552)
  Arg_4.2523 = s32[6]{0} parameter(4)
  slice.2617 = s32[1]{0} slice(Arg_4.2523), slice={[0:1]}
  reshape.2618 = s32[] reshape(slice.2617)
  broadcast.2619 = s32[32768]{0} broadcast(reshape.2618), dimensions={}
  add.2620 = s32[32768]{0} add(convert.2554, broadcast.2619)
  call.2621 = f64[32768,32]{1,0} call(Arg_0.2519, add.2620), to_apply=_roll_dynamic.2285
  subtract.2553 = f64[32768]{0} subtract(divide.2551, floor.2552)
  constant.2546 = f64[] constant(20)
  broadcast.2547 = f64[32768]{0} broadcast(constant.2546), dimensions={}
  divide.2559 = f64[32768]{0} divide(subtract.2553, broadcast.2547)
  multiply.2555 = f64[32768]{0} multiply(subtract.2553, subtract.2553)
  constant.2544 = f64[] constant(24)
  broadcast.2545 = f64[32768]{0} broadcast(constant.2544), dimensions={}
  divide.2560 = f64[32768]{0} divide(multiply.2555, broadcast.2545)
  subtract.2561 = f64[32768]{0} subtract(divide.2559, divide.2560)
  multiply.2556 = f64[32768]{0} multiply(multiply.2555, subtract.2553)
  divide.2562 = f64[32768]{0} divide(multiply.2556, broadcast.2545)
  subtract.2563 = f64[32768]{0} subtract(subtract.2561, divide.2562)
  multiply.2557 = f64[32768]{0} multiply(multiply.2556, subtract.2553)
  divide.2564 = f64[32768]{0} divide(multiply.2557, broadcast.2545)
  add.2565 = f64[32768]{0} add(subtract.2563, divide.2564)
  multiply.2558 = f64[32768]{0} multiply(multiply.2557, subtract.2553)
  constant.2542 = f64[] constant(120)
  broadcast.2543 = f64[32768]{0} broadcast(constant.2542), dimensions={}
  divide.2566 = f64[32768]{0} divide(multiply.2558, broadcast.2543)
  subtract.2567 = f64[32768]{0} subtract(add.2565, divide.2566)
  reshape.2622 = f64[32768,1]{1,0} reshape(subtract.2567)
  broadcast.2623 = f64[32768,1]{1,0} broadcast(reshape.2622), dimensions={0,1}
  reshape.2624 = f64[32768]{0} reshape(broadcast.2623)
  broadcast.2625 = f64[32768,32]{1,0} broadcast(reshape.2624), dimensions={0}
  multiply.2626 = f64[32768,32]{1,0} multiply(call.2621, broadcast.2625)
  slice.2627 = s32[1]{0} slice(Arg_4.2523), slice={[1:2]}
  reshape.2628 = s32[] reshape(slice.2627)
  broadcast.2629 = s32[32768]{0} broadcast(reshape.2628), dimensions={}
  add.2630 = s32[32768]{0} add(convert.2554, broadcast.2629)
  call.2631 = f64[32768,32]{1,0} call(Arg_0.2519, add.2630), to_apply=_roll_dynamic.2328
  constant.2540 = f64[] constant(2)
  broadcast.2541 = f64[32768]{0} broadcast(constant.2540), dimensions={}
  divide.2568 = f64[32768]{0} divide(subtract.2553, broadcast.2541)
  negate.2569 = f64[32768]{0} negate(divide.2568)
  multiply.2570 = f64[32768]{0} multiply(multiply.2555, broadcast.2541)
  constant.2538 = f64[] constant(3)
  broadcast.2539 = f64[32768]{0} broadcast(constant.2538), dimensions={}
  divide.2571 = f64[32768]{0} divide(multiply.2570, broadcast.2539)
  add.2572 = f64[32768]{0} add(negate.2569, divide.2571)
  divide.2573 = f64[32768]{0} divide(multiply.2556, broadcast.2545)
  subtract.2574 = f64[32768]{0} subtract(add.2572, divide.2573)
  constant.2536 = f64[] constant(6)
  broadcast.2537 = f64[32768]{0} broadcast(constant.2536), dimensions={}
  divide.2575 = f64[32768]{0} divide(multiply.2557, broadcast.2537)
  subtract.2576 = f64[32768]{0} subtract(subtract.2574, divide.2575)
  divide.2577 = f64[32768]{0} divide(multiply.2558, broadcast.2545)
  add.2578 = f64[32768]{0} add(subtract.2576, divide.2577)
  reshape.2632 = f64[32768,1]{1,0} reshape(add.2578)
  broadcast.2633 = f64[32768,1]{1,0} broadcast(reshape.2632), dimensions={0,1}
  reshape.2634 = f64[32768]{0} reshape(broadcast.2633)
  broadcast.2635 = f64[32768,32]{1,0} broadcast(reshape.2634), dimensions={0}
  multiply.2636 = f64[32768,32]{1,0} multiply(call.2631, broadcast.2635)
  add.2637 = f64[32768,32]{1,0} add(multiply.2626, multiply.2636)
  slice.2638 = s32[1]{0} slice(Arg_4.2523), slice={[2:3]}
  reshape.2639 = s32[] reshape(slice.2638)
  broadcast.2640 = s32[32768]{0} broadcast(reshape.2639), dimensions={}
  add.2641 = s32[32768]{0} add(convert.2554, broadcast.2640)
  call.2642 = f64[32768,32]{1,0} call(Arg_0.2519, add.2641), to_apply=_roll_dynamic.2371
  constant.2534 = f64[] constant(1)
  broadcast.2535 = f64[32768]{0} broadcast(constant.2534), dimensions={}
  divide.2579 = f64[32768]{0} divide(subtract.2553, broadcast.2539)
  subtract.2580 = f64[32768]{0} subtract(broadcast.2535, divide.2579)
  constant.2532 = f64[] constant(5)
  broadcast.2533 = f64[32768]{0} broadcast(constant.2532), dimensions={}
  multiply.2581 = f64[32768]{0} multiply(multiply.2555, broadcast.2533)
  constant.2530 = f64[] constant(4)
  broadcast.2531 = f64[32768]{0} broadcast(constant.2530), dimensions={}
  divide.2582 = f64[32768]{0} divide(multiply.2581, broadcast.2531)
  subtract.2583 = f64[32768]{0} subtract(subtract.2580, divide.2582)
  multiply.2584 = f64[32768]{0} multiply(multiply.2556, broadcast.2533)
  constant.2528 = f64[] constant(12)
  broadcast.2529 = f64[32768]{0} broadcast(constant.2528), dimensions={}
  divide.2585 = f64[32768]{0} divide(multiply.2584, broadcast.2529)
  add.2586 = f64[32768]{0} add(subtract.2583, divide.2585)
  divide.2587 = f64[32768]{0} divide(multiply.2557, broadcast.2531)
  add.2588 = f64[32768]{0} add(add.2586, divide.2587)
  divide.2589 = f64[32768]{0} divide(multiply.2558, broadcast.2529)
  subtract.2590 = f64[32768]{0} subtract(add.2588, divide.2589)
  reshape.2643 = f64[32768,1]{1,0} reshape(subtract.2590)
  broadcast.2644 = f64[32768,1]{1,0} broadcast(reshape.2643), dimensions={0,1}
  reshape.2645 = f64[32768]{0} reshape(broadcast.2644)
  broadcast.2646 = f64[32768,32]{1,0} broadcast(reshape.2645), dimensions={0}
  multiply.2647 = f64[32768,32]{1,0} multiply(call.2642, broadcast.2646)
  add.2648 = f64[32768,32]{1,0} add(add.2637, multiply.2647)
  slice.2649 = s32[1]{0} slice(Arg_4.2523), slice={[3:4]}
  reshape.2650 = s32[] reshape(slice.2649)
  broadcast.2651 = s32[32768]{0} broadcast(reshape.2650), dimensions={}
  add.2652 = s32[32768]{0} add(convert.2554, broadcast.2651)
  call.2653 = f64[32768,32]{1,0} call(Arg_0.2519, add.2652), to_apply=_roll_dynamic.2414
  multiply.2591 = f64[32768]{0} multiply(multiply.2555, broadcast.2541)
  divide.2592 = f64[32768]{0} divide(multiply.2591, broadcast.2539)
  add.2593 = f64[32768]{0} add(subtract.2553, divide.2592)
  constant.2526 = f64[] constant(7)
  broadcast.2527 = f64[32768]{0} broadcast(constant.2526), dimensions={}
  multiply.2594 = f64[32768]{0} multiply(multiply.2556, broadcast.2527)
  divide.2595 = f64[32768]{0} divide(multiply.2594, broadcast.2529)
  subtract.2596 = f64[32768]{0} subtract(add.2593, divide.2595)
  divide.2597 = f64[32768]{0} divide(multiply.2557, broadcast.2537)
  subtract.2598 = f64[32768]{0} subtract(subtract.2596, divide.2597)
  divide.2599 = f64[32768]{0} divide(multiply.2558, broadcast.2529)
  add.2600 = f64[32768]{0} add(subtract.2598, divide.2599)
  reshape.2654 = f64[32768,1]{1,0} reshape(add.2600)
  broadcast.2655 = f64[32768,1]{1,0} broadcast(reshape.2654), dimensions={0,1}
  reshape.2656 = f64[32768]{0} reshape(broadcast.2655)
  broadcast.2657 = f64[32768,32]{1,0} broadcast(reshape.2656), dimensions={0}
  multiply.2658 = f64[32768,32]{1,0} multiply(call.2653, broadcast.2657)
  add.2659 = f64[32768,32]{1,0} add(add.2648, multiply.2658)
  slice.2660 = s32[1]{0} slice(Arg_4.2523), slice={[4:5]}
  reshape.2661 = s32[] reshape(slice.2660)
  broadcast.2662 = s32[32768]{0} broadcast(reshape.2661), dimensions={}
  add.2663 = s32[32768]{0} add(convert.2554, broadcast.2662)
  call.2664 = f64[32768,32]{1,0} call(Arg_0.2519, add.2663), to_apply=_roll_dynamic.2457
  divide.2601 = f64[32768]{0} divide(subtract.2553, broadcast.2531)
  negate.2602 = f64[32768]{0} negate(divide.2601)
  divide.2603 = f64[32768]{0} divide(multiply.2555, broadcast.2545)
  subtract.2604 = f64[32768]{0} subtract(negate.2602, divide.2603)
  multiply.2605 = f64[32768]{0} multiply(multiply.2556, broadcast.2527)
  divide.2606 = f64[32768]{0} divide(multiply.2605, broadcast.2545)
  add.2607 = f64[32768]{0} add(subtract.2604, divide.2606)
  divide.2608 = f64[32768]{0} divide(multiply.2557, broadcast.2545)
  add.2609 = f64[32768]{0} add(add.2607, divide.2608)
  divide.2610 = f64[32768]{0} divide(multiply.2558, broadcast.2545)
  subtract.2611 = f64[32768]{0} subtract(add.2609, divide.2610)
  reshape.2665 = f64[32768,1]{1,0} reshape(subtract.2611)
  broadcast.2666 = f64[32768,1]{1,0} broadcast(reshape.2665), dimensions={0,1}
  reshape.2667 = f64[32768]{0} reshape(broadcast.2666)
  broadcast.2668 = f64[32768,32]{1,0} broadcast(reshape.2667), dimensions={0}
  multiply.2669 = f64[32768,32]{1,0} multiply(call.2664, broadcast.2668)
  add.2670 = f64[32768,32]{1,0} add(add.2659, multiply.2669)
  slice.2671 = s32[1]{0} slice(Arg_4.2523), slice={[5:6]}
  reshape.2672 = s32[] reshape(slice.2671)
  broadcast.2673 = s32[32768]{0} broadcast(reshape.2672), dimensions={}
  add.2674 = s32[32768]{0} add(convert.2554, broadcast.2673)
  call.2675 = f64[32768,32]{1,0} call(Arg_0.2519, add.2674), to_apply=_roll_dynamic.2500
  constant.2524 = f64[] constant(30)
  broadcast.2525 = f64[32768]{0} broadcast(constant.2524), dimensions={}
  divide.2612 = f64[32768]{0} divide(subtract.2553, broadcast.2525)
  divide.2613 = f64[32768]{0} divide(multiply.2556, broadcast.2545)
  subtract.2614 = f64[32768]{0} subtract(divide.2612, divide.2613)
  divide.2615 = f64[32768]{0} divide(multiply.2558, broadcast.2543)
  add.2616 = f64[32768]{0} add(subtract.2614, divide.2615)
  reshape.2676 = f64[32768,1]{1,0} reshape(add.2616)
  broadcast.2677 = f64[32768,1]{1,0} broadcast(reshape.2676), dimensions={0,1}
  reshape.2678 = f64[32768]{0} reshape(broadcast.2677)
  broadcast.2679 = f64[32768,32]{1,0} broadcast(reshape.2678), dimensions={0}
  multiply.2680 = f64[32768,32]{1,0} multiply(call.2675, broadcast.2679)
  ROOT add.2681 = f64[32768,32]{1,0} add(add.2670, multiply.2680)
}

None.2682 {
  Arg_7.2690 = f64[32,32]{1,0} parameter(7)
  Arg_8.2691 = f64[32,32]{1,0} parameter(8)
  Arg_6.2689 = f64[32,32,32,32]{3,2,1,0} parameter(6)
  transpose.2697 = f64[32,32,32,32]{2,1,0,3} transpose(Arg_6.2689), dimensions={1,2,3,0}
  reshape.2698 = f64[32768,32]{1,0} reshape(transpose.2697)
  Arg_0.2683 = f64[32]{0} parameter(0)
  reshape.2696 = f64[1,32,1]{2,1,0} reshape(Arg_0.2683)
  broadcast.2699 = f64[1,32,1]{2,1,0} broadcast(reshape.2696), dimensions={0,1,2}
  reshape.2700 = f64[32]{0} reshape(broadcast.2699)
  broadcast.2701 = f64[32,32,32]{2,1,0} broadcast(reshape.2700), dimensions={1}
  reshape.2702 = f64[32768]{0} reshape(broadcast.2701)
  constant.2695 = f64[] constant(0.025)
  constant.2694 = f64[] constant(0.39269908169872414)
  Arg_1.2684 = s32[6]{0} parameter(1)
  call.2703 = f64[32768,32]{1,0} call(reshape.2698, reshape.2702, constant.2695, constant.2694, Arg_1.2684), to_apply=advect_1d_roll_diag.275
  reshape.2704 = f64[32,32,32,32]{3,2,1,0} reshape(call.2703)
  transpose.2706 = f64[32,32,32,32]{0,2,1,3} transpose(reshape.2704), dimensions={3,1,2,0}
  reshape.2707 = f64[32768,32]{1,0} reshape(transpose.2706)
  Arg_2.2685 = f64[32]{0} parameter(2)
  reshape.2705 = f64[1,1,32]{2,1,0} reshape(Arg_2.2685)
  broadcast.2708 = f64[1,1,32]{2,1,0} broadcast(reshape.2705), dimensions={0,1,2}
  reshape.2709 = f64[32]{0} reshape(broadcast.2708)
  broadcast.2710 = f64[32,32,32]{2,1,0} broadcast(reshape.2709), dimensions={2}
  reshape.2711 = f64[32768]{0} reshape(broadcast.2710)
  call.2712 = f64[32768,32]{1,0} call(reshape.2707, reshape.2711, constant.2695, constant.2694, Arg_1.2684), to_apply=advect_1d_roll_diag.697
  reshape.2713 = f64[32,32,32,32]{3,2,1,0} reshape(call.2712)
  transpose.2721 = f64[32,32,32,32]{1,2,3,0} transpose(reshape.2713), dimensions={0,3,2,1}
  reshape.2722 = f64[32768,32]{1,0} reshape(transpose.2721)
  transpose.2714 = f64[32,32,32,32]{1,3,2,0} transpose(reshape.2713), dimensions={0,3,1,2}
  Arg_3.2686 = f64[32,1]{1,0} parameter(3)
  Arg_4.2687 = f64[1,17]{1,0} parameter(4)
  Arg_5.2688 = f64[32,17]{1,0} parameter(5)
  constant.2693 = f64[] constant(0.32258064516129031)
  call.2715 = (f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) call(transpose.2714, Arg_3.2686, Arg_4.2687, Arg_5.2688, constant.2693, constant.2693), to_apply=solve_poisson.877
  get-tuple-element.2716 = f64[32,32]{1,0} get-tuple-element(call.2715), index=0
  reshape.2720 = f64[32,32,1]{2,1,0} reshape(get-tuple-element.2716)
  broadcast.2723 = f64[32,32,1]{2,1,0} broadcast(reshape.2720), dimensions={0,1,2}
  reshape.2724 = f64[32,32]{1,0} reshape(broadcast.2723)
  broadcast.2725 = f64[32,32,32]{2,1,0} broadcast(reshape.2724), dimensions={0,1}
  reshape.2726 = f64[32768]{0} reshape(broadcast.2725)
  constant.2692 = f64[] constant(0.05)
  call.2727 = f64[32768,32]{1,0} call(reshape.2722, reshape.2726, constant.2692, constant.2693, Arg_1.2684), to_apply=advect_1d_roll_diag_1.1310
  reshape.2728 = f64[32,32,32,32]{3,2,1,0} reshape(call.2727)
  transpose.2729 = f64[32,32,32,32]{2,3,1,0} transpose(reshape.2728), dimensions={0,1,3,2}
  reshape.2731 = f64[32768,32]{1,0} reshape(transpose.2729)
  get-tuple-element.2717 = f64[32,32]{1,0} get-tuple-element(call.2715), index=1
  reshape.2730 = f64[32,32,1]{2,1,0} reshape(get-tuple-element.2717)
  broadcast.2732 = f64[32,32,1]{2,1,0} broadcast(reshape.2730), dimensions={0,1,2}
  reshape.2733 = f64[32,32]{1,0} reshape(broadcast.2732)
  broadcast.2734 = f64[32,32,32]{2,1,0} broadcast(reshape.2733), dimensions={0,1}
  reshape.2735 = f64[32768]{0} reshape(broadcast.2734)
  call.2736 = f64[32768,32]{1,0} call(reshape.2731, reshape.2735, constant.2692, constant.2693, Arg_1.2684), to_apply=advect_1d_roll_diag_1.1771
  reshape.2737 = f64[32,32,32,32]{3,2,1,0} reshape(call.2736)
  transpose.2739 = f64[32,32,32,32]{2,1,3,0} transpose(reshape.2737), dimensions={0,2,3,1}
  reshape.2740 = f64[32768,32]{1,0} reshape(transpose.2739)
  reshape.2738 = f64[1,1,32]{2,1,0} reshape(Arg_2.2685)
  broadcast.2741 = f64[1,1,32]{2,1,0} broadcast(reshape.2738), dimensions={0,1,2}
  reshape.2742 = f64[32]{0} reshape(broadcast.2741)
  broadcast.2743 = f64[32,32,32]{2,1,0} broadcast(reshape.2742), dimensions={2}
  reshape.2744 = f64[32768]{0} reshape(broadcast.2743)
  call.2745 = f64[32768,32]{1,0} call(reshape.2740, reshape.2744, constant.2695, constant.2694, Arg_1.2684), to_apply=advect_1d_roll_diag.2096
  reshape.2746 = f64[32,32,32,32]{3,2,1,0} reshape(call.2745)
  transpose.2748 = f64[32,32,32,32]{0,2,1,3} transpose(reshape.2746), dimensions={3,1,2,0}
  reshape.2749 = f64[32768,32]{1,0} reshape(transpose.2748)
  reshape.2747 = f64[1,32,1]{2,1,0} reshape(Arg_0.2683)
  broadcast.2750 = f64[1,32,1]{2,1,0} broadcast(reshape.2747), dimensions={0,1,2}
  reshape.2751 = f64[32]{0} reshape(broadcast.2750)
  broadcast.2752 = f64[32,32,32]{2,1,0} broadcast(reshape.2751), dimensions={1}
  reshape.2753 = f64[32768]{0} reshape(broadcast.2752)
  call.2754 = f64[32768,32]{1,0} call(reshape.2749, reshape.2753, constant.2695, constant.2694, Arg_1.2684), to_apply=advect_1d_roll_diag.2518
  reshape.2755 = f64[32,32,32,32]{3,2,1,0} reshape(call.2754)
  transpose.2756 = f64[32,32,32,32]{0,3,2,1} transpose(reshape.2755), dimensions={3,0,1,2}
  get-tuple-element.2718 = f64[32,32]{1,0} get-tuple-element(call.2715), index=2
  get-tuple-element.2719 = f64[32,32]{1,0} get-tuple-element(call.2715), index=3
  ROOT tuple.2757 = (f64[32,32,32,32]{0,3,2,1}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(transpose.2756, get-tuple-element.2718, get-tuple-element.2719)
}

region_0.2758 {
  arg_tuple.2759 = (s64[], f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) parameter(0)
  get-tuple-element.2760 = s64[] get-tuple-element(arg_tuple.2759), index=0
  constant.2764 = s64[] constant(1)
  add.2774 = s64[] add(get-tuple-element.2760, constant.2764)
  constant.2769 = f64[32]{0} constant({...})
  constant.2768 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  constant.2767 = f64[32,1]{1,0} constant({...})
  constant.2766 = f64[1,17]{1,0} constant({...})
  constant.2765 = f64[32,17]{1,0} constant({...})
  get-tuple-element.2761 = f64[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.2759), index=1
  get-tuple-element.2762 = f64[32,32]{1,0} get-tuple-element(arg_tuple.2759), index=2
  get-tuple-element.2763 = f64[32,32]{1,0} get-tuple-element(arg_tuple.2759), index=3
  call.2770 = (f64[32,32,32,32]{0,3,2,1}, f64[32,32]{1,0}, f64[32,32]{1,0}) call(constant.2769, constant.2768, constant.2769, constant.2767, constant.2766, constant.2765, get-tuple-element.2761, get-tuple-element.2762, get-tuple-element.2763), to_apply=None.2682
  get-tuple-element.2771 = f64[32,32,32,32]{0,3,2,1} get-tuple-element(call.2770), index=0
  get-tuple-element.2772 = f64[32,32]{1,0} get-tuple-element(call.2770), index=1
  get-tuple-element.2773 = f64[32,32]{1,0} get-tuple-element(call.2770), index=2
  ROOT tuple.2775 = (s64[], f64[32,32,32,32]{0,3,2,1}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(add.2774, get-tuple-element.2771, get-tuple-element.2772, get-tuple-element.2773)
}

region_2.2776 {
  arg_tuple.2777 = (s64[], f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) parameter(0)
  get-tuple-element.2779 = f64[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.2777), index=1
  get-tuple-element.2780 = f64[32,32]{1,0} get-tuple-element(arg_tuple.2777), index=2
  get-tuple-element.2781 = f64[32,32]{1,0} get-tuple-element(arg_tuple.2777), index=3
  get-tuple-element.2778 = s64[] get-tuple-element(arg_tuple.2777), index=0
  constant.2782 = s64[] constant(128)
  ROOT compare.2783 = pred[] compare(get-tuple-element.2778, constant.2782), direction=LT
}

ENTRY main.2792 {
  constant.15 = s64[] constant(0)
  Arg_2.3 = f64[32,32,32,32]{3,2,1,0} parameter(2)
  Arg_0.1 = f64[32,32]{1,0} parameter(0)
  Arg_1.2 = f64[32,32]{1,0} parameter(1)
  tuple.16 = (s64[], f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(constant.15, Arg_2.3, Arg_0.1, Arg_1.2)
  while.2784 = (s64[], f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) while(tuple.16), condition=region_2.2776, body=region_0.2758
  get-tuple-element.2785 = s64[] get-tuple-element(while.2784), index=0
  constant.14 = f64[32]{0} constant({...})
  constant.9 = f64[32]{0} constant({...})
  constant.11 = f64[32,1]{1,0} constant({...})
  constant.12 = f64[1,17]{1,0} constant({...})
  constant.13 = f64[32,17]{1,0} constant({...})
  constant.10 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  get-tuple-element.2787 = f64[32,32]{1,0} get-tuple-element(while.2784), index=2
  get-tuple-element.2788 = f64[32,32]{1,0} get-tuple-element(while.2784), index=3
  get-tuple-element.2786 = f64[32,32,32,32]{3,2,1,0} get-tuple-element(while.2784), index=1
  Arg_3.4 = f64[32,32]{1,0} parameter(3)
  Arg_4.5 = f64[] parameter(4)
  constant.7 = f64[] constant(6.4)
  add.2789 = f64[] add(Arg_4.5, constant.7)
  Arg_5.6 = s64[] parameter(5)
  constant.8 = s64[] constant(128)
  add.2790 = s64[] add(Arg_5.6, constant.8)
  ROOT tuple.2791 = (f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32,1]{1,0}, /*index=5*/f64[1,17]{1,0}, f64[32,17]{1,0}, s32[6]{0}, f64[32,32]{1,0}, f64[32,32]{1,0}, /*index=10*/f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[], s64[]) tuple(constant.14, constant.14, constant.9, constant.9, constant.11, constant.12, constant.13, constant.10, get-tuple-element.2787, get-tuple-element.2788, get-tuple-element.2786, Arg_3.4, add.2789, add.2790)
}

