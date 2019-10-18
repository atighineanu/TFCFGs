#!/bin/sh
cp other-files/caasp-cluster.tf /app/caasp-openstack-terraform/caasp-cluster.tf
cp other-files/terraform.tfvars /app/caasp-openstack-terraform/terraform.tfvars
cp other-files/terraform.tfstate /app/caasp-openstack-terraform/terraform.tfstate
cp other-files/id_caasp /app/caasp-openstack-terraform/id_caasp
cp other-files/id_caasp /app/caasp-openstack-terraform/ssh/id_caasp
chmod 0500 /app/caasp-openstack-terraform/id_caasp
chmod 0500 /app/caasp-openstack-terraform/ssh/id_caasp
eval $(ssh-agent)
ssh-add /app/caasp-openstack-terraform/ssh/id_caasp
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -reg
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -dis
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ar $1
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -cmd "zypper -n --gpg-auto-import-keys ref"
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -cmd "zypper --no-gpg-checks ref"
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -cmd "echo \"ZYPPER_AUTO_IMPORT_KEYS=1\" >> /etc/transactional-update.conf"
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -sysupd
sleep 20
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -uiupd

cp /app/caasp-openstack-terraform/caasp-cluster.tf some-files/caasp-cluster.tf 
cp /app/caasp-openstack-terraform/terraform.tfvars some-files/terraform.tfvars
cp /app/caasp-openstack-terraform/terraform.tfstate some-files/terraform.tfstate
cp /app/caasp-openstack-terraform/id_caasp some-files/id_caasp
