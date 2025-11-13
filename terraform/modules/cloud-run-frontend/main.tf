resource "google_cloud_run_v2_service" "frontend" {
  name                = var.service_name
  location            = var.region
  ingress             = "INGRESS_TRAFFIC_ALL"
  deletion_protection = false

  template {
    containers {
      image = var.image
      ports {
        container_port = 8080
      }
      env {
        name  = "BACKEND_URL"
        value = var.backend_internal_url
      }
    }

    service_account = "frontend-sa@${var.project_id}.iam.gserviceaccount.com"
  }
}
resource "google_cloud_run_service_iam_member" "public_invoker" {
  location = google_cloud_run_v2_service.frontend.location
  project  = google_cloud_run_v2_service.frontend.project
  service  = google_cloud_run_v2_service.frontend.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "service_name" {
  value = google_cloud_run_v2_service.frontend.name
}

output "service_uri" {
  value = google_cloud_run_v2_service.frontend.uri
}

