variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "service_accounts" {
  description = "List of service accounts to create"
  type = list(object({
    account_id   = string
    display_name = string
    description  = string
  }))

  default = []
}

variable "custom_roles" {
  description = "List of custom IAM roles"
  type = list(object({
    role_id     = string
    title       = string
    description = string
    permissions = list(string)
  }))

  default = []
}

variable "bindings" {
  description = "List of IAM bindings"
  type = list(object({
    role    = string
    members = list(string)
  }))

  default = []
}
variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default = "gcp-terraform-key.json"
}
