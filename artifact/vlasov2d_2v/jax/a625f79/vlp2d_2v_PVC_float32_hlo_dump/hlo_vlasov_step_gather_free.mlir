HloModule jit__lambda_, entry_computation_layout={(f32[32,32,32,32]{3,2,1,0})->(f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0})}

_roll_static.73 {
  Arg_0.74 = f32[32,32,16,32]{3,2,1,0} parameter(0)
  slice.75 = f32[31,32,16,32]{3,2,1,0} slice(Arg_0.74), slice={[1:32], [0:32], [0:16], [0:32]}
  slice.76 = f32[1,32,16,32]{3,2,1,0} slice(Arg_0.74), slice={[0:1], [0:32], [0:16], [0:32]}
  ROOT concatenate.77 = f32[32,32,16,32]{3,2,1,0} concatenate(slice.75, slice.76), dimensions={0}
}

_roll_static_0.80 {
  ROOT Arg_0.81 = f32[32,32,16,32]{3,2,1,0} parameter(0)
}

_roll_static_1.84 {
  Arg_0.85 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.86 = f32[30,32,32,32]{3,2,1,0} slice(Arg_0.85), slice={[2:32], [0:32], [0:32], [0:32]}
  slice.87 = f32[2,32,32,32]{3,2,1,0} slice(Arg_0.85), slice={[0:2], [0:32], [0:32], [0:32]}
  ROOT concatenate.88 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.86, slice.87), dimensions={0}
}

_roll_static_2.94 {
  Arg_0.95 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.96 = f32[31,32,32,32]{3,2,1,0} slice(Arg_0.95), slice={[1:32], [0:32], [0:32], [0:32]}
  slice.97 = f32[1,32,32,32]{3,2,1,0} slice(Arg_0.95), slice={[0:1], [0:32], [0:32], [0:32]}
  ROOT concatenate.98 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.96, slice.97), dimensions={0}
}

_roll_static_3.105 {
  ROOT Arg_0.106 = f32[32,32,32,32]{3,2,1,0} parameter(0)
}

_roll_static_4.113 {
  Arg_0.114 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.115 = f32[1,32,32,32]{3,2,1,0} slice(Arg_0.114), slice={[31:32], [0:32], [0:32], [0:32]}
  slice.116 = f32[31,32,32,32]{3,2,1,0} slice(Arg_0.114), slice={[0:31], [0:32], [0:32], [0:32]}
  ROOT concatenate.117 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.115, slice.116), dimensions={0}
}

_roll_static_5.124 {
  Arg_0.125 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.126 = f32[2,32,32,32]{3,2,1,0} slice(Arg_0.125), slice={[30:32], [0:32], [0:32], [0:32]}
  slice.127 = f32[30,32,32,32]{3,2,1,0} slice(Arg_0.125), slice={[0:30], [0:32], [0:32], [0:32]}
  ROOT concatenate.128 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.126, slice.127), dimensions={0}
}

_roll_static_6.135 {
  Arg_0.136 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.137 = f32[3,32,32,32]{3,2,1,0} slice(Arg_0.136), slice={[29:32], [0:32], [0:32], [0:32]}
  slice.138 = f32[29,32,32,32]{3,2,1,0} slice(Arg_0.136), slice={[0:29], [0:32], [0:32], [0:32]}
  ROOT concatenate.139 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.137, slice.138), dimensions={0}
}

_roll_static_7.147 {
  Arg_0.148 = f32[32,32,32,16]{3,2,1,0} parameter(0)
  slice.149 = f32[32,31,32,16]{3,2,1,0} slice(Arg_0.148), slice={[0:32], [1:32], [0:32], [0:16]}
  slice.150 = f32[32,1,32,16]{3,2,1,0} slice(Arg_0.148), slice={[0:32], [0:1], [0:32], [0:16]}
  ROOT concatenate.151 = f32[32,32,32,16]{3,2,1,0} concatenate(slice.149, slice.150), dimensions={1}
}

_roll_static_8.154 {
  ROOT Arg_0.155 = f32[32,32,32,16]{3,2,1,0} parameter(0)
}

_roll_static_9.158 {
  Arg_0.159 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.160 = f32[32,30,32,32]{3,2,1,0} slice(Arg_0.159), slice={[0:32], [2:32], [0:32], [0:32]}
  slice.161 = f32[32,2,32,32]{3,2,1,0} slice(Arg_0.159), slice={[0:32], [0:2], [0:32], [0:32]}
  ROOT concatenate.162 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.160, slice.161), dimensions={1}
}

_roll_static_10.168 {
  Arg_0.169 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.170 = f32[32,31,32,32]{3,2,1,0} slice(Arg_0.169), slice={[0:32], [1:32], [0:32], [0:32]}
  slice.171 = f32[32,1,32,32]{3,2,1,0} slice(Arg_0.169), slice={[0:32], [0:1], [0:32], [0:32]}
  ROOT concatenate.172 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.170, slice.171), dimensions={1}
}

_roll_static_11.179 {
  ROOT Arg_0.180 = f32[32,32,32,32]{3,2,1,0} parameter(0)
}

_roll_static_12.187 {
  Arg_0.188 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.189 = f32[32,1,32,32]{3,2,1,0} slice(Arg_0.188), slice={[0:32], [31:32], [0:32], [0:32]}
  slice.190 = f32[32,31,32,32]{3,2,1,0} slice(Arg_0.188), slice={[0:32], [0:31], [0:32], [0:32]}
  ROOT concatenate.191 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.189, slice.190), dimensions={1}
}

_roll_static_13.198 {
  Arg_0.199 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.200 = f32[32,2,32,32]{3,2,1,0} slice(Arg_0.199), slice={[0:32], [30:32], [0:32], [0:32]}
  slice.201 = f32[32,30,32,32]{3,2,1,0} slice(Arg_0.199), slice={[0:32], [0:30], [0:32], [0:32]}
  ROOT concatenate.202 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.200, slice.201), dimensions={1}
}

_roll_static_14.209 {
  Arg_0.210 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.211 = f32[32,3,32,32]{3,2,1,0} slice(Arg_0.210), slice={[0:32], [29:32], [0:32], [0:32]}
  slice.212 = f32[32,29,32,32]{3,2,1,0} slice(Arg_0.210), slice={[0:32], [0:29], [0:32], [0:32]}
  ROOT concatenate.213 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.211, slice.212), dimensions={1}
}

region_0.220 {
  Arg_0.221 = f32[] parameter(0)
  Arg_1.222 = f32[] parameter(1)
  ROOT add.223 = f32[] add(Arg_0.221, Arg_1.222)
}

fft.224 {
  Arg_0.225 = f32[32,32]{1,0} parameter(0)
  ROOT fft.226 = c64[32,17]{1,0} fft(Arg_0.225), fft_type=RFFT, fft_length={32,32}
}

fft_15.227 {
  Arg_0.228 = c64[32,17]{1,0} parameter(0)
  ROOT fft.229 = f32[32,32]{1,0} fft(Arg_0.228), fft_type=IRFFT, fft_length={32,32}
}

fft_15.230 {
  Arg_0.231 = c64[32,17]{1,0} parameter(0)
  ROOT fft.232 = f32[32,32]{1,0} fft(Arg_0.231), fft_type=IRFFT, fft_length={32,32}
}

fft_15.233 {
  Arg_0.234 = c64[32,17]{1,0} parameter(0)
  ROOT fft.235 = f32[32,32]{1,0} fft(Arg_0.234), fft_type=IRFFT, fft_length={32,32}
}

solve_poisson.236 {
  Arg_1.238 = f32[32,1]{1,0} parameter(1)
  convert.260 = c64[32,1]{1,0} convert(Arg_1.238)
  constant.245 = c64[] constant((-0, -1))
  broadcast.246 = c64[32,1]{1,0} broadcast(constant.245), dimensions={}
  multiply.261 = c64[32,1]{1,0} multiply(convert.260, broadcast.246)
  broadcast.262 = c64[32,1]{1,0} broadcast(multiply.261), dimensions={0,1}
  reshape.263 = c64[32]{0} reshape(broadcast.262)
  broadcast.264 = c64[32,17]{1,0} broadcast(reshape.263), dimensions={0}
  Arg_0.237 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  constant.249 = f32[] constant(0)
  reduce.250 = f32[32,32]{1,0} reduce(Arg_0.237, constant.249), dimensions={2,3}, to_apply=region_0.220
  Arg_4.241 = f32[] parameter(4)
  broadcast.251 = f32[32,32]{1,0} broadcast(Arg_4.241), dimensions={}
  multiply.252 = f32[32,32]{1,0} multiply(reduce.250, broadcast.251)
  Arg_5.242 = f32[] parameter(5)
  broadcast.253 = f32[32,32]{1,0} broadcast(Arg_5.242), dimensions={}
  multiply.254 = f32[32,32]{1,0} multiply(multiply.252, broadcast.253)
  constant.247 = f32[] constant(1)
  broadcast.248 = f32[32,32]{1,0} broadcast(constant.247), dimensions={}
  subtract.255 = f32[32,32]{1,0} subtract(multiply.254, broadcast.248)
  call.256 = c64[32,17]{1,0} call(subtract.255), to_apply=fft.224
  Arg_3.240 = f32[32,17]{1,0} parameter(3)
  convert.257 = c64[32,17]{1,0} convert(Arg_3.240)
  multiply.258 = c64[32,17]{1,0} multiply(call.256, convert.257)
  multiply.265 = c64[32,17]{1,0} multiply(broadcast.264, multiply.258)
  call.272 = f32[32,32]{1,0} call(multiply.265), to_apply=fft_15.230
  Arg_2.239 = f32[1,17]{1,0} parameter(2)
  convert.266 = c64[1,17]{1,0} convert(Arg_2.239)
  constant.243 = c64[] constant((-0, -1))
  broadcast.244 = c64[1,17]{1,0} broadcast(constant.243), dimensions={}
  multiply.267 = c64[1,17]{1,0} multiply(convert.266, broadcast.244)
  broadcast.268 = c64[1,17]{1,0} broadcast(multiply.267), dimensions={0,1}
  reshape.269 = c64[17]{0} reshape(broadcast.268)
  broadcast.270 = c64[32,17]{1,0} broadcast(reshape.269), dimensions={1}
  multiply.271 = c64[32,17]{1,0} multiply(broadcast.270, multiply.258)
  call.273 = f32[32,32]{1,0} call(multiply.271), to_apply=fft_15.233
  call.259 = f32[32,32]{1,0} call(multiply.258), to_apply=fft_15.227
  ROOT tuple.274 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(call.272, call.273, subtract.255, call.259)
}

_where.348 {
  Arg_0.349 = pred[32,32]{1,0} parameter(0)
  Arg_1.350 = f32[32,32]{1,0} parameter(1)
  Arg_2.351 = f32[] parameter(2)
  broadcast.352 = f32[32,32]{1,0} broadcast(Arg_2.351), dimensions={}
  ROOT select.353 = f32[32,32]{1,0} select(Arg_0.349, Arg_1.350, broadcast.352)
}

_where.356 {
  Arg_0.357 = pred[32,32]{1,0} parameter(0)
  Arg_1.358 = f32[32,32]{1,0} parameter(1)
  Arg_2.359 = f32[] parameter(2)
  broadcast.360 = f32[32,32]{1,0} broadcast(Arg_2.359), dimensions={}
  ROOT select.361 = f32[32,32]{1,0} select(Arg_0.357, Arg_1.358, broadcast.360)
}

_where.365 {
  Arg_0.366 = pred[32,32]{1,0} parameter(0)
  Arg_1.367 = f32[32,32]{1,0} parameter(1)
  Arg_2.368 = f32[] parameter(2)
  broadcast.369 = f32[32,32]{1,0} broadcast(Arg_2.368), dimensions={}
  ROOT select.370 = f32[32,32]{1,0} select(Arg_0.366, Arg_1.367, broadcast.369)
}

_where.374 {
  Arg_0.375 = pred[32,32]{1,0} parameter(0)
  Arg_1.376 = f32[32,32]{1,0} parameter(1)
  Arg_2.377 = f32[] parameter(2)
  broadcast.378 = f32[32,32]{1,0} broadcast(Arg_2.377), dimensions={}
  ROOT select.379 = f32[32,32]{1,0} select(Arg_0.375, Arg_1.376, broadcast.378)
}

_where.383 {
  Arg_0.384 = pred[32,32]{1,0} parameter(0)
  Arg_1.385 = f32[32,32]{1,0} parameter(1)
  Arg_2.386 = f32[] parameter(2)
  broadcast.387 = f32[32,32]{1,0} broadcast(Arg_2.386), dimensions={}
  ROOT select.388 = f32[32,32]{1,0} select(Arg_0.384, Arg_1.385, broadcast.387)
}

_where.392 {
  Arg_0.393 = pred[32,32]{1,0} parameter(0)
  Arg_1.394 = f32[32,32]{1,0} parameter(1)
  Arg_2.395 = f32[] parameter(2)
  broadcast.396 = f32[32,32]{1,0} broadcast(Arg_2.395), dimensions={}
  ROOT select.397 = f32[32,32]{1,0} select(Arg_0.393, Arg_1.394, broadcast.396)
}

_where.401 {
  Arg_0.402 = pred[32,32]{1,0} parameter(0)
  Arg_1.403 = f32[32,32]{1,0} parameter(1)
  Arg_2.404 = f32[] parameter(2)
  broadcast.405 = f32[32,32]{1,0} broadcast(Arg_2.404), dimensions={}
  ROOT select.406 = f32[32,32]{1,0} select(Arg_0.402, Arg_1.403, broadcast.405)
}

_where.409 {
  Arg_0.410 = pred[32,32]{1,0} parameter(0)
  Arg_1.411 = f32[32,32]{1,0} parameter(1)
  Arg_2.412 = f32[] parameter(2)
  broadcast.413 = f32[32,32]{1,0} broadcast(Arg_2.412), dimensions={}
  ROOT select.414 = f32[32,32]{1,0} select(Arg_0.410, Arg_1.411, broadcast.413)
}

_where.418 {
  Arg_0.419 = pred[32,32]{1,0} parameter(0)
  Arg_1.420 = f32[32,32]{1,0} parameter(1)
  Arg_2.421 = f32[] parameter(2)
  broadcast.422 = f32[32,32]{1,0} broadcast(Arg_2.421), dimensions={}
  ROOT select.423 = f32[32,32]{1,0} select(Arg_0.419, Arg_1.420, broadcast.422)
}

_where.427 {
  Arg_0.428 = pred[32,32]{1,0} parameter(0)
  Arg_1.429 = f32[32,32]{1,0} parameter(1)
  Arg_2.430 = f32[] parameter(2)
  broadcast.431 = f32[32,32]{1,0} broadcast(Arg_2.430), dimensions={}
  ROOT select.432 = f32[32,32]{1,0} select(Arg_0.428, Arg_1.429, broadcast.431)
}

