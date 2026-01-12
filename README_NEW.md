# CSharp Game - Nintendo Switch ARM Development

A comprehensive C# game project with Nintendo Switch ARM development support.

## 📁 Project Structure

### `arm_dev/` - Nintendo Switch ARM Hello World
Complete setup for Nintendo Switch (ARM64) development using **libnx** SDK.

**Quick Links:**
- 📖 [Compilation Guide](arm_dev/COMPILE.md) - Detailed setup & build instructions
- 🚀 [ARM Development README](arm_dev/README.md) - Quick start guide
- 🛠 [Setup Script](arm_dev/setup.sh) - Automated environment check
- 📝 [Compile Script](arm_dev/compile.sh) - Direct compilation example

## Getting Started with ARM Development

### Prerequisites
```bash
# For Debian-based systems (Ubuntu, Debian, Linux Mint):
wget https://apt.devkitpro.org/install-devkitpro-pacman
chmod +x ./install-devkitpro-pacman
sudo ./install-devkitpro-pacman

# For WSL, if needed:
sudo ln -s /proc/self/mounts /etc/mtab

# For macOS:
# Download from: https://github.com/devkitPro/pacman/releases/tag/v6.0.2
# sudo installer -pkg devkitpro-pacman-installer.pkg -target /

# For other distributions (Arch, Fedora, Gentoo):
# See: https://devkitpro.org/wiki/devkitPro_pacman
```

### Quick Compile
```bash
cd arm_dev

# Check environment
bash setup.sh

# Build Hello World
make clean && make

# Or use CMake
mkdir build && cd build && cmake .. && make
```

### Verify Build
```bash
file arm_dev/hello_world.elf
# Output: ELF 64-bit LSB executable, ARM aarch64
```

## Documentation

| File | Purpose |
|------|---------|
| [COMPILE.md](arm_dev/COMPILE.md) | Complete compilation guide with troubleshooting |
| [README.md](arm_dev/README.md) | ARM development quick start |
| [setup.sh](arm_dev/setup.sh) | Environment setup verification |
| [compile.sh](arm_dev/compile.sh) | Direct compilation script |

## Features

✅ Hello World application for Nintendo Switch  
✅ Makefile build system  
✅ CMake support  
✅ Comprehensive documentation  
✅ ARM64 (ARMv8-A) architecture  
✅ libnx SDK integration  

## Resources

- 📚 [libnx Official Documentation](https://github.com/switchbrew/libnx)
- 🔧 [devkitPro Tools](https://devkitpro.org/)
- 📖 [devkitPro Installation Guide](https://devkitpro.org/wiki/devkitPro_pacman) - All distros
- 🔗 [devkitPro GitHub Releases](https://github.com/devkitPro/pacman/releases/tag/v6.0.2) - v6.0.2 binaries
- 🏠 [Nintendo Switch Homebrew](https://switchbrew.org/)
- 🐳 [devkitPro Docker Images](https://hub.docker.com/u/devkitpro)

## Environment Setup

Set these in your shell profile (~/.bashrc or ~/.zshrc):
```bash
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM
export PATH=$DEVKITARM/bin:$PATH
```

## Next Steps

1. ✅ Build Hello World
2. 📊 Explore libnx graphics examples
3. 🎮 Add input handling for game development
4. 📦 Convert to NRO format for Homebrew Launcher

---

**Last Updated:** January 12, 2026  
**Target Platform:** Nintendo Switch (ARM64)
