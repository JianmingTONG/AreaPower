#include ../Makefile.include

SCRIPT_DIR=./scripts

all: flow

flow: clean synth pnr


synth_sweep_tree:
	python3 ./scripts/synth_wrapper/run_dc_tree.py

synth_sweep_fifo:
	python3 ./scripts/synth_wrapper/run_dc_fifo.py

synth_sweep_bus:
	python3 ./scripts/synth_wrapper/run_dc_bus.py

synth_sweep_xbar:
	python3 ./scripts/synth_wrapper/run_dc_xbar.py

synth_sweep_linear:
	python3 ./scripts/synth_wrapper/run_dc_linear.py

synth_sweep_multiplexer:
	python3 ./scripts/synth_wrapper/run_dc_multiplexer.py

synth_sweep_bus_singlebroadcast:
	python3 ./scripts/synth_wrapper/run_dc_bus_singlebroadcast.py

pnr_sweep_tree: 
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
	rm -rf synth_report.tar
	rm -rf pnr_report.tar 

synth_sweep_all: clean
	mkdir ./report
	make synth_sweep_flow

synth_sweep_flow: clean synth_sweep_tree synth_sweep_fifo synth_sweep_xbar synth_sweep_linear synth_sweep_bus_singlebroadcast
	tar -cvf synth_report.tar ./report

pnr_sweep_all: clean
	mkdir ./report
	mkdir ./pnr_report
	make pnr_sweep_flow

pnr_sweep_flow: clean pnr_sweep_tree pnr_sweep_fifo pnr_sweep_xbar pnr_sweep_linear pnr_sweep_bus_singlebroadcast
	tar -cvf pnr_report.tar ./pnr_report


