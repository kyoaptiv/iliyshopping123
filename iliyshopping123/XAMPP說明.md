# XAMPP MySQL 說明

## ✅ 關於系統服務

### XAMPP MySQL 不會註冊為 Windows 系統服務

**這是正常的！** XAMPP 的 MySQL 是作為應用程式運行，不是系統服務。

### 如何確認 MySQL 正在運行？

**方法 1：XAMPP Control Panel（最簡單）**
- 開啟 XAMPP Control Panel
- 查看 MySQL 那一行
- 如果顯示「Stop」按鈕（紅色），表示正在運行 ✅
- 如果顯示「Start」按鈕（綠色），表示未運行 ❌

**方法 2：檢查端口**
- MySQL 預設使用端口 3306
- 如果端口被占用，通常表示 MySQL 正在運行

### 為什麼找不到系統服務？

XAMPP 設計為：
- 開發環境使用
- 不需要管理員權限
- 不註冊為系統服務（避免與其他 MySQL 安裝衝突）

### 如果需要註冊為系統服務（可選）

如果您希望 MySQL 開機自動啟動，可以：

1. 開啟 XAMPP Control Panel
2. 點擊 MySQL 右側的「Config」按鈕
3. 選擇「Register MySQL as Service」
4. 這樣 MySQL 就會註冊為系統服務

**注意：** 通常不需要這樣做，在 XAMPP Control Panel 中啟動即可。

---

## 🔧 使用 XAMPP MySQL

### 基本操作

1. **啟動 MySQL**
   - 開啟 XAMPP Control Panel
   - 點擊 MySQL 的「Start」按鈕
   - 等待狀態變為「Running」

2. **停止 MySQL**
   - 在 XAMPP Control Panel 中
   - 點擊 MySQL 的「Stop」按鈕

3. **查看日誌**
   - 點擊 MySQL 的「Logs」按鈕
   - 可以查看 MySQL 的運行日誌和錯誤訊息

### 連線資訊

- **主機**：`localhost` 或 `127.0.0.1`
- **端口**：`3306`（預設）
- **使用者名稱**：`root`
- **密碼**：**無密碼**（XAMPP 預設）

### 設定密碼（可選）

如果您想為 root 設定密碼：

1. 開啟 XAMPP Control Panel
2. 點擊 MySQL 的「Admin」按鈕（開啟 phpMyAdmin）
3. 在 phpMyAdmin 中設定密碼
4. 記得更新 `server/.env` 檔案中的 `DB_PASSWORD`

---

## 📝 專案設定

### .env 檔案設定

因為 XAMPP MySQL 預設無密碼，`server/.env` 檔案應該設定為：

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=yili_meat_shop
JWT_SECRET=yili-secret-key-12345
PORT=5000
```

**重要：** `DB_PASSWORD=` 後面留空！

---

## ✅ 總結

1. ✅ **XAMPP MySQL 不註冊為系統服務是正常的**
2. ✅ **只要在 XAMPP Control Panel 中啟動 MySQL 就可以使用**
3. ✅ **XAMPP 預設無密碼，連線時不需要密碼**
4. ✅ **不需要管理員權限就可以使用**

如果 XAMPP Control Panel 顯示 MySQL 正在運行，就可以正常使用了！

