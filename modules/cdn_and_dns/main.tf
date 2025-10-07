# Reserve Global Static IP
resource "google_compute_global_address" "default" {
  name = "${var.name}-ip"
}

# Backend Bucket for CDN
resource "google_compute_backend_bucket" "default" {
  name        = "${var.name}-backend-bucket"
  bucket_name = var.bucket_name
  enable_cdn  = true
}

# SSL Certificate
resource "google_compute_managed_ssl_certificate" "default" {
  name = "${var.name}-cert"
  managed {
    domains = [var.domain]
  }
}

# URL Map
resource "google_compute_url_map" "default" {
  name            = "${var.name}-url-map"
  default_service = google_compute_backend_bucket.default.id
}

# HTTPS Proxy
resource "google_compute_target_https_proxy" "default" {
  name             = "${var.name}-https-proxy"
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

# Global Forwarding Rule
resource "google_compute_global_forwarding_rule" "default" {
  name       = "${var.name}-fwd-rule"
  target     = google_compute_target_https_proxy.default.id
  port_range = "443"
  ip_address = google_compute_global_address.default.address
}

# DNS Managed Zone
resource "google_dns_managed_zone" "default" {
  name        = "${var.name}-zone"
  dns_name    = "${var.domain}."
  description = "Managed zone for ${var.domain}"
}

# DNS A Record
resource "google_dns_record_set" "default" {
  name         = "${var.domain}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.default.name

  rrdatas = [google_compute_global_address.default.address]
}
