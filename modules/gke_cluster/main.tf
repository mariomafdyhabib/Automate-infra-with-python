
# GKE Cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  network    = var.network
  subnetwork = var.subnetwork

  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count

  release_channel {
    channel = var.release_channel
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  enable_shielded_nodes = var.enable_shielded_nodes

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

# Node Pool (optional default)
resource "google_container_node_pool" "default_nodes" {
  count    = var.remove_default_node_pool ? 1 : 0
  name     = "${var.cluster_name}-default-pool"
  location = var.region
  cluster  = google_container_cluster.primary.name

  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

    metadata = var.node_metadata
    labels   = var.node_labels
    tags     = var.node_tags
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
