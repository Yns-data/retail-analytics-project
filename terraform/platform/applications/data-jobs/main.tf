locals {
  common = {
    project_id = var.project_id
    region     = var.region
  }
}

module "cloud_run_job_data_extraction" {
  source = "../../../modules/cloud-run/cloud-run-jobs"
  project_id          = local.common.project_id
  region              = local.common.region
  repo_name = var.repo_name
  service_account = data.terraform_remote_state.data_platform.outputs.service_account_email
  region_schedular = var.region_schedular
  cloud_run_jobs = {
    extraction = {
      name =  "extraction-from-data-source-api"
      image_name = var.extraction_job_image_name
      image_tag = var.image_extraction_from_data_source_api_tag
      env = {
      (var.env_data_api_key_name) = var.data_api_key_name
      (var.env_project_id) = local.common.project_id
      (var.env_secret_name) = var.secret_name
      (var.env_version_secret_name) = var.version_secret
      (var.env_datalake_bucket_name) = data.terraform_remote_state.data_platform.outputs.data_lake_bucket_name
      (var.env_API_URL_name) =  data.terraform_remote_state.data_source.outputs.cloud_run_api_source_url
      }
      scheduler = {
        enabled = true
        schedule = var.scheduler_cron_for_extraction_job
      }

  }
}
}

module "cloud_run_job_data_processing" {
  source = "../../../modules/cloud-run/cloud-run-jobs"
  project_id          = local.common.project_id
  region              = local.common.region
  repo_name = var.repo_name
  service_account = data.terraform_remote_state.data_platform.outputs.service_account_email
  region_schedular = var.region_schedular
  cloud_run_jobs = {
    population = {
      name =  "population-sales-brut"
      image_name = var.population_job_image_name
      image_tag = var.image_population_sales_table_tag
      env = {
      (var.env_project_id) = local.common.project_id
      (var.env_datalake_bucket_name) = data.terraform_remote_state.data_platform.outputs.data_lake_bucket_name
      (var.env_API_URL_name) =  data.terraform_remote_state.data_source.outputs.cloud_run_api_source_url
      (var.env_DATASET_name) = "retail_brut"
      (var.env_BQ_TABLE_NAME_key) = "sales"
      (var.env_PREFIX_BLOB_name) = "data/"
      (var.env_PREFIX_BLOB_PROCESSED_name) = "data-processed/"

      }
      scheduler = {
        enabled = false
        schedule = var.scheduler_cron_for_population_job
      }

    }
  }
}

module "cloud_run_job_dbt_staging" {
  source = "../../../modules/cloud-run/cloud-run-jobs"
  project_id          = local.common.project_id
  region              = local.common.region
  repo_name = var.repo_name
  service_account = data.terraform_remote_state.data_platform.outputs.service_account_email
  region_schedular = var.region_schedular
  cloud_run_jobs = {
    dbt_staging = {
      name =  "dbt-staging-job"
      image_name = var.dbt_project_image_name
      image_tag = var.image_dbt_project_tag
      command = var.command_dbt
      args    = var.args_dbt_staging
      env = {
      (var.env_project_id) = local.common.project_id
      (var.env_dbt_bucket_name) = data.terraform_remote_state.data_platform.outputs.dbt_bucket_name
      (var.env_DATASET_name) = "retail_brut"
      (var.env_BQ_TABLE_NAME_key) = "sales"
      (var.env_LOCATION_name) = local.common.region

      }
      scheduler = {
        enabled = false
        schedule = var.scheduler_cron_for_population_job
      }

    }
  }
}