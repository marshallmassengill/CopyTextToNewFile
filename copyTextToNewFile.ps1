#Input a file name
[CmdletBinding()]
param (
	[string] $file = $null
)

#Set the file as a file system object
$fileToCopy = Get-Item $file

#Get the full path of the parent directory
$folderPath = Split-Path $fileToCopy.fullname -parent

#Get just the name of the file
$fileName = $fileToCopy.name

#Set a name for a temporary file
$outputFile = '{0}\{1}' -f $folderPath, "temp.foobar"

#Get the content of the file
$Content = (Get-Content $fileToCopy -Raw)

#Write the contents to the temp file
Set-Content -Path $outputFile -Value $Content

#Create a file system object for the temporary file
$newFile = Get-Item $outputFile

#Delete the Original
Remove-Item $fileToCopy

#Rename the temp file
Rename-Item $newFile $fileName

#Windows Registry Editor Version 5.00
#
#[HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\MyScript1]
#@="Copy text to new file"
#
#[HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\MyScript1\command]
#@="C:\\Windows\\system32\\WindowsPowerShell\\v1.0\\powershell.exe -NoExit -command "C:\scripts\copyTextToNewFile.ps1 '%1'""