HloModule jit_run_chunk, entry_computation_layout={(f32[32,32,32]{2,1,0}, f32[], s32[])->(f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,32,32]{2,1,0}, f32[], /*index=5*/s32[])}

_where.1 {
  Arg_0.4 = pred[] parameter(0)
  Arg_1.3 = s32[] parameter(1)
  Arg_2.1 = s32[] parameter(2)
  ROOT select_n.1 = s32[] select(Arg_0.4, Arg_1.3, Arg_2.1)
}

remainder.2 {
  Arg_0.5 = s32[32]{0} parameter(0)
  Arg_1.4 = s32[] parameter(1)
  constant.14 = s32[] constant(0)
  eq.1 = pred[] compare(Arg_1.4, constant.14), direction=EQ
  constant.13 = s32[] constant(1)
  jit__where_.1 = s32[] call(eq.1, constant.13, Arg_1.4), to_apply=_where.1
  rem.2 = s32[32]{0} broadcast(jit__where_.1), dimensions={}
  rem.3 = s32[32]{0} remainder(Arg_0.5, rem.2)
  constant.12 = s32[] constant(0)
  broadcast.2 = s32[32]{0} broadcast(constant.12), dimensions={}
  lt.2 = pred[32]{0} compare(rem.3, broadcast.2), direction=LT
  lt.3 = pred[] compare(jit__where_.1, constant.14), direction=LT
  ne.4 = pred[32]{0} broadcast(lt.3), dimensions={}
  ne.5 = pred[32]{0} compare(lt.2, ne.4), direction=NE
  ne.3 = pred[32]{0} compare(rem.3, broadcast.2), direction=NE
  and.1 = pred[32]{0} and(ne.5, ne.3)
  add.3 = s32[32]{0} broadcast(jit__where_.1), dimensions={}
  add.4 = s32[32]{0} add(rem.3, add.3)
  ROOT select_n.3 = s32[32]{0} select(and.1, add.4, rem.3)
}

_where_4.3 {
  Arg_0.8 = pred[32]{0} parameter(0)
  Arg_1.7 = s32[32]{0} parameter(1)
  Arg_2.3 = s32[32]{0} parameter(2)
  ROOT select_n.5 = s32[32]{0} select(Arg_0.8, Arg_1.7, Arg_2.3)
}

region_1.4 {
  reduce_and.3 = pred[] parameter(0)
  reduce_and.4 = pred[] parameter(1)
  ROOT reduce_and.5 = pred[] and(reduce_and.3, reduce_and.4)
}

_take.5 {
  Arg_1.8 = s32[32]{0} parameter(1)
  constant.26 = s32[] constant(0)
  lt.6 = s32[32]{0} broadcast(constant.26), dimensions={}
  lt.7 = pred[32]{0} compare(Arg_1.8, lt.6), direction=LT
  constant.24 = s32[] constant(32)
  add.7 = s32[32]{0} broadcast(constant.24), dimensions={}
  add.8 = s32[32]{0} add(Arg_1.8, add.7)
  jit__where_.3 = s32[32]{0} call(lt.7, add.8, Arg_1.8), to_apply=_where_4.3
  broadcast_in_dim.4 = s32[32,1]{1,0} reshape(jit__where_.3)
  constant.23 = s32[] constant(0)
  ge.2 = s32[32,1]{1,0} broadcast(constant.23), dimensions={}
  ge.3 = pred[32,1]{1,0} compare(broadcast_in_dim.4, ge.2), direction=GE
  constant.22 = s32[] constant(31)
  le.2 = s32[32,1]{1,0} broadcast(constant.22), dimensions={}
  le.3 = pred[32,1]{1,0} compare(broadcast_in_dim.4, le.2), direction=LE
  and.3 = pred[32,1]{1,0} and(ge.3, le.3)
  constant.25 = pred[] constant(true)
  reduce_and.7 = pred[32]{0} reduce(and.3, constant.25), dimensions={1}, to_apply=region_1.4
  broadcast_in_dim.5 = pred[32,32,32]{2,1,0} broadcast(reduce_and.7), dimensions={0}
  Arg_0.9 = f32[32,32,32]{2,1,0} parameter(0)
  gather.1 = f32[32,32,32]{2,1,0} gather(Arg_0.9, broadcast_in_dim.4), offset_dims={1,2}, collapsed_slice_dims={0}, start_index_map={0}, index_vector_dim=1, slice_sizes={1,32,32}
  constant.21 = f32[] constant(nan)
  broadcast_in_dim.3 = f32[32,32,32]{2,1,0} broadcast(constant.21), dimensions={}
  ROOT select_n.7 = f32[32,32,32]{2,1,0} select(broadcast_in_dim.5, gather.1, broadcast_in_dim.3)
}

