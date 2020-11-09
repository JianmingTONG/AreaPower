# 1. Put all your source files into ./src/ directory.
# 2. List all the files your design uses below.

# First file on the list should be the top module.
# For example, 
#   top module: ./src/topModule.v
#   submodules: ./src/sub1.v ./src/sub2.v src/subdir/sub3.v
# Then, you should write
# read_file -format verilog {./src/topModule.v ./src/sub1.v ./src/sub2.v src/subdir/sub3.v}
# =========================================================================
set work_dir work
analyze -work $work_dir  -format verilog { ./src/fifo/c_fifo.v ./src/fifo/c_fifo_ctrl.v ./src/fifo/c_dff.v ./src/fifo/c_regfile.v ./src/fifo/c_decr.v ./src/fifo/c_incr.v }
elaborate c_fifo -work $work_dir