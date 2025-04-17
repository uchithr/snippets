md G:\Daily_Backups\Development_Server\DB_Backup

XCOPY \\192.168.48.11\d$\DBBackups\*.* G:\Daily_Backups\Development_Server\DB_Backup /d/e/y 

Pause


:: Development_Server_TFS_Backup::

md G:\Daily_Backups\Development_Server\TFSBackup

XCOPY \\192.168.48.11\d$\TFSBackup\*.* G:\Daily_Backups\Development_Server\TFSBackup /d/e/y 

Pause

::###############################

md G:\Daily_Backups\TallyInterim_Eng_Backup

XCOPY \\192.168.52.12\d$\DB_Backup\EIE\TallyInterim\*.* G:\Daily_Backups\TallyInterim_Eng_Backup /d/e/y 

Pause


::###############################

md G:\Daily_Backups\Exper_tec_Eng_Backup\DB_Backups

XCOPY \\192.168.52.12\d$\DB_Backup\EIE\Expertec\*.* G:\Daily_Backups\Exper_tec_Eng_Backup\DB_Backups /d/e/y

Pause

::###############################

md G:\Daily_Backups\ExpoNet_Eng_Backup\DB_Backups

XCOPY \\192.168.52.12\d$\DB_Backup\EIE\Exponet\*.* G:\Daily_Backups\ExpoNet_Eng_Backup\DB_Backups /d/e/y 

Pause

::###############################

md G:\Daily_Backups\ExpoNet_Eng_Backup\Exponet_Documents\Content
md G:\Daily_Backups\ExpoNet_Eng_Backup\Exponet_Service\Document

XCOPY \\192.168.49.104\d$\ExponetDocuments\ExponetDocumentService\ExponetDocuments\Content\*.* G:\Daily_Backups\ExpoNet_Eng_Backup\Exponet_Documents\Content  /d/e/y 

XCOPY \\192.168.49.104\d$\ExponetService\Documents\*.* G:\Daily_Backups\ExpoNet_Eng_Backup\Exponet_Service\Document /d/e/y

Pause


::###############################


md G:\Daily_Backups\ExpoNet_Eng_Backup\Exponet_Reports

XCOPY \\192.168.49.104\d$\ExpoNetReports\*.* G:\Daily_Backups\ExpoNet_Eng_Backup\Exponet_Reports /d/e/y

Pause

::###############################


md D:\Daily_Backups\S2S_Backups\DB_Backups

XCOPY \\192.168.52.5\D$\DbBackups\S2S_DB_Backups\*.* G:\Daily_Backups\S2S_Backups\DB_Backups /d/e/y 

Pause

::###############################


md G:\Daily_Backups\S2S_Backups\Exponet_Documents\Content
md G:\Daily_Backups\S2S_Backups\Releases\Documents

XCOPY \\192.168.52.5\d$\ExponetDocuments\ExponetDocumentService\ExponetDocuments\Content\*.* G:\Daily_Backups\S2S_Backups\Exponet_Documents\Content /d/e/y 

XCOPY \\192.168.52.5\d$\Releases\Releases\V2.00\ExponetService\Documents\*.* G:\Daily_Backups\S2S_Backups\Releases\Documents /d/e/y

Pause

::###############################

md G:\Daily_Backups\S2S_Backups\Exponet_Reports

XCOPY \\192.168.52.5\d$\ExpoNetReports\*.* G:\Daily_Backups\S2S_Backups\Exponet_Reports /d/e/y

Pause


::###############################

md B:\dailybackup\Tally\TallyBackup

xcopy \\192.168.48.8\d$\*.*  B:\dailybackup\Tally\TallyBackup /d/e/y

Pause

