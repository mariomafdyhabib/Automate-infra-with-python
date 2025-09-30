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
  zone    = var.zone
  # credentials = file(var.credentials_file)
}

# Compute VM instances
resource "google_compute_instance" "instances" {
  for_each = { for idx, inst in var.instances : idx => inst }

  name         = each.value.name
  machine_type = each.value.machine_type
  zone         = coalesce(each.value.zone, var.zone)

  boot_disk {
    initialize_params {
      image = each.value.image
      size  = each.value.disk_size_gb
      type  = each.value.disk_type
    }
    auto_delete = true
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {
      // Ephemeral public IP if enabled
      nat_ip = each.value.enable_public_ip ? null : null
    }
  }

  metadata = merge(var.default_metadata, each.value.metadata)

  service_account {
    email  = var.service_account
    scopes = ["cloud-platform"]
  }

  tags = concat(var.default_tags, each.value.tags)
}
