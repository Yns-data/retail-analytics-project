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


variable "repo_name" {
  description = "Nom du repository Docker"
  type        = string
}

