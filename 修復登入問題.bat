@echo off
chcp 65001 >nul
echo ========================================
echo 修復登入問題 - 資料庫連線檢查
echo ========================================
echo.

echo [步驟 1/4] 檢查 MySQL 服務...
echo 請確認 XAMPP Control Panel 中 MySQL 正在運行
echo.
set /p MYSQL_RUNNING=MySQL 正在運行？(Y/N): 
if /i not "%MYSQL_RUNNING%"=="Y" (
    echo 請先在 XAMPP Control Panel 中啟動 MySQL
    pause
    exit /b 1
)

echo.
echo [步驟 2/4] 檢查 .env 檔案...
if not exist "server\.env" (
    echo ❌ 未找到 .env 檔案
    echo 正在建立...
    (
        echo DB_HOST=localhost
        echo DB_USER=root
        echo DB_PASSWORD=
        echo DB_NAME=yili_meat_shop
        echo JWT_SECRET=yili-secret-key-12345
        echo PORT=5000
        echo EMAIL_USER=humblemars@gmail.com
        echo EMAIL_PASS=
    ) > "server\.env"
    echo ✅ 已建立 .env 檔案（XAMPP 無密碼設定）
) else (
    echo ✅ 找到 .env 檔案
    echo.
    echo 當前設定：
    type "server\.env"
    echo.
    echo ⚠️  注意：XAMPP MySQL 預設無密碼
    echo 如果 DB_PASSWORD=12345，請改為 DB_PASSWORD=
    echo.
    set /p FIX_ENV=是否要修復 .env 檔案？(Y/N): 
    if /i "%FIX_ENV%"=="Y" (
        (
            echo DB_HOST=localhost
            echo DB_USER=root
            echo DB_PASSWORD=
            echo DB_NAME=yili_meat_shop
            echo JWT_SECRET=yili-secret-key-12345
            echo PORT=5000
            echo EMAIL_USER=humblemars@gmail.com
            echo EMAIL_PASS=
        ) > "server\.env"
        echo ✅ .env 檔案已更新為無密碼設定
    )
)

echo.
echo [步驟 3/4] 測試資料庫連線...
cd server
node test-db.js
set DB_TEST_RESULT=%ERRORLEVEL%
cd ..

if %DB_TEST_RESULT% NEQ 0 (
    echo.
    echo ❌ 資料庫連線測試失敗
    echo.
    echo 請檢查：
    echo 1. XAMPP Control Panel 中 MySQL 是否正在運行
    echo 2. 資料庫 yili_meat_shop 是否存在
    echo 3. .env 檔案中的設定是否正確
    echo.
    echo 建議執行「使用XAMPP MySQL.bat」來檢查資料庫
    pause
    exit /b 1
)

echo.
echo [步驟 4/4] 檢查管理員帳號...
set MYSQL_PATH=C:\xampp\mysql\bin\mysql.exe
if exist "%MYSQL_PATH%" (
    echo 檢查管理員帳號是否存在...
    "%MYSQL_PATH%" -u root -e "USE yili_meat_shop; SELECT username, password FROM admins WHERE username='admin';" 2>nul
    if errorlevel 1 (
        echo ⚠️  無法查詢管理員帳號
        echo 可能資料庫結構未匯入
        echo.
        echo 請執行「使用XAMPP MySQL.bat」→ 選擇 [3] 匯入資料庫結構
    ) else (
        echo ✅ 管理員帳號存在
    )
)

echo.
echo ========================================
echo 修復完成
echo ========================================
echo.
echo 下一步：
echo 1. 確認後端伺服器正在運行
echo 2. 重新嘗試登入
echo 3. 如果仍有問題，請查看後端控制台的錯誤訊息
echo.
pause

