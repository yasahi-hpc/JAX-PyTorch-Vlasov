#!/usr/bin/env python3
"""Cross-platform heat3d data collector.

Parses bandwidth and memory statistics for the JAX / Kokkos / PyTorch heat3d
benchmark across four architectures (H200, MI250X, PVC, TPU v5e), each measured
at its own SHA7, and emits a machine-readable JSON summary plus markdown tables.

Measurement batches are named per report SHA set (``--set``):

    3878ea8 (2026-07-22 report)  H200 95f32c5 | MI250X e32ad48 | PVC f87954e | TPU dacac00
    3f1259c (2026-07-31 report)  H200 98296c1 | MI250X a0be8c6 | PVC 44d95b2 | TPU d154229

The two sets are **not the same program for JAX**: the ``3f1259c`` batches run source blob
``5492b50d`` (HEAD), in which ``heat_step_conv`` was rewritten from one dense 3-D
convolution to three separable 1-D convolutions. PyTorch (``cc801574``) and Kokkos
(``fa921457``) are unchanged across both sets, so only the JAX solver2 column is affected.
"""
from __future__ import annotations

import json
import re
from pathlib import Path

BASE = Path("/home/i18048/jh220036/develop/vlp4d_tuto/measurements/heat3d")

# report sha -> {arch: (measurement sha, filename-arch-tag)}
ARCH_SETS = {
    "3878ea8": {
        "H200":   ("95f32c5", "H200"),
        "MI250X": ("e32ad48", "MI250X"),
        "PVC":    ("f87954e", "PVC"),
        "TPU":    ("dacac00", "TPUv5"),
    },
    "3f1259c": {
        "H200":   ("98296c1", "H200"),
        "MI250X": ("a0be8c6", "MI250X"),
        "PVC":    ("44d95b2", "PVC"),
        "TPU":    ("d154229", "TPUv5"),
    },
    "06a524a": {
        "H200":   ("d875542", "H200"),
        "MI250X": ("d1904d7", "MI250X"),
        "PVC":    ("a625f79", "PVC"),
        "TPU":    ("7e1e001", "TPUv5"),
    },
}
DEFAULT_SET = "06a524a"
ARCH = ARCH_SETS[DEFAULT_SET]
SIZES = [32, 64, 128, 256, 512]
JAX_SOLVERS = [0, 1, 2]

PEAK = {"H200": 4000.0, "MI250X": 1600.0, "PVC": 1638.4, "TPU": 859.0}


def _search(text, pat):
    m = re.search(pat, text)
    return float(m.group(1)) if m else None


def parse_bw(path: Path):
    if not path.exists():
        return None
    t = path.read_text()
    return _search(t, r"Estimated bandwidth \(GB/s\):\s*best=([0-9.]+)")


def parse_jax_mem(path: Path):
    if not path.exists():
        return {}
    t = path.read_text()
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
    t = path.read_text()
    return {
        "alloc_before_MiB": _search(t, r"Allocated before benchmark\s*:\s*([0-9.]+)"),
        "reserved_before_MiB": _search(t, r"Reserved before benchmark\s*:\s*([0-9.]+)"),
        "peak_alloc_MiB":   _search(t, r"Peak allocated\s*:\s*([0-9.]+)"),
        "peak_reserved_MiB": _search(t, r"Peak reserved\s*:\s*([0-9.]+)"),
    }


