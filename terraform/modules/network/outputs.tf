output "vpc_self_link" {
  description = "Self link of the VPC network"
  value       = google_compute_network.this.self_link
}

output "subnet_self_link" {
  description = "Self link of the private subnet"
  value       = google_compute_subnetwork.private.self_link
}

output "vpc_connector" {
  description = "Full resource path of the Serverless VPC Access connector"
  value       = "projects/${var.project_id}/locations/${var.region}/connectors/${google_vpc_access_connector.serverless.name}"
}

