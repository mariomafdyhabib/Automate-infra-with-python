output "network_id" {
  value       = google_compute_network.vpc_network.id
  description = "ID of the created VPC network"
}

output "subnet_id" {
  value       = google_compute_subnetwork.subnet.id
  description = "ID of the created subnet"
}
