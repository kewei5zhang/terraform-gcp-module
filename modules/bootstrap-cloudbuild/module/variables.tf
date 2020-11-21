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
  default     = ["dev","qa"]
}
variable build_env {
  default = "nonprod-build"
}
variable repo_owner {
  default = "kewei5zhang"
}
variable module_name_list {
  description = "A list of module names"
  type        = list(string)
  default     = ["resource-gcs"]
}
