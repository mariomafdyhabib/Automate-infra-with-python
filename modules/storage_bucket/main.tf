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
  region  = var.region
  credentials = file(var.credentials_file)
}

# Create multiple storage buckets
resource "google_storage_bucket" "buckets" {
  for_each = { for bucket in var.buckets : bucket.name => bucket }

  name                        = each.value.name
  location                    = each.value.location != "" ? each.value.location : var.region
  force_destroy               = each.value.force_destroy
  uniform_bucket_level_access = each.value.uniform_bucket_level_access

  versioning {
    enabled = each.value.versioning
  }

  dynamic "lifecycle_rule" {
    for_each = lookup(each.value, "lifecycle_rules", [])
    content {
      action {
        type          = lifecycle_rule.value.action
        storage_class = lookup(lifecycle_rule.value, "storage_class", null)
      }
      condition {
        age                   = lookup(lifecycle_rule.value, "age", null)
        created_before        = lookup(lifecycle_rule.value, "created_before", null)
        with_state            = lookup(lifecycle_rule.value, "with_state", null)
        matches_storage_class = lookup(lifecycle_rule.value, "matches_storage_class", null)
      }
    }
  }
}
# Grant Storage Admin role to the service account
resource "google_storage_bucket_iam_member" "bucket_admin" {
  for_each = google_storage_bucket.buckets

  bucket = each.value.name
  role   = "roles/storage.admin"
  member = "serviceAccount:cli-service-account-1@playground-s-11-a8d0d4ad.iam.gserviceaccount.com"
}