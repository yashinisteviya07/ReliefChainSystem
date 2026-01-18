@echo off
echo Starting local sharing setup...
echo.
echo 1. Download ngrok from https://ngrok.com/
echo 2. Install and authenticate ngrok
echo 3. Run these commands in separate terminals:
echo.
echo Terminal 1 - Share Frontend:
echo ngrok http 3000
echo.
echo Terminal 2 - Share Backend:
echo ngrok http 3001
echo.
echo Your friends can then access:
echo - Frontend: https://your-ngrok-url.ngrok.io
echo - Backend: https://your-backend-ngrok-url.ngrok.io
echo.
pause