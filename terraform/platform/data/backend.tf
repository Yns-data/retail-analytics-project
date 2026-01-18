terraform {
  backend "gcs" {
    bucket  = "tf-states-retail-analytics"
    prefix  = "platforms/data"
  }
}
