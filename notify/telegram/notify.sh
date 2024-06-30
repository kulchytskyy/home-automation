#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh
source $DIR/../config.sh

MSG="$1"

URL="https://api.telegram.org/bot$TELEGRAM_HA_ALERT_BOT_API_KEY/sendMessage"
#echo $URL

curl "$URL" -s \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
--data @<(cat <<EOF
{"chat_id": "$CHAT_ID", "text": "$MSG"}
EOF
) >> $LOGFILE



