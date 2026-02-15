from google.cloud import storage
from dotenv import load_dotenv
import os

load_dotenv()

BUCKET_NAME = os.getenv("BUCKET_NAME")
PREFIX_BLOB = os.getenv("PREFIX_BLOB")
PREFIX_BLOB_PROCESSED = os.getenv("PREFIX_BLOB_PROCESSED")


client = storage.Client()
bucket = client.bucket(BUCKET_NAME)

blobs = client.list_blobs(BUCKET_NAME, prefix=PREFIX_BLOB)
count = sum(1 for _ in blobs)

print(f"Nombre de blobs: {count}")
