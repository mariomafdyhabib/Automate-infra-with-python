output "instance_connection_name" {
  description = "Connection name of the Cloud SQL instance"
  value       = google_sql_database_instance.default.connection_name
}

# output "public_ip_address" {
#   description = "Public IP address of the Cloud SQL instance"
#   value       = try(google_sql_database_instance.default.public_ip_address[0], null)
# }

output "private_ip_address" {
  description = "Private IP address of the Cloud SQL instance"
  value       = try(google_sql_database_instance.default.private_ip_address, null)
}

output "db_name" {
  description = "Database name"
  value       = google_sql_database.default.name
}

output "db_user" {
  description = "Database user name"
  value       = google_sql_user.default.name
}
