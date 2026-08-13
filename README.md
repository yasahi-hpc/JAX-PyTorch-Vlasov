# AI frameworks for Performance Portable Vlasov code

Evaluating the capability of AI frameworks (JAX, PyTorch) as a performance portability framework. We have implemented 3D heat equation solver and 4D (2D space and 2D velocity space) Vlasov-Poisson solver. These mini-apps are parallelized with [JAX](https://github.com/jax-ml/jax), [PyTorch](https://github.com/pytorch/pytorch) and [Kokkos](https://github.com/kokkos/kokkos).

This repository includes the following mini-apps (JAX versions are also available through google Colab):

|  [heat3d](docs/heat3d.md) |  [vlasov1d-1v](docs/vlp1d-1v.md)  |  [vlasov2d-2v](docs/vlp2d-2v.md) | 
| :-: | :-: | :-: |
|  <a target="_blank" href="https://colab.research.google.com/github/yasahi-hpc/JAX-PyTorch-Vlasov/blob/main/simulations/heat3d/jax/src/heat3d.ipynb"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a> | <a target="_blank" href="https://colab.research.google.com/github/yasahi-hpc/JAX-PyTorch-Vlasov/blob/main/simulations/vlasov1d_1v/jax/src/vlp1d_1v.ipynb"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a> | <a target="_blank" href="https://colab.research.google.com/github/yasahi-hpc/JAX-PyTorch-Vlasov/blob/main/simulations/vlasov2d_2v/jax/src/vlp2d_2v.ipynb"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a> | 

## Using

First of all, you need to clone this repo.

```bash
git clone --recursive https://github.com/yasahi-hpc/JAX-PyTorch-Vlasov.git
```

## Prerequisites

We need the following for Kokkos codes.

* `CMake 3.22+`
* `Kokkos 5.2+`
* `kokkos-fft 1.1+`
* `gcc 11.0.0+` (CPUs)
* `IntelLLVM 2025.0.0+` (CPUs, Intel GPUs)
* `nvcc 11.0.0+` (NVIDIA GPUs)
* `rocm 5.6.0+` (AMD GPUs)

For JAX/PyTorch codes, we need

* `python 3.10+`
* `numpy`
* `matplotlib`
* `xarray[io], xarray[viz]`
* `joblib`
* `jax`
* `pytorch`

`jax` and `pytorch` should be installed with target GPU support.

### Compile and run

For compilation, we basically rely on the CMake options for Kokkos. For example, the compile options for H200 GPU is as follows.

```bash
cmake -B build_gpu -DCMAKE_CXX_COMPILER=g++ \
      -DCMAKE_BUILD_TYPE=Release \
      -DKokkos_ENABLE_CUDA=ON \
      -DKokkos_ARCH_HOPPER90=ON \
      -DVLP4D_ENABLE_INTERNAL_KOKKOS=ON \
      -DVLP4D_ENABLE_INTERNAL_KOKKOSFFT=ON \
      -DVLP4D_ENABLE_TESTS=ON

cmake --build build_gpu -j 8
```

To run the tests, please run the following command.

```bash
cd build
ctest --output-on-failure
```

More details are given in the docs for [heat3d](docs/heat3d.md), [vlasov1d-1v](docs/vlp1d-1v.md) and [vlasov2d-2v](docs/vlp2d-2v.md).
