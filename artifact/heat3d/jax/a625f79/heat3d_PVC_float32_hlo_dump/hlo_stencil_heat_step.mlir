HloModule jit_heat_step, entry_computation_layout={(f32[32,32,32]{2,1,0}, f32[])->f32[32,32,32]{2,1,0}}

_where.3 {
  Arg_0.4 = pred[] parameter(0)
  Arg_1.5 = s32[] parameter(1)
  Arg_2.6 = s32[] parameter(2)
  ROOT select.7 = s32[] select(Arg_0.4, Arg_1.5, Arg_2.6)
}

remainder.8 {
  Arg_0.9 = s32[32]{0} parameter(0)
  Arg_1.10 = s32[] parameter(1)
  constant.14 = s32[] constant(0)
  compare.15 = pred[] compare(Arg_1.10, constant.14), direction=EQ
  constant.13 = s32[] constant(1)
  call.16 = s32[] call(compare.15, constant.13, Arg_1.10), to_apply=_where.3
  broadcast.17 = s32[32]{0} broadcast(call.16), dimensions={}
  remainder.18 = s32[32]{0} remainder(Arg_0.9, broadcast.17)
  constant.11 = s32[] constant(0)
  broadcast.12 = s32[32]{0} broadcast(constant.11), dimensions={}
  compare.20 = pred[32]{0} compare(remainder.18, broadcast.12), direction=LT
  compare.21 = pred[] compare(call.16, constant.14), direction=LT
  broadcast.22 = pred[32]{0} broadcast(compare.21), dimensions={}
  compare.23 = pred[32]{0} compare(compare.20, broadcast.22), direction=NE
  compare.19 = pred[32]{0} compare(remainder.18, broadcast.12), direction=NE
  and.24 = pred[32]{0} and(compare.23, compare.19)
  broadcast.25 = s32[32]{0} broadcast(call.16), dimensions={}
  add.26 = s32[32]{0} add(remainder.18, broadcast.25)
  ROOT select.27 = s32[32]{0} select(and.24, add.26, remainder.18)
}

_where_0.28 {
  Arg_0.29 = pred[32]{0} parameter(0)
  Arg_1.30 = s32[32]{0} parameter(1)
  Arg_2.31 = s32[32]{0} parameter(2)
  ROOT select.32 = s32[32]{0} select(Arg_0.29, Arg_1.30, Arg_2.31)
}

region_0.33 {
  Arg_0.34 = pred[] parameter(0)
  Arg_1.35 = pred[] parameter(1)
  ROOT and.36 = pred[] and(Arg_0.34, Arg_1.35)
}

_take.37 {
  Arg_1.39 = s32[32]{0} parameter(1)
  constant.49 = s32[] constant(0)
  broadcast.50 = s32[32]{0} broadcast(constant.49), dimensions={}
  compare.51 = pred[32]{0} compare(Arg_1.39, broadcast.50), direction=LT
  constant.46 = s32[] constant(32)
  broadcast.47 = s32[32]{0} broadcast(constant.46), dimensions={}
  add.52 = s32[32]{0} add(Arg_1.39, broadcast.47)
  call.53 = s32[32]{0} call(compare.51, add.52, Arg_1.39), to_apply=_where_0.28
  reshape.54 = s32[32,1]{1,0} reshape(call.53)
  constant.44 = s32[] constant(0)
  broadcast.45 = s32[32,1]{1,0} broadcast(constant.44), dimensions={}
  compare.55 = pred[32,1]{1,0} compare(reshape.54, broadcast.45), direction=GE
  constant.42 = s32[] constant(31)
  broadcast.43 = s32[32,1]{1,0} broadcast(constant.42), dimensions={}
  compare.56 = pred[32,1]{1,0} compare(reshape.54, broadcast.43), direction=LE
  and.57 = pred[32,1]{1,0} and(compare.55, compare.56)
  constant.48 = pred[] constant(true)
  reduce.58 = pred[32]{0} reduce(and.57, constant.48), dimensions={1}, to_apply=region_0.33
  broadcast.60 = pred[32,32,32]{2,1,0} broadcast(reduce.58), dimensions={0}
  Arg_0.38 = f32[32,32,32]{2,1,0} parameter(0)
  gather.59 = f32[32,32,32]{2,1,0} gather(Arg_0.38, reshape.54), offset_dims={1,2}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1,32,32}
  constant.40 = f32[] constant(nan)
  broadcast.41 = f32[32,32,32]{2,1,0} broadcast(constant.40), dimensions={}
  ROOT select.61 = f32[32,32,32]{2,1,0} select(broadcast.60, gather.59, broadcast.41)
}

