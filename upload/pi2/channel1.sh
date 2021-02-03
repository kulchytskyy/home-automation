#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY1

URL_PARAMS=""

echo $(date) 

###
### w1
###
DHW_CENTER=$($DIR/../../sensor/get.sh dhw_center)
echo "DHW_CENTER=$DHW_CENTER"
if [ ! -z $DHW_CENTER ]; then
   URL_PARAMS="$URL_PARAMS&field8=$DHW_CENTER"
fi

###
### send
###
echo "url_params=$URL_PARAMS"
wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
