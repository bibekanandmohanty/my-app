terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

# Use your project + a region
provider "google" {
  project = "cloudbuild-478701"
  region  = "us-central1"
}

# 1) Cloud Run service running a simple public Python-like sample container
resource "google_cloud_run_v2_service" "python_app" {
  name     = "python-app-dev"
  location = "us-central1"

  template {
    containers {
      # Public sample container maintained by Google (simple web app)
      image = "us-central1-docker.pkg.dev/cloudbuild-478701/python-app-repo/python-app:v1"

    }
  }

  ingress = "INGRESS_TRAFFIC_ALL"
}

# 2) Make the service publicly invokable (no auth)
resource "google_cloud_run_v2_service_iam_member" "python_app_invoker" {
  name     = google_cloud_run_v2_service.python_app.name
  location = google_cloud_run_v2_service.python_app.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# 3) Output the public URL after apply
output "service_url" {
  value = google_cloud_run_v2_service.python_app.uri
}

