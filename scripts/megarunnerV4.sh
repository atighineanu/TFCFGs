#!/bin/sh
eval $(ssh-agent)
ssh-add ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -createcaasp -action init -rpm
/root/go/src/mkcaasp/main -v 4 -createcaasp -action apply -nodes w1m1 -rpm -bootstrap
cat /usr/share/caasp/terraform/vmware/terraform.tfstate
#/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -createcaasp -action apply
echo "---end---"
#/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ostkcmd "terraform output" > some-files/out.json
#cp /app/caasp-openstack-terraform/caasp-cluster.tf some-files/caasp-cluster.tf
#cp /app/caasp-openstack-terraform/terraform.tfvars some-files/terraform.tfvars
#cp /app/caasp-openstack-terraform/terraform.tfstate some-files/terraform.tfstate
#cp /app/caasp-openstack-terraform/ssh/id_caasp some-files/id_caasp
#cat /app/caasp-openstack-terraform/terraform.tfstate
