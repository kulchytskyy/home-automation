#!/bin/bash

DIR=$(dirname "$0")

source $DIR/../config.sh
if [ -f $DIR/config.sh ]; then
	source $DIR/config.sh
fi
source $DIR/pins.sh

bash $DIR/../run.sh $DOWN_PIN $UP_PIN

 