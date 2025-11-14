@echo off
chcp 65001 >nul
echo ========================================
echo MySQL 安裝方式選擇
echo ========================================
echo.
echo 請選擇安裝方式：
echo.
echo [1] XAMPP（推薦新手，最簡單）
echo      - 一鍵安裝 MySQL + Apache + PHP
echo      - 包含 phpMyAdmin（圖形化管理工具）
echo      - 預設無密碼，設定容易
echo      - 下載：https://www.apachefriends.org/zh_tw/index.html
echo.
echo [2] MySQL 官方版（適合生產環境）
echo      - 官方版本，穩定可靠
echo      - 包含 MySQL Workbench
echo      - 需要設定 root 密碼（建議設為 12345）
echo      - 下載：https://dev.mysql.com/downloads/installer/
echo.
echo [3] 查看詳細安裝指南
echo.
echo [0] 退出
echo.
set /p CHOICE=請選擇 (1/2/3/0): 

if "%CHOICE%"=="1" (
    echo.
    echo ========================================
    echo 您選擇了 XAMPP
    echo ========================================
    echo.
    echo 安裝步驟：
    echo 1. 前往 https://www.apachefriends.org/zh_tw/index.html
    echo 2. 下載 Windows 版本
    echo 3. 執行安裝檔，至少選擇 MySQL 和 phpMyAdmin
    echo 4. 安裝完成後，開啟 XAMPP Control Panel
    echo 5. 點擊 MySQL 的「Start」按鈕
    echo.
    echo 詳細指南請參考：安裝XAMPP指南.md
    echo.
    echo 安裝完成後，執行「診斷MySQL.bat」來測試連線
    echo.
    pause
    start https://www.apachefriends.org/zh_tw/index.html
    exit /b 0
)

if "%CHOICE%"=="2" (
    echo.
    echo ========================================
    echo 您選擇了 MySQL 官方版
    echo ========================================
    echo.
    echo 安裝步驟：
    echo 1. 前往 https://dev.mysql.com/downloads/installer/
    echo 2. 下載 mysql-installer-community
    echo 3. 執行安裝檔
    echo 4. 選擇「Developer Default」
    echo 5. 設定 root 密碼為：12345
    echo.
    echo 詳細指南請參考：安裝MySQL官方版指南.md
    echo.
    echo 安裝完成後，執行「診斷MySQL.bat」來測試連線
    echo.
    pause
    start https://dev.mysql.com/downloads/installer/
    exit /b 0
)

if "%CHOICE%"=="3" (
    echo.
    echo ========================================
    echo 安裝指南檔案
    echo ========================================
    echo.
    echo 已建立的指南檔案：
    echo - 安裝MySQL指南.md（總覽）
    echo - 安裝XAMPP指南.md（XAMPP 詳細步驟）
    echo - 安裝MySQL官方版指南.md（官方版詳細步驟）
    echo.
    echo 請開啟這些檔案查看詳細說明
    echo.
    pause
    exit /b 0
)

if "%CHOICE%"=="0" (
    exit /b 0
)

echo 無效的選擇
pause

