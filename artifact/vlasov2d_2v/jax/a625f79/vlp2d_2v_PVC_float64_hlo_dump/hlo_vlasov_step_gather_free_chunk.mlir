HloModule jit_run_chunk, entry_computation_layout={(f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[], /*index=5*/s64[])->(f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32,1]{1,0}, /*index=5*/f64[1,17]{1,0}, f64[32,17]{1,0}, s32[6]{0}, f64[32,32]{1,0}, f64[32,32]{1,0}, /*index=10*/f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[], s64[])}

_roll_static.17 {
  Arg_0.18 = f64[32,32,16,32]{3,2,1,0} parameter(0)
  slice.19 = f64[31,32,16,32]{3,2,1,0} slice(Arg_0.18), slice={[1:32], [0:32], [0:16], [0:32]}
  slice.20 = f64[1,32,16,32]{3,2,1,0} slice(Arg_0.18), slice={[0:1], [0:32], [0:16], [0:32]}
  ROOT concatenate.21 = f64[32,32,16,32]{3,2,1,0} concatenate(slice.19, slice.20), dimensions={0}
}

_roll_static_0.22 {
  ROOT Arg_0.23 = f64[32,32,16,32]{3,2,1,0} parameter(0)
}

_roll_static_1.24 {
  Arg_0.25 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.26 = f64[30,32,32,32]{3,2,1,0} slice(Arg_0.25), slice={[2:32], [0:32], [0:32], [0:32]}
  slice.27 = f64[2,32,32,32]{3,2,1,0} slice(Arg_0.25), slice={[0:2], [0:32], [0:32], [0:32]}
  ROOT concatenate.28 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.26, slice.27), dimensions={0}
}

_roll_static_2.29 {
  Arg_0.30 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.31 = f64[31,32,32,32]{3,2,1,0} slice(Arg_0.30), slice={[1:32], [0:32], [0:32], [0:32]}
  slice.32 = f64[1,32,32,32]{3,2,1,0} slice(Arg_0.30), slice={[0:1], [0:32], [0:32], [0:32]}
  ROOT concatenate.33 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.31, slice.32), dimensions={0}
}

_roll_static_3.34 {
  ROOT Arg_0.35 = f64[32,32,32,32]{3,2,1,0} parameter(0)
}

_roll_static_4.36 {
  Arg_0.37 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.38 = f64[1,32,32,32]{3,2,1,0} slice(Arg_0.37), slice={[31:32], [0:32], [0:32], [0:32]}
  slice.39 = f64[31,32,32,32]{3,2,1,0} slice(Arg_0.37), slice={[0:31], [0:32], [0:32], [0:32]}
  ROOT concatenate.40 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.38, slice.39), dimensions={0}
}

_roll_static_5.41 {
  Arg_0.42 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.43 = f64[2,32,32,32]{3,2,1,0} slice(Arg_0.42), slice={[30:32], [0:32], [0:32], [0:32]}
  slice.44 = f64[30,32,32,32]{3,2,1,0} slice(Arg_0.42), slice={[0:30], [0:32], [0:32], [0:32]}
  ROOT concatenate.45 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.43, slice.44), dimensions={0}
}

_roll_static_6.46 {
  Arg_0.47 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.48 = f64[3,32,32,32]{3,2,1,0} slice(Arg_0.47), slice={[29:32], [0:32], [0:32], [0:32]}
  slice.49 = f64[29,32,32,32]{3,2,1,0} slice(Arg_0.47), slice={[0:29], [0:32], [0:32], [0:32]}
  ROOT concatenate.50 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.48, slice.49), dimensions={0}
}

_roll_static_7.51 {
  Arg_0.52 = f64[32,32,32,16]{3,2,1,0} parameter(0)
  slice.53 = f64[32,31,32,16]{3,2,1,0} slice(Arg_0.52), slice={[0:32], [1:32], [0:32], [0:16]}
  slice.54 = f64[32,1,32,16]{3,2,1,0} slice(Arg_0.52), slice={[0:32], [0:1], [0:32], [0:16]}
  ROOT concatenate.55 = f64[32,32,32,16]{3,2,1,0} concatenate(slice.53, slice.54), dimensions={1}
}

_roll_static_8.56 {
  ROOT Arg_0.57 = f64[32,32,32,16]{3,2,1,0} parameter(0)
}

_roll_static_9.58 {
  Arg_0.59 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.60 = f64[32,30,32,32]{3,2,1,0} slice(Arg_0.59), slice={[0:32], [2:32], [0:32], [0:32]}
  slice.61 = f64[32,2,32,32]{3,2,1,0} slice(Arg_0.59), slice={[0:32], [0:2], [0:32], [0:32]}
  ROOT concatenate.62 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.60, slice.61), dimensions={1}
}

_roll_static_10.63 {
  Arg_0.64 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.65 = f64[32,31,32,32]{3,2,1,0} slice(Arg_0.64), slice={[0:32], [1:32], [0:32], [0:32]}
  slice.66 = f64[32,1,32,32]{3,2,1,0} slice(Arg_0.64), slice={[0:32], [0:1], [0:32], [0:32]}
  ROOT concatenate.67 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.65, slice.66), dimensions={1}
}

_roll_static_11.68 {
  ROOT Arg_0.69 = f64[32,32,32,32]{3,2,1,0} parameter(0)
}

_roll_static_12.70 {
  Arg_0.71 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.72 = f64[32,1,32,32]{3,2,1,0} slice(Arg_0.71), slice={[0:32], [31:32], [0:32], [0:32]}
  slice.73 = f64[32,31,32,32]{3,2,1,0} slice(Arg_0.71), slice={[0:32], [0:31], [0:32], [0:32]}
  ROOT concatenate.74 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.72, slice.73), dimensions={1}
}

_roll_static_13.75 {
  Arg_0.76 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.77 = f64[32,2,32,32]{3,2,1,0} slice(Arg_0.76), slice={[0:32], [30:32], [0:32], [0:32]}
  slice.78 = f64[32,30,32,32]{3,2,1,0} slice(Arg_0.76), slice={[0:32], [0:30], [0:32], [0:32]}
  ROOT concatenate.79 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.77, slice.78), dimensions={1}
}

_roll_static_14.80 {
  Arg_0.81 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.82 = f64[32,3,32,32]{3,2,1,0} slice(Arg_0.81), slice={[0:32], [29:32], [0:32], [0:32]}
  slice.83 = f64[32,29,32,32]{3,2,1,0} slice(Arg_0.81), slice={[0:32], [0:29], [0:32], [0:32]}
  ROOT concatenate.84 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.82, slice.83), dimensions={1}
}

region_1.85 {
  Arg_0.86 = f64[] parameter(0)
  Arg_1.87 = f64[] parameter(1)
  ROOT add.88 = f64[] add(Arg_0.86, Arg_1.87)
}

fft.89 {
  Arg_0.90 = f64[32,32]{1,0} parameter(0)
  ROOT fft.91 = c128[32,17]{1,0} fft(Arg_0.90), fft_type=RFFT, fft_length={32,32}
}

fft_15.92 {
  Arg_0.93 = c128[32,17]{1,0} parameter(0)
  ROOT fft.94 = f64[32,32]{1,0} fft(Arg_0.93), fft_type=IRFFT, fft_length={32,32}
}

fft_15.95 {
  Arg_0.96 = c128[32,17]{1,0} parameter(0)
  ROOT fft.97 = f64[32,32]{1,0} fft(Arg_0.96), fft_type=IRFFT, fft_length={32,32}
}

fft_15.98 {
  Arg_0.99 = c128[32,17]{1,0} parameter(0)
  ROOT fft.100 = f64[32,32]{1,0} fft(Arg_0.99), fft_type=IRFFT, fft_length={32,32}
}

