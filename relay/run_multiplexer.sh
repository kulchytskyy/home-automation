#!/bin/bash

PIN=$1
echo "using pin $PIN"
export PIN

source config.sh

SIGNAL_PIN=26

DIR=$(dirname "$0")

(
  flock -n 9 || { echo "!!! Failed to acquire lock. Aborting"; exit 1; }
  gpio -g mode $SIGNAL_PIN out
  gpio -g write $SIGNAL_PIN 1
  bash $DIR/multiplexer.sh $PIN
  bash $DIR/sleep.sh
  gpio -g write $SIGNAL_PIN 0
) 9>$LOCKFILE

 