HloModule jit__lambda_, entry_computation_layout={(f32[128,128]{1,0})->(f32[128,128]{1,0}, f32[128]{0}, f32[128]{0})}

_roll_static.65 {
  Arg_0.66 = f32[128,14]{1,0} parameter(0)
  slice.67 = f32[126,14]{1,0} slice(Arg_0.66), slice={[2:128], [0:14]}
  slice.68 = f32[2,14]{1,0} slice(Arg_0.66), slice={[0:2], [0:14]}
  ROOT concatenate.69 = f32[128,14]{1,0} concatenate(slice.67, slice.68), dimensions={0}
}

_roll_static_0.72 {
  Arg_0.73 = f32[128,50]{1,0} parameter(0)
  slice.74 = f32[127,50]{1,0} slice(Arg_0.73), slice={[1:128], [0:50]}
  slice.75 = f32[1,50]{1,0} slice(Arg_0.73), slice={[0:1], [0:50]}
  ROOT concatenate.76 = f32[128,50]{1,0} concatenate(slice.74, slice.75), dimensions={0}
}

_roll_static_1.79 {
  ROOT Arg_0.80 = f32[128,50]{1,0} parameter(0)
}

_roll_static_2.83 {
  Arg_0.84 = f32[128,14]{1,0} parameter(0)
  slice.85 = f32[1,14]{1,0} slice(Arg_0.84), slice={[127:128], [0:14]}
  slice.86 = f32[127,14]{1,0} slice(Arg_0.84), slice={[0:127], [0:14]}
  ROOT concatenate.87 = f32[128,14]{1,0} concatenate(slice.85, slice.86), dimensions={0}
}

_roll_static_3.90 {
  Arg_0.91 = f32[128,128]{1,0} parameter(0)
  slice.92 = f32[126,128]{1,0} slice(Arg_0.91), slice={[2:128], [0:128]}
  slice.93 = f32[2,128]{1,0} slice(Arg_0.91), slice={[0:2], [0:128]}
  ROOT concatenate.94 = f32[128,128]{1,0} concatenate(slice.92, slice.93), dimensions={0}
}

_roll_static_4.100 {
  Arg_0.101 = f32[128,128]{1,0} parameter(0)
  slice.102 = f32[127,128]{1,0} slice(Arg_0.101), slice={[1:128], [0:128]}
  slice.103 = f32[1,128]{1,0} slice(Arg_0.101), slice={[0:1], [0:128]}
  ROOT concatenate.104 = f32[128,128]{1,0} concatenate(slice.102, slice.103), dimensions={0}
}

_roll_static_5.111 {
  ROOT Arg_0.112 = f32[128,128]{1,0} parameter(0)
}

_roll_static_6.119 {
  Arg_0.120 = f32[128,128]{1,0} parameter(0)
  slice.121 = f32[1,128]{1,0} slice(Arg_0.120), slice={[127:128], [0:128]}
  slice.122 = f32[127,128]{1,0} slice(Arg_0.120), slice={[0:127], [0:128]}
  ROOT concatenate.123 = f32[128,128]{1,0} concatenate(slice.121, slice.122), dimensions={0}
}

_roll_static_7.130 {
  Arg_0.131 = f32[128,128]{1,0} parameter(0)
  slice.132 = f32[2,128]{1,0} slice(Arg_0.131), slice={[126:128], [0:128]}
  slice.133 = f32[126,128]{1,0} slice(Arg_0.131), slice={[0:126], [0:128]}
  ROOT concatenate.134 = f32[128,128]{1,0} concatenate(slice.132, slice.133), dimensions={0}
}

_roll_static_8.141 {
  Arg_0.142 = f32[128,128]{1,0} parameter(0)
  slice.143 = f32[3,128]{1,0} slice(Arg_0.142), slice={[125:128], [0:128]}
  slice.144 = f32[125,128]{1,0} slice(Arg_0.142), slice={[0:125], [0:128]}
  ROOT concatenate.145 = f32[128,128]{1,0} concatenate(slice.143, slice.144), dimensions={0}
}

region_0.152 {
  Arg_0.153 = f32[] parameter(0)
  Arg_1.154 = f32[] parameter(1)
  ROOT add.155 = f32[] add(Arg_0.153, Arg_1.154)
}

fft.156 {
  Arg_0.157 = f32[128]{0} parameter(0)
  ROOT fft.158 = c64[65]{0} fft(Arg_0.157), fft_type=RFFT, fft_length={128}
}

fft_9.159 {
  Arg_0.160 = c64[65]{0} parameter(0)
  ROOT fft.161 = f32[128]{0} fft(Arg_0.160), fft_type=IRFFT, fft_length={128}
}

fft_9.162 {
  Arg_0.163 = c64[65]{0} parameter(0)
  ROOT fft.164 = f32[128]{0} fft(Arg_0.163), fft_type=IRFFT, fft_length={128}
}

solve_poisson.165 {
  Arg_0.166 = f32[128,128]{1,0} parameter(0)
  constant.173 = f32[] constant(0)
  reduce.174 = f32[128]{0} reduce(Arg_0.166, constant.173), dimensions={1}, to_apply=region_0.152
  Arg_2.168 = f32[] parameter(2)
  broadcast.175 = f32[128]{0} broadcast(Arg_2.168), dimensions={}
  multiply.176 = f32[128]{0} multiply(reduce.174, broadcast.175)
  constant.171 = f32[] constant(1)
  broadcast.172 = f32[128]{0} broadcast(constant.171), dimensions={}
  subtract.177 = f32[128]{0} subtract(multiply.176, broadcast.172)
  call.178 = c64[65]{0} call(subtract.177), to_apply=fft.156
  constant.169 = c64[] constant((-0, -1))
  broadcast.170 = c64[65]{0} broadcast(constant.169), dimensions={}
  multiply.179 = c64[65]{0} multiply(call.178, broadcast.170)
  Arg_1.167 = f32[65]{0} parameter(1)
  convert.180 = c64[65]{0} convert(Arg_1.167)
  multiply.181 = c64[65]{0} multiply(multiply.179, convert.180)
  call.182 = f32[128]{0} call(multiply.181), to_apply=fft_9.159
  multiply.183 = f32[65]{0} multiply(Arg_1.167, Arg_1.167)
  convert.184 = c64[65]{0} convert(multiply.183)
  multiply.185 = c64[65]{0} multiply(call.178, convert.184)
  call.186 = f32[128]{0} call(multiply.185), to_apply=fft_9.162
  ROOT tuple.187 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) tuple(call.182, subtract.177, call.186)
}

_where.260 {
  Arg_0.261 = pred[128]{0} parameter(0)
  Arg_1.262 = f32[128]{0} parameter(1)
  Arg_2.263 = f32[] parameter(2)
  broadcast.264 = f32[128]{0} broadcast(Arg_2.263), dimensions={}
  ROOT select.265 = f32[128]{0} select(Arg_0.261, Arg_1.262, broadcast.264)
}

_where.268 {
  Arg_0.269 = pred[128]{0} parameter(0)
  Arg_1.270 = f32[128]{0} parameter(1)
  Arg_2.271 = f32[] parameter(2)
  broadcast.272 = f32[128]{0} broadcast(Arg_2.271), dimensions={}
  ROOT select.273 = f32[128]{0} select(Arg_0.269, Arg_1.270, broadcast.272)
}

