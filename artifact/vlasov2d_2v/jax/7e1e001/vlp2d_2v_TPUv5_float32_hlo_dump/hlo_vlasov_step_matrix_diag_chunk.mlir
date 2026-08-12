HloModule jit_run_chunk, entry_computation_layout={(f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[], /*index=5*/s32[])->(f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,1]{1,0}, /*index=5*/f32[1,17]{1,0}, f32[32,17]{1,0}, s32[6]{0}, f32[32,32]{1,0}, f32[32,32]{1,0}, /*index=10*/f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[], s32[])}

_where.1 {
  Arg_0.5 = pred[] parameter(0)
  Arg_1.5 = s32[] parameter(1)
  Arg_2.3 = s32[] parameter(2)
  ROOT select_n.1 = s32[] select(Arg_0.5, Arg_1.5, Arg_2.3)
}

remainder.2 {
  Arg_0.6 = s32[32768]{0} parameter(0)
  Arg_1.6 = s32[] parameter(1)
  constant.40 = s32[] constant(0)
  eq.1 = pred[] compare(Arg_1.6, constant.40), direction=EQ
  constant.39 = s32[] constant(1)
  jit__where_.1 = s32[] call(eq.1, constant.39, Arg_1.6), to_apply=_where.1
  rem.2 = s32[32768]{0} broadcast(jit__where_.1), dimensions={}
  rem.3 = s32[32768]{0} remainder(Arg_0.6, rem.2)
  constant.38 = s32[] constant(0)
  broadcast.10 = s32[32768]{0} broadcast(constant.38), dimensions={}
  lt.3 = pred[32768]{0} compare(rem.3, broadcast.10), direction=LT
  lt.4 = pred[] compare(jit__where_.1, constant.40), direction=LT
  ne.4 = pred[32768]{0} broadcast(lt.4), dimensions={}
  ne.5 = pred[32768]{0} compare(lt.3, ne.4), direction=NE
  ne.3 = pred[32768]{0} compare(rem.3, broadcast.10), direction=NE
  and.1 = pred[32768]{0} and(ne.5, ne.3)
  add.15 = s32[32768]{0} broadcast(jit__where_.1), dimensions={}
  add.16 = s32[32768]{0} add(rem.3, add.15)
  ROOT select_n.3 = s32[32768]{0} select(and.1, add.16, rem.3)
}

_roll_dynamic.3 {
  Arg_0.7 = f32[32768,32]{1,0} parameter(0)
  concatenate.1 = f32[32768,64]{1,0} concatenate(Arg_0.7, Arg_0.7), dimensions={1}
  constant.43 = s32[] constant(32)
  sub.17 = s32[32768]{0} broadcast(constant.43), dimensions={}
  Arg_1.7 = s32[32768]{0} parameter(1)
  constant.44 = s32[] constant(32)
  jit_remainder_.1 = s32[32768]{0} call(Arg_1.7, constant.44), to_apply=remainder.2
  sub.18 = s32[32768]{0} subtract(sub.17, jit_remainder_.1)
  constant.42 = s32[] constant(0)
  lt.6 = s32[32768]{0} broadcast(constant.42), dimensions={}
  lt.7 = pred[32768]{0} compare(sub.18, lt.6), direction=LT
  constant.41 = s32[] constant(64)
  add.18 = s32[32768]{0} broadcast(constant.41), dimensions={}
  add.19 = s32[32768]{0} add(sub.18, add.18)
  select_n.5 = s32[32768]{0} select(lt.7, add.19, sub.18)
  broadcast_in_dim.5 = s32[32768,1]{1,0} reshape(select_n.5)
  ROOT gather.1 = f32[32768,32]{1,0} gather(concatenate.1, broadcast_in_dim.5), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,32}, indices_are_sorted=true
}

