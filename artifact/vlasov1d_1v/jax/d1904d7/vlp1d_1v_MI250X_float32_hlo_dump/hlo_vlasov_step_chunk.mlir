HloModule jit_run_chunk, entry_computation_layout={(f32[128]{0}, f32[128]{0}, f32[65]{0}, s32[6]{0}, f32[128]{0}, /*index=5*/f32[128]{0}, f32[128,128]{1,0}, f32[128]{0}, f32[], s32[])->(f32[128]{0}, f32[128]{0}, f32[65]{0}, s32[6]{0}, f32[128]{0}, /*index=5*/f32[128]{0}, f32[128,128]{1,0}, f32[128]{0}, f32[], s32[])}

_where.1 {
  Arg_0.4 = pred[] parameter(0)
  Arg_1.4 = s32[] parameter(1)
  Arg_2.3 = s32[] parameter(2)
  ROOT select_n.1 = s32[] select(Arg_0.4, Arg_1.4, Arg_2.3)
}

remainder.2 {
  Arg_0.5 = s32[128,128,6]{2,1,0} parameter(0)
  Arg_1.5 = s32[] parameter(1)
  constant.32 = s32[] constant(0)
  eq.1 = pred[] compare(Arg_1.5, constant.32), direction=EQ
  constant.31 = s32[] constant(1)
  jit__where_.1 = s32[] call(eq.1, constant.31, Arg_1.5), to_apply=_where.1
  rem.2 = s32[128,128,6]{2,1,0} broadcast(jit__where_.1), dimensions={}
  rem.3 = s32[128,128,6]{2,1,0} remainder(Arg_0.5, rem.2)
  constant.30 = s32[] constant(0)
  broadcast.10 = s32[128,128,6]{2,1,0} broadcast(constant.30), dimensions={}
  lt.3 = pred[128,128,6]{2,1,0} compare(rem.3, broadcast.10), direction=LT
  lt.4 = pred[] compare(jit__where_.1, constant.32), direction=LT
  ne.4 = pred[128,128,6]{2,1,0} broadcast(lt.4), dimensions={}
  ne.5 = pred[128,128,6]{2,1,0} compare(lt.3, ne.4), direction=NE
  ne.3 = pred[128,128,6]{2,1,0} compare(rem.3, broadcast.10), direction=NE
  and.1 = pred[128,128,6]{2,1,0} and(ne.5, ne.3)
  add.10 = s32[128,128,6]{2,1,0} broadcast(jit__where_.1), dimensions={}
  add.11 = s32[128,128,6]{2,1,0} add(rem.3, add.10)
  ROOT select_n.3 = s32[128,128,6]{2,1,0} select(and.1, add.11, rem.3)
}

