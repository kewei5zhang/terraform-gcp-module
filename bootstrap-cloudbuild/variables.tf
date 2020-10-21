variable build_project_id {}
variable substitution_vars {
  default = {
    _ENV                = "nonprod"
    _CONTAINER_REGISTRY = ""
  }
}
variable env_names {
  description = "A list of environment names"
  type        = list(string)
  default     = ["nonprod"]
}
variable build_env {
  default = "nonprod-build"
}


