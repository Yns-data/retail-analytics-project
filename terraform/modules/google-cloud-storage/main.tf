resource "google_storage_bucket" "bucket_datalake" {
  name     = "retail-analytics-data-lake"
  location = var.region

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    }
    condition {
      age = 30
    }
  }

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "COLDLINE"
    }
    condition {
      age = 90
    }
  }

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "ARCHIVE"
    }
    condition {
      age = 365
    }
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 730
    }
  }
}
resource "google_storage_bucket" "bucket_tf_states" {
  name     = "tf-states-retail-analytics"
  location = var.region
}