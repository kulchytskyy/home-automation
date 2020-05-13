#!/bin/bash

F=/var/ha/rtl/temp.csv

LAST_LINE=`grep -a ,$1, $F | tail -n 1`
#echo $LAST_LINE

TEMP=`echo $LAST_LINE | cut -d , -f 8`
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
