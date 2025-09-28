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

# SSL Certificate
resource "google_compute_managed_ssl_certificate" "default" {
  count = var.use_managed_ssl ? 1 : 0

  name = "${var.name}-managed-cert"
  managed {
    domains = var.domains
  }
}

resource "google_compute_ssl_certificate" "self_signed" {
  count = var.use_managed_ssl ? 0 : 1

  name        = "${var.name}-self-cert"
  private_key = file(var.private_key_path)
  certificate = file(var.certificate_path)
}

# Backend Service
resource "google_compute_backend_service" "default" {
  name                  = "${var.name}-backend"
  load_balancing_scheme = "EXTERNAL"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 30

  backend {
    group = var.backend_group
  }

  health_checks = [google_compute_health_check.default.id]
}

# Health Check
resource "google_compute_health_check" "default" {
  name               = "${var.name}-hc"
  check_interval_sec = 5
  timeout_sec        = 5
  healthy_threshold  = 2
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

# HTTPS Proxy
resource "google_compute_target_https_proxy" "default" {
  name    = "${var.name}-https-proxy"
  url_map = google_compute_url_map.default.id

  ssl_certificates = var.use_managed_ssl ? 
    [google_compute_managed_ssl_certificate.default[0].id] : 
    [google_compute_ssl_certificate.self_signed[0].id]
}

# Global Forwarding Rule
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "${var.name}-fwd-rule"
  target                = google_compute_target_https_proxy.default.id
  port_range            = "443"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = var.ip_address
}
