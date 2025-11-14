@echo off
chcp 65001 >nul
echo ========================================
echo 修復 MySQL 路徑問題
echo ========================================
echo.

echo [檢查] 尋找 XAMPP MySQL...
set XAMPP_MYSQL_PATH=C:\xampp\mysql\bin\mysql.exe

if exist "%XAMPP_MYSQL_PATH%" (
    echo ✅ 找到 XAMPP MySQL: %XAMPP_MYSQL_PATH%
    echo.
    echo [測試] 使用完整路徑測試連線...
    "%XAMPP_MYSQL_PATH%" -u root -e "SELECT 1;" 2>nul
    if not errorlevel 1 (
        echo ✅ MySQL 連線成功！
        echo.
        echo ========================================
        echo 解決方案
        echo ========================================
        echo.
        echo 方法 1：使用完整路徑（臨時解決）
        echo   使用：C:\xampp\mysql\bin\mysql.exe -u root
        echo.
        echo 方法 2：加入系統 PATH（永久解決）
        echo   1. 按 Win+R，輸入 sysdm.cpl
        echo   2. 進階 → 環境變數
        echo   3. 編輯「Path」變數
        echo   4. 新增：C:\xampp\mysql\bin
        echo   5. 重新開啟命令提示字元
        echo.
        echo 方法 3：使用我建立的快速腳本
        echo   執行「使用XAMPP MySQL.bat」
        echo.
        pause
        exit /b 0
    ) else (
        echo ⚠️  連線失敗，測試無密碼連線...
        "%XAMPP_MYSQL_PATH%" -u root -e "SELECT 1;" 2>nul
        if not errorlevel 1 (
            echo ✅ MySQL 連線成功（無密碼）！
            echo.
            echo 注意：XAMPP 預設無密碼
            echo 請確認 server\.env 檔案中 DB_PASSWORD= 留空
            echo.
            pause
            exit /b 0
        ) else (
            echo ❌ 連線失敗
            echo.
            echo 請檢查：
            echo 1. XAMPP Control Panel 中 MySQL 是否正在運行
            echo 2. 是否有其他錯誤訊息
            echo.
            echo 建議：在 XAMPP Control Panel 中點擊 MySQL 的「Logs」查看錯誤
            pause
            exit /b 1
        )
    )
) else (
    echo ❌ 未找到 XAMPP MySQL
    echo.
    echo 可能原因：
    echo 1. XAMPP 安裝在其他位置
    echo 2. MySQL 未正確安裝
    echo.
    echo 請檢查 XAMPP 安裝位置
    pause
    exit /b 1
)

