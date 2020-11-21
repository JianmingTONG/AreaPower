#include ../Makefile.include

SCRIPT_DIR=./scripts

all: flow

flow: clean synth pnr

py_sweep_tree:
	python3 ./scripts/synth_wrapper/run_dc_tree.py

py_sweep_fifo:
	python3 ./scripts/synth_wrapper/run_dc_fifo.py

py_sweep_bus:
	python3 ./scripts/synth_wrapper/run_dc_bus.py

py_sweep_xbar:
	python3 ./scripts/synth_wrapper/run_dc_xbar.py

py_sweep_linear:
	python3 ./scripts/synth_wrapper/run_dc_linear.py

py_sweep_multiplexer:
	python3 ./scripts/synth_wrapper/run_dc_multiplexer.py

py_sweep_bus_singlebroadcast:
	python3 ./scripts/synth_wrapper/run_dc_bus_singlebroadcast.py

pnr_sweep_tree: clean
	python3 ./scripts/pnr_wrapper/run_pnr_tree.py

pnr_sweep_fifo:
	python3 ./scripts/pnr_wrapper/run_pnr_fifo.py

pnr_sweep_xbar:
	python3 ./scripts/pnr_wrapper/run_pnr_xbar.py

pnr_sweep_linear:
	python3 ./scripts/pnr_wrapper/run_pnr_linear.py

pnr_sweep_bus_singlebroadcast:
	python3 ./scripts/pnr_wrapper/run_pnr_bus_singlebroadcast.py

synth:
	mkdir -p SYNTH/rpt
	cd SYNTH ; dc_shell -f ../scripts/dc/dc_script.tcl -o synth.log
	
pnr:
	mkdir PNR
	cd PNR ; innovus -64 -init ../scripts/innovus/pnr_script.tcl -log pnr.log


clean:
	rm -rf SYNTH PNR
	rm -f simv
	rm -f *.vcd
	rm -f *.key
	rm -rf csrc/
	rm -rf *.rpt
	rm -rf *.log
	rm -rf *.svf
	rm -rf *.ddc
	rm -rf results_synthesized.v
	rm -rf results_synthesized.sdc
	rm -rf alib-52/
	rm -rf rpt/
	rm -rf simv.daidir/
	rm -rf encounter*
	rm -rf pnr_report
	rm -rf report

