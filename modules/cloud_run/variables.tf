variable "project" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "Region to deploy Cloud Run service"
  default     = "us-central1"
}

variable "name" {
  type        = string
  description = "Cloud Run service name"
}

variable "image" {
  type        = string
  description = "Container image for Cloud Run (gcr.io, Artifact Registry, Docker Hub, etc.)"
}

variable "cpu" {
  type        = string
  description = "CPU limit (e.g. '1', '2')"
  default     = "1"
}

variable "memory" {
  type        = string
  description = "Memory limit (e.g. '512Mi', '1Gi')"
  default     = "512Mi"
}

variable "concurrency" {
  type        = number
  description = "Number of requests a container can handle at once"
  default     = 80
}

variable "timeout_seconds" {
  type        = number
  description = "Request timeout in seconds"
  default     = 300
}

variable "env_vars" {
  type        = map(string)
  description = "Environment variables for the container"
  default     = {}
}

variable "allow_unauthenticated" {
  type        = bool
  description = "Allow unauthenticated invocations (public endpoint)"
  default     = true
}
variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default = "gcp-terraform-key.json"
}