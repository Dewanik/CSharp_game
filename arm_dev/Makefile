#-------------------------------------------------------------------------------
# Nintendo Switch ARM Development Makefile
#-------------------------------------------------------------------------------

ifeq ($(strip $(DEVKITARM)),)
$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

TOPDIR ?= $(CURDIR)
include $(DEVKITARM)/base_rules

TARGET := $(notdir $(CURDIR))
BUILD := build
SOURCES := src
DATA := data
INCLUDES := include

ARCH := -march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIE

CFLAGS := -g -Wall -O2 -ffunction-sections \
	$(ARCH) $(DEFINES)

CFLAGS += $(INCLUDE) -D__SWITCH__

CXXFLAGS := $(CFLAGS) -fno-exceptions -fno-rtti

ASFLAGS := -g $(ARCH)

LDFLAGS = -specs=$(DEVKITARM)/../libnx/switch.specs -g $(ARCH) -Wl,-Map,$(notdir $*.map)

LIBS := -lnx

#-------------------------------------------------------------------------------
# List of all object files
#-------------------------------------------------------------------------------
OBJS := $(addsuffix .o,$(BINFILES)) \
	$(CPPFILES:.cpp=.o) \
	$(CFILES:.c=.o) \
	$(SFILES:.s=.o)

#-------------------------------------------------------------------------------
# Build targets
#-------------------------------------------------------------------------------
.PHONY: all clean

all: $(TARGET).elf

$(TARGET).elf: $(OBJS)

clean:
	@echo "Cleaning build directory..."
	@rm -rf $(BUILD) *.elf *.map

#-------------------------------------------------------------------------------
# Rules
#-------------------------------------------------------------------------------
define bin2o
	bin2s $< | $(AS) -o $(@)
endef

%.a:
	@echo $(notdir $@)
	@rm -f $@
	@for i in $^; do $(AR) -q $@ $$i; done

%.o: %.c
	@echo "Compiling $<..."
	@mkdir -p $(dir $@)
	@$(CC) -MMD -MP -MF $(addsuffix .d,$(basename $@)) $(CFLAGS) -c $< -o $@

%.o: %.cpp
	@echo "Compiling $<..."
	@mkdir -p $(dir $@)
	@$(CXX) -MMD -MP -MF $(addsuffix .d,$(basename $@)) $(CXXFLAGS) -c $< -o $@

%.elf:
	@echo "Linking $(notdir $@)..."
	@$(LD) $(LDFLAGS) $(OBJS) $(LIBS) -o $@
	@echo "Build complete: $(notdir $@)"

-include $(DEPENDS)
