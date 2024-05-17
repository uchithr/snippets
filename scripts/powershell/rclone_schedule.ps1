$taskName = "Rclone Copy Task"
$rclonePath = "C:\Program Files\cmd_prg\rclone.exe"
$copyArgs = "copy -P cmod:/[deluge]/mvs/sw/ot C:\Users\uchithr\Downloads\DONE\[sort]\sw --transfers 1 --bwlimit 1M"
$limitedCopyArgs = "copy -P cmod:/[deluge]/mvs/sw/ot C:\Users\uchithr\Downloads\DONE\[sort]\sw --transfers 1 --bwlimit 100k"
$rcloneAction = New-ScheduledTaskAction -Execute $rclonePath -Argument $copyArgs
$rcloneTrigger = New-ScheduledTaskTrigger -Daily -At "7:20AM"
$rcloneSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$deadline = (Get-Date).Date.AddHours(7).AddMinutes(45)
$limitedAction = New-ScheduledTaskAction -Execute $rclonePath -Argument $limitedCopyArgs
$limitedTrigger = New-ScheduledTaskTrigger -Once -At $deadline
$limitedSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$limitedTaskName = "$taskName Limited Bandwidth"
$limitedTaskDescription = "Limit Rclone bandwidth to 100k if not completed by 7:45 AM"
Register-ScheduledTask -TaskName $taskName -Action $rcloneAction -Trigger $rcloneTrigger -Settings $rcloneSettings
Register-ScheduledTask -TaskName $limitedTaskName -Action $limitedAction -Trigger $limitedTrigger -Settings $limitedSettings -Description $limitedTaskDescription














## C:\Program Files\cmd_prg\rclone.exe