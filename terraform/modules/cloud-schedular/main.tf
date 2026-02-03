resource "google_cloud_scheduler_job" "extraction_from_data_source_api_cron_job" {
  project          = var.project_id
  region           = var.region
  name             = "extraction_from_data_source_api_cron_job"
  schedule         = var.scheduler_cron_for_extraction_job
  attempt_deadline = "320s"

  retry_config {
    retry_count = 3
  }

  http_target {
    http_method = "POST"
    uri         = "https://${var.region}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${var.project_id}/jobs/extraction_from_data_source_api:run"

    oauth_token {
      service_account_email = var.service_account
    }
  }

  depends_on = [
    google_cloud_run_v2_job.team_league_cloud_run_job
  ]
}