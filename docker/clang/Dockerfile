ARG BASE=ubuntu:latest
FROM $BASE

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
        build-essential \
        wget \
        gnupg \
        lsb-release \
        software-properties-common \
        git \
        bc \
        ccache \
        libfftw3-dev \
        cmake \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git config --global --add safe.directory "*"

# Install Clang++ version 20 and Clang-tidy version 20
RUN apt-get update && apt-get install -y \
    clang-20 \
    clang-tidy-20 \
    && rm -rf /var/lib/apt/lists/*

# Set Clang 20 as the default Clang and Clang++
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-20 100 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-20 100 \
    && update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-20 100

WORKDIR /work
CMD ["bash"]
