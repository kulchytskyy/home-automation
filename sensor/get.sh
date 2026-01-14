#!/bin/bash

DIR=$(dirname $0)

name=$1;

#echo "quering sensor: $name"

case "$1" in


    #pi3
    attic)
            echo $($DIR/../temperature/w1/get.sh "28-03168123a0ff");
    ;;
    kidroom)
            echo $($DIR/../temperature/w1/get.sh "28-0316811ffaff");
    ;;
    bathroom2)
            echo $($DIR/../temperature/w1/get.sh "28-0416810106ff");
    ;;
    bedroom)
            echo $($DIR/../temperature/w1/get.sh "28-0416812edaff");
    ;;
    kidroom2)
            echo $($DIR/../temperature/w1/get.sh "28-0516848757ff");
    ;;
    floor1)
            echo $($DIR/../temperature/w1/get.sh "28-3c01b556458b");
    ;;
    floor2)
            echo $($DIR/../temperature/w1/get.sh "28-3c01b55639bf");
    ;;
    hum_living)
            echo $($DIR/../temperature/sdr/get.sh 35);
    ;;
    hum_outdoor)
            echo $($DIR/../temperature/sdr/get.sh 164);
    ;;
    hum_floor1)
            echo $($DIR/../humidity/bme280/get.py 77);
    ;;
    hum_floor2)
            echo $($DIR/../humidity/bme280/get.py 76);
    ;;

    #boiler
    boiler_ch_temp)
    	    $DIR/../boiler/emodul/get.sh >/dev/null
            echo $($DIR/../boiler/emodul/parse.sh 1006 sensor);
    ;;
    boiler_outdoor_temp)
    	    $DIR/../boiler/emodul/get.sh >/dev/null
            echo $($DIR/../boiler/emodul/parse.sh 1009 sensor);
    ;;
    boiler_fan)
    	    $DIR/../boiler/emodul/get.sh >/dev/null
            echo $($DIR/../boiler/emodul/parse.sh 1011 fan);
    ;;
    boiler_dhw)
    	    $DIR/../boiler/emodul/get.sh >/dev/null
            echo $($DIR/../boiler/emodul/parse.sh 1007 sensor);
    ;;
    boiler2_ch_emodul_temp)
    	    $DIR/../boiler/emodul/get.sh >/dev/null
            echo $($DIR/../boiler/emodul/parse.sh 1013 valveTemp);
    ;;
    

    #sdr
    livingroom)
            echo $($DIR/../temperature/sdr/get_temp.sh 5);
    ;;
    bathroom)
            echo $($DIR/../temperature/sdr/get_temp.sh 14);
    ;;
    outdoor)
            echo $($DIR/../temperature/sdr/get_temp.sh 57);
    ;;


    #pi2
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
            echo $($DIR/../temperature/w1/get_abs.sh "28-3c01b556867f");
    ;;
    dhw_center)
            echo $($DIR/../temperature/w1/get_abs.sh "28-021319cc85aa");
    ;;
    boiler2_ch_temp)
            echo $($DIR/../temperature/w1/get_abs.sh "28-021319dd9aaa");
    ;;
    hum_basement)
            echo $($DIR/../humidity/bme280/get.py 76);
    ;;
    
    #voltage
    voltage1)
            echo $($DIR/../voltage/ina3221/get.py 1);
    ;;

    voltage2)
            echo $($DIR/../voltage/ina3221/get.py 2);
    ;;

    voltage3)
            echo $($DIR/../voltage/ina3221/get.py 3);
    ;;


    
    *) echo "Unknown sensor: $1"; exit 1;;

esac

