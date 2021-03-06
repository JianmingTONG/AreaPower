import os

def alter(file,old_str,new_str):
  """
  替换文件中的字符串
  :param file:文件名
  :param old_str:就字符串
  :param new_str:新字符串
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

# ADDER TREE 
# specify the top module name
top_module = ["tree"]

# a) change variable.tcl
alter("./variables.tcl", "set project ", 'set project "' + top_module[0] + '"\n')

# b) change file_list.tcl;
# add all verilog files in { }.
alter("./file_list.tcl", "analyze", "analyze -format sverilog {../src/tree.v}\n")

# c) set all sweeped parameter. 
# only modify parameters in need of change without list all parameters 
parameter_value = [4, 8]
parameter_name = ["NUM"]

# d) create report directory.
# os.system("mkdir ./report") 
# os.system("mkdir ./pnr_report")

# sweep params
for i in range(len(parameter_value)):
  # a) change the parameter
  param_list = parameter_name[0] + "= "+ str(parameter_value[i])
  print('elaborate -parameter "' + param_list + '" ' + top_module[0])
  alter("./file_list.tcl","elaborate", 'elaborate -parameter "' + param_list + '" ' + top_module[0] +"\n")
  
  # b) start synthesis
  os.system("make synth")
  
  # d) start pnr
  os.system("make pnr")

  # c) move report to the report directory
  os.system("mv ./SYNTH/rpt " + "./report/" + top_module[0] + str(parameter_value[i]))


  # e) move report of pnr into /pnr_report
  os.system("mv ./PNR " + "./pnr_report/" + top_module[0] + str(parameter_value[i]))
