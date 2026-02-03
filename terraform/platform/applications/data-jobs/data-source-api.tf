data "terraform_remote_state" "data_source" {
    backend = "gcs"

  config = {
    bucket = "tf-states-retail-analytics"
    prefix = "platforms/runtime"
  } 
}