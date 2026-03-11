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
    
    # Cloud Scheduler
    "roles/cloudscheduler.admin",

    # Cloud Run
    "roles/run.admin",

    # Cloud Build
    "roles/cloudbuild.builds.editor",

    # Cloud Logging
    "roles/logging.logWriter",
    "roles/logging.viewer",

    # IAM
    "roles/iam.serviceAccountUser",

    # Workflows
    "roles/workflows.admin",
    "roles/workflows.invoker",

    # Composer
    "roles/composer.admin",
    "roles/composer.worker",
    "roles/composer.user",
    "roles/composer.environmentAndStorageObjectAdmin",

    # Composer dépendances fréquentes
    "roles/container.admin",        # GKE utilisé par Composer
    "roles/compute.networkAdmin",   # gestion réseau
    "roles/compute.viewer"
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.full_access_sa.email}"
}
