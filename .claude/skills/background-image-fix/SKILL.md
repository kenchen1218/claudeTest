---
description: 修復 HTML 電子報（eNews MIP）的背景圖顯示問題，涵蓋各郵件客戶端（特別是 Outlook）相容性
---

請用繁體中文回覆。

## 用途
專門修復 HTML email / eNews MIP 模板中**背景圖（background image）顯示異常**的問題，例如：
- 背景圖在 Outlook（Windows）不顯示
- 背景圖被裁切、沒填滿、位置跑掉、沒置中
- 背景圖在手機 / Gmail / Apple Mail 表現不一致
- 背景色 fallback 缺失，圖載入失敗時整塊變空白

相關脈絡：eNews 專案的 MIP HTML 在 `\\10.17.6.141\01_workout\eNews\cypress\cypress-framework\html_finalToMIP\`。

## 主要轉換規則（核心）

掃描目標 HTML，凡是看到 `<td ... background="圖片路徑">` 這種用 `background` **屬性**設背景圖的寫法，一律改寫成 CSS `background-image`：

- 移除 `background="圖片路徑"` 屬性
- 把 `background-image: url('圖片路徑');` 寫進該標籤的 `style`
  - 若該 `<td>` **原本就有** `style="..."`：把 `background-image: url('圖片路徑');` **接到 style 內容的最後方**（不要動原本的內容）
  - 若該 `<td>` **原本沒有** `style`：新增 `style="background-image: url('圖片路徑');"`
- url 內的圖片路徑用單引號包起來，並保持與原本 `background` 屬性完全相同的網址
- 不要改動標籤上的其他屬性（width、align、bgcolor 等）與既有 style 內容

**範例：**
```html
<!-- 修改前 -->
<td style="padding-left:32px; padding-right:32px;" background="https://example.com/bg.png">

<!-- 修改後 -->
<td style="padding-left:32px; padding-right:32px;background-image: url('https://example.com/bg.png');">
```

處理完回報：總共改了幾處、各在第幾行，並列出 before/after。

## 其他背景圖問題的修復流程

1. **定位背景圖**：讀取目標 HTML，找出使用背景圖的 `<td background="...">`、`style="background-image:url(...)"`，以及對應的 Outlook VML 區塊（`<!--[if gte mso 9]> <v:rect>...<v:fill> ... <![endif]-->`）。

2. **診斷問題**，常見原因對照：
   - **Outlook 不顯示**：缺少 VML fallback，或 `<v:fill src="">` 路徑/尺寸不對 → 補上或修正 VML（`<v:rect>` 的 width/height 要與設計一致、`<v:fill type="frame" src="圖片URL">`）
   - **沒填滿/被裁切**：缺 `background-size:cover`、`background-position:center center`、`background-repeat:no-repeat`
   - **路徑問題**：VML 的 `src` 用相對路徑（如 `images/image-3.png`）但實際應為完整 URL → 改成與 `background` 屬性相同的絕對網址
   - **fallback 缺失**：背景所在 `<td>` 補上 `bgcolor` / `background-color` 當底色

3. **修改**：套用修正，盡量同時顧及一般客戶端（HTML/CSS）與 Outlook（VML），不破壞既有的 table 排版。

4. **驗證**：
   - 檢查修改後 HTML 結構正確、標籤閉合、VML 條件註解完整
   - 若 eNews 有對應的 Cypress 測試（`cypress/e2e/eNews_template.cy.js` 等），跑測試確認：`npx cypress run --spec "cypress/e2e/<檔名>.cy.js"`
   - 回報實際結果，不要只說「應該修好了」

5. **總結**：說明背景圖原本壞在哪、改了什麼、各客戶端預期表現。提醒檔案位於網路磁碟，與本 repo 版控不同。
