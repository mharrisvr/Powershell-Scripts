#Purporse... Gets members of admins group on remote machine 

$computerName = "<InsertComputerName>"        #Update Computer Name to be one that is needed.. 

$group = Get-WmiObject win32_group -ComputerName $computerName -Filter "LocalAccount=True AND SID='S-1-5-32-544'"
$query = "GroupComponent = `"Win32_Group.Domain='$($group.domain)'`,Name='$($group.name)'`""
$allAdmins = Get-WmiObject win32_groupuser -ComputerName $computerName -Filter $query | %{$_.PartComponent} | % {$_.substring($_.lastindexof("Domain=") + 7).replace("`",Name=`"","\")}


$allAdmins
