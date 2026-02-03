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
    type =string
  
}

variable "cloud_run_jobs" {
    description = "definition des variables cloud run jobs"
    type = map(object({
     name = string
    image_name = string
    image_tag  = string
    env = map(string)
    scheduler = object({
    enabled  = bool
    schedule = string
    timezone = optional(string, "UTC")
    })
  }))
}






