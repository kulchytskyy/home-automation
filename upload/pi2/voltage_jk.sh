#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY_N1

URL_PARAMS=""

echo $(date) 

### JK BMS

JK_DIR="$DIR/../../battery/bms/jk"
$JK_DIR/get.sh

JK_VOLTAGE=$($JK_DIR/parse.sh voltage)
echo "JK_VOLTAGE=$JK_VOLTAGE"
if [ ! -z $JK_VOLTAGE ]; then
   URL_PARAMS="$URL_PARAMS&field8=$JK_VOLTAGE"
fi

JK_POWER=$($JK_DIR/parse.sh power)
echo "JK_POWER=$JK_POWER"
if [ ! -z $JK_POWER ]; then
   URL_PARAMS="$URL_PARAMS&field1=$JK_POWER"
fi

JK_SOC=$($JK_DIR/parse.sh soc)
echo "JK_SOC=$JK_SOC"
if [ ! -z $JK_SOC ]; then
   URL_PARAMS="$URL_PARAMS&field2=$JK_SOC"
fi

JK_DIFF=$($JK_DIR/parse.sh cells_diff)
echo "JK_DIFF=$JK_DIFF"
if [ ! -z $JK_DIFF ]; then
   URL_PARAMS="$URL_PARAMS&field3=$JK_DIFF"
fi


###
### send
###
echo "url_params=$URL_PARAMS"
#wget -v -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
