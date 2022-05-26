# Creates new AD Group for Temp or perm admin rights & adds users into group. 
# Will need to update both groupname, SamAccountName, and Members sections 

$GroupNme = "Test Group"
$GroupMembers = "user1, user2, user3"

New-ADGroup -Name $GroupName -SamAccountName $GroupName -GroupCategory Security -GroupScope Global -Path "Insert Path Here"
add-adgroupmember -Identity $GroupName -Members $GroupMembers
