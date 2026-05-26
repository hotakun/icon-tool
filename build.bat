@echo off
echo ========================================
echo   Icon Tool - Build EXE
echo ========================================
echo.

echo [1/4] Checking Node.js...
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js not found.
    echo Install from https://nodejs.org
    echo Make sure "Add to PATH" is checked.
    pause
    exit /b 1
)
node --version
echo.

echo [2/4] Installing dependencies...
echo NOTE: First run downloads Electron (~150MB), may take a few minutes.
call npm install
if %errorlevel% neq 0 (
    echo [ERROR] npm install failed. Check your internet connection.
    pause
    exit /b 1
)
echo.

echo [3/4] Building portable EXE...
echo NOTE: First build downloads electron-builder tools, may take 3-5 min.
echo If this appears stuck, check Task Manager for node.exe activity.
call npm run build
if %errorlevel% neq 0 (
    echo [ERROR] Build failed.
    pause
    exit /b 1
)

echo.
echo [4/4] Checking output...
if exist "dist\" (
    echo [OK] dist\ folder created
    dir dist\*.exe /b 2>nul
) else (
    echo [WARN] dist\ folder not found
)

echo.
echo ========================================
echo   BUILD COMPLETE!
echo   Next: Open build_setup.iss in Inno
echo         Setup and press Ctrl+F9
echo ========================================
pause
