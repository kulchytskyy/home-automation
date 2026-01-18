import os
import sys
import socket
import json
import time
import smbus2
import bme280

import paho.mqtt.client as mqtt
from dotenv import load_dotenv

load_dotenv(os.path.expanduser("~/.ha_creds"))
load_dotenv(os.path.expanduser("./config.sh"))

BROKER = os.getenv("MQTT_BROKER")
PORT = int(os.getenv("MQTT_PORT", 1883))
USER = os.getenv("MQTT_USER")
PASS = os.getenv("MQTT_PASSWORD")
MQTT_INTERVAL = int(os.getenv("MQTT_INTERVAL", 60))

hostname = socket.gethostname()
load_dotenv(os.path.expanduser(f"./{hostname}/config.sh"))
MQTT_CLIENT_ID = os.getenv("MQTT_I2C_CLIENT_ID")

print(f"--- I2C MQTT Service Starting ---")
print(f"Hostname: {hostname}")
print(f"Broker:   {BROKER}")
print(f"Client ID: {MQTT_CLIENT_ID}")

config_path = f"./{hostname}/sensors_config.json"
with open(config_path, "r") as f:
    config_data = json.load(f)
    i2c_definitions = config_data.get("i2c_sensors", {})

active_sensors = []
for key, info in i2c_definitions.items():
    parts = key.split('_')
    bus_num = int(parts[0].replace("bus", ""))
    addr = int(parts[1], 16)
    
    bus = smbus2.SMBus(bus_num)
    
    # PIMORONI CHANGE: Load calibration parameters instead of creating an object
    print(f"Initializing sensor {bus_num}_{hex(addr)} {info['mqtt_topic']} ...")
    calib = bme280.load_calibration_params(bus, addr)
    
    time.sleep(1) # Brief pause for stability
    
    active_sensors.append({
        "bus": bus,
        "addr": addr,
        "calib": calib,
        "name": info["name"],
        "base_topic": info["mqtt_topic"]
    })
    print(f"Mapped {info['name']} at {hex(addr)}")
                    

client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION1, client_id=MQTT_CLIENT_ID)
if USER and PASS:
    client.username_pw_set(USER, PASS)

client.connect(BROKER, PORT, 60)
client.loop_start()

try:
    while True:
        for sensor in active_sensors:
            data = bme280.sample(sensor["bus"], sensor["addr"], sensor["calib"])
            
            temp = data.temperature
            hum = data.humidity
            pres = data.pressure
            
            topic = sensor["base_topic"]
            client.publish(f"{topic}/temperature", round(temp, 2), retain=True)
            client.publish(f"{topic}/humidity", round(hum, 2), retain=True)
            client.publish(f"{topic}/pressure", round(pres, 2), retain=True)
            
            print(f"[{sensor['name']}] {round(temp, 2)}C, {round(hum, 2)}%, {round(pres, 2)}hPa")
            time.sleep(1)
        
        time.sleep(MQTT_INTERVAL)
except KeyboardInterrupt:
    pass
finally:
    client.loop_stop()
    client.disconnect()
