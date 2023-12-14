set_device -family {SmartFusion2} -die {M2S010} -speed {STD}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\component\Actel\DirectCore\CoreResetP\7.1.100\rtl\vlog\core\coreresetp_pcie_hotreset.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\component\Actel\DirectCore\CoreResetP\7.1.100\rtl\vlog\core\coreresetp.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\component\work\led_blink_mss2_sb\CCC_0\led_blink_mss2_sb_CCC_0_FCCC.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\component\work\led_blink_mss2_sb\FABOSC_0\led_blink_mss2_sb_FABOSC_0_OSC.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\component\work\led_blink_mss2_sb_MSS\led_blink_mss2_sb_MSS.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\component\work\led_blink_mss2_sb\led_blink_mss2_sb.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\hdl\not_test.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\component\work\led_blink_mss2\led_blink_mss2.v}
set_top_level {led_blink_mss2}
map_netlist
check_constraints {C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\constraint\synthesis_sdc_errors.log}
write_fdc {C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\designer\led_blink_mss2\synthesis.fdc}
