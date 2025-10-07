
# Create firewall rules
resource "google_compute_firewall" "rules" {
  for_each = { for rule in var.firewall_rules : rule.name => rule }

  name    = each.value.name
  network = var.network_id
  priority = lookup(each.value, "priority", 1000)
  direction = each.value.direction

  allow {
    protocol = each.value.protocol
    ports    = lookup(each.value, "ports", null)
  }

  source_ranges           = lookup(each.value, "source_ranges", null)
  source_tags             = lookup(each.value, "source_tags", null)
  target_tags             = lookup(each.value, "target_tags", null)
  destination_ranges      = lookup(each.value, "destination_ranges", null)
  disabled                = lookup(each.value, "disabled", false)
  enable_logging          = lookup(each.value, "enable_logging", false)
}
