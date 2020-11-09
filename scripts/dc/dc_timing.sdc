# -------------------------------------------------------------------------
# ---------------------- constraints file ---------------------------------
# -------------------------------------------------------------------------

# This file contains various constraints for your chip including the
# target clock period, fanout, transition time and any
# input/output delay constraints.

# set clock period
create_clock -period $clock_period -name $clock_name [get_ports $clock_name]

# set clock jitter [%]
set_clock_uncertainty -setup 0.2 [get_clocks $clock_name]
set_clock_uncertainty -hold  0.2 [get_clocks $clock_name]

# set input and output delay [unit: follows the clock time unit]
set_input_delay  $io_delay -clock $clock_name [remove_from_collection [all_inputs] $clock_name]
set_output_delay $io_delay -clock $clock_name [all_outputs]

# set output capacitive load [fF]
set_load 15 [all_outputs]
