# Créaton de la ressource
resource "google_cloud_run_v2_service" "source-data-api" {
  name     = "api-data-source"
  location = var.region

  template {
    service_account = var.service_account
    timeout         = "300s"

  
    
    scaling {
      max_instance_count = 10
      min_instance_count = 1
    }

    containers {
      image = var.image_data_source

      ports {
        container_port = var.fastapi_port
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }

      env {
        name  = "DATA_API_KEY_NAME"
        value = "access_token"
      }
      env {
        name  = "PROJECT_ID"
        value = var.project_id
      }
      env {
        name  = "SECRET_NAME"
        value = "DATA_API_KEY"
      }
      env {
        name  = "VERSION"
        value = "first"
      
      }

    }
  }

  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }

  ingress = "INGRESS_TRAFFIC_ALL"
}
# configuration du service et des accès pout sur l'api soit accéssible publiquement 
resource "google_cloud_run_v2_service_iam_member" "public_access" {
  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.source-data-api.name

  role   = "roles/run.invoker"
  member = "allUsers"
}