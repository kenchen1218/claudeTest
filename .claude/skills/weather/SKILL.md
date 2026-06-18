---
description: 查詢今天的天氣狀況（預設台北，可指定城市），並自動存檔至 weather-logs/
---

請用繁體中文回覆。

1. 使用 Bash 執行 `bash weather.sh [城市]` 來查詢天氣（預設台北，如果使用者有指定城市則帶入城市名稱，例如 `bash weather.sh Tokyo`）
   - 腳本會自動將結果存檔至 `weather-logs/YYYY-MM/YYYY-MM-DD.json`
2. 從 JSON 結果中擷取以下資訊並用易讀格式呈現：
   - 地點（nearest_area 的 areaName 和 country）
   - 天氣描述（weatherDesc）
   - 氣溫（temp_C）和體感溫度（FeelsLikeC）
   - 今日最高/最低溫（weather[0] 的 maxtempC / mintempC）
   - 濕度（humidity）
   - 降雨量（precipMM）
   - 風速與風向（windspeedKmph, winddir16Point）
   - 紫外線指數（uvIndex）
3. 根據天氣狀況給出簡短的生活建議（例如：帶傘、防曬、多喝水等）
4. 最後提醒使用者：今日天氣已記錄，可用 `/天氣統計` 查看歷史紀錄
