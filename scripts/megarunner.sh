#!/bin/sh
function copy_some_files {
	cp /app/caasp-openstack-terraform/caasp-cluster.tf some-files/caasp-cluster.tf
	cp /app/caasp-openstack-terraform/terraform.tfvars some-files/terraform.tfvars
	cp /app/caasp-openstack-terraform/terraform.tfstate some-files/terraform.tfstate
	cp /app/caasp-openstack-terraform/ssh/id_caasp some-files/id_caasp
	cat /app/caasp-openstack-terraform/terraform.tfstate
	find some-files
	find /app
}

/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ostkcmd "terraform init"
if [ $? -ne 0 ]; then
	copy_some_files
	return 1
fi

/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -createcaasp -action apply
if [ $? -ne 0 ]; then
	copy_some_files
	return 1
fi
copy_some_files
#/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ostkcmd "terraform output" > some-files/out.json
