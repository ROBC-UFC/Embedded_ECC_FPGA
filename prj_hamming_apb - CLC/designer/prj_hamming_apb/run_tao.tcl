set_device -family {SmartFusion2} -die {M2S010} -speed {STD}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\hdl\decodificador.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\hdl\Decoder_ip.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\hdl\codificador.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\hdl\adder_ip.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\component\Actel\DirectCore\CoreResetP\7.1.100\rtl\vlog\core\coreresetp_pcie_hotreset.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\component\Actel\DirectCore\CoreResetP\7.1.100\rtl\vlog\core\coreresetp.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\component\work\prj_hamming_apb_sb\CCC_0\prj_hamming_apb_sb_CCC_0_FCCC.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\component\work\prj_hamming_apb_sb\FABOSC_0\prj_hamming_apb_sb_FABOSC_0_OSC.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\component\work\prj_hamming_apb_sb_MSS\prj_hamming_apb_sb_MSS.v}
read_verilog -mode system_verilog -lib COREAPB3_LIB {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\component\Actel\DirectCore\CoreAPB3\4.1.100\rtl\vlog\core\coreapb3_muxptob3.v}
read_verilog -mode system_verilog -lib COREAPB3_LIB {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\component\Actel\DirectCore\CoreAPB3\4.1.100\rtl\vlog\core\coreapb3_iaddr_reg.v}
read_verilog -mode system_verilog -lib COREAPB3_LIB {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\component\Actel\DirectCore\CoreAPB3\4.1.100\rtl\vlog\core\coreapb3.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\component\work\prj_hamming_apb_sb\prj_hamming_apb_sb.v}
read_verilog -mode system_verilog {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\component\work\prj_hamming_apb\prj_hamming_apb.v}
set_top_level {prj_hamming_apb}
map_netlist
check_constraints {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\constraint\synthesis_sdc_errors.log}
write_fdc {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\designer\prj_hamming_apb\synthesis.fdc}