solve_poisson.101 {
  Arg_1.103 = f64[32,1]{1,0} parameter(1)
  convert.125 = c128[32,1]{1,0} convert(Arg_1.103)
  constant.110 = c128[] constant((-0, -1))
  broadcast.111 = c128[32,1]{1,0} broadcast(constant.110), dimensions={}
  multiply.126 = c128[32,1]{1,0} multiply(convert.125, broadcast.111)
  broadcast.127 = c128[32,1]{1,0} broadcast(multiply.126), dimensions={0,1}
  reshape.128 = c128[32]{0} reshape(broadcast.127)
  broadcast.129 = c128[32,17]{1,0} broadcast(reshape.128), dimensions={0}
  Arg_0.102 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  constant.114 = f64[] constant(0)
  reduce.115 = f64[32,32]{1,0} reduce(Arg_0.102, constant.114), dimensions={2,3}, to_apply=region_1.85
  Arg_4.106 = f64[] parameter(4)
  broadcast.116 = f64[32,32]{1,0} broadcast(Arg_4.106), dimensions={}
  multiply.117 = f64[32,32]{1,0} multiply(reduce.115, broadcast.116)
  Arg_5.107 = f64[] parameter(5)
  broadcast.118 = f64[32,32]{1,0} broadcast(Arg_5.107), dimensions={}
  multiply.119 = f64[32,32]{1,0} multiply(multiply.117, broadcast.118)
  constant.112 = f64[] constant(1)
  broadcast.113 = f64[32,32]{1,0} broadcast(constant.112), dimensions={}
  subtract.120 = f64[32,32]{1,0} subtract(multiply.119, broadcast.113)
  call.121 = c128[32,17]{1,0} call(subtract.120), to_apply=fft.89
  Arg_3.105 = f64[32,17]{1,0} parameter(3)
  convert.122 = c128[32,17]{1,0} convert(Arg_3.105)
  multiply.123 = c128[32,17]{1,0} multiply(call.121, convert.122)
  multiply.130 = c128[32,17]{1,0} multiply(broadcast.129, multiply.123)
  call.137 = f64[32,32]{1,0} call(multiply.130), to_apply=fft_15.95
  Arg_2.104 = f64[1,17]{1,0} parameter(2)
  convert.131 = c128[1,17]{1,0} convert(Arg_2.104)
  constant.108 = c128[] constant((-0, -1))
  broadcast.109 = c128[1,17]{1,0} broadcast(constant.108), dimensions={}
  multiply.132 = c128[1,17]{1,0} multiply(convert.131, broadcast.109)
  broadcast.133 = c128[1,17]{1,0} broadcast(multiply.132), dimensions={0,1}
  reshape.134 = c128[17]{0} reshape(broadcast.133)
  broadcast.135 = c128[32,17]{1,0} broadcast(reshape.134), dimensions={1}
  multiply.136 = c128[32,17]{1,0} multiply(broadcast.135, multiply.123)
  call.138 = f64[32,32]{1,0} call(multiply.136), to_apply=fft_15.98
  call.124 = f64[32,32]{1,0} call(multiply.123), to_apply=fft_15.92
  ROOT tuple.139 = (f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(call.137, call.138, subtract.120, call.124)
}

_where.140 {
  Arg_0.141 = pred[32,32]{1,0} parameter(0)
  Arg_1.142 = f64[32,32]{1,0} parameter(1)
  Arg_2.143 = f64[] parameter(2)
  broadcast.144 = f64[32,32]{1,0} broadcast(Arg_2.143), dimensions={}
  ROOT select.145 = f64[32,32]{1,0} select(Arg_0.141, Arg_1.142, broadcast.144)
}

_where.146 {
  Arg_0.147 = pred[32,32]{1,0} parameter(0)
  Arg_1.148 = f64[32,32]{1,0} parameter(1)
  Arg_2.149 = f64[] parameter(2)
  broadcast.150 = f64[32,32]{1,0} broadcast(Arg_2.149), dimensions={}
  ROOT select.151 = f64[32,32]{1,0} select(Arg_0.147, Arg_1.148, broadcast.150)
}

_where.152 {
  Arg_0.153 = pred[32,32]{1,0} parameter(0)
  Arg_1.154 = f64[32,32]{1,0} parameter(1)
  Arg_2.155 = f64[] parameter(2)
  broadcast.156 = f64[32,32]{1,0} broadcast(Arg_2.155), dimensions={}
  ROOT select.157 = f64[32,32]{1,0} select(Arg_0.153, Arg_1.154, broadcast.156)
}

_where.158 {
  Arg_0.159 = pred[32,32]{1,0} parameter(0)
  Arg_1.160 = f64[32,32]{1,0} parameter(1)
  Arg_2.161 = f64[] parameter(2)
  broadcast.162 = f64[32,32]{1,0} broadcast(Arg_2.161), dimensions={}
  ROOT select.163 = f64[32,32]{1,0} select(Arg_0.159, Arg_1.160, broadcast.162)
}

_where.164 {
  Arg_0.165 = pred[32,32]{1,0} parameter(0)
  Arg_1.166 = f64[32,32]{1,0} parameter(1)
  Arg_2.167 = f64[] parameter(2)
  broadcast.168 = f64[32,32]{1,0} broadcast(Arg_2.167), dimensions={}
  ROOT select.169 = f64[32,32]{1,0} select(Arg_0.165, Arg_1.166, broadcast.168)
}

_where.170 {
  Arg_0.171 = pred[32,32]{1,0} parameter(0)
  Arg_1.172 = f64[32,32]{1,0} parameter(1)
  Arg_2.173 = f64[] parameter(2)
  broadcast.174 = f64[32,32]{1,0} broadcast(Arg_2.173), dimensions={}
  ROOT select.175 = f64[32,32]{1,0} select(Arg_0.171, Arg_1.172, broadcast.174)
}

_where.176 {
  Arg_0.177 = pred[32,32]{1,0} parameter(0)
  Arg_1.178 = f64[32,32]{1,0} parameter(1)
  Arg_2.179 = f64[] parameter(2)
  broadcast.180 = f64[32,32]{1,0} broadcast(Arg_2.179), dimensions={}
  ROOT select.181 = f64[32,32]{1,0} select(Arg_0.177, Arg_1.178, broadcast.180)
}

_where.182 {
  Arg_0.183 = pred[32,32]{1,0} parameter(0)
  Arg_1.184 = f64[32,32]{1,0} parameter(1)
  Arg_2.185 = f64[] parameter(2)
  broadcast.186 = f64[32,32]{1,0} broadcast(Arg_2.185), dimensions={}
  ROOT select.187 = f64[32,32]{1,0} select(Arg_0.183, Arg_1.184, broadcast.186)
}

_where.188 {
  Arg_0.189 = pred[32,32]{1,0} parameter(0)
  Arg_1.190 = f64[32,32]{1,0} parameter(1)
  Arg_2.191 = f64[] parameter(2)
  broadcast.192 = f64[32,32]{1,0} broadcast(Arg_2.191), dimensions={}
  ROOT select.193 = f64[32,32]{1,0} select(Arg_0.189, Arg_1.190, broadcast.192)
}

_where.194 {
  Arg_0.195 = pred[32,32]{1,0} parameter(0)
  Arg_1.196 = f64[32,32]{1,0} parameter(1)
  Arg_2.197 = f64[] parameter(2)
  broadcast.198 = f64[32,32]{1,0} broadcast(Arg_2.197), dimensions={}
  ROOT select.199 = f64[32,32]{1,0} select(Arg_0.195, Arg_1.196, broadcast.198)
}

_where.200 {
  Arg_0.201 = pred[32,32]{1,0} parameter(0)
  Arg_1.202 = f64[32,32]{1,0} parameter(1)
  Arg_2.203 = f64[] parameter(2)
  broadcast.204 = f64[32,32]{1,0} broadcast(Arg_2.203), dimensions={}
  ROOT select.205 = f64[32,32]{1,0} select(Arg_0.201, Arg_1.202, broadcast.204)
}

_where.206 {
  Arg_0.207 = pred[32,32]{1,0} parameter(0)
  Arg_1.208 = f64[32,32]{1,0} parameter(1)
  Arg_2.209 = f64[] parameter(2)
  broadcast.210 = f64[32,32]{1,0} broadcast(Arg_2.209), dimensions={}
  ROOT select.211 = f64[32,32]{1,0} select(Arg_0.207, Arg_1.208, broadcast.210)
}

_where.212 {
  Arg_0.213 = pred[32,32]{1,0} parameter(0)
  Arg_1.214 = f64[32,32]{1,0} parameter(1)
  Arg_2.215 = f64[] parameter(2)
  broadcast.216 = f64[32,32]{1,0} broadcast(Arg_2.215), dimensions={}
  ROOT select.217 = f64[32,32]{1,0} select(Arg_0.213, Arg_1.214, broadcast.216)
}

_where.218 {
  Arg_0.219 = pred[32,32]{1,0} parameter(0)
  Arg_1.220 = f64[32,32]{1,0} parameter(1)
  Arg_2.221 = f64[] parameter(2)
  broadcast.222 = f64[32,32]{1,0} broadcast(Arg_2.221), dimensions={}
  ROOT select.223 = f64[32,32]{1,0} select(Arg_0.219, Arg_1.220, broadcast.222)
}

_where.224 {
  Arg_0.225 = pred[32,32]{1,0} parameter(0)
  Arg_1.226 = f64[32,32]{1,0} parameter(1)
  Arg_2.227 = f64[] parameter(2)
  broadcast.228 = f64[32,32]{1,0} broadcast(Arg_2.227), dimensions={}
  ROOT select.229 = f64[32,32]{1,0} select(Arg_0.225, Arg_1.226, broadcast.228)
}

_where.230 {
  Arg_0.231 = pred[32,32]{1,0} parameter(0)
  Arg_1.232 = f64[32,32]{1,0} parameter(1)
  Arg_2.233 = f64[] parameter(2)
  broadcast.234 = f64[32,32]{1,0} broadcast(Arg_2.233), dimensions={}
  ROOT select.235 = f64[32,32]{1,0} select(Arg_0.231, Arg_1.232, broadcast.234)
}

_where.236 {
  Arg_0.237 = pred[32,32]{1,0} parameter(0)
  Arg_1.238 = f64[32,32]{1,0} parameter(1)
  Arg_2.239 = f64[] parameter(2)
  broadcast.240 = f64[32,32]{1,0} broadcast(Arg_2.239), dimensions={}
  ROOT select.241 = f64[32,32]{1,0} select(Arg_0.237, Arg_1.238, broadcast.240)
}

_where.242 {
  Arg_0.243 = pred[32,32]{1,0} parameter(0)
  Arg_1.244 = f64[32,32]{1,0} parameter(1)
  Arg_2.245 = f64[] parameter(2)
  broadcast.246 = f64[32,32]{1,0} broadcast(Arg_2.245), dimensions={}
  ROOT select.247 = f64[32,32]{1,0} select(Arg_0.243, Arg_1.244, broadcast.246)
}

_where.248 {
  Arg_0.249 = pred[32,32]{1,0} parameter(0)
  Arg_1.250 = f64[32,32]{1,0} parameter(1)
  Arg_2.251 = f64[] parameter(2)
  broadcast.252 = f64[32,32]{1,0} broadcast(Arg_2.251), dimensions={}
  ROOT select.253 = f64[32,32]{1,0} select(Arg_0.249, Arg_1.250, broadcast.252)
}

_where.254 {
  Arg_0.255 = pred[32,32]{1,0} parameter(0)
  Arg_1.256 = f64[32,32]{1,0} parameter(1)
  Arg_2.257 = f64[] parameter(2)
  broadcast.258 = f64[32,32]{1,0} broadcast(Arg_2.257), dimensions={}
  ROOT select.259 = f64[32,32]{1,0} select(Arg_0.255, Arg_1.256, broadcast.258)
}

_where.260 {
  Arg_0.261 = pred[32,32]{1,0} parameter(0)
  Arg_1.262 = f64[32,32]{1,0} parameter(1)
  Arg_2.263 = f64[] parameter(2)
  broadcast.264 = f64[32,32]{1,0} broadcast(Arg_2.263), dimensions={}
  ROOT select.265 = f64[32,32]{1,0} select(Arg_0.261, Arg_1.262, broadcast.264)
}

_where.266 {
  Arg_0.267 = pred[32,32]{1,0} parameter(0)
  Arg_1.268 = f64[32,32]{1,0} parameter(1)
  Arg_2.269 = f64[] parameter(2)
  broadcast.270 = f64[32,32]{1,0} broadcast(Arg_2.269), dimensions={}
  ROOT select.271 = f64[32,32]{1,0} select(Arg_0.267, Arg_1.268, broadcast.270)
}

_where.272 {
  Arg_0.273 = pred[32,32]{1,0} parameter(0)
  Arg_1.274 = f64[32,32]{1,0} parameter(1)
  Arg_2.275 = f64[] parameter(2)
  broadcast.276 = f64[32,32]{1,0} broadcast(Arg_2.275), dimensions={}
  ROOT select.277 = f64[32,32]{1,0} select(Arg_0.273, Arg_1.274, broadcast.276)
}

_where.278 {
  Arg_0.279 = pred[32,32]{1,0} parameter(0)
  Arg_1.280 = f64[32,32]{1,0} parameter(1)
  Arg_2.281 = f64[] parameter(2)
  broadcast.282 = f64[32,32]{1,0} broadcast(Arg_2.281), dimensions={}
  ROOT select.283 = f64[32,32]{1,0} select(Arg_0.279, Arg_1.280, broadcast.282)
}

_where.284 {
  Arg_0.285 = pred[32,32]{1,0} parameter(0)
  Arg_1.286 = f64[32,32]{1,0} parameter(1)
  Arg_2.287 = f64[] parameter(2)
  broadcast.288 = f64[32,32]{1,0} broadcast(Arg_2.287), dimensions={}
  ROOT select.289 = f64[32,32]{1,0} select(Arg_0.285, Arg_1.286, broadcast.288)
}

_where.290 {
  Arg_0.291 = pred[32,32]{1,0} parameter(0)
  Arg_1.292 = f64[32,32]{1,0} parameter(1)
  Arg_2.293 = f64[] parameter(2)
  broadcast.294 = f64[32,32]{1,0} broadcast(Arg_2.293), dimensions={}
  ROOT select.295 = f64[32,32]{1,0} select(Arg_0.291, Arg_1.292, broadcast.294)
}

_where.296 {
  Arg_0.297 = pred[32,32]{1,0} parameter(0)
  Arg_1.298 = f64[32,32]{1,0} parameter(1)
  Arg_2.299 = f64[] parameter(2)
  broadcast.300 = f64[32,32]{1,0} broadcast(Arg_2.299), dimensions={}
  ROOT select.301 = f64[32,32]{1,0} select(Arg_0.297, Arg_1.298, broadcast.300)
}

_where.302 {
  Arg_0.303 = pred[32,32]{1,0} parameter(0)
  Arg_1.304 = f64[32,32]{1,0} parameter(1)
  Arg_2.305 = f64[] parameter(2)
  broadcast.306 = f64[32,32]{1,0} broadcast(Arg_2.305), dimensions={}
  ROOT select.307 = f64[32,32]{1,0} select(Arg_0.303, Arg_1.304, broadcast.306)
}

_where.308 {
  Arg_0.309 = pred[32,32]{1,0} parameter(0)
  Arg_1.310 = f64[32,32]{1,0} parameter(1)
  Arg_2.311 = f64[] parameter(2)
  broadcast.312 = f64[32,32]{1,0} broadcast(Arg_2.311), dimensions={}
  ROOT select.313 = f64[32,32]{1,0} select(Arg_0.309, Arg_1.310, broadcast.312)
}

_where.314 {
  Arg_0.315 = pred[32,32]{1,0} parameter(0)
  Arg_1.316 = f64[32,32]{1,0} parameter(1)
  Arg_2.317 = f64[] parameter(2)
  broadcast.318 = f64[32,32]{1,0} broadcast(Arg_2.317), dimensions={}
  ROOT select.319 = f64[32,32]{1,0} select(Arg_0.315, Arg_1.316, broadcast.318)
}

_where.320 {
  Arg_0.321 = pred[32,32]{1,0} parameter(0)
  Arg_1.322 = f64[32,32]{1,0} parameter(1)
  Arg_2.323 = f64[] parameter(2)
  broadcast.324 = f64[32,32]{1,0} broadcast(Arg_2.323), dimensions={}
  ROOT select.325 = f64[32,32]{1,0} select(Arg_0.321, Arg_1.322, broadcast.324)
}

_where.326 {
  Arg_0.327 = pred[32,32]{1,0} parameter(0)
  Arg_1.328 = f64[32,32]{1,0} parameter(1)
  Arg_2.329 = f64[] parameter(2)
  broadcast.330 = f64[32,32]{1,0} broadcast(Arg_2.329), dimensions={}
  ROOT select.331 = f64[32,32]{1,0} select(Arg_0.327, Arg_1.328, broadcast.330)
}

_where.332 {
  Arg_0.333 = pred[32,32]{1,0} parameter(0)
  Arg_1.334 = f64[32,32]{1,0} parameter(1)
  Arg_2.335 = f64[] parameter(2)
  broadcast.336 = f64[32,32]{1,0} broadcast(Arg_2.335), dimensions={}
  ROOT select.337 = f64[32,32]{1,0} select(Arg_0.333, Arg_1.334, broadcast.336)
}

_where.338 {
  Arg_0.339 = pred[32,32]{1,0} parameter(0)
  Arg_1.340 = f64[32,32]{1,0} parameter(1)
  Arg_2.341 = f64[] parameter(2)
  broadcast.342 = f64[32,32]{1,0} broadcast(Arg_2.341), dimensions={}
  ROOT select.343 = f64[32,32]{1,0} select(Arg_0.339, Arg_1.340, broadcast.342)
}

_where.344 {
  Arg_0.345 = pred[32,32]{1,0} parameter(0)
  Arg_1.346 = f64[32,32]{1,0} parameter(1)
  Arg_2.347 = f64[] parameter(2)
  broadcast.348 = f64[32,32]{1,0} broadcast(Arg_2.347), dimensions={}
  ROOT select.349 = f64[32,32]{1,0} select(Arg_0.345, Arg_1.346, broadcast.348)
}

_where.350 {
  Arg_0.351 = pred[32,32]{1,0} parameter(0)
  Arg_1.352 = f64[32,32]{1,0} parameter(1)
  Arg_2.353 = f64[] parameter(2)
  broadcast.354 = f64[32,32]{1,0} broadcast(Arg_2.353), dimensions={}
  ROOT select.355 = f64[32,32]{1,0} select(Arg_0.351, Arg_1.352, broadcast.354)
}

_where.356 {
  Arg_0.357 = pred[32,32]{1,0} parameter(0)
  Arg_1.358 = f64[32,32]{1,0} parameter(1)
  Arg_2.359 = f64[] parameter(2)
  broadcast.360 = f64[32,32]{1,0} broadcast(Arg_2.359), dimensions={}
  ROOT select.361 = f64[32,32]{1,0} select(Arg_0.357, Arg_1.358, broadcast.360)
}

_where.362 {
  Arg_0.363 = pred[32,32]{1,0} parameter(0)
  Arg_1.364 = f64[32,32]{1,0} parameter(1)
  Arg_2.365 = f64[] parameter(2)
  broadcast.366 = f64[32,32]{1,0} broadcast(Arg_2.365), dimensions={}
  ROOT select.367 = f64[32,32]{1,0} select(Arg_0.363, Arg_1.364, broadcast.366)
}

_where.368 {
  Arg_0.369 = pred[32,32]{1,0} parameter(0)
  Arg_1.370 = f64[32,32]{1,0} parameter(1)
  Arg_2.371 = f64[] parameter(2)
  broadcast.372 = f64[32,32]{1,0} broadcast(Arg_2.371), dimensions={}
  ROOT select.373 = f64[32,32]{1,0} select(Arg_0.369, Arg_1.370, broadcast.372)
}

_where.374 {
  Arg_0.375 = pred[32,32]{1,0} parameter(0)
  Arg_1.376 = f64[32,32]{1,0} parameter(1)
  Arg_2.377 = f64[] parameter(2)
  broadcast.378 = f64[32,32]{1,0} broadcast(Arg_2.377), dimensions={}
  ROOT select.379 = f64[32,32]{1,0} select(Arg_0.375, Arg_1.376, broadcast.378)
}

_where.380 {
  Arg_0.381 = pred[32,32]{1,0} parameter(0)
  Arg_1.382 = f64[32,32]{1,0} parameter(1)
  Arg_2.383 = f64[] parameter(2)
  broadcast.384 = f64[32,32]{1,0} broadcast(Arg_2.383), dimensions={}
  ROOT select.385 = f64[32,32]{1,0} select(Arg_0.381, Arg_1.382, broadcast.384)
}

_where.386 {
  Arg_0.387 = pred[32,32]{1,0} parameter(0)
  Arg_1.388 = f64[32,32]{1,0} parameter(1)
  Arg_2.389 = f64[] parameter(2)
  broadcast.390 = f64[32,32]{1,0} broadcast(Arg_2.389), dimensions={}
  ROOT select.391 = f64[32,32]{1,0} select(Arg_0.387, Arg_1.388, broadcast.390)
}

_pad.392 {
  Arg_0.393 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  Arg_1.394 = s64[] parameter(1)
  convert.395 = f64[] convert(Arg_1.394)
  ROOT pad.396 = f64[32,32,38,32]{3,2,1,0} pad(Arg_0.393, convert.395), padding=0_0x0_0x3_3x0_0
}

_where.397 {
  Arg_0.398 = pred[32,32]{1,0} parameter(0)
  Arg_1.399 = f64[32,32]{1,0} parameter(1)
  Arg_2.400 = f64[] parameter(2)
  broadcast.401 = f64[32,32]{1,0} broadcast(Arg_2.400), dimensions={}
  ROOT select.402 = f64[32,32]{1,0} select(Arg_0.398, Arg_1.399, broadcast.401)
}

_where.403 {
  Arg_0.404 = pred[32,32]{1,0} parameter(0)
  Arg_1.405 = f64[32,32]{1,0} parameter(1)
  Arg_2.406 = f64[] parameter(2)
  broadcast.407 = f64[32,32]{1,0} broadcast(Arg_2.406), dimensions={}
  ROOT select.408 = f64[32,32]{1,0} select(Arg_0.404, Arg_1.405, broadcast.407)
}

_where.409 {
  Arg_0.410 = pred[32,32]{1,0} parameter(0)
  Arg_1.411 = f64[32,32]{1,0} parameter(1)
  Arg_2.412 = f64[] parameter(2)
  broadcast.413 = f64[32,32]{1,0} broadcast(Arg_2.412), dimensions={}
  ROOT select.414 = f64[32,32]{1,0} select(Arg_0.410, Arg_1.411, broadcast.413)
}

_where.415 {
  Arg_0.416 = pred[32,32]{1,0} parameter(0)
  Arg_1.417 = f64[32,32]{1,0} parameter(1)
  Arg_2.418 = f64[] parameter(2)
  broadcast.419 = f64[32,32]{1,0} broadcast(Arg_2.418), dimensions={}
  ROOT select.420 = f64[32,32]{1,0} select(Arg_0.416, Arg_1.417, broadcast.419)
}

_where.421 {
  Arg_0.422 = pred[32,32]{1,0} parameter(0)
  Arg_1.423 = f64[32,32]{1,0} parameter(1)
  Arg_2.424 = f64[] parameter(2)
  broadcast.425 = f64[32,32]{1,0} broadcast(Arg_2.424), dimensions={}
  ROOT select.426 = f64[32,32]{1,0} select(Arg_0.422, Arg_1.423, broadcast.425)
}

_where.427 {
  Arg_0.428 = pred[32,32]{1,0} parameter(0)
  Arg_1.429 = f64[32,32]{1,0} parameter(1)
  Arg_2.430 = f64[] parameter(2)
  broadcast.431 = f64[32,32]{1,0} broadcast(Arg_2.430), dimensions={}
  ROOT select.432 = f64[32,32]{1,0} select(Arg_0.428, Arg_1.429, broadcast.431)
}

_where.433 {
  Arg_0.434 = pred[32,32]{1,0} parameter(0)
  Arg_1.435 = f64[32,32]{1,0} parameter(1)
  Arg_2.436 = f64[] parameter(2)
  broadcast.437 = f64[32,32]{1,0} broadcast(Arg_2.436), dimensions={}
  ROOT select.438 = f64[32,32]{1,0} select(Arg_0.434, Arg_1.435, broadcast.437)
}

_where.439 {
  Arg_0.440 = pred[32,32]{1,0} parameter(0)
  Arg_1.441 = f64[32,32]{1,0} parameter(1)
  Arg_2.442 = f64[] parameter(2)
  broadcast.443 = f64[32,32]{1,0} broadcast(Arg_2.442), dimensions={}
  ROOT select.444 = f64[32,32]{1,0} select(Arg_0.440, Arg_1.441, broadcast.443)
}

_where.445 {
  Arg_0.446 = pred[32,32]{1,0} parameter(0)
  Arg_1.447 = f64[32,32]{1,0} parameter(1)
  Arg_2.448 = f64[] parameter(2)
  broadcast.449 = f64[32,32]{1,0} broadcast(Arg_2.448), dimensions={}
  ROOT select.450 = f64[32,32]{1,0} select(Arg_0.446, Arg_1.447, broadcast.449)
}

_where.451 {
  Arg_0.452 = pred[32,32]{1,0} parameter(0)
  Arg_1.453 = f64[32,32]{1,0} parameter(1)
  Arg_2.454 = f64[] parameter(2)
  broadcast.455 = f64[32,32]{1,0} broadcast(Arg_2.454), dimensions={}
  ROOT select.456 = f64[32,32]{1,0} select(Arg_0.452, Arg_1.453, broadcast.455)
}

_where.457 {
  Arg_0.458 = pred[32,32]{1,0} parameter(0)
  Arg_1.459 = f64[32,32]{1,0} parameter(1)
  Arg_2.460 = f64[] parameter(2)
  broadcast.461 = f64[32,32]{1,0} broadcast(Arg_2.460), dimensions={}
  ROOT select.462 = f64[32,32]{1,0} select(Arg_0.458, Arg_1.459, broadcast.461)
}

_where.463 {
  Arg_0.464 = pred[32,32]{1,0} parameter(0)
  Arg_1.465 = f64[32,32]{1,0} parameter(1)
  Arg_2.466 = f64[] parameter(2)
  broadcast.467 = f64[32,32]{1,0} broadcast(Arg_2.466), dimensions={}
  ROOT select.468 = f64[32,32]{1,0} select(Arg_0.464, Arg_1.465, broadcast.467)
}

_where.469 {
  Arg_0.470 = pred[32,32]{1,0} parameter(0)
  Arg_1.471 = f64[32,32]{1,0} parameter(1)
  Arg_2.472 = f64[] parameter(2)
  broadcast.473 = f64[32,32]{1,0} broadcast(Arg_2.472), dimensions={}
  ROOT select.474 = f64[32,32]{1,0} select(Arg_0.470, Arg_1.471, broadcast.473)
}

_where.475 {
  Arg_0.476 = pred[32,32]{1,0} parameter(0)
  Arg_1.477 = f64[32,32]{1,0} parameter(1)
  Arg_2.478 = f64[] parameter(2)
  broadcast.479 = f64[32,32]{1,0} broadcast(Arg_2.478), dimensions={}
  ROOT select.480 = f64[32,32]{1,0} select(Arg_0.476, Arg_1.477, broadcast.479)
}

_where.481 {
  Arg_0.482 = pred[32,32]{1,0} parameter(0)
  Arg_1.483 = f64[32,32]{1,0} parameter(1)
  Arg_2.484 = f64[] parameter(2)
  broadcast.485 = f64[32,32]{1,0} broadcast(Arg_2.484), dimensions={}
  ROOT select.486 = f64[32,32]{1,0} select(Arg_0.482, Arg_1.483, broadcast.485)
}

_where.487 {
  Arg_0.488 = pred[32,32]{1,0} parameter(0)
  Arg_1.489 = f64[32,32]{1,0} parameter(1)
  Arg_2.490 = f64[] parameter(2)
  broadcast.491 = f64[32,32]{1,0} broadcast(Arg_2.490), dimensions={}
  ROOT select.492 = f64[32,32]{1,0} select(Arg_0.488, Arg_1.489, broadcast.491)
}

_where.493 {
  Arg_0.494 = pred[32,32]{1,0} parameter(0)
  Arg_1.495 = f64[32,32]{1,0} parameter(1)
  Arg_2.496 = f64[] parameter(2)
  broadcast.497 = f64[32,32]{1,0} broadcast(Arg_2.496), dimensions={}
  ROOT select.498 = f64[32,32]{1,0} select(Arg_0.494, Arg_1.495, broadcast.497)
}

_where.499 {
  Arg_0.500 = pred[32,32]{1,0} parameter(0)
  Arg_1.501 = f64[32,32]{1,0} parameter(1)
  Arg_2.502 = f64[] parameter(2)
  broadcast.503 = f64[32,32]{1,0} broadcast(Arg_2.502), dimensions={}
  ROOT select.504 = f64[32,32]{1,0} select(Arg_0.500, Arg_1.501, broadcast.503)
}

_where.505 {
  Arg_0.506 = pred[32,32]{1,0} parameter(0)
  Arg_1.507 = f64[32,32]{1,0} parameter(1)
  Arg_2.508 = f64[] parameter(2)
  broadcast.509 = f64[32,32]{1,0} broadcast(Arg_2.508), dimensions={}
  ROOT select.510 = f64[32,32]{1,0} select(Arg_0.506, Arg_1.507, broadcast.509)
}

_where.511 {
  Arg_0.512 = pred[32,32]{1,0} parameter(0)
  Arg_1.513 = f64[32,32]{1,0} parameter(1)
  Arg_2.514 = f64[] parameter(2)
  broadcast.515 = f64[32,32]{1,0} broadcast(Arg_2.514), dimensions={}
  ROOT select.516 = f64[32,32]{1,0} select(Arg_0.512, Arg_1.513, broadcast.515)
}

_where.517 {
  Arg_0.518 = pred[32,32]{1,0} parameter(0)
  Arg_1.519 = f64[32,32]{1,0} parameter(1)
  Arg_2.520 = f64[] parameter(2)
  broadcast.521 = f64[32,32]{1,0} broadcast(Arg_2.520), dimensions={}
  ROOT select.522 = f64[32,32]{1,0} select(Arg_0.518, Arg_1.519, broadcast.521)
}

_where.523 {
  Arg_0.524 = pred[32,32]{1,0} parameter(0)
  Arg_1.525 = f64[32,32]{1,0} parameter(1)
  Arg_2.526 = f64[] parameter(2)
  broadcast.527 = f64[32,32]{1,0} broadcast(Arg_2.526), dimensions={}
  ROOT select.528 = f64[32,32]{1,0} select(Arg_0.524, Arg_1.525, broadcast.527)
}

_where.529 {
  Arg_0.530 = pred[32,32]{1,0} parameter(0)
  Arg_1.531 = f64[32,32]{1,0} parameter(1)
  Arg_2.532 = f64[] parameter(2)
  broadcast.533 = f64[32,32]{1,0} broadcast(Arg_2.532), dimensions={}
  ROOT select.534 = f64[32,32]{1,0} select(Arg_0.530, Arg_1.531, broadcast.533)
}

_where.535 {
  Arg_0.536 = pred[32,32]{1,0} parameter(0)
  Arg_1.537 = f64[32,32]{1,0} parameter(1)
  Arg_2.538 = f64[] parameter(2)
  broadcast.539 = f64[32,32]{1,0} broadcast(Arg_2.538), dimensions={}
  ROOT select.540 = f64[32,32]{1,0} select(Arg_0.536, Arg_1.537, broadcast.539)
}

_where.541 {
  Arg_0.542 = pred[32,32]{1,0} parameter(0)
  Arg_1.543 = f64[32,32]{1,0} parameter(1)
  Arg_2.544 = f64[] parameter(2)
  broadcast.545 = f64[32,32]{1,0} broadcast(Arg_2.544), dimensions={}
  ROOT select.546 = f64[32,32]{1,0} select(Arg_0.542, Arg_1.543, broadcast.545)
}

_where.547 {
  Arg_0.548 = pred[32,32]{1,0} parameter(0)
  Arg_1.549 = f64[32,32]{1,0} parameter(1)
  Arg_2.550 = f64[] parameter(2)
  broadcast.551 = f64[32,32]{1,0} broadcast(Arg_2.550), dimensions={}
  ROOT select.552 = f64[32,32]{1,0} select(Arg_0.548, Arg_1.549, broadcast.551)
}

_where.553 {
  Arg_0.554 = pred[32,32]{1,0} parameter(0)
  Arg_1.555 = f64[32,32]{1,0} parameter(1)
  Arg_2.556 = f64[] parameter(2)
  broadcast.557 = f64[32,32]{1,0} broadcast(Arg_2.556), dimensions={}
  ROOT select.558 = f64[32,32]{1,0} select(Arg_0.554, Arg_1.555, broadcast.557)
}

_where.559 {
  Arg_0.560 = pred[32,32]{1,0} parameter(0)
  Arg_1.561 = f64[32,32]{1,0} parameter(1)
  Arg_2.562 = f64[] parameter(2)
  broadcast.563 = f64[32,32]{1,0} broadcast(Arg_2.562), dimensions={}
  ROOT select.564 = f64[32,32]{1,0} select(Arg_0.560, Arg_1.561, broadcast.563)
}

_where.565 {
  Arg_0.566 = pred[32,32]{1,0} parameter(0)
  Arg_1.567 = f64[32,32]{1,0} parameter(1)
  Arg_2.568 = f64[] parameter(2)
  broadcast.569 = f64[32,32]{1,0} broadcast(Arg_2.568), dimensions={}
  ROOT select.570 = f64[32,32]{1,0} select(Arg_0.566, Arg_1.567, broadcast.569)
}

_where.571 {
  Arg_0.572 = pred[32,32]{1,0} parameter(0)
  Arg_1.573 = f64[32,32]{1,0} parameter(1)
  Arg_2.574 = f64[] parameter(2)
  broadcast.575 = f64[32,32]{1,0} broadcast(Arg_2.574), dimensions={}
  ROOT select.576 = f64[32,32]{1,0} select(Arg_0.572, Arg_1.573, broadcast.575)
}

_where.577 {
  Arg_0.578 = pred[32,32]{1,0} parameter(0)
  Arg_1.579 = f64[32,32]{1,0} parameter(1)
  Arg_2.580 = f64[] parameter(2)
  broadcast.581 = f64[32,32]{1,0} broadcast(Arg_2.580), dimensions={}
  ROOT select.582 = f64[32,32]{1,0} select(Arg_0.578, Arg_1.579, broadcast.581)
}

_where.583 {
  Arg_0.584 = pred[32,32]{1,0} parameter(0)
  Arg_1.585 = f64[32,32]{1,0} parameter(1)
  Arg_2.586 = f64[] parameter(2)
  broadcast.587 = f64[32,32]{1,0} broadcast(Arg_2.586), dimensions={}
  ROOT select.588 = f64[32,32]{1,0} select(Arg_0.584, Arg_1.585, broadcast.587)
}

_where.589 {
  Arg_0.590 = pred[32,32]{1,0} parameter(0)
  Arg_1.591 = f64[32,32]{1,0} parameter(1)
  Arg_2.592 = f64[] parameter(2)
  broadcast.593 = f64[32,32]{1,0} broadcast(Arg_2.592), dimensions={}
  ROOT select.594 = f64[32,32]{1,0} select(Arg_0.590, Arg_1.591, broadcast.593)
}

_where.595 {
  Arg_0.596 = pred[32,32]{1,0} parameter(0)
  Arg_1.597 = f64[32,32]{1,0} parameter(1)
  Arg_2.598 = f64[] parameter(2)
  broadcast.599 = f64[32,32]{1,0} broadcast(Arg_2.598), dimensions={}
  ROOT select.600 = f64[32,32]{1,0} select(Arg_0.596, Arg_1.597, broadcast.599)
}

_where.601 {
  Arg_0.602 = pred[32,32]{1,0} parameter(0)
  Arg_1.603 = f64[32,32]{1,0} parameter(1)
  Arg_2.604 = f64[] parameter(2)
  broadcast.605 = f64[32,32]{1,0} broadcast(Arg_2.604), dimensions={}
  ROOT select.606 = f64[32,32]{1,0} select(Arg_0.602, Arg_1.603, broadcast.605)
}

_where.607 {
  Arg_0.608 = pred[32,32]{1,0} parameter(0)
  Arg_1.609 = f64[32,32]{1,0} parameter(1)
  Arg_2.610 = f64[] parameter(2)
  broadcast.611 = f64[32,32]{1,0} broadcast(Arg_2.610), dimensions={}
  ROOT select.612 = f64[32,32]{1,0} select(Arg_0.608, Arg_1.609, broadcast.611)
}

_where.613 {
  Arg_0.614 = pred[32,32]{1,0} parameter(0)
  Arg_1.615 = f64[32,32]{1,0} parameter(1)
  Arg_2.616 = f64[] parameter(2)
  broadcast.617 = f64[32,32]{1,0} broadcast(Arg_2.616), dimensions={}
  ROOT select.618 = f64[32,32]{1,0} select(Arg_0.614, Arg_1.615, broadcast.617)
}

_where.619 {
  Arg_0.620 = pred[32,32]{1,0} parameter(0)
  Arg_1.621 = f64[32,32]{1,0} parameter(1)
  Arg_2.622 = f64[] parameter(2)
  broadcast.623 = f64[32,32]{1,0} broadcast(Arg_2.622), dimensions={}
  ROOT select.624 = f64[32,32]{1,0} select(Arg_0.620, Arg_1.621, broadcast.623)
}

_where.625 {
  Arg_0.626 = pred[32,32]{1,0} parameter(0)
  Arg_1.627 = f64[32,32]{1,0} parameter(1)
  Arg_2.628 = f64[] parameter(2)
  broadcast.629 = f64[32,32]{1,0} broadcast(Arg_2.628), dimensions={}
  ROOT select.630 = f64[32,32]{1,0} select(Arg_0.626, Arg_1.627, broadcast.629)
}

_where.631 {
  Arg_0.632 = pred[32,32]{1,0} parameter(0)
  Arg_1.633 = f64[32,32]{1,0} parameter(1)
  Arg_2.634 = f64[] parameter(2)
  broadcast.635 = f64[32,32]{1,0} broadcast(Arg_2.634), dimensions={}
  ROOT select.636 = f64[32,32]{1,0} select(Arg_0.632, Arg_1.633, broadcast.635)
}

_where.637 {
  Arg_0.638 = pred[32,32]{1,0} parameter(0)
  Arg_1.639 = f64[32,32]{1,0} parameter(1)
  Arg_2.640 = f64[] parameter(2)
  broadcast.641 = f64[32,32]{1,0} broadcast(Arg_2.640), dimensions={}
  ROOT select.642 = f64[32,32]{1,0} select(Arg_0.638, Arg_1.639, broadcast.641)
}

_where.643 {
  Arg_0.644 = pred[32,32]{1,0} parameter(0)
  Arg_1.645 = f64[32,32]{1,0} parameter(1)
  Arg_2.646 = f64[] parameter(2)
  broadcast.647 = f64[32,32]{1,0} broadcast(Arg_2.646), dimensions={}
  ROOT select.648 = f64[32,32]{1,0} select(Arg_0.644, Arg_1.645, broadcast.647)
}

_pad_16.649 {
  Arg_0.650 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  Arg_1.651 = s64[] parameter(1)
  convert.652 = f64[] convert(Arg_1.651)
  ROOT pad.653 = f64[32,32,32,38]{3,2,1,0} pad(Arg_0.650, convert.652), padding=0_0x0_0x0_0x3_3
}

_roll_static_7.654 {
  Arg_0.655 = f64[32,32,32,16]{3,2,1,0} parameter(0)
  slice.656 = f64[32,31,32,16]{3,2,1,0} slice(Arg_0.655), slice={[0:32], [1:32], [0:32], [0:16]}
  slice.657 = f64[32,1,32,16]{3,2,1,0} slice(Arg_0.655), slice={[0:32], [0:1], [0:32], [0:16]}
  ROOT concatenate.658 = f64[32,32,32,16]{3,2,1,0} concatenate(slice.656, slice.657), dimensions={1}
}

_roll_static_8.659 {
  ROOT Arg_0.660 = f64[32,32,32,16]{3,2,1,0} parameter(0)
}

_roll_static_9.661 {
  Arg_0.662 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.663 = f64[32,30,32,32]{3,2,1,0} slice(Arg_0.662), slice={[0:32], [2:32], [0:32], [0:32]}
  slice.664 = f64[32,2,32,32]{3,2,1,0} slice(Arg_0.662), slice={[0:32], [0:2], [0:32], [0:32]}
  ROOT concatenate.665 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.663, slice.664), dimensions={1}
}

