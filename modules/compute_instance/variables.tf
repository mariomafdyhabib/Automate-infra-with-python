variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "Region for the instance(s)"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "Zone for the instance(s)"
  default     = "us-central1-a"
}

variable "network" {
  type        = string
  description = "VPC network name"
  default     = "default"
}

variable "subnetwork" {
  type        = string
  description = "Subnetwork name"
  default     = null
}

variable "service_account" {
  type        = string
  description = "Service account email for the VM"
  default     = null
}

variable "default_metadata" {
  type        = map(string)
  description = "Default metadata for all instances"
  default     = {}
}

variable "default_tags" {
  type        = list(string)
  description = "Default network tags for all instances"
  default     = []
}

variable "instances" {
  description = "List of compute instances"
  type = list(object({
    name            = string
    machine_type    = string
    zone            = string
    image           = string
    disk_size_gb    = number
    disk_type       = string
    enable_public_ip = bool
    tags            = list(string)
    metadata        = map(string)
  }))

  default = [
    {
      name            = "vm-1"
      machine_type    = "e2-micro"
      zone            = "us-central1-a"
      image           = "debian-cloud/debian-11"
      disk_size_gb    = 10
      disk_type       = "pd-balanced"
      enable_public_ip = true
      tags            = ["web"]
      metadata        = {}
    }
  ]
}
variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default = "gcp-terraform-key.json"
}