@echo off
chcp 65001 >nul
echo ========================================
echo 測試 MySQL 連線
echo ========================================
echo.

echo 正在測試不同的連線方式...
echo.

echo [測試 1] 使用密碼 12345 連線...
mysql -u root -p12345 -e "SELECT '連線成功' AS status;" 2>nul
if not errorlevel 1 (
    echo ✅ 連線成功！MySQL root 密碼是 12345
    echo.
    echo 現在可以執行「快速設定資料庫.bat」
    pause
    exit /b 0
)

echo ❌ 連線失敗
echo.
echo [測試 2] 無密碼連線...
mysql -u root -e "SELECT '連線成功' AS status;" 2>nul
if not errorlevel 1 (
    echo ✅ 連線成功！MySQL root 沒有密碼
    echo.
    echo ⚠️  請修改 server\.env 檔案
    echo 將 DB_PASSWORD=12345 改為 DB_PASSWORD=
    echo.
    echo 然後執行以下命令建立資料庫：
    echo   mysql -u root -e "CREATE DATABASE IF NOT EXISTS yili_meat_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    echo   mysql -u root yili_meat_shop ^< database\schema.sql
    pause
    exit /b 0
)

echo ❌ 連線失敗
echo.
echo ========================================
echo 無法連線到 MySQL
echo ========================================
echo.
echo 可能原因：
echo 1. MySQL 服務未運行
echo 2. MySQL root 密碼不是 12345
echo 3. MySQL 未正確安裝
echo.
echo 請執行「診斷MySQL.bat」來詳細診斷問題
echo.
pause

