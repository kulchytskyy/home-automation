#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY4

URL_PARAMS=""

echo $(date) 

N=2
for i in hum_living hum_outdoor hum_floor1 hum_floor2; do
	D=$($DIR/../../sensor/get.sh $i)
	echo "$i=$D"
	if [ ! -z $D ]; then
		D_ARR=(${D//|/ })
		TEMP=${D_ARR[0]}
		HUM=${D_ARR[1]}
 
		URL_PARAMS="$URL_PARAMS&field$N=$HUM"
 		if [[ "$i" == "hum_living" || "$i" == "hum_outdoor" ]]; then
			ABS_HUM=$($DIR/../../humidity/abshum.sh $HUM $TEMP)
			echo "$i abs hum=$ABS_HUM"
			URL_PARAMS="$URL_PARAMS&field$(($N+5))=$ABS_HUM"
		fi
	fi
	N=$(($N+1))
done

### send
echo "url_params=$URL_PARAMS"
wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
