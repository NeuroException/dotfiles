import requests
import json
import sys

def get_weather(cityID: str, apiKey: str) -> dict:
	# Build request url
	url: str = f"http://api.openweathermap.org/data/2.5/weather?id={cityID}&units=metric&lang=%s&APPID={apiKey}"

    # Get all weather data
	data: dict = requests.get(url).json()

    # Return result
	return data


# Check arguments
if len(sys.argv) < 3:
    # Print usage
    print("Usage: weather.py <cityID> <apiKey>")

    # Exit
    exit(0)

# Get cityID
cityID: str = sys.argv[1]

# Get apiKey
apiKey: str = sys.argv[2]

try:
    # Send request
    data: dict = get_weather(cityID, apiKey)

	# Get weather
    weather: str = data["weather"][0]["description"]

    # Get temperature
    temp: float = data["main"]["temp"]

    # Build final string
    result: str = f"{weather} {temp}°C"

    # Print result
    print(result)
except:
    print("There was an error while fetching the weather data.")
