import os

def alter(file,old_str,new_str):
  """
  replace string
  :param file
  :param old_str 
  :param new_str
  :return:
  """
  file_data = ""
  with open(file, "r", encoding="utf-8") as f:
    for line in f:
      if old_str in line:
        line = new_str
  #      line = line.replace(old_str,new_str)
      file_data += line
  with open(file,"w",encoding="utf-8") as f:
    f.write(file_data)

# fix parameters
test_widths = [8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096]

# FIFO
# Variable Parameters
funcs = ["fifo"]
file_path   = "./src/fifo/c_fifo.v"
elaborate_name = "c_fifo"
depend_file_path = ["./src/fifo/c_fifo_ctrl.v", "./src/fifo/c_dff.v", "./src/fifo/c_regfile.v", "./src/fifo/c_decr.v", "./src/fifo/c_incr.v"]

is_sequential = 1
if(is_sequential):
  tcl_path    = "./scripts/dc/dc_script.tcl"

  # Total three files need to be modified, including environment.tcl, sources_list.tcl and dc_script.tcl
  # Modify the environment.tcl
  alter("./configuration/environment.tcl", "set clock_name", 'set clock_name "clk"\n')

  # Modify the sources_list.tcl
  sourcelist_str_list = file_path + " "
  for i in range(len(depend_file_path)):
    sourcelist_str_list = sourcelist_str_list + depend_file_path[i] + " "
  alter("./configuration/sources_list.tcl", "analyze", "analyze -work $work_dir  -format verilog { " + sourcelist_str_list + "}\n")
  alter("./configuration/sources_list.tcl", "elaborate", "elaborate " + elaborate_name + "-work $work_dir\n")
  print("analyze -format verilog { " + sourcelist_str_list + "}\n")
  # Modify the dc_script.tcl
  alter(tcl_path, "set root_directory", "set root_directory     ./result/" + funcs[0] +"\n")

  for i in test_widths:
    os.system("mkdir -p ./result/" + funcs[0] + "/report")
    alter(file_path, "parameter depth =", "   parameter depth = " + str(i) + ";\n")
    os.system("dc_shell-t -f " + tcl_path)
    os.system("mv ./result/" + funcs[0] + "/report ./result/" + funcs[0] + "/report" + str(i))

else:
  tcl_path    = "./scripts/dc/dc_script_combination.tcl"

  # Total three files need to be modified, including environment.tcl, sources_list.tcl and dc_script.tcl
  # Modify the environment.tcl
  alter("./configuration/environment_combination.tcl", "set clock_name", 'set clock_name "clk"\n')

  # Modify the sources_list.tcl
  sourcelist_str_list = file_path + " "
  for i in range(len(depend_file_path)):
    sourcelist_str_list = sourcelist_str_list + depend_file_path[i] + " "
  alter("./configuration/sources_list_combination.tcl", "analyze", "analyze -format verilog { " + sourcelist_str_list + "}\n")
  alter("./configuration/sources_list_combination.tcl", "elaborate", "elaborate " + elaborate_name + "-work $work_dir\n")
  # Modify the dc_script.tcl
  alter(tcl_path, "set root_directory", "set root_directory     ./result/" + funcs[0] +"\n")

  for i in test_widths:
    os.system("mkdir -p ./result/" + funcs[0] + "/report")
    alter(file_path, "parameter depth =", "   parameter depth = " + str(i) + ";\n")
    os.system("dc_shell-t -f " + tcl_path)
    os.system("mv ./result/" + funcs[0] + "/report ./result/" + funcs[0] + "/report" + str(i))
