@echo off
echo ========================================
echo   MetaMask Connection Fix Script
echo ========================================
echo.

echo This script will help fix MetaMask connection issues
echo.

echo Step 1: Checking if Hardhat node is running...
echo ==============================================
netstat -an | findstr :8545 >nul
if errorlevel 1 (
    echo ❌ Hardhat node is not running on port 8545
    echo Starting Hardhat node...
    cd blockchain
    start "Hardhat Node" cmd /k "npx hardhat node"
    echo ✅ Hardhat node started
    echo ⏳ Waiting 10 seconds for initialization...
    timeout /t 10 /nobreak >nul
    cd ..
) else (
    echo ✅ Hardhat node is running on port 8545
)
echo.

echo Step 2: Deploying/Redeploying Smart Contract...
echo ===============================================
cd blockchain
echo Deploying contract to localhost network...
call npx hardhat run scripts/deploy.js --network localhost
if errorlevel 1 (
    echo ❌ Deployment failed, trying alternative method...
    call node scripts/deploy.js
)
echo ✅ Contract deployment completed
cd ..
echo.

echo Step 3: Checking Backend Service...
echo ===================================
netstat -an | findstr :3001 >nul
if errorlevel 1 (
    echo ❌ Backend is not running on port 3001
    echo Starting backend service...
    cd backend
    start "Backend Server" cmd /k "npm run dev"
    echo ✅ Backend service started
    echo ⏳ Waiting 5 seconds for initialization...
    timeout /t 5 /nobreak >nul
    cd ..
) else (
    echo ✅ Backend service is running on port 3001
)
echo.

echo Step 4: MetaMask Configuration Instructions...
echo =============================================
echo.
echo 📋 METAMASK SETUP INSTRUCTIONS:
echo.
echo 1. Open MetaMask extension
echo 2. Click on network dropdown (top center)
echo 3. Click "Add Network" or "Custom RPC"
echo 4. Enter these details:
echo    Network Name: Hardhat Local
echo    RPC URL: http://127.0.0.1:8545
echo    Chain ID: 31337
echo    Currency Symbol: ETH
echo 5. Click "Save"
echo.
echo 6. Import Hardhat Test Account:
echo    - Click account icon (top right)
echo    - Select "Import Account"
echo    - Paste this private key:
echo    0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
echo    - Click "Import"
echo.
echo 7. You should now see ~10000 ETH in your account
echo.

echo Step 5: Testing Connection...
echo =============================
echo Opening test page to verify MetaMask connection...
start http://localhost:3000
echo.
echo If you still see "Failed to generate authentication nonce":
echo.
echo 🔧 TROUBLESHOOTING STEPS:
echo.
echo 1. Refresh the webpage (Ctrl+F5)
echo 2. Disconnect and reconnect MetaMask
echo 3. Make sure you're on the "Hardhat Local" network
echo 4. Check that you have ETH in your account
echo 5. Open browser console (F12) to see detailed errors
echo.
echo 6. If contract is not initialized:
echo    - Make sure Hardhat node is running
echo    - Redeploy contract: cd blockchain && npx hardhat run scripts/deploy.js --network localhost
echo    - Restart backend: cd backend && npm run dev
echo.
echo 7. Common fixes:
echo    - Clear browser cache and cookies
echo    - Disable other wallet extensions
echo    - Try in incognito/private browsing mode
echo.

echo Step 6: Service Status Check...
echo ===============================
echo Checking all required services...
echo.
echo 🔗 Blockchain (Port 8545):
netstat -an | findstr :8545 >nul && echo ✅ Running || echo ❌ Not running

echo 🖥️  Backend (Port 3001):
netstat -an | findstr :3001 >nul && echo ✅ Running || echo ❌ Not running

echo 🌐 Frontend (Port 3000):
netstat -an | findstr :3000 >nul && echo ✅ Running || echo ❌ Not running
echo.

echo ========================================
echo   🎯 METAMASK FIX COMPLETE
echo ========================================
echo.
echo If you're still having issues:
echo 1. Run troubleshoot.bat for detailed diagnostics
echo 2. Check the console logs in each service window
echo 3. Verify MetaMask is connected to http://127.0.0.1:8545
echo 4. Ensure you have the Hardhat test account imported
echo.
echo Your application should now work with MetaMask!
echo.
pause