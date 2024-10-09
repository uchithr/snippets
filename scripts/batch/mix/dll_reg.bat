@ECHO ON

ROBOCOPY \\slktswd1\software\VSF_GRID\Vs20000318\ C:\windows\syswow64
ROBOCOPY \\slktswd1\software\VSF_GRID\FM20dll Files\FM20_64\SysWow C:\windows\syswow64

Regsvr32 C:\Windows\SysWOW64\VSFLEX7.OCX
Regsvr32 C:\Windows\SysWOW64\VSFLEX7D.OCX
Regsvr32 C:\Windows\SysWOW64\VSFLEX7L.OCX
Regsvr32 C:\Windows\SysWOW64\VSFLEX7N.OCX
Regsvr32 C:\Windows\SysWOW64\VSFLEX7U.OCX
Regsvr32 C:\Windows\SysWOW64\FM20.DLL
Regsvr32 C:\Windows\SysWOW64\FM20.ocx
Regsvr32 C:\Windows\SysWOW64\FM20ENU.DLL

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Fixed Assets.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "\\slktfileserver1\FixedAssetsINV\FixedAssets.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%

ECHO "Completed"


cd C:\Windows\SysWOW64\ && Regsvr32 VSFLEX7.OCX
cd C:\Windows\SysWOW64\ && Regsvr32 FM20.DLL
