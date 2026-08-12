# AI frameworks for Performance Portable Vlasov code

Evaluating the capability of AI frameworks (JAX, PyTorch) as a performance portability framework.

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
