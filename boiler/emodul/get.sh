DIR=$(dirname $0)

source $DIR/config.sh

mkdir -p $DATA_DIR

LOGIN_CMD="$CURL $API_URL/login $COMMON_HEADER --data-binary '$LOGIN_PAYLOAD' > $LOGIN_DATA_FILE"
#echo "$LOGIN_CMD"
#echo

eval $LOGIN_CMD
CONTROLLER_STATUS=`cat $LOGIN_DATA_FILE | $JQ ".modules[0] | .controllerStatus"`
MODULE_STATUS=`cat $LOGIN_DATA_FILE | $JQ ".modules[0] | .moduleStatus"`
#echo "CONTROLLER_STATUS=$CONTROLLER_STATUS"
#echo "MODULE_STATUS=$MODULE_STATUS"

if [ "$CONTROLLER_STATUS" = '"active"' ] && [ "$MODULE_STATUS" = '"active"' ]; then 
	UPDATE_DATA_CMD="$CURL $API_URL/update_data $COMMON_HEADER"
	#echo "$UPDATE_DATA_CMD"
	#echo

	eval "$UPDATE_DATA_CMD > $DATA_FILE"
	echo "active"
else
	echo "inactive"
fi

