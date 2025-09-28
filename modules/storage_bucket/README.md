# Storage Bucket Module

> Creates one or more Google Cloud Storage (GCS) buckets with optional versioning, uniform bucket-level access, and lifecycle rules.

## Inputs

| Name    | Type   | Required | Description |
|---------|--------|----------|-------------|
| project | string | yes      | The GCP project ID |
| region  | string | no       | Default location for buckets (default: `US`) |
| buckets | list   | yes      | List of bucket configurations (name, location, force_destroy, versioning, lifecycle rules, etc.) |

## Outputs

| Name              | Description |
|-------------------|-------------|
| bucket_names      | List of created bucket names |
| bucket_urls       | List of bucket URLs |
| bucket_self_links | List of bucket self-links |

## Example usage

```hcl
module "storage_bucket" {
  source  = "../storage_bucket"
  project = var.project
  region  = "US"

  buckets = [
    {
      name                        = "my-app-logs"
      location                    = "US"
      force_destroy               = true
      uniform_bucket_level_access = true
      versioning                  = true
      lifecycle_rules = [
        {
          action        = "SetStorageClass"
          storage_class = "NEARLINE"
          age           = 30
        },
        {
          action = "Delete"
          age    = 365
        }
      ]
    },
    {
      name                        = "my-static-assets"
      location                    = "EU"
      force_destroy               = false
      uniform_bucket_level_access = true
      versioning                  = false
    }
  ]
}