_where.277 {
  Arg_0.278 = pred[128]{0} parameter(0)
  Arg_1.279 = f32[128]{0} parameter(1)
  Arg_2.280 = f32[] parameter(2)
  broadcast.281 = f32[128]{0} broadcast(Arg_2.280), dimensions={}
  ROOT select.282 = f32[128]{0} select(Arg_0.278, Arg_1.279, broadcast.281)
}

_where.286 {
  Arg_0.287 = pred[128]{0} parameter(0)
  Arg_1.288 = f32[128]{0} parameter(1)
  Arg_2.289 = f32[] parameter(2)
  broadcast.290 = f32[128]{0} broadcast(Arg_2.289), dimensions={}
  ROOT select.291 = f32[128]{0} select(Arg_0.287, Arg_1.288, broadcast.290)
}

_where.295 {
  Arg_0.296 = pred[128]{0} parameter(0)
  Arg_1.297 = f32[128]{0} parameter(1)
  Arg_2.298 = f32[] parameter(2)
  broadcast.299 = f32[128]{0} broadcast(Arg_2.298), dimensions={}
  ROOT select.300 = f32[128]{0} select(Arg_0.296, Arg_1.297, broadcast.299)
}

_where.304 {
  Arg_0.305 = pred[128]{0} parameter(0)
  Arg_1.306 = f32[128]{0} parameter(1)
  Arg_2.307 = f32[] parameter(2)
  broadcast.308 = f32[128]{0} broadcast(Arg_2.307), dimensions={}
  ROOT select.309 = f32[128]{0} select(Arg_0.305, Arg_1.306, broadcast.308)
}

_where.313 {
  Arg_0.314 = pred[128]{0} parameter(0)
  Arg_1.315 = f32[128]{0} parameter(1)
  Arg_2.316 = f32[] parameter(2)
  broadcast.317 = f32[128]{0} broadcast(Arg_2.316), dimensions={}
  ROOT select.318 = f32[128]{0} select(Arg_0.314, Arg_1.315, broadcast.317)
}

_where.321 {
  Arg_0.322 = pred[128]{0} parameter(0)
  Arg_1.323 = f32[128]{0} parameter(1)
  Arg_2.324 = f32[] parameter(2)
  broadcast.325 = f32[128]{0} broadcast(Arg_2.324), dimensions={}
  ROOT select.326 = f32[128]{0} select(Arg_0.322, Arg_1.323, broadcast.325)
}

_where.330 {
  Arg_0.331 = pred[128]{0} parameter(0)
  Arg_1.332 = f32[128]{0} parameter(1)
  Arg_2.333 = f32[] parameter(2)
  broadcast.334 = f32[128]{0} broadcast(Arg_2.333), dimensions={}
  ROOT select.335 = f32[128]{0} select(Arg_0.331, Arg_1.332, broadcast.334)
}

_where.339 {
  Arg_0.340 = pred[128]{0} parameter(0)
  Arg_1.341 = f32[128]{0} parameter(1)
  Arg_2.342 = f32[] parameter(2)
  broadcast.343 = f32[128]{0} broadcast(Arg_2.342), dimensions={}
  ROOT select.344 = f32[128]{0} select(Arg_0.340, Arg_1.341, broadcast.343)
}

_where.348 {
  Arg_0.349 = pred[128]{0} parameter(0)
  Arg_1.350 = f32[128]{0} parameter(1)
  Arg_2.351 = f32[] parameter(2)
  broadcast.352 = f32[128]{0} broadcast(Arg_2.351), dimensions={}
  ROOT select.353 = f32[128]{0} select(Arg_0.349, Arg_1.350, broadcast.352)
}

_where.357 {
  Arg_0.358 = pred[128]{0} parameter(0)
  Arg_1.359 = f32[128]{0} parameter(1)
  Arg_2.360 = f32[] parameter(2)
  broadcast.361 = f32[128]{0} broadcast(Arg_2.360), dimensions={}
  ROOT select.362 = f32[128]{0} select(Arg_0.358, Arg_1.359, broadcast.361)
}

_where.366 {
  Arg_0.367 = pred[128]{0} parameter(0)
  Arg_1.368 = f32[128]{0} parameter(1)
  Arg_2.369 = f32[] parameter(2)
  broadcast.370 = f32[128]{0} broadcast(Arg_2.369), dimensions={}
  ROOT select.371 = f32[128]{0} select(Arg_0.367, Arg_1.368, broadcast.370)
}

_where.374 {
  Arg_0.375 = pred[128]{0} parameter(0)
  Arg_1.376 = f32[128]{0} parameter(1)
  Arg_2.377 = f32[] parameter(2)
  broadcast.378 = f32[128]{0} broadcast(Arg_2.377), dimensions={}
  ROOT select.379 = f32[128]{0} select(Arg_0.375, Arg_1.376, broadcast.378)
}

_where.383 {
  Arg_0.384 = pred[128]{0} parameter(0)
  Arg_1.385 = f32[128]{0} parameter(1)
  Arg_2.386 = f32[] parameter(2)
  broadcast.387 = f32[128]{0} broadcast(Arg_2.386), dimensions={}
  ROOT select.388 = f32[128]{0} select(Arg_0.384, Arg_1.385, broadcast.387)
}

_where.392 {
  Arg_0.393 = pred[128]{0} parameter(0)
  Arg_1.394 = f32[128]{0} parameter(1)
  Arg_2.395 = f32[] parameter(2)
  broadcast.396 = f32[128]{0} broadcast(Arg_2.395), dimensions={}
  ROOT select.397 = f32[128]{0} select(Arg_0.393, Arg_1.394, broadcast.396)
}

_where.401 {
  Arg_0.402 = pred[128]{0} parameter(0)
  Arg_1.403 = f32[128]{0} parameter(1)
  Arg_2.404 = f32[] parameter(2)
  broadcast.405 = f32[128]{0} broadcast(Arg_2.404), dimensions={}
  ROOT select.406 = f32[128]{0} select(Arg_0.402, Arg_1.403, broadcast.405)
}

_where.410 {
  Arg_0.411 = pred[128]{0} parameter(0)
  Arg_1.412 = f32[128]{0} parameter(1)
  Arg_2.413 = f32[] parameter(2)
  broadcast.414 = f32[128]{0} broadcast(Arg_2.413), dimensions={}
  ROOT select.415 = f32[128]{0} select(Arg_0.411, Arg_1.412, broadcast.414)
}

_where.419 {
  Arg_0.420 = pred[128]{0} parameter(0)
  Arg_1.421 = f32[128]{0} parameter(1)
  Arg_2.422 = f32[] parameter(2)
  broadcast.423 = f32[128]{0} broadcast(Arg_2.422), dimensions={}
  ROOT select.424 = f32[128]{0} select(Arg_0.420, Arg_1.421, broadcast.423)
}

_where.427 {
  Arg_0.428 = pred[128]{0} parameter(0)
  Arg_1.429 = f32[128]{0} parameter(1)
  Arg_2.430 = f32[] parameter(2)
  broadcast.431 = f32[128]{0} broadcast(Arg_2.430), dimensions={}
  ROOT select.432 = f32[128]{0} select(Arg_0.428, Arg_1.429, broadcast.431)
}

_where.436 {
  Arg_0.437 = pred[128]{0} parameter(0)
  Arg_1.438 = f32[128]{0} parameter(1)
  Arg_2.439 = f32[] parameter(2)
  broadcast.440 = f32[128]{0} broadcast(Arg_2.439), dimensions={}
  ROOT select.441 = f32[128]{0} select(Arg_0.437, Arg_1.438, broadcast.440)
}

