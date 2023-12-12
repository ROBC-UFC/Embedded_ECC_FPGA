################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include firmware/hal/CortexM3/GNU/subdir.mk
-include firmware/hal/CortexM3/subdir.mk
-include firmware/drivers_config/sys_config/subdir.mk
-include firmware/drivers/mss_sys_services/subdir.mk
-include firmware/drivers/mss_nvm/subdir.mk
-include firmware/drivers/mss_hpdma/subdir.mk
-include firmware/drivers/mss_gpio/subdir.mk
-include firmware/CMSIS/startup_gcc/subdir.mk
-include firmware/CMSIS/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
SECONDARY_FLASH += \
test_github.hex \

SECONDARY_LIST += \
test_github.lst \

SECONDARY_SIZE += \
test_github.siz \


# All Target
all: test_github.elf secondary-outputs

# Tool invocations
test_github.elf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GNU ARM Cross C Linker'
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -O0 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g3 -T "C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\firmware\CMSIS\startup_gcc\debug-in-microsemi-smartfusion2-esram.ld" -Xlinker --gc-sections -Wl,-Map,"test_github.map" --specs=nano.specs -o "test_github.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

test_github.hex: test_github.elf
	@echo 'Invoking: GNU ARM Cross Create Flash Image'
	arm-none-eabi-objcopy -O ihex "test_github.elf"  "test_github.hex"
	@echo 'Finished building: $@'
	@echo ' '

test_github.lst: test_github.elf
	@echo 'Invoking: GNU ARM Cross Create Listing'
	arm-none-eabi-objdump --source --all-headers --demangle --line-numbers --wide "test_github.elf" > "test_github.lst"
	@echo 'Finished building: $@'
	@echo ' '

test_github.siz: test_github.elf
	@echo 'Invoking: GNU ARM Cross Print Size'
	arm-none-eabi-size --format=berkeley "test_github.elf"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS)$(SECONDARY_FLASH)$(SECONDARY_LIST)$(SECONDARY_SIZE)$(ASM_DEPS)$(S_UPPER_DEPS)$(C_DEPS) test_github.elf
	-@echo ' '

secondary-outputs: $(SECONDARY_FLASH) $(SECONDARY_LIST) $(SECONDARY_SIZE)

.PHONY: all clean dependents

-include ../makefile.targets
