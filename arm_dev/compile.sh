#!/bin/bash
# Direct compilation script for Hello World
# Run this after setting up devkitPro

set -e

echo "Nintendo Switch ARM - Hello World Compilation"
echo "=============================================="
echo ""

# Check environment
if [ -z "$DEVKITARM" ]; then
    echo "ERROR: DEVKITARM not set!"
    echo "Run: export DEVKITARM=/opt/devkitpro/devkitARM"
    exit 1
fi

echo "✓ Using DEVKITARM=$DEVKITARM"

# Create build directory
mkdir -p build

# Step 1: Compile C source to object file
echo ""
echo "Step 1: Compiling source code..."
$DEVKITARM/bin/arm-none-eabi-gcc \
    -march=armv8-a \
    -mtune=cortex-a57 \
    -mtp=soft \
    -fPIE \
    -D__SWITCH__ \
    -I$DEVKITPRO/libnx/include \
    -g -Wall -O2 \
    -c src/main.c -o build/main.o

echo "✓ Compiled: build/main.o"

# Step 2: Link object file to executable
echo ""
echo "Step 2: Linking..."
$DEVKITARM/bin/arm-none-eabi-gcc \
    -march=armv8-a \
    -mtune=cortex-a57 \
    -mtp=soft \
    -fPIE \
    -L$DEVKITPRO/libnx/lib \
    -specs=$DEVKITPRO/libnx/switch.specs \
    build/main.o \
    -lnx \
    -o build/hello_world.elf

echo "✓ Linked: build/hello_world.elf"

# Step 3: Verify
echo ""
echo "Step 3: Verifying binary..."
if file build/hello_world.elf | grep -q "ELF 64-bit"; then
    echo "✓ Binary verified as ARM64 ELF"
else
    echo "⚠ Warning: Binary might not be correct format"
    file build/hello_world.elf
fi

echo ""
echo "=============================================="
echo "BUILD SUCCESSFUL!"
echo "=============================================="
echo ""
echo "Output: build/hello_world.elf"
echo ""
echo "To examine the binary:"
echo "  file build/hello_world.elf"
echo "  arm-none-eabi-objdump -d build/hello_world.elf | head -50"
echo ""
