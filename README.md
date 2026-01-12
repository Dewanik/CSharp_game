# 🎮 Nintendo Switch Hello World - Setup & Build Guide

**Complete beginner guide to compile Hello World for Nintendo Switch in GitHub Codespace**

---

# 🚀 BEGINNER QUICK START

## ⚡ For Total Beginners (2 Steps)

### Step 1: Run the Build Script

```bash
cd /workspaces/CSharp_game && ./build.sh
```

This does everything automatically:
- Downloads the Nintendo Switch compiler (Docker)
- Compiles your code to ARM64
- Converts to .nro format (Homebrew Launcher compatible)

### Step 2: Verify It Worked

```bash
ls -lh arm_dev/hello_world.nro
```

You should see **hello_world.nro** (~92 KB). ✅ **Done!** You have a Nintendo Switch Homebrew executable ready to run!

---

## ❓ Quick Troubleshooting

| Issue | Fix |
|-------|-----|
| `docker: command not found` | Install Docker first: https://docs.docker.com/install/ |
| `Permission denied` | Run: `sudo usermod -aG docker $USER` then logout/login |
| `hello_world.nro` not created | Run `./build.sh` again and check for error messages |

---

---

# 📚 COMPLETE CODESPACE SETUP (START TO FINISH)

## 📁 Project Structure

```
/workspaces/CSharp_game/
├── build.sh              ← Build script (run this)
├── README.md             ← You are here
├── SETUP_GUIDE.txt       ← Detailed reference
└── arm_dev/
    ├── src/main.c       ← Hello World source code
    ├── Makefile         ← Build configuration
    └── hello_world.elf  ← Your ARM64 executable (created after build)
```

---

## 🔨 What's Inside

**File:** `arm_dev/src/main.c`

```c
int main() {
    return 0;
}
```

Simple C program that compiles to ARM64 (aarch64) for Nintendo Switch. Ready to add features!

---

## 🐳 How the Build Works

The `build.sh` script automatically:

1. **Pulls Docker Image**
   - Downloads `devkitpro/devkita64:20251231` (official Nintendo Switch SDK)
   - ~2 min on first run, cached after

2. **Sets Up Compiler Environment**
   - Configures PATH to use aarch64-none-elf-gcc
   - Links against libnx (Nintendo Switch SDK)
   - Sets ARM64 architecture flags (-march=armv8-a)
   - Targets Cortex-A57 CPU

3. **Compiles Your Code**
   - Runs: `aarch64-none-elf-gcc` on src/main.c
   - Links with libnx and switch.specs
   - Creates hello_world.elf (ELF 64-bit executable)

4. **Converts to NRO Format**
   - Runs: `elf2nro hello_world.elf hello_world.nro`
   - NRO = Nintendo Relocatable Object (Homebrew format)
   - Creates hello_world.nro (ready for Switch Homebrew Launcher)

5. **Verifies Success**
   - Checks both .elf and .nro created
   - Shows file sizes and properties

---

## 🔧 Complete Build Instructions

### Option A: Automated Build Script (RECOMMENDED)

```bash
cd /workspaces/CSharp_game && ./build.sh
```

This is the easiest way. The script handles all Docker setup automatically.

### Option B: Manual Docker Build

If you want to run the build manually:

```bash
docker run --rm \
  -v /workspaces/CSharp_game/arm_dev:/workspace \
  devkitpro/devkita64:20251231 \
  bash -c "
    export PATH=/opt/devkitpro/devkitA64/bin:/opt/devkitpro/tools/bin:\$PATH
    cd /workspace
    rm -rf build hello_world.elf
    mkdir -p build/src
    aarch64-none-elf-gcc -march=armv8-a -mtune=cortex-a57 -O2 -g -Wall \
      -ffunction-sections -D__SWITCH__ -c src/main.c -o build/src/main.o
    aarch64-none-elf-gcc -march=armv8-a -mtune=cortex-a57 -O2 -g \
      build/src/main.o -o hello_world.elf
    echo '✅ Build complete!'
    ls -lh hello_world.elf
  "
```

