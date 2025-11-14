@echo off
chcp 65001 >nul
echo ========================================
echo 使用 XAMPP MySQL 工具
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
echo 請選擇操作：
echo.
echo [1] 測試連線
echo [2] 建立資料庫 yili_meat_shop
echo [3] 匯入資料庫結構
echo [4] 檢查管理員帳號
echo [5] 進入 MySQL 命令列
echo [0] 退出
echo.
set /p CHOICE=請選擇 (0-5): 

if "%CHOICE%"=="1" (
    echo.
    echo 測試連線中...
    "%MYSQL_PATH%" -u root -e "SELECT 1 AS test, VERSION() AS version;" 2>nul
    if errorlevel 1 (
        echo 使用無密碼連線測試...
        "%MYSQL_PATH%" -u root -e "SELECT 1 AS test, VERSION() AS version;"
        if not errorlevel 1 (
            echo.
            echo ✅ 連線成功！
            echo XAMPP MySQL 預設無密碼
        )
    ) else (
        echo.
        echo ✅ 連線成功！
    )
    pause
    exit /b 0
)

if "%CHOICE%"=="2" (
    echo.
    echo 正在建立資料庫...
    "%MYSQL_PATH%" -u root -e "CREATE DATABASE IF NOT EXISTS yili_meat_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" 2>nul
    if errorlevel 1 (
        "%MYSQL_PATH%" -u root -e "CREATE DATABASE IF NOT EXISTS yili_meat_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    )
    if not errorlevel 1 (
        echo ✅ 資料庫已建立
    ) else (
        echo ❌ 建立資料庫失敗
    )
    pause
    exit /b 0
)

if "%CHOICE%"=="3" (
    echo.
    echo 正在匯入資料庫結構...
    if exist "database\schema.sql" (
        "%MYSQL_PATH%" -u root yili_meat_shop < database\schema.sql 2>nul
        if errorlevel 1 (
            "%MYSQL_PATH%" -u root yili_meat_shop < database\schema.sql
        )
        if not errorlevel 1 (
            echo ✅ 資料庫結構已匯入
        ) else (
            echo ❌ 匯入失敗
        )
    ) else (
        echo ❌ 找不到 database\schema.sql 檔案
    )
    pause
    exit /b 0
)

if "%CHOICE%"=="4" (
    echo.
    echo 檢查管理員帳號...
    "%MYSQL_PATH%" -u root -e "USE yili_meat_shop; SELECT username, password FROM admins WHERE username='admin';" 2>nul
    if errorlevel 1 (
        "%MYSQL_PATH%" -u root -e "USE yili_meat_shop; SELECT username, password FROM admins WHERE username='admin';"
    )
    pause
    exit /b 0
)

if "%CHOICE%"=="5" (
    echo.
    echo 進入 MySQL 命令列...
    echo 輸入 exit 或 quit 退出
    echo.
    "%MYSQL_PATH%" -u root
    pause
    exit /b 0
)

if "%CHOICE%"=="0" (
    exit /b 0
)

echo 無效的選擇
pause

