#!/bin/bash

# arg1 - channel id
# arg2 - value column index (8 - temperature, 9 - huminity)
TEMP_INDEX=8
HUM_INDEX=9

F=/var/ha/sdr/temp.csv
MODEL="TFA\-[\w]+"

LAST_LINE=`grep -aP "$MODEL\,$1", $F | tail -n 1`
#echo $LAST_LINE

DATE_STR=`echo $LAST_LINE | cut -d , -f 1`
#echo $DATE_STR

DATE=$(date -d "$DATE_STR" +%s)
#echo $DATE

VALUE=''
AGO_DATE=$(date --date='10 minutes ago' +%s)
#echo $AGO_DATE

if [ $DATE -ge $AGO_DATE ]; then
	if [ -z "$2" ]; then
		TEMP=`echo $LAST_LINE | cut -d , -f $TEMP_INDEX`
		#echo "temp=$TEMP"
		HUM=`echo $LAST_LINE | cut -d , -f $HUM_INDEX`
		#echo "hum=$HUM"
		VALUE="$TEMP|$HUM"
	else
		TEMP=`echo $LAST_LINE | cut -d , -f $2`
		VALUE=$TEMP
	fi
fi

echo $VALUE
