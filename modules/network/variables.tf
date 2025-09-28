variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "The region to create resources in"
  default     = "us-central1"
}

variable "network_name" {
  type        = string
  description = "The name of the VPC network"
  default     = "my-vpc"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
  default     = "my-subnet"
}

variable "subnet_cidr" {
  type        = string
  description = "The CIDR block for the subnet"
  default     = "10.0.0.0/24"
}
variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default = "gcp-terraform-key.json"
}
