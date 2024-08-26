@echo off
setlocal enabledelayedexpansion

echo Step 1: Navigating to the Flutter app directory...
cd ..\q-yaar-app\
if %ERRORLEVEL% neq 0 (
    echo Error: Failed to navigate to the Flutter app directory
    exit /b 1
)
echo Successfully navigated to the Flutter app directory.

echo Step 2: Building Flutter web app...
call flutter build web --release
if %ERRORLEVEL% neq 0 (
    echo Error: Flutter web build failed
    exit /b 1
)
echo Flutter web build completed successfully.

echo Step 3: Copying build files to deployment repository...
xcopy /E /I /Y .\build\web\* ..\q-yaar-deployment\
if %ERRORLEVEL% neq 0 (
    echo Error: Failed to copy build files to deployment repository
    exit /b 1
)
echo Successfully copied build files to deployment repository.

echo Step 4: Committing changes in deployment repository...
cd ..\q-yaar-deployment\
git add .
git commit -m "Update web app deployment - %date% %time%"
if %ERRORLEVEL% neq 0 (
    echo Error: Git commit failed
    exit /b 1
)
echo Successfully committed changes.

echo Step 5: Pushing changes to main branch...
git push origin main
if %ERRORLEVEL% neq 0 (
    echo Error: Git push failed
    exit /b 1
)
echo Successfully pushed changes to main branch.

echo Deployment process completed successfully!
exit /b 0

:end
endlocal