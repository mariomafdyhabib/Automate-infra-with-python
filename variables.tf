# Project Configuration
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "us-central1-a"
}

# Network Variables
variable "network_name" {
  description = "Name of the network"
  type        = string
  default     = "main-network"
}

variable "auto_create_subnets" {
  description = "Whether to auto-create subnets"
  type        = bool
  default     = false
}

# Subnetwork Variables
variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    name          = string
    ip_cidr_range = string
    region        = string
  }))
  default = [
    {
      name          = "subnet-01"
      ip_cidr_range = "10.10.10.0/24"
      region        = "us-central1"
    }
  ]
}

# Storage Bucket Variables
variable "bucket_name" {
  description = "Name of the GCS bucket"
  type        = string
  default     = "my-unique-bucket-name"
}

variable "storage_class" {
  description = "Storage class for GCS bucket"
  type        = string
  default     = "STANDARD"
}

# Firewall Variables
variable "firewall_rules" {
  description = "List of firewall rules"
  type = list(object({
    name        = string
    direction   = string
    ports       = list(string)
    source_ranges = list(string)
  }))
  default = [
    {
      name        = "allow-ssh"
      direction   = "INGRESS"
      ports       = ["22"]
      source_ranges = ["0.0.0.0/0"]
    },
    {
      name        = "allow-http"
      direction   = "INGRESS"
      ports       = ["80", "443"]
      source_ranges = ["0.0.0.0/0"]
    }
  ]
}

# Cloud SQL Variables
variable "cloud_sql_instance_name" {
  description = "Name of the Cloud SQL instance"
  type        = string
  default     = "main-database"
}

variable "database_version" {
  description = "Database version"
  type        = string
  default     = "MYSQL_8_0"
}

variable "db_tier" {
  description = "Database machine tier"
  type        = string
  default     = "db-f1-micro"
}

variable "db_disk_size" {
  description = "Database disk size in GB"
  type        = number
  default     = 20
}

# Compute Instance Variables
variable "instance_name" {
  description = "Name of the compute instance"
  type        = string
  default     = "main-instance"
}

variable "machine_type" {
  description = "Machine type for compute instance"
  type        = string
  default     = "e2-medium"
}

variable "image" {
  description = "Image for compute instance"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

# GKE Cluster Variables
variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "main-cluster"
}

# Pub/Sub Variables
variable "pubsub_topics" {
  description = "List of Pub/Sub topics to create"
  type = list(object({
    name = string
  }))
  default = [
    {
      name = "my-topic"
    }
  ]
}
variable "project" {
  type        = string
  description = "The GCP project ID"
}

# Load Balancer Variables
variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
  default     = "web-lb"
}

variable "lb_backend_config" {
  description = "Load balancer backend configuration"
  type        = map(any)
  default     = {}
}

# IAM Variables
variable "iam_roles" {
  description = "List of IAM roles to assign"
  type        = list(string)
  default     = ["roles/viewer"]
}

variable "iam_members" {
  description = "List of IAM members"
  type        = list(string)
  default     = []
}

# Cloud Run Variables
variable "cloud_run_service_name" {
  description = "Name of the Cloud Run service"
  type        = string
  default     = "my-service"
}

# CDN & DNS Variables
variable "dns_zones" {
  description = "List of DNS zones to create"
  type        = list(any)
  default     = []
}
variable "name" {
  type        = string
  description = "Base name for resources"
}


variable "domain" {
  type        = string
  description = "Domain name to map to the CDN"
}

# Common Variables
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "required_apis" {
  description = "List of required Google APIs"
  type        = list(string)
  default = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "sqladmin.googleapis.com",
    "iam.googleapis.com",
    "storage.googleapis.com",
    "servicenetworking.googleapis.com",
    "pubsub.googleapis.com",
    "run.googleapis.com",
    "dns.googleapis.com"
  ]
}