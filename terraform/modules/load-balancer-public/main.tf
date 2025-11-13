resource "google_compute_region_network_endpoint_group" "frontend_neg" {
  name                  = "${var.service_name}-neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = var.service_name
  }
}

resource "google_compute_backend_service" "frontend_backend" {
  name                  = "${var.service_name}-bes"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  protocol              = "HTTP"
  backend {
    group = google_compute_region_network_endpoint_group.frontend_neg.id
  }
}

resource "google_compute_url_map" "frontend_urlmap" {
  name            = "${var.service_name}-urlmap"
  default_service = google_compute_backend_service.frontend_backend.id
}

resource "google_compute_target_http_proxy" "frontend_proxy" {
  name   = "${var.service_name}-httpproxy"
  url_map = google_compute_url_map.frontend_urlmap.id
}

resource "google_compute_global_forwarding_rule" "frontend_fwd_rule" {
  name                  = "${var.service_name}-fwd"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  target                = google_compute_target_http_proxy.frontend_proxy.id
  port_range            = "80"
}

output "frontend_lb_ip" {
  value = google_compute_global_forwarding_rule.frontend_fwd_rule.ip_address
}

