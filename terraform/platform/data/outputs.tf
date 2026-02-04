output "service_account_email" {
  value = module.iam.service_account_email
}

output "service_account_id" {
  value = module.iam.service_account_name
}

output "data_lake_bucket_name" {
  value = module.google_storage_buckets.datalake_bucket_name
}

