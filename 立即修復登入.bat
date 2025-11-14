@echo off
chcp 65001 >nul
echo ========================================
echo 立即修復登入問題
echo ========================================
echo.

echo [修復 1/3] 修正 .env 檔案...
echo 將 DB_PASSWORD 改為空（XAMPP 預設無密碼）
echo.

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

echo ✅ .env 檔案已更新
echo    DB_PASSWORD= 已設為空
echo.

echo [修復 2/3] 測試資料庫連線...
cd server
node test-db.js
set TEST_RESULT=%ERRORLEVEL%
cd ..

if %TEST_RESULT% NEQ 0 (
    echo.
    echo ❌ 資料庫連線測試失敗
    echo.
    echo 請確認：
    echo 1. XAMPP Control Panel 中 MySQL 正在運行
    echo 2. 資料庫 yili_meat_shop 已建立
    echo.
    echo 如果資料庫未建立，請執行：
    echo   使用XAMPP MySQL.bat → [2] 建立資料庫 → [3] 匯入結構
    echo.
    pause
    exit /b 1
)

echo.
echo [修復 3/3] 檢查管理員帳號...
set MYSQL_PATH=C:\xampp\mysql\bin\mysql.exe
if exist "%MYSQL_PATH%" (
    "%MYSQL_PATH%" -u root -e "USE yili_meat_shop; SELECT username FROM admins WHERE username='admin';" 2>nul | findstr "admin" >nul
    if not errorlevel 1 (
        echo ✅ 管理員帳號存在
    ) else (
        echo ⚠️  管理員帳號不存在
        echo 請執行「使用XAMPP MySQL.bat」→ [3] 匯入資料庫結構
    )
)

echo.
echo ========================================
echo ✅ 修復完成！
echo ========================================
echo.
echo ⚠️  重要：請重新啟動後端伺服器！
echo.
echo 步驟：
echo 1. 如果後端正在運行，按 Ctrl+C 停止
echo 2. 重新執行「啟動網站.bat」或「開始測試.bat」
echo 3. 等待伺服器啟動完成
echo 4. 再次嘗試登入
echo.
echo 登入資訊：
echo   帳號：admin
echo   密碼：12345
echo.
pause

