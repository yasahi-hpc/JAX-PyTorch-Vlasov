HloModule jit_heat_step, entry_computation_layout={(f64[32,32,32]{2,1,0}, f64[])->f64[32,32,32]{2,1,0}}

_where.1 {
  Arg_0.3 = pred[] parameter(0)
  Arg_1.3 = s64[] parameter(1)
  Arg_2.1 = s64[] parameter(2)
  ROOT select_n.1 = s64[] select(Arg_0.3, Arg_1.3, Arg_2.1)
}

remainder.2 {
  Arg_0.4 = s64[32]{0} parameter(0)
  Arg_1.4 = s64[] parameter(1)
  constant.8 = s64[] constant(0)
  eq.1 = pred[] compare(Arg_1.4, constant.8), direction=EQ
  constant.7 = s64[] constant(1)
  jit__where_.1 = s64[] call(eq.1, constant.7, Arg_1.4), to_apply=_where.1
  rem.2 = s64[32]{0} broadcast(jit__where_.1), dimensions={}
  rem.3 = s64[32]{0} remainder(Arg_0.4, rem.2)
  constant.6 = s64[] constant(0)
  broadcast.2 = s64[32]{0} broadcast(constant.6), dimensions={}
  lt.2 = pred[32]{0} compare(rem.3, broadcast.2), direction=LT
  lt.3 = pred[] compare(jit__where_.1, constant.8), direction=LT
  ne.4 = pred[32]{0} broadcast(lt.3), dimensions={}
  ne.5 = pred[32]{0} compare(lt.2, ne.4), direction=NE
  ne.3 = pred[32]{0} compare(rem.3, broadcast.2), direction=NE
  and.1 = pred[32]{0} and(ne.5, ne.3)
  add.3 = s64[32]{0} broadcast(jit__where_.1), dimensions={}
  add.4 = s64[32]{0} add(rem.3, add.3)
  ROOT select_n.3 = s64[32]{0} select(and.1, add.4, rem.3)
}

_where_3.3 {
  Arg_0.7 = pred[32]{0} parameter(0)
  Arg_1.7 = s64[32]{0} parameter(1)
  Arg_2.3 = s64[32]{0} parameter(2)
  ROOT select_n.5 = s64[32]{0} select(Arg_0.7, Arg_1.7, Arg_2.3)
}

region_0.4 {
  reduce_and.3 = pred[] parameter(0)
  reduce_and.4 = pred[] parameter(1)
  ROOT reduce_and.5 = pred[] and(reduce_and.3, reduce_and.4)
}

_take.5 {
  Arg_1.8 = s64[32]{0} parameter(1)
  constant.20 = s64[] constant(0)
  lt.6 = s64[32]{0} broadcast(constant.20), dimensions={}
  lt.7 = pred[32]{0} compare(Arg_1.8, lt.6), direction=LT
  constant.18 = s64[] constant(32)
  add.7 = s64[32]{0} broadcast(constant.18), dimensions={}
  add.8 = s64[32]{0} add(Arg_1.8, add.7)
  jit__where_.3 = s64[32]{0} call(lt.7, add.8, Arg_1.8), to_apply=_where_3.3
  broadcast_in_dim.4 = s64[32,1]{1,0} reshape(jit__where_.3)
  convert_element_type.1 = s32[32,1]{1,0} convert(broadcast_in_dim.4)
  constant.17 = s32[] constant(0)
  ge.2 = s32[32,1]{1,0} broadcast(constant.17), dimensions={}
  ge.3 = pred[32,1]{1,0} compare(convert_element_type.1, ge.2), direction=GE
  constant.16 = s32[] constant(31)
  le.2 = s32[32,1]{1,0} broadcast(constant.16), dimensions={}
  le.3 = pred[32,1]{1,0} compare(convert_element_type.1, le.2), direction=LE
  and.3 = pred[32,1]{1,0} and(ge.3, le.3)
  constant.19 = pred[] constant(true)
  reduce_and.7 = pred[32]{0} reduce(and.3, constant.19), dimensions={1}, to_apply=region_0.4
  broadcast_in_dim.5 = pred[32,32,32]{2,1,0} broadcast(reduce_and.7), dimensions={0}
  Arg_0.8 = f64[32,32,32]{2,1,0} parameter(0)
  gather.1 = f64[32,32,32]{2,1,0} gather(Arg_0.8, convert_element_type.1), offset_dims={1,2}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1,32,32}
  constant.15 = f64[] constant(nan)
  broadcast_in_dim.3 = f64[32,32,32]{2,1,0} broadcast(constant.15), dimensions={}
  ROOT select_n.7 = f64[32,32,32]{2,1,0} select(broadcast_in_dim.5, gather.1, broadcast_in_dim.3)
}

