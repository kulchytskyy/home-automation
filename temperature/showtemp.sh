#!/bin/bash

cd /sys/bus/w1/devices
watch cat */w1_slave
