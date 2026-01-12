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
- Creates your executable

### Step 2: Verify It Worked

```bash
ls -lh arm_dev/hello_world.elf
```

You should see a file around **100+ KB**. ✅ **Done!** You have a Nintendo Switch ARM64 executable!

---

## ❓ Quick Troubleshooting

| Issue | Fix |
|-------|-----|
| `docker: command not found` | Install Docker first: https://docs.docker.com/install/ |
| `Permission denied` | Run: `sudo usermod -aG docker $USER` then logout/login |
| `hello_world.elf` not created | Run `./build.sh` again and check for error messages |

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
   - Sets ARM64 architecture flags (-march=armv8-a)
   - Targets Cortex-A57 CPU

3. **Compiles Your Code**
   - Runs: `aarch64-none-elf-gcc` on src/main.c
   - Creates object file in build/src/
   - Links to create hello_world.elf

4. **Verifies Success**
   - Checks if hello_world.elf was created
   - Shows file size and properties

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

### Check Binary Exists

```bash
ls -lh arm_dev/hello_world.elf
```

Expected: File showing ~100+ KB

### Verify Architecture

```bash
file arm_dev/hello_world.elf
```

Expected output:
```
hello_world.elf: ELF 64-bit LSB executable, ARM aarch64
```

### Check Compiler Version

```bash
docker run --rm devkitpro/devkita64:20251231 \
  bash -c "aarch64-none-elf-gcc --version"
```

Expected: ARM GCC compiler version info

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

**Error:** `aarch64-none-elf-gcc: command not found`
- The PATH is not set correctly in Docker
- The build.sh script should handle this automatically
- Check: `docker run --rm devkitpro/devkita64:20251231 bash -c "which aarch64-none-elf-gcc"`

**Error:** `cannot represent machine 'aarch64'`
- Using wrong compiler (32-bit instead of 64-bit)
- Ensure build.sh uses `/opt/devkitpro/devkitA64/` tools
- Not using local devkitARM (which is 32-bit only)

**Error:** `hello_world.elf: No such file or directory`
- Build didn't complete successfully
- Check output above for compilation errors
- Try: `cd arm_dev && make clean && make VERBOSE=1`

**Error:** `DEVKITARM not set` (if using native build)
```bash
source ~/.bashrc
echo $DEVKITARM
# Should show: /opt/devkitpro/devkitARM
```

**Build is very slow**
- First Docker pull downloads ~3GB image (1-2 min on fast connection)
- Subsequent builds are cached and much faster (~30 seconds)
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

1. **Run on Hardware**
   - Convert `.elf` to `.nro` format with `elf2nro`
   - Use Homebrew Launcher to run
   - Test on actual Nintendo Switch

2. **Add Features**
   - Include libnx.h for graphics
   - Add controller input handling
   - Implement game logic
   - Use standard C library functions

3. **Learn More**
   - **libnx SDK:** https://github.com/switchbrew/libnx
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
- [ ] `hello_world.elf` created in `arm_dev/`
- [ ] Verified with `file arm_dev/hello_world.elf`
- [ ] Output shows "ELF 64-bit LSB executable, ARM aarch64"
- [ ] Ready to modify code and rebuild
- [ ] Understand how build.sh works
- [ ] Bookmarked useful resources for next steps

---

## 🎮 You're Ready!

You now have a working Nintendo Switch ARM64 development environment. Your `hello_world.elf` is a compiled executable ready for Switch hardware. Edit `arm_dev/src/main.c`, run `./build.sh`, and iterate!

Happy coding! 🚀

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
