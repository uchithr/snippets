@echo on
net localgroup users %username% /add
net localgroup "Remote Desktop Users" %username% /add
net localgroup users
net localgroup administrators
net localgroup "Remote Desktop Users"
mmc compmgmt.msc
pause