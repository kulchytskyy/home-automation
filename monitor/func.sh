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


function check {
	sensor=$1;
	limit=$2;
	operator=$3;
	actual=`$DIR/../sensor/get.sh "$sensor"`;
	#echo "act=$actual"
	if [[ $sensor == hum_* ]]; then
		actual=`echo $actual | cut -f 2 -d "|"`;
	fi
	echo "checking $sensor=$actual $operator $limit";
	
	if [[ $operator == "gt" ]]; then
		res=$(check_value_gt "$actual" "$limit")
	elif [[ $operator == "lt" ]]; then
		res=$(check_value_lt "$actual" "$limit")
	fi
	echo "check=$res"

	if [[ $res == 1 ]]; then 
 		echo "Limit reached";
	 	$DIR/notify.sh "$sensor" "$sensor=$actual (limit:$limit)";
	fi
}

function check_lt {
	check $1 $2 lt
}

function check_gt {
	check $1 $2 gt
}

function check_in_range {
	check $1 $2 lt
	check $1 $3 gt
}
