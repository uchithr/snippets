@echo off
REM Prompt the user to enter the destination path
SET /P destination="Please enter the destination folder path: "

SET userprofile=%USERPROFILE%

REM Create the destination folders if they don't exist
IF NOT EXIST "%destination%\Desktop" mkdir "%destination%\Desktop"
IF NOT EXIST "%destination%\Documents" mkdir "%destination%\Documents"
IF NOT EXIST "%destination%\Downloads" mkdir "%destination%\Downloads"
IF NOT EXIST "%destination%\Pictures" mkdir "%destination%\Pictures"

REM Copy the folders
xcopy /e /i /y "%userprofile%\Desktop" "%destination%\Desktop"
xcopy /e /i /y "%userprofile%\Documents" "%destination%\Documents"
xcopy /e /i /y "%userprofile%\Downloads" "%destination%\Downloads"
xcopy /e /i /y "%userprofile%\Pictures" "%destination%\Pictures"

echo Backup completed.
pause
