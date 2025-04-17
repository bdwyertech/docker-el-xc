# Cross-Compilation Docker Environment for ARM64

This project provides a Docker-based cross-compilation environment for building ARM64 (aarch64) binaries on x86_64 systems using Rocky Linux 8.

## Overview

The container builds and packages the complete GNU toolchain needed for cross-compiling to ARM64, based on Oracle Linux 8 (OL8u10) system libraries. This allows for building ARM64/aarch64 binaries that are compatible with Enterprise Linux 8+ distributions.

## Features

- Complete cross-compilation environment for ARM64/aarch64
- Based on Oracle Linux 8 Update 10 system libraries
- Includes GCC 8.5.0 compiler suite
- Suitable for building binaries compatible with RHEL/Oracle/Rocky Linux

## Usage
```bash
export CC=aarch64-ol8u10-linux-gnu-gcc
export CXX=aarch64-ol8u10-linux-gnu-g++
export AR=aarch64-ol8u10-linux-gnu-ar
export LD=aarch64-ol8u10-linux-gnu-ld
export RANLIB=aarch64-ol8u10-linux-gnu-ranlib
```