advect_1d_vectorized.3 {
  iota.2 = f32[128]{0} iota(), iota_dimension=0
  broadcast_in_dim.7 = f32[1,128]{1,0} reshape(iota.2)
  sub.23 = f32[1,128]{1,0} broadcast(broadcast_in_dim.7), dimensions={0,1}
  sub.24 = f32[128]{0} reshape(sub.23)
  sub.25 = f32[128,128]{1,0} broadcast(sub.24), dimensions={1}
  Arg_1.6 = f32[128]{0} parameter(1)
  broadcast_in_dim.6 = f32[128,1]{1,0} reshape(Arg_1.6)
  Arg_2.4 = f32[] parameter(2)
  mul.21 = f32[128,1]{1,0} broadcast(Arg_2.4), dimensions={}
  mul.22 = f32[128,1]{1,0} multiply(broadcast_in_dim.6, mul.21)
  Arg_3.2 = f32[] parameter(3)
  div.33 = f32[128,1]{1,0} broadcast(Arg_3.2), dimensions={}
  div.34 = f32[128,1]{1,0} divide(mul.22, div.33)
  sub.26 = f32[128,1]{1,0} broadcast(div.34), dimensions={0,1}
  sub.27 = f32[128]{0} reshape(sub.26)
  sub.28 = f32[128,128]{1,0} broadcast(sub.27), dimensions={0}
  sub.29 = f32[128,128]{1,0} subtract(sub.25, sub.28)
  floor.1 = f32[128,128]{1,0} floor(sub.29)
  sub.30 = f32[128,128]{1,0} subtract(sub.29, floor.1)
  constant.44 = f32[] constant(20)
  div.32 = f32[128,128]{1,0} broadcast(constant.44), dimensions={}
  div.35 = f32[128,128]{1,0} divide(sub.30, div.32)
  mul.24 = f32[128,128]{1,0} multiply(sub.30, sub.30)
  constant.43 = f32[] constant(24)
  broadcast.19 = f32[128,128]{1,0} broadcast(constant.43), dimensions={}
  div.36 = f32[128,128]{1,0} divide(mul.24, broadcast.19)
  sub.31 = f32[128,128]{1,0} subtract(div.35, div.36)
  mul.25 = f32[128,128]{1,0} multiply(mul.24, sub.30)
  div.37 = f32[128,128]{1,0} divide(mul.25, broadcast.19)
  sub.32 = f32[128,128]{1,0} subtract(sub.31, div.37)
  mul.26 = f32[128,128]{1,0} multiply(mul.25, sub.30)
  div.38 = f32[128,128]{1,0} divide(mul.26, broadcast.19)
  add.45 = f32[128,128]{1,0} add(sub.32, div.38)
  mul.27 = f32[128,128]{1,0} multiply(mul.26, sub.30)
  constant.42 = f32[] constant(120)
  broadcast.18 = f32[128,128]{1,0} broadcast(constant.42), dimensions={}
  div.39 = f32[128,128]{1,0} divide(mul.27, broadcast.18)
  sub.33 = f32[128,128]{1,0} subtract(add.45, div.39)
  Arg_0.6 = f32[128,128]{1,0} parameter(0)
  reshape.3 = f32[16384]{0} reshape(Arg_0.6)
  iota.3 = s32[128]{0} iota(), iota_dimension=0
  broadcast_in_dim.10 = s32[128,1,1]{2,1,0} reshape(iota.3)
  constant.47 = s32[] constant(128)
  mul.20 = s32[128,1,1]{2,1,0} broadcast(constant.47), dimensions={}
  mul.23 = s32[128,1,1]{2,1,0} multiply(broadcast_in_dim.10, mul.20)
  add.40 = s32[128,1,1]{2,1,0} broadcast(mul.23), dimensions={0,1,2}
  add.41 = s32[128]{0} reshape(add.40)
  add.42 = s32[128,128,6]{2,1,0} broadcast(add.41), dimensions={0}
  convert_element_type.1 = s32[128,128]{1,0} convert(floor.1)
  broadcast_in_dim.8 = s32[128,128,1]{2,1,0} reshape(convert_element_type.1)
  add.33 = s32[128,128,1]{2,1,0} broadcast(broadcast_in_dim.8), dimensions={0,1,2}
  add.34 = s32[128,128]{1,0} reshape(add.33)
  add.35 = s32[128,128,6]{2,1,0} broadcast(add.34), dimensions={0,1}
  Arg_4.2 = s32[6]{0} parameter(4)
  broadcast_in_dim.9 = s32[1,1,6]{2,1,0} reshape(Arg_4.2)
  add.36 = s32[1,1,6]{2,1,0} broadcast(broadcast_in_dim.9), dimensions={0,1,2}
  add.37 = s32[6]{0} reshape(add.36)
  add.38 = s32[128,128,6]{2,1,0} broadcast(add.37), dimensions={2}
  add.39 = s32[128,128,6]{2,1,0} add(add.35, add.38)
  constant.48 = s32[] constant(128)
  jit_remainder_.1 = s32[128,128,6]{2,1,0} call(add.39, constant.48), to_apply=remainder.2
  add.43 = s32[128,128,6]{2,1,0} add(add.42, jit_remainder_.1)
  reshape.4 = s32[98304]{0} reshape(add.43)
  constant.46 = s32[] constant(0)
  lt.6 = s32[98304]{0} broadcast(constant.46), dimensions={}
  lt.7 = pred[98304]{0} compare(reshape.4, lt.6), direction=LT
  constant.45 = s32[] constant(16384)
  add.32 = s32[98304]{0} broadcast(constant.45), dimensions={}
  add.44 = s32[98304]{0} add(reshape.4, add.32)
  select_n.5 = s32[98304]{0} select(lt.7, add.44, reshape.4)
  broadcast_in_dim.11 = s32[98304,1]{1,0} reshape(select_n.5)
  gather.1 = f32[98304]{0} gather(reshape.3, broadcast_in_dim.11), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.5 = f32[128,128,6]{2,1,0} reshape(gather.1)
  slice.6 = f32[128,128,1]{2,1,0} slice(reshape.5), slice={[0:128], [0:128], [0:1]}
  squeeze.6 = f32[128,128]{1,0} reshape(slice.6)
  mul.34 = f32[128,128]{1,0} multiply(sub.33, squeeze.6)
  constant.41 = f32[] constant(2)
  broadcast.17 = f32[128,128]{1,0} broadcast(constant.41), dimensions={}
  div.40 = f32[128,128]{1,0} divide(sub.30, broadcast.17)
  neg.2 = f32[128,128]{1,0} negate(div.40)
  mul.28 = f32[128,128]{1,0} multiply(mul.24, broadcast.17)
  constant.40 = f32[] constant(3)
  broadcast.16 = f32[128,128]{1,0} broadcast(constant.40), dimensions={}
  div.41 = f32[128,128]{1,0} divide(mul.28, broadcast.16)
  add.46 = f32[128,128]{1,0} add(neg.2, div.41)
  div.42 = f32[128,128]{1,0} divide(mul.25, broadcast.19)
  sub.34 = f32[128,128]{1,0} subtract(add.46, div.42)
  constant.39 = f32[] constant(6)
  broadcast.15 = f32[128,128]{1,0} broadcast(constant.39), dimensions={}
  div.43 = f32[128,128]{1,0} divide(mul.26, broadcast.15)
  sub.35 = f32[128,128]{1,0} subtract(sub.34, div.43)
  div.44 = f32[128,128]{1,0} divide(mul.27, broadcast.19)
  add.47 = f32[128,128]{1,0} add(sub.35, div.44)
  slice.7 = f32[128,128,1]{2,1,0} slice(reshape.5), slice={[0:128], [0:128], [1:2]}
  squeeze.7 = f32[128,128]{1,0} reshape(slice.7)
  mul.35 = f32[128,128]{1,0} multiply(add.47, squeeze.7)
  add.55 = f32[128,128]{1,0} add(mul.34, mul.35)
  constant.38 = f32[] constant(1)
  sub.22 = f32[128,128]{1,0} broadcast(constant.38), dimensions={}
  div.45 = f32[128,128]{1,0} divide(sub.30, broadcast.16)
  sub.36 = f32[128,128]{1,0} subtract(sub.22, div.45)
  constant.37 = f32[] constant(5)
  broadcast.14 = f32[128,128]{1,0} broadcast(constant.37), dimensions={}
  mul.29 = f32[128,128]{1,0} multiply(mul.24, broadcast.14)
  constant.36 = f32[] constant(4)
  broadcast.13 = f32[128,128]{1,0} broadcast(constant.36), dimensions={}
  div.46 = f32[128,128]{1,0} divide(mul.29, broadcast.13)
  sub.37 = f32[128,128]{1,0} subtract(sub.36, div.46)
  mul.30 = f32[128,128]{1,0} multiply(mul.25, broadcast.14)
  constant.35 = f32[] constant(12)
  broadcast.12 = f32[128,128]{1,0} broadcast(constant.35), dimensions={}
  div.47 = f32[128,128]{1,0} divide(mul.30, broadcast.12)
  add.48 = f32[128,128]{1,0} add(sub.37, div.47)
  div.48 = f32[128,128]{1,0} divide(mul.26, broadcast.13)
  add.49 = f32[128,128]{1,0} add(add.48, div.48)
  div.49 = f32[128,128]{1,0} divide(mul.27, broadcast.12)
  sub.38 = f32[128,128]{1,0} subtract(add.49, div.49)
  slice.8 = f32[128,128,1]{2,1,0} slice(reshape.5), slice={[0:128], [0:128], [2:3]}
  squeeze.8 = f32[128,128]{1,0} reshape(slice.8)
  mul.36 = f32[128,128]{1,0} multiply(sub.38, squeeze.8)
  add.56 = f32[128,128]{1,0} add(add.55, mul.36)
  mul.31 = f32[128,128]{1,0} multiply(mul.24, broadcast.17)
  div.50 = f32[128,128]{1,0} divide(mul.31, broadcast.16)
  add.50 = f32[128,128]{1,0} add(sub.30, div.50)
  constant.34 = f32[] constant(7)
  broadcast.11 = f32[128,128]{1,0} broadcast(constant.34), dimensions={}
  mul.32 = f32[128,128]{1,0} multiply(mul.25, broadcast.11)
  div.51 = f32[128,128]{1,0} divide(mul.32, broadcast.12)
  sub.39 = f32[128,128]{1,0} subtract(add.50, div.51)
  div.52 = f32[128,128]{1,0} divide(mul.26, broadcast.15)
  sub.40 = f32[128,128]{1,0} subtract(sub.39, div.52)
  div.53 = f32[128,128]{1,0} divide(mul.27, broadcast.12)
  add.51 = f32[128,128]{1,0} add(sub.40, div.53)
  slice.9 = f32[128,128,1]{2,1,0} slice(reshape.5), slice={[0:128], [0:128], [3:4]}
  squeeze.9 = f32[128,128]{1,0} reshape(slice.9)
  mul.37 = f32[128,128]{1,0} multiply(add.51, squeeze.9)
  add.57 = f32[128,128]{1,0} add(add.56, mul.37)
  div.54 = f32[128,128]{1,0} divide(sub.30, broadcast.13)
  neg.3 = f32[128,128]{1,0} negate(div.54)
  div.55 = f32[128,128]{1,0} divide(mul.24, broadcast.19)
  sub.41 = f32[128,128]{1,0} subtract(neg.3, div.55)
  mul.33 = f32[128,128]{1,0} multiply(mul.25, broadcast.11)
  div.56 = f32[128,128]{1,0} divide(mul.33, broadcast.19)
  add.52 = f32[128,128]{1,0} add(sub.41, div.56)
  div.57 = f32[128,128]{1,0} divide(mul.26, broadcast.19)
  add.53 = f32[128,128]{1,0} add(add.52, div.57)
  div.58 = f32[128,128]{1,0} divide(mul.27, broadcast.19)
  sub.42 = f32[128,128]{1,0} subtract(add.53, div.58)
  slice.10 = f32[128,128,1]{2,1,0} slice(reshape.5), slice={[0:128], [0:128], [4:5]}
  squeeze.10 = f32[128,128]{1,0} reshape(slice.10)
  mul.38 = f32[128,128]{1,0} multiply(sub.42, squeeze.10)
  add.58 = f32[128,128]{1,0} add(add.57, mul.38)
  constant.33 = f32[] constant(30)
  div.31 = f32[128,128]{1,0} broadcast(constant.33), dimensions={}
  div.59 = f32[128,128]{1,0} divide(sub.30, div.31)
  div.60 = f32[128,128]{1,0} divide(mul.25, broadcast.19)
  sub.43 = f32[128,128]{1,0} subtract(div.59, div.60)
  div.61 = f32[128,128]{1,0} divide(mul.27, broadcast.18)
  add.54 = f32[128,128]{1,0} add(sub.43, div.61)
  slice.11 = f32[128,128,1]{2,1,0} slice(reshape.5), slice={[0:128], [0:128], [5:6]}
  squeeze.11 = f32[128,128]{1,0} reshape(slice.11)
  mul.39 = f32[128,128]{1,0} multiply(add.54, squeeze.11)
  ROOT add.59 = f32[128,128]{1,0} add(add.58, mul.39)
}