_where.436 {
  Arg_0.437 = pred[32,32]{1,0} parameter(0)
  Arg_1.438 = f32[32,32]{1,0} parameter(1)
  Arg_2.439 = f32[] parameter(2)
  broadcast.440 = f32[32,32]{1,0} broadcast(Arg_2.439), dimensions={}
  ROOT select.441 = f32[32,32]{1,0} select(Arg_0.437, Arg_1.438, broadcast.440)
}

_where.445 {
  Arg_0.446 = pred[32,32]{1,0} parameter(0)
  Arg_1.447 = f32[32,32]{1,0} parameter(1)
  Arg_2.448 = f32[] parameter(2)
  broadcast.449 = f32[32,32]{1,0} broadcast(Arg_2.448), dimensions={}
  ROOT select.450 = f32[32,32]{1,0} select(Arg_0.446, Arg_1.447, broadcast.449)
}

_where.454 {
  Arg_0.455 = pred[32,32]{1,0} parameter(0)
  Arg_1.456 = f32[32,32]{1,0} parameter(1)
  Arg_2.457 = f32[] parameter(2)
  broadcast.458 = f32[32,32]{1,0} broadcast(Arg_2.457), dimensions={}
  ROOT select.459 = f32[32,32]{1,0} select(Arg_0.455, Arg_1.456, broadcast.458)
}

_where.462 {
  Arg_0.463 = pred[32,32]{1,0} parameter(0)
  Arg_1.464 = f32[32,32]{1,0} parameter(1)
  Arg_2.465 = f32[] parameter(2)
  broadcast.466 = f32[32,32]{1,0} broadcast(Arg_2.465), dimensions={}
  ROOT select.467 = f32[32,32]{1,0} select(Arg_0.463, Arg_1.464, broadcast.466)
}

_where.471 {
  Arg_0.472 = pred[32,32]{1,0} parameter(0)
  Arg_1.473 = f32[32,32]{1,0} parameter(1)
  Arg_2.474 = f32[] parameter(2)
  broadcast.475 = f32[32,32]{1,0} broadcast(Arg_2.474), dimensions={}
  ROOT select.476 = f32[32,32]{1,0} select(Arg_0.472, Arg_1.473, broadcast.475)
}

_where.480 {
  Arg_0.481 = pred[32,32]{1,0} parameter(0)
  Arg_1.482 = f32[32,32]{1,0} parameter(1)
  Arg_2.483 = f32[] parameter(2)
  broadcast.484 = f32[32,32]{1,0} broadcast(Arg_2.483), dimensions={}
  ROOT select.485 = f32[32,32]{1,0} select(Arg_0.481, Arg_1.482, broadcast.484)
}

_where.489 {
  Arg_0.490 = pred[32,32]{1,0} parameter(0)
  Arg_1.491 = f32[32,32]{1,0} parameter(1)
  Arg_2.492 = f32[] parameter(2)
  broadcast.493 = f32[32,32]{1,0} broadcast(Arg_2.492), dimensions={}
  ROOT select.494 = f32[32,32]{1,0} select(Arg_0.490, Arg_1.491, broadcast.493)
}

_where.498 {
  Arg_0.499 = pred[32,32]{1,0} parameter(0)
  Arg_1.500 = f32[32,32]{1,0} parameter(1)
  Arg_2.501 = f32[] parameter(2)
  broadcast.502 = f32[32,32]{1,0} broadcast(Arg_2.501), dimensions={}
  ROOT select.503 = f32[32,32]{1,0} select(Arg_0.499, Arg_1.500, broadcast.502)
}

_where.507 {
  Arg_0.508 = pred[32,32]{1,0} parameter(0)
  Arg_1.509 = f32[32,32]{1,0} parameter(1)
  Arg_2.510 = f32[] parameter(2)
  broadcast.511 = f32[32,32]{1,0} broadcast(Arg_2.510), dimensions={}
  ROOT select.512 = f32[32,32]{1,0} select(Arg_0.508, Arg_1.509, broadcast.511)
}

_where.515 {
  Arg_0.516 = pred[32,32]{1,0} parameter(0)
  Arg_1.517 = f32[32,32]{1,0} parameter(1)
  Arg_2.518 = f32[] parameter(2)
  broadcast.519 = f32[32,32]{1,0} broadcast(Arg_2.518), dimensions={}
  ROOT select.520 = f32[32,32]{1,0} select(Arg_0.516, Arg_1.517, broadcast.519)
}

_where.524 {
  Arg_0.525 = pred[32,32]{1,0} parameter(0)
  Arg_1.526 = f32[32,32]{1,0} parameter(1)
  Arg_2.527 = f32[] parameter(2)
  broadcast.528 = f32[32,32]{1,0} broadcast(Arg_2.527), dimensions={}
  ROOT select.529 = f32[32,32]{1,0} select(Arg_0.525, Arg_1.526, broadcast.528)
}

_where.533 {
  Arg_0.534 = pred[32,32]{1,0} parameter(0)
  Arg_1.535 = f32[32,32]{1,0} parameter(1)
  Arg_2.536 = f32[] parameter(2)
  broadcast.537 = f32[32,32]{1,0} broadcast(Arg_2.536), dimensions={}
  ROOT select.538 = f32[32,32]{1,0} select(Arg_0.534, Arg_1.535, broadcast.537)
}

_where.542 {
  Arg_0.543 = pred[32,32]{1,0} parameter(0)
  Arg_1.544 = f32[32,32]{1,0} parameter(1)
  Arg_2.545 = f32[] parameter(2)
  broadcast.546 = f32[32,32]{1,0} broadcast(Arg_2.545), dimensions={}
  ROOT select.547 = f32[32,32]{1,0} select(Arg_0.543, Arg_1.544, broadcast.546)
}

_where.551 {
  Arg_0.552 = pred[32,32]{1,0} parameter(0)
  Arg_1.553 = f32[32,32]{1,0} parameter(1)
  Arg_2.554 = f32[] parameter(2)
  broadcast.555 = f32[32,32]{1,0} broadcast(Arg_2.554), dimensions={}
  ROOT select.556 = f32[32,32]{1,0} select(Arg_0.552, Arg_1.553, broadcast.555)
}

_where.560 {
  Arg_0.561 = pred[32,32]{1,0} parameter(0)
  Arg_1.562 = f32[32,32]{1,0} parameter(1)
  Arg_2.563 = f32[] parameter(2)
  broadcast.564 = f32[32,32]{1,0} broadcast(Arg_2.563), dimensions={}
  ROOT select.565 = f32[32,32]{1,0} select(Arg_0.561, Arg_1.562, broadcast.564)
}

_where.568 {
  Arg_0.569 = pred[32,32]{1,0} parameter(0)
  Arg_1.570 = f32[32,32]{1,0} parameter(1)
  Arg_2.571 = f32[] parameter(2)
  broadcast.572 = f32[32,32]{1,0} broadcast(Arg_2.571), dimensions={}
  ROOT select.573 = f32[32,32]{1,0} select(Arg_0.569, Arg_1.570, broadcast.572)
}

_where.577 {
  Arg_0.578 = pred[32,32]{1,0} parameter(0)
  Arg_1.579 = f32[32,32]{1,0} parameter(1)
  Arg_2.580 = f32[] parameter(2)
  broadcast.581 = f32[32,32]{1,0} broadcast(Arg_2.580), dimensions={}
  ROOT select.582 = f32[32,32]{1,0} select(Arg_0.578, Arg_1.579, broadcast.581)
}

_where.586 {
  Arg_0.587 = pred[32,32]{1,0} parameter(0)
  Arg_1.588 = f32[32,32]{1,0} parameter(1)
  Arg_2.589 = f32[] parameter(2)
  broadcast.590 = f32[32,32]{1,0} broadcast(Arg_2.589), dimensions={}
  ROOT select.591 = f32[32,32]{1,0} select(Arg_0.587, Arg_1.588, broadcast.590)
}

_where.595 {
  Arg_0.596 = pred[32,32]{1,0} parameter(0)
  Arg_1.597 = f32[32,32]{1,0} parameter(1)
  Arg_2.598 = f32[] parameter(2)
  broadcast.599 = f32[32,32]{1,0} broadcast(Arg_2.598), dimensions={}
  ROOT select.600 = f32[32,32]{1,0} select(Arg_0.596, Arg_1.597, broadcast.599)
}

_where.604 {
  Arg_0.605 = pred[32,32]{1,0} parameter(0)
  Arg_1.606 = f32[32,32]{1,0} parameter(1)
  Arg_2.607 = f32[] parameter(2)
  broadcast.608 = f32[32,32]{1,0} broadcast(Arg_2.607), dimensions={}
  ROOT select.609 = f32[32,32]{1,0} select(Arg_0.605, Arg_1.606, broadcast.608)
}

_where.613 {
  Arg_0.614 = pred[32,32]{1,0} parameter(0)
  Arg_1.615 = f32[32,32]{1,0} parameter(1)
  Arg_2.616 = f32[] parameter(2)
  broadcast.617 = f32[32,32]{1,0} broadcast(Arg_2.616), dimensions={}
  ROOT select.618 = f32[32,32]{1,0} select(Arg_0.614, Arg_1.615, broadcast.617)
}

_where.621 {
  Arg_0.622 = pred[32,32]{1,0} parameter(0)
  Arg_1.623 = f32[32,32]{1,0} parameter(1)
  Arg_2.624 = f32[] parameter(2)
  broadcast.625 = f32[32,32]{1,0} broadcast(Arg_2.624), dimensions={}
  ROOT select.626 = f32[32,32]{1,0} select(Arg_0.622, Arg_1.623, broadcast.625)
}

_where.630 {
  Arg_0.631 = pred[32,32]{1,0} parameter(0)
  Arg_1.632 = f32[32,32]{1,0} parameter(1)
  Arg_2.633 = f32[] parameter(2)
  broadcast.634 = f32[32,32]{1,0} broadcast(Arg_2.633), dimensions={}
  ROOT select.635 = f32[32,32]{1,0} select(Arg_0.631, Arg_1.632, broadcast.634)
}

_where.639 {
  Arg_0.640 = pred[32,32]{1,0} parameter(0)
  Arg_1.641 = f32[32,32]{1,0} parameter(1)
  Arg_2.642 = f32[] parameter(2)
  broadcast.643 = f32[32,32]{1,0} broadcast(Arg_2.642), dimensions={}
  ROOT select.644 = f32[32,32]{1,0} select(Arg_0.640, Arg_1.641, broadcast.643)
}

_where.648 {
  Arg_0.649 = pred[32,32]{1,0} parameter(0)
  Arg_1.650 = f32[32,32]{1,0} parameter(1)
  Arg_2.651 = f32[] parameter(2)
  broadcast.652 = f32[32,32]{1,0} broadcast(Arg_2.651), dimensions={}
  ROOT select.653 = f32[32,32]{1,0} select(Arg_0.649, Arg_1.650, broadcast.652)
}

_where.657 {
  Arg_0.658 = pred[32,32]{1,0} parameter(0)
  Arg_1.659 = f32[32,32]{1,0} parameter(1)
  Arg_2.660 = f32[] parameter(2)
  broadcast.661 = f32[32,32]{1,0} broadcast(Arg_2.660), dimensions={}
  ROOT select.662 = f32[32,32]{1,0} select(Arg_0.658, Arg_1.659, broadcast.661)
}

_where.666 {
  Arg_0.667 = pred[32,32]{1,0} parameter(0)
  Arg_1.668 = f32[32,32]{1,0} parameter(1)
  Arg_2.669 = f32[] parameter(2)
  broadcast.670 = f32[32,32]{1,0} broadcast(Arg_2.669), dimensions={}
  ROOT select.671 = f32[32,32]{1,0} select(Arg_0.667, Arg_1.668, broadcast.670)
}

_where.674 {
  Arg_0.675 = pred[32,32]{1,0} parameter(0)
  Arg_1.676 = f32[32,32]{1,0} parameter(1)
  Arg_2.677 = f32[] parameter(2)
  broadcast.678 = f32[32,32]{1,0} broadcast(Arg_2.677), dimensions={}
  ROOT select.679 = f32[32,32]{1,0} select(Arg_0.675, Arg_1.676, broadcast.678)
}

_where.683 {
  Arg_0.684 = pred[32,32]{1,0} parameter(0)
  Arg_1.685 = f32[32,32]{1,0} parameter(1)
  Arg_2.686 = f32[] parameter(2)
  broadcast.687 = f32[32,32]{1,0} broadcast(Arg_2.686), dimensions={}
  ROOT select.688 = f32[32,32]{1,0} select(Arg_0.684, Arg_1.685, broadcast.687)
}

_where.692 {
  Arg_0.693 = pred[32,32]{1,0} parameter(0)
  Arg_1.694 = f32[32,32]{1,0} parameter(1)
  Arg_2.695 = f32[] parameter(2)
  broadcast.696 = f32[32,32]{1,0} broadcast(Arg_2.695), dimensions={}
  ROOT select.697 = f32[32,32]{1,0} select(Arg_0.693, Arg_1.694, broadcast.696)
}

_where.701 {
  Arg_0.702 = pred[32,32]{1,0} parameter(0)
  Arg_1.703 = f32[32,32]{1,0} parameter(1)
  Arg_2.704 = f32[] parameter(2)
  broadcast.705 = f32[32,32]{1,0} broadcast(Arg_2.704), dimensions={}
  ROOT select.706 = f32[32,32]{1,0} select(Arg_0.702, Arg_1.703, broadcast.705)
}

_where.710 {
  Arg_0.711 = pred[32,32]{1,0} parameter(0)
  Arg_1.712 = f32[32,32]{1,0} parameter(1)
  Arg_2.713 = f32[] parameter(2)
  broadcast.714 = f32[32,32]{1,0} broadcast(Arg_2.713), dimensions={}
  ROOT select.715 = f32[32,32]{1,0} select(Arg_0.711, Arg_1.712, broadcast.714)
}

_pad.718 {
  Arg_0.719 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  Arg_1.720 = s32[] parameter(1)
  convert.721 = f32[] convert(Arg_1.720)
  ROOT pad.722 = f32[32,32,38,32]{3,2,1,0} pad(Arg_0.719, convert.721), padding=0_0x0_0x3_3x0_0
}

_where.840 {
  Arg_0.841 = pred[32,32]{1,0} parameter(0)
  Arg_1.842 = f32[32,32]{1,0} parameter(1)
  Arg_2.843 = f32[] parameter(2)
  broadcast.844 = f32[32,32]{1,0} broadcast(Arg_2.843), dimensions={}
  ROOT select.845 = f32[32,32]{1,0} select(Arg_0.841, Arg_1.842, broadcast.844)
}

