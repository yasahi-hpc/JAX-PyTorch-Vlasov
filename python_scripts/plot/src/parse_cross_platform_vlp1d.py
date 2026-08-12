#!/usr/bin/env python3
"""Cross-platform vlasov1d_1v (vlp1d_1v) data collector.

Parses elapsed-time and memory statistics for the JAX / Kokkos / PyTorch
vlp1d_1v benchmark across four architectures (H200, MI250X, PVC, TPU v5e),
each measured at its own SHA7, and emits a machine-readable JSON summary plus
markdown bandwidth tables.

The vlp1d_1v output files print only the *total* elapsed time of a multi-step
run (the step count differs per machine: 1000 on the GPUs, 10 on the TPU).
There is no printed "Estimated bandwidth" line (unlike heat3d), so we apply the
same prescribed traffic model the performance-portability skill uses:

    GB/s = sizeof(dtype) * N*N * (2*3 + 1) / (elapsed / steps) / 1e9

where N*N is the phase-space grid (the Grid line's product) and (2*3+1)=7 is
the modelled number of full-grid array accesses per step (three advection
kernels each reading+writing the distribution function, plus one Poisson
sweep). GLUPS = N*N * steps / elapsed / 1e9.

Measurement batches are named per report SHA set (``--set``):

    3157c76 (2026-07-25 report)   H200 95f32c5 | MI250X e32ad48 | PVC f87954e
    3f1259c (2026-07-31 report)   H200 98296c1 | MI250X a0be8c6 | PVC 44d95b2

Both sets use TPU ``dacac00`` (JAX + fp32 only): neither the 720b3a0 nor the
d154229 TPU vlp1d run directory exists, and the only other TPU batch
(``350c77d``) predates the current solver set (its solver2 is
``vlasov_step_vmap``, not ``vlasov_step_gather_free``).

Solver selection for the comparison (per comparisons.md):
    JAX     -> solver2 (vlasov_step_gather_free, block_roll form)
    PyTorch -> solver2 (vlasov_step_gather_free, const-index gather form)
    Kokkos  -> solver1 (MDRangePolicy Rank<2>, double-buffered)
"""
from __future__ import annotations

import json
import re
from pathlib import Path

BASE = Path("/work/jh220036/i18048/develop/vlp4d_tuto/measurements/vlasov1d_1v")

# report sha -> {arch: (measurement sha, filename-arch-tag)}
ARCH_SETS = {
    "3157c76": {
        "H200":   ("95f32c5", "H200"),
        "MI250X": ("e32ad48", "MI250X"),
        "PVC":    ("f87954e", "PVC"),
        "TPU":    ("dacac00", "TPUv5"),
    },
    "3f1259c": {
        "H200":   ("98296c1", "H200"),
        "MI250X": ("a0be8c6", "MI250X"),
        "PVC":    ("44d95b2", "PVC"),
        "TPU":    ("dacac00", "TPUv5"),
    },
    "06a524a": {
        "H200":   ("d875542", "H200"),
        "MI250X": ("d1904d7", "MI250X"),
        "PVC":    ("a625f79", "PVC"),
        "TPU":    ("7e1e001", "TPUv5"),
    }
}
DEFAULT_SET = "06a524a"
ARCH = ARCH_SETS[DEFAULT_SET]
SIZES = [128, 256, 512, 1024, 2048, 4096]

# Solver chosen per backend for the cross-platform comparison.
JAX_SOLVER = 2
TORCH_SOLVER = 2
KOKKOS_SOLVER = 1

PEAK = {"H200": 4000.0, "MI250X": 1600.0, "PVC": 1638.4, "TPU": 859.0}

DTYPE_BYTES = {"float32": 4, "float64": 8}
ACCESSES_PER_STEP = 2 * 3 + 1  # prescribed traffic model (see module docstring)

_ELAPSED = re.compile(r"Elapsed time:\s*([\d.eE+\-]+)\s*\[s\]")
_GRID = re.compile(r"Grid:\s*(\d+)\s*x\s*(\d+)")
_STEPS = re.compile(r"(?:Steps|Total iterations):\s*(\d+)")


def _search(text, pat):
    m = re.search(pat, text)
    return float(m.group(1)) if m else None


