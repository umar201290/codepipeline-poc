#!/bin/bash
set -e

TF_REFRESH=${TF_REFRESH:="true"}

export http_proxy="10.192.126.40:8080"
export https_proxy="10.192.126.40:8080"

TF_VAR_FILE="./terraform.tfvars"

terraform plan -var-file=${TF_VAR_FILE} -refresh=${TF_REFRESH}
