#!/bin/bash
# 查詢天氣歷史紀錄
# 用法: bash weather-query.sh [YYYY-MM]
# 預設查詢當月

MONTH="${1:-$(date +%Y-%m)}"
MONTH_DIR="weather-logs/${MONTH}"

if [ ! -d "$MONTH_DIR" ]; then
    echo "找不到 ${MONTH} 的天氣紀錄"
    exit 1
fi

echo "=== ${MONTH} 天氣紀錄 ==="
echo ""

for f in "$MONTH_DIR"/*.json; do
    [ -f "$f" ] || continue
    DATE=$(basename "$f" .json)
    # 先把 JSON 壓成一行再 grep
    ONELINE=$(tr -d '\n' < "$f")
    DESC=$(echo "$ONELINE" | grep -oP '"weatherDesc"\s*:\s*\[\s*\{\s*"value"\s*:\s*"\K[^"]+' | head -1)
    TEMP=$(grep -oP '"temp_C"\s*:\s*"\K[^"]+' "$f" | head -1)
    HUMIDITY=$(grep -oP '"humidity"\s*:\s*"\K[^"]+' "$f" | head -1)
    PRECIP=$(grep -oP '"precipMM"\s*:\s*"\K[^"]+' "$f" | head -1)
    echo "${DATE} | ${TEMP}°C | 濕度${HUMIDITY}% | 降雨${PRECIP}mm | ${DESC}"
done

echo ""
echo "=== 降雨統計 ==="
RAIN_DAYS=0
TOTAL_DAYS=0
for f in "$MONTH_DIR"/*.json; do
    [ -f "$f" ] || continue
    TOTAL_DAYS=$((TOTAL_DAYS + 1))
    # 檢查是否有降雨（precipMM > 0）或天氣描述含 rain/Rain/shower/drizzle
    PRECIP=$(grep -oP '"precipMM"\s*:\s*"\K[^"]+' "$f" | head -1)
    ONELINE2=$(tr -d '\n' < "$f")
    DESC=$(echo "$ONELINE2" | grep -oiP '"weatherDesc"\s*:\s*\[\s*\{\s*"value"\s*:\s*"\K[^"]+' | head -1)
    if echo "$PRECIP" | grep -qvP '^0(\.0)?$' 2>/dev/null || echo "$DESC" | grep -iqP 'rain|shower|drizzle|thunder'; then
        RAIN_DAYS=$((RAIN_DAYS + 1))
    fi
done
echo "共有 ${TOTAL_DAYS} 天紀錄，其中 ${RAIN_DAYS} 天有下雨"
