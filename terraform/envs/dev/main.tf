module "network" {
  source     = "../../modules/network"
  project_id = var.project_id
  region     = var.region
  vpc_name   = var.vpc_name
  subnet_name = var.subnet_name
}

module "backend" {
  source     = "../../modules/cloud-run-backend"
  project_id = var.project_id
  region     = var.region
  image      = var.backend_image
  service_name = var.backend_service_name
  vpc_connector = module.network.vpc_connector
  subnet_self_link = module.network.subnet_self_link
}

module "internal_lb" {
  source        = "../../modules/load-balancer-internal"
  project_id    = var.project_id
  region        = var.region
  backend_service = module.backend.backend_service_name
  vpc_self_link = module.network.vpc_self_link
  subnet_self_link = module.network.subnet_self_link
}

module "frontend" {
  source              = "../../modules/cloud-run-frontend"
  project_id          = var.project_id
  region              = var.region
  image               = "us-central1-docker.pkg.dev/gitops-testing-478006/docker-repo/frontend:latest"
  service_name        = "frontend-dev"
  backend_internal_url = module.internal_lb.forwarding_rule_ip
}

module "public_lb" {
  source        = "../../modules/load-balancer-public"
  project_id    = var.project_id
  region        = var.region
  service_name  = module.frontend.service_name
}

