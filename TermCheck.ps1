Import-Module ActiveDirectory

# #employeeIDs --> This is the list that is checked through below (If ID can not be found in AD, user has successfully termed, 
#or if user has been successfully added to term list, will be in description). 

$employeeIDs = @('1','2','3')                

$PendingTerms = @('4','5','6')                       # Was just a holding place to keep track

$SuccesfullyTermedUsers = @('7','8','9')             #This was just to keep track of the ones that I had verified; has to be manually updated / copy & pasted      

Write-Host "`n....Checking EmployeeIDs`n" -ForegroundColor Green

$Users = foreach ($employeeID in $employeeIDs) {

    $User = $(try {Get-ADUser -filter ("EmployeeID -eq $employeeID") } catch {$null})

    if ($User -ne $Null) {
      Get-ADUser $User.DistinguishedName -properties *
      }

    else {
        Write-Host "User with $employeeID does not exist"
    }
}

$Users | select name, employeeID, description


#Compared to make sure that all IDs checked were accounted for. 
$employeeIDs.count
#$PendingTerms.count
$Users.count
