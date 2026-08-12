HloModule jit__lambda, entry_computation_layout={(f64[128,128]{1,0})->(f64[128,128]{0,1}, f64[128]{0}, f64[128]{0})}

_where.1 {
  Arg_0.4 = pred[] parameter(0)
  Arg_1.4 = s32[] parameter(1)
  Arg_2.2 = s32[] parameter(2)
  ROOT select_n.1 = s32[] select(Arg_0.4, Arg_1.4, Arg_2.2)
}

remainder.2 {
  Arg_0.5 = s32[128]{0} parameter(0)
  Arg_1.5 = s32[] parameter(1)
  constant.28 = s32[] constant(0)
  eq.1 = pred[] compare(Arg_1.5, constant.28), direction=EQ
  constant.27 = s32[] constant(1)
  jit__where_.1 = s32[] call(eq.1, constant.27, Arg_1.5), to_apply=_where.1
  rem.2 = s32[128]{0} broadcast(jit__where_.1), dimensions={}
  rem.3 = s32[128]{0} remainder(Arg_0.5, rem.2)
  constant.26 = s32[] constant(0)
  broadcast.10 = s32[128]{0} broadcast(constant.26), dimensions={}
  lt.3 = pred[128]{0} compare(rem.3, broadcast.10), direction=LT
  lt.4 = pred[] compare(jit__where_.1, constant.28), direction=LT
  ne.4 = pred[128]{0} broadcast(lt.4), dimensions={}
  ne.5 = pred[128]{0} compare(lt.3, ne.4), direction=NE
  ne.3 = pred[128]{0} compare(rem.3, broadcast.10), direction=NE
  and.1 = pred[128]{0} and(ne.5, ne.3)
  add.15 = s32[128]{0} broadcast(jit__where_.1), dimensions={}
  add.16 = s32[128]{0} add(rem.3, add.15)
  ROOT select_n.3 = s32[128]{0} select(and.1, add.16, rem.3)
}