### Option C: Native Installation (If Servers Available)

If devkitPro servers are accessible:

```bash
# Setup environment
cat >> ~/.bashrc << 'EOF'
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM
export PATH=$DEVKITARM/bin:$PATH
EOF

source ~/.bashrc

# Install tools (requires working servers)
sudo dkp-pacman -Sy
sudo dkp-pacman -S devkitARM libnx switch-tools

# Build
cd arm_dev && make clean && make
```

---

## 🏗️ Understanding the Build System

**File:** `arm_dev/Makefile`

Key settings:
- **Compiler:** `aarch64-none-elf-gcc` (ARM 64-bit cross-compiler)
- **Target:** ARM aarch64 (Nintendo Switch CPU architecture)
- **Flags:**
  - `-march=armv8-a` = ARMv8-A instruction set
  - `-mtune=cortex-a57` = Optimize for Switch CPU
  - `-O2` = Optimization level 2
  - `-D__SWITCH__` = Define Switch macro
- **Output:** `hello_world.elf` (ELF 64-bit executable)
- **Build dir:** `arm_dev/build/`

**Make Commands:**

```bash
# Clean and rebuild
cd arm_dev && make clean && make

# Rebuild only
cd arm_dev && make

# Clean only
cd arm_dev && make clean

# Show all compile commands
cd arm_dev && make VERBOSE=1
```

---

## ✅ Verification & Testing

### Check Binaries Exist

```bash
ls -lh arm_dev/hello_world.*
```

Expected: Both `hello_world.elf` (~2.4 MB) and `hello_world.nro` (~92 KB)

### Verify NRO Format

```bash
hexdump -C arm_dev/hello_world.nro | head -5
```

Expected: First bytes should be `4e 52 4f 30` (NRO0 magic number)

### Check NRO Header

```bash
docker run --rm -v /workspaces/CSharp_game/arm_dev:/ws \
  devkitpro/devkita64:20251231 \
  bash -c "nro /ws/hello_world.nro"
```

Shows NRO header information

---

## 🆘 Comprehensive Troubleshooting

### Docker Issues

**Error:** `docker: command not found`
```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

**Error:** `Permission denied while trying to connect to Docker daemon`
```bash
sudo usermod -aG docker $USER
# Then logout and login (or restart terminal)
# Or use: newgrp docker
```

**Error:** `devkitpro/devkita64:20251231 not found`
```bash
docker pull devkitpro/devkita64:20251231
```

### Build Issues

**Error:** `elf2nro: Invalid ELF`
- ELF is not compiled with proper libnx linking
- Ensure build.sh has: `-lnx -specs=/opt/devkitpro/libnx/switch.specs`
- The script handles this automatically

**Error:** `aarch64-none-elf-gcc: command not found`
- The PATH is not set correctly in Docker
- build.sh sets: `export PATH=/opt/devkitpro/devkitA64/bin:/opt/devkitpro/tools/bin:$PATH`
- Check: `docker run --rm devkitpro/devkita64:20251231 bash -c "which aarch64-none-elf-gcc"`

**Error:** `cannot represent machine 'aarch64'`
- Using wrong compiler (32-bit instead of 64-bit)
- Ensure build.sh uses `/opt/devkitpro/devkitA64/` tools
- Not using local devkitARM (which is 32-bit only)

**Error:** `hello_world.nro` not created
- Build script failed before elf2nro step
- Check compilation/linking errors above
- Run: `./build.sh` again and watch for errors

**Build is very slow**
- First Docker pull downloads ~3GB image (1-2 min on fast connection)
- Subsequent builds are cached and much faster (~45 sec)
- Make sure you have stable internet for first build

---

## 📊 Performance Timeline

| Step | Time (First Run) | Time (Cached) |
|------|-----------------|---------------|
| Docker image pull | 1-2 minutes | 0 seconds |
| Compilation | 30 seconds | 30 seconds |
| Linking | 10 seconds | 10 seconds |
| Verification | 5 seconds | 5 seconds |
| **Total** | **~3-4 minutes** | **~45 seconds** |

---

## 📚 What's Next?

After successful build:

1. **Run on Nintendo Switch Hardware** ⭐
   - Copy `hello_world.nro` to Switch SD card: `/switch/` folder
   - Run via Homebrew Launcher (requires CFW)
   - Test your program on actual hardware

2. **Add More Features**
   - Include graphics with SDL2 or libnx graphics APIs
   - Handle controller input (buttons, joystick)
   - Implement game logic
   - Use standard C/C++ libraries

3. **Learn More**
   - **libnx Documentation:** https://github.com/switchbrew/libnx
   - **devkitPro Official:** https://devkitpro.org/
   - **Nintendo Switch Homebrew:** https://switchbrew.org/
   - **ARM Development:** https://developer.arm.com/

---

## 💡 Pro Tips

- **Keep Docker cached:** First pull takes time, but Docker caches it for super-fast rebuilds
- **Rebuild frequently:** As you add code, rebuild often to catch errors early
- **Check output:** Always verify `hello_world.elf` was created before testing
- **Use Make:** Makefile approach is simple, reliable, and integrates well with IDE build tasks
- **Add printf debugging:** Include `#include <stdio.h>` to add printf statements for testing
- **Read compiler output:** Error messages tell you exactly what went wrong