advect_1d_roll_diag.4 {
  Arg_0.8 = f32[32768,32]{1,0} parameter(0)
  Arg_1.8 = f32[32768]{0} parameter(1)
  Arg_2.4 = f32[] parameter(2)
  mul.36 = f32[32768]{0} broadcast(Arg_2.4), dimensions={}
  mul.37 = f32[32768]{0} multiply(Arg_1.8, mul.36)
  Arg_3.2 = f32[] parameter(3)
  div.33 = f32[32768]{0} broadcast(Arg_3.2), dimensions={}
  div.34 = f32[32768]{0} divide(mul.37, div.33)
  floor.1 = f32[32768]{0} floor(div.34)
  convert_element_type.1 = s32[32768]{0} convert(floor.1)
  Arg_4.2 = s32[6]{0} parameter(4)
  slice.6 = s32[1]{0} slice(Arg_4.2), slice={[0:1]}
  squeeze.6 = s32[] reshape(slice.6)
  add.45 = s32[32768]{0} broadcast(squeeze.6), dimensions={}
  add.46 = s32[32768]{0} add(convert_element_type.1, add.45)
  vmap_jit__roll_dynamic__.6 = f32[32768,32]{1,0} call(Arg_0.8, add.46), to_apply=_roll_dynamic.3
  sub.20 = f32[32768]{0} subtract(div.34, floor.1)
  constant.56 = f32[] constant(20)
  div.32 = f32[32768]{0} broadcast(constant.56), dimensions={}
  div.35 = f32[32768]{0} divide(sub.20, div.32)
  mul.38 = f32[32768]{0} multiply(sub.20, sub.20)
  constant.55 = f32[] constant(24)
  broadcast.19 = f32[32768]{0} broadcast(constant.55), dimensions={}
  div.36 = f32[32768]{0} divide(mul.38, broadcast.19)
  sub.21 = f32[32768]{0} subtract(div.35, div.36)
  mul.39 = f32[32768]{0} multiply(mul.38, sub.20)
  div.37 = f32[32768]{0} divide(mul.39, broadcast.19)
  sub.22 = f32[32768]{0} subtract(sub.21, div.37)
  mul.40 = f32[32768]{0} multiply(mul.39, sub.20)
  div.38 = f32[32768]{0} divide(mul.40, broadcast.19)
  add.35 = f32[32768]{0} add(sub.22, div.38)
  mul.41 = f32[32768]{0} multiply(mul.40, sub.20)
  constant.54 = f32[] constant(120)
  broadcast.18 = f32[32768]{0} broadcast(constant.54), dimensions={}
  div.39 = f32[32768]{0} divide(mul.41, broadcast.18)
  sub.23 = f32[32768]{0} subtract(add.35, div.39)
  broadcast_in_dim.12 = f32[32768,1]{1,0} reshape(sub.23)
  mul.48 = f32[32768,1]{1,0} broadcast(broadcast_in_dim.12), dimensions={0,1}
  mul.49 = f32[32768]{0} reshape(mul.48)
  mul.50 = f32[32768,32]{1,0} broadcast(mul.49), dimensions={0}
  mul.51 = f32[32768,32]{1,0} multiply(vmap_jit__roll_dynamic__.6, mul.50)
  slice.7 = s32[1]{0} slice(Arg_4.2), slice={[1:2]}
  squeeze.7 = s32[] reshape(slice.7)
  add.47 = s32[32768]{0} broadcast(squeeze.7), dimensions={}
  add.48 = s32[32768]{0} add(convert_element_type.1, add.47)
  vmap_jit__roll_dynamic__.7 = f32[32768,32]{1,0} call(Arg_0.8, add.48), to_apply=_roll_dynamic.3
  constant.53 = f32[] constant(2)
  broadcast.17 = f32[32768]{0} broadcast(constant.53), dimensions={}
  div.40 = f32[32768]{0} divide(sub.20, broadcast.17)
  neg.2 = f32[32768]{0} negate(div.40)
  mul.42 = f32[32768]{0} multiply(mul.38, broadcast.17)
  constant.52 = f32[] constant(3)
  broadcast.16 = f32[32768]{0} broadcast(constant.52), dimensions={}
  div.41 = f32[32768]{0} divide(mul.42, broadcast.16)
  add.36 = f32[32768]{0} add(neg.2, div.41)
  div.42 = f32[32768]{0} divide(mul.39, broadcast.19)
  sub.24 = f32[32768]{0} subtract(add.36, div.42)
  constant.51 = f32[] constant(6)
  broadcast.15 = f32[32768]{0} broadcast(constant.51), dimensions={}
  div.43 = f32[32768]{0} divide(mul.40, broadcast.15)
  sub.25 = f32[32768]{0} subtract(sub.24, div.43)
  div.44 = f32[32768]{0} divide(mul.41, broadcast.19)
  add.37 = f32[32768]{0} add(sub.25, div.44)
  broadcast_in_dim.13 = f32[32768,1]{1,0} reshape(add.37)
  mul.52 = f32[32768,1]{1,0} broadcast(broadcast_in_dim.13), dimensions={0,1}
  mul.53 = f32[32768]{0} reshape(mul.52)
  mul.54 = f32[32768,32]{1,0} broadcast(mul.53), dimensions={0}
  mul.55 = f32[32768,32]{1,0} multiply(vmap_jit__roll_dynamic__.7, mul.54)
  add.49 = f32[32768,32]{1,0} add(mul.51, mul.55)
  slice.8 = s32[1]{0} slice(Arg_4.2), slice={[2:3]}
  squeeze.8 = s32[] reshape(slice.8)
  add.50 = s32[32768]{0} broadcast(squeeze.8), dimensions={}
  add.51 = s32[32768]{0} add(convert_element_type.1, add.50)
  vmap_jit__roll_dynamic__.8 = f32[32768,32]{1,0} call(Arg_0.8, add.51), to_apply=_roll_dynamic.3
  constant.50 = f32[] constant(1)
  sub.19 = f32[32768]{0} broadcast(constant.50), dimensions={}
  div.45 = f32[32768]{0} divide(sub.20, broadcast.16)
  sub.26 = f32[32768]{0} subtract(sub.19, div.45)
  constant.49 = f32[] constant(5)
  broadcast.14 = f32[32768]{0} broadcast(constant.49), dimensions={}
  mul.43 = f32[32768]{0} multiply(mul.38, broadcast.14)
  constant.48 = f32[] constant(4)
  broadcast.13 = f32[32768]{0} broadcast(constant.48), dimensions={}
  div.46 = f32[32768]{0} divide(mul.43, broadcast.13)
  sub.27 = f32[32768]{0} subtract(sub.26, div.46)
  mul.44 = f32[32768]{0} multiply(mul.39, broadcast.14)
  constant.47 = f32[] constant(12)
  broadcast.12 = f32[32768]{0} broadcast(constant.47), dimensions={}
  div.47 = f32[32768]{0} divide(mul.44, broadcast.12)
  add.38 = f32[32768]{0} add(sub.27, div.47)
  div.48 = f32[32768]{0} divide(mul.40, broadcast.13)
  add.39 = f32[32768]{0} add(add.38, div.48)
  div.49 = f32[32768]{0} divide(mul.41, broadcast.12)
  sub.28 = f32[32768]{0} subtract(add.39, div.49)
  broadcast_in_dim.14 = f32[32768,1]{1,0} reshape(sub.28)
  mul.56 = f32[32768,1]{1,0} broadcast(broadcast_in_dim.14), dimensions={0,1}
  mul.57 = f32[32768]{0} reshape(mul.56)
  mul.58 = f32[32768,32]{1,0} broadcast(mul.57), dimensions={0}
  mul.59 = f32[32768,32]{1,0} multiply(vmap_jit__roll_dynamic__.8, mul.58)
  add.52 = f32[32768,32]{1,0} add(add.49, mul.59)
  slice.9 = s32[1]{0} slice(Arg_4.2), slice={[3:4]}
  squeeze.9 = s32[] reshape(slice.9)
  add.53 = s32[32768]{0} broadcast(squeeze.9), dimensions={}
  add.54 = s32[32768]{0} add(convert_element_type.1, add.53)
  vmap_jit__roll_dynamic__.9 = f32[32768,32]{1,0} call(Arg_0.8, add.54), to_apply=_roll_dynamic.3
  mul.45 = f32[32768]{0} multiply(mul.38, broadcast.17)
  div.50 = f32[32768]{0} divide(mul.45, broadcast.16)
  add.40 = f32[32768]{0} add(sub.20, div.50)
  constant.46 = f32[] constant(7)
  broadcast.11 = f32[32768]{0} broadcast(constant.46), dimensions={}
  mul.46 = f32[32768]{0} multiply(mul.39, broadcast.11)
  div.51 = f32[32768]{0} divide(mul.46, broadcast.12)
  sub.29 = f32[32768]{0} subtract(add.40, div.51)
  div.52 = f32[32768]{0} divide(mul.40, broadcast.15)
  sub.30 = f32[32768]{0} subtract(sub.29, div.52)
  div.53 = f32[32768]{0} divide(mul.41, broadcast.12)
  add.41 = f32[32768]{0} add(sub.30, div.53)
  broadcast_in_dim.15 = f32[32768,1]{1,0} reshape(add.41)
  mul.60 = f32[32768,1]{1,0} broadcast(broadcast_in_dim.15), dimensions={0,1}
  mul.61 = f32[32768]{0} reshape(mul.60)
  mul.62 = f32[32768,32]{1,0} broadcast(mul.61), dimensions={0}
  mul.63 = f32[32768,32]{1,0} multiply(vmap_jit__roll_dynamic__.9, mul.62)
  add.55 = f32[32768,32]{1,0} add(add.52, mul.63)
  slice.10 = s32[1]{0} slice(Arg_4.2), slice={[4:5]}
  squeeze.10 = s32[] reshape(slice.10)
  add.56 = s32[32768]{0} broadcast(squeeze.10), dimensions={}
  add.57 = s32[32768]{0} add(convert_element_type.1, add.56)
  vmap_jit__roll_dynamic__.10 = f32[32768,32]{1,0} call(Arg_0.8, add.57), to_apply=_roll_dynamic.3
  div.54 = f32[32768]{0} divide(sub.20, broadcast.13)
  neg.3 = f32[32768]{0} negate(div.54)
  div.55 = f32[32768]{0} divide(mul.38, broadcast.19)
  sub.31 = f32[32768]{0} subtract(neg.3, div.55)
  mul.47 = f32[32768]{0} multiply(mul.39, broadcast.11)
  div.56 = f32[32768]{0} divide(mul.47, broadcast.19)
  add.42 = f32[32768]{0} add(sub.31, div.56)
  div.57 = f32[32768]{0} divide(mul.40, broadcast.19)
  add.43 = f32[32768]{0} add(add.42, div.57)
  div.58 = f32[32768]{0} divide(mul.41, broadcast.19)
  sub.32 = f32[32768]{0} subtract(add.43, div.58)
  broadcast_in_dim.16 = f32[32768,1]{1,0} reshape(sub.32)
  mul.64 = f32[32768,1]{1,0} broadcast(broadcast_in_dim.16), dimensions={0,1}
  mul.65 = f32[32768]{0} reshape(mul.64)
  mul.66 = f32[32768,32]{1,0} broadcast(mul.65), dimensions={0}
  mul.67 = f32[32768,32]{1,0} multiply(vmap_jit__roll_dynamic__.10, mul.66)
  add.58 = f32[32768,32]{1,0} add(add.55, mul.67)
  slice.11 = s32[1]{0} slice(Arg_4.2), slice={[5:6]}
  squeeze.11 = s32[] reshape(slice.11)
  add.59 = s32[32768]{0} broadcast(squeeze.11), dimensions={}
  add.60 = s32[32768]{0} add(convert_element_type.1, add.59)
  vmap_jit__roll_dynamic__.11 = f32[32768,32]{1,0} call(Arg_0.8, add.60), to_apply=_roll_dynamic.3
  constant.45 = f32[] constant(30)
  div.31 = f32[32768]{0} broadcast(constant.45), dimensions={}
  div.59 = f32[32768]{0} divide(sub.20, div.31)
  div.60 = f32[32768]{0} divide(mul.39, broadcast.19)
  sub.33 = f32[32768]{0} subtract(div.59, div.60)
  div.61 = f32[32768]{0} divide(mul.41, broadcast.18)
  add.44 = f32[32768]{0} add(sub.33, div.61)
  broadcast_in_dim.17 = f32[32768,1]{1,0} reshape(add.44)
  mul.68 = f32[32768,1]{1,0} broadcast(broadcast_in_dim.17), dimensions={0,1}
  mul.69 = f32[32768]{0} reshape(mul.68)
  mul.70 = f32[32768,32]{1,0} broadcast(mul.69), dimensions={0}
  mul.71 = f32[32768,32]{1,0} multiply(vmap_jit__roll_dynamic__.11, mul.70)
  ROOT add.61 = f32[32768,32]{1,0} add(add.58, mul.71)
}

