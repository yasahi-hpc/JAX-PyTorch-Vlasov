HloModule jit_run_chunk, entry_computation_layout={(f64[128]{0}, f64[128]{0}, f64[65]{0}, s32[6]{0}, f64[128]{0}, /*index=5*/f64[128]{0}, f64[128,128]{1,0}, f64[128]{0}, f64[], s64[])->(f64[128]{0}, f64[128]{0}, f64[65]{0}, s32[6]{0}, f64[128]{0}, /*index=5*/f64[128]{0}, f64[128,128]{1,0}, f64[128]{0}, f64[], s64[])}

_roll_static.15 {
  Arg_0.16 = f64[128,14]{1,0} parameter(0)
  slice.17 = f64[126,14]{1,0} slice(Arg_0.16), slice={[2:128], [0:14]}
  slice.18 = f64[2,14]{1,0} slice(Arg_0.16), slice={[0:2], [0:14]}
  ROOT concatenate.19 = f64[128,14]{1,0} concatenate(slice.17, slice.18), dimensions={0}
}

_roll_static_0.20 {
  Arg_0.21 = f64[128,50]{1,0} parameter(0)
  slice.22 = f64[127,50]{1,0} slice(Arg_0.21), slice={[1:128], [0:50]}
  slice.23 = f64[1,50]{1,0} slice(Arg_0.21), slice={[0:1], [0:50]}
  ROOT concatenate.24 = f64[128,50]{1,0} concatenate(slice.22, slice.23), dimensions={0}
}

_roll_static_1.25 {
  ROOT Arg_0.26 = f64[128,50]{1,0} parameter(0)
}

_roll_static_2.27 {
  Arg_0.28 = f64[128,14]{1,0} parameter(0)
  slice.29 = f64[1,14]{1,0} slice(Arg_0.28), slice={[127:128], [0:14]}
  slice.30 = f64[127,14]{1,0} slice(Arg_0.28), slice={[0:127], [0:14]}
  ROOT concatenate.31 = f64[128,14]{1,0} concatenate(slice.29, slice.30), dimensions={0}
}

_roll_static_3.32 {
  Arg_0.33 = f64[128,128]{1,0} parameter(0)
  slice.34 = f64[126,128]{1,0} slice(Arg_0.33), slice={[2:128], [0:128]}
  slice.35 = f64[2,128]{1,0} slice(Arg_0.33), slice={[0:2], [0:128]}
  ROOT concatenate.36 = f64[128,128]{1,0} concatenate(slice.34, slice.35), dimensions={0}
}

_roll_static_4.37 {
  Arg_0.38 = f64[128,128]{1,0} parameter(0)
  slice.39 = f64[127,128]{1,0} slice(Arg_0.38), slice={[1:128], [0:128]}
  slice.40 = f64[1,128]{1,0} slice(Arg_0.38), slice={[0:1], [0:128]}
  ROOT concatenate.41 = f64[128,128]{1,0} concatenate(slice.39, slice.40), dimensions={0}
}

_roll_static_5.42 {
  ROOT Arg_0.43 = f64[128,128]{1,0} parameter(0)
}

_roll_static_6.44 {
  Arg_0.45 = f64[128,128]{1,0} parameter(0)
  slice.46 = f64[1,128]{1,0} slice(Arg_0.45), slice={[127:128], [0:128]}
  slice.47 = f64[127,128]{1,0} slice(Arg_0.45), slice={[0:127], [0:128]}
  ROOT concatenate.48 = f64[128,128]{1,0} concatenate(slice.46, slice.47), dimensions={0}
}

_roll_static_7.49 {
  Arg_0.50 = f64[128,128]{1,0} parameter(0)
  slice.51 = f64[2,128]{1,0} slice(Arg_0.50), slice={[126:128], [0:128]}
  slice.52 = f64[126,128]{1,0} slice(Arg_0.50), slice={[0:126], [0:128]}
  ROOT concatenate.53 = f64[128,128]{1,0} concatenate(slice.51, slice.52), dimensions={0}
}

_roll_static_8.54 {
  Arg_0.55 = f64[128,128]{1,0} parameter(0)
  slice.56 = f64[3,128]{1,0} slice(Arg_0.55), slice={[125:128], [0:128]}
  slice.57 = f64[125,128]{1,0} slice(Arg_0.55), slice={[0:125], [0:128]}
  ROOT concatenate.58 = f64[128,128]{1,0} concatenate(slice.56, slice.57), dimensions={0}
}

region_1.59 {
  Arg_0.60 = f64[] parameter(0)
  Arg_1.61 = f64[] parameter(1)
  ROOT add.62 = f64[] add(Arg_0.60, Arg_1.61)
}

fft.63 {
  Arg_0.64 = f64[128]{0} parameter(0)
  ROOT fft.65 = c128[65]{0} fft(Arg_0.64), fft_type=RFFT, fft_length={128}
}

fft_9.66 {
  Arg_0.67 = c128[65]{0} parameter(0)
  ROOT fft.68 = f64[128]{0} fft(Arg_0.67), fft_type=IRFFT, fft_length={128}
}

fft_9.69 {
  Arg_0.70 = c128[65]{0} parameter(0)
  ROOT fft.71 = f64[128]{0} fft(Arg_0.70), fft_type=IRFFT, fft_length={128}
}

solve_poisson.72 {
  Arg_0.73 = f64[128,128]{1,0} parameter(0)
  constant.80 = f64[] constant(0)
  reduce.81 = f64[128]{0} reduce(Arg_0.73, constant.80), dimensions={1}, to_apply=region_1.59
  Arg_2.75 = f64[] parameter(2)
  broadcast.82 = f64[128]{0} broadcast(Arg_2.75), dimensions={}
  multiply.83 = f64[128]{0} multiply(reduce.81, broadcast.82)
  constant.78 = f64[] constant(1)
  broadcast.79 = f64[128]{0} broadcast(constant.78), dimensions={}
  subtract.84 = f64[128]{0} subtract(multiply.83, broadcast.79)
  call.85 = c128[65]{0} call(subtract.84), to_apply=fft.63
  constant.76 = c128[] constant((-0, -1))
  broadcast.77 = c128[65]{0} broadcast(constant.76), dimensions={}
  multiply.86 = c128[65]{0} multiply(call.85, broadcast.77)
  Arg_1.74 = f64[65]{0} parameter(1)
  convert.87 = c128[65]{0} convert(Arg_1.74)
  multiply.88 = c128[65]{0} multiply(multiply.86, convert.87)
  call.89 = f64[128]{0} call(multiply.88), to_apply=fft_9.66
  multiply.90 = f64[65]{0} multiply(Arg_1.74, Arg_1.74)
  convert.91 = c128[65]{0} convert(multiply.90)
  multiply.92 = c128[65]{0} multiply(call.85, convert.91)
  call.93 = f64[128]{0} call(multiply.92), to_apply=fft_9.69
  ROOT tuple.94 = (f64[128]{0}, f64[128]{0}, f64[128]{0}) tuple(call.89, subtract.84, call.93)
}

_where.95 {
  Arg_0.96 = pred[128]{0} parameter(0)
  Arg_1.97 = f64[128]{0} parameter(1)
  Arg_2.98 = f64[] parameter(2)
  broadcast.99 = f64[128]{0} broadcast(Arg_2.98), dimensions={}
  ROOT select.100 = f64[128]{0} select(Arg_0.96, Arg_1.97, broadcast.99)
}

_where.101 {
  Arg_0.102 = pred[128]{0} parameter(0)
  Arg_1.103 = f64[128]{0} parameter(1)
  Arg_2.104 = f64[] parameter(2)
  broadcast.105 = f64[128]{0} broadcast(Arg_2.104), dimensions={}
  ROOT select.106 = f64[128]{0} select(Arg_0.102, Arg_1.103, broadcast.105)
}

_where.107 {
  Arg_0.108 = pred[128]{0} parameter(0)
  Arg_1.109 = f64[128]{0} parameter(1)
  Arg_2.110 = f64[] parameter(2)
  broadcast.111 = f64[128]{0} broadcast(Arg_2.110), dimensions={}
  ROOT select.112 = f64[128]{0} select(Arg_0.108, Arg_1.109, broadcast.111)
}

_where.113 {
  Arg_0.114 = pred[128]{0} parameter(0)
  Arg_1.115 = f64[128]{0} parameter(1)
  Arg_2.116 = f64[] parameter(2)
  broadcast.117 = f64[128]{0} broadcast(Arg_2.116), dimensions={}
  ROOT select.118 = f64[128]{0} select(Arg_0.114, Arg_1.115, broadcast.117)
}

