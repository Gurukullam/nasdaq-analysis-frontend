@echo off
chcp 65001 >nul
echo ==========================================
echo  NASDAQ Analysis AI — Frontend Deployer
echo  Target: GitHub Pages
echo ==========================================
echo.

REM Check if git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Git not found. Please install Git first:
    echo    https://git-scm.com/download/win
    pause
    exit /b 1
)

echo ✅ Git found
echo.

set /p GITHUB_USER="Enter your GitHub username: "
set /p REPO_NAME="Enter repository name (e.g., nasdaq-analysis-frontend): "

echo.
echo 🔧 Setting up GitHub repository...
echo.

cd /d "%~dp0"

REM Initialize git if not already
git init

git add .
git commit -m "Phase 1: NASDAQ Analysis AI Frontend"
git branch -M main

echo.
echo 🔗 Linking to GitHub...
git remote add origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git 2>nul
git remote set-url origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git

git push -u origin main

echo.
echo ==========================================
echo ✅ Frontend pushed to GitHub!
echo.
echo 📋 NEXT STEPS:
echo    1. Go to https://github.com/%GITHUB_USER%/%REPO_NAME%/settings/pages
echo    2. Under "Source", select "Deploy from a branch"
echo    3. Select "main" branch and "/ (root)" folder
echo    4. Click "Save"
echo    5. Wait 1-2 minutes
echo    6. Visit: https://%GITHUB_USER%.github.io/%REPO_NAME%/
echo.
echo 💡 Don't forget to paste your Vercel backend URL in the app Settings!
echo ==========================================
pause