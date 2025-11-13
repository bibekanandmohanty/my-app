output "forwarding_rule_ip" {
  value = google_compute_forwarding_rule.ilb_fwd_rule.ip_address
}

output "url_map" {
  value = google_compute_region_url_map.ilb_url_map.id
}

output "backend_service_id" {
  value = google_compute_region_backend_service.ilb_backend.id
}

