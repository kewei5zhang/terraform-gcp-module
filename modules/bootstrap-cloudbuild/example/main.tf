module bootstrap-cloudbuild {
  source           = "../module/"
  build_project_id = "kewei-demo-sandbox"
  env_names        = ["test_env"]
  build_env        = "nonprod-build"
}
