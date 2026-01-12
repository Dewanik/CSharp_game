# Quick Reference - Nintendo Switch ARM Development

## 🚀 One-Time Setup (First Time Only)

```bash
# 1. Install devkitPro
wget https://github.com/devkitPro/pacman/releases/download/devkitpro-pacman-1.0.1/devkitpro-pacman.amd64.deb
sudo dpkg -i devkitpro-pacman.amd64.deb
sudo dkp-pacman -S devkitARM libnx switch-tools

# 2. Add to ~/.bashrc or ~/.zshrc
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM
export PATH=$DEVKITARM/bin:$PATH

# 3. Reload shell
source ~/.bashrc
```

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