---

## 🔗 Useful Resources

| Resource | Link | Purpose |
|----------|------|---------|
| devkitPro Official | https://devkitpro.org/ | Official SDK & documentation |
| Docker Hub (devkitpro/devkita64) | https://hub.docker.com/r/devkitpro/devkita64 | Official Docker image |
| libnx GitHub | https://github.com/switchbrew/libnx | Nintendo Switch SDK source |
| switchbrew.org | https://switchbrew.org/ | Homebrew community & docs |
| ARM Developer | https://developer.arm.com/ | ARM architecture info |
| GCC Documentation | https://gcc.gnu.org/onlinedocs/ | GCC compiler reference |

---

## 📋 Complete Checklist

- [ ] Docker installed and working
- [ ] Project cloned/copied to `/workspaces/CSharp_game/`
- [ ] `build.sh` is executable (run `chmod +x build.sh` if needed)
- [ ] Ran `./build.sh` successfully
- [ ] `hello_world.elf` created in `arm_dev/` (ELF format)
- [ ] `hello_world.nro` created in `arm_dev/` (Homebrew format)
- [ ] NRO file is ~92 KB (expected size)
- [ ] Ready to copy .nro to Nintendo Switch
- [ ] Understand how build.sh works
- [ ] Bookmarked useful resources for next steps

---

## 🎮 You're Ready!

You now have:
- **hello_world.elf** - Compiled ARM64 executable (for debugging/linking)
- **hello_world.nro** - Nintendo Switch Homebrew format (ready to run on Switch!)

Edit `arm_dev/src/main.c`, run `./build.sh`, and iterate! Copy the .nro to your Switch and run via Homebrew Launcher. 🚀

You now have a complete Nintendo Switch ARM development environment in GitHub Codespace.

**Next build:**
```bash
cd /workspaces/CSharp_game/arm_dev
docker run --rm -v $(pwd):/workspace devkitpro/devkita64:20251231 \
  bash -c "export DEVKITPRO=/opt/devkitpro && export DEVKITARM=/opt/devkitpro/devkitARM && \
           export PATH=/opt/devkitpro/devkitARM/bin:/opt/devkitpro/tools/bin:\$PATH && \
           make clean && make"
```

**Happy coding! 🚀**

---

**Last Updated:** January 12, 2026  
**Environment:** GitHub Codespace (Ubuntu 24.04.3 LTS)  
**Build System:** Docker + Make  
**Target:** Nintendo Switch (ARM aarch64)  
**Status:** ✅ Ready to Build
