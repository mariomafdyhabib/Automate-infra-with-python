# Firewall Module

> Creates firewall rules for a VPC network in GCP.

## Inputs

| Name           | Type   | Required | Description |
|----------------|--------|----------|-------------|
| project        | string | yes      | The GCP project ID |
| region         | string | no       | Region for resources (default: us-central1) |
| network_id     | string | yes      | The ID of the VPC network |
| firewall_rules | list   | yes      | List of firewall rule objects |

## Outputs

| Name                    | Description |
|-------------------------|-------------|
| firewall_rule_names     | List of created firewall rule names |
| firewall_rule_self_links| Self-links of created firewall rules |

## Example usage

```hcl
module "firewall" {
  source     = "../firewall"
  project    = var.project
  region     = "us-central1"
  network_id = module.network.network_id

  firewall_rules = [
    {
      name          = "allow-ssh"
      direction     = "INGRESS"
      protocol      = "tcp"
      ports         = ["22"]
      source_ranges = ["0.0.0.0/0"]
      priority      = 1000
    },
    {
      name              = "allow-internal"
      direction         = "INGRESS"
      protocol          = "all"
      source_ranges     = ["10.0.0.0/16"]
      priority          = 1001
    }
  ]
}
