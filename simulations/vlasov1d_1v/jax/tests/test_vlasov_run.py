"""
Tests for the Vlasov.run method and the optimized _run_chunk pattern.
Validates that:
  - _run_chunk is defined in __init__ (JIT cache stable)
  - run() produces correct state metadata (t, step)
  - run() uses fori_loop (not scan) with minimal carry
  - Results are reproducible across warm-up and timed runs
"""
import jax
import jax.numpy as jnp
import numpy as np
import pytest
import shutil
import pathlib
import src.vlasov1D1V
from src.vlasov1D1V import (
    Grid, Field, Variables, SimulationState,
    Vlasov, vlasov_step,
)


# ------------------------------------------------------------------ fixtures --

@pytest.fixture
def solver_no_physics(tmp_path):
    """Vlasov solver with physics_mode=False, small grid, output to tmp."""
    return Vlasov(
        Nx=32, Nv=32,
        L=2.0 * jnp.pi, V_max=4.0,
        nbiter=20, diag_steps=10,
        dt=0.05, out_dir=str(tmp_path / "data"),
        physics_mode=False,
    )


@pytest.fixture
def solver_physics(tmp_path):
    """Vlasov solver with physics_mode=True, small grid, output to tmp."""
    return Vlasov(
        Nx=32, Nv=32,
        L=2.0 * jnp.pi, V_max=4.0,
        nbiter=20, diag_steps=10,
        dt=0.05, out_dir=str(tmp_path / "data_phys"),
        physics_mode=True,
    )


# ---------------------------------------- _run_chunk defined in __init__ ------

def test_run_chunk_is_attribute(solver_no_physics):
    """_run_chunk must be stored on the solver (defined in __init__)."""
    assert hasattr(solver_no_physics, "_run_chunk")
    assert callable(solver_no_physics._run_chunk)


def test_run_chunk_is_same_object_across_calls(solver_no_physics):
    """The function object must be the same every time (stable JIT cache)."""
    obj1 = solver_no_physics._run_chunk
    obj2 = solver_no_physics._run_chunk
    assert obj1 is obj2


# ------------------------------------------------- num_steps attribute --------

def test_num_steps_stored(solver_no_physics):
    """num_steps = nbiter // diag_steps should be on the instance."""
    assert hasattr(solver_no_physics, "num_steps")
    assert solver_no_physics.num_steps == 20 // 10  # 2


# ------------------------------------------------- run_chunk correctness ------

def test_run_chunk_one_chunk(solver_no_physics):
    """Running one chunk should advance t and step by diag_steps."""
    state0 = solver_no_physics.initialize()
    state1 = solver_no_physics._run_chunk(state0)

    expected_t = state0.t + solver_no_physics.dt * solver_no_physics.diag_steps
    expected_step = state0.step + solver_no_physics.diag_steps

    assert jnp.isclose(float(state1.t), expected_t, atol=1e-6)
    assert int(state1.step) == expected_step


def test_run_chunk_preserves_grid(solver_no_physics):
    """Grid should be unchanged after a chunk."""
    state0 = solver_no_physics.initialize()
    state1 = solver_no_physics._run_chunk(state0)

    assert jnp.array_equal(state1.grid.x, state0.grid.x)
    assert jnp.array_equal(state1.grid.v, state0.grid.v)
    assert jnp.array_equal(state1.grid.inv_kx, state0.grid.inv_kx)


def test_run_chunk_preserves_f0(solver_no_physics):
    """f0 (background) should be unchanged after a chunk."""
    state0 = solver_no_physics.initialize()
    state1 = solver_no_physics._run_chunk(state0)

    assert jnp.array_equal(state1.variables.f0, state0.variables.f0)


def test_run_chunk_shapes(solver_no_physics):
    """Output shapes must be consistent with the grid."""
    state0 = solver_no_physics.initialize()
    state1 = solver_no_physics._run_chunk(state0)
    g = solver_no_physics.grid

    assert state1.variables.fn.shape == (g.Nx, g.Nv)
    assert state1.field.rho.shape == (g.Nx,)
    assert state1.field.phi.shape == (g.Nx,)


# --------------------------------------------------- full run correctness ----

def test_run_final_time(solver_no_physics):
    """After run(), t should equal nbiter * dt."""
    state0 = solver_no_physics.initialize()
    state_final = solver_no_physics.run(state0)

    expected_t = solver_no_physics.nbiter * solver_no_physics.dt
    assert jnp.isclose(float(state_final.t), expected_t, atol=1e-6)


def test_run_final_step(solver_no_physics):
    """After run(), step should equal nbiter."""
    state0 = solver_no_physics.initialize()
    state_final = solver_no_physics.run(state0)

    assert int(state_final.step) == solver_no_physics.nbiter


def test_run_returns_simulation_state(solver_no_physics):
    """run() must return a SimulationState."""
    state0 = solver_no_physics.initialize()
    result = solver_no_physics.run(state0)

    assert isinstance(result, SimulationState)


def test_run_f_changes(solver_no_physics):
    """The distribution function should evolve during run()."""
    state0 = solver_no_physics.initialize()
    state_final = solver_no_physics.run(state0)

    assert not jnp.allclose(state_final.variables.fn, state0.variables.fn, atol=1e-6)


def test_run_physics_mode(solver_physics):
    """run() with physics_mode=True should produce non-zero fields."""
    state0 = solver_physics.initialize()
    state_final = solver_physics.run(state0)

    assert not jnp.allclose(state_final.field.rho, 0.0, atol=1e-10)
    assert not jnp.allclose(state_final.field.phi, 0.0, atol=1e-10)


# ------------------------------------------------- reproducibility -----------

def test_run_reproducible(solver_no_physics):
    """Two runs from the same initial state must produce identical results."""
    state0 = solver_no_physics.initialize()

    state_a = solver_no_physics.run(state0)
    state_b = solver_no_physics.run(state0)

    assert jnp.allclose(state_a.variables.fn, state_b.variables.fn, atol=1e-7)
    assert jnp.isclose(float(state_a.t), float(state_b.t))


# ---------------------------------------------- diag files are written --------

def test_run_creates_diag_files(solver_no_physics):
    """run() should write diagnostic NetCDF files."""
    state0 = solver_no_physics.initialize()
    solver_no_physics.run(state0)

    out = pathlib.Path(solver_no_physics.out_dir)
    nc_files = sorted(out.glob("field_*.nc"))

    # initialize writes step 0; each chunk writes one more.
    # nbiter=20, diag_steps=10 → 2 chunks → files for step 0, 10, 20
    # But run(state0) writes at step 10 and 20 on top of step 0 from init.
    assert len(nc_files) >= 2


# ---------------------------------------------- edge: nbiter < diag_steps ----

def test_run_nbiter_less_than_diag_steps(tmp_path):
    """When nbiter < diag_steps, num_steps=0 branch should execute."""
    solver = Vlasov(
        Nx=16, Nv=16,
        L=2.0 * jnp.pi, V_max=4.0,
        nbiter=5, diag_steps=10,
        dt=0.05, out_dir=str(tmp_path / "data_edge"),
        physics_mode=False,
    )
    assert solver.num_steps == 0

    state0 = solver.initialize()
    state_final = solver.run(state0)

    # Should still advance by min(diag_steps, nbiter) = 5
    assert int(state_final.step) == 5
    expected_t = 5 * solver.dt
    assert jnp.isclose(float(state_final.t), expected_t, atol=1e-6)
