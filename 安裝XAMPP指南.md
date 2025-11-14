# XAMPP 安裝詳細指南

## 為什麼選擇 XAMPP？

- ✅ 安裝最簡單，一鍵完成
- ✅ 包含 MySQL、Apache、PHP
- ✅ 包含 phpMyAdmin（圖形化資料庫管理工具）
- ✅ 預設無密碼，設定容易
- ✅ 適合開發環境

## 詳細安裝步驟

### 步驟 1：下載 XAMPP

1. 開啟瀏覽器，前往：
   ```
   https://www.apachefriends.org/zh_tw/index.html
   ```

2. 點擊「下載」按鈕
   - 選擇 Windows 版本
   - 建議下載最新版本（包含 MySQL 8.0）

3. 下載完成後，您會得到一個 `.exe` 安裝檔

### 步驟 2：安裝 XAMPP

1. **執行安裝檔**
   - 雙擊下載的 `.exe` 檔案
   - 如果出現安全性警告，點擊「執行」或「是」

2. **選擇安裝元件**
   - 在元件選擇畫面，至少勾選：
     - ✅ **MySQL**
     - ✅ **phpMyAdmin**（資料庫管理工具）
   - 其他元件可選（Apache、PHP 等）

3. **選擇安裝位置**
   - 預設：`C:\xampp`
   - 建議使用預設位置

4. **完成安裝**
   - 點擊「Next」完成安裝
   - 安裝完成後，會詢問是否開啟 XAMPP Control Panel
   - 選擇「是」

### 步驟 3：啟動 MySQL

1. **開啟 XAMPP Control Panel**
   - 如果沒有自動開啟，從開始選單搜尋「XAMPP Control Panel」

2. **啟動 MySQL**
   - 在 XAMPP Control Panel 中找到「MySQL」
   - 點擊右側的「Start」按鈕
   - 狀態應變為「Running」（綠色）

3. **確認服務運行**
   - 開啟服務管理員（`services.msc`）
   - 應該可以看到 MySQL 服務正在運行

### 步驟 4：測試 MySQL 連線

1. **開啟命令提示字元（cmd）**

2. **測試連線**
   ```bash
   # 切換到 XAMPP MySQL 目錄
   cd C:\xampp\mysql\bin
   
   # 測試連線（XAMPP 預設無密碼）
   mysql -u root
   ```

3. **如果看到 `mysql>` 提示符**
   - 表示連線成功！
   - 輸入 `exit;` 退出

### 步驟 5：設定環境變數（讓 mysql 命令在任何地方都能用）

1. **開啟系統環境變數設定**
   - 按 `Win + R`，輸入 `sysdm.cpl`，按 Enter
   - 切換到「進階」標籤
   - 點擊「環境變數」

2. **編輯 PATH 變數**
   - 在「系統變數」中找到「Path」
   - 點擊「編輯」
   - 點擊「新增」
   - 輸入：`C:\xampp\mysql\bin`
   - 點擊「確定」儲存

3. **重新開啟命令提示字元**
   - 關閉現有的 cmd 視窗
   - 開啟新的 cmd 視窗
   - 現在可以在任何地方使用 `mysql` 命令

### 步驟 6：建立專案資料庫

1. **開啟命令提示字元**

2. **建立資料庫**
   ```bash
   mysql -u root -e "CREATE DATABASE IF NOT EXISTS yili_meat_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
   ```

3. **匯入資料庫結構**
   ```bash
   # 切換到專案目錄
   cd C:\Users\humbl\OneDrive\文件\CURSOR\shoppingPage1.1
   
   # 匯入資料庫結構
   mysql -u root yili_meat_shop < database\schema.sql
   ```

### 步驟 7：設定 .env 檔案

在 `server` 目錄建立或編輯 `.env` 檔案：

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=yili_meat_shop
JWT_SECRET=yili-secret-key-12345
PORT=5000
EMAIL_USER=humblemars@gmail.com
EMAIL_PASS=
```

**注意：** `DB_PASSWORD=` 後面留空，因為 XAMPP 預設無密碼

### 步驟 8：驗證設定

執行：
```bash
cd server
npm run test-db
```

應該看到：
```
✅ 資料庫連線成功！
✅ 找到管理員帳號
```

## 使用 phpMyAdmin 管理資料庫（可選）

XAMPP 包含 phpMyAdmin，提供圖形化介面管理資料庫：

1. **開啟 phpMyAdmin**
   - 在 XAMPP Control Panel 中，點擊 MySQL 右側的「Admin」按鈕
   - 或開啟瀏覽器，訪問：http://localhost/phpmyadmin

2. **登入**
   - 使用者名稱：`root`
   - 密碼：留空（XAMPP 預設無密碼）

3. **建立資料庫**
   - 點擊左側「新增」
   - 資料庫名稱：`yili_meat_shop`
   - 字元集：`utf8mb4_unicode_ci`
   - 點擊「建立」

4. **匯入 SQL**
   - 選擇 `yili_meat_shop` 資料庫
   - 點擊「匯入」標籤
   - 選擇 `database/schema.sql` 檔案
   - 點擊「執行」

## 常見問題

### Q: XAMPP Control Panel 無法啟動 MySQL？

**A:** 可能原因：
1. 端口被占用（通常是 3306）
2. 需要管理員權限

**解決方法：**
- 以管理員身份執行 XAMPP Control Panel
- 檢查是否有其他 MySQL 服務在運行

### Q: mysql 命令找不到？

**A:** 需要將 MySQL 加入系統 PATH（見步驟 5）

### Q: 如何停止 MySQL？

**A:** 在 XAMPP Control Panel 中，點擊 MySQL 的「Stop」按鈕

### Q: 如何設定 MySQL 密碼？

**A:** 
1. 使用 phpMyAdmin 登入
2. 點擊「使用者帳號」標籤
3. 編輯 root 使用者，設定密碼
4. 記得更新 `.env` 檔案中的 `DB_PASSWORD`

## 完成後

安裝完成後，執行：
1. `診斷MySQL.bat` - 確認連線
2. `檢查設定.bat` - 驗證所有設定
3. `開始測試.bat` - 啟動網站

現在您可以使用以下帳號登入後台：
- **帳號**：`admin`
- **密碼**：`12345`

