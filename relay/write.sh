#!/bin/bash

echo "setting $PIN to $1"
gpio -g write $PIN $1
 