region_2.6 {
  reduce_and.11 = pred[] parameter(0)
  reduce_and.12 = pred[] parameter(1)
  ROOT reduce_and.13 = pred[] and(reduce_and.11, reduce_and.12)
}

_take_11.7 {
  Arg_1.10 = s32[32]{0} parameter(1)
  constant.38 = s32[] constant(0)
  lt.10 = s32[32]{0} broadcast(constant.38), dimensions={}
  lt.11 = pred[32]{0} compare(Arg_1.10, lt.10), direction=LT
  constant.36 = s32[] constant(32)
  add.12 = s32[32]{0} broadcast(constant.36), dimensions={}
  add.13 = s32[32]{0} add(Arg_1.10, add.12)
  jit__where_.5 = s32[32]{0} call(lt.11, add.13, Arg_1.10), to_apply=_where_4.3
  broadcast_in_dim.10 = s32[32,1]{1,0} reshape(jit__where_.5)
  constant.35 = s32[] constant(0)
  ge.6 = s32[32,1]{1,0} broadcast(constant.35), dimensions={}
  ge.7 = pred[32,1]{1,0} compare(broadcast_in_dim.10, ge.6), direction=GE
  constant.34 = s32[] constant(31)
  le.6 = s32[32,1]{1,0} broadcast(constant.34), dimensions={}
  le.7 = pred[32,1]{1,0} compare(broadcast_in_dim.10, le.6), direction=LE
  and.5 = pred[32,1]{1,0} and(ge.7, le.7)
  constant.37 = pred[] constant(true)
  reduce_and.15 = pred[32]{0} reduce(and.5, constant.37), dimensions={1}, to_apply=region_2.6
  broadcast_in_dim.11 = pred[32,32,32]{2,1,0} broadcast(reduce_and.15), dimensions={1}
  Arg_0.11 = f32[32,32,32]{2,1,0} parameter(0)
  gather.3 = f32[32,32,32]{2,1,0} gather(Arg_0.11, broadcast_in_dim.10), offset_dims={0,2}, collapsed_slice_dims={1}, start_index_map={1}, index_vector_dim=1, slice_sizes={32,1,32}
  constant.33 = f32[] constant(nan)
  broadcast_in_dim.9 = f32[32,32,32]{2,1,0} broadcast(constant.33), dimensions={}
  ROOT select_n.9 = f32[32,32,32]{2,1,0} select(broadcast_in_dim.11, gather.3, broadcast_in_dim.9)
}

region_3.8 {
  reduce_and.19 = pred[] parameter(0)
  reduce_and.20 = pred[] parameter(1)
  ROOT reduce_and.21 = pred[] and(reduce_and.19, reduce_and.20)
}

