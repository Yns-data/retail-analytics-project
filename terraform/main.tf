locals {
  common = {
    project_id = var.project_id
    region     = var.region
  }
}

module "iam" {
  source     = "./modules/iam"
  project_id = local.common.project_id
}

module "artifact_registry" {
  source     = "./modules/artifact-registry"
  project_id = local.common.project_id
  region     = local.common.region
  repo_name  = var.repo_name
}

module "bigquery" {
  source     = "./modules/bigquery"
  project_id = local.common.project_id
  region     = local.common.region
}

module "cloud_run" {
  source = "./modules/cloud-run"

  project_id       = local.common.project_id
  region           = local.common.region
  service_account  = module.iam.service_account_email

  image_data_source = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repo_name}/${var.data_source_api}:${var.data_source_api_image_tag}"
}

module "cloud_build" {
  source = "./modules/cloudbuild-trigger"

  project_id          = local.common.project_id
  region              = local.common.region
  service_account_email  = module.iam.service_account_email
}
