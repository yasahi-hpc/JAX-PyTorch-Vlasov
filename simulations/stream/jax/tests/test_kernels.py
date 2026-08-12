import pytest
import jax
import jax.numpy as jnp
import src.stream


# ── Helpers ───────────────────────────────────────────────────────────
# For unit tests we call the *unwrapped* (non-jitted) Python function
# so tests exercise the pure logic without XLA compilation.

def _raw(fn):
    """Return the un-jitted version of a @jax.jit function."""
    return fn.__wrapped__ if hasattr(fn, "__wrapped__") else fn

raw_set   = _raw(src.stream.stream_set)
raw_copy  = _raw(src.stream.stream_copy)
raw_scale = _raw(src.stream.stream_scale)
raw_add   = _raw(src.stream.stream_add)
raw_triad = _raw(src.stream.stream_triad)


# ── Set ───────────────────────────────────────────────────────────────

class TestStreamSet:
    """Tests for the stream_set kernel: a = scalar."""

    def test_set_fills_value(self, abc_arrays, scalar):
        a, _, _ = abc_arrays
        result = raw_set(a, scalar)
        assert jnp.all(result == scalar)

    def test_set_preserves_shape(self, abc_arrays, scalar):
        a, _, _ = abc_arrays
        result = raw_set(a, scalar)
        assert result.shape == a.shape

    def test_set_preserves_dtype(self, abc_arrays, scalar):
        a, _, _ = abc_arrays
        result = raw_set(a, scalar)
        assert result.dtype == a.dtype

    def test_set_zero(self, abc_arrays):
        a, _, _ = abc_arrays
        result = raw_set(a, 0.0)
        assert jnp.all(result == 0.0)

    def test_set_negative(self, abc_arrays):
        a, _, _ = abc_arrays
        result = raw_set(a, -7.5)
        assert jnp.all(result == -7.5)


# ── Copy ──────────────────────────────────────────────────────────────

class TestStreamCopy:
    """Tests for the stream_copy kernel: c = a."""

    def test_copy_values(self, abc_arrays):
        a, _, _ = abc_arrays
        result = raw_copy(a)
        assert jnp.allclose(result, a)

    def test_copy_does_not_modify_source(self, abc_arrays):
        a, _, _ = abc_arrays
        a_orig = jnp.array(a, copy=True)
        _ = raw_copy(a)
        assert jnp.allclose(a, a_orig)

    def test_copy_is_independent(self, abc_arrays):
        """After copy, the result is independent of the source."""
        a, _, _ = abc_arrays
        result = raw_copy(a)
        # JAX arrays are immutable, so independence is guaranteed.
        # Verify values differ from an arbitrary modification.
        assert not jnp.all(result == 999.0)

    def test_copy_preserves_dtype(self, abc_arrays):
        a, _, _ = abc_arrays
        result = raw_copy(a)
        assert result.dtype == a.dtype


# ── Scale ─────────────────────────────────────────────────────────────

class TestStreamScale:
    """Tests for the stream_scale kernel: b = scalar * c."""

    def test_scale_values(self, abc_arrays, scalar):
        _, _, c = abc_arrays
        result = raw_scale(c, scalar)
        assert jnp.allclose(result, c * scalar)

    def test_scale_does_not_modify_source(self, abc_arrays, scalar):
        _, _, c = abc_arrays
        c_orig = jnp.array(c, copy=True)
        _ = raw_scale(c, scalar)
        assert jnp.allclose(c, c_orig)

    def test_scale_by_zero(self, abc_arrays):
        _, _, c = abc_arrays
        result = raw_scale(c, 0.0)
        assert jnp.all(result == 0.0)

    def test_scale_by_one(self, abc_arrays):
        _, _, c = abc_arrays
        result = raw_scale(c, 1.0)
        assert jnp.allclose(result, c)

    def test_scale_by_negative(self, abc_arrays):
        _, _, c = abc_arrays
        result = raw_scale(c, -2.0)
        assert jnp.allclose(result, c * -2.0)


# ── Add ───────────────────────────────────────────────────────────────

class TestStreamAdd:
    """Tests for the stream_add kernel: c = a + b."""

    def test_add_values(self, abc_arrays):
        a, b, _ = abc_arrays
        result = raw_add(a, b)
        assert jnp.allclose(result, a + b)

    def test_add_does_not_modify_sources(self, abc_arrays):
        a, b, _ = abc_arrays
        a_orig = jnp.array(a, copy=True)
        b_orig = jnp.array(b, copy=True)
        _ = raw_add(a, b)
        assert jnp.allclose(a, a_orig)
        assert jnp.allclose(b, b_orig)

    def test_add_zeros(self, small_size, dtype, device):
        with jax.default_device(device):
            a = jnp.zeros(small_size, dtype=dtype)
            b = jnp.zeros(small_size, dtype=dtype)
        result = raw_add(a, b)
        assert jnp.all(result == 0.0)

    def test_add_identity(self, small_size, dtype, device):
        """a + 0 = a."""
        with jax.default_device(device):
            a = jnp.full((small_size,), 5.0, dtype=dtype)
            b = jnp.zeros(small_size, dtype=dtype)
        result = raw_add(a, b)
        assert jnp.allclose(result, a)


# ── Triad ─────────────────────────────────────────────────────────────

class TestStreamTriad:
    """Tests for the stream_triad kernel: a = b + scalar * c."""

    def test_triad_values(self, abc_arrays, scalar):
        _, b, c = abc_arrays
        result = raw_triad(b, c, scalar)
        expected = b + scalar * c
        assert jnp.allclose(result, expected)

    def test_triad_does_not_modify_sources(self, abc_arrays, scalar):
        _, b, c = abc_arrays
        b_orig = jnp.array(b, copy=True)
        c_orig = jnp.array(c, copy=True)
        _ = raw_triad(b, c, scalar)
        assert jnp.allclose(b, b_orig)
        assert jnp.allclose(c, c_orig)

    def test_triad_scalar_zero(self, abc_arrays):
        """With scalar=0, triad reduces to copy: a = b."""
        _, b, c = abc_arrays
        result = raw_triad(b, c, 0.0)
        assert jnp.allclose(result, b)

    def test_triad_scalar_one(self, abc_arrays):
        """With scalar=1, triad is a = b + c."""
        _, b, c = abc_arrays
        expected = b + c
        result = raw_triad(b, c, 1.0)
        assert jnp.allclose(result, expected)

    def test_triad_negative_scalar(self, abc_arrays):
        _, b, c = abc_arrays
        expected = b + (-3.0) * c
        result = raw_triad(b, c, -3.0)
        assert jnp.allclose(result, expected)