_roll_static_10.666 {
  Arg_0.667 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.668 = f64[32,31,32,32]{3,2,1,0} slice(Arg_0.667), slice={[0:32], [1:32], [0:32], [0:32]}
  slice.669 = f64[32,1,32,32]{3,2,1,0} slice(Arg_0.667), slice={[0:32], [0:1], [0:32], [0:32]}
  ROOT concatenate.670 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.668, slice.669), dimensions={1}
}

_roll_static_11.671 {
  ROOT Arg_0.672 = f64[32,32,32,32]{3,2,1,0} parameter(0)
}

_roll_static_12.673 {
  Arg_0.674 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.675 = f64[32,1,32,32]{3,2,1,0} slice(Arg_0.674), slice={[0:32], [31:32], [0:32], [0:32]}
  slice.676 = f64[32,31,32,32]{3,2,1,0} slice(Arg_0.674), slice={[0:32], [0:31], [0:32], [0:32]}
  ROOT concatenate.677 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.675, slice.676), dimensions={1}
}

_roll_static_13.678 {
  Arg_0.679 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.680 = f64[32,2,32,32]{3,2,1,0} slice(Arg_0.679), slice={[0:32], [30:32], [0:32], [0:32]}
  slice.681 = f64[32,30,32,32]{3,2,1,0} slice(Arg_0.679), slice={[0:32], [0:30], [0:32], [0:32]}
  ROOT concatenate.682 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.680, slice.681), dimensions={1}
}

_roll_static_14.683 {
  Arg_0.684 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.685 = f64[32,3,32,32]{3,2,1,0} slice(Arg_0.684), slice={[0:32], [29:32], [0:32], [0:32]}
  slice.686 = f64[32,29,32,32]{3,2,1,0} slice(Arg_0.684), slice={[0:32], [0:29], [0:32], [0:32]}
  ROOT concatenate.687 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.685, slice.686), dimensions={1}
}

_roll_static.688 {
  Arg_0.689 = f64[32,32,16,32]{3,2,1,0} parameter(0)
  slice.690 = f64[31,32,16,32]{3,2,1,0} slice(Arg_0.689), slice={[1:32], [0:32], [0:16], [0:32]}
  slice.691 = f64[1,32,16,32]{3,2,1,0} slice(Arg_0.689), slice={[0:1], [0:32], [0:16], [0:32]}
  ROOT concatenate.692 = f64[32,32,16,32]{3,2,1,0} concatenate(slice.690, slice.691), dimensions={0}
}

_roll_static_0.693 {
  ROOT Arg_0.694 = f64[32,32,16,32]{3,2,1,0} parameter(0)
}

_roll_static_1.695 {
  Arg_0.696 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.697 = f64[30,32,32,32]{3,2,1,0} slice(Arg_0.696), slice={[2:32], [0:32], [0:32], [0:32]}
  slice.698 = f64[2,32,32,32]{3,2,1,0} slice(Arg_0.696), slice={[0:2], [0:32], [0:32], [0:32]}
  ROOT concatenate.699 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.697, slice.698), dimensions={0}
}

