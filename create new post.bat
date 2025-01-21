@echo off
:: Step 1: Ask if images are required for the article
set /p IMAGES_REQUIRED="Do you need to add images to this article? (y/n): "

:: Step 2: Ask for the article name
set /p ARTICLE_NAME="Enter the article name (Ex: test article): "

:: Step 3: Replace spaces with hyphens to create a slug-friendly directory and filename
for /f "tokens=* delims=" %%A in ('powershell -Command "'%ARTICLE_NAME%' -replace ' ', '-'"') do set POST_SLUG=%%A

:: Step 4: Check if images are required
if /i "%IMAGES_REQUIRED%"=="y" (
    :: Create a folder for the article and images
    set POST_DIR=content\posts\%POST_SLUG%
    if not "%POST_DIR%"=="" (
        powershell -Command "New-Item -Path '%POST_DIR%' -ItemType Directory -Force > $null 2>&1"
        powershell -Command "New-Item -Path '%POST_DIR%\images' -ItemType Directory -Force > $null 2>&1"
    )
    :: Create the index.md file in the folder
    powershell -Command "hugo new content/posts/%POST_SLUG%/index.md"
) else (
    :: Directly create the index.md file in content/posts with no additional folders
    powershell -Command "hugo new content/posts/%POST_SLUG%.md"
    set POST_DIR=content\posts
)

:: Debugging: Uncomment the next line to log the directory being created
:: echo Debug: POST_DIR=%POST_DIR%

:: Step 5: Determine the file path of the created file
if /i "%IMAGES_REQUIRED%"=="y" (
    set FILE_PATH=%POST_DIR%\index.md
) else (
    set FILE_PATH=%POST_DIR%\%POST_SLUG%.md
)

:: Step 6: Ask if the user wants to open the created file
set /p OPEN_FILE="Do you want to open the file? (y/n): "
if /i "%OPEN_FILE%"=="y" (
    start code "%FILE_PATH%"
)

:: Step 7: Exit the batch script without any prompts
exit 0