_where.62 {
  Arg_0.63 = pred[] parameter(0)
  Arg_1.64 = s32[] parameter(1)
  Arg_2.65 = s32[] parameter(2)
  ROOT select.66 = s32[] select(Arg_0.63, Arg_1.64, Arg_2.65)
}

remainder.67 {
  Arg_0.68 = s32[32]{0} parameter(0)
  Arg_1.69 = s32[] parameter(1)
  constant.73 = s32[] constant(0)
  compare.74 = pred[] compare(Arg_1.69, constant.73), direction=EQ
  constant.72 = s32[] constant(1)
  call.75 = s32[] call(compare.74, constant.72, Arg_1.69), to_apply=_where.62
  broadcast.76 = s32[32]{0} broadcast(call.75), dimensions={}
  remainder.77 = s32[32]{0} remainder(Arg_0.68, broadcast.76)
  constant.70 = s32[] constant(0)
  broadcast.71 = s32[32]{0} broadcast(constant.70), dimensions={}
  compare.79 = pred[32]{0} compare(remainder.77, broadcast.71), direction=LT
  compare.80 = pred[] compare(call.75, constant.73), direction=LT
  broadcast.81 = pred[32]{0} broadcast(compare.80), dimensions={}
  compare.82 = pred[32]{0} compare(compare.79, broadcast.81), direction=NE
  compare.78 = pred[32]{0} compare(remainder.77, broadcast.71), direction=NE
  and.83 = pred[32]{0} and(compare.82, compare.78)
  broadcast.84 = s32[32]{0} broadcast(call.75), dimensions={}
  add.85 = s32[32]{0} add(remainder.77, broadcast.84)
  ROOT select.86 = s32[32]{0} select(and.83, add.85, remainder.77)
}

_where_0.87 {
  Arg_0.88 = pred[32]{0} parameter(0)
  Arg_1.89 = s32[32]{0} parameter(1)
  Arg_2.90 = s32[32]{0} parameter(2)
  ROOT select.91 = s32[32]{0} select(Arg_0.88, Arg_1.89, Arg_2.90)
}

region_0.92 {
  Arg_0.93 = pred[] parameter(0)
  Arg_1.94 = pred[] parameter(1)
  ROOT and.95 = pred[] and(Arg_0.93, Arg_1.94)
}

_take.96 {
  Arg_1.98 = s32[32]{0} parameter(1)
  constant.108 = s32[] constant(0)
  broadcast.109 = s32[32]{0} broadcast(constant.108), dimensions={}
  compare.110 = pred[32]{0} compare(Arg_1.98, broadcast.109), direction=LT
  constant.105 = s32[] constant(32)
  broadcast.106 = s32[32]{0} broadcast(constant.105), dimensions={}
  add.111 = s32[32]{0} add(Arg_1.98, broadcast.106)
  call.112 = s32[32]{0} call(compare.110, add.111, Arg_1.98), to_apply=_where_0.87
  reshape.113 = s32[32,1]{1,0} reshape(call.112)
  constant.103 = s32[] constant(0)
  broadcast.104 = s32[32,1]{1,0} broadcast(constant.103), dimensions={}
  compare.114 = pred[32,1]{1,0} compare(reshape.113, broadcast.104), direction=GE
  constant.101 = s32[] constant(31)
  broadcast.102 = s32[32,1]{1,0} broadcast(constant.101), dimensions={}
  compare.115 = pred[32,1]{1,0} compare(reshape.113, broadcast.102), direction=LE
  and.116 = pred[32,1]{1,0} and(compare.114, compare.115)
  constant.107 = pred[] constant(true)
  reduce.117 = pred[32]{0} reduce(and.116, constant.107), dimensions={1}, to_apply=region_0.92
  broadcast.119 = pred[32,32,32]{2,1,0} broadcast(reduce.117), dimensions={0}
  Arg_0.97 = f32[32,32,32]{2,1,0} parameter(0)
  gather.118 = f32[32,32,32]{2,1,0} gather(Arg_0.97, reshape.113), offset_dims={1,2}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1,32,32}
  constant.99 = f32[] constant(nan)
  broadcast.100 = f32[32,32,32]{2,1,0} broadcast(constant.99), dimensions={}
  ROOT select.120 = f32[32,32,32]{2,1,0} select(broadcast.119, gather.118, broadcast.100)
}

