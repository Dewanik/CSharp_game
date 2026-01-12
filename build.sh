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
    
    cd /workspace
    
    echo '📦 Cleaning...'
    rm -rf build hello_world.elf hello_world.map 2>/dev/null
    mkdir -p build/src
    
    echo '🔧 Compiling src/main.c...'
    aarch64-none-elf-gcc \
      -march=armv8-a \
      -mtune=cortex-a57 \
      -O2 -g -Wall \
      -ffunction-sections \
      -D__SWITCH__ \
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
      -O2 -g \
      -Wl,-Map,hello_world.map \
      build/src/main.o \
      -o hello_world.elf
    
    if [ -f hello_world.elf ]; then
        echo
        echo '✅ BUILD SUCCESSFUL!'
        echo
        file hello_world.elf
        ls -lh hello_world.elf
    else
        echo '❌ BUILD FAILED!'
        exit 1
    fi
  "

EXIT_CODE=$?

echo
if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ Binary ready: $BUILD_DIR/hello_world.elf"
else
    echo "❌ Build failed. Check errors above."
fi

exit $EXIT_CODE
