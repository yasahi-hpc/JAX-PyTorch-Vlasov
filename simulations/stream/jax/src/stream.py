import jax
import jax.numpy as jnp
import time
import argparse
import resource
from pathlib import Path

def get_memory_stats(device=None):
    """
    Return allocator statistics for a JAX device via the public
    jax.Device.memory_stats() API (available on GPU/TPU PJRT backends).

    Returns None if the backend does not expose allocator statistics
    (e.g. the CPU backend).
    """
    if device is None:
        device = jax.local_devices()[0]
    return device.memory_stats()

def get_host_peak_rss():
    """Peak resident set size of this process in bytes (Linux: ru_maxrss is KiB)."""
    return resource.getrusage(resource.RUSAGE_SELF).ru_maxrss * 1024

def get_compiled_memory_analysis(jitted_fn, *args):
    """
    Static, compiler-reported memory requirements of a jitted function
    (AOT lowering; hits the JIT cache if already compiled for these shapes).

    Returns None if the backend does not implement memory_analysis().
    """
    try:
        return jitted_fn.lower(*args).compile().memory_analysis()
    except Exception:
        return None

def format_memory(num_bytes):
    return f"{num_bytes / 1024**2:.2f} MiB"

def get_device(device_arg):
    if device_arg == 'gpu':
        try:
            gpus = jax.devices('gpu')
            if gpus:
                return gpus[0]
        except RuntimeError:
            try:
                gpus = jax.devices('sycl')
                if gpus:
                    return gpus[0]
            except RuntimeError:
                pass
    elif device_arg == 'tpu':
        return jax.devices('tpu')[0]
    elif device_arg == 'cpu':
        return jax.devices('cpu')[0]
    # Default fallback to cpu
    return jax.devices('cpu')[0]

# Helper for synchronization
def synchronize(device):
    # In JAX, block_until_ready() is used on arrays.
    # For a global barrier, we can use jax.effects_barrier() or
    # simply call block_until_ready() on results in time_kernel.
    pass

def time_kernel(fn, nbiter: int, device):
    times = []
    for _ in range(nbiter):
        start = time.perf_counter()
        result = fn()
        # Block until the computation is complete
        if isinstance(result, jax.Array):
            result.block_until_ready()
        elif isinstance(result, (tuple, list)):
            for r in result:
                if isinstance(r, jax.Array):
                    r.block_until_ready()
        end = time.perf_counter()
        times.append(end - start)

    best = min(times)
    avg = sum(times) / len(times)
    return best, avg

# JAX is functional: ops return new arrays rather than mutating in-place.
# Each kernel returns the updated array(s) so the caller can capture them.

@jax.jit
def stream_set(a: jax.Array, scalar: float) -> jax.Array:
    """Set: a[:] = scalar.  `a` is the shape/dtype template."""
    return jnp.full_like(a, scalar)

@jax.jit
def stream_copy(a: jax.Array) -> jax.Array:
    """Copy: c = a."""
    return jnp.array(a, copy=True)

@jax.jit
def stream_scale(c: jax.Array, scalar: float) -> jax.Array:
    """Scale: b = scalar * c."""
    return c * scalar

@jax.jit
def stream_add(a: jax.Array, b: jax.Array) -> jax.Array:
    """Add: c = a + b."""
    return a + b

@jax.jit
def stream_triad(b: jax.Array, c: jax.Array, scalar: float) -> jax.Array:
    """Triad: a = b + scalar * c."""
    return b + scalar * c

def dump_jaxprs(a, b, c, scalar, output_dir="jaxpr_dump"):
    """Trace each STREAM kernel with jax.make_jaxpr and write the
    resulting Jaxpr IR to text files for inspection."""
    out = Path(output_dir)
    out.mkdir(parents=True, exist_ok=True)

    kernels = {
        "set":   (stream_set,   (a, scalar)),
        "copy":  (stream_copy,  (a,)),
        "scale": (stream_scale, (c, scalar)),
        "add":   (stream_add,   (a, b)),
        "triad": (stream_triad, (b, c, scalar)),
    }

    for name, (fn, args) in kernels.items():
        path = out / f"jaxpr_{name}.txt"
        if path.exists():
            continue

        # Strip @jax.jit so make_jaxpr can trace the raw Python function
        raw_fn = fn.__wrapped__ if hasattr(fn, "__wrapped__") else fn
        jaxpr = jax.make_jaxpr(raw_fn)(*args)
        path.write_text(str(jaxpr))

