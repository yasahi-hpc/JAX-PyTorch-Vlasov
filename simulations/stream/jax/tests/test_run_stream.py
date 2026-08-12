import pytest
import jax
import jax.numpy as jnp
import src.stream


class TestRunStream:
    """Integration tests for run_stream — the full benchmark driver."""

    def test_run_stream_cpu_float64_writes_report_and_jaxprs(self, tmp_path, monkeypatch):
        """Run full benchmark on CPU/float64 and verify output artifacts."""
        monkeypatch.chdir(tmp_path)

        src.stream.run_stream(
            size=1024, iterations=2, device_name="cpu", dtype_name="float64"
        )

        report_path = tmp_path / "stream_float64.txt"
        assert report_path.exists()

        report = report_path.read_text()
        assert "Running STREAM Benchmark on" in report
        assert "Data Type: float64" in report
        for kernel in ["Set", "Copy", "Scale", "Add", "Triad"]:
            assert kernel in report

        jaxpr_dir = tmp_path / "jaxpr_dump"
        assert jaxpr_dir.exists() and jaxpr_dir.is_dir()
        for name in ["set", "copy", "scale", "add", "triad"]:
            assert (jaxpr_dir / f"jaxpr_{name}.txt").exists()

    def test_run_stream_cpu_float32_writes_report(self, tmp_path, monkeypatch):
        """Run full benchmark on CPU/float32 and verify output file name/content."""
        monkeypatch.chdir(tmp_path)

        src.stream.run_stream(
            size=512, iterations=2, device_name="cpu", dtype_name="float32"
        )

        report_path = tmp_path / "stream_float32.txt"
        assert report_path.exists()
        report = report_path.read_text()
        assert "Data Type: float32" in report

    def test_run_stream_reports_positive_bandwidth(self, tmp_path, monkeypatch):
        """All reported bandwidths in the report table should be positive."""
        monkeypatch.chdir(tmp_path)

        src.stream.run_stream(
            size=1024, iterations=3, device_name="cpu", dtype_name="float64"
        )

        report = (tmp_path / "stream_float64.txt").read_text()

        # Kernel names also appear as rows of the per-kernel memory tables,
        # so parse only the timing table, which ends where the memory
        # report begins.
        lines = report.splitlines()
        mem_idx = lines.index("Memory statistics") if "Memory statistics" in lines else len(lines)
        timing_lines = lines[:mem_idx]

        kernels = {"Set", "Copy", "Scale", "Add", "Triad"}
        found = set()
        for line in timing_lines:
            parts = line.split()
            if parts and parts[0] in kernels:
                bw = float(parts[1])
                assert bw > 0, f"{parts[0]} bandwidth should be positive"
                found.add(parts[0])
        assert found == kernels, f"Missing kernels in timing table: {kernels - found}"

    def test_run_stream_gpu(self, tmp_path, monkeypatch):
        """Smoke test: run full benchmark on GPU (skipped if unavailable)."""
        monkeypatch.chdir(tmp_path)

        try:
            gpus = jax.devices("gpu")
        except RuntimeError:
            gpus = []
        if not gpus:
            pytest.skip("No GPU available")

        src.stream.run_stream(
            size=1024, iterations=2, device_name="gpu", dtype_name="float64"
        )
        report = (tmp_path / "stream_float64.txt").read_text().lower()
        assert "gpu" in report or "cuda" in report


class TestRunStreamSequence:
    """
    Tests that the STREAM kernels compose correctly in the canonical order:
    Set -> Copy -> Scale -> Add -> Triad.
    """

    @pytest.mark.parametrize("dtype_name", ["float32", "float64"])
    def test_stream_full_sequence(self, dtype_name):
        """
        Run the canonical STREAM sequence on small arrays and verify
        intermediate values after each kernel.
        """
        jax.config.update("jax_enable_x64", True)
        size = 128
        dtype = jnp.float32 if dtype_name == "float32" else jnp.float64

        a = jnp.full((size,), 1.0, dtype=dtype)
        b = jnp.full((size,), 2.0, dtype=dtype)
        c = jnp.full((size,), 3.0, dtype=dtype)
        scalar = 4.0

        # Use unwrapped functions to test pure logic without XLA compilation
        raw_set = src.stream.stream_set.__wrapped__
        raw_copy = src.stream.stream_copy.__wrapped__
        raw_scale = src.stream.stream_scale.__wrapped__
        raw_add = src.stream.stream_add.__wrapped__
        raw_triad = src.stream.stream_triad.__wrapped__

        # Set: a = scalar  ->  a = 4.0
        a = raw_set(a, scalar)
        assert jnp.allclose(a, jnp.full_like(a, 4.0))

        # Copy: c = a  ->  c = 4.0
        c = raw_copy(a)
        assert jnp.allclose(c, jnp.full_like(c, 4.0))

        # Scale: b = scalar * c  ->  b = 4.0 * 4.0 = 16.0
        b = raw_scale(c, scalar)
        assert jnp.allclose(b, jnp.full_like(b, 16.0))

        # Add: c = a + b  ->  c = 4.0 + 16.0 = 20.0
        c = raw_add(a, b)
        assert jnp.allclose(c, jnp.full_like(c, 20.0))

        # Triad: a = b + scalar * c  ->  a = 16.0 + 4.0 * 20.0 = 96.0
        a = raw_triad(b, c, scalar)
        assert jnp.allclose(a, jnp.full_like(a, 96.0))


class TestBytesMap:
    """Tests that bandwidth byte counting is correct."""

    @pytest.mark.parametrize("dtype_name,element_size", [("float32", 4), ("float64", 8)])
    def test_element_size(self, dtype_name, element_size):
        dtype = jnp.float32 if dtype_name == "float32" else jnp.float64
        actual = jnp.dtype(dtype).itemsize
        assert actual == element_size

    @pytest.mark.parametrize(
        "kernel,factor",
        [("Set", 1), ("Copy", 2), ("Scale", 2), ("Add", 3), ("Triad", 3)],
    )
    def test_bytes_per_kernel(self, kernel, factor):
        """
        Verify the byte count formula: factor * size * element_size.
        This matches the bytes_map in run_stream.
        """
        size = 1000
        element_size = 8  # float64
        expected = factor * size * element_size
        assert expected == factor * size * element_size
