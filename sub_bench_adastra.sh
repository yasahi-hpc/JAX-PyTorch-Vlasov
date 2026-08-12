#!/bin/bash
#SBATCH --account=cad16293
#SBATCH --job-name=name
#SBATCH --constraint=MI250
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --time=12:00:00

module purge
module load cpe/24.07
module load cray-python
module load rocm/7.2.0
module load cmake/3.27.9

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

ROOT_DIR=$(pwd)
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

run_rocprof_profile() {
    local output_name="$1"
    shift

    local stats_name="rocprof_stats_${output_name#rocprof_}.txt"

    rocprofv3 \
        --output-format=csv \
	--hip-runtime-trace \
	--kernel-trace \
       	--stats \
	--summary \
	--kokkos-trace -- \
	"$@" > "$stats_name"
}

run_rcu_profile() {
    local output_name="$1"
    local kernel_name="$2"
    shift 2

    local stats_name="rcu_stats_${output_name#rcu_}.txt"

    rocprof-compute profile \
	--no-roof -n "$kernel_name" \
	-- "$@"

    rocprof-compute analyze -p "./workloads/${kernel_name}/MI210" > "$stats_name"
}

prof_kokkos_stream() {
  local measure_sha_dir="$1"

  for fp in fp32 fp64; do
    for size in 160000000; do
      #rocprof-v3
      run_rocprof_profile "rocprof_stream_${fp}_N${size}" \
        ./simulations/stream/kokkos/src/stream_${fp} -size ${size}
      mv -f "rocprof_stats_stream_${fp}_N${size}.txt" "${measure_sha_dir}/"

      #rocprof-compute
      run_rcu_profile "stream_${fp}_N${size}" "stream_${fp}_N${size}" \
        ./simulations/stream/kokkos/src/stream_${fp} -size ${size}
      mv -f "rcu_stats_stream_${fp}_N${size}.txt" "${measure_sha_dir}/"
    done
  done
}

prof_kokkos_heat3d() {
  local measure_sha_dir="$1"

  for fp in fp32 fp64; do
    for nx in 512; do
      #rocprof-v3
      run_rocprof_profile "rocprof_heat3d_${fp}_N${nx}" \
        ./simulations/heat3d/kokkos/src/heat3d_${fp} -nx $nx -nbiter 100 -diag_steps 2000 -dt 0.02
      mv -f "rocprof_stats_heat3d_${fp}_N${nx}.txt" "${measure_sha_dir}/"

      #rocprof-compute
      run_rcu_profile "heat3d_${fp}_N${nx}" "heat3d_${fp}_N${nx}" \
        ./simulations/heat3d/kokkos/src/heat3d_${fp} -nx $nx -nbiter 100 -diag_steps 2000 -dt 0.02
      mv -f "rcu_stats_heat3d_${fp}_N${nx}.txt" "${measure_sha_dir}/"
    done
  done
}

prof_kokkos_vlp1d() {
  local measure_sha_dir="$1"

  for fp in fp32 fp64; do
    for n in 4096; do
      for solver in 0 1; do
	#rocprof-v3
        run_rocprof_profile "rocprof_vlp1d_1v_${fp}_N${n}_solver${solver}" \
            ./simulations/vlasov1d_1v/kokkos/src/vlp1d_1v_${fp} -nx $n -nv $n -nbiter 100 -diag_steps 2000 -solver_type $solver
        mv -f "rocprof_stats_vlp1d_1v_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"

	#rocprof-compute
        run_rcu_profile "vlp1d_1v_${fp}_N${n}_solver${solver}" "vlp1d_1v_${fp}_N${n}" \
            ./simulations/vlasov1d_1v/kokkos/src/vlp1d_1v_${fp} -nx $n -nv $n -nbiter 100 -diag_steps 2000 -solver_type $solver
        mv -f "rcu_stats_vlp1d_1v_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"
      done
    done
  done
}

prof_kokkos_vlp2d() {
  local measure_sha_dir="$1"

  for fp in fp32 fp64; do
    for n in 128; do
      for solver in 0 1; do
	#rocprof-v3
        run_rocprof_profile "rocprof_vlp2d_2v_${fp}_N${n}_solver${solver}" \
          ./simulations/vlasov2d_2v/kokkos/src/vlp2d_2v_${fp} -nx $n -ny $n -nvx $n -nvy $n -nbiter 10 -diag_steps 2000 -solver_type $solver
        mv -f "rocprof_stats_vlp2d_2v_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"

	#rocprof-compute
        run_rcu_profile "vlp2d_2v_${fp}_N${n}_solver${solver}" "vlp2d_2v_${fp}_N${n}" \
          ./simulations/vlasov2d_2v/kokkos/src/vlp2d_2v_${fp} -nx $n -ny $n -nvx $n -nvy $n -nbiter 10 -diag_steps 2000 -solver_type $solver
        mv -f "rcu_stats_vlp2d_2v_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"
      done
    done
  done
}

