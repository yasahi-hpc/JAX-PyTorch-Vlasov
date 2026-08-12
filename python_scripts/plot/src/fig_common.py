#!/usr/bin/env python3
"""Shared paths and CLI arguments for the draft figure scripts (fig1..fig4).

All four figure scripts read their measurement logs from the repository's
``artifact/`` tree, located *relative to this file* (``python_scripts/plot/src``
-> repository root -> ``artifact``), so the scripts work from any checkout and
any working directory without absolute paths baked in.

The artifact tree is laid out as

    artifact/<benchmark>/<backend>/<sha7>/<log files>

with one SHA7 per architecture.  The current artifacts are

    H200    d875542
    MI250X  d1904d7
    PVC     a625f79
    TPU v5e 7e1e001

which are the defaults; every figure script also accepts ``--h200-sha``,
``--mi250x-sha``, ``--pvc-sha`` and ``--tpu-sha`` to plot a different batch.

Figures are written to ``python_scripts/plot/imgs`` by default (``--out-dir``).
"""
from __future__ import annotations

import argparse
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent   # python_scripts/plot/src
PLOT_DIR = SCRIPT_DIR.parent                   # python_scripts/plot
REPO_ROOT = SCRIPT_DIR.parents[2]              # src -> plot -> python_scripts -> repo
ARTIFACT_ROOT = REPO_ROOT / "artifact"
IMG_DIR = PLOT_DIR / "imgs"

# Architecture -> SHA7 of the artifact batch currently published for it.
DEFAULT_SHAS = {
    "H200":   "d875542",
    "MI250X": "d1904d7",
    "PVC":    "a625f79",
    "TPU":    "7e1e001",
}
# Architecture -> tag used inside the log file names.
ARCH_TAG = {"H200": "H200", "MI250X": "MI250X", "PVC": "PVC", "TPU": "TPUv5"}
ARCH_ORDER = ["H200", "MI250X", "PVC", "TPU"]


def _dest(arch: str) -> str:
    return f"{arch.lower()}_sha"


def add_common_arguments(ap: argparse.ArgumentParser,
                         archs: list[str] | None = None) -> argparse.ArgumentParser:
    """Add ``--<arch>-sha``, ``--artifact-root`` and ``--out-dir`` to `ap`."""
    for arch in archs or ARCH_ORDER:
        ap.add_argument(f"--{arch.lower()}-sha", dest=_dest(arch), metavar="SHA7",
                        default=DEFAULT_SHAS[arch],
                        help=f"artifact SHA7 for {arch} (default: %(default)s)")
    ap.add_argument("--artifact-root", type=Path, default=ARTIFACT_ROOT,
                    help="root of the artifact tree (default: %(default)s)")
    ap.add_argument("--out-dir", type=Path, default=IMG_DIR,
                    help="where to write the figures (default: %(default)s)")
    return ap


def sha_map(args: argparse.Namespace,
            archs: list[str] | None = None) -> dict[str, str]:
    """{arch: sha7} from the parsed ``--<arch>-sha`` arguments."""
    return {a: getattr(args, _dest(a)) for a in (archs or ARCH_ORDER)}


def arch_map(args: argparse.Namespace,
             archs: list[str] | None = None) -> dict[str, tuple[str, str]]:
    """{arch: (sha7, filename tag)}, the shape the cross-platform parsers take."""
    return {a: (sha, ARCH_TAG[a]) for a, sha in sha_map(args, archs).items()}


def ensure_out_dir(path: Path) -> Path:
    path.mkdir(parents=True, exist_ok=True)
    return path
