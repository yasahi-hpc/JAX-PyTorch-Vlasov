"""Tests for fig1.py (heat3d JAX solver variants, H200 vs TPU v5e, fp32).

The figure is always built from the SHAs published under ``artifact/``
(``fig_common.DEFAULT_SHAS``): H200 d875542, TPU v5e 7e1e001.
"""
from __future__ import annotations

import pytest

import fig1
import fig_common
from conftest import (IMG_DIR, SHAS, artifact_dirs, assert_written, sha_args)

ARCHS = ["H200", "TPU"]
BASENAME = "heat3d_bandwidth_H200_TPUv5e_fp32"
SUFFIX = ".png"  # fig1 writes PNG only


@pytest.mark.parametrize("path", artifact_dirs("heat3d", ("jax",), ARCHS),
                         ids=lambda p: f"{p.parent.name}/{p.name}")
def test_artifact_directory_exists(path):
    assert path.is_dir(), f"missing artifact directory {path}"


def test_reads_bandwidth_from_artifact():
    """Every (solver, size) cell of at least one architecture is readable."""
    root = fig_common.ARTIFACT_ROOT / "heat3d" / "jax"
    values = [
        fig1.read_bandwidth(root, SHAS[arch], fig_common.ARCH_TAG[arch], n, solver)
        for arch in ARCHS for solver in fig1.SOLVERS for n in fig1.PROBLEM_SIZES
    ]
    found = [v for v in values if v is not None]
    assert found, "no bandwidth values parsed from the artifact logs"
    assert all(v > 0 for v in found)


def test_writes_images_to_imgs_dir(run_figure):
    """Default run writes the figure into python_scripts/plot/imgs."""
    _, start = run_figure("fig1.py", *sha_args(ARCHS))
    assert_written(IMG_DIR / (BASENAME + SUFFIX), start)


def test_writes_no_pdf(run_figure, tmp_path):
    """Only the PNG is produced; the figure is not also written as a PDF."""
    run_figure("fig1.py", *sha_args(ARCHS), out_dir=tmp_path)
    assert [p.name for p in sorted(tmp_path.iterdir())] == [BASENAME + SUFFIX]


def test_out_dir_argument(run_figure, tmp_path):
    _, start = run_figure("fig1.py", *sha_args(ARCHS), out_dir=tmp_path)
    assert_written(tmp_path / (BASENAME + SUFFIX), start)


def test_output_basename_argument(run_figure, tmp_path):
    out = tmp_path / "custom_name"
    _, start = run_figure("fig1.py", *sha_args(ARCHS), "-o", out)
    assert_written(out.with_suffix(SUFFIX), start)


def test_unknown_sha_is_not_silently_reused(run_figure, tmp_path):
    """A SHA with no artifact data must not fall back to the default batch."""
    root = fig_common.ARTIFACT_ROOT / "heat3d" / "jax"
    assert fig1.read_bandwidth(root, "0000000", "H200", 128, 1) is None
