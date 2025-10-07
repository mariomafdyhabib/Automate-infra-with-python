terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
  }


}   

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
  # credentials = file(var.credentials_file)
}



# Network Module
module "network" {
  source = "./modules/network"
  count  = var.enable_network ? 1 : 0

  project            = var.project
  network_name       = var.network_name

}

# Declare subnets variable
module "subnetwork" {
  source = "./modules/subnetwork"
  count  = var.enable_network ? 1 : 0

  project         = var.project
  region          = var.region
  network_id      = var.network_id
  subnets         = var.subnets
  

}



# Storage Bucket Module
module "storage_bucket" {
  source = "./modules/storage_bucket"
  count  = var.enable_network ? 1 : 0

  project = var.project
  buckets = [
    {
      name          = var.bucket_name
      location      = var.region
      storage_class = var.storage_class
    }
  ]


}

# Firewall Module
module "firewall" {
  source = "./modules/firewall"
  count  = var.enable_network ? 1 : 0

  project        = var.project
  network_id     = var.network_id
  firewall_rules = var.firewall_rules

}

# Cloud SQL Module
module "cloud_sql" {
  source = "./modules/cloud_sql"
  count  = var.enable_network ? 1 : 0

  project           = var.project
  region            = var.region
  instance_name     = var.cloud_sql_instance_name
  database_version  = var.database_version
  tier              = var.db_tier
  disk_size         = var.db_disk_size
  db_name           = var.db_name
  db_user           = var.db_user
  db_password       = var.db_password
  

}

# Compute Instance Module
module "compute_instance" {
  source = "./modules/compute_instance"
  count  = var.enable_network ? 1 : 0

  project      = var.project
  zone         = var.zone
  network      = var.network_name
  subnetwork   = var.subnetwork
  # instance_name = var.instances[0].name
  # machine_type  = var.instances[0].machine_type
  # image         = var.instances[0].image


}

# GKE Cluster Module
module "gke_cluster" {
  source = "./modules/gke_cluster"
  count  = var.enable_network ? 1 : 0

  project      = var.project
  region       = var.region
  cluster_name = var.cluster_name
  network      = module.network.network_name
  subnetwork   = module.subnetwork.subnet_names[0]

}

# Pub/Sub Module
module "pub_sub" {
  source = "./modules/pubsub"
  count  = var.enable_network ? 1 : 0

  project = var.project
  topics  = [for topic in var.pubsub_topics : topic.name]

}

# Load Balancer Module
module "load_balancer" {
  source = "./modules/load_balancer"
  count  = var.enable_network ? 1 : 0

  project        = var.project
  region         = var.region
  name           = var.lb_name
  ip_address     = var.lb_ip_address
  backend_group  = var.lb_backend_group

}

# IAM Module
module "iam" {
  source = "./modules/iam"
  count  = var.enable_network ? 1 : 0

  project = var.project

}

# Cloud Run Module
module "cloud_run" {
  source = "./modules/cloud_run"
  count  = var.enable_network ? 1 : 0

  project = var.project
  region  = var.region
  name    = var.service_name
  image   = var.docker-image

}

# CDN & DNS Module
module "cdn_and_dns" {
  source      = "./modules/cdn_and_dns"
  count  = var.enable_network ? 1 : 0
  name        = var.dns_managed_zone
  bucket_name = var.cdn_backend_bucket
  project     = var.project
  domain      = var.dns_name

}