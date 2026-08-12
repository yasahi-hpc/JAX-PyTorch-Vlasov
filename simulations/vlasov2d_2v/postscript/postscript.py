""" 
A module for loading simulation data files and providing access to the data
for different variables and iterations.
"""

import argparse
import pathlib
from typing import Tuple, List
import numpy as np
import xarray as xr
import matplotlib.pyplot as plt
from joblib import Parallel, delayed

def load_dataset(data_dir: str, nx: int, suffix: str) -> None:
    data_path = pathlib.Path(data_dir)
    if not data_path.exists():
        raise FileNotFoundError(f"Directory {data_dir} does not exist.")
    
    files = sorted(list(data_path.glob(f'*.{suffix}')))
    ds = xr.open_mfdataset(files, engine='netcdf4', combine='by_coords')
    
    return ds

def plot_time_series(ds: xr.Dataset, fig_dir: str) -> None:
    fig_path = pathlib.Path(fig_dir)
    if not fig_path.exists():
        fig_path.mkdir(parents=True)
    
    # Volume integral
    phi = ds['phi'].integrate('x').integrate('y')
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
        
    Lx, Ly = ds.attrs['Lx'], ds.attrs['Ly']
        
    kw = {'origin': 'lower',
          'extent': [0, Lx, 0, Ly],
          'aspect': 'auto',
          'cmap': 'jet'}
    
    nstep = len(ds['time'])
    for it in range(nstep):
        phi = ds['phi'].isel(time=it)
        
        fig, ax = plt.subplots(figsize=(6,5))
        ax.imshow(phi.values.T, **kw)
        ax.set_xlabel('x', **axis_font)
        ax.set_ylabel('y', **axis_font)
        
        filename = fig_path / f'phi_{it:06d}.png'
        fig.savefig(filename, format='png', bbox_inches="tight")
        plt.close('all')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(add_help=True)
    parser.add_argument('-nx', nargs='?', type=int, default=32,
                        help="Grid size in one dimension (total grid will be (nx, nx, nx, nx))")
    parser.add_argument('-data_dir', nargs='?', type=str, default='data_python',
                        help="Directory containing the simulation data files")
    parser.add_argument('-fig_dir', nargs='?', type=str, default='img_python',
                        help="Directory where the generated plot PDFs will be saved")
    parser.add_argument('-suffix', nargs='?', type=str, default='nc',
                        help="File extension of the simulation data files ('nc' or 'dat')")
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
    
    ds = load_dataset(data_dir=args.data_dir, nx=args.nx, suffix=args.suffix)
    plot_time_series(ds=ds, fig_dir=args.fig_dir)
    plot_fields(ds=ds, fig_dir=args.fig_dir, n_jobs=args.n_jobs, var_dict={'phi': 1e-05})
    