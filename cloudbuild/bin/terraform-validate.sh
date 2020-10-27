#!/bin/bash

set -exuo pipefail

sh cloudbuild/bin/terraform-init.sh

cd modules/${MODULE}/example

terraform validate

