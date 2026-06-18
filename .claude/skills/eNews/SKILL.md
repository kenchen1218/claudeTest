---
description: 修復 eNews Cypress 測試框架的 bug（定位問題、修改、跑 Cypress 測試驗證）
---

請用繁體中文回覆。

## 專案資訊
- eNews 是一個 **Cypress e2e 測試自動化框架**（作者 Ken）。
- 專案路徑（網路磁碟）：`\\10.17.6.141\01_workout\eNews\cypress\cypress-framework`
  - 在 Bash 工具中使用 POSIX 路徑：`//10.17.6.141/01_workout/eNews/cypress/cypress-framework`
- 測試檔位置：`cypress/e2e/`
  - `eNews.cy.js`、`eNews_channelEnews.cy.js`、`eNews_monthlyReport.cy.js`、`eNews_template.cy.js`
- 共用指令：`cypress/support/commands.js`、`cypress/support/e2e.js`
- 設定檔：`cypress.config.js`
- 開啟測試：`npm run cy:open`（= `cypress open`）；CLI 跑測試用 `npx cypress run`

## 修 bug 流程

1. **確認專案可存取**：先確認網路路徑能讀取（無法存取時提醒使用者連線/掛載網路磁碟或檢查權限）。

2. **了解 bug**：問清楚使用者遇到的現象 — 是哪一支測試失敗、錯誤訊息為何，或是哪個 eNews 電子報模板/HTML 有問題。

3. **定位問題**：
   - 讀取相關的 `cypress/e2e/*.cy.js` 測試與 `support/commands.js`
   - 找出失敗的 selector、斷言、或對應的 HTML 模板（專案根目錄有 `*.html` 測試檔）
   - 指出出問題的檔案與行數

4. **修改**：提出並套用修正，遵循該專案既有的 Cypress 寫法與風格（命名、自訂指令慣例）。

5. **測試驗證**（重點）：
   - 修改後跑 Cypress 驗證，優先只跑受影響的測試：
     `npx cypress run --spec "cypress/e2e/<檔名>.cy.js"`
   - 確認測試由紅轉綠；若仍失敗，依錯誤訊息回到步驟 3 再定位
   - 回報實際的測試輸出（通過/失敗數），不要只說「應該修好了」

6. **總結**：說明 bug 的根本原因、改了什麼、測試結果。如修改了 eNews 專案的檔案，提醒使用者該專案在網路磁碟上、與本 repo 是不同的 git 控管範圍。
