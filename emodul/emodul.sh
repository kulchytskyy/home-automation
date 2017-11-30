
CURL="curl"
JQ="jq"

API_URL="https://emodul.pl"
USERNAME="kulchytskyy@gmail.com"
PASSWORD="em23pfmr"

COOKIE_STORAGE="--cookie c.txt --cookie-jar c.txt"
COMMON_HEADER="-s $COOKIE_STORAGE -H 'pragma: no-cache' -H 'origin: https://emodul.pl' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.8' -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36' -H 'content-type: application/json;charset=UTF-8' -H 'accept: application/json, text/plain, */*' -H 'cache-control: no-cache' -H 'authority: emodul.pl' -H 'referer: https://emodul.pl/login' --compressed"
LOGIN_PAYLOAD="{\"username\":\"$USERNAME\",\"password\":\"$PASSWORD\",\"rememberMe\":false,\"languageId\":\"en\"}"
DATA_FILE="data.json"

#echo "COMMON_HEADER: $COMMON_HEADER"
#echo
#echo "LOGIN_PAYLOAD: $LOGIN_PAYLOAD"
#echo

LOGIN_CMD="$CURL $API_URL/login $COMMON_HEADER --data-binary '$LOGIN_PAYLOAD'"
#echo "$LOGIN_CMD"
#echo

UPDATE_DATA_CMD="$CURL $API_URL/update_data $COMMON_HEADER"
#echo "$UPDATE_DATA_CMD"
#echo

function sensor_format {
	echo $(($1 * 100 / 10)) | sed 's/..$/.&/'
}  

eval $LOGIN_CMD
eval "$UPDATE_DATA_CMD > $DATA_FILE"
TEMP_SENSOR1_RAW=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1006) | .params.value"`
TEMP_SENSOR2_RAW=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1008) | .params.value"`
TEMP_SENSOR3_RAW=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1009) | .params.value"`

TEMP_SENSOR1=$(sensor_format $TEMP_SENSOR1_RAW)
TEMP_SENSOR2=$(sensor_format $TEMP_SENSOR2_RAW)
TEMP_SENSOR3=$(sensor_format $TEMP_SENSOR3_RAW)

FAN_WORKING=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1011) | .params.workingStatus"`
FAN_NUMBER=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == 1011) | .params.fanNumber"`

echo
echo "TEMP_SENSOR1=$TEMP_SENSOR1"
echo "TEMP_SENSOR2=$TEMP_SENSOR2"
echo "TEMP_SENSOR2=$TEMP_SENSOR3"
echo "FAN_WORKING=$FAN_WORKING"
echo "FAN_NUMBER=$FAN_NUMBER"





