# [DC_SCRIPT] Load and setup environment
#source ./configuration/environment.tcl

set root_directory     ./result/crossbar
set report_path $root_directory/report
set build_path "./build"

# [User Script] to preserve FF from being removed by DC, apply the below command
#set hdlin_preserve_sequential true


# [DC_SCRIPT] Multicore setting
# [DC_SCRIPT] 15 is the maximum availalbe number of cores in DC
set_host_options -max_cores 15

# [DC_SCRIPT] Load source files
source ./configuration/sources_list_combination.tcl

# [DC_SCRIPT] Link
link
uniquify


# [DC_SCRIPT] Timing Check
#source ./scripts/dc/dc_timing.sdc
set_input_delay 1.0 -clock $clock_name [all_inputs]
set_output_delay 0.5 -clock $clock_name [all_outputs]
set_load 0.1 [all_outputs]
set_max_fanout 2 [all_inputs ]
set_fanout_load  8 [all_outputs ]

set_wire_load_mode top
set auto_wire_load_selection true

report_port

check_design
update_timing

# [DC_SCRIPT] Compile
compile -map_effort medium 
# compile_ultra -timing_high_effort_script -no_autoungroup

change_names -rules verilog -hierarchy -verbose
write -format verilog -hierarchy -output $build_path/results_synthesized.v
write_sdc $build_path/results_synthesized.sdc

# [DC_SCRIPT] Write Timing, Area and Power Reports
report_timing -nworst 50 \
              -max_paths 50 \
              -path full \
              -delay max \
              -significant_digits 3 \
              -sort_by slack \
              > $report_path/timing_max.rpt
report_timing -nworst 50 \
              -max_paths 50 \
              -path full \
              -delay min \
              -significant_digits 3 \
              -sort_by slack \
              > $report_path/timing_min.rpt
report_timing > $report_path/timing.rpt
report_timing_derate > $report_path/timing_derate.rpt
report_area -hierarchy > $report_path/area.rpt
report_power -hier > $report_path/power.rpt
report_power > $report_path/power_no_hier.rpt
report_net -cell_degradation > $report_path/net.rpt
report_clock_gating > $report_path/clock_gating.rpt

# [DC_SCRIPT] Save synthesis state
write -hierarchy -format ddc -output $build_path/synthesis.ddc

# [DC_SCRIPT] Done
quit
