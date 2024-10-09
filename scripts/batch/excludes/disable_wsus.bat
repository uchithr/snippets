@echo off
:: Disable WSUS server usage for Windows Updates

echo Modifying the registry to set UseWUServer to 0...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v UseWUServer /t REG_DWORD /d 0 /f

if %errorlevel%==0 (
    echo Registry modification successful!
) else (
    echo Failed to modify the registry.
)

:: Restart the Windows Update service for the changes to take effect
echo Restarting Windows Update service...
net stop wuauserv
net start wuauserv

echo Done.
pause