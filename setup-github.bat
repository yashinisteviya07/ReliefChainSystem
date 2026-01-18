@echo off
echo ========================================
echo    ReliefChain GitHub Setup Script
echo ========================================
echo.

REM Check if Git is installed
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Git is not installed or not in PATH
    echo.
    echo Please install Git first:
    echo 1. Download from: https://git-scm.com/download/win
    echo 2. Or use winget: winget install --id Git.Git -e --source winget
    echo 3. Restart this script after installation
    echo.
    pause
    exit /b 1
)

echo ✅ Git is installed
echo.

REM Initialize Git repository
echo 🔧 Initializing Git repository...
git init

REM Add all files
echo 📁 Adding all files to Git...
git add .

REM Create initial commit
echo 💾 Creating initial commit...
git commit -m "🚀 Initial commit: ReliefChain - Blockchain Relief Distribution System

✨ Features:
- Complete blockchain-based relief distribution system
- React frontend with Material-UI
- Node.js backend with Express
- Solidity smart contracts with Hardhat
- Weil Chain deployment ready
- Comprehensive KYC validation
- Real-time transparency dashboard
- Multi-role access control (Admin, Donor, Beneficiary, Vendor)

🏆 Built for East India Blockchain Summit 2.0
🔗 Ready for hackathon demonstration"

echo.
echo ✅ Git repository initialized successfully!
echo.
echo 📋 Next Steps:
echo 1. Create a new repository on GitHub.com:
echo    - Go to https://github.com/new
echo    - Repository name: reliefchain
echo    - Description: 🚀 ReliefChain - Blockchain Relief Distribution System
echo    - Set to Public
echo    - Don't initialize with README (we have one)
echo.
echo 2. Add your GitHub repository as remote:
echo    git remote add origin https://github.com/YOUR_USERNAME/reliefchain.git
echo.
echo 3. Push to GitHub:
echo    git branch -M main
echo    git push -u origin main
echo.
echo 📖 For detailed instructions, see: GITHUB_SETUP_GUIDE.md
echo.
pause