region_1.4 {
  reduce_sum.3 = f32[] parameter(0)
  reduce_sum.4 = f32[] parameter(1)
  ROOT reduce_sum.5 = f32[] add(reduce_sum.3, reduce_sum.4)
}

fft.5 {
  Arg_0.9 = f32[128]{0} parameter(0)
  ROOT fft.1 = c64[65]{0} fft(Arg_0.9), fft_type=RFFT, fft_length={128}
}

fft_37.6 {
  Arg_0.11 = c64[65]{0} parameter(0)
  ROOT fft.3 = f32[128]{0} fft(Arg_0.11), fft_type=IRFFT, fft_length={128}
}

solve_poisson.7 {
  Arg_0.12 = f32[128,128]{1,0} parameter(0)
  constant.54 = f32[] constant(0)
  reduce_sum.7 = f32[128]{0} reduce(Arg_0.12, constant.54), dimensions={1}, to_apply=region_1.4
  Arg_2.6 = f32[] parameter(2)
  mul.47 = f32[128]{0} broadcast(Arg_2.6), dimensions={}
  mul.48 = f32[128]{0} multiply(reduce_sum.7, mul.47)
  constant.53 = f32[] constant(1)
  sub.46 = f32[128]{0} broadcast(constant.53), dimensions={}
  sub.47 = f32[128]{0} subtract(mul.48, sub.46)
  jit_fft_.3 = c64[65]{0} call(sub.47), to_apply=fft.5
  constant.52 = c64[] constant((-0, -1))
  mul.46 = c64[65]{0} broadcast(constant.52), dimensions={}
  mul.49 = c64[65]{0} multiply(jit_fft_.3, mul.46)
  Arg_1.8 = f32[65]{0} parameter(1)
  convert_element_type.4 = c64[65]{0} convert(Arg_1.8)
  mul.50 = c64[65]{0} multiply(mul.49, convert_element_type.4)
  jit_fft_.4 = f32[128]{0} call(mul.50), to_apply=fft_37.6
  integer_pow.1 = f32[65]{0} multiply(Arg_1.8, Arg_1.8)
  convert_element_type.5 = c64[65]{0} convert(integer_pow.1)
  mul.51 = c64[65]{0} multiply(jit_fft_.3, convert_element_type.5)
  jit_fft_.5 = f32[128]{0} call(mul.51), to_apply=fft_37.6
  ROOT tuple.1 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) tuple(jit_fft_.4, sub.47, jit_fft_.5)
}

