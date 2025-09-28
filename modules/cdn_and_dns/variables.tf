variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "name" {
  type        = string
  description = "Base name for resources"
}

variable "bucket_name" {
  type        = string
  description = "GCS bucket name to serve content from"
}

variable "domain" {
  type        = string
  description = "Domain name to map to the CDN"
}
variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default = "gcp-terraform-key.json"
}