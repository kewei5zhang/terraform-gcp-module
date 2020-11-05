#!/bin/bash

set -exuo pipefail

MAIN_VERSION="v1"

if [[ "$BRANCH_NAME" == "master" ]]; then
	echo "Detect update in the following modules"
	module_name=$(git log --name-only | grep modules | awk '{split($0,a,"/"); print a[2]}' | sort | uniq)
	NEW_VERSION=$MAIN_VERSION.$BUILD_ID
	git tag -a $NEW_VERSION -m "module update in $module_name, tag version $NEW_VERSION"
	git push origin $NEW_VERSION
else
	echo "Skip tagging step"
fi