import paho.mqtt as mqtt_module
import paho.mqtt.client as mqtt

# Check the version from the top-level module
print(f"Paho MQTT Version: {mqtt_module.__version__}")

# Initialize a client
# Note: Version 1.6.1 does NOT use the CallbackAPIVersion parameter
client = mqtt.Client()
print("Client initialized successfully!")

