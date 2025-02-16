#!/bin/bash

CH_TEMP_SWITCH_ON=78
NOTIFY_RANGE_LOW=60
NOTIFY_RANGE_HIGH=65

DIR=$(dirname $0)
source $DIR/../monitor/func.sh

echo
echo "`date`"

$DIR/emodul/get.sh
boiler1_ch_temp=$($DIR/../sensor/get.sh boiler_ch_temp_no_get)
boiler2_ch_temp=$($DIR/../sensor/get.sh boiler2_ch_emodul_temp_no_get)

#boiler1_ch_temp="51.2"
#boiler2_ch_temp="72.5"

echo "boiler1_ch_temp = $boiler1_ch_temp"
echo "boiler2_ch_temp = $boiler2_ch_temp"

check $boiler1_ch_temp 70 gt "BOILER1 CH TEMP"
check $boiler2_ch_temp 80 gt "BOILER2 CH TEMP"

#notify if valve is closed
diff="$(echo $boiler2_ch_temp - $boiler1_ch_temp | bc)"
echo $diff
if (( $(echo "$diff > 10" | bc -l) )); then
	echo "OPEN BOILER2 VALVE!!!"
	$DIR/../notify/alert.sh "OPEN BOILER2 VALVE!!! boiler2: $boiler2_ch_temp, boiler1: $boiler1_ch_temp"
fi	
exit 0;


#notify if temp is descreasing
if (( $(echo "$boiler2_ch_temp > $NOTIFY_RANGE_LOW" | bc -l) && $(echo "$boiler2_ch_temp < $NOTIFY_RANGE_HIGH" | bc -l))); then
	echo "CH TEMP is decreasing: $boiler2_ch_temp"
	$DIR/../notify/notify.sh "Boiler2 CH temp: $boiler2_ch_temp"
fi

#switch DHW
if (( $(echo "$boiler2_ch_temp > $CH_TEMP_SWITCH_ON" | bc -l) )); then
	if [[ `cat /var/ha/boiler/dhw` == "HOUSE" ]]; then
       		echo "Switching on DHW heating."
       		$DIR/../notify/notify.sh "Switching on DHW heating ($boiler2_ch_temp)"
       		bash $DIR/relay/water.sh
       	else
       		echo "Already switched to water heating."
       	fi
else 
	if [[ `cat /var/ha/boiler/dhw` == "WATER" ]]; then
       		echo "Switching off DHW heating."
       		$DIR/../notify/notify.sh "Switching off DHW heating ($boiler2_ch_temp))"
	       	bash $DIR/relay/house.sh
	else
		echo "Already switched to house heating."
	fi
fi

