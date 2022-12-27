set company  "VLSILAB"
set designer "Shi-Yong Wu"
set search_path      ". /usr/cad/synopsys/CBDK_TSMC90GUTM_Arm_f1.0/CIC/SynopsysDC/db ../Mem_lib $search_path"
set target_library   "typical.db SRAM_SP_512_128.db"
#set target_library  "slow.db fast.db"
set link_library     "* $target_library dw_foundation.sldb"
set symbol_library   "tsmc090.sdb generic.sdb"
set synthetic_library "dw_foundation.sldb"

set case_analysis_with_logic_constants true

set hdlin_translate_off_skip_text "TRUE"
#set hdlin_enable_presto_for_vhdl "TRUE"
set edifout_netlist_only "TRUE"
set verilogout_no_tri true
set plot_command {lpr -Plp}
set hdlin_auto_save_templates "TRUE"


#define_name_rules name_rule -allowed {a-z A-Z 0-9 _} -max_length 255 -type cell
#define_name_rules name_rule -allowed {a-z A-Z 0-9 _[]} -max_length 255 -type net
#define_name_rules name_rule -map {{"\*cell\*" "cell"}}
#define_name_rules name_rule -case_insensitive

set view_script_submenu_items [list {Avoid assign statement} {set_fix_multiple_p
ort_nets -all -buffer_constant} {Change Naming Rule} {change_names -rule verilog
 -hierarchy} {Write SDF} {write_sdf -version 2.1 -context verilog chip.sdf}]

set hdlin_while_loop_iterations 2000


analyze -format verilog ../vlog/siang_test_v/horizontal_tf_fly_row0.v  
analyze -format verilog ../vlog/siang_test_v/horizontal_tf_fly_row1.v  
analyze -format verilog ../vlog/siang_test_v/horizontal_tf_fly_row2.v  
analyze -format verilog ../vlog/siang_test_v/horizontal_tf_fly_row3.v  
analyze -format verilog ../vlog/siang_test_v/horizontal_top.v  
analyze -format verilog ../vlog/siang_test_v/horizontal_Mux3.v  
analyze -format verilog ../vlog/siang_test_v/horizontal_fifo.v  
analyze -format verilog ../vlog/siang_test_v/horizontal_out_process.v  
analyze -format verilog ../vlog/siang_test_v/delay_buffer.v  


analyze -format verilog ../vlog/siang_test_v/MulMod128_on_the_fly.v       
analyze -format verilog ../vlog/siang_test_v/Mux3_const.v                 
analyze -format verilog ../vlog/siang_test_v/on_the_fly_pip.v             
analyze -format verilog ../vlog/siang_test_v/R16_ROMPipe_const.v           
analyze -format verilog ../vlog/siang_test_v/stage_delay.v                
analyze -format verilog ../vlog/siang_test_v/TW_ROM0_1024_64.v            
analyze -format verilog ../vlog/siang_test_v/TW_ROM1_1024_128.v            
analyze -format verilog ../vlog/siang_test_v/TW_ROM2_1024_128.v            
analyze -format verilog ../vlog/siang_test_v/TW_ROM3_1024_128.v            
analyze -format verilog ../vlog/siang_test_v/TW_ROM4_1024_128.v            
analyze -format verilog ../vlog/siang_test_v/TW_ROM5_1024_128.v            
analyze -format verilog ../vlog/siang_test_v/TW_ROM6_1024_128.v            
analyze -format verilog ../vlog/siang_test_v/TW_ROM7_1024_128.v            
analyze -format verilog ../vlog/FFTP.v              
analyze -format verilog ../vlog/CenCtrl.v           
analyze -format verilog ../vlog/CLA4.v              
analyze -format verilog ../vlog/CLA16.v             
analyze -format verilog ../vlog/CLA16clg.v          
analyze -format verilog ../vlog/CLA32.v             
analyze -format verilog ../vlog/CLA32clg.v          
analyze -format verilog ../vlog/CLA64clg_co.v       
analyze -format verilog ../vlog/CLA64_co.v          
analyze -format verilog ../vlog/CLA65.v             
analyze -format verilog ../vlog/CLA65clg.v          
analyze -format verilog ../vlog/Ctrl_PipeReg1.v     
analyze -format verilog ../vlog/Mod192.v            
analyze -format verilog ../vlog/Mod192PD.v          
analyze -format verilog ../vlog/ModMux.v            
analyze -format verilog ../vlog/Mul64.v             
analyze -format verilog ../vlog/MulMod128.v         
analyze -format verilog ../vlog/MulMod128PD.v       
analyze -format verilog ../vlog/Mux1.v              
analyze -format verilog ../vlog/Mux2.v              
analyze -format verilog ../vlog/Mux3.v              
analyze -format verilog ../vlog/Mux4.v              
analyze -format verilog ../vlog/R16_AGU.v           
analyze -format verilog ../vlog/R16_DC.v            
analyze -format verilog ../vlog/R16_NPipeReg2.v     
analyze -format verilog ../vlog/R16_NPipeReg3.v     
analyze -format verilog ../vlog/R16_PipeReg2.v      
analyze -format verilog ../vlog/R16_PipeReg4.v      
analyze -format verilog ../vlog/R16_PipeReg4_2.v    
analyze -format verilog ../vlog/R16_ROMPipeReg1.v   
analyze -format verilog ../vlog/R16_WAddr.v         
analyze -format verilog ../vlog/R16_WD_buf.v        
analyze -format verilog ../vlog/BU_S0.v             
analyze -format verilog ../vlog/BU.v                
analyze -format verilog ../vlog/Pipe.v              
analyze -format verilog ../vlog/Radix16_Pipe.v      
analyze -format verilog ../vlog/Mux5.v
analyze -format verilog ../vlog/Mux6.v
analyze -format verilog ../vlog/BR.v
analyze -format verilog ../vlog/R16_BU_outpipe.v
analyze -format verilog ../vlog/R16_orderROM_Pipe.v
analyze -format verilog ../vlog/IReorderMA_pip.v
analyze -format verilog ../vlog/Rectrl.v
analyze -format verilog ../vlog/R16_InpipeReg.v
analyze -format verilog ../vlog/MulMod.v
analyze -format verilog ../vlog/Mul.v
analyze -format verilog ../vlog/TWIpipe.v
analyze -format verilog ../vlog/TWIMux.v
                                                    
