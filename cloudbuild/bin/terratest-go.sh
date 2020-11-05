#!/bin/bash

set -exuo pipefail

go mod init github.com/kewei5zhang/terraform-gcp-module

cd modules/${MODULE}/test 

go mod vendor

go test
