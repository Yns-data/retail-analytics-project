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
  included_files = ["data-source-api/**","ci-cd/data-source-api-deployment.yaml"]

  # Fichier Cloud Build à exécuter
  filename = "ci-cd/data-source-api-deployment.yaml"
}

resource "google_cloudbuild_trigger" "data-extraction-job-trigger" {
  name = "data-extraction-job-trigger"

  service_account = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"

  github {
    owner = "Yns-data"
    name  = "retail-analytics-project"

    push {
      branch = "^main$"
    }
  }

  # Déclenchement uniquement si un fichier dans ci-cd/ change
  included_files = ["data-source-api/**","ci-cd/data-extraction-job-deployment.yaml"]

  # Fichier Cloud Build à exécuter
  filename = "ci-cd/data-extraction-job-deployment.yaml"
}


resource "google_service_account_iam_member" "cloudbuild_use_sa" {
  service_account_id = var.service_account_name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${var.service_account_email}"
}
