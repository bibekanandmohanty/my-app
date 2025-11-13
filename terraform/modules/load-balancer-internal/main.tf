resource "google_compute_region_network_endpoint_group" "ilb_neg" {
  name                  = "${var.backend_service}-neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = var.backend_service
  }
}

resource "google_compute_region_backend_service" "ilb_backend" {
  name                  = "${var.backend_service}-bes"
  region                = var.region
  load_balancing_scheme = "INTERNAL_MANAGED"
  protocol              = "HTTP"
  backend {
    group = google_compute_region_network_endpoint_group.ilb_neg.id
  }
}

resource "google_compute_region_url_map" "ilb_url_map" {
  name            = "${var.backend_service}-urlmap"
  region          = var.region
  default_service = google_compute_region_backend_service.ilb_backend.id
}

resource "google_compute_region_target_http_proxy" "ilb_http_proxy" {
  name   = "${var.backend_service}-httpproxy"
  region = var.region
  url_map = google_compute_region_url_map.ilb_url_map.id
}

resource "google_compute_forwarding_rule" "ilb_fwd_rule" {
  name                  = "${var.backend_service}-fwdrule"
  region                = var.region
  load_balancing_scheme = "INTERNAL_MANAGED"
  network               = var.vpc_self_link
  subnetwork            = var.subnet_self_link
  target                = google_compute_region_target_http_proxy.ilb_http_proxy.id
  port_range            = "80"
}

