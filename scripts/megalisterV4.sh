#!/bin/sh
export MKCAASPROOT=/root/go/src/mkcaasp
cp -r some-files/* /usr/share/caasp/terraform/openstack/
cp some-files/mkcaaspcfg.json /root/go/src/mkcaasp/
zypper -n up skuba
zypper -n in terraform
/root/go/src/mkcaasp/main -v 4 -rpm -upgradetf12
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -rpm -openstack -createcaasp -action init
sleep 5
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -rpm -createcaasp -action refresh
sleep 10
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
sleep 3
/root/go/src/mkcaasp/main -v 4 -rpm -cmd "sudo zypper ref; sudo zypper -n up; sudo systemctl disable firewalld; sudo reboot now" -all
sleep 60
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
export GO111MODULE=on
/root/go/src/mkcaasp/main -v 4 -rpm -ginkgo deploy01
sleep 10
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -rpm -createcaasp -action apply -nodes w2m1
sleep 10
/root/go/src/mkcaasp/main -v 4 -rpm -ginkgo add_cluster_nodes03
cp /root/go/src/mkcaasp/mkcaaspcfg.json other-files/
cp -r /usr/share/caasp/terraform/openstack/* other-files/
cp -r /root/go/src/mkcaasp/tests/ginkgoscenarios/imba-cluster other-files/
