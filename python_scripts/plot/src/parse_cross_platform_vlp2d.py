#!/usr/bin/env python3
"""Cross-platform vlasov2d_2v (vlp2d_2v) data collector.

Parses elapsed-time and memory statistics for the JAX / Kokkos / PyTorch
vlp2d_2v benchmark across four architectures (H200, MI250X, PVC, TPU v5e),
each measured at its own SHA7, and emits a machine-readable JSON summary plus
markdown bandwidth tables.

vlp2d_2v is a 2D-2V (4-D phase space) Vlasov-Poisson solver. The output files
print only the *total* elapsed time of a multi-step run (128 steps on the GPUs,
10 on the TPU). There is no printed bandwidth line, so we apply the same
prescribed traffic model the performance-portability skill uses
(portability/loader_vlp2d.py):

    GB/s = sizeof(dtype) * Nx*Nx*Nvx*Nvx * (2*6 + 1) / (elapsed / steps) / 1e9

where Nx²·Nvx² is the 4-D phase-space grid (the Grid line's product) and
(2*6+1)=13 is the modelled number of full-grid array accesses per step (six
advection kernels each reading+writing the distribution function, plus one
Poisson sweep). GLUPS = Nx²·Nvx² * steps / elapsed / 1e9, so GB/s = 13·sizeof·GLUPS.

Measurement batches are named per report SHA set (``--set``):

    c8880d0 (2026-07-25 report)   H200 95f32c5 | MI250X e32ad48 | PVC f87954e | TPU 720b3a0
    3f1259c (2026-07-31 report)   H200 98296c1 | MI250X a0be8c6 | PVC 44d95b2 |
                                  TPU d154229 + 720b3a0 fallback

Each architecture maps to a **list** of SHAs tried in order, so a batch that covers
only part of the size sweep can fall back to an older same-source batch. The
``3f1259c`` TPU batch ``d154229`` ran only the two smallest grids; the three larger
solver2 cells come from ``720b3a0`` (identical JAX source blob ``78b6aec9``, JAX 0.7.2,
and the six overlapping cells agree within 0.2%). ``collect()`` records the supplying
SHA per cell in the ``"sha"`` field so the mixing is auditable.

Solver selection for the comparison (per comparisons.md instruction 19):
    JAX     -> solver2 (vlasov_step_gather_free, block_roll form)
    PyTorch -> solver2 (vlasov_step_gather_free, const-index gather form)
    Kokkos  -> solver1 (MDRangePolicy, double-buffered)
"""
from __future__ import annotations

import json
import re
from pathlib import Path

from fig_common import REPO_ROOT  # repository root, derived from this file's location

BENCH = "vlasov2d_2v"
BASE = REPO_ROOT / "measurements" / BENCH
INVESTIGATION_DIR = REPO_ROOT / "investigation" / BENCH

# report sha -> {arch: ([sha7, ...] in fallback order, filename-arch-tag)}
ARCH_SETS = {
    "c8880d0": {
        "H200":   (["95f32c5"], "H200"),
        "MI250X": (["e32ad48"], "MI250X"),
        "PVC":    (["f87954e"], "PVC"),
        "TPU":    (["720b3a0"], "TPUv5"),
    },
    "3f1259c": {
        "H200":   (["98296c1"], "H200"),
        "MI250X": (["a0be8c6"], "MI250X"),
        "PVC":    (["44d95b2"], "PVC"),
        "TPU":    (["d154229", "720b3a0"], "TPUv5"),
    },
    "06a524a": {
        "H200":   (["d875542"], "H200"),
        "MI250X": (["d1904d7"], "MI250X"),
        "PVC":    (["a625f79"], "PVC"),
        "TPU":    (["7e1e001"], "TPUv5"),
    },
}
DEFAULT_SET = "06a524a"
ARCH = ARCH_SETS[DEFAULT_SET]
# (Nx, Nvx) grid pairs; total phase-space points = Nx**2 * Nvx**2.
SIZES = [(32, 32), (32, 64), (64, 64), (64, 128), (128, 128)]

# Solver chosen per backend for the cross-platform comparison.
JAX_SOLVER = 2
TORCH_SOLVER = 2
KOKKOS_SOLVER = 1

PEAK = {"H200": 4000.0, "MI250X": 1600.0, "PVC": 1638.4, "TPU": 859.0}

DTYPE_BYTES = {"float32": 4, "float64": 8}
ACCESSES_PER_STEP = 2 * 6 + 1  # prescribed traffic model (see module docstring)