def parse_perf(path: Path, prec: str, n_fallback: int):
    """Return (gbs, glups, elapsed_per_step, steps, points) or None."""
    if not path.exists():
        return None
    t = path.read_text(errors="replace")
    em = _ELAPSED.search(t)
    if em is None:
        return None
    elapsed = float(em.group(1))
    gm = _GRID.search(t)
    points = int(gm.group(1)) * int(gm.group(2)) if gm else n_fallback ** 2
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
    if not path.exists():
        return {}
    t = path.read_text(errors="replace")
    return {
        "alloc_before_MiB": _search(t, r"Allocated before benchmark\s*:\s*([0-9.]+)"),
        "reserved_before_MiB": _search(t, r"Reserved before benchmark\s*:\s*([0-9.]+)"),
        "peak_alloc_MiB":   _search(t, r"Peak allocated\s*:\s*([0-9.]+)"),
        "peak_reserved_MiB": _search(t, r"Peak reserved\s*:\s*([0-9.]+)"),
    }


def collect(sha_set: str = DEFAULT_SET, arch_map: dict | None = None,
            base: Path | None = None):
    """Collect vlp1d_1v results.

    ``arch_map`` ({arch: (sha7, filename tag)}) and ``base`` override the named
    ``sha_set`` and the module-level measurements root; the figure scripts use
    them to read the repository's ``artifact/vlasov1d_1v`` tree instead.
    """
    arch_map = ARCH_SETS[sha_set] if arch_map is None else arch_map
    base = BASE if base is None else Path(base)
    out = {"jax": {}, "kokkos": {}, "pytorch": {}, "peaks": PEAK,
           "solvers": {"jax": JAX_SOLVER, "pytorch": TORCH_SOLVER,
                       "kokkos": KOKKOS_SOLVER},
           "sha_set": sha_set,
           "sizes": SIZES, "arch": {a: s for a, (s, _) in arch_map.items()}}
    for arch, (sha, tag) in arch_map.items():
        for prec in ("float32", "float64"):
            fpshort = "fp32" if prec == "float32" else "fp64"
            for n in SIZES:
                # JAX (solver2)
                p = base / "jax" / sha / f"vlp1d_1v_{tag}_{prec}_N{n}_solver{JAX_SOLVER}.txt"
                perf = parse_perf(p, prec, n)
                if perf:
                    out["jax"][f"{arch}|{prec}|{n}"] = {
                        **perf, "n": n, "arch": arch, "prec": prec,
                        "eff": perf["bw"] / PEAK[arch], "mem": parse_jax_mem(p)}
                # PyTorch (solver2)
                p = base / "pytorch" / sha / f"vlp1d_1v_{tag}_{prec}_N{n}_solver{TORCH_SOLVER}.txt"
                perf = parse_perf(p, prec, n)
                if perf:
                    out["pytorch"][f"{arch}|{prec}|{n}"] = {
                        **perf, "n": n, "arch": arch, "prec": prec,
                        "eff": perf["bw"] / PEAK[arch], "mem": parse_torch_mem(p)}
                # Kokkos (solver1) — filename uses fp32/fp64 tag, no mem block
                p = base / "kokkos" / sha / f"vlp1d_1v_{tag}_{fpshort}_N{n}_solver{KOKKOS_SOLVER}.txt"
                perf = parse_perf(p, prec, n)
                if perf:
                    out["kokkos"][f"{arch}|{prec}|{n}"] = {
                        **perf, "n": n, "arch": arch, "prec": prec,
                        "eff": perf["bw"] / PEAK[arch]}
    return out


def bw_table(data, prec):
    lines = []
    archs = ["H200", "MI250X", "PVC", "TPU"]
    for model in ("jax", "kokkos", "pytorch"):
        lines.append(f"\n### {model} ({prec}) — best GB/s (arch efficiency %)")
        lines.append("| N | " + " | ".join(archs) + " |")
        lines.append("|---|" + "|".join(["---"] * len(archs)) + "|")
        for n in SIZES:
            row = [f"{n}²"]
            for a in archs:
                d = data[model].get(f"{a}|{prec}|{n}")
                row.append(f"{d['bw']:.1f} ({100*d['eff']:.1f}%)" if d else "—")
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
    outdir = args.out_dir or Path(
        "/home/i18048/jh220036/develop/vlp4d_tuto/investigation/vlasov1d_1v"
    ) / args.sha_set
    outdir.mkdir(parents=True, exist_ok=True)
    (outdir / "cross_platform_data.json").write_text(json.dumps(data, indent=2))
    print("Wrote", outdir / "cross_platform_data.json")
    tables = "\n".join(bw_table(data, prec) for prec in ("float32", "float64"))
    (outdir / "cross_platform_tables.md").write_text(
        f"# vlp1d cross-platform bandwidth (SHA set {args.sha_set})\n" + tables + "\n")
    print(tables)
