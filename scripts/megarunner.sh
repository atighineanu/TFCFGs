#!/bin/sh
set -e
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ostkcmd "terraform init"
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -createcaasp -action apply
#/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ostkcmd "terraform output" > some-files/out.json
cp /app/caasp-openstack-terraform/caasp-cluster.tf some-files/caasp-cluster.tf
cp /app/caasp-openstack-terraform/terraform.tfvars some-files/terraform.tfvars
cp /app/caasp-openstack-terraform/terraform.tfstate some-files/terraform.tfstate
cp /app/caasp-openstack-terraform/ssh/id_caasp some-files/id_caasp
cat /app/caasp-openstack-terraform/terraform.tfstate
