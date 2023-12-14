new_project \
         -name {prj_hamming_apb} \
         -location {C:\Users\Lesc\Documents\LiberoProjects\prj_hamming_apb\designer\prj_hamming_apb\prj_hamming_apb_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {M2S010} \
         -name {M2S010}
enable_device \
         -name {M2S010} \
         -enable {TRUE}
save_project
close_project
