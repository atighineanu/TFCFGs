#!/bin/sh
cp other-files/caasp-cluster.tf /app/caasp-openstack-terraform/caasp-cluster.tf
cp other-files/terraform.tfvars /app/caasp-openstack-terraform/terraform.tfvars
cp other-files/terraform.tfstate /app/caasp-openstack-terraform/terraform.tfstate
cp other-files/id_caasp /app/caasp-openstack-terraform/id_caasp
chmod 0500 /app/caasp-openstack-terraform/id_caasp
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -test health

/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -cmd "rpm -qi $1"

cp /app/caasp-openstack-terraform/caasp-cluster.tf some-files/caasp-cluster.tf 
cp /app/caasp-openstack-terraform/terraform.tfvars some-files/terraform.tfvars
cp /app/caasp-openstack-terraform/terraform.tfstate some-files/terraform.tfstate
cp /app/caasp-openstack-terraform/id_caasp some-files/id_caasp