region_1.5 {
  reduce_sum.3 = f32[] parameter(0)
  reduce_sum.4 = f32[] parameter(1)
  ROOT reduce_sum.5 = f32[] add(reduce_sum.3, reduce_sum.4)
}

fft.6 {
  Arg_0.11 = f32[32,32]{1,0} parameter(0)
  ROOT fft.1 = c64[32,17]{1,0} fft(Arg_0.11), fft_type=RFFT, fft_length={32,32}
}

fft_44.7 {
  Arg_0.13 = c64[32,17]{1,0} parameter(0)
  ROOT fft.3 = f32[32,32]{1,0} fft(Arg_0.13), fft_type=IRFFT, fft_length={32,32}
}

solve_poisson.8 {
  Arg_1.10 = f32[32,1]{1,0} parameter(1)
  convert_element_type.6 = c64[32,1]{1,0} convert(Arg_1.10)
  constant.62 = c64[] constant((-0, -1))
  mul.88 = c64[32,1]{1,0} broadcast(constant.62), dimensions={}
  mul.94 = c64[32,1]{1,0} multiply(convert_element_type.6, mul.88)
  mul.95 = c64[32,1]{1,0} broadcast(mul.94), dimensions={0,1}
  mul.96 = c64[32]{0} reshape(mul.95)
  mul.97 = c64[32,17]{1,0} broadcast(mul.96), dimensions={0}
  Arg_0.14 = f32[32,32,32,32]{3,2,1,0} parameter(0)
  constant.64 = f32[] constant(0)
  reduce_sum.7 = f32[32,32]{1,0} reduce(Arg_0.14, constant.64), dimensions={2,3}, to_apply=region_1.5
  Arg_4.4 = f32[] parameter(4)
  mul.89 = f32[32,32]{1,0} broadcast(Arg_4.4), dimensions={}
  mul.90 = f32[32,32]{1,0} multiply(reduce_sum.7, mul.89)
  Arg_5.2 = f32[] parameter(5)
  mul.91 = f32[32,32]{1,0} broadcast(Arg_5.2), dimensions={}
  mul.92 = f32[32,32]{1,0} multiply(mul.90, mul.91)
  constant.63 = f32[] constant(1)
  sub.36 = f32[32,32]{1,0} broadcast(constant.63), dimensions={}
  sub.37 = f32[32,32]{1,0} subtract(mul.92, sub.36)
  jit_fft_.4 = c64[32,17]{1,0} call(sub.37), to_apply=fft.6
  Arg_3.4 = f32[32,17]{1,0} parameter(3)
  convert_element_type.5 = c64[32,17]{1,0} convert(Arg_3.4)
  mul.93 = c64[32,17]{1,0} multiply(jit_fft_.4, convert_element_type.5)
  mul.98 = c64[32,17]{1,0} multiply(mul.97, mul.93)
  jit_fft_.6 = f32[32,32]{1,0} call(mul.98), to_apply=fft_44.7
  Arg_2.6 = f32[1,17]{1,0} parameter(2)
  convert_element_type.7 = c64[1,17]{1,0} convert(Arg_2.6)
  constant.61 = c64[] constant((-0, -1))
  broadcast.21 = c64[1,17]{1,0} broadcast(constant.61), dimensions={}
  mul.99 = c64[1,17]{1,0} multiply(convert_element_type.7, broadcast.21)
  mul.100 = c64[1,17]{1,0} broadcast(mul.99), dimensions={0,1}
  mul.101 = c64[17]{0} reshape(mul.100)
  mul.102 = c64[32,17]{1,0} broadcast(mul.101), dimensions={1}
  mul.103 = c64[32,17]{1,0} multiply(mul.102, mul.93)
  jit_fft_.7 = f32[32,32]{1,0} call(mul.103), to_apply=fft_44.7
  jit_fft_.5 = f32[32,32]{1,0} call(mul.93), to_apply=fft_44.7
  ROOT tuple.1 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(jit_fft_.6, jit_fft_.7, sub.37, jit_fft_.5)
}

