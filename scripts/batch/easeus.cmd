@echo off
set ver=v5.3
title EaseUS BLOCKING
fltmc >nul 2>&1 || (
  echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\GetAdmin.vbs"
  echo UAC.ShellExecute "%~fs0", "", "", "runas", 1 >> "%temp%\GetAdmin.vbs"
  cmd /u /c type "%temp%\GetAdmin.vbs">"%temp%\GetAdminUnicode.vbs"
  cscript //nologo "%temp%\GetAdminUnicode.vbs"
  del /f /q "%temp%\GetAdmin.vbs" >nul 2>&1
  del /f /q "%temp%\GetAdminUnicode.vbs" >nul 2>&1
  exit
)

@echo off
SET hosts=%windir%\system32\drivers\etc\hosts
attrib -r %hosts%
echo. >>%hosts%
FOR %%A IN (

activation.easeus.com
track.easeus.com
easeus.com 
update.easeus.com


) DO (
 echo 0.0.0.0 %%A >>%hosts%
)
attrib +r %hosts%
echo Successfully added entries

@echo off
netsh advfirewall firewall add rule name="DRW.exe" dir=out program="C:\Program Files\EaseUS\EaseUS Data Recovery Wizard\DRW.exe" action=block

netsh advfirewall firewall add rule name="DRWUI.exe" dir=out program="C:\Program Files\EaseUS\EaseUS Data Recovery Wizard\DRWUI.exe" action=block
echo Successfully Blocked Programs 





