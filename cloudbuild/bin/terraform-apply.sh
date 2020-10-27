#!/bin/bash

set -exuo pipefail

echo "Running on $BRANCH_NAME branch"

terraform_apply () {
 	sh cloudbuild/bin/terraform-init.sh
	cd modules/${MODULE}/example
	terraform plan -out ${MODULE}-${ENV}.tfstate
	terraform apply -auto-approve ${MODULE}-${ENV}.tfstate
}

terraform_apply
