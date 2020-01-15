#!/bin/bash
cd /terraform
go install ./tools/terraform-bundle
terraform-bundle package -plugin-dir /data /data/terraform-bundle.hcl
cp ./terraform_* /data/