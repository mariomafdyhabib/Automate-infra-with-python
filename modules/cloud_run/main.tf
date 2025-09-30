terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  credentials = file(var.credentials_file)
}

# Cloud Run Service
resource "google_cloud_run_service" "default" {
  name     = var.name
  location = var.region

  template {
    spec {
      containers {
        image = var.image

        resources {
          limits = {
            cpu    = var.cpu
            memory = var.memory
          }
        }

        dynamic "env" {
          for_each = var.env_vars
          content {
            name  = env.key
            value = env.value
          }
        }
      }
      container_concurrency = var.concurrency
      timeout_seconds       = var.timeout_seconds
    }
  }

  # traffics {
  #   percent         = 100
  #   latest_revision = true
  # }
}

# IAM Binding (Public or Restricted)
resource "google_cloud_run_service_iam_binding" "binding" {
  count = var.allow_unauthenticated ? 1 : 0

  location = google_cloud_run_service.default.location
  service  = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  members  = ["allUsers"]
}
