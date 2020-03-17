#!/bin/sh
echo MKCAASPROOT=/root/go/src/mkcaasp
cp -r some-files/* /usr/share/caasp/terraform/vmware/
zypper -n up skuba
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -rpm -vmware -createcaasp -action init
sleep 5
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -rpm -vmware -createcaasp -action refresh
sleep 10
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
sleep 3
/root/go/src/mkcaasp/main -v 4 -rpm -vmware -cmd "sudo zypper ref; sudo zypper -n up; sudo systemctl disable firewalld; sudo reboot now" -all
sleep 60
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -rpm -ginkgo deploy01
sleep 10
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -rpm -addnodes w1m0
sleep 10
/root/go/src/mkcaasp/main -v 4 -rpm -ginkgo add_cluster_nodes03
cp -r /usr/share/caasp/terraform/vmware/* other-files/
cp -r /root/go/src/mkcaasp/tests/ginkgoscenarios/imba-cluster other-files/
