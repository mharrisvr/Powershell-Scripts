# ========================================================================================================#
# Gets names & IPs of each printer installed to computer and pings to see if printer is active / online.  #
# I don't remember why I needed this..                                                                    #
#=========================================================================================================#

$Printers = Get-Printer | select Name, portname

for($i=0; $i -le $Printers.count; $i++) {

    $Count = $Printers.Count
    Write-Progress -Activity "Counting 1 to '$Count'"
    
    foreach ($Printer in $Printers) {
        ping $Printer.portname
    }
}
