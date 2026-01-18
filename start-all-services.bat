@echo off
echo ========================================
echo   ReliefChain - Complete Service Startup
echo ========================================
echo.

echo Checking if services are already running...
echo.

echo Step 1: Starting Hardhat Blockchain Node...
echo ==========================================
cd blockchain
echo Starting local blockchain network...
start "Hardhat Node" cmd /k "npx hardhat node"
echo ✅ Hardhat node starting in new window
echo ⏳ Waiting 10 seconds for blockchain to initialize...
timeout /t 10 /nobreak >nul
echo.

echo Step 2: Deploying Smart Contract...
echo ===================================
echo Deploying DisasterReliefToken contract...
call npx hardhat run scripts/deploy.js --network localhost
if errorlevel 1 (
    echo ❌ Contract deployment failed
    echo Trying alternative deployment...
    call node scripts/deploy.js
)
echo ✅ Smart contract deployed
echo.

echo Step 3: Starting Backend Server...
echo ==================================
cd ../backend
echo Installing/updating dependencies...
call npm install
echo Starting backend server...
start "Backend Server" cmd /k "npm run dev"
echo ✅ Backend server starting in new window
echo ⏳ Waiting 5 seconds for backend to initialize...
timeout /t 5 /nobreak >nul
echo.

echo Step 4: Starting Frontend Application...
echo ========================================
cd ../frontend
echo Installing/updating dependencies...
call npm install
echo Starting frontend development server...
start "Frontend Server" cmd /k "npm start"
echo ✅ Frontend server starting in new window
echo ⏳ Waiting 10 seconds for frontend to initialize...
timeout /t 10 /nobreak >nul
echo.

echo Step 5: Opening Application...
echo ==============================
echo Opening ReliefChain in your default browser...
start http://localhost:3000
echo.

echo ========================================
echo   🚀 ALL SERVICES STARTED SUCCESSFULLY!
echo ========================================
echo.
echo Services Running:
echo 🔗 Blockchain: http://127.0.0.1:8545 (Hardhat Node)
echo 🖥️  Backend:    http://localhost:3001 (API Server)
echo 🌐 Frontend:   http://localhost:3000 (React App)
echo.
echo Next Steps:
echo 1. Connect MetaMask to localhost:8545
echo 2. Import Hardhat test account
echo 3. Test the application
echo.
echo If you see "authentication nonce" errors:
echo 1. Make sure all 3 services are running
echo 2. Check that smart contract is deployed
echo 3. Verify MetaMask is connected to localhost:8545
echo.
echo Troubleshooting:
echo - If services fail to start, run troubleshoot.bat
echo - Check console logs in each service window
echo - Ensure ports 3000, 3001, 8545 are available
echo.
pause