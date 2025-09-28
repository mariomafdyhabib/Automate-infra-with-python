# CDN and DNS Module

> Sets up Cloud CDN with HTTPS Load Balancer and Cloud DNS for a custom domain.

## Inputs

| Name        | Type   | Description |
|-------------|--------|-------------|
| project     | string | GCP project ID |
| name        | string | Base name for resources |
| bucket_name | string | GCS bucket serving content |
| domain      | string | Domain name (e.g. example.com) |

## Outputs

| Name          | Description |
|---------------|-------------|
| cdn_ip        | Global IP of the CDN-enabled load balancer |
| dns_zone_name | Name of Cloud DNS managed zone |

## Example

```hcl
module "cdn_and_dns" {
  source      = "../cdn_and_dns"
  project     = var.project
  name        = "myapp"
  bucket_name = "myapp-static-bucket"
  domain      = "example.com"
}
