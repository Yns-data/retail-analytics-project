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


