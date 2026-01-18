@echo off
echo Troubleshooting Connection Issues...
echo.

echo 1. Checking if services are running...
netstat -ano | findstr :3000
netstat -ano | findstr :3001
netstat -ano | findstr :8545

echo.
echo 2. Testing backend connection...
curl -s http://localhost:3001/health

echo.
echo 3. Opening application in browser...
start http://localhost:3000

echo.
echo If you still see "Failed to Connect":
echo - Clear browser cache (Ctrl+Shift+Delete)
echo - Try incognito/private mode
echo - Check Windows Firewall settings
echo - Restart browser completely

pause