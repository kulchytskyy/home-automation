import smbus2
import bme280
import time

# Default I2C address is 0x76; some sensors use 0x77
address = 0x76
bus = smbus2.SMBus(1)

# Load calibration parameters from the sensor
calibration_params = bme280.load_calibration_params(bus, address)

while True:
    # Take a single reading
    data = bme280.sample(bus, address, calibration_params)
    
    # Access compensated readings
    print(f"Temperature: {data.temperature:.2f} °C")
    print(f"Pressure:    {data.pressure:.2f} hPa")
    print(f"Humidity:    {data.humidity:.2f} %")
    
    time.sleep(2)
    