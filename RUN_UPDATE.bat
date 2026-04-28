@echo off
title Auto Update and Publish
echo Updating data files...
powershell -ExecutionPolicy Bypass -File update_news.ps1
powershell -ExecutionPolicy Bypass -File update_visit_places.ps1
powershell -ExecutionPolicy Bypass -File update_history.ps1

echo.
echo Automating Github Publish...
set "GIT_PATH=C:\Program Files\Git\cmd\git.exe"

if not exist "%GIT_PATH%" (
    echo Git could not be found at %GIT_PATH%. 
    echo Please install Git from https://git-scm.com/
    pause
    exit /b
)

"%GIT_PATH%" add .
"%GIT_PATH%" commit -m "Auto Update: Publish new content"

rem Fetch the latest changes
"%GIT_PATH%" fetch origin main

rem Try pulling and automatically merging any manual edits on GitHub (autostash helps with dirty tree issues)
"%GIT_PATH%" pull origin main --rebase --autostash

rem Push the changes
"%GIT_PATH%" push origin main

echo.
echo Done! Your website has been successfully published to GitHub.
pause
