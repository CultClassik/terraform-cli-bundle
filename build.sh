#!/bin/bash

SRC_TF="https://github.com/hashicorp/terraform"
SRC_IBX="https://github.com/infobloxopen/terraform-provider-infoblox"
IBX_VER="1.0.1"

# build the infoblox provider plug-in
git clone ${SRC_IBX} ./ibxsource &&\
docker run --rm \
    -e GO111MODULE=on \
    -v "$PWD"/ibxsource:/source \
    -w /source \
    golang \
    make build

# add version to the provider file (required by the terraform)
mv ./ibxsource/terraform-provider-infoblox ./terraform-provider-infoblox_v${IBX_VER}

# install the terraform-bundle tool from the terraform source code, then create the new bundle
git clone ${SRC_TF} ./tfsource &&\
docker run --rm \
    -v "$PWD"/tfsource:/terraform \
    -v "$PWD":/data \
    -w /source \
    golang \
    /data/terraform-bundle-build.sh

# cleanup
rm ./terraform-provider-infoblox_v${IBX_VER}
rm -rf ./tfsource
rm -rf ./ibxsource

# output
BUNDLE_FILE=`ls ./terraform_*`
SHA_SUM=`sha256sum ${BUNDLE_FILE}`
echo "SHA 256 checksum for bundle to be used with Terraform Enterprise:"
echo ${SHA_SUM}
echo "For the version in Terraform Enterprise when uploading, use the portion of the filename that follows this format:"
echo "N.N.N-bundleYYYYMMDDHH"