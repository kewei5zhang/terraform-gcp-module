terraform {
  required_version = ">= 0.12.26"
}

locals {
  env               = lookup(var.substitution_vars, "_ENV", "nonprod")
  plan_branch_name  = lookup(var.substitution_vars, "_ENV", "nonprod") == "prod" ? "^develop$" : "feature/*"
  apply_branch_name = lookup(var.substitution_vars, "_ENV", "nonprod") == "prod" ? "^master$" : "develop"
}

# Create Cloud Source Repositories
resource google_sourcerepo_repository terraform_gcp_foundation {
  project = data.google_project.build_project.project_id
  name    = "terraform-gcp-foundation"
}

resource google_sourcerepo_repository terraform_gcp_module {
  project = data.google_project.build_project.project_id
  name    = "terraform-gcp-module"
}

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
      branch = "feature/${var.module_name_list[count.index]}*"
    }
  }
  filename      = "cloudbuild-dry-run.yaml"
  substitutions = merge(var.substitution_vars, { _MODULE = var.module_name_list[count.index] })
  included_files = [
    "modules/${var.module_name_list[count.index]}/module/**",
  ]
}
# Create Module CI Cloudbuild trigger for testing and dev version release based on develop branch
# Create Module CI Cloudbuild trigger for testing and prod release based on master branch





