"""
Helpers to measure device and host memory consumption of JAX programs.

Device statistics come from the public jax.Device.memory_stats() API and are
only available on backends whose allocator exposes them (GPU/TPU PJRT).
Host statistics fall back to the process peak RSS. Compiler-reported
requirements of a jitted function are obtained through the AOT API
(lower/compile/memory_analysis).
"""
import resource
import jax


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
