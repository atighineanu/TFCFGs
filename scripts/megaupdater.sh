#!/bin/sh
cp some-files/caasp-cluster.tf /app/caasp-openstack-terraform/caasp-cluster.tf
cp some-files/terraform.tfvars /app/caasp-openstack-terraform/terraform.tfvars
cp some-files/terraform.tfstate /app/caasp-openstack-terraform/terraform.tfstate
cp some-files/id_caasp /app/caasp-openstack-terraform/id_caasp
chmod 0500 /app/caasp-openstack-terraform/id_caasp
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -reg
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -dis
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ar $1
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -cmd "zypper -n --gpg-auto-import-keys ref"
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -cmd "zypper  --no-gpg-checks ref"
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -cmd "echo \"ZYPPER_AUTO_IMPORT_KEYS=1\" >> /etc/transactional-update.conf"
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -sysupd
sleep 10
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -uiupd
