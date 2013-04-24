proc exportToSDK {} {
  cd /home/race/ise_projects/test/arm
  if { [ catch { xload xmp arm.xmp } result ] } {
    exit 10
  }
  if { [run exporttosdk] != 0 } {
    return -1
  }
  return 0
}

if { [catch {exportToSDK} result] } {
  exit -1
}

set sExportDir [ xget sdk_export_dir ]
set sExportDir [ file join "/home/race/ise_projects/test/arm" "$sExportDir" "hw" ] 
if { [ file exists /home/race/ise_projects/test/edkBmmFile_bd.bmm ] } {
   puts "Copying placed bmm file /home/race/ise_projects/test/edkBmmFile_bd.bmm to $sExportDir" 
   file copy -force "/home/race/ise_projects/test/edkBmmFile_bd.bmm" $sExportDir
}
if { [ file exists /home/race/ise_projects/test/arm_top.bit ] } {
   puts "Copying bit file /home/race/ise_projects/test/arm_top.bit to $sExportDir" 
   file copy -force "/home/race/ise_projects/test/arm_top.bit" $sExportDir
}
exit $result
