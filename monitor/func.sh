#!/bin/bash

DIR=$(dirname $0)

function check_value_gt {
	if (( $(echo "$1 > $2" | bc -l) )); then 
		echo 1;
	else
		echo 0;
	fi;
}

function check_value_lt {
	if (( $(echo "$1 < $2" | bc -l) )); then 
		echo 1;
	else
		echo 0;
	fi;
}


function get_value {
	sensor=$1;
	actual=`$DIR/../sensor/get.sh "$sensor"`;
	#echo "act=$actual"
	if [[ -z $actual ]]; then
		echo "No data from $sensor";
 		$DIR/notify.sh "$sensor_nodata" "No data from $sensor sensor";
 		return 1;
	else
		if [[ $sensor == hum_* ]]; then
			actual=`echo $actual | cut -f 2 -d "|"`;
		fi
		echo $actual;
	fi	
}

function check {
	actual=$1;
	limit=$2;
	operator=$3;
	sensor=$4;
	
	echo "checking $sensor=$actual $operator $limit";
	if [[ $operator == "gt" ]]; then
		res=$(check_value_gt "$actual" "$limit")
	elif [[ $operator == "lt" ]]; then
		res=$(check_value_lt "$actual" "$limit")
	fi
	#echo "check=$res"

	if [[ $res == 1 ]]; then 
		echo "Limit reached";
 		$DIR/notify.sh "$sensor" "$sensor=$actual (limit:$limit)";
	fi	
}

function check_lt {
	actual=$(get_value "$1")
	if [[ $? == 0 ]]; then
		check $actual $2 lt $1
	else
		echo "$actual";
	fi
}

function check_gt {
	actual=$(get_value "$1")
	if [[ $? == 0 ]]; then
		check $actual $2 gt $1
	else
		echo "$actual";
	fi
}

function check_in_range {
	actual=$(get_value "$1")
	if [[ $? == 0 ]]; then
		check $actual $2 lt $1
		check $actual $3 gt $1
	else
		echo "$actual";
	fi
}
