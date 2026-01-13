
resource "google_cloudbuild_trigger" "folder_trigger" {
  name        = "trigger-ci"
  
  service_account = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"

  
  github {
    owner = "Yns-data"
    name  = "Data_Api"

    push {
      branch = "^main$"
    }
  }

  # Fichier Cloud Build à exécuter
  filename = "cloudbuild.yaml"


}
