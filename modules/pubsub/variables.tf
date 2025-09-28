variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "Region for Pub/Sub (not required but for consistency)"
  default     = "us-central1"
}

variable "topics" {
  description = "List of Pub/Sub topics"
  type = list(object({
    name                       = string
    message_retention_duration = string
    labels                     = map(string)
  }))

  default = [
    {
      name                       = "orders"
      message_retention_duration = "604800s" # 7 days
      labels                     = {}
    }
  ]
}

variable "dead_letter_topics" {
  description = "List of dead letter topics"
  type = list(object({
    name   = string
    labels = map(string)
  }))
  default = []
}

variable "subscriptions" {
  description = "List of Pub/Sub subscriptions"
  type = list(object({
    name                 = string
    topic_index          = number
    ack_deadline_seconds = number
    retain_acked_messages = bool
    expiration_ttl       = string
    min_backoff          = string
    max_backoff          = string
    dead_letter_topic    = number # index of dead_letter_topics list
    max_delivery_attempts = number
    labels               = map(string)
  }))

  default = [
    {
      name                 = "orders-sub"
      topic_index          = 0
      ack_deadline_seconds = 20
      retain_acked_messages = true
      expiration_ttl       = "2678400s" # 31 days
      min_backoff          = "10s"
      max_backoff          = "600s"
      dead_letter_topic    = null
      max_delivery_attempts = 5
      labels               = {}
    }
  ]
}
variable "credentials_file" {
  description = "Path to GCP credentials file"
  type        = string
  default = "gcp-terraform-key.json"
}