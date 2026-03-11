from google.cloud import storage

# Configuration
bucket_name = "us-central1-test-composer-6b02c8d3-bucket"
source_file = "/home/chronos_neworder/retail-analytics-project/composer/dags/test_pipeline_dbt_log.py"
destination_blob = "dags/test_pipeline_dbt_log.py"

def upload_to_gcs():
    # Create client
    client = storage.Client()

    # Get bucket
    bucket = client.bucket(bucket_name)

    # Create blob
    blob = bucket.blob(destination_blob)

    # Upload file
    blob.upload_from_filename(source_file)

    print(f"File {source_file} uploaded to gs://{bucket_name}/{destination_blob}")

if __name__ == "__main__":
    upload_to_gcs()