#!/bin/bash
#
# Docker-based build script for Nintendo Switch Hello World
# Uses devkitpro/devkita64 for ARM64 environment
#

echo "🔨 Building Nintendo Switch Hello World..."
echo

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$SCRIPT_DIR/arm_dev"

docker run --rm \
  -v "$BUILD_DIR":/workspace \
  devkitpro/devkita64:20251231 \
  bash -c "
    export PATH=/opt/devkitpro/devkitA64/bin:/opt/devkitpro/tools/bin:\$PATH
    export DEVKITPRO=/opt/devkitpro
    
    cd /workspace
    
    echo '📦 Cleaning...'
    rm -rf build hello_world.elf hello_world.nro hello_world.map 2>/dev/null
    mkdir -p build/src
    
    echo '🔧 Compiling src/main.c...'
    aarch64-none-elf-gcc \
      -march=armv8-a \
      -mtune=cortex-a57 \
      -mtp=soft \
      -fPIE \
      -O2 -g -Wall \
      -ffunction-sections \
      -D__SWITCH__ \
      -fno-strict-aliasing \
      -I/opt/devkitpro/libnx/include \
      -I/opt/devkitpro/portlibs/aarch64-none-elf/include \
      -c src/main.c \
      -o build/src/main.o
    
    if [ \$? -ne 0 ]; then
      echo '❌ Compilation failed!'
      exit 1
    fi
    
    echo 'Linking hello_world.elf...'
    aarch64-none-elf-gcc \
      -march=armv8-a \
      -mtune=cortex-a57 \
      -mtp=soft \
      -fPIE \
      -O2 -g \
      -Wl,-Map,hello_world.map \
      -L/opt/devkitpro/libnx/lib \
      -L/opt/devkitpro/portlibs/aarch64-none-elf/lib \
      build/src/main.o \
      -lnx \
      -specs=/opt/devkitpro/libnx/switch.specs \
      -o hello_world.elf
    
    if [ -f hello_world.elf ]; then
        echo '✅ ELF build successful!'
        echo
        
        echo '🔄 Converting to NRO format...'
        elf2nro hello_world.elf hello_world.nro
        
        if [ -f hello_world.nro ]; then
            echo '✅ NRO conversion successful!'
            echo
            echo '📊 Final binaries:'
            file hello_world.elf
            file hello_world.nro
            echo
            ls -lh hello_world.elf hello_world.nro
        else
            echo '❌ NRO conversion failed!'
            exit 1
        fi
    else
        echo '❌ BUILD FAILED!'
        exit 1
    fi
  "

EXIT_CODE=$?

echo
if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ Binaries ready:"
    echo "   ELF:  $BUILD_DIR/hello_world.elf (for debugging)"
    echo "   NRO:  $BUILD_DIR/hello_world.nro (for Nintendo Switch Homebrew Launcher)"
else
    echo "❌ Build failed. Check errors above."
fi

exit $EXIT_CODE
