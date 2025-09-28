output "service_accounts_emails" {
  description = "Emails of created service accounts"
  value       = [for sa in google_service_account.service_accounts : sa.email]
}

output "custom_roles_ids" {
  description = "IDs of created custom roles"
  value       = [for cr in google_project_iam_custom_role.custom_roles : cr.name]
}
