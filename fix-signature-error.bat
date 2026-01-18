@echo off
echo ========================================
echo   Fix "Failed to Verify Signature" Error
echo ========================================
echo.

echo This error occurs when MetaMask signature verification fails.
echo Let's fix this step by step.
echo.

echo Step 1: Checking if all services are running...
echo =============================================
netstat -an | findstr :8545 >nul && echo ✅ Blockchain running (port 8545) || echo ❌ Blockchain not running
netstat -an | findstr :3001 >nul && echo ✅ Backend running (port 3001) || echo ❌ Backend not running
netstat -an | findstr :3000 >nul && echo ✅ Frontend running (port 3000) || echo ❌ Frontend not running
echo.

echo Step 2: MetaMask Network Configuration
echo ======================================
echo.
echo 📋 METAMASK SETUP CHECKLIST:
echo.
echo 1. Open MetaMask extension
echo 2. Click network dropdown (top center)
echo 3. Select "Add Network" or "Custom RPC"
echo 4. Enter EXACTLY these details:
echo.
echo    Network Name: Hardhat Local
echo    RPC URL: http://127.0.0.1:8545
echo    Chain ID: 31337
echo    Currency Symbol: ETH
echo    Block Explorer: (leave empty)
echo.
echo 5. Click "Save" and switch to this network
echo.

echo Step 3: Import Hardhat Test Account
echo ====================================
echo.
echo 1. In MetaMask, click account icon (top right)
echo 2. Select "Import Account"
echo 3. Copy and paste this EXACT private key:
echo.
echo    0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
echo.
echo 4. Click "Import"
echo 5. You should see ~10000 ETH balance
echo.

echo Step 4: Clear Browser Data (Important!)
echo ========================================
echo.
echo 1. Open browser settings (Ctrl+Shift+Delete)
echo 2. Select "All time" for time range
echo 3. Check these boxes:
echo    ✅ Cookies and other site data
echo    ✅ Cached images and files
echo    ✅ Site settings
echo 4. Click "Clear data"
echo.
echo OR use incognito/private browsing mode
echo.

echo Step 5: Refresh and Reconnect
echo ==============================
echo.
echo 1. Go to http://localhost:3000
echo 2. Hard refresh (Ctrl+F5)
echo 3. Click "Connect Wallet" button
echo 4. Select MetaMask
echo 5. Approve the connection
echo.

echo Step 6: Common Signature Issues & Fixes
echo =========================================
echo.
echo ❌ ISSUE: "Failed to verify signature"
echo ✅ FIX: Make sure you're using the correct account
echo.
echo ❌ ISSUE: "Wrong network"
echo ✅ FIX: Switch to Hardhat Local (Chain ID 31337)
echo.
echo ❌ ISSUE: "Insufficient funds"
echo ✅ FIX: Import the Hardhat test account with 10000 ETH
echo.
echo ❌ ISSUE: "Nonce too high/low"
echo ✅ FIX: Reset MetaMask account (Settings > Advanced > Reset Account)
echo.
echo ❌ ISSUE: "Contract not found"
echo ✅ FIX: Make sure smart contract is deployed (check console)
echo.

echo Step 7: Advanced Troubleshooting
echo =================================
echo.
echo If you still get signature errors:
echo.
echo 1. Reset MetaMask Account:
echo    - MetaMask Settings > Advanced > Reset Account
echo    - This clears transaction history and nonces
echo.
echo 2. Check Browser Console (F12):
echo    - Look for specific error messages
echo    - Check if contract address is correct
echo.
echo 3. Verify Contract Deployment:
echo    - Contract should be at: 0x5FbDB2315678afecb367f032d93F642f64180aa3
echo    - Check backend logs for deployment confirmation
echo.
echo 4. Try Different Browser:
echo    - Use Chrome/Firefox incognito mode
echo    - Disable other wallet extensions
echo.

echo Step 8: Testing the Fix
echo =======================
echo.
echo 1. Open http://localhost:3000
echo 2. Connect MetaMask wallet
echo 3. Try to register as a donor/beneficiary/vendor
echo 4. If signature works, you should see success message
echo.

echo ========================================
echo   🎯 SIGNATURE ERROR FIX COMPLETE
echo ========================================
echo.
echo If you're still having issues:
echo.
echo 🔧 Quick Reset Commands:
echo 1. Reset MetaMask: Settings > Advanced > Reset Account
echo 2. Clear browser: Ctrl+Shift+Delete > Clear all data
echo 3. Restart services: run start-all-services.bat
echo.
echo 📞 Common Solutions:
echo • Use the EXACT private key provided above
echo • Make sure Chain ID is 31337 (not 1337 or other)
echo • Use http://127.0.0.1:8545 (not localhost:8545)
echo • Clear all browser data and cookies
echo • Try incognito/private browsing mode
echo.
echo Your MetaMask should now work with ReliefChain! 🚀
echo.
pause