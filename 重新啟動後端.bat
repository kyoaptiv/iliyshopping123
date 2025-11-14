@echo off
chcp 65001 >nul
echo ========================================
echo 重新啟動後端伺服器
echo ========================================
echo.

echo 這個腳本會幫您重新啟動後端伺服器
echo.
echo 請注意：
echo - 如果後端正在運行，請先按 Ctrl+C 停止
echo - 然後執行此腳本重新啟動
echo.
pause

echo.
echo 正在啟動後端伺服器...
echo.

cd server
echo 後端將運行在：http://localhost:5000
echo 按 Ctrl+C 可停止伺服器
echo.
npm start

