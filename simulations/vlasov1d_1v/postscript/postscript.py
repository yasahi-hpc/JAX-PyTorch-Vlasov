"""
A module for loading simulation data files and providing access to the data
for different variables and iterations.

Two output formats are supported:

* netCDF (``field_######.nc``), written by the JAX solver
  ``simulations/vlasov1d_1v/jax/src/vlasov1D1V.py``. Grid, time and physical
  parameters are stored in the files themselves.
* raw binary (``fn_######.bin``, ``f0_######.bin``, ``rho_######.bin``,
  ``phi_######.bin``), written by the Kokkos solver
  ``simulations/vlasov1d_1v/kokkos/src/vlasov_poisson.hpp``. These files carry
  no metadata, so the grid (``nx``, ``nv``, ``lx``, ``vmax``) and the time step
  ``dt`` must be passed on the command line and must match the values used for
  the run. Both formats are turned into the same ``xarray.Dataset``, so the
  plotting routines below are format agnostic.
"""

import argparse
import pathlib
from typing import Dict, List, Tuple
import numpy as np
import xarray as xr
import matplotlib.pyplot as plt
from joblib import Parallel, delayed

# Suffixes of the raw binary dumps of the Kokkos solver ('bin' is what
# VlasovPoisson::to_binary_file writes, 'dat' is accepted for older runs).
BINARY_SUFFIXES = ('bin', 'dat')

# Variables written by the Kokkos solver, mapped onto the netCDF names of the
# JAX solver together with their dimensions.
KOKKOS_VARS = {
    'fn': ('f', ('x', 'v')),
    'f0': ('f0', ('v',)),
    'rho': ('rho', ('x',)),
    'phi': ('phi', ('x',)),
}

def step_of(file_path: pathlib.Path) -> int:
    """
    Extract the iteration number from a file name such as ``fn_000010.bin``.

    Parameters
    ----------
    file_path : pathlib.Path
        Path of a binary snapshot.

    Returns
    -------
    int
        The iteration number encoded in the file name.

    Raises
    ------
    ValueError
        If the file name does not end with ``_<step>``.
    """
    step = file_path.stem.rsplit('_', 1)[-1]
    if not step.isdigit():
        raise ValueError(
            f'Cannot extract the iteration number from {file_path.name}. '
            f'Expected a name of the form <var>_######.<suffix>.'
        )
    return int(step)

def infer_binary_dtype(file_path: pathlib.Path, size: int) -> np.dtype:
    """
    Infer the floating point type of a binary snapshot from its size.

    The Kokkos solver is compiled either in single (``ENABLE_FP32``) or in
    double precision and dumps raw ``RealType`` values without any header, so
    the element size is recovered from the file size and the expected number
    of elements.

    Parameters
    ----------
    file_path : pathlib.Path
        Path of a binary snapshot.
    size : int
        Expected number of elements in the file.

    Returns
    -------
    np.dtype
        ``np.float32`` or ``np.float64``.

    Raises
    ------
    ValueError
        If the file size is not ``size`` times 4 or 8 bytes, which means that
        the grid passed on the command line does not match the data.
    """
    nbytes = file_path.stat().st_size
    itemsize, remainder = divmod(nbytes, size)
    if remainder != 0 or itemsize not in (4, 8):
        raise ValueError(
            f'{file_path} holds {nbytes} bytes, which is not {size} float32 '
            f'or float64 values. The grid given on the command line does not '
            f'fit the data in this directory.'
        )
    return np.dtype(np.float32) if itemsize == 4 else np.dtype(np.float64)

def read_binary(file_path: pathlib.Path, shape: tuple, dtype: np.dtype) -> np.ndarray:
    """
    Read a single binary snapshot written by the Kokkos solver.

    Parameters
    ----------
    file_path : pathlib.Path
        Path of the binary snapshot.
    shape : tuple
        Expected shape of the array, e.g. ``(nx, nv)`` for ``fn``.
    dtype : np.dtype
        Floating point type of the data (see ``infer_binary_dtype``).

    Returns
    -------
    np.ndarray
        The array stored in the file.

    Raises
    ------
    ValueError
        If the file does not hold the expected number of elements.
    """
    var = np.fromfile(file_path, dtype=dtype)
    if var.size != int(np.prod(shape)):
        raise ValueError(
            f'{file_path} holds {var.size} elements, but shape {shape} was '
            f'expected. The grid given on the command line does not fit the '
            f'data in this file.'
        )
    # The views are dumped as Kokkos::LayoutRight, i.e. C order.
    return var.reshape(shape)

