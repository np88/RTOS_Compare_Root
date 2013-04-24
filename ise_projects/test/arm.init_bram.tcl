cd /home/race/ise_projects/test/arm
if { [ catch { xload xmp arm.xmp } result ] } {
  exit 10
}

if { [catch {run init_bram} result] } {
  exit -1
}

exit 0
