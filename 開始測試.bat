@echo off
chcp 65001 >nul
echo ========================================
echo 益利肉類食品販售網站 - 測試啟動
echo ========================================
echo.

echo [1/4] 檢查 Node.js...
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 未安裝 Node.js，請先安裝 Node.js
    pause
    exit /b 1
)
echo ✅ Node.js 已安裝

echo.
echo [2/4] 檢查依賴套件...
if not exist "node_modules" (
    echo ⚠️  尚未安裝依賴套件，正在安裝...
    call npm install
)

if not exist "server\node_modules" (
    echo ⚠️  後端依賴尚未安裝，正在安裝...
    cd server
    call npm install
    cd ..
)

if not exist "client\node_modules" (
    echo ⚠️  前端依賴尚未安裝，正在安裝...
    cd client
    call npm install
    cd ..
)
echo ✅ 依賴套件檢查完成

echo.
echo [3/4] 檢查環境設定...
if not exist "server\.env" (
    echo ⚠️  未找到 server\.env 檔案
    echo 請參考 INSTALLATION.md 建立 .env 檔案
    echo.
    echo 基本設定範例：
    echo DB_HOST=localhost
    echo DB_USER=root
    echo DB_PASSWORD=你的密碼
    echo DB_NAME=yili_meat_shop
    echo JWT_SECRET=yili-secret-key
    echo PORT=5000
    echo.
    pause
)

echo.
echo [4/4] 啟動開發伺服器...
echo.
echo 前端將在 http://localhost:3000 運行
echo 後端 API 將在 http://localhost:5000 運行
echo.
echo 按 Ctrl+C 可停止伺服器
echo.
echo ========================================
echo.

call npm run dev

