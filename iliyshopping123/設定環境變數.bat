@echo off
chcp 65001 >nul
echo ========================================
echo 設定環境變數（MySQL root 密碼：12345）
echo ========================================
echo.

echo 正在建立 server\.env 檔案...
(
    echo DB_HOST=localhost
    echo DB_USER=root
    echo DB_PASSWORD=12345
    echo DB_NAME=yili_meat_shop
    echo JWT_SECRET=yili-secret-key-12345
    echo PORT=5000
    echo EMAIL_USER=humblemars@gmail.com
    echo EMAIL_PASS=
) > "server\.env"

if exist "server\.env" (
    echo ✅ .env 檔案已建立
    echo.
    echo 檔案內容：
    type "server\.env"
    echo.
    echo ========================================
    echo 設定完成！
    echo ========================================
    echo.
    echo MySQL 連線設定：
    echo   - 使用者：root
    echo   - 密碼：12345
    echo   - 資料庫：yili_meat_shop
    echo.
    echo 管理員登入帳號：
    echo   - 帳號：admin
    echo   - 密碼：12345
    echo.
    echo 下一步：
    echo   1. 執行「快速設定資料庫.bat」來建立資料庫
    echo   2. 執行「檢查設定.bat」來驗證設定
    echo.
) else (
    echo ❌ 無法建立 .env 檔案
    echo 請手動在 server 目錄建立 .env 檔案
)

pause

