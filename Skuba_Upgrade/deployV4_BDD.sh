#!/bin/sh
export MKCAASPROOT=/root/go/src/mkcaasp
eval $(ssh-agent)
ssh-add -k /root/go/src/mkcaasp/skuba_TF_stuff/id_shared
/root/go/src/mkcaasp/main -v 4 -createcaasp -action init -vmware
/root/go/src/mkcaasp/main -v 4 -createcaasp -action apply -nodes w2m3 -vmware


cp /root/go/src/mkcaasp/mkcaaspcfg.json some-files/
cp -r /usr/share/caasp/terraform/vmware/* some-files/
cat /usr/share/caasp/terraform/vmware/terraform.tfstate
echo "---end---"