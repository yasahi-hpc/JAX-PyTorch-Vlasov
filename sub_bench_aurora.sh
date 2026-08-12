#!/bin/bash -l
#PBS -N AFFINITY
#PBS -l select=1
#PBS -l place=scatter
#PBS -l walltime=0:60:00
#PBS -l filesystems=flare
#PBS -q debug
#PBS -A kokkos_math

FORCE_RUN_BENCHMARKS=1

problem_sizes=(
    "32 32"
    "32 64"
    "64 64"
    "64 128"
    "128 128"
)

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force-benchmarks)
      FORCE_RUN_BENCHMARKS=1
      shift
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

cd ${PBS_O_WORKDIR}
ROOT_DIR=${PBS_O_WORKDIR}
GIT_SHA7=$(git -C "${ROOT_DIR}" rev-parse --short=7 HEAD)

run_benchmark() {
  local benchmark_name="$1"
  local backend_name="$2"
  local measure_base_dir="$3"
  local source_path="$4"
  local bench_dir="$5"
  local runner_function="$6"
  local latest_dir
  local latest_sha=""
  local measure_sha_dir

  latest_dir=$(ls -1dt "${measure_base_dir}"/*/ 2>/dev/null | head -n 1 || true)
  if [[ -n "${latest_dir}" ]]; then
    latest_sha=$(basename "${latest_dir}")
  fi

  if [[ "${FORCE_RUN_BENCHMARKS}" -eq 0 ]] \
    && [[ -n "${latest_sha}" ]] \
    && git -C "${ROOT_DIR}" cat-file -e "${latest_sha}^{commit}" 2>/dev/null \
    && git -C "${ROOT_DIR}" diff --quiet --exit-code "${latest_sha}" -- "${source_path}"; then
    echo "Skip ${benchmark_name} benchmark (${backend_name}): no changes in ${source_path} since ${latest_sha}."
    return
  fi

  measure_sha_dir=${measure_base_dir}/${GIT_SHA7}
  mkdir -p "${measure_sha_dir}"

  (
    cd "${bench_dir}"
    "${runner_function}" "${measure_sha_dir}"
  )
}

run_iprof_profile() {
    local output_name="$1"
    shift

    local stats_name="iprof_stats_${output_name#iprof_}.txt"

    iprof --max-name-size -1 -- \
    "$@" > "$stats_name"
}

run_kokkos_stream() {
  local measure_sha_dir="$1"

  for fp in fp32 fp64; do
    for size in 20000000 40000000 80000000 160000000; do
      ./simulations/stream/kokkos/src/stream_${fp} -size ${size}
      mv -f "stream_${fp}.txt" "stream_PVC_${fp}_N${size}.txt"
      mv -f "stream_PVC_${fp}_N${size}.txt" "${measure_sha_dir}/"
      rm -f -- *.dat # Do not use Kokkos-tools

      # Using iprof to profile the stream benchmark
      run_iprof_profile "iprof_stream_${fp}_N${size}" \
        ./simulations/stream/kokkos/src/stream_${fp} -size ${size}
      mv -f "iprof_stats_stream_${fp}_N${size}.txt" "${measure_sha_dir}/"
    done
  done
}

run_kokkos_heat3d() {
  local measure_sha_dir="$1"

  for fp in fp32 fp64; do
    for nx in 32 64 128 256 512; do
      ./simulations/heat3d/kokkos/src/heat3d_${fp} -nx $nx -nbiter 1000 -diag_steps 2000 -dt 0.02
      mv -f "heat3d_${fp}.txt" "heat3d_PVC_${fp}_N${nx}.txt"
      mv -f "heat3d_PVC_${fp}_N${nx}.txt" "${measure_sha_dir}/"
      rm -f -- *.dat # Do not use Kokkos-tools

      # Using iprof to profile the heat3d benchmark
      run_iprof_profile "iprof_heat3d_${fp}_N${nx}" \
        ./simulations/heat3d/kokkos/src/heat3d_${fp} -nx $nx -nbiter 1000 -diag_steps 2000 -dt 0.02
      mv -f "iprof_stats_heat3d_${fp}_N${nx}.txt" "${measure_sha_dir}/"
    done
  done
}

run_kokkos_vlp1d() {
  local measure_sha_dir="$1"

  for fp in fp32 fp64; do
    for n in 128 256 512 1024 2048 4096; do
      for solver in 0 1; do
        ./simulations/vlasov1d_1v/kokkos/src/vlp1d_1v_${fp} -nx $n -nv $n -nbiter 1000 -diag_steps 2000 -solver_type $solver
        mv -f "vlp1d_1v_${fp}.txt" "vlp1d_1v_PVC_${fp}_N${n}_solver${solver}.txt"
        cp "vlp1d_1v_PVC_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"

        ${KOKKOS_TOOLS_DIR}/../bin/kp_reader *.dat > prof_vlp1d_1v_PVC_${fp}_N${n}_solver${solver}.txt
        mv -f "prof_vlp1d_1v_PVC_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"
        rm -f -- *.dat

        # Using iprof to profile the vlp1d_1v benchmark
        run_iprof_profile "iprof_vlp1d_1v_${fp}_N${n}_solver${solver}" \
          ./simulations/vlasov1d_1v/kokkos/src/vlp1d_1v_${fp} -nx $n -nv $n -nbiter 1000 -diag_steps 2000 -solver_type $solver
        mv -f "iprof_stats_vlp1d_1v_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"
      done
    done
  done
}

run_kokkos_vlp2d() {
  local measure_sha_dir="$1"

  for fp in fp32 fp64; do
    for problem_size in "${problem_sizes[@]}"; do
      for solver in 0 1; do
        read -r nx nvx <<< "${problem_size}"
        ./simulations/vlasov2d_2v/kokkos/src/vlp2d_2v_${fp} -nx $nx -ny $nx -nvx $nvx -nvy $nvx -nbiter 128 -diag_steps 2000 -solver_type $solver
        mv -f "vlp2d_2v_${fp}.txt" "vlp2d_2v_PVC_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt"
        mv -f "vlp2d_2v_PVC_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt" "${measure_sha_dir}/"

        ${KOKKOS_TOOLS_DIR}/../bin/kp_reader *.dat > prof_vlp2d_2v_PVC_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt
        mv -f "prof_vlp2d_2v_PVC_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt" "${measure_sha_dir}/"
        rm -f -- *.dat

        # Using iprof to profile the vlp2d_2v benchmark
        run_iprof_profile "iprof_vlp2d_2v_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}" \
          ./simulations/vlasov2d_2v/kokkos/src/vlp2d_2v_${fp} -nx $nx -ny $nx -nvx $nvx -nvy $nvx -nbiter 128 -diag_steps 2000 -solver_type $solver
        mv -f "iprof_stats_vlp2d_2v_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt" "${measure_sha_dir}/"
      done
    done
  done
}

run_kokkos_benchmarks() {
  module load cmake thapi
  cmake -B build_gpu -DCMAKE_CXX_COMPILER=icpx \
        -DCMAKE_BUILD_TYPE=Release \
        -DKokkos_ENABLE_SYCL=ON \
        -DKokkos_ARCH_INTEL_PVC=ON \
        -DVLP4D_ENABLE_INTERNAL_KOKKOS=ON \
        -DVLP4D_ENABLE_INTERNAL_KOKKOSFFT=ON

  cmake --build build_gpu -j 8

  echo "#########################"
  echo "### Kokkos benchmarks ###"
  echo "#########################"

  export KOKKOS_TOOLS_DIR=/home/yasahi/lib/kokkos-tools/lib64
  export KOKKOS_TOOLS_LIBS=${KOKKOS_TOOLS_DIR}/libkp_kernel_timer.so
  export PATH=${PATH}:${KOKKOS_TOOLS_DIR}
  export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${KOKKOS_TOOLS_DIR}
  export ZE_FLAT_DEVICE_HIERARCHY=FLATs

  run_benchmark "stream" "Kokkos" \
    "${ROOT_DIR}/measurements/stream/kokkos" \
    "simulations/stream/kokkos/src" \
    "${ROOT_DIR}/build_gpu" \
    run_kokkos_stream

  run_benchmark "heat3d" "Kokkos" \
    "${ROOT_DIR}/measurements/heat3d/kokkos" \
    "simulations/heat3d/kokkos/src" \
    "${ROOT_DIR}/build_gpu" \
    run_kokkos_heat3d

  run_benchmark "vlasov1d_1v" "Kokkos" \
    "${ROOT_DIR}/measurements/vlasov1d_1v/kokkos" \
    "simulations/vlasov1d_1v/kokkos/src" \
    "${ROOT_DIR}/build_gpu" \
    run_kokkos_vlp1d

  run_benchmark "vlasov2d_2v" "Kokkos" \
    "${ROOT_DIR}/measurements/vlasov2d_2v/kokkos" \
    "simulations/vlasov2d_2v/kokkos/src" \
    "${ROOT_DIR}/build_gpu" \
    run_kokkos_vlp2d
}

run_jax_stream() {
  local measure_sha_dir="$1"

  for fp in float32 float64; do
    for size in 20000000 40000000 80000000 160000000; do
      python stream.py --size $size --dtype $fp
      mv -f "stream_${fp}.txt" "stream_PVC_${fp}_N${size}.txt"
      mv -f "stream_PVC_${fp}_N${size}.txt" "${measure_sha_dir}/"
    done
    mv -f jaxpr_dump "${measure_sha_dir}/stream_PVC_${fp}_jaxpr_dump"
    mv -f hlo_dump "${measure_sha_dir}/stream_PVC_${fp}_hlo_dump"
  done
}

run_jax_heat3d() {
  local measure_sha_dir="$1"

  for fp in float32 float64; do
    for nx in 32 64 128 256 512; do
      for solver in 0 1 2; do
	      # Skip fp=float64 with solver=2
        if [[ "$fp" == "float64" && "$solver" -eq 2 ]]; then
          continue
        fi
        python heat3d.py -nx $nx -dtype $fp -nbiter 100 -diag_steps 200 -solver $solver  -dt 0.02
        mv -f "heat3d_${fp}.txt" "heat3d_PVC_${fp}_N${nx}_solver${solver}.txt"
        mv -f "heat3d_PVC_${fp}_N${nx}_solver${solver}.txt" "${measure_sha_dir}/"
      done
    done
    mv -f jaxpr_dump "${measure_sha_dir}/heat3d_PVC_${fp}_jaxpr_dump"
    mv -f hlo_dump "${measure_sha_dir}/heat3d_PVC_${fp}_hlo_dump"
  done
}

run_jax_vlp1d() {
  local measure_sha_dir="$1"

  for fp in float32 float64; do
    for n in 128 256 512 1024 2048 4096; do
      for solver in 0 1 2; do
        python vlasov1D1V.py -nx $n -dtype $fp -nx $n -nv $n -nbiter 1000 -diag_steps 2000 -physics_mode -solver $solver
        mv -f "vlp1d_1v_${fp}.txt" "vlp1d_1v_PVC_${fp}_N${n}_solver${solver}.txt"
        mv -f "vlp1d_1v_PVC_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"
      done
    done
    mv -f jaxpr_dump "${measure_sha_dir}/vlp1d_1v_PVC_${fp}_jaxpr_dump"
    mv -f hlo_dump "${measure_sha_dir}/vlp1d_1v_PVC_${fp}_hlo_dump"
  done
}

run_jax_vlp2d() {
  local measure_sha_dir="$1"

  for fp in float32 float64; do
    for problem_size in "${problem_sizes[@]}"; do
      for solver in 0 1 2; do
        read -r nx nvx <<< "${problem_size}"
        python vlasov2D2V.py -nx $nx -dtype $fp -nx $nx -ny $nx -nvx $nvx -nvy $nvx -nbiter 128 -diag_steps 2000 -physics_mode -solver $solver
        mv -f "vlp2d_2v_${fp}.txt" "vlp2d_2v_PVC_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt"
        mv -f "vlp2d_2v_PVC_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt" "${measure_sha_dir}/"
      done
    done
    mv -f jaxpr_dump "${measure_sha_dir}/vlp2d_2v_PVC_${fp}_jaxpr_dump"
    mv -f hlo_dump "${measure_sha_dir}/vlp2d_2v_PVC_${fp}_hlo_dump"
  done
}

run_jax_benchmarks() {
  echo "######################"
  echo "### Jax benchmarks ###"
  echo "######################"

  module purge
  module load frameworks
  source /home/yasahi/develop/Paper/practice-python/jax_env/bin/activate

  run_benchmark "stream" "jax" \
    "${ROOT_DIR}/measurements/stream/jax" \
    "simulations/stream/jax/src" \
    "${ROOT_DIR}/simulations/stream/jax/src" \
    run_jax_stream

  run_benchmark "heat3d" "jax" \
    "${ROOT_DIR}/measurements/heat3d/jax" \
    "simulations/heat3d/jax/src" \
    "${ROOT_DIR}/simulations/heat3d/jax/src" \
    run_jax_heat3d

  run_benchmark "vlp1d_1v" "jax" \
    "${ROOT_DIR}/measurements/vlasov1d_1v/jax" \
    "simulations/vlasov1d_1v/jax/src" \
    "${ROOT_DIR}/simulations/vlasov1d_1v/jax/src" \
    run_jax_vlp1d

  run_benchmark "vlp2d_2v" "jax" \
    "${ROOT_DIR}/measurements/vlasov2d_2v/jax" \
    "simulations/vlasov2d_2v/jax/src" \
    "${ROOT_DIR}/simulations/vlasov2d_2v/jax/src" \
    run_jax_vlp2d
}

run_torch_stream() {
  local measure_sha_dir="$1"

  for fp in float32 float64; do
    for size in 20000000 40000000 80000000 160000000; do
      python stream.py --size $size --dtype $fp
      mv -f "stream_${fp}.txt" "stream_PVC_${fp}_N${size}.txt"
      mv -f "stream_PVC_${fp}_N${size}.txt" "${measure_sha_dir}/"
    done
    mv -f dynamo_graphs "${measure_sha_dir}/stream_PVC_${fp}_dynamo_graphs"
  done
}

run_torch_heat3d() {
  local measure_sha_dir="$1"

  for fp in float32 float64; do
    for nx in 32 64 128 256 512; do
      python heat3d.py -nx $nx -dtype $fp -nbiter 100 -diag_steps 200 -dt 0.02
      mv -f "heat3d_${fp}.txt" "heat3d_PVC_${fp}_N${nx}.txt"
      mv -f "heat3d_PVC_${fp}_N${nx}.txt" "${measure_sha_dir}/"
    done
    mv -f dynamo_graphs "${measure_sha_dir}/heat3d_PVC_${fp}_dynamo_graphs"
  done
}

run_torch_vlp1d() {
  local measure_sha_dir="$1"

  for fp in float32 float64; do
    for n in 128 256 512 1024 2048 4096; do
      for solver in 0 1 2; do
        python vlasov1D1V.py -nx $n -dtype $fp -nx $n -nv $n -nbiter 1000 -diag_steps 2000 -physics_mode -solver $solver
        mv -f "vlp1d_1v_${fp}.txt" "vlp1d_1v_PVC_${fp}_N${n}_solver${solver}.txt"
        mv -f "vlp1d_1v_PVC_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"
      done
    done
    mv -f dynamo_graphs "${measure_sha_dir}/vlp1d_1v_PVC_${fp}_dynamo_graphs"
  done
}

run_torch_vlp2d() {
  local measure_sha_dir="$1"

  for fp in float32 float64; do
    for problem_size in "${problem_sizes[@]}"; do
      for solver in 0 1 2; do
        read -r nx nvx <<< "${problem_size}"
        python vlasov2D2V.py -nx $nx -dtype $fp -nx $nx -ny $nx -nvx $nvx -nvy $nvx -nbiter 128 -diag_steps 2000 -physics_mode -solver $solver
        mv -f "vlp2d_2v_${fp}.txt" "vlp2d_2v_PVC_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt"
        mv -f "vlp2d_2v_PVC_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt" "${measure_sha_dir}/"
      done
    done
    mv -f dynamo_graphs "${measure_sha_dir}/vlp2d_2v_PVC_${fp}_dynamo_graphs"
  done
}

run_torch_benchmarks() {
  echo "##########################"
  echo "### PyTorch benchmarks ###"
  echo "##########################"

  module purge
  module load frameworks
  source /home/yasahi/develop/Paper/practice-python/torch_env/bin/activate

  run_benchmark "stream" "pytorch" \
    "${ROOT_DIR}/measurements/stream/pytorch" \
    "simulations/stream/pytorch/src" \
    "${ROOT_DIR}/simulations/stream/pytorch/src" \
    run_torch_stream

  run_benchmark "heat3d" "pytorch" \
    "${ROOT_DIR}/measurements/heat3d/pytorch" \
    "simulations/heat3d/pytorch/src" \
    "${ROOT_DIR}/simulations/heat3d/pytorch/src" \
    run_torch_heat3d

  run_benchmark "vlp1d_1v" "pytorch" \
    "${ROOT_DIR}/measurements/vlasov1d_1v/pytorch" \
    "simulations/vlasov1d_1v/pytorch/src" \
    "${ROOT_DIR}/simulations/vlasov1d_1v/pytorch/src" \
    run_torch_vlp1d

  run_benchmark "vlp2d_2v" "pytorch" \
    "${ROOT_DIR}/measurements/vlasov2d_2v/pytorch" \
    "simulations/vlasov2d_2v/pytorch/src" \
    "${ROOT_DIR}/simulations/vlasov2d_2v/pytorch/src" \
    run_torch_vlp2d
}

run_kokkos_benchmarks
run_torch_benchmarks
run_jax_benchmarks
