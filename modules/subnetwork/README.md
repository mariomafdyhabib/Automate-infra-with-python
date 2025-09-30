# Subnetwork Module

> Creates multiple subnetworks inside an existing VPC.

## Inputs

| Name       | Type   | Required | Description                                      |
|------------|--------|----------|--------------------------------------------------|
| project    | string | yes      | The GCP project ID                               |
| region     | string | no       | Default region for subnets                       |
| network_id | string | yes      | The ID of the existing VPC network               |
| subnets    | list   | no       | List of subnet objects (name, cidr, region)      |

## Outputs

| Name         | Description                   |
|--------------|-------------------------------|
| subnet_ids   | IDs of all created subnets    |
| subnet_names | Names of all created subnets  |

## Example usage

```hcl
module "subnetwork" {
  source     = "../subnetwork"
  project    = var.project
  region     = "us-central1"
  network_id = module.network.network_id

  subnets = [
    {
      name   = "frontend-subnet"
      cidr   = "10.20.1.0/24"
      region = "us-central1"
    },
    {
      name   = "backend-subnet"
      cidr   = "10.20.2.0/24"
      region = "us-east1"
    }
  ]
}