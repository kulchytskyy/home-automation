#!/bin/bash

DIR=$(dirname $0)
source $DIR/config.sh

LOGIN_CMD="$CURL $API_URL/login $COMMON_HEADER --data-binary '$LOGIN_PAYLOAD' > $LOGIN_DATA_FILE"
#echo "$LOGIN_CMD"
#echo

eval $LOGIN_CMD
CONTROLLER_STATUS=`cat $LOGIN_DATA_FILE | $JQ ".modules[0] | .controllerStatus"`
MODULE_STATUS=`cat $LOGIN_DATA_FILE | $JQ ".modules[0] | .moduleStatus"`
echo "CONTROLLER_STATUS=$CONTROLLER_STATUS"
echo "MODULE_STATUS=$MODULE_STATUS"

if [ "$CONTROLLER_STATUS" = '"active"' ] && [ "$MODULE_STATUS" = '"active"' ]; then 

	UPDATE_DATA_CMD="$CURL $API_URL/module_data $COMMON_HEADER"
	#echo "$UPDATE_DATA_CMD"
	#echo

	function sensor_format {
		echo $(($1 * 100 / 10)) | sed 's/..$/.&/'
	}  

	function display_status {
		case $1 in 
			524 )
				echo "damped"
				;;
			604 )
				echo "pid operation"
				;;
			671 )
				echo "firing up"
				;;
			912 )
				echo "damping"
				;;
			* )
				echo "$1"
				;;
		esac
	}  

	eval "$UPDATE_DATA_CMD > $DATA_FILE"
	STATUS=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == 2040) | .params.statusId"`

	CH_TEMP=$(sensor_format `cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1006) | .params.value"`)
	DHW_TEMP=$(sensor_format `cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1007) | .params.value"`)
	RETURN_TEMP=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1012) | .params.returnTemp"`
	FLUE_GASS_TEMP=$(sensor_format `cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1008) | .params.value"`)
	OUTDOOR_TEMP=$(sensor_format `cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1009) | .params.value"`)

	FAN_WORKING=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1011) | .params.workingStatus"`
	FAN_GEAR=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1011) | .params.gear"`

	FIRE_SENSOR_STATUS=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1016) | .params.workingStatus"`
	FIRE_SENSOR_VALUE=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1016) | .params.value"`

	HEATER_WORKING=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1003) | .params.workingStatus"`
	CH_PUMP_WORKING=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1004) | .params.workingStatus"`

	echo
	echo "STATUS=$(display_status $STATUS)"
	echo
	echo "CH_TEMP=$CH_TEMP"
	echo "DHW_TEMP=$DHW_TEMP"
	echo "RETURN_TEMP=$RETURN_TEMP"
	echo "FLUE_GASS_TEMP=$FLUE_GASS_TEMP"
	echo "OUTDOOR_TEMP=$OUTDOOR_TEMP"
	echo
	echo "FAN_WORKING=$FAN_WORKING"
	echo "FAN_GEAR=$FAN_GEAR"
	echo
	echo "FIRE_SENSOR_STATUS=$FIRE_SENSOR_STATUS"
	echo "FIRE_SENSOR_VALUE=$FIRE_SENSOR_VALUE"
	echo
	echo "HEATER_WORKING=$HEATER_WORKING"
	echo "CH_PUMP_WORKING=$CH_PUMP_WORKING"

fi