_where.121 {
  Arg_0.122 = pred[] parameter(0)
  Arg_1.123 = s32[] parameter(1)
  Arg_2.124 = s32[] parameter(2)
  ROOT select.125 = s32[] select(Arg_0.122, Arg_1.123, Arg_2.124)
}

remainder.126 {
  Arg_0.127 = s32[32]{0} parameter(0)
  Arg_1.128 = s32[] parameter(1)
  constant.132 = s32[] constant(0)
  compare.133 = pred[] compare(Arg_1.128, constant.132), direction=EQ
  constant.131 = s32[] constant(1)
  call.134 = s32[] call(compare.133, constant.131, Arg_1.128), to_apply=_where.121
  broadcast.135 = s32[32]{0} broadcast(call.134), dimensions={}
  remainder.136 = s32[32]{0} remainder(Arg_0.127, broadcast.135)
  constant.129 = s32[] constant(0)
  broadcast.130 = s32[32]{0} broadcast(constant.129), dimensions={}
  compare.138 = pred[32]{0} compare(remainder.136, broadcast.130), direction=LT
  compare.139 = pred[] compare(call.134, constant.132), direction=LT
  broadcast.140 = pred[32]{0} broadcast(compare.139), dimensions={}
  compare.141 = pred[32]{0} compare(compare.138, broadcast.140), direction=NE
  compare.137 = pred[32]{0} compare(remainder.136, broadcast.130), direction=NE
  and.142 = pred[32]{0} and(compare.141, compare.137)
  broadcast.143 = s32[32]{0} broadcast(call.134), dimensions={}
  add.144 = s32[32]{0} add(remainder.136, broadcast.143)
  ROOT select.145 = s32[32]{0} select(and.142, add.144, remainder.136)
}

_where_0.146 {
  Arg_0.147 = pred[32]{0} parameter(0)
  Arg_1.148 = s32[32]{0} parameter(1)
  Arg_2.149 = s32[32]{0} parameter(2)
  ROOT select.150 = s32[32]{0} select(Arg_0.147, Arg_1.148, Arg_2.149)
}

region_1.151 {
  Arg_0.152 = pred[] parameter(0)
  Arg_1.153 = pred[] parameter(1)
  ROOT and.154 = pred[] and(Arg_0.152, Arg_1.153)
}

_take_1.155 {
  Arg_1.157 = s32[32]{0} parameter(1)
  constant.167 = s32[] constant(0)
  broadcast.168 = s32[32]{0} broadcast(constant.167), dimensions={}
  compare.169 = pred[32]{0} compare(Arg_1.157, broadcast.168), direction=LT
  constant.164 = s32[] constant(32)
  broadcast.165 = s32[32]{0} broadcast(constant.164), dimensions={}
  add.170 = s32[32]{0} add(Arg_1.157, broadcast.165)
  call.171 = s32[32]{0} call(compare.169, add.170, Arg_1.157), to_apply=_where_0.146
  reshape.172 = s32[32,1]{1,0} reshape(call.171)
  constant.162 = s32[] constant(0)
  broadcast.163 = s32[32,1]{1,0} broadcast(constant.162), dimensions={}
  compare.173 = pred[32,1]{1,0} compare(reshape.172, broadcast.163), direction=GE
  constant.160 = s32[] constant(31)
  broadcast.161 = s32[32,1]{1,0} broadcast(constant.160), dimensions={}
  compare.174 = pred[32,1]{1,0} compare(reshape.172, broadcast.161), direction=LE
  and.175 = pred[32,1]{1,0} and(compare.173, compare.174)
  constant.166 = pred[] constant(true)
  reduce.176 = pred[32]{0} reduce(and.175, constant.166), dimensions={1}, to_apply=region_1.151
  broadcast.178 = pred[32,32,32]{2,1,0} broadcast(reduce.176), dimensions={1}
  Arg_0.156 = f32[32,32,32]{2,1,0} parameter(0)
  gather.177 = f32[32,32,32]{2,1,0} gather(Arg_0.156, reshape.172), offset_dims={0,2}, collapsed_slice_dims={1}, start_index_map={1}, index_vector_dim=1, slice_sizes={32,1,32}
  constant.158 = f32[] constant(nan)
  broadcast.159 = f32[32,32,32]{2,1,0} broadcast(constant.158), dimensions={}
  ROOT select.179 = f32[32,32,32]{2,1,0} select(broadcast.178, gather.177, broadcast.159)
}

