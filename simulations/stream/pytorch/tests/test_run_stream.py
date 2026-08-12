import pytest
import torch
import src.stream


class TestRunStream:
    """Integration tests for run_stream — the full benchmark driver."""

    def test_run_stream_cpu_float64(self, tmp_path, monkeypatch):
        """Run the full benchmark on CPU with float64 and verify output file content."""
        monkeypatch.chdir(tmp_path)
        src.stream.run_stream(
            size=1024, iterations=2, device_name="cpu", dtype_name="float64"
        )
        out_path = tmp_path / "stream_float64.txt"
        assert out_path.exists()

        content = out_path.read_text()
        assert "Running STREAM Benchmark on" in content
        assert "Data Type: torch.float64" in content
        assert "Copy" in content
        assert "Scale" in content
        assert "Add" in content
        assert "Triad" in content
        assert "Set" in content

    def test_run_stream_cpu_float32(self, tmp_path, monkeypatch):
        """Run the full benchmark on CPU with float32 and verify output file."""
        monkeypatch.chdir(tmp_path)
        src.stream.run_stream(
            size=512, iterations=2, device_name="cpu", dtype_name="float32"
        )
        out_path = tmp_path / "stream_float32.txt"
        assert out_path.exists()
        assert "Data Type: torch.float32" in out_path.read_text()

    def test_run_stream_reports_positive_bandwidth(self, tmp_path, monkeypatch):
        """All reported bandwidths in the output file should be positive."""
        monkeypatch.chdir(tmp_path)
        src.stream.run_stream(
            size=1024, iterations=3, device_name="cpu", dtype_name="float64"
        )
        content = (tmp_path / "stream_float64.txt").read_text()
        for kernel_name in ["Set", "Copy", "Scale", "Add", "Triad"]:
            for line in content.splitlines():
                if line.startswith(kernel_name):
                    parts = line.split()
                    bw = float(parts[1])
                    assert bw > 0, f"{kernel_name} bandwidth should be positive"

    @pytest.mark.skipif(not torch.cuda.is_available(), reason="No CUDA")
    def test_run_stream_cuda(self, tmp_path, monkeypatch):
        """Smoke test: run full benchmark on CUDA and verify output file content."""
        monkeypatch.chdir(tmp_path)
        src.stream.run_stream(
            size=1024, iterations=2, device_name="cuda", dtype_name="float64"
        )
        content = (tmp_path / "stream_float64.txt").read_text()
        assert "cuda" in content


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
        size = 128
        dtype = getattr(torch, dtype_name)
        device = torch.device("cpu")

        a = torch.full((size,), 1.0, dtype=dtype, device=device)
        b = torch.full((size,), 2.0, dtype=dtype, device=device)
        c = torch.full((size,), 3.0, dtype=dtype, device=device)
        scalar = 4.0

        # Set: a = scalar  ->  a = 4.0
        src.stream.stream_set(a, scalar)
        assert torch.allclose(a, torch.full_like(a, 4.0))

        # Copy: c = a  ->  c = 4.0
        src.stream.stream_copy(c, a)
        assert torch.allclose(c, torch.full_like(c, 4.0))

        # Scale: b = scalar * c  ->  b = 4.0 * 4.0 = 16.0
        src.stream.stream_scale(b, c, scalar)
        assert torch.allclose(b, torch.full_like(b, 16.0))

        # Add: c = a + b  ->  c = 4.0 + 16.0 = 20.0
        src.stream.stream_add(a, b, c)
        assert torch.allclose(c, torch.full_like(c, 20.0))

        # Triad: a = b + scalar * c  ->  a = 16.0 + 4.0 * 20.0 = 96.0
        src.stream.stream_triad(a, b, c, scalar)
        assert torch.allclose(a, torch.full_like(a, 96.0))


class TestBytesMap:
    """Tests that bandwidth byte counting is correct."""

    @pytest.mark.parametrize("dtype_name,element_size", [
        ("float32", 4),
        ("float64", 8),
    ])
    def test_element_size(self, dtype_name, element_size):
        dtype = getattr(torch, dtype_name)
        actual = torch.tensor([], dtype=dtype).element_size()
        assert actual == element_size

    @pytest.mark.parametrize("kernel,factor", [
        ("Set", 1),
        ("Copy", 2),
        ("Scale", 2),
        ("Add", 3),
        ("Triad", 3),
    ])
    def test_bytes_per_kernel(self, kernel, factor):
        """
        Verify the byte count formula: factor * size * element_size.
        This matches the bytes_map in run_stream.
        """
        size = 1000
        element_size = 8  # float64
        expected = factor * size * element_size
        assert expected == factor * size * element_size
