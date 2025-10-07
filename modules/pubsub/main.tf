
# Create Pub/Sub Topics
resource "google_pubsub_topic" "topics" {
  for_each = { for idx, t in var.topics : idx => t }

  name                       = each.value.name
  message_retention_duration = each.value.message_retention_duration
  labels                     = each.value.labels
}

# Dead Letter Topics (optional)
# resource "google_pubsub_topic" "dead_letter_topics" {
#   for_each = { for idx, t in var.dead_letter_topics : idx => t }

#   name   = t.value.name
#   labels = t.value.labels
# }

# Subscriptions
resource "google_pubsub_subscription" "subscriptions" {
  for_each = { for idx, s in var.subscriptions : idx => s }

  name  = each.value.name
  topic = google_pubsub_topic.topics[each.value.topic_index].name

  ack_deadline_seconds = each.value.ack_deadline_seconds
  retain_acked_messages = each.value.retain_acked_messages

  expiration_policy {
    ttl = each.value.expiration_ttl
  }

  retry_policy {
    minimum_backoff = each.value.min_backoff
    maximum_backoff = each.value.max_backoff
  }

  dynamic "dead_letter_policy" {
    for_each = each.value.dead_letter_topic != null ? [1] : []
    content {
      dead_letter_topic     = google_pubsub_topic.dead_letter_topics[each.value.dead_letter_topic].id
      max_delivery_attempts = each.value.max_delivery_attempts
    }
  }

  labels = each.value.labels
}
