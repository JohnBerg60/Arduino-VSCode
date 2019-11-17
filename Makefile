# Basic Makefile
#
# path to gcc:
# D:/Dev-Tools/arm-gcc-8/bin
#

FAMILY = STM32F1xx
BOARD = BLUEPILL_F103C8
# sets the variant
BOARD_NAME = PILL_F103XX
PROC = STM32F103xB
STARTUP = stm32f100xb
ARM = cortex-m3

OBJDIR = obj
BINDIR = bin
SRCDIR = src

BASE = D:/Dev-Tools/Arduino_Core_STM32
CORE = $(BASE)/cores
ARDUINO = $(CORE)/arduino
VARIANT = $(BASE)/variants/$(BOARD_NAME)
HALBASE = $(BASE)/system/Drivers/$(FAMILY)_HAL_Driver
CMSIS = D:/Dev-Tools/CMSIS_5/CMSIS/Core/Include

CXX = arm-none-eabi-g++
CXXFLAGS = -c -g -Os -mcpu=$(ARM) -std=gnu++14
CXXFLAGS += -ffunction-sections -fdata-sections -nostdlib -fno-threadsafe-statics --param max-inline-insns-single=500 
CXXFLAGS += -fno-rtti -fno-exceptions -fno-use-cxa-atexit -MMD

CC = arm-none-eabi-gcc
CCFLAGS = -c -g -Os -std=gnu11 -mcpu=$(ARM)
CCFLAGS += -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -MMD

LD = arm-none-eabi-gcc
LDFLAGS = -mcpu=$(ARM) -mthumb -Os --specs=nano.specs -specs=nosys.specs 
LDFLAGS += -larm_cortexM3l_math -lm -lgcc -lstdc++
LDFLAGS += -Wl,--defsym=LD_FLASH_OFFSET=0 -Wl,--defsym=LD_MAX_SIZE=131072 -Wl,--defsym=LD_MAX_DATA_SIZE=20480 
LDFLAGS += -Wl,--cref -Wl,--check-sections -Wl,--gc-sections -Wl,--entry=Reset_Handler -Wl,--unresolved-symbols=report-all -Wl,--warn-common 
LDFLAGS += -T$(VARIANT)/ldscript.ld
LDFLAGS += -LD:/Dev-Tools/CMSIS_5/CMSIS/DSP/Lib/GCC 
LDFLAGS += "-Wl,-Map,bin/firmware.map" 
LDFLAGS += -Wl,--start-group -Wl,--whole-archive -Wl,--no-whole-archive -lc -Wl,--end-group 
#LDFLAGS += -Wl,--verbose

SIZE = arm-none-eabi-size
OBJCOPY = arm-none-eabi-objcopy

SRCS = $(shell find $(CORE) -name "*.c")
OBJS = $(patsubst $(CORE)/%.c, $(OBJDIR)/%.o, $(SRCS))

CPPSRCS = $(shell find $(CORE) -name "*.cpp")
CPPOBJS = $(patsubst $(CORE)/%.cpp, $(OBJDIR)/%.o, $(CPPSRCS))

HALSRCS = $(shell find $(HALBASE)/Src -name *.c ! -path *template*)
HALOBJS = $(patsubst $(HALBASE)/Src/%.c, $(OBJDIR)/hal/%.o, $(HALSRCS))

