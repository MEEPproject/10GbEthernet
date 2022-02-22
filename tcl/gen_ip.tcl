source $root_dir/tcl/environment.tcl
source $root_dir/tcl/ip_properties.tcl

set ip_properties [ list \
    vendor "meep-project.eu" \
    library "MEEP" \
    name "MEEP_${g_design_name}" \
    version "$g_ip_version" \
    taxonomy "/MEEP_IP" \
    display_name "MEEP Aurora DMA" \
    description "${g_ip_description}" \
    vendor_display_name "MEEP Project" \
    company_url "https://meep-project.eu/" \
    ]

set family_lifecycle { \
  virtexuplusHBM Production \
}


# Package project and set properties
ipx::package_project
set ip_core [ipx::current_core]
set_property -dict ${ip_properties} ${ip_core}
set_property SUPPORTED_FAMILIES ${family_lifecycle} ${ip_core}

# ipx::add_bus_parameter ID_WIDTH [ipx::get_bus_interfaces S_AXI -of_objects [ipx::current_core]]    
# ipx::add_bus_parameter AWUSER_WIDTH [ipx::get_bus_interfaces S_AXI -of_objects [ipx::current_core]]
# ipx::add_bus_parameter ARUSER_WIDTH [ipx::get_bus_interfaces S_AXI -of_objects [ipx::current_core]]
# ipx::add_bus_parameter WUSER_WIDTH [ipx::get_bus_interfaces S_AXI -of_objects [ipx::current_core]] 
# ipx::add_bus_parameter BUSER_WIDTH [ipx::get_bus_interfaces S_AXI -of_objects [ipx::current_core]] 
# ipx::add_bus_parameter RUSER_WIDTH [ipx::get_bus_interfaces S_AXI -of_objects [ipx::current_core]] 


# Associate AXI/AXIS interfaces and reset with clock
#set aclk_intf [ipx::get_bus_interfaces ACLK -of_objects ${ip_core}]
#set aclk_assoc_intf [ipx::add_bus_parameter ASSOCIATED_BUSIF $aclk_intf]
#set_property value M_AXIS:S_AXIS:S_AXI $aclk_assoc_intf
#set aclk_assoc_reset [ipx::add_bus_parameter ASSOCIATED_RESET $aclk_intf]
#set_property value ARESETN $aclk_assoc_reset
#ipx::add_bus_parameter FREQ_HZ [ipx::get_bus_interfaces ACLK -of_objects [ipx::current_core]]




#Set clocks

#Set Frequency INY_CLK
ipx::add_bus_parameter FREQ_HZ [ipx::get_bus_interfaces INIT_CLK -of_objects [ipx::current_core]]

#Set USER_CLK_OUT
ipx::infer_bus_interface USER_CLK_OUT xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::add_bus_parameter FREQ_HZ [ipx::get_bus_interfaces USER_CLK_OUT -of_objects [ipx::current_core]]
set user_clk_out_intf [ipx::get_bus_interfaces USER_CLK_OUT -of_objects ${ip_core}]
set user_clk_out_assoc_intf [ipx::add_bus_parameter ASSOCIATED_BUSIF $user_clk_out_intf]
set_property value M_AXI_MM2S:M_AXI_S2MM:M0_AXIS_MM2S:S0_AXIS_S2MM [ipx::add_bus_parameter ASSOCIATED_BUSIF [ipx::get_bus_interfaces USER_CLK_OUT]]

#Set S_AXI_LITE_DMA_ACLK
ipx::infer_bus_interface S_AXI_LITE_DMA_ACLK xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::add_bus_parameter FREQ_HZ [ipx::get_bus_interfaces S_AXI_LITE_DMA_ACLK -of_objects [ipx::current_core]]
set s_axi_lite_dma_aclk_intf [ipx::get_bus_interfaces S_AXI_LITE_DMA_ACLK -of_objects [ipx::current_core]]
set s_axi_lite_dma_aclk_assoc_intf [ipx::add_bus_parameter ASSOCIATED_BUSIF $s_axi_lite_dma_aclk_intf]
set_property value S_AXI_LITE $s_axi_lite_dma_aclk_assoc_intf
set s_axi_lite_aclk_assoc_reset [ipx::add_bus_parameter ASSOCIATED_RESET $s_axi_lite_dma_aclk_intf]
set_property value AXI_DMA_RESETN $s_axi_lite_aclk_assoc_reset

## Relative path to IP root directory
ipx::create_xgui_files ${ip_core} -logo_file "misc/BSC-Logo.png"
set_property type LOGO [ipx::get_files "misc/BSC-Logo.png" -of_objects [ipx::get_file_groups xilinx_utilityxitfiles -of_objects [ipx::current_core]]]



# SET SYS_RESET

# Set reset polarity
#set aresetn_intf [ipx::get_bus_interfaces ARESETN -of_objects ${ip_core}]
#set aresetn_polarity [ipx::add_bus_parameter POLARITY $aresetn_intf]
#set_property value ACTIVE_LOW ${aresetn_polarity}

set reset_intf [ipx::get_bus_interfaces RESET -of_objects [ipx::current_core]]
set reset_polarity [ipx::add_bus_parameter POLARITY $reset_intf]
set_property value ACTIVE_HIGH ${reset_polarity}

set reset_ui_intf [ipx::get_bus_interfaces RESET_UI -of_objects [ipx::current_core]]
set reset_ui_polarity [ipx::add_bus_parameter POLARITY $reset_ui_intf]
set_property value ACTIVE_HIGH ${reset_ui_polarity}


# Add Software Driver

#data
ipx::add_file_group -type software_driver {} [ipx::current_core]
ipx::add_file driver/data/auroradma.tcl [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type tclSource [ipx::get_files driver/data/auroradma.tcl -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file driver/data/auroradma.mdd [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type mdd [ipx::get_files driver/data/auroradma.mdd -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]

#src
ipx::add_file driver/src/xaxidma.h [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files driver/src/xaxidma.h -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file driver/src/xaxidma_sinit.c [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files driver/src/xaxidma_sinit.c -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file driver/src/xaxidma_g.c [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files driver/src/xaxidma_g.c -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file driver/src/xaxidma.c [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files driver/src/xaxidma.c -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file driver/src/xaxidma_bd.h [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files driver/src/xaxidma_bd.h -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file driver/src/xaxidma_bdring.c [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files driver/src/xaxidma_bdring.c -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file driver/src/xaxidma_hw.h [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files driver/src/xaxidma_hw.h -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file driver/src/xaxidma_porting_guide.h [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files driver/src/xaxidma_porting_guide.h -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file driver/src/xdebug.h [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files driver/src/xdebug.h -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file driver/src/xaxidma_selftest.c [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files driver/src/xaxidma_selftest.c -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file driver/src/Makefile [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type unknown [ipx::get_files driver/src/Makefile -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file driver/src/xaxidma_bdring.h [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files driver/src/xaxidma_bdring.c -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file driver/src/xaxidma_bd.c [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files driver/src/xaxidma_bd.c -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]

ipx::remove_file_group xilinx_implementation [ipx::current_core]


# Save IP and close project
ipx::check_integrity ${ip_core}
ipx::save_core ${ip_core}

puts "IP succesfully packaged " 
