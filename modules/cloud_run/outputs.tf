output "service_name" {
  description = "Cloud Run service name"
  value       = google_cloud_run_service.default.name
}

output "service_url" {
  description = "Cloud Run service URL"
  value       = google_cloud_run_service.default.status[0].url
}
