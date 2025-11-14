@echo off
chcp 65001 >nul
echo ========================================
echo 建立資料庫工具
echo ========================================
echo.
echo 此工具將幫您建立 yili_meat_shop 資料庫
echo.

echo 請輸入 MySQL root 密碼（如果沒有密碼，直接按 Enter）：
set /p MYSQL_PASSWORD=

if "%MYSQL_PASSWORD%"=="" (
    echo 使用空密碼連線...
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS yili_meat_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    if errorlevel 1 (
        echo ❌ 建立資料庫失敗
        echo 請確認 MySQL 服務正在運行
        pause
        exit /b 1
    )
    echo ✅ 資料庫已建立
    echo.
    echo 正在匯入資料庫結構...
    mysql -u root yili_meat_shop < database\schema.sql
    if errorlevel 1 (
        echo ❌ 匯入資料庫結構失敗
        pause
        exit /b 1
    )
) else (
    echo 使用密碼連線...
    mysql -u root -p%MYSQL_PASSWORD% -e "CREATE DATABASE IF NOT EXISTS yili_meat_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    if errorlevel 1 (
        echo ❌ 建立資料庫失敗
        echo 請確認密碼是否正確
        pause
        exit /b 1
    )
    echo ✅ 資料庫已建立
    echo.
    echo 正在匯入資料庫結構...
    mysql -u root -p%MYSQL_PASSWORD% yili_meat_shop < database\schema.sql
    if errorlevel 1 (
        echo ❌ 匯入資料庫結構失敗
        pause
        exit /b 1
    )
)

echo.
echo ✅ 資料庫建立完成！
echo.
echo 現在可以執行「檢查設定.bat」來驗證設定
echo.
pause

