#!/bin/bash

set -exuo pipefail

cd modules/${_MODULE}/example

tflint --disable-rule=terraform_module_pinned_source
