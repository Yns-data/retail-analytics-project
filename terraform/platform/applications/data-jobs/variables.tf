variable "project_id" {
  description = "ID du projet GCP "
  type        = string
}

variable "region" {
  description = "Région GCP"
  type        = string
}



variable "env_project_id" {
  description = "nom de la variable d'environnement du projet id"
  type        = string
  default = "PROJECT_ID"

}


variable "env_data_api_key_name" {
  description = "nom de la variable d'environnement du nom de la clé de l'api"
  type        = string
  default = "DATA_API_KEY_NAME"
  
}
variable "data_api_key_name" {
  type = string
  default = "access_token"
}

variable "env_secret_name" {
  description = "nom de la variable d'environnement du nom du secret"
  type        = string
  default = "SECRET_NAME"
  
}

variable "secret_name" {
  type = string
  default = "DATA_API_KEY"
}

variable "env_version_secret_name" {
  description = "nom de la variable d'environnement de la vesion du secret"
  type        = string
  default = "VERSION"
  
}

variable "version_secret" {
  type = string
  default = "first"

}

variable "env_datalake_bucket_name" {
  type = string
  default = "BUCKET_NAME"
}


variable "env_API_URL_name" {
  type = string
  default = "API_URL"
}


variable "scheduler_cron_for_extraction_job" {
  type =string
  default = "* * * * *"
}

variable "scheduler_cron_for_population_job" {
  type =string
  default = "* * * * *"
}

variable enable_cloud_run_service_data_source_api {
  type    = bool
  default = true
}


variable "enable_cloud_run_extraction_job" {
  type    = bool
  default = true
}

variable "repo_name" {
  description = "Nom du repository Docker"
  type        = string
}
variable "image_extraction_from_data_source_api_tag" {
  description = " tag de l'image docker de la focntion d'extraction des données"
  type        = string
  default = "default"

}

variable "extraction_job_image_name" {
  type = string
  default = "default"

}

variable "region_schedular" {
  type = string
}

variable "env_DATASET_name" {
  type = string
  default = "DATASET"
}

variable "env_BQ_TABLE_NAME_key" {
  type = string
  default = "BQ_TABLE_NAME"
}

variable "env_PREFIX_BLOB_name" {
  type = string
  default = "PREFIX_BLOB"
}

variable "env_PREFIX_BLOB_PROCESSED_name" {
  type = string
  default = "PREFIX_BLOB_PROCESSED"
}

variable "population_job_image_name" {
  type = string
  default = "default"

}

variable "image_population_sales_table_tag" {
  type = string
  default = "default"

  
}