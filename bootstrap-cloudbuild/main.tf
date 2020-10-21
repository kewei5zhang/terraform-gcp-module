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