clip.8 {
  Arg_2.9 = s32[] parameter(2)
  min.2 = s32[128,128,6]{2,1,0} broadcast(Arg_2.9), dimensions={}
  Arg_1.11 = s32[] parameter(1)
  max.2 = s32[128,128,6]{2,1,0} broadcast(Arg_1.11), dimensions={}
  Arg_0.15 = s32[128,128,6]{2,1,0} parameter(0)
  max.3 = s32[128,128,6]{2,1,0} maximum(max.2, Arg_0.15)
  ROOT min.3 = s32[128,128,6]{2,1,0} minimum(min.2, max.3)
}

_where_40.9 {
  Arg_0.17 = pred[128,128,6]{2,1,0} parameter(0)
  Arg_1.13 = f32[128,128,6]{2,1,0} parameter(1)
  Arg_2.11 = f32[] parameter(2)
  broadcast_in_dim.19 = f32[128,128,6]{2,1,0} broadcast(Arg_2.11), dimensions={}
  ROOT select_n.8 = f32[128,128,6]{2,1,0} select(Arg_0.17, Arg_1.13, broadcast_in_dim.19)
}

advect_1d_vectorized_39.10 {
  iota.6 = f32[128]{0} iota(), iota_dimension=0
  broadcast_in_dim.21 = f32[1,128]{1,0} reshape(iota.6)
  sub.71 = f32[1,128]{1,0} broadcast(broadcast_in_dim.21), dimensions={0,1}
  sub.72 = f32[128]{0} reshape(sub.71)
  sub.73 = f32[128,128]{1,0} broadcast(sub.72), dimensions={1}
  Arg_1.14 = f32[128]{0} parameter(1)
  broadcast_in_dim.20 = f32[128,1]{1,0} reshape(Arg_1.14)
  Arg_2.12 = f32[] parameter(2)
  mul.73 = f32[128,1]{1,0} broadcast(Arg_2.12), dimensions={}
  mul.74 = f32[128,1]{1,0} multiply(broadcast_in_dim.20, mul.73)
  Arg_3.4 = f32[] parameter(3)
  div.95 = f32[128,1]{1,0} broadcast(Arg_3.4), dimensions={}
  div.96 = f32[128,1]{1,0} divide(mul.74, div.95)
  sub.74 = f32[128,1]{1,0} broadcast(div.96), dimensions={0,1}
  sub.75 = f32[128]{0} reshape(sub.74)
  sub.76 = f32[128,128]{1,0} broadcast(sub.75), dimensions={0}
  sub.77 = f32[128,128]{1,0} subtract(sub.73, sub.76)
  floor.3 = f32[128,128]{1,0} floor(sub.77)
  sub.78 = f32[128,128]{1,0} subtract(sub.77, floor.3)
  constant.86 = f32[] constant(20)
  div.94 = f32[128,128]{1,0} broadcast(constant.86), dimensions={}
  div.97 = f32[128,128]{1,0} divide(sub.78, div.94)
  mul.76 = f32[128,128]{1,0} multiply(sub.78, sub.78)
  constant.85 = f32[] constant(24)
  broadcast.37 = f32[128,128]{1,0} broadcast(constant.85), dimensions={}
  div.98 = f32[128,128]{1,0} divide(mul.76, broadcast.37)
  sub.79 = f32[128,128]{1,0} subtract(div.97, div.98)
  mul.77 = f32[128,128]{1,0} multiply(mul.76, sub.78)
  div.99 = f32[128,128]{1,0} divide(mul.77, broadcast.37)
  sub.80 = f32[128,128]{1,0} subtract(sub.79, div.99)
  mul.78 = f32[128,128]{1,0} multiply(mul.77, sub.78)
  div.100 = f32[128,128]{1,0} divide(mul.78, broadcast.37)
  add.101 = f32[128,128]{1,0} add(sub.80, div.100)
  mul.79 = f32[128,128]{1,0} multiply(mul.78, sub.78)
  constant.84 = f32[] constant(120)
  broadcast.36 = f32[128,128]{1,0} broadcast(constant.84), dimensions={}
  div.101 = f32[128,128]{1,0} divide(mul.79, broadcast.36)
  sub.81 = f32[128,128]{1,0} subtract(add.101, div.101)
  convert_element_type.7 = s32[128,128]{1,0} convert(floor.3)
  broadcast_in_dim.22 = s32[128,128,1]{2,1,0} reshape(convert_element_type.7)
  add.89 = s32[128,128,1]{2,1,0} broadcast(broadcast_in_dim.22), dimensions={0,1,2}
  add.90 = s32[128,128]{1,0} reshape(add.89)
  add.91 = s32[128,128,6]{2,1,0} broadcast(add.90), dimensions={0,1}
  Arg_4.4 = s32[6]{0} parameter(4)
  broadcast_in_dim.23 = s32[1,1,6]{2,1,0} reshape(Arg_4.4)
  add.92 = s32[1,1,6]{2,1,0} broadcast(broadcast_in_dim.23), dimensions={0,1,2}
  add.93 = s32[6]{0} reshape(add.92)
  add.94 = s32[128,128,6]{2,1,0} broadcast(add.93), dimensions={2}
  add.95 = s32[128,128,6]{2,1,0} add(add.91, add.94)
  constant.91 = s32[] constant(0)
  ge.2 = s32[128,128,6]{2,1,0} broadcast(constant.91), dimensions={}
  ge.3 = pred[128,128,6]{2,1,0} compare(add.95, ge.2), direction=GE
  constant.90 = s32[] constant(128)
  lt.13 = s32[128,128,6]{2,1,0} broadcast(constant.90), dimensions={}
  lt.14 = pred[128,128,6]{2,1,0} compare(add.95, lt.13), direction=LT
  and.3 = pred[128,128,6]{2,1,0} and(ge.3, lt.14)
  Arg_0.18 = f32[128,128]{1,0} parameter(0)
  reshape.9 = f32[16384]{0} reshape(Arg_0.18)
  iota.7 = s32[128]{0} iota(), iota_dimension=0
  broadcast_in_dim.24 = s32[128,1,1]{2,1,0} reshape(iota.7)
  constant.89 = s32[] constant(128)
  mul.72 = s32[128,1,1]{2,1,0} broadcast(constant.89), dimensions={}
  mul.75 = s32[128,1,1]{2,1,0} multiply(broadcast_in_dim.24, mul.72)
  add.96 = s32[128,1,1]{2,1,0} broadcast(mul.75), dimensions={0,1,2}
  add.97 = s32[128]{0} reshape(add.96)
  add.98 = s32[128,128,6]{2,1,0} broadcast(add.97), dimensions={0}
  constant.94 = s32[] constant(0)
  constant.93 = s32[] constant(127)
  jit_clip_.1 = s32[128,128,6]{2,1,0} call(add.95, constant.94, constant.93), to_apply=clip.8
  add.99 = s32[128,128,6]{2,1,0} add(add.98, jit_clip_.1)
  reshape.10 = s32[98304]{0} reshape(add.99)
  constant.88 = s32[] constant(0)
  lt.12 = s32[98304]{0} broadcast(constant.88), dimensions={}
  lt.15 = pred[98304]{0} compare(reshape.10, lt.12), direction=LT
  constant.87 = s32[] constant(16384)
  add.88 = s32[98304]{0} broadcast(constant.87), dimensions={}
  add.100 = s32[98304]{0} add(reshape.10, add.88)
  select_n.9 = s32[98304]{0} select(lt.15, add.100, reshape.10)
  broadcast_in_dim.25 = s32[98304,1]{1,0} reshape(select_n.9)
  gather.3 = f32[98304]{0} gather(reshape.9, broadcast_in_dim.25), offset_dims={}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1}
  reshape.11 = f32[128,128,6]{2,1,0} reshape(gather.3)
  constant.92 = f32[] constant(0)
  jit__where_.3 = f32[128,128,6]{2,1,0} call(and.3, reshape.11, constant.92), to_apply=_where_40.9
  slice.18 = f32[128,128,1]{2,1,0} slice(jit__where_.3), slice={[0:128], [0:128], [0:1]}
  squeeze.18 = f32[128,128]{1,0} reshape(slice.18)
  mul.86 = f32[128,128]{1,0} multiply(sub.81, squeeze.18)
  constant.83 = f32[] constant(2)
  broadcast.35 = f32[128,128]{1,0} broadcast(constant.83), dimensions={}
  div.102 = f32[128,128]{1,0} divide(sub.78, broadcast.35)
  neg.6 = f32[128,128]{1,0} negate(div.102)
  mul.80 = f32[128,128]{1,0} multiply(mul.76, broadcast.35)
  constant.82 = f32[] constant(3)
  broadcast.34 = f32[128,128]{1,0} broadcast(constant.82), dimensions={}
  div.103 = f32[128,128]{1,0} divide(mul.80, broadcast.34)
  add.102 = f32[128,128]{1,0} add(neg.6, div.103)
  div.104 = f32[128,128]{1,0} divide(mul.77, broadcast.37)
  sub.82 = f32[128,128]{1,0} subtract(add.102, div.104)
  constant.81 = f32[] constant(6)
  broadcast.33 = f32[128,128]{1,0} broadcast(constant.81), dimensions={}
  div.105 = f32[128,128]{1,0} divide(mul.78, broadcast.33)
  sub.83 = f32[128,128]{1,0} subtract(sub.82, div.105)
  div.106 = f32[128,128]{1,0} divide(mul.79, broadcast.37)
  add.103 = f32[128,128]{1,0} add(sub.83, div.106)
  slice.19 = f32[128,128,1]{2,1,0} slice(jit__where_.3), slice={[0:128], [0:128], [1:2]}
  squeeze.19 = f32[128,128]{1,0} reshape(slice.19)
  mul.87 = f32[128,128]{1,0} multiply(add.103, squeeze.19)
  add.111 = f32[128,128]{1,0} add(mul.86, mul.87)
  constant.80 = f32[] constant(1)
  sub.70 = f32[128,128]{1,0} broadcast(constant.80), dimensions={}
  div.107 = f32[128,128]{1,0} divide(sub.78, broadcast.34)
  sub.84 = f32[128,128]{1,0} subtract(sub.70, div.107)
  constant.79 = f32[] constant(5)
  broadcast.32 = f32[128,128]{1,0} broadcast(constant.79), dimensions={}
  mul.81 = f32[128,128]{1,0} multiply(mul.76, broadcast.32)
  constant.78 = f32[] constant(4)
  broadcast.31 = f32[128,128]{1,0} broadcast(constant.78), dimensions={}
  div.108 = f32[128,128]{1,0} divide(mul.81, broadcast.31)
  sub.85 = f32[128,128]{1,0} subtract(sub.84, div.108)
  mul.82 = f32[128,128]{1,0} multiply(mul.77, broadcast.32)
  constant.77 = f32[] constant(12)
  broadcast.30 = f32[128,128]{1,0} broadcast(constant.77), dimensions={}
  div.109 = f32[128,128]{1,0} divide(mul.82, broadcast.30)
  add.104 = f32[128,128]{1,0} add(sub.85, div.109)
  div.110 = f32[128,128]{1,0} divide(mul.78, broadcast.31)
  add.105 = f32[128,128]{1,0} add(add.104, div.110)
  div.111 = f32[128,128]{1,0} divide(mul.79, broadcast.30)
  sub.86 = f32[128,128]{1,0} subtract(add.105, div.111)
  slice.20 = f32[128,128,1]{2,1,0} slice(jit__where_.3), slice={[0:128], [0:128], [2:3]}
  squeeze.20 = f32[128,128]{1,0} reshape(slice.20)
  mul.88 = f32[128,128]{1,0} multiply(sub.86, squeeze.20)
  add.112 = f32[128,128]{1,0} add(add.111, mul.88)
  mul.83 = f32[128,128]{1,0} multiply(mul.76, broadcast.35)
  div.112 = f32[128,128]{1,0} divide(mul.83, broadcast.34)
  add.106 = f32[128,128]{1,0} add(sub.78, div.112)
  constant.76 = f32[] constant(7)
  broadcast.29 = f32[128,128]{1,0} broadcast(constant.76), dimensions={}
  mul.84 = f32[128,128]{1,0} multiply(mul.77, broadcast.29)
  div.113 = f32[128,128]{1,0} divide(mul.84, broadcast.30)
  sub.87 = f32[128,128]{1,0} subtract(add.106, div.113)
  div.114 = f32[128,128]{1,0} divide(mul.78, broadcast.33)
  sub.88 = f32[128,128]{1,0} subtract(sub.87, div.114)
  div.115 = f32[128,128]{1,0} divide(mul.79, broadcast.30)
  add.107 = f32[128,128]{1,0} add(sub.88, div.115)
  slice.21 = f32[128,128,1]{2,1,0} slice(jit__where_.3), slice={[0:128], [0:128], [3:4]}
  squeeze.21 = f32[128,128]{1,0} reshape(slice.21)
  mul.89 = f32[128,128]{1,0} multiply(add.107, squeeze.21)
  add.113 = f32[128,128]{1,0} add(add.112, mul.89)
  div.116 = f32[128,128]{1,0} divide(sub.78, broadcast.31)
  neg.7 = f32[128,128]{1,0} negate(div.116)
  div.117 = f32[128,128]{1,0} divide(mul.76, broadcast.37)
  sub.89 = f32[128,128]{1,0} subtract(neg.7, div.117)
  mul.85 = f32[128,128]{1,0} multiply(mul.77, broadcast.29)
  div.118 = f32[128,128]{1,0} divide(mul.85, broadcast.37)
  add.108 = f32[128,128]{1,0} add(sub.89, div.118)
  div.119 = f32[128,128]{1,0} divide(mul.78, broadcast.37)
  add.109 = f32[128,128]{1,0} add(add.108, div.119)
  div.120 = f32[128,128]{1,0} divide(mul.79, broadcast.37)
  sub.90 = f32[128,128]{1,0} subtract(add.109, div.120)
  slice.22 = f32[128,128,1]{2,1,0} slice(jit__where_.3), slice={[0:128], [0:128], [4:5]}
  squeeze.22 = f32[128,128]{1,0} reshape(slice.22)
  mul.90 = f32[128,128]{1,0} multiply(sub.90, squeeze.22)
  add.114 = f32[128,128]{1,0} add(add.113, mul.90)
  constant.75 = f32[] constant(30)
  div.93 = f32[128,128]{1,0} broadcast(constant.75), dimensions={}
  div.121 = f32[128,128]{1,0} divide(sub.78, div.93)
  div.122 = f32[128,128]{1,0} divide(mul.77, broadcast.37)
  sub.91 = f32[128,128]{1,0} subtract(div.121, div.122)
  div.123 = f32[128,128]{1,0} divide(mul.79, broadcast.36)
  add.110 = f32[128,128]{1,0} add(sub.91, div.123)
  slice.23 = f32[128,128,1]{2,1,0} slice(jit__where_.3), slice={[0:128], [0:128], [5:6]}
  squeeze.23 = f32[128,128]{1,0} reshape(slice.23)
  mul.91 = f32[128,128]{1,0} multiply(add.110, squeeze.23)
  ROOT add.115 = f32[128,128]{1,0} add(add.114, mul.91)
}

