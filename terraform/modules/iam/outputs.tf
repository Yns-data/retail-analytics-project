output "service_account_email" {
  value = google_service_account.full_access_sa.email
}

output "service_account_name" {
  value = google_service_account.full_access_sa.name
}