_take_15.9 {
  Arg_1.12 = s32[32]{0} parameter(1)
  constant.50 = s32[] constant(0)
  lt.14 = s32[32]{0} broadcast(constant.50), dimensions={}
  lt.15 = pred[32]{0} compare(Arg_1.12, lt.14), direction=LT
  constant.48 = s32[] constant(32)
  add.17 = s32[32]{0} broadcast(constant.48), dimensions={}
  add.18 = s32[32]{0} add(Arg_1.12, add.17)
  jit__where_.7 = s32[32]{0} call(lt.15, add.18, Arg_1.12), to_apply=_where_4.3
  broadcast_in_dim.16 = s32[32,1]{1,0} reshape(jit__where_.7)
  constant.47 = s32[] constant(0)
  ge.10 = s32[32,1]{1,0} broadcast(constant.47), dimensions={}
  ge.11 = pred[32,1]{1,0} compare(broadcast_in_dim.16, ge.10), direction=GE
  constant.46 = s32[] constant(31)
  le.10 = s32[32,1]{1,0} broadcast(constant.46), dimensions={}
  le.11 = pred[32,1]{1,0} compare(broadcast_in_dim.16, le.10), direction=LE
  and.7 = pred[32,1]{1,0} and(ge.11, le.11)
  constant.49 = pred[] constant(true)
  reduce_and.23 = pred[32]{0} reduce(and.7, constant.49), dimensions={1}, to_apply=region_3.8
  broadcast_in_dim.17 = pred[32,32,32]{2,1,0} broadcast(reduce_and.23), dimensions={2}
  Arg_0.13 = f32[32,32,32]{2,1,0} parameter(0)
  gather.5 = f32[32,32,32]{2,1,0} gather(Arg_0.13, broadcast_in_dim.16), offset_dims={0,1}, collapsed_slice_dims={2}, start_index_map={2}, index_vector_dim=1, slice_sizes={32,32,1}
  constant.45 = f32[] constant(nan)
  broadcast_in_dim.15 = f32[32,32,32]{2,1,0} broadcast(constant.45), dimensions={}
  ROOT select_n.11 = f32[32,32,32]{2,1,0} select(broadcast_in_dim.17, gather.5, broadcast_in_dim.15)
}

heat_step.10 {
  Arg_0.14 = f32[32,32,32]{2,1,0} parameter(0)
  Arg_1.13 = f32[] parameter(1)
  mul.6 = f32[32,32,32]{2,1,0} broadcast(Arg_1.13), dimensions={}
  iota.6 = s32[32]{0} iota(), iota_dimension=0
  constant.52 = s32[] constant(1)
  broadcast.3 = s32[32]{0} broadcast(constant.52), dimensions={}
  add.25 = s32[32]{0} add(iota.6, broadcast.3)
  constant.53 = s32[] constant(32)
  jit_remainder_.6 = s32[32]{0} call(add.25, constant.53), to_apply=remainder.2
  jit__take_.6 = f32[32,32,32]{2,1,0} call(Arg_0.14, jit_remainder_.6), to_apply=_take.5
  iota.7 = s32[32]{0} iota(), iota_dimension=0
  sub.4 = s32[32]{0} subtract(iota.7, broadcast.3)
  jit_remainder_.7 = s32[32]{0} call(sub.4, constant.53), to_apply=remainder.2
  jit__take_.7 = f32[32,32,32]{2,1,0} call(Arg_0.14, jit_remainder_.7), to_apply=_take.5
  add.28 = f32[32,32,32]{2,1,0} add(jit__take_.6, jit__take_.7)
  iota.8 = s32[32]{0} iota(), iota_dimension=0
  add.26 = s32[32]{0} add(iota.8, broadcast.3)
  jit_remainder_.8 = s32[32]{0} call(add.26, constant.53), to_apply=remainder.2
  jit__take_.8 = f32[32,32,32]{2,1,0} call(Arg_0.14, jit_remainder_.8), to_apply=_take_11.7
  add.29 = f32[32,32,32]{2,1,0} add(add.28, jit__take_.8)
  iota.9 = s32[32]{0} iota(), iota_dimension=0
  sub.5 = s32[32]{0} subtract(iota.9, broadcast.3)
  jit_remainder_.9 = s32[32]{0} call(sub.5, constant.53), to_apply=remainder.2
  jit__take_.9 = f32[32,32,32]{2,1,0} call(Arg_0.14, jit_remainder_.9), to_apply=_take_11.7
  add.30 = f32[32,32,32]{2,1,0} add(add.29, jit__take_.9)
  iota.10 = s32[32]{0} iota(), iota_dimension=0
  add.27 = s32[32]{0} add(iota.10, broadcast.3)
  jit_remainder_.10 = s32[32]{0} call(add.27, constant.53), to_apply=remainder.2
  jit__take_.10 = f32[32,32,32]{2,1,0} call(Arg_0.14, jit_remainder_.10), to_apply=_take_15.9
  add.31 = f32[32,32,32]{2,1,0} add(add.30, jit__take_.10)
  iota.11 = s32[32]{0} iota(), iota_dimension=0
  sub.6 = s32[32]{0} subtract(iota.11, broadcast.3)
  jit_remainder_.11 = s32[32]{0} call(sub.6, constant.53), to_apply=remainder.2
  jit__take_.11 = f32[32,32,32]{2,1,0} call(Arg_0.14, jit_remainder_.11), to_apply=_take_15.9
  add.32 = f32[32,32,32]{2,1,0} add(add.31, jit__take_.11)
  constant.51 = f32[] constant(6)
  mul.4 = f32[32,32,32]{2,1,0} broadcast(constant.51), dimensions={}
  mul.5 = f32[32,32,32]{2,1,0} multiply(Arg_0.14, mul.4)
  sub.7 = f32[32,32,32]{2,1,0} subtract(add.32, mul.5)
  mul.7 = f32[32,32,32]{2,1,0} multiply(mul.6, sub.7)
  ROOT add.33 = f32[32,32,32]{2,1,0} add(Arg_0.14, mul.7)
}

