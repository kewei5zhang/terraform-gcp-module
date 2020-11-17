resource "google_storage_bucket" "gcs" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = var.force_destroy
  project       = var.project_id
  storage_class = var.storage_class
  versioning {
    enabled = var.versioning_enabled
  }
}