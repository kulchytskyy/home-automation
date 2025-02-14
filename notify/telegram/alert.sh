#!/bin/bash

DIR=$(dirname "$0")
source $DIR/config.sh
source $DIR/../config.sh

MSG="$1"

#echo $TELEGRAM_HA_ALERT_BOT_API_KEY
#echo $ALERTS_CHAT_ID
#echo $MSG

$DIR/notify.sh "$TELEGRAM_HA_ALERT_BOT_API_KEY" "$ALERTS_CHAT_ID" "$MSG"
