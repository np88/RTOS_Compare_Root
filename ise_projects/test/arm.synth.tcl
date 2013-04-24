proc pnsynth {} {
  cd /home/race/ise_projects/test/arm
  if { [ catch { xload xmp arm.xmp } result ] } {
    exit 10
  }
  if { [catch {run netlist} result] } {
    return -1
  }
  return $result
}
if { [catch {pnsynth} result] } {
  exit -1
}
exit $result
