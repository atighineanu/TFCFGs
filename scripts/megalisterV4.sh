#!/bin/sh
cp -r some-files/* /usr/share/caasp/terraform/vmware/

eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -createcaasp -action apply -nodes w1m3 -rpm -bootstrap
cp -r /usr/share/caasp/terraform/vmware/* other-files/