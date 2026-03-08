FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y gcc \
    && rm -rf /var/lib/apt/lists/*

# ENV VERSION=first \
#     PROJECT_ID=glossy-metric-481911-c7 \
#     API_URL=https://api-data-source-473481245278.europe-west9.run.app \
#     BUCKET_NAME_PREFIX=retail-analytics-data-lake \
#     BUCKET_NAME=retail-analytics-data-lake-glossy-metric-481911-c7 \
#     DATASET=retail_brut \
#     BQ_TABLE_NAME=sales \
#     PREFIX_BLOB=data/ \
#     PREFIX_BLOB_PROCESSED=data-processed/ \
#     DATASET_STAGING=retail_staging \
#     LOCATION=europe-west9

RUN pip install dbt-bigquery

COPY dbt ./dbt
WORKDIR /app/dbt

# CMD ["dbt", "run", "--select", "staging"]