_where.180 {
  Arg_0.181 = pred[] parameter(0)
  Arg_1.182 = s32[] parameter(1)
  Arg_2.183 = s32[] parameter(2)
  ROOT select.184 = s32[] select(Arg_0.181, Arg_1.182, Arg_2.183)
}

remainder.185 {
  Arg_0.186 = s32[32]{0} parameter(0)
  Arg_1.187 = s32[] parameter(1)
  constant.191 = s32[] constant(0)
  compare.192 = pred[] compare(Arg_1.187, constant.191), direction=EQ
  constant.190 = s32[] constant(1)
  call.193 = s32[] call(compare.192, constant.190, Arg_1.187), to_apply=_where.180
  broadcast.194 = s32[32]{0} broadcast(call.193), dimensions={}
  remainder.195 = s32[32]{0} remainder(Arg_0.186, broadcast.194)
  constant.188 = s32[] constant(0)
  broadcast.189 = s32[32]{0} broadcast(constant.188), dimensions={}
  compare.197 = pred[32]{0} compare(remainder.195, broadcast.189), direction=LT
  compare.198 = pred[] compare(call.193, constant.191), direction=LT
  broadcast.199 = pred[32]{0} broadcast(compare.198), dimensions={}
  compare.200 = pred[32]{0} compare(compare.197, broadcast.199), direction=NE
  compare.196 = pred[32]{0} compare(remainder.195, broadcast.189), direction=NE
  and.201 = pred[32]{0} and(compare.200, compare.196)
  broadcast.202 = s32[32]{0} broadcast(call.193), dimensions={}
  add.203 = s32[32]{0} add(remainder.195, broadcast.202)
  ROOT select.204 = s32[32]{0} select(and.201, add.203, remainder.195)
}

_where_0.205 {
  Arg_0.206 = pred[32]{0} parameter(0)
  Arg_1.207 = s32[32]{0} parameter(1)
  Arg_2.208 = s32[32]{0} parameter(2)
  ROOT select.209 = s32[32]{0} select(Arg_0.206, Arg_1.207, Arg_2.208)
}

region_1.210 {
  Arg_0.211 = pred[] parameter(0)
  Arg_1.212 = pred[] parameter(1)
  ROOT and.213 = pred[] and(Arg_0.211, Arg_1.212)
}

_take_1.214 {
  Arg_1.216 = s32[32]{0} parameter(1)
  constant.226 = s32[] constant(0)
  broadcast.227 = s32[32]{0} broadcast(constant.226), dimensions={}
  compare.228 = pred[32]{0} compare(Arg_1.216, broadcast.227), direction=LT
  constant.223 = s32[] constant(32)
  broadcast.224 = s32[32]{0} broadcast(constant.223), dimensions={}
  add.229 = s32[32]{0} add(Arg_1.216, broadcast.224)
  call.230 = s32[32]{0} call(compare.228, add.229, Arg_1.216), to_apply=_where_0.205
  reshape.231 = s32[32,1]{1,0} reshape(call.230)
  constant.221 = s32[] constant(0)
  broadcast.222 = s32[32,1]{1,0} broadcast(constant.221), dimensions={}
  compare.232 = pred[32,1]{1,0} compare(reshape.231, broadcast.222), direction=GE
  constant.219 = s32[] constant(31)
  broadcast.220 = s32[32,1]{1,0} broadcast(constant.219), dimensions={}
  compare.233 = pred[32,1]{1,0} compare(reshape.231, broadcast.220), direction=LE
  and.234 = pred[32,1]{1,0} and(compare.232, compare.233)
  constant.225 = pred[] constant(true)
  reduce.235 = pred[32]{0} reduce(and.234, constant.225), dimensions={1}, to_apply=region_1.210
  broadcast.237 = pred[32,32,32]{2,1,0} broadcast(reduce.235), dimensions={1}
  Arg_0.215 = f32[32,32,32]{2,1,0} parameter(0)
  gather.236 = f32[32,32,32]{2,1,0} gather(Arg_0.215, reshape.231), offset_dims={0,2}, collapsed_slice_dims={1}, start_index_map={1}, index_vector_dim=1, slice_sizes={32,1,32}
  constant.217 = f32[] constant(nan)
  broadcast.218 = f32[32,32,32]{2,1,0} broadcast(constant.217), dimensions={}
  ROOT select.238 = f32[32,32,32]{2,1,0} select(broadcast.237, gather.236, broadcast.218)
}

