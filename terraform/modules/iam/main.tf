resource "google_service_account" "full_access_sa" {
  account_id   = "platform-full-access-data"
  display_name = "Platform Full Access Service Account"
}

resource "google_project_iam_member" "full_access_roles" {
  for_each = toset([
    # GCS
    "roles/storage.admin",

    # BigQuery
    "roles/bigquery.admin",

    # Dataflow
    "roles/dataflow.admin",

    # Artifact Registry
    "roles/artifactregistry.admin",

    # Cloud Run
    "roles/run.admin",

    # Cloud Build
    "roles/cloudbuild.builds.editor",

    # Cloud Logging
    "roles/logging.logWriter",
    "roles/logging.viewer",

    # IAM (pour permettre à Cloud Build / Run d’utiliser le SA)
    "roles/iam.serviceAccountUser"
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.full_access_sa.email}"
}
