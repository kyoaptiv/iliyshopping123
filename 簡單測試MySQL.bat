@echo off
chcp 65001 >nul
echo ========================================
echo 簡單測試 XAMPP MySQL
echo ========================================
echo.

set MYSQL_PATH=C:\xampp\mysql\bin\mysql.exe

if not exist "%MYSQL_PATH%" (
    echo ❌ 未找到 XAMPP MySQL
    echo 請確認 XAMPP 安裝在 C:\xampp
    pause
    exit /b 1
)

echo ✅ 找到 XAMPP MySQL
echo.
echo 正在測試連線（XAMPP 預設無密碼）...
echo.

"%MYSQL_PATH%" -u root -e "SELECT 1 AS test;" 2>nul
if errorlevel 1 (
    echo ❌ 連線失敗
    echo.
    echo 請檢查：
    echo 1. XAMPP Control Panel 中 MySQL 是否正在運行
    echo 2. 點擊 MySQL 的「Logs」查看錯誤訊息
    echo.
    pause
    exit /b 1
)

echo ✅ 連線成功！
echo.
echo MySQL 資訊：
"%MYSQL_PATH%" -u root -e "SELECT VERSION() AS mysql_version;" 2>nul

echo.
echo ========================================
echo 下一步
echo ========================================
echo.
echo 1. 確認 XAMPP Control Panel 中 MySQL 正在運行
echo 2. 執行「使用XAMPP MySQL.bat」來建立資料庫
echo 3. 確認 server\.env 檔案中 DB_PASSWORD= 留空
echo.
pause

