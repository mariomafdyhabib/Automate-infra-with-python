terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  # credentials = file(var.credentials_file)
}

# Backend Service
resource "google_compute_backend_service" "default" {
  name                  = "${var.name}-backend"
  load_balancing_scheme = "EXTERNAL"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 30

  backend {
    group = google_compute_instance_group.default.self_link
  }

  health_checks = [google_compute_health_check.default.id]
}

# Health Check
resource "google_compute_health_check" "default" {
  name                = "${var.name}-hc"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  http_health_check {
    port = 80
  }
}

# URL Map
resource "google_compute_url_map" "default" {
  name            = "${var.name}-url-map"
  default_service = google_compute_backend_service.default.id
}

# HTTP Proxy (replaces HTTPS proxy)
resource "google_compute_target_http_proxy" "default" {
  name    = "${var.name}-http-proxy"
  url_map = google_compute_url_map.default.id
}

# Global Forwarding Rule for HTTP (port 80)
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "${var.name}-fwd-rule"
  target                = google_compute_target_http_proxy.default.id
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = var.ip_address
}
resource "google_compute_instance_group" "default" {
  name        = "${var.name}-backend-group"
  zone        = "us-central1-a"
  description = "Instance group for backend servers"
}

