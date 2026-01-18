resource "google_cloudbuild_trigger" "data-source-api-trigger" {
  name = "trigger-datasource-api"

  service_account = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"

  github {
    owner = "Yns-data"
    name  = "retail-analytics-project"

    push {
      branch = "^main$"
    }
  }

  # Déclenchement uniquement si un fichier dans ci-cd/ change
  included_files = ["data-source-api/**"]

  # Fichier Cloud Build à exécuter
  filename = "ci-cd/data-source-api-deployment.yaml"
}
