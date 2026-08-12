"""Tests for fig2.py (cross-architecture heat3d bandwidth, JAX/Kokkos/PyTorch).

All runs use the SHAs published under ``artifact/`` (``fig_common.DEFAULT_SHAS``):
H200 d875542, MI250X d1904d7, PVC a625f79, TPU v5e 7e1e001.
"""
from __future__ import annotations

import warnings

import pytest

import fig_common
import parse_cross_platform_heat3d as parser
from conftest import (IMG_DIR, artifact_dirs, assert_written, sha_args)

BACKENDS = ("jax", "kokkos", "pytorch")
EXPECTED = [f"heat3d_bandwidth_{prec}_{group}.png"
            for prec in ("float32", "float64")
            for group in ("H200_TPU", "MI250X_PVC")]


def artifact_data():
    """collect() over the artifact tree with the default (artifact) SHAs."""
    arch_map = {a: (sha, fig_common.ARCH_TAG[a])
                for a, sha in fig_common.DEFAULT_SHAS.items()}
    return parser.collect(arch_map=arch_map,
                          base=fig_common.ARTIFACT_ROOT / "heat3d")


@pytest.mark.parametrize("path", artifact_dirs("heat3d", BACKENDS),
                         ids=lambda p: f"{p.parent.parent.name}/{p.parent.name}/{p.name}")
def test_artifact_directory_exists(path):
    # The TPU batch is JAX-only, so only its jax directory is required.
    if path.parent.name != "jax" and not path.is_dir():
        pytest.skip(f"no {path.parent.name} batch for this architecture")
    assert path.is_dir(), f"missing artifact directory {path}"


def test_collect_reads_artifact_data():
    data = artifact_data()
    assert data["jax"], "no JAX cells parsed from the artifact tree"
    for arch in fig_common.ARCH_ORDER:
        assert any(k.startswith(f"{arch}|") for k in data["jax"]), \
            f"no JAX data for {arch}"
    assert all(d["bw"] > 0 for d in data["jax"].values())


def test_backend_coverage():
    """Warn (do not fail) about a backend the artifact tree does not cover."""
    data = artifact_data()
    for backend in BACKENDS:
        if not data[backend]:
            warnings.warn(f"artifact/heat3d has no usable {backend} logs "
                          f"for the default SHAs")
    assert data["jax"] and data["kokkos"]


def test_writes_images_to_imgs_dir(run_figure):
    """Default run writes all four panels into python_scripts/plot/imgs."""
    _, start = run_figure("fig2.py", *sha_args())
    for name in EXPECTED:
        assert_written(IMG_DIR / name, start)


def test_out_dir_argument(run_figure, tmp_path):
    _, start = run_figure("fig2.py", *sha_args(), out_dir=tmp_path)
    for name in EXPECTED:
        assert_written(tmp_path / name, start)


def test_measurements_base_is_repo_relative():
    """No absolute path is baked in: BASE follows this checkout's location."""
    assert parser.BASE == fig_common.REPO_ROOT / "measurements" / parser.BENCH
    assert parser.INVESTIGATION_DIR == fig_common.REPO_ROOT / "investigation" / parser.BENCH
