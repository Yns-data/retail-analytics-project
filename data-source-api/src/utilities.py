from typing import Optional
from fastapi.responses import JSONResponse
import re
import os
from dotenv import load_dotenv
from fastapi import Security, HTTPException, status
from fastapi.security.api_key import APIKeyHeader
from google.cloud import secretmanager
load_dotenv()

PROJECT_ID = os.getenv("PROJECT_ID")
SECRET_NAME = os.getenv("SECRET_NAME")
VERSION = os.getenv("VERSION")
API_KEY_NAME = os.getenv("DATA_API_KEY_NAME")

def get_gcp_secret(project_id:str,secret_name:str,version:str):
    client = secretmanager.SecretManagerServiceClient()
    secret_path = f"projects/{project_id}/secrets/{secret_name}/versions/{version}"
    response = client.access_secret_version(name=secret_path)
    return response.payload.data.decode("UTF-8")

API_KEY = get_gcp_secret(PROJECT_ID,SECRET_NAME,VERSION)
api_key_header = APIKeyHeader(name=API_KEY_NAME, auto_error=False)

def get_api_key(api_key:str = API_KEY,api_key_header: str = Security(api_key_header)):
    if api_key_header == api_key:
        return api_key_header
    raise HTTPException(
        status_code=status.HTTP_403_FORBIDDEN,
        detail="Could not validate credentials"
    )

def process_dates(
    date: Optional[str],
    dates: Optional[list[str]],
    date_format: str,
    error_msg: str):
    """Helper function to process dates and validate format"""
    if not date and not dates:
        return JSONResponse(
            status_code=400,
            content={"error": "You must provide at least one 'date' or 'dates' parameter"}
        )

    dates_to_process = ([date] if date else []) + (dates if dates else [])
    
    if any(not re.match(date_format, d) for d in dates_to_process):
        return JSONResponse(
            status_code=400,
            content={"error": error_msg}
        )

    return dates_to_process