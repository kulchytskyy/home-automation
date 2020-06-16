#!/bin/bash

# arg1 - channel id
# arg2 - value column index (8 - temperature, 9 - huminity)

F=/var/ha/rtl/temp.csv
MODEL="TFA-TwinPlus"

LAST_LINE=`grep -a $MODEL,$1, $F | tail -n 1`
#echo $LAST_LINE

TEMP=`echo $LAST_LINE | cut -d , -f $2`
#echo $TEMP

DATE_STR=`echo $LAST_LINE | cut -d , -f 1`
#echo $DATE_STR

DATE=$(date -d "$DATE_STR" +%s)
#echo $DATE

VALUE=''
AGO_DATE=$(date --date='10 minutes ago' +%s)
#echo $AGO_DATE

if [ $DATE -ge $AGO_DATE ];
then
   VALUE=$TEMP
fi

echo $VALUE
