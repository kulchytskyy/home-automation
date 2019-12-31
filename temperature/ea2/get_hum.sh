#!/bin/bash

F=/var/local/ea2temp.csv

LAST_LINE=`grep ,$1, $F | tail -n 1`
#echo $LAST_LINE

TEMP=`echo $LAST_LINE | cut -d , -f 7`
#echo $TEMP

DATE_STR=`echo $LAST_LINE | cut -d , -f 1`
#echo $DATE_STR

DATE=$(date -d "$DATE_STR")
#echo $DATE

VALUE=''
AGO_DATE=$(date --date='10 minutes ago')
if [[ $DATE > $AGO_DATE ]];
then
   VALUE=$TEMP
fi

echo $VALUE
