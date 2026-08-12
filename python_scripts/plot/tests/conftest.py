"""Shared fixtures/helpers for the fig1..fig4 tests.

Every test drives the figure scripts with the SHAs published under
``artifact/`` (``fig_common.DEFAULT_SHAS``) and checks that the figures land in
``python_scripts/plot/imgs``.

The scripts under test live in the sibling ``src`` directory and import each
other by plain name (they are run as scripts, not as a package), so ``src`` is
prepended to ``sys.path`` here; that makes ``pytest python_scripts/plot/tests``
work from any working directory without setting ``PYTHONPATH``.
"""
from __future__ import annotations

import subprocess
import sys
import time
from pathlib import Path

import pytest

SRC_DIR = Path(__file__).resolve().parents[1] / "src"
if str(SRC_DIR) not in sys.path:
    sys.path.insert(0, str(SRC_DIR))

import fig_common  # noqa: E402  (needs SRC_DIR on sys.path)

SCRIPT_DIR = fig_common.SCRIPT_DIR
IMG_DIR = fig_common.IMG_DIR
ARTIFACT_ROOT = fig_common.ARTIFACT_ROOT
SHAS = fig_common.DEFAULT_SHAS

PNG_MAGIC = b"\x89PNG\r\n\x1a\n"
PDF_MAGIC = b"%PDF"


def sha_args(archs: list[str] | None = None) -> list[str]:
    """Explicit ``--<arch>-sha`` arguments naming the artifact SHAs."""
    args = []
    for arch in archs or fig_common.ARCH_ORDER:
        args += [f"--{arch.lower()}-sha", SHAS[arch]]
    return args


def artifact_dirs(benchmark: str, backends: tuple[str, ...],
                  archs: list[str] | None = None) -> list[Path]:
    """Artifact directories a figure reads, for the default SHAs."""
    return [ARTIFACT_ROOT / benchmark / backend / SHAS[arch]
            for arch in (archs or fig_common.ARCH_ORDER)
            for backend in backends]


def assert_written(path: Path, not_before: float) -> None:
    """The file exists, is a fresh non-empty PNG/PDF from this test run."""
    assert path.exists(), f"{path} was not created"
    assert path.stat().st_size > 0, f"{path} is empty"
    assert path.stat().st_mtime >= not_before, f"{path} is stale (not regenerated)"
    head = path.read_bytes()[:8]
    magic = PDF_MAGIC if path.suffix == ".pdf" else PNG_MAGIC
    assert head.startswith(magic), f"{path} is not a valid {path.suffix[1:]} file"


@pytest.fixture(scope="session")
def run_figure():
    """Run a figure script in a subprocess; assert it exits cleanly.

    Returns (CompletedProcess, start_time); `start_time` is taken just before
    the run so callers can prove the images were (re)written by it.
    """
    def _run(script: str, *args: object, out_dir: Path | None = None):
        cmd = [sys.executable, str(SCRIPT_DIR / script), *map(str, args)]
        if out_dir is not None:
            cmd += ["--out-dir", str(out_dir)]
        start = time.time() - 1.0  # filesystem timestamp granularity
        proc = subprocess.run(cmd, cwd=SCRIPT_DIR, capture_output=True, text=True)
        assert proc.returncode == 0, (
            f"{script} exited with {proc.returncode}\n"
            f"--- stdout ---\n{proc.stdout}\n--- stderr ---\n{proc.stderr}")
        return proc, start
    return _run
