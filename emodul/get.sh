source config.sh

LOGIN_CMD="$CURL $API_URL/login $COMMON_HEADER --data-binary '$LOGIN_PAYLOAD' > $LOGIN_DATA_FILE"
#echo "$LOGIN_CMD"
#echo

eval $LOGIN_CMD
if [ "$CONTROLLER_STATUS" = '"active"' ] && [ "$MODULE_STATUS" = '"active"' ]; then 
	UPDATE_DATA_CMD="$CURL $API_URL/update_data $COMMON_HEADER"
	#echo "$UPDATE_DATA_CMD"
	#echo

	eval "$UPDATE_DATA_CMD > $DATA_FILE"

fi

