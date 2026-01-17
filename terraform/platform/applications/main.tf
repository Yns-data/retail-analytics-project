locals {
  common = {
    project_id = var.project_id
    region     = var.region
  }
}
module "cloud_run" {
  source = "././modules/cloud-run"
  project_id          = local.common.project_id
  region              = local.common.region
  service_account = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"
  service_account_email  = module.iam.service_account_email
}