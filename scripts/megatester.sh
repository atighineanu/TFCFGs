#!/bin/sh
cp -r some-files/* /usr/share/caasp/terraform/vmware/
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -rpm -status
sleep 2
kubectl get nodes
sleep 2
kubectl get services
sleep 2
/root/go/src/mkcaasp/main -v 4 -rpm -reboot masters
sleep 2
/root/go/src/mkcaasp/main -v 4 -rpm -diagn
cp -r /usr/share/caasp/terraform/vmware/* other-files/