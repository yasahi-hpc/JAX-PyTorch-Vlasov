HloModule jit_run_chunk, entry_computation_layout={(f32[32,32,32]{2,1,0}, f32[], s32[])->(f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,32,32]{2,1,0}, f32[], /*index=5*/s32[])}

_where.9 {
  Arg_0.10 = pred[] parameter(0)
  Arg_1.11 = s32[] parameter(1)
  Arg_2.12 = s32[] parameter(2)
  ROOT select.13 = s32[] select(Arg_0.10, Arg_1.11, Arg_2.12)
}

remainder.14 {
  Arg_0.15 = s32[32]{0} parameter(0)
  Arg_1.16 = s32[] parameter(1)
  constant.20 = s32[] constant(0)
  compare.21 = pred[] compare(Arg_1.16, constant.20), direction=EQ
  constant.19 = s32[] constant(1)
  call.22 = s32[] call(compare.21, constant.19, Arg_1.16), to_apply=_where.9
  broadcast.23 = s32[32]{0} broadcast(call.22), dimensions={}
  remainder.24 = s32[32]{0} remainder(Arg_0.15, broadcast.23)
  constant.17 = s32[] constant(0)
  broadcast.18 = s32[32]{0} broadcast(constant.17), dimensions={}
  compare.26 = pred[32]{0} compare(remainder.24, broadcast.18), direction=LT
  compare.27 = pred[] compare(call.22, constant.20), direction=LT
  broadcast.28 = pred[32]{0} broadcast(compare.27), dimensions={}
  compare.29 = pred[32]{0} compare(compare.26, broadcast.28), direction=NE
  compare.25 = pred[32]{0} compare(remainder.24, broadcast.18), direction=NE
  and.30 = pred[32]{0} and(compare.29, compare.25)
  broadcast.31 = s32[32]{0} broadcast(call.22), dimensions={}
  add.32 = s32[32]{0} add(remainder.24, broadcast.31)
  ROOT select.33 = s32[32]{0} select(and.30, add.32, remainder.24)
}

_where_0.34 {
  Arg_0.35 = pred[32]{0} parameter(0)
  Arg_1.36 = s32[32]{0} parameter(1)
  Arg_2.37 = s32[32]{0} parameter(2)
  ROOT select.38 = s32[32]{0} select(Arg_0.35, Arg_1.36, Arg_2.37)
}

region_1.39 {
  Arg_0.40 = pred[] parameter(0)
  Arg_1.41 = pred[] parameter(1)
  ROOT and.42 = pred[] and(Arg_0.40, Arg_1.41)
}

_take.43 {
  Arg_1.45 = s32[32]{0} parameter(1)
  constant.55 = s32[] constant(0)
  broadcast.56 = s32[32]{0} broadcast(constant.55), dimensions={}
  compare.57 = pred[32]{0} compare(Arg_1.45, broadcast.56), direction=LT
  constant.52 = s32[] constant(32)
  broadcast.53 = s32[32]{0} broadcast(constant.52), dimensions={}
  add.58 = s32[32]{0} add(Arg_1.45, broadcast.53)
  call.59 = s32[32]{0} call(compare.57, add.58, Arg_1.45), to_apply=_where_0.34
  reshape.60 = s32[32,1]{1,0} reshape(call.59)
  constant.50 = s32[] constant(0)
  broadcast.51 = s32[32,1]{1,0} broadcast(constant.50), dimensions={}
  compare.61 = pred[32,1]{1,0} compare(reshape.60, broadcast.51), direction=GE
  constant.48 = s32[] constant(31)
  broadcast.49 = s32[32,1]{1,0} broadcast(constant.48), dimensions={}
  compare.62 = pred[32,1]{1,0} compare(reshape.60, broadcast.49), direction=LE
  and.63 = pred[32,1]{1,0} and(compare.61, compare.62)
  constant.54 = pred[] constant(true)
  reduce.64 = pred[32]{0} reduce(and.63, constant.54), dimensions={1}, to_apply=region_1.39
  broadcast.66 = pred[32,32,32]{2,1,0} broadcast(reduce.64), dimensions={0}
  Arg_0.44 = f32[32,32,32]{2,1,0} parameter(0)
  gather.65 = f32[32,32,32]{2,1,0} gather(Arg_0.44, reshape.60), offset_dims={1,2}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1,32,32}
  constant.46 = f32[] constant(nan)
  broadcast.47 = f32[32,32,32]{2,1,0} broadcast(constant.46), dimensions={}
  ROOT select.67 = f32[32,32,32]{2,1,0} select(broadcast.66, gather.65, broadcast.47)
}

