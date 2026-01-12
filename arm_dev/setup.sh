#!/bin/bash
# Nintendo Switch ARM Development Setup Script
# This script sets up the development environment

set -e

echo "========================================="
echo "Nintendo Switch ARM Dev Setup"
echo "========================================="

# Check if devkitARM is installed
if [ -z "$DEVKITARM" ]; then
    echo "❌ DEVKITARM not set!"
    echo ""
    echo "To install devkitPro:"
    echo ""
    echo "Linux/WSL:"
    echo "  wget https://github.com/devkitPro/pacman/releases/download/devkitpro-pacman-1.0.1/devkitpro-pacman.amd64.deb"
    echo "  sudo dpkg -i devkitpro-pacman.amd64.deb"
    echo "  sudo dkp-pacman -S devkitARM libnx switch-tools"
    echo ""
    echo "Then add to ~/.bashrc or ~/.zshrc:"
    echo "  export DEVKITPRO=/opt/devkitpro"
    echo "  export DEVKITARM=\$DEVKITPRO/devkitARM"
    echo "  export PATH=\$DEVKITARM/bin:\$PATH"
    exit 1
fi

echo "✅ DEVKITARM found at: $DEVKITARM"

# Verify arm-none-eabi-gcc
if ! command -v arm-none-eabi-gcc &> /dev/null; then
    echo "❌ arm-none-eabi-gcc not found in PATH"
    exit 1
fi

echo "✅ arm-none-eabi-gcc available"

# Check libnx
if [ ! -f "$DEVKITPRO/libnx/include/switch.h" ]; then
    echo "❌ libnx headers not found"
    echo "Install with: sudo dkp-pacman -S libnx"
    exit 1
fi

echo "✅ libnx headers found"

echo ""
echo "========================================="
echo "Environment Ready!"
echo "========================================="
echo ""
echo "Build with:"
echo "  cd arm_dev"
echo "  make"
echo ""
echo "Or with CMake:"
echo "  cd arm_dev"
echo "  mkdir build && cd build"
echo "  cmake .."
echo "  make"
echo ""
