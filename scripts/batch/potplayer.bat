@echo off
netsh advfirewall firewall add rule name="PotPlayer In" dir=in action=block program="C:\ProgramFiles\DAUM\PotPlayer\PotPlayerMini64.exe" enable=yes
netsh advfirewall firewall add rule name="PotPlayer Out" dir=out action=block program="C:\ProgramFiles\DAUM\PotPlayer\PotPlayerMini64.exe" enable=yes

:: Run this batch script as administrator
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else (goto gotAdmin)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