_where.848 {
  Arg_0.849 = pred[32,32]{1,0} parameter(0)
  Arg_1.850 = f32[32,32]{1,0} parameter(1)
  Arg_2.851 = f32[] parameter(2)
  broadcast.852 = f32[32,32]{1,0} broadcast(Arg_2.851), dimensions={}
  ROOT select.853 = f32[32,32]{1,0} select(Arg_0.849, Arg_1.850, broadcast.852)
}

_where.857 {
  Arg_0.858 = pred[32,32]{1,0} parameter(0)
  Arg_1.859 = f32[32,32]{1,0} parameter(1)
  Arg_2.860 = f32[] parameter(2)
  broadcast.861 = f32[32,32]{1,0} broadcast(Arg_2.860), dimensions={}
  ROOT select.862 = f32[32,32]{1,0} select(Arg_0.858, Arg_1.859, broadcast.861)
}

_where.866 {
  Arg_0.867 = pred[32,32]{1,0} parameter(0)
  Arg_1.868 = f32[32,32]{1,0} parameter(1)
  Arg_2.869 = f32[] parameter(2)
  broadcast.870 = f32[32,32]{1,0} broadcast(Arg_2.869), dimensions={}
  ROOT select.871 = f32[32,32]{1,0} select(Arg_0.867, Arg_1.868, broadcast.870)
}

_where.875 {
  Arg_0.876 = pred[32,32]{1,0} parameter(0)
  Arg_1.877 = f32[32,32]{1,0} parameter(1)
  Arg_2.878 = f32[] parameter(2)
  broadcast.879 = f32[32,32]{1,0} broadcast(Arg_2.878), dimensions={}
  ROOT select.880 = f32[32,32]{1,0} select(Arg_0.876, Arg_1.877, broadcast.879)
}

_where.884 {
  Arg_0.885 = pred[32,32]{1,0} parameter(0)
  Arg_1.886 = f32[32,32]{1,0} parameter(1)
  Arg_2.887 = f32[] parameter(2)
  broadcast.888 = f32[32,32]{1,0} broadcast(Arg_2.887), dimensions={}
  ROOT select.889 = f32[32,32]{1,0} select(Arg_0.885, Arg_1.886, broadcast.888)
}

_where.893 {
  Arg_0.894 = pred[32,32]{1,0} parameter(0)
  Arg_1.895 = f32[32,32]{1,0} parameter(1)
  Arg_2.896 = f32[] parameter(2)
  broadcast.897 = f32[32,32]{1,0} broadcast(Arg_2.896), dimensions={}
  ROOT select.898 = f32[32,32]{1,0} select(Arg_0.894, Arg_1.895, broadcast.897)
}

_where.901 {
  Arg_0.902 = pred[32,32]{1,0} parameter(0)
  Arg_1.903 = f32[32,32]{1,0} parameter(1)
  Arg_2.904 = f32[] parameter(2)
  broadcast.905 = f32[32,32]{1,0} broadcast(Arg_2.904), dimensions={}
  ROOT select.906 = f32[32,32]{1,0} select(Arg_0.902, Arg_1.903, broadcast.905)
}

_where.910 {
  Arg_0.911 = pred[32,32]{1,0} parameter(0)
  Arg_1.912 = f32[32,32]{1,0} parameter(1)
  Arg_2.913 = f32[] parameter(2)
  broadcast.914 = f32[32,32]{1,0} broadcast(Arg_2.913), dimensions={}
  ROOT select.915 = f32[32,32]{1,0} select(Arg_0.911, Arg_1.912, broadcast.914)
}

_where.919 {
  Arg_0.920 = pred[32,32]{1,0} parameter(0)
  Arg_1.921 = f32[32,32]{1,0} parameter(1)
  Arg_2.922 = f32[] parameter(2)
  broadcast.923 = f32[32,32]{1,0} broadcast(Arg_2.922), dimensions={}
  ROOT select.924 = f32[32,32]{1,0} select(Arg_0.920, Arg_1.921, broadcast.923)
}

_where.928 {
  Arg_0.929 = pred[32,32]{1,0} parameter(0)
  Arg_1.930 = f32[32,32]{1,0} parameter(1)
  Arg_2.931 = f32[] parameter(2)
  broadcast.932 = f32[32,32]{1,0} broadcast(Arg_2.931), dimensions={}
  ROOT select.933 = f32[32,32]{1,0} select(Arg_0.929, Arg_1.930, broadcast.932)
}

_where.937 {
  Arg_0.938 = pred[32,32]{1,0} parameter(0)
  Arg_1.939 = f32[32,32]{1,0} parameter(1)
  Arg_2.940 = f32[] parameter(2)
  broadcast.941 = f32[32,32]{1,0} broadcast(Arg_2.940), dimensions={}
  ROOT select.942 = f32[32,32]{1,0} select(Arg_0.938, Arg_1.939, broadcast.941)
}

_where.946 {
  Arg_0.947 = pred[32,32]{1,0} parameter(0)
  Arg_1.948 = f32[32,32]{1,0} parameter(1)
  Arg_2.949 = f32[] parameter(2)
  broadcast.950 = f32[32,32]{1,0} broadcast(Arg_2.949), dimensions={}
  ROOT select.951 = f32[32,32]{1,0} select(Arg_0.947, Arg_1.948, broadcast.950)
}

_where.954 {
  Arg_0.955 = pred[32,32]{1,0} parameter(0)
  Arg_1.956 = f32[32,32]{1,0} parameter(1)
  Arg_2.957 = f32[] parameter(2)
  broadcast.958 = f32[32,32]{1,0} broadcast(Arg_2.957), dimensions={}
  ROOT select.959 = f32[32,32]{1,0} select(Arg_0.955, Arg_1.956, broadcast.958)
}

_where.963 {
  Arg_0.964 = pred[32,32]{1,0} parameter(0)
  Arg_1.965 = f32[32,32]{1,0} parameter(1)
  Arg_2.966 = f32[] parameter(2)
  broadcast.967 = f32[32,32]{1,0} broadcast(Arg_2.966), dimensions={}
  ROOT select.968 = f32[32,32]{1,0} select(Arg_0.964, Arg_1.965, broadcast.967)
}

_where.972 {
  Arg_0.973 = pred[32,32]{1,0} parameter(0)
  Arg_1.974 = f32[32,32]{1,0} parameter(1)
  Arg_2.975 = f32[] parameter(2)
  broadcast.976 = f32[32,32]{1,0} broadcast(Arg_2.975), dimensions={}
  ROOT select.977 = f32[32,32]{1,0} select(Arg_0.973, Arg_1.974, broadcast.976)
}

_where.981 {
  Arg_0.982 = pred[32,32]{1,0} parameter(0)
  Arg_1.983 = f32[32,32]{1,0} parameter(1)
  Arg_2.984 = f32[] parameter(2)
  broadcast.985 = f32[32,32]{1,0} broadcast(Arg_2.984), dimensions={}
  ROOT select.986 = f32[32,32]{1,0} select(Arg_0.982, Arg_1.983, broadcast.985)
}

_where.990 {
  Arg_0.991 = pred[32,32]{1,0} parameter(0)
  Arg_1.992 = f32[32,32]{1,0} parameter(1)
  Arg_2.993 = f32[] parameter(2)
  broadcast.994 = f32[32,32]{1,0} broadcast(Arg_2.993), dimensions={}
  ROOT select.995 = f32[32,32]{1,0} select(Arg_0.991, Arg_1.992, broadcast.994)
}

_where.999 {
  Arg_0.1000 = pred[32,32]{1,0} parameter(0)
  Arg_1.1001 = f32[32,32]{1,0} parameter(1)
  Arg_2.1002 = f32[] parameter(2)
  broadcast.1003 = f32[32,32]{1,0} broadcast(Arg_2.1002), dimensions={}
  ROOT select.1004 = f32[32,32]{1,0} select(Arg_0.1000, Arg_1.1001, broadcast.1003)
}

_where.1007 {
  Arg_0.1008 = pred[32,32]{1,0} parameter(0)
  Arg_1.1009 = f32[32,32]{1,0} parameter(1)
  Arg_2.1010 = f32[] parameter(2)
  broadcast.1011 = f32[32,32]{1,0} broadcast(Arg_2.1010), dimensions={}
  ROOT select.1012 = f32[32,32]{1,0} select(Arg_0.1008, Arg_1.1009, broadcast.1011)
}

_where.1016 {
  Arg_0.1017 = pred[32,32]{1,0} parameter(0)
  Arg_1.1018 = f32[32,32]{1,0} parameter(1)
  Arg_2.1019 = f32[] parameter(2)
  broadcast.1020 = f32[32,32]{1,0} broadcast(Arg_2.1019), dimensions={}
  ROOT select.1021 = f32[32,32]{1,0} select(Arg_0.1017, Arg_1.1018, broadcast.1020)
}

_where.1025 {
  Arg_0.1026 = pred[32,32]{1,0} parameter(0)
  Arg_1.1027 = f32[32,32]{1,0} parameter(1)
  Arg_2.1028 = f32[] parameter(2)
  broadcast.1029 = f32[32,32]{1,0} broadcast(Arg_2.1028), dimensions={}
  ROOT select.1030 = f32[32,32]{1,0} select(Arg_0.1026, Arg_1.1027, broadcast.1029)
}

_where.1034 {
  Arg_0.1035 = pred[32,32]{1,0} parameter(0)
  Arg_1.1036 = f32[32,32]{1,0} parameter(1)
  Arg_2.1037 = f32[] parameter(2)
  broadcast.1038 = f32[32,32]{1,0} broadcast(Arg_2.1037), dimensions={}
  ROOT select.1039 = f32[32,32]{1,0} select(Arg_0.1035, Arg_1.1036, broadcast.1038)
}

_where.1043 {
  Arg_0.1044 = pred[32,32]{1,0} parameter(0)
  Arg_1.1045 = f32[32,32]{1,0} parameter(1)
  Arg_2.1046 = f32[] parameter(2)
  broadcast.1047 = f32[32,32]{1,0} broadcast(Arg_2.1046), dimensions={}
  ROOT select.1048 = f32[32,32]{1,0} select(Arg_0.1044, Arg_1.1045, broadcast.1047)
}

_where.1052 {
  Arg_0.1053 = pred[32,32]{1,0} parameter(0)
  Arg_1.1054 = f32[32,32]{1,0} parameter(1)
  Arg_2.1055 = f32[] parameter(2)
  broadcast.1056 = f32[32,32]{1,0} broadcast(Arg_2.1055), dimensions={}
  ROOT select.1057 = f32[32,32]{1,0} select(Arg_0.1053, Arg_1.1054, broadcast.1056)
}

_where.1060 {
  Arg_0.1061 = pred[32,32]{1,0} parameter(0)
  Arg_1.1062 = f32[32,32]{1,0} parameter(1)
  Arg_2.1063 = f32[] parameter(2)
  broadcast.1064 = f32[32,32]{1,0} broadcast(Arg_2.1063), dimensions={}
  ROOT select.1065 = f32[32,32]{1,0} select(Arg_0.1061, Arg_1.1062, broadcast.1064)
}

_where.1069 {
  Arg_0.1070 = pred[32,32]{1,0} parameter(0)
  Arg_1.1071 = f32[32,32]{1,0} parameter(1)
  Arg_2.1072 = f32[] parameter(2)
  broadcast.1073 = f32[32,32]{1,0} broadcast(Arg_2.1072), dimensions={}
  ROOT select.1074 = f32[32,32]{1,0} select(Arg_0.1070, Arg_1.1071, broadcast.1073)
}

_where.1078 {
  Arg_0.1079 = pred[32,32]{1,0} parameter(0)
  Arg_1.1080 = f32[32,32]{1,0} parameter(1)
  Arg_2.1081 = f32[] parameter(2)
  broadcast.1082 = f32[32,32]{1,0} broadcast(Arg_2.1081), dimensions={}
  ROOT select.1083 = f32[32,32]{1,0} select(Arg_0.1079, Arg_1.1080, broadcast.1082)
}

_where.1087 {
  Arg_0.1088 = pred[32,32]{1,0} parameter(0)
  Arg_1.1089 = f32[32,32]{1,0} parameter(1)
  Arg_2.1090 = f32[] parameter(2)
  broadcast.1091 = f32[32,32]{1,0} broadcast(Arg_2.1090), dimensions={}
  ROOT select.1092 = f32[32,32]{1,0} select(Arg_0.1088, Arg_1.1089, broadcast.1091)
}

_where.1096 {
  Arg_0.1097 = pred[32,32]{1,0} parameter(0)
  Arg_1.1098 = f32[32,32]{1,0} parameter(1)
  Arg_2.1099 = f32[] parameter(2)
  broadcast.1100 = f32[32,32]{1,0} broadcast(Arg_2.1099), dimensions={}
  ROOT select.1101 = f32[32,32]{1,0} select(Arg_0.1097, Arg_1.1098, broadcast.1100)
}

_where.1105 {
  Arg_0.1106 = pred[32,32]{1,0} parameter(0)
  Arg_1.1107 = f32[32,32]{1,0} parameter(1)
  Arg_2.1108 = f32[] parameter(2)
  broadcast.1109 = f32[32,32]{1,0} broadcast(Arg_2.1108), dimensions={}
  ROOT select.1110 = f32[32,32]{1,0} select(Arg_0.1106, Arg_1.1107, broadcast.1109)
}

_where.1113 {
  Arg_0.1114 = pred[32,32]{1,0} parameter(0)
  Arg_1.1115 = f32[32,32]{1,0} parameter(1)
  Arg_2.1116 = f32[] parameter(2)
  broadcast.1117 = f32[32,32]{1,0} broadcast(Arg_2.1116), dimensions={}
  ROOT select.1118 = f32[32,32]{1,0} select(Arg_0.1114, Arg_1.1115, broadcast.1117)
}

_where.1122 {
  Arg_0.1123 = pred[32,32]{1,0} parameter(0)
  Arg_1.1124 = f32[32,32]{1,0} parameter(1)
  Arg_2.1125 = f32[] parameter(2)
  broadcast.1126 = f32[32,32]{1,0} broadcast(Arg_2.1125), dimensions={}
  ROOT select.1127 = f32[32,32]{1,0} select(Arg_0.1123, Arg_1.1124, broadcast.1126)
}

_where.1131 {
  Arg_0.1132 = pred[32,32]{1,0} parameter(0)
  Arg_1.1133 = f32[32,32]{1,0} parameter(1)
  Arg_2.1134 = f32[] parameter(2)
  broadcast.1135 = f32[32,32]{1,0} broadcast(Arg_2.1134), dimensions={}
  ROOT select.1136 = f32[32,32]{1,0} select(Arg_0.1132, Arg_1.1133, broadcast.1135)
}

