#!/bin/sh
ln -s /usr/bin/chromedriver /usr/sbin/chromedriver
cp some-files/id_caasp /app/caasp-openstack-terraform/id_caasp
chmod 0500 /app/caasp-openstack-terraform/id_caasp
cp some-files/id_caasp /app/caasp-openstack-terraform/ssh/id_caasp
chmod 0500 /app/caasp-openstack-terraform/ssh/id_caasp
sleep 60;
eval $(ssh-agent)
ssh-add /app/caasp-openstack-terraform/ssh/id_caasp
cp some-files/caasp-cluster.tf /app/caasp-openstack-terraform/caasp-cluster.tf
cp some-files/terraform.tfvars /app/caasp-openstack-terraform/terraform.tfvars
cp some-files/terraform.tfstate /app/caasp-openstack-terraform/terraform.tfstate
/root/go/src/mkcaasp/main -repo /app/caasp-openstack-terraform -auth openstack.json -ostkcmd "terraform refresh"
sleep 10;
/root/go/src/mkcaasp/main -repo /app/caasp-openstack-terraform -auth openstack.json -caaspuiinst
cp /app/caasp-openstack-terraform/caasp-cluster.tf other-files/caasp-cluster.tf
cp /app/caasp-openstack-terraform/terraform.tfvars other-files/terraform.tfvars
cp /app/caasp-openstack-terraform/terraform.tfstate other-files/terraform.tfstate
cp /app/caasp-openstack-terraform/ssh/id_caasp other-files/id_caasp