_ELAPSED = re.compile(r"Elapsed time:\s*([\d.eE+\-]+)\s*\[s\]")
_GRID = re.compile(r"Grid:\s*(\d+(?:\s*x\s*\d+)+)")
_STEPS = re.compile(r"(?:Steps|Total iterations):\s*(\d+)")


def points_of(nx, nvx):
    return nx * nx * nvx * nvx


def size_label(nx, nvx):
    return f"{nx}_{nvx}"


def _search(text, pat):
    m = re.search(pat, text)
    return float(m.group(1)) if m else None


def parse_perf(path: Path, prec: str, nx: int, nvx: int):
    """Return dict(bw, glups, per_step_s, steps, points) or None."""
    if not path.exists():
        return None
    t = path.read_text(errors="replace")
    em = _ELAPSED.search(t)
    if em is None:
        return None
    elapsed = float(em.group(1))
    gm = _GRID.search(t)
    if gm:
        points = 1
        for d in re.split(r"\s*x\s*", gm.group(1)):
            points *= int(d)
    else:
        points = points_of(nx, nvx)
    sm = _STEPS.search(t)
    steps = int(sm.group(1)) if sm else 1
    per_step = elapsed / steps
    bytes_moved = DTYPE_BYTES[prec] * points * ACCESSES_PER_STEP
    gbs = bytes_moved / per_step / 1e9
    glups = points * steps / elapsed / 1e9
    return {"bw": gbs, "glups": glups, "per_step_s": per_step,
            "steps": steps, "points": points}


def parse_jax_mem(path: Path):
    if not path.exists():
        return {}
    t = path.read_text(errors="replace")
    return {
        "dev_before_MiB": _search(t, r"Device memory before main loop\s*:\s*([0-9.]+)"),
        "dev_after_MiB":  _search(t, r"Device memory after main loop\s*:\s*([0-9.]+)"),
        "dev_peak_MiB":   _search(t, r"Device peak memory\s*:\s*([0-9.]+)"),
        "arg_MiB":        _search(t, r"Argument size\s*:\s*([0-9.]+)"),
        "out_MiB":        _search(t, r"Output size\s*:\s*([0-9.]+)"),
        "temp_MiB":       _search(t, r"Temp size\s*:\s*([0-9.]+)"),
        "compiled_peak_MiB": _search(t, r"Peak memory\s*:\s*([0-9.]+)"),
        "host_rss_MiB":   _search(t, r"Host peak RSS\s*:\s*([0-9.]+)"),
    }


def parse_torch_mem(path: Path):
    """Peak allocated / reserved are printed in the main .txt (not _memory.txt)."""
    if not path.exists():
        return {}
    t = path.read_text(errors="replace")
    return {
        "alloc_before_MiB": _search(t, r"Allocated before benchmark\s*:\s*([0-9.]+)"),
        "reserved_before_MiB": _search(t, r"Reserved before benchmark\s*:\s*([0-9.]+)"),
        "peak_alloc_MiB":   _search(t, r"Peak allocated\s*:\s*([0-9.]+)"),
        "peak_reserved_MiB": _search(t, r"Peak reserved\s*:\s*([0-9.]+)"),
    }


def _first_existing(shas, backend, filename, base=None):
    """Return (path, sha) of the first SHA in `shas` that has `filename`."""
    base = BASE if base is None else Path(base)
    for sha in shas:
        p = base / backend / sha / filename
        if p.exists():
            return p, sha
    return base / backend / shas[0] / filename, shas[0]


def _as_sha_list(shas):
    """Accept either a single SHA7 or a fallback-ordered list of them."""
    return [shas] if isinstance(shas, str) else list(shas)