_where_65.9 {
  Arg_0.18 = pred[6,32768,32]{2,1,0} parameter(0)
  Arg_1.14 = f32[6,32768,1]{2,1,0} parameter(1)
  broadcast_in_dim.41 = f32[6,32768,1]{2,1,0} broadcast(Arg_1.14), dimensions={0,1,2}
  broadcast_in_dim.42 = f32[6,32768]{1,0} reshape(broadcast_in_dim.41)
  broadcast_in_dim.43 = f32[6,32768,32]{2,1,0} broadcast(broadcast_in_dim.42), dimensions={0,1}
  Arg_2.10 = f32[] parameter(2)
  broadcast_in_dim.44 = f32[6,32768,32]{2,1,0} broadcast(Arg_2.10), dimensions={}
  ROOT select_n.7 = f32[6,32768,32]{2,1,0} select(Arg_0.18, broadcast_in_dim.43, broadcast_in_dim.44)
}

build_v_diag_weights.10 {
  iota.1 = s32[32]{0} iota(), iota_dimension=0
  broadcast_in_dim.53 = s32[1,1,32]{2,1,0} reshape(iota.1)
  sub.74 = s32[1,1,32]{2,1,0} broadcast(broadcast_in_dim.53), dimensions={0,1,2}
  sub.75 = s32[32]{0} reshape(sub.74)
  sub.76 = s32[6,32768,32]{2,1,0} broadcast(sub.75), dimensions={2}
  Arg_0.19 = s32[6]{0} parameter(0)
  broadcast_in_dim.51 = s32[6,1]{1,0} reshape(Arg_0.19)
  add.89 = s32[6,1]{1,0} broadcast(broadcast_in_dim.51), dimensions={0,1}
  add.90 = s32[6]{0} reshape(add.89)
  add.91 = s32[6,32768]{1,0} broadcast(add.90), dimensions={0}
  Arg_1.15 = s32[32768]{0} parameter(1)
  broadcast_in_dim.52 = s32[1,32768]{1,0} reshape(Arg_1.15)
  add.92 = s32[1,32768]{1,0} broadcast(broadcast_in_dim.52), dimensions={0,1}
  add.93 = s32[32768]{0} reshape(add.92)
  add.94 = s32[6,32768]{1,0} broadcast(add.93), dimensions={1}
  add.95 = s32[6,32768]{1,0} add(add.91, add.94)
  broadcast_in_dim.54 = s32[6,32768,1]{2,1,0} reshape(add.95)
  sub.77 = s32[6,32768,1]{2,1,0} broadcast(broadcast_in_dim.54), dimensions={0,1,2}
  sub.78 = s32[6,32768]{1,0} reshape(sub.77)
  sub.79 = s32[6,32768,32]{2,1,0} broadcast(sub.78), dimensions={0,1}
  sub.80 = s32[6,32768,32]{2,1,0} subtract(sub.76, sub.79)
  constant.81 = s32[] constant(0)
  ge.2 = s32[6,32768,32]{2,1,0} broadcast(constant.81), dimensions={}
  ge.3 = pred[6,32768,32]{2,1,0} compare(sub.80, ge.2), direction=GE
  constant.80 = s32[] constant(32)
  lt.10 = s32[6,32768,32]{2,1,0} broadcast(constant.80), dimensions={}
  lt.11 = pred[6,32768,32]{2,1,0} compare(sub.80, lt.10), direction=LT
  and.3 = pred[6,32768,32]{2,1,0} and(ge.3, lt.11)
  Arg_2.11 = f32[32768]{0} parameter(2)
  constant.93 = f32[] constant(20)
  div.94 = f32[32768]{0} broadcast(constant.93), dimensions={}
  div.95 = f32[32768]{0} divide(Arg_2.11, div.94)
  mul.116 = f32[32768]{0} multiply(Arg_2.11, Arg_2.11)
  constant.92 = f32[] constant(24)
  broadcast.39 = f32[32768]{0} broadcast(constant.92), dimensions={}
  div.96 = f32[32768]{0} divide(mul.116, broadcast.39)
  sub.61 = f32[32768]{0} subtract(div.95, div.96)
  mul.117 = f32[32768]{0} multiply(mul.116, Arg_2.11)
  div.97 = f32[32768]{0} divide(mul.117, broadcast.39)
  sub.62 = f32[32768]{0} subtract(sub.61, div.97)
  mul.118 = f32[32768]{0} multiply(mul.117, Arg_2.11)
  div.98 = f32[32768]{0} divide(mul.118, broadcast.39)
  add.79 = f32[32768]{0} add(sub.62, div.98)
  mul.119 = f32[32768]{0} multiply(mul.118, Arg_2.11)
  constant.91 = f32[] constant(120)
  broadcast.38 = f32[32768]{0} broadcast(constant.91), dimensions={}
  div.99 = f32[32768]{0} divide(mul.119, broadcast.38)
  sub.63 = f32[32768]{0} subtract(add.79, div.99)
  broadcast_in_dim.45 = f32[1,32768]{1,0} reshape(sub.63)
  constant.90 = f32[] constant(2)
  broadcast.37 = f32[32768]{0} broadcast(constant.90), dimensions={}
  div.100 = f32[32768]{0} divide(Arg_2.11, broadcast.37)
  neg.6 = f32[32768]{0} negate(div.100)
  mul.120 = f32[32768]{0} multiply(mul.116, broadcast.37)
  constant.89 = f32[] constant(3)
  broadcast.36 = f32[32768]{0} broadcast(constant.89), dimensions={}
  div.101 = f32[32768]{0} divide(mul.120, broadcast.36)
  add.80 = f32[32768]{0} add(neg.6, div.101)
  div.102 = f32[32768]{0} divide(mul.117, broadcast.39)
  sub.64 = f32[32768]{0} subtract(add.80, div.102)
  constant.88 = f32[] constant(6)
  broadcast.35 = f32[32768]{0} broadcast(constant.88), dimensions={}
  div.103 = f32[32768]{0} divide(mul.118, broadcast.35)
  sub.65 = f32[32768]{0} subtract(sub.64, div.103)
  div.104 = f32[32768]{0} divide(mul.119, broadcast.39)
  add.81 = f32[32768]{0} add(sub.65, div.104)
  broadcast_in_dim.46 = f32[1,32768]{1,0} reshape(add.81)
  constant.87 = f32[] constant(1)
  sub.60 = f32[32768]{0} broadcast(constant.87), dimensions={}
  div.105 = f32[32768]{0} divide(Arg_2.11, broadcast.36)
  sub.66 = f32[32768]{0} subtract(sub.60, div.105)
  constant.86 = f32[] constant(5)
  broadcast.34 = f32[32768]{0} broadcast(constant.86), dimensions={}
  mul.121 = f32[32768]{0} multiply(mul.116, broadcast.34)
  constant.85 = f32[] constant(4)
  broadcast.33 = f32[32768]{0} broadcast(constant.85), dimensions={}
  div.106 = f32[32768]{0} divide(mul.121, broadcast.33)
  sub.67 = f32[32768]{0} subtract(sub.66, div.106)
  mul.122 = f32[32768]{0} multiply(mul.117, broadcast.34)
  constant.84 = f32[] constant(12)
  broadcast.32 = f32[32768]{0} broadcast(constant.84), dimensions={}
  div.107 = f32[32768]{0} divide(mul.122, broadcast.32)
  add.82 = f32[32768]{0} add(sub.67, div.107)
  div.108 = f32[32768]{0} divide(mul.118, broadcast.33)
  add.83 = f32[32768]{0} add(add.82, div.108)
  div.109 = f32[32768]{0} divide(mul.119, broadcast.32)
  sub.68 = f32[32768]{0} subtract(add.83, div.109)
  broadcast_in_dim.47 = f32[1,32768]{1,0} reshape(sub.68)
  mul.123 = f32[32768]{0} multiply(mul.116, broadcast.37)
  div.110 = f32[32768]{0} divide(mul.123, broadcast.36)
  add.84 = f32[32768]{0} add(Arg_2.11, div.110)
  constant.83 = f32[] constant(7)
  broadcast.31 = f32[32768]{0} broadcast(constant.83), dimensions={}
  mul.124 = f32[32768]{0} multiply(mul.117, broadcast.31)
  div.111 = f32[32768]{0} divide(mul.124, broadcast.32)
  sub.69 = f32[32768]{0} subtract(add.84, div.111)
  div.112 = f32[32768]{0} divide(mul.118, broadcast.35)
  sub.70 = f32[32768]{0} subtract(sub.69, div.112)
  div.113 = f32[32768]{0} divide(mul.119, broadcast.32)
  add.85 = f32[32768]{0} add(sub.70, div.113)
  broadcast_in_dim.48 = f32[1,32768]{1,0} reshape(add.85)
  div.114 = f32[32768]{0} divide(Arg_2.11, broadcast.33)
  neg.7 = f32[32768]{0} negate(div.114)
  div.115 = f32[32768]{0} divide(mul.116, broadcast.39)
  sub.71 = f32[32768]{0} subtract(neg.7, div.115)
  mul.125 = f32[32768]{0} multiply(mul.117, broadcast.31)
  div.116 = f32[32768]{0} divide(mul.125, broadcast.39)
  add.86 = f32[32768]{0} add(sub.71, div.116)
  div.117 = f32[32768]{0} divide(mul.118, broadcast.39)
  add.87 = f32[32768]{0} add(add.86, div.117)
  div.118 = f32[32768]{0} divide(mul.119, broadcast.39)
  sub.72 = f32[32768]{0} subtract(add.87, div.118)
  broadcast_in_dim.49 = f32[1,32768]{1,0} reshape(sub.72)
  constant.82 = f32[] constant(30)
  div.93 = f32[32768]{0} broadcast(constant.82), dimensions={}
  div.119 = f32[32768]{0} divide(Arg_2.11, div.93)
  div.120 = f32[32768]{0} divide(mul.117, broadcast.39)
  sub.73 = f32[32768]{0} subtract(div.119, div.120)
  div.121 = f32[32768]{0} divide(mul.119, broadcast.38)
  add.88 = f32[32768]{0} add(sub.73, div.121)
  broadcast_in_dim.50 = f32[1,32768]{1,0} reshape(add.88)
  concatenate.3 = f32[6,32768]{1,0} concatenate(broadcast_in_dim.45, broadcast_in_dim.46, broadcast_in_dim.47, broadcast_in_dim.48, broadcast_in_dim.49, broadcast_in_dim.50), dimensions={0}
  broadcast_in_dim.55 = f32[6,32768,1]{2,1,0} reshape(concatenate.3)
  constant.94 = f32[] constant(0)
  ROOT jit__where_.3 = f32[6,32768,32]{2,1,0} call(and.3, broadcast_in_dim.55, constant.94), to_apply=_where_65.9
}