_roll_static_2.700 {
  Arg_0.701 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.702 = f64[31,32,32,32]{3,2,1,0} slice(Arg_0.701), slice={[1:32], [0:32], [0:32], [0:32]}
  slice.703 = f64[1,32,32,32]{3,2,1,0} slice(Arg_0.701), slice={[0:1], [0:32], [0:32], [0:32]}
  ROOT concatenate.704 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.702, slice.703), dimensions={0}
}

_roll_static_3.705 {
  ROOT Arg_0.706 = f64[32,32,32,32]{3,2,1,0} parameter(0)
}

_roll_static_4.707 {
  Arg_0.708 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.709 = f64[1,32,32,32]{3,2,1,0} slice(Arg_0.708), slice={[31:32], [0:32], [0:32], [0:32]}
  slice.710 = f64[31,32,32,32]{3,2,1,0} slice(Arg_0.708), slice={[0:31], [0:32], [0:32], [0:32]}
  ROOT concatenate.711 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.709, slice.710), dimensions={0}
}

_roll_static_5.712 {
  Arg_0.713 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.714 = f64[2,32,32,32]{3,2,1,0} slice(Arg_0.713), slice={[30:32], [0:32], [0:32], [0:32]}
  slice.715 = f64[30,32,32,32]{3,2,1,0} slice(Arg_0.713), slice={[0:30], [0:32], [0:32], [0:32]}
  ROOT concatenate.716 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.714, slice.715), dimensions={0}
}

_roll_static_6.717 {
  Arg_0.718 = f64[32,32,32,32]{3,2,1,0} parameter(0)
  slice.719 = f64[3,32,32,32]{3,2,1,0} slice(Arg_0.718), slice={[29:32], [0:32], [0:32], [0:32]}
  slice.720 = f64[29,32,32,32]{3,2,1,0} slice(Arg_0.718), slice={[0:29], [0:32], [0:32], [0:32]}
  ROOT concatenate.721 = f64[32,32,32,32]{3,2,1,0} concatenate(slice.719, slice.720), dimensions={0}
}

