@echo off
chcp 65001 >nul
echo ========================================
echo 快速修復登入問題
echo ========================================
echo.

echo 正在修復 .env 檔案（XAMPP 無密碼設定）...
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
echo.
echo 重要：XAMPP MySQL 預設無密碼
echo 已將 DB_PASSWORD= 設為空
echo.
echo 請確認：
echo 1. XAMPP Control Panel 中 MySQL 正在運行
echo 2. 重新啟動後端伺服器
echo 3. 再次嘗試登入
echo.
pause