region_1.6 {
  reduce_and.11 = pred[] parameter(0)
  reduce_and.12 = pred[] parameter(1)
  ROOT reduce_and.13 = pred[] and(reduce_and.11, reduce_and.12)
}

_take_11.7 {
  Arg_1.10 = s64[32]{0} parameter(1)
  constant.32 = s64[] constant(0)
  lt.10 = s64[32]{0} broadcast(constant.32), dimensions={}
  lt.11 = pred[32]{0} compare(Arg_1.10, lt.10), direction=LT
  constant.30 = s64[] constant(32)
  add.12 = s64[32]{0} broadcast(constant.30), dimensions={}
  add.13 = s64[32]{0} add(Arg_1.10, add.12)
  jit__where_.5 = s64[32]{0} call(lt.11, add.13, Arg_1.10), to_apply=_where_3.3
  broadcast_in_dim.10 = s64[32,1]{1,0} reshape(jit__where_.5)
  convert_element_type.3 = s32[32,1]{1,0} convert(broadcast_in_dim.10)
  constant.29 = s32[] constant(0)
  ge.6 = s32[32,1]{1,0} broadcast(constant.29), dimensions={}
  ge.7 = pred[32,1]{1,0} compare(convert_element_type.3, ge.6), direction=GE
  constant.28 = s32[] constant(31)
  le.6 = s32[32,1]{1,0} broadcast(constant.28), dimensions={}
  le.7 = pred[32,1]{1,0} compare(convert_element_type.3, le.6), direction=LE
  and.5 = pred[32,1]{1,0} and(ge.7, le.7)
  constant.31 = pred[] constant(true)
  reduce_and.15 = pred[32]{0} reduce(and.5, constant.31), dimensions={1}, to_apply=region_1.6
  broadcast_in_dim.11 = pred[32,32,32]{2,1,0} broadcast(reduce_and.15), dimensions={1}
  Arg_0.10 = f64[32,32,32]{2,1,0} parameter(0)
  gather.3 = f64[32,32,32]{2,1,0} gather(Arg_0.10, convert_element_type.3), offset_dims={0,2}, collapsed_slice_dims={1}, start_index_map={1}, index_vector_dim=1, slice_sizes={32,1,32}
  constant.27 = f64[] constant(nan)
  broadcast_in_dim.9 = f64[32,32,32]{2,1,0} broadcast(constant.27), dimensions={}
  ROOT select_n.9 = f64[32,32,32]{2,1,0} select(broadcast_in_dim.11, gather.3, broadcast_in_dim.9)
}

region_2.8 {
  reduce_and.19 = pred[] parameter(0)
  reduce_and.20 = pred[] parameter(1)
  ROOT reduce_and.21 = pred[] and(reduce_and.19, reduce_and.20)
}

_take_15.9 {
  Arg_1.12 = s64[32]{0} parameter(1)
  constant.44 = s64[] constant(0)
  lt.14 = s64[32]{0} broadcast(constant.44), dimensions={}
  lt.15 = pred[32]{0} compare(Arg_1.12, lt.14), direction=LT
  constant.42 = s64[] constant(32)
  add.17 = s64[32]{0} broadcast(constant.42), dimensions={}
  add.18 = s64[32]{0} add(Arg_1.12, add.17)
  jit__where_.7 = s64[32]{0} call(lt.15, add.18, Arg_1.12), to_apply=_where_3.3
  broadcast_in_dim.16 = s64[32,1]{1,0} reshape(jit__where_.7)
  convert_element_type.5 = s32[32,1]{1,0} convert(broadcast_in_dim.16)
  constant.41 = s32[] constant(0)
  ge.10 = s32[32,1]{1,0} broadcast(constant.41), dimensions={}
  ge.11 = pred[32,1]{1,0} compare(convert_element_type.5, ge.10), direction=GE
  constant.40 = s32[] constant(31)
  le.10 = s32[32,1]{1,0} broadcast(constant.40), dimensions={}
  le.11 = pred[32,1]{1,0} compare(convert_element_type.5, le.10), direction=LE
  and.7 = pred[32,1]{1,0} and(ge.11, le.11)
  constant.43 = pred[] constant(true)
  reduce_and.23 = pred[32]{0} reduce(and.7, constant.43), dimensions={1}, to_apply=region_2.8
  broadcast_in_dim.17 = pred[32,32,32]{2,1,0} broadcast(reduce_and.23), dimensions={2}
  Arg_0.12 = f64[32,32,32]{2,1,0} parameter(0)
  gather.5 = f64[32,32,32]{2,1,0} gather(Arg_0.12, convert_element_type.5), offset_dims={0,1}, collapsed_slice_dims={2}, start_index_map={2}, index_vector_dim=1, slice_sizes={32,32,1}
  constant.39 = f64[] constant(nan)
  broadcast_in_dim.15 = f64[32,32,32]{2,1,0} broadcast(constant.39), dimensions={}
  ROOT select_n.11 = f64[32,32,32]{2,1,0} select(broadcast_in_dim.17, gather.5, broadcast_in_dim.15)
}