_roll_dynamic.3 {
  Arg_0.6 = f64[128,128]{1,0} parameter(0)
  transpose.2 = f64[128,128]{0,1} transpose(Arg_0.6), dimensions={1,0}
  transpose.3 = f64[128,128]{0,1} transpose(Arg_0.6), dimensions={1,0}
  concatenate.1 = f64[128,256]{1,0} concatenate(transpose.2, transpose.3), dimensions={1}
  constant.31 = s32[] constant(128)
  sub.17 = s32[128]{0} broadcast(constant.31), dimensions={}
  Arg_1.6 = s32[128]{0} parameter(1)
  constant.32 = s32[] constant(128)
  jit_remainder_.1 = s32[128]{0} call(Arg_1.6, constant.32), to_apply=remainder.2
  sub.18 = s32[128]{0} subtract(sub.17, jit_remainder_.1)
  constant.30 = s32[] constant(0)
  lt.6 = s32[128]{0} broadcast(constant.30), dimensions={}
  lt.7 = pred[128]{0} compare(sub.18, lt.6), direction=LT
  constant.29 = s32[] constant(256)
  add.18 = s32[128]{0} broadcast(constant.29), dimensions={}
  add.19 = s32[128]{0} add(sub.18, add.18)
  select_n.5 = s32[128]{0} select(lt.7, add.19, sub.18)
  broadcast_in_dim.7 = s32[128,1]{1,0} reshape(select_n.5)
  ROOT gather.1 = f64[128,128]{1,0} gather(concatenate.1, broadcast_in_dim.7), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

advect_1d_matrix_diag.4 {
  Arg_0.7 = f64[128,128]{1,0} parameter(0)
  Arg_1.7 = f64[128]{0} parameter(1)
  Arg_2.3 = f64[] parameter(2)
  mul.36 = f64[128]{0} broadcast(Arg_2.3), dimensions={}
  mul.37 = f64[128]{0} multiply(Arg_1.7, mul.36)
  Arg_3.1 = f64[] parameter(3)
  div.33 = f64[128]{0} broadcast(Arg_3.1), dimensions={}
  div.34 = f64[128]{0} divide(mul.37, div.33)
  floor.1 = f64[128]{0} floor(div.34)
  convert_element_type.1 = s32[128]{0} convert(floor.1)
  Arg_4.1 = s32[6]{0} parameter(4)
  slice.6 = s32[1]{0} slice(Arg_4.1), slice={[0:1]}
  squeeze.6 = s32[] reshape(slice.6)
  add.45 = s32[128]{0} broadcast(squeeze.6), dimensions={}
  add.46 = s32[128]{0} add(convert_element_type.1, add.45)
  vmap_jit__roll_dynamic__.6 = f64[128,128]{1,0} call(Arg_0.7, add.46), to_apply=_roll_dynamic.3
  transpose.10 = f64[128,128]{0,1} transpose(vmap_jit__roll_dynamic__.6), dimensions={1,0}
  sub.20 = f64[128]{0} subtract(div.34, floor.1)
  constant.44 = f64[] constant(20)
  div.32 = f64[128]{0} broadcast(constant.44), dimensions={}
  div.35 = f64[128]{0} divide(sub.20, div.32)
  mul.38 = f64[128]{0} multiply(sub.20, sub.20)
  constant.43 = f64[] constant(24)
  broadcast.19 = f64[128]{0} broadcast(constant.43), dimensions={}
  div.36 = f64[128]{0} divide(mul.38, broadcast.19)
  sub.21 = f64[128]{0} subtract(div.35, div.36)
  mul.39 = f64[128]{0} multiply(mul.38, sub.20)
  div.37 = f64[128]{0} divide(mul.39, broadcast.19)
  sub.22 = f64[128]{0} subtract(sub.21, div.37)
  mul.40 = f64[128]{0} multiply(mul.39, sub.20)
  div.38 = f64[128]{0} divide(mul.40, broadcast.19)
  add.35 = f64[128]{0} add(sub.22, div.38)
  mul.41 = f64[128]{0} multiply(mul.40, sub.20)
  constant.42 = f64[] constant(120)
  broadcast.18 = f64[128]{0} broadcast(constant.42), dimensions={}
  div.39 = f64[128]{0} divide(mul.41, broadcast.18)
  sub.23 = f64[128]{0} subtract(add.35, div.39)
  broadcast_in_dim.8 = f64[1,128]{1,0} reshape(sub.23)
  mul.48 = f64[1,128]{1,0} broadcast(broadcast_in_dim.8), dimensions={0,1}
  mul.49 = f64[128]{0} reshape(mul.48)
  mul.50 = f64[128,128]{1,0} broadcast(mul.49), dimensions={1}
  mul.51 = f64[128,128]{0,1} multiply(transpose.10, mul.50)
  slice.7 = s32[1]{0} slice(Arg_4.1), slice={[1:2]}
  squeeze.7 = s32[] reshape(slice.7)
  add.47 = s32[128]{0} broadcast(squeeze.7), dimensions={}
  add.48 = s32[128]{0} add(convert_element_type.1, add.47)
  vmap_jit__roll_dynamic__.7 = f64[128,128]{1,0} call(Arg_0.7, add.48), to_apply=_roll_dynamic.3
  transpose.11 = f64[128,128]{0,1} transpose(vmap_jit__roll_dynamic__.7), dimensions={1,0}
  constant.41 = f64[] constant(2)
  broadcast.17 = f64[128]{0} broadcast(constant.41), dimensions={}
  div.40 = f64[128]{0} divide(sub.20, broadcast.17)
  neg.2 = f64[128]{0} negate(div.40)
  mul.42 = f64[128]{0} multiply(mul.38, broadcast.17)
  constant.40 = f64[] constant(3)
  broadcast.16 = f64[128]{0} broadcast(constant.40), dimensions={}
  div.41 = f64[128]{0} divide(mul.42, broadcast.16)
  add.36 = f64[128]{0} add(neg.2, div.41)
  div.42 = f64[128]{0} divide(mul.39, broadcast.19)
  sub.24 = f64[128]{0} subtract(add.36, div.42)
  constant.39 = f64[] constant(6)
  broadcast.15 = f64[128]{0} broadcast(constant.39), dimensions={}
  div.43 = f64[128]{0} divide(mul.40, broadcast.15)
  sub.25 = f64[128]{0} subtract(sub.24, div.43)
  div.44 = f64[128]{0} divide(mul.41, broadcast.19)
  add.37 = f64[128]{0} add(sub.25, div.44)
  broadcast_in_dim.9 = f64[1,128]{1,0} reshape(add.37)
  mul.52 = f64[1,128]{1,0} broadcast(broadcast_in_dim.9), dimensions={0,1}
  mul.53 = f64[128]{0} reshape(mul.52)
  mul.54 = f64[128,128]{1,0} broadcast(mul.53), dimensions={1}
  mul.55 = f64[128,128]{0,1} multiply(transpose.11, mul.54)
  add.49 = f64[128,128]{0,1} add(mul.51, mul.55)
  slice.8 = s32[1]{0} slice(Arg_4.1), slice={[2:3]}
  squeeze.8 = s32[] reshape(slice.8)
  add.50 = s32[128]{0} broadcast(squeeze.8), dimensions={}
  add.51 = s32[128]{0} add(convert_element_type.1, add.50)
  vmap_jit__roll_dynamic__.8 = f64[128,128]{1,0} call(Arg_0.7, add.51), to_apply=_roll_dynamic.3
  transpose.12 = f64[128,128]{0,1} transpose(vmap_jit__roll_dynamic__.8), dimensions={1,0}
  constant.38 = f64[] constant(1)
  sub.19 = f64[128]{0} broadcast(constant.38), dimensions={}
  div.45 = f64[128]{0} divide(sub.20, broadcast.16)
  sub.26 = f64[128]{0} subtract(sub.19, div.45)
  constant.37 = f64[] constant(5)
  broadcast.14 = f64[128]{0} broadcast(constant.37), dimensions={}
  mul.43 = f64[128]{0} multiply(mul.38, broadcast.14)
  constant.36 = f64[] constant(4)
  broadcast.13 = f64[128]{0} broadcast(constant.36), dimensions={}
  div.46 = f64[128]{0} divide(mul.43, broadcast.13)
  sub.27 = f64[128]{0} subtract(sub.26, div.46)
  mul.44 = f64[128]{0} multiply(mul.39, broadcast.14)
  constant.35 = f64[] constant(12)
  broadcast.12 = f64[128]{0} broadcast(constant.35), dimensions={}
  div.47 = f64[128]{0} divide(mul.44, broadcast.12)
  add.38 = f64[128]{0} add(sub.27, div.47)
  div.48 = f64[128]{0} divide(mul.40, broadcast.13)
  add.39 = f64[128]{0} add(add.38, div.48)
  div.49 = f64[128]{0} divide(mul.41, broadcast.12)
  sub.28 = f64[128]{0} subtract(add.39, div.49)
  broadcast_in_dim.10 = f64[1,128]{1,0} reshape(sub.28)
  mul.56 = f64[1,128]{1,0} broadcast(broadcast_in_dim.10), dimensions={0,1}
  mul.57 = f64[128]{0} reshape(mul.56)
  mul.58 = f64[128,128]{1,0} broadcast(mul.57), dimensions={1}
  mul.59 = f64[128,128]{0,1} multiply(transpose.12, mul.58)
  add.52 = f64[128,128]{0,1} add(add.49, mul.59)
  slice.9 = s32[1]{0} slice(Arg_4.1), slice={[3:4]}
  squeeze.9 = s32[] reshape(slice.9)
  add.53 = s32[128]{0} broadcast(squeeze.9), dimensions={}
  add.54 = s32[128]{0} add(convert_element_type.1, add.53)
  vmap_jit__roll_dynamic__.9 = f64[128,128]{1,0} call(Arg_0.7, add.54), to_apply=_roll_dynamic.3
  transpose.13 = f64[128,128]{0,1} transpose(vmap_jit__roll_dynamic__.9), dimensions={1,0}
  mul.45 = f64[128]{0} multiply(mul.38, broadcast.17)
  div.50 = f64[128]{0} divide(mul.45, broadcast.16)
  add.40 = f64[128]{0} add(sub.20, div.50)
  constant.34 = f64[] constant(7)
  broadcast.11 = f64[128]{0} broadcast(constant.34), dimensions={}
  mul.46 = f64[128]{0} multiply(mul.39, broadcast.11)
  div.51 = f64[128]{0} divide(mul.46, broadcast.12)
  sub.29 = f64[128]{0} subtract(add.40, div.51)
  div.52 = f64[128]{0} divide(mul.40, broadcast.15)
  sub.30 = f64[128]{0} subtract(sub.29, div.52)
  div.53 = f64[128]{0} divide(mul.41, broadcast.12)
  add.41 = f64[128]{0} add(sub.30, div.53)
  broadcast_in_dim.11 = f64[1,128]{1,0} reshape(add.41)
  mul.60 = f64[1,128]{1,0} broadcast(broadcast_in_dim.11), dimensions={0,1}
  mul.61 = f64[128]{0} reshape(mul.60)
  mul.62 = f64[128,128]{1,0} broadcast(mul.61), dimensions={1}
  mul.63 = f64[128,128]{0,1} multiply(transpose.13, mul.62)
  add.55 = f64[128,128]{0,1} add(add.52, mul.63)
  slice.10 = s32[1]{0} slice(Arg_4.1), slice={[4:5]}
  squeeze.10 = s32[] reshape(slice.10)
  add.56 = s32[128]{0} broadcast(squeeze.10), dimensions={}
  add.57 = s32[128]{0} add(convert_element_type.1, add.56)
  vmap_jit__roll_dynamic__.10 = f64[128,128]{1,0} call(Arg_0.7, add.57), to_apply=_roll_dynamic.3
  transpose.14 = f64[128,128]{0,1} transpose(vmap_jit__roll_dynamic__.10), dimensions={1,0}
  div.54 = f64[128]{0} divide(sub.20, broadcast.13)
  neg.3 = f64[128]{0} negate(div.54)
  div.55 = f64[128]{0} divide(mul.38, broadcast.19)
  sub.31 = f64[128]{0} subtract(neg.3, div.55)
  mul.47 = f64[128]{0} multiply(mul.39, broadcast.11)
  div.56 = f64[128]{0} divide(mul.47, broadcast.19)
  add.42 = f64[128]{0} add(sub.31, div.56)
  div.57 = f64[128]{0} divide(mul.40, broadcast.19)
  add.43 = f64[128]{0} add(add.42, div.57)
  div.58 = f64[128]{0} divide(mul.41, broadcast.19)
  sub.32 = f64[128]{0} subtract(add.43, div.58)
  broadcast_in_dim.12 = f64[1,128]{1,0} reshape(sub.32)
  mul.64 = f64[1,128]{1,0} broadcast(broadcast_in_dim.12), dimensions={0,1}
  mul.65 = f64[128]{0} reshape(mul.64)
  mul.66 = f64[128,128]{1,0} broadcast(mul.65), dimensions={1}
  mul.67 = f64[128,128]{0,1} multiply(transpose.14, mul.66)
  add.58 = f64[128,128]{0,1} add(add.55, mul.67)
  slice.11 = s32[1]{0} slice(Arg_4.1), slice={[5:6]}
  squeeze.11 = s32[] reshape(slice.11)
  add.59 = s32[128]{0} broadcast(squeeze.11), dimensions={}
  add.60 = s32[128]{0} add(convert_element_type.1, add.59)
  vmap_jit__roll_dynamic__.11 = f64[128,128]{1,0} call(Arg_0.7, add.60), to_apply=_roll_dynamic.3
  transpose.15 = f64[128,128]{0,1} transpose(vmap_jit__roll_dynamic__.11), dimensions={1,0}
  constant.33 = f64[] constant(30)
  div.31 = f64[128]{0} broadcast(constant.33), dimensions={}
  div.59 = f64[128]{0} divide(sub.20, div.31)
  div.60 = f64[128]{0} divide(mul.39, broadcast.19)
  sub.33 = f64[128]{0} subtract(div.59, div.60)
  div.61 = f64[128]{0} divide(mul.41, broadcast.18)
  add.44 = f64[128]{0} add(sub.33, div.61)
  broadcast_in_dim.13 = f64[1,128]{1,0} reshape(add.44)
  mul.68 = f64[1,128]{1,0} broadcast(broadcast_in_dim.13), dimensions={0,1}
  mul.69 = f64[128]{0} reshape(mul.68)
  mul.70 = f64[128,128]{1,0} broadcast(mul.69), dimensions={1}
  mul.71 = f64[128,128]{0,1} multiply(transpose.15, mul.70)
  ROOT add.61 = f64[128,128]{0,1} add(add.58, mul.71)
}

region_0.5 {
  reduce_sum.3 = f64[] parameter(0)
  reduce_sum.4 = f64[] parameter(1)
  ROOT reduce_sum.5 = f64[] add(reduce_sum.3, reduce_sum.4)
}

fft.6 {
  Arg_0.10 = f64[128]{0} parameter(0)
  ROOT fft.1 = c128[65]{0} fft(Arg_0.10), fft_type=RFFT, fft_length={128}
}

fft_33.7 {
  Arg_0.12 = c128[65]{0} parameter(0)
  ROOT fft.3 = f64[128]{0} fft(Arg_0.12), fft_type=IRFFT, fft_length={128}
}

solve_poisson.8 {
  Arg_0.13 = f64[128,128]{1,0} parameter(0)
  constant.50 = f64[] constant(0)
  reduce_sum.7 = f64[128]{0} reduce(Arg_0.13, constant.50), dimensions={1}, to_apply=region_0.5
  Arg_2.5 = f64[] parameter(2)
  mul.79 = f64[128]{0} broadcast(Arg_2.5), dimensions={}
  mul.80 = f64[128]{0} multiply(reduce_sum.7, mul.79)
  constant.49 = f64[] constant(1)
  sub.36 = f64[128]{0} broadcast(constant.49), dimensions={}
  sub.37 = f64[128]{0} subtract(mul.80, sub.36)
  jit_fft_.3 = c128[65]{0} call(sub.37), to_apply=fft.6
  constant.48 = c128[] constant((-0, -1))
  mul.78 = c128[65]{0} broadcast(constant.48), dimensions={}
  mul.81 = c128[65]{0} multiply(jit_fft_.3, mul.78)
  Arg_1.9 = f64[65]{0} parameter(1)
  convert_element_type.4 = c128[65]{0} convert(Arg_1.9)
  mul.82 = c128[65]{0} multiply(mul.81, convert_element_type.4)
  jit_fft_.4 = f64[128]{0} call(mul.82), to_apply=fft_33.7
  integer_pow.1 = f64[65]{0} multiply(Arg_1.9, Arg_1.9)
  convert_element_type.5 = c128[65]{0} convert(integer_pow.1)
  mul.83 = c128[65]{0} multiply(jit_fft_.3, convert_element_type.5)
  jit_fft_.5 = f64[128]{0} call(mul.83), to_apply=fft_33.7
  ROOT tuple.1 = (f64[128]{0}, f64[128]{0}, f64[128]{0}) tuple(jit_fft_.4, sub.37, jit_fft_.5)
}

_where_46.9 {
  Arg_0.17 = pred[6,128,128]{2,1,0} parameter(0)
  Arg_1.13 = f64[6,128,1]{2,1,0} parameter(1)
  broadcast_in_dim.29 = f64[6,128,1]{2,1,0} broadcast(Arg_1.13), dimensions={0,1,2}
  broadcast_in_dim.30 = f64[6,128]{1,0} reshape(broadcast_in_dim.29)
  broadcast_in_dim.31 = f64[6,128,128]{2,1,0} broadcast(broadcast_in_dim.30), dimensions={0,1}
  Arg_2.9 = f64[] parameter(2)
  broadcast_in_dim.32 = f64[6,128,128]{2,1,0} broadcast(Arg_2.9), dimensions={}
  ROOT select_n.7 = f64[6,128,128]{2,1,0} select(Arg_0.17, broadcast_in_dim.31, broadcast_in_dim.32)
}

build_v_diag_weights.10 {
  iota.1 = s64[128]{0} iota(), iota_dimension=0
  broadcast_in_dim.41 = s64[1,1,128]{2,1,0} reshape(iota.1)
  sub.74 = s64[1,1,128]{2,1,0} broadcast(broadcast_in_dim.41), dimensions={0,1,2}
  sub.75 = s64[128]{0} reshape(sub.74)
  sub.76 = s64[6,128,128]{2,1,0} broadcast(sub.75), dimensions={2}
  Arg_0.18 = s32[6]{0} parameter(0)
  broadcast_in_dim.39 = s32[6,1]{1,0} reshape(Arg_0.18)
  add.89 = s32[6,1]{1,0} broadcast(broadcast_in_dim.39), dimensions={0,1}
  add.90 = s32[6]{0} reshape(add.89)
  add.91 = s32[6,128]{1,0} broadcast(add.90), dimensions={0}
  Arg_1.14 = s32[128]{0} parameter(1)
  broadcast_in_dim.40 = s32[1,128]{1,0} reshape(Arg_1.14)
  add.92 = s32[1,128]{1,0} broadcast(broadcast_in_dim.40), dimensions={0,1}
  add.93 = s32[128]{0} reshape(add.92)
  add.94 = s32[6,128]{1,0} broadcast(add.93), dimensions={1}
  add.95 = s32[6,128]{1,0} add(add.91, add.94)
  broadcast_in_dim.42 = s32[6,128,1]{2,1,0} reshape(add.95)
  convert_element_type.8 = s64[6,128,1]{2,1,0} convert(broadcast_in_dim.42)
  sub.77 = s64[6,128,1]{2,1,0} broadcast(convert_element_type.8), dimensions={0,1,2}
  sub.78 = s64[6,128]{1,0} reshape(sub.77)
  sub.79 = s64[6,128,128]{2,1,0} broadcast(sub.78), dimensions={0,1}
  sub.80 = s64[6,128,128]{2,1,0} subtract(sub.76, sub.79)
  constant.67 = s64[] constant(0)
  ge.2 = s64[6,128,128]{2,1,0} broadcast(constant.67), dimensions={}
  ge.3 = pred[6,128,128]{2,1,0} compare(sub.80, ge.2), direction=GE
  constant.66 = s64[] constant(128)
  lt.10 = s64[6,128,128]{2,1,0} broadcast(constant.66), dimensions={}
  lt.11 = pred[6,128,128]{2,1,0} compare(sub.80, lt.10), direction=LT
  and.3 = pred[6,128,128]{2,1,0} and(ge.3, lt.11)
  Arg_2.10 = f64[128]{0} parameter(2)
  constant.79 = f64[] constant(20)
  div.94 = f64[128]{0} broadcast(constant.79), dimensions={}
  div.95 = f64[128]{0} divide(Arg_2.10, div.94)
  mul.96 = f64[128]{0} multiply(Arg_2.10, Arg_2.10)
  constant.78 = f64[] constant(24)
  broadcast.37 = f64[128]{0} broadcast(constant.78), dimensions={}
  div.96 = f64[128]{0} divide(mul.96, broadcast.37)
  sub.61 = f64[128]{0} subtract(div.95, div.96)
  mul.97 = f64[128]{0} multiply(mul.96, Arg_2.10)
  div.97 = f64[128]{0} divide(mul.97, broadcast.37)
  sub.62 = f64[128]{0} subtract(sub.61, div.97)
  mul.98 = f64[128]{0} multiply(mul.97, Arg_2.10)
  div.98 = f64[128]{0} divide(mul.98, broadcast.37)
  add.79 = f64[128]{0} add(sub.62, div.98)
  mul.99 = f64[128]{0} multiply(mul.98, Arg_2.10)
  constant.77 = f64[] constant(120)
  broadcast.36 = f64[128]{0} broadcast(constant.77), dimensions={}
  div.99 = f64[128]{0} divide(mul.99, broadcast.36)
  sub.63 = f64[128]{0} subtract(add.79, div.99)
  broadcast_in_dim.33 = f64[1,128]{1,0} reshape(sub.63)
  constant.76 = f64[] constant(2)
  broadcast.35 = f64[128]{0} broadcast(constant.76), dimensions={}
  div.100 = f64[128]{0} divide(Arg_2.10, broadcast.35)
  neg.6 = f64[128]{0} negate(div.100)
  mul.100 = f64[128]{0} multiply(mul.96, broadcast.35)
  constant.75 = f64[] constant(3)
  broadcast.34 = f64[128]{0} broadcast(constant.75), dimensions={}
  div.101 = f64[128]{0} divide(mul.100, broadcast.34)
  add.80 = f64[128]{0} add(neg.6, div.101)
  div.102 = f64[128]{0} divide(mul.97, broadcast.37)
  sub.64 = f64[128]{0} subtract(add.80, div.102)
  constant.74 = f64[] constant(6)
  broadcast.33 = f64[128]{0} broadcast(constant.74), dimensions={}
  div.103 = f64[128]{0} divide(mul.98, broadcast.33)
  sub.65 = f64[128]{0} subtract(sub.64, div.103)
  div.104 = f64[128]{0} divide(mul.99, broadcast.37)
  add.81 = f64[128]{0} add(sub.65, div.104)
  broadcast_in_dim.34 = f64[1,128]{1,0} reshape(add.81)
  constant.73 = f64[] constant(1)
  sub.60 = f64[128]{0} broadcast(constant.73), dimensions={}
  div.105 = f64[128]{0} divide(Arg_2.10, broadcast.34)
  sub.66 = f64[128]{0} subtract(sub.60, div.105)
  constant.72 = f64[] constant(5)
  broadcast.32 = f64[128]{0} broadcast(constant.72), dimensions={}
  mul.101 = f64[128]{0} multiply(mul.96, broadcast.32)
  constant.71 = f64[] constant(4)
  broadcast.31 = f64[128]{0} broadcast(constant.71), dimensions={}
  div.106 = f64[128]{0} divide(mul.101, broadcast.31)
  sub.67 = f64[128]{0} subtract(sub.66, div.106)
  mul.102 = f64[128]{0} multiply(mul.97, broadcast.32)
  constant.70 = f64[] constant(12)
  broadcast.30 = f64[128]{0} broadcast(constant.70), dimensions={}
  div.107 = f64[128]{0} divide(mul.102, broadcast.30)
  add.82 = f64[128]{0} add(sub.67, div.107)
  div.108 = f64[128]{0} divide(mul.98, broadcast.31)
  add.83 = f64[128]{0} add(add.82, div.108)
  div.109 = f64[128]{0} divide(mul.99, broadcast.30)
  sub.68 = f64[128]{0} subtract(add.83, div.109)
  broadcast_in_dim.35 = f64[1,128]{1,0} reshape(sub.68)
  mul.103 = f64[128]{0} multiply(mul.96, broadcast.35)
  div.110 = f64[128]{0} divide(mul.103, broadcast.34)
  add.84 = f64[128]{0} add(Arg_2.10, div.110)
  constant.69 = f64[] constant(7)
  broadcast.29 = f64[128]{0} broadcast(constant.69), dimensions={}
  mul.104 = f64[128]{0} multiply(mul.97, broadcast.29)
  div.111 = f64[128]{0} divide(mul.104, broadcast.30)
  sub.69 = f64[128]{0} subtract(add.84, div.111)
  div.112 = f64[128]{0} divide(mul.98, broadcast.33)
  sub.70 = f64[128]{0} subtract(sub.69, div.112)
  div.113 = f64[128]{0} divide(mul.99, broadcast.30)
  add.85 = f64[128]{0} add(sub.70, div.113)
  broadcast_in_dim.36 = f64[1,128]{1,0} reshape(add.85)
  div.114 = f64[128]{0} divide(Arg_2.10, broadcast.31)
  neg.7 = f64[128]{0} negate(div.114)
  div.115 = f64[128]{0} divide(mul.96, broadcast.37)
  sub.71 = f64[128]{0} subtract(neg.7, div.115)
  mul.105 = f64[128]{0} multiply(mul.97, broadcast.29)
  div.116 = f64[128]{0} divide(mul.105, broadcast.37)
  add.86 = f64[128]{0} add(sub.71, div.116)
  div.117 = f64[128]{0} divide(mul.98, broadcast.37)
  add.87 = f64[128]{0} add(add.86, div.117)
  div.118 = f64[128]{0} divide(mul.99, broadcast.37)
  sub.72 = f64[128]{0} subtract(add.87, div.118)
  broadcast_in_dim.37 = f64[1,128]{1,0} reshape(sub.72)
  constant.68 = f64[] constant(30)
  div.93 = f64[128]{0} broadcast(constant.68), dimensions={}
  div.119 = f64[128]{0} divide(Arg_2.10, div.93)
  div.120 = f64[128]{0} divide(mul.97, broadcast.37)
  sub.73 = f64[128]{0} subtract(div.119, div.120)
  div.121 = f64[128]{0} divide(mul.99, broadcast.36)
  add.88 = f64[128]{0} add(sub.73, div.121)
  broadcast_in_dim.38 = f64[1,128]{1,0} reshape(add.88)
  concatenate.3 = f64[6,128]{1,0} concatenate(broadcast_in_dim.33, broadcast_in_dim.34, broadcast_in_dim.35, broadcast_in_dim.36, broadcast_in_dim.37, broadcast_in_dim.38), dimensions={0}
  broadcast_in_dim.43 = f64[6,128,1]{2,1,0} reshape(concatenate.3)
  constant.80 = f64[] constant(0)
  ROOT jit__where_.3 = f64[6,128,128]{2,1,0} call(and.3, broadcast_in_dim.43, constant.80), to_apply=_where_46.9
}

_roll_dynamic_50.11 {
  Arg_0.20 = f64[128,128]{1,0} parameter(0)
  concatenate.5 = f64[128,256]{1,0} concatenate(Arg_0.20, Arg_0.20), dimensions={1}
  constant.87 = s32[] constant(128)
  sub.83 = s32[128]{0} broadcast(constant.87), dimensions={}
  Arg_1.16 = s32[128]{0} parameter(1)
  constant.88 = s32[] constant(128)
  jit_remainder_.3 = s32[128]{0} call(Arg_1.16, constant.88), to_apply=remainder.2
  sub.84 = s32[128]{0} subtract(sub.83, jit_remainder_.3)
  constant.86 = s32[] constant(0)
  lt.14 = s32[128]{0} broadcast(constant.86), dimensions={}
  lt.15 = pred[128]{0} compare(sub.84, lt.14), direction=LT
  constant.85 = s32[] constant(256)
  add.100 = s32[128]{0} broadcast(constant.85), dimensions={}
  add.101 = s32[128]{0} add(sub.84, add.100)
  select_n.9 = s32[128]{0} select(lt.15, add.101, sub.84)
  broadcast_in_dim.45 = s32[128,1]{1,0} reshape(select_n.9)
  ROOT gather.3 = f64[128,128]{1,0} gather(concatenate.5, broadcast_in_dim.45), offset_dims={1}, collapsed_slice_dims={}, start_index_map={1}, operand_batching_dims={0}, start_indices_batching_dims={0}, index_vector_dim=1, slice_sizes={1,128}, indices_are_sorted=true
}

advect_1d_matrix_diag_35.12 {
  Arg_4.3 = s32[6]{0} parameter(4)
  Arg_1.17 = f64[128]{0} parameter(1)
  Arg_2.11 = f64[] parameter(2)
  mul.112 = f64[128]{0} broadcast(Arg_2.11), dimensions={}
  mul.113 = f64[128]{0} multiply(Arg_1.17, mul.112)
  Arg_3.3 = f64[] parameter(3)
  div.122 = f64[128]{0} broadcast(Arg_3.3), dimensions={}
  div.123 = f64[128]{0} divide(mul.113, div.122)
  floor.3 = f64[128]{0} floor(div.123)
  convert_element_type.9 = s32[128]{0} convert(floor.3)
  sub.85 = f64[128]{0} subtract(div.123, floor.3)
  jit_build_v_diag_weights_.1 = f64[6,128,128]{2,1,0} call(Arg_4.3, convert_element_type.9, sub.85), to_apply=build_v_diag_weights.10
  slice.25 = f64[1,128,128]{2,1,0} slice(jit_build_v_diag_weights_.1), slice={[0:1], [0:128], [0:128]}
  squeeze.25 = f64[128,128]{1,0} reshape(slice.25)
  Arg_0.21 = f64[128,128]{1,0} parameter(0)
  slice.24 = s32[1]{0} slice(Arg_4.3), slice={[0:1]}
  squeeze.24 = s32[] reshape(slice.24)
  add.117 = s32[128]{0} broadcast(squeeze.24), dimensions={}
  add.118 = s32[128]{0} add(convert_element_type.9, add.117)
  vmap_jit__roll_dynamic__.18 = f64[128,128]{1,0} call(Arg_0.21, add.118), to_apply=_roll_dynamic_50.11
  mul.114 = f64[128,128]{1,0} multiply(squeeze.25, vmap_jit__roll_dynamic__.18)
  slice.27 = f64[1,128,128]{2,1,0} slice(jit_build_v_diag_weights_.1), slice={[1:2], [0:128], [0:128]}
  squeeze.27 = f64[128,128]{1,0} reshape(slice.27)
  slice.26 = s32[1]{0} slice(Arg_4.3), slice={[1:2]}
  squeeze.26 = s32[] reshape(slice.26)
  add.119 = s32[128]{0} broadcast(squeeze.26), dimensions={}
  add.120 = s32[128]{0} add(convert_element_type.9, add.119)
  vmap_jit__roll_dynamic__.19 = f64[128,128]{1,0} call(Arg_0.21, add.120), to_apply=_roll_dynamic_50.11
  mul.115 = f64[128,128]{1,0} multiply(squeeze.27, vmap_jit__roll_dynamic__.19)
  add.121 = f64[128,128]{1,0} add(mul.114, mul.115)
  slice.29 = f64[1,128,128]{2,1,0} slice(jit_build_v_diag_weights_.1), slice={[2:3], [0:128], [0:128]}
  squeeze.29 = f64[128,128]{1,0} reshape(slice.29)
  slice.28 = s32[1]{0} slice(Arg_4.3), slice={[2:3]}
  squeeze.28 = s32[] reshape(slice.28)
  add.122 = s32[128]{0} broadcast(squeeze.28), dimensions={}
  add.123 = s32[128]{0} add(convert_element_type.9, add.122)
  vmap_jit__roll_dynamic__.20 = f64[128,128]{1,0} call(Arg_0.21, add.123), to_apply=_roll_dynamic_50.11
  mul.116 = f64[128,128]{1,0} multiply(squeeze.29, vmap_jit__roll_dynamic__.20)
  add.124 = f64[128,128]{1,0} add(add.121, mul.116)
  slice.31 = f64[1,128,128]{2,1,0} slice(jit_build_v_diag_weights_.1), slice={[3:4], [0:128], [0:128]}
  squeeze.31 = f64[128,128]{1,0} reshape(slice.31)
  slice.30 = s32[1]{0} slice(Arg_4.3), slice={[3:4]}
  squeeze.30 = s32[] reshape(slice.30)
  add.125 = s32[128]{0} broadcast(squeeze.30), dimensions={}
  add.126 = s32[128]{0} add(convert_element_type.9, add.125)
  vmap_jit__roll_dynamic__.21 = f64[128,128]{1,0} call(Arg_0.21, add.126), to_apply=_roll_dynamic_50.11
  mul.117 = f64[128,128]{1,0} multiply(squeeze.31, vmap_jit__roll_dynamic__.21)
  add.127 = f64[128,128]{1,0} add(add.124, mul.117)
  slice.33 = f64[1,128,128]{2,1,0} slice(jit_build_v_diag_weights_.1), slice={[4:5], [0:128], [0:128]}
  squeeze.33 = f64[128,128]{1,0} reshape(slice.33)
  slice.32 = s32[1]{0} slice(Arg_4.3), slice={[4:5]}
  squeeze.32 = s32[] reshape(slice.32)
  add.128 = s32[128]{0} broadcast(squeeze.32), dimensions={}
  add.129 = s32[128]{0} add(convert_element_type.9, add.128)
  vmap_jit__roll_dynamic__.22 = f64[128,128]{1,0} call(Arg_0.21, add.129), to_apply=_roll_dynamic_50.11
  mul.118 = f64[128,128]{1,0} multiply(squeeze.33, vmap_jit__roll_dynamic__.22)
  add.130 = f64[128,128]{1,0} add(add.127, mul.118)
  slice.35 = f64[1,128,128]{2,1,0} slice(jit_build_v_diag_weights_.1), slice={[5:6], [0:128], [0:128]}
  squeeze.35 = f64[128,128]{1,0} reshape(slice.35)
  slice.34 = s32[1]{0} slice(Arg_4.3), slice={[5:6]}
  squeeze.34 = s32[] reshape(slice.34)
  add.131 = s32[128]{0} broadcast(squeeze.34), dimensions={}
  add.132 = s32[128]{0} add(convert_element_type.9, add.131)
  vmap_jit__roll_dynamic__.23 = f64[128,128]{1,0} call(Arg_0.21, add.132), to_apply=_roll_dynamic_50.11
  mul.119 = f64[128,128]{1,0} multiply(squeeze.35, vmap_jit__roll_dynamic__.23)
  ROOT add.133 = f64[128,128]{1,0} add(add.130, mul.119)
}

ENTRY main.13 {
  carry_0_.1 = f64[128,128]{1,0} parameter(0)
  constant.91 = f64[128]{0} constant({...})
  constant.94 = f64[] constant(0.025)
  constant.95 = f64[] constant(0.098174770424681035)
  constant.92 = s32[6]{0} constant({-2, -1, 0, 1, 2, 3})
  jit_advect_1d_matrix_diag_.3 = f64[128,128]{0,1} call(carry_0_.1, constant.91, constant.94, constant.95, constant.92), to_apply=advect_1d_matrix_diag.4
  constant.93 = f64[65]{0} constant({...})
  constant.90 = f64[] constant(0.07874015748031496)
  jit_solve_poisson_.4 = (f64[128]{0}, f64[128]{0}, f64[128]{0}) call(jit_advect_1d_matrix_diag_.3, constant.93, constant.90), to_apply=solve_poisson.8
  jit_solve_poisson_.5 = f64[128]{0} get-tuple-element(jit_solve_poisson_.4), index=0
  constant.89 = f64[] constant(0.05)
  jit_advect_1d_matrix_diag_.4 = f64[128,128]{1,0} call(jit_advect_1d_matrix_diag_.3, jit_solve_poisson_.5, constant.89, constant.90, constant.92), to_apply=advect_1d_matrix_diag_35.12
  jit_advect_1d_matrix_diag_.5 = f64[128,128]{0,1} call(jit_advect_1d_matrix_diag_.4, constant.91, constant.94, constant.95, constant.92), to_apply=advect_1d_matrix_diag.4
  jit_solve_poisson_.6 = f64[128]{0} get-tuple-element(jit_solve_poisson_.4), index=1
  jit_solve_poisson_.7 = f64[128]{0} get-tuple-element(jit_solve_poisson_.4), index=2
  ROOT tuple.3 = (f64[128,128]{0,1}, f64[128]{0}, f64[128]{0}) tuple(jit_advect_1d_matrix_diag_.5, jit_solve_poisson_.6, jit_solve_poisson_.7)
}

