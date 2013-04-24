cd /home/race/ise_projects/test/arm/
if { [ catch { xload xmp arm.xmp } result ] } {
  exit 10
}
xset hdl vhdl
run stubgen
exit 0
