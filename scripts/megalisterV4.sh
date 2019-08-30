#!/bin/sh
cp -r some-files/* /usr/share/caasp/terraform/vmware/
cp -r some-files/imba-cluster /root/go/src/mkcaasp/tests/ginkgoscenarios/scenario1/

eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -createcaasp -rpm -action init
/root/go/src/mkcaasp/main -v 4 -createcaasp -action refresh -nodes w1m3 -rpm -bootstrap
cp -r /usr/share/caasp/terraform/vmware/* other-files/
cp -r /root/go/src/mkcaasp/tests/ginkgoscenarios/scenario1/imba-cluster other-files/