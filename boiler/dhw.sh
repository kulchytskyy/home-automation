#!/bin/bash

DHW_MAX_TEMP=62
DHW_MIN_TEMP=45
FAN_MAX=98
CH_TEMP_MIN=63 

DIR=$(dirname $0)

echo
echo "`date`"

STATUS="$($DIR/emodul/status.sh)"
#echo "$STATUS"

FAN=$(echo "$STATUS" | grep FAN_GEAR | cut -d "=" -f 2)
CONTROLLER_STATUS=$(echo "$STATUS" | grep CONTROLLER_STATUS | cut -d "=" -f 2)
MODULE_STATUS=$(echo "$STATUS" | grep MODULE_STATUS | cut -d "=" -f 2)
BOILER_STATUS=$(echo "$STATUS" | grep "^STATUS" | cut -d "=" -f 2)
FAN=$(echo "$STATUS" | grep FAN_GEAR | cut -d "=" -f 2)
CH_TEMP=$(echo "$STATUS" | grep "CH_TEMP" | cut -d "=" -f 2)

#echo ""
#echo "==============="
#echo "CONTROLLER_STATUS = $CONTROLLER_STATUS"
#echo "MODULE_STATUS = $MODULE_STATUS"
#echo "BOILER_STATUS = $BOILER_STATUS"
#echo "FAN = $FAN"
#echo "CH_TEMP = $CH_TEMP"

if [ "$CONTROLLER_STATUS" = '"active"' ] && [ "$MODULE_STATUS" = '"active"' ] && [ "$BOILER_STATUS" = 'pid operation' ]; then
	echo "Boiler is active"
	
	DHW_TEMP_TOP=$(bash $DIR/../temperature/w1/get_abs.sh "28-3c01b556867f")
	echo "DHW temperature: $DHW_TEMP_TOP (min=$DHW_MIN_TEMP, max=$DHW_MAX_TEMP)"
	DHW_TEMP=$DHW_TEMP_TOP

	if [[ -z $DHW_TEMP ]]; then
		echo "Failed to get DHW temperature"
		notify --text "Failed to get DHW temperature"
		exit 1
	fi
        
	if (( $(echo "$DHW_TEMP > $DHW_MAX_TEMP" | bc -l) )); then
		if [[ `cat /var/ha/boiler/dhw` == "WATER" ]]; then
        		echo "Reached DHW max temperature $DHW_MAX_TEMP. Switching to HOUSE heating."
        		notify --text "Reached DHW max temperature $DHW_MAX_TEMP. Switching to HOUSE heating."
	       		bash $DIR/relay/house.sh
	       	else
	       		echo "Already switched to house heating."
	       	fi
	elif (( $(echo "$DHW_TEMP < $DHW_MIN_TEMP" | bc -l) )); then
		if [[ `cat /var/ha/boiler/dhw` == "HOUSE" ]]; then
	        	echo "Reached DHW min temperature $DHW_MIN_TEMP. Checking if can switch to water heating."
	        	echo "Fan is $FAN (required <$FAN_MAX). CH temp is $CH_TEMP (required >$CH_TEMP_MIN)."
	        	if (( $(echo "$FAN < $FAN_MAX" | bc -l) )) && (( $(echo "$CH_TEMP > $CH_TEMP_MIN" | bc -l) )); then
	        		echo "Switching to WATER heating."
	        		notify --text "Switching to WATER heating."
			       	bash $DIR/relay/water.sh
			else
				echo "Cannot switch to water heating."
	        	fi
		else
			echo "Already switched to water heating."
		fi
	else
		if [[ `cat /var/ha/boiler/dhw` == "HOUSE" ]]; then
	        	echo "House heating active."
		else
			echo "Water heating active."
		fi	
	fi
else
	echo "Boiler is not active"
	if [[ `cat /var/ha/boiler/dhw` == "WATER" ]]; then
        	echo "Disabling WATER heating."
        	notify --text "Boiler is not active. Disabling WATER heating."
	       	bash $DIR/relay/house.sh
       	fi
fi
