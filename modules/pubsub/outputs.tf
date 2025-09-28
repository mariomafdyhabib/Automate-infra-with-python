output "topic_names" {
  description = "List of Pub/Sub topic names"
  value       = [for t in google_pubsub_topic.topics : t.name]
}

output "subscription_names" {
  description = "List of Pub/Sub subscription names"
  value       = [for s in google_pubsub_subscription.subscriptions : s.name]
}