def collect_binary_files(data_path: pathlib.Path, suffix: str) -> Tuple[List[int], Dict[str, Dict[int, pathlib.Path]]]:
    """
    Group the binary snapshots of a directory by variable and iteration.

    Parameters
    ----------
    data_path : pathlib.Path
        Directory containing the simulation data files.
    suffix : str
        File extension of the binary snapshots ('bin' or 'dat').

    Returns
    -------
    Tuple[List[int], Dict[str, Dict[int, pathlib.Path]]]
        The sorted list of iterations and, per variable, a mapping from
        iteration to file path.

    Raises
    ------
    FileNotFoundError
        If no file is found for one of the variables.
    ValueError
        If the variables are not dumped at the same iterations.
    """
    file_paths = {}
    for var_name in KOKKOS_VARS:
        paths = {
            step_of(p): p
            for p in data_path.glob(f'{var_name}_*.{suffix}')
        }
        if not paths:
            raise FileNotFoundError(
                f'{var_name}_######.{suffix} files are not found under {data_path}.'
            )
        file_paths[var_name] = paths

    steps = {var_name: set(paths) for var_name, paths in file_paths.items()}
    reference = steps['fn']
    if any(s != reference for s in steps.values()):
        nb_files = {var_name: len(s) for var_name, s in steps.items()}
        raise ValueError(
            f'The variables are not dumped at the same iterations: {nb_files}'
        )

    return sorted(reference), file_paths

def load_binary_dataset(data_dir: str, suffix: str, nx: int, nv: int,
                        lx: float, vmax: float, dt: float) -> xr.Dataset:
    """
    Load the raw binary output of the Kokkos solver into an ``xarray.Dataset``.

    The grid and the time step are not stored in the binary files and must
    therefore match the ones used for the run (see the report file
    ``vlp1d_1v_fp##.txt`` written next to the data directory).

    Parameters
    ----------
    data_dir : str
        Directory containing the simulation data files.
    suffix : str
        File extension of the binary snapshots ('bin' or 'dat').
    nx : int
        Number of grid points in the spatial direction.
    nv : int
        Number of grid points in the velocity direction.
    lx : float
        Physical domain length.
    vmax : float
        Maximum velocity.
    dt : float
        Time step size, used to convert iteration numbers into times.

    Returns
    -------
    xr.Dataset
        Dataset with the variables ``f``, ``f0``, ``rho`` and ``phi``, the
        coordinates ``time``, ``x``, ``v`` and the attributes ``dt``, ``L``
        and ``V_max``, i.e. the same layout as the netCDF output of the JAX
        solver.
    """
    data_path = pathlib.Path(data_dir)
    steps, file_paths = collect_binary_files(data_path, suffix)

    # The Grid constructor uses linspace(0, lx, nx, endpoint=false) in x and
    # linspace(-vmax, vmax, nv, endpoint=true) in v.
    coords = {
        'time': np.asarray(steps, dtype=np.float64) * dt,
        'x': np.linspace(0.0, lx, nx, endpoint=False),
        'v': np.linspace(-vmax, vmax, nv, endpoint=True),
    }
    shapes = {'x': nx, 'v': nv}

    dtype = infer_binary_dtype(file_paths['fn'][steps[0]], nx * nv)

    data_vars = {}
    for var_name, (name, dims) in KOKKOS_VARS.items():
        shape = tuple(shapes[dim] for dim in dims)
        var = np.stack([
            read_binary(file_paths[var_name][step], shape, dtype)
            for step in steps
        ])
        data_vars[name] = (('time',) + dims, var)

    return xr.Dataset(
        data_vars=data_vars,
        coords=coords,
        attrs={'dt': dt, 'L': lx, 'V_max': vmax},
    )

def load_dataset(data_dir: str, suffix: str, nx: int, nv: int,
                 lx: float, vmax: float, dt: float) -> xr.Dataset:
    """
    Load the simulation data of either solver into an ``xarray.Dataset``.

    Parameters
    ----------
    data_dir : str
        Directory containing the simulation data files.
    suffix : str
        File extension of the data files: 'nc' for the netCDF output of the
        JAX solver, 'bin' (or 'dat') for the binary output of the Kokkos
        solver.
    nx, nv, lx, vmax, dt
        Grid and time step of the run. Only used for the binary format, where
        they are not stored in the files.

    Returns
    -------
    xr.Dataset
        The simulation data.

    Raises
    ------
    FileNotFoundError
        If the data directory does not exist.
    ValueError
        If the suffix is neither 'nc' nor a binary suffix.
    """
    data_path = pathlib.Path(data_dir)
    if not data_path.exists():
        raise FileNotFoundError(f"Directory {data_dir} does not exist.")

    if suffix == 'nc':
        files = sorted(list(data_path.glob(f'*.{suffix}')))
        return xr.open_mfdataset(files, engine='netcdf4', combine='by_coords')

    if suffix in BINARY_SUFFIXES:
        return load_binary_dataset(data_dir=data_dir, suffix=suffix, nx=nx,
                                   nv=nv, lx=lx, vmax=vmax, dt=dt)

    raise ValueError(
        f'suffix {suffix} is not allowed. '
        f'suffix must be nc or one of {BINARY_SUFFIXES}.'
    )

