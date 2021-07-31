##====================================================================================================================================##
##                                                                                                                                    ##
## Purpose: The purpose of this function is to check the values for a user and output if they are migrated to O365 email / Teams yet. ##
##                                                                                                                                    ##
##====================================================================================================================================##

#Function Get-TeamsStatus {


    $usr = Read-Host -Prompt "Enter Username" #Prompt for username

    #Creates usr object will all properties of Get-ADUser
    $UserInfo = Get-ADUser -Identity $usr -properties * # Creates Object storing all properties of Get-ADUser
 
    $0365Status = $UserInfo.'targetAddress'
    $trgtAddress = "SMTP:"+$usr+"@dcscorporation.mail.onmicrosoft.com"
    $UsrName = $UserInfo.'Name'

    Write-Output #Adds blank line between username prompt & Output 

    if ($0365Status -ne '$trgtAddress') {
        Write-Output '0365 Status: ' $UserInfo.'targetAddress'
       } else {
        Write-Output '0365 Status: Not Migrated'
        }

    Write-Output "Teams Status:" $UserInfo.'msRTCSIP-DeploymentLocator'
 
    #Check to see if user has been migrated to Teams by checking msRTCSIP-DeploymentLocator property
    if ($UserInfo.'msRTCSIP-DeploymentLocator' -eq 'sipfed.online.gov.skypeforbusiness.us') {
        Write-Output
        Write-Output $usrName "is moved to Office 365 and MS Teams" 
        Write-Output
    } else {
       Write-Output
       Write-Output $usrName "is not moved to Teams yet."
       Write-Output
    }



#}
