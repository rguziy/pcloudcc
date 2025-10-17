# ==========================
# Multi-ubuntu pCloudCC .deb build
# ==========================

# ---- Stage 1: Build on Ubuntu 18.04 ----
FROM ubuntu:18.04 AS build18

# Install build dependencies
RUN apt-get update && \
    apt-get install -y \
      cmake zlib1g-dev libboost-system-dev libboost-program-options-dev \
      libpthread-stubs0-dev libfuse-dev libudev-dev fuse build-essential git \
      checkinstall && \
    rm -rf /var/lib/apt/lists/*

# Clone pCloudCC repository
WORKDIR /src
RUN git clone https://github.com/pcloudcom/console-client.git pcloudcc

# Build pCloudCC
WORKDIR /src/pcloudcc/pCloudCC/lib/pclsync
RUN make clean && make fs

WORKDIR /src/pcloudcc/pCloudCC/lib/mbedtls
RUN cmake . && make clean && make

WORKDIR /src/pcloudcc/pCloudCC
RUN cmake . && make

# Create .deb package including library
RUN checkinstall -y --install=no --pkgname=pcloudcc --pkgversion=2.0.0 --backup=no --deldoc=yes --fstrans=no --default

# ---- Stage 1: Build on Ubuntu 22.04 ----
FROM ubuntu:22.04 AS build22

# Install build dependencies
RUN apt-get update && \
    apt-get install -y \
      cmake zlib1g-dev libboost-system-dev libboost-program-options-dev \
      libpthread-stubs0-dev libfuse-dev libudev-dev fuse build-essential git \
      checkinstall && \
    rm -rf /var/lib/apt/lists/*

# Clone pCloudCC repository
WORKDIR /src
RUN git clone https://github.com/pcloudcom/console-client.git pcloudcc

# Build pCloudCC
WORKDIR /src/pcloudcc/pCloudCC/lib/pclsync
RUN make clean && make fs

WORKDIR /src/pcloudcc/pCloudCC/lib/mbedtls
RUN cmake . && make clean && make

WORKDIR /src/pcloudcc/pCloudCC
RUN cmake . && make

# Create .deb package including library
RUN checkinstall -y --install=no --pkgname=pcloudcc --pkgversion=2.0.0 --backup=no --deldoc=yes --fstrans=no --default

# ---- Stage 1: Build on Ubuntu 24.04 ----
FROM ubuntu:24.04 AS build24

# Install build dependencies
RUN apt-get update && \
    apt-get install -y \
      cmake zlib1g-dev libboost-system-dev libboost-program-options-dev \
      libpthread-stubs0-dev libfuse-dev libudev-dev fuse build-essential git \
      checkinstall && \
    rm -rf /var/lib/apt/lists/*

# Clone pCloudCC repository
WORKDIR /src
RUN git clone https://github.com/pcloudcom/console-client.git pcloudcc

# Build pCloudCC
WORKDIR /src/pcloudcc/pCloudCC/lib/pclsync
RUN make clean && make fs

WORKDIR /src/pcloudcc/pCloudCC/lib/mbedtls
RUN cmake . && make clean && make

WORKDIR /src/pcloudcc/pCloudCC
RUN cmake . && make

# Create .deb package including library
RUN checkinstall -y --install=no --pkgname=pcloudcc --pkgversion=2.0.0 --backup=no --deldoc=yes --fstrans=no --default


# ---- Output stage ----
FROM ubuntu:22.04 AS output

# Create output directory for .deb files
RUN mkdir -p /out

# Copy the .deb package from the build stage
COPY --from=build18 /src/pcloudcc/pCloudCC/pcloudcc_2.0.0-1_amd64.deb /out/pcloudcc_2.0.0-1-ubuntu18_amd64.deb
COPY --from=build22 /src/pcloudcc/pCloudCC/pcloudcc_2.0.0-1_amd64.deb /out/pcloudcc_2.0.0-1-ubuntu22_amd64.deb
COPY --from=build24 /src/pcloudcc/pCloudCC/pcloudcc_2.0.0-1_amd64.deb /out/pcloudcc_2.0.0-1-ubuntu24_amd64.deb

# Copy the shared library
# COPY --from=build18 /usr/local/lib/libpcloudcc_lib.so /out/

# Set workdir for convenience
WORKDIR /out

# Default command just lists the contents of /out
CMD ["ls", "-l", "/out"]
