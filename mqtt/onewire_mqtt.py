import sys
import time
import json
import socket
import paho.mqtt.client as mqtt
from w1thermsensor import W1ThermSensor
import os
from dotenv import load_dotenv

load_dotenv(os.path.expanduser("~/.ha_creds"))
load_dotenv(os.path.expanduser("./config.sh"))

BROKER = os.getenv("MQTT_BROKER")
PORT = int(os.getenv("MQTT_PORT"))
USER = os.getenv("MQTT_USER")
PASS = os.getenv("MQTT_PASSWORD")

print(f"BROKER={BROKER}")
print(f"PORT={PORT}")
print(f"USER={USER}")

hostname = socket.gethostname();
print(f"The hostname is: {hostname}")
load_dotenv(os.path.expanduser(f"./{hostname}/config.sh"))
MQTT_CLIENT_ID = os.getenv("MQTT_CLIENT_ID")
print(f"MQTT_CLIENT_ID={MQTT_CLIENT_ID}")

with open('./sensors_config.json', 'r') as f:
    config = json.load(f)
SENSOR_MAP = config['sensors']

client = mqtt.Client(client_id=MQTT_CLIENT_ID) 
client.username_pw_set(USER, PASS)

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected successfully to Home Assistant Broker")
    else:
        print(f"Connection failed with code {rc}")

client.on_connect = on_connect
client.connect(BROKER, PORT, 60)
client.loop_start()

def read_and_send():
    try:
        # Loop through all detected DS18B20 sensors
        for sensor in W1ThermSensor.get_available_sensors():
            sensor_id = sensor.id
            if sensor_id in SENSOR_MAP:
                topic = SENSOR_MAP[sensor_id]
                temperature = sensor.get_temperature()
                
                # Publish to HA (retain=True keeps the value visible if HA restarts)
                client.publish(topic, round(temperature, 2), retain=True)
                print(f"Published: {topic} -> {temperature}°C")
            else:
                print(f"Detected unknown sensor: {sensor_id}")
    except Exception as e:
        print(f"Error reading sensors: {e}")

try:
    print(f"Starting MQTT Bridge to {BROKER}...")
    while True:
        read_and_send()
        time.sleep(60)  # Updates every 1 minute
except KeyboardInterrupt:
    print("Exiting...")
    client.loop_stop()
    client.disconnect()
    
    