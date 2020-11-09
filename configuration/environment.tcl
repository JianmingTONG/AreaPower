# ====================================================================================
# 1. Specify the clock signal name
set clock_name "clk"


# ====================================================================================
# 2. Specify the target library
# set current_library "Synopsys_28nm"
# set current_library "NanGate" 

# Two optioins are available -- activate only one
# To use Synopsys 28nm, you need to have access to it. please refer to https://eulas.ece.gatech.edu or contact ECE help (help@ece.gatech.edu)


# ====================================================================================
# 3. Set the target clock period
# 
# For Synopsys library, the unit of clock period is ns.
# Therefore  1 ns => 1 GHz
set clock_period 2.5
set_units -time ns

# For NanGate library, the unit of clock period is ps.
# Therefore, 1000 ps = 1 ns => 1 GHz clock
# set clock_period 1000
# set_units -time ps
# set_units -capacitance ff


# ====================================================================================
# 4. Setup IO Delay
set io_delay 0.025