_where.119 {
  Arg_0.120 = pred[128]{0} parameter(0)
  Arg_1.121 = f64[128]{0} parameter(1)
  Arg_2.122 = f64[] parameter(2)
  broadcast.123 = f64[128]{0} broadcast(Arg_2.122), dimensions={}
  ROOT select.124 = f64[128]{0} select(Arg_0.120, Arg_1.121, broadcast.123)
}

_where.125 {
  Arg_0.126 = pred[128]{0} parameter(0)
  Arg_1.127 = f64[128]{0} parameter(1)
  Arg_2.128 = f64[] parameter(2)
  broadcast.129 = f64[128]{0} broadcast(Arg_2.128), dimensions={}
  ROOT select.130 = f64[128]{0} select(Arg_0.126, Arg_1.127, broadcast.129)
}

_where.131 {
  Arg_0.132 = pred[128]{0} parameter(0)
  Arg_1.133 = f64[128]{0} parameter(1)
  Arg_2.134 = f64[] parameter(2)
  broadcast.135 = f64[128]{0} broadcast(Arg_2.134), dimensions={}
  ROOT select.136 = f64[128]{0} select(Arg_0.132, Arg_1.133, broadcast.135)
}

_where.137 {
  Arg_0.138 = pred[128]{0} parameter(0)
  Arg_1.139 = f64[128]{0} parameter(1)
  Arg_2.140 = f64[] parameter(2)
  broadcast.141 = f64[128]{0} broadcast(Arg_2.140), dimensions={}
  ROOT select.142 = f64[128]{0} select(Arg_0.138, Arg_1.139, broadcast.141)
}

_where.143 {
  Arg_0.144 = pred[128]{0} parameter(0)
  Arg_1.145 = f64[128]{0} parameter(1)
  Arg_2.146 = f64[] parameter(2)
  broadcast.147 = f64[128]{0} broadcast(Arg_2.146), dimensions={}
  ROOT select.148 = f64[128]{0} select(Arg_0.144, Arg_1.145, broadcast.147)
}

_where.149 {
  Arg_0.150 = pred[128]{0} parameter(0)
  Arg_1.151 = f64[128]{0} parameter(1)
  Arg_2.152 = f64[] parameter(2)
  broadcast.153 = f64[128]{0} broadcast(Arg_2.152), dimensions={}
  ROOT select.154 = f64[128]{0} select(Arg_0.150, Arg_1.151, broadcast.153)
}

_where.155 {
  Arg_0.156 = pred[128]{0} parameter(0)
  Arg_1.157 = f64[128]{0} parameter(1)
  Arg_2.158 = f64[] parameter(2)
  broadcast.159 = f64[128]{0} broadcast(Arg_2.158), dimensions={}
  ROOT select.160 = f64[128]{0} select(Arg_0.156, Arg_1.157, broadcast.159)
}

_where.161 {
  Arg_0.162 = pred[128]{0} parameter(0)
  Arg_1.163 = f64[128]{0} parameter(1)
  Arg_2.164 = f64[] parameter(2)
  broadcast.165 = f64[128]{0} broadcast(Arg_2.164), dimensions={}
  ROOT select.166 = f64[128]{0} select(Arg_0.162, Arg_1.163, broadcast.165)
}

_where.167 {
  Arg_0.168 = pred[128]{0} parameter(0)
  Arg_1.169 = f64[128]{0} parameter(1)
  Arg_2.170 = f64[] parameter(2)
  broadcast.171 = f64[128]{0} broadcast(Arg_2.170), dimensions={}
  ROOT select.172 = f64[128]{0} select(Arg_0.168, Arg_1.169, broadcast.171)
}

_where.173 {
  Arg_0.174 = pred[128]{0} parameter(0)
  Arg_1.175 = f64[128]{0} parameter(1)
  Arg_2.176 = f64[] parameter(2)
  broadcast.177 = f64[128]{0} broadcast(Arg_2.176), dimensions={}
  ROOT select.178 = f64[128]{0} select(Arg_0.174, Arg_1.175, broadcast.177)
}

_where.179 {
  Arg_0.180 = pred[128]{0} parameter(0)
  Arg_1.181 = f64[128]{0} parameter(1)
  Arg_2.182 = f64[] parameter(2)
  broadcast.183 = f64[128]{0} broadcast(Arg_2.182), dimensions={}
  ROOT select.184 = f64[128]{0} select(Arg_0.180, Arg_1.181, broadcast.183)
}

_where.185 {
  Arg_0.186 = pred[128]{0} parameter(0)
  Arg_1.187 = f64[128]{0} parameter(1)
  Arg_2.188 = f64[] parameter(2)
  broadcast.189 = f64[128]{0} broadcast(Arg_2.188), dimensions={}
  ROOT select.190 = f64[128]{0} select(Arg_0.186, Arg_1.187, broadcast.189)
}

_where.191 {
  Arg_0.192 = pred[128]{0} parameter(0)
  Arg_1.193 = f64[128]{0} parameter(1)
  Arg_2.194 = f64[] parameter(2)
  broadcast.195 = f64[128]{0} broadcast(Arg_2.194), dimensions={}
  ROOT select.196 = f64[128]{0} select(Arg_0.192, Arg_1.193, broadcast.195)
}

_where.197 {
  Arg_0.198 = pred[128]{0} parameter(0)
  Arg_1.199 = f64[128]{0} parameter(1)
  Arg_2.200 = f64[] parameter(2)
  broadcast.201 = f64[128]{0} broadcast(Arg_2.200), dimensions={}
  ROOT select.202 = f64[128]{0} select(Arg_0.198, Arg_1.199, broadcast.201)
}

_where.203 {
  Arg_0.204 = pred[128]{0} parameter(0)
  Arg_1.205 = f64[128]{0} parameter(1)
  Arg_2.206 = f64[] parameter(2)
  broadcast.207 = f64[128]{0} broadcast(Arg_2.206), dimensions={}
  ROOT select.208 = f64[128]{0} select(Arg_0.204, Arg_1.205, broadcast.207)
}

_where.209 {
  Arg_0.210 = pred[128]{0} parameter(0)
  Arg_1.211 = f64[128]{0} parameter(1)
  Arg_2.212 = f64[] parameter(2)
  broadcast.213 = f64[128]{0} broadcast(Arg_2.212), dimensions={}
  ROOT select.214 = f64[128]{0} select(Arg_0.210, Arg_1.211, broadcast.213)
}

_where.215 {
  Arg_0.216 = pred[128]{0} parameter(0)
  Arg_1.217 = f64[128]{0} parameter(1)
  Arg_2.218 = f64[] parameter(2)
  broadcast.219 = f64[128]{0} broadcast(Arg_2.218), dimensions={}
  ROOT select.220 = f64[128]{0} select(Arg_0.216, Arg_1.217, broadcast.219)
}

_where.221 {
  Arg_0.222 = pred[128]{0} parameter(0)
  Arg_1.223 = f64[128]{0} parameter(1)
  Arg_2.224 = f64[] parameter(2)
  broadcast.225 = f64[128]{0} broadcast(Arg_2.224), dimensions={}
  ROOT select.226 = f64[128]{0} select(Arg_0.222, Arg_1.223, broadcast.225)
}

_where.227 {
  Arg_0.228 = pred[128]{0} parameter(0)
  Arg_1.229 = f64[128]{0} parameter(1)
  Arg_2.230 = f64[] parameter(2)
  broadcast.231 = f64[128]{0} broadcast(Arg_2.230), dimensions={}
  ROOT select.232 = f64[128]{0} select(Arg_0.228, Arg_1.229, broadcast.231)
}

_where.233 {
  Arg_0.234 = pred[128]{0} parameter(0)
  Arg_1.235 = f64[128]{0} parameter(1)
  Arg_2.236 = f64[] parameter(2)
  broadcast.237 = f64[128]{0} broadcast(Arg_2.236), dimensions={}
  ROOT select.238 = f64[128]{0} select(Arg_0.234, Arg_1.235, broadcast.237)
}

_where.239 {
  Arg_0.240 = pred[128]{0} parameter(0)
  Arg_1.241 = f64[128]{0} parameter(1)
  Arg_2.242 = f64[] parameter(2)
  broadcast.243 = f64[128]{0} broadcast(Arg_2.242), dimensions={}
  ROOT select.244 = f64[128]{0} select(Arg_0.240, Arg_1.241, broadcast.243)
}

_where.245 {
  Arg_0.246 = pred[128]{0} parameter(0)
  Arg_1.247 = f64[128]{0} parameter(1)
  Arg_2.248 = f64[] parameter(2)
  broadcast.249 = f64[128]{0} broadcast(Arg_2.248), dimensions={}
  ROOT select.250 = f64[128]{0} select(Arg_0.246, Arg_1.247, broadcast.249)
}

