#-------------------------------------------------------------------------------
# Simple Nintendo Switch Hello World Makefile
#-------------------------------------------------------------------------------

ifeq ($(strip $(DEVKITARM)),)
$(error "DEVKITARM not set. Please set DEVKITARM environment variable")
endif

TARGET := hello_world
BUILD := build
SOURCES := src
INCLUDE := include

ARCH := -march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIE

CFLAGS := -g -Wall -O2 -ffunction-sections $(ARCH) -D__SWITCH__ -fno-strict-aliasing
CXXFLAGS := $(CFLAGS) -fno-exceptions -fno-rtti
ASFLAGS := -g $(ARCH)

LIBS := -lnx
LIBDIRS := -L$(DEVKITPRO)/libnx/lib -L$(DEVKITPRO)/portlibs/switch/lib
LDFLAGS := -g $(ARCH) -specs=$(DEVKITPRO)/libnx/switch.specs $(LIBDIRS) $(LIBS) -Wl,-Map,$(TARGET).map

INCDIRS := -I$(DEVKITPRO)/libnx/include -I$(DEVKITPRO)/portlibs/switch/include

SOURCES_C := $(wildcard $(SOURCES)/*.c)
OBJS := $(patsubst %.c,$(BUILD)/%.o,$(SOURCES_C))

.PHONY: all clean

all: $(TARGET).elf

$(BUILD):
	@mkdir -p $@/src

$(BUILD)/%.o: %.c | $(BUILD)
	@echo "Compiling $<..."
	@arm-none-eabi-gcc $(CFLAGS) $(INCDIRS) -c $< -o $@

$(TARGET).elf: $(OBJS)
	@echo "Linking $@..."
	@arm-none-eabi-gcc -o $@ $^ $(LDFLAGS)
	@echo "Build complete: $@"
	@file $@

clean:
	@echo "Cleaning..."
	@rm -rf $(BUILD) $(TARGET).elf $(TARGET).map
	@echo "Clean complete"
