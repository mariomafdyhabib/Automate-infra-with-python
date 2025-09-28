# Compute Instance Module

> Deploys one or more VM instances in GCP.

## Inputs

| Name           | Type   | Required | Description |
|----------------|--------|----------|-------------|
| project        | string | yes      | GCP project ID |
| region         | string | no       | Region (default: us-central1) |
| zone           | string | no       | Zone (default: us-central1-a) |
| network        | string | no       | VPC network (default: default) |
| subnetwork     | string | no       | Subnetwork (optional) |
| service_account | string | no      | Service account for the VMs |
| default_metadata | map  | no       | Metadata applied to all instances |
| default_tags   | list   | no       | Tags applied to all instances |
| instances      | list   | yes      | List of VM instance objects (see below) |

### Instance object fields
- `name` – Instance name  
- `machine_type` – Machine type (e.g., e2-micro, n1-standard-1)  
- `zone` – Zone for the VM  
- `image` – Boot disk image (e.g., debian-cloud/debian-11)  
- `disk_size_gb` – Disk size in GB  
- `disk_type` – Disk type (pd-standard, pd-balanced, pd-ssd)  
- `enable_public_ip` – Boolean for external IP  
- `tags` – List of tags  
- `metadata` – Map of metadata key-values  

## Outputs

| Name                | Description |
|---------------------|-------------|
| instance_names      | Names of instances |
| instance_self_links | Self links of instances |
| instance_external_ips | External IPs (if any) |
| instance_internal_ips | Internal IPs |

## Example Usage

```hcl
module "compute_instance" {
  source  = "../compute_instance"
  project = var.project
  region  = "us-central1"
  zone    = "us-central1-a"

  instances = [
    {
      name            = "frontend-vm"
      machine_type    = "e2-micro"
      zone            = "us-central1-a"
      image           = "debian-cloud/debian-11"
      disk_size_gb    = 10
      disk_type       = "pd-balanced"
      enable_public_ip = true
      tags            = ["frontend"]
      metadata        = { ssh-keys = "user:ssh-rsa AAAAB3..." }
    },
    {
      name            = "backend-vm"
      machine_type    = "e2-small"
      zone            = "us-central1-b"
      image           = "debian-cloud/debian-11"
      disk_size_gb    = 20
      disk_type       = "pd-ssd"
      enable_public_ip = false
      tags            = ["backend"]
      metadata        = {}
    }
  ]
}
