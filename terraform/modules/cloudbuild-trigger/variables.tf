variable "project_id" {
  description = "ID du projet GCP "
  type        = string
}

variable "region" {
  description = "Région GCP"
  type        = string
}

variable "service_account_email" {
  description = "Service Account utiliser pour les applications data"
  type        = string

}  