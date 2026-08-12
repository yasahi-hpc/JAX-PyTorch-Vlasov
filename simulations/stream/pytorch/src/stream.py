import os
# Workaround for Triton compilation on aarch64 with CC=nvc
if os.environ.get("CC") and "nvc" in os.environ["CC"]:
    os.environ["CC"] = "gcc"

import platform
import torch
import torch._dynamo as dynamo
import time
import argparse
from pathlib import Path

def get_device(device_arg):
    if device_arg == 'cuda' and torch.cuda.is_available():
        return torch.device('cuda')
    elif device_arg == 'xpu' and torch.xpu.is_available():
        return torch.device('xpu')
    elif device_arg == 'mps' and torch.backends.mps.is_available():
        return torch.device('mps')
    return torch.device('cpu')

def get_device_label(device: torch.device) -> str:
    if device.type == 'cuda':
        idx = device.index if device.index is not None else torch.cuda.current_device()
        return f"{torch.cuda.get_device_name(idx)} (cuda:{idx})"
    elif device.type == 'mps':
        return "Apple Silicon (mps)"
    elif device.type == 'xpu':
        return "Intel XPU (xpu)"
    else:
        cpu_name = platform.processor() or platform.machine()
        return f"{cpu_name} (cpu)"

# Helper for synchronization
def synchronize(device: torch.device):
    if device.type == 'cuda':
        torch.cuda.synchronize()
    elif device.type == 'mps':
        torch.mps.synchronize()
    elif device.type == 'xpu':
        torch.xpu.synchronize()

def reset_peak_memory(device: torch.device):
    if device.type == 'cuda':
        torch.cuda.reset_peak_memory_stats(device)
    elif device.type == 'xpu':
        torch.xpu.reset_peak_memory_stats(device)

def get_memory_stats(device: torch.device):
    synchronize(device)

    if device.type == 'cuda':
        return {
            'allocated': torch.cuda.memory_allocated(device),
            'reserved': torch.cuda.memory_reserved(device),
            'peak_allocated': torch.cuda.max_memory_allocated(device),
            'peak_reserved': torch.cuda.max_memory_reserved(device),
        }

    elif device.type == 'xpu':
        return {
            'allocated': torch.xpu.memory_allocated(device),
            'reserved': torch.xpu.memory_reserved(device),
            'peak_allocated': torch.xpu.max_memory_allocated(device),
            'peak_reserved': torch.xpu.max_memory_reserved(device),
        }

    return None

def print_memory_summary(device: torch.device, filename: str) -> None:
    if device.type == 'cuda':
        summary = torch.cuda.memory_summary(abbreviated=False)
        with open(filename, 'w') as f:
            f.write(summary)

def format_memory(num_bytes: int) -> str:
    return f"{num_bytes / (1024 ** 2):.2f} MiB"

def time_kernel(fn, nbiter: int, device: torch.device):
    times = []
    synchronize(device)
    for _ in range(nbiter):
        start = time.perf_counter()
        fn()
        synchronize(device)
        times.append(time.perf_counter() - start)

    best = min(times)
    avg = sum(times) / len(times)
    return best, avg

def stream_set(a: torch.Tensor, scalar: float) -> None:
    a.fill_(scalar)

def stream_copy(c: torch.Tensor, a: torch.Tensor) -> None:
    c.copy_(a)

def stream_scale(b: torch.Tensor, c: torch.Tensor, scalar: float) -> None:
    torch.mul(c, scalar, out=b)

def stream_add(a: torch.Tensor, b: torch.Tensor, c: torch.Tensor) -> None:
    torch.add(a, b, out=c)

def stream_triad(a: torch.Tensor, b: torch.Tensor, c: torch.Tensor, scalar: float) -> None:
    torch.add(b, c, alpha=scalar, out=a)

def export_stream_dynamo_report(name: str, fn, output_path: Path, *args) -> None:
    dynamo.reset()
    explain_output = dynamo.explain(fn)(*args)
    dynamo_report = str(explain_output)
    output_path.write_text(dynamo_report)

def export_stream_fx_graph(name: str, fn, output_path: Path, *args) -> None:
    """Capture the FX graph(s) TorchDynamo traces for `fn`, before any lowering."""
    dynamo.reset()
    graphs = []

    def capture_backend(gm: torch.fx.GraphModule, example_inputs):
        graphs.append(gm)
        return gm.forward  # run eagerly, no lowering

    compiled = torch.compile(fn, backend=capture_backend)
    with torch.no_grad():
        compiled(*args)

    text = []
    for i, gm in enumerate(graphs):
        text.append(f"# ===== Dynamo FX graph {i} (readable) =====\n")
        text.append(gm.print_readable(print_output=False))
        text.append(f"\n# ===== Dynamo FX graph {i} (node table) =====\n")
        text.append(str(gm.graph))
        text.append("\n")
    output_path.write_text("".join(text))
    dynamo.reset()

