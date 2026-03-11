from datetime import datetime

from airflow import DAG
from airflow.models import Variable
from airflow.providers.google.cloud.operators.cloud_run import CloudRunExecuteJobOperator

PROJECT_ID = "glossy-metric-481911-c7"
REGION = "europe-west9"

with DAG(
    dag_id="dbt_cloud_run_pipeline",
    start_date=datetime(2026, 3, 1),
    schedule=None,
    catchup=False,
    tags=["dbt", "cloud-run"],
) as dag:

    dbt_staging = CloudRunExecuteJobOperator(
        task_id="dbt_staging",
        project_id=PROJECT_ID,
        region=REGION,
        job_name="dbt-staging-job",
    )

    dbt_intermidate = CloudRunExecuteJobOperator(
        task_id="dbt_intermidate",
        project_id=PROJECT_ID,
        region=REGION,
        job_name="dbt-intermidate-job",
    )

    dbt_marts = CloudRunExecuteJobOperator(
        task_id="dbt_marts",
        project_id=PROJECT_ID,
        region=REGION,
        job_name="dbt-marts-job",
    )

    dbt_staging >> dbt_intermidate >> dbt_marts