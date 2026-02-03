output "cloud_run_api_source_url" {
  description = "URL publique de l'api source de données"
  value       = google_cloud_run_v2_service.source-data-api.uri
}