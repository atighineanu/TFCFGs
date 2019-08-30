#!/bin/sh
cp -r other-files/* /usr/share/caasp/terraform/vmware/
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
zypper up --auto-agree-with-licenses --no-confirm skuba
cp -r /usr/share/caasp/terraform/vmware/* some-files/