advect_1d_roll_diag_55.11 {
  Arg_4.6 = s32[6]{0} parameter(4)
  Arg_1.16 = f32[32768]{0} parameter(1)
  Arg_2.12 = f32[] parameter(2)
  mul.132 = f32[32768]{0} broadcast(Arg_2.12), dimensions={}
  mul.133 = f32[32768]{0} multiply(Arg_1.16, mul.132)
  Arg_3.6 = f32[] parameter(3)
  div.122 = f32[32768]{0} broadcast(Arg_3.6), dimensions={}
  div.123 = f32[32768]{0} divide(mul.133, div.122)
  floor.3 = f32[32768]{0} floor(div.123)
  convert_element_type.9 = s32[32768]{0} convert(floor.3)
  sub.81 = f32[32768]{0} subtract(div.123, floor.3)
  jit_build_v_diag_weights_.1 = f32[6,32768,32]{2,1,0} call(Arg_4.6, convert_element_type.9, sub.81), to_apply=build_v_diag_weights.10
  slice.25 = f32[1,32768,32]{2,1,0} slice(jit_build_v_diag_weights_.1), slice={[0:1], [0:32768], [0:32]}
  squeeze.25 = f32[32768,32]{1,0} reshape(slice.25)
  Arg_0.20 = f32[32768,32]{1,0} parameter(0)
  slice.24 = s32[1]{0} slice(Arg_4.6), slice={[0:1]}
  squeeze.24 = s32[] reshape(slice.24)
  add.113 = s32[32768]{0} broadcast(squeeze.24), dimensions={}
  add.114 = s32[32768]{0} add(convert_element_type.9, add.113)
  vmap_jit__roll_dynamic__.18 = f32[32768,32]{1,0} call(Arg_0.20, add.114), to_apply=_roll_dynamic.3
  mul.134 = f32[32768,32]{1,0} multiply(squeeze.25, vmap_jit__roll_dynamic__.18)
  slice.27 = f32[1,32768,32]{2,1,0} slice(jit_build_v_diag_weights_.1), slice={[1:2], [0:32768], [0:32]}
  squeeze.27 = f32[32768,32]{1,0} reshape(slice.27)
  slice.26 = s32[1]{0} slice(Arg_4.6), slice={[1:2]}
  squeeze.26 = s32[] reshape(slice.26)
  add.115 = s32[32768]{0} broadcast(squeeze.26), dimensions={}
  add.116 = s32[32768]{0} add(convert_element_type.9, add.115)
  vmap_jit__roll_dynamic__.19 = f32[32768,32]{1,0} call(Arg_0.20, add.116), to_apply=_roll_dynamic.3
  mul.135 = f32[32768,32]{1,0} multiply(squeeze.27, vmap_jit__roll_dynamic__.19)
  add.117 = f32[32768,32]{1,0} add(mul.134, mul.135)
  slice.29 = f32[1,32768,32]{2,1,0} slice(jit_build_v_diag_weights_.1), slice={[2:3], [0:32768], [0:32]}
  squeeze.29 = f32[32768,32]{1,0} reshape(slice.29)
  slice.28 = s32[1]{0} slice(Arg_4.6), slice={[2:3]}
  squeeze.28 = s32[] reshape(slice.28)
  add.118 = s32[32768]{0} broadcast(squeeze.28), dimensions={}
  add.119 = s32[32768]{0} add(convert_element_type.9, add.118)
  vmap_jit__roll_dynamic__.20 = f32[32768,32]{1,0} call(Arg_0.20, add.119), to_apply=_roll_dynamic.3
  mul.136 = f32[32768,32]{1,0} multiply(squeeze.29, vmap_jit__roll_dynamic__.20)
  add.120 = f32[32768,32]{1,0} add(add.117, mul.136)
  slice.31 = f32[1,32768,32]{2,1,0} slice(jit_build_v_diag_weights_.1), slice={[3:4], [0:32768], [0:32]}
  squeeze.31 = f32[32768,32]{1,0} reshape(slice.31)
  slice.30 = s32[1]{0} slice(Arg_4.6), slice={[3:4]}
  squeeze.30 = s32[] reshape(slice.30)
  add.121 = s32[32768]{0} broadcast(squeeze.30), dimensions={}
  add.122 = s32[32768]{0} add(convert_element_type.9, add.121)
  vmap_jit__roll_dynamic__.21 = f32[32768,32]{1,0} call(Arg_0.20, add.122), to_apply=_roll_dynamic.3
  mul.137 = f32[32768,32]{1,0} multiply(squeeze.31, vmap_jit__roll_dynamic__.21)
  add.123 = f32[32768,32]{1,0} add(add.120, mul.137)
  slice.33 = f32[1,32768,32]{2,1,0} slice(jit_build_v_diag_weights_.1), slice={[4:5], [0:32768], [0:32]}
  squeeze.33 = f32[32768,32]{1,0} reshape(slice.33)
  slice.32 = s32[1]{0} slice(Arg_4.6), slice={[4:5]}
  squeeze.32 = s32[] reshape(slice.32)
  add.124 = s32[32768]{0} broadcast(squeeze.32), dimensions={}
  add.125 = s32[32768]{0} add(convert_element_type.9, add.124)
  vmap_jit__roll_dynamic__.22 = f32[32768,32]{1,0} call(Arg_0.20, add.125), to_apply=_roll_dynamic.3
  mul.138 = f32[32768,32]{1,0} multiply(squeeze.33, vmap_jit__roll_dynamic__.22)
  add.126 = f32[32768,32]{1,0} add(add.123, mul.138)
  slice.35 = f32[1,32768,32]{2,1,0} slice(jit_build_v_diag_weights_.1), slice={[5:6], [0:32768], [0:32]}
  squeeze.35 = f32[32768,32]{1,0} reshape(slice.35)
  slice.34 = s32[1]{0} slice(Arg_4.6), slice={[5:6]}
  squeeze.34 = s32[] reshape(slice.34)
  add.127 = s32[32768]{0} broadcast(squeeze.34), dimensions={}
  add.128 = s32[32768]{0} add(convert_element_type.9, add.127)
  vmap_jit__roll_dynamic__.23 = f32[32768,32]{1,0} call(Arg_0.20, add.128), to_apply=_roll_dynamic.3
  mul.139 = f32[32768,32]{1,0} multiply(squeeze.35, vmap_jit__roll_dynamic__.23)
  ROOT add.129 = f32[32768,32]{1,0} add(add.126, mul.139)
}

