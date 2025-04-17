@echo off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer" /v DisableUserInstalls /t REG_DWORD /d 1 /f
pause


REM Explanation of each option:
REM reg add: Adds a registry entry.
REM "HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer": The registry path.
REM /v DisableUserInstalls: Specifies the value name (DisableUserInstalls).
REM /t REG_DWORD: Specifies the type of the value (REG_DWORD, which is a 32-bit integer).
REM /d 1: Specifies the data for the value (1 means 'disabled', 0 means 'enabled').
REM /f: Forces overwriting the existing value without confirmation.