source $root_dir/tcl/environment.tcl
source $root_dir/tcl/ip_properties.tcl

set ip_properties [ list \
    vendor "meep-project.eu" \
    library "MEEP" \
    name "MEEP_${g_design_name}" \
    version "$g_ip_version" \
    taxonomy "/MEEP_IP" \
    display_name "MEEP QSFP IP" \
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


## Relative path to IP root directory
ipx::create_xgui_files ${ip_core} -logo_file "misc/BSC-Logo.png"
set_property type LOGO [ipx::get_files "misc/BSC-Logo.png" -of_objects [ipx::get_file_groups xilinx_utilityxitfiles -of_objects [ipx::current_core]]]


# Save IP and close project
ipx::check_integrity ${ip_core}
ipx::save_core ${ip_core}

ipx::merge_project_changes files [ipx::current_core]
update_ip_catalog -rebuild -scan_changes

puts "IP succesfully packaged " 
