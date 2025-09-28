variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "Region for the GKE cluster"
  default     = "us-central1"
}

variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
}

variable "network" {
  type        = string
  description = "VPC network name"
}

variable "subnetwork" {
  type        = string
  description = "Subnetwork name"
}

variable "remove_default_node_pool" {
  type        = bool
  description = "If true, removes the default node pool"
  default     = true
}

variable "initial_node_count" {
  type        = number
  description = "Initial node count (used only if default pool is not removed)"
  default     = 1
}

variable "release_channel" {
  type        = string
  description = "GKE release channel (RAPID, REGULAR, STABLE)"
  default     = "REGULAR"
}

variable "cluster_secondary_range_name" {
  type        = string
  description = "Secondary range name for Pods"
  default     = null
}

variable "services_secondary_range_name" {
  type        = string
  description = "Secondary range name for Services"
  default     = null
}

variable "enable_shielded_nodes" {
  type        = bool
  description = "Enable Shielded Nodes"
  default     = true
}

# Node Pool vars
variable "node_count" {
  type        = number
  description = "Number of nodes in the default node pool"
  default     = 2
}

variable "machine_type" {
  type        = string
  description = "Machine type for nodes"
  default     = "e2-medium"
}

variable "disk_size_gb" {
  type        = number
  description = "Disk size for nodes"
  default     = 20
}

variable "disk_type" {
  type        = string
  description = "Disk type (pd-standard, pd-balanced, pd-ssd)"
  default     = "pd-balanced"
}

variable "node_metadata" {
  type        = map(string)
  description = "Metadata for nodes"
  default     = {}
}

variable "node_labels" {
  type        = map(string)
  description = "Labels for nodes"
  default     = {}
}

variable "node_tags" {
  type        = list(string)
  description = "Tags for nodes"
  default     = []
}
variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default = "gcp-terraform-key.json"
}