---
description: 移除 eNews / HTML email 中 style 屬性裡的 height 宣告（如 height: 52px;），保留 style 內其他宣告，若清空則留下 style=""
---

請用繁體中文回覆。

## 用途
電子報 / HTML email 的 inline `style="..."` 裡常有 `height: xxpx;` 這種固定高度宣告，會造成某些客戶端（特別是 Outlook）排版被撐高或跑版。這個 skill 專門把 **`style` 內的 `height` 宣告整段移除**，其餘宣告完全保留。

## 核心規則

掃描目標 HTML，凡是 `style="..."` 內含 `height` 屬性，移除該段 `height: 值;` 宣告：

- **只移除 `height` 這個屬性**，其他宣告（`line-height`、`vertical-align`、`font-size`、`padding`…）一律原樣保留。
- 高度的**值不限單位**：`px`、`%`、`em`、`auto`… 都一併移除（例如 `height: 52px;`、`height: auto;`）。
- 移除後若 `style` 內**還有其他宣告** → 保留那些宣告，順手清掉多餘的分號與前後空白。
- 移除後若 `style` 內**已無任何宣告** → 留下空的 `style=""`（不要把整個 style 屬性刪掉）。

**範例：**
```html
<!-- 修改前 -->                              <!-- 修改後 -->
style="height: 52px;"                        style=""
style="vertical-align: top; height: 52px;"   style="vertical-align: top;"
style="line-height: 52px; height: 52px; font-size: 52px;"   style="line-height: 52px; font-size: 52px;"
style="height: 52px; font-size: 52px;"       style="font-size: 52px;"
```

## 不要誤刪（重要）

- **`line-height`、`min-height`、`max-height` 不是 `height`**，必須保留。比對時要鎖定屬性名是「`height`」，不是只看到字串 `height` 就刪（會把 `line-height` 砍掉）。
- 只處理 **`style` 屬性內**的 `height`。HTML 標籤上獨立的 `height="52"` 屬性（不是寫在 style 裡的那種）**不在此 skill 範圍**，預設不動；若使用者要連那個也刪，請先確認。

## 執行流程

1. **讀取目標 HTML**：用 Read 載入要處理的檔案。
2. **找出所有目標**：搜尋 `style="..."` 內含 `height:` 宣告之處（排除 `line-height` / `min-height` / `max-height`）。
3. **逐處移除**：套用上面的核心規則，保留其他宣告，空了就留 `style=""`。
4. **回報**：總共改了幾處、各在第幾行，並列出 before/after。
5. **提醒**：eNews 檔多位於網路磁碟 `\\10.17.6.141\01_workout\eNews\...`，與本 repo 版控不同；建議寄測確認排版。
