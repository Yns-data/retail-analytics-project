from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.google.cloud.operators.cloud_run import CloudRunExecuteJobOperator

from google.cloud import logging

PROJECT_ID = "glossy-metric-481911-c7"
REGION = "europe-west9"


def fetch_dbt_logs(job_name: str, **context):
    """
    Récupère les logs Cloud Run du job et les affiche dans Airflow
    """
    logger = logging.Client(project=PROJECT_ID)

    # filtre Cloud Logging
    filter_str = f'''
    resource.type="cloud_run_job"
    resource.labels.job_name="{job_name}"
    '''

    entries = logger.list_entries(filter_=filter_str, order_by=logging.DESCENDING)

    ti = context["ti"]
    ti.log.info("===== DBT LOGS FROM CLOUD RUN (%s) =====", job_name)

    count = 0
    for entry in entries:
        payload = entry.payload

        if isinstance(payload, dict):
            message = payload.get("message", str(payload))
        else:
            message = str(payload)

        ti.log.info(message)

        count += 1
        if count > 200:
            break

    ti.log.info("===== END DBT LOGS =====")


with DAG(
    dag_id="dbt_cloud_run_pipeline_log",
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

    staging_logs = PythonOperator(
        task_id="dbt_staging_logs",
        python_callable=fetch_dbt_logs,
        op_kwargs={"job_name": "dbt-staging-job"},
    )

    dbt_intermidate = CloudRunExecuteJobOperator(
        task_id="dbt_intermidate",
        project_id=PROJECT_ID,
        region=REGION,
        job_name="dbt-intermidate-job",
    )

    intermidate_logs = PythonOperator(
        task_id="dbt_intermidate_logs",
        python_callable=fetch_dbt_logs,
        op_kwargs={"job_name": "dbt-intermidate-job"},
    )

    dbt_marts = CloudRunExecuteJobOperator(
        task_id="dbt_marts",
        project_id=PROJECT_ID,
        region=REGION,
        job_name="dbt-marts-job",
    )

    marts_logs = PythonOperator(
        task_id="dbt_marts_logs",
        python_callable=fetch_dbt_logs,
        op_kwargs={"job_name": "dbt-marts-job"},
    )

    dbt_staging >> staging_logs >> dbt_intermidate >> intermidate_logs >> dbt_marts >> marts_logs