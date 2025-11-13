variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "VPC name for this environment"
  type        = string
  default     = "gitops-vpc-dev"
}

variable "subnet_name" {
  description = "Private subnet name"
  type        = string
  default     = "gitops-private-subnet-dev"
}

variable "backend_image" {
  description = "Container image for backend Cloud Run"
  type        = string
  default     = ""
}

variable "backend_service_name" {
  description = "Cloud Run backend service name"
  type        = string
  default     = "backend-dev"
}

