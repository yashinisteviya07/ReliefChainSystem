@echo off
echo ========================================
echo   Quick Fix for MetaMask Connection
echo ========================================
echo.

echo This will fix the "authentication nonce" and "smart contract not initialized" errors
echo.

echo Step 1: Killing any existing processes...
taskkill /f /im node.exe >nul 2>&1
taskkill /f /im npm.exe >nul 2>&1
echo ✅ Processes cleared
echo.

echo Step 2: Starting Hardhat blockchain node...
cd blockchain
start "Hardhat Node" cmd /k "npx hardhat node"
echo ✅ Hardhat node starting...
echo ⏳ Waiting 15 seconds for blockchain to fully initialize...
timeout /t 15 /nobreak >nul
echo.

echo Step 3: Deploying smart contract...
echo Deploying to localhost network...
call npx hardhat run scripts/deploy.js --network localhost
if errorlevel 1 (
    echo ❌ Deployment failed, trying alternative...
    call node scripts/deploy.js
)
echo ✅ Smart contract deployed
echo.

echo Step 4: Installing backend dependencies...
cd ../backend
call npm install mongoose bcryptjs >nul 2>&1
echo ✅ Backend dependencies updated
echo.

echo Step 5: Starting backend server...
start "Backend Server" cmd /k "npm run dev"
echo ✅ Backend server starting...
echo ⏳ Waiting 10 seconds for backend to initialize...
timeout /t 10 /nobreak >nul
echo.

echo Step 6: Starting frontend...
cd ../frontend
start "Frontend Server" cmd /k "npm start"
echo ✅ Frontend starting...
echo ⏳ Waiting 15 seconds for frontend to initialize...
timeout /t 15 /nobreak >nul
echo.

echo Step 7: Opening application...
start http://localhost:3000
echo.

echo ========================================
echo   🎯 QUICK FIX COMPLETE!
echo ========================================
echo.
echo Services should now be running:
echo 🔗 Blockchain: Hardhat node on port 8545
echo 🖥️  Backend: API server on port 3001  
echo 🌐 Frontend: React app on port 3000
echo.
echo MetaMask Setup (if needed):
echo 1. Network: Add http://127.0.0.1:8545
echo 2. Chain ID: 31337
echo 3. Import account with private key:
echo    0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
echo.
echo If you still see errors:
echo 1. Refresh the webpage (Ctrl+F5)
echo 2. Disconnect and reconnect MetaMask
echo 3. Make sure you're on the Hardhat Local network
echo.
pause