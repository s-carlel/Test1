###Variabeln
$Folder = "BEG","AVL","TT","ITK","SYN"
#$Drive = "C:"
$RequiredSpaceGB = 33
$AVL ="$Drive\vGarage\AVL"
$ITK ="$Drive\vGarage\ITK"
$TT ="$Drive\vGarage\TT"
$SYN ="$Drive\vGarage\SYN"
$BEG ="$Drive\vGarage\BEG"
$User = "emea\E601_ALL_WksAdm","SYSTEM"

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

###########
##Ordner vGarage erstellen
New-Item -Path "$Drive" -Name "vGarage" -ItemType "Directory" -Force

##Vererbung Deaktivieren
$acl = Get-Acl "$Drive\vGarage"
$acl.SetAccessRuleProtection($true,$true)
$acl | Set-Acl "$Drive\vGarage"

##Authentifizierten Benuzter entfernen
icacls.exe "$Drive\vGarage" --%  /remove[:g] *S-1-5-11

##########


##Für jeden Eintrag in der Variable Folder einen Unterordner erstellen
foreach ($Folder in $Folder) {
    $newpath = Join-Path "$Drive\vGarage" -ChildPath $Folder
    New-Item $newpath -ItemType Directory -Force   
}


## Vererbungen für die Unterordner Deaktivieren
function Deactivate-Ver {

    $acl = Get-Acl "$AVL"
    $acl.SetAccessRuleProtection($true,$true)
    $acl | Set-Acl "$AVL"

    $acl = Get-Acl "$BEG"
    $acl.SetAccessRuleProtection($true,$true)
    $acl | Set-Acl "$BEG"

    $acl = Get-Acl "$TT"
    $acl.SetAccessRuleProtection($true,$true)
    $acl | Set-Acl "$TT"

    $acl = Get-Acl "$ITK"
    $acl.SetAccessRuleProtection($true,$true)
    $acl | Set-Acl "$ITK"

    $acl = Get-Acl "$SYN"
    $acl.SetAccessRuleProtection($true,$true)
    $acl | Set-Acl "$SYN"
}

## Berechtigungen löschen & falls Authetifizierter Benutzer angezeigt wird, auch löschen
function Del-Per{

    $acl = Get-Acl "$AVL"
    $acl.Access | %{$acl.RemoveAccessRule($_)}
    Set-Acl "$AVL" $acl

    $acl = Get-Acl "$SYN"
    $acl.Access | %{$acl.RemoveAccessRule($_)}
    Set-Acl "$SYN" $acl

    $acl = Get-Acl "$BEG"
    $acl.Access | %{$acl.RemoveAccessRule($_)}
    Set-Acl "$BEG" $acl

    $acl = Get-Acl "$TT"
    $acl.Access | %{$acl.RemoveAccessRule($_)}
    Set-Acl "$TT" $acl

    $acl = Get-Acl "$ITK"
    $acl.Access | %{$acl.RemoveAccessRule($_)}
    Set-Acl "$ITK" $acl
    
}

#### Admin & System Benutzer hinzufügen
function Add-UsertoFolder {
    $acl = Get-Acl "$AVL"
    $permission  = "$User","FullControl", "ContainerInherit,ObjectInherit","None","Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($accessRule)
    Set-Acl "$AVL" $acl

    $acl = Get-Acl "$ITK"
    $permission  = "$User","FullControl", "ContainerInherit,ObjectInherit","None","Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($accessRule)
    Set-Acl "$ITK" $acl

    $acl = Get-Acl "$TT"
    $permission  = "$User","FullControl", "ContainerInherit,ObjectInherit","None","Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($accessRule)
    Set-Acl "$TT" $acl

    $acl = Get-Acl "$BEG"
    $permission  = "$User","FullControl", "ContainerInherit,ObjectInherit","None","Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($accessRule)
    Set-Acl "$BEG" $acl

    $acl = Get-Acl "$SYN"
    $permission  = "$User","FullControl", "ContainerInherit,ObjectInherit","None","Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($accessRule)
    Set-Acl "$SYN" $acl
        
   }

### RDP Gruppen hinzufügen
function Add-UsertoFolder_v {
    $acl = Get-Acl "$AVL"
    $permission  = "emea\E601_RDP-SIL-AVL","FullControl", "ContainerInherit,ObjectInherit","None","Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($accessRule)
    Set-Acl "$AVL" $acl

    $acl = Get-Acl "$ITK"
    $permission  = "emea\E601_RDP-SIL-ITK","FullControl", "ContainerInherit,ObjectInherit","None","Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($accessRule)
    Set-Acl "$ITK" $acl

    $acl = Get-Acl "$TT"
    $permission  = "emea\E601_RDP-SIL-TT","FullControl", "ContainerInherit,ObjectInherit","None","Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($accessRule)
    Set-Acl "$TT" $acl

    $acl = Get-Acl "$BEG"
    $permission  = "emea\E601_RDP-SIL-BEG","FullControl", "ContainerInherit,ObjectInherit","None","Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($accessRule)
    Set-Acl "$BEG" $acl

    $acl = Get-Acl "$SYN"
    $permission  = "emea\E601_RDP-SIL-SYN","FullControl", "ContainerInherit,ObjectInherit","None","Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($accessRule)
    Set-Acl "$SYN" $acl
        
   }


###############Berechtigungen setzen
Deactivate-Ver
Del-Per 
Deactivate-Ver
Del-Per 
Deactivate-Ver
Del-Per 

icacls.exe $Drive\vGarage /restore 'C:\Windows\System32\SiL-Housekeeping\cre.txt' /T

##Vererbung für vGarage Deaktiviern
$acl = Get-Acl "$Drive\vGarage"
$acl.SetAccessRuleProtection($true,$true)
$acl | Set-Acl "$Drive\vGarage"

##Authentifizierten Benuzter entfernen
icacls.exe "$Drive\vGarage" --%  /remove[:g] *S-1-5-11

##Authentifizierter Benutzer mit neuen Berechtigungen setzen
icacls.exe "$Drive\vGarage" --%  /grant *S-1-5-11:(REA,RD,X,RA)


##Berechtigung setzen für System und Admin
foreach ($User in $User) {
    
    Add-UsertoFolder
}

#Lieferanten auf die jeweiligen Unterordner Berechtigen
Add-UsertoFolder_v