closed_call.11 {
  Arg_0.15 = f32[32,32,32]{2,1,0} parameter(0)
  constant.54 = f32[] constant(0.000518764486)
  ROOT jit_heat_step_.1 = f32[32,32,32]{2,1,0} call(Arg_0.15, constant.54), to_apply=heat_step.10
}

region_0.12 {
  arg_tuple.1 = (s32[], f32[32,32,32]{2,1,0}) parameter(0)
  get-tuple-element.2 = s32[] get-tuple-element(arg_tuple.1), index=0
  constant.55 = s32[] constant(1)
  add.35 = s32[] add(get-tuple-element.2, constant.55)
  get-tuple-element.3 = f32[32,32,32]{2,1,0} get-tuple-element(arg_tuple.1), index=1
  closed_call.1 = f32[32,32,32]{2,1,0} call(get-tuple-element.3), to_apply=closed_call.11
  ROOT tuple.1 = (s32[], f32[32,32,32]{2,1,0}) tuple(add.35, closed_call.1)
}

region_4.13 {
  arg_tuple.3 = (s32[], f32[32,32,32]{2,1,0}) parameter(0)
  get-tuple-element.7 = f32[32,32,32]{2,1,0} get-tuple-element(arg_tuple.3), index=1
  get-tuple-element.6 = s32[] get-tuple-element(arg_tuple.3), index=0
  constant.57 = s32[] constant(100)
  ROOT lt.17 = pred[] compare(get-tuple-element.6, constant.57), direction=LT
}

ENTRY main.14 {
  constant.61 = s32[] constant(0)
  start_state_1__0_.1 = f32[32,32,32]{2,1,0} parameter(0)
  while.4 = (s32[], f32[32,32,32]{2,1,0}) tuple(constant.61, start_state_1__0_.1)
  while.5 = (s32[], f32[32,32,32]{2,1,0}) while(while.4), condition=region_4.13, body=region_0.12
  while.6 = s32[] get-tuple-element(while.5), index=0
  constant.60 = f32[32]{0} constant({...})
  while.7 = f32[32,32,32]{2,1,0} get-tuple-element(while.5), index=1
  start_state_2_.1 = f32[] parameter(1)
  constant.58 = f32[] constant(2)
  add.38 = f32[] add(start_state_2_.1, constant.58)
  start_state_3_.1 = s32[] parameter(2)
  constant.59 = s32[] constant(100)
  add.39 = s32[] add(start_state_3_.1, constant.59)
  ROOT tuple.3 = (f32[32]{0}, f32[32]{0}, f32[32]{0}, f32[32,32,32]{2,1,0}, f32[], /*index=5*/s32[]) tuple(constant.60, constant.60, constant.60, while.7, add.38, add.39)
}

