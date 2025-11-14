@echo off
chcp 65001 >nul
echo ========================================
echo MySQL 連線診斷工具
echo ========================================
echo.

echo [檢查 1/5] 檢查 MySQL 是否安裝...
where mysql >nul 2>&1
if errorlevel 1 (
    echo ⚠️  MySQL 命令列工具未在 PATH 中找到
    echo.
    echo [檢查] 尋找 XAMPP MySQL...
    set XAMPP_MYSQL=C:\xampp\mysql\bin\mysql.exe
    if exist "%XAMPP_MYSQL%" (
        echo ✅ 找到 XAMPP MySQL: %XAMPP_MYSQL%
        echo.
        echo 注意：XAMPP MySQL 未加入系統 PATH
        echo 建議：執行「修復MySQL路徑.bat」或「使用XAMPP MySQL.bat」
        echo.
        set MYSQL_CMD=%XAMPP_MYSQL%
        goto :found_mysql
    ) else (
        echo ❌ MySQL 命令列工具未找到
        echo.
        echo 可能原因：
        echo 1. MySQL 未安裝
        echo 2. MySQL 未加入系統 PATH
        echo 3. XAMPP 安裝在其他位置
        echo.
        echo 解決方法：
        echo - 確認 MySQL 已安裝
        echo - 或使用完整路徑執行 MySQL
        echo - 執行「修復MySQL路徑.bat」來診斷問題
        echo.
        pause
        exit /b 1
    )
) else (
    echo ✅ MySQL 命令列工具已找到
    mysql --version
    set MYSQL_CMD=mysql
)

:found_mysql

echo.
echo [檢查 2/5] 檢查 MySQL 服務狀態...
sc query MySQL80 >nul 2>&1
if not errorlevel 1 (
    echo ✅ 找到 MySQL80 服務
    for /f "tokens=3" %%a in ('sc query MySQL80 ^| findstr "STATE"') do set SERVICE_STATE=%%a
    echo 服務狀態: %SERVICE_STATE%
    if "%SERVICE_STATE%"=="RUNNING" (
        echo ✅ MySQL 服務正在運行
    ) else (
        echo ⚠️  MySQL 服務未運行
        echo.
        echo 是否要啟動 MySQL 服務？(Y/N)
        set /p START_SERVICE=
        if /i "%START_SERVICE%"=="Y" (
            echo 正在啟動 MySQL 服務（需要管理員權限）...
            net start MySQL80
            if errorlevel 1 (
                echo ❌ 無法啟動服務，請以管理員身份執行此腳本
            ) else (
                echo ✅ MySQL 服務已啟動
            )
        )
    )
    set MYSQL_SERVICE=MySQL80
    goto :test_connection
)

sc query MySQL >nul 2>&1
if not errorlevel 1 (
    echo ✅ 找到 MySQL 服務
    for /f "tokens=3" %%a in ('sc query MySQL ^| findstr "STATE"') do set SERVICE_STATE=%%a
    echo 服務狀態: %SERVICE_STATE%
    if "%SERVICE_STATE%"=="RUNNING" (
        echo ✅ MySQL 服務正在運行
    ) else (
        echo ⚠️  MySQL 服務未運行
        echo.
        echo 是否要啟動 MySQL 服務？(Y/N)
        set /p START_SERVICE=
        if /i "%START_SERVICE%"=="Y" (
            echo 正在啟動 MySQL 服務（需要管理員權限）...
            net start MySQL
            if errorlevel 1 (
                echo ❌ 無法啟動服務，請以管理員身份執行此腳本
            ) else (
                echo ✅ MySQL 服務已啟動
            )
        )
    )
    set MYSQL_SERVICE=MySQL
    goto :test_connection
)

echo ⚠️  未找到 MySQL 服務
echo.
echo 請確認：
echo 1. MySQL 已正確安裝
echo 2. 服務名稱可能是 MySQL57、MySQL 或其他名稱
echo.
echo 手動檢查方法：
echo - 開啟「服務」管理員（services.msc）
echo - 尋找 MySQL 相關服務
echo.

:test_connection
echo.
echo [檢查 3/5] 測試 MySQL 連線（使用密碼 12345）...
"%MYSQL_CMD%" -u root -p12345 -e "SELECT 1;" >nul 2>&1
if not errorlevel 1 (
    echo ✅ 使用密碼 12345 連線成功
    set MYSQL_PASSWORD=12345
    goto :test_database
)

echo ⚠️  使用密碼 12345 連線失敗
echo.
echo [檢查 4/5] 測試 MySQL 連線（無密碼）...
"%MYSQL_CMD%" -u root -e "SELECT 1;" >nul 2>&1
if not errorlevel 1 (
    echo ✅ 無密碼連線成功
    set MYSQL_PASSWORD=
    goto :test_database
)

echo ❌ 無密碼連線也失敗
echo.
echo 可能原因：
echo 1. MySQL root 密碼不是 12345
echo 2. MySQL 配置問題
echo.
echo 請手動測試連線：
echo   mysql -u root -p
echo.
echo 如果成功連線，請記下您使用的密碼
echo 然後修改 server\.env 檔案中的 DB_PASSWORD
echo.
pause
exit /b 1

:test_database
echo.
echo [檢查 5/5] 檢查資料庫是否存在...
if "%MYSQL_PASSWORD%"=="" (
    "%MYSQL_CMD%" -u root -e "SHOW DATABASES LIKE 'yili_meat_shop';" 2>nul | findstr "yili_meat_shop" >nul
) else (
    "%MYSQL_CMD%" -u root -p%MYSQL_PASSWORD% -e "SHOW DATABASES LIKE 'yili_meat_shop';" 2>nul | findstr "yili_meat_shop" >nul
)

if not errorlevel 1 (
    echo ✅ 資料庫 yili_meat_shop 已存在
) else (
    echo ⚠️  資料庫 yili_meat_shop 不存在
    echo.
    echo 是否要建立資料庫？(Y/N)
    set /p CREATE_DB=
    if /i "%CREATE_DB%"=="Y" (
        if "%MYSQL_PASSWORD%"=="" (
            "%MYSQL_CMD%" -u root -e "CREATE DATABASE IF NOT EXISTS yili_meat_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
            "%MYSQL_CMD%" -u root yili_meat_shop < database\schema.sql
        ) else (
            "%MYSQL_CMD%" -u root -p%MYSQL_PASSWORD% -e "CREATE DATABASE IF NOT EXISTS yili_meat_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
            "%MYSQL_CMD%" -u root -p%MYSQL_PASSWORD% yili_meat_shop < database\schema.sql
        )
        if not errorlevel 1 (
            echo ✅ 資料庫已建立並匯入結構
        ) else (
            echo ❌ 建立資料庫失敗
        )
    )
)

echo.
echo ========================================
echo 診斷完成
echo ========================================
echo.
echo 連線資訊：
if "%MYSQL_PASSWORD%"=="" (
    echo   - 密碼：無密碼
    echo   - 請修改 server\.env，將 DB_PASSWORD= 留空
) else (
    echo   - 密碼：12345
    echo   - server\.env 設定正確
)
echo.
pause

