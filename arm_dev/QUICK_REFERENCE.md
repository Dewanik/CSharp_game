# Quick Reference - Nintendo Switch ARM Development

## 🚀 One-Time Setup (First Time Only)

### Debian-based Linux (Ubuntu, Debian, Linux Mint)
```bash
# 1. Install devkitPro using official script
wget https://apt.devkitpro.org/install-devkitpro-pacman
chmod +x ./install-devkitpro-pacman
sudo ./install-devkitpro-pacman

# 2. Add to ~/.bashrc or ~/.zshrc
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM
export PATH=$DEVKITARM/bin:$PATH

# 3. Reload shell
source ~/.bashrc
```

### WSL (Windows Subsystem for Linux)
```bash
# If needed, create mtab symlink
sudo ln -s /proc/self/mounts /etc/mtab

# Then follow Debian instructions above
```

### macOS
```bash
# Download from GitHub releases (v6.0.2):
# https://github.com/devkitPro/pacman/releases/tag/v6.0.2

# Install via terminal:
sudo installer -pkg /path/to/devkitpro-pacman-installer.pkg -target /

# Or right-click the .pkg and select "Open"

# Then add to ~/.zshrc:
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM
export PATH=$DEVKITARM/bin:$PATH
```

### Arch Linux
See: https://devkitpro.org/wiki/devkitPro_pacman

### Fedora/RHEL
See: https://devkitpro.org/wiki/devkitPro_pacman

### Gentoo
See: https://devkitpro.org/wiki/devkitPro_pacman

## 🛠 Build Commands

### Using Make (Recommended)
```bash
cd /workspaces/CSharp_game/arm_dev
make clean     # Clean previous builds
make           # Compile Hello World
```

### Using CMake
```bash
cd /workspaces/CSharp_game/arm_dev
mkdir -p build
cd build
cmake ..
make
```

### Direct Bash Script
```bash
cd /workspaces/CSharp_game/arm_dev
bash compile.sh
```

## ✅ Verification

```bash
# Check binary
file /workspaces/CSharp_game/arm_dev/hello_world.elf

# Should output: ELF 64-bit LSB executable, ARM aarch64...

# View symbols
arm-none-eabi-objdump -t /workspaces/CSharp_game/arm_dev/hello_world.elf

# Disassemble first 50 lines
arm-none-eabi-objdump -d /workspaces/CSharp_game/arm_dev/hello_world.elf | head -50
```

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| [COMPILE.md](arm_dev/COMPILE.md) | Full setup guide with troubleshooting |
| [README.md](arm_dev/README.md) | Quick start guide |
| [setup.sh](arm_dev/setup.sh) | Verify environment is set up |
| [compile.sh](arm_dev/compile.sh) | Direct compilation script |
| [Makefile](arm_dev/Makefile) | Traditional Make build system |
| [CMakeLists.txt](arm_dev/CMakeLists.txt) | CMake configuration |
| [src/main.c](arm_dev/src/main.c) | Hello World source code |

## 🔍 Troubleshooting Commands

```bash
# Verify DEVKITARM is set
echo $DEVKITARM
# Expected: /opt/devkitpro/devkitARM

# Verify arm-none-eabi-gcc works
arm-none-eabi-gcc --version

# Check libnx installation
ls $DEVKITPRO/libnx/include/switch.h

# View available tools
ls $DEVKITARM/bin/ | grep arm-none-eabi

# Check build output
ls -lh /workspaces/CSharp_game/arm_dev/hello_world.elf
```

## 📖 External References

- [devkitPro Installation Guide](https://devkitpro.org/wiki/devkitPro_pacman) - All distros
- [devkitPro GitHub Releases](https://github.com/devkitPro/pacman/releases/tag/v6.0.2) - v6.0.2 binaries
- [libnx GitHub](https://github.com/switchbrew/libnx)
- [devkitPro Official](https://devkitpro.org/)
- [Nintendo Switch Homebrew](https://switchbrew.org/)
- [ARM Developer Resources](https://developer.arm.com/)

## 🎯 Next Steps After Hello World

1. **Graphics:** Add framebuffer rendering
2. **Input:** Handle Joy-Con button input
3. **Audio:** Implement sound output
4. **Physics:** Add game logic
5. **NRO Conversion:** Convert .elf to .nro for Homebrew Launcher

---

**Commands Reference Location:**
`/workspaces/CSharp_game/arm_dev/QUICK_REFERENCE.md`
