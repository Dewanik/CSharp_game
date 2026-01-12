# Nintendo Switch ARM Hello World

A minimal Hello World application for Nintendo Switch development using **libnx**.

## Quick Start

### 1. Install Development Tools
```bash
# Follow the detailed guide in COMPILE.md
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
```bash
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM
export PATH=$DEVKITARM/bin:$PATH
```

### "arm-none-eabi-gcc not found"
```bash
sudo dkp-pacman -S devkitARM
```

### "switch.h not found"
```bash
sudo dkp-pacman -S libnx
```

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
