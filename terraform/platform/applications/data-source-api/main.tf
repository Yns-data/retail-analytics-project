locals {
  common = {
    project_id = var.project_id
    region     = var.region
  }
}

data "terraform_remote_state" "service_account" {
  backend = "gcs"

  config = {
    bucket  = "tf-states-retail-analytics"
    prefix  = "platforms/data"
  }
}
module "cloud_run_data_source_api_service" {
  source = "../../../modules/cloud-run/cloud-run-service"
  project_id          = local.common.project_id
  region              = local.common.region
  service_account = data.terraform_remote_state.data_platform.outputs.service_account_email
  image_data_source = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repo_name}/${var.data_source_api}:${var.data_source_api_image_tag}"
}

