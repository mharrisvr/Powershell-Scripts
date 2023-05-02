#The purpose of this is to Filter the contents of a JSON file provided by AWS (Would evenually like to add invoke-request to download file directly so it's always up to date). 
# https://ip-ranges.amazonaws.com/ip-ranges.json
# https://docs.aws.amazon.com/general/latest/gr/aws-ip-ranges.html#filter-json-file
# Currently works for what I need to find though... 

$ipranges = Get-content -Path C:\users\$username%\desktop\ip-ranges.json 

$GovWestRange = Get-AWSPublicIpAddressRange -Region us-gov-west-1 | where {$_.IpAddressFormat -eq "Ipv4"} | select IpPrefix, Region

#$GovWestRange.count 
$GovWestRange | Sort IpPrefix | Out-file C:\users\%username%\desktop\TakAWS-IP-Ranges.$(get-date -Format "MM-dd-yyyy").csv


#Unfinished part pf the script... Want to add in comparison to only Grab X.X.0.0 from Both lists and compare.. 

$CSVFilename = Import-Csv -Path C:\users\$username%\desktop\filename.csv 
  $AWSRanges = $GovWestRange.IpPrefix | sort
  $SeenRanges = $CSVFilename.IP | sort

    $AWSRanges
    Write-Host "------------------------------"
    $SeenRanges
