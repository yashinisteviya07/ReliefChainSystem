@echo off
echo ========================================
echo Weil Chain Deployment Script
echo ========================================
echo.

echo Step 1: Checking environment setup...
if not exist "blockchain\.env" (
    echo ERROR: blockchain\.env file not found!
    echo Please copy blockchain\.env.example to blockchain\.env and configure it.
    pause
    exit /b 1
)

echo Step 2: Installing dependencies...
cd blockchain
call npm install
if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo Step 3: Compiling contracts...
call npx hardhat compile
if errorlevel 1 (
    echo ERROR: Contract compilation failed
    pause
    exit /b 1
)

echo.
echo Step 4: Deploying to Weil Chain Testnet...
echo.
echo IMPORTANT: Make sure you have:
echo 1. Added Weil Chain to MetaMask
echo 2. Got test tokens from faucet
echo 3. Configured .env with your private key
echo.
pause

call npx hardhat run scripts/deploy-weilchain.js --network weilchainTestnet
if errorlevel 1 (
    echo ERROR: Deployment failed
    pause
    exit /b 1
)

echo.
echo ========================================
echo Deployment Successful!
echo ========================================
echo.
echo Next steps:
echo 1. Copy the contract address from above
echo 2. Update backend\.env with the contract address
echo 3. Restart your backend server
echo 4. Test your application
echo.
echo See WEIL_CHAIN_DEPLOYMENT_GUIDE.md for detailed instructions
echo.
pause
