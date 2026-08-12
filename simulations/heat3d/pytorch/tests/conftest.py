import pytest
import sys
import os

# Workaround for Triton compilation on aarch64 with CC=nvc
if os.environ.get("CC") and "nvc" in os.environ["CC"]:
    os.environ["CC"] = "gcc"

import torch
import src.heat3d

@pytest.fixture
def grid_params():
    """Standard parameters for Grid creation."""
    return {
        "Nx": 8,
        "Ny": 8,
        "Nz": 8,
        "Lx": 2.0 * 3.141592653589793,
        "Ly": 2.0 * 3.141592653589793,
        "Lz": 2.0 * 3.141592653589793,
    }

@pytest.fixture
def grid_instance(grid_params):
    """Create a Grid instance using the imported module."""
    return src.heat3d.Grid.create(
        grid_params["Nx"], grid_params["Ny"], grid_params["Nz"],
        grid_params["Lx"], grid_params["Ly"], grid_params["Lz"],
        device='cpu'
    )

@pytest.fixture
def variables_instance(grid_instance):
    """Create a Variables instance with dummy data."""
    shape = (grid_instance.Nx, grid_instance.Ny, grid_instance.Nz)
    u = torch.zeros(shape)
    return src.heat3d.Variables(u)