elaborate FFTP -architecture verilog                
                                                    
current_design FFTP                                 
link                                                
uniquify                                            
set_operating_conditions -max typical -max_library typical -min typical -min_library typical    
#set_operating_conditions -max slow -max_library slow -min fast -min_library fast               
set_wire_load_mode segmented                                                                    
set_wire_load_model -name tsmc090_wl10 -library typical                                         
#set_wire_load_model -name tsmc090_wl10 -library slow                                           
create_clock -period 5 -waveform {0 2.5} [get_ports clk]
set_dont_touch_network [get_ports clk]                                                          
set_ideal_network [get_ports clk]                                                             
set_ideal_network [get_ports rst_n]                                                             
#set_dont_touch_network [get_ports rst_n]                                                       
                                                                                                
set_clock_uncertainty -setup 0.1 [get_clocks clk]                                               
set_drive [drive_of typical/DFFX2/Q] [remove_from_collection [all_inputs] [get_ports {clk}]]    
set_load [load_of typical/DFFX2/D] [all_outputs]                                                
#set_drive [drive_of slow/DFFX2/Q] [remove_from_collection [all_inputs] [get_ports {clk}]]      
#set_load [load_of slow/DFFX2/D] [all_outputs]                                                  
set_input_delay 0.2 -clock clk [remove_from_collection [all_inputs] [get_ports {clk}]]          
set_output_delay 0.2 -max -clock clk [all_outputs]                                              
set_fix_multiple_port_nets -all -buffer_constants                                               
#set_case_analysis 1 [get_ports rst_n]                                                          
#set_max_area 0                                                                                 
set_host_options -max_cores 8                                                                   
                                                                                                
#set_clock_gating_style -sequential_cell latch -max_fanout 3 -num_stage 1 -setup 0.3            
#-control_point before -control_signal se                                                       
#propagate_constraints -gate_clock                                                              
#insert_clock_gating -module                                                                    
#replace_clock_gates                                                                            
                                                                                                
#compile                                                                                        
                                                                                                
#compile -inc -map_effort high                                                                  
#compile -map_effort medium                                                                     
#compile -incremental_mapping -map_effort high -area_effort high -boundary_optimization         
#compile -incremental_mapping -map_effort high -area_effort high -boundary_optimization         
#compile -incremental_mapping -map_effort high -boundary_optimization                           
#compile_ultra -timing_high_effort_script                                                       
#compile_ultra -area_high_effort_script                                                         
#compile_ultra -no_autoungroup -timing_high_effort_script                                       
compile_ultra -no_autoungroup -area_high_effort_script                                          
                                                                                                
                                                                                                
remove_unconnected_ports -blast_buses [get_cells * -hier]                                       
change_names -rule verilog -hierarchy                                                           
#set bus_inference_style {%s[%d]}                                                               
#set bus_naming_style {%s[%d]}                                                                  
#set hdlout_internal_busses true                                                                
#change_names -hierarchy -rule verilog                                                          
#define_name_rules name_rule -allowed "A-Z a-z 0-9 _"-max_length 255 -type cell
#define_name_rules name_rule -allowed "A-Z a-z 0-9 _[]"-max_length 255 -type net
#define_name_rules name_rule -map {{"\*cell\*" "cell"}}
#define_name_rules name_rule -case_insensitive                                                  
#change_names -hierarchy -rule name_rule                                                        
                                                                                                
                                                                                                
write -format verilog -hierarchy -output ../gate_netlist/FFTP_pipe_syn.v                        
write_sdf -version 2.1 -context verilog ../gate_netlist/FFTP_pipe.sdf                           
write -format ddc -hierarchy -output ../gate_netlist/FFTP_pipe.ddc                              
write_sdc -version 1.7 ../gate_netlist/FFTP_pipe.sdc                                            
write_parasitics -output ../gate_netlist/FFTP_pipe.spef                                         
                                                                                                
                                                                                                
report_timing -max_paths 20  > ../reports/FFTP_pipe_timing.rpt                                  
report_area > ../reports/FFTP_pipe_area.rpt                                                     
report_power > ../reports/FFTP_pipe_power.rpt                                                   
report_area -hier > ../reports/FFTP_pipe_area_hier.rpt                                          
                                                                                                
exit                                                                                            
