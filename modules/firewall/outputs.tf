output "firewall_rule_names" {
  value       = [for f in google_compute_firewall.rules : f.name]
  description = "Names of created firewall rules"
}

output "firewall_rule_self_links" {
  value       = [for f in google_compute_firewall.rules : f.self_link]
  description = "Self-links of created firewall rules"
}
