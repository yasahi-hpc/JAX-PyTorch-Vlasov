# PyTorch STREAM Benchmark

A PyTorch implementation of the [STREAM benchmark](https://www.cs.virginia.edu/stream/), measuring sustainable memory bandwidth on CPU and GPU devices.

## Overview

The STREAM benchmark measures memory bandwidth through four simple vector operations:

| Kernel | Operation | Bytes per element |
|--------|-----------|-------------------|
| **Set** | `a[:] = scalar` | 1 × sizeof(dtype) (write only) |
| **Copy** | `c[:] = a[:]` | 2 × sizeof(dtype) (1 read + 1 write) |
| **Scale** | `b[:] = scalar × c[:]` | 2 × sizeof(dtype) (1 read + 1 write) |
| **Add** | `c[:] = a[:] + b[:]` | 3 × sizeof(dtype) (2 reads + 1 write) |
| **Triad** | `a[:] = b[:] + scalar × c[:]` | 3 × sizeof(dtype) (2 reads + 1 write) |

## Sample Results (NVIDIA H200, float64)

```
Function        Best Rate (GB/s)     Avg Time (s)    Min Time (s)
-----------------------------------------------------------------
Set             2912.0551            0.000057        0.000055
Copy            2554.9111            0.000128        0.000125
Scale           2938.5570            0.000110        0.000109
Add             3285.8711            0.000147        0.000146
Triad           3244.6465            0.000149        0.000148
```

## Project Structure

```
pytorch/
├── src/
│   ├── __init__.py
│   ├── stream.py              # Main benchmark implementation
│   └── analyze_compile.py     # torch.compile introspection tool
├── tests/
│   ├── conftest.py            # Shared pytest fixtures
│   ├── test_kernels.py        # Unit tests for each STREAM kernel
│   ├── test_helpers.py        # Tests for utility functions
│   └── test_run_stream.py     # Integration tests for the full benchmark
├── investigation.md           # Detailed performance investigation notes
├── sub_miyabi.sh              # Job submission script
└── README.md
```

## Usage

```bash
# Default: 20M elements, float64, CUDA, 10 iterations
python -m src.stream

# Custom configuration
python -m src.stream --size 50000000 --dtype float32 --device cpu --nbiter 20
```

### Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `--size` | 20,000,000 | Number of array elements |
| `--nbiter` | 10 | Number of timed iterations (reports best-of-N) |
| `--device` | `cuda` | Device: `cpu`, `cuda`, or `mps` |
| `--dtype` | `float64` | Data type: `float32` or `float64` |

## Running Tests

```bash
conda activate torch_env
cd pytorch/
python -m pytest tests/ -v
```

### Test Coverage

| File | Tests | Coverage |
|------|-------|----------|
| `test_kernels.py` | 30 | Each kernel: correctness, edge cases (zero, negative, identity), dtype preservation, source immutability. Parametrized over float32/float64. |
| `test_helpers.py` | 10 | `get_device` (fallback logic), `synchronize` (no-op on CPU), `time_kernel` (return types, best ≤ avg, positivity). |
| `test_run_stream.py` | 9 | Full `run_stream()` smoke tests, output parsing, canonical Set→Copy→Scale→Add→Triad sequence with value chain verification, element size and byte-count checks. |
| `conftest.py` | — | Shared fixtures: `dtype` (parametrized f32/f64), `device`, `small_size`, `scalar`, `abc_tensors`. |

## Performance Investigation & Best Practices

A detailed investigation was conducted to understand a ~20% performance gap between two implementations. The findings provide general best practices for PyTorch GPU benchmarking.

### Issues Found

#### 1. Use `time.perf_counter()`, not `time.time()`

`time.time()` has ~ms resolution on Linux — too coarse for GPU kernels completing in 100–180μs. `time.perf_counter()` provides sub-μs resolution.

#### 2. Always use multiple iterations and report the minimum

A single timing sample is noisy and biased. The benchmark should run N iterations and report `min(times)` as the best-case bandwidth.

#### 3. Do NOT use `@torch.compile` on single-op kernels (Root Cause)

This was the **primary cause of the ~20% slowdown**. For trivially simple single-operation kernels (e.g., a single `torch.mul` or `torch.add`):

- **Dynamo guard checks** run in Python on every call, verifying tensor shape, dtype, stride, device, and memory layout.
- **No fusion opportunity** — `torch.compile` benefits come from fusing multiple operations into a single GPU kernel. A single op has nothing to fuse.
- For kernels completing in ~100–180μs, even 10–30μs of guard overhead causes a ~15–20% slowdown.

| Kernel | With `@torch.compile` (20M) | Without `@torch.compile` (20M) | Overhead |
|--------|----------------------------|-------------------------------|----------|
| Scale  | 2402 GB/s                  | 2939 GB/s                     | -18%     |
| Add    | 2671 GB/s                  | 3286 GB/s                     | -19%     |
| Triad  | 2706 GB/s                  | 3245 GB/s                     | -17%     |

> **Rule of thumb**: Use `@torch.compile` when there are **multiple operations to fuse** (e.g., a stencil computation with 6 `torch.roll` + additions). For single-op memory-bound kernels, raw PyTorch ops with `out=` parameters are optimal.

#### 4. Larger arrays amortize compile overhead but don't eliminate it

The guard-check overhead is a **fixed per-call cost** (~20μs), independent of array size:

| Array Size | Data (Scale) | Kernel Time | ~20μs overhead as % |
|------------|-------------|-------------|---------------------|
| N=20M      | 320 MB      | ~107 μs     | **~19%**            |
| N=50M      | 800 MB      | ~267 μs     | **~7.5%**           |

Even at 50M elements, the compiled version (2979 GB/s) is still slightly slower than the non-compiled 20M version (3057 GB/s).

#### 5. Use `torch.no_grad()` for non-training workloads

Wrapping the benchmark in `torch.no_grad()` eliminates autograd dispatch overhead for pure forward-pass / numerical simulation code.

#### 6. Warm up sufficiently

At least 3–5 warmup iterations ensure CUDA context initialization, memory pools, and caches are warm before the timed run.

### When TO use `@torch.compile`

`torch.compile` excels when there are **multiple operations to fuse**. For example, a 3D heat equation stencil:

```python
@torch.compile
def step(u, coeff):
    # 6 rolls + additions + multiply → all fused into one Triton kernel
    left   = torch.roll(u, -1, 0)
    right  = torch.roll(u,  1, 0)
    up     = torch.roll(u, -1, 1)
    down   = torch.roll(u,  1, 1)
    front  = torch.roll(u, -1, 2)
    back   = torch.roll(u,  1, 2)
    laplacian = (left + right + up + down + front + back) - (6.0 * u)
    return u + coeff * laplacian
```

This achieves ~2817 GB/s on H200 because `torch.compile` fuses 8+ operations into a single kernel launch.

### Debugging `torch.compile` (Equivalent to JAX's `jaxpr`)

| Tool | JAX Equivalent | What it shows |
|------|----------------|---------------|
| `torch._dynamo.explain(fn)(*args)` | `jax.make_jaxpr(fn)(*args)` | Graph breaks, guard count, captured graph |
| `TORCH_LOGS="graph_code"` | `jax.make_jaxpr` output | FX Graph IR (operator-level) |
| `TORCH_LOGS="output_code"` | `jit(fn).lower().compile().as_text()` | Generated Triton/C++ kernel source |
| `TORCH_LOGS="guards"` | — | Guard conditions checked per call |

See `src/analyze_compile.py` for a working example.
