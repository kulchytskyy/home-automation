#!/bin/bash

source ~/.ha_creds

CLOUDCOVER_MAX=70
CITY="Lviv"
LOGFILE="/var/log/ha/weather.log"
LAT="49.75"
LON="24.16"
DEC="31"	#Solar plane declination, 0 = horizontal, 90 = vertical
AZ="-77"	#Solar plane azimuth, West = 90, South = 0, East = -90
KWP="3.2"	#Solar plane max. peak power in kilo watt	https://swagger.forecast.solar/#/Public/get_estimate__lat___lon___dec___az___kwp_

