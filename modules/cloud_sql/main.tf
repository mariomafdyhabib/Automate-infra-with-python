terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  credentials = file(var.credentials_file)
}

# Cloud SQL Instance
resource "google_sql_database_instance" "default" {
  name             = var.instance_name
  database_version = var.database_version
  region           = var.region

  settings {
    tier              = var.tier
    availability_type = var.availability_type

    ip_configuration {
      ipv4_enabled    = var.enable_public_ip
      private_network = var.private_network
      require_ssl     = var.require_ssl

      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.value
        }
      }
    }

    backup_configuration {
      enabled                        = var.backup_enabled
      binary_log_enabled             = var.binary_log_enabled
      point_in_time_recovery_enabled = var.point_in_time_recovery_enabled
    }

    disk_size   = var.disk_size
    disk_type   = var.disk_type
    disk_autoresize = var.disk_autoresize
  }
}

# Database inside the instance
resource "google_sql_database" "default" {
  name     = var.db_name
  instance = google_sql_database_instance.default.name
}

# Database user
resource "google_sql_user" "default" {
  name     = var.db_user
  password = var.db_password
  instance = google_sql_database_instance.default.name
}
