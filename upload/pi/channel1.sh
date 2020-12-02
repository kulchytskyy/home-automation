#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY1

URL_PARAMS=""
FIELD_NUM=1

echo $(date) 

###
### ea2
###
for i in 15 14 31; do
   EA2T=`$DIR/../../temperature/ea2/get_temp.sh $i`
   echo "EA2T$i=$EA2T"
   if [ ! -z $EA2T ]; then
      URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$EA2T"
   fi
   FIELD_NUM=$(($FIELD_NUM+1))
done


###
###	emodul
###

EMODULE_STATUS=`$DIR/../../emodul/get.sh`
echo "EMODULE_STATUS=$EMODULE_STATUS"

if [ "$EMODULE_STATUS" = 'active' ]; then 

	EM_CH_TEMP=`$DIR/../../emodul/parse.sh 1006 sensor`
	echo "EM_CH_TEMP=$EM_CH_TEMP"
	URL_PARAMS="$URL_PARAMS&field4=$EM_CH_TEMP"

	EM_OUTDOOR_TEMP=`$DIR/../../emodul/parse.sh 1009 sensor`
	echo "EM_OUTDOOR_TEMP=$EM_OUTDOOR_TEMP"
	URL_PARAMS="$URL_PARAMS&field5=$EM_OUTDOOR_TEMP"

	EM_FAN=`$DIR/../../emodul/parse.sh 1011 fan`
	echo "EM_FAN=$EM_FAN"
	URL_PARAMS="$URL_PARAMS&field6=$EM_FAN"

	EM_DHW_TEMP=`$DIR/../../emodul/parse.sh 1007 sensor`
	echo "EM_DHW_TEMP=$EM_DHW_TEMP"
	URL_PARAMS="$URL_PARAMS&field7=$EM_DHW_TEMP"
fi

###
### send
###
echo "url_params=$URL_PARAMS"
if [ ! -z $URL_PARAMS ]; then
	wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"
fi

echo -e "\n\n"
