data "terraform_remote_state" "data_platform" {
  backend = "gcs"

  config = {
    bucket = "tf-states-retail-analytics"
    prefix = "platforms/data"
  }
}
