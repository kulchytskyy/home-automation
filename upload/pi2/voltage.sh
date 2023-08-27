#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY_N1

URL_PARAMS=""

echo $(date) 

#VOLTAGE1=$($DIR/../../sensor/get.sh voltage1)
#echo "VOLTAGE1=$VOLTAGE1"
#if [ ! -z $VOLTAGE1 ]; then
#   URL_PARAMS="$URL_PARAMS&field1=$VOLTAGE1"
#fi

#VOLTAGE2=$($DIR/../../sensor/get.sh voltage2)
#echo "VOLTAGE2=$VOLTAGE2"
#if [ ! -z $VOLTAGE2 ]; then
#   URL_PARAMS="$URL_PARAMS&field2=$VOLTAGE2"
#fi

#VOLTAGE3=$($DIR/../../sensor/get.sh voltage3)
#echo "VOLTAGE3=$VOLTAGE3"
#if [ ! -z $VOLTAGE3 ]; then
#   URL_PARAMS="$URL_PARAMS&field2=$VOLTAGE3"
#fi

DALY_VOLTAGE=$($DIR/../../battery/bms/daly/get.sh voltage)
echo "DALY_VOLTAGE=$DALY_VOLTAGE"
if [ ! -z $DALY_VOLTAGE ]; then
   URL_PARAMS="$URL_PARAMS&field4=$DALY_VOLTAGE"
fi

DALY_POWER=$($DIR/../../battery/bms/daly/get.sh power)
echo "DALY_POWER=$DALY_POWER"
if [ ! -z $DALY_POWER ]; then
   URL_PARAMS="$URL_PARAMS&field5=$DALY_POWER"
fi

DALY_SOC=$($DIR/../../battery/bms/daly/get.sh soc)
echo "DALY_SOC=$DALY_SOC"
if [ ! -z $DALY_SOC ]; then
   URL_PARAMS="$URL_PARAMS&field6=$DALY_SOC"
fi

DALY_DIFF=$($DIR/../../battery/bms/daly/get.sh cells_diff)
echo "DALY_DIFF=$DALY_DIFF"
if [ ! -z $DALY_DIFF ]; then
   URL_PARAMS="$URL_PARAMS&field7=$DALY_DIFF"
fi


###
### send
###
echo "url_params=$URL_PARAMS"
wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
