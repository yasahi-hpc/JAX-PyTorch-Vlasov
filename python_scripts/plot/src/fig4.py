#!/usr/bin/env python3
"""Cross-architecture vlp2d_2v bandwidth plots.

For each precision (fp32, fp64) two figures are produced, grouped by
architecture (so the fastest and slowest device share a y-scale and neither is
squished):
  * H200 + TPU    -> panel (a)
  * MI250X + PVC  -> panel (b)
Encoding:
  * programming model -> line COLOR   (JAX=blue, Kokkos=green, PyTorch=red)
  * architecture      -> LINESTYLE + MARKER, reused across the two panels since
    they are separate figures (first arch solid/*, second arch dashed/^; markers
    are drawn with edge color only)
JAX/PyTorch use solver2 (vlasov_step_gather_free); Kokkos uses solver1. The TPU
has JAX/fp32 data only; it appears on the fp32 H200+TPU figure only.

Data comes from ``artifact/vlasov2d_2v/<backend>/<sha7>/`` (one SHA7 per
architecture, overridable with ``--h200-sha`` etc.; see fig_common), located
relative to this file. Figures go to ``python_scripts/plot/imgs`` by default.

x-axis: 4-D phase-space grid 32²·32² .. 128²·128² (semilog, log2 points
positions); y-axis: modelled bandwidth GB/s (LINEAR). Enlarged legend / ticks
/ labels per the comparison spec.
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
from parse_cross_platform_vlp2d import (collect, SIZES, size_label, points_of)

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
MODEL_LABEL = {"jax": "JAX", "kokkos": "Kokkos",
               "pytorch": "PyTorch"}
# The two panels are separate figures, so the same linestyle/marker pair is
# reused in each; markers are unfilled (edge color only).
ARCH_STYLE = {
    "H200":   dict(linestyle="-",  marker="*", markersize=19),
    "TPU":    dict(linestyle="--", marker="^", markersize=13),
    "MI250X": dict(linestyle="-",  marker="*", markersize=19),
    "PVC":    dict(linestyle="--", marker="^", markersize=13),
}
ARCH_GROUPS = {"H200_TPU": ["H200", "TPU"], "MI250X_PVC": ["MI250X", "PVC"]}
GROUP_CAPTION = {"H200_TPU": "(a)", "MI250X_PVC": "(b)"}

# Bigger fonts for legend, ticks, labels, caption (per comparison spec).
plt.rcParams.update({
    "font.size": 20,
    "axes.labelsize": 24,
    "xtick.labelsize": 20,
    "ytick.labelsize": 21,
    "legend.fontsize": 19,
})

XPOS = [math.log2(points_of(nx, nvx)) for nx, nvx in SIZES]
XLAB = [rf"${nx}^2\!\cdot\!{nvx}^2$" for nx, nvx in SIZES]


def series(data, model, arch, prec):
    return [d["bw"] if (d := data[model].get(f"{arch}|{prec}|{size_label(nx, nvx)}"))
            else math.nan for nx, nvx in SIZES]


def make_plot(data, prec, group_name, archs, out_dir: Path):
    fig, ax = plt.subplots(figsize=(11.5, 7.2), constrained_layout=True)

    archs_present = []
    for arch in archs:
        drew = False
        for model in ("jax", "kokkos", "pytorch"):
            ys = series(data, model, arch, prec)
            if all(math.isnan(v) for v in ys):
                continue
            ax.plot(XPOS, ys, color=MODEL_COLOR[model], linewidth=2.8,
                    markerfacecolor="none", markeredgewidth=2.2,
                    **ARCH_STYLE[arch])
            drew = True
        if drew:
            archs_present.append(arch)

    ax.set_xticks(XPOS)
    ax.set_xticklabels(XLAB)
    ax.set_xlabel(r"Phase-space grid  $N_x^2\!\cdot\!N_{vx}^2$")
    ax.set_ylabel("Bandwidth (GB/s)")
    ax.grid(True, linestyle="--", alpha=0.4)
    ax.margins(x=0.04)
    # Headroom so the caption and the two stacked upper-left legends never sit
    # on a data point.
    ymax = max((v for a in archs_present for m in ("jax", "kokkos", "pytorch")
                for v in series(data, m, a, prec) if not math.isnan(v)), default=1.0)
    ax.set_ylim(0, ymax * 1.45)

    # Panel caption embedded at the top left, with the legends stacked below it.
    caption = ax.text(0.012, 0.985, GROUP_CAPTION[group_name],
                      transform=ax.transAxes, ha="left", va="top",
                      fontsize=28)

    models_present = [m for m in ("jax", "kokkos", "pytorch")
                      if any(not all(math.isnan(v) for v in series(data, m, a, prec))
                             for a in archs_present)]
    model_handles = [Line2D([0], [0], color=MODEL_COLOR[m], lw=3.6,
                            label=MODEL_LABEL[m]) for m in models_present]
    arch_handles = [Line2D([0], [0], color="black", lw=2.6,
                           markerfacecolor="none", markeredgewidth=2.2,
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
    out = out_dir / f"vlp2d_bandwidth_{prec}_{group_name}.png"
    fig.savefig(out, dpi=170)
    plt.close(fig)
    return out


def main():
    ap = argparse.ArgumentParser()
    fig_common.add_common_arguments(ap)
    args = ap.parse_args()
    data = collect(arch_map=fig_common.arch_map(args),
                   base=args.artifact_root / "vlasov2d_2v")
    for prec in ("float32", "float64"):
        for group_name, archs in ARCH_GROUPS.items():
            print("Saved:", make_plot(data, prec, group_name, archs, args.out_dir))


if __name__ == "__main__":
    main()