None.722 {
  Arg_6.729 = f64[32,32]{1,0} parameter(6)
  Arg_7.730 = f64[32,32]{1,0} parameter(7)
  Arg_5.728 = f64[32,32,32,32]{3,2,1,0} parameter(5)
  slice.934 = f64[32,32,16,32]{3,2,1,0} slice(Arg_5.728), slice={[0:32], [0:32], [0:16], [0:32]}
  call.935 = f64[32,32,16,32]{3,2,1,0} call(slice.934), to_apply=_roll_static.17
  slice.936 = f64[32,32,16,32]{3,2,1,0} slice(Arg_5.728), slice={[0:32], [0:32], [16:32], [0:32]}
  call.937 = f64[32,32,16,32]{3,2,1,0} call(slice.936), to_apply=_roll_static_0.22
  concatenate.938 = f64[32,32,32,32]{3,2,1,0} concatenate(call.935, call.937), dimensions={2}
  call.939 = f64[32,32,32,32]{3,2,1,0} call(concatenate.938), to_apply=_roll_static_1.24
  Arg_0.723 = f64[32]{0} parameter(0)
  constant.805 = f64[] constant(20)
  broadcast.806 = f64[32]{0} broadcast(constant.805), dimensions={}
  divide.814 = f64[32]{0} divide(Arg_0.723, broadcast.806)
  multiply.810 = f64[32]{0} multiply(Arg_0.723, Arg_0.723)
  constant.803 = f64[] constant(24)
  broadcast.804 = f64[32]{0} broadcast(constant.803), dimensions={}
  divide.815 = f64[32]{0} divide(multiply.810, broadcast.804)
  subtract.816 = f64[32]{0} subtract(divide.814, divide.815)
  multiply.811 = f64[32]{0} multiply(multiply.810, Arg_0.723)
  divide.817 = f64[32]{0} divide(multiply.811, broadcast.804)
  subtract.818 = f64[32]{0} subtract(subtract.816, divide.817)
  multiply.812 = f64[32]{0} multiply(multiply.811, Arg_0.723)
  divide.819 = f64[32]{0} divide(multiply.812, broadcast.804)
  add.820 = f64[32]{0} add(subtract.818, divide.819)
  multiply.813 = f64[32]{0} multiply(multiply.812, Arg_0.723)
  constant.801 = f64[] constant(120)
  broadcast.802 = f64[32]{0} broadcast(constant.801), dimensions={}
  divide.821 = f64[32]{0} divide(multiply.813, broadcast.802)
  subtract.822 = f64[32]{0} subtract(add.820, divide.821)
  reshape.940 = f64[1,1,32,1]{3,2,1,0} reshape(subtract.822)
  broadcast.941 = f64[1,1,32,1]{3,2,1,0} broadcast(reshape.940), dimensions={0,1,2,3}
  reshape.942 = f64[32]{0} reshape(broadcast.941)
  broadcast.943 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.942), dimensions={2}
  multiply.944 = f64[32,32,32,32]{3,2,1,0} multiply(call.939, broadcast.943)
  call.945 = f64[32,32,32,32]{3,2,1,0} call(concatenate.938), to_apply=_roll_static_2.29
  constant.799 = f64[] constant(2)
  broadcast.800 = f64[32]{0} broadcast(constant.799), dimensions={}
  divide.823 = f64[32]{0} divide(Arg_0.723, broadcast.800)
  negate.824 = f64[32]{0} negate(divide.823)
  multiply.825 = f64[32]{0} multiply(multiply.810, broadcast.800)
  constant.797 = f64[] constant(3)
  broadcast.798 = f64[32]{0} broadcast(constant.797), dimensions={}
  divide.826 = f64[32]{0} divide(multiply.825, broadcast.798)
  add.827 = f64[32]{0} add(negate.824, divide.826)
  divide.828 = f64[32]{0} divide(multiply.811, broadcast.804)
  subtract.829 = f64[32]{0} subtract(add.827, divide.828)
  constant.795 = f64[] constant(6)
  broadcast.796 = f64[32]{0} broadcast(constant.795), dimensions={}
  divide.830 = f64[32]{0} divide(multiply.812, broadcast.796)
  subtract.831 = f64[32]{0} subtract(subtract.829, divide.830)
  divide.832 = f64[32]{0} divide(multiply.813, broadcast.804)
  add.833 = f64[32]{0} add(subtract.831, divide.832)
  reshape.946 = f64[1,1,32,1]{3,2,1,0} reshape(add.833)
  broadcast.947 = f64[1,1,32,1]{3,2,1,0} broadcast(reshape.946), dimensions={0,1,2,3}
  reshape.948 = f64[32]{0} reshape(broadcast.947)
  broadcast.949 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.948), dimensions={2}
  multiply.950 = f64[32,32,32,32]{3,2,1,0} multiply(call.945, broadcast.949)
  add.951 = f64[32,32,32,32]{3,2,1,0} add(multiply.944, multiply.950)
  call.952 = f64[32,32,32,32]{3,2,1,0} call(concatenate.938), to_apply=_roll_static_3.34
  constant.793 = f64[] constant(1)
  broadcast.794 = f64[32]{0} broadcast(constant.793), dimensions={}
  divide.834 = f64[32]{0} divide(Arg_0.723, broadcast.798)
  subtract.835 = f64[32]{0} subtract(broadcast.794, divide.834)
  constant.791 = f64[] constant(5)
  broadcast.792 = f64[32]{0} broadcast(constant.791), dimensions={}
  multiply.836 = f64[32]{0} multiply(multiply.810, broadcast.792)
  constant.789 = f64[] constant(4)
  broadcast.790 = f64[32]{0} broadcast(constant.789), dimensions={}
  divide.837 = f64[32]{0} divide(multiply.836, broadcast.790)
  subtract.838 = f64[32]{0} subtract(subtract.835, divide.837)
  multiply.839 = f64[32]{0} multiply(multiply.811, broadcast.792)
  constant.787 = f64[] constant(12)
  broadcast.788 = f64[32]{0} broadcast(constant.787), dimensions={}
  divide.840 = f64[32]{0} divide(multiply.839, broadcast.788)
  add.841 = f64[32]{0} add(subtract.838, divide.840)
  divide.842 = f64[32]{0} divide(multiply.812, broadcast.790)
  add.843 = f64[32]{0} add(add.841, divide.842)
  divide.844 = f64[32]{0} divide(multiply.813, broadcast.788)
  subtract.845 = f64[32]{0} subtract(add.843, divide.844)
  reshape.953 = f64[1,1,32,1]{3,2,1,0} reshape(subtract.845)
  broadcast.954 = f64[1,1,32,1]{3,2,1,0} broadcast(reshape.953), dimensions={0,1,2,3}
  reshape.955 = f64[32]{0} reshape(broadcast.954)
  broadcast.956 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.955), dimensions={2}
  multiply.957 = f64[32,32,32,32]{3,2,1,0} multiply(call.952, broadcast.956)
  add.958 = f64[32,32,32,32]{3,2,1,0} add(add.951, multiply.957)
  call.959 = f64[32,32,32,32]{3,2,1,0} call(concatenate.938), to_apply=_roll_static_4.36
  multiply.846 = f64[32]{0} multiply(multiply.810, broadcast.800)
  divide.847 = f64[32]{0} divide(multiply.846, broadcast.798)
  add.848 = f64[32]{0} add(Arg_0.723, divide.847)
  constant.785 = f64[] constant(7)
  broadcast.786 = f64[32]{0} broadcast(constant.785), dimensions={}
  multiply.849 = f64[32]{0} multiply(multiply.811, broadcast.786)
  divide.850 = f64[32]{0} divide(multiply.849, broadcast.788)
  subtract.851 = f64[32]{0} subtract(add.848, divide.850)
  divide.852 = f64[32]{0} divide(multiply.812, broadcast.796)
  subtract.853 = f64[32]{0} subtract(subtract.851, divide.852)
  divide.854 = f64[32]{0} divide(multiply.813, broadcast.788)
  add.855 = f64[32]{0} add(subtract.853, divide.854)
  reshape.960 = f64[1,1,32,1]{3,2,1,0} reshape(add.855)
  broadcast.961 = f64[1,1,32,1]{3,2,1,0} broadcast(reshape.960), dimensions={0,1,2,3}
  reshape.962 = f64[32]{0} reshape(broadcast.961)
  broadcast.963 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.962), dimensions={2}
  multiply.964 = f64[32,32,32,32]{3,2,1,0} multiply(call.959, broadcast.963)
  add.965 = f64[32,32,32,32]{3,2,1,0} add(add.958, multiply.964)
  call.966 = f64[32,32,32,32]{3,2,1,0} call(concatenate.938), to_apply=_roll_static_5.41
  divide.856 = f64[32]{0} divide(Arg_0.723, broadcast.790)
  negate.857 = f64[32]{0} negate(divide.856)
  divide.858 = f64[32]{0} divide(multiply.810, broadcast.804)
  subtract.859 = f64[32]{0} subtract(negate.857, divide.858)
  multiply.860 = f64[32]{0} multiply(multiply.811, broadcast.786)
  divide.861 = f64[32]{0} divide(multiply.860, broadcast.804)
  add.862 = f64[32]{0} add(subtract.859, divide.861)
  divide.863 = f64[32]{0} divide(multiply.812, broadcast.804)
  add.864 = f64[32]{0} add(add.862, divide.863)
  divide.865 = f64[32]{0} divide(multiply.813, broadcast.804)
  subtract.866 = f64[32]{0} subtract(add.864, divide.865)
  reshape.967 = f64[1,1,32,1]{3,2,1,0} reshape(subtract.866)
  broadcast.968 = f64[1,1,32,1]{3,2,1,0} broadcast(reshape.967), dimensions={0,1,2,3}
  reshape.969 = f64[32]{0} reshape(broadcast.968)
  broadcast.970 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.969), dimensions={2}
  multiply.971 = f64[32,32,32,32]{3,2,1,0} multiply(call.966, broadcast.970)
  add.972 = f64[32,32,32,32]{3,2,1,0} add(add.965, multiply.971)
  call.973 = f64[32,32,32,32]{3,2,1,0} call(concatenate.938), to_apply=_roll_static_6.46
  constant.783 = f64[] constant(30)
  broadcast.784 = f64[32]{0} broadcast(constant.783), dimensions={}
  divide.867 = f64[32]{0} divide(Arg_0.723, broadcast.784)
  divide.868 = f64[32]{0} divide(multiply.811, broadcast.804)
  subtract.869 = f64[32]{0} subtract(divide.867, divide.868)
  divide.870 = f64[32]{0} divide(multiply.813, broadcast.802)
  add.871 = f64[32]{0} add(subtract.869, divide.870)
  reshape.974 = f64[1,1,32,1]{3,2,1,0} reshape(add.871)
  broadcast.975 = f64[1,1,32,1]{3,2,1,0} broadcast(reshape.974), dimensions={0,1,2,3}
  reshape.976 = f64[32]{0} reshape(broadcast.975)
  broadcast.977 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.976), dimensions={2}
  multiply.978 = f64[32,32,32,32]{3,2,1,0} multiply(call.973, broadcast.977)
  add.979 = f64[32,32,32,32]{3,2,1,0} add(add.972, multiply.978)
  slice.980 = f64[32,32,32,16]{3,2,1,0} slice(add.979), slice={[0:32], [0:32], [0:32], [0:16]}
  call.981 = f64[32,32,32,16]{3,2,1,0} call(slice.980), to_apply=_roll_static_7.51
  slice.982 = f64[32,32,32,16]{3,2,1,0} slice(add.979), slice={[0:32], [0:32], [0:32], [16:32]}
  call.983 = f64[32,32,32,16]{3,2,1,0} call(slice.982), to_apply=_roll_static_8.56
  concatenate.984 = f64[32,32,32,32]{3,2,1,0} concatenate(call.981, call.983), dimensions={3}
  call.985 = f64[32,32,32,32]{3,2,1,0} call(concatenate.984), to_apply=_roll_static_9.58
  Arg_1.724 = f64[32]{0} parameter(1)
  divide.876 = f64[32]{0} divide(Arg_1.724, broadcast.806)
  multiply.872 = f64[32]{0} multiply(Arg_1.724, Arg_1.724)
  divide.877 = f64[32]{0} divide(multiply.872, broadcast.804)
  subtract.878 = f64[32]{0} subtract(divide.876, divide.877)
  multiply.873 = f64[32]{0} multiply(multiply.872, Arg_1.724)
  divide.879 = f64[32]{0} divide(multiply.873, broadcast.804)
  subtract.880 = f64[32]{0} subtract(subtract.878, divide.879)
  multiply.874 = f64[32]{0} multiply(multiply.873, Arg_1.724)
  divide.881 = f64[32]{0} divide(multiply.874, broadcast.804)
  add.882 = f64[32]{0} add(subtract.880, divide.881)
  multiply.875 = f64[32]{0} multiply(multiply.874, Arg_1.724)
  divide.883 = f64[32]{0} divide(multiply.875, broadcast.802)
  subtract.884 = f64[32]{0} subtract(add.882, divide.883)
  reshape.986 = f64[1,1,1,32]{3,2,1,0} reshape(subtract.884)
  broadcast.987 = f64[1,1,1,32]{3,2,1,0} broadcast(reshape.986), dimensions={0,1,2,3}
  reshape.988 = f64[32]{0} reshape(broadcast.987)
  broadcast.989 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.988), dimensions={3}
  multiply.990 = f64[32,32,32,32]{3,2,1,0} multiply(call.985, broadcast.989)
  call.991 = f64[32,32,32,32]{3,2,1,0} call(concatenate.984), to_apply=_roll_static_10.63
  divide.885 = f64[32]{0} divide(Arg_1.724, broadcast.800)
  negate.886 = f64[32]{0} negate(divide.885)
  multiply.887 = f64[32]{0} multiply(multiply.872, broadcast.800)
  divide.888 = f64[32]{0} divide(multiply.887, broadcast.798)
  add.889 = f64[32]{0} add(negate.886, divide.888)
  divide.890 = f64[32]{0} divide(multiply.873, broadcast.804)
  subtract.891 = f64[32]{0} subtract(add.889, divide.890)
  divide.892 = f64[32]{0} divide(multiply.874, broadcast.796)
  subtract.893 = f64[32]{0} subtract(subtract.891, divide.892)
  divide.894 = f64[32]{0} divide(multiply.875, broadcast.804)
  add.895 = f64[32]{0} add(subtract.893, divide.894)
  reshape.992 = f64[1,1,1,32]{3,2,1,0} reshape(add.895)
  broadcast.993 = f64[1,1,1,32]{3,2,1,0} broadcast(reshape.992), dimensions={0,1,2,3}
  reshape.994 = f64[32]{0} reshape(broadcast.993)
  broadcast.995 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.994), dimensions={3}
  multiply.996 = f64[32,32,32,32]{3,2,1,0} multiply(call.991, broadcast.995)
  add.997 = f64[32,32,32,32]{3,2,1,0} add(multiply.990, multiply.996)
  call.998 = f64[32,32,32,32]{3,2,1,0} call(concatenate.984), to_apply=_roll_static_11.68
  divide.896 = f64[32]{0} divide(Arg_1.724, broadcast.798)
  subtract.897 = f64[32]{0} subtract(broadcast.794, divide.896)
  multiply.898 = f64[32]{0} multiply(multiply.872, broadcast.792)
  divide.899 = f64[32]{0} divide(multiply.898, broadcast.790)
  subtract.900 = f64[32]{0} subtract(subtract.897, divide.899)
  multiply.901 = f64[32]{0} multiply(multiply.873, broadcast.792)
  divide.902 = f64[32]{0} divide(multiply.901, broadcast.788)
  add.903 = f64[32]{0} add(subtract.900, divide.902)
  divide.904 = f64[32]{0} divide(multiply.874, broadcast.790)
  add.905 = f64[32]{0} add(add.903, divide.904)
  divide.906 = f64[32]{0} divide(multiply.875, broadcast.788)
  subtract.907 = f64[32]{0} subtract(add.905, divide.906)
  reshape.999 = f64[1,1,1,32]{3,2,1,0} reshape(subtract.907)
  broadcast.1000 = f64[1,1,1,32]{3,2,1,0} broadcast(reshape.999), dimensions={0,1,2,3}
  reshape.1001 = f64[32]{0} reshape(broadcast.1000)
  broadcast.1002 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1001), dimensions={3}
  multiply.1003 = f64[32,32,32,32]{3,2,1,0} multiply(call.998, broadcast.1002)
  add.1004 = f64[32,32,32,32]{3,2,1,0} add(add.997, multiply.1003)
  call.1005 = f64[32,32,32,32]{3,2,1,0} call(concatenate.984), to_apply=_roll_static_12.70
  multiply.908 = f64[32]{0} multiply(multiply.872, broadcast.800)
  divide.909 = f64[32]{0} divide(multiply.908, broadcast.798)
  add.910 = f64[32]{0} add(Arg_1.724, divide.909)
  multiply.911 = f64[32]{0} multiply(multiply.873, broadcast.786)
  divide.912 = f64[32]{0} divide(multiply.911, broadcast.788)
  subtract.913 = f64[32]{0} subtract(add.910, divide.912)
  divide.914 = f64[32]{0} divide(multiply.874, broadcast.796)
  subtract.915 = f64[32]{0} subtract(subtract.913, divide.914)
  divide.916 = f64[32]{0} divide(multiply.875, broadcast.788)
  add.917 = f64[32]{0} add(subtract.915, divide.916)
  reshape.1006 = f64[1,1,1,32]{3,2,1,0} reshape(add.917)
  broadcast.1007 = f64[1,1,1,32]{3,2,1,0} broadcast(reshape.1006), dimensions={0,1,2,3}
  reshape.1008 = f64[32]{0} reshape(broadcast.1007)
  broadcast.1009 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1008), dimensions={3}
  multiply.1010 = f64[32,32,32,32]{3,2,1,0} multiply(call.1005, broadcast.1009)
  add.1011 = f64[32,32,32,32]{3,2,1,0} add(add.1004, multiply.1010)
  call.1012 = f64[32,32,32,32]{3,2,1,0} call(concatenate.984), to_apply=_roll_static_13.75
  divide.918 = f64[32]{0} divide(Arg_1.724, broadcast.790)
  negate.919 = f64[32]{0} negate(divide.918)
  divide.920 = f64[32]{0} divide(multiply.872, broadcast.804)
  subtract.921 = f64[32]{0} subtract(negate.919, divide.920)
  multiply.922 = f64[32]{0} multiply(multiply.873, broadcast.786)
  divide.923 = f64[32]{0} divide(multiply.922, broadcast.804)
  add.924 = f64[32]{0} add(subtract.921, divide.923)
  divide.925 = f64[32]{0} divide(multiply.874, broadcast.804)
  add.926 = f64[32]{0} add(add.924, divide.925)
  divide.927 = f64[32]{0} divide(multiply.875, broadcast.804)
  subtract.928 = f64[32]{0} subtract(add.926, divide.927)
  reshape.1013 = f64[1,1,1,32]{3,2,1,0} reshape(subtract.928)
  broadcast.1014 = f64[1,1,1,32]{3,2,1,0} broadcast(reshape.1013), dimensions={0,1,2,3}
  reshape.1015 = f64[32]{0} reshape(broadcast.1014)
  broadcast.1016 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1015), dimensions={3}
  multiply.1017 = f64[32,32,32,32]{3,2,1,0} multiply(call.1012, broadcast.1016)
  add.1018 = f64[32,32,32,32]{3,2,1,0} add(add.1011, multiply.1017)
  call.1019 = f64[32,32,32,32]{3,2,1,0} call(concatenate.984), to_apply=_roll_static_14.80
  divide.929 = f64[32]{0} divide(Arg_1.724, broadcast.784)
  divide.930 = f64[32]{0} divide(multiply.873, broadcast.804)
  subtract.931 = f64[32]{0} subtract(divide.929, divide.930)
  divide.932 = f64[32]{0} divide(multiply.875, broadcast.802)
  add.933 = f64[32]{0} add(subtract.931, divide.932)
  reshape.1020 = f64[1,1,1,32]{3,2,1,0} reshape(add.933)
  broadcast.1021 = f64[1,1,1,32]{3,2,1,0} broadcast(reshape.1020), dimensions={0,1,2,3}
  reshape.1022 = f64[32]{0} reshape(broadcast.1021)
  broadcast.1023 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1022), dimensions={3}
  multiply.1024 = f64[32,32,32,32]{3,2,1,0} multiply(call.1019, broadcast.1023)
  add.1025 = f64[32,32,32,32]{3,2,1,0} add(add.1018, multiply.1024)
  Arg_2.725 = f64[32,1]{1,0} parameter(2)
  Arg_3.726 = f64[1,17]{1,0} parameter(3)
  Arg_4.727 = f64[32,17]{1,0} parameter(4)
  constant.808 = f64[] constant(0.32258064516129031)
  call.1026 = (f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) call(add.1025, Arg_2.725, Arg_3.726, Arg_4.727, constant.808, constant.808), to_apply=solve_poisson.101
  get-tuple-element.1028 = f64[32,32]{1,0} get-tuple-element(call.1026), index=1
  constant.781 = f64[] constant(0.05)
  broadcast.782 = f64[32,32]{1,0} broadcast(constant.781), dimensions={}
  multiply.1266 = f64[32,32]{1,0} multiply(get-tuple-element.1028, broadcast.782)
  constant.779 = f64[] constant(0.32258064516129031)
  broadcast.780 = f64[32,32]{1,0} broadcast(constant.779), dimensions={}
  divide.1267 = f64[32,32]{1,0} divide(multiply.1266, broadcast.780)
  floor.1268 = f64[32,32]{1,0} floor(divide.1267)
  convert.1270 = s32[32,32]{1,0} convert(floor.1268)
  constant.753 = s32[] constant(-1)
  broadcast.754 = s32[32,32]{1,0} broadcast(constant.753), dimensions={}
  compare.1333 = pred[32,32]{1,0} compare(convert.1270, broadcast.754), direction=EQ
  subtract.1269 = f64[32,32]{1,0} subtract(divide.1267, floor.1268)
  constant.777 = f64[] constant(20)
  broadcast.778 = f64[32,32]{1,0} broadcast(constant.777), dimensions={}
  divide.1275 = f64[32,32]{1,0} divide(subtract.1269, broadcast.778)
  multiply.1271 = f64[32,32]{1,0} multiply(subtract.1269, subtract.1269)
  constant.775 = f64[] constant(24)
  broadcast.776 = f64[32,32]{1,0} broadcast(constant.775), dimensions={}
  divide.1276 = f64[32,32]{1,0} divide(multiply.1271, broadcast.776)
  subtract.1277 = f64[32,32]{1,0} subtract(divide.1275, divide.1276)
  multiply.1272 = f64[32,32]{1,0} multiply(multiply.1271, subtract.1269)
  divide.1278 = f64[32,32]{1,0} divide(multiply.1272, broadcast.776)
  subtract.1279 = f64[32,32]{1,0} subtract(subtract.1277, divide.1278)
  multiply.1273 = f64[32,32]{1,0} multiply(multiply.1272, subtract.1269)
  divide.1280 = f64[32,32]{1,0} divide(multiply.1273, broadcast.776)
  add.1281 = f64[32,32]{1,0} add(subtract.1279, divide.1280)
  multiply.1274 = f64[32,32]{1,0} multiply(multiply.1273, subtract.1269)
  constant.773 = f64[] constant(120)
  broadcast.774 = f64[32,32]{1,0} broadcast(constant.773), dimensions={}
  divide.1282 = f64[32,32]{1,0} divide(multiply.1274, broadcast.774)
  subtract.1283 = f64[32,32]{1,0} subtract(add.1281, divide.1282)
  constant.809 = f64[] constant(0)
  call.1334 = f64[32,32]{1,0} call(compare.1333, subtract.1283, constant.809), to_apply=_where.397
  constant.751 = s32[] constant(-2)
  broadcast.752 = s32[32,32]{1,0} broadcast(constant.751), dimensions={}
  compare.1335 = pred[32,32]{1,0} compare(convert.1270, broadcast.752), direction=EQ
  constant.771 = f64[] constant(2)
  broadcast.772 = f64[32,32]{1,0} broadcast(constant.771), dimensions={}
  divide.1284 = f64[32,32]{1,0} divide(subtract.1269, broadcast.772)
  negate.1285 = f64[32,32]{1,0} negate(divide.1284)
  multiply.1286 = f64[32,32]{1,0} multiply(multiply.1271, broadcast.772)
  constant.769 = f64[] constant(3)
  broadcast.770 = f64[32,32]{1,0} broadcast(constant.769), dimensions={}
  divide.1287 = f64[32,32]{1,0} divide(multiply.1286, broadcast.770)
  add.1288 = f64[32,32]{1,0} add(negate.1285, divide.1287)
  divide.1289 = f64[32,32]{1,0} divide(multiply.1272, broadcast.776)
  subtract.1290 = f64[32,32]{1,0} subtract(add.1288, divide.1289)
  constant.767 = f64[] constant(6)
  broadcast.768 = f64[32,32]{1,0} broadcast(constant.767), dimensions={}
  divide.1291 = f64[32,32]{1,0} divide(multiply.1273, broadcast.768)
  subtract.1292 = f64[32,32]{1,0} subtract(subtract.1290, divide.1291)
  divide.1293 = f64[32,32]{1,0} divide(multiply.1274, broadcast.776)
  add.1294 = f64[32,32]{1,0} add(subtract.1292, divide.1293)
  call.1336 = f64[32,32]{1,0} call(compare.1335, add.1294, constant.809), to_apply=_where.403
  add.1337 = f64[32,32]{1,0} add(call.1334, call.1336)
  constant.749 = s32[] constant(-3)
  broadcast.750 = s32[32,32]{1,0} broadcast(constant.749), dimensions={}
  compare.1338 = pred[32,32]{1,0} compare(convert.1270, broadcast.750), direction=EQ
  constant.765 = f64[] constant(1)
  broadcast.766 = f64[32,32]{1,0} broadcast(constant.765), dimensions={}
  divide.1295 = f64[32,32]{1,0} divide(subtract.1269, broadcast.770)
  subtract.1296 = f64[32,32]{1,0} subtract(broadcast.766, divide.1295)
  constant.763 = f64[] constant(5)
  broadcast.764 = f64[32,32]{1,0} broadcast(constant.763), dimensions={}
  multiply.1297 = f64[32,32]{1,0} multiply(multiply.1271, broadcast.764)
  constant.761 = f64[] constant(4)
  broadcast.762 = f64[32,32]{1,0} broadcast(constant.761), dimensions={}
  divide.1298 = f64[32,32]{1,0} divide(multiply.1297, broadcast.762)
  subtract.1299 = f64[32,32]{1,0} subtract(subtract.1296, divide.1298)
  multiply.1300 = f64[32,32]{1,0} multiply(multiply.1272, broadcast.764)
  constant.759 = f64[] constant(12)
  broadcast.760 = f64[32,32]{1,0} broadcast(constant.759), dimensions={}
  divide.1301 = f64[32,32]{1,0} divide(multiply.1300, broadcast.760)
  add.1302 = f64[32,32]{1,0} add(subtract.1299, divide.1301)
  divide.1303 = f64[32,32]{1,0} divide(multiply.1273, broadcast.762)
  add.1304 = f64[32,32]{1,0} add(add.1302, divide.1303)
  divide.1305 = f64[32,32]{1,0} divide(multiply.1274, broadcast.760)
  subtract.1306 = f64[32,32]{1,0} subtract(add.1304, divide.1305)
  call.1339 = f64[32,32]{1,0} call(compare.1338, subtract.1306, constant.809), to_apply=_where.409
  add.1340 = f64[32,32]{1,0} add(add.1337, call.1339)
  constant.747 = s32[] constant(-4)
  broadcast.748 = s32[32,32]{1,0} broadcast(constant.747), dimensions={}
  compare.1341 = pred[32,32]{1,0} compare(convert.1270, broadcast.748), direction=EQ
  multiply.1307 = f64[32,32]{1,0} multiply(multiply.1271, broadcast.772)
  divide.1308 = f64[32,32]{1,0} divide(multiply.1307, broadcast.770)
  add.1309 = f64[32,32]{1,0} add(subtract.1269, divide.1308)
  constant.757 = f64[] constant(7)
  broadcast.758 = f64[32,32]{1,0} broadcast(constant.757), dimensions={}
  multiply.1310 = f64[32,32]{1,0} multiply(multiply.1272, broadcast.758)
  divide.1311 = f64[32,32]{1,0} divide(multiply.1310, broadcast.760)
  subtract.1312 = f64[32,32]{1,0} subtract(add.1309, divide.1311)
  divide.1313 = f64[32,32]{1,0} divide(multiply.1273, broadcast.768)
  subtract.1314 = f64[32,32]{1,0} subtract(subtract.1312, divide.1313)
  divide.1315 = f64[32,32]{1,0} divide(multiply.1274, broadcast.760)
  add.1316 = f64[32,32]{1,0} add(subtract.1314, divide.1315)
  call.1342 = f64[32,32]{1,0} call(compare.1341, add.1316, constant.809), to_apply=_where.415
  add.1343 = f64[32,32]{1,0} add(add.1340, call.1342)
  constant.745 = s32[] constant(-5)
  broadcast.746 = s32[32,32]{1,0} broadcast(constant.745), dimensions={}
  compare.1344 = pred[32,32]{1,0} compare(convert.1270, broadcast.746), direction=EQ
  divide.1317 = f64[32,32]{1,0} divide(subtract.1269, broadcast.762)
  negate.1318 = f64[32,32]{1,0} negate(divide.1317)
  divide.1319 = f64[32,32]{1,0} divide(multiply.1271, broadcast.776)
  subtract.1320 = f64[32,32]{1,0} subtract(negate.1318, divide.1319)
  multiply.1321 = f64[32,32]{1,0} multiply(multiply.1272, broadcast.758)
  divide.1322 = f64[32,32]{1,0} divide(multiply.1321, broadcast.776)
  add.1323 = f64[32,32]{1,0} add(subtract.1320, divide.1322)
  divide.1324 = f64[32,32]{1,0} divide(multiply.1273, broadcast.776)
  add.1325 = f64[32,32]{1,0} add(add.1323, divide.1324)
  divide.1326 = f64[32,32]{1,0} divide(multiply.1274, broadcast.776)
  subtract.1327 = f64[32,32]{1,0} subtract(add.1325, divide.1326)
  call.1345 = f64[32,32]{1,0} call(compare.1344, subtract.1327, constant.809), to_apply=_where.421
  add.1346 = f64[32,32]{1,0} add(add.1343, call.1345)
  constant.743 = s32[] constant(-6)
  broadcast.744 = s32[32,32]{1,0} broadcast(constant.743), dimensions={}
  compare.1347 = pred[32,32]{1,0} compare(convert.1270, broadcast.744), direction=EQ
  constant.755 = f64[] constant(30)
  broadcast.756 = f64[32,32]{1,0} broadcast(constant.755), dimensions={}
  divide.1328 = f64[32,32]{1,0} divide(subtract.1269, broadcast.756)
  divide.1329 = f64[32,32]{1,0} divide(multiply.1272, broadcast.776)
  subtract.1330 = f64[32,32]{1,0} subtract(divide.1328, divide.1329)
  divide.1331 = f64[32,32]{1,0} divide(multiply.1274, broadcast.774)
  add.1332 = f64[32,32]{1,0} add(subtract.1330, divide.1331)
  call.1348 = f64[32,32]{1,0} call(compare.1347, add.1332, constant.809), to_apply=_where.427
  add.1349 = f64[32,32]{1,0} add(add.1346, call.1348)
  reshape.1454 = f64[32,32,1,1]{3,2,1,0} reshape(add.1349)
  broadcast.1455 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1454), dimensions={0,1,2,3}
  reshape.1456 = f64[32,32]{1,0} reshape(broadcast.1455)
  broadcast.1457 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1456), dimensions={0,1}
  get-tuple-element.1027 = f64[32,32]{1,0} get-tuple-element(call.1026), index=0
  multiply.1031 = f64[32,32]{1,0} multiply(get-tuple-element.1027, broadcast.782)
  divide.1032 = f64[32,32]{1,0} divide(multiply.1031, broadcast.780)
  floor.1033 = f64[32,32]{1,0} floor(divide.1032)
  convert.1035 = s32[32,32]{1,0} convert(floor.1033)
  compare.1098 = pred[32,32]{1,0} compare(convert.1035, broadcast.754), direction=EQ
  subtract.1034 = f64[32,32]{1,0} subtract(divide.1032, floor.1033)
  divide.1040 = f64[32,32]{1,0} divide(subtract.1034, broadcast.778)
  multiply.1036 = f64[32,32]{1,0} multiply(subtract.1034, subtract.1034)
  divide.1041 = f64[32,32]{1,0} divide(multiply.1036, broadcast.776)
  subtract.1042 = f64[32,32]{1,0} subtract(divide.1040, divide.1041)
  multiply.1037 = f64[32,32]{1,0} multiply(multiply.1036, subtract.1034)
  divide.1043 = f64[32,32]{1,0} divide(multiply.1037, broadcast.776)
  subtract.1044 = f64[32,32]{1,0} subtract(subtract.1042, divide.1043)
  multiply.1038 = f64[32,32]{1,0} multiply(multiply.1037, subtract.1034)
  divide.1045 = f64[32,32]{1,0} divide(multiply.1038, broadcast.776)
  add.1046 = f64[32,32]{1,0} add(subtract.1044, divide.1045)
  multiply.1039 = f64[32,32]{1,0} multiply(multiply.1038, subtract.1034)
  divide.1047 = f64[32,32]{1,0} divide(multiply.1039, broadcast.774)
  subtract.1048 = f64[32,32]{1,0} subtract(add.1046, divide.1047)
  call.1099 = f64[32,32]{1,0} call(compare.1098, subtract.1048, constant.809), to_apply=_where.140
  compare.1100 = pred[32,32]{1,0} compare(convert.1035, broadcast.752), direction=EQ
  divide.1049 = f64[32,32]{1,0} divide(subtract.1034, broadcast.772)
  negate.1050 = f64[32,32]{1,0} negate(divide.1049)
  multiply.1051 = f64[32,32]{1,0} multiply(multiply.1036, broadcast.772)
  divide.1052 = f64[32,32]{1,0} divide(multiply.1051, broadcast.770)
  add.1053 = f64[32,32]{1,0} add(negate.1050, divide.1052)
  divide.1054 = f64[32,32]{1,0} divide(multiply.1037, broadcast.776)
  subtract.1055 = f64[32,32]{1,0} subtract(add.1053, divide.1054)
  divide.1056 = f64[32,32]{1,0} divide(multiply.1038, broadcast.768)
  subtract.1057 = f64[32,32]{1,0} subtract(subtract.1055, divide.1056)
  divide.1058 = f64[32,32]{1,0} divide(multiply.1039, broadcast.776)
  add.1059 = f64[32,32]{1,0} add(subtract.1057, divide.1058)
  call.1101 = f64[32,32]{1,0} call(compare.1100, add.1059, constant.809), to_apply=_where.146
  add.1102 = f64[32,32]{1,0} add(call.1099, call.1101)
  compare.1103 = pred[32,32]{1,0} compare(convert.1035, broadcast.750), direction=EQ
  divide.1060 = f64[32,32]{1,0} divide(subtract.1034, broadcast.770)
  subtract.1061 = f64[32,32]{1,0} subtract(broadcast.766, divide.1060)
  multiply.1062 = f64[32,32]{1,0} multiply(multiply.1036, broadcast.764)
  divide.1063 = f64[32,32]{1,0} divide(multiply.1062, broadcast.762)
  subtract.1064 = f64[32,32]{1,0} subtract(subtract.1061, divide.1063)
  multiply.1065 = f64[32,32]{1,0} multiply(multiply.1037, broadcast.764)
  divide.1066 = f64[32,32]{1,0} divide(multiply.1065, broadcast.760)
  add.1067 = f64[32,32]{1,0} add(subtract.1064, divide.1066)
  divide.1068 = f64[32,32]{1,0} divide(multiply.1038, broadcast.762)
  add.1069 = f64[32,32]{1,0} add(add.1067, divide.1068)
  divide.1070 = f64[32,32]{1,0} divide(multiply.1039, broadcast.760)
  subtract.1071 = f64[32,32]{1,0} subtract(add.1069, divide.1070)
  call.1104 = f64[32,32]{1,0} call(compare.1103, subtract.1071, constant.809), to_apply=_where.152
  add.1105 = f64[32,32]{1,0} add(add.1102, call.1104)
  compare.1106 = pred[32,32]{1,0} compare(convert.1035, broadcast.748), direction=EQ
  multiply.1072 = f64[32,32]{1,0} multiply(multiply.1036, broadcast.772)
  divide.1073 = f64[32,32]{1,0} divide(multiply.1072, broadcast.770)
  add.1074 = f64[32,32]{1,0} add(subtract.1034, divide.1073)
  multiply.1075 = f64[32,32]{1,0} multiply(multiply.1037, broadcast.758)
  divide.1076 = f64[32,32]{1,0} divide(multiply.1075, broadcast.760)
  subtract.1077 = f64[32,32]{1,0} subtract(add.1074, divide.1076)
  divide.1078 = f64[32,32]{1,0} divide(multiply.1038, broadcast.768)
  subtract.1079 = f64[32,32]{1,0} subtract(subtract.1077, divide.1078)
  divide.1080 = f64[32,32]{1,0} divide(multiply.1039, broadcast.760)
  add.1081 = f64[32,32]{1,0} add(subtract.1079, divide.1080)
  call.1107 = f64[32,32]{1,0} call(compare.1106, add.1081, constant.809), to_apply=_where.158
  add.1108 = f64[32,32]{1,0} add(add.1105, call.1107)
  compare.1109 = pred[32,32]{1,0} compare(convert.1035, broadcast.746), direction=EQ
  divide.1082 = f64[32,32]{1,0} divide(subtract.1034, broadcast.762)
  negate.1083 = f64[32,32]{1,0} negate(divide.1082)
  divide.1084 = f64[32,32]{1,0} divide(multiply.1036, broadcast.776)
  subtract.1085 = f64[32,32]{1,0} subtract(negate.1083, divide.1084)
  multiply.1086 = f64[32,32]{1,0} multiply(multiply.1037, broadcast.758)
  divide.1087 = f64[32,32]{1,0} divide(multiply.1086, broadcast.776)
  add.1088 = f64[32,32]{1,0} add(subtract.1085, divide.1087)
  divide.1089 = f64[32,32]{1,0} divide(multiply.1038, broadcast.776)
  add.1090 = f64[32,32]{1,0} add(add.1088, divide.1089)
  divide.1091 = f64[32,32]{1,0} divide(multiply.1039, broadcast.776)
  subtract.1092 = f64[32,32]{1,0} subtract(add.1090, divide.1091)
  call.1110 = f64[32,32]{1,0} call(compare.1109, subtract.1092, constant.809), to_apply=_where.164
  add.1111 = f64[32,32]{1,0} add(add.1108, call.1110)
  compare.1112 = pred[32,32]{1,0} compare(convert.1035, broadcast.744), direction=EQ
  divide.1093 = f64[32,32]{1,0} divide(subtract.1034, broadcast.756)
  divide.1094 = f64[32,32]{1,0} divide(multiply.1037, broadcast.776)
  subtract.1095 = f64[32,32]{1,0} subtract(divide.1093, divide.1094)
  divide.1096 = f64[32,32]{1,0} divide(multiply.1039, broadcast.774)
  add.1097 = f64[32,32]{1,0} add(subtract.1095, divide.1096)
  call.1113 = f64[32,32]{1,0} call(compare.1112, add.1097, constant.809), to_apply=_where.170
  add.1114 = f64[32,32]{1,0} add(add.1111, call.1113)
  reshape.1219 = f64[32,32,1,1]{3,2,1,0} reshape(add.1114)
  broadcast.1220 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1219), dimensions={0,1,2,3}
  reshape.1221 = f64[32,32]{1,0} reshape(broadcast.1220)
  broadcast.1222 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1221), dimensions={0,1}
  constant.807 = s64[] constant(0)
  call.1217 = f64[32,32,38,32]{3,2,1,0} call(add.1025, constant.807), to_apply=_pad.392
  slice.1218 = f64[32,32,32,32]{3,2,1,0} slice(call.1217), slice={[0:32], [0:32], [6:38], [0:32]}
  multiply.1223 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1222, slice.1218)
  constant.741 = s32[] constant(0)
  broadcast.742 = s32[32,32]{1,0} broadcast(constant.741), dimensions={}
  compare.1115 = pred[32,32]{1,0} compare(convert.1035, broadcast.742), direction=EQ
  call.1116 = f64[32,32]{1,0} call(compare.1115, subtract.1048, constant.809), to_apply=_where.176
  compare.1117 = pred[32,32]{1,0} compare(convert.1035, broadcast.754), direction=EQ
  call.1118 = f64[32,32]{1,0} call(compare.1117, add.1059, constant.809), to_apply=_where.182
  add.1119 = f64[32,32]{1,0} add(call.1116, call.1118)
  compare.1120 = pred[32,32]{1,0} compare(convert.1035, broadcast.752), direction=EQ
  call.1121 = f64[32,32]{1,0} call(compare.1120, subtract.1071, constant.809), to_apply=_where.188
  add.1122 = f64[32,32]{1,0} add(add.1119, call.1121)
  compare.1123 = pred[32,32]{1,0} compare(convert.1035, broadcast.750), direction=EQ
  call.1124 = f64[32,32]{1,0} call(compare.1123, add.1081, constant.809), to_apply=_where.194
  add.1125 = f64[32,32]{1,0} add(add.1122, call.1124)
  compare.1126 = pred[32,32]{1,0} compare(convert.1035, broadcast.748), direction=EQ
  call.1127 = f64[32,32]{1,0} call(compare.1126, subtract.1092, constant.809), to_apply=_where.200
  add.1128 = f64[32,32]{1,0} add(add.1125, call.1127)
  compare.1129 = pred[32,32]{1,0} compare(convert.1035, broadcast.746), direction=EQ
  call.1130 = f64[32,32]{1,0} call(compare.1129, add.1097, constant.809), to_apply=_where.206
  add.1131 = f64[32,32]{1,0} add(add.1128, call.1130)
  reshape.1225 = f64[32,32,1,1]{3,2,1,0} reshape(add.1131)
  broadcast.1226 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1225), dimensions={0,1,2,3}
  reshape.1227 = f64[32,32]{1,0} reshape(broadcast.1226)
  broadcast.1228 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1227), dimensions={0,1}
  slice.1224 = f64[32,32,32,32]{3,2,1,0} slice(call.1217), slice={[0:32], [0:32], [5:37], [0:32]}
  multiply.1229 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1228, slice.1224)
  add.1230 = f64[32,32,32,32]{3,2,1,0} add(multiply.1223, multiply.1229)
  constant.739 = s32[] constant(1)
  broadcast.740 = s32[32,32]{1,0} broadcast(constant.739), dimensions={}
  compare.1132 = pred[32,32]{1,0} compare(convert.1035, broadcast.740), direction=EQ
  call.1133 = f64[32,32]{1,0} call(compare.1132, subtract.1048, constant.809), to_apply=_where.212
  compare.1134 = pred[32,32]{1,0} compare(convert.1035, broadcast.742), direction=EQ
  call.1135 = f64[32,32]{1,0} call(compare.1134, add.1059, constant.809), to_apply=_where.218
  add.1136 = f64[32,32]{1,0} add(call.1133, call.1135)
  compare.1137 = pred[32,32]{1,0} compare(convert.1035, broadcast.754), direction=EQ
  call.1138 = f64[32,32]{1,0} call(compare.1137, subtract.1071, constant.809), to_apply=_where.224
  add.1139 = f64[32,32]{1,0} add(add.1136, call.1138)
  compare.1140 = pred[32,32]{1,0} compare(convert.1035, broadcast.752), direction=EQ
  call.1141 = f64[32,32]{1,0} call(compare.1140, add.1081, constant.809), to_apply=_where.230
  add.1142 = f64[32,32]{1,0} add(add.1139, call.1141)
  compare.1143 = pred[32,32]{1,0} compare(convert.1035, broadcast.750), direction=EQ
  call.1144 = f64[32,32]{1,0} call(compare.1143, subtract.1092, constant.809), to_apply=_where.236
  add.1145 = f64[32,32]{1,0} add(add.1142, call.1144)
  compare.1146 = pred[32,32]{1,0} compare(convert.1035, broadcast.748), direction=EQ
  call.1147 = f64[32,32]{1,0} call(compare.1146, add.1097, constant.809), to_apply=_where.242
  add.1148 = f64[32,32]{1,0} add(add.1145, call.1147)
  reshape.1232 = f64[32,32,1,1]{3,2,1,0} reshape(add.1148)
  broadcast.1233 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1232), dimensions={0,1,2,3}
  reshape.1234 = f64[32,32]{1,0} reshape(broadcast.1233)
  broadcast.1235 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1234), dimensions={0,1}
  slice.1231 = f64[32,32,32,32]{3,2,1,0} slice(call.1217), slice={[0:32], [0:32], [4:36], [0:32]}
  multiply.1236 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1235, slice.1231)
  add.1237 = f64[32,32,32,32]{3,2,1,0} add(add.1230, multiply.1236)
  constant.737 = s32[] constant(2)
  broadcast.738 = s32[32,32]{1,0} broadcast(constant.737), dimensions={}
  compare.1149 = pred[32,32]{1,0} compare(convert.1035, broadcast.738), direction=EQ
  call.1150 = f64[32,32]{1,0} call(compare.1149, subtract.1048, constant.809), to_apply=_where.248
  compare.1151 = pred[32,32]{1,0} compare(convert.1035, broadcast.740), direction=EQ
  call.1152 = f64[32,32]{1,0} call(compare.1151, add.1059, constant.809), to_apply=_where.254
  add.1153 = f64[32,32]{1,0} add(call.1150, call.1152)
  compare.1154 = pred[32,32]{1,0} compare(convert.1035, broadcast.742), direction=EQ
  call.1155 = f64[32,32]{1,0} call(compare.1154, subtract.1071, constant.809), to_apply=_where.260
  add.1156 = f64[32,32]{1,0} add(add.1153, call.1155)
  compare.1157 = pred[32,32]{1,0} compare(convert.1035, broadcast.754), direction=EQ
  call.1158 = f64[32,32]{1,0} call(compare.1157, add.1081, constant.809), to_apply=_where.266
  add.1159 = f64[32,32]{1,0} add(add.1156, call.1158)
  compare.1160 = pred[32,32]{1,0} compare(convert.1035, broadcast.752), direction=EQ
  call.1161 = f64[32,32]{1,0} call(compare.1160, subtract.1092, constant.809), to_apply=_where.272
  add.1162 = f64[32,32]{1,0} add(add.1159, call.1161)
  compare.1163 = pred[32,32]{1,0} compare(convert.1035, broadcast.750), direction=EQ
  call.1164 = f64[32,32]{1,0} call(compare.1163, add.1097, constant.809), to_apply=_where.278
  add.1165 = f64[32,32]{1,0} add(add.1162, call.1164)
  reshape.1239 = f64[32,32,1,1]{3,2,1,0} reshape(add.1165)
  broadcast.1240 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1239), dimensions={0,1,2,3}
  reshape.1241 = f64[32,32]{1,0} reshape(broadcast.1240)
  broadcast.1242 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1241), dimensions={0,1}
  slice.1238 = f64[32,32,32,32]{3,2,1,0} slice(call.1217), slice={[0:32], [0:32], [3:35], [0:32]}
  multiply.1243 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1242, slice.1238)
  add.1244 = f64[32,32,32,32]{3,2,1,0} add(add.1237, multiply.1243)
  constant.735 = s32[] constant(3)
  broadcast.736 = s32[32,32]{1,0} broadcast(constant.735), dimensions={}
  compare.1166 = pred[32,32]{1,0} compare(convert.1035, broadcast.736), direction=EQ
  call.1167 = f64[32,32]{1,0} call(compare.1166, subtract.1048, constant.809), to_apply=_where.284
  compare.1168 = pred[32,32]{1,0} compare(convert.1035, broadcast.738), direction=EQ
  call.1169 = f64[32,32]{1,0} call(compare.1168, add.1059, constant.809), to_apply=_where.290
  add.1170 = f64[32,32]{1,0} add(call.1167, call.1169)
  compare.1171 = pred[32,32]{1,0} compare(convert.1035, broadcast.740), direction=EQ
  call.1172 = f64[32,32]{1,0} call(compare.1171, subtract.1071, constant.809), to_apply=_where.296
  add.1173 = f64[32,32]{1,0} add(add.1170, call.1172)
  compare.1174 = pred[32,32]{1,0} compare(convert.1035, broadcast.742), direction=EQ
  call.1175 = f64[32,32]{1,0} call(compare.1174, add.1081, constant.809), to_apply=_where.302
  add.1176 = f64[32,32]{1,0} add(add.1173, call.1175)
  compare.1177 = pred[32,32]{1,0} compare(convert.1035, broadcast.754), direction=EQ
  call.1178 = f64[32,32]{1,0} call(compare.1177, subtract.1092, constant.809), to_apply=_where.308
  add.1179 = f64[32,32]{1,0} add(add.1176, call.1178)
  compare.1180 = pred[32,32]{1,0} compare(convert.1035, broadcast.752), direction=EQ
  call.1181 = f64[32,32]{1,0} call(compare.1180, add.1097, constant.809), to_apply=_where.314
  add.1182 = f64[32,32]{1,0} add(add.1179, call.1181)
  reshape.1246 = f64[32,32,1,1]{3,2,1,0} reshape(add.1182)
  broadcast.1247 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1246), dimensions={0,1,2,3}
  reshape.1248 = f64[32,32]{1,0} reshape(broadcast.1247)
  broadcast.1249 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1248), dimensions={0,1}
  slice.1245 = f64[32,32,32,32]{3,2,1,0} slice(call.1217), slice={[0:32], [0:32], [2:34], [0:32]}
  multiply.1250 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1249, slice.1245)
  add.1251 = f64[32,32,32,32]{3,2,1,0} add(add.1244, multiply.1250)
  constant.733 = s32[] constant(4)
  broadcast.734 = s32[32,32]{1,0} broadcast(constant.733), dimensions={}
  compare.1183 = pred[32,32]{1,0} compare(convert.1035, broadcast.734), direction=EQ
  call.1184 = f64[32,32]{1,0} call(compare.1183, subtract.1048, constant.809), to_apply=_where.320
  compare.1185 = pred[32,32]{1,0} compare(convert.1035, broadcast.736), direction=EQ
  call.1186 = f64[32,32]{1,0} call(compare.1185, add.1059, constant.809), to_apply=_where.326
  add.1187 = f64[32,32]{1,0} add(call.1184, call.1186)
  compare.1188 = pred[32,32]{1,0} compare(convert.1035, broadcast.738), direction=EQ
  call.1189 = f64[32,32]{1,0} call(compare.1188, subtract.1071, constant.809), to_apply=_where.332
  add.1190 = f64[32,32]{1,0} add(add.1187, call.1189)
  compare.1191 = pred[32,32]{1,0} compare(convert.1035, broadcast.740), direction=EQ
  call.1192 = f64[32,32]{1,0} call(compare.1191, add.1081, constant.809), to_apply=_where.338
  add.1193 = f64[32,32]{1,0} add(add.1190, call.1192)
  compare.1194 = pred[32,32]{1,0} compare(convert.1035, broadcast.742), direction=EQ
  call.1195 = f64[32,32]{1,0} call(compare.1194, subtract.1092, constant.809), to_apply=_where.344
  add.1196 = f64[32,32]{1,0} add(add.1193, call.1195)
  compare.1197 = pred[32,32]{1,0} compare(convert.1035, broadcast.754), direction=EQ
  call.1198 = f64[32,32]{1,0} call(compare.1197, add.1097, constant.809), to_apply=_where.350
  add.1199 = f64[32,32]{1,0} add(add.1196, call.1198)
  reshape.1253 = f64[32,32,1,1]{3,2,1,0} reshape(add.1199)
  broadcast.1254 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1253), dimensions={0,1,2,3}
  reshape.1255 = f64[32,32]{1,0} reshape(broadcast.1254)
  broadcast.1256 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1255), dimensions={0,1}
  slice.1252 = f64[32,32,32,32]{3,2,1,0} slice(call.1217), slice={[0:32], [0:32], [1:33], [0:32]}
  multiply.1257 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1256, slice.1252)
  add.1258 = f64[32,32,32,32]{3,2,1,0} add(add.1251, multiply.1257)
  constant.731 = s32[] constant(5)
  broadcast.732 = s32[32,32]{1,0} broadcast(constant.731), dimensions={}
  compare.1200 = pred[32,32]{1,0} compare(convert.1035, broadcast.732), direction=EQ
  call.1201 = f64[32,32]{1,0} call(compare.1200, subtract.1048, constant.809), to_apply=_where.356
  compare.1202 = pred[32,32]{1,0} compare(convert.1035, broadcast.734), direction=EQ
  call.1203 = f64[32,32]{1,0} call(compare.1202, add.1059, constant.809), to_apply=_where.362
  add.1204 = f64[32,32]{1,0} add(call.1201, call.1203)
  compare.1205 = pred[32,32]{1,0} compare(convert.1035, broadcast.736), direction=EQ
  call.1206 = f64[32,32]{1,0} call(compare.1205, subtract.1071, constant.809), to_apply=_where.368
  add.1207 = f64[32,32]{1,0} add(add.1204, call.1206)
  compare.1208 = pred[32,32]{1,0} compare(convert.1035, broadcast.738), direction=EQ
  call.1209 = f64[32,32]{1,0} call(compare.1208, add.1081, constant.809), to_apply=_where.374
  add.1210 = f64[32,32]{1,0} add(add.1207, call.1209)
  compare.1211 = pred[32,32]{1,0} compare(convert.1035, broadcast.740), direction=EQ
  call.1212 = f64[32,32]{1,0} call(compare.1211, subtract.1092, constant.809), to_apply=_where.380
  add.1213 = f64[32,32]{1,0} add(add.1210, call.1212)
  compare.1214 = pred[32,32]{1,0} compare(convert.1035, broadcast.742), direction=EQ
  call.1215 = f64[32,32]{1,0} call(compare.1214, add.1097, constant.809), to_apply=_where.386
  add.1216 = f64[32,32]{1,0} add(add.1213, call.1215)
  reshape.1260 = f64[32,32,1,1]{3,2,1,0} reshape(add.1216)
  broadcast.1261 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1260), dimensions={0,1,2,3}
  reshape.1262 = f64[32,32]{1,0} reshape(broadcast.1261)
  broadcast.1263 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1262), dimensions={0,1}
  slice.1259 = f64[32,32,32,32]{3,2,1,0} slice(call.1217), slice={[0:32], [0:32], [0:32], [0:32]}
  multiply.1264 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1263, slice.1259)
  add.1265 = f64[32,32,32,32]{3,2,1,0} add(add.1258, multiply.1264)
  call.1452 = f64[32,32,32,38]{3,2,1,0} call(add.1265, constant.807), to_apply=_pad_16.649
  slice.1453 = f64[32,32,32,32]{3,2,1,0} slice(call.1452), slice={[0:32], [0:32], [0:32], [6:38]}
  multiply.1458 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1457, slice.1453)
  compare.1350 = pred[32,32]{1,0} compare(convert.1270, broadcast.742), direction=EQ
  call.1351 = f64[32,32]{1,0} call(compare.1350, subtract.1283, constant.809), to_apply=_where.433
  compare.1352 = pred[32,32]{1,0} compare(convert.1270, broadcast.754), direction=EQ
  call.1353 = f64[32,32]{1,0} call(compare.1352, add.1294, constant.809), to_apply=_where.439
  add.1354 = f64[32,32]{1,0} add(call.1351, call.1353)
  compare.1355 = pred[32,32]{1,0} compare(convert.1270, broadcast.752), direction=EQ
  call.1356 = f64[32,32]{1,0} call(compare.1355, subtract.1306, constant.809), to_apply=_where.445
  add.1357 = f64[32,32]{1,0} add(add.1354, call.1356)
  compare.1358 = pred[32,32]{1,0} compare(convert.1270, broadcast.750), direction=EQ
  call.1359 = f64[32,32]{1,0} call(compare.1358, add.1316, constant.809), to_apply=_where.451
  add.1360 = f64[32,32]{1,0} add(add.1357, call.1359)
  compare.1361 = pred[32,32]{1,0} compare(convert.1270, broadcast.748), direction=EQ
  call.1362 = f64[32,32]{1,0} call(compare.1361, subtract.1327, constant.809), to_apply=_where.457
  add.1363 = f64[32,32]{1,0} add(add.1360, call.1362)
  compare.1364 = pred[32,32]{1,0} compare(convert.1270, broadcast.746), direction=EQ
  call.1365 = f64[32,32]{1,0} call(compare.1364, add.1332, constant.809), to_apply=_where.463
  add.1366 = f64[32,32]{1,0} add(add.1363, call.1365)
  reshape.1460 = f64[32,32,1,1]{3,2,1,0} reshape(add.1366)
  broadcast.1461 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1460), dimensions={0,1,2,3}
  reshape.1462 = f64[32,32]{1,0} reshape(broadcast.1461)
  broadcast.1463 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1462), dimensions={0,1}
  slice.1459 = f64[32,32,32,32]{3,2,1,0} slice(call.1452), slice={[0:32], [0:32], [0:32], [5:37]}
  multiply.1464 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1463, slice.1459)
  add.1465 = f64[32,32,32,32]{3,2,1,0} add(multiply.1458, multiply.1464)
  compare.1367 = pred[32,32]{1,0} compare(convert.1270, broadcast.740), direction=EQ
  call.1368 = f64[32,32]{1,0} call(compare.1367, subtract.1283, constant.809), to_apply=_where.469
  compare.1369 = pred[32,32]{1,0} compare(convert.1270, broadcast.742), direction=EQ
  call.1370 = f64[32,32]{1,0} call(compare.1369, add.1294, constant.809), to_apply=_where.475
  add.1371 = f64[32,32]{1,0} add(call.1368, call.1370)
  compare.1372 = pred[32,32]{1,0} compare(convert.1270, broadcast.754), direction=EQ
  call.1373 = f64[32,32]{1,0} call(compare.1372, subtract.1306, constant.809), to_apply=_where.481
  add.1374 = f64[32,32]{1,0} add(add.1371, call.1373)
  compare.1375 = pred[32,32]{1,0} compare(convert.1270, broadcast.752), direction=EQ
  call.1376 = f64[32,32]{1,0} call(compare.1375, add.1316, constant.809), to_apply=_where.487
  add.1377 = f64[32,32]{1,0} add(add.1374, call.1376)
  compare.1378 = pred[32,32]{1,0} compare(convert.1270, broadcast.750), direction=EQ
  call.1379 = f64[32,32]{1,0} call(compare.1378, subtract.1327, constant.809), to_apply=_where.493
  add.1380 = f64[32,32]{1,0} add(add.1377, call.1379)
  compare.1381 = pred[32,32]{1,0} compare(convert.1270, broadcast.748), direction=EQ
  call.1382 = f64[32,32]{1,0} call(compare.1381, add.1332, constant.809), to_apply=_where.499
  add.1383 = f64[32,32]{1,0} add(add.1380, call.1382)
  reshape.1467 = f64[32,32,1,1]{3,2,1,0} reshape(add.1383)
  broadcast.1468 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1467), dimensions={0,1,2,3}
  reshape.1469 = f64[32,32]{1,0} reshape(broadcast.1468)
  broadcast.1470 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1469), dimensions={0,1}
  slice.1466 = f64[32,32,32,32]{3,2,1,0} slice(call.1452), slice={[0:32], [0:32], [0:32], [4:36]}
  multiply.1471 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1470, slice.1466)
  add.1472 = f64[32,32,32,32]{3,2,1,0} add(add.1465, multiply.1471)
  compare.1384 = pred[32,32]{1,0} compare(convert.1270, broadcast.738), direction=EQ
  call.1385 = f64[32,32]{1,0} call(compare.1384, subtract.1283, constant.809), to_apply=_where.505
  compare.1386 = pred[32,32]{1,0} compare(convert.1270, broadcast.740), direction=EQ
  call.1387 = f64[32,32]{1,0} call(compare.1386, add.1294, constant.809), to_apply=_where.511
  add.1388 = f64[32,32]{1,0} add(call.1385, call.1387)
  compare.1389 = pred[32,32]{1,0} compare(convert.1270, broadcast.742), direction=EQ
  call.1390 = f64[32,32]{1,0} call(compare.1389, subtract.1306, constant.809), to_apply=_where.517
  add.1391 = f64[32,32]{1,0} add(add.1388, call.1390)
  compare.1392 = pred[32,32]{1,0} compare(convert.1270, broadcast.754), direction=EQ
  call.1393 = f64[32,32]{1,0} call(compare.1392, add.1316, constant.809), to_apply=_where.523
  add.1394 = f64[32,32]{1,0} add(add.1391, call.1393)
  compare.1395 = pred[32,32]{1,0} compare(convert.1270, broadcast.752), direction=EQ
  call.1396 = f64[32,32]{1,0} call(compare.1395, subtract.1327, constant.809), to_apply=_where.529
  add.1397 = f64[32,32]{1,0} add(add.1394, call.1396)
  compare.1398 = pred[32,32]{1,0} compare(convert.1270, broadcast.750), direction=EQ
  call.1399 = f64[32,32]{1,0} call(compare.1398, add.1332, constant.809), to_apply=_where.535
  add.1400 = f64[32,32]{1,0} add(add.1397, call.1399)
  reshape.1474 = f64[32,32,1,1]{3,2,1,0} reshape(add.1400)
  broadcast.1475 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1474), dimensions={0,1,2,3}
  reshape.1476 = f64[32,32]{1,0} reshape(broadcast.1475)
  broadcast.1477 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1476), dimensions={0,1}
  slice.1473 = f64[32,32,32,32]{3,2,1,0} slice(call.1452), slice={[0:32], [0:32], [0:32], [3:35]}
  multiply.1478 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1477, slice.1473)
  add.1479 = f64[32,32,32,32]{3,2,1,0} add(add.1472, multiply.1478)
  compare.1401 = pred[32,32]{1,0} compare(convert.1270, broadcast.736), direction=EQ
  call.1402 = f64[32,32]{1,0} call(compare.1401, subtract.1283, constant.809), to_apply=_where.541
  compare.1403 = pred[32,32]{1,0} compare(convert.1270, broadcast.738), direction=EQ
  call.1404 = f64[32,32]{1,0} call(compare.1403, add.1294, constant.809), to_apply=_where.547
  add.1405 = f64[32,32]{1,0} add(call.1402, call.1404)
  compare.1406 = pred[32,32]{1,0} compare(convert.1270, broadcast.740), direction=EQ
  call.1407 = f64[32,32]{1,0} call(compare.1406, subtract.1306, constant.809), to_apply=_where.553
  add.1408 = f64[32,32]{1,0} add(add.1405, call.1407)
  compare.1409 = pred[32,32]{1,0} compare(convert.1270, broadcast.742), direction=EQ
  call.1410 = f64[32,32]{1,0} call(compare.1409, add.1316, constant.809), to_apply=_where.559
  add.1411 = f64[32,32]{1,0} add(add.1408, call.1410)
  compare.1412 = pred[32,32]{1,0} compare(convert.1270, broadcast.754), direction=EQ
  call.1413 = f64[32,32]{1,0} call(compare.1412, subtract.1327, constant.809), to_apply=_where.565
  add.1414 = f64[32,32]{1,0} add(add.1411, call.1413)
  compare.1415 = pred[32,32]{1,0} compare(convert.1270, broadcast.752), direction=EQ
  call.1416 = f64[32,32]{1,0} call(compare.1415, add.1332, constant.809), to_apply=_where.571
  add.1417 = f64[32,32]{1,0} add(add.1414, call.1416)
  reshape.1481 = f64[32,32,1,1]{3,2,1,0} reshape(add.1417)
  broadcast.1482 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1481), dimensions={0,1,2,3}
  reshape.1483 = f64[32,32]{1,0} reshape(broadcast.1482)
  broadcast.1484 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1483), dimensions={0,1}
  slice.1480 = f64[32,32,32,32]{3,2,1,0} slice(call.1452), slice={[0:32], [0:32], [0:32], [2:34]}
  multiply.1485 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1484, slice.1480)
  add.1486 = f64[32,32,32,32]{3,2,1,0} add(add.1479, multiply.1485)
  compare.1418 = pred[32,32]{1,0} compare(convert.1270, broadcast.734), direction=EQ
  call.1419 = f64[32,32]{1,0} call(compare.1418, subtract.1283, constant.809), to_apply=_where.577
  compare.1420 = pred[32,32]{1,0} compare(convert.1270, broadcast.736), direction=EQ
  call.1421 = f64[32,32]{1,0} call(compare.1420, add.1294, constant.809), to_apply=_where.583
  add.1422 = f64[32,32]{1,0} add(call.1419, call.1421)
  compare.1423 = pred[32,32]{1,0} compare(convert.1270, broadcast.738), direction=EQ
  call.1424 = f64[32,32]{1,0} call(compare.1423, subtract.1306, constant.809), to_apply=_where.589
  add.1425 = f64[32,32]{1,0} add(add.1422, call.1424)
  compare.1426 = pred[32,32]{1,0} compare(convert.1270, broadcast.740), direction=EQ
  call.1427 = f64[32,32]{1,0} call(compare.1426, add.1316, constant.809), to_apply=_where.595
  add.1428 = f64[32,32]{1,0} add(add.1425, call.1427)
  compare.1429 = pred[32,32]{1,0} compare(convert.1270, broadcast.742), direction=EQ
  call.1430 = f64[32,32]{1,0} call(compare.1429, subtract.1327, constant.809), to_apply=_where.601
  add.1431 = f64[32,32]{1,0} add(add.1428, call.1430)
  compare.1432 = pred[32,32]{1,0} compare(convert.1270, broadcast.754), direction=EQ
  call.1433 = f64[32,32]{1,0} call(compare.1432, add.1332, constant.809), to_apply=_where.607
  add.1434 = f64[32,32]{1,0} add(add.1431, call.1433)
  reshape.1488 = f64[32,32,1,1]{3,2,1,0} reshape(add.1434)
  broadcast.1489 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1488), dimensions={0,1,2,3}
  reshape.1490 = f64[32,32]{1,0} reshape(broadcast.1489)
  broadcast.1491 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1490), dimensions={0,1}
  slice.1487 = f64[32,32,32,32]{3,2,1,0} slice(call.1452), slice={[0:32], [0:32], [0:32], [1:33]}
  multiply.1492 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1491, slice.1487)
  add.1493 = f64[32,32,32,32]{3,2,1,0} add(add.1486, multiply.1492)
  compare.1435 = pred[32,32]{1,0} compare(convert.1270, broadcast.732), direction=EQ
  call.1436 = f64[32,32]{1,0} call(compare.1435, subtract.1283, constant.809), to_apply=_where.613
  compare.1437 = pred[32,32]{1,0} compare(convert.1270, broadcast.734), direction=EQ
  call.1438 = f64[32,32]{1,0} call(compare.1437, add.1294, constant.809), to_apply=_where.619
  add.1439 = f64[32,32]{1,0} add(call.1436, call.1438)
  compare.1440 = pred[32,32]{1,0} compare(convert.1270, broadcast.736), direction=EQ
  call.1441 = f64[32,32]{1,0} call(compare.1440, subtract.1306, constant.809), to_apply=_where.625
  add.1442 = f64[32,32]{1,0} add(add.1439, call.1441)
  compare.1443 = pred[32,32]{1,0} compare(convert.1270, broadcast.738), direction=EQ
  call.1444 = f64[32,32]{1,0} call(compare.1443, add.1316, constant.809), to_apply=_where.631
  add.1445 = f64[32,32]{1,0} add(add.1442, call.1444)
  compare.1446 = pred[32,32]{1,0} compare(convert.1270, broadcast.740), direction=EQ
  call.1447 = f64[32,32]{1,0} call(compare.1446, subtract.1327, constant.809), to_apply=_where.637
  add.1448 = f64[32,32]{1,0} add(add.1445, call.1447)
  compare.1449 = pred[32,32]{1,0} compare(convert.1270, broadcast.742), direction=EQ
  call.1450 = f64[32,32]{1,0} call(compare.1449, add.1332, constant.809), to_apply=_where.643
  add.1451 = f64[32,32]{1,0} add(add.1448, call.1450)
  reshape.1495 = f64[32,32,1,1]{3,2,1,0} reshape(add.1451)
  broadcast.1496 = f64[32,32,1,1]{3,2,1,0} broadcast(reshape.1495), dimensions={0,1,2,3}
  reshape.1497 = f64[32,32]{1,0} reshape(broadcast.1496)
  broadcast.1498 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1497), dimensions={0,1}
  slice.1494 = f64[32,32,32,32]{3,2,1,0} slice(call.1452), slice={[0:32], [0:32], [0:32], [0:32]}
  multiply.1499 = f64[32,32,32,32]{3,2,1,0} multiply(broadcast.1498, slice.1494)
  add.1500 = f64[32,32,32,32]{3,2,1,0} add(add.1493, multiply.1499)
  slice.1501 = f64[32,32,32,16]{3,2,1,0} slice(add.1500), slice={[0:32], [0:32], [0:32], [0:16]}
  call.1502 = f64[32,32,32,16]{3,2,1,0} call(slice.1501), to_apply=_roll_static_7.654
  slice.1503 = f64[32,32,32,16]{3,2,1,0} slice(add.1500), slice={[0:32], [0:32], [0:32], [16:32]}
  call.1504 = f64[32,32,32,16]{3,2,1,0} call(slice.1503), to_apply=_roll_static_8.659
  concatenate.1505 = f64[32,32,32,32]{3,2,1,0} concatenate(call.1502, call.1504), dimensions={3}
  call.1506 = f64[32,32,32,32]{3,2,1,0} call(concatenate.1505), to_apply=_roll_static_9.661
  reshape.1507 = f64[1,1,1,32]{3,2,1,0} reshape(subtract.884)
  broadcast.1508 = f64[1,1,1,32]{3,2,1,0} broadcast(reshape.1507), dimensions={0,1,2,3}
  reshape.1509 = f64[32]{0} reshape(broadcast.1508)
  broadcast.1510 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1509), dimensions={3}
  multiply.1511 = f64[32,32,32,32]{3,2,1,0} multiply(call.1506, broadcast.1510)
  call.1512 = f64[32,32,32,32]{3,2,1,0} call(concatenate.1505), to_apply=_roll_static_10.666
  reshape.1513 = f64[1,1,1,32]{3,2,1,0} reshape(add.895)
  broadcast.1514 = f64[1,1,1,32]{3,2,1,0} broadcast(reshape.1513), dimensions={0,1,2,3}
  reshape.1515 = f64[32]{0} reshape(broadcast.1514)
  broadcast.1516 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1515), dimensions={3}
  multiply.1517 = f64[32,32,32,32]{3,2,1,0} multiply(call.1512, broadcast.1516)
  add.1518 = f64[32,32,32,32]{3,2,1,0} add(multiply.1511, multiply.1517)
  call.1519 = f64[32,32,32,32]{3,2,1,0} call(concatenate.1505), to_apply=_roll_static_11.671
  reshape.1520 = f64[1,1,1,32]{3,2,1,0} reshape(subtract.907)
  broadcast.1521 = f64[1,1,1,32]{3,2,1,0} broadcast(reshape.1520), dimensions={0,1,2,3}
  reshape.1522 = f64[32]{0} reshape(broadcast.1521)
  broadcast.1523 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1522), dimensions={3}
  multiply.1524 = f64[32,32,32,32]{3,2,1,0} multiply(call.1519, broadcast.1523)
  add.1525 = f64[32,32,32,32]{3,2,1,0} add(add.1518, multiply.1524)
  call.1526 = f64[32,32,32,32]{3,2,1,0} call(concatenate.1505), to_apply=_roll_static_12.673
  reshape.1527 = f64[1,1,1,32]{3,2,1,0} reshape(add.917)
  broadcast.1528 = f64[1,1,1,32]{3,2,1,0} broadcast(reshape.1527), dimensions={0,1,2,3}
  reshape.1529 = f64[32]{0} reshape(broadcast.1528)
  broadcast.1530 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1529), dimensions={3}
  multiply.1531 = f64[32,32,32,32]{3,2,1,0} multiply(call.1526, broadcast.1530)
  add.1532 = f64[32,32,32,32]{3,2,1,0} add(add.1525, multiply.1531)
  call.1533 = f64[32,32,32,32]{3,2,1,0} call(concatenate.1505), to_apply=_roll_static_13.678
  reshape.1534 = f64[1,1,1,32]{3,2,1,0} reshape(subtract.928)
  broadcast.1535 = f64[1,1,1,32]{3,2,1,0} broadcast(reshape.1534), dimensions={0,1,2,3}
  reshape.1536 = f64[32]{0} reshape(broadcast.1535)
  broadcast.1537 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1536), dimensions={3}
  multiply.1538 = f64[32,32,32,32]{3,2,1,0} multiply(call.1533, broadcast.1537)
  add.1539 = f64[32,32,32,32]{3,2,1,0} add(add.1532, multiply.1538)
  call.1540 = f64[32,32,32,32]{3,2,1,0} call(concatenate.1505), to_apply=_roll_static_14.683
  reshape.1541 = f64[1,1,1,32]{3,2,1,0} reshape(add.933)
  broadcast.1542 = f64[1,1,1,32]{3,2,1,0} broadcast(reshape.1541), dimensions={0,1,2,3}
  reshape.1543 = f64[32]{0} reshape(broadcast.1542)
  broadcast.1544 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1543), dimensions={3}
  multiply.1545 = f64[32,32,32,32]{3,2,1,0} multiply(call.1540, broadcast.1544)
  add.1546 = f64[32,32,32,32]{3,2,1,0} add(add.1539, multiply.1545)
  slice.1547 = f64[32,32,16,32]{3,2,1,0} slice(add.1546), slice={[0:32], [0:32], [0:16], [0:32]}
  call.1548 = f64[32,32,16,32]{3,2,1,0} call(slice.1547), to_apply=_roll_static.688
  slice.1549 = f64[32,32,16,32]{3,2,1,0} slice(add.1546), slice={[0:32], [0:32], [16:32], [0:32]}
  call.1550 = f64[32,32,16,32]{3,2,1,0} call(slice.1549), to_apply=_roll_static_0.693
  concatenate.1551 = f64[32,32,32,32]{3,2,1,0} concatenate(call.1548, call.1550), dimensions={2}
  call.1552 = f64[32,32,32,32]{3,2,1,0} call(concatenate.1551), to_apply=_roll_static_1.695
  reshape.1553 = f64[1,1,32,1]{3,2,1,0} reshape(subtract.822)
  broadcast.1554 = f64[1,1,32,1]{3,2,1,0} broadcast(reshape.1553), dimensions={0,1,2,3}
  reshape.1555 = f64[32]{0} reshape(broadcast.1554)
  broadcast.1556 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1555), dimensions={2}
  multiply.1557 = f64[32,32,32,32]{3,2,1,0} multiply(call.1552, broadcast.1556)
  call.1558 = f64[32,32,32,32]{3,2,1,0} call(concatenate.1551), to_apply=_roll_static_2.700
  reshape.1559 = f64[1,1,32,1]{3,2,1,0} reshape(add.833)
  broadcast.1560 = f64[1,1,32,1]{3,2,1,0} broadcast(reshape.1559), dimensions={0,1,2,3}
  reshape.1561 = f64[32]{0} reshape(broadcast.1560)
  broadcast.1562 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1561), dimensions={2}
  multiply.1563 = f64[32,32,32,32]{3,2,1,0} multiply(call.1558, broadcast.1562)
  add.1564 = f64[32,32,32,32]{3,2,1,0} add(multiply.1557, multiply.1563)
  call.1565 = f64[32,32,32,32]{3,2,1,0} call(concatenate.1551), to_apply=_roll_static_3.705
  reshape.1566 = f64[1,1,32,1]{3,2,1,0} reshape(subtract.845)
  broadcast.1567 = f64[1,1,32,1]{3,2,1,0} broadcast(reshape.1566), dimensions={0,1,2,3}
  reshape.1568 = f64[32]{0} reshape(broadcast.1567)
  broadcast.1569 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1568), dimensions={2}
  multiply.1570 = f64[32,32,32,32]{3,2,1,0} multiply(call.1565, broadcast.1569)
  add.1571 = f64[32,32,32,32]{3,2,1,0} add(add.1564, multiply.1570)
  call.1572 = f64[32,32,32,32]{3,2,1,0} call(concatenate.1551), to_apply=_roll_static_4.707
  reshape.1573 = f64[1,1,32,1]{3,2,1,0} reshape(add.855)
  broadcast.1574 = f64[1,1,32,1]{3,2,1,0} broadcast(reshape.1573), dimensions={0,1,2,3}
  reshape.1575 = f64[32]{0} reshape(broadcast.1574)
  broadcast.1576 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1575), dimensions={2}
  multiply.1577 = f64[32,32,32,32]{3,2,1,0} multiply(call.1572, broadcast.1576)
  add.1578 = f64[32,32,32,32]{3,2,1,0} add(add.1571, multiply.1577)
  call.1579 = f64[32,32,32,32]{3,2,1,0} call(concatenate.1551), to_apply=_roll_static_5.712
  reshape.1580 = f64[1,1,32,1]{3,2,1,0} reshape(subtract.866)
  broadcast.1581 = f64[1,1,32,1]{3,2,1,0} broadcast(reshape.1580), dimensions={0,1,2,3}
  reshape.1582 = f64[32]{0} reshape(broadcast.1581)
  broadcast.1583 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1582), dimensions={2}
  multiply.1584 = f64[32,32,32,32]{3,2,1,0} multiply(call.1579, broadcast.1583)
  add.1585 = f64[32,32,32,32]{3,2,1,0} add(add.1578, multiply.1584)
  call.1586 = f64[32,32,32,32]{3,2,1,0} call(concatenate.1551), to_apply=_roll_static_6.717
  reshape.1587 = f64[1,1,32,1]{3,2,1,0} reshape(add.871)
  broadcast.1588 = f64[1,1,32,1]{3,2,1,0} broadcast(reshape.1587), dimensions={0,1,2,3}
  reshape.1589 = f64[32]{0} reshape(broadcast.1588)
  broadcast.1590 = f64[32,32,32,32]{3,2,1,0} broadcast(reshape.1589), dimensions={2}
  multiply.1591 = f64[32,32,32,32]{3,2,1,0} multiply(call.1586, broadcast.1590)
  add.1592 = f64[32,32,32,32]{3,2,1,0} add(add.1585, multiply.1591)
  get-tuple-element.1029 = f64[32,32]{1,0} get-tuple-element(call.1026), index=2
  get-tuple-element.1030 = f64[32,32]{1,0} get-tuple-element(call.1026), index=3
  ROOT tuple.1593 = (f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(add.1592, get-tuple-element.1029, get-tuple-element.1030)
}

