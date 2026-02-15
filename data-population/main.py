from google.cloud import storage, bigquery
import logging
from dotenv import load_dotenv
import os
import uuid
from datetime import datetime


logger = logging.getLogger("Population-job")
logging.basicConfig(level=logging.INFO)


load_dotenv()
BUCKET_NAME = os.getenv("BUCKET_NAME")
PROJECT_ID = os.getenv("PROJECT_ID")
DATASET = os.getenv("DATASET")
BQ_TABLE_NAME = os.getenv("BQ_TABLE_NAME")
PREFIX_BLOB = os.getenv("PREFIX_BLOB")
PREFIX_BLOB_PROCESSED = os.getenv("PREFIX_BLOB_PROCESSED")
BQ_TABLE =f"{PROJECT_ID}.{DATASET}.{BQ_TABLE_NAME}"
BATCH_SIZE = 1000


def list_files_into_batches(
    batch_size:int,
    list_files:list)->list:

    list_size=len(list_files)
    list_result = []
    if batch_size >= list_size:
        return list_files
    else:
        for i in range(0,len(list_files),batch_size):
            list_result.append(list_files[i:i+batch_size])
        return list_result

def process_batch(
    list_blobs:list,
    bucket)->None:

    uris = [f"gs://{BUCKET_NAME}/{blob.name}" for blob in list_blobs]
    job_id = f"gcs_load_{uuid.uuid4().hex}"
    job_config = bigquery.LoadJobConfig(
    source_format=bigquery.SourceFormat.NEWLINE_DELIMITED_JSON,
    write_disposition=bigquery.WriteDisposition.WRITE_APPEND,
    ignore_unknown_values=True)
    bq_client = bigquery.Client(project=PROJECT_ID)

    logger.info(f"Loading job {job_id}")
    load_job = bq_client.load_table_from_uri(
        uris,
        BQ_TABLE,
        job_config=job_config,
        job_id=job_id
    )

    logger.info(f"Starting job {job_id}")
    load_job.result()
    now = datetime.utcnow().isoformat()

    if load_job.state == "DONE" and load_job.error_result is None:
        logger.info("Load job successed")

        for blob in list_blobs:
            blob.metadata={
                "status": "SUCCESS",
                "succeed_at": now 
            }
            blob.patch()
            try:
                bucket.copy_blob(
                    blob,
                    bucket,
                    blob.name.replace(
                        PREFIX_BLOB,
                        PREFIX_BLOB_PROCESSED
                        )
                        )
                blob.delete()
                logger.info(f"blob {blob.name} moved")
            except Exception as e :
                logger.error(
                    f"An error has occured while moving blob : {blob.name} to {PREFIX_BLOB_PROCESSED}"
                    )
                logger.error(
                    f"Error description: {e}"
                    )


    else:
        error_msg = str(load_job.error_result)

        logger.error("An error has occured while processing the job:", error_msg)

        for blob in list_blobs:
            blob.metadata={
                "status": "FAILED",
                "error": error_msg,
                "failed_at": now
            }
            blob.patch()

def process_blobs(
    client,
    bucket,
    blobs,
    batch_size)->None:

    new_blobs = list(blobs)

    if not new_blobs :
        logger.info("No new files found")
        exit(0)
    
    logger.info("Deviding list of blobs into batches")
    batches = list_files_into_batches(
        batch_size,
        new_blobs)
    batch_id = 0
    for batch in batches:
        batch_id=batch_id+1
        logger.info(f"Processing batch: {batch_id}")
        try:
            process_batch(
                batch,
                bucket)
            logger.info(f"Processing batch: {batch_id}")

        except Exception as e :
            logger.error(f"An error has occured while processing batch number : {batch_id}")
            logger.error(f"Error description : {e}")


if __name__ == "__main__":

    client = storage.Client()
    bucket = client.bucket(BUCKET_NAME)
    blobs = bucket.list_blobs(
        prefix=PREFIX_BLOB,
        max_results=10000
        )

    process_blobs(
    client,
    bucket,
    blobs,
    BATCH_SIZE
    )
