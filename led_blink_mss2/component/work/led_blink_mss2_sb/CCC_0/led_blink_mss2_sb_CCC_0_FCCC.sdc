set_component led_blink_mss2_sb_CCC_0_FCCC
# Microsemi Corp.
# Date: 2023-Dec-04 18:36:30
#

create_clock -period 20 [ get_pins { CCC_INST/RCOSC_25_50MHZ } ]
create_generated_clock -multiply_by 4 -divide_by 2 -source [ get_pins { CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
