#Script to uninstall and -reinstall the AutoDesk ODIS application. 
#Instructions from: https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Install-error-AutoCAD-2023-The-install-couldn-t-finish-Error-4005-when-installing-AutoCAD-based-2023-products.html

#Delete contents of all folders
$FolderList = @(
    "C:\Autodesk\WI\"
    "C:\Users\$($Env:USERNAME)\Local\Autodesk\ODIS\"
)

Foreach ($Folder in $FolderList) {
    Remove-Item $Folder -Recurse -Force
}

Stop-Service -Name "Autodesk Access Service Host"

#Start "RemoveODIS.exe" as admin (right click > run as administrator) if it exists. Otherwise, remove manually all the content in the folder.
Invoke-Item -Path C:\ProgramFiles\AutoDesk\AdODIS\V1\RemoveODIS.exe

#Download and install the latest version of the Autodesk On-Demand Install Service (ODIS)
Start-BitsTransfer -Source "https://emsfs.autodesk.com/utility/odis/1/installer/latest/AdODIS-installer.exe" -Destination "C:\users\$($Env:USERNAME)\downloads"

#Run again the Autodesk product install.
Invoke-Item -Path C:\users\$($Env:USERNAME)\downloads\AdODIS-installer.exe 
