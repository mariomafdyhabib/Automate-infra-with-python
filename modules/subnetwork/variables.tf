variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "Default region for resources"
  default     = "us-central1"
}

variable "network_id" {
  type        = string
  description = "The ID of the VPC network to attach subnetworks to"
}

variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))

  default = [
    {
      name   = "subnet-a"
      cidr   = "10.10.1.0/24"
      region = "us-central1"
    },
    {
      name   = "subnet-b"
      cidr   = "10.10.2.0/24"
      region = "us-east1"
    }
  ]
}
variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default = "gcp-terraform-key.json"
}