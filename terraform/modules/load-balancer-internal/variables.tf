variable "project_id" {}
variable "region" {}
variable "backend_service" {}
variable "vpc_self_link" {}
variable "subnet_self_link" {
  description = "Self link of the subnetwork for the internal LB"
}

