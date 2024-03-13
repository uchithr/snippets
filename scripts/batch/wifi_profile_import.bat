@echo off

echo ## Deleting CRYSTAL-MARTIN ##
netsh wlan delete profile name="CRYSTAL-MARTIN"


echo ## Adding Wi-Fi profile... ##
netsh wlan add profile filename = "\\someweb\zwi\CM.xml"


pause
