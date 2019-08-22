#!/bin/sh
cp some-files/caasp-cluster.tf /app/caasp-openstack-terraform/caasp-cluster.tf
cp some-files/terraform.tfvars /app/caasp-openstack-terraform/terraform.tfvars
cp some-files/terraform.tfstate /app/caasp-openstack-terraform/terraform.tfstate
cp some-files/id_caasp /app/caasp-openstack-terraform/id_caasp
chmod 0500 /app/caasp-openstack-terraform/id_caasp
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -test health

/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -cmd "rpm -qi $1"

cp /app/caasp-openstack-terraform/caasp-cluster.tf other-files/caasp-cluster.tf 
cp /app/caasp-openstack-terraform/terraform.tfvars other-files/terraform.tfvars
cp /app/caasp-openstack-terraform/terraform.tfstate other-files/terraform.tfstate
cp /app/caasp-openstack-terraform/id_caasp other-files/id_caasp