##Überprüfe die Festplatte
if (Test-Path -Path "D:\" ) {
    ##Überprüfe, ob auf der Platte mehr als 33 GB vorhanden sind
    $FreeSpaceGB = [int]((Get-CimInstance CIM_LogicalDisk -Filter "DeviceId='D:'").FreeSpace/1024/1024/1024)
    if($FreeSpaceGB -lt $RequiredSpaceGB){
        ##Nicht genügend Speicherplatz, springe auf C:
        $Drive = "C:"
        }
        else {
            $Drive= "D:"
        }
 } 

$Folder = "ITK", "AVL", "BEG", "SYN", "TT"
$todaysdate=Get-Date -Format "MM-dd-yyyy-hh-mm"
$logoutput = "$Drive\ITM\Backup\vGarage\Logs\"+$todaysdate+"_removed.log"


foreach ($item in $Folder) {

Start-Transcript $logoutput -Append
get-childitem -Path "$Drive\ITM\Backup\vGarage\$item" | where-object {$_.LastWriteTime -lt (get-date).AddDays(-31)} | Remove-Item -Force -Verbose
Stop-Transcript 
}
