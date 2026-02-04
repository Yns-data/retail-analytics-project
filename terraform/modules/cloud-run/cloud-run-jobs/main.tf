resource "google_cloud_run_v2_job" "jobs" {
  for_each = var.cloud_run_jobs
  project  = var.project_id
  name     = each.value.name
  location = var.region

  template {
    template {
      service_account = var.service_account
      max_retries = 3

      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.
        repo_name}/${each.value.image_name}:${each.value.image_tag}"
      
      dynamic "env" {
        for_each = each.value.env
        content {
          name = env.key
          value = env.value
        }
        
      }

      }
    }
  }
}

resource "google_service_account_iam_member" "self_act_as" {
  service_account_id = var.service_account_name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${var.service_account}"
}
