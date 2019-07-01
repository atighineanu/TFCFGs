#!/bin/sh
set -e
cp some-files/caasp-cluster.tf /app/caasp-openstack-terraform/caasp-cluster.tf
cp some-files/terraform.tfvars /app/caasp-openstack-terraform/terraform.tfvars
cp some-files/terraform.tfstate /app/caasp-openstack-terraform/terraform.tfstate
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ostkcmd "terraform init"
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ostkcmd "terraform destroy -auto-approve"
