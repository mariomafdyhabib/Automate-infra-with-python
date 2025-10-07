
# ✅ Use data source to fetch existing VPC info dynamically
data "google_compute_network" "existing_vpc" {
  project = var.project
  name    = split("/", var.network_id)[length(split("/", var.network_id)) - 1] # extract name from self_link
}

# Create subnetworks under an existing VPC
resource "google_compute_subnetwork" "subnets" {
  for_each = { for idx, subnet in var.subnets : idx => subnet }

  name          = each.value.name
  ip_cidr_range = each.value.cidr
  region        = each.value.region != "" ? each.value.region : var.region
  network       = var.network_id
}