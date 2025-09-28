# Cloud SQL Module

> Deploys a Cloud SQL instance, database, and user in GCP.

## Inputs

| Name        | Type   | Required | Description |
|-------------|--------|----------|-------------|
| project     | string | yes      | GCP project ID |
| region      | string | no       | Region for Cloud SQL instance (default: us-central1) |
| instance_name | string | yes    | Cloud SQL instance name |
| database_version | string | yes | Engine & version (e.g., POSTGRES_14, MYSQL_8_0) |
| tier        | string | yes      | Machine type (e.g., db-f1-micro) |
| availability_type | string | no | ZONAL (default) or REGIONAL |
| db_name     | string | yes      | Database name |
| db_user     | string | yes      | Database username |
| db_password | string | yes      | Database password |

## Outputs

| Name                   | Description |
|------------------------|-------------|
| instance_connection_name | Connection name used for clients |
| public_ip_address      | Public IP address (if enabled) |
| private_ip_address     | Private IP address (if VPC connected) |
| db_name                | Database name |
| db_user                | Database user |

## Example Usage

```hcl
module "cloudsql" {
  source          = "../cloudsql"
  project         = var.project
  region          = "us-central1"
  instance_name   = "my-postgres-db"
  database_version = "POSTGRES_14"
  tier            = "db-f1-micro"

  availability_type = "ZONAL"
  enable_public_ip  = true

  db_name      = "appdb"
  db_user      = "appuser"
  db_password  = "supersecretpassword"

  authorized_networks = [
    { name = "office", value = "203.0.113.5/32" }
  ]
}
