#!/bin/bash

source config.sh

API_KEY="47AQH7TEOTQPFNJY"

URL_PARAMS=""
FIELD_NUM=1

###
### w1
###
TEMP1=$(./temperature/w1/get.sh "28-0416812d86ff")
echo "TEMP1=$TEMP1"
URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$TEMP1"
FIELD_NUM=$(($FIELD_NUM+1))

TEMP2=$(./temperature/w1/get.sh "28-0416816c14ff")
echo "TEMP2=$TEMP2"
URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$TEMP2"
FIELD_NUM=$(($FIELD_NUM+1))

TEMP3=$(./temperature/w1/get.sh "28-0000052d025e")
echo "TEMP3=$TEMP3"
URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$TEMP3"
FIELD_NUM=$(($FIELD_NUM+1))

###
### send
###
echo $(date)
echo "url_params=$URL_PARAMS"
wget -qO- "$API_URL?api_key=$API_KEY&$URL_PARAMS"
