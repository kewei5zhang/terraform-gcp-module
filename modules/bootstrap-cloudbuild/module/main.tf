terraform {
  required_version = ">= 0.12.26"
}

# Create Cloud Source Repositories
# resource google_sourcerepo_repository terraform_gcp_foundation {
#   project = data.google_project.build_project.project_id
#   name    = "terraform-gcp-foundation"
# }

# resource google_sourcerepo_repository terraform_gcp_module {
#   project = data.google_project.build_project.project_id
#   name    = "terraform-gcp-module"
# }

# Create Module CI Cloudbuild trigger for unit-testing based on feature branch
resource google_cloudbuild_trigger module_dry_run {
  provider    = google-beta
  count       = length(var.module_name_list)
  description = "module ${var.module_name_list[count.index]} - dry run"
  project     = var.build_project_id
  github {
    owner = var.repo_owner
    name  = "terraform-gcp-module"
    push {
      branch = "feature/${var.module_name_list[count.index]}-*"
    }
  }
  filename      = "cloudbuild/cloudbuild-dry-run.yaml"
  substitutions = merge(var.substitution_vars, { _MODULE = var.module_name_list[count.index] })
  included_files = [
    "modules/${var.module_name_list[count.index]}/module/**",
  ]
}
# Create Foundation CI Cloudbuild trigger for terraform-gcp-foundation static analysis
resource google_cloudbuild_trigger infra_plan {
  provider    = google-beta
  count       = length(var.env_names)
  description = "infra env ${var.env_names[count.index]} - plan"
  project     = var.build_project_id
  github {
    owner = var.repo_owner
    name  = "terraform-gcp-foundation"
    push {
      branch = "feature/${var.env_names[count.index]}-*"
    }
  }
  filename      = "cloudbuild-plan.yaml"
  substitutions = merge(var.substitution_vars, { _ENV = var.env_names[count.index] })
  included_files = [
    "env/${var.env_names[count.index]}/**",
  ]
}
# Create Foundation CD Cloudbuild trigger for terraform-gcp-foundation code release
resource google_cloudbuild_trigger infra_release {
  provider    = google-beta
  count       = length(var.env_names)
  description = "infra env ${var.env_names[count.index]} - release"
  project     = var.build_project_id
  github {
    owner = var.repo_owner
    name  = "terraform-gcp-foundation"
    push {
      branch = "^master$"
    }
  }
  filename      = "cloudbuild-git-tag.yaml"
  substitutions = merge(var.substitution_vars, { _ENV = var.env_names[count.index] })
  included_files = [
    "env/${var.env_names[count.index]}/**",
  ]
}
# Create Foundation CD Cloudbuild trigger for terraform-gcp-foundation deployment
resource google_cloudbuild_trigger infra_apply {
  provider    = google-beta
  count       = length(var.env_names)
  description = "infra env ${var.env_names[count.index]} - apply"
  project     = var.build_project_id
  github {
    owner = var.repo_owner
    name  = "terraform-gcp-foundation"
    push {
      tag = "${var.env_names[count.index]}_v*"
    }
  }
  filename      = "cloudbuild-apply.yaml"
  substitutions = merge(var.substitution_vars, { _ENV = var.env_names[count.index] })
  included_files = [
    "env/${var.env_names[count.index]}/**",
  ]
}
# Create Foundation Ops Cloudbuild trigger for terraform-gcp-foundation teardown
resource google_cloudbuild_trigger infra_destroy {
  provider    = google-beta
  count       = length(var.env_names)
  description = "infra env ${var.env_names[count.index]} - destroy"
  project     = var.build_project_id
  github {
    owner = var.repo_owner
    name  = "terraform-gcp-foundation"
    push {
      branch = "^master$"
    }
  }
  filename      = "cloudbuild-destroy.yaml"
  substitutions = merge(var.substitution_vars, { _ACTION = "plan_only" })
  included_files = [
    "should not match anything here",
  ]
}




