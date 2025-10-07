# Project Configuration

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
variable "project" {
  description = "The GCP project ID where resources will be created"
  type        = string
  default     = "playground-s-11-4dd577ac"
}


variable "network_id" {
  description = "The ID of the existing VPC network to attach subnetworks to"
  type        = string
  default     = "projects/playground-s-11-4dd577ac/global/networks/mario-vpc"
}

variable "subnets" {
  description = "List of subnet configurations for the project"
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
  default = [
    {
      name   = "app-subnet"
      cidr   = "10.30.1.0/24"
      region = "us-central1"
    },
    {
      name   = "db-subnet"
      cidr   = "10.30.2.0/24"
      region = "us-east1"
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
  description = "List of firewall rules to create in the VPC"
  type = list(object({
    name          = string
    direction     = string
    protocol      = string
    ports         = optional(list(string))
    source_ranges = list(string)
    priority      = number
  }))

  default = [
    {
      name          = "allow-ssh"
      direction     = "INGRESS"
      protocol      = "tcp"
      ports         = ["22"]
      source_ranges = ["0.0.0.0/0"]
      priority      = 1000
    },
    {
      name          = "allow-internal"
      direction     = "INGRESS"
      protocol      = "all"
      # ports omitted since protocol=all
      source_ranges = ["10.0.0.0/16"]
      priority      = 1001
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

variable "db_name" {
  description = "The name of the database to be created"
  type        = string
  default     = "appdb"
}

variable "db_user" {
  description = "The username for the database"
  type        = string
  default     = "appuser"
}

variable "db_password" {
  description = "The password for the database user"
  type        = string
  sensitive   = true
  default     = "securepassword123"
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
variable "lb_ip_address" {
  description = "The IP address for the load balancer"
  type        = string
}

variable "lb_backend_group" {
  description = "The backend group for the load balancer"
  type        = string
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
variable "service_name" {
  description = "The name of the Cloud Run service"
  type        = string
  default     = "my-cloudrun-service"
}

variable "docker-image" {
  description = "The container image to deploy to Cloud Run"
  type        = string
  default     = "mariomafdy/teamavailtest:latest"
}

variable "allow_unauthenticated" {
  description = "Whether to allow unauthenticated invocations of the Cloud Run service"
  type        = bool
  default     = true
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
variable "dns_managed_zone" {
  description = "The name of the Cloud DNS managed zone"
  type        = string
  default     = "my-zone"
}

variable "dns_name" {
  description = "The DNS domain name (must end with a period)"
  type        = string
  default     = "example.com."
}

variable "cdn_backend_bucket" {
  description = "The name of the Cloud Storage bucket used as a backend for the CDN"
  type        = string
  default     = "python-managed-bucket"
}

variable "dns_records" {
  description = "List of DNS record configurations to create in the managed zone"
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    rrdatas = list(string)
  }))

  default = [
    {
      name    = "www"
      type    = "A"
      ttl     = 300
      rrdatas = ["34.120.0.1"]
    }
  ]
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
variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default = "gcp-terraform-key.json"
}