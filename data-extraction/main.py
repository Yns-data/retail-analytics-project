import requests
from dotenv import load_dotenv
import os
from datetime import datetime
from google.cloud import storage, secretmanager
import json
import time

load_dotenv()
SECRET_NAME = os.getenv("SECRET_NAME")
API_URL = os.getenv("API_URL")
DATA_API_KEY_NAME = os.getenv("DATA_API_KEY_NAME")
BUCKET_NAME = os.getenv("BUCKET_NAME")
PROJECT_ID = os.getenv("PROJECT_ID")
VERSION= os.getenv("VERSION")

def get_gcp_secret():
    client = secretmanager.SecretManagerServiceClient()
    secret_path = f"projects/{PROJECT_ID}/secrets/{SECRET_NAME}/versions/{VERSION}"
    response = client.access_secret_version(name=secret_path)
    return response.payload.data.decode("UTF-8")

TOKEN = get_gcp_secret()

def fetching_data():
    # categories and routes
    categories = [
        "food",
        "wear", 
        "electronics", 
        "books", 
        "sports", 
        "toys", 
        "home", 
        "garden", 
        "beauty", 
        "automotive"]
    routes = [
        "cities", 
        "pages_viewed", 
        "visitors",
        "articles"]

    # fetching data
    date_time = datetime.now().strftime("%Y-%m-%d-%H-%M-%S")
    HEADERS = {DATA_API_KEY_NAME: TOKEN}
    results = {}
    for route in routes:
        try :
            if route == "articles":
                for category in categories:
                    results.update(requests.get(
                        f"{API_URL}/{route}/{category}", 
                        headers=HEADERS,
                        params={"date":date_time}).json())
            else:
                results.update(
                    requests.get(
                        f"{API_URL}/{route}", 
                        headers=HEADERS,
                        params={"date":date_time}).json())
            print(f"Data fetched successfully for {route}")
        except Exception as e:
            print(f"An error has occured while fetching the route {route}: {e}")

    # storage 
    try:
        client = storage.Client()
        bucket = client.bucket(BUCKET_NAME)
        blob = bucket.blob(f"data/{date_time}.json")
        blob.upload_from_string(data=json.dumps(results))
        print("Data stored successfully")
    except Exception as e:
        print(f"An error has occured while storing the data: {e}")

if __name__ == "__main__":
    for i in range(4):
        try :
            fetching_data()
            time.sleep(5)
        except Exception as e :
            print(f"an error has occured while fetching the data in {i} iteration: {e}")





