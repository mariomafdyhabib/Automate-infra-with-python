# Network Outputs
output "network_name" {
  description = "Name of the created network"
  value       = module.network.network_name
}

output "network_id" {
  description = "ID of the created network"
  value       = module.network.network_id
}

# Subnetwork Outputs
output "subnet_names" {
  description = "Names of created subnets"
  value       = module.subnetwork.subnet_names
}

output "subnet_regions" {
  description = "Regions of created subnets"
  value       = module.subnetwork.subnet_regions
}

# Storage Bucket Outputs
output "storage_bucket_name" {
  description = "GCS bucket name"
  value       = module.storage_bucket.bucket_name
}

output "storage_bucket_url" {
  description = "GCS bucket URL"
  value       = module.storage_bucket.bucket_url
}

# Firewall Outputs
output "firewall_rule_names" {
  description = "Names of created firewall rules"
  value       = module.firewall.rule_names
}

# Cloud SQL Outputs
output "cloud_sql_instance_name" {
  description = "Cloud SQL instance name"
  value       = module.cloud_sql.instance_name
}

output "cloud_sql_connection_name" {
  description = "Cloud SQL connection name"
  value       = module.cloud_sql.connection_name
}

# Compute Instance Outputs
output "compute_instance_name" {
  description = "Compute instance name"
  value       = module.compute_instance.instance_name
}

output "compute_instance_ip" {
  description = "Compute instance external IP"
  value       = module.compute_instance.external_ip
}

# GKE Cluster Outputs
output "gke_cluster_name" {
  description = "GKE cluster name"
  value       = module.gke_cluster.cluster_name
}

output "gke_cluster_endpoint" {
  description = "GKE cluster endpoint"
  value       = module.gke_cluster.cluster_endpoint
  sensitive   = true
}

# Pub/Sub Outputs
output "pubsub_topics" {
  description = "Created Pub/Sub topics"
  value       = module.pub_sub.topics
}

# Load Balancer Outputs
output "load_balancer_ip" {
  description = "Load balancer IP address"
  value       = module.load_balancer.lb_ip
}

# IAM Outputs
output "iam_bindings" {
  description = "IAM bindings created"
  value       = module.iam.bindings
}

# Cloud Run Outputs
output "cloud_run_service_url" {
  description = "Cloud Run service URL"
  value       = module.cloud_run.service_url
}

# CDN & DNS Outputs
output "dns_zone_names" {
  description = "Created DNS zone names"
  value       = module.cdn_dns.zone_names
}

# Project Outputs
output "project_id" {
  description = "Project ID"
  value       = var.project_id
}

output "region" {
  description = "Region used for deployment"
  value       = var.region
}

# General Information
output "all_apis_enabled" {
  description = "List of all enabled APIs"
  value       = [for api in google_project_service.apis : api.service]
}

output "infrastructure_summary" {
  description = "Summary of all deployed infrastructure"
  value = {
    network    = module.network.network_name
    subnets    = module.subnetwork.subnet_names
    gke        = module.gke_cluster.cluster_name
    cloud_sql  = module.cloud_sql.instance_name
    compute    = module.compute_instance.instance_name
    storage    = module.storage_bucket.bucket_name
    cloud_run  = module.cloud_run.service_name
  }
}