_where.1140 {
  Arg_0.1141 = pred[32,32]{1,0} parameter(0)
  Arg_1.1142 = f32[32,32]{1,0} parameter(1)
  Arg_2.1143 = f32[] parameter(2)
  broadcast.1144 = f32[32,32]{1,0} broadcast(Arg_2.1143), dimensions={}
  ROOT select.1145 = f32[32,32]{1,0} select(Arg_0.1141, Arg_1.1142, broadcast.1144)
}

_where.1149 {
  Arg_0.1150 = pred[32,32]{1,0} parameter(0)
  Arg_1.1151 = f32[32,32]{1,0} parameter(1)
  Arg_2.1152 = f32[] parameter(2)
  broadcast.1153 = f32[32,32]{1,0} broadcast(Arg_2.1152), dimensions={}
  ROOT select.1154 = f32[32,32]{1,0} select(Arg_0.1150, Arg_1.1151, broadcast.1153)
}

_where.1158 {
  Arg_0.1159 = pred[32,32]{1,0} parameter(0)
  Arg_1.1160 = f32[32,32]{1,0} parameter(1)
  Arg_2.1161 = f32[] parameter(2)
  broadcast.1162 = f32[32,32]{1,0} broadcast(Arg_2.1161), dimensions={}
  ROOT select.1163 = f32[32,32]{1,0} select(Arg_0.1159, Arg_1.1160, broadcast.1162)
}

_where.1166 {
  Arg_0.1167 = pred[32,32]{1,0} parameter(0)
  Arg_1.1168 = f32[32,32]{1,0} parameter(1)
  Arg_2.1169 = f32[] parameter(2)
  broadcast.1170 = f32[32,32]{1,0} broadcast(Arg_2.1169), dimensions={}
  ROOT select.1171 = f32[32,32]{1,0} select(Arg_0.1167, Arg_1.1168, broadcast.1170)
}

_where.1175 {
  Arg_0.1176 = pred[32,32]{1,0} parameter(0)
  Arg_1.1177 = f32[32,32]{1,0} parameter(1)
  Arg_2.1178 = f32[] parameter(2)
  broadcast.1179 = f32[32,32]{1,0} broadcast(Arg_2.1178), dimensions={}
  ROOT select.1180 = f32[32,32]{1,0} select(Arg_0.1176, Arg_1.1177, broadcast.1179)
}

_where.1184 {
  Arg_0.1185 = pred[32,32]{1,0} parameter(0)
  Arg_1.1186 = f32[32,32]{1,0} parameter(1)
  Arg_2.1187 = f32[] parameter(2)
  broadcast.1188 = f32[32,32]{1,0} broadcast(Arg_2.1187), dimensions={}
  ROOT select.1189 = f32[32,32]{1,0} select(Arg_0.1185, Arg_1.1186, broadcast.1188)
}

_where.1193 {
  Arg_0.1194 = pred[32,32]{1,0} parameter(0)
  Arg_1.1195 = f32[32,32]{1,0} parameter(1)
  Arg_2.1196 = f32[] parameter(2)
  broadcast.1197 = f32[32,32]{1,0} broadcast(Arg_2.1196), dimensions={}
  ROOT select.1198 = f32[32,32]{1,0} select(Arg_0.1194, Arg_1.1195, broadcast.1197)
}

_where.1202 {
  Arg_0.1203 = pred[32,32]{1,0} parameter(0)
  Arg_1.1204 = f32[32,32]{1,0} parameter(1)
  Arg_2.1205 = f32[] parameter(2)
  broadcast.1206 = f32[32,32]{1,0} broadcast(Arg_2.1205), dimensions={}
  ROOT select.1207 = f32[32,32]{1,0} select(Arg_0.1203, Arg_1.1204, broadcast.1206)
}

_pad_16.1210 {
  Arg_0.1211 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  Arg_1.1212 = s32[] parameter(1)
  convert.1213 = f32[] convert(Arg_1.1212)
  ROOT pad.1214 = f32[32,32,32,38]{3,2,1,0} pad(Arg_0.1211, convert.1213), padding=0_0x0_0x0_0x3_3
}

_roll_static_7.1265 {
  Arg_0.1266 = f32[32,32,32,16]{3,2,1,0} parameter(0)
  slice.1267 = f32[32,31,32,16]{3,2,1,0} slice(Arg_0.1266), slice={[0:32], [1:32], [0:32], [0:16]}
  slice.1268 = f32[32,1,32,16]{3,2,1,0} slice(Arg_0.1266), slice={[0:32], [0:1], [0:32], [0:16]}
  ROOT concatenate.1269 = f32[32,32,32,16]{3,2,1,0} concatenate(slice.1267, slice.1268), dimensions={1}
}

_roll_static_8.1272 {
  ROOT Arg_0.1273 = f32[32,32,32,16]{3,2,1,0} parameter(0)
}

_roll_static_9.1276 {
  Arg_0.1277 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.1278 = f32[32,30,32,32]{3,2,1,0} slice(Arg_0.1277), slice={[0:32], [2:32], [0:32], [0:32]}
  slice.1279 = f32[32,2,32,32]{3,2,1,0} slice(Arg_0.1277), slice={[0:32], [0:2], [0:32], [0:32]}
  ROOT concatenate.1280 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.1278, slice.1279), dimensions={1}
}

_roll_static_10.1286 {
  Arg_0.1287 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.1288 = f32[32,31,32,32]{3,2,1,0} slice(Arg_0.1287), slice={[0:32], [1:32], [0:32], [0:32]}
  slice.1289 = f32[32,1,32,32]{3,2,1,0} slice(Arg_0.1287), slice={[0:32], [0:1], [0:32], [0:32]}
  ROOT concatenate.1290 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.1288, slice.1289), dimensions={1}
}

_roll_static_11.1297 {
  ROOT Arg_0.1298 = f32[32,32,32,32]{3,2,1,0} parameter(0)
}

_roll_static_12.1305 {
  Arg_0.1306 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.1307 = f32[32,1,32,32]{3,2,1,0} slice(Arg_0.1306), slice={[0:32], [31:32], [0:32], [0:32]}
  slice.1308 = f32[32,31,32,32]{3,2,1,0} slice(Arg_0.1306), slice={[0:32], [0:31], [0:32], [0:32]}
  ROOT concatenate.1309 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.1307, slice.1308), dimensions={1}
}

_roll_static_13.1316 {
  Arg_0.1317 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.1318 = f32[32,2,32,32]{3,2,1,0} slice(Arg_0.1317), slice={[0:32], [30:32], [0:32], [0:32]}
  slice.1319 = f32[32,30,32,32]{3,2,1,0} slice(Arg_0.1317), slice={[0:32], [0:30], [0:32], [0:32]}
  ROOT concatenate.1320 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.1318, slice.1319), dimensions={1}
}

_roll_static_14.1327 {
  Arg_0.1328 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.1329 = f32[32,3,32,32]{3,2,1,0} slice(Arg_0.1328), slice={[0:32], [29:32], [0:32], [0:32]}
  slice.1330 = f32[32,29,32,32]{3,2,1,0} slice(Arg_0.1328), slice={[0:32], [0:29], [0:32], [0:32]}
  ROOT concatenate.1331 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.1329, slice.1330), dimensions={1}
}

_roll_static.1339 {
  Arg_0.1340 = f32[32,32,16,32]{3,2,1,0} parameter(0)
  slice.1341 = f32[31,32,16,32]{3,2,1,0} slice(Arg_0.1340), slice={[1:32], [0:32], [0:16], [0:32]}
  slice.1342 = f32[1,32,16,32]{3,2,1,0} slice(Arg_0.1340), slice={[0:1], [0:32], [0:16], [0:32]}
  ROOT concatenate.1343 = f32[32,32,16,32]{3,2,1,0} concatenate(slice.1341, slice.1342), dimensions={0}
}

_roll_static_0.1346 {
  ROOT Arg_0.1347 = f32[32,32,16,32]{3,2,1,0} parameter(0)
}

_roll_static_1.1350 {
  Arg_0.1351 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.1352 = f32[30,32,32,32]{3,2,1,0} slice(Arg_0.1351), slice={[2:32], [0:32], [0:32], [0:32]}
  slice.1353 = f32[2,32,32,32]{3,2,1,0} slice(Arg_0.1351), slice={[0:2], [0:32], [0:32], [0:32]}
  ROOT concatenate.1354 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.1352, slice.1353), dimensions={0}
}

_roll_static_2.1360 {
  Arg_0.1361 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.1362 = f32[31,32,32,32]{3,2,1,0} slice(Arg_0.1361), slice={[1:32], [0:32], [0:32], [0:32]}
  slice.1363 = f32[1,32,32,32]{3,2,1,0} slice(Arg_0.1361), slice={[0:1], [0:32], [0:32], [0:32]}
  ROOT concatenate.1364 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.1362, slice.1363), dimensions={0}
}

_roll_static_3.1371 {
  ROOT Arg_0.1372 = f32[32,32,32,32]{3,2,1,0} parameter(0)
}

_roll_static_4.1379 {
  Arg_0.1380 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.1381 = f32[1,32,32,32]{3,2,1,0} slice(Arg_0.1380), slice={[31:32], [0:32], [0:32], [0:32]}
  slice.1382 = f32[31,32,32,32]{3,2,1,0} slice(Arg_0.1380), slice={[0:31], [0:32], [0:32], [0:32]}
  ROOT concatenate.1383 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.1381, slice.1382), dimensions={0}
}

_roll_static_5.1390 {
  Arg_0.1391 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.1392 = f32[2,32,32,32]{3,2,1,0} slice(Arg_0.1391), slice={[30:32], [0:32], [0:32], [0:32]}
  slice.1393 = f32[30,32,32,32]{3,2,1,0} slice(Arg_0.1391), slice={[0:30], [0:32], [0:32], [0:32]}
  ROOT concatenate.1394 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.1392, slice.1393), dimensions={0}
}

_roll_static_6.1401 {
  Arg_0.1402 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.1403 = f32[3,32,32,32]{3,2,1,0} slice(Arg_0.1402), slice={[29:32], [0:32], [0:32], [0:32]}
  slice.1404 = f32[29,32,32,32]{3,2,1,0} slice(Arg_0.1402), slice={[0:29], [0:32], [0:32], [0:32]}
  ROOT concatenate.1405 = f32[32,32,32,32]{3,2,1,0} concatenate(slice.1403, slice.1404), dimensions={0}
}

