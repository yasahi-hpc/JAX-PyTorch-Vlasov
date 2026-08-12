import pytest
import torch
import src.stream


@pytest.fixture(params=["float32", "float64"], ids=["f32", "f64"])
def dtype(request):
    """Parametrized data type fixture."""
    return getattr(torch, request.param)


@pytest.fixture
def device():
    """Device fixture — always CPU for unit tests."""
    return torch.device("cpu")


@pytest.fixture
def small_size():
    """Small array size for fast unit tests."""
    return 1024


@pytest.fixture
def scalar():
    """Standard scalar value used in STREAM kernels."""
    return 4.0


@pytest.fixture
def abc_tensors(small_size, dtype, device):
    """
    Create the standard (a, b, c) tensor triple used in STREAM,
    initialized to a=1, b=2, c=3.
    """
    a = torch.full((small_size,), 1.0, dtype=dtype, device=device)
    b = torch.full((small_size,), 2.0, dtype=dtype, device=device)
    c = torch.full((small_size,), 3.0, dtype=dtype, device=device)
    return a, b, c
