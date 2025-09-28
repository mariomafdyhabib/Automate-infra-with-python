# Cloud Run Module

> Deploys a Cloud Run service with container image, resources, and IAM bindings.

## Inputs

| Name                 | Type   | Description |
|----------------------|--------|-------------|
| project              | string | GCP project ID |
| region               | string | Deployment region |
| name                 | string | Service name |
| image                | string | Container image |
| cpu                  | string | CPU limit (default: 1) |
| memory               | string | Memory limit (default: 512Mi) |
| concurrency          | number | Max concurrent requests per container (default: 80) |
| timeout_seconds      | number | Request timeout (default: 300s) |
| env_vars             | map    | Environment variables |
| allow_unauthenticated | bool  | Public or restricted (default: true) |

## Outputs

| Name         | Description |
|--------------|-------------|
| service_name | Cloud Run service name |
| service_url  | Cloud Run service URL |

## Example

```hcl
module "cloudrun" {
  source  = "../cloudrun"
  project = var.project
  region  = "us-central1"
  name    = "myapp"
  image   = "gcr.io/my-gcp-project/myapp:latest"

  cpu       = "2"
  memory    = "1Gi"
  concurrency = 50
  timeout_seconds = 600

  env_vars = {
    ENV = "production"
    DB  = "postgres://user:pass@host:5432/db"
  }

  allow_unauthenticated = true
}
