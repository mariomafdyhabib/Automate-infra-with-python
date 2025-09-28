output "bucket_names" {
  value       = [for b in google_storage_bucket.buckets : b.name]
  description = "Names of created buckets"
}

output "bucket_urls" {
  value       = [for b in google_storage_bucket.buckets : b.url]
  description = "URLs of created buckets"
}

output "bucket_self_links" {
  value       = [for b in google_storage_bucket.buckets : b.self_link]
  description = "Self links of created buckets"
}
