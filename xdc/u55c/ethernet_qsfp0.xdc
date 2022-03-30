
# QSFP28 Interfaces, QSFP_0, U55C
set_property -dict {LOC AD51 } [get_ports qsfp_1x_grx_p] ; # MGTYRXP0_130 GTYE4_CHANNEL_X0Y40 / GTYE4_COMMON_X0Y10
set_property -dict {LOC AD52 } [get_ports qsfp_1x_grx_n] ; # MGTYRXN0_130 GTYE4_CHANNEL_X0Y40 / GTYE4_COMMON_X0Y10
set_property -dict {LOC AD46 } [get_ports qsfp_1x_gtx_p] ; # MGTYTXP0_130 GTYE4_CHANNEL_X0Y40 / GTYE4_COMMON_X0Y10
set_property -dict {LOC AD47 } [get_ports qsfp_1x_gtx_n] ; # MGTYTXN0_130 GTYE4_CHANNEL_X0Y40 / GTYE4_COMMON_X0Y10

set_property -dict {LOC AD42 } [get_ports qsfp_refclk_clk_p] ; # MGTREFCLK1P_130 from SI5394B
set_property -dict {LOC AD43 } [get_ports qsfp_refclk_clk_n] ; 


# 161.1328125 MHz MGT reference clock (from SI5394B)
create_clock -period 6.206 -name qsfp_refclk [get_ports qsfp_refclk_clk_p]


#set_false_path -from [get_pins -hierarchical -filter {NAME =~ interrupt*/C}]