_where.445 {
  Arg_0.446 = pred[128]{0} parameter(0)
  Arg_1.447 = f32[128]{0} parameter(1)
  Arg_2.448 = f32[] parameter(2)
  broadcast.449 = f32[128]{0} broadcast(Arg_2.448), dimensions={}
  ROOT select.450 = f32[128]{0} select(Arg_0.446, Arg_1.447, broadcast.449)
}

_where.454 {
  Arg_0.455 = pred[128]{0} parameter(0)
  Arg_1.456 = f32[128]{0} parameter(1)
  Arg_2.457 = f32[] parameter(2)
  broadcast.458 = f32[128]{0} broadcast(Arg_2.457), dimensions={}
  ROOT select.459 = f32[128]{0} select(Arg_0.455, Arg_1.456, broadcast.458)
}

_where.463 {
  Arg_0.464 = pred[128]{0} parameter(0)
  Arg_1.465 = f32[128]{0} parameter(1)
  Arg_2.466 = f32[] parameter(2)
  broadcast.467 = f32[128]{0} broadcast(Arg_2.466), dimensions={}
  ROOT select.468 = f32[128]{0} select(Arg_0.464, Arg_1.465, broadcast.467)
}

_where.472 {
  Arg_0.473 = pred[128]{0} parameter(0)
  Arg_1.474 = f32[128]{0} parameter(1)
  Arg_2.475 = f32[] parameter(2)
  broadcast.476 = f32[128]{0} broadcast(Arg_2.475), dimensions={}
  ROOT select.477 = f32[128]{0} select(Arg_0.473, Arg_1.474, broadcast.476)
}

_where.480 {
  Arg_0.481 = pred[128]{0} parameter(0)
  Arg_1.482 = f32[128]{0} parameter(1)
  Arg_2.483 = f32[] parameter(2)
  broadcast.484 = f32[128]{0} broadcast(Arg_2.483), dimensions={}
  ROOT select.485 = f32[128]{0} select(Arg_0.481, Arg_1.482, broadcast.484)
}

_where.489 {
  Arg_0.490 = pred[128]{0} parameter(0)
  Arg_1.491 = f32[128]{0} parameter(1)
  Arg_2.492 = f32[] parameter(2)
  broadcast.493 = f32[128]{0} broadcast(Arg_2.492), dimensions={}
  ROOT select.494 = f32[128]{0} select(Arg_0.490, Arg_1.491, broadcast.493)
}

_where.498 {
  Arg_0.499 = pred[128]{0} parameter(0)
  Arg_1.500 = f32[128]{0} parameter(1)
  Arg_2.501 = f32[] parameter(2)
  broadcast.502 = f32[128]{0} broadcast(Arg_2.501), dimensions={}
  ROOT select.503 = f32[128]{0} select(Arg_0.499, Arg_1.500, broadcast.502)
}

_where.507 {
  Arg_0.508 = pred[128]{0} parameter(0)
  Arg_1.509 = f32[128]{0} parameter(1)
  Arg_2.510 = f32[] parameter(2)
  broadcast.511 = f32[128]{0} broadcast(Arg_2.510), dimensions={}
  ROOT select.512 = f32[128]{0} select(Arg_0.508, Arg_1.509, broadcast.511)
}

_where.516 {
  Arg_0.517 = pred[128]{0} parameter(0)
  Arg_1.518 = f32[128]{0} parameter(1)
  Arg_2.519 = f32[] parameter(2)
  broadcast.520 = f32[128]{0} broadcast(Arg_2.519), dimensions={}
  ROOT select.521 = f32[128]{0} select(Arg_0.517, Arg_1.518, broadcast.520)
}

_where.525 {
  Arg_0.526 = pred[128]{0} parameter(0)
  Arg_1.527 = f32[128]{0} parameter(1)
  Arg_2.528 = f32[] parameter(2)
  broadcast.529 = f32[128]{0} broadcast(Arg_2.528), dimensions={}
  ROOT select.530 = f32[128]{0} select(Arg_0.526, Arg_1.527, broadcast.529)
}

_where.533 {
  Arg_0.534 = pred[128]{0} parameter(0)
  Arg_1.535 = f32[128]{0} parameter(1)
  Arg_2.536 = f32[] parameter(2)
  broadcast.537 = f32[128]{0} broadcast(Arg_2.536), dimensions={}
  ROOT select.538 = f32[128]{0} select(Arg_0.534, Arg_1.535, broadcast.537)
}

_where.542 {
  Arg_0.543 = pred[128]{0} parameter(0)
  Arg_1.544 = f32[128]{0} parameter(1)
  Arg_2.545 = f32[] parameter(2)
  broadcast.546 = f32[128]{0} broadcast(Arg_2.545), dimensions={}
  ROOT select.547 = f32[128]{0} select(Arg_0.543, Arg_1.544, broadcast.546)
}

_where.551 {
  Arg_0.552 = pred[128]{0} parameter(0)
  Arg_1.553 = f32[128]{0} parameter(1)
  Arg_2.554 = f32[] parameter(2)
  broadcast.555 = f32[128]{0} broadcast(Arg_2.554), dimensions={}
  ROOT select.556 = f32[128]{0} select(Arg_0.552, Arg_1.553, broadcast.555)
}

_where.560 {
  Arg_0.561 = pred[128]{0} parameter(0)
  Arg_1.562 = f32[128]{0} parameter(1)
  Arg_2.563 = f32[] parameter(2)
  broadcast.564 = f32[128]{0} broadcast(Arg_2.563), dimensions={}
  ROOT select.565 = f32[128]{0} select(Arg_0.561, Arg_1.562, broadcast.564)
}

_where.569 {
  Arg_0.570 = pred[128]{0} parameter(0)
  Arg_1.571 = f32[128]{0} parameter(1)
  Arg_2.572 = f32[] parameter(2)
  broadcast.573 = f32[128]{0} broadcast(Arg_2.572), dimensions={}
  ROOT select.574 = f32[128]{0} select(Arg_0.570, Arg_1.571, broadcast.573)
}

_where.578 {
  Arg_0.579 = pred[128]{0} parameter(0)
  Arg_1.580 = f32[128]{0} parameter(1)
  Arg_2.581 = f32[] parameter(2)
  broadcast.582 = f32[128]{0} broadcast(Arg_2.581), dimensions={}
  ROOT select.583 = f32[128]{0} select(Arg_0.579, Arg_1.580, broadcast.582)
}

_where.586 {
  Arg_0.587 = pred[128]{0} parameter(0)
  Arg_1.588 = f32[128]{0} parameter(1)
  Arg_2.589 = f32[] parameter(2)
  broadcast.590 = f32[128]{0} broadcast(Arg_2.589), dimensions={}
  ROOT select.591 = f32[128]{0} select(Arg_0.587, Arg_1.588, broadcast.590)
}

_where.595 {
  Arg_0.596 = pred[128]{0} parameter(0)
  Arg_1.597 = f32[128]{0} parameter(1)
  Arg_2.598 = f32[] parameter(2)
  broadcast.599 = f32[128]{0} broadcast(Arg_2.598), dimensions={}
  ROOT select.600 = f32[128]{0} select(Arg_0.596, Arg_1.597, broadcast.599)
}

_where.604 {
  Arg_0.605 = pred[128]{0} parameter(0)
  Arg_1.606 = f32[128]{0} parameter(1)
  Arg_2.607 = f32[] parameter(2)
  broadcast.608 = f32[128]{0} broadcast(Arg_2.607), dimensions={}
  ROOT select.609 = f32[128]{0} select(Arg_0.605, Arg_1.606, broadcast.608)
}