_where.239 {
  Arg_0.240 = pred[] parameter(0)
  Arg_1.241 = s32[] parameter(1)
  Arg_2.242 = s32[] parameter(2)
  ROOT select.243 = s32[] select(Arg_0.240, Arg_1.241, Arg_2.242)
}

remainder.244 {
  Arg_0.245 = s32[32]{0} parameter(0)
  Arg_1.246 = s32[] parameter(1)
  constant.250 = s32[] constant(0)
  compare.251 = pred[] compare(Arg_1.246, constant.250), direction=EQ
  constant.249 = s32[] constant(1)
  call.252 = s32[] call(compare.251, constant.249, Arg_1.246), to_apply=_where.239
  broadcast.253 = s32[32]{0} broadcast(call.252), dimensions={}
  remainder.254 = s32[32]{0} remainder(Arg_0.245, broadcast.253)
  constant.247 = s32[] constant(0)
  broadcast.248 = s32[32]{0} broadcast(constant.247), dimensions={}
  compare.256 = pred[32]{0} compare(remainder.254, broadcast.248), direction=LT
  compare.257 = pred[] compare(call.252, constant.250), direction=LT
  broadcast.258 = pred[32]{0} broadcast(compare.257), dimensions={}
  compare.259 = pred[32]{0} compare(compare.256, broadcast.258), direction=NE
  compare.255 = pred[32]{0} compare(remainder.254, broadcast.248), direction=NE
  and.260 = pred[32]{0} and(compare.259, compare.255)
  broadcast.261 = s32[32]{0} broadcast(call.252), dimensions={}
  add.262 = s32[32]{0} add(remainder.254, broadcast.261)
  ROOT select.263 = s32[32]{0} select(and.260, add.262, remainder.254)
}

_where_0.264 {
  Arg_0.265 = pred[32]{0} parameter(0)
  Arg_1.266 = s32[32]{0} parameter(1)
  Arg_2.267 = s32[32]{0} parameter(2)
  ROOT select.268 = s32[32]{0} select(Arg_0.265, Arg_1.266, Arg_2.267)
}

region_2.269 {
  Arg_0.270 = pred[] parameter(0)
  Arg_1.271 = pred[] parameter(1)
  ROOT and.272 = pred[] and(Arg_0.270, Arg_1.271)
}

_take_2.273 {
  Arg_1.275 = s32[32]{0} parameter(1)
  constant.285 = s32[] constant(0)
  broadcast.286 = s32[32]{0} broadcast(constant.285), dimensions={}
  compare.287 = pred[32]{0} compare(Arg_1.275, broadcast.286), direction=LT
  constant.282 = s32[] constant(32)
  broadcast.283 = s32[32]{0} broadcast(constant.282), dimensions={}
  add.288 = s32[32]{0} add(Arg_1.275, broadcast.283)
  call.289 = s32[32]{0} call(compare.287, add.288, Arg_1.275), to_apply=_where_0.264
  reshape.290 = s32[32,1]{1,0} reshape(call.289)
  constant.280 = s32[] constant(0)
  broadcast.281 = s32[32,1]{1,0} broadcast(constant.280), dimensions={}
  compare.291 = pred[32,1]{1,0} compare(reshape.290, broadcast.281), direction=GE
  constant.278 = s32[] constant(31)
  broadcast.279 = s32[32,1]{1,0} broadcast(constant.278), dimensions={}
  compare.292 = pred[32,1]{1,0} compare(reshape.290, broadcast.279), direction=LE
  and.293 = pred[32,1]{1,0} and(compare.291, compare.292)
  constant.284 = pred[] constant(true)
  reduce.294 = pred[32]{0} reduce(and.293, constant.284), dimensions={1}, to_apply=region_2.269
  broadcast.296 = pred[32,32,32]{2,1,0} broadcast(reduce.294), dimensions={2}
  Arg_0.274 = f32[32,32,32]{2,1,0} parameter(0)
  gather.295 = f32[32,32,32]{2,1,0} gather(Arg_0.274, reshape.290), offset_dims={0,1}, collapsed_slice_dims={2}, start_index_map={2}, index_vector_dim=1, slice_sizes={32,32,1}
  constant.276 = f32[] constant(nan)
  broadcast.277 = f32[32,32,32]{2,1,0} broadcast(constant.276), dimensions={}
  ROOT select.297 = f32[32,32,32]{2,1,0} select(broadcast.296, gather.295, broadcast.277)
}

