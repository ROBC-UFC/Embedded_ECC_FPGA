new_project \
         -name {led_blink_mss2} \
         -location {C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\designer\led_blink_mss2\led_blink_mss2_fp} \
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
