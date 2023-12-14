set_component led_blink_mss2_sb_MSS
# Microsemi Corp.
# Date: 2023-Dec-04 18:36:27
#

create_clock -period 40 [ get_pins { MSS_ADLIB_INST/CLK_CONFIG_APB } ]
set_false_path -ignore_errors -through [ get_pins { MSS_ADLIB_INST/CONFIG_PRESET_N } ]