def run_stream(size, iterations, device_name, dtype_name):
    # Setup Device and Data Type
    device = get_device(device_name)
    dtype = getattr(torch, dtype_name)

    element_size = torch.tensor([], dtype=dtype).element_size()
    array_size_mb = (size * element_size) / 1024**2
    total_mem_mb = 3 * array_size_mb

    output = f"PyTorch version: {torch.__version__}\n"
    output += f"Running STREAM Benchmark on {get_device_label(device)}\n"
    output += f"Array Size: {size} elements ({array_size_mb:.2f} MB)\n"
    output += f"Total Memory: {total_mem_mb:.2f} MB\n"
    output += f"Data Type: {dtype}\n"
    output += f"Iterations: {iterations}\n"
    output += "-" * 60 + "\n"

    # Allocation
    # We allocate tensors once. No new memory is allocated inside the loop.
    a = torch.full((size,), 1.0, dtype=dtype, device=device)
    b = torch.full((size,), 2.0, dtype=dtype, device=device)
    c = torch.full((size,), 3.0, dtype=dtype, device=device)
    scalar = 4.0

    dynamo_dir = Path("dynamo_graphs")
    dynamo_dir.mkdir(parents=True, exist_ok=True)

    # Kernels use raw PyTorch ops (no torch.compile).
    # For single-op kernels, torch.compile adds overhead (guard checks,
    # Triton codegen) without benefit — there are no ops to fuse.
    # 0. Set:   a = scalar
    # 1. Copy:  c = a
    # 2. Scale: b = scalar * c
    # 3. Add:   c = a + b
    # 4. Triad: a = b + scalar * c

    # Reset peak memory statistics so the compilation phase is excluded
    synchronize(device)
    reset_peak_memory(device)

    # Memory before benchmark
    mem_before = get_memory_stats(device)

    # Disable autograd — pure memory bandwidth test, no gradients needed
    with torch.no_grad():
        export_stream_dynamo_report("stream_set", stream_set, dynamo_dir / "stream_set.txt", a, scalar)
        export_stream_dynamo_report("stream_copy", stream_copy, dynamo_dir / "stream_copy.txt", c, a)
        export_stream_dynamo_report("stream_scale", stream_scale, dynamo_dir / "stream_scale.txt", b, c, scalar)
        export_stream_dynamo_report("stream_add", stream_add, dynamo_dir / "stream_add.txt", a, b, c)
        export_stream_dynamo_report("stream_triad", stream_triad, dynamo_dir / "stream_triad.txt", a, b, c, scalar)

        export_stream_fx_graph("stream_set", stream_set, dynamo_dir / "stream_set_fx_graph.txt", a, scalar)
        export_stream_fx_graph("stream_copy", stream_copy, dynamo_dir / "stream_copy_fx_graph.txt", c, a)
        export_stream_fx_graph("stream_scale", stream_scale, dynamo_dir / "stream_scale_fx_graph.txt", b, c, scalar)
        export_stream_fx_graph("stream_add", stream_add, dynamo_dir / "stream_add_fx_graph.txt", a, b, c)
        export_stream_fx_graph("stream_triad", stream_triad, dynamo_dir / "stream_triad_fx_graph.txt", a, b, c, scalar)

        # Warmup
        output += "Warming up...\n"
        _ = time_kernel(lambda: stream_set(a, scalar), 5, device)
        _ = time_kernel(lambda: stream_copy(c, a), 5, device)
        _ = time_kernel(lambda: stream_scale(b, c, scalar), 5, device)
        _ = time_kernel(lambda: stream_add(a, b, c), 5, device)
        _ = time_kernel(lambda: stream_triad(a, b, c, scalar), 5, device)
        output += "Warmup done. Starting timed run...\n"

        # Run
        timing_map = {}
        synchronize(device)
        timing_map['Set'] = time_kernel(lambda: stream_set(a, scalar), iterations, device)
        timing_map['Copy'] = time_kernel(lambda: stream_copy(c, a), iterations, device)
        timing_map['Scale'] = time_kernel(lambda: stream_scale(b, c, scalar), iterations, device)
        timing_map['Add'] = time_kernel(lambda: stream_add(a, b, c), iterations, device)
        timing_map['Triad'] = time_kernel(lambda: stream_triad(a, b, c, scalar), iterations, device)
        synchronize(device)

    # Memory after benchmark
    mem_after = get_memory_stats(device)

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
        min_time, avg_time = times

        # Bandwidth in GB/s = (Bytes / 1e9) / time
        # Standard STREAM uses 1e6 for MB/s, we use 1e9 for GB/s usually,
        # but to match strictly, STREAM often reports MB/s (10^6).
        # We will report GB/s (10^9).
        bw = (bytes_map[name] / 1e9) / min_time

        output += f"{name:<15} {bw:<20.4f} {avg_time:<15.6f} {min_time:<15.6f}\n"

    if mem_before is not None:
        output += "\nMemory statistics\n"
        output += (
            f"Allocated before benchmark : "
            f"{format_memory(mem_before['allocated'])}\n"
        )
        output += (
            f"Reserved before benchmark  : "
            f"{format_memory(mem_before['reserved'])}\n"
        )
        output += (
            f"Peak allocated             : "
            f"{format_memory(mem_after['peak_allocated'])}\n"
        )
        output += (
            f"Peak reserved              : "
            f"{format_memory(mem_after['peak_reserved'])}\n"
        )

    Path(f"stream_{dtype_name}.txt").write_text(output)
    print_memory_summary(device, f"stream_{dtype_name}_memory.txt")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='PyTorch STREAM Benchmark')
    parser.add_argument('--size', type=int, default=20_000_000,
                        help='Array size (default: 20M elements, approx 160MB for double)')
    parser.add_argument('--nbiter', type=int, default=10,
                        help='Number of iterations (default: 10)')
    parser.add_argument('--device', type=str, default='cuda',
                        choices=['cpu', 'cuda', 'mps', 'xpu'], help='Device to run on')
    parser.add_argument('--dtype', type=str, default='float64',
                        choices=['float32', 'float64'], help='Data type')

    args = parser.parse_args()
    run_stream(args.size, args.nbiter, args.device, args.dtype)
