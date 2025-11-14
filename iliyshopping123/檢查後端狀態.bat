@echo off
chcp 65001 >nul
echo ========================================
echo 檢查後端狀態
echo ========================================
echo.

echo [檢查 1/4] 檢查後端 API...
curl -s http://localhost:5000/api/health >nul 2>&1
if not errorlevel 1 (
    echo ✅ 後端 API 正在運行
    curl http://localhost:5000/api/health
    echo.
) else (
    echo ❌ 後端 API 未運行或無法連線
    echo.
    echo 請確認：
    echo 1. 後端伺服器是否正在運行
    echo 2. 執行「啟動網站.bat」來啟動伺服器
    echo.
)

echo [檢查 2/4] 檢查 .env 檔案...
if exist "server\.env" (
    echo ✅ .env 檔案存在
    echo.
    echo 當前設定：
    findstr "DB_PASSWORD" "server\.env"
    echo.
    echo ⚠️  如果顯示 DB_PASSWORD=12345，這是錯誤的！
    echo    XAMPP MySQL 預設無密碼，應該是 DB_PASSWORD=
    echo.
) else (
    echo ❌ .env 檔案不存在
)

echo [檢查 3/4] 測試資料庫連線...
cd server
node test-db.js
cd ..

echo.
echo [檢查 4/4] 檢查 MySQL 服務...
echo 請在 XAMPP Control Panel 中確認 MySQL 正在運行
echo.

pause

