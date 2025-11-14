@echo off
chcp 65001 >nul
echo ========================================
echo 資料庫連線問題修復工具
echo ========================================
echo.

echo [步驟 1/5] 檢查 .env 檔案...
if not exist "server\.env" (
    echo ❌ 未找到 server\.env 檔案
    echo.
    echo 正在建立 .env 檔案範本...
    (
        echo DB_HOST=localhost
        echo DB_USER=root
        echo DB_PASSWORD=
        echo DB_NAME=yili_meat_shop
        echo JWT_SECRET=yili-secret-key-12345
        echo PORT=5000
    ) > "server\.env"
    echo ✅ 已建立 server\.env 檔案範本
    echo.
    echo ⚠️  請編輯 server\.env 檔案，填入正確的 MySQL 密碼
    echo    特別是 DB_PASSWORD= 這一行
    echo.
    pause
) else (
    echo ✅ 找到 .env 檔案
)

echo.
echo [步驟 2/5] 檢查 MySQL 服務...
sc query MySQL80 >nul 2>&1
if errorlevel 1 (
    sc query MySQL >nul 2>&1
    if errorlevel 1 (
        echo ⚠️  無法找到 MySQL 服務
        echo.
        echo 請確認：
        echo 1. MySQL 已安裝
        echo 2. MySQL 服務正在運行
        echo.
        echo 手動檢查方法：
        echo - 開啟「服務」管理員（services.msc）
        echo - 尋找 MySQL 相關服務
        echo - 確認服務狀態為「執行中」
        echo.
    ) else (
        echo ✅ 找到 MySQL 服務
    )
) else (
    echo ✅ 找到 MySQL80 服務
)

echo.
echo [步驟 3/5] 測試資料庫連線...
cd server
node test-db.js
set DB_TEST_RESULT=%ERRORLEVEL%
cd ..

if %DB_TEST_RESULT% NEQ 0 (
    echo.
    echo ========================================
    echo 資料庫連線失敗，請選擇修復方法：
    echo ========================================
    echo.
    echo 1. 如果 MySQL 未安裝，請先安裝 MySQL
    echo 2. 如果 MySQL 已安裝但服務未運行，請啟動服務
    echo 3. 檢查 server\.env 檔案中的設定是否正確
    echo 4. 確認資料庫是否已建立
    echo.
    echo 建立資料庫的方法：
    echo   方法 A: 使用 MySQL Workbench 或其他工具執行 database\schema.sql
    echo   方法 B: 使用命令列（見下方）
    echo.
    echo 命令列建立資料庫：
    echo   mysql -u root -p ^< database\schema.sql
    echo.
    pause
    exit /b 1
)

echo.
echo [步驟 4/5] 檢查資料庫結構...
cd server
node -e "require('dotenv').config(); const mysql = require('mysql2/promise'); (async () => { try { const conn = await mysql.createConnection({host: process.env.DB_HOST || 'localhost', user: process.env.DB_USER || 'root', password: process.env.DB_PASSWORD || '', database: process.env.DB_NAME || 'yili_meat_shop'}); const [tables] = await conn.execute('SHOW TABLES'); console.log('✅ 資料庫表:', tables.map(t => Object.values(t)[0]).join(', ')); const [admins] = await conn.execute('SELECT * FROM admins'); if (admins.length === 0) { console.log('⚠️  管理員表為空，需要執行 schema.sql'); } else { console.log('✅ 找到', admins.length, '個管理員帳號'); } await conn.end(); } catch(e) { console.error('❌', e.message); process.exit(1); } })()"
cd ..

echo.
echo [步驟 5/5] 檢查完成
echo.
echo ========================================
echo 如果仍有問題，請檢查：
echo ========================================
echo 1. MySQL 服務是否運行
echo 2. server\.env 中的 DB_PASSWORD 是否正確
echo 3. 資料庫 yili_meat_shop 是否存在
echo 4. 是否已執行 database\schema.sql
echo.
pause

