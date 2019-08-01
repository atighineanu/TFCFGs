#!/bin/sh
cp some-files/caasp-cluster.tf /app/caasp-openstack-terraform/caasp-cluster.tf
cp some-files/terraform.tfvars /app/caasp-openstack-terraform/terraform.tfvars
cp some-files/terraform.tfstate /app/caasp-openstack-terraform/terraform.tfstate
cp some-files/terraform.tfstate /var/www/localhost/htdocs/index.html
cp some-files/id_caasp /app/caasp-openstack-terraform/id_caasp
chmod 0500 /app/caasp-openstack-terraform/id_caasp
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -test health
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -cmd "rpm -qi $1"
/app/mkcaasp -repo /app/caasp-openstack-terraform -auth openstack.json -ostkcmd "terraform output -json"
#exec /usr/sbin/httpd -D FOREGROUND -f /etc/apache2/httpd.conf