run_kokkos_stream() {
  local measure_sha_dir="$1"

  for fp in fp32 fp64; do
    for size in 20000000 40000000 80000000 160000000; do
      ./simulations/stream/kokkos/src/stream_${fp} -size ${size}
      mv -f "stream_${fp}.txt" "stream_MI250X_${fp}_N${size}.txt"
      mv -f "stream_MI250X_${fp}_N${size}.txt" "${measure_sha_dir}/"
      rm -f -- *.dat # Do not use Kokkos-tools
    done
  done
}

run_kokkos_heat3d() {
  local measure_sha_dir="$1"

  for fp in fp32 fp64; do
    for nx in 32 64 128 256 512; do
      ./simulations/heat3d/kokkos/src/heat3d_${fp} -nx $nx -nbiter 1000 -diag_steps 2000 -dt 0.02
      mv -f "heat3d_${fp}.txt" "heat3d_MI250X_${fp}_N${nx}.txt"
      mv -f "heat3d_MI250X_${fp}_N${nx}.txt" "${measure_sha_dir}/"
      rm -f -- *.dat # Do not use Kokkos-tools
    done
  done
}

run_kokkos_vlp1d() {
  local measure_sha_dir="$1"

  for fp in fp32 fp64; do
    for n in 128 256 512 1024 2048 4096; do
      for solver in 0 1; do
        ./simulations/vlasov1d_1v/kokkos/src/vlp1d_1v_${fp} -nx $n -nv $n -nbiter 1000 -diag_steps 2000 -solver_type $solver
        mv -f "vlp1d_1v_${fp}.txt" "vlp1d_1v_MI250X_${fp}_N${n}_solver${solver}.txt"
        cp "vlp1d_1v_MI250X_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"

        ${KOKKOS_TOOLS_DIR}/../bin/kp_reader *.dat > prof_vlp1d_1v_MI250X_${fp}_N${n}_solver${solver}.txt
        mv -f "prof_vlp1d_1v_MI250X_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"
        rm -f -- *.dat
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
        mv -f "vlp2d_2v_${fp}.txt" "vlp2d_2v_MI250X_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt"
        mv -f "vlp2d_2v_MI250X_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt" "${measure_sha_dir}/"

        ${KOKKOS_TOOLS_DIR}/../bin/kp_reader *.dat > prof_vlp2d_2v_MI250X_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt
        mv -f "prof_vlp2d_2v_MI250X_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt" "${measure_sha_dir}/"
        rm -f -- *.dat
      done
    done
  done
}

