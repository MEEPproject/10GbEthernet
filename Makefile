ROOT_DIR  = $(PWD)
VIVADO_VER  := 2021.2
VIVADO_PATH := /opt/Xilinx/Vivado/$(VIVADO_VER)/bin/
VIVADO_XLNX := $(VIVADO_PATH)/vivado
VIVADO_OPT  := -mode batch -nolog -nojournal -notrace -source
FPGA_BOARD  ?= u280
QSFP_PORT   ?= qsfp0


#Generate the Aurora DMA IP

generate_ip:
	echo "Generate 10Gb Ethernt IP for the Alveo $(FPGA_BOARD) and the port $(QSFP_PORT)"
	$(VIVADO_XLNX) $(VIVADO_OPT)  ./tcl/gen_project.tcl -tclargs $(FPGA_BOARD) $(QSFP_PORT)
	echo "IP created under folder $(QSFP_PORT)"


clean:
	git clean -f
	@(cd ip; find . -type f ! -name "*.tcl" -exec rm -r {} \;)
	rm -rf xgui project qsfp*



