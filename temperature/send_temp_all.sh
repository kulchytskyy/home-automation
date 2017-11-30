#!/bin/bash

W1_DEVICES_DIR="/sys/bus/w1/devices"
API_KEY="BQ3BEPLX2OPFEC81"
API_KEY2="47AQH7TEOTQPFNJY"
API_URL="https://api.thingspeak.com/update.json"

TEMP1=$(./get_temp.sh "28-0416812d86ff")
echo "TEMP1=$TEMP1"

TEMP2=$(./get_temp.sh "28-0416816c14ff")
echo "TEMP2=$TEMP2"

TEMP3=$(./get_temp.sh "28-0000052d025e")
echo "TEMP3=$TEMP3"


URL_PARAMS=""
FIELD_NUM=1

URL_PARAMS2=""
FIELD_NUM2=1

WORK_DIR=$(pwd)

#cd $W1_DEVICES_DIR
#for DEVICE in *; do
#  if [[ $DEVICE != w1_bus_master* ]]; then
#    TEMP=$($WORK_DIR/get_temp.sh "$DEVICE")
#    echo $DEVICE $FIELD_NUM $TEMP
#    URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$TEMP"
#    FIELD_NUM=$(($FIELD_NUM+1))
#  fi
#done

for i in $(seq 1 3); do
   EA2T=`/usr/local/sbin/ea2temp_get.sh $i`
   echo "EA2T$i=$EA2T"
   URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$EA2T"
   FIELD_NUM=$(($FIELD_NUM+1))
done

`./emodul_get.sh`

EM_TEMP1=`./emodul_parse.sh 1006 sensor`
echo "EM_TEMP1=$EM_TEMP1"
URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$EM_TEMP1"
FIELD_NUM=$(($FIELD_NUM+1))

#EM_TEMP2=`./emodul_parse.sh 1008 sensor`
#echo "EM_TEMP2=$EM_TEMP2"
#URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$EM_TEMP2"
#FIELD_NUM=$(($FIELD_NUM+1))

EM_TEMP3=`./emodul_parse.sh 1009 sensor`
echo "EM_TEMP3=$EM_TEMP3"
URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$EM_TEMP3"
FIELD_NUM=$(($FIELD_NUM+1))

EM_FAN=`./emodul_parse.sh 1011 fan`
echo "EM_FAN=$EM_FAN"
URL_PARAMS="$URL_PARAMS&field$FIELD_NUM=$EM_FAN"
FIELD_NUM=$(($FIELD_NUM+1))

URL_PARAMS2="$URL_PARAMS2&field$FIELD_NUM2=$TEMP1"
FIELD_NUM2=$(($FIELD_NUM2+1))

URL_PARAMS2="$URL_PARAMS2&field$FIELD_NUM2=$TEMP2"
FIELD_NUM2=$(($FIELD_NUM2+1))

URL_PARAMS2="$URL_PARAMS2&field$FIELD_NUM2=$TEMP3"
FIELD_NUM2=$(($FIELD_NUM2+1))

echo $(date)
echo "url_params=$URL_PARAMS"
wget -qO- "$API_URL?api_key=$API_KEY&$URL_PARAMS"
echo
echo

echo "url_params=$URL_PARAMS2"
wget -qO- "$API_URL?api_key=$API_KEY2&$URL_PARAMS2"
echo

