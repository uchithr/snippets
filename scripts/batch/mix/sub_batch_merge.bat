REM RUN THE SCRIPT NAME IN CMD
@echo off
for %%A in (*.mkv) do (
    mkvmerge -o "output\%%~nA.mkv" "%%A" "%%~nA.srt"
)
echo Done!
