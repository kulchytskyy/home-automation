#!/bin/bash

DIR=$(dirname $0)
source $DIR/config.sh

API_KEY=API_KEY1

URL_PARAMS=""
FIELD_NUM=1

###
### ea2
###
for i in 15 14 35; do
   EA2T=`$DIR/../temperature/ea2/get.sh $i`
   echo "EA2T$i=$EA2T"
   if [ ! -z $EA2T ]; then
      URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$EA2T"
   fi
   FIELD_NUM=$(($FIELD_NUM+1))
done


###
###	emodul
###

EMODULE_STATUS=`$DIR/../emodul/get.sh`
echo "EMODULE_STATUS=$EMODULE_STATUS"

if [ "$EMODULE_STATUS" = 'active' ]; then 

	EM_TEMP1=`$DIR/../emodul/parse.sh 1006 sensor`
	echo "EM_TEMP1=$EM_TEMP1"
	URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$EM_TEMP1"
	FIELD_NUM=$(($FIELD_NUM+1))

	#EM_TEMP2=`$DIR/../emodul/parse.sh 1008 sensor`
	#echo "EM_TEMP2=$EM_TEMP2"
	#URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$EM_TEMP2"
	#FIELD_NUM=$(($FIELD_NUM+1))

	EM_TEMP3=`$DIR/../emodul/parse.sh 1009 sensor`
	echo "EM_TEMP3=$EM_TEMP3"
	URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$EM_TEMP3"
	FIELD_NUM=$(($FIELD_NUM+1))

	EM_FAN=`$DIR/../emodul/parse.sh 1011 fan`
	echo "EM_FAN=$EM_FAN"
	URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$EM_FAN"
	FIELD_NUM=$(($FIELD_NUM+1))

fi

###
### send
###
echo $(date)
echo "url_params=$URL_PARAMS"
if [ ! -z $URL_PARAMS ]; then
	wget -qO- "$API_URL?api_key=$API_KEY&$URL_PARAMS"
fi
