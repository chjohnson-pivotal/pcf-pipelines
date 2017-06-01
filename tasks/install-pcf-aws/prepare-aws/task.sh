#!/bin/bash

set -ex

ami=$(cat ami/ami)

terraform plan \
  -state terraform-state/terraform.tfstate \
  -var "opsman_ami=${ami}" \
  -var "db_master_username=${DB_MASTER_USERNAME}" \
  -var "db_master_password=${DB_MASTER_PASSWORD}" \
  -var "prefix=${TERRAFORM_PREFIX}" \
  -out terraform.tfplan \
  pcf-pipelines/tasks/install-pcf-aws/terraform

terraform apply \
  -state-out terraform-state-output/terraform.tfstate \
  terraform.tfplan
