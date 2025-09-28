output "forwarding_rule_ip" {
  description = "The IP address of the forwarding rule"
  value       = var.ip_address
}

output "backend_service" {
  description = "Backend service ID"
  value       = google_compute_backend_service.default.id
}

output "url_map" {
  description = "URL Map ID"
  value       = google_compute_url_map.default.id
}
