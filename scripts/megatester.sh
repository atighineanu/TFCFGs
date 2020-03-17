#!/bin/sh
export MKCAASPROOT=/root/go/src/mkcaasp
cp -r some-files/* /usr/share/caasp/terraform/vmware/
cp -r some-files/imba-cluster /root/go/src/mkcaasp/tests/ginkgoscenarios/scenario1/
mkdir -p .kube/config
cp /root/go/src/mkcaasp/tests/ginkgoscenarios/scenario1/imba-cluster/admin.conf .kube/config
sleep 60;
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -rpm -createcaasp -action init
/root/go/src/mkcaasp/main -v 4 -rpm -createcaasp -action refresh
/root/go/src/mkcaasp/main -v 4 -rpm -status
sleep 2
kubectl get nodes
sleep 2
kubectl get all -n kube-system
sleep 2
/root/go/src/mkcaasp/main -v 4 -rpm -reboot workers
sleep 2
sleep 100
/root/go/src/mkcaasp/main -v 4 -rpm -status
/root/go/src/mkcaasp/main -v 4 -rpm -diagn
/root/go/src/mkcaasp/main -v 4 -rpm -proto workers
cp -r /usr/share/caasp/terraform/vmware/* other-files/
