#!/bin/bash
# Nintendo Switch ARM Development Setup Script
# This script sets up the development environment

set -e

echo "========================================="
echo "Nintendo Switch ARM Dev Setup"
echo "========================================="

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
else
    OS="other"
fi

echo "Detected OS: $OS"
echo ""

# Check if devkitARM is installed
if [ -z "$DEVKITARM" ]; then
    echo "❌ DEVKITARM not set!"
    echo ""
    echo "To install devkitPro, visit: https://devkitpro.org/wiki/devkitPro_pacman"
    echo ""
    
    if [ "$OS" = "linux" ]; then
        echo "For Debian-based systems (Ubuntu, Debian, Mint):"
        echo "  wget https://apt.devkitpro.org/install-devkitpro-pacman"
        echo "  chmod +x ./install-devkitpro-pacman"
        echo "  sudo ./install-devkitpro-pacman"
        echo ""
        echo "For WSL (if needed, run first):"
        echo "  sudo ln -s /proc/self/mounts /etc/mtab"
        echo ""
        echo "For Arch/Fedora/RHEL/Gentoo, see official guide:"
        echo "  https://devkitpro.org/wiki/devkitPro_pacman"
    elif [ "$OS" = "macos" ]; then
        echo "For macOS:"
        echo "  1. Download .pkg from:"
        echo "     https://github.com/devkitPro/pacman/releases/tag/v6.0.2"
        echo "  2. Install with:"
        echo "     sudo installer -pkg devkitpro-pacman-installer.pkg -target /"
        echo "  3. Or right-click .pkg and select 'Open'"
    fi
    
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