_where.251 {
  Arg_0.252 = pred[128]{0} parameter(0)
  Arg_1.253 = f64[128]{0} parameter(1)
  Arg_2.254 = f64[] parameter(2)
  broadcast.255 = f64[128]{0} broadcast(Arg_2.254), dimensions={}
  ROOT select.256 = f64[128]{0} select(Arg_0.252, Arg_1.253, broadcast.255)
}

_where.257 {
  Arg_0.258 = pred[128]{0} parameter(0)
  Arg_1.259 = f64[128]{0} parameter(1)
  Arg_2.260 = f64[] parameter(2)
  broadcast.261 = f64[128]{0} broadcast(Arg_2.260), dimensions={}
  ROOT select.262 = f64[128]{0} select(Arg_0.258, Arg_1.259, broadcast.261)
}

_where.263 {
  Arg_0.264 = pred[128]{0} parameter(0)
  Arg_1.265 = f64[128]{0} parameter(1)
  Arg_2.266 = f64[] parameter(2)
  broadcast.267 = f64[128]{0} broadcast(Arg_2.266), dimensions={}
  ROOT select.268 = f64[128]{0} select(Arg_0.264, Arg_1.265, broadcast.267)
}

_where.269 {
  Arg_0.270 = pred[128]{0} parameter(0)
  Arg_1.271 = f64[128]{0} parameter(1)
  Arg_2.272 = f64[] parameter(2)
  broadcast.273 = f64[128]{0} broadcast(Arg_2.272), dimensions={}
  ROOT select.274 = f64[128]{0} select(Arg_0.270, Arg_1.271, broadcast.273)
}

_where.275 {
  Arg_0.276 = pred[128]{0} parameter(0)
  Arg_1.277 = f64[128]{0} parameter(1)
  Arg_2.278 = f64[] parameter(2)
  broadcast.279 = f64[128]{0} broadcast(Arg_2.278), dimensions={}
  ROOT select.280 = f64[128]{0} select(Arg_0.276, Arg_1.277, broadcast.279)
}

_where.281 {
  Arg_0.282 = pred[128]{0} parameter(0)
  Arg_1.283 = f64[128]{0} parameter(1)
  Arg_2.284 = f64[] parameter(2)
  broadcast.285 = f64[128]{0} broadcast(Arg_2.284), dimensions={}
  ROOT select.286 = f64[128]{0} select(Arg_0.282, Arg_1.283, broadcast.285)
}

_where.287 {
  Arg_0.288 = pred[128]{0} parameter(0)
  Arg_1.289 = f64[128]{0} parameter(1)
  Arg_2.290 = f64[] parameter(2)
  broadcast.291 = f64[128]{0} broadcast(Arg_2.290), dimensions={}
  ROOT select.292 = f64[128]{0} select(Arg_0.288, Arg_1.289, broadcast.291)
}

_where.293 {
  Arg_0.294 = pred[128]{0} parameter(0)
  Arg_1.295 = f64[128]{0} parameter(1)
  Arg_2.296 = f64[] parameter(2)
  broadcast.297 = f64[128]{0} broadcast(Arg_2.296), dimensions={}
  ROOT select.298 = f64[128]{0} select(Arg_0.294, Arg_1.295, broadcast.297)
}

_where.299 {
  Arg_0.300 = pred[128]{0} parameter(0)
  Arg_1.301 = f64[128]{0} parameter(1)
  Arg_2.302 = f64[] parameter(2)
  broadcast.303 = f64[128]{0} broadcast(Arg_2.302), dimensions={}
  ROOT select.304 = f64[128]{0} select(Arg_0.300, Arg_1.301, broadcast.303)
}

_where.305 {
  Arg_0.306 = pred[128]{0} parameter(0)
  Arg_1.307 = f64[128]{0} parameter(1)
  Arg_2.308 = f64[] parameter(2)
  broadcast.309 = f64[128]{0} broadcast(Arg_2.308), dimensions={}
  ROOT select.310 = f64[128]{0} select(Arg_0.306, Arg_1.307, broadcast.309)
}

_where.311 {
  Arg_0.312 = pred[128]{0} parameter(0)
  Arg_1.313 = f64[128]{0} parameter(1)
  Arg_2.314 = f64[] parameter(2)
  broadcast.315 = f64[128]{0} broadcast(Arg_2.314), dimensions={}
  ROOT select.316 = f64[128]{0} select(Arg_0.312, Arg_1.313, broadcast.315)
}

_where.317 {
  Arg_0.318 = pred[128]{0} parameter(0)
  Arg_1.319 = f64[128]{0} parameter(1)
  Arg_2.320 = f64[] parameter(2)
  broadcast.321 = f64[128]{0} broadcast(Arg_2.320), dimensions={}
  ROOT select.322 = f64[128]{0} select(Arg_0.318, Arg_1.319, broadcast.321)
}

_where.323 {
  Arg_0.324 = pred[128]{0} parameter(0)
  Arg_1.325 = f64[128]{0} parameter(1)
  Arg_2.326 = f64[] parameter(2)
  broadcast.327 = f64[128]{0} broadcast(Arg_2.326), dimensions={}
  ROOT select.328 = f64[128]{0} select(Arg_0.324, Arg_1.325, broadcast.327)
}

_where.329 {
  Arg_0.330 = pred[128]{0} parameter(0)
  Arg_1.331 = f64[128]{0} parameter(1)
  Arg_2.332 = f64[] parameter(2)
  broadcast.333 = f64[128]{0} broadcast(Arg_2.332), dimensions={}
  ROOT select.334 = f64[128]{0} select(Arg_0.330, Arg_1.331, broadcast.333)
}

_where.335 {
  Arg_0.336 = pred[128]{0} parameter(0)
  Arg_1.337 = f64[128]{0} parameter(1)
  Arg_2.338 = f64[] parameter(2)
  broadcast.339 = f64[128]{0} broadcast(Arg_2.338), dimensions={}
  ROOT select.340 = f64[128]{0} select(Arg_0.336, Arg_1.337, broadcast.339)
}

_where.341 {
  Arg_0.342 = pred[128]{0} parameter(0)
  Arg_1.343 = f64[128]{0} parameter(1)
  Arg_2.344 = f64[] parameter(2)
  broadcast.345 = f64[128]{0} broadcast(Arg_2.344), dimensions={}
  ROOT select.346 = f64[128]{0} select(Arg_0.342, Arg_1.343, broadcast.345)
}

_pad.347 {
  Arg_0.348 = f64[128,128]{1,0} parameter(0)
  Arg_1.349 = s64[] parameter(1)
  convert.350 = f64[] convert(Arg_1.349)
  ROOT pad.351 = f64[128,134]{1,0} pad(Arg_0.348, convert.350), padding=0_0x3_3
}

_roll_static.352 {
  Arg_0.353 = f64[128,14]{1,0} parameter(0)
  slice.354 = f64[126,14]{1,0} slice(Arg_0.353), slice={[2:128], [0:14]}
  slice.355 = f64[2,14]{1,0} slice(Arg_0.353), slice={[0:2], [0:14]}
  ROOT concatenate.356 = f64[128,14]{1,0} concatenate(slice.354, slice.355), dimensions={0}
}

_roll_static_0.357 {
  Arg_0.358 = f64[128,50]{1,0} parameter(0)
  slice.359 = f64[127,50]{1,0} slice(Arg_0.358), slice={[1:128], [0:50]}
  slice.360 = f64[1,50]{1,0} slice(Arg_0.358), slice={[0:1], [0:50]}
  ROOT concatenate.361 = f64[128,50]{1,0} concatenate(slice.359, slice.360), dimensions={0}
}

_roll_static_1.362 {
  ROOT Arg_0.363 = f64[128,50]{1,0} parameter(0)
}

_roll_static_2.364 {
  Arg_0.365 = f64[128,14]{1,0} parameter(0)
  slice.366 = f64[1,14]{1,0} slice(Arg_0.365), slice={[127:128], [0:14]}
  slice.367 = f64[127,14]{1,0} slice(Arg_0.365), slice={[0:127], [0:14]}
  ROOT concatenate.368 = f64[128,14]{1,0} concatenate(slice.366, slice.367), dimensions={0}
}

_roll_static_3.369 {
  Arg_0.370 = f64[128,128]{1,0} parameter(0)
  slice.371 = f64[126,128]{1,0} slice(Arg_0.370), slice={[2:128], [0:128]}
  slice.372 = f64[2,128]{1,0} slice(Arg_0.370), slice={[0:2], [0:128]}
  ROOT concatenate.373 = f64[128,128]{1,0} concatenate(slice.371, slice.372), dimensions={0}
}

_roll_static_4.374 {
  Arg_0.375 = f64[128,128]{1,0} parameter(0)
  slice.376 = f64[127,128]{1,0} slice(Arg_0.375), slice={[1:128], [0:128]}
  slice.377 = f64[1,128]{1,0} slice(Arg_0.375), slice={[0:1], [0:128]}
  ROOT concatenate.378 = f64[128,128]{1,0} concatenate(slice.376, slice.377), dimensions={0}
}

