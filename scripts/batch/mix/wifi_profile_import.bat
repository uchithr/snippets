@echo off


echo ## Copying NEW Wi-Fi profile... ##
xcopy "\\CMSLWEB\Chathuranga-IT\zwi\CM.xml" "C:\Users"


echo ## Deleting OLD CRYSTAL-MARTIN ##
netsh wlan delete profile name="CRYSTAL-MARTIN"


echo ## Adding NEW Wi-Fi profile... ##
netsh wlan add profile filename = "C:\Users\CM.xml"


echo ## Deleting local file... ##
del "C:\Users\CM.xml"

pause