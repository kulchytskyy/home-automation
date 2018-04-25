#!/bin/bash

source upload/config.sh

API_KEY="47AQH7TEOTQPFNJY"

URL_PARAMS=""
FIELD_NUM=1

###
### w1
###
TEMP1=$(./temperature/w1/get.sh "28-0416812d86ff")
echo "TEMP1=$TEMP1"
if [ ! -z $TEMP1 ]; then
   URL_PARAMS="$URL_PARAMS&field1=$TEMP1"
fi

TEMP2=$(./temperature/w1/get.sh "28-0416816c14ff")
echo "TEMP2=$TEMP2"
if [ ! -z $TEMP2 ]; then
   URL_PARAMS="$URL_PARAMS&field2=$TEMP2"
fi

TEMP3=$(./temperature/w1/get.sh "28-0000052d025e")
echo "TEMP3=$TEMP3"
if [ ! -z $TEMP3 ]; then
   URL_PARAMS="$URL_PARAMS&field3=$TEMP3"
fi

###
### send
###
echo $(date)
echo "url_params=$URL_PARAMS"
wget -qO- "$API_URL?api_key=$API_KEY&$URL_PARAMS"
