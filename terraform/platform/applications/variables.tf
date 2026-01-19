variable "project_id" {
  description = "ID du projet GCP "
  type        = string
}

variable "region" {
  description = "Région GCP"
  type        = string
}


variable "data_source_api_image_tag" {
  description = "Tag de l'image Docker"
  type        = string
}

variable "repo_name" {
  description = "Nom du repository Docker"
  type        = string
}

variable "data_source_api" {
  description = "Image docker de l'API source de données"
  type        = string
}


variable "service_account_email" {
  description = "Email du service account"
  type        = string

}

