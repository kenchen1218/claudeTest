---
description: 自動產生 git commit 訊息並提交
---

請執行以下步驟：
1. 執行 `git diff --staged` 查看已暫存的變更
2. 如果沒有已暫存的變更，執行 `git diff` 查看未暫存的變更並提示使用者先執行 `git add`
3. 根據變更內容，以繁體中文產生一條清楚的 commit 訊息，格式為：`類型: 簡短描述`
   - 類型可以是：feat（新功能）、fix（修正）、refactor（重構）、docs（文件）、chore（雜項）
4. 詢問使用者是否確認這條 commit 訊息
5. 確認後執行 `git commit -m "訊息"`
