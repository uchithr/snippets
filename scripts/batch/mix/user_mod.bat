@echo on
net localgroup users  %username% /add
net localgroup administrators  %username% /delete
net localgroup users
net localgroup administrators
mmc compmgmt.msc
pause 