heat_step.10 {
  Arg_0.13 = f64[32,32,32]{2,1,0} parameter(0)
  Arg_1.13 = f64[] parameter(1)
  mul.6 = f64[32,32,32]{2,1,0} broadcast(Arg_1.13), dimensions={}
  iota.6 = s64[32]{0} iota(), iota_dimension=0
  constant.46 = s64[] constant(1)
  broadcast.3 = s64[32]{0} broadcast(constant.46), dimensions={}
  add.25 = s64[32]{0} add(iota.6, broadcast.3)
  constant.47 = s64[] constant(32)
  jit_remainder_.6 = s64[32]{0} call(add.25, constant.47), to_apply=remainder.2
  jit__take_.6 = f64[32,32,32]{2,1,0} call(Arg_0.13, jit_remainder_.6), to_apply=_take.5
  iota.7 = s64[32]{0} iota(), iota_dimension=0
  sub.4 = s64[32]{0} subtract(iota.7, broadcast.3)
  jit_remainder_.7 = s64[32]{0} call(sub.4, constant.47), to_apply=remainder.2
  jit__take_.7 = f64[32,32,32]{2,1,0} call(Arg_0.13, jit_remainder_.7), to_apply=_take.5
  add.28 = f64[32,32,32]{2,1,0} add(jit__take_.6, jit__take_.7)
  iota.8 = s64[32]{0} iota(), iota_dimension=0
  add.26 = s64[32]{0} add(iota.8, broadcast.3)
  jit_remainder_.8 = s64[32]{0} call(add.26, constant.47), to_apply=remainder.2
  jit__take_.8 = f64[32,32,32]{2,1,0} call(Arg_0.13, jit_remainder_.8), to_apply=_take_11.7
  add.29 = f64[32,32,32]{2,1,0} add(add.28, jit__take_.8)
  iota.9 = s64[32]{0} iota(), iota_dimension=0
  sub.5 = s64[32]{0} subtract(iota.9, broadcast.3)
  jit_remainder_.9 = s64[32]{0} call(sub.5, constant.47), to_apply=remainder.2
  jit__take_.9 = f64[32,32,32]{2,1,0} call(Arg_0.13, jit_remainder_.9), to_apply=_take_11.7
  add.30 = f64[32,32,32]{2,1,0} add(add.29, jit__take_.9)
  iota.10 = s64[32]{0} iota(), iota_dimension=0
  add.27 = s64[32]{0} add(iota.10, broadcast.3)
  jit_remainder_.10 = s64[32]{0} call(add.27, constant.47), to_apply=remainder.2
  jit__take_.10 = f64[32,32,32]{2,1,0} call(Arg_0.13, jit_remainder_.10), to_apply=_take_15.9
  add.31 = f64[32,32,32]{2,1,0} add(add.30, jit__take_.10)
  iota.11 = s64[32]{0} iota(), iota_dimension=0
  sub.6 = s64[32]{0} subtract(iota.11, broadcast.3)
  jit_remainder_.11 = s64[32]{0} call(sub.6, constant.47), to_apply=remainder.2
  jit__take_.11 = f64[32,32,32]{2,1,0} call(Arg_0.13, jit_remainder_.11), to_apply=_take_15.9
  add.32 = f64[32,32,32]{2,1,0} add(add.31, jit__take_.11)
  constant.45 = f64[] constant(6)
  mul.4 = f64[32,32,32]{2,1,0} broadcast(constant.45), dimensions={}
  mul.5 = f64[32,32,32]{2,1,0} multiply(Arg_0.13, mul.4)
  sub.7 = f64[32,32,32]{2,1,0} subtract(add.32, mul.5)
  mul.7 = f64[32,32,32]{2,1,0} multiply(mul.6, sub.7)
  ROOT add.33 = f64[32,32,32]{2,1,0} add(Arg_0.13, mul.7)
}

ENTRY main.11 {
  u.1 = f64[32,32,32]{2,1,0} parameter(0)
  coeff.1 = f64[] parameter(1)
  ROOT jit_heat_step_.1 = f64[32,32,32]{2,1,0} call(u.1, coeff.1), to_apply=heat_step.10
}

