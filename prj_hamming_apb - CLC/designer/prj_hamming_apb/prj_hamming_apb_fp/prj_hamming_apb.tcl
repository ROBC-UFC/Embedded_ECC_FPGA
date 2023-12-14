open_project -project {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\designer\prj_hamming_apb\prj_hamming_apb_fp\prj_hamming_apb.pro}
enable_device -name {M2S010} -enable 1
set_programming_file -name {M2S010} -file {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb - CLC\designer\prj_hamming_apb\prj_hamming_apb.ppd}
set_programming_action -action {PROGRAM} -name {M2S010} 
run_selected_actions
save_project
close_project
