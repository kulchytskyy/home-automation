#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY3

URL_PARAMS=""

echo $(date) 

###
### w1
###
TEMP1=$($DIR/../../sensor/get.sh basement_laundry)
echo "TEMP1=$TEMP1"
if [ ! -z $TEMP1 ]; then
   URL_PARAMS="$URL_PARAMS&field1=$TEMP1"
fi

TEMP2=$($DIR/../../sensor/get.sh basement_large)
echo "TEMP2=$TEMP2"
if [ ! -z $TEMP2 ]; then
   URL_PARAMS="$URL_PARAMS&field2=$TEMP2"
fi

TEMP3=$($DIR/../../sensor/get.sh basement_boiler)
echo "TEMP3=$TEMP3"
if [ ! -z $TEMP3 ]; then
   URL_PARAMS="$URL_PARAMS&field3=$TEMP3"
fi

#VOLTAGE1=$($DIR/../../sensor/get.sh voltage1)
#echo "VOLTAGE1=$VOLTAGE1"
#if [ ! -z $VOLTAGE1 ]; then
#   URL_PARAMS="$URL_PARAMS&field7=$VOLTAGE1"
#fi

#VOLTAGE2=$($DIR/../../sensor/get.sh voltage2)
#echo "VOLTAGE2=$VOLTAGE2"
#if [ ! -z $VOLTAGE2 ]; then
#   URL_PARAMS="$URL_PARAMS&field8=$VOLTAGE2"
#fi

###
### send
###
echo "url_params=$URL_PARAMS"
wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
