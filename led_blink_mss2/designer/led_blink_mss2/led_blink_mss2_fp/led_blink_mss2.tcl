open_project -project {C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\designer\led_blink_mss2\led_blink_mss2_fp\led_blink_mss2.pro}
enable_device -name {M2S010} -enable 1
set_programming_file -name {M2S010} -file {C:\Users\Lesc\Documents\LiberoProjects\led_blink_mss2\designer\led_blink_mss2\led_blink_mss2.ppd}
set_programming_action -action {PROGRAM} -name {M2S010} 
run_selected_actions
save_project
close_project