run_kokkos_benchmarks() {
  module purge
  module load cpe/24.07
  module load cray-python/3.10
  module load rocm/7.2.0
  module load cmake/3.27.9
  source /lus/home/CT6/cad16293/yasahi/work/test/pytorch/practice/jax_env2/bin/activate
  cmake -B build_gpu -DCMAKE_CXX_COMPILER=hipcc \
        -DCMAKE_BUILD_TYPE=Release \
        -DKokkos_ENABLE_HIP=ON \
        -DKokkos_ARCH_AMD_GFX90A=ON \
        -DVLP4D_ENABLE_INTERNAL_KOKKOS=ON \
        -DVLP4D_ENABLE_INTERNAL_KOKKOSFFT=ON

  cmake --build build_gpu -j 8

  echo "#########################"
  echo "### Kokkos benchmarks ###"
  echo "#########################"
  run_benchmark "stream" "Kokkos" \
    "${ROOT_DIR}/measurements/stream/kokkos" \
    "simulations/stream/kokkos/src" \
    "${ROOT_DIR}/build_gpu" \
    prof_kokkos_stream

  run_benchmark "heat3d" "Kokkos" \
    "${ROOT_DIR}/measurements/heat3d/kokkos" \
    "simulations/heat3d/kokkos/src" \
    "${ROOT_DIR}/build_gpu" \
    prof_kokkos_heat3d

  run_benchmark "vlasov1d_1v" "Kokkos" \
    "${ROOT_DIR}/measurements/vlasov1d_1v/kokkos" \
    "simulations/vlasov1d_1v/kokkos/src" \
    "${ROOT_DIR}/build_gpu" \
    prof_kokkos_vlp1d

  run_benchmark "vlasov2d_2v" "Kokkos" \
    "${ROOT_DIR}/measurements/vlasov2d_2v/kokkos" \
    "simulations/vlasov2d_2v/kokkos/src" \
    "${ROOT_DIR}/build_gpu" \
    prof_kokkos_vlp2d

  export KOKKOS_TOOLS_DIR=/lus/home/CT6/cad16293/yasahi/work/lib/lib/kokkos-tools/lib64
  export KOKKOS_TOOLS_LIBS=${KOKKOS_TOOLS_DIR}/libkp_kernel_timer.so
  export KOKKOS_TOOLS_CONNECTOR=${KOKKOS_TOOLS_DIR}/libkp_roctx_connector.so
  export PATH=${PATH}:${KOKKOS_TOOLS_DIR}
  export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${KOKKOS_TOOLS_DIR}

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
      mv -f "stream_${fp}.txt" "stream_MI250X_${fp}_N${size}.txt"
      mv -f "stream_MI250X_${fp}_N${size}.txt" "${measure_sha_dir}/"
      #rocprof-v3
      if [[ "$size" -eq 160000000 ]]; then
        run_rocprof_profile "rocprof_stream_${fp}_N${size}" \
          python stream.py --size $size --dtype $fp
        mv -f "rocprof_stats_stream_${fp}_N${size}.txt" "${measure_sha_dir}/"
      fi
    done
    mv -f jaxpr_dump "${measure_sha_dir}/stream_MI250X_${fp}_jaxpr_dump"
    mv -f hlo_dump "${measure_sha_dir}/stream_MI250X_${fp}_hlo_dump"
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
        python heat3d.py -nx $nx -dtype $fp -nbiter 100 -diag_steps 200 -solver $solver -dt 0.02
        mv -f "heat3d_${fp}.txt" "heat3d_MI250X_${fp}_N${nx}_solver${solver}.txt"
	mv -f "heat3d_MI250X_${fp}_N${nx}_solver${solver}.txt" "${measure_sha_dir}/"

	#rocprof-v3
        if [[ "$nx" -eq 512 ]]; then
          run_rocprof_profile "rocprof_heat3d_${fp}_N${nx}_solver${solver}" \
            python heat3d.py -nx $nx -dtype $fp -nbiter 100 -diag_steps 200 -solver $solver -dt 0.02
          mv -f "rocprof_stats_heat3d_${fp}_N${nx}_solver${solver}.txt" "${measure_sha_dir}/"

        fi
      done
    done
    mv -f jaxpr_dump "${measure_sha_dir}/heat3d_MI250X_${fp}_jaxpr_dump"
    mv -f hlo_dump "${measure_sha_dir}/heat3d_MI250X_${fp}_hlo_dump"
  done
}

run_jax_vlp1d() {
  local measure_sha_dir="$1"

  for fp in float32 float64; do
    for n in 128 256 512 1024 2048 4096; do
      for solver in 0 1 2; do
        python vlasov1D1V.py -dtype $fp -nx $n -nv $n -nbiter 1000 -diag_steps 2000 -physics_mode -solver $solver
        mv -f "vlp1d_1v_${fp}.txt" "vlp1d_1v_MI250X_${fp}_N${n}_solver${solver}.txt"
        mv -f "vlp1d_1v_MI250X_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"

	#rocprof-v3
        if [[ "$n" -eq 4096 ]]; then
          run_rocprof_profile "rocprof_vlp1d_1v_${fp}_N${n}_solver${solver}" \
            python vlasov1D1V.py -dtype $fp -nx $n -nv $n -nbiter 100 -diag_steps 2000 -physics_mode -solver $solver
          mv -f "rocprof_stats_vlp1d_1v_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"
        fi
      done
    done
    mv -f jaxpr_dump "${measure_sha_dir}/vlp1d_1v_MI250X_${fp}_jaxpr_dump"
    mv -f hlo_dump "${measure_sha_dir}/vlp1d_1v_MI250X_${fp}_hlo_dump"
  done
}

