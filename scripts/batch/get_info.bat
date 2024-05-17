@echo off

REM Display the local administrator name and computer hostname
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" /v ComputerName

rem Get the installed ESET Endpoint Security version
reg query "HKLM\SOFTWARE\ESET\ESET Security\CurrentVersion\Info" /v ProductVersion

rem Get the registry key
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v WUserver

rem Get the registry key
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v WUStatusServer

pause