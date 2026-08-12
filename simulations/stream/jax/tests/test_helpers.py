import pytest
import jax
import src.stream


class TestGetDevice:
    """Tests for the get_device helper."""

    def test_cpu_returns_cpu(self):
        """Requesting 'cpu' always returns a CPU device."""
        device = src.stream.get_device("cpu")
        assert device.platform == "cpu"

    def test_cuda_unavailable_falls_back_to_cpu(self):
        """If GPU is unavailable, get_device('cuda') returns cpu."""
        try:
            gpus = jax.devices("gpu")
        except RuntimeError:
            gpus = []
        if gpus:
            pytest.skip("GPU is available — cannot test fallback")
        device = src.stream.get_device("cuda")
        assert device.platform == "cpu"

    def test_cuda_available_returns_gpu(self):
        """If GPU is available, get_device('cuda') returns a GPU device."""
        try:
            gpus = jax.devices("gpu")
        except RuntimeError:
            gpus = []
        if not gpus:
            pytest.skip("GPU is not available")
        device = src.stream.get_device("cuda")
        assert device.platform == "gpu"

    def test_unknown_device_returns_cpu(self):
        """An unrecognized device string should fall back to cpu."""
        device = src.stream.get_device("xpu")
        assert device.platform == "cpu"


class TestSynchronize:
    """Tests for the synchronize helper."""

    def test_synchronize_cpu_does_not_raise(self):
        """synchronize on CPU should be a no-op and not raise."""
        device = jax.devices("cpu")[0]
        src.stream.synchronize(device)


class TestTimeKernel:
    """Tests for the time_kernel timing helper."""

    def test_returns_best_and_avg(self):
        """time_kernel should return a (best, avg) tuple."""
        counter = {"n": 0}

        def dummy():
            counter["n"] += 1

        device = jax.devices("cpu")[0]
        best, avg = src.stream.time_kernel(dummy, 5, device)
        assert counter["n"] == 5
        assert isinstance(best, float)
        assert isinstance(avg, float)

    def test_best_leq_avg(self):
        """Best time should always be <= average time."""
        device = jax.devices("cpu")[0]
        best, avg = src.stream.time_kernel(lambda: None, 10, device)
        assert best <= avg + 1e-15  # small epsilon for floating-point

    def test_single_iteration(self):
        """With 1 iteration, best == avg."""
        device = jax.devices("cpu")[0]
        best, avg = src.stream.time_kernel(lambda: None, 1, device)
        assert best == pytest.approx(avg)

    def test_times_are_positive(self):
        """All returned times should be positive."""
        device = jax.devices("cpu")[0]
        best, avg = src.stream.time_kernel(lambda: None, 5, device)
        assert best > 0
        assert avg > 0
