module resource-gcs {
  source          = "../module/"
  project_id      = "kewei-demo-sandbox"
  bucket_name     = "kewei-demo-sandbox-gcs"
  region          = "australia-southeast1"
  force_destroy   = "true"
  storage_class   = "NEARLINE"
  versioning_enabled = "false"
}