def collect(sha_set: str = DEFAULT_SET, arch_map: dict | None = None,
            base: Path | None = None):
    """Collect heat3d results.

    ``arch_map`` ({arch: (sha7, filename tag)}) and ``base`` override the named
    ``sha_set`` and the module-level measurements root; the figure scripts use
    them to read the repository's ``artifact/heat3d`` tree instead.
    """
    arch_map = ARCH_SETS[sha_set] if arch_map is None else arch_map
    base = BASE if base is None else Path(base)
    out = {"jax": {}, "kokkos": {}, "pytorch": {}, "peaks": PEAK,
           "sha_set": sha_set,
           "arch": {a: s for a, (s, _) in arch_map.items()}}
    for arch, (sha, tag) in arch_map.items():
        for prec in ("float32", "float64"):
            fp = "fp32" if prec == "float32" else "fp64"
            # JAX
            for k in JAX_SOLVERS:
                for n in SIZES:
                    p = base / "jax" / sha / f"heat3d_{tag}_{prec}_N{n}_solver{k}.txt"
                    bw = parse_bw(p)
                    if bw is None:
                        continue
                    key = f"{arch}|{prec}|solver{k}|{n}"
                    out["jax"][key] = {"bw": bw, "n": n, "arch": arch, "prec": prec,
                                       "solver": k, "eff": bw / PEAK[arch],
                                       "mem": parse_jax_mem(p)}
            # Kokkos
            for n in SIZES:
                p = base / "kokkos" / sha / f"heat3d_{tag}_{fp}_N{n}.txt"
                bw = parse_bw(p)
                if bw is None:
                    continue
                out["kokkos"][f"{arch}|{prec}|{n}"] = {
                    "bw": bw, "n": n, "arch": arch, "prec": prec, "eff": bw / PEAK[arch]}
            # PyTorch
            for n in SIZES:
                p = base / "pytorch" / sha / f"heat3d_{tag}_{prec}_N{n}.txt"
                bw = parse_bw(p)
                if bw is None:
                    continue
                memp = base / "pytorch" / sha / f"heat3d_{tag}_{prec}_N{n}_memory.txt"
                out["pytorch"][f"{arch}|{prec}|{n}"] = {
                    "bw": bw, "n": n, "arch": arch, "prec": prec, "eff": bw / PEAK[arch],
                    "mem": parse_torch_mem(p)}
    return out


def bw_table(data, prec):
    """Markdown table: rows=size, cols=arch, for each model. JAX uses solver1."""
    lines = []
    archs = ["H200", "MI250X", "PVC", "TPU"]
    for model in ("jax", "kokkos", "pytorch"):
        lines.append(f"\n### {model} ({prec}) — best GB/s (arch efficiency %)")
        lines.append("| N | " + " | ".join(archs) + " |")
        lines.append("|---|" + "|".join(["---"] * len(archs)) + "|")
        for n in SIZES:
            row = [f"{n}³"]
            for a in archs:
                if model == "jax":
                    key = f"{a}|{prec}|solver1|{n}"
                    d = data["jax"].get(key)
                else:
                    key = f"{a}|{prec}|{n}"
                    d = data[model].get(key)
                if d:
                    row.append(f"{d['bw']:.1f} ({100*d['eff']:.1f}%)")
                else:
                    row.append("—")
            lines.append("| " + " | ".join(row) + " |")
    return "\n".join(lines)


def jax_variant_table(data, prec):
    """Markdown table of all three JAX solver variants (rows=size, cols=arch)."""
    lines = []
    archs = ["H200", "MI250X", "PVC", "TPU"]
    names = {0: "solver0 heat_step", 1: "solver1 heat_step_roll",
             2: "solver2 heat_step_conv"}
    for k in JAX_SOLVERS:
        lines.append(f"\n### jax {names[k]} ({prec}) — best GB/s (arch efficiency %)")
        lines.append("| N | " + " | ".join(archs) + " |")
        lines.append("|---|" + "|".join(["---"] * len(archs)) + "|")
        for n in SIZES:
            row = [f"{n}³"]
            for a in archs:
                d = data["jax"].get(f"{a}|{prec}|solver{k}|{n}")
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
        "/home/i18048/jh220036/develop/vlp4d_tuto/investigation/heat3d") / args.sha_set
    outdir.mkdir(parents=True, exist_ok=True)
    (outdir / "cross_platform_data.json").write_text(json.dumps(data, indent=2))
    print("Wrote", outdir / "cross_platform_data.json")
    tables = "\n".join(bw_table(data, p) for p in ("float32", "float64"))
    variants = "\n".join(jax_variant_table(data, p) for p in ("float32", "float64"))
    (outdir / "cross_platform_tables.md").write_text(
        f"# heat3d cross-platform bandwidth (SHA set {args.sha_set})\n"
        "\n## Backend comparison (JAX = solver1)\n" + tables +
        "\n\n## JAX solver variants\n" + variants + "\n")
    print(tables)
    print(variants)
