#!/usr/bin/env python

import sys
import time
import datetime
import random 
import SDL_Pi_INA3221

ina3221 = SDL_Pi_INA3221.SDL_Pi_INA3221(addr=0x41)

CHANNEL = int(sys.argv[1])

busvoltage = ina3221.getBusVoltage_V(CHANNEL);
print("%3.2f" % busvoltage)
