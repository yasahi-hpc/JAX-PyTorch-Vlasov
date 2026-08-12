import pytest
import torch
import src.stream


class TestStreamSet:
    """Tests for the stream_set kernel: a[:] = scalar."""

    def test_set_fills_value(self, abc_tensors, scalar):
        a, _, _ = abc_tensors
        src.stream.stream_set(a, scalar)
        assert torch.all(a == scalar)

    def test_set_preserves_shape(self, abc_tensors, scalar):
        a, _, _ = abc_tensors
        shape_before = a.shape
        src.stream.stream_set(a, scalar)
        assert a.shape == shape_before

    def test_set_preserves_dtype(self, abc_tensors, scalar):
        a, _, _ = abc_tensors
        dtype_before = a.dtype
        src.stream.stream_set(a, scalar)
        assert a.dtype == dtype_before

    def test_set_zero(self, abc_tensors):
        a, _, _ = abc_tensors
        src.stream.stream_set(a, 0.0)
        assert torch.all(a == 0.0)

    def test_set_negative(self, abc_tensors):
        a, _, _ = abc_tensors
        src.stream.stream_set(a, -7.5)
        assert torch.all(a == -7.5)


class TestStreamCopy:
    """Tests for the stream_copy kernel: c[:] = a[:]."""

    def test_copy_values(self, abc_tensors):
        a, _, c = abc_tensors
        src.stream.stream_copy(c, a)
        assert torch.allclose(c, a)

    def test_copy_does_not_modify_source(self, abc_tensors):
        a, _, c = abc_tensors
        a_orig = a.clone()
        src.stream.stream_copy(c, a)
        assert torch.allclose(a, a_orig)

    def test_copy_is_independent(self, abc_tensors):
        """After copy, modifying source does not change destination."""
        a, _, c = abc_tensors
        src.stream.stream_copy(c, a)
        a.fill_(999.0)
        assert not torch.all(c == 999.0)

    def test_copy_preserves_dtype(self, abc_tensors):
        a, _, c = abc_tensors
        src.stream.stream_copy(c, a)
        assert c.dtype == a.dtype


class TestStreamScale:
    """Tests for the stream_scale kernel: b[:] = scalar * c[:]."""

    def test_scale_values(self, abc_tensors, scalar):
        _, b, c = abc_tensors
        c_orig = c.clone()
        src.stream.stream_scale(b, c, scalar)
        assert torch.allclose(b, c_orig * scalar)

    def test_scale_does_not_modify_source(self, abc_tensors, scalar):
        _, b, c = abc_tensors
        c_orig = c.clone()
        src.stream.stream_scale(b, c, scalar)
        assert torch.allclose(c, c_orig)

    def test_scale_by_zero(self, abc_tensors):
        _, b, c = abc_tensors
        src.stream.stream_scale(b, c, 0.0)
        assert torch.all(b == 0.0)

    def test_scale_by_one(self, abc_tensors):
        _, b, c = abc_tensors
        c_orig = c.clone()
        src.stream.stream_scale(b, c, 1.0)
        assert torch.allclose(b, c_orig)

    def test_scale_by_negative(self, abc_tensors):
        _, b, c = abc_tensors
        c_orig = c.clone()
        src.stream.stream_scale(b, c, -2.0)
        assert torch.allclose(b, c_orig * -2.0)


class TestStreamAdd:
    """Tests for the stream_add kernel: c[:] = a[:] + b[:]."""

    def test_add_values(self, abc_tensors):
        a, b, c = abc_tensors
        a_orig, b_orig = a.clone(), b.clone()
        src.stream.stream_add(a, b, c)
        assert torch.allclose(c, a_orig + b_orig)

    def test_add_does_not_modify_sources(self, abc_tensors):
        a, b, c = abc_tensors
        a_orig, b_orig = a.clone(), b.clone()
        src.stream.stream_add(a, b, c)
        assert torch.allclose(a, a_orig)
        assert torch.allclose(b, b_orig)

    def test_add_zeros(self, small_size, dtype, device):
        a = torch.zeros(small_size, dtype=dtype, device=device)
        b = torch.zeros(small_size, dtype=dtype, device=device)
        c = torch.ones(small_size, dtype=dtype, device=device)
        src.stream.stream_add(a, b, c)
        assert torch.all(c == 0.0)

    def test_add_identity(self, small_size, dtype, device):
        """a + 0 = a."""
        a = torch.full((small_size,), 5.0, dtype=dtype, device=device)
        b = torch.zeros(small_size, dtype=dtype, device=device)
        c = torch.empty(small_size, dtype=dtype, device=device)
        src.stream.stream_add(a, b, c)
        assert torch.allclose(c, a)


class TestStreamTriad:
    """Tests for the stream_triad kernel: a[:] = b[:] + scalar * c[:]."""

    def test_triad_values(self, abc_tensors, scalar):
        a, b, c = abc_tensors
        b_orig, c_orig = b.clone(), c.clone()
        src.stream.stream_triad(a, b, c, scalar)
        expected = b_orig + scalar * c_orig
        assert torch.allclose(a, expected)

    def test_triad_does_not_modify_sources(self, abc_tensors, scalar):
        a, b, c = abc_tensors
        b_orig, c_orig = b.clone(), c.clone()
        src.stream.stream_triad(a, b, c, scalar)
        assert torch.allclose(b, b_orig)
        assert torch.allclose(c, c_orig)

    def test_triad_scalar_zero(self, abc_tensors):
        """With scalar=0, triad reduces to copy: a = b."""
        a, b, c = abc_tensors
        b_orig = b.clone()
        src.stream.stream_triad(a, b, c, 0.0)
        assert torch.allclose(a, b_orig)

    def test_triad_scalar_one(self, abc_tensors):
        """With scalar=1, triad is a = b + c."""
        a, b, c = abc_tensors
        expected = b.clone() + c.clone()
        src.stream.stream_triad(a, b, c, 1.0)
        assert torch.allclose(a, expected)

    def test_triad_negative_scalar(self, abc_tensors):
        a, b, c = abc_tensors
        expected = b.clone() + (-3.0) * c.clone()
        src.stream.stream_triad(a, b, c, -3.0)
        assert torch.allclose(a, expected)