_roll_static_5.379 {
  ROOT Arg_0.380 = f64[128,128]{1,0} parameter(0)
}

_roll_static_6.381 {
  Arg_0.382 = f64[128,128]{1,0} parameter(0)
  slice.383 = f64[1,128]{1,0} slice(Arg_0.382), slice={[127:128], [0:128]}
  slice.384 = f64[127,128]{1,0} slice(Arg_0.382), slice={[0:127], [0:128]}
  ROOT concatenate.385 = f64[128,128]{1,0} concatenate(slice.383, slice.384), dimensions={0}
}

_roll_static_7.386 {
  Arg_0.387 = f64[128,128]{1,0} parameter(0)
  slice.388 = f64[2,128]{1,0} slice(Arg_0.387), slice={[126:128], [0:128]}
  slice.389 = f64[126,128]{1,0} slice(Arg_0.387), slice={[0:126], [0:128]}
  ROOT concatenate.390 = f64[128,128]{1,0} concatenate(slice.388, slice.389), dimensions={0}
}

_roll_static_8.391 {
  Arg_0.392 = f64[128,128]{1,0} parameter(0)
  slice.393 = f64[3,128]{1,0} slice(Arg_0.392), slice={[125:128], [0:128]}
  slice.394 = f64[125,128]{1,0} slice(Arg_0.392), slice={[0:125], [0:128]}
  ROOT concatenate.395 = f64[128,128]{1,0} concatenate(slice.393, slice.394), dimensions={0}
}

