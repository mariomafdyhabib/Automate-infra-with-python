output "subnet_ids" {
  value       = [for s in google_compute_subnetwork.subnets : s.id]
  description = "IDs of all created subnets"
}

output "subnet_names" {
  value       = [for s in google_compute_subnetwork.subnets : s.name]
  description = "Names of all created subnets"
}
