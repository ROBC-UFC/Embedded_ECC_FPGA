set_component prj_hamming_apb_sb_CCC_0_FCCC
# Microsemi Corp.
# Date: 2023-Dec-12 12:25:32
#

create_clock -period 20 [ get_pins { CCC_INST/RCOSC_25_50MHZ } ]
create_generated_clock -multiply_by 2 -divide_by 4 -source [ get_pins { CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