_where.613 {
  Arg_0.614 = pred[128]{0} parameter(0)
  Arg_1.615 = f32[128]{0} parameter(1)
  Arg_2.616 = f32[] parameter(2)
  broadcast.617 = f32[128]{0} broadcast(Arg_2.616), dimensions={}
  ROOT select.618 = f32[128]{0} select(Arg_0.614, Arg_1.615, broadcast.617)
}

_where.622 {
  Arg_0.623 = pred[128]{0} parameter(0)
  Arg_1.624 = f32[128]{0} parameter(1)
  Arg_2.625 = f32[] parameter(2)
  broadcast.626 = f32[128]{0} broadcast(Arg_2.625), dimensions={}
  ROOT select.627 = f32[128]{0} select(Arg_0.623, Arg_1.624, broadcast.626)
}

_pad.630 {
  Arg_0.631 = f32[128,128]{1,0} parameter(0)
  Arg_1.632 = s32[] parameter(1)
  convert.633 = f32[] convert(Arg_1.632)
  ROOT pad.634 = f32[128,134]{1,0} pad(Arg_0.631, convert.633), padding=0_0x3_3
}

_roll_static.685 {
  Arg_0.686 = f32[128,14]{1,0} parameter(0)
  slice.687 = f32[126,14]{1,0} slice(Arg_0.686), slice={[2:128], [0:14]}
  slice.688 = f32[2,14]{1,0} slice(Arg_0.686), slice={[0:2], [0:14]}
  ROOT concatenate.689 = f32[128,14]{1,0} concatenate(slice.687, slice.688), dimensions={0}
}

_roll_static_0.692 {
  Arg_0.693 = f32[128,50]{1,0} parameter(0)
  slice.694 = f32[127,50]{1,0} slice(Arg_0.693), slice={[1:128], [0:50]}
  slice.695 = f32[1,50]{1,0} slice(Arg_0.693), slice={[0:1], [0:50]}
  ROOT concatenate.696 = f32[128,50]{1,0} concatenate(slice.694, slice.695), dimensions={0}
}

_roll_static_1.699 {
  ROOT Arg_0.700 = f32[128,50]{1,0} parameter(0)
}

_roll_static_2.703 {
  Arg_0.704 = f32[128,14]{1,0} parameter(0)
  slice.705 = f32[1,14]{1,0} slice(Arg_0.704), slice={[127:128], [0:14]}
  slice.706 = f32[127,14]{1,0} slice(Arg_0.704), slice={[0:127], [0:14]}
  ROOT concatenate.707 = f32[128,14]{1,0} concatenate(slice.705, slice.706), dimensions={0}
}

_roll_static_3.710 {
  Arg_0.711 = f32[128,128]{1,0} parameter(0)
  slice.712 = f32[126,128]{1,0} slice(Arg_0.711), slice={[2:128], [0:128]}
  slice.713 = f32[2,128]{1,0} slice(Arg_0.711), slice={[0:2], [0:128]}
  ROOT concatenate.714 = f32[128,128]{1,0} concatenate(slice.712, slice.713), dimensions={0}
}

_roll_static_4.720 {
  Arg_0.721 = f32[128,128]{1,0} parameter(0)
  slice.722 = f32[127,128]{1,0} slice(Arg_0.721), slice={[1:128], [0:128]}
  slice.723 = f32[1,128]{1,0} slice(Arg_0.721), slice={[0:1], [0:128]}
  ROOT concatenate.724 = f32[128,128]{1,0} concatenate(slice.722, slice.723), dimensions={0}
}

_roll_static_5.731 {
  ROOT Arg_0.732 = f32[128,128]{1,0} parameter(0)
}

_roll_static_6.739 {
  Arg_0.740 = f32[128,128]{1,0} parameter(0)
  slice.741 = f32[1,128]{1,0} slice(Arg_0.740), slice={[127:128], [0:128]}
  slice.742 = f32[127,128]{1,0} slice(Arg_0.740), slice={[0:127], [0:128]}
  ROOT concatenate.743 = f32[128,128]{1,0} concatenate(slice.741, slice.742), dimensions={0}
}

_roll_static_7.750 {
  Arg_0.751 = f32[128,128]{1,0} parameter(0)
  slice.752 = f32[2,128]{1,0} slice(Arg_0.751), slice={[126:128], [0:128]}
  slice.753 = f32[126,128]{1,0} slice(Arg_0.751), slice={[0:126], [0:128]}
  ROOT concatenate.754 = f32[128,128]{1,0} concatenate(slice.752, slice.753), dimensions={0}
}

_roll_static_8.761 {
  Arg_0.762 = f32[128,128]{1,0} parameter(0)
  slice.763 = f32[3,128]{1,0} slice(Arg_0.762), slice={[125:128], [0:128]}
  slice.764 = f32[125,128]{1,0} slice(Arg_0.762), slice={[0:125], [0:128]}
  ROOT concatenate.765 = f32[128,128]{1,0} concatenate(slice.763, slice.764), dimensions={0}
}

