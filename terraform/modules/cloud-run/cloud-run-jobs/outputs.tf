output "job_names" {
  value = {
    for k, job in google_cloud_run_v2_job.jobs :
    k => job.name
  }
}
