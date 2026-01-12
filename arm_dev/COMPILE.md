# Nintendo Switch ARM Development - Compilation Guide

## Overview
This project sets up a Hello World application for Nintendo Switch ARM development using **libnx** - the official Nintendo Switch homebrew SDK.

## Prerequisites

### 1. Install devkitPro (Required)

**Debian-based Linux (Ubuntu, Debian, Linux Mint, etc.):**
```bash
# Download the official installation script
wget https://apt.devkitpro.org/install-devkitpro-pacman

# Make it executable
chmod +x ./install-devkitpro-pacman

# Run the installation script (reads the script first for security)
sudo ./install-devkitpro-pacman

# Update package manager
sudo dkp-pacman -Su

# Install devkitARM and libnx
sudo dkp-pacman -S devkitARM libnx switch-tools
```

**WSL (Windows Subsystem for Linux):**
```bash
# On some WSL systems, create this symlink first:
sudo ln -s /proc/self/mounts /etc/mtab

# Then follow Debian instructions above
wget https://apt.devkitpro.org/install-devkitpro-pacman
chmod +x ./install-devkitpro-pacman
sudo ./install-devkitpro-pacman
```

**Arch Linux:**
See official guide: https://devkitpro.org/wiki/devkitPro_pacman

**Fedora/RHEL based systems:**
See official guide: https://devkitpro.org/wiki/devkitPro_pacman

**Gentoo:**
See official guide: https://devkitpro.org/wiki/devkitPro_pacman

**macOS:**
```bash
# Download the .pkg installer from the official releases:
# https://github.com/devkitPro/pacman/releases/tag/v6.0.2

# Option 1: Install via terminal
sudo installer -pkg /path/to/devkitpro-pacman-installer.pkg -target /

# Option 2: Right-click the .pkg file and select "Open"

# Then install devkitARM and libnx
sudo dkp-pacman -S devkitARM libnx switch-tools
```

**Docker (Any Platform - CI/CD Recommended):**
For CI workflows and complete isolation, use official Docker images:
```bash
docker pull devkitpro/devkitarm
# See https://hub.docker.com/u/devkitpro for all available images
```
**Note:** Do NOT use pacman on CI workflows. Use Docker images instead.

**Official Installation Resources:**
- GitHub releases (v6.0.2): https://github.com/devkitPro/pacman/releases/tag/v6.0.2
- Installation guide (all distros): https://devkitpro.org/wiki/devkitPro_pacman

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
- [devkitPro Official Website](https://devkitpro.org/)
- [devkitPro pacman Installation Guide](https://devkitpro.org/wiki/devkitPro_pacman)
- [devkitPro GitHub Releases](https://github.com/devkitPro/pacman/releases/tag/v6.0.2)
- [devkitPro Docker Images](https://hub.docker.com/u/devkitpro)
- [Nintendo Switch Homebrew](https://switchbrew.org/)

## Troubleshooting

**Error: "DEVKITARM not found"**
```bash
# Verify installation
ls $DEVKITARM/bin/arm-none-eabi-gcc

# If not found, reinstall (Debian-based):
sudo ./install-devkitpro-pacman
sudo dkp-pacman -S libnx devkitARM
```

**Error: "libnx headers not found"**
```bash
# Check libnx installation
ls $DEVKITPRO/libnx/include/switch.h

# If missing, install:
sudo dkp-pacman -S libnx
```

**Error: "wget not working"**
```bash
# Try using curl instead:
curl https://apt.devkitpro.org/install-devkitpro-pacman -o install-devkitpro-pacman
chmod +x ./install-devkitpro-pacman
sudo ./install-devkitpro-pacman
```

**WSL: "Permission denied" or mount issues**
```bash
# Create the mtab symlink first:
sudo ln -s /proc/self/mounts /etc/mtab

# Then install normally
```

**Non-Debian systems: "pacman command not found"**
- Do NOT try to manually install the .deb file
- Follow the instructions for your specific distribution at:
  https://devkitpro.org/wiki/devkitPro_pacman

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
