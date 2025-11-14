@echo off
chcp 65001 >nul
echo ========================================
echo 快速設定資料庫（MySQL root 密碼：12345）
echo ========================================
echo.

echo [步驟 1/3] 檢查 MySQL 路徑...
set MYSQL_CMD=mysql
where mysql >nul 2>&1
if errorlevel 1 (
    set XAMPP_MYSQL=C:\xampp\mysql\bin\mysql.exe
    if exist "%XAMPP_MYSQL%" (
        echo ✅ 找到 XAMPP MySQL，使用完整路徑
        set MYSQL_CMD=%XAMPP_MYSQL%
    ) else (
        echo ❌ 找不到 MySQL 命令
        echo 請執行「修復MySQL路徑.bat」或「使用XAMPP MySQL.bat」
        pause
        exit /b 1
    )
)

echo [步驟 2/3] 建立資料庫...
"%MYSQL_CMD%" -u root -p12345 -e "CREATE DATABASE IF NOT EXISTS yili_meat_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" 2>nul
if errorlevel 1 (
    echo ⚠️  使用密碼連線失敗，嘗試無密碼連線...
    "%MYSQL_CMD%" -u root -e "CREATE DATABASE IF NOT EXISTS yili_meat_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" 2>nul
    if errorlevel 1 (
        echo ❌ 無法連線到 MySQL
        echo 請確認：
        echo 1. MySQL 服務是否運行（XAMPP Control Panel）
        echo 2. MySQL root 密碼是否為 12345
        echo 3. 如果密碼不同，請手動修改 server\.env 檔案
        echo.
        echo 建議：執行「使用XAMPP MySQL.bat」來手動操作
        pause
        exit /b 1
    )
    echo ✅ 資料庫已建立（使用無密碼連線）
    set MYSQL_PASSWORD=
) else (
    echo ✅ 資料庫已建立（使用密碼 12345 連線）
    set MYSQL_PASSWORD=12345
)

echo.
echo [步驟 3/3] 匯入資料庫結構...
if "%MYSQL_PASSWORD%"=="" (
    "%MYSQL_CMD%" -u root yili_meat_shop < database\schema.sql 2>nul
    if errorlevel 1 (
        echo ❌ 匯入資料庫結構失敗
        pause
        exit /b 1
    )
    echo ✅ 資料庫結構已匯入（使用無密碼連線）
    echo.
    echo ⚠️  注意：XAMPP 預設無密碼
    echo 請確認 server\.env 檔案中 DB_PASSWORD= 留空
) else (
    "%MYSQL_CMD%" -u root -p%MYSQL_PASSWORD% yili_meat_shop < database\schema.sql 2>nul
    if errorlevel 1 (
        echo ❌ 匯入資料庫結構失敗
        pause
        exit /b 1
    )
    echo ✅ 資料庫結構已匯入（使用密碼 12345 連線）
)

echo.
echo [驗證] 檢查管理員帳號...
if "%MYSQL_PASSWORD%"=="" (
    "%MYSQL_CMD%" -u root -e "USE yili_meat_shop; SELECT username, password FROM admins WHERE username='admin';" 2>nul
) else (
    "%MYSQL_CMD%" -u root -p%MYSQL_PASSWORD% -e "USE yili_meat_shop; SELECT username, password FROM admins WHERE username='admin';" 2>nul
)

echo.
echo ========================================
echo ✅ 設定完成！
echo ========================================
echo.
echo 資料庫設定：
echo   - 資料庫名稱：yili_meat_shop
echo   - MySQL 使用者：root
echo   - MySQL 密碼：12345
echo.
echo 管理員帳號：
echo   - 帳號：admin
echo   - 密碼：12345
echo.
echo 現在可以執行「檢查設定.bat」來驗證設定
echo.
pause

