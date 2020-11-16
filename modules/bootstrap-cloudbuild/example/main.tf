module bootstrap-cloudbuild {
  source           = "../module/"
  build_project_id = "kewei-demo-sandbox"
  env_names        = ["dev","qa"]
  build_env = "nonprod-build"
}