_where.68 {
  Arg_0.69 = pred[] parameter(0)
  Arg_1.70 = s32[] parameter(1)
  Arg_2.71 = s32[] parameter(2)
  ROOT select.72 = s32[] select(Arg_0.69, Arg_1.70, Arg_2.71)
}

remainder.73 {
  Arg_0.74 = s32[32]{0} parameter(0)
  Arg_1.75 = s32[] parameter(1)
  constant.79 = s32[] constant(0)
  compare.80 = pred[] compare(Arg_1.75, constant.79), direction=EQ
  constant.78 = s32[] constant(1)
  call.81 = s32[] call(compare.80, constant.78, Arg_1.75), to_apply=_where.68
  broadcast.82 = s32[32]{0} broadcast(call.81), dimensions={}
  remainder.83 = s32[32]{0} remainder(Arg_0.74, broadcast.82)
  constant.76 = s32[] constant(0)
  broadcast.77 = s32[32]{0} broadcast(constant.76), dimensions={}
  compare.85 = pred[32]{0} compare(remainder.83, broadcast.77), direction=LT
  compare.86 = pred[] compare(call.81, constant.79), direction=LT
  broadcast.87 = pred[32]{0} broadcast(compare.86), dimensions={}
  compare.88 = pred[32]{0} compare(compare.85, broadcast.87), direction=NE
  compare.84 = pred[32]{0} compare(remainder.83, broadcast.77), direction=NE
  and.89 = pred[32]{0} and(compare.88, compare.84)
  broadcast.90 = s32[32]{0} broadcast(call.81), dimensions={}
  add.91 = s32[32]{0} add(remainder.83, broadcast.90)
  ROOT select.92 = s32[32]{0} select(and.89, add.91, remainder.83)
}

_where_0.93 {
  Arg_0.94 = pred[32]{0} parameter(0)
  Arg_1.95 = s32[32]{0} parameter(1)
  Arg_2.96 = s32[32]{0} parameter(2)
  ROOT select.97 = s32[32]{0} select(Arg_0.94, Arg_1.95, Arg_2.96)
}

region_1.98 {
  Arg_0.99 = pred[] parameter(0)
  Arg_1.100 = pred[] parameter(1)
  ROOT and.101 = pred[] and(Arg_0.99, Arg_1.100)
}

_take.102 {
  Arg_1.104 = s32[32]{0} parameter(1)
  constant.114 = s32[] constant(0)
  broadcast.115 = s32[32]{0} broadcast(constant.114), dimensions={}
  compare.116 = pred[32]{0} compare(Arg_1.104, broadcast.115), direction=LT
  constant.111 = s32[] constant(32)
  broadcast.112 = s32[32]{0} broadcast(constant.111), dimensions={}
  add.117 = s32[32]{0} add(Arg_1.104, broadcast.112)
  call.118 = s32[32]{0} call(compare.116, add.117, Arg_1.104), to_apply=_where_0.93
  reshape.119 = s32[32,1]{1,0} reshape(call.118)
  constant.109 = s32[] constant(0)
  broadcast.110 = s32[32,1]{1,0} broadcast(constant.109), dimensions={}
  compare.120 = pred[32,1]{1,0} compare(reshape.119, broadcast.110), direction=GE
  constant.107 = s32[] constant(31)
  broadcast.108 = s32[32,1]{1,0} broadcast(constant.107), dimensions={}
  compare.121 = pred[32,1]{1,0} compare(reshape.119, broadcast.108), direction=LE
  and.122 = pred[32,1]{1,0} and(compare.120, compare.121)
  constant.113 = pred[] constant(true)
  reduce.123 = pred[32]{0} reduce(and.122, constant.113), dimensions={1}, to_apply=region_1.98
  broadcast.125 = pred[32,32,32]{2,1,0} broadcast(reduce.123), dimensions={0}
  Arg_0.103 = f32[32,32,32]{2,1,0} parameter(0)
  gather.124 = f32[32,32,32]{2,1,0} gather(Arg_0.103, reshape.119), offset_dims={1,2}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1,32,32}
  constant.105 = f32[] constant(nan)
  broadcast.106 = f32[32,32,32]{2,1,0} broadcast(constant.105), dimensions={}
  ROOT select.126 = f32[32,32,32]{2,1,0} select(broadcast.125, gather.124, broadcast.106)
}

