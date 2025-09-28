output "cdn_ip" {
  description = "Global IP address of the CDN-enabled load balancer"
  value       = google_compute_global_address.default.address
}

output "dns_zone_name" {
  description = "Name of the managed DNS zone"
  value       = google_dns_managed_zone.default.name
}