_where.298 {
  Arg_0.299 = pred[] parameter(0)
  Arg_1.300 = s32[] parameter(1)
  Arg_2.301 = s32[] parameter(2)
  ROOT select.302 = s32[] select(Arg_0.299, Arg_1.300, Arg_2.301)
}

remainder.303 {
  Arg_0.304 = s32[32]{0} parameter(0)
  Arg_1.305 = s32[] parameter(1)
  constant.309 = s32[] constant(0)
  compare.310 = pred[] compare(Arg_1.305, constant.309), direction=EQ
  constant.308 = s32[] constant(1)
  call.311 = s32[] call(compare.310, constant.308, Arg_1.305), to_apply=_where.298
  broadcast.312 = s32[32]{0} broadcast(call.311), dimensions={}
  remainder.313 = s32[32]{0} remainder(Arg_0.304, broadcast.312)
  constant.306 = s32[] constant(0)
  broadcast.307 = s32[32]{0} broadcast(constant.306), dimensions={}
  compare.315 = pred[32]{0} compare(remainder.313, broadcast.307), direction=LT
  compare.316 = pred[] compare(call.311, constant.309), direction=LT
  broadcast.317 = pred[32]{0} broadcast(compare.316), dimensions={}
  compare.318 = pred[32]{0} compare(compare.315, broadcast.317), direction=NE
  compare.314 = pred[32]{0} compare(remainder.313, broadcast.307), direction=NE
  and.319 = pred[32]{0} and(compare.318, compare.314)
  broadcast.320 = s32[32]{0} broadcast(call.311), dimensions={}
  add.321 = s32[32]{0} add(remainder.313, broadcast.320)
  ROOT select.322 = s32[32]{0} select(and.319, add.321, remainder.313)
}

_where_0.323 {
  Arg_0.324 = pred[32]{0} parameter(0)
  Arg_1.325 = s32[32]{0} parameter(1)
  Arg_2.326 = s32[32]{0} parameter(2)
  ROOT select.327 = s32[32]{0} select(Arg_0.324, Arg_1.325, Arg_2.326)
}

region_2.328 {
  Arg_0.329 = pred[] parameter(0)
  Arg_1.330 = pred[] parameter(1)
  ROOT and.331 = pred[] and(Arg_0.329, Arg_1.330)
}

_take_2.332 {
  Arg_1.334 = s32[32]{0} parameter(1)
  constant.344 = s32[] constant(0)
  broadcast.345 = s32[32]{0} broadcast(constant.344), dimensions={}
  compare.346 = pred[32]{0} compare(Arg_1.334, broadcast.345), direction=LT
  constant.341 = s32[] constant(32)
  broadcast.342 = s32[32]{0} broadcast(constant.341), dimensions={}
  add.347 = s32[32]{0} add(Arg_1.334, broadcast.342)
  call.348 = s32[32]{0} call(compare.346, add.347, Arg_1.334), to_apply=_where_0.323
  reshape.349 = s32[32,1]{1,0} reshape(call.348)
  constant.339 = s32[] constant(0)
  broadcast.340 = s32[32,1]{1,0} broadcast(constant.339), dimensions={}
  compare.350 = pred[32,1]{1,0} compare(reshape.349, broadcast.340), direction=GE
  constant.337 = s32[] constant(31)
  broadcast.338 = s32[32,1]{1,0} broadcast(constant.337), dimensions={}
  compare.351 = pred[32,1]{1,0} compare(reshape.349, broadcast.338), direction=LE
  and.352 = pred[32,1]{1,0} and(compare.350, compare.351)
  constant.343 = pred[] constant(true)
  reduce.353 = pred[32]{0} reduce(and.352, constant.343), dimensions={1}, to_apply=region_2.328
  broadcast.355 = pred[32,32,32]{2,1,0} broadcast(reduce.353), dimensions={2}
  Arg_0.333 = f32[32,32,32]{2,1,0} parameter(0)
  gather.354 = f32[32,32,32]{2,1,0} gather(Arg_0.333, reshape.349), offset_dims={0,1}, collapsed_slice_dims={2}, start_index_map={2}, index_vector_dim=1, slice_sizes={32,32,1}
  constant.335 = f32[] constant(nan)
  broadcast.336 = f32[32,32,32]{2,1,0} broadcast(constant.335), dimensions={}
  ROOT select.356 = f32[32,32,32]{2,1,0} select(broadcast.355, gather.354, broadcast.336)
}