_where.127 {
  Arg_0.128 = pred[] parameter(0)
  Arg_1.129 = s32[] parameter(1)
  Arg_2.130 = s32[] parameter(2)
  ROOT select.131 = s32[] select(Arg_0.128, Arg_1.129, Arg_2.130)
}

remainder.132 {
  Arg_0.133 = s32[32]{0} parameter(0)
  Arg_1.134 = s32[] parameter(1)
  constant.138 = s32[] constant(0)
  compare.139 = pred[] compare(Arg_1.134, constant.138), direction=EQ
  constant.137 = s32[] constant(1)
  call.140 = s32[] call(compare.139, constant.137, Arg_1.134), to_apply=_where.127
  broadcast.141 = s32[32]{0} broadcast(call.140), dimensions={}
  remainder.142 = s32[32]{0} remainder(Arg_0.133, broadcast.141)
  constant.135 = s32[] constant(0)
  broadcast.136 = s32[32]{0} broadcast(constant.135), dimensions={}
  compare.144 = pred[32]{0} compare(remainder.142, broadcast.136), direction=LT
  compare.145 = pred[] compare(call.140, constant.138), direction=LT
  broadcast.146 = pred[32]{0} broadcast(compare.145), dimensions={}
  compare.147 = pred[32]{0} compare(compare.144, broadcast.146), direction=NE
  compare.143 = pred[32]{0} compare(remainder.142, broadcast.136), direction=NE
  and.148 = pred[32]{0} and(compare.147, compare.143)
  broadcast.149 = s32[32]{0} broadcast(call.140), dimensions={}
  add.150 = s32[32]{0} add(remainder.142, broadcast.149)
  ROOT select.151 = s32[32]{0} select(and.148, add.150, remainder.142)
}

_where_0.152 {
  Arg_0.153 = pred[32]{0} parameter(0)
  Arg_1.154 = s32[32]{0} parameter(1)
  Arg_2.155 = s32[32]{0} parameter(2)
  ROOT select.156 = s32[32]{0} select(Arg_0.153, Arg_1.154, Arg_2.155)
}

region_2.157 {
  Arg_0.158 = pred[] parameter(0)
  Arg_1.159 = pred[] parameter(1)
  ROOT and.160 = pred[] and(Arg_0.158, Arg_1.159)
}

_take_1.161 {
  Arg_1.163 = s32[32]{0} parameter(1)
  constant.173 = s32[] constant(0)
  broadcast.174 = s32[32]{0} broadcast(constant.173), dimensions={}
  compare.175 = pred[32]{0} compare(Arg_1.163, broadcast.174), direction=LT
  constant.170 = s32[] constant(32)
  broadcast.171 = s32[32]{0} broadcast(constant.170), dimensions={}
  add.176 = s32[32]{0} add(Arg_1.163, broadcast.171)
  call.177 = s32[32]{0} call(compare.175, add.176, Arg_1.163), to_apply=_where_0.152
  reshape.178 = s32[32,1]{1,0} reshape(call.177)
  constant.168 = s32[] constant(0)
  broadcast.169 = s32[32,1]{1,0} broadcast(constant.168), dimensions={}
  compare.179 = pred[32,1]{1,0} compare(reshape.178, broadcast.169), direction=GE
  constant.166 = s32[] constant(31)
  broadcast.167 = s32[32,1]{1,0} broadcast(constant.166), dimensions={}
  compare.180 = pred[32,1]{1,0} compare(reshape.178, broadcast.167), direction=LE
  and.181 = pred[32,1]{1,0} and(compare.179, compare.180)
  constant.172 = pred[] constant(true)
  reduce.182 = pred[32]{0} reduce(and.181, constant.172), dimensions={1}, to_apply=region_2.157
  broadcast.184 = pred[32,32,32]{2,1,0} broadcast(reduce.182), dimensions={1}
  Arg_0.162 = f32[32,32,32]{2,1,0} parameter(0)
  gather.183 = f32[32,32,32]{2,1,0} gather(Arg_0.162, reshape.178), offset_dims={0,2}, collapsed_slice_dims={1}, start_index_map={1}, index_vector_dim=1, slice_sizes={32,1,32}
  constant.164 = f32[] constant(nan)
  broadcast.165 = f32[32,32,32]{2,1,0} broadcast(constant.164), dimensions={}
  ROOT select.185 = f32[32,32,32]{2,1,0} select(broadcast.184, gather.183, broadcast.165)
}

