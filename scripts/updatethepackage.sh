#!/bin/sh
cp other-files/caasp-cluster.tf /app/caasp-openstack-terraform/caasp-cluster.tf
cp other-files/terraform.tfvars /app/caasp-openstack-terraform/terraform.tfvars
cp other-files/terraform.tfstate /app/caasp-openstack-terraform/terraform.tfstate
cp other-files/id_caasp /app/caasp-openstack-terraform/id_caasp
chmod 0500 /app/caasp-openstack-terraform/id_caasp
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -dis
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ar $1
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -cmd "zypper --no-gpg-checks ref"
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -cmd "transactional-update reboot pkg install -y $2"
sleep 10
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -uiupd

cp /app/caasp-openstack-terraform/caasp-cluster.tf some-files/caasp-cluster.tf 
cp /app/caasp-openstack-terraform/terraform.tfvars some-files/terraform.tfvars
cp /app/caasp-openstack-terraform/terraform.tfstate some-files/terraform.tfstate
cp /app/caasp-openstack-terraform/id_caasp some-files/id_caasp