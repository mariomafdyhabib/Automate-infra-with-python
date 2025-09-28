# Load Balancer Module

> Creates a Global HTTPS Load Balancer with backend service, SSL certs, and forwarding rule.

## Inputs

| Name              | Type   | Description |
|-------------------|--------|-------------|
| project           | string | GCP project ID |
| region            | string | Backend region |
| name              | string | Base resource name |
| domains           | list   | Domains for managed SSL |
| use_managed_ssl   | bool   | Use Google-managed SSL (default: true) |
| certificate_path  | string | Path to self-managed cert (if not managed) |
| private_key_path  | string | Path to self-managed key (if not managed) |
| backend_group     | string | Instance group or NEG self-link for backend |
| ip_address        | string | Static global IP address |

## Outputs

| Name              | Description |
|-------------------|-------------|
| forwarding_rule_ip | IP of load balancer |
| backend_service   | Backend service ID |
| url_map           | URL map ID |

## Example

```hcl
module "loadbalancer" {
  source  = "../loadbalancer"
  project = var.project
  name    = "myapp-lb"
  backend_group = google_compute_instance_group.app_instances.self_link
  ip_address    = google_compute_global_address.lb_ip.address

  domains         = ["example.com"]
  use_managed_ssl = true
}