VARSRCS = $(wildcard $(VARIANT)/*.c)
VAROBJS = $(patsubst $(VARIANT)/%.c, $(OBJDIR)/variant/%.o, $(VARSRCS))

VARCPPSRCS = $(wildcard $(VARIANT)/*.cpp)
VARCPPOBJS = $(patsubst $(VARIANT)/%.cpp, $(OBJDIR)/variant/%.o, $(VARCPPSRCS))

SOURCES = $(wildcard $(SRCDIR)/*.cpp)
CPPUSEROBJS = $(patsubst $(SRCDIR)/%.cpp, $(OBJDIR)/%.o, $(SOURCES))

startup = startup_$(shell echo $(PROC) | tr '[:upper:]' '[:lower:]')
ASMSRC = $(BASE)/system/Drivers/CMSIS/Device/ST/$(FAMILY)/Source/Templates/gcc/$(startup).s
ASMOBJ = $(OBJDIR)/$(startup).o

INC = \
-I$(ARDUINO) \
-I$(ARDUINO)/stm32 \
-I$(ARDUINO)/stm32\LL \
-I$(ARDUINO)/stm32\usb \
-I$(BASE)/system/Drivers/CMSIS/Device/ST/$(FAMILY)/Include \
-I$(BASE)/system/Drivers/CMSIS/Include \
-I$(HALBASE)/Inc \
-I$(BASE)/system/$(FAMILY) \
-I$(VARIANT) \
-I$(CMSIS)

DEFINES = \
-D$(FAMILY) \
-DARDUINO=10810 \
-DARDUINO_$(BOARD)  \
-DARDUINO_ARCH_STM32 \
-DBOARD_NAME=$(BOARD) \
-D$(PROC) \
-DHAL_UART_MODULE_ENABLED


# linking
$(BINDIR)/firmware.elf:  $(ASMOBJ) $(VAROBJS) $(VARCPPOBJS) $(OBJS) $(CPPOBJS) $(HALOBJS) $(CPPUSEROBJS) 
	@test -d $(BINDIR) || mkdir -p $(BINDIR)
	$(LD) $(LDFLAGS) -o $@ $(ASMOBJ) $(VAROBJS) $(VARCPPOBJS) $(OBJS) $(CPPOBJS) $(HALOBJS) $(CPPUSEROBJS)
	$(OBJCOPY) -O binary $@ $(BINDIR)/firmware.bin
	$(OBJCOPY) -O ihex $@ $(BINDIR)/firmware.hex
	$(SIZE) -B $@

$(ASMOBJ) : $(ASMSRC)
	@test -d $(dir $@) || mkdir -p $(dir $@)
	$(CC) $(CCFLAGS) $(DEFINES) $(INC) -o $@ $<
	@echo -e "\n"

$(VAROBJS):
	$(eval SOURCE := $(patsubst $(OBJDIR)/variant/%.o, $(VARIANT)/%.c, $@))
	@test -d $(dir $@) || mkdir -p $(dir $@)
	$(CC) $(CCFLAGS) $(DEFINES) $(INC) -o $@ $(SOURCE)
	@echo -e "\n"

$(HALOBJS):
	$(eval SOURCE := $(patsubst $(OBJDIR)/hal/%.o, $(HALBASE)/Src/%.c, $@))
	@test -d $(dir $@) || mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(DEFINES) $(INC) -o $@ $(SOURCE)
	@echo -e "\n"

$(VARCPPOBJS):
	$(eval SOURCE := $(patsubst $(OBJDIR)/variant/%.o, $(VARIANT)/%.cpp, $@))
	@test -d $(dir $@) || mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(DEFINES) $(INC) -o $@ $(SOURCE)
	@echo -e "\n"

$(OBJS):
	$(eval SOURCE := $(patsubst $(OBJDIR)/%.o, $(CORE)/%.c, $@))
	@test -d $(dir $@) || mkdir -p $(dir $@)
	$(CC) $(CCFLAGS) $(DEFINES) $(INC) -o $@ $(SOURCE)
	@echo -e "\n"


$(CPPOBJS):
	$(eval SOURCE := $(patsubst $(OBJDIR)/%.o, $(CORE)/%.cpp, $@))
	@test -d $(dir $@) || mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(DEFINES) $(INC) -o $@ $(SOURCE)
	@echo -e "\n"

$(CPPUSEROBJS): $(OBJDIR)/%.o : $(SRCDIR)/%.cpp
	echo $@ $<
	@test -d $(dir $@) || mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(DEFINES) $(INC) -o $@ $<
	@echo -e "\n"


.PHONY: clean debug
clean:
	rm -fR $(OBJDIR)
	rm -fR $(BINDIR)

debug:
	@echo User: $(startup)