region_0.1594 {
  arg_tuple.1595 = (s64[], f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) parameter(0)
  get-tuple-element.1596 = s64[] get-tuple-element(arg_tuple.1595), index=0
  constant.1600 = s64[] constant(1)
  add.1609 = s64[] add(get-tuple-element.1596, constant.1600)
  constant.1604 = f64[32]{0} constant({...})
  constant.1603 = f64[32,1]{1,0} constant({...})
  constant.1602 = f64[1,17]{1,0} constant({...})
  constant.1601 = f64[32,17]{1,0} constant({...})
  get-tuple-element.1597 = f64[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.1595), index=1
  get-tuple-element.1598 = f64[32,32]{1,0} get-tuple-element(arg_tuple.1595), index=2
  get-tuple-element.1599 = f64[32,32]{1,0} get-tuple-element(arg_tuple.1595), index=3
  call.1605 = (f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) call(constant.1604, constant.1604, constant.1603, constant.1602, constant.1601, get-tuple-element.1597, get-tuple-element.1598, get-tuple-element.1599), to_apply=None.722
  get-tuple-element.1606 = f64[32,32,32,32]{3,2,1,0} get-tuple-element(call.1605), index=0
  get-tuple-element.1607 = f64[32,32]{1,0} get-tuple-element(call.1605), index=1
  get-tuple-element.1608 = f64[32,32]{1,0} get-tuple-element(call.1605), index=2
  ROOT tuple.1610 = (s64[], f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(add.1609, get-tuple-element.1606, get-tuple-element.1607, get-tuple-element.1608)
}

region_2.1611 {
  arg_tuple.1612 = (s64[], f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) parameter(0)
  get-tuple-element.1614 = f64[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.1612), index=1
  get-tuple-element.1615 = f64[32,32]{1,0} get-tuple-element(arg_tuple.1612), index=2
  get-tuple-element.1616 = f64[32,32]{1,0} get-tuple-element(arg_tuple.1612), index=3
  get-tuple-element.1613 = s64[] get-tuple-element(arg_tuple.1612), index=0
  constant.1617 = s64[] constant(128)
  ROOT compare.1618 = pred[] compare(get-tuple-element.1613, constant.1617), direction=LT
}

ENTRY main.1627 {
  constant.15 = s64[] constant(0)
  Arg_2.3 = f64[32,32,32,32]{3,2,1,0} parameter(2)
  Arg_0.1 = f64[32,32]{1,0} parameter(0)
  Arg_1.2 = f64[32,32]{1,0} parameter(1)
  tuple.16 = (s64[], f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) tuple(constant.15, Arg_2.3, Arg_0.1, Arg_1.2)
  while.1619 = (s64[], f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[32,32]{1,0}) while(tuple.16), condition=region_2.1611, body=region_0.1594
  get-tuple-element.1620 = s64[] get-tuple-element(while.1619), index=0
  constant.12 = f64[32]{0} constant({...})
  constant.13 = f64[32]{0} constant({...})
  constant.9 = f64[32,1]{1,0} constant({...})
  constant.10 = f64[1,17]{1,0} constant({...})
  constant.11 = f64[32,17]{1,0} constant({...})
  constant.14 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  get-tuple-element.1622 = f64[32,32]{1,0} get-tuple-element(while.1619), index=2
  get-tuple-element.1623 = f64[32,32]{1,0} get-tuple-element(while.1619), index=3
  get-tuple-element.1621 = f64[32,32,32,32]{3,2,1,0} get-tuple-element(while.1619), index=1
  Arg_3.4 = f64[32,32]{1,0} parameter(3)
  Arg_4.5 = f64[] parameter(4)
  constant.7 = f64[] constant(6.4)
  add.1624 = f64[] add(Arg_4.5, constant.7)
  Arg_5.6 = s64[] parameter(5)
  constant.8 = s64[] constant(128)
  add.1625 = s64[] add(Arg_5.6, constant.8)
  ROOT tuple.1626 = (f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32]{0}, f64[32,1]{1,0}, /*index=5*/f64[1,17]{1,0}, f64[32,17]{1,0}, s32[6]{0}, f64[32,32]{1,0}, f64[32,32]{1,0}, /*index=10*/f64[32,32,32,32]{3,2,1,0}, f64[32,32]{1,0}, f64[], s64[]) tuple(constant.12, constant.12, constant.13, constant.13, constant.9, constant.10, constant.11, constant.14, get-tuple-element.1622, get-tuple-element.1623, get-tuple-element.1621, Arg_3.4, add.1624, add.1625)
}

