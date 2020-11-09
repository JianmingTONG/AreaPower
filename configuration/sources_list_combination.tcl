# 1. Put all your source files into ./src/ directory.
# 2. List all the files your design uses below.

# First file on the list should be the top module.
# For example, 
#   top module: ./src/topModule.v
#   submodules: ./src/sub1.v ./src/sub2.v src/subdir/sub3.v
# Then, you should write
#   read_file -format verilog { ./src/topModule.v ./src/sub1.v ./src/sub2.v ./src/subdir/sub3.v } 
# =========================================================================
set work_dir work
analyze -work $work_dir -format verilog { ./src/crossbar/c_crossbar.v ./src/crossbar/c_interleave.v ./src/crossbar/c_select_1ofn.v }
elaborate c_crossbar -architecture verilog -library DEFAULT -work $work_dir