ENTRY main.1413 {
  Arg_0.1 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  slice.72 = f32[32,32,16,32]{3,2,1,0} slice(Arg_0.1), slice={[0:32], [0:32], [0:16], [0:32]}
  call.78 = f32[32,32,16,32]{3,2,1,0} call(slice.72), to_apply=_roll_static.73
  slice.79 = f32[32,32,16,32]{3,2,1,0} slice(Arg_0.1), slice={[0:32], [0:32], [16:32], [0:32]}
  call.82 = f32[32,32,16,32]{3,2,1,0} call(slice.79), to_apply=_roll_static_0.80
  concatenate.83 = f32[32,32,32,32]{3,2,1,0} concatenate(call.78, call.82), dimensions={2}
  call.89 = f32[32,32,32,32]{3,2,1,0} call(concatenate.83), to_apply=_roll_static_1.84
  constant.65 = f32[1,1,32,1]{3,2,1,0} constant({...})
  broadcast.90 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.65), dimensions={0,1,2,3}
  reshape.91 = f32[32]{0} reshape(broadcast.90)
  broadcast.92 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.91), dimensions={2}
  multiply.93 = f32[32,32,32,32]{3,2,1,0} multiply(call.89, broadcast.92)
  call.99 = f32[32,32,32,32]{3,2,1,0} call(concatenate.83), to_apply=_roll_static_2.94
  constant.64 = f32[1,1,32,1]{3,2,1,0} constant({...})
  broadcast.100 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.64), dimensions={0,1,2,3}
  reshape.101 = f32[32]{0} reshape(broadcast.100)
  broadcast.102 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.101), dimensions={2}
  multiply.103 = f32[32,32,32,32]{3,2,1,0} multiply(call.99, broadcast.102)
  add.104 = f32[32,32,32,32]{3,2,1,0} add(multiply.93, multiply.103)
  call.107 = f32[32,32,32,32]{3,2,1,0} call(concatenate.83), to_apply=_roll_static_3.105
  constant.63 = f32[1,1,32,1]{3,2,1,0} constant({...})
  broadcast.108 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.63), dimensions={0,1,2,3}
  reshape.109 = f32[32]{0} reshape(broadcast.108)
  broadcast.110 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.109), dimensions={2}
  multiply.111 = f32[32,32,32,32]{3,2,1,0} multiply(call.107, broadcast.110)
  add.112 = f32[32,32,32,32]{3,2,1,0} add(add.104, multiply.111)
  call.118 = f32[32,32,32,32]{3,2,1,0} call(concatenate.83), to_apply=_roll_static_4.113
  constant.62 = f32[1,1,32,1]{3,2,1,0} constant({...})
  broadcast.119 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.62), dimensions={0,1,2,3}
  reshape.120 = f32[32]{0} reshape(broadcast.119)
  broadcast.121 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.120), dimensions={2}
  multiply.122 = f32[32,32,32,32]{3,2,1,0} multiply(call.118, broadcast.121)
  add.123 = f32[32,32,32,32]{3,2,1,0} add(add.112, multiply.122)
  call.129 = f32[32,32,32,32]{3,2,1,0} call(concatenate.83), to_apply=_roll_static_5.124
  constant.61 = f32[1,1,32,1]{3,2,1,0} constant({...})
  broadcast.130 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.61), dimensions={0,1,2,3}
  reshape.131 = f32[32]{0} reshape(broadcast.130)
  broadcast.132 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.131), dimensions={2}
  multiply.133 = f32[32,32,32,32]{3,2,1,0} multiply(call.129, broadcast.132)
  add.134 = f32[32,32,32,32]{3,2,1,0} add(add.123, multiply.133)
  call.140 = f32[32,32,32,32]{3,2,1,0} call(concatenate.83), to_apply=_roll_static_6.135
  constant.60 = f32[1,1,32,1]{3,2,1,0} constant({...})
  broadcast.141 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.60), dimensions={0,1,2,3}
  reshape.142 = f32[32]{0} reshape(broadcast.141)
  broadcast.143 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.142), dimensions={2}
  multiply.144 = f32[32,32,32,32]{3,2,1,0} multiply(call.140, broadcast.143)
  add.145 = f32[32,32,32,32]{3,2,1,0} add(add.134, multiply.144)
  slice.146 = f32[32,32,32,16]{3,2,1,0} slice(add.145), slice={[0:32], [0:32], [0:32], [0:16]}
  call.152 = f32[32,32,32,16]{3,2,1,0} call(slice.146), to_apply=_roll_static_7.147
  slice.153 = f32[32,32,32,16]{3,2,1,0} slice(add.145), slice={[0:32], [0:32], [0:32], [16:32]}
  call.156 = f32[32,32,32,16]{3,2,1,0} call(slice.153), to_apply=_roll_static_8.154
  concatenate.157 = f32[32,32,32,32]{3,2,1,0} concatenate(call.152, call.156), dimensions={3}
  call.163 = f32[32,32,32,32]{3,2,1,0} call(concatenate.157), to_apply=_roll_static_9.158
  constant.59 = f32[1,1,1,32]{3,2,1,0} constant({...})
  broadcast.164 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.59), dimensions={0,1,2,3}
  reshape.165 = f32[32]{0} reshape(broadcast.164)
  broadcast.166 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.165), dimensions={3}
  multiply.167 = f32[32,32,32,32]{3,2,1,0} multiply(call.163, broadcast.166)
  call.173 = f32[32,32,32,32]{3,2,1,0} call(concatenate.157), to_apply=_roll_static_10.168
  constant.58 = f32[1,1,1,32]{3,2,1,0} constant({...})
  broadcast.174 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.58), dimensions={0,1,2,3}
  reshape.175 = f32[32]{0} reshape(broadcast.174)
  broadcast.176 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.175), dimensions={3}
  multiply.177 = f32[32,32,32,32]{3,2,1,0} multiply(call.173, broadcast.176)
  add.178 = f32[32,32,32,32]{3,2,1,0} add(multiply.167, multiply.177)
  call.181 = f32[32,32,32,32]{3,2,1,0} call(concatenate.157), to_apply=_roll_static_11.179
  constant.57 = f32[1,1,1,32]{3,2,1,0} constant({...})
  broadcast.182 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.57), dimensions={0,1,2,3}
  reshape.183 = f32[32]{0} reshape(broadcast.182)
  broadcast.184 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.183), dimensions={3}
  multiply.185 = f32[32,32,32,32]{3,2,1,0} multiply(call.181, broadcast.184)
  add.186 = f32[32,32,32,32]{3,2,1,0} add(add.178, multiply.185)
  call.192 = f32[32,32,32,32]{3,2,1,0} call(concatenate.157), to_apply=_roll_static_12.187
  constant.56 = f32[1,1,1,32]{3,2,1,0} constant({...})
  broadcast.193 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.56), dimensions={0,1,2,3}
  reshape.194 = f32[32]{0} reshape(broadcast.193)
  broadcast.195 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.194), dimensions={3}
  multiply.196 = f32[32,32,32,32]{3,2,1,0} multiply(call.192, broadcast.195)
  add.197 = f32[32,32,32,32]{3,2,1,0} add(add.186, multiply.196)
  call.203 = f32[32,32,32,32]{3,2,1,0} call(concatenate.157), to_apply=_roll_static_13.198
  constant.55 = f32[1,1,1,32]{3,2,1,0} constant({...})
  broadcast.204 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.55), dimensions={0,1,2,3}
  reshape.205 = f32[32]{0} reshape(broadcast.204)
  broadcast.206 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.205), dimensions={3}
  multiply.207 = f32[32,32,32,32]{3,2,1,0} multiply(call.203, broadcast.206)
  add.208 = f32[32,32,32,32]{3,2,1,0} add(add.197, multiply.207)
  call.214 = f32[32,32,32,32]{3,2,1,0} call(concatenate.157), to_apply=_roll_static_14.209
  constant.54 = f32[1,1,1,32]{3,2,1,0} constant({...})
  broadcast.215 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.54), dimensions={0,1,2,3}
  reshape.216 = f32[32]{0} reshape(broadcast.215)
  broadcast.217 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.216), dimensions={3}
  multiply.218 = f32[32,32,32,32]{3,2,1,0} multiply(call.214, broadcast.217)
  add.219 = f32[32,32,32,32]{3,2,1,0} add(add.208, multiply.218)
  constant.69 = f32[32,1]{1,0} constant({...})
  constant.70 = f32[1,17]{1,0} constant({...})
  constant.71 = f32[32,17]{1,0} constant({...})
  constant.67 = f32[] constant(0.322580636)
  call.275 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) call(add.219, constant.69, constant.70, constant.71, constant.67, constant.67), to_apply=solve_poisson.236
  get-tuple-element.277 = f32[32,32]{1,0} get-tuple-element(call.275), index=1
  constant.52 = f32[] constant(0.05)
  broadcast.53 = f32[32,32]{1,0} broadcast(constant.52), dimensions={}
  multiply.772 = f32[32,32]{1,0} multiply(get-tuple-element.277, broadcast.53)
  constant.50 = f32[] constant(0.322580636)
  broadcast.51 = f32[32,32]{1,0} broadcast(constant.50), dimensions={}
  divide.773 = f32[32,32]{1,0} divide(multiply.772, broadcast.51)
  floor.774 = f32[32,32]{1,0} floor(divide.773)
  convert.776 = s32[32,32]{1,0} convert(floor.774)
  constant.24 = s32[] constant(-1)
  broadcast.25 = s32[32,32]{1,0} broadcast(constant.24), dimensions={}
  compare.839 = pred[32,32]{1,0} compare(convert.776, broadcast.25), direction=EQ
  subtract.775 = f32[32,32]{1,0} subtract(divide.773, floor.774)
  constant.48 = f32[] constant(20)
  broadcast.49 = f32[32,32]{1,0} broadcast(constant.48), dimensions={}
  divide.781 = f32[32,32]{1,0} divide(subtract.775, broadcast.49)
  multiply.777 = f32[32,32]{1,0} multiply(subtract.775, subtract.775)
  constant.46 = f32[] constant(24)
  broadcast.47 = f32[32,32]{1,0} broadcast(constant.46), dimensions={}
  divide.782 = f32[32,32]{1,0} divide(multiply.777, broadcast.47)
  subtract.783 = f32[32,32]{1,0} subtract(divide.781, divide.782)
  multiply.778 = f32[32,32]{1,0} multiply(multiply.777, subtract.775)
  divide.784 = f32[32,32]{1,0} divide(multiply.778, broadcast.47)
  subtract.785 = f32[32,32]{1,0} subtract(subtract.783, divide.784)
  multiply.779 = f32[32,32]{1,0} multiply(multiply.778, subtract.775)
  divide.786 = f32[32,32]{1,0} divide(multiply.779, broadcast.47)
  add.787 = f32[32,32]{1,0} add(subtract.785, divide.786)
  multiply.780 = f32[32,32]{1,0} multiply(multiply.779, subtract.775)
  constant.44 = f32[] constant(120)
  broadcast.45 = f32[32,32]{1,0} broadcast(constant.44), dimensions={}
  divide.788 = f32[32,32]{1,0} divide(multiply.780, broadcast.45)
  subtract.789 = f32[32,32]{1,0} subtract(add.787, divide.788)
  constant.68 = f32[] constant(0)
  call.846 = f32[32,32]{1,0} call(compare.839, subtract.789, constant.68), to_apply=_where.840
  constant.22 = s32[] constant(-2)
  broadcast.23 = s32[32,32]{1,0} broadcast(constant.22), dimensions={}
  compare.847 = pred[32,32]{1,0} compare(convert.776, broadcast.23), direction=EQ
  constant.42 = f32[] constant(2)
  broadcast.43 = f32[32,32]{1,0} broadcast(constant.42), dimensions={}
  divide.790 = f32[32,32]{1,0} divide(subtract.775, broadcast.43)
  negate.791 = f32[32,32]{1,0} negate(divide.790)
  multiply.792 = f32[32,32]{1,0} multiply(multiply.777, broadcast.43)
  constant.40 = f32[] constant(3)
  broadcast.41 = f32[32,32]{1,0} broadcast(constant.40), dimensions={}
  divide.793 = f32[32,32]{1,0} divide(multiply.792, broadcast.41)
  add.794 = f32[32,32]{1,0} add(negate.791, divide.793)
  divide.795 = f32[32,32]{1,0} divide(multiply.778, broadcast.47)
  subtract.796 = f32[32,32]{1,0} subtract(add.794, divide.795)
  constant.38 = f32[] constant(6)
  broadcast.39 = f32[32,32]{1,0} broadcast(constant.38), dimensions={}
  divide.797 = f32[32,32]{1,0} divide(multiply.779, broadcast.39)
  subtract.798 = f32[32,32]{1,0} subtract(subtract.796, divide.797)
  divide.799 = f32[32,32]{1,0} divide(multiply.780, broadcast.47)
  add.800 = f32[32,32]{1,0} add(subtract.798, divide.799)
  call.854 = f32[32,32]{1,0} call(compare.847, add.800, constant.68), to_apply=_where.848
  add.855 = f32[32,32]{1,0} add(call.846, call.854)
  constant.20 = s32[] constant(-3)
  broadcast.21 = s32[32,32]{1,0} broadcast(constant.20), dimensions={}
  compare.856 = pred[32,32]{1,0} compare(convert.776, broadcast.21), direction=EQ
  constant.36 = f32[] constant(1)
  broadcast.37 = f32[32,32]{1,0} broadcast(constant.36), dimensions={}
  divide.801 = f32[32,32]{1,0} divide(subtract.775, broadcast.41)
  subtract.802 = f32[32,32]{1,0} subtract(broadcast.37, divide.801)
  constant.34 = f32[] constant(5)
  broadcast.35 = f32[32,32]{1,0} broadcast(constant.34), dimensions={}
  multiply.803 = f32[32,32]{1,0} multiply(multiply.777, broadcast.35)
  constant.32 = f32[] constant(4)
  broadcast.33 = f32[32,32]{1,0} broadcast(constant.32), dimensions={}
  divide.804 = f32[32,32]{1,0} divide(multiply.803, broadcast.33)
  subtract.805 = f32[32,32]{1,0} subtract(subtract.802, divide.804)
  multiply.806 = f32[32,32]{1,0} multiply(multiply.778, broadcast.35)
  constant.30 = f32[] constant(12)
  broadcast.31 = f32[32,32]{1,0} broadcast(constant.30), dimensions={}
  divide.807 = f32[32,32]{1,0} divide(multiply.806, broadcast.31)
  add.808 = f32[32,32]{1,0} add(subtract.805, divide.807)
  divide.809 = f32[32,32]{1,0} divide(multiply.779, broadcast.33)
  add.810 = f32[32,32]{1,0} add(add.808, divide.809)
  divide.811 = f32[32,32]{1,0} divide(multiply.780, broadcast.31)
  subtract.812 = f32[32,32]{1,0} subtract(add.810, divide.811)
  call.863 = f32[32,32]{1,0} call(compare.856, subtract.812, constant.68), to_apply=_where.857
  add.864 = f32[32,32]{1,0} add(add.855, call.863)
  constant.18 = s32[] constant(-4)
  broadcast.19 = s32[32,32]{1,0} broadcast(constant.18), dimensions={}
  compare.865 = pred[32,32]{1,0} compare(convert.776, broadcast.19), direction=EQ
  multiply.813 = f32[32,32]{1,0} multiply(multiply.777, broadcast.43)
  divide.814 = f32[32,32]{1,0} divide(multiply.813, broadcast.41)
  add.815 = f32[32,32]{1,0} add(subtract.775, divide.814)
  constant.28 = f32[] constant(7)
  broadcast.29 = f32[32,32]{1,0} broadcast(constant.28), dimensions={}
  multiply.816 = f32[32,32]{1,0} multiply(multiply.778, broadcast.29)
  divide.817 = f32[32,32]{1,0} divide(multiply.816, broadcast.31)
  subtract.818 = f32[32,32]{1,0} subtract(add.815, divide.817)
  divide.819 = f32[32,32]{1,0} divide(multiply.779, broadcast.39)
  subtract.820 = f32[32,32]{1,0} subtract(subtract.818, divide.819)
  divide.821 = f32[32,32]{1,0} divide(multiply.780, broadcast.31)
  add.822 = f32[32,32]{1,0} add(subtract.820, divide.821)
  call.872 = f32[32,32]{1,0} call(compare.865, add.822, constant.68), to_apply=_where.866
  add.873 = f32[32,32]{1,0} add(add.864, call.872)
  constant.16 = s32[] constant(-5)
  broadcast.17 = s32[32,32]{1,0} broadcast(constant.16), dimensions={}
  compare.874 = pred[32,32]{1,0} compare(convert.776, broadcast.17), direction=EQ
  divide.823 = f32[32,32]{1,0} divide(subtract.775, broadcast.33)
  negate.824 = f32[32,32]{1,0} negate(divide.823)
  divide.825 = f32[32,32]{1,0} divide(multiply.777, broadcast.47)
  subtract.826 = f32[32,32]{1,0} subtract(negate.824, divide.825)
  multiply.827 = f32[32,32]{1,0} multiply(multiply.778, broadcast.29)
  divide.828 = f32[32,32]{1,0} divide(multiply.827, broadcast.47)
  add.829 = f32[32,32]{1,0} add(subtract.826, divide.828)
  divide.830 = f32[32,32]{1,0} divide(multiply.779, broadcast.47)
  add.831 = f32[32,32]{1,0} add(add.829, divide.830)
  divide.832 = f32[32,32]{1,0} divide(multiply.780, broadcast.47)
  subtract.833 = f32[32,32]{1,0} subtract(add.831, divide.832)
  call.881 = f32[32,32]{1,0} call(compare.874, subtract.833, constant.68), to_apply=_where.875
  add.882 = f32[32,32]{1,0} add(add.873, call.881)
  constant.14 = s32[] constant(-6)
  broadcast.15 = s32[32,32]{1,0} broadcast(constant.14), dimensions={}
  compare.883 = pred[32,32]{1,0} compare(convert.776, broadcast.15), direction=EQ
  constant.26 = f32[] constant(30)
  broadcast.27 = f32[32,32]{1,0} broadcast(constant.26), dimensions={}
  divide.834 = f32[32,32]{1,0} divide(subtract.775, broadcast.27)
  divide.835 = f32[32,32]{1,0} divide(multiply.778, broadcast.47)
  subtract.836 = f32[32,32]{1,0} subtract(divide.834, divide.835)
  divide.837 = f32[32,32]{1,0} divide(multiply.780, broadcast.45)
  add.838 = f32[32,32]{1,0} add(subtract.836, divide.837)
  call.890 = f32[32,32]{1,0} call(compare.883, add.838, constant.68), to_apply=_where.884
  add.891 = f32[32,32]{1,0} add(add.882, call.890)
  reshape.1217 = f32[32,32,1,1]{3,2,1,0} reshape(add.891)
  broadcast.1218 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.1217), dimensions={0,1,2,3}
  reshape.1219 = f32[32,32]{1,0} reshape(broadcast.1218)
  broadcast.1220 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1219), dimensions={0,1}
  get-tuple-element.276 = f32[32,32]{1,0} get-tuple-element(call.275), index=0
  multiply.280 = f32[32,32]{1,0} multiply(get-tuple-element.276, broadcast.53)
  divide.281 = f32[32,32]{1,0} divide(multiply.280, broadcast.51)
  floor.282 = f32[32,32]{1,0} floor(divide.281)
  convert.284 = s32[32,32]{1,0} convert(floor.282)
  compare.347 = pred[32,32]{1,0} compare(convert.284, broadcast.25), direction=EQ
  subtract.283 = f32[32,32]{1,0} subtract(divide.281, floor.282)
  divide.289 = f32[32,32]{1,0} divide(subtract.283, broadcast.49)
  multiply.285 = f32[32,32]{1,0} multiply(subtract.283, subtract.283)
  divide.290 = f32[32,32]{1,0} divide(multiply.285, broadcast.47)
  subtract.291 = f32[32,32]{1,0} subtract(divide.289, divide.290)
  multiply.286 = f32[32,32]{1,0} multiply(multiply.285, subtract.283)
  divide.292 = f32[32,32]{1,0} divide(multiply.286, broadcast.47)
  subtract.293 = f32[32,32]{1,0} subtract(subtract.291, divide.292)
  multiply.287 = f32[32,32]{1,0} multiply(multiply.286, subtract.283)
  divide.294 = f32[32,32]{1,0} divide(multiply.287, broadcast.47)
  add.295 = f32[32,32]{1,0} add(subtract.293, divide.294)
  multiply.288 = f32[32,32]{1,0} multiply(multiply.287, subtract.283)
  divide.296 = f32[32,32]{1,0} divide(multiply.288, broadcast.45)
  subtract.297 = f32[32,32]{1,0} subtract(add.295, divide.296)
  call.354 = f32[32,32]{1,0} call(compare.347, subtract.297, constant.68), to_apply=_where.348
  compare.355 = pred[32,32]{1,0} compare(convert.284, broadcast.23), direction=EQ
  divide.298 = f32[32,32]{1,0} divide(subtract.283, broadcast.43)
  negate.299 = f32[32,32]{1,0} negate(divide.298)
  multiply.300 = f32[32,32]{1,0} multiply(multiply.285, broadcast.43)
  divide.301 = f32[32,32]{1,0} divide(multiply.300, broadcast.41)
  add.302 = f32[32,32]{1,0} add(negate.299, divide.301)
  divide.303 = f32[32,32]{1,0} divide(multiply.286, broadcast.47)
  subtract.304 = f32[32,32]{1,0} subtract(add.302, divide.303)
  divide.305 = f32[32,32]{1,0} divide(multiply.287, broadcast.39)
  subtract.306 = f32[32,32]{1,0} subtract(subtract.304, divide.305)
  divide.307 = f32[32,32]{1,0} divide(multiply.288, broadcast.47)
  add.308 = f32[32,32]{1,0} add(subtract.306, divide.307)
  call.362 = f32[32,32]{1,0} call(compare.355, add.308, constant.68), to_apply=_where.356
  add.363 = f32[32,32]{1,0} add(call.354, call.362)
  compare.364 = pred[32,32]{1,0} compare(convert.284, broadcast.21), direction=EQ
  divide.309 = f32[32,32]{1,0} divide(subtract.283, broadcast.41)
  subtract.310 = f32[32,32]{1,0} subtract(broadcast.37, divide.309)
  multiply.311 = f32[32,32]{1,0} multiply(multiply.285, broadcast.35)
  divide.312 = f32[32,32]{1,0} divide(multiply.311, broadcast.33)
  subtract.313 = f32[32,32]{1,0} subtract(subtract.310, divide.312)
  multiply.314 = f32[32,32]{1,0} multiply(multiply.286, broadcast.35)
  divide.315 = f32[32,32]{1,0} divide(multiply.314, broadcast.31)
  add.316 = f32[32,32]{1,0} add(subtract.313, divide.315)
  divide.317 = f32[32,32]{1,0} divide(multiply.287, broadcast.33)
  add.318 = f32[32,32]{1,0} add(add.316, divide.317)
  divide.319 = f32[32,32]{1,0} divide(multiply.288, broadcast.31)
  subtract.320 = f32[32,32]{1,0} subtract(add.318, divide.319)
  call.371 = f32[32,32]{1,0} call(compare.364, subtract.320, constant.68), to_apply=_where.365
  add.372 = f32[32,32]{1,0} add(add.363, call.371)
  compare.373 = pred[32,32]{1,0} compare(convert.284, broadcast.19), direction=EQ
  multiply.321 = f32[32,32]{1,0} multiply(multiply.285, broadcast.43)
  divide.322 = f32[32,32]{1,0} divide(multiply.321, broadcast.41)
  add.323 = f32[32,32]{1,0} add(subtract.283, divide.322)
  multiply.324 = f32[32,32]{1,0} multiply(multiply.286, broadcast.29)
  divide.325 = f32[32,32]{1,0} divide(multiply.324, broadcast.31)
  subtract.326 = f32[32,32]{1,0} subtract(add.323, divide.325)
  divide.327 = f32[32,32]{1,0} divide(multiply.287, broadcast.39)
  subtract.328 = f32[32,32]{1,0} subtract(subtract.326, divide.327)
  divide.329 = f32[32,32]{1,0} divide(multiply.288, broadcast.31)
  add.330 = f32[32,32]{1,0} add(subtract.328, divide.329)
  call.380 = f32[32,32]{1,0} call(compare.373, add.330, constant.68), to_apply=_where.374
  add.381 = f32[32,32]{1,0} add(add.372, call.380)
  compare.382 = pred[32,32]{1,0} compare(convert.284, broadcast.17), direction=EQ
  divide.331 = f32[32,32]{1,0} divide(subtract.283, broadcast.33)
  negate.332 = f32[32,32]{1,0} negate(divide.331)
  divide.333 = f32[32,32]{1,0} divide(multiply.285, broadcast.47)
  subtract.334 = f32[32,32]{1,0} subtract(negate.332, divide.333)
  multiply.335 = f32[32,32]{1,0} multiply(multiply.286, broadcast.29)
  divide.336 = f32[32,32]{1,0} divide(multiply.335, broadcast.47)
  add.337 = f32[32,32]{1,0} add(subtract.334, divide.336)
  divide.338 = f32[32,32]{1,0} divide(multiply.287, broadcast.47)
  add.339 = f32[32,32]{1,0} add(add.337, divide.338)
  divide.340 = f32[32,32]{1,0} divide(multiply.288, broadcast.47)
  subtract.341 = f32[32,32]{1,0} subtract(add.339, divide.340)
  call.389 = f32[32,32]{1,0} call(compare.382, subtract.341, constant.68), to_apply=_where.383
  add.390 = f32[32,32]{1,0} add(add.381, call.389)
  compare.391 = pred[32,32]{1,0} compare(convert.284, broadcast.15), direction=EQ
  divide.342 = f32[32,32]{1,0} divide(subtract.283, broadcast.27)
  divide.343 = f32[32,32]{1,0} divide(multiply.286, broadcast.47)
  subtract.344 = f32[32,32]{1,0} subtract(divide.342, divide.343)
  divide.345 = f32[32,32]{1,0} divide(multiply.288, broadcast.45)
  add.346 = f32[32,32]{1,0} add(subtract.344, divide.345)
  call.398 = f32[32,32]{1,0} call(compare.391, add.346, constant.68), to_apply=_where.392
  add.399 = f32[32,32]{1,0} add(add.390, call.398)
  reshape.725 = f32[32,32,1,1]{3,2,1,0} reshape(add.399)
  broadcast.726 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.725), dimensions={0,1,2,3}
  reshape.727 = f32[32,32]{1,0} reshape(broadcast.726)
  broadcast.728 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.727), dimensions={0,1}
  constant.66 = s32[] constant(0)
  call.723 = f32[32,32,38,32]{3,2,1,0} call(add.219, constant.66), to_apply=_pad.718
  slice.724 = f32[32,32,32,32]{3,2,1,0} slice(call.723), slice={[0:32], [0:32], [6:38], [0:32]}
  multiply.729 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.728, slice.724)
  constant.12 = s32[] constant(0)
  broadcast.13 = s32[32,32]{1,0} broadcast(constant.12), dimensions={}
  compare.400 = pred[32,32]{1,0} compare(convert.284, broadcast.13), direction=EQ
  call.407 = f32[32,32]{1,0} call(compare.400, subtract.297, constant.68), to_apply=_where.401
  compare.408 = pred[32,32]{1,0} compare(convert.284, broadcast.25), direction=EQ
  call.415 = f32[32,32]{1,0} call(compare.408, add.308, constant.68), to_apply=_where.409
  add.416 = f32[32,32]{1,0} add(call.407, call.415)
  compare.417 = pred[32,32]{1,0} compare(convert.284, broadcast.23), direction=EQ
  call.424 = f32[32,32]{1,0} call(compare.417, subtract.320, constant.68), to_apply=_where.418
  add.425 = f32[32,32]{1,0} add(add.416, call.424)
  compare.426 = pred[32,32]{1,0} compare(convert.284, broadcast.21), direction=EQ
  call.433 = f32[32,32]{1,0} call(compare.426, add.330, constant.68), to_apply=_where.427
  add.434 = f32[32,32]{1,0} add(add.425, call.433)
  compare.435 = pred[32,32]{1,0} compare(convert.284, broadcast.19), direction=EQ
  call.442 = f32[32,32]{1,0} call(compare.435, subtract.341, constant.68), to_apply=_where.436
  add.443 = f32[32,32]{1,0} add(add.434, call.442)
  compare.444 = pred[32,32]{1,0} compare(convert.284, broadcast.17), direction=EQ
  call.451 = f32[32,32]{1,0} call(compare.444, add.346, constant.68), to_apply=_where.445
  add.452 = f32[32,32]{1,0} add(add.443, call.451)
  reshape.731 = f32[32,32,1,1]{3,2,1,0} reshape(add.452)
  broadcast.732 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.731), dimensions={0,1,2,3}
  reshape.733 = f32[32,32]{1,0} reshape(broadcast.732)
  broadcast.734 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.733), dimensions={0,1}
  slice.730 = f32[32,32,32,32]{3,2,1,0} slice(call.723), slice={[0:32], [0:32], [5:37], [0:32]}
  multiply.735 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.734, slice.730)
  add.736 = f32[32,32,32,32]{3,2,1,0} add(multiply.729, multiply.735)
  constant.10 = s32[] constant(1)
  broadcast.11 = s32[32,32]{1,0} broadcast(constant.10), dimensions={}
  compare.453 = pred[32,32]{1,0} compare(convert.284, broadcast.11), direction=EQ
  call.460 = f32[32,32]{1,0} call(compare.453, subtract.297, constant.68), to_apply=_where.454
  compare.461 = pred[32,32]{1,0} compare(convert.284, broadcast.13), direction=EQ
  call.468 = f32[32,32]{1,0} call(compare.461, add.308, constant.68), to_apply=_where.462
  add.469 = f32[32,32]{1,0} add(call.460, call.468)
  compare.470 = pred[32,32]{1,0} compare(convert.284, broadcast.25), direction=EQ
  call.477 = f32[32,32]{1,0} call(compare.470, subtract.320, constant.68), to_apply=_where.471
  add.478 = f32[32,32]{1,0} add(add.469, call.477)
  compare.479 = pred[32,32]{1,0} compare(convert.284, broadcast.23), direction=EQ
  call.486 = f32[32,32]{1,0} call(compare.479, add.330, constant.68), to_apply=_where.480
  add.487 = f32[32,32]{1,0} add(add.478, call.486)
  compare.488 = pred[32,32]{1,0} compare(convert.284, broadcast.21), direction=EQ
  call.495 = f32[32,32]{1,0} call(compare.488, subtract.341, constant.68), to_apply=_where.489
  add.496 = f32[32,32]{1,0} add(add.487, call.495)
  compare.497 = pred[32,32]{1,0} compare(convert.284, broadcast.19), direction=EQ
  call.504 = f32[32,32]{1,0} call(compare.497, add.346, constant.68), to_apply=_where.498
  add.505 = f32[32,32]{1,0} add(add.496, call.504)
  reshape.738 = f32[32,32,1,1]{3,2,1,0} reshape(add.505)
  broadcast.739 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.738), dimensions={0,1,2,3}
  reshape.740 = f32[32,32]{1,0} reshape(broadcast.739)
  broadcast.741 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.740), dimensions={0,1}
  slice.737 = f32[32,32,32,32]{3,2,1,0} slice(call.723), slice={[0:32], [0:32], [4:36], [0:32]}
  multiply.742 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.741, slice.737)
  add.743 = f32[32,32,32,32]{3,2,1,0} add(add.736, multiply.742)
  constant.8 = s32[] constant(2)
  broadcast.9 = s32[32,32]{1,0} broadcast(constant.8), dimensions={}
  compare.506 = pred[32,32]{1,0} compare(convert.284, broadcast.9), direction=EQ
  call.513 = f32[32,32]{1,0} call(compare.506, subtract.297, constant.68), to_apply=_where.507
  compare.514 = pred[32,32]{1,0} compare(convert.284, broadcast.11), direction=EQ
  call.521 = f32[32,32]{1,0} call(compare.514, add.308, constant.68), to_apply=_where.515
  add.522 = f32[32,32]{1,0} add(call.513, call.521)
  compare.523 = pred[32,32]{1,0} compare(convert.284, broadcast.13), direction=EQ
  call.530 = f32[32,32]{1,0} call(compare.523, subtract.320, constant.68), to_apply=_where.524
  add.531 = f32[32,32]{1,0} add(add.522, call.530)
  compare.532 = pred[32,32]{1,0} compare(convert.284, broadcast.25), direction=EQ
  call.539 = f32[32,32]{1,0} call(compare.532, add.330, constant.68), to_apply=_where.533
  add.540 = f32[32,32]{1,0} add(add.531, call.539)
  compare.541 = pred[32,32]{1,0} compare(convert.284, broadcast.23), direction=EQ
  call.548 = f32[32,32]{1,0} call(compare.541, subtract.341, constant.68), to_apply=_where.542
  add.549 = f32[32,32]{1,0} add(add.540, call.548)
  compare.550 = pred[32,32]{1,0} compare(convert.284, broadcast.21), direction=EQ
  call.557 = f32[32,32]{1,0} call(compare.550, add.346, constant.68), to_apply=_where.551
  add.558 = f32[32,32]{1,0} add(add.549, call.557)
  reshape.745 = f32[32,32,1,1]{3,2,1,0} reshape(add.558)
  broadcast.746 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.745), dimensions={0,1,2,3}
  reshape.747 = f32[32,32]{1,0} reshape(broadcast.746)
  broadcast.748 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.747), dimensions={0,1}
  slice.744 = f32[32,32,32,32]{3,2,1,0} slice(call.723), slice={[0:32], [0:32], [3:35], [0:32]}
  multiply.749 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.748, slice.744)
  add.750 = f32[32,32,32,32]{3,2,1,0} add(add.743, multiply.749)
  constant.6 = s32[] constant(3)
  broadcast.7 = s32[32,32]{1,0} broadcast(constant.6), dimensions={}
  compare.559 = pred[32,32]{1,0} compare(convert.284, broadcast.7), direction=EQ
  call.566 = f32[32,32]{1,0} call(compare.559, subtract.297, constant.68), to_apply=_where.560
  compare.567 = pred[32,32]{1,0} compare(convert.284, broadcast.9), direction=EQ
  call.574 = f32[32,32]{1,0} call(compare.567, add.308, constant.68), to_apply=_where.568
  add.575 = f32[32,32]{1,0} add(call.566, call.574)
  compare.576 = pred[32,32]{1,0} compare(convert.284, broadcast.11), direction=EQ
  call.583 = f32[32,32]{1,0} call(compare.576, subtract.320, constant.68), to_apply=_where.577
  add.584 = f32[32,32]{1,0} add(add.575, call.583)
  compare.585 = pred[32,32]{1,0} compare(convert.284, broadcast.13), direction=EQ
  call.592 = f32[32,32]{1,0} call(compare.585, add.330, constant.68), to_apply=_where.586
  add.593 = f32[32,32]{1,0} add(add.584, call.592)
  compare.594 = pred[32,32]{1,0} compare(convert.284, broadcast.25), direction=EQ
  call.601 = f32[32,32]{1,0} call(compare.594, subtract.341, constant.68), to_apply=_where.595
  add.602 = f32[32,32]{1,0} add(add.593, call.601)
  compare.603 = pred[32,32]{1,0} compare(convert.284, broadcast.23), direction=EQ
  call.610 = f32[32,32]{1,0} call(compare.603, add.346, constant.68), to_apply=_where.604
  add.611 = f32[32,32]{1,0} add(add.602, call.610)
  reshape.752 = f32[32,32,1,1]{3,2,1,0} reshape(add.611)
  broadcast.753 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.752), dimensions={0,1,2,3}
  reshape.754 = f32[32,32]{1,0} reshape(broadcast.753)
  broadcast.755 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.754), dimensions={0,1}
  slice.751 = f32[32,32,32,32]{3,2,1,0} slice(call.723), slice={[0:32], [0:32], [2:34], [0:32]}
  multiply.756 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.755, slice.751)
  add.757 = f32[32,32,32,32]{3,2,1,0} add(add.750, multiply.756)
  constant.4 = s32[] constant(4)
  broadcast.5 = s32[32,32]{1,0} broadcast(constant.4), dimensions={}
  compare.612 = pred[32,32]{1,0} compare(convert.284, broadcast.5), direction=EQ
  call.619 = f32[32,32]{1,0} call(compare.612, subtract.297, constant.68), to_apply=_where.613
  compare.620 = pred[32,32]{1,0} compare(convert.284, broadcast.7), direction=EQ
  call.627 = f32[32,32]{1,0} call(compare.620, add.308, constant.68), to_apply=_where.621
  add.628 = f32[32,32]{1,0} add(call.619, call.627)
  compare.629 = pred[32,32]{1,0} compare(convert.284, broadcast.9), direction=EQ
  call.636 = f32[32,32]{1,0} call(compare.629, subtract.320, constant.68), to_apply=_where.630
  add.637 = f32[32,32]{1,0} add(add.628, call.636)
  compare.638 = pred[32,32]{1,0} compare(convert.284, broadcast.11), direction=EQ
  call.645 = f32[32,32]{1,0} call(compare.638, add.330, constant.68), to_apply=_where.639
  add.646 = f32[32,32]{1,0} add(add.637, call.645)
  compare.647 = pred[32,32]{1,0} compare(convert.284, broadcast.13), direction=EQ
  call.654 = f32[32,32]{1,0} call(compare.647, subtract.341, constant.68), to_apply=_where.648
  add.655 = f32[32,32]{1,0} add(add.646, call.654)
  compare.656 = pred[32,32]{1,0} compare(convert.284, broadcast.25), direction=EQ
  call.663 = f32[32,32]{1,0} call(compare.656, add.346, constant.68), to_apply=_where.657
  add.664 = f32[32,32]{1,0} add(add.655, call.663)
  reshape.759 = f32[32,32,1,1]{3,2,1,0} reshape(add.664)
  broadcast.760 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.759), dimensions={0,1,2,3}
  reshape.761 = f32[32,32]{1,0} reshape(broadcast.760)
  broadcast.762 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.761), dimensions={0,1}
  slice.758 = f32[32,32,32,32]{3,2,1,0} slice(call.723), slice={[0:32], [0:32], [1:33], [0:32]}
  multiply.763 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.762, slice.758)
  add.764 = f32[32,32,32,32]{3,2,1,0} add(add.757, multiply.763)
  constant.2 = s32[] constant(5)
  broadcast.3 = s32[32,32]{1,0} broadcast(constant.2), dimensions={}
  compare.665 = pred[32,32]{1,0} compare(convert.284, broadcast.3), direction=EQ
  call.672 = f32[32,32]{1,0} call(compare.665, subtract.297, constant.68), to_apply=_where.666
  compare.673 = pred[32,32]{1,0} compare(convert.284, broadcast.5), direction=EQ
  call.680 = f32[32,32]{1,0} call(compare.673, add.308, constant.68), to_apply=_where.674
  add.681 = f32[32,32]{1,0} add(call.672, call.680)
  compare.682 = pred[32,32]{1,0} compare(convert.284, broadcast.7), direction=EQ
  call.689 = f32[32,32]{1,0} call(compare.682, subtract.320, constant.68), to_apply=_where.683
  add.690 = f32[32,32]{1,0} add(add.681, call.689)
  compare.691 = pred[32,32]{1,0} compare(convert.284, broadcast.9), direction=EQ
  call.698 = f32[32,32]{1,0} call(compare.691, add.330, constant.68), to_apply=_where.692
  add.699 = f32[32,32]{1,0} add(add.690, call.698)
  compare.700 = pred[32,32]{1,0} compare(convert.284, broadcast.11), direction=EQ
  call.707 = f32[32,32]{1,0} call(compare.700, subtract.341, constant.68), to_apply=_where.701
  add.708 = f32[32,32]{1,0} add(add.699, call.707)
  compare.709 = pred[32,32]{1,0} compare(convert.284, broadcast.13), direction=EQ
  call.716 = f32[32,32]{1,0} call(compare.709, add.346, constant.68), to_apply=_where.710
  add.717 = f32[32,32]{1,0} add(add.708, call.716)
  reshape.766 = f32[32,32,1,1]{3,2,1,0} reshape(add.717)
  broadcast.767 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.766), dimensions={0,1,2,3}
  reshape.768 = f32[32,32]{1,0} reshape(broadcast.767)
  broadcast.769 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.768), dimensions={0,1}
  slice.765 = f32[32,32,32,32]{3,2,1,0} slice(call.723), slice={[0:32], [0:32], [0:32], [0:32]}
  multiply.770 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.769, slice.765)
  add.771 = f32[32,32,32,32]{3,2,1,0} add(add.764, multiply.770)
  call.1215 = f32[32,32,32,38]{3,2,1,0} call(add.771, constant.66), to_apply=_pad_16.1210
  slice.1216 = f32[32,32,32,32]{3,2,1,0} slice(call.1215), slice={[0:32], [0:32], [0:32], [6:38]}
  multiply.1221 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.1220, slice.1216)
  compare.892 = pred[32,32]{1,0} compare(convert.776, broadcast.13), direction=EQ
  call.899 = f32[32,32]{1,0} call(compare.892, subtract.789, constant.68), to_apply=_where.893
  compare.900 = pred[32,32]{1,0} compare(convert.776, broadcast.25), direction=EQ
  call.907 = f32[32,32]{1,0} call(compare.900, add.800, constant.68), to_apply=_where.901
  add.908 = f32[32,32]{1,0} add(call.899, call.907)
  compare.909 = pred[32,32]{1,0} compare(convert.776, broadcast.23), direction=EQ
  call.916 = f32[32,32]{1,0} call(compare.909, subtract.812, constant.68), to_apply=_where.910
  add.917 = f32[32,32]{1,0} add(add.908, call.916)
  compare.918 = pred[32,32]{1,0} compare(convert.776, broadcast.21), direction=EQ
  call.925 = f32[32,32]{1,0} call(compare.918, add.822, constant.68), to_apply=_where.919
  add.926 = f32[32,32]{1,0} add(add.917, call.925)
  compare.927 = pred[32,32]{1,0} compare(convert.776, broadcast.19), direction=EQ
  call.934 = f32[32,32]{1,0} call(compare.927, subtract.833, constant.68), to_apply=_where.928
  add.935 = f32[32,32]{1,0} add(add.926, call.934)
  compare.936 = pred[32,32]{1,0} compare(convert.776, broadcast.17), direction=EQ
  call.943 = f32[32,32]{1,0} call(compare.936, add.838, constant.68), to_apply=_where.937
  add.944 = f32[32,32]{1,0} add(add.935, call.943)
  reshape.1223 = f32[32,32,1,1]{3,2,1,0} reshape(add.944)
  broadcast.1224 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.1223), dimensions={0,1,2,3}
  reshape.1225 = f32[32,32]{1,0} reshape(broadcast.1224)
  broadcast.1226 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1225), dimensions={0,1}
  slice.1222 = f32[32,32,32,32]{3,2,1,0} slice(call.1215), slice={[0:32], [0:32], [0:32], [5:37]}
  multiply.1227 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.1226, slice.1222)
  add.1228 = f32[32,32,32,32]{3,2,1,0} add(multiply.1221, multiply.1227)
  compare.945 = pred[32,32]{1,0} compare(convert.776, broadcast.11), direction=EQ
  call.952 = f32[32,32]{1,0} call(compare.945, subtract.789, constant.68), to_apply=_where.946
  compare.953 = pred[32,32]{1,0} compare(convert.776, broadcast.13), direction=EQ
  call.960 = f32[32,32]{1,0} call(compare.953, add.800, constant.68), to_apply=_where.954
  add.961 = f32[32,32]{1,0} add(call.952, call.960)
  compare.962 = pred[32,32]{1,0} compare(convert.776, broadcast.25), direction=EQ
  call.969 = f32[32,32]{1,0} call(compare.962, subtract.812, constant.68), to_apply=_where.963
  add.970 = f32[32,32]{1,0} add(add.961, call.969)
  compare.971 = pred[32,32]{1,0} compare(convert.776, broadcast.23), direction=EQ
  call.978 = f32[32,32]{1,0} call(compare.971, add.822, constant.68), to_apply=_where.972
  add.979 = f32[32,32]{1,0} add(add.970, call.978)
  compare.980 = pred[32,32]{1,0} compare(convert.776, broadcast.21), direction=EQ
  call.987 = f32[32,32]{1,0} call(compare.980, subtract.833, constant.68), to_apply=_where.981
  add.988 = f32[32,32]{1,0} add(add.979, call.987)
  compare.989 = pred[32,32]{1,0} compare(convert.776, broadcast.19), direction=EQ
  call.996 = f32[32,32]{1,0} call(compare.989, add.838, constant.68), to_apply=_where.990
  add.997 = f32[32,32]{1,0} add(add.988, call.996)
  reshape.1230 = f32[32,32,1,1]{3,2,1,0} reshape(add.997)
  broadcast.1231 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.1230), dimensions={0,1,2,3}
  reshape.1232 = f32[32,32]{1,0} reshape(broadcast.1231)
  broadcast.1233 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1232), dimensions={0,1}
  slice.1229 = f32[32,32,32,32]{3,2,1,0} slice(call.1215), slice={[0:32], [0:32], [0:32], [4:36]}
  multiply.1234 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.1233, slice.1229)
  add.1235 = f32[32,32,32,32]{3,2,1,0} add(add.1228, multiply.1234)
  compare.998 = pred[32,32]{1,0} compare(convert.776, broadcast.9), direction=EQ
  call.1005 = f32[32,32]{1,0} call(compare.998, subtract.789, constant.68), to_apply=_where.999
  compare.1006 = pred[32,32]{1,0} compare(convert.776, broadcast.11), direction=EQ
  call.1013 = f32[32,32]{1,0} call(compare.1006, add.800, constant.68), to_apply=_where.1007
  add.1014 = f32[32,32]{1,0} add(call.1005, call.1013)
  compare.1015 = pred[32,32]{1,0} compare(convert.776, broadcast.13), direction=EQ
  call.1022 = f32[32,32]{1,0} call(compare.1015, subtract.812, constant.68), to_apply=_where.1016
  add.1023 = f32[32,32]{1,0} add(add.1014, call.1022)
  compare.1024 = pred[32,32]{1,0} compare(convert.776, broadcast.25), direction=EQ
  call.1031 = f32[32,32]{1,0} call(compare.1024, add.822, constant.68), to_apply=_where.1025
  add.1032 = f32[32,32]{1,0} add(add.1023, call.1031)
  compare.1033 = pred[32,32]{1,0} compare(convert.776, broadcast.23), direction=EQ
  call.1040 = f32[32,32]{1,0} call(compare.1033, subtract.833, constant.68), to_apply=_where.1034
  add.1041 = f32[32,32]{1,0} add(add.1032, call.1040)
  compare.1042 = pred[32,32]{1,0} compare(convert.776, broadcast.21), direction=EQ
  call.1049 = f32[32,32]{1,0} call(compare.1042, add.838, constant.68), to_apply=_where.1043
  add.1050 = f32[32,32]{1,0} add(add.1041, call.1049)
  reshape.1237 = f32[32,32,1,1]{3,2,1,0} reshape(add.1050)
  broadcast.1238 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.1237), dimensions={0,1,2,3}
  reshape.1239 = f32[32,32]{1,0} reshape(broadcast.1238)
  broadcast.1240 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1239), dimensions={0,1}
  slice.1236 = f32[32,32,32,32]{3,2,1,0} slice(call.1215), slice={[0:32], [0:32], [0:32], [3:35]}
  multiply.1241 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.1240, slice.1236)
  add.1242 = f32[32,32,32,32]{3,2,1,0} add(add.1235, multiply.1241)
  compare.1051 = pred[32,32]{1,0} compare(convert.776, broadcast.7), direction=EQ
  call.1058 = f32[32,32]{1,0} call(compare.1051, subtract.789, constant.68), to_apply=_where.1052
  compare.1059 = pred[32,32]{1,0} compare(convert.776, broadcast.9), direction=EQ
  call.1066 = f32[32,32]{1,0} call(compare.1059, add.800, constant.68), to_apply=_where.1060
  add.1067 = f32[32,32]{1,0} add(call.1058, call.1066)
  compare.1068 = pred[32,32]{1,0} compare(convert.776, broadcast.11), direction=EQ
  call.1075 = f32[32,32]{1,0} call(compare.1068, subtract.812, constant.68), to_apply=_where.1069
  add.1076 = f32[32,32]{1,0} add(add.1067, call.1075)
  compare.1077 = pred[32,32]{1,0} compare(convert.776, broadcast.13), direction=EQ
  call.1084 = f32[32,32]{1,0} call(compare.1077, add.822, constant.68), to_apply=_where.1078
  add.1085 = f32[32,32]{1,0} add(add.1076, call.1084)
  compare.1086 = pred[32,32]{1,0} compare(convert.776, broadcast.25), direction=EQ
  call.1093 = f32[32,32]{1,0} call(compare.1086, subtract.833, constant.68), to_apply=_where.1087
  add.1094 = f32[32,32]{1,0} add(add.1085, call.1093)
  compare.1095 = pred[32,32]{1,0} compare(convert.776, broadcast.23), direction=EQ
  call.1102 = f32[32,32]{1,0} call(compare.1095, add.838, constant.68), to_apply=_where.1096
  add.1103 = f32[32,32]{1,0} add(add.1094, call.1102)
  reshape.1244 = f32[32,32,1,1]{3,2,1,0} reshape(add.1103)
  broadcast.1245 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.1244), dimensions={0,1,2,3}
  reshape.1246 = f32[32,32]{1,0} reshape(broadcast.1245)
  broadcast.1247 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1246), dimensions={0,1}
  slice.1243 = f32[32,32,32,32]{3,2,1,0} slice(call.1215), slice={[0:32], [0:32], [0:32], [2:34]}
  multiply.1248 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.1247, slice.1243)
  add.1249 = f32[32,32,32,32]{3,2,1,0} add(add.1242, multiply.1248)
  compare.1104 = pred[32,32]{1,0} compare(convert.776, broadcast.5), direction=EQ
  call.1111 = f32[32,32]{1,0} call(compare.1104, subtract.789, constant.68), to_apply=_where.1105
  compare.1112 = pred[32,32]{1,0} compare(convert.776, broadcast.7), direction=EQ
  call.1119 = f32[32,32]{1,0} call(compare.1112, add.800, constant.68), to_apply=_where.1113
  add.1120 = f32[32,32]{1,0} add(call.1111, call.1119)
  compare.1121 = pred[32,32]{1,0} compare(convert.776, broadcast.9), direction=EQ
  call.1128 = f32[32,32]{1,0} call(compare.1121, subtract.812, constant.68), to_apply=_where.1122
  add.1129 = f32[32,32]{1,0} add(add.1120, call.1128)
  compare.1130 = pred[32,32]{1,0} compare(convert.776, broadcast.11), direction=EQ
  call.1137 = f32[32,32]{1,0} call(compare.1130, add.822, constant.68), to_apply=_where.1131
  add.1138 = f32[32,32]{1,0} add(add.1129, call.1137)
  compare.1139 = pred[32,32]{1,0} compare(convert.776, broadcast.13), direction=EQ
  call.1146 = f32[32,32]{1,0} call(compare.1139, subtract.833, constant.68), to_apply=_where.1140
  add.1147 = f32[32,32]{1,0} add(add.1138, call.1146)
  compare.1148 = pred[32,32]{1,0} compare(convert.776, broadcast.25), direction=EQ
  call.1155 = f32[32,32]{1,0} call(compare.1148, add.838, constant.68), to_apply=_where.1149
  add.1156 = f32[32,32]{1,0} add(add.1147, call.1155)
  reshape.1251 = f32[32,32,1,1]{3,2,1,0} reshape(add.1156)
  broadcast.1252 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.1251), dimensions={0,1,2,3}
  reshape.1253 = f32[32,32]{1,0} reshape(broadcast.1252)
  broadcast.1254 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1253), dimensions={0,1}
  slice.1250 = f32[32,32,32,32]{3,2,1,0} slice(call.1215), slice={[0:32], [0:32], [0:32], [1:33]}
  multiply.1255 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.1254, slice.1250)
  add.1256 = f32[32,32,32,32]{3,2,1,0} add(add.1249, multiply.1255)
  compare.1157 = pred[32,32]{1,0} compare(convert.776, broadcast.3), direction=EQ
  call.1164 = f32[32,32]{1,0} call(compare.1157, subtract.789, constant.68), to_apply=_where.1158
  compare.1165 = pred[32,32]{1,0} compare(convert.776, broadcast.5), direction=EQ
  call.1172 = f32[32,32]{1,0} call(compare.1165, add.800, constant.68), to_apply=_where.1166
  add.1173 = f32[32,32]{1,0} add(call.1164, call.1172)
  compare.1174 = pred[32,32]{1,0} compare(convert.776, broadcast.7), direction=EQ
  call.1181 = f32[32,32]{1,0} call(compare.1174, subtract.812, constant.68), to_apply=_where.1175
  add.1182 = f32[32,32]{1,0} add(add.1173, call.1181)
  compare.1183 = pred[32,32]{1,0} compare(convert.776, broadcast.9), direction=EQ
  call.1190 = f32[32,32]{1,0} call(compare.1183, add.822, constant.68), to_apply=_where.1184
  add.1191 = f32[32,32]{1,0} add(add.1182, call.1190)
  compare.1192 = pred[32,32]{1,0} compare(convert.776, broadcast.11), direction=EQ
  call.1199 = f32[32,32]{1,0} call(compare.1192, subtract.833, constant.68), to_apply=_where.1193
  add.1200 = f32[32,32]{1,0} add(add.1191, call.1199)
  compare.1201 = pred[32,32]{1,0} compare(convert.776, broadcast.13), direction=EQ
  call.1208 = f32[32,32]{1,0} call(compare.1201, add.838, constant.68), to_apply=_where.1202
  add.1209 = f32[32,32]{1,0} add(add.1200, call.1208)
  reshape.1258 = f32[32,32,1,1]{3,2,1,0} reshape(add.1209)
  broadcast.1259 = f32[32,32,1,1]{3,2,1,0} broadcast(reshape.1258), dimensions={0,1,2,3}
  reshape.1260 = f32[32,32]{1,0} reshape(broadcast.1259)
  broadcast.1261 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1260), dimensions={0,1}
  slice.1257 = f32[32,32,32,32]{3,2,1,0} slice(call.1215), slice={[0:32], [0:32], [0:32], [0:32]}
  multiply.1262 = f32[32,32,32,32]{3,2,1,0} multiply(broadcast.1261, slice.1257)
  add.1263 = f32[32,32,32,32]{3,2,1,0} add(add.1256, multiply.1262)
  slice.1264 = f32[32,32,32,16]{3,2,1,0} slice(add.1263), slice={[0:32], [0:32], [0:32], [0:16]}
  call.1270 = f32[32,32,32,16]{3,2,1,0} call(slice.1264), to_apply=_roll_static_7.1265
  slice.1271 = f32[32,32,32,16]{3,2,1,0} slice(add.1263), slice={[0:32], [0:32], [0:32], [16:32]}
  call.1274 = f32[32,32,32,16]{3,2,1,0} call(slice.1271), to_apply=_roll_static_8.1272
  concatenate.1275 = f32[32,32,32,32]{3,2,1,0} concatenate(call.1270, call.1274), dimensions={3}
  call.1281 = f32[32,32,32,32]{3,2,1,0} call(concatenate.1275), to_apply=_roll_static_9.1276
  broadcast.1282 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.59), dimensions={0,1,2,3}
  reshape.1283 = f32[32]{0} reshape(broadcast.1282)
  broadcast.1284 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1283), dimensions={3}
  multiply.1285 = f32[32,32,32,32]{3,2,1,0} multiply(call.1281, broadcast.1284)
  call.1291 = f32[32,32,32,32]{3,2,1,0} call(concatenate.1275), to_apply=_roll_static_10.1286
  broadcast.1292 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.58), dimensions={0,1,2,3}
  reshape.1293 = f32[32]{0} reshape(broadcast.1292)
  broadcast.1294 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1293), dimensions={3}
  multiply.1295 = f32[32,32,32,32]{3,2,1,0} multiply(call.1291, broadcast.1294)
  add.1296 = f32[32,32,32,32]{3,2,1,0} add(multiply.1285, multiply.1295)
  call.1299 = f32[32,32,32,32]{3,2,1,0} call(concatenate.1275), to_apply=_roll_static_11.1297
  broadcast.1300 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.57), dimensions={0,1,2,3}
  reshape.1301 = f32[32]{0} reshape(broadcast.1300)
  broadcast.1302 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1301), dimensions={3}
  multiply.1303 = f32[32,32,32,32]{3,2,1,0} multiply(call.1299, broadcast.1302)
  add.1304 = f32[32,32,32,32]{3,2,1,0} add(add.1296, multiply.1303)
  call.1310 = f32[32,32,32,32]{3,2,1,0} call(concatenate.1275), to_apply=_roll_static_12.1305
  broadcast.1311 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.56), dimensions={0,1,2,3}
  reshape.1312 = f32[32]{0} reshape(broadcast.1311)
  broadcast.1313 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1312), dimensions={3}
  multiply.1314 = f32[32,32,32,32]{3,2,1,0} multiply(call.1310, broadcast.1313)
  add.1315 = f32[32,32,32,32]{3,2,1,0} add(add.1304, multiply.1314)
  call.1321 = f32[32,32,32,32]{3,2,1,0} call(concatenate.1275), to_apply=_roll_static_13.1316
  broadcast.1322 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.55), dimensions={0,1,2,3}
  reshape.1323 = f32[32]{0} reshape(broadcast.1322)
  broadcast.1324 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1323), dimensions={3}
  multiply.1325 = f32[32,32,32,32]{3,2,1,0} multiply(call.1321, broadcast.1324)
  add.1326 = f32[32,32,32,32]{3,2,1,0} add(add.1315, multiply.1325)
  call.1332 = f32[32,32,32,32]{3,2,1,0} call(concatenate.1275), to_apply=_roll_static_14.1327
  broadcast.1333 = f32[1,1,1,32]{3,2,1,0} broadcast(constant.54), dimensions={0,1,2,3}
  reshape.1334 = f32[32]{0} reshape(broadcast.1333)
  broadcast.1335 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1334), dimensions={3}
  multiply.1336 = f32[32,32,32,32]{3,2,1,0} multiply(call.1332, broadcast.1335)
  add.1337 = f32[32,32,32,32]{3,2,1,0} add(add.1326, multiply.1336)
  slice.1338 = f32[32,32,16,32]{3,2,1,0} slice(add.1337), slice={[0:32], [0:32], [0:16], [0:32]}
  call.1344 = f32[32,32,16,32]{3,2,1,0} call(slice.1338), to_apply=_roll_static.1339
  slice.1345 = f32[32,32,16,32]{3,2,1,0} slice(add.1337), slice={[0:32], [0:32], [16:32], [0:32]}
  call.1348 = f32[32,32,16,32]{3,2,1,0} call(slice.1345), to_apply=_roll_static_0.1346
  concatenate.1349 = f32[32,32,32,32]{3,2,1,0} concatenate(call.1344, call.1348), dimensions={2}
  call.1355 = f32[32,32,32,32]{3,2,1,0} call(concatenate.1349), to_apply=_roll_static_1.1350
  broadcast.1356 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.65), dimensions={0,1,2,3}
  reshape.1357 = f32[32]{0} reshape(broadcast.1356)
  broadcast.1358 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1357), dimensions={2}
  multiply.1359 = f32[32,32,32,32]{3,2,1,0} multiply(call.1355, broadcast.1358)
  call.1365 = f32[32,32,32,32]{3,2,1,0} call(concatenate.1349), to_apply=_roll_static_2.1360
  broadcast.1366 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.64), dimensions={0,1,2,3}
  reshape.1367 = f32[32]{0} reshape(broadcast.1366)
  broadcast.1368 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1367), dimensions={2}
  multiply.1369 = f32[32,32,32,32]{3,2,1,0} multiply(call.1365, broadcast.1368)
  add.1370 = f32[32,32,32,32]{3,2,1,0} add(multiply.1359, multiply.1369)
  call.1373 = f32[32,32,32,32]{3,2,1,0} call(concatenate.1349), to_apply=_roll_static_3.1371
  broadcast.1374 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.63), dimensions={0,1,2,3}
  reshape.1375 = f32[32]{0} reshape(broadcast.1374)
  broadcast.1376 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1375), dimensions={2}
  multiply.1377 = f32[32,32,32,32]{3,2,1,0} multiply(call.1373, broadcast.1376)
  add.1378 = f32[32,32,32,32]{3,2,1,0} add(add.1370, multiply.1377)
  call.1384 = f32[32,32,32,32]{3,2,1,0} call(concatenate.1349), to_apply=_roll_static_4.1379
  broadcast.1385 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.62), dimensions={0,1,2,3}
  reshape.1386 = f32[32]{0} reshape(broadcast.1385)
  broadcast.1387 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1386), dimensions={2}
  multiply.1388 = f32[32,32,32,32]{3,2,1,0} multiply(call.1384, broadcast.1387)
  add.1389 = f32[32,32,32,32]{3,2,1,0} add(add.1378, multiply.1388)
  call.1395 = f32[32,32,32,32]{3,2,1,0} call(concatenate.1349), to_apply=_roll_static_5.1390
  broadcast.1396 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.61), dimensions={0,1,2,3}
  reshape.1397 = f32[32]{0} reshape(broadcast.1396)
  broadcast.1398 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1397), dimensions={2}
  multiply.1399 = f32[32,32,32,32]{3,2,1,0} multiply(call.1395, broadcast.1398)
  add.1400 = f32[32,32,32,32]{3,2,1,0} add(add.1389, multiply.1399)
  call.1406 = f32[32,32,32,32]{3,2,1,0} call(concatenate.1349), to_apply=_roll_static_6.1401
  broadcast.1407 = f32[1,1,32,1]{3,2,1,0} broadcast(constant.60), dimensions={0,1,2,3}
  reshape.1408 = f32[32]{0} reshape(broadcast.1407)
  broadcast.1409 = f32[32,32,32,32]{3,2,1,0} broadcast(reshape.1408), dimensions={2}
  multiply.1410 = f32[32,32,32,32]{3,2,1,0} multiply(call.1406, broadcast.1409)
  add.1411 = f32[32,32,32,32]{3,2,1,0} add(add.1400, multiply.1410)
  get-tuple-element.278 = f32[32,32]{1,0} get-tuple-element(call.275), index=2
  get-tuple-element.279 = f32[32,32]{1,0} get-tuple-element(call.275), index=3
  ROOT tuple.1412 = (f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(add.1411, get-tuple-element.278, get-tuple-element.279)
}

