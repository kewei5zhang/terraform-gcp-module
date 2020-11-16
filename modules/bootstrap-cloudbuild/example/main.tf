module bootstrap-cloudbuild {
  source           = "../module/"
  build_project_id = "kewei-demo-sandbox"
  env_names        = ["dev","qa"]
  # substitution_vars = ""
  build_env = "nonprod-build"
}