_where.186 {
  Arg_0.187 = pred[] parameter(0)
  Arg_1.188 = s32[] parameter(1)
  Arg_2.189 = s32[] parameter(2)
  ROOT select.190 = s32[] select(Arg_0.187, Arg_1.188, Arg_2.189)
}

remainder.191 {
  Arg_0.192 = s32[32]{0} parameter(0)
  Arg_1.193 = s32[] parameter(1)
  constant.197 = s32[] constant(0)
  compare.198 = pred[] compare(Arg_1.193, constant.197), direction=EQ
  constant.196 = s32[] constant(1)
  call.199 = s32[] call(compare.198, constant.196, Arg_1.193), to_apply=_where.186
  broadcast.200 = s32[32]{0} broadcast(call.199), dimensions={}
  remainder.201 = s32[32]{0} remainder(Arg_0.192, broadcast.200)
  constant.194 = s32[] constant(0)
  broadcast.195 = s32[32]{0} broadcast(constant.194), dimensions={}
  compare.203 = pred[32]{0} compare(remainder.201, broadcast.195), direction=LT
  compare.204 = pred[] compare(call.199, constant.197), direction=LT
  broadcast.205 = pred[32]{0} broadcast(compare.204), dimensions={}
  compare.206 = pred[32]{0} compare(compare.203, broadcast.205), direction=NE
  compare.202 = pred[32]{0} compare(remainder.201, broadcast.195), direction=NE
  and.207 = pred[32]{0} and(compare.206, compare.202)
  broadcast.208 = s32[32]{0} broadcast(call.199), dimensions={}
  add.209 = s32[32]{0} add(remainder.201, broadcast.208)
  ROOT select.210 = s32[32]{0} select(and.207, add.209, remainder.201)
}

_where_0.211 {
  Arg_0.212 = pred[32]{0} parameter(0)
  Arg_1.213 = s32[32]{0} parameter(1)
  Arg_2.214 = s32[32]{0} parameter(2)
  ROOT select.215 = s32[32]{0} select(Arg_0.212, Arg_1.213, Arg_2.214)
}

region_2.216 {
  Arg_0.217 = pred[] parameter(0)
  Arg_1.218 = pred[] parameter(1)
  ROOT and.219 = pred[] and(Arg_0.217, Arg_1.218)
}

