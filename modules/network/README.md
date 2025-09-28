# Network Module

> Creates a custom VPC network and a subnet in GCP.

## Inputs

| Name          | Type   | Required | Description                   |
|---------------|--------|----------|-------------------------------|
| project       | string | yes      | The GCP project ID            |
| region        | string | no       | Region for resources          |
| network_name  | string | no       | The name of the VPC           |
| subnet_name   | string | no       | The name of the subnet        |
| subnet_cidr   | string | no       | The subnet CIDR range         |

## Outputs

| Name       | Description                 |
|------------|-----------------------------|
| network_id | The ID of the VPC network   |
| subnet_id  | The ID of the subnet        |

## Example usage

```hcl
module "network" {
  source       = "../network"
  project      = var.project
  region       = "us-central1"
  network_name = "demo-vpc"
  subnet_name  = "demo-subnet"
  subnet_cidr  = "10.1.0.0/24"
}
