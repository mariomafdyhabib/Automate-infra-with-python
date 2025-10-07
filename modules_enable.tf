############################################
# Enable Flags for Each Terraform Module
############################################

variable "enable_network" {
  description = "Enable the VPC Network module"
  type        = bool
  default     = false
}

variable "enable_subnetwork" {
  description = "Enable the Subnetwork module"
  type        = bool
  default     = false
}

variable "enable_firewall" {
  description = "Enable the Firewall module"
  type        = bool
  default     = false
}

variable "enable_compute_instance" {
  description = "Enable the Compute Instance module"
  type        = bool
  default     = false
}

variable "enable_storage_bucket" {
  description = "Enable the Storage Bucket module"
  type        = bool
  default     = false
}

variable "enable_cloud_sql" {
  description = "Enable the Cloud SQL module"
  type        = bool
  default     = false
}

variable "enable_gke" {
  description = "Enable the GKE Cluster module"
  type        = bool
  default     = false
}

variable "enable_pubsub" {
  description = "Enable the Pub/Sub module"
  type        = bool
  default     = false
}

variable "enable_load_balancer" {
  description = "Enable the Load Balancer module"
  type        = bool
  default     = false
}

variable "enable_iam" {
  description = "Enable the IAM module"
  type        = bool
  default     = false
}

variable "enable_cloud_run" {
  description = "Enable the Cloud Run module"
  type        = bool
  default     = false
}

variable "enable_cdn_dns" {
  description = "Enable the CDN and DNS module"
  type        = bool
  default     = false
}

############################################
# Conditional Module Calls
############################################

# module "network" {
#   source = "./modules/network"
#   count  = var.enable_network ? 1 : 0

#   project_id          = var.project_id
#   region              = var.region
#   network_name        = var.network_name
#   auto_create_subnets = var.auto_create_subnets
# }

# module "subnetwork" {
#   source = "./modules/subnetwork"
#   count  = var.enable_subnetwork ? 1 : 0

#   project_id = var.project_id
#   region     = var.region
#   subnets    = var.subnets
# }

# module "firewall" {
#   source = "./modules/firewall"
#   count  = var.enable_firewall ? 1 : 0

#   project_id     = var.project_id
#   firewall_rules = var.firewall_rules
# }

# module "compute_instance" {
#   source = "./modules/compute_instance"
#   count  = var.enable_compute_instance ? 1 : 0

#   project_id    = var.project_id
#   region        = var.region
#   zone          = var.zone
#   instance_name = var.instance_name
#   machine_type  = var.machine_type
#   image         = var.image
# }

# module "storage_bucket" {
#   source = "./modules/storage_bucket"
#   count  = var.enable_storage_bucket ? 1 : 0

#   project_id     = var.project_id
#   bucket_name    = var.bucket_name
#   storage_class  = var.storage_class
# }

# module "cloud_sql" {
#   source = "./modules/cloud_sql"
#   count  = var.enable_cloud_sql ? 1 : 0

#   project_id             = var.project_id
#   region                 = var.region
#   cloud_sql_instance_name = var.cloud_sql_instance_name
#   database_version       = var.database_version
#   db_tier                = var.db_tier
#   db_disk_size           = var.db_disk_size
# }

# module "gke" {
#   source = "./modules/gke"
#   count  = var.enable_gke ? 1 : 0

#   project_id   = var.project_id
#   region       = var.region
#   cluster_name = var.cluster_name
# }

# module "pubsub" {
#   source = "./modules/pubsub"
#   count  = var.enable_pubsub ? 1 : 0

#   project_id = var.project_id
#   topics     = var.pubsub_topics
# }

# module "load_balancer" {
#   source = "./modules/load_balancer"
#   count  = var.enable_load_balancer ? 1 : 0

#   project_id        = var.project_id
#   region            = var.region
#   lb_name           = var.lb_name
#   lb_backend_config = var.lb_backend_config
#   lb_ip_address     = var.lb_ip_address
#   lb_backend_group  = var.lb_backend_group
# }

# module "iam" {
#   source = "./modules/iam"
#   count  = var.enable_iam ? 1 : 0

#   project_id   = var.project_id
#   iam_roles    = var.iam_roles
#   iam_members  = var.iam_members
# }

# module "cloud_run" {
#   source = "./modules/cloud_run"
#   count  = var.enable_cloud_run ? 1 : 0

#   project_id           = var.project_id
#   region               = var.region
#   cloud_run_service_name = var.cloud_run_service_name
#   cloud_run_image      = var.cloud_run_image
# }

# module "cdn_dns" {
#   source = "./modules/cdn_dns"
#   count  = var.enable_cdn_dns ? 1 : 0

#   project_id  = var.project_id
#   domain      = var.domain
#   dns_zones   = var.dns_zones
#   name        = var.name
# }
