#!/bin/bash

NOTIFY=~/ha/monitor/notify.sh

server=$1

function is_host_online {
	ping -c1 -W1 -q $1 &>/dev/null
	status=$( echo $? )
	if [[ $status == 0 ]] ; then
		echo "$1 is online";
                return 1;
	else
		echo "$1 is offline";
                $NOTIFY "pi" "$1 is offline";
                return 0;
	fi
}
