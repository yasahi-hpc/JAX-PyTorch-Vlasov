import numpy as np
import jax
import jax.numpy as jnp
import pytest

from src.memory_measurements import (
    get_memory_stats,
    get_host_peak_rss,
    get_compiled_memory_analysis,
    format_memory,
)


class TestFormatMemory:
    def test_one_mib(self):
        assert format_memory(1024**2) == "1.00 MiB"

    def test_zero(self):
        assert format_memory(0) == "0.00 MiB"

    def test_fractional(self):
        assert format_memory(1536 * 1024) == "1.50 MiB"

    def test_large(self):
        assert format_memory(512 * 1024**2) == "512.00 MiB"


class TestGetMemoryStats:
    def test_default_device_does_not_raise(self):
        stats = get_memory_stats()
        # None on backends without allocator statistics (e.g. CPU),
        # otherwise a dict with allocator counters.
        assert stats is None or isinstance(stats, dict)

    def test_explicit_device(self):
        device = jax.local_devices()[0]
        stats = get_memory_stats(device)
        assert stats == get_memory_stats()

    def test_expected_keys_when_available(self):
        stats = get_memory_stats()
        if stats is None:
            pytest.skip("Backend does not expose allocator statistics")
        assert "bytes_in_use" in stats
        assert "peak_bytes_in_use" in stats
        assert stats["peak_bytes_in_use"] >= stats["bytes_in_use"] >= 0


class TestGetHostPeakRss:
    def test_positive(self):
        assert get_host_peak_rss() > 0

    def test_monotonic(self):
        # Peak RSS is a high-water mark and can never decrease.
        first = get_host_peak_rss()
        second = get_host_peak_rss()
        assert second >= first

    def test_covers_live_allocation(self):
        # A live 64 MiB host array must be below the process peak RSS.
        n_bytes = 64 * 1024**2
        buf = np.ones(n_bytes // 8, dtype=np.float64)
        assert get_host_peak_rss() >= buf.nbytes


class TestGetCompiledMemoryAnalysis:
    def test_reports_argument_and_output_sizes(self):
        shape = (128, 128)
        x = jnp.ones(shape, dtype=jnp.float32)
        fn = jax.jit(lambda u: u * 2.0 + 1.0)
        analysis = get_compiled_memory_analysis(fn, x)
        if analysis is None:
            pytest.skip("Backend does not implement memory_analysis()")
        nbytes = np.prod(shape) * 4
        assert analysis.argument_size_in_bytes >= nbytes
        assert analysis.output_size_in_bytes >= nbytes
        assert analysis.temp_size_in_bytes >= 0

    def test_hits_jit_cache(self):
        x = jnp.ones((16,), dtype=jnp.float32)
        fn = jax.jit(lambda u: u + 1.0)
        fn(x).block_until_ready()  # warm up
        analysis = get_compiled_memory_analysis(fn, x)
        assert analysis is None or analysis.argument_size_in_bytes >= x.nbytes

    def test_returns_none_on_failure(self):
        # A plain (non-jitted) function has no .lower() -> graceful None.
        assert get_compiled_memory_analysis(lambda u: u, 1.0) is None