closed_call.11 {
  Arg_4.5 = f32[128]{0} parameter(4)
  Arg_5.1 = f32[128]{0} parameter(5)
  Arg_3.5 = f32[128,128]{1,0} parameter(3)
  transpose.4 = f32[128,128]{0,1} transpose(Arg_3.5), dimensions={1,0}
  Arg_0.19 = f32[128]{0} parameter(0)
  constant.98 = f32[] constant(0.025)
  constant.97 = f32[] constant(0.0981747732)
  Arg_1.15 = s32[6]{0} parameter(1)
  jit_advect_1d_vectorized_.3 = f32[128,128]{1,0} call(transpose.4, Arg_0.19, constant.98, constant.97, Arg_1.15), to_apply=advect_1d_vectorized.3
  transpose.5 = f32[128,128]{0,1} transpose(jit_advect_1d_vectorized_.3), dimensions={1,0}
  Arg_2.13 = f32[65]{0} parameter(2)
  constant.96 = f32[] constant(0.0787401572)
  jit_solve_poisson_.4 = (f32[128]{0}, f32[128]{0}, f32[128]{0}) call(transpose.5, Arg_2.13, constant.96), to_apply=solve_poisson.7
  jit_solve_poisson_.5 = f32[128]{0} get-tuple-element(jit_solve_poisson_.4), index=0
  constant.95 = f32[] constant(0.05)
  jit_advect_1d_vectorized_.4 = f32[128,128]{1,0} call(transpose.5, jit_solve_poisson_.5, constant.95, constant.96, Arg_1.15), to_apply=advect_1d_vectorized_39.10
  transpose.6 = f32[128,128]{0,1} transpose(jit_advect_1d_vectorized_.4), dimensions={1,0}
  jit_advect_1d_vectorized_.5 = f32[128,128]{1,0} call(transpose.6, Arg_0.19, constant.98, constant.97, Arg_1.15), to_apply=advect_1d_vectorized.3
  transpose.7 = f32[128,128]{0,1} transpose(jit_advect_1d_vectorized_.5), dimensions={1,0}
  jit_solve_poisson_.6 = f32[128]{0} get-tuple-element(jit_solve_poisson_.4), index=1
  jit_solve_poisson_.7 = f32[128]{0} get-tuple-element(jit_solve_poisson_.4), index=2
  ROOT tuple.3 = (f32[128,128]{0,1}, f32[128]{0}, f32[128]{0}) tuple(transpose.7, jit_solve_poisson_.6, jit_solve_poisson_.7)
}