None.396 {
  Arg_3.400 = f64[128]{0} parameter(3)
  Arg_4.401 = f64[128]{0} parameter(4)
  Arg_2.399 = f64[128,128]{1,0} parameter(2)
  slice.519 = f64[128,14]{1,0} slice(Arg_2.399), slice={[0:128], [0:14]}
  call.520 = f64[128,14]{1,0} call(slice.519), to_apply=_roll_static.15
  slice.521 = f64[128,50]{1,0} slice(Arg_2.399), slice={[0:128], [14:64]}
  call.522 = f64[128,50]{1,0} call(slice.521), to_apply=_roll_static_0.20
  slice.523 = f64[128,50]{1,0} slice(Arg_2.399), slice={[0:128], [64:114]}
  call.524 = f64[128,50]{1,0} call(slice.523), to_apply=_roll_static_1.25
  slice.525 = f64[128,14]{1,0} slice(Arg_2.399), slice={[0:128], [114:128]}
  call.526 = f64[128,14]{1,0} call(slice.525), to_apply=_roll_static_2.27
  concatenate.527 = f64[128,128]{1,0} concatenate(call.520, call.522, call.524, call.526), dimensions={1}
  call.528 = f64[128,128]{1,0} call(concatenate.527), to_apply=_roll_static_3.32
  Arg_0.397 = f64[128]{0} parameter(0)
  constant.452 = f64[] constant(20)
  broadcast.453 = f64[128]{0} broadcast(constant.452), dimensions={}
  divide.461 = f64[128]{0} divide(Arg_0.397, broadcast.453)
  multiply.457 = f64[128]{0} multiply(Arg_0.397, Arg_0.397)
  constant.450 = f64[] constant(24)
  broadcast.451 = f64[128]{0} broadcast(constant.450), dimensions={}
  divide.462 = f64[128]{0} divide(multiply.457, broadcast.451)
  subtract.463 = f64[128]{0} subtract(divide.461, divide.462)
  multiply.458 = f64[128]{0} multiply(multiply.457, Arg_0.397)
  divide.464 = f64[128]{0} divide(multiply.458, broadcast.451)
  subtract.465 = f64[128]{0} subtract(subtract.463, divide.464)
  multiply.459 = f64[128]{0} multiply(multiply.458, Arg_0.397)
  divide.466 = f64[128]{0} divide(multiply.459, broadcast.451)
  add.467 = f64[128]{0} add(subtract.465, divide.466)
  multiply.460 = f64[128]{0} multiply(multiply.459, Arg_0.397)
  constant.448 = f64[] constant(120)
  broadcast.449 = f64[128]{0} broadcast(constant.448), dimensions={}
  divide.468 = f64[128]{0} divide(multiply.460, broadcast.449)
  subtract.469 = f64[128]{0} subtract(add.467, divide.468)
  reshape.529 = f64[1,128]{1,0} reshape(subtract.469)
  broadcast.530 = f64[1,128]{1,0} broadcast(reshape.529), dimensions={0,1}
  reshape.531 = f64[128]{0} reshape(broadcast.530)
  broadcast.532 = f64[128,128]{1,0} broadcast(reshape.531), dimensions={1}
  multiply.533 = f64[128,128]{1,0} multiply(call.528, broadcast.532)
  call.534 = f64[128,128]{1,0} call(concatenate.527), to_apply=_roll_static_4.37
  constant.446 = f64[] constant(2)
  broadcast.447 = f64[128]{0} broadcast(constant.446), dimensions={}
  divide.470 = f64[128]{0} divide(Arg_0.397, broadcast.447)
  negate.471 = f64[128]{0} negate(divide.470)
  multiply.472 = f64[128]{0} multiply(multiply.457, broadcast.447)
  constant.444 = f64[] constant(3)
  broadcast.445 = f64[128]{0} broadcast(constant.444), dimensions={}
  divide.473 = f64[128]{0} divide(multiply.472, broadcast.445)
  add.474 = f64[128]{0} add(negate.471, divide.473)
  divide.475 = f64[128]{0} divide(multiply.458, broadcast.451)
  subtract.476 = f64[128]{0} subtract(add.474, divide.475)
  constant.442 = f64[] constant(6)
  broadcast.443 = f64[128]{0} broadcast(constant.442), dimensions={}
  divide.477 = f64[128]{0} divide(multiply.459, broadcast.443)
  subtract.478 = f64[128]{0} subtract(subtract.476, divide.477)
  divide.479 = f64[128]{0} divide(multiply.460, broadcast.451)
  add.480 = f64[128]{0} add(subtract.478, divide.479)
  reshape.535 = f64[1,128]{1,0} reshape(add.480)
  broadcast.536 = f64[1,128]{1,0} broadcast(reshape.535), dimensions={0,1}
  reshape.537 = f64[128]{0} reshape(broadcast.536)
  broadcast.538 = f64[128,128]{1,0} broadcast(reshape.537), dimensions={1}
  multiply.539 = f64[128,128]{1,0} multiply(call.534, broadcast.538)
  add.540 = f64[128,128]{1,0} add(multiply.533, multiply.539)
  call.541 = f64[128,128]{1,0} call(concatenate.527), to_apply=_roll_static_5.42
  constant.440 = f64[] constant(1)
  broadcast.441 = f64[128]{0} broadcast(constant.440), dimensions={}
  divide.481 = f64[128]{0} divide(Arg_0.397, broadcast.445)
  subtract.482 = f64[128]{0} subtract(broadcast.441, divide.481)
  constant.438 = f64[] constant(5)
  broadcast.439 = f64[128]{0} broadcast(constant.438), dimensions={}
  multiply.483 = f64[128]{0} multiply(multiply.457, broadcast.439)
  constant.436 = f64[] constant(4)
  broadcast.437 = f64[128]{0} broadcast(constant.436), dimensions={}
  divide.484 = f64[128]{0} divide(multiply.483, broadcast.437)
  subtract.485 = f64[128]{0} subtract(subtract.482, divide.484)
  multiply.486 = f64[128]{0} multiply(multiply.458, broadcast.439)
  constant.434 = f64[] constant(12)
  broadcast.435 = f64[128]{0} broadcast(constant.434), dimensions={}
  divide.487 = f64[128]{0} divide(multiply.486, broadcast.435)
  add.488 = f64[128]{0} add(subtract.485, divide.487)
  divide.489 = f64[128]{0} divide(multiply.459, broadcast.437)
  add.490 = f64[128]{0} add(add.488, divide.489)
  divide.491 = f64[128]{0} divide(multiply.460, broadcast.435)
  subtract.492 = f64[128]{0} subtract(add.490, divide.491)
  reshape.542 = f64[1,128]{1,0} reshape(subtract.492)
  broadcast.543 = f64[1,128]{1,0} broadcast(reshape.542), dimensions={0,1}
  reshape.544 = f64[128]{0} reshape(broadcast.543)
  broadcast.545 = f64[128,128]{1,0} broadcast(reshape.544), dimensions={1}
  multiply.546 = f64[128,128]{1,0} multiply(call.541, broadcast.545)
  add.547 = f64[128,128]{1,0} add(add.540, multiply.546)
  call.548 = f64[128,128]{1,0} call(concatenate.527), to_apply=_roll_static_6.44
  multiply.493 = f64[128]{0} multiply(multiply.457, broadcast.447)
  divide.494 = f64[128]{0} divide(multiply.493, broadcast.445)
  add.495 = f64[128]{0} add(Arg_0.397, divide.494)
  constant.432 = f64[] constant(7)
  broadcast.433 = f64[128]{0} broadcast(constant.432), dimensions={}
  multiply.496 = f64[128]{0} multiply(multiply.458, broadcast.433)
  divide.497 = f64[128]{0} divide(multiply.496, broadcast.435)
  subtract.498 = f64[128]{0} subtract(add.495, divide.497)
  divide.499 = f64[128]{0} divide(multiply.459, broadcast.443)
  subtract.500 = f64[128]{0} subtract(subtract.498, divide.499)
  divide.501 = f64[128]{0} divide(multiply.460, broadcast.435)
  add.502 = f64[128]{0} add(subtract.500, divide.501)
  reshape.549 = f64[1,128]{1,0} reshape(add.502)
  broadcast.550 = f64[1,128]{1,0} broadcast(reshape.549), dimensions={0,1}
  reshape.551 = f64[128]{0} reshape(broadcast.550)
  broadcast.552 = f64[128,128]{1,0} broadcast(reshape.551), dimensions={1}
  multiply.553 = f64[128,128]{1,0} multiply(call.548, broadcast.552)
  add.554 = f64[128,128]{1,0} add(add.547, multiply.553)
  call.555 = f64[128,128]{1,0} call(concatenate.527), to_apply=_roll_static_7.49
  divide.503 = f64[128]{0} divide(Arg_0.397, broadcast.437)
  negate.504 = f64[128]{0} negate(divide.503)
  divide.505 = f64[128]{0} divide(multiply.457, broadcast.451)
  subtract.506 = f64[128]{0} subtract(negate.504, divide.505)
  multiply.507 = f64[128]{0} multiply(multiply.458, broadcast.433)
  divide.508 = f64[128]{0} divide(multiply.507, broadcast.451)
  add.509 = f64[128]{0} add(subtract.506, divide.508)
  divide.510 = f64[128]{0} divide(multiply.459, broadcast.451)
  add.511 = f64[128]{0} add(add.509, divide.510)
  divide.512 = f64[128]{0} divide(multiply.460, broadcast.451)
  subtract.513 = f64[128]{0} subtract(add.511, divide.512)
  reshape.556 = f64[1,128]{1,0} reshape(subtract.513)
  broadcast.557 = f64[1,128]{1,0} broadcast(reshape.556), dimensions={0,1}
  reshape.558 = f64[128]{0} reshape(broadcast.557)
  broadcast.559 = f64[128,128]{1,0} broadcast(reshape.558), dimensions={1}
  multiply.560 = f64[128,128]{1,0} multiply(call.555, broadcast.559)
  add.561 = f64[128,128]{1,0} add(add.554, multiply.560)
  call.562 = f64[128,128]{1,0} call(concatenate.527), to_apply=_roll_static_8.54
  constant.430 = f64[] constant(30)
  broadcast.431 = f64[128]{0} broadcast(constant.430), dimensions={}
  divide.514 = f64[128]{0} divide(Arg_0.397, broadcast.431)
  divide.515 = f64[128]{0} divide(multiply.458, broadcast.451)
  subtract.516 = f64[128]{0} subtract(divide.514, divide.515)
  divide.517 = f64[128]{0} divide(multiply.460, broadcast.449)
  add.518 = f64[128]{0} add(subtract.516, divide.517)
  reshape.563 = f64[1,128]{1,0} reshape(add.518)
  broadcast.564 = f64[1,128]{1,0} broadcast(reshape.563), dimensions={0,1}
  reshape.565 = f64[128]{0} reshape(broadcast.564)
  broadcast.566 = f64[128,128]{1,0} broadcast(reshape.565), dimensions={1}
  multiply.567 = f64[128,128]{1,0} multiply(call.562, broadcast.566)
  add.568 = f64[128,128]{1,0} add(add.561, multiply.567)
  Arg_1.398 = f64[65]{0} parameter(1)
  constant.455 = f64[] constant(0.07874015748031496)
  call.569 = (f64[128]{0}, f64[128]{0}, f64[128]{0}) call(add.568, Arg_1.398, constant.455), to_apply=solve_poisson.72
  get-tuple-element.570 = f64[128]{0} get-tuple-element(call.569), index=0
  constant.428 = f64[] constant(0.05)
  broadcast.429 = f64[128]{0} broadcast(constant.428), dimensions={}
  multiply.573 = f64[128]{0} multiply(get-tuple-element.570, broadcast.429)
  constant.426 = f64[] constant(0.07874015748031496)
  broadcast.427 = f64[128]{0} broadcast(constant.426), dimensions={}
  divide.574 = f64[128]{0} divide(multiply.573, broadcast.427)
  floor.575 = f64[128]{0} floor(divide.574)
  convert.577 = s32[128]{0} convert(floor.575)
  constant.424 = s32[] constant(-1)
  broadcast.425 = s32[128]{0} broadcast(constant.424), dimensions={}
  compare.640 = pred[128]{0} compare(convert.577, broadcast.425), direction=EQ
  subtract.576 = f64[128]{0} subtract(divide.574, floor.575)
  divide.582 = f64[128]{0} divide(subtract.576, broadcast.453)
  multiply.578 = f64[128]{0} multiply(subtract.576, subtract.576)
  divide.583 = f64[128]{0} divide(multiply.578, broadcast.451)
  subtract.584 = f64[128]{0} subtract(divide.582, divide.583)
  multiply.579 = f64[128]{0} multiply(multiply.578, subtract.576)
  divide.585 = f64[128]{0} divide(multiply.579, broadcast.451)
  subtract.586 = f64[128]{0} subtract(subtract.584, divide.585)
  multiply.580 = f64[128]{0} multiply(multiply.579, subtract.576)
  divide.587 = f64[128]{0} divide(multiply.580, broadcast.451)
  add.588 = f64[128]{0} add(subtract.586, divide.587)
  multiply.581 = f64[128]{0} multiply(multiply.580, subtract.576)
  divide.589 = f64[128]{0} divide(multiply.581, broadcast.449)
  subtract.590 = f64[128]{0} subtract(add.588, divide.589)
  constant.456 = f64[] constant(0)
  call.641 = f64[128]{0} call(compare.640, subtract.590, constant.456), to_apply=_where.95
  constant.422 = s32[] constant(-2)
  broadcast.423 = s32[128]{0} broadcast(constant.422), dimensions={}
  compare.642 = pred[128]{0} compare(convert.577, broadcast.423), direction=EQ
  divide.591 = f64[128]{0} divide(subtract.576, broadcast.447)
  negate.592 = f64[128]{0} negate(divide.591)
  multiply.593 = f64[128]{0} multiply(multiply.578, broadcast.447)
  divide.594 = f64[128]{0} divide(multiply.593, broadcast.445)
  add.595 = f64[128]{0} add(negate.592, divide.594)
  divide.596 = f64[128]{0} divide(multiply.579, broadcast.451)
  subtract.597 = f64[128]{0} subtract(add.595, divide.596)
  divide.598 = f64[128]{0} divide(multiply.580, broadcast.443)
  subtract.599 = f64[128]{0} subtract(subtract.597, divide.598)
  divide.600 = f64[128]{0} divide(multiply.581, broadcast.451)
  add.601 = f64[128]{0} add(subtract.599, divide.600)
  call.643 = f64[128]{0} call(compare.642, add.601, constant.456), to_apply=_where.101
  add.644 = f64[128]{0} add(call.641, call.643)
  constant.420 = s32[] constant(-3)
  broadcast.421 = s32[128]{0} broadcast(constant.420), dimensions={}
  compare.645 = pred[128]{0} compare(convert.577, broadcast.421), direction=EQ
  divide.602 = f64[128]{0} divide(subtract.576, broadcast.445)
  subtract.603 = f64[128]{0} subtract(broadcast.441, divide.602)
  multiply.604 = f64[128]{0} multiply(multiply.578, broadcast.439)
  divide.605 = f64[128]{0} divide(multiply.604, broadcast.437)
  subtract.606 = f64[128]{0} subtract(subtract.603, divide.605)
  multiply.607 = f64[128]{0} multiply(multiply.579, broadcast.439)
  divide.608 = f64[128]{0} divide(multiply.607, broadcast.435)
  add.609 = f64[128]{0} add(subtract.606, divide.608)
  divide.610 = f64[128]{0} divide(multiply.580, broadcast.437)
  add.611 = f64[128]{0} add(add.609, divide.610)
  divide.612 = f64[128]{0} divide(multiply.581, broadcast.435)
  subtract.613 = f64[128]{0} subtract(add.611, divide.612)
  call.646 = f64[128]{0} call(compare.645, subtract.613, constant.456), to_apply=_where.107
  add.647 = f64[128]{0} add(add.644, call.646)
  constant.418 = s32[] constant(-4)
  broadcast.419 = s32[128]{0} broadcast(constant.418), dimensions={}
  compare.648 = pred[128]{0} compare(convert.577, broadcast.419), direction=EQ
  multiply.614 = f64[128]{0} multiply(multiply.578, broadcast.447)
  divide.615 = f64[128]{0} divide(multiply.614, broadcast.445)
  add.616 = f64[128]{0} add(subtract.576, divide.615)
  multiply.617 = f64[128]{0} multiply(multiply.579, broadcast.433)
  divide.618 = f64[128]{0} divide(multiply.617, broadcast.435)
  subtract.619 = f64[128]{0} subtract(add.616, divide.618)
  divide.620 = f64[128]{0} divide(multiply.580, broadcast.443)
  subtract.621 = f64[128]{0} subtract(subtract.619, divide.620)
  divide.622 = f64[128]{0} divide(multiply.581, broadcast.435)
  add.623 = f64[128]{0} add(subtract.621, divide.622)
  call.649 = f64[128]{0} call(compare.648, add.623, constant.456), to_apply=_where.113
  add.650 = f64[128]{0} add(add.647, call.649)
  constant.416 = s32[] constant(-5)
  broadcast.417 = s32[128]{0} broadcast(constant.416), dimensions={}
  compare.651 = pred[128]{0} compare(convert.577, broadcast.417), direction=EQ
  divide.624 = f64[128]{0} divide(subtract.576, broadcast.437)
  negate.625 = f64[128]{0} negate(divide.624)
  divide.626 = f64[128]{0} divide(multiply.578, broadcast.451)
  subtract.627 = f64[128]{0} subtract(negate.625, divide.626)
  multiply.628 = f64[128]{0} multiply(multiply.579, broadcast.433)
  divide.629 = f64[128]{0} divide(multiply.628, broadcast.451)
  add.630 = f64[128]{0} add(subtract.627, divide.629)
  divide.631 = f64[128]{0} divide(multiply.580, broadcast.451)
  add.632 = f64[128]{0} add(add.630, divide.631)
  divide.633 = f64[128]{0} divide(multiply.581, broadcast.451)
  subtract.634 = f64[128]{0} subtract(add.632, divide.633)
  call.652 = f64[128]{0} call(compare.651, subtract.634, constant.456), to_apply=_where.119
  add.653 = f64[128]{0} add(add.650, call.652)
  constant.414 = s32[] constant(-6)
  broadcast.415 = s32[128]{0} broadcast(constant.414), dimensions={}
  compare.654 = pred[128]{0} compare(convert.577, broadcast.415), direction=EQ
  divide.635 = f64[128]{0} divide(subtract.576, broadcast.431)
  divide.636 = f64[128]{0} divide(multiply.579, broadcast.451)
  subtract.637 = f64[128]{0} subtract(divide.635, divide.636)
  divide.638 = f64[128]{0} divide(multiply.581, broadcast.449)
  add.639 = f64[128]{0} add(subtract.637, divide.638)
  call.655 = f64[128]{0} call(compare.654, add.639, constant.456), to_apply=_where.125
  add.656 = f64[128]{0} add(add.653, call.655)
  reshape.760 = f64[128,1]{1,0} reshape(add.656)
  broadcast.762 = f64[128,1]{1,0} broadcast(reshape.760), dimensions={0,1}
  reshape.763 = f64[128]{0} reshape(broadcast.762)
  broadcast.764 = f64[128,128]{1,0} broadcast(reshape.763), dimensions={0}
  constant.454 = s64[] constant(0)
  call.759 = f64[128,134]{1,0} call(add.568, constant.454), to_apply=_pad.347
  slice.761 = f64[128,128]{1,0} slice(call.759), slice={[0:128], [6:134]}
  multiply.765 = f64[128,128]{1,0} multiply(broadcast.764, slice.761)
  constant.412 = s32[] constant(0)
  broadcast.413 = s32[128]{0} broadcast(constant.412), dimensions={}
  compare.657 = pred[128]{0} compare(convert.577, broadcast.413), direction=EQ
  call.658 = f64[128]{0} call(compare.657, subtract.590, constant.456), to_apply=_where.131
  compare.659 = pred[128]{0} compare(convert.577, broadcast.425), direction=EQ
  call.660 = f64[128]{0} call(compare.659, add.601, constant.456), to_apply=_where.137
  add.661 = f64[128]{0} add(call.658, call.660)
  compare.662 = pred[128]{0} compare(convert.577, broadcast.423), direction=EQ
  call.663 = f64[128]{0} call(compare.662, subtract.613, constant.456), to_apply=_where.143
  add.664 = f64[128]{0} add(add.661, call.663)
  compare.665 = pred[128]{0} compare(convert.577, broadcast.421), direction=EQ
  call.666 = f64[128]{0} call(compare.665, add.623, constant.456), to_apply=_where.149
  add.667 = f64[128]{0} add(add.664, call.666)
  compare.668 = pred[128]{0} compare(convert.577, broadcast.419), direction=EQ
  call.669 = f64[128]{0} call(compare.668, subtract.634, constant.456), to_apply=_where.155
  add.670 = f64[128]{0} add(add.667, call.669)
  compare.671 = pred[128]{0} compare(convert.577, broadcast.417), direction=EQ
  call.672 = f64[128]{0} call(compare.671, add.639, constant.456), to_apply=_where.161
  add.673 = f64[128]{0} add(add.670, call.672)
  reshape.766 = f64[128,1]{1,0} reshape(add.673)
  broadcast.768 = f64[128,1]{1,0} broadcast(reshape.766), dimensions={0,1}
  reshape.769 = f64[128]{0} reshape(broadcast.768)
  broadcast.770 = f64[128,128]{1,0} broadcast(reshape.769), dimensions={0}
  slice.767 = f64[128,128]{1,0} slice(call.759), slice={[0:128], [5:133]}
  multiply.771 = f64[128,128]{1,0} multiply(broadcast.770, slice.767)
  add.772 = f64[128,128]{1,0} add(multiply.765, multiply.771)
  constant.410 = s32[] constant(1)
  broadcast.411 = s32[128]{0} broadcast(constant.410), dimensions={}
  compare.674 = pred[128]{0} compare(convert.577, broadcast.411), direction=EQ
  call.675 = f64[128]{0} call(compare.674, subtract.590, constant.456), to_apply=_where.167
  compare.676 = pred[128]{0} compare(convert.577, broadcast.413), direction=EQ
  call.677 = f64[128]{0} call(compare.676, add.601, constant.456), to_apply=_where.173
  add.678 = f64[128]{0} add(call.675, call.677)
  compare.679 = pred[128]{0} compare(convert.577, broadcast.425), direction=EQ
  call.680 = f64[128]{0} call(compare.679, subtract.613, constant.456), to_apply=_where.179
  add.681 = f64[128]{0} add(add.678, call.680)
  compare.682 = pred[128]{0} compare(convert.577, broadcast.423), direction=EQ
  call.683 = f64[128]{0} call(compare.682, add.623, constant.456), to_apply=_where.185
  add.684 = f64[128]{0} add(add.681, call.683)
  compare.685 = pred[128]{0} compare(convert.577, broadcast.421), direction=EQ
  call.686 = f64[128]{0} call(compare.685, subtract.634, constant.456), to_apply=_where.191
  add.687 = f64[128]{0} add(add.684, call.686)
  compare.688 = pred[128]{0} compare(convert.577, broadcast.419), direction=EQ
  call.689 = f64[128]{0} call(compare.688, add.639, constant.456), to_apply=_where.197
  add.690 = f64[128]{0} add(add.687, call.689)
  reshape.773 = f64[128,1]{1,0} reshape(add.690)
  broadcast.775 = f64[128,1]{1,0} broadcast(reshape.773), dimensions={0,1}
  reshape.776 = f64[128]{0} reshape(broadcast.775)
  broadcast.777 = f64[128,128]{1,0} broadcast(reshape.776), dimensions={0}
  slice.774 = f64[128,128]{1,0} slice(call.759), slice={[0:128], [4:132]}
  multiply.778 = f64[128,128]{1,0} multiply(broadcast.777, slice.774)
  add.779 = f64[128,128]{1,0} add(add.772, multiply.778)
  constant.408 = s32[] constant(2)
  broadcast.409 = s32[128]{0} broadcast(constant.408), dimensions={}
  compare.691 = pred[128]{0} compare(convert.577, broadcast.409), direction=EQ
  call.692 = f64[128]{0} call(compare.691, subtract.590, constant.456), to_apply=_where.203
  compare.693 = pred[128]{0} compare(convert.577, broadcast.411), direction=EQ
  call.694 = f64[128]{0} call(compare.693, add.601, constant.456), to_apply=_where.209
  add.695 = f64[128]{0} add(call.692, call.694)
  compare.696 = pred[128]{0} compare(convert.577, broadcast.413), direction=EQ
  call.697 = f64[128]{0} call(compare.696, subtract.613, constant.456), to_apply=_where.215
  add.698 = f64[128]{0} add(add.695, call.697)
  compare.699 = pred[128]{0} compare(convert.577, broadcast.425), direction=EQ
  call.700 = f64[128]{0} call(compare.699, add.623, constant.456), to_apply=_where.221
  add.701 = f64[128]{0} add(add.698, call.700)
  compare.702 = pred[128]{0} compare(convert.577, broadcast.423), direction=EQ
  call.703 = f64[128]{0} call(compare.702, subtract.634, constant.456), to_apply=_where.227
  add.704 = f64[128]{0} add(add.701, call.703)
  compare.705 = pred[128]{0} compare(convert.577, broadcast.421), direction=EQ
  call.706 = f64[128]{0} call(compare.705, add.639, constant.456), to_apply=_where.233
  add.707 = f64[128]{0} add(add.704, call.706)
  reshape.780 = f64[128,1]{1,0} reshape(add.707)
  broadcast.782 = f64[128,1]{1,0} broadcast(reshape.780), dimensions={0,1}
  reshape.783 = f64[128]{0} reshape(broadcast.782)
  broadcast.784 = f64[128,128]{1,0} broadcast(reshape.783), dimensions={0}
  slice.781 = f64[128,128]{1,0} slice(call.759), slice={[0:128], [3:131]}
  multiply.785 = f64[128,128]{1,0} multiply(broadcast.784, slice.781)
  add.786 = f64[128,128]{1,0} add(add.779, multiply.785)
  constant.406 = s32[] constant(3)
  broadcast.407 = s32[128]{0} broadcast(constant.406), dimensions={}
  compare.708 = pred[128]{0} compare(convert.577, broadcast.407), direction=EQ
  call.709 = f64[128]{0} call(compare.708, subtract.590, constant.456), to_apply=_where.239
  compare.710 = pred[128]{0} compare(convert.577, broadcast.409), direction=EQ
  call.711 = f64[128]{0} call(compare.710, add.601, constant.456), to_apply=_where.245
  add.712 = f64[128]{0} add(call.709, call.711)
  compare.713 = pred[128]{0} compare(convert.577, broadcast.411), direction=EQ
  call.714 = f64[128]{0} call(compare.713, subtract.613, constant.456), to_apply=_where.251
  add.715 = f64[128]{0} add(add.712, call.714)
  compare.716 = pred[128]{0} compare(convert.577, broadcast.413), direction=EQ
  call.717 = f64[128]{0} call(compare.716, add.623, constant.456), to_apply=_where.257
  add.718 = f64[128]{0} add(add.715, call.717)
  compare.719 = pred[128]{0} compare(convert.577, broadcast.425), direction=EQ
  call.720 = f64[128]{0} call(compare.719, subtract.634, constant.456), to_apply=_where.263
  add.721 = f64[128]{0} add(add.718, call.720)
  compare.722 = pred[128]{0} compare(convert.577, broadcast.423), direction=EQ
  call.723 = f64[128]{0} call(compare.722, add.639, constant.456), to_apply=_where.269
  add.724 = f64[128]{0} add(add.721, call.723)
  reshape.787 = f64[128,1]{1,0} reshape(add.724)
  broadcast.789 = f64[128,1]{1,0} broadcast(reshape.787), dimensions={0,1}
  reshape.790 = f64[128]{0} reshape(broadcast.789)
  broadcast.791 = f64[128,128]{1,0} broadcast(reshape.790), dimensions={0}
  slice.788 = f64[128,128]{1,0} slice(call.759), slice={[0:128], [2:130]}
  multiply.792 = f64[128,128]{1,0} multiply(broadcast.791, slice.788)
  add.793 = f64[128,128]{1,0} add(add.786, multiply.792)
  constant.404 = s32[] constant(4)
  broadcast.405 = s32[128]{0} broadcast(constant.404), dimensions={}
  compare.725 = pred[128]{0} compare(convert.577, broadcast.405), direction=EQ
  call.726 = f64[128]{0} call(compare.725, subtract.590, constant.456), to_apply=_where.275
  compare.727 = pred[128]{0} compare(convert.577, broadcast.407), direction=EQ
  call.728 = f64[128]{0} call(compare.727, add.601, constant.456), to_apply=_where.281
  add.729 = f64[128]{0} add(call.726, call.728)
  compare.730 = pred[128]{0} compare(convert.577, broadcast.409), direction=EQ
  call.731 = f64[128]{0} call(compare.730, subtract.613, constant.456), to_apply=_where.287
  add.732 = f64[128]{0} add(add.729, call.731)
  compare.733 = pred[128]{0} compare(convert.577, broadcast.411), direction=EQ
  call.734 = f64[128]{0} call(compare.733, add.623, constant.456), to_apply=_where.293
  add.735 = f64[128]{0} add(add.732, call.734)
  compare.736 = pred[128]{0} compare(convert.577, broadcast.413), direction=EQ
  call.737 = f64[128]{0} call(compare.736, subtract.634, constant.456), to_apply=_where.299
  add.738 = f64[128]{0} add(add.735, call.737)
  compare.739 = pred[128]{0} compare(convert.577, broadcast.425), direction=EQ
  call.740 = f64[128]{0} call(compare.739, add.639, constant.456), to_apply=_where.305
  add.741 = f64[128]{0} add(add.738, call.740)
  reshape.794 = f64[128,1]{1,0} reshape(add.741)
  broadcast.796 = f64[128,1]{1,0} broadcast(reshape.794), dimensions={0,1}
  reshape.797 = f64[128]{0} reshape(broadcast.796)
  broadcast.798 = f64[128,128]{1,0} broadcast(reshape.797), dimensions={0}
  slice.795 = f64[128,128]{1,0} slice(call.759), slice={[0:128], [1:129]}
  multiply.799 = f64[128,128]{1,0} multiply(broadcast.798, slice.795)
  add.800 = f64[128,128]{1,0} add(add.793, multiply.799)
  constant.402 = s32[] constant(5)
  broadcast.403 = s32[128]{0} broadcast(constant.402), dimensions={}
  compare.742 = pred[128]{0} compare(convert.577, broadcast.403), direction=EQ
  call.743 = f64[128]{0} call(compare.742, subtract.590, constant.456), to_apply=_where.311
  compare.744 = pred[128]{0} compare(convert.577, broadcast.405), direction=EQ
  call.745 = f64[128]{0} call(compare.744, add.601, constant.456), to_apply=_where.317
  add.746 = f64[128]{0} add(call.743, call.745)
  compare.747 = pred[128]{0} compare(convert.577, broadcast.407), direction=EQ
  call.748 = f64[128]{0} call(compare.747, subtract.613, constant.456), to_apply=_where.323
  add.749 = f64[128]{0} add(add.746, call.748)
  compare.750 = pred[128]{0} compare(convert.577, broadcast.409), direction=EQ
  call.751 = f64[128]{0} call(compare.750, add.623, constant.456), to_apply=_where.329
  add.752 = f64[128]{0} add(add.749, call.751)
  compare.753 = pred[128]{0} compare(convert.577, broadcast.411), direction=EQ
  call.754 = f64[128]{0} call(compare.753, subtract.634, constant.456), to_apply=_where.335
  add.755 = f64[128]{0} add(add.752, call.754)
  compare.756 = pred[128]{0} compare(convert.577, broadcast.413), direction=EQ
  call.757 = f64[128]{0} call(compare.756, add.639, constant.456), to_apply=_where.341
  add.758 = f64[128]{0} add(add.755, call.757)
  reshape.801 = f64[128,1]{1,0} reshape(add.758)
  broadcast.803 = f64[128,1]{1,0} broadcast(reshape.801), dimensions={0,1}
  reshape.804 = f64[128]{0} reshape(broadcast.803)
  broadcast.805 = f64[128,128]{1,0} broadcast(reshape.804), dimensions={0}
  slice.802 = f64[128,128]{1,0} slice(call.759), slice={[0:128], [0:128]}
  multiply.806 = f64[128,128]{1,0} multiply(broadcast.805, slice.802)
  add.807 = f64[128,128]{1,0} add(add.800, multiply.806)
  slice.808 = f64[128,14]{1,0} slice(add.807), slice={[0:128], [0:14]}
  call.809 = f64[128,14]{1,0} call(slice.808), to_apply=_roll_static.352
  slice.810 = f64[128,50]{1,0} slice(add.807), slice={[0:128], [14:64]}
  call.811 = f64[128,50]{1,0} call(slice.810), to_apply=_roll_static_0.357
  slice.812 = f64[128,50]{1,0} slice(add.807), slice={[0:128], [64:114]}
  call.813 = f64[128,50]{1,0} call(slice.812), to_apply=_roll_static_1.362
  slice.814 = f64[128,14]{1,0} slice(add.807), slice={[0:128], [114:128]}
  call.815 = f64[128,14]{1,0} call(slice.814), to_apply=_roll_static_2.364
  concatenate.816 = f64[128,128]{1,0} concatenate(call.809, call.811, call.813, call.815), dimensions={1}
  call.817 = f64[128,128]{1,0} call(concatenate.816), to_apply=_roll_static_3.369
  reshape.818 = f64[1,128]{1,0} reshape(subtract.469)
  broadcast.819 = f64[1,128]{1,0} broadcast(reshape.818), dimensions={0,1}
  reshape.820 = f64[128]{0} reshape(broadcast.819)
  broadcast.821 = f64[128,128]{1,0} broadcast(reshape.820), dimensions={1}
  multiply.822 = f64[128,128]{1,0} multiply(call.817, broadcast.821)
  call.823 = f64[128,128]{1,0} call(concatenate.816), to_apply=_roll_static_4.374
  reshape.824 = f64[1,128]{1,0} reshape(add.480)
  broadcast.825 = f64[1,128]{1,0} broadcast(reshape.824), dimensions={0,1}
  reshape.826 = f64[128]{0} reshape(broadcast.825)
  broadcast.827 = f64[128,128]{1,0} broadcast(reshape.826), dimensions={1}
  multiply.828 = f64[128,128]{1,0} multiply(call.823, broadcast.827)
  add.829 = f64[128,128]{1,0} add(multiply.822, multiply.828)
  call.830 = f64[128,128]{1,0} call(concatenate.816), to_apply=_roll_static_5.379
  reshape.831 = f64[1,128]{1,0} reshape(subtract.492)
  broadcast.832 = f64[1,128]{1,0} broadcast(reshape.831), dimensions={0,1}
  reshape.833 = f64[128]{0} reshape(broadcast.832)
  broadcast.834 = f64[128,128]{1,0} broadcast(reshape.833), dimensions={1}
  multiply.835 = f64[128,128]{1,0} multiply(call.830, broadcast.834)
  add.836 = f64[128,128]{1,0} add(add.829, multiply.835)
  call.837 = f64[128,128]{1,0} call(concatenate.816), to_apply=_roll_static_6.381
  reshape.838 = f64[1,128]{1,0} reshape(add.502)
  broadcast.839 = f64[1,128]{1,0} broadcast(reshape.838), dimensions={0,1}
  reshape.840 = f64[128]{0} reshape(broadcast.839)
  broadcast.841 = f64[128,128]{1,0} broadcast(reshape.840), dimensions={1}
  multiply.842 = f64[128,128]{1,0} multiply(call.837, broadcast.841)
  add.843 = f64[128,128]{1,0} add(add.836, multiply.842)
  call.844 = f64[128,128]{1,0} call(concatenate.816), to_apply=_roll_static_7.386
  reshape.845 = f64[1,128]{1,0} reshape(subtract.513)
  broadcast.846 = f64[1,128]{1,0} broadcast(reshape.845), dimensions={0,1}
  reshape.847 = f64[128]{0} reshape(broadcast.846)
  broadcast.848 = f64[128,128]{1,0} broadcast(reshape.847), dimensions={1}
  multiply.849 = f64[128,128]{1,0} multiply(call.844, broadcast.848)
  add.850 = f64[128,128]{1,0} add(add.843, multiply.849)
  call.851 = f64[128,128]{1,0} call(concatenate.816), to_apply=_roll_static_8.391
  reshape.852 = f64[1,128]{1,0} reshape(add.518)
  broadcast.853 = f64[1,128]{1,0} broadcast(reshape.852), dimensions={0,1}
  reshape.854 = f64[128]{0} reshape(broadcast.853)
  broadcast.855 = f64[128,128]{1,0} broadcast(reshape.854), dimensions={1}
  multiply.856 = f64[128,128]{1,0} multiply(call.851, broadcast.855)
  add.857 = f64[128,128]{1,0} add(add.850, multiply.856)
  get-tuple-element.571 = f64[128]{0} get-tuple-element(call.569), index=1
  get-tuple-element.572 = f64[128]{0} get-tuple-element(call.569), index=2
  ROOT tuple.858 = (f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) tuple(add.857, get-tuple-element.571, get-tuple-element.572)
}

