#!/bin/bash

DIR=$(dirname $0)

name=$1;

#echo "quering sensor: $name"

case "$1" in
    basement_laundry)
            echo $($DIR/../temperature/w1/get.sh "28-0316819430ff");
    ;;
    basement_large)
            echo $($DIR/../temperature/w1/get.sh "28-0000052cf9c6");
    ;;
    basement_boiler)
            echo $($DIR/../temperature/w1/get.sh "28-0416816c14ff");
    ;;
    dhw|dhw_top)
            echo $($DIR/../temperature/w1/get.sh "28-3c01b556867f");
    ;;
    dhw_center)
            echo $($DIR/../temperature/w1/get.sh "28-021319cc85aa");
    ;;
    hum_basement)
            echo $($DIR/../humidity/bme280/get.py 76);
    ;;
    *) echo "Unknown sensor: $1"; exit 1;;

esac

