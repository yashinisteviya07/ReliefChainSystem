@echo off
echo ========================================
echo   ReliefChain Troubleshooting Script
echo ========================================
echo.

echo Checking system status...
echo.

echo 1. Checking Node.js installation...
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js not found
    echo Please install Node.js from https://nodejs.org/
) else (
    echo ✅ Node.js installed
    node --version
)
echo.

echo 2. Checking npm installation...
npm --version >nul 2>&1
if errorlevel 1 (
    echo ❌ npm not found
) else (
    echo ✅ npm installed
    npm --version
)
echo.

echo 3. Checking MongoDB installation...
mongod --version >nul 2>&1
if errorlevel 1 (
    echo ⚠️ MongoDB not found locally
    echo You can use MongoDB Atlas cloud database instead
    echo Update MONGODB_URI in backend/.env
) else (
    echo ✅ MongoDB installed locally
    mongod --version | findstr "db version"
)
echo.

echo 4. Checking port availability...
echo Checking if ports are in use:
netstat -an | findstr :3000 >nul && echo ⚠️  Port 3000 in use (Frontend) || echo ✅ Port 3000 available
netstat -an | findstr :3001 >nul && echo ⚠️  Port 3001 in use (Backend) || echo ✅ Port 3001 available  
netstat -an | findstr :8545 >nul && echo ⚠️  Port 8545 in use (Blockchain) || echo ✅ Port 8545 available
netstat -an | findstr :27017 >nul && echo ⚠️  Port 27017 in use (MongoDB) || echo ✅ Port 27017 available
echo.

echo 5. Checking project dependencies...
echo Checking backend dependencies:
cd backend
if exist node_modules (
    echo ✅ Backend node_modules exists
) else (
    echo ❌ Backend dependencies missing
    echo Run: cd backend && npm install
)

echo Checking frontend dependencies:
cd ../frontend
if exist node_modules (
    echo ✅ Frontend node_modules exists
) else (
    echo ❌ Frontend dependencies missing  
    echo Run: cd frontend && npm install
)

echo Checking blockchain dependencies:
cd ../blockchain
if exist node_modules (
    echo ✅ Blockchain node_modules exists
) else (
    echo ❌ Blockchain dependencies missing
    echo Run: cd blockchain && npm install
)
cd ..
echo.

echo 6. Checking environment configuration...
if exist backend\.env (
    echo ✅ Backend .env file exists
    findstr "MONGODB_URI" backend\.env >nul && echo ✅ MongoDB URI configured || echo ⚠️ MongoDB URI missing
) else (
    echo ❌ Backend .env file missing
    echo Copy backend\.env.example to backend\.env
)
echo.

echo 7. Checking smart contract deployment...
if exist blockchain\deployments\deployment.json (
    echo ✅ Contract deployment file exists
) else (
    echo ❌ Contract not deployed
    echo Run: cd blockchain && npx hardhat run scripts/deploy.js --network localhost
)
echo.

echo 8. Checking database connection...
echo Testing MongoDB connection...
cd backend
node -e "
const mongoose = require('mongoose');
const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017/reliefchain';
mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => {
    console.log('✅ Database connection successful');
    process.exit(0);
  })
  .catch(err => {
    console.log('❌ Database connection failed:', err.message);
    console.log('💡 Try using MongoDB Atlas cloud database');
    process.exit(1);
  });
" 2>nul
cd ..
echo.

echo 9. Process cleanup (if needed)...
echo Killing any stuck processes...
taskkill /f /im node.exe >nul 2>&1
taskkill /f /im npm.exe >nul 2>&1
taskkill /f /im mongod.exe >nul 2>&1
echo ✅ Process cleanup completed
echo.

echo ========================================
echo   Troubleshooting Complete
echo ========================================
echo.
echo Common solutions:
echo 1. Install missing dependencies: npm install
echo 2. Setup database: run setup-database.bat
echo 3. Start all services: run start-all-services.bat
echo 4. Fix MetaMask: run fix-metamask-connection.bat
echo.
echo Manual startup order:
echo 1. Start MongoDB: mongod (or use Atlas)
echo 2. Start Hardhat: cd blockchain && npx hardhat node
echo 3. Deploy contract: cd blockchain && npx hardhat run scripts/deploy.js --network localhost
echo 4. Start backend: cd backend && npm run dev
echo 5. Start frontend: cd frontend && npm start
echo.
pause