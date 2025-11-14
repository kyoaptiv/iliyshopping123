# MySQL 官方版安裝指南

## 下載與安裝

### 步驟 1：下載 MySQL Installer

1. **前往 MySQL 官方網站**
   ```
   https://dev.mysql.com/downloads/installer/
   ```

2. **選擇下載版本**
   - **推薦**：`mysql-installer-community`（較小，約 400MB）
   - 或：`mysql-installer-web-community`（需要網路連線）

3. **點擊「Download」**
   - 可能需要註冊 Oracle 帳號（可選擇「No thanks, just start my download」跳過）

### 步驟 2：安裝 MySQL

1. **執行安裝檔**
   - 雙擊下載的 `.msi` 檔案
   - 如果出現安全性警告，點擊「執行」

2. **選擇安裝類型**
   - **推薦**：選擇「Developer Default」（開發者預設）
     - 包含 MySQL Server、MySQL Workbench、MySQL Shell 等
   - 或選擇「Server only」（僅伺服器）

3. **檢查需求**
   - 安裝程式會檢查系統需求
   - 如果有缺少的元件，會自動下載安裝
   - 點擊「Execute」開始安裝

4. **產品配置**
   - 選擇「Standalone MySQL Server / Classic MySQL Replication」
   - 點擊「Next」

5. **類型與網路設定**
   - **Config Type**：選擇「Development Computer」（開發電腦）
   - **Port**：使用預設 3306
   - 點擊「Next」

6. **認證方法**
   - 選擇「Use Strong Password Encryption」（使用強密碼加密）
   - 點擊「Next」

7. **設定 root 密碼** ⭐ 重要
   - **MySQL Root Password**：輸入 `12345`（方便後續設定）
   - **Repeat Password**：再次輸入 `12345`
   - **記住這個密碼！**
   - 點擊「Next」

8. **Windows 服務設定**
   - **Windows Service Name**：使用預設 `MySQL80`
   - 勾選「Start the MySQL Server at System Startup」（開機自動啟動）
   - 點擊「Next」

9. **應用程式配置**
   - 點擊「Execute」套用設定
   - 等待配置完成

10. **完成安裝**
    - 點擊「Finish」完成安裝

### 步驟 3：驗證安裝

1. **檢查服務**
   - 開啟服務管理員（`services.msc`）
   - 確認「MySQL80」服務正在運行

2. **測試連線**
   - 開啟命令提示字元（cmd）
   - 執行：
     ```bash
     mysql -u root -p12345
     ```
   - 如果看到 `mysql>` 提示符，表示安裝成功！
   - 輸入 `exit;` 退出

### 步驟 4：設定環境變數（通常已自動設定）

MySQL Installer 通常會自動將 MySQL 加入系統 PATH。

如果 `mysql` 命令找不到，手動加入：
- 路徑：`C:\Program Files\MySQL\MySQL Server 8.0\bin`
- 加入系統環境變數 PATH

### 步驟 5：建立專案資料庫

1. **建立資料庫**
   ```bash
   mysql -u root -p12345 -e "CREATE DATABASE IF NOT EXISTS yili_meat_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
   ```

2. **匯入資料庫結構**
   ```bash
   # 切換到專案目錄
   cd C:\Users\humbl\OneDrive\文件\CURSOR\shoppingPage1.1
   
   # 匯入資料庫結構
   mysql -u root -p12345 yili_meat_shop < database\schema.sql
   ```

### 步驟 6：設定 .env 檔案

在 `server` 目錄建立或編輯 `.env` 檔案：

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=12345
DB_NAME=yili_meat_shop
JWT_SECRET=yili-secret-key-12345
PORT=5000
EMAIL_USER=humblemars@gmail.com
EMAIL_PASS=
```

### 步驟 7：驗證設定

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

## 使用 MySQL Workbench（可選）

MySQL Workbench 是圖形化資料庫管理工具，已包含在安裝中：

1. **開啟 MySQL Workbench**
   - 從開始選單搜尋「MySQL Workbench」

2. **建立連線**
   - 點擊「MySQL Connections」旁的「+」號
   - Connection Name：`Local MySQL`
   - Username：`root`
   - Password：`12345`（點擊「Store in Keychain」儲存）
   - 點擊「Test Connection」測試
   - 點擊「OK」儲存

3. **連線到資料庫**
   - 雙擊建立的連線
   - 輸入密碼（如果未儲存）

4. **建立資料庫**
   - 在左側導航中，右鍵點擊 → 「Create Schema」
   - Schema Name：`yili_meat_shop`
   - Default Collation：`utf8mb4_unicode_ci`
   - 點擊「Apply」

5. **匯入 SQL**
   - 選擇 `yili_meat_shop` 資料庫
   - 點擊「File」→「Open SQL Script」
   - 選擇 `database/schema.sql`
   - 點擊「Execute」執行

## 常見問題

### Q: 安裝時出現錯誤？

**A:** 
- 確認以管理員身份執行安裝程式
- 關閉防毒軟體後重試
- 檢查是否有其他 MySQL 版本已安裝

### Q: 忘記 root 密碼？

**A:** 需要重置密碼，步驟較複雜。建議：
- 使用 MySQL Workbench 嘗試連線（會提示輸入密碼）
- 或查看安裝時的設定記錄

### Q: MySQL 服務無法啟動？

**A:** 
- 檢查端口 3306 是否被占用
- 查看 MySQL 錯誤日誌
- 確認服務權限設定正確

## 完成後

安裝完成後，執行：
1. `診斷MySQL.bat` - 確認連線
2. `檢查設定.bat` - 驗證所有設定
3. `開始測試.bat` - 啟動網站

現在您可以使用以下帳號登入後台：
- **帳號**：`admin`
- **密碼**：`12345`