closed_call.12 {
  Arg_7.1 = f32[32,32]{1,0} parameter(7)
  Arg_8.1 = f32[32,32]{1,0} parameter(8)
  Arg_6.1 = f32[32,32,32,32]{3,2,1,0} parameter(6)
  transpose.8 = f32[32,32,32,32]{2,1,0,3} transpose(Arg_6.1), dimensions={1,2,3,0}
  reshape.18 = f32[32768,32]{1,0} reshape(transpose.8)
  Arg_0.21 = f32[32]{0} parameter(0)
  broadcast_in_dim.68 = f32[1,32,1]{2,1,0} reshape(Arg_0.21)
  broadcast_in_dim.69 = f32[1,32,1]{2,1,0} broadcast(broadcast_in_dim.68), dimensions={0,1,2}
  broadcast_in_dim.70 = f32[32]{0} reshape(broadcast_in_dim.69)
  broadcast_in_dim.71 = f32[32,32,32]{2,1,0} broadcast(broadcast_in_dim.70), dimensions={1}
  reshape.19 = f32[32768]{0} reshape(broadcast_in_dim.71)
  constant.98 = f32[] constant(0.025)
  constant.97 = f32[] constant(0.392699093)
  Arg_1.17 = s32[6]{0} parameter(1)
  jit_advect_1d_roll_diag_.6 = f32[32768,32]{1,0} call(reshape.18, reshape.19, constant.98, constant.97, Arg_1.17), to_apply=advect_1d_roll_diag.4
  reshape.20 = f32[32,32,32,32]{3,2,1,0} reshape(jit_advect_1d_roll_diag_.6)
  transpose.9 = f32[32,32,32,32]{0,2,1,3} transpose(reshape.20), dimensions={3,1,2,0}
  reshape.21 = f32[32768,32]{1,0} reshape(transpose.9)
  Arg_2.13 = f32[32]{0} parameter(2)
  broadcast_in_dim.72 = f32[1,1,32]{2,1,0} reshape(Arg_2.13)
  broadcast_in_dim.73 = f32[1,1,32]{2,1,0} broadcast(broadcast_in_dim.72), dimensions={0,1,2}
  broadcast_in_dim.74 = f32[32]{0} reshape(broadcast_in_dim.73)
  broadcast_in_dim.75 = f32[32,32,32]{2,1,0} broadcast(broadcast_in_dim.74), dimensions={2}
  reshape.22 = f32[32768]{0} reshape(broadcast_in_dim.75)
  jit_advect_1d_roll_diag_.7 = f32[32768,32]{1,0} call(reshape.21, reshape.22, constant.98, constant.97, Arg_1.17), to_apply=advect_1d_roll_diag.4
  reshape.23 = f32[32,32,32,32]{3,2,1,0} reshape(jit_advect_1d_roll_diag_.7)
  transpose.11 = f32[32,32,32,32]{1,2,3,0} transpose(reshape.23), dimensions={0,3,2,1}
  reshape.24 = f32[32768,32]{1,0} reshape(transpose.11)
  transpose.10 = f32[32,32,32,32]{1,3,2,0} transpose(reshape.23), dimensions={0,3,1,2}
  Arg_3.7 = f32[32,1]{1,0} parameter(3)
  Arg_4.7 = f32[1,17]{1,0} parameter(4)
  Arg_5.3 = f32[32,17]{1,0} parameter(5)
  constant.96 = f32[] constant(0.322580636)
  jit_solve_poisson_.5 = (f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) call(transpose.10, Arg_3.7, Arg_4.7, Arg_5.3, constant.96, constant.96), to_apply=solve_poisson.8
  jit_solve_poisson_.6 = f32[32,32]{1,0} get-tuple-element(jit_solve_poisson_.5), index=0
  broadcast_in_dim.76 = f32[32,32,1]{2,1,0} reshape(jit_solve_poisson_.6)
  broadcast_in_dim.77 = f32[32,32,1]{2,1,0} broadcast(broadcast_in_dim.76), dimensions={0,1,2}
  broadcast_in_dim.78 = f32[32,32]{1,0} reshape(broadcast_in_dim.77)
  broadcast_in_dim.79 = f32[32,32,32]{2,1,0} broadcast(broadcast_in_dim.78), dimensions={0,1}
  reshape.25 = f32[32768]{0} reshape(broadcast_in_dim.79)
  constant.95 = f32[] constant(0.05)
  jit_advect_1d_roll_diag_.8 = f32[32768,32]{1,0} call(reshape.24, reshape.25, constant.95, constant.96, Arg_1.17), to_apply=advect_1d_roll_diag_55.11
  reshape.26 = f32[32,32,32,32]{3,2,1,0} reshape(jit_advect_1d_roll_diag_.8)
  transpose.12 = f32[32,32,32,32]{2,3,1,0} transpose(reshape.26), dimensions={0,1,3,2}
  reshape.27 = f32[32768,32]{1,0} reshape(transpose.12)
  jit_solve_poisson_.7 = f32[32,32]{1,0} get-tuple-element(jit_solve_poisson_.5), index=1
  broadcast_in_dim.80 = f32[32,32,1]{2,1,0} reshape(jit_solve_poisson_.7)
  broadcast_in_dim.81 = f32[32,32,1]{2,1,0} broadcast(broadcast_in_dim.80), dimensions={0,1,2}
  broadcast_in_dim.82 = f32[32,32]{1,0} reshape(broadcast_in_dim.81)
  broadcast_in_dim.83 = f32[32,32,32]{2,1,0} broadcast(broadcast_in_dim.82), dimensions={0,1}
  reshape.28 = f32[32768]{0} reshape(broadcast_in_dim.83)
  jit_advect_1d_roll_diag_.9 = f32[32768,32]{1,0} call(reshape.27, reshape.28, constant.95, constant.96, Arg_1.17), to_apply=advect_1d_roll_diag_55.11
  reshape.29 = f32[32,32,32,32]{3,2,1,0} reshape(jit_advect_1d_roll_diag_.9)
  transpose.13 = f32[32,32,32,32]{2,1,3,0} transpose(reshape.29), dimensions={0,2,3,1}
  reshape.30 = f32[32768,32]{1,0} reshape(transpose.13)
  broadcast_in_dim.84 = f32[1,1,32]{2,1,0} reshape(Arg_2.13)
  broadcast_in_dim.85 = f32[1,1,32]{2,1,0} broadcast(broadcast_in_dim.84), dimensions={0,1,2}
  broadcast_in_dim.86 = f32[32]{0} reshape(broadcast_in_dim.85)
  broadcast_in_dim.87 = f32[32,32,32]{2,1,0} broadcast(broadcast_in_dim.86), dimensions={2}
  reshape.31 = f32[32768]{0} reshape(broadcast_in_dim.87)
  jit_advect_1d_roll_diag_.10 = f32[32768,32]{1,0} call(reshape.30, reshape.31, constant.98, constant.97, Arg_1.17), to_apply=advect_1d_roll_diag.4
  reshape.32 = f32[32,32,32,32]{3,2,1,0} reshape(jit_advect_1d_roll_diag_.10)
  transpose.14 = f32[32,32,32,32]{0,2,1,3} transpose(reshape.32), dimensions={3,1,2,0}
  reshape.33 = f32[32768,32]{1,0} reshape(transpose.14)
  broadcast_in_dim.88 = f32[1,32,1]{2,1,0} reshape(Arg_0.21)
  broadcast_in_dim.89 = f32[1,32,1]{2,1,0} broadcast(broadcast_in_dim.88), dimensions={0,1,2}
  broadcast_in_dim.90 = f32[32]{0} reshape(broadcast_in_dim.89)
  broadcast_in_dim.91 = f32[32,32,32]{2,1,0} broadcast(broadcast_in_dim.90), dimensions={1}
  reshape.34 = f32[32768]{0} reshape(broadcast_in_dim.91)
  jit_advect_1d_roll_diag_.11 = f32[32768,32]{1,0} call(reshape.33, reshape.34, constant.98, constant.97, Arg_1.17), to_apply=advect_1d_roll_diag.4
  reshape.35 = f32[32,32,32,32]{3,2,1,0} reshape(jit_advect_1d_roll_diag_.11)
  transpose.15 = f32[32,32,32,32]{0,3,2,1} transpose(reshape.35), dimensions={3,0,1,2}
  jit_solve_poisson_.8 = f32[32,32]{1,0} get-tuple-element(jit_solve_poisson_.5), index=2
  jit_solve_poisson_.9 = f32[32,32]{1,0} get-tuple-element(jit_solve_poisson_.5), index=3
  ROOT tuple.3 = (f32[32,32,32,32]{0,3,2,1}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(transpose.15, jit_solve_poisson_.8, jit_solve_poisson_.9)
}

region_0.13 {
  arg_tuple.1 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) parameter(0)
  get-tuple-element.4 = s32[] get-tuple-element(arg_tuple.1), index=0
  constant.99 = s32[] constant(1)
  add.131 = s32[] add(get-tuple-element.4, constant.99)
  constant.104 = f32[32]{0} constant({...})
  constant.103 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  constant.102 = f32[32,1]{1,0} constant({...})
  constant.101 = f32[1,17]{1,0} constant({...})
  constant.100 = f32[32,17]{1,0} constant({...})
  get-tuple-element.5 = f32[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.1), index=1
  get-tuple-element.6 = f32[32,32]{1,0} get-tuple-element(arg_tuple.1), index=2
  get-tuple-element.7 = f32[32,32]{1,0} get-tuple-element(arg_tuple.1), index=3
  closed_call.4 = (f32[32,32,32,32]{0,3,2,1}, f32[32,32]{1,0}, f32[32,32]{1,0}) call(constant.104, constant.103, constant.104, constant.102, constant.101, constant.100, get-tuple-element.5, get-tuple-element.6, get-tuple-element.7), to_apply=closed_call.12
  closed_call.5 = f32[32,32,32,32]{0,3,2,1} get-tuple-element(closed_call.4), index=0
  closed_call.6 = f32[32,32]{1,0} get-tuple-element(closed_call.4), index=1
  closed_call.7 = f32[32,32]{1,0} get-tuple-element(closed_call.4), index=2
  ROOT tuple.5 = (s32[], f32[32,32,32,32]{0,3,2,1}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(add.131, closed_call.5, closed_call.6, closed_call.7)
}

region_2.14 {
  arg_tuple.3 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) parameter(0)
  get-tuple-element.13 = f32[32,32,32,32]{3,2,1,0} get-tuple-element(arg_tuple.3), index=1
  get-tuple-element.14 = f32[32,32]{1,0} get-tuple-element(arg_tuple.3), index=2
  get-tuple-element.15 = f32[32,32]{1,0} get-tuple-element(arg_tuple.3), index=3
  get-tuple-element.12 = s32[] get-tuple-element(arg_tuple.3), index=0
  constant.106 = s32[] constant(10)
  ROOT lt.13 = pred[] compare(get-tuple-element.12, constant.106), direction=LT
}

