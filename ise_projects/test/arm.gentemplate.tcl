proc pngeninsttemplate {} {
  cd /home/race/ise_projects/test/arm
  if { [ catch { xload xmp arm.xmp } result ] } {
    exit 10
  }
  if { [catch {run mhs2hdl} result] } {
    return -1
  }
  return 0
}
if { [catch {pngeninsttemplate} result] } {
  exit -1
}
exit $result
