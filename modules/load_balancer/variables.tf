variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "Region for backend resources"
  default     = "us-central1"
}

variable "name" {
  type        = string
  description = "Base name for load balancer resources"
}

variable "backend_group" {
  type        = string
  description = "Instance group or NEG self-link used as backend"
  default     = null
}

variable "ip_address" {
  type        = string
  description = "Static global IP address for the load balancer"
}

variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default     = "gcp-terraform-key.json"
}
