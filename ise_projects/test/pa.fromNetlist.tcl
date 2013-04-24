
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name test -dir "/home/race/ise_projects/test/planAhead_run_4" -part xc7z020clg484-1
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/home/race/ise_projects/test/arm_top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/race/ise_projects/test} }
add_files [list {/home/race/ise_projects/test/arm_processing_system7_0_wrapper.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {/home/race/ise_projects/test/arm.ncf}] -fileset [get_property constrset [current_run]]
set_param project.pinAheadLayout  yes
set_property target_constrs_file "arm_top.ucf" [current_fileset -constrset]
add_files [list {arm_top.ucf}] -fileset [get_property constrset [current_run]]
link_design
