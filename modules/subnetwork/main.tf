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
  # credentials = file(var.credentials_file)
}

# Create subnetworks under an existing VPC
resource "google_compute_subnetwork" "subnets" {
  for_each = { for idx, subnet in var.subnets : idx => subnet }

  name          = each.value.name
  ip_cidr_range = each.value.cidr
  region        = each.value.region != "" ? each.value.region : var.region
  network       = var.network_id
}