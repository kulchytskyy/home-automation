#!/bin/bash

F=/var/local/ea2temp.csv

W1_DEVICES_DIR="/sys/bus/w1/devices"
API_KEY="BQ3BEPLX2OPFEC81"
API_URL="https://api.thingspeak.com/update.json"


T1=`grep ,1, $F | tail -n 1 | cut -d , -f 6`
T2=`grep ,2, $F | tail -n 1 | cut -d , -f 6`
T3=`grep ,3, $F | tail -n 1 | cut -d , -f 6`

echo $T1
echo $T2
echo $T3

wget -qO- "$API_URL?api_key=$API_KEY&field6=$T1&field7=$T2&field8=$T3"

