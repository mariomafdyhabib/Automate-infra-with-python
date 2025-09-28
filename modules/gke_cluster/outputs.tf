output "cluster_name" {
  description = "Name of the GKE cluster"
  value       = google_container_cluster.primary.name
}

output "endpoint" {
  description = "Endpoint for accessing the Kubernetes master"
  value       = google_container_cluster.primary.endpoint
}

output "master_version" {
  description = "Master version of the GKE cluster"
  value       = google_container_cluster.primary.min_master_version
}

output "node_pools" {
  description = "Node pool names"
  value       = [for np in google_container_node_pool.default_nodes : np.name]
}