def plot_time_series(ds: xr.Dataset, fig_dir: str) -> None:
    fig_path = pathlib.Path(fig_dir)
    if not fig_path.exists():
        fig_path.mkdir(parents=True)

    # Volume integral
    phi = ds['phi'].integrate('x')
    time = ds['time'].values
    analytical = np.exp(-0.153 * time) * 3.0e-4

    fig, ax = plt.subplots(figsize=(8,6))
    ax.semilogy(time, np.abs(phi.values))
    ax.semilogy(time, analytical, 'k--', label='Analytical: ' + r'$\exp(-0.153 t)$')
    ax.set_xlabel(r'$t$', **axis_font)
    ax.set_ylabel(r'$|\phi|$', **axis_font)
    ax.grid(which='both', linestyle='--', alpha=0.7)
    ax.legend(loc='upper right', prop={'family':'Times New Roman', 'size':20})

    filename = fig_path / 'time-series.pdf'
    fig.savefig(filename, format='pdf', bbox_inches="tight")
    plt.close('all')

def plot_fields(ds: xr.Dataset, fig_dir: str, n_jobs: int,
                var_dict: dict) -> None:
    fig_path = pathlib.Path(fig_dir)
    if not fig_path.exists():
        fig_path.mkdir(parents=True)

    L, V_max = ds.attrs['L'], ds.attrs['V_max']

    kw = {'origin': 'lower',
          'extent': [0, L, -V_max, V_max],
          'aspect': 'auto',
          'cmap': 'jet'}

    nstep = len(ds['time'])
    for it in range(nstep):
        f = ds['f'].isel(time=it) - ds['f0'].isel(time=it)

        fig, ax = plt.subplots(figsize=(6,5))
        ax.imshow(f.values.T, **kw)
        ax.set_xlabel('x', **axis_font)
        ax.set_ylabel('v', **axis_font)

        filename = fig_path / f'f_{it:06d}.png'
        fig.savefig(filename, format='png', bbox_inches="tight")
        plt.close('all')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(add_help=True)
    parser.add_argument('-nx', nargs='?', type=int, default=128,
                        help="Number of grid points in the spatial direction")
    parser.add_argument('-nv', nargs='?', type=int, default=128,
                        help="Number of grid points in the velocity direction")
    parser.add_argument('-lx', nargs='?', type=float, default=4.0*np.pi,
                        help="Physical domain length in the spatial direction")
    parser.add_argument('-vmax', nargs='?', type=float, default=5.0,
                        help="Maximum velocity in the velocity direction")
    parser.add_argument('-dt', nargs='?', type=float, default=0.05,
                        help="Time step size used for the run")
    parser.add_argument('-data_dir', nargs='?', type=str, default='data_kokkos',
                        help="Directory containing the simulation data files")
    parser.add_argument('-fig_dir', nargs='?', type=str, default='img_kokkos',
                        help="Directory where the generated plot PDFs will be saved")
    parser.add_argument('-suffix', nargs='?', type=str, default='bin',
                        help="File extension of the simulation data files ('nc', 'bin' or 'dat')")
    parser.add_argument('-n_jobs', nargs='?', type=int, default=8,
                        help="Number of parallel jobs for generating plots")
    args = parser.parse_args()

    # Plot settings
    fontname = 'Times New Roman'
    fontsize = 28
    plt.rc('xtick', labelsize=fontsize)
    plt.rc('ytick', labelsize=fontsize)
    plt.rc('font',  family=fontname)

    axis_font = {'fontname':fontname, 'size':fontsize}
    title_font = {
        'fontname': fontname,
        'size': fontsize,
        'color': 'black',
        'verticalalignment': 'bottom'
    }

    ds = load_dataset(data_dir=args.data_dir, suffix=args.suffix, nx=args.nx,
                      nv=args.nv, lx=args.lx, vmax=args.vmax, dt=args.dt)
    plot_time_series(ds=ds, fig_dir=args.fig_dir)
    #plot_fields(ds=ds, fig_dir=args.fig_dir, n_jobs=args.n_jobs, var_dict={'f': 1e-05})

