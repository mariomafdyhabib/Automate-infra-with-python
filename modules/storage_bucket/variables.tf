variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "Default region/location for buckets"
  default     = "US"
}

variable "buckets" {
  description = <<EOT
List of buckets to create.
Each object supports:
- name
- location (optional, defaults to var.region)
- force_destroy (bool)
- uniform_bucket_level_access (bool)
- versioning (bool)
- lifecycle_rules (list of objects: action, storage_class?, age?, created_before?, with_state?, matches_storage_class?)
EOT

  type = list(object({
    name                        = string
    location                    = string
    force_destroy               = bool
    uniform_bucket_level_access = bool
    versioning                  = bool
    lifecycle_rules = optional(list(object({
      action              = string
      storage_class       = optional(string)
      age                 = optional(number)
      created_before      = optional(string)
      with_state          = optional(string)
      matches_storage_class = optional(list(string))
    })), [])
  }))
}
variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default = "gcp-terraform-key.json"
}