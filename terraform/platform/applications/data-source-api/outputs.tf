output "cloud_run_api_source_url" {
  description = "URL publique de l'api source de données"
  value       = module.cloud_run_data_source_api_service.cloud_run_api_source_url
}
