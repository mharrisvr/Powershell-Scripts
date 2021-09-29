##===================================================================================================##
## SCCM-ClientRepair.ps1
## Purpose: Repair SCCM Client
## 
##===================================================================================================##

Write-Verbose "Starting the SCCM Client Repair.. " -Verbose 
Write-Output "`nStep 1. Disable SMS Agent Host from starting and Stop Service"

Set-Service -DisplayName 'SMS Agent Host' -StartupType Disabled    # Disables SMS Agent Host from starting
Get-Service -DisplayName 'SMS Agent Host' | Stop-Service           # Stops SMS Agent Host Service
$SMS = Get-Service -DisplayName 'SMS Agent Host' 
Write-Host $SMS.DisplayName "is" $SMS.Status
Read-Host "Press any Key to Continue..."

if ($SMS.Status -eq 'Stopped') {
    
    Write-output "Step 2. Stopping Wuauserv, BITS, and CryptSVC"
    Stop-Service -Name wuauserv, BITS, CryptSvc
    $Serv = Get-Service -Name CryptSvc,BITS, wuauserv 

}
    if ($Serv.Status -eq 'Stopped') {

        Set-Service -Name Winmgmt -StartupType Disabled
        Stop-Service -Name Winmgmt  
        Get-Service -DisplayName 'Windows Management Instrumentation'
        $WinM = Get-Service -Name Winmgmt

        Write-Output "`nDon't forget to restart Hyper-V Virtual Machine Management, User Access Logging Service, and IP Helper Services!" -Verbose
        Write-Output "Should be a PS line to run to re-start those down below.. "
        }

        if ($WinM.Status -eq 'stopped') {
           Write-Output "`nRenaming System Files..."
           Rename-Item -Path C:\Windows\System32\Catroot2 %systemroot%\System32\Catroot2.old
           Rename-Item -Path C:\Windows\SoftwareDistribution C:\Windows\SoftwareDistribution.old
           Rename-Item -Path C:\Windows\System32\wbem\Repository C:\Windows\System32\wbem\Repository.old
           Write-Output "`nRenaming Completed"

           Read-Host "Press any key to continue"

           Write-Output "`nEverything has been shutdown and is ready to be restarted"
           Read-Host "Enter any key to continue and restart services required... "

        }
            
        else {
            Write-Output "Please manually check to make sure all services are down."
        }

    else {
        Write-Output "Please manually check to make sure all services are down."
    }

Write-Output "`nStarting Services.. "
Start-Service -Name CryptSvc, bits, wuauserv, iphlpsvc, vmms
$Stats = Get-Service -Name CryptSvc, bits, wuauserv, iphlpsvc, vmms

if ($Stats.Status -eq 'Running') {

    Write-Verbose "`nRestarting WMI and setting to automatic startup.. "
    Set-Service -DisplayName 'Windows Management Instrumentation' -StartupType Automatic
    Start-Service -Name Winmgmt
    $WMI = Get-Service -Name Winmgmt

    Write-Output "Windows Management Instrumentation is: " $WMI.Status

    if ($WMI.Status -eq 'Running') {

        Set-Service -DisplayName 'SMS Agent Host' -StartupType Automatic
        Start-Service -DisplayName 'SMS Agent Host'
        Get-Service -DisplayName 'SMS Agent Host' 
        }

        Write-Output "Please restart your computer and wait 5 - 10 minutes before doing anything else."
        Restart-Computer -Delay 60 
        Write-Output "After 5-10 minutes, open a cmd prompt window and enter gpupdate / force"

        }

    else {
        Write-Output "Confirm all services are running"
    }

else {
    Write-Output "Please confirm all services are running"
}
