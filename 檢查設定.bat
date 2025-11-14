@echo off
chcp 65001 >nul
echo ========================================
echo 益利網站 - 設定檢查工具
echo ========================================
echo.

echo [檢查 1/4] 檢查 .env 檔案...
if exist "server\.env" (
    echo ✅ 找到 server\.env 檔案
    echo.
    echo 檔案內容：
    type "server\.env"
    echo.
) else (
    echo ❌ 未找到 server\.env 檔案
    echo.
    echo 請在 server 目錄建立 .env 檔案，內容如下：
    echo.
    echo DB_HOST=localhost
    echo DB_USER=root
    echo DB_PASSWORD=你的MySQL密碼
    echo DB_NAME=yili_meat_shop
    echo JWT_SECRET=yili-secret-key-12345
    echo PORT=5000
    echo.
    pause
    exit /b 1
)

echo.
echo [檢查 2/4] 檢查 Node.js 和依賴...
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 未安裝 Node.js
    pause
    exit /b 1
)
echo ✅ Node.js 已安裝

if not exist "server\node_modules" (
    echo ⚠️  後端依賴尚未安裝
    echo 正在安裝...
    cd server
    call npm install
    cd ..
)

echo ✅ 依賴套件已安裝

echo.
echo [檢查 3/4] 測試資料庫連線...
cd server
node test-db.js
if errorlevel 1 (
    echo.
    echo ❌ 資料庫連線失敗
    echo 請檢查上述錯誤訊息
    cd ..
    pause
    exit /b 1
)
cd ..

echo.
echo [檢查 4/4] 檢查上傳目錄...
if exist "server\uploads\products" (
    echo ✅ 上傳目錄存在
) else (
    echo ⚠️  上傳目錄不存在，正在建立...
    mkdir "server\uploads\products" 2>nul
    echo ✅ 已建立上傳目錄
)

echo.
echo ========================================
echo ✅ 所有檢查完成！
echo ========================================
echo.
echo 現在可以執行「開始測試.bat」來啟動伺服器
echo.
pause

