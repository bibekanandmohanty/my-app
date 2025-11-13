resource "google_cloud_run_v2_service" "backend" {
  name     = var.service_name
  location = var.region
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  deletion_protection = false

  template {
    containers {
      image = var.image
      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }

    service_account = "backend-sa@${var.project_id}.iam.gserviceaccount.com"
    vpc_access {
      connector = var.vpc_connector
      egress    = "ALL_TRAFFIC"
    }
  }
}

