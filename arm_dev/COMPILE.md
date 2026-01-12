# Nintendo Switch ARM Development - Compilation Guide

## Overview
This project sets up a Hello World application for Nintendo Switch ARM development using **libnx** - the official Nintendo Switch homebrew SDK.

## Prerequisites

### 1. Install devkitPro (Required)

**Linux/WSL:**
```bash
# Download the installer
wget https://github.com/devkitPro/pacman/releases/download/devkitpro-pacman-1.0.1/devkitpro-pacman.amd64.deb

# Install it
sudo dpkg -i devkitpro-pacman.amd64.deb

# Update package manager
sudo dkp-pacman -Su

# Install devkitARM and libnx
sudo dkp-pacman -S devkitARM libnx switch-tools
```

**macOS:**
```bash
# Using Homebrew
brew install devkitpro/devkitpro/devkitarm

# Install libnx
dkp-pacman -S libnx switch-tools
```

### 2. Set Environment Variables

Add to your shell profile (~/.bashrc, ~/.zshrc, or ~/.profile):
```bash
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM
export PATH=$DEVKITARM/bin:$PATH
```

Apply the changes:
```bash
source ~/.bashrc
# or
source ~/.zshrc
```

## Build Instructions

### Method 1: Using Make

```bash
cd arm_dev
make clean
make
```

Expected output:
- Successful compilation produces `hello_world.elf`

### Method 2: Using CMake

```bash
cd arm_dev
mkdir build && cd build
cmake ..
make
```

### Method 3: Using Clang (ARM Cross-Compiler)

```bash
cd arm_dev/src
arm-none-eabi-gcc -march=armv8-a -mtune=cortex-a57 \
  -D__SWITCH__ -Wall -O2 -c main.c -o main.o

arm-none-eabi-gcc -march=armv8-a -mtune=cortex-a57 \
  main.o -o hello_world.elf
```

## Verification

After successful compilation, verify the binary:

```bash
# Check if the file exists
file arm_dev/hello_world.elf

# Expected output:
# hello_world.elf: ELF 64-bit LSB executable, ARM aarch64, ...

# List symbols
arm-none-eabi-objdump -t arm_dev/hello_world.elf
```

## Running on Hardware

1. **Requires Hacked Switch:** The Hello World must be run on a modified Nintendo Switch with homebrew enabled
2. **Transfer the .elf file** to your Switch using:
   - Homebrew Launcher + nro conversion tools
   - FTP server on Switch

## Code Structure

```
arm_dev/
├── src/
│   └── main.c          # Hello World source code
├── build/              # Build output directory
├── Makefile            # Standard make build system
├── CMakeLists.txt      # CMake build configuration
└── COMPILE.md          # This file
```

## References

- [libnx Official Documentation](https://github.com/switchbrew/libnx)
- [devkitPro](https://devkitpro.org/)
- [Nintendo Switch Homebrew](https://switchbrew.org/)

## Troubleshooting

**Error: "DEVKITARM not found"**
```bash
# Verify installation
ls $DEVKITARM/bin/arm-none-eabi-gcc

# If not found, reinstall:
sudo dkp-pacman -R libnx devkitARM
sudo dkp-pacman -S devkitARM libnx
```

**Error: "libnx headers not found"**
```bash
# Check libnx installation
ls $DEVKITPRO/libnx/include/switch.h

# If missing, install:
sudo dkp-pacman -S libnx
```

**Compilation errors with C standard**
- Use C99: Add `-std=c99` to compilation flags
- Use C11: Add `-std=c11` to compilation flags

## Next Steps

1. ✅ Basic Hello World compiled
2. **Try graphics:** Add simple 2D graphics using libnx graphics APIs
3. **Add input handling:** Process joy-con input for games
4. **Create NRO format:** Convert .elf to .nro for Homebrew Launcher
5. **Optimize build:** Add release/debug configurations

---
**Last Updated:** January 12, 2026
**Target:** Nintendo Switch (ARM64)
