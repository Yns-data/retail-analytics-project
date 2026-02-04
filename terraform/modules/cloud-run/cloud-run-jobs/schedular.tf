resource "google_cloud_scheduler_job" "job_triggers" {
  for_each = {
    for key, job in var.cloud_run_jobs :
    key => job
    if job.scheduler.enabled
  }

  name     = "${each.value.name}-scheduler"
  project  = var.project_id
  region   = var.region_schedular

  schedule  = each.value.scheduler.schedule
  time_zone = each.value.scheduler.timezone

  http_target {
    http_method = "POST"
    uri = "https://${var.region}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${var.project_id}/jobs/${each.value.name}:run"

    oauth_token {
      service_account_email = var.service_account
    }
  }
}
