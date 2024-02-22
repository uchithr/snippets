################################################################################################################################################################################################
ALLOW SCRIPTS
################################################################################################################################################################################################



# run this comman in powershell admin mode

set-executionpolicy remotesigned


# to unrestricted
Set-ExecutionPolicy unrestricted


Add-MpPreference -ExclusionPath "C:\Program Files (x86)\Bandicam"



#####################################################################################################################################

# Add exclusions
# add a path to exclusion list
Add-MpPreference -ExclusionPath E:\CPP
# add a process to exclusion list
Add-MpPreference -ExclusionProcess "C:\Program Files (x86)\FindAndRunRobot\FindAndRunRobot.exe"
# add an extension to exclusion list
Add-MpPreference -ExclusionExtension ".jpg"

# Remove exclusions
# remove a path from exclusion list
Remove-MpPreference -ExclusionPath E:\CPP
# remove a process from exclusion list
Remove-MpPreference -ExclusionProcess "C:\Program Files (x86)\FindAndRunRobot\FindAndRunRobot.exe"
# remove an extension from exclusion list
Remove-MpPreference -ExclusionExtension ".jpg"

# Display exclusions
Get-MpPreference | Select-Object ExclusionProcess
Get-MpPreference | Select-Object ExclusionPath
Get-MpPreference | Select-Object ExclusionExtension


#####################################################################################################################################
