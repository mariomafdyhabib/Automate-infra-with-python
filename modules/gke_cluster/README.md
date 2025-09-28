# GKE Cluster Module

> Deploys a Google Kubernetes Engine (GKE) cluster with optional default node pool.

## Inputs

| Name         | Type   | Required | Description |
|--------------|--------|----------|-------------|
| project      | string | yes      | GCP project ID |
| region       | string | no       | Region for the cluster (default: us-central1) |
| cluster_name | string | yes      | Name of the GKE cluster |
| network      | string | yes      | VPC network name |
| subnetwork   | string | yes      | Subnetwork name |
| release_channel | string | no    | GKE release channel (RAPID, REGULAR, STABLE) |
| node_count   | number | no       | Number of nodes in default pool |
| machine_type | string | no       | Machine type for nodes |
| disk_size_gb | number | no       | Node disk size |
| disk_type    | string | no       | Disk type (pd-standard, pd-balanced, pd-ssd) |

## Outputs

| Name          | Description |
|---------------|-------------|
| cluster_name  | Cluster name |
| endpoint      | Master endpoint |
| master_version | Kubernetes master version |
| node_pools    | List of node pool names |

## Example Usage

```hcl
module "gke_cluster" {
  source       = "../gke_cluster"
  project      = var.project
  region       = "us-central1"
  cluster_name = "my-gke-cluster"
  network      = module.network.network_id
  subnetwork   = module.subnetwork.subnet_names[0]

  node_count   = 3
  machine_type = "e2-medium"
  disk_size_gb = 30
  disk_type    = "pd-balanced"
}
