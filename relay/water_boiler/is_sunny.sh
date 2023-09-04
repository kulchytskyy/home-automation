#!/bin/bash

CLOUDCOVER_MAX=50

DIR=$(dirname "$0")
source $DIR/config.sh

#curl "https://api.open-meteo.com/v1/forecast?latitude=49.759&longitude=24.1621&hourly=direct_radiation&forecast_days=0&current_weather=true"
#http://api.openweathermap.org/data/2.5/weather?q=Lviv&APPID=d551dad1df30d43e3ea57cd675a4fd49

CITY="Lviv"
APIKEY="d5027eef80e2387e3e8f3675e25daa74"
URL="http://api.weatherstack.com/current?access_key=$APIKEY&query=$CITY"
#echo $URL

DATA=`wget -q -O- $URL`
#echo $DATA

#echo "TEST="
CLOUDCOVER=`echo $DATA | jq ".current.cloudcover"`
echo "`date -u` Cloud cover $CLOUDCOVER" >> $LOGFILE


#echo CLOUDCOVER=$CLOUDCOVER
#echo $CLOUDCOVER

if (( $CLOUDCOVER < $CLOUDCOVER_MAX )); then
	echo true
else
	echo false
fi

