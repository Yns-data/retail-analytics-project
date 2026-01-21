import requests
from dotenv import load_dotenv
import os
from datetime import datetime
load_dotenv()
TOKEN = os.getenv("DATA_API_KEY")
API_URL = os.getenv("API_URL")

date_time = datetime.now().strftime("%Y-%m-%d-%H-%M-%S")

results_cities = requests.get(
    f"{API_URL}/cities", 
    headers={"Authorization": f"Bearer {TOKEN}"},
    params={"date":date_time})

