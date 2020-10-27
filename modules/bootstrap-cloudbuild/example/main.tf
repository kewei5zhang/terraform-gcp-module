module bootstrap-cloudbuild {
  source           = "../module/"
  build_project_id = "kewei-demo-sandbox"
  env_names        = ["nonprod"]
  # substitution_vars = ""
  build_env = "nonprod-build"
}