ENTRY main.773 {
  Arg_0.1 = f32[128,128]{1,0} parameter(0)
  slice.64 = f32[128,14]{1,0} slice(Arg_0.1), slice={[0:128], [0:14]}
  call.70 = f32[128,14]{1,0} call(slice.64), to_apply=_roll_static.65
  slice.71 = f32[128,50]{1,0} slice(Arg_0.1), slice={[0:128], [14:64]}
  call.77 = f32[128,50]{1,0} call(slice.71), to_apply=_roll_static_0.72
  slice.78 = f32[128,50]{1,0} slice(Arg_0.1), slice={[0:128], [64:114]}
  call.81 = f32[128,50]{1,0} call(slice.78), to_apply=_roll_static_1.79
  slice.82 = f32[128,14]{1,0} slice(Arg_0.1), slice={[0:128], [114:128]}
  call.88 = f32[128,14]{1,0} call(slice.82), to_apply=_roll_static_2.83
  concatenate.89 = f32[128,128]{1,0} concatenate(call.70, call.77, call.81, call.88), dimensions={1}
  call.95 = f32[128,128]{1,0} call(concatenate.89), to_apply=_roll_static_3.90
  constant.59 = f32[1,128]{1,0} constant({...})
  broadcast.96 = f32[1,128]{1,0} broadcast(constant.59), dimensions={0,1}
  reshape.97 = f32[128]{0} reshape(broadcast.96)
  broadcast.98 = f32[128,128]{1,0} broadcast(reshape.97), dimensions={1}
  multiply.99 = f32[128,128]{1,0} multiply(call.95, broadcast.98)
  call.105 = f32[128,128]{1,0} call(concatenate.89), to_apply=_roll_static_4.100
  constant.58 = f32[1,128]{1,0} constant({...})
  broadcast.106 = f32[1,128]{1,0} broadcast(constant.58), dimensions={0,1}
  reshape.107 = f32[128]{0} reshape(broadcast.106)
  broadcast.108 = f32[128,128]{1,0} broadcast(reshape.107), dimensions={1}
  multiply.109 = f32[128,128]{1,0} multiply(call.105, broadcast.108)
  add.110 = f32[128,128]{1,0} add(multiply.99, multiply.109)
  call.113 = f32[128,128]{1,0} call(concatenate.89), to_apply=_roll_static_5.111
  constant.57 = f32[1,128]{1,0} constant({...})
  broadcast.114 = f32[1,128]{1,0} broadcast(constant.57), dimensions={0,1}
  reshape.115 = f32[128]{0} reshape(broadcast.114)
  broadcast.116 = f32[128,128]{1,0} broadcast(reshape.115), dimensions={1}
  multiply.117 = f32[128,128]{1,0} multiply(call.113, broadcast.116)
  add.118 = f32[128,128]{1,0} add(add.110, multiply.117)
  call.124 = f32[128,128]{1,0} call(concatenate.89), to_apply=_roll_static_6.119
  constant.56 = f32[1,128]{1,0} constant({...})
  broadcast.125 = f32[1,128]{1,0} broadcast(constant.56), dimensions={0,1}
  reshape.126 = f32[128]{0} reshape(broadcast.125)
  broadcast.127 = f32[128,128]{1,0} broadcast(reshape.126), dimensions={1}
  multiply.128 = f32[128,128]{1,0} multiply(call.124, broadcast.127)
  add.129 = f32[128,128]{1,0} add(add.118, multiply.128)
  call.135 = f32[128,128]{1,0} call(concatenate.89), to_apply=_roll_static_7.130
  constant.55 = f32[1,128]{1,0} constant({...})
  broadcast.136 = f32[1,128]{1,0} broadcast(constant.55), dimensions={0,1}
  reshape.137 = f32[128]{0} reshape(broadcast.136)
  broadcast.138 = f32[128,128]{1,0} broadcast(reshape.137), dimensions={1}
  multiply.139 = f32[128,128]{1,0} multiply(call.135, broadcast.138)
  add.140 = f32[128,128]{1,0} add(add.129, multiply.139)
  call.146 = f32[128,128]{1,0} call(concatenate.89), to_apply=_roll_static_8.141
  constant.54 = f32[1,128]{1,0} constant({...})
  broadcast.147 = f32[1,128]{1,0} broadcast(constant.54), dimensions={0,1}
  reshape.148 = f32[128]{0} reshape(broadcast.147)
  broadcast.149 = f32[128,128]{1,0} broadcast(reshape.148), dimensions={1}
  multiply.150 = f32[128,128]{1,0} multiply(call.146, broadcast.149)
  add.151 = f32[128,128]{1,0} add(add.140, multiply.150)
  constant.63 = f32[65]{0} constant({...})
  constant.61 = f32[] constant(0.0787401572)
  call.188 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) call(add.151, constant.63, constant.61), to_apply=solve_poisson.165
  get-tuple-element.189 = f32[128]{0} get-tuple-element(call.188), index=0
  constant.52 = f32[] constant(0.05)
  broadcast.53 = f32[128]{0} broadcast(constant.52), dimensions={}
  multiply.192 = f32[128]{0} multiply(get-tuple-element.189, broadcast.53)
  constant.50 = f32[] constant(0.0787401572)
  broadcast.51 = f32[128]{0} broadcast(constant.50), dimensions={}
  divide.193 = f32[128]{0} divide(multiply.192, broadcast.51)
  floor.194 = f32[128]{0} floor(divide.193)
  convert.196 = s32[128]{0} convert(floor.194)
  constant.24 = s32[] constant(-1)
  broadcast.25 = s32[128]{0} broadcast(constant.24), dimensions={}
  compare.259 = pred[128]{0} compare(convert.196, broadcast.25), direction=EQ
  subtract.195 = f32[128]{0} subtract(divide.193, floor.194)
  constant.48 = f32[] constant(20)
  broadcast.49 = f32[128]{0} broadcast(constant.48), dimensions={}
  divide.201 = f32[128]{0} divide(subtract.195, broadcast.49)
  multiply.197 = f32[128]{0} multiply(subtract.195, subtract.195)
  constant.46 = f32[] constant(24)
  broadcast.47 = f32[128]{0} broadcast(constant.46), dimensions={}
  divide.202 = f32[128]{0} divide(multiply.197, broadcast.47)
  subtract.203 = f32[128]{0} subtract(divide.201, divide.202)
  multiply.198 = f32[128]{0} multiply(multiply.197, subtract.195)
  divide.204 = f32[128]{0} divide(multiply.198, broadcast.47)
  subtract.205 = f32[128]{0} subtract(subtract.203, divide.204)
  multiply.199 = f32[128]{0} multiply(multiply.198, subtract.195)
  divide.206 = f32[128]{0} divide(multiply.199, broadcast.47)
  add.207 = f32[128]{0} add(subtract.205, divide.206)
  multiply.200 = f32[128]{0} multiply(multiply.199, subtract.195)
  constant.44 = f32[] constant(120)
  broadcast.45 = f32[128]{0} broadcast(constant.44), dimensions={}
  divide.208 = f32[128]{0} divide(multiply.200, broadcast.45)
  subtract.209 = f32[128]{0} subtract(add.207, divide.208)
  constant.62 = f32[] constant(0)
  call.266 = f32[128]{0} call(compare.259, subtract.209, constant.62), to_apply=_where.260
  constant.22 = s32[] constant(-2)
  broadcast.23 = s32[128]{0} broadcast(constant.22), dimensions={}
  compare.267 = pred[128]{0} compare(convert.196, broadcast.23), direction=EQ
  constant.42 = f32[] constant(2)
  broadcast.43 = f32[128]{0} broadcast(constant.42), dimensions={}
  divide.210 = f32[128]{0} divide(subtract.195, broadcast.43)
  negate.211 = f32[128]{0} negate(divide.210)
  multiply.212 = f32[128]{0} multiply(multiply.197, broadcast.43)
  constant.40 = f32[] constant(3)
  broadcast.41 = f32[128]{0} broadcast(constant.40), dimensions={}
  divide.213 = f32[128]{0} divide(multiply.212, broadcast.41)
  add.214 = f32[128]{0} add(negate.211, divide.213)
  divide.215 = f32[128]{0} divide(multiply.198, broadcast.47)
  subtract.216 = f32[128]{0} subtract(add.214, divide.215)
  constant.38 = f32[] constant(6)
  broadcast.39 = f32[128]{0} broadcast(constant.38), dimensions={}
  divide.217 = f32[128]{0} divide(multiply.199, broadcast.39)
  subtract.218 = f32[128]{0} subtract(subtract.216, divide.217)
  divide.219 = f32[128]{0} divide(multiply.200, broadcast.47)
  add.220 = f32[128]{0} add(subtract.218, divide.219)
  call.274 = f32[128]{0} call(compare.267, add.220, constant.62), to_apply=_where.268
  add.275 = f32[128]{0} add(call.266, call.274)
  constant.20 = s32[] constant(-3)
  broadcast.21 = s32[128]{0} broadcast(constant.20), dimensions={}
  compare.276 = pred[128]{0} compare(convert.196, broadcast.21), direction=EQ
  constant.36 = f32[] constant(1)
  broadcast.37 = f32[128]{0} broadcast(constant.36), dimensions={}
  divide.221 = f32[128]{0} divide(subtract.195, broadcast.41)
  subtract.222 = f32[128]{0} subtract(broadcast.37, divide.221)
  constant.34 = f32[] constant(5)
  broadcast.35 = f32[128]{0} broadcast(constant.34), dimensions={}
  multiply.223 = f32[128]{0} multiply(multiply.197, broadcast.35)
  constant.32 = f32[] constant(4)
  broadcast.33 = f32[128]{0} broadcast(constant.32), dimensions={}
  divide.224 = f32[128]{0} divide(multiply.223, broadcast.33)
  subtract.225 = f32[128]{0} subtract(subtract.222, divide.224)
  multiply.226 = f32[128]{0} multiply(multiply.198, broadcast.35)
  constant.30 = f32[] constant(12)
  broadcast.31 = f32[128]{0} broadcast(constant.30), dimensions={}
  divide.227 = f32[128]{0} divide(multiply.226, broadcast.31)
  add.228 = f32[128]{0} add(subtract.225, divide.227)
  divide.229 = f32[128]{0} divide(multiply.199, broadcast.33)
  add.230 = f32[128]{0} add(add.228, divide.229)
  divide.231 = f32[128]{0} divide(multiply.200, broadcast.31)
  subtract.232 = f32[128]{0} subtract(add.230, divide.231)
  call.283 = f32[128]{0} call(compare.276, subtract.232, constant.62), to_apply=_where.277
  add.284 = f32[128]{0} add(add.275, call.283)
  constant.18 = s32[] constant(-4)
  broadcast.19 = s32[128]{0} broadcast(constant.18), dimensions={}
  compare.285 = pred[128]{0} compare(convert.196, broadcast.19), direction=EQ
  multiply.233 = f32[128]{0} multiply(multiply.197, broadcast.43)
  divide.234 = f32[128]{0} divide(multiply.233, broadcast.41)
  add.235 = f32[128]{0} add(subtract.195, divide.234)
  constant.28 = f32[] constant(7)
  broadcast.29 = f32[128]{0} broadcast(constant.28), dimensions={}
  multiply.236 = f32[128]{0} multiply(multiply.198, broadcast.29)
  divide.237 = f32[128]{0} divide(multiply.236, broadcast.31)
  subtract.238 = f32[128]{0} subtract(add.235, divide.237)
  divide.239 = f32[128]{0} divide(multiply.199, broadcast.39)
  subtract.240 = f32[128]{0} subtract(subtract.238, divide.239)
  divide.241 = f32[128]{0} divide(multiply.200, broadcast.31)
  add.242 = f32[128]{0} add(subtract.240, divide.241)
  call.292 = f32[128]{0} call(compare.285, add.242, constant.62), to_apply=_where.286
  add.293 = f32[128]{0} add(add.284, call.292)
  constant.16 = s32[] constant(-5)
  broadcast.17 = s32[128]{0} broadcast(constant.16), dimensions={}
  compare.294 = pred[128]{0} compare(convert.196, broadcast.17), direction=EQ
  divide.243 = f32[128]{0} divide(subtract.195, broadcast.33)
  negate.244 = f32[128]{0} negate(divide.243)
  divide.245 = f32[128]{0} divide(multiply.197, broadcast.47)
  subtract.246 = f32[128]{0} subtract(negate.244, divide.245)
  multiply.247 = f32[128]{0} multiply(multiply.198, broadcast.29)
  divide.248 = f32[128]{0} divide(multiply.247, broadcast.47)
  add.249 = f32[128]{0} add(subtract.246, divide.248)
  divide.250 = f32[128]{0} divide(multiply.199, broadcast.47)
  add.251 = f32[128]{0} add(add.249, divide.250)
  divide.252 = f32[128]{0} divide(multiply.200, broadcast.47)
  subtract.253 = f32[128]{0} subtract(add.251, divide.252)
  call.301 = f32[128]{0} call(compare.294, subtract.253, constant.62), to_apply=_where.295
  add.302 = f32[128]{0} add(add.293, call.301)
  constant.14 = s32[] constant(-6)
  broadcast.15 = s32[128]{0} broadcast(constant.14), dimensions={}
  compare.303 = pred[128]{0} compare(convert.196, broadcast.15), direction=EQ
  constant.26 = f32[] constant(30)
  broadcast.27 = f32[128]{0} broadcast(constant.26), dimensions={}
  divide.254 = f32[128]{0} divide(subtract.195, broadcast.27)
  divide.255 = f32[128]{0} divide(multiply.198, broadcast.47)
  subtract.256 = f32[128]{0} subtract(divide.254, divide.255)
  divide.257 = f32[128]{0} divide(multiply.200, broadcast.45)
  add.258 = f32[128]{0} add(subtract.256, divide.257)
  call.310 = f32[128]{0} call(compare.303, add.258, constant.62), to_apply=_where.304
  add.311 = f32[128]{0} add(add.302, call.310)
  reshape.636 = f32[128,1]{1,0} reshape(add.311)
  broadcast.638 = f32[128,1]{1,0} broadcast(reshape.636), dimensions={0,1}
  reshape.639 = f32[128]{0} reshape(broadcast.638)
  broadcast.640 = f32[128,128]{1,0} broadcast(reshape.639), dimensions={0}
  constant.60 = s32[] constant(0)
  call.635 = f32[128,134]{1,0} call(add.151, constant.60), to_apply=_pad.630
  slice.637 = f32[128,128]{1,0} slice(call.635), slice={[0:128], [6:134]}
  multiply.641 = f32[128,128]{1,0} multiply(broadcast.640, slice.637)
  constant.12 = s32[] constant(0)
  broadcast.13 = s32[128]{0} broadcast(constant.12), dimensions={}
  compare.312 = pred[128]{0} compare(convert.196, broadcast.13), direction=EQ
  call.319 = f32[128]{0} call(compare.312, subtract.209, constant.62), to_apply=_where.313
  compare.320 = pred[128]{0} compare(convert.196, broadcast.25), direction=EQ
  call.327 = f32[128]{0} call(compare.320, add.220, constant.62), to_apply=_where.321
  add.328 = f32[128]{0} add(call.319, call.327)
  compare.329 = pred[128]{0} compare(convert.196, broadcast.23), direction=EQ
  call.336 = f32[128]{0} call(compare.329, subtract.232, constant.62), to_apply=_where.330
  add.337 = f32[128]{0} add(add.328, call.336)
  compare.338 = pred[128]{0} compare(convert.196, broadcast.21), direction=EQ
  call.345 = f32[128]{0} call(compare.338, add.242, constant.62), to_apply=_where.339
  add.346 = f32[128]{0} add(add.337, call.345)
  compare.347 = pred[128]{0} compare(convert.196, broadcast.19), direction=EQ
  call.354 = f32[128]{0} call(compare.347, subtract.253, constant.62), to_apply=_where.348
  add.355 = f32[128]{0} add(add.346, call.354)
  compare.356 = pred[128]{0} compare(convert.196, broadcast.17), direction=EQ
  call.363 = f32[128]{0} call(compare.356, add.258, constant.62), to_apply=_where.357
  add.364 = f32[128]{0} add(add.355, call.363)
  reshape.642 = f32[128,1]{1,0} reshape(add.364)
  broadcast.644 = f32[128,1]{1,0} broadcast(reshape.642), dimensions={0,1}
  reshape.645 = f32[128]{0} reshape(broadcast.644)
  broadcast.646 = f32[128,128]{1,0} broadcast(reshape.645), dimensions={0}
  slice.643 = f32[128,128]{1,0} slice(call.635), slice={[0:128], [5:133]}
  multiply.647 = f32[128,128]{1,0} multiply(broadcast.646, slice.643)
  add.648 = f32[128,128]{1,0} add(multiply.641, multiply.647)
  constant.10 = s32[] constant(1)
  broadcast.11 = s32[128]{0} broadcast(constant.10), dimensions={}
  compare.365 = pred[128]{0} compare(convert.196, broadcast.11), direction=EQ
  call.372 = f32[128]{0} call(compare.365, subtract.209, constant.62), to_apply=_where.366
  compare.373 = pred[128]{0} compare(convert.196, broadcast.13), direction=EQ
  call.380 = f32[128]{0} call(compare.373, add.220, constant.62), to_apply=_where.374
  add.381 = f32[128]{0} add(call.372, call.380)
  compare.382 = pred[128]{0} compare(convert.196, broadcast.25), direction=EQ
  call.389 = f32[128]{0} call(compare.382, subtract.232, constant.62), to_apply=_where.383
  add.390 = f32[128]{0} add(add.381, call.389)
  compare.391 = pred[128]{0} compare(convert.196, broadcast.23), direction=EQ
  call.398 = f32[128]{0} call(compare.391, add.242, constant.62), to_apply=_where.392
  add.399 = f32[128]{0} add(add.390, call.398)
  compare.400 = pred[128]{0} compare(convert.196, broadcast.21), direction=EQ
  call.407 = f32[128]{0} call(compare.400, subtract.253, constant.62), to_apply=_where.401
  add.408 = f32[128]{0} add(add.399, call.407)
  compare.409 = pred[128]{0} compare(convert.196, broadcast.19), direction=EQ
  call.416 = f32[128]{0} call(compare.409, add.258, constant.62), to_apply=_where.410
  add.417 = f32[128]{0} add(add.408, call.416)
  reshape.649 = f32[128,1]{1,0} reshape(add.417)
  broadcast.651 = f32[128,1]{1,0} broadcast(reshape.649), dimensions={0,1}
  reshape.652 = f32[128]{0} reshape(broadcast.651)
  broadcast.653 = f32[128,128]{1,0} broadcast(reshape.652), dimensions={0}
  slice.650 = f32[128,128]{1,0} slice(call.635), slice={[0:128], [4:132]}
  multiply.654 = f32[128,128]{1,0} multiply(broadcast.653, slice.650)
  add.655 = f32[128,128]{1,0} add(add.648, multiply.654)
  constant.8 = s32[] constant(2)
  broadcast.9 = s32[128]{0} broadcast(constant.8), dimensions={}
  compare.418 = pred[128]{0} compare(convert.196, broadcast.9), direction=EQ
  call.425 = f32[128]{0} call(compare.418, subtract.209, constant.62), to_apply=_where.419
  compare.426 = pred[128]{0} compare(convert.196, broadcast.11), direction=EQ
  call.433 = f32[128]{0} call(compare.426, add.220, constant.62), to_apply=_where.427
  add.434 = f32[128]{0} add(call.425, call.433)
  compare.435 = pred[128]{0} compare(convert.196, broadcast.13), direction=EQ
  call.442 = f32[128]{0} call(compare.435, subtract.232, constant.62), to_apply=_where.436
  add.443 = f32[128]{0} add(add.434, call.442)
  compare.444 = pred[128]{0} compare(convert.196, broadcast.25), direction=EQ
  call.451 = f32[128]{0} call(compare.444, add.242, constant.62), to_apply=_where.445
  add.452 = f32[128]{0} add(add.443, call.451)
  compare.453 = pred[128]{0} compare(convert.196, broadcast.23), direction=EQ
  call.460 = f32[128]{0} call(compare.453, subtract.253, constant.62), to_apply=_where.454
  add.461 = f32[128]{0} add(add.452, call.460)
  compare.462 = pred[128]{0} compare(convert.196, broadcast.21), direction=EQ
  call.469 = f32[128]{0} call(compare.462, add.258, constant.62), to_apply=_where.463
  add.470 = f32[128]{0} add(add.461, call.469)
  reshape.656 = f32[128,1]{1,0} reshape(add.470)
  broadcast.658 = f32[128,1]{1,0} broadcast(reshape.656), dimensions={0,1}
  reshape.659 = f32[128]{0} reshape(broadcast.658)
  broadcast.660 = f32[128,128]{1,0} broadcast(reshape.659), dimensions={0}
  slice.657 = f32[128,128]{1,0} slice(call.635), slice={[0:128], [3:131]}
  multiply.661 = f32[128,128]{1,0} multiply(broadcast.660, slice.657)
  add.662 = f32[128,128]{1,0} add(add.655, multiply.661)
  constant.6 = s32[] constant(3)
  broadcast.7 = s32[128]{0} broadcast(constant.6), dimensions={}
  compare.471 = pred[128]{0} compare(convert.196, broadcast.7), direction=EQ
  call.478 = f32[128]{0} call(compare.471, subtract.209, constant.62), to_apply=_where.472
  compare.479 = pred[128]{0} compare(convert.196, broadcast.9), direction=EQ
  call.486 = f32[128]{0} call(compare.479, add.220, constant.62), to_apply=_where.480
  add.487 = f32[128]{0} add(call.478, call.486)
  compare.488 = pred[128]{0} compare(convert.196, broadcast.11), direction=EQ
  call.495 = f32[128]{0} call(compare.488, subtract.232, constant.62), to_apply=_where.489
  add.496 = f32[128]{0} add(add.487, call.495)
  compare.497 = pred[128]{0} compare(convert.196, broadcast.13), direction=EQ
  call.504 = f32[128]{0} call(compare.497, add.242, constant.62), to_apply=_where.498
  add.505 = f32[128]{0} add(add.496, call.504)
  compare.506 = pred[128]{0} compare(convert.196, broadcast.25), direction=EQ
  call.513 = f32[128]{0} call(compare.506, subtract.253, constant.62), to_apply=_where.507
  add.514 = f32[128]{0} add(add.505, call.513)
  compare.515 = pred[128]{0} compare(convert.196, broadcast.23), direction=EQ
  call.522 = f32[128]{0} call(compare.515, add.258, constant.62), to_apply=_where.516
  add.523 = f32[128]{0} add(add.514, call.522)
  reshape.663 = f32[128,1]{1,0} reshape(add.523)
  broadcast.665 = f32[128,1]{1,0} broadcast(reshape.663), dimensions={0,1}
  reshape.666 = f32[128]{0} reshape(broadcast.665)
  broadcast.667 = f32[128,128]{1,0} broadcast(reshape.666), dimensions={0}
  slice.664 = f32[128,128]{1,0} slice(call.635), slice={[0:128], [2:130]}
  multiply.668 = f32[128,128]{1,0} multiply(broadcast.667, slice.664)
  add.669 = f32[128,128]{1,0} add(add.662, multiply.668)
  constant.4 = s32[] constant(4)
  broadcast.5 = s32[128]{0} broadcast(constant.4), dimensions={}
  compare.524 = pred[128]{0} compare(convert.196, broadcast.5), direction=EQ
  call.531 = f32[128]{0} call(compare.524, subtract.209, constant.62), to_apply=_where.525
  compare.532 = pred[128]{0} compare(convert.196, broadcast.7), direction=EQ
  call.539 = f32[128]{0} call(compare.532, add.220, constant.62), to_apply=_where.533
  add.540 = f32[128]{0} add(call.531, call.539)
  compare.541 = pred[128]{0} compare(convert.196, broadcast.9), direction=EQ
  call.548 = f32[128]{0} call(compare.541, subtract.232, constant.62), to_apply=_where.542
  add.549 = f32[128]{0} add(add.540, call.548)
  compare.550 = pred[128]{0} compare(convert.196, broadcast.11), direction=EQ
  call.557 = f32[128]{0} call(compare.550, add.242, constant.62), to_apply=_where.551
  add.558 = f32[128]{0} add(add.549, call.557)
  compare.559 = pred[128]{0} compare(convert.196, broadcast.13), direction=EQ
  call.566 = f32[128]{0} call(compare.559, subtract.253, constant.62), to_apply=_where.560
  add.567 = f32[128]{0} add(add.558, call.566)
  compare.568 = pred[128]{0} compare(convert.196, broadcast.25), direction=EQ
  call.575 = f32[128]{0} call(compare.568, add.258, constant.62), to_apply=_where.569
  add.576 = f32[128]{0} add(add.567, call.575)
  reshape.670 = f32[128,1]{1,0} reshape(add.576)
  broadcast.672 = f32[128,1]{1,0} broadcast(reshape.670), dimensions={0,1}
  reshape.673 = f32[128]{0} reshape(broadcast.672)
  broadcast.674 = f32[128,128]{1,0} broadcast(reshape.673), dimensions={0}
  slice.671 = f32[128,128]{1,0} slice(call.635), slice={[0:128], [1:129]}
  multiply.675 = f32[128,128]{1,0} multiply(broadcast.674, slice.671)
  add.676 = f32[128,128]{1,0} add(add.669, multiply.675)
  constant.2 = s32[] constant(5)
  broadcast.3 = s32[128]{0} broadcast(constant.2), dimensions={}
  compare.577 = pred[128]{0} compare(convert.196, broadcast.3), direction=EQ
  call.584 = f32[128]{0} call(compare.577, subtract.209, constant.62), to_apply=_where.578
  compare.585 = pred[128]{0} compare(convert.196, broadcast.5), direction=EQ
  call.592 = f32[128]{0} call(compare.585, add.220, constant.62), to_apply=_where.586
  add.593 = f32[128]{0} add(call.584, call.592)
  compare.594 = pred[128]{0} compare(convert.196, broadcast.7), direction=EQ
  call.601 = f32[128]{0} call(compare.594, subtract.232, constant.62), to_apply=_where.595
  add.602 = f32[128]{0} add(add.593, call.601)
  compare.603 = pred[128]{0} compare(convert.196, broadcast.9), direction=EQ
  call.610 = f32[128]{0} call(compare.603, add.242, constant.62), to_apply=_where.604
  add.611 = f32[128]{0} add(add.602, call.610)
  compare.612 = pred[128]{0} compare(convert.196, broadcast.11), direction=EQ
  call.619 = f32[128]{0} call(compare.612, subtract.253, constant.62), to_apply=_where.613
  add.620 = f32[128]{0} add(add.611, call.619)
  compare.621 = pred[128]{0} compare(convert.196, broadcast.13), direction=EQ
  call.628 = f32[128]{0} call(compare.621, add.258, constant.62), to_apply=_where.622
  add.629 = f32[128]{0} add(add.620, call.628)
  reshape.677 = f32[128,1]{1,0} reshape(add.629)
  broadcast.679 = f32[128,1]{1,0} broadcast(reshape.677), dimensions={0,1}
  reshape.680 = f32[128]{0} reshape(broadcast.679)
  broadcast.681 = f32[128,128]{1,0} broadcast(reshape.680), dimensions={0}
  slice.678 = f32[128,128]{1,0} slice(call.635), slice={[0:128], [0:128]}
  multiply.682 = f32[128,128]{1,0} multiply(broadcast.681, slice.678)
  add.683 = f32[128,128]{1,0} add(add.676, multiply.682)
  slice.684 = f32[128,14]{1,0} slice(add.683), slice={[0:128], [0:14]}
  call.690 = f32[128,14]{1,0} call(slice.684), to_apply=_roll_static.685
  slice.691 = f32[128,50]{1,0} slice(add.683), slice={[0:128], [14:64]}
  call.697 = f32[128,50]{1,0} call(slice.691), to_apply=_roll_static_0.692
  slice.698 = f32[128,50]{1,0} slice(add.683), slice={[0:128], [64:114]}
  call.701 = f32[128,50]{1,0} call(slice.698), to_apply=_roll_static_1.699
  slice.702 = f32[128,14]{1,0} slice(add.683), slice={[0:128], [114:128]}
  call.708 = f32[128,14]{1,0} call(slice.702), to_apply=_roll_static_2.703
  concatenate.709 = f32[128,128]{1,0} concatenate(call.690, call.697, call.701, call.708), dimensions={1}
  call.715 = f32[128,128]{1,0} call(concatenate.709), to_apply=_roll_static_3.710
  broadcast.716 = f32[1,128]{1,0} broadcast(constant.59), dimensions={0,1}
  reshape.717 = f32[128]{0} reshape(broadcast.716)
  broadcast.718 = f32[128,128]{1,0} broadcast(reshape.717), dimensions={1}
  multiply.719 = f32[128,128]{1,0} multiply(call.715, broadcast.718)
  call.725 = f32[128,128]{1,0} call(concatenate.709), to_apply=_roll_static_4.720
  broadcast.726 = f32[1,128]{1,0} broadcast(constant.58), dimensions={0,1}
  reshape.727 = f32[128]{0} reshape(broadcast.726)
  broadcast.728 = f32[128,128]{1,0} broadcast(reshape.727), dimensions={1}
  multiply.729 = f32[128,128]{1,0} multiply(call.725, broadcast.728)
  add.730 = f32[128,128]{1,0} add(multiply.719, multiply.729)
  call.733 = f32[128,128]{1,0} call(concatenate.709), to_apply=_roll_static_5.731
  broadcast.734 = f32[1,128]{1,0} broadcast(constant.57), dimensions={0,1}
  reshape.735 = f32[128]{0} reshape(broadcast.734)
  broadcast.736 = f32[128,128]{1,0} broadcast(reshape.735), dimensions={1}
  multiply.737 = f32[128,128]{1,0} multiply(call.733, broadcast.736)
  add.738 = f32[128,128]{1,0} add(add.730, multiply.737)
  call.744 = f32[128,128]{1,0} call(concatenate.709), to_apply=_roll_static_6.739
  broadcast.745 = f32[1,128]{1,0} broadcast(constant.56), dimensions={0,1}
  reshape.746 = f32[128]{0} reshape(broadcast.745)
  broadcast.747 = f32[128,128]{1,0} broadcast(reshape.746), dimensions={1}
  multiply.748 = f32[128,128]{1,0} multiply(call.744, broadcast.747)
  add.749 = f32[128,128]{1,0} add(add.738, multiply.748)
  call.755 = f32[128,128]{1,0} call(concatenate.709), to_apply=_roll_static_7.750
  broadcast.756 = f32[1,128]{1,0} broadcast(constant.55), dimensions={0,1}
  reshape.757 = f32[128]{0} reshape(broadcast.756)
  broadcast.758 = f32[128,128]{1,0} broadcast(reshape.757), dimensions={1}
  multiply.759 = f32[128,128]{1,0} multiply(call.755, broadcast.758)
  add.760 = f32[128,128]{1,0} add(add.749, multiply.759)
  call.766 = f32[128,128]{1,0} call(concatenate.709), to_apply=_roll_static_8.761
  broadcast.767 = f32[1,128]{1,0} broadcast(constant.54), dimensions={0,1}
  reshape.768 = f32[128]{0} reshape(broadcast.767)
  broadcast.769 = f32[128,128]{1,0} broadcast(reshape.768), dimensions={1}
  multiply.770 = f32[128,128]{1,0} multiply(call.766, broadcast.769)
  add.771 = f32[128,128]{1,0} add(add.760, multiply.770)
  get-tuple-element.190 = f32[128]{0} get-tuple-element(call.188), index=1
  get-tuple-element.191 = f32[128]{0} get-tuple-element(call.188), index=2
  ROOT tuple.772 = (f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) tuple(add.771, get-tuple-element.190, get-tuple-element.191)
}

