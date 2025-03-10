DIR=$(dirname $0)

CURL="curl"
JQ="jq"

source ~/.ha_creds

API_URL="https://emodul.pl"
COOKIE_STORAGE="--cookie cookies.txt --cookie-jar cookies.txt"
COMMON_HEADER="-s $COOKIE_STORAGE -H 'pragma: no-cache' -H 'origin: https://emodul.pl' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.8' -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36' -H 'content-type: application/json;charset=UTF-8' -H 'accept: application/json, text/plain, */*' -H 'cache-control: no-cache' -H 'authority: emodul.pl' -H 'referer: https://emodul.pl/login' --compressed"
LOGIN_PAYLOAD="{\"username\":\"$USERNAME\",\"password\":\"$PASSWORD\",\"rememberMe\":false,\"languageId\":\"en\"}"
DATA_DIR=/var/ha/emodul
LOGIN_DATA_FILE="$DATA_DIR/login_data.json"
DATA_FILE="$DATA_DIR/data.json"
CMD_DATA_FILE="$DATA_DIR/cmd_data.json"

