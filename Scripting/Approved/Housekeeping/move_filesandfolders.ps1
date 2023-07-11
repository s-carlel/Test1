$Drive = "C:"
##ÃœberprÃ¼fe die Festplatte
if (Test-Path -Path "D:\" ) {
    ##ÃœberprÃ¼fe, ob auf der Platte mehr als 33 GB vorhanden sind
    $FreeSpaceGB = [int]((Get-CimInstance CIM_LogicalDisk -Filter "DeviceId='D:'").FreeSpace/1024/1024/1024)
    if($FreeSpaceGB -lt $RequiredSpaceGB){
        ##Nicht genÃ¼gend Speicherplatz, springe auf C:
        $Drive = "C:"
        }
        else {
            $Drive= "D:"
        }
 } 
##ÃœberprÃ¼fe, ob der Backup Ordner existiert
$path = "$Drive\ITM\Backup"
If(!(test-path -PathType container $path))
{
      New-Item -ItemType Directory -Path $path
}



$Folder = "ITK", "AVL", "BEG", "SYN", "TT"

$todaysdate=Get-Date -Format "MM-dd-yyyy-hh-mm"
$logoutput = "$Drive\ITM\Backup\vGarage\Logs\"+$todaysdate+".log"


foreach ($item in $Folder) {

Start-Transcript $logoutput -Append
get-childitem -Path "$Drive\vGarage\$item" | where-object {$_.LastWriteTime -lt (get-date).AddDays(-31)} | move-item -destination "$Drive\ITM\Backup\vGarage\$item\" -Force -Verbose
Stop-Transcript 
}
