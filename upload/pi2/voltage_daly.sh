#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY_N1

URL_PARAMS=""

echo $(date) 

### DALY BMS

DALY_DIR="$DIR/../../battery/bms/daly"
DALY_DATA=$($DALY_DIR/get.sh all)
echo $DALY_DATA

DALY_VOLTAGE=$(echo $DALY_DATA | $DALY_DIR/parse.sh voltage)
echo "DALY_VOLTAGE=$DALY_VOLTAGE"
if [ ! -z $DALY_VOLTAGE ]; then
   URL_PARAMS="$URL_PARAMS&field4=$DALY_VOLTAGE"
fi

DALY_POWER=$(echo $DALY_DATA | $DALY_DIR/parse.sh power)
echo "DALY_POWER=$DALY_POWER"
if [ ! -z $DALY_POWER ]; then
   URL_PARAMS="$URL_PARAMS&field5=$DALY_POWER"
fi

DALY_SOC=$(echo $DALY_DATA | $DALY_DIR/parse.sh soc)
echo "DALY_SOC=$DALY_SOC"
if [ ! -z $DALY_SOC ]; then
   URL_PARAMS="$URL_PARAMS&field6=$DALY_SOC"
fi

DALY_DIFF=$(echo $DALY_DATA | $DALY_DIR/parse.sh cells_diff)
echo "DALY_DIFF=$DALY_DIFF"
if [ ! -z $DALY_DIFF ]; then
   URL_PARAMS="$URL_PARAMS&field7=$DALY_DIFF"
fi


###
### send
###
echo "url_params=$URL_PARAMS"
#wget -v -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
