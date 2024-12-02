#!/bin/bash

CH_TEMP_SWITCH_ON=78 
NOTIFY_RANGE_LOW=60
NOTIFY_RANGE_HIGH=65


DIR=$(dirname $0)

echo
echo "`date`"

ch_temp=$($DIR/../sensor/get.sh boiler2_ch_emodul_temp)

echo "ch_temp = $ch_temp"

#notify if temp is descreasing
if (( $(echo "$ch_temp > $NOTIFY_RANGE_LOW" | bc -l) && $(echo "$ch_temp < $NOTIFY_RANGE_HIGH" | bc -l))); then
	echo "CH TEMP is decreasing: $ch_temp"
	$DIR/../notify/notify.sh "Boiler2 CH temp: $ch_temp"
fi

if (( $(echo "$ch_temp > $CH_TEMP_SWITCH_ON" | bc -l) )); then
	if [[ `cat /var/ha/boiler/dhw` == "HOUSE" ]]; then
       		echo "Switching on DHW heating."
       		$DIR/../notify/notify.sh "Switching on DHW heating ($ch_temp)"
       		bash $DIR/relay/water.sh
       	else
       		echo "Already switched to water heating."
       	fi
else 
	if [[ `cat /var/ha/boiler/dhw` == "WATER" ]]; then
       		echo "Switching off DHW heating."
       		$DIR/../notify/notify.sh "Switching off DHW heating ($ch_temp))"
	       	bash $DIR/relay/house.sh
	else
		echo "Already switched to house heating."
	fi
fi

