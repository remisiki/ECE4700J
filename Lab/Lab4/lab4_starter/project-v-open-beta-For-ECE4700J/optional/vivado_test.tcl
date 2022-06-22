cd ../baseline

set outputdir ./VivadoProject
file mkdir $outputdir

set files [glob -nocomplain "$outputdir/*"]
if {[llength $files] != 0} {
    puts "deleting contents of $outputdir"
    file delete -force {*}[glob -directory $outputdir *]; 
} else {
    puts "$outputdir is empty"
}

# Create your project
create_project pipeline $outputdir -part xcvu35p-fsvh2892-3-e


add_files -norecurse  {verilog/if_stage.sv verilog/id_stage.sv verilog/ex_stage.sv verilog/mem_stage.sv verilog/wb_stage.sv verilog/pipeline.sv verilog/regfile.sv program.mem }

update_compile_order -fileset sources_1
update_compile_order -fileset sources_1

add_files -norecurse  {D:/SJTU/ECE4700J/lab4/baseline/ISA.svh D:/SJTU/ECE4700J/lab4/baseline/sys_defs.svh}
set_property is_global_include true [get_files ISA.svh sys_defs.svh]
update_compile_order -fileset sources_1
update_compile_order -fileset sources_1




update_compile_order -fileset sources_1
set_property SOURCE_SET sources_1 [get_filesets sim_1]


add_files -fileset sim_1 -norecurse -scan_for_includes testbench/riscv_inst.h testbench/pipe_print.c
add_files -fileset sim_1 -norecurse -scan_for_includes testbench/mem.sv testbench/testbench.sv

update_compile_order -fileset sim_1

set_property top pipeline [current_fileset]
update_compile_order -fileset sources_1

set_property top testbench [get_filesets sim_1]

update_compile_order -fileset sim_1

set_property is_global_include true [get_files ISA.svh sys_defs.svh]
update_compile_order -fileset sources_1


# launch RTL analysis & synthesis
launch_runs synth_1 -jobs 8
wait_on_run synth_1


update_compile_order -fileset sources_1
set_property -name {xsim.simulate.runtime} -value {10000000ns} -objects [get_filesets sim_1]

launch_simulation

close_project


exit
