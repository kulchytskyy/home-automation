#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY1

URL_PARAMS=""

echo $(date) 

###
### w1
###

BOILER2_CH_TEMP=$($DIR/../../sensor/get.sh boiler2_ch_temp)
if [ -z $BOILER2_CH_TEMP ]; then
	echo "Retrieving boilder2 ch temp from emodul"
	BOILER2_CH_TEMP=$($DIR/../../sensor/get.sh boiler2_ch_emodul_temp)
	if [ ! -z $BOILER2_CH_TEMP ]; then
		echo "BOILER2_CH_EMODUL_TEMP=$BOILER2_CH_TEMP"
		URL_PARAMS="$URL_PARAMS&field2=$BOILER2_CH_TEMP"
	fi
else 
	echo "BOILER2_CH_TEMP=$BOILER2_CH_TEMP"
	URL_PARAMS="$URL_PARAMS&field2=$BOILER2_CH_TEMP"
fi

DHW_TOP=$($DIR/../../sensor/get.sh dhw_top)
echo "DHW_TOP=$DHW_TOP"
if [ ! -z $DHW_TOP ]; then
   URL_PARAMS="$URL_PARAMS&field7=$DHW_TOP"
fi


#DHW_CENTER=$($DIR/../../sensor/get.sh dhw_center)
#echo "DHW_CENTER=$DHW_CENTER"
#if [ ! -z $DHW_CENTER ]; then
#   URL_PARAMS="$URL_PARAMS&field8=$DHW_CENTER"
#fi


###
### send
###
echo "url_params=$URL_PARAMS"
wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