run_jax_vlp2d() {
  local measure_sha_dir="$1"

  for fp in float32 float64; do
    for problem_size in "${problem_sizes[@]}"; do
      for solver in 0 1 2; do
	read -r nx nvx <<< "${problem_size}"
        python vlasov2D2V.py -dtype $fp -nx $nx -ny $nx -nvx $nvx -nvy $nvx -nbiter 128 -diag_steps 2000 -physics_mode -solver $solver
        mv -f "vlp2d_2v_${fp}.txt" "vlp2d_2v_MI250X_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt"
        mv -f "vlp2d_2v_MI250X_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt" "${measure_sha_dir}/"

	#rocprof-v3
        if [[ "$nx" -eq 128 ]]; then
          run_rocprof_profile "rocprof_vlp2d_2v_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}" \
            python vlasov2D2V.py -dtype $fp -nx $nx -ny $nx -nvx $nvx -nvy $nvx -nbiter 10 -diag_steps 2000 -physics_mode -solver $solver
          mv -f "rocprof_stats_vlp2d_2v_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt" "${measure_sha_dir}/"
        fi
      done
    done
    mv -f jaxpr_dump "${measure_sha_dir}/vlp2d_2v_MI250X_${fp}_jaxpr_dump"
    mv -f hlo_dump "${measure_sha_dir}/vlp2d_2v_MI250X_${fp}_hlo_dump"
  done
}

run_jax_benchmarks() {
  echo "######################"
  echo "### Jax benchmarks ###"
  echo "######################"

  source /lus/home/CT6/cad16293/yasahi/work/test/pytorch/practice/jax_env/bin/activate

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
      mv -f "stream_${fp}.txt" "stream_MI250X_${fp}_N${size}.txt"
      mv -f "stream_MI250X_${fp}_N${size}.txt" "${measure_sha_dir}/"

    done
    mv -f dynamo_graphs "${measure_sha_dir}/stream_MI250X_${fp}_dynamo_graphs"
  done
}

run_torch_heat3d() {
  local measure_sha_dir="$1"

  for fp in float32 float64; do
    for nx in 32 64 128 256 512; do
      python heat3d.py -nx $nx -dtype $fp -nbiter 100 -diag_steps 200 -dt 0.02
      mv -f "heat3d_${fp}.txt" "heat3d_MI250X_${fp}_N${nx}.txt"
      mv -f "heat3d_MI250X_${fp}_N${nx}.txt" "${measure_sha_dir}/"
    done
    mv -f dynamo_graphs "${measure_sha_dir}/heat3d_MI250X_${fp}_dynamo_graphs"
  done
}

run_torch_vlp1d() {
  local measure_sha_dir="$1"

  for fp in float32 float64; do
    for n in 128 256 512 1024 2048 4096; do
      for solver in 0 1 2; do
        python vlasov1D1V.py -dtype $fp -nx $n -nv $n -nbiter 1000 -diag_steps 2000 -physics_mode -solver $solver
        mv -f "vlp1d_1v_${fp}.txt" "vlp1d_1v_MI250X_${fp}_N${n}_solver${solver}.txt"
        mv -f "vlp1d_1v_MI250X_${fp}_N${n}_solver${solver}.txt" "${measure_sha_dir}/"
      done
    done
    mv -f dynamo_graphs "${measure_sha_dir}/vlp1d_1v_MI250X_${fp}_dynamo_graphs"
  done
}

run_torch_vlp2d() {
  local measure_sha_dir="$1"

  for fp in float32 float64; do
    for problem_size in "${problem_sizes[@]}"; do
      for solver in 0 1 2; do
	read -r nx nvx <<< "${problem_size}"
        python vlasov2D2V.py -dtype $fp -nx $nx -ny $nx -nvx $nvx -nvy $nvx -nbiter 128 -diag_steps 2000 -physics_mode -solver $solver
        mv -f "vlp2d_2v_${fp}.txt" "vlp2d_2v_MI250X_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt"
        mv -f "vlp2d_2v_MI250X_${fp}_Nx${nx}_Nvx${nvx}_solver${solver}.txt" "${measure_sha_dir}/"
      done
    done
    mv -f dynamo_graphs "${measure_sha_dir}/vlp2d_2v_MI250X_${fp}_dynamo_graphs"
  done
}

run_torch_benchmarks() {
  echo "##########################"
  echo "### PyTorch benchmarks ###"
  echo "##########################"

  module purge
  module load cpe/24.07
  module load cray-python
  module load rocm/7.2.0
  source /lus/home/CT6/cad16293/yasahi/work/test/pytorch/practice/torch_env/bin/activate

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

run_jax_benchmarks
run_torch_benchmarks
run_kokkos_benchmarks

