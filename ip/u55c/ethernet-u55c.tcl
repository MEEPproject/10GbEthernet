set files [list \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/eth_mac_10g.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/eth_mac_10g_fifo.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/eth_phy_10g.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/eth_phy_10g_rx.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/eth_phy_10g_tx.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/eth_phy_10g_rx_if.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/eth_phy_10g_tx_if.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/eth_phy_10g_rx_ber_mon.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/eth_phy_10g_rx_frame_sync.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/eth_phy_10g_rx_watchdog.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/axis_xgmii_rx_32.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/axis_xgmii_rx_64.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/axis_xgmii_tx_32.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/axis_xgmii_tx_64.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/xgmii_baser_dec_64.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/xgmii_baser_enc_64.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/lib/axis/rtl/sync_reset.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/lib/axis/rtl/axis_adapter.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/lib/axis/rtl/axis_async_fifo.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/lib/axis/rtl/axis_async_fifo_adapter.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/lfsr.v"] \
  [file normalize "${g_root_dir}/src/verilog-ethernet/rtl/ptp_clock_cdc.v"] \
  [file normalize "${g_root_dir}/src/ethernet.v"] \
  [file normalize "${g_root_dir}/src/ethernet_alveo.v"] \
  [file normalize "${g_root_dir}/src/meep_eth_top.v"] \

]
add_files $files

set files [list \
  [file normalize ${g_root_dir}/src/verilog-ethernet/lib/axis/syn/vivado/sync_reset.tcl] \
  [file normalize ${g_root_dir}/src/verilog-ethernet/lib/axis/syn/vivado/axis_async_fifo.tcl] \
  [file normalize ${g_root_dir}/src/verilog-ethernet/syn/vivado/eth_mac_fifo.tcl] \
]

# QSFP Port 0
if { $g_qsfp_port == "qsfp0" } { 
create_ip -name gtwizard_ultrascale -vendor xilinx.com -library ip -module_name gtwizard_ultrascale_0

set_property -dict [list CONFIG.preset {GTY-10GBASE-R}] [get_ips gtwizard_ultrascale_0]

set_property -dict [list \
    CONFIG.CHANNEL_ENABLE {X0Y24} \
    CONFIG.TX_MASTER_CHANNEL {X0Y24} \
    CONFIG.RX_MASTER_CHANNEL {X0Y24} \
    CONFIG.TX_LINE_RATE {10.3125} \
    CONFIG.TX_REFCLK_FREQUENCY {161.1328125} \
    CONFIG.TX_USER_DATA_WIDTH {64} \
    CONFIG.TX_INT_DATA_WIDTH {64} \
    CONFIG.RX_LINE_RATE {10.3125} \
    CONFIG.RX_REFCLK_FREQUENCY {161.1328125} \
    CONFIG.RX_USER_DATA_WIDTH {64} \
    CONFIG.RX_INT_DATA_WIDTH {64} \
    CONFIG.RX_REFCLK_SOURCE {X0Y24 clk1} \
    CONFIG.TX_REFCLK_SOURCE {X0Y24 clk1} \
    CONFIG.FREERUN_FREQUENCY {125} \
] [get_ips gtwizard_ultrascale_0]

} else {

# QSFP Port 1
create_ip -name gtwizard_ultrascale -vendor xilinx.com -library ip -module_name gtwizard_ultrascale_1

set_property -dict [list CONFIG.preset {GTY-10GBASE-R}] [get_ips gtwizard_ultrascale_1]

 set_property -dict [list \
     CONFIG.CHANNEL_ENABLE {X0Y24} \
     CONFIG.TX_MASTER_CHANNEL {X0Y24} \
     CONFIG.RX_MASTER_CHANNEL {X0Y24} \
     CONFIG.TX_LINE_RATE {10.3125} \
     CONFIG.TX_REFCLK_FREQUENCY {161.1328125} \
     CONFIG.TX_USER_DATA_WIDTH {64} \
     CONFIG.TX_INT_DATA_WIDTH {64} \
     CONFIG.RX_LINE_RATE {10.3125} \
     CONFIG.RX_REFCLK_FREQUENCY {161.1328125} \
     CONFIG.RX_USER_DATA_WIDTH {64} \
     CONFIG.RX_INT_DATA_WIDTH {64} \
     CONFIG.RX_REFCLK_SOURCE {X0Y24 clk1} \
     CONFIG.TX_REFCLK_SOURCE {X0Y24 clk1} \
     CONFIG.FREERUN_FREQUENCY {125} \
 ] [get_ips gtwizard_ultrascale_1]
	

}
