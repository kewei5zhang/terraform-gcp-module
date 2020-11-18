#!/bin/bash
set -xuo pipefail

VERSION='patch'

tag_update () {
	# get highest tag number, and add 1.0.0 if doesn't exist
	git remote set-url origin git@github.com:$REPO_OWNER/$REPO_NAME
	git fetch --unshallow
	CURRENT_VERSION=$(git describe --abbrev=0 --tags 2>/dev/null)

	if [[ $CURRENT_VERSION == '' ]];
	then
	CURRENT_VERSION='1.0.0'
	fi

	echo "Current Version: $CURRENT_VERSION"
	# replace . with space so can split into an array
	CURRENT_VERSION_PARTS=(${CURRENT_VERSION//./ })
	# get number parts
	VNUM1=${CURRENT_VERSION_PARTS[0]}
	VNUM2=${CURRENT_VERSION_PARTS[1]}
	VNUM3=${CURRENT_VERSION_PARTS[2]}

	if [[ $VERSION == 'major' ]];
	then
	VNUM1=$((VNUM1+1))
	elif [[ $VERSION == 'minor' ]];
	then
	VNUM2=$((VNUM2+1))
	elif [[ $VERSION == 'patch' ]];
	then
	VNUM3=$((VNUM3+1))
	else
	echo "No version type (https://semver.org/) or incorrect type specified, try: -v [major, minor, patch]"
	exit 1
	fi

	# create new tag
	NEW_TAG="$VNUM1.$VNUM2.$VNUM3"
	echo "($VERSION) updating $CURRENT_VERSION to $NEW_TAG"

	# get current hash and see if it already has a tag
	GIT_COMMIT=$(git rev-parse HEAD)
	NEEDS_TAG=$(git describe --contains $GIT_COMMIT 2>/dev/null)

	# retrieve modules updated
	module_name=$(git log -2 --name-only | grep modules | awk '{split($0,a,"/"); print a[2]}' | sort | uniq 2>/dev/null)
	echo "Detect update in the these modules: $module_name"

	# only tag if no tag already
	if [ -z "$NEEDS_TAG" ]; then
		# set git identity
		git config --global user.name $REPO_OWNER 
    	git config --global user.email "keweizhang411@gmail.com" 
		git tag -a $NEW_TAG -m "module update in $module_name, tag version $NEW_TAG"
		echo "Tagged with $NEW_TAG"
		git push --tags
	else
		echo "Already a tag on this commit"
	fi
}

if [[ "$BRANCH_NAME" == "master" ]]; then
	tag_update
else
	echo "terraform-gcp-modules release will run only based on master branch. Please raise a PR to trigger this process."
fi
