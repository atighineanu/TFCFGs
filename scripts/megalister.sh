#!/bin/sh
set -e

find some-files
find /app

ln -s /usr/bin/chromedriver /usr/sbin/chromedriver
cp some-files/id_caasp /app/caasp-openstack-terraform/ssh/id_caasp
chmod 0500 /app/caasp-openstack-terraform/ssh/id_caasp
cp some-files/caasp-cluster.tf /app/caasp-openstack-terraform/caasp-cluster.tf
cp some-files/terraform.tfvars /app/caasp-openstack-terraform/terraform.tfvars
cp some-files/terraform.tfstate /app/caasp-openstack-terraform/terraform.tfstate
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ostkcmd "terraform init"
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ostkcmd "terraform refresh"
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -caaspuiinst
cp /app/caasp-openstack-terraform/caasp-cluster.tf some-files/caasp-cluster.tf
cp /app/caasp-openstack-terraform/terraform.tfvars some-files/terraform.tfvars
cp /app/caasp-openstack-terraform/terraform.tfstate some-files/terraform.tfstate
cp /app/caasp-openstack-terraform/ssh/id_caasp some-files/id_caasp

