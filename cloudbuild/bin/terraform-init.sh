#!/bin/bash

set -exuo pipefail

cd modules/${MODULE}/example

terraform get -update

terraform init \
	-backend-config="bucket=${PROJECT_ID}-statefile" \
	-backend-config="prefix=${MODULE}-${ENV}" \
	-reconfigure \
	-get=false \
	# -get-plugins=false \
	# -plugin-dir=/terraform.d/plugins