region_0.12 {
  arg_tuple.1 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) parameter(0)
  get-tuple-element.4 = s32[] get-tuple-element(arg_tuple.1), index=0
  constant.99 = s32[] constant(1)
  add.117 = s32[] add(get-tuple-element.4, constant.99)
  constant.102 = f32[128]{0} constant({...})
  constant.101 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  constant.100 = f32[65]{0} constant({...})
  get-tuple-element.5 = f32[128,128]{1,0} get-tuple-element(arg_tuple.1), index=1
  get-tuple-element.6 = f32[128]{0} get-tuple-element(arg_tuple.1), index=2
  get-tuple-element.7 = f32[128]{0} get-tuple-element(arg_tuple.1), index=3
  closed_call.4 = (f32[128,128]{0,1}, f32[128]{0}, f32[128]{0}) call(constant.102, constant.101, constant.100, get-tuple-element.5, get-tuple-element.6, get-tuple-element.7), to_apply=closed_call.11
  closed_call.5 = f32[128,128]{0,1} get-tuple-element(closed_call.4), index=0
  closed_call.6 = f32[128]{0} get-tuple-element(closed_call.4), index=1
  closed_call.7 = f32[128]{0} get-tuple-element(closed_call.4), index=2
  ROOT tuple.5 = (s32[], f32[128,128]{0,1}, f32[128]{0}, f32[128]{0}) tuple(add.117, closed_call.5, closed_call.6, closed_call.7)
}