ENTRY main.15 {
  constant.115 = s32[] constant(0)
  start_state_2__0_.1 = f32[32,32,32,32]{3,2,1,0} parameter(2)
  start_state_1__0_.1 = f32[32,32]{1,0} parameter(0)
  start_state_1__1_.1 = f32[32,32]{1,0} parameter(1)
  while.6 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) tuple(constant.115, start_state_2__0_.1, start_state_1__0_.1, start_state_1__1_.1)
  while.7 = (s32[], f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[32,32]{1,0}) while(while.6), condition=region_2.14, body=region_0.13
  while.8 = s32[] get-tuple-element(while.7), index=0
  constant.114 = f32[32]{0} constant({...})
  constant.109 = f32[32]{0} constant({...})
  constant.111 = f32[32,1]{1,0} constant({...})
  constant.112 = f32[1,17]{1,0} constant({...})
  constant.113 = f32[32,17]{1,0} constant({...})
  constant.110 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  while.10 = f32[32,32]{1,0} get-tuple-element(while.7), index=2
  while.11 = f32[32,32]{1,0} get-tuple-element(while.7), index=3
  while.9 = f32[32,32,32,32]{3,2,1,0} get-tuple-element(while.7), index=1
  start_state_2__1_.1 = f32[32,32]{1,0} parameter(3)
  start_state_3_.1 = f32[] parameter(4)
  constant.107 = f32[] constant(0.5)
  add.134 = f32[] add(start_state_3_.1, constant.107)
  start_state_4_.1 = s32[] parameter(5)
  constant.108 = s32[] constant(10)
  add.135 = s32[] add(start_state_4_.1, constant.108)
  ROOT tuple.7 = (f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,1]{1,0}, /*index=5*/f32[1,17]{1,0}, f32[32,17]{1,0}, s32[6]{0}, f32[32,32]{1,0}, f32[32,32]{1,0}, /*index=10*/f32[32,32,32,32]{3,2,1,0}, f32[32,32]{1,0}, f32[], s32[]) tuple(constant.114, constant.114, constant.109, constant.109, constant.111, constant.112, constant.113, constant.110, while.10, while.11, while.9, start_state_2__1_.1, add.134, add.135)
}

