#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY1

URL_PARAMS=""

echo $(date) 

### ea2
T=`$DIR/../../sensor/get.sh livingroom`
echo "livingroom=$T"
if [ ! -z $T ]; then
   URL_PARAMS="$URL_PARAMS&field1=$T"
fi

T=`$DIR/../../sensor/get.sh outdoor`
echo "outdoor=$T"
if [ ! -z $T ]; then
   URL_PARAMS="$URL_PARAMS&field3=$T"
fi

###	emodul
EMODULE_STATUS=`$DIR/../../boiler/emodul/get.sh`
echo "EMODULE_STATUS=$EMODULE_STATUS"
if [ "$EMODULE_STATUS" = 'active' ]; then 

	for i in boiler_ch_temp boiler_outdoor_temp boiler_fan boiler_dhw; do
	   T=`$DIR/../../sensor/get.sh $i`
	   echo "$i=$T"
	   if [ ! -z $T ]; then
	      URL_PARAMS="$URL_PARAMS&field$N=$T"
	   fi
	   N=$(($N+1))
	done
fi


### send
echo "url_params=$URL_PARAMS"
if [ ! -z $URL_PARAMS ]; then
	wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"
fi

echo -e "\n\n"
