@echo off
chcp 65001 >nul
echo ========================================
echo 啟動益利肉類食品販售網站
echo ========================================
echo.

echo [檢查 1/4] 檢查 XAMPP MySQL...
sc query MySQL80 >nul 2>&1
if errorlevel 1 (
    echo ⚠️  未找到 MySQL 系統服務（這是正常的，XAMPP 不註冊為服務）
    echo.
    echo 請確認 XAMPP Control Panel 中 MySQL 正在運行
    echo 如果未運行，請在 XAMPP Control Panel 中點擊 MySQL 的「Start」按鈕
    echo.
    set /p CONTINUE=MySQL 已啟動？(Y/N): 
    if /i not "%CONTINUE%"=="Y" (
        echo 請先啟動 MySQL 後再繼續
        pause
        exit /b 1
    )
) else (
    echo ✅ MySQL 服務正在運行
)

echo.
echo [檢查 2/4] 檢查 .env 檔案...
if not exist "server\.env" (
    echo ❌ 未找到 server\.env 檔案
    echo 請執行「設定環境變數.bat」來建立
    pause
    exit /b 1
)
echo ✅ 找到 .env 檔案

echo.
echo [檢查 3/4] 檢查依賴套件...
if not exist "server\node_modules" (
    echo ⚠️  後端依賴尚未安裝
    echo 正在安裝後端依賴...
    cd server
    call npm install
    if errorlevel 1 (
        echo ❌ 後端依賴安裝失敗
        cd ..
        pause
        exit /b 1
    )
    cd ..
    echo ✅ 後端依賴已安裝
) else (
    echo ✅ 後端依賴已安裝
)

if not exist "client\node_modules" (
    echo ⚠️  前端依賴尚未安裝
    echo 正在安裝前端依賴...
    cd client
    call npm install
    if errorlevel 1 (
        echo ❌ 前端依賴安裝失敗
        cd ..
        pause
        exit /b 1
    )
    cd ..
    echo ✅ 前端依賴已安裝
) else (
    echo ✅ 前端依賴已安裝
)

echo.
echo [檢查 4/4] 檢查上傳目錄...
if not exist "server\uploads\products" (
    echo 正在建立上傳目錄...
    mkdir "server\uploads\products" 2>nul
)
echo ✅ 上傳目錄已準備

echo.
echo ========================================
echo ✅ 所有檢查完成！
echo ========================================
echo.
echo 正在啟動網站...
echo.
echo 前端將在 http://localhost:3000 運行
echo 後端 API 將在 http://localhost:5000 運行
echo.
echo 按 Ctrl+C 可停止伺服器
echo.
echo ========================================
echo.

call npm run dev