heat_step.357 {
  Arg_0.358 = f32[32,32,32]{2,1,0} parameter(0)
  Arg_1.359 = f32[] parameter(1)
  broadcast.396 = f32[32,32,32]{2,1,0} broadcast(Arg_1.359), dimensions={}
  iota.365 = s32[32]{0} iota(), iota_dimension=0
  constant.362 = s32[] constant(1)
  broadcast.363 = s32[32]{0} broadcast(constant.362), dimensions={}
  add.366 = s32[32]{0} add(iota.365, broadcast.363)
  constant.364 = s32[] constant(32)
  call.367 = s32[32]{0} call(add.366, constant.364), to_apply=remainder.8
  call.368 = f32[32,32,32]{2,1,0} call(Arg_0.358, call.367), to_apply=_take.37
  iota.369 = s32[32]{0} iota(), iota_dimension=0
  subtract.370 = s32[32]{0} subtract(iota.369, broadcast.363)
  call.371 = s32[32]{0} call(subtract.370, constant.364), to_apply=remainder.67
  call.372 = f32[32,32,32]{2,1,0} call(Arg_0.358, call.371), to_apply=_take.96
  add.389 = f32[32,32,32]{2,1,0} add(call.368, call.372)
  iota.373 = s32[32]{0} iota(), iota_dimension=0
  add.374 = s32[32]{0} add(iota.373, broadcast.363)
  call.375 = s32[32]{0} call(add.374, constant.364), to_apply=remainder.126
  call.376 = f32[32,32,32]{2,1,0} call(Arg_0.358, call.375), to_apply=_take_1.155
  add.390 = f32[32,32,32]{2,1,0} add(add.389, call.376)
  iota.377 = s32[32]{0} iota(), iota_dimension=0
  subtract.378 = s32[32]{0} subtract(iota.377, broadcast.363)
  call.379 = s32[32]{0} call(subtract.378, constant.364), to_apply=remainder.185
  call.380 = f32[32,32,32]{2,1,0} call(Arg_0.358, call.379), to_apply=_take_1.214
  add.391 = f32[32,32,32]{2,1,0} add(add.390, call.380)
  iota.381 = s32[32]{0} iota(), iota_dimension=0
  add.382 = s32[32]{0} add(iota.381, broadcast.363)
  call.383 = s32[32]{0} call(add.382, constant.364), to_apply=remainder.244
  call.384 = f32[32,32,32]{2,1,0} call(Arg_0.358, call.383), to_apply=_take_2.273
  add.392 = f32[32,32,32]{2,1,0} add(add.391, call.384)
  iota.385 = s32[32]{0} iota(), iota_dimension=0
  subtract.386 = s32[32]{0} subtract(iota.385, broadcast.363)
  call.387 = s32[32]{0} call(subtract.386, constant.364), to_apply=remainder.303
  call.388 = f32[32,32,32]{2,1,0} call(Arg_0.358, call.387), to_apply=_take_2.332
  add.393 = f32[32,32,32]{2,1,0} add(add.392, call.388)
  constant.360 = f32[] constant(6)
  broadcast.361 = f32[32,32,32]{2,1,0} broadcast(constant.360), dimensions={}
  multiply.394 = f32[32,32,32]{2,1,0} multiply(Arg_0.358, broadcast.361)
  subtract.395 = f32[32,32,32]{2,1,0} subtract(add.393, multiply.394)
  multiply.397 = f32[32,32,32]{2,1,0} multiply(broadcast.396, subtract.395)
  ROOT add.398 = f32[32,32,32]{2,1,0} add(Arg_0.358, multiply.397)
}

ENTRY main.400 {
  Arg_0.1 = f32[32,32,32]{2,1,0} parameter(0)
  Arg_1.2 = f32[] parameter(1)
  ROOT call.399 = f32[32,32,32]{2,1,0} call(Arg_0.1, Arg_1.2), to_apply=heat_step.357
}

