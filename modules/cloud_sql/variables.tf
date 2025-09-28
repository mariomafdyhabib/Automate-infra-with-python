variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "Region for the Cloud SQL instance"
  default     = "us-central1"
}

variable "instance_name" {
  type        = string
  description = "Name of the Cloud SQL instance"
}

variable "database_version" {
  type        = string
  description = "Database engine and version (e.g. POSTGRES_14, MYSQL_8_0)"
}

variable "tier" {
  type        = string
  description = "Machine type for the database (e.g. db-f1-micro, db-custom-1-3840)"
}

variable "availability_type" {
  type        = string
  description = "REGIONAL for HA, ZONAL for single zone"
  default     = "ZONAL"
}

variable "enable_public_ip" {
  type        = bool
  description = "Enable public IP for the SQL instance"
  default     = false
}

variable "private_network" {
  type        = string
  description = "The VPC network to connect privately (optional)"
  default     = null
}

variable "require_ssl" {
  type        = bool
  description = "Require SSL connections"
  default     = true
}

variable "authorized_networks" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "List of authorized networks for public IP connections"
  default     = []
}

variable "backup_enabled" {
  type        = bool
  description = "Enable automated backups"
  default     = true
}

variable "binary_log_enabled" {
  type        = bool
  description = "Enable binary logging (for replication/point-in-time recovery)"
  default     = false
}

variable "point_in_time_recovery_enabled" {
  type        = bool
  description = "Enable point in time recovery"
  default     = false
}

variable "disk_size" {
  type        = number
  description = "Disk size in GB"
  default     = 10
}

variable "disk_type" {
  type        = string
  description = "PD_SSD or PD_HDD"
  default     = "PD_SSD"
}

variable "disk_autoresize" {
  type        = bool
  description = "Enable automatic disk resizing"
  default     = true
}

variable "db_name" {
  type        = string
  description = "Name of the database to create inside the instance"
}

variable "db_user" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  description = "Database password"
  sensitive   = true
}
variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default = "gcp-terraform-key.json"
}