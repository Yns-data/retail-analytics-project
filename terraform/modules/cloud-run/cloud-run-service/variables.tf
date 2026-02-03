variable "project_id" {
  description = "ID du projet GCP "
  type        = string
}

variable "region" {
  description = "Région GCP"
  type        = string
}


variable "service_account" {
  description = "Service Account utilisé par Cloud Run ET Cloud Build"
  type        = string
}



variable "image_data_source" {
  description = "Image docker de l'API source de données"
  type        = string
}

variable "fastapi_port" {
  description = "Port exposition de l'app fastapi"
  type        = number
  default     = 8000
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








