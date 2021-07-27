# Password update checker
# 7-27-2021
# This scripts checks a CSV file of names against AD to see if the account password has been changed since the account has been created and reports back. 

Import-Module ActiveDirectory

$UserObjects = Import-CSV -Path #Insert your path here

#Write-Host $userObjects
Write-Verbose -Message "Checking to see if passwords have been changed.. `n" -Verbose

ForEach ( $UserObject in $UserObjects ) {

    $User = Get-ADUSer $UserObject.Name -Properties *
    $CreationDate = $User.'Created'
    $PwdSet = $User.'passwordlastset'
    $Name = $User.'DisplayName'
    
    if ($PwdSet -eq $CreationDate) {
        Write-Host ("Password has not been reset")
    }
    else {
        Write-Host "$Name  was created on: $CreationDate" -Verbose
        Write-Host "Account Password last set on: $PwdSet"

        if ($pwdset -ge $CreationDate) {
            Write-Host "Account password has been changed. `n" -ForegroundColor Red
        }
    }
} 
