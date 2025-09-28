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

variable "domains" {
  type        = list(string)
  description = "Domains for managed SSL certificate"
  default     = []
}

variable "use_managed_ssl" {
  type        = bool
  description = "Whether to use Google-managed SSL"
  default     = true
}

variable "certificate_path" {
  type        = string
  description = "Path to self-managed certificate file"
  default     = null
}

variable "private_key_path" {
  type        = string
  description = "Path to self-managed private key file"
  default     = null
}

variable "backend_group" {
  type        = string
  description = "Instance group or NEG self-link used as backend"
}

variable "ip_address" {
  type        = string
  description = "Static global IP address for the load balancer"
}
variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default = "gcp-terraform-key.json"
}