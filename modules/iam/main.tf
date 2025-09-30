terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}

provider "google" {
  project = var.project
  credentials = file(var.credentials_file)
}

# Service Accounts
resource "google_service_account" "service_accounts" {
  for_each = { for sa in var.service_accounts : sa.account_id => sa }

  account_id   = each.value.account_id
  display_name = each.value.display_name
  description  = each.value.description
}

# Custom Roles
resource "google_project_iam_custom_role" "custom_roles" {
  for_each = { for role in var.custom_roles : role.role_id => role }

  role_id     = each.value.role_id
  title       = each.value.title
  description = each.value.description
  permissions = each.value.permissions
  stage       = "GA"
}

# IAM Bindings
resource "google_project_iam_binding" "bindings" {
  for_each = { for idx, binding in var.bindings : idx => binding }

  project = var.project
  role    = each.value.role
  members = each.value.members
}
