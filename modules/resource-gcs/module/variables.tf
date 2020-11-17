variable project_id {}
variable bucket_name {}
variable region {
  default     = "australia-southeast1"
}
variable force_destroy {
  default = "false"
}

variable storage_class {
  default = "NEARLINE"
}
variable versioning_enabled {
  default = "false"
}