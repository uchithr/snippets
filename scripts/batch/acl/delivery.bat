@echo off
:: Disable Delivery Optimization

echo Disabling Delivery Optimization...

:: Navigate to Delivery Optimization registry path
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f

echo Delivery Optimization has been disabled.

pause
