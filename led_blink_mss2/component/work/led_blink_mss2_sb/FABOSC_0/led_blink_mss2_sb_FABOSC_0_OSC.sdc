set_component led_blink_mss2_sb_FABOSC_0_OSC
# Microsemi Corp.
# Date: 2023-Dec-04 18:36:32
#

create_clock -ignore_errors -period 20 [ get_pins { I_RCOSC_25_50MHZ/CLKOUT } ]