_take_1.220 {
  Arg_1.222 = s32[32]{0} parameter(1)
  constant.232 = s32[] constant(0)
  broadcast.233 = s32[32]{0} broadcast(constant.232), dimensions={}
  compare.234 = pred[32]{0} compare(Arg_1.222, broadcast.233), direction=LT
  constant.229 = s32[] constant(32)
  broadcast.230 = s32[32]{0} broadcast(constant.229), dimensions={}
  add.235 = s32[32]{0} add(Arg_1.222, broadcast.230)
  call.236 = s32[32]{0} call(compare.234, add.235, Arg_1.222), to_apply=_where_0.211
  reshape.237 = s32[32,1]{1,0} reshape(call.236)
  constant.227 = s32[] constant(0)
  broadcast.228 = s32[32,1]{1,0} broadcast(constant.227), dimensions={}
  compare.238 = pred[32,1]{1,0} compare(reshape.237, broadcast.228), direction=GE
  constant.225 = s32[] constant(31)
  broadcast.226 = s32[32,1]{1,0} broadcast(constant.225), dimensions={}
  compare.239 = pred[32,1]{1,0} compare(reshape.237, broadcast.226), direction=LE
  and.240 = pred[32,1]{1,0} and(compare.238, compare.239)
  constant.231 = pred[] constant(true)
  reduce.241 = pred[32]{0} reduce(and.240, constant.231), dimensions={1}, to_apply=region_2.216
  broadcast.243 = pred[32,32,32]{2,1,0} broadcast(reduce.241), dimensions={1}
  Arg_0.221 = f32[32,32,32]{2,1,0} parameter(0)
  gather.242 = f32[32,32,32]{2,1,0} gather(Arg_0.221, reshape.237), offset_dims={0,2}, collapsed_slice_dims={1}, start_index_map={1}, index_vector_dim=1, slice_sizes={32,1,32}
  constant.223 = f32[] constant(nan)
  broadcast.224 = f32[32,32,32]{2,1,0} broadcast(constant.223), dimensions={}
  ROOT select.244 = f32[32,32,32]{2,1,0} select(broadcast.243, gather.242, broadcast.224)
}

_where.245 {
  Arg_0.246 = pred[] parameter(0)
  Arg_1.247 = s32[] parameter(1)
  Arg_2.248 = s32[] parameter(2)
  ROOT select.249 = s32[] select(Arg_0.246, Arg_1.247, Arg_2.248)
}

remainder.250 {
  Arg_0.251 = s32[32]{0} parameter(0)
  Arg_1.252 = s32[] parameter(1)
  constant.256 = s32[] constant(0)
  compare.257 = pred[] compare(Arg_1.252, constant.256), direction=EQ
  constant.255 = s32[] constant(1)
  call.258 = s32[] call(compare.257, constant.255, Arg_1.252), to_apply=_where.245
  broadcast.259 = s32[32]{0} broadcast(call.258), dimensions={}
  remainder.260 = s32[32]{0} remainder(Arg_0.251, broadcast.259)
  constant.253 = s32[] constant(0)
  broadcast.254 = s32[32]{0} broadcast(constant.253), dimensions={}
  compare.262 = pred[32]{0} compare(remainder.260, broadcast.254), direction=LT
  compare.263 = pred[] compare(call.258, constant.256), direction=LT
  broadcast.264 = pred[32]{0} broadcast(compare.263), dimensions={}
  compare.265 = pred[32]{0} compare(compare.262, broadcast.264), direction=NE
  compare.261 = pred[32]{0} compare(remainder.260, broadcast.254), direction=NE
  and.266 = pred[32]{0} and(compare.265, compare.261)
  broadcast.267 = s32[32]{0} broadcast(call.258), dimensions={}
  add.268 = s32[32]{0} add(remainder.260, broadcast.267)
  ROOT select.269 = s32[32]{0} select(and.266, add.268, remainder.260)
}

_where_0.270 {
  Arg_0.271 = pred[32]{0} parameter(0)
  Arg_1.272 = s32[32]{0} parameter(1)
  Arg_2.273 = s32[32]{0} parameter(2)
  ROOT select.274 = s32[32]{0} select(Arg_0.271, Arg_1.272, Arg_2.273)
}

region_3.275 {
  Arg_0.276 = pred[] parameter(0)
  Arg_1.277 = pred[] parameter(1)
  ROOT and.278 = pred[] and(Arg_0.276, Arg_1.277)
}

