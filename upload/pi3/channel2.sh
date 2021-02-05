#!/bin/bash

DIR=$(dirname $0)
source $DIR/../config.sh

API_KEY=$API_KEY2

URL_PARAMS=""

echo $(date) 


N=3
for i in attic kidroom bathroom2 bedroom kidroom2 hum_living; do
   T=`$DIR/../../sensor/get.sh $i`
   echo "$i=$T"
   if [ ! -z $T ]; then
      URL_PARAMS="$URL_PARAMS&field$N=$T"
   fi
   N=$(($N+1))
done

### send
echo "url_params=$URL_PARAMS"
wget -nv -O- "$API_URL?api_key=$API_KEY&$URL_PARAMS"

echo -e "\n\n"
