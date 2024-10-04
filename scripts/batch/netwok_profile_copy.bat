@echo off
REM Prompt the user to enter the network source path
SET /P source="Please enter the network source path (e.g., \\bob\c$\users\sam): "

SET userprofile=%USERPROFILE%

REM Define the folders to copy
SET folders=Desktop Documents Downloads Pictures

REM Loop through each folder and copy it from the network source to the local profile
for %%F in (%folders%) do (
    REM Check if the source folder exists
    IF EXIST "%source%\%%F" (
        REM Create the local destination folder if it doesn't exist
        IF NOT EXIST "%userprofile%\%%F" mkdir "%userprofile%\%%F"
        
        REM Copy the files from the network location to the local profile
        echo Copying %%F from %source% to %userprofile%\%%F...
        xcopy /e /i /y "%source%\%%F" "%userprofile%\%%F"
    ) ELSE (
        echo Folder %%F does not exist in the source path: %source%
    )
)

echo Copy operation completed.
pause