_take_2.279 {
  Arg_1.281 = s32[32]{0} parameter(1)
  constant.291 = s32[] constant(0)
  broadcast.292 = s32[32]{0} broadcast(constant.291), dimensions={}
  compare.293 = pred[32]{0} compare(Arg_1.281, broadcast.292), direction=LT
  constant.288 = s32[] constant(32)
  broadcast.289 = s32[32]{0} broadcast(constant.288), dimensions={}
  add.294 = s32[32]{0} add(Arg_1.281, broadcast.289)
  call.295 = s32[32]{0} call(compare.293, add.294, Arg_1.281), to_apply=_where_0.270
  reshape.296 = s32[32,1]{1,0} reshape(call.295)
  constant.286 = s32[] constant(0)
  broadcast.287 = s32[32,1]{1,0} broadcast(constant.286), dimensions={}
  compare.297 = pred[32,1]{1,0} compare(reshape.296, broadcast.287), direction=GE
  constant.284 = s32[] constant(31)
  broadcast.285 = s32[32,1]{1,0} broadcast(constant.284), dimensions={}
  compare.298 = pred[32,1]{1,0} compare(reshape.296, broadcast.285), direction=LE
  and.299 = pred[32,1]{1,0} and(compare.297, compare.298)
  constant.290 = pred[] constant(true)
  reduce.300 = pred[32]{0} reduce(and.299, constant.290), dimensions={1}, to_apply=region_3.275
  broadcast.302 = pred[32,32,32]{2,1,0} broadcast(reduce.300), dimensions={2}
  Arg_0.280 = f32[32,32,32]{2,1,0} parameter(0)
  gather.301 = f32[32,32,32]{2,1,0} gather(Arg_0.280, reshape.296), offset_dims={0,1}, collapsed_slice_dims={2}, start_index_map={2}, index_vector_dim=1, slice_sizes={32,32,1}
  constant.282 = f32[] constant(nan)
  broadcast.283 = f32[32,32,32]{2,1,0} broadcast(constant.282), dimensions={}
  ROOT select.303 = f32[32,32,32]{2,1,0} select(broadcast.302, gather.301, broadcast.283)
}

_where.304 {
  Arg_0.305 = pred[] parameter(0)
  Arg_1.306 = s32[] parameter(1)
  Arg_2.307 = s32[] parameter(2)
  ROOT select.308 = s32[] select(Arg_0.305, Arg_1.306, Arg_2.307)
}

remainder.309 {
  Arg_0.310 = s32[32]{0} parameter(0)
  Arg_1.311 = s32[] parameter(1)
  constant.315 = s32[] constant(0)
  compare.316 = pred[] compare(Arg_1.311, constant.315), direction=EQ
  constant.314 = s32[] constant(1)
  call.317 = s32[] call(compare.316, constant.314, Arg_1.311), to_apply=_where.304
  broadcast.318 = s32[32]{0} broadcast(call.317), dimensions={}
  remainder.319 = s32[32]{0} remainder(Arg_0.310, broadcast.318)
  constant.312 = s32[] constant(0)
  broadcast.313 = s32[32]{0} broadcast(constant.312), dimensions={}
  compare.321 = pred[32]{0} compare(remainder.319, broadcast.313), direction=LT
  compare.322 = pred[] compare(call.317, constant.315), direction=LT
  broadcast.323 = pred[32]{0} broadcast(compare.322), dimensions={}
  compare.324 = pred[32]{0} compare(compare.321, broadcast.323), direction=NE
  compare.320 = pred[32]{0} compare(remainder.319, broadcast.313), direction=NE
  and.325 = pred[32]{0} and(compare.324, compare.320)
  broadcast.326 = s32[32]{0} broadcast(call.317), dimensions={}
  add.327 = s32[32]{0} add(remainder.319, broadcast.326)
  ROOT select.328 = s32[32]{0} select(and.325, add.327, remainder.319)
}

_where_0.329 {
  Arg_0.330 = pred[32]{0} parameter(0)
  Arg_1.331 = s32[32]{0} parameter(1)
  Arg_2.332 = s32[32]{0} parameter(2)
  ROOT select.333 = s32[32]{0} select(Arg_0.330, Arg_1.331, Arg_2.332)
}

region_3.334 {
  Arg_0.335 = pred[] parameter(0)
  Arg_1.336 = pred[] parameter(1)
  ROOT and.337 = pred[] and(Arg_0.335, Arg_1.336)
}

