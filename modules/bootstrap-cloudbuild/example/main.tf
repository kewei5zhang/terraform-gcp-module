module bootstrap-cloudbuild {
  source           = "../module/"
  build_project_id = "kewei-demo-sandbox"
  env_names        = ["test-env"]
  build_env        = "nonprod-build"
}
