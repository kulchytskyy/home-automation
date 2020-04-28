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

	DAMP_PAYLOAD="[{\"ido\":251,\"params\":1,\"module_index\":0}]"
	DAMP_CMD="$CURL $API_URL/send_control_data $COMMON_HEADER --data-binary '$DAMP_PAYLOAD' > $CMD_DATA_FILE"
	#echo "$DAMP_CMD"
	eval $DAMP_CMD

	echo "RESULT:"
	cat $CMD_DATA_FILE

fi


