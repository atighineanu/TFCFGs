#!/bin/sh
cp other-files/caasp-cluster.tf /app/caasp-openstack-terraform/caasp-cluster.tf
cp other-files/terraform.tfvars /app/caasp-openstack-terraform/terraform.tfvars
cp other-files/terraform.tfstate /app/caasp-openstack-terraform/terraform.tfstate
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ostkcmd "terraform destroy -auto-approve"
