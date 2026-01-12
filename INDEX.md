# 🎮 Nintendo Switch ARM Development - Complete Setup

## ⚡ Start Here!

Your Nintendo Switch ARM development environment is **ready to use**!

### 📋 What You Need to Do

1. **Install devkitPro** (one-time setup)
   - Follow: [COMPILE.md](arm_dev/COMPILE.md#prerequisites)
   - Takes ~5 minutes

2. **Build Hello World**
   ```bash
   cd /workspaces/CSharp_game/arm_dev
   make clean && make
   ```

3. **Verify the build**
   ```bash
   file arm_dev/hello_world.elf
   ```

## 📚 Documentation

### Quick Links
- 🚀 **[SETUP_COMPLETE.md](SETUP_COMPLETE.md)** - Setup summary
- 📖 **[arm_dev/COMPILE.md](arm_dev/COMPILE.md)** - Full compilation guide ⭐ START HERE
- 🔧 **[arm_dev/QUICK_REFERENCE.md](arm_dev/QUICK_REFERENCE.md)** - Commands reference
- 📝 **[arm_dev/README.md](arm_dev/README.md)** - ARM dev overview
- 💻 **[arm_dev/src/main.c](arm_dev/src/main.c)** - Source code

## 🎯 One-Command Setup (Linux/WSL)

```bash
# For Debian-based systems (Ubuntu, Debian, Mint)
wget https://apt.devkitpro.org/install-devkitpro-pacman && \
chmod +x ./install-devkitpro-pacman && \
sudo ./install-devkitpro-pacman && \
echo "✅ Installation complete!"

# For WSL, if needed, run this first:
sudo ln -s /proc/self/mounts /etc/mtab
```

Then add to ~/.bashrc:
```bash
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM
export PATH=$DEVKITARM/bin:$PATH
```

## 🛠 Build Commands

```bash
cd /workspaces/CSharp_game/arm_dev

# Option 1: Make (recommended)
make clean && make

# Option 2: CMake
mkdir build && cd build && cmake .. && make

# Option 3: Direct script
bash compile.sh
```

## 📦 Project Structure

```
arm_dev/
├── src/main.c           ← Hello World source code
├── Makefile             ← Traditional make build
├── CMakeLists.txt       ← CMake alternative
├── compile.sh           ← Direct compilation
├── setup.sh             ← Environment verification
├── COMPILE.md           ← 📖 Full guide
├── README.md            ← Quick start
└── QUICK_REFERENCE.md   ← Command reference
```

## ✨ What's Included

- ✅ Hello World application
- ✅ Multiple build systems (Make, CMake)
- ✅ Full documentation
- ✅ Environment setup scripts
- ✅ Compilation scripts
- ✅ Troubleshooting guides
- ✅ External resource links

## 🔗 External Resources

| Resource | Link |
|----------|------|
| libnx SDK | https://github.com/switchbrew/libnx |
| devkitPro | https://devkitpro.org/ |
| Homebrew | https://switchbrew.org/ |
| ARM Docs | https://developer.arm.com/ |

## ✅ Verification Checklist

After installation:
```bash
# ✓ Verify DEVKITARM is set
echo $DEVKITARM
# Should show: /opt/devkitpro/devkitARM

# ✓ Verify arm-none-eabi-gcc works
arm-none-eabi-gcc --version

# ✓ Verify libnx headers
ls $DEVKITPRO/libnx/include/switch.h

# ✓ Build hello world
cd arm_dev && make clean && make

# ✓ Check output
file hello_world.elf
# Should show: ELF 64-bit LSB executable, ARM aarch64
```

## 🎮 Next Steps

1. ✅ **Setup complete** - You're here!
2. **→ Install devkitPro** - Follow [COMPILE.md](arm_dev/COMPILE.md)
3. **→ Build Hello World** - Run `make` in arm_dev/
4. **→ Verify binary** - Use `file` command
5. **→ Add graphics** - Extend with libnx drawing
6. **→ Add input** - Handle Joy-Con buttons
7. **→ Convert to NRO** - For Homebrew Launcher

## 🔍 Troubleshooting

| Issue | Solution |
|-------|----------|
| DEVKITARM not set | Run: `echo $DEVKITARM` and check setup |
| arm-none-eabi-gcc not found | Run: `sudo dkp-pacman -S devkitARM` |
| switch.h not found | Run: `sudo dkp-pacman -S libnx` |
| Make not found | Run: `sudo apt install build-essential` |
| Compilation errors | See [COMPILE.md#troubleshooting](arm_dev/COMPILE.md#troubleshooting) |

## 📞 Need Help?

See [arm_dev/COMPILE.md](arm_dev/COMPILE.md#troubleshooting) for detailed troubleshooting.

---

**Status:** ✅ Ready to build  
**Platform:** Nintendo Switch (ARM64)  
**Created:** January 12, 2026  
**Location:** `/workspaces/CSharp_game/arm_dev/`

**👉 Next:** Read [COMPILE.md](arm_dev/COMPILE.md) for installation instructions!