region_0.859 {
  arg_tuple.860 = (s64[], f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) parameter(0)
  get-tuple-element.861 = s64[] get-tuple-element(arg_tuple.860), index=0
  constant.865 = s64[] constant(1)
  add.872 = s64[] add(get-tuple-element.861, constant.865)
  constant.867 = f64[128]{0} constant({...})
  constant.866 = f64[65]{0} constant({...})
  get-tuple-element.862 = f64[128,128]{1,0} get-tuple-element(arg_tuple.860), index=1
  get-tuple-element.863 = f64[128]{0} get-tuple-element(arg_tuple.860), index=2
  get-tuple-element.864 = f64[128]{0} get-tuple-element(arg_tuple.860), index=3
  call.868 = (f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) call(constant.867, constant.866, get-tuple-element.862, get-tuple-element.863, get-tuple-element.864), to_apply=None.396
  get-tuple-element.869 = f64[128,128]{1,0} get-tuple-element(call.868), index=0
  get-tuple-element.870 = f64[128]{0} get-tuple-element(call.868), index=1
  get-tuple-element.871 = f64[128]{0} get-tuple-element(call.868), index=2
  ROOT tuple.873 = (s64[], f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) tuple(add.872, get-tuple-element.869, get-tuple-element.870, get-tuple-element.871)
}

