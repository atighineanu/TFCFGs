#!/bin/sh
cp some-files/caasp-cluster.tf /app/caasp-openstack-terraform/caasp-cluster.tf
cp some-files/terraform.tfvars /app/caasp-openstack-terraform/terraform.tfvars
cp some-files/terraform.tfstate /app/caasp-openstack-terraform/terraform.tfstate
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -createcaasp -caaspuiinst
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ostkcmd "terraform output" > some-files/out.json
cp /app/caasp-openstack-terraform/caasp-cluster.tf some-files/caasp-cluster.tf
cp /app/caasp-openstack-terraform/terraform.tfvars some-files/terraform.tfvars
cp /app/caasp-openstack-terraform/terraform.tfstate some-files/terraform.tfstate

