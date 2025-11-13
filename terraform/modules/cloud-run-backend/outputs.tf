output "service_name" {
  value = google_cloud_run_v2_service.backend.name
}

output "service_uri" {
  value = google_cloud_run_v2_service.backend.uri
}

output "service_account_email" {
  value = "backend-sa@${var.project_id}.iam.gserviceaccount.com"
}

output "backend_service_name" {
  description = "Alias for the Cloud Run backend service name"
  value       = google_cloud_run_v2_service.backend.name
}