def dump_stablehlo(a, b, c, scalar, output_dir="hlo_dump"):
    """Lower each STREAM kernel and write the stable-HLO IR to text files."""
    out = Path(output_dir)
    out.mkdir(parents=True, exist_ok=True)

    kernels = {
        "set":   (stream_set,   (a, scalar)),
        "copy":  (stream_copy,  (a,)),
        "scale": (stream_scale, (c, scalar)),
        "add":   (stream_add,   (a, b)),
        "triad": (stream_triad, (b, c, scalar)),
    }

    for dialect in ["hlo", "stablehlo"]:
        for name, (fn, args) in kernels.items():
            path = out / f"{dialect}_{name}.mlir"
            if path.exists():
                continue

            compiler_ir = fn.lower(*args).compiler_ir(dialect=dialect)
            if dialect == "hlo":
                # Some backends may not support HLO; skip if not available
                try:
                    hlo_text = compiler_ir.as_hlo_text()
                    path.write_text(hlo_text)
                except Exception as e:
                    print(f"Skipping HLO dump for {name}: {e}")
            else:
                # StableHLO is generally supported; write it to file
                path.write_text(str(compiler_ir))

def run_stream(size, iterations, device_name, dtype_name):
    if dtype_name == 'float64':
        # Enable 64-bit floating point support in JAX
        jax.config.update("jax_enable_x64", True)

    # Setup Device and Data Type
    device = get_device(device_name)
    dtype = jnp.float64 if dtype_name == 'float64' else jnp.float32

    element_size = jnp.dtype(dtype).itemsize
    array_size_mb = (size * element_size) / 1024**2
    total_mem_mb = 3 * array_size_mb

    output  = f"Jax version: {jax.__version__}\n"
    output += f"Running STREAM Benchmark on {device.device_kind}\n"
    output += f"Array Size: {size} elements ({array_size_mb:.2f} MB)\n"
    output += f"Total Memory: {total_mem_mb:.2f} MB\n"
    output += f"Data Type: {dtype_name}\n"
    output += f"Iterations: {iterations}\n"
    output += "-" * 60 + "\n"

    # Allocation
    # We allocate tensors once on the target device.
    with jax.default_device(device):
        a = jnp.full((size,), 1.0, dtype=dtype)
        b = jnp.full((size,), 2.0, dtype=dtype)
        c = jnp.full((size,), 3.0, dtype=dtype)
    scalar = 4.0

    a.block_until_ready()

    # JAX uses XLA JIT compilation. Single-op kernels are already
    # compiled efficiently; explicit jax.jit offers no extra benefit
    # for these simple operations.
    # 0. Set:   a = scalar
    # 1. Copy:  c = a
    # 2. Scale: b = scalar * c
    # 3. Add:   c = a + b
    # 4. Triad: a = b + scalar * c

    # Dump Jaxpr for each kernel
    dump_jaxprs(a, b, c, scalar)

    # Dump stable-HLO for each kernel
    dump_stablehlo(a, b, c, scalar)

    def run_set():
        return stream_set(a, scalar)

    def run_copy():
        return stream_copy(a)

    def run_scale():
        return stream_scale(c, scalar)

    def run_add():
        return stream_add(a, b)

    def run_triad():
        return stream_triad(b, c, scalar)

    # Warmup
    output += "Warming up...\n"
    _, _ = time_kernel(run_set, 5, device)
    _, _ = time_kernel(run_copy, 5, device)
    _, _ = time_kernel(run_scale, 5, device)
    _, _ = time_kernel(run_add, 5, device)
    _, _ = time_kernel(run_triad, 5, device)
    output += "Warmup done. Starting timed run...\n"

    # Measure memory before the main loop (warmup results are synchronized
    # inside time_kernel, so the allocator is quiescent here)
    mem_before = get_memory_stats(device)

    # Run; sample allocator stats after each kernel's timed loop
    timing_map = {}
    mem_map = {}
    timing_map['Set']   = time_kernel(run_set, iterations, device)
    mem_map['Set']      = get_memory_stats(device)
    timing_map['Copy']  = time_kernel(run_copy, iterations, device)
    mem_map['Copy']     = get_memory_stats(device)
    timing_map['Scale'] = time_kernel(run_scale, iterations, device)
    mem_map['Scale']    = get_memory_stats(device)
    timing_map['Add']   = time_kernel(run_add, iterations, device)
    mem_map['Add']      = get_memory_stats(device)
    timing_map['Triad'] = time_kernel(run_triad, iterations, device)
    mem_map['Triad']    = get_memory_stats(device)
    mem_after = mem_map['Triad']

    # Reporting
    output += f"{'Function':<15} {'Best Rate (GB/s)':<20} {'Avg Time (s)':<15} {'Min Time (s)':<15}\n"
    output += "-" * 65 + "\n"

    bytes_map = {
        'Set': 1 * size * element_size,
        'Copy': 2 * size * element_size,
        'Scale': 2 * size * element_size,
        'Add': 3 * size * element_size,
        'Triad': 3 * size * element_size
    }

    for name in ['Set', 'Copy', 'Scale', 'Add', 'Triad']:
        times = timing_map[name]
        min_time = times[0]
        avg_time = times[1]

        # Bandwidth in GB/s = (Bytes / 1e9) / time
        # Standard STREAM uses 1e6 for MB/s, we use 1e9 for GB/s usually,
        # but to match strictly, STREAM often reports MB/s (10^6).
        # We will report GB/s (10^9).
        bw = (bytes_map[name] / 1e9) / min_time

        output += f"{name:<15} {bw:<20.4f} {avg_time:<15.6f} {min_time:<15.6f}\n"

    # Memory report
    output += "\nMemory statistics\n"
    if mem_before is not None and mem_after is not None:
        output += f"Device memory before main loop : {format_memory(mem_before['bytes_in_use'])}\n"
        output += f"Device memory after main loop  : {format_memory(mem_after['bytes_in_use'])}\n"
        output += f"Device peak memory             : {format_memory(mem_after['peak_bytes_in_use'])}\n"
        if 'bytes_limit' in mem_after:
            output += f"Device memory limit            : {format_memory(mem_after['bytes_limit'])}\n"
    else:
        output += "Device allocator stats unavailable on this backend (e.g. CPU).\n"
    output += f"Host peak RSS                  : {format_memory(get_host_peak_rss())}\n"

    if mem_before is not None:
        # peak_bytes_in_use cannot be reset, so the per-kernel peak is
        # cumulative: a kernel raised the peak iff its value exceeds the
        # previous row's.
        output += "\nPer-kernel device memory (runtime; peak is cumulative)\n"
        output += f"{'Function':<15} {'In use after':<15} {'Peak after':<15}\n"
        output += "-" * 45 + "\n"
        for name in ['Set', 'Copy', 'Scale', 'Add', 'Triad']:
            stats = mem_map[name]
            output += (f"{name:<15} {format_memory(stats['bytes_in_use']):<15} "
                       f"{format_memory(stats['peak_bytes_in_use']):<15}\n")

    # Static (compiler-reported) memory requirements of each kernel
    kernel_args = {
        'Set':   (stream_set,   (a, scalar)),
        'Copy':  (stream_copy,  (a,)),
        'Scale': (stream_scale, (c, scalar)),
        'Add':   (stream_add,   (a, b)),
        'Triad': (stream_triad, (b, c, scalar)),
    }
    output += "\nPer-kernel compiled memory analysis (compiler-reported)\n"
    output += f"{'Function':<15} {'Argument':<15} {'Output':<15} {'Temp':<15} {'Peak':<15}\n"
    output += "-" * 75 + "\n"
    for name, (fn, fn_args) in kernel_args.items():
        ma = get_compiled_memory_analysis(fn, *fn_args)
        if ma is None:
            output += f"{name:<15} unavailable\n"
        else:
            # peak_memory_in_bytes is missing from CompiledMemoryStats on older jaxlib
            peak = getattr(ma, 'peak_memory_in_bytes', None)
            output += (f"{name:<15} {format_memory(ma.argument_size_in_bytes):<15} "
                       f"{format_memory(ma.output_size_in_bytes):<15} "
                       f"{format_memory(ma.temp_size_in_bytes):<15} "
                       f"{(format_memory(peak) if peak is not None else 'n/a'):<15}\n")

    Path(f"stream_{dtype_name}.txt").write_text(output)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='JAX STREAM Benchmark')
    parser.add_argument('--size', type=int, default=20_000_000,
                        help='Array size (default: 20M elements, approx 160MB for double)')
    parser.add_argument('--nbiter', type=int, default=10,
                        help='Number of iterations (default: 10)')
    parser.add_argument('--device', type=str, default='gpu',
                        choices=['cpu', 'gpu', 'tpu'], help='Device to run on')
    parser.add_argument('--dtype', type=str, default='float64',
                        choices=['float32', 'float64'], help='Data type')

    args = parser.parse_args()
    run_stream(args.size, args.nbiter, args.device, args.dtype)
