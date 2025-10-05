terraform {
  backend "gcs" {
    bucket      = "mariomafdy-bucket"   # <-- replace with your bucket name
    prefix      = "terraform/state"             # folder path inside the bucket
    # credentials = "gcp-terraform-key.json"      # service account key file
  }
}
