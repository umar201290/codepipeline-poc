#!/bin/bash
set -e

TF_REFRESH=${TF_REFRESH:="true"}

export http_proxy="10.192.126.40:8080"
export https_proxy="10.192.126.40:8080"

##################################################################
# Delete local terraform config and pull from s3 config
##################################################################
rm -rf .terraform

######################################################################################
# Pull remote terraform config then compare and update finally pushing to s3
######################################################################################

S3KEY="${PROJECT}/terraform.tfstate"
#TF_VAR_FILE="./terraform.tfvars"

echo "##################################################################################"
echo "# Terraform State Bucket at"
echo "#     s3://${BUCKET}/${S3KEY}"
echo "##################################################################################"

terraform init \
      -backend=true \
      -backend-config="bucket=${BUCKET}" \
      -backend-config="key=${S3KEY}" \
      -backend-config="region=eu-west-1" \
      -get-plugins=false \
      -plugin-dir=/usr/local/bin/terraform.d/plugins/linux_amd64 \
      -get=true \
      -input=false \
      -force-copy

#terraform plan -var-file=${TF_VAR_FILE} -refresh=${TF_REFRESH}
