variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "Region for resources"
  default     = "us-central1"
}

variable "network_id" {
  type        = string
  description = "The ID of the VPC network where rules will be applied"
}

variable "firewall_rules" {
  description = <<EOT
List of firewall rules.
Each object supports:
- name
- direction (INGRESS or EGRESS)
- priority (default: 1000)
- protocol (e.g., tcp, udp, icmp, all)
- ports (list, optional)
- source_ranges (list of CIDRs, optional)
- destination_ranges (list of CIDRs, optional)
- source_tags (list, optional)
- target_tags (list, optional)
- disabled (bool, default: false)
- enable_logging (bool, default: false)
EOT

  type = list(object({
    name              = string
    direction         = string
    priority          = optional(number, 1000)
    protocol          = string
    ports             = optional(list(string))
    source_ranges     = optional(list(string))
    destination_ranges = optional(list(string))
    source_tags       = optional(list(string))
    target_tags       = optional(list(string))
    disabled          = optional(bool, false)
    enable_logging    = optional(bool, false)
  }))
}
variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default = "gcp-terraform-key.json"
}