region_2.874 {
  arg_tuple.875 = (s64[], f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) parameter(0)
  get-tuple-element.877 = f64[128,128]{1,0} get-tuple-element(arg_tuple.875), index=1
  get-tuple-element.878 = f64[128]{0} get-tuple-element(arg_tuple.875), index=2
  get-tuple-element.879 = f64[128]{0} get-tuple-element(arg_tuple.875), index=3
  get-tuple-element.876 = s64[] get-tuple-element(arg_tuple.875), index=0
  constant.880 = s64[] constant(1000)
  ROOT compare.881 = pred[] compare(get-tuple-element.876, constant.880), direction=LT
}

ENTRY main.890 {
  constant.13 = s64[] constant(0)
  Arg_6.7 = f64[128,128]{1,0} parameter(6)
  Arg_4.5 = f64[128]{0} parameter(4)
  Arg_5.6 = f64[128]{0} parameter(5)
  tuple.14 = (s64[], f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) tuple(constant.13, Arg_6.7, Arg_4.5, Arg_5.6)
  while.882 = (s64[], f64[128,128]{1,0}, f64[128]{0}, f64[128]{0}) while(tuple.14), condition=region_2.874, body=region_0.859
  get-tuple-element.883 = s64[] get-tuple-element(while.882), index=0
  Arg_0.1 = f64[128]{0} parameter(0)
  Arg_1.2 = f64[128]{0} parameter(1)
  Arg_2.3 = f64[65]{0} parameter(2)
  Arg_3.4 = s32[6]{0} parameter(3)
  get-tuple-element.885 = f64[128]{0} get-tuple-element(while.882), index=2
  get-tuple-element.886 = f64[128]{0} get-tuple-element(while.882), index=3
  get-tuple-element.884 = f64[128,128]{1,0} get-tuple-element(while.882), index=1
  Arg_7.8 = f64[128]{0} parameter(7)
  Arg_8.9 = f64[] parameter(8)
  constant.11 = f64[] constant(50)
  add.887 = f64[] add(Arg_8.9, constant.11)
  Arg_9.10 = s64[] parameter(9)
  constant.12 = s64[] constant(1000)
  add.888 = s64[] add(Arg_9.10, constant.12)
  ROOT tuple.889 = (f64[128]{0}, f64[128]{0}, f64[65]{0}, s32[6]{0}, f64[128]{0}, /*index=5*/f64[128]{0}, f64[128,128]{1,0}, f64[128]{0}, f64[], s64[]) tuple(Arg_0.1, Arg_1.2, Arg_2.3, Arg_3.4, get-tuple-element.885, get-tuple-element.886, get-tuple-element.884, Arg_7.8, add.887, add.888)
}

