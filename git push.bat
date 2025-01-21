@echo off
:: Batch script to add, commit, and push changes to Git

:: Prompt for commit message (default to 'default commit' if not provided)
set /p commitMsg="Enter commit message (leave blank for 'default commit'): "
if "%commitMsg%"=="" set commitMsg=default commit

:: Navigate to the desired Git repository folder
:: Uncomment and specify your repository folder path
:: cd /d C:\path\to\your\repository

:: Run Git commands
git add .
git commit -m "%commitMsg%"
git push -u origin main

:: Display success message and close
echo Changes pushed successfully!
exit