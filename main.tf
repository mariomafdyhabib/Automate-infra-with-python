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

  # backend "gcs" {
  #   bucket = "tf-state-${var.project_id}"
  #   prefix = "terraform/state"
  # }
}   

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
  credentials = file(var.credentials_file)
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Enable required APIs
resource "google_project_service" "apis" {
  for_each = toset(var.required_apis)
  project  = var.project_id
  service  = each.key

  disable_dependent_services = true
  disable_on_destroy         = false
}

# Network Module
module "network" {
  source = "./modules/network"

  project            = var.project_id
  network_name       = var.network_name

}

# Declare subnets variable
module "subnetwork" {
  source = "./modules/subnetwork"

  project         = var.project_id
  region          = var.region
  network_id      = module.network.network_id
  subnets         = module.subnetwork.var.subnets
  credentials_file = var.credentials_file

}



# Storage Bucket Module
module "storage_bucket" {
  source = "./modules/storage_bucket"

  project = var.project_id
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

  project        = var.project_id
  network_id     = module.network.network_id
  firewall_rules = module.firewall.var.firewall_rules

}

# Cloud SQL Module
module "cloud_sql" {
  source = "./modules/cloud_sql"

  project           = var.project_id
  region            = var.region
  instance_name     = var.cloud_sql_instance_name
  database_version  = var.database_version
  tier              = var.db_tier
  disk_size         = var.db_disk_size
  db_name           = module.cloud_sql.db_name
  db_user           = module.cloud_sql.db_user
  db_password       = module.cloud_sql.db_password
  

}

# Compute Instance Module
module "compute_instance" {
  source = "./modules/compute_instance"

  project      = var.project_id
  zone         = var.zone
  network      = module.network.network_name
  subnetwork   = module.subnetwork.subnet_names[0]
  # instance_name = var.instance_name
  # machine_type  = var.machine_type
  # image         = var.image  
}

# GKE Cluster Module
module "gke_cluster" {
  source = "./modules/gke_cluster"

  project      = var.project_id
  region       = var.region
  cluster_name = var.cluster_name
  network      = module.network.network_name
  subnetwork   = module.subnetwork.subnet_names[0]

}

# Pub/Sub Module
module "pub_sub" {
  source = "./modules/pubsub"

  project = var.project_id
  topics  = [for topic in var.pubsub_topics : topic.name]

}

# Load Balancer Module
module "load_balancer" {
  source = "./modules/load_balancer"

  project        = var.project_id
  region         = var.region
  name           = var.lb_name
  ip_address     = var.lb_ip_address
  backend_group  = var.lb_backend_group

}

# IAM Module
module "iam" {
  source = "./modules/iam"

  project = var.project_id

}

# Cloud Run Module
module "cloud_run" {
  source = "./modules/cloud_run"

  project = var.project_id
  region  = var.region
  name    = var.cloud_run_service_name
  image   = var.cloud_run_image

}

# CDN & DNS Module
module "cdn_and_dns" {
  source      = "./modules/cdn_and_dns"
  name        = var.name
  bucket_name = var.bucket_name
  project     = var.project_id
  domain      = var.domain

}