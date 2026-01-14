import paho.mqtt.client as mqtt
import time

# Configuration
BROKER = "192.168.1.70"  # Your Home Assistant IP
PORT = 1883
USER = "pi2"
PASS = "yV9H23"
TOPIC = "home/pi2/test"

client = mqtt.Client()
client.username_pw_set(USER, PASS)
client.connect(BROKER, PORT)

while True:
    temp = 12.5 # Replace this with your actual sensor reading logic
    client.publish(TOPIC, temp)
    print(f"Sent {temp} to {TOPIC}")
    time.sleep(60)
    
    