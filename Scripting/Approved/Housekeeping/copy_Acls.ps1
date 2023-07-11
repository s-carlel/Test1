cls
$arraySourceAccess = @()

$FileSource = Read-Host "Enter source path (no trailing backslash)."
$FileTarget = Read-Host "Enter target path (no trailing backslash)."

#copy files
#Copy-Item -Path $FileSource -Destination $FileTarget -Recurse

#create new share, 0 is type of share (disk drive) 100 is max num of people in it
#(Get-WmiObject -List -ComputerName localhost | Where-Object -FilterScript {$_.Name -eq "Win32_Share"}).InvokeMethod("Create",("C:\test3","test3",0,100,"Share description")) 

#get users who have permissions on source files, cast in array $arraySourceAccess
$result = Get-Acl $FileSource
foreach ($item in $result)
{
	foreach ($access in $item.Access)
	{
		#lists who has access to share in format "<domain>\<group or person>"
		#$access.IdentityReference
		$arraySourceAccess += $access.IdentityReference
	}
}

#display list of who has access
#$arrayFileSourceUserAccess

#set access to new location
foreach ($user in $arraySourceAccess)
{
	$ACLSourcePermissions = Get-Acl $FileSource
	$ACLNewRule = New-Object system.security.accesscontrol.filesystemaccessrule($user,"FullControl","Allow")
	$ACLSourcePermissions.SetAccessRule($ACLNewRule)
	Set-Acl $FileTarget $ACLSourcePermissions
}
