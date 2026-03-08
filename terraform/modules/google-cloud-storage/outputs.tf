output "datalake_bucket_name" {
  value = google_storage_bucket.bucket_datalake.name
}

output "bucket_dbt_name" {
  value = google_storage_bucket.bucket_dbt.name
}