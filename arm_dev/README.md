# Nintendo Switch ARM Hello World

A minimal Hello World application for Nintendo Switch development using **libnx**.

## Quick Start

### 1. Install Development Tools
See [COMPILE.md](COMPILE.md) for detailed instructions for your OS:
- **Linux/Debian:** `wget https://apt.devkitpro.org/install-devkitpro-pacman && chmod +x ./install-devkitpro-pacman && sudo ./install-devkitpro-pacman`
- **macOS:** Download .pkg from [GitHub Releases](https://github.com/devkitPro/pacman/releases/tag/v6.0.2)
- **WSL:** May need to first run `sudo ln -s /proc/self/mounts /etc/mtab`
- **Arch/Fedora/Gentoo:** See [devkitpro.org/wiki/devkitPro_pacman](https://devkitpro.org/wiki/devkitPro_pacman)

Then run setup verification:
```bash
bash setup.sh
```

### 2. Compile
```bash
cd arm_dev
make clean
make
```

### 3. Verify Build
```bash
file hello_world.elf
# Expected: ELF 64-bit LSB executable, ARM aarch64
```

## What You Get

- ✅ **hello_world.elf** - Compiled Nintendo Switch executable
- ✅ **C Development Environment** - Full ARM cross-compiler toolchain
- ✅ **Build System** - Makefile + CMake support
- ✅ **Compilation Guide** - Step-by-step setup instructions

## File Structure

```
arm_dev/
├── src/main.c              # Hello World source
├── Makefile                # Build configuration
├── CMakeLists.txt          # CMake alternative
├── COMPILE.md              # Detailed compilation guide
├── setup.sh                # Environment setup script
└── README.md               # This file
```

## Documentation Links

📖 **[Compilation Guide](COMPILE.md)** - Detailed setup and build instructions

📚 **[libnx GitHub](https://github.com/switchbrew/libnx)** - Official SDK documentation

🔧 **[devkitPro](https://devkitpro.org/)** - Development tools

## Troubleshooting

### "DEVKITARM not set"
See [COMPILE.md](COMPILE.md#prerequisites) for your OS-specific installation

### "arm-none-eabi-gcc not found"
```bash
sudo dkp-pacman -S devkitARM
```

### "switch.h not found"
```bash
sudo dkp-pacman -S libnx
```

### "wget not working"
```bash
# Use curl instead:
curl https://apt.devkitpro.org/install-devkitpro-pacman -o install-devkitpro-pacman
chmod +x ./install-devkitpro-pacman
sudo ./install-devkitpro-pacman
```

See [COMPILE.md - Troubleshooting](COMPILE.md#troubleshooting) for more help.

## Platform Support

- **Target:** Nintendo Switch (ARM64 - Cortex-A57)
- **Architecture:** ARMv8-A
- **SDK:** libnx

## Next Steps

1. ✅ Hello World working
2. Try the graphics examples in libnx
3. Build more complex applications
4. Convert to NRO format for Homebrew Launcher

---

For more information, see [COMPILE.md](COMPILE.md)
