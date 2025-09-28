# Pub/Sub Module

> Creates Pub/Sub topics, subscriptions, and optional dead-letter topics.

## Inputs

| Name        | Type   | Required | Description |
|-------------|--------|----------|-------------|
| project     | string | yes      | GCP project ID |
| topics      | list   | yes      | List of topic objects (name, retention, labels) |
| subscriptions | list | no       | List of subscriptions with configs |
| dead_letter_topics | list | no | List of dead letter topics |

### Topic object
- `name` – Topic name  
- `message_retention_duration` – Duration messages are retained (e.g. `604800s`)  
- `labels` – Key-value labels  

### Subscription object
- `name` – Subscription name  
- `topic_index` – Index of topic in `topics` list  
- `ack_deadline_seconds` – Ack deadline in seconds  
- `retain_acked_messages` – Boolean to retain acked messages  
- `expiration_ttl` – Subscription expiration (e.g. `2678400s`)  
- `min_backoff` – Retry minimum backoff (e.g. `10s`)  
- `max_backoff` – Retry maximum backoff (e.g. `600s`)  
- `dead_letter_topic` – Index of dead letter topic in list (optional)  
- `max_delivery_attempts` – Max attempts before DLQ  
- `labels` – Key-value labels  

## Outputs

| Name              | Description |
|-------------------|-------------|
| topic_names       | List of topic names |
| subscription_names | List of subscription names |

## Example Usage

```hcl
module "pubsub" {
  source  = "../pubsub"
  project = var.project

  topics = [
    {
      name                       = "orders"
      message_retention_duration = "604800s"
      labels                     = { env = "prod" }
    }
  ]

  dead_letter_topics = [
    {
      name   = "orders-dlq"
      labels = { env = "prod" }
    }
  ]

  subscriptions = [
    {
      name                 = "orders-sub"
      topic_index          = 0
      ack_deadline_seconds = 20
      retain_acked_messages = true
      expiration_ttl       = "2678400s"
      min_backoff          = "10s"
      max_backoff          = "600s"
      dead_letter_topic    = 0
      max_delivery_attempts = 5
      labels               = { env = "prod" }
    }
  ]
}