_take_2.338 {
  Arg_1.340 = s32[32]{0} parameter(1)
  constant.350 = s32[] constant(0)
  broadcast.351 = s32[32]{0} broadcast(constant.350), dimensions={}
  compare.352 = pred[32]{0} compare(Arg_1.340, broadcast.351), direction=LT
  constant.347 = s32[] constant(32)
  broadcast.348 = s32[32]{0} broadcast(constant.347), dimensions={}
  add.353 = s32[32]{0} add(Arg_1.340, broadcast.348)
  call.354 = s32[32]{0} call(compare.352, add.353, Arg_1.340), to_apply=_where_0.329
  reshape.355 = s32[32,1]{1,0} reshape(call.354)
  constant.345 = s32[] constant(0)
  broadcast.346 = s32[32,1]{1,0} broadcast(constant.345), dimensions={}
  compare.356 = pred[32,1]{1,0} compare(reshape.355, broadcast.346), direction=GE
  constant.343 = s32[] constant(31)
  broadcast.344 = s32[32,1]{1,0} broadcast(constant.343), dimensions={}
  compare.357 = pred[32,1]{1,0} compare(reshape.355, broadcast.344), direction=LE
  and.358 = pred[32,1]{1,0} and(compare.356, compare.357)
  constant.349 = pred[] constant(true)
  reduce.359 = pred[32]{0} reduce(and.358, constant.349), dimensions={1}, to_apply=region_3.334
  broadcast.361 = pred[32,32,32]{2,1,0} broadcast(reduce.359), dimensions={2}
  Arg_0.339 = f32[32,32,32]{2,1,0} parameter(0)
  gather.360 = f32[32,32,32]{2,1,0} gather(Arg_0.339, reshape.355), offset_dims={0,1}, collapsed_slice_dims={2}, start_index_map={2}, index_vector_dim=1, slice_sizes={32,32,1}
  constant.341 = f32[] constant(nan)
  broadcast.342 = f32[32,32,32]{2,1,0} broadcast(constant.341), dimensions={}
  ROOT select.362 = f32[32,32,32]{2,1,0} select(broadcast.361, gather.360, broadcast.342)
}

heat_step.363 {
  Arg_0.364 = f32[32,32,32]{2,1,0} parameter(0)
  Arg_1.365 = f32[] parameter(1)
  broadcast.402 = f32[32,32,32]{2,1,0} broadcast(Arg_1.365), dimensions={}
  iota.371 = s32[32]{0} iota(), iota_dimension=0
  constant.368 = s32[] constant(1)
  broadcast.369 = s32[32]{0} broadcast(constant.368), dimensions={}
  add.372 = s32[32]{0} add(iota.371, broadcast.369)
  constant.370 = s32[] constant(32)
  call.373 = s32[32]{0} call(add.372, constant.370), to_apply=remainder.14
  call.374 = f32[32,32,32]{2,1,0} call(Arg_0.364, call.373), to_apply=_take.43
  iota.375 = s32[32]{0} iota(), iota_dimension=0
  subtract.376 = s32[32]{0} subtract(iota.375, broadcast.369)
  call.377 = s32[32]{0} call(subtract.376, constant.370), to_apply=remainder.73
  call.378 = f32[32,32,32]{2,1,0} call(Arg_0.364, call.377), to_apply=_take.102
  add.395 = f32[32,32,32]{2,1,0} add(call.374, call.378)
  iota.379 = s32[32]{0} iota(), iota_dimension=0
  add.380 = s32[32]{0} add(iota.379, broadcast.369)
  call.381 = s32[32]{0} call(add.380, constant.370), to_apply=remainder.132
  call.382 = f32[32,32,32]{2,1,0} call(Arg_0.364, call.381), to_apply=_take_1.161
  add.396 = f32[32,32,32]{2,1,0} add(add.395, call.382)
  iota.383 = s32[32]{0} iota(), iota_dimension=0
  subtract.384 = s32[32]{0} subtract(iota.383, broadcast.369)
  call.385 = s32[32]{0} call(subtract.384, constant.370), to_apply=remainder.191
  call.386 = f32[32,32,32]{2,1,0} call(Arg_0.364, call.385), to_apply=_take_1.220
  add.397 = f32[32,32,32]{2,1,0} add(add.396, call.386)
  iota.387 = s32[32]{0} iota(), iota_dimension=0
  add.388 = s32[32]{0} add(iota.387, broadcast.369)
  call.389 = s32[32]{0} call(add.388, constant.370), to_apply=remainder.250
  call.390 = f32[32,32,32]{2,1,0} call(Arg_0.364, call.389), to_apply=_take_2.279
  add.398 = f32[32,32,32]{2,1,0} add(add.397, call.390)
  iota.391 = s32[32]{0} iota(), iota_dimension=0
  subtract.392 = s32[32]{0} subtract(iota.391, broadcast.369)
  call.393 = s32[32]{0} call(subtract.392, constant.370), to_apply=remainder.309
  call.394 = f32[32,32,32]{2,1,0} call(Arg_0.364, call.393), to_apply=_take_2.338
  add.399 = f32[32,32,32]{2,1,0} add(add.398, call.394)
  constant.366 = f32[] constant(6)
  broadcast.367 = f32[32,32,32]{2,1,0} broadcast(constant.366), dimensions={}
  multiply.400 = f32[32,32,32]{2,1,0} multiply(Arg_0.364, broadcast.367)
  subtract.401 = f32[32,32,32]{2,1,0} subtract(add.399, multiply.400)
  multiply.403 = f32[32,32,32]{2,1,0} multiply(broadcast.402, subtract.401)
  ROOT add.404 = f32[32,32,32]{2,1,0} add(Arg_0.364, multiply.403)
}

