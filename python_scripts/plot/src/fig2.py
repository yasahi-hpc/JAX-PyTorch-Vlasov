#!/usr/bin/env python3
"""Cross-architecture heat3d bandwidth plots.

For each precision (fp32, fp64) two figures are produced, grouped by architecture:
  * H200 + TPU    -> panel (a)
  * MI250X + PVC  -> panel (b)
Encoding:
  * programming model -> line COLOR   (JAX=blue, Kokkos=green, PyTorch=orange)
  * architecture      -> LINESTYLE + MARKER, reused across the two panels since
    they are separate figures (first arch solid/*, second arch dashed/^; markers
    are drawn with edge color only)
JAX uses solver1 (heat_step_roll), per the comparison spec. The TPU has JAX/fp32
data only; it appears on the fp32 H200+TPU figure only.

Data comes from ``artifact/heat3d/<backend>/<sha7>/`` (one SHA7 per
architecture, overridable with ``--h200-sha`` etc.; see fig_common), located
relative to this file. Figures go to ``python_scripts/plot/imgs`` by default.

x-axis: problem size 32^3..512^3 (semilog, log2-spaced positions); y-axis: GB/s (linear).
"""
from __future__ import annotations

import argparse
import math
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D

import fig_common
from parse_cross_platform_heat3d import collect, SIZES  # reuse parser

plt.rcParams["font.family"] = "Times New Roman"
# The x tick labels are mathtext ($N^3$), which ignores font.family and would
# otherwise fall back to the DejaVu Sans math fontset.
plt.rcParams["mathtext.fontset"] = "custom"
plt.rcParams["mathtext.rm"] = "Times New Roman"
plt.rcParams["mathtext.it"] = "Times New Roman:italic"
plt.rcParams["mathtext.bf"] = "Times New Roman:bold"
plt.rcParams["mathtext.sf"] = "Times New Roman"
plt.rcParams["mathtext.cal"] = "Times New Roman:italic"  # default is 'cursive' (missing here)

MODEL_COLOR = {"jax": "#1f77b4", "kokkos": "#2ca02c", "pytorch": "#d62728"}
MODEL_LABEL = {"jax": "JAX", "kokkos": "Kokkos", "pytorch": "PyTorch"}
# The two panels are separate figures, so the same linestyle/marker pair is
# reused in each; markers are unfilled (edge color only).
ARCH_STYLE = {
    "H200":   dict(linestyle="-",  marker="*", markersize=17),
    "TPU":    dict(linestyle="--", marker="^", markersize=11),
    "MI250X": dict(linestyle="-",  marker="*", markersize=17),
    "PVC":    dict(linestyle="--", marker="^", markersize=11),
}
ARCH_GROUPS = {"H200_TPU": ["H200", "TPU"], "MI250X_PVC": ["MI250X", "PVC"]}
GROUP_CAPTION = {"H200_TPU": "(a)", "MI250X_PVC": "(b)"}

# Bigger fonts for legend, ticks, labels, caption.
plt.rcParams.update({
    "font.size": 18,
    "axes.labelsize": 22,
    "xtick.labelsize": 19,
    "ytick.labelsize": 19,
    "legend.fontsize": 18,
})


def series(data, model, arch, prec):
    ys = []
    for n in SIZES:
        if model == "jax":
            d = data["jax"].get(f"{arch}|{prec}|solver1|{n}")
        else:
            d = data[model].get(f"{arch}|{prec}|{n}")
        ys.append(d["bw"] if d else math.nan)
    return ys


def make_plot(data, prec, group_name, archs, out_dir: Path):
    x = [math.log2(n) for n in SIZES]
    fig, ax = plt.subplots(figsize=(10.5, 6.6), constrained_layout=True)

    archs_present = []
    for arch in archs:
        drew = False
        for model in ("jax", "kokkos", "pytorch"):
            ys = series(data, model, arch, prec)
            if all(math.isnan(v) for v in ys):
                continue
            ax.plot(x, ys, color=MODEL_COLOR[model], linewidth=2.4,
                    markerfacecolor="none", markeredgewidth=2.0,
                    **ARCH_STYLE[arch])
            drew = True
        if drew:
            archs_present.append(arch)

    ax.set_xticks(x)
    ax.set_xticklabels([f"${n}^3$" for n in SIZES])
    ax.set_xlabel("Problem size")
    ax.set_ylabel("Estimated bandwidth (GB/s)")
    ax.grid(True, linestyle="--", alpha=0.4)
    ax.margins(x=0.04)

    # Panel caption embedded at the top left, with the legends stacked below it.
    caption = ax.text(0.012, 0.985, GROUP_CAPTION[group_name],
                      transform=ax.transAxes, ha="left", va="top",
                      fontsize=26)

    # Two legends without titles: models (color), architectures (style).
    models_present = [m for m in ("jax", "kokkos", "pytorch")
                      if any(not all(math.isnan(v) for v in series(data, m, a, prec))
                             for a in archs_present)]
    model_handles = [Line2D([0], [0], color=MODEL_COLOR[m], lw=3.2,
                            label=MODEL_LABEL[m]) for m in models_present]
    arch_handles = [Line2D([0], [0], color="black", lw=2.4,
                           markerfacecolor="none", markeredgewidth=2.0,
                           label=a, **ARCH_STYLE[a])
                    for a in archs_present]
    # Stack: caption, then the programming-model legend, then the architectures.
    fig.canvas.draw()
    cap_bb = caption.get_window_extent().transformed(ax.transAxes.inverted())
    leg1 = ax.legend(handles=model_handles, loc="upper left",
                     bbox_to_anchor=(0.01, cap_bb.y0 - 0.02), framealpha=0.9)
    ax.add_artist(leg1)
    fig.canvas.draw()
    bb = leg1.get_window_extent().transformed(ax.transAxes.inverted())
    ax.legend(handles=arch_handles, loc="upper left",
              bbox_to_anchor=(bb.x0, bb.y0 - 0.03), framealpha=0.9)

    out_dir.mkdir(parents=True, exist_ok=True)
    out = out_dir / f"heat3d_bandwidth_{prec}_{group_name}.png"
    fig.savefig(out, dpi=170)
    plt.close(fig)
    return out


def main():
    ap = argparse.ArgumentParser()
    fig_common.add_common_arguments(ap)
    args = ap.parse_args()
    data = collect(arch_map=fig_common.arch_map(args),
                   base=args.artifact_root / "heat3d")
    for prec in ("float32", "float64"):
        for group_name, archs in ARCH_GROUPS.items():
            print("Saved:", make_plot(data, prec, group_name, archs, args.out_dir))


if __name__ == "__main__":
    main()
