import pytest
import torch
import src.stream


class TestGetDevice:
    """Tests for the get_device helper."""

    def test_cpu_fallback(self):
        """Requesting 'cpu' always returns cpu."""
        device = src.stream.get_device("cpu")
        assert device == torch.device("cpu")

    def test_cuda_unavailable_falls_back_to_cpu(self):
        """If cuda is unavailable, get_device('cuda') returns cpu."""
        if torch.cuda.is_available():
            pytest.skip("CUDA is available — cannot test fallback")
        device = src.stream.get_device("cuda")
        assert device == torch.device("cpu")

    def test_cuda_available_returns_cuda(self):
        """If cuda is available, get_device('cuda') returns cuda."""
        if not torch.cuda.is_available():
            pytest.skip("CUDA is not available")
        device = src.stream.get_device("cuda")
        assert device.type == "cuda"

    def test_unknown_device_returns_cpu(self):
        """An unrecognized device string should fall back to cpu."""
        device = src.stream.get_device("xpu")
        assert device == torch.device("cpu")


class TestSynchronize:
    """Tests for the synchronize helper."""

    def test_synchronize_cpu_does_not_raise(self):
        """synchronize on CPU should be a no-op and not raise."""
        src.stream.synchronize(torch.device("cpu"))

    @pytest.mark.skipif(not torch.cuda.is_available(), reason="No CUDA")
    def test_synchronize_cuda_does_not_raise(self):
        src.stream.synchronize(torch.device("cuda"))


class TestTimeKernel:
    """Tests for the time_kernel timing helper."""

    def test_returns_best_and_avg(self):
        """time_kernel should return a (best, avg) tuple."""
        counter = {"n": 0}

        def dummy():
            counter["n"] += 1

        best, avg = src.stream.time_kernel(dummy, 5, torch.device("cpu"))
        assert counter["n"] == 5
        assert isinstance(best, float)
        assert isinstance(avg, float)

    def test_best_leq_avg(self):
        """Best time should always be <= average time."""
        best, avg = src.stream.time_kernel(lambda: None, 10, torch.device("cpu"))
        assert best <= avg + 1e-15  # small epsilon for floating-point

    def test_single_iteration(self):
        """With 1 iteration, best == avg."""
        best, avg = src.stream.time_kernel(lambda: None, 1, torch.device("cpu"))
        assert best == pytest.approx(avg)

    def test_times_are_positive(self):
        """All returned times should be positive."""
        best, avg = src.stream.time_kernel(lambda: None, 5, torch.device("cpu"))
        assert best > 0
        assert avg > 0
