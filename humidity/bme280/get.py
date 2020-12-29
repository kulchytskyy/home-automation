#!/usr/bin/env python

import sys
import smbus2
import bme280

#print 'i2c address', str(sys.argv[1])

port = 1
#address = 0x76
address = int(sys.argv[1], 16)
bus = smbus2.SMBus(port)

calibration_params = bme280.load_calibration_params(bus, address)

# the sample method will take a single reading and return a
# compensated_reading object
data = bme280.sample(bus, address, calibration_params)

# the compensated_reading class has the following attributes
#print(data.id)
#print(data.timestamp)
#print(data.temperature)
#print(data.pressure)
#print(round(data.humidity,2))

# there is a handy string representation too
#print(data)

print (str(round(data.temperature,2)) + "|" + str(round(data.humidity,2)))

