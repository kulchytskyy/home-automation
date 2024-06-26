
DIR=$(dirname $0)

source $DIR/config.sh
FIELD_ID=$1
FIELD_TYPE=$2


case $FIELD_TYPE in 
  sensor)
    SELECTOR=".params.value";;
  fan)
    SELECTOR=".params.gear";;
  status)
    SELECTOR=".params.workingStatus";;
  valveTemp)
    SELECTOR=".params.currentTemp";;
esac

#echo $FIELD_ID
#echo $SELECTOR
#echo

function sensor_format {
	echo $(($1 * 100 / 10)) | sed 's/..$/.&/'
}  

RAW=`cat $DATA_FILE | $JQ ".tiles[] | select (.id == $FIELD_ID) | $SELECTOR"`

if [ $FIELD_TYPE = "sensor" ] || [ $FIELD_TYPE = "valveTemp" ]; then
  VAL=$(sensor_format $RAW)
else
  VAL=$RAW
fi


echo $VAL





