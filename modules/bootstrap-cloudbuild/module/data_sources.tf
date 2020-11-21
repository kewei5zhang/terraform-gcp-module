data google_project build_project {
  project_id = var.build_project_id
}

data google_pubsub_topic cloud_builds {
  project = var.build_project_id
  name    = "cloud-builds"
}