region_2.13 {
  arg_tuple.3 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) parameter(0)
  get-tuple-element.13 = f32[128,128]{1,0} get-tuple-element(arg_tuple.3), index=1
  get-tuple-element.14 = f32[128]{0} get-tuple-element(arg_tuple.3), index=2
  get-tuple-element.15 = f32[128]{0} get-tuple-element(arg_tuple.3), index=3
  get-tuple-element.12 = s32[] get-tuple-element(arg_tuple.3), index=0
  constant.104 = s32[] constant(1000)
  ROOT lt.17 = pred[] compare(get-tuple-element.12, constant.104), direction=LT
}

ENTRY main.14 {
  constant.107 = s32[] constant(0)
  start_state_2__0_.1 = f32[128,128]{1,0} parameter(6)
  start_state_1__0_.1 = f32[128]{0} parameter(4)
  start_state_1__1_.1 = f32[128]{0} parameter(5)
  while.6 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) tuple(constant.107, start_state_2__0_.1, start_state_1__0_.1, start_state_1__1_.1)
  while.7 = (s32[], f32[128,128]{1,0}, f32[128]{0}, f32[128]{0}) while(while.6), condition=region_2.13, body=region_0.12
  while.8 = s32[] get-tuple-element(while.7), index=0
  start_state_0__0_.1 = f32[128]{0} parameter(0)
  start_state_0__1_.1 = f32[128]{0} parameter(1)
  start_state_0__2_.1 = f32[65]{0} parameter(2)
  start_state_0__3_.1 = s32[6]{0} parameter(3)
  while.10 = f32[128]{0} get-tuple-element(while.7), index=2
  while.11 = f32[128]{0} get-tuple-element(while.7), index=3
  while.9 = f32[128,128]{1,0} get-tuple-element(while.7), index=1
  start_state_2__1_.1 = f32[128]{0} parameter(7)
  start_state_3_.1 = f32[] parameter(8)
  constant.105 = f32[] constant(50)
  add.120 = f32[] add(start_state_3_.1, constant.105)
  start_state_4_.1 = s32[] parameter(9)
  constant.106 = s32[] constant(1000)
  add.121 = s32[] add(start_state_4_.1, constant.106)
  ROOT tuple.7 = (f32[128]{0}, f32[128]{0}, f32[65]{0}, s32[6]{0}, f32[128]{0}, /*index=5*/f32[128]{0}, f32[128,128]{1,0}, f32[128]{0}, f32[], s32[]) tuple(start_state_0__0_.1, start_state_0__1_.1, start_state_0__2_.1, start_state_0__3_.1, while.10, while.11, while.9, start_state_2__1_.1, add.120, add.121)
}

