#!/bin/sh
cp -r some-files/* /usr/share/caasp/terraform/vmware/

eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -rpm -createcaasp -action init
sleep 5
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -rpm -createcaasp -action refresh
sleep 5
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
sleep 1
/root/go/src/mkcaasp/main -v 4 -rpm -bootstrap
cp -r /usr/share/caasp/terraform/vmware/* other-files/
cp -r /root/go/src/mkcaasp/tests/ginkgoscenarios/scenario1/imba-cluster other-files/
