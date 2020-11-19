# AreaPower
The repo implement area and power estimation using synopsys design compiler

# Sequential Circuit
By default, input data is 16-bit length.
- tree.          Only need to sweep parameter `NUM` to change input size, accpetable range is (0,4096)
- bus_singlebroadcast. Only need to sweep parameter `NUM_PES` to change input size, accpetable range is (0,4096)
- fifo.          Only need to sweep parameter `depth` , accpetable range is (0,4096)
- linear_dist.   Only need to sweep parameter `NUM_PES` to change input size, accpetable range is (0,4096)

Sweep scripts are also offered. Run the following to sweep parameters in synthesis, results are located in report directory with subdirectory name as <top_module><size>.
```
make py_sweep_<func>.
<func> = "tree" or "fifo" or "bus_singlebroadcast" or "linear"
```



# Combinational Circuit
By default, input data is 16-bit length.
- Crossbar. `num_in_ports` & `num_out_ports` should be sweeped. parameter larger than 512 will not be able to be synthesized by Cadence.

Sweep scripts are also offered. Run the following to sweep parameters in synthesis, results are located in report directory with subdirectory name as <top_module><size>.
```
make py_sweep_xbar.
```

