#It kinda works but you need to manually enter URLs still so kind of not really useful *yet
#Started working on 3/16/23

#This is where all the files will be downloaded to
$DownloadDirectory = 'C:\users\%username%\Downloads\BiosUpdates' #update for you

#Will need to be updated to scrape for most recent version.. 
$UrlList = @(
      'https://dl.dell.com/FOLDER09256210M/1/Latitude_5X91_Precision_3530_1.25.0.exe' 
      'https://dl.dell.com/FOLDER09387440M/1/Latitude_5X01_Precision_3541_1.24.0.exe' 
      'https://dl.dell.com/FOLDER09052387M/1/Latitude_5X11_Precision_3551_1.18.0.exe'
      'https://dl.dell.com/FOLDER09558432M/1/Precision_3561_Latitude_5521_1.20.0.exe'
      'https://dl.dell.com/FOLDER09579373M/1/Precision_3571_Latitude_5531_1.12.0.exe'
      'https://dl.dell.com/FOLDER09581651M/1/Precision_5470_1_11_0.exe'
      )

# File Downloader
Foreach ($Url in $UrlList) {
    Start-BitsTransfer -Source $Url -Destination $DownloadDirectory
}

#Unblock multiple files at once 
dir $DownloadDirectory\*exe* | Unblock-File 

#Rename Files to correct naming scheme (Will need to figure out) 
#Rename-Item etc


