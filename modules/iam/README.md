# IAM Module

> Manage GCP IAM resources: service accounts, custom roles, and bindings.

## Inputs

| Name             | Type   | Description |
|------------------|--------|-------------|
| project          | string | GCP project ID |
| service_accounts | list   | List of service accounts (account_id, display_name, description) |
| custom_roles     | list   | List of custom roles (role_id, title, description, permissions) |
| bindings         | list   | IAM bindings (role → members) |

## Outputs

| Name                  | Description |
|-----------------------|-------------|
| service_accounts_emails | Emails of created service accounts |
| custom_roles_ids        | IDs of created custom roles |

## Example

```hcl
module "iam" {
  source  = "../iam"
  project = var.project

  service_accounts = [
    {
      account_id   = "ci-cd-sa"
      display_name = "CI/CD Service Account"
      description  = "Used for CI/CD pipeline"
    }
  ]

  custom_roles = [
    {
      role_id     = "customDeployer"
      title       = "Custom Deployer"
      description = "Custom role for deployment tasks"
      permissions = [
        "compute.instances.start",
        "compute.instances.stop"
      ]
    }
  ]

  bindings = [
    {
      role    = "roles/viewer"
      members = ["user:dev@example.com"]
    },
    {
      role    = "projects/${var.project}/roles/customDeployer"
      members = ["serviceAccount:ci-cd-sa@${var.project}.iam.gserviceaccount.com"]
    }
  ]
}