None.405 {
  Arg_0.406 = f32[32,32,32]{2,1,0} parameter(0)
  constant.407 = f32[] constant(0.000518764486)
  ROOT call.408 = f32[32,32,32]{2,1,0} call(Arg_0.406, constant.407), to_apply=heat_step.363
}

region_0.409 {
  arg_tuple.410 = (s32[], f32[32,32,32]{2,1,0}) parameter(0)
  get-tuple-element.411 = s32[] get-tuple-element(arg_tuple.410), index=0
  constant.413 = s32[] constant(1)
  add.415 = s32[] add(get-tuple-element.411, constant.413)
  get-tuple-element.412 = f32[32,32,32]{2,1,0} get-tuple-element(arg_tuple.410), index=1
  call.414 = f32[32,32,32]{2,1,0} call(get-tuple-element.412), to_apply=None.405
  ROOT tuple.416 = (s32[], f32[32,32,32]{2,1,0}) tuple(add.415, call.414)
}

region_4.417 {
  arg_tuple.418 = (s32[], f32[32,32,32]{2,1,0}) parameter(0)
  get-tuple-element.420 = f32[32,32,32]{2,1,0} get-tuple-element(arg_tuple.418), index=1
  get-tuple-element.419 = s32[] get-tuple-element(arg_tuple.418), index=0
  constant.421 = s32[] constant(100)
  ROOT compare.422 = pred[] compare(get-tuple-element.419, constant.421), direction=LT
}

ENTRY main.429 {
  constant.7 = s32[] constant(0)
  Arg_0.1 = f32[32,32,32]{2,1,0} parameter(0)
  tuple.8 = (s32[], f32[32,32,32]{2,1,0}) tuple(constant.7, Arg_0.1)
  while.423 = (s32[], f32[32,32,32]{2,1,0}) while(tuple.8), condition=region_4.417, body=region_0.409
  get-tuple-element.424 = s32[] get-tuple-element(while.423), index=0
  constant.6 = f32[32]{0} constant({...})
  get-tuple-element.425 = f32[32,32,32]{2,1,0} get-tuple-element(while.423), index=1
  Arg_1.2 = f32[] parameter(1)
  constant.4 = f32[] constant(2)
  add.426 = f32[] add(Arg_1.2, constant.4)
  Arg_2.3 = s32[] parameter(2)
  constant.5 = s32[] constant(100)
  add.427 = s32[] add(Arg_2.3, constant.5)
  ROOT tuple.428 = (f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,32,32]{2,1,0}, f32[], /*index=5*/s32[]) tuple(constant.6, constant.6, constant.6, get-tuple-element.425, add.426, add.427)
}

