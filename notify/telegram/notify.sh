#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh
source $DIR/../config.sh

API_KEY="$1"
CHAT_ID="$2"
MSG="$3"

URL="https://api.telegram.org/bot$API_KEY/sendMessage"
#echo $URL

curl "$URL" -s \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
--data @<(cat <<EOF
{"chat_id": "$CHAT_ID", "text": "$MSG"}
EOF
) >> $LOGFILE



