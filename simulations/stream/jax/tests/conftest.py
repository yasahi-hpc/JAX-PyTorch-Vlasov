import pytest
import jax
import jax.numpy as jnp


def pytest_configure(config):
    """Enable 64-bit floating point in JAX for the entire test session."""
    jax.config.update("jax_enable_x64", True)


@pytest.fixture(params=["float32", "float64"], ids=["f32", "f64"])
def dtype(request):
    """Parametrized data type fixture."""
    return jnp.float32 if request.param == "float32" else jnp.float64


@pytest.fixture
def device():
    """Device fixture — always CPU for unit tests."""
    return jax.devices("cpu")[0]


@pytest.fixture
def small_size():
    """Small array size for fast unit tests."""
    return 1024


@pytest.fixture
def scalar():
    """Standard scalar value used in STREAM kernels."""
    return 4.0


@pytest.fixture
def abc_arrays(small_size, dtype, device):
    """
    Create the standard (a, b, c) array triple used in STREAM,
    initialized to a=1, b=2, c=3.
    """
    with jax.default_device(device):
        a = jnp.full((small_size,), 1.0, dtype=dtype)
        b = jnp.full((small_size,), 2.0, dtype=dtype)
        c = jnp.full((small_size,), 3.0, dtype=dtype)
    return a, b, c
