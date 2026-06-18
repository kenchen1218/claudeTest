#!/bin/bash
# 查詢天氣腳本 - 使用 wttr.in JSON API，並自動存檔
CITY="${1:-Taipei}"
DATE=$(date +%Y-%m-%d)
MONTH_DIR="weather-logs/$(date +%Y-%m)"
LOG_FILE="${MONTH_DIR}/${DATE}.json"

mkdir -p "$MONTH_DIR"

DATA=$(curl -s "https://wttr.in/${CITY}?format=j1" 2>/dev/null)

if [ -n "$DATA" ]; then
    echo "$DATA" > "$LOG_FILE"
    echo "$DATA"
fi
