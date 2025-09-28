output "instance_names" {
  description = "Names of created instances"
  value       = [for i in google_compute_instance.instances : i.name]
}

output "instance_self_links" {
  description = "Self links of created instances"
  value       = [for i in google_compute_instance.instances : i.self_link]
}

output "instance_external_ips" {
  description = "External IP addresses of instances"
  value       = [for i in google_compute_instance.instances : try(i.network_interface[0].access_config[0].nat_ip, null)]
}

output "instance_internal_ips" {
  description = "Internal IP addresses of instances"
  value       = [for i in google_compute_instance.instances : i.network_interface[0].network_ip]
}
