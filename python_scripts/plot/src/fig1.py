"""
Camera-ready heat3d bandwidth figure: H200 vs TPU v5e, all three JAX solver
variants, fp32 (the TPU has no fp64 hardware).

Bandwidth is the benchmark's own "Estimated bandwidth (GB/s): best=..." line
(= N^3 * steps * 2 * sizeof / best_time: one read + one write of the field
per step), parsed directly from the artifact logs:

    artifact/heat3d/jax/<sha7>/heat3d_<arch>_float32_N<n>_solver<k>.txt

with one SHA7 per architecture (H200 d875542, TPU v5e 7e1e001 by default; see
fig_common.DEFAULT_SHAS). The artifact tree is located relative to this file, so
no absolute paths are baked in.

Styling per the paper draft requirements: semilog-x (log-2 problem sizes,
linear GB/s), no title, one color
per solver shared by both architectures, one marker per architecture, large
ticks/labels/legends. A solver/size cell with no run simply leaves a gap in
that line.

Usage:
    python fig1.py [--h200-sha SHA7] [--tpu-sha SHA7] [-o OUTPUT_BASENAME]
Writes <basename>.png into python_scripts/plot/imgs by default.
"""

import argparse
import pathlib
import re

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

import fig_common
plt.rcParams["font.family"] = "Times New Roman"
# The x tick labels are mathtext ($N^3$), which ignores font.family and would
# otherwise fall back to the DejaVu Sans math fontset.
plt.rcParams["mathtext.fontset"] = "custom"
plt.rcParams["mathtext.rm"] = "Times New Roman"
plt.rcParams["mathtext.it"] = "Times New Roman:italic"
plt.rcParams["mathtext.bf"] = "Times New Roman:bold"
plt.rcParams["mathtext.sf"] = "Times New Roman"
plt.rcParams["mathtext.cal"] = "Times New Roman:italic"  # default is 'cursive' (missing here)

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

PROBLEM_SIZES = [32, 64, 128, 256, 512]

# Architectures on this figure, in the order they are drawn: the key is the
# legend label, the value is the fig_common architecture name plus the marker.
ARCHS = {
    "H200": ("H200", "*"),
    "TPU v5e": ("TPU", "^"),
}

SOLVERS = {
    # solver number -> (legend label, color)
    0: ("take", "tab:red"),    # heat_step        (jnp.take)
    1: ("roll", "tab:green"),  # heat_step_roll   (jnp.roll)
    2: ("conv", "tab:blue"),   # heat_step_conv   (lax.conv_general_dilated)
}

BW_RE = re.compile(r"Estimated bandwidth \(GB/s\): best=([0-9.eE+-]+)")

FONT_AXIS = 20
FONT_TICK = 18
FONT_LEGEND = 17


def read_bandwidth(root: pathlib.Path, sha: str, tag: str, n: int, solver: int):
    path = root / sha / f"heat3d_{tag}_float32_N{n}_solver{solver}.txt"
    if not path.exists():
        return None
    m = BW_RE.search(path.read_text())
    return float(m.group(1)) if m else None


def main() -> None:
    parser = argparse.ArgumentParser()
    fig_common.add_common_arguments(parser, archs=["H200", "TPU"])
    parser.add_argument(
        "-o",
        "--output",
        type=pathlib.Path,
        default=None,
        help="output basename (writes .png); "
             "default <out-dir>/heat3d_bandwidth_H200_TPUv5e_fp32",
    )
    args = parser.parse_args()

    jax_root = args.artifact_root / "heat3d" / "jax"
    shas = fig_common.sha_map(args, archs=["H200", "TPU"])
    out_dir = fig_common.ensure_out_dir(args.out_dir)
    output = args.output or out_dir / "heat3d_bandwidth_H200_TPUv5e_fp32"

    fig, ax = plt.subplots(figsize=(8, 6))

    for arch, (arch_key, marker) in ARCHS.items():
        sha, tag = shas[arch_key], fig_common.ARCH_TAG[arch_key]
        for solver, (label, color) in SOLVERS.items():
            xs, ys = [], []
            for n in PROBLEM_SIZES:
                bw = read_bandwidth(jax_root, sha, tag, n, solver)
                if bw is not None:
                    xs.append(n)
                    ys.append(bw)
            ax.plot(
                xs,
                ys,
                color=color,
                marker=marker,
                markeredgecolor=color,
                markerfacecolor='none',
                markersize=12,
                linewidth=2.2,
                linestyle="-" if arch == "H200" else "--",
            )

    # Semilog: log-2 problem-size axis, linear bandwidth axis. No title.
    ax.set_xscale("log", base=2)
    ax.set_ylim(bottom=0)
    ax.set_xticks(PROBLEM_SIZES)
    ax.set_xticklabels([rf"${n}^3$" for n in PROBLEM_SIZES], fontsize=FONT_TICK)
    ax.minorticks_off()
    ax.tick_params(axis="y", labelsize=FONT_TICK)
    ax.set_xlabel("Problem size", fontsize=FONT_AXIS)
    ax.set_ylabel("Bandwidth (GB/s)", fontsize=FONT_AXIS)
    ax.grid(True, alpha=0.3)

    # Two compact legends: colors identify the solver, markers the machine.
    solver_handles = [
        plt.Line2D([], [], color=color, linewidth=2.2, label=label)
        for _, (label, color) in SOLVERS.items()
    ]
    arch_handles = [
        plt.Line2D(
            [],
            [],
            color="black",
            marker=marker,
            markersize=10,
            linewidth=2.2,
            linestyle="-" if arch == "H200" else "--",
            label=arch,
        )
        for arch, (_, marker) in ARCHS.items()
    ]
    leg1 = ax.legend(
        handles=solver_handles, fontsize=FONT_LEGEND, loc="upper left", frameon=True
    )
    ax.add_artist(leg1)
    # Center-right is the one region no curve crosses (between the conv
    # plateau at ~150 GB/s and the take/roll plateau above 1400 GB/s).
    ax.legend(
        handles=arch_handles,
        fontsize=FONT_LEGEND,
        loc="center right",
        frameon=True,
    )

    fig.tight_layout()
    fig_common.ensure_out_dir(output.parent)
    out = output.with_suffix(".png")
    fig.savefig(out, dpi=300)
    print(f"Saved: {out}")
    plt.close(fig)


if __name__ == "__main__":
    main()
