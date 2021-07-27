##========================================================================================================================================##
##                                                                                                                                         ##
## Purpose of this Script: This script will automatically create a new Win10VM, add to Hyper-V / Create new VDH and Mount Various ISO file ##
## Script was re-written to accept CSV input and create multiple VMs at once with various Operating System choices and startup specs.      ##
## Author: Mike Harris                                                                                                                     ##
## Date Written: (Or at least started...) July 1, 2021                                                                                     ##
##                                                                                                                                         ##
##=========================================================================================================================================##

#Initialize VM Creator Array
$vms = @()
$vms = Import-Csv -Path C:\users\admin\desktop\Scripts\vms2create.txt

#Initialize Variables
$LocalVMPath = "H:\Local VMs\$vm.name"
$VHDLocation = "$LocalVMPath\[$vm.name]\[$vm.name].vhdx"

foreach($vm in $vms) {
    
    switch ( $vm.OperatingSystem ) {
        
        #These are hard-coded paths to ISO Files and will need to be updated according to location on other systems. 
        Windows20H2 {$OSPath = "H:\ISO Files\Windows\Windows 10\20H2\Win10_20H2_v2_English_x64.ISO"}
        Windows21H1 {$OSPath = "H:\ISO Files\Windows\Windows 10\21H1\Win10_21H1_English_x64.ISO"}
        Server2016 {}
        Ubuntu16 {$OSPath = "H:\ISO Files\Linux Distros\ubuntu-16.04.3-desktop-amd64 (2018_05_05 14_58_19 UTC).iso"}
        Ubuntu18 {}
        Ubuntu20 {} 
        Kali {$OSPath= "H:\ISO Files\Linux Distros\kali-linux-2016.2-amd64 (2018_05_05 14_58_19 UTC).iso"}
        pfsense {} 
}
    $name = $vm.Name
    New-VM -Name $vm.Name -MemoryStartupBytes $vm.Ram -Path "H:\Local VMs\$name" -NewVHDPath "H:\Local VMs\$name\$name.vhdx" -NewVHDSizeBytes $vm.HDSize 
    Set-VM $vm.name -ProcessorCount 2
    Set-VMDvdDrive -VMName $vm.Name -Path $OSPath #$vm.OperatingSystem
    
    Start-VM -Name $name
    
    Write-Host "Your VM Named: $name is now Starting running OS Version: " $vm.OperatingSystem
    
    }  
