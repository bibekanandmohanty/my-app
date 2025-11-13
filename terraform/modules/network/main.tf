resource "google_compute_network" "this" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private" {
  name          = var.subnet_name
  ip_cidr_range = "10.10.0.0/24"
  region        = var.region
  network       = google_compute_network.this.id
  private_ip_google_access = true
}

# Proxy-only subnet for internal HTTP(S) Load Balancing
resource "google_compute_subnetwork" "proxy_only" {
  name          = "${var.vpc_name}-proxy-subnet"
  ip_cidr_range = "10.100.0.0/26"  # Must be unique and non-overlapping
  region        = var.region
  network       = google_compute_network.this.id
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
}


resource "google_vpc_access_connector" "serverless" {
  name          = "${var.vpc_name}-connector"
  region        = var.region
  network       = google_compute_network.this.name
  ip_cidr_range = "10.8.0.0/28"
  min_throughput = 200
  max_throughput = 300
}

