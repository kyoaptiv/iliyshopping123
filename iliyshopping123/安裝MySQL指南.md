# MySQL 安裝指南

## 推薦安裝方式

### 方式一：XAMPP（最簡單，推薦新手）⭐

XAMPP 包含 MySQL、Apache、PHP，安裝簡單，適合開發使用。

#### 下載與安裝

1. **下載 XAMPP**
   - 前往：https://www.apachefriends.org/zh_tw/index.html
   - 選擇 Windows 版本下載
   - 建議下載最新版本（包含 MySQL 8.0）

2. **安裝步驟**
   - 執行下載的安裝檔
   - 選擇安裝元件：至少選擇 **MySQL** 和 **phpMyAdmin**
   - 選擇安裝位置（預設：`C:\xampp`）
   - 完成安裝

3. **啟動 MySQL**
   - 開啟 XAMPP Control Panel
   - 找到 MySQL，點擊「Start」按鈕
   - 狀態應顯示為「Running」

4. **設定密碼（可選）**
   - XAMPP 預設 MySQL root 沒有密碼
   - 如果需要設定密碼，可以使用 phpMyAdmin

#### XAMPP 的優點
- ✅ 安裝簡單，一鍵安裝
- ✅ 包含 MySQL 和 phpMyAdmin（圖形化管理工具）
- ✅ 預設無密碼，容易設定
- ✅ 適合開發環境

---

### 方式二：MySQL 官方安裝程式（適合生產環境）

#### 下載與安裝

1. **下載 MySQL**
   - 前往：https://dev.mysql.com/downloads/installer/
   - 選擇「MySQL Installer for Windows」
   - 下載「mysql-installer-community」（較小）或「mysql-installer-web-community」（需要網路）

2. **安裝步驟**
   - 執行安裝程式
   - 選擇「Developer Default」（開發者預設）或「Server only」（僅伺服器）
   - 安裝過程會要求設定 root 密碼
   - **建議設定密碼為：12345**（方便後續設定）
   - 完成安裝

3. **啟動 MySQL**
   - MySQL 會自動安裝為 Windows 服務
   - 在服務管理員中確認 MySQL80 服務正在運行

#### MySQL 官方版的優點
- ✅ 官方版本，穩定可靠
- ✅ 適合生產環境
- ✅ 功能完整

---

### 方式三：WAMP（Windows + Apache + MySQL + PHP）

類似 XAMPP，但專為 Windows 優化。

1. **下載 WAMP**
   - 前往：https://www.wampserver.com/
   - 下載最新版本

2. **安裝與啟動**
   - 執行安裝程式
   - 完成後啟動 WAMP Server
   - 點擊系統匣圖示 → MySQL → Service → Start/Resume Service

---

## 安裝後設定步驟

### 步驟 1：確認 MySQL 運行

1. 開啟服務管理員（`services.msc`）
2. 確認 MySQL 服務正在運行
   - XAMPP：服務名稱可能是 `MySQL` 或 `mysql`
   - 官方版：服務名稱是 `MySQL80`

### 步驟 2：測試連線

開啟命令提示字元（cmd），執行：

```bash
# XAMPP（通常無密碼）
mysql -u root

# 官方版（如果有設定密碼）
mysql -u root -p12345
```

如果看到 `mysql>` 提示符，表示連線成功！

### 步驟 3：設定環境變數（可選）

如果 `mysql` 命令找不到，需要將 MySQL 加入系統 PATH：

**XAMPP：**
- 路徑：`C:\xampp\mysql\bin`
- 加入系統環境變數 PATH

**官方版：**
- 路徑：`C:\Program Files\MySQL\MySQL Server 8.0\bin`
- 通常安裝時會自動加入 PATH

### 步驟 4：建立專案資料庫

連線成功後，執行：

```bash
# 如果使用 XAMPP（無密碼）
mysql -u root -e "CREATE DATABASE IF NOT EXISTS yili_meat_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -u root yili_meat_shop < database\schema.sql

# 如果使用官方版（密碼 12345）
mysql -u root -p12345 -e "CREATE DATABASE IF NOT EXISTS yili_meat_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -u root -p12345 yili_meat_shop < database\schema.sql
```

### 步驟 5：更新 .env 檔案

根據您的安裝方式，設定 `server/.env`：

**XAMPP（無密碼）：**
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=yili_meat_shop
```

**官方版（密碼 12345）：**
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=12345
DB_NAME=yili_meat_shop
```

---

## 推薦安裝方式

### 如果您是新手或只想快速開始
👉 **選擇 XAMPP**
- 安裝最簡單
- 預設無密碼，設定容易
- 包含 phpMyAdmin，方便管理資料庫

### 如果您需要生產環境或官方支援
👉 **選擇 MySQL 官方安裝程式**
- 更穩定可靠
- 官方支援

---

## 安裝完成後

1. 執行 `診斷MySQL.bat` 確認連線
2. 執行 `快速設定資料庫.bat` 建立資料庫
3. 執行 `檢查設定.bat` 驗證所有設定
4. 執行 `開始測試.bat` 啟動網站

---

## 需要幫助？

如果安裝過程中遇到問題，請提供：
1. 選擇的安裝方式（XAMPP / 官方版 / WAMP）
2. 錯誤訊息截圖
3. 安裝到哪個步驟

