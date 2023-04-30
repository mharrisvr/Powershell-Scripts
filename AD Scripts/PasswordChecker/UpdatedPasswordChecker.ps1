# Password update checker

Import-Module ActiveDirectory

$UserObjects = Import-CSV -Path C:\users\username\desktop\scripts\newhire.csv

#Write-Host $userObjects
Write-Verbose -Message "Checking to see if passwords have been changed.. `n" -Verbose

ForEach ( $UserObject in $UserObjects ) {

    $User = $(try {Get-ADUSer $UserObject.Name -Properties * } catch {$null})
    $ts = New-TimeSpan -Seconds 2 #Had to add to time to make comparison check work. 
    $CreationDate = $User.'Created' + $ts 
    $PwdSet = $User.'PasswordLastSet' 
    $Name = $User.'DisplayName'
    
    if ($User -ne $Null) {
    
        if ($PwdSet -gt $CreationDate) {
            Write-Host "$Name was created on: $CreationDate" 
            Write-Host "Account Password last set on: $PwdSet" 
            Write-Host "Account password has been changed. `n" -ForegroundColor Green      
        }
        else {
            Write-Host "$Name was created on: $CreationDate" 
            Write-Host "Account Password last set on: $PwdSet"
            Write-Host ("Password has not been reset `n") -ForegroundColor Red 
        }
    }
    else {
        Write-Host "AD account does not exist yet for: " $UserObject.Name
    }
}
