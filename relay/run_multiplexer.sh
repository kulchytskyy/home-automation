#!/bin/bash

PIN=$1
echo "using pin $PIN"
export PIN

source config.sh

SIGNAL_PIN=26
#ACTIVE_VALUE=0
#INACTIVE_VALUE=1

DIR=$(dirname "$0")

(
  flock -n 9 || { echo "!!! Failed to acquire lock. Aborting"; exit 1; }
  bash $DIR/multiplexer.sh $PIN
  #gpio -g mode $SIGNAL_PIN out
  raspi-gpio set $SIGNAL_PIN op dh
  #gpio -g write $SIGNAL_PIN $ACTIVE_VALUE
  bash $DIR/sleep.sh
  #gpio -g write $SIGNAL_PIN $INACTIVE_VALUE
  raspi-gpio set $SIGNAL_PIN op dl
) 9>$LOCKFILE

 