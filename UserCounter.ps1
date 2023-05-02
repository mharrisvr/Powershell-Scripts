# UserCounter.ps1
# Just Counts how many users exist for each site location.. Update with your own naming conventions 
# Last Modified: 5/2/2023

$LocationCodes = @('McDonalds','Burger King','Wendys')

Foreach ($Location in $LocationCodes) {
    $SiteUsers = Get-ADUser -filter "Office -like '*$Location*'" -properties name, description
    Write-Host $Location 'has:' $SiteUsers.count 
}