def collect(sha_set: str = DEFAULT_SET, arch_map: dict | None = None,
            base: Path | None = None):
    """Collect vlp2d_2v results.

    ``arch_map`` ({arch: (sha7 or [sha7, ...], filename tag)}) and ``base``
    override the named ``sha_set`` and the module-level measurements root; the
    figure scripts use them to read the repository's ``artifact/vlasov2d_2v``
    tree instead.
    """
    arch_map = ARCH_SETS[sha_set] if arch_map is None else arch_map
    arch_map = {a: (_as_sha_list(shas), tag) for a, (shas, tag) in arch_map.items()}
    base = BASE if base is None else Path(base)
    out = {"jax": {}, "kokkos": {}, "pytorch": {}, "peaks": PEAK,
           "solvers": {"jax": JAX_SOLVER, "pytorch": TORCH_SOLVER,
                       "kokkos": KOKKOS_SOLVER},
           "sha_set": sha_set,
           "sizes": [size_label(nx, nvx) for nx, nvx in SIZES],
           "size_pairs": SIZES,
           "arch": {a: shas for a, (shas, _) in arch_map.items()}}
    for arch, (shas, tag) in arch_map.items():
        for prec in ("float32", "float64"):
            fpshort = "fp32" if prec == "float32" else "fp64"
            for nx, nvx in SIZES:
                key = f"{arch}|{prec}|{size_label(nx, nvx)}"
                common = {"nx": nx, "nvx": nvx, "size": size_label(nx, nvx),
                          "arch": arch, "prec": prec}
                # JAX (solver2)
                p, sha = _first_existing(
                    shas, "jax",
                    f"vlp2d_2v_{tag}_{prec}_Nx{nx}_Nvx{nvx}_solver{JAX_SOLVER}.txt",
                    base=base)
                perf = parse_perf(p, prec, nx, nvx)
                if perf:
                    out["jax"][key] = {**perf, **common, "sha": sha,
                                       "eff": perf["bw"] / PEAK[arch],
                                       "mem": parse_jax_mem(p)}
                # PyTorch (solver2)
                p, sha = _first_existing(
                    shas, "pytorch",
                    f"vlp2d_2v_{tag}_{prec}_Nx{nx}_Nvx{nvx}_solver{TORCH_SOLVER}.txt",
                    base=base)
                perf = parse_perf(p, prec, nx, nvx)
                if perf:
                    out["pytorch"][key] = {**perf, **common, "sha": sha,
                                           "eff": perf["bw"] / PEAK[arch],
                                           "mem": parse_torch_mem(p)}
                # Kokkos (solver1) — filename uses fp32/fp64 tag, no mem block
                p, sha = _first_existing(
                    shas, "kokkos",
                    f"vlp2d_2v_{tag}_{fpshort}_Nx{nx}_Nvx{nvx}_solver{KOKKOS_SOLVER}.txt",
                    base=base)
                perf = parse_perf(p, prec, nx, nvx)
                if perf:
                    out["kokkos"][key] = {**perf, **common, "sha": sha,
                                          "eff": perf["bw"] / PEAK[arch]}
    return out


def _lbl(nx, nvx):
    return f"{nx}²·{nvx}²"


def bw_table(data, prec):
    lines = []
    archs = ["H200", "MI250X", "PVC", "TPU"]
    for model in ("jax", "kokkos", "pytorch"):
        lines.append(f"\n### {model} ({prec}) — best GB/s (arch efficiency %) / GLUPS")
        lines.append("| grid | " + " | ".join(archs) + " |")
        lines.append("|---|" + "|".join(["---"] * len(archs)) + "|")
        for nx, nvx in SIZES:
            row = [_lbl(nx, nvx)]
            for a in archs:
                d = data[model].get(f"{a}|{prec}|{size_label(nx, nvx)}")
                row.append(f"{d['bw']:.1f} ({100*d['eff']:.1f}%) / {d['glups']:.2f}"
                           if d else "—")
            lines.append("| " + " | ".join(row) + " |")
    return "\n".join(lines)


if __name__ == "__main__":
    import argparse

    ap = argparse.ArgumentParser()
    ap.add_argument("--set", dest="sha_set", default=DEFAULT_SET,
                    choices=sorted(ARCH_SETS))
    ap.add_argument("--out-dir", type=Path, default=None)
    args = ap.parse_args()

    data = collect(args.sha_set)
    outdir = args.out_dir or INVESTIGATION_DIR / args.sha_set
    outdir.mkdir(parents=True, exist_ok=True)
    (outdir / "cross_platform_data.json").write_text(json.dumps(data, indent=2))
    print("Wrote", outdir / "cross_platform_data.json")
    tables = "\n".join(bw_table(data, prec) for prec in ("float32", "float64"))
    (outdir / "cross_platform_tables.md").write_text(
        f"# vlp2d cross-platform bandwidth (SHA set {args.sha_set})\n" + tables + "\n")
    print(tables)
    # Report which SHA supplied each TPU cell (the fallback audit trail).
    tpu = {k: v["sha"] for k, v in data["jax"].items() if k.startswith("TPU|")}
    if len(set(tpu.values())) > 1:
        print("\nTPU cells by supplying SHA:")
        for k in sorted(tpu):
            print(f"  {k}: {tpu[k]}")
